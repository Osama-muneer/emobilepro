import 'dart:async';
import 'dart:io';
import 'dart:math';
import 'package:dropdown_button2/dropdown_button2.dart';
import '../../Operation/Views/Approve/add_approve_view.dart';
import '../../Operation/models/bif_cou_c.dart';
import '../../Operation/models/bif_cou_m.dart';
import '../../Setting/controllers/login_controller.dart';
import '../../Setting/controllers/setting_controller.dart';
import '../../Setting/models/bil_cre_c.dart';
import '../../Setting/models/bil_cus.dart';
import '../../Setting/models/bil_poi.dart';
import '../../Setting/models/bra_inf.dart';
import '../../Setting/models/bra_yea.dart';
import '../../Setting/models/cou_inf_m.dart';
import '../../Setting/models/cou_red.dart';
import '../../Setting/models/cou_typ_m.dart';
import '../../Setting/models/pay_kin.dart';
import '../../Setting/models/sys_cur.dart';
import '../../Setting/models/sys_doc_d.dart';
import '../../Setting/models/sys_own.dart';
import '../../Setting/models/sys_var.dart';
import '../../Setting/models/usr_pri.dart';
import '../../Setting/services/api_provider_login.dart';
import '../../Setting/services/syncronize.dart';
import '../../Widgets/colors.dart';
import '../../Widgets/config.dart';
import '../../Widgets/dimensions.dart';
import '../../Widgets/dropdown.dart';
import '../../Widgets/theme_helper.dart';
import '../../database/invoices_db.dart';
import '../../database/setting_db.dart';
import '../../database/sync_db.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';
import 'package:uuid/uuid.dart';

import '../models/bil_mov_m.dart';

class Counter_Sales_Approving_Controller extends GetxController {
  RxBool loading = false.obs;
  final DataGridController dataGridController = DataGridController();
  String SelectFromTime = '00:01 AM',
      SelectToTime = '23:59 PM',
      Fromtimeperiod = '',
      Totimeperiod = '';
  RxBool loadingerror = false.obs;
  var isloadingvalidator = false.obs;
  var isloading = false.obs;
  bool isloadingInstallData = false, isPrint = true;
  final ADD_EDformKey = GlobalKey<FormState>();
  RxnString errorTextBIID = RxnString(null);
  RxnString errorTextBPID = RxnString(null);
  RxnString errorTextCTMID = RxnString(null);
  RxnString errorTextSCID = RxnString(null);
  RxnString errorTextPKID = RxnString(null);
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  FocusNode contentFocusNode = FocusNode();
  late FocusNode myFocusNode;
  final String _selectedDate =
      DateFormat('dd-MM-yyyy hh:mm').format(DateTime.now());
  final String _selectedDatesercher =
      DateFormat('dd-MM-yyyy').format(DateTime.now());
  DateTime dateFromDays1 = DateTime.now();
  String dateFromDays = DateFormat('dd-MM-yyyy').format(DateTime.now());
  DateTime dateTimeToDays2 = DateTime.now();
  String dateTimeToDays = DateFormat('dd-MM-yyyy hh:mm').format(DateTime.now());
  String? SelectDataBIID,
      SelectDataSIID,
      SelectDataBPID,
      SelectDataCTMID,
      SelectDataSCID,
      SelectDataCIMID,
      errorText,
      CRPD,
      ALLOW_MPS1,
      P_PRI_COS,
      SelectFromDays,
      SelectToDays,
      SelectDataACID,
      SelectDataACNO,
      SelectToBCMTD;
  String titleScreen = '',
      titleAddScreen = '',
      StringButton = '',
      MES_ADD_EDIT = '',
      Keyword = '',
      BINA = '',
      SCID = '',
      SMDED = '',
      SUCH = '',
      DEVI = '',
      DEVU = '',
      DATEU = '',
      SINA = '',
      SDDSA = '',
      SONA = '',
      SONE = '',
      SORN = '',
      SOLN = '',
      SYED = '',
      SelectNumberOfDays = '',
      MGNO = '',
      MGNA = '',
      STB_N = '',
      title = "",
      title2 = "",
      Type = "1",
      SCSY = '';
  var dbHelper, GUID, GUIDD;
  var uuid = Uuid();
  bool edit = false;
  bool editd = false;
  late List<Cou_Inf_M_Local> COU_INF_M_List = [];
  late List<Cou_Typ_M_Local> COU_TYP_M_List = [];
  late List<Bil_Cus_Local> BIL_CUS_List = [];
  late List<Bil_Cre_C_Local> BIL_CRE_C_List = [];
  late List<Bif_Cou_M_Local> BIF_COU_M_List = [];
  late List<Bra_Yea_Local> BRA_YEA;
  late List<Usr_Pri_Local> USR_PRI;
  late List<Bil_Poi_Local> BOL_POI;
  late List<Cou_Typ_M_Local> COU_TYP_M;
  late List<Sys_Cur_Local> SYS_CUR;
  late List<Pay_Kin_Local> PAY_KIN;
  late List<Cou_Inf_M_Local> COU_INF_M;
  late List<Bif_Cou_M_Local> BIF_COU_M;
  late List<Bif_Cou_C_Local> BIF_COU_C;
  late List<Bif_Cou_C_Local> BIF_COU_C_COUNT;
  late List<Bif_Cou_C_Local> BIF_COU_C_DATE;
  late List<Sys_Doc_D_Local> GET_SYS_DOC;
  late List<Sys_Own_Local> SYS_OWN;
  late List<Sys_Var_Local> SYS_VAR;
  late List<Cou_Red_Local> COU_RED;
  late List<Bil_Mov_M_Local> COUNT_BMMID_P;
  late List<Bif_Cou_C_Local> SUM_Bif_COU_C;
  late List<Bil_Mov_M_Local> COUNT_SUMCredit_P;
  int? BCMID,
      BCCID,
      COUNTBCCID,
      BMDID,
      BCMNO,
      CheckBack = 0,
      Count = 0,
      UPIN = 1,
      UPCH = 1,
      UPQR = 1,
      UPDL = 1,
      UPPR = 1,
      COUNT_BMMID,
      CheckHomeScreen,
      SMDID_MAX,
      BYST = 1,
      UPIN2 = 1,
      UPCH2 = 1,
      UPQR2 = 1,
      UPDL2 = 1,
      UPPR2 = 1,
      DEL_SMMID,
      PKID = 1,
      UPIN_PKID = 1;
  int COUNT = 0, SCSFL = 2, COUNTCIMID = 0;
  double BMDAMT = 0,
      BMDAM1 = 0,
      BMDAM = 0,
      BMDTXAT = 0,
      BMDNO = 0,
      COUNT_BMMAM = 0,
      SCEX = 0,
      timecompare = 0,
      FromTime = 0,
      ToTime = 0,
      SUMCashier = 0,
      SUMCredit = 0,
      SUMCredit2 = 0,
      SUMCredit3 = 0,
      DEF_MOUNT = 0,
      DEF_COU = 0;
  late TextEditingController BCIDController,
      BCNAController,
      BCCIDController,
      BCMRNController,
      MINAController,
      BMDNOController,
      BCMTAController,
      CTMIDController,
      CIMIDController,
      SIIDController,
      GUIDController,
      SMDIDController,
      BPIDController,
      BCMAMController,
      BCMROController,
      MGNOController,
      MUIDController,
      MINOController,
      DEF_COUController,
      BCCID1Controller,
      BCCID2Controller,
      BCCID3Controller,
      BCCNA1Controller,
      BCCNA2Controller,
      BCCNA3Controller,
      BCMAM1Controller,
      BCMAM2Controller,
      BCMAM3Controller,
      BCMINController,
      SCIDOController,
      SUMBCMAMCController;
  static const MaterialColor buttonTextColor = const MaterialColor(
    0xFFEF5350,
    const <int, Color>{
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

  Future<void> selectDateFromDays(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: dateFromDays1,
      firstDate: DateTime(2022, 5),
      lastDate: DateTime(2030),
      builder: (context, child) {
        return Theme(
          data: ThemeData.light().copyWith(
              primaryColor: const Color(0xFF4A5BF6),
              colorScheme:
                  ColorScheme.fromSwatch(primarySwatch: buttonTextColor)
                      .copyWith(
                          secondary: const Color(0xFF4A5BF6)) //selection color
              ),
          child: child!,
        );
      },
    );

    if (picked != null) {
      dateFromDays1 = picked;
      final difference = dateTimeToDays2.difference(dateFromDays1).inDays;
      update();
      if (difference >= 0) {
        SelectFromDays = DateFormat("dd-MM-yyyy hh:mm").format(picked);
      } else {
        Fluttertoast.showToast(
            msg: "StringcompareDate".tr,
            textColor: Colors.white,
            backgroundColor: Colors.black);
      }
    }
    update();
    refresh();
  }

  Future<void> selectDateToDays(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: dateTimeToDays2,
      firstDate: DateTime(2022, 5),
      lastDate: DateTime(2030),
      builder: (context, child) {
        return Theme(
          data: ThemeData.light().copyWith(
              primaryColor: const Color(0xFF4A5BF6),
              colorScheme:
                  ColorScheme.fromSwatch(primarySwatch: buttonTextColor)
                      .copyWith(
                          secondary: const Color(0xFF4A5BF6)) //selection color
              ),
          child: child!,
        );
      },
    );
    if (picked != null) {
      dateTimeToDays2 = picked;
      final difference = dateTimeToDays2.difference(dateFromDays1).inDays;
      update();
      if (difference >= 0) {
        SelectToDays = DateFormat("dd-MM-yyyy hh:mm").format(picked);
        SelectToBCMTD = DateFormat("dd-MM-yyyy hh:mm").format(picked);
      } else {
        Fluttertoast.showToast(
            msg: "StringcompareDate".tr,
            textColor: Colors.white,
            backgroundColor: Colors.black);
      }
    }
    update();
    refresh();
  }

