// // To parse this JSON data, do
// //
// //     final nearByLocationModel = nearByLocationModelFromJson(jsonString);
//
// import 'dart:convert';
//
// NearByLocationModel nearByLocationModelFromJson(String str) => NearByLocationModel.fromJson(json.decode(str));
//
// String nearByLocationModelToJson(NearByLocationModel data) => json.encode(data.toJson());
//
// class NearByLocationModel {
//   NearByLocationModel({
//     required this.businessStatus,
//     required this.formattedAddress,
//     required this.geometry,
//     required this.icon,
//     required this.name,
//     required this.placeId,
//     required this.plusCode,
//     required this.rating,
//     required this.reference,
//     required this.types,
//     required this.userRatingsTotal,
//   });
//
//   String businessStatus;
//   String formattedAddress;
//   Geometry geometry;
//   String icon;
//   String name;
//   String placeId;
//   PlusCode plusCode;
//   double rating;
//   String reference;
//   List<String> types;
//   int userRatingsTotal;
//
//   factory NearByLocationModel.fromJson(Map<String, dynamic> json) => NearByLocationModel(
//     businessStatus: json["business_status"],
//     formattedAddress: json["formatted_address"],
//     geometry: Geometry.fromJson(json["geometry"]),
//     icon: json["icon"],
//     name: json["name"],
//     placeId: json["place_id"],
//     plusCode: PlusCode.fromJson(json["plus_code"]),
//     rating: json["rating"].toDouble(),
//     reference: json["reference"],
//     types: List<String>.from(json["types"].map((x) => x)),
//     userRatingsTotal: json["user_ratings_total"],
//   );
//
//   Map<String, dynamic> toJson() => {
//     "business_status": businessStatus,
//     "formatted_address": formattedAddress,
//     "geometry": geometry.toJson(),
//     "icon": icon,
//     "name": name,
//     "place_id": placeId,
//     "plus_code": plusCode.toJson(),
//     "rating": rating,
//     "reference": reference,
//     "types": List<dynamic>.from(types.map((x) => x)),
//     "user_ratings_total": userRatingsTotal,
//   };
// }
//
// class Geometry {
//   Geometry({
//     required this.location,
//     required this.viewport,
//   });
//
//   Location location;
//   Viewport viewport;
//
//   factory Geometry.fromJson(Map<String, dynamic> json) => Geometry(
//     location: Location.fromJson(json["location"]),
//     viewport: Viewport.fromJson(json["viewport"]),
//   );
//
//   Map<String, dynamic> toJson() => {
//     "location": location.toJson(),
//     "viewport": viewport.toJson(),
//   };
// }
//
// class Location {
//   Location({
//     required this.lat,
//     required this.lng,
//   });
//
//   double lat;
//   double lng;
//
//   factory Location.fromJson(Map<String, dynamic> json) => Location(
//     lat: json["lat"].toDouble(),
//     lng: json["lng"].toDouble(),
//   );
//
//   Map<String, dynamic> toJson() => {
//     "lat": lat,
//     "lng": lng,
//   };
// }
//
// class Viewport {
//   Viewport({
//     required this.northeast,
//     required this.southwest,
//   });
//
//   Location northeast;
//   Location southwest;
//
//   factory Viewport.fromJson(Map<String, dynamic> json) => Viewport(
//     northeast: Location.fromJson(json["northeast"]),
//     southwest: Location.fromJson(json["southwest"]),
//   );
//
//   Map<String, dynamic> toJson() => {
//     "northeast": northeast.toJson(),
//     "southwest": southwest.toJson(),
//   };
// }
//
// class PlusCode {
//   PlusCode({
//     required this.compoundCode,
//     required this.globalCode,
//   });
//
//   String compoundCode;
//   String globalCode;
//
//   factory PlusCode.fromJson(Map<String, dynamic> json) => PlusCode(
//     compoundCode: json["compound_code"],
//     globalCode: json["global_code"],
//   );
//
//   Map<String, dynamic> toJson() => {
//     "compound_code": compoundCode,
//     "global_code": globalCode,
//   };
// }
