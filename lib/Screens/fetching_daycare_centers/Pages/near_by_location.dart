import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:maps_launcher/maps_launcher.dart';
import 'package:waddler/Services/cloud_server.dart';
import 'package:waddler/Style/colors.dart';

class NearByLocation extends StatefulWidget {
  final lat;
  final lon;

  const NearByLocation({Key? key, this.lon, this.lat}) : super(key: key);

  @override
  _NearByLocationState createState() => _NearByLocationState();
}

class _NearByLocationState extends State<NearByLocation> {
  @override
  void initState() {
    super.initState();
    CloudServer().fetchFromMapByNear(lat: widget.lat, lan: widget.lon);
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          backgroundColor: primaryDarkClr,
          title: Text("Daycare centers under 5km",
              style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.w500,
                  fontSize: size.width * 0.05)),
        ),
        body: Column(
          children: [
            Expanded(
                child: Container(
              width: size.width,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                    begin: const FractionalOffset(0.0, 0.0),
                    end: const FractionalOffset(2.0, 2.0),
                    colors: [
                      primaryClr.withOpacity(0.2),
                      primaryClr.withOpacity(0.2)
                    ]),
              ),
              child: FutureBuilder(
                future: CloudServer()
                    .fetchFromMapByNear(lat: widget.lat, lan: widget.lon),
                builder: (_, AsyncSnapshot snapshot) {
                  if (snapshot.hasData) {
                    return ListView.builder(
                        itemCount: snapshot.data.results.length,
                        itemBuilder: (_, index) {
                          return InkWell(
                            onTap: () {
                              showBottomSheetCustom(
                                  context: context,
                                  size: size,
                                  rating: snapshot.data.results![index].rating
                                      .toString(),
                                  address: snapshot
                                      .data.results![index].formattedAddress
                                      .toString(),
                                  name: snapshot.data.results![index].name,
                                  totalRating: snapshot
                                      .data.results![index].userRatingsTotal
                                      .toString(),
                                  phoneNumber: '');
                            },
                            child: Container(
                              margin: EdgeInsets.symmetric(
                                  horizontal: size.width * 0.05,
                                  vertical: size.height * 0.02),
                              width: size.width * 0.9,
                              height: snapshot
                                          .data.results![index].formattedAddress
                                          .toString()
                                          .length >
                                      80
                                  ? size.height * 0.4
                                  : size.height * 0.35,
                              child: Column(
                                children: [
                                  Container(
                                    alignment: Alignment.topRight,
                                    width: size.width * 0.9,
                                    height: size.height * 0.27,
                                    decoration: BoxDecoration(
                                      image: const DecorationImage(
                                          fit: BoxFit.fill,
                                          image: AssetImage(
                                              "images/dayCareCenter.jpg")),
                                      borderRadius: BorderRadius.circular(20),
                                    ),
                                    child: Container(
                                      padding: EdgeInsets.only(
                                          top: size.height * 0.01,
                                          right: size.width * 0.02),
                                      alignment: Alignment.topRight,
                                      width: size.width * 0.9,
                                      height: size.height * 0.25,
                                      decoration: BoxDecoration(
                                        color: Colors.black.withOpacity(0.1),
                                        borderRadius: BorderRadius.circular(20),
                                      ),
                                      child: Image.network(
                                        "${snapshot.data.results![index].icon}",
                                        scale: 2,
                                      ),
                                    ),
                                  ),
                                  Container(
                                    margin: EdgeInsets.only(
                                        top: size.height * 0.008),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Container(
                                              width: size.width * 0.7,
                                              child: RichText(
                                                text: TextSpan(
                                                    text: "Name: ",
                                                    style: TextStyle(
                                                        fontSize:
                                                            size.width * 0.033,
                                                        color:
                                                            Colors.grey[700]),
                                                    children: [
                                                      TextSpan(
                                                          text:
                                                              "${snapshot.data.results![index].name}",
                                                          style: TextStyle(
                                                            fontSize:
                                                                size.width *
                                                                    0.033,
                                                            color: Colors.black,
                                                            fontWeight:
                                                                FontWeight.w700,
                                                            letterSpacing: 0.8,
                                                          ))
                                                    ]),
                                                overflow: TextOverflow.ellipsis,
                                              ),
                                            ),
                                            Container(
                                              child: Row(
                                                children: [
                                                  Icon(
                                                    Icons.star,
                                                    color: Colors.blue,
                                                    size: size.width * 0.04,
                                                  ),
                                                  Text(
                                                    "${snapshot.data.results![index].rating.toString()} ",
                                                    style: TextStyle(
                                                        color: Colors.black,
                                                        fontWeight:
                                                            FontWeight.w800,
                                                        fontSize:
                                                            size.width * 0.03),
                                                  ),
                                                  Text(
                                                      "(${snapshot.data.results![index].userRatingsTotal})")
                                                ],
                                              ),
                                            )
                                          ],
                                        ),
                                        Container(
                                          margin: EdgeInsets.only(
                                              top: size.height * 0.006),
                                          width: size.width * 0.9,
                                          child: RichText(
                                            text: TextSpan(
                                                text: "Address: ",
                                                style: TextStyle(
                                                    fontSize:
                                                        size.width * 0.033,
                                                    color: Colors.grey[700]),
                                                children: [
                                                  TextSpan(
                                                      text:
                                                          "${snapshot.data.results![index].formattedAddress}",
                                                      style: TextStyle(
                                                        fontSize:
                                                            size.width * 0.033,
                                                        color: Colors.black87,
                                                        fontWeight:
                                                            FontWeight.w500,
                                                        letterSpacing: 0.8,
                                                      ))
                                                ]),
                                          ),
                                        ),
                                      ],
                                    ),
                                  )
                                ],
                              ),
                            ),
                          );
                        });
                  } else {
                    print("error ");
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                },
              ),
            ))
          ],
        ),
      ),
    );
  }

  showBottomSheetCustom({
    required BuildContext context,
    required Size size,
    required String address,
    required String name,
    required String phoneNumber,
    required String totalRating,
    required String rating,
  }) {
    return showModalBottomSheet(
        context: context,
        builder: (BuildContext buildContext) {
          return BottomSheet(
            rating: rating,
            name: name,
            address: address,
            totalRating: totalRating,
          );
        });
  }
}

