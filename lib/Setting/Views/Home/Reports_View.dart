import 'package:dropdown_button2/dropdown_button2.dart';
import '../../../Widgets/app_extension.dart';
import '../../../Setting/models/acc_acc.dart';
import '../../../Setting/models/acc_cos.dart';
import '../../../Setting/models/bra_inf.dart';
import '../../../Setting/models/sys_cur.dart';
import '../../../Widgets/colors.dart';
import '../../../Widgets/config.dart';
import '../../../Widgets/dimensions.dart';
import '../../../Widgets/dropdown.dart';
import '../../../Widgets/theme_helper.dart';
import '../../../database/invoices_db.dart';
import '../../../database/setting_db.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../controllers/Reports_Controller.dart';
import '../../models/acc_gro.dart';
import '../../models/bil_are.dart';
import '../../models/bil_cus.dart';
import '../../models/bil_cus_t.dart';
import '../../models/bil_dis.dart';
import '../../models/bil_imp.dart';
import '../../models/bil_imp_t.dart';
import '../../models/cou_tow.dart';
import '../../models/cou_wrd.dart';
import '../../models/sys_lan.dart';

class Reports_View extends StatefulWidget {
  const Reports_View({super.key});

  @override
  State<Reports_View> createState() => _Report_ViewState();
}

class _Report_ViewState extends State<Reports_View> {
  final Reports_Controller controller = Get.find();

