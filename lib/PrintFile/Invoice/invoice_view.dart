import 'package:number_to_word_arabic/number_to_word_arabic.dart';
import '../../Operation/Controllers/sale_invoices_controller.dart';
import '../../Operation/models/bil_mov_d.dart';
import '../../PrintFile/share_mode.dart';
import '../../PrintFile/simple_pdf.dart';
import '../../Setting/controllers/setting_controller.dart';
import 'package:flutter/material.dart' as ma;
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:pdf/widgets.dart';
import '../invoice_controller.dart';
import '../file_helper.dart';


Pdf_Invoices({
  String? GetBMKID,
  String? GetBMMDO,
  String? GetBMMNO,
  String? GetPKNA,
  String? Type_Model_A4,
  required ShareMode mode,
  // required UserTaxInfo userTaxInfo,
  // required InvoiceSetting invoiceSetting,
}) async {
   try {
  final Sale_Invoices_Controller controller = Get.find();

  var item = controller.BIF_MOV_M_PRINT.elementAt(0);
  bool Scsy_b = controller.BIF_MOV_M_PRINT.elementAt(0).SCSY=='SAR';

  String qrData =item.BMMFQR.toString().isEmpty ||
      item.BMMFQR.toString()=='null'? await  InvoiceController.zatcaQrData(
    nameSaller: controller.SONA.toString(),
    invoiceTotalAmount: item.BMMMT.toString(),
    invoiceTaxAmount: item.BMMTX1.toString(),
    taxNumber: controller.SOTX.toString(),
  ): item.BMMFQR.toString();


  final pdf = pw.Document();
  final Uint8List fontData = await FileHelper.getFileFromAssets('Assets/fonts/HacenTunisia.ttf');
  final Uint8List fontSa = await FileHelper.getFileFromAssets('Assets/fonts/NewRiyal-Regular.ttf');
  final font = pw.Font.ttf(fontData.buffer.asByteData());
  final Sau = pw.Font.ttf(fontSa.buffer.asByteData());

  final image = await SimplePdf.loadImage();
///  final pw.MemoryImage imageData = await SimplePdf.getSaudiRiyalImage();

  Widget buildImage(){
    return SimplePdf.text(
      "\$",
      Sau,
      fontSize: 18,
    );
  }
  
  pdf.addPage(
        MultiPage(
      pageFormat: PdfPageFormat.a4,
          margin: EdgeInsets.all(15),
          header: (context) =>   StteingController().REPEAT_REP_HEADER==true?
          SimplePdf.buildHeader(1,font,GetPKNA,controller,image):Container(),
          build: (Context context)=> [
            if(StteingController().REPEAT_REP_HEADER==false)
            SimplePdf.buildHeader(1,font,GetPKNA,controller,image),
            Type_Model_A4=='3'?
            Table(border: TableBorder.all(), children: [
           TableRow(
             children: [
               pw.Container(
                 padding: const EdgeInsets.only(right: 1, left: 1),
                 /// height: 630,
                 child: Column(children: [
                   Padding(
                     padding: const EdgeInsets.only(right: 2, left: 2, top: 3),
                     child: Table(border: TableBorder.all(), children: [
                       TableRow(
                         children: [
                           Container(
                             decoration: const BoxDecoration(),
                             padding: const EdgeInsets.all(1),
                             child: Padding(
                                 padding: const EdgeInsets.only(left: 2, top: 2,bottom: 2),
                                 child: Column(
                                   children: [
                                     Row(children: [
                                       Table(border: TableBorder.all(),columnWidths: {
                                         0: FixedColumnWidth(90),// العمود الأول
                                       },
                                           children: [
                                         TableRow(
                                           children: [
                                             Container(

                                               decoration: const BoxDecoration(),
                                               padding: const EdgeInsets.all(1),
                                               child: Column(children: [
                                                 SimplePdf.text(
                                                   '.Invoice NO',
                                                   font,
                                                   align: TextAlign.right,
                                                   fontSize: 10,
                                                   color: PdfColors.black,
                                                 ),
                                               ]),
                                             ),
                                           ],
                                         ),
                                         TableRow(
                                           children: [
                                             Container(

                                               decoration: const BoxDecoration(),
                                               padding: const EdgeInsets.all(1),
                                               child: Column(children: [
                                                 SimplePdf.text(
                                                   'Invoice issue date',
                                                   font,
                                                   align: TextAlign.right,
                                                   fontSize: 10,
                                                   color: PdfColors.black,
                                                 ),
                                               ]),
                                             ),
                                           ],
                                         ),
                                         TableRow(
                                           children: [
                                             Container(

                                               decoration: const BoxDecoration(),
                                               padding: const EdgeInsets.all(1),
                                               child: Column(children: [
                                                 SimplePdf.text(
                                                   'Date of Supply',
                                                   font,
                                                   align: TextAlign.right,
                                                   fontSize: 10,
                                                   color: PdfColors.black,
                                                 ),
                                               ]),
                                             ),
                                           ],
                                         ),
                                       ]),
                                       Table(border: TableBorder.all(),columnWidths: {
                                         0: FixedColumnWidth(100),// العمود الأول
                                       },
                                           children: [
                                         TableRow(
                                           children: [
                                             Container(

                                               decoration: const BoxDecoration(),
                                               padding: const EdgeInsets.all(1),
                                               child: Column(children: [
                                                 SimplePdf.text(GetBMMNO!,
                                                   font,
                                                   align: TextAlign.right,
                                                   fontSize: 10,
                                                   color: PdfColors.black,
                                                 ),
                                               ]),
                                             ),
                                           ],
                                         ),
                                         TableRow(
                                           children: [
                                             Container(

                                               decoration: const BoxDecoration(),
                                               padding: const EdgeInsets.all(1),
                                               child: Column(children: [
                                                 SimplePdf.text(
                                                   GetBMMDO!,
                                                   font,
                                                   align: TextAlign.right,
                                                   fontSize: 10,
                                                   color: PdfColors.black,
                                                 ),
                                               ]),
                                             ),
                                           ],
                                         ),
                                         TableRow(
                                           children: [
                                             Container(
                                               decoration: const BoxDecoration(),
                                               padding: const EdgeInsets.all(1),
                                               child: Column(children: [
                                                 SimplePdf.text(
                                                   GetBMMDO,
                                                   font,
                                                   align: TextAlign.right,
                                                   fontSize: 10,
                                                   color: PdfColors.black,
                                                 ),
                                               ]),
                                             ),
                                           ],
                                         ),
                                       ]),
                                       Table(border: TableBorder.all(), columnWidths: {
                                         0: FixedColumnWidth(90),// العمود الأول
                                       },
                                           children: [
                                         TableRow(
                                           children: [
                                             Container(

                                               decoration: const BoxDecoration(),
                                               padding: const EdgeInsets.all(1),
                                               child: Column(children: [
                                                 SimplePdf.text(
                                                   'رقم الفاتورة',
                                                   font,
                                                   align: TextAlign.right,
                                                   fontSize: 10,
                                                   color: PdfColors.black,
                                                 ),
                                               ]),
                                             ),
                                           ],
                                         ),
                                         TableRow(
                                           children: [
                                             Container(

                                               decoration: const BoxDecoration(),
                                               padding: const EdgeInsets.all(1),
                                               child: Column(children: [
                                                 SimplePdf.text(
                                                   'تاريخ اصدار الفاتورة',
                                                   font,
                                                   align: TextAlign.right,
                                                   fontSize: 10,
                                                   color: PdfColors.black,
                                                 ),
                                               ]),
                                             ),
                                           ],
                                         ),
                                         TableRow(
                                           children: [
                                             Container(

                                               decoration: const BoxDecoration(),
                                               padding: const EdgeInsets.all(1),
                                               child: Column(children: [
                                                 SimplePdf.text(
                                                   'تاريخ التوريد',
                                                   font,
                                                   align: TextAlign.right,
                                                   fontSize: 10,
                                                   color: PdfColors.black,
                                                 ),
                                               ]),
                                             ),
                                           ],
                                         ),
                                       ]),
                                     [1,10].contains(controller.BIF_MOV_M_PRINT.elementAt(0).BMMFST)?
                                     Padding(
                                           padding: const EdgeInsets.only(left: 190,top: 8),
                                           child:Container(
                                             alignment: pw.Alignment.center,
                                             child: Container(
                                               width: 80,
                                               height: 50,
                                               child: pw.BarcodeWidget(
                                                 color: PdfColor.fromHex("#000000"),
                                                 barcode: pw.Barcode.qrCode(),
                                                 data: qrData.toString(),
                                               ),
                                             ),
                                           ))
                                         :Container(),
                                     ]),
                                     Row(children: [
                                       Table(border: TableBorder.all(),columnWidths: {
                                         0: FixedColumnWidth(280),// العمود الأول
                                       }, children: [
                                         TableRow(
                                           children: [
                                             Container(

                                               decoration: const BoxDecoration(
                                                 color: PdfColors.MyColors,
                                               ),
                                               padding: const EdgeInsets.all(1),
                                               child: SimplePdf.text(
                                                 GetBMKID=='3'?"${'StringSalesInvoices'.tr}-$GetPKNA":GetBMKID=='4'?"${'StringBIL_MOV_OUT_R'.tr}-$GetPKNA":
                                                 GetBMKID=='11'?"${'StringPOSInvoice'.tr}-$GetPKNA": GetBMKID=='12'?"${'StringBIF_MOV_MOR'.tr}-$GetPKNA":
                                                 GetBMKID=='7'?"عرض سعر-$GetPKNA":
                                                 GetBMKID=='10'?"طلب عميل-$GetPKNA":
                                                 "${'StringPurchases_Invoices'.tr}-$GetPKNA",
                                                 font,
                                                 align: TextAlign.center,
                                                 fontSize: 12,
                                                 color: PdfColors.black,
                                               ),
                                             ),
                                           ],
                                         ),
                                       ]),
                                     ]),
                                   ],
                                 )),
                           ),
                         ],
                       ),
                     ]),
                   ),
                   Padding(
                       padding: const EdgeInsets.only(right: 2, left: 2, top: 3),
                       child: Row(children: [
                         Table(border: TableBorder.all(),
                             columnWidths: {
                               0: FixedColumnWidth(280),// العمود الأول
                               1: FixedColumnWidth(280),// العمود الأول
                             },
                             children: [
                           TableRow(
                             children: [
                               Container(
                                // width: 238,
                                 decoration: const BoxDecoration(color: PdfColors.MyColors),
                                 padding: const EdgeInsets.all(1),
                                 child: controller.BMKID==1?SimplePdf.text(
                                   'العميل Customer',
                                   font,
                                   align: TextAlign.center,
                                   fontSize: 11,
                                   color: PdfColors.black,
                                 ): SimplePdf.text(
                                   'المورد/المصنع Supplier',
                                   font,
                                   align: TextAlign.center,
                                   fontSize: 11,
                                   color: PdfColors.black,
                                 ),
                               ),
                             ],
                           ),
                           TableRow(
                             children: [
                               Container(
                                 padding: const EdgeInsets.only(right: 4, left: 4),
                               //  width: 238,
                                 height: 170,
                                 child: Column(
                                     mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                     children: [
                                   Row(
                                       mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                       children: [
                                         SimplePdf.text(
                                           'Name',
                                           font,
                                           fontSize: 9,
                                         ),
                                         SimplePdf.text(
                                           controller.SONA,
                                           font,
                                           fontSize: 9,
                                         ),
                                         SimplePdf.text(
                                           'الاسم',
                                           font,
                                           fontSize: 9,
                                         ),
                                       ]),
                                   Row(
                                       mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                       children: [
                                         SimplePdf.text(
                                           'Building No.',
                                           font,
                                           fontSize: 9,
                                           color: PdfColors.black,
                                         ),
                                         SimplePdf.text(
                                           controller.SOBN,
                                           font,
                                           fontSize: 9,
                                           color: PdfColors.black,
                                         ),
                                         SimplePdf.text(
                                           'رقم البنايه',
                                           font,
                                           fontSize: 9,
                                           color: PdfColors.black,
                                         ),
                                       ]),
                                   Row(
                                       mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                       children: [
                                         SimplePdf.text(
                                           'Street Name',
                                           font,
                                           fontSize: 9,
                                           color: PdfColors.black,
                                         ),
                                         SimplePdf.text(
                                           controller.SOSN,
                                           font,
                                           fontSize: 9,
                                           color: PdfColors.black,
                                         ),
                                         SimplePdf.text(
                                           'اسم الشارع',
                                           font,
                                           fontSize: 9,
                                           color: PdfColors.black,
                                         ),
                                       ]),
                                   Row(
                                       mainAxisAlignment:
                                       MainAxisAlignment.spaceBetween,
                                       children: [
                                         SimplePdf.text(
                                           'District\Quarter',
                                           font,
                                           fontSize: 9,
                                           color: PdfColors.black,
                                         ),
                                         SimplePdf.text(
                                           controller.SOQN,
                                           font,
                                           fontSize: 9,
                                           color: PdfColors.black,
                                         ),
                                         SimplePdf.text(
                                           'الحي/المنطقه',
                                           font,
                                           fontSize: 9,
                                           color: PdfColors.black,
                                         ),
                                       ]),
                                   Row(
                                       mainAxisAlignment:
                                       MainAxisAlignment.spaceBetween,
                                       children: [
                                         SimplePdf.text(
                                           'City',
                                           font,
                                           fontSize: 9,
                                           color: PdfColors.black,
                                         ),
                                         SimplePdf.text(
                                           controller.CTID=='null'?'':controller.CTID,
                                           font,
                                           fontSize: 9,
                                           color: PdfColors.black,
                                         ),
                                         SimplePdf.text(
                                           'المدينه',
                                           font,
                                           fontSize: 9,
                                           color: PdfColors.black,
                                         ),
                                       ]),
                                   Row(
                                       mainAxisAlignment:
                                       MainAxisAlignment.spaceBetween,
                                       children: [
                                         SimplePdf.text(
                                           'Country',
                                           font,
                                           fontSize: 9,
                                           color: PdfColors.black,
                                         ),
                                         SimplePdf.text(
                                           controller.CWID=='null'?'':controller.CWID,
                                           font,
                                           fontSize: 9,
                                           color: PdfColors.black,
                                         ),
                                         SimplePdf.text(
                                           'الدوله',
                                           font,
                                           fontSize: 9,
                                           color: PdfColors.black,
                                         ),
                                       ]),
                                   Row(
                                       mainAxisAlignment:
                                       MainAxisAlignment.spaceBetween,
                                       children: [
                                         SimplePdf.text(
                                           'Postal Code',
                                           font,
                                           fontSize: 9,
                                           color: PdfColors.black,
                                         ),
                                         SimplePdf.text(
                                           controller.SOPC,
                                           font,
                                           fontSize: 9,
                                           color: PdfColors.black,
                                         ),
                                         SimplePdf.text(
                                           'الرمز البريدي',
                                           font,
                                           fontSize: 9,
                                           color: PdfColors.black,
                                         ),
                                       ]),
                                   Row(
                                       mainAxisAlignment:
                                       MainAxisAlignment.spaceBetween,
                                       children: [
                                         SimplePdf.text(
                                           'Additional Address No.',
                                           font,
                                           fontSize: 9,
                                           color: PdfColors.black,
                                         ),
                                         SimplePdf.text(
                                           controller.SOAD2,
                                           font,
                                           fontSize: 9,
                                           color: PdfColors.black,
                                         ),
                                         SimplePdf.text(
                                           'رقم اضافي للعنوان',
                                           font,
                                           fontSize: 9,
                                           color: PdfColors.black,
                                         ),
                                       ]),
                                   Row(
                                       mainAxisAlignment:
                                       MainAxisAlignment.spaceBetween,
                                       children: [
                                         SimplePdf.text(
                                           'VAT Number',
                                           font,
                                           fontSize: 9,
                                           color: PdfColors.black,
                                         ),
                                         SimplePdf.text(
                                           controller.SOTX,
                                           font,
                                           fontSize: 9,
                                           color: PdfColors.black,
                                         ),
                                         SimplePdf.text(
                                           'رقم تسجيل ضريبة '
                                               'القيمه المضافه',
                                           font,
                                           fontSize: 9,
                                           color: PdfColors.black,
                                         ),
                                       ]),
                                   Row(
                                       mainAxisAlignment:
                                       MainAxisAlignment.spaceBetween,
                                       children: [
                                         SimplePdf.text(
                                           'Tel.',
                                           font,
                                           fontSize: 9,
                                           color: PdfColors.black,
                                         ),
                                         SimplePdf.text(
                                           controller.SOTL,
                                           font,
                                           fontSize: 9,
                                           color: PdfColors.black,
                                         ),
                                         SimplePdf.text(
                                           'هاتف',
                                           font,
                                           fontSize: 9,
                                           color: PdfColors.black,
                                         ),
                                       ]),
                                   Row(
                                       mainAxisAlignment:
                                       MainAxisAlignment.spaceBetween,
                                       children: [
                                         SimplePdf.text(
                                           'Commercial registration number',
                                           font,
                                           fontSize: 9,
                                           color: PdfColors.black,
                                         ),
                                         SimplePdf.text(
                                           controller.SOC1,
                                           font,
                                           fontSize: 9,
                                           color: PdfColors.black,
                                         ),
                                         SimplePdf.text(
                                           'رقم السجل التجاري',
                                           font,
                                           fontSize: 9,
                                           color: PdfColors.black,
                                         ),
                                       ]),
                                 ]),
                               ),
                             ],
                           )
                         ]),
                         Table(border: TableBorder.all(),columnWidths: {
                           0: FixedColumnWidth(280),// العمود الأول
                           1: FixedColumnWidth(280),// العمود الأول
                         }, children: [
                           TableRow(
                             children: [
                               Container(
                               //  width: 238,
                                 decoration:
                                 const BoxDecoration(color: PdfColors.MyColors),
                                 padding: const EdgeInsets.all(1),
                                 child: controller.BMKID==1?SimplePdf.text(
                                   'المورد/المصنع Supplier',
                                   font,
                                   align: TextAlign.center,
                                   fontSize: 11,
                                   color: PdfColors.black,
                                 ):SimplePdf.text(
                                   'العميل Customer',
                                   font,
                                   align: TextAlign.center,
                                   fontSize: 11,
                                   color: PdfColors.black,
                                 ),
                               ),
                             ],
                           ),
                           TableRow(
                             children: [
                               Container(
                                 padding: const EdgeInsets.only(right: 4, left: 4),
                                // width: 238,
                                 height: 170,
                                 child: Column(children: [
                                   Row(
                                       mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                       children: [
                                         SimplePdf.text(
                                           'Name',
                                           font,
                                           fontSize: 9,
                                         ),
                                         SimplePdf.text(
                                           controller.BCNA,
                                           font,
                                           fontSize: 9,
                                         ),
                                         SimplePdf.text(
                                           'الاسم',
                                           font,
                                           fontSize: 9,
                                         ),
                                       ]),
                                   Row(
                                       mainAxisAlignment:
                                       MainAxisAlignment.spaceBetween,
                                       children: [
                                         SimplePdf.text(
                                           'Building No.',
                                           font,
                                           fontSize: 9,
                                           color: PdfColors.black,
                                         ),
                                         SimplePdf.text(
                                           controller.BCBN,
                                           font,
                                           fontSize: 9,
                                           color: PdfColors.black,
                                         ),
                                         SimplePdf.text(
                                           'رقم البنايه',
                                           font,
                                           fontSize: 9,
                                           color: PdfColors.black,
                                         ),
                                       ]),
                                   Row(
                                       mainAxisAlignment:
                                       MainAxisAlignment.spaceBetween,
                                       children: [
                                         SimplePdf.text(
                                           'Street Name',
                                           font,
                                           fontSize: 9,
                                           color: PdfColors.black,
                                         ),
                                         SimplePdf.text(
                                           controller.BCSN=='null'?'':controller.BCSN,
                                           font,
                                           fontSize: 9,
                                           color: PdfColors.black,
                                         ),
                                         SimplePdf.text(
                                           'اسم الشارع',
                                           font,
                                           fontSize: 9,
                                           color: PdfColors.black,
                                         ),
                                       ]),
                                   Row(
                                       mainAxisAlignment:
                                       MainAxisAlignment.spaceBetween,
                                       children: [
                                         SimplePdf.text(
                                           'District\Quarter',
                                           font,
                                           fontSize: 9,
                                           color: PdfColors.black,
                                         ),
                                         SimplePdf.text(
                                           controller.BCQND=='null'?'': controller.BCQND,
                                           font,
                                           fontSize: 9,
                                           color: PdfColors.black,
                                         ),
                                         SimplePdf.text(
                                           'الحي/المنطقه',
                                           font,
                                           fontSize: 9,
                                           color: PdfColors.black,
                                         ),
                                       ]),
                                   Row(
                                       mainAxisAlignment:
                                       MainAxisAlignment.spaceBetween,
                                       children: [
                                         SimplePdf.text(
                                           'City',
                                           font,
                                           fontSize: 9,
                                           color: PdfColors.black,
                                         ),
                                         SimplePdf.text(
                                           controller.CTNA=='null'?'':controller.CTNA,
                                           font,
                                           fontSize: 9,
                                           color: PdfColors.black,
                                         ),
                                         SimplePdf.text(
                                           'المدينه',
                                           font,
                                           fontSize: 9,
                                           color: PdfColors.black,
                                         ),
                                       ]),
                                   Row(
                                       mainAxisAlignment:
                                       MainAxisAlignment.spaceBetween,
                                       children: [
                                         SimplePdf.text(
                                           'Country',
                                           font,
                                           fontSize: 9,
                                           color: PdfColors.black,
                                         ),
                                         SimplePdf.text(
                                           controller.CWNA,
                                           font,
                                           fontSize: 9,
                                           color: PdfColors.black,
                                         ),
                                         SimplePdf.text(
                                           'الدوله',
                                           font,
                                           fontSize: 9,
                                           color: PdfColors.black,
                                         ),
                                       ]),
                                   Row(
                                       mainAxisAlignment:
                                       MainAxisAlignment.spaceBetween,
                                       children: [
                                         SimplePdf.text(
                                           'Postal Code',
                                           font,
                                           fontSize: 9,
                                           color: PdfColors.black,
                                         ),
                                         SimplePdf.text(
                                           controller.BCPC,
                                           font,
                                           fontSize: 9,
                                           color: PdfColors.black,
                                         ),
                                         SimplePdf.text(
                                           'الرمز البريدي',
                                           font,
                                           fontSize: 9,
                                           color: PdfColors.black,
                                         ),
                                       ]),
                                   Row(
                                       mainAxisAlignment:
                                       MainAxisAlignment.spaceBetween,
                                       children: [
                                         SimplePdf.text(
                                           'Additional Address No.',
                                           font,
                                           fontSize: 9,
                                           color: PdfColors.black,
                                         ),
                                         SimplePdf.text(
                                           controller.BCAD2,
                                           font,
                                           fontSize: 9,
                                           color: PdfColors.black,
                                         ),
                                         SimplePdf.text(
                                           'رقم اضافي للعنوان',
                                           font,
                                           fontSize: 9,
                                           color: PdfColors.black,
                                         ),
                                       ]),
                                   Row(
                                       mainAxisAlignment:
                                       MainAxisAlignment.spaceBetween,
                                       children: [
                                         SimplePdf.text(
                                           'VAT Number',
                                           font,
                                           fontSize: 9,
                                           color: PdfColors.black,
                                         ),
                                         SimplePdf.text(
                                           controller.BCTX,
                                           font,
                                           fontSize: 9,
                                           color: PdfColors.black,
                                         ),
                                         SimplePdf.text(
                                           'رقم تسجيل ضريبة القيمه المضافه',
                                           font,
                                           fontSize: 9,
                                           color: PdfColors.black,
                                         ),
                                       ]),
                                   Row(
                                       mainAxisAlignment:
                                       MainAxisAlignment.spaceBetween,
                                       children: [
                                         SimplePdf.text(
                                           'Tel.',
                                           font,
                                           fontSize: 9,
                                           color: PdfColors.black,
                                         ),
                                         SimplePdf.text(
                                           controller.BCTL,
                                           font,
                                           fontSize: 9,
                                           color: PdfColors.black,
                                         ),
                                         SimplePdf.text(
                                           'هاتف',
                                           font,
                                           fontSize: 9,
                                           color: PdfColors.black,
                                         ),
                                       ]),
                                   Row(
                                       mainAxisAlignment:
                                       MainAxisAlignment.spaceBetween,
                                       children: [
                                         SimplePdf.text(
                                           'Commercial registration number',
                                           font,
                                           fontSize: 9,
                                           color: PdfColors.black,
                                         ),
                                         SimplePdf.text(
                                           controller.BCC1,
                                           font,
                                           fontSize: 9,
                                           color: PdfColors.black,
                                         ),
                                         SimplePdf.text(
                                           'رقم السجل التجاري',
                                           font,
                                           fontSize: 9,
                                           color: PdfColors.black,
                                         ),
                                       ]),
                                 ]),
                               ),
                             ],
                           )
                         ]),
                       ])),
                   SizedBox(height: 2),
                   Divider(height: 1),
                   Padding(
                       padding: const EdgeInsets.only(right: 2, left: 2, top: 3),
                       child: Row(children: [

                         Table(border: TableBorder.all(),columnWidths: {
                           0: FixedColumnWidth(280),// العمود الأول
                           1: FixedColumnWidth(280),// العمود الأول
                         },
                             children: [
                           TableRow(
                             children: [
                               Container(
                          //       width: 238,
                                 decoration: const BoxDecoration(color: PdfColors.MyColors),
                                 padding: const EdgeInsets.all(1),
                                 child: Column(children: [
                                   SimplePdf.text(
                                     'Additional Data',
                                     font,
                                     align: TextAlign.right,
                                     fontSize: 11,
                                     color: PdfColors.black,
                                   ),
                                 ]),
                               ),
                             ],
                           ),
                           TableRow(
                             children: [
                               pw.Container(
                                 padding: const pw.EdgeInsets.only(right: 8, left: 8),
                              //   width: 238,
                                 height: 50,
                                 child: Column(children: [
                                   Row(
                                       mainAxisAlignment:
                                       MainAxisAlignment.spaceBetween,
                                       children: [
                                         SimplePdf.text(
                                           'Currency',
                                           font,
                                           fontSize: 9,
                                           color: PdfColors.black,
                                         ),
                                         Scsy_b? pw.Row(
                                           mainAxisAlignment: pw.MainAxisAlignment.center, // توسيط المحتوى
                                           children: [
                                             buildImage(),
                                             pw.SizedBox(width: 5), // مسافة صغيرة بين النص والصورة
                                             // ✅ النص
                                             SimplePdf.text(
                                               "${controller.BIF_MOV_M_PRINT.elementAt(0).SCNA_D.toString()}",
                                               font,
                                               align: TextAlign.center,
                                               fontSize: 9,
                                               color: PdfColors.black,
                                             ),
                                           ],
                                         ):
                                         SimplePdf.text(
                                           "${controller.BIF_MOV_M_PRINT.elementAt(0).SCNA_D.toString()} ${controller.BIF_MOV_M_PRINT.elementAt(0).SCSY.toString()}",
                                           font,
                                           fontSize: 9,
                                           color: PdfColors.black,
                                         ),
                                         SimplePdf.text(
                                           'العمله',
                                           font,
                                           fontSize: 9,
                                           color: PdfColors.black,
                                         ),
                                       ]),
                                   Row(
                                       mainAxisAlignment:
                                       MainAxisAlignment.spaceBetween,
                                       children: [
                                         SimplePdf.text(
                                           'State',
                                           font,
                                           fontSize: 9,
                                           color: PdfColors.black,
                                         ),
                                         SimplePdf.text(
                                           controller.BIF_MOV_M_PRINT.elementAt(0).BMMST.toString()=='2' ? 'StringNotfinal'.tr
                                               : '${controller.BIF_MOV_M_PRINT.elementAt(0).BMMST}'.toString() == '4' ? 'StringPending'.tr : 'Stringfinal'.tr,
                                           font,
                                           fontSize: 9,
                                           color: PdfColors.black,
                                         ),
                                         SimplePdf.text(
                                           'الحاله',
                                           font,
                                           fontSize: 9,
                                           color: PdfColors.black,
                                         ),
                                       ]),
                                 ]),
                               ),
                             ],
                           )
                         ]),
                         Table(border: TableBorder.all(),columnWidths: {
                         0: FixedColumnWidth(280),// العمود الأول
                         1: FixedColumnWidth(280),// العمود الأول
                          },
                         children: [
                           TableRow(
                             children: [
                               Container(
                                // width: 238,
                                 decoration: const BoxDecoration(color: PdfColors.MyColors),
                                 padding: const EdgeInsets.all(1),
                                 child: Column(children: [
                                   SimplePdf.text(
                                     'بيانات اضافيه',
                                     font,
                                     align: TextAlign.right,
                                     fontSize: 11,
                                     color: PdfColors.black,
                                   ),
                                 ]),
                               ),
                             ],
                           ),
                           TableRow(
                             children: [
                               pw.Container(
                                 padding:
                                 const pw.EdgeInsets.only(right: 8, left: 8),
                                // width: 238,
                                 height: 50,
                                 child: Column(children: [
                                   Row(
                                       mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                       children: [
                                         SimplePdf.text(
                                           'Branch',
                                           font,
                                           fontSize: 9,
                                           color: PdfColors.black,
                                         ),
                                         SimplePdf.text(
                                           "${controller.BIF_MOV_M_PRINT.elementAt(0).BINA_D.toString()} ",
                                           font,
                                           fontSize: 9,
                                           color: PdfColors.black,
                                         ),
                                         SimplePdf.text(
                                           'الفرع',
                                           font,
                                           fontSize: 9,
                                           color: PdfColors.black,
                                         ),
                                       ]),
                                       controller.BMKID==11 || controller.BMKID==12?Row(
                                       mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                       children: [
                                         SimplePdf.text(
                                           'No. point',
                                           font,
                                           fontSize: 9,
                                           color: PdfColors.black,
                                         ),
                                         SimplePdf.text(
                                           controller.BIF_MOV_M_PRINT.elementAt(0).BPNA_D.toString(),
                                           font,
                                           fontSize: 9,
                                           color: PdfColors.black,
                                         ),
                                         SimplePdf.text(
                                           'رقم النقطه',
                                           font,
                                           fontSize: 9,
                                           color: PdfColors.black,
                                         ),
                                       ]):
                                       controller.BIF_MOV_M_PRINT.elementAt(0).PKID.toString()=='1'?Row(
                                       mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                       children: [
                                         SimplePdf.text(
                                           'Cashier',
                                           font,
                                           fontSize: 9,
                                           color: PdfColors.black,
                                         ),
                                         SimplePdf.text(
                                           "${controller.BIF_MOV_M_PRINT.elementAt(0).ACNA_D.toString()} ",
                                           font,
                                           fontSize: 9,
                                           color: PdfColors.black,
                                         ),
                                         SimplePdf.text(
                                           'الصندوق',
                                           font,
                                           fontSize: 9,
                                           color: PdfColors.black,
                                         ),
                                       ]):
                                       controller.BIF_MOV_M_PRINT.elementAt(0).PKID.toString()=='8'?Row(
                                       mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                       children: [
                                         SimplePdf.text(
                                           'Credit Card',
                                           font,
                                           fontSize: 9,
                                           color: PdfColors.black,
                                         ),
                                         SimplePdf.text(
                                           "${controller.BIF_MOV_M_PRINT.elementAt(0).BCCID_D.toString()} ",
                                           font,
                                           fontSize: 9,
                                           color: PdfColors.black,
                                         ),
                                         SimplePdf.text(
                                           'بطاقة ائتمان',
                                           font,
                                           fontSize: 9,
                                           color: PdfColors.black,
                                         ),
                                       ]):Container(),
                                       Row(
                                       mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                       children: [
                                         SimplePdf.text(
                                           'Store',
                                           font,
                                           fontSize: 9,
                                           color: PdfColors.black,
                                         ),
                                         SimplePdf.text(
                                           "${controller.BIF_MOV_M_PRINT.elementAt(0).SINA_D.toString()} ",
                                           font,
                                           fontSize: 9,
                                           color: PdfColors.black,
                                         ),
                                         SimplePdf.text(
                                           'المخزن',
                                           font,
                                           fontSize: 9,
                                           color: PdfColors.black,
                                         ),
                                       ]),
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
         ]):
            Table(border: TableBorder.all(), children:[
             TableRow(
               children: [
                 pw.Row(
                   crossAxisAlignment: pw.CrossAxisAlignment.start,
                   children: [
                     // QR Code في اليسار
                     pw.Container(
                       padding: pw.EdgeInsets.all(10),
                       child: pw.BarcodeWidget(
                         barcode: pw.Barcode.qrCode(),
                         data: qrData.toString(),
                         width: 80,
                         height: 100,
                       ),
                     ),

                     pw.SizedBox(width: 10), // مسافة بين QR والجدول

                     // الجدول في اليمين
                     pw.Column(
                       crossAxisAlignment: pw.CrossAxisAlignment.start,
                       children: [
                         Table(border: TableBorder.all(),columnWidths: {
                           0: FixedColumnWidth(455),// العمود الأول
                         },
                             children: [
                               TableRow(
                                 children: [
                                   Container(

                                     decoration: const BoxDecoration(
                                       color: PdfColors.MyColors,
                                     ),
                                     padding: const EdgeInsets.all(2),
                                     child: pw.Row(
                                         mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                                         children: [
                                           SimplePdf.text(
                                             controller.BIF_MOV_M_PRINT.elementAt(0).BINA_D.toString(),
                                             font,
                                             align: TextAlign.center,
                                             fontSize: 12,
                                             color: PdfColors.black,
                                           ),
                                           SimplePdf.text(
                                             GetBMKID=='3'?"${'StringSalesInvoices'.tr}-$GetPKNA":GetBMKID=='4'?"${'StringBIL_MOV_OUT_R'.tr}-$GetPKNA":
                                             GetBMKID=='11'?"${'StringPOSInvoice'.tr}-$GetPKNA": GetBMKID=='12'?"${'StringBIF_MOV_MOR'.tr}-$GetPKNA":
                                             GetBMKID=='7'?"عرض سعر-$GetPKNA":
                                             GetBMKID=='10'?"طلب عميل-$GetPKNA":
                                             "${'StringPurchases_Invoices'.tr}-$GetPKNA",
                                             font,
                                             align: TextAlign.center,
                                             fontSize: 12,
                                             color: PdfColors.black,
                                           ),
                                         ]),
                                   ),
                                 ],
                               ),
                             ]),

                         pw.SizedBox(height: 3), // مسافة قبل الجدول
                         // الجدول
                         pw.Table(
                           border: pw.TableBorder.all(),
                           columnWidths: {
                             0: FixedColumnWidth(127),// العمود الأول
                             1: FixedColumnWidth(100),// العمود الأول
                             2: FixedColumnWidth(128),// العمود الأول
                             3: FixedColumnWidth(100),// العمود الأول
                           },
                           children: [
                             // رقم الفاتورة
                             pw.TableRow(
                               children: [
                                 pw.Container(
                                   padding: pw.EdgeInsets.all(3),
                                   child: SimplePdf.text(
                                     GetBMMDO.toString(),
                                     font,
                                     align: TextAlign.center,
                                     fontSize: 11,
                                     color: PdfColors.black,
                                   ),
                                 ),
                                 pw.Container(
                                   padding: pw.EdgeInsets.all(3),
                                   color: PdfColors.grey100,
                                   child: SimplePdf.text(
                                     'StringBMMDO'.tr,
                                     font,
                                     align: TextAlign.right,
                                     fontSize: 11,
                                     color: PdfColors.black,
                                   ),
                                 ),
                                 pw.Container(
                                   padding: pw.EdgeInsets.all(3),
                                   child: SimplePdf.text(
                                     GetBMMNO.toString(),
                                     font,
                                     align: TextAlign.center,
                                     fontSize: 11,
                                     color: PdfColors.black,
                                   ),
                                 ),
                                 pw.Container(
                                   padding: pw.EdgeInsets.all(3),
                                   color: PdfColors.grey100,
                                   child: SimplePdf.text(
                                     'StringInvoiceNO'.tr,
                                     font,
                                     align: TextAlign.right,
                                     fontSize: 11,
                                     color: PdfColors.black,
                                   ),
                                 ),
                               ],
                             ),
                             // تاريخ إصدار الفاتورة
                             pw.TableRow(
                               children: [
                                 pw.Container(
                                   padding: pw.EdgeInsets.all(3),
                                   child: Scsy_b? pw.Row(
                                     mainAxisAlignment: pw.MainAxisAlignment.center, // توسيط المحتوى
                                     children: [
                                       buildImage(),
                                       pw.SizedBox(width: 5), // مسافة صغيرة بين النص والصورة
                                       // ✅ النص
                                       SimplePdf.text(
                                         "${controller.BIF_MOV_M_PRINT.elementAt(0).SCNA_D.toString()}",
                                         font,
                                         align: TextAlign.center,
                                         fontSize: 11,
                                         color: PdfColors.black,
                                       ),
                                     ],
                                   ):SimplePdf.text(
                                     "${controller.BIF_MOV_M_PRINT.elementAt(0).SCNA_D.toString()} ${controller.BIF_MOV_M_PRINT.elementAt(0).SCSY.toString()}",
                                     font,
                                     align: TextAlign.center,
                                     fontSize: 11,
                                     color: PdfColors.black,
                                   ),
                                 ),
                                 pw.Container(
                                   padding: pw.EdgeInsets.all(3),
                                   color: PdfColors.grey100,
                                   child: SimplePdf.text(
                                     'StringSCIDlableText'.tr,
                                     font,
                                     align: TextAlign.right,
                                     fontSize: 11,
                                     color: PdfColors.black,
                                   ),
                                 ),
                                 pw.Container(
                                   padding: pw.EdgeInsets.all(3),
                                   child: SimplePdf.text(
                                     controller.BIF_MOV_M_PRINT.elementAt(0).BMMRE.toString(),
                                     font,
                                     align: TextAlign.center,
                                     fontSize: 11,
                                     color: PdfColors.black,
                                   ),
                                 ),
                                 pw.Container(
                                   padding: pw.EdgeInsets.all(3),
                                   color: PdfColors.grey100,
                                   child: SimplePdf.text(
                                     'StringManualNO'.tr,
                                     font,
                                     align: TextAlign.right,
                                     fontSize: 11,
                                     color: PdfColors.black,
                                   ),
                                 ),
                               ],
                             ),
                             // العملة
                             // pw.TableRow(
                             //   children: [
                             //     pw.Container(
                             //       padding: pw.EdgeInsets.all(3),
                             //       child: SimplePdf.text(
                             //         controller.BIF_MOV_M_PRINT.elementAt(0).BMMST.toString()=='2' ? 'StringNotfinal'.tr
                             //             : '${controller.BIF_MOV_M_PRINT.elementAt(0).BMMST}'.toString() == '4' ? 'StringPending'.tr : 'Stringfinal'.tr,
                             //         font,
                             //         align: TextAlign.center,
                             //         fontSize: 11,
                             //         color: PdfColors.black,
                             //       ),
                             //     ),
                             //     pw.Container(
                             //       padding: pw.EdgeInsets.all(3),
                             //       color: PdfColors.grey100,
                             //       child: SimplePdf.text(
                             //         'StringState'.tr,
                             //         font,
                             //         align: TextAlign.right,
                             //         fontSize: 11,
                             //         color: PdfColors.black,
                             //       ),
                             //     ),
                             //     pw.Container(
                             //       padding: pw.EdgeInsets.all(3),
                             //       child: SimplePdf.text(
                             //         '',
                             //         font,
                             //         align: TextAlign.center,
                             //         fontSize: 11,
                             //         color: PdfColors.black,
                             //       ),
                             //     ),
                             //     pw.Container(
                             //       padding: pw.EdgeInsets.all(3),
                             //       color: PdfColors.grey100,
                             //       child: SimplePdf.text(
                             //         '',
                             //         font,
                             //         align: TextAlign.right,
                             //         fontSize: 11,
                             //         color: PdfColors.black,
                             //       ),
                             //     ),
                             //   ],
                             // ),
                           ],
                         ),

                         pw.SizedBox(height: 3),

                         pw.Table(
                           border: pw.TableBorder.all(),
                           columnWidths: {
                             0: FixedColumnWidth(127),// العمود الأول
                             1: FixedColumnWidth(100),// العمود الأول
                             2: FixedColumnWidth(128),// العمود الأول
                             3: FixedColumnWidth(100),// العمود الأول
                           },
                           children: [
                             // رقم الفاتورة
                             pw.TableRow(
                               children: [
                                 pw.Container(
                                   padding: pw.EdgeInsets.all(3),
                                   child: SimplePdf.text(
                                     controller.BCTX.toString(),
                                     font,
                                     align: TextAlign.center,
                                     fontSize: 11,
                                     color: PdfColors.black,
                                   ),
                                 ),
                                 pw.Container(
                                   padding: pw.EdgeInsets.all(3),
                                   color: PdfColors.MyColors,
                                   child: SimplePdf.text(
                                     'StringVATNumber'.tr,
                                     font,
                                     align: TextAlign.right,
                                     fontSize: 11,
                                     color: PdfColors.black,
                                   ),
                                 ),
                                 pw.Container(
                                   padding: pw.EdgeInsets.all(3),
                                   child: SimplePdf.text(
                                     controller.BIF_MOV_M_PRINT.elementAt(0).BMMNA.toString(),
                                     font,
                                     align: TextAlign.center,
                                     fontSize: 11,
                                     color: PdfColors.black,
                                   ),
                                 ),
                                 pw.Container(
                                   padding: pw.EdgeInsets.all(3),
                                   color: PdfColors.MyColors,
                                   child: SimplePdf.text(
                                     'StringBCID'.tr,
                                     font,
                                     align: TextAlign.right,
                                     fontSize: 11,
                                     color: PdfColors.black,
                                   ),
                                 ),
                               ],
                             ),

                           ],
                         ),

                         pw.Table(
                           border: pw.TableBorder.all(),
                           columnWidths: {
                             0: FixedColumnWidth(355),// العمود الأول
                             1: FixedColumnWidth(100),// العمود الأول
                           },
                           children: [
                             // رقم الفاتورة
                             pw.TableRow(
                               children: [
                                 pw.Container(
                                   padding: pw.EdgeInsets.all(3),
                                   child: SimplePdf.text(
                                     controller.BCAD.toString(),
                                     font,
                                     align: TextAlign.center,
                                     fontSize: 11,
                                     color: PdfColors.black,
                                   ),
                                 ),
                                 pw.Container(
                                   padding: pw.EdgeInsets.all(3),
                                   color: PdfColors.MyColors,
                                   child: SimplePdf.text(
                                     'StringAddress'.tr,
                                     font,
                                     align: TextAlign.right,
                                     fontSize: 11,
                                     color: PdfColors.black,
                                   ),
                                 ),

                               ],
                             ),

                           ],
                         ),

                         pw.SizedBox(height: 3),
                       ],
                     ),


                   ],
                 ),
               ]),
            ]),
            Table(border: TableBorder.all(), columnWidths: {
              0: const FlexColumnWidth(1.7),
              1: const FlexColumnWidth(0.8),
              2: const FlexColumnWidth(0.6),
              3: const FlexColumnWidth(0.8),
              4: (controller.BIF_MOV_M_PRINT.elementAt(0).TTID2.toString()!='null'
                  && controller.BIF_MOV_M_PRINT.elementAt(0).BMMTX2!>0)?
              FlexColumnWidth(0.7):FlexColumnWidth(0.0),
              5: const FlexColumnWidth(1.1),
              6: const FlexColumnWidth(1),
              7: const FlexColumnWidth(0.7),
              8: const FlexColumnWidth(0.7),
              9: const FlexColumnWidth(2),
              10: const FlexColumnWidth(0.8),
              11: const FlexColumnWidth(0.4),
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
                        'String_Item_Subtotal_IncludingVAT'.tr,
                        font,
                        fontSize: 9,
                        color: PdfColors.black,
                      ),
                    ),
                    Container(
                      decoration: const BoxDecoration(),
                      padding: const EdgeInsets.all(1),
                      child: SimplePdf.text(
                        'String_Tax_Amount'.tr,
                        font,
                        fontSize: 9,
                        color: PdfColors.black,
                      ),
                    ),
                    Container(
                      decoration: const BoxDecoration(),
                      padding: const EdgeInsets.all(1),
                      child: SimplePdf.text(
                        'StringBMDTX'.tr,
                        font,
                        fontSize: 9,
                        color: PdfColors.black,
                      ),
                    ),
                //    if(controller.BIF_MOV_M_PRINT.elementAt(0).TTID2.toString()!='null' && controller.BIF_MOV_M_PRINT.elementAt(0).BMMTX2!>0)

                    Container(
                      decoration: const pw.BoxDecoration(),
                      padding: const pw.EdgeInsets.all(1),
                      child: pw.Column(children: [
                        SimplePdf.text(
                          'String_Discount'.tr,
                          font,
                          fontSize: 9,
                          color: PdfColors.black,
                        ),
                      ]),
                    ),
                    Container(
                      decoration: const BoxDecoration(),
                      padding: const EdgeInsets.all(1),
                      child: SimplePdf.text(
                        'StringBMDTXA'.tr,
                        font,
                        fontSize: 9,
                        color: PdfColors.black,
                      ),
                    ),
                    Container(
                      decoration: const BoxDecoration(),
                      padding: const EdgeInsets.all(1),
                      child: SimplePdf.text(
                        'String_Taxable_Amount'.tr,
                        font,
                        fontSize: 9,
                        color: PdfColors.black,
                      ),
                    ),
                    Container(
                      decoration: const BoxDecoration(),
                      padding: const EdgeInsets.all(1),
                      child: SimplePdf.text(
                        'StringMPCO'.tr,
                        font,
                        fontSize: 9,
                        color: PdfColors.black,
                      ),
                    ),
                    Container(
                      decoration: const BoxDecoration(),
                      padding: const EdgeInsets.all(1),
                      child: SimplePdf.text(
                        'StringMUID'.tr,
                        font,
                        fontSize: 9,
                        color: PdfColors.black,
                      ),
                    ),
                    Container(
                      decoration: const BoxDecoration(),
                      padding: const EdgeInsets.all(1),
                      child: SimplePdf.text(
                        'StringSNNO'.tr,
                        font,
                        fontSize: 9,
                        color: PdfColors.black,
                      ),
                    ),
                    Container(
                      decoration: const BoxDecoration(),
                      padding: const EdgeInsets.all(1),
                      child: SimplePdf.text(
                        'StringBMDIN'.tr,
                        font,
                        fontSize: 9,
                        color: PdfColors.black,
                      ),
                    ),
                    Container(
                      decoration: const BoxDecoration(),
                      padding: const EdgeInsets.all(1),
                      child: SimplePdf.text(
                        'StringMINO'.tr,
                        font,
                        fontSize: 9,
                        color: PdfColors.black,
                      ),
                    ),
                    Container(
                      decoration: const BoxDecoration(),
                      padding: const EdgeInsets.all(1),
                      child: SimplePdf.text(
                        '#',
                        font,
                        fontSize: 9,
                        color: PdfColors.black,
                      ),
                    ),
                  ],
                ),
              ]),
            Table(
              border: pw.TableBorder.all(),
                columnWidths: {
                  0: const FlexColumnWidth(1.7),
                  1: const FlexColumnWidth(0.8),
                  2: const FlexColumnWidth(0.6),
                  3: const FlexColumnWidth(0.8),
                  4: (controller.BIF_MOV_M_PRINT.elementAt(0).TTID2.toString()!='null'
                      && controller.BIF_MOV_M_PRINT.elementAt(0).BMMTX2!>0)?
                  FlexColumnWidth(0.7):FlexColumnWidth(0.0),
                  5: const FlexColumnWidth(1.1),
                  6: const FlexColumnWidth(1),
                  7: const FlexColumnWidth(0.7),
                  8: const FlexColumnWidth(0.7),
                  9: const FlexColumnWidth(2),
                  10: const FlexColumnWidth(0.8),
                  11: const FlexColumnWidth(0.4),
                },
              children: List.generate(controller.InvoiceList.length, (index) {
                Bil_Mov_D_Local product = controller.InvoiceList[index];
                print('product.MINA_D');
                print(product.MINA_D);
                return pw.TableRow(
                  children: [
                    pw.Container(
                      alignment: pw.Alignment.center,
                      padding: const pw.EdgeInsets.only(top: 2,bottom: 2,right: 1,left: 1),
                      child: SimplePdf.text(
                          controller.formatter.format(((product.BMDAM!-product.BMDDI!)*product.BMDNO!)+(product.BMDTXT1!+product.BMDTXT2!)).toString(),
                          font,
                          fontSize: 9),
                    ),
                    Container(
                      alignment: pw.Alignment.center,
                      padding:  const pw.EdgeInsets.only(top: 2,bottom: 2,right: 1,left: 1),
                      child: SimplePdf.text(
                          controller.formatter.format(product.BMDTXT1).toString() , font,
                          fontSize: 9),
                    ),

                    Container(
                      alignment: pw.Alignment.center,
                      padding:  const pw.EdgeInsets.only(top: 2,bottom: 2,right: 1,left: 1),
                      child: SimplePdf.text(
                          controller.formatter.format(product.BMDTX1).toString() , font,
                          fontSize: 9),
                    ),
                    Container(
                      alignment: pw.Alignment.center,
                      padding:  const pw.EdgeInsets.only(top: 2,bottom: 2,right: 1,left: 1),
                      child: SimplePdf.text(
                        controller.formatter.format((product.BMDDI!+((product.BMDDIA!/100)*product.BMDAM!))*product.BMDNO!+(product.BMDDIF!*product.BMDNF!)).toString() , font,
                        fontSize: 9,color: PdfColors.black,
                      ),
                    ),
                    //  if(controller.BIF_MOV_M_PRINT.elementAt(0).TTID2.toString()!='null' && controller.BIF_MOV_M_PRINT.elementAt(0).BMMTX2!>0)
                    Container(
                      alignment: pw.Alignment.center,
                      padding:  const pw.EdgeInsets.only(top: 2,bottom: 2,right: 1,left: 1),
                      child: SimplePdf.text(
                          controller.formatter.format(product.BMDTXT2).toString() , font,
                          fontSize: 9),
                    ),
                    Container(
                      alignment: pw.Alignment.center,
                      padding:  const pw.EdgeInsets.only(top: 2,bottom: 2,right: 1,left: 1),
                      child: SimplePdf.text(
                        controller.formatter.format((product.BMDAM!-(product.BMDDI!+((product.BMDDIA!/100)*product.BMDAM!)))*product.BMDNO!).toString() , font,
                        fontSize: 9,color: PdfColors.black,
                      ),
                    ),
                    Container(
                      alignment: pw.Alignment.center,
                      padding:  const pw.EdgeInsets.only(top: 2,bottom: 2,right: 1,left: 1),
                      child: SimplePdf.text(
                        controller.formatter.format(product.BMDAM).toString() , font,
                        fontSize: 9,color: PdfColors.black,
                      ),
                    ),
                    Container(
                      alignment: Alignment.center,
                      padding:  const pw.EdgeInsets.only(top: 2,bottom: 2,right: 1,left: 1),
                      child: SimplePdf.text(
                        product.MUNA_D.toString() , font,
                        fontSize: 9,color: PdfColors.black,
                      ),
                    ),
                    Container(
                      alignment: pw.Alignment.center,
                      padding:  const pw.EdgeInsets.only(top: 2,bottom: 2,right: 1,left: 1),
                      child: SimplePdf.text(
                        controller.formatter.format(product.BMDNO!+product.BMDNF!).toString() , font,
                        fontSize: 9,color: PdfColors.black,
                      ),
                    ),
                    Container(
                      alignment: pw.Alignment.center,
                      padding:  const pw.EdgeInsets.only(top: 2,bottom: 2,right: 1,left: 1),
                      child: SimplePdf.text(
                       product.MINA_D.toString(),font,
                        fontSize: 9,color: PdfColors.black,
                      ),
                    ),
                    Container(
                      alignment: Alignment.center,
                      padding:  const pw.EdgeInsets.only(top: 2,bottom: 2,right: 1,left: 1),
                      child: SimplePdf.text(
                        product.MINO.toString() , font,
                        fontSize: 9,color: PdfColors.black,
                      ),
                    ),
                    pw.Container(
                      alignment: pw.Alignment.center,
                      padding:  const pw.EdgeInsets.only(top: 2,bottom: 2,right: 1,left: 1),
                      child: SimplePdf.text(
                        product.BMDID.toString() , font,
                        fontSize: 9,color: PdfColors.black,
                      ),
                    ),
                  ],
                );
              })),
            SizedBox(height: 3),
            Table(border: TableBorder.all(), children: [
           TableRow(
             children: [
               pw.Container(
                 padding: const EdgeInsets.only(right: 1, left: 1),
                 /// height: 630,
                 child: Column(children: [
                   Padding(padding: const EdgeInsets.only(right: 2, left: 2, top: 3),
                     child: Table(border: TableBorder.all(), children: [
                       TableRow(
                         children: [
                           Row(children: [
                             Table(border: TableBorder.all(),columnWidths: {
                               0: FixedColumnWidth(170),// العمود الأول
                               1: FixedColumnWidth(170),// العمود الأول
                             }, children: [
                               TableRow(
                                 children: [
                                   Container(
                                     decoration: const BoxDecoration(),
                                     padding: const EdgeInsets.all(1),
                                     child:Scsy_b? pw.Row(
                                       mainAxisAlignment: pw.MainAxisAlignment.center, // توسيط المحتوى
                                       children: [
                                         buildImage(),
                                         pw.SizedBox(width: 5), // مسافة صغيرة بين النص والصورة
                                         // ✅ النص
                                         SimplePdf.text(
                                           controller.formatter.format((controller.BIF_MOV_M_PRINT.elementAt(0).BMMAM!-controller.BIF_MOV_M_PRINT.elementAt(0).BMMTX!)).toString(),
                                           font,
                                           align: TextAlign.center,
                                           fontSize: 12,
                                           color: PdfColors.black,
                                         ),
                                       ],
                                     ):SimplePdf.text(
                                       controller.formatter.format((controller.BIF_MOV_M_PRINT.elementAt(0).BMMAM!-controller.BIF_MOV_M_PRINT.elementAt(0).BMMTX!)).toString(),
                                       font,
                                       align: TextAlign.center,
                                       fontSize: 12,
                                       color: PdfColors.black,
                                     ),
                                   ),
                                 ],
                               ),
                               if(controller.BIF_MOV_M_PRINT.elementAt(0).TTID2.toString()!='null' && controller.BIF_MOV_M_PRINT.elementAt(0).BMMTX2!>0)
                               TableRow(
                                 children: [
                                   Container(
                                     decoration: const BoxDecoration(),
                                     padding: const EdgeInsets.all(1),
                                     child:Scsy_b?  pw.Row(
                                       mainAxisAlignment: pw.MainAxisAlignment.center, // توسيط المحتوى
                                       children: [
                                         buildImage(),
                                         pw.SizedBox(width: 5), // مسافة صغيرة بين النص والصورة
                                         // ✅ النص
                                         SimplePdf.text(
                                           controller.formatter.format(controller.BIF_MOV_M_PRINT.elementAt(0).BMMTX2).toString(),
                                           font,
                                           align: TextAlign.center,
                                           fontSize: 12,
                                           color: PdfColors.black,
                                         ),
                                       ],
                                     ):SimplePdf.text(
                                       controller.formatter.format(controller.BIF_MOV_M_PRINT.elementAt(0).BMMTX2).toString(),
                                       font,
                                       align: TextAlign.center,
                                       fontSize: 12,
                                       color: PdfColors.black,
                                     ),
                                   ),
                                 ],
                               ),
                               if(controller.BIF_MOV_M_PRINT.elementAt(0).BMMDI!+controller.BIF_MOV_M_PRINT.elementAt(0).BMMDIA!>0)
                               TableRow(
                                 children: [
                                   Container(
                                     decoration: const BoxDecoration(),
                                     padding: const EdgeInsets.all(1),
                                     child:Scsy_b? pw.Row(
                                       mainAxisAlignment: pw.MainAxisAlignment.center, // توسيط المحتوى
                                       children: [
                                         buildImage(),
                                         pw.SizedBox(width: 5), // مسافة صغيرة بين النص والصورة
                                         // ✅ النص
                                         SimplePdf.text(
                                           controller.formatter.format(controller.BIF_MOV_M_PRINT.elementAt(0).BMMDI!+controller.BIF_MOV_M_PRINT.elementAt(0).BMMDIA!).toString(),
                                           font,
                                           align: TextAlign.center,
                                           fontSize: 12,
                                           color: PdfColors.black,
                                         ),
                                       ],
                                     ):SimplePdf.text(
                                       controller.formatter.format(controller.BIF_MOV_M_PRINT.elementAt(0).BMMDI!+controller.BIF_MOV_M_PRINT.elementAt(0).BMMDIA!).toString(),
                                       font,
                                       align: TextAlign.center,
                                       fontSize: 12,
                                       color: PdfColors.black,
                                     ),
                                   ),
                                 ],
                               ),
                               if(controller.BIF_MOV_M_PRINT.elementAt(0).BMMDIF!>0)
                               TableRow(
                                 children: [
                                   Container(
                                     decoration: const BoxDecoration(),
                                     padding: const EdgeInsets.all(1),
                                     child:Scsy_b? pw.Row(
                                       mainAxisAlignment: pw.MainAxisAlignment.center, // توسيط المحتوى
                                       children: [
                                         buildImage(),
                                         pw.SizedBox(width: 5), // مسافة صغيرة بين النص والصورة
                                         // ✅ النص
                                         SimplePdf.text(
                                           controller.formatter.format(controller.BIF_MOV_M_PRINT.elementAt(0).BMMDIF).toString(),
                                           font,
                                           align: TextAlign.center,
                                           fontSize: 12,
                                           color: PdfColors.black,
                                         ),
                                       ],
                                     ):SimplePdf.text(
                                       controller.formatter.format(controller.BIF_MOV_M_PRINT.elementAt(0).BMMDIF).toString(),
                                       font,
                                       align: TextAlign.center,
                                       fontSize: 12,
                                       color: PdfColors.black,
                                     ),
                                   ),
                                 ],
                               ),
                               if((controller.BIF_MOV_M_PRINT.elementAt(0).BMMAM!-controller.BIF_MOV_M_PRINT.elementAt(0).BMMTX!-
                                   controller.BIF_MOV_M_PRINT.elementAt(0).BMMDI!-controller.BIF_MOV_M_PRINT.elementAt(0).BMMDIF!-
                                   controller.BIF_MOV_M_PRINT.elementAt(0).BMMDIA! - controller.BIF_MOV_M_PRINT.elementAt(0).BMMTX2!)!=
                                   (controller.BIF_MOV_M_PRINT.elementAt(0).BMMAM!-controller.BIF_MOV_M_PRINT.elementAt(0).BMMTX!))
                               TableRow(
                                 children: [
                                   Container(
                                     height:39,
                                     decoration: const BoxDecoration(),
                                     padding: const EdgeInsets.all(1),
                                     child:Scsy_b? pw.Row(
                                       mainAxisAlignment: pw.MainAxisAlignment.center, // توسيط المحتوى
                                       children: [
                                         buildImage(),
                                         pw.SizedBox(width: 5), // مسافة صغيرة بين النص والصورة
                                         // ✅ النص
                                         SimplePdf.text(
                                           controller.formatter.format((controller.BIF_MOV_M_PRINT.elementAt(0).BMMAM!-controller.BIF_MOV_M_PRINT.elementAt(0).BMMTX!-
                                               controller.BIF_MOV_M_PRINT.elementAt(0).BMMDI!-controller.BIF_MOV_M_PRINT.elementAt(0).BMMDIF!-
                                               controller.BIF_MOV_M_PRINT.elementAt(0).BMMDIA! + controller.BIF_MOV_M_PRINT.elementAt(0).BMMTX2!)).toString(),
                                           font,
                                           align: TextAlign.center,
                                           fontSize: 12,
                                           color: PdfColors.black,
                                         ),

                                       ],
                                     ): SimplePdf.text(
                                       controller.formatter.format((controller.BIF_MOV_M_PRINT.elementAt(0).BMMAM!-controller.BIF_MOV_M_PRINT.elementAt(0).BMMTX!-
                                           controller.BIF_MOV_M_PRINT.elementAt(0).BMMDI!-controller.BIF_MOV_M_PRINT.elementAt(0).BMMDIF!-
                                           controller.BIF_MOV_M_PRINT.elementAt(0).BMMDIA! + controller.BIF_MOV_M_PRINT.elementAt(0).BMMTX2!)).toString(),
                                       font,
                                       align: TextAlign.center,
                                       fontSize: 12,
                                       color: PdfColors.black,
                                     ),
                                   ),
                                 ],
                               ),
                               TableRow(
                                 children: [
                                   Container(
                                     decoration: const BoxDecoration(),
                                     padding: const EdgeInsets.all(1),
                                     child:Scsy_b? pw.Row(
                                       mainAxisAlignment: pw.MainAxisAlignment.center, // توسيط المحتوى
                                       children: [
                                         buildImage(),
                                         pw.SizedBox(width: 5), // مسافة صغيرة بين النص والصورة
                                         // ✅ النص
                                         SimplePdf.text(
                                           controller.formatter.format(controller.BIF_MOV_M_PRINT.elementAt(0).BMMTX1).toString(),
                                           font,
                                           align: TextAlign.center,
                                           fontSize: 12,
                                           color: PdfColors.black,
                                         ),

                                       ],
                                     ):SimplePdf.text(
                                       controller.formatter.format(controller.BIF_MOV_M_PRINT.elementAt(0).BMMTX1).toString(),
                                       font,
                                       align: TextAlign.center,
                                       fontSize: 12,
                                       color: PdfColors.black,
                                     ),
                                   ),
                                 ],
                               ),
                               TableRow(
                                 children: [
                                   Container(
                                     decoration: const BoxDecoration( color: PdfColors.grey200,),
                                     padding: const EdgeInsets.all(1),
                                     child:Scsy_b? pw.Row(
                                       mainAxisAlignment: pw.MainAxisAlignment.center, // توسيط المحتوى
                                       children: [
                                         buildImage(),
                                         pw.SizedBox(width: 5), // مسافة صغيرة بين النص والصورة
                                         // ✅ النص
                                         SimplePdf.text(
                                           controller.formatter.format(controller.BIF_MOV_M_PRINT.elementAt(0).BMMMT).toString(),
                                           font,
                                           align: TextAlign.center,
                                           fontSize: 12,
                                           color: PdfColors.black,
                                         ),

                                       ],
                                     ):SimplePdf.text(
                                       controller.formatter.format(controller.BIF_MOV_M_PRINT.elementAt(0).BMMMT).toString(),
                                       font,
                                       align: TextAlign.center,
                                       fontSize: 12,
                                       color: PdfColors.black,
                                     ),
                                   ),
                                 ],
                               ),
                               TableRow(
                                 children: [
                                   Container(
                                       height:17,
                                       decoration: const BoxDecoration(),
                                       padding: const EdgeInsets.all(1),
                                       child:SimplePdf.text('',
                                         font,
                                         align:TextAlign.center,
                                         fontSize: 10,
                                         color:PdfColors.black,
                                       ),
                                   ),
                                 ],
                               ),
                             ]),
                             Table(border: TableBorder.all(),columnWidths: {
                               0: FixedColumnWidth(200),// العمود الأول
                               1: FixedColumnWidth(200),// العمود الأول
                             }, children: [
                               TableRow(
                                 children: [
                                   Container(
                                     decoration: const BoxDecoration(),
                                     padding: const EdgeInsets.all(1),
                                     child: SimplePdf.text(
                                       'الاجمالي ) غير شامله ضريبه القيمه المضافة (',
                                       font,
                                       align: TextAlign.center,
                                       fontSize: 12,
                                       color: PdfColors.black,
                                     ),
                                   ),
                                 ],
                               ),
                               if(controller.BIF_MOV_M_PRINT.elementAt(0).TTID2.toString()!='null' && controller.BIF_MOV_M_PRINT.elementAt(0).BMMTX2!>0)
                               TableRow(
                                 children: [
                                   Container(

                                     decoration: const BoxDecoration(),
                                     padding: const EdgeInsets.all(1),
                                     child: SimplePdf.text(
                                       'الضريبه الانتقائيه',
                                       font,
                                       align: TextAlign.center,
                                       fontSize: 12,
                                       color: PdfColors.black,
                                     ),
                                   ),
                                 ],
                               ),
                               if(controller.BIF_MOV_M_PRINT.elementAt(0).BMMDI!+controller.BIF_MOV_M_PRINT.elementAt(0).BMMDIA!>0)
                               TableRow(
                                 children: [
                                   Container(

                                     decoration: const BoxDecoration(),
                                     padding: const EdgeInsets.all(1),
                                     child: SimplePdf.text(
                                       'اجمالي الخصم',
                                       font,
                                       align: TextAlign.center,
                                       fontSize: 12,
                                       color: PdfColors.black,
                                     ),
                                   ),
                                 ],
                               ),
                               if(controller.BIF_MOV_M_PRINT.elementAt(0).BMMDIF!>0)
                               TableRow(
                                 children: [
                                   Container(

                                     decoration: const BoxDecoration(),
                                     padding: const EdgeInsets.all(1),
                                     child: SimplePdf.text(
                                       'تخفيض للمجاني',
                                       font,
                                       align: TextAlign.center,
                                       fontSize: 12,
                                       color: PdfColors.black,
                                     ),
                                   ),
                                 ],
                               ),
                               if((controller.BIF_MOV_M_PRINT.elementAt(0).BMMAM!-controller.BIF_MOV_M_PRINT.elementAt(0).BMMTX!-
                                   controller.BIF_MOV_M_PRINT.elementAt(0).BMMDI!-controller.BIF_MOV_M_PRINT.elementAt(0).BMMDIF!-
                                   controller.BIF_MOV_M_PRINT.elementAt(0).BMMDIA! - controller.BIF_MOV_M_PRINT.elementAt(0).BMMTX2!)!=
                                   (controller.BIF_MOV_M_PRINT.elementAt(0).BMMAM!-controller.BIF_MOV_M_PRINT.elementAt(0).BMMTX!))
                               TableRow(
                                 children: [
                                   Container(

                                     decoration: const BoxDecoration(),
                                     padding: const EdgeInsets.all(1),
                                     child: SimplePdf.text(
                                       'الاجمالي الخاضع للضريبه )غير شامل ضريبة القيمه المضافة(',
                                       font,
                                       align: TextAlign.center,
                                       fontSize: 12,
                                       color: PdfColors.black,
                                     ),
                                   ),
                                 ],
                               ),
                               TableRow(
                                 children: [
                                   Container(

                                     decoration: const BoxDecoration(),
                                     padding: const EdgeInsets.all(1),
                                     child: SimplePdf.text(
                                       'مجموع ضريبة القيمة المضافة',
                                       font,
                                       align: TextAlign.center,
                                       fontSize: 12,
                                       color: PdfColors.black,
                                     ),
                                   ),
                                 ],
                               ),
                               TableRow(
                                 children: [
                                   Container(
                                     decoration: const BoxDecoration( color: PdfColors.grey200,),
                                     padding: const EdgeInsets.all(1),
                                     child: SimplePdf.text(
                                       'صافي المبلغ',
                                       font,
                                       align: TextAlign.center,
                                       fontSize: 12,
                                       color: PdfColors.black,
                                     ),
                                   ),
                                 ],
                               ),
                               TableRow(
                                 children: [
                                   Container(

                                     decoration: const BoxDecoration(),
                                     padding: const EdgeInsets.all(1),
                                     child: SimplePdf.text(
                                       "${'StringTotal_NO'.tr} ${controller.formatter.format(double.parse(controller.COUNTBMDNOController.text))}",
                                       font,
                                       align: TextAlign.center,
                                       fontSize: 10,
                                       color: PdfColors.black,
                                     ),
                                   ),
                                 ],
                               ),
                             ]),
                             Table(border: TableBorder.all(),columnWidths: {
                               0: FixedColumnWidth(200),// العمود الأول
                               1: FixedColumnWidth(200),// العمود الأول
                             }, children: [
                               TableRow(
                                 children: [
                                   Container(

                                     decoration: const BoxDecoration(),
                                     padding: const EdgeInsets.all(1),
                                     child: SimplePdf.text(
                                       'Total (Excluding VAT)',
                                       font,
                                       align: TextAlign.center,
                                       fontSize: 12,
                                       color: PdfColors.black,
                                     ),
                                   ),
                                 ],
                               ),
                               if(controller.BIF_MOV_M_PRINT.elementAt(0).TTID2.toString()!='null' && controller.BIF_MOV_M_PRINT.elementAt(0).BMMTX2!>0)
                               TableRow(
                                 children: [
                                   Container(

                                     decoration: const BoxDecoration(),
                                     padding: const EdgeInsets.all(1),
                                     child: SimplePdf.text(
                                       'Excise tax',
                                       font,
                                       align: TextAlign.center,
                                       fontSize: 12,
                                       color: PdfColors.black,
                                     ),
                                   ),
                                 ],
                               ),
                               if(controller.BIF_MOV_M_PRINT.elementAt(0).BMMDI!+controller.BIF_MOV_M_PRINT.elementAt(0).BMMDIA!>0)
                               TableRow(
                                 children: [
                                   Container(

                                     decoration: const BoxDecoration(),
                                     padding: const EdgeInsets.all(1),
                                     child: SimplePdf.text(
                                       'Total discount',
                                       font,
                                       align: TextAlign.center,
                                       fontSize: 12,
                                       color: PdfColors.black,
                                     ),
                                   ),
                                 ],
                               ),
                               if(controller.BIF_MOV_M_PRINT.elementAt(0).BMMDIF!>0)
                               TableRow(
                                 children: [
                                   Container(

                                     decoration: const BoxDecoration(),
                                     padding: const EdgeInsets.all(1),
                                     child: SimplePdf.text(
                                       'Discount',
                                       font,
                                       align: TextAlign.center,
                                       fontSize: 12,
                                       color: PdfColors.black,
                                     ),
                                   ),
                                 ],
                               ),
                               if((controller.BIF_MOV_M_PRINT.elementAt(0).BMMAM!-controller.BIF_MOV_M_PRINT.elementAt(0).BMMTX!-
                                   controller.BIF_MOV_M_PRINT.elementAt(0).BMMDI!-controller.BIF_MOV_M_PRINT.elementAt(0).BMMDIF!-
                                   controller.BIF_MOV_M_PRINT.elementAt(0).BMMDIA! - controller.BIF_MOV_M_PRINT.elementAt(0).BMMTX2!)!=
                                   (controller.BIF_MOV_M_PRINT.elementAt(0).BMMAM!-controller.BIF_MOV_M_PRINT.elementAt(0).BMMTX!))
                               TableRow(
                                 children: [
                                   Container(
                                     height:39,
                                     decoration: const BoxDecoration(),
                                     padding: const EdgeInsets.all(1),
                                     child: SimplePdf.text(
                                       'Total Taxable Amount (Excluding VAT)',
                                       font,
                                       align: TextAlign.center,
                                       fontSize: 12,
                                       color: PdfColors.black,
                                     ),
                                   ),
                                 ],
                               ),
                               TableRow(
                                 children: [
                                   Container(

                                     decoration: const BoxDecoration(),
                                     padding: const EdgeInsets.all(1),
                                     child: SimplePdf.text(
                                       'Total VAT',
                                       font,
                                       align: TextAlign.center,
                                       fontSize: 12,
                                       color: PdfColors.black,
                                     ),
                                   ),
                                 ],
                               ),
                               TableRow(
                                 children: [
                                   Container(

                                     decoration: const BoxDecoration( color: PdfColors.grey200),
                                     padding: const EdgeInsets.all(1),
                                     child: SimplePdf.text(
                                       'Net Amount',
                                       font,
                                       align: TextAlign.center,
                                       fontSize: 12,
                                       color: PdfColors.black,
                                     ),
                                   ),
                                 ],
                               ),
                               TableRow(
                                 children: [
                                   Container(

                                     decoration: const BoxDecoration(),
                                     padding: const EdgeInsets.all(1),
                                     child: SimplePdf.text(
                                       " عدد الاصناف= ${ controller. CountRecodeController.text.toString()}",
                                       font,
                                       align: TextAlign.center,
                                       fontSize: 10,
                                       color: PdfColors.black,
                                     ),
                                   ),
                                 ],
                               ),
                             ]),
                           ]),
                         ],
                       ),
                     ]),
                   ),
                   SizedBox(height: 3),
                 ]),
               ),
             ],
           ),
         ]),
            Table(border: TableBorder.all(), children: [
              TableRow(
                children: [
                  pw.Container(
                    padding: const EdgeInsets.only(right: 1, left: 1),
                    decoration: const BoxDecoration(color: PdfColors.grey200),
                    child: SimplePdf.text(
                      "${Tafqeet.convert(item.BMMMT.toString())} ${item.SCNA_D.toString()}",
                      font, fontSize: 14, color: PdfColors.black,
                    ),
                  ),
                ],
              ),
            ]),
            SimplePdf.buildBalanceSection(item,controller,font,10.5),
            SimplePdf.buildFooter_SIN(font,controller.SDDDA,controller.SDDSA),
            SimplePdf.buildSignature(font,controller.signature),
      ],
          footer: (context) => SimplePdf.buildFooter(context,font,controller.SDDSA),
    ),
  );

  List<int> bytes = await pdf.save();
  FileHelper.share(
      msg: "iiiiiiiiii",
      mode: mode,
      bytes: bytes,
      fileName:
      'Invoice - ${controller.BIF_MOV_M_PRINT.elementAt(0).BMMNO}.pdf',
      BMMID: controller.BIF_MOV_M_PRINT.elementAt(0).BMMID!);
   } catch (e, stackTrace) {
     print('$e $stackTrace');
     Fluttertoast.showToast(
         msg:e.toString(),
         toastLength: Toast.LENGTH_LONG,
         textColor: ma.Colors.white,
         backgroundColor: ma.Colors.redAccent);
     print(e.toString());
   }
}

