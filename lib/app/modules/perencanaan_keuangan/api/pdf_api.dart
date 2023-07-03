// import 'dart:io';
// import 'package:flutter/services.dart';
// import 'package:open_file/open_file.dart';
// import 'package:path_provider/path_provider.dart';
// import 'package:pdf/widgets.dart';

// class PdfApi {
//   static Future<File> generateCenteredText(String text) async {
//     final pdf = Document();
//     final font = await rootBundle.load("assets/fonts/OpenSans.ttf");
//     final ttf = Font.ttf(font);

//     pdf.addPage(
//       Page(
//         build: (context) => Center(
//           child: Text(
//             "text",
//             style: TextStyle(fontSize: 48, font: ttf),
//           ),
//         ),
//       ),
//     );

//     return saveDocument(name: 'name.pdf', pdf: pdf);
//   }

//   static Future<File> saveDocument({
//     required String name,
//     required Document pdf,
//   }) async {
//     final bytes = await pdf.save();

//     final dir = await getApplicationDocumentsDirectory();
//     final file = File("${dir.path}/$name");

//     await file.writeAsBytes(bytes);

//     return file;
//   }

//   static Future openFile(File file) async {
//     final url = file.path;

//     await OpenFile.open(url);
//   }
// }
