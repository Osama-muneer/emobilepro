import 'package:number_to_word_arabic/number_to_word_arabic.dart';
import '../../Operation/Controllers/sale_invoices_controller.dart';
import '../../Operation/models/bil_mov_d.dart';
import '../../PrintFile/share_mode.dart';
import '../../PrintFile/simple_pdf.dart';
import '../../Setting/controllers/setting_controller.dart';
import 'package:flutter/services.dart';
import '../../Setting/controllers/login_controller.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:pdf/widgets.dart';
import '../../Widgets/Tafqeet.dart';
import '../invoice_controller.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:pdf/widgets.dart';
import 'package:flutter/material.dart' as ma;
import '../file_helper.dart';

taxTikcetReportThermal({
  String? msg,
  required ShareMode mode,
  String? Type_Rep,
}) async {
  try {
    final Sale_Invoices_Controller controller = Get.find();

    var item = controller.BIF_MOV_M_PRINT.elementAt(0);
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
    final ttf = pw.Font.ttf(fontData.buffer.asByteData());
    final Sau = pw.Font.ttf(fontSa.buffer.asByteData());
    final image = await SimplePdf.loadImage();
   // final pw.MemoryImage imageData = await SimplePdf.getSaudiRiyalImage();
    bool Scsy_b = item.SCSY=='SAR';
    final isTaxCondition = (controller.SVVL_TAX != '2' && (controller.BCTX.toString() != 'null'
        || controller.BCTX.toString().isNotEmpty));
    final bmmdif = item.BMMDIF!;
    final bmmdi = item.BMMDI!;
    final bmmdia = item.BMMDIA!;
    final bmmam = item.BMMAM!;
    final bmmtx = item.BMMTX!;
    final bmmtx2 = item.BMMTX2!;
    final bmmmt = item.BMMMT!;
    final totalAmountWithoutTax = bmmam - bmmtx - bmmdi - bmmdif - bmmdia + bmmtx2;
    final FontSize = StteingController().FONT_SIZE_PDF;
    final isTax2Available = item.TTID2.toString() != 'null' && bmmtx2 > 0;
    final isDiscountAvailable = bmmdi + bmmdia > 0;
    final isBmmdifAvailable = bmmdif > 0;
    final isTotalAmountWithoutTaxChanged = totalAmountWithoutTax != (bmmam - bmmtx);

    pw.Widget buildHeader() {
      return Table(children: [
        TableRow(
          children: [
            Column(children: [
              StteingController().Print_Image == true
                  ? Container(width: 50, child: Image(image))
                  : Container(),
              LoginController().experimentalcopy == 1
                  ? pw.Image(image, height: 55, width: 55)
                  : Container(),
              SimplePdf.text(
                controller.SONA.toString(),
                ttf,
                fontSize: FontSize+2,
                color: PdfColors.black,
              ),
              controller.View_Tax_number_when_print_Invoices == '1'
                  ?controller.SOTX.toString() != 'null' || controller.SOTX.toString().isNotEmpty ? Container(
                alignment: Alignment.center,
                child: SimplePdf.text(
                  'الرقم الضريبي)TAV(:  ${controller.SOTX.toString()} ',
                  ttf,
                  fontSize: FontSize+1,
                  color: PdfColors.black,
                ),
              ): Container()
                  : Container(),
              SimplePdf.text(
                " ${'StringAddress'.tr}: ${controller.SOAD.toString() == 'null' ? '' : controller.SOAD.toString()}",
                ttf,
                fontSize: FontSize,
                color: PdfColors.black,
              ),
              Container(
                margin: const pw.EdgeInsets.symmetric(vertical: 4),
                decoration: pw.BoxDecoration(
                  color: PdfColor.fromHex("#ABABAB"),
                  borderRadius: pw.BorderRadius.circular(5),
                ),
                child: SimplePdf.text(
                  controller.SVVL_TAX != '2'
                      ? controller.BCTX.toString() == 'null' || controller.BCTX.toString().isEmpty
                      ? item.BMKID == 4 || item.BMKID == 12
                      ? 'مردود فاتورة ضريبية  '
                      : controller.BMKID == 7
                      ? 'StringQuotations'.tr
                      : controller.BMKID == 10
                      ? 'StringCustomer_Requests'.tr
                      : 'StringSimplifiedTaxInvoicee'.tr
                      : item.BMKID == 4 || item.BMKID == 12
                      ? 'مردود فاتورة ضريبية مبسطة  '
                      : controller.BMKID == 7
                      ? 'StringQuotations'.tr
                      : controller.BMKID == 10
                      ? 'StringCustomer_Requests'.tr
                      : 'String_Tax_Invoice'.tr
                      : controller.BMKID == 3
                      ? 'StringSalesInvoices'.tr
                      : controller.BMKID == 1
                      ? 'StringPurchases_Invoices'.tr
                      : controller.BMKID == 4
                      ? 'StringReturn_Sale'.tr
                      : controller.BMKID == 7
                      ? 'StringQuotations'.tr
                      : controller.BMKID == 10
                      ? 'StringCustomer_Requests'.tr
                      : 'StringPOSInvoice'.tr,
                  ttf,
                  fontSize: FontSize,
                ),
              ),
            ]),
          ],
        ),
      ]);
    }

    pw.TableRow buildRow_SUM( value, String label) {
      return TableRow(
        children: [
          Container(
            alignment: Alignment.center,
            padding: const EdgeInsets.only(top: 2),
            child:Scsy_b? pw.Row(
              mainAxisAlignment: pw.MainAxisAlignment.center, // توسيط المحتوى
              children: [
                SimplePdf.text(
                  "\$",
                  Sau,
                  fontSize: FontSize+6,
                ),

                // pw.Image(
                //   imageData,
                //   width:Type_Rep=='58'?8: 11, // عرض الصورة
                //   height: Type_Rep=='58'?8: 11, // ارتفاع الصورة
                // ),
                pw.SizedBox(width: 3), // مسافة صغيرة بين النص والصورة
                // ✅ النص
                SimplePdf.text(
                  controller.formatter.format(value).toString(),
                  ttf,
                  fontSize: FontSize,
                ),
              ],
            ): SimplePdf.text(
              controller.formatter.format(value).toString(),
              ttf,
              fontSize: FontSize,
            ),
          ),
          Container(
            alignment: Alignment.centerRight,
            padding: const EdgeInsets.only(top: 2),
            child: SimplePdf.text(label.tr, ttf, fontSize: FontSize),
          ),
        ],
      );
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

    Table buildTable_SUM() {
      if(isTaxCondition) {
       return Table(
          columnWidths: {
            0: const pw.FlexColumnWidth(3),
            1: const pw.FlexColumnWidth(8),
          },
          children: [
            buildRow_SUM(bmmam - bmmtx, 'StringAM_NO_TAX'),
            if (isTax2Available)
              buildRow_SUM(bmmtx2, 'StringTotal_Excise_TAX'),
            if (isDiscountAvailable)
              buildRow_SUM(bmmdi + bmmdia, 'String_Discount'),
            if (isBmmdifAvailable)
              buildRow_SUM(bmmdif, 'StringBMMDIF_T'),
            if (isTotalAmountWithoutTaxChanged)
              buildRow_SUM(totalAmountWithoutTax, 'StringTOT_AM_NO_TAX'),
            buildRow_SUM(item.BMMTX1, 'StringTAX_TOT'),
            buildRow_SUM(item.BMMMT, 'StringTotal_Including_Tax'),
          ],
        );
      }
      else{
       return Table(
            columnWidths: {
              0: const pw.FlexColumnWidth(3),
              1: const pw.FlexColumnWidth(8),
            },
            children: [
              buildRow_SUM(bmmam, 'StrinCount_BMDAMC'),
              if (isBmmdifAvailable)
                buildRow_SUM(bmmdif, 'StringBMMDIF_T'),
              if (isDiscountAvailable)
                buildRow_SUM(bmmdi + bmmdia,'String_Discount'),
                buildRow_SUM(bmmmt, 'StrinBCMAM'),
            ],
        );
            }
    }

    pw.Widget buildContent_label(String label,Font_S) {
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

    pw.Widget buildContent_Data(String value, double fontSize) {
      return pw.Container(
        alignment: pw.Alignment.center,
        padding: const pw.EdgeInsets.only(top: 2, bottom: 2, right: 1, left: 1),
        child: SimplePdf.text(value, ttf, fontSize: fontSize),
      );
    }

    pw.Widget buildFooter() {

      // بناء الجداول الصغيرة مع النصوص
      pw.Widget buildPaymentDetails() {
        if (item.PKID == 3 &&
            item.BMMCP.toString() != 'null' &&
            item.BMMCP! > 0) {
          return Table(
            border: TableBorder.all(),
            children: [
              pw.TableRow(
                children: [
                  pw.Container(
                    padding: const pw.EdgeInsets.only(right: 2, left: 1),
                    child: pw.Column(
                      children: [
                        pw.Row(
                          mainAxisAlignment: pw.MainAxisAlignment.spaceAround,
                          children: [
                            SimplePdf.text('اجل', ttf, fontSize: FontSize),
                            SimplePdf.text('نقدا', ttf, fontSize: FontSize),
                          ],
                        ),
                        pw.Divider(height: 0.3),
                        pw.Row(
                          mainAxisAlignment: pw.MainAxisAlignment.spaceAround,
                          children: [
                            SimplePdf.text(
                              '${controller.formatter.format(item.BMMMT! - item.BMMCP!).toString()}',
                              ttf,
                              fontSize: FontSize,
                            ),
                            SimplePdf.text(
                              '${controller.formatter.format(item.BMMCP).toString()}',
                              ttf,
                              fontSize: FontSize,
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ],
          );
        }
        return pw.Container();
      }


      //عدد الاصناف
      pw.Widget buildSUM_Item() {
        return  Row(
          mainAxisAlignment: pw.MainAxisAlignment.end,
          children: <pw.Widget>[
            SimplePdf.text(
                "${controller.CountRecodeController.text}", ttf,
                fontSize: FontSize),
            SimplePdf.spaceW(width: 4),
            SimplePdf.text("${'StrinCount_MINO2'.tr}", ttf,
                fontSize: FontSize),
            SimplePdf.spaceW(width: 45),
            SimplePdf.text(
                "${controller.formatter.format(double.parse(controller.COUNTBMDNOController.text))}",
                ttf,
                fontSize: FontSize),
            SimplePdf.spaceW(width: 4),
            SimplePdf.text("${'StringSUMSNNORep2'.tr}", ttf,
                fontSize: FontSize),
            SimplePdf.spaceW(width: 35),
          ],
        );
      }

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

      // بناء الباركود
      pw.Widget buildQRCode() {
        if ( controller.SVVL_TAX != '2' &&
            [1, 10].contains(controller.BIF_MOV_M_PRINT.elementAt(0).BMMFST)) {
          return pw.Container(
            alignment: pw.Alignment.center,
            child: pw.Container(
              width: 70,
              height: 70,
              child: pw.BarcodeWidget(
                color: PdfColor.fromHex("#000000"),
                barcode: pw.Barcode.qrCode(),
                data: qrData,
              ),
            ),
          );
        }
        return pw.Container();
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
            if (controller.SUMO.toString() != 'null' && controller.SUMO.toString().isNotEmpty)
              pw.Row(
                mainAxisAlignment: pw.MainAxisAlignment.start,
                children: [
                  SimplePdf.text(
                      'StringPhone'.tr + ': ' + '${controller.SUMO}', ttf,
                      fontSize: FontSize),
                ],
              ),
          ],
        );
      }

      return pw.Column(
        children: [
          buildPaymentDetails(),
          SimplePdf.buildBalanceSection(item,controller,ttf,Type_Rep=='58'?5.0:7.0),
          pw.Divider(height: 0.5),
          buildSUM_Item(),
          buildMainText(),
          buildQRCode(),
          buildFooterInfo(),
          buildSignature(),

        ],
      );
    }


    pdf.addPage(
      pw.Page(
        pageFormat:Type_Rep=='58'?PdfPageFormat.roll57 :PdfPageFormat.roll80,
        margin: EdgeInsets.only(
            right: StteingController().RIGHT_MARGIN.toDouble(),
            bottom: StteingController().BOTTOM_MARGIN.toDouble(),
            left: StteingController().LEFT_MARGIN.toDouble(),
            top: StteingController().TOP_MARGIN.toDouble()),
        build: (Context context) {
          return Column(
                  children: [
                    buildHeader(),
                    Table(
                      border: pw.TableBorder.all(),
                      columnWidths: {
                        0: pw.FixedColumnWidth(140), // العمود الأول
                        1: pw.FixedColumnWidth(82), // العمود الثاني
                      },
                      children: [
                      buildRowContect(item.BMMNO.toString(),'StringInvoiceNO'),
                      buildRowContect(item.BMMDO.toString(),'StringInvoiceDate'),
                      buildRowContect('${item.SCNA_D.toString()}-${item.PKNA_D.toString()}'
                       ,'StringSCIDlableText'),
                      ],
                    ),
                    SimplePdf.spaceH(height: 3),
                    //بيانات العميل
                    item.BCID.toString() != 'null' && item.BCID != null
                        ? Table(border: TableBorder.all(), children: [
                            TableRow(
                              decoration: BoxDecoration(color: PdfColor.fromHex("#ABABAB")),
                              children: [
                                pw.Container(
                                  padding: const pw.EdgeInsets.only(
                                      right: 2, left: 1),
                                  child: SimplePdf.text(
                                    'بيانات العميل',
                                    ttf,
                                    fontSize: FontSize,
                                  ),
                                ),
                              ],
                            ),
                          ])
                        : Container(),
                         item.BCID.toString() != 'null'
                        ? Table(border: pw.TableBorder.all(), columnWidths: {
                            0: pw.FixedColumnWidth(140), // العمود الأول
                            1: pw.FixedColumnWidth(82), // العمود الثاني
                          }, children: [
                            buildRowContect(item.BMMNA.toString(),'StringBMMNA'),
                            controller.BCTX.toString() != 'null' && controller.BCTX.isNotEmpty
                            ?buildRowContect(controller.BCTX.toString() == 'null'? '': controller.BCTX.toString()
                            ,'StringTaxnumber'):TableRow(children: []),
                             controller.BCAD.toString() != 'null' && controller.BCAD.isNotEmpty
                            ?buildRowContect(controller.BCAD.toString() == 'null'? '': controller.BCAD.toString()
                            ,'StringAddress'):TableRow(children: []),
                            controller.BCTL.toString() != 'null' && controller.BCTL.isNotEmpty
                            ?buildRowContect(controller.BCTL.toString() == 'null'? '': controller.BCTL.toString()
                             ,'StringPhone'):TableRow(children: []),
                          ])
                        : Container(),
                    SimplePdf.spaceH(height: 3),
                    // data
                    Table(
                        border: TableBorder.all(),
                        columnWidths: StteingController().Show_BMDID == true
                            ? {
                                0: const pw.FlexColumnWidth(1.4),
                                1: (controller.BIF_MOV_M_PRINT.elementAt(0).TTID2.toString()!='null'
                                && controller.BIF_MOV_M_PRINT.elementAt(0).BMMTX2!>0)?
                                FlexColumnWidth(1):FlexColumnWidth(0.0),
                                2: const pw.FlexColumnWidth(1),
                                3: const pw.FlexColumnWidth(1),
                                4: const pw.FlexColumnWidth(2.2),
                                5: const pw.FlexColumnWidth(0.4),
                              }
                            : {
                                0: const pw.FlexColumnWidth(1.4),
                                1: (controller.BIF_MOV_M_PRINT.elementAt(0).TTID2.toString()!='null'
                                 && controller.BIF_MOV_M_PRINT.elementAt(0).BMMTX2!>0)?
                                 FlexColumnWidth(1):FlexColumnWidth(0.0),
                                2: const pw.FlexColumnWidth(1),
                                3: const pw.FlexColumnWidth(1),
                                4: const pw.FlexColumnWidth(2.2),
                              },
                        children: [
                          TableRow(
                            decoration: BoxDecoration(
                                color: PdfColor.fromHex("#ABABAB")),
                            children: [
                            buildContent_label('StrinCount_BMDAMC',8.5),
                            buildContent_label('StringBMDTXA2',8.5),
                            buildContent_label('StringPrice',8.5),
                            buildContent_label('StrinlChice_item_QUANTITY',8.5),
                            buildContent_label('StringMINO',8.5),
                            StteingController().Show_BMDID == true
                             ?buildContent_label('#',6)
                                  : pw.Container(),
                            ],
                          ),
                          ///data Rows
                          // Now the next table row
                        ]),
                    Table(
                        border: pw.TableBorder.all(),
                        columnWidths: StteingController().Show_BMDID == true
                            ? {
                                0: const pw.FlexColumnWidth(1.4),
                          1: (controller.BIF_MOV_M_PRINT.elementAt(0).TTID2.toString()!='null'
                              && controller.BIF_MOV_M_PRINT.elementAt(0).BMMTX2!>0)?
                          FlexColumnWidth(1):FlexColumnWidth(0.0),
                                2: const pw.FlexColumnWidth(1),
                                3: const pw.FlexColumnWidth(1),
                                4: const pw.FlexColumnWidth(2.2),
                                5: const pw.FlexColumnWidth(0.4),
                              }
                            : {
                                0: const pw.FlexColumnWidth(1.4),
                          1: (controller.BIF_MOV_M_PRINT.elementAt(0).TTID2.toString()!='null'
                              && controller.BIF_MOV_M_PRINT.elementAt(0).BMMTX2!>0)?
                          FlexColumnWidth(1):FlexColumnWidth(0.0),
                                2: const pw.FlexColumnWidth(1),
                                3: const pw.FlexColumnWidth(1),
                                4: const pw.FlexColumnWidth(2.2),
                              },
                        children: List.generate(controller.InvoiceList.length, (index) {
                          Bil_Mov_D_Local product = controller.InvoiceList[index];
                          return pw.TableRow(
                            children: [
                              isTaxCondition?
                                buildContent_Data(controller.formatter.format(controller.roundDouble(((product.BMDAM! - product.BMDDI!) *
                              product.BMDNO!) +(product.BMDTXT1!+product.BMDTXT2!),controller.SCSFL)),8.5):
                              buildContent_Data(controller.formatter.format(controller.roundDouble(((product.BMDAM!) *
                              product.BMDNO!),controller.SCSFL)),8.5),
                              buildContent_Data(controller.formatter.format(product.BMDTXT2).toString(),8.5),
                              buildContent_Data(controller.formatter.format(LoginController().CIID=='971'? product.BMDAMO:product.BMDAM),8.5),
                              buildContent_Data("${controller.formatter.format((product.BMDNO! + product.BMDNF!))} ${product.MUNA_D}",8.5),
                              buildContent_Data(StteingController().Show_MINO == true?
                              product.NAM_D.toString() : product.MINA_D.toString(),8.5),
                              if(StteingController().Show_BMDID == true)
                              buildContent_Data(product.BMDID.toString(),6.0),
                            ],
                          );
                        })),
                           SimplePdf.spaceH(height: 5),
                            buildTable_SUM(),
                     Table(children: [
                      TableRow(
                        children: [
                          pw.Container(
                            padding: const EdgeInsets.only(right: 1, left: 1),
                           // decoration: const BoxDecoration(color: PdfColors.grey200),
                            child: SimplePdf.text(
                              "${Tafqeet2.convert(item.BMMMT.toString(),currency: item.SCSY.toString())} ${item.SCNA_D.toString()}",
                              ttf, fontSize: FontSize, color: PdfColors.black,
                            ),
                          ),
                        ],
                      ),
                    ]),
                            buildFooter(),
                    Container(height: 15),
                    SimplePdf.spaceH(height: 15),
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
        fileName: 'Invoice - ${item.BMMNO}.pdf',
        BMMID: item.BMMID!);
  } catch (e, stackTrace) {
    print(e);
    print(stackTrace);
    Fluttertoast.showToast(
        msg: e.toString(),
        toastLength: Toast.LENGTH_LONG,
        textColor: ma.Colors.white,
        backgroundColor: ma.Colors.redAccent);
    print(e.toString());
  }
}
