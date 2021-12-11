import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_credit_card/credit_card_widget.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:waddler/Common/snackbar.dart';
import 'package:waddler/Model/center_model.dart';
import 'package:waddler/Screens/OnlinePayment/components/pdf_api.dart';
import 'package:waddler/Screens/OnlinePayment/stripe_service.dart';
import 'package:waddler/Style/colors.dart';

class OnlinePayment extends StatefulWidget {
  const OnlinePayment({Key? key}) : super(key: key);

  @override
  _OnlinePaymentState createState() => _OnlinePaymentState();
}

class _OnlinePaymentState extends State<OnlinePayment> {
  DaycareCenterModel? dayCareCenter;
  String cardNumber = '';
  String expiryDate = '';
  String cardHolderName = '';
  String cvvCode = '';
  bool isCvvFocused = false;
  String? childName;
  String? parentName;
  String? age;
  List<DaycareCenterModel> dayCareCenterNames = [];
  late CollectionReference _ref;

  @override
  void initState() {
    StripeService.init();
    _ref = FirebaseFirestore.instance.collection("Users");
    _ref.doc(FirebaseAuth.instance.currentUser!.uid).get().then((value) {
      parentName = value.get("fName");
      childName = value.get("childName");
      age = value.get("childAge");
    }).whenComplete(() {
      print("fetched data");
      setState(() {});
    });
    FirebaseFirestore.instance.collection('dayCareCenter').get().then((value) {
      for (int i = 0; i < value.docs.length; i++) {
        dayCareCenterNames.add(DaycareCenterModel(
            name: value.docs[i].get('name'), fees: value.docs[i].get('fees')));
      }
    }).whenComplete(() {
      setState(() {});
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Pay Online'),
          centerTitle: true,
          backgroundColor: primaryDarkClrLightTheme,
        ),
        body: Container(
          margin: EdgeInsets.symmetric(horizontal: 10),
          child: Column(
            children: [
              CreditCardWidget(
                cardBgColor: Colors.black,
                cardNumber: cardNumber,
                expiryDate: expiryDate,
                cardHolderName: cardHolderName,
                cvvCode: cvvCode,
                showBackView: isCvvFocused,
                textStyle: const TextStyle(
                    color: Colors.white, fontWeight: FontWeight.w600),
                animationDuration: const Duration(milliseconds: 1000),
                onCreditCardWidgetChange: (CreditCardBrand) {},
                width: size.width * 0.9,
                height: size.height * 0.25,
                //true when you want to show cvv(back) view
              ),
              StreamBuilder(
                  stream: FirebaseFirestore.instance
                      .collection('dayCareCenter')
                      .snapshots(),
                  builder: (context, AsyncSnapshot snapshot) {
                    if (snapshot.hasData) {
                      return DropdownButton<DaycareCenterModel>(
                        isExpanded: true,
                        value: dayCareCenter,
                        hint: const Text("Select daycare center"),
                        items: dayCareCenterNames.map((value) {
                          return DropdownMenuItem<DaycareCenterModel>(
                            value: value,
                            child: Text(value.name),
                          );
                        }).toList(),
                        onChanged: (value) {
                          setState(() {
                            dayCareCenter = value;
                          });
                        },
                      );
                    } else {
                      return const Center(
                        child: CircularProgressIndicator(),
                      );
                    }
                  }),
              InkWell(
                onTap: () async {
                  if (dayCareCenter == null) {
                    showSnackBarFailed(context, 'Please select daycare center');
                    return;
                  }
                  final stripeTransactionResponse =
                      await StripeService.payWithNewCard(
                          amount: dayCareCenter!.fees, currency: 'USD');

                  if (stripeTransactionResponse.success ?? false) {
                    Navigator.pop(context);
                    showSnackBarSuccess(
                        context, '${stripeTransactionResponse.message}');
                    showSnackBarSuccess(context, 'Paid successfully');
                    final pdfFile = await PdfApi.generateTable(
                        age: age!,
                        appName: "Waddler",
                        centerName: "${dayCareCenter!.name}",
                        childName: childName!,
                        fees: '${dayCareCenter!.fees}',
                        parentName: parentName!,
                        time: DateTime.now().toString());

                    PdfApi.openFile(pdfFile);
                  } else {
                    print("Error => ${stripeTransactionResponse.message}");
                    showSnackBarSuccess(
                        context, 'Payment transferred');
                  }
                },
                child: Container(
                  margin: EdgeInsets.only(top: size.height * 0.06),
                  alignment: Alignment.center,
                  width: size.width * 0.8,
                  height: size.height * 0.06,
                  decoration: BoxDecoration(
                      color: primaryDarkClrLightTheme,
                      borderRadius: BorderRadius.circular(20)),
                  child: Text(
                    "Pay",
                    style: GoogleFonts.rubik(
                        color: Colors.white,
                        fontWeight: FontWeight.w500,
                        fontSize: size.width * 0.045),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
