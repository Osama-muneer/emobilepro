import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../Setting/models/con_acc_m.dart';
import '../Setting/controllers/login_controller.dart';
import '../Setting/models/acc_acc.dart';
import '../Setting/models/acc_ban.dart';
import '../Setting/models/acc_cas.dart';
import '../Setting/models/acc_cas_u.dart';
import '../Setting/models/acc_cos.dart';
import '../Setting/models/acc_mov_k.dart';
import '../Setting/models/acc_sta_d.dart';
import '../Setting/models/acc_sta_m.dart';
import '../Setting/models/acc_tax_c.dart';
import '../Setting/models/acc_tax_t.dart';
import '../Setting/models/acc_usr.dart';
import '../Setting/models/bal_acc_c.dart';
import '../Setting/models/bal_acc_d.dart';
import '../Setting/models/bal_acc_m.dart';
import '../Setting/models/bif_cus_d.dart';
import '../Setting/models/bif_gro.dart';
import '../Setting/models/bif_gro2.dart';
import '../Setting/models/bil_are.dart';
import '../Setting/models/bil_cre_c.dart';
import '../Setting/models/bil_cus.dart';
import '../Setting/models/bil_cus_t.dart';
import '../Setting/models/bil_dis.dart';
import '../Setting/models/bil_imp.dart';
import '../Setting/models/bil_mov_k.dart';
import '../Setting/models/bil_poi.dart';
import '../Setting/models/bil_poi_u.dart';
import '../Setting/models/bil_usr_d.dart';
import '../Setting/models/bra_inf.dart';
import '../Setting/models/bra_yea.dart';
import '../Setting/models/config.dart';
import '../Setting/models/cos_usr.dart';
import '../Setting/models/cou_inf_m.dart';
import '../Setting/models/cou_poi_l.dart';
import '../Setting/models/cou_red.dart';
import '../Setting/models/cou_tow.dart';
import '../Setting/models/cou_typ_m.dart';
import '../Setting/models/cou_usr.dart';
import '../Setting/models/cou_wrd.dart';
import '../Setting/models/eco_acc.dart';
import '../Setting/models/eco_msg_acc.dart';
import '../Setting/models/eco_var.dart';
import '../Setting/models/fat_api_inf.dart';
import '../Setting/models/fat_csid_inf.dart';
import '../Setting/models/fat_csid_inf_d.dart';
import '../Setting/models/fat_csid_seq.dart';
import '../Setting/models/fat_csid_st.dart';
import '../Setting/models/fat_que.dart';
import '../Setting/models/gen_var.dart';
import '../Setting/models/gro_usr.dart';
import '../Setting/models/ide_lin.dart';
import '../Setting/models/ide_typ.dart';
import '../Setting/models/job_typ.dart';
import '../Setting/models/mat_des_d.dart';
import '../Setting/models/mat_des_m.dart';
import '../Setting/models/mat_dis_d.dart';
import '../Setting/models/mat_dis_f.dart';
import '../Setting/models/mat_dis_k.dart';
import '../Setting/models/mat_dis_l.dart';
import '../Setting/models/mat_dis_m.dart';
import '../Setting/models/mat_dis_s.dart';
import '../Setting/models/mat_dis_t.dart';
import '../Setting/models/mat_fol.dart';
import '../Setting/models/mat_inf.dart';
import '../Setting/models/mat_inf_a.dart';
import '../Setting/models/mat_mai_m.dart';
import '../Setting/models/mat_pri.dart';
import '../Setting/models/mat_uni.dart';
import '../Setting/models/mat_uni_b.dart';
import '../Setting/models/mat_uni_c.dart';
import '../Setting/models/pay_kin.dart';
import '../Setting/models/res_emp.dart';
import '../Setting/models/res_sec.dart';
import '../Setting/models/res_tab.dart';
import '../Setting/models/shi_inf.dart';
import '../Setting/models/shi_usr.dart';
import '../Setting/models/sto_inf.dart';
import '../Setting/models/sto_mov_k.dart';
import '../Setting/models/sto_num.dart';
import '../Setting/models/sto_usr.dart';
import '../Setting/models/syn_dat.dart';
import '../Setting/models/syn_off_m.dart';
import '../Setting/models/syn_off_m2.dart';
import '../Setting/models/syn_ord.dart';
import '../Setting/models/syn_ord_l.dart';
import '../Setting/models/syn_set.dart';
import '../Setting/models/syn_tas.dart';
import '../Setting/models/sys_com.dart';
import '../Setting/models/sys_cur.dart';
import '../Setting/models/sys_cur_bet.dart';
import '../Setting/models/sys_cur_d.dart';
import '../Setting/models/sys_doc_d.dart';
import '../Setting/models/sys_own.dart';
import '../Setting/models/sys_pri_u.dart';
import '../Setting/models/sys_ref.dart';
import '../Setting/models/sys_scr.dart';
import '../Setting/models/sys_usr.dart';
import '../Setting/models/sys_usr_b.dart';
import '../Setting/models/sys_usr_p.dart';
import '../Setting/models/sys_var.dart';
import '../Setting/models/sys_yea.dart';
import '../Setting/models/tax_cod.dart';
import '../Setting/models/tax_cod_sys.dart';
import '../Setting/models/tax_cod_sys_d.dart';
import '../Setting/models/tax_lin.dart';
import '../Setting/models/tax_loc.dart';
import '../Setting/models/tax_loc_sys.dart';
import '../Setting/models/tax_mov_d.dart';
import '../Setting/models/tax_mov_sin.dart';
import '../Setting/models/tax_per_bra.dart';
import '../Setting/models/tax_per_d.dart';
import '../Setting/models/tax_per_m.dart';
import '../Setting/models/tax_sys.dart';
import '../Setting/models/tax_sys_bra.dart';
import '../Setting/models/tax_sys_d.dart';
import '../Setting/models/tax_tbl_lnk.dart';
import '../Setting/models/tax_typ.dart';
import '../Setting/models/tax_typ_bra.dart';
import '../Setting/models/tax_typ_sys.dart';
import '../Setting/models/tax_var.dart';
import '../Setting/models/tax_var_d.dart';
import '../Setting/models/usr_pri.dart';
import '../Widgets/config.dart';
import 'package:intl/intl.dart';
import 'package:sqflite/sqflite.dart';
import '../Setting/models/mat_gro.dart';
import '../Setting/models/mat_inf_d.dart';
import 'database.dart';

final conn = DatabaseHelper.instance;

String SQLBIID=  LoginController().BIID_ALL_V=='1'? SQLBIID= " AND  BIID_L=${LoginController().BIID}":SQLBIID='';


DeleteSYN_ORD() async {
  var dbClient = await conn.database;
  String sql= "DELETE FROM SYN_ORD WHERE JTID_L=${LoginController().JTID} AND SYID_L=${LoginController().SYID} "
      " AND CIID_L=${LoginController().CIID} $SQLBIID";
  final res = await dbClient!.rawDelete(sql);
  // print('DeleteSyn_ord ${sql} = ${res}');
  return res;
}

DeleteSYN_ORD_NULL() async {
  var dbClient = await conn.database;
  String sql= "DELETE FROM SYN_ORD WHERE JTID_L is NULL AND SYID_L is NULL AND CIID_L is NULL";
  final res = await dbClient!.rawDelete(sql);
  // print('DeleteSYN_ORD_NULL ${sql} = ${res}');
  return res;
}

Future<int> DeleteFAS_ACC_USR() async {
  var dbClient = await conn.database;
  String sql =" DELETE FROM FAS_ACC_USR WHERE JTID_L=${LoginController().JTID} AND SYID_L=${LoginController().SYID} "
      " AND CIID_L=${LoginController().CIID} $SQLBIID";
  final res = await dbClient!.rawDelete(sql);
  return res;
}

DeleteALLData(String GetTableName,bool TypeSync) async {
  var dbClient = await conn.database;
  String TableNameTmp='$GetTableName''_TMP';
  String GUID='';

    if(['FAT_CSID_INF', 'FAT_CSID_SEQ', 'FAT_CSID_ST'].contains(GetTableName)){
      GUID='FCIGU';
    }
    else if(['FAT_INV_SND', 'FAT_CSID_SEQ', 'FAT_INV_SND_ARC'].contains(GetTableName)){
      GUID='FISGU';
    }
    else{
      GUID='GUID';
    }

  String SqlBIIDTMP=LoginController().BIID_ALL_V=='1'?  " AND  $GetTableName.BIID_L=BIID_L":'';
  String sql='';

    if(['BIL_CUS', 'ACC_ACC','ACC_USR'].contains(GetTableName)) {
    sql="DELETE FROM $GetTableName WHERE SYST_L=1 and JTID_L=${LoginController().JTID} AND SYID_L=${LoginController().SYID}"
        "  AND CIID_L=${LoginController().CIID} $SQLBIID";
  }
    else{
    sql= "DELETE FROM $GetTableName WHERE JTID_L=${LoginController().JTID} AND SYID_L=${LoginController().SYID}"
       "  AND CIID_L=${LoginController().CIID} $SQLBIID ";
  }

   String sql2="DELETE FROM $GetTableName  WHERE EXISTS(SELECT 1 FROM $TableNameTmp B WHERE  $GetTableName.$GUID=B.$GUID )";

  String SQL_CSID_SEQ="DELETE FROM FAT_CSID_SEQ   WHERE EXISTS(SELECT 1 FROM FAT_CSID_SEQ_TMP B WHERE  B.FCIGU=FAT_CSID_SEQ.FCIGU  AND B.FCSNO>=FAT_CSID_SEQ.FCSNO)";
  String SQL_CSID_SEQ2="DELETE FROM FAT_CSID_SEQ_TMP   WHERE EXISTS(SELECT 1 FROM FAT_CSID_SEQ B WHERE  B.FCIGU=FAT_CSID_SEQ_TMP.FCIGU  AND B.FCSNO>FAT_CSID_SEQ_TMP.FCSNO)";

  // print(sql);
  // print(sql2);
  // print('DeleteALLData');
  final res = await dbClient!.rawDelete(GetTableName=='FAT_CSID_SEQ' ? SQL_CSID_SEQ2 : TypeSync==true?sql:sql2);
  final res2 = GetTableName=='FAT_CSID_SEQ' ? await dbClient.rawDelete( SQL_CSID_SEQ ):null;
 // print('DeleteALLData ${GetTableName=='FAT_CSID_SEQ' ? SQL_CSID_SEQ : TypeSync==true?sql:sql2} = ${res}');
 // print('DeleteALLData $SQL_CSID_SEQ2');
  INSERT_SYN_LOG(TAB_N,'تم الدخول الى دالة حذف البيانات السابقه ','D');
  return res;
}


