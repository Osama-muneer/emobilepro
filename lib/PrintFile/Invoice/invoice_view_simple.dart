import 'package:number_to_word_arabic/number_to_word_arabic.dart';
import '../../Operation/Controllers/sale_invoices_controller.dart';
import '../../Operation/models/bil_mov_d.dart';
import '../../PrintFile/share_mode.dart';
import '../../PrintFile/simple_pdf.dart';
import '../../Setting/controllers/setting_controller.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart' as intl;
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:pdf/widgets.dart';
import '../invoice_controller.dart';
import '../file_helper.dart';
import 'package:flutter/material.dart' as ma;
import 'package:fluttertoast/fluttertoast.dart';

Pdf_Invoices_Samplie({
  String? GetBMKID,
  String? GetBMMDO,
  String? GetBMMNO,
  String? GetPKNA,
  required ShareMode mode,
}) async {
  try {
    final Sale_Invoices_Controller controller = Get.find();
    var item = controller.BIF_MOV_M_PRINT.elementAt(0);
    print(item.BMMFQR.toString());
    String qrData = item.BMMFQR.toString().isEmpty || item.BMMFQR.toString() == 'null'
        ? await InvoiceController.zatcaQrData(
            nameSaller: controller.SONA.toString(),
            invoiceTotalAmount:
                item.BMMMT.toString(),
            invoiceTaxAmount:
                item.BMMTX1.toString(),
            taxNumber: controller.SOTX.toString(),
          )
        : item.BMMFQR.toString();

    final pdf = pw.Document();
    final Uint8List fontData = await FileHelper.getFileFromAssets('Assets/fonts/HacenTunisia.ttf');
    final Uint8List fontSa = await FileHelper.getFileFromAssets('Assets/fonts/NewRiyal-Regular.ttf');

    final font = pw.Font.ttf(fontData.buffer.asByteData());
    final Sau = pw.Font.ttf(fontSa.buffer.asByteData());

    final image = await SimplePdf.loadImage();
//    final pw.MemoryImage imageData = await SimplePdf.getSaudiRiyalImage();


    String totalAmount= controller.formatter.format([4, 11, 12].contains(item.BMKID)
        ? item.BMMMT! - controller.BACBA! : item.BMMMT! + controller.BACBA!).toString();
    bool Scsy_b = item.SCSY=='SAR';

    // دالة مساعدة لبناء الصفوف
    Widget buildRow(String leftText, String rightText) {
      return Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          SimplePdf.text(leftText, font, fontSize: 13, color: PdfColors.black),
          SimplePdf.text(rightText, font, fontSize: 13, color: PdfColors.black),
        ],
      );
    }

    // دالة مساعدة لبناء الصف
    Widget buildRow2(String text, double fontSize) {
      return Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          SimplePdf.text(
            text,
            font,
            fontSize: fontSize,
            color: PdfColors.black,
          ),
        ],
      );
    }

    // دالة مساعدة لبناء الصف الشرطي
    Widget buildConditionalRow() {
      if ((item.BMKID == 7 || item.BMKID == 10)) {
        return item.BMMGR.toString().isNotEmpty?
        buildRow2(' ${'StringBMMGR2'.tr} ${item.BMMGR}', 13):Container();
      } else {
        return Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Expanded(
              child: SimplePdf.text(
                '${'StringBMMIN'.tr}${item.BMMIN}',
                font,
                fontSize: 13,
                color: PdfColors.black,
              ),
            ),
          ],
        );
      }
    }

    // دالة مساعدة لبناء الصف الشرطي
    Widget buildAdditionalInfoRow() {
      // if (item.BMKID == 7 || item.BMKID == 10) {
      //   return buildRow2('${'StringBMMGR2'.tr}${item.BMMGR}', 13);
      // } else
        if (item.BMKID == 7) {
        return buildRow2(controller.Statement_Quotation, 9);
      } else if (item.BMKID == 10) {
        return  Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Expanded(
              child: SimplePdf.text(
                '${'StringBMMIN'.tr}${item.BMMIN}',
                font,
                fontSize: 13,
                color: PdfColors.black,
              ),
            ),
          ],
        );
      } else {
        return Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            buildRow2('Tel:${controller.SOTL.toString()},', 13),
            buildRow2('${'StringBAID'.tr}${controller.SOSN.toString()}', 13),
          ],
        );
      }
    }


    // دالة مساعدة لبناء خلية الجدول
    Widget _buildCell(String content) {
      return Container(
        alignment: pw.Alignment.center,
        padding: const pw.EdgeInsets.symmetric(vertical: 2, horizontal: 1),
        child: SimplePdf.text(content,
          font,
          fontSize: 9.5,
          color: PdfColors.black,
        ),
      );
    }

    Widget _buildlabel(String content) {
      return Container(
        decoration: const BoxDecoration(),
        padding: const EdgeInsets.all(1),
        child: SimplePdf.text(
          content,
          font,
          fontSize: 9,
          color: PdfColors.black,
        ),
      );
    }

    TableRow  _buildTableRow(String content,{type=1,bool isGrey = false, double? height}) {
      return TableRow(
        children: [
          type==1?
          Container(
            height: height,
            decoration: isGrey ? const BoxDecoration(color: PdfColors.grey200) : const BoxDecoration(),
            padding: const EdgeInsets.all(1),
            child: SimplePdf.text(
              content,
              font,
              align: TextAlign.center,
              fontSize: 12,
              color: PdfColors.black,
            ),
          )
              : Container(
            height: height,
            decoration: isGrey ? const BoxDecoration(color: PdfColors.grey200) : const BoxDecoration(),
            padding: const EdgeInsets.all(1),
            child: Scsy_b? pw.Row(
              mainAxisAlignment: pw.MainAxisAlignment.center, // توسيط المحتوى
              children: [
                SimplePdf.text(
                  "\$",
                  Sau,
                  fontSize: 18,
                ),
                pw.SizedBox(width: 5), // مسافة صغيرة بين النص والصورة
                // ✅ النص
                SimplePdf.text(
                  content,
                  font,
                  align: TextAlign.center,
                  fontSize: 12,
                  color: PdfColors.black,
                ),
              ],
            ): SimplePdf.text(
              content,
              font,
              align: TextAlign.center,
              fontSize: 12,
              color: PdfColors.black,
            ),
          ),
        ],
      );
    }

    /// تحويل الأرقام إلى كلمات عربية
    String convertNumberToArabicWords(double number) {
      final formatter = intl.NumberFormat("#,##0", "ar");
      print('formatter');
      print(formatter);
      return formatter.format(number);
    }


    pdf.addPage(
      MultiPage(
        pageFormat: PdfPageFormat.a4,
        textDirection: TextDirection.rtl,
        crossAxisAlignment: CrossAxisAlignment.center,
        margin: EdgeInsets.all(15),
        theme: ThemeData.withFont(base: Font.ttf(await rootBundle.load("Assets/fonts/HacenTunisia.ttf"))),
        header: (context) => StteingController().REPEAT_REP_HEADER==true?
        SimplePdf.buildHeader(2,font,GetPKNA,controller,image):Container(),
        build: (Context context) => [
        if(  StteingController().REPEAT_REP_HEADER==false)
         SimplePdf.buildHeader(1,font,GetPKNA,controller,image),
          Table(border: TableBorder.all(),
              children: [
            TableRow(
              children: [
                Column(children: [
                  Padding(padding: const EdgeInsets.only(right: 2, left: 2, top: 3),
                      child: Row(children: [
                        Table(border: TableBorder.all(),
                            columnWidths: {
                            0: FixedColumnWidth(561),// العمود الأول
                            },
                            children: [
                          TableRow(
                            children: [
                          Padding(padding: const EdgeInsets.only(right: 3, left: 3),
                              child: Column(children: [
                                buildRow(
                                  item.BMMST.toString() == '2'
                                      ? 'StringNotfinal'.tr : '${item.BMMST}'.toString() == '4'
                                      ? 'StringPending'.tr : 'Stringfinal'.tr,
                                  '${'StringBMMDO'.tr} ${GetBMMDO.toString()}',
                                ),
                                buildRow(
                                  '${item.BMMRE.toString() == 'null' ||
                                      item.BMMRE.toString().isEmpty
                                      ? '${'StringBMMRE'.tr}--------'
                                      : " ${'StringBMMRE'.tr} ${item.BMMRE}"}',
                                      '${'StringBMMNO_R'.tr} ${GetBMMNO.toString()}'
                                ),
                                buildRow(
                                 '${'StringSIID2'.tr}${item.SINA_D.toString()}',
                                  '${'StringSCID'.tr}${item.SCNA_D.toString()}',
                                ),
                                controller.BMKID == 11
                                    ? Row(
                                        mainAxisAlignment: MainAxisAlignment.end,
                                        children: [
                                            SimplePdf.text(
                                              '${'StringBPID'.tr}${item.BPNA_D.toString()}',
                                              font,
                                              fontSize: 13,
                                              color: PdfColors.black,
                                            ),
                                          ])
                                    :
                                buildRow(
                                  item.BMKID.toString() == '10'
                                      ?' ${'StringBMMDD2'.tr} ${item.BMMDD.toString()}'
                                      : item.BMKID.toString() == '7'?
                                  ' ${'StringBMMCD3'.tr} ${item.BMMCD.toString()}':'',
                                  item.PKID.toString() =='1'
                                      ?'${'StringACID'.tr}${item.ACNA_D.toString()}':'',
                                ),
                              ]),)
                            ],
                          )
                        ]),
                      ])),
                  SizedBox(height: 2),
                  Divider(height: 1),
                  Padding(padding:
                  const EdgeInsets.only(right: 2, left: 2, top: 3),
                      child: Row(children: [
                        Table(border: TableBorder.all(),
                            columnWidths: {
                              0: pw.FixedColumnWidth(561), // العمود الأول
                            },
                            children: [
                          TableRow(
                            children: [
                           Padding(padding:const EdgeInsets.only(right: 3, left: 3),
                             child: Column(
                                  children: [
                                    buildRow2('${'StringBMMNA2'.tr} ${item.BMMNA}', 13),
                                    buildConditionalRow(),
                                    buildAdditionalInfoRow()
                              ]),)
                            ],
                          )
                        ]),
                      ])),
                  SizedBox(height: 3),
                ]),
              ],
            ),
          ]),
          Table(border: TableBorder.all(),
          columnWidths: controller.Show_Items_Expire_Date=='2'? {
            0: const FlexColumnWidth(1.7),
            1: const FlexColumnWidth(0.9),
            2: const FlexColumnWidth(0.7),
            3: const FlexColumnWidth(0.9),
            4: const FlexColumnWidth(0.7),
            5: const FlexColumnWidth(2),
            6: const FlexColumnWidth(0.8),
            7: const FlexColumnWidth(0.4),
          }: {
          0: const FlexColumnWidth(1.7),
          1: const FlexColumnWidth(1),
          2: const FlexColumnWidth(0.7),
          3: const FlexColumnWidth(0.7),
          4: const FlexColumnWidth(2),
          5: const FlexColumnWidth(0.8),
          6: const FlexColumnWidth(0.4),
          },
              children: [
            TableRow(
              decoration: const BoxDecoration(
                color: PdfColors.MyColors,
              ),
              children: [
                _buildlabel(controller.SVVL_TAX != '2'?'String_Item_Subtotal_IncludingVAT'.tr:'StrinCount_SMDFN'.tr),
                _buildlabel('StringMPCO'.tr),
                _buildlabel('StringSNNO'.tr),
                if (controller.Show_Items_Expire_Date=='2') _buildlabel('StringSMDED'.tr),
                _buildlabel('StringMUID'.tr),
                _buildlabel('StringBMDIN'.tr),
                _buildlabel('StringMINO'.tr),
                _buildlabel('#'),
              ],
            ),
          ]),
          Table(
              border: pw.TableBorder.all(),
              columnWidths: controller.Show_Items_Expire_Date=='2'? {
                0: const FlexColumnWidth(1.7),
                1: const FlexColumnWidth(0.9),
                2: const FlexColumnWidth(0.7),
                3: const FlexColumnWidth(0.9),
                4: const FlexColumnWidth(0.7),
                5: const FlexColumnWidth(2),
                6: const FlexColumnWidth(0.8),
                7: const FlexColumnWidth(0.4),
              }: {
                0: const FlexColumnWidth(1.7),
                1: const FlexColumnWidth(1),
                2: const FlexColumnWidth(0.7),
                3: const FlexColumnWidth(0.7),
                4: const FlexColumnWidth(2),
                5: const FlexColumnWidth(0.8),
                6: const FlexColumnWidth(0.4),
              },
              children: List.generate(controller.InvoiceList.length, (index) {
                Bil_Mov_D_Local product = controller.InvoiceList[index];
                return pw.TableRow(
                  children: [
                    _buildCell(controller.formatter.format(((product.BMDAM! - product.BMDDI!) *
                        product.BMDNO!) + product.BMDTXT1!).toString()),
                    _buildCell(controller.formatter.format(product.BMDAM).toString()),
                    _buildCell(controller.formatter.format(product.BMDNO! + product.BMDNF!).toString()),
                    if (controller.Show_Items_Expire_Date=='2') _buildCell(product.BMDED.toString()),
                    _buildCell(product.MUNA_D.toString()),
                    _buildCell(product.MINA_D.toString()),
                    _buildCell(product.MINO.toString()),
                    _buildCell(product.BMDID.toString()),
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
                  child: controller.SVVL_TAX != '2'
                      ? Column(children: [
                          Padding(padding: const EdgeInsets.only(right: 2, left: 2, top: 3),
                            child: Table(border: TableBorder.all(), children: [
                              TableRow(
                                children: [
                                  Row(children: [
                                    Table(border: TableBorder.all(),
                                        columnWidths: {
                                          0: pw.FixedColumnWidth(160),
                                        },
                                        children: [
                                      _buildTableRow(type: 2,controller.formatter.format((item.BMMAM! - item.BMMTX!)).toString()),
                                      item.TTID2.toString() != 'null' && item.BMMTX2! > 0
                                        ? _buildTableRow(type: 2,controller.formatter.format(item.BMMTX2).toString())
                                          : TableRow(children: []),
                                      item.BMMDI! + item.BMMDIA! > 0
                                     ? _buildTableRow(type: 2,controller.formatter.format(item.BMMDI! + item.BMMDIA!).toString())
                                          : TableRow(children: []),
                                      item.BMMDIF! > 0
                                      ? _buildTableRow(type: 2,controller.formatter.format(item.BMMDIF).toString())
                                          : TableRow(children: []),
                                      (item.BMMAM! - item.BMMTX! - item.BMMDI! - item.BMMDIF! -
                                          item.BMMDIA! - item.BMMTX2!) != (item.BMMAM! - item.BMMTX!)
                                          ? _buildTableRow(type: 2, height: 39,controller.formatter.format((item.BMMAM! -
                                          item.BMMTX! - item.BMMDI! - item.BMMDIF! -
                                          item.BMMDIA! + item.BMMTX2!)).toString(),)
                                          : TableRow(children: []),
                                      _buildTableRow(type: 2,controller.formatter.format(item.BMMTX1).toString()),
                                      _buildTableRow(type: 2,controller.formatter.format(item.BMMMT).toString(),isGrey: true),
                                    ]),
                                    Table(border: TableBorder.all(),
                                        columnWidths: {
                                          0: pw.FixedColumnWidth(220),
                                        },
                                        children: [
                                          _buildTableRow(controller.SVVL_TAX != '2'
                                          ?'الاجمالي )غير شامله ضريبه القيمه المضافة(':'الاجمالي'),
                                      item.TTID2.toString() != 'null' && item.BMMTX2! > 0
                                         ? _buildTableRow('الضريبه الانتقائيه')
                                          : TableRow(children: []),
                                      item.BMMDI! + item.BMMDIA! > 0
                                          ? _buildTableRow('اجمالي الخصم')
                                          : TableRow(children: []),
                                      item.BMMDIF! > 0
                                          ?_buildTableRow('تخفيض للمجاني')
                                          : TableRow(children: []),
                                      (item.BMMAM! - item.BMMTX! - item.BMMDI! - item.BMMDIF! -
                                          item.BMMDIA! - item.BMMTX2!) != (item.BMMAM! - item.BMMTX!)
                                          ?_buildTableRow('الاجمالي الخاضع للضريبه )غير شامل ضريبة القيمه المضافة(')
                                          : TableRow(children: []),
                                          _buildTableRow('مجموع ضريبة القيمة المضافة'),
                                          _buildTableRow('صافي المبلغ',isGrey: true),
                                    ]),
                                    Table(border: TableBorder.all(),
                                        columnWidths: {
                                          0: pw.FixedColumnWidth(190),
                                        },
                                        children: [
                                      _buildTableRow(controller.SVVL_TAX != '2'
                                          ?'Total (Excluding VAT)':'Total'),
                                      item.TTID2.toString() != 'null' && item.BMMTX2! > 0
                                      ?_buildTableRow('Excise Tax')
                                          : TableRow(children: []),
                                          item.BMMDI! + item.BMMDIA! > 0
                                              ?_buildTableRow('Total discount')
                                              : TableRow(children: []),
                                          item.BMMDIF! > 0
                                              ?_buildTableRow('Discount')
                                              : TableRow(children: []),
                                      (item.BMMAM! - item.BMMTX! - item.BMMDI! - item.BMMDIF! -
                                          item.BMMDIA! - item.BMMTX2!) != (item.BMMAM! - item.BMMTX!)
                                          ?_buildTableRow(height: 39,'Total Taxable Amount (Excluding VAT)')
                                          : TableRow(children: []),
                                          _buildTableRow('Total VAT'),
                                          _buildTableRow('Net Amount',isGrey: true),
                                    ]),
                                  ]),
                                ],
                              ),
                            ]),
                          ),
                          SizedBox(height: 3),
                        ])
                      : Column(children: [
                          Padding(
                            padding: const EdgeInsets.only(right: 2, left: 2, top: 3),
                            child: Table(border: TableBorder.all(), children: [
                              TableRow(
                                children: [
                                  Row(children: [
                                    Table(border: TableBorder.all(),
                                        columnWidths: {
                                          0: pw.FixedColumnWidth(160),
                                        },
                                        children: [
                                      (item.BMMAM! - item.BMMTX!) !=item.BMMMT?
                                      _buildTableRow(controller.formatter.format((item.BMMAM! - item.BMMTX!)).toString())
                                      : TableRow(children: []),
                                      item.BMMDI! + item.BMMDIA! > 0
                                          ? _buildTableRow(controller.formatter.format(item.BMMDI! + item.BMMDIA!).toString())
                                          : TableRow(children: []),
                                      item.BMMDIF! > 0
                                          ? _buildTableRow(controller.formatter.format(item.BMMDIF).toString())
                                          : TableRow(children: []),
                                           _buildTableRow(controller.formatter.format(item.BMMMT).toString(),isGrey: true),
                                    ]),
                                    Table(border: TableBorder.all(),
                                        columnWidths: {
                                          0: pw.FixedColumnWidth(220),
                                        },
                                        children: [
                                          (item.BMMAM! - item.BMMTX!) !=item.BMMMT?
                                          _buildTableRow(controller.SVVL_TAX != '2'
                                          ?'الاجمالي )غير شامله ضريبه القيمه المضافة(':'الاجمالي')
                                              : TableRow(children: []),
                                      item.BMMDI! + item.BMMDIA! > 0
                                          ? _buildTableRow('اجمالي الخصم')
                                          : TableRow(children: []),
                                      item.BMMDIF! > 0
                                      ?_buildTableRow('تخفيض للمجاني')
                                          : TableRow(children: []),
                                          _buildTableRow('صافي المبلغ',isGrey: true),
                                    ]),
                                    Table(border: TableBorder.all(),
                                        columnWidths: {
                                          0: pw.FixedColumnWidth(190),
                                        },
                                        children: [
                                          (item.BMMAM! - item.BMMTX!) !=item.BMMMT?
                                          _buildTableRow(controller.SVVL_TAX != '2'
                                              ?'Total (Excluding VAT)':'Total'): TableRow(children: []),
                                      item.BMMDI! + item.BMMDIA! > 0
                                      ?_buildTableRow('Total discount')
                                          : TableRow(children: []),
                                      item.BMMDIF! > 0
                                          ?_buildTableRow('Discount')
                                          : TableRow(children: []),
                                          _buildTableRow('Net Amount',isGrey: true),
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
          controller.SVVL_TAX != '2'
              ? SizedBox(height: 10)
              : SizedBox(height: 1),
          controller.SVVL_TAX != '2'? [1,10].contains(item.BMMFST)?
        Container(
                  alignment: pw.Alignment.center,
                  child: Container(
                    width: 70,
                    height: 70,
                    child: pw.BarcodeWidget(
                      color: PdfColor.fromHex("#000000"),
                      barcode: pw.Barcode.qrCode(),
                      data: qrData,
                    ),
                  ),
                ): Container()
              : Container(),
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
        fileName:'Invoice - ${item.BMMNO}.pdf',
        BMMID: item.BMMID!);
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
