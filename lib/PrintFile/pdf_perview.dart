import 'dart:io';
import 'package:share_plus/share_plus.dart';
import '../Core/Services/shareService.dart';
import '../Widgets/colors.dart';
import 'package:get/get.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';
import 'package:flutter/material.dart';

class PdfPerview extends GetWidget {
  String filePath;

  PdfPerview({
    required this.filePath,
  });
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          iconTheme: IconThemeData(color: Colors.white),
          backgroundColor: AppColors.MainColor,
          title: Text(" ",
          //  style: subtitle1,
          ),
          actions: [
            IconButton(
                onPressed: () async {
                  sharePdf(filePath);
                  // final xFile = XFile(filePath, mimeType: 'application/pdf');
                  // await Share.shareXFiles([xFile]);
                  // await Share.shareFiles([filePath],
                  //     mimeTypes: ['application/pdf'], text: '');
                },
                icon: Icon(Icons.share,color: Colors.white,)),
          ],
        ),
        body: SfPdfViewer.file(File(filePath),
                 // pageLayoutMode: PdfPageLayoutMode.single,
                ));
  }
}