DeleteALLDataTMP(String GetTableName) async {
  var dbClient = await conn.database;
  String GetTableNameTMP= '$GetTableName''_TMP';
  String sql= "Delete FROM $GetTableNameTMP";
  final res = await dbClient!.rawDelete(sql);
  // print('${sql} = ${res}');
  return res;
}


SaveALLData(String GetTableName) async {
  var dbClient = await conn.database;
  String TableNameTmp='$GetTableName''_TMP';
  String sql;
  sql= 'INSERT INTO  $GetTableName SELECT * FROM $TableNameTmp ';
  final res = await dbClient!.rawInsert(sql);
   // print('SaveALLData ${sql} = ${res}');
   DeleteALLDataTMP(GetTableName);
  return res;
}


//جلب البيانات الفاشله

DeleteSYN_ORD_L() async {
  var dbClient = await conn.database;
  String sql= "DELETE FROM SYN_ORD_L ";
  final res = await dbClient!.rawDelete(sql);
  return res;
}

late List<Syn_Ord_L_Local> Syn_Ord_LList=[];

Future<List<Syn_Ord_L_Local>> Get_SYN_ORD_L_ROW() async {
  var dbClient = await conn.database;
  String sql;
  sql =" SELECT * FROM SYN_ORD_L  WHERE SYDV_NO=${LoginController().SYDV_NO}  ";
  var result = await dbClient!.rawQuery(sql);
  List<Syn_Ord_L_Local> list = result.map((item) {
    return Syn_Ord_L_Local.fromMap(item);
  }).toList();
  return list;
}

Future SYN_ORD_L_ROW() async {
  try{
  Get_SYN_ORD_L_ROW().then((data) {
    Syn_Ord_LList = data;
    if (Syn_Ord_LList.isNotEmpty) {
      // print(Syn_Ord_LList.length);
      // print('Syn_Ord_LList.length');
      for (var i = 0; i < Syn_Ord_LList.length; i++) {
        Update_SYN_ORD_L(Syn_Ord_LList[i].SOET.toString(),Syn_Ord_LList[i].SOLGU.toString());
        // print(Syn_Ord_LList[i].SOET.toString());
      }
    }
  });
  } catch (e, stackTrace) {
    // التعامل مع أي أخطاء أثناء العملية
    print('Error in SYN_ORD_L_ROW: $e\n$stackTrace');
    Get.snackbar(
      'Error',
      'Error in SYN_ORD_L_ROW $e',
      backgroundColor: Colors.red,
      icon: const Icon(Icons.error, color: Colors.white),
      colorText: Colors.white,
    );

  }
}

Future<int> Update_SYN_ORD_L(String GetTableName,String GETGUID) async {
  var dbClient = await conn.database;
  GETGUID= '$GETGUID''';
  String sql=GetTableName=='ACC_MOV_M' ? 'AMMST=2' : 'BMMST=2';
  String sqlupdate="UPDATE  $GetTableName SET $sql WHERE GUID='${GETGUID}'" ;
  final result = await dbClient!.rawUpdate(sqlupdate);
  // print(sqlupdate);
  // print(result);
  // print('Update_SYN_ORD_L');
  Update_SYN_ORD_L_D(GetTableName=='ACC_MOV_M'?'ACC_MOV_D':GetTableName=='BIL_MOV_M'?'BIL_MOV_D':'BIF_MOV_D',GETGUID);
  return result;
}

Future<int> Update_SYN_ORD_L_D(String GetTableName,String GETGUID) async {
  var dbClient = await conn.database;
  GETGUID= '$GETGUID''';
  String sql=GetTableName=='ACC_MOV_D' ? 'SYST_L=2 WHERE GUIDF' : 'SYST=2 WHERE GUIDM';
  String sqlupdate="UPDATE  $GetTableName SET $sql='${GETGUID}'" ;
  final result = await dbClient!.rawUpdate(sqlupdate);
  // print(sqlupdate);
  // print(result);
  // print('Update_SYN_ORD_L_D');
  return result;
}
//جلب البيانات الفاشله


// NUM 1
DeleteDataByGUID(String GetTableName,String GETGUID) async {
  var dbClient = await conn.database;
  GETGUID= '$GETGUID''';
  String sql="DELETE FROM $GetTableName WHERE GUID='${GETGUID}'" ;
  final  res = await dbClient!.rawDelete(sql);
  // print('${sql} = ${res}');
  // print('DeleteDataByGUID');
  if(GetTableName=='BIL_CUS'){
    await SaveDataByGUID(GetTableName,GETGUID);
  }else {
    await SaveDataACC(GetTableName);
  }
  return res;
}

// NUM 2
SaveDataByGUID(String GetTableName,String GETGUID) async {
  var dbClient = await conn.database;
  String TableNameTmp='$GetTableName''_TMP';
  String sql;
  sql= "INSERT INTO  $GetTableName SELECT * FROM $TableNameTmp WHERE GUID='${GETGUID}'";
  final res = await dbClient!.rawInsert(sql);
  await DeleteALLDataTMP(GetTableName);
  await Update_TABLE_ALL(GetTableName);
  await UpdateDataByGUID('ACC_TAX_C',GETGUID);
  await UpdateDataByGUID('ACC_MOV_D',GETGUID);
  await UpdateDataByGUID('BIL_MOV_M',GETGUID);
  await UpdateDataByGUID('BIF_MOV_M',GETGUID);
  return res;
}

// NUM 3
UpdateDataByGUID(String GetTableName,String GETGUID) async {
  var dbClient = await conn.database;
  String sql;
  String SQL2=GetTableName=='BIL_MOV_M' || GetTableName=='BIF_MOV_M'
      ? ",BCID=(SELECT BCID FROM BIL_CUS B WHERE B.GUID='$GETGUID'),BMMNA=(SELECT BCNA FROM BIL_CUS B WHERE B.GUID='$GETGUID')":'';
  sql= "UPDATE $GetTableName SET AANO=(SELECT AANO FROM BIL_CUS B WHERE B.GUID='$GETGUID') $SQL2  WHERE AANO='${GETGUID}'";
  final res = await dbClient!.rawUpdate(sql);
  // print('UpdateDataByGUID ${sql} : ${res}');
  return res;
}

SaveDataACC(String GetTableName) async {
  var dbClient = await conn.database;
  String TableNameTmp='$GetTableName''_TMP';
  String sql;
  sql= "INSERT INTO  $GetTableName SELECT * FROM $TableNameTmp ";
  final res = await dbClient!.rawInsert(sql);
  DeleteALLDataTMP(GetTableName);
  Update_TABLE_ALL(GetTableName);
  Update_SYN_ORD(GetTableName);
  DeleteROWID('ACC_ACC','GUID');
  DeleteROWID('ACC_USR','GUID');
  return res;
}

DeleteDataBySYN_DATA(String GetTableName,String GETGUID) async {
  var dbClient = await conn.database;
  GETGUID= '$GETGUID''';
  final  res = await dbClient!.rawDelete("DELETE FROM $GetTableName WHERE GUID='${GETGUID}' ");
  INSERT_SYN_LOG(GetTableName,'DELETE DATA','U');
  return res;
}

// SaveSyncData(Map<String,dynamic> GetList,TableName) async {
//   var dbClient = await conn.database;
//   final res = await dbClient!.insert(TableName, GetList);
//   return res;
// }

Future<int> DeleteBRA_INF_ACC_ALL() async {
  var dbClient = await conn.database;
  final res = await dbClient!.rawDelete('DELETE FROM BRA_INF_ACC');
  return res;
}


SaveBRA_INF_ACC(Bra_Inf_Local BRA_INF_ACC) async {
  await DeleteBRA_INF_ACC_ALL();
  var dbClient = await conn.database;
  final res = await dbClient!.insert('BRA_INF_ACC', BRA_INF_ACC.toMap());
  return res;
}

Future<int> DeleteCON_ACC_M_ALL() async {
  var dbClient = await conn.database;
  final res = await dbClient!.rawDelete('DELETE FROM CON_ACC_M');
  return res;
}


SaveCON_ACC_M_ACC(Con_Acc_M_Local CON_ACC_M) async {
  await DeleteCON_ACC_M_ALL();
  var dbClient = await conn.database;
  final res = await dbClient!.insert('CON_ACC_M', CON_ACC_M.toMap());
  return res;
}

Future<int> DeleteSYS_USR_ACC_ALL() async {
  var dbClient = await conn.database;
  final res = await dbClient!.rawDelete('DELETE FROM SYS_USR_ACC');
  return res;
}

SaveSYS_USR_ACC(Sys_Usr_Local SYS_USR_ACC) async {
  await DeleteSYS_USR_ACC_ALL();
  var dbClient = await conn.database;
  final res = await dbClient!.insert('SYS_USR_ACC', SYS_USR_ACC.toMap());
  LoginController().GET_JTID_ONEData();
  return res;
}

SaveBackupData(Map<String,dynamic> getlist,TableName) async {
  var dbClient = await conn.database;
  final res = await dbClient!.insert(TableName, getlist);
  return res;
}


SaveSYS_OWN(Sys_Own_Local SYS_OWN) async {
  //await DeleteSYS_OWN_ALL();
  var dbClient = await conn.database;
  final res = await dbClient!.insert('SYS_OWN_TMP', SYS_OWN.toMap());
  return res;
}


Future<int> DeleteJOB_TYP_ALL() async {
  var dbClient = await conn.database;
  final res = await dbClient!.rawDelete('DELETE FROM JOB_TYP ');
  return res;
}

SaveJOB_TYP(Job_Typ_Local JOB_TYP) async {
  await DeleteJOB_TYP_ALL();
  var dbClient = await conn.database;
  final res = await dbClient!.insert('JOB_TYP', JOB_TYP.toMap());
  return res;
}

Future<int> DeleteSYS_YEA_ALL() async {
  var dbClient = await conn.database;
  final res = await dbClient!.rawDelete("DELETE FROM SYS_YEA WHERE JTID_L=${LoginController().JTID} AND SYID_L=${LoginController().SYID} "
  " AND CIID_L=${LoginController().CIID} $SQLBIID");
  return res;
}

