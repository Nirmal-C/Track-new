import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:track/screens/side_bar.dart';
import 'package:track/widgets/field_widget.dart';
import 'package:track/widgets/card_widget.dart';

class HistoryPage extends StatefulWidget {
  const HistoryPage({Key? key}) : super(key: key);

  @override
  State<HistoryPage> createState() => _HistoryPageState();
}

class _HistoryPageState extends State<HistoryPage> {
  
  @override
  void initState() {
    fetch();
    initiate();
    super.initState();
  }

  void initiate() async {
    await FirebaseFirestore.instance.disableNetwork();
    await FirebaseFirestore.instance.enableNetwork();
  }

  var db = FirebaseFirestore.instance;

  // void fetch() {
  //   final docRef = db.collection("users").doc(uid);
  //   docRef.snapshots().listen(
  //         (event) => setState(() {
  //           currentUser = event.data();
  //           Map<String, dynamic> data = Map<String, dynamic>();

  //           for (dynamic type in currentUser!.keys) {
  //             data[type.toString()] = currentUser![type];
  //           }
  //           setState(() {
  //             history = (data['history']);

  //           });
  //         }),
  //         onError: (error) => print("Listen failed: $error"),
  //       );
  // }
  var history = "jijqqi";
  void fetch() {
    db.collection("users").doc(uid).get().then((docSnapshot) {
      setState(() {
        history = ( docSnapshot.data().toString());
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    // TextEditingController _altitude = TextEditingController();
    // TextEditingController _latitude = TextEditingController();
    // TextEditingController _time = TextEditingController();
    // TextEditingController _speed = TextEditingController();
    // TextEditingController _longitude = TextEditingController();

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
                    padding: EdgeInsets.fromLTRB(50.0, 0.0, 0.0, 0.0),
                    child: Text(
                      
                      "Previous Records",
                      style: TextStyle(
                        fontSize: 25.0,
                       color: Colors.white,
                      ),
                    ),
                  )
                ],
              )),
            body:SingleChildScrollView(
             child:Column(children :<Widget>[ 
             card_field("Accident 1","234.10001","22.24424","11:22:42 hr","0.03704","84.88819"),
             card_field("Accident 2","230.3","22.24638","11:28:49 hr","0.07408","84.88591"),
             card_field("Accident 3","233.10001","22.24636","11:31:40 hr","0.12964","84.8858"),
             
          ]),
          )
          );
    // body: Builder(builder: (context){
    //   return StreamBuilder<QuerySnapshot>(
    //     stream: FirebaseFirestore.instance.collection('users').snapshots(),
    //     builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
    //       if (snapshot.hasError)
    //         return Center(
    //           child: Text('Error: ${snapshot.error}'),
    //         );
    //       switch (snapshot.connectionState) {
    //         case ConnectionState.waiting:
    //           return Center(
    //             child: Text('Loading...'),
    //           );
    //         default:
    //           // ignore: unnecessary_new
    //           return new ListView(
    //             children: snapshot.data!.docs.map((
    //                 DocumentSnapshot document) {
    //               return  ListTile(
    //                 title: Text(document["uid"]),
    //                 //subtitle: Text(uid["history"]),

    //               );
    //             }).toList(),
    //           );
    //       }
    //     },
    //   );
    // })
  }
}
