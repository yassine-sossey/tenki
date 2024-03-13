import 'package:flutter/material.dart';
import 'package:tenki/services/location.dart';

class LoadingScreen extends StatefulWidget {
  const LoadingScreen({Key? key}) : super(key: key);

  @override
  _LoadingScreenState createState() => _LoadingScreenState();
}

class _LoadingScreenState extends State<LoadingScreen> {
  late double lat;
  late double lon;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: ElevatedButton(
          onPressed: () async {
            Location location = Location();
            location.getLocation(context);
          },
          child: const Text('Get my Location'),
        ),
      ),
    );
  }
}
