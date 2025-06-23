import 'dart:async';
import 'dart:io';
import 'package:geolocator/geolocator.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import '../../Widgets/config.dart';
import '../Views/Customers/add_ed_customer.dart';
import '../controllers/login_controller.dart';
import '../models/acc_acc.dart';
import '../models/acc_tax_c.dart';
import '../models/acc_tax_t.dart';
import '../models/acc_usr.dart';
import '../models/bil_are.dart';
import '../models/bil_cus.dart';
import '../models/bil_cus_t.dart';
import '../models/bra_yea.dart';
import '../models/cou_tow.dart';
import '../models/sys_var.dart';
import '../models/usr_pri.dart';
import '../services/syncronize.dart';
import '../../database/customer_db.dart';
import '../../database/setting_db.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:uuid/uuid.dart';

import 'setting_controller.dart';

class CustomersController extends GetxController {
  //TODO: Implement HomeController
  RxBool loading = false.obs;
  bool edit = false,CompareBCNAChanged=false;
  bool value = false;
  StreamSubscription<Position>? _positionStreamSubscription;
  final GeolocatorPlatform _geolocatorPlatform = GeolocatorPlatform.instance;

  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  late FocusNode BCNAFocus, BCNEFocus, BCMOFocus,BCTLFocus, BCADFocus, BCHNFocus, BCTXFocus, BCSNFocus,
      BCQNDFocus,BCAD2Focus,BCPCFocus,BCJTFocus, BCBNFocus, BCONFocus,
      BCC1Focus, BCINFocus, BIIDFocus, ATTIDFocus, ACIDFocus, PKIDFocus, BAIDFocus, BDIDFocus,
      CWIDFocus, BCPRFocus, BCTIDFocus,BCBLFocus,BCDMFocus,BCCRFocus;
  var uuid = Uuid();
  var GUID;
  String? SelectDataBIID,titleScreen,SelectDataCWID,selectedValue,SelectDataCTID,SelectDataBAID,SelectDataATTID,
      SelectDataBCTID,SelectDataBCST,SelectDataBCPR,SelectDataCTID2,SelectDataCWID2,SelectDataBAID2,SelectDataBDID,SelectDataBDID2;
  String Type='1',STB_N='', SelectNumberOfDays='',AANO='',location_of_account_application='',Update_location_account='',
      TYPE_SHOW = "ALL",query = '';
  int? BCID,UPIN=1,UPCH=1,UPQR=1,UPDL=1,UPPR=1,BYST=1,CheckBack=0,AANO_D=0,PKID=4,Allow_to_location_of_account_application,
      Allow_Update_location_account;
    int  currentIndex=0;
  FocusNode contentFocusNode = FocusNode();
  late TextEditingController BCNAController,BCNEController,BCIDController,CWIDController,CWNAController,CTIDController,CTNAController,
      BAIDController,BANAController,BCTIDController,BCTNAController,ATTIDController,ATTNAController,
       BCMOController,BCADController,BCTXController,BCSNController,BCC1Controller,BCBNController,BCHNController,
      BCONController,TextEditingSercheController,BCINController,BCC3Controller,BCLONController,
      BCLATController,BCQNDController,BCAD2Controller,BCPCController,BCJTController,BCBLController,
      BCDMController,BCCRController,BCTLController;

  RxDouble? longitude=0.0.obs;
  RxDouble? latitude=0.0.obs;
  double distanceInMeters=0;
  static const _pageSize = 20;

  late List<Bil_Cus_Local> BIL_CUS_List = [];
  late List<Usr_Pri_Local> USR_PRI;
  late List<Bil_Cus_Local> BIL_CUS;
  late final PagingController<int, Bil_Cus_Local> pagingController =
  PagingController<int, Bil_Cus_Local>(
    // تُرجع null عندما لا تكون هناك صفحة قادمة
    firstPageKey: 1,
  );
  void onInit() async {
    super.onInit();
    BCIDController = TextEditingController();
    BCNAController = TextEditingController();
    BCNEController = TextEditingController();
    CWIDController = TextEditingController();
    CWNAController = TextEditingController();
    CTIDController = TextEditingController();
    CTNAController = TextEditingController();
    BAIDController = TextEditingController();
    BANAController = TextEditingController();
    BCTIDController = TextEditingController();
    BCTNAController = TextEditingController();
    ATTIDController = TextEditingController();
    ATTNAController = TextEditingController();
    BCMOController = TextEditingController();
    BCTLController = TextEditingController();
    BCADController = TextEditingController();
    BCTXController = TextEditingController();
    BCSNController = TextEditingController();
    BCC1Controller = TextEditingController();
    BCBNController = TextEditingController();
    BCONController = TextEditingController();
    BCINController = TextEditingController();
    BCC3Controller = TextEditingController();
    BCHNController = TextEditingController();
    BCLONController = TextEditingController();
    BCLATController = TextEditingController();
    BCQNDController = TextEditingController();
    BCAD2Controller = TextEditingController();
    BCPCController = TextEditingController();
    BCJTController = TextEditingController();
    TextEditingSercheController = TextEditingController();
    BCBLController= TextEditingController();
    BCDMController= TextEditingController();
    BCCRController= TextEditingController();
    BCNAFocus = FocusNode();
    BCNEFocus = FocusNode();
    BCMOFocus = FocusNode();
    BCTLFocus = FocusNode();
    BCADFocus = FocusNode();
    BCHNFocus = FocusNode();
    BCTXFocus = FocusNode();
    BCSNFocus = FocusNode();
    BCBNFocus = FocusNode();
    BCONFocus = FocusNode();
    BCC1Focus = FocusNode();
    BCINFocus = FocusNode();
    BIIDFocus = FocusNode();
    ATTIDFocus = FocusNode();
    ACIDFocus = FocusNode();
    PKIDFocus = FocusNode();
    BAIDFocus = FocusNode();
    BDIDFocus = FocusNode();
    CWIDFocus = FocusNode();
    BCPRFocus = FocusNode();
    BCTIDFocus = FocusNode();
    BCQNDFocus = FocusNode();
    BCAD2Focus = FocusNode();
    BCPCFocus = FocusNode();
    BCJTFocus = FocusNode();
    BCBLFocus = FocusNode();
    BCDMFocus = FocusNode();
    BCCRFocus = FocusNode();
    BCLATController.text=='0.0';
    BCLONController.text=='0.0';
    GET_location_of_account_application();
    Update_location_of_account_application();
    pagingController.addPageRequestListener(_fetchPage);
   // GET_BIL_CUS_P("ALL");
    GET_PRIVLAGE();
    _addFocusListeners();
    update();
    if(Get.arguments==1){
      AddCustomer();
    }
  }

