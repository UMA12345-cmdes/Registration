import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:registration_form/screen/login.dart';

import '../provider/google_sign_in.dart';

class Welcome extends StatefulWidget {

  @override
  State<Welcome> createState() => _WelcomeState();
}

class _WelcomeState extends State<Welcome> {
 void logOut() async {
    await FirebaseAuth.instance.signOut();
    Navigator.popUntil(context, (route) => route.isFirst);
    Navigator.push(context, CupertinoPageRoute(
          builder: (context) => Login()
        ));
  }

 // final user = FirebaseAuth.instance.currentUser!;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Welcome to your App'),
          
          actions: [
           IconButton(onPressed: (){ 
            logOut();
           }, icon: Icon(Icons.exit_to_app))
          ],

          // TextButton(onPressed: (){
          //   final provider = 
          //   Provider.of<GoogleSignInProvider>(context, 
          //   listen: false);
          //   provider.logout();
          // },
          //  child: const Text('logout'),),
        
      ),
      body: SafeArea(child: Container(
        alignment: Alignment.center,
      child: Padding(
        padding: const EdgeInsets.all(18.0),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [

              Text('welcome to your page', style: TextStyle(fontSize: 14),),

              SizedBox(height: 20,),
               Text('you are successfully Login', style: TextStyle(
                fontSize: 20),),
            
//          Container(
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

            ],
          ),
        ),
      ),

      )),
    );
  }
}