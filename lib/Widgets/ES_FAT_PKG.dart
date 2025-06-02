import 'dart:async';
import 'dart:convert';
import 'dart:io';
import '../Setting/models/tax_tbl_lnk.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart';
import 'package:uuid/uuid.dart';
import '../Operation/models/bil_mov_d.dart';
import '../Operation/models/bil_mov_m.dart';
import '../Setting/controllers/login_controller.dart';
import '../Setting/models/bil_cus.dart';
import '../Setting/models/fat_api_inf.dart';
import '../Setting/models/fat_csid_inf.dart';
import '../Setting/models/fat_inv_rs.dart';
import '../Setting/models/fat_inv_snd.dart';
import '../Setting/models/sys_own.dart';
import '../Setting/services/fat_mod.dart';
import '../database/database.dart';
import '../database/invoices_db.dart';
import '../database/setting_db.dart';
import 'config.dart';
import 'package:http/http.dart' as http;

class ES_FAT_PKG {

   //لحفظ بيانات عامه
  static Future  GET_P() async {
    var STP_N=0;
    try {
      STP_N=1;
    //CIID
    GET_GEN_VAR_ACC('CIID').then((data) {
      if (data.isNotEmpty) {
        LoginController().SET_P('CIID',data.elementAt(0).VAL.toString());
      }
    });
      STP_N=2;
    //BRA_TYP_N
    GET_GEN_VAR_ACC('BIID_TYP').then((data) {
      if (data.isNotEmpty) {
        LoginController().SET_P('BIID_ALL',data.elementAt(0).VAL.toString());
      }
    });
      STP_N=3;
    //BIID
    GET_GEN_VAR_ACC('BIID_TYP').then((data) {
      if (data.isNotEmpty) {
        LoginController().SET_P('BIIDL_N',data.elementAt(0).VAL.toString()=='2'?'0':LoginController().BIID.toString());
      }
    });
      STP_N=4;
    //SCHEMA_V
    GET_GEN_VAR_ACC('BIID_TYP').then((data) {
      if (data.isNotEmpty) {
        LoginController().SET_P('SCHEMA_V',data.elementAt(0).VAL.toString()=='2'?'ACC${LoginController().JTID}_0':'ACC${LoginController().JTID}_${LoginController().BIID.toString()}');
      }
    });
      STP_N=5;
    //SOMGU
    GET_GEN_VAR('SOMGU').then((data) {
      if (data.isNotEmpty) {
        LoginController().SET_P('SOMGU',data.elementAt(0).VAL.toString());
      }
    });
      STP_N=6;
    //SCSFL_TX
    GET_SYS_CUR_DATI('1').then((data) {
        if (data.isNotEmpty) {
          LoginController().SET_N_P('SCSFL_TX',data.elementAt(0).SCSFL!);
        }
      });
    //TTID_N
    GET_TTID().then((data) {
      if (data.isNotEmpty) {
        LoginController().SET_N_P('TTID_N',data.elementAt(0).TTID!);
      }else{
        LoginController().SET_N_P('TTID_N',1);
      }
    });


      STP_N=7;
    //USE_VAT_N ---هل سيتخدم ضريبه القيمه المضافه في السعوديه
   var USE_VAT=await GET_USE_VAT(LoginController().TTID_N);
      if (USE_VAT.isNotEmpty) {
        if (USE_VAT.elementAt(0).TTID!=1){
          LoginController().SET_P('USE_VAT_N','2');
          LoginController().SET_N_P('USE_E_INV_N',2);
          LoginController().SET_N_P('USE_FAT_P_N',2);

        }else{
         var USE_VAT2=await GET_USE_VAT2();
            if (USE_VAT2.isNotEmpty) {
              if (USE_VAT2.elementAt(0).SOID==1){
                LoginController().SET_P('USE_VAT_N','1');
              }else{
                LoginController().SET_P('USE_VAT_N','2');
              }
            }

        }
        STP_N=8;
        //USE_E_INV_N ---هل سيتخدم الفوتره الالكترونيه
        await GET_USE_E_INV(LoginController().TTID_N).then((data) {
          if (data.isNotEmpty) {
            LoginController().SET_N_P('USE_E_INV_N',int.parse(data.elementAt(0).TVDVL.toString()));
          }else{
            LoginController().SET_N_P('USE_E_INV_N',2);
          }
        });
        STP_N=9;
        //USE_FAT_P_N---------هل يستخدم الربط مع منصه فاتوره ام لا
       await GET_USE_FAT_P(LoginController().TTID_N,100).then((data) {
          if (data.isNotEmpty) {
            LoginController().SET_N_P('USE_FAT_P_N',int.parse(data.elementAt(0).TVDVL.toString()));
          }else{
            LoginController().SET_N_P('USE_FAT_P_N',2);
          }
        });
        STP_N=10;
        //USE_FAT_P_D ------------تاريخ الربط مع منصه فاتوره
        await GET_USE_FAT_P(LoginController().TTID_N,100).then((data) {
          if (data.isNotEmpty) {
            LoginController().SET_P('USE_FAT_P_D',data.elementAt(0).TVDDA.toString());
          }else{
            LoginController().SET_P('USE_FAT_P_D','null');
          }
        });
        STP_N=11;
        //USE_FAT_S_N------------هل يستخدم المحاكاه ام لا
        await GET_USE_FAT_P(LoginController().TTID_N,104).then((data) {
          if (data.isNotEmpty) {
            LoginController().SET_N_P('USE_FAT_S_N',int.parse(data.elementAt(0).TVDVL.toString()));
          }else{
            LoginController().SET_N_P('USE_FAT_S_N',2);
          }
        });
        STP_N=12;
        //USE_FAT_S_D------------تاريخ الربط مع منصه فاتوره محاكاه
        await GET_USE_FAT_P(LoginController().TTID_N,104).then((data) {
          if (data.isNotEmpty) {
            LoginController().SET_P('USE_FAT_S_D',data.elementAt(0).TVDDA.toString());
          }else{
            LoginController().SET_P('USE_FAT_S_D','null');
          }
        });
        STP_N=13;
        //DAT_TIM_FRM_V---صيغه التاريخ والوقت
        await GET_USE_FAT_P(LoginController().TTID_N,107).then((data) {
          if (data.isNotEmpty) {
           // LoginController().SET_P('DAT_TIM_FRM_V','yyyy-MM-dd HH:mm:ss');
            LoginController().SET_P('DAT_TIM_FRM_V',data.elementAt(0).TVDVL.toString());
          }else{
            LoginController().SET_P('DAT_TIM_FRM_V','yyyy-MM-dd HH:mm:ss');
          }
        });
        STP_N=14;
        //DAT_FRM_V---صيغه التاريخ فقط
        await GET_USE_FAT_P(LoginController().TTID_N,105).then((data) {
          if (data.isNotEmpty) {
          //  LoginController().SET_P('DAT_FRM_V','yyyy-MM-dd');
            LoginController().SET_P('DAT_FRM_V',data.elementAt(0).TVDVL.toString());
          }else{
            LoginController().SET_P('DAT_FRM_V','yyyy-MM-dd');
          }
        });
        STP_N=15;
        //TIM_FRM_V---صيغه الوقت
        await GET_USE_FAT_P(LoginController().TTID_N,105).then((data) {
          if (data.isNotEmpty) {
            LoginController().SET_P('TIM_FRM_V',data.elementAt(0).TVDVL.toString());
          }else{
            LoginController().SET_P('TIM_FRM_V','HH:mm:ss');
          }
        });
        STP_N=16;
        //SIGN_N-----توقيع فقط
        await GET_USE_FAT_P(LoginController().TTID_N,112).then((data) {
          if (data.isNotEmpty) {
            LoginController().SET_P('SIGN_N','2');
          //  LoginController().SET_P('SIGN_N',data.elementAt(0).TVDVL.toString());
          }else{
            LoginController().SET_P('SIGN_N','2');
          }
        });
        STP_N=17;
        //GET_VAR_P الية انشاء معرف ختم تشفير جديد
        await GET_USE_FAT_P(LoginController().TTID_N,111).then((data) {
          if (data.isNotEmpty) {
            LoginController().SET_P('GET_VAR_P',data.elementAt(0).TVDVL.toString());
          }else{
            LoginController().SET_P('GET_VAR_P','');
          }
        });
      }
      else{
        LoginController().SET_P('USE_VAT_N','2');
        LoginController().SET_N_P('USE_E_INV_N',2);
        LoginController().SET_N_P('USE_FAT_P_N',2);
      }
     //INF1
      await GET_FAT_QUE('INF2').then((data) {
        if (data.isNotEmpty) {
          LoginController().SET_P('INF1',data.elementAt(0).FQQU1.toString());
        }else{
          LoginController().SET_P('INF1','');
        }
      });

    print("CIID=${LoginController().CIID}");
    print("BIID_ALL=${LoginController().BIID_ALL}");
    print("BIIDL_N=${LoginController().BIIDL_N}");
    print("SCHEMA_V=${LoginController().SCHEMA_V}");
    print("TTID_N=${LoginController().TTID_N}");
    print("USE_VAT_N=${LoginController().USE_VAT_N}");
    print("USE_E_INV_N=${LoginController().USE_E_INV_N}");
    print("USE_FAT_P_N=${LoginController().USE_FAT_P_N}");
    print("USE_FAT_P_D=${LoginController().USE_FAT_P_D}");
    print("USE_FAT_S_N=${LoginController().USE_FAT_S_N}");
    print("USE_FAT_S_D=${LoginController().USE_FAT_S_D}");
    print("DAT_TIM_FRM_V=${LoginController().DAT_TIM_FRM_V}");
    print("DAT_FRM_V=${LoginController().DAT_FRM_V}");
    print("TIM_FRM_V=${LoginController().TIM_FRM_V}");
    print("SIGN_N=${LoginController().SIGN_N}");
    print("SOMGU=${LoginController().SOMGU}");
    print("INF1=${LoginController().INF1}");
    } catch (e, stackTrace) {
      print('ES_FAT_PKG.GET_P $e $stackTrace');
      Fluttertoast.showToast(
          msg: "$STP_N-ES_FAT_PKG.GET_P-${e.toString()}",
          toastLength: Toast.LENGTH_LONG,
          textColor: Colors.white,
          backgroundColor: Colors.redAccent);
    }
    }

