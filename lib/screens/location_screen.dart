import 'package:flutter/material.dart';
import 'package:tenki/screens/loading_screen.dart';
import 'package:tenki/utilities/constants.dart';
import 'package:tenki/services/weather.dart';

class LocationScreen extends StatefulWidget {
  final dynamic data;

  const LocationScreen({super.key, required this.data});

  @override
  // ignore: library_private_types_in_public_api
  _LocationScreenState createState() => _LocationScreenState();
}

class _LocationScreenState extends State<LocationScreen> {
  WeatherModel weatherModel = WeatherModel();
  late int condition;
  late int temp;
  late String city;
  late String weatherMessage;
  late String weatherIcon;

  @override
  Widget build(BuildContext context) {
    condition = widget.data['weather'][0]['id'];
    temp = widget.data['main']['temp'].toInt();
    city = widget.data['name'];
    weatherMessage = weatherModel.getMessage(temp);
    weatherIcon = weatherModel.getWeatherIcon(condition);
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: const AssetImage('images/location_background.jpg'),
            fit: BoxFit.cover,
            colorFilter: ColorFilter.mode(
                Colors.white.withOpacity(0.8), BlendMode.dstATop),
          ),
        ),
        constraints: const BoxConstraints.expand(),
        child: SafeArea(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  TextButton(
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: ((context) => const LoadingScreen())));
                    },
                    child: const Icon(
                      Icons.home,
                      color: Colors.black,
                      size: 50.0,
                    ),
                  ),
                ],
              ),
              Container(
                alignment: Alignment.center,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text(
                      '$temp°',
                      style: kTempTextStyle,
                    ),
                    Text(
                      weatherIcon,
                      style: kConditionTextStyle,
                    ),
                  ],
                ),
              ),
              Container(
                alignment: Alignment.center,
                child: Text(
                  "$weatherMessage in $city",
                  textAlign: TextAlign.center,
                  style: kMessageTextStyle,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
