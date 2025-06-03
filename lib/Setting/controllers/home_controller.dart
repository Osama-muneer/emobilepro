import 'dart:async';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart';
import 'package:uuid/uuid.dart';
import '../../Operation/models/acc_mov_m.dart';
import '../../Operation/models/bil_mov_m.dart';
import '../../Services/service.dart';
import '../controllers/setting_controller.dart';
import '../../Widgets/theme_helper.dart';
import '../models/acc_mov_k.dart';
import '../models/bil_mov_k.dart';
import '../models/bk_inf.dart';
import '../models/bra_inf.dart';
import '../models/fas_acc_usr.dart';
import '../models/syn_log.dart';
import '../../database/report_db.dart';
import 'package:flutter/material.dart';
import 'package:flutter_background_service/flutter_background_service.dart';
import 'package:get/get.dart';
import '../controllers/login_controller.dart';
import '../models/job_typ.dart';
import '../models/sys_scr.dart';
import '../models/sys_usr.dart';
import '../models/usr_pri.dart';
import '../../Widgets/config.dart';
import '../../database/setting_db.dart';
import '../../database/sync_db.dart';
import 'package:intl/intl.dart' as intl;


class HomeController extends GetxController {
  //TODO: Implement HomeController
  final formatter = intl.NumberFormat.decimalPattern();
  RxBool loading = false.obs;
  bool isChecked=false,isChecked2=false,isChecked3=false;
  var uuid = const Uuid();
  final String selectedDatesercher = DateFormat('yyyy-MM-dd').format(DateTime.now());
  DateTime dateTimeDays = DateTime.now();
  final now = DateTime.now();
  final formatter2 = DateFormat('yyyy-MM-dd');
  final count = 0.obs;
  var isloading = false.obs;
  var dbHelper,GUID,GUIDD;
  double SUM_PAY1_BO=0,SUM_PAY3_BO=0,SUM_PAY8_BO=0,SUM_PAY9_BO=0,SUM_PAY1_BF=0,SUM_PAY3_BF=0,SUM_PAY8_BF=0,SUM_PAY9_BF=0
  ,SUM_PAY1_BI=0,SUM_PAY3_BI=0,SUM_PAY8_BI=0,SUM_PAY9_BI=0,SUM_PAY1_BS=0,SUM_PAY3_BS=0,SUM_PAY8_BS=0,SUM_PAY9_BS=0,
      SUM_STATE_BO1=0,SUM_STATE_BF1=0,SUM_STATE_BI1=0,SUM_STATE_BS1=0,SUM_STATE_BO2=0,SUM_STATE_BF2=0,SUM_STATE_BI2=0
  ,SUM_STATE_BS2=0,SUM_STATE_BO4=0,SUM_STATE_BF4=0,SUM_STATE_BI4=0,SUM_STATE_BS4=0,SUM_B1=0,SUM_B3=0,SUM_B4=0
  ,SUM_B5=0,SUM_B7=0,SUM_B10=0,SUM_B11=0,SUM_B12=0,SUM_A1=0,SUM_A2=0;
  int? UPIN_BI=0,UPIN_BIO=1,UPIN_BO=1,UPIN_BO_R=1,UPIN_BF=1,UPIN_ACI=0,UPIN_ACO=0,UPIN_ACS=0,UPIN_ACJ=0,UPIN_CUS=0,
      BMKST_BI=1,BMKST_BIO=1,BMKST_BO=1,BMKST_BO_R=1,BMKST_BF=1,AMKST_ACI=1,AMKST_ACO=1,AMKST_ACJ,BMKST_BF_R=1,UPIN_BF_R=1,BMKST_BO_S=1,
      UPIN_BO_S=1,UPIN_QU=1,UPIN_CUS_ORD=1,FAUST=2,SSID=0,BMKST_QU=1,BMKST_CUS_ORD=1,COU_STATE_BO1=0,COU_STATE_BF1=0,
      COU_STATE_BI1=0,COU_STATE_BS1=0,COU_STATE_BO2=0,COU_STATE_BF2=0,
      COU_STATE_BI2=0,COU_STATE_BS2=0,COU_STATE_BO4=0,COU_STATE_BF4=0,
      COU_STATE_BI4=0,COU_STATE_BS4=0,ST_1003=1,ST_1004=1,ST_1010=1,ST_1008=1,ST_1016=1,ST_1018=1,ST_1023=1,ST_1025=1,
      SMKST_IN=1,SMKST_OU=1,SMKST_TR=1,SMKST_INV=1,UPIN_IN=1,UPIN_OU=1,UPIN_TR=1,UPIN_INV=1,
      UPIN_COS=1,UPIN_MAIN=1,
      count1=0,count4=0;
  String? name ='', password='',SelectDataJTID,SelectDataBINA='',SelectDataSYSD='',SelectDataSYED='',SelectDataSYNA='',
      SelectDataSUNA='',Y,E,F,SUNA_V=LoginController().SUNA,JTNA_V=LoginController().JTNA,BINA_V=LoginController().BINA,
      SelectDays_F,SelectDays_T,TYPE_T='1',TYPE_TOP_CUS='1',TYPE_TOP_ITM='1',SelectDataSCID='1';
  late final TabController tabController;
  late final TextEditingController JTNAController,BINAController,SUNAController,searchController;
  late List<Fas_Acc_Usr_Local> FAS_ACC_USR2 = [];
  late List<Fas_Acc_Usr_Local> FAS_ACC_USR = [];
  late List<Bil_Mov_M_Local> BIL_MOV_M = [];
  late List<Acc_Mov_M_Local> ACC_MOV_M = [];
  late List<Usr_Pri_Local> USR_PRI_INV;
  late List<Bra_Inf_Local> GET_BINA;
  late List<Job_Typ_Local> GET_JTNA;
  late List<Sys_Usr_Local> GET_SUNA_D;
  late List<Sys_Scr_Local> SYS_SCR;
  late List<Usr_Pri_Local> USR_PRI;
  late List<Acc_Mov_K_Local> Acc_Mov_K;
  late List<Bil_Mov_K_Local> Bil_Mov_K;
  late List<Bk_inf> backups = [];
  late List<Bk_inf> filteredBackups = [];