SaveSYS_YEA(Sys_Yea_Local SYS_YEA) async {
 // await DeleteSYS_YEA_ALL();
  var dbClient = await conn.database;
  final res = await dbClient!.insert('SYS_YEA', SYS_YEA.toMap());
  return res;
}

Future<int> DeleteSYS_YEA_ACC_ALL() async {
  var dbClient = await conn.database;
  final res = await dbClient!.rawDelete('DELETE FROM SYS_YEA_ACC');
  return res;
}

SaveSYS_YEA_ACC(Sys_Yea_Local SYS_YEA_ACC) async {
  await DeleteSYS_YEA_ACC_ALL();
  var dbClient = await conn.database;
  final res = await dbClient!.insert('SYS_YEA_ACC', SYS_YEA_ACC.toMap());
  return res;
}

Future<int> DeleteSYS_COM_ALL() async {
  var dbClient = await conn.database;
  final res = await dbClient!.rawDelete('DELETE FROM SYS_COM ');
  return res;
}

SaveSYS_COM(Sys_Com_Local SYS_COM) async {
  await DeleteSYS_COM_ALL();
  var dbClient = await conn.database;
  final res = await dbClient!.insert('SYS_COM', SYS_COM.toMap());
  return res;
}

SaveBRA_YEA(Bra_Yea_Local BRA_YEA) async {
  var dbClient = await conn.database;
  final res = await dbClient!.insert('BRA_YEA_TMP', BRA_YEA.toMap());
  return res;
}

Future<int> DeleteBRA_YEA_ACC_ALL() async {
  var dbClient = await conn.database;
  final res = await dbClient!.rawDelete('DELETE FROM BRA_YEA_ACC');
  return res;
}

SaveBRA_YEA_ACC(Bra_Yea_Local BRA_YEA_ACC) async {
  await DeleteBRA_YEA_ACC_ALL();
  var dbClient = await conn.database;
  final res = await dbClient!.insert('BRA_YEA_ACC', BRA_YEA_ACC.toMap());
  return res;
}

Future<int> DeleteSYS_PRI_U_ALL() async {
  var dbClient = await conn.database;
  final res = await dbClient!.rawDelete('DELETE FROM SYS_PRI_U');
  return res;
}

DeleteGEN_VAR_ALL() async {
  var dbClient = await conn.database;
  final res = await dbClient!.rawDelete("DELETE FROM GEN_VAR WHERE JTID_L=${LoginController().JTID} AND SYID_L=${LoginController().SYID} "
  " AND CIID_L=${LoginController().CIID} $SQLBIID");
  return res;
}
Future<void> SaveGEN_VAR(Gen_Var_Local GEN_VAR) async {
  var dbClient = await conn.database;
  await dbClient!.insert('GEN_VAR', GEN_VAR.toMap(),
  );
}
Future<void> SaveGEN_VAR_ACC(Gen_Var_Local GEN_VAR) async {
  await DeleteGEN_VAR_ACC_ALL();
  var dbClient = await conn.database;
  await dbClient!.insert('GEN_VAR_ACC', GEN_VAR.toMap(),
  );
}

Future<int> DeleteSYS_USR_P_ALL() async {
  var dbClient = await conn.database;
  final res = await dbClient!.rawDelete('DELETE FROM SYS_USR_P');
  return res;
}

Future<int> DeleteGEN_VAR_ACC_ALL() async {
  var dbClient = await conn.database;
  final res = await dbClient!.rawDelete('DELETE FROM GEN_VAR_ACC');
  return res;
}

SaveSYS_USR_P(Sys_Usr_P_Local SYS_USR_P) async {
  await DeleteSYS_USR_P_ALL();
  var dbClient = await conn.database;
  final res = await dbClient!.insert('SYS_USR_P', SYS_USR_P.toMap());
  return res;
}

UpdateSYN_ORD_ALL() async {
  var dbClient = await conn.database;
  String sqlupdate= "UPDATE SYN_ORD SET ROW_NUM=ifnull((SELECT ROW_NUM FROM SYN_ORD_TMP WHERE SYN_ORD.SOET=SOET),0)"
      " WHERE JTID_L=${LoginController().JTID} AND SYID_L=${LoginController().SYID} "
      " AND CIID_L=${LoginController().CIID} $SQLBIID";
  final result = await dbClient!.rawUpdate(sqlupdate);
  // print('${sqlupdate} = ${result}');
  // print('UpdateSYN_ORD_ALL');
  return result;
}

SaveSYN_ORD(SYN_ORD_Local SYN_ORD) async {
  var dbClient = await conn.database;
  final res = await dbClient!.insert('SYN_ORD_TMP', SYN_ORD.toMap());
  return res;
}

//جلب البيانات المحذوفه
Future SYN_DAT_P_ROW() async {
  // print(SYN_DATList.length);
  for (var i = 0; i < SYN_DATList.length; i++) {
    DeleteDataBySYN_DATA(SYN_DATList[i].SDTB.toString(),SYN_DATList[i].GUID.toString());
    // print(SYN_DATList[i].SDTB.toString());
  }
}

DeleteALLSYN_DAT() async {
  var dbClient = await conn.database;
  final res = await dbClient!.rawDelete('DELETE FROM SYN_DAT');
  return res;
}

SaveSYN_DAT(Syn_Dat_Local SYN_DAT_Data) async {
  var dbClient = await conn.database;
  final res = await dbClient!.insert('SYN_DAT', SYN_DAT_Data.toMap());
  return res;
}

SaveACC_STA_M(Acc_Sta_M_Local ACC_STA_M) async {
  var dbClient = await conn.database;
  // print('SaveACC_STA_M');
  final res = await dbClient!.insert('ACC_STA_M', ACC_STA_M.toMap());
  return res;
}

SaveACC_STA_D(Acc_Sta_D_Local ACC_STA_D) async {
  var dbClient = await conn.database;
  final res = await dbClient!.insert('ACC_STA_D', ACC_STA_D.toMap());
  return res;
}

Future<List<SYN_ORD_Local>> GET_SYN_ORD(String GETSOET) async {
  var dbClient = await conn.database;
  String sql2;
  sql2 = "SELECT  ROW_NUM,SOLD FROM SYN_ORD  WHERE  SOET='$GETSOET' AND JTID_L=${LoginController().JTID} AND"
      " SYID_L=${LoginController().SYID} AND CIID_L=${LoginController().CIID} $SQLBIID ORDER BY SOLD LIMIT 1";
  var result = await dbClient!.rawQuery(sql2);
  List<SYN_ORD_Local> list = result.map((item) {
    return SYN_ORD_Local.fromMap(item);
  }).toList();
  return list;
}

int Count_Rec=0;
int Count=0;


Future<int> Get_Count_Rec(String TAB_V) async {
  var dbClient = await conn.database;
  String sql2;
  String TableNameTmp='$TAB_V''_TMP';
  sql2 ="  SELECT  COUNT(*) FROM $TableNameTmp ";
  var x = await dbClient!.rawQuery(sql2);
  Count_Rec = Sqflite.firstIntValue(x)!;
  // print('Count_Rec ${sql2} = ${Count_Rec}');
  return Count_Rec;
}

Future<int> Get_Count_Check(String TAB_V) async {
  var dbClient = await conn.database;
  String sql2;
  sql2 ="SELECT  COUNT(*) FROM $TAB_V WHERE JTID_L=${LoginController().JTID} AND SYID_L=${LoginController().SYID} "
      " AND CIID_L=${LoginController().CIID} $SQLBIID";
  var x = await dbClient!.rawQuery(sql2);
  Count_Rec = Sqflite.firstIntValue(x)!;
  // print('Count_Check ${sql2} = ${Count_Rec}');
  return Count_Rec;
}



Future<List<Config_Local>> GetLastSyncDate() async {
  var dbClient = await conn.database;
  String sql;
  String sqlb2;
  LoginController().BIID_ALL_V=='1'? sqlb2= " AND  BIID=${LoginController().BIID}":sqlb2='';
  sql = "SELECT LastSyncDate,CHIKE_ALL FROM CONFIG WHERE JTID=${LoginController().JTID} AND SYID=${LoginController().SYID}"
      "  AND CIID=${LoginController().CIID}  $sqlb2 ";
  var result = await dbClient!.rawQuery(sql);
  List<Config_Local> list = result.map((item) {
    return Config_Local.fromMap(item);
  }).toList();
  return list;
}


Future<int> UpdateCONFIG(String ColmunName,String GETColmunValue) async {
  var dbClient = await conn.database;
  String Wheresql='';
  LoginController().BIID_ALL_V=='1'? Wheresql= " AND  BIID=${LoginController().BIID}":Wheresql='';
  final data = {ColmunName: GETColmunValue};
  final result =
  await dbClient!.update('CONFIG', data, where: "JTID=${LoginController().JTID} AND SYID=${LoginController().SYID}"
      "  AND CIID=${LoginController().CIID}  $Wheresql ",);
  return result;
}


Future<int> DeleteROWID(TableName,GUID) async {
  var dbClient = await conn.database;
  String Wheresql2='';
  LoginController().BIID_ALL_V=='1'? Wheresql2= ",BIID_L":Wheresql2='';
  String sql =" DELETE FROM $TableName WHERE ROWID NOT IN(SELECT MIN(ROWID) FROM $TableName  GROUP BY $GUID,JTID_L,SYID_L,CIID_L $Wheresql2)";
  final res = await dbClient!.rawDelete(sql);
 // print('DeleteROWID ${sql} = ${res}');
  return res;
}

Future<int> DeleteROWIDFAS_ACC_USR() async {
  var dbClient = await conn.database;
  String Wheresql2='';
  LoginController().BIID_ALL_V=='1'? Wheresql2= ",A.BIID_L":Wheresql2='';
  String sql =" DELETE FROM FAS_ACC_USR WHERE ROWID NOT IN(SELECT MIN(ROWID) FROM FAS_ACC_USR A "
      " GROUP BY A.SSID,A.SUID,A.CIID_L,A.JTID_L,A.SYID_L $Wheresql2) ";
  final res = await dbClient!.rawDelete(sql);
  return res;
}


