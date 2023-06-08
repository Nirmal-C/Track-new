// ignore_for_file: prefer_const_constructors

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

import 'package:track/screens/login_screen.dart';
import 'package:track/screens/home_screen.dart';
import 'package:track/screens/side_bar.dart';
import 'package:firebase_database/firebase_database.dart';

import 'package:track/services/query.dart';
// import 'package:get/get.dart';
// import 'package:get_storage/get_storage.dart';

final _database = FirebaseDatabase(
        databaseURL:
            'https://track-6aeb6-default-rtdb.asia-southeast1.firebasedatabase.app/')
    .ref();

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp();
  runApp(MyApp());
  _appopen();
  MyNavigationDrawer();
}

void _appopen() {
  final appstart = _database.child('monitoring');

  appstart.update({'app': 1});
}

OnDisconnect onDisconnect = _database.child("monitoring").onDisconnect();

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    onDisconnect.update({"auto_monitoring": 0, "app": 0});
    return MaterialApp(
      color: Palette.kToDark,
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        appBarTheme: AppBarTheme(
          titleTextStyle: TextStyle(color: Colors.white),
          backgroundColor: Colors.black,
        ),
        primarySwatch: Palette.kToDark,
        textTheme: Theme.of(context).textTheme.apply(
              //  Set default Text() color;  Use:  apply()
              bodyColor: Colors.black,
              displayColor: Colors.black,
            ),
      ),
      home: LoginScreen(),
    );
  }
}

class Palette {
  static const MaterialColor kToDark = MaterialColor(
    0xffF39500,
    const <int, Color>{
      50: const Color(0xffce5641), //10%
      100: const Color(0xffb74c3a), //20%
      200: const Color(0xffa04332), //30%
      300: const Color(0xff89392b), //40%
      400: const Color(0xff733024), //50%
      500: const Color(0xff5c261d), //60%
      600: const Color(0xff451c16), //70%
      700: const Color(0xff2e130e), //80%
      800: const Color(0xff170907), //90%
      900: const Color(0xff000000), //100%
    },
  );
}
