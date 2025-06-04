import 'dart:convert';
import 'dart:io';
import 'package:dio/dio.dart';
import '../../Operation/models/bif_tra_tbl.dart';
import '../../Setting/models/fat_inv_snd_r.dart';
import '../../Operation/models/acc_mov_d.dart';
import '../../Operation/models/acc_mov_m.dart';
import '../../Operation/models/bif_cou_c.dart';
import '../../Operation/models/bif_cou_m.dart';
import '../../Operation/models/bif_mov_a.dart';
import '../../Operation/models/bil_mov_d.dart';
import '../../Operation/models/bil_mov_m.dart';
import '../../Operation/models/inventory.dart';
import '../../Operation/models/sto_mov_m.dart';
import '../../Setting/controllers/login_controller.dart';
import '../../Setting/models/acc_acc.dart';
import '../../Setting/models/acc_usr.dart';
import '../../Setting/models/bif_cus_d.dart';
import '../../Setting/models/bil_cus.dart';
import '../../Setting/models/syn_ord.dart';
import '../../Setting/models/sys_usr.dart';
import '../../Setting/services/api_provider_login.dart';
import '../../database/TreasuryVouchers_db.dart';
import '../../database/customer_db.dart';
import '../../database/inventory_db.dart';
import '../../database/invoices_db.dart';
import '../../database/setting_db.dart';
import '../../database/sync_db.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import '../../database/database.dart';
import 'package:http/http.dart' as http;
import '../../Widgets/config.dart';
import 'package:intl/intl.dart';
import '../../Operation/models/bif_eord_m.dart';
import '../models/fat_csid_seq.dart';
import '../models/fat_inv_rs.dart';
import '../models/fat_inv_snd.dart';
import '../models/fat_inv_snd_d.dart';
import '../models/fat_snd_log.dart';
import '../models/fat_snd_log_d.dart';


class SyncronizationData {
  final conn = DatabaseHelper.instance;
  // final SyncController controller = Get.find();
  String SLINM='تم بنجاح ارسال البيانات للجدول الرئيسي رقم : ';
  String SLIND='تم بنجاح ارسال البيانات للجدول الفرعي رقم : ';
  void configloading(String ERR){
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
    EasyLoading.showError(ERR);
  }





//الفواتير------------------------------


  //STEP ----1
  Future<List<Bil_Mov_D_Local>> fetchAll_BIL_D(String TypeSync, int GetBMKID, String GetBMMID,
      GETBMMST,GetFromDate, GetToDate) async {
    final dbClient = await conn.database;
    List<Bil_Mov_D_Local> List_D = [];

    String SQLBIID_L = LoginController().BIID_ALL_V == '1'
        ? " AND  A.BIID_L=${LoginController().BIID}" :  '';
    String SQLBIID_L2 = LoginController().BIID_ALL_V == '1'
        ? " AND  B.BIID_L=A.BIID_L" :  '';

    String SQL2 = ''' AND A.JTID_L=${LoginController().JTID} AND A.SYID_L=${LoginController().SYID} 
                  AND A.CIID_L=${LoginController().CIID} $SQLBIID_L''';

    String SQL3 = ''' AND B.JTID_L=A.JTID_L AND B.SYID_L=A.SYID_L AND B.CIID_L=A.CIID_L $SQLBIID_L2''';

    var TAB_M=GetBMKID==11 || GetBMKID==12 || GetBMKID==-2?'BIF_MOV_M':'BIL_MOV_M';

    String SqlWhere= GetBMKID==-1 || GetBMKID==-2 ?
    " A.SYST=2 AND EXISTS(SELECT 1 FROM $TAB_M B WHERE B.BMMST=2 AND B.BMMFST IN(1,10) AND B.BMMID=A.BMMID"
        "  $SQL3) $SQL2"
        : 'A.BMKID=$GetBMKID AND A.SYST=2 AND '
        ' EXISTS(SELECT 1 FROM $TAB_M B WHERE B.BMMST=2 AND B.BMMFST IN(1,10) AND B.BMMID=A.BMMID $SQL3) $SQL2';

    try {
      if (TypeSync == "SyncAll") {
        final maps = await dbClient!.query(
            GetBMKID==11 || GetBMKID==12 || GetBMKID==-2?'BIF_MOV_D A':'BIL_MOV_D A',
            where: '$SqlWhere');
        for (var item in maps) {
          List_D.add(Bil_Mov_D_Local.fromMap(item));
        }
      }
      else if (TypeSync == "SyncOnly") {
        final maps = await dbClient!.query(GetBMKID==11 || GetBMKID==12?'BIF_MOV_D A':'BIL_MOV_D A',
            where: ''' A.BMMID=$GetBMMID AND EXISTS(SELECT 1 FROM $TAB_M B 
                 WHERE B.BMMST!=4 AND B.BMMFST IN(1,10) AND B.BMMID=A.BMMID $SQL3) ''');
        for (var item in maps) {
          List_D.add(Bil_Mov_D_Local.fromMap(item));
        }
      }
      else if (TypeSync == "ByDate") {
        final maps = await dbClient!.query(GetBMKID==11 || GetBMKID==12 || GetBMKID==-2?'BIF_MOV_D A':'BIL_MOV_D A',
            where: '''A.BMKID=$GetBMKID AND EXISTS(SELECT 1 FROM $TAB_M B WHERE B.BMMDOR
             BETWEEN '$GetFromDate' AND '$GetToDate' AND B.BMMST=$GETBMMST
             AND B.BMMFST IN(1,10) AND B.BMMID=A.BMMID $SQL3)  
             $SQL2 ''');
        for (var item in maps) {
          List_D.add(Bil_Mov_D_Local.fromMap(item));
        }
      }
    } catch (e) {
      print(e.toString());
    }
    return List_D;
  }

  //STEP ----2
  Future SyncBIL_MOV_DToSystem(String TypeSync, int GetBMKID, String GetBMMID, List<Bil_Mov_D_Local> List_D,
      String GETTAB_N,bool TypeAuto,int GETBMMST,GetFromDate, GetToDate) async {
    for (var i = 0; i < List_D.length; i++) {
      var data    =    {
        "BMMID": List_D[i].BMMID.toString(),
        "BMKID": List_D[i].BMKID.toString(),
        "BMDID": List_D[i].BMDID.toString(),
        "MGNO": List_D[i].MGNO.toString(),
        "MINO": List_D[i].MINO.toString(),
        "MUID": List_D[i].MUID.toString(),
        "BMDNF": List_D[i].BMDNF.toString(),
        "BMDNO": List_D[i].BMDNO.toString(),
        "BMDIN": List_D[i].BMDIN.toString(),
        "BMDAM": List_D[i].BMDAM.toString(),
        "BMDED": List_D[i].BMDED.toString(),
        "BMDTX": List_D[i].BMDTX.toString(),
        "BMDTX1": List_D[i].BMDTX1.toString(),
        "BMDTX2": List_D[i].BMDTX2.toString(),
        "BMDTX3": List_D[i].BMDTX3.toString(),
        "BMDTXA": List_D[i].BMDTXA.toString(),
        "BMDTXA1": List_D[i].BMDTXA1.toString(),
        "BMDTXA2": List_D[i].BMDTXA2.toString(),
        "BMDTXA3": List_D[i].BMDTXA3.toString(),
        "BMDTXD": List_D[i].BMDTXD.toString(),
        "BMDDIA2": List_D[i].BMDDIA2.toString(),
        "BMDDIR2": List_D[i].BMDDIR2.toString(),
        "BMDDIR": List_D[i].BMDDIR.toString(),
        "BMDWE": List_D[i].BMDWE.toString(),
        "BMDVO": List_D[i].BMDVO.toString(),
        "BMDVC": List_D[i].BMDVC.toString(),
        "SIID": List_D[i].SIID.toString(),
        "BMDTY": List_D[i].BMDTY.toString(),
        "BMDEQ": List_D[i].BMDEQ.toString(),
        "GUID": List_D[i].GUID.toString(),
        "GUIDM_L": List_D[i].GUIDM.toString(),
        "BMDDI": List_D[i].BMDDI.toString(),
        "BMDDIA": List_D[i].BMDDIA.toString(),
        "BMDDIF": List_D[i].BMDDIF.toString(),
        "BMDIDR": List_D[i].BMDIDR.toString(),
        "BMDAMR": List_D[i].BMDAMR.toString(),
        "MUCBC": List_D[i].MUCBC.toString(),
        "BMDAMO": List_D[i].BMDAMO.toString(),
        "CTMID": List_D[i].CTMID.toString(),
        "CIMID": List_D[i].CIMID.toString(),
        "STMID_CO":STMID,
        "SYDV_NAME": LoginController().DeviceName,
        "SYDV_IP": LoginController().IP,
        "SYDV_TY":  LoginController().SYDV_TY,
        "SYDV_SER": LoginController().DeviceID,
        "SYDV_POI":"",
        "SYDV_ID_V":LoginController().SYDV_ID_V,
        "SYDV_NO_V":LoginController().SYDV_NO_V,
        "SYDV_BRA_N":1,
        "SYDV_LATITUDE":"",
        "SYDV_LONGITUDE":"",
        "SYDV_APPV_V":LoginController().APPV,
      };
      var data2   =    {
        "BMMID": List_D[i].BMMID.toString(),
        "BMKID": List_D[i].BMKID.toString(),
        "BMDID": List_D[i].BMDID.toString(),
        "MGNO": List_D[i].MGNO.toString(),
        "MINO": List_D[i].MINO.toString(),
        "MUID": List_D[i].MUID.toString(),
        "BMDNF": List_D[i].BMDNF.toString(),
        "BMDNO": List_D[i].BMDNO.toString(),
        "BMDAM": List_D[i].BMDAM.toString(),
        "BMDED": List_D[i].BMDED.toString(),
        "BMDTX": List_D[i].BMDTX.toString(),
        "BMDTX1": List_D[i].BMDTX1.toString(),
        "BMDTX2": List_D[i].BMDTX2.toString(),
        "BMDTX3": List_D[i].BMDTX3.toString(),
        "BMDTXA": List_D[i].BMDTXA.toString(),
        "BMDTXA1": List_D[i].BMDTXA1.toString(),
        "BMDTXA2": List_D[i].BMDTXA2.toString(),
        "BMDTXA3": List_D[i].BMDTXA3.toString(),
        "BMDEQC": List_D[i].BMDEQC.toString(),
        "BMDTXD": List_D[i].BMDTXD.toString(),
        "BMDDIA2": List_D[i].BMDDIA2.toString(),
        "BMDDIR2": List_D[i].BMDDIR2.toString(),
        "BMDDIR": List_D[i].BMDDIR.toString(),
        "BMDWE": List_D[i].BMDWE.toString(),
        "BMDVO": List_D[i].BMDVO.toString(),
        "BMDVC": List_D[i].BMDVC.toString(),
        "SIID": List_D[i].SIID.toString(),
        "BMDTY": List_D[i].BMDTY.toString(),
        "BMDEQ": List_D[i].BMDEQ.toString(),
        "BMDIN": List_D[i].BMDIN.toString(),
        "GUID": List_D[i].GUID.toString(),
        "GUIDM_L": List_D[i].GUIDM.toString(),
        "BMDDI": List_D[i].BMDDI.toString(),
        "BMDDIA": List_D[i].BMDDIA.toString(),
        "BMDDIF": List_D[i].BMDDIF.toString(),
        "BMDIDR": List_D[i].BMDIDR.toString(),
        "BMDAMR": List_D[i].BMDAMR.toString(),
        "BMDAMO": List_D[i].BMDAMO.toString(),
        "BMDAMRE": List_D[i].BMDAMRE.toString(),
        "STMID_CO":STMID,
        "SYDV_NAME": LoginController().DeviceName,
        "SYDV_IP": LoginController().IP,
        "SYDV_TY":  LoginController().SYDV_TY,
        "SYDV_SER": LoginController().DeviceID,
        "SYDV_POI":"",
        "SYDV_ID_V":LoginController().SYDV_ID_V,
        "SYDV_NO_V":LoginController().SYDV_NO_V,
        "SYDV_BRA_N":1,
        "SYDV_LATITUDE":"",
        "SYDV_LONGITUDE":"",
        "SYDV_APPV_V":LoginController().APPV,
      };
      var params2 =    {
        "STMID_CO_V": STMID,
        "SYDV_NAME_V": LoginController().DeviceName,
        "SYDV_IP_V":   LoginController().IP,
        "SYDV_TY_V":   LoginController().SYDV_TY,
        "SYDV_SER_V":  LoginController().DeviceID,
        "SYDV_POI_V":"",
        "SYDV_ID_V":   LoginController().SYDV_ID,
        "SYDV_NO_V":   LoginController().SYDV_NO,
        "SYDV_BRA_V":1,
        "SYDV_LATITUDE_V":"",
        "SYDV_LONGITUDE_V":"",
        "SYDV_APPV_V": LoginController().APPV,
        "SOID_V": STMID=='EORD'? 'BIF_MOV_DORD':STMID=='COU'? 'BIF_MOV_DC':
        List_D[i].BMKID==11?"BIF_MOV_DO":List_D[i].BMKID==12?
        "BIF_MOV_DOR":List_D[i].BMKID==3?"BIL_MOV_DO":List_D[i].BMKID==4?"BIL_MOV_DOR":
        List_D[i].BMKID==5?"BIL_MOV_DOS":List_D[i].BMKID==7?"BIL_MOV_DQ":
        List_D[i].BMKID==10?"BIL_MOV_DCR": List_D[i].BMKID==2?"BIL_MOV_DIR": "BIL_MOV_DI",
        "STID_V":"",
        "TBNA_V":GETTAB_N,
        "LAN_V": LoginController().LAN,
        "CIID_V":LoginController().CIID,
        "JTID_V":LoginController().JTID,
        "BIID_V":LoginController().BIID,
        "SYID_V":LoginController().SYID,
        "SUID_V":LoginController().SUID,
        "SUPA_V":LoginController().SUPA,
        "F_ROW_V":'0',
        "T_ROW_V":'0',
        "F_DAT_V": '',
        "T_DAT_V": '',
        "F_GUID_V":"",
        "WH_V1":'',
        "PAR_V":"",
        "JSON_V": List_D[i].BMKID==11 || List_D[i].BMKID==12?data.toString():data2.toString(),
        "JSON_V2":"",
        "JSON_V3":""
      };
      var bodylang = utf8.encode(json.encode(params2));
      var body = json.encode(params2);
      try {
        final response = await http.post(
            Uri.parse("${LoginController().API}/ESAPI/ESPOST"), body: body,
            headers: {'Transfer-Encoding': 'chunked',
              HttpHeaders.contentTypeHeader: "application/json",
              'Content-Length': bodylang.length.toString(),
            });
        if (response.statusCode == 201 || response.statusCode == 200) {
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
            ..userInteractions = TypeSync=='ByDate'?false:true
            ..dismissOnTap = false;
          TypeAuto==true?
          EasyLoading.show(status:  "${'StringWeAreSync'.tr}..${i+1}..${List_D.length}"):false;
          INSERT_SYN_LOG(List_D[i].BMKID == 11 || List_D[i].BMKID == 12 ? "BIF_MOV_D":"BIL_MOV_D", '${SLIND} ${List_D[i].BMMID}-${List_D[i].BMDID}', 'U');
        }
        else {
          TypeAuto==true? configloading(response.body):false;
          INSERT_SYN_LOG(GETTAB_N,'${response.body} ${List_D[i].BMMID.toString()}-${List_D[i].BMDID.toString()}','U');
          break;
        }
        if(i+1 ==List_D.length){
          print('STEP----2');
          STMID=='EORD'?await SyncBIF_MOV_A(TypeSync,GetBMKID,GetBMMID,List_D.length.toString(),TypeAuto):null;
          STMID=='EORD'?await SyncBIF_EROD_M(TypeSync,GetBMKID,GetBMMID,TypeAuto):null;
          await Future.delayed(const Duration(milliseconds: 100));
          await SYNC_FAT_INV_SND(TypeSync,List_D[0].GUIDM.toString(),TypeAuto);
          await SyncBIL_MOV_MToSystem_P(TypeSync, GetBMKID,GetBMMID,List_D.length.toString(),TypeAuto,GETBMMST,GetFromDate,GetToDate);
        }
      } catch (e) {
        TypeAuto==true? configloading('StrinError_Sync'.tr):false;
        INSERT_SYN_LOG(GETTAB_N,e.toString(),'U');
        i = List_D.length;
        return Future.error(e);
      }
    }
  }

  //STEP ----3
  Future<void> SyncBIF_MOV_A(String TypeSync, int GetBMKID, String GetBMMID, String BIL_MOV_DList, bool TypeAuto) async {
    // Fetch BIL_MOV_MList asynchronously
    final BIL_MOV_MList = await SyncronizationData().fetchAll_BIF_A(TypeSync, GetBMKID, GetBMMID);

    // Check if the list is not empty
    if (BIL_MOV_MList.isNotEmpty) {
      // Sync the data if the list has items
      await SyncronizationData().SyncBIF_MOV_AToSystem(BIL_MOV_MList, TypeSync, GetBMMID, GetBMKID);
    } else if (TypeAuto) {
      // If no data and TypeAuto is true, show loading message
      configloading("StringNoDataSync".tr);
    }
  }


  Future<void> SyncBIF_EROD_M(String TypeSync, int GetBMKID, String GetBMMID, bool TypeAuto) async {
    // Fetch BIL_MOV_MList asynchronously
    final BIL_MOV_MList = await SyncronizationData().fetchAll_BIF_EORD_M(TypeSync, GetBMKID, GetBMMID);

    // Check if the list is not empty
    if (BIL_MOV_MList.isNotEmpty) {
      // Sync the data if the list has items
      await SyncronizationData().SyncBIF_EORD_MToSystem(BIL_MOV_MList, TypeSync, GetBMMID, GetBMKID);
    } else if (TypeAuto) {
      // If no data and TypeAuto is true, show loading message
      configloading("StringNoDataSync".tr);
    }
  }

  Future SyncBIL_MOV_MToSystem_P(String TypeSync, int GetBMKID,String GetBMMID,String BIL_MOV_DList,bool TypeAuto,
      int GETBMMST,GetFromDate, GetToDate) async {
    // Fetch BIL_MOV_MList asynchronously
    final BIL_MOV_MList = await SyncronizationData().fetchAll_BIL_M(TypeSync, GetBMKID, GetBMMID,GETBMMST,GetFromDate, GetToDate);
    if (BIL_MOV_MList.isNotEmpty ) {
      await SyncronizationData().SyncBIL_MOV_MToSystem(BIL_MOV_MList, TypeSync, GetBMMID, GetBMKID,
          GetBMKID==11 || GetBMKID==12 ||  GetBMKID==-2?'BIF_MOV_M':'BIL_MOV_M',TypeAuto,GETBMMST,GetFromDate, GetToDate);
    }
  }

  //STEP ----4
  Future<List<Bif_Mov_A_Local>> fetchAll_BIF_A(String TypeSync, int GetBMKID, String GetBMMID) async {
    final dbClient = await conn.database;
    List<Bif_Mov_A_Local> contactList = [];
    String SQLBIID_L = LoginController().BIID_ALL_V == '1'
        ? " AND  A.BIID_L=${LoginController().BIID}" :  '';

    String SQL2 = ''' AND A.JTID_L=${LoginController().JTID} AND A.SYID_L=${LoginController().SYID} 
                  AND A.CIID_L=${LoginController().CIID} $SQLBIID_L''';

    try {
      if (TypeSync == "SyncAll") {
        final maps = await dbClient!.query('BIF_MOV_A A',
            where: ' A.BMKID=$GetBMKID $SQL2');
        for (var item in maps) {
          contactList.add(Bif_Mov_A_Local.fromMap(item));
        }
      } else if (TypeSync == "SyncOnly") {
        final maps = await dbClient!.query('BIF_MOV_A',
            where: '  BMMID=$GetBMMID');
        for (var item in maps) {
          contactList.add(Bif_Mov_A_Local.fromMap(item));
        }
      }
    } catch (e) {
      print(e.toString());
    }
    return contactList;
  }

  Future<List<Bif_Eord_M_Local>> fetchAll_BIF_EORD_M(String TypeSync, int GetBMKID, String GetBMMID) async {
    final dbClient = await conn.database;
    List<Bif_Eord_M_Local> contactList = [];
    String SQLBIID_L = LoginController().BIID_ALL_V == '1'
        ? " AND  A.BIID_L=${LoginController().BIID}" :  '';

    String SQL2 = ''' AND A.JTID_L=${LoginController().JTID} AND A.SYID_L=${LoginController().SYID} 
                  AND A.CIID_L=${LoginController().CIID} $SQLBIID_L''';
    try {
      if (TypeSync == "SyncAll") {
        final maps = await dbClient!.query('BIF_EORD_M A',
            where: ' A.BMKID=$GetBMKID $SQL2');
        for (var item in maps) {
          contactList.add(Bif_Eord_M_Local.fromMap(item));
        }
      } else if (TypeSync == "SyncOnly") {
        final maps = await dbClient!.query('BIF_EORD_M', where: '  BMMID=$GetBMMID');
        for (var item in maps) {
          contactList.add(Bif_Eord_M_Local.fromMap(item));
        }
      }
    } catch (e) {
      print(e.toString());
    }
    return contactList;
  }

  Future<List<Bil_Mov_M_Local>> fetchAll_BIL_M(String TypeSync, int GetBMKID, String GetBMMID,GETBMMST,GetFromDate,
      GetToDate) async {
    final dbClient = await conn.database;
    List<Bil_Mov_M_Local> contactList = [];
    String sql='';
    String SQLBIID_L = LoginController().BIID_ALL_V == '1'
        ? " AND  BIID_L=${LoginController().BIID}" :  '';

    String SQL2 = ''' AND JTID_L=${LoginController().JTID} AND SYID_L=${LoginController().SYID} 
                  AND CIID_L=${LoginController().CIID} $SQLBIID_L''';

    String TableNameOnly=GetBMKID==11 || GetBMKID==12?' BIF_MOV_M ':' BIL_MOV_M ';
    String TableNameAll=GetBMKID==11 || GetBMKID==12 ||  GetBMKID==-2 ?'BIF_MOV_M':'BIL_MOV_M';
    String valueAll='';
    String SqlWhere=GetBMKID==-1 || GetBMKID==-2?'':' BMKID=$GetBMKID AND ';
    valueAll=STMID=='EORD'?' BMMFST IN(1,10) ':' BMMST=2 AND BMMFST IN(1,10)';
    try {
      if (TypeSync == "SyncAll") {
        sql='select * from $TableNameAll where  $SqlWhere $valueAll $SQL2';
        final maps = await dbClient!.rawQuery(sql);
        for (var item in maps) {
          contactList.add(Bil_Mov_M_Local.fromMap(item));
        }
      }
      else if (TypeSync == "SyncOnly") {
        sql='select * from $TableNameOnly where BMMID=$GetBMMID AND BMMFST IN(1,10) ';
        final maps = await dbClient!.rawQuery(sql);

        for (var item in maps) {
          contactList.add(Bil_Mov_M_Local.fromMap(item));
        }
      }
      else if (TypeSync == "ByDate") {
        sql="select * from $TableNameOnly where BMMDOR BETWEEN '$GetFromDate' AND '$GetToDate' AND BMMST=$GETBMMST"
            " and BMKID=$GetBMKID AND BMMFST IN(1,10) $SQL2";
        final maps = await dbClient!.rawQuery(sql);
        for (var item in maps) {
          contactList.add(Bil_Mov_M_Local.fromMap(item));
        }
      }
    } catch (e) {
      print(e.toString());
    }
    return contactList;
  }

