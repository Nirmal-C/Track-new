// ignore_for_file: prefer_const_constructors, override_on_non_overriding_member, non_constant_identifier_names

import 'package:flutter/material.dart';

import 'package:flutter_switch/flutter_switch.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:track/main.dart';
import 'package:track/screens/side_bar.dart';

import 'package:cloud_firestore/cloud_firestore.dart';

import 'dart:async';

import 'dart:convert';
import 'package:flutter/services.dart' show rootBundle;

import 'package:firebase_database/firebase_database.dart';
import 'package:track/services/sms.dart';

import '../services/method.dart';

// import 'package:get/get.dart';
// import 'package:get_storage/get_storage.dart';

ValueNotifier<bool> dialogTrigger = ValueNotifier(false);
bool checker = false;
var latitude = 22.2531;
var longitude = 84.9010;
var speed = 0.000;
var altitude = 0.00;
var accident = 0;
var accident_count = 0;
//var responder;

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  bool auto_monitor = false;

  var _displayText = 'Results go here';
  var _accidentText = 'Not yet';

  final _database = FirebaseDatabase(
          databaseURL:
              'https://track-6aeb6-default-rtdb.asia-southeast1.firebasedatabase.app/')
      .ref();

  late StreamSubscription _subscription, _accidentsub, _accidentcountsub;
  List<Marker> allMarkers = [];

  var _darkMapStyle;

  @override
  void initState() {
    super.initState();
    _activateListeners();
    _loadMapStyles();
    
    _events.add(15);
    //
    //_appopen();

    //final GetXSwitchState getXSwitchState = Get.put(GetXSwitchState());

    // setState(() {
    //   auto_monitor = getXSwitchState.isPressed;
    // });

    allMarkers.add(Marker(
      markerId: MarkerId('myMarker'),
      draggable: false,
      onTap: () {},
    ));
  }

  Future _loadMapStyles() async {
    _darkMapStyle = await rootBundle.loadString('assets/map_styles/dark.json');
  }



  var _initialCameraPosition =
      CameraPosition(target: LatLng(22.2531, 84.9010), zoom: 15);
  late GoogleMapController _googleMapController;

  void _activateListeners() {
    _subscription = _database.child('location').onValue.listen((event) {
      Map<String, dynamic> location =
          jsonDecode(jsonEncode(event.snapshot.value));

      final lat = location['latitude'];
      final lon = location['longitude'];
      final fast = location['speed(kmph)'];
      final high = location['altitude'];

      setState(() {
        latitude = lat;
        longitude = lon;
        speed = fast;
        altitude = high;

        LatLng(lat, lon);

        _displayText = "$lat, $lon, $fast $altitude";

        _googleMapController.animateCamera(
          CameraUpdate.newCameraPosition(
              CameraPosition(target: LatLng(latitude, longitude), zoom: 20)),
        );

        allMarkers.add(Marker(
            markerId: MarkerId('myMarker'),
            position: LatLng(latitude, longitude)));
      });
    });

    _accidentsub = _database
        .child('Accident/new accident status')
        .onValue
        .listen((event1) {
      var acc = event1.snapshot.value as int;

      setState(() {
        accident = acc;
      });
    });

    _accidentcountsub = _database
        .child('Accident/number of accidents')
        .onValue
        .listen((event2) {
      var acc = event2.snapshot.value as int;

      setState(() {
        accident_count = acc;
      });
    });
  }

  @override
  bool status = false;
  var Auto_monitoring = "OFF";
  var Emergency_text = "REQUEST EMERGENCY";
  bool pressed = true;

  void removeBanner() {
    ScaffoldMessenger.of(context)..removeCurrentMaterialBanner();
  }

  // ignore: prefer_final_fields

  // Timer? timer;
  // int start = 15;

  // void startTimer() {
  //   const oneSec = Duration(seconds: 0);
  //   timer = Timer.periodic(
  //     oneSec,
  //     (Timer timer) {
  //       if (start == 0) {
  //         setState(() {
  //           timer.cancel();
  //         });
  //       } else {
  //         setState(() {
  //           start--;
  //         });
  //       }
  //     },
  //   );
  // }
  // _events = StreamController<int>();
  // var _events = StreamController<int>();
  int _counter = 15;

  StreamController<int> _events = StreamController<int>.broadcast();

  //_events.add(15);

  Timer? _timer;
  void _startTimer() {
    _counter = 15;

    if (_timer != null) {
      _timer?.cancel();
    }
    _timer = Timer.periodic(Duration(seconds: 1), (timer) {
      //setState(() {
      if (_counter > 0) {
        _counter--;
      } else {
        timer.cancel();

        Navigator.pop(context);
        var snackBar = SnackBar(
            content: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Accident Detection Alert Sent',
              style: TextStyle(),
            )
          ],
        ));
        sendsms();
        ScaffoldMessenger.of(context).showSnackBar(snackBar);
      }
      //});
      print(_counter);
      _events.add(_counter);
    });
  }

  void alertD(BuildContext ctx) {
    var alert = AlertDialog(
        backgroundColor: Colors.black.withOpacity(0.7),
        title: Container(
          alignment: Alignment.center,
          child: Text(
            'WARNING!',
            style: TextStyle(
              color: Colors.red,
              fontSize: 23,
            ),
          ),
        ),
        content: StreamBuilder<int>(
            stream: _events.stream.asBroadcastStream(),
            //     .asBroadcastStream(),
            builder: (BuildContext context, AsyncSnapshot<int> snapshot) {
              print(snapshot.data.toString());

              return Container(
                  height: 190,
                  child: Column(children: [
                    Text('Accident Detected !',style: TextStyle(color: Colors.white)),
                    const SizedBox(
                      height: 20,
                    ),
                    Text("${snapshot.data.toString()} Sec",
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 20,color: Colors.white)),
                    const SizedBox(
                      height: 25,
                    ),
                    Text('Press "Cancel" to Abort Sending',style: TextStyle(color: Colors.white)),
                    const SizedBox(
                      height: 30,
                    ),
                    Expanded(
                      child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        minimumSize: const Size.fromHeight(50),
                        primary: Palette.kToDark ,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30),
                          )),
                          onPressed: () {
                          Navigator.pop(context);
                          _timer?.cancel();
                        },
                          
                          
                          child: Text("Cancel" , style: TextStyle (fontSize: 20),),),
                     
                    )
                  ]));
            }));
    showDialog(
        barrierDismissible: false,
        context: ctx,
        builder: (ctx) {
          return alert;
        });
  }

  @override
  void dispose() {
    _googleMapController.dispose();
    dialogTrigger.removeListener(() {});
    _subscription.cancel();
    _events.close();

    super.dispose();
  }

  // @override
  // void deactivate() {
  //   _subscription.cancel;

  //   super.deactivate();
  // }

  static String currentTimeInSeconds() {
    var hs = (new DateTime.now()).hour;
    var ms = (new DateTime.now()).minute;
    var sc = (new DateTime.now()).second;

    var time = "$hs:$ms:$sc hr";

    return (time);
  }

  Future addAccidentRecord() async {
    final docAccident = FirebaseFirestore.instance.collection('users').doc(uid);

    final json = {
      'history': {
        'accident number $accident_count': {
          'time': currentTimeInSeconds(),
          'latitude': "$latitude° N",
          'longitude': "$longitude° E",
          'altitude': "$altitude m",
          'speed': "$speed kmph",
        }
      }
    };

    await docAccident.update(json);
  }

  @override
  Widget build(BuildContext context) {
    //WidgetsBinding.instance.addPostFrameCallback((_) {
    // add your code here.
    //SchedulerBinding.instance.addPostFrameCallback((_) {
    final acc_count = _database.child('Accident');

    if ((auto_monitor == true) & (accident == 1)) {
      setState(() {
        _accidentText = 'Detected';
        acc_count.update({'new accident status': 0});
        dialogTrigger.value = true;
        addAccidentRecord();

        Timer(Duration(seconds: 1), () {
          dialogTrigger.value = false;
        });

        acc_count.update({'new accident status': 0});

        // ValueNotifier(true);
      });
    } else {
      setState(() {
        //_accidentText = 'Not Yet';
        //ValueNotifier(false);
        dialogTrigger.value = false;
      });
    }
    //});
    // accident_status.set({0});
    //  });

// Somewhere in your application, trigger that the user is online:

    final tracking = _database.child('monitoring');

    // OnDisconnect onDisconnect = _database.child("monitoring").onDisconnect();
    // onDisconnect.update({"auto_monitoring": 0, "app": 0});

    //   final accident_status = _database.child('accident_status');

    // final GetXSwitchState getXSwitchState = Get.put(GetXSwitchState());
    return WillPopScope(
        child: Scaffold(
          drawer: const MyNavigationDrawer(),
          floatingActionButton: Container(
              margin: EdgeInsets.only(bottom: 90),
              padding: EdgeInsets.all(2),
              child: Align(
                alignment: Alignment.bottomRight,
                child: FloatingActionButton(
                  backgroundColor: Theme.of(context).primaryColor,
                  //   foregroundColor: Colors.white,
                  onPressed: () {
                    _googleMapController.animateCamera(
                      CameraUpdate.newCameraPosition(CameraPosition(
                          target: LatLng(latitude, longitude), zoom: 20)),
                    );

                    allMarkers.add(Marker(
                        markerId: MarkerId('myMarker'),
                        position: LatLng(latitude, longitude)));
                  },
                  child: const Icon(
                    Icons.center_focus_strong,
                    color: Colors.black,
                  ),
                ),
              )),

          bottomSheet: Offstage(
            offstage: true,
            child: ValueListenableBuilder(
                valueListenable: dialogTrigger,
                builder: (ctx, value, child) {
                  if (dialogTrigger.value == true) {
                    Future.delayed(const Duration(seconds: 0), () {
                      _startTimer();
                      alertD(context);
                      dialogTrigger.value = false;
                      Timer(Duration(seconds: 15), () {
                        ;
                      });
                    });
                  }

                  return const SizedBox();
                }),
          ),

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
                    padding: EdgeInsets.fromLTRB(120.0, 0.0, 0.0, 0.0),
                    child: Text(
                      "HOME",
                      style: TextStyle(
                        fontSize: 25.0,
                        color: Colors.white,
                      ),
                    ),
                  )
                ],
              )),
          // drawer: const NavigationDrawer (),
          body: Container(
            decoration: BoxDecoration(color: Colors.black26),
            child: Column(
              children: <Widget>[
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: <Widget>[
                    // GetBuilder<GetXSwitchState>(
                    //  builder: (_) =>dialogTrigger.removeListener(() { });
                    FlutterSwitch(
                        width: 50.0,
                        height: 30.0,
                        valueFontSize: 20.0,
                        toggleSize: 20.0,
                        value: status,
                        borderRadius: 30.0,
                        activeToggleColor: Theme.of(context).primaryColor,
                        inactiveToggleColor: Theme.of(context).primaryColor,
                        activeColor: Colors.black,
                        inactiveColor: Colors.black54,
                        //switchBorder: Border.all(),
                        padding: 3.0,
                        activeIcon: Icon(
                          Icons.where_to_vote_rounded,
                          color: Colors.black,
                          size: 60.0,
                        ),
                        inactiveIcon: Icon(
                          Icons.where_to_vote_rounded,
                          color: Colors.black,
                          size: 60.0,
                        ),
                        // showOnOff: true,
                        onToggle: (value) {
                          setState(() {
                            status = value;
                            if (Auto_monitoring == "OFF") {
                              Auto_monitoring = "ON";
                              auto_monitor = true;
                              tracking.update({'auto_monitoring': 1});
                              checker = false;

                              //  getXSwitchState.changeSwitchState(value);
                            } else {
                              Auto_monitoring = "OFF";
                              auto_monitor = false;

                              //getXSwitchState.changeSwitchState(value);

                              tracking.update({'auto_monitoring': 0});
                            }
                            if (pressed == true) {
                              pressed = false;
                              Emergency_text = "AUTO MONITORING ACTIVATED";
                            } else {
                              pressed = true;
                              Emergency_text = "REQUEST EMERGENCY";
                            }
                          });
                        }),

                    Column(
                      children: <Widget>[
                        Text(
                          "Auto Monitoring",
                          style: TextStyle(fontSize: 25.0),
                        ),
                        Text(
                          "$Auto_monitoring",
                          style: TextStyle(
                              fontSize: 15.0,
                              fontWeight: FontWeight.bold,
                              color:(pressed==false) ? Palette.kToDark : Colors.black),
                        )
                      ],
                    ),
                    Icon(
                      Icons.directions_car_rounded,
                      color: Colors.black54,
                      size: 50.0,
                    ),
                  ],
                ),

                Expanded(
                    child: GoogleMap(
                        markers: Set.from(allMarkers),
                        compassEnabled: true,
                        trafficEnabled: true,
                        zoomControlsEnabled: false,
                        initialCameraPosition: _initialCameraPosition,
                        onMapCreated: (controller) {
                          _googleMapController = controller;
                          controller.setMapStyle(_darkMapStyle);
                        })),
                        SizedBox(height:10),
                Text(
                    '  Location: $latitude° N   $longitude° E     Speed: $speed kmph'),
                //Text(_displayText),

                //Text('$auto_monitor'),
                // Text('$accident'),
                //  Text(_accidentText),
                Container(
                    margin: EdgeInsets.all(10),
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30),
                          ),
                          primary: (pressed == true)
                              ? Colors.black
                              : Palette.kToDark,
                          minimumSize: const Size.fromHeight(50)

                          // NEW
                          ),
                      onPressed: () {
                        if ((auto_monitor == false) & (checker == false)) {
                          ScaffoldMessenger.of(context)
                              .showMaterialBanner(materialBanner(context));
                          MainAxisAlignment.center;
                          checker = true;
                          dialogTrigger.value = false;
                        } else if (pressed == false) {
                          ScaffoldMessenger.of(context)
                            ..removeCurrentMaterialBanner();

                          pressed = false;
                        }
                      },
                      child: Text(
                        "$Emergency_text",
                        style: TextStyle(
                          fontSize: (pressed == true) ? 24 : 21,
                          color:
                              (pressed == true) ? Colors.white : Colors.black,
                        ),
                      ),
                    ))
              ],
            ),
          ),
        ),
        onWillPop: () async {
          try {
            ScaffoldMessenger.of(context)..removeCurrentMaterialBanner();

            logOut(context);
            return true; // true allows navigating back
          } catch (e) {
            return false; // false prevents navigating back
          }
        });
  }
}

