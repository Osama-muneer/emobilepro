import 'dart:async';
import 'dart:io';
import 'dart:math';
import 'package:barcode_scan2/barcode_scan2.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:intl/intl.dart' as intl;
import 'package:uuid/uuid.dart';
import '../../Packages/ES_MAT_PKG.dart';
import '../../Setting/controllers/login_controller.dart';
import '../../Setting/controllers/setting_controller.dart';
import '../../Setting/models/acc_acc.dart';
import '../../Setting/models/bra_yea.dart';
import '../../Setting/models/mat_gro.dart';
import '../../Setting/models/mat_inf.dart';
import '../../Setting/models/mat_pri.dart';
import '../../Setting/models/mat_uni_b.dart';
import '../../Setting/models/mat_uni_c.dart';
import '../../Setting/models/sto_num.dart';
import '../../Setting/models/sys_doc_d.dart';
import '../../Setting/models/sys_own.dart';
import '../../Setting/models/sys_var.dart';
import '../../Setting/models/sys_yea.dart';
import '../../Setting/models/usr_pri.dart';
import '../../Setting/services/syncronize.dart';
import '../../Widgets/config.dart';
import '../../Widgets/dropdown.dart';
import '../../Widgets/theme_helper.dart';
import '../../database/database.dart';
import '../../database/inventory_db.dart';
import '../../database/setting_db.dart';
import '../Views/Inventory/add_edit_inventory.dart';
import '../Views/Inventory/datagrid_inventory.dart';
import '../models/inventory.dart';
import '../models/sto_mov_m.dart';

List<Sto_Mov_D_Local> get_item=[];

class InventoryController extends GetxController {
  //TODO: Implement HomeController
  final formatter = intl.NumberFormat.decimalPattern();
  final ES_MAT_PKG ES_MAT = ES_MAT_PKG();
  String _scanBarcode = 'Unknown';
  late FocusNode myFocusNode;
  late FocusNode myFocus;
  late FocusNode myFocusSMMAM;
  late FocusNode myFocusSMDFN;
  var isloading = false.obs;
  var isloadingvalidator = false.obs;
  RxBool loading = false.obs;

  var uuid = Uuid();
  String? SelectDataBIID,SelectDataSIID,SelectDataMINO,SelectDataMUID,SelectDataMUCNA,SER_MINA,
      SelectDataSNED="01-01-2900",SelectDataACNO,SelectDays,SMMRD,SelectDataSIID_F,SelectDataSIID_T,
      SelectDataAANO,SelectDataAANA, SelectDataSCID,AANA='',SelectDataMGNA,SelectDataBIID_T;
  final conn = DatabaseHelper.instance;
  final String selectedDatesercher = DateFormat('dd-MM-yyyy').format(DateTime.now());
  // yyyy-MM-dd hh:mm:ss
  DateTime dateTimeDays = DateTime.now();
  DateTime dateTimeDays2 = DateTime.now();
 // GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final ADD_EDformKey = GlobalKey<FormState>();
  var GUID,GUIDD;

  late TextEditingController
  MGNOController,
      MINOController,
      MUIDController,
      MINAController,
      SMDNFController,
      SMDNFHintController,
      SMDNOController,
      SMMIDController,
      SMMNOController,
      SMKIDController,
      SMMDOController,
      SMMSTController,
      SMDIDController,
      SMMINController,
      SMDEDController,
      CountController,
      CountRecodeController,
      MPCOController,
      MPCO_VController,
      UPDATEController,
      MGNAController,
      SMMREController,
      SMDAMController,
      SMMAMTOTController,
      SMMDRController,
      SMMCNController,
      TextEditingSercheController;

  late List<STO_MOV_M_Local> STO_MOV_M_List = [];
  late List<STO_MOV_M_Local> STO_MOV_M_PRINT = [];
  late List<Sto_Mov_D_Local> STO_MOV_D_PRINT = [];
  late List<STO_MOV_M_Local> get_item22 = [];
  late List<Acc_Acc_Local> ACC_ACC_LIST;
  final Sto_Num_List = <Sto_Num_Local>[].obs;
  late List<Mat_Gro_Local> Mat_Gro_List = [];

  String titleScreen = '',titleAddScreen = '',TextButton_T = '',MES_ADD_EDIT='',Keyword = '',BINA='',SCID='',
      SUCH='',DEVI='',DEVU='',DATEU='',SINA = '',SDDSA='',SDDDA='',SONA='',SONE='',SORN='',SOLN='',SOAD='',SYED='',
      SelectNumberOfDays='',MGNO = '',MGNA='',Date_of_Insert='2',SINA_F='',SINA_T='',SCSY='',
      P_COSM='1', P_COS='1',P_COS1='2', P_COS2='2',P_COSS='2',P_COS_SEQ='2',P_PR_REP='2';

  double? SMDDF,SMDAM,HINT,SUM,SCEX,SMMAM=0,  MPS1 = 0, MPHP = 0, MPLP = 0,SCEXS, MUCNO = 0, MPCO_V = 0,
      CHIN_NO = 1, V_N1 = 0,   BMDNO = 0,MPCO,SUMSMMDIF=0,SMMAMTOT=0,BDNO_F = 0;

  int? SMMID,SMDID,SMMNO,CheckBack=0,Count=0,UPIN=1,UPCH=1,UPQR=1,UPDL=1,UPPR=1,Countrecode=0,CheckSearech,
      BYST=1,UPIN2=1,UPCH2=1,UPQR2=1,UPDL2=1,UPPR2=1,DEL_SMMID,COUNT_SNNO,SMKID=17,
      Allow_to_Inserted_Date=1,MAX_MIN_MUCID = 1, MUCID_F, MUCID_T, MUID, V_FROM, V_TO, V_KIN,
      Allow_USE_Cost_Cen=1,AKID=1,AACC=1,UPIN_OUT,MIED;

  int SMMST=2,NUM_INV_MINO=0,GET_MGNO=0, SCSFL = 2;

  bool edit = false;

  FocusNode contentFocusNode = FocusNode();
  late List<Mat_Inf_Local> autoCompleteData;
  late List<Mat_Inf_Local> MAT_INF;
  late List<Mat_Gro_Local> MAT_GRO;
  late List<Mat_Uni_B_Local> barcodData;
  late List<Sto_Num_Local> GET_STO_NUM_LIST;
  late List<Sto_Mov_D_Local> SUM_COUNT;
  late List<Sto_Mov_D_Local> MAX_SMDID;
  late List<Sto_Mov_D_Local> COUNT_RECODE;
  late List<Sto_Mov_D_Local> NUM_INV_MINO_L;
  late List<Usr_Pri_Local> USR_PRI;
  late List<Sys_Var_Local> SYS_VAR;
  late List<Mat_Pri_Local> MAT_PRI;
  late List<Sto_Num_Local> GET_SNDE;
  late List<Sys_Doc_D_Local> GET_SYS_DOC;
  late List<Sys_Own_Local> SYS_OWN;
  late List<Sys_Yea_Local> SYS_YEA;
  late List<Bra_Yea_Local> BRA_YEA;
  late List<Sto_Mov_D_Local> DEL_STO_MOV_D;
  late List<Mat_Inf_Local> GET_DownLoad_STO_MOV_D;

  @override
  void onInit() async {
    (Get.arguments == 13 || SMKID == 13) ? SMKID = 13
        : (Get.arguments == 1 || SMKID == 1) ? SMKID = 1
        : (Get.arguments == 3 || SMKID == 3) ? SMKID = 3
        : (Get.arguments == 11 || SMKID == 11) ? SMKID = 11
        : (Get.arguments == 131 || SMKID == 131) ? SMKID = 131
        : (Get.arguments == 0 || SMKID == 0) ? SMKID = 0
        : SMKID = 17;
    MINOController = TextEditingController();
    MGNOController = TextEditingController();
    SMDNOController = TextEditingController();
    SMDNFController = TextEditingController();
    SMDNFHintController = TextEditingController();
    MINAController = TextEditingController();
    SMMIDController = TextEditingController();
    SMMNOController = TextEditingController();
    SMMDOController = TextEditingController();
    SMMSTController = TextEditingController();
    SMMINController = TextEditingController();
    SMKIDController = TextEditingController();
    MUIDController = TextEditingController();
    SMDIDController = TextEditingController();
    CountController = TextEditingController();
    SMDEDController = TextEditingController();
    MPCOController = TextEditingController();
    MGNAController = TextEditingController();
    CountRecodeController = TextEditingController();
    UPDATEController = TextEditingController();
    SMMREController = TextEditingController();
    SMDAMController = TextEditingController();
    MPCO_VController = TextEditingController();
    SMMAMTOTController = TextEditingController();
    SMMDRController = TextEditingController();
    SMMCNController = TextEditingController();
    TextEditingSercheController = TextEditingController();
    GETSTO_MOV_M_P("DateNow");
    GET_BRA_YEA_P();
    USE_SCID_P();
    // USE_SMDED_P();
    GET_PRIVLAGE();
    GET_SYS_DOC_D();
    GET_Sys_Own();
    GET_USR_PRI();
    CHK_YEA();
    GET_Date_of_Insert();
    GET_USE_Cost_Centers();
    GET_USE_Linking_Accounts_Cost_Centers();
    GET_USE_Linking_Income_Accounts_Cost_Centers();
    GET_USE_Cost_Cen();
    GET_COS_SEQ();
    GET_Allow_Update_Price_Items_Out_Vouchers();
    Print_Price_Inventory_REP();
    myFocusNode = FocusNode();
    myFocusSMMAM = FocusNode();
    myFocus = FocusNode();
    myFocusSMDFN = FocusNode();
    SER_MINA = '';
    Delete_Sto_Mov_D_DetectApp();
    super.onInit();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    MINOController.dispose();
    MGNOController.dispose();
    SMDNFController.dispose();
    SMDNFHintController.dispose();
    SMDNOController.dispose();
    SMMIDController.dispose();
    SMMNOController.dispose();
    SMMDOController.dispose();
    SMMSTController.dispose();
    SMMINController.dispose();
    SMKIDController.dispose();
    MUIDController.dispose();
    SMDIDController.dispose();
    SMDEDController.dispose();
    MPCOController.dispose();
    UPDATEController.dispose();
    myFocusNode.dispose();
    myFocus.dispose();
    myFocusSMMAM.dispose();
    myFocusSMDFN.dispose();
    CountController.dispose();
    CountRecodeController.dispose();
    SMMREController.dispose();
    SMDAMController.dispose();
    MPCO_VController.dispose();
    SMMAMTOTController.dispose();
    SMMDRController.dispose();
    SMMCNController.dispose();
    TextEditingSercheController.dispose();
    super.dispose();
  }

  //جلب الاصناف
  Future fetchAutoCompleteData() async {
    autoCompleteData= await
    Get_MAT_INF(SMKID==0?1:SMKID!,SelectDataSIID.toString(),SelectDataSIID_T.toString(),MGNOController.text);
    update();
  }


  Future<void> selectDateFromDays2(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
        context: context,
        initialDate:  dateTimeDays,
        firstDate: DateTime(2022,5),
        lastDate: DateTime(2050));

