import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'dart:async';

class HeartRate extends StatefulWidget {
  const HeartRate({Key? key}) : super(key: key);

  @override
  State<HeartRate> createState() => _HeartRateState();
}

class _HeartRateState extends State<HeartRate> {
  final database = FirebaseDatabase.instance.reference();

  String rateText = "";
  late StreamSubscription _dailySpecialStream;

  @override
  void initState() {
    super.initState();
    _activateListeners();
  }

  void _activateListeners() {
    _dailySpecialStream = database.child('theReadings/rate').onValue.listen((event) {
      final rate = event.snapshot.value;
      setState(() {
        rateText = "$rate";
      });
    });
  }

  final hoursController = TextEditingController();
  final minutesController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final hours = database.child('theReadings/hours');
    final mins = database.child('theReadings/mins');
    return Scaffold(
      appBar: AppBar(
        title: const Text('Alarm'),
        centerTitle: true,
        backgroundColor: Colors.pink.shade100,
      ),
      body: Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [Colors.pink.shade100, Colors.pinkAccent],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
            ),
          ),
          child: SingleChildScrollView(
          child: Padding(
          padding: const EdgeInsets.all(20),
      child: Column(
          children: <Widget>[
      Padding(
      padding: const EdgeInsets.all(8.0),
      child: Image.asset(
        'lib/images/9.jpg',
        height: 200,
      ),
    ),
    const SizedBox(height: 40),
    Column(
    mainAxisAlignment: MainAxisAlignment.center,
    children: <Widget>[
    TextField(
    controller: hoursController,
    decoration: InputDecoration(
    border: OutlineInputBorder(),
    labelText: 'Hours',
    hintText: 'Enter Hours',
    suffixIcon: IconButton(
    onPressed: () {
    hoursController.clear();
    },
    icon: const Icon(Icons.clear),
    ),
    ),
    keyboardType: TextInputType.number,
    ),
    const SizedBox(height: 20),
    TextField(
    controller: minutesController,
    decoration: InputDecoration(
    border: OutlineInputBorder(),
    labelText: 'Minutes',
    hintText: 'Enter Minutes',
    suffixIcon: IconButton(
    onPressed: () {
    minutesController.clear();
    },
    icon: const Icon(Icons.clear),
    ),
    ),
    keyboardType: TextInputType.number,
    ),
    const SizedBox(height: 40),
    ElevatedButton(
    onPressed: () {
    hours.set(int.parse(hoursController.text));
    mins.set(int.parse(minutesController.text));
    },
    child: const Text(
    'Set Alarm',
    style: TextStyle(fontSize: 16),
    ),
    style: ElevatedButton.styleFrom(
    minimumSize: const Size(150, 50),
    primary: Colors.
    grey[400], // set the color to gray
    ),
    ),
    ],
    ),
          ],
      ),
          ),
          ),
      ),
    );
  }
}