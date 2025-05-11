import '../../Operation/Controllers/Pay_Out_Controller.dart';
import '../../Operation/models/acc_mov_d.dart';
import '../../Operation/models/acc_mov_m.dart';
import '../../PrintFile/share_mode.dart';
import '../../PrintFile/simple_pdf.dart';
import '../../Setting/controllers/login_controller.dart';
import '../../Setting/controllers/setting_controller.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:number_to_character/number_to_character.dart';
import 'package:number_to_word_arabic/number_to_word_arabic.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:pdf/widgets.dart';

import '../file_helper.dart';

taxTikcetReportThermal({
  required List<Acc_Mov_M_Local> orderDetails,
  String? msg,
  required ShareMode mode,
  String? Type_Rep
  // required UserTaxInfo userTaxInfo,
  // required InvoiceSetting invoiceSetting,
}) async {
  // try {
  final Pay_Out_Controller controller = Get.find();
  final pdf = pw.Document();
  const double inch = 72.0;
  const double mm = inch / 25.4;

  final Uint8List fontData = await FileHelper.getFileFromAssets('Assets/fonts/HacenTunisia.ttf');
  final Uint8List fontSa = await FileHelper.getFileFromAssets('Assets/fonts/NewRiyal-Regular.ttf');
  final ttf = pw.Font.ttf(fontData.buffer.asByteData());
  final Sau = pw.Font.ttf(fontSa.buffer.asByteData());

  var converter = NumberToCharacterConverter('en');
  final image = await SimplePdf.loadImage();

  //final MemoryImage imageData = await SimplePdf.getSaudiRiyalImage();
  bool Scsy_b = orderDetails.elementAt(0).SCSY=='SAR';

  final FontSize = StteingController().FONT_SIZE_PDF;

  Widget buildSud(){
    return SimplePdf.text(
      "\$",
      Sau,
      fontSize: FontSize,
    );
  }

  pw.Widget buildHeader() {
    return Table(children: [
      TableRow(
        children: [
          Column(children: [
            StteingController().Print_Image == true
                ? Container(width: 48.w, child: Image(image))
                : Container(),
            LoginController().experimentalcopy == 1
                ? pw.Image(image, height: 55, width: 55)
                : Container(),
            SimplePdf.text(
              controller.SONA.toString(),
              ttf,
              fontSize: FontSize,
              color: PdfColors.black,
            ),
            Container(
              margin: pw.EdgeInsets.symmetric(vertical: 2),
              decoration: pw.BoxDecoration(
                color: PdfColor.fromHex("#ABABAB"),
                borderRadius: pw.BorderRadius.circular(5),
              ),
              child: SimplePdf.text(
                controller.AMKID == 1
                    ? '  ${'StringReceiptVoucher'.tr}   ${orderDetails.elementAt(0).PKNA_D.toString()}  '
                    : controller.AMKID == 2
                        ? ' ${'StringPaymentVoucher'.tr}  ${orderDetails.elementAt(0).PKNA_D.toString()} '
                        : controller.AMKID == 3
                            ? ' ${'StringCollectionsVoucher'.tr}  ${orderDetails.elementAt(0).PKNA_D.toString()} '
                            : ' ${'StringJournalVoucher'.tr} ',
                ttf,
                fontSize: FontSize,
              ),
            ),
          ]),
        ],
      ),
    ]);
  }

  pw.TableRow buildRowContect(value, String label) {
    return TableRow(
      children: [
        pw.Container(
          padding: const pw.EdgeInsets.all(1),
          child: SimplePdf.text(
            value.toString(),
            ttf,
            align: TextAlign.center,
            fontSize: FontSize,
            color: PdfColors.black,
          ),
        ),
        pw.Container(
          padding: const pw.EdgeInsets.all(1),
          child: SimplePdf.text(
            '  ' + label.tr,
            ttf,
            align: TextAlign.right,
            fontSize: FontSize,
            color: PdfColors.black,
          ),
        )
      ],
    );
  }

  pw.Widget buildContent_label(String label) {
    return pw.Container(
      decoration: const BoxDecoration(),
      padding: const EdgeInsets.all(1),
      child: SimplePdf.text(
        label.tr,
        ttf,
        fontSize: FontSize,
        color: PdfColors.black,
      ),
    );
  }

  pw.Widget buildContent_Data(String value) {
    return pw.Container(
      alignment: Alignment.center,
      padding: const pw.EdgeInsets.only(top: 2, bottom: 2, right: 1, left: 1),
      child: SimplePdf.text(value.toString(), ttf, fontSize: FontSize),
    );
  }

  pw.Widget buildFooter() {
    final order = orderDetails.elementAt(0);

    // تذليل المستند
    pw.Widget buildMainText() {
      return pw.Container(
        child: SimplePdf.text(
          controller.SDDDA,
          ttf,
          fontSize: FontSize,
          color: PdfColors.black,
        ),
      );
    }

    // التوقيع
    pw.Widget buildSignature() {
      if (controller.signature != null && controller.signature!.isNotEmpty) {
        return pw.Row(
          mainAxisAlignment: pw.MainAxisAlignment.center,
          children: [
            pw.SizedBox(height: 3),
            pw.Image(
              pw.MemoryImage(controller.signature!),
              width: 60,
              height: 60,
            ),
            SimplePdf.text("StringSignature".tr, ttf, fontSize: FontSize),
          ],
        );
      }
      return pw.Container();
    }

    // بناء باقي المعلومات
    pw.Widget buildFooterInfo() {
      return pw.Column(
        children: [
          pw.Row(
            mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
            children: [
              SimplePdf.text('StrinUser'.tr + ' ${LoginController().SUNA}', ttf,
                  fontSize: FontSize),
              SimplePdf.text(
                  'StringDateofPrinting'.tr +
                      ': ' +
                      '${DateFormat('dd-MM-yyyy HH:m').format(DateTime.now())}',
                  ttf,
                  fontSize: FontSize),
            ],
          ),
          if (controller.SUMO != 'null' &&
              controller.SUMO.toString().isNotEmpty)
            pw.Row(
              mainAxisAlignment: pw.MainAxisAlignment.start,
              children: [
                SimplePdf.text(
                    'StringPhone'.tr + ': ' + '${controller.SUMO}', ttf,
                    fontSize: FontSize),
              ],
            ),
          SimplePdf.text(
            ' ',
            ttf,
            fontSize: 9,
            color: PdfColors.black,
          )
        ],
      );
    }

    return pw.Column(
      children: [
        buildMainText(),
        buildFooterInfo(),
        buildSignature(),
      ],
    );
  }

  pdf.addPage(
    pw.Page(
      margin: EdgeInsets.only(
          right: StteingController().RIGHT_MARGIN.toDouble(),
          bottom: StteingController().BOTTOM_MARGIN.toDouble(),
          left: StteingController().LEFT_MARGIN.toDouble(),
          top: StteingController().TOP_MARGIN.toDouble()),
      pageFormat: Type_Rep=='2'?PdfPageFormat.roll57 :PdfPageFormat.roll80,
      build: (pw.Context context) {
        return StteingController().Type_Model == 2
            ? Column(
                children: [
                  //header
                  Row(
                    mainAxisAlignment: pw.MainAxisAlignment.center,
                    children: [
                      pw.Expanded(
                        child: pw.Column(
                            crossAxisAlignment: pw.CrossAxisAlignment.center,
                            children: [
                              StteingController().Print_Image == true
                                  ? pw.Image(image, height: 50, width: 50)
                                  : Container(),
                              SimplePdf.text(
                                controller.SONA.toString(),
                                ttf,
                                fontSize: 10,
                                color: PdfColors.black,
                              ),
                            ]),
                      ),
                      // SimplePdf.spaceW(width: 5),  'الرقم الضريبي '
                    ],
                  ),
                  Row(
                    mainAxisAlignment: pw.MainAxisAlignment.center,
                    children: [
                      pw.Expanded(
                        child: pw.Column(
                            crossAxisAlignment: pw.CrossAxisAlignment.center,
                            children: [
                              pw.Container(
                                margin: pw.EdgeInsets.symmetric(vertical: 2),
                                decoration: pw.BoxDecoration(
                                  color: PdfColor.fromHex("#ABABAB"),
                                  borderRadius: pw.BorderRadius.circular(5),
                                ),
                                child: SimplePdf.text(
                                  controller.AMKID == 1
                                      ? '  ${'StringReceiptVoucher'.tr}   ${orderDetails.elementAt(0).PKNA_D.toString()}  '
                                      : controller.AMKID == 2
                                          ? ' ${'StringPaymentVoucher'.tr}  ${orderDetails.elementAt(0).PKNA_D.toString()} '
                                          : controller.AMKID == 3
                                              ? ' ${'StringCollectionsVoucher'.tr}  ${orderDetails.elementAt(0).PKNA_D.toString()} '
                                              : ' ${'StringJournalVoucher'.tr} ',
                                  ttf,
                                  fontSize: 10,
                                ),
                              ),
                            ]),
                      ),
                      // SimplePdf.spaceW(width: 5),  'الرقم الضريبي '
                    ],
                  ),
                  // /// Simplified Tax Invoice
                  // pw.Container(
                  //   width: 100,
                  //   alignment: pw.Alignment.center,
                  //   padding: pw.EdgeInsets.all(2),
                  //   child: SimplePdf.text(
                  //     orderDetails.elementAt(0).BMMPR==1?
                  //     'نسخة':'' , ttf,
                  //     fontSize: 8,color: PdfColors.black,
                  //   ),
                  // ),
                  Table(border: pw.TableBorder.all(), children: [
                    TableRow(
                      children: [
                        pw.Container(
                          padding: const pw.EdgeInsets.only(right: 2, left: 2),
                          width: 100,
                          height: 100,
                          child: pw.Column(children: [
                            pw.Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  SimplePdf.text(
                                    'branch',
                                    ttf,
                                    fontSize: 9,
                                  ),
                                  //pw.Spacer(),
                                  SimplePdf.text(
                                    ' ${orderDetails.elementAt(0).BINA_D.toString()} ',
                                    ttf,
                                    fontSize: 9,
                                  ),
                                  //SimplePdf.spaceW(width: 13),
                                  SimplePdf.text(
                                    'الفرع',
                                    ttf,
                                    fontSize: 9,
                                  ),
                                ]),
                            pw.Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  SimplePdf.text(
                                    'The date',
                                    ttf,
                                    fontSize: 9,
                                  ),
                                  // pw.Spacer(),
                                  SimplePdf.text(
                                    ' ${orderDetails.elementAt(0).AMMDO.toString()} ',
                                    ttf,
                                    fontSize: 9,
                                  ),
                                  //  SimplePdf.spaceW(width: 13),
                                  SimplePdf.text(
                                    'التاريخ',
                                    ttf,
                                    fontSize: 9,
                                  ),
                                ]),
                            pw.Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  SimplePdf.text(
                                    'Number',
                                    ttf,
                                    fontSize: 9,
                                  ),
                                  // pw.Spacer(),
                                  SimplePdf.text(
                                    ' ${orderDetails.elementAt(0).AMMNO.toString()} ',
                                    ttf,
                                    fontSize: 9,
                                  ),
                                  // SimplePdf.spaceW(width: 13),
                                  SimplePdf.text(
                                    'الرقم',
                                    ttf,
                                    fontSize: 9,
                                  ),
                                ]),
                            controller.AMKID == 1 ||
                                    controller.AMKID == 2 ||
                                    controller.AMKID == 2
                                ? Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                        SimplePdf.text(
                                          orderDetails.elementAt(0).PKID == '1'
                                              ? 'box'
                                              : orderDetails
                                                          .elementAt(0)
                                                          .PKID ==
                                                      '9'
                                                  ? 'Credit Card'
                                                  : 'Bank',
                                          ttf,
                                          fontSize: 8,
                                        ),
                                        // pw.Spacer(),
                                        SimplePdf.text(
                                          orderDetails.elementAt(0).PKID == '1'
                                              ? orderDetails
                                                  .elementAt(0)
                                                  .ACNA_D
                                                  .toString()
                                              : orderDetails
                                                          .elementAt(0)
                                                          .PKID ==
                                                      '8'
                                                  ? orderDetails
                                                      .elementAt(0)
                                                      .BCCNA_D
                                                      .toString()
                                                  : orderDetails
                                                      .elementAt(0)
                                                      .ABNA_D
                                                      .toString(),
                                          ttf,
                                          fontSize: 8,
                                        ),
                                        // SimplePdf.spaceW(width: 13),
                                        SimplePdf.text(
                                          orderDetails.elementAt(0).PKID == '1'
                                              ? 'الصندوق'
                                              : orderDetails
                                                          .elementAt(0)
                                                          .PKID ==
                                                      '9'
                                                  ? 'بطاقة الائتمان'
                                                  : 'البنك',
                                          ttf,
                                          fontSize: 8,
                                        ),
                                      ])
                                : Container(),
                            controller.AMKID == 1 ||
                                    controller.AMKID == 2 ||
                                    controller.AMKID == 2
                                ? Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                        SimplePdf.text(
                                          'Amount',
                                          ttf,
                                          fontSize: 9,
                                        ),
                                        // pw.Spacer(),
                                        SimplePdf.text(
                                          ' ${controller.formatter.format(orderDetails.elementAt(0).AMMAM)} ',
                                          ttf,
                                          fontSize: 9,
                                        ),
                                        // SimplePdf.spaceW(width: 13),
                                        SimplePdf.text(
                                          'المبلغ',
                                          ttf,
                                          fontSize: 9,
                                        ),
                                      ])
                                : Container(),
                            //converter.convertDouble(double.parse(SUMBMDAMTController.text));
                            controller.AMKID == 1 ||
                                    controller.AMKID == 2 ||
                                    controller.AMKID == 2
                                ? Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                        SimplePdf.text(
                                          LoginController().LAN == 1
                                              ? ' ${Tafqeet.convert(orderDetails.elementAt(0).AMMAM!.toString())} ${orderDetails.elementAt(0).SCNA_D.toString()} '
                                              : '${converter.convertDouble(double.parse(orderDetails.elementAt(0).AMMAM.toString().contains('.0') ? orderDetails.elementAt(0).AMMAM!.round().toString() : orderDetails.elementAt(0).AMMAM.toString())).replaceFirst(RegExp(r" و  و"), "")} ${orderDetails.elementAt(0).SCNA_D.toString()}',
                                          ttf,
                                          fontSize: 8,
                                        )
                                      ])
                                : Container(),
                            pw.Container(
                              alignment: pw.Alignment.center,
                              child: SimplePdf.text(
                                orderDetails.elementAt(0).AMMPR == 1 &&
                                        (controller.ShowRePrintingVoucher ==
                                                '1' ||
                                            controller.ShowRePrinting == 1)
                                    ? 'StringReplacementoflost'.tr
                                    : '',
                                ttf,
                                fontSize: 9,
                                color: PdfColors.black,
                              ),
                            ),
                          ]),
                        ),
                      ],
                    ),

                    // Now the next table row
                  ]),
                  SimplePdf.spaceH(height: 5),
                  // data
                  Table(border: pw.TableBorder.all(), columnWidths: {
                    0: pw.FlexColumnWidth(1),
                    1: pw.FlexColumnWidth(1),
                    2: pw.FlexColumnWidth(1),
                  }, children: [
                    pw.TableRow(
                      decoration:
                          pw.BoxDecoration(color: PdfColor.fromHex("#ABABAB")),
                      children: [
                        Container(
                          width: 100,
                          decoration: pw.BoxDecoration(),
                          padding: pw.EdgeInsets.all(1),
                          child: Column(children: [
                            SimplePdf.text(
                              'StringAmount'.tr,
                              ttf,
                              fontSize: 9,
                              color: PdfColors.black,
                            ),
                          ]),
                        ),
                        Container(
                          width: 100,
                          decoration: pw.BoxDecoration(),
                          padding: pw.EdgeInsets.all(1),
                          child: pw.Column(children: [
                            SimplePdf.text(
                              'StringAccount'.tr,
                              ttf,
                              fontSize: 9,
                              color: PdfColors.black,
                            ),
                          ]),
                        ),
                      ],
                    ),

                    ///data Rows

                    // Now the next table row
                  ]),
                  Table(
                      border: pw.TableBorder.all(),
                      columnWidths: {
                        0: pw.FlexColumnWidth(1),
                        1: pw.FlexColumnWidth(1),
                        2: pw.FlexColumnWidth(1),
                      },
                      children: List.generate(get_ACC_MOV_D.length, (index) {
                        Acc_Mov_D_Local product = get_ACC_MOV_D[index];
                        return pw.TableRow(
                          children: [
                            // Container(
                            //   width: 100,
                            //   alignment: pw.Alignment.center,
                            //   padding: pw.EdgeInsets.only(top: 2,bottom: 2,right: 1,left: 1),
                            //   child: SimplePdf.text(
                            //       controller.SCSY.toString(),
                            //       ttf,
                            //       fontSize: 6),
                            // ),
                            Container(
                              width: 100,
                              alignment: pw.Alignment.center,
                              child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                              Scsy_b? buildSud():
                                    SimplePdf.text(
                                        orderDetails
                                            .elementAt(0)
                                            .SCSY
                                            .toString(),
                                        ttf,
                                        fontSize: 8),
                                    SimplePdf.text(
                                        controller.AMKID == 2
                                            ? controller.formatter
                                                .format(product.AMDMD)
                                            : controller.formatter
                                                .format(product.AMDDA),
                                        ttf,
                                        fontSize: 8),
                                  ]),
                            ),
                            Container(
                              width: 100,
                              alignment: pw.Alignment.center,
                              padding: const pw.EdgeInsets.only(
                                  top: 2, bottom: 2, right: 1, left: 1),
                              child: SimplePdf.text(
                                  product.AANA_D.toString(), ttf,
                                  fontSize: 8),
                            ),
                          ],
                        );
                      })),

                  SimplePdf.spaceH(height: 3),
                  pw.Container(
                    width: 230,
                    padding: const pw.EdgeInsets.only(top: 2, bottom: 3),
                    child: SimplePdf.text(
                      controller.SDDDA,
                      ttf,
                      fontSize: 8,
                      color: PdfColors.black,
                    ),
                  ),
                  controller.signature.isNull || controller.signature!.isEmpty
                      ? Container()
                      : Row(
                          mainAxisAlignment: pw.MainAxisAlignment.center,
                          children: [
                              SizedBox(height: 3),
                              pw.Image(
                                pw.MemoryImage(
                                  controller.signature!,
                                ),
                                width: 60,
                                height: 60,
                              ),
                              SimplePdf.text("StringSignature".tr, ttf,
                                  fontSize: 8),
                            ]),
                  pw.Row(
                    mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                    children: [
                      pw.Expanded(
                        child: pw.Row(
                            mainAxisAlignment:
                                pw.MainAxisAlignment.spaceBetween,
                            children: [
                              SimplePdf.text(
                                  'StrinUser'.tr + ' ${LoginController().SUNA}',
                                  ttf,
                                  fontSize: 6),
                              SimplePdf.spaceW(width: 10),
                              SimplePdf.text(
                                  'StringDateofPrinting'.tr +
                                      ': ' +
                                      '${DateFormat('dd-MM-yyyy HH:m').format(DateTime.now())}',
                                  ttf,
                                  fontSize: 6),
                            ]),
                      ),
                      // SimplePdf.spaceW(width: 5),  'الرقم الضريبي '
                    ],
                  ),
                  controller.SUMO != 'null'
                      ? Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: <pw.Widget>[
                            SimplePdf.text('تلفون: ${controller.SUMO}', ttf,
                                fontSize: 7),
                          ],
                        )
                      : Container(),
                  SimplePdf.text(
                    ' ',
                    ttf,
                    fontSize: 9,
                    color: PdfColors.black,
                  )
                ],
              )
            : Column(
                children: [
                  //header
                  buildHeader(),
                  Table(border: pw.TableBorder.all(), children: [
                    TableRow(
                      children: [
                        Table(border: pw.TableBorder.all(), columnWidths: {
                          0: pw.FixedColumnWidth(160), // العمود الأول
                          1: pw.FixedColumnWidth(65), // العمود الثاني
                        }, children: [
                          buildRowContect(
                              ' ${orderDetails.elementAt(0).BINA_D.toString()} ',
                              "${'StringBIID'.tr}"),
                          buildRowContect(
                              orderDetails.elementAt(0).AMMDO.toString(),
                              "${'StringSMDED2'.tr}"),
                          buildRowContect(
                              orderDetails.elementAt(0).AMMNO.toString(),
                              "${'StringSMMID'.tr}"),
                          controller.AMKID == 1 ||
                                  controller.AMKID == 2 ||
                                  controller.AMKID == 2
                              ? buildRowContect(
                                  orderDetails.elementAt(0).PKID == '1'
                                      ? orderDetails
                                          .elementAt(0)
                                          .ACNA_D
                                          .toString()
                                      : orderDetails.elementAt(0).PKID == '8'
                                          ? orderDetails
                                              .elementAt(0)
                                              .BCCNA_D
                                              .toString()
                                          : orderDetails
                                              .elementAt(0)
                                              .ABNA_D
                                              .toString(),
                                  orderDetails.elementAt(0).PKID == '1'
                                      ? "${'StringCashier'.tr}"
                                      : orderDetails.elementAt(0).PKID == '8'
                                          ? "  ${'StringCreditCard'.tr}"
                                          : "${'StringBank'.tr}")
                              : TableRow(children: []),
                          controller.AMKID == 1 ||
                                  controller.AMKID == 2 ||
                                  controller.AMKID == 3
                              ?
                          buildRowContect(
                                  controller.formatter
                                      .format(orderDetails.elementAt(0).AMMAM),
                                  "${'StringAmount'.tr}")
                              : TableRow(children: []),
                          // Now the next table row
                        ]),
                      ],
                    ),
                    TableRow(
                      children: [
                        SimplePdf.text(
                          LoginController().LAN == 2
                              ? '${converter.convertDouble(double.parse(orderDetails.elementAt(0).AMMAM.toString().contains('.0') ? orderDetails.elementAt(0).AMMAM!.round().toString() : orderDetails.elementAt(0).AMMAM.toString())).replaceFirst(RegExp(r" و  و"), "")} ${orderDetails.elementAt(0).SCNA_D.toString()}'
                              : ' ${Tafqeet.convert(orderDetails.elementAt(0).AMMAM!.toString())} ${orderDetails.elementAt(0).SCNA_D.toString()} ',
                          ttf,
                          fontSize: 9.5,
                        ),
                      ],
                    ),
                  ]),
                  SimplePdf.spaceH(height: 3),
                  // data
                  Table(
                      border: pw.TableBorder.all(),
                      columnWidths: controller.Balance_Pay == '1' &&
                              StteingController().Print_Balance_Pay == true
                          ? {
                              0: pw.FlexColumnWidth(1),
                              1: pw.FlexColumnWidth(1),
                              2: pw.FlexColumnWidth(1.5),
                            }
                          : {
                              0: pw.FlexColumnWidth(1),
                              1: pw.FlexColumnWidth(1),
                              2: pw.FlexColumnWidth(1),
                            },
                      children: [
                        pw.TableRow(
                          decoration: pw.BoxDecoration(
                              color: PdfColor.fromHex("#ABABAB")),
                          children: [
                            buildContent_label(controller.Balance_Pay == '1' &&
                                    StteingController().Print_Balance_Pay ==
                                        true
                                ? 'StringBAL_ACC'.tr
                                : 'StringDetails'.tr),
                            buildContent_label('StringAmount'.tr),
                            buildContent_label('StringAccount'.tr),
                          ],
                        ),
                      ]),
                  Table(
                          border: pw.TableBorder.all(),
                          columnWidths: controller.Balance_Pay == '1' && StteingController().Print_Balance_Pay == true
                              ? {
                                  0: pw.FlexColumnWidth(1),
                                  1: pw.FlexColumnWidth(1),
                                  2: pw.FlexColumnWidth(1.5),
                                }
                              : {
                                  0: pw.FlexColumnWidth(1),
                                  1: pw.FlexColumnWidth(1),
                                  2: pw.FlexColumnWidth(1),
                                },
                          children:
                              List.generate(get_ACC_MOV_D.length, (index) {
                            Acc_Mov_D_Local product = get_ACC_MOV_D[index];
                            return pw.TableRow(
                              children: [
                                buildContent_Data(  controller.Balance_Pay == '1'
                                    && StteingController().Print_Balance_Pay == true? product.BACBA == null ? '0'
                                    : controller.formatter.format(double.parse(product.BACBA.toString())).toString():
                                product.AMDIN.toString()),
                                Scsy_b? pw.Row(
                                  mainAxisAlignment: pw.MainAxisAlignment.center, // توسيط المحتوى
                                  children: [
                                    buildSud(),
                                    pw.SizedBox(width: 1),
                                    buildContent_Data("${controller.AMKID == 2 ? "${controller.formatter.format(product.AMDMD)}" :
                                    "${controller.formatter.format(product.AMDDA)}"}")// مسافة صغيرة بين النص والصورة
                                  ],
                                ):
                                buildContent_Data("${controller.AMKID == 2 ? "${orderDetails.elementAt(0).SCSY.toString()} ${controller.formatter.format(product.AMDMD)} " :
                                "${orderDetails.elementAt(0).SCSY.toString()} ${controller.formatter.format(product.AMDDA)} "}"),
                                buildContent_Data( product.AANA_D.toString()),
                              ],
                            );
                          })),
                  SimplePdf.spaceH(height: 3),
                  buildFooter(),
                ],
              );
      },
    ),
  );

  List<int> bytes = await pdf.save();
  FileHelper.share(
      msg: "iiiiiiiiii",
      mode: mode,
      bytes: bytes,
      fileName: 'vouchers - ${orderDetails.elementAt(0).AMMNO}.pdf',
      BMMID: orderDetails.elementAt(0).AMMID!);
     // AMMID: orderDetails.elementAt(0).AMMID!);
}
