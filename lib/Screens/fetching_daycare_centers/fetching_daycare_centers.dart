import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:google_maps_place_picker/google_maps_place_picker.dart';
import 'package:waddler/Common/common_functions.dart';
import 'package:waddler/Services/cloud_server.dart';
import 'package:waddler/Style/colors.dart';
import 'Pages/result_sheet.dart';
import 'Pages/near_by_location.dart';
import 'Pages/search_by_rating.dart';

class FDC extends StatefulWidget {
  const FDC({Key? key}) : super(key: key);

  @override
  _FDCState createState() => _FDCState();
}

class _FDCState extends State<FDC> {
  String cloudKey = "AIzaSyAiYXBLE3LuMDpBqsr0staw-qhAxSfuMUY";
  late Position position;
  late LatLng _latLng;
  var image;
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return SafeArea(
        child: Scaffold(
            extendBodyBehindAppBar: true,
            appBar: AppBar(
              leading: IconButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                icon: const Icon(
                  Icons.arrow_back,
                  color: Colors.blue,
                ),
              ),
              elevation: 0,
              backgroundColor: Colors.transparent,
            ),
            body: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(
                    width: size.width * 0.8,
                    child: Image.asset(
                      'images/bgImg.png',
                    ),
                  ),
                  Container(
                    width: size.width,
                    padding: EdgeInsets.symmetric(vertical: size.height * 0.03),
                    decoration: BoxDecoration(
                        color: Colors.blue.shade100.withOpacity(0.5)),
                    child: Column(
                      children: [
                        Text(
                          "Look no further",
                          style: GoogleFonts.cabin(
                              color: Colors.black,
                              fontSize: size.width * 0.044),
                        ),
                        SizedBox(
                          height: size.height * 0.01,
                        ),
                        Text(
                          'Find the best daycare centers near you',
                          style: const TextStyle(
                            color: Colors.black,
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: size.height * 0.02,
                  ),
                  Text(
                    'Choose an option',
                    style: TextStyle(
                      fontSize: size.width * 0.055,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  InkWell(
                    onTap: () async {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => PlacePicker(
                            hintText: "Search DayCare center here..",
                            apiKey:
                                "AIzaSyAiYXBLE3LuMDpBqsr0staw-qhAxSfuMUY", // Put YOUR OWN KEY here.
                            onPlacePicked: (result) {
                              Navigator.of(context).pop();
                              print("\n\n");
                              print(
                                  "Adress ${result.formattedAddress} \n Phone number:${result.internationalPhoneNumber} ${result.formattedPhoneNumber}\n"
                                  "Place name: ${result.name} ${result.rating}\n"
                                  "URL: ${result.url}\n"
                                  "Reviews: ${result.reviews![0].text}\n"
                                  "official website: ${result.website}\n"
                                  "Scope: ${result.scope}\n");
                              settingModalBottomSheetAddress(
                                name: result.name,
                                size: size,
                                context: context,
                                address: result.formattedAddress,
                                phoneNumber: result.internationalPhoneNumber ??
                                    result.formattedPhoneNumber,
                                reviews: result.reviews,
                                rating: result.rating,
                                url: result.url,
                                website: result.website.toString(),
                              );
                            },
                            useCurrentLocation: true,
                            initialPosition: const LatLng(33.6844, 73.0479),
                          ),
                        ),
                      );
                    },
                    child: Container(
                      margin: const EdgeInsets.only(top: 10, bottom: 3),
                      width: size.width * 0.9,
                      padding:
                          EdgeInsets.symmetric(vertical: size.height * 0.02),
                      decoration:
                          BoxDecoration(color: Colors.white, boxShadow: [
                        BoxShadow(
                            color: Colors.grey.shade400,
                            spreadRadius: 2,
                            offset: const Offset(1, 1),
                            blurRadius: 2)
                      ]),
                      child: Column(
                        children: [
                          Icon(
                            Icons.location_pin,
                            color: const Color(0xff1693bf),
                            size: size.width * 0.1,
                          ),
                          const SizedBox(
                            height: 5,
                          ),
                          Text(
                            'Search by Location',
                            style: TextStyle(
                              color: Color(0xff1693bf),
                              fontSize: size.width * 0.037,
                              fontWeight: FontWeight.bold,
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                  InkWell(
                    onTap: () async {
                      Geolocator.getCurrentPosition(
                              desiredAccuracy: LocationAccuracy.high)
                          .then((value) {
                        position = value;
                      }).whenComplete(() async {
                        screenPush(
                            context,
                            NearByLocation(
                                lat: position.latitude,
                                lon: position.longitude));
                      });
                    },
                    child: Container(
                      margin: const EdgeInsets.only(top: 10, bottom: 3),
                      width: size.width * 0.9,
                      padding:
                          EdgeInsets.symmetric(vertical: size.height * 0.02),
                      decoration:
                          BoxDecoration(color: Colors.white, boxShadow: [
                        BoxShadow(
                            color: Colors.grey.shade400,
                            spreadRadius: 2,
                            offset: const Offset(1, 1),
                            blurRadius: 2)
                      ]),
                      child: Column(
                        children: [
                          Icon(
                            Icons.my_location_rounded,
                            color: const Color(0xff1693bf),
                            size: size.width * 0.1,
                          ),
                          const SizedBox(
                            height: 5,
                          ),
                          Text(
                            'Automatic nearby search',
                            style: TextStyle(
                              color: const Color(0xff1693bf),
                              fontSize: size.width * 0.037,
                              fontWeight: FontWeight.bold,
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                  InkWell(
                    onTap: () {
                      Geolocator.getCurrentPosition(
                              desiredAccuracy: LocationAccuracy.high)
                          .then((value) {
                        position = value;
                      }).whenComplete(() async {
                        CloudServer()
                            .fetchFromMapByNear(
                                lat: position.latitude, lan: position.longitude)
                            .then((value) {
                          value.results!.sort((a, b) => b.rating!.compareTo(a.rating as num));
                          screenPush(
                              context,
                              SearchByRating(
                                data: value.results as List<dynamic>,
                              ),
                          );
                        });
                      });
                    },
                    child: Container(
                      margin: const EdgeInsets.only(top: 10, bottom: 3),
                      width: size.width * 0.9,
                      padding:
                          EdgeInsets.symmetric(vertical: size.height * 0.02),
                      decoration:
                          BoxDecoration(color: Colors.white, boxShadow: [
                        BoxShadow(
                            color: Colors.grey.shade400,
                            spreadRadius: 2,
                            offset: const Offset(1, 1),
                            blurRadius: 2)
                      ]),
                      child: Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(
                                Icons.star_rate,
                                color: const Color(0xff1693bf),
                                size: size.width * 0.07,
                              ),
                              Icon(
                                Icons.star_rate,
                                color: const Color(0xff1693bf),
                                size: size.width * 0.07,
                              ),
                              Icon(
                                Icons.star_rate,
                                color: const Color(0xff1693bf),
                                size: size.width * 0.07,
                              ),
                              Icon(
                                Icons.star_rate,
                                color: const Color(0xff1693bf),
                                size: size.width * 0.07,
                              ),
                              Icon(
                                Icons.star_rate,
                                color: const Color(0xff1693bf),
                                size: size.width * 0.07,
                              ),
                            ],
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          Text(
                            'Sort by Rating',
                            style: TextStyle(
                              color: Color(0xff1693bf),
                              fontSize: size.width * 0.037,
                              fontWeight: FontWeight.bold,
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            )));
  }

  settingModalBottomSheetAddress(
      {required BuildContext context,
      required String website,
      required Size size,
      var reviews,
      var rating,
      var name,
      var address,
      var phoneNumber,
      var url}) {
    showModalBottomSheet(
        isScrollControlled: true,
        context: context,
        builder: (BuildContext buildContext) {
          return CustomBottomSheet(
            address: address,
            name: name,
            phoneNumber: phoneNumber,
            reviews: reviews,
            rating: rating,
            urlAddress: url,
            website: website,
          );
        });
  }
}
