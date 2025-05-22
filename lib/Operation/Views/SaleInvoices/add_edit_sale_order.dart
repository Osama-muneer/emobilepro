import 'dart:async';
import 'dart:io';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import '../../../Operation/Views/SaleInvoices/order_view.dart';
import '../../../Operation/models/bil_mov_d.dart';
import '../../../Widgets/AnimatedTextWidget.dart';
import '../../../Widgets/app_extension.dart';
import '../../../Operation/Controllers/sale_invoices_controller.dart';
import '../../../Setting/controllers/login_controller.dart';
import '../../../Widgets/colors.dart';
import '../../../Widgets/config.dart';
import '../../../Widgets/counter_button.dart';
import '../../../Widgets/theme_helper.dart';
import '../../../database/invoices_db.dart';
import 'package:flutter/material.dart';
import 'package:flutter_search_bar/flutter_search_bar.dart' as search;
import 'package:get/get.dart';
import 'datagrid_sale_invoice.dart';

class Add_Edit_Sale_order extends StatefulWidget {
  const Add_Edit_Sale_order({Key? key}) : super(key: key);
  @override
  State<Add_Edit_Sale_order> createState() => _Add_Edit_Sale_InvoiceState();
}

class _Add_Edit_Sale_InvoiceState extends State<Add_Edit_Sale_order> {
  final Sale_Invoices_Controller controller = Get.find();
  late search.SearchBar searchBar;
  String query = '';
  final txtController = TextEditingController();
  void onSubmitted(String value) {
    //ScaffoldMessenger.of(context).showSnackBar(snackBar);
    setState(() => ScaffoldMessenger.of(context)
        .showSnackBar(SnackBar(content: Text('You wrote $value!'))));
  }

  void searchRequestData(String query) {
    final listDatacustmoerRequest = controller.MAT_INF_DATE.where((list) {
      final titleLower = list.MINA_D.toString().toLowerCase();
      final authorLower = list.MPS1.toString().toLowerCase();
      final searchLower = query.toLowerCase();
      return titleLower.contains(searchLower) ||
          authorLower.contains(searchLower);
    }).toList();
    setState(() {
      this.query = query;
      controller.MAT_INF_DATE = listDatacustmoerRequest;
      if (query == '') {
        controller.GET_MAT_INF_DATE(controller.SelectDataMGNO.toString(),
            controller.SelectDataSCID.toString(), controller.SelectDataBIID.toString(),controller.BCPR!);
      }
    });
  }

  SearchBarDemoHomeState() {
    searchBar = search.SearchBar(
        hintText: 'StringSearchBarOrd'.tr,
        onChanged: searchRequestData,
        controller: txtController,
        inBar: false,
        buildDefaultAppBar: buildAppBar,
        setState: setState,
        onSubmitted: onSubmitted,
        onCleared: () {
          setState(() {
            controller.GET_MAT_INF_DATE(controller.SelectDataMGNO.toString(),
                controller.SelectDataSCID.toString(), controller.SelectDataBIID.toString(),controller.BCPR!);
            controller.update();
          });
          print("cleared");
        },
        onClosed: () {
          setState(() {
            controller.GET_MAT_INF_DATE(controller.SelectDataMGNO.toString(),
                controller.SelectDataSCID.toString(), controller.SelectDataBIID.toString(),controller.BCPR!);
            controller.update();
          });
          controller.CheckSearech = 1;
          controller.update();
          print("closed");
        });
  }

  @override
  void initState() {
    // TODO: implement initState
    if(controller.isTablet){
      SystemChrome.setPreferredOrientations([
        DeviceOrientation.landscapeLeft,
        DeviceOrientation.landscapeRight,
      ]);
    }
    SearchBarDemoHomeState();
    super.initState();
  }

  // @override
  // void dispose() {
  //   SystemChrome.setPreferredOrientations([
  //     DeviceOrientation.portraitUp,
  //     DeviceOrientation.portraitDown,
  //   ]);
  //   super.dispose();
  // }

