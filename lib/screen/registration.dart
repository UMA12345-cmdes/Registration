import 'dart:async';
import 'dart:developer';
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import '../provider/google_sign_in.dart';
import 'package:uuid/uuid.dart';

class Registration extends StatefulWidget {
  const Registration({Key? key}) : super(key: key);

  @override
  State<Registration> createState() => _RegistrationState();
}

class _RegistrationState extends State<Registration> {
  // var uuid = Uuid;
TextEditingController namecontroller = TextEditingController();
TextEditingController emailcontroller = TextEditingController();
TextEditingController passwordcontroller = TextEditingController();
TextEditingController addresscontroller = TextEditingController();
TextEditingController agecontroller  =  TextEditingController();
File? profile;

void createAccount() async {
  String name=namecontroller.text.trim();
    String email = emailcontroller.text.trim();
    String password = passwordcontroller.text.trim();
    String address = addresscontroller.text.trim();
    String ageString = agecontroller.text.trim();

    int age = int.parse(ageString);

    namecontroller.clear();
    emailcontroller.clear();
    passwordcontroller.clear();
    addresscontroller.clear();
    agecontroller.clear();
    

    if(name !="" || email != "" || password != "" || address != "" || profile !=null) {


 try
      {
        UserCredential userCredential = 
        await FirebaseAuth.instance.createUserWithEmailAndPassword(
          email: email, password: password);
        if(userCredential.user != null) {
          Navigator.pop(context);
        }
      } on FirebaseAuthException catch(ex) {
        log(ex.code.toString());
      }

 UploadTask uploadTask = FirebaseStorage.instance.ref().child("profile").child(
        Uuid().v1()).putFile(profile!);

        StreamSubscription taskSubscription = uploadTask.snapshotEvents.listen((snapshot) {
         double percentage = snapshot.bytesTransferred/snapshot.totalBytes * 100;
         log(percentage.toString());
         });

         TaskSnapshot taskSnapshot = await uploadTask;
          String downloadurl = await taskSnapshot.ref.getDownloadURL();

          taskSubscription.cancel();

      Map<String, dynamic> userData = {
       "name":name,
       "email":email,
       "password":password,
       "address":address,
       "age":age,
       "profile": downloadurl,
 };
      FirebaseFirestore.instance.collection("users").add(userData);
      log('user created');
    }
  
    else {
      print('please fill form');
    }
    setState(() {
      profile = null;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      
body: SafeArea(
  child: SingleChildScrollView(
    child: Center(
    child: Padding(
      padding: const EdgeInsets.all(18.0),
      child: Column(
        children: [
        MaterialButton(
  onPressed: () async{
        XFile? selectedImage = await ImagePicker().pickImage(
          source: ImageSource.gallery);

if(selectedImage != null){
          File convertedFile = File(selectedImage.path);
          setState(() {
            profile = convertedFile;
          });
          log('image selected');
        }
        else if(selectedImage == null){
          print('no selected image');
        }
  },
   padding: EdgeInsets.zero,
  child:   CircleAvatar(
  backgroundImage: (profile != null) ? FileImage(profile!) : null,
    backgroundColor: Colors.grey,
  
    radius: 50,
  
    child: Container(
  
    )
  
  
  
  ),
),

          TextField(
            controller: namecontroller,
            keyboardType: TextInputType.name,
            decoration: InputDecoration(
              hintText: 'Enter your Name'
            ),
          ),
          SizedBox(height: 30,),
           TextField(
            controller: emailcontroller,
            keyboardType: TextInputType.emailAddress,
            decoration: InputDecoration(
              hintText: 'Enter your Email'
            ),
          ),
          SizedBox(height: 30,),
           TextField(
            controller: passwordcontroller,
            obscureText: true,
            decoration: InputDecoration(
              hintText: 'Enter your password'
            ),
          ),
          SizedBox(height: 10,),
           TextField(
            controller: addresscontroller,
            decoration: InputDecoration(
              hintText: 'Enter your Address',
            ),
            maxLines: 3,
            maxLength: 50,
          ),
           SizedBox(height: 10,),
           TextField(
            controller: agecontroller,
            decoration: InputDecoration(
              hintText: 'Enter your Age',
            ),
          
          ),
          SizedBox(height: 40,),
  
          SizedBox(
            height: 40,
            width: double.infinity,
            child: MaterialButton(
              color: Colors.blue,
              onPressed: (){
                createAccount();
              },
            child: Text('Registration', style: TextStyle(color: Colors.white),),
            ),
          ),
  
  SizedBox(height: 20,),
  
          // Spacer(),
          SizedBox(
            height: 40,
            width: double.infinity,
            child: ElevatedButton.icon(
              onPressed: () {
              final provider = Provider.of<GoogleSignInProvider>(context, 
              listen: false);
              provider.googleLogin();
            },
             icon: FaIcon(FontAwesomeIcons.google, color: Colors.red ), 
            label: const Text('SignUp with google',style: TextStyle(fontSize: 15)),
            ),
          ),
        ],
      ),
    ),
  ),
  )),
    );
  }
}