import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:track/screens/side_bar.dart';
import 'package:track/widgets/field_widget.dart';
import 'package:track/widgets/description_widget.dart';
class UpdateInfoPage extends StatefulWidget {
  const UpdateInfoPage({Key? key}) : super(key: key);

  @override
  State<UpdateInfoPage> createState() => _UpdateInfoPageState();
}

class _UpdateInfoPageState extends State<UpdateInfoPage> {
  final TextEditingController _fullname = TextEditingController();
     final TextEditingController _email = TextEditingController();
      final TextEditingController _mobileNumber = TextEditingController();
  final TextEditingController _emergencyMobileNumber1 = TextEditingController();
  final TextEditingController _emergencyMobileNumber2 = TextEditingController();
  final TextEditingController _emergencyMobileNumber3 = TextEditingController();  
  final TextEditingController _discription = TextEditingController();    
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
                          icon: const Icon(Icons.menu, 
                          color: Colors.white,
                          ),
                          onPressed: () {
                            Scaffold.of(context).openDrawer();
                            ScaffoldMessenger.of(context)
                              ..removeCurrentMaterialBanner();
                           
                          });
                    }),
                    onTap: () => Scaffold.of(context).openDrawer(),
                    // child: Icon(Icons.menu),
                  ),
                  Container(
                    padding: EdgeInsets.fromLTRB(120.0, 0.0, 0.0, 0.0),
                    child: Text(
                      
                      "Update",
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
              SizedBox(height: 20.0),
              Center(
                child: CircleAvatar(
                  backgroundImage: AssetImage("assets/images/user.png"),
                  radius: 60.0,
                 
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 10.0),
                child: Container(
                  alignment: Alignment.centerLeft,
                  padding:EdgeInsets.only(left: 20),
                  child:Text("Full Name ",style: TextStyle(fontSize:20,fontWeight:FontWeight.bold,color:Colors.grey,)),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 10.0),
                child: Container(
                  width: size.width,
                  alignment: Alignment.center,
                  child: field(TextInputType.name, size, "***************",
                      Icons.person, _fullname),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 10.0),
                child: Container(
                  alignment: Alignment.centerLeft,
                  padding:EdgeInsets.only(left: 20),
                  child:Text("Email ",style: TextStyle(fontSize:20,fontWeight:FontWeight.bold,color:Colors.grey,)),
                ),
              ),
               Padding(
                padding: const EdgeInsets.symmetric(vertical: 10.0),
                child: Container(
                  width: size.width,
                  alignment: Alignment.center,
                  child: field(TextInputType.emailAddress, size, "************", Icons.mail,_email ),
                     
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 10.0),
                child: Container(
                  alignment: Alignment.centerLeft,
                  padding:EdgeInsets.only(left: 20),
                  child:Text("Mobile Number ",style: TextStyle(fontSize:20,fontWeight:FontWeight.bold,color:Colors.grey,)),
                ),
              ),
                 Padding(
                padding: const EdgeInsets.symmetric(vertical: 10.0),
                child: Container(
                  width: size.width,
                  alignment: Alignment.center,
                  child: field(TextInputType.number,size, "************", Icons.call, _mobileNumber,
                      ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 10.0),
                child: Container(
                  alignment: Alignment.centerLeft,
                  padding:EdgeInsets.only(left: 20),
                  child:Text("Emergency Mobile Number 1",style: TextStyle(fontSize:20,fontWeight:FontWeight.bold,color:Colors.grey,)),
                ),
              ),
               Padding(
                padding: const EdgeInsets.symmetric(vertical: 10.0),
                child: Container(
                  width: size.width,
                  alignment: Alignment.center,
                  child: field(TextInputType.number,size, "************", Icons.call, _emergencyMobileNumber1,
                      ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 10.0),
                child: Container(
                  alignment: Alignment.centerLeft,
                  padding:EdgeInsets.only(left: 20),
                  child:Text("Emergency Mobile Number 2",style: TextStyle(fontSize:20,fontWeight:FontWeight.bold,color:Colors.grey,)),
                ),
              ),
               Padding(
                padding: const EdgeInsets.symmetric(vertical: 10.0),
                child: Container(
                  width: size.width,
                  alignment: Alignment.center,
                  child: field(TextInputType.number,size, "************", Icons.call, _emergencyMobileNumber2,
                      ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 10.0),
                child: Container(
                  alignment: Alignment.centerLeft,
                  padding:EdgeInsets.only(left: 20),
                  child:Text("Emergency Mobile Number 3",style: TextStyle(fontSize:20,fontWeight:FontWeight.bold,color:Colors.grey,)),
                ),
              ),
                 Padding(
                padding: const EdgeInsets.symmetric(vertical: 10.0),
                child: Container(
                  width: size.width,
                  alignment: Alignment.center,
                  child: field(TextInputType.number,size, "************", Icons.call, _emergencyMobileNumber3,
                      ),
                ),
              ),
              
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 10.0),
                child: Container(
                  alignment: Alignment.centerLeft,
                  padding:EdgeInsets.only(left: 20),
                  child:Text("Blood Group",style: TextStyle(fontSize:20,fontWeight:FontWeight.bold,color:Colors.grey,)),
                ),
              ),
                 Padding(
                padding: const EdgeInsets.symmetric(vertical: 10.0),
                child: Container(
                  width: size.width,
                  alignment: Alignment.center,
                  child: field(TextInputType.number,size, "************", Icons.emergency, _emergencyMobileNumber3,
                      ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 10.0),
                child: Container(
                  alignment: Alignment.centerLeft,
                  padding:EdgeInsets.only(left: 20),
                  child:Text("Blood Pressure",style: TextStyle(fontSize:20,fontWeight:FontWeight.bold,color:Colors.grey,)),
                ),
              ),
                 Padding(
                padding: const EdgeInsets.symmetric(vertical: 10.0),
                child: Container(
                  width: size.width,
                  alignment: Alignment.center,
                  child: field(TextInputType.number,size, "************", Icons.emergency, _emergencyMobileNumber3,
                      ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 10.0),
                child: Container(
                  alignment: Alignment.centerLeft,
                  padding:EdgeInsets.only(left: 20),
                  child:Text("Diabetes",style: TextStyle(fontSize:20,fontWeight:FontWeight.bold,color:Colors.grey,)),
                ),
              ),
                 Padding(
                padding: const EdgeInsets.symmetric(vertical: 10.0),
                child: Container(
                  width: size.width,
                  alignment: Alignment.center,
                  child: field(TextInputType.number,size, "************", Icons.emergency, _emergencyMobileNumber3,
                      ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 10.0),
                child: Container(
                  alignment: Alignment.centerLeft,
                  padding:EdgeInsets.only(left: 20),
                  child:Text("Allergies",style: TextStyle(fontSize:20,fontWeight:FontWeight.bold,color:Colors.grey,)),
                ),
              ),
                 Padding(
                padding: const EdgeInsets.symmetric(vertical: 10.0),
                child: Container(
                  width: size.width,
                  alignment: Alignment.center,
                  child: field(TextInputType.number,size, "************", Icons.emergency, _emergencyMobileNumber3,
                      ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 5.0),
                child: Container(
                  alignment: Alignment.centerLeft,
                  padding:EdgeInsets.only(left: 20),
                  child:Text("Past Sugeries",style: TextStyle(fontSize:20,fontWeight:FontWeight.bold,color:Colors.grey,)),
                ),
              ),
                 Padding(
                padding: const EdgeInsets.symmetric(vertical: 10.0),
                child: Container(
                  width: size.width,
                  alignment: Alignment.center,
                  child: description_field(TextInputType.text,size, "", _discription,
                      ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 5.0),
                child: Container(
                  alignment: Alignment.centerLeft,
                  padding:EdgeInsets.only(left: 20),
                  child:Text("Genetic Disoreders ",style: TextStyle(fontSize:20,fontWeight:FontWeight.bold,color:Colors.grey,)),
                ),
              ),
                 Padding(
                padding: const EdgeInsets.symmetric(vertical: 10.0),
                child: Container(
                  width: size.width,
                  alignment: Alignment.center,
                  child: description_field(TextInputType.text,size, "", _discription,
                      ),
                ),
              ),
              Padding(
          padding: const EdgeInsets.symmetric(vertical: 20.0),
          child: Container(
              padding: EdgeInsets.only(left: 20,right:20),
              alignment: Alignment.center,
              child: ElevatedButton(
                
                style: ElevatedButton.styleFrom(
          minimumSize: const Size.fromHeight(70),
                   shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(40),
                  ),
                  primary: Colors.black
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  
                  children: const [
        //          Icon(
        //   Icons.add,
        //   color: Colors.white,
        // ),
        Text(
          'Update',
          style: TextStyle(color: Colors.white,fontSize: 25),
        ),


                ]),
                onPressed: () {},
              )),
        ),  
            ])),);
  }
  

    
}
