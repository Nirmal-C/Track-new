import 'package:flutter/material.dart';
import 'package:track/screens/home_screen.dart';
import 'package:track/screens/side_bar.dart';
import 'package:track/widgets/field_widget.dart';

class Change_Password extends StatefulWidget {
  const Change_Password({Key? key}) : super(key: key);

  @override
  State<Change_Password> createState() => _Change_PasswordState();
}

class _Change_PasswordState extends State<Change_Password> {

 final TextEditingController _oldpass = TextEditingController();
     final TextEditingController _newpass1 = TextEditingController();
      final TextEditingController _newpass2 = TextEditingController();
        @override
  Widget build(BuildContext context) {
    
  
    final size = MediaQuery.of(context).size;

    return Scaffold(
        drawer: const MyNavigationDrawer(),
        appBar: AppBar(
            //backgroundColor: Colors.blue,
            elevation: 0.0,
            automaticallyImplyLeading: false,
            title: Row(
              children: <Widget>[
                GestureDetector(
                  child: Builder(builder: (context) {
                    return IconButton(
                        icon: const Icon(
                          Icons.menu,
                          color: Colors.white,
                        ),
                        onPressed: () {
                          Scaffold.of(context).openDrawer();
                          ScaffoldMessenger.of(context)
                            ..removeCurrentMaterialBanner();
                          checker = false;
                        });
                  }),
                  onTap: () => Scaffold.of(context).openDrawer(),
                  // child: Icon(Icons.menu),
                ),
                Container(
                  padding: EdgeInsets.fromLTRB(60.0, 0.0, 0.0, 0.0),
                  child: Text(
                    "Change Password",
                    style: TextStyle(
                      fontSize: 25.0,
                      color: Colors.white,
                    ),
                  ),
                )
              ],
            )),
        body:SingleChildScrollView(
                child:Column(
            // mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 10.0),
                child: Container(
                  width: size.width,
                  alignment: Alignment.center,
                  child: field(TextInputType.emailAddress, size, "Old Password",
                      Icons.lock, _oldpass),
                ),
              ),
               Padding(
                padding: const EdgeInsets.symmetric(vertical: 10.0),
                child: Container(
                  width: size.width,
                  alignment: Alignment.center,
                  child: field(TextInputType.emailAddress, size, "New Password", Icons.lock, _newpass1),
                     
                ),
              ),
                 Padding(
                padding: const EdgeInsets.symmetric(vertical: 10.0),
                child: Container(
                  width: size.width,
                  alignment: Alignment.center,
                  child: field(TextInputType.visiblePassword,size, "Confirm New Password", Icons.lock, _newpass2,
                      ),
                ),
              ),


             Padding(
          padding: const EdgeInsets.symmetric(vertical: 60.0),
          child: Container(
              padding: EdgeInsets.only(left: 20,right:20),
              alignment: Alignment.center,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                            shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(40)),
                             minimumSize: const Size.fromHeight(60),
                  

                  primary: Colors.black
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center, 
                  children: const [
                    Text(
                          'Set',
                            style: TextStyle(color: Colors.white, fontSize: 25),

                        ),]),
                onPressed: () {}, ))),

                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 10.0),
                  child:Container(
                    alignment: Alignment.center,
                    child: Image.asset(
                'assets/images/Accident.png',
                height: 270,
                width: 270,
              ), 
                  )
                  )
            ])));
  }
  

    
  }

