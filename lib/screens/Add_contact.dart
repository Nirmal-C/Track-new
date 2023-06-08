import 'package:flutter/material.dart';
import 'package:track/screens/home_screen.dart';
import 'package:track/screens/side_bar.dart';
import 'package:track/widgets/field_widget.dart';

class Add_contact extends StatelessWidget {
  TextEditingController _ctname = TextEditingController();
  TextEditingController _ctphone = TextEditingController();
  // var _ctphone;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      drawer: const MyNavigationDrawer(),
      appBar: AppBar(

          // backgroundColor: Colors.blue,
          elevation: 0.0,
          automaticallyImplyLeading: false,
           title: Row(
                
                children: <Widget>[
                  GestureDetector(
                    child: Builder(builder: (context) {
                      return IconButton(
                          icon: const Icon(Icons.menu, color: Colors.white,),
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
                    padding: EdgeInsets.fromLTRB(50.0, 0.0, 0.0, 0.0),
                    child: Text(
                      
                      "Emergency Contact",
                      style: TextStyle(
                        fontSize: 25.0,
                       color: Colors.white,
                      ),
                    ),
                  )
                ],
              )),
      body:SingleChildScrollView(
        child: Column(children: <Widget>[
        SizedBox(height: 25.0),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 15.0),
          child: Container(
            width: size.width,
            alignment: Alignment.center,
            child: field(
                TextInputType.name, size, "Name", Icons.account_box, _ctname),
          ),
        ),
        SizedBox(height: 10.0),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 15.0),
          child: Container(
            width: size.width,
            alignment: Alignment.center,
            child: field(
                TextInputType.phone, size, "Phone", Icons.phone, _ctphone),
          ),
        ),
        SizedBox(height: 40.0),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 30.0),
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
          'Add Contact',
          style: TextStyle(color: Colors.white,fontSize: 25),
        ),


                ]),
                onPressed: () {},
              )),
        ),
        SizedBox(height:size.height/10),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 20),
                  child:Expanded(
                    child: Image.asset(
                'assets/images/Accident.png',
                height: 300,
                width: 300,
              ), 
                  )
                  )
      ]),
      // floatingActionButton: FloatingActionButton.extended(
      //   onPressed: () {
      //     // Add your onPressed code here!
      //   },
      //   backgroundColor: Theme.of(context).primaryColor,
      //   label: const Text(
      //     'Add',
      //     style: TextStyle(color: Colors.black),
      //   ),
      //   icon: const Icon(
      //     Icons.add,
      //     color: Colors.black,
      //   ),
      //   // backgroundColor: Colors.blue,
      // ),
    ),);
  }

//   Widget field(
//     Size size, String hintText) {
//     return Container(
//       height: size.height / 14,
//       width: size.width / 1.1,
//       child: TextField(
//         decoration: InputDecoration(
//             hintText: hintText,
//             hintStyle: TextStyle(color: Colors.grey),
//             enabledBorder: UnderlineInputBorder( //<-- SEE HERE
//             borderSide: BorderSide(
//             width: 3, color: Colors.grey),
//             ),
//           ),
//       ),
//     );
//   }

}
