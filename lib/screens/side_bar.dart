// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables
import 'package:track/screens/history.dart';
import 'package:track/screens/home_screen.dart';
import 'package:track/screens/update_info.dart';
import 'package:track/services/method.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:track/screens/change_password.dart';
import 'package:track/screens/Add_contact.dart';

var uid;
var name = "name";
var email = "email";
var phone = "phone";
var bloodg = "blood";
var allg;
var bloodpre;
var diab;
var emerg1;
var emerg2;
var emerg3;
var gen;
var surger;

Map<String, dynamic>? currentUser;

class MyNavigationDrawer extends StatefulWidget {
  const MyNavigationDrawer({Key? key}) : super(key: key);
  @override
  State<MyNavigationDrawer> createState() => _MyNavigationDrawerState();
}

class _MyNavigationDrawerState extends State<MyNavigationDrawer> {
  @override
  void initState() {
    getCurrentUser();
    fetch();
    initiate();
    super.initState();
  }

  void initiate() async {
    await FirebaseFirestore.instance.disableNetwork();
    await FirebaseFirestore.instance.enableNetwork();
  }

  final FirebaseAuth auth = FirebaseAuth.instance;

  var db = FirebaseFirestore.instance;

  void getCurrentUser() {
    final User? user = auth.currentUser;
    final id = user?.uid;
    final displayName = user?.displayName;
    final mail = user?.email;

    setState(() {
      uid = id;
      name = displayName as String;
      email = mail as String;
    });
  }

  void fetch() {
    final docRef = db.collection("users").doc(uid);
    docRef.snapshots().listen(
          (event) => setState(() {
            currentUser = event.data();
            Map<String, dynamic> data = Map<String, dynamic>();

            for (dynamic type in currentUser!.keys) {
              data[type.toString()] = currentUser![type];
            }
            setState(() {
              phone = (data['phone']);
              bloodg = (data['blood_group']);
              bloodpre = (data['blood_pressure']);
              allg = (data['allegies']);
              diab = (data['diabetes']);
              emerg1 = (data['emergency_number1']);
              emerg2 = (data['emergency_number2']);
              emerg3 = (data['emergency_number3']);
              gen = (data['genetic_disorders']);
              surger = (data['past_surgeries']);
            });
          }),
          onError: (error) => print("Listen failed: $error"),
        );
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            buildHeader(context),
            buildMenuItems(context),
          ],
        ),
      ),
    );
  }

  Widget buildHeader(BuildContext context) => Container(
        padding: EdgeInsets.only(
          top: MediaQuery.of(context).padding.top,
        ),
      );

  Widget buildMenuItems(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Column(
      children: <Widget>[
        Container(
          padding: EdgeInsets.fromLTRB(0, 20.0, 0, 40.0),
          color: Colors.white.withOpacity(0.1),
          child: Column(
            children: <Widget>[
              Center(
                child: CircleAvatar(
                  backgroundImage: AssetImage("assets/images/user.png"),
                  radius: 60.0,
                ),
              ),
              SizedBox(height: 10.0),
              Center(
                child: Text(
                  "$name",
                  style: TextStyle(
                    fontSize: 20.0,
                    // color: Colors.white,
                  ),
                ),
              ),
              SizedBox(height: 10.0),
              Center(
                child: Text(
                  "$bloodg",
                  style: TextStyle(
                    fontSize: 25.0,
                    // color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              SizedBox(height: 10.0),
              // ignore: prefer_const_constructors
              Center(
                child: Text(
                  "$email",
                  style: TextStyle(
                    fontSize: 20.0,
                    //  color: Colors.white,
                  ),
                ),
              )
            ],
          ),
        ),
        Column(
            //crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Container(
                  height: size.height / 1.5,
                  decoration:
                      BoxDecoration(color: Colors.black.withOpacity(0.9)),
                  padding: EdgeInsets.fromLTRB(30.0, 50.0, 0, 10.0),
                  child: Column(
                    children: <Widget>[
                      Row(
                        children: <Widget>[
                          Icon(
                            Icons.house,
                            color: Colors.grey,
                            size: 35.0,
                          ),
                          SizedBox(
                            width: 25.0,
                          ),
                          TextButton(
                            child: Text(
                              "Home",
                              style: TextStyle(
                                  fontSize: 20.0, color: Colors.white),
                            ),
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => HomeScreen()),
                              );
                            },
                          )
                        ],
                      ),
                      SizedBox(
                        height: 20.0,
                      ),
                      Row(
                        children: <Widget>[
                          Icon(
                            Icons.history,
                            color: Colors.grey,
                            size: 35.0,
                          ),
                          SizedBox(
                            width: 25.0,
                          ),
                          TextButton(
                            child: Text(
                              "History",
                              style: TextStyle(
                                  fontSize: 20.0, color: Colors.white),
                            ),
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => HistoryPage()),
                              );
                            },
                          )
                        ],
                      ),
                      SizedBox(
                        height: 20.0,
                      ),
                      Row(
                        children: <Widget>[
                          Icon(
                            Icons.wysiwyg,
                            color: Colors.grey,
                            size: 35.0,
                          ),
                          SizedBox(
                            width: 25.0,
                          ),
                          TextButton(
                              child: Text("Update Information",
                                  style: TextStyle(
                                      fontSize: 20.0, color: Colors.white)),
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => UpdateInfoPage()),
                                );
                              }),
                        ],
                      ),
                      SizedBox(
                        height: 20.0,
                      ),
                      Row(
                        children: <Widget>[
                          Icon(
                            Icons.account_box,
                            color: Colors.grey,
                            size: 35.0,
                          ),
                          SizedBox(
                            width: 25.0,
                          ),
                          TextButton(
                            child: Text(
                              "Add Contact",
                              style: TextStyle(
                                  fontSize: 20.0, color: Colors.white),
                            ),
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => Add_contact()),
                              );
                            },
                          )
                        ],
                      ),
                      SizedBox(
                        height: 20.0,
                      ),
                      Row(
                        children: <Widget>[
                          Icon(
                            Icons.lock,
                            color: Colors.grey,
                            size: 35.0,
                          ),
                          SizedBox(
                            width: 25.0,
                          ),
                          TextButton(
                            child: Text(
                              "Change Password",
                              style: TextStyle(
                                  fontSize: 20.0, color: Colors.white),
                            ),
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => Change_Password()),
                              );
                            },
                          )
                        ],
                      ),
                      SizedBox(
                        height: 20.0,
                      ),
                      Row(
                        children: <Widget>[
                          Icon(
                            Icons.login_outlined,
                            color: Colors.grey,
                            size: 35.0,
                          ),
                          SizedBox(
                            width: 30.0,
                          ),
                          TextButton(
                            child: Text(
                              "Log Out",
                              style: TextStyle(
                                  fontSize: 20.0, color: Colors.white),
                            ),
                            onPressed: () => logOut(context),
                          )
                        ],
                      ),
//                   TextButton(onPressed: () {
//   Navigator.push(
//     context,
//     MaterialPageRoute(builder: (context) => UserInformation()),
//   );
// },
//                   child: Text("Fetch"))

                      // TextButton(
                      //   onPressed: () {Navigator.push (
                      //     context,
                      //      MaterialPageRoute(builder: (context)=> ReadExample()),);}
                      //       ,child: Text('Firebase') )
                    ],
                  ))
            ]),
      ],
    );
  }
}
