import 'dart:async';

import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:flutter/material.dart';
class GetData extends StatefulWidget {
  const GetData({Key? key}) : super(key: key);

  @override
  State<GetData> createState() => _GetDataState();
}

class _GetDataState extends State<GetData> {
  final database = FirebaseDatabase.instance.reference();

  String tempText = "";
  String humiText ="";
  late StreamSubscription _dailySpecialStream;
  late StreamSubscription _dailySpecialStream2;
  @override
  void initState(){
    super.initState();
    _activateListeners();
  }
  void _activateListeners(){
    _dailySpecialStream = database.child('theReadings/temp').onValue.listen((event) {
      final temperature = event.snapshot.value;
      setState(() {
        tempText = "Today's temp: $temperature";
      });
    });
    _dailySpecialStream2 = database.child('theReadings/humi').onValue.listen((event) {
      final temperature = event.snapshot.value;
      setState(() {
        humiText = "Today's Humidity: $temperature";
      });
    });
  }
  @override
  Widget build(BuildContext context) {
    final temp = database.child('theReadings/temp');
    return Scaffold(
      appBar: AppBar(
        title: Text(tempText),
      ),
      body: Container(
        child: Text(humiText),
      ),
    );
  }
  @override
  void deactivate(){
    _dailySpecialStream.cancel();
  }
}
