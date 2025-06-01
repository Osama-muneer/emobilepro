import 'dart:io';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:flutter/material.dart' as ma;
import '../../Operation/Controllers/inventory_controller.dart';
import '../../Operation/models/inventory.dart';
import '../../PrintFile/share_mode.dart';
import '../../PrintFile/simple_pdf.dart';
import '../../Setting/controllers/login_controller.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart' as intl;
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:pdf/widgets.dart';
import '../file_helper.dart';

Pdf_Inventory_Samplie({
  int? GetSMKID,
  String? P_PR_REP,
  required ShareMode mode,
  // required UserTaxInfo userTaxInfo,
  // required InvoiceSetting invoiceSetting,
}) async {
  try {

    final InventoryController controller = Get.find();
    final pdf = pw.Document();
    final Uint8List fontData = await FileHelper.getFileFromAssets('Assets/fonts/HacenTunisia.ttf');
    final font = pw.Font.ttf(fontData.buffer.asByteData());

    final image = await SimplePdf.loadImage();


    pdf.addPage(
      MultiPage(
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
                  Text(controller.SONE,style: TextStyle(fontWeight: FontWeight.bold, color: PdfColors.black, fontSize: 13)),
                  Text(controller.SOLN,style: TextStyle(fontWeight: FontWeight.bold, color: PdfColors.black, fontSize: 11)),
                ]),),
            Expanded(child:Column(children: [
              Container(
                  width: 50,
                  child: Image(image)
              ),
              Container( margin: const EdgeInsets.symmetric(vertical: 2),
                  decoration: BoxDecoration(
                    color: PdfColor.fromHex("#ABABAB"),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Text(controller.SMKID==3?'StringItem_Out_Voucher'.tr:controller.SMKID==1?'StringItem_In_Voucher'.tr
                      :controller.SMKID==11?'StringTransfer_Store_Request'.tr:controller.SMKID==131?'StringTransfer_Store_Branches'.tr:
                  controller.STO_MOV_M_PRINT.elementAt(0).BKID==-1 && controller.STO_MOV_M_PRINT.elementAt(0).SMKID==1?'StringIncoming_Store'.tr:
                  'StringInventoryTransferVoucher'.tr,
                      style: TextStyle(color: PdfColors.black, fontSize: 13))),
            ])),
            Expanded(
              child: Column(
                  children: [
                    Text(controller.SONA,style: TextStyle(color: PdfColors.black, fontSize: 11)),
                    Text(controller.SORN,style: TextStyle(color: PdfColors.black, fontSize: 11)),
                    SimplePdf.text(
                      ' ${'StringAddress'.tr}  ${controller.SOAD.toString()} :',
                      font,
                      fontSize: 11,
                      color: PdfColors.black,
                    ),
                  ]),)
          ],
        ),
        build: (Context context)=> [
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
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: [
                                          SimplePdf.text(
                                            ' ${'StringSMDED2'.tr}  ${controller.STO_MOV_M_PRINT.elementAt(0).SMMDO.toString()} :',
                                            font,
                                            fontSize: 13,
                                            color: PdfColors.black,
                                          ),
                                          SimplePdf.text(
                                            controller.STO_MOV_M_PRINT.elementAt(0).SMMST.toString()=='2' ? 'StringNotfinal'.tr
                                                : '${controller.STO_MOV_M_PRINT.elementAt(0).SMMST}'.toString() == '3' ? 'StringPending'.tr : 'Stringfinal'.tr,
                                            font,
                                            fontSize: 13,
                                            color: PdfColors.black,
                                          ),
                                          SimplePdf.text(
                                            '${'StringBIID'.tr} : ${controller.STO_MOV_M_PRINT.elementAt(0).BINA_D}',
                                            font,
                                            fontSize: 13,
                                            color: PdfColors.black,
                                          ),
                                        ]),
                                    Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: [
                                          SimplePdf.text(
                                            '${controller.STO_MOV_M_PRINT.elementAt(0).SMMRE.toString()=='null' || controller.STO_MOV_M_PRINT.elementAt(0).SMMRE.toString().isEmpty
                                                ?'الرقم اليدوي:--------': " الرقم اليدوي: ${controller.STO_MOV_M_PRINT.elementAt(0).SMMRE}"}',
                                            font,
                                            fontSize: 13,
                                            color: PdfColors.black,
                                          ),
                                          SimplePdf.text(
                                            '${'StringSMMID'.tr}  ${controller.STO_MOV_M_PRINT.elementAt(0).SMMNO.toString()} :',
                                            // '${GetBMMNO!}',
                                            font,
                                            fontSize: 13,
                                            color: PdfColors.black,
                                          ),
                                        ]),
                                    controller.SMKID==13 || controller.SMKID==11 || controller.SMKID==131?
                                    Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: [
                                          SimplePdf.text(
                                            '${'StringT_SIID'.tr} : ${controller.STO_MOV_M_PRINT.elementAt(0).SIIDT_D.toString()}',
                                            font, fontSize: 13, color: PdfColors.black,
                                          ),
                                          SimplePdf.text(
                                            '${'StringF_SIID'.tr} : ${controller.STO_MOV_M_PRINT.elementAt(0).SINA_D.toString()}',
                                            font, fontSize: 13, color: PdfColors.black,
                                          ),
                                        ]):
                                    Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: [
                                          SimplePdf.text(
                                            '${'StringSIIDlableText'.tr} : ${controller.STO_MOV_M_PRINT.elementAt(0).SINA_D.toString()}',
                                            font, fontSize: 13, color: PdfColors.black,
                                          ),
                                          SimplePdf.text(
                                            '${'StringSCIDlableText'.tr} : ${controller.STO_MOV_M_PRINT.elementAt(0).SCNA_D.toString()}',
                                            font, fontSize: 13, color: PdfColors.black,
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
                          Table(border: TableBorder.all(), children: [
                            TableRow(
                              children: [
                                Container(
                                  width: 476,
                                  padding: const pw.EdgeInsets.only(right: 8, left: 8),
                                  child: Column(children: [
                                    controller.SMKID!=11?  Row(
                                        mainAxisAlignment: MainAxisAlignment.end,
                                        children: [
                                          SimplePdf.text(
                                            '${'StringAccount'.tr} : ${controller.STO_MOV_M_PRINT.elementAt(0).SMMNN}',
                                            font,
                                            fontSize: 13,
                                            color: PdfColors.black,
                                          ),
                                        ]):Container(),
                                    Row(
                                        mainAxisAlignment: MainAxisAlignment.end,
                                        children: [
                                          SimplePdf.text(
                                            '${'StringDetails'.tr} : ${controller.STO_MOV_M_PRINT.elementAt(0).SMMIN}',
                                            font,
                                            fontSize: 13,
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
          ]),

          P_PR_REP=='1'? Table(border: TableBorder.all(),
              columnWidths: {
                0:  FlexColumnWidth(GetSMKID!=11?1.7:0),
                1:  FlexColumnWidth(GetSMKID!=11?1:0),
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
                    Container(
                      decoration: const BoxDecoration(),
                      padding: const EdgeInsets.all(1),
                      child: SimplePdf.text(
                        'StrinCount_BMDAMC'.tr,
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
              ]):

          Table(border: TableBorder.all(),
              columnWidths: {
                0:  FlexColumnWidth(0.7),
                1:  FlexColumnWidth(0.7),
                2: const FlexColumnWidth(1.7),
                3: const FlexColumnWidth(0.6),
                4: const FlexColumnWidth(1.7),
                5: const FlexColumnWidth(0.4),
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
                        'StringMgno'.tr,
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
          P_PR_REP=='1'?Table(
              border: pw.TableBorder.all(),
              columnWidths: {
                0:  FlexColumnWidth(GetSMKID!=11?1.7:0),
                1:  FlexColumnWidth(GetSMKID!=11?1:0),
                2: const FlexColumnWidth(0.7),
                3: const FlexColumnWidth(0.7),
                4: const FlexColumnWidth(2),
                5: const FlexColumnWidth(0.8),
                6: const FlexColumnWidth(0.4),
              },
              children: List.generate(controller.STO_MOV_D_PRINT.length, (index) {
                Sto_Mov_D_Local product = controller.STO_MOV_D_PRINT[index];
                return pw.TableRow(
                  children: [
                    pw.Container(
                      alignment: pw.Alignment.center,
                      padding: const pw.EdgeInsets.only(top: 2,bottom: 2,right: 1,left: 1),
                      child: SimplePdf.text(
                          P_PR_REP=='1'?
                          controller.formatter.format(((product.SMDAM!-product.SMDDI!)*product.SMDNO!)).toString():'',
                          font,
                          fontSize: 9),
                    ),
                    pw.Container(
                      alignment: pw.Alignment.center,
                      padding:  const pw.EdgeInsets.only(top: 2,bottom: 2,right: 1,left: 1),
                      child: SimplePdf.text(
                        P_PR_REP=='1'?
                        controller.formatter.format(product.SMDAM).toString():'' , font,
                        fontSize: 9,color: PdfColors.black,
                      ),
                    ),
                    pw.Container(
                      alignment: pw.Alignment.center,
                      padding:  const pw.EdgeInsets.only(top: 2,bottom: 2,right: 1,left: 1),
                      child: SimplePdf.text(
                        product.MUNA_D.toString() , font,
                        fontSize: 9,color: PdfColors.black,
                      ),
                    ),
                    pw.Container(
                      alignment: pw.Alignment.center,
                      padding:  const pw.EdgeInsets.only(top: 2,bottom: 2,right: 1,left: 1),
                      child: SimplePdf.text(
                        controller.formatter.format(product.SMDNO!+product.SMDNF!).toString() , font,
                        fontSize: 9,color: PdfColors.black,
                      ),
                    ),
                    pw.Container(
                      alignment: pw.Alignment.center,
                      padding:  const pw.EdgeInsets.only(top: 2,bottom: 2,right: 1,left: 1),
                      child: SimplePdf.text(
                        product.MINA_D.toString() , font,
                        fontSize: 9,color: PdfColors.black,
                      ),
                    ),
                    pw.Container(
                      alignment: pw.Alignment.center,
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
                        product.SMDID.toString() , font,
                        fontSize: 9,color: PdfColors.black,
                      ),
                    ),
                  ],
                );
              })):
          Table(
              border: pw.TableBorder.all(),
              columnWidths: {
                0:  FlexColumnWidth(0.7),
                1:  FlexColumnWidth(0.7),
                2: const FlexColumnWidth(1.7),
                3: const FlexColumnWidth(0.6),
                4: const FlexColumnWidth(1.7),
                5: const FlexColumnWidth(0.4),
              },
              children: List.generate(controller.STO_MOV_D_PRINT.length, (index) {
                Sto_Mov_D_Local product = controller.STO_MOV_D_PRINT[index];
                return pw.TableRow(
                  children: [
                    Container(
                      alignment: pw.Alignment.center,
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
                        controller.formatter.format(product.SMDNO!+product.SMDNF!).toString() , font,
                        fontSize: 9,color: PdfColors.black,
                      ),
                    ),
                    Container(
                      alignment: pw.Alignment.center,
                      padding:  const pw.EdgeInsets.only(top: 2,bottom: 2,right: 1,left: 1),
                      child: SimplePdf.text(
                        product.MINA_D.toString() , font,
                        fontSize: 9,color: PdfColors.black,
                      ),
                    ),
                    Container(
                      alignment: pw.Alignment.center,
                      padding:  const pw.EdgeInsets.only(top: 2,bottom: 2,right: 1,left: 1),
                      child: SimplePdf.text(
                        product.MINO.toString() , font,
                        fontSize: 9,color: PdfColors.black,
                      ),
                    ),
                    Container(
                      alignment: pw.Alignment.center,
                      padding:  const pw.EdgeInsets.only(top: 2,bottom: 2,right: 1,left: 1),
                      child: SimplePdf.text(
                        product.MGNA.toString() , font,
                        fontSize: 9,color: PdfColors.black,
                      ),
                    ),
                    Container(
                      alignment: pw.Alignment.center,
                      padding:  const pw.EdgeInsets.only(top: 2,bottom: 2,right: 1,left: 1),
                      child: SimplePdf.text(
                        product.SMDID.toString() , font,
                        fontSize: 9,color: PdfColors.black,
                      ),
                    ),
                  ],
                );
              })),
          SizedBox(height: 3),
          controller.SMKID!=11 &&   P_PR_REP=='1' ? Table(border: TableBorder.all(), children: [
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
                              Table(border: TableBorder.all(), children: [
                                TableRow(
                                  children: [
                                    Container(
                                      width: 200,
                                      decoration: const BoxDecoration(),
                                      padding: const EdgeInsets.all(1),
                                      child: SimplePdf.text(
                                        controller.formatter.format((controller.STO_MOV_M_PRINT.elementAt(0).SMMAM!)).toString(),
                                        font,
                                        align: TextAlign.center,
                                        fontSize: 12,
                                        color: PdfColors.black,
                                      ),
                                    ),
                                  ],
                                ),
                                controller.STO_MOV_M_PRINT.elementAt(0).SMMDIF!>0?TableRow(
                                  children: [
                                    Container(
                                      width: 200,
                                      decoration: const BoxDecoration(),
                                      padding: const EdgeInsets.all(1),
                                      child: SimplePdf.text(
                                        controller.formatter.format(controller.STO_MOV_M_PRINT.elementAt(0).SMMDIF).toString(),
                                        font,
                                        align: TextAlign.center,
                                        fontSize: 11,
                                        color: PdfColors.black,
                                      ),
                                    ),
                                  ],
                                ):TableRow(children: []),
                                TableRow(
                                  children: [
                                    Container(
                                      width: 200,
                                      decoration: const BoxDecoration( color: PdfColors.grey200,),
                                      padding: const EdgeInsets.all(1),
                                      child: SimplePdf.text(
                                        controller.formatter.format(controller.STO_MOV_M_PRINT.elementAt(0).SMMAM).toString(),
                                        font,
                                        align: TextAlign.center,
                                        fontSize: 12,
                                        color: PdfColors.black,
                                      ),
                                    ),
                                  ],
                                ),
                              ]),
                              Table(border: TableBorder.all(), children: [
                                TableRow(
                                  children: [
                                    Container(
                                      width: 273,
                                      decoration: const BoxDecoration(),
                                      padding: const EdgeInsets.all(1),
                                      child: SimplePdf.text(
                                        'StrinCount_BMDAMC'.tr,
                                        font,
                                        align: TextAlign.center,
                                        fontSize: 12,
                                        color: PdfColors.black,
                                      ),
                                    ),
                                  ],
                                ),
                                controller.STO_MOV_M_PRINT.elementAt(0).SMMDIF!>0?TableRow(
                                  children: [
                                    Container(
                                      width: 273,
                                      decoration: const BoxDecoration(),
                                      padding: const EdgeInsets.all(1),
                                      child: SimplePdf.text(
                                        'StringBMMDIF'.tr,
                                        font,
                                        align: TextAlign.center,
                                        fontSize: 12,
                                        color: PdfColors.black,
                                      ),
                                    ),
                                  ],
                                ):TableRow(children: []),
                                TableRow(
                                  children: [
                                    Container(
                                      width: 273,
                                      decoration: const BoxDecoration( color: PdfColors.grey200,),
                                      padding: const EdgeInsets.all(1),
                                      child: SimplePdf.text(
                                        'StringSUM_ALL_BMMAM'.tr,
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
                        ),
                      ]),
                    ),
                    SizedBox(height: 3),
                  ]),
                ),
              ],
            ),
          ]):Container(),

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
                        child: SimplePdf.text(controller.SDDDA.toString()=='null'?'':controller.SDDDA.toString(),
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
                  '${'StrinUser'.tr}  ${LoginController().SUNA}',
                  font,
                  fontSize: 9,
                  color: PdfColors.black,
                ),
                Text('Page ${context.pageNumber}  of ${context.pagesCount}',
                    style: const TextStyle(fontSize: 9)),
                SimplePdf.text(
                  '${'StringDateofPrinting'.tr}  ${intl.DateFormat('dd-MM-yyyy HH:mm').format(DateTime.now())} :',
                  font,
                  fontSize: 9,
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
        fileName: '${controller.SMKID==3?'StringItem_Out_Voucher'.tr:controller.SMKID==1?'StringItem_In_Voucher'.tr
            :controller.SMKID==11?'StringTransfer_Store_Request'.tr:controller.SMKID==131?'StringTransfer_Store_Branches'.tr:
        'StringInventoryTransferVoucher'.tr}-${controller.STO_MOV_M_PRINT.elementAt(0).SMMNO}.pdf',
        BMMID: controller.STO_MOV_M_PRINT.elementAt(0).SMMID!);
  } catch (e) {
    Fluttertoast.showToast(
        msg:e.toString(),
        toastLength: Toast.LENGTH_LONG,
        textColor: ma.Colors.white,
        backgroundColor: ma.Colors.redAccent);
    print(e.toString());
  }
}

