import 'dart:convert';

import 'package:http/http.dart' as http;

const GOOGLE_API_KEY = 'AIzaSyBkIxHiNQOhcseoyUiSGJsLwteeSb3UXXo';

class LocationHelper {
  static String getLocationPreviewImage({double latitude, double longitude}) {
    return 'https://maps.googleapis.com/maps/api/staticmap?center=$latitude,$longitude&zoom=16&size=600x250&maptype=roadmap&markers=color:red%7Alabel:C%7C$latitude,$longitude&key=$GOOGLE_API_KEY';
  }
  // convert lat lng to address using http & geocoding api
  static Future<String> getPlaceAddress(double lat, double lng) async {
    final url = 'https://maps.googleapis.com/maps/api/geocode/json?latlng=$lat,$lng&key=$GOOGLE_API_KEY';
    final response = await http.get(url);
    return json.decode(response.body)['results'][0]['formatted_address'];


  }
}