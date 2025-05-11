import 'dart:async';
import '../../Reports/Views/Inventory_Quantity/show_sto_num.dart';
import '../../Setting/controllers/login_controller.dart';
import '../../Setting/models/sto_num_local.dart';
import '../../database/setting_db.dart';
import '../../database/sto_num_db.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';


List<Sto_Num> get_Sto_Num = [];

class Sto_NumController extends GetxController {
  //TODO: Implement HomeController
  var isloading = false.obs;
  bool NOT_Quantities = false,STO_V_N=false,isTablet = false;
  String? SelectDataBIID, SelectDataSIID, SelectDataSINA, SelectBINA,
      SelectDataMGNO,SelectDataMGNO2,SelectDataMINO,SelectDataMINO_TO,SelectDataMGNA,SelectDataMINA,SelectDataMINA_TO;
  GlobalKey<FormState> abcKey = GlobalKey<FormState>();
  String
      SMDED = '',
      TYPE_DATA = '1',
      SONA = '',
      SONE = '',
      SORN = '',
      SDDSA = '',
      SOLN = '',SCID='1',TYPE_T='1';
  double SUM_SNNO=0.0,SUM_MPS1=0.0;
  int? COUNT_MINO=0,UPIN=1,UPCH=1,UPQR=1,UPDL=1,UPPR=1,UPIN2=1,UPCH2=1,UPQR2=1,UPDL2=1,UPPR2=1;
  late TextEditingController TextEditingSercheController;
  late List<Sto_Num> SUM_STO_NUM;

  @override
  void onInit() async {
    TextEditingSercheController = TextEditingController();
    USE_SMDED_P();
    GET_SYS_DOC_D();
    GET_SYS_OWN_P();
    GET_USR_PRI();
    GET_PRIVLAGE();
    USE_SCID_P();
    USE_TYPE_DATA_P();
    SelectDataBIID = LoginController().BIID.toString();
    GET_BRA_INF();
    super.onInit();
  }


  void clear() {
    // TODO: implement dispose
    SelectDataSIID=null;
    SelectDataMGNO=null;
    SelectDataMGNO2=null;
    SelectDataMINO=null;
    SelectDataMINO_TO=null;
    SelectDataMGNA=null;
    SelectDataMINA=null;
    SelectDataMINA_TO=null;
    SelectDataBIID =LoginController().BIID.toString();
    STO_V_N=false;
    update();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    TextEditingSercheController.dispose();
    super.dispose();
  }


  //صلاحيات الكمية المخزنية
  Future GET_PRIVLAGE() async {
   var PRIVLAGE_USR=await PRIVLAGE(LoginController().SUID,1521);
      if(PRIVLAGE_USR.isNotEmpty){
        UPIN2=PRIVLAGE_USR.elementAt(0).UPIN;
        UPCH2=PRIVLAGE_USR.elementAt(0).UPCH;
        UPDL2=PRIVLAGE_USR.elementAt(0).UPDL;
        UPPR2=PRIVLAGE_USR.elementAt(0).UPPR;
        UPQR2=PRIVLAGE_USR.elementAt(0).UPQR;
      }else {
        UPIN2=2;UPCH2=2;UPDL2=2;UPPR2=2;UPQR2=2;
      }
  }

  //جلب عملة المخزون
  Future USE_SCID_P() async {
    var SYS_VAR_SCID=await GET_SYS_VAR(952);
      if(SYS_VAR_SCID.isNotEmpty) {
        SCID = SYS_VAR_SCID.elementAt(0).SVVL.toString();
      }
  }


  Future FetchPdfData() async {
    get_Sto_Num=await query_STO_NUM(SelectDataBIID.toString(), SelectDataSIID.toString(),
        SelectDataMGNO2.toString(), SelectDataMINO.toString(),SelectDataMINO_TO.toString()
        ,NOT_Quantities,SCID.toString(),STO_V_N,TYPE_DATA,TYPE_T);
      if(get_Sto_Num.isNotEmpty){
       SUM_STO_NUM=await  GET_SUM_STO_NUM(SelectDataBIID.toString(), SelectDataSIID.toString(),
            SelectDataMGNO2.toString(), SelectDataMINO.toString(),NOT_Quantities,SCID.toString(),STO_V_N);
              if(SUM_STO_NUM.isNotEmpty){
                SUM_SNNO=SUM_STO_NUM.elementAt(0).SUM_SNNO!;
                SUM_MPS1=SUM_STO_NUM.elementAt(0).SUM_MPS1!;
                COUNT_MINO=SUM_STO_NUM.elementAt(0).COUNT_MINO!;
              }
       update();
      }

  }

