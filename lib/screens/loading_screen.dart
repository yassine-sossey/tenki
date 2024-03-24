import 'package:flutter/material.dart';
import 'package:tenki/screens/city_screen.dart';
import 'package:tenki/screens/tenki_brain.dart';

class LoadingScreen extends StatefulWidget {
  const LoadingScreen({Key? key}) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _LoadingScreenState createState() => _LoadingScreenState();
}

class _LoadingScreenState extends State<LoadingScreen> {
  TenkiBrain brain = TenkiBrain();
  bool fetchingOngoing = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            if (fetchingOngoing == true) const CircularProgressIndicator(),
            const SizedBox(height: 20),
            if (fetchingOngoing == true)
              const Text(
                'Fetching Weather Data...',
                style: TextStyle(fontSize: 18),
              ),
            ElevatedButton(
                onPressed: () {
                  setState(() {
                    fetchingOngoing = true;
                  });
                  brain.getUserWeatherData(context);
                },
                child: const Text('use my location')),
            ElevatedButton(
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const CityScreen()));
                },
                child: const Text('use my city name'))
          ],
        ),
      ),
    );
  }
}
