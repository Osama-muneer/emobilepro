import 'dart:io';
import '../../../Operation/models/acc_mov_m.dart';
import '../../../PrintFile/file_helper.dart';
import '../../../PrintFile/share_mode.dart';
import '../../../PrintFile/simple_pdf.dart';
import '../../../Reports/controllers/accounts_archive_controller.dart';
import '../../../Setting/controllers/login_controller.dart';
import '../../../Widgets/config.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart' as intl;
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:pdf/widgets.dart';
import 'package:flutter/material.dart' as ma;
import 'package:fluttertoast/fluttertoast.dart';

Accounts_Archive_Pdf({
  required ShareMode mode,
  String? GetBINAF,
  String? GetBINAT,
  String? GetBMMDAF,
  String? GetBMMDAT,
  // required Vouchersetting Vouchersetting,
}) async {
   try {
  final Accounts_ArchiveController controller = Get.find();

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
                    Text(controller.SONE,style: TextStyle(fontWeight: FontWeight.bold, color: PdfColors.black, fontSize: 10.5)),
                    Text(controller.SOLN,style: TextStyle(fontWeight: FontWeight.bold, color: PdfColors.black, fontSize: 10.5)),
                  ]),),
              Expanded(child:Column(children: [
                Container(
                    width: 50,
                    child: Image(image)
                ),
                Container( margin: const EdgeInsets.symmetric(vertical: 4),
                    decoration: BoxDecoration(
                      color: PdfColor.fromHex("#ABABAB"),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Text(' ${'StringAccountsArchive'.tr} ',
                        style: TextStyle(color: PdfColors.black, fontSize: 13))),
              ])),
              Expanded(
                child: Column(
                    children: [
                      Text(controller.SONA,style: TextStyle(color: PdfColors.black, fontSize: 11)),
                      Text(controller.SORN,style: TextStyle(color: PdfColors.black, fontSize: 11)),
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
                                              style: TextStyle(fontSize: 13.0),
                                            ),
                                          ]),
                                          pw.Column(children: [
                                            pw.Text(
                                              ' ${'StringBIID_FlableText'.tr} ${GetBINAF} :',
                                              style: TextStyle(fontSize: 13.0),
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
                                              style: TextStyle(fontSize: 13.0),
                                            ),
                                          ]),
                                          pw.Column(children: [
                                            pw.Text(
                                              ' ${'StringFromDate_Rep'.tr} ${GetBMMDAF}',
                                              style: TextStyle(fontSize: 13.0),
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
               2: const FlexColumnWidth(2),
               3: const FlexColumnWidth(2),
               4: const FlexColumnWidth(3),
               5: const FlexColumnWidth(2),
               6: const FlexColumnWidth(2.2),
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
                          'StringPKIDlableText'.tr,
                          font,
                          fontSize: 12,
                          color: PdfColors.black,
                        ),
                      ),
                      Container(
                        decoration: const BoxDecoration(),
                        padding: const EdgeInsets.all(1),
                        child: SimplePdf.text(
                          'StringAmount'.tr,
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
                  2: const FlexColumnWidth(2),
                  3: const FlexColumnWidth(2),
                  4: const FlexColumnWidth(3),
                  5: const FlexColumnWidth(2),
                  6: const FlexColumnWidth(2.2),
                  // 7: const FlexColumnWidth(2),
                },
                children: List.generate(ACC_MOV_M_PDF.length, (index) {
                  Acc_Mov_M_Local ACC_MOV_M_LIST = ACC_MOV_M_PDF[index];
                  return TableRow(
                    children: [
                      Container(
                        alignment: pw.Alignment.center,
                        padding: const pw.EdgeInsets.only(top: 2,bottom: 2,right: 1,left: 1),
                        child: SimplePdf.text(
                            ACC_MOV_M_LIST.AMMST.toString()== '2' ? 'StringNotfinal'.tr
                      : ACC_MOV_M_LIST.AMMST.toString() =='3' ? 'StringPending'.tr : 'Stringfinal'.tr
                            ,
                            font,
                            fontSize: 12),
                      ),
                      Container(
                        alignment: pw.Alignment.center,
                        padding: const pw.EdgeInsets.only(top: 2,bottom: 2,right: 1,left: 1),
                        child: SimplePdf.text(
                            ACC_MOV_M_LIST.PKNA_D.toString(),
                            font,
                            fontSize: 12),
                      ),
                      Container(
                        alignment: pw.Alignment.center,
                        padding: const pw.EdgeInsets.only(top: 2,bottom: 2,right: 1,left: 1),
                        child: SimplePdf.text(
                            controller.formatter.format(ACC_MOV_M_LIST.AMMAM).toString(),
                            font,
                            fontSize: 12),
                      ),
                      Container(
                        alignment: pw.Alignment.center,
                        padding:  const pw.EdgeInsets.only(top: 2,bottom: 2,right: 1,left: 1),
                        child: SimplePdf.text(
                          '${ACC_MOV_M_LIST.SCNA_D.toString()}', font,
                          fontSize: 12,color: PdfColors.black,
                        ),
                      ),
                      Container(
                        alignment: pw.Alignment.center,
                        padding: const pw.EdgeInsets.only(top: 2,bottom: 2,right: 1,left: 1),
                        child: SimplePdf.text(
                            ACC_MOV_M_LIST.DATEI.toString(),
                            font,
                            fontSize: 12),
                      ),
                      Container(
                        alignment: pw.Alignment.center,
                        padding:  const pw.EdgeInsets.only(top: 2,bottom: 2,right: 1,left: 1),
                        child: SimplePdf.text(
                          ACC_MOV_M_LIST.AMMNO.toString() , font,
                          fontSize: 10,color: PdfColors.black,
                        ),
                      ),
                      Container(
                        alignment: pw.Alignment.center,
                        padding:  const pw.EdgeInsets.only(top: 2,bottom: 2,right: 1,left: 1),
                        child: SimplePdf.text(
                  ACC_MOV_M_LIST.AMKID.toString()=='1'
                      ?'StringReceipt'.tr:ACC_MOV_M_LIST.AMKID.toString()=='2'?'StringPayment'.tr:
                  ACC_MOV_M_LIST.AMKID.toString()=='3'?'StringCollectionsVoucher'.tr:'StringJournalVouchers'.tr, font,
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
                List.generate(ACC_MOV_M_SUM_PDF.length, (index) {
                  Acc_Mov_M_Local ACC_MOV_M_SUM_PDF_LIST = ACC_MOV_M_SUM_PDF[index];
                  return TableRow(
                    children: [
                      Container(
                        alignment: pw.Alignment.center,
                        decoration: const BoxDecoration(),
                        padding: const pw.EdgeInsets.only(
                            top: 2, bottom: 2, right: 1, left: 1),
                        child: SimplePdf.text(
                          ACC_MOV_M_SUM_PDF_LIST.AMMAM.toString() == 'null'
                              ? '0'
                              : formatter
                              .format(double.parse(
                              ACC_MOV_M_SUM_PDF_LIST.AMMAM.toString()))
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
                          ACC_MOV_M_SUM_PDF_LIST.SCNA_D.toString(),
                          font,
                          fontSize: 12,
                          color: PdfColors.black,
                        ),
                      ),
                      Container(
                        alignment: pw.Alignment.center,
                        padding:  const pw.EdgeInsets.only(top: 2,bottom: 2,right: 1,left: 1),
                        child: SimplePdf.text(
                          ACC_MOV_M_SUM_PDF_LIST.AMKID.toString()=='1'
                              ?'StringReceipt'.tr:ACC_MOV_M_SUM_PDF_LIST.AMKID.toString()=='2'?'StringPayment'.tr:
                          ACC_MOV_M_SUM_PDF_LIST.AMKID.toString()=='3'?'StringCollectionsVoucher'.tr:'StringJournalVouchers'.tr, font,
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
         //                 SizedBox(height: 3),
         //                 Text('StringTotal'.tr  , style: TextStyle(fontSize: 13.0.sp,color: PdfColors.black),),
         //                 Column(
         //                   crossAxisAlignment: CrossAxisAlignment.end,
         //                   children: [
         //                     pw.Column(children: [
         //                       Row(
         //                         mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
         //                         children: <pw.Widget>[
         //                           pw.Column(children: [
         //                             ListAcc_Mov_M.elementAt(0).AMKID==1 || ListAcc_Mov_M.elementAt(0).AMKID==2 ||
         //                             ListAcc_Mov_M.elementAt(0).AMKID==3?
         //                             pw.Text(
         //                               '${'StringTotalequivalent'.tr} ${SUM_ACC_MOV_D.elementAt(0).SUMAMDEQ==null?'0':controller.formatter.format(SUM_ACC_MOV_D.elementAt(0).SUMAMDEQ).toString()} :',
         //                               style: TextStyle(fontSize: 12.0.sp,color: PdfColors.black),
         //                             ):Container(),
         //                           ]),
         //                           pw.Column(children: [
         //                             pw.Text(
         //                               '${'StringAMDDA'.tr} ${SUM_ACC_MOV_D.elementAt(0).SUMAMDDA==null?'0':
         //                               controller.formatter.format(SUM_ACC_MOV_D.elementAt(0).SUMAMDDA).toString()} :',
         //                               style: TextStyle(fontSize: 12.0.sp,color: PdfColors.black),
         //                             ),
         //                           ]),
         //                           pw.Column(children: [
         //                             pw.Text(
         //                               '${'StringAMDMD'.tr} ${SUM_ACC_MOV_D.elementAt(0).SUMAMDMD==null?'0':
         //                               controller.formatter.format(SUM_ACC_MOV_D.elementAt(0).SUMAMDMD).toString()} :',
         //                               style: TextStyle(fontSize: 12.0.sp,color: PdfColors.black),
         //                             ),
         //                           ]),
         //                         ],
         //                       ),
         //                     ]),
         //                     SizedBox(height: 0.3 * PdfPageFormat.cm),
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
      msg: "iiiiiiiiii",
      mode: mode,
      bytes: bytes,
      fileName: '${'StringAccountsArchive'.tr}.pdf',
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

