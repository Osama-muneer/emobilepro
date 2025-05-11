import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:number_to_word_arabic/number_to_word_arabic.dart';
import 'package:open_filex/open_filex.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:path_provider/path_provider.dart';
import 'dart:io';
import '../../Operation/Controllers/Pay_Out_Controller.dart';
import '../../Operation/models/acc_mov_m.dart';
import '../../Setting/controllers/login_controller.dart';
import '../../Widgets/config.dart';
import '../../database/setting_db.dart';
import '../file_helper.dart';
import 'package:pdf/widgets.dart';
import 'package:intl/intl.dart' as intl;
import '../simple_pdf.dart';

Future<void> generateReportVou({
  required int GETAMKID,
  required String TYPE,
  required String GETDateNow,
  required int GETAMMST,
  required String AMMDO_F,
  required String AMMDO_T,
  required String BIID_F,
  required String BIID_T,
  required String SCID_V,
  required int TYPE_SER,
}) async {

  try {

    final Pay_Out_Controller controller = Get.find();
    // دالة لجلب الحركات من قاعدة البيانات
    Future<List<Acc_Mov_M_Local>> getTransactions() async {
      var dbClient = await conn.database;
      String sql2='';
      String sqlAMKID='';
      String sqlSCID='';
      String sqlBIID2='';
      String sqlAMKST='';

      sql2=" AND (A.AMMDOR BETWEEN '$AMMDO_F' AND '$AMMDO_T')  ";

      // if (TYPE == 'DateNow' || TYPE == 'FromDate') {
      //   sql2 = " A.AMMDOR like'%$GETDateNow%' AND";
      // }

      if (GETAMKID == 15) {
        sqlAMKID = " A.AMKID NOT IN (1,2,3) AND ";
      } else {
        sqlAMKID = " A.AMKID=$GETAMKID AND ";
      }

      if( GETAMMST==1){
        sqlAMKST="  A.AMMST=1 AND ";
      }else if( GETAMMST==2){
        sqlAMKST="  A.AMMST=2 AND ";
      }else if( GETAMMST==3){
        sqlAMKST="  A.AMMST=4 AND ";
      }else{
        sqlAMKST='';
      }

      if(SCID_V.isNotEmpty && SCID_V.toString()!='null'){
        sqlSCID=" AND A.SCID=$SCID_V ";
      }else{
        sqlSCID='';
      }

      if(BIID_F.isNotEmpty && BIID_F.toString()!='null' && BIID_T.isNotEmpty && BIID_T.toString()!='null'){
        sqlBIID2=" AND A.BIID2 BETWEEN $BIID_F AND $BIID_T ";
      }else{
        sqlBIID2='';
      }

      if(TYPE_SER==1){
        sql2='';
        sqlSCID='';
        sqlBIID2='';
      }

      // if( TYPE=='DateNow' || TYPE=='FromDate' ){
      //   sql2=" AND A.AMMDO like'%$GETDateNow%' ";
      // }
      String SQLBIID_L = LoginController().BIID_ALL_V == '1'
          ? " AND  A.BIID_L=${LoginController().BIID}" :  '';
      String SQLBIID_L2 = LoginController().BIID_ALL_V == '1'
          ? " AND A.BIID_L = B.BIID_L " :  '';
      String SQLBIID_L3 = LoginController().BIID_ALL_V == '1'
          ? " AND A.BIID_L = D.BIID_L " :  '';
      String SQLBIID_L4 = LoginController().BIID_ALL_V == '1'
          ? " AND A.BIID_L = C.BIID_L " :  '';
      String SQLBIID_L5 = LoginController().BIID_ALL_V == '1'
          ? " AND B.BIID_L = E.BIID_L " :  '';
      String SQLBIID_L6 = LoginController().BIID_ALL_V == '1'
          ? " AND A.BIID_L = F.BIID_L " :  '';


      String sql = '''
        SELECT A.AMMID,A.AMKID,A.AMMNO,A.AMMDO,A.BIID,A.AMMAM,A.AMMIN,B.AANO,B.AMDMD,B.AMDDA,B.AMDIN,
        CASE WHEN ${LoginController().LAN}=2 AND D.PKNE IS NOT NULL THEN D.PKNE ELSE D.PKNA END  PKNA_D,
        CASE WHEN ${LoginController().LAN}=2 AND C.SCNE IS NOT NULL THEN C.SCNE ELSE C.SCNA END  SCNA_D,
        CASE WHEN ${LoginController().LAN}=2 AND E.AANE IS NOT NULL THEN E.AANE ELSE E.AANA END  AANO_D
        FROM ACC_MOV_M A JOIN ACC_MOV_D B ON A.AMMID = B.AMMID AND A.JTID_L = B.JTID_L AND A.SYID_L = B.SYID_L
        AND A.CIID_L = B.CIID_L $SQLBIID_L2 JOIN PAY_KIN D ON A.PKID = D.PKID
        AND A.JTID_L = D.JTID_L AND A.SYID_L = D.SYID_L
        AND A.CIID_L = D.CIID_L $SQLBIID_L3
        JOIN SYS_CUR C ON A.SCID = C.SCID  AND A.JTID_L = C.JTID_L AND A.SYID_L = C.SYID_L
        AND A.CIID_L = C.CIID_L $SQLBIID_L4
        JOIN ACC_ACC E ON B.AANO = E.AANO  AND B.JTID_L = E.JTID_L AND B.SYID_L = E.SYID_L
        AND B.CIID_L = E.CIID_L $SQLBIID_L5  WHERE A.AMKID=$GETAMKID $sqlAMKST $sql2 $sqlBIID2 $sqlSCID  AND A.JTID_L=${LoginController().JTID} 
         AND A.SYID_L=${LoginController().SYID} AND A.CIID_L=${LoginController().CIID} 
        $SQLBIID_L
        ORDER BY A.AMMID ASC, A.AMMDO DESC
      ''';

      var result = await dbClient!.rawQuery(sql);
      print(result);
      print('عدد الحركات المسترجعة: ${result.length}');
      List<Acc_Mov_M_Local> list = result.map((item) {
        return Acc_Mov_M_Local.fromMap(item);
      }).toList();
      return list;
    }

    // جلب الحركات من قاعدة البيانات
    List<Acc_Mov_M_Local> transactions = await getTransactions();

    if (transactions.isEmpty) {
      print('لا توجد بيانات لإنشاء التقرير.');
      return;
    }

    // تنظيم البيانات حسب رقم الحركة (BMMID)
    Map<String, List<Acc_Mov_M_Local>> groupedTransactions = {};

    for (var transaction in transactions) {
      print('BMMID: ${transaction.AMMID}'); // لطباعة BMMID لكل حركة
      if (!groupedTransactions.containsKey(transaction.AMMID.toString())) {
        groupedTransactions[transaction.AMMID.toString()] = [];
      }
      groupedTransactions[transaction.AMMID.toString()]!.add(transaction);
    }

    groupedTransactions.forEach((key, value) {
      print('BMMID: $key, عدد الحركات الفرعية: ${value.length}');
    });

    print('عدد الحركات المتجمعة: ${groupedTransactions.map((key, value) => MapEntry(key, value.length))}');

    final pdf = pw.Document();

    final Uint8List fontData = await FileHelper.getFileFromAssets('Assets/fonts/HacenTunisia.ttf');
    final ttf = pw.Font.ttf(fontData.buffer.asByteData());
    final formatter = intl.NumberFormat.decimalPattern();

    final image = await SimplePdf.loadImage();


    pw.Widget buildText(String text, double fontSize) {
      return SimplePdf.text(
        text,
        ttf,
        fontSize: fontSize,
        color: PdfColors.black,
      );
    }

    String _getInvoiceTitle(int BMKID, String STMID) {
      switch (BMKID) {
        case 1:
          return 'StringReceipt_Vouchers'.tr;
        case 2:
          return 'StringPayOuts'.tr;
        case 3:
          return 'StringCollection_Vouchers'.tr;
        default:
          return 'StringJournalVouchers'.tr;
      }
    }

    pdf.addPage(
        pw.MultiPage(
          maxPages: 1000,
      margin: pw.EdgeInsets.all(15),
      pageFormat: PdfPageFormat.a4,
      textDirection: pw.TextDirection.rtl,
      crossAxisAlignment: pw.CrossAxisAlignment.start,
      theme: pw.ThemeData.withFont(base: ttf),
          header: (context) =>
              pw.Table(
              columnWidths: {
                0: const  pw.FlexColumnWidth(60),
                1: const  pw.FlexColumnWidth(60),
                2: const  pw.FlexColumnWidth(60),
              },
            border: pw.TableBorder.all(),
            children: [
              // عنوان الجدول
              pw.TableRow(
                children: [
                  pw.Column(children:[
                    pw.Row(
                        mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                        children: [
                          pw.Column(children: [
                            buildText(controller.SONE, 13),
                            buildText(controller.SOLN, 11),
                          ]),
                          pw.Column(
                              mainAxisAlignment: pw.MainAxisAlignment.center,
                              children: [
                                pw.Container(width: 70, child:  pw.Image(image)),
                          ]),
                          pw.Column(children: [
                            buildText(controller.SONA, 13),
                            buildText(controller.SORN, 11),
                            buildText(' العنوان:  ${controller.SOAD}', 10),
                          ]),
                        ]),
                    pw.Row(
                      mainAxisAlignment: pw.MainAxisAlignment.center,
                      children: [
                        pw.Expanded(
                          child: pw.Divider(
                            color: PdfColors.grey,
                            thickness: 1,
                          ),
                        ),
                        pw.Container(
                          margin: const pw.EdgeInsets.symmetric(horizontal: 10),
                          padding: const pw.EdgeInsets.symmetric(horizontal: 5, vertical: 5),
                          decoration: pw.BoxDecoration(
                            border: pw.Border.all(color: PdfColors.grey, width: 1),
                            borderRadius: pw.BorderRadius.circular(5),
                            color: PdfColors.white,
                          ),
                          child: pw.Text(
                            _getInvoiceTitle(controller.AMKID!, STMID),
                            style: pw.TextStyle(fontSize: 15),
                          ),
                        ),
                        pw.Expanded(
                          child: pw.Divider(
                            color: PdfColors.grey,
                            thickness: 1,
                          ),
                        ),
                      ],
                    ),
                    pw.SizedBox(height: 5),
                  ]),
                ],
              ),
            ],
          ),
          build: (context) => [
        ...groupedTransactions.entries.map((entry) {
          final List<Acc_Mov_M_Local> details = entry.value; // تأكد من أن هذه قائمة جميع الحركات الفرعية
          // معلومات الحركة الرئيسية
          final Acc_Mov_M_Local mainTransaction = details.first;
          return pw.Column(
            crossAxisAlignment: pw.CrossAxisAlignment.start,
            children: [
              pw.Row(
                mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                children: [
                  pw.Row(
                    crossAxisAlignment: pw.CrossAxisAlignment.start,
                    children: [
                      SimplePdf.text('${mainTransaction.SCNA_D}', ttf, fontSize: 15, color: PdfColors.red),
                      SimplePdf.text('العملة: ', ttf, fontSize: 15, color: PdfColors.black),
                    ],
                  ),
                  pw.Row(
                    crossAxisAlignment: pw.CrossAxisAlignment.start,
                    children: [
                      SimplePdf.text('${mainTransaction.PKNA_D}', ttf, fontSize: 15, color: PdfColors.red),
                      SimplePdf.text('الدفع: ', ttf, fontSize: 15, color: PdfColors.black),
                    ],
                  ),
                  pw.Row(
                    crossAxisAlignment: pw.CrossAxisAlignment.start,
                    children: [
                      SimplePdf.text('${mainTransaction.AMMDO}', ttf, fontSize: 15, color: PdfColors.red),
                      SimplePdf.text('التاريخ: ', ttf, fontSize: 15, color: PdfColors.black),
                    ],
                  ),
                  pw.Row(
                    crossAxisAlignment: pw.CrossAxisAlignment.start,
                    children: [
                      SimplePdf.text('${mainTransaction.AMMNO}', ttf, fontSize: 15, color: PdfColors.red),
                      SimplePdf.text('رقم الحركة: ', ttf, fontSize: 15, color: PdfColors.black),
                    ],
                  ),
                ],
              ),

              pw.Row(
                mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                children: [
                  pw.Row(
                    crossAxisAlignment: pw.CrossAxisAlignment.start,
                    children: [
                      SimplePdf.text(  mainTransaction.AMMST.toString() == '2'
                          ? 'StringNotfinal'.tr : '${mainTransaction.AMMST}'.toString() == '3'
                          ? 'StringPending'.tr : 'Stringfinal'.tr, ttf, fontSize: 15, color: PdfColors.black),
                      SimplePdf.text('الحالة:', ttf, fontSize: 15, color: PdfColors.black),
                    ],
                  ),

                  pw.Row(
                    crossAxisAlignment: pw.CrossAxisAlignment.start,
                    children: [
                      SimplePdf.text('${mainTransaction.AMMIN}', ttf, fontSize: 15, color: PdfColors.black),
                      SimplePdf.text('تفاصيل:', ttf, fontSize: 15, color: PdfColors.black),
                    ],
                  ),

                ],
              ),

              pw.Center(child:
              SimplePdf.text(
                LoginController().LAN == 2
                    ? '${controller.converter.convertDouble(double.parse(mainTransaction.AMMAM.toString().contains('.0') ? mainTransaction.AMMAM!.round().toString() : mainTransaction.AMMAM.toString())).replaceFirst(RegExp(r" و  و"), "")} ${mainTransaction.SCNA_D}'
                    : '${Tafqeet.convert( mainTransaction.AMMAM!.toString())} ${mainTransaction.SCNA_D}',
                ttf, fontSize: 15, color: PdfColors.red,
              ),
              ),


              pw.SizedBox(height: 3),

              // جدول الحركات الفرعية
              pw.Table(
                border: pw.TableBorder.all(),
                columnWidths:  {
                  0: const  pw.FlexColumnWidth(0.9),
                  1: const  pw.FlexColumnWidth(0.5),
                  2: const  pw.FlexColumnWidth(0.9),
                  3: const  pw.FlexColumnWidth(0.2),
                },
                children: [
                  // عنوان الجدول
                  pw.TableRow(
                    decoration: const  pw.BoxDecoration(
                      color: PdfColors.MyColors,
                    ),
                    children: [
                      SimplePdf.text('StringDetails'.tr, ttf,fontSize: 12, color: PdfColors.black),
                      SimplePdf.text('StringBMMAM'.tr, ttf,fontSize: 12, color: PdfColors.black),
                      SimplePdf.text('StringAccount'.tr, ttf,fontSize: 12, color: PdfColors.black),
                      SimplePdf.text('StringBIIDlableText'.tr, ttf,fontSize: 12, color: PdfColors.black),
                    ],
                  ),
                  // الحركات الفرعية
                  ...details.map((detail) {
                    return pw.TableRow(
                      children: [
                        SimplePdf.text(detail.AMDIN.toString(), ttf, fontSize: 12, color: PdfColors.black),
                        SimplePdf.text("${detail.AMKID == 2 ? "${controller.formatter.format(detail.AMDMD)}" :
                        "${controller.formatter.format(detail.AMDDA)}"}", ttf, fontSize: 12, color: PdfColors.black),
                        SimplePdf.text(detail.AANO_D.toString(), ttf, fontSize: 12, color: PdfColors.black),
                        SimplePdf.text(detail.BIID.toString(), ttf, fontSize: 12, color: PdfColors.black),
                      ],
                    );
                  }).toList(),
                ],
              ),
              pw.Row(children: [
                // جدول الإجماليات
                pw.Table(
                  border: pw.TableBorder.all(),
                  columnWidths: {
                    0: pw.FixedColumnWidth(84.7), // عرض العمود الأول
                    1: pw.FixedColumnWidth(66), // عرض العمود الثاني
                  },
                  children: [
                    pw.TableRow(
                      children: [
                        SimplePdf.text(formatter.format(mainTransaction.AMMAM).toString(), ttf, fontSize: 13, color: PdfColors.red),
                        SimplePdf.text('الإجمالي', ttf, fontSize: 13, color: PdfColors.red),
                      ],
                    ),
                  ],
                ),
              ]),
              pw.Table(border:  pw.TableBorder.all(),
                  children: [
                    pw.TableRow(
                  children: [
                    pw.Container(
                      padding: const  pw.EdgeInsets.only(right: 1, left: 1),
                      /// height: 630,
                      child:  pw.Container(
                          padding: pw.EdgeInsets.all(3),
                          child: SimplePdf.text(
                            controller.SDDSA,
                            ttf,
                            fontSize: 10,
                            align: TextAlign.center,
                            color: PdfColors.black,
                          ),
                        ),

                    ),
                  ],
                ),
              ]),
              pw.SizedBox(height: 10),
            ],
          );
        }).toList(),
      ],
          footer: (context) =>  pw.Column(children: [
            pw.Row(mainAxisAlignment:  pw.MainAxisAlignment.spaceBetween, children: [
              SimplePdf.text(
                'StrinUser'.tr + ' ${LoginController().SUNA}',
                ttf,
                fontSize: 9,
                color: PdfColors.black,
              ),
              pw.Text('Page ${context.pageNumber}  of ${context.pagesCount}',
                  style: const  pw.TextStyle(fontSize: 9)),
              SimplePdf.text(
                'StringDateofPrinting'.tr + ': ' + '${intl.DateFormat('dd-MM-yyyy HH:m').format(DateTime.now())}',
                ttf,
                fontSize: 9,
                color: PdfColors.black,
              ),
            ])
          ]),
    ));

    // حفظ التقرير كملف PDF
    final output = await getTemporaryDirectory();
    final file = File("${output.path}/Vouchers.pdf");
    await file.writeAsBytes(await pdf.save());
    print('تم إنشاء التقرير: ${file.path}');
    await OpenFilex.open(file.path);
  } catch (e, stackTrace) {
    Fluttertoast.showToast(
        msg: e.toString(),
        toastLength: Toast.LENGTH_LONG,
        textColor: Colors.white,
        backgroundColor: Colors.redAccent);
    print('خطأ أثناء إنشاء التقرير: $e');
    print(stackTrace);
  }

}
