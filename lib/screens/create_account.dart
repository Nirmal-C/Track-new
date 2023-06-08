// ignore_for_file: prefer_const_constructors

import 'package:track/services/method.dart';
import 'package:flutter/material.dart';
import 'package:track/widgets/field_widget.dart';
import 'package:track/widgets/description_widget.dart';
import 'package:track/screens/home_screen.dart';
import 'package:track/screens/medical.dart';

  final TextEditingController name = TextEditingController();
  final TextEditingController email = TextEditingController();
  final TextEditingController password = TextEditingController();
    final TextEditingController phone = TextEditingController();
    final TextEditingController emergency1 = TextEditingController();
  final TextEditingController emergency2 = TextEditingController();
  final TextEditingController emergency3 = TextEditingController();

  

class CreateAccount extends StatefulWidget {
  @override
  _CreateAccountState createState() => _CreateAccountState();
}

class _CreateAccountState extends State<CreateAccount> {


  
  //final TextEditingController _blood = TextEditingController();

  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      body: SingleChildScrollView(
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
                    // ignore: prefer_const_constructors
                    child: Text(
                      "Welcome",
                      style: TextStyle(
                        fontSize: 34,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  Container(
                    width: size.width / 1.1,
                    child: Text(
                      "Create Account to Continue!",
                      style: TextStyle(
                        color: Colors.grey[700],
                        fontSize: 20,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                  SizedBox(
                    height: size.height / 20,
                  ),
                  Center(
                child: CircleAvatar(
                  backgroundImage: AssetImage("assets/images/user.png"),
                  radius: 60.0,
                 
                ),
              ),
              SizedBox(
                    height: size.height / 30,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 18.0),
                    child: Container(
                      width: size.width,
                      alignment: Alignment.center,
                      child: field(TextInputType.name, size, "Name", Icons.account_box, name),
                    ),
                  ),
                  Container(
                    width: size.width,
                    alignment: Alignment.center,
                    child: field(TextInputType.emailAddress, size, "Email", Icons.email, email),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 18.0),
                    child: Container(
                      width: size.width,
                      alignment: Alignment.center,
                      child: field(TextInputType.visiblePassword, size, "Password", Icons.lock, password),
                    ),
                  ),
                   Container(
                    width: size.width,
                    alignment: Alignment.center,
                    child: field(TextInputType.phone, size, "Phone", Icons.phone, phone),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 18.0),
                    child: Container(
                      width: size.width,
                      alignment: Alignment.center,
                      child: field(TextInputType.phone, size, "Emergency Contact 1", Icons.phone, emergency1),
                    ),
                  ),
                   Container(
                    width: size.width,
                    alignment: Alignment.center,
                    child: field(TextInputType.phone, size, "Emergency Contact 2", Icons.phone, emergency2),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 18.0),
                    child: Container(
                      width: size.width,
                      alignment: Alignment.center,
                      child: field(TextInputType.phone, size, "Emergency Contact 3", Icons.phone, emergency3),
                    ),
                  ),
            
                  SizedBox(
                    height: size.height / 70,
                  ),
                  customButton(size),
                  SizedBox(
                    height: size.height / 50,
                  ),
                ],
              ),
            ),
    );
  }

  Widget customButton(Size size) {
    return GestureDetector(
      onTap: () {
        if (name.text.isNotEmpty &&
            email.text.isNotEmpty &&
            password.text.isNotEmpty &&
            phone.text.isNotEmpty && 
             //_blood.text.isNotEmpty &&
             emergency1.text.isNotEmpty)
              {
          setState(() {
            isLoading = true;
          });
          Navigator.push(
                  context, MaterialPageRoute(builder: (_) => Medical()));

          
        } else {
          print("Please enter Fields");
        }
      },
      child: Container(
          height: size.height / 14,
          width: size.width / 1.1,  
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(50),
            color: Colors.black,
          ),
          alignment: Alignment.center,
          child: Text(
            "Next",
            style: TextStyle(
              color: Colors.white,
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          )),
    );
  }
}