  void onInit() async {
    SUMBCMAMCController = TextEditingController();
    BPIDController = TextEditingController();
    BCIDController = TextEditingController();
    BCNAController = TextEditingController();
    BCCIDController = TextEditingController();
    BCMRNController = TextEditingController();
    MGNOController = TextEditingController();
    MINOController = TextEditingController();
    MUIDController = TextEditingController();
    CTMIDController = TextEditingController();
    CIMIDController = TextEditingController();
    SIIDController = TextEditingController();
    GUIDController = TextEditingController();
    BMDNOController = TextEditingController();
    BCMAMController = TextEditingController();
    SCIDOController = TextEditingController();
    BCMTAController = TextEditingController();
    BCMROController = TextEditingController();
    DEF_COUController = TextEditingController();
    BCCID1Controller = TextEditingController();
    BCCID2Controller = TextEditingController();
    BCCID3Controller = TextEditingController();
    BCMAM1Controller = TextEditingController();
    BCMAM2Controller = TextEditingController();
    BCMAM3Controller = TextEditingController();
    BCMINController = TextEditingController();
    BCCNA1Controller = TextEditingController();
    BCCNA2Controller = TextEditingController();
    BCCNA3Controller = TextEditingController();
    myFocusNode = FocusNode();
    SelectDataBIID = LoginController().BIID.toString();
    GET_BIF_COU_M_P("DateNow");
    GET_BCMID_P();
    GET_PRIVLAGE();
    GET_BRA_YEA_P();
    GET_SYS_DOC_D();
    GET_Sys_Own();
    GET_BIL_CRE_C_P();
    GET_BIL_POI_ONE_P();
    GET_COU_TYP_M_ONE_P();
    GET_SYS_CUR_ONE_P();
    GET_BCMNO_P();
    GET_COUNT_BMMID_P();

  }

  @override
  void dispose() {
    // TODO: implement dispose
    SUMBCMAMCController.dispose();
    BPIDController.dispose();
    BCIDController.dispose();
    BCNAController.dispose();
    BCCIDController.dispose();
    BCMRNController.dispose();
    MGNOController.dispose();
    MINOController.dispose();
    MUIDController.dispose();
    CTMIDController.dispose();
    CIMIDController.dispose();
    SIIDController.dispose();
    GUIDController.dispose();
    BMDNOController.dispose();
    BCMAMController.dispose();
    SCIDOController.dispose();
    BCMTAController.dispose();
    BCMROController.dispose();
    DEF_COUController.dispose();
    BCCID1Controller.dispose();
    BCCID2Controller.dispose();
    BCCID3Controller.dispose();
    BCMAM1Controller.dispose();
    BCMAM2Controller.dispose();
    BCMAM3Controller.dispose();
    BCMINController.dispose();
    BCCNA1Controller.dispose();
    BCCNA2Controller.dispose();
    BCCNA3Controller.dispose();
    myFocusNode.dispose();
    super.dispose();
  }

  //اظهار البيانات +البحث
  GET_BIF_COU_M_P(String type) async {
      BIF_COU_M_List=await GET_BIF_COU_M(type,type == "DateNow"?_selectedDatesercher:
      type == "FromDate"? SelectNumberOfDays:'');
      update();
  }

  String? validate_Continue() {
    errorTextBIID.value = null;
    errorTextBPID.value = null;
    errorTextCTMID.value = null;
    errorTextSCID.value = null;
    errorTextPKID.value = null;
    try {
      if (SelectDataBIID == null) {
        errorTextBIID.value = 'StringvalidateBIID'.tr;
        loadingerror(true);
        update();
        return 'StringvalidateBIID'.tr;
      } else if (SelectDataBPID == null) {
        errorTextBPID.value = 'StringvalidateBPID'.tr;
        loadingerror(true);
        update();
        return 'StringvalidateBPID'.tr;
      } else if (SelectDataCTMID == null) {
        errorTextCTMID.value = 'StringvalidateCTMID'.tr;
        loadingerror(true);
        update();
        return 'StringvalidateCTMID'.tr;
      } else if (SelectDataSCID == null) {
        errorTextSCID.value = 'StringvalidateSCID'.tr;
        loadingerror(true);
        update();
        return 'StringvalidateSCID'.tr;
      } else {
        // LoginController().setInstallData(isloadingInstallData);
        errorTextBIID.value = null;
        errorTextBPID.value = null;
        errorTextCTMID.value = null;
        errorTextSCID.value = null;
        update();
        return null;
      }
    } catch (e) {
      errorText = 'StringErrorDefault_SNNO_NUM'.tr;
      update();
    }
    return null;
  }


  //صلاحيات الفاتورة
  Future GET_PRIVLAGE() async {
    PRIVLAGE(LoginController().SUID, 2264).then((data) {
      USR_PRI = data;
      if (USR_PRI.isNotEmpty) {
        UPIN = USR_PRI.elementAt(0).UPIN;
        UPCH = USR_PRI.elementAt(0).UPCH;
        UPDL = USR_PRI.elementAt(0).UPDL;
        UPPR = USR_PRI.elementAt(0).UPPR;
        UPQR = USR_PRI.elementAt(0).UPQR;
      } else {
        UPIN = 2;
        UPCH = 2;
        UPDL = 2;
        UPPR = 2;
        UPQR = 2;
      }
    });
  }

  //التأكد من السنة المالية من انه فعالة
  Future GET_BRA_YEA_P() async {
    GET_BRA_YEA(LoginController().JTID, LoginController().BIID,LoginController().SYID).then((data) {
      BRA_YEA = data;
      if (BRA_YEA.isNotEmpty) {
        BYST = BRA_YEA.elementAt(0).BYST;
      }
    });
  }

  //جلب تذلبل المستندات
  Future GET_SYS_DOC_D() async {
    Get_SYS_DOC_D('BF',17, LoginController().BIID).then((data) {
      GET_SYS_DOC = data;
      if (GET_SYS_DOC.isNotEmpty) {
        SDDSA = GET_SYS_DOC.elementAt(0).SDDSA_D.toString();
      }
    });
  }

  //جلب بيانات المنشاة
  Future GET_Sys_Own() async {
    GET_SYS_OWN(LoginController().BIID).then((data) {
      SYS_OWN = data;
      if (SYS_OWN.isNotEmpty) {
        SONA = SYS_OWN.elementAt(0).SONA.toString();
        SONE = SYS_OWN.elementAt(0).SONE.toString();
        SORN = SYS_OWN.elementAt(0).SORN.toString();
        SOLN = SYS_OWN.elementAt(0).SOLN.toString();
      }
    });
  }

  //مزامنة اخر قراءة
  void Socket_IP() async {
    print('LoginController().IP');
    print(LoginController().IP);
    print(LoginController().PORT);
    Socket.connect(LoginController().IP,int.parse(LoginController().PORT), timeout: const Duration(seconds: 10)).then((socket) async {
      TAB_N = "COU_RED";
      await deleteCOU_RED_ALL();
      ApiProviderLogin().getAllCOU_RED_M();
      await Future.delayed(const Duration(seconds: 3));
      Update_TABLE_ALL("COU_RED");
      GET_COU_RED_P();
     socket.destroy();
    }).catchError((error) {
      Get.snackbar('StringCHK_Err_Con'.tr, 'StringCHK_Con'.tr,
          backgroundColor: Colors.red,
          icon: Icon(Icons.error, color: Colors.white),
          colorText: Colors.white,
          isDismissible: true,
          dismissDirection: DismissDirection.horizontal,
          forwardAnimationCurve: Curves.easeOutBack);
    });
  }

