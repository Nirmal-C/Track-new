import 'package:track/screens/login_screen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:track/screens/side_bar.dart';


Future<User?> createAccount(
    String name, String email, String password, phone, String blood, String em1, String em2, String em3, String bp, String sugar, String alg, String surg, String genetics ) async {
  FirebaseAuth _auth = FirebaseAuth.instance;

  FirebaseFirestore _firestore = FirebaseFirestore.instance;

  try {
    UserCredential userCrendetial = await _auth.createUserWithEmailAndPassword(
        email: email, password: password);

    print("Account created Succesfull");

    userCrendetial.user!.updateDisplayName(name);
    // userCrendetial.user!.updatePhoneNumber(phone);

    await _firestore.collection('users').doc(_auth.currentUser!.uid).set({
      "name": name,
      "email": email,
      "phone": phone,
      "emergency_number1" : em1 ,
      "emergency_number2" : em2,
      "emergency_number3" : em3,
      "blood_group": blood,
      "blood_pressure": bp,
      "diabetes" : sugar,
      "allegies" : alg ,
      "past_surgeries" :surg ,
      "genetic_disorders" : genetics ,
 


      
      "uid": _auth.currentUser!.uid,
    });

    return userCrendetial.user;
  } catch (e) {
    print(e);
    return null;
  }
}

Future<User?> logIn(String email, String password) async {
  FirebaseAuth _auth = FirebaseAuth.instance;
  FirebaseFirestore _firestore = FirebaseFirestore.instance;

  try {
    UserCredential userCredential = await _auth.signInWithEmailAndPassword(
        email: email, password: password);

    print("Login Sucessfull");
    _firestore
        .collection('users')
        .doc(_auth.currentUser!.uid)
        .get()
        .then((value) => userCredential.user!.updateDisplayName(value['name']));

    return userCredential.user;
  } catch (e) {
    print(e);
    return null;
  }
}

Future logOut(BuildContext context) async {
  FirebaseAuth _auth = FirebaseAuth.instance;

  try {
    await _auth.signOut().then((value) {
      Navigator.push(context, MaterialPageRoute(builder: (_) => LoginScreen()));
    });
  } catch (e) {
    print("error");
  }
}

// Future reset(BuildContext context) async {
//   FirebaseAuth _auth = FirebaseAuth.instance;

//   _auth.sendPasswordResetEmail(email: email);
// }
