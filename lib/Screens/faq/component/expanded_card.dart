import 'package:flutter/material.dart';
import 'package:waddler/Style/colors.dart';

class ExpandedCard extends StatefulWidget {
  final title;
  final answer;

  const ExpandedCard({
    Key? key,
    this.title,
    this.answer,
  }) : super(key: key);

  @override
  _ExpandedCardState createState() => _ExpandedCardState();
}

class _ExpandedCardState extends State<ExpandedCard> {
  bool isExpanded = false;
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return InkWell(
      onTap: () {
        setState(() {
          isExpanded = !isExpanded;
        });
      },
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: size.width * 0.04),
        margin: EdgeInsets.only(top: size.height * 0.01),
        decoration: BoxDecoration(
          color: isExpanded ? primaryDarkClr : primaryClr,
          borderRadius: BorderRadius.circular(10),
        ),
        width: size.width,
        height: isExpanded ? size.height * 0.2 : null,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: 10,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  width: size.width * 0.75,
                  child: Text(
                    "${widget.title}",
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: size.width * 0.05,
                        fontWeight: FontWeight.bold),
                  ),
                ),
                IconButton(
                  onPressed: () {
                    setState(() {
                      isExpanded = !isExpanded;
                    });
                  },
                  icon: Icon(
                    isExpanded
                        ? Icons.keyboard_arrow_up_sharp
                        : Icons.keyboard_arrow_down,
                    color: Colors.white,
                    size: size.width * 0.08,
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 10,
            ),
            isExpanded
                ? SizedBox(
              width: size.width * 0.85,
              child: Text(
                "${widget.answer}",
                style: TextStyle(
                    color: Colors.white, fontSize: size.width * 0.043),
              ),
            )
                : Text('')
          ],
        ),
      ),
    );
  }
}