  //الدالة الاساسية التي يتم استدعاءه في الفاتورة
  static Future<bool> MAIN_FAT_SND_INV(BMKID_V,BMMID_V,BIID_V,BMMDO_V,BMMGU_V,BMMST_N,SSID_N,FAT_ST_N,
      CHK_INV_EXIS_N,ST_O_N,MSG_O)
  async {
    var ERR_TYP_N,STP_N=1;
    INV_RE_TYP INV_RE_R=INV_RE_TYP();
    try {
    bool result=false;
    STP_N=1;
    if((BMKID_V!=3 && BMKID_V!=4 && BMKID_V!=11 && BMKID_V!=5 && BMKID_V!=6 && BMKID_V!=12) ||
        (LoginController().USE_VAT_N!='1' && LoginController().USE_FAT_P_N!=1) || (BMMST_N!=4 && BMMST_N!=2 && BMMST_N!=1) ) {
      ST_O_N=10;
      result=false;
      return result;
    }
    STP_N=2;
   var USE_FAT_BIID=await GET_USE_FAT_BIID(LoginController().TTID_N,108,BIID_V);
      if (USE_FAT_BIID.isEmpty) {
        ST_O_N=10;
        result=false;
        return result;
      }
      if (USE_FAT_BIID.elementAt(0).TVDDA.toString().isEmpty){
        ST_O_N=10;
        result=false;
        return result;
      }
      print('BMMDO_V.toString()');
      print(BMMDO_V.toString());
      DateTime dt1 =DateFormat('dd-MM-yyyy').parse(USE_FAT_BIID.elementAt(0).TVDDA.toString());
      DateTime dt2 =DateFormat('dd-MM-yyyy').parse(BMMDO_V.toString());
      print('dt1');
      print(dt1);
      print(dt2);
      print(dt1.compareTo(dt2) > 0);
      if(dt1.compareTo(dt2) > 0){
        print('dt111');
        ST_O_N=10;
        result=false;
        print(result);
        return result;
      }

    STP_N=3;
    configloading();
    if(BIID_V==null || BMMGU_V==null || BMMID_V==null) {
      ST_O_N=5;
      result=false;
      MSG_O='هناك بيانات غير صحيحة ';
     await UPDATE_BIL_MOV_M_BMMQR(TBL_V:BMKID_V == 11 || BMKID_V == 12 ? 'BIF_MOV_M' : 'BIL_MOV_M',
          BMKID:BMKID_V, BMMID:BMMID_V,BMMFS:ST_O_N);
      ADD_CSID_ERR_TO_SND_LOG_P(BMMGU_V,ST_O_N,MSG_O);
      Fluttertoast.showToast(
          msg: "$STP_N-${MSG_O}",
          toastLength: Toast.LENGTH_LONG,
          textColor: Colors.white,
          backgroundColor: Colors.redAccent);
      configloading_ERR();
      return result;
    }
    STP_N=4;
    //جلب ختم التشفير
    var CSID_V = await  GET_CSID_F(BIID_V,STMID,LoginController().SOMGU,LoginController().SUID,BMKID_V,null,null,null,null,null,null,null);
    print('CSID_V: $CSID_V');
    if (CSID_V.toString().isEmpty){
      ST_O_N=5;
      result=false;
      MSG_O='لا يوجد معرف ختم تشفير';
      await UPDATE_BIL_MOV_M_BMMQR(TBL_V:BMKID_V == 11 || BMKID_V == 12 ? 'BIF_MOV_M' : 'BIL_MOV_M',
          BMKID:BMKID_V, BMMID:BMMID_V,BMMFS:ST_O_N);
      ADD_CSID_ERR_TO_SND_LOG_P(BMMGU_V,ST_O_N,MSG_O);
      Fluttertoast.showToast(
          msg: "$STP_N-${MSG_O}",
          toastLength: Toast.LENGTH_LONG,
          textColor: Colors.white,
          backgroundColor: Colors.redAccent);
      configloading_ERR();
      return result;
    }
    else if(CSID_V.toString().indexOf('<ES_FAT_PKG.GET_CSID_F>')>=0){
      ST_O_N=5;
      result=false;
      MSG_O=CSID_V.toString();
      await UPDATE_BIL_MOV_M_BMMQR(TBL_V:BMKID_V == 11 || BMKID_V == 12 ? 'BIF_MOV_M' : 'BIL_MOV_M',
          BMKID:BMKID_V, BMMID:BMMID_V,BMMFS:ST_O_N);
      ADD_CSID_ERR_TO_SND_LOG_P(BMMGU_V,ST_O_N,MSG_O);
      Fluttertoast.showToast(
          msg: "$STP_N-${MSG_O}",
          toastLength: Toast.LENGTH_LONG,
          textColor: Colors.white,
          backgroundColor: Colors.redAccent);
      configloading_ERR();
    }
    STP_N=5;

    //الحالة السابقة الفاتورة
    // if(FAT_ST_N==null || FAT_ST_N==10){
    //   FAT_ST_N=5;
    //   ST_O_N=5;
    //   result=false;
    //   MSG_O='تأكد من الحالة السابقة للفاتورة';
    //   UPDATE_BIL_MOV_M_BMMQR(TBL_V:BMKID_V == 11 || BMKID_V == 12 ? 'BIF_MOV_M' : 'BIL_MOV_M',
    //       BMKID:BMKID_V, BMMID:BMMID_V,BMMFS:ST_O_N);
    //   ADD_CSID_ERR_TO_SND_LOG_P(BMMGU_V,ST_O_N,MSG_O);
    //   Fluttertoast.showToast(
    //       msg: "$STP_N-${MSG_O}",
    //       toastLength: Toast.LENGTH_LONG,
    //       textColor: Colors.white,
    //       backgroundColor: Colors.redAccent);
    //   return result;
    // }
    STP_N=6;
    if(FAT_ST_N==1){
      ST_O_N=1;
      result=true;
      return result;
    }
    STP_N=7;

    (ST_O_N,ERR_TYP_N,MSG_O)=await SND_INV_P(int.parse(LoginController().SIGN_N),BMKID_V,
        BMMID_V,CSID_V,STMID,SSID_N,FAT_ST_N);
    print(ST_O_N);
    print(ERR_TYP_N);
    print(MSG_O);
    if(ST_O_N==2){
      Fluttertoast.showToast(
          msg: "$STP_N-${MSG_O}",
          toastLength: Toast.LENGTH_LONG,
          textColor: Colors.white,
          backgroundColor: Colors.redAccent);
      configloading_ERR();
      result=false;
      return result;
    }else{
      configloading_SUCC();
    }
    print('FAT_SND_INV');
    result=true;
    return result;
    } catch (e, stackTrace) {
      print('ES_FAT_PKG.FAT_SND_INV $e $stackTrace');
      ST_O_N=5;
      ERR_TYP_N=3;
      MSG_O="ES_FAT_PKG.FAT_SND_INV $e";
      await UPDATE_BIL_MOV_M_BMMQR(TBL_V:BMKID_V == 11 || BMKID_V == 12 ? 'BIF_MOV_M' : 'BIL_MOV_M',
          BMKID:BMKID_V, BMMID:BMMID_V,BMMFS:ST_O_N);
      ADD_CSID_ERR_TO_SND_LOG_P(BMMGU_V,ST_O_N,MSG_O);
      Fluttertoast.showToast(
          msg: "$STP_N-${MSG_O}-${e.toString()}",
          toastLength: Toast.LENGTH_LONG,
          textColor: Colors.white,
          backgroundColor: Colors.redAccent);
      configloading_ERR();
      return false;
    }
    }

  // لارجاع رقم GUID لختم التشفير
  static Future<String> GET_CSID_F(P_BIIDV_V,P_STMIDV_V,P_SOMGUV_V,P_SUIDV_V,P_BMKIDV_V,P_FCIBTV_V,P_JOBS_N,P_AF1_V,P_AF2_V,
      P_AF3_V,P_AF4_V,P_AF5_V)
  async {
    var STP_N=1;
    try {
    String RES='';
    STP_N=1;
    int BIID_N = LoginController().GET_VAR_P.toString().indexOf('<BIID>');
    if (BIID_N == -1) {
      P_BIIDV_V=null;
    }
    STP_N=2;
    int STMID_N = LoginController().GET_VAR_P.toString().indexOf('<STMID>');
    if (STMID_N == -1) {
      P_STMIDV_V=null;
    }
    STP_N=3;
    int SOMGU_N = LoginController().GET_VAR_P.toString().indexOf('<SOMGU>');
    if (SOMGU_N == -1) {
      P_SOMGUV_V=null;
    }
    STP_N=4;
    int SUID_N = LoginController().GET_VAR_P.toString().indexOf('<SUID>');
    if (SUID_N == -1) {
      P_SUIDV_V=null;
    }
    STP_N=5;
    int BMKID_N = LoginController().GET_VAR_P.toString().indexOf('<BMKID>');
    if (BMKID_N == -1) {
      P_BMKIDV_V=null;
    }
    STP_N=6;
    var data = await GET_CSID(P_BIIDV_V,P_STMIDV_V,P_SOMGUV_V,P_SUIDV_V,P_BMKIDV_V,P_FCIBTV_V,P_AF1_V,P_AF2_V,
        P_AF3_V,P_AF4_V,P_AF5_V);
      if (data.isNotEmpty) {
        RES=data.elementAt(0).FCIGU.toString();
      }

    return  RES;
    } catch (e, stackTrace) {
      print('ES_FAT_PKG.GET_CSID_F $e $stackTrace');
      Fluttertoast.showToast(
          msg: "$STP_N-ES_FAT_PKG.GET_CSID_F-${e.toString()}",
          toastLength: Toast.LENGTH_LONG,
          textColor: Colors.white,
          backgroundColor: Colors.redAccent);
      return "ES_FAT_PKG.GET_CSID_F $e";
    }
  }

  //-لاضافه الاخطاء الى الLOG وذلك في حال عدم وجود بيانات ختم التشفير قبل ارسال الفاتوره
  //الداله ستقوم باضافه الخطا الى جدول FAT_SND_LOG وكذلك اضافه الفاتوره الى جدةل الجوبز لاعاده ارسالها اليا
  static Future ADD_CSID_ERR_TO_SND_LOG_P(BMMGU,P_FISST_N,P_MSG_V) async {
    try {
    var uuid = const Uuid();
    INSERT_FAT_SND_LOG(BMMGU:BMMGU,MSG_ERR:P_MSG_V,FISST_N:P_FISST_N);
    } catch (e, stackTrace) {
      print('ES_FAT_PKG.ADD_CSID_ERR_TO_SND_LOG_P $e $stackTrace');
      Fluttertoast.showToast(
          msg: "ES_FAT_PKG.ADD_CSID_ERR_TO_SND_LOG_P-${e.toString()}",
          toastLength: Toast.LENGTH_LONG,
          textColor: Colors.white,
          backgroundColor: Colors.redAccent);
      return false; // ترجع false في حال حدوث خطأ
    }
    }

  //جلب نوع الضريبة
  static Future<String?> GET_TAX_TYP(TTLID) async {
    var STP_N=1;
    try {
     String TTLSYM='';
     STP_N=1;
    // if(BCTX_V.toString().isNotEmpty && BCTX_V.toString()!='null' ){
    //   if(BMKID_N==3 || BMKID_N==5 || BMKID_N==11 ){
    //     TTLID='1';
    //   }else if (BMKID_N==4 || BMKID_N==6 || BMKID_N==12 ){
    //     TTLID='3';
    //   }
    // }
    // else{
    //   if(BMKID_N==3 || BMKID_N==5 || BMKID_N==11 ){
    //     TTLID='2';
    //   }
    //   else if (BMKID_N==4 || BMKID_N==6 || BMKID_N==12 ){
    //     TTLID='4';
    //   }
    // }
    var data= await GET_TAX_TBL_LNK(TTLID);
    if(data.isNotEmpty){
      TTLSYM=data.elementAt(0).TTLSYM.toString();
    }
    return TTLSYM;
    } catch (e, stackTrace) {
      print('ES_FAT_PKG.GET_TAX_TYP:$e $stackTrace');
      return null; // ترجع false في حال حدوث خطأ
    }
  }

