import '../../Operation/Controllers/Pay_Out_Controller.dart';
import '../../Operation/models/acc_mov_d.dart';
import '../../Operation/models/acc_mov_m.dart';
import '../../PrintFile/share_mode.dart';
import '../../PrintFile/simple_pdf.dart';
import '../../Setting/controllers/login_controller.dart';
import '../../Setting/controllers/setting_controller.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:number_to_word_arabic/number_to_word_arabic.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:pdf/widgets.dart';
import 'package:flutter/material.dart' as ma;
import 'package:fluttertoast/fluttertoast.dart';
import '../file_helper.dart';

Pdf_Vouchers_Samplie({
  required List<Acc_Mov_M_Local> ListAcc_Mov_M,
  String? GetAMKID,
  required ShareMode mode,

  // required UserTaxInfo userTaxInfo,
  // required Vouchersetting Vouchersetting,

}) async {

  try {
    final Pay_Out_Controller controller = Get.find();

    final pdf = pw.Document();
    const double inch = 72.0;
    final Uint8List fontData = await FileHelper.getFileFromAssets('Assets/fonts/HacenTunisia.ttf');
    final Uint8List fontSa = await FileHelper.getFileFromAssets('Assets/fonts/NewRiyal-Regular.ttf');

    final font = pw.Font.ttf(fontData.buffer.asByteData());
    final Sau = pw.Font.ttf(fontSa.buffer.asByteData());

    final image = await SimplePdf.loadImage();
    Widget buildSud(){
      return SimplePdf.text("\$", Sau, fontSize: 18,);
    }

   // final MemoryImage imageData = await SimplePdf.getSaudiRiyalImage();
    bool Scsy_b = ListAcc_Mov_M.elementAt(0).SCSY=='SAR';
     pw.Widget buildHeader(pw.Font font){


      // دالة مساعدة لبناء النص
      pw.Widget buildText(String text, double fontSize) {
        return SimplePdf.text(
          text,
          font,
          fontSize: fontSize,
          color: PdfColors.black,
        );
      }


      String _getInvoiceTitle() {
        switch (controller.AMKID) {
          case 1:
            return ' ${'StringReceiptVoucher'.tr}  ${ListAcc_Mov_M.elementAt(0).PKNA_D.toString()}';
          case 2:
            return ' ${'StringPaymentVoucher'.tr}  ${ListAcc_Mov_M.elementAt(0).PKNA_D.toString()} ';
          case 3:
            return ' ${'StringCollectionsVoucher'.tr}  ${ListAcc_Mov_M.elementAt(0).PKNA_D.toString()} ';
          default:
            return ' ${'StringJournalVoucher'.tr}  ${ListAcc_Mov_M.elementAt(0).PKNA_D.toString()} ';
        }
      }

      // دالة مساعدة لبناء العمود الأيسر
      pw.Widget _buildLeftColumn() {
        return Expanded(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              buildText(controller.SONE, 13),
              buildText(controller.SOLN, 11),
            ],
          ),
        );
      }

      // دالة مساعدة لبناء العمود المركزي
      pw.Widget _buildCenterColumn() {
        return Expanded(
          child: Column(
            children: [
              Container(width: 50, child: Image(image)),
            ],
          ),
        );
      }

      // دالة مساعدة لبناء العمود الأيمن
      pw.Widget _buildRightColumn() {
        return Expanded(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              buildText(controller.SONA, 13),
              buildText(controller.SORN, 11),
            ],
          ),
        );
      }


      return StteingController().SHOW_REP_HEADER==true?pw.Table(
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
                  children: <pw.Widget>[
                    _buildLeftColumn(),
                    _buildCenterColumn(),
                    _buildRightColumn(),
                  ],
                ),
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
                        child: buildText(_getInvoiceTitle(),15)
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
      ):pw.Container();
    }


    pdf.addPage(
      MultiPage(
        pageFormat: PdfPageFormat.a4,
        margin: EdgeInsets.all(15),
        textDirection: TextDirection.rtl,
        crossAxisAlignment: CrossAxisAlignment.center,
        theme: ThemeData.withFont(base: Font.ttf(await rootBundle.load("Assets/fonts/HacenTunisia.ttf"))),
        header: (context) =>  StteingController().REPEAT_REP_HEADER==true?buildHeader(font):Container(),
        build: (Context context) => [
          if(  StteingController().REPEAT_REP_HEADER==false)
            buildHeader(font),
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
                          Table(border: TableBorder.all(), columnWidths: {
                            0: FixedColumnWidth(560),// العمود الأول
                          },
                              children: [
                            TableRow(
                              children: [
                                Container(
                                //  width: 476,
                                  padding: const pw.EdgeInsets.only(right: 8, left: 8),
                                  child: Column(children: [
                                    Row(
                                      mainAxisAlignment:
                                      pw.MainAxisAlignment.spaceBetween,
                                      children: <pw.Widget>[
                                        pw.Text(' ${'StringSMDED2'.tr} ${ListAcc_Mov_M.elementAt(0).AMMDO.toString()} :',
                                          style: TextStyle(fontSize: 13),
                                        ),
                                        pw.Text(
                                          '${'StringBIID2'.tr} ${ListAcc_Mov_M.elementAt(0).BINA_D.toString()}',
                                          style: TextStyle(fontSize: 13.0),
                                        ),
                                      ],
                                    ),
                                    Row(
                                      mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                                      children: <pw.Widget>[
                                        Text(
                                          '${'StringSMMID'.tr} ${ListAcc_Mov_M.elementAt(0).AMMNO.toString()} :',
                                          style: TextStyle(fontSize: 13.0),
                                        ),
                                        Text(
                                          GetAMKID == '1' || GetAMKID == '2' || GetAMKID == '2'
                                              ? ListAcc_Mov_M.elementAt(0).PKID == '1'
                                              ? '${'StringCashier'.tr} : ${ListAcc_Mov_M.elementAt(0).ACNA_D.toString()}'
                                              : ListAcc_Mov_M.elementAt(0).PKID == '8'
                                              ? '${'StringCreditCard'.tr} : ${ListAcc_Mov_M.elementAt(0).BCCNA_D.toString()}'
                                              : '${'StringBank'.tr} : ${ListAcc_Mov_M.elementAt(0).ABNA_D.toString()}'
                                              : '${ListAcc_Mov_M.elementAt(0).SCNA_D.toString()}',
                                          style: TextStyle(fontSize: 13.0),
                                        ),
                                        Text(
                                          '${'StringAMMID'.tr} ${ListAcc_Mov_M.elementAt(0).AMMID.toString()} :',
                                          style: TextStyle(fontSize: 13.0),
                                        ),
                                      ],
                                    ),
                                    GetAMKID == '1' || GetAMKID == '2' || GetAMKID == '2'
                                        ? Row(
                                      mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                                      children: <pw.Widget>[
                                        Column(children: [
                                          Text(
                                            LoginController().LAN == 2
                                                ? '${controller.converter.convertDouble(double.parse(ListAcc_Mov_M.elementAt(0).AMMAM.toString().contains('.0') ? ListAcc_Mov_M.elementAt(0).AMMAM!.round().toString() : ListAcc_Mov_M.elementAt(0).AMMAM.toString())).replaceFirst(RegExp(r" و  و"), "")} ${ListAcc_Mov_M.elementAt(0).SCNA_D}'
                                                : '${Tafqeet.convert( ListAcc_Mov_M.elementAt(0).AMMAM.toString())} ${ListAcc_Mov_M.elementAt(0).SCNA_D}',
                                            style: TextStyle(fontSize: 13.0),
                                          ),
                                        ]),
                                        Column(children: [
                                          pw.Text(
                                            '${'StringAmount'.tr} ${'${controller.formatter.format(ListAcc_Mov_M.elementAt(0).AMMAM)} :'}',
                                            style: TextStyle(fontSize: 13.0),
                                          ),
                                        ]),
                                      ],
                                    )
                                        : Container(),
                                    Column(
                                        crossAxisAlignment: CrossAxisAlignment.center,
                                        children: [
                                          pw.Text(
                                            '${ListAcc_Mov_M.elementAt(0).AMMIN}',
                                            style: TextStyle(fontSize: 13.0),
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
          ]),
          controller.Balance_Pay == '1' && StteingController().Print_Balance_Pay == true
              ? Table(border: TableBorder.all(), columnWidths: {
            0: const FlexColumnWidth(1.4),
            1: FlexColumnWidth(1.4),
            2: FlexColumnWidth(1.4),
            3: FlexColumnWidth(GetAMKID != '2'  ? 1.4 : 0),
            4: FlexColumnWidth(GetAMKID != '1' ? 1.4 : 0),
            5: const FlexColumnWidth(0.7),
            6: const FlexColumnWidth(2),
            7: const FlexColumnWidth(2),
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
                    'StringTotalequivalent'.tr,
                    font,
                    fontSize: 12,
                    color: PdfColors.black,
                  ),
                ),
                Container(
                  decoration: const BoxDecoration(),
                  padding: const EdgeInsets.all(1),
                  child: SimplePdf.text(
                    'StringCurrent_Balance'.tr,
                    font,
                    fontSize: 12,
                    color: PdfColors.black,
                  ),
                ),
                Container(
                  decoration: const BoxDecoration(),
                  padding: const EdgeInsets.all(1),
                  child: SimplePdf.text(
                    'StringLast_Balance'.tr,
                    font,
                    fontSize: 12,
                    color: PdfColors.black,
                  ),
                ),
                Container(
                  decoration: const BoxDecoration(),
                  padding: const EdgeInsets.all(1),
                  child: SimplePdf.text(
                    'StringAMDDA'.tr,
                    font,
                    fontSize: 12,
                    color: PdfColors.black,
                  ),
                ),
                Container(
                  decoration: const BoxDecoration(),
                  padding: const EdgeInsets.all(1),
                  child: SimplePdf.text(
                    'StringAMDMD'.tr,
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
                    'StringDetails'.tr,
                    font,
                    fontSize: 12,
                    color: PdfColors.black,
                  ),
                ),
                Container(
                  decoration: const BoxDecoration(),
                  padding: const EdgeInsets.all(1),
                  child: SimplePdf.text(
                    'StringAccount'.tr,
                    font,
                    fontSize: 12,
                    color: PdfColors.black,
                  ),
                ),
              ],
            ),
          ])
              : Table(border: TableBorder.all(), columnWidths: {
            0: const FlexColumnWidth(1.5),
            1: FlexColumnWidth(GetAMKID != '2'  ? 1.5 : 0),
            2: FlexColumnWidth(GetAMKID != '1' ? 1.5 : 0),
            3: const FlexColumnWidth(0.7),
            4: const FlexColumnWidth(2),
            5: const FlexColumnWidth(2),
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
                    'StringTotalequivalent'.tr,
                    font,
                    fontSize: 12,
                    color: PdfColors.black,
                  ),
                ),
                Container(
                  decoration: const BoxDecoration(),
                  padding: const EdgeInsets.all(1),
                  child: SimplePdf.text(
                    'StringAMDDA'.tr,
                    font,
                    fontSize: 12,
                    color: PdfColors.black,
                  ),
                ),
                Container(
                  decoration: const BoxDecoration(),
                  padding: const EdgeInsets.all(1),
                  child: SimplePdf.text(
                    'StringAMDMD'.tr,
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
                    'StringDetails'.tr,
                    font,
                    fontSize: 12,
                    color: PdfColors.black,
                  ),
                ),
                Container(
                  decoration: const BoxDecoration(),
                  padding: const EdgeInsets.all(1),
                  child: SimplePdf.text(
                    'StringAccount'.tr,
                    font,
                    fontSize: 12,
                    color: PdfColors.black,
                  ),
                ),
              ],
            ),
          ]),
          controller.Balance_Pay == '1' && StteingController().Print_Balance_Pay == true
              ? Table(
              border: pw.TableBorder.all(),
              columnWidths: {
                0: const FlexColumnWidth(1.4),
                1: FlexColumnWidth(1.4),
                2: FlexColumnWidth(1.4),
                3: FlexColumnWidth(GetAMKID != '2'  ? 1.4 : 0),
                4: FlexColumnWidth(GetAMKID != '1' ? 1.4 : 0),
                5: const FlexColumnWidth(0.7),
                6: const FlexColumnWidth(2),
                7: const FlexColumnWidth(2),
              },
              children: List.generate(get_ACC_MOV_D.length, (index) {
                Acc_Mov_D_Local ListACC_MOV_D = get_ACC_MOV_D[index];
                return TableRow(
                  children: [
                    Container(
                      alignment: pw.Alignment.center,
                      padding: const pw.EdgeInsets.only(
                          top: 2, bottom: 2, right: 1, left: 1),
                      child: SimplePdf.text(
                          controller.formatter.format(ListACC_MOV_D.AMDEQ).toString(),
                          font,
                          fontSize: 12),
                    ),
                    Container(
                      alignment: pw.Alignment.center,
                      padding: const pw.EdgeInsets.only(top: 2, bottom: 2, right: 1, left: 1),
                      child: SimplePdf.text(
                        ListACC_MOV_D.BACBA != null ?
                        GetAMKID != '2'?controller.formatter.format(double.parse(ListACC_MOV_D.BACBA.toString())+
                            double.parse(ListACC_MOV_D.BACBNF.toString()) + double.parse(ListACC_MOV_D.balance.toString())-
                            double.parse(ListACC_MOV_D.AMDDA.toString())) :
                        controller.formatter.format(double.parse(ListACC_MOV_D.BACBA.toString())+
                            double.parse(ListACC_MOV_D.BACBNF.toString()) +
                           double.parse(ListACC_MOV_D.balance.toString()) +
                            double.parse(ListACC_MOV_D.AMDMD.toString())): '0',
                        font,
                        fontSize: 12,
                        color: PdfColors.black,
                      ),
                    ),
                    Container(
                      alignment: pw.Alignment.center,
                      padding: const pw.EdgeInsets.only(top: 2, bottom: 2, right: 1, left: 1),
                      child: SimplePdf.text(
                        ListACC_MOV_D.BACBA != null ?
                        controller.formatter.format(double.parse(ListACC_MOV_D.BACBA.toString())+
                            double.parse(ListACC_MOV_D.BACBNF.toString())
                            + double.parse(ListACC_MOV_D.balance.toString())) : '0',
                        font,
                        fontSize: 12,
                        color: PdfColors.black,
                      ),
                    ),
                    Container(
                      alignment: pw.Alignment.center,
                      padding: const pw.EdgeInsets.only(top: 2, bottom: 2, right: 1, left: 1),
                      child: SimplePdf.text(
                        controller.formatter.format(ListACC_MOV_D.AMDDA).toString(),
                        font,
                        fontSize: 12,
                        color: PdfColors.black,
                      ),
                    ),
                    Container(
                      alignment: pw.Alignment.center,
                      padding: const pw.EdgeInsets.only(top: 2, bottom: 2, right: 1, left: 1),
                      child: SimplePdf.text(
                        ListACC_MOV_D.AMDMD == null ? '0'
                            : controller.formatter.format(ListACC_MOV_D.AMDMD).toString(),
                        font,
                        fontSize: 12,
                        color: PdfColors.black,
                      ),
                    ),
                    Container(
                      alignment: pw.Alignment.center,
                      padding: const pw.EdgeInsets.only(top: 2, bottom: 2, right: 1, left: 1),
                      child: Scsy_b? pw.Row(
                        mainAxisAlignment: pw.MainAxisAlignment.center, // توسيط المحتوى
                        children: [
                          buildSud(),
                        ],
                      ): SimplePdf.text(
                        ListACC_MOV_D.SCSY.toString(),
                        font,
                        align: TextAlign.center,
                        fontSize: 12,
                        color: PdfColors.black,
                      ),
                    ),
                    Container(
                      alignment: pw.Alignment.center,
                      padding: const pw.EdgeInsets.only(
                          top: 2, bottom: 2, right: 1, left: 1),
                      child: SimplePdf.text(
                        ListACC_MOV_D.AMDIN.toString(),
                        font,
                        fontSize: 10,
                        color: PdfColors.black,
                      ),
                    ),
                    Container(
                      alignment: pw.Alignment.center,
                      padding: const pw.EdgeInsets.only(
                          top: 2, bottom: 2, right: 1, left: 1),
                      child: SimplePdf.text(
                        ListACC_MOV_D.AANA_D.toString(),
                        font,
                        fontSize: 12,
                        color: PdfColors.black,
                      ),
                    ),
                  ],
                );
              }))
              : Table(
              border: pw.TableBorder.all(),
              columnWidths: {
                0: const FlexColumnWidth(1.5),
                1: FlexColumnWidth(GetAMKID != '2'  ? 1.5 : 0),
                2: FlexColumnWidth(GetAMKID != '1' ? 1.5 : 0),
                3: const FlexColumnWidth(0.7),
                4: const FlexColumnWidth(2),
                5: const FlexColumnWidth(2),
              },
              children: List.generate(get_ACC_MOV_D.length, (index) {
                Acc_Mov_D_Local ListACC_MOV_D = get_ACC_MOV_D[index];
                return pw.TableRow(
                  children: [
                    pw.Container(
                      alignment: pw.Alignment.center,
                      padding: const pw.EdgeInsets.only(
                          top: 2, bottom: 2, right: 1, left: 1),
                      child: SimplePdf.text(
                          controller.formatter
                              .format(ListACC_MOV_D.AMDEQ)
                              .toString(),
                          font,
                          fontSize: 12),
                    ),
                    pw.Container(
                      alignment: pw.Alignment.center,
                      padding: const pw.EdgeInsets.only(
                          top: 2, bottom: 2, right: 1, left: 1),
                      child: SimplePdf.text(
                        controller.formatter
                            .format(ListACC_MOV_D.AMDDA)
                            .toString(),
                        font,
                        fontSize: 12,
                        color: PdfColors.black,
                      ),
                    ),
                    pw.Container(
                      alignment: pw.Alignment.center,
                      padding: const pw.EdgeInsets.only(
                          top: 2, bottom: 2, right: 1, left: 1),
                      child: SimplePdf.text(
                        ListACC_MOV_D.AMDMD == null
                            ? '0'
                            : controller.formatter
                            .format(ListACC_MOV_D.AMDMD)
                            .toString(),
                        font,
                        fontSize: 12,
                        color: PdfColors.black,
                      ),
                    ),
                    Container(
                      alignment: pw.Alignment.center,
                      padding: const pw.EdgeInsets.only(
                          top: 2, bottom: 2, right: 1, left: 1),
                      child: Scsy_b? pw.Row(
                        mainAxisAlignment: pw.MainAxisAlignment.center, // توسيط المحتوى
                        children: [
                          buildSud(),
                          pw.SizedBox(width: 5), // مسافة صغيرة بين النص والصورة
                        ],
                      ): SimplePdf.text(
                        ListACC_MOV_D.SCSY.toString(),
                        font,
                        align: TextAlign.center,
                        fontSize: 12,
                        color: PdfColors.black,
                      ),
                    ),
                    pw.Container(
                      alignment: pw.Alignment.center,
                      padding: const pw.EdgeInsets.only(
                          top: 2, bottom: 2, right: 1, left: 1),
                      child: SimplePdf.text(
                        ListACC_MOV_D.AMDIN.toString(),
                        font,
                        fontSize: 10,
                        color: PdfColors.black,
                      ),
                    ),
                    pw.Container(
                      alignment: pw.Alignment.center,
                      padding: const pw.EdgeInsets.only(
                          top: 2, bottom: 2, right: 1, left: 1),
                      child: SimplePdf.text(
                        ListACC_MOV_D.AANA_D.toString(),
                        font,
                        fontSize: 12,
                        color: PdfColors.black,
                      ),
                    ),
                  ],
                );
              })),
          Table(border: TableBorder.all(), columnWidths: {
            0:  FlexColumnWidth(GetAMKID == '2' ||GetAMKID == '1' ? 2 : 0),
            1: FlexColumnWidth(GetAMKID != '1'  ? 2 : 0),
            2: FlexColumnWidth(GetAMKID != '2' ? 2 : 0),
          }, children: [
            TableRow(
              decoration: const BoxDecoration(
                color: PdfColors.MyColors,
              ),
              children: [
                Container(
                  decoration: const BoxDecoration(),
                  padding: const EdgeInsets.all(1),
                  child: SimplePdf.text(
                    'StringTotalequivalent'.tr,
                    font,
                    fontSize: 12,
                    color: PdfColors.black,
                  ),
                ),
                Container(
                  decoration: const BoxDecoration(),
                  padding: const EdgeInsets.all(1),
                  child: SimplePdf.text(
                    'StringAMDMD'.tr,
                    font,
                    fontSize: 12,
                    color: PdfColors.black,
                  ),
                ),
                Container(
                  decoration: const BoxDecoration(),
                  padding: const EdgeInsets.all(1),
                  child: SimplePdf.text(
                    'StringAMDDA'.tr,
                    font,
                    fontSize: 12,
                    color: PdfColors.black,
                  ),
                ),
              ],
            ),
          ]),
          Table(border: TableBorder.all(), columnWidths: {
            0:  FlexColumnWidth(GetAMKID == '2' ||GetAMKID == '1' ? 2 : 0),
            1: FlexColumnWidth(GetAMKID != '1'  ? 2 : 0),
            2: FlexColumnWidth(GetAMKID != '2' ? 2 : 0),
          }, children: [
            TableRow(
              children: [
                Container(
                  decoration: const BoxDecoration(),
                  padding: const EdgeInsets.all(1),
                  child: SimplePdf.text(
                    "${SUM_ACC_MOV_D.elementAt(0).SUMAMDEQ == null ? '0' : controller.formatter.format(SUM_ACC_MOV_D.elementAt(0).SUMAMDEQ).toString()}",
                    font,
                    fontSize: 14,
                    color: PdfColors.black,
                  ),
                ),
                Container(
                  decoration: const BoxDecoration(),
                  padding: const EdgeInsets.all(1),
                  child: SimplePdf.text(
                    " ${SUM_ACC_MOV_D.elementAt(0).SUMAMDMD == null ? '0' : controller.formatter.format(SUM_ACC_MOV_D.elementAt(0).SUMAMDMD).toString()}",
                    font,
                    fontSize: 14,
                    color: PdfColors.black,
                  ),
                ),
                Container(
                  decoration: const BoxDecoration(),
                  padding: const EdgeInsets.all(1),
                  child: SimplePdf.text(
                    " ${SUM_ACC_MOV_D.elementAt(0).SUMAMDDA == null ? '0' : controller.formatter.format(SUM_ACC_MOV_D.elementAt(0).SUMAMDDA).toString()}",
                    font,
                    fontSize: 14,
                    color: PdfColors.black,
                  ),
                ),
              ],
            ),
          ]),
          SimplePdf.buildFooter_SIN(font,controller.SDDDA,controller.SDDSA),
          SimplePdf.buildSignature(font,controller.signature),
        ],
        footer: (context) =>  SimplePdf.buildFooter(context,font,controller.SDDSA),
      ),
    );
    List<int> bytes = await pdf.save();
    FileHelper.share(
        msg: "iiiiiiiiii",
        mode: mode,
        bytes: bytes,
        fileName: ListAcc_Mov_M.elementAt(0).AMKID == 1
            ? '${'StringReceiptVoucher'.tr} - ${ListAcc_Mov_M.elementAt(0).AMMNO}.pdf'
            : ListAcc_Mov_M.elementAt(0).AMKID == 2
            ? '${'StringPayOuts'.tr} - ${ListAcc_Mov_M.elementAt(0).AMMNO}.pdf'
            : ListAcc_Mov_M.elementAt(0).AMKID == 3
            ? '${'StringCollection_Vouchers'.tr} - ${ListAcc_Mov_M.elementAt(0).AMMNO}.pdf'
            : '${'StringJournalVouchers'.tr} - ${ListAcc_Mov_M.elementAt(0).AMMNO}.pdf',
        //AMKID: ListAcc_Mov_M.elementAt(0).AMKID!,
        BMMID: ListAcc_Mov_M.elementAt(0).AMMID!);
  } catch (e, stackTrace) {
  print('$e $stackTrace');
    Fluttertoast.showToast(
        msg: e.toString(),
        toastLength: Toast.LENGTH_LONG,
        textColor: ma.Colors.white,
        backgroundColor: ma.Colors.redAccent);
    print(e.toString());
  }
}
