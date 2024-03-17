 /*
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
    //give me the wether Data
    _latitude = position.latitude;
    _longitude = position.longitude;

    //now fetch the data using position
    Uri url = Uri.parse(
        'https://api.openweatherma.org/data/2.5/weather?lat=$_latitude&lon=$_longitude&exclude={alerts}&appid=$kApiKey');
    isWebsiteReachable(url).then((isrechableOK) async {
      if (isrechableOK) {
        try {
          debugPrint('before');
          http.Response response = await http.get(url);

          debugPrint('after');
          if (response.statusCode == 200) {
            debugPrint('successful fetching');
            debugPrint(
                'successful fetching : ${response.statusCode.toString()}');
            //debugPrint(response.body);
          } else {
            debugPrint('failed fetching : ${response.statusCode.toString()}');
            return Future.error(
                'not succeded${response.statusCode.toString()}');
          }
          // throw Error();
        } catch (error) {
          debugPrint('error caught: $error');
          throw Future.error('enable to fetch Data.');
        }
      } else {
        return Future.error("cannot reach data");
      }
    });
  }

//check if user have access to internet
  Future<bool> hasInternetAccess() async {
    final connectivityResult = await (Connectivity().checkConnectivity());
    return (connectivityResult == ConnectivityResult.mobile ||
        connectivityResult == ConnectivityResult.wifi);
  }

  //check if a website is reachable
  Future<bool> isWebsiteReachable(Uri url) async {
    try {
      final response = await http.head(url);
      return response.statusCode == 200;
    } catch (e) {
      return false;
    }
  }

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

 
 
 */
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
  // void getlocation() async {
  //   bool serviceEnabled;
  //   LocationPermission permission;

  //   // Test if location services are enabled.
  //   serviceEnabled = await Geolocator.isLocationServiceEnabled();
  //   if (!serviceEnabled) {
  //     debugPrint('service not enabeld');
  //     // Location services are not enabled don't continue
  //     // accessing the position and request users of the
  //     // App to enable the location services.

  //     return SnackBar(content: Text('please allow localisation permission'));
  //   }

  //   permission = await Geolocator.checkPermission();
  //   debugPrint(permission.toString());
  //   if (permission == LocationPermission.denied) {
  //     permission = await Geolocator.requestPermission();
  //     if (permission == LocationPermission.denied) {
  //       debugPrint('permission is DENIED');
  //       // Permissions are denied, next time you could try
  //       // requesting permissions again (this is also where
  //       // Android's shouldShowRequestPermissionRationale
  //       // returned true. According to Android guidelines
  //       // your App should show an explanatory UI now.
  //       //return Future.error('Location permissions are denied');
  //       //permission = await Geolocator.requestPermission();
  //       await Geolocator.openAppSettings();
  //       return SnackBar(content: Text('please allow localisation permission'));
  //       //
  //     }
  //   } else if (permission == LocationPermission.deniedForever) {
  //     debugPrint('permission is DENIED FOR EVER');
  //     // Permissions are denied forever, handle appropriately.
  //     // return Future.error(

  //     await Geolocator.openAppSettings();
  //      return SnackBar(content: Text('please allow localisation permission'));
  //   } else {
  //     Position position = await Geolocator.getCurrentPosition(
  //         desiredAccuracy: LocationAccuracy.low);
  //     debugPrint(position.toString());
  //     debugPrint('done');
  //     return SnackBar(content: Text(position.toString()));
  //   }
  //