var snackBar2 = SnackBar(
    content: Row(
  mainAxisAlignment: MainAxisAlignment.center,
  children: const [
    Text(
      'Emergency Request Sent ',
      style: TextStyle(),
    )
  ],
));

// showMaterialBanner() {
void alertD2(BuildContext ctx) {
  var alert2 = AlertDialog(
      backgroundColor: Colors.black.withOpacity(0.3),
      title: Container(
        alignment: Alignment.center,
        child: Text(
          'WARNING!',
          style: TextStyle(
            color: Colors.red,
            fontSize: 23,
          ),
        ),
      ),
      content: StreamBuilder<int>(
          // stream: _events.stream,
          //     .asBroadcastStream(),
          builder: (BuildContext context, AsyncSnapshot<int> snapshot) {
        print(snapshot.data.toString());
        return Container(
            height: 150,
            child: Expanded(
                child: Column(children: [
              Text('This will Send Emergency Notification',style: TextStyle(color: Colors.white)),
              const SizedBox(
                height: 30,
              ),
              Text('Are You Sure?',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18,color: Colors.white)),
              const SizedBox(
                height: 30,
              ),
              Expanded(
                child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          primary: Colors.grey,
                        ),
                        child: Text("Cancel"),
                        onPressed: () {
                          Navigator.pop(context);
                        },
                      ),
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            // primary: Colors.blue,
                            ),
                        child: Text("Yes"),
                        onPressed: () {
                          ScaffoldMessenger.of(context).showSnackBar(snackBar2);
                          Navigator.pop(context);
                        },
                      )
                    ]),
              )
            ])));
      }));
  showDialog(
      barrierDismissible: false,
      context: ctx,
      builder: (ctx) {
        return alert2;
      });
}