Future<int> Update_SYN_ORD(TAB_N) async {
  var dbClient = await conn.database;
  String SQLUPDATE='';
  SQLUPDATE = " UPDATE  SYN_ORD SET SOLD= '${DateFormat('dd-MM-yyyy HH:mm:ss').format(DateTime.now())}' "
      " WHERE SOET='$TAB_N' AND JTID_L=${LoginController().JTID} "
      " AND BIID_L='${LoginController().BIID}' AND SYID_L='${LoginController().SYID}'"
      " AND CIID_L='${LoginController().CIID}' ";
  final result = await dbClient!.rawUpdate(SQLUPDATE);
  return result;
}

Future<int> INSERT_SYN_LOG(TAB_N,GETSLIN,SOTYSOTY) async {
  var dbClient = await conn.database;
  String sql2='';
  GETSLIN= '$GETSLIN''';
  await dbClient!.execute(
      'INSERT INTO SYN_LOG(SLDO,SLIN,STMID,SOTT,SOTY,JTID_L,BIID_L,SYID_L,CIID_L,SUID) values(?,?,?,?,?,?,?,?,?,?)',
      [
        DateFormat('dd-MM-yyyy HH:mm:ss').format(DateTime.now()),
        GETSLIN,
        STMID,
        TAB_N,
        SOTYSOTY,
        LoginController().JTID,
        LoginController().BIID,
        LoginController().SYID,
        LoginController().CIID,
        LoginController().SUID
      ]);
  // sql2= "INSERT INTO  SYN_LOG(SLDO,SLIN,STMID,SOTT,SOTY,JTID_L,BIID_L,SYID_L,CIID_L,SUID) values "
  //     "('$STMID','$TAB_N','$SOTYSOTY'"
  //     ",${LoginController().JTID},${LoginController().BIID},${LoginController().SYID},"
  //     "'${LoginController().CIID}','${LoginController().SUID}' ) ";
  // final res2 = await dbClient!.rawInsert(sql2);
  return 0;
}
//13 40
Future<int> Update_SYST(int GETJTID,int GETSYID,int GETBIID,String GETCIID, int GETSYST) async {
  var dbClient = await conn.database;
  final data = { 'SYST': GETSYST};
  final result =
  await dbClient!.update('CONFIG', data, where: "JTID=$GETJTID AND SYID=$GETSYID AND CIID='$GETCIID'",);
  return result;
}

Future<int> Update_TABLE_ALL(String TAB_N) async {
  var dbClient = await conn.database;
  String sqlupdate='';
  if(TAB_N=='BIL_CUS' || TAB_N=='ACC_ACC' || TAB_N=='ACC_USR'){
    sqlupdate= 'UPDATE  $TAB_N SET JTID_L=${LoginController().JTID},SYID_L=${LoginController().SYID}'
        ',BIID_L=${LoginController().BIID},CIID_L=${LoginController().CIID},SYST_L=1 ';
  }
  else{
    sqlupdate= 'UPDATE  $TAB_N SET JTID_L=${LoginController().JTID},SYID_L=${LoginController().SYID}'
        ',BIID_L=${LoginController().BIID},CIID_L=${LoginController().CIID} ';
  }
     // ' WHERE JTID_L=NULL AND SYID_L=NULL AND CIID_L=NULL AND BIID_L=NULL';
  // print('Update_TABLE_ALL');
  // print(sqlupdate);
  final result = await dbClient!.rawUpdate(sqlupdate);
  // print('Update_TABLE_ALL ${sqlupdate} = ${result}');
  INSERT_SYN_LOG(TAB_N,'تم الدخول الى دالة تعبئة الاربعه الحقول','D');
  return result;
}

//جلب البيانات المحذوفه
late List<SYN_ORD_Local> SYN_ORD_List=[];

Future<List<SYN_ORD_Local>> GET_SYN_ORDDelete() async {
  var dbClient = await conn.database;
  String sql2;
  sql2 = "SELECT  SOET,SOPK FROM SYN_ORD  WHERE SOLD NOT NULL AND  JTID_L=${LoginController().JTID} AND SYID_L=${LoginController().SYID} "
      " AND CIID_L=${LoginController().CIID} $SQLBIID ";
  var result = await dbClient!.rawQuery(sql2);
  List<SYN_ORD_Local> list = result.map((item) {
    return SYN_ORD_Local.fromMap(item);
  }).toList();
  SYN_ORD_List=list;
  return list;
}

Future DeleteROWIDAll() async {
  // print(SYN_ORD_List);
  // print('SYN_ORD_List');

  for (var i = 0; i < SYN_ORD_List.length; i++) {
  await  DeleteROWID(SYN_ORD_List[i].SOET.toString(),SYN_ORD_List[i].SOPK.toString());
     // print(SYN_ORD_List[i].SOET.toString() + '-' + SYN_ORD_List[i].SOPK.toString());
  }
}


 DeleteAllTMP(){
  DeleteALLDataTMP('SYN_TAS');
  DeleteALLDataTMP('SYS_VAR');
  DeleteALLDataTMP('SYN_DAT');
  DeleteALLDataTMP('MAT_FOL');
  DeleteALLDataTMP('SYS_OWN');
  DeleteALLDataTMP('BRA_INF');
  DeleteALLDataTMP('SYS_USR');
  DeleteALLDataTMP('USR_PRI');
  DeleteALLDataTMP('SYS_USR_B');
  DeleteALLDataTMP('STO_INF');
  DeleteALLDataTMP('STO_USR');
  DeleteALLDataTMP('MAT_GRO');
  DeleteALLDataTMP('GRO_USR');
  DeleteALLDataTMP('MAT_UNI');
  DeleteALLDataTMP('MAT_INF');
  DeleteALLDataTMP('MAT_UNI_C');
  DeleteALLDataTMP('MAT_UNI_B');
  DeleteALLDataTMP('MAT_PRI');
  DeleteALLDataTMP('STO_NUM');
  DeleteALLDataTMP('SYS_CUR');
  DeleteALLDataTMP('SYS_CUR_D');
  DeleteALLDataTMP('SYS_CUR_BET');
  DeleteALLDataTMP('PAY_KIN');
  DeleteALLDataTMP('ACC_CAS');
  DeleteALLDataTMP('ACC_CAS_U');
  DeleteALLDataTMP('BIL_CRE_C');
  DeleteALLDataTMP('ACC_BAN');
  DeleteALLDataTMP('BIL_CUS_T');
  DeleteALLDataTMP('ACC_TAX_T');
  DeleteALLDataTMP('BIL_CUS');
  DeleteALLDataTMP('BIF_CUS_D');
  DeleteALLDataTMP('BIL_DIS');
  DeleteALLDataTMP('BIL_IMP');
  DeleteALLDataTMP('COU_WRD');
  DeleteALLDataTMP('COU_TOW');
  DeleteALLDataTMP('BIL_ARE');
  DeleteALLDataTMP('ACC_ACC');
  DeleteALLDataTMP('ACC_USR');
  DeleteALLDataTMP('SHI_INF');
  DeleteALLDataTMP('SHI_USR');
  DeleteALLDataTMP('BIL_POI');
  DeleteALLDataTMP('BIL_POI_U');
  DeleteALLDataTMP('BIL_USR_D');
  DeleteALLDataTMP('ACC_COS');
  DeleteALLDataTMP('COS_USR');
  DeleteALLDataTMP('SYS_REF');
  DeleteALLDataTMP('SYS_DOC_D');
  DeleteALLDataTMP('BRA_YEA');
  DeleteALLDataTMP('SYS_SCR');
  DeleteALLDataTMP('TAX_COD');
  DeleteALLDataTMP('TAX_COD_SYS');
  DeleteALLDataTMP('TAX_COD_SYS_D');
  DeleteALLDataTMP('TAX_LIN');
  DeleteALLDataTMP('TAX_LOC');
  DeleteALLDataTMP('TAX_LOC_SYS');
  DeleteALLDataTMP('TAX_MOV_SIN');
  DeleteALLDataTMP('TAX_SYS');
  DeleteALLDataTMP('TAX_SYS_BRA');
  DeleteALLDataTMP('TAX_SYS_D');
  DeleteALLDataTMP('TAX_TBL_LNK');
  DeleteALLDataTMP('TAX_TYP');
  DeleteALLDataTMP('TAX_TYP_BRA');
  DeleteALLDataTMP('TAX_TYP_SYS');
  DeleteALLDataTMP('TAX_VAR');
  DeleteALLDataTMP('TAX_VAR_D');
  DeleteALLDataTMP('IDE_TYP');
  DeleteALLDataTMP('IDE_LIN');
  DeleteALLDataTMP('RES_SEC');
  DeleteALLDataTMP('RES_TAB');
  DeleteALLDataTMP('RES_EMP');
  DeleteALLDataTMP('BIF_GRO');
  DeleteALLDataTMP('BIF_GRO2');
  DeleteALLDataTMP('MAT_DES_M');
  DeleteALLDataTMP('MAT_DES_D');
  DeleteALLDataTMP('MAT_INF_D');
  DeleteALLDataTMP('MAT_DIS_T');
  DeleteALLDataTMP('MAT_DIS_K');
  DeleteALLDataTMP('MAT_DIS_M');
  DeleteALLDataTMP('MAT_DIS_D');
  DeleteALLDataTMP('MAT_DIS_F');
  DeleteALLDataTMP('MAT_DIS_L');
  DeleteALLDataTMP('MAT_DIS_S');
  DeleteALLDataTMP('MAT_MAI_M');
  DeleteALLDataTMP('ACC_TAX_C');
  DeleteALLDataTMP('TAX_MOV_T');
  DeleteALLDataTMP('TAX_PER_M');
  DeleteALLDataTMP('TAX_PER_D');
  DeleteALLDataTMP('TAX_PER_BRA');
  DeleteALLDataTMP('FAT_API_INF');
  DeleteALLDataTMP('FAT_CSID_INF');
  DeleteALLDataTMP('FAT_CSID_INF_D');
  DeleteALLDataTMP('FAT_CSID_SEQ');
  DeleteALLDataTMP('FAT_CSID_ST');
  DeleteALLDataTMP('FAT_QUE');
  DeleteALLDataTMP('COU_TYP_M');
  DeleteALLDataTMP('COU_INF_M');
  DeleteALLDataTMP('COU_POI_L');
  DeleteALLDataTMP('COU_USR');
  DeleteALLDataTMP('COU_RED');
  DeleteALLDataTMP('SYN_SET');
  DeleteALLDataTMP('SYN_OFF_M2');
  DeleteALLDataTMP('SYN_OFF_M');
  DeleteALLDataTMP('ECO_VAR');
  DeleteALLDataTMP('ECO_ACC');
  DeleteALLDataTMP('ECO_MSG_ACC');
}


