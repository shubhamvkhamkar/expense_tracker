
import 'package:expense_tracker/view/screens/admin_page.dart';
import 'package:expense_tracker/view/screens/feedback_page.dart';
import 'package:expense_tracker/view/screens/resgistraion_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class LoginPage extends StatefulWidget{
  const LoginPage({super.key});

 

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {

    final FirebaseAuth _auth = FirebaseAuth.instance;
  TextEditingController usernameController = TextEditingController();
  TextEditingController passwordContoller = TextEditingController();
  
  Future<void> login() async {
    UserCredential userCredential;
    try{
    userCredential = await _auth.signInWithEmailAndPassword(
      email: usernameController.text.trim(), 
      password: passwordContoller.text.trim());
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Login succuesfully')));
      Navigator.pushReplacement(context, MaterialPageRoute(
        builder: (context) => FeedbackPage(),));
        
  }catch(e){
  ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Failed Login $e')));
  }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Login Page'),
      ),
      body: SingleChildScrollView(
        child: Column(
          
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
           Padding(
             padding: const EdgeInsets.all(8.0),
             child: Text('Login Page',style: TextStyle(fontSize: 22,fontWeight: FontWeight.bold),),
           ),
           SizedBox(height: 16,),
           Padding(
             padding: const EdgeInsets.only(left: 10),
             child: Text('Email:',style: TextStyle(fontSize: 18,fontWeight: FontWeight.w600),),
           ),
           Padding(
             padding: const EdgeInsets.all(8.0),
             child: TextField(
              controller: usernameController,
              decoration: InputDecoration(
                hintText: 'Enter your Email',
                border: OutlineInputBorder()
              ),
              
             
             ),
           ),
           Padding(
             padding: const EdgeInsets.only(left: 10),
             child: Text('Password:',style: TextStyle(fontSize: 18,fontWeight: FontWeight.w600)),
           ),
           Padding(
             padding: const EdgeInsets.all(8.0),
             child: TextField(
              controller: passwordContoller,
              decoration: InputDecoration(
                hintText: 'Enter your password here',
                border: OutlineInputBorder()
              ),
             ),
           ),
           Center(
              widthFactor: MediaQuery.of(context).size.width,
             child: Padding(
               padding: const EdgeInsets.all(8.0),
               child: ElevatedButton(
                style: ButtonStyle(backgroundColor: WidgetStatePropertyAll(Colors.green),fixedSize: WidgetStatePropertyAll(Size(700, 16))),
                onPressed: login, 
                child: Text('Login',style: TextStyle(fontSize: 18,fontWeight: FontWeight.bold,color: Colors.white),),
                
               ),
             ),
           ),
           Center(child: TextButton(onPressed: (){
            Navigator.push(context, MaterialPageRoute(builder: (context) => ResgistraionPage(),));
           }, child: Text('New user? Register Here',)),
           
           ),
           Center(
             child: TextButton(onPressed: (){
              Navigator.push(context, MaterialPageRoute(builder: (context) => AdminDashboard(),));
             }, child: Text('Admin Only',style: TextStyle(color: Colors.red),)),
           )
        
          ],
        ),
      ),
    );
  }
}
