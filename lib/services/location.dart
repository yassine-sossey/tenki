import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:http/http.dart' as http;
import 'package:tenki/utilities/constants.dart';

// get location of user
class Location {
  late double _latitude;
  late double _longitude;
//Get user position
  Future<void> fetchWeatherData() async {
    bool serviceEnabled;
    LocationPermission permission;

    /// Check if GPS is enabeld
    serviceEnabled = await Geolocator.isLocationServiceEnabled();

    if (!serviceEnabled) {
      //throw 'Location services are disabled.';
      return Future.error('Location services are disabled.');
    }

    /// Check for permission of using localisation
    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      //permisison is denied so request it.
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        /// permission is denied again by user
        return Future.error('Location permissions are denied.');
      }
    }
    if (permission == LocationPermission.deniedForever) {
      /// Permsiion is for ever denied by user
      return Future.error('Location permissions are permanently denied.');
    }

    /// all is ok, give me the position
    Position position = await Geolocator.getCurrentPosition();
    //give me the wether Data
    _latitude = position.latitude;
    _longitude = position.longitude;

    //now fetch the data using position
    Uri url = Uri.parse(
        'https://api.openweathermap.org/data/2.5/weather?lat=$_latitude&lon=$_longitude&exclude={alerts}&appid=$kApiKey');

    http.Response response = await http.get(url);

    if (response.statusCode == 200) {
      debugPrint('successful fetching');
      debugPrint('successful fetching : ${response.statusCode.toString()}');
      //debugPrint(response.body);
    } else {
      debugPrint('failed fetching : ${response.statusCode.toString()}');
      return Future.error(
          'Error ${response.statusCode.toString()} failed to reach Data');
    }
  }

//check if user have access to internet
  Future<bool> hasInternetAccess() async {
    final connectivityResult = await (Connectivity().checkConnectivity());
    return (connectivityResult == ConnectivityResult.mobile ||
        connectivityResult == ConnectivityResult.wifi);
  }

//let's use all this method to have users weather data
  void getLocation(context) {
    hasInternetAccess().then(
      (interntOK) {
        if (interntOK) {
          fetchWeatherData().catchError((error) {
            // Handle errors
            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
              content: Text(error.toString()),
              //only when permission permanently denied go to settings
              action: error.toString() ==
                      'Location permissions are permanently denied.'
                  ? SnackBarAction(
                      label: "give Permission",
                      textColor: Colors.amber,
                      onPressed: () => Geolocator.openAppSettings())
                  : null,
            ));
          });
        } else {
          ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
            content: Text("no internet access"),
          ));
        }
      },
    );
  }
}
