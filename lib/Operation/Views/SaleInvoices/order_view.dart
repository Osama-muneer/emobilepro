import 'dart:io';
import '../../../Operation/Controllers/sale_invoices_controller.dart';
import '../../../Setting/models/mat_fol.dart';
import '../../../Setting/models/mat_des_m.dart';
import '../../../Widgets/AnimatedTextWidget.dart';
import '../../../Widgets/app_extension.dart';
import '../../../Widgets/clipper.dart';
import '../../../Widgets/colors.dart';
import '../../../Widgets/config.dart';
import '../../../Widgets/counter_button.dart';
import '../../../Widgets/theme_helper.dart';
import '../../../database/invoices_db.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';

class CheckOut extends StatefulWidget {
  final bool Show;
  const CheckOut({Key? key, show = true, required this.Show}) : super(key: key);
  @override
  State<CheckOut> createState() => _CheckOutState();
}

class _CheckOutState extends State<CheckOut> {
  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return GetBuilder<Sale_Invoices_Controller>(
        init: Sale_Invoices_Controller(),
        builder: ((controller) =>
            Scaffold(
          body: Column(
            children: [
              // custom app bar
             if(controller.isTablet==false)
              if(widget.Show)
              Stack(
                children: [
                  ClipPath(
                    clipper: BottomClipper(),
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.black,
                        borderRadius: BorderRadius.only(
                          bottomLeft: Radius.circular(30),
                          bottomRight: Radius.circular(30),
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: 5, left: 10, right: 10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        IconButton(
                          onPressed: () {
                            controller.CheckOutTemplate=0;
                            controller.update();
                            Navigator.pop(context);
                          },
                          icon: Icon(
                            Icons.close,
                            color: Colors.black,
                          ),
                        ),
                        Text(
                          controller.TYPE_ORDER==1?'StringOrder'.tr:'StringMOV_M_DATA'.tr,
                          style: ThemeHelper().buildTextStyle(context,AppColors.black,'L'),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
             //// الاصناف
              Expanded(
                child: ListView.separated(
                  padding: const EdgeInsets.all(2),
                  shrinkWrap: true,
                  itemCount: controller.cartFood.length,
                  itemBuilder: (_, index) {
                    return controller.cartFood[index].SYST==1 ?
                    InkWell(
                      onTap: () async {
                        if (controller.SHOW_MAT_DES == false) {
                          controller.update();
                          await controller.GET_MAT_DES_M_P(controller.cartFood[index].MGNO.toString()
                              ,controller.cartFood[index].MINO.toString());
                          controller.update();
                          controller.BMDID_L = controller.cartFood[index].BMDID;
                          controller.SHOW_MAT_DES(true);
                          print('controller.MAT_DES_M.length');
                          print(controller.MAT_DES_M.length);
                          controller.update();
                        } else {
                          controller.SHOW_MAT_DES(false);
                          controller.BMDID_L = 0;
                          controller.MAT_DES_M.clear();
                          controller.update();
                        }
                      },
                      child: Column(
                        children: [
                          Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(15),
                              color: Colors.white,
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                SizedBox(height: 0.01 * height),
                                ClipOval(
                                    child: Image.file(File("${SignPicture_MAT}${controller.cartFood[index].MGNO}-${controller.cartFood[index].MINO}.png"),
                                      errorBuilder: (BuildContext context, Object exception, StackTrace? stackTrace) {
                                        return Image.asset(ImageEORDPOS, fit:BoxFit.fill,height: 0.05 *height);
                                      },
                                      fit: BoxFit.fill,height:0.05 *height ,)
                                ),
                                SizedBox(width: 0.03 * width),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    controller.cartFood[index].NAM.toString().length >= 25 ?
                                    SizedBox(
                                        width: MediaQuery.of(context).size.width * 0.56,
                                        child: AnimatedTextWidget(text:controller.cartFood[index].NAM.toString())):
                                    Text(controller.cartFood[index].NAM.toString(),
                                      style:  ThemeHelper().buildTextStyle(context, Colors.black, 'M'),
                                    ),
                                    SizedBox(width: 0.03 * width),
                                    Text(
                                      "${controller.formatter.format(controller.cartFood[index].BMDAM).toString()}",
                                      style:  ThemeHelper().buildTextStyle(context, Colors.black,'M'),
                                    ),
                                  ],
                                ),
                                const Spacer(),
                                Column(
                                  children: [
                                    CounterButton(
                                      onIncrementSelected: () => controller.UPDATE_BIF_MOV_D_ORD(controller.cartFood[index],1),
                                      onDecrementSelected: () => controller.UPDATE_BIF_MOV_D_ORD(controller.cartFood[index],2),
                                      size: controller.cartFood[index].SYST==1?const Size(0, 0):
                                      Size(0.053* height, 0.053* height),
                                      padding: 0,
                                      label: Text(
                                        controller.formatter.format(controller.cartFood[index].BMDNO).toString(),
                                        style:  ThemeHelper().buildTextStyle(context, Colors.black,'M'),
                                      ),
                                    ),
                                    Text(
                                        controller.formatter.format(controller.cartFood[index].BMDAMT).toString(),
                                        style:  ThemeHelper().buildTextStyle(context, Colors.black,'M')
                                    )
                                  ],
                                )
                              ],
                            ),
                          ).fadeAnimation(index * 0.1),
                          // Column(
                          //   children: [
                          //     Expanded(
                          //       child: MAT_FOL_BULDER(height,controller.cartFood[index].BMMID.toString()
                          //           ,controller.cartFood[index].BMDID.toString(),
                          //           controller.cartFood[index].MGNO.toString(),
                          //           controller.cartFood[index].MINO.toString()),
                          //     ),
                          //     // MAT_DES_M_BUILDER(height,controller.cartFood[index].BMMID.toString()
                          //     //     ,controller.cartFood[index].BMDID.toString()),
                          //     SizedBox(height: 2.5,)
                          //   ],
                          // ),
                          MAT_FOL_BULDER(height,controller.cartFood[index].BMMID.toString()
                              ,controller.cartFood[index].BMDID.toString(),
                              controller.cartFood[index].MGNO.toString(),
                              controller.cartFood[index].MINO.toString()),
                          MAT_FOL_BUILDER(controller.cartFood[index].MGNO.toString(),
                          controller.cartFood[index].MINO.toString()),
                        ],
                      ),
                    ):
                    Dismissible(
                      onDismissed: (direction) async {
                        if (direction == DismissDirection.startToEnd) {
                         await deleteBIL_MOV_D_ONE('BIF_MOV_D',controller.cartFood[index].BMMID.toString(),
                              controller.cartFood[index].BMDID.toString());
                          controller.cartFood.removeAt(index);
                            await controller.GET_SUMBMMAM();
                            await controller.GET_SUMBMMAM2();
                            await controller.GET_SUMBMDTXA();
                            await controller.GET_SUMBMMDIF();
                            await controller.GET_SUMBMMDI();
                            await controller.GET_CountRecode(controller.BMMID!);
                            await controller.GET_COUNT_BMDNO_P(controller.BMMID!);
                            await controller.GET_SUMBMDTXT();
                            await controller.GET_SUM_AM_TXT_DI();
                            await controller.GET_BIF_MOV_D_P(controller.BMMID.toString(),'2');
                            controller.update();

                        }
                      },
                      key: Key(controller.cartFood[index].BMDID.toString()),
                      background: Row(
                        children: [
                          Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 15,
                              vertical: 25,
                            ),
                            decoration: BoxDecoration(
                              color: Colors.redAccent,
                              borderRadius: BorderRadius.circular(15),
                            ),
                            child: const FaIcon(FontAwesomeIcons.trash),
                          ),
                        ],
                      ),
                      child: InkWell(
                        onTap: ()  async {
                          if (controller.SHOW_MAT_DES == false) {
                            controller.update();
                            await controller.GET_MAT_DES_M_P(controller.cartFood[index].MGNO.toString(),controller.cartFood[index].MINO.toString());
                            controller.update();
                            controller.BMDID_L = controller.cartFood[index].BMDID;
                            controller.SHOW_MAT_DES(true);
                            print(controller.MAT_DES_M.length);
                            controller.update();
                          }
                          else {
                            controller.SHOW_MAT_DES(false);
                            controller.BMDID_L = 0;
                            controller.MAT_DES_M.clear();
                            controller.update();
                          }
                        },
                        child: Column(
                          children: [
                            Container(
                              padding: const EdgeInsets.all(5),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(15),
                                color: Colors.white,
                              ),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                children: [
                                  SizedBox(height: 0.01 * height),
                                  ClipOval(
                                      child: Image.file(File("${SignPicture_MAT}${controller.cartFood[index].MGNO}-${controller.cartFood[index].MINO}.png"),
                                        errorBuilder: (BuildContext context, Object exception, StackTrace? stackTrace) {
                                          return Image.asset(ImageEORDPOS, fit:BoxFit.fill,height: 0.05 *height);
                                        },
                                        fit: BoxFit.fill,
                                        height: 0.05 * height,)
                                  ),
                                  //Image(image: AssetImage(ImagePath + "sushi5.png"), fit: BoxFit.fill, height: 40,),
                                  SizedBox(width: 0.03 * width),
                                  Column(
                                    mainAxisSize: MainAxisSize.min,
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      controller.cartFood[index].NAM.toString().length >= 25 ?
                                      SizedBox(
                                          width: MediaQuery.of(context).size.width * 0.56,
                                          child: AnimatedTextWidget(text:controller.cartFood[index].NAM.toString())):
                                      Text(controller.cartFood[index].NAM.toString(),
                                        style: ThemeHelper().buildTextStyle(context, Colors.black, 'M',),
                                        // overflow: TextOverflow.ellipsis,
                                        // maxLines: 1,
                                      ),
                                      SizedBox(height: 1), // لتجنب تداخل العناصر
                                      Text(
                                        "${controller.formatter.format(controller.cartFood[index].BMDAM).toString()}",
                                        style: ThemeHelper().buildTextStyle(context, Colors.black, 'M'),
                                      ),
                                    ],
                                  ),
                                  const Spacer(),
                                  Column(
                                    children: [
                                      CounterButton(
                                        onIncrementSelected: () => controller.UPDATE_BIF_MOV_D_ORD(controller.cartFood[index],1),
                                        onDecrementSelected: () => controller.UPDATE_BIF_MOV_D_ORD(controller.cartFood[index],2),
                                        size: controller.cartFood[index].SYST==1?const Size(0, 0):
                                        Size(0.027* height, 0.027* height),
                                        padding: 0,
                                        label: Text(
                                          controller.formatter.format(controller.cartFood[index].BMDNO).toString(),
                                          style: ThemeHelper().buildTextStyle(context, Colors.black,'M'),
                                        ),
                                      ),
                                      Text(controller.formatter.format(controller.cartFood[index].BMDAMT).toString(),
                                        style: ThemeHelper().buildTextStyle(context, Colors.black,'M'),
                                      )
                                    ],
                                  )
                                ],
                              ),
                            ).fadeAnimation(index * 0.1),
                            if(controller.USING_QUICK_NOTES_FOR_ITEM!='2' )
                            Column(
                              children: [
                                MAT_FOL_BULDER(height,controller.cartFood[index].BMMID.toString()
                                    ,controller.cartFood[index].BMDID.toString(),
                                    controller.cartFood[index].MGNO.toString(),
                                    controller.cartFood[index].MINO.toString()),
                                SizedBox(height: 2.5,)
                              ],
                            ),
                            MAT_FOL_BUILDER(controller.cartFood[index].MGNO.toString(),
                                controller.cartFood[index].MINO.toString()),
                          ],
                        ),
                      ),
                    );
                  },
                  separatorBuilder: (_, __) => const Padding(padding: EdgeInsets.all(5)),
                ),
              ),
              Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  // border: Border.all(color: Colors.grey)
                ),
                child:
                Column(children: [
                  SizedBox(height: 0.01 * height),
                  //انواع الدقع
                  SizedBox(
                    height:  height * 0.04,
                    child: ListView.builder(
                      physics: BouncingScrollPhysics(),
                      scrollDirection: Axis.horizontal,
                      itemCount: controller.PAY_KIN_LIST.length,
                      itemBuilder: (BuildContext context, int index) {
                        return   Padding(
                          padding: EdgeInsets.only(left: 0.01 * width, right: 0.01 * width),
                          child: TextButton(
                            onPressed: () {
                              setState(() {
                                controller.SelectDataPKID=controller.PAY_KIN_LIST[index].PKID.toString();
                                controller.PKID=controller.PAY_KIN_LIST[index].PKID;
                                controller.SelectDataBCCID=null;
                                if(controller.SelectDataBCID!=null){
                                  if(int.parse(controller.CountRecodeController.text) == 0){
                                    controller.BCPR=controller.BCPR2;
                                    controller.GET_MAT_INF_DATE(controller.SelectDataMGNO.toString(),
                                        controller.SelectDataSCID.toString(), controller.SelectDataBIID.toString(),
                                        controller.BCPR!);
                                  }
                                }else{
                                  if(int.parse(controller.CountRecodeController.text) == 0){
                                    controller.BCPR=controller.BPPR;
                                    controller.GET_MAT_INF_DATE(controller.SelectDataMGNO.toString(),
                                        controller.SelectDataSCID.toString(), controller.SelectDataBIID.toString(),
                                        controller.BCPR!);
                                  }
                                }
                                controller.update();
                              });
                            },
                            style:
                            TextButton.styleFrom(
                              side:  BorderSide(color:controller.PAY_KIN_LIST[index].PKID.toString()==controller.SelectDataPKID?
                              Colors.red:Colors.black45),
                              //foregroundColor: Colors.black,
                              // backgroundColor: Colors.grey[400],
                              shape:RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(0.01 * height), // <-- Radius
                              ),
                            ),
                            child: Text(
                                controller.PAY_KIN_LIST[index].PKNA_D.toString(),
                                style: ThemeHelper().buildTextStyle(context, controller.PAY_KIN_LIST[index].PKID.toString()==controller.SelectDataPKID?
                                Colors.red:Colors.black,'M')
                            ),
                          ).fadeAnimation(index * 0.6),
                        );
                      },
                    ),
                  ),
                  SizedBox(height: 0.01 * height),
                  Padding(
                    padding: const EdgeInsets.all(3.0),
                    child: controller.DropdownBIL_CUSBuilder(),
                  ),
                  // SizedBox(height: 0.01 * height),
                  if(controller.PKID==8)
                  Padding(
                    padding: const EdgeInsets.all(3.0),
                    child: controller.DropdownBIL_CRE_CBuilder(),
                  ),
                  SizedBox(height: 0.01 * height),
                  //محلي - سفري...
                  SizedBox(
                    height:  height * 0.04,
                    child: ListView.builder(
                      physics: BouncingScrollPhysics(),
                      scrollDirection: Axis.horizontal,
                      itemCount: controller.GET_TYP_LIST.length,
                      itemBuilder: (BuildContext context, int index) {
                        final item = controller.GET_TYP_LIST[index];
                        return   Padding(
                          padding:EdgeInsets.only(left: 0.01 * width, right: 0.01 * width),
                          child: TextButton(
                            onPressed: () async {
                                controller.SelectDataGETTYPE=item['id'].toString();
                                if(item['id'].toString()=='2'){
                                  controller.BCDNAController.clear();
                                  controller.BCDID = null;
                                  controller.GUIDC2 = null;
                                  controller.SelectDataRTID = null;
                                  controller.SelectDataREID = null;
                                  controller.BCDMOController.clear();
                                  controller.BCDNAController.clear();
                                  controller.SelectDataCWID = null;
                                  controller.SelectDataBAID = null;
                                  controller.SelectDataCTID = null;
                                  controller.SelectDataRTNA=null;
                                  controller.BCDADController.clear();
                                  controller.BCDSNController.clear();
                                  controller.BCDFNController.clear();
                                  controller.BCDBNController.clear();
                                }
                                else if (item['id'].toString()=='3'){
                                  controller.SelectDataRTID = null;
                                  controller.SelectDataREID = null;
                                  controller.SelectDataRTNA=null;

                                }
                                controller.update();
                            },
                            style:
                            TextButton.styleFrom(
                              side:  BorderSide(color:item['id'].toString()==controller.SelectDataGETTYPE? Colors.red:Colors.black45),
                              //foregroundColor: Colors.black,
                              // backgroundColor: Colors.grey[400],
                              shape:RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(0.01 * height), // <-- Radius
                              ),
                            ),
                            child: Text(item['name'].toString(),
                                style: ThemeHelper().buildTextStyle(context, item['id'].toString().toString()==controller.SelectDataGETTYPE?
                                Colors.red:Colors.black,'M')
                            ),
                          ).fadeAnimation(index * 0.6),
                        );
                      },
                    ),
                  ),
                  SizedBox(height: 0.01 * height),
                  if(controller.SelectDataGETTYPE=='3')
                  Padding(
                    padding: const EdgeInsets.all(3.0),
                    child: controller.DropdownBIL_DIS_ORDBuilder(),
                  ),
                 // SizedBox(height: 0.01 * height),
                  if(controller.SelectDataGETTYPE=='3')
                  Padding(
                    padding: const EdgeInsets.all(3.0),
                    child: controller.DropdownBIF_CUS_DBuilder(),
                  ),
                  if(controller.SelectDataGETTYPE=='1' )
                    SizedBox(
                      height: height * 0.04,
                      child: ListView.builder(
                        physics: const BouncingScrollPhysics(),
                        scrollDirection: Axis.horizontal,
                        itemCount: controller.RES_EMP.length,
                        itemBuilder: (BuildContext context, int index) {
                          final employee = controller.RES_EMP[index];
                          final isSelected = employee.REID.toString() == controller.SelectDataREID.toString();
                          return Padding(
                            padding: EdgeInsets.symmetric(horizontal: width * 0.01),
                            child: TextButton(
                              onPressed: () {
                                // تغيير حالة التحديد: إذا كان الموظف مختاراً نلغيه، وإلا نختاره
                                controller.SelectDataREID = isSelected
                                    ? null
                                    : employee.REID.toString();
                                controller.update();
                              },
                              style: TextButton.styleFrom(
                                side: BorderSide(
                                  color: controller.RES_EMP[index].REID.toString()==controller.SelectDataREID?
                                  Colors.red:Colors.black45,
                                ),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(height * 0.01),
                                ),
                              ),
                              child: Text(
                                employee.RENA_D.toString(),
                                style: ThemeHelper().buildTextStyle(
                                  context,
                                  controller.RES_EMP[index].REID.toString()==controller.SelectDataREID?
                                  Colors.red:Colors.black,
                                  'M',
                                ),
                              ),
                            ).fadeAnimation(index * 0.1),
                          );
                        },
                      ),
                    )
                ],),),
              Padding(
                padding: const EdgeInsets.all(5.0),
                child: Container(
                  decoration:  BoxDecoration(
                    color: Colors.white,
                    border: Border.all(color: Colors.grey),
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(0.01 * height),
                        topRight: Radius.circular(0.01 * height),
                        bottomLeft: Radius.circular(0.01 * height),
                        bottomRight: Radius.circular(0.01 * height)
                    ),
                  ),
                  child: Padding(
                    padding:  EdgeInsets.all( 0.01 * height),
                    child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 20),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text("${'StrinCount_SMDFN'.tr}", style:  ThemeHelper().buildTextStyle(context, Colors.black,'M')),
                              Text("${controller.formatter.format(double.parse(controller.BMMAMController.text)).toString()}", style:
                              ThemeHelper().buildTextStyle(context, Colors.black,'M'),),
                            ],
                          ).fadeAnimation(0 * 0.6),
                        ),

                        double.parse(controller.SUMBMDTXTController.text)>0?Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 20),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text("StringSUM_BMMTX_ORD".tr, style:
                              ThemeHelper().buildTextStyle(context, Colors.black,'M'),),
                              Text(controller.formatter.format(double.parse(controller.SUMBMDTXTController.text)).toString()
                                , style: ThemeHelper().buildTextStyle(context, Colors.black,'M'),
                              ),
                            ],
                          ).fadeAnimation(1 * 0.6),
                        ):
                        Container(),
                        const Padding(
                          padding: EdgeInsets.symmetric(horizontal: 20),
                          child: Divider(thickness: 4.0, height: 10.0),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 20),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text('StringNet_Amount'.tr, style:
                              ThemeHelper().buildTextStyle(context, Colors.red,'M'),),
                              Text(controller.formatter.format(double.parse(controller.BMMAMTOTController.text)).toString(),
                                style:
                                ThemeHelper().buildTextStyle(context, Colors.black,'M'),
                              ),
                            ],
                          ).fadeAnimation(2 * 0.6),
                        ),
                      ],
                    ).fadeAnimation(0 * 0.1),
                  ),
                ),
              ),
              MaterialButton(
                onPressed: () async {
                  if(controller.ASK_SAVE=='1'){
                    Get.defaultDialog(
                      title: 'StringMestitle'.tr,
                      middleText: 'StringMessave'.tr,
                      backgroundColor: Colors.white,
                      radius: 40,
                      textCancel: 'StringNo'.tr,
                      cancelTextColor: Colors.red,
                      textConfirm: 'StringYes'.tr,
                      confirmTextColor: Colors.white,
                      onConfirm: () {
                        Navigator.of(context).pop(false);
                        if (controller.SelectDataBCID!=null &&
                            controller.PKID_C == 1 &&
                            (controller.PKID == 3 || controller.PKID == 2) ) {
                          Get.defaultDialog(
                            title: 'StringMestitle'.tr,
                            middleText: 'StringCHK_PKID_C'.tr,
                            backgroundColor: Colors.white,
                            radius: 40,
                            textCancel: 'StringOK'.tr,
                            cancelTextColor: Colors.blueAccent,
                            barrierDismissible: false,
                          );
                        }
                        else if (controller.SelectDataBCID!=null &&
                            controller.PKID_C == 3 &&
                            controller.PKID == 1) {
                          Get.defaultDialog(
                            title: 'StringMestitle'.tr,
                            middleText: 'StringCHK_PKID_C'.tr,
                            backgroundColor: Colors.white,
                            radius: 40,
                            textCancel: 'StringOK'.tr,
                            cancelTextColor: Colors.blueAccent,
                            barrierDismissible: false,
                          );
                        }
                        else if (controller.SelectDataBCID!=null &&
                            controller.PKID_C == 2 &&
                            controller.PKID == 1) {
                          Get.defaultDialog(
                            title: 'StringMestitle'.tr,
                            middleText: 'StringCHK_PKID_C'.tr,
                            backgroundColor: Colors.white,
                            radius: 40,
                            textCancel: 'StringOK'.tr,
                            cancelTextColor: Colors.blueAccent,
                            barrierDismissible: false,
                          );
                        }
                        else {
                          if (((controller.BMKID == 11 || controller.BMKID == 12 ) &&
                              controller.SHOW_BDID == '3') &&
                              controller.SelectDataBDID == null ||
                              ((controller.BMKID != 11 && controller.BMKID != 12) &&
                                  controller.SHOW_BDID == '2') &&
                                  controller.SelectDataBDID == null) {
                            Get.defaultDialog(
                              title: 'StringMestitle'.tr,
                              middleText: 'StringErr_BDID'.tr,
                              backgroundColor: Colors.white,
                              radius: 40,
                              textCancel: 'StringNo'.tr,
                              cancelTextColor: Colors.red,
                              textConfirm: 'StringYes'.tr,
                              confirmTextColor: Colors.white,
                              onConfirm: () {
                                Navigator.of(context).pop(false);
                                controller.editMode();

                              },
                            );
                          }
                          else {
                            controller.editMode();
                          }
                        }
                      },
                      // barrierDismissible: false,
                    );
                  }else{
                    if (controller.SelectDataBCID!=null &&
                        controller.PKID_C == 1 &&
                        (controller.PKID == 3 || controller.PKID == 2) ) {
                      Get.defaultDialog(
                        title: 'StringMestitle'.tr,
                        middleText: 'StringCHK_PKID_C'.tr,
                        backgroundColor: Colors.white,
                        radius: 40,
                        textCancel: 'StringOK'.tr,
                        cancelTextColor: Colors.blueAccent,
                        barrierDismissible: false,
                      );
                    }
                    else if (controller.SelectDataBCID!=null && controller.PKID_C == 3 && controller.PKID == 1) {
                      Get.defaultDialog(
                        title: 'StringMestitle'.tr,
                        middleText: 'StringCHK_PKID_C'.tr,
                        backgroundColor: Colors.white,
                        radius: 40,
                        textCancel: 'StringOK'.tr,
                        cancelTextColor: Colors.blueAccent,
                        barrierDismissible: false,
                      );
                    }
                    else if (controller.SelectDataBCID!=null &&
                        controller.PKID_C == 2 &&
                        controller.PKID == 1) {
                      Get.defaultDialog(
                        title: 'StringMestitle'.tr,
                        middleText: 'StringCHK_PKID_C'.tr,
                        backgroundColor: Colors.white,
                        radius: 40,
                        textCancel: 'StringOK'.tr,
                        cancelTextColor: Colors.blueAccent,
                        barrierDismissible: false,
                      );
                    }
                    else {
                      if (((controller.BMKID == 11 || controller.BMKID == 12 ) &&
                          controller.SHOW_BDID == '3') &&
                          controller.SelectDataBDID == null ||
                          ((controller.BMKID != 11 && controller.BMKID != 12) &&
                              controller.SHOW_BDID == '2') &&
                              controller.SelectDataBDID == null) {
                        Get.defaultDialog(
                          title: 'StringMestitle'.tr,
                          middleText: 'StringErr_BDID'.tr,
                          backgroundColor: Colors.white,
                          radius: 40,
                          textCancel: 'StringNo'.tr,
                          cancelTextColor: Colors.red,
                          textConfirm: 'StringYes'.tr,
                          confirmTextColor: Colors.white,
                          onConfirm: () {
                            Navigator.of(context).pop(false);
                            controller.editMode();

                          },
                        );
                      }
                      else {
                        controller.editMode();
                      }
                    }
                  }
                },
                child: Container(
                  height: 0.04 * height,
                  // width: 330.w,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(color: AppColors.MainColor,
                      borderRadius: BorderRadius.circular(5)),
                  child: Text('StringSave'.tr, style:  ThemeHelper().buildTextStyle(context, Colors.white,'L'),
                  ),
                ).fadeAnimation(0 * 0.6),
              ),
              // content checkout
            ],
          ),
        )
        )
    );
  }

  GetBuilder<Sale_Invoices_Controller> MAT_FOL_BUILDER(MGNO,MINO) {
    return GetBuilder<Sale_Invoices_Controller>(
        init: Sale_Invoices_Controller(),
        builder: ((controller) => FutureBuilder<List<Mat_Fol_Local>>(
              future: GET_MAT_FOL(controller.SelectDataBIID.toString(), MGNO, MINO,),
              builder: (BuildContext context, AsyncSnapshot<List<Mat_Fol_Local>> snapshot) {
                if (!snapshot.hasData || snapshot.data!.isEmpty) {
                  return Container(); // إرجاع عنصر فارغ إذا لم توجد بيانات
                }
                return SizedBox(
                  height: 30,
                  child: ListView.builder(
                    physics: BouncingScrollPhysics(),
                   // shrinkWrap: true,
                    scrollDirection: Axis.horizontal,
                    itemCount: snapshot.data!.length,
                    itemBuilder: (BuildContext context, int index) {
                      final item = snapshot.data![index];
                      return Padding(
                        padding: EdgeInsets.symmetric(horizontal: 3),
                        child: Container(
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(8),
                            border: Border.all(color: Colors.grey.shade300),
                          ),
                          child:
                          item.MINA_D!.length >= 30 ?
                          Expanded(child: AnimatedTextWidget(text:"${item.MINA_D.toString()} (${controller.formatter.format(item.MFNOF)})")):
                          Text(
                            "${item.MINA_D} (${controller.formatter.format(item.MFNOF)})",
                            style: ThemeHelper().buildTextStyle(
                              context, Colors.black, 'M',
                            ),
                            //overflow: TextOverflow.ellipsis,
                           // maxLines: 1,
                          ),
                        ).fadeAnimation(index * 0.6),
                      );
                    },
                  ),
                );
              },
            )
        ));
  }

  GetBuilder<Sale_Invoices_Controller> MAT_FOL_BULDER(double height,MGNO,MINO, String BMMID, String BMDID) {
    return GetBuilder<Sale_Invoices_Controller>(
        init: Sale_Invoices_Controller(),
        builder: ((controller) => FutureBuilder<List<Mat_Des_M_Local>>(
          future: GET_MAT_DES_M(MGNO, MINO),
          builder: (BuildContext context, AsyncSnapshot<List<Mat_Des_M_Local>> snapshot) {
            if (!snapshot.hasData || snapshot.data!.isEmpty) {
              return Container(); // إرجاع عنصر فارغ إذا لم توجد بيانات
            }
            // تأكد من أن القائمة موجودة
            controller.selectedDetails ??= [];

            controller.detailsMap ??= {};

            // إنشاء مفتاح فريد للحركة الحالية
            final currentKey = '$BMMID-$BMDID';

            // التأكد من وجود قائمة للتفاصيل المختارة للحركة الحالية
            controller.detailsMap[currentKey] ??= [];

            return  SizedBox(
              height: 30,
              child: ListView.builder(
                physics: const BouncingScrollPhysics(),
                scrollDirection: Axis.horizontal,
                itemCount: snapshot.data!.length,
                itemBuilder: (BuildContext context, int index) {
                  final item = snapshot.data![index];
                  final isSelected = controller.detailsMap[currentKey]!.contains(item.MDMID.toString());
                  return Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 3),
                    child: GestureDetector(
                      onTap: () async {
                        try {
                          if (isSelected) {
                            // إزالة العنصر من القائمة إذا كان محددًا
                            controller.detailsMap[currentKey]!.remove(item.MDMID.toString());
                          } else {
                            // إضافة العنصر إلى القائمة إذا لم يكن محددًا
                            controller.detailsMap[currentKey]!.add(item.MDMID.toString());
                          }

                          // إنشاء نص التفاصيل مع التنسيق المطلوب
                          final details = controller.detailsMap[currentKey]!.map((detailId) {
                            // البحث عن العنصر باستخدام firstWhere مع معامل orElse لإرجاع كائن افتراضي بدلاً من null
                            final element = controller.MAT_DES_M.firstWhere(
                                  (element) => element.MDMID.toString() == detailId,
                              orElse: () => Mat_Des_M_Local(MDMID: 0, MDMNA_D: ''),
                            );
                            return element.MDMNA_D.toString();
                          }).map((detail) => '<$detail>') // إضافة العلامة <> حول كل تفصيل
                              .join(); // دمج جميع التفاصيل بدون فاصل

                          // تحديث قاعدة البيانات بالتفاصيل
                          await UpdateBMDIN(
                            controller.BMKID == 11 || controller.BMKID == 12 ? 'BIF_MOV_D' : 'BIL_MOV_D',
                            BMMID, // رقم الحركة الرئيسي
                            BMDID, // رقم الحركة الفرعي
                            details, // التفاصيل
                          );

                          controller.update();
                        } catch (error, stackTrace) {
                          print('Error: $error');
                          print('Stack Trace: $stackTrace');
                          Get.snackbar(
                            "Error",
                            "An error occurred while updating the data.",
                            backgroundColor: Colors.red,
                            colorText: Colors.white,
                          );
                        }

                      },
                      child: AnimatedContainer(
                        duration: const Duration(milliseconds: 200),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(8),
                          border: Border.all(
                            color: isSelected ? Colors.red : Colors.grey.shade300,
                          ),
                        ),
                        alignment: Alignment.center,
                        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                        child: Text(
                          item.MDMNA_D.toString(),
                          style: ThemeHelper().buildTextStyle(
                            context,
                            isSelected ? Colors.red : Colors.black,
                            'M',
                          ),
                        ),
                      ).fadeAnimation(index * 0.1),
                    ),
                  );
                },
              ),
            );
          },
        )
        ));
  }

}