  //SEND INV لارسال فاتوره لمنصه فاتوره
  static Future<dynamic> SND_INV_P(SIGN_N,BMKID_N,BMMID_N,FCIGU_V,STMID_V,SSID_N,FAT_ST_N) async {
    var FAT_CSID_INF,IS_EXI_N=2, BCTX_V='',ST_O_N=2,ERR_TYP_N=3,MSG_O_V='ERROR',FISPIN_N,ICV_N,PIH_V,FISPGU_V,
        BIL_CUS,BIL_MOV_M,BIL_MOV_D,SYS_OWN,STP_N=1,FISST_N=FAT_ST_N,FISSI_N=2,FISWE_N=2,FISEE_N=2,FISSEQ_N,
        FISST_OLD_N,FISSTO_OLD_N,FISSTO_N,UUID_V,FISSIO_N,FISZHSO_N,FISNS_N=0,FISGU,FISST_N2,FISINO_V;
    int SIGN_FLAG_N=SIGN_N,FISXE_N=2;
    API_TYP API_R=API_TYP(TYP_V: 'P',PRO_TYP_V: 'SND_JSON');
    INV_RE_TYP INV_RE_R=INV_RE_TYP();
   try {

     STP_N=1;
   //اذا كان حاله الفاتورة السابقة اعادة ارسال
   if (FAT_ST_N==2 || FAT_ST_N==4){
     IS_EXI_N=1;
    }
     STP_N=2;
   // اذا كان حالة 4 او موقعة تجتاج ارسال فقط
   if (FAT_ST_N==4 && SIGN_N==1){
     SIGN_FLAG_N=2;
   }

     print('SIGN_FLAG_N1');
     print(SIGN_FLAG_N);

     STP_N=3;
   //جلب بيانات الفاتورة الرئيسي
   BIL_MOV_M=await GET_BIL_MOV_M_PRINT(BMKID_N == 11 || BMKID_N == 12 ? 'BIF_MOV_M' : 'BIL_MOV_M', BMMID_N.toString());
   if(BIL_MOV_M.isEmpty){
     ST_O_N=2;
     ERR_TYP_N=3;
     MSG_O_V='يجب التاكد من البيانات الرئيسيه';
     await UPDATE_BIL_MOV_M_BMMQR(TBL_V:BIL_MOV_M[0].BMKID == 11 || BIL_MOV_M[0].BMKID == 12 ? 'BIF_MOV_M' : 'BIL_MOV_M',
         BMKID:BIL_MOV_M[0].BMKID, BMMID:BIL_MOV_M[0].BMMID,BMMFS:5);
     return (ST_O_N,ERR_TYP_N,MSG_O_V);
   }
     STP_N=4;
   //جلب بيانات الفاتورة الفرعي
    BIL_MOV_D=await GET_BIL_MOV_D_TX(BMKID_N == 11 || BMKID_N == 12 ? 'BIF_MOV_D' : 'BIL_MOV_D',
        BMMID_N.toString(),LoginController().SCSFL_TX);
   if(BIL_MOV_D.isEmpty){
     ST_O_N=2;
     ERR_TYP_N=3;
     MSG_O_V='يجب التاكد من البيانات الفرعي';
     await UPDATE_BIL_MOV_M_BMMQR(TBL_V:BIL_MOV_M[0].BMKID == 11 || BIL_MOV_M[0].BMKID == 12 ? 'BIF_MOV_M' : 'BIL_MOV_M',
         BMKID:BIL_MOV_M[0].BMKID, BMMID:BIL_MOV_M[0].BMMID,BMMFS:5);
     return (ST_O_N,ERR_TYP_N,MSG_O_V);
   }
     STP_N=5;
   //جلب بيانات المنشاة
   SYS_OWN=await  GET_SYS_OWN(BMKID_N == 11 || BMKID_N == 12?BIL_MOV_M.elementAt(0).BIID!:BIL_MOV_M.elementAt(0).BIID2!);
   if(SYS_OWN.isEmpty){
     ST_O_N=2;
     ERR_TYP_N=3;
     MSG_O_V='يجب التاكد من بيانات المنشاة';
     await UPDATE_BIL_MOV_M_BMMQR(TBL_V:BIL_MOV_M[0].BMKID == 11 || BIL_MOV_M[0].BMKID == 12 ? 'BIF_MOV_M' : 'BIL_MOV_M',
         BMKID:BIL_MOV_M[0].BMKID, BMMID:BIL_MOV_M[0].BMMID,BMMFS:5);
     return (ST_O_N,ERR_TYP_N,MSG_O_V);
   }


     if (isVatNumberValid(SYS_OWN[0].SOTX.toString())) {
       print('رقم VAT صالح');
     }
     else {
       ST_O_N=2;
       ERR_TYP_N=3;
       MSG_O_V='الرقم الضريبيي للمنشأه غير صحيح';
       await  UPDATE_BIL_MOV_M_BMMQR(TBL_V:BIL_MOV_M[0].BMKID == 11 || BIL_MOV_M[0].BMKID == 12 ? 'BIF_MOV_M' : 'BIL_MOV_M',
           BMKID:BIL_MOV_M[0].BMKID, BMMID:BIL_MOV_M[0].BMMID,BMMFS:5);
       return (ST_O_N,ERR_TYP_N,MSG_O_V);
     }

     STP_N=6;
   //جلب العميل والتاكد من انه موجود
   var TTLID=  BIL_MOV_M.elementAt(0).TTLID;
   var BCID_V=TTLID==1 || TTLID==3 || TTLID==5? BIL_MOV_M.elementAt(0).BCID.toString():'null';
   print('BCID_V');
   print(BCID_V);
   if((BCID_V.toString()!='null')){
     //جلب بيانات العميل
     BIL_CUS=await GET_BIL_CUS_INF(BCID_V);
    var TAX_LIN_CUS=await GET_TAX_LIN(BMKID_N,LoginController().TTID_N.toString(),'CUS',BIL_MOV_M.elementAt(0).AANO,BCID_V.toString());
     print(BIL_CUS.elementAt(0).BCNA);
     if(TAX_LIN_CUS.isNotEmpty){
       BCTX_V=TAX_LIN_CUS.elementAt(0).TLTN.toString();
       if (isVatNumberValid(BCTX_V.toString())) {
         print('رقم VAT صالح');
       } else {
         ST_O_N=2;
         ERR_TYP_N=3;
         MSG_O_V='الرقم الضريبيي للعميل غير صحيح';
         await  UPDATE_BIL_MOV_M_BMMQR(TBL_V:BIL_MOV_M[0].BMKID == 11 || BIL_MOV_M[0].BMKID == 12 ? 'BIF_MOV_M' : 'BIL_MOV_M',
             BMKID:BIL_MOV_M[0].BMKID, BMMID:BIL_MOV_M[0].BMMID,BMMFS:5);
         return (ST_O_N,ERR_TYP_N,MSG_O_V);
       }
     }else{
       ST_O_N=2;
       ERR_TYP_N=3;
       MSG_O_V='يجب التاكد من  بيانات الضريبة والعملاء';
       await  UPDATE_BIL_MOV_M_BMMQR(TBL_V:BIL_MOV_M[0].BMKID == 11 || BIL_MOV_M[0].BMKID == 12 ? 'BIF_MOV_M' : 'BIL_MOV_M',
           BMKID:BIL_MOV_M[0].BMKID, BMMID:BIL_MOV_M[0].BMMID,BMMFS:5);
       return (ST_O_N,ERR_TYP_N,MSG_O_V);
     }
   }

     FISINO_V=BIL_MOV_M[0].BMMNO.toString();
    // FISINO_V= GEN_INV_NO_F(stId:[11,12].contains(BIL_MOV_M[0].BMKID)?'BF':'BO',biId:BIL_MOV_M[0].BIID2
    // ,bmKId:  BIL_MOV_M[0].BMKID,bmMId: BIL_MOV_M[0].BMMID,bmMNo:BIL_MOV_M[0].BMMNO
    // ,syId:  LoginController().SYID);
     print(FISINO_V);
     print('GEN_INV_NO_F');

     STP_N=7;
   //جلب نوع الضريبة
   var TAX_TYP=  await GET_TAX_TYP(TTLID);
   API_R.TAX_TYP=TAX_TYP;

     print(TAX_TYP);
     print(SIGN_FLAG_N);
     print((TAX_TYP=='TAX_INVOICE' || TAX_TYP=='CREDIT_NOTE' || TAX_TYP=='DEBIT_NOTE'));
     print((SIGN_FLAG_N==1));
     print((TAX_TYP=='TAX_INVOICE' || TAX_TYP=='CREDIT_NOTE' || TAX_TYP=='DEBIT_NOTE') && (SIGN_FLAG_N==1));

     STP_N=8;
   if ((TAX_TYP=='TAX_INVOICE' || TAX_TYP=='CREDIT_NOTE' || TAX_TYP=='DEBIT_NOTE') && (SIGN_FLAG_N==1)){
     SIGN_FLAG_N=2;
   }

     print('SIGN_FLAG_N2');
     print(SIGN_FLAG_N);

     STP_N=9;
   //اذا كان موجود يتم فقط اعادة ارسال
   if(IS_EXI_N==1){
     var FAT_INV_SND=await GET_FAT_INV_SND(null,BIL_MOV_M.elementAt(0).GUID,FAT_ST_N);
     if(FAT_INV_SND.isNotEmpty){
       FISPIN_N=FAT_INV_SND.elementAt(0).FISPIN;
       ICV_N=FAT_INV_SND.elementAt(0).FISICV;
       PIH_V=FAT_INV_SND.elementAt(0).FISPIH;
       FISPGU_V=FAT_INV_SND.elementAt(0).FISPGU;
       FISSI_N=FAT_INV_SND.elementAt(0).FISSI!;
       FISSEQ_N=FAT_INV_SND.elementAt(0).FISSEQ!;
       FISST_OLD_N=FAT_INV_SND.elementAt(0).FISST!;
       FISSTO_OLD_N=FAT_INV_SND.elementAt(0).FISSTO!;
       UUID_V=FAT_INV_SND.elementAt(0).UUID;
       FISSIO_N=FAT_INV_SND.elementAt(0).FISSI;
       FISZHSO_N=FAT_INV_SND.elementAt(0).FISZHS;
       FISNS_N=FAT_INV_SND.elementAt(0).FISNS!;
       FISGU=FAT_INV_SND.elementAt(0).FISGU!;
       FISGU=FAT_INV_SND.elementAt(0).FISGU!;
       FISINO_V=FAT_INV_SND.elementAt(0).FISINO.toString();
       // API_R.REQ_DAT_C=FAT_INV_SND.elementAt(0).FISREQ;
       // if(FAT_INV_SND.elementAt(0).FISREQ.toString().isNotEmpty){
       //   API_R.PRO_TYP_V='SND';
       // }
     }else{
       IS_EXI_N=2;
     }
   }

     STP_N=10;
   //جلب اخر رقم و الهاش السابق
   if(IS_EXI_N!=1){
     var FAT_CSID_SEQ=await GET_FAT_CSID_SEQ(FCIGU_V);
     if(FAT_CSID_SEQ.isNotEmpty){
       print('FCSNO1111');
       print(FAT_CSID_SEQ.elementAt(0).FCSNO);
       FISPIN_N=FAT_CSID_SEQ.elementAt(0).FISSEQ;
       ICV_N=FAT_CSID_SEQ.elementAt(0).FCSNO!+1;
       PIH_V=FAT_CSID_SEQ.elementAt(0).FCSHA;
       FISPGU_V=FAT_CSID_SEQ.elementAt(0).FISGU;
       FISGU=Uuid().v4();
       UUID_V=Uuid().v4();
     }
   }
     API_R.UUID_V=UUID_V;
     API_R.FISINO_V=FISINO_V;

     STP_N=10;
     print('ICV_N');
     print(ICV_N);
     print(PIH_V);
   //التاكد من ان الهاش و التسلسل مش فاضي
   if(ICV_N==null || PIH_V==null){
     ST_O_N=2;
     ERR_TYP_N=3;
     MSG_O_V='خطأ في بيانات الهاش و التسلسل';
     await UPDATE_BIL_MOV_M_BMMQR(TBL_V:BIL_MOV_M[0].BMKID == 11 || BIL_MOV_M[0].BMKID == 12 ? 'BIF_MOV_M' : 'BIL_MOV_M',
         BMKID:BIL_MOV_M[0].BMKID, BMMID:BIL_MOV_M[0].BMMID,BMMFS:5);
     return (ST_O_N,ERR_TYP_N,MSG_O_V);
   }

   API_R.ICV_N=ICV_N;
   API_R.PIH_V=PIH_V;

     STP_N=11;
   //جلب بيانات ختم التشفير
    FAT_CSID_INF=await CSID_DAT_F(FCIGU_V);
   if(FAT_CSID_INF.isEmpty){
     ST_O_N=2;
     ERR_TYP_N=3;
     MSG_O_V='يجب التاكد من بيانات ختم التشفير';
     await  UPDATE_BIL_MOV_M_BMMQR(TBL_V:BIL_MOV_M[0].BMKID == 11 || BIL_MOV_M[0].BMKID == 12 ? 'BIF_MOV_M' : 'BIL_MOV_M',
         BMKID:BIL_MOV_M[0].BMKID, BMMID:BIL_MOV_M[0].BMMID,BMMFS:5);
     return (ST_O_N,ERR_TYP_N,MSG_O_V);
   }

     STP_N=12;

     print('SIGN_FLAG_N3');
     print(SIGN_FLAG_N);

    if (SIGN_FLAG_N!=1){
      API_R.SUBSI_V='SUBMIT';
    }
    else{
      API_R.SUBSI_V='SIGN';
    }

     print('SIGN_FLAG_N4');
     print(API_R.SUBSI_V);

     STP_N=13;


    //دالة ارسل json
    INV_RE_R= await GEN_JS_AND_SND(API_R,BIL_CUS ?? [],BIL_MOV_M,SYS_OWN,BIL_MOV_D,FAT_CSID_INF);

     if(INV_RE_R.ERR_TYP_N.toString().isNotEmpty && (INV_RE_R.ERR_TYP_N==4)){
       ST_O_N=2;
       ERR_TYP_N=INV_RE_R.ERR_TYP_N;
       MSG_O_V=INV_RE_R.ERR_V;
       await UPDATE_BIL_MOV_M_BMMQR(TBL_V:BIL_MOV_M[0].BMKID == 11 || BIL_MOV_M[0].BMKID == 12 ? 'BIF_MOV_M' : 'BIL_MOV_M',
           BMKID:BIL_MOV_M[0].BMKID, BMMID:BIL_MOV_M[0].BMMID,BMMFS:5,
           BMMFIC: API_R.ICV_N,BMMFUU:API_R.UUID_V,BMMFNO: API_R.FISINO_V,
           BMMQR:INV_RE_R.INV_QR_V);
       INSERT_FAT_SND_LOG(BMMGU:BIL_MOV_M[0].GUID,FCIGU:FAT_CSID_INF[0].FCIGU,FSLSIG:SIGN_FLAG_N,
           FSLCIE:IS_EXI_N,FSLSTP:STP_N,FSLST:ST_O_N,FSLRT:ERR_TYP_N,MSG_ERR:MSG_O_V,
           FISST_N:5,SSID_N:LoginController().SSID_N,FSLDRQ:INV_RE_R.REQ_DAT_C.toString(),
           FSLDER:INV_RE_R.ERR_V.toString() ,FSLDRC:INV_RE_R.RES_COD_V.toString() ,FSLDRS:INV_RE_R.RES_DAT_C.toString() );
       return (ST_O_N,ERR_TYP_N,MSG_O_V);
     }

     if( INV_RE_R.REQ_DAT_C.toString().isEmpty  && INV_RE_R.JSON_C.toString().isEmpty &&
         INV_RE_R.ERR_V.toString().isEmpty  && INV_RE_R.RES_COD_V.toString().isEmpty ){
       ST_O_N=2;
       ERR_TYP_N=3;
       MSG_O_V='الداله لم ترجع اي بيانات NO_DATA RETURN FROM ES_FAT_PKG.GEN_JS_AND_SND';
       await  UPDATE_BIL_MOV_M_BMMQR(TBL_V:BIL_MOV_M[0].BMKID == 11 || BIL_MOV_M[0].BMKID == 12 ? 'BIF_MOV_M' : 'BIL_MOV_M',
           BMKID:BIL_MOV_M[0].BMKID, BMMID:BIL_MOV_M[0].BMMID,BMMFS:5,
       BMMFIC: API_R.ICV_N,BMMFUU:API_R.UUID_V,BMMFNO: API_R.FISINO_V,
           BMMQR:INV_RE_R.INV_QR_V);
       INSERT_FAT_SND_LOG(BMMGU:BIL_MOV_M[0].GUID,FCIGU:FAT_CSID_INF[0].FCIGU,FSLSIG:SIGN_FLAG_N,
           FSLCIE:IS_EXI_N,FSLSTP:STP_N,FSLST:ST_O_N,FSLRT:ERR_TYP_N,MSG_ERR:MSG_O_V,
           FISST_N:5,SSID_N:LoginController().SSID_N,FSLDRQ:INV_RE_R.REQ_DAT_C.toString(),
           FSLDER:INV_RE_R.ERR_V.toString() ,FSLDRC:INV_RE_R.RES_COD_V.toString() ,FSLDRS:INV_RE_R.RES_DAT_C.toString() );
       return (ST_O_N,ERR_TYP_N,MSG_O_V);
     }

     if( INV_RE_R.ERR_V.toString().isNotEmpty  && (INV_RE_R.RES_COD_V.toString().isEmpty ||
         INV_RE_R.INV_HASH_V.toString().isEmpty)  ){
       ST_O_N=2;
       ERR_TYP_N=INV_RE_R.ERR_TYP_N;
       MSG_O_V=INV_RE_R.ERR_V;
       await UPDATE_BIL_MOV_M_BMMQR(TBL_V:BIL_MOV_M[0].BMKID == 11 || BIL_MOV_M[0].BMKID == 12 ? 'BIF_MOV_M' : 'BIL_MOV_M',
           BMKID:BIL_MOV_M[0].BMKID, BMMID:BIL_MOV_M[0].BMMID,BMMFS:5,
       BMMFIC: API_R.ICV_N,BMMFUU:API_R.UUID_V,BMMFNO: API_R.FISINO_V,
           BMMQR:INV_RE_R.INV_QR_V);
       INSERT_FAT_SND_LOG(BMMGU:BIL_MOV_M[0].GUID,FCIGU:FAT_CSID_INF[0].FCIGU,FSLSIG:SIGN_FLAG_N,
           FSLCIE:IS_EXI_N,FSLSTP:STP_N,FSLST:ST_O_N,FSLRT:ERR_TYP_N,MSG_ERR:MSG_O_V,
           FISST_N:5,SSID_N:LoginController().SSID_N,FSLDRQ:INV_RE_R.REQ_DAT_C.toString(),
           FSLDER:INV_RE_R.ERR_V.toString() ,FSLDRC:INV_RE_R.RES_COD_V.toString() ,FSLDRS:INV_RE_R.RES_DAT_C.toString());
       return (ST_O_N,ERR_TYP_N,MSG_O_V);
     }

     if( INV_RE_R.RES_DAT_C.toString().isEmpty  && (INV_RE_R.RES_COD_V.toString().isEmpty ||
         INV_RE_R.RES_COD_V.toString().substring(1,1) !='2')  ){
       ST_O_N=2;
       ERR_TYP_N=2;
       MSG_O_V="DESTINATION SERVER IS DOWN NO_DATA RETURN =>RESPONSE CODE =>"+' '+INV_RE_R.RES_COD_V.toString();
       await UPDATE_BIL_MOV_M_BMMQR(TBL_V:BIL_MOV_M[0].BMKID == 11 || BIL_MOV_M[0].BMKID == 12 ? 'BIF_MOV_M' : 'BIL_MOV_M',
           BMKID:BIL_MOV_M[0].BMKID, BMMID:BIL_MOV_M[0].BMMID,BMMFS:5,
       BMMFIC: API_R.ICV_N,BMMFUU:API_R.UUID_V,BMMFNO: API_R.FISINO_V,
           BMMQR:INV_RE_R.INV_QR_V);
       INSERT_FAT_SND_LOG(BMMGU:BIL_MOV_M[0].GUID,FCIGU:FAT_CSID_INF[0].FCIGU,FSLSIG:SIGN_FLAG_N,
           FSLCIE:IS_EXI_N,FSLSTP:STP_N,FSLST:ST_O_N,FSLRT:ERR_TYP_N,MSG_ERR:MSG_O_V,
           FISST_N:5,SSID_N:LoginController().SSID_N,FSLDRQ:INV_RE_R.REQ_DAT_C.toString(),
           FSLDER:INV_RE_R.ERR_V.toString() ,FSLDRC:INV_RE_R.RES_COD_V.toString() ,FSLDRS:INV_RE_R.RES_DAT_C.toString());
       return (ST_O_N,ERR_TYP_N,MSG_O_V);
     }

     if( (INV_RE_R.ZATHTTPST_N.toString().isNotEmpty)  || (INV_RE_R.ZATHTTPST_N.toString().isEmpty &&
         SIGN_FLAG_N==1)  ){
       ST_O_N=2;
       ERR_TYP_N=2;
       FISST_N=await HTTP_ST_F(P_SIGN_N:SIGN_FLAG_N,P_HTTP_V:INV_RE_R.ZATHTTPST_N.toString() ?? INV_RE_R.RES_COD_V.toString());
       print('FISST_N');
       print(FISST_N);

     }

     if (FISST_N==5){
       ST_O_N=2;
       ERR_TYP_N=2;
       print('ZATHTTPST_N');
       print(INV_RE_R.ZATHTTPST_N);
       if(INV_RE_R.ZATHTTPST_N=='409'){
         STP_N=60;
         String  msgErr=await GET_MSG_F(423,P_LAN_N: 1).toString();
         String MSG_O_V_2 = [
           msgErr.toString(),
           STP_N.toString(),
           'الفاتوره كبيره جدا يجب اعاده تقسيمها ',
           INV_RE_R.ZATHTTPST_N.toString()=='null'?'':INV_RE_R.ZATHTTPST_N.toString(),
           INV_RE_R.RES_COD_V.toString()=='null'?'':INV_RE_R.RES_COD_V.toString(),
         ].join(' ');
         MSG_O_V=MSG_O_V_2.length>400?MSG_O_V_2.toString().substring(1,400):MSG_O_V_2.toString();
       }else{
         STP_N=61;
       String  msgErr=await GET_MSG_F(423,P_LAN_N: 1).toString();
         String MSG_O_V_1 = [
           msgErr,
           STP_N.toString(),
           INV_RE_R.ERR_V.toString()=='null'?'':INV_RE_R.ERR_V.toString(),
           INV_RE_R.INV_ERR_C.toString()=='null'?'':INV_RE_R.INV_ERR_C.toString(),
           INV_RE_R.INV_WAR_C.toString()=='null'?'':INV_RE_R.INV_WAR_C.toString(),
           '=> RESPONSE CODE =>',
           INV_RE_R.ZATHTTPST_N.toString()=='null'?'':INV_RE_R.ZATHTTPST_N.toString(),
           INV_RE_R.RES_COD_V.toString(),
         ].join(' ');
       print('MSG_O_V_1');
       print(STP_N);
       print(INV_RE_R.ERR_V);
       print(MSG_O_V_1);
       MSG_O_V=MSG_O_V_1.length>400?MSG_O_V_1.substring(1,400):MSG_O_V_1;
       }
       await UPDATE_BIL_MOV_M_BMMQR(TBL_V:BIL_MOV_M[0].BMKID == 11 || BIL_MOV_M[0].BMKID == 12 ? 'BIF_MOV_M' : 'BIL_MOV_M',
           BMKID:BIL_MOV_M[0].BMKID, BMMID:BIL_MOV_M[0].BMMID,BMMFS:FISST_N,
       BMMFIC: API_R.ICV_N,BMMFUU:API_R.UUID_V,BMMFNO: API_R.FISINO_V,
           BMMQR:INV_RE_R.INV_QR_V);
       INSERT_FAT_SND_LOG(BMMGU:BIL_MOV_M[0].GUID,FCIGU:FAT_CSID_INF[0].FCIGU,FSLSIG:SIGN_FLAG_N,
           FSLCIE:IS_EXI_N,FSLSTP:STP_N,FSLST:ST_O_N,FSLRT:ERR_TYP_N,MSG_ERR:MSG_O_V,
           FISST_N:FISST_N,SSID_N:LoginController().SSID_N,FSLDRQ:INV_RE_R.REQ_DAT_C.toString(),
           FSLDER:INV_RE_R.ERR_V.toString() ,FSLDRC:INV_RE_R.RES_COD_V.toString() ,FSLDRS:INV_RE_R.RES_DAT_C.toString());
       return (ST_O_N,ERR_TYP_N,MSG_O_V);

     }

     if( SIGN_FLAG_N==1) {
      FISSI_N=1;
     }else{
       FISSI_N=FISSI_N ?? 2;
     }


     if( INV_RE_R.INV_WAR_C.toString()!='null') {
       FISWE_N=1;
     }
     if( INV_RE_R.INV_ERR_C.toString()!='null') {
       FISEE_N=1;
     }

     INV_RE_R.INV_INF_V=processInvInf(INV_RE_R.INV_INF_V.toString(),LoginController().INF1.toString());


     if( INV_RE_R.INV_XML_C.toString()!='null') {
       FISXE_N=1;
     }

     if(IS_EXI_N==1 && FISSEQ_N.toString().isNotEmpty){
       if(FISST_OLD_N==3 || FISSTO_OLD_N==3){
         FISSTO_N=3;
       }else{
         FISSTO_N=FISST_OLD_N ?? FISSTO_OLD_N;
       }

       try{
         print('UPDATE_FAT_INV_SND');
         UPDATE_FAT_INV_SND(FCIGU:FAT_CSID_INF[0].FCIGU,
             UUID:UUID_V,FISST:FISST_N,FISSTO:FISSTO_N,FISSI:FISSI_N ?? FISSIO_N,FISICV:API_R.ICV_N,
             FISPIN:FISPIN_N,FISPIH:API_R.PIH_V,FISIH:INV_RE_R.INV_HASH_V,FISQR:INV_RE_R.INV_QR_V,
             FISZHS:INV_RE_R.ZATHTTPST_N,FISZHSO:FISZHSO_N ?? INV_RE_R.ZATHTTPST_N,FISZS:INV_RE_R.PZATST_V,
             FISIS:INV_RE_R.INV_STATUS_V,FISINF:INV_RE_R.INV_INF_V,FISWE:FISWE_N,
             FISEE:FISEE_N,FISXML:INV_RE_R.INV_XML_C,
             FISTOT:INV_RE_R.INV_TOTAMO_N, FISSUM:INV_RE_R.INV_LINAMO_N,
             FISTWV:INV_RE_R.INV_TOTWVAT_N, FISNS:FISNS_N+1,FISSEQ_N:FISSEQ_N,FISXE:FISXE_N,
             FISINO: FISINO_V);
       }catch(e){
        ST_O_N=2;
        ERR_TYP_N=3;
         MSG_O_V =(await GET_MSG_F(423,P_LAN_N: 1)! +''+ STP_N.toString() +'ERROR UPDATE FAT_INV_SND TABLE =>' + '' + e.toString()).toString();
        await  UPDATE_BIL_MOV_M_BMMQR(TBL_V:BIL_MOV_M[0].BMKID == 11 || BIL_MOV_M[0].BMKID == 12 ? 'BIF_MOV_M' : 'BIL_MOV_M',
            BMKID:BIL_MOV_M[0].BMKID, BMMID:BIL_MOV_M[0].BMMID,BMMFS:5,
        BMMFIC: API_R.ICV_N,BMMFUU:API_R.UUID_V,BMMFNO: API_R.FISINO_V,
           BMMQR:INV_RE_R.INV_QR_V);
         INSERT_FAT_SND_LOG(BMMGU:BIL_MOV_M[0].GUID,FCIGU:FAT_CSID_INF[0].FCIGU,FSLSIG:SIGN_FLAG_N,
            FSLCIE:IS_EXI_N,FSLSTP:STP_N,FSLST:ST_O_N,FSLRT:ERR_TYP_N,MSG_ERR:MSG_O_V,
            FISST_N:5,SSID_N:LoginController().SSID_N,FSLDRQ:INV_RE_R.REQ_DAT_C.toString(),
            FSLDER:INV_RE_R.ERR_V.toString() ,FSLDRC:INV_RE_R.RES_COD_V.toString() ,FSLDRS:INV_RE_R.RES_DAT_C.toString());
         return (ST_O_N,ERR_TYP_N,MSG_O_V);
       }
       }else{

       try{
         print('SAVE_FAT_INV_SND');
         print(INV_RE_R.INV_INF_V);
       Fat_Inv_Snd_Local FAT_INV_SND_S = Fat_Inv_Snd_Local(
         FISGU: FISGU,
         FCIGU: FAT_CSID_INF[0].FCIGU,
         CIIDL:int.parse(LoginController().CIID.toString()),
         JTIDL:int.parse(LoginController().JTID.toString()),
         BIIDL: int.parse(LoginController().BIIDL_N.toString()),
         SYIDL: LoginController().SYID,
         SCHNA: LoginController().SCHEMA_V,
         UUID:UUID_V,
         STID: [11,12].contains(BIL_MOV_M[0].BMKID)?'BF':'BO',
         BMMGU: BIL_MOV_M[0].GUID,
         FISSI: FISSI_N ?? FISSIO_N,
         FISST: FISST_N,
         FISSTO: FISST_N,
         FISICV: API_R.ICV_N,
         FISPIN: FISPIN_N,
         FISPGU: FISPGU_V,
         FISPIH: API_R.PIH_V,
         FISIH: INV_RE_R.INV_HASH_V,
         FISQR: INV_RE_R.INV_QR_V,
         FISZHS: INV_RE_R.ZATHTTPST_N.toString(),
         FISZHSO: FISZHSO_N ?? INV_RE_R.ZATHTTPST_N.toString(),
         FISZS: INV_RE_R.PZATST_V,
         FISIS: INV_RE_R.INV_STATUS_V,
         FISINF: INV_RE_R.INV_INF_V.toString(),
         FISWE: FISWE_N.toString(),
     //    FISWA: INV_RE_R.INV_WAR_C.toString(),
         FISEE: FISEE_N,
        // FISER: INV_RE_R.INV_ERR_C.toString(),
         FISXML: INV_RE_R.INV_XML_C,
    //     FISREQ: INV_RE_R.REQ_DAT_C,
       //  FISRES: INV_RE_R.RES_DAT_C,
      //   FISJSON: INV_RE_R.JSON_C,
         FISTOT: INV_RE_R.INV_TOTAMO_N,
         FISSUM: INV_RE_R.INV_LINAMO_N,
         FISTWV: INV_RE_R.INV_TOTWVAT_N,
         FISSD: DateFormat('dd-MM-yyyy HH:mm:ss').format(DateTime.now()),
         FISLSD: null,
         FISNS: 1,
         SOMGU: LoginController().SOMGU.toString(),
         SYDV_APPV: LoginController().APPV,
         SMID: null,
         SUID: LoginController().SUID,
         DATEI: DateFormat('dd-MM-yyyy HH:mm:ss').format(DateTime.now()),
         DEVI: LoginController().DeviceName,
         STMIDI: STMID,
         SOMIDI: int.parse(LoginController().SYDV_ID.toString()),
         FISINO: FISINO_V,
         FISXE:FISXE_N,
         JTID_L: LoginController().JTID,
         BIID_L: LoginController().BIID,
         SYID_L: LoginController().SYID,
         CIID_L: LoginController().CIID,
       );
         var data=  await SAVE_FAT_INV_SND(FAT_INV_SND_S);
         print('data.FISSEQ');
         print(FAT_INV_SND_S.toMap());
         print(data.FISSEQ);
         FISSEQ_N=data.FISSEQ;

         try{
           ADD_SND_INV_D_R_P(P_BMMFST_N: FISST_N,P_FISGU_V:FISGU,P_ERR_C: INV_RE_R.INV_ERR_C.toString(),
           P_REQ_C:INV_RE_R.REQ_DAT_C.toString(),P_RES_C:INV_RE_R.RES_DAT_C.toString(),
               P_WAR_C:INV_RE_R.INV_WAR_C.toString());

         }catch(e,stackTrace){
           ST_O_N=2;
           ERR_TYP_N=3;
           print(stackTrace);
           MSG_O_V =(await GET_MSG_F(423,P_LAN_N: 1)! +''+ STP_N.toString() +'ERROR INSRT DATA TO  FAT_INV_SND_D_R TABLE =>' + '' + e.toString()).toString();
           await UPDATE_BIL_MOV_M_BMMQR(TBL_V:BIL_MOV_M[0].BMKID == 11 || BIL_MOV_M[0].BMKID == 12 ? 'BIF_MOV_M' : 'BIL_MOV_M',
               BMKID:BIL_MOV_M[0].BMKID, BMMID:BIL_MOV_M[0].BMMID,BMMFS:5,
           BMMFIC: API_R.ICV_N,BMMFUU:API_R.UUID_V,BMMFNO: API_R.FISINO_V,
           BMMQR:INV_RE_R.INV_QR_V);
           INSERT_FAT_SND_LOG(BMMGU:BIL_MOV_M[0].GUID,FCIGU:FAT_CSID_INF[0].FCIGU,FSLSIG:SIGN_FLAG_N,
               FSLCIE:IS_EXI_N,FSLSTP:STP_N,FSLST:ST_O_N,FSLRT:ERR_TYP_N,MSG_ERR:MSG_O_V,
               FISST_N:5,SSID_N:LoginController().SSID_N,FSLDRQ:INV_RE_R.REQ_DAT_C.toString(),
               FSLDER:INV_RE_R.ERR_V.toString() ,FSLDRC:INV_RE_R.RES_COD_V.toString() ,FSLDRS:INV_RE_R.RES_DAT_C.toString());
           return (ST_O_N,ERR_TYP_N,MSG_O_V);
         }


       }catch(e,stackTrace){
       ST_O_N=2;
       ERR_TYP_N=3;
       print(stackTrace);
       MSG_O_V =(await GET_MSG_F(423,P_LAN_N: 1)! +''+ STP_N.toString() +'ERROR INSRT DATA TO  FAT_INV_SND TABLE =>' + '' + e.toString()).toString();
       await UPDATE_BIL_MOV_M_BMMQR(TBL_V:BIL_MOV_M[0].BMKID == 11 || BIL_MOV_M[0].BMKID == 12 ? 'BIF_MOV_M' : 'BIL_MOV_M',
           BMKID:BIL_MOV_M[0].BMKID, BMMID:BIL_MOV_M[0].BMMID,BMMFS:5,
           BMMFIC: API_R.ICV_N,BMMFUU:API_R.UUID_V,BMMFNO: API_R.FISINO_V,
           BMMQR:INV_RE_R.INV_QR_V
       );
       INSERT_FAT_SND_LOG(BMMGU:BIL_MOV_M[0].GUID,FCIGU:FAT_CSID_INF[0].FCIGU,FSLSIG:SIGN_FLAG_N,
           FSLCIE:IS_EXI_N,FSLSTP:STP_N,FSLST:ST_O_N,FSLRT:ERR_TYP_N,MSG_ERR:MSG_O_V,
           FISST_N:5,SSID_N:LoginController().SSID_N,FSLDRQ:INV_RE_R.REQ_DAT_C.toString(),
           FSLDER:INV_RE_R.ERR_V.toString() ,FSLDRC:INV_RE_R.RES_COD_V.toString() ,FSLDRS:INV_RE_R.RES_DAT_C.toString());
       return (ST_O_N,ERR_TYP_N,MSG_O_V);
       }
     }


      if(INV_RE_R.ZATHTTPST_N.toString().isNotEmpty && FISST_N==3){
       ST_O_N=2;
       ERR_TYP_N=1;
       MSG_O_V=STP_N.toString() +' '+ 'ZATCA RETURN ERROR' +' '+INV_RE_R.INV_ERR_C.toString();
       await UPDATE_BIL_MOV_M_BMMQR(TBL_V:BIL_MOV_M[0].BMKID == 11 || BIL_MOV_M[0].BMKID == 12 ? 'BIF_MOV_M' : 'BIL_MOV_M',
           BMKID:BIL_MOV_M[0].BMKID, BMMID:BIL_MOV_M[0].BMMID,BMMFS:FISST_N,
       BMMFIC: API_R.ICV_N,BMMFUU:API_R.UUID_V,BMMFNO: API_R.FISINO_V,
           BMMQR:INV_RE_R.INV_QR_V);
       INSERT_FAT_SND_LOG(BMMGU:BIL_MOV_M[0].GUID,FCIGU:FAT_CSID_INF[0].FCIGU,FSLSIG:SIGN_FLAG_N,
           FSLCIE:IS_EXI_N,FSLSTP:STP_N,FSLST:ST_O_N,FSLRT:ERR_TYP_N,MSG_ERR:MSG_O_V,
           FISST_N:FISST_N,SSID_N:LoginController().SSID_N,FSLDRQ:INV_RE_R.REQ_DAT_C.toString(),
           FSLDER:INV_RE_R.ERR_V.toString() ,FSLDRC:INV_RE_R.RES_COD_V.toString() ,FSLDRS:INV_RE_R.RES_DAT_C.toString());
       return (ST_O_N,ERR_TYP_N,MSG_O_V);
      }
      else if(INV_RE_R.ZATHTTPST_N.toString().isNotEmpty && FISST_N==2){
       STP_N=145;
       ST_O_N=3;
       ERR_TYP_N=1;
       try{
        Fat_Inv_Rs_Local FAT_INV_RS_S = Fat_Inv_Rs_Local(
          GUID: Uuid().v4().toString().toUpperCase(),
          FISSEQ: FISSEQ_N,
          FISGU: FISGU,
          FCIGU: FAT_CSID_INF[0].FCIGU,
          CIIDL:int.parse(LoginController().CIID.toString()),
          JTIDL:int.parse(LoginController().JTID.toString()),
          BIIDL: int.parse(LoginController().BIIDL_N.toString()),
          SYIDL: LoginController().SYID,
          SCHNA: LoginController().SCHEMA_V,
          BMMGU: BIL_MOV_M[0].GUID.toString(),
          FIREQD: INV_RE_R.REQ_DAT_C,
          FIRESC: INV_RE_R.ZATHTTPST_N.toString(),
          FIRERR: INV_RE_R.ERR_V.toString(),
          FIRESD: INV_RE_R.RES_DAT_C,
       //   FIRJSON: INV_RE_R.JSON_C,
          FIRDA: DateFormat('dd-MM-yyyy HH:mm:ss').format(DateTime.now()),
          SUID: LoginController().SUID,
          DATEI: DateFormat('dd-MM-yyyy HH:mm:ss').format(DateTime.now()),
          DEVI: LoginController().DeviceName,
          STMIDI: STMID,
          SOMIDI: int.parse(LoginController().SYDV_ID.toString()),
          JTID_L: LoginController().JTID,
          BIID_L: LoginController().BIID,
          SYID_L: LoginController().SYID,
          CIID_L: LoginController().CIID,
        );
        SAVE_FAT_INV_RS(FAT_INV_RS_S);
       }catch(e,stackTrace){
         print(stackTrace);
         ST_O_N=2;
         ERR_TYP_N=3;
         MSG_O_V =(await GET_MSG_F(423,P_LAN_N: 1)! +''+ STP_N.toString() +'ERROR INSRT DATA TO  FAT_INV_RS TABLE =>' + '' + e.toString()).toString();
         await UPDATE_BIL_MOV_M_BMMQR(TBL_V:BIL_MOV_M[0].BMKID == 11 || BIL_MOV_M[0].BMKID == 12 ? 'BIF_MOV_M' : 'BIL_MOV_M',
             BMKID:BIL_MOV_M[0].BMKID, BMMID:BIL_MOV_M[0].BMMID,BMMFS:FISST_N,
         BMMFIC: API_R.ICV_N,BMMFUU:API_R.UUID_V,BMMFNO: API_R.FISINO_V,
           BMMQR:INV_RE_R.INV_QR_V);
         INSERT_FAT_SND_LOG(BMMGU:BIL_MOV_M[0].GUID,FCIGU:FAT_CSID_INF[0].FCIGU,FSLSIG:SIGN_FLAG_N,
             FSLCIE:IS_EXI_N,FSLSTP:STP_N,FSLST:ST_O_N,FSLRT:ERR_TYP_N,MSG_ERR:MSG_O_V,
             FISST_N:FISST_N,SSID_N:LoginController().SSID_N,FSLDRQ:INV_RE_R.REQ_DAT_C.toString(),
             FSLDER:INV_RE_R.ERR_V.toString() ,FSLDRC:INV_RE_R.RES_COD_V.toString() ,FSLDRS:INV_RE_R.RES_DAT_C.toString());
         return (ST_O_N,ERR_TYP_N,MSG_O_V);
       }
      }

      if(IS_EXI_N==1 || SIGN_FLAG_N==1){
        FISST_N=null;
      }
     if (IS_EXI_N == 1 && FISSEQ_N != null) {
      null;
     }else{

       try{
      print('INV_HASH_V');
      print(INV_RE_R.INV_HASH_V);
       UPDATE_FAT_CSID_SEQ(FCSNO:API_R.ICV_N,FISSEQ:FISSEQ_N,FISGU:FISGU,FCSHA:INV_RE_R.INV_HASH_V,FCIGU:FCIGU_V, STMIDU: STMID,
         SOMIDU: LoginController().SYDV_ID.toString(),DEVU: LoginController().DeviceName);

       }catch(e){
         ST_O_N=2;
         ERR_TYP_N=3;
         MSG_O_V =(await GET_MSG_F(423,P_LAN_N: 1)! +''+ STP_N.toString() +'ERROR UPDATE FAT_CSID_SEQ TABLE =>' + '' + e.toString()).toString();
         await UPDATE_BIL_MOV_M_BMMQR(TBL_V:BIL_MOV_M[0].BMKID == 11 || BIL_MOV_M[0].BMKID == 12 ? 'BIF_MOV_M' : 'BIL_MOV_M',
             BMKID:BIL_MOV_M[0].BMKID, BMMID:BIL_MOV_M[0].BMMID,BMMFS:FISST_N,
             BMMFIC: API_R.ICV_N,BMMFUU:API_R.UUID_V,BMMFNO: API_R.FISINO_V,
             BMMQR:INV_RE_R.INV_QR_V);
         INSERT_FAT_SND_LOG(BMMGU:BIL_MOV_M[0].GUID,FCIGU:FAT_CSID_INF[0].FCIGU,FSLSIG:SIGN_FLAG_N,
             FSLCIE:IS_EXI_N,FSLSTP:STP_N,FSLST:ST_O_N,FSLRT:ERR_TYP_N,MSG_ERR:MSG_O_V,
             FISST_N:FISST_N,SSID_N:LoginController().SSID_N,FSLDRQ:INV_RE_R.REQ_DAT_C.toString(),
             FSLDER:INV_RE_R.ERR_V.toString() ,FSLDRC:INV_RE_R.RES_COD_V.toString() ,FSLDRS:INV_RE_R.RES_DAT_C.toString());
         return (ST_O_N,ERR_TYP_N,MSG_O_V);
       }
       }

     if(INV_RE_R.ZATHTTPST_N!=null && FISST_N!= null && (IS_EXI_N==1 || SIGN_FLAG_N==1) ){
       try{
         UPDATE_FAT_INV_SND_ST(FISST:FISST_N,FISQR:INV_RE_R.INV_QR_V,FISZHSO:INV_RE_R.ZATHTTPST_N,BMMGU:BIL_MOV_M[0].GUID.toString() );
        }catch(e){
       ST_O_N=2;
       ERR_TYP_N=3;
       MSG_O_V =(await GET_MSG_F(423,P_LAN_N: 1)! +''+ STP_N.toString() +'ERROR UPDATE UPDATE_FAT_INV_SND_ST =>' + '' + e.toString()).toString();
       await UPDATE_BIL_MOV_M_BMMQR(TBL_V:BIL_MOV_M[0].BMKID == 11 || BIL_MOV_M[0].BMKID == 12 ? 'BIF_MOV_M' : 'BIL_MOV_M',
           BMKID:BIL_MOV_M[0].BMKID, BMMID:BIL_MOV_M[0].BMMID,BMMFS:FISST_N,
       BMMFIC: API_R.ICV_N,BMMFUU:API_R.UUID_V,BMMFNO: API_R.FISINO_V,
           BMMQR:INV_RE_R.INV_QR_V);
       INSERT_FAT_SND_LOG(BMMGU:BIL_MOV_M[0].GUID,FCIGU:FAT_CSID_INF[0].FCIGU,FSLSIG:SIGN_FLAG_N,
           FSLCIE:IS_EXI_N,FSLSTP:STP_N,FSLST:ST_O_N,FSLRT:ERR_TYP_N,MSG_ERR:MSG_O_V,
           FISST_N:FISST_N,SSID_N:LoginController().SSID_N,FSLDRQ:INV_RE_R.REQ_DAT_C.toString(),
           FSLDER:INV_RE_R.ERR_V.toString() ,FSLDRC:INV_RE_R.RES_COD_V.toString() ,FSLDRS:INV_RE_R.RES_DAT_C.toString());
       return (ST_O_N,ERR_TYP_N,MSG_O_V);
      }
     }
      print('INV_QR_V');
      print(INV_RE_R.INV_QR_V);
     if(INV_RE_R.INV_QR_V!=null){
       try{
         print('FISINO_V');
         print(API_R.ICV_N);
         print(API_R.UUID_V);
         print(API_R.FISINO_V);
         await UPDATE_BIL_MOV_M_BMMQR(TBL_V:BIL_MOV_M[0].BMKID == 11 || BIL_MOV_M[0].BMKID == 12 ? 'BIF_MOV_M' : 'BIL_MOV_M',
           BMKID:BIL_MOV_M[0].BMKID, BMMID:BIL_MOV_M[0].BMMID, BMMQR:INV_RE_R.INV_QR_V,BMMFS:FISST_N,
           BMMFIC: API_R.ICV_N,BMMFUU:API_R.UUID_V,BMMFNO: API_R.FISINO_V);
       }catch(e){
         ST_O_N=2;
         ERR_TYP_N=3;
         MSG_O_V =(await GET_MSG_F(423,P_LAN_N: 1)! +''+ STP_N.toString() +'ERROR UPDATE UPDATE_BIL_MOV_M_BMMQR =>' + '' + e.toString()).toString();
         await UPDATE_BIL_MOV_M_BMMQR(TBL_V:BIL_MOV_M[0].BMKID == 11 || BIL_MOV_M[0].BMKID == 12 ? 'BIF_MOV_M' : 'BIL_MOV_M',
             BMKID:BIL_MOV_M[0].BMKID, BMMID:BIL_MOV_M[0].BMMID,BMMFS:5);
         INSERT_FAT_SND_LOG(BMMGU:BIL_MOV_M[0].GUID,FCIGU:FAT_CSID_INF[0].FCIGU,FSLSIG:SIGN_FLAG_N,
             FSLCIE:IS_EXI_N,FSLSTP:STP_N,FSLST:ST_O_N,FSLRT:ERR_TYP_N,MSG_ERR:MSG_O_V,
             FISST_N:FISST_N,SSID_N:LoginController().SSID_N,FSLDRQ:INV_RE_R.REQ_DAT_C.toString(),
             FSLDER:INV_RE_R.ERR_V.toString() ,FSLDRC:INV_RE_R.RES_COD_V.toString(),
             FSLDRS:INV_RE_R.RES_DAT_C.toString());
         return (ST_O_N,ERR_TYP_N,MSG_O_V);
       }
       }


    ST_O_N=1;
    ERR_TYP_N=INV_RE_R.ERR_TYP_N ?? 1;
    MSG_O_V=INV_RE_R.ERR_V.toString();
    print('REQ_DAT_C');
    print(INV_RE_R.REQ_DAT_C.toString());

     INSERT_FAT_SND_LOG(BMMGU:BIL_MOV_M[0].GUID,FCIGU:FAT_CSID_INF[0].FCIGU,FSLSIG:SIGN_FLAG_N,
         FSLCIE:IS_EXI_N,FSLSTP:STP_N,FSLST:ST_O_N,FSLRT:ERR_TYP_N,MSG_ERR:'تم الارسال بنجاح',
         FISST_N:FISST_N,SSID_N:LoginController().SSID_N,FISGU:FISGU,FSLDRQ:INV_RE_R.REQ_DAT_C.toString(),
         FSLDER:INV_RE_R.ERR_V.toString() ,FSLDRC:INV_RE_R.RES_COD_V.toString() ,FSLDRS:INV_RE_R.RES_DAT_C.toString());

   return (ST_O_N,ERR_TYP_N,MSG_O_V);
    } catch (e, stackTrace) {
      print('ES_FAT_PKG.SND_INV_P $e $stackTrace');
      await UPDATE_BIL_MOV_M_BMMQR(TBL_V:BMKID_N == 11 || BMKID_N == 12 ? 'BIF_MOV_M' : 'BIL_MOV_M',
          BMKID:BMKID_N, BMMID:BMMID_N,BMMFS:5);
      INSERT_FAT_SND_LOG(BMMGU:BIL_MOV_M[0].GUID,FCIGU:FAT_CSID_INF[0].FCIGU.toString(),
          FSLSIG:SIGN_FLAG_N,
          FSLCIE:IS_EXI_N,FSLSTP:STP_N,FSLST:ST_O_N,FSLRT:ERR_TYP_N,MSG_ERR:MSG_O_V,
          FISST_N:5,SSID_N:LoginController().SSID_N,FSLDRQ:INV_RE_R.REQ_DAT_C.toString(),
          FSLDER:INV_RE_R.ERR_V.toString() ,FSLDRC:INV_RE_R.RES_COD_V.toString() ,FSLDRS:INV_RE_R.RES_DAT_C.toString());
      return (ST_O_N,ERR_TYP_N,e);
    }
  }

