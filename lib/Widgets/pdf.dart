import 'dart:io';
import 'dart:math';
import 'package:flutter/material.dart' as MA;
import '../Operation/Controllers/inventory_controller.dart';
import '../Operation/models/bil_mov_m.dart';
import '../PrintFile/simple_pdf.dart';
import '../Reports/controllers/Cus_Bal_Rep_Controller.dart';
import '../Reports/controllers/Inv_Rep_Controller.dart';
import '../Reports/controllers/approving_rep_controller.dart';
import '../Reports/controllers/invc_mov_rep_controller.dart';
import '../Reports/controllers/sto_num_controller.dart';
import '../Setting/controllers/login_controller.dart';
import '../Setting/models/acc_sta_d.dart';
import '../Setting/models/bal_acc_c.dart';
import '../Setting/models/bal_acc_d.dart';
import '../Setting/models/sto_num_local.dart';
import '../Widgets/config.dart';
import '../database/report_db.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:flutter/material.dart' as ma;
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:pdf/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../Setting/controllers/setting_controller.dart';
import 'colors.dart';
import 'pdfpakage.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart' as intl;

class Pdf {
  // تقرير جرد مخزني---------------
  static Future<File> InventoryReport_Pdf(
      String GetFromDays,
      String GetToDays,
      String GetFromBINA,
      String GetToBINA,
      String GETSONA,
      String GETSONE,
      String GETSORN,
      String GETSOLN,
      String GETSDDSA,
      String USE_SNDE,
      String? GETREPTYE,
      double GetSUMSNNO,
      int GetCount_RECODE,
      int GetSUMMINES,
      int GetSUMPlus,
      int GetSUMDefernt,
      int GetSUMEquil,
      String P_PR_REP,
      String GETSUNA) async {
    final image = await SimplePdf.loadImage();

    var arabicFont =
        Font.ttf(await rootBundle.load("Assets/fonts/HacenTunisia.ttf"));
    final pdf = Document();
    pdf.addPage(MultiPage(
      maxPages: 500,
      textDirection: TextDirection.rtl,
      crossAxisAlignment: CrossAxisAlignment.center,
      theme: ThemeData.withFont(
          base:
              Font.ttf(await rootBundle.load("Assets/fonts/HacenTunisia.ttf"))),
      pageFormat: PdfPageFormat.standard,
      build: (context) => [
        PdfPakage.buildHeader(
            GETREPTYE, '', GETSONA, GETSONE, GETSORN, GETSOLN, image),
        //SizedBox(height: 1 * PdfPageFormat.cm),
        buildTitleInventoryReport(GetFromBINA, GetToBINA, GetFromDays,
            GetToDays, arabicFont, context),
        GETREPTYE != 'StringInvc_Mov_Rep'
            ? buildIncoming_StoreReport(arabicFont, USE_SNDE, P_PR_REP)
            : buildInventoryReport(arabicFont, USE_SNDE),
        SizedBox(height: 2.h),
        GETREPTYE != 'StringIncoming_Store_Rep'
            ? buildSUM_Incoming_StoreReport(
                GetSUMSNNO,
                GetCount_RECODE,
                GetSUMMINES,
                GetSUMPlus,
                GetSUMDefernt,
                GetSUMEquil,
                arabicFont,
                context)
            : buildSUMReport(GetSUMSNNO, GetCount_RECODE, GetSUMMINES,
                GetSUMPlus, GetSUMDefernt, GetSUMEquil, arabicFont, context),
      ],
      footer: (context) =>
          PdfPakage.buildFooter(context, GETSDDSA, '', GETSUNA),
    ));

    return PdfPakage.saveDocument(
        name: GETREPTYE == 'Item_In'
            ? "${'StringItem_In_Voucher'.tr} .pdf"
            : GETREPTYE == 'Item_Out'
                ? "${'StringItem_Out_Voucher'.tr} .pdf"
                : GETREPTYE == 'Transfer'
                    ? "${'StringInventoryTransferVoucher'.tr} .pdf"
                    : GETREPTYE == 'Transfer_Request'
                        ? "${'StringTransfer_Store_Request'.tr} .pdf"
                        : GETREPTYE == 'Transfer_Request'
                            ? "${'StringTransfer_Store_Request'.tr} .pdf"
                            : "${'StringInvc_Mov_Rep'.tr} .pdf",
        pdf: pdf);
  }

  static Widget buildInventoryReport(pw.Font font, String use_snde) {
    final headers = [
      'StringSMDDF'.tr,
      'StringSMDFN'.tr,
      'StringSNNO'.tr,
      'StringSMDED'.tr,
      'StringMUID'.tr,
      'StringMINO'.tr,
      'StringMgno'.tr,
      'م.'
    ];
    final headers2 = [
      'StringSMDDF'.tr,
      'StringSMDFN'.tr,
      'StringSNNO'.tr,
      'StringMUID'.tr,
      'StringMINO'.tr,
      'StringMgno'.tr,
      'م.'
    ];
    return Table.fromTextArray(
      headers: use_snde == '2' ? headers2 : headers,
      // data:data,
      data: use_snde == '2'
          ? <List<dynamic>>[
              ...STO_MOV_D_List.map((Data) => [
                    Data.SMDDF,
                    Data.SMDNF,
                    Data.SMDNO,
                    Data.MUNA_D,
                    Data.MINA_D,
                    Data.MGNO,
                    Data.SMMNO
                  ]).toList(),
            ]
          : <List<dynamic>>[
              ...STO_MOV_D_List.map((Data) => [
                    Data.SMDDF,
                    Data.SMDNF,
                    Data.SMDNO,
                    Data.SMDED,
                    Data.MUNA_D,
                    Data.MINA_D,
                    Data.MGNO,
                    Data.SMMNO
                  ]).toList(),
            ],
      cellStyle: pw.TextStyle(
        font: font,
        decorationColor: PdfColors.amber100,
      ),
      // border: pw.Border.all(color: PdfColors.black),
      headerStyle: TextStyle(fontWeight: FontWeight.bold, font: font),
      headerDecoration: BoxDecoration(color: PdfColors.grey200),
      cellHeight: 30,

      cellAlignments: {
        0: Alignment.center,
        // 0: Alignment.centerLeft,
        1: Alignment.center,
        2: Alignment.center,
        3: Alignment.center,
        4: Alignment.center,
        5: Alignment.center,
        6: Alignment.center,
        7: Alignment.center,
      },
    );
  }

  static Widget buildIncoming_StoreReport(
      pw.Font font, String use_snde, P_PR_REP) {
    final headers = [
      'StringMPCO'.tr,
      'StringSNNO'.tr,
      'StringSMDED'.tr,
      'StringMUID'.tr,
      'StringMINO'.tr,
      'StringMgno'.tr,
      'م.'
    ];
    final headers2 = [
      // 'StringSMDAM'.tr,
      'StringSNNO'.tr,
      'StringSMDED'.tr,
      'StringMUID'.tr,
      'StringMINO'.tr,
      'StringMgno'.tr,
      'م.'
    ];
    return Table.fromTextArray(
      headers: P_PR_REP == '1' ? headers : headers2,
      // data:data,
      data:
          // use_snde == '2'
          //     ? <List<dynamic>>[
          //         ...STO_MOV_D_List.map((Data) => [
          //               Data.SMDAM,
          //               Data.SMDNO,
          //               Data.MUNA_D,
          //               Data.MINA_D,
          //               Data.MGNO,
          //               Data.SMMNO
          //             ]).toList(),
          //       ]
          //     :
          P_PR_REP == '1'
              ? <List<dynamic>>[
                  ...STO_MOV_D_List.map((Data) => [
                        Data.SMDAM,
                        Data.SMDNO,
                        Data.SMDED == "01-01-2900" ? '' : Data.SMDED,
                        Data.MUNA_D,
                        Data.MINA_D,
                        Data.MGNO,
                        Data.SMMNO
                      ]).toList(),
                ]
              : <List<dynamic>>[
                  ...STO_MOV_D_List.map((Data) => [
                        Data.SMDNO,
                        Data.SMDED == "01-01-2900" ? '' : Data.SMDED,
                        Data.MUNA_D,
                        Data.MINA_D,
                        Data.MGNO,
                        Data.SMMNO
                      ]).toList(),
                ],
      cellStyle: pw.TextStyle(
        font: font,
        decorationColor: PdfColors.amber100,
      ),
      // border: pw.Border.all(color: PdfColors.black),
      headerStyle: TextStyle(fontWeight: FontWeight.bold, font: font),
      headerDecoration: BoxDecoration(color: PdfColors.grey200),
      cellHeight: 30,

      cellAlignments: {
        0: Alignment.center,
        // 0: Alignment.centerLeft,
        1: Alignment.center,
        2: Alignment.center,
        3: Alignment.center,
        4: Alignment.center,
        5: Alignment.center,
        6: Alignment.center,
        7: Alignment.center,
      },
    );
  }

  static Widget buildContentTra_Mov_Rep(pw.Font font, String use_snde) {
    final headers = [
      'StringSNNO'.tr,
      'StringSMDED'.tr,
      'StringMUID'.tr,
      'StringMINO'.tr,
      'StringMgno'.tr,
      'رقم'
    ];
    final headers2 = [
      'StringSNNO'.tr,
      'StringMUID'.tr,
      'StringMINO'.tr,
      'StringMgno'.tr,
      'رقم'
    ];
    return Table.fromTextArray(
      headers: use_snde == '2' ? headers2 : headers,
      // data:data,
      data: use_snde == '2'
          ? <List<dynamic>>[
              ...STO_MOV_D_List.map((Data) => [
                    Data.SMDNO,
                    Data.MUNA_D,
                    Data.MINA_D,
                    Data.MGNA,
                    Data.SMMNO
                  ]).toList(),
            ]
          : <List<dynamic>>[
              ...STO_MOV_D_List.map((Data) => [
                    Data.SMDNO,
                    Data.SMDED,
                    Data.MUNA,
                    Data.MINA,
                    Data.MGNA,
                    Data.SMMNO
                  ]).toList(),
            ],
      cellStyle: pw.TextStyle(
        font: font,
        decorationColor: PdfColors.amber100,
      ),

      // border: pw.Border.all(color: PdfColors.black),
      headerStyle: TextStyle(fontWeight: FontWeight.bold, font: font),
      headerDecoration: BoxDecoration(color: PdfColors.grey200),
      cellHeight: 30,

      cellAlignments: {
        0: Alignment.center,
        // 0: Alignment.centerLeft,
        1: Alignment.center,
        2: Alignment.center,
        3: Alignment.center,
        4: Alignment.center,
        5: Alignment.center,
        6: Alignment.center,
        7: Alignment.center,
      },
    );
  }

