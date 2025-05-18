import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import '../../../Reports/Views/Account_Statement/show_acc_statement.dart';
import '../../../Reports/controllers/Account_Statement_Controller.dart';
import '../../../Setting/controllers/login_controller.dart';
import '../../../Setting/models/acc_acc.dart';
import '../../../Setting/models/acc_cos.dart';
import '../../../Setting/models/bra_inf.dart';
import '../../../Setting/models/sys_cur.dart';
import '../../../Setting/models/sys_scr.dart';
import '../../../Widgets/colors.dart';
import '../../../Widgets/config.dart';
import '../../../Widgets/dropdown.dart';
import '../../../Widgets/theme_helper.dart';
import '../../../database/report_db.dart';
import '../../../database/setting_db.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';

class Account_Statement_View extends StatefulWidget {
  const Account_Statement_View({super.key});

  @override
  State<Account_Statement_View> createState() => _Account_Statement_ViewState();
}

class _Account_Statement_ViewState extends State<Account_Statement_View> {
  final Account_Statement_Controller controller = Get.find();

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return GetBuilder<Account_Statement_Controller>(
        init: Account_Statement_Controller(),
        builder: ((controller) {
          if (controller.loading.value == false) {
            return SpinKitFadingCircle(
              //  controller: AnimationController(duration: const Duration(milliseconds: 1200), vsync: ),
              itemBuilder: (BuildContext context, int index) {
                return DecoratedBox(
                  decoration: BoxDecoration(
                    color: index.isEven ? Colors.red : Colors.grey,
                  ),
                );
              },
            );
          }
          return Scaffold(
            appBar: AppBar(
              backgroundColor: AppColors.MainColor,
              iconTheme:const  IconThemeData(color: Colors.white),
              actions: [
                Row(
                  children: [
                    IconButton(
                      icon: const Icon(Icons.cleaning_services,color: Colors.white),
                      onPressed: () {
                        controller.clear();
                        controller.update();
                      },
                    ),
                  ],
                )
              ],
              title: Text(controller.TYPY==2?'StringAccount_Statement_Online'.tr:
              controller.TYPY==3?'StringACC_COS_STA'.tr:
              controller.TYPY==4?'StringACC_STA_H'.tr:'StringAccount_Statement'.tr,
                  style: ThemeHelper().buildTextStyle(context, AppColors.textColor,'L')),
              centerTitle: true,
            ),
            body: SingleChildScrollView(
              child: Padding(
                padding: EdgeInsets.only(left: 0.03 * width, right: 0.03 * width),
                child: Form(
                  key: controller.formKey,
                  child: controller.TYPY==2?
                  Column(
                    children: [
                      SizedBox(height: 0.01 * height),
                      DropdownACC_ACCBuilder(),
                      SizedBox(height: 0.02 * height),
                      DropdownSYS_CURBuilder(context),
                      SizedBox(height: 0.02 * height),
                      MaterialButton(
                        onPressed: () async {
                          if(controller.UPQR==1){
                            if (controller.SelectDataAANO==null) {
                              Fluttertoast.showToast(
                                  msg: 'StringvalidateAANO'.tr,
                                  textColor: Colors.white,
                                  backgroundColor: Colors.red);
                            }else if ( controller.SelectDataSCID == null) {
                              Fluttertoast.showToast(
                                  msg: 'StringvalidateSCID'.tr,
                                  textColor: Colors.white,
                                  backgroundColor: Colors.red);
                            } else{
                              controller.GET_BIL_ACC_D_P(controller.SelectDataAANO.toString(),
                                  controller.SelectTYPE_CUR.toString(),controller.SelectDataSCID.toString());
                              controller.GET_BIL_ACC_M_P(controller.AANOController.text,controller.GUIDC,
                                  controller.SelectTYPE_CUR.toString(),controller.SelectDataSCID.toString());
                              Get.to(() => Show_Acc_Statement());
                            }
                          }else{
                            Get.snackbar('StringAcc_Statement'.tr, 'String_CHK_Acc_Statement'.tr,
                                backgroundColor: Colors.red, icon: const Icon(Icons.error,color:Colors.white),
                                colorText:Colors.white,
                                isDismissible: true,
                                dismissDirection: DismissDirection.horizontal,
                                forwardAnimationCurve: Curves.easeOutBack);
                          }},
                        child: Container(
                            height: 0.05 * height,
                         // width: 1 * width,
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                              color: AppColors.MainColor,
                              borderRadius: BorderRadius.circular(0.02 * width)),
                          child: Text('StringShow'.tr, style: ThemeHelper().buildTextStyle(context, Colors.white,'L')
                          ),
                        ),
                      ),
                    ],
                  ):
                  Column(
                    children: [
                      SizedBox(height: 0.01 * height),
                      if(controller.TYPY==1)
                      if(controller.SYS_SCR2.length >0)
                      GridView.builder(
                        shrinkWrap: true,
                        itemCount: controller.SYS_SCR2.length,
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 1,
                          childAspectRatio: MediaQuery.of(context).size.height / 100,
                        ),
                        itemBuilder: (BuildContext context, int index) {
                          return TextButton(
                            onPressed: () async {
                                controller.SelectDataSSID = controller.SYS_SCR2[index].SSID.toString();
                                controller.SSNA = controller.SYS_SCR2[index].SSNA_D.toString();
                                controller.SelectDataAANO=null;
                                controller.SelectDataAANO2=null;
                                query_Acc_Acc(LoginController().BIID.toString(),controller.SelectDataSSID.toString());
                                await controller.GET_PRIVLAGE();
                                controller.update();

                            },
                            style: controller.SYS_SCR2[index].SSID.toString() == controller.SelectDataSSID
                                ? TextButton.styleFrom(
                                    side: const BorderSide(color: Colors.red),
                                    //foregroundColor: Colors.black,
                                   // backgroundColor: Colors.grey[400],
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(
                                          0.02 * height), // <-- Radius
                                    ),
                                  )
                                : TextButton.styleFrom(side: const BorderSide(color: Colors.black45),
                                    // foregroundColor: Colors.black,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(
                                          0.02 * height), // <-- Radius
                                    ),
                                  ),
                            child: Text(
                              controller.SYS_SCR2[index].SSNA_D.toString(),
                              style: TextStyle(
                                  color: controller.SYS_SCR2[index].SSID.toString() == controller.SelectDataSSID
                                      ?Colors.red:Colors.black,
                                  fontSize: 0.022 * height,
                                  fontWeight: FontWeight.bold),
                            ),
                          );
                        },
                      ),
                      if(controller.TYPY==1)
                      SizedBox(height: 0.01 * height),
                      if(controller.TYPY==1)
                      if(controller.SYS_SCR.length >0)
                      GridView.builder(
                        shrinkWrap: true,
                        itemCount: controller.SYS_SCR.length,
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: controller.SYS_SCR.length == 3
                              ? 3 : controller.SYS_SCR.length == 2 ? 2 : 1,
                          childAspectRatio: controller.SYS_SCR.length == 3
                              ? MediaQuery.of(context).size.height / 250 : controller.SYS_SCR.length == 2 ? 4 : 9,
                          crossAxisSpacing: 0,
                        ),
                        itemBuilder: (BuildContext context, int index) {
                          return Padding(
                            padding:  EdgeInsets.only(left:  0.012 * width,right:  0.012 * width),
                            child: TextButton(
                              onPressed: () async {
                                  controller.SelectDataSSID = controller.SYS_SCR[index].SSID.toString();
                                  controller.SSNA = controller.SYS_SCR[index].SSNA_D.toString();
                                  controller.SelectDataAANO=null;
                                  controller.SelectDataAANO2=null;
                                  query_Acc_Acc(LoginController().BIID.toString(),controller.SelectDataSSID.toString());
                                  await controller.GET_PRIVLAGE();
                                  controller.update();
                              },
                              style: controller.SYS_SCR[index].SSID.toString() == controller.SelectDataSSID
                                  ? TextButton.styleFrom(
                                      side: const BorderSide(color: Colors.red),
                                      //foregroundColor: Colors.black,
                                     // backgroundColor: Colors.grey[400],
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(
                                            0.02 * height), // <-- Radius
                                      ),
                                    )
                                  : TextButton.styleFrom(side: const BorderSide(color: Colors.black45),
                                      // foregroundColor: Colors.black,
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(
                                            0.02 * height), // <-- Radius
                                      ),
                                    ),
                              child: Text(
                                controller.SYS_SCR[index].SSNA_D.toString(),
                                style: TextStyle(
                                    color: controller.SYS_SCR[index].SSID.toString() == controller.SelectDataSSID
                                        ?Colors.red:Colors.black,
                                    fontSize: 0.014 * height,
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                          );
                        },
                      ),
                      SizedBox(height: 0.015 * height),
                      Row(
                        children: [
                          Expanded(
                            child: DropdownBra_InfBuilder(context),
                          ),
                          Expanded(
                            child: DropdownBra_Inf_ToBuilder(context),
                          ),
                        ],
                      ),
                      SizedBox(height: 0.015 * height),
                      controller.TYPY==1 || controller.TYPY==4?
                      controller.SelectDataSSID!='203'?
                        Row(
                        children: [
                          Expanded(
                            child: DropdownFrom_ACC_COSBuilder(context,2),
                          ),
                          Expanded(
                            child: DropdownTo_ACC_COSBuilder(context),
                          ),
                        ],
                      ):
                      Container():
                      Column(
                        children: [
                          DropdownACC_ACCBuilder(),
                          SizedBox(height: 0.015 * height),
                          DropdownACC_ACCBuilder_TO(),
                        ],
                      ),
                      SizedBox(height: 0.015 * height),
                      controller.TYPY==3?
                      DropdownFrom_ACC_COSBuilder(context,1):
                      DropdownACC_ACCBuilder(),
                      SizedBox(height: 0.015 * height),
                      controller.SelectTYPE_CUR=='1'?
                      controller.SelectDataSSID!='203'?
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                              child: DropdownTYPE_CURBuilder(context)
                          ),
                          Expanded(
                              child: DropdownSYS_CURBuilder(context)
                          ),
                        ],
                      )
                      : DropdownSYS_CURBuilder(context)
                          :DropdownTYPE_CURBuilder(context),
                           SizedBox(height: 0.015 * height),
                      //من السنه الى السنه
                      if(controller.SelectDataSSID!='203')
                      Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Expanded(
                                child: Container(
                                    margin: EdgeInsets.only(left:  0.02 * width),
                                    decoration: BoxDecoration(
                                        color: Colors.white,
                                        borderRadius: BorderRadius.circular(
                                            0.02 * width)),
                                    child: Column(
                                      children: [
                                        Text((controller.SelectFromYear == null ?
                                        controller.SelectFromYear = controller.dateFromYear.toString().split(" ")[0] :
                                        controller.SelectFromYear.toString()),style:
                                        ThemeHelper().buildTextStyle(context, Colors.black,'M'),),
                                        SizedBox(
                                          width: 0.3 * width,
                                          child: MaterialButton(
                                            onPressed: () {
                                              buildShowDialogSYS_YEA(context);
                                            },
                                            color: AppColors.MainColor,
                                            child: ThemeHelper().buildText(context,'StringSYID_F', Colors.white,'M'),
                                          ),
                                        ),
                                      ],
                                    )),
                              ),
                              Expanded(
                                child: Container(
                                    margin: EdgeInsets.only(
                                        right: 0.02 * height),
                                    decoration: BoxDecoration(
                                        color: Colors.white,
                                        borderRadius: BorderRadius.circular(
                                            0.02 * width)),
                                    child: Column(
                                      children: [
                                        Text(controller.SelectToYear == null
                                            ? controller.SelectToYear = controller.dateFromYear.toString()
                                            : controller.SelectToYear.toString(),style:
                                        ThemeHelper().buildTextStyle(context, Colors.black,'M'),),
                                        SizedBox(
                                          width: 0.3 * width,
                                          child: MaterialButton(
                                            onPressed: () {
                                              buildShowDialogSYS_YEA2(context);
                                            },
                                            color: AppColors.MainColor,
                                            child: ThemeHelper().buildText(context,'StringSYID_T', Colors.white,'M'),
                                          ),
                                        ),
                                      ],
                                    )),
                              ),
                            ],
                          ),
                        ],
                      ),
                      SizedBox(height: 0.015 * height),
                      //من تاريخ الى تاريخ
                      Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Expanded(
                                child: Container(
                                    margin:
                                    EdgeInsets.only(left: 0.02 * height),
                                    decoration: BoxDecoration(
                                        color: Colors.white,
                                        borderRadius: BorderRadius.circular(
                                            0.02 * width)),
                                    child: Column(
                                      children: [
                                        Text((controller.SelectFromDays == null ? controller.SelectFromDays =
                                        controller.dateFromDays.toString().split(" ")[0] :
                                        controller.SelectFromDays.toString()).split(" ")[0],
                                        style:  ThemeHelper().buildTextStyle(context, Colors.black,'M'),),
                                        SizedBox(
                                          width: 0.3 * width,
                                          child: MaterialButton(
                                            onPressed: () {
                                              controller.selectDateFromDays(context);
                                            },
                                            color: AppColors.MainColor,
                                            child: ThemeHelper().buildText(context,'StringFromDate', Colors.white,'M'),
                                          ),
                                        ),
                                      ],
                                    )),
                              ),
                              Expanded(
                                child: Container(
                                    margin: EdgeInsets.only(right: 0.02 * height),
                                    decoration: BoxDecoration(color: Colors.white,
                                        borderRadius: BorderRadius.circular(0.002* height)),
                                    child: Column(
                                      children: [
                                        Text(controller.SelectToDays == null
                                            ? controller.SelectToDays = controller.dateTimeToDays.toString().split(" ")[0]
                                            : controller.SelectToDays.toString().split(" ")[0],
                                          style:  ThemeHelper().buildTextStyle(context, Colors.black,'M'),),
                                        SizedBox(
                                          width: 0.3 * width,
                                          child: MaterialButton(
                                            onPressed: () {
                                              controller.selectDateToDays(context);
                                            },
                                            color: AppColors.MainColor,
                                            child: ThemeHelper().buildText(context,'StringToDate', Colors.white,'M'),
                                          ),
                                        ),
                                      ],
                                    )),
                              ),
                            ],
                          ),
                        ],
                      ),
                      SizedBox(height: 0.015 * height),
                      controller.SelectDataSSID!='203'?
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          ThemeHelper().buildText(context,'StringAdditional_Data', Colors.black,'L'),
                          Checkbox(
                            value: controller.value,
                            onChanged: (value) {
                              if(controller.value1==true  ){
                                controller.value1=false;
                                controller.value = value!;
                                controller.update();
                              }
                              else{
                                controller.value = value!;
                                controller.update();
                              }
                              controller.update();
                            },
                            activeColor: AppColors.MainColor,
                          ),
                        ],
                      ):
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          ThemeHelper().buildText(context,'StringV_SUN_ACC', Colors.black,'M'),
                          Checkbox(
                            value: controller.V_SUN_ACC,
                            onChanged: (value) {
                                controller.V_SUN_ACC = value!;
                              controller.update();
                            },
                            activeColor: AppColors.MainColor,
                          ),
                        ],
                      ),
                     if(controller.value)
                      Padding(
                        padding:  EdgeInsets.all( 0.002 * width),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                ThemeHelper().buildText(context,'StringPRI_MAT', Colors.black,'M'),
                                Checkbox(
                                  value: controller.PRI_MAT,
                                  onChanged: (value) {
                                    controller.PRI_MAT = value!;
                                      controller.update();
                                  },
                                  activeColor: AppColors.MainColor,
                                ),
                              ],
                            ),
                            SizedBox(height:0.02 * height),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                ThemeHelper().buildText(context,'StringPRI_MAT2', Colors.black,'M'),
                                Checkbox(
                                  value: controller.PRI_MAT2,
                                  onChanged: (value) {
                                    controller.PRI_MAT2 = value!;
                                    controller.update();
                                  },
                                  activeColor: AppColors.MainColor,
                                ),
                              ],
                            ),
                            SizedBox(height:0.02 * height),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                ThemeHelper().buildText(context,'StringNot_Last_Balance', Colors.black,'M'),
                                Checkbox(
                                  value: controller.NOT_INC_LAS,
                                  onChanged: (value) {
                                    controller.NOT_INC_LAS = value!;
                                    controller.update();
                                  },
                                  activeColor: AppColors.MainColor,
                                ),
                              ],
                            ),
                            SizedBox(height:0.02 * height),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                ThemeHelper().buildText(context,'StringPRI_BIL_NOT', Colors.black,'M'),
                                Checkbox(
                                  value: controller.PRI_BIL_NOT,
                                  onChanged: (value) {
                                    controller.PRI_BIL_NOT = value!;
                                    controller.update();
                                  },
                                  activeColor: AppColors.MainColor,
                                ),
                              ],
                            ),
                            SizedBox(height:0.02 * height),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                ThemeHelper().buildText(context,'StringVIE_BY_LOC_CUR', Colors.black,'M'),
                                Checkbox(
                                  value: controller.VIE_BY_LOC_CUR,
                                  onChanged: (value) {
                                    controller.VIE_BY_LOC_CUR = value!;
                                    controller.update();
                                  },
                                  activeColor: AppColors.MainColor,
                                ),
                              ],
                            ),
                            SizedBox(height:0.02 * height),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                ThemeHelper().buildText(context,'StringEQ_V', Colors.black,'M'),
                                Checkbox(
                                  value: controller.EQ_V,
                                  onChanged: (value) {
                                    controller.EQ_V = value!;
                                    controller.update();
                                  },
                                  activeColor: AppColors.MainColor,
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: 0.015 * height),
                      MaterialButton(
                        onPressed: () async {
                          controller.arrlengthM=-1;
                          controller.arrlength=-1;
                        if(controller.UPQR==1){
                          if (controller.TYPY!=3 && controller.SelectDataAANO==null) {
                            Fluttertoast.showToast(
                                msg: 'StringvalidateAANO'.tr,
                                textColor: Colors.white,
                                backgroundColor: Colors.red);
                          }
                          else if (controller.TYPY==3 && controller.SelectDataACNO_F==null) {
                            Fluttertoast.showToast(
                                msg: 'StringCHI_ACNO'.tr,
                                textColor: Colors.white,
                                backgroundColor: Colors.red);
                          }
                          else if (controller.SelectTYPE_CUR=='1' && controller.SelectDataSCID == null) {
                            Fluttertoast.showToast(
                                msg: 'StringvalidateSCID'.tr,
                                textColor: Colors.white,
                                backgroundColor: Colors.red);
                         }
                          else if (controller.SelectDataFromBIID==null && controller.SelectDataToBIID == null) {
                            Fluttertoast.showToast(
                                msg: 'StringBrach'.tr,
                                textColor: Colors.white,
                                backgroundColor: Colors.red);
                          } else{
                            EasyLoading.instance
                              ..displayDuration = const Duration(milliseconds: 2000)
                              ..indicatorType = EasyLoadingIndicatorType.fadingCircle
                              ..loadingStyle = EasyLoadingStyle.custom
                              ..indicatorSize = 55.0
                              ..radius = 10.0
                              ..progressColor = Colors.white
                              ..backgroundColor = Colors.green
                              ..indicatorColor = Colors.white
                              ..textColor = Colors.white
                              ..maskColor = Colors.blue.withOpacity(0.5)
                              ..userInteractions = false
                              ..dismissOnTap = false;
                            EasyLoading.show();
                            controller.GET_BIL_ACC_D_P(controller.SelectDataAANO.toString(),
                                controller.SelectTYPE_CUR.toString(),controller.SelectDataSCID.toString());
                            controller.Socket_IP(LoginController().IP,int.parse(LoginController().PORT));
                          }
                        }
                        else{
                          Get.snackbar('StringAcc_Statement'.tr, 'String_CHK_Acc_Statement'.tr,
                              backgroundColor: Colors.red, icon: const Icon(Icons.error,color:Colors.white),
                              colorText:Colors.white,
                              isDismissible: true,
                              dismissDirection: DismissDirection.horizontal,
                              forwardAnimationCurve: Curves.easeOutBack);
                        }
                        },
                        child: Container(
                          height: 0.05 * height,
                          width: 2 * width,
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                              color: AppColors.MainColor,
                              borderRadius:
                                  BorderRadius.circular(0.02 * height)),
                          child:  ThemeHelper().buildText(context,'StringShow', Colors.white,'L'),
                        ),
                      ),
                      SizedBox(height: 0.02 * height),
                    ],
                  ),
                ),
              ),
            ),
          );
        }));
  }

  final List<Map> TYPE_CUR_LIST = [
    {"id": '1', "name": 'StringCUR_T'.tr},
    {"id": '2', "name": 'StringCUR_T2'.tr}
  ].obs;

  FutureBuilder<List<Bra_Inf_Local>> DropdownBra_InfBuilder(BuildContext context) {
    double width= MediaQuery.of(context).size.width;
    return FutureBuilder<List<Bra_Inf_Local>>(
        future:  GET_BRA(2),
        builder: (BuildContext context,
            AsyncSnapshot<List<Bra_Inf_Local>> snapshot) {
          if (!snapshot.hasData) {
            return Dropdown(josnStatus: josnStatus, GETSTRING: '',);
          }
          return Padding(padding: EdgeInsets.only(left: 0.015 * width),
            child: DropdownButtonFormField2(
              decoration: ThemeHelper().InputDecorationDropDown(" ${'StringBIID_FlableText'.tr}"),
              isExpanded: true,
              hint: ThemeHelper().buildText(context,'StringFromBrach', Colors.grey,'S'),
              value: controller.SelectDataFromBIID,
              style: ThemeHelper().buildTextStyle(context, Colors.black,'M'),
              items: snapshot.data!
                  .map((item) => DropdownMenuItem<String>(
                value: item.BIID.toString(),
                child: Text(
                  item.BINA_D.toString(),
                  style:  ThemeHelper().buildTextStyle(context, Colors.black,'M'),
                ),
              ))
                  .toList()
                  .obs,
              onChanged: (value) {
                controller.SelectDataFromBIID = value.toString();
              },
            ),
          );
        });
  }

  FutureBuilder<List<Bra_Inf_Local>> DropdownBra_Inf_ToBuilder(BuildContext context) {
    double width= MediaQuery.of(context).size.width;
    return FutureBuilder<List<Bra_Inf_Local>>(
        future:  GET_BRA(2),
        builder: (BuildContext context,
            AsyncSnapshot<List<Bra_Inf_Local>> snapshot) {
          if (!snapshot.hasData) {
            return Dropdown(josnStatus: josnStatus, GETSTRING: '',);
          }
          return  Padding(padding: EdgeInsets.only(right: 0.015 * width),
              child:DropdownButtonFormField2(
            decoration: ThemeHelper().InputDecorationDropDown(" ${'StringBIID_TlableText'.tr}"),
            isExpanded: true,
            hint: ThemeHelper().buildText(context,'StringToBrach', Colors.grey,'S'),
            value: controller.SelectDataToBIID,
            style: ThemeHelper().buildTextStyle(context, Colors.black,'M'),
            items: snapshot.data!.map((item) => DropdownMenuItem<String>(
              value: item.BIID.toString(),
              child: Text(
                item.BINA_D.toString(),
                style: ThemeHelper().buildTextStyle(context, Colors.black,'M'),
              ),
            ))
                .toList()
                .obs,
            onChanged: (value) {
              controller.SelectDataToBIID = value.toString();
            },
          ));
        });
  }

  FutureBuilder<List<Sys_Cur_Local>> DropdownSYS_CURBuilder(BuildContext context) {
    double width= MediaQuery.of(context).size.width;
    return FutureBuilder<List<Sys_Cur_Local>>(
        future: GET_SYS_CUR(),
        builder: (BuildContext context,
            AsyncSnapshot<List<Sys_Cur_Local>> snapshot) {
          if (!snapshot.hasData) {
            return Dropdown(
              josnStatus: josnStatus,
              GETSTRING: 'StringChi_currency'.tr,
            );
          }
          return Padding(
            padding:  EdgeInsets.only(right: 0.015 * width),
            child: DropdownButtonFormField2(
              decoration: ThemeHelper().InputDecorationDropDown(" ${'StringSCIDlableText'.tr}"),
              isExpanded: true,
              hint: ThemeHelper().buildText(context,'StringChi_currency', Colors.grey,'S'),
              value: controller.SelectDataSCID,
              style: ThemeHelper().buildTextStyle(context, Colors.black,'M'),
              items: snapshot.data!
                  .map((item) => DropdownMenuItem<String>(
                onTap: () {
                  controller.SCNA = item.SCNA_D.toString();
                  controller.SCSY = item.SCSY.toString();
                },
                value: item.SCID.toString(),
                child: Text(
                  item.SCNA_D.toString(),
                  style:ThemeHelper().buildTextStyle(context, Colors.black,'M'),
                ),
              ))
                  .toList()
                  .obs,
              onChanged: (value) {
                controller.SelectDataSCID = value.toString();
              },
            ),
          );
        });
  }

  GetBuilder<Account_Statement_Controller> DropdownTYPE_CURBuilder(BuildContext context) {
    double width= MediaQuery.of(context).size.width;
    return GetBuilder<Account_Statement_Controller>(
        init: Account_Statement_Controller(),
        builder: ((controller) => Padding(padding: EdgeInsets.only(left: 0.015 * width),
          child: DropdownButtonFormField2(
            decoration: ThemeHelper().InputDecorationDropDown(" ${'StringSCIDlableText'.tr}"),
            isExpanded: true,
            value: controller.SelectTYPE_CUR,
            style: ThemeHelper().buildTextStyle(context, Colors.black,'M'),
            items: TYPE_CUR_LIST
                .map((item) => DropdownMenuItem<String>(
              value: item['id'],
              child: Text(
                item['name'],
                style: ThemeHelper().buildTextStyle(context, Colors.black,'M'),
              ),
            )).toList().obs,
            onChanged: (value) {
              //Do something when changing the item if you want.
              controller.SelectTYPE_CUR = value.toString();
              controller.update();
              if (controller.SelectTYPE_CUR=='2'){
                controller.SelectDataSCID=null;
              }
            },
          ),
        )));
  }

  FutureBuilder<List<Acc_Cos_Local>> DropdownFrom_ACC_COSBuilder(BuildContext context,int TY) {
    double width= MediaQuery.of(context).size.width;
    return FutureBuilder<List<Acc_Cos_Local>>(
        future: GET_ACC_COS(),
        builder: (BuildContext context,
            AsyncSnapshot<List<Acc_Cos_Local>> snapshot) {
          if (!snapshot.hasData) {
            return Dropdown(
              josnStatus: josnStatus,
              GETSTRING: 'StringBrach',
            );
          }
          return Padding(padding: EdgeInsets.only( left: controller.TYPY==3?0:0.015 * width),
              child:DropdownButtonFormField2(
            decoration: ThemeHelper().InputDecorationDropDown(" ${TY==1?'StringACNOlableText'.tr:'StringACNO_FlableText'.tr}"),
            isExpanded: true,
            hint: ThemeHelper().buildText(context,TY==1?'StringACNOlableText'.tr:'StringChi_ACNO', Colors.grey,'S'),
            value: controller.SelectDataACNO_F,
            style: ThemeHelper().buildTextStyle(context, Colors.black,'M'),
            items: snapshot.data!
                .map((item) => DropdownMenuItem<String>(
              value: item.ACNO.toString(),
              child: Text(
                item.ACNA_D.toString(),
                style: ThemeHelper().buildTextStyle(context, Colors.black,'M'),
              ),)).toList().obs,
            onChanged: (value) {
              controller.SelectDataACNO_F = value.toString();
              controller.update();
            },
          ));
        });
  }

  FutureBuilder<List<Acc_Cos_Local>> DropdownTo_ACC_COSBuilder(BuildContext context) {
    double width= MediaQuery.of(context).size.width;
    return FutureBuilder<List<Acc_Cos_Local>>(
        future: GET_ACC_COS(),
        builder: (BuildContext context,
            AsyncSnapshot<List<Acc_Cos_Local>> snapshot) {
          if (!snapshot.hasData) {
            return Dropdown(
              josnStatus: josnStatus,
              GETSTRING: 'StringBrach',
            );
          }
          return Padding(padding: EdgeInsets.only(right: 0.015 * width),
              child:DropdownButtonFormField2(
            decoration: ThemeHelper().InputDecorationDropDown(" ${'StringACNO_TlableText'.tr}"),
            isExpanded: true,
            hint:ThemeHelper().buildText(context,'StringChi_ACNO', Colors.grey,'S'),
            value: controller.SelectDataACNO_T,
            style: ThemeHelper().buildTextStyle(context, Colors.black,'M'),
            items: snapshot.data!
                .map((item) => DropdownMenuItem<String>(
              value: item.ACNO.toString(),
              child: Text(
                item.ACNA_D.toString(),
                style: ThemeHelper().buildTextStyle(context, Colors.black,'M'),
              ),)).toList().obs,
            onChanged: (value) {
              controller.SelectDataACNO_T = value.toString();
              controller.update();
            },
          ));
        });
  }

  GetBuilder<Account_Statement_Controller> DropdownACC_ACCBuilder() {
    return GetBuilder<Account_Statement_Controller>(
        init: Account_Statement_Controller(),
        builder: ((controller) => FutureBuilder<List<Acc_Acc_Local>>(
            future: query_Acc_Acc(LoginController().BIID.toString(),controller.SelectDataSSID.toString()),
            builder: (BuildContext context,
                AsyncSnapshot<List<Acc_Acc_Local>> snapshot) {
              if (!snapshot.hasData) {
                return Dropdown(
                  josnStatus: josnStatus,
                  GETSTRING: 'StringAccount'.tr,
                );
              }
              return DropdownButtonFormField2(
                decoration: ThemeHelper().InputDecorationDropDown(" ${controller.TYPY==3?'StringAANO_F'.tr:
                'StringAccount'.tr}"),
                dropdownStyleData: const DropdownStyleData(
                  maxHeight: 400,
                ),
                isDense: true,
                isExpanded: true,
                hint:  ThemeHelper().buildText(context,controller.TYPY==3?'StringAANO_F'.tr:
               'StringAccount', Colors.grey,'S'),
                iconStyleData: IconStyleData(
                  icon: snapshot.connectionState == ConnectionState.waiting
                      ? const SizedBox(
                    width: 24,
                    height: 24,
                    child: CircularProgressIndicator(
                      strokeWidth: 2,
                      color: Colors.black45,
                    ),
                  )
                      : const Icon(
                    Icons.arrow_drop_down,
                    color: Colors.black45,
                  ),
                ),
                items: snapshot.data!.map((item) => DropdownMenuItem<String>(
                  onTap: (){
                    controller.AANAController.text= item.AANA_D.toString();
                    controller.AANOController.text= item.AANO.toString();
                    controller.SelectDataAANO= item.AANO.toString();
                    controller.GUIDC= item.GUID.toString();
                    controller.BCTL= item.AATL.toString();
                    controller.AAAD= item.AAAD.toString();
                  },
                  value: item.AANA_D.toString(),
                  child: Text(
                    item.AANA_D.toString(),
                    style: ThemeHelper().buildTextStyle(context, Colors.black,'M'),
                  ),
                )).toList().obs,
                value: controller.SelectDataAANO2,
                onChanged: (value) async {
                    controller.SelectDataAANO2 = value as String;
                    await controller.GET_PRIVLAGE();
                    controller.update();

                },
                dropdownSearchData: DropdownSearchData(
                    searchController: controller.TextEditingSercheController,
                    searchInnerWidget: Padding(
                      padding: const EdgeInsets.only(
                        top: 8,
                        bottom: 4,
                        right: 8,
                        left: 8,
                      ),
                      child: TextFormField(
                        controller: controller.TextEditingSercheController,
                        decoration: InputDecoration(
                          isDense: true,
                          contentPadding: const EdgeInsets.symmetric(
                            horizontal: 10,
                            vertical: 8,
                          ),
                          suffixIcon: IconButton(icon: const Icon(
                            Icons.clear,
                            size: 20,
                          ),
                            onPressed: (){
                              controller.TextEditingSercheController.clear();
                              controller.update();
                            },),
                          hintText: 'StringSearch_for_AANO'.tr,
                          hintStyle:  ThemeHelper().buildTextStyle(context, Colors.grey,'S'),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                      ),
                    ),
                    searchMatchFn: (item, searchValue) {
                      return (item.value.toString().toLowerCase().contains(searchValue));
                    },
                    searchInnerWidgetHeight: 50),

                //This to clear the search value when you close the menu
                onMenuStateChange: (isOpen) {
                  if (!isOpen) {
                    controller.TextEditingSercheController.clear();
                  }
                },
              );
            })));
  }

  GetBuilder<Account_Statement_Controller> DropdownACC_ACCBuilder_TO() {
    return GetBuilder<Account_Statement_Controller>(
        init: Account_Statement_Controller(),
        builder: ((controller) => FutureBuilder<List<Acc_Acc_Local>>(
            future: query_Acc_Acc(LoginController().BIID.toString(),controller.SelectDataSSID.toString()),
            builder: (BuildContext context,
                AsyncSnapshot<List<Acc_Acc_Local>> snapshot) {
              if (!snapshot.hasData) {
                return Dropdown(
                  josnStatus: josnStatus,
                  GETSTRING: 'StringAANO_T'.tr,
                );
              }
              return DropdownButtonFormField2(
                decoration: ThemeHelper().InputDecorationDropDown(" ${'StringAANO_T'.tr}"),
                dropdownStyleData: const DropdownStyleData(
                  maxHeight: 400,
                ),
                isDense: true,
                isExpanded: true,
                hint:  ThemeHelper().buildText(context,'StringAANO_T', Colors.grey,'S'),
                items: snapshot.data!
                    .map((item) => DropdownMenuItem<String>(
                  onTap: (){
                    controller.SelectDataAANO_T= item.AANO.toString();
                  },
                  value: item.AANA_D.toString(),
                  child: Text(
                    item.AANA_D.toString(),
                    style: ThemeHelper().buildTextStyle(context, Colors.black,'M'),
                  ),
                )).toList().obs,
                value: controller.SelectDataAANO2_T,
                onChanged: (value) async {
                    controller.SelectDataAANO2_T = value as String;
                    await controller.GET_PRIVLAGE();
                    controller.update();
                },
                dropdownSearchData: DropdownSearchData(
                    searchController: controller.TextEditingSercheController,
                    searchInnerWidget: Padding(
                      padding: const EdgeInsets.only(
                        top: 8,
                        bottom: 4,
                        right: 8,
                        left: 8,
                      ),
                      child: TextFormField(
                        controller: controller.TextEditingSercheController,
                        decoration: InputDecoration(
                          isDense: true,
                          contentPadding: const EdgeInsets.symmetric(
                            horizontal: 10,
                            vertical: 8,
                          ),
                          suffixIcon: IconButton(icon: const Icon(
                            Icons.clear,
                            size: 20,
                          ),
                            onPressed: (){
                              controller.TextEditingSercheController.clear();
                              controller.update();
                            },),
                          hintText: 'StringSearch_for_AANO'.tr,
                          hintStyle:  ThemeHelper().buildTextStyle(context, Colors.grey,'S'),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                      ),
                    ),
                    searchMatchFn: (item, searchValue) {
                      return (item.value.toString().toLowerCase().contains(searchValue));
                    },
                    searchInnerWidgetHeight: 50),
                //This to clear the search value when you close the menu
                onMenuStateChange: (isOpen) {
                  if (!isOpen) {
                    controller.TextEditingSercheController.clear();
                  }
                },
              );
            })));
  }

  Future<dynamic> buildShowDialogSYS_YEA(BuildContext context) {
    return Get.defaultDialog(
      title: "StringCHI_SYID".tr,
      content:Container(
        width: 200,
        height: 130,
        child: ListView.separated(
            shrinkWrap: true,
            itemCount: controller.SYS_YEA.length,
            itemBuilder: (context,index){
              return GestureDetector(
                child: Text(controller.SYS_YEA[index].SYNO.toString()),
                onTap: (){
                controller.SelectFromYear=controller.SYS_YEA[index].SYNO.toString();
                print(controller.SelectFromYear);
                print('SelectFromYear');
                controller.SYID_F=controller.SYS_YEA[index].SYID;
                //controller.SelectFromYear= controller.SelectFromYear.format(DateTime(int.parse(controller.SYID_T.toString())));
                controller.update();
                Get.back();
                },
              );
            },
            separatorBuilder: (context,index){
              return const Divider(
                color: Colors.blue,
              );
            },),
      ),
      backgroundColor: Colors.white,
      radius: 40,
      // barrierDismissible: false,
    );
  }

  Future<dynamic> buildShowDialogSYS_YEA2(BuildContext context) {
    return Get.defaultDialog(
      title: "StringCHI_SYID".tr,
      content:Container(
        width: 200,
        height: 130,
        child: ListView.separated(
            shrinkWrap: true,
            itemCount: controller.SYS_YEA.length,
            itemBuilder: (context,index){
              return GestureDetector(
                child: Text(controller.SYS_YEA[index].SYNO.toString()),
                onTap: (){
                controller.SelectToYear=controller.SYS_YEA[index].SYNO.toString();
                controller.SYID_T=controller.SYS_YEA[index].SYID;
                controller.update();
                //print();
                Get.back();
                },
              );
            },
            separatorBuilder: (context,index){
              return const Divider(
                color: Colors.blue,
              );
            },),
      ),
      backgroundColor: Colors.white,
      radius: 40,
      // barrierDismissible: false,
    );
  }

}
