import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:registration_form/provider/google_sign_in.dart';
import 'package:registration_form/screen/registration.dart';
import 'package:registration_form/screen/welcome.dart';

class Login extends StatefulWidget {
  Login({Key? key}) : super(key: key);

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {


TextEditingController emailcontroller = TextEditingController();
TextEditingController passwordcontroller = TextEditingController();


 void login() async {
    String email = emailcontroller.text.trim();
    String password = passwordcontroller.text.trim();

    if(email == "" || password == "") {
      log("Please fill all the fields!");
    }
    else {

      try {
        UserCredential userCredential = await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: email, 
          password: password);
        if(userCredential.user != null) {

          Navigator.popUntil(context, (route) => route.isFirst);
          Navigator.pushReplacement(context, MaterialPageRoute(
            builder: (context) => Welcome()
          ));
          
        }
      } on FirebaseAuthException catch(ex) {
        log(ex.code.toString());
      }
    }
  }



  @override
  Widget build(BuildContext context) {
    // final user = FirebaseAuth.instance.currentUser!;
    return Scaffold(
      appBar: AppBar(
        title: Text('Login'),
        centerTitle: true,
        
      ),
      body:  SafeArea(
          child: ListView(
            children: [
               Padding(
              padding: EdgeInsets.all(15),
              child: Column(
                children: [
             TextField(
                    controller: emailcontroller,
                    decoration: InputDecoration(
                      labelText: "Email Address"
                    ),
                  ),

                  SizedBox(height: 10,),

                  TextField(
                    obscureText: true,
                    controller: passwordcontroller,
                    decoration: InputDecoration(
                      labelText: "Password"
                    ),
                  ),


                
                  SizedBox(height: 20,),

                Row(
                  children: [
                     CupertinoButton(
                    onPressed: () {
                      login();
                    },
                    color: Colors.blue,
                    child: Text("Log In"),
                  ),


                  CupertinoButton(
                    alignment: Alignment.topRight,
                    onPressed: () {
                      Navigator.push(context, CupertinoPageRoute(
                        builder: (context) => Registration()
                      ));
                    },
                    child: Text("Create an Account"),
                  ),
                  ],
                ),

                  SizedBox(height: 20,),
  
          // Spacer(),
          SizedBox(
            height: 60,
            width: double.infinity,
            child: ElevatedButton.icon(
              onPressed: () {
              final provider = Provider.of<GoogleSignInProvider>(context, 
              listen: false);
              provider.googleLogin();
            },
             icon: FaIcon(FontAwesomeIcons.google, color: Colors.red ), 
            label: const Text('SignIn with google',style: TextStyle(fontSize: 18)),
            ),
          ),

                ],
          ),
        
        ),
            ]
      ),
      ),
  
      
      
      
      
//       Container(
//         alignment: Alignment.center,
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             Text('profile'),

//             SizedBox(height: 32,),
//             CircleAvatar(
//               radius: 40,
//               backgroundImage: NetworkImage(user.photoURL!),
//             ),
//             SizedBox(height: 8,),
// Text('Name: '+user.displayName!,
// style: TextStyle(color: Colors.white, fontSize: 16),
// ),

// SizedBox(height: 8,),
// Text('Name: '+user.displayName!,
// style: TextStyle(color: Colors.white, fontSize: 16),
// ),
//             SizedBox(height: 8,),
//           ],
//         ),
//       ),



    );
  }
}