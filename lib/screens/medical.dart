// ignore_for_file: prefer_const_constructors

import 'package:track/services/method.dart';
import 'package:flutter/material.dart';
import 'package:track/widgets/field_widget.dart';
import 'package:track/widgets/description_widget.dart';
import 'package:track/screens/home_screen.dart';
import 'package:track/screens/create_account.dart';

  final TextEditingController blood = TextEditingController();
  final TextEditingController bloodPressure = TextEditingController();
  final TextEditingController diabetes = TextEditingController();
  final TextEditingController allergies = TextEditingController();
  final TextEditingController past_Sugeries = TextEditingController();
  final TextEditingController genetic_Disoreders = TextEditingController();


class Medical extends StatefulWidget {
  @override
  _Medical createState() => _Medical();
}

class _Medical extends State<Medical> {



  bool isLoading = false;

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
                      child: field(TextInputType.name, size, "Blood Group", Icons.emergency, blood),
                    ),
                  ),
                  Container(
                    width: size.width,
                    alignment: Alignment.center,
                    child: field(TextInputType.emailAddress, size, "Blood Pressure", Icons.emergency, bloodPressure),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 18.0),
                    child: Container(
                      width: size.width,
                      alignment: Alignment.center,
                      child: field(TextInputType.visiblePassword, size, "Diabetes", Icons.emergency, diabetes),
                    ),
                  ),

                  Padding(
                    padding: const EdgeInsets.only(top:2),
                    child: Container(
                      width: size.width,
                      alignment: Alignment.center,
                      child: description_field(TextInputType.text, size, "Allergies", allergies),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 0.0),
                    child: Container(
                      width: size.width,
                      alignment: Alignment.center,
                      child: description_field(TextInputType.text, size, "Past Sugeries", past_Sugeries),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 0.0),
                    child: Container(
                      width: size.width,
                      alignment: Alignment.center,
                      child: description_field(TextInputType.text, size, "Genetic Disoreders", genetic_Disoreders),
                    ),
                  ),
                  SizedBox(
                    height: size.height / 70,
                  ),
                  customButton(size),
                  SizedBox(
                    height: size.height / 50,
                  ),
                 
                  Container(
                    margin: const EdgeInsets.only(top:10 ,bottom :20),
                    child: GestureDetector(
                      onTap: () => Navigator.pop(context),
                      child: Text(
                        "Login",
                        style: TextStyle(
                       //   color: Colors.blue,
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),
    );
  }

  Widget customButton(Size size) {
    return GestureDetector(
      onTap: () {
        if (blood.text.isNotEmpty &&
            bloodPressure.text.isNotEmpty &&
            diabetes.text.isNotEmpty &&
            allergies.text.isNotEmpty && 
             genetic_Disoreders.text.isNotEmpty && 
             past_Sugeries.text.isNotEmpty) 
             {
          setState(() {
            isLoading = true;
          });
          
          createAccount(name.text, email.text, password.text, phone.text, blood.text, emergency1.text, emergency2.text, emergency3.text, bloodPressure.text, diabetes.text,  allergies.text, past_Sugeries.text,genetic_Disoreders.text).then((user) {
            if (user != null) {
              setState(() {
                isLoading = false;
              });
              Navigator.push(
                  context, MaterialPageRoute(builder: (_) => HomeScreen()));
              print("Account Created Sucessfull");
            } else {
              print("Login Failed");
              setState(() {
                isLoading = false;
              });
            }
          });
        } 
        // else {
        //   print("Please enter Fields");
        // }
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
            "Create Account",
            style: TextStyle(
              color: Colors.white,
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          )),
    );
  }
}