  void dispose() {
    super.dispose();
    // TODO: implement dispose
    BCIDController.dispose();
    BCNAController.dispose();
    BCNEController.dispose();
    CWIDController.dispose();
    CWNAController.dispose();
    CTIDController.dispose();
    CTNAController.dispose();
    BAIDController.dispose();
    BANAController.dispose();
    BCTIDController.dispose();
    BCTNAController.dispose();
    ATTIDController.dispose();
    ATTNAController.dispose();
    BCMOController.dispose();
    BCTLController.dispose();
    BCADController.dispose();
    BCTXController.dispose();
    BCSNController.dispose();
    BCC1Controller.dispose();
    BCBNController.dispose();
    BCONController.dispose();
    BCINController.dispose();
    BCC3Controller.dispose();
    BCHNController.dispose();
    BCLONController.dispose();
    BCLATController.dispose();
    BCQNDController.dispose();
    BCAD2Controller.dispose();
    BCPCController.dispose();
    BCJTController.dispose();
    TextEditingSercheController.dispose();
    BCBLController.dispose();
    BCDMController.dispose();
    BCCRController.dispose();
    BCNAFocus.dispose();
    BCNEFocus.dispose();
    BCMOFocus.dispose();
    BCTLFocus.dispose();
    BCADFocus.dispose();
    BCHNFocus.dispose();
    BCTXFocus.dispose();
    BCSNFocus.dispose();
    BCBNFocus.dispose();
    BCONFocus.dispose();
    BCC1Focus.dispose();
    BCINFocus.dispose();
    BIIDFocus.dispose();
    ATTIDFocus.dispose();
    ACIDFocus.dispose();
    PKIDFocus.dispose();
    BAIDFocus.dispose();
    BDIDFocus.dispose();
    CWIDFocus.dispose();
    BCPRFocus.dispose();
    BCTIDFocus.dispose();
    BCQNDFocus.dispose();
    BCAD2Focus.dispose();
    BCPCFocus.dispose();
    BCJTFocus.dispose();
    BCBLFocus.dispose();
    BCDMFocus.dispose();
    BCCRFocus.dispose();
    pagingController.dispose();
  }

