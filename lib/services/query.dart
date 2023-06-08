// import 'package:flutter/material.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebase_auth/firebase_auth.dart';


// var uid;
// var name = "name";
// var email = "email";
// var phone = "phone";
// var blood = "blood";



// Map<String, dynamic>? currentUser;

// class UserInformation extends StatefulWidget {
//   const UserInformation({Key? key}) : super(key: key);

//   @override
//   State<UserInformation> createState() => _UserInformationState();
// }

// class _UserInformationState extends State<UserInformation> {
//   var db = FirebaseFirestore.instance;
//   final FirebaseAuth auth = FirebaseAuth.instance;


//   @override
//   void initState() {
//     getCurrentUser();
//     fetch();
//      super.initState();
    
//   }

//   void getCurrentUser() {
//     final User? user = auth.currentUser;
//     final id = user?.uid;
//     final displayName = user?.displayName;
//     final mail = user?.email;

//     setState(() {
//       uid = id;
//       name = displayName as String;
//       email = mail as String;
//     });
//   }

//   void fetch() {
//     final docRef = db.collection("users").doc(uid);
//     docRef.snapshots().listen(
//           (event) => setState(() {
//             currentUser = event.data();
//             Map<String, dynamic> data = Map<String, dynamic>();

//             for (dynamic type in currentUser!.keys) {
//               data[type.toString()] = currentUser![type];
//             }
//             setState(() {
//               phone = (data['phone']);
//               blood = (data['blood']);
//             });
//           }),
//           onError: (error) => print("Listen failed: $error"),
//         );
//   }
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(),
//       body: Text("$currentUser"),
//       // body: Text('${event.data}'
//     );
//   }
// }
