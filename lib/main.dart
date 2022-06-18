import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:registration_form/provider/google_sign_in.dart';
import 'package:registration_form/screen/homepage.dart';
import 'package:registration_form/screen/welcome.dart';

import 'screen/login.dart';

void main() async {
WidgetsFlutterBinding.ensureInitialized();
await Firebase.initializeApp();
// await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  
  @override
  Widget build(BuildContext context) =>
    ChangeNotifierProvider(create: (context) => GoogleSignInProvider(),
    child: MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
          primarySwatch: Colors.blue,
      ),
      //home: HomePage(),
       home: FirebaseAuth.instance.currentUser != null ? Welcome() : Login(),
     ),
    );
  
  
}