MaterialBanner materialBanner(BuildContext context) {
  return MaterialBanner(
      padding: EdgeInsets.only(top: 10),
      elevation: 5,
      forceActionsBelow: true,
      overflowAlignment: OverflowBarAlignment.start,
      content: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: const [
            Text('',
                style: TextStyle(
                    color: Colors.red,
                    fontSize: 20,
                    fontWeight: FontWeight.bold)),
          ]),
      backgroundColor: Colors.black.withOpacity(0.8),
      actions: [
        Column(children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              Row(children: <Widget>[
                Radio(
                  value: "Ambulance",
                  groupValue: 'Emergancy',
                  activeColor: Colors.orange,
                  fillColor:
                      MaterialStateColor.resolveWith((states) => Colors.orange),
                  onChanged: (value) {
                    alertD2(context);
                  },
                ),
                Text("Ambulance",
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                        fontWeight: FontWeight.bold)),
              ]),
              Row(children: <Widget>[
                Radio(
                  value: "Fire",
                  groupValue: 'Emergancy',
                  onChanged: (value) {
                    alertD2(context);
                  },
                  activeColor: Colors.orange,
                  fillColor:
                      MaterialStateColor.resolveWith((states) => Colors.orange),
                ),
                Text("Fire",
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                        fontWeight: FontWeight.bold)),
              ]),
              Row(children: <Widget>[
                Radio(
                  value: "Police",
                  groupValue: 'Emergancy',
                  onChanged: (value) {
                    alertD2(context);
                  },
                  activeColor: Colors.orange,
                  fillColor:
                      MaterialStateColor.resolveWith((states) => Colors.orange),
                ),
                Text("Police",
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                        fontWeight: FontWeight.bold))
              ])
            ],
          ),
          SizedBox(height: 20),
          Container(
            margin: EdgeInsets.only(right:10 , left: 20 , bottom:10),
            
            child:  ElevatedButton(
              onPressed: () {
                checker = false;
                ScaffoldMessenger.of(context)..removeCurrentMaterialBanner();
              },
              style: ElevatedButton.styleFrom(
                  shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30),
                          ),
                
                  // primary: Colors.blue,
                  minimumSize: const Size.fromHeight(40)

                  // NEW
                  ),
              child: Text("CANCEL", style: TextStyle(fontSize: 20)))),
         
        ]),
      ]);
}