  //جلب النقطه عند الدخول
  Future GET_BIL_POI_ONE_P() async {
    GET_BIL_POI_ONE(SelectDataBIID.toString()).then((data) {
      BOL_POI = data;
      if (BOL_POI.isNotEmpty) {
        SelectDataBPID = BOL_POI.elementAt(0).BPID.toString();
      }
    });
  }

  //جلب تاريخ اخر حركه ترحيل عند الدخول
  Future GET_BIF_COU_M_DATE_P() async {
    GET_BIF_COU_M_DATE(SelectDataBIID, SelectDataBPID, SelectDataCTMID).then((data) {
      BIF_COU_M = data;
      if (BOL_POI.isNotEmpty) {
        SelectFromDays = BIF_COU_M.elementAt(0).BCMRD.toString();
        SelectFromDays == 'null' ? SelectFromDays = dateFromDays.toString().split(" ")[0] : SelectFromDays;
      } else {
        SelectFromDays == 'null' ? SelectFromDays = dateFromDays.toString().split(" ")[0] : SelectFromDays;
      }
    });
  }

  //جلب نوع الوقود عند الدخول
  Future GET_COU_TYP_M_ONE_P() async {
    GET_COU_TYP_M_ONE().then((data) {
      COU_TYP_M = data;
      if (COU_TYP_M.isNotEmpty) {
        SelectDataCTMID = COU_TYP_M.elementAt(0).CTMID.toString();
      }
    });
  }

  //جلب العمله عند الدخول
  Future GET_SYS_CUR_ONE_P() async {
    GET_SYS_CUR_ONE().then((data) {
      SYS_CUR = data;
      if (SYS_CUR.isNotEmpty) {
        SelectDataSCID = SYS_CUR.elementAt(0).SCID.toString();
        SCEX = SYS_CUR.elementAt(0).SCEX!;
        SCSY = SYS_CUR.elementAt(0).SCSY!;
        SCSFL = SYS_CUR.elementAt(0).SCSFL!;
      }
    });
  }

  //جلب رقم الحركة
  Future GET_BCMID_P() async {
    GET_BCMID().then((data) {
      BIF_COU_M = data;
      if (BIF_COU_M.isNotEmpty) {
        BCMID = BIF_COU_M.elementAt(0).BCMID;
      }
    });
  }

  //جلب رقم الحركة
  Future GET_BCMNO_P() async {
    GET_BCMNO().then((data) {
      BIF_COU_M = data;
      if (BIF_COU_M.isNotEmpty) {
        BCMNO = BIF_COU_M.elementAt(0).BCMNO;
      }
    });
  }

  //جلب اجمالي المبلغ
  GETSUMBCMAM_P() async {
    CountSUMBCMAMC(BCMID).then((data) {
      if(data.isEmpty){
        SUMBCMAMCController.text ='0.0';
        update();
      }
      SUM_Bif_COU_C= data;
      SUMBCMAMCController.text=SUM_Bif_COU_C.elementAt(0).SUMBCMAMC.toString();
      update();
    });
    update();
  }
  //جلب العدادت
  Future GET_COU_INF_M_ONE_P() async {
    GET_COU_INF_M_ONE(
            SelectDataBIID.toString(),
            SelectDataCTMID.toString().toString(),
            SelectDataBPID.toString(),
            SelectDataSCID.toString(), 2).then((data) {
      COU_INF_M_List = data;
      if (COU_INF_M_List.isNotEmpty) {
        SelectDataCIMID = COU_INF_M_List.elementAt(0).CIMID.toString();
        CTMIDController.text = COU_INF_M_List.elementAt(0).CTMID.toString();
        MGNOController.text = COU_INF_M_List.elementAt(0).MGNO.toString();
        MINOController.text = COU_INF_M_List.elementAt(0).MINO.toString();
        MUIDController.text = COU_INF_M_List.elementAt(0).MUID.toString();
        SIIDController.text = COU_INF_M_List.elementAt(0).SIID.toString();
        SCIDOController.text = COU_INF_M_List.elementAt(0).SCIDO.toString();
        BCMAMController.text = COU_INF_M_List.elementAt(0).MPS1.toString();
        GUIDController.text = COU_INF_M_List.elementAt(0).GUID.toString();
        print(SelectDataCIMID);
        print('SelectDataCIMID');
        GET_COU_RED_P();
      }
    });
  }

  //جلب اخر قراءة
  Future GET_COU_RED_P() async {
    DEF_COUController.text='0';
    GET_COU_RED(SelectDataCIMID.toString()).then((data) {
      COU_RED = data;
      if (COU_RED.isNotEmpty) {
        BCMROController.text = COU_RED.elementAt(0).CRLR.toString();
        CRPD = COU_RED.elementAt(0).CRLD.toString();
        update();
      }
      else {
        CRPD = '0';
        update();
      }
    });
    GET_BIF_COU_C_DATE(SelectDataCIMID.toString()).then((data) {
      BIF_COU_C_DATE = data;
      if (BIF_COU_C_DATE.isNotEmpty) {
        CRPD = BIF_COU_C_DATE.elementAt(0).DATEI.toString();
        if(COU_RED.elementAt(0).DATEI!.compareTo(BIF_COU_C_DATE.elementAt(0).DATEI!) < 0){
          print("DT1 is before DT2");
          BCMROController.text = BIF_COU_C_DATE.elementAt(0).BCMRN.toString();
          update();
        }
        else{
          print("DT2 is before DT1");
          BCMROController.text = COU_RED.elementAt(0).CRLR.toString();
          update();
        }
      }
    });
    BCMRNController.text = '0';
    DEF_MOUNT = 0;
    // DEF_COU = (double.parse(BCMRNController.text.toString()) - (double.parse(BCMROController.text.toString())));
    // DEF_COUController.text = DEF_COU.toString();
    update();
  }

  //جلب عدد الفواتير
  Future GET_COUNT_BMMID_P() async {
    GET_COUNT_BIF_MOV_M().then((data) {
      COUNT_BMMID_P = data;
      if (COUNT_BMMID_P.isNotEmpty) {
        COUNT_BMMID = COUNT_BMMID_P.elementAt(0).BMMID;
        // GET_SUM_MOUNT_BIF_MOV_M_P();
      }
    });
  }

  //جلب المبالغ للحقول
  Future GET_SUM_MOUNT_BIF_MOV_M_P() async {
    loading(true);
    GET_SUM_MOUNT_BIF_MOV_M('1', SelectDataBIID.toString(), SelectDataBPID.toString(), SelectDataCTMID.toString()).then((data) {
      COUNT_BMMID_P = data;
      if (COUNT_BMMID_P.isNotEmpty) {
        SUMCashier = COUNT_BMMID_P.elementAt(0).SUMBMMAM.isNull
            ? 0.0
            : COUNT_BMMID_P.elementAt(0).SUMBMMAM!;
        update();
        BCMTAController.text = SUMCashier.toString();
      }
    });
    GET_SUM_MOUNT_BIF_MOV_M('8', SelectDataBIID.toString(),
            SelectDataBPID.toString(), SelectDataCTMID.toString())
        .then((data) {
      COUNT_SUMCredit_P = data;
      for (var i = 0; i < COUNT_SUMCredit_P.length; i++) {
        if (i == 0) {
          if (COUNT_SUMCredit_P[i].BCCID == 1) {
            SUMCredit = COUNT_SUMCredit_P[i].SUMBMMAM.isNull
                ? 0.0
                : COUNT_SUMCredit_P[i].SUMBMMAM!;
          } else if (COUNT_SUMCredit_P[i].BCCID == 2) {
            SUMCredit2 = COUNT_SUMCredit_P[i].SUMBMMAM.isNull
                ? 0.0
                : COUNT_SUMCredit_P[i].SUMBMMAM!;
          } else {
            SUMCredit3 = COUNT_SUMCredit_P[i].SUMBMMAM.isNull
                ? 0.0
                : COUNT_SUMCredit_P[i].SUMBMMAM!;
          }
          update();
        }
        if (i == 1) {
          if (COUNT_SUMCredit_P[i].BCCID == 2) {
            SUMCredit2 = COUNT_SUMCredit_P[i].SUMBMMAM.isNull
                ? 0.0
                : COUNT_SUMCredit_P[i].SUMBMMAM!;
          } else {
            SUMCredit3 = COUNT_SUMCredit_P[i].SUMBMMAM.isNull
                ? 0.0
                : COUNT_SUMCredit_P[i].SUMBMMAM!;
          }
          update();
        }
        if (i == 2) {
          SUMCredit3 = COUNT_SUMCredit_P[i].SUMBMMAM.isNull
              ? 0.0
              : COUNT_SUMCredit_P[i].SUMBMMAM!;
          update();
        }
      }
      if (COUNT_SUMCredit_P.length == 0) {
        SUMCredit = 0.0;
        SUMCredit2 = 0.0;
        SUMCredit3 = 0.0;
        update();
      }
      BCMAM1Controller.text = SUMCredit.toString();
      BCMAM2Controller.text = SUMCredit2.toString();
      BCMAM3Controller.text = SUMCredit3.toString();
    });

    update();
    loading(false);
  }