  //دالة تحهيز json
  static Future<INV_RE_TYP> GEN_JS_AND_SND(API_TYP API_TYP_R,List<Bil_Cus_Local> BIL_CUS,List<Bil_Mov_M_Local>
  BIL_MOV_M,List<Sys_Own_Local> SYS_OWN,List<Bil_Mov_D_Local> BIL_MOV_D,List<Fat_Csid_Inf_Local> FAT_CSID_INF)
  async {

    INV_RE_TYP INV_RE_R=INV_RE_TYP();
    Buyer buyer=Buyer();
    Invoice invoice=Invoice();
    List<InvoiceLine>? invoiceLines=[];
    var STP_N=1;
    try {

      INV_RE_R.ERR_TYP_N=0;
      STP_N=1;
      print('BIL_CUS');
      print(BIL_CUS);
    //بيانات العميل
    if(BIL_CUS.isNotEmpty){
      buyer.name=BIL_CUS.elementAt(0).BCNA.toString();
      buyer.address= Address(
        street: BIL_CUS.elementAt(0).BCSND.toString(),
        buildingNumber: BIL_CUS.elementAt(0).BCBN.toString(),
        district:BIL_CUS.elementAt(0).BAID_D.toString(),
        city: BIL_CUS.elementAt(0).CTNA_D.toString(),
        postalCode:  BIL_CUS.elementAt(0).BCPC.toString(),
        countryCode: BIL_CUS.elementAt(0).CWWC2.toString(),//رمز الدولة
      );
      buyer.vatNumber= BIL_CUS.elementAt(0).BCTX.toString();
      print('ITSY222');
      print(BIL_CUS.elementAt(0).ITSY.toString());
      print(BIL_CUS.elementAt(0).ILDE.toString());
      if(BIL_CUS.elementAt(0).ITSY.toString()!='null' && BIL_CUS.elementAt(0).ILDE.toString()!='null'){
        buyer.CUS_EX=true;
        buyer.id= Id(idType:BIL_CUS.elementAt(0).ITSY.toString(), value: BIL_CUS.elementAt(0).ILDE.toString());
      }
    }

      STP_N=2;
    //جلب بيانات api مثل ip ,port
    var FAT_API_INF =await GET_FAT_API_INF(API_TYP_R.SUBSI_V);
    if(FAT_API_INF.isEmpty){
      INV_RE_R.ERR_TYP_N=4;
      INV_RE_R.ERR_V="تأكد من بيانات FAT_API_INF";
      return INV_RE_R;
    }

      STP_N=3;
    //اذا كان ارسال
    if (API_TYP_R.PRO_TYP_V!='SND'){
      STP_N=4;
      //جلب بيانات الفاتورة الفرعي
      for (var i = 0; i < BIL_MOV_D.length; i++) {
        invoiceLines.add(InvoiceLine(
          quantity:  BIL_MOV_D[i].QUN_N!,
          price: BIL_MOV_D[i].AM_N,
          itemName: BIL_MOV_D[i].NAM_V,
          vat: Vat(categoryCode: BIL_MOV_D[i].VAT_CAT_V.toString(), percent:BIL_MOV_D[i].VAT_RAT_N!,
              taxExemptionReason: BIL_MOV_D[i].TAX_EXE_V.toString(),
              taxExemptionReasonCode: BIL_MOV_D[i].TAX_EXE_COD_V.toString()),));
           print('DIS_AM_N2');
           print(BIL_MOV_D[i].DIS_AM_N2);
          if(BIL_MOV_D[i].DIS_AM_N2!>0){
            invoiceLines.elementAt(i).dis=true;
            invoiceLines.elementAt(i).Allowances?.amount=BIL_MOV_D[i].DIS_AM_N2;
            invoiceLines.elementAt(i).Allowances?.reason=BIL_MOV_D[i].DIS_RES_V;
            invoiceLines.elementAt(i).Allowances?.reasonCode=BIL_MOV_D[i].DIS_COD_V;
            invoiceLines.elementAt(i).vat=Vat(categoryCode: BIL_MOV_D[i].VAT_CAT_V.toString(),
                percent: BIL_MOV_D[i].VAT_RAT_N!);
          }
      }
      STP_N=5;
      // إعداد نموذج الفاتورة
       invoice = Invoice(
        invoiceType: API_TYP_R.TAX_TYP,
        billingReference: BIL_MOV_M.elementAt(0).BMMNOR.toString(),
        reasonsForIssuance: BIL_MOV_M.elementAt(0).INV_REL_RES_V.toString(),
        //بيانات الفاتورة الرئيسي
        generalInvoiceInfo: GeneralInvoiceInfo(
          number: BIL_MOV_M.elementAt(0).BMMNO.toString(),
          uuid: API_TYP_R.UUID_V,
          icv: API_TYP_R.ICV_N,
          issueDateTime: BIL_MOV_M.elementAt(0).DAT_TIM_V.toString(),
          actualDeliveryDate:BIL_MOV_M.elementAt(0).DAT_V.toString(),
          previousInvoiceHash: API_TYP_R.PIH_V,
          currency: BIL_MOV_M.elementAt(0).SCSY.toString(),
          paymentMeans: [BIL_MOV_M.elementAt(0).PKSY.toString()],
          vatCurrency: "SAR",
        ),

        //بيانات البائع
        seller: Seller(
          name: SYS_OWN.elementAt(0).SOHN.toString(),
          address: Address(
            street: SYS_OWN.elementAt(0).SOSND.toString(),
            buildingNumber: SYS_OWN.elementAt(0).SOBN.toString(),
            district:SYS_OWN.elementAt(0).BAID_D.toString(),
            city: SYS_OWN.elementAt(0).CTNA_D.toString(),
            postalCode:  SYS_OWN.elementAt(0).SOPC.toString(),
            countryCode: SYS_OWN.elementAt(0).CWWC2.toString(),//رمز الدولة
          ),
          vatNumber: SYS_OWN.elementAt(0).SOTX.toString(),
          id: Id(idType: SYS_OWN.elementAt(0).ITSY.toString(), value: SYS_OWN.elementAt(0).ILDE.toString()),
        ),
        //بيانات العميل
        buyer: buyer,
         //بيانات الفاتورة الفرعي
        invoiceLines: invoiceLines,
        privateKey: FAT_CSID_INF.elementAt(0).FCIPK,
        binarySecurityToken:FAT_CSID_INF.elementAt(0).FCIBST,
        secret: FAT_CSID_INF.elementAt(0).FCISE,
      );
    }

      STP_N=6;

      var isConnected = await checkInternetConnection();
      if (await isConnected==true) {
        print('متصل بالإنترنت');
        // إرسال الفاتورة
        INV_RE_R=await CALL_API_P(invoice,FAT_API_INF,API_TYP_R);
      } else {
        print('غير متصل بالإنترنت');
        INV_RE_R.ERR_TYP_N=4;
        INV_RE_R.ERR_V=" لا يوجد اتصال بالإنترنت. يرجى التحقق من اتصالك بالشبكة";
        return INV_RE_R;
      }

     // INV_RE_R=await CALL_API_P(invoice,FAT_API_INF,API_TYP_R);
      return INV_RE_R;
    } catch (e, stackTrace) {
      print('ES_FAT_PKG.GEN_JS_AND_SND $e $stackTrace');
      INV_RE_R.ERR_V='ES_FAT_PKG.GEN_JS_AND_SND $e';
      INV_RE_R.ERR_TYP_N=4;
      return INV_RE_R;
    }
  }

