import 'package:flutter/cupertino.dart';

import 'package:flutter_google_places/flutter_google_places.dart';
import 'package:google_api_headers/google_api_headers.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:google_maps_webservice/places.dart';
import 'package:http/http.dart' as http;
import 'dart:convert' as convert;
import 'package:google_place/google_place.dart';
import 'package:go_dutch/place_services.dart';
import 'package:go_dutch/place_search.dart';
import 'package:go_dutch/place.dart';
import 'dart:async';
import 'package:go_dutch/place.dart';

final placesService = PlaceService();

class appbloc with ChangeNotifier {
  late Place selectedLocationStatic;
  var searchResults = [];
  String Name = "";
  StreamController<Place> selectedLocation = StreamController<Place>();
  searchPlaces(String searchterm) async {
    searchResults = await placesService.findPlace(searchterm);
    notifyListeners();
  }

  clearResults() {
    searchResults.clear();
  }

  setSelectedLocation(String placeId) async {
    var sLocation = await placesService.getPlace(placeId);
    selectedLocation.add(sLocation);
    selectedLocationStatic = sLocation;
    searchResults.clear();
    notifyListeners();
  }

  getNames(LatLng param) async {
    Name = await getNames(param);
    notifyListeners();
  }

  @override
  void dispose() {
    selectedLocation.close();
    super.dispose();
  }
}