  //جلب بطائق الائتمان
  Future GET_BIL_CRE_C_P() async {
    GET_BIL_CRE_C_APPROVE(SelectDataBIID.toString()).then((data) {
      BIL_CRE_C_List = data;
      GET_BIL_CRE_C_P_ROW(BIL_CRE_C_List);
    });
  }

  //جلب العداد للناكد من عدم التكرار
  Future GET_CIMID_P() async {
    GET_CIMID(BCMID, SelectDataCIMID).then((data) {
      BIF_COU_C = data;
      COUNTCIMID = BIF_COU_C.elementAt(0).COUNTCIMID!;
    });
  }

  Future GET_BIL_CRE_C_P_ROW(List<Bil_Cre_C_Local> contactList) async {
    for (var i = 0; i < contactList.length; i++) {
      if (i == 0) {
        BCCID1Controller.text = contactList[i].BCCID.toString();
        BCCNA1Controller.text = contactList[i].BCCNA_D.toString();
      }
      if (i == 1) {
        BCCID2Controller.text = contactList[i].BCCID.toString();
        BCCNA2Controller.text = contactList[i].BCCNA_D.toString();
      }
      if (i == 2) {
        BCCID3Controller.text = contactList[i].BCCID.toString();
        BCCNA3Controller.text = contactList[i].BCCNA_D.toString();
      }
    }
    update();
  }

  configloading(String MESSAGE) {
    EasyLoading.instance
      ..displayDuration = const Duration(milliseconds: 8000)
      ..indicatorType = EasyLoadingIndicatorType.fadingCircle
      ..loadingStyle = EasyLoadingStyle.custom
      ..indicatorSize = 45.0
      ..radius = 10.0
      ..backgroundColor = Colors.grey[300]
      ..indicatorColor = Colors.black
      ..textColor = Colors.black
      ..maskColor = Colors.blue.withOpacity(0.5)
      ..userInteractions = true
      ..dismissOnTap = true;
    EasyLoading.showInfo(MESSAGE);
  }

  //اضافة فاتورة مبيعات عدادات
  AddApprove() {
    if (UPIN == 1) {
      formKey.currentState?.reset();
      edit = false;
      CheckBack = 0;
      GUID = uuid.v4();
      BCMTAController.clear();
      BCCID1Controller.clear();
      BCCID2Controller.clear();
      BCCID3Controller.clear();
      BCMROController.clear();
      BCMRNController.clear();
      BCMINController.clear();
      DEF_COUController.clear();
      BCMAM1Controller.clear();
      BCMAM2Controller.clear();
      BCMAM3Controller.clear();
      SUMBCMAMCController.clear();
      SelectToBCMTD = dateTimeToDays;
      GET_BCMID_P();
      GET_BIL_CRE_C_P();
      configloading('StringGET_COU_RED'.tr);
      SelectDataBIID = LoginController().BIID.toString();
      titleScreen = 'StringAdd'.tr;
      update();
      Get.to(() => Add_Approve_View());
    }
  }

  //دالة التقريب
  double roundDouble(double value, int places) {
    num mod = pow(10.0, places);
    return ((value * mod).round().toDouble() / mod);
  }

  //تعديل حركة فاتوره
  EditApprove(Bif_Cou_M_Local note) {
    if (BYST == 2) {
      Get.snackbar('StringByst_Mes'.tr, 'String_CHK_Byst'.tr,
          backgroundColor: Colors.red,
          icon: Icon(Icons.error, color: Colors.white),
          colorText: Colors.white,
          isDismissible: true,
          dismissDirection: DismissDirection.horizontal,
          forwardAnimationCurve: Curves.easeOutBack);
    } else {
      if (UPCH == 1) {
        edit = true;
        BCMID = note.BCMID;
        BCMNO = note.BCMNO;
        SelectDataBIID = note.BIID.toString();
        SIIDController.text = note.SIID.toString();
        SelectDataBPID = note.BPID.toString();
        SelectDataCTMID = note.CTMID.toString();
        SelectDataCIMID = note.CIMID.toString();
        SelectDataSCID = note.SCID.toString();
        SelectFromDays = note.BCMFD.toString();
        dateFromDays = note.BCMFD.toString();
        SelectToDays = note.BCMTD.toString();
        SelectToBCMTD = note.BCMTD.toString();
        SCEX = note.SCEX!;
        SCIDOController.text = note.SCIDC.toString();
        BCMROController.text = note.BCMRO.toString();
        BCMRNController.text = note.BCMRN.toString();
        BCCID1Controller.text = note.BCCID1.toString();
        BCCID2Controller.text = note.BCCID2.toString();
        BCCID3Controller.text = note.BCCID3.toString();
        BCMAM1Controller.text = note.BCMAM1.toString();
        BCMAM2Controller.text = note.BCMAM2.toString();
        BCMAM3Controller.text = note.BCMAM3.toString();
        MGNOController.text = note.MGNO.toString();
        MINOController.text = note.MINO.toString();
        MUIDController.text = note.MUID.toString();
        BCMAMController.text = note.BCMAM.toString();
        BCMTAController.text = note.BCMTA.toString();
        BCMINController.text = note.BCMIN.toString();
        note.ACID.toString().isEmpty || note.ACID == null
            ? SelectDataACID = null
            : SelectDataACID = note.ACID.toString();
        note.ACNO.toString().isEmpty || note.ACNO == null
            ? SelectDataACNO = null
            : SelectDataACNO = note.ACNO.toString();
        //  SelectDataACNO= note.ACNO.toString().isEmpty?'':note.ACNO.toString();
        DEF_COU = (double.parse(BCMRNController.text.toString()) - (double.parse(BCMROController.text.toString())));
        DEF_COUController.text = DEF_COU.toString();
        titleScreen = 'StringEdit'.tr;
        GETSUMBCMAM_P();
        GET_BIF_COU_C(BCMID);
        Get.to(() => Add_Approve_View(), arguments: note.BCMID);
      } else {
        Get.snackbar('StringUPCH'.tr, 'String_CHK_UPCH'.tr,
            backgroundColor: Colors.red,
            icon: Icon(Icons.error, color: Colors.white),
            colorText: Colors.white,
            isDismissible: true,
            dismissDirection: DismissDirection.horizontal,
            forwardAnimationCurve: Curves.easeOutBack);
      }
    }
  }
  //حالة الحفظ
  editMode() {
    contentFocusNode.unfocus();
    bool isValidate = formKey.currentState!.validate();
    if (isValidate == false) {
      isloadingvalidator(false);
    } else {
      if (Get.arguments == null && edit == false) {
        if (CheckBack == 0) {
          Get.snackbar('StringCHK_Save_Err'.tr, 'StringCHK_Save'.tr,
              backgroundColor: Colors.red,
              icon: const Icon(Icons.error, color: Colors.white),
              colorText: Colors.white,
              isDismissible: true,
              dismissDirection: DismissDirection.horizontal,
              forwardAnimationCurve: Curves.easeOutBack);
        } else {
          Save_BIF_COU_M_P(0);
          CheckBack=0;
        }
      } else {
        Save_BIF_COU_M_P(Get.arguments);
        CheckBack=0;
        //  _updateItem(Get.arguments);
      }
    }
  }


