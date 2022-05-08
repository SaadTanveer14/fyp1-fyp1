import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:http/http.dart' as http;
import 'dart:convert' as convert;
import 'place_search.dart';
import 'place.dart';

class PlaceService {
  var res;
  dynamic json;
  Future<List<Place_Search>> findPlace(String placeName) async {
    String mapKey = "AIzaSyArtrJGGyuWasmlZ1rcmovSoCkl7zJWgIE";
    String autoCompleteUrl =
        "https://maps.googleapis.com/maps/api/place/autocomplete/json?input=$placeName&key=$mapKey&sessiontoken=1234567890&components=country:pk";

    res = await http.get(Uri.parse(autoCompleteUrl));

    json = convert.jsonDecode(res.body);
    // so now json is in the format u can see on web by search autocomplete url on browser
    for (var x = 0; x < json['predictions'].length; x++) {
      print(json['predictions'][x]['description']);
    }
    var jsonResults = json['predictions'] as List;
    return jsonResults.map((place) => Place_Search.fromJson(place)).toList();
  }

  void getName(LatLng param) async {
    String mapKey = "AIzaSyArtrJGGyuWasmlZ1rcmovSoCkl7zJWgIE";
    String autoCompleteUrl =
        "https://maps.googleapis.com/maps/api/geocode/json?latlng=$param&key=$mapKey";

    res = await http.get(Uri.parse(autoCompleteUrl));
    json = convert.jsonDecode(res.body);
    print(json);
  }

  Future<void> getDirection(String origin, String destination) async {
    String mapKey = "AIzaSyArtrJGGyuWasmlZ1rcmovSoCkl7zJWgIE";
    String autoCompleteUrl =
        "https://maps.googleapis.com/maps/api/directions/json?origin=$origin&destination=$destination&key=$mapKey";
    //  https://maps.googleapis.com/maps/api/directions/json?origin=Islamabad&destination=Lahore&key=AIzaSyArtrJGGyuWasmlZ1rcmovSoCkl7zJWgIE

    res = await http.get(Uri.parse(autoCompleteUrl));

    json = convert.jsonDecode(res.body);
    // so now json is in the format u can see on web by search autocomplete url on browser

    print(json);
  }

  Future<Place> getPlace(String placeId) async {
    String mapKey = "AIzaSyArtrJGGyuWasmlZ1rcmovSoCkl7zJWgIE";
    String autoCompleteUrl =
        'https://maps.googleapis.com/maps/api/place/details/json?place_id=$placeId&key=$mapKey';

    res = await http.get(Uri.parse(autoCompleteUrl));

    json = convert.jsonDecode(res.body);
    // so now json is in the format u can see on web by search autocomplete url on browser
    var jsonResults = json['result'] as Map<String, dynamic>;
    return Place.fromJson(jsonResults);
  }
}
