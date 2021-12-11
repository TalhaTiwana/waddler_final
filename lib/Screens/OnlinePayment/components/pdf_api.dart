import 'dart:io';

import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:open_file/open_file.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart';
import 'package:pdf/widgets.dart' as pw;

class User {
  final String appName;
  final String centerName;
  final String time;
  final String fees;
  final String childName;
  final String parentName;
  final int age;

  const User(
      {required this.appName,
      required this.centerName,
      required this.time,
      required this.fees,
      required this.childName,
      required this.parentName,
      required this.age});
}

class PdfApi {
  static Future<File> generateTable(
      {required String appName,
      required String centerName,
      required String time,
      required String fees,
      required String childName,
      required String parentName,
      required String age}) async {
    final pdf = Document();

    final headers = ['Name', 'Age'];

    final users = [];
    final data = users.map((user) => [user.name, user.age]).toList();

    pdf.addPage(Page(build: (context) {
      return Column(crossAxisAlignment: CrossAxisAlignment.center, children: [
        Text("Invoice",
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 25,
            ),
            textAlign: pw.TextAlign.center),
        pw.Table(children: [
          pw.TableRow(
              verticalAlignment: TableCellVerticalAlignment.full,
              children: [
                pw.Text('Daycare center name:'),
                pw.Text(centerName),
              ]),
          pw.TableRow(
              verticalAlignment: TableCellVerticalAlignment.full,
              children: [
                pw.Text('Fees:'),
                pw.Text(fees),
              ]),
          pw.TableRow(
              verticalAlignment: TableCellVerticalAlignment.full,
              children: [
                pw.Text('Parent name:'),
                pw.Text(parentName),
              ]),
          pw.TableRow(
              verticalAlignment: TableCellVerticalAlignment.full,
              children: [
                pw.Text('Child name:'),
                pw.Text(childName),
              ]),
          pw.TableRow(
              verticalAlignment: TableCellVerticalAlignment.full,
              children: [
                pw.Text('Child age:'),
                pw.Text(age),
              ]),
          pw.TableRow(
              verticalAlignment: TableCellVerticalAlignment.full,
              children: [
                pw.Text('Time:'),
                pw.Text(time),
              ]),
        ]),
      ]);
    }));
    return saveDocument(name: 'my_example.pdf', pdf: pdf);
  }

  static Future<File> generateImage() async {
    final pdf = Document();

    final imageSvg = await rootBundle.loadString('assets/fruit.svg');
    final imageJpg =
        (await rootBundle.load('assets/person.jpg')).buffer.asUint8List();

    final pageTheme = PageTheme(
      pageFormat: PdfPageFormat.a4,
      buildBackground: (context) {
        if (context.pageNumber == 1) {
          return FullPage(
            ignoreMargins: true,
            child: Image(MemoryImage(imageJpg), fit: BoxFit.cover),
          );
        } else {
          return Container();
        }
      },
    );

    pdf.addPage(
      MultiPage(
        pageTheme: pageTheme,
        build: (context) => [
          Container(
            height: pageTheme.pageFormat.availableHeight - 1,
            child: Center(
              child: Text(
                'Foreground Text',
                style: TextStyle(color: PdfColors.white, fontSize: 48),
              ),
            ),
          ),
          SvgImage(svg: imageSvg),
          Image(MemoryImage(imageJpg)),
          Center(
            child: ClipRRect(
              horizontalRadius: 32,
              verticalRadius: 32,
              child: Image(
                MemoryImage(imageJpg),
                width: pageTheme.pageFormat.availableWidth / 2,
              ),
            ),
          ),
          GridView(
            crossAxisCount: 3,
            childAspectRatio: 1,
            children: [
              SvgImage(svg: imageSvg),
              SvgImage(svg: imageSvg),
              SvgImage(svg: imageSvg),
              SvgImage(svg: imageSvg),
              SvgImage(svg: imageSvg),
              SvgImage(svg: imageSvg),
            ],
          )
        ],
      ),
    );

    return saveDocument(name: 'my_example.pdf', pdf: pdf);
  }

  static Future<File> saveDocument({
    required String name,
    required Document pdf,
  }) async {
    final bytes = await pdf.save();

    final dir = await getApplicationDocumentsDirectory();
    final file = File('${dir.path}/$name');

    await file.writeAsBytes(bytes);

    return file;
  }

  static Future openFile(File file) async {
    final url = file.path;

    await OpenFile.open(url);
  }
}
