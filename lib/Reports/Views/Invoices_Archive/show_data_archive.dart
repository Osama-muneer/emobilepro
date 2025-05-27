import 'dart:async';
import '../../../Operation/models/bil_mov_m.dart';
import '../../../Reports/controllers/invoices_archive_controller.dart';
import '../../../database/report_db.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:syncfusion_flutter_core/theme.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';


class Show_DataGrid_archive extends StatefulWidget {
  @override
  _DataGridPageState createState() => _DataGridPageState();
}

class _DataGridPageState extends State<Show_DataGrid_archive> {
  final Invoices_ArchiveController controller = Get.find();
  Future<ProductDataGridSource> getProductDataSource() async {
    var productList = await  GET_BIL_MOV_REP(controller.SelectDataFromBIID!,controller.SelectDataToBIID!,controller.SelectFromDays!,
        controller.SelectToDays!, controller.SelectDataSCID.toString(),controller.PKID.toString(),controller.SelectFromDATEI.toString(),
        controller.SelectToDATEI.toString(),controller.TYPE_T,
        controller.TYPE_ORD2);

    controller.totalBmmam=0;
    controller.totalBmmtx=0;
    controller.totalBmmmt=0;
    controller.totalBmmdi=0;
    controller.totalBmmdif=0;

    // حساب المجاميع
    for (var product in productList) {
      controller.totalBmmam += product.BMMAM!;
      controller.totalBmmtx += product.BMMTX!;
      controller.totalBmmdi += product.BMMDI!;
      controller.totalBmmmt += product.BMMMT!;
      controller.totalBmmdif += product.BMMDIF!;
    }

    return ProductDataGridSource(productList);
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<Invoices_ArchiveController>(
        init: Invoices_ArchiveController(),
        builder: ((value)=> FutureBuilder(
      future: getProductDataSource(),
      builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
        return snapshot.hasData
            ? SfDataGridTheme(
              data: SfDataGridThemeData(
                headerColor: const Color(0xFFECEFF0),
              ),
              child: SfDataGrid(
                allowSwiping: false,
                allowSorting: true,
                columnWidthMode: ColumnWidthMode.fill,
                source: snapshot.data,
                columns: getColumns(),
              ),
            )
            : const Center(
          child: CircularProgressIndicator(
            strokeWidth: 5,
          ),
        );
      },
    )));
  }


  List<GridColumn> getColumns() {
    return <GridColumn>[
      // GridColumn(
      //     columnName: 'PRINT',
      //     columnWidthMode: ColumnWidthMode.auto,
      //     width:  double.nan,
      //     label: Container(
      //         alignment: Alignment.center,
      //         child:  Text(
      //             'StringPrint'.tr,style: const TextStyle(fontFamily: 'Hacen')
      //         ))),
      GridColumn(
          columnName: 'BINA_D',
          columnWidthMode: ColumnWidthMode.auto,
          width:  double.nan,
          label: Container(
              alignment: Alignment.center,
              child:  Text(
                  'StringBIID'.tr,style: const TextStyle(fontFamily: 'Hacen')
              ))),
      GridColumn(
          columnName: 'BMKID',
          columnWidthMode: ColumnWidthMode.auto,
          width:  140,
          label: Container(
              alignment: Alignment.center,
              child:  Text(
                  'StringType'.tr,style: const TextStyle(fontFamily: 'Hacen')
              ))),
      GridColumn(
          columnName: 'BMMNO',
          width:  double.nan,
          columnWidthMode: ColumnWidthMode.auto,
          label: Container(
              alignment: Alignment.center,
              child:  Text(
                'StringSMMID'.tr, style: const TextStyle(fontFamily: 'Hacen'),
              ))),
      GridColumn(
          columnName: 'BMMRE',
          width:  double.nan,
          columnWidthMode: ColumnWidthMode.auto,
          label: Container(
              alignment: Alignment.center,
              child:  Text(
                'StringBMMNO'.tr, style: const TextStyle(fontFamily: 'Hacen'),
              ))),
      GridColumn(
          columnName: 'BMMDO',
          columnWidthMode: ColumnWidthMode.auto,
          width:  double.nan,
          label: Container(
              alignment: Alignment.center,
              child:  Text(
                  'StringSMDED2'.tr,style: const TextStyle(fontFamily: 'Hacen')
              ))),
      GridColumn(
          columnName: 'SCNA_D',
          columnWidthMode: ColumnWidthMode.auto,
          width:  double.nan,
          label: Container(
              alignment: Alignment.center,
              child:  Text(
                  'StringSCIDlableText'.tr,style: const TextStyle(fontFamily: 'Hacen')
              ))),
      GridColumn(
          columnName: 'BMMAM',
          columnWidthMode: ColumnWidthMode.auto,
          width:  double.nan,
          label: Container(
              alignment: Alignment.center,
              child:  Text(
                  'StringAmount'.tr,style: const TextStyle(fontFamily: 'Hacen')
              ))),
      GridColumn(
          columnName: 'BMMDI',
          columnWidthMode: ColumnWidthMode.auto,
          width:  double.nan,
          label: Container(
              alignment: Alignment.center,
              child:  Text(
                  'StringDiscount'.tr,style: const TextStyle(fontFamily: 'Hacen')
              ))),
      GridColumn(
          columnName: 'BMMTX',
          columnWidthMode: ColumnWidthMode.auto,
          width:  double.nan,
          label: Container(
              alignment: Alignment.center,
              child:  Text(
                  'StringSUM_BMMTX'.tr,style: const TextStyle(fontFamily: 'Hacen')
              ))),
      GridColumn(
          columnName: 'BMMDIF',
          columnWidthMode: ColumnWidthMode.auto,
          width:  double.nan,
          label: Container(
              alignment: Alignment.center,
              child:  Text(
                  'StringBMMDIF_T'.tr,style: const TextStyle(fontFamily: 'Hacen')
              ))),
      GridColumn(
          columnName: 'BMMMT',
          columnWidthMode: ColumnWidthMode.auto,
          width:  double.nan,
          label: Container(
              alignment: Alignment.center,
              child:  Text(
                  'StrinBCMAM'.tr,style: const TextStyle(fontFamily: 'Hacen')
              ))),
      GridColumn(
          columnName: 'BMMNA',
          columnWidthMode: ColumnWidthMode.auto,
          width:  double.nan,
          label: Container(
              alignment: Alignment.center,
              child:  Text(
                  'StringBMMNA'.tr,style: const TextStyle(fontFamily: 'Hacen')
              ))),
      GridColumn(
          columnName: 'PKNA_D',
          columnWidthMode: ColumnWidthMode.auto,
          width:  double.nan,
          label: Container(
              alignment: Alignment.center,
              child:  Text(
                  'StringPKIDlableText'.tr,style: const TextStyle(fontFamily: 'Hacen')
              ))),
      GridColumn(
          columnName: 'BMMST',
          columnWidthMode: ColumnWidthMode.auto,
          width:  double.nan,
          label: Container(
              alignment: Alignment.center,
              child:  Text(
                  'StringState'.tr,style: const TextStyle(fontFamily: 'Hacen')
              ))),
    ];
  }
}

