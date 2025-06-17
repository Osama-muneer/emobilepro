import 'dart:async';
import 'dart:io';
import 'dart:math';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/services.dart';
import '../../Setting/controllers/login_controller.dart';
import '../../Setting/controllers/setting_controller.dart';
import '../../Setting/models/acc_acc.dart';
import '../../Setting/models/acc_ban.dart';
import '../../Setting/models/acc_cas.dart';
import '../../Setting/models/acc_cos.dart';
import '../../Setting/models/bal_acc_c.dart';
import '../../Setting/models/bil_cre_c.dart';
import '../../Setting/models/bil_dis.dart';
import '../../Setting/models/bra_inf.dart';
import '../../Setting/models/sys_cur.dart';
import '../../Setting/models/sys_doc_d.dart';
import '../../Setting/models/sys_usr.dart';
import '../../Setting/models/sys_var.dart';
import '../../Setting/models/usr_pri.dart';
import '../../Setting/services/syncronize.dart';
import '../../Widgets/TextFormt.dart';
import '../../Widgets/colors.dart';
import '../../Widgets/config.dart';
import '../../Widgets/dropdown.dart';
import '../../Widgets/theme_helper.dart';
import '../../database/TreasuryVouchers_db.dart';
import '../../database/setting_db.dart';
import '../../database/sync_db.dart';
import '../Views/TreasuryVouchers/add_ed_pay_out.dart';
import '../models/acc_mov_m.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:number_to_character/number_to_character.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';
import 'package:uuid/uuid.dart';
import 'package:intl/intl.dart' as intl;
import '../models/acc_mov_d.dart';
import '../models/bil_mov_m.dart';

List<Acc_Mov_D_Local> get_ACC_MOV_D = [];

List<Acc_Mov_D_Local> SUM_ACC_MOV_D = [];
class Pay_Out_Controller extends GetxController {
  //AMJAD

  Uint8List? signature;
  final formatter = intl.NumberFormat.decimalPattern();
  RxBool loading = false.obs;
  bool edit = false,Repeatingedit=false,Debit=false,Credit=false,ValueAMMCC = false;
  late FocusNode myFocusNode;
  var converter = NumberToCharacterConverter('en');
  RegExp regex = RegExp(r'([.]*0)(?!.*\d)');
  RxnString errorTextBIID = RxnString(null);
  RxnString errorTextCWID = RxnString(null);
  RxnString errorTextSCID = RxnString(null);
  RxnString errorTextPKID = RxnString(null);
  RxnString errorText = RxnString(null);
  var isloading = false.obs;
  DateTime dateTimeDays = DateTime.now();
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final DataGridController dataGridController = DataGridController();

  final ADD_EDformKey = GlobalKey<FormState>();
  FocusNode contentFocusNode = FocusNode();
  var uuid = const Uuid();
  var GUID,GUIDD,SUM_M;
  late FocusNode _autocompleteFocusNode;
  double SCEX2=0,SCHR=0,SCLR=0,SCEX=0, BACBMD=0,
      BACBDA=0, BACBA=0,AMDMO=0,SUMAMDEQ_DA=0,SUMAMDEQ_MD=0,Difference_AMDEQ_MD_DA=0,
      SUMBAL_V=0,
      SumBal=0,
      BACBNF = 0;
  String? SelectDataBIID,titleScreen,SelectDataSCID,SelectDataSCID2,SelectDataPKID,SelectDataAANO,SelectDays,SelectDataACNO,
      SelectDataACID,SelectDataBCCID,SelectDataABID,Date_of_Insert_Voucher,RepeatingSameAccount,ShowRePrintingVoucher,SUMO,
      Balance_Pay,SelectDataBDID,SelectDataBDID2,SHOW_BDID,SelectDataACNO_D,
      SelectDays_F,SelectDays_T,selectedBranchFrom,selectedBranchTo,SelectDataSCID_S;
  String Type='1',SCSY='',SCNA='',titleAddScreen = '',StringButton = '',STB_N='',SelectNumberOfDays='',SONA=''
  ,SONE='',SORN='',SOLN='',SDDSA='',MES_ADD_EDIT='', SOTX='', SOAD='',AANOCOUNT='0',
      SDDDA = '',AANADetails='',AMMINCHECK='' ,BACBAS='', BACBAR='', BCAD_D='',BIID_D='',
      P_COS1='2', P_COS2='2',P_COSS='2',P_COSM='1',P_COS_SEQ='2',AMKID_TYPE='15',TYPE_SHOW = "DateNow",
      Multi_CUR='1', LastBAL_ACC_C='';
  int SCSFL=2,UPIN_PKID=1,PKID=1,TYPYPKID=1,CheckBack=0,ShowRePrinting=0,AACT = 1, UseSignature=0,
      ShowSignatureAlert=0, currentIndex=0,TYPE_SER=2;
  int? AMMID,AMKID,AMMST,AMDID,AMMNO,Allow_to_Inserted_Date_of_Voucher,SCID_C,BYST=1,UPCH=1,UPINCUS=1,
      UPIN=1,UPQR=1,UPDL=1,UPPR=1,AKID=1,CheckSearech,  ArrLengthCus = 0;
  late TextEditingController AANAController,AANOController,SCNAController,
      SCEXController,SCEX2Controller,AMDDAController,
      PKIDController,BCCIDController,BCCNAController,ABIDController,ABNAController,
      BCBNController,BCONController,AMMCNController,
      ACIDController,ACNAController,UPDATEController,AMMINController,AMDIDController,
      AMMREController,CountRecodeController,
      AMMAMController,SUMAMDAController,AMMAM1Controller,AMMEQController,AMDEQController,
      AMDINController,
      AMDMOController,AMDMOHintController,AMDMOSController,AMDEQSController,
      SCHRController,SCLRController,FromDaysController,
      ToDaysController,TextEditingSercheController;
  DateTime dateFromDays1 = DateTime.now();
  DateTime dateFromYear1 = DateTime.now();
  DateTime dateTimeToDays2 = DateTime.now();
  String SER_DA = DateFormat('dd-MM-yyyy').format(DateTime.now());
  late List<Acc_Acc_Local> autoCompleteData;
  late List<Bil_Cre_C_Local> BIL_CRE_C_List = [];
  late List<Acc_Ban_Local> ACC_BAN_List = [];
  late List<Acc_Mov_M_Local> ACC_MOV_M_List = [];
  late List<Acc_Mov_M_Local> ACC_MOV_M_PRINT = [];
  late List<Acc_Mov_D_Local> ACC_MOV_D = [];
  late List<Acc_Mov_D_Local> ListACC_MOV_D = [];
  late List<Sys_Var_Local> SYS_VAR;
  late List<Usr_Pri_Local> USR_PRI;
  late List<Bal_Acc_C_Local> BIL_ACC_C;
  late List<Sys_Doc_D_Local> GET_SYS_DOC;
  late List<Acc_Mov_D_Local> COUNT_RECODE;
  late List<Acc_Mov_M_Local> GET_AMMIN;
  late List<Acc_Mov_D_Local> GET_AMDIN;
  late List<Bra_Inf_Local> BRA_INF;
  late List<Acc_Cas_Local> ACC_CAS;
  late List<Sys_Usr_Local> SYS_USR;
  late List<Bil_Dis_Local> BIL_DIS;

  onInit() {
    super.onInit();
    (Get.arguments==1 || Get.arguments==11 || AMKID==1) ? AMKID=1 : (Get.arguments==2 || AMKID==2) ? AMKID=2 :
    (Get.arguments==3 || AMKID==3) ? AMKID=3 : AMKID=15;
    AANOController =   TextEditingController();
    AANAController =   TextEditingController();
    SCNAController =   TextEditingController();
    SCEXController =   TextEditingController();
    AMDDAController =  TextEditingController();
    PKIDController =   TextEditingController();
    BCCIDController =  TextEditingController();
    BCCNAController =  TextEditingController();
    BCBNController =   TextEditingController();
    BCONController =   TextEditingController();
    ABIDController =   TextEditingController();
    ABNAController =   TextEditingController();
    AMMCNController =  TextEditingController();
    ACIDController =   TextEditingController();
    ACNAController =   TextEditingController();
    UPDATEController = TextEditingController();
    AMDMOController =  TextEditingController();
    AMMINController =  TextEditingController();
    AMDIDController =  TextEditingController();
    AMMREController =  TextEditingController();
    AMMAMController =  TextEditingController();
    SUMAMDAController =  TextEditingController();
    AMDINController =  TextEditingController();
    AMMAM1Controller =  TextEditingController();
    SCEX2Controller =  TextEditingController();
    AMDEQController =  TextEditingController();
    AMDMOHintController =  TextEditingController();
    AMMEQController =  TextEditingController();
    CountRecodeController =  TextEditingController();
    SCHRController =  TextEditingController();
    SCLRController =  TextEditingController();
    AMDMOSController =  TextEditingController();
    AMDEQSController =  TextEditingController();
    FromDaysController =  TextEditingController();
    TextEditingSercheController =  TextEditingController();
    ToDaysController =  TextEditingController();
    myFocusNode = FocusNode();
    _autocompleteFocusNode = FocusNode();
    FromDaysController.text = SER_DA;
    ToDaysController.text = SER_DA;
    GET_USR_PRI();
    // Timer_Strat();
    SyncACC_MOV_D('SyncOnly','0',false);
    GET_ACC_MOV_M_P('DateNow',AMKID!);
    UpdateDataGUID_P();
    Delete_Acc_Mov_D_DetectApp();
    GET_SYS_OWN_P(LoginController().BIID.toString());
    GET_SYS_DOC_D_P();
    GET_Date_of_Insert_Voucher();
    GET_BRA_YEA_P();
    GET_Multi_Currency();
    GETRepeatingSameAccount_Voucher();
    GETShowRePrintingVoucher();
    GET_Balance_Pay();
    GET_AMMIN_P();
    GET_SUMO();
    GET_PRIVLAGECUS();
    GET_SHOW_BDID();
    GET_USE_Cost_Centers();
    GET_USE_Linking_Accounts_Cost_Centers();
    GET_USE_Linking_Income_Accounts_Cost_Centers();
    GET_COS_SEQ();
    GETMOB_VAR_P(21);
    GETMOB_VAR_P(22);
    GET_SYN_ORD_P();
    if(Get.arguments==11){
      AddPayOut();
    }
  }

  dispose() {
    super.dispose();
    AANAController.dispose();
    AANAController.dispose();
    SCNAController.dispose();
    SCEXController.dispose();
    AMDDAController.dispose();
    PKIDController.dispose();
    BCCIDController.dispose();
    BCCNAController.dispose();
    BCBNController.dispose();
    BCONController.dispose();
    ABIDController.dispose();
    ABNAController.dispose();
    AMMCNController.dispose();
    ACIDController.dispose();
    ACNAController.dispose();
    UPDATEController.dispose();
    AMDMOController.dispose();
    AMMINController.dispose();
    AMDIDController.dispose();
    AMMREController.dispose();
    AMMAMController.dispose();
    SUMAMDAController.dispose();
    AMDINController.dispose();
    AMMAM1Controller.dispose();
    SCEX2Controller.dispose();
    AMDMOHintController.dispose();
    AMMEQController.dispose();
    AMDEQController.dispose();
    AMDEQSController.dispose();
    SCHRController.dispose();
    SCLRController.dispose();
    CountRecodeController.dispose();
    FromDaysController.dispose();
    ToDaysController.dispose();
    TextEditingSercheController.dispose();
    AMDMOSController.dispose();
    _autocompleteFocusNode.dispose();
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


  Future GET_SYN_ORD_P() async {
    var SYN_ORD=await GET_SYN_ORD('BAL_ACC_C');
    if (SYN_ORD.isNotEmpty) {
      LastBAL_ACC_C = SYN_ORD.elementAt(0).SOLD.toString();
      print('LastBAL_ACC_C');
      print(LastBAL_ACC_C);
    }
  }

//داله التحقق من متغير التوقيع
  Future GETMOB_VAR_P(int GETMVID) async {
    var MVVL=await GETMOB_VAR(GETMVID);
    if(MVVL.isNotEmpty){
      if(GETMVID==21) {
        UseSignature=int.parse(MVVL.elementAt(0).MVVL.toString());
      }
      else if(GETMVID==22) {
        ShowSignatureAlert=int.parse(MVVL.elementAt(0).MVVL.toString());
      }
      ShowSignatureAlert= UseSignature==0 ? 0 : ShowSignatureAlert;
      update();
    }else{
      if(GETMVID==21) {
        UseSignature=StteingController().UseSignatureValue==true?1:0;
      } else if(GETMVID==22) {
        ShowSignatureAlert=StteingController().ShowSignatureAlertValue==true?1:0;
      }
    }
  }

  Future<void> selectDateFromDays_F(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate:  dateFromDays1,
      firstDate: DateTime(2000,5),
      lastDate: DateTime(2040),
      builder: (context, child) {
        return   Theme(
          data: ThemeData.light().copyWith(
              primaryColor: const Color(0xFF4A5BF6),
              colorScheme: ColorScheme.fromSwatch(primarySwatch: buttonTextColor).copyWith(secondary: const Color(0xFF4A5BF6))//selection color
          ),
          child: child!,
        );
      },
    );
    if (picked != null) {
      FromDaysController.text =  DateFormat("dd-MM-yyyy").format(picked);
    }
    update();
  }

