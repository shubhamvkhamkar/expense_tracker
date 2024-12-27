import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class AdminDashboard extends StatelessWidget {
  final _firestore = FirebaseFirestore.instance;

  AdminDashboard({super.key});

  
  Future<void> _deleteFeedback(String docId) async {
    await _firestore.collection('feedback').doc(docId).delete();
    
  }

  
  void _editFeedback(BuildContext context, String docId, String currentContent) {
    final _editController = TextEditingController(text: currentContent);

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Edit Feedback'),
          content: TextField(
            controller: _editController,
            decoration: InputDecoration(labelText: 'Updated Feedback'),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: Text('Cancel'),
            ),
            TextButton(
              onPressed: () async {
                await _firestore.collection('feedback').doc(docId).update({
                  'feedback': _editController.text.trim(),
                  'updatedTimestamp': FieldValue.serverTimestamp(),
                });
                
                Navigator.pop(context);
              },
              child: Text('Save'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Admin Dashboard'),
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: _firestore
        .collection('feedback')
        .orderBy('timestamp', descending: true)
        .snapshots(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return Center(child: CircularProgressIndicator());
          }

          final feedbackDocs = snapshot.data!.docs;

          return ListView.builder(
            itemCount: feedbackDocs.length,
            itemBuilder: (context, index) {
              final doc = feedbackDocs[index];
              final content = doc['feedback'];
              final userId = doc['userId'];
              final timestamp = doc['timestamp']?.toDate() ?? DateTime.now();

              return SingleChildScrollView(
                child: Card(
                  margin: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                  child: ListTile(
                    title: Text(content),
                    subtitle: Text('User: $userId\nDate: $timestamp'),
                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        IconButton(
                          icon: Icon(Icons.edit, color: Colors.blue),
                          onPressed: () => _editFeedback(context, doc.id, content),
                        ),
                        IconButton(
                          icon: Icon(Icons.delete, color: Colors.red),
                          onPressed: () => _deleteFeedback(doc.id),
                        ),
                      ],
                    ),
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}