  late List<Syn_Log_Local> Syn_Log = [];

  //جلب عدد الحركات من ارشيف التزامن لحذف البيانات اذا كان عدد الحركات كبير
   GET_COUNT_SYN_LOG_P() {
    GET_COUNT_SYN_LOG().then((data) async {
      Syn_Log = data;
      if (Syn_Log.isNotEmpty) {
        if( Syn_Log.elementAt(0).COUNTROW!>2000){
          DELETESYN_LOG();
          await Future.delayed(const Duration(seconds: 2));{
            INSERT_SYN_LOG('SYN_LOG','تم حذف بيانات الجدول لوصلها الى عدد كبير','U');
          }
        }
      }
    });
  }

  int currentIndex =0,Type_chart=0;
  double? SUM_ST=0,SUM_ST1=0,SUM_ST2=0,SUM_ST3=0;
  int? COUNT_ST=0,COUNT_ST1=0,COUNT_ST2=0,COUNT_ST3=0;
  Future GET_BIL_MOV_M_GET_BIF_MOV_M_STATE_P(String GETBMMST) async {
    GET_BIF_MOV_M_STATE(GETBMMST).then((data) {
      if(data.isNotEmpty) {
        if(GETBMMST=='1'){
          COUNT_ST1 = data.elementAt(0).BMMNO;
          SUM_ST1 = data.elementAt(0).BMMMT;
        }
        else if(GETBMMST=='2'){
          COUNT_ST2 = data.elementAt(0).BMMNO;
          SUM_ST2 = data.elementAt(0).BMMMT;
        }
        else if(GETBMMST=='4'){
          COUNT_ST3 = data.elementAt(0).BMMNO;
          SUM_ST3 = data.elementAt(0).BMMMT;
        }
        else if(GETBMMST=='0'){
          COUNT_ST = data.elementAt(0).BMMNO;
          SUM_ST = data.elementAt(0).BMMMT;
        }
        update();
      }
    });
  }
  static const MaterialColor buttonTextColor = MaterialColor(
    0xFFEF5350,
    <int, Color>{
      50: Color(0xFFFFEBEE),
      100: Color(0xFFFFCDD2),
      200: Color(0xFFEF9A9A),
      300: Color(0xFFE57373),
      400: Color(0xFFEF5350),
      500: Color(0xFFF44336),
      600: Color(0xFFE53935),
      700: Color(0xFFD32F2F),
      800: Color(0xFFC62828),
      900: Color(0xFFB71C1C),
    },
  );
  Future<void> selectDateFromDays_F(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: dateTimeDays,
      firstDate: DateTime(2022, 5),
      lastDate: DateTime(2050),
      builder: (context, child) {
        return   Theme(
          data: ThemeData.light().copyWith(
              primaryColor: const Color(0xFF4A5BF6),
              colorScheme: ColorScheme.fromSwatch(primarySwatch: buttonTextColor).copyWith(secondary: const Color(0xFF4A5BF6))//selection color
          ),
          child: child!,
        );
      },);

