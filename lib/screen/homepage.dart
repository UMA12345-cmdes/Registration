// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/material.dart';
// import 'package:registration_form/screen/login.dart';
// import 'package:registration_form/screen/registration.dart';

// class HomePage extends StatefulWidget {
//   HomePage({Key? key}) : super(key: key);

//   @override
//   State<HomePage> createState() => _HomePageState();
// }

// class _HomePageState extends State<HomePage> {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('home'),
//       ),
//       body: StreamBuilder(
//         stream: FirebaseAuth.instance.authStateChanges(),
//         builder: (context, snapshot) {
//           if(snapshot.connectionState == ConnectionState.waiting){
//           return const Center(
//             child: CircularProgressIndicator(),
//           );
//           }
//           else if(snapshot.hasData){
           
//             return Login();
//           }
//           else if(snapshot.hasError){
//             return Center(
//               child: Text('something went wrong'),
//             );
//           }
//         else{
//           return   Registration();
//         }
//         }
          
//       ),
//     );
//   }
// }