  @override
  Widget build(BuildContext context) {
    return GetBuilder<Reports_Controller>(
        init: Reports_Controller(),
        builder: ((controller) {
          return DefaultTabController(
            length: 3,
            child: Scaffold(
              appBar: AppBar(
                backgroundColor: AppColors.MainColor,
                iconTheme: IconThemeData(color: Colors.white),
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
                title: Text(controller.SRID==1003?'StringCus_Bal_Rep'.tr:controller.SRID==1004?'StringSuppliers_Balances_Report'.tr:
                controller.SRID==1010?'StringAccounts_Balances_Report'.tr:controller.SRID==1008?'String1008'.tr:
                controller.SRID==1016?'String1016'.tr:controller.SRID==1018?'String1018'.tr:controller.SRID==1023?'String1023'.tr:
                    'String1025'.tr,
                    style: TextStyle(
                        fontSize: Dimensions.fonAppBar,
                        color: AppColors.textColor,
                        fontWeight: FontWeight.bold)),
                centerTitle: true,
                bottom: TabBar(indicatorColor: Colors.white, tabs: [
                  Tab(
                      child: Text('----1----',
                        style: TextStyle(
                            fontSize: Dimensions.fonText, color: Colors.white),
                      )),
                  Tab(
                      child: Text('----2----',
                        style: TextStyle(
                            fontSize: Dimensions.fonText, color: Colors.white),
                      )),
                  Tab(
                      child: Text('----3----',
                        style: TextStyle(
                            fontSize: Dimensions.fonText, color: Colors.white),
                      )),
                ]),
              ),
              body: Padding(
                padding: EdgeInsets.only(left: Dimensions.width10, right: Dimensions.width10),
                child: TabBarView(
                    children: [
                      SingleChildScrollView(
                        child: Column(
                          children: [
                            SizedBox(height: Dimensions.height15),
                            //من الفرع الي الفرع
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Expanded(
                                  child: DropdownBra_InfBuilder(),
                                ),
                                Expanded(
                                  child: DropdownBra_Inf_ToBuilder(),
                                ),
                              ],
                            ),
                            SizedBox(height: Dimensions.height15),
                            //من المركز الى المركز
                            Row(
                              children: [
                                Expanded(
                                  child: DropdownFrom_ACC_COSBuilder(),
                                ),
                                Expanded(
                                  child: DropdownTo_ACC_COSBuilder(),
                                ),
                              ],
                            ),
                            SizedBox(height: Dimensions.height15),
                            //من تاريخ الى تاريخ
                           controller.SRID==1016?
                               Row(children: [

                               ],)
                               : Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  children: [
                                    controller.SRID==1018?Container():Expanded(
                                      child: Container(
                                          margin: EdgeInsets.only(left: Dimensions.height5),
                                          decoration: BoxDecoration(
                                              color: Colors.white,
                                              borderRadius: BorderRadius.circular(
                                                  Dimensions.width10)),
                                          child: Column(
                                            children: [
                                              Text((controller.SelectFromDays == null ? controller.SelectFromDays =
                                              controller.dateFromDays.toString().split(" ")[0] :
                                              controller.SelectFromDays.toString()).split(" ")[0],
                                                style: TextStyle(fontSize: Dimensions.fonText),),
                                              SizedBox(
                                                width: Dimensions.width100,
                                                child: MaterialButton(
                                                  onPressed: () {
                                                    controller.selectDateFromDays(context);
                                                  },
                                                  color: AppColors.MainColor,
                                                  child: Text(
                                                    'StringFromDate'.tr,
                                                    style: TextStyle(
                                                      color: Colors.white,
                                                      fontSize:Dimensions.fonText,
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ],
                                          )),
                                    ),
                                    Expanded(
                                      child: Container(
                                          margin: EdgeInsets.only(right: Dimensions.height5),
                                          decoration: BoxDecoration(color: Colors.white,
                                              borderRadius: BorderRadius.circular(Dimensions.width10)),
                                          child: Column(
                                            children: [
                                              Text(controller.SelectToDays == null
                                                  ? controller.SelectToDays = controller.dateTimeToDays.toString().split(" ")[0]
                                                  : controller.SelectToDays.toString().split(" ")[0],
                                                style: TextStyle(fontSize: Dimensions.fonText),),
                                              SizedBox(
                                                width: Dimensions.width100,
                                                child: MaterialButton(
                                                  onPressed: () {
                                                    controller.selectDateToDays(context);
                                                  },
                                                  color: AppColors.MainColor,
                                                  child: Text('StringToDate'.tr,
                                                    style: TextStyle(
                                                        color: Colors.white,
                                                        fontSize: Dimensions.fonText),
                                                  ),
                                                ),
                                              ),
                                            ],
                                          )),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                            SizedBox(height: Dimensions.height15),
                            //من تاريخ الاضافة الى تاريخ
                            Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  children: [
                                    Expanded(
                                      child: Container(
                                          margin: EdgeInsets.only(left: Dimensions.height5),
                                          decoration: BoxDecoration(color: Colors.white,
                                              borderRadius: BorderRadius.circular(Dimensions.width10)),
                                          child: Column(
                                            children: [
                                              Text((controller.SelectFromInsertDate == null ? controller.SelectFromInsertDate =
                                              '' : controller.SelectFromInsertDate.toString()).split(" ")[0],
                                                style: TextStyle(fontSize: Dimensions.fonText),),
                                              SizedBox(
                                                width: Dimensions.width100,
                                                child: MaterialButton(
                                                  onPressed: () {
                                                    controller.Get_FromInsertDate(context);
                                                  },
                                                  color: AppColors.MainColor,
                                                  child: Text(
                                                    'StringFrom_Insert_Date'.tr,
                                                    style: TextStyle(
                                                      color: Colors.white,
                                                      fontSize:Dimensions.fonText,
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ],
                                          )),
                                    ),
                                    Expanded(
                                      child: Container(
                                          margin: EdgeInsets.only(right: Dimensions.height5),
                                          decoration: BoxDecoration(color: Colors.white,
                                              borderRadius: BorderRadius.circular(Dimensions.width10)),
                                          child: Column(
                                            children: [
                                              Text(controller.SelectToInsertDate == null
                                                  ? '' : controller.SelectToInsertDate.toString().split(" ")[0],
                                                style: TextStyle(fontSize: Dimensions.fonText),),
                                              SizedBox(
                                                width: Dimensions.width100,
                                                child: MaterialButton(
                                                  onPressed: () {
                                                    controller.Get_ToInsertDate(context);
                                                  },
                                                  color: AppColors.MainColor,
                                                  child: Text('StringToDate'.tr,
                                                    style: TextStyle(
                                                        color: Colors.white,
                                                        fontSize: Dimensions.fonText),
                                                  ),
                                                ),
                                              ),
                                            ],
                                          )),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                            SizedBox(height: Dimensions.height15),
                            controller.SRID==1018?
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Expanded(
                                  child: DropdownGET_AC_TBuilder(),
                                ),
                                Expanded(
                                  child: DropdownGET_AATYBuilder(),
                                ),
                              ],
                            )   :
                            //اظهار حسب
                            DropdownGET_BRA_TBuilder(),
                            SizedBox(height: Dimensions.height15),
                            //من الحساب
                            controller.SRID==1003?DropdownFromBIL_CUSBuilder():controller.SRID==1004?DropdownFromBIL_IMPBuilder():
                            DropdownFromACC_ACCBuilder(),
                            SizedBox(height: Dimensions.height15),
                            //الى الحساب
                            controller.SRID==1003?DropdownTO_BIL_CUSBuilder():controller.SRID==1004?DropdownTO_BIL_IMPBuilder():
                            DropdownToACC_ACCBuilder(),
                            SizedBox(height: Dimensions.height15),
                            //الى النوع-من النوع
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Expanded(
                                  child: controller.SRID==1003?DropdownFromBIL_CUS_TBuilder():controller.SRID==1004?
                                  DropdownFrom_BIL_IMP_TBuilder():DropdownSYS_CUR_FBuilder(),
                                ),
                                Expanded(
                                  child: controller.SRID==1003?DropdownToBIL_CUS_TBuilder():controller.SRID==1004?
                                  DropdownTO_BIL_IMP_TBuilder():DropdownSYS_CUR_TBuilder(),
                                ),
                              ],
                            ),
                            SizedBox(height: Dimensions.height70),
                          ],
                        ),
                      ),
                      SingleChildScrollView(
                        child: Column(
                          children: [
                            SizedBox(height: Dimensions.height15),
                            //الى العملة-من لعملة
                            controller.SRID==1003 || controller.SRID==1004?Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Expanded(
                                  child: DropdownSYS_CUR_FBuilder(),
                                ),
                                Expanded(
                                  child: DropdownSYS_CUR_TBuilder(),
                                ),
                              ],
                            ):Container(),
                            controller.SRID==1003 || controller.SRID==1004?SizedBox(height: Dimensions.height15):
                            Container(),
                            //الى المجموعه-من المجموعه
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Expanded(
                                  child: DropdownAcc_Gro_FBuilder(),
                                ),
                                Expanded(
                                  child: DropdownAcc_Gro_TBuilder(),
                                ),
                              ],
                            ),
                            SizedBox(height: Dimensions.height15),
                            //الى الحالة-من الحاله
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Expanded(
                                  child: DropdownGET_ST_FBuilder(),
                                ),
                                Expanded(
                                  child: DropdownGET_ST_TBuilder(),
                                ),
                              ],
                            ),
                            SizedBox(height: Dimensions.height15),
                            //الحاله
                            DropdownGET_AMMSTBuilder(),
                            SizedBox(height: Dimensions.height15),
                           controller.SRID==1018?DropdownGET_AC_BAL2Builder():DropdownGET_AC_V_BBuilder(),
                            SizedBox(height: Dimensions.height15),
                            //الدولة
                            DropdownCou_WrdBuilder(),
                            SizedBox(height: Dimensions.height15),
                            //المدينه
                            DropdownCOU_TOWBuilder(),
                            SizedBox(height: Dimensions.height15),
                            //الى المنطقه-من المنطفه
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Expanded(
                                  child: DropdownBIL_ARE_FBuilder(),
                                ),
                                Expanded(
                                  child: DropdownBIL_ARE_TBuilder(),
                                ),
                              ],
                            ),
                            SizedBox(height: Dimensions.height15),
                            //من المختص-الى المختص
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Expanded(
                                  child: DropdownBIL_DIS_FBuilder(),
                                ),
                                Expanded(
                                  child: DropdownBIL_DIS_TBuilder(),
                                ),
                              ],
                            ),
                            SizedBox(height: Dimensions.height60),

                          ],
                        ),
                      ),
                      SingleChildScrollView(
                        child: Column(
                          children: [
                            SizedBox(height: Dimensions.height15),
                            //من المبلغ-الى المبلغ
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                Expanded(
                                  child: DropdownGET_CON3_FBuilder(),
                                ),
                                SizedBox(height: Dimensions.height5),
                                Expanded(
                                  child: TextFormField(
                                    style: TextStyle(fontWeight: FontWeight.bold,fontSize: Dimensions.fonText),
                                    controller: controller.AM_FController,
                                    decoration: InputDecoration(
                                        contentPadding: const EdgeInsets.symmetric(vertical: 15, horizontal: 8),
                                        labelStyle: TextStyle(color: Colors.grey),
                                        focusedBorder: OutlineInputBorder(
                                            borderRadius: BorderRadius.circular(Dimensions.width15),
                                            borderSide: BorderSide(color: Colors.grey.shade500)),
                                        border: OutlineInputBorder(
                                            borderRadius: BorderRadius.all(Radius.circular(Dimensions.height15)))),
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(height: Dimensions.height15),
                            Row(
                            //  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Expanded(
                                  child: DropdownGET_CON3_TBuilder(),
                                ),
                                Expanded(
                                  child: TextFormField(
                                    style: TextStyle(fontWeight: FontWeight.bold,fontSize: Dimensions.fonText),
                                    controller: controller.AM_FController,
                                    decoration: InputDecoration(
                                        contentPadding: const EdgeInsets.symmetric(vertical: 15, horizontal: 8),
                                        labelStyle: TextStyle(color: Colors.grey),
                                        focusedBorder: OutlineInputBorder(
                                            borderRadius: BorderRadius.circular(Dimensions.width15),
                                            borderSide: BorderSide(color: Colors.grey.shade500)),
                                        border: OutlineInputBorder(
                                            borderRadius: BorderRadius.all(Radius.circular(Dimensions.height15)))),
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(height: Dimensions.height10),
                            //تجميعي لكل الفروع
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text('StringBRA_COL'.tr, style: TextStyle(fontWeight: FontWeight.bold,
                                    fontSize: Dimensions.fonText)),
                                Checkbox(
                                  value: controller.BRA_COL,
                                  onChanged: (value) {
                                    controller.BRA_COL = value!;
                                    controller.update();
                                  },
                                  activeColor: AppColors.MainColor,
                                ),
                              ],
                            ),
                            SizedBox(height:Dimensions.height5),
                            //عدم تضمين حساب مرتبط عميل/مورد
                            controller.SRID==1003 || controller.SRID==1004?Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text('StringN_C_I'.tr, style: TextStyle(fontWeight: FontWeight.bold,
                                    fontSize: Dimensions.fonText)),
                                Checkbox(
                                  value: controller.N_C_I,
                                  onChanged: (value) {
                                    controller.N_C_I = value!;
                                    controller.update();
                                  },
                                  activeColor: AppColors.MainColor,
                                ),
                              ],
                            ):
                            Container(),
                            SizedBox(height:Dimensions.height5),
                            //تضمين الحركات الغير نهائيه
                            controller.SRID==1003 || controller.SRID==1004?Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text('StringPRI_BIL_NOT'.tr, style: TextStyle(fontWeight: FontWeight.bold,
                                    fontSize: Dimensions.fonText)),
                                Checkbox(
                                  value: controller.PRI_BIL_NOT,
                                  onChanged: (value) {
                                    controller.PRI_BIL_NOT = value!;
                                    controller.update();
                                  },
                                  activeColor: AppColors.MainColor,
                                ),
                              ],
                            ):
                            Container(),
                            SizedBox(height:Dimensions.height5),
                            //تضمين الفواتير النقديه
                            controller.SRID==1003 || controller.SRID==1004?Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text('StringVIW_BP'.tr, style: TextStyle(fontWeight: FontWeight.bold,
                                    fontSize: Dimensions.fonText)),
                                Checkbox(
                                  value: controller.VIW_BP,
                                  onChanged: (value) {
                                    controller.VIW_BP = value!;
                                    controller.update();
                                  },
                                  activeColor: AppColors.MainColor,
                                ),
                              ],
                            ):
                            Container(),
                            SizedBox(height:Dimensions.height5),
                            // اخر سداد
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text('StringVIW_L_D'.tr, style: TextStyle(fontWeight: FontWeight.bold,
                                    fontSize: Dimensions.fonText)),
                                Checkbox(
                                  value: controller.VIW_L_D,
                                  onChanged: (value) {
                                    controller.VIW_L_D = value!;
                                    controller.update();
                                  },
                                  activeColor: AppColors.MainColor,
                                ),
                              ],
                            ),
                            SizedBox(height:Dimensions.height10),
                            //اظهار بيانات الهاتف
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text('StringVIW_AD'.tr, style: TextStyle(fontWeight: FontWeight.bold,
                                    fontSize: Dimensions.fonText)),
                                Checkbox(
                                  value: controller.VIW_AD,
                                  onChanged: (value) {
                                    controller.VIW_AD = value!;
                                    controller.update();
                                  },
                                  activeColor: AppColors.MainColor,
                                ),
                              ],
                            ),
                            SizedBox(height:Dimensions.height5),
                            //اظهار تاريخ اخر حركة مدين/دائن
                            controller.SRID==1003 || controller.SRID==1004?Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text('StringVIW_L_MD'.tr, style: TextStyle(fontWeight: FontWeight.bold,
                                    fontSize: Dimensions.fonText)),
                                Checkbox(
                                  value: controller.VIW_L_MD,
                                  onChanged: (value) {
                                    controller.VIW_L_MD = value!;
                                    controller.update();
                                  },
                                  activeColor: AppColors.MainColor,
                                ),
                              ],
                            ):
                            Container(),
                            //استثناء حسابات العملاء /الموردين التي تحركت بفواتير نقديه خلال الفتره
                            controller.SRID==1008?Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text('StringHI_B'.tr, style: TextStyle(fontWeight: FontWeight.bold,
                                    fontSize: 11)),
                                Checkbox(
                                  value: controller.HI_B,
                                  onChanged: (value) {
                                    controller.HI_B = value!;
                                    controller.update();
                                  },
                                  activeColor: AppColors.MainColor,
                                ),
                              ],
                            ):
                            Container(),
                            SizedBox(height: Dimensions.height10),
                            controller.SRID==1008 || controller.SRID==1018?DropdownGET_REP_GROBuilder() :
                            DropdownGET_REP_TYPBuilder(),
                            SizedBox(height: Dimensions.height10),
                            controller.SRID==1008 || controller.SRID==1018?DropdownGET_REP_GRO2Builder():DropdownGET_REP_DIRBuilder(),
                            SizedBox(height: Dimensions.height10),
                            controller.SRID==1008 || controller.SRID==1018?Container(): DropdownGET_R_TYPBuilder(),
                            SizedBox(height: Dimensions.height60),
                          ],
                        ),
                      ),
                    ]),
              ),
              floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
              floatingActionButton: MaterialButton(
                onPressed: () async {

                  // controller.openPdfFile('EMobileProSign.png');
                  // // controller.openfile(
                  // //   'EMobileProSign.png',
                  // //     controller.SOSI.toString()
                  // // );
                  controller.TEST_API();
                },
                padding: EdgeInsets.all(16.0), // يمكنك تعيين الحشوة هنا
                shape: CircleBorder(),
                child: Container(
                  height: Dimensions.height40,
                  // width: 330.w,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(color: AppColors.MainColor,
                      borderRadius: BorderRadius.circular(15)),
                  child: Text('StringPrint'.tr, style: TextStyle(color: Colors.white, fontSize: Dimensions.fonAppBar),
                  ),
                ).fadeAnimation(0 * 0.6),
              ),
            ),
          );
        }));
  }

  final List<Map> GET_BRA_T = [
    {"id": '1', "name": 'StringBMMBR1'.tr},
    {"id": '2', "name": 'StringBMMBR2'.tr}
  ].obs;

  final List<Map> GET_ST = [
    {"id": '1', "name": 'StringActive'.tr},
    {"id": '2', "name": 'StringNoActive'.tr},
    {"id": '3', "name": 'StringST3'.tr},
    {"id": '4', "name": 'StringST4'.tr},
  ].obs;

  final List<Map> GET_AMMST = [
    {"id": '1', "name": 'StringAMMST1'.tr},
    {"id": '5', "name": 'StringAMMST5'.tr},
  ].obs;

  final List<Map> GET_AC_V_B = [
    {"id": '1', "name": 'StringAC_V_B1'.tr},
    {"id": '2', "name": 'StringAC_V_B2'.tr},
    {"id": '3', "name": 'StringAC_V_B3'.tr},
    {"id": '4', "name": 'StringAC_V_B4'.tr},
    {"id": '5', "name": 'StringAC_V_B5'.tr},
    {"id": '6', "name": 'StringAC_V_B6'.tr},
    {"id": '7', "name": 'StringAC_V_B7'.tr},
  ].obs;

  final List<Map> GET_CON_3 = [
    {"id": '>=', "name": '>='},
    {"id": '<=', "name": '<='},
    {"id": '=', "name": '='},
  ].obs;

  final List<Map> GET_CON_4 = [
    {"id": '<=', "name": '<='},
  ].obs;

  final List<Map> GET_REP_TYP = [
    {"id": '1', "name": 'StringREP_TYP1'.tr},
    {"id": '2', "name": 'StringREP_TYP2'.tr},
    {"id": '3', "name": 'StringREP_TYP3'.tr},
    {"id": '4', "name": 'StringREP_TYP4'.tr},
  ].obs;

  final List<Map> GET_REP_DIR = [
    {"id": '1', "name": 'StringREP_DIR1'.tr},
    {"id": '2', "name": 'StringREP_DIR2'.tr},
  ].obs;

  final List<Map> GET_R_TYP = [
    {"id": '1', "name": 'StringR_TYP1'.tr},
    {"id": '2', "name": 'StringR_TYP2'.tr},
    {"id": '3', "name": 'StringR_TYP3'.tr},
    {"id": '4', "name": 'StringR_TYP4'.tr},
    {"id": '5', "name": 'StringR_TYP5'.tr},
  ].obs;

  final List<Map> GET_AC_T = [
    {"id": '1', "name": 'StringSP_CU_SUP1'.tr},
    {"id": '2', "name": 'StringSP_CU_SUP2'.tr},
    {"id": '3', "name": 'StringSP_CU_SUP3'.tr},
  ].obs;

  final List<Map> GET_AATY = [
    {"id": '1', "name": 'StringAC_V_T1'.tr},
    {"id": '2', "name": 'StringAC_V_T2'.tr},
    {"id": '3', "name": 'StringAC_V_T3'.tr},
    {"id": '4', "name": 'StringAC_V_T4'.tr},
  ].obs;

  final List<Map> GET_AC_BAL2 = [
    {"id": '1', "name": 'StringALL_INF1'.tr},
    {"id": '2', "name": 'StringALL_INF2'.tr},
    {"id": '3', "name": 'StringALL_INF3'.tr},
  ].obs;

  FutureBuilder<List<Bra_Inf_Local>> DropdownBra_InfBuilder() {
    return FutureBuilder<List<Bra_Inf_Local>>(
        future:  GET_BRA(2),
        builder: (BuildContext context,
            AsyncSnapshot<List<Bra_Inf_Local>> snapshot) {
          if (!snapshot.hasData) {
            return Padding(
              padding: EdgeInsets.only(left: Dimensions.width5),
              child: Dropdown(josnStatus: josnStatus, GETSTRING: '',),
            );
          }
          return Padding(padding: EdgeInsets.only(left: Dimensions.height5),
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
          ),);
        });
  }

  FutureBuilder<List<Bra_Inf_Local>> DropdownBra_Inf_ToBuilder() {
    return FutureBuilder<List<Bra_Inf_Local>>(
        future:  GET_BRA(2),
        builder: (BuildContext context,
            AsyncSnapshot<List<Bra_Inf_Local>> snapshot) {
          if (!snapshot.hasData) {
            return Padding(
              padding: EdgeInsets.only(right: Dimensions.height5),
              child: Dropdown(josnStatus: josnStatus, GETSTRING: '',),
            );
          }
          return  Padding(padding: EdgeInsets.only(right: Dimensions.height5),
              child:DropdownButtonFormField2(
            decoration: ThemeHelper().InputDecorationDropDown(" ${'StringBIID_TlableText'.tr}"),
            isExpanded: true,
            hint:  ThemeHelper().buildText(context,'StringToBrach', Colors.grey,'S'),
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

  FutureBuilder<List<Sys_Cur_Local>> DropdownSYS_CUR_FBuilder() {
    return FutureBuilder<List<Sys_Cur_Local>>(
        future: GET_SYS_CUR(),
        builder: (BuildContext context,
            AsyncSnapshot<List<Sys_Cur_Local>> snapshot) {
          if (!snapshot.hasData) {
            return Padding(
              padding: EdgeInsets.only(left: Dimensions.width5),
              child: Dropdown(josnStatus: josnStatus, GETSTRING: 'StringSCID_F'.tr,),
            );
          }
          return Padding(
            padding: EdgeInsets.only(left: Dimensions.width5),
            child: DropdownButtonFormField2(
              decoration: ThemeHelper().InputDecorationDropDown(" ${'StringSCID_F'.tr}"),
              isExpanded: true,
              hint: ThemeHelper().buildText(context,'StringSCID_F', Colors.grey,'S'),
              value: controller.SCID_F,
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
              )).toList().obs,
              onChanged: (value) {
                controller.SCID_F = value.toString();
              },
            ),
          );
        });
  }

  FutureBuilder<List<Sys_Cur_Local>> DropdownSYS_CUR_TBuilder() {
    return FutureBuilder<List<Sys_Cur_Local>>(
        future: GET_SYS_CUR(),
        builder: (BuildContext context,
            AsyncSnapshot<List<Sys_Cur_Local>> snapshot) {
          if (!snapshot.hasData) {
            return Padding(
              padding: EdgeInsets.only(right: Dimensions.height5),
              child: Dropdown(josnStatus: josnStatus, GETSTRING: 'StringSCID_T'.tr,),
            );
          }
          return Padding(
            padding: EdgeInsets.only(right: Dimensions.height5),
            child: DropdownButtonFormField2(
              decoration: ThemeHelper().InputDecorationDropDown(" ${'StringSCID_T'.tr}"),
              isExpanded: true,
              hint: ThemeHelper().buildText(context,'StringSCID_T', Colors.grey,'S'),
              value: controller.SCID_T,
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
              )).toList().obs,
              onChanged: (value) {
                controller.SCID_T = value.toString();
              },
            ),
          );
        });
  }

  FutureBuilder<List<Acc_Cos_Local>> DropdownFrom_ACC_COSBuilder() {
    return FutureBuilder<List<Acc_Cos_Local>>(
        future: GET_ACC_COS(),
        builder: (BuildContext context,
            AsyncSnapshot<List<Acc_Cos_Local>> snapshot) {
          if (!snapshot.hasData) {
            return Padding(
              padding: EdgeInsets.only( left: Dimensions.width5),
              child: Dropdown(
                josnStatus: josnStatus,
                GETSTRING: 'StringBrach',
              ),
            );
          }
          return Padding(padding: EdgeInsets.only(left: Dimensions.height5),
              child:DropdownButtonFormField2(
            decoration: ThemeHelper().InputDecorationDropDown(" ${'StringACNO_FlableText'.tr}"),
            isExpanded: true,
            hint: ThemeHelper().buildText(context,'StringChi_ACNO', Colors.grey,'S'),
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

  FutureBuilder<List<Acc_Cos_Local>> DropdownTo_ACC_COSBuilder() {
    return FutureBuilder<List<Acc_Cos_Local>>(
        future: GET_ACC_COS(),
        builder: (BuildContext context,
            AsyncSnapshot<List<Acc_Cos_Local>> snapshot) {
          if (!snapshot.hasData) {
            return Padding(
              padding: EdgeInsets.only(right: Dimensions.height5),
              child: Dropdown(
                josnStatus: josnStatus,
                GETSTRING: 'StringBrach',
              ),
            );
          }
          return Padding(padding: EdgeInsets.only(right: Dimensions.height5),
              child:DropdownButtonFormField2(
            decoration: ThemeHelper().InputDecorationDropDown(" ${'StringACNO_TlableText'.tr}"),
            isExpanded: true,
            hint: ThemeHelper().buildText(context,'StringChi_ACNO', Colors.grey,'S'),
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

  GetBuilder<Reports_Controller> DropdownFromACC_ACCBuilder() {
    return GetBuilder<Reports_Controller>(
        init: Reports_Controller(),
        builder: ((controller) => FutureBuilder<List<Acc_Acc_Local>>(
            future: GET_ACC_ACC_REP(controller.SelectDataFromBIID.toString(),controller.SelectDataToBIID.toString()),
            builder: (BuildContext context,
                AsyncSnapshot<List<Acc_Acc_Local>> snapshot) {
              if (!snapshot.hasData) {
                return Dropdown(
                  josnStatus: josnStatus,
                  GETSTRING: 'StringAccount',
                );
              }
              return DropdownButtonFormField2(
                decoration: ThemeHelper().InputDecorationDropDown(" ${'StringAANO_F'.tr}"),
                dropdownStyleData: const DropdownStyleData(
                  maxHeight: 400,
                ),
                isDense: true,
                isExpanded: true,
                hint: ThemeHelper().buildText(context,'StringAANO_F', Colors.grey,'S'),
                items: snapshot.data!.map((item) => DropdownMenuItem<String>(
                  onTap: (){
                    controller.AANAController.text= item.AANA_D.toString();
                    controller.AANOController.text= item.AANO.toString();
                    controller.AANO_F= item.AANO.toString();
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
                value: controller.SelectDataAANO,
                onChanged: (value) {
                  setState(() {
                    controller.SelectDataAANO = value as String;
                    controller.update();
                  });
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
                          hintStyle:  TextStyle(fontSize: Dimensions.fonDropDown),
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

  GetBuilder<Reports_Controller> DropdownToACC_ACCBuilder() {
    return GetBuilder<Reports_Controller>(
        init: Reports_Controller(),
        builder: ((controller) => FutureBuilder<List<Acc_Acc_Local>>(
            future: GET_ACC_ACC_REP(controller.SelectDataFromBIID.toString(),controller.SelectDataToBIID.toString()),
            builder: (BuildContext context,
                AsyncSnapshot<List<Acc_Acc_Local>> snapshot) {
              if (!snapshot.hasData) {
                return Dropdown(
                  josnStatus: josnStatus,
                  GETSTRING: 'StringAccount',
                );
              }
              return DropdownButtonFormField2(
                decoration: ThemeHelper().InputDecorationDropDown(" ${'StringAANO_T'.tr}"),
                dropdownStyleData: const DropdownStyleData(
                  maxHeight: 400,
                ),
                isDense: true,
                isExpanded: true,
                hint: ThemeHelper().buildText(context,'StringAANO_T', Colors.grey,'S'),
                items: snapshot.data!
                    .map((item) => DropdownMenuItem<String>(
                  onTap: (){
                    controller.AANAController.text= item.AANA_D.toString();
                    controller.AANOController.text= item.AANO.toString();
                    controller.AANO_T= item.AANO.toString();
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
                onChanged: (value) {
                  setState(() {
                    controller.SelectDataAANO2 = value as String;
                    controller.update();
                  });
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
                          hintStyle:  TextStyle(fontSize: Dimensions.fonDropDown),
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

  GetBuilder<Reports_Controller> DropdownFromBIL_CUSBuilder() {
    return GetBuilder<Reports_Controller>(
        init: Reports_Controller(),
        builder: ((controller) => FutureBuilder<List<Bil_Cus_Local>>(
            future: GET_BIL_CUS_REP(controller.SelectDataFromBIID.toString(),controller.SelectDataToBIID.toString()),
            builder: (BuildContext context,
                AsyncSnapshot<List<Bil_Cus_Local>> snapshot) {
              if (!snapshot.hasData) {
                return Dropdown(
                  josnStatus: josnStatus,
                  GETSTRING: 'StringAccount',
                );
              }
              return DropdownButtonFormField2(
                decoration: ThemeHelper().InputDecorationDropDown(" ${'StringAANO_F'.tr}"),
                dropdownStyleData: const DropdownStyleData(
                  maxHeight: 400,
                ),
                isDense: true,
                isExpanded: true,
                hint: ThemeHelper().buildText(context,'StringAANO_F', Colors.grey,'S'),
                items: snapshot.data!
                    .map((item) => DropdownMenuItem<String>(
                  onTap: (){
                    controller.BCID_F= item.BCID.toString();
                  },
                  value: item.BCNA_D.toString(),
                  child: Text(
                    item.BCNA_D.toString(),
                    style: ThemeHelper().buildTextStyle(context, Colors.black,'M'),
                  ),
                )).toList().obs,
                value: controller.BCID_F2,
                onChanged: (value) {
                  setState(() {
                    controller.BCID_F2 = value as String;
                    controller.update();
                  });
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
                          hintStyle:  TextStyle(fontSize: Dimensions.fonDropDown),
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

  GetBuilder<Reports_Controller> DropdownTO_BIL_CUSBuilder() {
    return GetBuilder<Reports_Controller>(
        init: Reports_Controller(),
        builder: ((controller) => FutureBuilder<List<Bil_Cus_Local>>(
            future: GET_BIL_CUS_REP(controller.SelectDataFromBIID.toString(),controller.SelectDataToBIID.toString()),
            builder: (BuildContext context,
                AsyncSnapshot<List<Bil_Cus_Local>> snapshot) {
              if (!snapshot.hasData) {
                return Dropdown(
                  josnStatus: josnStatus,
                  GETSTRING: 'StringAccount',
                );
              }
              return DropdownButtonFormField2(
                decoration: ThemeHelper().InputDecorationDropDown(" ${'StringAANO_F'.tr}"),
                dropdownStyleData: const DropdownStyleData(
                  maxHeight: 400,
                ),
                isDense: true,
                isExpanded: true,
                hint: ThemeHelper().buildText(context,'StringAANO_F', Colors.grey,'S'),
                items: snapshot.data!
                    .map((item) => DropdownMenuItem<String>(
                  onTap: (){
                    controller.BCID_T= item.BCID.toString();
                  },
                  value: item.BCNA_D.toString(),
                  child: Text(
                    item.BCNA_D.toString(),
                    style: ThemeHelper().buildTextStyle(context, Colors.black,'M'),
                  ),
                )).toList().obs,
                value: controller.BCID_T2,
                onChanged: (value) {
                  setState(() {
                    controller.BCID_T2 = value as String;
                    controller.update();
                  });
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
                          hintStyle:  TextStyle(fontSize: Dimensions.fonDropDown),
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

  GetBuilder<Reports_Controller> DropdownFromBIL_IMPBuilder() {
    return GetBuilder<Reports_Controller>(
        init: Reports_Controller(),
        builder: ((controller) => FutureBuilder<List<Bil_Imp_Local>>(
            future: GET_BIL_IMP_REP(),
            builder: (BuildContext context,
                AsyncSnapshot<List<Bil_Imp_Local>> snapshot) {
              if (!snapshot.hasData) {
                return Dropdown(
                  josnStatus: josnStatus,
                  GETSTRING: 'StringAccount',
                );
              }
              return DropdownButtonFormField2(
                decoration: ThemeHelper().InputDecorationDropDown(" ${'StringAANO_F'.tr}"),
                dropdownStyleData: const DropdownStyleData(
                  maxHeight: 400,
                ),
                isDense: true,
                isExpanded: true,
                hint: ThemeHelper().buildText(context,'StringAANO_F', Colors.grey,'S'),
                items: snapshot.data!.map((item) => DropdownMenuItem<String>(
                  onTap: (){
                    controller.BIID_F= item.BIID.toString();
                  },
                  value: item.BINA_D.toString(),
                  child: Text(
                    item.BINA_D.toString(),
                    style: ThemeHelper().buildTextStyle(context, Colors.black,'M'),
                  ),
                )).toList().obs,
                value: controller.BIID_F2,
                onChanged: (value) {
                  setState(() {
                    controller.BIID_F2 = value as String;
                    controller.update();
                  });
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
                          hintStyle:  TextStyle(fontSize: Dimensions.fonDropDown),
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

  GetBuilder<Reports_Controller> DropdownTO_BIL_IMPBuilder() {
    return GetBuilder<Reports_Controller>(
        init: Reports_Controller(),
        builder: ((controller) => FutureBuilder<List<Bil_Imp_Local>>(
            future: GET_BIL_IMP_REP(),
            builder: (BuildContext context,
                AsyncSnapshot<List<Bil_Imp_Local>> snapshot) {
              if (!snapshot.hasData) {
                return Dropdown(
                  josnStatus: josnStatus,
                  GETSTRING: 'StringAccount',
                );
              }
              return DropdownButtonFormField2(
                decoration: ThemeHelper().InputDecorationDropDown(" ${'StringAANO_F'.tr}"),
                dropdownStyleData: const DropdownStyleData(
                  maxHeight: 400,
                ),
                isDense: true,
                isExpanded: true,
                hint: ThemeHelper().buildText(context,'StringAANO_F', Colors.grey,'S'),
                items: snapshot.data!.map((item) => DropdownMenuItem<String>(
                  onTap: (){
                    controller.BIID_T= item.BIID.toString();
                  },
                  value: item.BINA_D.toString(),
                  child: Text(
                    item.BINA_D.toString(),
                    style: ThemeHelper().buildTextStyle(context, Colors.black,'M'),
                  ),
                )).toList().obs,
                value: controller.BIID_T2,
                onChanged: (value) {
                  setState(() {
                    controller.BIID_T2 = value as String;
                    controller.update();
                  });
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
                          hintStyle:  TextStyle(fontSize: Dimensions.fonDropDown),
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

  GetBuilder<Reports_Controller> DropdownGET_BRA_TBuilder() {
    return GetBuilder<Reports_Controller>(
        init: Reports_Controller(),
        builder: ((controller) => FutureBuilder<List<Sys_Lan_Local>>(
            future: GET_SYS_LAN('5','BMMBR'," AND SLSC IN('1','2')"),
            builder: (BuildContext context,
                AsyncSnapshot<List<Sys_Lan_Local>> snapshot) {
              if (!snapshot.hasData) {
                return Dropdown(
                  josnStatus: josnStatus,
                  GETSTRING: 'StringSH_BY',
                );
              }
              return DropdownButtonFormField2(
                decoration: ThemeHelper().InputDecorationDropDown(" ${'StringSH_BY'.tr}"),
                isDense: true,
                isExpanded: true,
                items: snapshot.data!.map((item) => DropdownMenuItem<String>(
                  value: item.SLSC.toString(),
                  child: Text(
                    item.SLN_D.toString(),
                    style: ThemeHelper().buildTextStyle(context, Colors.black,'M'),
                  ),
                )).toList().obs,
                value: controller.SelectGET_BRA_T,
                onChanged: (value) {
                  setState(() {
                    controller.SelectGET_BRA_T = value.toString();
                    controller.update();
                  });
                },
              );
            })));
  }

  GetBuilder<Reports_Controller> DropdownFromBIL_CUS_TBuilder() {
    return GetBuilder<Reports_Controller>(
        init: Reports_Controller(),
        builder: ((controller) => FutureBuilder<List<Bil_Cus_T_Local>>(
            future: GET_BIL_CUS_T(),
            builder: (BuildContext context,
                AsyncSnapshot<List<Bil_Cus_T_Local>> snapshot) {
              if (!snapshot.hasData) {
                return Padding(
                  padding: EdgeInsets.only(left: Dimensions.width5),
                  child: Dropdown(josnStatus: josnStatus, GETSTRING: 'StringAccount'),
                );
              }
              return Padding(
                padding:  EdgeInsets.only(left: Dimensions.height5),
                child: DropdownButtonFormField2(
                  decoration: ThemeHelper().InputDecorationDropDown(" ${'StringType_F'.tr}"),
                  dropdownStyleData: const DropdownStyleData(
                    maxHeight: 400,
                  ),
                  isDense: true,
                  isExpanded: true,
                  hint: ThemeHelper().buildText(context,'StringType_F', Colors.grey,'S'),
                  items: snapshot.data!
                      .map((item) => DropdownMenuItem<String>(
                    onTap: (){
                      controller.BCTID_F= item.BCTID.toString();
                    },
                    value: item.BCTNA_D.toString(),
                    child: Text(
                      item.BCTNA_D.toString(),
                      style: ThemeHelper().buildTextStyle(context, Colors.black,'M'),
                    ),
                  )).toList().obs,
                  value: controller.SelectDataBCTID,
                  onChanged: (value) {
                    setState(() {
                      controller.SelectDataBCTID = value as String;
                      controller.update();
                    });
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
                            hintText: 'StringSearch'.tr,
                            hintStyle:  TextStyle(fontSize: Dimensions.fonDropDown),
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
                ),
              );
            })));
  }

  GetBuilder<Reports_Controller> DropdownToBIL_CUS_TBuilder() {
    return GetBuilder<Reports_Controller>(
        init: Reports_Controller(),
        builder: ((controller) => FutureBuilder<List<Bil_Cus_T_Local>>(
            future: GET_BIL_CUS_T(),
            builder: (BuildContext context,AsyncSnapshot<List<Bil_Cus_T_Local>> snapshot) {
              if (!snapshot.hasData) {
                return Padding(
                  padding: EdgeInsets.only(right: Dimensions.height5),
                  child: Dropdown(josnStatus: josnStatus, GETSTRING: 'StringType_T',),
                );
              }
              return Padding(
                  padding: EdgeInsets.only(right: Dimensions.height5),
                child: DropdownButtonFormField2(
                  decoration: ThemeHelper().InputDecorationDropDown(" ${'StringType_T'.tr}"),
                  dropdownStyleData: const DropdownStyleData(
                    maxHeight: 400,
                  ),
                  isDense: true,
                  isExpanded: true,
                  hint: ThemeHelper().buildText(context,'StringType_T', Colors.grey,'S'),
                  items: snapshot.data!
                      .map((item) => DropdownMenuItem<String>(
                    onTap: (){
                      controller.BCTID_T= item.BCTID.toString();
                    },
                    value: item.BCTNA_D.toString(),
                    child: Text(
                      item.BCTNA_D.toString(),
                      style: ThemeHelper().buildTextStyle(context, Colors.black,'M'),
                    ),
                  )).toList().obs,
                  value: controller.SelectDataBCTID2,
                  onChanged: (value) {
                    setState(() {
                      controller.SelectDataBCTID2 = value as String;
                      controller.update();
                    });
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
                            hintText: 'StringSearch'.tr,
                            hintStyle:  TextStyle(fontSize: Dimensions.fonDropDown),
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
                ),
              );
            })));
  }

  GetBuilder<Reports_Controller> DropdownFrom_BIL_IMP_TBuilder() {
    return GetBuilder<Reports_Controller>(
        init: Reports_Controller(),
        builder: ((controller) => FutureBuilder<List<Bil_Imp_T_Local>>(
            future: GET_BIL_IMP_T(),
            builder: (BuildContext context,
                AsyncSnapshot<List<Bil_Imp_T_Local>> snapshot) {
              if (!snapshot.hasData) {
                return Padding(
                  padding: EdgeInsets.only(left: Dimensions.width5),
                  child: Dropdown(josnStatus: josnStatus, GETSTRING: 'StringAccount'),
                );
              }
              return Padding(
                padding:  EdgeInsets.only(left: Dimensions.height5),
                child: DropdownButtonFormField2(
                  decoration: ThemeHelper().InputDecorationDropDown(" ${'StringType_F'.tr}"),
                  dropdownStyleData: const DropdownStyleData(
                    maxHeight: 400,
                  ),
                  isDense: true,
                  isExpanded: true,
                  hint: ThemeHelper().buildText(context,'StringType_F', Colors.grey,'S'),
                  items: snapshot.data!
                      .map((item) => DropdownMenuItem<String>(
                    onTap: (){
                      controller.BITID_F= item.BITID.toString();
                    },
                    value: item.BITNA_D.toString(),
                    child: Text(
                      item.BITNA_D.toString(),
                      style: ThemeHelper().buildTextStyle(context, Colors.black,'M'),
                    ),
                  )).toList().obs,
                  value: controller.BITID2_F,
                  onChanged: (value) {
                    setState(() {
                      controller.BITID2_F = value as String;
                      controller.update();
                    });
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
                            hintText: 'StringSearch'.tr,
                            hintStyle:  TextStyle(fontSize: Dimensions.fonDropDown),
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
                ),
              );
            })));
  }

  GetBuilder<Reports_Controller> DropdownTO_BIL_IMP_TBuilder() {
    return GetBuilder<Reports_Controller>(
        init: Reports_Controller(),
        builder: ((controller) => FutureBuilder<List<Bil_Imp_T_Local>>(
            future: GET_BIL_IMP_T(),
            builder: (BuildContext context,
                AsyncSnapshot<List<Bil_Imp_T_Local>> snapshot) {
              if (!snapshot.hasData) {
                return Padding(
                  padding: EdgeInsets.only(left: Dimensions.width5),
                  child: Dropdown(josnStatus: josnStatus, GETSTRING: 'StringAccount'),
                );
              }
              return Padding(
                padding:  EdgeInsets.only(left: Dimensions.height5),
                child: DropdownButtonFormField2(
                  decoration: ThemeHelper().InputDecorationDropDown(" ${'StringType_F'.tr}"),
                  dropdownStyleData: const DropdownStyleData(
                    maxHeight: 400,
                  ),
                  isDense: true,
                  isExpanded: true,
                  hint:  ThemeHelper().buildText(context,'StringType_T', Colors.grey,'S'),
                  items: snapshot.data!
                      .map((item) => DropdownMenuItem<String>(
                    onTap: (){
                      controller.BITID_T= item.BITID.toString();
                    },
                    value: item.BITNA_D.toString(),
                    child: Text(
                      item.BITNA_D.toString(),
                      style: ThemeHelper().buildTextStyle(context, Colors.black,'M'),
                    ),
                  )).toList().obs,
                  value: controller.BITID2_T,
                  onChanged: (value) {
                    setState(() {
                      controller.BITID2_T = value as String;
                      controller.update();
                    });
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
                            hintText: 'StringSearch'.tr,
                            hintStyle:  TextStyle(fontSize: Dimensions.fonDropDown),
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
                ),
              );
            })));
  }

  FutureBuilder<List<Acc_Gro_Local>> DropdownAcc_Gro_FBuilder() {
    return FutureBuilder<List<Acc_Gro_Local>>(
        future:  GET_ACC_GRO(),
        builder: (BuildContext context,
            AsyncSnapshot<List<Acc_Gro_Local>> snapshot) {
          if (!snapshot.hasData) {
            return Padding(padding: EdgeInsets.only(left: Dimensions.width5),
              child: Dropdown(josnStatus: josnStatus, GETSTRING: '',),
            );
          }
          return Padding(
            padding: EdgeInsets.only(left: Dimensions.width5),
            child: DropdownButtonFormField2(
              decoration: ThemeHelper().InputDecorationDropDown(" ${'StringFromMgno'.tr}"),
              isExpanded: true,
              hint: ThemeHelper().buildText(context,'StringFromMgno', Colors.grey,'S'),
              value: controller.AGID_F,
              style: ThemeHelper().buildTextStyle(context, Colors.black,'M'),
              items: snapshot.data!
                  .map((item) => DropdownMenuItem<String>(
                value: item.AGID.toString(),
                child: Text(
                  item.AGNA.toString(),
                  style:  ThemeHelper().buildTextStyle(context, Colors.black,'M'),
                ),
              )).toList().obs,
              onChanged: (value) {
                controller.AGID_F = value.toString();
              },
            ),
          );
        });
  }

  FutureBuilder<List<Acc_Gro_Local>> DropdownAcc_Gro_TBuilder() {
    return FutureBuilder<List<Acc_Gro_Local>>(
        future:  GET_ACC_GRO(),
        builder: (BuildContext context,
            AsyncSnapshot<List<Acc_Gro_Local>> snapshot) {
          if (!snapshot.hasData) {
            return Padding(
              padding: EdgeInsets.only(right: Dimensions.height5),
              child: Dropdown(josnStatus: josnStatus, GETSTRING: '',),
            );
          }
          return  Padding(padding: EdgeInsets.only(right: Dimensions.height5),
              child:DropdownButtonFormField2(
                decoration: ThemeHelper().InputDecorationDropDown(" ${'StringToMgno'.tr}"),
                isExpanded: true,
                hint:  ThemeHelper().buildText(context,'StringToMgno', Colors.grey,'S'),
                value: controller.AGID_T,
                style: ThemeHelper().buildTextStyle(context, Colors.black,'M'),
                items: snapshot.data!.map((item) => DropdownMenuItem<String>(
                  value: item.AGID.toString(),
                  child: Text(
                    item.AGNA.toString(),
                    style: ThemeHelper().buildTextStyle(context, Colors.black,'M'),
                  ),
                )).toList().obs,
                onChanged: (value) {
                  controller.AGID_T = value.toString();
                },
              ));
        });
  }

  GetBuilder<Reports_Controller> DropdownGET_ST_FBuilder() {
    return GetBuilder<Reports_Controller>(
        init: Reports_Controller(),
        builder: ((controller) => FutureBuilder<List<Sys_Lan_Local>>(
            future: GET_SYS_LAN('5','ST',""),
            builder: (BuildContext context,
                AsyncSnapshot<List<Sys_Lan_Local>> snapshot) {
              if (!snapshot.hasData) {
                return Dropdown(
                  josnStatus: josnStatus,
                  GETSTRING: 'StringST_F',
                );
              }
              return DropdownButtonFormField2(
                decoration: ThemeHelper().InputDecorationDropDown(" ${'StringST_F'.tr}"),
                isDense: true,
                isExpanded: true,
                items: snapshot.data!.map((item) => DropdownMenuItem<String>(
                  value: item.SLSC.toString(),
                  child: Text(
                    item.SLN_D.toString(),
                    style: ThemeHelper().buildTextStyle(context, Colors.black,'M'),
                  ),
                )).toList().obs,
                value: controller.ST_F,
                onChanged: (value) {
                  setState(() {
                    controller.ST_F = value.toString();
                    controller.update();
                  });
                },
              );
            })));
  }

  GetBuilder<Reports_Controller> DropdownGET_ST_TBuilder() {
    return GetBuilder<Reports_Controller>(
        init: Reports_Controller(),
        builder: ((controller) => FutureBuilder<List<Sys_Lan_Local>>(
            future: GET_SYS_LAN('5','ST',""),
            builder: (BuildContext context,
                AsyncSnapshot<List<Sys_Lan_Local>> snapshot) {
              if (!snapshot.hasData) {
                return Dropdown(
                  josnStatus: josnStatus,
                  GETSTRING: 'StringST_T',
                );
              }
              return DropdownButtonFormField2(
                decoration: ThemeHelper().InputDecorationDropDown(" ${'StringST_T'.tr}"),
                isDense: true,
                isExpanded: true,
                items: snapshot.data!.map((item) => DropdownMenuItem<String>(
                  value: item.SLSC.toString(),
                  child: Text(
                    item.SLN_D.toString(),
                    style: ThemeHelper().buildTextStyle(context, Colors.black,'M'),
                  ),
                )).toList().obs,
                value: controller.ST_T,
                onChanged: (value) {
                  setState(() {
                    controller.ST_T = value.toString();
                    controller.update();
                  });
                },
              );
            })));
  }

  GetBuilder<Reports_Controller> DropdownGET_AMMSTBuilder() {
    return GetBuilder<Reports_Controller>(
        init: Reports_Controller(),
        builder: ((controller) => FutureBuilder<List<Sys_Lan_Local>>(
            future: GET_SYS_LAN('5','AMMST'," AND SLSC IN(1,5)"),
            builder: (BuildContext context,
                AsyncSnapshot<List<Sys_Lan_Local>> snapshot) {
              if (!snapshot.hasData) {
                return Dropdown(
                  josnStatus: josnStatus,
                  GETSTRING: 'StringState',
                );
              }
              return DropdownButtonFormField2(
                decoration: ThemeHelper().InputDecorationDropDown(" ${'StringState'.tr}"),
                isDense: true,
                isExpanded: true,
                items: snapshot.data!.map((item) => DropdownMenuItem<String>(
                  value: item.SLSC.toString(),
                  child: Text(
                    item.SLN_D.toString(),
                    style: ThemeHelper().buildTextStyle(context, Colors.black,'M'),
                  ),
                )).toList().obs,
                value: controller.AMMST_T,
                onChanged: (value) {
                  setState(() {
                    controller.AMMST_T = value.toString();
                    controller.update();
                  });
                },
              );
            })));
  }

  GetBuilder<Reports_Controller> DropdownGET_AC_V_BBuilder() {
    return GetBuilder<Reports_Controller>(
        init: Reports_Controller(),
        builder: ((controller) => FutureBuilder<List<Sys_Lan_Local>>(
            future: GET_SYS_LAN('5','AC_V_B',""),
            builder: (BuildContext context,
                AsyncSnapshot<List<Sys_Lan_Local>> snapshot) {
              if (!snapshot.hasData) {
                return Dropdown(
                  josnStatus: josnStatus,
                  GETSTRING: '',
                );
              }
              return DropdownButtonFormField2(
                decoration: ThemeHelper().InputDecorationDropDown(""),
                isDense: true,
                isExpanded: true,
                items: snapshot.data!.map((item) => DropdownMenuItem<String>(
                  value: item.SLSC.toString(),
                  child: Text(
                    item.SLN_D.toString(),
                    style: ThemeHelper().buildTextStyle(context, Colors.black,'M'),
                  ),
                )).toList().obs,
                value: controller.AC_V_B,
                onChanged: (value) {
                  setState(() {
                    controller.AC_V_B = value.toString();
                    controller.update();
                  });
                },
              );
            })));
  }

  GetBuilder<Reports_Controller> DropdownCou_WrdBuilder() {
    return GetBuilder<Reports_Controller>(
        init: Reports_Controller(),
        builder: ((controller) => FutureBuilder<List<Cou_Wrd_Local>>(
            future: GET_COU_WRD(),
            builder: (BuildContext context, AsyncSnapshot<List<Cou_Wrd_Local>> snapshot) {
              if (!snapshot.hasData) {
                return Dropdown(josnStatus: josnStatus,GETSTRING: 'StringChooseCountry',);
              }
              return DropdownButtonFormField2(
                decoration: InputDecoration(
                  isDense: true,
                  contentPadding: const EdgeInsets.symmetric(vertical: 13, horizontal: 8),
                  labelText: 'StringChooseCountry'.tr,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(Dimensions.height15),
                  ),
                  focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(Dimensions.width15),
                      borderSide: BorderSide(color: Colors.grey.shade400)),
                ),
                dropdownStyleData: const DropdownStyleData(
                  maxHeight: 200,
                ),
                isExpanded: true,
                hint:  ThemeHelper().buildText(context,'StringChooseCountry', Colors.grey,'S'),
                value: controller.SelectDataCWID2,
                style: const TextStyle(
                    fontFamily: 'Hacen',
                    color: Colors.black,
                    fontWeight: FontWeight.bold),
                items: snapshot.data!.map((item) => DropdownMenuItem<String>(
                  value: "${item.CWID.toString() + " +++ " + item.CWNA_D.toString()}",
                  // value: item.CWID.toString(),
                  child: Text(
                    item.CWNA_D.toString(),
                    style: ThemeHelper().buildTextStyle(context, Colors.black,'M'),
                  ),
                )).toList().obs,
                onChanged: (value) {
                  setState(() {
                    controller.SelectDataCWID2 = value as String;
                    controller.SelectDataCWID = value.toString().split(" +++ ")[0];
                    controller.update();
                  });
                },
                dropdownSearchData: DropdownSearchData(
                  searchInnerWidgetHeight: 50,
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
                        hintText: 'StringSearch_for_CWID'.tr,
                        hintStyle: const TextStyle(fontSize: 12),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                    ),
                  ),
                  searchMatchFn: (item, searchValue) {
                    return (item.value
                        .toString()
                        .toLowerCase()
                        .contains(searchValue));
                  },
                ),
                //This to clear the search value when you close the menu
                onMenuStateChange: (isOpen) {
                  if (!isOpen) {
                    controller.TextEditingSercheController.clear();
                  }
                },
              );
            })));
  }

  GetBuilder<Reports_Controller> DropdownCOU_TOWBuilder() {
    return GetBuilder<Reports_Controller>(
        init: Reports_Controller(),
        builder: ((controller) => FutureBuilder<List<Cou_Tow_Local>>(
            future: GET_COU_TOW(controller.SelectDataCWID.toString()),
            builder: (BuildContext context,
                AsyncSnapshot<List<Cou_Tow_Local>> snapshot) {
              if (!snapshot.hasData) {
                return Dropdown(
                  josnStatus: josnStatus,
                  GETSTRING: 'StringBrach',
                );
              }
              return DropdownButtonFormField2(
                decoration: InputDecoration(
                  isDense: true,
                  contentPadding: const EdgeInsets.symmetric(vertical: 13, horizontal: 8),
                  labelText: 'StringCity'.tr,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(Dimensions.height15),
                  ),
                  focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(Dimensions.width15),
                      borderSide: BorderSide(color: Colors.grey.shade400)),
                ),
                dropdownStyleData: const DropdownStyleData(
                  maxHeight: 200,
                ),
                isExpanded: true,
                hint: ThemeHelper().buildText(context,'StringCity', Colors.grey,'S'),
                items: snapshot.data!.map((item) => DropdownMenuItem<String>(
                  value: "${item.CTID.toString() + " +++ " + item.CTNA_D.toString()}",
                  //   value: item.CTID.toString(),
                  child: Text(
                    item.CTNA_D.toString(),
                    style: ThemeHelper().buildTextStyle(context, Colors.black,'M'),
                  ),
                )).toList().obs,
                value: controller.SelectDataCTID2,
                onChanged: (value) {
                  setState(() {
                    controller.SelectDataCTID2 = value as String;
                    controller.SelectDataCTID = value.toString().split(" +++ ")[0];
                  });
                },
                dropdownSearchData: DropdownSearchData(
                  searchInnerWidgetHeight: 60,
                  searchController: controller.TextEditingSercheController,
                  searchInnerWidget: Padding(padding: const EdgeInsets.only(top: 8, bottom: 4, right: 8, left: 8,),
                    child: TextFormField(
                      controller: controller.TextEditingSercheController,
                      decoration: InputDecoration(
                        isDense: true,
                        contentPadding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8,),
                        hintText: 'StringSearch_for_CTID'.tr,
                        hintStyle: const TextStyle(fontSize: 12),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                    ),
                  ),
                  searchMatchFn: (item, searchValue) {return (item.value.toString().toLowerCase().contains(searchValue));},
                ),
                //This to clear the search value when you close the menu
                onMenuStateChange: (isOpen) {
                  if (!isOpen) {
                    controller.TextEditingSercheController.clear();
                  }
                },
              );
            })));
  }

  GetBuilder<Reports_Controller> DropdownBIL_ARE_FBuilder() {
    return GetBuilder<Reports_Controller>(
        init: Reports_Controller(),
        builder: ((controller) => FutureBuilder<List<Bil_Are_Local>>(
            future: GET_BIL_ARE(controller.SelectDataCWID.toString(),
                controller.SelectDataCTID.toString()),
            builder: (BuildContext context,
                AsyncSnapshot<List<Bil_Are_Local>> snapshot) {
              if (!snapshot.hasData) {
                return Padding(
                  padding: EdgeInsets.only(left: Dimensions.width5),
                  child: Dropdown(josnStatus: josnStatus, GETSTRING: 'StringBAID_F'),
                );
              }
              return Padding(
                padding: EdgeInsets.only(left: Dimensions.width5),
                child: DropdownButtonFormField2(
                  decoration: InputDecoration(
                    isDense: true,
                    contentPadding: const EdgeInsets.symmetric(vertical: 13, horizontal: 8),
                    labelText: 'StringBAID_F'.tr,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(Dimensions.height15),
                    ),
                    focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(Dimensions.width15),
                        borderSide: BorderSide(color: Colors.grey.shade400)),
                  ),
                  dropdownStyleData: const DropdownStyleData(
                    maxHeight: 200,
                  ),
                  isExpanded: true,
                  hint: ThemeHelper().buildText(context,'StringBAID_F', Colors.grey,'S'),
                  items: snapshot.data!.map((item) => DropdownMenuItem<String>(
                    value: "${item.BAID.toString() + " +++ " + item.BANA_D.toString()}",
                    //  value: item.BAID.toString(),
                    child: Text(
                      item.BANA_D.toString(),
                      style: ThemeHelper().buildTextStyle(context, Colors.black,'M'),
                    ),
                  )).toList().obs,
                  value: controller.BAID2_F,
                  onChanged: (value) {
                    setState(() {
                      controller.BAID2_F = value as String;
                      controller.BAID_F = value.toString().split(" +++ ")[0];
                    });
                  },
                  dropdownSearchData: DropdownSearchData(
                    searchInnerWidgetHeight: 60,
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
                          hintText: 'StringSearch_for_BAID'.tr,
                          hintStyle: const TextStyle(fontSize: 12),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                      ),
                    ),
                    searchMatchFn: (item, searchValue) {
                      return (item.value.toString().toLowerCase().contains(searchValue));
                    },
                  ),
                  //This to clear the search value when you close the menu
                  onMenuStateChange: (isOpen) {
                    if (!isOpen) {
                      controller.TextEditingSercheController.clear();
                    }
                  },

                ),
              );
            })));
  }

  GetBuilder<Reports_Controller> DropdownBIL_ARE_TBuilder() {
    return GetBuilder<Reports_Controller>(
        init: Reports_Controller(),
        builder: ((controller) => FutureBuilder<List<Bil_Are_Local>>(
            future: GET_BIL_ARE(controller.SelectDataCWID.toString(),
                controller.SelectDataCTID.toString()),
            builder: (BuildContext context,
                AsyncSnapshot<List<Bil_Are_Local>> snapshot) {
              if (!snapshot.hasData) {
                return Padding(
                  padding: EdgeInsets.only(right: Dimensions.width5),
                  child: Dropdown(josnStatus: josnStatus, GETSTRING: 'StringBAID_T'),
                );
              }
              return Padding(
                padding: EdgeInsets.only(right: Dimensions.width5),
                child: DropdownButtonFormField2(
                  decoration: InputDecoration(
                    isDense: true,
                    contentPadding: const EdgeInsets.symmetric(vertical: 13, horizontal: 8),
                    labelText: 'StringBAID_T'.tr,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(Dimensions.height15),
                    ),
                    focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(Dimensions.width15),
                        borderSide: BorderSide(color: Colors.grey.shade400)),
                  ),
                  dropdownStyleData: const DropdownStyleData(
                    maxHeight: 200,
                  ),
                  isExpanded: true,
                  hint: ThemeHelper().buildText(context,'StringBAID_T', Colors.grey,'S'),
                  items: snapshot.data!.map((item) => DropdownMenuItem<String>(
                    value: "${item.BAID.toString() + " +++ " + item.BANA_D.toString()}",
                    //  value: item.BAID.toString(),
                    child: Text(
                      item.BANA_D.toString(),
                      style: ThemeHelper().buildTextStyle(context, Colors.black,'M'),
                    ),
                  )).toList().obs,
                  value: controller.BAID2_T,
                  onChanged: (value) {
                    setState(() {
                      controller.BAID2_T = value as String;
                      controller.BAID_T = value.toString().split(" +++ ")[0];
                    });
                  },
                  dropdownSearchData: DropdownSearchData(
                    searchInnerWidgetHeight: 60,
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
                          hintText: 'StringSearch_for_BAID'.tr,
                          hintStyle: const TextStyle(fontSize: 12),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                      ),
                    ),
                    searchMatchFn: (item, searchValue) {
                      return (item.value
                          .toString()
                          .toLowerCase()
                          .contains(searchValue));
                    },
                  ),
                  //This to clear the search value when you close the menu
                  onMenuStateChange: (isOpen) {
                    if (!isOpen) {
                      controller.TextEditingSercheController.clear();
                    }
                  },

                ),
              );
            })));
  }

  GetBuilder<Reports_Controller> DropdownBIL_DIS_FBuilder() {
    return GetBuilder<Reports_Controller>(
        init: Reports_Controller(),
        builder: ((controller) => FutureBuilder<List<Bil_Dis_Local>>(
            future: GET_BIL_DIS(controller.SelectDataFromBIID.toString()),
            builder: (BuildContext context,
                AsyncSnapshot<List<Bil_Dis_Local>> snapshot) {
              if (!snapshot.hasData) {
                return Padding(
                  padding: EdgeInsets.only(left: Dimensions.width5),
                  child: Dropdown(
                    josnStatus: josnStatus,
                    GETSTRING: 'StringCollector'.tr,
                  ),
                );
              }
              return Padding(
                padding: EdgeInsets.only(left: Dimensions.width5),
                child: DropdownButtonFormField2(
                  decoration: ThemeHelper().InputDecorationDropDown('StringCollector'.tr),
                  isDense: true,
                  isExpanded: true,
                  hint: ThemeHelper().buildText(context,'StringCollector', Colors.grey,'S'),
                  items: snapshot.data!.map((item) => DropdownMenuItem<String>(
                    onTap: (){
                      controller.BDID_F = item.BDID.toString();
                      controller.update();
                    },
                    value: item.BDNA.toString(),
                    child: Text(
                      item.BDNA.toString(),
                      style: ThemeHelper().buildTextStyle(context, Colors.black,'M'),
                    ),
                  )).toList().obs,
                  value: controller.BDID2_F,
                  onChanged: (value) {
                    controller.BDID2_F=value.toString();
                    controller.update();
                  },
                  dropdownStyleData: const DropdownStyleData(
                    maxHeight: 250,
                  ),
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
                            suffixIcon: IconButton(icon: const Icon(
                              Icons.clear,
                              size: 20,
                            ),
                              onPressed: (){
                                controller.TextEditingSercheController.clear();
                                controller.update();
                              },),
                            contentPadding: const EdgeInsets.symmetric(
                              horizontal: 10,
                              vertical: 8,
                            ),
                            hintText: 'StringSearch_for_BDID'.tr,
                            hintStyle:  TextStyle(fontSize: Dimensions.fonTextSmall),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                          ),
                        ),
                      ),
                      searchMatchFn: (item, searchValue) {
                        return (item.value
                            .toString()
                            .toLowerCase()
                            .contains(searchValue));
                      },
                      searchInnerWidgetHeight: 50),
                  //This to clear the search value when you close the menu
                  onMenuStateChange: (isOpen) {
                    if (!isOpen) {
                      controller.TextEditingSercheController.clear();
                    }
                  },
                ),
              );
            })));
  }

  GetBuilder<Reports_Controller> DropdownBIL_DIS_TBuilder() {
    return GetBuilder<Reports_Controller>(
        init: Reports_Controller(),
        builder: ((controller) => FutureBuilder<List<Bil_Dis_Local>>(
            future: GET_BIL_DIS(controller.SelectDataFromBIID.toString()),
            builder: (BuildContext context,
                AsyncSnapshot<List<Bil_Dis_Local>> snapshot) {
              if (!snapshot.hasData) {
                return Padding(
                  padding:  EdgeInsets.only(right: Dimensions.width5),
                  child: Dropdown(josnStatus: josnStatus, GETSTRING: 'StringCollector'.tr,),
                );
              }
              return Padding(
                padding:  EdgeInsets.only(right: Dimensions.width5),
                child: DropdownButtonFormField2(
                  decoration: ThemeHelper().InputDecorationDropDown('StringCollector'.tr),
                  isDense: true,
                  isExpanded: true,
                  hint: ThemeHelper().buildText(context,'StringCollector', Colors.grey,'S'),
                  items: snapshot.data!.map((item) => DropdownMenuItem<String>(
                    onTap: (){
                      controller.BDID_T = item.BDID.toString();
                      controller.update();
                    },
                    value: item.BDNA.toString(),
                    child: Text(
                      item.BDNA.toString(),
                      style: ThemeHelper().buildTextStyle(context, Colors.black,'M'),
                    ),
                  )).toList().obs,
                  value: controller.BDID2_T,
                  onChanged: (value) {
                    controller.BDID2_T=value.toString();
                    controller.update();
                  },
                  dropdownStyleData: const DropdownStyleData(
                    maxHeight: 250,
                  ),
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
                            suffixIcon: IconButton(icon: const Icon(
                              Icons.clear,
                              size: 20,
                            ),
                              onPressed: (){
                                controller.TextEditingSercheController.clear();
                                controller.update();
                              },),
                            contentPadding: const EdgeInsets.symmetric(
                              horizontal: 10,
                              vertical: 8,
                            ),
                            hintText: 'StringSearch_for_BDID'.tr,
                            hintStyle:  TextStyle(fontSize: Dimensions.fonTextSmall),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                          ),
                        ),
                      ),
                      searchMatchFn: (item, searchValue) {
                        return (item.value
                            .toString()
                            .toLowerCase()
                            .contains(searchValue));
                      },
                      searchInnerWidgetHeight: 50),
                  //This to clear the search value when you close the menu
                  onMenuStateChange: (isOpen) {
                    if (!isOpen) {
                      controller.TextEditingSercheController.clear();
                    }
                  },
                ),
              );
            })));
  }

  GetBuilder<Reports_Controller> DropdownGET_CON3_FBuilder() {
    return GetBuilder<Reports_Controller>(
        init: Reports_Controller(),
        builder: ((controller) => Padding(
          padding: EdgeInsets.only(left: Dimensions.width5),
          child: DropdownButtonFormField2(
            decoration:  ThemeHelper().InputDecorationDropDown(" ${'StringFrom_Amount'.tr}"),
            isExpanded: true,
            value: controller.CON3_F,
            style: ThemeHelper().buildTextStyle(context, Colors.black,'M'),
            items: GET_CON_3
                .map((item) => DropdownMenuItem<String>(
              value: item['id'],
              child: Text(
                item['name'],
                style: ThemeHelper().buildTextStyle(context, Colors.black,'M'),
              ),
            )).toList().obs,
            onChanged: (value) {
              //Do something when changing the item if you want.
              controller.CON3_F = value.toString();
              controller.update();
            },
          ),
        )));
  }

  GetBuilder<Reports_Controller> DropdownGET_CON3_TBuilder() {
    return GetBuilder<Reports_Controller>(
        init: Reports_Controller(),
        builder: ((controller) => Padding(
          padding: EdgeInsets.only(left: Dimensions.width5),
          child: DropdownButtonFormField2(
            decoration:  ThemeHelper().InputDecorationDropDown(" ${'StringTo_Amount'.tr}"),
            isExpanded: true,
            value: controller.CON3_T,
            style: ThemeHelper().buildTextStyle(context, Colors.black,'M'),
            items: GET_CON_4
                .map((item) => DropdownMenuItem<String>(
              value: item['id'],
              child: Text(
                item['name'],
                style: ThemeHelper().buildTextStyle(context, Colors.black,'M'),
              ),
            )).toList().obs,
            onChanged: (value) {
              //Do something when changing the item if you want.
              controller.CON3_T = value.toString();
              controller.update();
            },
          ),
        )));
  }

  GetBuilder<Reports_Controller> DropdownGET_REP_TYPBuilder() {
    return GetBuilder<Reports_Controller>(
        init: Reports_Controller(),
        builder: ((controller) => FutureBuilder<List<Sys_Lan_Local>>(
            future: GET_SYS_LAN('5','REP_TYP',""),
            builder: (BuildContext context,
                AsyncSnapshot<List<Sys_Lan_Local>> snapshot) {
              if (!snapshot.hasData) {
                return Dropdown(
                  josnStatus: josnStatus,
                  GETSTRING: '',
                );
              }
              return DropdownButtonFormField2(
                decoration: ThemeHelper().InputDecorationDropDown(""),
                isDense: true,
                isExpanded: true,
                items: snapshot.data!.map((item) => DropdownMenuItem<String>(
                  value: item.SLSC.toString(),
                  child: Text(
                    item.SLN_D.toString(),
                    style: ThemeHelper().buildTextStyle(context, Colors.black,'M'),
                  ),
                )).toList().obs,
                value: controller.R_TY,
                onChanged: (value) {
                  setState(() {
                    controller.R_TY = value.toString();
                    controller.update();
                  });
                },
              );
            })));
  }

  GetBuilder<Reports_Controller> DropdownGET_REP_DIRBuilder() {
    return GetBuilder<Reports_Controller>(
        init: Reports_Controller(),
        builder: ((controller) => FutureBuilder<List<Sys_Lan_Local>>(
            future: GET_SYS_LAN('5','REP_DIR',""),
            builder: (BuildContext context,
                AsyncSnapshot<List<Sys_Lan_Local>> snapshot) {
              if (!snapshot.hasData) {
                return Dropdown(
                  josnStatus: josnStatus,
                  GETSTRING: '',
                );
              }
              return DropdownButtonFormField2(
                decoration: ThemeHelper().InputDecorationDropDown(""),
                isDense: true,
                isExpanded: true,
                items: snapshot.data!.map((item) => DropdownMenuItem<String>(
                  value: item.SLSC.toString(),
                  child: Text(
                    item.SLN_D.toString(),
                    style: ThemeHelper().buildTextStyle(context, Colors.black,'M'),
                  ),
                )).toList().obs,
                value: controller.REP_DIR,
                onChanged: (value) {
                  setState(() {
                    controller.REP_DIR = value.toString();
                    controller.update();
                  });
                },
              );
            })));
  }

  GetBuilder<Reports_Controller> DropdownGET_R_TYPBuilder() {
    return GetBuilder<Reports_Controller>(
        init: Reports_Controller(),
        builder: ((controller) => FutureBuilder<List<Sys_Lan_Local>>(
            future: GET_SYS_LAN('5','R_TYP'," AND SLSC IN('1','2','3','4','5') "),
            builder: (BuildContext context,
                AsyncSnapshot<List<Sys_Lan_Local>> snapshot) {
              if (!snapshot.hasData) {
                return Dropdown(
                  josnStatus: josnStatus,
                  GETSTRING: '',
                );
              }
              return DropdownButtonFormField2(
                decoration: ThemeHelper().InputDecorationDropDown(""),
                isDense: true,
                isExpanded: true,
                items: snapshot.data!.map((item) => DropdownMenuItem<String>(
                  value: item.SLSC.toString(),
                  child: Text(
                    item.SLN_D.toString(),
                    style: ThemeHelper().buildTextStyle(context, Colors.black,'M'),
                  ),
                )).toList().obs,
                value: controller.R_TYP,
                onChanged: (value) {
                  setState(() {
                    controller.R_TYP = value.toString();
                    controller.update();
                  });
                },
              );
            })));
  }

  GetBuilder<Reports_Controller> DropdownGET_AC_TBuilder() {
    return GetBuilder<Reports_Controller>(
        init: Reports_Controller(),
        builder: ((controller) => FutureBuilder<List<Sys_Lan_Local>>(
            future: GET_SYS_LAN('5','SP_CU_SUP'," AND  SLSC IN('1','2','3')"),
            builder: (BuildContext context,
                AsyncSnapshot<List<Sys_Lan_Local>> snapshot) {
              if (!snapshot.hasData) {
                return Dropdown(
                  josnStatus: josnStatus,
                  GETSTRING: '',
                );
              }
              return DropdownButtonFormField2(
                decoration: ThemeHelper().InputDecorationDropDown(" "),
                isDense: true,
                isExpanded: true,
                items: snapshot.data!.map((item) => DropdownMenuItem<String>(
                  value: item.SLSC.toString(),
                  child: Text(
                    item.SLN_D.toString(),
                    style: ThemeHelper().buildTextStyle(context, Colors.black,'M'),
                  ),
                )).toList().obs,
                value: controller.AC_T,
                onChanged: (value) {
                  setState(() {
                    controller.AC_T = value.toString();
                    controller.update();
                  });
                },
              );
            })));
  }

  GetBuilder<Reports_Controller> DropdownGET_AATYBuilder() {
    return GetBuilder<Reports_Controller>(
        init: Reports_Controller(),
        builder: ((controller) => FutureBuilder<List<Sys_Lan_Local>>(
            future: GET_SYS_LAN('5','AC_V_T'," AND SLSC IN('1','2','3','4')"),
            builder: (BuildContext context,
                AsyncSnapshot<List<Sys_Lan_Local>> snapshot) {
              if (!snapshot.hasData) {
                return Dropdown(
                  josnStatus: josnStatus,
                  GETSTRING: '',
                );
              }
              return DropdownButtonFormField2(
                decoration: ThemeHelper().InputDecorationDropDown(" "),
                isDense: true,
                isExpanded: true,
                items: snapshot.data!.map((item) => DropdownMenuItem<String>(
                  value: item.SLSC.toString(),
                  child: Text(
                    item.SLN_D.toString(),
                    style: ThemeHelper().buildTextStyle(context, Colors.black,'M'),
                  ),
                )).toList().obs,
                value: controller.AATY,
                onChanged: (value) {
                  setState(() {
                    controller.AATY = value.toString();
                    controller.update();
                  });
                },
              );
            })));
  }

  GetBuilder<Reports_Controller> DropdownGET_AC_BAL2Builder() {
    return GetBuilder<Reports_Controller>(
        init: Reports_Controller(),
        builder: ((controller) => FutureBuilder<List<Sys_Lan_Local>>(
            future: GET_SYS_LAN('5','ALL_INF',""),
            builder: (BuildContext context,
                AsyncSnapshot<List<Sys_Lan_Local>> snapshot) {
              if (!snapshot.hasData) {
                return Dropdown(
                  josnStatus: josnStatus,
                  GETSTRING: '',
                );
              }
              return DropdownButtonFormField2(
                decoration: ThemeHelper().InputDecorationDropDown(" "),
                isDense: true,
                isExpanded: true,
                items: snapshot.data!.map((item) => DropdownMenuItem<String>(
                  value: item.SLSC.toString(),
                  child: Text(
                    item.SLN_D.toString(),
                    style: ThemeHelper().buildTextStyle(context, Colors.black,'M'),
                  ),
                )).toList().obs,
                value: controller.AC_BAL2,
                onChanged: (value) {
                  setState(() {
                    controller.AC_BAL2 = value.toString();
                    controller.update();
                  });
                },
              );
            })));
  }

  GetBuilder<Reports_Controller> DropdownGET_REP_GROBuilder() {
    return GetBuilder<Reports_Controller>(
        init: Reports_Controller(),
        builder: ((controller) => FutureBuilder<List<Sys_Lan_Local>>(
            future: GET_SYS_LAN('5','REP_GRO'," AND SLSC IN('0','BRN','COS','STA','PAY','DIS','CUSK','IMPK','ARE','GRO','WRD','TOW')"),
            builder: (BuildContext context,
                AsyncSnapshot<List<Sys_Lan_Local>> snapshot) {
              if (!snapshot.hasData) {
                return Dropdown(
                  josnStatus: josnStatus,
                  GETSTRING: 'StringREP_GRO',
                );
              }
              return DropdownButtonFormField2(
                decoration: ThemeHelper().InputDecorationDropDown(" ${'StringREP_GRO'.tr}"),
                isDense: true,
                isExpanded: true,
                items: snapshot.data!.map((item) => DropdownMenuItem<String>(
                  value: item.SLSC.toString(),
                  child: Text(item.SLN_D.toString(),
                    style: ThemeHelper().buildTextStyle(context, Colors.black,'M'),
                  ),
                )).toList().obs,
                value: controller.REP_GRO,
                onChanged: (value) {
                  setState(() {
                    controller.REP_GRO = value.toString();
                    controller.update();
                  });
                },
              );
            })));
  }

  GetBuilder<Reports_Controller> DropdownGET_REP_GRO2Builder() {
    return GetBuilder<Reports_Controller>(
        init: Reports_Controller(),
        builder: ((controller) => FutureBuilder<List<Sys_Lan_Local>>(
            future: GET_SYS_LAN('5','REP_GRO'," AND SLSC IN('0','BRN','COS','STA','PAY','DIS','CUSK','IMPK','ARE','GRO','WRD','TOW')"),
            builder: (BuildContext context,
                AsyncSnapshot<List<Sys_Lan_Local>> snapshot) {
              if (!snapshot.hasData) {
                return Dropdown(
                  josnStatus: josnStatus,
                  GETSTRING: 'StringREP_GRO2',
                );
              }
              return DropdownButtonFormField2(
                decoration: ThemeHelper().InputDecorationDropDown(" ${'StringREP_GRO2'.tr}"),
                isDense: true,
                isExpanded: true,
                items: snapshot.data!.map((item) => DropdownMenuItem<String>(
                  value: item.SLSC.toString(),
                  child: Text(item.SLN_D.toString(),
                    style: ThemeHelper().buildTextStyle(context, Colors.black,'M'),
                  ),
                )).toList().obs,
                value: controller.REP_GRO2,
                onChanged: (value) {
                  setState(() {
                    controller.REP_GRO2 = value.toString();
                    controller.update();
                  });
                },
              );
            })));
  }

}