  //STEP ----5
  Future SyncBIF_MOV_AToSystem(List<Bif_Mov_A_Local> contactList, String TypeSync, String GetBMMID, int GetBMKID)
  async {
    for (var i = 0; i < contactList.length; i++) {
      var data = {
        "BMMID": contactList[i].BMMID.toString(),
        "BMMNO": contactList[i].BMMNO.toString(),
        "BMKID": contactList[i].BMKID.toString(),
        "RSID": contactList[i].RSID.toString(),
        "RTID": contactList[i].RTID.toString(),
        "REID": contactList[i].REID.toString(),
        "BMATY": contactList[i].BMATY.toString(),
        "BDID": contactList[i].BDID.toString(),
        "GUID": contactList[i].GUID.toString(),
        "BMACR": contactList[i].BMACR.toString(),
        "BMACA": contactList[i].BMACA.toString(),
        "BCDID": contactList[i].BCDID.toString(),
        "GUIDR": contactList[i].GUIDR.toString(),
        "BMADD": contactList[i].BMADD.toString(),
        "BMADT": contactList[i].BMADT.toString(),
        "PKIDB": contactList[i].PKIDB.toString(),
        "GUIDP": contactList[i].GUIDP.toString(),
        "GUIDM_L": contactList[i].GUID.toString(),
        "STMID_CO":STMID,
        "SYDV_NAME": LoginController().DeviceName,
        "SYDV_IP": LoginController().IP,
        "SYDV_TY":  LoginController().SYDV_TY,
        "SYDV_SER": LoginController().DeviceID,
        "SYDV_POI":"",
        "SYDV_ID":LoginController().SYDV_ID,
        "SYDV_NO": LoginController().SYDV_NO,
        "SYDV_LATITUDE":"",
        "SYDV_LONGITUDE":"",
        "SYDV_APPV":LoginController().APPV,
      };
      var params = {
        "STMID_CO_V": STMID,
        "SYDV_NAME_V": LoginController().DeviceName,
        "SYDV_IP_V":   LoginController().IP,
        "SYDV_TY_V":   LoginController().SYDV_TY,
        "SYDV_SER_V":  LoginController().DeviceID,
        "SYDV_POI_V":"",
        "SYDV_ID_V":   LoginController().SYDV_ID,
        "SYDV_NO_V":   LoginController().SYDV_NO,
        "SYDV_BRA_V":1,
        "SYDV_LATITUDE_V":"",
        "SYDV_LONGITUDE_V":"",
        "SYDV_APPV_V": LoginController().APPV,
        "SOID_V":"BIF_MOV_AORD",
        "STID_V":"",
        "TBNA_V":'BIF_MOV_A',
        "LAN_V": LoginController().LAN,
        "CIID_V":LoginController().CIID,
        "JTID_V":LoginController().JTID,
        "BIID_V":LoginController().BIID,
        "SYID_V":LoginController().SYID,
        "SUID_V":LoginController().SUID,
        "SUPA_V":LoginController().SUPA,
        "F_ROW_V":'0',
        "T_ROW_V":'0',
        "F_DAT_V": '',
        "T_DAT_V": '',
        "F_GUID_V":"",
        "WH_V1":'',
        "PAR_V":"",
        "JSON_V": data.toString(),
        "JSON_V2":"",
        "JSON_V3":""
      };
      var bodylang = utf8.encode(json.encode(params));
      var body = json.encode(params);
      try {
        final response = await http.post(Uri.parse("${LoginController().API}/ESAPI/ESPOST"),
            body: body,
            headers: {'Transfer-Encoding': 'chunked',
              HttpHeaders.contentTypeHeader: "application/json",
              'Content-Length': bodylang.length.toString(),
            });
        if (response.statusCode == 201 || response.statusCode == 200) {
          INSERT_SYN_LOG('BIL_MOV_A',SLINM,'U');
        } else {
          configloading(response.body);
          Fluttertoast.showToast(
              msg: response.body,
              textColor: Colors.white,
              backgroundColor: Colors.red);
          INSERT_SYN_LOG('BIL_MOV_A',response.body,'U');
        }
      } catch (e) {
        configloading('StrinError_Sync'.tr);
        Fluttertoast.showToast(
            msg: "response error ${e.toString()}",
            textColor: Colors.white,
            backgroundColor: Colors.red);
        INSERT_SYN_LOG('BIL_MOV_A',e.toString(),'U');
        return Future.error(e);
      }
    }
  }

  Future SyncBIF_EORD_MToSystem(List<Bif_Eord_M_Local> contactList, String TypeSync, String GetBMMID, int GetBMKID) async {
    for (var i = 0; i < contactList.length; i++) {
      var data = {
        "BMMID": contactList[i].BMMID.toString(),
        "BMKID": contactList[i].BMKID.toString(),
        "BEMPS": contactList[i].BEMPS.toString(),
        "BEMPCS": contactList[i].BEMPCS.toString(),
        "BEMIPS": contactList[i].BEMIPS.toString(),
        "BEMBS": contactList[i].BEMBS.toString(),
        "SUID": contactList[i].SUID.toString(),
        "DATEI": contactList[i].DATEI.toString(),
        "DEVI": contactList[i].DEVI.toString(),
        "SUCH": contactList[i].SUCH.toString(),
        "DATEU": contactList[i].DATEU.toString(),
        "DEVU": contactList[i].DEVU.toString(),
        "GUID": contactList[i].GUID.toString(),
        "GUIDM_L": contactList[i].GUID.toString(),
        "STMID_CO":STMID,
        "SYDV_NAME": LoginController().DeviceName,
        "SYDV_IP": LoginController().IP,
        "SYDV_TY":  LoginController().SYDV_TY,
        "SYDV_SER": LoginController().DeviceID,
        "SYDV_POI":"",
        "SYDV_ID":LoginController().SYDV_ID,
        "SYDV_NO": LoginController().SYDV_NO,
        "SYDV_LATITUDE":"",
        "SYDV_LONGITUDE":"",
        "SYDV_APPV":LoginController().APPV,
      };
      var params = {
        "STMID_CO_V": STMID,
        "SYDV_NAME_V": LoginController().DeviceName,
        "SYDV_IP_V":   LoginController().IP,
        "SYDV_TY_V":   LoginController().SYDV_TY,
        "SYDV_SER_V":  LoginController().DeviceID,
        "SYDV_POI_V":"",
        "SYDV_ID_V":   LoginController().SYDV_ID,
        "SYDV_NO_V":   LoginController().SYDV_NO,
        "SYDV_BRA_V":1,
        "SYDV_LATITUDE_V":"",
        "SYDV_LONGITUDE_V":"",
        "SYDV_APPV_V": LoginController().APPV,
        "SOID_V":"BIF_EORD_MORD",
        "STID_V":"",
        "TBNA_V":'BIF_EORD_M',
        "LAN_V": LoginController().LAN,
        "CIID_V":LoginController().CIID,
        "JTID_V":LoginController().JTID,
        "BIID_V":LoginController().BIID,
        "SYID_V":LoginController().SYID,
        "SUID_V":LoginController().SUID,
        "SUPA_V":LoginController().SUPA,
        "F_ROW_V":'0',
        "T_ROW_V":'0',
        "F_DAT_V": '',
        "T_DAT_V": '',
        "F_GUID_V":"",
        "WH_V1":'',
        "PAR_V":"",
        "JSON_V": data.toString(),
        "JSON_V2":"",
        "JSON_V3":""
      };
      var bodylang = utf8.encode(json.encode(params));
      var body = json.encode(params);
      try {
        final response = await http.post(Uri.parse("${LoginController().API}/ESAPI/ESPOST"),
            body: body,
            headers: {'Transfer-Encoding': 'chunked',
              HttpHeaders.contentTypeHeader: "application/json",
              'Content-Length': bodylang.length.toString(),
            });
        if (response.statusCode == 201 || response.statusCode == 200) {
          INSERT_SYN_LOG('BIF_EORD_M',SLINM,'U');
        } else {
          configloading(response.body);
          Fluttertoast.showToast(
              msg: response.body,
              textColor: Colors.white,
              backgroundColor: Colors.red);
          INSERT_SYN_LOG('BIF_EORD_M',response.body,'U');
        }
      } catch (e) {
        configloading('StrinError_Sync'.tr);
        Fluttertoast.showToast(
            msg: "response error ${e.toString()}",
            textColor: Colors.white,
            backgroundColor: Colors.red);
        INSERT_SYN_LOG('BIF_EORD_M',e.toString(),'U');
        return Future.error(e);
      }
    }
  }

  Future SyncBIL_MOV_MToSystem(List<Bil_Mov_M_Local> contactList,String TypeSync,String GetBMMID,
      int GetBMKID,String TypeTable,bool TypeAuto,GETBMMST,GetFromDate, GetToDate) async {
    for (var i = 0; i < contactList.length; i++) {
      String BMMIN_COU='${contactList[i].BMMIN.toString()} '
          '${contactList[i].BMMDR.toString().isEmpty || contactList[i].BMMDR.toString()=='' ?' ' : '  السائق:${contactList[i].BMMDR.toString()} '}'
          '${contactList[i].BMMCRT.toString().isEmpty || contactList[i].BMMCRT.toString()=='' ?'' : ' - السياره: ${contactList[i].BMMCRT.toString()} '}'
          '${contactList[i].BMMTN.toString().isEmpty || contactList[i].BMMTN.toString()=='' ?'' : ' - رقم السياره: ${contactList[i].BMMTN.toString()} '}';

      var data = {
        "BMMID": contactList[i].BMMID.toString(),
        "BMMNO": contactList[i].BMMNO.toString(),
        "BMKID": contactList[i].BMKID.toString(),
        "BMMDO": contactList[i].BMMDO.toString(),
        "BMMST": contactList[i].BMMST.toString(),
        "BMMST2": contactList[i].BMMST2.toString(),
        "BMMIN": LoginController().IncludeAdditionalSyncing==true ? BMMIN_COU : contactList[i].BMMIN.toString(),
        "BIID": contactList[i].BIID.toString(),
        "SIID": contactList[i].SIID.toString(),
        "SCID": contactList[i].SCID.toString(),
        "PKID": contactList[i].PKID.toString(),
        "BCID": contactList[i].BCID.toString(),
        "BDID": contactList[i].BDID.toString(),
        "BMMNA": contactList[i].BMMNA.toString(),
        "BPID": contactList[i].BPID.toString(),
        "AANO": contactList[i].AANO.toString(),
        "BMMTX": contactList[i].BMMTX.toString(),
        "BMMTX1": contactList[i].BMMTX1.toString(),
        "BMMTX2": contactList[i].BMMTX2.toString(),
        "BMMTX3": contactList[i].BMMTX3.toString(),
        "TTID1": contactList[i].TTID1.toString(),
        "TTID2": contactList[i].TTID2.toString(),
        "TTID3": contactList[i].TTID3.toString(),
        "BMMAM": contactList[i].BMMAM.toString(),
        "SCEX": contactList[i].SCEX.toString(),
        "BMMRE": contactList[i].BMMRE.toString(),
        "SCEXS": contactList[i].SCEXS.toString(),
        "BMMDI": contactList[i].BMMDI.toString(),
        "BMMDIA": contactList[i].BMMDIA.toString(),
        "BMMDIF": contactList[i].BMMDIF.toString(),
        "BMMDN": contactList[i].BMMDN.toString(),
        "BMMDIA2": contactList[i].BMMDIA2.toString(),
        "BMMDIR2": contactList[i].BMMDIR2.toString(),
        "BMMDIR":contactList[i].BMMDIR.toString(),
        "BIIDB":contactList[i].BIIDB.toString(),
        "BMMIS":contactList[i].BMMIS.toString(),
        "BMMEQ":contactList[i].BMMEQ.toString(),
        "BMMCD":contactList[i].BMMCD.toString(),
        "BMMCR":contactList[i].BMMCR.toString(),
        "BMMPT":contactList[i].BMMPT.toString(),
        "BMMDT":contactList[i].BMMDT.toString(),
        "BMMCA":contactList[i].BMMCA.toString(),
        "BMMTXD":contactList[i].BMMTXD.toString(),
        "GUIDC": contactList[i].GUIDC.toString(),
        "GUID_LNK": contactList[i].GUID_LNK.toString(),
        "BMMNOR": contactList[i].BMMNOR.toString(),
        "BMMIDR": contactList[i].BMMIDR.toString(),
        "BCCID": contactList[i].BCCID.toString(),
        "BMMBR": contactList[i].BMMBR.toString(),
        "BMMWE": contactList[i].BMMWE.toString(),
        "BMMVO": contactList[i].BMMVO.toString(),
        "BMMVC": contactList[i].BMMVC.toString(),
        "BCDID": contactList[i].BCDID.toString(),
        "BCDMO": contactList[i].BCDMO.toString(),
        "GUIDC2": contactList[i].GUIDC2.toString(),
        "SUID": contactList[i].SUID.toString(),
        "DATEI": contactList[i].DATEI.toString(),
        "DEVI": contactList[i].DEVI.toString(),
        "SUCH": contactList[i].SUCH.toString(),
        "DATEU": contactList[i].DATEU.toString(),
        "DEVU": contactList[i].DEVU.toString(),
        "GUID": contactList[i].GUID.toString(),
        "BMMTX_DAT": contactList[i].BMMTX_DAT.toString(),
        "BMMFST": contactList[i].BMMFST.toString(),
        "BMMFQR": contactList[i].BMMFQR.toString(),
        "BMMFIC": contactList[i].BMMFIC.toString(),
        "BMMFUU": contactList[i].BMMFUU.toString(),
        "BMMFNO": contactList[i].BMMFNO.toString(),
        "CTMID": contactList[i].CTMID.toString(),
        "CIMID": contactList[i].CIMID.toString(),
        // "BMMDR": contactList[i].BMMDR.toString(),
        // "BMMCRT": contactList[i].BMMCRT.toString(),
        // "BMMTN": contactList[i].BMMTN.toString(),
        "ROWN1": contactList[i].BMMNR.toString(),
        "ROWN2":1,
        "ROWN3":1,
        "STMID_CO":STMID,
        "SYDV_NAME": LoginController().DeviceName,
        "SYDV_IP": LoginController().IP,
        "SYDV_TY":  LoginController().SYDV_TY,
        "SYDV_SER": LoginController().DeviceID,
        "SYDV_POI":"",
        "SYDV_ID":LoginController().SYDV_ID,
        "SYDV_NO": LoginController().SYDV_NO,
        "SYDV_LATITUDE":"",
        "SYDV_LONGITUDE":"",
        "SYDV_APPV":LoginController().APPV,
      };
      var data2 = {
        "BMMID": contactList[i].BMMID.toString(),
        "BMMNO": contactList[i].BMMNO.toString(),
        "BMKID": contactList[i].BMKID.toString(),
        "BMMDO": contactList[i].BMMDO.toString(),
        "BMMST": contactList[i].BMMST.toString(),
        "BMMST2": contactList[i].BMMST2.toString(),
        "ROWN1": contactList[i].BMMNR.toString(),
        "BMMDR": contactList[i].BMMDR.toString(),
        "ROWN2": 1,
        "BMMIN": LoginController().IncludeAdditionalSyncing==true ? BMMIN_COU : contactList[i].BMMIN.toString(),
        "BIID": contactList[i].BIID.toString(),
        "SIID": contactList[i].SIID.toString(),
        "SCID": contactList[i].SCID.toString(),
        "PKID": contactList[i].PKID.toString(),
        "BCID": contactList[i].BCID.toString(),
        "BMMNA": contactList[i].BMMNA.toString(),
        "AANO": contactList[i].AANO.toString(),
        "BMMTX": contactList[i].BMMTX.toString(),
        "BMMTX1": contactList[i].BMMTX1.toString(),
        "BMMTX2": contactList[i].BMMTX2.toString(),
        "BMMTX3": contactList[i].BMMTX3.toString(),
        "TTID1": contactList[i].TTID1.toString(),
        "TTID2": contactList[i].TTID2.toString(),
        "TTID3": contactList[i].TTID3.toString(),
        "BMMAM": contactList[i].BMMAM.toString(),
        "SCEX": contactList[i].SCEX.toString(),
        "ACID": contactList[i].ACID.toString(),
        "ABID": contactList[i].ABID.toString(),
        "BDID": contactList[i].BDID.toString(),
        "BPID": contactList[i].BPID.toString(),
        "BIID2": contactList[i].BIID2.toString(),
        "BMMCN": contactList[i].BMMCN.toString(),
        "BMMRE": contactList[i].BMMRE.toString(),
        "SCEXS": contactList[i].SCEXS.toString(),
        "BMMDI": contactList[i].BMMDI.toString(),
        "BMMDIA": contactList[i].BMMDIA.toString(),
        "BMMDIF": contactList[i].BMMDIF.toString(),
        "BMMDN": contactList[i].BMMDN.toString(),
        "BMMDIA2": contactList[i].BMMDIA2.toString(),
        "BMMDIR2": contactList[i].BMMDIR2.toString(),
        "BMMDIR":contactList[i].BMMDIR.toString(),
        "BIIDB":contactList[i].BIIDB.toString(),
        "BMMIS":contactList[i].BMMIS.toString(),
        "BMMEQ":contactList[i].BMMEQ.toString(),
        "BMMCD":contactList[i].BMMCD.toString(),
        "BMMCT":contactList[i].BMMCT.toString(),
        "BMMCR":contactList[i].BMMCR.toString(),
        "BMMPT":contactList[i].BMMPT.toString(),
        "BMMDT":contactList[i].BMMDT.toString(),
        "BMMCA":contactList[i].BMMCA.toString(),
        "BMMTXD":contactList[i].BMMTXD.toString(),
        "GUIDC": contactList[i].GUIDC.toString(),
        "GUID_LNK": contactList[i].GUID_LNK.toString(),
        "BMMNOR": contactList[i].BMMNOR.toString(),
        "BMMIDR": contactList[i].BMMIDR.toString(),
        "BCCID": contactList[i].BCCID.toString(),
        "BMMDD": contactList[i].BMMDD.toString(),
        "BMMBR": contactList[i].BMMBR.toString(),
        "BMMWE": contactList[i].BMMWE.toString(),
        "BMMVO": contactList[i].BMMVO.toString(),
        "BMMVC": contactList[i].BMMVC.toString(),
        "ACNO": contactList[i].ACNO.toString(),
        "ACNO2": contactList[i].ACNO2.toString(),
        "BMMDA": contactList[i].BMMDA.toString(),
        "ATTID": contactList[i].ATTID.toString(),
        "BMMTX_DAT": contactList[i].BMMTX_DAT.toString(),
        "SUID": contactList[i].SUID.toString(),
        "DATEI": contactList[i].DATEI.toString(),
        "DEVI": contactList[i].DEVI.toString(),
        "SUCH": contactList[i].SUCH.toString(),
        "DATEU": contactList[i].DATEU.toString(),
        "DEVU": contactList[i].DEVU.toString(),
        "GUID": contactList[i].GUID.toString(),
        "BMMGR": contactList[i].BMMGR.toString(),
        "BMMDE": contactList[i].BMMDE.toString(),
        "BMMFST": contactList[i].BMMFST.toString(),
        "BMMFQR": contactList[i].BMMFQR.toString(),
        "BMMFIC": contactList[i].BMMFIC.toString(),
        "BMMFUU": contactList[i].BMMFUU.toString(),
        "BMMFNO": contactList[i].BMMFNO.toString(),
        "STMID_CO":STMID,
        "SYDV_NAME": LoginController().DeviceName,
        "SYDV_IP": LoginController().IP,
        "SYDV_TY":  LoginController().SYDV_TY,
        "SYDV_SER": LoginController().DeviceID,
        "SYDV_POI":"",
        "SYDV_ID":LoginController().SYDV_ID,
        "SYDV_NO": LoginController().SYDV_NO,
        "SYDV_LATITUDE":"",
        "SYDV_LONGITUDE":"",
        "SYDV_APPV":LoginController().APPV,
      };
      var params = {
        "STMID_CO_V": STMID,
        "SYDV_NAME_V": LoginController().DeviceName,
        "SYDV_IP_V":   LoginController().IP,
        "SYDV_TY_V":   LoginController().SYDV_TY,
        "SYDV_SER_V":  LoginController().DeviceID,
        "SYDV_POI_V":"",
        "SYDV_ID_V":   LoginController().SYDV_ID,
        "SYDV_NO_V":   LoginController().SYDV_NO,
        "SYDV_BRA_V":1,
        "SYDV_LATITUDE_V":"",
        "SYDV_LONGITUDE_V":"",
        "SYDV_APPV_V": LoginController().APPV,
        "SOID_V":STMID=='EORD'? 'BIF_MOV_MORD':STMID=='COU'? 'BIF_MOV_MC':
        contactList[i].BMKID==11 ? "BIF_MOV_MO" : contactList[i].BMKID==12 ? "BIF_MOV_MOR":
        contactList[i].BMKID==3?"BIL_MOV_MO":contactList[i].BMKID==4?
        "BIL_MOV_MOR":contactList[i].BMKID==5?"BIL_MOV_MOS":contactList[i].BMKID==7?"BIL_MOV_MQ":
        contactList[i].BMKID==10?"BIL_MOV_MCR": contactList[i].BMKID==2?"BIL_MOV_MIR": "BIL_MOV_MI",
        "STID_V":"",
        "TBNA_V": contactList[i].BMKID==11 ||  contactList[i].BMKID==12? 'BIF_MOV_M':'BIL_MOV_M',
        "LAN_V": LoginController().LAN,
        "CIID_V":LoginController().CIID,
        "JTID_V":LoginController().JTID,
        "BIID_V":LoginController().BIID,
        "SYID_V":LoginController().SYID,
        "SUID_V":LoginController().SUID,
        "SUPA_V":LoginController().SUPA,
        "F_ROW_V":'0',
        "T_ROW_V":'0',
        "F_DAT_V": '',
        "T_DAT_V": '',
        "F_GUID_V":"",
        "WH_V1":'',
        "PAR_V":"",
        "JSON_V": contactList[i].BMKID==11 || contactList[i].BMKID==12 ?
        data.toString():data2.toString(),
        "JSON_V2":"",
        "JSON_V3":""
      };
      print('STEP----66');
      var bodylang = utf8.encode(json.encode(params));
      var body = json.encode(params);
      try {
        final response = await http.post(Uri.parse("${LoginController().API}/ESAPI/ESPOST"),
              body: body, headers: {'Transfer-Encoding': 'chunked',
              HttpHeaders.contentTypeHeader: "application/json",
              'Content-Length': bodylang.length.toString(),
            });

        if (response.statusCode == 201 || response.statusCode == 200) {
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
          TypeAuto==true?EasyLoading.showSuccess('StringSuccessfullySync'.tr):false;
          print('STEP----6');
          STMID=='EORD'? UpdateStateBIF_MOV_D_ORDER(TypeSync, contactList[i].BMKID!, GetBMMID):
          UpdateStateBIL_MOV_D(TypeSync, contactList[i].BMKID.toString(), GetBMMID, 1,
              TypeTable=='BIF_MOV_M'?'BIF_MOV_D':'BIL_MOV_D',GETBMMST,GetFromDate, GetToDate);
          UpdateStateBIF_MOV_M(GETBMMST.toString(),TypeSync, GetBMKID, GetBMMID,TypeTable,GetFromDate, GetToDate);
          INSERT_SYN_LOG(GetBMKID==11 || GetBMKID==12?'BIF_MOV_M':'BIL_MOV_M','${SLINM} ${contactList[i].BMMID.toString()}','U');
          // GET_SYN_DAT_P();
        }
        else {
          TypeAuto==true? configloading(response.body):false;
          INSERT_SYN_LOG(TypeTable,'${response.body} ${contactList[i].BMMID.toString()}','U');
        }
      } catch (e) {
        TypeAuto==true? configloading(e.toString()):false;
        INSERT_SYN_LOG(TypeTable,'${e.toString()} ${contactList[i].BMMID.toString()}','U');
        return Future.error(e);
      }
    }
  }


//الفواتير------------------------------


//الضريبة------------------------------


