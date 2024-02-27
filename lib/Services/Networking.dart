import 'package:http/http.dart' as http;
import 'dart:convert';

class NetworkHelper {
  NetworkHelper(this.url);
  final String url;
  Future getData() async {
    http.Response Res = await http.get(Uri.parse(url));
    if (Res.statusCode == 200) {
      String Data = Res.body;
      var Decode = jsonDecode(Data);
      //print(Decode);
      return Decode;
    } else {
      // print(Res.statusCode);
    }
  }
}