    if (picked != null ) {
      dateTimeDays = picked;
      SMDEDController.text =  dateTimeDays.toString().split(" ")[0];
      SelectDataSNED =  dateTimeDays.toString().split(" ")[0];

      update();
    }
  }


  Future GETAANA_P(GETAANO) async{
    GETAANOCOUNT(SelectDataAANO.toString()).then((data) {
      ACC_ACC_LIST = data;
      if (ACC_ACC_LIST.isNotEmpty) {
        AANA = ACC_ACC_LIST.elementAt(0).AANA_D.toString();
      }else{
        AANA='';
      }
    });
  }


  //طباعة السعر في تقارير الحركه المخزنيه
  Future Print_Price_Inventory_REP() async {
    GET_SYS_VAR(985).then((data) {
      SYS_VAR = data;
      if (data.isNotEmpty) {
        P_PR_REP =  data.elementAt(0).SVVL.toString();
      } else {
        P_PR_REP = '2';
      }
    });
  }

  //1444
  //صلاحيات الجرد المخزني
  Future GET_PRIVLAGE() async {
    var USR_PRI= await PRIVLAGE(LoginController().SUID,SMKID==17?1501:SMKID==13?
    1444:SMKID==1?1421:SMKID==11?1442:SMKID==131?1446:SMKID==0?1544:1401);
    print(USR_PRI);
    print(UPIN);
    print('UPIN2');
    if(USR_PRI.isNotEmpty){
      UPIN=USR_PRI.elementAt(0).UPIN;
      UPCH=USR_PRI.elementAt(0).UPCH;
      UPDL=USR_PRI.elementAt(0).UPDL;
      UPPR=USR_PRI.elementAt(0).UPPR;
      UPQR=USR_PRI.elementAt(0).UPQR;
      print(UPIN);
      print('UPIN');
    }else {
      UPIN=2;UPCH=2;UPDL=2;UPPR=2;UPQR=2;
    }

  }

  //جلب الكمية للصرف المخزني
  Get_STO_NUM_Out_Voucher(String StringMUID) async {
    GET_SNNO_INVC(SelectDataBIID.toString(), int.parse(SelectDataSIID_F.toString()),
        MGNOController.text.toString(), SelectDataMINO.toString(),
        StringMUID, MIED.toString(), SMKID==1 || SMKID==2 || SMKID==0 ?
        SMDEDController.text:SelectDataSNED.toString()).then((data) {
      if (data.isNotEmpty) {
        GET_STO_NUM_LIST = data;
        BDNO_F = double.parse(GET_STO_NUM_LIST.elementAt(0).SNNO.toString());
      } else {
        BDNO_F = 0;
      }
    });
    SMDNFHintController.text=BDNO_F.toString();
    print(SMDNFHintController.text);
    print('SMDNFHintController.text');
    update();
  }

  //الاطلاع على سعر التكلفه في الجرد
  Future GET_USR_PRI() async {
    PRIVLAGE(LoginController().SUID,1510).then((data) {
      USR_PRI = data;
      if(USR_PRI.isNotEmpty){
        UPIN2=USR_PRI.elementAt(0).UPIN;
        UPCH2=USR_PRI.elementAt(0).UPCH;
        UPDL2=USR_PRI.elementAt(0).UPDL;
        UPPR2=USR_PRI.elementAt(0).UPPR;
        UPQR2=USR_PRI.elementAt(0).UPQR;

      }else {
        UPIN2=2;UPCH2=2;UPDL2=2;UPPR2=2;UPQR2=2;
      }
    });
  }

  // //جلب صلاحية استخدام تاريخ الانتهاء
  // Future USE_SMDED_P() async {
  //   GET_SYS_VAR(976).then((data) {
  //     SYS_VAR = data;
  //     if(MIED==1 && SMKID!=17){
  //       SelectDataSNED==null;
  //       SMDEDController.text=='null';
  //       print(MIED);
  //       print('MIED');
  //     }
  //     else{
  //       if(SYS_VAR.isNotEmpty){
  //         SMDED=SYS_VAR.elementAt(0).SVVL.toString();
  //         if(SMDED=='2'){
  //           SelectDataSNED=='01-01-2900';
  //           SMDEDController.text=='01-01-2900';
  //         }
  //         print(SMDED);
  //         print('SMDED');
  //       }
  //     }
  //
  //   });
  // }

  //التأكد من السنة المالية من انه فعالة

  Future GET_BRA_YEA_P() async {
    GET_BRA_YEA(LoginController().JTID, LoginController().BIID, LoginController().SYID).then((data) {
      BRA_YEA = data;
      if(BRA_YEA.isNotEmpty){
        BYST=BRA_YEA.elementAt(0).BYST;
      }
    });
  }

  //تاريخ ادخال حركات
  Future GET_Date_of_Insert() async {
    GET_SYS_VAR(654).then((data) {
      SYS_VAR = data;
      if (SYS_VAR.isNotEmpty) {
        Date_of_Insert = SMKID == 17 ? '2' : SYS_VAR.elementAt(0).SVVL!;
        //حسب الصلاحيات
        if (SYS_VAR.elementAt(0).SVVL.toString() == '4') {
          //السماح بتعديل تاريخ ادخال الجركات المخزنيه
          PRIVLAGE(LoginController().SUID,  1547).then((data) {
            USR_PRI = data;
            if (USR_PRI.isNotEmpty) {
              Allow_to_Inserted_Date = USR_PRI.elementAt(0).UPIN;
            } else {
              Allow_to_Inserted_Date = 2;
            }
          });
        }
      } else {
        Date_of_Insert = '2';
      }
    });
  }

  // هل يتم استخدام مراكز التكلفة بشكل عام
  Future GET_USE_Cost_Centers() async {
    GET_SYS_VAR(351).then((data) {
      if (data.isNotEmpty) {
        P_COSM =  data.elementAt(0).SVVL!;
      } else {
        P_COSM = '2';
      }
    });
  }

  //ربط حسابات المركز المالي-الميزانيه بمراكز التكلفه
  Future GET_USE_Linking_Accounts_Cost_Centers() async {
    GET_SYS_VAR(352).then((data) {
      if (data.isNotEmpty) {
        P_COS1 =  data.elementAt(0).SVVL!;
      } else {
        P_COS1 = '2';
      }
    });
  }


  //ربط حسابات قائمة الدخل-الارباح,المتاجره بمراكز التكلفه
  Future GET_USE_Linking_Income_Accounts_Cost_Centers() async {
    GET_SYS_VAR(353).then((data) {
      if (data.isNotEmpty) {
        P_COS2 =  data.elementAt(0).SVVL!;
      } else {
        P_COS2 = '2';
      }
    });
  }

  //استخدام مراكز التكلفة في الشاشة
  Future GET_USE_Cost_Cen() async {
    GET_SYS_VAR(SMKID == 1 || SMKID == 2 || SMKID == 0 ? 804 : 815).then((data) {
      SYS_VAR = data;
      if (data.isNotEmpty) {
        P_COSS =  data.elementAt(0).SVVL!;
        //حسب الصلاحيات
        if (data.elementAt(0).SVVL.toString() == '4') {
          PRIVLAGE(LoginController().SUID, SMKID == 1 || SMKID == 2 || SMKID == 0 ? 1412 :1402 ).then((data) {
            USR_PRI = data;
            if (data.isNotEmpty) {
              Allow_USE_Cost_Cen = data.elementAt(0).UPIN;
            } else {
              Allow_USE_Cost_Cen = 2;
            }
          });
        }
      }
      else {
        P_COSS = '2';
      }
    });

  }

  //تسلسل الحركة حسب مراكز التكلفة في الشاشة
  Future GET_COS_SEQ() async {
    GET_SYS_VAR(SMKID == 1 || SMKID == 2 || SMKID == 0 ? 1001 : 1000).then((data) {
      SYS_VAR = data;
      if (data.isNotEmpty) {
        P_COS_SEQ =  data.elementAt(0).SVVL!;
        P_COS_SEQ=='4' ? P_COS_SEQ='1' : P_COS_SEQ='2';
      } else {
        P_COS_SEQ = '2';
      }
      SET_COS();
    });
  }

  Future SET_COS() async {
    if (P_COSM!='1' || P_COSS=='5') {
      P_COS_SEQ =  '2';
      P_COS1=  '5';
      P_COS2=  '5';
      P_COSS=  '5';
      update();
    }

    if(P_COSS=='5' && P_COS_SEQ=='2') {
      P_COSM =  '2';
      P_COS1=  '5';
      P_COS2=  '5';
      P_COSS=  '5';
      update();
    }
  }

  //السماح بتعديل سعر الصرف عند عمل صرف مخزني
  Future GET_Allow_Update_Price_Items_Out_Vouchers() async {
    PRIVLAGE(LoginController().SUID,1549).then((data) {
      USR_PRI = data;
      if(USR_PRI.isNotEmpty){
        UPIN_OUT=USR_PRI.elementAt(0).UPIN;
      }else {
        UPIN_OUT=2;
      }
    });
  }

  //جلب رقم الحركة
  Future GET_SMMID_P() async {
    GET_SMMID().then((data) {
      if (data.isNotEmpty) {
        SMMID = data.elementAt(0).SMMID;
        update();
      }
    });
    update();
  }

  //جلب رقم الحركة
  Future GET_SMMNO_P() async {
    GET_SMMNO(SMKID!).then((data) {
      if (data.isNotEmpty) {
        SMMNO = data.elementAt(0).SMMNO;
      }
    });
  }

  //جلب رقم الحركة الفرعي
  Future GET_SMDID_P() async {
  var SMDID_V=await GET_SMDID(SMMID!);
      if (SMDID_V.isNotEmpty) {
        SMDID = SMDID_V.elementAt(0).SMDID;
      }
  }

  Future<void> renumberbmdid(String SMMID) async {
    var dbClient = await conn.database;

    // استرجاع كل الحركات الفرعية الخاصة بالحركة الرئيسية وترتيبها تصاعديًا حسب BMDID
    List<Map<String, dynamic>> subRows = await dbClient!.rawQuery(
        "SELECT SMDID FROM STO_MOV_D WHERE SMMID = ? ORDER BY SMDID ASC",
        [SMMID]
    );

    // إعادة ترقيم كل سجل بحيث يبدأ BMDID من 1
    for (int i = 0; i < subRows.length; i++) {
      int newBMDID = i + 1;
      await dbClient.update(
        "STO_MOV_D",
        {"SMDID": newBMDID},
        where: "SMDID = ?",
        whereArgs: [subRows[i]["SMDID"]],
      );
    }
  }

  //جلب عملة المخزون
  Future USE_SCID_P() async {
    GET_SYS_VAR(952).then((data) {
      SYS_VAR = data;
      if (SYS_VAR.isNotEmpty) {
        SCID = SYS_VAR.elementAt(0).SVVL.toString();
        GET_SYS_CUR_ONE(SYS_VAR.elementAt(0).SVVL.toString());
      }else{
        SCID='1';
      }
    });
  }

  //جلب العمله
  Future GET_SYS_CUR_ONE(String GETSCID) async {
    GET_SYS_CUR_ONE_P(GETSCID).then((data) {
      if (data.isNotEmpty) {
        SelectDataSCID = data.elementAt(0).SCID.toString();
        SCEXS = data.elementAt(0).SCEX;
        SCEX = data.elementAt(0).SCEX;
        SCSY = data.elementAt(0).SCSY!;
        SCSFL = data.elementAt(0).SCSFL!;
      }
      update();
    });
  }

  //جلب المخزن
  Future GET_STO_INF_P() async {
    GET_STO_INF_ONE(SelectDataBIID.toString()).then((data) {
      if(data.isNotEmpty) {
        SelectDataSIID = data.elementAt(0).SIID.toString();
        SelectDataSIID_F = data.elementAt(0).SIID.toString();
        SINA_F = data.elementAt(0).SINA_D.toString();
        update();
      }
    });
  }

  //جلب العمله عند الدخول
  Future GET_SYS_CUR_ONE_P_STO() async {
    GET_SYS_CUR_ONE_STO().then((data) {
      if (data.isNotEmpty) {
        SelectDataSCID = data.elementAt(0).SCID.toString();
        SCEX = data.elementAt(0).SCEX;
        SCSY = data.elementAt(0).SCSY!;
        SCSFL = data.elementAt(0).SCSFL!;
      }
      update();
    });
  }

  //جلب الباركود
  Future FetchBarcodData(String barcod) async {
    if (barcod=='-1'){
      ClearSto_Mov_D_Data();
      Fluttertoast.showToast(
          msg: "error -1",
          toastLength: Toast.LENGTH_LONG,
          textColor: Colors.white,
          backgroundColor: Colors.redAccent);
      ClearSto_Mov_D_Data();
    }else {
     var barcodData= await Get_BRO(SelectDataSIID.toString(), barcod);
        if (barcodData.isEmpty) {
          Fluttertoast.showToast(
              msg: "لا يوجد صنف بهذا الباركود",
              toastLength: Toast.LENGTH_LONG,
              textColor: Colors.white,
              backgroundColor: Colors.redAccent);
        } else {
          MGNOController.text = barcodData.elementAt(0).MGNO.toString();
          SelectDataMINO = barcodData.elementAt(0).MINO.toString();
          MINAController.text = barcodData.elementAt(0).MINA.toString();
          SelectDataMUID = barcodData.elementAt(0).MUID.toString();
          // USE_SMDED_P();
          await GETSNDE_ONE();
          await Get_Sto_Num(barcodData.elementAt(0).MUID.toString());
          SMKID==3 || SMKID==13?Get_STO_NUM_Out_Voucher(barcodData.elementAt(0).MUID.toString()):false;
          await GET_COU_B();
          await GET_MGNA_P();
          myFocusNode.requestFocus();
          if (SMDNOController.text.isEmpty) {
            return;
          } else {
            SMDNOController.selection = TextSelection(baseOffset: 0, extentOffset: SMDNOController.text.length);
          }
        }
    }
  }

  //جلب حركة جرد مخزني الي pdf
  Future FetchPdfData(int GetSmmid) async {
    GETSTO_MOV_D(GetSmmid,'').then((data) {
      get_item = data;
    });
  }

  //اظهار البيانات +البحث
  GETSTO_MOV_M_P(String type) {
    if(type=="ALL"){
      GETSTO_MOV_M( SMKID==0 ? 1 : SMKID!,"ALL",'',SMKID==0 ? -1 : SMKID!).then((data) {
        STO_MOV_M_List = data;
        update();
      });
    }else if(type=="DateNow"){
      GETSTO_MOV_M(SMKID==0 ? 1 : SMKID!,"DateNow",DateFormat('dd-MM-yyyy').format(DateTime.now()),SMKID==0?-1:SMKID!).then((data) {
        STO_MOV_M_List = data;
        update();
      });
    }else if(type=="FromDate"){
      GETSTO_MOV_M(SMKID==0 ? 1 : SMKID!,"FromDate",SelectNumberOfDays,SMKID==0?-1:SMKID!).then((data) {
        STO_MOV_M_List = data;
        update();
      });
    }
    update();
  }


  //جلب سعر التكلفة
  Future GET_MPCO_P(String GETMGNO, String GETMINO, GETMUID) async {
    //جلب سعر التكلفه بعملة الفاتورة
    MAT_PRI=await GET_MPCO(int.parse(SelectDataBIID.toString()), GETMGNO, GETMINO, GETMUID, int.parse(SCID.toString()));
    print(SMDAM);
    print(MAT_PRI);
    print('SMDAM');
    if (MAT_PRI.isNotEmpty) {
      var MPCO_V = await ES_MAT.GET_MAT_UNI_F(
        F_MGNO: MGNOController.text.toString(), // أدخل القيم المناسبة هنا
        F_MINO: SelectDataMINO.toString(),
        F_MUID_F: GETMUID,
        F_MUID_T: double.parse(SelectDataMUID.toString()),
        F_NO: MAT_PRI.elementAt(0).MPCO!,
        F_TY: 2, // أو 2 أو 3 أو 4 أو 44 حسب الحاجة
      );

      MPCOController.text = roundDouble((MPCO_V * SCEXS!) / SCEX!, 6).toString();

      SMDAM = roundDouble((MPCO_V * SCEXS!) / SCEX!, 6);
      print(SMDAM);
      print('SMDAM');
      SMDAMController.text = roundDouble((MPCO_V * SCEXS!) / SCEX!, 6).toString();
      MPCO_VController.text = formatter.format(roundDouble((MPCO_V * SCEXS!) / SCEX!, 6)).toString();
      update();
    }

    // //جلب سعر التكلفه بعملة المخزون
    // GET_MPCO(int.parse(SelectDataBIID.toString()), GETMGNO, GETMINO,
    //     int.parse(SelectDataMUID.toString()), int.parse(SCID.toString())).then((data) async {
    //   MAT_PRI = data;
    //   if (MAT_PRI.isNotEmpty) {
    //     MPCO = MAT_PRI.elementAt(0).MPCO;
    //     update();
    //   }
    // });
  }


  //جلب وحدة البيع
  GETMUIDS() async {
    Get_MUIDS_D(MGNOController.text.toString(),SelectDataMINO.toString()).then((data) {
      MAT_INF = data;
      if(MAT_INF.isNotEmpty){
        SelectDataMUID=MAT_INF.elementAt(0).MUIDS.toString();
        GETSNDE_ONE();
        Get_Sto_Num(SelectDataMUID.toString());
        SMKID==3 || SMKID==13?Get_STO_NUM_Out_Voucher(SelectDataMUID.toString()):false;
        //   GET_MPS1_P(MGNOController.text.toString(), SelectDataMINO!, int.parse(SelectDataMUID.toString()));
        GET_COU_B();
        GET_MGNA_P();
      }
    });
  }


  //جلب اول تاريخ انتهاء
  GETSNDE_ONE() async {
    if(MIED==1 && SMKID!=17){
      SelectDataSNED==null;
      SMDEDController.text=='null';
    }
    else  {
      Get_SNDE_ONE(MGNOController.text.toString(), SelectDataMINO.toString(),
          SelectDataSIID.toString(),SelectDataMUID.toString()).then((data) {
        GET_SNDE = data;
        if(GET_SNDE.isNotEmpty){
          SelectDataSNED = GET_SNDE.elementAt(0).SNED.toString();
          SMDEDController.text = GET_SNDE.elementAt(0).SNED.toString();
          Get_Sto_Num(SelectDataMUID.toString());
          SMKID==3 || SMKID==13?Get_STO_NUM_Out_Voucher(SelectDataMUID.toString()):false;
          GET_COU_B();
        }else{
          SMDEDController.text='01-01-2900';
        }
      });
    }
  }


  //جلب عدد اجمالي العدد
  GET_CountSMDNF() async {
    loading(true);
    CountSMDNF(SMMID!,SMKID!).then((data) {
      if(data.isEmpty){
        CountController.text ='0.0';
        loading(false);
      }
      SUM_COUNT= data;
      loading(true);
      CountController.text=SUM_COUNT.elementAt(0).SUM.toString();
      SUM=SUM_COUNT.elementAt(0).SUM;
      SUM.toString().contains('.0') ? SUM!.round() : SUM;
      CountController.text.contains('.0') ? double.parse(CountController.text).round() :
      double.parse(CountController.text).toPrecision(1);
      loading(false);
    });
  }

  //جلب عدد اجمالي العدد
  GET_CountSMDNF2(int SMMID) async {
    CountSMDNF(SMMID,1).then((data) {
      SUM_COUNT= data;
      loading(true);
      CountController.text=SUM_COUNT.elementAt(0).SUM.toString();
      SUM=SUM_COUNT.elementAt(0).SUM;
      SUM.toString().contains('.0') ? SUM!.round() : SUM;
      CountController.text.contains('.0') ? double.parse(CountController.text).round() :
      double.parse(CountController.text).toPrecision(1);
      loading(false);
    });
  }

  //جلب عدد  السجلات
  GET_CountRecode() async {
    loading(true);
    CountRecode(SMMID!).then((data) {
      if(data.isEmpty){
        CountRecodeController.text ='0';
        loading(false);
      }
      COUNT_RECODE= data;
      loading(true);
      Countrecode=COUNT_RECODE.elementAt(0).COU;
      CountRecodeController.text=COUNT_RECODE.elementAt(0).COU.toString();
      UpdateSMMNR(int.parse(CountRecodeController.text),SMMID);
      GET_CountSMDNF();
      loading(false);
    });
  }


  //جلب عدد محاولات الجرد للصتف
  GET_NUM_INV_MINO_P() async {
    loading(true);
    GET_NUM_INV_MINO(SelectDataBIID.toString(),SelectDataSIID.toString(),MGNOController.text.toString(),
        SelectDataMINO.toString()).then((data) {
      if(data.isEmpty){
        NUM_INV_MINO =0;
      }
      NUM_INV_MINO_L= data;
      NUM_INV_MINO=NUM_INV_MINO_L.elementAt(0).NUM_MINO!;
    });
  }

  //جلب الكمية
  Get_Sto_Num(String StringMUID) async {
    SelectDataSNED==null && MIED!=1 && SMKID==17 ? SelectDataSNED='01-01-2900':
    SelectDataSNED==null && MIED==1 && SMKID!=17 ? null:
    SelectDataSNED=SelectDataSNED;
    SMDEDController.text.isEmpty && MIED!=1 && SMKID==17 ?SMDEDController.text='01-01-2900':
    SMDEDController.text=='null' && MIED==1 && SMKID!=17 ? null:
    SMDEDController.text=SMDEDController.text;
    var  data=await  GETSTO_SNNO(int.parse(SelectDataSIID.toString()),MGNOController.text.toString(),SelectDataMINO.toString(),
        StringMUID,MIED.toString(),SelectDataSNED.toString());
    if(data.isEmpty){
      SMDNFHintController.text = '0.0';
      SMDNOController.text = '0.0';
      SMKID!=17?SMDNFController.text = '0':null;
    }
    else{
      GET_STO_NUM_LIST=data;
      SMDNFHintController.text=GET_STO_NUM_LIST.elementAt(0).SNNO.toString().isEmpty?'0':GET_STO_NUM_LIST.elementAt(0).SNNO.toString();
      SMDNOController.text=SMKID==17?GET_STO_NUM_LIST.elementAt(0).SNNO.toString():'0';
      HINT=GET_STO_NUM_LIST.elementAt(0).SNNO;
      SMDNFController.text = SMKID==17?'':'0';
    }

    if(StteingController().isShow_SNNO_OR_DEF==false && StteingController().Default_SNNO  > 0){
      SMDNFHintController.text = StteingController().Default_SNNO.toString();
      SMDNFController.text = SMKID==17?StteingController().Default_SNNO.toString():'0';
      update();
    }
    GET_COU_B();
    GET_NUM_INV_MINO_P();

    GETSTO_NUM(int.parse(SelectDataSIID.toString()),MGNOController.text.toString(),
        SelectDataMINO.toString(),StringMUID,MIED.toString(),SelectDataSNED.toString()).then((data) async {
      Sto_Num_List.value = data;
      if(Sto_Num_List.isNotEmpty){
        SelectDataMUCNA=Sto_Num_List.elementAt(0).MUNA.toString();
        GET_MGNA_P();
      }
    });

    // اعادة الوحده الاساسيه للصنف اصغر وحده
    // GET_MAT_UNI_F(MGNOController.text.toString(), SelectDataMINO.toString(), 0, 0, 0, 4);
    // استدعاء الدالة matUniF
    var MUID2 = await ES_MAT.GET_MAT_UNI_F(
      F_MGNO: MGNOController.text.toString(), // أدخل القيم المناسبة هنا
      F_MINO: SelectDataMINO.toString(),
      F_MUID_F: 0,
      F_MUID_T: 0,
      F_NO: 0,
      F_TY: 4, // أو 2 أو 3 أو 4 أو 44 حسب الحاجة
    );

    // await Future.delayed(const Duration(milliseconds: 100));
    await GET_MPCO_P(MGNOController.text.toString(), SelectDataMINO!, MUID2);
    if (SMDNOController.text.isEmpty) {
      return;
    } else {
      SMDNOController.selection = TextSelection(baseOffset: 0, extentOffset: SMDNOController.text.length);
    }
  }

  //جلب عدد تكرار الصنف
  GET_COU_B() {
    Get_Count_D(SMMID!, MGNOController.text.toString(),SelectDataMINO.toString(), int.parse(SelectDataMUID.toString()),
        MIED.toString(),SelectDataSNED.toString()).then((data) {
      Count = data;
    });
  }

  //جلب اسم المجموعة
  Future GET_MGNA_P() async {
    GET_MGNA(MGNOController.text).then((data) {
      MAT_GRO = data;
      if(MAT_GRO.isNotEmpty){
        MGNA = MAT_GRO.elementAt(0).MGNA_D.toString();
      }
    });
  }


  //جلب تذلبل المستندات
  Future GET_SYS_DOC_D() async {
    Get_SYS_DOC_D('ST',SMKID==131?13:SMKID!,LoginController().BIID).then((data) {
      GET_SYS_DOC = data;
      if(GET_SYS_DOC.isNotEmpty){
        SDDSA=GET_SYS_DOC.elementAt(0).SDDSA_D.toString();
        SDDDA=GET_SYS_DOC.elementAt(0).SDDDA_D.toString();
      }
    });
  }

  //جلب بيانات المنشاة
  Future GET_Sys_Own() async {
    GET_SYS_OWN(LoginController().BIID).then((data) {
      SYS_OWN = data;
      if(SYS_OWN.isNotEmpty){
        SONA=SYS_OWN.elementAt(0).SONA.toString();
        SONE=SYS_OWN.elementAt(0).SONE.toString();
        SORN=SYS_OWN.elementAt(0).SORN.toString();
        SOLN=SYS_OWN.elementAt(0).SOLN.toString();
        SOAD=SYS_OWN.elementAt(0).SOAD.toString();
      }
    });
  }

  //التحقق من تاريخ الجرد اكبر من السنة السنة
  Future CHK_YEA() async {
    GET_SYS_YEA(LoginController().SYID).then((data) {
      SYS_YEA = data;
      if(SYS_YEA.isNotEmpty){
        SYED=SYS_YEA.elementAt(0).SYED.toString();
      }
    });
  }

  //تنطيف Sto_Mov_D
  ClearSto_Mov_D_Data() {
    MINAController.text='';
    SMDNFController.text = '';
    SMDNOController.clear();
    SMDAMController.clear();
    SMDNFHintController.text = '';
    SMMNOController.text = '';
    MGNOController.text = '';
    SelectDataMUCNA = null;
    SelectDataMUCNA = '';
    SelectDataMINO = '';
    SelectDataSNED = '';
    SelectDataSNED = null;
    SMDIDController.clear();
    SMDEDController.clear();
    titleAddScreen = 'StringAdd'.tr;
    TextButton_T = 'StringAdd'.tr;
  }

  //تنطيف Sto_Mov_M
  ClearSto_Mov_M_Data() {
    SelectDataSIID = null;
    SelectDataBIID = null;
    SelectDataSIID_F = null;
    SelectDataSIID_T = null;
    // SelectDataAANO = null;
    SMMINController.clear();
  }

  //دالة تنزيل البيانات
  Future GET_DownLoad_Sto_Mov_D() async {
    Get_MAT_INF_Download(SelectDataBIID.toString(),SelectDataSIID.toString(),SCID).then((data) {
      GET_DownLoad_STO_MOV_D = data;
      if(GET_DownLoad_STO_MOV_D.isNotEmpty){
        EasyLoading.instance
          ..displayDuration = const Duration(milliseconds: 2000)
          ..indicatorType = EasyLoadingIndicatorType.fadingCircle
          ..loadingStyle = EasyLoadingStyle.custom
          ..indicatorSize = 50.0
          ..radius = 10.0
          ..progressColor = Colors.white
          ..backgroundColor = Colors.green
          ..indicatorColor = Colors.white
          ..textColor = Colors.white
          ..maskColor = Colors.blue.withOpacity(0.5)
          ..userInteractions = true
          ..dismissOnTap = false;
        EasyLoading.show();
        DownLoad_Sto_Mov_D(GET_DownLoad_STO_MOV_D);
      }
    });
  }

  Future DownLoad_Sto_Mov_D(List<Mat_Inf_Local> List_D) async {
    for (var i = 0; i < List_D.length; i++) {
      try {
        int? N;
        N = i + 1;
        GUIDD = uuid.v1();
        if (StteingController().isShow_Mat_No_SNNO == false) {
          StteingController().isShow_SNNO_OR_DEF == false && StteingController().Default_SNNO > 0 ?
          SMDDF = (StteingController().Default_SNNO -
              double.parse(List_D[i].SNNO.toString())).toPrecision(1) :
          SMDDF = (0.0 - double.parse(List_D[i].SNNO.toString())).toPrecision(1);
          await Future.delayed(const Duration(milliseconds: 400));
          Sto_Mov_D_Local e = Sto_Mov_D_Local(
            SMMID: SMMID,
            SMKID: SMKID==0?1:SMKID,
            SMDID: N,
            MGNO: List_D[i].MGNO.toString(),
            MINO: List_D[i].MINO.toString(),
            MUID: List_D[i].MUID,
            SMDNF: StteingController().isShow_SNNO_OR_DEF == false &&
                StteingController().Default_SNNO > 0 ? StteingController()
                .Default_SNNO : 0,
            SMDNO: List_D[i].SNNO,
            SMDDF: SMDDF,
            SMDAM: List_D[i].MPCO,
            SMDED: List_D[i].SNED.toString(),
            GUID: GUIDD.toString().toUpperCase(),
            GUIDM: GUID.toString().toUpperCase(),
            SYST: SMMST,
            SIID: int.parse(SelectDataSIID.toString()),
            BIID: int.parse(SelectDataBIID.toString()),
            SUID: LoginController().SUID,
            DEVI: LoginController().DeviceName,
            DATEI:  DateFormat('dd-MM-yyyy HH:m').format(DateTime.now()),
            JTID_L: LoginController().JTID,
            BIID_L: LoginController().BIID,
            SYID_L: LoginController().SYID,
            CIID_L: LoginController().CIID,
          );
          SaveSto_Mov_D(e);
        }
        else{
          GET_COUNT_STO_NUM(SelectDataSIID.toString(),List_D[i].MGNO.toString(),List_D[i].MINO.toString(),
              List_D[i].MUIDP.toString(),List_D[i].SNNO.toString()).then((data) {
            GET_STO_NUM_LIST = data;
            COUNT_SNNO=GET_STO_NUM_LIST.elementAt(0).COUNT_SNNO;
          });
          await Future.delayed(const Duration(milliseconds: 400));
          if(COUNT_SNNO!>0){
            StteingController().isShow_SNNO_OR_DEF == false &&
                StteingController().Default_SNNO > 0 ?
            SMDDF = (StteingController().Default_SNNO -
                double.parse(GET_STO_NUM_LIST.elementAt(0).SNNO.toString())).toPrecision(1) :
            SMDDF = (0.0 - double.parse(GET_STO_NUM_LIST.elementAt(0).SNNO.toString())).toPrecision(1);
            Sto_Mov_D_Local e = Sto_Mov_D_Local(
              SMMID: SMMID,
              SMKID: SMKID==0?1:SMKID,
              SMDID: N,
              MGNO: List_D[i].MGNO.toString(),
              MINO: List_D[i].MINO.toString(),
              MUID: List_D[i].MUIDP,
              SMDNF: StteingController().isShow_SNNO_OR_DEF == false &&
                  StteingController().Default_SNNO > 0 ? StteingController()
                  .Default_SNNO : 0,
              SMDNO: GET_STO_NUM_LIST.elementAt(0).SNNO,
              SMDDF: SMDDF,
              SMDAM: List_D[i].MPCO,
              SMDED: GET_STO_NUM_LIST.elementAt(0).SNED.toString(),
              GUID: GUIDD.toString().toUpperCase(),
              GUIDM: GUID.toString().toUpperCase(),
              SYST: SMMST,
              SIID: int.parse(SelectDataSIID.toString()),
              BIID: int.parse(SelectDataBIID.toString()),
              SUID: LoginController().SUID,
              DEVI: LoginController().DeviceName,
              DATEI:  DateFormat('dd-MM-yyyy HH:m').format(DateTime.now()),
              JTID_L: LoginController().JTID,
              BIID_L: LoginController().BIID,
              SYID_L: LoginController().SYID,
              CIID_L: LoginController().CIID,
            );
            SaveSto_Mov_D(e);
          }
          else{
            StteingController().isShow_SNNO_OR_DEF == false &&
                StteingController().Default_SNNO > 0 ?
            SMDDF = (StteingController().Default_SNNO - 0.0).toPrecision(1) :
            SMDDF = (0.0 - 0.0).toPrecision(1);
            Sto_Mov_D_Local e = Sto_Mov_D_Local(
              SMMID: SMMID,
              SMKID: SMKID==0?1:SMKID,
              SMDID: N,
              MGNO: List_D[i].MGNO.toString(),
              MINO: List_D[i].MINO.toString(),
              MUID: List_D[i].MUIDP,
              SMDNF: StteingController().isShow_SNNO_OR_DEF == false &&
                  StteingController().Default_SNNO > 0 ? StteingController()
                  .Default_SNNO : 0,
              SMDNO:0,
              SMDDF: SMDDF,
              SMDAM: List_D[i].MPCO,
              SMDED:'01-01-2900',
              GUID: GUIDD.toString().toUpperCase(),
              GUIDM: GUID.toString().toUpperCase(),
              SYST: SMMST,
              SIID: int.parse(SelectDataSIID.toString()),
              BIID: int.parse(SelectDataBIID.toString()),
              SUID: LoginController().SUID,
              DEVI: LoginController().DeviceName,
              DATEI:  DateFormat('dd-MM-yyyy HH:m').format(DateTime.now()),
              JTID_L: LoginController().JTID,
              BIID_L: LoginController().BIID,
              SYID_L: LoginController().SYID,
              CIID_L: LoginController().CIID,
            );
            SaveSto_Mov_D(e);
          }
        }
        CheckBack = 1;
        GET_CountSMDNF();
        GET_CountRecode();
        update();
        if(N==List_D.length){
          EasyLoading.dismiss();
        }
      } catch (e) {
        EasyLoading.dismiss();
        Fluttertoast.showToast(
            msg: e.toString(),
            textColor: Colors.white,
            backgroundColor: Colors.red);
        return Future.error(e);
      }
    }
  }


  //اضافة حركة جرد مخزني
  AddInventory() {
    print(UPIN);
    print('UPIN');
    if(UPIN==1) {
    //  formKey.currentState?.reset();
      edit = false;
      CheckBack=0;
      GET_SMMID_P();
      GET_SMMNO_P();
      SelectDataSIID = null;
      SelectDataSIID_T = null;
      SelectDataACNO = null;
      SMKID==11 ?  SelectDataSIID_F = null:false;
      SelectDataAANO = null;
      SMMRD = DateFormat('dd-MM-yyyy').format(dateTimeDays).toString().split(" ")[0];
      CountController.text='0.0';
      CountRecodeController.text='0';
      MGNAController.text = '';
      SMMINController.text= SMKID==0 ? 'مخزون اول المده/الافتتاحي':'';
      SMMINController.text = '';
      SMMAMTOTController.text='0.0';
      SMMCNController.text='';
      SMMDRController.text='';
      SMMAM=0;
      SMMAMTOT=0;
      titleScreen = 'StringAdd'.tr;
      titleAddScreen = 'StringAdd'.tr;
      GUID = uuid.v1();
      SER_MINA='';
      SelectDataBIID=LoginController().BIID.toString();
      GET_STO_INF_P();
      SMKID==3 || SMKID==1 || SMKID==0?GET_SYS_CUR_ONE_P_STO():null;
      update();
      //CheckHomeScreen==1 ? Get.to(() => add_edit_inventory()):Get.off(() => add_edit_inventory());
      Get.to(() => add_edit_inventory());
    }
    else{
      Get.snackbar('StringUPIN'.tr, 'String_CHK_UPIN'.tr,
          backgroundColor: Colors.red, icon: Icon(Icons.error,color:Colors.white),
          colorText:Colors.white,
          isDismissible: true,
          dismissDirection: DismissDirection.horizontal,
          forwardAnimationCurve: Curves.easeOutBack);
      return false;
    }
  }

  //تعديل حركة جرد مخزني
  EditInventory(STO_MOV_M_Local note) {
    if(BYST==2) {
      Get.snackbar('StringByst_Mes'.tr, 'String_CHK_Byst'.tr,
          backgroundColor: Colors.red, icon: Icon(Icons.error,color:Colors.white),
          colorText:Colors.white,
          isDismissible: true,
          dismissDirection: DismissDirection.horizontal,
          forwardAnimationCurve: Curves.easeOutBack);
    }else {
      if (UPCH == 1) {
        edit = true;
        SelectDataBIID = note.BIID.toString();
        SelectDataBIID_T = note.BIIDT.toString();
        SelectDataSIID = note.SIID.toString();
        SelectDataSIID_F = note.SIID.toString();
        SelectDataSIID_T = note.SIIDT.toString();
        SelectDataSCID = note.SCID.toString();
        SelectDataACNO = note.ACNO.toString() == 'null' ? null:note.ACNO.toString();
        SelectDataAANO = note.AANO.toString() == 'null' ? null:note.AANO.toString();
        SelectDataAANA = note.AANO2.toString() == 'null' ? null : note.AANO2.toString();
        SCEX = note.SCEX;
        SMMINController.text = note.SMMIN.toString();
        SMMID = note.SMMID;
        SMMNO = note.SMMNO;
        SelectDays = note.SMMDO.toString().substring(0, 11);
        SMMRD = note.SMMDA.toString();
        SMMAM = note.SMMAM;
        GUID = note.GUID;
        SMMCNController.text=note.SMMCN.toString();
        SMMDRController.text=note.SMMDR.toString();
        GET_CountRecode();
        GET_CountSMDNF();
        GET_SUMSMMAM();
        titleScreen = 'StringEdit'.tr;
        SER_MINA = '';
        fetchAutoCompleteData();
        Get.to(() => add_edit_inventory(), arguments: note.SMMID);
      } else {
        Get.snackbar('StringUPCH'.tr, 'String_CHK_UPCH'.tr,
            backgroundColor: Colors.red, icon: Icon(Icons.error,color:Colors.white),
            colorText:Colors.white,
            isDismissible: true,
            dismissDirection: DismissDirection.horizontal,
            forwardAnimationCurve: Curves.easeOutBack);
      }
    }
  }

  Future GET_STO_MOV_M_PRINT_P(int GET_SMKID,int GETSMMID) async {
    GET_STO_MOV_D_P(GETSMMID);
    GET_STO_MOV_M_PRINT(GET_SMKID,GETSMMID).then((data) {
      STO_MOV_M_PRINT = data;
      update();
    });
  }


  //جلب السجلات الفرعية
  Future GET_STO_MOV_D_P(int GetBMMID) async {
    GETSTO_MOV_D(GetBMMID, '').then((data) {
      STO_MOV_D_PRINT = data;
      update();
    });
  }

  //حالة الحفظ
  editMode() {
    contentFocusNode.unfocus();
    loading(true);
    bool isValidate=true;
    //bool isValidate = formKey.currentState!.validate();
    if (isValidate == false) {
      isloadingvalidator(false);
    }else{
      if (Get.arguments == null && edit==false) {
        if (CheckBack== 0) {
          Get.snackbar('StringCHK_Save_Err'.tr, 'StringCHK_Save'.tr,
              backgroundColor: Colors.red, icon: Icon(Icons.error,color:Colors.white),
              colorText:Colors.white,
              isDismissible: true,
              dismissDirection: DismissDirection.horizontal,
              forwardAnimationCurve: Curves.easeOutBack);
        } else {
          Save_STO_MOV_M();
        }
      } else {
        UpdateSTO_MOV_M_P(Get.arguments);
      }
    }
  }


  String? validateSMDFN(String value){
    if(value.trim().isEmpty){
      return 'StringvalidateSMDFN'.tr;
    }
    return null;
  }

  String? validateMINO(String value){
    if(value.trim().isEmpty){
      return 'StringvalidateMINO'.tr;
    }
    return null;
  }

  //دالة التقريب
  double roundDouble(double value, int places) {
    num mod = pow(10.0, places);
    return ((value * mod).round().toDouble() / mod);
  }


  // جلب اجمالي المجاني
  GET_SUMSMMDIF() async {
    loading(true);
    SUM_SMMDIF(SMMID!).then((data) {
      if (data.isEmpty) {
        SUMSMMDIF = 0.0;
      }else{
        SUMSMMDIF = roundDouble(data.elementAt(0).SMMDIF!, SCSFL);
      }
      update();
    });
  }

  // جلب  صافي المبلغ
  GET_SUMSMMAM2() async {
    SUM_SMMAM2(SMMID!).then((data) {
      if (data.isEmpty) {
        SMMAMTOTController.text = '0.0';
        SMMAMTOT = 0.0;
      }
      SMMAMTOTController.text = roundDouble(data.elementAt(0).SUM_TOTSMDAM!, SCSFL).toString();
      SMMAMTOT = roundDouble(data.elementAt(0).SUM_TOTSMDAM!, SCSFL);
      update();
    });
    update();
  }

  // جلب  اجمالي المبلغ
  GET_SUMSMMAM() async {
    SUM_SMMAM(SMMID!).then((data) {
      if (data.isEmpty) {
        SMMAM = 0;
      } else {
        SMMAM = roundDouble(data.elementAt(0).SUM_SMDAM!, 6);
        update();
      }
    });
    GET_SUMSMMAM2();
    GET_SUMSMMDIF();
    update();
  }

  // نوع الحساب اذا كان 1 قائمة مركز مالي و 2 قائمة دخل
  GET_AKID_P() async {
    GET_AKID(SelectDataAANO.toString()).then((data) {
      if (data.isEmpty) {
        AKID = 1;
        AKID = 1;
      } else {
        AKID = data.elementAt(0).AKID!;
        AACC = data.elementAt(0).AACC!;
        update();
      }
    });
    update();
  }

  //حفظ حركة جرد مخزني الفرعي
  Future<bool> Save_STO_MOV_D() async {
    try {
      await GET_SMDID_P();
      bool isValidate = ADD_EDformKey.currentState!.validate();
      if (isValidate == false) {
        loading(true);
      }
      else {
        print(SMKID==13 || SMKID==131 ?int.parse(SelectDataSIID_F.toString())
            :int.parse(SelectDataSIID.toString()));
        print('SelectDataSIID');
        SMKID==17? SMDNFController.text = SMDNFController.text == '' ?
        SMDNFHintController.text : SMDNFController.text:null;
        GUIDD = uuid.v1();
        SMDDF = (double.parse(SMDNFController.text.toString()) - double.parse(SMDNOController.text.toString())).toPrecision(1);
        if (SelectDataMINO == null || SelectDataMUID == null ) {
          Fluttertoast.showToast(
              msg: "StringError_MESSAGE".tr,
              toastLength: Toast.LENGTH_LONG,
              textColor: Colors.white,
              backgroundColor: Colors.redAccent);
          return false;
        }
        else if (SMKID==17 && !SMDNFController.text.isNum) {
          Fluttertoast.showToast(
              msg: 'StrinReq_SMDFN_NUM'.tr,
              toastLength: Toast.LENGTH_LONG,
              textColor: Colors.white,
              backgroundColor: Colors.redAccent);
          return false;
        }
        else if (SMKID==17 && double.parse(SMDNFController.text) < 0.0) {
          Fluttertoast.showToast(
              msg: 'StrinReq_SMDFN'.tr,
              toastLength: Toast.LENGTH_LONG,
              textColor: Colors.white,
              backgroundColor: Colors.redAccent);
          return false;
        }
        else if (SMKID!=17 && double.parse(SMDNOController.text) <= 0.0) {
          Fluttertoast.showToast(
              msg: 'StringvalidateSMDFN'.tr,
              toastLength: Toast.LENGTH_LONG,
              textColor: Colors.white,
              backgroundColor: Colors.redAccent);
          return false;
        }
        else if (SMKID!=11 &&  MIED == 1 &&  SelectDataSNED == null) {
          Fluttertoast.showToast(
              msg: 'StrinReq_SMDED'.tr,
              toastLength: Toast.LENGTH_LONG,
              textColor: Colors.white,
              backgroundColor: Colors.redAccent);
          return false;
        }
        else if (SMKID==3  && (double.parse(SMDNOController.text) > BDNO_F!)) {
          Get.defaultDialog(
            title: 'StringMestitle'.tr,
            middleText: 'StringChk_BMDNO'.tr,
            backgroundColor: Colors.white,
            radius: 40,
            textCancel: 'StringOK'.tr,
            cancelTextColor: Colors.blueAccent,
            barrierDismissible: false,
          );
          return false;
        }

        else {
          if (SMDIDController.text.isNotEmpty) {
            MES_ADD_EDIT = 'StringED'.tr;
            UpdateSto_Mov_D(
                SMKID==131?13:SMKID==0?1:SMKID!,
                SMMID!,
                int.parse(SMDIDController.text.toString()),
                MGNOController.text,
                SelectDataMINO.toString(),
                int.parse(SelectDataMUID.toString()),
                SMKID==17?double.parse(SMDNFController.text):double.parse(SMDNOController.text),
                SMKID==17?double.parse(SMDDF.toString()):double.parse(SMDNFController.text),
                SMKID==1 || SMKID==2 || SMKID==0 ?SMDEDController.text:SelectDataSNED.toString(),double.parse(SMDAMController.text),
                roundDouble(double.parse(SMDAMController.text) * SCEX!, 6),
                SMKID==17?0:roundDouble((double.parse(SMDAMController.text) * SCEX!) / SCEXS!, 6),
                SMKID==17?0:roundDouble(double.parse(MPCOController.text) / SCEXS!, 6),
                SMKID==17?0:double.parse(MPCOController.text),
                SMKID==17?0:roundDouble(double.parse(SMDAMController.text) * double.parse(SMDNOController.text), 6),
                SMKID==17?0: roundDouble(double.parse(SMDAMController.text) * double.parse(SMDNFController.text), 6));
          }
          else if (SMDIDController.text.isEmpty) {
            Count ??= 0;
            if (SMKID==17 &&  Count! > 0 && StteingController().isSwitchCollectionOfItems == true) {
              UpdateSMDNF(
                  SMKID==0?1: SMKID!,
                  SMMID!,
                  MGNOController.text.toString(),
                  SelectDataMINO.toString(),
                  int.parse(SelectDataMUID.toString()),
                  SMKID==17?double.parse(SMDNFController.text).toPrecision(1):double.parse(SMDNOController.text),
                  MIED.toString(),
                  SMKID==1 || SMKID==2 || SMKID==0 ? SMDEDController.text:SelectDataSNED.toString(),double.parse(SMDAMController.text));
              MES_ADD_EDIT = 'StringAD'.tr;
            } else  {
              Sto_Mov_D_Local e = Sto_Mov_D_Local(
                SMMID: SMMID,
                SMKID: SMKID==131?13: SMKID==0?1: SMKID,
                SMDID: SMDID,
                MGNO: MGNOController.text,
                MINO: SelectDataMINO,
                MUID: int.parse(SelectDataMUID.toString()),
                SMDNF: double.parse(SMDNFController.text),
                SMDNO: double.parse(SMDNOController.text),
                SMDDF: SMDDF,
                SMDAM: SMKID==17?0:SMDAMController.text.isEmpty?0:double.parse(SMDAMController.text),
                SMDEQ:SMKID==17?0:roundDouble(double.parse(SMDAMController.text) * SCEX!, 6),
                SMDEQC: SMKID==17?0:roundDouble((double.parse(SMDAMController.text) * SCEX!) / SCEXS!, 6),
                SMDED: SMKID==1 || SMKID==2 || SMKID==0 ? SMDEDController.text:SelectDataSNED,
                SMDDIF: SMKID==17?0:SMDNFController.text.isEmpty || double.parse(SMDNFController.text) <= 0 ? 0 : SMKID==17?0:SMDAMController.text.isEmpty?0:double.parse(SMDAMController.text),
                SMDAMR: SMKID==17?0:roundDouble(double.parse(MPCOController.text) / SCEXS!, 6),
                SMDAMRE: SMKID==17?0:double.parse(MPCOController.text),
                SMDAMT: SMKID==17?0:roundDouble(double.parse(SMDAMController.text) * double.parse(SMDNOController.text), 6),
                SMDAMTF:SMKID==17?0: roundDouble(double.parse(SMDAMController.text) * double.parse(SMDNFController.text), 6),
                GUID: GUIDD.toString().toUpperCase(),
                GUIDM: GUID.toString().toUpperCase(),
                SYST: SMMST,
                SIID: SMKID==13 || SMKID==131 ?int.parse(SelectDataSIID_F.toString()):int.parse(SelectDataSIID.toString()),
                SIIDT: SMKID==13 || SMKID==11 || SMKID==131?int.parse(SelectDataSIID_T.toString()):null,
                BIID: int.parse(SelectDataBIID.toString()),
                SUID: LoginController().SUID,
                DEVI: LoginController().DeviceName,
                DATEI:  DateFormat('dd-MM-yyyy HH:m').format(DateTime.now()),
                JTID_L: LoginController().JTID,
                BIID_L: LoginController().BIID,
                SYID_L: LoginController().SYID,
                CIID_L: LoginController().CIID,
              );
              SaveSto_Mov_D(e);
              MES_ADD_EDIT = 'StringAD'.tr;
            }
          }
          ClearSto_Mov_D_Data();
          SER_MINA = '';
          GETSTO_MOV_D(SMMID!, SER_MINA.toString());
          CheckBack = 1;
          Fluttertoast.showToast(
              msg: MES_ADD_EDIT,
              toastLength: Toast.LENGTH_LONG,
              textColor: Colors.white,
              backgroundColor: Colors.green);
          update();
          GET_CountSMDNF();
          GET_CountRecode();
          GET_SUMSMMAM();
          GETSTO_MOV_M_P('DateNow');
          ADD_EDformKey.currentState!.save;
          if(StteingController().SHOW_BRCODE_SAVE==true && edit == false){
            scanBarcodeNormal();
            myFocusNode.requestFocus();
          }
          return true;
        }
      }
    }catch (e) {
      Fluttertoast.showToast(
          msg: 'StrinError_save_data'.tr,
          toastLength: Toast.LENGTH_LONG,
          textColor: Colors.white,
          backgroundColor: Colors.redAccent);
      print("error-save_d ${e.toString()}");
      return false;
    }
    return true;
  }

  //حفظ حركة جرد مخزني الرئيسي
  bool Save_STO_MOV_M() {
     try {
    SMKID==17 || SMKID==13 || SMKID==131 || SMKID==11 ? SelectDataAANA==null:SelectDataAANA=SelectDataAANA;
    SMKID==17 || SMKID==13 || SMKID==131 || SMKID==11 ? SelectDataAANA==null:SelectDataAANO=SelectDataAANO;
    if (SelectDataSIID == null || SelectDataBIID == null) {
      Get.snackbar('StringErrorMes'.tr, 'StringError_MESSAGE'.tr,
          backgroundColor: Colors.red,
          icon: Icon(Icons.error, color: Colors.white),
          colorText: Colors.white,
          isDismissible: true,
          dismissDirection: DismissDirection.horizontal,
          forwardAnimationCurve: Curves.easeOutBack);
      return false;
    }

    else if ( (P_COS_SEQ=='1' || P_COSS=='1' ) && SelectDataACNO== null) {
      Fluttertoast.showToast(
          msg: 'StringACNO_ERR'.tr,
          toastLength: Toast.LENGTH_LONG,
          textColor: Colors.white,
          backgroundColor: Colors.redAccent);
      return false;
    }
    else if ((SMKID==0 || SMKID==1 || SMKID==3) &&  ((P_COSS=='2' || P_COSS=='3' || P_COSS=='4')  &&
        ((P_COS1=='1' && AKID==1 ) || (P_COS2=='1' && (AKID==2 || AKID==3) )) && SelectDataACNO== null)) {
      Fluttertoast.showToast(
          msg: 'StringACNO_ERR'.tr,
          toastLength: Toast.LENGTH_LONG,
          textColor: Colors.white,
          backgroundColor: Colors.redAccent);
      return false;
    }
    else if ((SMKID==0 || SMKID==1 || SMKID==3) && ((((P_COS1=='3' && AKID==1 ) ||  (P_COS2=='3' && (AKID==2 || AKID==3) )) && AACC==1)  &&  SelectDataACNO== null)) {
      Fluttertoast.showToast(
          msg: 'StringACNO_ERR'.tr,
          toastLength: Toast.LENGTH_LONG,
          textColor: Colors.white,
          backgroundColor: Colors.redAccent);
      return false;
    }
    else if ((SMKID==0 || SMKID==1 || SMKID==3) && (P_COSS=='3' && AACC==1 && SelectDataACNO== null)) {
      Fluttertoast.showToast(
          msg: 'StringACNO_ERR'.tr,
          toastLength: Toast.LENGTH_LONG,
          textColor: Colors.white,
          backgroundColor: Colors.redAccent);
      return false;
    }
    else {
      STO_MOV_M_Local e = STO_MOV_M_Local(
        SMMID: SMMID,
        SMMNO: SMMNO,
        BIID:  SelectDataBIID,
        BIIDT: SMKID==131?SelectDataBIID_T:null,
        SIID:  SMKID==13 || SMKID==131 ?SelectDataSIID_F:SelectDataSIID,
        SIIDT: SMKID==13 || SMKID==11 || SMKID==131 ? SelectDataSIID_T : null,
        SMKID: SMKID==131 ? 13 : SMKID==0 ? 1 : SMKID,
        SMMST: SMMST,
        BKID:  SMKID==0 ?-1:null,
        BMMID: SMKID==0 ? -1:null,
        AANO:  SelectDataAANO,
        AANO2: SelectDataAANA.toString(),
        SMMIN: SMKID==13 || SMKID==11 ? SMMINController.text.isEmpty?SMKID==131?'من الفرع:$SelectDataBIID الى الفرع:$SelectDataBIID_T':'من المخزن:$SelectDataSIID_F الى المخزن:$SelectDataSIID_T':SMMINController.text:SMMINController.text,
        SMMDO: '$SelectDays  ${DateFormat('HH:mm').format(DateTime.now())}',
        SMMDA: SMMRD.toString(),
        SMMRE: SMMREController.text,
        SMMAM: SMMAM,
        SCID:  SMKID==17 || SMKID==11?int.parse(SCID.toString()):int.parse(SelectDataSCID.toString()),
        SCEX:  SCEX,
        SCEXS: SCEXS,
        SMMEQ: roundDouble(SMMAM!  * SCEX!, 2),
        SMMDIF: SUMSMMDIF,
        ACNO: SelectDataACNO.toString().isEmpty || SelectDataACNO.toString().contains('null') || P_COSM!='1'?null:SelectDataACNO,
        //  SMKID=.=17?SNMIM=='4'?SelectDataACNO.toString():'':SelectDataACNO.toString(),
        SMMNN:AANA,
        SMMDI:0,
        SMMDIA:0,
        SMMCN: SMMCNController.text,
        SMMDR: SMMDRController.text,
        SUID: LoginController().SUID,
        DATEI:  DateFormat('dd-MM-yyyy HH:m').format(DateTime.now()),
        DEVI: LoginController().DeviceName,
        GUID: GUID.toString().toUpperCase(),
        SMMNR: int.parse(CountRecodeController.text),
        JTID_L: LoginController().JTID,
        BIID_L: LoginController().BIID,
        SYID_L: LoginController().SYID,
        CIID_L: LoginController().CIID,
      );
      SaveSto_Mov_M(e);
     // UPADTE_SIID(SMMID!, SelectDataSIID.toString());
      ClearSto_Mov_M_Data();
      CheckBack = 0;
      //save
      Get.snackbar(
          'StringMesSave'.tr, "${'StringMesSave'.tr}-$SMMID",
          backgroundColor: Colors.green,
          icon: Icon(Icons.save, color: Colors.white),
          colorText: Colors.white,
          isDismissible: true,
          dismissDirection: DismissDirection.horizontal,
          forwardAnimationCurve: Curves.easeOutBack);
      update();
     // formKey.currentState!.save;
      update();
      Get.offNamed('/Inventory');
      GET_STO_MOV_M_PRINT_P(SMKID!,SMMID!);
      GETSTO_MOV_M_P('DateNow');
      if(SMMST!=3){
        StteingController().isActivateAutoMoveSync==true && SMKID!=17 ?
        Socket_IP_Connect('SyncOnly',SMMID.toString(),true):false;
      }
      update();
      return true;
    }
    }catch (e) {
      Fluttertoast.showToast(
          msg: 'StrinError_save_data'.tr,
          toastLength: Toast.LENGTH_LONG,
          textColor: Colors.white,
          backgroundColor: Colors.redAccent);
      print("error-save_m ${e.toString()}");
      return false;
    }
  }

  //دالة التعديل الحركات
  Future<void> UpdateSTO_MOV_M_P(int id) async {
    SMKID==17 || SMKID==13 || SMKID==131 || SMKID==11 ? SelectDataAANA==null:SelectDataAANA=SelectDataAANA;
    SMKID==17 || SMKID==13 || SMKID==131 || SMKID==11 ? SelectDataAANA==null:SelectDataAANO=SelectDataAANO;
    if (SelectDataSIID == null || SelectDataBIID == null ) {
      Get.snackbar('StringErrorMes'.tr, 'StringError_MESSAGE'.tr,
          backgroundColor: Colors.red, icon: Icon(Icons.error,color:Colors.white),
          colorText:Colors.white,
          isDismissible: true,
          dismissDirection: DismissDirection.horizontal,
          forwardAnimationCurve: Curves.easeOutBack);
    } else {
      await UpdateSTO_MOV_M(
          id, SelectDataBIID.toString(), SelectDataSIID.toString(),SelectDataSIID_T.toString(),SMMST,SelectDataAANO.toString(),
          SelectDataAANA.toString(),SMMAM!,SMKID==17?SCID.toString():SelectDataSCID.toString(),
          SCEX!,roundDouble(SMMAM!  * SCEX!, 3),SMMINController.text,LoginController().SUID, DateFormat('dd-MM-yyyy HH:m').format(DateTime.now()),
          LoginController().DeviceName,SMKID==17?  P_COS_SEQ=='1' ? SelectDataACNO.toString() : '' : SelectDataACNO.toString());
      updateSYST(id,SMMST);
      Get.snackbar(
          'StringMesSave'.tr, "${'StringMesSave'.tr}-$SMMID",
          backgroundColor: Colors.green,
          icon: Icon(Icons.save,color:Colors.white),
          colorText:Colors.white,
          isDismissible: true,
          dismissDirection: DismissDirection.horizontal,
          forwardAnimationCurve: Curves.easeOutBack);
      loading(false);
      CheckBack = 0;
      GETSTO_MOV_M_P('DateNow');
      GET_STO_MOV_M_PRINT_P(SMKID!,SMMID!);
      Get.offNamed('/Inventory');
    }
  }

  //حذف حركة جرد مخزني الرئيسي
  bool delete_STO_MOV_M(int? Smmid,int type) {
    if(UPDL==1){
      if(type==1){
        DeleteSTO_MOV_D(SMMID!);
        DeleteSTO_MOV_M(SMMID!);
        Get.snackbar(
            'StringDelete'.tr,
            "${'StringDelete'.tr}-$SMMID",
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
        DeleteSTO_MOV_D(Smmid!);
        DeleteSTO_MOV_M(Smmid);
        Get.snackbar(
            'StringDelete'.tr,
            "${'StringDelete'.tr}-${Smmid}",
            backgroundColor: Colors.green,
            icon: Icon(Icons.delete,color:Colors.white),
            colorText:Colors.white,
            isDismissible: true,
            dismissDirection: DismissDirection.horizontal,
            forwardAnimationCurve: Curves.easeOutBack);
        onInit();
        update();
      }
      return true;
    }else {
      Get.snackbar('StringUPDL'.tr, 'String_CHK_UPDL'.tr,
          backgroundColor: Colors.red,
          icon: const Icon(Icons.error, color: Colors.white),
          colorText: Colors.white,
          isDismissible: true,
          dismissDirection: DismissDirection.horizontal,
          forwardAnimationCurve: Curves.easeOutBack);
      return false;
    }
  }

  //حذف حركة جرد مخزني الفرعية
  bool DeleteItem(String SMMID, String SMDID) {
    DeleteSTO_MOV_DOne(SMMID, SMDID);
    Fluttertoast.showToast(
        msg: 'StringDelete'.tr,
        toastLength: Toast.LENGTH_LONG,
        textColor: Colors.white,
        backgroundColor: Colors.redAccent);
    return true;
  }

  //حذف الحركة الفرعية عند الخروج من التطبيق
  Future Delete_Sto_Mov_D_DetectApp() async {
    GET_Sto_Mov_D_DetectApp().then((data) {
      if(data.isNotEmpty){
        DEL_STO_MOV_D = data;
        DEL_SMMID = DEL_STO_MOV_D.elementAt(0).SMMID;
        DeleteSTO_MOV_D(DEL_SMMID!);
      }
    });
  }

  scanBarcodeNormal() async {
    String barcodeScanRes;

    try {
      var result = await BarcodeScanner.scan();
      barcodeScanRes = result.rawContent;
    } catch (e) {
      barcodeScanRes = 'Failed to get barcode.';
    }

    _scanBarcode = barcodeScanRes;
    update();
    await FetchBarcodData(_scanBarcode);
    print(_scanBarcode);
    print('_scanBarcode');

    Timer(const Duration(milliseconds: 400), () {
      displayAddItemsWindo();
      myFocusNode.requestFocus();

      if (SMDAMController.text.isNotEmpty) {
        SMDAMController.selection = TextSelection(
          baseOffset: 0,
          extentOffset: SMDAMController.text.length,
        );
      }

      if (barcodData.isNotEmpty) {
        Timer(const Duration(milliseconds: 1300), () async {
          if (StteingController().isSave_Automatic == true) {
            bool isValid = await Save_STO_MOV_D();
            myFocusNode.requestFocus();

            if (isValid) {
              DataGrid();
              GET_CountSMDNF();
              GET_CountRecode();
              update();
            }
          }
        });
        update();
      }
    });

    myFocusNode.requestFocus();
  }

  // scanBarcodeNormal_old() async {
  //   String barcodeScanRes;
  //   // Platform messages may fail, so we use a try/catch PlatformException.
  //   try {
  //     barcodeScanRes = await FlutterBarcodeScanner.scanBarcode(
  //         '#ff6666', 'Cancel', true, ScanMode.BARCODE);
  //   } on PlatformException {
  //     barcodeScanRes = 'Failed to get platform version.';
  //   }
  //
  //   _scanBarcode = barcodeScanRes;
  //   update();
  //   await FetchBarcodData(_scanBarcode);
  //   print(_scanBarcode);
  //   print('_scanBarcode');
  //   Timer(const Duration(milliseconds: 400), () {
  //     displayAddItemsWindo();
  //     myFocusNode.requestFocus();
  //     if (SMDAMController.text.isEmpty) {
  //       return;
  //     } else {
  //       SMDAMController.selection = TextSelection(
  //           baseOffset: 0,
  //           extentOffset: SMDAMController.text.length);
  //     }
  //     if (barcodData.isNotEmpty) {
  //       Timer(const Duration(milliseconds: 1300), () async {
  //         if (StteingController().isSave_Automatic == true) {
  //           bool isValid = await Save_STO_MOV_D();
  //           myFocusNode.requestFocus();
  //           if (isValid) {
  //             DataGrid();
  //             GET_CountSMDNF();
  //             GET_CountRecode();
  //             update();
  //           }
  //         }
  //       });
  //       update();
  //     }
  //
  //   });
  //   myFocusNode.requestFocus();
  //
  // }


  //دوال المزامنة

  void configloading(String MES_ERR){
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

  void Socket_IP_Connect(String TypeSync, String GetSMMID,bool TypeAuto) async {
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
    EasyLoading.show(status: 'StringWeAreSync'.tr);
    Socket.connect(LoginController().IP, int.parse(LoginController().PORT), timeout: const Duration(seconds: 5)).then((socket) async {
      print("Success");
      SyncSTO_MOV_DToSystem(TypeSync,GetSMMID,TypeAuto);
      socket.destroy();
    }).catchError((error){
      Get.snackbar('StringCHK_Err_Con'.tr, 'StringCHK_Con'.tr,
          backgroundColor: Colors.red,
          icon: Icon(Icons.error,color:Colors.white),
          colorText:Colors.white,
          isDismissible: true,
          dismissDirection: DismissDirection.horizontal,
          forwardAnimationCurve: Curves.easeOutBack);
      configloading("StrinError_Sync".tr);
      print("Exception on Socket "+error.toString());
    });
  }

  Future SyncSTO_MOV_DToSystem(String TypeSync, String GetSMMID,TypeAuto) async {
    await SyncronizationData().FetchSTO_MOV_DData(TypeSync,  SMKID==131? 13 :SMKID==0? 1: SMKID!, GetSMMID).then((list_d) async {
      if (list_d.isNotEmpty && list_d.length>0) {
        TAB_N = SMKID==11?'STO_REQ_D':'STO_MOV_D';
        await SyncronizationData().SyncSTO_MOV_DToSystem(list_d, TypeSync, GetSMMID,SMKID==0? 1: SMKID!,SMKID==17?'STO_MOV_DC':
        SMKID==1 ? 'STO_MOV_DI':SMKID==3?'STO_MOV_DO':SMKID==11?'STO_MOV_DBSORD':SMKID==131?'STO_MOV_DBB':
        SMKID==0 ? 'STO_MOV_DF':'STO_MOV_DBS',TypeAuto);
        await Future.delayed(const Duration(seconds: 3));
        GETSTO_MOV_M_P('DateNow');
      } else{
        configloading("StringNoDataSync".tr);
      }
    });
  }

  void DataGrid() {
    DataGridPageInventory();
    GET_CountSMDNF();
    GET_CountRecode();
    GET_SUMSMMAM();
    update();
  }


  displayAddItemsWindo() {
    Get.bottomSheet(
      StatefulBuilder(builder: (BuildContext context, StateSetter setState) {
        double width = MediaQuery.of(context).size.width;
        double height = MediaQuery.of(context).size.height;
        return GetBuilder<InventoryController>(
            init: InventoryController(),
            builder: ((controller) => Form(
              key: controller.ADD_EDformKey,
              child: SingleChildScrollView(
                child: Column(
                  // mainAxisSize: MainAxisSize.min,
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
                            padding: EdgeInsets.only(right: 0.03 * width,left:0.03 * width),
                            child: Column(
                              children: [
                                SizedBox(height: 0.01 * height),
                                StteingController().isSwitchUse_Gro == false
                                    ? Container() : DropdownMAT_GROBuilder(),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Expanded(
                                      child: Autocomplete<Mat_Inf_Local>(
                                        optionsBuilder:
                                             (TextEditingValue textEditingValue) {
                                          return filterOptions(textEditingValue.text); },
                                        displayStringForOption: (Mat_Inf_Local option) =>
                                        controller.MINAController.text == '' ? '' : option.MINA_D,
                                        fieldViewBuilder: (BuildContext context,
                                            textEditingController,
                                            FocusNode myFocus,
                                            VoidCallback onFieldSubmitted) {
                                          return controller.MINAController.text ==
                                              ''
                                              ? TextFormField(
                                            controller: textEditingController,
                                            focusNode: myFocus,
                                            validator: (v) {
                                              return controller.validateMINO(v!);
                                            },
                                            style: const TextStyle(
                                                fontWeight: FontWeight.bold),
                                            textAlign: TextAlign.center,
                                            decoration:  InputDecoration(
                                              labelText: 'StringMINO'.tr,
                                            ),
                                          )
                                              : TextFormField(
                                            controller:
                                            controller.MINAController,
                                            validator: (v) {
                                              return controller
                                                  .validateMINO(v!);
                                            },
                                            style:  ThemeHelper().buildTextStyle(context, Colors.black,'M'),
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
                                                      ClearSto_Mov_D_Data();
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
                                                onPressed: () {
                                                  setState(() {
                                                    if (SelectDataMUID
                                                        .toString()
                                                        .isNotEmpty) {
                                                      Get.defaultDialog(
                                                        title: '${MINAController.text}. ${SelectDataMUCNA}',
                                                        backgroundColor:
                                                        Colors.white,
                                                        radius: 30,
                                                        content: Column(
                                                            children: [
                                                              Row(
                                                                mainAxisAlignment: MainAxisAlignment.start,
                                                                children: [
                                                                  Text(
                                                                    "${'StringMgno2'.tr}:",
                                                                    style: ThemeHelper().buildTextStyle(context, Colors.black87,'M'),
                                                                  ),
                                                                  SizedBox(height: 0.015 * height),
                                                                  Text(
                                                                    controller
                                                                        .MGNA,
                                                                    style: ThemeHelper().buildTextStyle(context, Colors.black87,'M'),
                                                                  ),
                                                                ],
                                                              ),
                                                              SizedBox(height: 0.015 * height),
                                                              Row(
                                                                mainAxisAlignment: MainAxisAlignment.start,
                                                                children: [
                                                                  Text(
                                                                    "${'String_BDNO_F'.tr}:",
                                                                    style: ThemeHelper().buildTextStyle(context, Colors.black87,'M'),
                                                                  ),
                                                                  SizedBox(height: 0.015 * height),
                                                                  Text(
                                                                    '${BDNO_F}',
                                                                    style: ThemeHelper().buildTextStyle(context, Colors.black87,'M'),
                                                                  ),
                                                                ],
                                                              ),
                                                              SizedBox(height: 0.015 * height),
                                                              UPIN2 != 2 && SMKID!=11
                                                                  ? Row(
                                                                mainAxisAlignment:
                                                                MainAxisAlignment.start,
                                                                children: [
                                                                  Text("${'StringMPCO'.tr}:",
                                                                    style: ThemeHelper().buildTextStyle(context, Colors.black87,'M'),
                                                                  ),
                                                                  SizedBox(height: 0.015 * height),
                                                                  Text(
                                                                    SMDAM.toString(),
                                                                    style: ThemeHelper().buildTextStyle(context, Colors.black87,'M'),
                                                                  ),
                                                                ],
                                                              )
                                                                  : Text(""),
                                                              SizedBox(height: 0.015 * height),
                                                              SMKID==17?
                                                              Row(
                                                                mainAxisAlignment: MainAxisAlignment.start,
                                                                children: [
                                                                  Text("${'StringNum_Inv_MINO'.tr}:",
                                                                    style: ThemeHelper().buildTextStyle(context, Colors.black87,'M'),
                                                                  ),
                                                                  SizedBox(height: 0.015 * height),
                                                                  Text(
                                                                    NUM_INV_MINO.toString(),
                                                                    style: ThemeHelper().buildTextStyle(context, Colors.black87,'M'),
                                                                  ),
                                                                ],
                                                              ):Container(),
                                                            ]),
                                                        textCancel: 'StringHide'.tr,
                                                        cancelTextColor: Colors.blueAccent,
                                                        // barrierDismissible: false,
                                                      );
                                                    }
                                                  });
                                                },
                                              ),
                                              labelText: 'StringMINO'.tr,
                                            ),
                                          );
                                        },
                                        onSelected: (Mat_Inf_Local selection) {
                                          setState(() {
                                            SelectDataMINO = selection.MINO.toString();
                                            MGNOController.text = selection.MGNO.toString();
                                            MIED=selection.MIED;
                                            Timer(const Duration(milliseconds: 90), () async {
                                                await  GETMUIDS();
                                                  MINAController.text = selection.MINA_D.toString();
                                                  setState(() {
                                                    myFocusNode.requestFocus();
                                                  });
                                                });
                                            Timer(const Duration(milliseconds: 280), () async {
                                              if (StteingController().isSave_Automatic == true && SMKID==17) {
                                                  bool isValid = await Save_STO_MOV_D();
                                                  if (isValid) {
                                                    DataGrid();
                                                     GET_CountSMDNF();
                                                     GET_CountRecode();
                                                    update();
                                                  }
                                              }
                                            });
                                          });
                                        },
                                        optionsViewBuilder: (BuildContext context,
                                            AutocompleteOnSelected<Mat_Inf_Local>
                                            onSelected,
                                            Iterable<Mat_Inf_Local> options) {
                                          return Align(
                                            alignment: Alignment.topLeft,
                                            child: Material(
                                              child: Container(
                                                width: double.infinity,
                                                height: 0.17 * height,
                                                color: Colors.white54,
                                                child: ListView.builder(
                                                  itemCount: options.length,
                                                  itemBuilder:
                                                      (BuildContext context,
                                                      int index) {
                                                    final Mat_Inf_Local option =
                                                    options.elementAt(index);
                                                    return GestureDetector(
                                                      onTap: () {
                                                        onSelected(option);
                                                      },
                                                      child: Center(
                                                          child: Padding(
                                                            padding:
                                                            EdgeInsets.all(0.009 * height),
                                                            child: Text(option.MINA_D,
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
                                            ),
                                          );
                                        },
                                      ),
                                    ),
                                    StteingController().isSwitchBrcode ? Padding(
                                      padding: EdgeInsets.only(
                                          left:  0.015 * height),
                                      child: IconButton(
                                          icon: Icon(
                                            Icons.camera_alt,
                                            size: 0.04  * height,
                                          ),
                                          onPressed: () {
                                            setState(() {
                                              Navigator.of(context).pop(false);
                                              scanBarcodeNormal();
                                              myFocusNode.requestFocus();
                                            });
                                            // buildAlert(context).show();
                                          }),
                                    )
                                        : Padding(
                                      padding: EdgeInsets.only(
                                          left: 0.02 * height),
                                      child: const Text(""),
                                    ),
                                  ],
                                ),

                                Row(
                                  children: [
                                    Expanded(
                                        child: Container(
                                          margin: EdgeInsets.only(
                                            left: 0.02 * height,),
                                          child:  DropdownMat_Uni_CBuilder(),)
                                    ),
                                    SizedBox(width: 0.02 * height),
                                    Expanded(
                                      child: Container(
                                        margin: EdgeInsets.only(
                                          bottom: 0.01*height,
                                          left: 0.02 * height,
                                        ),
                                        child:SMKID==17  ?
                                        StatefulBuilder(
                                          builder: (BuildContext context, StateSetter setState) {
                                            return TextFormField(
                                              controller: SMDNFController,
                                              keyboardType: TextInputType.number,
                                              textAlign: TextAlign.center,
                                              focusNode: myFocusNode,
                                              decoration: InputDecoration(
                                                  labelText: 'StringSMDFN'.tr,
                                                  hintText: SMDNFHintController.text.toString(),
                                                  hintStyle: const TextStyle(
                                                      color: Colors.blue)),
                                              validator: (v) {
                                                return validateSMDFN(
                                                    SMDNFHintController.text.toString());
                                              },
                                              onTap: () {
                                                GET_COU_B();
                                              },
                                            );
                                          },
                                        ):
                                        TextFormField(
                                          controller: SMDNOController,
                                          keyboardType: TextInputType.number,
                                          textAlign: TextAlign.center,
                                          focusNode: myFocusNode,
                                          textInputAction: TextInputAction.go,
                                          onFieldSubmitted: (String value) {
                                            myFocusSMDFN.requestFocus();
                                            if (SMDNFController.text.isEmpty) {
                                              return;
                                            } else {
                                              SMDNFController.selection = TextSelection(baseOffset: 0, extentOffset: SMDNFController.text.length);
                                            }
                                          },
                                          decoration: InputDecoration(
                                              labelText: 'StringSNNO'.tr,
                                              hintStyle: const TextStyle(
                                                  color: Colors.blue)),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                SMKID==1 || SMKID==3 || SMKID==0?
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Expanded(
                                      child: Container(
                                        margin: EdgeInsets.only(
                                          bottom: 0.02 * height,
                                          left: 0.02 * height,
                                        ),
                                        child: TextFormField(
                                          controller: SMDNFController,
                                          focusNode: myFocusSMDFN,
                                          keyboardType: TextInputType.number,
                                          textAlign: TextAlign.center,
                                          textInputAction: TextInputAction.go,
                                          onFieldSubmitted: (String value) {
                                            myFocusSMMAM.requestFocus();
                                            if (SMDAMController.text.isEmpty) {
                                              return;
                                            } else {
                                              SMDAMController.selection = TextSelection(
                                                baseOffset: 0,
                                                extentOffset: SMDAMController.text.length,
                                              );
                                            }
                                          },
                                          decoration: InputDecoration(
                                            labelText: 'StringSMDNF'.tr,
                                            hintStyle: const TextStyle(
                                              color: Colors.blue,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                    SizedBox(width: 0.02 * height),
                                    SMKID==11? Container(): Expanded(
                                      child: Container(
                                        margin: EdgeInsets.only(
                                          bottom: 0.02 * height,
                                          left: 0.02 * height,
                                        ),
                                        child: TextFormField(
                                          controller: SMDAMController,
                                          keyboardType: TextInputType.number,
                                          textAlign: TextAlign.center,
                                          focusNode: myFocusSMMAM,
                                          readOnly: SMKID==3 && UPIN_OUT==2?true:false,
                                          decoration: InputDecoration(
                                            labelText: 'StringMPCO'.tr,
                                            hintStyle: const TextStyle(
                                              color: Colors.blue,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                )
                                    :Container(),
                                SMKID!=11 ?
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Expanded(
                                        child:
                                        SMKID == 1 || SMKID == 2 || SMKID==0?
                                        Container(
                                          width: MediaQuery.of(context).size.width / 3,
                                          margin: EdgeInsets.only(
                                              left: 0.02 * height,
                                              bottom: 0.02 * height),
                                          child:TextFormField(
                                            controller: SMDEDController,
                                            textAlign: TextAlign.center,
                                            decoration: InputDecoration(
                                              labelText:  'StringSMDED'.tr,
                                            ),
                                            onChanged: (value){
                                              selectDateFromDays2(context);
                                            },
                                            onTap: () {
                                              setState(() {
                                                selectDateFromDays2(context);
                                              });
                                            },
                                          ),
                                        )
                                            :Container(
                                          margin: EdgeInsets.only(
                                            bottom: 0.02 * height,
                                            left: 0.02 * height,
                                          ),
                                          child: DropdownMat_Date_endBuilder(),
                                        )

                                    ),
                                    SizedBox(width: 0.02 * height),
                                    Expanded(
                                      child: Container(
                                        margin: EdgeInsets.only(
                                          left: 0.02 * height,),
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
                                                      right:0.02 * height)),
                                            ),
                                            child: Text(
                                              TextButton_T,
                                              style: ThemeHelper().buildTextStyle(context, Colors.black,'M'),
                                            ),
                                            onPressed: () async {
                                              if (Count! > 0 && StteingController().isSwitchShowMesMat == true &&
                                                  SMDIDController.text.isEmpty) {
                                                Get.defaultDialog(
                                                  title: 'StringMestitle'.tr,
                                                  middleText: 'StringMesCount'.tr,
                                                  backgroundColor: Colors.white,
                                                  radius: 40,
                                                  textCancel: 'StringNo'.tr,
                                                  cancelTextColor: Colors.red,
                                                  textConfirm: 'StringYes'.tr,
                                                  confirmTextColor: Colors.white,
                                                  onConfirm: () async {
                                                    Navigator.of(context).pop(false);
                                                      bool isValid = await Save_STO_MOV_D();
                                                      if (isValid) {
                                                        DataGrid();
                                                        GET_CountSMDNF();
                                                        GET_CountRecode();
                                                        controller.update();
                                                      }
                                                  },
                                                  barrierDismissible:
                                                  false,
                                                );
                                              } else {

                                                  bool isValid = await Save_STO_MOV_D();
                                                  if (isValid) {
                                                    DataGrid();
                                                    GET_CountSMDNF();
                                                    GET_CountRecode();
                                                    update();
                                                  }
                                              }
                                            },
                                          );
                                        }),
                                      ),
                                    ),
                                  ],
                                ) :
                                Container(
                                  width: MediaQuery.of(context).size.width / 3,
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
                                          TextButton_T,
                                          style:  ThemeHelper().buildTextStyle(context, Colors.black,'M')
                                      ),
                                      onPressed: () async {
                                        if (Count! > 0 && StteingController().isSwitchShowMesMat == true &&
                                            SMDIDController.text.isEmpty) {
                                          Get.defaultDialog(
                                            title: 'StringMestitle'.tr,
                                            middleText: 'StringMesCount'.tr,
                                            backgroundColor:
                                            Colors.white,
                                            radius: 40,
                                            textCancel: 'StringNo'.tr,
                                            cancelTextColor: Colors.red,
                                            textConfirm: 'StringYes'.tr,
                                            confirmTextColor: Colors.white,
                                            onConfirm: () async {
                                              Navigator.of(context).pop(false);

                                                bool isValid = await Save_STO_MOV_D();
                                                if (isValid) {
                                                  DataGrid();
                                                  GET_CountSMDNF();
                                                  GET_CountRecode();
                                                  update();
                                                }
                                            },
                                            barrierDismissible:false,
                                          );
                                        } else {
                                            await Save_STO_MOV_D();
                                            DataGrid();
                                            GET_CountSMDNF();
                                            GET_CountRecode();
                                            update();
                                        }
                                      },
                                    );
                                  }),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            )));
      }),
    );
  }

  List<Mat_Inf_Local> filterOptions(String query) {
    return  autoCompleteData.where((county) =>
        "${county.MINO ?? ''}${county.MINA_D ?? ''}${county.MUCBC ?? ''}${county.MPS1 ?? ''}"
            .toLowerCase()
            .contains(query.toLowerCase()))
        .toList().obs;
  }



  FutureBuilder<List<Mat_Uni_C_Local>> DropdownMat_Uni_CBuilder() {
    return FutureBuilder<List<Mat_Uni_C_Local>>(
        future: GETMAT_UNI_C(MGNOController.text.toString(), SelectDataMINO.toString()),
        builder: (BuildContext context,
            AsyncSnapshot<List<Mat_Uni_C_Local>> snapshot) {
          if (!snapshot.hasData) {
            return Dropdown2(josnStatus: josnStatus);
          }
          return DropdownButtonFormField2(
            isExpanded: true,
            hint: ThemeHelper().buildText(context,'StringMUID', Colors.grey,'S'),
            value: SelectDataMUID,
            style: ThemeHelper().buildTextStyle(context, Colors.black,'M'),
            items: snapshot.data!
                .map((item) => DropdownMenuItem<String>(
              onTap: () {
                SelectDataMUCNA = item.MUNA_D.toString();
              },
              value: item.MUID.toString(),
          child: Text(
          "${item.MUID.toString()} - ${item.MUNA_D
              .toString()}",
                style: ThemeHelper().buildTextStyle(context, Colors.black,'M'),
              ),
            ))
                .toList()
                .obs,
            validator: (value) {
              if (value == null) {
                return 'StringvalidateMUID'.tr;
              }
              return null;
            },
            onChanged: (value) {
              SMDNFHintController.text = '';
              SelectDataMUID = value.toString();
              Get_Sto_Num(value.toString());
              SMKID==3 || SMKID==13?Get_STO_NUM_Out_Voucher(value.toString()):false;
              Timer(const Duration(milliseconds: 90), () {
                myFocusNode.requestFocus();
              });
            },
          );
        });
  }

  FutureBuilder<List<Sto_Num_Local>> DropdownMat_Date_endBuilder() {
    return FutureBuilder<List<Sto_Num_Local>>(
        future: GET_SMDED(
            MGNOController.text.toString(),
            SelectDataMINO.toString(),
            SelectDataSIID.toString(),
            SelectDataMUID.toString(),
            SMKID.toString()),
        builder: (BuildContext context,
            AsyncSnapshot<List<Sto_Num_Local>> snapshot) {
          if (!snapshot.hasData) {
            return Dropdown2(josnStatus: josnStatus);
          }
          return DropdownButtonFormField2(
            isExpanded: true,
            hint: ThemeHelper().buildText(context,'StringSMDED', Colors.grey,'S'),
            value: SelectDataSNED,
            style: ThemeHelper().buildTextStyle(context, Colors.black,'M'),
            items: snapshot.data!
                .map((item) => DropdownMenuItem<String>(
              value: item.SNED.toString(),
              onTap: () {
                Get_STO_NUM_Out_Voucher(SelectDataMUID.toString());
                update();
              },
              child: Text(
                item.SNED.toString(),
                style: ThemeHelper().buildTextStyle(context, Colors.black,'M'),
              ),
            )).toList().obs,

            // validator: (value) {
            //   if (value == null) {
            //     return 'StringvalidateSMDED'.tr;
            //   }
            //   return null;
            // },
            onChanged: (value) {
              SelectDataSNED = value.toString();
              Get_STO_NUM_Out_Voucher(SelectDataMUID.toString());
            },
          );
        });
  }

  GetBuilder<InventoryController> DropdownMAT_GROBuilder() {
    return GetBuilder<InventoryController>(
        init: InventoryController(),
        builder: ((controller) => FutureBuilder<List<Mat_Gro_Local>>(
            future: GETGRO_INF(),
            builder: (BuildContext context,
                AsyncSnapshot<List<Mat_Gro_Local>> snapshot) {
              if (!snapshot.hasData) {
                return Dropdown(
                  josnStatus: josnStatus,
                  GETSTRING: 'StringBrach',
                );
              }
              return DropdownButtonFormField2(
                isDense: true,
                isExpanded: true,
                hint: ThemeHelper().buildText(context,'StringMgno', Colors.grey,'S'),
                dropdownStyleData: const DropdownStyleData(
                  maxHeight: 200,
                ),
                items: snapshot.data!
                    .map((item) => DropdownMenuItem<String>(
                  value:
                  "${item.MGNO.toString() + " +++ " + item.MGNA_D.toString()}",
                  // value: item.MGNO.toString(),
                  onTap: () {
                    fetchAutoCompleteData();
                    update();
                  },
                  child: Text(
                    item.MGNA_D.toString(),
                    style: ThemeHelper().buildTextStyle(context, Colors.black,'M'),
                  ),
                ))
                    .toList()
                    .obs,
                value: SelectDataMGNA,
                onChanged: (value) {
                  SelectDataMINO = null;
                  ClearSto_Mov_D_Data();
                  MGNOController.text =
                  value.toString().split(" +++ ")[0];
                  fetchAutoCompleteData();
                  update();
                },
                dropdownSearchData: DropdownSearchData(
                    searchController: TextEditingSercheController,
                    searchInnerWidget: Padding(
                      padding: const EdgeInsets.only(
                        top: 8,
                        bottom: 4,
                        right: 8,
                        left: 8,
                      ),
                      child: TextFormField(
                        controller: TextEditingSercheController,
                        decoration: InputDecoration(
                          isDense: true,
                          contentPadding: const EdgeInsets.symmetric(
                            horizontal: 10,
                            vertical: 8,
                          ),
                          hintText: 'StringSearch_for_MGNO'.tr,
                          hintStyle: ThemeHelper().buildTextStyle(context, Colors.grey,'S'),
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
                    TextEditingSercheController.clear();
                  }
                },
              );
            })));
  }


}
