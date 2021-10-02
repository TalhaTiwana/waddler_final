import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:waddler/Style/colors.dart';

import 'component/expanded_card.dart';

class FAQ extends StatefulWidget {
  const FAQ({Key? key}) : super(key: key);

  @override
  _FAQState createState() => _FAQState();
}

class _FAQState extends State<FAQ> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          leading: IconButton(
            icon: Icon(Icons.arrow_back_ios),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
          centerTitle: true,
          backgroundColor: primaryDarkClr,
          title: Text("F.A.Q"),
        ),
        body: Container(
          margin: EdgeInsets.symmetric(horizontal: 5),
          child: SingleChildScrollView(
            child: Column(
              children: [
                ExpandedCard(
                  title: 'How do I manage my child register?',
                  answer:
                      'You can register your child online with your preferred child-care center.',
                ),
                ExpandedCard(
                  title: 'How do i make an observation?',
                  answer:
                      'You can observe your child activities through our waddler app feature live surveillance.',
                ),
                ExpandedCard(
                  title: 'How can i update my personal information?',
                  answer:
                      'Personal information can be edited any time through our waddler app.',
                ),
                ExpandedCard(
                  title: 'How can i pay for this registration?',
                  answer:
                      'You can easily pay through online payment system by selecting a payment method and by adding relevant information.',
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}


