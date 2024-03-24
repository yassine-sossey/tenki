import 'package:flutter/material.dart';
import 'package:tenki/utilities/constants.dart';
import 'package:tenki/screens/tenki_brain.dart';

class CityScreen extends StatefulWidget {
  const CityScreen({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _CityScreenState createState() => _CityScreenState();
}

class _CityScreenState extends State<CityScreen> {
  String cityName = '';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('images/city_background.jpg'),
            fit: BoxFit.cover,
          ),
        ),
        constraints: const BoxConstraints.expand(),
        child: SafeArea(
          child: Column(
            children: <Widget>[
              Align(
                alignment: Alignment.topLeft,
                child: TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: const Icon(
                    Icons.arrow_back_ios,
                    size: 50.0,
                    color: Colors.white,
                  ),
                ),
              ),
              Container(
                padding: const EdgeInsets.all(20.0),
                child: TextField(
                  onChanged: (value) {
                    setState(() {
                      cityName = value;
                    });
                  },
                  style: const TextStyle(color: Colors.white),
                  cursorColor: Colors.white,
                  decoration: const InputDecoration(
                      focusedBorder: OutlineInputBorder(
                          borderSide:
                              BorderSide(color: Colors.black, width: 2)),
                      icon: Icon(
                        Icons.location_city,
                        color: Colors.amber,
                      ),
                      filled: true,
                      hintStyle: TextStyle(color: Colors.grey, fontSize: 15),
                      hintText: 'please input a city name',
                      focusColor: Colors.yellow,
                      hoverColor: Colors.green,
                      fillColor: Color.fromARGB(255, 228, 210, 156),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(10.0)),
                      )),
                ),
              ),
              TextButton(
                onPressed: () {
                  TenkiBrain brain = TenkiBrain();
                  brain.getcityWeatherData(context, cityName);
                },
                child: const Text(
                  'Get Weather',
                  style: kButtonTextStyle,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
