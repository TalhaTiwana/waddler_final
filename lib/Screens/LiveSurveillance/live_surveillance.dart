import 'dart:async';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:web_socket_channel/web_socket_channel.dart';

class Surveillance extends StatefulWidget {
  final WebSocketChannel channel;
  const Surveillance({Key? key, required this.channel}) : super(key: key);

  @override
  _LiveSurveillianceState createState() => _LiveSurveillianceState();
}

class _LiveSurveillianceState extends State<Surveillance> {
  final double videoWidth = 640;
  final double videoHeight = 480;

  double newVideoSizeWidth = 640;
  double newVideoSizeHeight = 480;

  late bool isLandscape;
  late String _timeString;

  var _globalKey = new GlobalKey();

  @override
  void initState() {
    super.initState();
    isLandscape = false;
  }

  @override
  void dispose() {
    widget.channel.sink.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: OrientationBuilder(builder: (context, orientation) {
        var screenWidth = MediaQuery.of(context).size.width;
        var screenHeight = MediaQuery.of(context).size.height;

        if (orientation == Orientation.portrait) {
          //screenWidth < screenHeight

          isLandscape = false;
          newVideoSizeWidth =
              screenWidth > videoWidth ? videoWidth : screenWidth;
          newVideoSizeHeight = videoHeight * newVideoSizeWidth / videoWidth;
        } else {
          isLandscape = true;
          newVideoSizeHeight =
              screenHeight > videoHeight ? videoHeight : screenHeight;
          newVideoSizeWidth = videoWidth * newVideoSizeHeight / videoHeight;
        }

        return Container(
          decoration: BoxDecoration(
            color: Colors.white,
          ),
          margin: EdgeInsets.only(top: size.height*0.25),
          height: double.infinity,
          width: double.infinity,
          alignment: Alignment.center,
          child: StreamBuilder(
            stream: widget.channel.stream,
            builder: (context,AsyncSnapshot snapshot) {
              if (!snapshot.hasData) {
                return const Center(
                  child: CircularProgressIndicator(
                    valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                  ),
                );
              } else {
                return Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Column(
                      children: <Widget>[
                        SizedBox(
                          height: isLandscape ? 0 : 30,
                        ),
                        Stack(
                          children: <Widget>[
                            RepaintBoundary(
                              key: _globalKey,
                              child: Image.memory(
                                snapshot.data,
                                gaplessPlayback: true,
                                width: newVideoSizeWidth,
                                height: newVideoSizeHeight,
                              ),
                            ),
                            Positioned.fill(
                                child: Align(
                              child: Column(
                                children: <Widget>[
                                  SizedBox(
                                    height: 16,
                                  ),
                                  Text(
                                    'ESP32\'s cam',
                                    style: TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.w300),
                                  ),
                                  SizedBox(
                                    height: 4,
                                  ),
                                  Text(
                                    'Live | $_timeString',
                                    style: TextStyle(
                                        fontSize: 12,
                                        fontWeight: FontWeight.w300),
                                  ),
                                ],
                              ),
                              alignment: Alignment.topCenter,
                            ))
                          ],
                        ),
                      ],
                    ),
                  ],
                );
              }
            },
          ),
        );
      }),
    );
  }
}