  AppBar buildAppBar(BuildContext context) {
    return AppBar(
      backgroundColor: AppColors.MainColor,
      iconTheme: IconThemeData(color: Colors.white),
      centerTitle: true,
      actions: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            children: [
              searchBar.getSearchAction(context),
              InkWell(
                onTap: () {
                  //  if(int.parse(controller.CountRecodeController.text.isEmpty ? '0' : controller.CountRecodeController.text) > 0){
                  controller.GET_BMDID_COUNT_P();
                  controller.GET_BIF_MOV_D_P(controller.BMMID.toString(),'2');
                  controller.BMATY_SHOW(false);
                  controller.RSID_SHOW(false);
                  controller.RTID_SHOW(false);
                  controller.REID_SHOW(false);
                  controller.TYPE_ORDER=1;
                  controller.CheckOutTemplate=1;
                  Get.dialog(
                    CheckOut(Show:true),
                  );
                  // }
                  //   Navigator.push(context, MaterialPageRoute(builder: (context)=>CheckOut()));
                },
                child: Container(
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadiusDirectional.circular(10),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.shopping_cart,color: Colors.white
                        //  color: colorSiji,
                      ),
                      SizedBox(width: 2),
                      Text(controller.COUNTRecode_ORD.toString(), style:TextStyle(fontSize: 18,color: Colors.white),
                      )
                    ],
                  ),
                ),
              ),
            ],
          ),
        )
      ],
      title: Text(controller.SelectDataGETTYPE=='1' && (controller.SelectDataRTID.toString()!='null')?
          '(${controller.RSNA_TitleScreen} / ${controller.SelectDataRTNA})' :'(${controller.RSNA_TitleScreen})',
          style: ThemeHelper().buildTextStyle(context,AppColors.textColor,'L')),
    );
  }

  Future<bool> onWillPop() async {
    final shouldPop;
    if ((controller.edit == true || controller.CheckBack == 0)) {
      if(controller.edit == true){
        UpdateBIL_MOV_M_SUM(
            controller.BMKID==11 || controller.BMKID==12?'BIF_MOV_M':'BIL_MOV_M',
            controller.BMKID!,
            controller.BMMID!,
            controller.roundDouble(double.parse(controller.BMMAMController.text)+double.parse(controller.SUMBMDTXTController.text),controller.SCSFL),
            controller.SUMBMDTXT!,
            int.parse(controller.CountRecodeController.text),
            controller.roundDouble((double.parse(controller.BMMAMController.text)+double.parse(controller.SUMBMDTXTController.text)) * double.parse(controller.SCEXController.text), 2).toString(),
            controller.SUMBMMDIF!,
            controller.SelectDataBMMDN=='1'? controller.SUMBMMDI!: controller.BMMDIController.text.isNotEmpty ? double.parse(controller.BMMDIController.text) : 0,
            controller.BMMDIRController.text.isNotEmpty ? double.parse(controller.BMMDIRController.text) : 0,
            double.parse(controller.BMMAMTOTController.text),
            controller.SUMBMDTXT1!,
            controller.SUMBMDTXT2!,
            controller.SUMBMDTXT3!,
            controller.BMMAM_TX,
            controller.BMMDI_TX,
            controller.TCAM);
      }
      if (controller.CheckSearech == 1) {
        controller.CheckSearech = 0;
        controller.SER_MINA = '';
        controller.update();
        return true;
      } else {
        Navigator.of(context).pop(false);
        controller.GET_BIL_MOV_M_P('DateNow');
        LoginController().SET_N_P('TIMER_POST',0);
        LoginController().SET_P('Return_Type','1');
        shouldPop = await Get.offNamed('/Home',arguments:1);
      }
    } else {
      if (controller.CheckSearech == 1) {
        controller.CheckSearech = 0;
        controller.SER_MINA = '';
        DataGridPageInvoice();
        controller.update();
        return true;
      } else {
        shouldPop = await Get.defaultDialog(
          title: 'StringChiksave2'.tr,
          middleText: 'StringChiksave'.tr,
          backgroundColor: Colors.white,
          radius: 40,
          textCancel: 'StringNo'.tr,
          cancelTextColor: Colors.red,
          textConfirm: 'StringYes'.tr,
          confirmTextColor: Colors.white,
          onConfirm: () {
            Navigator.of(context).pop(false);
            bool isValid = controller.delete_BIL_MOV(null, 1);
            if (isValid) {
              LoginController().SET_P('Return_Type','1');
              Get.offNamed('/Home',arguments:1);
              controller.loading(false);
              LoginController().SET_N_P('TIMER_POST',0);
              controller.update();
            }
          },
        );
      }
    }

    return shouldPop ?? false;
  }

  @override
  Widget build(BuildContext context) {


    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return GetBuilder<Sale_Invoices_Controller>(
        init: Sale_Invoices_Controller(),
        builder: ((value) => WillPopScope(
            onWillPop: onWillPop,
            child: Scaffold(
              appBar: searchBar.build(context),
              body: Row(
                children: [
                  Expanded(
                      flex: 3,
                      child: Padding(
                        padding:  EdgeInsets.all(0.01 * width),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            if(controller.SelectDataGETTYPE=='1')
                            if(controller.RES_TAB.length>0 && controller.edit==false)
                              SizedBox(
                              height: height / 23,
                              child:  ListView.builder(
                                physics: BouncingScrollPhysics(),
                                scrollDirection: Axis.horizontal,
                                itemCount: controller.RES_TAB.length,
                                itemBuilder: (BuildContext context, int index) {
                                  return Padding(
                                    padding: EdgeInsets.only(left: 0.01 * width, right: 0.01 * width),
                                    child: TextButton(
                                      onPressed: () {
                                        setState(() {
                                          if(controller.RES_TAB[index].RTID==controller.SelectDataRTID){
                                            controller.SelectDataRTID=null;
                                          }else{
                                            controller.SelectDataRTID=controller.RES_TAB[index].RTID.toString();
                                            controller.SelectDataRTNA=controller.RES_TAB[index].RTNA_D.toString();
                                          }
                                          controller.update();
                                        });
                                      },
                                      style:
                                      TextButton.styleFrom(
                                        side:  BorderSide(color:controller.RES_TAB[index].RTID.toString()==controller.SelectDataRTID?
                                        Colors.red:Colors.black45),
                                        shape:RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular( 0.01 * height), // <-- Radius
                                        ),
                                      ),
                                      child:
                                      Text(
                                          "${controller.RES_TAB[index].RTID.toString()}-${controller.RES_TAB[index].RTNA_D.toString()}",
                                          style: ThemeHelper().buildTextStyle(context, controller.RES_TAB[index].RTID.toString()==controller.SelectDataRTID?
                                          Colors.red:Colors.black,'M')
                                      ),
                                    ).fadeAnimation(index * 0.6),
                                  );
                                },
                              ),),
                            SizedBox(height: 0.01 * height),
                            SizedBox(
                              height: controller.MAT_GRO.length<5?height / 12.5:
                              height / 8.0,
                              child:GridView.builder(
                                shrinkWrap: true,
                                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: controller.MAT_GRO.length<5? 1: 2,
                                  crossAxisSpacing: 5.0,
                                  mainAxisSpacing: 5.0,
                                  mainAxisExtent: 190,
                                ),
                                // shrinkWrap: true,
                                scrollDirection: Axis.horizontal,
                                itemCount: controller.MAT_GRO.length,
                                itemBuilder: (BuildContext context, int index) {
                                  return Padding(
                                    padding: EdgeInsets.only(left: 0.01 * width, right: 0.01 * width),
                                    child: TextButton(
                                      onPressed: () async {
                                        controller.SelectDataMGNO=controller.MAT_GRO[index].MGNO.toString();
                                        controller.MGNOController.text=controller.MAT_GRO[index].MGNO.toString();
                                        controller.GET_MAT_INF_DATE(controller.MAT_GRO[index].MGNO.toString(),
                                            controller.SelectDataSCID.toString(),controller.SelectDataBIID.toString(),controller.BCPR!);
                                        controller.update();

                                      },
                                      style:  controller.MAT_GRO[index].MGNO.toString()==controller.SelectDataMGNO?
                                      TextButton.styleFrom(
                                        side: const BorderSide(color: Colors.red),
                                        //foregroundColor: Colors.black,
                                        // backgroundColor: Colors.grey[400],
                                        shape:RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular( 0.02 * height), // <-- Radius
                                        ),
                                      ):
                                      TextButton.styleFrom(
                                        side: const BorderSide(color: Colors.black45),
                                        // foregroundColor: Colors.black,
                                        shape:RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular( 0.02 * height), // <-- Radius
                                        ),
                                      ),
                                      child: Text(
                                          controller.MAT_GRO[index].MGNA_D.toString(),
                                          style: ThemeHelper().buildTextStyle(context, controller.MAT_GRO[index].MGNO.toString()==controller.SelectDataMGNO?
                                          Colors.red:Colors.black,'M')
                                      ),
                                    ).fadeAnimation(index * 0.1),
                                  );
                                },
                              ),
                            ),
                            SizedBox(height: 0.01 * height),
                            Expanded(child: GridView.builder(
                              physics: const BouncingScrollPhysics(),
                              // physics: NeverScrollableScrollPhysics(),
                              shrinkWrap: true,
                              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 2,
                                crossAxisSpacing: 12.0,
                                mainAxisSpacing: 15.0,
                                mainAxisExtent: 200,
                              ),
                              itemCount: controller.MAT_INF_DATE.length,
                              itemBuilder: (context, index) {
                                return Stack(
                                children: [

                                  Container(
                                    decoration: BoxDecoration(
                                      border: Border.all(color: Colors.red, width: 0.5),
                                      borderRadius: BorderRadius.circular(8),
                                    ),
                                    child: GestureDetector(
                                      onTap: () async {
                                        controller.SelectDataMINO = controller.MAT_INF_DATE[index].MINO.toString();
                                        print('STP-1');
                                        controller.MGNOController.text = controller.MAT_INF_DATE[index].MGNO.toString();
                                        controller.SelectDataMUID = controller.MAT_INF_DATE[index].MUID.toString();
                                        controller.MGKI = controller.MAT_INF_DATE[index].MGKI;
                                        controller.update();
                                        await controller.GET_COUNT_MINO_P();
                                        await controller.GET_COUNT_NO_P(
                                            controller.MAT_INF_DATE[index].MGNO.toString(),
                                            controller.MAT_INF_DATE[index].MINO.toString(),
                                            controller.MAT_INF_DATE[index].MUID!);
                                        await controller.GET_BROCODE_P( controller.MGNOController.text,controller.SelectDataMINO.toString(),controller.SelectDataMUID.toString());
                                        controller.MINAController.text = controller.MAT_INF_DATE[index].MINA_D.toString();
                                        controller.MIED = controller.MAT_INF_DATE[index].MIED;
                                        controller.BMDNOController.text = '1';
                                        controller.BMDNO_V = 1;
                                        controller.BMDAMController.text = controller.BCPR==2?
                                        controller.MAT_INF_DATE[index].MPS2.toString(): controller.BCPR==3?
                                        controller.MAT_INF_DATE[index].MPS3.toString() :controller.BCPR==4?
                                        controller.MAT_INF_DATE[index].MPS4.toString():
                                        controller.MAT_INF_DATE[index].MPS1.toString();
                                        controller.BMDNFController.text = '0';
                                        controller.SUMBMDAMController.text = '0';
                                        controller.BMDDIRController.text = '0';
                                        controller.BMDDIController.text = '0';
                                        controller.MPS1 = double.parse(controller.BMDAMController.text);
                                        print(controller.MPS1 );
                                        print(controller.BMDAMController.text);
                                        print('controller.BMDAMController.text');
                                        if(controller.TTID1!=null){
                                          await controller.GET_TAX_LIN_P('MAT',controller.MAT_INF_DATE[index].MGNO.toString(),
                                              controller.MAT_INF_DATE[index].MINO.toString());
                                        }
                                        // Timer(const Duration(milliseconds: 200), () async {
                                          print('STP-2');
                                          if(controller.COUNT_NO<=0){
                                            print(controller.BMDAMController.text);
                                            print('controller.BMDAMController.text');
                                            await  controller.Calculate_BMD_NO_AM();
                                            print(controller.BMDAMController.text);
                                            print('controller.BMDAMController.text');
                                           print('STP-3');
                                            bool isValid =await controller.Save_BIL_MOV_D_ORD_P();
                                            if (isValid) {
                                              // controller.ClearBil_Mov_D_Data();
                                              await controller.ADD_MAT_FOL_TO_MOV_D(controller.SelectDataBIID.toString(),
                                                  controller.MAT_INF_DATE[index].MGNO.toString(),
                                                  controller.MAT_INF_DATE[index].MINO.toString(),
                                                  controller.BMDID!
                                              );
                                            }
                                          }
                                        // });


                                        controller.update();
                                      },
                                      child:  Container(
                                        decoration: BoxDecoration(
                                          color:  Colors.white,
                                          borderRadius: const BorderRadius.all(Radius.circular(20)),
                                        ),
                                        child: Column(
                                          crossAxisAlignment: CrossAxisAlignment.center, // المحاذاة في المنتصف أفقياً
                                          mainAxisAlignment: MainAxisAlignment.center, // المحاذاة في المنتصف رأسياً
                                          children: [
                                            ClipOval(
                                                child: Image.file(File("${SignPicture_MAT}${controller.MAT_INF_DATE[index].MGNO}-${controller.MAT_INF_DATE[index].MINO}.png"),
                                                  errorBuilder: (BuildContext context, Object exception, StackTrace? stackTrace) {
                                                    return Image.asset(ImageEORDPOS, fit:BoxFit.fill,height: 0.1 *height);
                                                  },
                                                  fit: BoxFit.fitWidth,height: 0.1 *height,)
                                            ),
                                            // Image(image:AssetImage(ImagePath + "sushi5.png"),fit:BoxFit.fill,height: 70),
                                            Text("${ controller.formatter.format(controller.BCPR==2? controller.MAT_INF_DATE[index].MPS2:controller.BCPR==3?
                                            controller.MAT_INF_DATE[index].MPS3:controller.BCPR==4? controller.MAT_INF_DATE[index].MPS4:controller.MAT_INF_DATE[index].MPS1).toString()} ${controller.SCSY} ",
                                                style: ThemeHelper().buildTextStyle(context, Colors.red,'M')),
                                            controller.MAT_INF_DATE[index].MUCNA_D.toString().length >= 30 ?
                                            AnimatedTextWidget(text: controller.MAT_INF_DATE[index].MUCNA_D.toString(),):
                                            Text(controller.DisplayItemsOnScreen=='3' ? controller.MAT_INF_DATE[index].MUCNA_D.toString():
                                              '${controller.MAT_INF_DATE[index].MUCNA_D.toString()} - ${controller.MAT_INF_DATE[index].MUNA_D.toString()}',
                                              style: ThemeHelper().buildTextStyle(context, Colors.black, 'M'),
                                            ),
                                            if(controller.isTablet==false)
                                            FutureBuilder<List<Bil_Mov_D_Local>>(
                                                future: GET_BIL_MOV_D_ORD(controller.BMKID == 11 || controller.BMKID == 12 ? 'BIF_MOV_D' : 'BIL_MOV_D'
                                                    ,controller.BMMID.toString()
                                                    ,controller.MAT_INF_DATE[index].MGNO.toString(),
                                                    controller.MAT_INF_DATE[index].MINO.toString(),
                                                    controller.MAT_INF_DATE[index].MUID!),

                                                builder: (BuildContext context, AsyncSnapshot<List<Bil_Mov_D_Local>> snapshot) {
                                                  if (!snapshot.hasData || snapshot.data!.length==0 ) {
                                                    return Container();
                                                  }
                                                  return CounterButton(
                                                    onIncrementSelected: () => controller.enqueueUpdate(snapshot.data!.elementAt(0), 1),
                                                    onDecrementSelected: () => controller.enqueueUpdate(snapshot.data!.elementAt(0), 2),
                                                    // onIncrementSelected: () => controller.UPDATE_BIF_MOV_D_ORD(snapshot.data!.elementAt(0),1),
                                                    // onDecrementSelected: () => controller.UPDATE_BIF_MOV_D_ORD(snapshot.data!.elementAt(0),2),
                                                    size:  Size(0.03* height, 0.03* height),
                                                    padding: 0,
                                                    label: Text(controller.formatter.format(snapshot.data!.elementAt(0).BMDNO).toString(),
                                                        style: ThemeHelper().buildTextStyle(context, Colors.black,'M')
                                                    ),
                                                  );
                                                }),
                                            // SizedBox(height: 5,)
                                          ],
                                        ).fadeAnimation(0.7),
                                      ),
                                    ),
                                  ),
                                  // // ✅ أيقونة  في الأعلى يسار العنصر
                                  // controller.COUNT_NO>0?
                                  // Positioned(
                                  //   top: MediaQuery.of(context).size.height * 0.01,
                                  //   left: MediaQuery.of(context).size.height * 0.01,
                                  //   child: GestureDetector(
                                  //     onTap: () {
                                  //       //
                                  //     },
                                  //     child: InkWell(
                                  //       onTap: () {
                                  //         //  if(int.parse(controller.CountRecodeController.text.isEmpty ? '0' : controller.CountRecodeController.text) > 0){
                                  //         controller.GET_BMDID_COUNT_P();
                                  //         controller.GET_BIF_MOV_D_P(controller.BMMID.toString(),'2');
                                  //         controller.BMATY_SHOW(false);
                                  //         controller.RSID_SHOW(false);
                                  //         controller.RTID_SHOW(false);
                                  //         controller.REID_SHOW(false);
                                  //         controller.TYPE_ORDER=1;
                                  //         controller.CheckOutTemplate=1;
                                  //         Get.dialog(
                                  //           CheckOut(Show:true),
                                  //         );
                                  //         // }
                                  //         //   Navigator.push(context, MaterialPageRoute(builder: (context)=>CheckOut()));
                                  //       },
                                  //       child: Icon(Icons.add_card_rounded,color: Colors.grey,
                                  //         size: MediaQuery.of(context).size.height * 0.026,
                                  //       ),
                                  //     ),
                                  //   ),
                                  // ):Container(),
                                ],
                                );
                              },
                            ),)
                          ],
                        ),
                      ),
                    ),
                  if(controller.isTablet)
                  Container(
                    width:  320,
                    color: Colors.grey[100],
                    child: Padding(
                      padding: const EdgeInsets.all(3),
                      child: CheckOut(Show:false),
                    ),
                  ),
                ],
              ),
              bottomNavigationBar: controller.isTablet==false
                  ? GetBuilder<Sale_Invoices_Controller>(
                init: Sale_Invoices_Controller(),
                builder: ((value) => Container(
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.black),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Text(
                        "${'StrinCount_SMDFN'.tr}  ${controller.BMMAMController.text.isEmpty ? controller.BMMAMController.text = '0' : controller.formatter.format(double.parse(controller.BMMAMController.text))}",
                        style: ThemeHelper().buildTextStyle(context, Colors.red, 'M'),
                      ),
                      Text(
                        "${'StringNet_Amount'.tr}  ${controller.BMMAMTOTController.text.isEmpty ? controller.BMMAMTOTController.text = '0' : controller.formatter.format(double.parse(controller.BMMAMTOTController.text))}",
                        style: ThemeHelper().buildTextStyle(context, Colors.red, 'M'),
                      ),
                    ],
                  ),
                )),
              )
                  : null,

            )
        )));
  }

}