  //STEP ----1
  Future<List<Fat_Inv_Snd_Local>> fetchAll_FAT_INV_SND(TypeSync,BMMGU) async {
    final dbClient = await conn.database;
    List<Fat_Inv_Snd_Local> List_D = [];
    String SQLBIID_L = LoginController().BIID_ALL_V == '1'
        ? " AND  BIID_L=${LoginController().BIID}" :  '';

    String SQL2 = ''' AND JTID_L=${LoginController().JTID} AND SYID_L=${LoginController().SYID} 
                  AND CIID_L=${LoginController().CIID} $SQLBIID_L''';
    try {
      if (TypeSync == "SyncAll") {
        final maps = await dbClient!.query('FAT_INV_SND', where: 'FISFS=2 $SQL2');
        for (var item in maps) {
          List_D.add(Fat_Inv_Snd_Local.fromMap(item));
        }
      }
      else if (TypeSync == "SyncOnly") {
       var sql="select * from FAT_INV_SND where BMMGU='$BMMGU'";
        final maps = await dbClient!.rawQuery(sql);
        print('maps');
        print(sql);
        print(maps);
        for (var item in maps) {
          List_D.add(Fat_Inv_Snd_Local.fromMap(item));
        }
      }
    } catch (e,stackTrace) {
      print(stackTrace);
      print(e.toString());
    }
    print('fetchAll_FAT_INV_SND');
    print(List_D);
    return List_D;
  }

  Future<List<Fat_Inv_Snd_D_Local>> fetchAll_FAT_INV_SND_D(TypeSync,FISGU) async {
    final dbClient = await conn.database;
    List<Fat_Inv_Snd_D_Local> List_D = [];
    String SQLBIID_L = LoginController().BIID_ALL_V == '1'
        ? " AND  BIID_L=${LoginController().BIID}" :  '';

    String SQL2 = ''' AND JTID_L=${LoginController().JTID} AND SYID_L=${LoginController().SYID} 
                  AND CIID_L=${LoginController().CIID} $SQLBIID_L''';

    try {
      if (TypeSync == "SyncAll") {
        final maps = await dbClient!.query('FAT_INV_SND_D', where: 'FISDFS=2 $SQL2');
        for (var item in maps) {
          List_D.add(Fat_Inv_Snd_D_Local.fromMap(item));
        }
      }
      else if (TypeSync == "SyncOnly") {
       var sql="select * from FAT_INV_SND_D where FISGU='$FISGU'";
        final maps = await dbClient!.rawQuery(sql);
        print('maps');
        print(sql);
        print(maps);
        for (var item in maps) {
          List_D.add(Fat_Inv_Snd_D_Local.fromMap(item));
        }
      }
    } catch (e,stackTrace) {
      print(stackTrace);
      print(e.toString());
    }
    print('fetchAll_FAT_INV_SND_D');
    print(List_D);
    return List_D;
  }

  Future<List<Fat_Inv_Snd_R_Local>> fetchAll_FAT_INV_SND_R(TypeSync,FISGU) async {
    final dbClient = await conn.database;
    List<Fat_Inv_Snd_R_Local> List_D = [];
    String SQLBIID_L = LoginController().BIID_ALL_V == '1'
        ? " AND  BIID_L=${LoginController().BIID}" :  '';

    String SQL2 = ''' AND JTID_L=${LoginController().JTID} AND SYID_L=${LoginController().SYID} 
                  AND CIID_L=${LoginController().CIID} $SQLBIID_L''';
    try {
      if (TypeSync == "SyncAll") {
        final maps = await dbClient!.query('FAT_INV_SND_R', where: 'FISRFS=2 $SQL2');
        for (var item in maps) {
          List_D.add(Fat_Inv_Snd_R_Local.fromMap(item));
        }
      }
      else if (TypeSync == "SyncOnly") {
       var sql="select * from FAT_INV_SND_R where FISGU='$FISGU'";
        final maps = await dbClient!.rawQuery(sql);
        print('maps');
        print(sql);
        print(maps);
        for (var item in maps) {
          List_D.add(Fat_Inv_Snd_R_Local.fromMap(item));
        }
      }
    } catch (e,stackTrace) {
      print(stackTrace);
      print(e.toString());
    }
    print('fetchAll_FAT_INV_SND_R');
    print(List_D);
    return List_D;
  }

  Future<List<Fat_Inv_Rs_Local>> fetchAll_FAT_INV_RS(TypeSync,BMMGU) async {
    final dbClient = await conn.database;
    List<Fat_Inv_Rs_Local> List_D = [];
    String SQLBIID_L = LoginController().BIID_ALL_V == '1'
        ? " AND  BIID_L=${LoginController().BIID}" :  '';

    String SQL2 = ''' AND JTID_L=${LoginController().JTID} AND SYID_L=${LoginController().SYID} 
                  AND CIID_L=${LoginController().CIID} $SQLBIID_L''';
    try {
      if (TypeSync == "SyncAll") {
        var sql="select * from FAT_INV_RS where FIRFS=2 $SQL2  ";
        final maps = await dbClient!.rawQuery(sql);
        for (var item in maps) {
          List_D.add(Fat_Inv_Rs_Local.fromMap(item));
        }
      }
      else if (TypeSync == "SyncOnly") {
        var sql="select * from FAT_INV_RS where BMMGU='$BMMGU'  ";
        final maps = await dbClient!.rawQuery(sql);
        print(sql);
        for (var item in maps) {
          List_D.add(Fat_Inv_Rs_Local.fromMap(item));
        }
      }
    } catch (e) {
      print(e.toString());
    }
    return List_D;
  }

  Future<List<Fat_Snd_Log_Local>> fetchAll_FAT_SND_LOG(TypeSync,BMMGU) async {
    final dbClient = await conn.database;
    List<Fat_Snd_Log_Local> List_D = [];
    String SQLBIID_L = LoginController().BIID_ALL_V == '1'
        ? " AND  BIID_L=${LoginController().BIID}" :  '';

    String SQL2 = ''' AND JTID_L=${LoginController().JTID} AND SYID_L=${LoginController().SYID} 
                  AND CIID_L=${LoginController().CIID} $SQLBIID_L''';
    try {
      if (TypeSync == "SyncAll") {
        var sql="select * from FAT_SND_LOG where FSLFS=2 $SQL2";
        final maps = await dbClient!.rawQuery(sql);
        for (var item in maps) {
          List_D.add(Fat_Snd_Log_Local.fromMap(item));
        }
      }
      else if (TypeSync == "SyncOnly") {
        var sql="select * from FAT_SND_LOG where  BMMGU='$BMMGU' ";
        final maps = await dbClient!.rawQuery(sql);
        print(sql);
        for (var item in maps) {
          List_D.add(Fat_Snd_Log_Local.fromMap(item));
        }
      }
    } catch (e) {
      print(e.toString());
    }
    return List_D;
  }

  Future<List<Fat_Snd_Log_D_Local>> fetchAll_FAT_SND_LOG_D(TypeSync,FSLGU) async {
    final dbClient = await conn.database;
    List<Fat_Snd_Log_D_Local> List_D = [];
    String SQLBIID_L = LoginController().BIID_ALL_V == '1'
        ? " AND  BIID_L=${LoginController().BIID}" :  '';

    String SQL2 = ''' AND JTID_L=${LoginController().JTID} AND SYID_L=${LoginController().SYID} 
                  AND CIID_L=${LoginController().CIID} $SQLBIID_L''';
    try {
      if (TypeSync == "SyncAll") {
        var sql="select * from FAT_SND_LOG_D where  FSLDFS=2 $SQL2";
        final maps = await dbClient!.rawQuery(sql);
        for (var item in maps) {
          List_D.add(Fat_Snd_Log_D_Local.fromMap(item));
        }
      }
      else if (TypeSync == "SyncOnly") {
        var sql="select * from FAT_SND_LOG_D where  FSLGU='$FSLGU'  ";
        final maps = await dbClient!.rawQuery(sql);
        print(sql);
        for (var item in maps) {
          List_D.add(Fat_Snd_Log_D_Local.fromMap(item));
        }
      }
    } catch (e) {
      print(e.toString());
    }
    return List_D;
  }

  Future<List<Fat_Csid_Seq_Local>> fetchAll_FAT_CSID_SEQ(TypeSync,FCIGU) async {
    final dbClient = await conn.database;
    List<Fat_Csid_Seq_Local> List_D = [];
    String SQLBIID_L = LoginController().BIID_ALL_V == '1'
        ? " AND  BIID_L=${LoginController().BIID}" :  '';

    String SQL2 = ''' AND JTID_L=${LoginController().JTID} AND SYID_L=${LoginController().SYID} 
                  AND CIID_L=${LoginController().CIID} $SQLBIID_L''';
    try {
      if (TypeSync == "SyncAll") {
        var sql="select * from FAT_CSID_SEQ where FCSFS=2 $SQL2 ";
        final maps = await dbClient!.rawQuery(sql);
        for (var item in maps) {
          List_D.add(Fat_Csid_Seq_Local.fromMap(item));
        }
      }
      else if (TypeSync == "SyncOnly") {
        var sql="select * from FAT_CSID_SEQ where FCIGU='$FCIGU'  ";
        final maps = await dbClient!.rawQuery(sql);
        for (var item in maps) {
          List_D.add(Fat_Csid_Seq_Local.fromMap(item));
        }
      }
    } catch (e) {
      print(e.toString());
    }
    return List_D;
  }

  Future<List<Fat_Csid_Seq_Local>> fetchAll_FAT_INV_SND_ST(TypeSync,FCIGU) async {
    final dbClient = await conn.database;
    List<Fat_Csid_Seq_Local> List_D = [];
    String SQLBIID_L = LoginController().BIID_ALL_V == '1'
        ? " AND  BIID_L=${LoginController().BIID}" :  '';

    String SQL2 = ''' AND JTID_L=${LoginController().JTID} AND SYID_L=${LoginController().SYID} 
                  AND CIID_L=${LoginController().CIID} $SQLBIID_L''';
    try {
      if (TypeSync == "SyncAll") {
        var sql="select * from FAT_INV_SND_ST where SYST=2 $SQL2 ";
        final maps = await dbClient!.rawQuery(sql);
        for (var item in maps) {
          List_D.add(Fat_Csid_Seq_Local.fromMap(item));
        }
      }
      else if (TypeSync == "SyncOnly") {
        var sql="select * from FAT_INV_SND_ST where FCIGU='$FCIGU'  ";
        final maps = await dbClient!.rawQuery(sql);
        for (var item in maps) {
          List_D.add(Fat_Csid_Seq_Local.fromMap(item));
        }
      }
    } catch (e) {
      print(e.toString());
    }
    return List_D;
  }