class ProductDataGridSource extends DataGridSource {
  ProductDataGridSource(this.productList) {
    buildDataGridRow();
  }
  late List<DataGridRow> dataGridRows;
  late List<Bil_Mov_M_Local> productList;
 // final controller2=Get.put(Sale_Invoices_Controller());
  @override
  DataGridRowAdapter? buildRow(DataGridRow row) {
    return  DataGridRowAdapter(cells: [
      // Container(
      //   alignment: Alignment.center,
      //   child: IconButton(
      //     icon: Icon(Icons.picture_as_pdf,size: Dimensions.iconSize24,),
      //     onPressed: ()async {
      //       // controller2.GET_BIL_MOV_M_PRINT_P(row.getCells()[14].value);
      //       // controller2.GET_BIF_MOV_D_P(row.getCells()[14].value.toString());
      //       // controller2.GET_BIL_CUS_IMP_INF_P(row.getCells()[1].value==1?row.getCells()[15].value.toString()
      //       //     :row.getCells()[16].value.toString());
      //       // controller2.GET_COUNT_BMDNO_P(row.getCells()[14].value);
      //       // controller2.GET_CountRecode(row.getCells()[14].value);
      //       // await Future.delayed(const Duration(seconds: 1));
      //       // if(controller2.BCTX.isEmpty || controller2.BCTX=='null'){
      //       //   StteingController().Thermal_printer_paper_size == '58 mm'
      //       //       ? taxTikcetReport58(
      //       //       mode: ShareMode.view,
      //       //       msg: 'مرحبا',
      //       //       orderDetails: controller2.BIF_MOV_M_PRINT)
      //       //       : taxTikcetReport80(
      //       //       mode: ShareMode.view,
      //       //       msg: 'مرحبا',
      //       //       orderDetails: controller2.BIF_MOV_M_PRINT);
      //       // }else {
      //       //   Timer(const Duration(seconds: 1), () async {
      //       //     Pdf_Invoices(
      //       //         GetBMKID:   row.getCells()[1].value.toString(),
      //       //         GetBMMDO:    row.getCells()[4].value.toString(),
      //       //         GetBMMNO:   row.getCells()[2].value.toString(),
      //       //         GetPKNA:   row.getCells()[12].value.toString(),
      //       //         mode: ShareMode.view);
      //       //   });
      //       //}
      //     },
      //   ),
      // ),
      Container(
        alignment: Alignment.center,
        child:  Text(row.getCells()[0].value.toString(),
            overflow: TextOverflow.ellipsis,
            style: const TextStyle(fontFamily: 'Hacen')),
      ),
      Container(
        alignment: Alignment.center,
        child: Text(row.getCells()[1].value.toString()=='3'
            ?'StringSale_Invoices'.tr:row.getCells()[1].value.toString()=='1'?'StringPurchases_Invoices'.tr:
           row.getCells()[1].value.toString()=='5'?'StringService_Bills'.tr:row.getCells()[1].value.toString()=='4'?'StringReturn_Sale_Invoices'.tr:
           row.getCells()[1].value.toString()=='12'?'StringReturn_Sale_Invoices_POS'.tr:'StringPOS'.tr,
            overflow: TextOverflow.ellipsis,
            style: const TextStyle(fontFamily: 'Hacen')),
      ),
      Container(
        alignment: Alignment.center,
        child: Text(row.getCells()[2].value.toString(),
            overflow: TextOverflow.ellipsis,
            style: const TextStyle(fontFamily: 'Hacen')),
      ),
      Container(
        alignment: Alignment.center,
        child: Text(row.getCells()[3].value.toString(),
            overflow: TextOverflow.ellipsis,
            style: const TextStyle(fontFamily: 'Hacen')),
      ),
      Container(
        alignment: Alignment.center,
        child: Text(row.getCells()[4].value.toString(),
            overflow: TextOverflow.ellipsis,
            style: const TextStyle(fontFamily: 'Hacen')),
      ),
      Container(
        alignment: Alignment.center,
        child: Text(row.getCells()[5].value.toString(),
            overflow: TextOverflow.ellipsis,
            style: const TextStyle(fontFamily: 'Hacen')),
      ),
      Container(
        alignment: Alignment.center,
        child: Text(row.getCells()[6].value.toString(),
            overflow: TextOverflow.ellipsis,
            style: const TextStyle(fontFamily: 'Hacen')),
      ),
      Container(
        alignment: Alignment.center,
        child: Text(row.getCells()[7].value.toString(),
            overflow: TextOverflow.ellipsis,
            style: const TextStyle(fontFamily: 'Hacen')),
      ),
      Container(
        alignment: Alignment.center,
        child: Text(row.getCells()[8].value.toString(),
            overflow: TextOverflow.ellipsis,
            style: const TextStyle(fontFamily: 'Hacen')),
      ),
      Container(
        alignment: Alignment.center,
        child: Text(row.getCells()[9].value.toString(),
            overflow: TextOverflow.ellipsis,
            style: const TextStyle(fontFamily: 'Hacen')),
      ),
      Container(
        alignment: Alignment.center,
        child: Text(row.getCells()[10].value.toString(),
            overflow: TextOverflow.ellipsis,
            style: const TextStyle(fontFamily: 'Hacen')),
      ),
      Container(
        alignment: Alignment.center,
        child: Text(row.getCells()[11].value.toString(),
            overflow: TextOverflow.ellipsis,
            style: const TextStyle(fontFamily: 'Hacen')),
      ),
      Container(
        alignment: Alignment.center,
        child: Text(row.getCells()[12].value.toString(),
            overflow: TextOverflow.ellipsis,
            style: const TextStyle(fontFamily: 'Hacen')),
      ),
      Container(
        alignment: Alignment.center,
        child: Text(row.getCells()[13].value.toString()== '2' ? 'StringNotfinal'.tr
            : row.getCells()[13].value.toString() =='4' ? 'StringPending'.tr : 'Stringfinal'.tr,
            overflow: TextOverflow.ellipsis,
            style: const TextStyle(fontFamily: 'Hacen')),
      ),
    ]);
  }