  //دالة ارسال الفاتورة
  static Future<INV_RE_TYP> CALL_API_P(Invoice invoice,List<Fat_Api_Inf_Local> FAT_API_INF,
      API_TYP API_TYP_R)
  async {
    INV_RE_TYP INV_RE_R=INV_RE_TYP();
    var STP_N=1;
    Map<String, dynamic> jsonData;
   try {
      var Url="http://${FAT_API_INF[0].FAIURL.toString()}:${FAT_API_INF[0].FAIPO.toString()}/${FAT_API_INF[0].FAIRO.toString()}";
      var USR = FAT_API_INF[0].FAIUS;
      var PAS = FAT_API_INF[0].FAIPA.toString();

      STP_N=1;
      Socket.connect(FAT_API_INF[0].FAIURL.toString(), int.parse(FAT_API_INF[0].FAIPO.toString()), timeout:
      Duration(seconds: 5)).then((socket) async {
        print("Success");
        socket.destroy();
      }).catchError((error) {
        INV_RE_R.ERR_TYP_N=3;
        INV_RE_R.API_ERR_N=1;
        INV_RE_R.ERR_V= "ES_FAT_PKG.CALL_API_P-${error.toString()}";
        print("Exception on Socket $error");
      });
      if(INV_RE_R.ERR_TYP_N==3 && INV_RE_R.API_ERR_N==1 && INV_RE_R.ERR_V.toString().isNotEmpty){
        return INV_RE_R;
      }
      // تحويل الكائن إلى JSON
      print('invoice');
      print(invoice.toJson());
      printLongText(invoice.toJson().toString());
      var jsonString = jsonEncode(invoice.toJson());
      var bodylang = utf8.encode(json.encode(invoice.toJson()));
      var basicAuth = 'Basic ${base64Encode(utf8.encode('$USR:$PAS'))}';
      INV_RE_R.REQ_DAT_C=jsonString;
      STP_N=2;
      //إرسال البيانات
      final response = await http.post(Uri.parse(Url),
          body: (API_TYP_R.PRO_TYP_V == 'SND') ? API_TYP_R.REQ_DAT_C : jsonString,
          headers: {'Transfer-Encoding': 'chunked',
            HttpHeaders.contentTypeHeader: "application/json",
            'Content-Length': API_TYP_R.PRO_TYP_V=='SND'?API_TYP_R.REQ_DAT_C.length.toString():bodylang.length.toString(),
            'Authorization': basicAuth
          }).timeout(Duration(seconds: FAT_API_INF[0].FAITI!));

      if(response.body.isEmpty){
        INV_RE_R.ERR_TYP_N=3;
        INV_RE_R.API_ERR_N=1;
        INV_RE_R.ERR_V= "ES_FAT_PKG.CALL_API_P NO_DATA_RETURN";
        return INV_RE_R;
      }
      INV_RE_R.RES_DAT_C=response.body;
      INV_RE_R.RES_COD_V=response.statusCode;

      STP_N=3;


      // معالجة الاستجابة
        print('الاستجابة: ${response.body}');


      STP_N=5;

       try{
         jsonData = json.decode(response.body);
         //ارجع الطلب و جلب qr ,hash
       }catch(e){
         INV_RE_R.ERR_TYP_N=2;
         var ERR_SJ= "${INV_RE_R.ERR_V} ${INV_RE_R.RES_DAT_C} ${e}";
         INV_RE_R.ERR_V=ERR_SJ.toString();
         return INV_RE_R;
       }

        INV_RE_R.INV_HASH_V=jsonData['invoiceHash'];
        INV_RE_R.INV_QR_V=jsonData['qrCode'];
        INV_RE_R.PZATST_V=jsonData['httpStatus'];
        INV_RE_R.INV_STATUS_V=jsonData['status'];
        INV_RE_R.INV_LINAMO_N=jsonData['sumOfLineNetAmount'];
        INV_RE_R.INV_TOTAMO_N=jsonData['totalAmount'];
        INV_RE_R.INV_TOTWVAT_N=jsonData['totalAmountWithVat'];
        INV_RE_R.ZATHTTPST_N=jsonData['zatcaHttpStatus'];
        print('INV_RE_R.ZATHTTPST_N');
        print(INV_RE_R.ZATHTTPST_N);
        INV_RE_R.JSON_C=jsonData['json'];
         if(INV_RE_R.ZATHTTPST_N.toString().isEmpty && API_TYP_R.SUBSI_V=='SIGN'){
           INV_RE_R.ZATHTTPST_N=response.statusCode;
         }

      if(jsonData.containsKey('errors')){
        // // الوصول إلى القيمة
        // List<dynamic> errors = jsonData['errors'];
        // print(errors);
        INV_RE_R.ERR_TYP_N=2;
        INV_RE_R.ERR_V=(INV_RE_R.RES_DAT_C).toString();
        return INV_RE_R;
      }

      print(jsonData['infoMessages']);
      if(jsonData['infoMessages'].toString().length>10){
        INV_RE_R.INV_INF_V=jsonData['infoMessages'];
      }
      if(jsonData['errorMessages'].toString().length>10){
        INV_RE_R.INV_ERR_C=jsonData['errorMessages'];
      }
      if(jsonData['warningMessages'].toString().length>10){
        INV_RE_R.INV_WAR_C=jsonData['warningMessages'];
      }

      INV_RE_R.INV_XML_C=jsonData['invoice'];
      INV_RE_R.JSON_C=jsonData['json'];


      return INV_RE_R;

    }on TimeoutException catch (_) {
      print('الطلب استغرق أكثر من دقيقة.');
      INV_RE_R.ERR_V='ES_FAT_PKG.CALL_API_P الطلب استغرق أكثر من دقيقة';
      INV_RE_R.ERR_TYP_N=3;
      return INV_RE_R;
    } catch (e, stackTrace) {
      print('ES_FAT_PKG.CALL_API_P $e');
      print('ES_FAT_PKG.CALL_API_P $stackTrace');
      INV_RE_R.ERR_V='ES_FAT_PKG.CALL_API_P $e';
      INV_RE_R.ERR_TYP_N=3;
      return INV_RE_R;
   }
  }