  //STEP ----2
  Future SyncFAT_INV_SNDToSystem(List<Fat_Inv_Snd_Local> List_D,String TypeSync,bool TypeAuto) async {
    for (var i = 0; i < List_D.length; i++) {
      var data    =    {
        "FISSEQ":List_D[i].FISSEQ.toString(),
        "FISGU": List_D[i].FISGU.toString(),
        "FCIGU": List_D[i].FCIGU.toString(),
        "CIIDL": List_D[i].CIIDL.toString(),
        "JTIDL": List_D[i].JTIDL.toString(),
        "BIIDL": List_D[i].BIIDL.toString(),
        "SYIDL": List_D[i].SYIDL.toString(),
        "SCHNA": List_D[i].SCHNA.toString(),
        "UUID": List_D[i].UUID.toString(),
        "STID": List_D[i].STID.toString(),
        "BMMGU": List_D[i].BMMGU.toString(),
        "FISSI": List_D[i].FISSI.toString(),
        "FISST": List_D[i].FISST.toString(),
        "FISICV": List_D[i].FISICV.toString(),
        "FISPIN": List_D[i].FISPIN.toString(),
        "FISPGU": List_D[i].FISPGU.toString(),
        "FISPIH": List_D[i].FISPIH.toString(),
        "FISIH": List_D[i].FISIH.toString(),
        "FISQR": List_D[i].FISQR.toString(),
        "FISZHS": List_D[i].FISZHS.toString(),
        "FISZHSO": List_D[i].FISZHSO.toString(),
        "FISZS": List_D[i].FISZS.toString(),
        "FISIS": List_D[i].FISIS.toString(),
        "FISINF": List_D[i].FISINF.toString(),
        "FISWE": List_D[i].FISWE.toString(),
        "FISEE": List_D[i].FISEE.toString(),
        "FISXML": List_D[i].FISXML.toString(),
        "FISTOT": List_D[i].FISTOT.toString(),
        "FISSUM": List_D[i].FISSUM.toString(),
        "FISTWV": List_D[i].FISTWV.toString(),
        "FISSD": List_D[i].FISSD.toString(),
        "FISLSD": List_D[i].FISLSD.toString(),
        "FISNS": List_D[i].FISNS.toString(),
        "SOMGU": List_D[i].SOMGU.toString(),
        "SYDV_APPV": List_D[i].SYDV_APPV.toString(),
        "SMID": List_D[i].SMID.toString(),
        "SUID": List_D[i].SUID.toString(),
        "DATEI": List_D[i].DATEI.toString(),
        "DEVI": List_D[i].DEVI.toString(),
        "STMIDI": List_D[i].STMIDI.toString(),
        "SOMIDI": List_D[i].SOMIDI.toString(),
        "SUCH": List_D[i].SUCH.toString(),
        "DATEU": List_D[i].DATEU.toString(),
        "DEVU": List_D[i].DEVU.toString(),
        "STMIDU": List_D[i].STMIDU.toString(),
        "SOMIDU": List_D[i].SOMIDU.toString(),
        "FISSTO": List_D[i].FISSTO.toString(),
        "FISINO": List_D[i].FISINO.toString(),
        "FISXE": List_D[i].FISXE.toString(),
        "FISXN": List_D[i].FISXN.toString(),
        "FISXNA": List_D[i].FISXNA.toString(),
        "STMID_CO":STMID,
        "SYDV_NAME": LoginController().DeviceName,
        "SYDV_TY":  LoginController().SYDV_TY,
        "SYDV_SER": LoginController().DeviceID,
        "SYDV_POI":"",
        "SYDV_ID_V":LoginController().SYDV_ID_V,
        "SYDV_NO_V":LoginController().SYDV_NO_V,
        "SYDV_BRA_N":1,
        "SYDV_LATITUDE":"",
        "SYDV_LONGITUDE":"",
        "SYDV_APPV_V":LoginController().APPV,
      };
      var params2 =    {
        "STMID_CO_V": STMID,
        "SYDV_NAME_V": LoginController().DeviceName,
        "SYDV_IP_V":   LoginController().IP,
        "SYDV_TY_V":   LoginController().SYDV_TY,
        "SYDV_SER_V":  LoginController().DeviceID,
        "SYDV_POI_V":"",
        "SYDV_ID_V":   LoginController().SYDV_ID,
        "SYDV_NO_V":   LoginController().SYDV_NO,
        "SYDV_BRA_V":1,
        "SYDV_LATITUDE_V":"",
        "SYDV_LONGITUDE_V":"",
        "SYDV_APPV_V": LoginController().APPV,
        "SOID_V": "FAT_INV_SND",
        "STID_V":"",
        "TBNA_V":"FAT_INV_SND",
        "LAN_V": LoginController().LAN,
        "CIID_V":LoginController().CIID,
        "JTID_V":LoginController().JTID,
        "BIID_V":LoginController().BIID,
        "SYID_V":LoginController().SYID,
        "SUID_V":LoginController().SUID,
        "SUPA_V":LoginController().SUPA,
        "F_ROW_V":'0',
        "T_ROW_V":'0',
        "F_DAT_V": '',
        "T_DAT_V": '',
        "F_GUID_V":"",
        "WH_V1":'',
        "PAR_V":"",
        "JSON_V": json.encode(data),
        "JSON_V2":"",
        "JSON_V3":""
      };
      print('SyncFAT_INV_SNDToSystem');
      print(data.toString());
      var bodylang = utf8.encode(json.encode(params2));
      var body = json.encode(params2);
      try {
        final response = await http.post(
            Uri.parse("${LoginController().API}/ESAPI/ESPOST"), body: body,
            headers: {'Transfer-Encoding': 'chunked',
              HttpHeaders.contentTypeHeader: "application/json",
              'Content-Length': bodylang.length.toString(),
            });
        if (response.statusCode == 201 || response.statusCode == 200) {
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
            ..userInteractions = TypeSync=='ByDate'?false:true
            ..dismissOnTap = false;
          TypeAuto==true?EasyLoading.show(status:  "الفواتير المرسلة لمنصة فاتورة ${'StringWeAreSync'.tr}..${i+1}..${List_D.length}"):false;
          UPDATE_FAT("FAT_INV_SND",List_D[i].FISGU.toString());
          INSERT_SYN_LOG("FAT_INV_SND", '${SLIND} ${List_D[i].FISSEQ}-${List_D[i].FISSEQ}', 'U');
        } else {
          configloading('StrinError_Sync'.tr);
          INSERT_SYN_LOG("FAT_INV_SND",'${response.body} ${List_D[i].FISSEQ.toString()}-${List_D[i].FISSEQ.toString()}','U');
          break;
        }
      } catch (e) {
        INSERT_SYN_LOG("FAT_INV_SND",e.toString(),'U');
        i = List_D.length;
        return Future.error(e);
      }
    }
  }
  Future SyncFAT_INV_SND_DToSystem(List<Fat_Inv_Snd_D_Local> List_D,String TypeSync,bool TypeAuto) async {
    for (var i = 0; i < List_D.length; i++) {
      var data    =    {
        "FISDGU":List_D[i].FISDGU.toString(),
        "FISGU": List_D[i].FISGU.toString(),
        "FISDTY": List_D[i].FISDTY.toString(),
        "FISDDA": List_D[i].FISDDA.toString(),
        "STMID_CO":STMID,
        "SYDV_NAME": LoginController().DeviceName,
        "SYDV_TY":  LoginController().SYDV_TY,
        "SYDV_SER": LoginController().DeviceID,
        "SYDV_POI":"",
        "SYDV_ID_V":LoginController().SYDV_ID_V,
        "SYDV_NO_V":LoginController().SYDV_NO_V,
        "SYDV_BRA_N":1,
        "SYDV_LATITUDE":"",
        "SYDV_LONGITUDE":"",
        "SYDV_APPV_V":LoginController().APPV,
      };
      var params2 =    {
        "STMID_CO_V": STMID,
        "SYDV_NAME_V": LoginController().DeviceName,
        "SYDV_IP_V":   LoginController().IP,
        "SYDV_TY_V":   LoginController().SYDV_TY,
        "SYDV_SER_V":  LoginController().DeviceID,
        "SYDV_POI_V":"",
        "SYDV_ID_V":   LoginController().SYDV_ID,
        "SYDV_NO_V":   LoginController().SYDV_NO,
        "SYDV_BRA_V":1,
        "SYDV_LATITUDE_V":"",
        "SYDV_LONGITUDE_V":"",
        "SYDV_APPV_V": LoginController().APPV,
        "SOID_V": "FAT_INV_SND_D",
        "STID_V":"",
        "TBNA_V":"FAT_INV_SND_D",
        "LAN_V": LoginController().LAN,
        "CIID_V":LoginController().CIID,
        "JTID_V":LoginController().JTID,
        "BIID_V":LoginController().BIID,
        "SYID_V":LoginController().SYID,
        "SUID_V":LoginController().SUID,
        "SUPA_V":LoginController().SUPA,
        "F_ROW_V":'0',
        "T_ROW_V":'0',
        "F_DAT_V": '',
        "T_DAT_V": '',
        "F_GUID_V":"",
        "WH_V1":'',
        "PAR_V":"",
        "JSON_V": json.encode(data),
        "JSON_V2":"",
        "JSON_V3":""
      };
      print('SyncFAT_INV_SND_DToSystem');
      print(data.toString());
      var bodylang = utf8.encode(json.encode(params2));
      var body = json.encode(params2);
      try {
        final response = await http.post(
            Uri.parse("${LoginController().API}/ESAPI/ESPOST"), body: body,
            headers: {'Transfer-Encoding': 'chunked',
              HttpHeaders.contentTypeHeader: "application/json",
              'Content-Length': bodylang.length.toString(),
            });
        if (response.statusCode == 201 || response.statusCode == 200) {
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
            ..userInteractions = TypeSync=='ByDate'?false:true
            ..dismissOnTap = false;
          TypeAuto==true?EasyLoading.show(status:  "الفواتير المرسلة لمنصة فاتورة ${'StringWeAreSync'.tr}..${i+1}..${List_D.length}"):false;
          UPDATE_FAT("FAT_INV_SND_D",List_D[i].FISGU.toString());
          INSERT_SYN_LOG("FAT_INV_SND_D", '${SLIND} ${List_D[i].FISDGU}', 'U');
        } else {
          configloading('StrinError_Sync'.tr);
          INSERT_SYN_LOG("FAT_INV_SND_D",'${response.body} ${List_D[i].FISDGU.toString()}','U');
          break;
        }
      } catch (e) {
        INSERT_SYN_LOG("FAT_INV_SND_D",e.toString(),'U');
        i = List_D.length;
        return Future.error(e);
      }
    }
  }
  Future SyncFAT_INV_SND_RToSystem(List<Fat_Inv_Snd_R_Local> List_D,String TypeSync,bool TypeAuto) async {
    for (var i = 0; i < List_D.length; i++) {
      var data    =    {
        "FISRGU":List_D[i].FISRGU.toString(),
        "FISGU": List_D[i].FISGU.toString(),
        "FISRTY": List_D[i].FISRTY.toString(),
        "FISRDA": List_D[i].FISRDA.toString(),
        "STMID_CO":STMID,
        "SYDV_NAME": LoginController().DeviceName,
        "SYDV_TY":  LoginController().SYDV_TY,
        "SYDV_SER": LoginController().DeviceID,
        "SYDV_POI":"",
        "SYDV_ID_V":LoginController().SYDV_ID_V,
        "SYDV_NO_V":LoginController().SYDV_NO_V,
        "SYDV_BRA_N":1,
        "SYDV_LATITUDE":"",
        "SYDV_LONGITUDE":"",
        "SYDV_APPV_V":LoginController().APPV,
      };
      var params2 =    {
        "STMID_CO_V": STMID,
        "SYDV_NAME_V": LoginController().DeviceName,
        "SYDV_IP_V":   LoginController().IP,
        "SYDV_TY_V":   LoginController().SYDV_TY,
        "SYDV_SER_V":  LoginController().DeviceID,
        "SYDV_POI_V":"",
        "SYDV_ID_V":   LoginController().SYDV_ID,
        "SYDV_NO_V":   LoginController().SYDV_NO,
        "SYDV_BRA_V":1,
        "SYDV_LATITUDE_V":"",
        "SYDV_LONGITUDE_V":"",
        "SYDV_APPV_V": LoginController().APPV,
        "SOID_V": "FAT_INV_SND_R",
        "STID_V":"",
        "TBNA_V":"FAT_INV_SND_R",
        "LAN_V": LoginController().LAN,
        "CIID_V":LoginController().CIID,
        "JTID_V":LoginController().JTID,
        "BIID_V":LoginController().BIID,
        "SYID_V":LoginController().SYID,
        "SUID_V":LoginController().SUID,
        "SUPA_V":LoginController().SUPA,
        "F_ROW_V":'0',
        "T_ROW_V":'0',
        "F_DAT_V": '',
        "T_DAT_V": '',
        "F_GUID_V":"",
        "WH_V1":'',
        "PAR_V":"",
        "JSON_V": json.encode(data),
        "JSON_V2":"",
        "JSON_V3":""
      };
      print('SyncFAT_INV_SND_RToSystem');
      print(data.toString());
      var bodylang = utf8.encode(json.encode(params2));
      var body = json.encode(params2);
      try {
        final response = await http.post(
            Uri.parse("${LoginController().API}/ESAPI/ESPOST"), body: body,
            headers: {'Transfer-Encoding': 'chunked',
              HttpHeaders.contentTypeHeader: "application/json",
              'Content-Length': bodylang.length.toString(),
            });
        if (response.statusCode == 201 || response.statusCode == 200) {
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
            ..userInteractions = TypeSync=='ByDate'?false:true
            ..dismissOnTap = false;
          TypeAuto==true?EasyLoading.show(status:  "الفواتير المرسلة لمنصة فاتورة ${'StringWeAreSync'.tr}..${i+1}..${List_D.length}"):false;
          UPDATE_FAT("FAT_INV_SND_R",List_D[i].FISGU.toString());
          INSERT_SYN_LOG("FAT_INV_SND_R", '${SLIND} ${List_D[i].FISGU}', 'U');
        } else {
          configloading('StrinError_Sync'.tr);
          INSERT_SYN_LOG("FAT_INV_SND_R",'${response.body} ${List_D[i].FISGU.toString()}','U');
          break;
        }
      } catch (e) {
        INSERT_SYN_LOG("FAT_INV_SND_R",e.toString(),'U');
        i = List_D.length;
        return Future.error(e);
      }
    }
  }
  Future SyncFAT_INV_RSToSystem(List<Fat_Inv_Rs_Local> List_D,String TypeSync,bool TypeAuto) async {
    for (var i = 0; i < List_D.length; i++) {
      var data    =    {
        "FIRSEQ": List_D[i].FIRSEQ.toString(),
        "GUID": List_D[i].GUID.toString(),
        "FISSEQ": List_D[i].FISSEQ.toString(),
        "FISGU": List_D[i].FISGU.toString(),
        "FCIGU": List_D[i].FCIGU.toString(),
        "CIIDL": List_D[i].CIIDL.toString(),
        "JTIDL": List_D[i].JTIDL.toString(),
        "BIIDL": List_D[i].BIIDL.toString(),
        "SYIDL": List_D[i].SYIDL.toString(),
        "SCHNA": List_D[i].SCHNA.toString(),
        "BMMGU": List_D[i].BMMGU.toString(),
        "FIREQD": List_D[i].FIREQD.toString(),
        "FIRESC": List_D[i].FIRESC.toString(),
        "FIRERR": List_D[i].FIRERR.toString(),
        "FIRESD": List_D[i].FIRESD.toString(),
        "FIRDA": List_D[i].FIRDA.toString(),
        "SUID": List_D[i].SUID.toString(),
        "DATEI": List_D[i].DATEI.toString(),
        "DEVI": List_D[i].DEVI.toString(),
        "STMIDI": List_D[i].STMIDI.toString(),
        "SOMIDI": List_D[i].SOMIDI.toString(),
        "SUCH": List_D[i].SUCH.toString(),
        "DATEU": List_D[i].DATEU.toString(),
        "DEVU": List_D[i].DEVU.toString(),
        "STMIDU": List_D[i].STMIDU.toString(),
        "SOMIDU": List_D[i].SOMIDU.toString(),
        "STMID_CO":STMID,
        "SYDV_NAME": LoginController().DeviceName,
        "SYDV_IP": LoginController().IP,
        "SYDV_TY":  LoginController().SYDV_TY,
        "SYDV_SER": LoginController().DeviceID,
        "SYDV_POI":"",
        "SYDV_ID_V":LoginController().SYDV_ID_V,
        "SYDV_NO_V":LoginController().SYDV_NO_V,
        "SYDV_BRA_N":1,
        "SYDV_LATITUDE":"",
        "SYDV_LONGITUDE":"",
        "SYDV_APPV_V":LoginController().APPV,
      };
      var params2 =    {
        "STMID_CO_V": STMID,
        "SYDV_NAME_V": LoginController().DeviceName,
        "SYDV_IP_V":   LoginController().IP,
        "SYDV_TY_V":   LoginController().SYDV_TY,
        "SYDV_SER_V":  LoginController().DeviceID,
        "SYDV_POI_V":"",
        "SYDV_ID_V":   LoginController().SYDV_ID,
        "SYDV_NO_V":   LoginController().SYDV_NO,
        "SYDV_BRA_V":1,
        "SYDV_LATITUDE_V":"",
        "SYDV_LONGITUDE_V":"",
        "SYDV_APPV_V": LoginController().APPV,
        "SOID_V": "FAT_INV_RS",
        "STID_V":"",
        "TBNA_V":"FAT_INV_RS",
        "LAN_V": LoginController().LAN,
        "CIID_V":LoginController().CIID,
        "JTID_V":LoginController().JTID,
        "BIID_V":LoginController().BIID,
        "SYID_V":LoginController().SYID,
        "SUID_V":LoginController().SUID,
        "SUPA_V":LoginController().SUPA,
        "F_ROW_V":'0',
        "T_ROW_V":'0',
        "F_DAT_V": '',
        "T_DAT_V": '',
        "F_GUID_V":"",
        "WH_V1":'',
        "PAR_V":"",
        "JSON_V":  json.encode(data),
        "JSON_V2":"",
        "JSON_V3":""
      };
      var bodylang = utf8.encode(json.encode(params2));
      var body = json.encode(params2);
      try {
        final response = await http.post(
            Uri.parse("${LoginController().API}/ESAPI/ESPOST"), body: body,
            headers: {'Transfer-Encoding': 'chunked',
              HttpHeaders.contentTypeHeader: "application/json",
              'Content-Length': bodylang.length.toString(),
            });
        if (response.statusCode == 201 || response.statusCode == 200) {
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
            ..userInteractions = TypeSync=='ByDate'?false:true
            ..dismissOnTap = false;
          TypeAuto==true?EasyLoading.show(status:  "الفواتير المراد اعادة ارسالها بسبب وجود خطا في سيرفرات منصة فاتوره${'StringWeAreSync'.tr}..${i+1}..${List_D.length}"):false;
          UPDATE_FAT("FAT_INV_RS",List_D[i].BMMGU.toString());
          INSERT_SYN_LOG("FAT_INV_RS", '${SLIND} ${List_D[i].FISSEQ}-${List_D[i].FISSEQ}', 'U');
        }
        else {
          configloading('StrinError_Sync'.tr);
          INSERT_SYN_LOG("FAT_INV_RS",'${response.body} ${List_D[i].FISSEQ.toString()}-${List_D[i].FISSEQ.toString()}','U');
          break;
        }
      } catch (e) {
        INSERT_SYN_LOG("FAT_INV_RS",e.toString(),'U');
        i = List_D.length;
        return Future.error(e);
      }
    }
  }
  Future SyncFAT_SND_LOGToSystem(List<Fat_Snd_Log_Local> List_D,String TypeSync,bool TypeAuto) async {
    for (var i = 0; i < List_D.length; i++) {
      print('SyncFAT_SND_LOGToSystem');
      var data    =    {
        "FSLSEQ": List_D[i].FSLSEQ.toString(),
        "FSLGU": List_D[i].FSLGU.toString(),
        "FSLTY": List_D[i].FSLTY.toString(),
        "FCIGU": List_D[i].FCIGU.toString(),
        "CIIDL": List_D[i].CIIDL.toString(),
        "JTIDL": List_D[i].JTIDL.toString(),
        "BIIDL": List_D[i].BIIDL.toString(),
        "SYIDL": List_D[i].SYIDL.toString(),
        "SCHNA": List_D[i].SCHNA.toString(),
        "BMMGU": List_D[i].BMMGU.toString(),
        "FISGU": List_D[i].FISGU.toString(),
        "FSLPT": List_D[i].FSLPT.toString(),
        "FSLJOB": List_D[i].FSLJOB.toString(),
        "SSID": List_D[i].SSID.toString(),
        "FSLSIG": List_D[i].FSLSIG.toString(),
        "FSLCIE": List_D[i].FSLCIE.toString(),
        "FSLSTP": List_D[i].FSLSTP.toString(),
        "FSLST": List_D[i].FSLST.toString(),
        "FSLRT": List_D[i].FSLRT.toString(),
        "FSLMSG": List_D[i].FSLMSG.toString(),
        "FSLIS": List_D[i].FSLIS.toString(),
        "SUID": List_D[i].SUID.toString(),
        "DATEI": List_D[i].DATEI.toString(),
        "DEVI": List_D[i].DEVI.toString(),
        "STMIDI": List_D[i].STMIDI.toString(),
        "SOMIDI": List_D[i].SOMIDI.toString(),
        "STMID_CO":STMID,
        "SYDV_NAME": LoginController().DeviceName,
        "SYDV_IP": LoginController().IP,
        "SYDV_TY":  LoginController().SYDV_TY,
        "SYDV_SER": LoginController().DeviceID,
        "SYDV_POI":"",
        "SYDV_ID_V":LoginController().SYDV_ID_V,
        "SYDV_NO_V":LoginController().SYDV_NO_V,
        "SYDV_BRA_N":1,
        "SYDV_LATITUDE":"",
        "SYDV_LONGITUDE":"",
        "SYDV_APPV_V":LoginController().APPV,
      };
      var params2 =    {
        "STMID_CO_V": STMID,
        "SYDV_NAME_V": LoginController().DeviceName,
        "SYDV_IP_V":   LoginController().IP,
        "SYDV_TY_V":   LoginController().SYDV_TY,
        "SYDV_SER_V":  LoginController().DeviceID,
        "SYDV_POI_V":"",
        "SYDV_ID_V":   LoginController().SYDV_ID,
        "SYDV_NO_V":   LoginController().SYDV_NO,
        "SYDV_BRA_V":1,
        "SYDV_LATITUDE_V":"",
        "SYDV_LONGITUDE_V":"",
        "SYDV_APPV_V": LoginController().APPV,
        "SOID_V": "FAT_SND_LOG",
        "STID_V":"",
        "TBNA_V":"FAT_SND_LOG",
        "LAN_V": LoginController().LAN,
        "CIID_V":LoginController().CIID,
        "JTID_V":LoginController().JTID,
        "BIID_V":LoginController().BIID,
        "SYID_V":LoginController().SYID,
        "SUID_V":LoginController().SUID,
        "SUPA_V":LoginController().SUPA,
        "F_ROW_V":'0',
        "T_ROW_V":'0',
        "F_DAT_V": '',
        "T_DAT_V": '',
        "F_GUID_V":"",
        "WH_V1":'',
        "PAR_V":"",
        "JSON_V":  json.encode(data),
        "JSON_V2":"",
        "JSON_V3":""
      };
      var bodylang = utf8.encode(json.encode(params2));
      var body = json.encode(params2);
      try {
        final response = await http.post(
            Uri.parse("${LoginController().API}/ESAPI/ESPOST"), body: body,
            headers: {'Transfer-Encoding': 'chunked',
              HttpHeaders.contentTypeHeader: "application/json",
              'Content-Length': bodylang.length.toString(),
            });
        if (response.statusCode == 201 || response.statusCode == 200) {
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
            ..userInteractions = TypeSync=='ByDate'?false:true
            ..dismissOnTap = false;
          TypeAuto==true?EasyLoading.show(status:  "ارشيف البيانات المرسلة والمستلمة من منصة فاتورة ${'StringWeAreSync'.tr}..${i+1}..${List_D.length}"):false;
          UPDATE_FAT("FAT_SND_LOG",List_D[i].FSLSEQ.toString());
          INSERT_SYN_LOG("FAT_SND_LOG", '${SLIND} ${List_D[i].FSLSEQ}-${List_D[i].FSLGU}', 'U');
        }
        else {
          configloading('StrinError_Sync'.tr);
          INSERT_SYN_LOG("FAT_SND_LOG",'${response.body} ${List_D[i].FSLSEQ.toString()}-${List_D[i].FSLGU.toString()}','U');
          break;
        }
      } catch (e) {
        INSERT_SYN_LOG("FAT_SND_LOG",e.toString(),'U');
        i = List_D.length;
        return Future.error(e);
      }
    }
  }
  Future SyncFAT_SND_LOG_DToSystem(List<Fat_Snd_Log_D_Local> List_D) async {
    for (var i = 0; i < List_D.length; i++) {
      print('SyncFAT_SND_LOG_DToSystem');
      var data    =    {
        "FSLSEQ": List_D[i].FSLSEQ.toString(),
        "FSLGU": List_D[i].FSLGU.toString(),
        "FSLDRQ": List_D[i].FSLDRQ.toString(),
        "FSLDRC": List_D[i].FSLDRC.toString(),
        "FSLDER": List_D[i].FSLDER.toString(),
        "FSLDRS": List_D[i].FSLDRS.toString(),
        "STMID_CO":STMID,
        "SYDV_NAME": LoginController().DeviceName,
        "SYDV_IP": LoginController().IP,
        "SYDV_TY":  LoginController().SYDV_TY,
        "SYDV_SER": LoginController().DeviceID,
        "SYDV_POI":"",
        "SYDV_ID_V":LoginController().SYDV_ID_V,
        "SYDV_NO_V":LoginController().SYDV_NO_V,
        "SYDV_BRA_N":1,
        "SYDV_LATITUDE":"",
        "SYDV_LONGITUDE":"",
        "SYDV_APPV_V":LoginController().APPV,
      };
      var params2 =    {
        "STMID_CO_V": STMID,
        "SYDV_NAME_V": LoginController().DeviceName,
        "SYDV_IP_V":   LoginController().IP,
        "SYDV_TY_V":   LoginController().SYDV_TY,
        "SYDV_SER_V":  LoginController().DeviceID,
        "SYDV_POI_V":"",
        "SYDV_ID_V":   LoginController().SYDV_ID,
        "SYDV_NO_V":   LoginController().SYDV_NO,
        "SYDV_BRA_V":1,
        "SYDV_LATITUDE_V":"",
        "SYDV_LONGITUDE_V":"",
        "SYDV_APPV_V": LoginController().APPV,
        "SOID_V": "FAT_SND_LOG_D",
        "STID_V":"",
        "TBNA_V":"FAT_SND_LOG_D",
        "LAN_V": LoginController().LAN,
        "CIID_V":LoginController().CIID,
        "JTID_V":LoginController().JTID,
        "BIID_V":LoginController().BIID,
        "SYID_V":LoginController().SYID,
        "SUID_V":LoginController().SUID,
        "SUPA_V":LoginController().SUPA,
        "F_ROW_V":'0',
        "T_ROW_V":'0',
        "F_DAT_V": '',
        "T_DAT_V": '',
        "F_GUID_V":"",
        "WH_V1":'',
        "PAR_V":"",
        "JSON_V":  json.encode(data),
        "JSON_V2":"",
        "JSON_V3":""
      };
      var bodylang = utf8.encode(json.encode(params2));
      var body = json.encode(params2);
      try {
        final response = await http.post(
            Uri.parse("${LoginController().API}/ESAPI/ESPOST"), body: body,
            headers: {'Transfer-Encoding': 'chunked',
              HttpHeaders.contentTypeHeader: "application/json",
              'Content-Length': bodylang.length.toString(),
            });
        if (response.statusCode == 201 || response.statusCode == 200) {
          UPDATE_FAT("FAT_SND_LOG_D",List_D[i].FSLSEQ.toString());
          INSERT_SYN_LOG("FAT_SND_LOG_D", '${SLIND} ${List_D[i].FSLSEQ}-${List_D[i].FSLGU}', 'U');
        }
        else {
          INSERT_SYN_LOG("FAT_SND_LOG_D",'${response.body} ${List_D[i].FSLSEQ.toString()}-${List_D[i].FSLGU.toString()}','U');
          break;
        }
      } catch (e) {
        INSERT_SYN_LOG("FAT_SND_LOG_D",e.toString(),'U');
        i = List_D.length;
        return Future.error(e);
      }
    }
  }
  Future SyncFAT_CSID_SEQToSystem(List<Fat_Csid_Seq_Local> List_D,String TypeSync,bool TypeAuto) async {
    print('SyncFAT_CSID_SEQToSystem');
    for (var i = 0; i < List_D.length; i++) {
      var data    =    {
        "FCIGU": List_D[i].FCIGU.toString(),
        "FCSNO": List_D[i].FCSNO.toString(),
        "FISSEQ": List_D[i].FISSEQ.toString(),
        "FISGU": List_D[i].FISGU.toString(),
        "FCSHA": List_D[i].FCSHA.toString(),
        "SUID": List_D[i].SUID.toString(),
        "DATEI": List_D[i].DATEI.toString(),
        "DEVI": List_D[i].DEVI.toString(),
        "STMIDI": List_D[i].STMIDI.toString(),
        "SOMIDI": List_D[i].SOMIDI.toString(),
        "SUCH": List_D[i].SUCH.toString(),
        "DATEU": List_D[i].DATEU.toString(),
        "DEVU": List_D[i].DEVU.toString(),
        "STMIDU": List_D[i].STMIDU.toString(),
        "SOMIDU": List_D[i].SOMIDU.toString(),
        "STMID_CO":STMID,
        "SYDV_NAME": LoginController().DeviceName,
        "SYDV_IP": LoginController().IP,
        "SYDV_TY":  LoginController().SYDV_TY,
        "SYDV_SER": LoginController().DeviceID,
        "SYDV_POI":"",
        "SYDV_ID_V":LoginController().SYDV_ID_V,
        "SYDV_NO_V":LoginController().SYDV_NO_V,
        "SYDV_BRA_N":1,
        "SYDV_LATITUDE":"",
        "SYDV_LONGITUDE":"",
        "SYDV_APPV_V":LoginController().APPV,
      };
      var params2 =    {
        "STMID_CO_V": STMID,
        "SYDV_NAME_V": LoginController().DeviceName,
        "SYDV_IP_V":   LoginController().IP,
        "SYDV_TY_V":   LoginController().SYDV_TY,
        "SYDV_SER_V":  LoginController().DeviceID,
        "SYDV_POI_V":"",
        "SYDV_ID_V":   LoginController().SYDV_ID,
        "SYDV_NO_V":   LoginController().SYDV_NO,
        "SYDV_BRA_V":1,
        "SYDV_LATITUDE_V":"",
        "SYDV_LONGITUDE_V":"",
        "SYDV_APPV_V": LoginController().APPV,
        "SOID_V": "FAT_CSID_SEQ",
        "STID_V":"",
        "TBNA_V":"FAT_CSID_SEQ",
        "LAN_V": LoginController().LAN,
        "CIID_V":LoginController().CIID,
        "JTID_V":LoginController().JTID,
        "BIID_V":LoginController().BIID,
        "SYID_V":LoginController().SYID,
        "SUID_V":LoginController().SUID,
        "SUPA_V":LoginController().SUPA,
        "F_ROW_V":'0',
        "T_ROW_V":'0',
        "F_DAT_V": '',
        "T_DAT_V": '',
        "F_GUID_V":"",
        "WH_V1":'',
        "PAR_V":"",
        "JSON_V":  json.encode(data),
        "JSON_V2":"",
        "JSON_V3":""
      };
      var bodylang = utf8.encode(json.encode(params2));
      var body = json.encode(params2);
      try {
        final response = await http.post(
            Uri.parse("${LoginController().API}/ESAPI/ESPOST"), body: body,
            headers: {'Transfer-Encoding': 'chunked',
              HttpHeaders.contentTypeHeader: "application/json",
              'Content-Length': bodylang.length.toString(),
            });
        if (response.statusCode == 201 || response.statusCode == 200) {
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
            ..userInteractions = TypeSync=='ByDate'?false:true
            ..dismissOnTap = false;
          TypeAuto==true?EasyLoading.show(status:  "مسلسل الترقيم للوحدات/الاجهزه التقنية ${'StringWeAreSync'.tr}..${i+1}..${List_D.length}"):false;
          UPDATE_FAT("FAT_CSID_SEQ",List_D[i].FCIGU.toString());
          INSERT_SYN_LOG("FAT_CSID_SEQ", '${SLIND} ${List_D[i].FISSEQ}-${List_D[i].FISGU}', 'U');
        }
        else {
          configloading('StrinError_Sync'.tr);
          INSERT_SYN_LOG("FAT_CSID_SEQ",'${response.body} ${List_D[i].FCIGU.toString()}-${List_D[i].FISGU.toString()}','U');
          break;
        }
      } catch (e) {
        INSERT_SYN_LOG("FAT_CSID_SEQ",e.toString(),'U');
        i = List_D.length;
        return Future.error(e);
      }
    }
  }


  //STEP ----3
  Future SYNC_FAT_INV_SND(String TypeSync,BMMGU,bool TypeAuto) async {
    var FAT_INV_SNDList= await fetchAll_FAT_INV_SND(TypeSync, BMMGU);
    if (FAT_INV_SNDList.isNotEmpty && FAT_INV_SNDList.length>0) {
      await SyncFAT_INV_SNDToSystem(FAT_INV_SNDList,TypeSync,TypeAuto);
      await SYNC_FAT_INV_SND_D(TypeSync,FAT_INV_SNDList[0].FISGU,TypeAuto);
      await SYNC_FAT_INV_SND_R(TypeSync,FAT_INV_SNDList[0].FISGU,TypeAuto);
      await SYNC_FAT_INV_RS(TypeSync,BMMGU,TypeAuto);
      await SYNC_FAT_SND_LOG(TypeSync,BMMGU,TypeAuto);
      await SYNC_FAT_CSID_SEQ(TypeSync,FAT_INV_SNDList[0].FCIGU,TypeAuto);
    } else{
      print('لا يوجد بيانات FAT_INV_SND');
    }
  }
  Future SYNC_FAT_INV_SND_D(String TypeSync,FISGU,bool TypeAuto) async {
    var FAT_INV_SNDList= await fetchAll_FAT_INV_SND_D(TypeSync, FISGU);
    if (FAT_INV_SNDList.isNotEmpty && FAT_INV_SNDList.length>0) {
      await SyncFAT_INV_SND_DToSystem(FAT_INV_SNDList,TypeSync,TypeAuto);
    } else{
      print('لا يوجد بيانات FAT_INV_SND_D');
    }
  }
  Future SYNC_FAT_INV_SND_R(String TypeSync,FISGU,bool TypeAuto) async {
    var FAT_INV_SNDList= await fetchAll_FAT_INV_SND_R(TypeSync, FISGU);
    if (FAT_INV_SNDList.isNotEmpty && FAT_INV_SNDList.length>0) {
      await SyncFAT_INV_SND_RToSystem(FAT_INV_SNDList,TypeSync,TypeAuto);
    } else{
      print('لا يوجد بيانات FAT_INV_SND_R');
    }
  }
  Future SYNC_FAT_INV_RS(String TypeSync,BMMGU,bool TypeAuto) async {
    var FAT_INV_RSList= await fetchAll_FAT_INV_RS(TypeSync, BMMGU);
    if (FAT_INV_RSList.isNotEmpty && FAT_INV_RSList.length>0) {
      await SyncFAT_INV_RSToSystem(FAT_INV_RSList,TypeSync,TypeAuto);
    } else{
      print('لا يوجد بيانات FAT_INV_RS');
    }
  }
  Future SYNC_FAT_SND_LOG(String TypeSync,FSLGU,bool TypeAuto) async {
    var FAT_SND_LOGList= await fetchAll_FAT_SND_LOG(TypeSync, FSLGU);
    if (FAT_SND_LOGList.isNotEmpty && FAT_SND_LOGList.length>0) {
      await SyncFAT_SND_LOGToSystem(FAT_SND_LOGList,TypeSync,TypeAuto);
      await SYNC_FAT_SND_LOG_D(TypeSync,FAT_SND_LOGList[0].FSLGU);
    } else{
      print('لا يوجد بيانات FAT_SND_LOG');
    }

  }
  Future SYNC_FAT_SND_LOG_D(String TypeSync,BMMGU) async {
    var FAT_SND_LOG_DList= await fetchAll_FAT_SND_LOG_D(TypeSync, BMMGU);
    if (FAT_SND_LOG_DList.isNotEmpty && FAT_SND_LOG_DList.length>0) {
      await SyncFAT_SND_LOG_DToSystem(FAT_SND_LOG_DList);
    } else{
      print('لا يوجد بيانات FAT_SND_LOG_D');
    }

  }
  Future SYNC_FAT_CSID_SEQ(String TypeSync,FCIGU,bool TypeAuto) async {
    var FAT_CSID_SEQList= await fetchAll_FAT_CSID_SEQ(TypeSync, FCIGU);
    if (FAT_CSID_SEQList.isNotEmpty && FAT_CSID_SEQList.length>0) {
      await SyncFAT_CSID_SEQToSystem(FAT_CSID_SEQList,TypeSync,TypeAuto);
    } else{
      print('لا يوجد بيانات FAT_CSID_SEQ');
    }

  }


//الضريبة------------------------------

//الطاولات------------------------------

  Future<List<BIF_TRA_TBL_Local>> FetchBIF_TRA_TBL(String GETGUID) async {
    final dbClient = await conn.database;
    List<BIF_TRA_TBL_Local> List_D = [];
    String SQLBIID_L = LoginController().BIID_ALL_V == '1' ? " AND  BIID_L=${LoginController().BIID}" :  '';
    String SQL2 = ''' AND JTID_L=${LoginController().JTID} AND SYID_L=${LoginController().SYID} 
                  AND CIID_L=${LoginController().CIID} $SQLBIID_L''';
    try {
      final maps = await dbClient!.query('BIF_TRA_TBL', where: "GUID='$GETGUID' $SQL2");
      for (var item in maps) {
        List_D.add(BIF_TRA_TBL_Local.fromMap(item));
      }
    } catch (e) {
      print(e.toString());
    }
    return List_D;
  }

