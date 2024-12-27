import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:expense_tracker/view/screens/login_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class FeedbackPage extends StatefulWidget{
  const FeedbackPage({super.key});

  @override
  State<FeedbackPage> createState() => _FeedbackPageState();
}

class _FeedbackPageState extends State<FeedbackPage> {
final FirebaseFirestore firestore =FirebaseFirestore.instance;
  final FirebaseAuth auth = FirebaseAuth.instance;
  bool isEdit = false;
  final userId = FirebaseAuth.instance.currentUser!.uid;
  TextEditingController feedbackcontroller = TextEditingController();
  String? currentDocId;

  Future<void> addFeedback() async {
    try{
    await firestore.collection('feedback')
    .add({
      'userId' : userId,
      'feedback' : feedbackcontroller.text.toString(),
      'timestamp' : FieldValue.serverTimestamp(),
    });

    ScaffoldMessenger.of(context).
    showSnackBar(SnackBar(content: 
    Text('Thank you for Your Feedback')));
    feedbackcontroller.clear();
  }catch(e){
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: 
    Text('Error: $e')));
  }
  }
  
  Future<void> updateFeedback() async {
    if(currentDocId != null){
      try{
      await firestore.collection('feedback').doc(currentDocId).update({
      'feedback' : feedbackcontroller.text.trim(),
      'updateTime' : FieldValue.serverTimestamp()
      });
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Feedback Updated')));
      setState(() {
        isEdit = false;
        feedbackcontroller.clear();
      });
    }catch(e){
     ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: 
    Text('Error: $e')));
    }
  }else{
    ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('No feedback found to update.')),
      );
  }
  }
  
  Future<void> fetchFeedback() async {
    try{
    final QuerySnapshot feedbackSnapshot = await firestore
    .collection('feedback')
    .where('userId',isEqualTo: userId)
    .orderBy('timestamp',descending: true)
    .limit(1)
    .get();

    if(feedbackSnapshot.docs.isNotEmpty){
      final doc = feedbackSnapshot.docs.first;
      
      setState(() {
        feedbackcontroller.text = doc['feedback'];
        currentDocId = doc.id;
        isEdit =true;
      });
    } else {
      ScaffoldMessenger.of(context).
      showSnackBar(SnackBar(content: Text('No feedback found to edit')));
    }
  }
  catch(e){
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(content: Text('Error fetching feedback $e'))
  );
  }
  }

 

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Feedback page'),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          spacing: 10,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                TextButton(onPressed: (){
                  setState(() {
                    isEdit =false;
                    feedbackcontroller.clear();
                  });
                }, child: Text('Add Feedback',
                style: TextStyle(
                  color: Colors.green,
                  fontSize: 18,
                  fontWeight: FontWeight.bold))),
                TextButton(
                  onPressed: fetchFeedback, 
                  child: Text('Edit feedback',
                  style: TextStyle(color: Colors.green,fontSize: 18,fontWeight: FontWeight.bold)))
              ],
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(isEdit ? 'Edit Your Feedback' : 'Add Your Feedback',
              style: TextStyle(fontWeight: FontWeight.bold,fontSize: 18),),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextField(
                controller: feedbackcontroller,
                maxLines: 5,
                decoration: InputDecoration(
                  
                  hintText:  'Write your feedback here .........',
                  hintStyle: TextStyle(fontWeight: FontWeight.bold),
                  border: OutlineInputBorder()
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: ElevatedButton
              (style: ButtonStyle(
                backgroundColor: WidgetStatePropertyAll(Colors.green),fixedSize: WidgetStatePropertyAll(Size(700, 16))
              ),
                onPressed: isEdit ? updateFeedback : addFeedback, 
              child: Text(isEdit ? 'Update' :'Submit',style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold,fontSize: 21),)),
            ),
            TextButton(onPressed: (){
              FirebaseAuth.instance.signOut();
              Navigator.pushReplacement(context, 
              MaterialPageRoute(builder: (_) => LoginPage(),));
            }, child: Text('Logout',style: TextStyle(color: Colors.red),))
        
            
          ],
        ),
      ),
    );
  }
}