  Future<void> selectDateToDays(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: dateTimeToDays2,
      firstDate: DateTime(2000, 5),
      lastDate: DateTime(2040),
      builder: (context, child) {
        return   Theme(
          data: ThemeData.light().copyWith(
              primaryColor: const Color(0xFF4A5BF6),
              colorScheme: ColorScheme.fromSwatch(primarySwatch: buttonTextColor).copyWith(secondary: const Color(0xFF4A5BF6))//selection color
          ),
          child: child!,
        );
      },
    );
    if (picked != null) {
      ToDaysController.text = DateFormat("dd-MM-yyyy").format(picked);
    }
    update();
  }

  Future UpdateDataGUID_P() async {
    await UpdateDataGUID('ACC_MOV_D');
  }

  //اظهار البيانات +البحث
  GET_ACC_MOV_M_P(String type,int GETAMKID) async {
    ACC_MOV_M_List=await GET_ACC_MOV_M(
        TYPE_SHOW,TYPE_SHOW=="DateNow"?DateFormat('dd-MM-yyyy').format(DateTime.now())
        :TYPE_SHOW=="FromDate"?SelectNumberOfDays:'',GETAMKID,currentIndex,
        selectedBranchFrom.toString(),selectedBranchTo.toString(),FromDaysController.text,
        ToDaysController.text,SelectDataSCID_S.toString(),TYPE_SER);
    update();
  }

  //التأكد من السنة المالية من انه فعالة
  Future GET_BRA_YEA_P() async {
    var BRA_YEA=await GET_BRA_YEA(LoginController().JTID, LoginController().BIID,LoginController().SYID);
    if (BRA_YEA.isNotEmpty) {
      BYST = BRA_YEA.elementAt(0).BYST;
    } else {
      BYST = 1;
    }
  }

  //جلب بيانات المنشاة
  Future GET_SYS_OWN_P(String GETBIID) async {
    var SYS_OWN = await GET_SYS_OWN(GETBIID);
    if (SYS_OWN.isNotEmpty) {
      //الاسم يمين
      SONA = SYS_OWN
          .elementAt(0)
          .SONA
          .toString();
      SORN = SYS_OWN
          .elementAt(0)
          .SORN
          .toString();
      //الاسم شمال
      SONE = SYS_OWN
          .elementAt(0)
          .SONE
          .toString();
      SOLN = SYS_OWN
          .elementAt(0)
          .SOLN
          .toString();
      //العنوان
      SOAD = SYS_OWN
          .elementAt(0)
          .SOAD
          .toString();

    }
  }

  //طباعه الحركه
  Future GET_ACC_MOV_M_PRINT_P(GETAMMID, GETAMKID) async {
    GET_ACC_MOV_M_PRINT(GETAMMID,GETAMKID).then((data) {
      ACC_MOV_M_PRINT = data;
    });
  }

  //جلب العمله عند الدخول
  Future GET_SYS_CUR_ONE_PAY_P() async {
    var SYS_CUR=await GET_SYS_CUR_ONE();
    if(SYS_CUR.isNotEmpty){
      SelectDataSCID=SYS_CUR.elementAt(0).SCID.toString();
      SCEXController.text=SYS_CUR.elementAt(0).SCEX.toString();
      SCHRController.text=SYS_CUR.elementAt(0).SCHR.toString();
      SCLRController.text=SYS_CUR.elementAt(0).SCLR.toString();
      SCSY=SYS_CUR.elementAt(0).SCSY!;
      SCNA=SYS_CUR.elementAt(0).SCNA!;
      SCSFL=SYS_CUR.elementAt(0).SCSFL!;
      update();
    }
  }


  Future GET_Multi_Currency() async {
    GET_SYS_VAR(201).then((data) {
      if (data.isNotEmpty) {
        Multi_CUR =  data.elementAt(0).SVVL!;
      } else {
        Multi_CUR = '2';
      }
    });
  }


  // نوع الحساب اذا كان 1 قائمة مركز مالي و 2 قائمة دخل
  GET_AKID_P() async {
    GET_AKID(SelectDataAANO.toString()).then((data) {
      if (data.isEmpty) {
        AKID = 1;
      } else {
        AKID = data.elementAt(0).AKID;
      }
    });
    update();
  }

  // هل يتم استخدام مراكز التكلفة بشكل عام
  Future GET_USE_Cost_Centers() async {
    var data =await GET_SYS_VAR(351);
    if (data.isNotEmpty) {
      P_COSM =  data.elementAt(0).SVVL!;
    } else {
      P_COSM = '2';
    }
  }

  //ربط حسابات المركز المالي-الميزانيه بمراكز التكلفه
  Future GET_USE_Linking_Accounts_Cost_Centers() async {
    var data =await GET_SYS_VAR(352);
    if (data.isNotEmpty) {
      P_COS1 =  data.elementAt(0).SVVL!;
    } else {
      P_COS1 = '2';
    }
  }

  //ربط حسابات قائمة الدخل-الارباح,المتاجره بمراكز التكلفه
  Future GET_USE_Linking_Income_Accounts_Cost_Centers() async {
    var data =await GET_SYS_VAR(353);
    if (data.isNotEmpty) {
      P_COS2 =  data.elementAt(0).SVVL!;
    } else {
      P_COS2 = '2';
    }
  }

  //تسلسل الحركة حسب مراكز التكلفة في الشاشة
  Future GET_COS_SEQ() async {
    var data =await GET_SYS_VAR(AMKID == 15 ? 383 :375);
    if (data.isNotEmpty) {
      P_COS_SEQ =  data.elementAt(0).SVVL!;
      P_COS_SEQ=='4' ? P_COS_SEQ='1' : P_COS_SEQ='2';
    } else {
      P_COS_SEQ = '2';
    }
    await SET_COS();
  }


  Future SET_COS() async {
    if (P_COSM!='1' ) {
      P_COS_SEQ =  '2';
      P_COS1=  '5';
      P_COS2=  '5';
      print('SET_COS');
      print(P_COS1);
      print(P_COS2);
      print('SET_COS');
      update();
    }
  }

  //حذف الحركة الفرعية عند الخروج من التطبيق
  Future Delete_Acc_Mov_D_DetectApp() async {
    GET_Acc_Mov_D_DetectApp().then((data) {
      if (data.isNotEmpty) {
        DELETEACC_MOV_D(data.elementAt(0).AMMID.toString());
      }
    });
  }

  Future GET_SYS_CUR_DAT_P(String GETSCID) async {
    var SYS_CUR=await GET_SYS_CUR_DAT(GETSCID);
    if(SYS_CUR.isNotEmpty){
      // SCEXController.text=SYS_CUR.elementAt(0).SCEX.toString();
      SCEX=SYS_CUR.elementAt(0).SCEX!;
      SCHRController.text=SYS_CUR.elementAt(0).SCHR.toString();
      SCLRController.text=SYS_CUR.elementAt(0).SCLR.toString();
      SCSY=SYS_CUR.elementAt(0).SCSY!;
      SCNA=SYS_CUR.elementAt(0).SCNA!;
      SCSFL=SYS_CUR.elementAt(0).SCSFL!;
      update();
    }
  }

  Future GET_SYS_CUR_ONE_SALE_P(String GETSCID) async {
    var SYS_CUR=await GET_SYS_CUR_ONE_P(GETSCID);
    if (SYS_CUR.isNotEmpty) {
      SelectDataSCID = SYS_CUR.elementAt(0).SCID.toString();
      SCEXController.text = SYS_CUR.elementAt(0).SCEX.toString();
      SCSY = SYS_CUR.elementAt(0).SCSY!;
      SCSFL = SYS_CUR.elementAt(0).SCSFL!;
    }else{
      await GET_SYS_CUR_ONE_PAY_P();
    }
    update();
  }

  Future GET_SUMO() async {
    GET_USR_NAME(LoginController().SUID).then((data) {
      if(data.isNotEmpty) {
        SYS_USR=data;
        SUMO = SYS_USR.elementAt(0).SUMO.toString();
      }
    });
  }

  //جلب الحسابات
  Future fetchAutoCompleteData() async {
    autoCompleteData= await GET_ACC_ACC(SelectDataBIID.toString(),AMKID!);
    await GET_AMDID_P();
  }

  //تاريخ ادخال السندات
  Future GET_Date_of_Insert_Voucher() async {
    GET_SYS_VAR(362).then((data) {
      SYS_VAR = data;
      if (SYS_VAR.isNotEmpty) {
        Date_of_Insert_Voucher = SYS_VAR.elementAt(0).SVVL;
        //حسب الصلاحيات
        if (SYS_VAR.elementAt(0).SVVL.toString() == '4') {
          //السماح بتعديل تاريخ ادخال السندات
          PRIVLAGE(LoginController().SUID, 71).then((data) {
            USR_PRI = data;
            if (USR_PRI.isNotEmpty) {
              Allow_to_Inserted_Date_of_Voucher = USR_PRI.elementAt(0).UPIN;
            } else {
              Allow_to_Inserted_Date_of_Voucher = 2;
            }
          });
        }
      }
      else {
        Date_of_Insert_Voucher = '1';
      }
    });
  }

  //عند تكرار ادخال نفس الحساب في الحركه المحاسبيه
  Future GETRepeatingSameAccount_Voucher() async {
    GET_SYS_VAR(365).then((data) {
      SYS_VAR = data;
      if (SYS_VAR.isNotEmpty) {
        RepeatingSameAccount = SYS_VAR.elementAt(0).SVVL;
      }
      else {
        RepeatingSameAccount = '1';
      }
    });
  }

  //جلب رقم الحساب وذلك للتاكد من ان الحساب لم يتم اضافته من قبل في الحركه
  Future GETAANOCOUNT_P() async{
    GETAANOCOUNT(AMMID!,AMKID!,SelectDataAANO.toString()).then((data) {
      ACC_MOV_D = data;
      if (ACC_MOV_D.isNotEmpty) {
        AANOCOUNT = ACC_MOV_D.elementAt(0).AANOCOUNT.toString();
      }else{
        AANOCOUNT='0';
      }
    });
  }


  //البيان الافتراضي عند ادخال السندات
  Future GETDefaultDescription_Voucher() async {
    GET_SYS_VAR( (AMKID==2 && PKID==1) ? 382 : (AMKID==2 && PKID!=1) ? 396 : (AMKID!=2 && PKID==1) ? 381 :395 ).then((data) {
      SYS_VAR = data;
      if (SYS_VAR.isNotEmpty && AMKID!=15) {
        AMMINController.text = '${SYS_VAR.elementAt(0).SVVL.toString()} ';
        AMMINCHECK = '${SYS_VAR.elementAt(0).SVVL.toString()} ';
      }
      else {
        AMMINController.text = '';
      }
      AANADetails='';
    });
  }

  //اظهار وصف (بدل فاقد) عند اعادة طباعة السند/الحركه المحاسبيه
  Future GETShowRePrintingVoucher() async {
    GET_SYS_VAR(379).then((data) {
      SYS_VAR = data;
      if (SYS_VAR.isNotEmpty) {
        ShowRePrintingVoucher = SYS_VAR.elementAt(0).SVVL.toString();
      }
      else {
        ShowRePrintingVoucher = '1';
      }
    });
  }

  //صلاحيات شاشة السندات
  Future GET_USR_PRI() async {
    PRIVLAGE(LoginController().SUID,AMKID==15 ? 111 : AMKID==2 ? 103 : 102).then((data) {
      USR_PRI = data;
      if (USR_PRI.isNotEmpty) {
        UPIN = USR_PRI.elementAt(0).UPIN;
        UPCH = USR_PRI.elementAt(0).UPCH;
        UPDL = USR_PRI.elementAt(0).UPDL;
        UPPR = USR_PRI.elementAt(0).UPPR;
        UPQR = USR_PRI.elementAt(0).UPQR;
      }
      else {
        UPIN = 2;
        UPCH = 2;
        UPDL = 2;
        UPPR = 2;
        UPQR = 2;
      }
    });
  }


  //اظهار رصيد الحساب عند طباعة سندات .
  Future GET_Balance_Pay() async {
    GET_SYS_VAR(AMKID==1?217:218).then((data) {
      SYS_VAR = data;
      if (SYS_VAR.isNotEmpty) {
        Balance_Pay = SYS_VAR.elementAt(0).SVVL;
      } else {
        Balance_Pay = '2';
      }
    });
  }

  //جلب رقم الحركة
  Future GET_AMMNO_P() async {
    var ACC_MOV_M_AMMNO =await GET_AMMNO(AMKID!);
    if(ACC_MOV_M_AMMNO.isNotEmpty){
      AMMNO=ACC_MOV_M_AMMNO.elementAt(0).AMMNO;
    }
  }


  Future GET_BIL_ACC_C_P(String GETAANO,String GETGUID,String GETBIID,String GETSCID) async {
    GET_BIL_ACC_C( GETAANO, GETGUID, GETBIID, GETSCID).then((data) {
      BIL_ACC_C = data;
      if(BIL_ACC_C.isNotEmpty){
        //اجمالي مدين كلي
        BACBMD=double.parse(BIL_ACC_C.elementAt(0).BACBMD.toString());
        // اجمالي دائن كلي
        BACBDA=double.parse(BIL_ACC_C.elementAt(0).BACBDA.toString());

        //رصيد الفواتير الغير نهائيه
        BACBNF = double.parse(BIL_ACC_C.elementAt(0).BACBNF.toString());
        // الرصيد الكلي
        BACBA=double.parse(BIL_ACC_C.elementAt(0).BACBA.toString()) + BACBNF;
        // SYMBOL
        // M-مدين
        // D-دائن
        BACBAS=BIL_ACC_C.elementAt(0).BACBAS.toString();
        //مبلغ كتابيا
        BACBAR=BIL_ACC_C.elementAt(0).BACBAR1.toString();
        update();
      }else{
        BACBMD=0;
        BACBDA=0;
        BACBA=0;
        BACBAS='';
        BACBAR='';
      }
      update();
    });
  }

  Future GET_AMMID_P() async {
    var ACC_MOV_M_AMMNO=await GET_AMMID();
    if(ACC_MOV_M_AMMNO.isNotEmpty){
      AMMID=ACC_MOV_M_AMMNO.elementAt(0).AMMID;
      update();
      GET_CountRecode();
      GETSUMAMDEQ();
    }
  }


  Future<void> GET_ACC_MOV_D_P(String GetAMKID, String GetAMMID) async {
    // 1. جلب الحركات الفرعية
    get_ACC_MOV_D = await GET_ACC_MOV_D(GetAMKID, GetAMMID);

    // 2. جلب مجموعاتها (إن احتجت)
    SUM_ACC_MOV_D = await GET_ACC_MOV_D_SUM(GetAMKID, GetAMMID);

    // 3. إذا كانت القائمة غير فارغة، عَبِّئ الرصيد لكل حركة
    if (get_ACC_MOV_D.isNotEmpty) {
      // أسلوب متسلسل
      for (var mov in get_ACC_MOV_D) {
        // استدعاء SUM_BAL للحصول على الـ List<Bil_Mov_M_Local>
        List<Bil_Mov_M_Local> bils = await SUM_BAL(
          2,                // معاملات المثال
          2,
          mov.AMMID,
          mov.AANO,
          mov.SCID,
          LastBAL_ACC_C.toString(),
        );

        // استخراج رصيد الحركة (مثلاً مجموع الحقل amount لكل العناصر)
        mov.balance = bils.map((b) => b.SUM_BAL)              // ابدل amount باسم الحقل الصحيح
            .fold(0.0, (prev, curr) => prev! + curr!);
        print('mov.balance');
        print(mov.balance);
      }

      // — أو — طريقة متوازية للأداء الأفضل:
      /*
    final futures = get_ACC_MOV_D.map((mov) async {
      final bils = await SUM_BAL(
        2, 2, mov.AMMID, mov.AANO, mov.SCID, LastBAL_ACC_C.toString()
      );
      return bils.map((b) => b.amount).fold(0.0, (a, b) => a + b);
    }).toList();

    final balances = await Future.wait(futures);
    for (int i = 0; i < get_ACC_MOV_D.length; i++) {
      get_ACC_MOV_D[i].balance = balances[i];
    }
    */
    }
  }


  // Future GET_ACC_MOV_D_P(String GetAMKID,String GetAMMID) async {
  //   get_ACC_MOV_D= await GET_ACC_MOV_D(GetAMKID,GetAMMID);
  //   SUM_ACC_MOV_D=await GET_ACC_MOV_D_SUM(GetAMKID,GetAMMID);
  //   GET_BAL_APP_P();
  // }

  Future GET_ACC_MOV_D_View_P(String GetAMKID,String GetAMMID) async {
    ListACC_MOV_D=await GET_ACC_MOV_D(GetAMKID,GetAMMID);
    update();
  }

  //جلب رقم الحركة الفرعي
  Future GET_AMDID_P() async {
    ACC_MOV_D=await GET_AMDID(AMKID!,AMMID!);
    if(ACC_MOV_D.isNotEmpty){
      AMDID=ACC_MOV_D.elementAt(0).AMDID;
    }
  }


  //جلب تذلبل المستندات
  Future GET_SYS_DOC_D_P() async {
    Get_SYS_DOC_D('AC',AMKID!=2 ? 1 :AMKID==15 ? 15: 2,LoginController().BIID).then((data) {
      GET_SYS_DOC = data;
      if (GET_SYS_DOC.isNotEmpty) {
        if (GET_SYS_DOC.elementAt(0).SDDST1 == 1 &&
            GET_SYS_DOC.elementAt(0).SDDDA_D.toString().isNotEmpty) {
          SDDDA = GET_SYS_DOC.elementAt(0).SDDDA_D.toString();
          SDDDA != 'null' ? SDDDA = SDDDA : SDDDA = '';
        } else {
          SDDDA = '';
        }
        if (GET_SYS_DOC.elementAt(0).SDDST2 == 1 &&
            GET_SYS_DOC.elementAt(0).SDDSA_D.toString().isNotEmpty) {
          SDDSA = GET_SYS_DOC.elementAt(0).SDDSA_D.toString();
          SDDSA != 'null' ? SDDSA = SDDSA : SDDSA = '';
        } else {
          SDDSA = '';
        }
        print(SDDSA);
      }
    });
  }

  GETSUMAMDEQ() async {
    var SUM_MOUNT=await CountAMMAM(AMMID.toString(),AMKID!);
    if(SUM_MOUNT.isEmpty){
      AMMAMController.text ='0.0';
      AMDEQController.text ='0.0';
      AMDEQSController.text ='0.0';
      SUMAMDAController.text ='0.0';
      loading(false);
      update();
    }
    AMMAMController.text=(AMKID==2 || AMKID==15) ? SUM_MOUNT.elementAt(0).SUMAMDMD.toString():SUM_MOUNT.elementAt(0).SUMAMDDA.toString();
    SUMAMDAController.text=SUM_MOUNT.elementAt(0).SUMAMDDA.toString();
    AMKID!=15?
    AMDEQController.text= roundDouble((double.parse(SUM_MOUNT.elementAt(0).SUMAMDEQ.toString())),2).toString():null;
    AMKID!=15?
    AMDEQSController.text= formatter.format(roundDouble(
        (double.parse(SUM_MOUNT.elementAt(0).SUMAMDEQ.toString())),2)).toString():null;
    SUMAMDEQ_BYAMDTY_P(1);
    SUMAMDEQ_BYAMDTY_P(2);
    update();
  }

  SUMAMDEQ_BYAMDTY_P(int AMDTY) async {
    var SUMAMDEQ=await SUMAMDEQ_BYAMDTY(AMMID.toString(),AMDTY);
    if(SUMAMDEQ.isEmpty){
      AMDTY==2?SUMAMDEQ_MD =0.0:SUMAMDEQ_DA =0.0;
      update();
    }
    AMDTY==2?
    SUMAMDEQ_MD=roundDouble((double.parse(SUMAMDEQ.elementAt(0).SUMAMDEQ.toString())),2):
    SUMAMDEQ_DA=roundDouble((double.parse(SUMAMDEQ.elementAt(0).SUMAMDEQ.toString())),2);
    Difference_AMDEQ_MD_DA=SUMAMDEQ_MD-SUMAMDEQ_DA;
    update();
  }

  //جلب الفروع
  Future GET_BRA_INF_P() async {
    GET_BRA_ONE_CHECK(LoginController().BIID_Voucher).then((data) {
      BRA_INF = data;
      if(BRA_INF.isNotEmpty){
        LoginController().BIID_Voucher != 0
            ? SelectDataBIID = LoginController().BIID_Voucher.toString()
            : BRA_INF.elementAt(0).BIID.toString();
        update();
      }
      else{
        GET_BRA_ONE(1).then((data) {
          BRA_INF = data;
          if(BRA_INF.isNotEmpty){
            SelectDataBIID=BRA_INF.elementAt(0).BIID.toString();
            update();
          }
        });
      }
      GET_ACC_BAN_P();
      GET_BIL_CRE_C_P();
      GET_ACC_CAS_P();
      GET_BIL_DIS_ONE_P();
      update();
    });
  }

  //جلب الصناديق
  Future GET_ACC_CAS_P() async {
    GET_ACC_CAS_ONE(SelectDataBIID.toString(),SelectDataSCID.toString(),'AC',
        AMKID==3?1:AMKID!,LoginController().ACID_Voucher).then((data) {
      ACC_CAS = data;
      if(ACC_CAS.isNotEmpty){
        LoginController().PKID_Voucher == 1 && LoginController().ACID_Voucher!=0 ?
        SelectDataACID=LoginController().ACID_Voucher.toString():'';
        update();
      }else{
        SelectDataACID=null;
      }
    });
  }

  //جلب البنوك
  Future GET_ACC_BAN_P() async {
    GET_ACC_BAN_ONE(SelectDataBIID.toString(),LoginController().ABID_Voucher).then((data) {
      ACC_BAN_List  = data;
      if(ACC_BAN_List.isNotEmpty){
        LoginController().PKID_Voucher == 9 || LoginController().PKID_Voucher == 2
            ? SelectDataABID=LoginController().ABID_Voucher.toString():'';
      }else{
        SelectDataABID=null;
      }
    });
  }

  //جلب بطائق الائتمان
  Future GET_BIL_CRE_C_P() async {
    GET_BIL_CRE_C_ONE(SelectDataBIID.toString(),LoginController().BCCID_Voucher).then((data) {
      BIL_CRE_C_List  = data;
      if( BIL_CRE_C_List.isNotEmpty){
        LoginController().PKID_Voucher == 8 ? SelectDataBCCID=LoginController().BCCID_Voucher.toString():'';
        update();
      }else{
        SelectDataBCCID=null;
      }
    });
  }

  //جلب المحصل
  Future GET_BIL_DIS_ONE_P() async {
    if (StteingController().Install_BDID == true) {
      GET_BIL_DIS_ONE(SelectDataBIID.toString(), LoginController().BDID_SALE.toString()).then((data) {
        BIL_DIS = data;
        if (BIL_DIS.isNotEmpty) {
          SelectDataBDID = LoginController().BDID_SALE.toString();
          SelectDataBDID2 = BIL_DIS.elementAt(0).BDNA.toString();
          update();
        } else {
          SelectDataBDID = null;
          SelectDataBDID2 = null;
        }
      });
    } else {
      SelectDataBDID = null;
      SelectDataBDID2 = null;
    }
  }

  Future GET_BIL_DIS_NAM_P(String GETBDID) async {
    GET_BIL_DIS_NAM(GETBDID).then((data) {
      BIL_DIS = data;
      if (BIL_DIS.isNotEmpty) {
        SelectDataBDID2 = BIL_DIS.elementAt(0).BDNA.toString();
      }
      update();
    });
  }

  //جلب مراكز التكلفه
  Future GET_ACC_COS_ONE_P() async {
    await GET_ACC_COS_ONE().then((data) {
      if (data.isNotEmpty) {
        SelectDataACNO = data.elementAt(0).ACNO.toString();
      }
      update();
    });
  }

  //اضافة سند
  AddPayOut() {
    if(UPIN==1) {
      formKey.currentState?.reset();
      edit = false;
      CheckBack=0;
      GET_AMMID_P();
      GET_AMMNO_P();
      GET_AMMIN_P();
      GUID = uuid.v4();
      AMKID_TYPE='15';
      LoginController().SET_N_P('TIMER_POST',1);
      AMMAM1Controller.text='0.0';
      AMDEQController.text='0.0';
      AMDEQSController.text='0.0';
      AMMEQController.text='0.0';
      GETDefaultDescription_Voucher();
      GET_BRA_INF_P();
      LoginController().SCID_Voucher != 0
          ? GET_SYS_CUR_ONE_SALE_P(LoginController().SCID_Voucher.toString())
          : GET_SYS_CUR_ONE_PAY_P();
      AMKID == 15 ? PKID=1 : LoginController().PKID_Voucher !=0? PKID=LoginController().PKID_Voucher:PKID=1;
      GET_ACC_CAS_P();

      // P_COSS == '1' || (P_COSS == '4' && UPIN_USE_ACNO == 1)
      //     ? LoginController().ACNO_VOU != 0?
      // SelectDataACNO= LoginController().ACNO_VOU.toString():
      // GET_ACC_COS_ONE_P()
      //     : null;

      // LoginController().SCEX_Voucher != 0.0 ?  SCEXController.text = LoginController().SCEX_Voucher.toString() : SCEXController.text='0';
      // LoginController().SCSY_Voucher!='0' ? SCSY=LoginController().SCSY_Voucher.toString():'';
      // SCSFL=LoginController().SCSFL_SALE ;
      titleScreen = 'StringAdd'.tr;
      Debit=true;
      Get.to(() => const Add_Ed_Pay_Out(),transition: StteingController().isActivateInteractionScreens==true ? Transition.zoom: Transition.noTransition
          ,duration: Duration(milliseconds: 500));
    }
    else{
      Get.snackbar('StringUPIN'.tr, 'String_CHK_UPIN'.tr,
          backgroundColor: Colors.red, icon: const Icon(Icons.error,color:Colors.white),
          colorText:Colors.white,
          isDismissible: true,
          dismissDirection: DismissDirection.horizontal,
          forwardAnimationCurve: Curves.easeOutBack);
      return false;
    }
  }

  //تعديل حركة سند
  EditTreasury(Acc_Mov_M_Local note) {
    if(BYST==2) {
      Get.snackbar('StringByst_Mes'.tr, 'String_CHK_Byst'.tr,
          backgroundColor: Colors.red, icon: const Icon(Icons.error,color:Colors.white),
          colorText:Colors.white,
          isDismissible: true,
          dismissDirection: DismissDirection.horizontal,
          forwardAnimationCurve: Curves.easeOutBack);
    }else {
      if (UPCH == 1) {
        edit = true;
        AMMID = note.AMMID;
        LoginController().SET_N_P('BMMID',note.AMMID!) ;
        AMMNO = note.AMMNO;
        AMMID = note.AMMID;
        AMMST = note.AMMST;
        GUID = note.GUID;
        AMKID_TYPE=note.AMKID.toString();
        SelectDataBIID = note.BIID.toString();
        SelectDataSCID = note.SCID.toString();
        SCEXController.text = note.SCEX.toString();
        SelectDataPKID = note.PKID.toString();
        PKID = int.parse(note.PKID.toString());
        SelectDataACID = (PKID == 1 ? note.ACID.toString() : null);
        SelectDataACNO = note.ACNO.toString().contains('null')?null:note.ACNO.toString();
        SelectDataBDID = note.BDID.toString() == 'null' ? null : note.BDID.toString();
        note.BDID.toString() == 'null' ? SelectDataBDID2 = null : GET_BIL_DIS_NAM_P(note.BDID.toString());
        SelectDataBCCID = (PKID == 8 ? note.BCCID.toString() : null);
        SelectDataABID = (PKID == 9 || PKID == 2 ? note.ABID.toString() : null);
        AMMINController.text = note.AMMIN.toString();
        AMMREController.text = note.AMMRE.toString();
        AMMAMController.text = note.AMMAM.toString();
        AMMEQController.text = note.AMMEQ.toString();
        SelectDays= note.AMMDO.toString().substring(0, 11);
        note.AMMCC.toString()=='1'? ValueAMMCC=true : ValueAMMCC=false;
        //  note.AMMCC.toString()=='1'? AMMAM1Controller.text=formatter.format(double.parse(note.AMMAM.toString())) : AMMAM1Controller.text='0';
        note.AMMCC.toString()=='1'? AMMAM1Controller.text=note.AMMAM.toString().replaceAll(regex, '') : AMMAM1Controller.text='0';
        AMMCNController.text= note.AMMCN.toString();
        titleScreen = 'StringEdit'.tr;
        GETSUMAMDEQ();
        GET_AMMIN_P();
        GET_CountRecode();
        Get.to(() => const Add_Ed_Pay_Out(), arguments: note.AMMID,
            transition: StteingController().isActivateInteractionScreens==true ? Transition.zoom: Transition.noTransition,duration: Duration(milliseconds: 500));
      }
      else {
        Get.snackbar('StringUPCH'.tr, 'String_CHK_UPCH'.tr,
            backgroundColor: Colors.red, icon: const Icon(Icons.error,color:Colors.white),
            colorText:Colors.white,
            isDismissible: true,
            dismissDirection: DismissDirection.horizontal,
            forwardAnimationCurve: Curves.easeOutBack);
      }
    }
  }

  //صلاحيات العملاء
  Future GET_PRIVLAGECUS() async {
    PRIVLAGE(LoginController().SUID,91).then((data) {
      USR_PRI = data;
      if(USR_PRI.isNotEmpty){
        UPINCUS=USR_PRI.elementAt(0).UPIN;
      }else {
        UPINCUS=2;
      }

    });
  }

  //ضرورة تحديد المحصل عند ادخال سند قبض
  Future GET_SHOW_BDID() async {
    GET_SYS_VAR(AMKID == 1 || AMKID == 3  ? 384 : 385).then((data) {
      SYS_VAR = data;
      if (SYS_VAR.isNotEmpty) {
        SHOW_BDID = SYS_VAR.elementAt(0).SVVL;
      }
    });
  }

  String? validateAANO(String value){
    if(value.trim().isEmpty){
      return 'StringvalidateAANO'.tr;
    }
    return null;
  }
  String? validateAMDMD(String value){
    if(value.trim().isEmpty){
      return 'StringvalidateAMDMD'.tr;
    }
    return null;
  }

  //حالة الحفظ
  editMode(BuildContext context) {
    contentFocusNode.unfocus();
    loading(true);
    if (Get.arguments == null && edit == false) {
      if (CountRecodeController.text == '0') {
        Get.snackbar('StringCHK_Save_Err'.tr, 'StringCHK_Save'.tr,
            backgroundColor: Colors.red, icon: const Icon(Icons.error,color:Colors.white),
            colorText:Colors.white,
            isDismissible: true,
            dismissDirection: DismissDirection.horizontal,
            forwardAnimationCurve: Curves.easeOutBack);
      }
      else {
        Save_ACC_MOV_M_P(edit,context);
      }
    } else {
      Save_ACC_MOV_M_P(edit,context);
    }
  }
  //دالة التقريب
  double roundDouble(double value, int places){
    num mod = pow(10.0, places);
    return ((value * mod).round().toDouble() / mod);
  }

  //جلب عدد  السجلات
  GET_CountRecode() async {
    var data=await GET_ROWN1(AMKID.toString(),AMMID.toString());
      if (data.isEmpty) {
        CountRecodeController.text = '0';
      }
      else{
        COUNT_RECODE = data;
        CountRecodeController.text = COUNT_RECODE.elementAt(0).COU.toString();
        // CheckBack=COUNT_RECODE.elementAt(0).COU!;
        UpdateROWN1(int.parse(CountRecodeController.text), AMMID);
        update();
      }

    update();
  }

  //جلب رصيد غير مرحل
  GET_BAL_P(AMMID,AANO,SCID) async {
    SUMBAL_V = 0.0;
    SUM_M = await SUM_BAL(2,1,AMMID,AANO.toString(), SCID,LastBAL_ACC_C.toString());
    if (SUM_M.isEmpty) {
      SUMBAL_V = 0.0;
    } else {
      SUMBAL_V = SUM_M.elementAt(0).SUM_BAL;
      update();
    }
    update();
  }

  //جلب رصيد التطبيق على حسب اخر تزامن
  GET_BAL_APP_P() async {
    if(get_ACC_MOV_D.isNotEmpty){

      for (var mov in get_ACC_MOV_D) {

        //    SUM_BAL(2,1,AMMID,AANO.toString(), SCID,LastBAL_ACC_C.toString());
        // استدعاء جلب الرصيد
        //   SUM_M = await SUM_BAL(2,2,AMMID,AANO.toString(), SCID,LastBAL_ACC_C.toString());
        SUM_M = await SUM_BAL(
            2,2,
            mov.AMMID,
            mov.AANO,
            mov.SCID,
            LastBAL_ACC_C.toString()
        );

        // تعبئة الحقل داخل الموديل
        // mov.balance = bal;
      }

      // GET_BAL_P(get_ACC_MOV_D.elementAt(0).AMMID.toString(),
      //     get_ACC_MOV_D.elementAt(0).AANO.toString(),
      //     get_ACC_MOV_D.elementAt(0).SCID.toString());
    }
  }


  GET_AMMIN_P() async {
    GET_AMMIN_M().then((data) {
      GET_AMMIN = data;
      update();
    });
  }

  GET_AMDIN_P() async {
    GET_AMDIN_M().then((data) {
      GET_AMDIN = data;
      update();
    });
  }

  //حفظ سند رئيسي
  Future<bool> Save_ACC_MOV_M_P(bool TypeSave,BuildContext context) async {
    try {
      STB_N='S1';
      if (SelectDataBIID == null || SelectDataSCID == null ){
        Get.snackbar('StringErrorMes'.tr, 'StringError_MESSAGE'.tr,
            backgroundColor: Colors.red,
            icon: const Icon(Icons.error, color: Colors.white),
            colorText: Colors.white,
            isDismissible: true,
            dismissDirection: DismissDirection.horizontal,
            forwardAnimationCurve: Curves.easeOutBack);
        STB_N='S2';
        return false;
      }
      else if (AMKID!=15 && PKID == 1 && SelectDataACID == null) {
        Fluttertoast.showToast(
            msg: 'StringChi_ACID'.tr,
            toastLength: Toast.LENGTH_LONG,
            textColor: Colors.white,
            backgroundColor: Colors.redAccent);
        return false;
      }
      else if (AMKID!=15 && (PKID == 9 || PKID == 2) && SelectDataABID == null) {
        Fluttertoast.showToast(
            msg: 'StringvalidateABID'.tr,
            toastLength: Toast.LENGTH_LONG,
            textColor: Colors.white,
            backgroundColor: Colors.redAccent);
        return false;
      }
      else if (AMKID!=15 && PKID==8   && SelectDataBCCID== null){
        Fluttertoast.showToast(
            msg: 'StrinError_BCCID_error'.tr,
            toastLength: Toast.LENGTH_LONG,
            textColor: Colors.white,
            backgroundColor: Colors.redAccent);
        return false;
      }
      else if (( ValueAMMCC   && double.parse(AMDEQController.text) != double.parse(AMMEQController.text))
          || (AMKID==15 && Difference_AMDEQ_MD_DA!=0) ){
        Fluttertoast.showToast(
            msg: 'Stringtransactionnot'.tr,
            toastLength: Toast.LENGTH_LONG,
            textColor: Colors.white,
            backgroundColor: Colors.redAccent);
        return false;
      }
      else if (AMKID != 15  && SHOW_BDID == '3' && SelectDataBDID == null) {
        Fluttertoast.showToast(
            msg: 'StringChi_BDID'.tr,
            toastLength: Toast.LENGTH_LONG,
            textColor: Colors.white,
            backgroundColor: Colors.redAccent);
        return false;
      }

      else if (P_COSM=='1' && ((P_COS_SEQ=='1' || P_COS1=='1') && SelectDataACNO== null)) {
        Fluttertoast.showToast(
            msg: 'StringACNO_ERR_ACC_D'.tr,
            toastLength: Toast.LENGTH_LONG,
            textColor: Colors.white,
            backgroundColor: Colors.redAccent);
        return false;
      }
      else {
        if(TypeSave==false){
          SCEXController.text=SCEXController.text.toString().contains('.0') ? double.parse(SCEXController.text).round().toString() :SCEXController.text;
          AMMINController.text=AMKID!=15? AMMINCHECK==AMMINController.text ?
          AMKID==2?"(MOB) ${'StringPayTo'.tr}: ${AANADetails}":
          "(MOB) ${'StringContinuefrom'.tr}: ${AANADetails}":AMMINController.text:AMMINController.text;
          Acc_Mov_M_Local M = Acc_Mov_M_Local(
            ROWN1: int.parse(CountRecodeController.text),
            AMKID: AMKID==15 ? int.parse(AMKID_TYPE.toString()) : AMKID,
            AMMID: AMMID,
            AMMNO: AMMNO,
            PKID:   PKID.toString(),
            AMMDO: '$SelectDays ${DateFormat('HH:mm:ss').format(DateTime.now())}',
            AMMST: AMMST,
            AMMRE: AMMREController.text.isEmpty?AMMNO.toString():AMMREController.text,
            AMMCC: ValueAMMCC==true ? 1 : 2,
            SCID:  int.parse(SelectDataSCID.toString()),
            SCEX:  SCEXController.text,
            AMMAM: AMKID == 15 ? 0.0:(double.parse(ValueAMMCC? AMMAM1Controller.text :AMMAMController.text)),
            AMMEQ:  AMKID == 15 ? 0.0:roundDouble((double.parse(ValueAMMCC? AMMAM1Controller.text :AMMAMController.text)*double.parse(SCEXController.text.toString())),2),
            ACID:  AMKID != 15 && PKID==1 ? int.parse(SelectDataACID.toString()):null,
            ABID:  PKID==9 || PKID==2 ?int.parse(SelectDataABID.toString()):null ,
            BDID:  SelectDataBDID == null ? null : int.parse(SelectDataBDID.toString()),
            AMMCN: AMMCNController.text,
            AMMCD:  PKID==2?DateFormat('dd-MM-yyyy').format(DateTime.now()):null,
            AMMIN: AMMINController.text,
            ACNO:  SelectDataACNO.toString().isEmpty || SelectDataACNO.toString().contains('null') || P_COSM!='1' ? null : SelectDataACNO,
            GUID:  GUID.toString().toUpperCase(),
            SUID:   LoginController().SUID,
            AMMCT:  1,
            DATEI:  DateFormat('dd-MM-yyyy HH:m').format(DateTime.now()),
            AMMDOR: DateFormat('dd-MM-yyyy').format(DateTime.now()),
            DEVI:   LoginController().DeviceName,
            BIID:   SelectDataBIID.toString(),
            BCCID:  PKID == 8 ? int.parse(SelectDataBCCID.toString()): null,
            AMMBR:  1,
            BIIDB:  SelectDataBIID.toString(),
            JTID_L: LoginController().JTID.toString(),
            BIID_L: LoginController().BIID,
            SYID_L: LoginController().SYID,
            CIID_L: LoginController().CIID,
          );
          Save_ACC_MOV_M(M);
        }
        else{
          UpdateACC_MOV_M(AMKID!,AMMID!,AMMST!,'$SelectDays ${DateFormat('HH:mm:ss').format(DateTime.now())}'
              ,SelectDataPKID.toString(),PKID==1?int.parse(SelectDataACID.toString()):null,
              PKID==9 || PKID==2?int.parse(SelectDataABID.toString()):null,
              PKID==8?int.parse(SelectDataBCCID.toString()):null,
              SelectDataACNO.toString().isEmpty || SelectDataACNO.toString().contains('null') ? null : SelectDataACNO,
              SelectDataBDID == null ? null : int.parse(SelectDataBDID.toString()),
              AMKID == 15?0.0:double.parse(AMMAMController.text),
              AMKID == 15?0.0:roundDouble((double.parse(AMMAMController.text.toString())*double.parse(SCEXController.text.toString())),2),
              AMMREController.text,AMMINController.text,AMMCNController.text,
              LoginController().SUID,DateFormat('dd-MM-yyyy HH:m').format(DateTime.now()),LoginController().DeviceName);
        }
        CheckBack = 0;
        STB_N='S3';
        LoginController().SET_N_P('BIID_Voucher',int.parse(SelectDataBIID.toString()));
        LoginController().SET_N_P('SCID_Voucher',int.parse(SelectDataSCID.toString()));
        LoginController().SET_N_P('ACID_Voucher',AMKID != 15 && PKID == 1 ? int.parse(SelectDataACID.toString()):LoginController().ACID_Voucher);
        LoginController().SET_N_P('ABID_Voucher',PKID == 9 || PKID == 2 ? int.parse(SelectDataABID.toString()):LoginController().ABID_Voucher);
        LoginController().SET_N_P('BCCID_Voucher',PKID == 8 ? int.parse(SelectDataBCCID.toString()): LoginController().BCCID_Voucher);
        LoginController().SET_N_P('PKID_Voucher',PKID);
        LoginController().SET_N_P('SCSFL_Voucher',SCSFL);
        LoginController().SET_D_P('SCEX_Voucher',double.parse(SCEXController.text));
        LoginController().SET_P('SCSY_Voucher',SCSY);
        LoginController().SET_P('ACNO_VOU',SelectDataACNO.toString());
        LoginController().SET_N_P('TIMER_POST',0);
        //value ? UpdateACC_MOV_D_SCID(AMKID!,AMMID!,SelectDataSCID.toString(),SCEXController.text): null;
        ClearACC_Mov_M_Data();
        Get.snackbar(
            'StringMesSave'.tr, "${'StringMesSave'.tr}-$AMMID",
            backgroundColor: Colors.green,
            icon: const Icon(Icons.save, color: Colors.white),
            colorText: Colors.white,
            isDismissible: true,
            dismissDirection: DismissDirection.horizontal,
            forwardAnimationCurve: Curves.easeOutBack);
        UpdateStateACC_MOV_D('SyncAll', AMKID.toString(), AMMID.toString(), 2,'','','');
        update();
        formKey.currentState!.save;
        GET_ACC_MOV_M_P('DateNow',AMKID!);
        if(Get.arguments==11){
          Navigator.of(context).pop(false);
          //  Get.back();
          return true;
        }else{
          Get.offNamed('/View_Pay_Out');
          GET_ACC_MOV_M_P('DateNow',AMKID!);
          StteingController().isActivateAutoMoveSync==true?Socket_IP_Connect('SyncOnly', AMMID.toString(),false):false;
          update();
        }
        return true;
      }
    }
    catch (e) {
      Fluttertoast.showToast(
          msg: "${STB_N}-${'StrinError_save_data'.tr}",
          toastLength: Toast.LENGTH_LONG,
          textColor: Colors.white,
          backgroundColor: Colors.redAccent);
      return false;
    }
  }

  //حفظ الحركه الفرعيه
  Future<bool> Save_ACC_MOV_D_P() async {
    try {
      bool isValidate = ADD_EDformKey.currentState!.validate();
      GET_AMDID_P();
      AMDMOController.text == '' ? AMDMOController.text=AMDMOHintController.text : AMDMOController.text=AMDMOController.text;
      if (isValidate == false) {
        loading(true);
      }
      else {
        if (SelectDataAANO == null || AMDMOController.text.trim().isEmpty) {
          Fluttertoast.showToast(
              msg: "StringError_MESSAGE".tr,
              toastLength: Toast.LENGTH_LONG,
              textColor: Colors.white,
              backgroundColor: Colors.redAccent);
          return false;
        }
        else if (!AMDMOController.text.isNum) {
          Fluttertoast.showToast(
              msg: 'StrinReq_SMDFN_NUM'.tr,
              toastLength: Toast.LENGTH_LONG,
              textColor: Colors.white,
              backgroundColor: Colors.redAccent);
          return false;
        }
        else if (double.parse(AMDMOController.text) <= 0.0) {
          Fluttertoast.showToast(
              msg: 'StringNegative_values_are_not_accepted'.tr,
              toastLength: Toast.LENGTH_LONG,
              textColor: Colors.white,
              backgroundColor: Colors.redAccent);
          return false;
        }
        else if ( (ValueAMMCC || ( Multi_CUR=='1' && AMKID==15)) && (SCEX2 < SCLR || SCEX2 > SCHR) ) {
          Fluttertoast.showToast(
              msg: 'StringTheExchangeRateIsIncorrect'.tr,
              toastLength: Toast.LENGTH_LONG,
              textColor: Colors.white,
              backgroundColor: Colors.redAccent);
          return false;
        }
        else if ( (ValueAMMCC || ( Multi_CUR=='1' && AMKID==15)) && SelectDataSCID2==null ) {
          Fluttertoast.showToast(
              msg: 'enter scid',
              toastLength: Toast.LENGTH_LONG,
              textColor: Colors.white,
              backgroundColor: Colors.redAccent);
          return false;
        }
        else if (Repeatingedit==false && RepeatingSameAccount=='3' && int.parse(AANOCOUNT)!=0 ) {
          Fluttertoast.showToast(
              msg: 'StringRepeatingSameAccount'.tr,
              toastLength: Toast.LENGTH_LONG,
              textColor: Colors.white,
              backgroundColor: Colors.redAccent);
          return false;
        }
        else if (Credit==false && Debit==false && AMKID==15 ) {
          Fluttertoast.showToast(
              msg: 'StringSpecifytypeDebitCredit'.tr,
              toastLength: Toast.LENGTH_LONG,
              textColor: Colors.white,
              backgroundColor: Colors.redAccent);
          return false;
        }

        else if ( AACT == 2 && ( (!ValueAMMCC && int.parse(SelectDataSCID.toString())!=1) ||
            (ValueAMMCC && int.parse(SelectDataSCID2.toString())!=1))) {
          Fluttertoast.showToast(
              msg: 'StringCHK_SCID_C'.tr,
              toastLength: Toast.LENGTH_LONG,
              textColor: Colors.white,
              backgroundColor: Colors.redAccent);
        }
        else if ( AACT == 3 && ( (!ValueAMMCC && int.parse(SelectDataSCID.toString())==1) ||
            (ValueAMMCC && int.parse(SelectDataSCID2.toString())==1))) {
          Fluttertoast.showToast(
              msg: 'StringCHK_SCID_C'.tr,
              toastLength: Toast.LENGTH_LONG,
              textColor: Colors.white,
              backgroundColor: Colors.redAccent);
        }
        else if ( AACT == 4 && ( (!ValueAMMCC && int.parse(SelectDataSCID.toString())!=SCID_C) ||
            (ValueAMMCC && int.parse(SelectDataSCID2.toString())!=SCID_C))) {
          Fluttertoast.showToast(
              msg: 'StringCHK_SCID_C'.tr,
              toastLength: Toast.LENGTH_LONG,
              textColor: Colors.white,
              backgroundColor: Colors.redAccent);
        }
        else if ( AACT == 5 && ( (!ValueAMMCC && int.parse(SelectDataSCID.toString())==SCID_C) ||
            (ValueAMMCC && int.parse(SelectDataSCID2.toString())==SCID_C))) {
          Fluttertoast.showToast(
              msg: 'StringCHK_SCID_C'.tr,
              toastLength: Toast.LENGTH_LONG,
              textColor: Colors.white,
              backgroundColor: Colors.redAccent);
        }
        else if (((P_COS1=='1'  && AKID==1) || (P_COS2=='1'  && (AKID==2 || AKID==3))) && SelectDataACNO_D== null) {
          Fluttertoast.showToast(
              msg: 'StringACNO_ERR_ACC_D'.tr,
              toastLength: Toast.LENGTH_LONG,
              textColor: Colors.white,
              backgroundColor: Colors.redAccent);
          return false;
        }
        else if (((P_COS1=='3'  && AKID==1) || (P_COS2=='3'  && (AKID==2 || AKID==3))) && SelectDataACNO_D== null) {
          Fluttertoast.showToast(
              msg: 'StringACNO_ERR_ACC_D'.tr,
              toastLength: Toast.LENGTH_LONG,
              textColor: Colors.white,
              backgroundColor: Colors.redAccent);
          return false;
        }
        else {
          if (AMDIDController.text.isNotEmpty) {
            UpdateACC_MOV_D(
                AMKID, AMMID!, int.parse(AMDIDController.text.toString()),
                SelectDataAANO.toString(),SelectDataAANO.toString(),SelectDataACNO_D.toString(), double.parse(AMDMOController.text), AMDINController.text,AMMREController.text,
                (ValueAMMCC || ( Multi_CUR=='1' && AMKID==15)) ? SelectDataSCID2.toString():SelectDataSCID.toString(),
                (ValueAMMCC || ( Multi_CUR=='1' && AMKID==15)) ? SCEX2.toString(): SCEXController.text,
                roundDouble((double.parse(AMDMOController.text.toString())*
                    double.parse((ValueAMMCC || ( Multi_CUR=='1' && AMKID==15)) ? SCEX2.toString() :
                    SCEXController.text)),2),Debit);
            MES_ADD_EDIT = 'StringED'.tr;
          }
          else  {
            print(SelectDataACNO_D);
            print('SelectDataACNO_D');
            Acc_Mov_D_Local e = Acc_Mov_D_Local(
              AMKID: AMKID==15 ? int.parse(AMKID_TYPE.toString()):AMKID,
              AMMID: AMMID,
              AMDID: AMDID,
              AANO:  SelectDataAANO,
              GUIDC: SelectDataAANO,
              AMDRE: AMMREController.text,
              AMDIN: AMDINController.text,
              SCID:  (ValueAMMCC || ( Multi_CUR=='1' && AMKID==15)) ? SelectDataSCID2  : SelectDataSCID,
              SCEX:  (ValueAMMCC || ( Multi_CUR=='1' && AMKID==15)) ? SCEX2.toString() : SCEXController.text,
              AMDDA: (AMKID == 1 || AMKID == 3)  ? roundDouble(double.parse(AMDMOController.text.toString()),2) :
              (AMKID == 15  && Credit==true && Debit==false) ? roundDouble(double.parse(AMDMOController.text.toString()),2):0.0,
              AMDMD: AMKID == 2  ? roundDouble(double.parse(AMDMOController.text.toString()),2) :
              (AMKID == 15  && Debit==true && Credit==false) ? roundDouble(double.parse(AMDMOController.text.toString()),2):0.0,
              AMDEQ: roundDouble((double.parse(AMDMOController.text.toString())*
                  double.parse(ValueAMMCC || ( Multi_CUR=='1' && AMKID==15) ? SCEX2.toString() : SCEXController.text)),2),
              AMDTY: (AMKID == 2 || AMKID == 15) && Debit==true ? '2' : '1',
              AMDST: '1',
              GUID: uuid.v1(),
              GUIDF: GUID.toUpperCase(),
              AMDKI: 'O',
              AMDVW: 1,
              SYST_L: 0,
              ACNO: SelectDataACNO_D.toString().isEmpty || SelectDataACNO_D.toString().contains('null') ? null : SelectDataACNO_D,
              BIID: BIID_D=='null'?SelectDataBIID.toString():BIID_D,
              SUID:  LoginController().SUID,
              DATEI: DateFormat('dd-MM-yyyy HH:m').format(DateTime.now()),
              DEVI:  LoginController().DeviceName,
              JTID_L: LoginController().JTID,
              BIID_L: LoginController().BIID,
              SYID_L: LoginController().SYID,
              CIID_L: LoginController().CIID,
            );
            Save_ACC_MOV_D(e);
            MES_ADD_EDIT = 'StringAD'.tr;
          }
          GET_AMDID_P();
          CheckBack = 1;
          Repeatingedit = false;
          AANADetails= AANADetails+' - ${AANAController.text} ';
          ClearACC_MOV_D();
          GETSUMAMDEQ();
          GET_CountRecode();

          update();
          Fluttertoast.showToast(
              msg: MES_ADD_EDIT,
              toastLength: Toast.LENGTH_LONG,
              textColor: Colors.white,
              backgroundColor: Colors.green);
          ADD_EDformKey.currentState!.save;
          STB_N='S2';
          if (_autocompleteFocusNode != 'null') {
            _autocompleteFocusNode.requestFocus();
          }
          return true;
        }
      }
    }catch (e) {
      Fluttertoast.showToast(
          msg: "$e ${'StrinError_save_data'.tr}",
          toastLength: Toast.LENGTH_LONG,
          textColor: Colors.white,
          backgroundColor: Colors.redAccent);
      return false;
    }
    return true;

  }

  //تنظيف ACC_Mov_M
  ClearACC_Mov_M_Data() {
    SelectDataBIID = null;
    SelectDataACID = null;
    SelectDataBCCID = null;
    SelectDataPKID = null;
    SelectDataSCID = null;
    SelectDataBDID = null;
    AMMINController.clear();
    AMMCNController.clear();
    AMMREController.clear();
    AMMAMController.clear();
  }
  // ACC_MOV_Dتنظيف
  ClearACC_MOV_D(){
    fetchAutoCompleteData();
    titleAddScreen = 'StringAdd'.tr;
    StringButton = 'StringAdd'.tr;
    SelectDataAANO='';
    SelectDataAANO=null;
    AANAController.text='';
    AMKID==15?SelectDataSCID2='1':SelectDataSCID2=null;
    AMKID==15?SCEX2=1:SCEX2=0.0;
    AMKID==15?SCLR=1:SCLR=0.0;
    AMKID==15?SCHR=1:SCHR=0.0;
    AMDMO=0.0;
    AMDMOController.clear();
    AMDMOSController.clear();
    AMDMOHintController.clear();
    AMDIDController.clear();
    AMDEQController.clear();
    AMDEQSController.clear();
    Debit=false;
    Credit=false;
    AMDINController.text=AMMINController.text;
    fetchAutoCompleteData();
    update();
  }

  //حذف حركة سند فرعي
  bool DeleteACC_MOV_D(String GETAMMID, String GETAMDID) {
    DeleteACC_MOV_D_ONE(GETAMMID, GETAMDID);
    Fluttertoast.showToast(
        msg: 'StringDelete'.tr,
        toastLength: Toast.LENGTH_LONG,
        textColor: Colors.white,
        backgroundColor: Colors.redAccent);
    GETSUMAMDEQ();
    return true;
  }

  //حذف الحركه الرئيسي
  bool DELETE_ACC_MOV(String GetAMMID,int type) {
    if(type==1){
      DELETEACC_MOV_D(AMMID.toString());
      DELETEACC_MOV_M(AMKID.toString(),AMMID.toString());
      Get.snackbar(
          'StringDelete'.tr,
          "${'StringDelete'.tr}-$AMMID",
          backgroundColor: Colors.green,
          icon: const Icon(Icons.delete,color:Colors.white),
          colorText:Colors.white,
          isDismissible: true,
          dismissDirection: DismissDirection.horizontal,
          forwardAnimationCurve: Curves.easeOutBack);
      onInit();
      update();
    }
    else if (type==2){
      DELETEACC_MOV_D(GetAMMID.toString());
      DELETEACC_MOV_M(AMKID.toString(),GetAMMID.toString());
      Get.snackbar(
          'StringDelete'.tr,
          "${'StringDelete'.tr}-$GetAMMID",
          backgroundColor: Colors.green,
          icon: const Icon(Icons.delete,color:Colors.white),
          colorText:Colors.white,
          isDismissible: true,
          dismissDirection: DismissDirection.horizontal,
          forwardAnimationCurve: Curves.easeOutBack);
      onInit();
      update();
    }
    return true;
  }

  void configloading(String MES_ERR) {
    EasyLoading.instance
      ..displayDuration = const Duration(milliseconds: 2000)
      ..indicatorType = EasyLoadingIndicatorType.fadingCircle
      ..loadingStyle = EasyLoadingStyle.custom
      ..indicatorSize = 45.0
      ..radius = 10.0
      ..backgroundColor = Colors.redAccent
      ..indicatorColor = Colors.white
      ..textColor = Colors.white
      ..maskColor = Colors.blue.withOpacity(0.5)
      ..userInteractions = true
      ..dismissOnTap = false;

    EasyLoading.showError(MES_ERR);
  }

  Future<void> Socket_IP_Connect(String TypeSync, String GetAMMID, bool TypeAuto) async {
    await GetCheckCustomerData();

    EasyLoading.instance
      ..displayDuration = const Duration(milliseconds: 2000)
      ..indicatorType = EasyLoadingIndicatorType.fadingCircle
      ..loadingStyle = EasyLoadingStyle.custom
      ..indicatorSize = 45.0
      ..radius = 10.0
      ..progressColor = Colors.white
      ..backgroundColor = Colors.green
      ..indicatorColor = Colors.white
      ..textColor = Colors.white
      ..maskColor = Colors.blue.withOpacity(0.5)
      ..userInteractions = true
      ..dismissOnTap = false;

    if (TypeAuto) {
      EasyLoading.show(status: 'StringWeAreSync'.tr);
    }

    try {
      final socket = await Socket.connect(
        LoginController().IP,
        int.parse(LoginController().PORT),
        timeout: const Duration(seconds: 5),
      );

      print("Socket Connection Successful");
      await SyncCustomerData(TypeSync, GetAMMID, TypeAuto);
      socket.destroy();
    } catch (error) {
      Get.snackbar(
        'StringCHK_Err_Con'.tr,
        'StringCHK_Con'.tr,
        backgroundColor: Colors.red,
        icon: const Icon(Icons.error, color: Colors.white),
        colorText: Colors.white,
        isDismissible: true,
        dismissDirection: DismissDirection.horizontal,
        forwardAnimationCurve: Curves.easeOutBack,
      );

      configloading("StrinError_Sync".tr);
      print("Exception on Socket $error");
    }
  }

  Future<void> GetCheckCustomerData() async {
    ArrLengthCus = await Get_CustomerData_Check();
    update();
  }

  Future<void> AwaitFunc(String TypeSync, String GetAMMID, bool TypeAuto) async {
    int retries = 0;
    while (ArrLengthCus != 0 && retries < 200) {
      await Future.delayed(const Duration(milliseconds: 500));
      print("Checking ArrLengthCus: $ArrLengthCus");

      if (ArrLengthCus == 0) {
        await Future.delayed(const Duration(seconds: 1));
        await SyncACC_MOV_D(TypeSync, GetAMMID, TypeAuto);
        break;
      } else {
        await GetCheckCustomerData();
        update();
        retries++;
      }
    }
  }

  Future<void> SyncCustomerData(String TypeSync, String GetAMMID, bool TypeAuto) async {
    var customerList = await SyncronizationData().FetchCustomerData('SyncAll', '0');

    if (customerList.isNotEmpty) {
      await SyncronizationData().SyncCustomerToSystem(customerList, 'SyncAll', '0', 0, TypeAuto);
      update();
      await AwaitFunc(TypeSync, GetAMMID, TypeAuto);
    } else {
      await SyncACC_MOV_D(TypeSync, GetAMMID, TypeAuto);
    }
  }

  Future<void> SyncACC_MOV_D(String TypeSync, String GetAMMID, bool TypeAuto) async {
    var listD = await SyncronizationData().FetchACC_MOV_DData(
      TypeSync, AMKID.toString(), GetAMMID, '', '', '',
    );

    if (listD.isNotEmpty) {
      await SyncronizationData().SyncACC_MOV_DToSystem(TypeSync, AMKID.toString(), GetAMMID, listD, TypeAuto, '', '', '',
      );

      await Future.delayed(const Duration(seconds: 3));
      GET_ACC_MOV_M_P('DateNow', AMKID!);
    } else if (TypeAuto) {
      configloading("StringNoDataSync".tr);
    }
  }


  //دوال المزامنة ------------

  //-------------------التصميم ------------
  Future<dynamic> buildShowBIL_ACC_C(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    return  Get.defaultDialog(
      title: 'StringDAT_ACC'.tr,
      backgroundColor: Colors.white,
      radius: 30,
      content: Column(children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Text("${'StringAMDMD'.tr}:",
                style: ThemeHelper().buildTextStyle(context, Colors.black87,'M')),
            SizedBox(width: 0.02*height),
            Text(formatter.format(BACBMD).toString(),
                style:ThemeHelper().buildTextStyle(context, Colors.black,'M'))
          ],
        ),
        SizedBox(height: 0.015 * height),
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Text(
              "${'StringAMDDA'.tr}:",
              style: ThemeHelper().buildTextStyle(context, Colors.black87,'M'),
            ),
            SizedBox(width: 0.02*height),
            Text(formatter.format(BACBDA).toString(),
              style: ThemeHelper().buildTextStyle(context, Colors.black,'M'),
            ),
          ],
        ),
        SizedBox(height: 0.015 * height),
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Text(
              "${'StringBalance_Not_Final'.tr}:",
              style: ThemeHelper().buildTextStyle(context, Colors.black87, 'M'),
            ),
            Text(formatter.format(BACBNF).toString(),
                style: ThemeHelper().buildTextStyle(context, Colors.black, 'M')
            ),
          ],
        ),
        SizedBox(height: 0.015 * height),
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Text(
              "${'StringUn_Balance'.tr}:",
              style: ThemeHelper().buildTextStyle(context, Colors.black87, 'M'),
            ),
            Text(formatter.format(SUMBAL_V).toString(),
                style: ThemeHelper().buildTextStyle(context, Colors.black, 'M')
            ),
          ],
        ),
        SizedBox(height: 0.015 * height),
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Text(
              "${'StringCurrent_Balance'.tr}:",
              style: ThemeHelper().buildTextStyle(context, Colors.black87,'M'),
            ),
            SizedBox(width: 0.02 * height),
            Text(formatter.format(BACBA).toString(),
              style: TextStyle(color:
              BACBA==0?Colors.black:BACBAS=='M'?Colors.green:Colors.red, fontWeight: FontWeight.bold ,fontSize: 0.016 * height),
            ),
          ],
        ),
      ]),
      textCancel: 'StringHide'.tr,
      cancelTextColor: Colors.blueAccent,
      // barrierDismissible: false,
    );
  }
