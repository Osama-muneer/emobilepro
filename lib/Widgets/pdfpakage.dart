import 'package:open_filex/open_filex.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pdf/widgets.dart';
import 'dart:io';
import 'package:get/get.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:pdf/pdf.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../PrintFile/simple_pdf.dart';
import '../Setting/controllers/login_controller.dart';
import '../Setting/controllers/setting_controller.dart';
import 'config.dart';
import 'package:intl/intl.dart' as intl;
var ShareFile;

class PdfPakage {
  static Widget buildHeader( RepType,GetPKNA,  GETSONA,  GETSONE, GETSORN, GETSOLN,MemoryImage image) {
    return StteingController().SHOW_REP_HEADER==true?
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
            Column(children: [
              Row(
                mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                children: <pw.Widget>[
                  Expanded(child:
                  Column(
                      children: [
                        Text(GETSONE, style: TextStyle(fontWeight: FontWeight.bold, color: PdfColors.red, fontSize: 10.sp)),
                        Text(GETSOLN, style: TextStyle(fontWeight: FontWeight.bold, color: PdfColors.black, fontSize: 10.sp)),
                      ]),),
                  Expanded(child:Column(children: [
                    Container(width: 50.w,),
                    Container(width: 50.w, child: Image(image)
                    ),
                  ])),
                  Expanded(child:Column(children: [
                    Text(GETSONA, style: TextStyle(color: PdfColors.red, fontSize: 11.sp)),
                    Text(GETSORN, style: TextStyle(color: PdfColors.black, fontSize: 11.sp)),
                  ]),)
                ],
              ),
              // Row(
              //   mainAxisAlignment: MainAxisAlignment.center,
              //   children: <pw.Widget>[
              //     Container( margin: const pw.EdgeInsets.symmetric(vertical: 2),
              //         decoration: pw.BoxDecoration(
              //           color: PdfColor.fromHex("#ABABAB"),
              //           borderRadius: pw.BorderRadius.circular(8),
              //         ),
              //         child: Text(
              //             RepType == '1'
              //                 ? ' ${'StringReceiptVoucher'.tr}  $GetPKNA '
              //                 : RepType == '2'
              //                 ? ' ${'StringPaymentVoucher'.tr}  $GetPKNA '
              //                 : RepType == '202' ?
              //             'StringAccount_Statement'.tr
              //                 : RepType == '203' ?
              //             'StringACC_STA_H'.tr
              //                 : RepType == '208' ?
              //             'StringCustomerAccountStatement'.tr
              //                 : RepType == '207' ?
              //             'StringInternalAccountStatement'.tr
              //                 : RepType == '206' ?
              //             'StringSuppliersAccountStatement'.tr
              //                 : RepType == 'Quantities' ?
              //             'StrinSto_Num'.tr
              //                 : RepType == 'Cus_Bal' ?
              //             'StringCus_Bal_Rep'.tr
              //                 : RepType == 'Bal_Bal' ?
              //             'StringSuppliers_Balances_Report'.tr
              //                 : RepType == 'Acc_Bal' ?
              //             'StringAccounts_Balances_Report'.tr
              //                 :  RepType == '15'?' ${'StringJournalVoucher'.tr} ' :
              //             RepType == 'StringTotalDetailedItemReport'?' ${'StringTotalDetailedItemReport'.tr} '
              //                 : RepType == '101'?'StringTotalItemReport'.tr :
              //             RepType == '102'?'StringDetailedItemReport'.tr :
              //             RepType == 'Cus_Acc_Bal'? 'StringDaily_Treasury_Report'.tr:
              //             RepType == 'INVC-17'? 'StringInventory'.tr:
              //             RepType == 'Item_In'? 'StringItem_In_Voucher'.tr:
              //             RepType == 'Item_Out'? 'StringItem_Out_Voucher'.tr:
              //             RepType == 'Transfer'? 'StringInventoryTransferVoucher'.tr:
              //             RepType == 'Transfer_Request'? 'StringTransfer_Store_Request'.tr:
              //             RepType == 'StringInvc_Mov_Rep'? 'StringInvc_Mov_Rep'.tr:
              //             RepType == 'Equil' ? 'StringItem_Equil'.tr
              //                 : RepType == 'Minus' ? 'String_Item_MINES'.tr
              //                 : RepType == 'Plus' ? 'String_Item_PLUS'.tr
              //                 : RepType == 'Mat_Mov_Rep' ? 'StringMat_Mov_Rep'.tr
              //                 : RepType == 'Approving' ? 'StringApprovingReports'.tr
              //                 : ' ${'StringCollectionsVoucher'.tr}  $GetPKNA ',
              //             style: TextStyle(color: PdfColors.black, fontSize: 16.0.sp))) ,
              //     SizedBox(height: 5)
              //   ],
              // ),
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
                      child: Text(
                          RepType == '1'
                              ? ' ${'StringReceiptVoucher'.tr}  $GetPKNA '
                              : RepType == '2'
                              ? ' ${'StringPaymentVoucher'.tr}  $GetPKNA '
                              : RepType == '202' ?
                          'StringAccount_Statement'.tr
                              : RepType == '203' ?
                          'StringACC_STA_H'.tr
                              : RepType == '208' ?
                          'StringCustomerAccountStatement'.tr
                              : RepType == '207' ?
                          'StringInternalAccountStatement'.tr
                              : RepType == '206' ?
                          'StringSuppliersAccountStatement'.tr
                              : RepType == 'Quantities' ?
                          'StrinSto_Num'.tr
                              : RepType == 'Cus_Bal' ?
                          'StringCus_Bal_Rep'.tr
                              : RepType == 'Bal_Bal' ?
                          'StringSuppliers_Balances_Report'.tr
                              : RepType == 'Acc_Bal' ?
                          'StringAccounts_Balances_Report'.tr
                              :  RepType == '15'?' ${'StringJournalVoucher'.tr} ' :
                          RepType == 'StringTotalDetailedItemReport'?' ${'StringTotalDetailedItemReport'.tr} '
                              : RepType == '101'?'StringTotalItemReport'.tr :
                          RepType == '102'?'StringDetailedItemReport'.tr :
                          RepType == 'Cus_Acc_Bal'? 'StringDaily_Treasury_Report'.tr:
                          RepType == 'INVC-17'? 'StringInventory'.tr:
                          RepType == 'Item_In'? 'StringItem_In_Voucher'.tr:
                          RepType == 'Item_Out'? 'StringItem_Out_Voucher'.tr:
                          RepType == 'Transfer'? 'StringInventoryTransferVoucher'.tr:
                          RepType == 'Transfer_Request'? 'StringTransfer_Store_Request'.tr:
                          RepType == 'StringInvc_Mov_Rep'? 'StringInvc_Mov_Rep'.tr:
                          RepType == 'Equil' ? 'StringItem_Equil'.tr
                              : RepType == 'Minus' ? 'String_Item_MINES'.tr
                              : RepType == 'Plus' ? 'String_Item_PLUS'.tr
                              : RepType == 'Mat_Mov_Rep' ? 'StringMat_Mov_Rep'.tr
                              : RepType == 'Approving' ? 'StringApprovingReports'.tr
                              : ' ${'StringCollectionsVoucher'.tr}  $GetPKNA ',
                          style: TextStyle(color: PdfColors.black, fontSize: 16.0.sp))
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
            ])
          ],
        ),
      ],
    )
        :Container();
  }

  static Widget buildFooter(Context context, String SDDNA,String GETSDDDA, String SUNA) =>
      Column(children: [
        context.pagesCount==context.pageNumber?Container(
            child: Column(children: [
              Text(GETSDDDA,
                  style: pw.Theme.of(context).defaultTextStyle.copyWith(color: PdfColors.grey, fontSize: 11.sp)),
              Text(SDDNA,
                  style: pw.Theme.of(context).defaultTextStyle.copyWith(color: PdfColors.grey, fontSize: 11.sp)),
            ])): Container(),
        Divider(),
        Column(children: [
          Row(
            mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
            children: <pw.Widget>[
              pw.Column(children: [
                pw.Text(
                  selectedDatereportnow,
                  style: TextStyle(fontSize: 11.sp, color: PdfColors.grey),
                ),
              ]),
              pw.Column(children: [
                pw.Text('Page ${context.pageNumber}  of ${context.pagesCount}',
                    style: TextStyle(fontSize: 11.sp, color: PdfColors.grey)),
              ]),
              pw.Column(children: [
                pw.Text(SUNA,
                    style: TextStyle(fontSize: 11.sp, color: PdfColors.grey)),
              ]),
            ],
          ),
        ]),
      ]);

  static Widget buildFooter_pdf(Context context,ttf) =>
      pw.Column(children: [
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
      ]);

  static Future<File> saveDocument({
    required String name,
    required pw.Document pdf,
  }) async {
    final bytes = await pdf.save();
    final dir = await getApplicationDocumentsDirectory();
    final file = File('${dir.path}/$name');
    await file.writeAsBytes(bytes);
    return file;
  }

  static Future openFile(File file) async {
    final url = file.path;
    ShareFile = file.path;
    await OpenFilex.open(url);
  }


  static buildText({
    required String title,
    required String value,
    double width = double.infinity,
    TextStyle? titleStyle,
    required Font font,
    bool unite = false,
  }) {
    final style = titleStyle ?? TextStyle(fontWeight: FontWeight.bold,fontSize: 12.sp, font: font);
    return Container(
      width: width,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
      Text(' ${title}' '=' '  ${value}', style:  style ),
        ],
      ),
    );
  }
}