  Future SyncBIF_TRA_TBLToSystem(List<BIF_TRA_TBL_Local> contactList)
  async {
    for (var i = 0; i < contactList.length; i++) {
      print('SyncBIF_TRA_TBLToSystem');
      var data = {
        "RSIDO": contactList[i].RSIDO.toString(),
        "RTIDO": contactList[i].RTIDO.toString(),
        "RSIDN": contactList[i].RSIDN.toString(),
        "RTIDN": contactList[i].RTIDN.toString(),
        "BTTST": contactList[i].BTTST.toString(),
        "GUIDF": contactList[i].GUIDF.toString(),
        "GUID": contactList[i].GUID.toString(),
        "STMIDI": contactList[i].STMIDI.toString(),
        "SOMIDI": contactList[i].SOMIDI.toString(),
        "SUID": contactList[i].SUID.toString(),
        "DATEI": contactList[i].DATEI.toString(),
        "DEVI": contactList[i].DEVI.toString(),
        "STMID_CO":STMID,
        "SYDV_NAME": LoginController().DeviceName,
        "SYDV_IP": LoginController().IP,
        "SYDV_TY":  LoginController().SYDV_TY,
        "SYDV_SER": LoginController().DeviceID,
        "SYDV_POI":"",
        "SYDV_ID":LoginController().SYDV_ID,
        "SYDV_NO": LoginController().SYDV_NO,
        "SYDV_LATITUDE":"",
        "SYDV_LONGITUDE":"",
        "SYDV_APPV":LoginController().APPV,
      };
      var params = {
        "STMID_CO_V": STMID,
        "SYDV_NAME_V": LoginController().DeviceName,
        "SYDV_IP_V":   LoginController().IP,
        "SYDV_TY_V":   LoginController().SYDV_TY,
        "SYDV_SER_V":  LoginController().DeviceID,
        "SYDV_POI_V":"",
        "SYDV_ID_V":   LoginController().SYDV_ID,
        "SYDV_NO_V":   LoginController().SYDV_NO,
        "SYDV_BRA_V":1,
        "SYDV_LATITUDE_V":"",
        "SYDV_LONGITUDE_V":"",
        "SYDV_APPV_V": LoginController().APPV,
        "SOID_V":"BIF_TRA_TAB",
        "STID_V":"",
        "TBNA_V":'BIF_TRA_TAB',
        "LAN_V": LoginController().LAN,
        "CIID_V":LoginController().CIID,
        "JTID_V":LoginController().JTID,
        "BIID_V":LoginController().BIID,
        "SYID_V":LoginController().SYID,
        "SUID_V":LoginController().SUID,
        "SUPA_V":LoginController().SUPA,
        "F_ROW_V":'0',
        "T_ROW_V":'0',
        "F_DAT_V": '',
        "T_DAT_V": '',
        "F_GUID_V":"",
        "WH_V1":'',
        "PAR_V":"",
        "JSON_V": data.toString(),
        "JSON_V2":"",
        "JSON_V3":""
      };
      print(data);
      print(params);
      print('SyncBIF_TRA_TBLToSystem');
      var bodylang = utf8.encode(json.encode(params));
      var body = json.encode(params);
      try {
        final response = await http.post(Uri.parse("${LoginController().API}/ESAPI/ESPOST"),
            body: body,
            headers: {'Transfer-Encoding': 'chunked',
              HttpHeaders.contentTypeHeader: "application/json",
              'Content-Length': bodylang.length.toString(),
            });
        if (response.statusCode == 201 || response.statusCode == 200) {
          INSERT_SYN_LOG('BIF_TRA_TBL',SLINM,'U');
        } else {
          configloading(response.body);
          Fluttertoast.showToast(
              msg: response.body,
              textColor: Colors.white,
              backgroundColor: Colors.red);
          INSERT_SYN_LOG('BIF_TRA_TBL',response.body,'U');
        }
      } catch (e) {
        configloading('StrinError_Sync'.tr);
        Fluttertoast.showToast(
            msg: "response error ${e.toString()}",
            textColor: Colors.white,
            backgroundColor: Colors.red);
        INSERT_SYN_LOG('BIF_TRA_TBL',e.toString(),'U');
        return Future.error(e);
      }
    }
  }

//الطاولات------------------------------

//السندات------------------------------


  //STEP ----1
  Future<List<Acc_Mov_D_Local>> FetchACC_MOV_DData(String TypeSync, String GETAMKID, String GETAMMID,
      GETAMMST,GetFromDate, GetToDate) async {
    final dbClient = await conn.database;
    List<Acc_Mov_D_Local> ACC_MOV_DList = [];
    String SQLBIID_L = LoginController().BIID_ALL_V == '1'
        ? " AND  BIID_L=${LoginController().BIID}" :  '';
    String SQLBIID_L2 = LoginController().BIID_ALL_V == '1'
        ? " AND  A.BIID_L=${LoginController().BIID}" :  '';

    String SQL2 = ''' AND JTID_L=${LoginController().JTID} AND SYID_L=${LoginController().SYID} 
                  AND CIID_L=${LoginController().CIID} $SQLBIID_L''';
    String sqlAMKID='';
    if(GETAMKID=='1' || GETAMKID=='2' || GETAMKID=='3'){
      sqlAMKID=" AMKID=$GETAMKID  AND ";
    }
    else if(GETAMKID=='0'){
      sqlAMKID="";
    }
    else{
      sqlAMKID=" AMKID NOT IN (1,2,3) AND ";
    }
    try {
      if (TypeSync == "SyncAll") {
        final maps = await dbClient!.query('ACC_MOV_D', where: '$sqlAMKID SYST_L=2 $SQL2');
        for (var item in maps) {
          ACC_MOV_DList.add(Acc_Mov_D_Local.fromMap(item));
        }
      }
      else if (TypeSync == "SyncOnly") {
        final maps = await dbClient!.query('ACC_MOV_D', where: '  AMMID=$GETAMMID');
        print('maps');
        print(maps);
        for (var item in maps) {
          ACC_MOV_DList.add(Acc_Mov_D_Local.fromMap(item));
        }
      }

      else if (TypeSync == "ByDate") {
        String whereByDate=" A.AMKID=$GETAMKID AND "
        " EXISTS(SELECT 1 FROM ACC_MOV_M B WHERE "
            " strftime('%Y-%m-%d', substr(B.AMMDOR, 7, 4) || '-' || substr(B.AMMDOR, 4, 2) || '-' || substr(B.AMMDOR, 1, 2))"
            " BETWEEN '$GetFromDate' AND '$GetToDate' AND B.AMMST=$GETAMMST "
            " and B.AMMID=A.AMMID) AND "
            " A.JTID_L=${LoginController().JTID} AND A.SYID_L=${LoginController().SYID} "
            " AND A.CIID_L=${LoginController().CIID} $SQLBIID_L2 ";
        final maps = await dbClient!.query('ACC_MOV_D A', where: whereByDate);
        for (var item in maps) {
          ACC_MOV_DList.add(Acc_Mov_D_Local.fromMap(item));
        }
        print('maps');
      }
    } catch (e) {
      print(e.toString());
    }
    return ACC_MOV_DList;
  }

  //STEP ----2
  Future SyncACC_MOV_DToSystem(String TypeSync, String GetAMKID, String GetAMMID,List<Acc_Mov_D_Local> Acc_Mov_DList,
                    bool TypeAuto,GETAMMST,GetFromDate, GetToDate) async {
    for (var i = 0; i < Acc_Mov_DList.length; i++) {
      var data = {
        "AMMID": Acc_Mov_DList[i].AMMID.toString(),
        "AMKID": Acc_Mov_DList[i].AMKID.toString()=='3'?'1':Acc_Mov_DList[i].AMKID.toString(),
        "AMDID": Acc_Mov_DList[i].AMDID.toString(),
        "AANO": Acc_Mov_DList[i].AANO.toString(),
        "ACNO": Acc_Mov_DList[i].ACNO.toString(),
        "AMDRE": Acc_Mov_DList[i].AMDRE.toString(),
        "AMDIN": Acc_Mov_DList[i].AMDIN.toString(),
        "SCID": Acc_Mov_DList[i].SCID.toString(),
        "SCEX": Acc_Mov_DList[i].SCEX.toString(),
        "AMDMD": Acc_Mov_DList[i].AMDMD.toString(),
        "AMDDA": Acc_Mov_DList[i].AMDDA.toString(),
        "AMDEQ": Acc_Mov_DList[i].AMDEQ.toString(),
        "AMDTY": Acc_Mov_DList[i].AMDTY.toString(),
        "AMDST": Acc_Mov_DList[i].AMDST.toString(),
        "BIID": Acc_Mov_DList[i].BIID.toString(),
        "AMDVW": Acc_Mov_DList[i].AMDVW.toString(),
        "AMDKI": Acc_Mov_DList[i].AMDKI.toString(),
        "GUID": Acc_Mov_DList[i].GUID.toString(),
        "GUIDF": Acc_Mov_DList[i].GUIDF.toString(),
        "GUIDM_L": Acc_Mov_DList[i].GUIDF.toString(),
        "SUID": Acc_Mov_DList[i].SUID.toString(),
        "SUCH": Acc_Mov_DList[i].SUCH.toString(),
        "DATEI": Acc_Mov_DList[i].DATEI.toString(),
        "DATEU": Acc_Mov_DList[i].DATEU.toString(),
        "DEVI": Acc_Mov_DList[i].DEVI.toString(),
        "DEVU": Acc_Mov_DList[i].DEVU.toString(),
        "STMID_CO":STMID,
        "SYDV_NAME": LoginController().DeviceName,
        "SYDV_IP": LoginController().IP,
        "SYDV_TY":  LoginController().SYDV_TY,
        "SYDV_SER": LoginController().DeviceID,
        "SYDV_POI":"",
        "SYDV_ID_V":LoginController().SYDV_ID_V,
        "SYDV_NO_V":LoginController().SYDV_NO_V,
        "SYDV_BRA_N":1,
        "SYDV_LATITUDE":"",
        "SYDV_LONGITUDE":"",
        "SYDV_APPV_V":LoginController().APPV,
      };
      var params = {
        "STMID_CO_V": STMID,
        "SYDV_NAME_V": LoginController().DeviceName,
        "SYDV_IP_V":   LoginController().IP,
        "SYDV_TY_V":   LoginController().SYDV_TY,
        "SYDV_SER_V":  LoginController().DeviceID,
        "SYDV_POI_V":"",
        "SYDV_ID_V":   LoginController().SYDV_ID,
        "SYDV_NO_V":   LoginController().SYDV_NO,
        "SYDV_BRA_V":1,
        "SYDV_LATITUDE_V":"",
        "SYDV_LONGITUDE_V":"",
        "SYDV_APPV_V": LoginController().APPV,
        "SOID_V":Acc_Mov_DList[i].AMKID.toString()=='2'?"ACC_MOV_DO":Acc_Mov_DList[i].AMKID.toString()=='1'?'ACC_MOV_DI':
        Acc_Mov_DList[i].AMKID.toString()=='3'?'ACC_MOV_DC':'ACC_MOV_DJ',
        "STID_V":"",
        "TBNA_V":'ACC_MOV_D',
        "LAN_V": LoginController().LAN,
        "CIID_V":LoginController().CIID,
        "JTID_V":LoginController().JTID,
        "BIID_V":LoginController().BIID,
        "SYID_V":LoginController().SYID,
        "SUID_V":LoginController().SUID,
        "SUPA_V":LoginController().SUPA,
        "F_ROW_V":'0',
        "T_ROW_V":'0',
        "F_DAT_V": '',
        "T_DAT_V": '',
        "F_GUID_V":'',
        "WH_V1":'',
        "PAR_V":"",
        "JSON_V": data.toString(),
        "JSON_V2":"",
        "JSON_V3":""
      };
      print(data);
      var bodylang = utf8.encode(json.encode(params));
      var body = json.encode(params);
      try {
        final response = await http.post(
            Uri.parse("${LoginController().API}/ESAPI/ESPOST"),
            body: body,
            headers: {'Transfer-Encoding': 'chunked', HttpHeaders.contentTypeHeader: "application/json",
              'Content-Length': bodylang.length.toString(),
            });
        if (response.statusCode == 201 || response.statusCode == 200) {
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
            ..userInteractions = TypeSync=='ByDate'?false:true
            ..dismissOnTap = false;
          TypeAuto==true?EasyLoading.show(status:  "${'StringWeAreSync'.tr}..${i+1}..${Acc_Mov_DList.length}"):false;
          print('i');
          print(i);
          print(Acc_Mov_DList.length);
          INSERT_SYN_LOG('ACC_MOV_D','${SLIND} ${Acc_Mov_DList[i].AMMID.toString()}-${Acc_Mov_DList[i].AMDID.toString()} ','U');
        }
        else {
          configloading('StrinError_Sync'.tr);
          Fluttertoast.showToast(
              msg: response.body,
              textColor: Colors.white,
              backgroundColor: Colors.red);
          INSERT_SYN_LOG('ACC_MOV_D','${response.body} ${Acc_Mov_DList[i].AMMID.toString()}-${Acc_Mov_DList[i].AMDID.toString()} ','U');
          break;
        }
        if(i+1 ==Acc_Mov_DList.length){
          print('object11');
          SyncACC_MOV_M(TypeSync,GetAMKID,GetAMMID,TypeAuto,GETAMMST,GetFromDate, GetToDate);
        }
      } catch (e) {
        configloading('StrinError_Sync'.tr);
        Fluttertoast.showToast(
            msg: e.toString(),
            textColor: Colors.white,
            backgroundColor: Colors.red);
        INSERT_SYN_LOG('ACC_MOV_D','${e.toString()} ${Acc_Mov_DList[i].AMMID.toString()}-${Acc_Mov_DList[i].AMDID.toString()} ','U');
        i = Acc_Mov_DList.length;
        return Future.error(e);
      }
    }
  }

  //STEP ----3
  Future SyncACC_MOV_M(String TypeSync,String GetAMKID, String GetAMMID,bool TypeAuto,GETAMMST,GetFromDate, GetToDate) async {
    await SyncronizationData().FetchACC_MOV_MData(TypeSync, GetAMKID, GetAMMID,GETAMMST,GetFromDate, GetToDate).then((ACC_MOV_MList) async {
      if (ACC_MOV_MList.isNotEmpty && ACC_MOV_MList.length>0) {
        await SyncronizationData().SyncACC_MOV_MToSystem(ACC_MOV_MList, TypeSync, GetAMMID, GetAMKID,TypeAuto,GETAMMST,GetFromDate, GetToDate);
      }
    });
  }


  //STEP ----4
  Future<List<Acc_Mov_M_Local>> FetchACC_MOV_MData(String TypeSync, String GETAMKID, String GETAMMID,
      GETAMMST,GetFromDate, GetToDate) async {
    final dbClient = await conn.database;
    List<Acc_Mov_M_Local> ACC_MOV_MList = [];
    String SQLBIID_L = LoginController().BIID_ALL_V == '1'
        ? " AND  BIID_L=${LoginController().BIID}" :  '';
    String SQLBIID_L2 = LoginController().BIID_ALL_V == '1'
        ? " AND  A.BIID_L=${LoginController().BIID}" :  '';

    String SQL2 = ''' AND JTID_L=${LoginController().JTID} AND SYID_L=${LoginController().SYID} 
                  AND CIID_L=${LoginController().CIID} $SQLBIID_L''';
    String sqlAMKID='';
    if(GETAMKID=='1' || GETAMKID=='2' || GETAMKID=='3'){
      sqlAMKID=" AMKID=$GETAMKID AND ";
    }
    else if(GETAMKID=='0'){
      sqlAMKID=" ";
    }
    else{
      sqlAMKID=" AMKID NOT IN (1,2,3) AND ";
    }
    try {
      if (TypeSync == "SyncAll") {
        final maps = await dbClient!.query('ACC_MOV_M', where: '$sqlAMKID  AMMST!=1 $SQL2');
        for (var item in maps) {
          ACC_MOV_MList.add(Acc_Mov_M_Local.fromMap(item));
        }
      }
      else if (TypeSync == "SyncOnly") {
        final maps = await dbClient!.query('ACC_MOV_M', where: ' AMMID=$GETAMMID');
        for (var item in maps) {
          ACC_MOV_MList.add(Acc_Mov_M_Local.fromMap(item));
        }
      }
      else if (TypeSync == "ByDate") {
        final maps = await dbClient!.query('ACC_MOV_M', where: " "
            "AMKID=$GETAMKID and "
            " strftime('%Y-%m-%d', substr(AMMDOR, 7, 4) || '-' || substr(AMMDOR, 4, 2) || '-' || substr(AMMDOR, 1, 2))"
            " BETWEEN '$GetFromDate' AND '$GetToDate' AND AMMST=$GETAMMST $SQL2");
        for (var item in maps) {
          ACC_MOV_MList.add(Acc_Mov_M_Local.fromMap(item));
        }
      }
    } catch (e) {
      print(e.toString());
    }
    return ACC_MOV_MList;
  }

  //STEP ----5
  Future SyncACC_MOV_MToSystem(List<Acc_Mov_M_Local> Acc_Mov_MList, String TypeSync, String GETAMMID, String GETAMKID,
      bool TypeAuto,GETAMMST,GetFromDate, GetToDate)
  async {
    for (var i = 0; i < Acc_Mov_MList.length; i++) {
      var data = {
        "AMKID": Acc_Mov_MList[i].AMKID.toString()=='3'?'1':Acc_Mov_MList[i].AMKID.toString(),
        "AMMID": Acc_Mov_MList[i].AMMID.toString(),
        "AMMNO": Acc_Mov_MList[i].AMMNO.toString(),
        "PKID": Acc_Mov_MList[i].PKID.toString(),
        "AMMDO": Acc_Mov_MList[i].AMMDO.toString(),
        "AMMST": 2,
        "AMMRE": Acc_Mov_MList[i].AMMRE.toString(),
        "AMMCC": Acc_Mov_MList[i].AMMCC.toString(),
        "SCID": Acc_Mov_MList[i].SCID.toString(),
        "SCEX": Acc_Mov_MList[i].SCEX.toString(),
        "AMMAM": Acc_Mov_MList[i].AMMAM.toString(),
        "AMMEQ": Acc_Mov_MList[i].AMMEQ.toString(),
        "ACID": Acc_Mov_MList[i].ACID.toString(),
        "ABID": Acc_Mov_MList[i].ABID.toString(),
        "AMMCN": Acc_Mov_MList[i].AMMCN.toString(),
        "AMMCD": Acc_Mov_MList[i].AMMCD.toString(),
        "AMMCI": Acc_Mov_MList[i].AMMCI.toString(),
        "BDID": Acc_Mov_MList[i].BDID.toString(),
        "AMMIN": Acc_Mov_MList[i].AMMIN.toString(),
        "AMMNA": Acc_Mov_MList[i].AMMNA.toString(),
        "AMMRE2": Acc_Mov_MList[i].AMMRE2.toString(),
        "ACNO": Acc_Mov_MList[i].ACNO.toString(),
        "AMMDN": Acc_Mov_MList[i].AMMDN.toString(),
        "BKID":Acc_Mov_MList[i].BKID.toString(),
        "BMMID":Acc_Mov_MList[i].BMMID.toString(),
        "SUID":Acc_Mov_MList[i].SUID.toString(),
        "AMMDA":Acc_Mov_MList[i].AMMDA.toString(),
        "SUAP":Acc_Mov_MList[i].SUAP.toString(),
        "AMMDU":Acc_Mov_MList[i].AMMDU.toString(),
        "SUUP":Acc_Mov_MList[i].SUUP.toString(),
        "AMMCT":Acc_Mov_MList[i].AMMCT.toString(),
        "BIID":Acc_Mov_MList[i].BIID.toString(),
        "BCCID":Acc_Mov_MList[i].BCCID.toString(),
        "GUID":Acc_Mov_MList[i].GUID.toString(),
        "AMMBR":Acc_Mov_MList[i].AMMBR.toString(),
        "BIIDB":Acc_Mov_MList[i].BIIDB.toString(),
        "DATEI":Acc_Mov_MList[i].DATEI.toString(),
        "DATEU": Acc_Mov_MList[i].DATEU.toString(),
        "GUID_LNK": Acc_Mov_MList[i].GUID_LNK.toString(),
        "DEVI": Acc_Mov_MList[i].DEVI.toString(),
        "DEVU": Acc_Mov_MList[i].DEVU.toString(),
        "ROWN1":  Acc_Mov_MList[i].ROWN1.toString(),
        "STMID_CO":STMID,
        "SYDV_NAME": LoginController().DeviceName,
        "SYDV_IP": LoginController().IP,
        "SYDV_TY":  LoginController().SYDV_TY,
        "SYDV_SER": LoginController().DeviceID,
        "SYDV_POI":"",
        "SYDV_ID":LoginController().SYDV_ID,
        "SYDV_NO": LoginController().SYDV_NO,
        "SYDV_LATITUDE":"",
        "SYDV_LONGITUDE":"",
        "SYDV_APPV":LoginController().APPV,
      };
      var params = {
        "STMID_CO_V": STMID,
        "SYDV_NAME_V": LoginController().DeviceName,
        "SYDV_IP_V":   LoginController().IP,
        "SYDV_TY_V":   LoginController().SYDV_TY,
        "SYDV_SER_V":  LoginController().DeviceID,
        "SYDV_POI_V":"",
        "SYDV_ID_V":   LoginController().SYDV_ID,
        "SYDV_NO_V":   LoginController().SYDV_NO,
        "SYDV_BRA_V":1,
        "SYDV_LATITUDE_V":"",
        "SYDV_LONGITUDE_V":"",
        "SYDV_APPV_V": LoginController().APPV,
        "SOID_V":Acc_Mov_MList[i].AMKID.toString()=='2' ? "ACC_MOV_MO":Acc_Mov_MList[i].AMKID.toString()=='1'?'ACC_MOV_MI':
        Acc_Mov_MList[i].AMKID.toString()=='3'?'ACC_MOV_MC':'ACC_MOV_MJ',
        "STID_V":"",
        "TBNA_V":'ACC_MOV_M',
        "LAN_V": LoginController().LAN,
        "CIID_V":LoginController().CIID,
        "JTID_V":LoginController().JTID,
        "BIID_V":LoginController().BIID,
        "SYID_V":LoginController().SYID,
        "SUID_V":LoginController().SUID,
        "SUPA_V":LoginController().SUPA,
        "F_ROW_V":'0',
        "T_ROW_V":'0',
        "F_DAT_V": '',
        "T_DAT_V": '',
        "F_GUID_V":'',
        "WH_V1":'',
        "PAR_V":"",
        "JSON_V": data.toString(),
        "JSON_V2":"",
        "JSON_V3":""
      };
      var bodylang = utf8.encode(json.encode(params));
      var body = json.encode(params);
      try {
        final response = await http.post(Uri.parse("${LoginController().API}/ESAPI/ESPOST"),
            body: body,
            headers: {'Transfer-Encoding': 'chunked',
              HttpHeaders.contentTypeHeader: "application/json",
              'Content-Length': bodylang.length.toString(),
            });
        if (response.statusCode == 201 || response.statusCode == 200) {
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
            ..userInteractions = TypeSync=='ByDate'?false:true
            ..dismissOnTap = false;
         // INSERT_SYN_LOG('ACC_MOV_M','${SLINM} ${Acc_Mov_MList[i].AMMID}','U');
          TypeAuto==true?EasyLoading.showSuccess('StringSuccessfullySync'.tr):false;
          await UpdateStateACC_MOV_D(TypeSync, Acc_Mov_MList[i].AMKID.toString(), GETAMMID, 1,GETAMMST,GetFromDate, GetToDate);
          await UpdateStateACC_MOV_M(TypeSync, Acc_Mov_MList[i].AMKID.toString(), GETAMMID,GETAMMST,GetFromDate, GetToDate);
        } else {
          configloading('StrinError_Sync'.tr);
          Fluttertoast.showToast(
              msg: response.body,
              textColor: Colors.white,
              backgroundColor: Colors.red);
          INSERT_SYN_LOG('ACC_MOV_M','${response.body} ${Acc_Mov_MList[i].AMMID}','U');

        }
      } catch (e) {
        configloading('StrinError_Sync'.tr);
        Fluttertoast.showToast(
            msg: "response error ${e.toString()}",
            textColor: Colors.white,
            backgroundColor: Colors.red);
        INSERT_SYN_LOG('ACC_MOV_M','${e.toString()} ${Acc_Mov_MList[i].AMMID}','U');

        return Future.error(e);
      }
    }
  }

//السندات------------------------------


//العملاء------------------------------

