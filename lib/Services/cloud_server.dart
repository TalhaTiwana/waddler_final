import 'dart:convert';

import 'package:waddler/Model/near_by_location.dart';
import 'package:http/http.dart' as http;
import 'package:waddler/Model/near_by_location_model.dart';

class CloudServer {
  // Future<List<NearByLocationModel>>
  Future<NearByLocationModel> fetchFromMapByNear(
      {double? lan, double? lat}) async {
    print("lat => $lat lan => $lan");
    var url =
        "https://maps.googleapis.com/maps/api/place/textsearch/json?query=day+care+center&location=$lat,$lan&fields=photos,formatted_address,name,opening_hours,icon,rating&radius=5000&key=AIzaSyBkYmRni1_L_2IqaTG-6nNWAOhINbMKHcg";

    var finalUrl = Uri.parse(url);

    var response = await http.get(finalUrl);
    var values = jsonDecode(response.body);

    final List result = values['results'];

    print('length => ${result.length}');
    return NearByLocationModel.fromJson(values);
  }
}