  //حفظ ترحيل رئيسي
  Future<bool> Save_BIF_COU_M_P(int id) async {
    try {
      STB_N = 'S1';
      if (SelectDataBIID.toString().isEmpty &&
          SelectDataBPID.toString().isEmpty &&
          SelectDataCTMID.toString().isEmpty &&
          SelectDataCIMID.toString().isEmpty &&
          SelectDataSCID.toString().isEmpty) {
        Get.snackbar('StringErrorMes'.tr, 'StringError_MESSAGE'.tr,
            backgroundColor: Colors.red,
            icon: Icon(Icons.error, color: Colors.white),
            colorText: Colors.white,
            isDismissible: true,
            dismissDirection: DismissDirection.horizontal,
            forwardAnimationCurve: Curves.easeOutBack);
        STB_N = 'S2';
        return false;
      }  else if (BCMTAController.text.isNotEmpty && double.parse(BCMTAController.text) < 0) {
        Fluttertoast.showToast(
            msg: 'StringNegative_values_are_not_accepted'.tr,
            toastLength: Toast.LENGTH_LONG,
            textColor: Colors.white,
            backgroundColor: Colors.redAccent);
        return false;
      } else if ((BCMAM1Controller.text.isNotEmpty && double.parse(BCMAM1Controller.text) < 0) && BIL_CRE_C_List.length > 0) {
        Fluttertoast.showToast(
            msg: 'StringNegative_values_are_not_accepted'.tr,
            toastLength: Toast.LENGTH_LONG,
            textColor: Colors.white,
            backgroundColor: Colors.redAccent);
        return false;
      }
      else {
        if (id == 0) {
          Bif_Cou_M_Local M = Bif_Cou_M_Local(
            BCMID: BCMID,
            BCMNO: BCMNO,
            BCMDO: DateFormat('dd-MM-yyyy HH:m').format(DateTime.now()),
            BCMRD: DateFormat('dd-MM-yyyy').format(DateTime.now()),
            BCMFD: SelectFromDays,
            BCMTD: SelectToBCMTD,
            BCMST: 2,
            BCMNR: COUNTBCCID,
            BCMFT: SelectFromTime,
            BCMTT: SelectToTime,
            BPID: int.parse(SelectDataBPID.toString()),
            SIID: int.parse(SIIDController.text),
            SCID: int.parse(SelectDataSCID.toString()),
            SCEX: SCEX,
            SUID: LoginController().SUID,
            BIID: int.parse(SelectDataBIID.toString()),
            CTMID: int.parse(SelectDataCTMID.toString()),
            CIMID: int.parse(SelectDataCIMID.toString()),
            SCIDC: SCIDOController.text.isEmpty
                ? null
                : int.parse(SCIDOController.text),
            BCMRO: 0,
            BCMRN: 0,
            BCMTY: 1,
            BCCID1: BCCID1Controller.text.isEmpty
                ? null
                : int.parse(BCCID1Controller.text),
            BCCID2: BCCID2Controller.text.isEmpty
                ? null
                : int.parse(BCCID2Controller.text),
            BCCID3: BCCID3Controller.text.isEmpty
                ? null
                : int.parse(BCCID3Controller.text),
            BCMAM1: BCMAM1Controller.text.isEmpty
                ? 0
                : double.parse(BCMAM1Controller.text),
            BCMAM2: BCMAM2Controller.text.isEmpty
                ? 0
                : double.parse(BCMAM2Controller.text),
            BCMAM3: BCMAM3Controller.text.isEmpty
                ? 0
                : double.parse(BCMAM3Controller.text),
            MGNO: MGNOController.text,
            MINO: MINOController.text,
            MUID: int.parse(MUIDController.text),
            BCMAM: double.parse(BCMAMController.text),
            BCMTA: BCMTAController.text.isEmpty
                ? 0
                : double.parse(BCMTAController.text),
            ACID: SelectDataACID.toString().isEmpty || SelectDataACID == null
                ? null
                : int.parse(SelectDataACID.toString()),
            ACNO: SelectDataACNO.toString().isEmpty ? '' : SelectDataACNO,
            GUID: GUID.toString().toUpperCase(),
            DATEI: _selectedDate,
            BCMIN: BCMINController.text,
            BCMKI: 2,
            DEVI: LoginController().DeviceName,
            JTID_L: LoginController().JTID,
            BIID_L: LoginController().BIID,
            SYID_L: LoginController().SYID,
            CIID_L: LoginController().CIID,
          );
          STB_N = 'S3';
          Save_BIF_COU_M(M);
          UPDATE_BIF_MOV_M(SelectDataBIID.toString(), SelectDataBPID.toString(), SelectDataCTMID.toString());
        }
        else {
          STB_N = 'S4';
          UpdateBIF_COU_M(
              BCMID.toString(),
              SelectFromDays.toString(),
              SelectToBCMTD.toString(),
              int.parse(SelectDataBPID.toString()),
              int.parse(SIIDController.text),
              int.parse(SelectDataSCID.toString()),
              SCEX,
              int.parse(SelectDataBIID.toString()),
              int.parse(SelectDataCTMID.toString()),
              int.parse(SelectDataCIMID.toString()),
              SCIDOController.text.isEmpty
                  ? 0
                  : int.parse(SCIDOController.text),
              0,
              0,
              BCCID1Controller.text.isEmpty
                  ? null
                  : int.parse(BCCID1Controller.text),
              BCCID2Controller.text.isEmpty
                  ? null
                  : int.parse(BCCID2Controller.text),
              BCCID3Controller.text.isEmpty
                  ? null
                  : int.parse(BCCID3Controller.text),
              BCMAM1Controller.text.isEmpty
                  ? 0
                  : double.parse(BCMAM1Controller.text),
              BCMAM2Controller.text.isEmpty
                  ? 0
                  : double.parse(BCMAM2Controller.text),
              BCMAM3Controller.text.isEmpty
                  ? 0
                  : double.parse(BCMAM3Controller.text),
              MGNOController.text,
              MINOController.text,
              int.parse(MUIDController.text),
              double.parse(BCMAMController.text),
              BCMTAController.text.isEmpty
                  ? 0
                  : double.parse(BCMTAController.text),
              SelectDataACID.toString().isEmpty || SelectDataACID == null
                  ? null
                  : int.parse(SelectDataACID.toString()),
              SelectDataACNO.toString().isEmpty || SelectDataACNO == null
                  ? ''
                  : SelectDataACNO.toString(),
              BCMINController.text,
              LoginController().SUID,
              _selectedDate,
              LoginController().DeviceName);
        }
        CheckBack = 0;
        Get.snackbar('StringMesSave'.tr, "${'StringMesSave'.tr}-$BCMID",
            backgroundColor: Colors.green,
            icon: Icon(Icons.save, color: Colors.white),
            colorText: Colors.white,
            isDismissible: true,
            dismissDirection: DismissDirection.horizontal,
            forwardAnimationCurve: Curves.easeOutBack);
        update();
        formKey.currentState!.save;
        Get.offNamed('/Counter_Sale_Posting_Approving');
        StteingController().isActivateAutoMoveSync==true?
        Socket_IP_Connect('SyncOnly',BCMID.toString()):false;
        await Future.delayed(Duration(seconds: 1));
        GET_BIF_COU_M_P('DateNow');
        update();
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

  //جلب رقم ترحيل الفرعي
  Future GET_BCCID_P() async {
    GET_BCCID(BCMID).then((data) {
      BIF_COU_C = data;
      if (BIF_COU_C.isNotEmpty) {
        BCCID = BIF_COU_C.elementAt(0).BCCID;
      }
    });
  }

  //جلب اجمالي الحركات للترحيل الفرعي
  Future GET_COUNTBCCID_P() async {
    GET_COUNTBCCID(BCMID).then((data) {
      BIF_COU_C_COUNT = data;
      if (BIF_COU_C_COUNT.isNotEmpty) {
        COUNTBCCID = BIF_COU_C_COUNT.elementAt(0).COUNTBCCID;
      }
    });
  }

  //حفظ ترحيل فرعي
  bool Save_BIF_COU_C_P() {
    try {
      STB_N = 'S1';
      GUIDD = uuid.v4();
      if (double.parse(BCMRNController.text) <= 0) {
        Fluttertoast.showToast(
            msg: 'StringVAL_BCMRN'.tr,
            toastLength: Toast.LENGTH_LONG,
            textColor: Colors.white,
            backgroundColor: Colors.redAccent);
        return false;
      } else if (DEF_COU < 0) {
        Fluttertoast.showToast(
            msg: 'StringVAL_DEF_COU'.tr,
            toastLength: Toast.LENGTH_LONG,
            textColor: Colors.white,
            backgroundColor: Colors.redAccent);
        return false;
      }
      else if (COUNTCIMID > 0 && editd == false) {
        Fluttertoast.showToast(
            msg: 'StringCheckCIMIDONE'.tr,
            toastLength: Toast.LENGTH_LONG,
            textColor: Colors.white,
            backgroundColor: Colors.redAccent);
        return false;
      } else {
        if (BCCIDController.text.isEmpty) {
          Bif_Cou_C_Local M = Bif_Cou_C_Local(
            BCCID: BCCID,
            BCMID: BCMID,
            GUIDM: GUID.toString().toUpperCase(),
            BCMFD: SelectFromDays,
            BCMTD: SelectToBCMTD,
            BCCST: 2,
            BCMFT: SelectFromTime,
            BCMTT: SelectToTime,
            SIID: int.parse(SIIDController.text),
            SCID: int.parse(SelectDataSCID.toString()),
            SCEX: SCEX,
            SUID: LoginController().SUID,
            CTMID: int.parse(CTMIDController.text),
            CIMID: int.parse(SelectDataCIMID.toString()),
            SCIDC: SCIDOController.text.isEmpty ? null : int.parse(SCIDOController.text),
            BCMRO: double.parse(BCMROController.text),
            BCMRN: double.parse(BCMRNController.text),
            BCMTY: 1,
            BCCID1: BCCID1Controller.text.isEmpty ? null : int.parse(BCCID1Controller.text),
            BCCID2: BCCID2Controller.text.isEmpty ? null : int.parse(BCCID2Controller.text),
            BCCID3: BCCID3Controller.text.isEmpty ? null : int.parse(BCCID3Controller.text),
            BCMAM1: BCMAM1Controller.text.isEmpty ? 0 : double.parse(BCMAM1Controller.text),
            BCMAM2: BCMAM2Controller.text.isEmpty ? 0 : double.parse(BCMAM2Controller.text),
            BCMAM3: BCMAM3Controller.text.isEmpty ? 0 : double.parse(BCMAM3Controller.text),
            BCMAM: double.parse(BCMAMController.text),
            BCMAMSUM: roundDouble(
                double.parse(BCMAMController.text) * (double.parse(BCMRNController.text) - double.parse(BCMROController.text)), 2),
            ACID: SelectDataACID.toString().isEmpty || SelectDataACID == null ? null : int.parse(SelectDataACID.toString()),
            ACNO: SelectDataACNO.toString().isEmpty ? '' : SelectDataACNO,
            GUID: GUIDD.toString().toUpperCase(),
            DATEI: DateFormat('dd-MM-yyyy hh:mm').format(DateTime.now()),
            BCCIN: BCMINController.text,
            DEVI: LoginController().DeviceName,
            JTID_L: LoginController().JTID,
            BIID_L: LoginController().BIID,
            SYID_L: LoginController().SYID,
            CIID_L: LoginController().CIID,
          );
          Save_BIF_COU_C(M);
          MES_ADD_EDIT = 'StringAD'.tr;
        }
        else {
          UpdateBIF_COU_C(
              BCMID.toString(),
              BCCIDController.text.toString(),
              SelectToBCMTD.toString(),
              int.parse(SIIDController.text),
              int.parse(SelectDataSCID.toString()),
              SCEX,
              int.parse(SelectDataCTMID.toString()),
              int.parse(SelectDataCIMID.toString()),
              SCIDOController.text.isEmpty
                  ? 0
                  : int.parse(SCIDOController.text),
              double.parse(BCMROController.text),
              double.parse(BCMRNController.text),
              BCCID1Controller.text.isEmpty
                  ? null
                  : int.parse(BCCID1Controller.text),
              BCCID2Controller.text.isEmpty
                  ? null
                  : int.parse(BCCID2Controller.text),
              BCCID3Controller.text.isEmpty
                  ? null
                  : int.parse(BCCID3Controller.text),
              BCMAM1Controller.text.isEmpty
                  ? 0
                  : double.parse(BCMAM1Controller.text),
              BCMAM2Controller.text.isEmpty
                  ? 0
                  : double.parse(BCMAM2Controller.text),
              BCMAM3Controller.text.isEmpty
                  ? 0
                  : double.parse(BCMAM3Controller.text),
              double.parse(BCMAMController.text),
              BCMTAController.text.isEmpty
                  ? 0
                  : double.parse(BCMTAController.text),
              SelectDataACID.toString().isEmpty || SelectDataACID == null
                  ? null
                  : int.parse(SelectDataACID.toString()),
              SelectDataACNO.toString().isEmpty || SelectDataACNO == null
                  ? ''
                  : SelectDataACNO.toString(),
              roundDouble(
                  double.parse(BCMAMController.text) *
                      (double.parse(BCMRNController.text) -
                          double.parse(BCMROController.text)),
                  2),
              BCMINController.text,
              LoginController().SUID,
              _selectedDate,
              LoginController().DeviceName);
          MES_ADD_EDIT = 'StringED'.tr;
          editd = false;
        }
        GET_BCCID_P();
        CheckBack = 1;
        update();
        clearBIF_COU_C();
        Fluttertoast.showToast(
            msg: MES_ADD_EDIT,
            toastLength: Toast.LENGTH_LONG,
            textColor: Colors.white,
            backgroundColor: Colors.green);
        ADD_EDformKey.currentState!.save;
        STB_N = 'S2';
        GET_CIMID_P();
        GETSUMBCMAM_P();
        return true;
      }
    } catch (e) {
      Fluttertoast.showToast(
          msg: "${STB_N}-${'StrinError_save_data'.tr}",
          toastLength: Toast.LENGTH_LONG,
          textColor: Colors.white,
          backgroundColor: Colors.redAccent);
      return false;
    }
  }

  clearBIF_COU_C() {
    BCMRNController.clear();
    DEF_COUController.clear();
    BCCIDController.clear();
    DEF_MOUNT = 0;
    titleAddScreen = 'StringAdd'.tr;
    StringButton = 'StringAdd'.tr;
  }

  //حذف الفاتورة الرئيسي
  bool delete_BIF_COU(int? GetBCMID, int type) {
    if (UPDL == 1) {
      if (type == 1) {
        deleteBIF_COU_M(BCMID!);
        deleteBIF_COU_C(BCMID);
        onInit();
        onInit();
        update();
      } else if (type == 2) {
        deleteBIF_COU_M(GetBCMID!);
        deleteBIF_COU_C(GetBCMID);
        Get.snackbar('StringDelete'.tr, "${'StringDelete'.tr}-${GetBCMID}",
            backgroundColor: Colors.green,
            icon: Icon(Icons.delete, color: Colors.white),
            colorText: Colors.white,
            isDismissible: true,
            dismissDirection: DismissDirection.horizontal,
            forwardAnimationCurve: Curves.easeOutBack);
        onInit();
        update();
      }
      return true;
    } else {
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

  //حذف حركة ترحيل فرعي
  bool DeleteBIF_COU_C_P(String GETBCMID, String GETBCCID) {
    DeleteBIF_COU_C_ONE(GETBCMID, GETBCCID);
    Fluttertoast.showToast(
        msg: 'StringDelete'.tr,
        toastLength: Toast.LENGTH_LONG,
        textColor: Colors.white,
        backgroundColor: Colors.redAccent);
    return true;
  }

  void Socket_IP_Connect(String TypeSync, String GetBCMID) async {
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
    Socket.connect(LoginController().IP,int.parse(LoginController().PORT), timeout: const Duration(seconds: 5))
        .then((socket) async {
      SyncBIF_COU_CToSystem_P(TypeSync, GetBCMID);
      socket.destroy();
    }).catchError((error) {
      Get.snackbar('StringCHK_Err_Con'.tr, 'StringCHK_Con'.tr,
          backgroundColor: Colors.red,
          icon: Icon(Icons.error, color: Colors.white),
          colorText: Colors.white,
          isDismissible: true,
          dismissDirection: DismissDirection.horizontal,
          forwardAnimationCurve: Curves.easeOutBack);
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
      EasyLoading.showError('StrinError_Sync'.tr);
    });
  }


  Future SyncBIF_COU_MToSystem_P(String TypeSync, String GetBCMID) async {
    await SyncronizationData().FetchBIF_COU_M(TypeSync, GetBCMID).then((userList) async {
      if (userList.isNotEmpty) {
        TAB_N = 'BIF_COU_M';
        await SyncronizationData().SyncBIF_COU_MToSystem(userList, TypeSync, GetBCMID);
        GET_BIF_COU_M_P("DateNow");
      }
    });
  }

  Future SyncBIF_COU_CToSystem_P(String TypeSync, String GetBCMID) async {
    await SyncronizationData().FetchBIF_COU_C(TypeSync, GetBCMID)
        .then((list_d) async {
      if (list_d.isNotEmpty) {
        TAB_N = 'BIF_COU_C';
        await SyncronizationData().SyncBIF_COU_CToSystem(list_d, TypeSync, GetBCMID);
        SyncBIF_COU_MToSystem_P(TypeSync, GetBCMID);
      }
    });
  }

  displayAddItemsWindo() {
    Get.bottomSheet(
      StatefulBuilder(builder: (BuildContext context, StateSetter setState) {
        double width = MediaQuery.of(context).size.width;
        double height = MediaQuery.of(context).size.height;
        return Form(
          key: ADD_EDformKey,
          child: SingleChildScrollView(
            child: Column(
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
                      // SizedBox(height: Dimensions.height5),
                      // DropdownCou_Typ_M2Builder(),
                      Padding(    padding: EdgeInsets.only(right: 0.05 * width,left:0.05 * width),
                      child: Column(children: [
                        DropdownCOU_INF_MBuilder(),
                        SizedBox(height: Dimensions.height10),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Container(
                              width: MediaQuery.of(context).size.width / 3.5,
                              child: TextFormField(
                                controller: BCMROController,
                                textAlign: TextAlign.center,
                                enabled: false,
                                keyboardType: TextInputType.number,
                                decoration: InputDecoration(
                                    labelText: 'StrinBCMRO'.tr,
                                    labelStyle: ThemeHelper().buildTextStyle(context, Colors.grey,'S'),
                                    focusedBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(
                                            Dimensions.width15),
                                        borderSide: BorderSide(
                                            color: Colors.grey.shade500)),
                                    border: OutlineInputBorder(
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(
                                                Dimensions.height15)))),
                              ),
                            ),
                            Container(
                              width: MediaQuery.of(context).size.width / 3.5,
                              child: TextFormField(
                                focusNode: myFocusNode,
                                controller: BCMRNController,
                                textAlign: TextAlign.center,
                                keyboardType: TextInputType.number,
                                decoration: InputDecoration(
                                    labelText: 'StrinBCMRN'.tr,
                                    labelStyle: ThemeHelper().buildTextStyle(context, Colors.grey,'S'),
                                    focusedBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(
                                            Dimensions.width15),
                                        borderSide: BorderSide(
                                            color: Colors.grey.shade500)),
                                    border: OutlineInputBorder(
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(
                                                Dimensions.height15)))),
                                validator: (v) {
                                  if (v!.isEmpty) {
                                    return 'StringBCMRN'.tr;
                                  }
                                  return null;
                                },
                                onChanged: (v) {
                                  if (v.isNotEmpty) {
                                    DEF_COU = (double.parse(v.toString()) -
                                        (double.parse(
                                            BCMROController.text.toString())));
                                    DEF_COUController.text = DEF_COU.toString();
                                    DEF_MOUNT = roundDouble(
                                        double.parse(DEF_COU.toString()) *
                                            (double.parse(BCMAMController.text
                                                .toString())),
                                        2);
                                    GET_BCCID_P();
                                    update();
                                  }
                                },
                              ),
                            ),
                            Container(
                              width: MediaQuery.of(context).size.width / 3.5,
                              child: TextFormField(
                                controller: DEF_COUController,
                                textAlign: TextAlign.center,
                                keyboardType: TextInputType.number,
                                enabled: false,
                                decoration: InputDecoration(
                                    labelText: 'StrinDef_BCMRO'.tr,
                                    labelStyle: ThemeHelper().buildTextStyle(context, Colors.grey,'S'),
                                    focusedBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(
                                            Dimensions.width15),
                                        borderSide: BorderSide(
                                            color: Colors.grey.shade500)),
                                    border: OutlineInputBorder(
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(
                                                Dimensions.height15)))),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: Dimensions.height5,
                        ),
                        Container(
                          child: Obx(() {
                            return isloading.value == true
                                ? ThemeHelper().circularProgress()
                                : TextButton(
                              //icon: Icon(Icons.add,color:  Colors.black,),
                              style: ButtonStyle(
                                shape: MaterialStateProperty.all<
                                    RoundedRectangleBorder>(
                                    RoundedRectangleBorder(
                                        borderRadius:
                                        BorderRadius.circular(
                                            Dimensions.height40),
                                        side: const BorderSide(
                                            color: Colors.black45))),
                                padding:
                                MaterialStateProperty.all<EdgeInsets>(
                                    EdgeInsets.only(
                                        left: Dimensions.height40,
                                        right: Dimensions.height40)),
                              ),
                              child: Text(
                                StringButton,
                                style: ThemeHelper().buildTextStyle(context, Colors.black,'M'),
                              ),
                              onPressed: () async {
                                Save_BIF_COU_C_P();
                              },
                            );
                          }),
                        ),
                        SizedBox(height: Dimensions.height20),
                      ],),)

                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      }),
    );
  }

  GetBuilder<Counter_Sales_Approving_Controller> DropdownCOU_INF_MBuilder() {
    return GetBuilder<Counter_Sales_Approving_Controller>(
        init: Counter_Sales_Approving_Controller(),
        builder: ((value) => FutureBuilder<List<Cou_Inf_M_Local>>(
            future: GET_COU_INF_M(
                SelectDataBIID.toString(),
                SelectDataCTMID.toString(),
                SelectDataBPID.toString(),
                SelectDataSCID.toString(),
                2),
            builder: (BuildContext context,
                AsyncSnapshot<List<Cou_Inf_M_Local>> snapshot) {
              if (!snapshot.hasData) {
                return Dropdown(josnStatus: josnStatus, GETSTRING: '',);
              }
              return IgnorePointer(
                ignoring: editd == true ? true : false,
                child: Padding(
                  padding: EdgeInsets.only(left: Dimensions.width10, right: Dimensions.width10,
                      top: Dimensions.height10,bottom: Dimensions.height10),
                  child: DropdownButtonFormField2(
                    decoration: InputDecoration(
                      labelText: 'Stringcounter_label'.tr,
                      labelStyle: TextStyle(color: Colors.grey.shade800),
                      focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(Dimensions.width15),
                          borderSide: BorderSide(color: Colors.grey.shade500)),
                      isDense: true,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(Dimensions.width15),
                      ),
                    ),
                      isDense: true,
                      isExpanded: true,
                      hint: ThemeHelper().buildText(context,'StringChi_CIMID', Colors.grey,'S'),
                      items: snapshot.data!
                          .map((item) => DropdownMenuItem<String>(
                                value: item.CIMID.toString(),
                                onTap: () {
                                  MGNOController.text = item.MGNO.toString();
                                  MINOController.text = item.MINO.toString();
                                  MUIDController.text = item.MUID.toString();
                                  SIIDController.text = item.SIID.toString();
                                  SCIDOController.text = item.SCIDO.toString();
                                  BCMAMController.text = item.MPS1.toString();
                                  GUIDController.text = item.GUID.toString();
                                  CTMIDController.text = item.CTMID.toString();
                                },
                                child: Text(
                                  item.CIMNA_D.toString(),
                                  style: ThemeHelper().buildTextStyle(context, Colors.black,'M'),
                                ),
                              ))
                          .toList()
                          .obs,
                      value: SelectDataCIMID,
                      onChanged: (value) {
                        SelectDataCIMID = value.toString();
                        GET_COU_RED_P();
                        // GET_SUM_MOUNT_BIF_MOV_M_P();
                        GET_CIMID_P();
                        update();
                      },
                      onMenuStateChange: (isOpen) {
                        if (!isOpen) {
                          CIMIDController.clear();
                        }
                      },

                  ),
                ),
              );
            })));
  }

  Future<dynamic> buildShowSetting() {
    return Get.defaultDialog(
      title: "Stringsetting".tr,
      content: Column(
        children: [
          DropdownBra_InfBuilder(),
          SizedBox(height: Dimensions.height10),
          DropdownBil_PoiBuilder(),
          SizedBox(height: Dimensions.height10),
          DropdownCou_Typ_MBuilder(),
          SizedBox(height: Dimensions.height10),
          DropdownSYS_CURBuilder(),
          SizedBox(height: Dimensions.height10),
          titleScreen == ''
              ? MaterialButton(
                  onPressed: () async {
                    errorText = validate_Continue();
                    update();
                    if (errorText.isNull) {
                      GET_BIF_COU_M_DATE_P();
                      GET_SUM_MOUNT_BIF_MOV_M_P();

                      AddApprove();
                      loadingerror(false);
                      update();
                    } else {
                      loadingerror(true);
                      update();
                    }
                  },
                  child: Container(
                    height: 40.h,
                    width: 330.w,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                        color: AppColors.MainColor,
                        borderRadius:
                            BorderRadius.circular(Dimensions.height35)),
                    child: Text(
                      'StringContinue'.tr,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                      ),
                    ),
                  ),
                )
              : Container(),
          SizedBox(height: Dimensions.height10),
          MaterialButton(
            onPressed: () {
              Get.back();
            },
            child: Container(
              height: 40.h,
              width: 330.w,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                  color: AppColors.MainColor,
                  borderRadius: BorderRadius.circular(Dimensions.height35)),
              child: Text(
                'StringLogout'.tr,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                ),
              ),
            ),
          )
        ],
      ),
      backgroundColor: Colors.white,
      radius: 30,
      barrierDismissible: false,
    );
  }

  GetBuilder<Counter_Sales_Approving_Controller> DropdownBra_InfBuilder() {
    return GetBuilder<Counter_Sales_Approving_Controller>(
        init: Counter_Sales_Approving_Controller(),
        builder: ((controller) => FutureBuilder<List<Bra_Inf_Local>>(
            future: GET_BRA(1),
            builder: (BuildContext context,
                AsyncSnapshot<List<Bra_Inf_Local>> snapshot) {
              if (!snapshot.hasData) {
                return Dropdown(josnStatus: josnStatus, GETSTRING: '',);
              }
              return IgnorePointer(
                ignoring: titleScreen == '' ? false : true,
                child: DropdownButtonFormField2(
                  decoration: InputDecoration(
                    isDense: true,
                    labelText: 'StringBIIDlableText'.tr,
                    errorText: controller.errorTextBIID.value,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(Dimensions.height15),
                    ),
                    focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(Dimensions.width15),
                        borderSide: BorderSide(color: Colors.grey.shade400)),
                  ),
                  isExpanded: true,
                  hint: ThemeHelper().buildText(context,'StringBrach', Colors.grey,'S'),
                  value: controller.SelectDataBIID,
                  style: const TextStyle(
                      fontFamily: 'Hacen',
                      color: Colors.black,
                      fontWeight: FontWeight.bold),
                  items: snapshot.data!
                      .map((item) => DropdownMenuItem<String>(
                            value: item.BIID.toString(),
                            child:Text("${item.BIID.toString()} - ${item
                                .BINA_D.toString()}",
                              style: ThemeHelper().buildTextStyle(context, Colors.black,'M'),
                            ),
                          ))
                      .toList()
                      .obs,
                  validator: (v) {
                    if (v == null) {
                      return 'StringBrach'.tr;
                    }
                    return null;
                  },
                  onChanged: (value) {
                    if (controller.SelectDataBPID != null) {
                      controller.SelectDataBPID == null;
                    }
                    controller.SelectDataBIID = value.toString();
                    controller.SelectDataBPID = null;
                    controller.update();
                    controller.GET_BIL_POI_ONE_P();
                  },
                ),
              );
            })));
  }

  GetBuilder<Counter_Sales_Approving_Controller> DropdownBil_PoiBuilder() {
    return GetBuilder<Counter_Sales_Approving_Controller>(
        init: Counter_Sales_Approving_Controller(),
        builder: ((controller) => FutureBuilder<List<Bil_Poi_Local>>(
            future: GET_BIL_POI(controller.SelectDataBIID.toString()),
            builder: (BuildContext context,
                AsyncSnapshot<List<Bil_Poi_Local>> snapshot) {
              if (!snapshot.hasData) {
                return Dropdown(josnStatus: josnStatus, GETSTRING: '',);
              }
              return IgnorePointer(
                ignoring: titleScreen == '' ? false : true,
                child: DropdownButtonFormField2(
                  decoration: InputDecoration(
                    isDense: true,
                    labelText: 'StringBPIDlableText'.tr,
                    errorText: controller.errorTextBIID.value,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(Dimensions.height15),
                    ),
                    focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(Dimensions.width15),
                        borderSide: BorderSide(color: Colors.grey.shade400)),
                  ),
                  isExpanded: true,
                  hint: ThemeHelper().buildText(context,'StringBrach', Colors.grey,'S'),
                  value: controller.SelectDataBPID,
                  style: const TextStyle(
                      fontFamily: 'Hacen',
                      color: Colors.black,
                      fontWeight: FontWeight.bold),
                  items: snapshot.data!
                      .map((item) => DropdownMenuItem<String>(
                            value: item.BPID.toString(),
                            child: Text("${item.BPID.toString()} - ${item.BPNA_D.toString()}",
                              style: ThemeHelper().buildTextStyle(context, Colors.black,'M'),
                            ),
                          ))
                      .toList()
                      .obs,
                  validator: (v) {
                    if (v == null) {
                      return 'StringBrach'.tr;
                    }
                    return null;
                  },
                  onChanged: (value) {
                    if (controller.SelectDataCIMID != null) {
                      controller.SelectDataCIMID == null;
                    }
                    Timer(const Duration(milliseconds: 300), () async {
                      controller.SelectDataBPID = value.toString();

                      controller.GET_COU_INF_M_ONE_P();
                      // controller.GET_SUM_MOUNT_BIF_MOV_M_P();
                      controller.update();
                    });
                  },
                ),
              );
            })));
  }

  FutureBuilder<List<Cou_Typ_M_Local>> DropdownCou_Typ_MBuilder() {
    return FutureBuilder<List<Cou_Typ_M_Local>>(
        future: GET_COU_TYP_M('ALL'),
        builder: (BuildContext context,
            AsyncSnapshot<List<Cou_Typ_M_Local>> snapshot) {
          if (!snapshot.hasData) {
            return Dropdown(josnStatus: josnStatus, GETSTRING: '',);
          }
          return IgnorePointer(
            ignoring: titleScreen == '' ? false : true,
            child: DropdownButtonFormField2(
              decoration: InputDecoration(
                isDense: true,
                labelText: 'StringCTMIDlableText'.tr,
                errorText: errorTextCTMID.value,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(Dimensions.height15),
                ),
                focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(Dimensions.width15),
                    borderSide: BorderSide(color: Colors.grey.shade400)),
              ),
              isExpanded: true,
              hint:ThemeHelper().buildText(context,'StringFuelType', Colors.grey,'S'),
              value: SelectDataCTMID,
              style: const TextStyle(
                  fontFamily: 'Hacen',
                  color: Colors.black,
                  fontWeight: FontWeight.bold),
              items: snapshot.data!
                  .map((item) => DropdownMenuItem<String>(
                        value: item.CTMID.toString(),
                        child: Text("${item.CTMID.toString()} - ${item.CTMNA_D.toString()}",
                          style: ThemeHelper().buildTextStyle(context, Colors.black,'M'),
                        ),
                      ))
                  .toList()
                  .obs,
              validator: (v) {
                if (v == null) {
                  return 'StringBrach'.tr;
                }
                return null;
              },
              onChanged: (value) {
                SelectDataCTMID = value.toString();
                Timer(const Duration(milliseconds: 5), () async {
                  SelectDataCTMID = value.toString();
                  if (SelectDataCIMID != null) {
                    SelectDataCIMID = null;
                    GET_COU_INF_M_ONE_P();
                  } else {
                    SelectDataCIMID = null;
                    GET_COU_INF_M_ONE_P();
                  }

                  update();
                  //   GET_SUM_MOUNT_BIF_MOV_M_P();
                });
              },
            ),
          );
        });
  }

  FutureBuilder<List<Sys_Cur_Local>> DropdownSYS_CURBuilder() {
    return FutureBuilder<List<Sys_Cur_Local>>(
        future: GET_SYS_CUR(),
        builder: (BuildContext context,
            AsyncSnapshot<List<Sys_Cur_Local>> snapshot) {
          if (!snapshot.hasData) {
            return Dropdown(josnStatus: josnStatus, GETSTRING: '',);
          }
          return IgnorePointer(
            ignoring: titleScreen == '' ? false : true,
            child: DropdownButtonFormField2(
              decoration: InputDecoration(
                isDense: true,
                labelText: 'StringSCIDlableText'.tr,
                errorText: errorTextSCID.value,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(Dimensions.height15),
                ),
                focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(Dimensions.width15),
                    borderSide: BorderSide(color: Colors.grey.shade400)),
              ),
              isExpanded: true,
              hint: ThemeHelper().buildText(context,'StringChi_currency', Colors.grey,'S'),
              value: SelectDataSCID,
              style: const TextStyle(
                  fontFamily: 'Hacen',
                  color: Colors.black,
                  fontWeight: FontWeight.bold),
              items: snapshot.data!
                  .map((item) => DropdownMenuItem<String>(
                        value: item.SCID.toString(),
                        onTap: () {
                          SCEX = item.SCEX!;
                          SCSY = item.SCSY!;
                          SCSFL = item.SCSFL!;
                        },
                        child: Text("${item.SCID.toString()} - ${item.SCNA_D.toString()}",
                          style: ThemeHelper().buildTextStyle(context, Colors.black,'M'),
                        ),
                      ))
                  .toList()
                  .obs,
              validator: (v) {
                if (v == null) {
                  return 'StringBrach'.tr;
                }
                return null;
              },
              onChanged: (value) {
                SelectDataSCID = value.toString();
              },
            ),
          );
        });
  }
}