  Future<List<Bil_Cus_Local>> FetchCustomerData(String TypeSync, String GETBCID) async {
    final dbClient = await conn.database;
    List<Bil_Cus_Local> CustomerList = [];
    String SQLBIID_L = LoginController().BIID_ALL_V == '1'
        ? " AND  BIID_L=${LoginController().BIID}" :  '';

    String SQL2 = ''' AND JTID_L=${LoginController().JTID} AND SYID_L=${LoginController().SYID} 
                  AND CIID_L=${LoginController().CIID} $SQLBIID_L''';
    print('ST----1');
    try {
      if (TypeSync == "SyncAll") {
        final maps = await dbClient!.query('BIL_CUS', where: 'SYST_L!=1 $SQL2 ');
        for (var item in maps) {
          CustomerList.add(Bil_Cus_Local.fromMap(item));
        }
      }
      else if (TypeSync == "SyncOnly") {
       // final maps = await dbClient!.query('BIL_CUS', where: ' BCID=$GETBCID AND SYST_L!=1');
        final maps = await dbClient!.query('BIL_CUS', where: ' BCID=$GETBCID ');
        for (var item in maps) {
          CustomerList.add(Bil_Cus_Local.fromMap(item));
        }
      }
    } catch (e) {
      print(e.toString());
    }
    return CustomerList;
  }

  Future<List<Bif_Cus_D_Local>> FetchBIF_CUS_D(String TypeSync, String GETBCID) async {
    final dbClient = await conn.database;
    List<Bif_Cus_D_Local> CustomerList = [];
    String SQLBIID_L = LoginController().BIID_ALL_V == '1'
        ? " AND  BIID_L=${LoginController().BIID}" :  '';

    String SQL2 = ''' AND JTID_L=${LoginController().JTID} AND SYID_L=${LoginController().SYID} 
                  AND CIID_L=${LoginController().CIID} $SQLBIID_L''';
    try {
      if (TypeSync == "SyncAll") {
        final maps = await dbClient!.query('BIF_CUS_D', where: 'SYST_L!=1 $SQL2 ');
        for (var item in maps) {
          CustomerList.add(Bif_Cus_D_Local.fromMap(item));
        }
      } else if (TypeSync == "SyncOnly") {
        final maps = await dbClient!.query('BIF_CUS_D', where: ' BCDID=$GETBCID AND SYST_L!=1');
        for (var item in maps) {
          CustomerList.add(Bif_Cus_D_Local.fromMap(item));
        }
      }
    } catch (e) {
      print(e.toString());
    }
    return CustomerList;
  }

  Future SyncCustomerToSystem(List<Bil_Cus_Local> CustomerList, String TypeSync, String GETBCID,int TypeMsg,TypeAuto) async {
    for (var i = 0; i < CustomerList.length; i++) {
      var data = {
        "BCID": CustomerList[i].BCID.toString(),
        "BCNA": CustomerList[i].BCNA.toString(),
        "BCNE": CustomerList[i].BCNE.toString(),
        "AANO": CustomerList[i].AANO.toString(),
        "BCST": 1,
        "BCTY": CustomerList[i].BCTY.toString(),
        "BCFN": CustomerList[i].BCFN.toString(),
        "BCTID": CustomerList[i].BCTID.toString(),
        "BCTL": CustomerList[i].BCTL.toString(),
        "BCFX": CustomerList[i].BCFX.toString(),
        "BCBX": CustomerList[i].BCBX.toString(),
        "BCMO": CustomerList[i].BCMO.toString(),
        "BCEM": CustomerList[i].BCEM.toString(),
        "BCWE": CustomerList[i].BCWE.toString(),
        "CWID": CustomerList[i].CWID.toString(),
        "CTID": CustomerList[i].CTID.toString(),
        "BCAD": CustomerList[i].BCAD.toString(),
        "BDID": CustomerList[i].BDID.toString(),
        "BAID": CustomerList[i].BAID.toString(),
        "BCLA": CustomerList[i].BCLA.toString(),
        "PKID": CustomerList[i].PKID.toString(),
        "BCBL": CustomerList[i].BCBL.toString(),
        "BCPR": CustomerList[i].BCPR.toString(),
        "BCBA":CustomerList[i].BCBA.toString(),
        "BCBAA":CustomerList[i].BCBAA.toString(),
        "BCIN":CustomerList[i].BCIN.toString(),
        "BCNAF":CustomerList[i].BCNAF.toString(),
        "OKID":CustomerList[i].OKID.toString(),
        "BCCT":CustomerList[i].BCCT.toString(),
        "SCID":CustomerList[i].SCID.toString(),
        "BCDM":CustomerList[i].BCDM.toString(),
        "BCHN":CustomerList[i].BCHN.toString(),
        "BCHT":CustomerList[i].BCHT.toString(),
        "BCHG":CustomerList[i].BCHG.toString(),
        "BCPS":CustomerList[i].BCPS.toString(),
        "BCPD":CustomerList[i].BCPD.toString(),
        "BCDO":CustomerList[i].BCDO.toString(),
        "SUID": CustomerList[i].SUID.toString(),
        "BCDC": CustomerList[i].BCDC.toString(),
        "SUCH": CustomerList[i].SUCH.toString(),
        "BIID": CustomerList[i].BIID.toString(),
        "GUID": CustomerList[i].GUID.toString(),
        "BCN3": CustomerList[i].BCN3.toString(),
        "BCQN": CustomerList[i].BCQN.toString(),
        "BCQND": CustomerList[i].BCQND.toString(),
        "BCSN": CustomerList[i].BCSN.toString(),
        "BCSND": CustomerList[i].BCSND.toString(),
        "BCBN": CustomerList[i].BCBN.toString(),
        "BCBND": CustomerList[i].BCBND.toString(),
        "BCON": CustomerList[i].BCON.toString(),
        "BCPC": CustomerList[i].BCPC.toString(),
        "BCAD2": CustomerList[i].BCAD2.toString(),
        "BCSA": CustomerList[i].BCSA.toString(),
        "BCSW": CustomerList[i].BCSW.toString(),
        "BCSWD": CustomerList[i].BCSWD.toString(),
        "BCAB": CustomerList[i].BCAB.toString(),
        "BCABD": CustomerList[i].BCABD.toString(),
        "BCAB2": CustomerList[i].BCAB2.toString(),
        "BCAB2D": CustomerList[i].BCAB2D.toString(),
        "BCTX": CustomerList[i].BCTX.toString(),
        "BCTXG": CustomerList[i].BCTXG.toString(),
        "BCTX2": CustomerList[i].BCTX2.toString(),
        "BCTX2G": CustomerList[i].BCTX2G.toString(),
        "BCC1": CustomerList[i].BCC1.toString(),
        "BCC2": CustomerList[i].BCC2.toString(),
        "BCC3": CustomerList[i].BCC3.toString(),
        "BCC4": CustomerList[i].BCC4.toString(),
        "BCC5": CustomerList[i].BCC5.toString(),
        "BCC6": CustomerList[i].BCC6.toString(),
        "BCC7": CustomerList[i].BCC7.toString(),
        "BCC8": CustomerList[i].BCC8.toString(),
        "BCC9": CustomerList[i].BCC9.toString(),
        "BCC10": CustomerList[i].ATTID.toString(),
        "DATEI": CustomerList[i].DATEI.toString(),
        "DATEU": CustomerList[i].DATEU.toString(),
        "DEVI": CustomerList[i].DEVI.toString(),
        "DEVU": CustomerList[i].DEVU.toString(),
        "BCLAT": CustomerList[i].BCLAT.toString(),
        "BCLON": CustomerList[i].BCLON.toString(),
        "BCJT": CustomerList[i].BCJT.toString(),
        "BCCR": CustomerList[i].BCCR.toString(),
        "STMID_CO":STMID,
        "SYDV_NAME":LoginController().DeviceName,
        "SYDV_IP":  LoginController().IP,
        "SYDV_TY":  LoginController().SYDV_TY,
        "SYDV_SER": LoginController().DeviceID,
        "SYDV_POI":"",
        "SYDV_ID":  LoginController().SYDV_ID,
        "SYDV_NO":  LoginController().SYDV_NO,
        "SYDV_LATITUDE":"",
        "SYDV_LONGITUDE":"",
        "SYDV_APPV":LoginController().APPV,
      };
      var params = {
        "STMID_CO_V": STMID,
        "SYDV_NAME_V": LoginController().DeviceName,
        "SYDV_IP_V":   LoginController().IP,
        "SYDV_TY_V":   LoginController().SYDV_TY,
        "SYDV_SER_V":  LoginController().DeviceID,
        "SYDV_POI_V":"",
        "SYDV_ID_V":   LoginController().SYDV_ID,
        "SYDV_NO_V":   LoginController().SYDV_NO,
        "SYDV_BRA_V":1,
        "SYDV_LATITUDE_V":"",
        "SYDV_LONGITUDE_V":"",
        "SYDV_APPV_V": LoginController().APPV,
        "SOID_V": "",
        "STID_V": "",
        "TBNA_V": 'BIL_CUS',
        "LAN_V": LoginController().LAN,
        "CIID_V":LoginController().CIID,
        "JTID_V":LoginController().JTID,
        "BIID_V":LoginController().BIID,
        "SYID_V":LoginController().SYID,
        "SUID_V":LoginController().SUID,
        "SUPA_V":LoginController().SUPA,
        "F_ROW_V":'0',
        "T_ROW_V":'0',
        "F_DAT_V": '',
        "T_DAT_V": '',
        "F_GUID_V":CustomerList[i].GUID.toString(),
        "WH_V1":'',
        "PAR_V":"",
        "JSON_V": data.toString(),
        "JSON_V2":"",
        "JSON_V3":""
      };
      var bodylang = utf8.encode(json.encode(params));
      var body = json.encode(params);
      try {
        final response = await http.post(Uri.parse("${LoginController().API}/ESAPI/ESPOST"),
            body: body,
            headers: {'Transfer-Encoding': 'chunked',
              HttpHeaders.contentTypeHeader: "application/json",
              'Content-Length': bodylang.length.toString(),
            });
        if (response.statusCode == 201 || response.statusCode == 200) {
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
            ..userInteractions = TypeSync=='ByDate'?false:true
            ..dismissOnTap = false;
          TypeAuto==true?EasyLoading.show(status:  "${'StringWeAreSync'.tr}${'StringCustomer_Home'.tr}..${i+1}..${CustomerList.length}"):false;
          WH_V1='';
          F_GUID_V=CustomerList[i].GUID.toString();
          TAB_N=  'BIL_CUS';
          INSERT_SYN_LOG('BIL_CUS',SLINM,'U');
          print('ST----2');
         await GetAllBIL_CUS(F_GUID_V ,TypeSync,CustomerList[i].BCID!,TypeMsg);
        }
        else {
          configloading('StrinError_Sync'.tr);
          Fluttertoast.showToast(
              msg: response.body,
              textColor: Colors.white,
              backgroundColor: Colors.red);
          INSERT_SYN_LOG('BIL_CUS',response.body,'U');

        }
      } catch (e) {
        configloading('StrinError_Sync'.tr);
        Fluttertoast.showToast(
            msg: "response error ${e.toString()}",
            textColor: Colors.white,
            backgroundColor: Colors.red);
        INSERT_SYN_LOG('BIL_CUS',e.toString(),'U');
        return Future.error(e);
      }
    }
  }

  Future SyncBIF_CUS_D_ToSystem(List<Bif_Cus_D_Local> CustomerList, String TypeSync, String GETBCID,int TypeMsg) async {
    for (var i = 0; i < CustomerList.length; i++) {
      var data = {
        "BCDID": CustomerList[i].BCDID.toString(),
        "BCDDO": CustomerList[i].BCDDO.toString(),
        "BCDNA": CustomerList[i].BCDNA.toString(),
        "BCDMO": CustomerList[i].BCDMO.toString(),
        "BCDTL": CustomerList[i].BCDTL.toString(),
        "BCDAD": CustomerList[i].BCDAD.toString(),
        "CWID": CustomerList[i].CWID.toString(),
        "CTID": CustomerList[i].CTID.toString(),
        "BAID": CustomerList[i].BAID.toString(),
        "BCDSN": CustomerList[i].BCDSN.toString(),
        "BCDBN": CustomerList[i].BCDBN.toString(),
        "BCDFN": CustomerList[i].BCDFN.toString(),
        "BCDHN": CustomerList[i].BCDHN.toString(),
        "BCDST": CustomerList[i].BCDST.toString(),
        "BCDIN": CustomerList[i].BCDIN.toString(),
        "BCID": CustomerList[i].BCID.toString(),
        "EAID": CustomerList[i].EAID.toString(),
        "GUIDE": CustomerList[i].GUIDE.toString(),
        "GUID": CustomerList[i].GUID.toString(),
        "SYUP":CustomerList[i].SYUP.toString(),
        "BCDMO2":CustomerList[i].BCDMO2.toString(),
        "BCDMO3":CustomerList[i].BCDMO3.toString(),
        "BCDMO4":CustomerList[i].BCDMO4.toString(),
        "BCDMO5":CustomerList[i].BCDMO5.toString(),
        "GUIDC":CustomerList[i].GUIDC.toString(),
        "RES":CustomerList[i].RES.toString(),
        "BCDNE":CustomerList[i].BCDNE.toString(),
        "BCDN3":CustomerList[i].BCDN3.toString(),
        "ORDNU":CustomerList[i].ORDNU.toString(),
        "SUID": CustomerList[i].SUID.toString(),
        "SUCH": CustomerList[i].SUCH.toString(),
        "DATEI": CustomerList[i].DATEI.toString(),
        "DATEU": CustomerList[i].DATEU.toString(),
        "DEVI": CustomerList[i].DEVI.toString(),
        "DEVU": CustomerList[i].DEVU.toString(),
        "STMID_CO":STMID,
        "SYDV_NAME":LoginController().DeviceName,
        "SYDV_IP":  LoginController().IP,
        "SYDV_TY":  LoginController().SYDV_TY,
        "SYDV_SER": LoginController().DeviceID,
        "SYDV_POI":"",
        "SYDV_ID":  LoginController().SYDV_ID,
        "SYDV_NO":  LoginController().SYDV_NO,
        "SYDV_LATITUDE":"",
        "SYDV_LONGITUDE":"",
        "SYDV_APPV":LoginController().APPV,
      };
      var params = {
        "STMID_CO_V": STMID,
        "SYDV_NAME_V": LoginController().DeviceName,
        "SYDV_IP_V":   LoginController().IP,
        "SYDV_TY_V":   LoginController().SYDV_TY,
        "SYDV_SER_V":  LoginController().DeviceID,
        "SYDV_POI_V":"",
        "SYDV_ID_V":   LoginController().SYDV_ID,
        "SYDV_NO_V":   LoginController().SYDV_NO,
        "SYDV_BRA_V":1,
        "SYDV_LATITUDE_V":"",
        "SYDV_LONGITUDE_V":"",
        "SYDV_APPV_V": LoginController().APPV,
        "SOID_V": "",
        "STID_V": "",
        "TBNA_V": 'BIF_CUS_D',
        "LAN_V": LoginController().LAN,
        "CIID_V":LoginController().CIID,
        "JTID_V":LoginController().JTID,
        "BIID_V":LoginController().BIID,
        "SYID_V":LoginController().SYID,
        "SUID_V":LoginController().SUID,
        "SUPA_V":LoginController().SUPA,
        "F_ROW_V":'0',
        "T_ROW_V":'0',
        "F_DAT_V": '',
        "T_DAT_V": '',
        "F_GUID_V":CustomerList[i].GUID.toString(),
        "WH_V1":'',
        "PAR_V":"",
        "JSON_V": data.toString(),
        "JSON_V2":"",
        "JSON_V3":""
      };
      var bodylang = utf8.encode(json.encode(params));
      var body = json.encode(params);
      try {
        final response = await http.post(Uri.parse("${LoginController().API}/ESAPI/ESPOST"),
            body: body,
            headers: {'Transfer-Encoding': 'chunked',
              HttpHeaders.contentTypeHeader: "application/json",
              'Content-Length': bodylang.length.toString(),
            });
        if (response.statusCode == 201 || response.statusCode == 200) {
          WH_V1='';
          F_GUID_V=CustomerList[i].GUID.toString();
          TAB_N=  'BIF_CUS_D';
          INSERT_SYN_LOG('BIF_CUS_D',SLINM,'U');
          getAllBIF_CUS_D(F_GUID_V ,TypeSync,CustomerList[i].BCDID!,TypeMsg);
        }
        else {
          configloading('StrinError_Sync'.tr);
          Fluttertoast.showToast(
              msg: response.body,
              textColor: Colors.white,
              backgroundColor: Colors.red);
          INSERT_SYN_LOG('BIF_CUS_D',response.body,'U');

        }
      } catch (e) {
        configloading('StrinError_Sync'.tr);
        Fluttertoast.showToast(
            msg: "response error ${e.toString()}",
            textColor: Colors.white,
            backgroundColor: Colors.red);
        INSERT_SYN_LOG('BIF_CUS_D',e.toString(),'U');
        return Future.error(e);
      }
    }
  }

  Future<dynamic> GetAllBIL_CUS(String GETGUID,String TypeSync,int GETBCID,int TypeMsg) async {
    var url = "${LoginController().API}/ESAPI/ESGET";
    var Getparams = {
      "STMID_CO_V": STMID,
      "SYDV_NAME_V": LoginController().DeviceName,
      "SYDV_IP_V": LoginController().IP,
      "SYDV_TY_V":  LoginController().SYDV_TY,
      "SYDV_SER_V": LoginController().DeviceID,
      "SYDV_POI_V":"",
      "SYDV_ID_V":LoginController().SYDV_ID,
      "SYDV_NO_V":LoginController().SYDV_NO,
      "SYDV_BRA_V":1,
      "SYDV_LATITUDE_V":"",
      "SYDV_LONGITUDE_V":"",
      "SYDV_APPV_V":LoginController().APPV,
      "SOID_V":"",
      "STID_V":"",
      "TBNA_V":TAB_N,
      "LAN_V":LoginController().LAN,
      "CIID_V":LoginController().CIID,
      "JTID_V":LoginController().JTID,
      "BIID_V":LoginController().BIID,
      "SYID_V":LoginController().SYID,
      "SUID_V":LoginController().SUID,
      "SUPA_V":LoginController().SUPA,
      "F_ROW_V":'',
      "T_ROW_V":'',
      "F_DAT_V": '',
      "T_DAT_V": '',
      "F_GUID_V":F_GUID_V,
      "WH_V1": WH_V1,
      "PAR_V":"",
      "JSON_V":"",
      "JSON_V2":"",
      "JSON_V3":""
    };
    try {
      var response = await Dio().get(url,queryParameters: Getparams);
      if (response.statusCode == 200) {
        return (response.data)['result'].map((data) async {
          F_GUID_V='';
          await SaveBIL_CUS(Bil_Cus_Local.fromMap(data));
          // SaveSyncData(data,'BIL_CUS_TMP');
          await DeleteDataByGUID('BIL_CUS',GETGUID);
          await GET_SYN_ORD_P('ACC_ACC');
          print('ST----3');
         // await Future.delayed(const Duration(milliseconds: 600));
          var AANOValue = (response.data)['result'][0]['AANO'].toString();
          await  GetAllACC_ACC(AANOValue,GETGUID,TypeMsg);
          await INSERT_SYN_LOG('BIL_CUS',SLINM,'U');
          await UpdateStateBIL_CUS(TypeSync, GETBCID);
        }).toList();
      }
      else if (response.statusCode == 207) {
        TypeMsg==1? configloading('StrinError_Sync'.tr):false;
        Fluttertoast.showToast(
            msg: "${response.data}",
            toastLength: Toast.LENGTH_LONG,
            textColor: Colors.white,
            backgroundColor: Colors.red);
        INSERT_SYN_LOG('BIL_CUS',response.data,'U');

      }
      else {
        TypeMsg==1? configloading('StrinError_Sync'.tr):false;
        Fluttertoast.showToast(
            msg: "response error: ${response.statusCode}",
            toastLength: Toast.LENGTH_LONG,
            textColor: Colors.white,
            backgroundColor: Colors.red);
        INSERT_SYN_LOG('BIL_CUS',response.statusCode,'U');
        throw Exception("response error: ${response.data}");
      }
    } on DioException catch (e) {
      TypeMsg==1? configloading('StrinError_Sync'.tr):false;
      Fluttertoast.showToast(
          msg: 'StringCHK_Con'.tr,
          toastLength: Toast.LENGTH_LONG,
          textColor: Colors.white,
          backgroundColor: Colors.red);
      INSERT_SYN_LOG('BIL_CUS',e.message,'U');
      return Future.error("response error: ${e.message}");
    }
  }

  Future<dynamic> getAllBIF_CUS_D(String GETGUID,String TypeSync,int GETBCID,int TypeMsg) async {
    var url = "${LoginController().API}/ESAPI/ESGET";
    var Getparams = {
      "STMID_CO_V": STMID,
      "SYDV_NAME_V": LoginController().DeviceName,
      "SYDV_IP_V": LoginController().IP,
      "SYDV_TY_V":  LoginController().SYDV_TY,
      "SYDV_SER_V": LoginController().DeviceID,
      "SYDV_POI_V":"",
      "SYDV_ID_V":LoginController().SYDV_ID,
      "SYDV_NO_V":LoginController().SYDV_NO,
      "SYDV_BRA_V":1,
      "SYDV_LATITUDE_V":"",
      "SYDV_LONGITUDE_V":"",
      "SYDV_APPV_V":LoginController().APPV,
      "SOID_V":"",
      "STID_V":"",
      "TBNA_V":TAB_N,
      "LAN_V":LoginController().LAN,
      "CIID_V":LoginController().CIID,
      "JTID_V":LoginController().JTID,
      "BIID_V":LoginController().BIID,
      "SYID_V":LoginController().SYID,
      "SUID_V":LoginController().SUID,
      "SUPA_V":LoginController().SUPA,
      "F_ROW_V":'',
      "T_ROW_V":'',
      "F_DAT_V": '',
      "T_DAT_V": '',
      "F_GUID_V":F_GUID_V,
      "WH_V1": WH_V1,
      "PAR_V":"",
      "JSON_V":"",
      "JSON_V2":"",
      "JSON_V3":""
    };
    try {
      var response = await Dio().get(url,queryParameters: Getparams);
      if (response.statusCode == 200) {
        return (response.data)['result'].map((data) async {
          F_GUID_V='';
          SaveBIF_CUS_D(Bif_Cus_D_Local.fromMap(data));
          DeleteDataByGUID('BIF_CUS_D',GETGUID);
          UpdateStateBIF_CUS_D(TypeSync, GETBCID);
        }).toList();
      }
      else if (response.statusCode == 207) {
        Fluttertoast.showToast(
            msg: "${response.data}",
            toastLength: Toast.LENGTH_LONG,
            textColor: Colors.white,
            backgroundColor: Colors.red);
        INSERT_SYN_LOG('BIF_CUS_D',response.data,'U');

      }
      else {
        Fluttertoast.showToast(
            msg: "response error: ${response.statusCode}",
            toastLength: Toast.LENGTH_LONG,
            textColor: Colors.white,
            backgroundColor: Colors.red);
        INSERT_SYN_LOG('BIF_CUS_D',response.statusCode,'U');
        throw Exception("response error: ${response.data}");
      }
    } on DioException catch (e) {
      Fluttertoast.showToast(
          msg: 'StringCHK_Con'.tr,
          toastLength: Toast.LENGTH_LONG,
          textColor: Colors.white,
          backgroundColor: Colors.red);
      INSERT_SYN_LOG('BIF_CUS_D',e.message,'U');
      return Future.error("response error: ${e.message}");
    }
  }
  late List<SYN_ORD_Local> SYN_ORD;