  //دالة جلب قيمة
  static Future<String> TYP_NAM_F(F_TY,VAL_V,VAL_V2) async {
    try {
      String RES='';
      var TYP_NAM_V=await GET_TYP_NAM(F_TY,VAL_V,VAL_V2);
      if(TYP_NAM_V.isNotEmpty){
        RES= TYP_NAM_V.elementAt(0).NAM_V.toString();
      }
      print(RES);
      print('TYP_NAM_F');
      return  RES;
    } catch (e) {
      print('ES_FAT_PKG.TYP_NAM_F: $e');
      Fluttertoast.showToast(
          msg: "ES_FAT_PKG.TYP_NAM_F-${e.toString()}",
          toastLength: Toast.LENGTH_LONG,
          textColor: Colors.white,
          backgroundColor: Colors.redAccent);
      return e.toString();
    }
  }

  //دالة للتحقق من اتصال الإنترنت
  static Future<bool> checkInternetConnection() async {
    try {
      print('checkInternetConnection');
      final response = await http.get(Uri.parse('https://www.google.com'));
      print(response.statusCode);
      // إذا كانت الحالة 200، فهذا يعني أن الاتصال ناجح
      if (response.statusCode == 200) {
        return true;
      }
    } catch (e) {
      // في حالة حدوث أي استثناء، فهذا يعني عدم وجود اتصال
      return false;
    }
    return false; // إذا لم يكن هناك استجابة

  }

