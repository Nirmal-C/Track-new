// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:track/screens/login_screen.dart';
import 'package:track/screens/side_bar.dart';
import 'package:track/widgets/field_widget.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'package:track/screens/create_account.dart';
import 'package:track/screens/home_screen.dart';

class ResetScreen extends StatefulWidget {
  @override
  _ResetScreenState createState() => _ResetScreenState();
}

class _ResetScreenState extends State<ResetScreen> {
  final _email = TextEditingController();
  // final TextEditingController _password = TextEditingController();
  bool isLoading = false;
  final auth = FirebaseAuth.instance;

  @override
  void dispose() {
    _email.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      body: isLoading
          ? Center(
              child: Container(
                height: size.height / 20,
                width: size.height / 20,
                child: CircularProgressIndicator(),
              ),
            )
          : SingleChildScrollView(
              child: Column(
                children: [
                  SizedBox(
                    height: size.height / 20,
                  ),
                  Container(
                    alignment: Alignment.centerLeft,
                    width: size.width / 0.5,
                    /*child: IconButton(
                        icon: Icon(Icons.arrow_back_ios), onPressed: () {}),*/
                  ),
                  SizedBox(
                    height: size.height / 50,
                  ),
                  Container(
                    width: size.width / 1.1,
                    child: Text(
                      "Password",
                      style: TextStyle(
                        fontSize: 34,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                     SizedBox(
                    height: size.height / 90,
                  ),
                  Container(
                    width: size.width / 1.1,
                    child: Text(
                      "Click To Send Reset Link!",
                      style: TextStyle(
                        color: Colors.grey[700],
                        fontSize: 20,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                  SizedBox(
                    height: size.height / 10,
                  ),
                  Container(
                    width: size.width,
                    alignment: Alignment.center,
                    child: field(
              TextInputType.emailAddress, size, "email", Icons.email, _email),
                  ),
                  // Padding(
                  //   padding: const EdgeInsets.symmetric(vertical: 18.0),
                  //   child: Container(
                  //     width: size.width,
                  //     alignment: Alignment.center,
                  //     child: field(size, "password", Icons.lock, _password),
                  //   ),
                  // ),
                  SizedBox(
                    height: size.height / 10,
                  ),
                 // customButton(size),
                  GestureDetector(
      onTap: () {
        auth.sendPasswordResetEmail(email: _email.text);
        Navigator.push(
            context, MaterialPageRoute(builder: (_) => LoginScreen()));
        if (_email.text.isNotEmpty) {
          setState(() {
            isLoading = true;
          });
        }
      },
      child: Container(
          height: size.height / 14,
          width: size.width / 1.2,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(50),
            color: Colors.black,
          ),
          alignment: Alignment.center,
          child: Text(
            "Reset",
            style: TextStyle(
              color: Colors.white,
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          )),
    ),
                  SizedBox(
                    height: size.height / 40,
                  ),
                  // GestureDetector(
                  //   onTap: () => Navigator.of(context).push(
                  //       MaterialPageRoute(builder: (_) => CreateAccount())),
                  //   child: Text(
                  //     "Create Account",
                  //     style: TextStyle(
                  //       color: Colors.blue,
                  //       fontSize: 16,
                  //       fontWeight: FontWeight.w500,
                  //     ),
                  //   ),
                  // )
                ],
              ),
            ),
    );
  }

//   Widget customButton(Size size) {
//     return 
//   }
}