class BottomSheet extends StatefulWidget {
  final name;
  final address;
  final rating;
  final totalRating;
  const BottomSheet(
      {Key? key, this.name, this.address, this.rating, this.totalRating})
      : super(key: key);

  @override
  _BottomSheetState createState() => _BottomSheetState();
}

class _BottomSheetState extends State<BottomSheet> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return InkWell(
      onTap: () {
        MapsLauncher.launchQuery(widget.address);
      },
      child: Container(
        padding: EdgeInsets.only(
            top: size.height * 0.02,
            left: size.width * 0.03,
            right: size.width * 0.03,
            bottom: size.height * 0.02),
        width: size.width,
        height: size.height * 0.35,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                    width: size.width,
                    alignment: Alignment.center,
                    child: Text(
                      "Details",
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: size.width * 0.05,
                          fontWeight: FontWeight.w800),
                    )),
                Container(
                  margin: EdgeInsets.only(top: size.height * 0.02),
                  child: RichText(
                    text: TextSpan(
                        text: "Place Name:\n",
                        style: TextStyle(
                          color: Colors.grey[900],
                        ),
                        children: [
                          TextSpan(
                              text: "${widget.name}",
                              style: TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.w500,
                                  fontSize: size.width * 0.04))
                        ]),
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(top: size.height * 0.02),
                  child: RichText(
                    text: TextSpan(
                        text: "Place Address:\n",
                        style: TextStyle(
                          color: Colors.grey[900],
                        ),
                        children: [
                          TextSpan(
                              text: "${widget.address}",
                              style: TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.w500,
                                  fontSize: size.width * 0.04))
                        ]),
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(top: size.height * 0.02),
                  child: RichText(
                    text: TextSpan(
                        text: "Phone number:\n",
                        style: TextStyle(
                          color: Colors.grey[900],
                        ),
                        children: [
                          TextSpan(
                              text: "",
                              style: TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.w500,
                                  fontSize: size.width * 0.04))
                        ]),
                  ),
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Container(
                  child: Row(
                    children: [
                      Icon(
                        Icons.star,
                        color: Colors.blue,
                        size: size.width * 0.04,
                      ),
                      Text(
                        "${widget.rating} ",
                        style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.w800,
                            fontSize: size.width * 0.03),
                      ),
                      Text("(${widget.totalRating})")
                    ],
                  ),
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}