  //جلب الفرع
  Future GET_BRA_INF() async {
    var  BRA_INF=await GET_BINA();
    if(BRA_INF.isNotEmpty) {
      SelectBINA = BRA_INF.elementAt(0).BINA.toString();
    }
  }

  //جلب تذلبل المستندات
  Future GET_SYS_DOC_D() async {
    var  GET_SYS_DOC=await Get_SYS_DOC_D('ST',17,LoginController().BIID);
    if (GET_SYS_DOC.isNotEmpty) {
      SDDSA=GET_SYS_DOC.elementAt(0).SDDSA_D.toString();}
  }

  //جلب بيانات المنشاة
  Future GET_SYS_OWN_P() async {
    var SYS_OWN=await GET_SYS_OWN(LoginController().BIID);
    if (SYS_OWN.isNotEmpty) {
      SONA=SYS_OWN.elementAt(0).SONA.toString();
      SONE=SYS_OWN.elementAt(0).SONE.toString();
      SORN=SYS_OWN.elementAt(0).SORN.toString();
      SOLN=SYS_OWN.elementAt(0).SOLN.toString();
    }
  }

//جلب صلاحية استخدام تاريخ الانتهاء
  Future USE_SMDED_P() async {
    var SYS_VAR_SMDED=await GET_SYS_VAR(976);
    if(SYS_VAR_SMDED.isNotEmpty) {
      SMDED = SYS_VAR_SMDED.elementAt(0).SVVL.toString();
    }
  }

  //نوع البيانات المستخدمه في ترقيم الاصناف-حروف,ارقام...
  Future USE_TYPE_DATA_P() async {
    var SYS_VAR_S=await GET_SYS_VAR(1002);
    if(SYS_VAR_S.isNotEmpty) {
      TYPE_DATA = SYS_VAR_S.elementAt(0).SVVL.toString();
    }else{
      TYPE_DATA='1';
    }
  }

  //الاطلاع على سعر التكلفه في الجرد
  Future GET_USR_PRI() async {
   var USR_PRI=await PRIVLAGE(LoginController().SUID,1510);
      if(USR_PRI.isNotEmpty){
        UPIN=USR_PRI.elementAt(0).UPIN;
        UPCH=USR_PRI.elementAt(0).UPCH;
        UPDL=USR_PRI.elementAt(0).UPDL;
        UPPR=USR_PRI.elementAt(0).UPPR;
        UPQR=USR_PRI.elementAt(0).UPQR;
      }else {
        UPIN=2;UPCH=2;UPDL=2;UPPR=2;UPQR=2;
      }
  }

  Search() async {
    bool isValidate = abcKey.currentState!.validate();
    if (isValidate) {
      isloading(true);
    }
    try {
      if(UPQR2==1){
        abcKey.currentState?.reset();
        if (SelectDataBIID == null) {
          Fluttertoast.showToast(
              msg: 'StringBrach'.tr,
              textColor: Colors.white,
              backgroundColor: Colors.red);
        } else  {
          print('SelectDataMINO');
          print(SelectDataMINO);
          print(SelectDataSIID);
          // SelectDataSIID ==null?SelectDataSIID='':SelectDataSIID=SelectDataSIID;
          Get.to(() => Show_Sto_Num());
        }
      }else{
        Get.snackbar('StringSto_Num'.tr, 'String_CHK_Sto_Num'.tr,
            backgroundColor: Colors.red, icon: Icon(Icons.error,color:Colors.white),
            colorText:Colors.white,
            isDismissible: true,
            dismissDirection: DismissDirection.horizontal,
            forwardAnimationCurve: Curves.easeOutBack);
      }
    } finally {
      isloading(false);
    }
    //Get.offAllNamed(Routes.LOGIN);
  }
}
