import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:modernlogintute/config/colors.dart';
import 'package:modernlogintute/models/weather_model.dart';
import 'package:modernlogintute/models/weathercode_model.dart';
import 'package:modernlogintute/utils/align_constants.dart';
import 'package:modernlogintute/view-model/weather_provider.dart';
import 'package:modernlogintute/view/screens/widget/weather_status.dart';
import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:modernlogintute/models/weather_model.dart';
import 'package:modernlogintute/models/weathercode_model.dart';
import 'package:modernlogintute/view-model/weather_provider.dart';

import 'package:modernlogintute/utils/align_constants.dart';

import 'package:modernlogintute/view/screens/home/widgets/widget_exporter.dart';

import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:flutter/material.dart';
class HomeAppbarRowWidget extends StatefulWidget {
  const HomeAppbarRowWidget({Key? key}) : super(key: key);

  @override
  State<HomeAppbarRowWidget> createState() => _HomeAppbarRowWidgetState();
}

class _HomeAppbarRowWidgetState extends State<HomeAppbarRowWidget> {
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
        tempText = "$temperature°C";
      });
    });
    _dailySpecialStream2 = database.child('theReadings/humi').onValue.listen((event) {
      final temperature = event.snapshot.value;
      setState(() {
        humiText = "$temperature%";
      });
    });
  }
  @override
  Widget build(BuildContext context) {
    WeatherProvider weatherProvider = Provider.of<WeatherProvider>(context);
    WeatherModel weatherModel = weatherProvider.getLoadedWeather;
    List todayWeather = weatherProvider.todayWeather;

    WeatherCodeModel? weatherCodeModel =
    weatherProvider.getWeatherCode(todayWeather[0]);

    return Row(
      children: [
        Padding(
          padding: elementAlignment,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                weatherModel.timezone,
                style: Theme.of(context).textTheme.headlineMedium,
              ),
              Text(
                tempText,
                style: Theme.of(context).textTheme.headlineLarge,
              ),
              Text(
                humiText,
                style: Theme.of(context).textTheme.headlineLarge,
              ),
              Container(
                padding:
                const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                decoration: BoxDecoration(
                  color: mainColors.lightContainerBG,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Text(
                  weatherCodeModel.name,
                  style: Theme.of(context).textTheme.bodySmall,
                ),
              ),
            ],
          ),
        ),
        const SizedBox(width: 10),
        Expanded(
          child: WeatherStatusIconWidget(
            iconData: weatherCodeModel.iconData,
            iconSize: 250,
            sizedBoxWidth: 170,
            shadowOn: true,
            paddingLeft: 20,
          ),
        )
      ],
    );

  }
  @override
  void deactivate(){
    _dailySpecialStream.cancel();
  }
}

/*
class HomeAppbarRowWidget extends StatelessWidget {
  const HomeAppbarRowWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    WeatherProvider weatherProvider = Provider.of<WeatherProvider>(context);
    WeatherModel weatherModel = weatherProvider.getLoadedWeather;
    List todayWeather = weatherProvider.todayWeather;

    WeatherCodeModel? weatherCodeModel =
        weatherProvider.getWeatherCode(todayWeather[0]);

    return Row(
      children: [
        Padding(
          padding: elementAlignment,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                weatherModel.timezone,
                style: Theme.of(context).textTheme.headlineMedium,
              ),
              Text(
                "32°C",
                style: Theme.of(context).textTheme.headlineLarge,
              ),
              Text(
                "55%",
                style: Theme.of(context).textTheme.headlineLarge,
              ),
              Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                decoration: BoxDecoration(
                  color: mainColors.lightContainerBG,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Text(
                  weatherCodeModel.name,
                  style: Theme.of(context).textTheme.bodySmall,
                ),
              ),
            ],
          ),
        ),
        const SizedBox(width: 10),
        Expanded(
          child: WeatherStatusIconWidget(
            iconData: weatherCodeModel.iconData,
            iconSize: 250,
            sizedBoxWidth: 170,
            shadowOn: true,
            paddingLeft: 20,
          ),
        )
      ],
    );
  }
}
*/