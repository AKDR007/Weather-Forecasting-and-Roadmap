import 'package:http/http.dart' as http;
import 'dart:convert' as convert;

class LocationService {
  final String Key = 'Your Google API Key For Maps';

  Future<String> getPlaceId(String input) async {
    final String url =
        'https://maps.googleapis.com/maps/api/place/findplacefromtext/json?input=$input&inputtype=textquery&key=$Key';
    var response = await http.get(Uri.parse(url));
    var json = convert.jsonDecode(response
        .body); // var placedId = json['candidates']['place_id'] as String;
    var placedId = json['candidates'][0]['place_id'] as String;
    print(placedId);
    return placedId;
  }
}
