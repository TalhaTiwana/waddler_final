import 'package:flutter/material.dart';
import 'package:maps_launcher/maps_launcher.dart';
import 'package:waddler/Style/colors.dart';

class CustomBottomSheet extends StatefulWidget {
  final List reviews;
  final rating;
  final address;
  final name;
  final phoneNumber;
  final urlAddress;
  final website;

  const CustomBottomSheet({Key? key, required this.reviews, this.rating, this.address, this.name, this.phoneNumber, this.urlAddress, this.website}) : super(key: key);

  @override
  _CustomBottomSheetState createState() => _CustomBottomSheetState();
}

class _CustomBottomSheetState extends State<CustomBottomSheet> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return InkWell(
      onTap: (){
        MapsLauncher.launchQuery(widget.address);

      },
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: size.width*0.05),
        width: size.width,
        height: size.height*.9,
        decoration: BoxDecoration(
            gradient: LinearGradient(
                begin: const FractionalOffset(0.0, 0.0),
                end: const FractionalOffset(2.0, 2.0),
                colors: [
                  primaryClr.withOpacity(0.5),
                  primaryClr.withOpacity(0.2)
                ]
            )
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              margin: EdgeInsets.only(top: size.height*0.03),
              child:Text("Searched Result",style: TextStyle(
                color: Colors.black,
                fontSize: size.width*0.07,
                fontWeight: FontWeight.w500,
              ),
              ),
            ),
            Container(
              margin: EdgeInsets.only(top: size.height*0.02),
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
                        fontSize: size.width*0.04
                      )
                    )
                  ]
                ),

              ),
            ),

            Container(
              margin: EdgeInsets.only(top: size.height*0.02),
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
                              fontSize: size.width*0.04
                          )
                      )
                    ]
                ),

              ),
            ),
            Container(
              margin: EdgeInsets.only(top: size.height*0.02),
              child: RichText(
                text: TextSpan(
                    text: "Phone number:\n",
                    style: TextStyle(
                      color: Colors.grey[900],
                    ),
                    children: [
                      TextSpan(
                          text: "${widget.phoneNumber??"N/A"}",
                          style: TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.w500,
                              fontSize: size.width*0.04
                          )
                      )
                    ]
                ),

              ),
            ),

            Container(
              margin: EdgeInsets.only(top: size.height*0.02),
              child: RichText(
                text: TextSpan(
                    text: "Web address:\n",
                    style: TextStyle(
                      color: Colors.grey[900],
                    ),
                    children: [
                      TextSpan(
                          text: "${widget.website??"N/A"}",
                          style: TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.w500,
                              fontSize: size.width*0.04
                          )
                      ),
                    ]
                ),

              ),
            ),

            Container(
              margin: EdgeInsets.only(top: size.height*0.02),
              child: RichText(
                text: TextSpan(
                    text: "Google Map:\n",
                    style: TextStyle(
                      color: Colors.grey[900],
                    ),
                    children: [
                      TextSpan(
                          text: "${widget.urlAddress??"N/A"}",
                          style: TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.w500,
                              fontSize: size.width*0.04
                          )
                      ),
                    ]
                ),

              ),
            ),
            Container(
              margin: EdgeInsets.only(top: size.height*0.02),
              child: RichText(
                text: TextSpan(
                    text: "Rating:\n",
                    style: TextStyle(
                      color: Colors.grey[900],
                    ),
                    children: [
                      TextSpan(
                          text: "${widget.rating??"N/A"}",
                          style: TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.w500,
                              fontSize: size.width*0.04
                          )
                      ),
                    ]
                ),

              ),
            ),
             SizedBox(
               height: size.height*0.02,
             ),
             Text( "Reviews:\n",
               style: TextStyle(
                 color: Colors.grey[900],
                 fontSize: size.width*0.05,
                 fontWeight: FontWeight.w800
               ),),
      //     Expanded(
      //       child: ( widget.reviews.length>-1&&  widget.reviews.length!=null)?ListView.builder(
      //           itemCount: widget.reviews.length??0,
      //           itemBuilder: (_,index){
      //             return Container(
      //               margin: EdgeInsets.symmetric(horizontal: size.width*0.05,vertical: size.height*0.01),
      //               width: size.width,
      //               child: Text("${index+1}.  ${widget.reviews[index].text}",style: TextStyle(
      //                 color: Colors.black,
      //                 fontWeight: FontWeight.w500,
      //                 fontSize: size.width*0.04,
      //               ),),
      //             );
      //           }):Text("N/A",style: TextStyle(
      // color: Colors.black,
      // fontWeight: FontWeight.w500,
      // fontSize: size.width*0.04,
      // ),),
      //     )
          ],
        ),
      ),
    );
  }
}
