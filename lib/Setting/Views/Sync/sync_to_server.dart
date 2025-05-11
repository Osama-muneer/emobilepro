import 'dart:async';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter_background_service/flutter_background_service.dart';
import '../../../Setting/models/bil_mov_k.dart';
import '../../../Widgets/colors.dart';
import '../../../Widgets/config.dart';
import '../../../Widgets/dimensions.dart';
import '../../../Widgets/dropdown.dart';
import '../../../Widgets/service.dart';
import '../../../Widgets/theme_helper.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../database/sync_db.dart';
import '../../controllers/login_controller.dart';
import '../../controllers/sync_server_controller.dart';

class Sync_To_Server extends StatefulWidget {
  @override
  State<Sync_To_Server> createState() => _Sync_To_ServerState();
}

class _Sync_To_ServerState extends State<Sync_To_Server> {
  final Sync_To_ServerController controller = Get.find();

  DropdownST_Builder() {
    return  Padding(
      padding: EdgeInsets.only(left: Dimensions.width5, right: Dimensions.width5,
          top: Dimensions.width5,bottom: Dimensions.width5),
      child: DropdownButtonFormField2(
        decoration: InputDecoration(
          labelText: 'StringState'.tr,
          labelStyle: TextStyle(color: Colors.grey.shade800),
          focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(Dimensions.width15),
              borderSide: BorderSide(color: Colors.grey.shade500)),
          isDense: true,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(Dimensions.width15),
          ),
        ),
                  isExpanded: true,
                  hint: ThemeHelper().buildText(context,'StringState', Colors.grey,'S'),
                  value: controller.SelectDataST,
                  style: const TextStyle(
                      fontFamily: 'Hacen',
                      color: Colors.black,
                      fontWeight: FontWeight.bold),
                  items: josnStatus.map((item) => DropdownMenuItem<String>(
                    onTap: (){
                    },
                    value: item['id'],
                    child: Text(
                      item['name'],
                      style: ThemeHelper().buildTextStyle(context, Colors.black,'M'),
                    ),
                  )).toList().obs,
                  onChanged: (value) {
                    controller.SelectDataST = value.toString();
                    controller.GET_GET_COUNT_MOV_P();
                    controller.update();
                  },
                ),
    );
  }


  FutureBuilder<List<Bil_Mov_K_Local>> DropdownBIL_MOV_K() {
    return FutureBuilder<List<Bil_Mov_K_Local>>(
        future:  GET_MOV_K(),
        builder: (BuildContext context,
            AsyncSnapshot<List<Bil_Mov_K_Local>> snapshot) {
          if (!snapshot.hasData) {
            return Padding(
              padding: EdgeInsets.only(left: Dimensions.width5, right: Dimensions.width5,
                  top: Dimensions.width5,bottom: Dimensions.width5),
              child: Dropdown(josnStatus: josnStatus, GETSTRING: 'StringFromBrach'.tr,),
            );
          }
          return Padding(
            padding: EdgeInsets.only(left: Dimensions.width5, right: Dimensions.width5,
                top: Dimensions.width5,bottom: Dimensions.width5),
            child: DropdownButtonFormField2(
              decoration: InputDecoration(
                labelText: 'StringType'.tr,
                labelStyle: TextStyle(color: Colors.grey.shade800),
                focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(Dimensions.width15),
                    borderSide: BorderSide(color: Colors.grey.shade500)),
                isDense: true,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(Dimensions.width15),
                ),
              ),
              isExpanded: true,
              hint: ThemeHelper().buildText(context,'StringType', Colors.grey,'S'),
              value: controller.SelectDataBMKID,
              style: const TextStyle(fontFamily: 'Hacen', color: Colors.black),
              items: snapshot.data!
                  .map((item) => DropdownMenuItem<String>(
                value: item.BMKID.toString(),
                child: Text(
                  item.BMKNA_D.toString(),
                  style:  ThemeHelper().buildTextStyle(context, Colors.black,'M'),
                ),
              )).toList().obs,
              validator: (value) {
                if (value == null) {
                  return 'Please select gender.';
                }
                return null;
              },
              onChanged: (value) {
                controller.SelectDataBMKID = value.toString();
                controller.value=false;
                controller.GET_GET_COUNT_MOV_P();
              },
            ),
          );
        });
  }

  Future<bool> onWillPop() async {
    Navigator.of(context).pop(false);
    // STMID=='EORD'?false:await initializeService();
    Get.offAllNamed('/Home');
    return Future.value(true);
  }

  Widget build(BuildContext context) {
    final service = FlutterBackgroundService();
    return WillPopScope(
    onWillPop: onWillPop,
      child: Scaffold(
          backgroundColor: Colors.grey[200],
          appBar: AppBar(
            automaticallyImplyLeading:  STMID=='EORD'?false:true,
            backgroundColor: AppColors.MainColor,
            iconTheme: IconThemeData(color: Colors.white),

            title:  ThemeHelper().buildText(context,'StringUploaddata', Colors.white,'L'),
            centerTitle: true,
          ),
          body: Container(
            margin: EdgeInsets.only(left:Dimensions.height20,right: Dimensions.height20,top: Dimensions.height15),
            child: GetBuilder<Sync_To_ServerController>(
              init: Sync_To_ServerController(),
              builder: ((value)=>
                  Form(
                    child: ListView(
                      children: <Widget>[

                        Container(
                            margin: EdgeInsets.only(left: Dimensions.height5,right: Dimensions.height5),
                            decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular( Dimensions.width10)),
                            child:  DropdownBIL_MOV_K(),
                        ),
                        SizedBox(height: Dimensions.height10,),
                        Container(
                            margin: EdgeInsets.only(left: Dimensions.height5,right: Dimensions.height5),
                            decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular( Dimensions.width10)),
                            child:  DropdownST_Builder(),
                        ),
                        SizedBox(height: Dimensions.height10,),
                        //من تاريخ الى تاريخ
                        Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Expanded(
                                  child: Container(
                                      margin: EdgeInsets.only(left: Dimensions.height5),
                                      decoration: BoxDecoration(
                                          color: Colors.white,
                                          borderRadius: BorderRadius.circular(Dimensions.width10)),
                                      child: Column(
                                        children: [
                                          Text(
                                              (controller.SelectFromDays == null ?
                                              controller.SelectFromDays=controller.dateFromDays.toString().split(" ")[0]
                                                  : controller.SelectFromDays.toString())
                                                  .split(" ")[0],style: TextStyle(fontSize: Dimensions.fonText),),
                                          SizedBox(
                                            width: Dimensions.width100,
                                            child: ElevatedButton(
                                              onPressed: () {
                                                controller.selectDateFromDays(context);
                                              },
                                              style: ElevatedButton.styleFrom(
                                                backgroundColor: AppColors.MainColor, // Background color
                                              ),
                                              child: ThemeHelper().buildText(context,'StringFromDate', Colors.white,'M'),
                                            ),
                                          ),
                                        ],
                                      )
                                  ),
                                ),
                                Expanded(
                                  child: Container(
                                      margin: EdgeInsets.only(right: Dimensions.height5),
                                      decoration: BoxDecoration(
                                          color: Colors.white,
                                          borderRadius: BorderRadius.circular(Dimensions.width10)),
                                      child:  Column(
                                        children: [
                                          Text(
                                              controller.SelectToDays == null ?
                                              controller.SelectToDays=controller.dateTimeToDays.toString().split(" ")[0]
                                                  : controller.SelectToDays.toString()
                                                  .split(" ")[0],style: TextStyle(fontSize: Dimensions.fonText),),
                                          Container(
                                            width: Dimensions.width100,
                                            child: ElevatedButton(
                                              onPressed: () {
                                                controller.selectDateToDays(context);
                                              },
                                              style: ElevatedButton.styleFrom(
                                                backgroundColor: AppColors.MainColor, // Background color
                                              ),
                                              child: ThemeHelper().buildText(context,'StringToDate', Colors.white,'M'),
                                            ),
                                          ),
                                        ],
                                      )
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                        SizedBox(height: Dimensions.height15,),
                        Text( "${'StringNumberofmovements'.tr} : ${controller.Count}",
                          style: TextStyle(fontWeight: FontWeight.bold),),

                        Obx(() => controller.isloading.value == true
                              ? ThemeHelper().circularProgress()
                              : Container(
                            decoration: ThemeHelper().buttonBoxDecoration(context),
                            child: MaterialButton(
                                onPressed: ()  {
                                    //Timer(const Duration(seconds: 5), () async {
                                    if(controller.SelectDataBMKID==null ){
                                      Get.snackbar('StringMestitle'.tr, 'StringChooseTheType'.tr,
                                          backgroundColor: Colors.red, icon: const Icon(Icons.error,color:Colors.white),
                                          colorText:Colors.white,
                                          isDismissible: true,
                                          dismissDirection: DismissDirection.horizontal,
                                          forwardAnimationCurve: Curves.easeOutBack);
                                      controller.isloading.value=false;
                                    }
                                    else if(controller.Count=='0' ){
                                      Get.snackbar('StringMestitle'.tr, 'StringNoDataSync'.tr,
                                          backgroundColor: Colors.red, icon: const Icon(Icons.error,color:Colors.white),
                                          colorText:Colors.white,
                                          isDismissible: true,
                                          dismissDirection: DismissDirection.horizontal,
                                          forwardAnimationCurve: Curves.easeOutBack);
                                      controller.isloading.value=false;
                                    }
                                    else{
                                      service.invoke("stopService");
                                      LoginController().SET_N_P('Timer_Strat',1);
                                      controller.Socket_IP_Connect();
                                    }
                                  // });
                                },
                                child: Container(
                                  height:Dimensions.height40,
                                  width: Dimensions.width100,
                                  alignment: Alignment.center,
                                  child: ThemeHelper().buildText(context,'StringSend', Colors.white,'M'),
                                  decoration: BoxDecoration(
                                      color: AppColors.MainColor,
                                      borderRadius:
                                      BorderRadius.circular(Dimensions.height10)),
                                )),
                          ),),
                      ],
                    ),
                  )),
            ),
          )),
    );
  }
}
