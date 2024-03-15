import 'dart:async';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
// import 'package:akdr_weather/Map/LocationService.dart';
import 'package:akdr_weather/Map/Network.dart';
import 'package:akdr_weather/Services/Weather.dart';

class GoogleMa extends StatefulWidget {
  GoogleMa({this.LocationWeather});
  final LocationWeather;
  @override
  State<GoogleMa> createState() => GoogleMaState();
} // googlesample LatLng(37.42796133580664, -122.085749655962),

class GoogleMaState extends State<GoogleMa> {
  WeatherModel weather = WeatherModel();

  static double ulat = 12.918017117282044;
  static double ulon = 79.28362359859021;

  double lat = 0;
  double long = 0;

  static double lati = 0;
  static double lon = 0;

  @override
  void initState() {
    super.initState();
    updateUI(widget.LocationWeather);
    getNetwork();
  }

  void getNetwork() async {
    Network network = Network();
    await network.getCurrentLocation();

    print(network.Lat);
    print(network.Long);
  }

  void updateUI(dynamic weatherData) {
    setState(() {
      lat = weatherData['coord']['lat'];
      lon = weatherData['coord']['lon'];
      lati = lat;
      long = lon;
    });
  } // user location 12.918017117282044, 79.28362359859021

  Completer<GoogleMapController> _controller = Completer();
  TextEditingController _searchController = TextEditingController();
  final CameraPosition _kGooglePlex = CameraPosition(
    target: LatLng(ulat, ulon),
    zoom: 14.4746,
  );
  final Marker _kgooglePlexMarker = Marker(
    markerId: MarkerId('kGooglePlex'),
    infoWindow: InfoWindow(title: 'Your Location'),
    icon: BitmapDescriptor.defaultMarker,
    position: LatLng(ulat, ulon),
  );
  final CameraPosition _kLake = CameraPosition(
      bearing: 192.8334901395799,
      target: LatLng(ulat, ulon),
      tilt: 59.440717697143555,
      zoom: 19.151926040649414);
  Marker get _klakeMarker => Marker(
        markerId: MarkerId('kLakeMarker'),
        infoWindow: InfoWindow(title: 'Destination'),
        icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueBlue),
        position: LatLng(lat, lon),
      );
  static final Polyline _kpolyline = Polyline(
    polylineId: PolylineId('_kpolyline'),
    points: [
      LatLng(ulat, ulon),
      LatLng(lati, lon),
    ],
    width: 5,
  );
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: AppBar(
        title: Text('Google Map'),
      ),
      body: Column(
        children: [
          Row(
            children: [
              Expanded(
                child: Text(
                    "OOPs,We didn't purchased API so,we can't show clear route, you can CheckOut in GoogleMap, ThankYou!"),
              ),
            ],
          ),
          Expanded(
            child: GoogleMap(
              mapType: MapType.normal,
              markers: {
                _kgooglePlexMarker,
                _klakeMarker,
              },
              polylines: {
                _kpolyline,
              }, // polygons: {_kpolygon},
              initialCameraPosition: _kGooglePlex,
              onMapCreated: (GoogleMapController controller) {
                _controller.complete(controller);
              },
            ),
          )
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: _goToTheLake,
        label: Text('Your Location!'),
        icon: Icon(Icons.directions_boat),
      ),
    );
  }

  void _goToTheLake() async {
    final GoogleMapController controller = await _controller.future;
    controller.animateCamera(CameraUpdate.newCameraPosition(_kLake));
  }
}
