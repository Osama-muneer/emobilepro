import 'dart:io';
import '../../../Operation/models/bil_mov_m.dart';
import '../../../PrintFile/file_helper.dart';
import '../../../PrintFile/share_mode.dart';
import '../../../PrintFile/simple_pdf.dart';
import '../../../Reports/controllers/invoices_archive_controller.dart';
import '../../../Setting/controllers/login_controller.dart';
import '../../../Widgets/config.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart' as intl;
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:pdf/widgets.dart';
import 'package:flutter/material.dart' as ma;
import 'package:fluttertoast/fluttertoast.dart';

Invoices_Archive_Pdf({
  required ShareMode mode,
  String? GetBINAF,
  String? GetBINAT,
  String? GetBMMDAF,
  String? GetBMMDAT,
  // required Vouchersetting Vouchersetting,
}) async {
   try {
  final Invoices_ArchiveController controller = Get.find();

  final pdf = pw.Document();
  const double inch = 72.0;
  final Uint8List fontData = await FileHelper.getFileFromAssets('Assets/fonts/HacenTunisia.ttf');
  final font = pw.Font.ttf(fontData.buffer.asByteData());

  final imageByteData = await rootBundle.load(ImagePathPDF);
  final imagefile = File(SignPicture);
  final imageBytes_b = LoginController().SOSI=='null' || LoginController().SOSI=='0' || LoginController().SOSI.isEmpty
      ||  LoginController().Image_Type=='2'?imageByteData.buffer.asUint8List(imageByteData.offsetInBytes, imageByteData.lengthInBytes)
      :imagefile.readAsBytesSync();
  final image = pw.MemoryImage(imageBytes_b);
  final formatter = intl.NumberFormat.decimalPattern();
  pdf.addPage(
        MultiPage(
          // margin: const EdgeInsets.all(1),
      pageFormat: PdfPageFormat.a4,
          textDirection: TextDirection.rtl,
          crossAxisAlignment: CrossAxisAlignment.center,
          theme: ThemeData.withFont(base: Font.ttf(await rootBundle.load("Assets/fonts/HacenTunisia.ttf"))),
          header: (context) =>Row(
            mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
            children: <pw.Widget>[
              Expanded(child:
              Column(
                  children: [
                    Text(controller.SONE,style: TextStyle(fontWeight: FontWeight.bold, color: PdfColors.black, fontSize: 10.5.sp)),
                    Text(controller.SOLN,style: TextStyle(fontWeight: FontWeight.bold, color: PdfColors.black, fontSize: 10.5.sp)),
                  ]),),
              Expanded(child:Column(children: [
                Container(
                    width: 50.w,
                    child: Image(image)
                ),
                Container( margin: const EdgeInsets.symmetric(vertical: 4),
                    decoration: BoxDecoration(
                      color: PdfColor.fromHex("#ABABAB"),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Text(' ${'StrinInvoices_Archive'.tr} ',
                        style: TextStyle(color: PdfColors.black, fontSize: 13.sp))),
              ])),
              Expanded(
                child: Column(
                    children: [
                      Text(controller.SONA,style: TextStyle(color: PdfColors.black, fontSize: 11.sp)),
                      Text(controller.SORN,style: TextStyle(color: PdfColors.black, fontSize: 11.sp)),
                    ]),)
            ],
          ),
          build: (Context context)=> [
            SizedBox(height: 3),
            Table(border: TableBorder.all(), children: [
              TableRow(
                children: [
                  Container(
                    padding: const EdgeInsets.only(right: 1, left: 1),
                    /// height: 630,
                    child: Column(children: [
                      Padding(
                          padding: const EdgeInsets.only(right: 2, left: 2, top: 3),
                          child: Row(children: [
                            Table(border: TableBorder.all(), children: [
                              TableRow(
                                children: [
                                  Container(
                                    width: 476,
                                    padding: const pw.EdgeInsets.only(right: 8, left: 8),
                                    child: Column(children: [
                                      Row(
                                        mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                                        children: <pw.Widget>[
                                          pw.Column(children: [
                                            pw.Text(
                                              '${'StringBIID_TlableText'.tr} ${GetBINAT} :',
                                              style: TextStyle(fontSize: 13.0.sp),
                                            ),
                                          ]),
                                          pw.Column(children: [
                                            pw.Text(
                                              ' ${'StringBIID_FlableText'.tr} ${GetBINAF} :',
                                              style: TextStyle(fontSize: 13.0.sp),
                                            ),
                                          ]),

                                        ],
                                      ),
                                      Row(
                                        mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                                        children: <pw.Widget>[
                                          pw.Column(children: [
                                            pw.Text(
                                              '${'StringToDate_Rep'.tr} ${GetBMMDAT} ',
                                              style: TextStyle(fontSize: 13.0.sp),
                                            ),
                                          ]),
                                          pw.Column(children: [
                                            pw.Text(
                                              ' ${'StringFromDate_Rep'.tr} ${GetBMMDAF}',
                                              style: TextStyle(fontSize: 13.0.sp),
                                            ),
                                          ]),
                                        ],
                                      ),
                                    ]),
                                  ),
                                ],
                              )
                            ]),
                          ])),
                      SizedBox(height: 3),
                    ]),
                  ),
                ],
              ),
            ]),
            SizedBox(height: 3),
            Table(border: TableBorder.all(),
             columnWidths: {
               0: const FlexColumnWidth(1.5),
               1: const FlexColumnWidth(2),
               2: const FlexColumnWidth(1.5),
               3: const FlexColumnWidth(2.5),
               4: const FlexColumnWidth(2.5),
               5: const FlexColumnWidth(2),
               6:  FlexColumnWidth(STMID!='COU'?2.2:0),
              // 7: const FlexColumnWidth(2),
            },
             children: [
                  TableRow(
                    decoration: const BoxDecoration(
                      color: PdfColors.MyColors,
                    ),
                    children: [
                      Container(
                        decoration: const BoxDecoration(),
                        padding: const EdgeInsets.all(1),
                        child: SimplePdf.text(
                          'StringState'.tr,
                          font,
                          fontSize: 12,
                          color: PdfColors.black,
                        ),
                      ),
                      Container(
                        decoration: const BoxDecoration(),
                        padding: const EdgeInsets.all(1),
                        child: SimplePdf.text(
                          'StrinBCMAM'.tr,
                          font,
                          fontSize: 12,
                          color: PdfColors.black,
                        ),
                      ),
                      Container(
                        decoration: const BoxDecoration(),
                        padding: const EdgeInsets.all(1),
                        child: SimplePdf.text(
                          'StringSCIDlableText'.tr,
                          font,
                          fontSize: 12,
                          color: PdfColors.black,
                        ),
                      ),
                      Container(
                        decoration: const BoxDecoration(),
                        padding: const EdgeInsets.all(1),
                        child: SimplePdf.text(
                          'StringBCID'.tr,
                          font,
                          fontSize: 12,
                          color: PdfColors.black,
                        ),
                      ),
                      Container(
                        decoration: const BoxDecoration(),
                        padding: const EdgeInsets.all(1),
                        child: SimplePdf.text(
                          'StringSMDED2'.tr,
                          font,
                          fontSize: 12,
                          color: PdfColors.black,
                        ),
                      ),
                      Container(
                        decoration: const BoxDecoration(),
                        padding: const EdgeInsets.all(1),
                        child: SimplePdf.text(
                          'StringBMMNO'.tr,
                          font,
                          fontSize: 12,
                          color: PdfColors.black,
                        ),
                      ),
                      Container(
                        decoration: const BoxDecoration(),
                        padding: const EdgeInsets.all(1),
                        child: SimplePdf.text(
                          'StringType'.tr,
                          font,
                          fontSize: 12,
                          color: PdfColors.black,
                        ),
                      ),
                    ],
                  ),
                ]),
           Table(
                border: pw.TableBorder.all(),
                columnWidths: {
                  0: const FlexColumnWidth(1.5),
                  1: const FlexColumnWidth(2),
                  2: const FlexColumnWidth(1.5),
                  3: const FlexColumnWidth(2.5),
                  4: const FlexColumnWidth(2.5),
                  5: const FlexColumnWidth(2),
                  6:  FlexColumnWidth(STMID!='COU'?2.2:0),
                  // 7: const FlexColumnWidth(2),
                },
                children: List.generate(BIF_MOV_M_PDF.length, (index) {
                  Bil_Mov_M_Local BIF_MOV_M_LIST = BIF_MOV_M_PDF[index];
                  return TableRow(
                    children: [
                      Container(
                        alignment: pw.Alignment.center,
                        padding: const pw.EdgeInsets.only(top: 2,bottom: 2,right: 1,left: 1),
                        child: SimplePdf.text(
                            BIF_MOV_M_LIST.BMMST.toString()== '2' ? 'StringNotfinal'.tr
                      : BIF_MOV_M_LIST.BMMST.toString() =='3' ? 'StringPending'.tr : 'Stringfinal'.tr
                            ,
                            font,
                            fontSize: 12),
                      ),
                      Container(
                        alignment: pw.Alignment.center,
                        padding: const pw.EdgeInsets.only(top: 2,bottom: 2,right: 1,left: 1),
                        child: SimplePdf.text(
                            controller.formatter.format(BIF_MOV_M_LIST.BMMMT).toString(),
                            font,
                            fontSize: 12),
                      ),
                      Container(
                        alignment: pw.Alignment.center,
                        padding:  const pw.EdgeInsets.only(top: 2,bottom: 2,right: 1,left: 1),
                        child: SimplePdf.text(
                          '${BIF_MOV_M_LIST.SCNA_D.toString()} - ${BIF_MOV_M_LIST.PKNA_D.toString()}', font,
                          fontSize: 12,color: PdfColors.black,
                        ),
                      ),
                      Container(
                        alignment: pw.Alignment.center,
                        padding:  const pw.EdgeInsets.only(top: 2,bottom: 2,right: 1,left: 1),
                        child: SimplePdf.text(BIF_MOV_M_LIST.BMMNA.toString(), font,
                          fontSize: 12,color: PdfColors.black,
                        ),
                      ),
                      Container(
                        alignment: pw.Alignment.center,
                        padding: const pw.EdgeInsets.only(top: 2,bottom: 2,right: 1,left: 1),
                        child: SimplePdf.text(
                            BIF_MOV_M_LIST.DATEI.toString(),
                            font,
                            fontSize: 12),
                      ),
                      Container(
                        alignment: pw.Alignment.center,
                        padding:  const pw.EdgeInsets.only(top: 2,bottom: 2,right: 1,left: 1),
                        child: SimplePdf.text(
                          BIF_MOV_M_LIST.BMMNO.toString() , font,
                          fontSize: 10,color: PdfColors.black,
                        ),
                      ),
                      Container(
                        alignment: pw.Alignment.center,
                        padding:  const pw.EdgeInsets.only(top: 2,bottom: 2,right: 1,left: 1),
                        child: SimplePdf.text(
                  BIF_MOV_M_LIST.BMKID.toString()=='3'
                  ?'StringSale_Invoices'.tr:BIF_MOV_M_LIST.BMKID.toString()=='1'?'StringPurchases_Invoices'.tr:
                  BIF_MOV_M_LIST.BMKID.toString()=='5'?'StringService_Bills'.tr:BIF_MOV_M_LIST.BMKID.toString()=='4'?'StringReturn_Sale_Invoices'.tr:
                  BIF_MOV_M_LIST.BMKID.toString()=='12'?'StringReturn_Sale_Invoices_POS'.tr:'StringPOS'.tr
                          , font,
                          fontSize: 12,color: PdfColors.black,
                        ),
                      ),
                    ],
                  );
                })),


            //الاجمالي  حسب كل نوع
            Table(border: TableBorder.all(), children: [
              TableRow(
                children: [
                  Table(children: [
                    TableRow(
                      children: [
                        Container(
                          padding: const pw.EdgeInsets.only(top: 8),
                          child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Container(),

                                SimplePdf.text(
                                  'الاجمالي  حسب كل نوع',
                                  font,
                                  fontSize: 12,
                                  color: PdfColors.black,
                                ),
                              ]),
                        ),
                      ],
                    ),
                    TableRow(
                      children: [
                        Container(
                          padding: const pw.EdgeInsets.only(right: 8, left: 8),
                          child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: []),
                        ),
                      ],
                    ),
                  ]),
                ],
              ),
            ]),

            Table(border: TableBorder.all(), columnWidths: {
              0: const FlexColumnWidth(1.2),
              1: const FlexColumnWidth(1.2),
              2: const FlexColumnWidth(1.2),
            },
                children: [
                  TableRow(
                    decoration: const BoxDecoration(
                      color: PdfColors.MyColors,
                    ),
                    children: [
                      Container(
                        decoration: const BoxDecoration(),
                        padding: const EdgeInsets.all(1),
                        child: SimplePdf.text(
                          'StringSUM_BMMAM'.tr,
                          font,
                          fontSize: 10,
                          color: PdfColors.black,
                        ),
                      ),
                      //العمله
                      Container(
                        decoration: const BoxDecoration(),
                        padding: const EdgeInsets.all(1),
                        child: SimplePdf.text(
                          'StringSCIDlableText'.tr,
                          font,
                          fontSize: 10,
                          color: PdfColors.black,
                        ),
                      ),
                      Container(
                        decoration: const BoxDecoration(),
                        padding: const EdgeInsets.all(1),
                        child: SimplePdf.text(
                          'StringType'.tr,
                          font,
                          fontSize: 10,
                          color: PdfColors.black,
                        ),
                      ),
                    ],
                  ),
                ]),
            Table(
                border: pw.TableBorder.all(),
                columnWidths: {
                  0: const FlexColumnWidth(1.2),
                  1: const FlexColumnWidth(1.2),
                  2: const FlexColumnWidth(1.2),
                },
                children:
                List.generate(BIF_MOV_M_SUM_PDF.length, (index) {
                  Bil_Mov_M_Local BIF_MOV_M_SUM_PDF_LIST = BIF_MOV_M_SUM_PDF[index];
                  return TableRow(
                    children: [
                      Container(
                        alignment: pw.Alignment.center,
                        decoration: const BoxDecoration(),
                        padding: const pw.EdgeInsets.only(
                            top: 2, bottom: 2, right: 1, left: 1),
                        child: SimplePdf.text(
                          BIF_MOV_M_SUM_PDF_LIST.BMMMT.toString() == 'null'
                              ? '0'
                              : formatter
                              .format(double.parse(
                              BIF_MOV_M_SUM_PDF_LIST.BMMMT.toString()))
                              .toString(),
                          font,
                          align: TextAlign.left,
                          fontSize: 12,
                          color: PdfColors.black,
                        ),
                      ),
                      Container(
                        alignment: pw.Alignment.center,
                        decoration: const BoxDecoration(),
                        padding: const pw.EdgeInsets.only(
                            top: 2, bottom: 2, right: 1, left: 1),
                        child: SimplePdf.text(
                          BIF_MOV_M_SUM_PDF_LIST.SCNA_D.toString(),
                          font,
                          fontSize: 12,
                          color: PdfColors.black,
                        ),
                      ),
                      Container(
                        alignment: pw.Alignment.center,
                        padding:  const pw.EdgeInsets.only(top: 2,bottom: 2,right: 1,left: 1),
                        child: SimplePdf.text(
                          BIF_MOV_M_SUM_PDF_LIST.BMKID.toString()=='3'
                              ?'StringSale_Invoices'.tr:BIF_MOV_M_SUM_PDF_LIST.BMKID.toString()=='1'?'StringPurchases_Invoices'.tr:
                          BIF_MOV_M_SUM_PDF_LIST.BMKID.toString()=='5'?'StringService_Bills'.tr:BIF_MOV_M_SUM_PDF_LIST.BMKID.toString()=='4'?'StringReturn_Sale_Invoices'.tr:
                          BIF_MOV_M_SUM_PDF_LIST.BMKID.toString()=='12'?'StringReturn_Sale_Invoices_POS'.tr:'StringPOS'.tr
                          , font,
                          fontSize: 12,color: PdfColors.black,
                        ),
                      ),

                    ],
                  );
                })),
         // Table(border: TableBorder.all(), children: [
         //   TableRow(
         //     children: [
         //       Container(
         //         padding: const EdgeInsets.only(right: 1, left: 1),
         //         /// height: 630,
         //         child: Column(children: [
         //           Padding(padding: const EdgeInsets.only(right: 5, left: 5, top: 1),
         //             child: Column(
         //               crossAxisAlignment: CrossAxisAlignment.end,
         //               children: [
         //                 Column(
         //                   crossAxisAlignment: CrossAxisAlignment.end,
         //                   children: [
         //                     pw.Column(children: [
         //                       pw.Text(
         //                         '${'StrinCount_SMDFN'.tr} ${controller.formatter.format(BIF_MOV_M_SUM_PDF.elementAt(0).BMMMT).toString()} :',
         //                         style: TextStyle(fontSize: 12.0.sp,color: PdfColors.black),
         //                       )
         //                     ]),
         //                     // Text(dataInfo.billnote.toString()),
         //                     // SizedBox(height: 0.8 * PdfPageFormat.cm),
         //                   ],
         //                 ),
         //               ],
         //             ),
         //           ),
         //           SizedBox(height: 2),
         //           Divider(height: 1),
         //         ]),
         //       ),
         //     ],
         //   ),
         // ]),

         Table(border: TableBorder.all(), children: [
           TableRow(
             children: [
               Container(
                 padding: const EdgeInsets.only(right: 1, left: 1),
                 /// height: 630,
                 child: Column(children: [
                   Padding(padding: const EdgeInsets.only(right: 2, left: 2, top: 3),
                     child: Container(
                       padding:  const EdgeInsets.only(top: 2,bottom: 3),
                       child: SimplePdf.text(controller.SDDDA,
                         font,
                         fontSize: 9,
                         align: TextAlign.center,
                         color: PdfColors.black,
                       ),
                     ),
                   ),
                   SizedBox(height: 2),
                   Divider(height: 1),
                   Padding(padding: const EdgeInsets.only(right: 2, left: 2, top: 3),
                     child: Container(
                       padding:  const EdgeInsets.only(top: 2,bottom: 3),
                       child: SimplePdf.text(controller.SDDSA,
                         font,
                         fontSize: 9,
                         align: TextAlign.center,
                         color: PdfColors.black,
                       ),
                     ),
                   ),
                   SizedBox(height: 2),
                 ]),
               ),
             ],
           ),
         ]),
      ],
          footer: (context) =>  Column(children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SimplePdf.text(
                  'StrinUser'.tr + ' ${LoginController().SUNA}',
                  font,
                  fontSize: 10,
                  color: PdfColors.black,
                ),
                Text('Page ${context.pageNumber}  of ${context.pagesCount}',
                    style: const TextStyle(fontSize: 10)),
                SimplePdf.text(
                  'StringDateofPrinting'.tr +
                      ': ' +
                      '${intl.DateFormat('dd-MM-yyyy HH:m').format(DateTime.now())}',
                  font,
                  fontSize: 10,
                  color: PdfColors.black,
                ),
              ])]),
    ),
  );

  List<int> bytes = await pdf.save();
  FileHelper.share(
      mode: mode,
      bytes: bytes,
      fileName: '${'StrinInvoices_Archive'.tr}.pdf',
      BMMID: 0
  );
   } catch (e) {
     Fluttertoast.showToast(
         msg:e.toString(),
         toastLength: Toast.LENGTH_LONG,
         textColor: ma.Colors.white,
         backgroundColor: ma.Colors.redAccent);
     print(e.toString());
   }
}