Future<int> SaveSto_Inf(Sto_Inf_Local Sto_Inf_Data) async {
  var dbClient = await conn.database;

  if (dbClient == null) {
    throw Exception("Database not initialized");
  }

  try {
    // استخدام المعاملة لضمان إدخال البيانات بشكل صحيح
    return await dbClient.transaction((txn) async {
      // إدخال البيانات في الجدول المؤقت
      final res = await txn.insert('STO_INF_TMP', Sto_Inf_Data.toMap());

      // print('Data inserted successfully: $res');
      return res;
    });
  } catch (e) {
    print('Error inserting data: $e');
    throw Exception("Failed to insert data into STO_INF_TMP");
  }
}


SaveSto_Inf_old(Sto_Inf_Local Sto_Inf_Data) async {
  var dbClient = await conn.database;
  final res = await dbClient!.insert('STO_INF_TMP', Sto_Inf_Data.toMap());
  return res;
}
SaveBRA_INF(Bra_Inf_Local BRA_INF) async {
  var dbClient = await conn.database;
  final res = await dbClient!.insert('BRA_INF_TMP', BRA_INF.toMap());
  return res;
}
SaveAcc_Ban(Acc_Ban_Local Acc_Ban_Data) async {
  var dbClient = await conn.database;
  final res = await dbClient!.insert('ACC_BAN_TMP', Acc_Ban_Data.toMap());
  return res;
}
SaveACC_TAX_T(Acc_Tax_T_Local ACC_TAX_T) async {
  var dbClient = await conn.database;
  final res = await dbClient!.insert('ACC_TAX_T_TMP', ACC_TAX_T.toMap());
  return res;
}
SaveMAT_GRO(Mat_Gro_Local MAT_GRO) async {
  var dbClient = await conn.database;
  final res = await dbClient!.insert('MAT_GRO_TMP', MAT_GRO.toMap());
  return res;
}

SaveMAT_UNI(Mat_Uni_Local MAT_UNI) async {
  var dbClient = await conn.database;
  final res = await dbClient!.insert('MAT_UNI_TMP', MAT_UNI.toMap());
  return res;
}

SaveMAT_INF(Mat_Inf_Local MAT_INF) async {

  var dbClient = await conn.database;
  final res = await dbClient!.insert('MAT_INF_TMP', MAT_INF.toMap());
  return res;
}


SaveMAT_UNI_C(Mat_Uni_C_Local MAT_UNI_C) async {

  var dbClient = await conn.database;
  final res = await dbClient!.insert('MAT_UNI_C_TMP', MAT_UNI_C.toMap());
  return res;
}

SaveMAT_UNI_B(Mat_Uni_B_Local MAT_UNI_B) async {
  var dbClient = await conn.database;
  final res = await dbClient!.insert('MAT_UNI_B_TMP', MAT_UNI_B.toMap());
  return res;
}

SaveSTO_NUM(Sto_Num_Local STO_NUM) async {
  var dbClient = await conn.database;
  final res = await dbClient!.insert('STO_NUM_TMP', STO_NUM.toMap());
  return res;
}

SaveMAT_INF_A(Mat_Inf_A_Local MAT_INF_A) async {
  var dbClient = await conn.database;
  final res = await dbClient!.insert('MAT_INF_A_TMP', MAT_INF_A.toMap());
  return res;
}

SaveMAT_INF_D(Mat_Inf_D_Local MAT_INF_D) async {
  var dbClient = await conn.database;
  final res = await dbClient!.insert('MAT_INF_D_TMP', MAT_INF_D.toMap());
  return res;
}

SaveMAT_FOL(Mat_Fol_Local MAT_FOL) async {
  var dbClient = await conn.database;
  final res = await dbClient!.insert('MAT_FOL_TMP', MAT_FOL.toMap());
  return res;
}

SaveMAT_DES_M(Mat_Des_M_Local MAT_DES_M) async {
  var dbClient = await conn.database;
  final res = await dbClient!.insert('MAT_DES_M_TMP', MAT_DES_M.toMap());
  return res;
}

SaveMAT_DES_D(Mat_Des_D_Local MAT_DES_D) async {
  var dbClient = await conn.database;
  final res = await dbClient!.insert('MAT_DES_D_TMP', MAT_DES_D.toMap());
  return res;
}

SaveSYS_USR_B(Sys_Usr_B_Local SYS_USR_B) async {
  var dbClient = await conn.database;
  final res = await dbClient!.insert('SYS_USR_B_TMP', SYS_USR_B.toMap());
  return res;
}

SaveSTO_USR(Sto_Usr_Local STO_USR) async {
  var dbClient = await conn.database;
  final res = await dbClient!.insert('STO_USR_TMP', STO_USR.toMap());
  return res;
}

SaveSYS_USR(Sys_Usr_Local SYS_USR) async {
  var dbClient = await conn.database;
  final res = await dbClient!.insert('SYS_USR_TMP', SYS_USR.toMap());
  return res;
}

SaveUSR_PRI(Usr_Pri_Local USR_PRI) async {
  var dbClient = await conn.database;
  final res = await dbClient!.insert('USR_PRI_TMP', USR_PRI.toMap());
  return res;
}

SaveSYN_ORD_L(Syn_Ord_L_Local SYN_ORD_L) async {
  var dbClient = await conn.database;
  final res = await dbClient!.insert('SYN_ORD_L', SYN_ORD_L.toMap());
  return res;
}

Future<int> SaveSYS_VAR(Sys_Var_Local SYS_VAR) async {
  var dbClient = await conn.database;
  if (dbClient == null) {
    throw Exception("Database not initialized");
  }
  try {
    // استخدام المعاملة لضمان إدخال البيانات بشكل صحيح
    return await dbClient.transaction((txn) async {
      // إدخال البيانات في الجدول المؤقت
      final res = await txn.insert('SYS_VAR_TMP', SYS_VAR.toMap());

      // print('Data inserted successfully: $res');
      return res;
    });
  } catch (e) {
    print('Error inserting data: $e');
    throw Exception("Failed to insert data into SYS_VAR_TMP");
  }
}

Future<int> SaveSYN_SET(Syn_Set_Local SYN_SET) async {
  var dbClient = await conn.database;
  if (dbClient == null) {
    throw Exception("Database not initialized");
  }
  try {
    // استخدام المعاملة لضمان إدخال البيانات بشكل صحيح
    return await dbClient.transaction((txn) async {
      // إدخال البيانات في الجدول المؤقت
      final res = await txn.insert('SYN_SET_TMP', SYN_SET.toMap());

      // print('Data inserted successfully: $res');
      return res;
    });
  } catch (e) {
    print('Error inserting data: $e');
    throw Exception("Failed to insert data into SYN_SET_TMP");
  }
}

Future<int> SaveSYN_OFF_M2(Syn_Off_M2_Local SYN_OFF_M2) async {
  var dbClient = await conn.database;
  if (dbClient == null) {
    throw Exception("Database not initialized");
  }
  try {
    // استخدام المعاملة لضمان إدخال البيانات بشكل صحيح
    return await dbClient.transaction((txn) async {
      // إدخال البيانات في الجدول المؤقت
      final res = await txn.insert('SYN_OFF_M2_TMP', SYN_OFF_M2.toMap());

      // print('Data inserted successfully: $res');
      return res;
    });
  } catch (e) {
    print('Error inserting data: $e');
    throw Exception("Failed to insert data into SYN_OFF_M2_TMP");
  }
}

Future<int> SaveSYN_OFF_M(Syn_Off_M_Local SYN_OFF_M) async {
  var dbClient = await conn.database;
  if (dbClient == null) {
    throw Exception("Database not initialized");
  }
  try {
    // استخدام المعاملة لضمان إدخال البيانات بشكل صحيح
    return await dbClient.transaction((txn) async {
      // إدخال البيانات في الجدول المؤقت
      final res = await txn.insert('SYN_OFF_M_TMP', SYN_OFF_M.toMap());

      // print('Data inserted successfully: $res');
      return res;
    });
  } catch (e) {
    print('Error inserting data: $e');
    throw Exception("Failed to insert data into SYN_OFF_M_TMP");
  }
}

Future<int> SaveECO_ACC(Eco_Acc_Local ECO_ACC) async {
  var dbClient = await conn.database;
  if (dbClient == null) {
    throw Exception("Database not initialized");
  }
  try {
    // استخدام المعاملة لضمان إدخال البيانات بشكل صحيح
    return await dbClient.transaction((txn) async {
      // إدخال البيانات في الجدول المؤقت
      final res = await txn.insert('ECO_ACC_TMP', ECO_ACC.toMap());

      // print('Data inserted successfully: $res');
      return res;
    });
  } catch (e) {
    print('Error inserting data: $e');
    throw Exception("Failed to insert data into ECO_ACC_TMP");
  }
}

Future<int> SaveECO_VAR(Eco_Var_Local ECO_VAR) async {
  var dbClient = await conn.database;
  if (dbClient == null) {
    throw Exception("Database not initialized");
  }
  try {
    // استخدام المعاملة لضمان إدخال البيانات بشكل صحيح
    return await dbClient.transaction((txn) async {
      // إدخال البيانات في الجدول المؤقت
      final res = await txn.insert('ECO_VAR_TMP', ECO_VAR.toMap());

      // print('Data inserted successfully: $res');
      return res;
    });
  } catch (e) {
    print('Error inserting data: $e');
    throw Exception("Failed to insert data into ECO_VAR_TMP");
  }
}

Future<int> SaveECO_MSG_ACC(Eco_Msg_Acc_Local ECO_MSG_ACC) async {
  var dbClient = await conn.database;
  if (dbClient == null) {
    throw Exception("Database not initialized");
  }
  try {
    // استخدام المعاملة لضمان إدخال البيانات بشكل صحيح
    return await dbClient.transaction((txn) async {
      // إدخال البيانات في الجدول المؤقت
      final res = await txn.insert('ECO_MSG_ACC_TMP', ECO_MSG_ACC.toMap());

      // print('Data inserted successfully: $res');
      return res;
    });
  } catch (e) {
    print('Error inserting data: $e');
    throw Exception("Failed to insert data into ECO_MSG_ACC_TMP");
  }
}

