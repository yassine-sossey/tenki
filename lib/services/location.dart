import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:geolocator/geolocator.dart';

// get location of user
class Location {
  //check if user have access to internet
  Future<bool> hasInternetAccess() async {
    final connectivityResult = await (Connectivity().checkConnectivity());
    return (connectivityResult == ConnectivityResult.mobile ||
        connectivityResult == ConnectivityResult.wifi);
  }

//Get user position
  Future<Position> getPosition() async {
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
    return position;
  }
}
