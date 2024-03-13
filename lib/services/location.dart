import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:http/http.dart' as http;
import 'package:tenki/utilities/constants.dart';

// get location of user
class Location {
  late double latitude;
  late double longitude;
//Get user position
  Future<void> getPosition() async {
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
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        /// permission is denied by user
        return Future.error('Location permissions are denied.');
      }
    }
    if (permission == LocationPermission.deniedForever) {
      /// Permsiion is for ever denied by user
      return Future.error('Location permissions are permanently denied.');
    }

    /// all is ok, give me the position
    Position position = await Geolocator.getCurrentPosition();
    longitude = position.longitude;
    latitude = position.latitude;
    getData(lat: latitude, long: longitude);
  }

//get weather Data
  Future<void> getData({required double lat, required double long}) async {
    Uri url = Uri.parse(
        'https://api.openweathermap.org/data/2.5/weather?lat=$lat&lon=$long&exclude={alerts}&appid=$kApiKey');
    http.Response response = await http.get(url);
    debugPrint(response.body);
    //return response;
  }

//check if user have access to internet
  Future<bool> hasInternetAccess() async {
    //var connectivityResult = Connectivity().checkConnectivity();
    final connectivityResult = await (Connectivity().checkConnectivity());
    return connectivityResult == ConnectivityResult.mobile ||
        connectivityResult == ConnectivityResult.wifi;
  }

  void getLocation(context) {
    hasInternetAccess().then((hasInternet) {
      //if user has access to internet
      if (hasInternet) {
        getPosition().then((position) {
          // Handle successful location retrieval
          debugPrint(
              'Location: longitude is $longitude\n latitude is $latitude ');
        }).catchError((error) {
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
        //no acess to internet ? so :
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text('No internet connection.'),
        ));
      }
    });
  }
}
