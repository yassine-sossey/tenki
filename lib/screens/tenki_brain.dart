import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:tenki/utilities/constants.dart';
import 'package:tenki/services/location.dart';
import 'package:tenki/services/networking.dart';
import 'package:tenki/screens/location_screen.dart';
import 'dart:math';

class TenkiBrain {
  Location location = Location();
  double generateRandomLatitude() {
    // Latitude ranges from -90 to +90
    Random random = Random();
    double min = -90;
    double max = 90;
    return min + random.nextDouble() * (max - min);
  }

  double generateRandomLongitude() {
    // Longitude ranges from -180 to +180
    Random random = Random();
    double min = -180;
    double max = 180;
    return min + random.nextDouble() * (max - min);
  }

  //let's use all this method to have users weather data
  void getUserWeatherData(context) {
    //check if user has internet
    location.hasInternetAccess().then(
      (interntOK) {
        if (interntOK) {
          location.getPosition().then((position) {
            // double latitude = generateRandomLatitude();
            // double longitude = generateRandomLongitude();
            double latitude = position.latitude;
            double longitude = position.longitude;
            //url of weather data using current position
            Uri url = Uri.parse(
                'https://api.openweathermap.org/data/2.5/weather?lat=$latitude&lon=$longitude&exclude={alerts}&appid=$kApiKey&units=metric');

            NetworkingSolider net = NetworkingSolider(url);
            //fetch data from url
            net.fetchfromwebsite().then((data) {
              //all data are OK to display the location screen
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: ((context) => LocationScreen(
                            data: data,
                          ))));
            }).catchError((error) {
              // Handle errors
              ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                content: Text(error.toString()),
              ));
            });
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
          ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
            content: Text("no internet access"),
          ));
        }
      },
    );
  }

//get userDatabased on city name
  void getcityWeatherData(context, String cityName) {
    //check if user has internet
    location.hasInternetAccess().then(
      (interntOK) {
        if (interntOK) {
          //url of weather data using current position
          Uri url = Uri.parse(
              'https://api.openweathermap.org/data/2.5/weather?q=$cityName&exclude={alerts}&appid=$kApiKey&units=metric');

          NetworkingSolider net = NetworkingSolider(url);
          //fetch data from url
          net.fetchfromwebsite().then((data) {
            //all data are OK to display the location screen
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: ((context) => LocationScreen(
                          data: data,
                        ))));
          }).catchError((error) {
            // Handle errors
            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
              content: Text(error.toString()),
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