    if (picked != null) {
        dateTimeDays = picked;
        SelectDays_F = DateFormat('yyyy-MM-dd').format(dateTimeDays).toString().split(" ")[0];
       // GET_SUM_PAY_BIL_MOV_P();
      update();
    }
  }

  Future<void> selectDateFromDays_T(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: dateTimeDays,
      firstDate: DateTime(2022, 5),
      lastDate: DateTime(2050),
      builder: (context, child) {
        return   Theme(
          data: ThemeData.light().copyWith(
              primaryColor: const Color(0xFF4A5BF6),
              colorScheme: ColorScheme.fromSwatch(primarySwatch: buttonTextColor).copyWith(secondary: const Color(0xFF4A5BF6))//selection color
          ),
          child: child!,
        );
      },);

    if (picked != null) {
        dateTimeDays = picked;
        SelectDays_T = DateFormat('yyyy-MM-dd').format(dateTimeDays).toString().split(" ")[0];
       // GET_SUM_PAY_BIL_MOV_P();
      update();
    }
  }

  @override
  void onInit() async {
    loading(false);
    Get.arguments==3?currentIndex=3:Get.arguments==1?currentIndex=1:currentIndex=0;
    BINAController = TextEditingController();
    JTNAController = TextEditingController();
    SUNAController = TextEditingController();
    searchController = TextEditingController();
   // await ES_WS_PKG.GET_P();
    await GET_SYS_SCR_FAS_P2();
    await GET_SYS_SCR_FAS_P();
    update();
    await GET_GEN_VAR_P();
    GET_SUNA();
    Get_JTNA_DATA();
    GET_BIL_MOV_M_GET_BIF_MOV_M_STATE_P('0');
    GET_BIL_MOV_M_GET_BIF_MOV_M_STATE_P('1');
    GET_BIL_MOV_M_GET_BIF_MOV_M_STATE_P('2');
    GET_BIL_MOV_M_GET_BIF_MOV_M_STATE_P('4');
    update();
    // LoginController().Androidversion();
    if(LoginController().experimentalcopy==1){
      ThemeHelper().saveData();
    }
    else{
      StteingController().SET_B_P('Save_Sync_Invo',true);
    }
    await GET_USR_PRI(901);
    await GET_USR_PRI(912);
    await GET_USR_PRI(601);
    await GET_USR_PRI(621);
    await GET_USR_PRI(2207);
    await GET_USR_PRI(2272);
    await GET_USR_PRI(102);
    await GET_USR_PRI(103);
    await GET_USR_PRI(202);
    await GET_USR_PRI(489);
    await GET_USR_PRI(91);
    await GET_USR_PRI(611);
    await GET_USR_PRI(111);
    await GET_USR_PRI(1501);
    await GET_USR_PRI(1444);
    await GET_USR_PRI(1421);
    await GET_USR_PRI(1401);
    await GET_ACC_MOV_K_P(1);
    await GET_ACC_MOV_K_P(2);
    await GET_ACC_MOV_K_P(15);
    await GET_BIL_MOV_K_P(1);
    await GET_BIL_MOV_K_P(2);
    await GET_BIL_MOV_K_P(3);
    await GET_BIL_MOV_K_P(4);
    await GET_BIL_MOV_K_P(5);
    await GET_BIL_MOV_K_P(11);
    await GET_BIL_MOV_K_P(12);
    await GET_BIL_MOV_K_P(7);
    await GET_BIL_MOV_K_P(10);
    await GET_STO_MOV_K_P(1);
    await GET_STO_MOV_K_P(3);
    await GET_STO_MOV_K_P(13);
    await GET_STO_MOV_K_P(17);
    STMID=='REP'?GET_SYS_REP_P(1003):false;
    STMID=='REP'?GET_SYS_REP_P(1004):false;
    STMID=='REP'?GET_SYS_REP_P(1008):false;
    STMID=='REP'?GET_SYS_REP_P(1010):false;
    GET_COUNT_SYN_LOG_P();
    GETMOB_VAR_P(7);
    CHICK_SERVICE();
    fetchBackups();
    startBackgroundServiceSafely();
    loading(true);
    update();
    super.onInit();
  }

  void startBackgroundServiceSafely() async {
    final service = FlutterBackgroundService();
    print('service.isRunning000');
    if (!(await service.isRunning())) {
      print('service.isRunning');
      await initializeService(); // هذا موجود في service.dart
    }
  }

  @override
  void dispose() {
    // TODO: implement dispose
    JTNAController.dispose();
    BINAController.dispose();
    SUNAController.dispose();
    tabController.dispose();
    searchController.dispose();
    super.dispose();
  }

  Future<void> fetchBackups() async {
    try {
        backups =await GET_BK_INF();
        filteredBackups =await GET_BK_INF();
         update();
    } catch (e) {
      print('Error in fetchBackups: $e');
      Get.snackbar('خطأ', 'فشل في تحميل النسخ الاحتياطية',
          backgroundColor: Colors.redAccent, colorText: Colors.white);
    }
  }

  void filterBackups(String query) {
    if (query.isEmpty) {
        filteredBackups = backups;
        update();
    } else {
        filteredBackups = backups.where((backup) {
          return backup.bity.contains(query) || backup.bida.contains(query);
        }).toList();
     update();
    }
  }


  Future GETMOB_VAR_P(int GETMVID) async {
    var MVVL=await GETMOB_VAR(GETMVID);
    if(MVVL.isNotEmpty){
        LoginController().SET_P('APPV',MVVL.elementAt(0).MVVL.toString());
    }
  }

  //صلاحيات
  Future GET_USR_PRI(int GETPRID) async {
    USR_PRI=await PRIVLAGE(LoginController().SUID,GETPRID);

      if (USR_PRI.isNotEmpty) {
        //فاتورة مشتربات
        if(GETPRID==901){
        UPIN_BI = 1;
        }

        //مردود مشتريات
        if(GETPRID==912){
          UPIN_BIO = 1;
        }
        //فاتورة مبيعات
        else if(GETPRID==601){
          UPIN_BO = 1;
        }
        //مردود فواتير المبيعات
        else if(GETPRID==611){
          UPIN_BO_R = 1;
        }
        // فواتير خدمات
        else if(GETPRID==621){
          UPIN_BO_S = 1;
        }
        // فاتورة مبيعات فورية
        else if(GETPRID==2207){
          UPIN_BF = 1;
        }
        // مردرد فاتورة مبيعات فورية
        else if(GETPRID==2272){
          UPIN_BF_R = 1;
        }
        // عروض الاسعار
        else if(GETPRID==641){
          UPIN_QU = 1;
        }
        // طلبات عميل
        else if(GETPRID==645){
          UPIN_CUS_ORD = 1;
        }
        //سندات القبض
        else if(GETPRID==102){
          UPIN_ACI = 1;
        }
        //سندات الصرف
        else if(GETPRID==103){
          UPIN_ACO = 1;
        }
        //قيد يومي
        else if(GETPRID==111){
          UPIN_ACJ = 1;
        }
        //كشف حساب
        else if(GETPRID==202){
          UPIN_ACS = 1;
        }
        //كشف حساب رئيسي
        else if(GETPRID==203){
          UPIN_MAIN = 1;
        }
        //كشف حساب مراكز تكلفه
        else if(GETPRID==489){
          UPIN_COS = 1;
        }
        //العملاء
        else if(GETPRID==91){
          UPIN_CUS = 1;
        }
        //التوريد المخزني
        else if(GETPRID==1421){
          UPIN_IN = 1;
        }
        //الصرف المخزني
        else if(GETPRID==1401){
          UPIN_OU = 1;
        }
        //تحويل مخزني
        else if(GETPRID==1444){
          UPIN_TR = 1;
        }
        //الجرد المخزني
        else if(GETPRID==1501){
          UPIN_INV = 1;
        }
        update();
      }
      else {
        if(LoginController().SUID=='1'){
          UPIN_BI=1;
          UPIN_BIO=1;
          UPIN_BO=1;
          UPIN_BO_R=1;
          UPIN_BO_R=1;
          UPIN_BF=1;
          UPIN_BF_R=1;
          UPIN_QU=1;
          UPIN_CUS_ORD=1;
          UPIN_ACI=1;
          UPIN_ACO=1;
          UPIN_ACJ=1;
          UPIN_ACS=1;
          UPIN_ACS=1;
          UPIN_COS=1;
          UPIN_MAIN=1;
          UPIN_CUS=1;
          UPIN_IN=1;
          UPIN_OU=1;
          UPIN_TR=1;
          UPIN_INV=1;
        }else{
          //فاتورة مشتربات
          if(GETPRID==901) {UPIN_BI = 2;}
          //مردود مشتريات
          if(GETPRID==912){UPIN_BIO = 2;}
          //فاتورة مبيعات
          else if(GETPRID==601) {UPIN_BO = 1;}
          //مردود فواتير المبيعات
          else if(GETPRID==611) {UPIN_BO_R = 2;}
          // فواتير خدمات
          else if(GETPRID==621) {UPIN_BO_S = 1;}
          // فاتورة مبيعات فورية
          else if(GETPRID==2207) {UPIN_BF = 1;}
          // // فاتورة مبيعات فورية
          else if(GETPRID==2272) {UPIN_BF_R = 2;}
          // عروض الاسعار
          else if(GETPRID==641){UPIN_QU = 2;}
          // طلبات عميل
          else if(GETPRID==645){UPIN_CUS_ORD = 2;}
          //سندات القبض
          else if(GETPRID==102) {UPIN_ACI = 2;}
          //سندات الصرف
          else if(GETPRID==103) {UPIN_ACO = 2;}
          //قيد يومي
          else if(GETPRID==111) {UPIN_ACJ = 2;}
          //كشف حساب
          else if(GETPRID==202) {UPIN_ACS = 1;}
          // كشف حساب رئيسي
          else if(GETPRID==203) {UPIN_MAIN = 1;}
          //كشف حساب مراكز تكلفه
          else if(GETPRID==489) {UPIN_COS = 1;}
          //العملاء
          else if(GETPRID==91) {UPIN_CUS = 2;}
          //التوريد المخزني
          else if(GETPRID==1421){UPIN_IN = 2;}
          //الصرف المخزني
          else if(GETPRID==1401){UPIN_OU = 2;}
          //تحويل مخزني
          else if(GETPRID==1444){UPIN_TR = 2;}
          //الجرد المخزني
          else if(GETPRID==1501){UPIN_INV = 2;}
          update();
        }
      }
  }

  //صلاحيات انواع السندات
  Future GET_ACC_MOV_K_P(int GETAMKID) async {
    Acc_Mov_K=await GET_ACC_MOV_K(GETAMKID);
      if (Acc_Mov_K.isNotEmpty) {
        // سندات القبض
        if(GETAMKID==1 ){
          AMKST_ACI = Acc_Mov_K.elementAt(0).AMKST;
        }
        //سندات الصرف
        else if(GETAMKID==2){
          AMKST_ACO = Acc_Mov_K.elementAt(0).AMKST;
        }
        //قيد يوميه
        else if(GETAMKID==15){
          AMKST_ACJ = Acc_Mov_K.elementAt(0).AMKST;
        }
      }
  }

  //صلاحيات انواع الحركات
  Future GET_BIL_MOV_K_P(int GETBMKID) async {
    Bil_Mov_K=await GET_BIL_MOV_K_State(GETBMKID);
      if (Bil_Mov_K.isNotEmpty) {
        // فواتير المشتريات
        if(GETBMKID==1 ){BMKST_BI = Bil_Mov_K.elementAt(0).BMKST;}
        //مردود مشتريات
        if(GETBMKID==2 ){BMKST_BIO = Bil_Mov_K.elementAt(0).BMKST;}
        // فواتير المبيعات
        else if(GETBMKID==3){BMKST_BO = Bil_Mov_K.elementAt(0).BMKST;}
        // مردود فواتير المبيعات
        else if(GETBMKID==4){BMKST_BO_R = Bil_Mov_K.elementAt(0).BMKST;}
        //  فواتير خدمات
        else if(GETBMKID==5){BMKST_BO_S = Bil_Mov_K.elementAt(0).BMKST;}
        // فواتير مبيعات فوريه
        else if(GETBMKID==11){BMKST_BF = Bil_Mov_K.elementAt(0).BMKST;}
        // مردود فواتير مبيعات فوريه
        else if(GETBMKID==12){BMKST_BF_R = Bil_Mov_K.elementAt(0).BMKST;}
        // عرض سعر
        else if(GETBMKID==7){BMKST_QU = Bil_Mov_K.elementAt(0).BMKST;}
        // طلب عميل
        else if(GETBMKID==10){BMKST_CUS_ORD = Bil_Mov_K.elementAt(0).BMKST;}
        update();
      }
  }

  Future GET_SYS_REP_P(int SRID) async {
    GET_SYS_REP(SRID.toString()).then((data) {
      if(SRID==1003){
        ST_1003=data.elementAt(0).SRST;
      }else if(SRID==1004){
        ST_1004=data.elementAt(0).SRST;
      }else if(SRID==1010){
        ST_1010=data.elementAt(0).SRST;
      }else if(SRID==1008){
        ST_1008=data.elementAt(0).SRST;
      }else if(SRID==1016){
        ST_1016=data.elementAt(0).SRST;
      }else if(SRID==1018){
        ST_1018=data.elementAt(0).SRST;
      }else if(SRID==1023){
        ST_1023=data.elementAt(0).SRST;
      }else if(SRID==1025){
        ST_1025=data.elementAt(0).SRST;
      }
    });
  }

  //صلاحيات انواع المخازن
  Future GET_STO_MOV_K_P(int GETSMKID) async {
    GET_STO_MOV_K_ST(GETSMKID).then((data) {
      if (data.isNotEmpty) {
        // امر توريد مخزني
        if(GETSMKID==1 ){
          SMKST_IN = data.elementAt(0).SMKST;
        }
        //امر صرف مخزني
        else if(GETSMKID==3){
          SMKST_OU = data.elementAt(0).SMKST;
        }
        //تحويل مخزنيه
        else if(GETSMKID==13){
          SMKST_TR = data.elementAt(0).SMKST;
        }
        //امر جرد مخزني
        else if(GETSMKID==17){
          SMKST_INV = data.elementAt(0).SMKST;
        }
      }
    });
  }

  GoToInvoiceSales(int Getarguments) {
     //فاتورة مبيعات
    if(BMKST_BO!=1 && Getarguments==3){
      LoginController().SET_N_P('SSID_N', 601);
      buildShowDialogMOV_K();
    }
    else if(UPIN_BO!=1 && Getarguments==3){
      LoginController().SET_N_P('SSID_N', 601);
      buildShowDialogPRIV();
    }
    //مردود فاتورة مبيعات
    else if(BMKST_BO_R!=1 && Getarguments==4){
      LoginController().SET_N_P('SSID_N', 611);
      buildShowDialogMOV_K();
    }
    else if(UPIN_BO_R!=1 && Getarguments==4){
      buildShowDialogPRIV();
      LoginController().SET_N_P('SSID_N', 611);
    }
    // فاتورة خدمات
    else if(BMKST_BO_S!=1 && Getarguments==5){
      buildShowDialogMOV_K();
      LoginController().SET_N_P('SSID_N', 621);
    }
    else if(UPIN_BO_S!=1 && Getarguments==5){
      buildShowDialogPRIV();
      LoginController().SET_N_P('SSID_N', 621);
    }
    //فاتورة مشتريات
    else if(BMKST_BI!=1 && Getarguments==1){
      buildShowDialogMOV_K();
      LoginController().SET_N_P('SSID_N', 901);
    }
    else if(UPIN_BI!=1 && Getarguments==1){
      buildShowDialogPRIV();
      LoginController().SET_N_P('SSID_N', 901);
    }
    //فاتورة مبيعات فوريه
    else if(BMKST_BF!=1 && Getarguments==11){
      buildShowDialogMOV_K();
      LoginController().SET_N_P('SSID_N', 2207);
    }
    else if(UPIN_BF!=1 && Getarguments==11){
      buildShowDialogPRIV();
      LoginController().SET_N_P('SSID_N', 2207);
    }
    //مردرد فاتورة مبيعات فوريه
    else if(BMKST_BF_R!=1 && Getarguments==12){
      buildShowDialogMOV_K();
      LoginController().SET_N_P('SSID_N', 2272);
    }
    else if(UPIN_BF_R!=1 && Getarguments==12){
      buildShowDialogPRIV();
      LoginController().SET_N_P('SSID_N', 2272);
    }
    //عرض سعر
    else if(BMKST_QU!=1 && Getarguments==7){
      buildShowDialogMOV_K();
      LoginController().SET_N_P('SSID_N', 641);
    }
    else if(UPIN_QU!=1 && Getarguments==7){
      buildShowDialogPRIV();
      LoginController().SET_N_P('SSID_N', 641);
    }
    //طلب عميل
    else if(BMKST_CUS_ORD!=1 && Getarguments==10){
      buildShowDialogMOV_K();
      LoginController().SET_N_P('SSID_N', 645);
    }
    else if(UPIN_CUS_ORD!=1 && Getarguments==10){
      buildShowDialogPRIV();
      LoginController().SET_N_P('SSID_N', 645);
    }
    else{
       Get.toNamed('/Sale_Invoices',arguments: Getarguments);
    }
  }

  GoToCounterSalesInvoice(int Getarguments) {
    if( Getarguments==0){
      Get.toNamed('/Counter_Sale_Posting_Approving');
    }
    else{
      Get.toNamed('/Sale_Invoices',arguments: Getarguments);
    }
  }

  GoToPay_Out(int Getarguments) {
     //سند صرف
    if(AMKST_ACO!=1 && Getarguments==2){
      buildShowDialogMOV_K();
    }
    else if(UPIN_ACO!=1 && Getarguments==2){
      buildShowDialogPRIV();
    }
    //سند قبض وتحصيل
    else if(AMKST_ACI!=1 && (Getarguments==1 || Getarguments==3)){
      buildShowDialogMOV_K();
    }
    else if(UPIN_ACI!=1 && (Getarguments==1 || Getarguments==3)){
      buildShowDialogPRIV();
    }
    // //قيد يوميه
    // else if(AMKST_ACJ!=1 && Getarguments==15){
    //   buildShowDialogMOV_K();
    // }
    else if(UPIN_ACJ!=1 && Getarguments==15){
      buildShowDialogPRIV();
    }
    else{
      Get.toNamed('/View_Pay_Out',arguments: Getarguments);
    }
  }

  GoToInventory(int Getarguments) {
     //امر توريد مخزني
    if(LoginController().experimentalcopy != 1 && SMKST_IN!=1 && Getarguments==1){
      buildShowDialogMOV_K();
    }
    else if(LoginController().experimentalcopy != 1 && UPIN_IN!=1 && Getarguments==1){
      buildShowDialogPRIV();
    }
    //امر صرف مخزني
    else if(LoginController().experimentalcopy != 1 && SMKST_OU!=1 && Getarguments==3 ){
      buildShowDialogMOV_K();
    }
    else if(LoginController().experimentalcopy != 1 && UPIN_OU!=1 &&  Getarguments==3){
      buildShowDialogPRIV();
    }
    // تحويل مخزني
    else if(LoginController().experimentalcopy != 1 && SMKST_TR!=1 && Getarguments==13){
      buildShowDialogMOV_K();
    }
    else if(LoginController().experimentalcopy != 1 && UPIN_TR!=1 && Getarguments==15){
      buildShowDialogPRIV();
    }
    //امر جرد مخزني
    else if(LoginController().experimentalcopy != 1 && SMKST_INV!=1 && Getarguments==17){
      buildShowDialogMOV_K();
    }
    else if(LoginController().experimentalcopy != 1 && UPIN_INV!=1 && Getarguments==17){
      buildShowDialogPRIV();
    }
    else{
      Get.toNamed('/Inventory',arguments: Getarguments);
    }
  }

  GoToRopert(int Getarguments) {
    //تقرير بارصدة العملاء
    if(ST_1003!=1 && Getarguments==1003){
      buildShowDialogMOV_K();
    }
    //تقرير بارصدة الموردين
    else if(ST_1004!=1 && Getarguments==1004){
      buildShowDialogMOV_K();
      //تقرير بارصدة الحسابات
    }else if(ST_1010!=1 && Getarguments==1010 ){
      buildShowDialogMOV_K();
    }
    //تقرير بالحسابات الغير متحركه
    else if(ST_1008!=1 && Getarguments==1008) {
      buildShowDialogMOV_K();
      //تقريراعمار الديون للحسابات
    }
    else if(ST_1016!=1 && Getarguments==1016) {
      buildShowDialogMOV_K();
      //تقرير بالحسابات
      // المخالفه لطبيعتها
    }else if(ST_1018!=1 && Getarguments==1018){
      buildShowDialogMOV_K();
    }
    //تقرير القوائم  الماليه
    else if(ST_1023!=1 && Getarguments==1023){
      buildShowDialogMOV_K();
    }
    //كشف تحليلي بحركة الحسابات للاشهر/السنوات
    else if(ST_1025!=1 && Getarguments==1025){
      buildShowDialogMOV_K();
    } else{

      Get.toNamed('/Reports',arguments: Getarguments);
    }
  }

  Future<dynamic> buildShowDialogPRIV() {
    return Get.defaultDialog(
      title: 'StringMestitle'.tr,
      middleText: 'StringCHK_PRIV'.tr,
      backgroundColor: Colors.white,
      radius: 40,
      textCancel: 'StringOK'.tr,
      cancelTextColor: Colors.blue,
    );
  }

  Future<dynamic> buildShowDialogMOV_K() {
    return Get.defaultDialog(
      title: 'StringMestitle'.tr,
      middleText: 'StrinStoppedToInsert'.tr,
      backgroundColor: Colors.white,
      radius: 40,
      textCancel: 'StringNo'.tr,
      cancelTextColor: Colors.red,
    );
  }


  Future GET_GEN_VAR_P() async {
    var GEN_VAR;
    GEN_VAR=await GET_GEN_VAR('SOMID');
      if (GEN_VAR.isNotEmpty) {
        LoginController().SET_P('SYDV_ID',GEN_VAR.elementAt(0).VAL.toString());
        UpdateMOB_VAR(4,GEN_VAR.elementAt(0).VAL.toString());
      }

    GEN_VAR=await GET_GEN_VAR('SOMWN');
      if (GEN_VAR.isNotEmpty) {
        LoginController().SET_P('SYDV_NO',GEN_VAR.elementAt(0).VAL.toString());
      }

    GEN_VAR=await GET_GEN_VAR('PKID1');
      if (GEN_VAR.isNotEmpty) {
        print('PKID1');
        print(GEN_VAR.elementAt(0).VAL.toString());
        LoginController().SET_P('PKID1', GEN_VAR.elementAt(0).VAL.toString());
      }

    GEN_VAR=await GET_GEN_VAR('PKID3');
      if (GEN_VAR.isNotEmpty) {
        LoginController().SET_P('PKID2', GEN_VAR.elementAt(0).VAL.toString());
      }
      update();
  }

  Future Get_JTNA_DATA() async {
    Get_JTNA(LoginController().JTID).then((data) {
      GET_JTNA=data;
      if(GET_JTNA.isNotEmpty) {
        JTNA_V = GET_JTNA.elementAt(0).JTNA_D.toString();
        JTNAController.text = GET_JTNA.elementAt(0).JTNA_D.toString();
        update();
        isloading(true);
        update();
      }
    });
    Get_BINA_DATA();
    update();
  }

  //جلب اسم الفرع
  Future Get_BINA_DATA() async {
    Get_BINA(LoginController().BIID).then((data) {
      GET_BINA=data;
      if(GET_BINA.isNotEmpty) {
        BINA_V = GET_BINA.elementAt(0).BINA_D.toString();
        BINAController.text = GET_BINA.elementAt(0).BINA_D.toString();
        update();
        isloading(true);
        update();
      }
    });
  }

  Future GET_SUNA() async {
    GET_USR_NAME(LoginController().SUID).then((data) {
      if(data.isNotEmpty) {
        GET_SUNA_D=data;
        SUNAController.text = GET_SUNA_D.elementAt(0).SUNA_D.toString();
        update();
        isloading(true);
        update();
      }
    });
  }

  Future GET_SYS_SCR_FAS_P() async {
    FAS_ACC_USR= await GET_FAS_ACC_USR('2');
      update();
  }

  Future GET_SYS_SCR_FAS_P2() async {
    FAS_ACC_USR2= await GET_FAS_ACC_USR('1');
        update();
  }

  Future SAVE_FAS_ACC_USR() async {
    try {
        //فواتير المبيعات
        Fas_Acc_Usr_Local FAS_ACC_USR1 = Fas_Acc_Usr_Local(
            SUID: LoginController().SUID,
            SSID: 601,
            FAUST: 1,
            FAUST2: 2,
            ORDNU: 1,
            SUID2: 'IT',
            DATEI: DateTime.now().toString(),
            DEVI: LoginController().DeviceName,
            GUID: uuid.v4().toUpperCase(),
            JTID_L: LoginController().BIID_L,
            BIID_L: LoginController().BIID_L,
            SYID_L: LoginController().SYID_L,
            CIID_L: LoginController().CIID_L);
        //فاتورة مشتريات
        Fas_Acc_Usr_Local FAS_ACC_USR2 = Fas_Acc_Usr_Local(
            SUID: LoginController().SUID,
            SSID: 901,
            FAUST: 1,
            FAUST2: 2,
            ORDNU: 2,
            SUID2: 'IT',
            DATEI: DateTime.now().toString(),
            DEVI: LoginController().DeviceName,
            GUID: uuid.v4().toUpperCase(),
            JTID_L: LoginController().BIID_L,
            BIID_L: LoginController().BIID_L,
            SYID_L: LoginController().SYID_L,
            CIID_L: LoginController().CIID_L);
        //سندات القبض
        Fas_Acc_Usr_Local FAS_ACC_USR3 = Fas_Acc_Usr_Local(
            SUID: LoginController().SUID,
            SSID: 102,
            FAUST: 1,
            FAUST2: 2,
            ORDNU: 3,
            SUID2: 'IT',
            DATEI: DateTime.now().toString(),
            DEVI: LoginController().DeviceName,
            GUID: uuid.v4().toUpperCase(),
            JTID_L: LoginController().BIID_L,
            BIID_L: LoginController().BIID_L,
            SYID_L: LoginController().SYID_L,
            CIID_L: LoginController().CIID_L);
        //سندات الصرف
        Fas_Acc_Usr_Local FAS_ACC_USR4 = Fas_Acc_Usr_Local(
            SUID: LoginController().SUID,
            SSID: 103,
            FAUST: 1,
            FAUST2: 2,
            ORDNU: 4,
            SUID2: 'IT',
            DATEI: DateTime.now().toString(),
            DEVI: LoginController().DeviceName,
            GUID: uuid.v4().toUpperCase(),
            JTID_L: LoginController().BIID_L,
            BIID_L: LoginController().BIID_L,
            SYID_L: LoginController().SYID_L,
            CIID_L: LoginController().CIID_L);
        //فاتورة مبيعات(POS)
        Fas_Acc_Usr_Local FAS_ACC_USR5 = Fas_Acc_Usr_Local(
            SUID: LoginController().SUID,
            SSID: 742,
            FAUST: 2,
            FAUST2: 2,
            ORDNU: 5,
            SUID2: 'IT',
            DATEI: DateTime.now().toString(),
            DEVI: LoginController().DeviceName,
            GUID: uuid.v4().toUpperCase(),
            JTID_L: LoginController().BIID_L,
            BIID_L: LoginController().BIID_L,
            SYID_L: LoginController().SYID_L,
            CIID_L: LoginController().CIID_L);
        //فواتير الخدمات
        Fas_Acc_Usr_Local FAS_ACC_USR6 = Fas_Acc_Usr_Local(
            SUID: LoginController().SUID,
            SSID: 621,
            FAUST: 2,
            FAUST2: 2,
            ORDNU: 6,
            SUID2: 'IT',
            DATEI: DateTime.now().toString(),
            DEVI: LoginController().DeviceName,
            GUID: uuid.v4().toUpperCase(),
            JTID_L: LoginController().BIID_L,
            BIID_L: LoginController().BIID_L,
            SYID_L: LoginController().SYID_L,
            CIID_L: LoginController().CIID_L);
        //مردود فواتير المبيعات
        Fas_Acc_Usr_Local FAS_ACC_USR7 = Fas_Acc_Usr_Local(
            SUID: LoginController().SUID,
            SSID: 611,
            FAUST: 2,
            FAUST2: 2,
            ORDNU: 7,
            SUID2: 'IT',
            DATEI: DateTime.now().toString(),
            DEVI: LoginController().DeviceName,
            GUID: uuid.v4().toUpperCase(),
            JTID_L: LoginController().BIID_L,
            BIID_L: LoginController().BIID_L,
            SYID_L: LoginController().SYID_L,
            CIID_L: LoginController().CIID_L);
        //مردود مبيعات (POS)
        Fas_Acc_Usr_Local FAS_ACC_USR8 = Fas_Acc_Usr_Local(
            SUID: LoginController().SUID,
            SSID: 743,
            FAUST: 2,
            FAUST2: 2,
            ORDNU: 8,
            SUID2: 'IT',
            DATEI: DateTime.now().toString(),
            DEVI: LoginController().DeviceName,
            GUID: uuid.v4().toUpperCase(),
            JTID_L: LoginController().BIID_L,
            BIID_L: LoginController().BIID_L,
            SYID_L: LoginController().SYID_L,
            CIID_L: LoginController().CIID_L);
        //القيود اليوميه
        Fas_Acc_Usr_Local FAS_ACC_USR9 = Fas_Acc_Usr_Local(
            SUID: LoginController().SUID,
            SSID: 111,
            FAUST: 2,
            FAUST2: 2,
            ORDNU: 9,
            SUID2: 'IT',
            DATEI: DateTime.now().toString(),
            DEVI: LoginController().DeviceName,
            GUID: uuid.v4().toUpperCase(),
            JTID_L: LoginController().BIID_L,
            BIID_L: LoginController().BIID_L,
            SYID_L: LoginController().SYID_L,
            CIID_L: LoginController().CIID_L);
        //اعدادات العملاء
        Fas_Acc_Usr_Local FAS_ACC_USR10 = Fas_Acc_Usr_Local(
            SUID: LoginController().SUID,
            SSID: 91,
            FAUST: 2,
            FAUST2: 2,
            ORDNU: 10,
            SUID2: 'IT',
            DATEI: DateTime.now().toString(),
            DEVI: LoginController().DeviceName,
            GUID: uuid.v4().toUpperCase(),
            JTID_L: LoginController().BIID_L,
            BIID_L: LoginController().BIID_L,
            SYID_L: LoginController().SYID_L,
            CIID_L: LoginController().CIID_L);
        //كشف حساب
        Fas_Acc_Usr_Local FAS_ACC_USR11 = Fas_Acc_Usr_Local(
            SUID: LoginController().SUID,
            SSID: 202,
            FAUST: 2,
            FAUST2: 2,
            ORDNU: 11,
            SUID2: 'IT',
            DATEI: DateTime.now().toString(),
            DEVI: LoginController().DeviceName,
            GUID: uuid.v4().toUpperCase(),
            JTID_L: LoginController().BIID_L,
            BIID_L: LoginController().BIID_L,
            SYID_L: LoginController().SYID_L,
            CIID_L: LoginController().CIID_L);

        await SaveFAS_ACC_USR(FAS_ACC_USR1);
        await SaveFAS_ACC_USR(FAS_ACC_USR2);
        await SaveFAS_ACC_USR(FAS_ACC_USR3);
        await SaveFAS_ACC_USR(FAS_ACC_USR4);
        await SaveFAS_ACC_USR(FAS_ACC_USR5);
        await SaveFAS_ACC_USR(FAS_ACC_USR6);
        await SaveFAS_ACC_USR(FAS_ACC_USR7);
        await SaveFAS_ACC_USR(FAS_ACC_USR8);
        await SaveFAS_ACC_USR(FAS_ACC_USR9);
        await SaveFAS_ACC_USR(FAS_ACC_USR10);
        await SaveFAS_ACC_USR(FAS_ACC_USR11);
        GET_SYS_SCR_FAS_P2();
        GET_SYS_SCR_FAS_P();
        update();
      } catch (e) {
        print(e.toString());
        Fluttertoast.showToast(
            msg: "SAVE_FAS_ACC_USR: ${e.toString()}",
            textColor: Colors.white,
            backgroundColor: Colors.red);
        return Future.error(e);
      }
    }

  Future<void> CHICK_SERVICE() async {
    final service = FlutterBackgroundService();
    var isRunning = await service.isRunning();
    if (isRunning) {
      LoginController().SET_B_P('Service_isRunning',true);
    }else{
      LoginController().SET_B_P('Service_isRunning',false);
    }
    update();
    print(LoginController().Service_isRunning);
    Timer.periodic(Duration(minutes: 5), (timer) {
      if (isRunning) {
        LoginController().SET_B_P('Service_isRunning',true);
      }else{
        LoginController().SET_B_P('Service_isRunning',false);
      }
      update();
    } );
    // returns hostname as string
  }


}
