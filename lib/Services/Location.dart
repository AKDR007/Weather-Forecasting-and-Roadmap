import 'package:geolocator/geolocator.dart';

class Location {
  double lat = 0;
  double long = 0;

  Future<void> getCurrentLocation() async {
    try {
      Position POS = await Geolocator.getCurrentPosition(
          desiredAccuracy: LocationAccuracy.bestForNavigation);
      lat = POS.latitude;
      long = POS.longitude;
    } catch (E) {
      print(E);
    }
  }
}