  void _addFocusListeners() {
    BCNAFocus.addListener(update);
    BCNEFocus.addListener(update);
    BCMOFocus.addListener(update);
    BCTLFocus.addListener(update);
    BCADFocus.addListener(update);
    BCHNFocus.addListener(update);
    BCTXFocus.addListener(update);
    BCSNFocus.addListener(update);
    BCBNFocus.addListener(update);
    BCONFocus.addListener(update);
    BCC1Focus.addListener(update);
    BCINFocus.addListener(update);
    BIIDFocus.addListener(update);
    ATTIDFocus.addListener(update);
    ACIDFocus.addListener(update);
    PKIDFocus.addListener(update);
    BAIDFocus.addListener(update);
    BDIDFocus.addListener(update);
    CWIDFocus.addListener(update);
    BCPRFocus.addListener(update);
    BCTIDFocus.addListener(update);
    BCQNDFocus.addListener(update);
    BCAD2Focus.addListener(update);
    BCPCFocus.addListener(update);
    BCJTFocus.addListener(update);
    BCBLFocus.addListener(update);
    BCDMFocus.addListener(update);
    BCCRFocus.addListener(update);
  }
  //صلاحيات العملاء
  Future GET_PRIVLAGE() async {
    PRIVLAGE(LoginController().SUID,91).then((data) {
      USR_PRI = data;
      if(USR_PRI.isNotEmpty){
        UPIN=USR_PRI.elementAt(0).UPIN;
        UPCH=USR_PRI.elementAt(0).UPCH;
        UPDL=USR_PRI.elementAt(0).UPDL;
        UPPR=USR_PRI.elementAt(0).UPPR;
        UPQR=USR_PRI.elementAt(0).UPQR;
      }else {
        UPIN=2;UPCH=2;UPDL=2;UPPR=2;UPQR=2;
      }
    });
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


  Future<void> _fetchPage(int pageKey) async {
    try {
      print('pageKey');
      print(pageKey);
      // 1) جلب الدفعة
      BIL_CUS_List = await  GET_BIL_CUS(
        TYPE_SHOW,TYPE_SHOW=="DateNow"?DateFormat('dd-MM-yyyy').format(DateTime.now()):
      TYPE_SHOW=="FromDate"?SelectNumberOfDays:'',currentIndex,
         pageIndex: pageKey,
        pageSize: _pageSize,searchQuery: query,);


      // 2) إذا لا توجد عناصر، نخبر الـ controller بأن الصفحات انتهت
      if (BIL_CUS_List.isEmpty) {
        pagingController.appendLastPage([]);
        return;
      }

      // 3) حدد إذا كانت هذه آخر صفحة
      // 2) صفٍّ الدفعة لإزالة المكرّرات
      final existing = pagingController.itemList ?? <Bil_Cus_Local>[];
      final filtered = BIL_CUS_List.where((item) => !existing.any((e) => e.BCID == item.BCID)).toList();

      // 3) إذا لا توجد عناصر بعد التصفية، نُخبر الـ controller بانتهاء الصفحات
      if (filtered.isEmpty) {
        pagingController.appendLastPage([]);
        return;
      }

      // 4) حدد إذا كانت هذه آخر صفحة بناءً على حجم الأصل (ليس حجم المفلترة)
      final isLastPage = BIL_CUS_List.length < _pageSize;
      if (isLastPage) {
        pagingController.appendLastPage(filtered);
      } else {
        pagingController.appendPage(filtered, pageKey + 1);
      }
      // BIL_MOV_M_List=newItems;
      update();

    } catch (error) {
      // في حالة الخطأ
      pagingController.error = error;
    }
  }
  //اظهار البيانات +البحث
  GET_BIL_CUS_P(String type) async {
    pagingController.refresh();
    //   BIL_CUS_List=await GET_BIL_CUS(
    //   TYPE_SHOW,TYPE_SHOW=="DateNow"?DateFormat('dd-MM-yyyy').format(DateTime.now()):
    //   TYPE_SHOW=="FromDate"?SelectNumberOfDays:'',currentIndex,
    //    // pageIndex: pageKey,
    //     pageSize: _pageSize,);
    // update();
  }

  //يجب تحديد الموقع عند اضافة حساب جديد من التطبيق
  Future GET_location_of_account_application() async {
   var SYS_VAR=await GET_SYS_VAR(901);
      if (SYS_VAR.isNotEmpty) {
        location_of_account_application = SYS_VAR.elementAt(0).SVVL.toString();
        if (SYS_VAR.elementAt(0).SVVL.toString() != '3') {
          await determinePosition();
        }
        //حسب الصلاحيات
        if (SYS_VAR.elementAt(0).SVVL.toString() == '4') {
          //يجب تحديد الموقع عند اضافة حساب جديد من التطبيق
          PRIVLAGE(LoginController().SUID, 1872).then((data) {
            USR_PRI = data;
            if (USR_PRI.isNotEmpty) {
              Allow_to_location_of_account_application = USR_PRI.elementAt(0).UPIN;
            } else {
              Allow_to_location_of_account_application = 2;
            }
          });
        }
      }
      else {
        location_of_account_application = '3';
      }
  }

  //عند تعديل بيانات الحساب من التطبيق السماح بتعديل الموقع
  Future Update_location_of_account_application() async {
    var SYS_VAR =await GET_SYS_VAR(903);
      if (SYS_VAR.isNotEmpty) {
        Update_location_account = SYS_VAR.elementAt(0).SVVL.toString();
        print('Update_location_account');
        print(Update_location_account);
        //حسب الصلاحيات
        if (SYS_VAR.elementAt(0).SVVL.toString() == '3') {
          //يجب تحديد الموقع عند اضافة حساب جديد من التطبيق
          PRIVLAGE(LoginController().SUID, 1874).then((data) {
            USR_PRI = data;
            if (USR_PRI.isNotEmpty) {
              Update_location_account = USR_PRI.elementAt(0).UPIN.toString();
            } else {
              Update_location_account = '2';
            }
          });
        }
      }
      else {
        Update_location_account = '1';
      }
  }

  //جلب المحصل
  Future GET_BIL_DIS_ONE_P() async {
    if (StteingController().Install_BDID == true) {
    var  BIL_DIS = await GET_BIL_DIS_ONE(SelectDataBIID.toString(), LoginController().BDID_Cus.toString());
      if (BIL_DIS.isNotEmpty) {
        SelectDataBDID = LoginController().BDID_Cus.toString();
        SelectDataBDID2 = BIL_DIS
            .elementAt(0)
            .BDNA
            .toString();
        update();
      }
      else {
        SelectDataBDID = null;
        SelectDataBDID2 = null;
      }
    } else {
      SelectDataBDID = null;
      SelectDataBDID2 = null;
    }
  }

  //اضافة عميل
  AddCustomer() {
    if (BYST == 2) {
    Get.snackbar('StringByst_Mes'.tr, 'String_CHK_Byst'.tr,
    backgroundColor: Colors.red,
    icon: Icon(Icons.error, color: Colors.white),
    colorText: Colors.white);
    }
    else if (UPIN==2){
    Get.snackbar('StringUPIN'.tr, 'String_CHK_UPIN'.tr,
    backgroundColor: Colors.red, icon: Icon(Icons.error,color:Colors.white),
    colorText:Colors.white,
    isDismissible: true,
    dismissDirection: DismissDirection.horizontal,
    forwardAnimationCurve: Curves.easeOutBack);
    }
    else{
      formKey.currentState?.reset();
      edit = false;
      GET_location_of_account_application();
      Update_location_of_account_application();
      GET_BCID_P();
      GUID = uuid.v4();
      print(SelectDataCWID);
      LoginController().BIID_Cus != 0 ? SelectDataBIID = LoginController().BIID_Cus.toString()
          : SelectDataBIID = LoginController().BIID.toString();
      print(SelectDataBCTID);
      print(LoginController().BCTID_Cus);
      print('LoginController().BCTID_Cus');
      LoginController().BCTID_Cus!=0? SelectDataBCTID=LoginController().BCTID_Cus.toString():null;
      print(SelectDataBCTID);
      print('SelectDataBCTID');
      LoginController().ATTID_Cus!=0? SelectDataATTID=LoginController().ATTID_Cus.toString():SelectDataATTID='1';
      LoginController().BCPR_Cus!=0? SelectDataBCPR=LoginController().BCPR_Cus.toString():SelectDataBCPR='1';
      LoginController().CWID_Cus!='0' ? SelectDataCWID=LoginController().CWID_Cus.toString():SelectDataCWID=null;
      LoginController().CTID_Cus!='0'? SelectDataCTID=LoginController().CTID_Cus.toString():SelectDataCTID=null;
      LoginController().BAID_Cus!=0? SelectDataBAID=LoginController().BAID_Cus.toString():SelectDataBAID=null;
      GET_BIL_DIS_ONE_P();
      print(LoginController().CWID_Cus);
      print(LoginController().CTID_Cus);
      print(LoginController().BDID_Cus);
      print('LoginController().BDID_Cus');
      LoginController().PKID_Cus!=0? PKID=LoginController().PKID_Cus:PKID=4;
      value=LoginController().value_Cus;
      BCBLController.text='0';
      BCDMController.text='0';
      BCCRController.text='0';
      titleScreen = 'StringAddCustomer'.tr;
      Get.to(() => Add_Ed_Customer());
    }
    }

  //تعديل حركة فاتوره
  EditCustomer(Bil_Cus_Local note) {
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
        BCID = note.BCID;
        AANO = note.AANO.toString();
        SelectDataBIID = note.BIID.toString();
        BCNAController.text = note.BCNA.toString();
        BCNEController.text= note.BCNE.toString()=='null'?'':note.BCNE.toString();
        SelectDataBCTID= note.BCTID.toString();
        SelectDataATTID= note.ATTID.toString();
        SelectDataBCST= note.BCST.toString();
        SelectDataCWID= note.CWID.toString();
        SelectDataBCPR= note.BCPR.toString();
        SelectDataCTID= note.CTID.toString()=='null'?null:note.CTID.toString();
        SelectDataBAID= note.BAID.toString()=='null'?null:note.BAID.toString();
        PKID= note.PKID;
        SelectDataBDID= note.BDID.toString()=='null'?null:note.BDID.toString();
        SelectDataBDID2 = note.BDID.toString()=='null'?null: LoginController().LAN==2?note.BDNE.toString():note.BDNA.toString();
        BCADController.text= note.BCAD.toString()=='null'?'':note.BCAD.toString();
        BCMOController.text= note.BCMO.toString()=='null'?'':note.BCMO.toString();
        BCTLController.text= note.BCMO.toString()=='null'?'':note.BCTL.toString();
        BCTXController.text= note.BCTX.toString()=='null'?'':note.BCTX.toString();
        print(note.BCTX.toString());
        print('note.BCTX.toString()');
        BCSNController.text= note.BCSN.toString()=='null'?'':note.BCSN.toString();
        BCINController.text= note.BCIN.toString()=='null'?'':note.BCIN.toString();
        BCHNController.text= note.BCHN.toString()=='null'?'':note.BCHN.toString();
        // BCSNDController.text= note.BCSND.toString()=='null'?'':'${note.BCSND.toString()} ';
        BCBNController.text= note.BCBN.toString()=='null'?'':note.BCBN.toString();
        BCONController.text= note.BCON.toString()=='null'?'':note.BCON.toString();
        BCC3Controller.text= note.BCC3.toString()=='null'?'':note.BCC3.toString();
        BCLATController.text= note.BCLAT.toString()=='null'?'':note.BCLAT.toString();
        BCLONController.text= note.BCLON.toString()=='null'?'':note.BCLON.toString();
        BCQNDController.text= note.BCQND.toString()=='null'?'':note.BCQND.toString();
        BCAD2Controller.text= note.BCAD2.toString()=='null'?'':note.BCAD2.toString();
        BCPCController.text= note.BCPC.toString()=='null'?'':note.BCPC.toString();
        BCJTController.text= note.BCJT.toString()=='null'?'':note.BCJT.toString();
        BCBLController.text= note.BCBL.toString()=='null'?'':note.BCBL.toString();
        BCDMController.text= note.BCDM.toString()=='null'?'':note.BCDM.toString();
        BCCRController.text= note.BCCR.toString()=='null'?'':note.BCCR.toString();
        BCC1Controller.text= note.BCC1.toString()=='null'?'':note.BCC1.toString();

        print(note.BCJT.toString());
        print(note.BCC1.toString());
        // SelectDataCWID2 = note.CWID2.toString()=='null'?null:note.CWID2.toString();
        SelectDataCWID2 = note.CWID.toString()=='null'?null:
        "${note.CWID.toString() + " +++ " + "${LoginController().LAN==2?note.CWNE.toString():note.CWNA.toString()}"}";
        SelectDataCTID2 = note.CTID.toString()=='null' ? null:
        "${note.CTID.toString() + " +++ " + "${LoginController().LAN==2?note.CTNE.toString():note.CTNA.toString()}"}";
        SelectDataBAID2 = note.BAID.toString()=='null' ? null:
        "${note.BAID.toString() + " +++ " + "${LoginController().LAN==2?note.BANE.toString():note.BANA.toString()}"}";
        CompareBCNAChanged=false;
        titleScreen = 'StringEdit'.tr;
        GET_location_of_account_application();
        Update_location_of_account_application();
        Get.to(() => Add_Ed_Customer(), arguments: note.BCID);
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

  //حالة الحفظ
  editMode(BuildContext context) {
    contentFocusNode.unfocus();
    loading(true);
    if (Get.arguments == null) {
        Save_BIL_CUS_P(0,context);
    } else {
      Save_BIL_CUS_P(Get.arguments,context);
    }
  }

  //جلب رقم
  Future GET_BCID_P() async {
   var BIL_CUS=await GET_BCID();
      if(BIL_CUS.isNotEmpty){
        BCID=BIL_CUS.elementAt(0).BCID;
      }
  }

  String? validateBCNA(String value) {
    if (value.trim().isEmpty) {
      return 'StringvalidateBCNA'.tr;
    }
    return null;
  }


  //حفظ العميل
  Future<bool> Save_BIL_CUS_P(int id,BuildContext context) async {
    // try {
      STB_N='S1';
      if (SelectDataBIID == null  || SelectDataBCTID == null || SelectDataATTID == null ||
          SelectDataBCPR== null || PKID ==null || BCNAController.text.trim().isEmpty)
      {
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
      else if ((location_of_account_application == '2' &&
          (double.parse(BCLONController.text) <= 0.0 || double.parse(BCLATController.text) <= 0.0 )) ||
          (Allow_to_location_of_account_application == 2 &&
          (double.parse(BCLONController.text) <= 0.0 || double.parse(BCLATController.text) <= 0.0 )))
      {
        Get.snackbar('StringErrorMes'.tr, 'StringError_Location_of_Account'.tr,
            backgroundColor: Colors.red,
            icon: const Icon(Icons.error, color: Colors.white),
            colorText: Colors.white,
            isDismissible: true,
            dismissDirection: DismissDirection.horizontal,
            forwardAnimationCurve: Curves.easeOutBack);
        STB_N='S3';
        await determinePosition();
        return false;
      }
      else {
        if(edit==false){
          Bil_Cus_Local B = Bil_Cus_Local(
            BCID:BCID,
            BCNA: BCNAController.text,
            BCNAF: BCNAController.text,
            BCNE: BCNEController.text.isEmpty?BCNAController.text:BCNEController.text,
            BCDO:DateFormat('dd-MM-yyyy HH:mm:ss').format(DateTime.now()),
            BIID:int.parse(SelectDataBIID.toString()),
            BCTID:int.parse(SelectDataBCTID.toString()),
            BCPR:int.parse(SelectDataBCPR.toString()),
            ATTID:int.parse(SelectDataATTID.toString()),
            BDID:SelectDataBDID.toString()=='null'?null:int.parse(SelectDataBDID.toString()),
            BCST:1,
            BCTY:2,
            PKID:PKID,
            BCBA:0,
            BCBAA:0,
            OKID:1,
            BCCT:1,
            BCPS:0,
            BCPD:DateFormat('dd-MM-yyyy').format(DateTime.now()),
            BCDC: DateFormat('dd-MM-yyyy HH:mm:ss').format(DateTime.now()),
            BCLA:LoginController().LAN,
            CWID:SelectDataCWID,
            CWID2: SelectDataCWID2 == null ? null : SelectDataCWID2.toString(),
            CTID:SelectDataCTID,
            CTID2:SelectDataCTID2 == null ? null : SelectDataCTID2.toString(),
            BAID:SelectDataBAID==null?null:int.parse(SelectDataBAID.toString()),
            BAID2:SelectDataBAID2==null?null:SelectDataBAID2.toString(),
            BCAD:BCADController.text,
            BCTL:BCTLController.text,
            BCMO:BCMOController.text,
            BCTX:BCTXController.text,
            BCSND:BCSNController.text,
            BCHN:BCHNController.text,
            BCBN:BCBNController.text,
            BCON:BCONController.text,
            BCIN:BCINController.text,
            BCC3:BCC3Controller.text,
            BCLON:BCLONController.text,
            BCLAT:BCLATController.text,
            BCQND:BCQNDController.text,
            BCAD2:BCAD2Controller.text,
            BCPC:BCPCController.text,
            BCJT:BCJTController.text,
            BCBL:BCBLController.text.isEmpty?0: double.parse(BCBLController.text),
            BCDM:BCDMController.text.isEmpty?0:int.parse(BCDMController.text),
            BCCR:BCCRController.text.isEmpty?0:int.parse(BCCRController.text),
            SUID:LoginController().SUID,
            GUID:GUID.toString().toUpperCase(),
            AANO:GUID.toString().toUpperCase(),
            SYST_L: 2,
            BCDL_L: 2,
            DATEI:  DateFormat('dd-MM-yyyy HH:mm:ss').format(DateTime.now()),
            DEVI:   LoginController().DeviceName,
            JTID_L: LoginController().JTID,
            BIID_L: LoginController().BIID,
            SYID_L: LoginController().SYID,
            CIID_L: LoginController().CIID,
          );
          Acc_Acc_Local A = Acc_Acc_Local(
            AANO:GUID.toString().toUpperCase(),
            AANA: BCNAController.text,
            AANE: BCNEController.text.isEmpty?BCNAController.text:BCNEController.text,
            AATY:2,
            AKID:1,
            OKID:5,
            // AGID:1,
            AAFN:'12201',
            AASE:1,
            AAST:1,
            AAIN:BCINController.text,
            AAAD:BCADController.text,
            AATL:BCMOController.text,
            AACT:1,
            AAKI:2,
            AAOV:1,
            AACC:2,
            AACH:2,
            AAPR:2,
            AAPN:0,
            AADP:DateFormat('dd-MM-yyyy HH:mm:ss').format(DateTime.now()),
            AADO:DateFormat('dd-MM-yyyy HH:mm:ss').format(DateTime.now()),
            AADC:DateFormat('dd-MM-yyyy HH:mm:ss').format(DateTime.now()),
            SUID:LoginController().SUID,
            AAMA:2,
            AAMN:90,
            SYST_L: 2,
            BIID:int.parse(SelectDataBIID.toString()),
            GUID:GUID.toString().toUpperCase(),
            DATEI: DateFormat('dd-MM-yyyy HH:mm:ss').format(DateTime.now()),
            DEVI: LoginController().DeviceName,
            JTID_L: LoginController().JTID,
            BIID_L: LoginController().BIID,
            SYID_L: LoginController().SYID,
            CIID_L: LoginController().CIID,
          );
          Acc_Usr_Local U = Acc_Usr_Local(
            AANO:GUID.toString().toUpperCase(),
            SUID:LoginController().SUID,
            AUIN:1,
            AUOU:1,
            AUPR:1,
            AUDL:1,
            AUOT:1,
            SUAP:'2',
            SYST_L: 2,
            AUDO:DateFormat('dd-MM-yyyy HH:mm:ss').format(DateTime.now()),
            GUID:GUID.toString().toUpperCase(),
            DATEI: DateFormat('dd-MM-yyyy HH:mm:ss').format(DateTime.now()),
            DEVI: LoginController().DeviceName,
            JTID_L: LoginController().JTID,
            BIID_L: LoginController().BIID,
            SYID_L: LoginController().SYID,
            CIID_L: LoginController().CIID,
          );
          Acc_Tax_C_Local T = Acc_Tax_C_Local(
            AANO:GUID.toString().toUpperCase(),
            SUID:LoginController().SUID,
            ATTID:int.parse(SelectDataATTID.toString()),
            ATCST:'1',
            JTID_L: LoginController().JTID,
            BIID_L: LoginController().BIID,
            SYID_L: LoginController().SYID,
            CIID_L: LoginController().CIID,
          );
          STB_N='S3';
          await  Save_BIL_CUS(B);
          await Save_ACC_ACC(A);
          await Save_ACC_USR(U);
          await Save_ACC_TAX_C(T);
        }
        else {
          STB_N='S4';
          UpdateBIL_CUS(BCID,SelectDataBCTID,SelectDataATTID,PKID,SelectDataBCPR,SelectDataCWID,SelectDataCTID,SelectDataBAID,
              SelectDataCWID2 == null ? null : SelectDataCWID2.toString(),SelectDataCTID2 == null ? null : SelectDataCTID2.toString(),
              SelectDataBAID2 == null ? null : SelectDataBAID2.toString(),
              BCNAController.text,BCNEController.text,BCMOController.text,BCTLController.text,BCADController.text,BCTXController.text,
              BCSNController.text, BCBNController.text,BCONController.text,BCC1Controller.text,BCINController.text,
              LoginController().JTID,LoginController().SYID,LoginController().BIID,LoginController().CIID,
              LoginController().SUID,DateFormat('dd-MM-yyyy HH:mm:ss').format(DateTime.now()),2,SelectDataBDID,BCC3Controller.text,
              BCHNController.text,BCLONController.text,BCLATController.text,
              BCJTController.text,BCPCController.text,BCAD2Controller.text,BCQNDController.text);
          UpdateACC_ACC(AANO, BCNAController.text,BCNEController.text,
              LoginController().JTID,LoginController().SYID,LoginController().BIID,LoginController().CIID,
              LoginController().SUID,DateFormat('dd-MM-yyyy HH:mm:ss').format(DateTime.now()));
          UpdateTAX_LIN(AANO, BCTXController.text,
              LoginController().JTID,LoginController().SYID,LoginController().BIID,LoginController().CIID,
              LoginController().SUID,DateFormat('dd-MM-yyyy HH:mm:ss').format(DateTime.now()));
          UpdateBIL_NAME_CUS('BIL_MOV_M',BCID, BCNAController.text, LoginController().JTID,
            LoginController().SYID,LoginController().BIID,LoginController().CIID);
          UpdateBIL_NAME_CUS('BIF_MOV_M',BCID, BCNAController.text, LoginController().JTID,
            LoginController().SYID,LoginController().BIID,LoginController().CIID);
        }
        LoginController().SET_N_P('BIID_Cus',int.parse(SelectDataBIID.toString()));
        LoginController().SET_N_P('BCTID_Cus',int.parse(SelectDataBCTID.toString()));
        LoginController().SET_N_P('ATTID_Cus',int.parse(SelectDataATTID.toString()));
        LoginController().SET_N_P('BCPR_Cus',int.parse(SelectDataBCPR.toString()));
        LoginController().SET_N_P('PKID_Cus',int.parse(PKID.toString()));
        LoginController().SET_N_P('BDID_Cus', SelectDataBDID.toString() == 'null' || SelectDataBDID==null ? 0 : int.parse(SelectDataBDID.toString()));
        LoginController().SET_N_P('BAID_Cus', SelectDataBAID.toString() == 'null' || SelectDataBAID==null ? 0 : int.parse(SelectDataBAID.toString()));
        LoginController().SET_P('CWID_Cus', SelectDataCWID.toString() == 'null' || SelectDataCWID==null ? '0' : SelectDataCWID.toString());
        LoginController().SET_P('CTID_Cus', SelectDataCTID.toString() == 'null' || SelectDataCTID==null ? '0' : SelectDataCTID.toString());
        LoginController().SET_B_P('value_Cus',value);
        print(LoginController().BDID_Cus);
        print('LoginController().BDID_Cus');
        ClearCustomersData();
        Get.snackbar(
            'StringMesSave'.tr, "${'StringMesSave'.tr}-$BCID",
            backgroundColor: Colors.green,
            icon: Icon(Icons.save, color: Colors.white),
            colorText: Colors.white,
            isDismissible: true,
            dismissDirection: DismissDirection.horizontal,
            forwardAnimationCurve: Curves.easeOutBack);
        update();
        loading(false);
        formKey.currentState!.save;
        if(Get.arguments==1){
          Navigator.of(context).pop(false);
          // Get.back();
          return true;
        }else{
          Socket_IP_Connect('SyncOnly', BCID.toString());
          Get.offNamed('/View_Customers');
          GET_BIL_CUS_P("ALL");
          update();
        }
        return true;
      }
    // }
    // catch (e) {
    //   Fluttertoast.showToast(
    //       msg: "${STB_N}-${'StrinError_save_data'.tr}",
    //       toastLength: Toast.LENGTH_LONG,
    //       textColor: Colors.white,
    //       backgroundColor: Colors.redAccent);
    //   return false;
    // }
  }


  //التاكد من العميل ليس مرتبط باي فاتوره او سند
  Future CHECK_DELETE_BCID_P(GETAANO_D,GETBCID_D) async {
    CHECK_DELETE_BCID(GETAANO_D,GETBCID_D).then((data) {
      BIL_CUS  = data;
      if(BIL_CUS.isNotEmpty){
        AANO_D=BIL_CUS.elementAt(0).AANO_D;
      }
    });
  }

  //حذف عميل
  Future<bool> Delete_BIL_CUS_P(GetBCID,GetAANO) async {
    if(UPDL==1){
      if(AANO_D==0){
        deleteBIL_CUS(GetBCID);
        await deleteCUS('ACC_ACC',GetAANO);
        await deleteCUS('ACC_USR',GetAANO);
        await deleteCUS('ACC_TAX_C',GetAANO);
        Get.snackbar(
            'StringDelete'.tr,
            "${'StringDelete'.tr}-${GetBCID}",
            backgroundColor: Colors.green,
            icon: Icon(Icons.delete,color:Colors.white),
            colorText:Colors.white,
            isDismissible: true,
            dismissDirection: DismissDirection.horizontal,
            forwardAnimationCurve: Curves.easeOutBack);
        onInit();
        update();
        return true;
      }
      else{
        Get.snackbar('StringUPDL'.tr, 'String_CHK_DELETE_CUS'.tr,
            backgroundColor: Colors.red,
            icon: const Icon(Icons.error, color: Colors.white),
            colorText: Colors.white,
            isDismissible: true,
            dismissDirection: DismissDirection.horizontal,
            forwardAnimationCurve: Curves.easeOutBack);
        return false;
      }

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

  ClearCustomersData(){
    SelectDataBIID = null;
    BCNAController.clear();
    BCNEController.clear();
    SelectDataBCTID= null;
    SelectDataATTID= null;
    SelectDataCWID= null;
    SelectDataCTID= null;
    SelectDataBAID=null;
    SelectDataBDID=null;
    BCADController.clear();
    BCMOController.clear();
    BCTLController.clear();
    BCTXController.clear();
    BCSNController.clear();
    BCINController.clear();
    BCBNController.clear();
    BCONController.clear();
    BCHNController.clear();
    BCLATController.clear();
    BCLONController.clear();
    CompareBCNAChanged=false;
  }


  Socket_IP_Connect(String TypeSync, String GETBCID) async {
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
      SyncCustomer(TypeSync, GETBCID);
      socket.destroy();
    }).catchError((error) {
      Get.snackbar('StringCHK_Err_Con'.tr, 'StringCHK_Con'.tr,
          backgroundColor: Colors.red,
          icon: const Icon(Icons.error, color: Colors.white),
          colorText: Colors.white,
          isDismissible: true,
          dismissDirection: DismissDirection.horizontal,
          forwardAnimationCurve: Curves.easeOutBack);
      configloading();
      print("Exception on Socket " + error.toString());
    });
  }

  Future SyncCustomer(String TypeSync, String GETBCID) async {
    await SyncronizationData().FetchCustomerData(TypeSync, GETBCID).then((CustomerList) async {
      if (CustomerList.isNotEmpty) {
        TAB_N = 'BIL_CUS';
        await SyncronizationData().SyncCustomerToSystem(CustomerList, TypeSync, GETBCID,1,false);
        Timer(const Duration(seconds: 2), () {
          GET_BIL_CUS_P("ALL");
        });
        // GET_COUNT_SYNC();
        update();
      }else{
        configloading();
      }

    });
  }

  configloading() {
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
    EasyLoading.showError("StrinError_Sync".tr);
  }

  Future<Position> determinePosition() async {
    bool serviceEnabled;
    LocationPermission permission;
    print('st----1');
    // Test if location services are enabled.
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      // Location services are not enabled don't continue
      // accessing the position and request users of the
      // App to enable the location services.
      Geolocator.openLocationSettings();
      print('st----2');
      return Future.error('Location services are disabled.');
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {

      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        // Permissions are denied, next time you could try
        // requesting permissions again (this is also where
        // Android's shouldShowRequestPermissionRationale
        // returned true. According to Android guidelines
        // your App should show an explanatory UI now.
        print('st----3');
        Geolocator.openLocationSettings();
        return Future.error('Location permissions are denied');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      // Permissions are denied forever, handle appropriately.
      print('st----4');
      return Future.error('Location permissions are permanently denied, we cannot request permissions.');
    }

    toggleListening();
    // When we reach here, permissions are granted and we can
    // continue accessing the position of the device.
    return await Geolocator.getCurrentPosition();
  }

  void toggleListening() {
    if (_positionStreamSubscription == null) {
      print('st----5');
      final positionStream = _geolocatorPlatform.getPositionStream();
      _positionStreamSubscription = positionStream.handleError((error) {
        _positionStreamSubscription?.cancel();
        _positionStreamSubscription = null;
      }).listen((position){
        GetLocaton(position);
        print(_positionStreamSubscription!.isPaused);
        print(position);
        print('_positionStreamSubscription!.isPaused');
        _positionStreamSubscription?.pause();
      });
          // _updatePositionList(_PositionItemType.position,position,));

      print(_positionStreamSubscription!.isPaused);
    }
      if (_positionStreamSubscription == null) {
        print('st----6');
        return;
      }
      String statusDisplayValue;
      if (_positionStreamSubscription!.isPaused) {
        print('st----7');
        _positionStreamSubscription!.resume();
        statusDisplayValue = 'resumed';
      }
      else {
        print('st----8');
        _positionStreamSubscription!.pause();
        statusDisplayValue = 'paused';
      }

  }

  GetLocaton(Position position) async {
    print('st----10');
    if(position != 'null'&&position.isMocked==false ){
      Position pos = await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.best,);
      longitude!.value = pos.longitude.toDouble();
      latitude!.value = pos.latitude.toDouble();
      if(Update_location_account=='2'){
        BCLATController.text=='' ? BCLATController.text=pos.latitude.toString()
            : BCLATController.text=BCLATController.text;
        BCLONController.text=='' ? BCLONController.text=pos.longitude.toString():
        BCLONController.text=BCLONController.text;
      }
      else
      {
        BCLATController.text=='' ? BCLATController.text=pos.latitude.toString()
            : BCLATController.text=BCLATController.text;
        BCLONController.text=='' ? BCLONController.text=pos.longitude.toString():
        BCLONController.text=BCLONController.text;
      }
      print("BCLATController.text "+BCLATController.text);
      print("BCLONController.text"+BCLONController.text);
      //
      var _distanceBetweenLastTwoLocations = Geolocator.distanceBetween(double.parse (pos.latitude.toString())
          ,double.parse(pos.longitude.toString()) , double.parse (pos.latitude.toString()),
          double.parse (pos.longitude.toString()));
      distanceInMeters = _distanceBetweenLastTwoLocations;
      print('Total Distance: $distanceInMeters');
      print('Distance: ${ distanceInMeters > 1000 ? (distanceInMeters / 1000).toStringAsFixed(2)
          : distanceInMeters.toStringAsFixed(2) } ${distanceInMeters > 1000 ? 'KM' : 'meters' }');
    }
    else{
      print(position.longitude);
      print(position.isMocked);
      if(position.longitude!='null'){
        latitude!.value=0.0;
        longitude!.value=0.0;
        BCLATController.text='0.0';
        BCLONController.text='0.0';
        distanceInMeters=0;
        //
        // Timer(Duration(seconds: 5), ()
        // {
        // //  exit(0);
        //   GetSnackMsg(
        //       msg: 'Please don\'t use fake Location'.tr,
        //       bgClr: kColorsDanger,
        //       txClr: kColorsBackground).showTxt();
        // });

      }
    }
  }
}