  static int? HTTP_ST_F({int P_SIGN_N = 1, String? P_HTTP_V}) {
    if (P_HTTP_V == null) {
      return 5;
    } else if (P_HTTP_V.isNotEmpty && P_HTTP_V=='409') {
      return 1;
    } else if (P_HTTP_V.isNotEmpty && P_HTTP_V=='413') {
      return 5;
    } else if (P_HTTP_V.isNotEmpty && (P_HTTP_V.startsWith('0') || P_HTTP_V.startsWith('4') || P_HTTP_V.startsWith('5')) && P_HTTP_V == '400') {
      return 3;
    } else if (P_HTTP_V.isNotEmpty && (P_HTTP_V.startsWith('0') || P_HTTP_V.startsWith('4') || P_HTTP_V.startsWith('5'))) {
      return 2;
    } else if (P_HTTP_V.isNotEmpty && (P_HTTP_V.startsWith('0') || P_HTTP_V.startsWith('2')) && P_SIGN_N == 1) {
      return 4;
    } else if (P_HTTP_V.isNotEmpty && (P_HTTP_V.startsWith('0') || P_HTTP_V.startsWith('2'))) {
      return 1;
    } else {
      return 5;
    }
  }

  static String? GET_MSG_F(int? P_MSG_N, {int? P_LAN_N}) {
    String? RE_V;

    if (P_MSG_N == null) {
      return null; // أو يمكنك إرجاع رسالة معينة
    }

    try {
      // محاكاة الاستعلام عن الرسالة
      // في بيئة حقيقية، يمكنك استخدام مكتبة مثل http لاستدعاء API
      RE_V = sysMsgF(P_MSG_N, 1, P_LAN_N ?? getLanN());
    } catch (e) {
      // التعامل مع الاستثناءات إذا لزم الأمر
      print('Error: $e');
    }

    // إذا كانت RE_V فارغة، تحقق من قيم P_MSG_N لإرجاع الرسالة المناسبة
    if (RE_V == null) {
      switch (P_MSG_N) {
        case 423:
          RE_V = 'خطا غير معرف';
          break;
        case 8028:
          RE_V = 'لايمكن حذف ختم التشفير لوجود فواتير وحركات مرسله عن طريقه .. يمكنك ايقاف استخدامه فقط';
          break;
        case 461:
          RE_V = 'الداله لم ترجع اي بيانات';
          break;
        case 8029:
          RE_V = 'مفتاح ختم التشفير منتهي';
          break;
        case 463:
          RE_V = 'غير قادر على الوصول للـAPI';
          break;
        case 8030:
          RE_V = 'الفاتوره يتم العمل عليها من خلال جهاز /جلسه اخرى';
          break;
        case 8025:
          RE_V = 'لقد تم ارسال الفاتوره مسبقا ..';
          break;
        case 8031:
          RE_V = 'لقد تم توقيع الفاتوره مسبقا ..';
          break;
        case 8032:
          RE_V = 'يرجى التاكد من بيانات الفاتوره والبيانات الضريبيه التابعه لها';
          break;
        case 8033:
          RE_V = 'مفتاح ختم التشفير محجوز من حركه /جلسة اخرى';
          break;
        case 8034:
          RE_V = 'لم يتم تفعيل الربط مع منصه فاتوره للفرع';
          break;
        case 8035:
          RE_V = 'الفاتوره ادخلت من نظام اخر وبالتالي يجب ارسال الفاتوره من النظام الذي ادخلت منه';
          break;
        default:
          RE_V = 'رسالة غير معروفة';
      }
    }
    return RE_V;
  }

// محاكاة دالة sysMsgF
  static String? sysMsgF(int fSmId, int fTy, int? fLa) {
    // هنا يمكنك تنفيذ المنطق الخاص بك لاسترجاع الرسالة
    // سأقوم بإرجاع null كمثال
    return null; // يمكنك استبداله بالقيمة الفعلية
  }

// محاكاة دالة getLanN
  static int getLanN() {
    return 1; // القيمة الافتراضية للغة
  }


//لارجاع هل الفاتوره مرسله من قبل ام لا
  static Future<void> GET_INV_ST_P({
    required String? P_TYP_V,
    required String P_BMMGU_V,
    required int? P_ST_O_N,
    required int? P_FISSEQ_O_N,
  })
  async {
    int? FISST_N;
    int TMP_N = 0;
    String TBL_V = 'FAT_INV_SND';
    int? TY_N;

    // تحقق من المعطيات
    if (P_TYP_V == null || P_BMMGU_V.isEmpty) {
      return; // أو يمكنك إرجاع قيمة معينة
    }

    // تنفيذ استعلام للبحث عن الحالة
    try {
      String Q_V = '''
    SELECT 1 AS TY, A.FISST 
    FROM $TBL_V A 
    WHERE A.BMMGU = :bmmguV 
    AND ROWNUM <= 1
    ''';

      // تنفيذ الاستعلام
      var result = await executeQuery(Q_V, {'bmmguV': P_BMMGU_V});
      if (result.isNotEmpty) {
        TY_N = result[0]['TY'];
        FISST_N = result[0]['FISST'];
      }
    } catch (e) {
      // إذا لم يتم العثور على بيانات
      try {
        String Q_VArc = '''
      SELECT 2 AS TY, A.FISST 
      FROM ${TBL_V}_ARC A 
      WHERE A.BMMGU = :bmmguV 
      AND ROWNUM <= 1
      ''';

        var resultArc = await executeQuery(Q_VArc, {'bmmguV': P_BMMGU_V});
        if (resultArc.isNotEmpty) {
          TY_N = resultArc[0]['TY'];
          FISST_N = resultArc[0]['FISST'];
        }
      } catch (e) {
        // التعامل مع الخطأ
        P_ST_O_N = await HTTP_ST_F();
        P_FISSEQ_O_N = null;
        return;
      }
    }

    P_ST_O_N = FISST_N;

    if (TY_N == 2) {
      TBL_V = '${TBL_V}_ARC';
    }

    // استعلام للبحث عن FISSEQ
    try {
      String Q_VSeq = '''
    SELECT A.FISSEQ 
    FROM $TBL_V A 
    WHERE A.BMMGU = :bmmguV
    AND ROWNUM <= 1
    ''';

      if (P_ST_O_N == 1 || P_ST_O_N == 4) {
        Q_VSeq += ' AND SUBSTR(NVL(A.FISZHS,0),1,1) IN(2)';
      } else if (P_ST_O_N == 2) {
        Q_VSeq += ' AND SUBSTR(NVL(A.FISZHS,0),1,1) IN(0,4,5) AND NVL(A.FISZHS,0) NOT IN (400)';
      } else if (P_ST_O_N == 3) {
        Q_VSeq += ' AND SUBSTR(NVL(A.FISZHS,0),1,1) IN(0,4,5) AND NVL(A.FISZHS,0) IN (400)';
      }

      var resultSeq = await executeQuery(Q_VSeq, {'bmmguV': P_BMMGU_V});
      if (resultSeq.isNotEmpty) {
        P_FISSEQ_O_N = resultSeq[0]['FISSEQ'];
      }
    } catch (e) {
      P_ST_O_N = await HTTP_ST_F();
      P_FISSEQ_O_N = null;
    }
  }