  GET_SYN_ORD_P(GETTYPE) async {
    SYN_ORD=await GET_SYN_ORD(GETTYPE);
      if (SYN_ORD.isNotEmpty) {
        FROM_DATE = SYN_ORD.elementAt(0).SOLD.toString();
      }

  }

  Future<dynamic> GetAllACC_ACC(String AANOValue,String GETGUID,TypeMsg) async {
    var url = "${LoginController().API}/ESAPI/ESGET";
    var AANO=' AND A.AANO=<<${AANOValue}>>';
    var Getparams = {
      "STMID_CO_V": STMID,
      "SYDV_NAME_V": LoginController().DeviceName,
      "SYDV_IP_V": LoginController().IP,
      "SYDV_TY_V":  LoginController().SYDV_TY,
      "SYDV_SER_V": LoginController().DeviceID,
      "SYDV_POI_V":"",
      "SYDV_ID_V":LoginController().SYDV_ID,
      "SYDV_NO_V":LoginController().SYDV_NO,
      "SYDV_BRA_V":1,
      "SYDV_LATITUDE_V":"",
      "SYDV_LONGITUDE_V":"",
      "SYDV_APPV_V":LoginController().APPV,
      "SOID_V":"",
      "STID_V":"",
      "TBNA_V":'ACC_ACC',
      "LAN_V":LoginController().LAN,
      "CIID_V":LoginController().CIID,
      "JTID_V":LoginController().JTID,
      "BIID_V":LoginController().BIID,
      "SYID_V":LoginController().SYID,
      "SUID_V":LoginController().SUID,
      "SUPA_V":LoginController().SUPA,
      "F_ROW_V":'',
      "T_ROW_V":'',
      "F_DAT_V": '',
      "T_DAT_V": '',
      "F_GUID_V":'',
      "WH_V1": '$AANO',
      "PAR_V":"",
      "JSON_V":"",
      "JSON_V2":"",
      "JSON_V3":""
    };
    try {
      var response = await Dio().get(url,queryParameters: Getparams);
      if (response.statusCode == 200) {
        return (response.data)['result'].map((data) async {
          print('ST----4');
          await SaveACC_ACC(Acc_Acc_Local.fromMap(data));
          var AANOValue =(response.data)['result'][0]['AANO'].toString();
          await DeleteDataByGUID('ACC_ACC',GETGUID);
          await INSERT_SYN_LOG('ACC_ACC',SLINM,'D');
          await UpdateStateACC('ACC_ACC');
          await GetAllACC_USR(AANOValue,GETGUID,TypeMsg);
        }).toList();
      }
      else if (response.statusCode == 207) {
        TypeMsg==1? configloading('StrinError_Sync'.tr):false;
        Fluttertoast.showToast(
            msg: "${response.data}",
            toastLength: Toast.LENGTH_LONG,
            textColor: Colors.white,
            backgroundColor: Colors.red);
        INSERT_SYN_LOG('ACC_ACC',response.data,'U');
      }
      else {
        TypeMsg==1? configloading('StrinError_Sync'.tr):false;
        Fluttertoast.showToast(
            msg: "response error: ${response.statusCode}",
            toastLength: Toast.LENGTH_LONG,
            textColor: Colors.white,
            backgroundColor: Colors.red);
        INSERT_SYN_LOG('ACC_ACC',response.statusCode,'U');
        throw Exception("response error: ${response.data}");
      }
    } on DioException catch (e) {
      TypeMsg==1? configloading('StrinError_Sync'.tr):false;
      Fluttertoast.showToast(
          msg: 'StringCHK_Con'.tr,
          toastLength: Toast.LENGTH_LONG,
          textColor: Colors.white,
          backgroundColor: Colors.red);
      INSERT_SYN_LOG('ACC_ACC',e.message,'U');
      return Future.error("response error: ${e.message}");
    }
  }

  Future<dynamic> GetAllACC_USR(String AANOValue,String GETGUID,int TypeMsg) async {
    var url = "${LoginController().API}/ESAPI/ESGET";
    var AANO=' AND A.AANO=<<${AANOValue}>>';
    var Getparams = {
      "STMID_CO_V": STMID,
      "SYDV_NAME_V": LoginController().DeviceName,
      "SYDV_IP_V": LoginController().IP,
      "SYDV_TY_V":  LoginController().SYDV_TY,
      "SYDV_SER_V": LoginController().DeviceID,
      "SYDV_POI_V":"",
      "SYDV_ID_V":LoginController().SYDV_ID,
      "SYDV_NO_V":LoginController().SYDV_NO,
      "SYDV_BRA_V":1,
      "SYDV_LATITUDE_V":"",
      "SYDV_LONGITUDE_V":"",
      "SYDV_APPV_V":LoginController().APPV,
      "SOID_V":"",
      "STID_V":"",
      "TBNA_V":'ACC_USR',
      "LAN_V":LoginController().LAN,
      "CIID_V":LoginController().CIID,
      "JTID_V":LoginController().JTID,
      "BIID_V":LoginController().BIID,
      "SYID_V":LoginController().SYID,
      "SUID_V":LoginController().SUID,
      "SUPA_V":LoginController().SUPA,
      "F_ROW_V":'',
      "T_ROW_V":'',
      "F_DAT_V": '',
      "T_DAT_V": '',
      "F_GUID_V":'',
      "WH_V1": '$AANO',
      "PAR_V":"",
      "JSON_V":"",
      "JSON_V2":"",
      "JSON_V3":""
    };
    try {
      var response = await Dio().get(url,queryParameters: Getparams);
      if (response.statusCode == 200) {
        List<dynamic> arr = response.data['result'];
        if(arr.length==0){ TypeMsg==1? EasyLoading.showSuccess('StringSuccessfullySync'.tr):false;}
        return (response.data)['result'].map((data) async {
          print('ST----5');
          await SaveACC_USR(Acc_Usr_Local.fromMap(data));
          TypeMsg==1? EasyLoading.showSuccess('StringSuccessfullySync'.tr):false;
          await DeleteDataByGUID('ACC_USR',GETGUID);
          await INSERT_SYN_LOG('ACC_USR',SLINM,'D');
          await UpdateStateACC('ACC_USR');
        }).toList();
      }
      else if (response.statusCode == 207) {
        TypeMsg==1?  configloading('StrinError_Sync'.tr):false;
        Fluttertoast.showToast(
            msg: "${response.data}",
            toastLength: Toast.LENGTH_LONG,
            textColor: Colors.white,
            backgroundColor: Colors.red);
        INSERT_SYN_LOG('ACC_USR',response.data,'U');
      }
      else {
        TypeMsg==1? configloading('StrinError_Sync'.tr):false;
        Fluttertoast.showToast(
            msg: "response error: ${response.statusCode}",
            toastLength: Toast.LENGTH_LONG,
            textColor: Colors.white,
            backgroundColor: Colors.red);
        INSERT_SYN_LOG('ACC_USR',response.statusCode,'U');
        throw Exception("response error: ${response.data}");
      }
    } on DioException catch (e) {
      TypeMsg==1? configloading('StrinError_Sync'.tr):false;
      Fluttertoast.showToast(
          msg: 'StringCHK_Con'.tr,
          toastLength: Toast.LENGTH_LONG,
          textColor: Colors.white,
          backgroundColor: Colors.red);
      INSERT_SYN_LOG('ACC_USR',e.message,'U');
      return Future.error("response error: ${e.message}");
    }
  }

//العملاء------------------------------



//تغيير كلمة المرور----------------------------

  Future<List<Sys_Usr_Local>> FetchSYS_USR() async {
    final dbClient = await conn.database;
    List<Sys_Usr_Local> SYS_USR_List = [];
    String SQLBIID_L = LoginController().BIID_ALL_V == '1'
        ? " AND  BIID_L=${LoginController().BIID}" :  '';

    String SQL2 = ''' AND JTID_L=${LoginController().JTID} AND SYID_L=${LoginController().SYID} 
                  AND CIID_L=${LoginController().CIID} $SQLBIID_L''';
    try {
      final maps = await dbClient!.query('SYS_USR', where: " SUID='${LoginController().SUID}' $SQL2");
      for (var item in maps) {
        SYS_USR_List.add(Sys_Usr_Local.fromMap(item));
      }
    } catch (e) {
      print(e.toString());
    }
    return SYS_USR_List;
  }

  Future SyncSYS_USR(String GETSUPA) async {
    await SyncronizationData().FetchSYS_USR().then((SYS_USRList) async {
      if (SYS_USRList.isNotEmpty && SYS_USRList.length>0) {
        await SyncronizationData().SyncSYS_USRToSystem(SYS_USRList,GETSUPA);
      } else{
        configloading("StringNoDataSync".tr);
      }
    });
  }

  int A = 0;

  //فك تشفير كلمة المرور
  Future CONV_P(String F_PAS) async {
    int X;
    A = 0;
    X = (F_PAS.length) + 1;
    for (int i = 1; i < X; i++) {
      print(
          ' ASCII value of ${F_PAS[i - 1]} is ${A = (A + F_PAS.codeUnitAt(i - 1)) * (i + 1)}');
    }
    print(' ASCII value of ${F_PAS} is ${(A)}');
  }

  Future GET_SUAP() async {
    GET_USR_NAME(LoginController().SUID).then((data) {
      if(data.isNotEmpty) {
        LoginController().SET_P('SUPA',data.elementAt(0).SUPA.toString());
      }
    });
  }

  Future SyncSYS_USRToSystem(List<Sys_Usr_Local> CustomerList,String GETSUPA) async {
    for (var i = 0; i < CustomerList.length; i++) {
      var data = {
        "SUID": CustomerList[i].SUID.toString(),
        "SUNA": CustomerList[i].SUNA.toString(),
        "SUNE": CustomerList[i].SUNE.toString(),
        "SUPA": GETSUPA.toString(),
        "SULA": CustomerList[i].SULA.toString(),
        "SUST": CustomerList[i].SUST.toString(),
        "SUCP": CustomerList[i].SUCP.toString(),
        "SUAC": CustomerList[i].SUAC.toString(),
        "SUDA": CustomerList[i].SUDA.toString(),
        "SUJO": CustomerList[i].SUJO.toString(),
        "SUEM": CustomerList[i].SUEM.toString(),
        "SUTL": CustomerList[i].SUTL.toString(),
        "SUMO": CustomerList[i].SUMO.toString(),
        "SUFX": CustomerList[i].SUFX.toString(),
        "SUAD": CustomerList[i].SUAD.toString(),
        "BIID": CustomerList[i].BIID.toString(),
        "GUID": CustomerList[i].GUID.toString(),
        "SUEX": CustomerList[i].SUEX.toString(),
        "SUCH": LoginController().SUID,
        "DATEU": DateFormat('dd-MM-yyyy HH:mm:ss').format(DateTime.now()),
        "DATEI": CustomerList[i].DATEI.toString(),
        "DEVI": CustomerList[i].DEVI.toString(),
        "DEVU": CustomerList[i].DEVU.toString(),
        "STMID_CO":STMID,
        "SYDV_NAME":LoginController().DeviceName,
        "SYDV_IP":  LoginController().IP,
        "SYDV_TY":  LoginController().SYDV_TY,
        "SYDV_SER": LoginController().DeviceID,
        "SYDV_POI":"",
        "SYDV_ID":  LoginController().SYDV_ID,
        "SYDV_NO":  LoginController().SYDV_NO,
        "SYDV_LATITUDE":"",
        "SYDV_LONGITUDE":"",
        "SYDV_APPV":LoginController().APPV,
      };
      var params = {
        "STMID_CO_V": STMID,
        "SYDV_NAME_V": LoginController().DeviceName,
        "SYDV_IP_V":   LoginController().IP,
        "SYDV_TY_V":   LoginController().SYDV_TY,
        "SYDV_SER_V":  LoginController().DeviceID,
        "SYDV_POI_V":"",
        "SYDV_ID_V":   LoginController().SYDV_ID,
        "SYDV_NO_V":   LoginController().SYDV_NO,
        "SYDV_BRA_V":1,
        "SYDV_LATITUDE_V":"",
        "SYDV_LONGITUDE_V":"",
        "SYDV_APPV_V": LoginController().APPV,
        "SOID_V": "",
        "STID_V": "",
        "TBNA_V": 'SYS_USR',
        "LAN_V": LoginController().LAN,
        "CIID_V":LoginController().CIID,
        "JTID_V":LoginController().JTID,
        "BIID_V":LoginController().BIID,
        "SYID_V":LoginController().SYID,
        "SUID_V":LoginController().SUID,
        "SUPA_V":LoginController().SUPA,
        "F_ROW_V":'0',
        "T_ROW_V":'0',
        "F_DAT_V": '',
        "T_DAT_V": '',
        "F_GUID_V":'',
        "WH_V1":'',
        "PAR_V":"",
        "JSON_V": data.toString(),
        "JSON_V2":"",
        "JSON_V3":""
      };
      var bodylang = utf8.encode(json.encode(params));
      var body = json.encode(params);
      try {
        final response = await http.post(Uri.parse("${LoginController().API}/ESAPI/ESPOST"),
            body: body,
            headers: {'Transfer-Encoding': 'chunked',
              HttpHeaders.contentTypeHeader: "application/json",
              'Content-Length': bodylang.length.toString(),
            });
        if (response.statusCode == 201 || response.statusCode == 200) {
          await Future.delayed(const Duration(seconds: 1));
          TAB_N = "SYS_USR_P";
          ApiProviderLogin().getAllSYS_USR_P();
          CONV_P(GETSUPA);
          INSERT_SYN_LOG('SYS_USR_P',SLINM,'U');
          await Future.delayed(const Duration(seconds: 1));
          // TAB_N = "SYS_USR";
          // ApiProviderLogin().getAllSYS_USR2();
          // INSERT_SYN_LOG('SYS_USR',SLIN,'U');
          UpdateSYS_USR(A.toString());
          LoginController().SET_P('SUPA',A.toString());
          //  GET_SUAP();
          await Future.delayed(const Duration(seconds: 1));
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
          EasyLoading.showSuccess('StringSuccessfullySync'.tr);
        }
        else {
          configloading('StrinError_Sync'.tr);
          Fluttertoast.showToast(
              msg: response.body,
              textColor: Colors.white,
              backgroundColor: Colors.red);
          INSERT_SYN_LOG('BIL_CUS',response.body,'U');

        }
      } catch (e) {
        configloading('StrinError_Sync'.tr);
        Fluttertoast.showToast(
            msg: "response error ${e.toString()}",
            textColor: Colors.white,
            backgroundColor: Colors.red);
        INSERT_SYN_LOG('BIL_CUS',e.toString(),'U');
        return Future.error(e);
      }
    }
  }


// الجرد -------------------------------


  Future<List<STO_MOV_M_Local>> FetchSTO_MOV_MData(
      String TypeSync, int GetSMKID, String GetSMMID) async {
    final dbClient = await conn.database;
    List<STO_MOV_M_Local> contactList = [];
    String SQLBIID_L = LoginController().BIID_ALL_V == '1'
        ? " AND  BIID_L=${LoginController().BIID}" :  '';

    String SQL2 = ''' AND JTID_L=${LoginController().JTID} AND SYID_L=${LoginController().SYID} 
                  AND CIID_L=${LoginController().CIID} $SQLBIID_L''';

    try {
      if (TypeSync == "SyncAll") {
        final maps = await dbClient!.query('STO_MOV_M', where: ' SMKID=$GetSMKID AND SMMST=2 $SQL2');
        for (var item in maps) {
          contactList.add(STO_MOV_M_Local.fromMap(item));
        }
      } else if (TypeSync == "SyncOnly") {
        final maps = await dbClient!.query('STO_MOV_M', where: ' SMMID=$GetSMMID ');
        for (var item in maps) {
          contactList.add(STO_MOV_M_Local.fromMap(item));
        }
      }
    } catch (e) {
      print(e.toString());
    }
    return contactList;
  }

  Future<List<Sto_Mov_D_Local>> FetchSTO_MOV_DData(
      String TypeSync, int GetSMKID, String GetSMMID) async {
    final dbClient = await conn.database;
    List<Sto_Mov_D_Local> List_D = [];
    String SQLBIID_L = LoginController().BIID_ALL_V == '1'
        ? " AND  BIID_L=${LoginController().BIID}" :  '';

    String SQL2 = ''' AND JTID_L=${LoginController().JTID} AND SYID_L=${LoginController().SYID} 
                  AND CIID_L=${LoginController().CIID} $SQLBIID_L''';

    try {
      if (TypeSync == "SyncAll") {
        final maps = await dbClient!.query('STO_MOV_D',
            where: 'SMKID=$GetSMKID AND SYST=2 $SQL2');
        for (var item in maps) {
          List_D.add(Sto_Mov_D_Local.fromMap(item));
        }
      } else if (TypeSync == "SyncOnly") {
        final maps = await dbClient!.query('STO_MOV_D',
            where: ' SMMID=$GetSMMID $SQL2');
        for (var item in maps) {
          List_D.add(Sto_Mov_D_Local.fromMap(item));
        }
      }
    } catch (e) {
      print(e.toString());
    }
    return List_D;
  }

  Future SyncSTO_MOV_DToSystem(List<Sto_Mov_D_Local> List_D, String TypeSync,
      String GetSMMID, int GetSMKID,String GetSOID,bool TypeAuto) async {
    for (var i = 0; i < List_D.length; i++) {
      print('List_D[i].SIID.toString()');
      print(List_D[i].SIID.toString());
      var data = {
        "SMMID": List_D[i].SMMID.toString(),
        "SMKID": List_D[i].SMKID.toString(),
        "SMDID": List_D[i].SMDID.toString(),
        "MGNO": List_D[i].MGNO.toString(),
        "MINO": List_D[i].MINO.toString(),
        "MUID": List_D[i].MUID.toString(),
        "SMDNF": List_D[i].SMDNF.toString(),
        "SMDNO": List_D[i].SMDNO.toString(),
        "SMDAM": List_D[i].SMDAM.toString(),
        "SMDEQ": List_D[i].SMDEQ.toString(),
        "SMDEQC": List_D[i].SMDEQC.toString(),
        "SMDED": List_D[i].SMDED.toString(),
        "SIID": List_D[i].SIID.toString(),
        "SMDDIF": List_D[i].SMDDIF.toString(),
        "SMDAMR": List_D[i].SMDAMR.toString(),
        "SMDAMRE": List_D[i].SMDAMRE.toString(),
        "SIIDT": List_D[i].SIIDT.toString(),
        "BIID": List_D[i].BIID.toString(),
        "GUID": List_D[i].GUID.toString(),
        "GUIDM": List_D[i].GUIDM.toString(),
        "GUIDM_L": List_D[i].GUIDM.toString(),
        "SUID": List_D[i].SUID.toString(),
        "DATEI": List_D[i].DATEI.toString(),
        "DEVI": List_D[i].DEVI.toString(),
        "SUCH": List_D[i].SUCH.toString(),
        "DATEU": List_D[i].DATEU.toString(),
        "DEVU": List_D[i].DEVU.toString(),
        "STMID_CO":'INVC',
        "SYDV_NAME": LoginController().DeviceName,
        "SYDV_IP": LoginController().IP,
        "SYDV_TY":  LoginController().SYDV_TY,
        "SYDV_SER": LoginController().DeviceID,
        "SYDV_POI":"",
        "SYDV_ID_V":LoginController().SYDV_ID_V,
        "SYDV_NO_V":LoginController().SYDV_NO_V,
        "SYDV_BRA_N":1,
        "SYDV_LATITUDE":"",
        "SYDV_LONGITUDE":"",
        "SYDV_APPV_V":LoginController().APPV,
      };
      var data2 = {
        "SRMID": List_D[i].SMMID.toString(),
        "SMKID": List_D[i].SMKID.toString(),
        "SRDID": List_D[i].SMDID.toString(),
        "MGNO": List_D[i].MGNO.toString(),
        "MINO": List_D[i].MINO.toString(),
        "MUID": List_D[i].MUID.toString(),
        "SRDNF": List_D[i].SMDNF.toString(),
        "SRDNO": List_D[i].SMDNO.toString(),
        "SRDAM": List_D[i].SMDAM.toString(),
        "SRDEQ": List_D[i].SMDEQ.toString(),
        "SRDEQC": List_D[i].SMDEQC.toString(),
        "SRDED": List_D[i].SMDED.toString(),
        "SIID": List_D[i].SIID.toString(),
        "SRDDIF": List_D[i].SMDDIF.toString(),
        "SRDAMR": List_D[i].SMDAMR.toString(),
        "SRDAMRE": List_D[i].SMDAMRE.toString(),
        "SIIDT": List_D[i].SIIDT.toString(),
        "BIID": List_D[i].BIID.toString(),
        "GUID": List_D[i].GUID.toString(),
        "GUIDM": List_D[i].GUIDM.toString(),
        "GUIDM_L": List_D[i].GUIDM.toString(),
        "SUID": List_D[i].SUID.toString(),
        "DATEI": List_D[i].DATEI.toString(),
        "DEVI": List_D[i].DEVI.toString(),
        "SUCH": List_D[i].SUCH.toString(),
        "DATEU": List_D[i].DATEU.toString(),
        "DEVU": List_D[i].DEVU.toString(),
        "STMID_CO":'INVC',
        "SYDV_NAME": LoginController().DeviceName,
        "SYDV_IP": LoginController().IP,
        "SYDV_TY":  LoginController().SYDV_TY,
        "SYDV_SER": LoginController().DeviceID,
        "SYDV_POI":"",
        "SYDV_ID_V":LoginController().SYDV_ID_V,
        "SYDV_NO_V":LoginController().SYDV_NO_V,
        "SYDV_BRA_N":1,
        "SYDV_LATITUDE":"",
        "SYDV_LONGITUDE":"",
        "SYDV_APPV_V":LoginController().APPV,
      };
      var params2 = {
        "STMID_CO_V": "INVC",
        "SYDV_NAME_V": LoginController().DeviceName,
        "SYDV_IP_V": LoginController().IP,
        "SYDV_TY_V":  LoginController().SYDV_TY,
        "SYDV_SER_V": LoginController().DeviceID,
        "SYDV_POI_V":"",
        "SYDV_ID_V":LoginController().SYDV_ID,
        "SYDV_NO_V":LoginController().SYDV_NO,
        "SYDV_BRA_V":1,
        "SYDV_LATITUDE_V":"",
        "SYDV_LONGITUDE_V":"",
        "SYDV_APPV_V":LoginController().APPV,
        "SOID_V":GetSOID,
        "STID_V":"",
        "TBNA_V":TAB_N,
        "LAN_V":LoginController().LAN,
        "CIID_V":LoginController().CIID,
        "JTID_V":LoginController().JTID,
        "BIID_V":LoginController().BIID,
        "SYID_V":LoginController().SYID,
        "SUID_V":LoginController().SUID,
        "SUPA_V":LoginController().SUPA,
        "F_ROW_V":'0',
        "T_ROW_V":'0',
        "F_DAT_V": '',
        "T_DAT_V": '',
        "F_GUID_V":'',
        "WH_V1": '',
        "PAR_V":"",
        "JSON_V":List_D[i].SMKID.toString()=='11'?data2.toString():data.toString(),
        "JSON_V2":"",
        "JSON_V3":""
      };
      var bodylang = utf8.encode(json.encode(params2));
      var body = json.encode(params2);
      try {
        final response = await http.post(
            Uri.parse("${LoginController().API}/ESAPI/ESPOST"), body: body, headers: {
          'Transfer-Encoding': 'chunked',
          HttpHeaders.contentTypeHeader: "application/json",
          'Content-Length': bodylang.length.toString(),
        });
        if (response.statusCode == 201 || response.statusCode == 200) {
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
            ..userInteractions = TypeSync=='ByDate'?false:true
            ..dismissOnTap = false;
          TypeAuto==true?EasyLoading.show(status:  "${'StringWeAreSync'.tr}..${i+1}..${List_D.length}"):false;
          print('i');
          print(i);
          print(List_D.length);
          INSERT_SYN_LOG('ACC_MOV_D','${SLIND} ${List_D[i].SMMID.toString()}-${List_D[i].SMDID.toString()} ','U');
        }
        else {
          configloading('StrinError_Sync'.tr);
          Fluttertoast.showToast(
              msg: response.body,
              textColor: Colors.white,
              backgroundColor: Colors.red);
          INSERT_SYN_LOG('ACC_MOV_D','${response.body} ${List_D[i].SMMID.toString()}-${List_D[i].SMDID.toString()} ','U');
          break;
        }
        if(i+1 ==List_D.length){
          print('object11');
          SyncSTO_MOV_M(TypeSync,GetSMKID,GetSMMID);
        }
      } catch (e) {
        configloading('StrinError_Sync'.tr);
        Fluttertoast.showToast(
            msg: e.toString(),
            textColor: Colors.white,
            backgroundColor: Colors.red);
        print(e);
        print('response.body');
        return Future.error(e);
      }
    }
  }

