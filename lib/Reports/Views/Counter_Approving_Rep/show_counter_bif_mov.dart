import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../Operation/Views/SaleInvoices/counter_invoices_datagrid.dart';
import '../../../Widgets/colors.dart';



class Show_Counter_Bif_Mov extends StatefulWidget {
  @override
  State<Show_Counter_Bif_Mov> createState() => _Show_Counter_Bif_MovState();
}

class _Show_Counter_Bif_MovState extends State<Show_Counter_Bif_Mov> {

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(backgroundColor: AppColors.MainColor,

        title: Text('StrinInvoices_Archive'.tr,
          style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: height*0.02),
        ),
        iconTheme: const IconThemeData(color: Colors.white),
        // actions: [
        //   Padding(
        //     padding: EdgeInsets.only(left: Dimensions.height5),
        //     child: IconButton(icon: Icon(Icons.picture_as_pdf),
        //         onPressed: ()async{
        //           EasyLoading.instance
        //             ..displayDuration = const Duration(milliseconds: 2000)
        //             ..indicatorType = EasyLoadingIndicatorType.fadingCircle
        //             ..loadingStyle = EasyLoadingStyle.custom
        //             ..indicatorSize = 50.0
        //             ..radius = 10.0
        //             ..progressColor = Colors.white
        //             ..backgroundColor = Colors.green
        //             ..indicatorColor = Colors.white
        //             ..textColor = Colors.white
        //             ..maskColor = Colors.blue.withOpacity(0.5)
        //             ..userInteractions = true
        //             ..dismissOnTap = false;
        //           EasyLoading.show();
        //           setState(() {
        //             // controller.FetchPdfData();
        //           });
        //           // Timer(const Duration(seconds: 1), () async{
        //           //   final pdfFile = await Pdf.Sto_Num_Pdf(
        //           //       controller.SelectBINA.toString(),
        //           //       controller.SelectDataSINA.toString()==null?'':controller.SelectDataSINA.toString()
        //           //       ,controller.SDDSA,controller.SMDED, controller.SONA,
        //           //       controller.SONE,
        //           //       controller.SORN,
        //           //       controller.SOLN,'Quantities',
        //           //       LoginController().SUNA,
        //           //       controller.SUM_SNNO,
        //           //        controller.UPIN!);
        //           //   EasyLoading.dismiss();
        //           //   PdfPakage.openFile(pdfFile);
        //           // });
        //         }),
        //   ),
        // ],
      ),
      body:  DataGridPage(),
    );
  }
}

