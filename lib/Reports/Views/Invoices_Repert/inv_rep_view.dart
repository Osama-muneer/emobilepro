import '../../../Reports/controllers/Inv_Rep_Controller.dart';
import '../../../Widgets/RightSideNavigationBar.dart';
import '../../../Widgets/config.dart';
import '../../../Widgets/dimensions.dart';
import '../../../Widgets/theme_helper.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Inv_Rep_View extends StatefulWidget {
  @override
  State<Inv_Rep_View> createState() => _Inv_Rep_ViewState();
}

class _Inv_Rep_ViewState extends State<Inv_Rep_View> {

  final controller=Get.put(Inv_Rep_Controller());
  int selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: ThemeHelper().MainAppBar('StringSalesReports'.tr),
      body: SingleChildScrollView(
        child: Column(
          children: [
           if(STMID=='MOB')
            Card(
              child:Container(
                color: Colors.white,
                child: ListTile(
                  leading:  Icon(Icons.receipt_long,color: Colors.black,size: Dimensions.height20,),
                  title:  Text('StringTotal_SalesReports'.tr,style: TextStyle(fontWeight:FontWeight.bold,fontSize: Dimensions.fonText)),
                  onTap: () {
                      Get.toNamed('/Inv_Mov_Rep',arguments: 3);
                      controller.BMKID=3;
                  },
                ),
              ),
            ),
            if(STMID=='MOB')
            Card(
              child: Container(
                color: Colors.white,
                child: ListTile(
                  leading:  Icon(Icons.receipt_long,color: Colors.black,size: Dimensions.height20,),
                  title:  Text('StringTotal_PurchasesReports'.tr,style: TextStyle(fontWeight:FontWeight.bold,fontSize: Dimensions.fonText)),
                  onTap: () {
                      Get.toNamed('/Inv_Mov_Rep',arguments: 1);
                      controller.BMKID=1;
                  },
                ),
              ),
            ),
            Card(
              child:Container(
                color: Colors.white,
                child: ListTile(
                  leading:  Icon(Icons.receipt_long,color: Colors.black,size: Dimensions.height20,),
                  title:  Text('StringInv_Mov_Rep'.tr,style: TextStyle(fontWeight:FontWeight.bold,fontSize: Dimensions.fonText)),
                  onTap: () {
                    controller.clearData();
                    Get.toNamed('/Inv_Mov_Rep',arguments: 11);
                    controller.BMKID=11;
                  },
                ),
              ),
            ),
            Card(
              child:Container(
                color: Colors.white,
                child: ListTile(
                  leading:  Icon(Icons.receipt_long,color: Colors.black,size: Dimensions.height20,),
                  title:  Text('StringTotalItemReport'.tr,style: TextStyle(fontWeight:FontWeight.bold,fontSize: Dimensions.fonText)),
                  onTap: () {
                    controller.clearData();
                    Get.toNamed('/Inv_Mov_Rep',arguments: 101);
                    controller.BMKID=101;
                    if(STMID=='COU'){
                      controller.SelectDataBMKID='11';
                    }
                  },
                ),
              ),
            ),
            Card(
              child:Container(
                color: Colors.white,
                child: ListTile(
                  leading:  Icon(Icons.receipt_long,color: Colors.black,size: Dimensions.height20,),
                  title:  Text('StringDetailedItemReport'.tr,style: TextStyle(fontWeight:FontWeight.bold,fontSize: Dimensions.fonText)),
                  onTap: () {
                    controller.clearData();
                    Get.toNamed('/Inv_Mov_Rep',arguments: 102);
                    controller.BMKID=102;
                    if(STMID=='COU'){
                      controller.SelectDataBMKID='11';
                    }
                  },
                ),
              ),
            ),
            // Stack(
            //   children: [
            //     // المحتوى الرئيسي (يمكنك تغييره بما يتناسب مع تطبيقك)
            //     Center(child: Text("المحتوى الرئيسي هنا")),
            //     // شريط التنقل على اليمين
            //     RightSideNavigationBar(
            //       currentIndex: selectedIndex,
            //       onTap: (index) {
            //         setState(() {
            //           selectedIndex = index;
            //         });
            //         // هنا يمكنك التنقل بين الشاشات أو تحديث الحالة بناءً على الاختيار
            //       },
            //     ),
            //   ],
            // ),
          ],
        ),
      ),
    );
  }
}
