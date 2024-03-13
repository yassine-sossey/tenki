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