SaveGRO_USR(Gro_Usr_Local GRO_USR) async {
  var dbClient = await conn.database;
  final res = await dbClient!.insert('GRO_USR_TMP', GRO_USR.toMap());
  return res;
}

SaveMAT_PRI(Mat_Pri_Local MAT_PRI) async {
  var dbClient = await conn.database;
  final res = await dbClient!.insert('MAT_PRI_TMP', MAT_PRI.toMap());
  return res;
}

SaveSYS_DOC_D(Sys_Doc_D_Local SYS_DOC_D) async {
  var dbClient = await conn.database;
  final res = await dbClient!.insert('SYS_DOC_D_TMP', SYS_DOC_D.toMap());
  return res;
}

SaveBIL_ARE(Bil_Are_Local BIL_ARE) async {
  var dbClient = await conn.database;
  final res = await dbClient!.insert('BIL_ARE_TMP', BIL_ARE.toMap());
  return res;
}

SaveCOS_USR(Cos_Usr_Local COS_USR) async {
  var dbClient = await conn.database;
  final res = await dbClient!.insert('COS_USR_TMP', COS_USR.toMap());
  return res;
}

SaveSYS_SCR(Sys_Scr_Local SYS_SCR) async {
  var dbClient = await conn.database;
  final res = await dbClient!.insert('SYS_SCR_TMP', SYS_SCR.toMap());
  return res;
}

SaveSYS_PRI_U(Sys_Pri_U_Local SYS_PRI_U) async {
  await DeleteSYS_PRI_U_ALL();
  var dbClient = await conn.database;
  final res = await dbClient!.insert('SYS_PRI_U_TMP', SYS_PRI_U.toMap());
  return res;
}

SaveBIL_CUS_T(Bil_Cus_T_Local BIL_CUS_T) async {
  var dbClient = await conn.database;
  final res = await dbClient!.insert('BIL_CUS_T_TMP', BIL_CUS_T.toMap());
  return res;
}

SaveBIL_CUS(Bil_Cus_Local BIL_CUS) async {
  var dbClient = await conn.database;
  final res = await dbClient!.insert('BIL_CUS_TMP', BIL_CUS.toMap());
  return res;
}

SaveBIF_CUS_D(Bif_Cus_D_Local BIF_CUS_D) async {
  var dbClient = await conn.database;
  final res = await dbClient!.insert('BIF_CUS_D_TMP', BIF_CUS_D.toMap());
  return res;
}

SaveBIL_DIS(Bil_Dis_Local BIL_DIS) async {

  var dbClient = await conn.database;
  final res = await dbClient!.insert('BIL_DIS_TMP', BIL_DIS.toMap());
  return res;
}

SaveSHI_INF(Shi_Inf_Local SHI_INF) async {
  var dbClient = await conn.database;
  final res = await dbClient!.insert('SHI_INF_TMP', SHI_INF.toMap());
  return res;
}

SaveSHI_USR(Shi_Usr_Local SHI_USR) async {
  var dbClient = await conn.database;
  final res = await dbClient!.insert('SHI_USR_TMP', SHI_USR.toMap());
  return res;
}

SaveBIL_POI(Bil_Poi_Local BIL_POI) async {
  var dbClient = await conn.database;
  final res = await dbClient!.insert('BIL_POI_TMP', BIL_POI.toMap());
  return res;
}

SaveBIL_POI_U(Bil_Poi_U_Local BIL_POI_U) async {
  var dbClient = await conn.database;
  final res = await dbClient!.insert('BIL_POI_U_TMP', BIL_POI_U.toMap());
  return res;
}

SaveBIL_IMP(Bil_Imp_Local Bil_Imp) async {
  var dbClient = await conn.database;
  final res = await dbClient!.insert('BIL_IMP_TMP', Bil_Imp.toMap());
  return res;
}

SaveCOU_WRD(Cou_Wrd_Local COU_WRD) async {
  var dbClient = await conn.database;
  final res = await dbClient!.insert('COU_WRD_TMP', COU_WRD.toMap());
  return res;
}

SaveBIL_MOV_K(Bil_Mov_K_Local BIL_MOV_K_Data) async {
  var dbClient = await conn.database;
  final res = await dbClient!.insert('BIL_MOV_K_TMP', BIL_MOV_K_Data.toMap());
  return res;
}

SaveSTO_MOV_K(Sto_Mov_K_Local Sto_Mov_K_Data) async {
  var dbClient = await conn.database;
  final res = await dbClient!.insert('STO_MOV_K_TMP', Sto_Mov_K_Data.toMap());
  return res;
}

SaveBAL_ACC_M(Bal_Acc_M_Local BAL_ACC_M_Data) async {
  var dbClient = await conn.database;
  final res = await dbClient!.insert('BAL_ACC_M_TMP', BAL_ACC_M_Data.toMap());
  return res;
}

SaveBAL_ACC_D(Bal_Acc_D_Local BAL_ACC_D_Data) async {
  var dbClient = await conn.database;
  final res = await dbClient!.insert('BAL_ACC_D_TMP', BAL_ACC_D_Data.toMap());
  return res;
}

SaveBAL_ACC_C(Bal_Acc_C_Local BAL_ACC_C_Data) async {
  var dbClient = await conn.database;
  final res = await dbClient!.insert('BAL_ACC_C_TMP', BAL_ACC_C_Data.toMap());
  return res;
}

SaveACC_MOV_K(Acc_Mov_K_Local ACC_MOV_K_Data) async {
  var dbClient = await conn.database;
  final res = await dbClient!.insert('ACC_MOV_K_TMP', ACC_MOV_K_Data.toMap());
  return res;
}

SaveACC_ACC(Acc_Acc_Local ACC_ACC) async {
  var dbClient = await conn.database;
  final res = await dbClient!.insert('ACC_ACC_TMP', ACC_ACC.toMap());
  return res;
}

SaveCOU_TOW(Cou_Tow_Local COU_TOW) async {
  var dbClient = await conn.database;
  final res = await dbClient!.insert('COU_TOW_TMP', COU_TOW.toMap());
  return res;
}

SaveBIL_USR_D(Bil_Usr_D_Local BIL_USR_D) async {
  var dbClient = await conn.database;
  final res = await dbClient!.insert('BIL_USR_D_TMP', BIL_USR_D.toMap());
  return res;
}

SaveSYS_REF(Sys_Ref_Local SYS_REF) async {
  var dbClient = await conn.database;
  final res = await dbClient!.insert('SYS_REF_TMP', SYS_REF.toMap());
  return res;
}

SaveACC_COS(Acc_Cos_Local ACC_COS) async {
  var dbClient = await conn.database;
  final res = await dbClient!.insert('ACC_COS_TMP', ACC_COS.toMap());
  return res;
}

SavePAY_KIN(Pay_Kin_Local PAY_KIN) async {
  var dbClient = await conn.database;
  final res = await dbClient!.insert('PAY_KIN_TMP', PAY_KIN.toMap());
  return res;
}

SaveSYS_CUR(Sys_Cur_Local SYS_CUR) async {
  var dbClient = await conn.database;
  final res = await dbClient!.insert('SYS_CUR_TMP', SYS_CUR.toMap());
  return res;
}

SaveSYS_CUR_D(Sys_Cur_D_Local SYS_CUR_D) async {
  var dbClient = await conn.database;
  final res = await dbClient!.insert('SYS_CUR_D_TMP', SYS_CUR_D.toMap());
  return res;
}

SaveACC_CAS(Acc_Cas_Local ACC_CAS) async {
  var dbClient = await conn.database;
  final res = await dbClient!.insert('ACC_CAS_TMP', ACC_CAS.toMap());
  return res;
}

SaveACC_CAS_U(Acc_Cas_U_Local ACC_CAS) async {
  var dbClient = await conn.database;
  final res = await dbClient!.insert('ACC_CAS_U_TMP', ACC_CAS.toMap());
  return res;
}

Future<int> SaveACC_USR(Acc_Usr_Local ACC_USR) async {
  var dbClient = await conn.database;
  if (dbClient == null) {
    throw Exception("Database not initialized");
  }
  try {
    // استخدام المعاملة لضمان إدخال البيانات بشكل صحيح
    return await dbClient.transaction((txn) async {
      // إدخال البيانات في الجدول المؤقت
      final res = await txn.insert('ACC_USR_TMP', ACC_USR.toMap());

      // print('Data inserted successfully: $res');
      return res;
    });
  } catch (e) {
    print('Error inserting data: $e');
    throw Exception("Failed to insert data into ACC_USR_TMP");
  }
}


SaveACC_USR_old(Acc_Usr_Local ACC_USR) async {
  var dbClient = await conn.database;
  final res = await dbClient!.insert('ACC_USR_TMP', ACC_USR.toMap());
  return res;
}

SaveSYS_CUR_BET(Sys_Cur_Bet_Local Sys_Cur_Bet) async {
  var dbClient = await conn.database;
  final res = await dbClient!.insert('SYS_CUR_BET_TMP', Sys_Cur_Bet.toMap());
  return res;
}

SaveBIL_CRE_C(Bil_Cre_C_Local BIL_CRE_C) async {
  var dbClient = await conn.database;
  final res = await dbClient!.insert('BIL_CRE_C_TMP', BIL_CRE_C.toMap());
  return res;
}

SaveTAX_COD(Tax_Cod_Local TAX_COD) async {
  var dbClient = await conn.database;
  final res = await dbClient!.insert('TAX_COD_TMP', TAX_COD.toMap());
  return res;
}

SaveTAX_COD_SYS(Tax_Cod_Sys_Local TAX_COD_SYS) async {
  var dbClient = await conn.database;
  final res = await dbClient!.insert('TAX_COD_SYS_TMP', TAX_COD_SYS.toMap());
  return res;
}

SaveTAX_COD_SYS_D(Tax_Cod_Sys_D_Local TAX_COD_SYS_D) async {
  var dbClient = await conn.database;
  final res = await dbClient!.insert('TAX_COD_SYS_D_TMP', TAX_COD_SYS_D.toMap());
  return res;
}

SaveTAX_LIN(Tax_Lin_Local TAX_LIN) async {
  var dbClient = await conn.database;
  final res = await dbClient!.insert('TAX_LIN_TMP', TAX_LIN.toMap());
  return res;
}