//
  displayAddItemsWindo() {
    Get.bottomSheet(
      StatefulBuilder(builder: (BuildContext context, StateSetter setState) {
        double width = MediaQuery.of(context).size.width;
        double height = MediaQuery.of(context).size.height;
        return GetBuilder<Pay_Out_Controller>(
            init: Pay_Out_Controller(),
            builder: ((controller) => SafeArea(
              child: Form(
                key: ADD_EDformKey,
                child: SingleChildScrollView(
                  child: Column(
                    //mainAxisSize: MainAxisSize.min,
                    children: [
                      Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.only(
                            topRight: Radius.circular(0.02*height),
                            topLeft: Radius.circular(0.02*height),
                          ),
                          color: Colors.white,
                        ),
                        child: Column(
                          children: [
                            Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.only(
                                  topRight: Radius.circular(0.02*height),
                                  topLeft: Radius.circular(0.02*height),
                                ),
                                color: Colors.grey,
                              ),
                              width: double.infinity,
                              padding: EdgeInsets.symmetric(
                                  horizontal: 0.01 * height),
                              child: Center(
                                child: Text(titleAddScreen,
                                    style: ThemeHelper().buildTextStyle(context, Colors.white,'L')),
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.only(right: 0.05 * width,left:0.05 * width),
                              child: Column(
                                children: [
                                  if(AMKID==15)
                                    Card(
                                      elevation: 2,
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(0.02*width),
                                      ),
                                      clipBehavior: Clip.antiAliasWithSaveLayer,
                                      child: Container(
                                          width: double.infinity,
                                          color: Colors.white,
                                          child: Row(
                                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                                            children: <Widget>[
                                              Row(children: [
                                                Switch(
                                                  value: Debit,
                                                  activeColor: AppColors.MainColor,
                                                  onChanged: (value) {
                                                    Repeatingedit!=true ?
                                                    setState(() {
                                                      Debit=value;
                                                      if(value==true){
                                                        Credit=false;
                                                      }
                                                      else{
                                                        Credit=true;
                                                      }
                                                    }):
                                                    false;
                                                  },
                                                ),
                                                ThemeHelper().buildText(context,'StringAMDMD', Colors.black,'M'),
                                              ],),
                                              Row(children: [
                                                Switch(
                                                  value: Credit,
                                                  activeColor: AppColors.MainColor,
                                                  onChanged: (value) {
                                                    Repeatingedit!=true ?
                                                    setState(() {
                                                      Credit=value;
                                                      if(value==true){
                                                        Debit=false;
                                                      }
                                                      else{
                                                        Debit=true;
                                                      }
                                                    }):false;
                                                  },
                                                ),
                                                ThemeHelper().buildText(context,'StringAMDDA', Colors.black,'M'),
                                              ],),
                                            ],
                                          )
                                      ),
                                    ),
                                  Row(
                                    children: [
                                      Expanded(
                                        child: Autocomplete<Acc_Acc_Local>(
                                          optionsBuilder: (TextEditingValue textEditingValue) {
                                            return autoCompleteData
                                                .where((Acc_Acc_Local county) =>
                                                county.AANA_D.toString().toLowerCase().contains(textEditingValue.text.toLowerCase())).toList();
                                          },  displayStringForOption:
                                            (Acc_Acc_Local option) =>
                                        AANAController.text == '' ? '' : option.AANA_D.toString(),
                                          fieldViewBuilder: (BuildContext context,
                                              textEditingController,
                                              FocusNode myFocus,
                                              VoidCallback onFieldSubmitted) {
                                            _autocompleteFocusNode = myFocus;
                                            return AANAController.text ==
                                                '' ? TextFormField(
                                              controller: textEditingController,
                                              focusNode: myFocus,
                                              validator: (v) {
                                                return validateAANO(v!);
                                              },
                                              style: const TextStyle(
                                                  fontWeight: FontWeight.bold),
                                              textAlign: TextAlign.center,
                                              decoration:  InputDecoration(
                                                labelText: 'StringAccount'.tr,
                                              ),
                                            )
                                                : TextFormField(
                                              controller:
                                              AANAController,
                                              validator: (v) {
                                                return validateAANO(v!);
                                              },
                                              style: const TextStyle(
                                                  fontWeight: FontWeight.bold),
                                              textAlign: TextAlign.center,
                                              decoration: InputDecoration(
                                                suffixIcon: IconButton(
                                                  icon: const Icon(
                                                    Icons.clear,
                                                    color: Colors.black,
                                                  ),
                                                  onPressed: () {
                                                    setState(() {
                                                      setState(() {
                                                        textEditingController.text = "";
                                                        AANAController.clear();
                                                        SelectDataAANO='';
                                                        myFocus.requestFocus();
                                                      });
                                                    });
                                                  },
                                                ),
                                                icon: IconButton(
                                                  icon: const Icon(
                                                    Icons.error,
                                                    color: Colors.black,
                                                  ),
                                                  onPressed: () async{
              
                                                    GET_BIL_ACC_C_P(SelectDataAANO.toString(),'','',SelectDataSCID.toString());
                                                    await Future.delayed(const Duration(milliseconds: 100));
                                                    buildShowBIL_ACC_C(context);
                                                  },
                                                ),
                                                labelText: 'StringAccount'.tr,
                                              ),
                                            );
                                          },
                                          onSelected: (Acc_Acc_Local selection) {
                                            setState(() {
                                              AANAController.text=selection.AANA_D.toString();
                                              SelectDataAANO=selection.AANO.toString();
                                              SelectDataAANO=selection.AANO.toString();
                                              AACT=int.parse(selection.AACT.toString());
                                              SCID_C=selection.SCID;
                                              BIID_D=selection.BIID.toString();
                                              SelectDataACNO_D=SelectDataACNO;
                                              GETAANOCOUNT_P();
                                              GET_AKID_P();
                                              GET_BAL_P(AMMID.toString(),
                                                  selection.AANO.toString(),
                                                  SelectDataSCID.toString());
                                              myFocusNode.requestFocus();
                                            });
                                          },
                                          optionsViewBuilder: (BuildContext context,AutocompleteOnSelected<Acc_Acc_Local>
                                          onSelected, Iterable<Acc_Acc_Local> options) {
                                            return Align(
                                              alignment: Alignment.topLeft,
                                              child: Container(
                                                width: double.infinity,
                                                height: (options.length * 100.0).clamp(150.0, 0.4 * MediaQuery.of(context).size.height),
                                                decoration: BoxDecoration(
                                                  color: Colors.white,
                                                  border: Border.all(color: Colors.grey),
                                                  borderRadius: BorderRadius.circular(8.0),
                                                  boxShadow: [
                                                    BoxShadow(
                                                      color: Colors.grey.withOpacity(0.5),
                                                      spreadRadius: 1,
                                                      blurRadius: 5,
                                                      offset: Offset(0, 3),
                                                    ),
                                                  ],
                                                ),
                                                child: ListView.builder(
                                                  itemCount: options.length,
                                                  itemBuilder:
                                                      (BuildContext context, int index) {
                                                    final Acc_Acc_Local option = options.elementAt(index);
                                                    return GestureDetector(
                                                      onTap: () {
                                                        onSelected(option);
                                                      },
                                                      child: Center(
                                                          child: Padding(
                                                            padding: EdgeInsets.all(0.009 * height),
                                                            child: Text(option.AANA_D.toString(),
                                                                textAlign:
                                                                TextAlign.center,
                                                                style: const TextStyle(
                                                                    color: Colors.black,
                                                                    fontWeight:
                                                                    FontWeight
                                                                        .bold)),
                                                          )),
                                                    );
                                                  },
                                                ),
                                              ),
                                            );
                                          },
                                        ),
                                      ),
                                    ],
                                  ),
                                  TextFormField(
                                    controller: AMDINController,
                                    textAlign: TextAlign.center,
                                    decoration: InputDecoration(
                                        suffixIcon: IconButton(icon: Icon(Icons.error_outline),onPressed: (){
                                          if(controller.GET_AMDIN.isNotEmpty){
                                            buildShowDialogGET_AMDIN(context);
                                          }
                                        }),
                                        labelText: 'StringDetails'.tr,
                                        hintStyle: const TextStyle(
                                            color: Colors.blue)),
                                  ),
                                  SizedBox(height: 0.02 * height),
                                  if( ValueAMMCC ||( Multi_CUR=='1' && AMKID==15))
                                    Column(
                                      children: [
                                        DropdownSYS_CUR2Builder(),
                                        SizedBox(height: 0.02 * height),
                                        // Padding(
                                        //   padding:  EdgeInsets.only(right: 0.02 * height,left:0.02 * height,bottom:0.02 * height ),
                                        //   child: Row(
                                        //     crossAxisAlignment: CrossAxisAlignment.start,
                                        //     children: [
                                        //     Text("${'Stringexchangerate'.tr}    ${SCEX2}",
                                        //               style: TextStyle(fontSize: 0.01 * height)),
                                        //     ],
                                        //   ),
                                        // ),
                                      ],
                                    ),
                                  P_COSM!='1' || ((P_COS1 =='4' ||   P_COS1 =='5') && (P_COS2 =='4' ||   P_COS2 =='5'))
                                      ? Container() :  DropdownACC_COS_DBuilder(),
                                  AMKID==15?  Row(
                                    children: [
                                      ExpandedAMDMO(),
                                      SizedBox(width: 0.08* width),
                                      Expanded(
                                          child: TextFormField(
                                            controller: AMDEQSController,
                                            keyboardType: TextInputType.numberWithOptions(decimal: true),
                                            textAlign: TextAlign.center,
                                            inputFormatters: [
                                              //  FilteringTextInputFormatter.digitsOnly, // للسماح بالأرقام فقط
                                              ThousandsSeparatorInputFormatter(),
                                            ],
                                            onChanged: (v){
                                              if(v.isNotEmpty){
                                                String sanitizedValue = v.replaceAll(',', '');
                                                AMDEQController.text=sanitizedValue.toString();
                                                if(AMKID==15 ){
                                                  SelectDataSCID2.toString()!='1'?
                                                  SCEX2=double.parse(AMDEQController.text)/double.parse(AMDMOController.text): SCEX2=1;
                                                  update();
                                                }
                                              }
                                            },
                                            decoration: InputDecoration(
                                                hintText: AMDMOHintController.text.toString().replaceAll(regex, ''),
                                                labelText: 'StringTotalequivalent'.tr,
                                                hintStyle: const TextStyle(
                                                    color: Colors.blue)),
                                          )),
                                    ],
                                  ): Row(
                                    children: [
                                      ExpandedAMDMO(),
                                      SizedBox(width: 0.08* width),
                                      ContainerSave(context, width, height, setState),
                                    ],
                                  ),
                                  AMKID==15?ContainerSave(context, width, height, setState):Container(),
              
                                  SizedBox(height: 0.02* height),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            )));
      }),
    );
  }

  Container ContainerSave(BuildContext context, double width, double height, StateSetter setState) {
    return Container(
      width: AMKID==15?MediaQuery.of(context).size.width / 1
          :MediaQuery.of(context).size.width / 3,
      margin: EdgeInsets.only(right: 0.02 * width,top: 0.02 * height),
      child: Obx(() {
        return isloading.value ==
            true
            ? ThemeHelper().circularProgress()
            : TextButton(
          //icon: Icon(Icons.add,color:  Colors.black,),
          style: ButtonStyle(
            shape: WidgetStateProperty.all<
                RoundedRectangleBorder>(
                RoundedRectangleBorder(
                    borderRadius:
                    BorderRadius.circular(
                        0.02 * height),
                    side: const BorderSide(
                        color: Colors
                            .black45))),
            padding: WidgetStateProperty
                .all<EdgeInsets>(
                EdgeInsets.only(
                    left: 0.02 * height,
                    right: 0.02 * height)),
          ),
          child: Text(
              StringButton,
              style:  ThemeHelper().buildTextStyle(context, Colors.black,'M')
          ),
          onPressed: () async {
            GETAANOCOUNT_P();
            if (Repeatingedit==false && RepeatingSameAccount=='1' && int.parse(AANOCOUNT)!=0) {
              Get.defaultDialog(
                title: 'StringMestitle'.tr,
                middleText: 'StringRepeatingSameAccount'.tr,
                backgroundColor:
                Colors.white,
                radius: 40,
                textCancel: 'StringNo'.tr,
                cancelTextColor:
                Colors.red,
                textConfirm: 'StringYes'.tr,
                confirmTextColor:
                Colors.white,
                onConfirm: () {
                  Navigator.of(context).pop(false);
                  setState(() async {
                    GET_AMDID_P();
                    await Future.delayed(const Duration(milliseconds: 10));{
                      Save_ACC_MOV_D_P();
                    }
                  });
                },
                barrierDismissible: false,
              );
            }
            else{
              GET_AMDID_P();
              await Future.delayed(const Duration(milliseconds: 10));{
                Save_ACC_MOV_D_P();
              }
            }

          },
        );
      }),
    );
  }

  Expanded ExpandedAMDMO() {
    return Expanded(
        child: TextFormField(
          controller: AMDMOSController,
          keyboardType: TextInputType.numberWithOptions(decimal: true),
          textAlign: TextAlign.center,
          focusNode: myFocusNode,
          inputFormatters: [
            //   FilteringTextInputFormatter.digitsOnly, // للسماح بالأرقام فقط
            ThousandsSeparatorInputFormatter(),
          ],
          onChanged: (v){
            if(v.isNotEmpty){
              String sanitizedValue = v.replaceAll(',', '');
              AMDMO=double.parse(sanitizedValue);
              AMDMOController.text=sanitizedValue.toString();
              if(ValueAMMCC ){
                SelectDataSCID2.toString()!='1'?
                SCEX2=double.parse(AMMEQController.text)/double.parse(AMDMOController.text): SCEX2=1;
              }
              if(AMKID==15 ){
                AMDEQController.text=roundDouble((double.parse(AMDMOController.text.toString())*
                    double.parse(ValueAMMCC || ( Multi_CUR=='1' && AMKID==15) ? SCEX2.toString() : SCEXController.text)),2).toString();
                AMDEQSController.text=formatter.format(roundDouble(
                    (double.parse(AMDMOController.text.toString())*
                        double.parse(ValueAMMCC || ( Multi_CUR=='1' && AMKID==15) ? SCEX2.toString() : SCEXController.text)),2)).toString();
                print('onChanged');
                print(AMDEQController.text);
                print('onChanged');
                SelectDataSCID2.toString()!='1'?
                SCEX2=double.parse(AMDEQController.text)/double.parse(AMDMOController.text): SCEX2=1;
              }
              update();
            }else{
              AMDMO=0;
              AMDMOController.text='0';
            }
          },
          decoration: InputDecoration(
              hintText: AMDMOHintController.text.toString().replaceAll(regex, ''),
              labelText: 'StringAmount'.tr,
              hintStyle: const TextStyle(
                  color: Colors.blue)),
        ));
  }

  FutureBuilder<List<Acc_Cos_Local>> DropdownACC_COS_DBuilder() {
    return FutureBuilder<List<Acc_Cos_Local>>(
        future: GET_ACC_COS(),
        builder: (BuildContext context,
            AsyncSnapshot<List<Acc_Cos_Local>> snapshot) {
          if (!snapshot.hasData) {
            return Dropdown(josnStatus: josnStatus,GETSTRING: 'StringBrach',);
          }
          return DropdownButtonFormField2(
            decoration: ThemeHelper().InputDecorationDropDown('StringCostCenters'.tr),
            isExpanded: true,
            hint: ThemeHelper().buildText(context,'StringChi_ACNO', Colors.grey,'S'),
            value: SelectDataACNO_D,
            style: ThemeHelper().buildTextStyle(context, Colors.black,'M'),
            items: snapshot.data!.map((item) => DropdownMenuItem<String>(
              value: item.ACNO.toString(),
              child: Text(
                item.ACNA_D.toString(),
                style: ThemeHelper().buildTextStyle(context, Colors.black,'M'),
              ),
            )).toList().obs,
            onChanged: (value) {
              SelectDataACNO_D = value.toString();
            },
          );
        });
  }

  FutureBuilder<List<Sys_Cur_Local>> DropdownSYS_CUR2Builder() {
    return FutureBuilder<List<Sys_Cur_Local>>(
        future: GET_SYS_CURVou(ValueAMMCC?1:2,SelectDataSCID),
        builder: (BuildContext context,
            AsyncSnapshot<List<Sys_Cur_Local>> snapshot) {
          if (!snapshot.hasData) {
            return Dropdown(josnStatus: josnStatus,GETSTRING: 'StringChi_currency'.tr,);
          }
          return DropdownButtonFormField2(
            decoration: ThemeHelper().InputDecorationDropDown(" ${'StringSCIDlableText'.tr} ${'Stringexchangerate'.tr}    ${SCEX2}"),
            isExpanded: true,
            hint: ThemeHelper().buildText(context,'StringChi_currency', Colors.grey,'S'),
            value: SelectDataSCID2,
            style: ThemeHelper().buildTextStyle(context, Colors.black,'M'),
            items: snapshot.data!.map((item) => DropdownMenuItem<String>(
              value: item.SCID.toString(),
              onTap: () {
                SCEX2= item.SCEX!;
                SCHR= item.SCHR!;
                SCLR= item.SCLR!;
                if(ValueAMMCC){
                  AMDMOHintController.text= roundDouble(((double.parse(AMMEQController.text)/item.SCEX!)),2).toString();
                  item.SCID.toString()!='1'?
                  SCEX2=double.parse(AMMEQController.text)/double.parse(AMDMOHintController.text):
                  SCEX2=1;
                }
                print('SCEX2');
                print(SCEX2);
                myFocusNode.requestFocus();
                update();
              },
              child: Text(
                item.SCNA_D.toString(),
                style: ThemeHelper().buildTextStyle(context, Colors.black,'M'),
              ),
            )).toList().obs,
            validator: (v) {
              if (v == null) {
                return 'StringvalidateSCID'.tr;
              }
              ;
              return null;
            },
            onChanged: (value) {
              AMDMOController.text='';
              AMDMOSController.text='';
              AMDMO=0;
              SelectDataSCID2 = value.toString();
            },
          );
        });
  }

  Future<dynamic> buildShowDialogGET_AMDIN(BuildContext context) {
    return Get.defaultDialog(
      title: "StringDetails".tr,
      content:Container(
        width: 210,
        height: 180,
        child: ListView.separated(
          shrinkWrap: true,
          itemCount: GET_AMDIN.length,
          itemBuilder: (context,index){
            return GestureDetector(
              child: Text(GET_AMDIN[index].AMDIN.toString()),
              onTap: (){
                AMDINController.text=GET_AMDIN[index].AMDIN.toString();
                update();
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
