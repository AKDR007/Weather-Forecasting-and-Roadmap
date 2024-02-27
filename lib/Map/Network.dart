import 'package:geolocator/geolocator.dart';

class Network {
  double Lat = 0;
  double Long = 0;

  Future<void> getCurrentLocation() async {
    try {
      Position POS = await Geolocator.getCurrentPosition(
          desiredAccuracy: LocationAccuracy.best);
      Lat = POS.latitude;
      Long = POS.longitude;
    } catch (E) {
      print(E);
    }
  }
}