SaveTAX_LOC(Tax_Loc_Local TAX_LOC) async {
  var dbClient = await conn.database;
  final res = await dbClient!.insert('TAX_LOC_TMP', TAX_LOC.toMap());
  return res;
}

SaveTAX_LOC_SYS(Tax_Loc_Sys_Local TAX_LOC_SYS) async {
  var dbClient = await conn.database;
  final res = await dbClient!.insert('TAX_LOC_SYS_TMP', TAX_LOC_SYS.toMap());
  return res;
}

SaveTAX_MOV_SIN(Tax_Mov_Sin_Local TAX_MOV_SIN) async {
  var dbClient = await conn.database;
  final res = await dbClient!.insert('TAX_MOV_SIN_TMP', TAX_MOV_SIN.toMap());
  return res;
}

SaveTAX_SYS(Tax_Sys_Local TAX_SYS) async {
  var dbClient = await conn.database;
  final res = await dbClient!.insert('TAX_SYS_TMP', TAX_SYS.toMap());
  return res;
}

SaveTAX_SYS_BRA(Tax_Sys_Bra_Local TAX_SYS_BRA) async {
  var dbClient = await conn.database;
  final res = await dbClient!.insert('TAX_SYS_BRA_TMP', TAX_SYS_BRA.toMap());
  return res;
}

SaveTAX_SYS_D(Tax_Sys_D_Local TAX_SYS_D) async {
  var dbClient = await conn.database;
  final res = await dbClient!.insert('TAX_SYS_D_TMP', TAX_SYS_D.toMap());
  return res;
}

SaveTAX_TYP(Tax_Typ_Local TAX_TYP) async {
  var dbClient = await conn.database;
  final res = await dbClient!.insert('TAX_TYP_TMP', TAX_TYP.toMap());
  return res;
}


SaveTAX_TYP_BRA(Tax_Typ_Bra_Local TAX_TYP_BRA) async {
  var dbClient = await conn.database;
  final res = await dbClient!.insert('TAX_TYP_BRA_TMP', TAX_TYP_BRA.toMap());
  return res;
}

SaveTAX_TYP_SYS(Tax_Typ_Sys_Local TAX_TYP_SYS) async {
  var dbClient = await conn.database;
  final res = await dbClient!.insert('TAX_TYP_SYS_TMP', TAX_TYP_SYS.toMap());
  return res;
}

SaveTAX_TBL_LNK(Tax_Tbl_Lnk_Local TAX_TBL_LNK) async {
  var dbClient = await conn.database;
  final res = await dbClient!.insert('TAX_TBL_LNK_TMP', TAX_TBL_LNK.toMap());
  return res;
}

SaveTAX_VAR(Tax_Var_Local TAX_VAR) async {
  var dbClient = await conn.database;
  final res = await dbClient!.insert('TAX_VAR_TMP', TAX_VAR.toMap());
  return res;
}

SaveTAX_VAR_D(Tax_Var_D_Local TAX_VAR_D) async {
  var dbClient = await conn.database;
  final res = await dbClient!.insert('TAX_VAR_D_TMP', TAX_VAR_D.toMap());
  return res;
}

SaveIDE_TYP(Ide_Typ_Local IDE_TYP) async {
  var dbClient = await conn.database;
  final res = await dbClient!.insert('IDE_TYP_TMP', IDE_TYP.toMap());
  return res;
}

SaveIDE_LIN(Ide_Lin_Local IDE_LIN) async {
  var dbClient = await conn.database;
  final res = await dbClient!.insert('IDE_LIN_TMP', IDE_LIN.toMap());
  return res;
}

SaveRES_SEC(Res_Sec_Local RES_SEC) async {
  var dbClient = await conn.database;
  final res = await dbClient!.insert('RES_SEC_TMP', RES_SEC.toMap());
  return res;
}

SaveRES_TAB(Res_Tab_Local RES_TAB) async {
  var dbClient = await conn.database;
  final res = await dbClient!.insert('RES_TAB_TMP', RES_TAB.toMap());
  return res;
}
SaveRES_EMP(Res_Emp_Local RES_EMP) async {
  var dbClient = await conn.database;
  final res = await dbClient!.insert('RES_EMP_TMP', RES_EMP.toMap());
  return res;
}
SaveBIF_GRO(Bif_Gro_Local BIF_GRO) async {
  var dbClient = await conn.database;
  final res = await dbClient!.insert('BIF_GRO_TMP', BIF_GRO.toMap());
  return res;
}

SaveBIF_GRO2(Bif_Gro2_Local BIF_GRO2) async {
  var dbClient = await conn.database;
  final res = await dbClient!.insert('BIF_GRO2_TMP', BIF_GRO2.toMap());
  return res;
}


DeleteSYS_USR() async {
  var dbClient = await conn.database;
  String sql= "Delete FROM SYS_USR WHERE JTID_L=${LoginController().JTID} AND SYID_L=${LoginController().SYID} "
      " AND CIID_L=${LoginController().CIID} $SQLBIID";
  final res = await dbClient!.rawDelete(sql);
  // print('${sql} = ${res}');
  // print('DeleteSYS_USR');
  return res;
}

SaveCHINGSYS_USR(Sys_Usr_Local SYS_USR) async {
  var dbClient = await conn.database;
  DeleteSYS_USR();
  final res = await dbClient!.insert('SYS_USR', SYS_USR.toMap());
  return res;
}


SaveMAT_DIS_T(Mat_Dis_T_Local MAT_DIS_T) async {
  var dbClient = await conn.database;
  final res = await dbClient!.insert('MAT_DIS_T_TMP', MAT_DIS_T.toMap());
  return res;
}

SaveMAT_DIS_K(Mat_Dis_K_Local MAT_DIS_K) async {
  var dbClient = await conn.database;
  final res = await dbClient!.insert('MAT_DIS_K_TMP', MAT_DIS_K.toMap());
  return res;
}

SaveMAT_DIS_M(Mat_Dis_M_Local MAT_DIS_M) async {
  var dbClient = await conn.database;
  final res = await dbClient!.insert('MAT_DIS_M_TMP', MAT_DIS_M.toMap());
  return res;
}

SaveMAT_DIS_D(Mat_Dis_D_Local MAT_DIS_D) async {
  var dbClient = await conn.database;
  final res = await dbClient!.insert('MAT_DIS_D_TMP', MAT_DIS_D.toMap());
  return res;
}

SaveMAT_DIS_F(Mat_Dis_F_Local MAT_DIS_F) async {
  var dbClient = await conn.database;
  final res = await dbClient!.insert('MAT_DIS_F_TMP', MAT_DIS_F.toMap());
  return res;
}

SaveMAT_DIS_L(Mat_Dis_L_Local MAT_DIS_L) async {
  var dbClient = await conn.database;
  final res = await dbClient!.insert('MAT_DIS_L_TMP', MAT_DIS_L.toMap());
  return res;
}

SaveMAT_DIS_S(Mat_Dis_S_Local MAT_DIS_S) async {
  var dbClient = await conn.database;
  final res = await dbClient!.insert('MAT_DIS_S_TMP', MAT_DIS_S.toMap());
  return res;
}

SaveMAT_MAI_M(Mat_Mai_M_Local MAT_MAI_M) async {
  var dbClient = await conn.database;
  final res = await dbClient!.insert('MAT_MAI_M_TMP', MAT_MAI_M.toMap());
  return res;
}

SaveSYN_TAS(Syn_Tas_Local SYN_TAS) async {
  // await DeleteSYN_TAS_ALL();
  var dbClient = await conn.database;
      final res =  dbClient!.insert('SYN_TAS_TMP', SYN_TAS.toMap());
      return res;
}


SaveTAX_MOV_T(TAX_MOV_T_Local TAX_MOV_T) async {
  var dbClient = await conn.database;
  final res = await dbClient!.insert('TAX_MOV_T_TMP', TAX_MOV_T.toMap());
  return res;
}
SaveACC_TAX_C(Acc_Tax_C_Local ACC_TAX_C) async {
  var dbClient = await conn.database;
  final res = await dbClient!.insert('ACC_TAX_C_TMP', ACC_TAX_C.toMap());
  return res;
}

SaveTAX_PER_M(Tax_Per_M_Local TAX_PER_M) async {
  var dbClient = await conn.database;
  final res = await dbClient!.insert('TAX_PER_M_TMP', TAX_PER_M.toMap());
  return res;
}
SaveTAX_PER_D(Tax_Per_D_Local TAX_PER_D) async {
  var dbClient = await conn.database;
  final res = await dbClient!.insert('TAX_PER_D_TMP', TAX_PER_D.toMap());
  return res;
}
SaveTAX_PER_BRA(Tax_Per_Bra_Local TAX_PER_D) async {
  var dbClient = await conn.database;
  final res = await dbClient!.insert('TAX_PER_D_TMP', TAX_PER_D.toMap());
  return res;
}

SaveFAT_API_INF(Fat_Api_Inf_Local FAT_API_INF) async {
  var dbClient = await conn.database;
  final res = await dbClient!.insert('FAT_API_INF_TMP', FAT_API_INF.toMap());
  return res;
}

SaveFAT_CSID_INF(Fat_Csid_Inf_Local FAT_CSID_INF) async {
  var dbClient = await conn.database;
  final res = await dbClient!.insert('FAT_CSID_INF_TMP', FAT_CSID_INF.toMap());
  return res;
}
SaveFAT_CSID_INF_D(Fat_Csid_Inf_D_Local FAT_CSID_INF_D) async {
  var dbClient = await conn.database;
  final res = await dbClient!.insert('FAT_CSID_INF_D_TMP', FAT_CSID_INF_D.toMap());
  return res;
}

SaveFAT_QUE(Fat_Que_Local FAT_QUE) async {
  var dbClient = await conn.database;
  final res = await dbClient!.insert('FAT_QUE_TMP', FAT_QUE.toMap());
  return res;
}

SaveFAT_CSID_SEQ(Fat_Csid_Seq_Local FAT_CSID_SEQ) async {
  var dbClient = await conn.database;
  final res = await dbClient!.insert('FAT_CSID_SEQ_TMP', FAT_CSID_SEQ.toMap());
  return res;
}

SaveFAT_CSID_ST(Fat_Csid_St_Local FAT_CSID_ST) async {
  var dbClient = await conn.database;
  final res = await dbClient!.insert('FAT_CSID_ST_TMP', FAT_CSID_ST.toMap());
  return res;
}

