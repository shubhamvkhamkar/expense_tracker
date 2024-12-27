
import 'package:expense_tracker/view/screens/login_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class ResgistraionPage extends StatefulWidget{
  const ResgistraionPage({super.key});

  @override
  State<ResgistraionPage> createState() => _ResgistraionPageState();
}

class _ResgistraionPageState extends State<ResgistraionPage> {

  final FirebaseAuth _auth = FirebaseAuth.instance;
  TextEditingController usernameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController fullNameController = TextEditingController();
   bool isSignUp = false;


  Future<void> authenticate() async {
    
    try{
    UserCredential userCredential;
    
    userCredential = await _auth.createUserWithEmailAndPassword(
      email: emailController.text.trim() , 
      password: passwordController.text.trim()
      );
     await userCredential.user!.updateDisplayName(usernameController.text.trim());
  
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Register succuesfully ! Plsease Login')));
     Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) => LoginPage()));
    }catch(e){
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(e.toString())));
    }
  }
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Registration'),

      ),
      body: SingleChildScrollView(
        child: Column(
          
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
           Padding(
             padding: const EdgeInsets.all(8.0),
             child: Text('Registraton',style: TextStyle(fontSize: 22,fontWeight: FontWeight.bold),),
           ),
           SizedBox(height: 16,),
           Padding(
             padding: const EdgeInsets.only(left: 10),
             child: Text('Username :',style: TextStyle(fontSize: 18,fontWeight: FontWeight.w600),),
           ),
           Padding(
             padding: const EdgeInsets.all(8.0),
             child: TextField(
              controller: usernameController,
              decoration: InputDecoration(
                hintText: 'Enter your Username',
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
              controller: passwordController,
              decoration: InputDecoration(
                hintText: 'Enter your password here',
                border: OutlineInputBorder()
              ),
             ),
           ),
        
           Padding(
             padding: const EdgeInsets.only(left: 10),
             child: Text('Email:',style: TextStyle(fontSize: 18,fontWeight: FontWeight.w600)),
           ),
           Padding(
             padding: const EdgeInsets.all(8.0),
             child: TextField(
              controller: emailController,
              decoration: InputDecoration(
                hintText: 'Enter your Email here',
                border: OutlineInputBorder()
              ),
             ),
           ),
           Padding(
             padding: const EdgeInsets.only(left: 10),
             child: Text('Full Name:',style: TextStyle(fontSize: 18,fontWeight: FontWeight.w600)),
           ),
           Padding(
             padding: const EdgeInsets.all(8.0),
             child: TextField(
              controller: fullNameController,
              decoration: InputDecoration(
                hintText: 'Enter your Full Name here',
                border: OutlineInputBorder()
              ),
             ),
           ),
           Center(
             child: Padding(
               padding: const EdgeInsets.all(8.0),
               child: ElevatedButton(
                style: ButtonStyle(backgroundColor: WidgetStatePropertyAll(Colors.blue),fixedSize: WidgetStatePropertyAll(Size(700, 16))),
                onPressed: authenticate,
                child: Text('Register',style: TextStyle(fontSize: 18,fontWeight: FontWeight.bold,color: Colors.white),),
                
               ),
             ),
           ),
          Center(
            child: TextButton(onPressed: (){
              Navigator.push(context, MaterialPageRoute(builder: (context) => LoginPage(),));
            }, child: Text('Already have an account? Login Here')),
          )
        
          ],
        ),
      ),
    );
  }
}

