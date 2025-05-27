import 'dart:async';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import '../../Operation/models/bil_mov_m.dart';
import '../../Setting/controllers/login_controller.dart';
import '../../Setting/models/usr_pri.dart';
import '../../Widgets/ES_FAT_PKG.dart';
import '../../Widgets/pdf.dart';
import '../../Widgets/pdfpakage.dart';
import '../../database/invoices_db.dart';
import '../../database/report_db.dart';
import '../../database/setting_db.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:intl/intl.dart' as intl;

import '../../database/sync_db.dart';

List<Bil_Mov_M_Local> BIF_MOV_M_CUS_List = [];
List<Bil_Mov_M_Local> GET_ACC_MOV_D_SUM_REP_List = [];
class Cus_Bal_Rep_Controller extends GetxController {
  //TODO: Implement HomeController
  var isloading = false.obs,GUIDC;
  final formatter = intl.NumberFormat.decimalPattern();
  bool value = false;
  bool value1 = false;
  bool NOT_BAL = false,SH_DA=false,V_TEL=false,V_INV_NO=false;
  bool Show_Last_Balance = false;

  // late  DateTime dateFromDays =  DateFormat('dd-MM-yyyy').format(DateTime.now()) as DateTime;
  DateTime dateFromDays1 = DateTime.now();
  String dateFromDays = DateFormat('yyyy-MM-dd').format(DateTime.now());
  DateTime dateTimeToDays2 = DateTime.now();
  String dateTimeToDays = DateFormat('yyyy-MM-dd').format(DateTime.now());
  String? SelectFromDays,SelectToDays,SelectDataACNO_F,SelectDataACNO_T,AMKID_F,AMKID_T,SUID_V,
      SelectDataACID,ST_F,ST_T,BDID_F,BDID2_F,BDID_T,BDID2_T,SelectDataFromBIID='',SelectDataToBIID='', SelectDataFromBINA, SelectDataToBINA,
      SelectBINA,SelectDataSCID_F,SelectDataSCID_T,PKID,SelectDataBCID_F,SelectDataBCID_T,
      SelectDataAANO_F,SelectDataAANO_T,SelectDataBCNA_F,SelectDataBCNA_T,SelectDataSCNA_F,SelectDataSCNA_T,
      SelectBIST_F='1',SelectBIST_T='4',SelectDataBCTID_F,SelectDataBCTID_T,SelectDataCWID_F,SelectDataCWID2_F,
     SelectDataCWID_T,SelectDataCWID2_T,SelectDataBAID2_F,SelectDataBAID_F,SelectDataBAID2_T,SelectDataBAID_T,
      SelectDataBCTNA_F,SelectDataBCTNA_T,SelectBISTD_F,SelectBISTD_T,SelectDataCWNA_F,SelectDataCWNA_T,SelectDataBANA_F,
      SelectDataBANA_T,SelectDataAANO2_F,SelectDataAANO2_T,SelectDataACID_D,SelectDataACNO,TYPE_ORD='1',
      TYPE_ORD2='1',GRO_BY='1',LastBAL_ACC_M='';
  int? UPIN=1,UPCH=1,UPQR=1,UPDL=1,UPPR=1,TYPE_REP=1;
  double SUM_BACBMD=0.0,SUM_BACBDA=0.0,SUM_BACBA=0.0,GET_ACC_MOV_D_TOT_REP_List=0.0,Last_Balance=0.0;
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
  Future<void> selectDateFromDays(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate:  dateFromDays1,
      firstDate: DateTime(2022,5),
      lastDate: DateTime(2030),
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
      SelectFromDays =  DateFormat("yyyy-MM-dd").format(picked);
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
      SelectToDays = DateFormat("yyyy-MM-dd").format(picked);
    }
    update();
    refresh();
  }
  String SDDSA='',SONA='',SONE='',SORN='',SOLN='',SDDDA='';

  late TextEditingController TextEditingSercheController, BCNAController;

  @override
  void onInit() async {
    TextEditingSercheController = TextEditingController();
    BCNAController = TextEditingController();
    GET_BRA_INF_ONE_P();
    GET_PRIVLAGE();
    GET_SYS_OWN_P();
    GET_SYS_DOC_D();
    super.onInit();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    BCNAController.dispose();
    TextEditingSercheController.dispose();
    super.dispose();
  }

  String? selectedOption = '1';

  // دالة لتغيير القيمة عند اختيار Radio Button
  void handleRadioValueChange(String? value) {
      selectedOption = value;
    update();
  }

  //صلاحيات
  Future GET_PRIVLAGE() async {
    var PRIVLAGE_USR=await PRIVLAGE(LoginController().SUID,224);
      if(PRIVLAGE_USR.isNotEmpty){
        UPIN=PRIVLAGE_USR.elementAt(0).UPIN;
        UPCH=PRIVLAGE_USR.elementAt(0).UPCH;
        UPDL=PRIVLAGE_USR.elementAt(0).UPDL;
        UPPR=PRIVLAGE_USR.elementAt(0).UPPR;
        UPQR=PRIVLAGE_USR.elementAt(0).UPQR;
      } else {
        UPIN=2;UPCH=2;UPDL=2;UPPR=2;UPQR=2;
      }
  }


  //جلب تذلبل المستندات
  Future GET_SYS_DOC_D() async {
  var GET_SYS_DOC=await Get_SYS_DOC_D('AC',202, LoginController().BIID);
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
      }
  }

  Future GET_BRA_INF_ONE_P() async {
    var  BRA_INF=await GET_BRA_ONE(2);
      if(BRA_INF.isNotEmpty){
        SelectDataFromBIID=BRA_INF.elementAt(0).BIID.toString();
        SelectDataToBIID=BRA_INF.elementAt(0).BIID.toString();
        SelectDataFromBINA=BRA_INF.elementAt(0).BINA_D.toString();
        SelectDataToBINA=BRA_INF.elementAt(0).BINA_D.toString();
      }
      update();
  }

  void Clear_P() {
    // TODO: implement dispose
    GET_BRA_INF_ONE_P();
    SelectDataACNO_F=null;
    SelectDataACNO_T=null;
    SelectDataSCID_F=null;
    SelectDataSCID_T=null;
    SelectDataSCID_F=null;
    SelectDataSCID_T=null;
    SelectDataBCID_F=null;
    SelectDataBCID_T=null;
    SelectDataAANO_F=null;
    SelectDataAANO_T=null;
    SelectBIST_F='1';
    SelectBIST_T='4';
    SelectDataBCTID_F=null;
    SelectDataBCTID_T=null;
    SelectDataCWID2_F=null;
    SelectDataCWID_F=null;
    SelectDataCWID_T=null;
    SelectDataCWID2_T=null;
    SelectDataBAID_F=null;
    SelectDataBAID2_F=null;
    SelectDataBAID_T=null;
    SelectDataBAID2_T=null;
    SelectDataFromBINA=null;
    SelectDataToBINA=null;
    SelectDataBCTNA_F=null;
    SelectDataBCTNA_T=null;
    SelectBISTD_F=null;
    SelectBISTD_T=null;
    SelectDataCWNA_F=null;
    SelectDataCWNA_T=null;
    SelectDataBANA_F=null;
    SelectDataBANA_T=null;
    SelectDataBCID_F=null;
    SelectDataBCID_T=null;
    SelectDataBCNA_F=null;
    SelectDataBCNA_T=null;
    SelectDataAANO2_F=null;
    SelectDataAANO2_T=null;
    NOT_BAL=false;
    SH_DA=false;
    V_TEL=false;
    V_INV_NO=false;
    Show_Last_Balance=false;
    AMKID_F=null;
    AMKID_T=null;
    ST_F='1';
    ST_T='2';
    update();
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

  Future GET_SYS_CUR_ONE() async {
   var SYS_CUR_ONE_SALE=await GET_SYS_CUR_ONE_SALE();
      if (SYS_CUR_ONE_SALE.isNotEmpty) {
        SelectDataSCID_F = SYS_CUR_ONE_SALE.elementAt(0).SCID.toString();
      }
      GET_ACC_CAS_ONE();
      ST_F='1';
      ST_T='2';
      update();
  }

  Future GET_ACC_CAS_ONE() async {
   var ACC_CAS_REP_ONE=await GET_ACC_CAS_REP_ONE();
      if (ACC_CAS_REP_ONE.isNotEmpty) {
        SelectDataACID = ACC_CAS_REP_ONE.elementAt(0).ACID.toString();
        SelectDataACID_D = ACC_CAS_REP_ONE.elementAt(0).ACNA_D.toString();
      }
      update();
  }


  Future GET_SYN_ORD_P() async {
    var SYN_ORD=await GET_SYN_ORD('BAL_ACC_D');
    if (SYN_ORD.isNotEmpty) {
      LastBAL_ACC_M = SYN_ORD.elementAt(0).SOLD.toString();
    }
  }

  Future GET_BIL_ACC_D_P(String GETBIID_F,String GETBIID_T,String GETSCID_F,String GETSCID_T,String GETAANO_F,String GETAANO_T,
      String GETBCTID_F,String GETBCTID_T,String GETBCST_F,String GETBCST_T,String GETCWID_F,
      String GETCWID_T,String GETBAID_F,String GETBAID_T) async {
    await GET_SYN_ORD_P();
    var BAL_ACC_C =await GET_Customers_Balances(TYPE_REP!,GETBIID_F,GETBIID_T,GETSCID_F,GETSCID_T,GETAANO_F,GETAANO_T, GETBCTID_F, GETBCTID_T,GETBCST_F,
        GETBCST_T,GETCWID_F,GETCWID_T,GETBAID_F,GETBAID_T,NOT_BAL,TYPE_ORD,TYPE_ORD2);
      update();
    // var BAL_ACC_C_SUM=  await GET_Customers_Balances_SUM(TYPE_REP!,GETBIID_F,GETBIID_T,GETSCID_F,GETSCID_T,GETAANO_F,GETAANO_T, GETBCTID_F, GETBCTID_T,GETBCST_F,
    //       GETBCST_T,GETCWID_F,GETCWID_T,GETBAID_F,GETBAID_T,NOT_BAL,TYPE_ORD,TYPE_ORD2);
    //     if(BAL_ACC_C_SUM.isNotEmpty){
    //       SUM_BACBMD=double.parse(BAL_ACC_C_SUM.elementAt(0).SUM_BACBMD.toString());
    //       SUM_BACBDA=double.parse(BAL_ACC_C_SUM.elementAt(0).SUM_BACBDA.toString());
    //       SUM_BACBA=double.parse(BAL_ACC_C_SUM.elementAt(0).SUM_BACBA.toString());
    //       update();
    //     }
    //     else{
    //       SUM_BACBMD=0.0;
    //       SUM_BACBDA=0.0;
    //       SUM_BACBA=0.0;
    //     }
     //   update();
      if (BAL_ACC_C.isEmpty) {
        Get.snackbar('StringNo_Data_Rep'.tr, 'StringChk_No_Data'.tr,
            backgroundColor: Colors.red,
            icon: const Icon(Icons.error, color: Colors.white),
            colorText: Colors.white,
            isDismissible: true,
            dismissDirection: DismissDirection.horizontal,
            forwardAnimationCurve: Curves.easeOutBack);
        isloading.value = false;
        EasyLoading.dismiss();
      }
      else {
        final pdfFile = await Pdf.Customers_Balances_Pdf(
            SelectDataFromBINA.toString(),
            SelectDataToBINA.toString(),
            SelectDataSCNA_F.toString(),
            SelectDataSCNA_T.toString(),
            SelectDataBCNA_F.toString(),
            SelectDataBCNA_T.toString()=='null'?
            SelectDataBCNA_F.toString():
            SelectDataBCNA_T.toString(),
            SelectDataBCTNA_F.toString(),
            SelectDataBCTNA_T.toString(),
            SelectBISTD_F.toString(),
            SelectBISTD_T.toString(),
            SelectDataCWNA_F.toString(),
            SelectDataCWNA_T.toString(),
            SelectDataBANA_F.toString(),
            SelectDataBANA_T.toString(),
            LoginController().BINA.toString(),
            SONA.toString(),
            SONE.toString(),
            SORN.toString(),
            SOLN.toString(),
            TYPE_REP==1?'Cus_Bal': TYPE_REP==2?'Bal_Bal':'Acc_Bal',
            LoginController().SUNA,
            SDDDA.toString(),
            SDDSA.toString(),
            SUM_BACBMD,
            SUM_BACBDA,
            SUM_BACBA,
            BAL_ACC_C,
            SH_DA,
            V_TEL,
            V_INV_NO,
            GRO_BY.toString(),
            LastBAL_ACC_M.toString()
             );
        PdfPakage.openFile(pdfFile!);
        isloading.value = false;
        EasyLoading.dismiss();
      }
      update();
  }


  Future GET_ACC_MOV_D_P(String GETBIID_F,String GETBIID_T,
      String GETDATE_F,String GETDATE_T,String GETSCID_F,
       String GETAMKID_F,String GETAMKID_T,String GETACNO,String GETACID,
       String GETST_F,String GETST_T) async {
    BIF_MOV_M_CUS_List =await GET_ACC_MOV_D_REP( GETBIID_F, GETBIID_T, GETDATE_F, GETDATE_T, GETSCID_F,
           GETAMKID_F, GETAMKID_T, GETACNO, GETACID, GETST_F, GETST_T);
      if (BIF_MOV_M_CUS_List.isEmpty) {
        Get.snackbar('StringNo_Data_Rep'.tr, 'StringChk_No_Data'.tr,
            backgroundColor: Colors.red,
            icon: const Icon(Icons.error, color: Colors.white),
            colorText: Colors.white,
            isDismissible: true,
            dismissDirection: DismissDirection.horizontal,
            forwardAnimationCurve: Curves.easeOutBack);
        isloading.value = false;
        EasyLoading.dismiss();
      }
      else {
        SelectDataSCNA_F=await  ES_FAT_PKG.TYP_NAM_F('SCID',SelectDataSCID_F.toString(),'');
        GET_ACC_MOV_D_SUM_REP_List=await  GET_ACC_MOV_D_SUM_REP(GETBIID_F, GETBIID_T, GETDATE_F, GETDATE_T, GETSCID_F,
            GETAMKID_F, GETAMKID_T, GETACNO, GETACID, GETST_F, GETST_T);
          update();

      await GET_ACC_MOV_D_TOT_REP(GETBIID_F, GETBIID_T, GETDATE_F, GETDATE_T, GETSCID_F,
            GETAMKID_F, GETAMKID_T, GETACNO, GETACID,GETST_F, GETST_T).then((data) async {
           GET_ACC_MOV_D_TOT_REP_List = double.parse(data.elementAt(0).BAL.toString());
          update();
        });
      await Show_Last_Balance_REP(GETBIID_F, GETBIID_T, GETDATE_F, GETDATE_T, GETSCID_F,
            GETAMKID_F, GETAMKID_T, GETACNO, GETACID,GETST_F, GETST_T).then((data) async {
            Last_Balance = double.parse(data.elementAt(0).BAL.toString()=='null'?'0':data.elementAt(0).BAL.toString());
          update();
        });

        await Future.delayed(const Duration(seconds: 2));
        final pdfFile = await Pdf.Daily_Treasury_Pdf(
            SelectDataFromBINA.toString(),
            SelectDataToBINA.toString(),
            SelectFromDays.toString(),
            SelectToDays.toString(),
            SelectDataSCNA_F.toString(),
            SelectDataACID_D.toString(),
            GET_ACC_MOV_D_TOT_REP_List,
            Last_Balance,
            Show_Last_Balance,
            SONA.toString(),
            SONE.toString(),
            SORN.toString(),
            SOLN.toString(),
            TYPE_REP==1?'Cus_Bal': TYPE_REP==2?'Cus_Bal_Bal':'Cus_Acc_Bal',
            LoginController().SUNA,
            SDDDA.toString(),
            SDDSA.toString());
        PdfPakage.openFile(pdfFile!);
        isloading.value = false;
        EasyLoading.dismiss();
      }
      update();
  }

}