  Future SyncSTO_MOV_M(String TypeSync,int GetSMKID, String GetSMMID) async {
    await SyncronizationData().FetchSTO_MOV_MData(TypeSync, GetSMKID==131?13:GetSMKID==0? 1:GetSMKID, GetSMMID).then((STO_MOV_MList) async {
      if (STO_MOV_MList.isNotEmpty && STO_MOV_MList.length>0) {
        TAB_N = GetSMKID==11?'STO_REQ_M':'STO_MOV_M';
        await SyncronizationData().SyncSTO_MOV_MToSystem(STO_MOV_MList, TypeSync, GetSMMID,GetSMKID==0? 1: GetSMKID,GetSMKID==17?'STO_MOV_MC':
        GetSMKID==1 ? 'STO_MOV_MI':GetSMKID==3?'STO_MOV_MO':GetSMKID==11?'STO_MOV_MBSORD':GetSMKID==131?'STO_MOV_MBB':
        GetSMKID==0 ? 'STO_MOV_MF':'STO_MOV_MBS');
      }
    });
  }

  Future SyncSTO_MOV_MToSystem(List<STO_MOV_M_Local> contactList, String TypeSync,
      String GetSMMID, int GetSMKID,String GetSOID) async {
    for (var i = 0; i < contactList.length; i++) {
      var data = {
        "SMMID": contactList[i].SMMID.toString(),
        "SMMNO": contactList[i].SMMNO.toString(),
        "SMKID": contactList[i].SMKID.toString(),
        "SMMDO": contactList[i].SMMDO.toString(),
        "SMMST": contactList[i].SMMST.toString(),
        "SMMIN": contactList[i].SMMIN.toString(),
        "BIID": contactList[i].BIID.toString(),
        "SIID": contactList[i].SIID.toString(),
        "SCID": contactList[i].SCID.toString(),
        "AANO": contactList[i].AANO.toString(),
        "SCEX": contactList[i].SCEX.toString(),
        "ACNO": contactList[i].ACNO.toString(),
        "SMMDA": contactList[i].SMMDA.toString(),
        "SMMAM": contactList[i].SMMAM.toString(),
        "SCEXS": contactList[i].SCEXS.toString(),
        "SMMEQ": contactList[i].SMMEQ.toString(),
        "SMMRE": contactList[i].SMMRE.toString(),
        "SMMDIF": contactList[i].SMMDIF.toString(),
        "SMMDI": contactList[i].SMMDI.toString(),
        "SMMDIA": contactList[i].SMMDIA.toString(),
        "SMMNN": contactList[i].SMMNN.toString(),
        "SMMCN": contactList[i].SMMCN.toString(),
        "SMMDR": contactList[i].SMMDR.toString(),
        "BKID": contactList[i].BKID.toString(),
        "BMMID": contactList[i].BMMID.toString(),
        "SUID": contactList[i].SUID.toString(),
        "DATEI": contactList[i].DATEI.toString(),
        "DEVI": contactList[i].DEVI.toString(),
        "SUCH": contactList[i].SUCH.toString(),
        "DATEU": contactList[i].DATEU.toString(),
        "DEVU": contactList[i].DEVU.toString(),
        "GUID": contactList[i].GUID.toString(),
        "ROWN1": contactList[i].SMMNR.toString(),
        "STMID_CO":'INVC',
        "SYDV_NAME": LoginController().DeviceName,
        "SYDV_IP": LoginController().IP,
        "SYDV_TY":  LoginController().SYDV_TY,
        "SYDV_SER": LoginController().DeviceID,
        "SYDV_POI":"",
        "SYDV_ID":LoginController().SYDV_ID,
        "SYDV_NO": LoginController().SYDV_NO,
        "SYDV_LATITUDE":"",
        "SYDV_LONGITUDE":"",
        "SYDV_APPV":LoginController().APPV,
      };
      var data2 = {
        "SRMID": contactList[i].SMMID.toString(),
        "SRMNO": contactList[i].SMMNO.toString(),
        "SMKID": contactList[i].SMKID.toString(),
        "SRMDO": contactList[i].SMMDO.toString(),
        "SRMST": contactList[i].SMMST.toString(),
        "SRMIN": contactList[i].SMMIN.toString(),
        "BIID": contactList[i].BIID.toString(),
        "SIID": contactList[i].SIID.toString(),
        "SCID": contactList[i].SCID.toString(),
        "AANO": contactList[i].AANO.toString(),
        "SCEX": contactList[i].SCEX.toString(),
        "ACNO": contactList[i].ACNO.toString(),
        // "SMMDA": contactList[i].SMMDA.toString(),
        "SRMAM": contactList[i].SMMAM.toString(),
        "SCEXS": contactList[i].SCEXS.toString(),
        "SRMEQ": contactList[i].SMMEQ.toString(),
        "SRMRE": contactList[i].SMMRE.toString(),
        "SRMDIF": contactList[i].SMMDIF.toString(),
        "SRMDI": contactList[i].SMMDI.toString(),
        "SRMDIA": contactList[i].SMMDIA.toString(),
        "SRMNN": contactList[i].SMMNN.toString(),
        "SRMCN": contactList[i].SMMCN.toString(),
        "SRMDR": contactList[i].SMMDR.toString(),
        "BKID": contactList[i].BKID.toString(),
        // "BMMID": contactList[i].BMMID.toString(),
        "SUID": contactList[i].SUID.toString(),
        "DATEI": contactList[i].DATEI.toString(),
        "DEVI": contactList[i].DEVI.toString(),
        "SUCH": contactList[i].SUCH.toString(),
        "DATEU": contactList[i].DATEU.toString(),
        "DEVU": contactList[i].DEVU.toString(),
        "GUID": contactList[i].GUID.toString(),
        "ROWN1": contactList[i].SMMNR.toString(),
        "STMID_CO":'INVC',
        "SYDV_NAME": LoginController().DeviceName,
        "SYDV_IP": LoginController().IP,
        "SYDV_TY":  LoginController().SYDV_TY,
        "SYDV_SER": LoginController().DeviceID,
        "SYDV_POI":"",
        "SYDV_ID":LoginController().SYDV_ID,
        "SYDV_NO": LoginController().SYDV_NO,
        "SYDV_LATITUDE":"",
        "SYDV_LONGITUDE":"",
        "SYDV_APPV":LoginController().APPV,
      };
      var params = {
        "STMID_CO_V": "INVC",
        "SYDV_NAME_V": LoginController().DeviceName,
        "SYDV_IP_V": LoginController().IP,
        "SYDV_TY_V":  LoginController().SYDV_TY,
        "SYDV_SER_V": LoginController().DeviceID,
        "SYDV_POI_V":"",
        "SYDV_ID_V":LoginController().SYDV_ID,
        "SYDV_NO_V":LoginController().SYDV_NO,
        "SYDV_BRA_V":1,
        "SYDV_LATITUDE_V":"",
        "SYDV_LONGITUDE_V":"",
        "SYDV_APPV_V":LoginController().APPV,
        "SOID_V":GetSOID,
        "STID_V":"",
        "TBNA_V":TAB_N,
        "LAN_V":LoginController().LAN,
        "CIID_V":LoginController().CIID,
        "JTID_V":LoginController().JTID,
        "BIID_V":LoginController().BIID,
        "SYID_V":LoginController().SYID,
        "SUID_V":LoginController().SUID,
        "SUPA_V":LoginController().SUPA,
        "F_ROW_V":'0',
        "T_ROW_V":'0',
        "F_DAT_V": '',
        "T_DAT_V": '',
        "F_GUID_V":'',
        "WH_V1": '',
        "PAR_V":"",
        "JSON_V": contactList[i].SMKID.toString()=='11'?data2.toString():data.toString(),
        "JSON_V2":"",
        "JSON_V3":""
      };
      var bodylang = utf8.encode(json.encode(params));
      var body = json.encode(params);
      try {
        final response = await http.post(
            Uri.parse("${LoginController().API}/ESAPI/ESPOST"),
            body: body,
            headers: {
              'Transfer-Encoding': 'chunked',
              HttpHeaders.contentTypeHeader: "application/json",
              'Content-Length': bodylang.length.toString(),
            });
        if (response.statusCode == 201 || response.statusCode == 200) {
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
          EasyLoading.showSuccess('StringSuccessfullySync'.tr);
          UpdateStateSto_Mov_D(TypeSync, GetSMKID, GetSMMID, 1);
          UpdateStateSto_Mov_M(TypeSync, GetSMKID, GetSMMID, 1);
          // controller.getAll("ALL");
        } else {
          configloading('StrinError_Sync'.tr);
          Fluttertoast.showToast(
              msg: "${response.body}",
              textColor: Colors.white,
              backgroundColor: Colors.red);
          //  EasyLoading.show(status: response.body);
        }
      } catch (e) {
        configloading('StrinError_Sync'.tr);
        Fluttertoast.showToast(
            msg: "response error ${e.toString()}",
            textColor: Colors.white,
            backgroundColor: Colors.red);
        return Future.error(e);
      }
    }
  }

// الجرد -------------------------------


//المحطاااااااات-----------------------

  Future<List<Bif_Cou_M_Local>> FetchBIF_COU_M(String TypeSync, String GetBCMID) async {
    final dbClient = await conn.database;
    List<Bif_Cou_M_Local> List_D = [];
    String SQLBIID_L = LoginController().BIID_ALL_V == '1'
        ? " AND  BIID_L=${LoginController().BIID}" :  '';

    String SQL2 = ''' AND JTID_L=${LoginController().JTID} AND SYID_L=${LoginController().SYID} 
                  AND CIID_L=${LoginController().CIID} $SQLBIID_L''';
    try {
      if (TypeSync == "SyncAll") {
        final maps = await dbClient!.query('BIF_COU_M',
            where: ' BCMST=2 $SQL2');
        for (var item in maps) {
          List_D.add(Bif_Cou_M_Local.fromMap(item));
        }
      } else if (TypeSync == "SyncOnly") {
        final maps = await dbClient!.query('BIF_COU_M',
            where: 'BCMST=2 and BCMID=$GetBCMID');
        for (var item in maps) {
          List_D.add(Bif_Cou_M_Local.fromMap(item));
        }
      }
    } catch (e) {
      print(e.toString());
    }
    return List_D;
  }

  Future<List<Bif_Cou_C_Local>> FetchBIF_COU_C(String TypeSync, String GetBCMID) async {
    final dbClient = await conn.database;
    List<Bif_Cou_C_Local> List_D = [];
    String SQLBIID_L = LoginController().BIID_ALL_V == '1'
        ? " AND  BIID_L=${LoginController().BIID}" :  '';

    String SQL2 = ''' AND JTID_L=${LoginController().JTID} AND SYID_L=${LoginController().SYID} 
                  AND CIID_L=${LoginController().CIID} $SQLBIID_L''';
    try {
      if (TypeSync == "SyncAll") {
        final maps = await dbClient!.query('BIF_COU_C', where: ' BCCST=2 $SQL2');
        for (var item in maps) {
          List_D.add(Bif_Cou_C_Local.fromMap(item));
        }
      } else if (TypeSync == "SyncOnly") {
        final maps = await dbClient!.query('BIF_COU_C',
            where: 'BCCST=2 and BCMID=$GetBCMID');
        for (var item in maps) {
          List_D.add(Bif_Cou_C_Local.fromMap(item));
        }
      }
    } catch (e) {
      print(e.toString());
    }
    return List_D;
  }


  Future SyncBIF_COU_MToSystem(List<Bif_Cou_M_Local> contactList, String TypeSync, String GetBCMID) async {
    for (var i = 0; i < contactList.length; i++) {
      var data = {
        "BIID": contactList[i].BIID.toString(),
        "BCMID": contactList[i].BCMID.toString(),
        "BCMNO": contactList[i].BCMNO.toString(),
        "BCMKI": contactList[i].BCMKI.toString(),
        "BCMDO": contactList[i].BCMDO.toString(),
        "BCMNR": contactList[i].BCMNR.toString(),
        "ROWN1": contactList[i].BCMNR.toString(),
        "BCMFD": "${contactList[i].BCMFD.toString().substring(0, 10)}",
        "BCMTD": "${contactList[i].BCMTD.toString().substring(0, 10)}",
        "BCMFT": "${contactList[i].BCMFT.toString()}",
        "BCMTT": "${contactList[i].BCMTT.toString()}",
        "BCMAM3": contactList[i].BCMAM3.toString(),
        "BCMAM1": contactList[i].BCMAM1.toString(),
        "BCMAM2": contactList[i].BCMAM2.toString(),
        "BCMTA": contactList[i].BCMTA.toString(),
        "BCMST": contactList[i].BCMST.toString(),
        "SIID": contactList[i].SIID.toString(),
        "SCID": contactList[i].SCID.toString(),
        "BPID": contactList[i].BPID.toString(),
        "SCEX": contactList[i].SCEX.toString(),
        "SUID": contactList[i].SUID.toString(),
        "CTMID": contactList[i].CTMID.toString(),
        "CIMID": contactList[i].CIMID.toString(),
        "SCIDC": contactList[i].SCIDC.toString(),
        "BCMRO": contactList[i].BCMRO.toString(),
        "BCMRN": contactList[i].BCMRN.toString(),
        "BCCID1": contactList[i].BCCID1.toString(),
        "BCCID2": contactList[i].BCCID2.toString(),
        "BCCID3": contactList[i].BCCID3.toString(),
        "MGNO":contactList[i].MGNO.toString(),
        "MINO":contactList[i].MINO.toString(),
        "MUID":contactList[i].MUID.toString(),
        "BCMAM":contactList[i].BCMAM.toString(),
        "ACID":contactList[i].ACID.toString(),
        "ACNO":contactList[i].ACNO.toString(),
        "DATEI":contactList[i].DATEI.toString(),
        "DEVI":contactList[i].DEVI.toString(),
        "GUID":contactList[i].GUID.toString(),
        "BCMTY":contactList[i].BCMTY.toString(),
        "BCMIN":contactList[i].BCMIN.toString(),
        "STMID_CO":'COU',
        "SYDV_NAME": LoginController().DeviceName,
        "SYDV_IP": LoginController().IP,
        "SYDV_TY":  LoginController().SYDV_TY,
        "SYDV_SER": LoginController().DeviceID,
        "SYDV_POI":"",
        "SYDV_ID":LoginController().SYDV_ID,
        "SYDV_NO": LoginController().SYDV_NO,
        "SYDV_LATITUDE":"",
        "SYDV_LONGITUDE":"",
        "SYDV_APPV":LoginController().APPV,
      };
      var params = {
        "STMID_CO_V": "COU",
        "SYDV_NAME_V": LoginController().DeviceName,
        "SYDV_IP_V": LoginController().IP,
        "SYDV_TY_V":  LoginController().SYDV_TY,
        "SYDV_SER_V": LoginController().DeviceID,
        "SYDV_POI_V":"",
        "SYDV_ID_V":LoginController().SYDV_ID,
        "SYDV_NO_V":LoginController().SYDV_NO,
        "SYDV_BRA_V":1,
        "SYDV_LATITUDE_V":"",
        "SYDV_LONGITUDE_V":"",
        "SYDV_APPV_V":LoginController().APPV,
        "SOID_V":"",
        "STID_V":"",
        "TBNA_V":TAB_N,
        "LAN_V":LoginController().LAN,
        "CIID_V":LoginController().CIID,
        "JTID_V":LoginController().JTID,
        "BIID_V":LoginController().BIID,
        "SYID_V":LoginController().SYID,
        "SUID_V":LoginController().SUID,
        "SUPA_V":LoginController().SUPA,
        "F_ROW_V":'0',
        "T_ROW_V":'0',
        "F_DAT_V": '',
        "T_DAT_V": '',
        "F_GUID_V":'',
        "WH_V1": '',
        "PAR_V":"",
        "JSON_V":data.toString(),
        "JSON_V2":"",
        "JSON_V3":""
      };
      var bodylang = utf8.encode(json.encode(params));
      var body = json.encode(params);
      try {
        final response = await http.post(
            Uri.parse("${LoginController().API}/ESAPI/ESPOST"),
            body: body,
            headers: {
              'Transfer-Encoding': 'chunked',
              HttpHeaders.contentTypeHeader: "application/json",
              'Content-Length': bodylang.length.toString(),
            });
        if (response.statusCode == 201 || response.statusCode == 200) {
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
          EasyLoading.showSuccess('StringSuccessfullySync'.tr);
          UpdateStateBIF_COU_M(TypeSync,GetBCMID, 1);
        } else {
          configloading('StrinError_Sync'.tr);
          Fluttertoast.showToast(
              msg: "${response.body}",
              textColor: Colors.white,
              backgroundColor: Colors.red);
          //  EasyLoading.show(status: response.body);
        }
      } catch (e) {
        configloading(e.toString());
        Fluttertoast.showToast(
            msg: "response error ${e.toString()}",
            textColor: Colors.white,
            backgroundColor: Colors.red);
        return Future.error(e);
      }
    }
  }

  Future SyncBIF_COU_CToSystem(List<Bif_Cou_C_Local> contactList, String TypeSync, String GetBCMID) async {
    for (var i = 0; i < contactList.length; i++) {
      var data = {
        "BCMID": contactList[i].BCMID.toString(),
        "BCCID": contactList[i].BCCID.toString(),
        "GUIDM_L": contactList[i].GUIDM.toString(),
        "GUIDM": contactList[i].GUIDM.toString(),
        "BCCST": contactList[i].BCCST.toString(),
        "SCIDC": contactList[i].SCIDC.toString(),
        "SCNO": contactList[i].SCNO.toString(),
        "CTMID": contactList[i].CTMID.toString(),
        "CIMID": contactList[i].CIMID.toString(),
        "BCMFD": "${contactList[i].BCMFD.toString().substring(0, 10)}",
        "BCMTD": "${contactList[i].BCMTD.toString().substring(0, 10)}",
        "BCMFT": "${contactList[i].BCMFT.toString()}",
        "BCMTT": "${contactList[i].BCMTT.toString()}",
        "BCMRO": contactList[i].BCMRO.toString(),
        "BCMRN": contactList[i].BCMRN.toString(),
        "SIID": contactList[i].SIID.toString(),
        "BCCIN": contactList[i].BCCIN.toString(),
        "SCID": contactList[i].SCID.toString(),
        "SCEX": contactList[i].SCEX.toString(),
        "BCMAM": contactList[i].BCMAM.toString(),
        "BCMTX": contactList[i].BCMTX.toString(),
        "BCMDI": contactList[i].BCMDI.toString(),
        "BCMDIA": contactList[i].BCMDIA.toString(),
        "BCMTXD": contactList[i].BCMTXD.toString(),
        "ACID": contactList[i].ACID.toString(),
        "BCMTA": contactList[i].BCMTA.toString(),
        "ACNO": contactList[i].ACNO.toString(),
        "SUID": contactList[i].SUID.toString(),
        "SUCH": contactList[i].SUCH.toString(),
        "SCEXS": contactList[i].SCEXS.toString(),
        "BMKIDR":contactList[i].BMKIDR.toString(),
        "BMMIDR":contactList[i].BMMIDR.toString(),
        "AMKIDR":contactList[i].AMKIDR.toString(),
        "AMMIDR":contactList[i].AMMIDR.toString(),
        "BCMAT":contactList[i].BCMAT.toString(),
        "BCMAT1":contactList[i].BCMAT1.toString(),
        "BCMAT2":contactList[i].BCMAT2.toString(),
        "BCMAT3":contactList[i].BCMAT3.toString(),
        "BCMTY":contactList[i].BCMTY.toString(),
        "DATEI":contactList[i].DATEI.toString(),
        "BCCID1":contactList[i].BCCID1.toString(),
        "BCCID2":contactList[i].BCCID2.toString(),
        "BCCID3":contactList[i].BCCID3.toString(),
        "BCMAM1":contactList[i].BCMAM1.toString(),
        "BCMAM2":contactList[i].BCMAM2.toString(),
        "BCMAM3":contactList[i].BCMAM3.toString(),
        "DEVI":contactList[i].DEVI.toString(),
        "DATEU":contactList[i].DATEU.toString(),
        "DEVU":contactList[i].DEVU.toString(),
        "BCMPT":contactList[i].BCMPT.toString(),
        "GUID":contactList[i].GUID.toString(),
        "STMID_CO":'COU',
        "SYDV_NAME": LoginController().DeviceName,
        "SYDV_IP": LoginController().IP,
        "SYDV_TY":  LoginController().SYDV_TY,
        "SYDV_SER": LoginController().DeviceID,
        "SYDV_POI":"",
        "SYDV_ID":LoginController().SYDV_ID,
        "SYDV_NO": LoginController().SYDV_NO,
        "SYDV_LATITUDE":"",
        "SYDV_LONGITUDE":"",
        "SYDV_APPV":LoginController().APPV,
      };
      var params = {
        "STMID_CO_V": "COU",
        "SYDV_NAME_V": LoginController().DeviceName,
        "SYDV_IP_V": LoginController().IP,
        "SYDV_TY_V":  LoginController().SYDV_TY,
        "SYDV_SER_V": LoginController().DeviceID,
        "SYDV_POI_V":"",
        "SYDV_ID_V":LoginController().SYDV_ID,
        "SYDV_NO_V":LoginController().SYDV_NO,
        "SYDV_BRA_V":1,
        "SYDV_LATITUDE_V":"",
        "SYDV_LONGITUDE_V":"",
        "SYDV_APPV_V":LoginController().APPV,
        "SOID_V":"",
        "STID_V":"",
        "TBNA_V":TAB_N,
        "LAN_V":LoginController().LAN,
        "CIID_V":LoginController().CIID,
        "JTID_V":LoginController().JTID,
        "BIID_V":LoginController().BIID,
        "SYID_V":LoginController().SYID,
        "SUID_V":LoginController().SUID,
        "SUPA_V":LoginController().SUPA,
        "F_ROW_V":'0',
        "T_ROW_V":'0',
        "F_DAT_V": '',
        "T_DAT_V": '',
        "F_GUID_V":'',
        "WH_V1": '',
        "PAR_V":"",
        "JSON_V":data.toString(),
        "JSON_V2":"",
        "JSON_V3":""
      };
      var bodylang = utf8.encode(json.encode(params));
      var body = json.encode(params);
      try {
        final response = await http.post(Uri.parse("${LoginController().API}/ESAPI/ESPOST"),
            body: body,
            headers: {
              'Transfer-Encoding': 'chunked',
              HttpHeaders.contentTypeHeader: "application/json",
              'Content-Length': bodylang.length.toString(),
            });
        if (response.statusCode == 201 || response.statusCode == 200) {

        }
        else {
          configloading('StrinError_Sync'.tr);
          Fluttertoast.showToast(
              msg: response.body,
              textColor: Colors.white,
              backgroundColor: Colors.red);
          //  EasyLoading.show(status: response.body);
        }
      } catch (e) {
        configloading(e.toString());
        Fluttertoast.showToast(
            msg: e.toString(),
            textColor: Colors.white,
            backgroundColor: Colors.red);
        return Future.error(e);
      }
    }
  }

//المحطاااااااات-----------------------
}