  static Widget buildTitleInventoryReport(
          String GetFromBINA,
          String GetToBINA,
          String GetFromDays,
          String GetToDays,
          pw.Font font,
          Context context) =>
      Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Column(
              crossAxisAlignment: pw.CrossAxisAlignment.center,
              mainAxisSize: pw.MainAxisSize.min,
              children: [
                pw.Center(
                    child: pw.Column(children: [
                  pw.Divider(
                    height: 1,
                  ),
                  pw.Row(
                    mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                    children: <pw.Widget>[
                      pw.Column(children: [
                        pw.Text(
                          '${'StringToBrach_Rep'.tr}${GetToBINA}',
                          style: TextStyle(fontSize: 13.0.sp),
                        ),
                      ]),
                      pw.Column(children: [
                        pw.Text('${'StringFromBrach_Rep'.tr}${GetFromBINA}',
                            style: TextStyle(fontSize: 13.0.sp)),
                      ])
                    ],
                  ),
                  pw.Row(
                    mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                    children: <pw.Widget>[
                      pw.Column(children: [
                        pw.Text(
                          '${'StringToDate_Rep'.tr} ${GetToDays}',
                          style: TextStyle(fontSize: 13.0.sp),
                        ),
                      ]),
                      pw.Column(children: [
                        pw.Text(
                          '${'StringFromDate_Rep'.tr} ${GetFromDays}',
                          style: TextStyle(fontSize: 13.0.sp),
                        ),
                      ])
                    ],
                  ),
                ])),
              ]),
          SizedBox(height: 0.3 * PdfPageFormat.cm),
          // Text(dataInfo.billnote.toString()),
          // SizedBox(height: 0.8 * PdfPageFormat.cm),
        ],
      );

  static Widget buildSUMReport(
          double GetSUMSNNO,
          int GetCount_RECODE,
          int GetSUMMINES,
          int GetSUMPlus,
          int GetSUMDefernt,
          int GetSUMEquil,
          pw.Font font,
          Context context) =>
      Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Column(
              crossAxisAlignment: pw.CrossAxisAlignment.start,
              mainAxisSize: pw.MainAxisSize.min,
              children: [
                pw.Center(
                    child: pw.Column(children: [
                  pw.Row(
                    mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                    children: <pw.Widget>[
                      Expanded(
                        flex: 4,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  pw.Text(
                                    '${'StringSUMSNNORep'.tr} ${GetSUMSNNO}',
                                    style: TextStyle(
                                        fontSize: 16,
                                        color: PdfColors.redAccent),
                                  ),
                                  pw.Text(
                                      ' ${'StrinCount_MINO'.tr} ${GetCount_RECODE}',
                                      style: TextStyle(fontSize: 16)),
                                ]),
                            Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  PdfPakage.buildText(
                                    title: 'StringSUMMINES'.tr,
                                    value: GetSUMMINES.toString(),
                                    font: font,
                                    unite: true,
                                  ),
                                  PdfPakage.buildText(
                                    title: 'StringSUMPLUS'.tr,
                                    value: GetSUMPlus.toString(),
                                    font: font,
                                    unite: true,
                                  ),
                                  PdfPakage.buildText(
                                    title: 'StringEquil'.tr,
                                    value: GetSUMEquil.toString(),
                                    font: font,
                                    unite: true,
                                  ), //Divider(),
                                ])
                          ],
                        ),
                      ),
                    ],
                  ),
                ])),
              ]),
          SizedBox(height: 0.3 * PdfPageFormat.cm),
          // Text(dataInfo.billnote.toString()),
          // SizedBox(height: 0.8 * PdfPageFormat.cm),
        ],
      );

  static Widget buildSUM_Incoming_StoreReport(
          double GetSUMSNNO,
          int GetCount_RECODE,
          int GetSUMMINES,
          int GetSUMPlus,
          int GetSUMDefernt,
          int GetSUMEquil,
          pw.Font font,
          Context context) =>
      Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Column(
              crossAxisAlignment: pw.CrossAxisAlignment.start,
              mainAxisSize: pw.MainAxisSize.min,
              children: [
                pw.Center(
                    child: pw.Column(children: [
                  pw.Row(
                    mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                    children: <pw.Widget>[
                      Expanded(
                        flex: 4,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  pw.Text(
                                    '${'StringSUMSNNORep'.tr} ${GetSUMSNNO}',
                                    style: TextStyle(
                                        fontSize: 16,
                                        color: PdfColors.redAccent),
                                  ),
                                  pw.Text(
                                      ' ${'StrinCount_MINO'.tr} ${GetCount_RECODE}',
                                      style: TextStyle(fontSize: 16)),
                                ]),
                          ],
                        ),
                      ),
                    ],
                  ),
                ])),
              ]),
          SizedBox(height: 0.3 * PdfPageFormat.cm),
          // Text(dataInfo.billnote.toString()),
          // SizedBox(height: 0.8 * PdfPageFormat.cm),
        ],
      );

  static Future<File> MAT_MOVReport_Pdf(
      String GetFromDays,
      String GetToDays,
      String GetFromBINA,
      String GetToBINA,
      String GETSONA,
      String GETSONE,
      String GETSORN,
      String GETSOLN,
      String GETSDDSA,
      String USE_SNDE,
      String GETREPTYE,
      double GetSUMSNNO,
      int GetCount_RECODE,
      int GetSUMMINES,
      int GetSUMPlus,
      int GetSUMDefernt,
      int GetSUMEquil,
      String GETSUNA) async {
    var arabicFont =
        Font.ttf(await rootBundle.load("Assets/fonts/HacenTunisia.ttf"));
    final pdf = Document();
    final image = await SimplePdf.loadImage();

    pdf.addPage(MultiPage(
      maxPages: 500,
      textDirection: TextDirection.rtl,
      crossAxisAlignment: CrossAxisAlignment.center,
      theme: ThemeData.withFont(
          base:
              Font.ttf(await rootBundle.load("Assets/fonts/HacenTunisia.ttf"))),
      pageFormat: PdfPageFormat.standard,
      build: (context) => [
        PdfPakage.buildHeader(
            GETREPTYE, '', GETSONA, GETSONE, GETSORN, GETSOLN, image),
        //SizedBox(height: 1 * PdfPageFormat.cm),
        buildTitleMAT_MOVReport(GetFromBINA, GetToBINA, GetFromDays, GetToDays,
            arabicFont, context),
        buildMAT_MOVReport(arabicFont, USE_SNDE),
        SizedBox(height: 2.h),
        buildSUM_Tra_Rep(GetSUMSNNO, GetCount_RECODE, arabicFont, context),
        //Divider(),
        // buildTotal(expensesDataInfo,arabicFont),
      ],
      footer: (context) =>
          PdfPakage.buildFooter(context, GETSDDSA, '', GETSUNA),
    ));

    return PdfPakage.saveDocument(
        name: "${'StringMat_Mov_Rep'.tr}.pdf", pdf: pdf);
  }

  // تقرير الاصناف غير مضمنه ---------------

  static Widget buildMAT_MOVReport(pw.Font font, String use_snde) {
    final headers = [
      'StringSNNO'.tr,
      'StringSMDED'.tr,
      'StringMUID'.tr,
      'StringMINO'.tr,
      'StringMgno'.tr,
    ];
    final headers2 = [
      'StringSNNO'.tr,
      'StringMUID'.tr,
      'StringMINO'.tr,
      'StringMgno'.tr,
    ];
    return Table.fromTextArray(
      headers: use_snde == '2' ? headers2 : headers,
      // data:data,
      data: use_snde == '2'
          ? <List<dynamic>>[
              ...STO_MOV_D_List.map((Data) =>
                  [Data.SMDNO, Data.MUNA_D, Data.MINA_D, Data.MGNO]).toList(),
            ]
          : <List<dynamic>>[
              ...STO_MOV_D_List.map((Data) => [
                    Data.SMDNO,
                    Data.SMDED,
                    Data.MUNA_D,
                    Data.MINA_D,
                    Data.MGNO
                  ]).toList(),
            ],
      cellStyle: pw.TextStyle(
        font: font,
        decorationColor: PdfColors.amber100,
      ),

      // border: pw.Border.all(color: PdfColors.black),
      headerStyle: TextStyle(fontWeight: FontWeight.bold, font: font),
      headerDecoration: BoxDecoration(color: PdfColors.grey200),
      cellHeight: 28.h,

      cellAlignments: {
        0: Alignment.center,
        // 0: Alignment.centerLeft,
        1: Alignment.center,
        2: Alignment.center,
        3: Alignment.center,
        4: Alignment.center,
        5: Alignment.center,
      },
    );
  }

  static Widget buildTitleMAT_MOVReport(
          String GetFromBINA,
          String GetToBINA,
          String GetFromDays,
          String GetToDays,
          pw.Font font,
          Context context) =>
      Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Column(
              crossAxisAlignment: pw.CrossAxisAlignment.center,
              mainAxisSize: pw.MainAxisSize.min,
              children: [
                pw.Center(
                    child: pw.Column(children: [
                  pw.Divider(height: 1),
                  pw.Row(
                    mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                    children: <pw.Widget>[
                      pw.Column(children: [
                        pw.Text(
                          '${'StringToBrach_Rep'.tr}${GetToBINA}',
                          style: TextStyle(fontSize: 13.0.sp),
                        ),
                      ]),
                      pw.Column(children: [
                        pw.Text('${'StringFromBrach_Rep'.tr}${GetFromBINA}',
                            style: TextStyle(fontSize: 13.0.sp)),
                      ])
                    ],
                  ),
                  pw.Row(
                    mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                    children: <pw.Widget>[
                      pw.Column(children: [
                        pw.Text(
                          '${'StringToDate_Rep'.tr} ${GetToDays}',
                        ),
                      ]),
                      pw.Column(children: [
                        pw.Text(
                          '${'StringFromDate_Rep'.tr} ${GetFromDays}',
                        ),
                      ])
                    ],
                  ),
                ])),
              ]),
          SizedBox(height: 0.3 * PdfPageFormat.cm),
          // Text(dataInfo.billnote.toString()),
          // SizedBox(height: 0.8 * PdfPageFormat.cm),
        ],
      );

  static Widget buildSUM_Tra_Rep(double GetSUMSNNO, int GetCount_RECODE,
          pw.Font font, Context context) =>
      Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Column(
              crossAxisAlignment: pw.CrossAxisAlignment.start,
              mainAxisSize: pw.MainAxisSize.min,
              children: [
                pw.Center(
                    child: pw.Column(children: [
                  pw.Row(
                    mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                    children: <pw.Widget>[
                      pw.Column(children: [
                        pw.Text(
                          '${'StringSUMSNNORep'.tr} ${GetSUMSNNO}',
                          style: TextStyle(
                              fontSize: 16, color: PdfColors.redAccent),
                        ),
                      ]),
                      pw.Column(children: [
                        pw.Text('${'StrinCount_MINO'.tr} ${GetCount_RECODE}',
                            style: TextStyle(fontSize: 16)),
                      ]),
                    ],
                  ),
                ])),
              ]),
          SizedBox(height: 0.3 * PdfPageFormat.cm),
          // Text(dataInfo.billnote.toString()),
          // SizedBox(height: 0.8 * PdfPageFormat.cm),
        ],
      );

  static Future<File> Plus_Equil_Minus_Mat_Pdf(
      String GETSDDSA,
      String GETSONA,
      String GETSONE,
      String GETSORN,
      String GETSOLN,
      String USE_SNDE,
      String GETREPTYE,
      String GETSUNA) async {
    final image = await SimplePdf.loadImage();

    var arabicFont = Font.ttf(await rootBundle.load("Assets/fonts/HacenTunisia.ttf"));
    final pdf = Document();
    pdf.addPage(MultiPage(
      maxPages: 500,
      textDirection: TextDirection.rtl,
      crossAxisAlignment: CrossAxisAlignment.center,
      theme: ThemeData.withFont(
          base:
              Font.ttf(await rootBundle.load("Assets/fonts/HacenTunisia.ttf"))),
      pageFormat: PdfPageFormat.standard,
      build: (context) => [
        PdfPakage.buildHeader(
            GETREPTYE, '', GETSONA, GETSONE, GETSORN, GETSOLN, image),
        //SizedBox(height: 1 * PdfPageFormat.cm),
        buildContentPlus_Equil_Minus_Mat(arabicFont, USE_SNDE),
      ],
      footer: (context) =>
          PdfPakage.buildFooter(context, GETSDDSA, '', GETSUNA),
    ));

    return PdfPakage.saveDocument(
        name: GETREPTYE == 'Equil'
            ? "${'StringItem_Equil'.tr}.pdf"
            : GETREPTYE == 'Minus'
                ? "${'String_Item_MINES'.tr}.pdf"
                : GETREPTYE == 'Plus'
                    ? "${'String_Item_PLUS'.tr}.pdf"
                    : "${'String_Item_PLUS'.tr}.pdf",
        pdf: pdf);
  }

  static Widget buildContentPlus_Equil_Minus_Mat(
      pw.Font font, String use_snde) {
    final headers = [
      'StringSMDFN'.tr,
      'StringSNNO'.tr,
      'StringMUID'.tr,
      'StringMINO'.tr,
      'StringMgno'.tr,
      'StringSMMNO'.tr,
    ];
    final headers2 = [
      'StringSMDFN'.tr,
      'StringSNNO'.tr,
      'StringSMDED'.tr,
      'StringMUID'.tr,
      'StringMINO'.tr,
      'StringMgno'.tr,
      'StringSMMNO'.tr,
    ];

    return Table.fromTextArray(
      headers: use_snde == '2' ? headers : headers2,
      // data:data,
      data: use_snde == '2'
          ? <List<dynamic>>[
              ...STO_MOV_D_List.map((Data) => [
                    Data.SMDNF,
                    Data.SMDNO,
                    Data.MUNA_D,
                    Data.MINA_D,
                    Data.MGNO,
                    Data.SMMNO
                  ]).toList()
            ]
          : <List<dynamic>>[
              ...STO_MOV_D_List.map((Data) => [
                    Data.SMDNF,
                    Data.SMDNO,
                    Data.SMDED,
                    Data.MUNA_D,
                    Data.MINA_D,
                    Data.MGNO,
                    Data.SMMNO,
                  ]).toList(),
            ],
      cellStyle: pw.TextStyle(
        font: font,
        decorationColor: PdfColors.amber100,
      ),
      // border: pw.Border.all(color: PdfColors.black),
      headerStyle: TextStyle(fontWeight: FontWeight.bold, font: font),
      headerDecoration: BoxDecoration(color: PdfColors.grey200),
      cellHeight: 30.h,
      cellAlignments: {
        0: Alignment.center,
        1: Alignment.center,
        2: Alignment.center,
        3: Alignment.center,
        4: Alignment.center,
        5: Alignment.center,
        6: Alignment.center,
      },
    );
  }

  static Future<File> Inventory_Pdf(
      String GetSMMDO,
      String GetSMMNO,
      String GetSINA,
      String GetBINA,
      String GETSDDSA,
      String GETSONA,
      String GETSONE,
      String GETSORN,
      String GETSOLN,
      String GETREPTYE,
      String GETSUNA,
      String P_PR_REP) async {
    final image = await SimplePdf.loadImage();

    var arabicFont =
        Font.ttf(await rootBundle.load("Assets/fonts/HacenTunisia.ttf"));
    final pdf = Document();
    pdf.addPage(MultiPage(
      maxPages: 500,
      textDirection: TextDirection.rtl,
      crossAxisAlignment: CrossAxisAlignment.center,
      theme: ThemeData.withFont(
          base:
              Font.ttf(await rootBundle.load("Assets/fonts/HacenTunisia.ttf"))),
      pageFormat: PdfPageFormat.standard,
      build: (context) => [
        PdfPakage.buildHeader(
            GETREPTYE, '', GETSONA, GETSONE, GETSORN, GETSOLN, image),
        //SizedBox(height: 1 * PdfPageFormat.cm),
        buildTitle(GetSMMDO, GetSMMNO, GetSINA, GetBINA, arabicFont, context),
        buildContentInventory(arabicFont),
        SizedBox(height: 2.h),
        //buildTotal(),
        //Divider(),
        // buildTotal(expensesDataInfo,arabicFont),
      ],
      footer: (context) =>
          PdfPakage.buildFooter(context, GETSDDSA, '', GETSUNA),
    ));

    return PdfPakage.saveDocument(
        name: "جرد مخزني رقم${GetSMMNO}.pdf", pdf: pdf);
  }

  static Widget buildTitle(String GetSMMDO, String GetSMMNO, String GetSINA,
          String GetBINA, pw.Font font, Context context) =>
      Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Column(
              crossAxisAlignment: pw.CrossAxisAlignment.center,
              mainAxisSize: pw.MainAxisSize.min,
              children: [
                pw.Center(
                    child: pw.Column(children: [
                  pw.Divider(height: 1),
                  pw.Row(
                    mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                    children: <pw.Widget>[
                      pw.Column(children: [
                        pw.Text('${'StringBIID2'.tr} ${GetBINA}',
                            style: TextStyle(fontSize: 13.sp)),
                      ]),
                      pw.Column(children: [
                        pw.Text('${'StringSMDED3'.tr} ${GetSMMDO}',
                            style: TextStyle(fontSize: 13.sp)),
                      ])
                    ],
                  ),
                  pw.Row(
                    mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                    children: <pw.Widget>[
                      pw.Column(children: [
                        pw.Text('${'StringSIID2'.tr} ${GetSINA}',
                            style: TextStyle(fontSize: 13.sp)),
                      ]),
                      pw.Column(children: [
                        pw.Text('${'StringSMMID'.tr} ${GetSMMNO}',
                            style: TextStyle(fontSize: 13.sp)),
                      ])
                    ],
                  ),
                ])),
              ]),
          SizedBox(height: 0.3 * PdfPageFormat.cm),
          // Text(dataInfo.billnote.toString()),
          // SizedBox(height: 0.8 * PdfPageFormat.cm),
        ],
      );

  static Widget buildTitleInComing(
          String GetSMMDO,
          String GetSMMNO,
          String GetSINA,
          String GetBINA,
          String GetAANA,
          String GetSCNA,
          pw.Font font,
          Context context) =>
      Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Column(
              crossAxisAlignment: pw.CrossAxisAlignment.center,
              mainAxisSize: pw.MainAxisSize.min,
              children: [
                pw.Center(
                    child: pw.Column(children: [
                  pw.Divider(height: 1),
                  pw.Row(
                    mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                    children: <pw.Widget>[
                      pw.Column(children: [
                        pw.Text('${'StringBIID2'.tr} ${GetBINA}',
                            style: TextStyle(fontSize: 13.sp)),
                      ]),
                      pw.Column(children: [
                        pw.Text('${'StringSMDED3'.tr} ${GetSMMDO}',
                            style: TextStyle(fontSize: 13.sp)),
                      ])
                    ],
                  ),
                  pw.Row(
                    mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                    children: <pw.Widget>[
                      pw.Column(children: [
                        pw.Text('${'StringSIID2'.tr} ${GetSINA}',
                            style: TextStyle(fontSize: 13.sp)),
                      ]),
                      pw.Column(children: [
                        pw.Text('${'StringSMMID'.tr} ${GetSMMNO}',
                            style: TextStyle(fontSize: 13.sp)),
                      ])
                    ],
                  ),
                  pw.Row(
                    mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                    children: <pw.Widget>[
                      pw.Column(children: [
                        pw.Text('${'StringSCID'.tr} ${GetSCNA}',
                            style: TextStyle(fontSize: 13.sp)),
                      ]),
                      pw.Column(children: [
                        pw.Text('${'StringAANO2'.tr} ${GetAANA}',
                            style: TextStyle(fontSize: 13.sp)),
                      ])
                    ],
                  ),
                ])),
              ]),
          SizedBox(height: 0.3 * PdfPageFormat.cm),
          // Text(dataInfo.billnote.toString()),
          // SizedBox(height: 0.8 * PdfPageFormat.cm),
        ],
      );

  static Widget buildTitleTransfer(String GetSMMDO, String GetSMMNO,
          String GetFSIID, String GetT_SIID, pw.Font font, Context context) =>
      Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Column(
              crossAxisAlignment: pw.CrossAxisAlignment.center,
              mainAxisSize: pw.MainAxisSize.min,
              children: [
                pw.Center(
                    child: pw.Column(children: [
                  pw.Divider(height: 1),
                  pw.Row(
                    mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                    children: <pw.Widget>[
                      pw.Column(children: [
                        pw.Text('${'StringF_SIID2'.tr}${GetFSIID}',
                            style: TextStyle(fontSize: 13.sp)),
                      ]),
                      pw.Column(children: [
                        pw.Text('${'StringSMDED2'.tr} ${GetSMMDO}',
                            style: TextStyle(fontSize: 13.sp)),
                      ])
                    ],
                  ),
                  pw.Row(
                    mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                    children: <pw.Widget>[
                      pw.Column(children: [
                        pw.Text('${'StringT_SIID2'.tr}${GetT_SIID}',
                            style: TextStyle(fontSize: 13.sp)),
                      ]),
                      pw.Column(children: [
                        pw.Text('${'StringSMMNO'.tr}${GetSMMNO}',
                            style: TextStyle(fontSize: 13.sp)),
                      ])
                    ],
                  ),
                ])),
              ]),
          SizedBox(height: 0.3 * PdfPageFormat.cm),
          // Text(dataInfo.billnote.toString()),
          // SizedBox(height: 0.8 * PdfPageFormat.cm),
        ],
      );

  static Widget buildContentInventory(pw.Font font) {
    final headers = [
      'StringSMDDF'.tr,
      'StringSMDFN'.tr,
      'StringSNNO'.tr,
      'StringMUID'.tr,
      'StringMINO'.tr,
      'StringMgno'.tr
    ];
    final headers2 = [
      'StringSMDDF'.tr,
      'StringSMDFN'.tr,
      'StringSNNO'.tr,
      'StringSMDED'.tr,
      'StringMUID'.tr,
      'StringMINO'.tr,
      'StringMgno'.tr
    ];

    return Table.fromTextArray(
      headers: headers2,
      // data:data,
      data:
          // use_snde == '2'
          //     ? <List<dynamic>>[
          //         ...get_item
          //             .map((Data) => [
          //                   Data.SMDDF,
          //                   Data.SMDNF,
          //                   Data.SMDNO,
          //                   Data.MUNA,
          //                   Data.MINA,
          //                   Data.MGNO
          //                 ])
          //             .toList()
          //       ]
          //     :
          <List<dynamic>>[
        ...get_item
            .map((Data) => [
                  Data.SMDDF,
                  Data.SMDNF,
                  Data.SMDNO,
                  Data.SMDED == '01-01-2900' ? '' : Data.SMDED,
                  Data.MUNA,
                  Data.MINA,
                  Data.MGNO
                ])
            .toList(),
      ],
      cellStyle: pw.TextStyle(
        font: font,
        decorationColor: PdfColors.amber100,
      ),
      // border: pw.Border.all(color: PdfColors.black),
      headerStyle: TextStyle(fontWeight: FontWeight.bold, font: font),
      headerDecoration: BoxDecoration(color: PdfColors.grey200),
      cellHeight: 30.h,
      cellAlignments: {
        0: Alignment.center,
        1: Alignment.center,
        2: Alignment.center,
        3: Alignment.center,
        4: Alignment.center,
        5: Alignment.center,
        6: Alignment.center,
      },
    );
  }


  static Future<File> Sto_Num_Pdf(
      String GetSINA,
      String GetBINA,
      String GETSDDSA,
      String USE_SNDE,
      String GETSONA,
      String GETSONE,
      String GETSORN,
      String GETSOLN,
      String GETREPTYE,
      String GETSUNA,
      double GetSUMSNNO,
      double SUM_MPS1,
      int COUNT_MINO,
      int Use_UPIN,
      STO_V_N) async {
    final image = await SimplePdf.loadImage();
    var arabicFont =
        Font.ttf(await rootBundle.load("Assets/fonts/HacenTunisia.ttf"));
    final pdf = Document();
    final formatter = intl.NumberFormat.decimalPattern();
    double totalSNNO =
        get_Sto_Num.fold(0, (sum, product) => sum + product.SNNO!);
    double roundedTotal = 0;
    for (var product in get_Sto_Num) {
      roundedTotal +=
          product.SNNO! * product.MPCO!; // افترض أن MPCO موجود في المنتج
    }

// تقريب الإجمالي إلى رقم صحيح أو عدد معين من الخانات العشرية
    double roundedTotal2 = roundedTotal; // تقريب إلى عدد صحيح
    int itemCount = get_Sto_Num.length;

    pdf.addPage(MultiPage(
      maxPages: 500,
      textDirection: TextDirection.rtl,
      crossAxisAlignment: CrossAxisAlignment.center,
      theme: ThemeData.withFont(
          base:
              Font.ttf(await rootBundle.load("Assets/fonts/HacenTunisia.ttf"))),
      pageFormat: PdfPageFormat.a4,
      build: (context) => [
        PdfPakage.buildHeader(
            GETREPTYE, '', GETSONA, GETSONE, GETSORN, GETSOLN, image),
        buildTitleSto_Num(GetBINA, GetSINA, arabicFont, context),
        Use_UPIN == 1 && USE_SNDE != '2'
            ? Table(border: TableBorder.all(), columnWidths: {
                0: const FlexColumnWidth(0.6),
                1: const FlexColumnWidth(0.5),
                2: const FlexColumnWidth(0.3),
                3: const FlexColumnWidth(0.4),
                4: const FlexColumnWidth(1.1),
                5: const FlexColumnWidth(0.4),
                6: const FlexColumnWidth(0.3),
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
                        'StringMPCO2'.tr,
                        arabicFont,
                        fontSize: 10,
                        color: PdfColors.black,
                      ),
                    ),
                    Container(
                      decoration: const BoxDecoration(),
                      padding: const EdgeInsets.all(1),
                      child: SimplePdf.text(
                        'StringSMDED'.tr,
                        arabicFont,
                        fontSize: 10,
                        color: PdfColors.black,
                      ),
                    ),
                    Container(
                      decoration: const BoxDecoration(),
                      padding: const EdgeInsets.all(1),
                      child: SimplePdf.text(
                        'StringSNNO'.tr,
                        arabicFont,
                        fontSize: 10,
                        color: PdfColors.black,
                      ),
                    ),
                    Container(
                      decoration: const BoxDecoration(),
                      padding: const EdgeInsets.all(1),
                      child: SimplePdf.text(
                        'StringMUID'.tr,
                        arabicFont,
                        fontSize: 10,
                        color: PdfColors.black,
                      ),
                    ),
                    Container(
                      decoration: const BoxDecoration(),
                      padding: const EdgeInsets.all(1),
                      child: SimplePdf.text(
                        'StringMINO'.tr,
                        arabicFont,
                        fontSize: 10,
                        color: PdfColors.black,
                      ),
                    ),
                    Container(
                      decoration: const BoxDecoration(),
                      padding: const EdgeInsets.all(1),
                      child: SimplePdf.text(
                        'StringMgno'.tr,
                        arabicFont,
                        fontSize: 10,
                        color: PdfColors.black,
                      ),
                    ),
                    Container(
                      decoration: const BoxDecoration(),
                      padding: const EdgeInsets.all(1),
                      child: SimplePdf.text(
                        'StringSIIDlableText'.tr,
                        arabicFont,
                        fontSize: 10,
                        color: PdfColors.black,
                      ),
                    ),
                  ],
                ),
              ])
            : (Use_UPIN != 1 && USE_SNDE != '2')
                ? Table(border: TableBorder.all(), columnWidths: {
                    0: const FlexColumnWidth(0.5),
                    1: const FlexColumnWidth(0.3),
                    2: const FlexColumnWidth(0.4),
                    3: const FlexColumnWidth(1.5),
                    4: const FlexColumnWidth(0.4),
                    5: const FlexColumnWidth(0.4),
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
                            'StringSMDED'.tr,
                            arabicFont,
                            fontSize: 10,
                            color: PdfColors.black,
                          ),
                        ),
                        Container(
                          decoration: const BoxDecoration(),
                          padding: const EdgeInsets.all(1),
                          child: SimplePdf.text(
                            'StringSNNO'.tr,
                            arabicFont,
                            fontSize: 10,
                            color: PdfColors.black,
                          ),
                        ),
                        Container(
                          decoration: const BoxDecoration(),
                          padding: const EdgeInsets.all(1),
                          child: SimplePdf.text(
                            'StringMUID'.tr,
                            arabicFont,
                            fontSize: 10,
                            color: PdfColors.black,
                          ),
                        ),
                        Container(
                          decoration: const BoxDecoration(),
                          padding: const EdgeInsets.all(1),
                          child: SimplePdf.text(
                            'StringMINO'.tr,
                            arabicFont,
                            fontSize: 10,
                            color: PdfColors.black,
                          ),
                        ),
                        Container(
                          decoration: const BoxDecoration(),
                          padding: const EdgeInsets.all(1),
                          child: SimplePdf.text(
                            'StringMgno'.tr,
                            arabicFont,
                            fontSize: 10,
                            color: PdfColors.black,
                          ),
                        ),
                        Container(
                          decoration: const BoxDecoration(),
                          padding: const EdgeInsets.all(1),
                          child: SimplePdf.text(
                            'StringSIIDlableText'.tr,
                            arabicFont,
                            fontSize: 10,
                            color: PdfColors.black,
                          ),
                        ),
                      ],
                    ),
                  ])
                : (Use_UPIN != 1 && USE_SNDE == '2')
                    ? Table(border: TableBorder.all(), columnWidths: {
                        0: const FlexColumnWidth(0.3),
                        1: const FlexColumnWidth(0.4),
                        2: const FlexColumnWidth(0.4),
                        3: const FlexColumnWidth(1.7),
                        4: const FlexColumnWidth(0.4),
                        5: const FlexColumnWidth(0.4),
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
                                'StringSNHO'.tr,
                                arabicFont,
                                fontSize: 10,
                                color: PdfColors.black,
                              ),
                            ),
                            Container(
                              decoration: const BoxDecoration(),
                              padding: const EdgeInsets.all(1),
                              child: SimplePdf.text(
                                'StringSNNO'.tr,
                                arabicFont,
                                fontSize: 10,
                                color: PdfColors.black,
                              ),
                            ),
                            Container(
                              decoration: const BoxDecoration(),
                              padding: const EdgeInsets.all(1),
                              child: SimplePdf.text(
                                'StringMUID'.tr,
                                arabicFont,
                                fontSize: 10,
                                color: PdfColors.black,
                              ),
                            ),
                            Container(
                              decoration: const BoxDecoration(),
                              padding: const EdgeInsets.all(1),
                              child: SimplePdf.text(
                                'StringMINO'.tr,
                                arabicFont,
                                fontSize: 10,
                                color: PdfColors.black,
                              ),
                            ),
                            Container(
                              decoration: const BoxDecoration(),
                              padding: const EdgeInsets.all(1),
                              child: SimplePdf.text(
                                'StringMgno'.tr,
                                arabicFont,
                                fontSize: 10,
                                color: PdfColors.black,
                              ),
                            ),
                            Container(
                              decoration: const BoxDecoration(),
                              padding: const EdgeInsets.all(1),
                              child: SimplePdf.text(
                                'StringSIIDlableText'.tr,
                                arabicFont,
                                fontSize: 10,
                                color: PdfColors.black,
                              ),
                            ),
                          ],
                        ),
                      ])
                    : Table(border: TableBorder.all(), columnWidths: {
                        0: const FlexColumnWidth(0.5),
                        1: const FlexColumnWidth(0.5),
                        2: const FlexColumnWidth(0.4),
                        3: const FlexColumnWidth(0.4),
                        4: const FlexColumnWidth(1.4),
                        5: const FlexColumnWidth(0.4),
                        6: const FlexColumnWidth(0.3),
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
                                'StrinCount_BMDAMC'.tr,
                                arabicFont,
                                fontSize: 10,
                                color: PdfColors.black,
                              ),
                            ),
                            Container(
                              decoration: const BoxDecoration(),
                              padding: const EdgeInsets.all(1),
                              child: SimplePdf.text(
                                'StringMPCO2'.tr,
                                arabicFont,
                                fontSize: 10,
                                color: PdfColors.black,
                              ),
                            ),
                            Container(
                              decoration: const BoxDecoration(),
                              padding: const EdgeInsets.all(1),
                              child: SimplePdf.text(
                                'StringSNNO'.tr,
                                arabicFont,
                                fontSize: 10,
                                color: PdfColors.black,
                              ),
                            ),
                            Container(
                              decoration: const BoxDecoration(),
                              padding: const EdgeInsets.all(1),
                              child: SimplePdf.text(
                                'StringMUID'.tr,
                                arabicFont,
                                fontSize: 10,
                                color: PdfColors.black,
                              ),
                            ),
                            Container(
                              decoration: const BoxDecoration(),
                              padding: const EdgeInsets.all(1),
                              child: SimplePdf.text(
                                'StringMINO'.tr,
                                arabicFont,
                                fontSize: 10,
                                color: PdfColors.black,
                              ),
                            ),
                            Container(
                              decoration: const BoxDecoration(),
                              padding: const EdgeInsets.all(1),
                              child: SimplePdf.text(
                                'StringMgno'.tr,
                                arabicFont,
                                fontSize: 10,
                                color: PdfColors.black,
                              ),
                            ),
                            Container(
                              decoration: const BoxDecoration(),
                              padding: const EdgeInsets.all(1),
                              child: SimplePdf.text(
                                'StringSIIDlableText'.tr,
                                arabicFont,
                                fontSize: 10,
                                color: PdfColors.black,
                              ),
                            ),
                          ],
                        ),
                      ]),
        Use_UPIN == 1 && USE_SNDE != '2'
            ? Table(
                border: pw.TableBorder.all(),
                columnWidths: {
                  0: const FlexColumnWidth(0.6),
                  1: const FlexColumnWidth(0.5),
                  2: const FlexColumnWidth(0.3),
                  3: const FlexColumnWidth(0.4),
                  4: const FlexColumnWidth(1.1),
                  5: const FlexColumnWidth(0.4),
                  6: const FlexColumnWidth(0.3),
                },
                children: List.generate(get_Sto_Num.length, (index) {
                  Sto_Num product = get_Sto_Num[index];
                  return pw.TableRow(
                    children: [
                      Container(
                        alignment: pw.Alignment.center,
                        padding: const pw.EdgeInsets.only(
                            top: 2, bottom: 2, right: 1, left: 1),
                        child: SimplePdf.text(
                            formatter.format(product.MPCO).toString(),
                            arabicFont,
                            fontSize: 10),
                      ),
                      Container(
                        alignment: pw.Alignment.center,
                        padding: const pw.EdgeInsets.only(
                            top: 2, bottom: 2, right: 1, left: 1),
                        child: SimplePdf.text(
                          product.SNED.toString(),
                          arabicFont,
                          fontSize: 10,
                          color: PdfColors.black,
                        ),
                      ),
                      Container(
                        alignment: pw.Alignment.center,
                        padding: const pw.EdgeInsets.only(
                            top: 2, bottom: 2, right: 1, left: 1),
                        child: SimplePdf.text(
                          formatter.format(product.SNNO).toString(),
                          arabicFont,
                          fontSize: 10,
                          color: PdfColors.black,
                        ),
                      ),
                      Container(
                        alignment: pw.Alignment.center,
                        padding: const pw.EdgeInsets.only(
                            top: 2, bottom: 2, right: 1, left: 1),
                        child: SimplePdf.text(
                          product.MUNA.toString(),
                          arabicFont,
                          fontSize: 10,
                          color: PdfColors.black,
                        ),
                      ),
                      Container(
                        alignment: pw.Alignment.center,
                        padding: const pw.EdgeInsets.only(
                            top: 2, bottom: 2, right: 1, left: 1),
                        child: SimplePdf.text(
                          product.MINA.toString(),
                          arabicFont,
                          fontSize: 10,
                          color: PdfColors.black,
                        ),
                      ),
                      Container(
                        alignment: pw.Alignment.center,
                        padding: const pw.EdgeInsets.only(
                            top: 2, bottom: 2, right: 1, left: 1),
                        child: SimplePdf.text(
                          product.MGNO.toString(),
                          arabicFont,
                          fontSize: 10,
                          color: PdfColors.black,
                        ),
                      ),
                      Container(
                        alignment: pw.Alignment.center,
                        padding: const pw.EdgeInsets.only(
                            top: 2, bottom: 2, right: 1, left: 1),
                        child: SimplePdf.text(
                          STO_V_N == true
                              ? 'StringAll'.tr
                              : product.SIID.toString(),
                          arabicFont,
                          fontSize: 10,
                          color: PdfColors.black,
                        ),
                      ),
                    ],
                  );
                }))
            : (Use_UPIN != 1 && USE_SNDE != '2')
                ? Table(
                    border: pw.TableBorder.all(),
                    columnWidths: {
                      0: const FlexColumnWidth(0.5),
                      1: const FlexColumnWidth(0.3),
                      2: const FlexColumnWidth(0.4),
                      3: const FlexColumnWidth(1.5),
                      4: const FlexColumnWidth(0.4),
                      5: const FlexColumnWidth(0.4),
                    },
                    children: List.generate(get_Sto_Num.length, (index) {
                      Sto_Num product = get_Sto_Num[index];
                      return pw.TableRow(
                        children: [
                          Container(
                            alignment: pw.Alignment.center,
                            padding: const pw.EdgeInsets.only(
                                top: 2, bottom: 2, right: 1, left: 1),
                            child: SimplePdf.text(
                                product.SNED.toString(), arabicFont,
                                fontSize: 10),
                          ),
                          Container(
                            alignment: pw.Alignment.center,
                            padding: const pw.EdgeInsets.only(
                                top: 2, bottom: 2, right: 1, left: 1),
                            child: SimplePdf.text(
                              formatter.format(product.SNNO).toString(),
                              arabicFont,
                              fontSize: 10,
                              color: PdfColors.black,
                            ),
                          ),
                          Container(
                            alignment: pw.Alignment.center,
                            padding: const pw.EdgeInsets.only(
                                top: 2, bottom: 2, right: 1, left: 1),
                            child: SimplePdf.text(
                              product.MUNA.toString(),
                              arabicFont,
                              fontSize: 10,
                              color: PdfColors.black,
                            ),
                          ),
                          Container(
                            alignment: pw.Alignment.center,
                            padding: const pw.EdgeInsets.only(
                                top: 2, bottom: 2, right: 1, left: 1),
                            child: SimplePdf.text(
                              product.MINA.toString(),
                              arabicFont,
                              fontSize: 10,
                              color: PdfColors.black,
                            ),
                          ),
                          Container(
                            alignment: pw.Alignment.center,
                            padding: const pw.EdgeInsets.only(
                                top: 2, bottom: 2, right: 1, left: 1),
                            child: SimplePdf.text(
                              product.MGNO.toString(),
                              arabicFont,
                              fontSize: 10,
                              color: PdfColors.black,
                            ),
                          ),
                          Container(
                            alignment: pw.Alignment.center,
                            padding: const pw.EdgeInsets.only(
                                top: 2, bottom: 2, right: 1, left: 1),
                            child: SimplePdf.text(
                              STO_V_N == true
                                  ? 'StringAll'.tr
                                  : product.SIID.toString(),
                              arabicFont,
                              fontSize: 10,
                              color: PdfColors.black,
                            ),
                          ),
                        ],
                      );
                    }))
                : (Use_UPIN != 1 && USE_SNDE == '2')
                    ? Table(
                        border: pw.TableBorder.all(),
                        columnWidths: {
                          0: const FlexColumnWidth(0.3),
                          1: const FlexColumnWidth(0.4),
                          2: const FlexColumnWidth(0.4),
                          3: const FlexColumnWidth(1.7),
                          4: const FlexColumnWidth(0.4),
                          5: const FlexColumnWidth(0.4),
                        },
                        children: List.generate(get_Sto_Num.length, (index) {
                          Sto_Num product = get_Sto_Num[index];
                          return pw.TableRow(
                            children: [
                              Container(
                                alignment: pw.Alignment.center,
                                padding: const pw.EdgeInsets.only(
                                    top: 2, bottom: 2, right: 1, left: 1),
                                child: SimplePdf.text(
                                    formatter.format(product.SNHO).toString(),
                                    arabicFont,
                                    fontSize: 10),
                              ),
                              Container(
                                alignment: pw.Alignment.center,
                                padding: const pw.EdgeInsets.only(
                                    top: 2, bottom: 2, right: 1, left: 1),
                                child: SimplePdf.text(
                                    formatter.format(product.SNNO).toString(),
                                    arabicFont,
                                    fontSize: 10),
                              ),
                              Container(
                                alignment: pw.Alignment.center,
                                padding: const pw.EdgeInsets.only(
                                    top: 2, bottom: 2, right: 1, left: 1),
                                child: SimplePdf.text(
                                  product.MUNA.toString(),
                                  arabicFont,
                                  fontSize: 10,
                                  color: PdfColors.black,
                                ),
                              ),
                              Container(
                                alignment: pw.Alignment.center,
                                padding: const pw.EdgeInsets.only(
                                    top: 2, bottom: 2, right: 1, left: 1),
                                child: SimplePdf.text(
                                  product.MINA.toString(),
                                  arabicFont,
                                  fontSize: 10,
                                  color: PdfColors.black,
                                ),
                              ),
                              Container(
                                alignment: pw.Alignment.center,
                                padding: const pw.EdgeInsets.only(
                                    top: 2, bottom: 2, right: 1, left: 1),
                                child: SimplePdf.text(
                                  product.MGNO.toString(),
                                  arabicFont,
                                  fontSize: 10,
                                  color: PdfColors.black,
                                ),
                              ),
                              Container(
                                alignment: pw.Alignment.center,
                                padding: const pw.EdgeInsets.only(
                                    top: 2, bottom: 2, right: 1, left: 1),
                                child: SimplePdf.text(
                                  STO_V_N == true
                                      ? 'StringAll'.tr
                                      : product.SIID.toString(),
                                  arabicFont,
                                  fontSize: 10,
                                  color: PdfColors.black,
                                ),
                              ),
                            ],
                          );
                        }))
                    : Table(
                        border: pw.TableBorder.all(),
                        columnWidths: {
                          0: const FlexColumnWidth(0.5),
                          1: const FlexColumnWidth(0.5),
                          2: const FlexColumnWidth(0.4),
                          3: const FlexColumnWidth(0.4),
                          4: const FlexColumnWidth(1.4),
                          5: const FlexColumnWidth(0.4),
                          6: const FlexColumnWidth(0.3),
                        },
                        children: List.generate(get_Sto_Num.length, (index) {
                          Sto_Num product = get_Sto_Num[index];
                          return pw.TableRow(
                            children: [
                              Container(
                                alignment: pw.Alignment.center,
                                padding: const pw.EdgeInsets.only(
                                    top: 2, bottom: 2, right: 1, left: 1),
                                child: SimplePdf.text(
                                    formatter
                                        .format(product.MPCO! * product.SNNO!)
                                        .toString(),
                                    arabicFont,
                                    fontSize: 10),
                              ),
                              Container(
                                alignment: pw.Alignment.center,
                                padding: const pw.EdgeInsets.only(
                                    top: 2, bottom: 2, right: 1, left: 1),
                                child: SimplePdf.text(
                                  formatter.format(product.MPCO).toString(),
                                  arabicFont,
                                  fontSize: 10,
                                  color: PdfColors.black,
                                ),
                              ),
                              Container(
                                alignment: pw.Alignment.center,
                                padding: const pw.EdgeInsets.only(
                                    top: 2, bottom: 2, right: 1, left: 1),
                                child: SimplePdf.text(
                                  formatter.format(product.SNNO).toString(),
                                  arabicFont,
                                  fontSize: 10,
                                  color: PdfColors.black,
                                ),
                              ),
                              Container(
                                alignment: pw.Alignment.center,
                                padding: const pw.EdgeInsets.only(
                                    top: 2, bottom: 2, right: 1, left: 1),
                                child: SimplePdf.text(
                                  product.MUNA.toString(),
                                  arabicFont,
                                  fontSize: 10,
                                  color: PdfColors.black,
                                ),
                              ),
                              Container(
                                alignment: pw.Alignment.center,
                                padding: const pw.EdgeInsets.only(
                                    top: 2, bottom: 2, right: 1, left: 1),
                                child: SimplePdf.text(
                                  product.MINA.toString(),
                                  arabicFont,
                                  fontSize: 10,
                                  color: PdfColors.black,
                                ),
                              ),
                              Container(
                                alignment: pw.Alignment.center,
                                padding: const pw.EdgeInsets.only(
                                    top: 2, bottom: 2, right: 1, left: 1),
                                child: SimplePdf.text(
                                  product.MGNO.toString(),
                                  arabicFont,
                                  fontSize: 10,
                                  color: PdfColors.black,
                                ),
                              ),
                              Container(
                                alignment: pw.Alignment.center,
                                padding: const pw.EdgeInsets.only(
                                    top: 2, bottom: 2, right: 1, left: 1),
                                child: SimplePdf.text(
                                  STO_V_N == true
                                      ? 'StringAll'.tr
                                      : product.SIID.toString(),
                                  arabicFont,
                                  fontSize: 10,
                                  color: PdfColors.black,
                                ),
                              ),
                            ],
                          );
                        })),
        buildSUM_Sto_Num(
            formatter.format(roundDouble(totalSNNO, 6)),
            formatter.format(roundDouble(roundedTotal2, 6)),
            itemCount,
            Use_UPIN,
            arabicFont,
            context),
      ],
      footer: (context) =>
          PdfPakage.buildFooter(context, GETSDDSA, '', GETSUNA),
    ));
    return PdfPakage.saveDocument(
        name: "${'StringInventoryQuantities'.tr}.pdf", pdf: pdf);
  }

  static Widget buildTitleSto_Num(
          String GetSINA, String GetBINA, pw.Font font, Context context) =>
      Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          pw.Divider(height: 1),
          pw.Column(children: [
            pw.Text('${'StringBIID2'.tr}$GetBINA',
                style: TextStyle(fontSize: 13.sp)),
          ]),
          SizedBox(height: 0.3 * PdfPageFormat.cm),
          // Text(dataInfo.billnote.toString()),
          // SizedBox(height: 0.8 * PdfPageFormat.cm),
        ],
      );

  static Widget buildSUM_Sto_Num(GetSUMSNNO, SUM_MPS1, int COUNT_MINO,
          int Use_UPIN, pw.Font font, Context context) =>
      Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Use_UPIN == 1
              ? Row(children: [
                  Table(border: TableBorder.all(), children: [
                    TableRow(
                      children: [
                        Container(
                          width: 165,
                          decoration: const BoxDecoration(),
                          padding: const EdgeInsets.all(1),
                          child: Column(children: [
                            SimplePdf.text(
                              "${'الاجمالي='} $SUM_MPS1",
                              font,
                              align: TextAlign.right,
                              fontSize: 11,
                              color: PdfColors.red,
                            ),
                          ]),
                        ),
                      ],
                    ),
                  ]),
                  Table(border: TableBorder.all(), children: [
                    TableRow(
                      children: [
                        Container(
                          width: 165,
                          decoration: const BoxDecoration(),
                          padding: const EdgeInsets.all(1),
                          child: Column(children: [
                            SimplePdf.text(
                              "${'اجمالي الكمية='} $GetSUMSNNO",
                              font,
                              align: TextAlign.right,
                              fontSize: 11,
                              color: PdfColors.red,
                            ),
                          ]),
                        ),
                      ],
                    ),
                  ]),
                  Table(border: TableBorder.all(), children: [
                    TableRow(
                      children: [
                        Container(
                          width: 153,
                          decoration: const BoxDecoration(),
                          padding: const EdgeInsets.all(1),
                          child: Column(children: [
                            SimplePdf.text(
                              "${'عدد الاصناف='} $COUNT_MINO",
                              font,
                              align: TextAlign.right,
                              fontSize: 11,
                              color: PdfColors.red,
                            ),
                          ]),
                        ),
                      ],
                    ),
                  ]),
                ])
              : Row(children: [
                  Table(border: TableBorder.all(), children: [
                    TableRow(
                      children: [
                        Container(
                          width: 236,
                          decoration: const BoxDecoration(),
                          padding: const EdgeInsets.all(1),
                          child: Column(children: [
                            SimplePdf.text(
                              "${'اجمالي الكمية='} $GetSUMSNNO",
                              font,
                              align: TextAlign.right,
                              fontSize: 11,
                              color: PdfColors.red,
                            ),
                          ]),
                        ),
                      ],
                    ),
                  ]),
                  Table(border: TableBorder.all(), children: [
                    TableRow(
                      children: [
                        Container(
                          width: 247,
                          decoration: const BoxDecoration(),
                          padding: const EdgeInsets.all(1),
                          child: Column(children: [
                            SimplePdf.text(
                              "${'عدد الاصناف='} $COUNT_MINO",
                              font,
                              align: TextAlign.right,
                              fontSize: 11,
                              color: PdfColors.red,
                            ),
                          ]),
                        ),
                      ],
                    ),
                  ]),
                ])
        ],
      );

  static Widget buildContentSto_Num(
      pw.Font font, String use_snde, int use_upin) {
    final formatter = intl.NumberFormat.decimalPattern();
    final headers = [
      'StrinCount_BMDAMC'.tr,
      'StringMPCO2'.tr,
      'StringSNNO'.tr,
      'StringMUID'.tr,
      'StringMINO'.tr,
      'StringMgno'.tr,
      'StringSIIDlableText'.tr,
      //  StringSIIDlableText
    ];
    final headers2 = [
      'StringMPCO2'.tr,
      'StringSMDED'.tr,
      'StringSNNO'.tr,
      'StringMUID'.tr,
      'StringMINO'.tr,
      'StringMgno'.tr,
      'StringSIIDlableText'.tr,
      //StringSIIDlableText
    ];
    final headers3 = [
      'StringSMDED'.tr,
      'StringSNNO'.tr,
      'StringMUID'.tr,
      'StringMINO'.tr,
      'StringMgno'.tr,
      'StringSIIDlableText'.tr,
      //StringSIIDlableText
    ];
    final headers4 = [
      'StringSNNO'.tr,
      'StringMUID'.tr,
      'StringMINO'.tr,
      'StringMgno'.tr,
      'StringSIIDlableText'.tr,
      //StringSIIDlableText
    ];
    return use_upin == 1 && use_snde != '2'
        ? Column(children: [
            Table(border: TableBorder.all(), columnWidths: {
              0: const FlexColumnWidth(0.6),
              1: const FlexColumnWidth(0.5),
              2: const FlexColumnWidth(0.3),
              3: const FlexColumnWidth(0.4),
              4: const FlexColumnWidth(1.1),
              5: const FlexColumnWidth(0.4),
              6: const FlexColumnWidth(0.3),
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
                      'StringMPCO2'.tr,
                      font,
                      fontSize: 10,
                      color: PdfColors.black,
                    ),
                  ),
                  Container(
                    decoration: const BoxDecoration(),
                    padding: const EdgeInsets.all(1),
                    child: SimplePdf.text(
                      'StringSMDED'.tr,
                      font,
                      fontSize: 10,
                      color: PdfColors.black,
                    ),
                  ),
                  Container(
                    decoration: const BoxDecoration(),
                    padding: const EdgeInsets.all(1),
                    child: SimplePdf.text(
                      'StringSNNO'.tr,
                      font,
                      fontSize: 10,
                      color: PdfColors.black,
                    ),
                  ),
                  Container(
                    decoration: const BoxDecoration(),
                    padding: const EdgeInsets.all(1),
                    child: SimplePdf.text(
                      'StringMUID'.tr,
                      font,
                      fontSize: 10,
                      color: PdfColors.black,
                    ),
                  ),
                  Container(
                    decoration: const BoxDecoration(),
                    padding: const EdgeInsets.all(1),
                    child: SimplePdf.text(
                      'StringMINO'.tr,
                      font,
                      fontSize: 10,
                      color: PdfColors.black,
                    ),
                  ),
                  Container(
                    decoration: const BoxDecoration(),
                    padding: const EdgeInsets.all(1),
                    child: SimplePdf.text(
                      'StringMgno'.tr,
                      font,
                      fontSize: 10,
                      color: PdfColors.black,
                    ),
                  ),
                  Container(
                    decoration: const BoxDecoration(),
                    padding: const EdgeInsets.all(1),
                    child: SimplePdf.text(
                      'StringSIIDlableText'.tr,
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
                  0: const FlexColumnWidth(0.6),
                  1: const FlexColumnWidth(0.5),
                  2: const FlexColumnWidth(0.3),
                  3: const FlexColumnWidth(0.4),
                  4: const FlexColumnWidth(1.1),
                  5: const FlexColumnWidth(0.4),
                  6: const FlexColumnWidth(0.3),
                },
                children: List.generate(get_Sto_Num.length, (index) {
                  Sto_Num product = get_Sto_Num[index];
                  return pw.TableRow(
                    children: [
                      Container(
                        alignment: pw.Alignment.center,
                        padding: const pw.EdgeInsets.only(
                            top: 2, bottom: 2, right: 1, left: 1),
                        child: SimplePdf.text(
                            formatter.format(product.MPCO).toString(), font,
                            fontSize: 10),
                      ),
                      Container(
                        alignment: pw.Alignment.center,
                        padding: const pw.EdgeInsets.only(
                            top: 2, bottom: 2, right: 1, left: 1),
                        child: SimplePdf.text(
                          product.SNED.toString(),
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
                          formatter.format(product.SNNO).toString(),
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
                          product.MUNA.toString(),
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
                          product.MINA.toString(),
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
                          product.MGNO.toString(),
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
                          product.SIID.toString(),
                          font,
                          fontSize: 10,
                          color: PdfColors.black,
                        ),
                      ),
                    ],
                  );
                })),
          ])
        : (use_upin != 1 && use_snde != '2')
            ? Column(children: [
                Table(border: TableBorder.all(), columnWidths: {
                  0: const FlexColumnWidth(0.5),
                  1: const FlexColumnWidth(0.3),
                  2: const FlexColumnWidth(0.4),
                  3: const FlexColumnWidth(1.5),
                  4: const FlexColumnWidth(0.4),
                  5: const FlexColumnWidth(0.4),
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
                          'StringSMDED'.tr,
                          font,
                          fontSize: 10,
                          color: PdfColors.black,
                        ),
                      ),
                      Container(
                        decoration: const BoxDecoration(),
                        padding: const EdgeInsets.all(1),
                        child: SimplePdf.text(
                          'StringSNNO'.tr,
                          font,
                          fontSize: 10,
                          color: PdfColors.black,
                        ),
                      ),
                      Container(
                        decoration: const BoxDecoration(),
                        padding: const EdgeInsets.all(1),
                        child: SimplePdf.text(
                          'StringMUID'.tr,
                          font,
                          fontSize: 10,
                          color: PdfColors.black,
                        ),
                      ),
                      Container(
                        decoration: const BoxDecoration(),
                        padding: const EdgeInsets.all(1),
                        child: SimplePdf.text(
                          'StringMINO'.tr,
                          font,
                          fontSize: 10,
                          color: PdfColors.black,
                        ),
                      ),
                      Container(
                        decoration: const BoxDecoration(),
                        padding: const EdgeInsets.all(1),
                        child: SimplePdf.text(
                          'StringMgno'.tr,
                          font,
                          fontSize: 10,
                          color: PdfColors.black,
                        ),
                      ),
                      Container(
                        decoration: const BoxDecoration(),
                        padding: const EdgeInsets.all(1),
                        child: SimplePdf.text(
                          'StringSIIDlableText'.tr,
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
                      0: const FlexColumnWidth(0.5),
                      1: const FlexColumnWidth(0.3),
                      2: const FlexColumnWidth(0.4),
                      3: const FlexColumnWidth(1.5),
                      4: const FlexColumnWidth(0.4),
                      5: const FlexColumnWidth(0.4),
                    },
                    children: List.generate(get_Sto_Num.length, (index) {
                      Sto_Num product = get_Sto_Num[index];
                      return pw.TableRow(
                        children: [
                          Container(
                            alignment: pw.Alignment.center,
                            padding: const pw.EdgeInsets.only(
                                top: 2, bottom: 2, right: 1, left: 1),
                            child: SimplePdf.text(product.SNED.toString(), font,
                                fontSize: 10),
                          ),
                          Container(
                            alignment: pw.Alignment.center,
                            padding: const pw.EdgeInsets.only(
                                top: 2, bottom: 2, right: 1, left: 1),
                            child: SimplePdf.text(
                              formatter.format(product.SNNO).toString(),
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
                              product.MUNA.toString(),
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
                              product.MINA.toString(),
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
                              product.MGNO.toString(),
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
                              product.SIID.toString(),
                              font,
                              fontSize: 10,
                              color: PdfColors.black,
                            ),
                          ),
                        ],
                      );
                    })),
              ])
            : (use_upin != 1 && use_snde == '2')
                ? Column(children: [
                    Table(border: TableBorder.all(), columnWidths: {
                      0: const FlexColumnWidth(0.3),
                      1: const FlexColumnWidth(0.4),
                      2: const FlexColumnWidth(1.7),
                      3: const FlexColumnWidth(0.5),
                      4: const FlexColumnWidth(0.4),
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
                              'StringSNNO'.tr,
                              font,
                              fontSize: 10,
                              color: PdfColors.black,
                            ),
                          ),
                          Container(
                            decoration: const BoxDecoration(),
                            padding: const EdgeInsets.all(1),
                            child: SimplePdf.text(
                              'StringMUID'.tr,
                              font,
                              fontSize: 10,
                              color: PdfColors.black,
                            ),
                          ),
                          Container(
                            decoration: const BoxDecoration(),
                            padding: const EdgeInsets.all(1),
                            child: SimplePdf.text(
                              'StringMINO'.tr,
                              font,
                              fontSize: 10,
                              color: PdfColors.black,
                            ),
                          ),
                          Container(
                            decoration: const BoxDecoration(),
                            padding: const EdgeInsets.all(1),
                            child: SimplePdf.text(
                              'StringMgno'.tr,
                              font,
                              fontSize: 10,
                              color: PdfColors.black,
                            ),
                          ),
                          Container(
                            decoration: const BoxDecoration(),
                            padding: const EdgeInsets.all(1),
                            child: SimplePdf.text(
                              'StringSIIDlableText'.tr,
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
                          0: const FlexColumnWidth(0.3),
                          1: const FlexColumnWidth(0.4),
                          2: const FlexColumnWidth(1.7),
                          3: const FlexColumnWidth(0.5),
                          4: const FlexColumnWidth(0.4),
                        },
                        children: List.generate(get_Sto_Num.length, (index) {
                          Sto_Num product = get_Sto_Num[index];
                          return pw.TableRow(
                            children: [
                              Container(
                                alignment: pw.Alignment.center,
                                padding: const pw.EdgeInsets.only(
                                    top: 2, bottom: 2, right: 1, left: 1),
                                child: SimplePdf.text(
                                    formatter.format(product.SNNO).toString(),
                                    font,
                                    fontSize: 10),
                              ),
                              Container(
                                alignment: pw.Alignment.center,
                                padding: const pw.EdgeInsets.only(
                                    top: 2, bottom: 2, right: 1, left: 1),
                                child: SimplePdf.text(
                                  product.MUNA.toString(),
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
                                  product.MINA.toString(),
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
                                  product.MGNO.toString(),
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
                                  product.SIID.toString(),
                                  font,
                                  fontSize: 10,
                                  color: PdfColors.black,
                                ),
                              ),
                            ],
                          );
                        })),
                  ])
                : Column(children: [
                    Table(border: TableBorder.all(), columnWidths: {
                      0: const FlexColumnWidth(0.5),
                      1: const FlexColumnWidth(0.5),
                      2: const FlexColumnWidth(0.4),
                      3: const FlexColumnWidth(0.4),
                      4: const FlexColumnWidth(1.4),
                      5: const FlexColumnWidth(0.4),
                      6: const FlexColumnWidth(0.3),
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
                              'StrinCount_BMDAMC'.tr,
                              font,
                              fontSize: 10,
                              color: PdfColors.black,
                            ),
                          ),
                          Container(
                            decoration: const BoxDecoration(),
                            padding: const EdgeInsets.all(1),
                            child: SimplePdf.text(
                              'StringMPCO2'.tr,
                              font,
                              fontSize: 10,
                              color: PdfColors.black,
                            ),
                          ),
                          Container(
                            decoration: const BoxDecoration(),
                            padding: const EdgeInsets.all(1),
                            child: SimplePdf.text(
                              'StringSNNO'.tr,
                              font,
                              fontSize: 10,
                              color: PdfColors.black,
                            ),
                          ),
                          Container(
                            decoration: const BoxDecoration(),
                            padding: const EdgeInsets.all(1),
                            child: SimplePdf.text(
                              'StringMUID'.tr,
                              font,
                              fontSize: 10,
                              color: PdfColors.black,
                            ),
                          ),
                          Container(
                            decoration: const BoxDecoration(),
                            padding: const EdgeInsets.all(1),
                            child: SimplePdf.text(
                              'StringMINO'.tr,
                              font,
                              fontSize: 10,
                              color: PdfColors.black,
                            ),
                          ),
                          Container(
                            decoration: const BoxDecoration(),
                            padding: const EdgeInsets.all(1),
                            child: SimplePdf.text(
                              'StringMgno'.tr,
                              font,
                              fontSize: 10,
                              color: PdfColors.black,
                            ),
                          ),
                          Container(
                            decoration: const BoxDecoration(),
                            padding: const EdgeInsets.all(1),
                            child: SimplePdf.text(
                              'StringSIIDlableText'.tr,
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
                          0: const FlexColumnWidth(0.5),
                          1: const FlexColumnWidth(0.5),
                          2: const FlexColumnWidth(0.4),
                          3: const FlexColumnWidth(0.4),
                          4: const FlexColumnWidth(1.4),
                          5: const FlexColumnWidth(0.4),
                          6: const FlexColumnWidth(0.3),
                        },
                        children: List.generate(get_Sto_Num.length, (index) {
                          Sto_Num product = get_Sto_Num[index];
                          return pw.TableRow(
                            children: [
                              Container(
                                alignment: pw.Alignment.center,
                                padding: const pw.EdgeInsets.only(
                                    top: 2, bottom: 2, right: 1, left: 1),
                                child: SimplePdf.text(
                                    formatter
                                        .format(product.MPCO! * product.SNNO!)
                                        .toString(),
                                    font,
                                    fontSize: 10),
                              ),
                              Container(
                                alignment: pw.Alignment.center,
                                padding: const pw.EdgeInsets.only(
                                    top: 2, bottom: 2, right: 1, left: 1),
                                child: SimplePdf.text(
                                  formatter.format(product.MPCO).toString(),
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
                                  formatter.format(product.SNNO).toString(),
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
                                  product.MUNA.toString(),
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
                                  product.MINA.toString(),
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
                                  product.MGNO.toString(),
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
                                  product.SIID.toString(),
                                  font,
                                  fontSize: 10,
                                  color: PdfColors.black,
                                ),
                              ),
                            ],
                          );
                        })),
                  ]);
  }

  static Future<File> TotalDetailedItemReport_Pdf(
      String GetBMKID,
      String GetBMKID2,
      String GetBINA_F,
      String GetBINA_T,
      String GETSDDSA,
      String GETSONA,
      String GETSONE,
      String GETSORN,
      String GETSOLN,
      String GETSUNA,
      String GetBMMDO_F,
      String GetBMMDO_T,
      double GetSUMBMDNO,
      double GetSUMBMAMT,
      List<Bil_Mov_M_Local> data) async {
    // حساب الإجماليات
    final totalIn = data.fold<double>(0.0, (sum, m) => sum + (m.BMDNO_IN ?? 0.0) + (m.BMDNF_IN ?? 0.0));
    final totalOut = data.fold<double>(0.0, (sum, m) => sum + (m.BMDNO_OUT ?? 0.0) + (m.BMDNF_OUT ?? 0.0));
    final formatter = intl.NumberFormat.decimalPattern();
    final image = await SimplePdf.loadImage();
    var arabicFont = Font.ttf(await rootBundle.load("Assets/fonts/HacenTunisia.ttf"));
    var ttf = Font.ttf(await rootBundle.load("Assets/fonts/HacenTunisia.ttf"));
    final pdf = Document();
    pdf.addPage(MultiPage(
      maxPages: 500,
      margin: pw.EdgeInsets.all(5),
      textDirection: TextDirection.rtl,
      crossAxisAlignment: CrossAxisAlignment.center,
      theme: ThemeData.withFont(base: Font.ttf(await rootBundle.load("Assets/fonts/HacenTunisia.ttf"))),
      pageFormat: PdfPageFormat.a4,
      build: (context) => [
        PdfPakage.buildHeader(GetBMKID, '', GETSONA, GETSONE, GETSORN, GETSOLN, image),
      buildTitleTotalDetailedItemReport(GetBMKID, GetBMMDO_F, GetBMMDO_T,
            GetBINA_F, GetBINA_T, arabicFont, context),

           pw.Row(children: [
             pw.Table(
               border: pw.TableBorder.all(color: PdfColors.black, width: 0.6),
               children: [
                 pw.TableRow(
                   decoration: pw.BoxDecoration(color: PdfColors.MyColors,),
                   children: [
                     pw.Container(
                       padding:GetBMKID=='101'?
                       const pw.EdgeInsets.only(left: 49,right: 48,top: 2,bottom: 2)
                           : const pw.EdgeInsets.only(left: 7,right: 7,top: 2,bottom: 2),
                       alignment: pw.Alignment.center,
                       child: SimplePdf.text('العدد المنصرف', ttf, fontSize: 11, color: PdfColors.black),
                     ),
                     pw.Container(
                       padding:GetBMKID=='101'?
                       const pw.EdgeInsets.only(left: 53,right: 53,top: 2,bottom: 2)
                           : const pw.EdgeInsets.only(left: 11,right: 10,top: 2,bottom: 2),
                       alignment: pw.Alignment.center,
                       child: SimplePdf.text('العدد المورد', ttf, fontSize: 11, color: PdfColors.black),
                     ),
                   ],
                 ),
               ],
             ),
              // pw.Container(
              //     padding: const EdgeInsets.only(left: 5),
              //     alignment: Alignment.center,
              //     decoration: BoxDecoration(
              //         color: PdfColors.MyColors,
              //         borderRadius: BorderRadius.circular(10)),
              //     child:SimplePdf.text('العدد المنصرف', ttf, fontSize: 11, color: PdfColors.black), ),
              // pw.Container(
              //     padding: const EdgeInsets.only(left: 20),
              //     alignment: Alignment.center,
              //     decoration: BoxDecoration(
              //         color: PdfColors.MyColors,
              //         borderRadius: BorderRadius.circular(10)),
              //     child:SimplePdf.text('العدد المورد', ttf, fontSize: 11, color: PdfColors.black), ),
            ]),
      pw.Table(
          border: pw.TableBorder.all(width: 0.7),
          columnWidths: {
            0: pw.FlexColumnWidth(0.5),
            1: pw.FlexColumnWidth(0.5),
            2: pw.FlexColumnWidth(0.5),
            3: pw.FlexColumnWidth(0.5),
            4: pw.FlexColumnWidth(0.5),
            5: pw.FlexColumnWidth(0.5),
            6: pw.FlexColumnWidth(0.8),
            7: pw.FlexColumnWidth(0.5),
            8: pw.FlexColumnWidth(1.5),
            9: pw.FlexColumnWidth(0.7),
            10: pw.FlexColumnWidth(1),
            11: pw.FlexColumnWidth(0.8),
          },
          children: [

            // الصف الرئيسي للعناوين
            GetBMKID=='101'? pw.TableRow(
              decoration: pw.BoxDecoration(color: PdfColors.MyColors,),
              children: [
                'مجاني',
                'كمية',
                'مجاني',
                'كمية',
                'سعر الوحدة',
                'الوحدة',
                'الصنف',
              ].map((title) => pw.Padding(
                  padding: pw.EdgeInsets.all(4),
                  child:SimplePdf.text(title, ttf, fontSize: 10, color: PdfColors.black)
              )).toList(),
            ): pw.TableRow(
              decoration: pw.BoxDecoration(color: PdfColors.MyColors,),
              children: [
                'مجاني',
                'كمية',
                'مجاني',
                'كمية',
                'سعر الوحدة',
                'الوحدة',
                'الصنف',
                'العملة',
                'العميل',
                'رقم الحركة',
                'التاريخ',
                'النوع',
              ].map((title) => pw.Padding(
                  padding: pw.EdgeInsets.all(4),
                  child:SimplePdf.text(title, ttf, fontSize: 10, color: PdfColors.black)
              )).toList(),
            ),
            // الصفوف الديناميكية للبيانات
            ...data.map((m) {
              return GetBMKID=='101'? pw.TableRow(
                children: [
                  pw.Padding(
                    padding: pw.EdgeInsets.all(2),
                    child:SimplePdf.text(formatter.format(m.BMDNF_OUT).toString(), ttf, fontSize: 8.5, color: PdfColors.black),
                  ),
                  pw.Padding(
                    padding: pw.EdgeInsets.all(2),
                    child:SimplePdf.text(formatter.format(m.BMDNO_OUT).toString(), ttf, fontSize: 8.5, color: PdfColors.black),
                  ),
                  pw.Padding(
                    padding: pw.EdgeInsets.all(2),
                    child:SimplePdf.text(formatter.format(m.BMDNF_IN).toString(), ttf, fontSize: 8.5, color: PdfColors.black),
                  ),
                  pw.Padding(
                    padding: pw.EdgeInsets.all(2),
                    child:SimplePdf.text(formatter.format(m.BMDNO_IN).toString(), ttf, fontSize: 8.5, color: PdfColors.black),
                  ),
                  pw.Padding(
                    padding: pw.EdgeInsets.all(2),
                    child:SimplePdf.text(formatter.format(m.BMDAM).toString(), ttf, fontSize: 8.5, color: PdfColors.black),
                  ),
                  pw.Padding(
                    padding: pw.EdgeInsets.all(2),
                    child:SimplePdf.text(m.MUNA_D.toString() ?? '', ttf, fontSize: 8.5, color: PdfColors.black),
                  ),
                  pw.Padding(
                    padding: pw.EdgeInsets.all(2),
                    child:SimplePdf.text(m.MINA_D.toString() ?? '', ttf, fontSize: 8.5, color: PdfColors.black),
                  ),
                ],
              ):
              pw.TableRow(
                children: [
                  pw.Padding(
                    padding: pw.EdgeInsets.all(2),
                    child:SimplePdf.text(formatter.format(m.BMDNF_OUT).toString(), ttf, fontSize: 8.5, color: PdfColors.black),
                  ),
                  pw.Padding(
                    padding: pw.EdgeInsets.all(2),
                    child:SimplePdf.text(formatter.format(m.BMDNO_OUT).toString(), ttf, fontSize: 8.5, color: PdfColors.black),
                  ),
                  pw.Padding(
                    padding: pw.EdgeInsets.all(2),
                    child:SimplePdf.text(formatter.format(m.BMDNF_IN).toString(), ttf, fontSize: 8.5, color: PdfColors.black),
                  ),
                  pw.Padding(
                    padding: pw.EdgeInsets.all(2),
                    child:SimplePdf.text(formatter.format(m.BMDNO_IN).toString(), ttf, fontSize: 8.5, color: PdfColors.black),
                  ),
                  pw.Padding(
                    padding: pw.EdgeInsets.all(2),
                    child:SimplePdf.text(formatter.format(m.BMDAM).toString(), ttf, fontSize: 8.5, color: PdfColors.black),
                  ),
                  pw.Padding(
                    padding: pw.EdgeInsets.all(2),
                    child:SimplePdf.text(m.MUNA_D.toString() ?? '', ttf, fontSize: 8.5, color: PdfColors.black),
                  ),
                  pw.Padding(
                    padding: pw.EdgeInsets.all(2),
                    child:SimplePdf.text(m.MINA_D.toString() ?? '', ttf, fontSize: 8.5, color: PdfColors.black),
                  ),
                  pw.Padding(
                    padding: pw.EdgeInsets.all(2),
                    child:SimplePdf.text(m.SCNA_D.toString() ?? '', ttf, fontSize: 8.5, color: PdfColors.black),
                  ),
                  pw.Padding(
                    padding: pw.EdgeInsets.all(2),
                    child:SimplePdf.text(m.BMMNA.toString() ?? '', ttf, fontSize: 8.5, color: PdfColors.black),
                  ),
                  pw.Padding(
                    padding: pw.EdgeInsets.all(2),
                    child:SimplePdf.text(m.BMMNO.toString(), ttf, fontSize: 8.5, color: PdfColors.black),
                  ),
                  pw.Padding(
                    padding: pw.EdgeInsets.all(2),
                    child:SimplePdf.text(m.BMMDO ?? '', ttf, fontSize: 8.5, color: PdfColors.black),
                  ),
                  pw.Padding(
                    padding: pw.EdgeInsets.all(2),
                    child:SimplePdf.text(m.BMKID_D.toString() ?? '', ttf, fontSize: 8.5, color: PdfColors.black),
                  ),
                ],
              );
            }).toList(),
          ],
      ),
        pw.SizedBox(height: 5),
        // جدول الإجمــاليــات فقط مع عمودين
        pw.Table(
          border: pw.TableBorder.all(width: 0.5),
          // columnWidths: {
          //   0: pw.FlexColumnWidth(1),
          //   1: pw.FlexColumnWidth(1),
          // },
          children: [
            // صف الرأس
            pw.TableRow(
              decoration: pw.BoxDecoration(color: PdfColors.MyColors),
              children: [
                pw.Padding(
                  padding: pw.EdgeInsets.all(6),
                  child:SimplePdf.text('العدد المنصرف', ttf, fontSize: 11, color: PdfColors.black),
                ),
                pw.Padding(
                  padding: pw.EdgeInsets.all(6),
                  child:SimplePdf.text('العدد المورد', ttf, fontSize: 11, color: PdfColors.black),
                ),
              ],
            ),
            // صف القيم
            pw.TableRow(
              children: [
                pw.Padding(
                  padding: pw.EdgeInsets.all(6),
                  child:SimplePdf.text(formatter.format(totalOut).toString(), ttf, fontSize: 11, color: PdfColors.black),
                ),
                pw.Padding(
                  padding: pw.EdgeInsets.all(6),
                  child:SimplePdf.text(formatter.format(totalIn).toString(), ttf, fontSize: 11, color: PdfColors.black),
                ),
              ],
            ),
          ],
        ),
      ],
      footer: (context) => PdfPakage.buildFooter(context, GETSDDSA, '', GETSUNA),
    ));

    return PdfPakage.saveDocument(
        name: "${'StringTotalDetailedItem'.tr}.pdf", pdf: pdf);
  }

  static Widget buildTitleTotalDetailedItemReport(
          String GetBMKID,
          String GetBMMDO_F,
          String GetBMMDO_T,
          String GetBINA_F,
          String GetBINA_T,
          pw.Font font,
          Context context) =>
      Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          pw.Divider(height: 1),
          SizedBox(height: 0.3 * PdfPageFormat.cm),
          pw.Column(children: [
            // Row(
            //   mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
            //   children: <pw.Widget>[
            //     pw.Column(children: [
            //       pw.Text(GetBMKID=='1'?'${'StringPurchases'.tr}':GetBMKID=='3'?'${'StringSale_Invoices'.tr}'
            //           :GetBMKID=='5'?'${'StringService_Bills'.tr}':'${'StringSale_Points'.tr}',
            //           style: TextStyle(fontSize: 14.sp,)),
            //     ]),
            //     pw.Column(children: [
            //       pw.Text('${'StringPKIDlableText'.tr}  $GetBMMDO_F :',
            //           style: TextStyle(fontSize: 14.sp,)),
            //     ]),
            //     pw.Column(children: [
            //       pw.Text('${'StringSCIDlableText'.tr}  $GetBMMDO_F :',
            //           style: TextStyle(fontSize: 14.sp,)),
            //     ])
            //   ],
            // ),
            GetBINA_F != 'null' && GetBINA_T != 'null'
                ? Row(
                    mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                    children: <pw.Widget>[
                      pw.Column(children: [
                        pw.Text('${'StringToBrach'.tr} : $GetBINA_F  ',
                            style: TextStyle(
                              fontSize: 14.sp,
                            )),
                      ]),
                      pw.Column(children: [
                        pw.Text('${'StringFromBrach'.tr} : $GetBINA_T ',
                            style: TextStyle(
                              fontSize: 14.sp,
                            )),
                      ])
                    ],
                  )
                : Container(),
            Row(
              mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
              children: <pw.Widget>[
                pw.Column(children: [
                  pw.Text('${'StringToDate'.tr}  $GetBMMDO_T : ',
                      style: TextStyle(
                        fontSize: 14.sp,
                      )),
                ]),
                pw.Column(children: [
                  pw.Text('${'StringFromDate'.tr}  $GetBMMDO_F :',
                      style: TextStyle(
                        fontSize: 14.sp,
                      )),
                ])
              ],
            ),
          ]),
          SizedBox(height: 0.3 * PdfPageFormat.cm),
          // Text(dataInfo.billnote.toString()),
          // SizedBox(height: 0.8 * PdfPageFormat.cm),
        ],
      );

  static Widget buildContentTotalDetailedItemReport(
      pw.Font font, GetBMKID, GetBMKID2) {
    final formatter = intl.NumberFormat.decimalPattern();
    final headers = [
      'StrinCount_BMDAMC'.tr,
      'StringMPCO2'.tr,
      'StringSNNO'.tr,
      'StringMUID'.tr,
      'StringMINO'.tr,
      // 'StringMgno'.tr,
      // 'StringSIIDlableText'.tr,
      //  StringSIIDlableText
    ];
    final headers3 = [
      'StrinCount_BMDAMC'.tr,
      'StringMPCO2'.tr,
      'StringSNNO'.tr,
      'StringMUID'.tr,
      'StringMINO'.tr,
      'StringBCID'.tr,
    ];
    final headers2 = [
      'StrinCount_BMDAMC'.tr,
      'StringSNNO'.tr,
      'StringMUID'.tr,
      'StringMINO'.tr,
    ];
    final headers4 = [
      'StrinCount_BMDAMC'.tr,
      'StringSNNO'.tr,
      'StringMUID'.tr,
      'StringMINO'.tr,
      'StringBCID'.tr,
    ];
    return Table.fromTextArray(
      headers: GetBMKID == '102' &&
              (GetBMKID2 == '3' ||
                  GetBMKID2 == '4' ||
                  GetBMKID2 == '5' ||
                  GetBMKID2 == '11' ||
                  GetBMKID2 == '12')
          ? headers3
          : GetBMKID == '102'
              ? headers
              : headers2,
      data: GetBMKID == '102' &&
              (GetBMKID2 == '3' ||
                  GetBMKID2 == '4' ||
                  GetBMKID2 == '5' ||
                  GetBMKID2 == '11' ||
                  GetBMKID2 == '12')
          ? <List<dynamic>>[
              ...Bil_Mov_D.map((Data) => [
                    formatter.format(roundDouble(
                        ((Data.BMDAM! - Data.BMDDI!) * Data.BMDNO!) +
                            Data.BMDTXT!,
                        3)),
                    formatter.format(Data.BMDAM),
                    formatter.format(Data.BMDNO! + Data.BMDNF!),
                    Data.MUNA_D,
                    Data.MINA_D,
                    Data.NAM_D,
                  ]).toList()
            ]
          : GetBMKID == '102'
              ? <List<dynamic>>[
                  ...Bil_Mov_D.map((Data) => [
                        formatter.format(roundDouble(
                            ((Data.BMDAM! - Data.BMDDI!) * Data.BMDNO!) +
                                Data.BMDTXT!,
                            3)),
                        formatter.format(Data.BMDAM),
                        formatter.format(Data.BMDNO! + Data.BMDNF!),
                        Data.MUNA_D,
                        Data.MINA_D,
                      ]).toList()
                ]
              : <List<dynamic>>[
                  ...Bil_Mov_D.map((Data) => [
                        formatter.format(roundDouble(Data.BMDAMT!, 3)),
                        formatter.format(Data.BMDNO! + Data.BMDNF!),
                        Data.MUNA_D,
                        Data.MINA_D,
                      ]).toList()
                ],
      cellStyle: pw.TextStyle(font: font, decorationColor: PdfColors.amber100),
      // border: pw.Border.all(color: PdfColors.black),
      headerStyle: TextStyle(fontWeight: FontWeight.bold, font: font),
      headerDecoration: const BoxDecoration(color: PdfColors.grey200),
      cellHeight: 30.h,
      cellAlignments: {
        0: Alignment.center,
        1: Alignment.center,
        2: Alignment.center,
        3: Alignment.center,
        4: Alignment.center,
        5: Alignment.center,
        6: Alignment.center,
      },
    );
  }

  static Widget buildSUM_TotalDetailedItemReport(double GetSUMBMDNO,
          double GetSUMBMAMT, pw.Font font, Context context) =>
      Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Row(children: [
            Table(border: TableBorder.all(), children: [
              TableRow(
                children: [
                  Container(
                    width: 241,
                    decoration: const BoxDecoration(),
                    padding: const EdgeInsets.all(1),
                    child: Column(children: [
                      SimplePdf.text(
                        "${'اجمالي='} ${GetSUMBMAMT}",
                        font,
                        align: TextAlign.right,
                        fontSize: 13,
                        color: PdfColors.red,
                      ),
                    ]),
                  ),
                ],
              ),
            ]),
            Table(border: TableBorder.all(), children: [
              TableRow(
                children: [
                  Container(
                    width: 241,
                    decoration: const BoxDecoration(),
                    padding: const EdgeInsets.all(1),
                    child: Column(children: [
                      SimplePdf.text(
                        "${'اجمالي الكمية='} $GetSUMBMDNO",
                        font,
                        align: TextAlign.right,
                        fontSize: 13,
                        color: PdfColors.red,
                      ),
                    ]),
                  ),
                ],
              ),
            ]),
          ])
        ],
      );

  static Future<File> Account_Statement_Pdf(
      String GetType,
      String GetAANO,
      String GetAANA,
      String GETDATE_F,
      String GETDATE_T,
      String GETSCNA,
      String GETBINA_F,
      String GETBINA_T,
      String GETAATL,
      String GETAAAD,
      String GETSONA,
      String GETSONE,
      String GETSORN,
      String GETSOLN,
      String GETREPTYE,
      String GETSUNA,
      String GETSSNA,
      String GETSDDDA,
      String GETSDDSA,
      String GETAMBAL,
      String GETAMBALN,
      List<Acc_Sta_D_Local> orderDetails,
      List<Bal_Acc_D_Local> orderDetails2) async {
    final image = await SimplePdf.loadImage();

    var font = Font.ttf(await rootBundle.load("Assets/fonts/HacenTunisia.ttf"));
    final pdf = Document();
    final formatter = intl.NumberFormat.decimalPattern();
    pdf.addPage(MultiPage(
      maxPages: 1000,
      textDirection: TextDirection.rtl,
      crossAxisAlignment: CrossAxisAlignment.center,
      theme: ThemeData.withFont(base: Font.ttf(await rootBundle.load("Assets/fonts/HacenTunisia.ttf"))),
      pageFormat: PdfPageFormat.a4,
      header: (context) =>StteingController().REPEAT_REP_HEADER==true? PdfPakage.buildHeader(
          GETREPTYE, '', GETSONA, GETSONE, GETSORN, GETSOLN, image):pw.Container(),
      build: (Context context) => [
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
                                padding:
                                    const pw.EdgeInsets.only(right: 8, left: 8),
                                child: Column(children: [
                                  Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        SimplePdf.text(
                                          GetAANO,
                                          font,
                                          fontSize: 13,
                                          color: PdfColors.black,
                                        ),
                                        SimplePdf.text(
                                          'اسم الحساب: $GetAANA',
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
                  SizedBox(height: 2),
                  Divider(height: 1),
                  GetType == '2'
                      ? Padding(
                          padding:
                              const EdgeInsets.only(right: 2, left: 2, top: 3),
                          child: Table(border: TableBorder.all(), children: [
                            TableRow(
                              children: [
                                Container(
                                  width: 476,
                                  padding: const pw.EdgeInsets.only(
                                      right: 8, left: 8),
                                  child: Column(children: [
                                    Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          SimplePdf.text(
                                            GETAAAD == 'null' ? '' : GETAAAD,
                                            font,
                                            fontSize: 13,
                                            color: PdfColors.black,
                                          ),
                                          SimplePdf.text(
                                            'العمله:$GETSCNA',
                                            font,
                                            fontSize: 13,
                                            color: PdfColors.black,
                                          ),
                                        ]),
                                    Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.end,
                                        children: [
                                          SimplePdf.text(
                                            GETAATL == 'null' ? '' : GETAATL,
                                            font,
                                            fontSize: 13,
                                            color: PdfColors.black,
                                          ),
                                        ]),
                                  ]),
                                ),
                              ],
                            )
                          ]))
                      : Padding(
                          padding:
                              const EdgeInsets.only(right: 2, left: 2, top: 3),
                          child: Row(children: [
                            Table(border: TableBorder.all(), children: [
                              TableRow(
                                children: [
                                  Container(
                                    width: 476,
                                    padding: const pw.EdgeInsets.only(
                                        right: 8, left: 8),
                                    child: Column(children: [
                                      Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            SimplePdf.text(
                                              'العمله:$GETSCNA',
                                              font,
                                              fontSize: 13,
                                              color: PdfColors.black,
                                            ),
                                            SimplePdf.text(
                                              '${'StringToDate_Rep'.tr} $GETDATE_T',
                                              font,
                                              fontSize: 13,
                                              color: PdfColors.black,
                                            ),
                                            SimplePdf.text(
                                              '${'StringFromDate_Rep'.tr} $GETDATE_F',
                                              font,
                                              fontSize: 13,
                                              color: PdfColors.black,
                                            ),
                                          ]),
                                      Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceAround,
                                          children: [
                                            SimplePdf.text(
                                              GETAAAD == 'null' ? '' : GETAAAD,
                                              font,
                                              fontSize: 13,
                                              color: PdfColors.black,
                                            ),
                                            SimplePdf.text(
                                              '$GETBINA_F-$GETBINA_T',
                                              font,
                                              fontSize: 13,
                                              color: PdfColors.black,
                                            ),
                                          ]),
                                      Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.end,
                                          children: [
                                            SimplePdf.text(
                                              GETAATL == 'null' ? '' : GETAATL,
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
                  SizedBox(height: 2),
                ]),
              ),
            ],
          ),
        ]),
        // buildContentAccount_Statement(font,orderDetails),
        Table(border: TableBorder.all(), columnWidths: GetType != '4'? {
          0: const FlexColumnWidth(1.2),
          1: const FlexColumnWidth(1.2),
          2: const FlexColumnWidth(1.2),
          3: const FlexColumnWidth(0.9),
          4: const FlexColumnWidth(2.5),
          5: const FlexColumnWidth(0.8),
          6: const FlexColumnWidth(1.7),
          7: const FlexColumnWidth(1),
          8: const FlexColumnWidth(0.4),
        }:{
          0: const FlexColumnWidth(1.2),
          1: const FlexColumnWidth(1.2),
          2: const FlexColumnWidth(1.2),
          3: const FlexColumnWidth(1),
          4: const FlexColumnWidth(1.7),
          5: const FlexColumnWidth(1),
          6: const FlexColumnWidth(0.4),
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
                  GetType == '4'?'StringCurrent_Balance'.tr:'الرصيد',
                  font,
                  fontSize: 8,
                  color: PdfColors.black,
                ),
              ),
              Container(
                decoration: const BoxDecoration(),
                padding: const EdgeInsets.all(1),
                child: SimplePdf.text(
                  'دائن/له',
                  font,
                  fontSize: 8,
                  color: PdfColors.black,
                ),
              ),
              Container(
                decoration: const BoxDecoration(),
                padding: const EdgeInsets.all(1),
                child: SimplePdf.text(
                  'مدين/عليه',
                  font,
                  fontSize: 8,
                  color: PdfColors.black,
                ),
              ),
              if(GetType != '4')
                Container(
                decoration: const BoxDecoration(),
                padding: const EdgeInsets.all(1),
                child: SimplePdf.text(
                  'الرقم اليدوي',
                  font,
                  fontSize: 8,
                  color: PdfColors.black,
                ),
              ),
              if(GetType != '4')
              Container(
                decoration: const BoxDecoration(),
                padding: const EdgeInsets.all(1),
                child: SimplePdf.text(
                  'تفاصيل',
                  font,
                  fontSize: 8,
                  color: PdfColors.black,
                ),
              ),
              Container(
                decoration: const BoxDecoration(),
                padding: const EdgeInsets.all(1),
                child: SimplePdf.text(
                  GetType == '4'?'StringLast_Balance_R'.tr:'الرقم',
                  font,
                  fontSize: 8,
                  color: PdfColors.black,
                ),
              ),
              Container(
                decoration: const BoxDecoration(),
                padding: const EdgeInsets.all(1),
                child: SimplePdf.text(
                  GetType == '4'?'StringAccount'.tr:'النوع',
                  font,
                  fontSize: 8,
                  color: PdfColors.black,
                ),
              ),
              Container(
                decoration: const BoxDecoration(),
                padding: const EdgeInsets.all(1),
                child: SimplePdf.text(
                  GetType == '4'?'StringAccount_NO'.tr:'التاريخ',
                  font,
                  fontSize: 8,
                  color: PdfColors.black,
                ),
              ),
              Container(
                decoration: const BoxDecoration(),
                padding: const EdgeInsets.all(1),
                child: SimplePdf.text(
                  '#',
                  font,
                  fontSize: 8,
                  color: PdfColors.black,
                ),
              ),
            ],
          ),
        ]),
        GetType == '2'
            ? Table(
                border: pw.TableBorder.all(),
                columnWidths: {
                  0: const FlexColumnWidth(1.2),
                  1: const FlexColumnWidth(1.2),
                  2: const FlexColumnWidth(1.2),
                  3: const FlexColumnWidth(0.9),
                  4: const FlexColumnWidth(2.5),
                  5: const FlexColumnWidth(0.8),
                  6: const FlexColumnWidth(1.7),
                  7: const FlexColumnWidth(1),
                  8: const FlexColumnWidth(0.4),
                },
                children: List.generate(orderDetails2.length, (index) {
                  Bal_Acc_D_Local product2 = orderDetails2[index];
                  return TableRow(
                    children: [
                      pw.Container(
                        alignment: pw.Alignment.center,
                        padding: const pw.EdgeInsets.only(
                            top: 2, bottom: 2, right: 1, left: 1),
                        child: SimplePdf.text(
                            product2.BADBA.toString() == 'null'
                                ? ''
                                : product2.BADBA.toString(),
                            font,
                            align: TextAlign.right,
                            fontSize: 7),
                      ),
                      pw.Container(
                        alignment: pw.Alignment.center,
                        padding: const pw.EdgeInsets.only(
                            top: 2, bottom: 2, right: 1, left: 1),
                        decoration: const BoxDecoration(),
                        child: SimplePdf.text(
                          product2.BADDA.toString() == 'null'
                              ? ''
                              : product2.BADDA.toString(),
                          font,
                          align: TextAlign.right,
                          fontSize: 8,
                          color: PdfColors.black,
                        ),
                      ),
                      pw.Container(
                        alignment: pw.Alignment.center,
                        decoration: const BoxDecoration(),
                        padding: const pw.EdgeInsets.only(
                            top: 2, bottom: 2, right: 1, left: 1),
                        child: SimplePdf.text(
                          product2.BADMD.toString() == 'null'
                              ? ''
                              : product2.BADMD.toString(),
                          font,
                          align: TextAlign.left,
                          fontSize: 8,
                          color: PdfColors.black,
                        ),
                      ),
                      pw.Container(
                        alignment: pw.Alignment.center,
                        decoration: const BoxDecoration(),
                        padding: const pw.EdgeInsets.only(
                            top: 2, bottom: 2, right: 1, left: 1),
                        child: SimplePdf.text(
                          product2.BADRE.toString() == 'null'
                              ? product2.AMKID.toString() == 'null'
                                  ? '---*ر.سابق*---'
                                  : ''
                              : product2.BADRE.toString(),
                          font,
                          fontSize: 6.3,
                          color: PdfColors.black,
                        ),
                      ),
                      pw.Container(
                        alignment: pw.Alignment.center,
                        decoration: const BoxDecoration(),
                        padding: const pw.EdgeInsets.only(
                            top: 2, bottom: 2, right: 1, left: 1),
                        child: SimplePdf.text(
                          product2.BADDE.toString() == 'null'
                              ? ''
                              : product2.BADDE.toString(),
                          font,
                          fontSize: 8,
                          color: PdfColors.black,
                        ),
                      ),
                      pw.Container(
                        alignment: pw.Alignment.center,
                        decoration: const BoxDecoration(),
                        padding: const pw.EdgeInsets.only(
                            top: 2, bottom: 2, right: 1, left: 1),
                        child: SimplePdf.text(
                          product2.AMMNO.toString() == 'null'
                              ? ''
                              : formatter.format(
                                  double.parse(product2.AMMNO.toString())),
                          font,
                          fontSize: 8,
                          color: PdfColors.black,
                        ),
                      ),
                      pw.Container(
                        alignment: pw.Alignment.center,
                        decoration: const BoxDecoration(),
                        padding: const pw.EdgeInsets.only(
                            top: 2, bottom: 2, right: 1, left: 1),
                        child: SimplePdf.text(
                          product2.AMKID.toString() == 'null'
                              ? ''
                              : product2.AMKNA_D.toString(),
                          font,
                          fontSize: 7,
                          color: PdfColors.black,
                        ),
                      ),
                      pw.Container(
                        alignment: pw.Alignment.center,
                        padding: const pw.EdgeInsets.only(
                            top: 2, bottom: 2, right: 1, left: 1),
                        child: SimplePdf.text(
                          product2.BADDO.toString() == 'null'
                              ? ''
                              : product2.BADDO.toString().substring(0, 11),
                          font,
                          fontSize: 8,
                          color: PdfColors.black,
                        ),
                      ),
                      pw.Container(
                        alignment: pw.Alignment.center,
                        padding: const pw.EdgeInsets.only(
                            top: 2, bottom: 2, right: 1, left: 1),
                        child: SimplePdf.text(
                          product2.BADNO.toString(),
                          font,
                          fontSize: 9,
                          color: PdfColors.black,
                        ),
                      ),
                    ],
                  );
                }))
            : Table(
                border: pw.TableBorder.all(),
                columnWidths:GetType != '4'? {
                  0: const FlexColumnWidth(1.2),
                  1: const FlexColumnWidth(1.2),
                  2: const FlexColumnWidth(1.2),
                  3: const FlexColumnWidth(0.9),
                  4: const FlexColumnWidth(2.5),
                  5: const FlexColumnWidth(0.8),
                  6: const FlexColumnWidth(1.7),
                  7: const FlexColumnWidth(1),
                  8: const FlexColumnWidth(0.4),
                }:{
                  0: const FlexColumnWidth(1.2),
                  1: const FlexColumnWidth(1.2),
                  2: const FlexColumnWidth(1.2),
                  3: const FlexColumnWidth(1),
                  4: const FlexColumnWidth(1.7),
                  5: const FlexColumnWidth(1),
                  6: const FlexColumnWidth(0.4),
                },
                children: List.generate(orderDetails.length, (index) {
                  Acc_Sta_D_Local product = orderDetails[index];
                  return TableRow(
                    children: [
                      Container(
                        alignment: pw.Alignment.center,
                        padding: const pw.EdgeInsets.only(
                            top: 2, bottom: 2, right: 1, left: 1),
                        child: SimplePdf.text(
                            GetType == '4'?
                            product.ATC4.toString() == 'null'
                                ? ''
                                : formatter.format(product.ATC4).toString()
                            :product.ATC15.toString() == 'null'
                                ? ''
                                : product.ATC15.toString(),
                            font,
                            align: TextAlign.right,
                            fontSize: 7),
                      ),
                      Container(
                        alignment: pw.Alignment.center,
                        padding: const pw.EdgeInsets.only(
                            top: 2, bottom: 2, right: 1, left: 1),
                        decoration: product.ATC28.toString() == 'TOT'
                            ? const BoxDecoration(
                                color: PdfColors.MyColors,
                              )
                            : const BoxDecoration(),
                        child: SimplePdf.text(
                          GetType == '4'?
                          product.ATC3.toString() == 'null'
                              ? ''
                              : formatter.format(product.ATC3).toString()
                              : product.ATC23.toString() == 'null'
                              ? ''
                              : product.ATC23.toString(),
                          font,
                          align: TextAlign.right,
                          fontSize: product.ATC28.toString() == 'TOT' ? 10 : 8,
                          color: PdfColors.black,
                        ),
                      ),
                      Container(
                        alignment: pw.Alignment.center,
                        decoration: product.ATC28.toString() == 'TOT'
                            ? const BoxDecoration(
                                color: PdfColors.MyColors,
                              )
                            : const BoxDecoration(),
                        padding: const pw.EdgeInsets.only(
                            top: 2, bottom: 2, right: 1, left: 1),
                        child: SimplePdf.text(
                          GetType == '4'?
                          product.ATC2.toString() == 'null'
                              ? ''
                              : formatter.format(product.ATC2).toString():
                          product.ATC22.toString() == 'null'
                              ? ''
                              : product.ATC22.toString(),
                          font,
                          align: TextAlign.left,
                          fontSize: product.ATC28.toString() == 'TOT' ? 10 : 8,
                          color: PdfColors.black,
                        ),
                      ),
                      if(GetType != '4')
                      Container(
                        alignment: pw.Alignment.center,
                        decoration: product.ATC28.toString() == 'TOT'
                            ? const BoxDecoration(
                                color: PdfColors.MyColors,
                              )
                            : const BoxDecoration(),
                        padding: const pw.EdgeInsets.only(
                            top: 2, bottom: 2, right: 1, left: 1),
                        child: SimplePdf.text(
                          product.ATC13.toString() == 'null'
                              ? ''
                              : product.ATC13.toString(),
                          font,
                          fontSize: 7,
                          color: PdfColors.black,
                        ),
                      ),
                      if(GetType != '4')
                      Container(
                        alignment: pw.Alignment.center,
                        decoration: product.ATC28.toString() == 'TOT'
                            ? const BoxDecoration(
                                color: PdfColors.MyColors,
                              )
                            : const BoxDecoration(),
                        padding: const pw.EdgeInsets.only(
                            top: 2, bottom: 2, right: 1, left: 1),
                        child: SimplePdf.text(
                          product.ATC21.toString() == 'null'
                              ? ''
                              : product.ATC21.toString(),
                          font,
                          fontSize: product.ATC28.toString() == 'TOT' ? 10 : 8,
                          color: PdfColors.black,
                        ),
                      ),
                      GetType == '4'?
                      Container(
                        alignment: pw.Alignment.center,
                        decoration: product.ATC28.toString() == 'TOT'
                            ? const BoxDecoration(
                          color: PdfColors.MyColors,
                        )
                            : const BoxDecoration(),
                        padding: const pw.EdgeInsets.only(
                            top: 2, bottom: 2, right: 1, left: 1),
                        child: SimplePdf.text(
                          product.ATC1.toString() == 'null' ? '' : formatter.format(double.parse(product.ATC1.toString())),
                          font,
                          fontSize: product.ATC28.toString() == 'TOT' ? 10 : 8,
                          color: PdfColors.black,
                        ),
                      ):
                      Container(
                        alignment: pw.Alignment.center,
                        decoration: product.ATC28.toString() == 'TOT'
                            ? const BoxDecoration(
                                color: PdfColors.MyColors,
                              )
                            : const BoxDecoration(),
                        padding: const pw.EdgeInsets.only(
                            top: 2, bottom: 2, right: 1, left: 1),
                        child: SimplePdf.text(
                          product.ATC2.toString() == 'null'
                              ? ''
                              : formatter.format(
                                  double.parse(product.ATC2.toString())),
                          font,
                          fontSize: product.ATC28.toString() == 'TOT' ? 10 : 8,
                          color: PdfColors.black,
                        ),
                      ),
                      Container(
                        alignment: pw.Alignment.center,
                        decoration: product.ATC28.toString() == 'TOT'
                            ? const BoxDecoration(
                                color: PdfColors.MyColors,
                              )
                            : const BoxDecoration(),
                        padding: const pw.EdgeInsets.only(
                            top: 2, bottom: 2, right: 1, left: 1),
                        child: SimplePdf.text(
                          product.ATC12.toString() == 'null'
                              ? ''
                              : product.ATC12.toString(),
                          font,
                          fontSize: product.ATC28.toString() == 'TOT' ? 10 : 7,
                          color: PdfColors.black,
                        ),
                      ),
                      Container(
                        alignment: pw.Alignment.center,
                        padding: const pw.EdgeInsets.only(
                            top: 2, bottom: 2, right: 1, left: 1),
                        child: SimplePdf.text(
                          product.ATC11.toString() == 'null'
                              ? ''
                              : product.ATC11.toString(),
                          font,
                          fontSize: 8,
                          color: PdfColors.black,
                        ),
                      ),
                      Container(
                        alignment: pw.Alignment.center,
                        padding: const pw.EdgeInsets.only(
                            top: 2, bottom: 2, right: 1, left: 1),
                        child: SimplePdf.text(
                          product.ATC28.toString() == 'TOT'
                              ? ''
                              : formatter.format(
                                  double.parse(product.ASDID.toString())),
                          font,
                          fontSize: 9,
                          color: PdfColors.black,
                        ),
                      ),
                    ],
                  );
                })),
        Table(border: TableBorder.all(), children: [
          TableRow(
            children: [
              Container(
                decoration: const BoxDecoration(
                  color: PdfColors.MyColors,
                ),
                width: 482,
                padding: const pw.EdgeInsets.only(right: 8, left: 8),
                child: Column(children: [
                  Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        SimplePdf.text(
                          GETAMBAL,
                          font,
                          fontSize: 12,
                          color: PdfColors.red,
                        ),
                        SimplePdf.text(
                          GETAMBALN,
                          font,
                          fontSize: 10,
                          align: TextAlign.center,
                          color: PdfColors.black,
                        ),
                        SimplePdf.text(
                          "StringCurrent_Balance".tr,
                          font,
                          fontSize: 12,
                          color: PdfColors.black,
                        ),
                      ]),
                ]),
              ),
            ],
          )
        ]),
        SizedBox(height: 3),
        Table(border: TableBorder.all(), children: [
          TableRow(
            children: [
              GetType == '2'
                  ? Container(
                      padding: const EdgeInsets.only(right: 1, left: 1),

                      /// height: 630,
                      child: Column(children: [
                        Padding(
                          padding:
                              const EdgeInsets.only(right: 2, left: 2, top: 3),
                          child: Container(
                            padding: const EdgeInsets.only(top: 2, bottom: 3),
                            child: SimplePdf.text(
                              GETSDDDA,
                              font,
                              fontSize: 9,
                              align: TextAlign.center,
                              color: PdfColors.black,
                            ),
                          ),
                        ),
                        SizedBox(height: 2),
                        Divider(height: 1),
                        Padding(
                          padding:
                              const EdgeInsets.only(right: 2, left: 2, top: 3),
                          child: Container(
                            padding: const EdgeInsets.only(top: 2, bottom: 3),
                            child: SimplePdf.text(
                              GETSDDSA,
                              font,
                              fontSize: 9,
                              align: TextAlign.center,
                              color: PdfColors.black,
                            ),
                          ),
                        ),
                        SizedBox(height: 2),
                        Divider(height: 1),
                        Padding(
                          padding:
                              const EdgeInsets.only(right: 2, left: 2, top: 3),
                          child: StteingController().SHOW_ALTER_REP == false
                              ? Container(
                                  padding:
                                      const EdgeInsets.only(top: 2, bottom: 3),
                                  child: SimplePdf.text(
                                    "Stringdetails_Sto_Num".tr,
                                    font,
                                    fontSize: 13,
                                    align: TextAlign.center,
                                    color: PdfColors.red,
                                  ),
                                )
                              : Container(),
                        ),
                        SizedBox(height: 2),
                      ]),
                    )
                  : Container(
                      padding: const EdgeInsets.only(right: 1, left: 1),

                      /// height: 630,
                      child: Column(children: [
                        Padding(
                          padding:
                              const EdgeInsets.only(right: 2, left: 2, top: 3),
                          child: Container(
                            padding: const EdgeInsets.only(top: 2, bottom: 3),
                            child: SimplePdf.text(
                              GETSDDDA,
                              font,
                              fontSize: 9,
                              align: TextAlign.center,
                              color: PdfColors.black,
                            ),
                          ),
                        ),
                        SizedBox(height: 2),
                        Divider(height: 1),
                        Padding(
                          padding:
                              const EdgeInsets.only(right: 2, left: 2, top: 3),
                          child: Container(
                            padding: const EdgeInsets.only(top: 2, bottom: 3),
                            child: SimplePdf.text(
                              GETSDDSA,
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
      footer: (context) => Column(children: [
        Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
          SimplePdf.text(
            'المستخدم: ${LoginController().SUNA}',
            font,
            fontSize: 9,
            color: PdfColors.black,
          ),
          Text('Page ${context.pageNumber}  of ${context.pagesCount}',
              style: const TextStyle(fontSize: 9)),
          SimplePdf.text(
            'تاريخ الطباعه: ${intl.DateFormat('dd-MM-yyyy HH:mm').format(DateTime.now())}',
            font,
            fontSize: 9,
            color: PdfColors.black,
          ),
        ])
      ]),
    ));

    return PdfPakage.saveDocument(name: "$GETSSNA .pdf", pdf: pdf);
  }

  static Future<File?> Customers_Balances_Pdf(
      String GETBIID_F,
      String GETBIID_T,
      String GETSCID_F,
      String GETSCID_T,
      String GETAANO_F,
      String GETAANO_T,
      String GETBCTID_F,
      String GETBCTID_T,
      String GETBCST_F,
      String GETBCST_T,
      String GETCWID_F,
      String GETCWID_T,
      String GETBAID_F,
      String GETBAID_T,
      String GETBINA,
      String GETSONA,
      String GETSONE,
      String GETSORN,
      String GETSOLN,
      String GETREPTYE,
      String GETSUNA,
      String GETSDDDA,
      String GETSDDSA,
      double GET_SUM_BACBMD,
      double GET_SUM_BACBDA,
      double GET_SUM_BACBA,
      List<Bal_Acc_C_Local> orderDetails2,
      bool SH_DA,
      bool V_TEL,
      bool V_INV_NO,
      String GRO_BY,
      String LastBAL_ACC_M) async {
    try {

      // تنظيم البيانات حسب رقم الحركة (BMMID)
      Map<String, List<Bal_Acc_C_Local>> groupedTransactions = {};

      if(GRO_BY=='1'){
        for (var transaction in orderDetails2) {
          if (!groupedTransactions.containsKey(transaction.SCID.toString())) {
            groupedTransactions[transaction.SCID.toString()] = [];
          }
          groupedTransactions[transaction.SCID.toString()]!.add(transaction);
        }
      }else{
        for (var transaction in orderDetails2) {
          if (!groupedTransactions.containsKey(transaction.AANO.toString())) {
            groupedTransactions[transaction.AANO.toString()] = [];
          }
          groupedTransactions[transaction.AANO.toString()]!.add(transaction);
        }
      }


      groupedTransactions.forEach((key, value) {
        print('SCID: $key, عدد الحركات الفرعية: ${value.length}');
      });

      print('عدد الحركات المتجمعة: ${groupedTransactions.map((key, value) => MapEntry(key, value.length))}');

      double totalBACBMD = 0;
      double totalBACBDA = 0;
      double totalBACBA = 0;
      print(V_INV_NO);
      print('V_INV_NO');
      final image = await SimplePdf.loadImage();

      var font = Font.ttf(await rootBundle.load("Assets/fonts/HacenTunisia.ttf"));
      var ttf = Font.ttf(await rootBundle.load("Assets/fonts/HacenTunisia.ttf"));
      final pdf = Document();
      final formatter = intl.NumberFormat.decimalPattern();
      pdf.addPage(MultiPage(
        margin: const EdgeInsets.all(10.5),
        maxPages: 3000,
        textDirection: TextDirection.rtl,
        crossAxisAlignment: CrossAxisAlignment.center,
        theme: ThemeData.withFont(base: Font.ttf(await rootBundle.load("Assets/fonts/HacenTunisia.ttf"))),
        pageFormat: PdfPageFormat.a4,
        header: (context) => PdfPakage.buildHeader(GETREPTYE, '', GETSONA, GETSONE, GETSORN, GETSOLN, image),
        build: (context) {
          List<pw.Widget> widgets = [];

          // عنوان الحركة الرئيسية
          widgets.add(
            Table(border: TableBorder.all(), children: [
              TableRow(
                children: [
                  Table(children: [
                    TableRow(
                      children: [
                        Container(
                          padding: const pw.EdgeInsets.only(right: 8, left: 8),
                          child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                GETSCID_F == 'null'
                                    ? Container()
                                    : SimplePdf.text(
                                  ' $GETSCID_F-$GETSCID_T',
                                  font,
                                  fontSize: 12,
                                  color: PdfColors.black,
                                ),
                                GETAANO_F == 'null'
                                    ? Container()
                                    : SimplePdf.text(
                                  ' $GETAANO_F-$GETAANO_T',
                                  font,
                                  fontSize: 12,
                                  color: PdfColors.black,
                                ),
                                GETBIID_F == 'null'
                                    ? Container()
                                    : SimplePdf.text(
                                  ' $GETBIID_F-$GETBIID_T',
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
                              children: [
                                GETBCST_F == 'null'
                                    ? Container()
                                    : SimplePdf.text(
                                  ' $GETBCST_F-$GETBCST_T',
                                  font,
                                  fontSize: 12,
                                  color: PdfColors.black,
                                ),
                                GETCWID_F == 'null'
                                    ? Container()
                                    : SimplePdf.text(
                                  ' $GETCWID_F-$GETCWID_T',
                                  font,
                                  fontSize: 12,
                                  color: PdfColors.black,
                                ),
                                GETBCTID_F == 'null'
                                    ? Container()
                                    : SimplePdf.text(
                                  ' $GETBCTID_F-$GETBCTID_T',
                                  font,
                                  fontSize: 12,
                                  color: PdfColors.black,
                                ),
                              ]),
                        ),
                      ],
                    ),
                  ]),
                ],
              ),
            ]),
          );
          // لكل مجموعة من الحركات
          // داخل حلقة لكل مجموعة من الحركات:
          groupedTransactions.entries.forEach((entry) {
            final String groupKey = entry.key;
            final List<Bal_Acc_C_Local> details = entry.value;
            final Bal_Acc_C_Local mainTransaction = details.first;

            // حساب إجماليات المجموعة لمرة واحدة:
            double groupTotalBACBMD = 0;
            double groupTotalBACBDA = 0;
            double groupTotalBACBA = 0;
            for (var detail in details) {
              groupTotalBACBMD += double.tryParse(detail.BACBMD ?? '0') ?? 0;
              groupTotalBACBDA += double.tryParse(detail.BACBDA ?? '0') ?? 0;
              groupTotalBACBA += double.tryParse(detail.BACBA ?? '0') ?? 0;
            }

            // إضافة عنوان الحركة الرئيسية للمجموعة
            widgets.add(
              pw.Column(
                crossAxisAlignment: pw.CrossAxisAlignment.start,
                children: [
                  pw.SizedBox(width: 5),
                  pw.Container(
                    padding: pw.EdgeInsets.all(8),
                    decoration: pw.BoxDecoration(
                      borderRadius: pw.BorderRadius.circular(5),
                      border: pw.Border.all(color: PdfColors.black, width: 1),
                    ),
                    child: pw.Row(
                      crossAxisAlignment: pw.CrossAxisAlignment.center,
                      mainAxisAlignment: pw.MainAxisAlignment.end,
                      children: [
                        pw.Text(
                          GRO_BY == '1'
                              ? ' ${mainTransaction.SCNA_D}'
                              : ' ${mainTransaction.BCNA_D}',
                          style: pw.TextStyle(
                            font: ttf,
                            fontSize: GRO_BY == '1' ? 18 : 15,
                            color: PdfColors.red,
                            fontWeight: pw.FontWeight.bold,
                          ),
                        ),
                        pw.SizedBox(width: 3),
                        pw.Text(
                          GRO_BY == '1' ? 'العملة:' : 'الحساب:',
                          style: pw.TextStyle(
                            font: ttf,
                            fontSize: 18,
                            color: PdfColors.black,
                            fontWeight: pw.FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                  pw.SizedBox(height: 3),
                ],
              ),
            );

            // إنشاء جدول الحركات الفرعية
            widgets.add(
              pw.Table(
                border: pw.TableBorder.all(),
                columnWidths: GRO_BY == '1'
                    ? {
                  0: V_INV_NO ? pw.FlexColumnWidth(0.5) : pw.FlexColumnWidth(0.0),
                  1: SH_DA ? pw.FlexColumnWidth(0.5) : pw.FlexColumnWidth(0.0),
                  2: const pw.FlexColumnWidth(0.5),
                  3: const pw.FlexColumnWidth(0.5),
                  4: const pw.FlexColumnWidth(0.5),
                  5: const pw.FlexColumnWidth(0.0),
                  6: const pw.FlexColumnWidth(0.8),
                  7: const pw.FlexColumnWidth(0.8),
                  8: const pw.FlexColumnWidth(0.4),
                }
                    : {
                  0: V_INV_NO ? pw.FlexColumnWidth(0.5) : pw.FlexColumnWidth(0.0),
                  1: SH_DA ? pw.FlexColumnWidth(0.5) : pw.FlexColumnWidth(0.0),
                  2: const pw.FlexColumnWidth(0.5),
                  3: const pw.FlexColumnWidth(0.5),
                  4: const pw.FlexColumnWidth(0.5),
                  5: const pw.FlexColumnWidth(0.5),
                  6: const pw.FlexColumnWidth(0.8),
                },
                children: [
                  // صف عنوان الجدول
                  pw.TableRow(
                    decoration: const pw.BoxDecoration(
                      color: PdfColors.MyColors,
                    ),
                    children: [
                      if (V_INV_NO == true)
                        SimplePdf.text(
                          'رقم اخر فاتوره',
                          font,
                          fontSize: 8,
                          color: PdfColors.black,
                        )
                      else
                        pw.Container(),
                      if (SH_DA == true)
                        SimplePdf.text(
                          'اخر سداد',
                          font,
                          fontSize: 8,
                          color: PdfColors.black,
                        )
                      else
                        pw.Container(),
                      SimplePdf.text(
                        'الرصيد',
                        font,
                        fontSize: 8,
                        color: PdfColors.black,
                      ),
                      SimplePdf.text(
                        'دائن/له',
                        font,
                        fontSize: 8,
                        color: PdfColors.black,
                      ),
                      SimplePdf.text(
                        'مدين/عليه',
                        font,
                        fontSize: 8,
                        color: PdfColors.black,
                      ),
                      GRO_BY == '2'
                          ? SimplePdf.text(
                        'العملة',
                        font,
                        fontSize: 8,
                        color: PdfColors.black,
                      )
                          : pw.Container(),
                      SimplePdf.text(
                        'العنوان',
                        font,
                        fontSize: 8,
                        color: PdfColors.black,
                      ),
                      GRO_BY == '1'
                          ? SimplePdf.text(
                        'الاسم',
                        font,
                        fontSize: 8,
                        color: PdfColors.black,
                      )
                          : pw.Container(),
                      GRO_BY == '1'
                          ? SimplePdf.text(
                        'العميل',
                        font,
                        fontSize: 8,
                        color: PdfColors.black,
                      )
                          : pw.Container(),
                    ],
                  ),

                  // صفوف الحركات الفرعية (بدون عملية الجمع داخلها)
                  ...details.map((detail) {
                    return pw.TableRow(
                      children: [
                        if (V_INV_NO == true)
                          SimplePdf.text(
                            detail.BACLBN.toString() == 'null'
                                ? ''
                                : detail.BACLBN.toString(),
                            ttf,
                            fontSize: 8,
                            color: PdfColors.black,
                          )
                        else
                          pw.Container(),
                        if (SH_DA == true)
                          SimplePdf.text(
                            detail.BACLP.toString() == 'null'
                                ? ''
                                : detail.BACLP.toString(),
                            ttf,
                            fontSize: 8,
                            color: PdfColors.black,
                          )
                        else
                          pw.Container(),
                        SimplePdf.text(
                          detail.BACBA.toString() == 'null'
                              ? '0'
                              : formatter.format(double.parse(detail.BACBA)).toString(),
                          ttf,
                          fontSize: 8,
                          color: detail.BACBA.toString() != 'null'
                              ? double.parse(detail.BACBA) < 0
                              ? PdfColors.red
                              : PdfColors.black
                              : PdfColors.black,
                        ),
                        SimplePdf.text(
                          detail.BACBDA.toString() == 'null'
                              ? '0'
                              : formatter.format(double.parse(detail.BACBDA)).toString(),
                          ttf,
                          fontSize: 8,
                          color: PdfColors.black,
                        ),
                        SimplePdf.text(
                          detail.BACBMD.toString() == 'null'
                              ? '0'
                              : formatter.format(double.parse(detail.BACBMD)).toString(),
                          ttf,
                          fontSize: 8,
                          color: PdfColors.black,
                        ),
                        GRO_BY == '2'
                            ? SimplePdf.text(
                          detail.SCNA_D.toString() == 'null'
                              ? ''
                              : detail.SCNA_D.toString(),
                          ttf,
                          fontSize: 8,
                          color: PdfColors.black,
                        )
                            : pw.Container(),
                        SimplePdf.text(
                          detail.BCAD.toString() == 'null'
                              ? ''
                              : V_TEL == true
                              ? "${detail.BCAD.toString()}-${detail.BCTL.toString() == 'null' ? '' : detail.BCTL.toString()}"
                              : "${detail.BCAD.toString()}",
                          ttf,
                          fontSize: 8,
                          color: PdfColors.black,
                        ),
                        GRO_BY == '1'
                            ? SimplePdf.text(
                          detail.BCNA_D.toString() == 'null'
                              ? ''
                              : "${detail.BCNA_D.toString()}",
                          ttf,
                          fontSize: 8,
                          color: PdfColors.black,
                        )
                            : pw.Container(),
                        GRO_BY == '1'
                            ? SimplePdf.text(
                          detail.AANO.toString(),
                          ttf,
                          fontSize: 8,
                          color: PdfColors.black,
                        )
                            : pw.Container(),
                      ],
                    );
                  }).toList(),

                  // صف الإجمالي للمجموعة
                  pw.TableRow(
                    decoration: pw.BoxDecoration(
                      color: PdfColors.grey100,
                    ),
                    children: [
                      // الأعمدة غير المستخدمة تبقى فارغة
                      if (V_INV_NO == true) pw.Container() else pw.Container(),
                      if (SH_DA == true) pw.Container() else pw.Container(),
                      // إجمالي الرصيد (BACBA)
                      SimplePdf.text(
                        formatter.format(groupTotalBACBA),
                        ttf,
                        fontSize: 11,
                        color: groupTotalBACBA < 0 ? PdfColors.red : PdfColors.black,
                      ),
                      // إجمالي الدائن/له (BACBDA)
                      SimplePdf.text(
                        formatter.format(groupTotalBACBDA),
                        ttf,
                        fontSize: 11,
                        color: PdfColors.black,
                      ),
                      // إجمالي المدين/عليه (BACBMD)
                      SimplePdf.text(
                        formatter.format(groupTotalBACBMD),
                        ttf,
                        fontSize: 11,
                        color: PdfColors.black,
                      ),
                      // بقية الأعمدة تبقى فارغة
                      GRO_BY == '2' ? pw.Container() : pw.Container(),
                      pw.Container(),
                      GRO_BY == '1' ? pw.Container() : pw.Container(),
                      GRO_BY == '1' ? pw.Container() : pw.Container(),
                    ],
                  ),
                ],
              ),
            );

            // إضافة فاصل بين المجموعات
            widgets.add(pw.SizedBox(height: 10));
          });

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
                            GETSDDSA,
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

          return widgets;

        },
        footer: (context) => Column(children: [
          Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
            SimplePdf.text(
              'المستخدم: ${LoginController().SUNA}',
              font,
              fontSize: 9,
              color: PdfColors.black,
            ),
            Text('Page ${context.pageNumber}  of ${context.pagesCount}',
                style: const TextStyle(fontSize: 9)),
            Text("${'StringlastSync'.tr} :${LastBAL_ACC_M}   ",
              style:  TextStyle(
                color: PdfColors.red,
                fontSize: 9,
              ),),
            SimplePdf.text(
              'تاريخ الطباعه: ${intl.DateFormat('dd-MM-yyyy HH:mm').format(DateTime.now())}',
              font,
              fontSize: 9,
              color: PdfColors.black,
            ),
          ])
        ]),
      ));
      return PdfPakage.saveDocument(
          name: GETREPTYE == 'Cus_Bal'
              ? ' ${'StringCus_Bal_Rep'.tr}.pdf'
              : GETREPTYE == 'Bal_Bal'
                  ? ' ${'StringSuppliers_Balances_Report'.tr}.pdf'
                  : ' ${'StringAccounts_Balances_Report'.tr}.pdf',
          pdf: pdf);
    } catch (e) {
      Fluttertoast.showToast(
          msg: e.toString(),
          toastLength: Toast.LENGTH_LONG,
          textColor: ma.Colors.white,
          backgroundColor: ma.Colors.redAccent);
      print(e.toString());
      return null;
    }
  }

  static Future<File> Total_Amount_of_Point_Pdf(
      String GETBMKID,
      String GetBMMDO_F,
      String GetBMMDO_T,
      String GetSINA,
      String GetBINA,
      String GETSUNA,
      String GetSONA) async {
    var arabicFont =
        Font.ttf(await rootBundle.load("Assets/fonts/HacenTunisia.ttf"));
    final pdf = Document();
    pdf.addPage(
      pw.Page(
        pageFormat: PdfPageFormat.roll57,
        // textDirection: LoginController().LAN==1?TextDirection.ltr:TextDirection.ltr,
        build: (pw.Context context) => pw.Column(children: [
          buildHeader(GetSONA, GETBMKID, GetBMMDO_F, GetBMMDO_T, arabicFont),
          SizedBox(height: 3),
          buildEmpExpenses(arabicFont),
          Row(
            mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
            children: <pw.Widget>[
              pw.Column(children: [
                pw.Text(
                  selectedDatereportnow,
                  style: const TextStyle(fontSize: 6, color: PdfColors.grey),
                ),
              ]),
              pw.Column(children: [
                SimplePdf.text(
                  LoginController().SUNA,
                  arabicFont,
                  fontSize: 6,
                  color: PdfColors.grey,
                ),
              ]),
            ],
          ),
        ]),
      ),
    );
    return PdfPakage.saveDocument(
        name:
            "${GETBMKID == '3' ? 'StringTotal_SalesReports'.tr : GETBMKID == '1' ? 'StringTotal_PurchasesReports'.tr : 'StringInv_Mov_Rep'.tr}($GetBMMDO_F)-($GetBMMDO_T).pdf",
        pdf: pdf);
  }

  static Future<File> Total_Amount_of_Accounts_Pdf(
      String GETAMKID,
      String GetAMMDO_F,
      String GetAMMDO_T,
      String GetSINA,
      String GetBINA,
      String GETSUNA) async {
    var arabicFont =
        Font.ttf(await rootBundle.load("Assets/fonts/HacenTunisia.ttf"));
    final pdf = Document();
    pdf.addPage(
      pw.Page(
        pageFormat: PdfPageFormat.roll57,
        // textDirection: LoginController().LAN==1?TextDirection.ltr:TextDirection.ltr,
        build: (pw.Context context) => pw.Column(children: [
          buildHeaderAccounts(GETAMKID, GetAMMDO_F, GetAMMDO_T, arabicFont),
          SizedBox(height: 3),
          buildEmpExpenses(arabicFont),
          Row(
            mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
            children: <pw.Widget>[
              pw.Column(children: [
                pw.Text(
                  selectedDatereportnow,
                  style: const TextStyle(fontSize: 6, color: PdfColors.grey),
                ),
              ]),
              pw.Column(children: [
                SimplePdf.text(
                  LoginController().SUNA,
                  arabicFont,
                  fontSize: 6,
                  color: PdfColors.grey,
                ),
              ]),
            ],
          ),
        ]),
      ),
    );
    return PdfPakage.saveDocument(
        name:
            "${'StringTotal_AccountsReports'.tr}($GetAMMDO_F)-($GetAMMDO_T).pdf",
        pdf: pdf);
  }

  static Widget buildHeader(String GetSONA, String GETBMKID, String GetBMMDO_F,
      String GetBMMDO_T, pw.Font font) {
    return Column(
      children: [
        Column(children: [
          Row(
            mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
            children: <pw.Widget>[
              Expanded(
                  child: Column(children: [
                SimplePdf.text(
                  GetSONA.toString(),
                  font,
                  fontSize: 11,
                  color: PdfColors.blue,
                ),
              ])),
            ],
          ),
          Row(
            mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
            children: <pw.Widget>[
              Expanded(
                  child: Column(children: [
                SimplePdf.text(
                  GETBMKID == '3'
                      ? 'StringTotal_SalesReports'.tr
                      : GETBMKID == '1'
                          ? 'StringTotal_PurchasesReports'.tr
                          : 'StringInv_Mov_Rep'.tr,
                  font,
                  fontSize: 9,
                  color: PdfColors.red,
                ),
                //  Text('StringInv_Mov_Rep'.tr, style: TextStyle(color: PdfColors.red, fontSize: 9)),
              ])),
            ],
          ),
          Row(
            mainAxisAlignment: pw.MainAxisAlignment.spaceEvenly,
            children: <pw.Widget>[
              pw.Column(children: [
                pw.Text(GetBMMDO_F,
                    style: TextStyle(fontSize: 6, fontWeight: FontWeight.bold)),
              ]),
              pw.Column(children: [
                pw.Text(GetBMMDO_T,
                    style: TextStyle(fontSize: 6, fontWeight: FontWeight.bold)),
              ])
            ],
          ),
          Divider(height: 3),
          Row(
            mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
            children: <pw.Widget>[
              pw.Padding(
                  padding: const EdgeInsets.only(left: 30),
                  child: pw.Column(children: [
                    pw.Text(BIF_MOV_M_List.elementAt(0).BMMNO.toString(),
                        style: TextStyle(
                            fontSize: 6, fontWeight: FontWeight.bold)),
                  ])),
              pw.Column(mainAxisAlignment: pw.MainAxisAlignment.end, children: [
                SimplePdf.text(
                  GETBMKID == '3'
                      ? 'StringSale_Invoices'.tr
                      : GETBMKID == '1'
                          ? 'StringPurchases_Invoices'.tr
                          : 'StringPOS'.tr,
                  font,
                  fontSize: 6,
                  color: PdfColors.red,
                ),
              ]),
            ],
          ),
          Row(
            mainAxisAlignment: pw.MainAxisAlignment.spaceAround,
            children: <pw.Widget>[
              pw.Column(children: [
                pw.Text(BIF_MOV_M_List.elementAt(0).MIN_BMMDO.toString(),
                    style: TextStyle(fontSize: 6, fontWeight: FontWeight.bold)),
              ]),
              pw.Column(children: [
                pw.Text("(${BIF_MOV_M_List.elementAt(0).MIN_BMMNO.toString()})",
                    style: TextStyle(fontSize: 6, fontWeight: FontWeight.bold)),
              ]),
              pw.Column(children: [
                SimplePdf.text(
                  'StringFrom_Num'.tr,
                  font,
                  fontSize: 6,
                  color: PdfColors.red,
                ),
              ]),
            ],
          ),
          Row(
            mainAxisAlignment: pw.MainAxisAlignment.spaceAround,
            children: <pw.Widget>[
              pw.Column(children: [
                pw.Text(BIF_MOV_M_List.elementAt(0).MAX_BMMDO.toString(),
                    style: TextStyle(fontSize: 6, fontWeight: FontWeight.bold)),
              ]),
              pw.Column(children: [
                pw.Text("(${BIF_MOV_M_List.elementAt(0).MAX_BMMNO.toString()})",
                    style: TextStyle(fontSize: 6, fontWeight: FontWeight.bold)),
              ]),
              pw.Column(children: [
                SimplePdf.text(
                  'StringTo_Num'.tr,
                  font,
                  fontSize: 6,
                  color: PdfColors.red,
                ),
              ]),
            ],
          ),
        ]),
      ],
    );
  }

  static Widget buildHeaderAccounts(
      String GETAMKID, String GetAMMDO_F, String GetAMMDO_T, pw.Font font) {
    return Column(
      children: [
        Column(children: [
          Row(
            mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
            children: <pw.Widget>[
              Expanded(
                  child: Column(children: [
                SimplePdf.text(
                  LoginController().JTNA,
                  font,
                  fontSize: 11,
                  color: PdfColors.blue,
                ),
              ])),
            ],
          ),
          Row(
            mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
            children: <pw.Widget>[
              Expanded(
                  child: Column(children: [
                SimplePdf.text(
                  'StringTotal_AccountsReports'.tr,
                  font,
                  fontSize: 9,
                  color: PdfColors.red,
                ),
                //  Text('StringInv_Mov_Rep'.tr, style: TextStyle(color: PdfColors.red, fontSize: 9)),
              ])),
            ],
          ),
          Row(
            mainAxisAlignment: pw.MainAxisAlignment.spaceEvenly,
            children: <pw.Widget>[
              pw.Column(children: [
                pw.Text(GetAMMDO_F,
                    style: TextStyle(fontSize: 6, fontWeight: FontWeight.bold)),
              ]),
              pw.Column(children: [
                pw.Text(GetAMMDO_T,
                    style: TextStyle(fontSize: 6, fontWeight: FontWeight.bold)),
              ])
            ],
          ),
          Divider(height: 3),
        ]),
      ],
    );
  }

  static double roundDouble(double value, int places) {
    num mod = pow(10.0, places);
    return ((value * mod).round().toDouble() / mod);
  }

  static Widget buildEmpExpenses(pw.Font font) {
    return BIL_CRE_C_List.length < 0
        ? Table(border: pw.TableBorder.all(), children: [
            TableRow(
              children: [
                pw.Container(
                  width: 10,
                  decoration: const pw.BoxDecoration(),
                  padding: const pw.EdgeInsets.all(1),
                  child: pw.Column(children: [
                    SimplePdf.text(
                      roundDouble(BIF_MOV_M_List.elementAt(0).BMMAM!, 2)
                          .toString(),
                      font,
                      align: TextAlign.right,
                      fontSize: 6,
                      color: PdfColors.black,
                    ),
                  ]),
                ),
                pw.Container(
                  width: 10,
                  decoration: const pw.BoxDecoration(),
                  padding: const pw.EdgeInsets.all(1),
                  child: pw.Column(children: [
                    SimplePdf.text(
                      'StringSUM_BMMAM'.tr,
                      font,
                      fontSize: 6,
                      align: TextAlign.right,
                      color: PdfColors.black,
                    ),
                  ]),
                ),
              ],
            ),
            TableRow(
              children: [
                pw.Container(
                  width: 100,
                  decoration: const pw.BoxDecoration(),
                  padding: const pw.EdgeInsets.all(1),
                  child: pw.Column(children: [
                    SimplePdf.text(
                      BIF_MOV_M_List.elementAt(0).BMMTX.toString(),
                      font,
                      fontSize: 6,
                      color: PdfColors.black,
                    ),
                  ]),
                ),
                pw.Container(
                  width: 100,
                  decoration: const pw.BoxDecoration(),
                  padding: const pw.EdgeInsets.all(1),
                  child: pw.Column(children: [
                    SimplePdf.text(
                      'StringSUM_BMMTX'.tr,
                      font,
                      fontSize: 6,
                      color: PdfColors.black,
                    ),
                  ]),
                ),
              ],
            ),
            TableRow(
              children: [
                pw.Container(
                  width: 100,
                  decoration: const pw.BoxDecoration(),
                  padding: const pw.EdgeInsets.all(1),
                  child: pw.Column(children: [
                    SimplePdf.text(
                      BIF_MOV_M_List.elementAt(0).SUM_BMMAM.toString(),
                      font,
                      fontSize: 6,
                      color: PdfColors.red,
                    ),
                  ]),
                ),
                pw.Container(
                  width: 100,
                  decoration: const pw.BoxDecoration(),
                  padding: const pw.EdgeInsets.all(1),
                  child: pw.Column(children: [
                    SimplePdf.text(
                      'StringSUM_ALL_BMMAM'.tr,
                      font,
                      fontSize: 6,
                      color: PdfColors.red,
                    ),
                  ]),
                ),
              ],
            ),
            TableRow(
              children: [
                pw.Container(
                  width: 100,
                  decoration: const pw.BoxDecoration(),
                  padding: const pw.EdgeInsets.all(1),
                  child: pw.Column(children: [
                    SimplePdf.text(
                      BIF_MOV_M_REP.elementAt(0).SUM_BMMAM_delayed.toString() ==
                              'null'
                          ? '0'
                          : BIF_MOV_M_REP
                              .elementAt(0)
                              .SUM_BMMAM_delayed
                              .toString(),
                      font,
                      fontSize: 6,
                      color: PdfColors.black,
                    ),
                  ]),
                ),
                pw.Container(
                  width: 100,
                  decoration: const pw.BoxDecoration(),
                  padding: const pw.EdgeInsets.all(1),
                  child: pw.Column(children: [
                    SimplePdf.text(
                      'StringSUM_BMMAM_delayed'.tr,
                      font,
                      fontSize: 6,
                      color: PdfColors.black,
                    ),
                  ]),
                ),
              ],
            ),
            pw.TableRow(
              children: [
                pw.Container(
                  width: 100,
                  decoration: const pw.BoxDecoration(),
                  padding: const pw.EdgeInsets.all(1),
                  child: pw.Column(children: [
                    SimplePdf.text(
                      BIF_MOV_M_REP2.elementAt(0).SUM_BMMAM_CASH.toString(),
                      font,
                      fontSize: 6,
                      color: PdfColors.black,
                    ),
                  ]),
                ),
                pw.Container(
                  width: 100,
                  decoration: const pw.BoxDecoration(),
                  padding: const pw.EdgeInsets.all(1),
                  child: pw.Column(children: [
                    SimplePdf.text(
                      'StringSUM_BMMAM_CASH'.tr,
                      font,
                      fontSize: 6,
                      color: PdfColors.red,
                    ),
                  ]),
                ),
              ],
            ),
          ])
        : BIL_CRE_C_List.length == 1
            ? Table(border: pw.TableBorder.all(), children: [
                pw.TableRow(
                  children: [
                    pw.Container(
                      width: 10,
                      decoration: const pw.BoxDecoration(),
                      padding: const pw.EdgeInsets.all(1),
                      child: pw.Column(children: [
                        SimplePdf.text(
                          roundDouble(BIF_MOV_M_List.elementAt(0).BMMAM!, 2)
                              .toString(),
                          font,
                          align: TextAlign.right,
                          fontSize: 6,
                          color: PdfColors.black,
                        ),
                      ]),
                    ),
                    pw.Container(
                      width: 10,
                      decoration: const pw.BoxDecoration(),
                      padding: const pw.EdgeInsets.all(1),
                      child: pw.Column(children: [
                        SimplePdf.text(
                          'StringSUM_BMMAM'.tr,
                          font,
                          fontSize: 6,
                          align: TextAlign.right,
                          color: PdfColors.black,
                        ),
                      ]),
                    ),
                  ],
                ),
                pw.TableRow(
                  children: [
                    pw.Container(
                      width: 100,
                      decoration: const pw.BoxDecoration(),
                      padding: const pw.EdgeInsets.all(1),
                      child: pw.Column(children: [
                        SimplePdf.text(
                          BIF_MOV_M_List.elementAt(0).BMMTX.toString(),
                          font,
                          fontSize: 6,
                          color: PdfColors.black,
                        ),
                      ]),
                    ),
                    pw.Container(
                      width: 100,
                      decoration: const pw.BoxDecoration(),
                      padding: const pw.EdgeInsets.all(1),
                      child: pw.Column(children: [
                        SimplePdf.text(
                          'StringSUM_BMMTX'.tr,
                          font,
                          fontSize: 6,
                          color: PdfColors.black,
                        ),
                      ]),
                    ),
                  ],
                ),
                pw.TableRow(
                  children: [
                    pw.Container(
                      width: 100,
                      decoration: const pw.BoxDecoration(),
                      padding: const pw.EdgeInsets.all(1),
                      child: pw.Column(children: [
                        SimplePdf.text(
                          BIF_MOV_M_List.elementAt(0).SUM_BMMAM.toString(),
                          font,
                          fontSize: 6,
                          color: PdfColors.red,
                        ),
                      ]),
                    ),
                    pw.Container(
                      width: 100,
                      decoration: const pw.BoxDecoration(),
                      padding: const pw.EdgeInsets.all(1),
                      child: pw.Column(children: [
                        SimplePdf.text(
                          'StringSUM_ALL_BMMAM'.tr,
                          font,
                          fontSize: 6,
                          color: PdfColors.red,
                        ),
                      ]),
                    ),
                  ],
                ),
                pw.TableRow(
                  children: [
                    pw.Container(
                      width: 100,
                      decoration: const pw.BoxDecoration(),
                      padding: const pw.EdgeInsets.all(1),
                      child: pw.Column(children: [
                        SimplePdf.text(
                          BIF_MOV_M_REP
                                      .elementAt(0)
                                      .SUM_BMMAM_delayed
                                      .toString() ==
                                  'null'
                              ? '0'
                              : BIF_MOV_M_REP
                                  .elementAt(0)
                                  .SUM_BMMAM_delayed
                                  .toString(),
                          font,
                          fontSize: 6,
                          color: PdfColors.black,
                        ),
                      ]),
                    ),
                    pw.Container(
                      width: 100,
                      decoration: const pw.BoxDecoration(),
                      padding: const pw.EdgeInsets.all(1),
                      child: pw.Column(children: [
                        SimplePdf.text(
                          'StringSUM_BMMAM_delayed'.tr,
                          font,
                          fontSize: 6,
                          color: PdfColors.black,
                        ),
                      ]),
                    ),
                  ],
                ),
                pw.TableRow(
                  children: [
                    pw.Container(
                      width: 100,
                      decoration: const pw.BoxDecoration(),
                      padding: const pw.EdgeInsets.all(1),
                      child: pw.Column(children: [
                        SimplePdf.text(
                          GET_BCCAM1_REP.elementAt(0).SUM_BCCAM1.toString(),
                          font,
                          fontSize: 6,
                          color: PdfColors.black,
                        ),
                      ]),
                    ),
                    pw.Container(
                      width: 100,
                      decoration: const pw.BoxDecoration(),
                      padding: const pw.EdgeInsets.all(1),
                      child: pw.Column(children: [
                        SimplePdf.text(
                          BIL_CRE_C_List[0].BCCNA_D.toString() == 'null'
                              ? '0'
                              : BIL_CRE_C_List[0].BCCNA_D.toString(),
                          font,
                          fontSize: 6,
                          color: PdfColors.black,
                        ),
                      ]),
                    ),
                  ],
                ),
                pw.TableRow(
                  children: [
                    pw.Container(
                      width: 100,
                      decoration: const pw.BoxDecoration(),
                      padding: const pw.EdgeInsets.all(1),
                      child: pw.Column(children: [
                        SimplePdf.text(
                          SUM_BCCID.toString(),
                          font,
                          fontSize: 6,
                          color: PdfColors.black,
                        ),
                      ]),
                    ),
                    pw.Container(
                      width: 100,
                      decoration: const pw.BoxDecoration(),
                      padding: const pw.EdgeInsets.all(1),
                      child: pw.Column(children: [
                        SimplePdf.text(
                          'StringSUM_BMCAM'.tr,
                          font,
                          fontSize: 6,
                          color: PdfColors.red,
                        ),
                      ]),
                    ),
                  ],
                ),
                pw.TableRow(
                  children: [
                    pw.Container(
                      width: 100,
                      decoration: const pw.BoxDecoration(),
                      padding: const pw.EdgeInsets.all(1),
                      child: pw.Column(children: [
                        SimplePdf.text(
                          BIF_MOV_M_REP2.elementAt(0).SUM_BMMAM_CASH.toString(),
                          font,
                          fontSize: 6,
                          color: PdfColors.black,
                        ),
                      ]),
                    ),
                    pw.Container(
                      width: 100,
                      decoration: const pw.BoxDecoration(),
                      padding: const pw.EdgeInsets.all(1),
                      child: pw.Column(children: [
                        SimplePdf.text(
                          'StringSUM_BMMAM_CASH'.tr,
                          font,
                          fontSize: 6,
                          color: PdfColors.red,
                        ),
                      ]),
                    ),
                  ],
                ),
              ])
            : BIL_CRE_C_List.length == 2
                ? Table(border: pw.TableBorder.all(), children: [
                    pw.TableRow(
                      children: [
                        pw.Container(
                          width: 10,
                          decoration: const pw.BoxDecoration(),
                          padding: const pw.EdgeInsets.all(1),
                          child: pw.Column(children: [
                            SimplePdf.text(
                              roundDouble(BIF_MOV_M_List.elementAt(0).BMMAM!, 2)
                                  .toString(),
                              font,
                              align: TextAlign.right,
                              fontSize: 6,
                              color: PdfColors.black,
                            ),
                          ]),
                        ),
                        pw.Container(
                          width: 10,
                          decoration: const pw.BoxDecoration(),
                          padding: const pw.EdgeInsets.all(1),
                          child: pw.Column(children: [
                            SimplePdf.text(
                              'StringSUM_BMMAM'.tr,
                              font,
                              fontSize: 6,
                              align: TextAlign.right,
                              color: PdfColors.black,
                            ),
                          ]),
                        ),
                      ],
                    ),
                    pw.TableRow(
                      children: [
                        pw.Container(
                          width: 100,
                          decoration: const pw.BoxDecoration(),
                          padding: const pw.EdgeInsets.all(1),
                          child: pw.Column(children: [
                            SimplePdf.text(
                              BIF_MOV_M_List.elementAt(0).BMMTX.toString(),
                              font,
                              fontSize: 6,
                              color: PdfColors.black,
                            ),
                          ]),
                        ),
                        pw.Container(
                          width: 100,
                          decoration: const pw.BoxDecoration(),
                          padding: const pw.EdgeInsets.all(1),
                          child: pw.Column(children: [
                            SimplePdf.text(
                              'StringSUM_BMMTX'.tr,
                              font,
                              fontSize: 6,
                              color: PdfColors.black,
                            ),
                          ]),
                        ),
                      ],
                    ),
                    pw.TableRow(
                      children: [
                        pw.Container(
                          width: 100,
                          decoration: const pw.BoxDecoration(),
                          padding: const pw.EdgeInsets.all(1),
                          child: pw.Column(children: [
                            SimplePdf.text(
                              BIF_MOV_M_List.elementAt(0).SUM_BMMAM.toString(),
                              font,
                              fontSize: 6,
                              color: PdfColors.red,
                            ),
                          ]),
                        ),
                        pw.Container(
                          width: 100,
                          decoration: const pw.BoxDecoration(),
                          padding: const pw.EdgeInsets.all(1),
                          child: pw.Column(children: [
                            SimplePdf.text(
                              'StringSUM_ALL_BMMAM'.tr,
                              font,
                              fontSize: 6,
                              color: PdfColors.red,
                            ),
                          ]),
                        ),
                      ],
                    ),
                    pw.TableRow(
                      children: [
                        pw.Container(
                          width: 100,
                          decoration: const pw.BoxDecoration(),
                          padding: const pw.EdgeInsets.all(1),
                          child: pw.Column(children: [
                            SimplePdf.text(
                              BIF_MOV_M_REP
                                          .elementAt(0)
                                          .SUM_BMMAM_delayed
                                          .toString() ==
                                      'null'
                                  ? '0'
                                  : BIF_MOV_M_REP
                                      .elementAt(0)
                                      .SUM_BMMAM_delayed
                                      .toString(),
                              font,
                              fontSize: 6,
                              color: PdfColors.black,
                            ),
                          ]),
                        ),
                        pw.Container(
                          width: 100,
                          decoration: const pw.BoxDecoration(),
                          padding: const pw.EdgeInsets.all(1),
                          child: pw.Column(children: [
                            SimplePdf.text(
                              'StringSUM_BMMAM_delayed'.tr,
                              font,
                              fontSize: 6,
                              color: PdfColors.black,
                            ),
                          ]),
                        ),
                      ],
                    ),
                    pw.TableRow(
                      children: [
                        pw.Container(
                          width: 100,
                          decoration: const pw.BoxDecoration(),
                          padding: const pw.EdgeInsets.all(1),
                          child: pw.Column(children: [
                            SimplePdf.text(
                              GET_BCCAM1_REP.elementAt(0).SUM_BCCAM1.toString(),
                              font,
                              fontSize: 6,
                              color: PdfColors.black,
                            ),
                          ]),
                        ),
                        pw.Container(
                          width: 100,
                          decoration: const pw.BoxDecoration(),
                          padding: const pw.EdgeInsets.all(1),
                          child: pw.Column(children: [
                            SimplePdf.text(
                              BIL_CRE_C_List[0].BCCNA_D.toString() == 'null'
                                  ? '0'
                                  : BIL_CRE_C_List[0].BCCNA_D.toString(),
                              font,
                              fontSize: 6,
                              color: PdfColors.black,
                            ),
                          ]),
                        ),
                      ],
                    ),
                    pw.TableRow(
                      children: [
                        pw.Container(
                          width: 100,
                          decoration: const pw.BoxDecoration(),
                          padding: const pw.EdgeInsets.all(1),
                          child: pw.Column(children: [
                            SimplePdf.text(
                              GET_BCCAM2_REP.elementAt(0).SUM_BCCAM2.toString(),
                              font,
                              fontSize: 6,
                              color: PdfColors.black,
                            ),
                          ]),
                        ),
                        pw.Container(
                          width: 100,
                          decoration: const pw.BoxDecoration(),
                          padding: const pw.EdgeInsets.all(1),
                          child: pw.Column(children: [
                            SimplePdf.text(
                              BIL_CRE_C_List[1].BCCNA_D.toString() == 'null'
                                  ? '0'
                                  : BIL_CRE_C_List[1].BCCNA_D.toString(),
                              font,
                              fontSize: 6,
                              color: PdfColors.black,
                            ),
                          ]),
                        ),
                      ],
                    ),
                    pw.TableRow(
                      children: [
                        pw.Container(
                          width: 100,
                          decoration: const pw.BoxDecoration(),
                          padding: const pw.EdgeInsets.all(1),
                          child: pw.Column(children: [
                            SimplePdf.text(
                              SUM_BCCID.toString(),
                              font,
                              fontSize: 6,
                              color: PdfColors.black,
                            ),
                          ]),
                        ),
                        pw.Container(
                          width: 100,
                          decoration: const pw.BoxDecoration(),
                          padding: const pw.EdgeInsets.all(1),
                          child: pw.Column(children: [
                            SimplePdf.text(
                              'StringSUM_BMCAM'.tr,
                              font,
                              fontSize: 6,
                              color: PdfColors.red,
                            ),
                          ]),
                        ),
                      ],
                    ),
                    pw.TableRow(
                      children: [
                        pw.Container(
                          width: 100,
                          decoration: const pw.BoxDecoration(),
                          padding: const pw.EdgeInsets.all(1),
                          child: pw.Column(children: [
                            SimplePdf.text(
                              BIF_MOV_M_REP2
                                  .elementAt(0)
                                  .SUM_BMMAM_CASH
                                  .toString(),
                              font,
                              fontSize: 6,
                              color: PdfColors.black,
                            ),
                          ]),
                        ),
                        pw.Container(
                          width: 100,
                          decoration: const pw.BoxDecoration(),
                          padding: const pw.EdgeInsets.all(1),
                          child: pw.Column(children: [
                            SimplePdf.text(
                              'StringSUM_BMMAM_CASH'.tr,
                              font,
                              fontSize: 6,
                              color: PdfColors.red,
                            ),
                          ]),
                        ),
                      ],
                    ),
                  ])
                : Table(border: pw.TableBorder.all(), children: [
                    pw.TableRow(
                      children: [
                        pw.Container(
                          width: 10,
                          decoration: const pw.BoxDecoration(),
                          padding: const pw.EdgeInsets.all(1),
                          child: pw.Column(children: [
                            SimplePdf.text(
                              roundDouble(BIF_MOV_M_List.elementAt(0).BMMAM!, 2)
                                  .toString(),
                              font,
                              align: TextAlign.right,
                              fontSize: 6,
                              color: PdfColors.black,
                            ),
                          ]),
                        ),
                        pw.Container(
                          width: 10,
                          decoration: const pw.BoxDecoration(),
                          padding: const pw.EdgeInsets.all(1),
                          child: pw.Column(children: [
                            SimplePdf.text(
                              'StringSUM_BMMAM'.tr,
                              font,
                              fontSize: 6,
                              align: TextAlign.right,
                              color: PdfColors.black,
                            ),
                          ]),
                        ),
                      ],
                    ),
                    pw.TableRow(
                      children: [
                        pw.Container(
                          width: 100,
                          decoration: const pw.BoxDecoration(),
                          padding: const pw.EdgeInsets.all(1),
                          child: pw.Column(children: [
                            SimplePdf.text(
                              BIF_MOV_M_List.elementAt(0).BMMTX.toString(),
                              font,
                              fontSize: 6,
                              color: PdfColors.black,
                            ),
                          ]),
                        ),
                        pw.Container(
                          width: 100,
                          decoration: const pw.BoxDecoration(),
                          padding: const pw.EdgeInsets.all(1),
                          child: pw.Column(children: [
                            SimplePdf.text(
                              'StringSUM_BMMTX'.tr,
                              font,
                              fontSize: 6,
                              color: PdfColors.black,
                            ),
                          ]),
                        ),
                      ],
                    ),
                    pw.TableRow(
                      children: [
                        pw.Container(
                          width: 100,
                          decoration: const pw.BoxDecoration(),
                          padding: const pw.EdgeInsets.all(1),
                          child: pw.Column(children: [
                            SimplePdf.text(
                                roundDouble(
                                        BIF_MOV_M_List.elementAt(0).SUM_BMMAM!,
                                        2)
                                    .toString(),
                                font,
                                fontSize: 6,
                                color: PdfColors.red),
                          ]),
                        ),
                        pw.Container(
                          width: 100,
                          decoration: const pw.BoxDecoration(),
                          padding: const pw.EdgeInsets.all(1),
                          child: pw.Column(children: [
                            SimplePdf.text(
                              'StringSUM_ALL_BMMAM'.tr,
                              font,
                              fontSize: 6,
                              color: PdfColors.red,
                            ),
                          ]),
                        ),
                      ],
                    ),
                    pw.TableRow(
                      children: [
                        pw.Container(
                          width: 100,
                          decoration: const pw.BoxDecoration(),
                          padding: const pw.EdgeInsets.all(1),
                          child: pw.Column(children: [
                            SimplePdf.text(
                              BIF_MOV_M_REP
                                          .elementAt(0)
                                          .SUM_BMMAM_delayed
                                          .toString() ==
                                      'null'
                                  ? '0'
                                  : BIF_MOV_M_REP
                                      .elementAt(0)
                                      .SUM_BMMAM_delayed
                                      .toString(),
                              font,
                              fontSize: 6,
                              color: PdfColors.black,
                            ),
                          ]),
                        ),
                        pw.Container(
                          width: 100,
                          decoration: const pw.BoxDecoration(),
                          padding: const pw.EdgeInsets.all(1),
                          child: pw.Column(children: [
                            SimplePdf.text(
                              'StringSUM_BMMAM_delayed'.tr,
                              font,
                              fontSize: 6,
                              color: PdfColors.black,
                            ),
                          ]),
                        ),
                      ],
                    ),
                    BIL_CRE_C_List.length > 0
                        ? pw.TableRow(
                            children: [
                              pw.Container(
                                width: 100,
                                decoration: const pw.BoxDecoration(),
                                padding: const pw.EdgeInsets.all(1),
                                child: pw.Column(children: [
                                  SimplePdf.text(
                                    GET_BCCAM1_REP
                                        .elementAt(0)
                                        .SUM_BCCAM1
                                        .toString(),
                                    font,
                                    fontSize: 6,
                                    color: PdfColors.black,
                                  ),
                                ]),
                              ),
                              pw.Container(
                                width: 100,
                                decoration: const pw.BoxDecoration(),
                                padding: const pw.EdgeInsets.all(1),
                                child: pw.Column(children: [
                                  SimplePdf.text(
                                    BIL_CRE_C_List[0].BCCNA_D.toString() ==
                                            'null'
                                        ? '0'
                                        : BIL_CRE_C_List[0].BCCNA_D.toString(),
                                    font,
                                    fontSize: 6,
                                    color: PdfColors.black,
                                  ),
                                ]),
                              ),
                            ],
                          )
                        : pw.TableRow(children: []),
                    BIL_CRE_C_List.length > 0
                        ? pw.TableRow(
                            children: [
                              pw.Container(
                                width: 100,
                                decoration: const pw.BoxDecoration(),
                                padding: const pw.EdgeInsets.all(1),
                                child: pw.Column(children: [
                                  SimplePdf.text(
                                    GET_BCCAM2_REP
                                        .elementAt(0)
                                        .SUM_BCCAM2
                                        .toString(),
                                    font,
                                    fontSize: 6,
                                    color: PdfColors.black,
                                  ),
                                ]),
                              ),
                              pw.Container(
                                width: 100,
                                decoration: const pw.BoxDecoration(),
                                padding: const pw.EdgeInsets.all(1),
                                child: pw.Column(children: [
                                  SimplePdf.text(
                                    BIL_CRE_C_List[1].BCCNA_D.toString() ==
                                            'null'
                                        ? '0'
                                        : BIL_CRE_C_List[1].BCCNA_D.toString(),
                                    font,
                                    fontSize: 6,
                                    color: PdfColors.black,
                                  ),
                                ]),
                              ),
                            ],
                          )
                        : pw.TableRow(children: []),
                    BIL_CRE_C_List.length > 0
                        ? pw.TableRow(
                            children: [
                              pw.Container(
                                width: 100,
                                decoration: const pw.BoxDecoration(),
                                padding: const pw.EdgeInsets.all(1),
                                child: pw.Column(children: [
                                  SimplePdf.text(
                                    GET_BCCAM3_REP
                                        .elementAt(0)
                                        .SUM_BCCAM3
                                        .toString(),
                                    font,
                                    fontSize: 6,
                                    color: PdfColors.black,
                                  ),
                                ]),
                              ),
                              pw.Container(
                                width: 100,
                                decoration: const pw.BoxDecoration(),
                                padding: const pw.EdgeInsets.all(1),
                                child: pw.Column(children: [
                                  SimplePdf.text(
                                    BIL_CRE_C_List[2].BCCNA_D.toString() ==
                                            'null'
                                        ? '0'
                                        : BIL_CRE_C_List[2].BCCNA_D.toString(),
                                    font,
                                    fontSize: 6,
                                    color: PdfColors.black,
                                  ),
                                ]),
                              ),
                            ],
                          )
                        : pw.TableRow(children: []),
                    pw.TableRow(
                      children: [
                        pw.Container(
                          width: 100,
                          decoration: const pw.BoxDecoration(),
                          padding: const pw.EdgeInsets.all(1),
                          child: pw.Column(children: [
                            SimplePdf.text(
                              SUM_BCCID.toString(),
                              font,
                              fontSize: 6,
                              color: PdfColors.black,
                            ),
                          ]),
                        ),
                        pw.Container(
                          width: 100,
                          decoration: const pw.BoxDecoration(),
                          padding: const pw.EdgeInsets.all(1),
                          child: pw.Column(children: [
                            SimplePdf.text(
                              'StringSUM_BMCAM'.tr,
                              font,
                              fontSize: 6,
                              color: PdfColors.red,
                            ),
                          ]),
                        ),
                      ],
                    ),
                    pw.TableRow(
                      children: [
                        pw.Container(
                          width: 100,
                          decoration: const pw.BoxDecoration(),
                          padding: const pw.EdgeInsets.all(1),
                          child: pw.Column(children: [
                            SimplePdf.text(
                              BIF_MOV_M_REP2
                                  .elementAt(0)
                                  .SUM_BMMAM_CASH
                                  .toString(),
                              font,
                              fontSize: 6,
                              color: PdfColors.black,
                            ),
                          ]),
                        ),
                        pw.Container(
                          width: 100,
                          decoration: const pw.BoxDecoration(),
                          padding: const pw.EdgeInsets.all(1),
                          child: pw.Column(children: [
                            SimplePdf.text(
                              'StringSUM_BMMAM_CASH'.tr,
                              font,
                              fontSize: 6,
                              color: PdfColors.red,
                            ),
                          ]),
                        ),
                      ],
                    ),
                    // pw.TableRow(
                    //   children: [
                    //     pw.Container(
                    //       width: 100,
                    //       decoration: pw.BoxDecoration(),
                    //       padding: pw.EdgeInsets.all(1),
                    //       child: pw.Column(children: [
                    //         SimplePdf.text(
                    //           '0',
                    //           font,
                    //           fontSize: 6,
                    //           color: PdfColors.black,
                    //         ),
                    //       ]),
                    //     ),
                    //     pw.Container(
                    //       width: 100,
                    //       decoration: pw.BoxDecoration(),
                    //       padding: pw.EdgeInsets.all(1),
                    //       child: pw.Column(children: [
                    //         SimplePdf.text(
                    //           'خصومات صافي النقديه',
                    //           font, fontSize: 6,
                    //           color: PdfColors.black,
                    //         ),
                    //       ]),
                    //     ),
                    //   ],
                    // ),
                    // pw.TableRow(
                    //   children: [
                    //     pw.Container(
                    //       width: 100,
                    //       decoration: pw.BoxDecoration(),
                    //       padding: pw.EdgeInsets.all(1),
                    //       child: pw.Column(children: [
                    //         SimplePdf.text(
                    //           '0',
                    //           font,
                    //           fontSize: 6,
                    //           color: PdfColors.black,
                    //         ),
                    //       ]),
                    //     ),
                    //     pw.Container(
                    //       width: 100,
                    //       decoration: pw.BoxDecoration(),
                    //       padding: pw.EdgeInsets.all(1),
                    //       child: pw.Column(children: [
                    //         SimplePdf.text(
                    //           'مبلغ العمولة صافي النقديه',
                    //           font, fontSize: 6,
                    //           color: PdfColors.black,
                    //         ),
                    //       ]),
                    //     ),
                    //   ],
                    // ),
                    // pw.TableRow(
                    //   children: [
                    //     pw.Container(
                    //       width: 100,
                    //       decoration: pw.BoxDecoration(),
                    //       padding: pw.EdgeInsets.all(1),
                    //       child: pw.Column(children: [
                    //         SimplePdf.text(
                    //           '0',
                    //           font,
                    //           fontSize: 6,
                    //           color: PdfColors.black,
                    //         ),
                    //       ]),
                    //     ),
                    //     pw.Container(
                    //       width: 100,
                    //       decoration: pw.BoxDecoration(),
                    //       padding: pw.EdgeInsets.all(1),
                    //       child: pw.Column(children: [
                    //         SimplePdf.text(
                    //           'صافي النقديه-خصومات صافي النقديه',
                    //           font, fontSize: 6,
                    //           color: PdfColors.red,
                    //         ),
                    //       ]),
                    //     ),
                    //   ],
                    // ),
                    // Now the next table row
                  ]);
  }

  static buildText({
    required String title,
    required String value,
    double width = double.infinity,
    TextStyle? titleStyle,
    bool unite = false,
  }) {
    final style = titleStyle ?? TextStyle(fontWeight: FontWeight.bold);
    return Container(
      width: width,
      child: Row(
        children: [
          Expanded(child: Text(title, style: style)),
          Text(value, style: unite ? style : null),
        ],
      ),
    );
  }

  static Future<File?> Daily_Treasury_Pdf(
      String GETBIID_F,
      String GETBIID_T,
      String GETDATE_F,
      String GETDATE_T,
      String GETSCID_F,
      String GETACID_D,
      double GET_ACC_MOV_D_TOT_REP_List,
      double Last_Balance,
      bool Show_Last_Balance,
      String GETSONA,
      String GETSONE,
      String GETSORN,
      String GETSOLN,
      String GETREPTYE,
      String GETSUNA,
      String GETSDDDA,
      String GETSDDSA) async {
    try {
      final image = await SimplePdf.loadImage();

      var font =
          Font.ttf(await rootBundle.load("Assets/fonts/HacenTunisia.ttf"));
      final pdf = Document();
      final formatter = intl.NumberFormat.decimalPattern();
      pdf.addPage(MultiPage(
        margin: const EdgeInsets.all(10.5),
        maxPages: 3000,
        textDirection: TextDirection.rtl,
        crossAxisAlignment: CrossAxisAlignment.center,
        theme: ThemeData.withFont(
            base: Font.ttf(
                await rootBundle.load("Assets/fonts/HacenTunisia.ttf"))),
        pageFormat: PdfPageFormat.a4,
        header: (context) => PdfPakage.buildHeader(
            GETREPTYE, '', GETSONA, GETSONE, GETSORN, GETSOLN, image),
        build: (Context context) => [
          Table(border: TableBorder.all(), children: [
            TableRow(
              children: [
                Table(children: [
                  TableRow(
                    children: [
                      Container(
                        padding: const pw.EdgeInsets.only(right: 8, left: 8),
                        child: Column(children: [
                          Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                SimplePdf.text(
                                  '${'StringBIID_TlableText'.tr} : ${GETBIID_T}',
                                  font,
                                  fontSize: 12,
                                  color: PdfColors.black,
                                ),
                                SimplePdf.text(
                                  '${'StringBIID_FlableText'.tr} : ${GETBIID_F}',
                                  font,
                                  fontSize: 12,
                                  color: PdfColors.black,
                                ),
                              ]),
                          Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                SimplePdf.text(
                                  '${'StringToDate_Rep'.tr} ${GETDATE_T}',
                                  font,
                                  fontSize: 12,
                                  color: PdfColors.black,
                                ),
                                SimplePdf.text(
                                  '${'StringFromDate'.tr}  ${GETDATE_F} :',
                                  font,
                                  fontSize: 12,
                                  color: PdfColors.black,
                                ),
                              ]),
                          Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                SimplePdf.text(
                                  '${'StringSCIDlableText'.tr} : ${GETSCID_F}',
                                  font,
                                  fontSize: 12,
                                  color: PdfColors.black,
                                ),
                                SimplePdf.text(
                                  '${'StringACIDlableText'.tr} : ${GETACID_D}',
                                  font,
                                  fontSize: 12,
                                  color: PdfColors.black,
                                ),
                              ])
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
            1: const FlexColumnWidth(0.8),
            2: const FlexColumnWidth(0.8),
            3: const FlexColumnWidth(0.8),
            4: const FlexColumnWidth(1.6),
            5: const FlexColumnWidth(1),
            6: const FlexColumnWidth(0.8),
            7: const FlexColumnWidth(0.4),
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
                    'StringSMDED2'.tr,
                    font,
                    fontSize: 10,
                    color: PdfColors.black,
                  ),
                ),
                Container(
                  decoration: const BoxDecoration(),
                  padding: const EdgeInsets.all(1),
                  child: SimplePdf.text(
                    'StringBAL_ACC'.tr,
                    font,
                    fontSize: 10,
                    color: PdfColors.black,
                  ),
                ),
                Container(
                  decoration: const BoxDecoration(),
                  padding: const EdgeInsets.all(1),
                  child: SimplePdf.text(
                    'StringAMDDA'.tr,
                    font,
                    fontSize: 10,
                    color: PdfColors.black,
                  ),
                ),
                Container(
                  decoration: const BoxDecoration(),
                  padding: const EdgeInsets.all(1),
                  child: SimplePdf.text(
                    'StringAMDMD'.tr,
                    font,
                    fontSize: 10,
                    color: PdfColors.black,
                  ),
                ),
                Container(
                  decoration: const BoxDecoration(),
                  padding: const EdgeInsets.all(1),
                  child: SimplePdf.text(
                    'StringAccount'.tr,
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
                Container(
                  decoration: const BoxDecoration(),
                  padding: const EdgeInsets.all(1),
                  child: SimplePdf.text(
                    'StringBMMNO'.tr,
                    font,
                    fontSize: 10,
                    color: PdfColors.black,
                  ),
                ),
                Container(
                  decoration: const BoxDecoration(),
                  padding: const EdgeInsets.all(1),
                  child: SimplePdf.text(
                    'StringSMMID'.tr,
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
                1: const FlexColumnWidth(0.8),
                2: const FlexColumnWidth(0.8),
                3: const FlexColumnWidth(0.8),
                4: const FlexColumnWidth(1.6),
                5: const FlexColumnWidth(1),
                6: const FlexColumnWidth(0.8),
                7: const FlexColumnWidth(0.4),
              },
              children: List.generate(BIF_MOV_M_CUS_List.length, (index) {
                Bil_Mov_M_Local product2 = BIF_MOV_M_CUS_List[index];
                return TableRow(
                  children: [
                    Container(
                      alignment: pw.Alignment.center,
                      padding: const pw.EdgeInsets.only(
                          top: 2, bottom: 2, right: 1, left: 1),
                      child: SimplePdf.text(
                          product2.BMMDO.toString() == 'null'
                              ? ''
                              : product2.BMMDO.toString(),
                          font,
                          align: TextAlign.right,
                          fontSize: 9),
                    ),
                    Container(
                      alignment: pw.Alignment.center,
                      decoration: const BoxDecoration(),
                      child: SimplePdf.text(
                        product2.BAL.toString() == 'null'
                            ? '0'
                            : formatter
                                .format(double.parse(product2.BAL.toString()))
                                .toString(),
                        font,
                        align: TextAlign.right,
                        fontSize: 10,
                        color: PdfColors.black,
                      ),
                    ),
                    Container(
                      alignment: pw.Alignment.center,
                      decoration: const BoxDecoration(),
                      padding: const pw.EdgeInsets.only(
                          top: 2, bottom: 2, right: 1, left: 1),
                      child: SimplePdf.text(
                        product2.DA.toString() == 'null'
                            ? '0'
                            : formatter
                                .format(double.parse(product2.DA.toString()))
                                .toString(),
                        font,
                        align: TextAlign.left,
                        fontSize: 10,
                        color: PdfColors.black,
                      ),
                    ),
                    Container(
                      alignment: pw.Alignment.center,
                      decoration: const BoxDecoration(),
                      padding: const pw.EdgeInsets.only(
                          top: 2, bottom: 2, right: 1, left: 1),
                      child: SimplePdf.text(
                        product2.MD.toString() == 'null'
                            ? '0'
                            : formatter
                                .format(double.parse(product2.MD.toString()))
                                .toString(),
                        font,
                        fontSize: 10,
                        color: PdfColors.black,
                      ),
                    ),
                    Container(
                      alignment: pw.Alignment.center,
                      decoration: const BoxDecoration(),
                      padding: const pw.EdgeInsets.only(
                          top: 2, bottom: 2, right: 1, left: 1),
                      child: SimplePdf.text(
                        product2.BMMNA.toString(),
                        font,
                        fontSize: 10,
                        color: PdfColors.black,
                      ),
                    ),
                    Container(
                      alignment: pw.Alignment.center,
                      decoration: const BoxDecoration(),
                      padding: const pw.EdgeInsets.only(
                          top: 2, bottom: 2, right: 1, left: 1),
                      child: SimplePdf.text(
                        product2.IDTYP_D.toString(),
                        font,
                        fontSize: 10,
                        color: PdfColors.black,
                      ),
                    ),
                    Container(
                      alignment: pw.Alignment.center,
                      decoration: const BoxDecoration(),
                      padding: const pw.EdgeInsets.only(
                          top: 2, bottom: 2, right: 1, left: 1),
                      child: SimplePdf.text(
                        product2.BMMNO.toString(),
                        font,
                        fontSize: 10,
                        color: PdfColors.black,
                      ),
                    ),
                    Container(
                      alignment: pw.Alignment.center,
                      decoration: const BoxDecoration(),
                      padding: const pw.EdgeInsets.only(
                          top: 2, bottom: 2, right: 1, left: 1),
                      child: SimplePdf.text(
                        product2.BMMID.toString(),
                        font,
                        fontSize: 10,
                        color: PdfColors.black,
                      ),
                    ),
                  ],
                );
              })),

          //الاجمالي للصندوق حسب كل نوع
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
                                'الاجمالي للصندوق حسب كل نوع',
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
            3: const FlexColumnWidth(1.8),
            4: const FlexColumnWidth(2),
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
                    'StringBAL_ACC'.tr,
                    font,
                    fontSize: 10,
                    color: PdfColors.black,
                  ),
                ),
                Container(
                  decoration: const BoxDecoration(),
                  padding: const EdgeInsets.all(1),
                  child: SimplePdf.text(
                    'StringAMDDA'.tr,
                    font,
                    fontSize: 10,
                    color: PdfColors.black,
                  ),
                ),
                Container(
                  decoration: const BoxDecoration(),
                  padding: const EdgeInsets.all(1),
                  child: SimplePdf.text(
                    'StringAMDMD'.tr,
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
                Container(
                  decoration: const BoxDecoration(),
                  padding: const EdgeInsets.all(1),
                  child: SimplePdf.text(
                    'StringACIDlableText'.tr,
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
                3: const FlexColumnWidth(1.8),
                4: const FlexColumnWidth(2),
              },
              children:
                  List.generate(GET_ACC_MOV_D_SUM_REP_List.length, (index) {
                Bil_Mov_M_Local GET_ACC_MOV_D_SUM_List =
                    GET_ACC_MOV_D_SUM_REP_List[index];
                return TableRow(
                  children: [
                    Container(
                      alignment: pw.Alignment.center,
                      padding: const pw.EdgeInsets.only(
                          top: 2, bottom: 2, right: 1, left: 1),
                      decoration: const BoxDecoration(),
                      child: SimplePdf.text(
                        GET_ACC_MOV_D_SUM_List.BAL.toString() == 'null'
                            ? '0'
                            : formatter
                                .format(double.parse(
                                    GET_ACC_MOV_D_SUM_List.BAL.toString()))
                                .toString(),
                        font,
                        align: TextAlign.right,
                        fontSize: 10,
                        color: PdfColors.black,
                      ),
                    ),
                    Container(
                      alignment: pw.Alignment.center,
                      decoration: const BoxDecoration(),
                      padding: const pw.EdgeInsets.only(
                          top: 2, bottom: 2, right: 1, left: 1),
                      child: SimplePdf.text(
                        GET_ACC_MOV_D_SUM_List.DA.toString() == 'null'
                            ? '0'
                            : formatter
                                .format(double.parse(
                                    GET_ACC_MOV_D_SUM_List.DA.toString()))
                                .toString(),
                        font,
                        align: TextAlign.left,
                        fontSize: 10,
                        color: PdfColors.black,
                      ),
                    ),
                    Container(
                      alignment: pw.Alignment.center,
                      decoration: const BoxDecoration(),
                      padding: const pw.EdgeInsets.only(
                          top: 2, bottom: 2, right: 1, left: 1),
                      child: SimplePdf.text(
                        GET_ACC_MOV_D_SUM_List.MD.toString() == 'null'
                            ? '0'
                            : formatter
                                .format(double.parse(
                                    GET_ACC_MOV_D_SUM_List.MD.toString()))
                                .toString(),
                        font,
                        fontSize: 10,
                        color: PdfColors.black,
                      ),
                    ),
                    Container(
                      alignment: pw.Alignment.center,
                      decoration: const BoxDecoration(),
                      padding: const pw.EdgeInsets.only(
                          top: 2, bottom: 2, right: 1, left: 1),
                      child: SimplePdf.text(
                        GET_ACC_MOV_D_SUM_List.IDTYP_D.toString(),
                        font,
                        fontSize: 10,
                        color: PdfColors.black,
                      ),
                    ),
                    Container(
                      alignment: pw.Alignment.center,
                      decoration: const BoxDecoration(),
                      padding: const pw.EdgeInsets.only(
                          top: 2, bottom: 2, right: 1, left: 1),
                      child: SimplePdf.text(
                        GET_ACC_MOV_D_SUM_List.ACNA_D.toString(),
                        font,
                        fontSize: 10,
                        color: PdfColors.black,
                      ),
                    ),
                  ],
                );
              })),
          SizedBox(height: 8),
          Show_Last_Balance == true
              ? Table(border: TableBorder.all(), columnWidths: {
                  0: const FlexColumnWidth(1.2),
                  1: const FlexColumnWidth(1.2),
                  2: const FlexColumnWidth(1.2),
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
                          'StringFinalBalance'.tr,
                          font,
                          fontSize: 10,
                          color: PdfColors.black,
                        ),
                      ),
                      Container(
                        decoration: const BoxDecoration(),
                        padding: const EdgeInsets.all(1),
                        child: SimplePdf.text(
                          'StringBalanceDuringPeriod'.tr,
                          font,
                          fontSize: 10,
                          color: PdfColors.black,
                        ),
                      ),
                      Container(
                        decoration: const BoxDecoration(),
                        padding: const EdgeInsets.all(1),
                        child: SimplePdf.text(
                          'StringLast_Balance'.tr,
                          font,
                          fontSize: 11,
                          color: PdfColors.black,
                        ),
                      ),
                    ],
                  ),
                ])
              : Table(border: TableBorder.all(), columnWidths: {
                  0: const FlexColumnWidth(1.2),
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
                          'StringBalanceDuringPeriod'.tr,
                          font,
                          fontSize: 10,
                          color: PdfColors.black,
                        ),
                      ),
                    ],
                  ),
                ]),
          Show_Last_Balance == true
              ? Table(border: TableBorder.all(), columnWidths: {
                  0: const FlexColumnWidth(1.2),
                  1: const FlexColumnWidth(1.2),
                  2: const FlexColumnWidth(1.2),
                }, children: [
                  TableRow(
                    children: [
                      Container(
                        decoration: const BoxDecoration(),
                        padding: const EdgeInsets.all(1),
                        child: SimplePdf.text(
                          "${formatter.format(double.parse(GET_ACC_MOV_D_TOT_REP_List.toString()) + double.parse(Last_Balance.toString()))}",
                          font,
                          fontSize: 12,
                          color: PdfColors.black,
                        ),
                      ),
                      Container(
                        decoration: const BoxDecoration(),
                        padding: const EdgeInsets.all(1),
                        child: SimplePdf.text(
                          "${formatter.format(GET_ACC_MOV_D_TOT_REP_List).toString()}",
                          font,
                          fontSize: 12,
                          color: PdfColors.black,
                        ),
                      ),
                      Container(
                        decoration: const BoxDecoration(),
                        padding: const EdgeInsets.all(1),
                        child: SimplePdf.text(
                          "${formatter.format(Last_Balance).toString()}",
                          font,
                          fontSize: 12,
                          color: PdfColors.black,
                        ),
                      ),
                    ],
                  ),
                ])
              : Table(border: TableBorder.all(), columnWidths: {
                  0: const FlexColumnWidth(1.2),
                  1: const FlexColumnWidth(1.2),
                  2: const FlexColumnWidth(1.2),
                }, children: [
                  TableRow(
                    children: [
                      Container(
                        decoration: const BoxDecoration(),
                        padding: const EdgeInsets.all(1),
                        child: SimplePdf.text(
                          "${formatter.format(GET_ACC_MOV_D_TOT_REP_List).toString()}",
                          font,
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
                  padding: const EdgeInsets.only(right: 1, left: 1),

                  /// height: 630,
                  child: Column(children: [
                    Padding(
                      padding: const EdgeInsets.only(right: 2, left: 2, top: 3),
                      child: Container(
                        padding: const EdgeInsets.only(top: 2, bottom: 3),
                        child: SimplePdf.text(
                          GETSDDDA,
                          font,
                          fontSize: 9,
                          align: TextAlign.center,
                          color: PdfColors.black,
                        ),
                      ),
                    ),
                    SizedBox(height: 2),
                    Divider(height: 1),
                    Padding(
                      padding: const EdgeInsets.only(right: 2, left: 2, top: 3),
                      child: Container(
                        padding: const EdgeInsets.only(top: 2, bottom: 3),
                        child: SimplePdf.text(
                          GETSDDSA,
                          font,
                          fontSize: 9,
                          align: TextAlign.center,
                          color: PdfColors.black,
                        ),
                      ),
                    ),
                    SizedBox(height: 2),
                    Divider(height: 1),
                    Padding(
                      padding: const EdgeInsets.only(right: 2, left: 2, top: 3),
                      child: Container(
                        padding: const EdgeInsets.only(top: 2, bottom: 3),
                        child: SimplePdf.text(
                          "StringDataPreliminaryNotFinal".tr,
                          font,
                          fontSize: 11,
                          align: TextAlign.center,
                          color: PdfColors.red,
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
        footer: (context) => Column(children: [
          Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
            SimplePdf.text(
              'المستخدم: ${LoginController().SUNA}',
              font,
              fontSize: 9,
              color: PdfColors.black,
            ),
            Text('Page ${context.pageNumber}  of ${context.pagesCount}',
                style: const TextStyle(fontSize: 9)),
            SimplePdf.text(
              'تاريخ الطباعه: ${intl.DateFormat('dd-MM-yyyy HH:mm').format(DateTime.now())}',
              font,
              fontSize: 9,
              color: PdfColors.black,
            ),
          ])
        ]),
      ));
      return PdfPakage.saveDocument(
          name: GETREPTYE == 'Cus_Bal'
              ? ' ${'StringCus_Bal_Rep'.tr}.pdf'
              : GETREPTYE == 'Bal_Bal'
                  ? ' ${'StringSuppliers_Balances_Report'.tr}.pdf'
                  : GETREPTYE == 'Cus_Acc_Bal'
                      ? ' ${'StringDaily_Treasury_Report'.tr}.pdf'
                      : ' ${'StringAccounts_Balances_Report'.tr}.pdf',
          pdf: pdf);
    } catch (e) {
      Fluttertoast.showToast(
          msg: e.toString(),
          toastLength: Toast.LENGTH_LONG,
          textColor: ma.Colors.white,
          backgroundColor: ma.Colors.redAccent);
      print(e.toString());
      return null;
    }
  }

  static Future<File> Total_Approve_of_Pdf(
    String GetBMMDO_F,
    String GetBMMDO_T,
    String GetSINA,
    String GetBINA,
    String GETSUNA,
    String GETSDDSA,
    String GETSONA,
    String GETSONE,
    String GETSORN,
    String GETSOLN,
  ) async {
    final image = await SimplePdf.loadImage();

    var arabicFont =
        Font.ttf(await rootBundle.load("Assets/fonts/HacenTunisia.ttf"));
    final pdf = Document();
    pdf.addPage(MultiPage(
      maxPages: 500,
      textDirection: TextDirection.rtl,
      crossAxisAlignment: CrossAxisAlignment.center,
      theme: ThemeData.withFont(
          base:
              Font.ttf(await rootBundle.load("Assets/fonts/HacenTunisia.ttf"))),
      pageFormat: PdfPageFormat.standard,
      header: (context) => PdfPakage.buildHeader(
          'Approving', '', GETSONA, GETSONE, GETSORN, GETSOLN, image),
      build: (context) => [
        SizedBox(height: 10),
        // buildTitleTreasuryVouchers(GetBINA, GetAMMDO,GetAMMAM,GetAMMID,GetSCNA,GETPKID_NAME, arabicFont, context,converter),
        buildApprove(arabicFont),
        //buildSUM_Sto_Num(GetSUMSNNO, arabicFont, context),
        //Divider(),
        // buildTotal(expensesDataInfo,arabicFont),
      ],
      footer: (context) =>
          PdfPakage.buildFooter(context, GETSDDSA, '', GETSUNA),
    ));
    return PdfPakage.saveDocument(
        name: "${'StringApprovingReports'.tr}.pdf", pdf: pdf);
  }

  static Widget buildApprove(pw.Font font) {
    final headers = [
      'StrinlChice_item_Total'.tr,
      'StringReadAfter'.tr,
      'StringReadBefore'.tr,
      'StringCIMIDlableText'.tr,
      'StringCTMIDlableText'.tr,
      'StringPdf_SMMNO'.tr
    ];
    double roundDouble(double value, int places) {
      num mod = pow(10.0, places);
      return ((value * mod).round().toDouble() / mod);
    }

    return Table.fromTextArray(
      headers: headers,
      // data:data,
      data: <List<dynamic>>[
        ...BIF_COU_C_List.map((Data) => [
              Data.BCMAMSUM.toString().contains('.0')
                  ? Data.BCMAMSUM!.round().toString()
                  : Data.BCMAMSUM,
              Data.BCMRN.toString().contains('.0')
                  ? Data.BCMRN!.round().toString()
                  : Data.BCMRN,
              Data.BCMRO.toString().contains('.0')
                  ? Data.BCMRO!.round().toString()
                  : Data.BCMRO,
              Data.CIMNA_D,
              Data.CTMNA_D,
              Data.BCMID,
            ]).toList()
      ],
      cellStyle: pw.TextStyle(
        font: font,
        decorationColor: PdfColors.amber100,
      ),
      headerStyle: TextStyle(fontWeight: FontWeight.bold, font: font),
      headerDecoration: BoxDecoration(color: PdfColors.grey200),
      cellHeight: 30.h,
      cellAlignments: {
        0: Alignment.center,
        1: Alignment.center,
        2: Alignment.center,
        3: Alignment.center,
        4: Alignment.center,
        5: Alignment.center,
      },
    );
  }

  static Future<File> Total_Amount_of_Counter_Point_Pdf(
    String GetBMMDO_F,
    String GetBMMDO_T,
    String GetSINA,
    String GetBINA,
    String GETSUNA,
    String GETSONA,
  ) async {
    try{
    final image = await SimplePdf.loadImage();

    var arabicFont = Font.ttf(await rootBundle.load("Assets/fonts/HacenTunisia.ttf"));
    final pdf = Document();
    pdf.addPage(
      pw.Page(
        pageFormat: PdfPageFormat.roll57,
        // textDirection: LoginController().LAN==1?TextDirection.ltr:TextDirection.ltr,
        build: (pw.Context context) => pw.Column(children: [
          buildHeader(GETSONA, '11', GetBMMDO_F, GetBMMDO_T, arabicFont),
          // Divider(height: 15),
          SizedBox(height: 3),
          buildEmpExpenses(arabicFont),
          Row(
            mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
            children: <pw.Widget>[
              pw.Column(children: [
                pw.Text(
                  selectedDatereportnow,
                  style: TextStyle(fontSize: 6, color: PdfColors.grey),
                ),
              ]),
              pw.Column(children: [
                SimplePdf.text(
                  LoginController().SUNA,
                  arabicFont,
                  fontSize: 6,
                  color: PdfColors.grey,
                ),
              ]),
            ],
          ),
        ]),
      ),
    );
    // pdf.addPage(
    //     MultiPage(
    //   textDirection: TextDirection.rtl,
    //   theme: ThemeData.withFont(base: Font.ttf(await rootBundle.load("Assets/fonts/HacenTunisia.ttf"))),
    //    pageFormat: PdfPageFormat.roll57,
    //   build: (context) => [
    //   //  buildHeader(GetBMMDO_F, GetBMMDO_T),
    //   //  buildTitle(GetBMMDO_F, GetBMMDO_T, GetSINA, GetBINA, arabicFont, context),
    //     buildEmpExpenses(arabicFont),
    //   ],
    // ));
    return PdfPakage.saveDocument(
        name: "${'StringInv_Mov_Rep'.tr}($GetBMMDO_F)-($GetBMMDO_T).pdf",
        pdf: pdf);
  }catch(e){
      print(e);
      return File('path');
      
    }
  }
}