  // دالة لمحاكاة تنفيذ الاستعلام
  static Future<List<Map<String, dynamic>>> executeQuery(String query, Map<String, dynamic> params) async {
    // هنا يجب أن تضيف منطق الاتصال بقاعدة البيانات وتنفيذ الاستعلام
    print('Executing query: $query with params: $params');
    return []; // إرجاع نتيجة وهمية
  }


  static Future<int> GET_TTLID( int BMKID, double BMMAM, double SCEX, int TTID, String? TTBTNC) async {
    int vN1 = 0;
    String? vC1;
    final conn = DatabaseHelper.instance;
    var dbClient = await conn.database;
    try{


    // بناء جملة SQL
    String BMKID_V = '';
    String vCom = '''
    SELECT IFNULL(A.TTLID, 0) AS TTLID
    FROM TAX_TBL_LNK A 
    WHERE A.TTID = $TTID 
      AND A.TTLTB = 'BIL_MOV_K' 
      AND A.TTLNO IS NOT NULL 
      AND A.TTLNO LIKE '%<$BMKID>%' 
      AND ROUND(IFNULL($BMMAM, 0) * IFNULL($SCEX, 0), 1) >= IFNULL(A.TTLLN, 0) 
      AND ROUND(IFNULL($BMMAM, 0) * IFNULL($SCEX, 0), 1) <= IFNULL(A.TTLHN, 0) 
      AND A.TTLID < 300
  ''';

    // معالجة الشروط
    if ([2, 4, 6, 12].contains(BMKID)) {
      int vN2 = (BMKID == 2) ? 2 : 1;

      if (vN2 == 2) {
        vCom += ' AND A.TTLID IN(5,6)';
      } else {
        vCom += ' AND A.TTLID IN(3,4)';
      }
    }

    // إضافة شرط للصفوف
    vCom += ' LIMIT 1';



    // تنفيذ الاستعلام
    var result = await dbClient!.rawQuery(vCom);
    print(result);

    List<Tax_Tbl_Lnk_Local> list = result.map((item) {
      return Tax_Tbl_Lnk_Local.fromMap(item);
    }).toList();

    if (result.isNotEmpty) {
      vN1 = list[0].TTLID ?? 0;
    }


    // معالجة الرقم الضربي للحساب
    if (vN1 > 0) {
      vC1 = TTBTNC;

      print([1, 3, 5].contains(vN1));
      print((vC1 == 'null' || vC1.toString().isEmpty));
      print([1, 3, 5].contains(vN1) && (vC1 == 'null' || vC1.toString().isEmpty));

      print(![1, 3, 5].contains(vN1));
      print((vC1 != 'null' || vC1.toString().isNotEmpty));
      print(![1, 3, 5].contains(vN1) && (vC1 != 'null' || vC1.toString().isNotEmpty));


      if ([1, 3, 5].contains(vN1) && (vC1 == 'null' || vC1.toString().isEmpty)) {
        vN1 += 1;
      }

      if (![1, 3, 5].contains(vN1) && (vC1 != 'null' && vC1.toString().isNotEmpty)) {
        vN1 -= 1;
      }
    }

    return vN1; // إرجاع القيمة النهائية

  } catch (e) {
    print(e);
    return vN1;
    }
  }

  static String GEN_INV_NO_F(
      {String? stId,
      int? biId,
      int? bmKId,
      int? bmMId,
      int? bmMNo,
      int? syId}) {
    try{
      print(stId);
      print(biId);
      print(bmKId);
      print(bmMId);
      print(bmMNo);
      print(syId);
      print('GEN_INV_NO_F');
    // تحقق من القيم الفارغة
    if (stId == null || biId == null || bmKId == null || bmMId == null || bmMNo == null || syId == null) {
      return 'تأكد من البيانات المرسلة'; // أو يمكنك إرجاع رسالة خطأ
    }

    // تنسيق المعلمات
    String tmpV = bmKId.toString().padLeft(2, '0');
    String tmpV2 = syId.toString().padLeft(2, '0');
    String tmpV3 = biId.toString().padLeft(3, '0');

    print(tmpV);
    print(tmpV2);
    print(tmpV3);

    // توليد رقم الفاتورة
    String reV = '${stId[0]}$tmpV$tmpV2$tmpV3-$bmMNo';
    print(reV);

    return reV;
    } catch (e, stackTrace) {
      print(e);
      print(stackTrace);
      return '';
    }
    }

  static Future<void> ADD_SND_INV_D_R_P({int? P_BMMFST_N,
      String? P_FISGU_V,
      String? P_WAR_C,
      String? P_ERR_C,
      String? P_REQ_C,
      String? P_RES_C})
  async {
    if (P_BMMFST_N == null || P_FISGU_V == null || ![1, 2, 3, 4].contains(P_BMMFST_N)) {
      return; // إنهاء الدالة إذا كانت القيم غير صالحة
    }

    print('ADD_SND_INV_D_R_P');
    print(P_WAR_C);
    print(P_ERR_C);
    print(P_REQ_C);
    print(P_RES_C);
    // تسجيل العملية
    await logMessage('ADD_SND_INV_D_R_P BMMFST_N=$P_BMMFST_N');
    await logMessage('ADD_SND_INV_D_R_P P_FISGU_V=$P_FISGU_V');

    try {
      if (P_WAR_C.toString() != 'null') {
        await SAVE_SND_INV_D_R( 'WAR', P_WAR_C.toString(), P_BMMFST_N, P_FISGU_V);
      }

      if (P_ERR_C.toString() != 'null') {
        await SAVE_SND_INV_D_R('ERR', P_ERR_C.toString(), P_BMMFST_N, P_FISGU_V);
      }

      if (P_REQ_C.toString() != 'null' && [2, 3, 4].contains(P_BMMFST_N)) {
        await SAVE_SND_INV_D_R('REQ', P_REQ_C.toString(), P_BMMFST_N, P_FISGU_V);
      }

      if (P_RES_C.toString() != 'null' && [2, 3].contains(P_BMMFST_N)) {
        await SAVE_SND_INV_D_R( 'RES', P_RES_C.toString(), P_BMMFST_N, P_FISGU_V);
      }
    } catch (e) {
      await logError('Error inserting data: ${e.toString()}');
    }
  }


  static Future<void> logMessage(String message) async {
    // وظيفة لتسجيل الرسائل
    print(message);
  }

  static Future<void> logError(String error) async {
    // وظيفة لتسجيل الأخطاء
    print('ERROR: $error');
  }

  static String processInvInf(String invInfV, String? inf1) {
    // طباعة القيم المدخلة
    print('Processing invInfV: $invInfV');
    print('inf1: $inf1');

    // تحقق من القيم المدخلة
    if (invInfV != 'null' && invInfV.isNotEmpty) {
      // إزالة الأحرف الجديدة (CR) وتنظيف السلسلة
      String cleanedInvInfV = invInfV.replaceAll('\r', '').replaceAll('\n', '').trim();
      String cleanedInf1 = (inf1?.replaceAll('\r', '').replaceAll('\n', '') ?? '1');

      // طباعة السلسلة المنظفة للمراجعة
      print('Cleaned invInfV: $cleanedInvInfV');
      print('Cleaned INF1: $cleanedInvInfV');
      print(cleanedInvInfV == cleanedInf1);

      // المقارنة مع قيمة أخرى (inf1)
      if (cleanedInvInfV == cleanedInf1) {
        invInfV = 'INF1';
      }

      // تقليم السلسلة إلى 999 حرف
      invInfV = invInfV.substring(0, invInfV.length > 999 ? 999 : invInfV.length);
    }

    // طباعة النتيجة النهائية
    print('Final invInfV: $invInfV');
    return invInfV;
  }

  static bool isVatNumberValid(String vatNumber) {
    // تحقق من طول رقم VAT
    if (vatNumber.length != 15) {
      return false; // غير صالح
    }

    // تحقق من الرقم الأول
    if (vatNumber.substring(0, 1) != '3') {
      return false; // غير صالح
    }

    // تحقق من الرقم الأخير
    if (vatNumber.substring(vatNumber.length - 1) != '3') {
      return false; // غير صالح
    }

    // إذا كانت جميع الشروط صحيحة
    return true; // صالح
  }

  static void configloading_ERR() {
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
    EasyLoading.showError('خطأ في الارسال');
  }

  static void configloading_SUCC() {
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
      ..userInteractions = false
      ..dismissOnTap = false;
    EasyLoading.showSuccess('تم الارسال بنجاح');
  }

  static void configloading() {
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
      ..userInteractions = false
      ..dismissOnTap = false;
    EasyLoading.show(status: 'ارسال البيانات الى منصه فاتورة');
  }

}