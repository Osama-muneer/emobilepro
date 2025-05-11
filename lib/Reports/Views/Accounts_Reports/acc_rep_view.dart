import '../../../Reports/controllers/Acc_Rep_Controller.dart';
import '../../../Widgets/dimensions.dart';
import '../../../Widgets/theme_helper.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Acc_Rep_View extends StatefulWidget {
  @override
  State<Acc_Rep_View> createState() => Acc_Rep_ViewState();
}

class Acc_Rep_ViewState extends State<Acc_Rep_View> {
  final controller=Get.put(Acc_Rep_Controller());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: ThemeHelper().MainAppBar('StringAccountsReports'.tr),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Card(
              child:
              Container(
               color: Colors.white,
                child: ListTile(
                  leading:  Icon(Icons.receipt_long,color: Colors.black,size: Dimensions.iconSize40,),
                  title:  Text('StringTotal_AccountsReports'.tr,style: TextStyle(fontWeight:FontWeight.bold,
                      fontSize: Dimensions.fonText)),
                  onTap: () {
                      Get.toNamed('/Acc_Mov_Rep',arguments: 3);
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