  @override
  List<DataGridRow> get rows => dataGridRows;
  @override
  String calculateSummaryValue(GridTableSummaryRow summaryRow,
      GridSummaryColumn? summaryColumn, RowColumnIndex rowColumnIndex) {
    List<double> getCellValues(GridSummaryColumn summaryColumn) {
     // List<double> values = getCellValues(summaryColumn).cast<double>();
      final List<double> values = <double>[];
      for (final DataGridRow row in rows) {
        final DataGridCell? cell = row.getCells().firstWhereOrNull(
                (DataGridCell element) =>
            element.columnName == summaryColumn.columnName);
        if (cell != null && cell.value != null) {
          values.add(cell.value);
        }
      }
      return values;
    }

    String? title = summaryRow.title;
    if (title != null) {
      if (summaryRow.showSummaryInRow && summaryRow.columns.isNotEmpty) {
        for (final GridSummaryColumn summaryColumn in summaryRow.columns) {
          if (title!.contains(summaryColumn.name)) {
            double deviation = 0;
             List<double> values = getCellValues(summaryColumn).cast<double>();
            if (values.isNotEmpty) {
           //   double sum = values+1;
              deviation = 2;
            }
            title = title.replaceAll(
                '{${summaryColumn.name}}', deviation.toString());
          }
        }
      }
    }
    return title ?? '';
  }

