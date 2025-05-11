import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:open_filex/open_filex.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:path_provider/path_provider.dart';
import 'dart:io';
import '../../Operation/Controllers/sale_invoices_controller.dart';
import '../../Operation/models/bil_mov_m.dart';
import '../../Setting/controllers/login_controller.dart';
import '../../Setting/controllers/setting_controller.dart';
import '../../Widgets/config.dart';
import '../../Widgets/pdfpakage.dart';
import '../../database/setting_db.dart';
import '../file_helper.dart';
import 'package:pdf/widgets.dart';
import 'package:intl/intl.dart' as intl;
import '../simple_pdf.dart';

Future<void> generateReportFromDatabase({
  required String TAB_N,
  required String TAB_D,
  required int GETBMKID,
  required String TYPE,
  required String GETDateNow,
  required int GETBMMST,
  required String BMMDO_F,
  required String BMMDO_T,
  required String BIID_F,
  required String BIID_T,
  required String SCID_V,
  required String PKID_V,
  required int TYPE_SER,
}) async {

  try {

    final Sale_Invoices_Controller controller = Get.find();
    // دالة لجلب الحركات من قاعدة البيانات
    Future<List<Bil_Mov_M_Local>> getTransactions() async {
      var dbClient = await conn.database;
      String sql2='';
      String sqlBMMST='';
      String sqlSCID='';
      String sqlPKID='';
      String sqlBIID2='';

      sql2=" (A.BMMDOR BETWEEN '$BMMDO_F' AND '$BMMDO_T')  AND";

      if(BIID_F.isNotEmpty && BIID_F.toString()!='null' && BIID_T.isNotEmpty && BIID_T.toString()!='null'){
        sqlBIID2=" AND A.BIID2 BETWEEN $BIID_F AND $BIID_T ";
      }else{
        sqlBIID2='';
      }


      if( GETBMMST==1){
        sqlBMMST=" AND A.BMMST=1 ";
      }else if( GETBMMST==2){
        sqlBMMST=" AND A.BMMST=2 ";
      }else if( GETBMMST==3){
        sqlBMMST=" AND A.BMMST=4 ";
      }else{
        sqlBMMST='';
      }

      if(SCID_V.isNotEmpty && SCID_V.toString()!='null'){
        sqlSCID=" AND A.SCID=$SCID_V ";
      }else{
        sqlSCID='';
      }

      if(PKID_V.isNotEmpty && PKID_V.toString()!='null'){
        sqlPKID=" AND A.PKID=$PKID_V ";
      }else{
        sqlPKID='';
      }

      // if( TYPE=='DateNow' || TYPE=='FromDate' ){
      //   sql2=" AND A.BMMDO like'%$GETDateNow%' ";
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
          ? " AND A.BIID_L = E.BIID_L " :  '';
      String SQLBIID_L6 = LoginController().BIID_ALL_V == '1'
          ? " AND A.BIID_L = F.BIID_L " :  '';

      if(TYPE_SER==1){
        sql2='';
        sqlSCID='';
        sqlBIID2='';
        sqlPKID='';
      }


      String sql = '''
        SELECT A.BMMID,A.BMKID,A.BMMNO,A.BMMDO,A.SCID,A.PKID,A.BCID,A.SIID,A.AANO,A.BMMST,A.BIID2,
        A.BMMNA,A.BMMAM,A.BMMDI,A.BMMDIF,A.BMMTX,A.BMMMT,A.BMMTX1,A.BMMDIA,A.BMMTX11,
        CASE WHEN ${LoginController().LAN}=2 AND D.PKNE IS NOT NULL THEN D.PKNE ELSE D.PKNA END  PKNA_D,
        CASE WHEN ${LoginController().LAN}=2 AND C.SCNE IS NOT NULL THEN C.SCNE ELSE C.SCNA END  SCNA_D,
        A.BMMIN,B.MGNO,B.MINO,B.MUID,B.BMDNO,B.BMDNF,B.BMDAM,B.BMDTXT1,B.BMDDI,B.BMDAMT,B.BMDED,
        CASE WHEN ${LoginController().LAN}=2 AND E.MINE IS NOT NULL  THEN E.MINE ELSE E.MINA END  MINA_D,
        CASE WHEN ${LoginController().LAN}=2 AND F.MUNE IS NOT NULL  THEN F.MUNE ELSE F.MUNA END  MUNA_D
        FROM $TAB_N A JOIN $TAB_D B ON A.BMMID = B.BMMID AND A.JTID_L = B.JTID_L AND A.SYID_L = B.SYID_L
        AND A.CIID_L = B.CIID_L $SQLBIID_L2 JOIN PAY_KIN D ON A.PKID = D.PKID
        AND A.JTID_L = D.JTID_L AND A.SYID_L = D.SYID_L
        AND A.CIID_L = D.CIID_L $SQLBIID_L3
        JOIN SYS_CUR C ON A.SCID = C.SCID  AND A.JTID_L = C.JTID_L AND A.SYID_L = C.SYID_L
        AND A.CIID_L = C.CIID_L $SQLBIID_L4 
        JOIN MAT_INF E ON B.MGNO = E.MGNO AND B.MINO = E.MINO  
        AND A.JTID_L = E.JTID_L AND A.SYID_L = E.SYID_L
        AND A.CIID_L = E.CIID_L $SQLBIID_L5 
        JOIN MAT_UNI F ON B.MUID = F.MUID  AND A.JTID_L = F.JTID_L AND A.SYID_L = F.SYID_L
        AND A.CIID_L = F.CIID_L $SQLBIID_L6 
         WHERE A.BMKID=$GETBMKID $sqlBMMST $sqlSCID $sqlPKID AND $sql2  A.JTID_L=${LoginController().JTID} 
         AND A.SYID_L=${LoginController().SYID} AND A.CIID_L=${LoginController().CIID} 
        $SQLBIID_L
        ORDER BY A.BMMID ASC, A.BMMDO ASC
      ''';
      printLongText(sql);
      var result = await dbClient!.rawQuery(sql);
      print('عدد الحركات المسترجعة: ${result.length}');
      List<Bil_Mov_M_Local> list = result.map((item) {
        return Bil_Mov_M_Local.fromMap(item);
      }).toList();
      return list;
    }

    // جلب الحركات من قاعدة البيانات
    List<Bil_Mov_M_Local> transactions = await getTransactions();

    if (transactions.isEmpty) {
      print('لا توجد بيانات لإنشاء التقرير.');
      return;
    }

    // تنظيم البيانات حسب رقم الحركة (BMMID)
    Map<String, List<Bil_Mov_M_Local>> groupedTransactions = {};

    for (var transaction in transactions) {
      print('BMMID: ${transaction.BMMID}'); // لطباعة BMMID لكل حركة
      if (!groupedTransactions.containsKey(transaction.BMMID.toString())) {
        groupedTransactions[transaction.BMMID.toString()] = [];
      }
      groupedTransactions[transaction.BMMID.toString()]!.add(transaction);
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


    pdf.addPage(
        pw.MultiPage(
          maxPages: 1000,
      margin: pw.EdgeInsets.all(15),
      pageFormat: PdfPageFormat.a4,
      textDirection: pw.TextDirection.rtl,
      crossAxisAlignment: pw.CrossAxisAlignment.start,
      theme: pw.ThemeData.withFont(base: ttf),
          header: (context) =>StteingController().REPEAT_REP_HEADER==true?
          SimplePdf.buildHeader(3,ttf,'',controller,image):pw.Container(),
          build: (context) {
            List<pw.Widget> widgets = [];
         groupedTransactions.entries.map((entry) {
          final String bmmid = entry.key;
          final List<Bil_Mov_M_Local> details = entry.value; // تأكد من أن هذه قائمة جميع الحركات الفرعية
          // معلومات الحركة الرئيسية
          final Bil_Mov_M_Local mainTransaction = details.first;


            widgets.add(
              pw.Column(
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
                          SimplePdf.text('${mainTransaction.BMMDO}', ttf, fontSize: 15, color: PdfColors.red),
                          SimplePdf.text('التاريخ: ', ttf, fontSize: 15, color: PdfColors.black),
                        ],
                      ),
                      pw.Row(
                        crossAxisAlignment: pw.CrossAxisAlignment.start,
                        children: [
                          SimplePdf.text('${mainTransaction.BMMNO}', ttf, fontSize: 15, color: PdfColors.red),
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
                          SimplePdf.text(mainTransaction.BMMST.toString() == '2'
                              ? 'StringNotfinal'.tr : '${mainTransaction.BMMST}'.toString() == '4'
                              ? 'StringPending'.tr : 'Stringfinal'.tr, ttf, fontSize: 15, color: PdfColors.black),
                          SimplePdf.text('الحالة:', ttf, fontSize: 15, color: PdfColors.black),
                        ],
                      ),

                      pw.Row(
                        crossAxisAlignment: pw.CrossAxisAlignment.start,
                        children: [
                          SimplePdf.text('${mainTransaction.BMMNA}', ttf, fontSize: 15, color: PdfColors.black),
                          SimplePdf.text('اسم العميل:', ttf, fontSize: 15, color: PdfColors.black),
                        ],
                      ),

                    ],
                  ),
                  pw.SizedBox(height: 3),
                ],

            ));

          widgets.add(
            // جدول الحركات الفرعية
            pw.Table(
              border: pw.TableBorder.all(),
              columnWidths: controller.Show_Items_Expire_Date=='2'? {
                0: const  pw.FlexColumnWidth(0.9),
                1: const  pw.FlexColumnWidth(0.7),
                2: const  pw.FlexColumnWidth(0.7),
                3: const  pw.FlexColumnWidth(0.7),
                4: const  pw.FlexColumnWidth(0.5),
                5: const  pw.FlexColumnWidth(0.8),
                6: const  pw.FlexColumnWidth(0.4),
                7: const  pw.FlexColumnWidth(1.3),
              }:
              {
                0: const  pw.FlexColumnWidth(0.9),
                1: const  pw.FlexColumnWidth(0.7),
                2: const  pw.FlexColumnWidth(0.7),
                3: const  pw.FlexColumnWidth(0.7),
                4: const  pw.FlexColumnWidth(0.5),
                5: const  pw.FlexColumnWidth(0.4),
                6: const  pw.FlexColumnWidth(1.3),
              },
              children: [
                // عنوان الجدول
                pw.TableRow(
                  decoration: const  pw.BoxDecoration(
                    color: PdfColors.MyColors,
                  ),
                  children: [
                    SimplePdf.text('الإجمالي', ttf,fontSize: 12, color: PdfColors.black),
                    SimplePdf.text('الضريبة', ttf,fontSize: 12, color: PdfColors.black),
                    SimplePdf.text('التخفيض', ttf,fontSize: 12, color: PdfColors.black),
                    SimplePdf.text('السعر', ttf,fontSize: 12, color: PdfColors.black),
                    SimplePdf.text('الكمية', ttf,fontSize: 12, color: PdfColors.black),
                    if (controller.Show_Items_Expire_Date=='2') SimplePdf.text('تاريخ الانتهاء', ttf,fontSize: 12, color: PdfColors.black),
                    SimplePdf.text('الوحدة', ttf,fontSize: 12, color: PdfColors.black),
                    SimplePdf.text('الصنف', ttf,fontSize: 12, color: PdfColors.black),
                  ],
                ),
                // الحركات الفرعية
                ...details.map((detail) {
                  return pw.TableRow(
                    children: [
                      SimplePdf.text(formatter.format(detail.BMDAMT).toString(), ttf, fontSize: 12, color: PdfColors.black),
                      SimplePdf.text(formatter.format(detail.BMDTXT1).toString(), ttf, fontSize: 12, color: PdfColors.black),
                      SimplePdf.text(formatter.format(detail.BMDDI).toString(), ttf, fontSize: 12, color: PdfColors.black),
                      SimplePdf.text(formatter.format(detail.BMDAM).toString(), ttf, fontSize: 12, color: PdfColors.black),
                      SimplePdf.text(formatter.format(detail.BMDNO! + detail.BMDNF!).toString(), ttf, fontSize: 12, color: PdfColors.black),
                      if (controller.Show_Items_Expire_Date == '2') SimplePdf.text(detail.BMDED.toString(), ttf, fontSize: 12, color: PdfColors.black),
                      SimplePdf.text(detail.MUNA_D.toString(), ttf, fontSize: 12, color: PdfColors.black),
                      SimplePdf.text(detail.MINA_D.toString(), ttf, fontSize: 12, color: PdfColors.black),
                    ],
                  );
                }).toList(),
              ],
            ),);

          widgets.add(
            // جدول الحركات الفرعية
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
                        SimplePdf.text(formatter.format(mainTransaction.BMMAM!-mainTransaction.BMMTX!).toString(), ttf, fontSize: 13, color: PdfColors.black),
                        SimplePdf.text('الإجمالي', ttf, fontSize: 13, color: PdfColors.black),
                      ],
                    ),
                    mainTransaction.BMMDI! + mainTransaction.BMMDIA! > 0?
                    pw.TableRow(
                      children: [
                        SimplePdf.text(formatter.format(mainTransaction.BMMDI! + mainTransaction.BMMDI!).toString(), ttf, fontSize: 13, color: PdfColors.black),
                        SimplePdf.text('الخصم', ttf, fontSize: 13, color: PdfColors.black),
                      ],
                    ): pw.TableRow(children: []),
                    mainTransaction.BMMDIF! > 0?
                    pw.TableRow(
                      children: [
                        SimplePdf.text(formatter.format(mainTransaction.BMMDIF).toString(), ttf, fontSize: 13, color: PdfColors.black),
                        SimplePdf.text('تخفيض للمجاني', ttf, fontSize: 13, color: PdfColors.black),
                      ],
                    ): pw.TableRow(children: []),
                    pw.TableRow(
                      children: [
                        SimplePdf.text(formatter.format(mainTransaction.BMMTX1).toString(), ttf, fontSize: 13, color: PdfColors.black),
                        SimplePdf.text('الضريبة', ttf, fontSize: 13, color: PdfColors.black),
                      ],
                    ),
                    pw.TableRow(
                      children: [
                        SimplePdf.text(formatter.format(mainTransaction.BMMMT).toString(), ttf, fontSize: 13, color: PdfColors.red),
                        SimplePdf.text('الصافي', ttf, fontSize: 13, color: PdfColors.red),
                      ],
                    ),
                  ],
                ),
              ])
            ,);

          widgets.add(
            // جدول الحركات الفرعية
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
            );
          widgets.add(pw.SizedBox(height: 10));

        }).toList();
  return widgets;
  },
          footer: (context) =>  PdfPakage.buildFooter_pdf(context,ttf)),
    );

    // حفظ التقرير كملف PDF
    final output = await getTemporaryDirectory();
    final file = File("${output.path}/Invoice.pdf");
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