SaveCOU_TYP_M(Cou_Typ_M_Local COU_TYP_M) async {
  var dbClient = await conn.database;
  final res = await dbClient!.insert('COU_TYP_M_TMP', COU_TYP_M.toMap());
  return res;
}

SaveCOU_INF_M(Cou_Inf_M_Local COU_INF_M) async {
  var dbClient = await conn.database;
  final res = await dbClient!.insert('COU_INF_M_TMP', COU_INF_M.toMap());
  return res;
}

SaveCOU_USR(Cou_Usr_Local COU_USR) async {
  var dbClient = await conn.database;
  final res = await dbClient!.insert('COU_USR_TMP', COU_USR.toMap());
  return res;
}

SaveCOU_POI_L(Cou_Poi_L_Local COU_POI_L) async {
  var dbClient = await conn.database;
  final res = await dbClient!.insert('COU_POI_L_TMP', COU_POI_L.toMap());
  return res;
}

SaveCOU_RED(Cou_Red_Local COU_RED) async {
  var dbClient = await conn.database;
  final res = await dbClient!.insert('COU_RED_TMP', COU_RED.toMap());
  return res;
}

SaveCOU_RED_M(Cou_Red_Local COU_RED) async {
  var dbClient = await conn.database;
  final res = await dbClient!.insert('COU_RED', COU_RED.toMap());
  return res;
}

SaveDate(T,TAB_N) async {
  var dbClient = await conn.database;
  final res = await dbClient!.insert(TAB_N, T.toMap());
  return res;
}


Future<List<Syn_Tas_Local>> GET_SYN_TAS(String Table,int STST) async {
  var dbClient = await conn.database;
  String sql='';
  String sqlSTST='';
  String Wheresql='';
  STST==0?sqlSTST='':sqlSTST='STST=1 AND ';
  // print(sqlSTST);
  // print('sqlSTST');
  LoginController().BIID_ALL_V=='1'? Wheresql= " AND A.BIID_L=${LoginController().BIID}":Wheresql='';
  sql = "SELECT *  FROM $Table A WHERE $sqlSTST A.JTID=${LoginController().JTID} "
      " AND A.SYID=${LoginController().SYID} AND A.CIID=${LoginController().CIID} $Wheresql ";
  var result = await dbClient!.rawQuery(sql);
  // print(result);
  // print(sql);
  // print('GET_SYN_TAS');
  List<Syn_Tas_Local> list = result.map((item) {
    return Syn_Tas_Local.fromMap(item);
  }).toList();
  return list;
}

Future UPDATESYIDAll(SYID_NEWValue) async {
  for (var i = 0; i < SYN_ORD_List.length; i++) {
    UPDATESYIDROWID(SYN_ORD_List[i].SOET.toString(),SYID_NEWValue);
  }
}

Future<int> UPDATESYIDROWID(TableName,SYID_NEWValue) async {
  var dbClient = await conn.database;
  String sql =" UPDATE $TableName SET SYID_L=$SYID_NEWValue "
      "where JTID_L=${LoginController().JTID} AND SYID_L=${LoginController().SYID} "
      " AND CIID_L=${LoginController().CIID} $SQLBIID";
  final res = await dbClient!.rawUpdate(sql);
  UPDATESTST();
  return res;
}

Future<int> UPDATESTST() async {
  var dbClient = await conn.database;
  String sql =" UPDATE SYN_TAS SET STST=2 WHERE JTID_L=1 AND CIID_L=1 $SQLBIID";
  final res = await dbClient!.rawUpdate(sql);
  // print('UPDATESTST ${sql} = ${res}');
  return res;
}

Future<int> INSERT_CONFIG(SYID) async {
  var dbClient = await conn.database;
  String sql2='';
  sql2= "INSERT INTO  CONFIG(JTID,BIID,SYID,CIID,DATEI,CHIKE_ALL,STMID,SYDV_NAME,SYDV_TY,"
      " SYDV_APPV,SYST,LastSyncDate) values "
      "('${LoginController().JTID}','${LoginController().BIID}','$SYID','${LoginController().CIID}',"
      "'${DateFormat('dd-MM-yyyy HH:mm:ss').format(DateTime.now())}',1,'$STMID','${LoginController().deviceName}',"
      "'${LoginController().SYDV_TY_V}','$SYDV_APPV',1,'${DateFormat('dd-MM-yyyy HH:mm:ss').format(DateTime.now())}') ";
  final res2 = await dbClient!.rawInsert(sql2);
  return res2;
}

Future<int> DELETE_BRA_INF() async {
  var dbClient = await conn.database;
  String Wheresql='';
  LoginController().BIID_ALL_V=='1'? Wheresql= " AND BIID_L=${LoginController().BIID}":Wheresql='';
  String sql =" DELETE FROM BRA_INF WHERE BIID!=${LoginController().BIID}  "
      " AND JTID_L=${LoginController().JTID} AND SYID_L=${LoginController().SYID} "
      " AND CIID_L=${LoginController().CIID}  $Wheresql";
  final res = await dbClient!.rawDelete(sql);
  return res;
}

Future<List<Bil_Mov_K_Local>> GET_MOV_K() async {
  var dbClient = await conn.database;
  String sql;
  String Wheresql='';
  LoginController().BIID_ALL_V=='1'? Wheresql= " AND  BIID_L=${LoginController().BIID}":Wheresql='';
//SELECT 0 AS BMKID,CASE WHEN ${LoginController().LAN}=2  THEN 'All' ELSE 'الكل' END AS BMKNA_D UNION ALL
  sql =
        "SELECT BMKID,CASE WHEN ${LoginController().LAN}=2 AND BMKNA IS NOT NULL THEN BMKNE ELSE BMKNA END  BMKNA_D"
        " FROM BIL_MOV_K WHERE BMKID IN(0,1,3,4,5,7,10,11) "
        " AND JTID_L=${LoginController().JTID} "
        " AND SYID_L=${LoginController().SYID} AND CIID_L='${LoginController().CIID}' $Wheresql "
        " UNION ALL "
        " SELECT CASE WHEN AMKID!=1  THEN AMKID ELSE 1001 END  AMKID"
        ",CASE WHEN ${LoginController().LAN}=2 AND AMKNA IS NOT NULL THEN AMKNA ELSE AMKNA END  AMKNA_D"
        " FROM ACC_MOV_K WHERE AMKID IN(1,2,15)  "
        " AND JTID_L=${LoginController().JTID} "
        " AND SYID_L=${LoginController().SYID} AND CIID_L='${LoginController().CIID}' $Wheresql ";
  var result = await dbClient!.rawQuery(sql);
  List<Bil_Mov_K_Local> list = result.map((item) {
    return Bil_Mov_K_Local.fromMap(item);
  }).toList();
  return list;
}

Future<Object?> GET_COUNT(String TAB_N,String GETColmun,GETBMKID,String GETColmunST, GETST,
    String GETColmunDate, GetFromDate,GetToDate) async {
  var dbClient = await conn.database;
  String sql='';
  String Wheresql='';
  String WhereDate='';
  String WhereKID='';

  LoginController().BIID_ALL_V=='1'? Wheresql= " AND A.BIID_L=${LoginController().BIID}":Wheresql='';
  if(GETBMKID=='1' || GETBMKID=='3' || GETBMKID=='4' || GETBMKID=='5' || GETBMKID=='7' || GETBMKID=='10'  || GETBMKID=='11'){
    WhereDate =  "A.$GETColmunDate BETWEEN '$GetFromDate' AND '$GetToDate'";
  }
  else{
    WhereDate = " strftime('%Y-%m-%d', substr(A.$GETColmunDate, 7, 4) || '-' || substr(A.$GETColmunDate, 4, 2) || '-' || substr(A.$GETColmunDate, 1, 2))"
        " BETWEEN '$GetFromDate' AND '$GetToDate'" ;
  }

  WhereKID=GETBMKID=='1001'?'1':GETBMKID;

  sql = "SELECT COUNT(*)  FROM $TAB_N A WHERE A.$GETColmun=$WhereKID AND A.$GETColmunST=$GETST "
        " and $WhereDate "
        " AND   A.JTID_L=${LoginController().JTID} "
        " AND A.SYID_L=${LoginController().SYID} AND A.CIID_L=${LoginController().CIID} $Wheresql";
  var result = await dbClient!.rawQuery(sql);
  var result2 = result.elementAt(0).values.first;
   // print(sql);
   // print(result2);
  return result2;
}

Future<int> deleteCOU_RED_ALL() async {
  var dbClient = await conn.database;
  String sql2='';
  LoginController().BIID_ALL_V=='1'? sql2= " AND  BIID_L=${LoginController().BIID}":sql2='';
  final res = await dbClient!.rawDelete("DELETE FROM COU_RED WHERE  JTID_L=${LoginController().JTID} AND SYID_L=${LoginController().SYID} "
  " AND CIID_L=${LoginController().CIID} $sql2 $sql2");
  return res;
}

DeleteAllDataByUser(){
  // DeleteDataByUser('SYS_USR');
  DeleteDataByUser('USR_PRI');
  DeleteDataByUser('SYS_USR_B');
  DeleteDataByUser('STO_USR');
  DeleteDataByUser('GRO_USR');
  DeleteDataByUser('ACC_USR');
  DeleteDataByUser('SHI_USR');
  // DeleteDataByUser('BIL_POI_U');
  DeleteDataByUser('COS_USR');
  DeleteDataByUser('ACC_CAS_U');
}

DeleteDataByUser(String GetTableName) async {
  var dbClient = await conn.database;
  String sql= "Delete FROM $GetTableName where SUID!=${LoginController().SUID}";
  final res = await dbClient!.rawDelete(sql);
  // print('${sql} = ${res}');
  return res;
}


Future<int> Get_FAS_ACC_USRData_Check() async {
  var dbClient = await conn.database;
  String sql2;
  int Count_Rec = 0;
  sql2 = "SELECT  COUNT(*) FROM FAS_ACC_USR WHERE  JTID_L=${LoginController().JTID} AND SYID_L=${LoginController().SYID} "
      " AND CIID_L=${LoginController().CIID} $SQLBIID";
  var x = await dbClient!.rawQuery(sql2);
  Count_Rec = Sqflite.firstIntValue(x)!;
   // print('Count_Check ${sql2} = ${Count_Rec}');
  return Count_Rec;
}