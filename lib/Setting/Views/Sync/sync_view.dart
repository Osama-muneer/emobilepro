import '../../../Widgets/config.dart';
<<<<<<< HEAD
=======
import '../../../Services/service.dart';
>>>>>>> a6ee55e48d6c506d8dbe2c5a15bbb5870744819e
import '../../../Widgets/theme_helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_background_service/flutter_background_service.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import '../../../Setting/controllers/login_controller.dart';
import '../../../Setting/controllers/sync_controller.dart';
import '../../../Widgets/colors.dart';
import '../../../database/sync_db.dart';

class SyncView extends StatefulWidget {
  @override
  State<SyncView> createState() => _SyncViewState();
}

class _SyncViewState extends State<SyncView> {
  final SyncController controller = Get.find();

  Future<bool> onWillPop() async {
    GET_SYN_ORDDelete();
    F_GUID_V='';
    LoginController().BIID_ALL_V=='1'?
    DELETE_BRA_INF():null;
    DeleteROWIDFAS_ACC_USR();
    DeleteROWIDAll();
    if ((controller.PercentValue == 100 || controller.PercentValue == 0) && controller.TypeSync==0) {
      STMID=='EORD'?Get.offNamed('/Home',arguments:controller.CHIKE_BACK_MAIN==0?0:3):Get.offAllNamed('/Home');
      return true;
   }
    else if(controller.CheckDataBaseTmp==-1 && controller.SyncOneTable==true && controller.CheckSync == true){
      Fluttertoast.showToast(
          msg: "StringVerifiedSaved".tr,
          textColor: Colors.white,
          backgroundColor: Colors.red);
      return false;
    }
    final shouldPop = await Get.defaultDialog(
      title: 'StringMestitle'.tr,
      middleText: 'StringChikBack'.tr,
      backgroundColor: Colors.white,
      radius: 40,
      textCancel: 'StringNo'.tr,
      cancelTextColor: Colors.red,
      textConfirm: 'StringYes'.tr,
      confirmTextColor: Colors.white,
      onConfirm: () async {
      controller.round=false;
      controller.update();
      Navigator.of(context).pop(false);
      if(LoginController().CHIKE_ALL_MAIN==0 ) {
        LoginController().SET_B_P('RemmberMy',false);
         Navigator.of(context).pop(false);
         SystemNavigator.pop();
      }
      else{
         STMID=='EORD'?Get.offNamed('/Home',arguments:controller.CHIKE_BACK_MAIN==0?0:3):Get.offAllNamed('/Home');
      }
      },
      barrierDismissible: false,
    );
    return shouldPop ?? false;
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    final service = FlutterBackgroundService();
    return WillPopScope(
      onWillPop: onWillPop,
      child:  Directionality(
        textDirection: TextDirection.ltr,
        child: Scaffold(
          appBar: AppBar(
            automaticallyImplyLeading: TYPEPHONE=="IOS"? true: STMID=='EORD'? false : true,
            backgroundColor: AppColors.MainColor,
            iconTheme: IconThemeData(color: Colors.white),
            title: ThemeHelper().buildText(context,'StringSync', Colors.white,'L'),
            centerTitle: true,
            actions: <Widget>[
              ( LoginController().CHIKE_ALL_MAIN!=0  ) ?
               IconButton(
                icon: Icon(
                  Icons.update,color: Colors.white
                ),
                onPressed: () {

                    if(controller.SyncOneTable==true){
                      ThemeHelper().ShowToastW( "'${'StringOutfromScreen'.tr} ");
                    }
                    else{
                      setState(() async {
                      if( controller.checkclick==false || controller.CheckSync==false){
                        controller.TypeSync=1;
                        controller.TypeSyncAll=0;
                        controller.CheckClickAll=true;
                        controller.checkclick=true;
                        controller.loadingone.value=true;
                        controller.CheckSync(true);
                        controller.round=true;
                        controller.ClickAllOrLastTime=false;
                        LoginController().SET_N_P('Timer_Strat',1);
                        print(controller.round);
                        print('round');
                        final isRunning = await service.isRunning();
                        if (isRunning) {
                          try {
                            service.invoke("stopService");
                          } catch (e) {
                            debugPrint('Error stopping service: $e');
                          }
                        }
                        print('round');
                        controller.Socket_IP();
                      }
                      });
                    }
                },
              ):Container(),
               IconButton(
                icon: Icon(Icons.settings_input_antenna,color: Colors.white),
                onPressed: () async{
                    if(controller.SyncOneTable==true){
                      ThemeHelper().ShowToastW( "'${'StringOutfromScreen'.tr} ");
                    }
                    else{
                      if( controller.checkclick==false || controller.CheckSync==false){
                          controller.TypeSync=1;
                          controller.TypeSyncAll=1;
                          controller.CheckClickAll=true;
                          controller.checkclick=true;
                          controller.ClickAllOrLastTime=true;
                          controller.loadingone.value=true;
                          controller.CheckSync(true);
                          final isRunning = await service.isRunning();
                          if (isRunning) {
                            try {
                               service.invoke("stopService");
                            } catch (e) {
                              debugPrint('Error stopping service: $e');
                            }
                          }

                          //service.invoke("stopService");
                          LoginController().SET_N_P('Timer_Strat',1);
                          controller.Socket_IP();
                      }
                    }

                },
              ),
            ],
          ),
          body: GetBuilder<SyncController>(
              init: SyncController(),
              builder: ((value) => Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(padding: EdgeInsets.only(top: 0.02 * height),
                                  child: Column(
                                    children: [
                                      Stack(
                                        alignment: AlignmentDirectional.center,
                                        children: [
                                          SizedBox(
                                            width: 0.3 * width,
                                            height:  0.15 * height,
                                            child: CircularProgressIndicator(
                                              backgroundColor: Colors.grey,
                                              color: Colors.green,
                                              strokeWidth: 6,
                                              value: controller.cireclValue,
                                            ),
                                          ),
                                          Center(child: buildMainProgress(context))
                                        ],
                                      ),
                                      SizedBox(height:  0.01 * height),
                                      Obx(() {
                                        if (controller.loading.value == true) {
                                          return const Center(
                                            child: CircularProgressIndicator(),
                                          );
                                        }
                                        return controller.PercentValue == 100
                                            ? Text('StringSuccessfullySync'.tr, style:
                                            ThemeHelper().buildTextStyle(context, Colors.green,'L'))
                                            : controller.TypeSync == 0
                                                ?  Text('${controller.LastSyncDate} ${'StringlastSync'.tr} ')
                                                : controller.CheckSync == false
                                                    ? ThemeHelper().buildText(context,'StringStopSync', Colors.red,'L')
                                                    : ThemeHelper().buildText(context,'StringWeAreSync', Colors.black,'L');
                                      })
                                    ],
                                  ),
                                ),
                        ],
                      ),
                      Expanded(
                          child:
                              SingleChildScrollView(child: buildSyncListView())),
                    ],
                  ))),
        ),
      ),
    );
  }

  buildSyncListView() {
    return
      GetBuilder<SyncController>(
          init: SyncController(),
          builder: ((value) => Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              //متغيرات عامه
              BuildCard(context,controller.SysVarvalue,controller.SysVarProgress,controller.TotalSYS_VAR,controller.SysVarPercent,
                  'StringSys_Var',controller.LastSYS_VAR.value,1,'SYS_VAR'),
              //بيانات اخرى
              Card(
                child: Container(
                  color: Colors.white,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          BuildPadding(context,controller.SYN_DATvalue,buildProgress(context,controller.SYN_DATProgress, controller.TotalSYN_DAT,controller.SYN_DATPercent)),
                          PaddingWidget(context,'StringOtherData',controller.SYN_DATPercent,controller.SYN_DATProgress,controller.TotalSYN_DAT,controller.LastSYN_DAT)
                        ],
                      ),
                      // controller.TypeSync==2  &&  controller.loadingone.value==true ?
                      IconButton(   icon: const Icon(Icons.download_rounded), onPressed: ()  {})
                    ],
                  ),
                ),
              ),
              //بيانات المنشاه
              BuildCard(context,controller.SysWvalue,controller.SysWProgress,controller.TotalSYS_OWN,
                  controller.SysWPercent,'StrinSys_Own',controller.LastSys_Won,3,'SYS_OWN'),
              //بيانات الفروع
              BuildCard(context,controller.Bravalue,controller.BraProgress,controller.TotalBRA_INF,controller.BraPercent,
                  'StrinBra_Inf',controller.LastBra_Inf,4,'BRA_INF'),
              //المستخدمين
              BuildCard(context,controller.SysUvalue,controller.SysUProgress,controller.TotalSYS_USR,controller.SysUPercent,
                  'StrinSys_Usr',controller.LastSys_Usr,5,'SYS_USR'),
              //صلاحيات المستخدمين
              BuildCard(context,controller.UsrPvalue,controller.UsrPProgress,controller.TotalUSR_PRI,controller.UsrPPercent,
                  'StrinUsr_Pri',controller.LastUsr_Pri,6,'USR_PRI'),
              //صلاحيات المستخدمين على الفروع
              BuildCard(context,controller.SysUBvalue,controller.SysUBProgress,controller.TotalSYS_USR_B,controller.SysUBPercent,
                  'StrinSys_Usr_B',controller.LastSys_Usr_B,7,'SYS_USR_B'),
              //بيانات المخازن
              BuildCard(context,controller.Stovalue,controller.StoProgress,controller.TotalSTO_INF,controller.StoPercent,
                  'StringSto_Inf',controller.LastSto_Inf,8,'STO_INF'),
              //صلاحيات المخازن
              BuildCard(context,controller.StoUvalue,controller.StoUProgress,controller.TotalSTO_USR,controller.StoUPercent,
                  'StrinSto_Usr',controller.LastSto_Usr,9,'STO_USR'),
              //بيانات المجموعات
              BuildCard(context,controller.MatGvalue,controller.MatGProgress,controller.TotalMAT_GRO,controller.MatGPercent,
                  'StrinMat_Gro',controller.LastMat_Gro,10,'MAT_GRO'),
              //صلاحيات المجموعات
              BuildCard(context,controller.GroUvalue,controller.GroUProgress,controller.TotalGRO_USR,controller.GroUPercent,
                  'StrinGro_Usr',controller.LastGro_Usr,11,'GRO_USR'),
              //بيانات الوحدات
              BuildCard(context,controller.MatUvalue,controller.MatUProgress,controller.TotalMAT_UNI,controller.MatUPercent,
                  'StrinMat_Uni',controller.LastMat_Uni,12,'MAT_UNI'),
              //بيانات الاصناف
              BuildCard(context,controller.MatIvalue,controller.MatIProgress,controller.TotalMAT_INF,controller.MatIPercent,
                  'StrinMat_Inf',controller.LastMat_Inf,13,'MAT_INF'),
              // وحدات الاصناف
              BuildCard(context,controller.MatUCvalue,controller.MatUCProgress,controller.TotalMAT_UNI_C,controller.MatUCPercent,
                  'StrinMat_Uni_C',controller.LastMat_Uni_C,14,'MAT_UNI_C'),
              //الباركود
              BuildCard(context,controller.MatUBvalue,controller.MatUBProgress,controller.TotalMAT_UNI_B,controller.MatUBPercent,
                  'StrinMat_Uni_B',controller.LastMat_Uni_B,15,'MAT_UNI_B'),
              //تسعيره الاصناف
              BuildCard(context,controller.MatPvalue,controller.MatPProgress,controller.TotalMAT_PRI,controller.MatPPercent,
                  'StrinMat_Pri',controller.LastMat_Pri,16,'MAT_PRI'),
              //بيانات اضافيه للاصناف -2
              BuildCard(context,controller.MatIAvalue,controller.MatIAProgress,controller.TotalMAT_INF_A,controller.MatIAPercent,
                  'StrinMat_Inf_A',controller.LastMat_Inf_A,17,'MAT_INF_A'),
              // // الاصناف التابعة/المرتبطة.
              BuildCard(context,controller.MATFOLvalue,controller.MATFOLProgress,controller.TotalMAT_FOL,controller.MATFOLPercent,
                  'StringMAT_FOL',controller.LastMAT_FOL,18,'MAT_FOL'),
              // مواصفات/ملاحظات سريعة للاصناف
              BuildCard(context,controller.MATDESMvalue,controller.MATDESMProgress,controller.TotalMAT_DES_M,controller.MATDESMPercent,
                  'StringMAT_DES_M',controller.LastMAT_DES_M,19,'MAT_DES_M'),
              // مواصفات/ملاحظات سريعة للاصناف-فرعي
              BuildCard(context,controller.MATDESDvalue,controller.MATDESDProgress,controller.TotalMAT_DES_D,controller.MATDESDPercent,
                  'StringMAT_DES_D',controller.LastMAT_DES_D,20,'MAT_DES_D'),
              //الكميات المخزنية
              BuildCard(context,controller.StoNvalue,controller.StoNProgress,controller.TotalSTO_NUM,controller.StoNPercent,
                  'StrinSto_Num',controller.LastSto_Num,21,'STO_NUM'),
              //العملات
              BuildCard(context,controller.SysCurvalue,controller.SysCurProgress,controller.TotalSYS_CUR,controller.SysCurPercent,
                  'StringCurrency',controller.LastSYS_CUR,22,'SYS_CUR'),
              //أنواع الدفع
              BuildCard(context,controller.PayKinvalue,controller.PayKinProgress,controller.TotalPAY_KIN,controller.PayKinPercent,
                  'StringPaymenttypes',controller.LastPAY_KIN,25,'PAY_KIN'),
              //اعدادات الصناديق
              BuildCard(context,controller.AccCasvalue,controller.AccCasProgress,controller.TotalACC_CAS,controller.AccCasPercent,
                  'StringACCCAS',controller.LastACC_CAS,26,'ACC_CAS'),
              //بطائق الائتمان
              BuildCard(context,controller.BilCrecvalue,controller.BilCrecProgress,controller.TotalBIL_CRE_C,controller.BilCrecPercent,
                  'StringBilCrec',controller.LastBIL_CRE_C,28,'BIL_CRE_C'),
              //البنوك
              BuildCard(context,controller.AccBanvalue,controller.AccBanProgress,controller.TotalACC_BAN,controller.AccBanPercent,
                  'StringBanksSettings',controller.LastACC_BAN,29,'ACC_BAN'),
              // انواع بيانات العملاء
              BuildCard(context,controller.BilCusTvalue,controller.BilCusTProgress,controller.TotalBIL_CUS_T,controller.BilCusTPercent,
                  'StringCustomerstypes',controller.LastBIL_CUS_T,30,'BIL_CUS_T'),
              //بيانات العملاء
              BuildCard(context,controller.BilCusvalue,controller.BilCusProgress,controller.TotalBIL_CUS,controller.BilCusPercent,
                  'StringCustomer',controller.LastBIL_CUS,31,'BIL_CUS'),
              //بيانات العملاء بدون حسابات
              BuildCard(context,controller.BIFCDvalue,controller.BIFCDProgress,controller.TotalBIF_CUS_D,controller.BIFCDPercent,
                  'StringCusWithOutAcc',controller.LastBIF_CUS_D,32,'BIF_CUS_D'),
              //بيانات المندوبين
              BuildCard(context,controller.BilDisvalue,controller.BilDisProgress,controller.TotalBIL_DIS,controller.BilDisPercent,
                  'StringBILDIS',controller.LastBIL_DIS,33,'BIL_DIS'),
              //الموردين
              BuildCard(context,controller.BILIMPvalue,controller.BILIMPProgress,controller.TotalBIL_IMP,controller.BILIMPPercent,
                  'StringSuppliersSettings',controller.LastBIL_IMP,34,'BIL_IMP'),
              //الدول
              BuildCard(context,controller.CouWrdvalue,controller.CouWrdProgress,controller.TotalCOU_WRD,controller.CouWrdPercent,
                  'StringCountries',controller.LastCOU_WRD,35,'COU_WRD'),
              //والمدن
              BuildCard(context,controller.CouTowvalue,controller.CouTowProgress,controller.TotalCOU_TOW,controller.CouTowPercent,
                  'StringCitie',controller.LastCOU_TOW,36,'COU_TOW'),
              //المناطق
              BuildCard(context,controller.BilArevalue,controller.BilAreProgress,controller.TotalBIL_ARE,controller.BilArePercent,
                  'StringRegions',controller.LastBil_Are,37,'BIL_ARE'),
              //الدليل المحاسبي
              BuildCard(context,controller.AccAccvalue,controller.AccAccProgress,controller.TotalACC_ACC,controller.AccAccPercent,
                  'StrinAcc_Acc',controller.LastACC_ACC,38,'ACC_ACC'),
              //المستخدمين والحسابات.....
              BuildCard(context,controller.AccUsrvalue,controller.AccUsrProgress,controller.TotalACC_USR,controller.AccUsrPercent,
                  'StringACCUSR',controller.LastACC_USR,39,'ACC_USR'),
              //فترات العمل
              BuildCard(context,controller.ShiUsrvalue,controller.ShiUsrProgress,controller.TotalSHI_USR,controller.ShiUsrPercent,
                  'Stringworking_periods',controller.LastSHI_USR,40,'SHI_USR'),
              //نقاط البيع
              BuildCard(context,controller.BilPoivalue,controller.BilPoiProgress,controller.TotalBIL_POI,controller.BilPoiPercent,
                  'StringSale_Points',controller.LastBIL_POI_U,42,'BIL_POI'),
              //ربط نقاط البيع بالمستخدمين
              BuildCard(context,controller.BilPoiUvalue,controller.BilPoiUProgress,controller.TotalBIL_POI_U,controller.BilPoiUPercent,
                  'StringConnectingPOSUsers',controller.LastBIL_POI_U,43,'BIL_POI_U'),
              //نسب التخفيض للموظفين
              BuildCard(context,controller.BilUsrdvalue,controller.BilUsrdProgress,controller.TotalBIL_USR_D,controller.BilUsrdPercent,
                  'StringBilUsrd',controller.LastBIL_USR_D,44,'BIL_USR_D'),
              //مراكز التكلفه
              BuildCard(context,controller.CosUsrvalue,controller.CosUsrProgress,controller.TotalCOS_USR,controller.CosUsrPercent,
                  'StringCostCenters',controller.LastCOS_USR,45,'COS_USR'),
              //تذييل المستندات
              BuildCard(context,controller.SysDvalue,controller.SysDProgress,controller.TotalSYS_DOC_D,controller.SysDPercent,
                  'StrinSys_Doc',controller.LastSys_Doc,47,'SYS_DOC_D'),
              //الشاشات
              BuildCard(context,controller.SYSSCRvalue,controller.SYSSCRProgress,controller.TotalSYS_SCR,controller.SYSSCRPercent,
                  'StringPriviages',controller.LastSYS_SCR,48,'SYS_SCR'),
              //انواع حركات الفواتير
              BuildCard(context,controller.BILMOVKvalue,controller.BILMOVKProgress,controller.TotalBIL_MOV_K,controller.BILMOVKPercent,
                  'StringInvTraType',controller.LastBIL_MOV_K,50,'BIL_MOV_K'),
              //اعداد انواع القيود
              BuildCard(context,controller.ACCMOVKvalue,controller.ACCMOVKProgress,controller.TotalACC_MOV_K,controller.ACCMOVKPercent,
                  'StringEntryTypesSettings',controller.LastACC_MOV_K,51,'ACC_MOV_K'),
              //التصنيف الضريبي
              BuildCard(context,controller.TAXMOVTvalue,controller.TAXMOVTProgress,controller.TotalTAX_MOV_T,controller.TAXMOVTPercent,
                  'StringACC_TAX_C',controller.LastTAX_MOV_T,52,'TAX_MOV_T'),
              //انواع الضرائب
              BuildCard(context,controller.TAXTYPvalue,controller.TAXTYPProgress,controller.TotalTAX_TYP,controller.TAXTYPPercent,
                  'StringTAX_TYP',controller.LastTAX_TYP,55,'TAX_TYP'),
              ////أنواع الضرائب والفروع
              BuildCard(context,controller.TAXTYPBRAvalue,controller.TAXTYPBRAProgress,controller.TotalTAX_TYP_BRA,controller.TAXTYPBRAPercent,
                  'StringTAX_TYP_BRA',controller.LastTAX_TYP_BRA,57,'TAX_TYP_BRA'),
              // //اعداد الفترات الضريبيه
              BuildCard(context,controller.TAXPERDvalue,controller.TAXPERDProgress,controller.TotalTAX_PER_D,controller.TAXPERDPercent,
                  'StringTAX_PER_M',controller.LastTAX_PER_D,58,'TAX_PER_M'),
              //ربط الفترات الضريبيه بالفروع
              BuildCard(context,controller.TAXPERBRAvalue,controller.TAXPERBRAProgress,controller.TotalTAX_PER_BRA,controller.TAXPERBRAPercent,
                  'StringTAX_PER_BRA',controller.LastTAX_PER_BRA,60,'TAX_PER_BRA'),
              //المواقع الضريبيه
              BuildCard(context,controller.TAXLOCvalue,controller.TAXLOCProgress,controller.TotalTAX_LOC,controller.TAXLOCPercent,
                  'StringTAX_LOC',controller.LastTAX_LOC,61,'TAX_LOC'),
              //الترميزات الضريبيه
              BuildCard(context,controller.TAXCODvalue,controller.TAXCODProgress,controller.TotalTAX_COD,controller.TAXCODPercent,
                  'StringTAX_COD',controller.LastTAX_COD,63,'TAX_COD'),
              //ربط الضريبيه بالانظمه
              BuildCard(context,controller.TAXSYSvalue,controller.TAXSYSProgress,controller.TotalTAX_SYS,controller.TAXSYSPercent,
                  'StringTAX_SYS',controller.LastTAX_SYS,66,'TAX_SYS'),
              //ربط الضريبه والفروع
              BuildCard(context,controller.TAXSYSBRAvalue,controller.TAXSYSBRAProgress,controller.TotalTAX_SYS_BRA,controller.TAXSYSBRAPercent,
                  'StringTAX_SYS_BRA',controller.LastTAX_SYS_BRA,68,'TAX_SYS_BRA'),
              //متغيرات الضرائب
              BuildCard(context,controller.TAXVARvalue,controller.TAXVARProgress,controller.TotalTAX_VAR,controller.TAXVARPercent,
                  'StringTAX_VAR',controller.LastTAX_VAR,69,'TAX_VAR'),

              //التصنيفات الضريبيه
              BuildCard(context,controller.TAXLINvalue,controller.TAXLINProgress,controller.TotalTAX_LIN,controller.TAXLINPercent,
                  'StringTAX_LIN',controller.LastTAX_LIN,71,'TAX_LIN'),
              //بيانات المعرفات
              BuildCard(context,controller.IDELINvalue,controller.IDELINProgress,controller.TotalIDE_LIN,controller.IDELINPercent,
                  'StringIDE_LIN',controller.LastIDE_LIN,73,'IDE_LIN'),
              //مؤشرات/انواع ضريبيه للحركات
              BuildCard(context,controller.TAXMOVSINvalue,controller.TAXMOVSINProgress,controller.TotalTAX_MOV_SIN,controller.TAXMOVSINPercent,
                  'StringTAX_MOV_SIN',controller.LastTAX_MOV_SIN,74,'TAX_MOV_SIN'),
              //
              BuildCard(context,controller.TAXTBLLNKvalue,controller.TAXTBLLNKProgress,controller.TotalTAX_TBL_LNK,controller.TAXTBLLNKPercent,
                  'StringTAX_TBL_LNK',controller.LastTAX_SYS_BRA,75,'TAX_TBL_LNK'),
              //بيانات الربط مع الــAPI
              BuildCard(context,controller.FATAPIINFvalue,controller.FATAPIINFProgress,controller.TotalFAT_API_INF,controller.FATAPIINFPercent,
                  'StringFAT_API_INF',controller.LastFAT_API_INF,76,'FAT_API_INF'),
              //الوحدات/الاجهزة التفنية
              BuildCard(context,controller.FATCSIDINFvalue,controller.FATCSIDINFProgress,controller.TotalFAT_CSID_INF,controller.FATCSIDINFPercent,
                  'StringFAT_CSID_INF',controller.LastFAT_CSID_INF,77,'FAT_CSID_INF'),
              //مسلسل الترقيم للوحدات/الاجهزه التقنية
              BuildCard(context,controller.FATCSIDSEQvalue,controller.FATCSIDSEQProgress,controller.TotalFAT_CSID_SEQ,controller.FATCSIDSEQPercent,
                  'StringFAT_CSID_SEQ',controller.LastFAT_CSID_SEQ,79,'FAT_CSID_SEQ'),
              //حالة الوحدات/الاجهزه التقنية
              BuildCard(context,controller.FATCSIDSTvalue,controller.FATCSIDSTProgress,controller.TotalFAT_CSID_ST,controller.FATCSIDSTPercent,
                  'StringFAT_CSID_ST',controller.LastFAT_CSID_ST,80,'FAT_CSID_ST'),
              //FAT_QUE
              BuildCard(context,controller.FATQUEvalue,controller.FATQUEProgress,controller.TotalFAT_QUE,controller.FATQUEPercent,
                  'StringFAT_QUE',controller.LastFAT_QUE,81,'FAT_QUE'),
              //انواع العروض والتخفيضات
              BuildCard(context,controller.MATDISTvalue,controller.MATDISTProgress,controller.TotalMAT_DIS_T,controller.MATDISTPercent,
                  'StringMAT_DIS_T',controller.LastMAT_DIS_T,82,'MAT_DIS_T'),
              //طبيعة العروض والتخفيضات
              BuildCard(context,controller.MATDISKvalue,controller.MATDISKProgress,controller.TotalMAT_DIS_K,controller.MATDISKPercent,
                  'StringMAT_DIS_K',controller.LastMAT_DIS_K,83,'MAT_DIS_K'),
              //العروض والتخقيضات -رئيسي
              BuildCard(context,controller.MATDISMvalue,controller.MATDISMProgress,controller.TotalMAT_DIS_M,controller.MATDISMPercent,
                  'StringMAT_DIS_M',controller.LastMAT_DIS_M,84,'MAT_DIS_M'),
              //العروض والتخقيضات -فرعي 1
              BuildCard(context,controller.MATDISDvalue,controller.MATDISDProgress,controller.TotalMAT_DIS_D,controller.MATDISDPercent,
                  'StringMAT_DIS_D',controller.LastMAT_DIS_D,85,'MAT_DIS_D'),
              //العروض والتخقيضات -فرعي 2
              BuildCard(context,controller.MATDISFvalue,controller.MATDISFProgress,controller.TotalMAT_DIS_F,controller.MATDISFPercent,
                  'StringMAT_DIS_F',controller.LastMAT_DIS_F,86,'MAT_DIS_F'),
              //ربط العروض مع المجموعات الرئيسيه
              BuildCard(context,controller.MATDISLvalue,controller.MATDISLProgress,controller.TotalMAT_DIS_L,controller.MATDISLPercent,
                  'StringMAT_DIS_L',controller.LastMAT_DIS_L,87,'MAT_DIS_L'),
              //حالة العروض والتخفيضات
              BuildCard(context,controller.MATDISSvalue,controller.MATDISSProgress,controller.TotalMAT_DIS_S,controller.MATDISSPercent,
                  'StringMAT_DIS_S',controller.LastMAT_DIS_S,88,'MAT_DIS_S'),
              ////المجموعات الرئيسية للعروض.
              BuildCard(context,controller.MATMAIMvalue,controller.MATMAIMProgress,controller.TotalMAT_MAI_M,controller.MATMAIMPercent,
                  'StringMAT_MAI_M',controller.LastMAT_MAI_M,89,'MAT_MAI_M'),
              //الاقسام
              BuildCard(context,controller.RESSECvalue,controller.RESSECProgress,controller.TotalRES_SEC,controller.RESSECPercent,
                  'StringRES_SEC',controller.LastRES_SEC,90,'RES_SEC'),
              //الطاولات
              BuildCard(context,controller.RESTABvalue,controller.RESTABProgress,controller.TotalRES_TAB,controller.RESTABPercent,
                  'StringRES_TAB',controller.LastRES_TAB,91,'RES_TAB'),
              //موظفي الخدمه
              BuildCard(context,controller.RESEMPvalue,controller.RESEMPProgress,controller.TotalRES_EMP,controller.RESEMPPercent,
                  'StringRES_EMP',controller.LastRES_EMP,92,'RES_EMP'),
              //أنواع الوقود
              BuildCard(context,controller.CouTypvalue,controller.CouTypMProgress,controller.TotalCOU_TYP_M,controller.CouTypMPercent,
                  'StringFuel_type',controller.LastCOU_TYP_M,93,'COU_TYP_M'),
              //ترميز العدادات
              BuildCard(context,controller.CouInfMvalue,controller.CouInfMProgress,controller.TotalCOU_INF_M,controller.CouInfMPercent,
                  'StringCounterdata',controller.LastCOU_INF_M,94,'COU_INF_M'),
              //ربط العدادات بالنقاط
              BuildCard(context,controller.CouPoiLvalue,controller.CouPoiLProgress,controller.TotalCOU_POI_L,controller.CouPoiLPercent,
                  'StringcounterstoPOS',controller.LastCOU_POI_L,95,'COU_POI_L'),
              //صلاحيه المستخدمين بالعدادات
              BuildCard(context,controller.CouUsrvalue,controller.CouUsrProgress,controller.TotalCOU_USR,controller.CouUsrPercent,
                  'StringCIMID_privilage',controller.LastCOU_USR,96,'COU_USR'),
              //القراءات
              BuildCard(context,controller.CouRedvalue,controller.CouRedProgress,controller.TotalCOU_RED,controller.CouRedPercent,
                  'Stringreadings',controller.LastCOU_RED,97,'COU_RED'),
              //مجموعات الفواتير
              BuildCard(context,controller.BIFGROvalue,controller.BIFGROProgress,controller.TotalBIF_GRO,controller.BIFGROPercent,
                  'StringBIF_GRO',controller.LastBIF_GRO,98,'BIF_GRO'),
              //مجموعات الفواتير2
              BuildCard(context,controller.BIFGRO2value,controller.BIFGRO2Progress,controller.TotalBIF_GRO2,controller.BIFGRO2Percent,
                  'StringBIF_GRO2',controller.LastBIF_GRO2,99,'BIF_GRO2'),
              //اعدادات الربط/التزامن-السحابي
              BuildCard(context,controller.ECOVARvalue,controller.ECOVARProgress,controller.TotalECO_VAR,controller.ECOVARPercent,
                  'StringSYN_SET',controller.LastECO_VAR,100,'ECO_VAR'),
              //حسابات وارقام التواصل
              BuildCard(context,controller.ECOACCvalue,controller.ECOACCProgress,controller.TotalECO_ACC,controller.ECOACCPercent,
                  'StringECO_ACC',controller.LastECO_ACC,104,'ECO_ACC'),
              //انواع الرسائل المرتبطه بالارقام
              BuildCard(context,controller.ECOMSGACCvalue,controller.ECOMSGACCProgress,controller.TotalECO_MSG_ACC,controller.ECOMSGACCPercent,
                  'StringECO_MSG_ACC',controller.LastECO_MSG_ACC,105,'ECO_MSG_ACC'),
              // ارصده الحسابات -رئيسي
              BuildCard(context,controller.BALACCMvalue,controller.BALACCMProgress,controller.TotalBAL_ACC_M,controller.BALACCMPercent,
                  'StringBAL_ACC_M',controller.LastBAL_ACC_M,106,'BAL_ACC_M'),
              // ارصده الحسابات-اجمالي
              Card(
                child: Container(
                  color: Colors.grey[50],
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          BuildPadding(context,controller.BALACCCvalue,buildProgress(context,controller.BALACCCProgress, controller.TotalBAL_ACC_C,controller.BALACCCPercent)),
                          PaddingWidget(context,'StringBAL_ACC_C',controller.BALACCCPercent,controller.BALACCCProgress,controller.TotalBAL_ACC_C,controller.LastBAL_ACC_C)
                        ],
                      ),
                      (controller.TypeSync==108 || controller.TypeSync==107 || controller.TypeSync==106)  &&  controller.loadingone.value==true ?
                      IconButton(   icon: const Icon(Icons.download_rounded), onPressed: ()  {})
                          :IconButton(
                          icon: const Icon(Icons.download_rounded),
                          onPressed: ()  {
                            ThemeHelper().ShowToastW( "'${'StringBAL_ACC_M_CHECK'.tr} ");
                          }),
                    ],
                  ),
                ),
              ),
              // // ارصده الحسابات -فرعي
              Card(
                child: Container(
                  color: Colors.grey[50],
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          BuildPadding(context,controller.BALACCDvalue,buildProgress(context,controller.BALACCDProgress, controller.TotalBAL_ACC_D,controller.BALACCDPercent)),
                          PaddingWidget(context,'StringBAL_ACC_D',controller.BALACCDPercent,controller.BALACCDProgress,controller.TotalBAL_ACC_D,controller.LastBAL_ACC_D)
                        ],
                      ),
                      (controller.TypeSync==108 || controller.TypeSync==107 || controller.TypeSync==106)  &&  controller.loadingone.value==true ?
                      IconButton(   icon: const Icon(Icons.download_rounded), onPressed: ()  {})
                          :IconButton(
                          icon: const Icon(Icons.download_rounded),
                          onPressed: ()  {
                            ThemeHelper().ShowToastW( "'${'StringBAL_ACC_M_CHECK'.tr} ");
                          }),
                    ],
                  ),
                ),
              ),
            ],
          )));

  }

  Card BuildCard(BuildContext context,double value,int Progress,total,Percent,String NameCard,String Last,int Num,String TableName )
  {
    return Card(
        child: Container(
          color: Colors.white,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
                  Row(
                children: [
                  BuildPadding(context,value, buildProgress(context,Progress,total,Percent)),
                  PaddingWidget(context,NameCard,Percent,Progress,total,Last)
                ],
              ),

                  controller.TypeSync==Num  &&  controller.loadingone.value==true ?
                  IconButton(   icon: const Icon(Icons.download_rounded), onPressed: ()  {

                  })
                : BuildIconButton(Num,Progress,total,TableName),
            ],
          ),
        ),
      );
  }

  IconButton BuildIconButton(int Num,int Progress,int total,String TableName) {
    return IconButton(
                icon: const Icon(Icons.download_rounded),
                onPressed: ()  {
                  if(Progress==total){
                    ThemeHelper().ShowToastW( "'${'StringtableSync'.tr} ");
                  }
                  else {
                    if( (controller.TypeSync==0 || controller.TypeSync==Num) && controller.CheckClickAll==false){
                      controller.TypeCheckSync=Num;
                      controller.CheckDataBaseTmp=-1;
                      controller.TypeSync=Num;
                      controller.TypeSyncAll=1;
                      controller.loadingone.value = true;
                      controller.TypeGet=TableName;
                      controller.SyncOneTable=true;
                      controller.ClickAllOrLastTime=true;
                      controller.update();
                      controller.Socket_IP();
                    }
                  }
                });
  }

  Padding PaddingWidget(BuildContext context,StringText,Percent,Progress,total,LastS) {
    double height = MediaQuery.of(context).size.height;
    return Padding(
      padding: EdgeInsets.only(left:  0.02 * height),
      child: Column(
        children: [
          Text(
            '$StringText'.tr,
            style: ThemeHelper().buildTextStyle(context, Colors.black,'$StringText'.tr.toString().length>=35?'S':'M')
          ),
          Percent != 0
              ? Progress != total
              ? Text(" ${'Stringdownload'.tr} ${Progress.round()}  ${'StringfromS'.tr} ${total}  ",
            style: ThemeHelper().buildTextStyle(context, Colors.black,'S'),
          )
              : Text("${total} ${'StringDoneSync'.tr}  ",
            style: ThemeHelper().buildTextStyle(context, Colors.black,'S'),
          )
              :
          Text((controller.CHIKE_ALL==0  )?'':
          LastS!='null'?"${LastS} ${'StringlastSync'.tr}  ":'', style: ThemeHelper().buildTextStyle(context, Colors.black,'S'),)
          // TextLast(LastS),
        ],
      ),
    );
  }

  Padding BuildPadding(BuildContext context,double value,Widget widget) {
    double height = MediaQuery.of(context).size.height;
    return Padding(
      padding: EdgeInsets.only(left:  0.02 * height),
      child: Stack(
        alignment: AlignmentDirectional.center,
        children: [
          CircularProgressIndicator(
            backgroundColor: Colors.grey,
            color: Colors.green,
            strokeWidth: 4,
            value:value,
          ),

          Center(child: widget)
        ],
      ),
    );
  }

  Widget buildProgress(BuildContext context,Progress,total,Percent) {
    double height = MediaQuery.of(context).size.height;
    if (Progress == total) {
      return Icon(
        Icons.done,
        color: Colors.green,
        size:  0.03 * height,
      );
    } else {
      return Text(
        '${Percent > 100 ? Percent = 100 : Percent}%',
        style: ThemeHelper().buildTextStyle(context, Colors.black,'S'),
      );
    }
  }

  Widget buildMainProgress(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    if (controller.PercentValue == 100) {
      return Icon(Icons.done, color: Colors.green, size:  0.06 * height,);
    } else {
      return Text(
        '${controller.PercentValue > 100 ? controller.PercentValue = 100 : controller.PercentValue}%',
        style: ThemeHelper().buildTextStyle(context, Colors.black,'L'),
      );
    }
  }

}
