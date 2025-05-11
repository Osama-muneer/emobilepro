import 'dart:async';
import '../../../Operation/models/acc_mov_m.dart';
import '../../../Reports/controllers/accounts_archive_controller.dart';
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
  final Accounts_ArchiveController controller = Get.find();
  Future<ProductDataGridSource> getProductDataSource() async {
    var ACC_MOVList = await  GET_ACC_MOV_REP(controller.SelectDataFromBIID!,controller.SelectDataToBIID!,controller.SelectFromDays!,
        controller.SelectToDays!, controller.SelectDataSCID.toString(),controller.PKID.toString(),controller.AANA,
        controller.SelectFromDATEI.toString(),controller.SelectToDATEI.toString());
    return ProductDataGridSource(ACC_MOVList);
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<Accounts_ArchiveController>(
        init: Accounts_ArchiveController(),
        builder: ((value)=>FutureBuilder(
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
          columnName: 'AMKID',
          columnWidthMode: ColumnWidthMode.auto,
          width:  140,
          label: Container(
              alignment: Alignment.center,
              child:  Text(
                  'StringType'.tr,style: const TextStyle(fontFamily: 'Hacen')
              ))),
      GridColumn(
          columnName: 'AMMNO',
          columnWidthMode: ColumnWidthMode.auto,
          width:  140,
          label: Container(
              alignment: Alignment.center,
              child:  Text(
                  'StringBMMNO'.tr,style: const TextStyle(fontFamily: 'Hacen')
              ))),
      GridColumn(
          columnName: 'AMMDO',
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
          columnName: 'AMMAM',
          columnWidthMode: ColumnWidthMode.auto,
          width:  double.nan,
          label: Container(
              alignment: Alignment.center,
              child:  Text(
                  'StringAmount'.tr,style: const TextStyle(fontFamily: 'Hacen')
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
          columnName: 'AMMIN',
          columnWidthMode: ColumnWidthMode.auto,
          width:  double.nan,
          label: Container(
              alignment: Alignment.center,
              child:  Text(
                  'StringDetails'.tr,style: const TextStyle(fontFamily: 'Hacen')
              ))),
      // GridColumn(
      //     columnName: 'PKNA_D',
      //     columnWidthMode: ColumnWidthMode.auto,
      //     width:  double.nan,
      //     label: Container(
      //         alignment: Alignment.center,
      //         child:  Text(
      //             '-----'.tr,style: const TextStyle(fontFamily: 'Hacen')
      //         ))),
      GridColumn(
          columnName: 'AMMST',
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
  late List<Acc_Mov_M_Local> productList;
 // final controller2=Get.put(Sale_Invoices_Controller());
  @override
  DataGridRowAdapter? buildRow(DataGridRow row) {
    return  DataGridRowAdapter(cells: [
      Container(
        alignment: Alignment.center,
        child:  Text(row.getCells()[0].value.toString(),
            overflow: TextOverflow.ellipsis,
            style: const TextStyle(fontFamily: 'Hacen')),
      ),
      Container(
        alignment: Alignment.center,
        child: Text(row.getCells()[1].value.toString()=='1'
            ?'StringReceipt'.tr:row.getCells()[1].value.toString()=='2'?'StringPayment'.tr:
           row.getCells()[1].value.toString()=='3'?'StringCollectionsVoucher'.tr:'StringJournalVouchers'.tr,
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
        child: Text(row.getCells()[11].value.toString(),
            overflow: TextOverflow.ellipsis,
            style: const TextStyle(fontFamily: 'Hacen')),
      ),
    //   Container(
    //     alignment: Alignment.center,
    //     child: Text(row.getCells()[1].value.toString()=='1'?
    // row.getCells()[8].value.toString():
    // row.getCells()[1].value.toString()=='8'?
    // row.getCells()[10].value.toString():
    // row.getCells()[9].value.toString(),
    //         overflow: TextOverflow.ellipsis,
    //         style: const TextStyle(fontFamily: 'Hacen')),
    //   ),
      Container(
        alignment: Alignment.center,
        child: Text(row.getCells()[7].value.toString()== '2' ? 'StringNotfinal'.tr
            : row.getCells()[7].value.toString() =='3' ? 'StringPending'.tr : 'Stringfinal'.tr,
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
        DataGridCell(columnName: 'BINA_D', value: dataGridRow.BINA_D),//'0'
        DataGridCell(columnName: 'AMKID', value: dataGridRow.AMKID),//'1'
        DataGridCell(columnName: 'AMMNO', value: dataGridRow.AMMNO),//'2'
        DataGridCell(columnName: 'AMMDO', value: dataGridRow.AMMDO),//'3'
        DataGridCell(columnName: 'SCNA_D', value: dataGridRow.SCNA_D),//'4'
        DataGridCell(columnName: 'AMMAM', value: dataGridRow.AMMAM),//'5'
        DataGridCell(columnName: 'PKNA_D', value: dataGridRow.PKNA_D),//'6'
        DataGridCell(columnName: 'AMMST', value: dataGridRow.AMMST),//'7'
        DataGridCell(columnName: 'ACNA_D', value: dataGridRow.ACNA_D),//'8'
        DataGridCell(columnName: 'ABNA_D', value: dataGridRow.ABNA_D),//'9'
        DataGridCell(columnName: 'BCCNA_D', value: dataGridRow.BCCNA_D),//'10'
        DataGridCell(columnName: 'AMMIN', value: dataGridRow.AMMIN),//'11'
      ]);
    }).toList(growable: false);
  }

  void updateDataSource() {
    notifyListeners();
  }
}
