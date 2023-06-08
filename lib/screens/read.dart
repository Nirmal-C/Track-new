// ignore_for_file: prefer_const_literals_to_create_immutables

import 'dart:async';

import 'dart:convert';

import 'package:firebase_database/firebase_database.dart';

import 'package:flutter/material.dart';

class ReadExample extends StatefulWidget {
  const ReadExample({Key? key}) : super(key: key);

  @override
  State<ReadExample> createState() => _ReadExampleState();
}

class _ReadExampleState extends State<ReadExample> {
  String _displayText = 'Results go here';
  final _database = FirebaseDatabase(
          databaseURL:
              'https://track-6aeb6-default-rtdb.asia-southeast1.firebasedatabase.app/')
      .ref();

  late StreamSubscription _subscription;

  @override
  void initState() {
    super.initState();
    _activateListeners();
  }

  void _activateListeners() {
    _subscription = _database.child('location').onValue.listen((event) {
      Map<String, dynamic> location =
          jsonDecode(jsonEncode(event.snapshot.value));

      final lat = location['latitude'];
      final lon = location['longitude'];
      final speed = location['speed(kmph)'];


    

      setState(() {
        _displayText = "$lat, $lon, $speed";
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Read examples'),
        ),
        body: Center(
            child: Padding(
                padding: const EdgeInsets.only(top: 15.0),
                child: Column(
                  children: [
                    Text(_displayText),
                  ],
                ))));
  }

  @override
  void deactivate() {
    _subscription.cancel;
    super.deactivate();
  }
}