  @override
  Widget? buildTableSummaryCellWidget(
      GridTableSummaryRow summaryRow,
      GridSummaryColumn? summaryColumn,
      RowColumnIndex rowColumnIndex,
      String summaryValue) {
    return Container(
      padding: const EdgeInsets.all(15.0),
      child: Text(summaryValue),
    );
  }

  void buildDataGridRow() {
    dataGridRows = productList.map<DataGridRow>((dataGridRow) {
      return DataGridRow(cells: [
        DataGridCell(columnName: 'BINA_D', value: dataGridRow.BINA_D),
        DataGridCell(columnName: 'BMKID', value: dataGridRow.BMKID),
        DataGridCell(columnName: 'BMMNO', value: dataGridRow.BMMNO),
        DataGridCell(columnName: 'BMMRE', value: dataGridRow.BMMRE),
        DataGridCell(columnName: 'BMMDO', value: dataGridRow.BMMDO),
        DataGridCell(columnName: 'SCNA_D', value: dataGridRow.SCNA_D),
        DataGridCell(columnName: 'BMMAM', value: dataGridRow.BMMAM),
        DataGridCell(columnName: 'BMMDI', value: dataGridRow.BMMDI),
        DataGridCell(columnName: 'BMMTX', value: dataGridRow.BMMTX),
        DataGridCell(columnName: 'BMMDIF', value: dataGridRow.BMMDIF),
        DataGridCell(columnName: 'BMMMT', value: dataGridRow.BMMMT),
        DataGridCell(columnName: 'BMMNA', value: dataGridRow.BMMNA),
        DataGridCell(columnName: 'PKNA_D', value: dataGridRow.PKNA_D),
        DataGridCell(columnName: 'BMMST', value: dataGridRow.BMMST),
        DataGridCell(columnName: 'BMMID', value: dataGridRow.BMMID),
        DataGridCell(columnName: 'BIID', value: dataGridRow.BIID),
        DataGridCell(columnName: 'BCID', value: dataGridRow.BCID),
      ]);
    }).toList(growable: false);
  }

  void updateDataSource() {
    notifyListeners();
  }
}
