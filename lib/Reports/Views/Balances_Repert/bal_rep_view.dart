import '../../../Reports/controllers/Cus_Bal_Rep_Controller.dart';
import '../../../Widgets/dimensions.dart';
import '../../../Widgets/theme_helper.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Bal_Rep_View extends StatefulWidget {
  @override
  State<Bal_Rep_View> createState() => _Inv_Rep_ViewState();
}

class _Inv_Rep_ViewState extends State<Bal_Rep_View> {
  final Cus_Bal_Rep_Controller controller = Get.find();


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: ThemeHelper().MainAppBar('StringAccounts_Report'.tr),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Card(
              child:Container(
                color: Colors.white,
                child: ListTile(
                  leading:  Icon(Icons.receipt_long,color: Colors.black,size: Dimensions.height20,),
                  title:  Text('StringCus_Bal_Rep'.tr,style: TextStyle(fontWeight:FontWeight.bold,fontSize: Dimensions.fonText)),
                  onTap: () {
                    controller.Clear_P();
                    Get.toNamed('/Cus_Bal_Rep',arguments: 3);
                    controller.TYPE_REP=1;
                  },
                ),
              ),
            ),
            Card(
              child:Container(
                color: Colors.white,
                child: ListTile(
                  leading:  Icon(Icons.receipt_long,color: Colors.black,size: Dimensions.height20,),
                  title:  Text('StringSuppliers_Balances_Report'.tr,style: TextStyle(fontWeight:FontWeight.bold,fontSize: Dimensions.fonText)),
                  onTap: () {
                    controller.Clear_P();
                    Get.toNamed('/Cus_Bal_Rep',arguments: 2);
                    controller.TYPE_REP=2;
                  },
                ),
              ),
            ),
            Card(
              child:Container(
                color: Colors.white,
                child: ListTile(
                  leading:  Icon(Icons.receipt_long,color: Colors.black,size: Dimensions.height20,),
                  title:  Text('StringAccounts_Balances_Report'.tr,style: TextStyle(fontWeight:FontWeight.bold,fontSize: Dimensions.fonText)),
                  onTap: () {
                    controller.Clear_P();
                    Get.toNamed('/Cus_Bal_Rep',arguments: 3);
                    controller.TYPE_REP=3;
                  },
                ),
              ),
            ),
            Card(
              child:Container(
                color: Colors.white,
                child: ListTile(
                  leading:  Icon(Icons.receipt_long,color: Colors.black,size: Dimensions.height20,),
                  title:  Text('StringDaily_Treasury_Report'.tr,style: TextStyle(fontWeight:FontWeight.bold,fontSize: Dimensions.fonText)),
                  onTap: () {
                    controller.Clear_P();
                    Get.toNamed('/Cus_Bal_Rep',arguments: 4);
                    controller.TYPE_REP=4;
                    controller.GET_SYS_CUR_ONE();
                  },
                ),
              ),
            ),
            // Card(
            //   child:Container(
            //     color: Colors.white,
            //     child: ListTile(
            //       leading:  Icon(Icons.receipt_long,color: Colors.black,size: Dimensions.height20,),
            //       title:  Text('StringDaily_Treasury_Report'.tr,style: TextStyle(fontWeight:FontWeight.bold,fontSize: Dimensions.fonText)),
            //       onTap: () {
            //         controller.Clear_P();
            //         Get.toNamed('/Acc_Mov_Rep',arguments: 3);
            //         controller.TYPE_REP=44;
            //         controller.GET_SYS_CUR_ONE();
            //       },
            //     ),
            //   ),
            // ),
          ],
        ),
      ),
    );
  }
}
