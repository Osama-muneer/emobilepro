import 'dart:io';

import '../Operation/models/acc_mov_m.dart';
import '../Setting/models/AppPrinterDevice.dart';
import '../Setting/models/Mob_Log.dart';
import '../Setting/models/bk_inf.dart';
import '../Setting/models/eco_acc.dart';
import '../Setting/models/eco_var.dart';
import '../Setting/models/mat_gro.dart';
import '../Setting/models/mob_var.dart';
import '../Setting/models/pay_kin.dart';
import 'package:intl/intl.dart';
import 'package:sqflite/sqflite.dart';
import 'package:uuid/uuid.dart';
import '../Setting/controllers/login_controller.dart';
import '../Setting/models/acc_acc.dart';
import '../Setting/models/acc_ban.dart';
import '../Setting/models/acc_cas.dart';
import '../Setting/models/acc_cos.dart';
import '../Setting/models/acc_gro.dart';
import '../Setting/models/acc_mov_k.dart';
import '../Setting/models/bal_acc_c.dart';
import '../Setting/models/bil_are.dart';
import '../Setting/models/bil_cre_c.dart';
import '../Setting/models/bil_cus.dart';
import '../Setting/models/bil_cus_t.dart';
import '../Setting/models/bil_dis.dart';
import '../Setting/models/bil_imp.dart';
import '../Setting/models/bil_imp_t.dart';
import '../Setting/models/bil_mov_k.dart';
import '../Setting/models/bra_inf.dart';
import '../Setting/models/bra_yea.dart';
import '../Setting/models/config.dart';
import '../Setting/models/cou_tow.dart';
import '../Setting/models/cou_wrd.dart';
import '../Setting/models/fas_acc_usr.dart';
import '../Setting/models/fat_snd_log.dart';
import '../Setting/models/gen_var.dart';
import '../Setting/models/job_typ.dart';
import '../Setting/models/list_value.dart';
import '../Setting/models/mat_inf.dart';
import '../Setting/models/mat_pri.dart';
import '../Setting/models/mat_uni_b.dart';
import '../Setting/models/qr_inf.dart';
import '../Setting/models/sto_inf.dart';
import '../Setting/models/sto_mov_k.dart';
import '../Setting/models/sto_num.dart';
import '../Setting/models/syn_off_m.dart';
import '../Setting/models/syn_off_m2.dart';
import '../Setting/models/syn_set.dart';
import '../Setting/models/sys_com.dart';
import '../Setting/models/sys_cur.dart';
import '../Setting/models/sys_doc_d.dart';
import '../Setting/models/sys_lan.dart';
import '../Setting/models/sys_own.dart';
import '../Setting/models/sys_rep.dart';
import '../Setting/models/sys_usr.dart';
import '../Setting/models/sys_usr_p.dart';
import '../Setting/models/sys_var.dart';
import '../Setting/models/sys_yea.dart';
import '../Setting/models/usr_pri.dart';
import '../Setting/services/fat_mod.dart';
import '../Widgets/ES_FAT_PKG.dart';
import '../Widgets/config.dart';
import '../database/database.dart';

import '../Operation/models/bil_mov_d.dart';
import '../Operation/models/bil_mov_m.dart';
import 'invoices_db.dart';

final conn = DatabaseHelper.instance;
String WhereSql =
    " JTID_L=${LoginController().JTID} AND SYID_L=${LoginController().SYID} "
    " AND CIID_L=${LoginController().CIID} ";
String sql2 = '';
String SQLBIID = LoginController().BIID_ALL_V == '1'
    ? SQLBIID = " AND  BIID_L=${LoginController().BIID}"
    : SQLBIID = '';

Future<List<Job_Typ_Local>> Get_Job_Typ() async {
  var dbClient = await conn.database;
  String sql;
  sql = " SELECT JTID,CASE WHEN ${LoginController().LAN}=2 AND JTNE IS NOT NULL THEN JTNE ELSE JTNA END AS JTNA_D"
      " FROM JOB_TYP WHERE JTST=1 ";
  var result = await dbClient!.rawQuery(sql);
  List<Job_Typ_Local> list = result.map((item) {
    return Job_Typ_Local.fromMap(item);
  }).toList();
  return list;
}

Future<List<Job_Typ_Local>> Get_Job_Typ_One() async {
  var dbClient = await conn.database;
  String sql;
  sql =
  " SELECT JTID,CASE WHEN ${LoginController().LAN}=2 AND JTNE IS NOT NULL THEN JTNE ELSE JTNA END AS JTNA_D"
      " FROM JOB_TYP  WHERE JTST=1 ORDER BY JTID  LIMIT 1";
  var result = await dbClient!.rawQuery(sql);
  List<Job_Typ_Local> list = result.map((item) {
    return Job_Typ_Local.fromMap(item);
  }).toList();
  return list;
}

Future<List<Bra_Inf_Local>> Get_Bra_Inf(int GETJTID, int GETBIID) async {
  var dbClient = await conn.database;
  String sql;
  sql =
  " SELECT BIID,CASE WHEN ${LoginController().LAN}=2 AND BINE IS NOT NULL THEN BINE ELSE BINA END  BINA_D"
      " FROM BRA_INF_ACC  WHERE JTID=$GETJTID AND BIID=$GETBIID AND BIST=1";
  var result = await dbClient!.rawQuery(sql);
  // print(sql);
  // print(result);
  // print('Get_Bra_Inf');
  List<Bra_Inf_Local> list = result.map((item) {
    return Bra_Inf_Local.fromMap(item);
  }).toList();
  return list;
}

Future<List<Bra_Inf_Local>> Get_Bra_Inf_One(int GETJTID) async {
  var dbClient = await conn.database;
  String sql;
  sql = " SELECT BIID,CASE WHEN ${LoginController().LAN}=2 AND BINE IS NOT NULL THEN BINE ELSE BINA END  BINA_D"
      " FROM BRA_INF_ACC  WHERE JTID=$GETJTID ORDER BY BIID  LIMIT 1 ";
  var result = await dbClient!.rawQuery(sql);
  // print(sql);
  // print(result);
  // print('Get_Bra_Inf_One');
  List<Bra_Inf_Local> list = result.map((item) {
    return Bra_Inf_Local.fromMap(item);
  }).toList();
  return list;
}

Future<List<Sys_Yea_Local>> Get_SYS_YEA_ONE(
    String GETJTID, String GETBIID) async {
  var dbClient = await conn.database;
  String sql;
  sql =
  " SELECT A.SYID,A.SYNO,A.SYSD,A.SYED FROM SYS_YEA_ACC A WHERE A.SYST IN(1,4) AND  EXISTS(SELECT 1 FROM BRA_YEA_ACC B "
      " WHERE B.JTID=$GETJTID AND B.BIID=$GETBIID AND B.SYID=A.SYID ) "
      " AND A.SYID=(SELECT MAX(C.SYID) FROM SYS_YEA_ACC C WHERE  C.SYST=A.SYST ) ORDER BY A.SYID DESC";
  var result = await dbClient!.rawQuery(sql);
  List<Sys_Yea_Local> list = result.map((item) {
    return Sys_Yea_Local.fromMap(item);
  }).toList();
  return list;
}

Future<List<Sys_Yea_Local>> Get_SYS_YEA(
    int GETSYNO, String GETJTID, String GETBIID, String GETSYID) async {
  var dbClient = await conn.database;
  String sql;
  if (GETSYNO == 1) {
    sql =
    " SELECT A.SYID,A.SYNO,A.SYSD,A.SYED FROM SYS_YEA_ACC A WHERE EXISTS(SELECT 1 FROM BRA_YEA_ACC B "
        " WHERE B.JTID=$GETJTID AND B.BIID=$GETBIID AND B.SYID=$GETSYID AND  A.SYID=B.SYID  ORDER BY B.JTID  LIMIT 1) ";
  } else {
    sql =
    " SELECT A.SYID,A.SYNO,A.SYSD,A.SYED FROM SYS_YEA_ACC A WHERE A.SYNO=$GETSYID AND EXISTS(SELECT 1 FROM BRA_YEA_ACC B "
        "WHERE B.JTID=$GETJTID AND B.BIID=$GETBIID AND A.SYID=B.SYID  ORDER BY B.JTID  LIMIT 1) ";
  }
  var result = await dbClient!.rawQuery(sql);
  List<Sys_Yea_Local> list = result.map((item) {
    return Sys_Yea_Local.fromMap(item);
  }).toList();
  return list;
}

Future<List<Sys_Usr_P_Local>> CHK_USR_PAW(int Type, String GETSUID,
    String GETSUPA, int GETJTID, int GETBIID, String GETSYID) async {
  var dbClient = await conn.database;
  String sql;
  String WhereSqlSUNA = Type == 1
      ? ' JTID=$GETJTID AND BIID=$GETBIID AND SYID=$GETSYID '
      : Type == 2
      ? ' JTID=$GETJTID AND BIID=$GETBIID '
      : ' JTID=$GETJTID ';

  sql =
  "SELECT SUID FROM SYS_USR_P  WHERE SUST=1 AND SUID='$GETSUID' AND SUPA='$GETSUPA'"
      "  AND $WhereSqlSUNA  ORDER BY JTID  LIMIT 1";
  var result = await dbClient!.rawQuery(sql);
  List<Sys_Usr_P_Local> list = result.map((item) {
    return Sys_Usr_P_Local.fromMap(item);
  }).toList();
  return list;
}

Future<List<Sys_Usr_P_Local>> Get_SUNA(
    int Type, int GETJTID, int GETBIID, String GETSUID) async {
  var dbClient = await conn.database;
  String sql;
  String WhereSqlSUNA =
  Type == 1 ? 'JTID=$GETJTID AND BIID=$GETBIID' : 'JTID=$GETJTID ';
  sql =
  " SELECT SUID,CASE WHEN ${LoginController().LAN}=2 AND SUNE IS NOT NULL THEN SUNE ELSE SUNA END  SUNA_D"
      " FROM SYS_USR_P  WHERE $WhereSqlSUNA AND SUID='$GETSUID'"
      " ORDER BY SUID  LIMIT 1";
  var result = await dbClient!.rawQuery(sql);
  List<Sys_Usr_P_Local> list = result.map((item) {
    return Sys_Usr_P_Local.fromMap(item);
  }).toList();
  return list;
}

Future<List<Job_Typ_Local>> Get_JTNA(int GETJTID) async {
  var dbClient = await conn.database;
  String sql;
  sql =
  " SELECT JTID,CASE WHEN ${LoginController().LAN}=2 AND JTNE IS NOT NULL THEN JTNE ELSE JTNA END  JTNA_D"
      " FROM JOB_TYP  WHERE JTID=$GETJTID";
  var result = await dbClient!.rawQuery(sql);
  List<Job_Typ_Local> list = result.map((item) {
    return Job_Typ_Local.fromMap(item);
  }).toList();
  return list;
}

Future<List<Bra_Inf_Local>> Get_BINA(int GETBINA) async {
  var dbClient = await conn.database;
  String sql;
  sql =
  " SELECT BIID,CASE WHEN ${LoginController().LAN}=2 AND BINE IS NOT NULL THEN BINE ELSE BINA END  BINA_D"
      " FROM BRA_INF  WHERE BIID=$GETBINA";
  var result = await dbClient!.rawQuery(sql);
  List<Bra_Inf_Local> list = result.map((item) {
    return Bra_Inf_Local.fromMap(item);
  }).toList();
  return list;
}

Future<List<Sys_Com_Local>> GetSysCom() async {
  var dbClient = await conn.database;
  String sql;
  sql = "select * from Sys_Com where SCID=1";
  var result = await dbClient!.rawQuery(sql);
  //if (result.length == 0) return null;
  List<Sys_Com_Local> list = result.map((item) {
    return Sys_Com_Local.fromMap(item);
  }).toList();
  // print(list);
  return list;
}

Future<List<Bra_Yea_Local>> GET_BRA_YEA(
    int GETJTID, int GETBIID, int GETSYID) async {
  var dbClient = await conn.database;
  String sql;
  LoginController().BIID_ALL_V == '1'
      ? sql2 = " AND  BIID_L=${LoginController().BIID}"
      : sql2 = '';
  sql =
  "select BYST from BRA_YEA WHERE  JTID=$GETJTID AND BIID=$GETBIID AND SYID=$GETSYID AND"
      " $WhereSql $sql2";
  var result = await dbClient!.rawQuery(sql);
  List<Bra_Yea_Local> list = result.map((item) {
    return Bra_Yea_Local.fromMap(item);
  }).toList();
  return list;
}

Future<List<Gen_Var_Local>> GET_GEN_VAR(String GETDES) async {
  var dbClient = await conn.database;
  String sql = '';
  String SQLBIID = '';
  String WhereSql = " JTID_L=${LoginController().JTID} AND SYID_L=${LoginController().SYID} "
      " AND CIID_L=${LoginController().CIID} ";
  SQLBIID = LoginController().BIID_ALL_V == '1'
      ? SQLBIID = " AND  BIID_L=${LoginController().BIID} " : SQLBIID = '';

  sql = " SELECT  * FROM GEN_VAR WHERE  DES='$GETDES' AND $WhereSql $SQLBIID LIMIT 1";
  var result = await dbClient!.rawQuery(sql);
  // print(sql);
  // print(result);
  // print('GET_GEN_VAR');
  List<Gen_Var_Local> list = result.map((item) {
    return Gen_Var_Local.fromMap(item);
  }).toList();
  return list;
}

Future<List<Gen_Var_Local>> GET_GEN_VAR_ACC(String GETDES) async {
  var dbClient = await conn.database;
  String sql = '';
  sql = "SELECT  * FROM GEN_VAR_ACC WHERE  DES='$GETDES'";
  var result = await dbClient!.rawQuery(sql);
  // print(sql);
  // print(result);
  // print('GET_GEN_VAR_ACC');
  List<Gen_Var_Local> list = result.map((item) {
    return Gen_Var_Local.fromMap(item);
  }).toList();
  return list;
}

Future<List<Sys_Own_Local>> GET_SYS_OWN_SOSI(String GETBIID) async {
  var dbClient = await conn.database;
  String sql;
  String Wheresql;
  LoginController().BIID_ALL_V == '1'
      ? Wheresql = " AND  A.BIID_L=${LoginController().BIID}"
      : Wheresql = '';
  sql = "SELECT  SOSI FROM SYS_OWN A WHERE  A.BIID='$GETBIID' "
      " AND A.JTID_L=${LoginController().JTID} "
      " AND A.SYID_L=${LoginController().SYID} AND A.CIID_L=${LoginController().CIID} $Wheresql LIMIT 1";
  var result = await dbClient!.rawQuery(sql);
  List<Sys_Own_Local> list = result.map((item) {
    return Sys_Own_Local.fromMap(item);
  }).toList();
  return list;
}

Future<List<Sys_Usr_Local>> GET_USR_NAME(String GETSUID) async {
  var dbClient = await conn.database;
  String sql;
  sql =
  "select SUID,SUMO,SUPA,CASE WHEN ${LoginController().LAN}=2 AND SUNE IS NOT NULL THEN SUNE ELSE SUNA END  SUNA_D"
      " FROM SYS_USR WHERE  SUID='$GETSUID' LIMIT 1 ";
  var result = await dbClient!.rawQuery(sql);
  List<Sys_Usr_Local> list = result.map((item) {
    return Sys_Usr_Local.fromMap(item);
  }).toList();
  return list;
}

Future<List<Config_Local>> GET_CONFIG(
    int GETJTID, int GETSYID, int GETBIID, String GETCIID) async {
  var dbClient = await conn.database;
  String sql;
  LoginController().BIID_ALL_V == '1'
      ? sql2 = " AND  BIID=$GETBIID"
      : sql2 = '';
  sql =
  "select * FROM CONFIG WHERE  JTID=$GETJTID AND SYID=$GETSYID AND CIID='$GETCIID' $sql2";
  var result = await dbClient!.rawQuery(sql);
  List<Config_Local> list = result.map((item) {
    return Config_Local.fromMap(item);
  }).toList();
  return list;
}

Future<Config_Local> SaveCONFIG(Config_Local data) async {
  var dbClient = await conn.database;
  data.JTID = await dbClient!.insert("CONFIG", data.toMap());
  return data;
}

Future<List<Sys_Own_Local>> GET_SYS_OWN(GetBIID) async {
  var dbClient = await conn.database;
  String sql;
  String Wheresql = '';
  LoginController().BIID_ALL_V == '1'
      ? Wheresql = " AND  A.BIID_L=${LoginController().BIID}"
      : Wheresql = '';
  sql =
  "SELECT * FROM SYS_OWN A WHERE A.BIID=$GetBIID AND A.JTID_L=${LoginController().JTID} "
      " AND A.SYID_L=${LoginController().SYID} AND A.CIID_L=${LoginController().CIID} $Wheresql LIMIT 1";
  var result = await dbClient!.rawQuery(sql);
  List<Sys_Own_Local> list = result.map((item) {
    return Sys_Own_Local.fromMap(item);
  }).toList();

  try {
    if (list[0].CWID.toString() != 'null') {
      list.elementAt(0).CWWC2 = await ES_FAT_PKG.TYP_NAM_F('CWWC2', list[0].CWID.toString(), '');
    }
    var BAID_V = await ES_FAT_PKG.TYP_NAM_F(
        'BAID', list.elementAt(0).BAID.toString(), '');
    list.elementAt(0).BAID_D = BAID_V == 'null' || BAID_V.isEmpty
        ? list.elementAt(0).SOQND.toString() : BAID_V.toString();
    list.elementAt(0).CTNA_D = await ES_FAT_PKG.TYP_NAM_F('CTID',
        list.elementAt(0).CWID.toString(), list.elementAt(0).CTID.toString());
    var IDE_LIN = await GET_IDE_LIN('BRA', list.elementAt(0).BIID.toString());
    if (IDE_LIN.isNotEmpty) {
      list.elementAt(0).ITSY = IDE_LIN.elementAt(0).ITSY.toString();
      list.elementAt(0).ILDE = IDE_LIN.elementAt(0).ILDE.toString();
    }
    var TAX_LIN_CUS = await GET_TAX_TYP_BRA(list.elementAt(0).BIID.toString(), LoginController().TTID_N.toString());
    if (TAX_LIN_CUS.isNotEmpty) {
      list.elementAt(0).SOTX = TAX_LIN_CUS.elementAt(0).TTBTN.toString();
    }
  } catch (e, stackTrace) {
    print(' $e $stackTrace');
    return list;
  }
  return list;
}

SaveLIST_VALUE(List_Value LIST_VALUE) async {
  var dbClient = await conn.database;
  final res = await dbClient!.insert('LIST_VALUE', LIST_VALUE.toMap());
  return res;
}

Future<List<Usr_Pri_Local>> PRIVLAGE(String GetSUID, int GetPRID) async {
  var dbClient = await conn.database;
  String sql;
  String Wheresql = '';
  LoginController().BIID_ALL_V == '1'
      ? Wheresql = " AND  BIID_L=${LoginController().BIID}"
      : Wheresql = '';

  sql = "SELECT * FROM USR_PRI WHERE PRID=$GetPRID AND SUID='$GetSUID' "
      " AND JTID_L=${LoginController().JTID} "
      " AND SYID_L=${LoginController().SYID} AND CIID_L='${LoginController().CIID}' $Wheresql";
  var result = await dbClient!.rawQuery(sql);
  // print(sql);
  // print(result);
  List<Usr_Pri_Local> list = result.map((item) {
    return Usr_Pri_Local.fromMap(item);
  }).toList();
  return list;
}

Future<List<Acc_Cas_Local>> GET_ACC_CAS(
    String GETBIID, String GETSCID, String GETSTMID, int GETKI) async {
  var dbClient = await conn.database;
  String sql;
  String Wheresql = '';
  String Wheresql2 = '';
  LoginController().BIID_ALL_V == '1'
      ? Wheresql = " AND A.BIID_L=${LoginController().BIID}"
      : Wheresql = '';
  LoginController().BIID_ALL_V == '1'
      ? Wheresql2 = " AND C.BIID_L=A.BIID_L"
      : Wheresql2 = '';

  sql =
  " SELECT A.ACID,CASE WHEN ${LoginController().LAN}=2 AND A.ACNE IS NOT NULL THEN A.ACNE ELSE A.ACNA END  ACNA_D"
      " FROM ACC_CAS A WHERE  A.JTID_L=${LoginController().JTID} AND A.SYID_L=${LoginController().SYID} "
      " AND A.CIID_L='${LoginController().CIID}' $Wheresql AND A.ACST!=2  AND(A.BIID IS NULL OR A.BIID=$GETBIID) "
      " AND  EXISTS(SELECT 1  FROM ACC_USR C WHERE C.AANO=A.AANO AND C.AUIN=1 AND C.SUID IS NOT NULL AND "
      " C.SUID='${LoginController().SUID}' AND ( C.CIID_L=A.CIID_L AND C.JTID_L=A.JTID_L AND C.SYID_L=A.SYID_L $Wheresql2)) "
  // " AND (A.ACCT =1 OR (A.ACCT IN(2) AND $GETSCID=1) OR (A.ACCT IN(3) AND $GETSCID<>1) "
  // " OR (A.ACCT IN(4) AND $GETSCID=A.SCID) OR (A.ACCT IN(5) AND $GETSCID<>A.SCID))"
  // " AND ((A.ACST<>3 AND  A.ACTM=1 AND A.ACTMS IN(1,2) AND A.ACTMP IN(0,1) AND  '$GETSTMID'='AC' AND $GETKI=1 ) "
  // " OR (A.ACST<>3 AND  A.ACTM=1 AND A.ACTMS IN(1,3) AND A.ACTMP IN(0,1) AND '$GETSTMID' IN('BO','BS') AND $GETKI IN(3,5) )"
  // " OR (A.ACST<>3 AND  A.ACTM=1 AND A.ACTMS IN(1,5) AND A.ACTMP IN(0,1) AND '$GETSTMID'='BI' AND $GETKI IN(2) )"
  // " OR (A.ACST<>4 AND A.ACGM=1 AND A.ACGMS IN(1,2) AND A.ACGMP IN(0,1) AND '$GETSTMID'='AC' AND $GETKI=2) "
  // " OR (A.ACST<>4 AND A.ACGM=1 AND A.ACGMS IN(1,5) AND A.ACGMP IN(0,1) AND '$GETSTMID'='BI' AND $GETKI=1) "
  // " OR (A.ACST<>4 AND A.ACGM=1 AND A.ACGMS IN(1,3) AND A.ACGMP IN(0,1) AND '$GETSTMID' IN('BO','BS') AND $GETKI IN(4,6)) )"
  // " AND ((A.SUIDT=1 AND (('$GETSTMID'='AC' AND $GETKI=1) OR ('$GETSTMID' IN('BO','BS') AND $GETKI IN(3,5)) OR "
  // " ('$GETSTMID' IN('BI') AND $GETKI IN(2)) ))  OR (A.SUIDG=1 AND (('$GETSTMID'='AC' AND $GETKI=2) OR ('$GETSTMID' IN('BO','BS') "
  // " AND $GETKI IN(4,6)) OR ('$GETSTMID' IN('BI') AND $GETKI IN(1)))) ) OR EXISTS(SELECT 1 FROM ACC_CAS_U B WHERE B.ACUST=1 "
  // " AND B.ACID=A.ACID AND ( B.CIID_L=A.CIID_L AND B.JTID_L=A.JTID_L AND B.SYID_L=A.SYID_L  $Wheresql3)"
  // "  AND ((B.ACUTY=1 AND (('$GETSTMID'='AC' AND $GETKI=1) OR ('$GETSTMID' IN('BO','BS') AND $GETKI IN(3,5)) "
  // " OR('$GETSTMID' IN('BI') AND $GETKI IN(2))))  OR ( B.ACUTY=2 AND (('$GETSTMID'='AC' AND $GETKI=2) "
  // " OR ('$GETSTMID' IN('BO','BS') AND $GETKI IN(4,6)) OR ('$GETSTMID' IN('BI') AND $GETKI IN(1)))) "
  // " AND B.SUID IS NOT NULL AND B.SUID='${LoginController().SUID}' AND (B.ACCT =1 OR (B.ACCT IN(2) AND $GETSCID=1) "
  // " OR (B.ACCT IN(3) AND $GETSCID<>1) OR (B.ACCT IN(4) AND $GETSCID=B.SCID) OR (B.ACCT IN(5) AND $GETSCID<>B.SCID)) "
  // " AND ((B.ACTMS IN(1,2) AND B.ACTMP IN(0,1) AND '$GETSTMID'='AC' AND $GETKI=1 ) OR (B.ACTMS IN(1,3) AND B.ACTMP IN(0,1) "
  // " AND '$GETSTMID' IN('BO','BS') AND $GETKI IN(3,5)) OR (B.ACTMS IN(1,5) AND B.ACTMP IN(0,1) AND '$GETSTMID'='BI' AND $GETKI IN(2)) "
  // " OR ( A.ACTMS IN(1,2) AND A.ACTMP IN(0,1) AND '$GETSTMID'='AC' AND $GETKI=2) OR (A.ACTMS IN(1,5) AND A.ACTMP IN(0,1) "
  // " AND '$GETSTMID'='BI' AND $GETKI=1) OR (A.ACTMS IN(1,3) AND A.ACTMP IN(0,1) AND '$GETSTMID' IN('BO','BS') AND $GETKI IN(4,6)))))"
      "  ORDER BY A.ACID ";

  var result = await dbClient!.rawQuery(sql);
  List<Acc_Cas_Local> list = result.map((item) {
    return Acc_Cas_Local.fromMap(item);
  }).toList();
  return list;
}

Future<List<Acc_Cas_Local>> GET_ACC_CAS_ONE(String GETBIID, String GETSCID,
    String GETSTMID, int GETKI, int GETACID) async {
  var dbClient = await conn.database;
  String sql;
  String Wheresql = '';
  String Wheresql2 = '';
  LoginController().BIID_ALL_V == '1'
      ? Wheresql = " AND A.BIID_L=${LoginController().BIID}"
      : Wheresql = '';
  LoginController().BIID_ALL_V == '1'
      ? Wheresql2 = " AND C.BIID_L=A.BIID_L"
      : Wheresql2 = '';

  sql = sql = " SELECT A.ACID,CASE WHEN ${LoginController().LAN}=2 AND A.ACNE IS NOT NULL THEN A.ACNE ELSE A.ACNA END  ACNA_D"
      " FROM ACC_CAS A WHERE  A.JTID_L=${LoginController().JTID} AND A.SYID_L=${LoginController().SYID} "
      " AND A.CIID_L='${LoginController().CIID}' $Wheresql AND A.ACST!=2  AND(A.BIID IS NULL OR A.BIID=$GETBIID) AND "
      "  A.ACID=$GETACID AND  EXISTS(SELECT 1  FROM ACC_USR C WHERE C.AANO=A.AANO AND C.AUIN=1 AND C.SUID IS NOT NULL AND "
      " C.SUID='${LoginController().SUID}' AND ( C.CIID_L=A.CIID_L AND C.JTID_L=A.JTID_L AND C.SYID_L=A.SYID_L $Wheresql2)) "
      "  ORDER BY A.ACID LIMIT 1";
  var result = await dbClient!.rawQuery(sql);
  List<Acc_Cas_Local> list = result.map((item) {
    return Acc_Cas_Local.fromMap(item);
  }).toList();
  return list;
}

Future<List<Acc_Cos_Local>> GET_ACC_COS() async {
  var dbClient = await conn.database;
  String sql;
  String Wheresql = '';
  String Wheresql2 = '';
  LoginController().BIID_ALL_V == '1'
      ? Wheresql = " AND A.BIID_L=${LoginController().BIID}"
      : Wheresql = '';
  LoginController().BIID_ALL_V == '1'
      ? Wheresql2 = " AND D.BIID_L=${LoginController().BIID}"
      : Wheresql2 = '';

  sql =
  "SELECT A.ACNO,CASE WHEN ${LoginController().LAN}=2 AND A.ACNE IS NOT NULL THEN A.ACNE ELSE A.ACNA END  ACNA_D "
      " FROM ACC_COS A WHERE A.ACST=1 AND A.ACTY=2 AND A.JTID_L=${LoginController().JTID} "
      " AND A.SYID_L=${LoginController().SYID} AND A.CIID_L=${LoginController().CIID} $Wheresql "
      " AND  EXISTS(SELECT 1 FROM COS_USR D WHERE D.ACNO=A.ACNO AND D.CUOU=1 AND D.SUID='${LoginController().SUID}' "
      " AND D.JTID_L=${LoginController().JTID} AND D.SYID_L=${LoginController().SYID} "
      " AND D.CIID_L=${LoginController().CIID} $Wheresql2 ) ORDER BY A.ACNO";
  final result = await dbClient!.rawQuery(sql);
  // print(result);
  return result.map((json) => Acc_Cos_Local.fromMap(json)).toList();
}

Future<List<Acc_Mov_K_Local>> GET_ACC_MOV_K(int GetAMKID) async {
  var dbClient = await conn.database;
  String sql;
  String Wheresql = '';
  LoginController().BIID_ALL_V == '1'
      ? Wheresql = " AND  BIID_L=${LoginController().BIID}"
      : Wheresql = '';

  sql = "SELECT AMKST FROM ACC_MOV_K WHERE AMKID=$GetAMKID "
      " AND JTID_L=${LoginController().JTID} "
      " AND SYID_L=${LoginController().SYID} AND CIID_L='${LoginController().CIID}' $Wheresql";
  var result = await dbClient!.rawQuery(sql);
  List<Acc_Mov_K_Local> list = result.map((item) {
    return Acc_Mov_K_Local.fromMap(item);
  }).toList();
  return list;
}

Future<List<Bil_Mov_K_Local>> GET_BIL_MOV_K_State(int GetBMKID) async {
  var dbClient = await conn.database;
  String sql;
  String Wheresql = '';
  LoginController().BIID_ALL_V == '1'
      ? Wheresql = " AND  BIID_L=${LoginController().BIID}"
      : Wheresql = '';

  sql = "SELECT BMKST FROM BIL_MOV_K WHERE BMKID=$GetBMKID "
      " AND JTID_L=${LoginController().JTID} "
      " AND SYID_L=${LoginController().SYID} AND CIID_L='${LoginController().CIID}' $Wheresql";
  var result = await dbClient!.rawQuery(sql);
  List<Bil_Mov_K_Local> list = result.map((item) {
    return Bil_Mov_K_Local.fromMap(item);
  }).toList();
  return list;
}

Future<List<Bil_Mov_K_Local>> GET_BIL_MOV_K() async {
  var dbClient = await conn.database;
  String sql;
  String Wheresql = '';
  LoginController().BIID_ALL_V == '1'
      ? Wheresql = " AND  BIID_L=${LoginController().BIID}"
      : Wheresql = '';

  sql =
  "SELECT BMKID,CASE WHEN ${LoginController().LAN}=2 AND BMKNA IS NOT NULL THEN BMKNE ELSE BMKNA END  BMKNA_D"
      " FROM BIL_MOV_K WHERE BMKID IN(1,2,3,4,5,11,12) "
      " AND JTID_L=${LoginController().JTID} "
      " AND SYID_L=${LoginController().SYID} AND CIID_L='${LoginController().CIID}' $Wheresql";
  var result = await dbClient!.rawQuery(sql);
  List<Bil_Mov_K_Local> list = result.map((item) {
    return Bil_Mov_K_Local.fromMap(item);
  }).toList();
  return list;
}

Future<List<Bra_Inf_Local>> GET_BRA_ONE_CHECK(int GETBIID) async {
  var dbClient = await conn.database;
  String sql;
  String Wheresql = '';
  String Wheresql2 = '';
  LoginController().BIID_ALL_V == '1'
      ? Wheresql = " AND  A.BIID_L=${LoginController().BIID}"
      : Wheresql = '';
  LoginController().BIID_ALL_V == '1'
      ? Wheresql2 = " AND  B.BIID_L=${LoginController().BIID}"
      : Wheresql2 = '';

  sql =
  "SELECT A.BIID,CASE WHEN ${LoginController().LAN}=2 AND BINE IS NOT NULL THEN BINE ELSE BINA END  BINA_D"
      " FROM BRA_INF A WHERE BIID=$GETBIID AND A.BIST=1  AND A.JTID_L=${LoginController().JTID} "
      "AND A.SYID_L=${LoginController().SYID} AND A.CIID_L='${LoginController().CIID}' $Wheresql"
      " AND EXISTS(SELECT 1 FROM SYS_USR_B B WHERE B.BIID IS NOT NULL "
      " AND B.BIID=A.BIID AND B.SUID IS NOT NULL AND B.SUID=${LoginController().SUID} AND B.SUBST=1 AND B.SUBIN=1"
      " AND B.JTID_L=${LoginController().JTID} "
      " AND B.SYID_L=${LoginController().SYID} AND B.CIID_L='${LoginController().CIID}' $Wheresql2)"
      " ORDER BY A.BIID ";
  var result = await dbClient!.rawQuery(sql);
  List<Bra_Inf_Local> list = result.map((item) {
    return Bra_Inf_Local.fromMap(item);
  }).toList();
  return list;
}

Future<List<Bra_Inf_Local>> GET_BRA_ONE(int GETTYPE) async {
  var dbClient = await conn.database;
  String sql;
  String sq2 = '';
  String Wheresql = '';
  String Wheresql2 = '';
  LoginController().BIID_ALL_V == '1'
      ? Wheresql = " AND  A.BIID_L=${LoginController().BIID}"
      : Wheresql = '';
  LoginController().BIID_ALL_V == '1'
      ? Wheresql2 = " AND  B.BIID_L=${LoginController().BIID}"
      : Wheresql2 = '';
  GETTYPE == 2 ? sq2 = ' AND B.SUBPR=1 ' : sq2 = ' AND B.SUBIN=1 ';
  sql =
  "SELECT A.BIID,CASE WHEN ${LoginController().LAN}=2 AND BINE IS NOT NULL THEN BINE ELSE BINA END  BINA_D"
      " FROM BRA_INF A WHERE A.BIST=1  AND A.JTID_L=${LoginController().JTID} "
      "AND A.SYID_L=${LoginController().SYID} AND A.CIID_L='${LoginController().CIID}' $Wheresql"
      " AND EXISTS(SELECT 1 FROM SYS_USR_B B WHERE B.BIID IS NOT NULL "
      " AND B.BIID=A.BIID AND B.SUID IS NOT NULL AND B.SUID=${LoginController().SUID} AND B.SUBST=1 $sq2 "
      " AND B.JTID_L=${LoginController().JTID} "
      " AND B.SYID_L=${LoginController().SYID} AND B.CIID_L='${LoginController().CIID}' $Wheresql2)"
      " ORDER BY A.BIID LIMIT 1 ";
  var result = await dbClient!.rawQuery(sql);
  List<Bra_Inf_Local> list = result.map((item) {
    return Bra_Inf_Local.fromMap(item);
  }).toList();
  return list;
}

Future<Fas_Acc_Usr_Local> Save_FAS_ACC_USR(Fas_Acc_Usr_Local data) async {
  var dbClient = await conn.database;
  await dbClient!.insert('FAS_ACC_USR', data.toMap());
  return data;
}

Future<int> UpdateFAS_ACC_USR(int GETSSID, int GETSSST2) async {
  var dbClient = await conn.database;
  final data = {'FAUST2': GETSSST2};
  final data2 = {'FAUST2': 2};
  final result = await dbClient!.update('FAS_ACC_USR', data,
      where: " SSID=$GETSSID AND FAUST=2 AND SUID='${LoginController().SUID}'");
  final result2 = await dbClient.update('FAS_ACC_USR', data2,
      where:
      " SSID!=$GETSSID AND FAUST=2 AND SUID='${LoginController().SUID}'");
  return result;
}

SaveFAS_ACC_USR(Fas_Acc_Usr_Local FAS_ACC_USR) async {
  var dbClient = await conn.database;
  final res = await dbClient!.insert('FAS_ACC_USR', FAS_ACC_USR.toMap());
  return res;
}

Future<int> deleteFAS_ACC_USR() async {
  var dbClient = await conn.database;
  return await dbClient!.delete('FAS_ACC_USR');
}

Future<int> UpdateFAS_ACC_USR_ORDNU(int GETSSID, int GETORDNU) async {
  var dbClient = await conn.database;
  final data = {'ORDNU': GETORDNU};
  final result =
  await dbClient!.update('FAS_ACC_USR', data, where: ' SSID=$GETSSID');
  return result;
}

Future<List<Fas_Acc_Usr_Local>> GET_FAS_ACC_USR(String GETFAUST) async {
  var dbClient = await conn.database;
  String sql;
  String Wheresql = '';
  String Wheresql2 = '';
  LoginController().BIID_ALL_V == '1'
      ? Wheresql = " AND  A.BIID_L=${LoginController().BIID}"
      : Wheresql = '';
  LoginController().BIID_ALL_V == '1'
      ? Wheresql2 = " AND  B.BIID_L=${LoginController().BIID}"
      : Wheresql2 = '';

  sql =
  " SELECT A.SSID,A.FAUST2,A.FAUST,CASE WHEN ${LoginController().LAN}=2 AND B.SSDE IS NOT NULL THEN B.SSDE ELSE B.SSDA END  SSDA_D "
      " FROM FAS_ACC_USR A,SYS_SCR B WHERE A.FAUST=$GETFAUST AND A.SSID=B.SSID AND A.SUID='${LoginController().SUID}' "
      " AND A.JTID_L=${LoginController().JTID} "
      " AND A.SYID_L=${LoginController().SYID} AND A.CIID_L='${LoginController().CIID}' $Wheresql"
      " AND B.JTID_L=${LoginController().JTID} "
      " AND B.SYID_L=${LoginController().SYID} AND B.CIID_L='${LoginController().CIID}' $Wheresql2"
      " ORDER BY A.ORDNU ";
  var result = await dbClient!.rawQuery(sql);
  List<Fas_Acc_Usr_Local> list = result.map((item) {
    return Fas_Acc_Usr_Local.fromMap(item);
  }).toList();
  return list;
}

Future<int> UpdateFAS_ACC_USR_Single(int GETSSID, int GETSSST2) async {
  var dbClient = await conn.database;
  String Wheresql = '';
  LoginController().BIID_ALL_V == '1'
      ? Wheresql = " AND  BIID_L=${LoginController().BIID}"
      : Wheresql = '';
  final data = {'FAUST2': GETSSST2};
  final data2 = {'FAUST2': 2};
  final result = await dbClient!.update('FAS_ACC_USR', data,
      where: " SSID=$GETSSID AND FAUST=1 AND SUID='${LoginController().SUID}' "
          " AND JTID_L=${LoginController().JTID} AND SYID_L=${LoginController().SYID} AND CIID_L='${LoginController().CIID}' $Wheresql");
  final result2 = await dbClient.update('FAS_ACC_USR', data2,
      where: " SSID!=$GETSSID AND FAUST=1 AND SUID='${LoginController().SUID}'"
          " AND JTID_L=${LoginController().JTID} AND SYID_L=${LoginController().SYID} AND CIID_L='${LoginController().CIID}' $Wheresql");
  return result;
}

Future<List<Qr_Inf_Local>> GET_QR_INF() async {
  var dbClient = await conn.database;
  String sql;
  String Wheresql = '';
  LoginController().BIID_ALL_V == '1'
      ? Wheresql = " AND  A.BIID_L=${LoginController().BIID}"
      : Wheresql = '';

  sql = " SELECT * FROM QR_INF A WHERE  A.JTID_L=${LoginController().JTID} "
      " AND A.SYID_L=${LoginController().SYID} AND A.CIID_L='${LoginController().CIID}' $Wheresql "
      " ORDER BY A.QIID ";
  var result = await dbClient!.rawQuery(sql);
  List<Qr_Inf_Local> list = result.map((item) {
    return Qr_Inf_Local.fromMap(item);
  }).toList();
  return list;
}

Future<Qr_Inf_Local> Save_QR_INF(Qr_Inf_Local data) async {
  var dbClient = await conn.database;
  data.QIID = await dbClient!.insert('QR_INF', data.toMap());
  return data;
}

Future<List<Qr_Inf_Local>> GET_QIID() async {
  var dbClient = await conn.database;
  String sql;
  sql = "SELECT ifnull(MAX(QIID),0)+1 AS BMMID FROM QR_INF ";
  var result = await dbClient!.rawQuery(sql);
  List<Qr_Inf_Local> list = result.map((item) {
    return Qr_Inf_Local.fromMap(item);
  }).toList();
  return list;
}

Future<int> UpdateFAS_ACC_USR_FAUST(
    int GETSSID, int GETFAUST, int GETFAUST_F, int GETORDNU) async {
  var dbClient = await conn.database;
  String Wheresql = '';
  LoginController().BIID_ALL_V == '1'
      ? Wheresql = " AND  BIID_L=${LoginController().BIID}"
      : Wheresql = '';
  final data = GETFAUST == 1
      ? {'FAUST': GETFAUST, 'FAUST2': 2, 'ORDNU': GETORDNU}
      : {'FAUST': GETFAUST, 'FAUST2': GETFAUST};
  final result = await dbClient!.update('FAS_ACC_USR', data,
      where:
      " SSID=$GETSSID AND FAUST=$GETFAUST_F AND SUID='${LoginController().SUID}'"
          " AND JTID_L=${LoginController().JTID} "
          " AND SYID_L=${LoginController().SYID} AND CIID_L='${LoginController().CIID}' $Wheresql");
  return result;
}

Future<int> UpdateFAS_ACC_USR__FAUST2() async {
  var dbClient = await conn.database;
  String Wheresql = '';
  LoginController().BIID_ALL_V == '1'
      ? Wheresql = " AND  BIID_L=${LoginController().BIID}"
      : Wheresql = '';
  final data = {'FAUST2': 2};
  final result = await dbClient!.update('FAS_ACC_USR', data,
      where: " SUID='${LoginController().SUID}'"
          " AND JTID_L=${LoginController().JTID} AND SYID_L=${LoginController().SYID} AND CIID_L='${LoginController().CIID}' $Wheresql ");
  return result;
}

Future<List<Mat_Pri_Local>> GET_MAT_PRI(
    int GETBIID, String GETMGNO, String GETMINO, int GETSCID) async {
  var dbClient = await conn.database;
  String sql;
  String Wheresql = '';
  String Wheresql2 = '';
  String Wheresql3 = '';
  String Wheresql4 = '';
  LoginController().BIID_ALL_V == '1'
      ? Wheresql = " AND  A.BIID_L=${LoginController().BIID}"
      : Wheresql = '';
  LoginController().BIID_ALL_V == '1'
      ? Wheresql2 = " AND  B.BIID_L=${LoginController().BIID}"
      : Wheresql2 = '';
  LoginController().BIID_ALL_V == '1'
      ? Wheresql3 = " AND  C.BIID_L=${LoginController().BIID}"
      : Wheresql3 = '';
  LoginController().BIID_ALL_V == '1'
      ? Wheresql4 = " AND  D.BIID_L=${LoginController().BIID}"
      : Wheresql4 = '';

  sql = " SELECT A.MPCO,A.MPS1,A.MPS2,A.MPS3,D.SCSY,CASE WHEN ${LoginController().LAN}=2 AND B.MINE IS NOT NULL THEN B.MINE ELSE B.MINA END  MINA_D "
      ",CASE WHEN ${LoginController().LAN}=2 AND C.MUNE IS NOT NULL THEN C.MUNE ELSE C.MUNA END  MUNA_D "
      " FROM MAT_PRI A,MAT_INF B,MAT_UNI C,SYS_CUR D WHERE A.BIID=$GETBIID  AND A.MGNO='$GETMGNO' AND A.MINO='$GETMINO' "
      " AND A.JTID_L=${LoginController().JTID} AND A.SYID_L=${LoginController().SYID} AND A.CIID_L=${LoginController().CIID} $Wheresql "
      " AND (A.MGNO=B.MGNO AND A.MINO=B.MINO) AND  B.JTID_L=${LoginController().JTID} "
      " AND B.SYID_L=${LoginController().SYID} AND B.CIID_L=${LoginController().CIID} $Wheresql2"
      " AND A.MUID=C.MUID AND  C.JTID_L=${LoginController().JTID} "
      " AND C.SYID_L=${LoginController().SYID} AND C.CIID_L=${LoginController().CIID} $Wheresql3 "
      " AND A.SCID=D.SCID AND  D.JTID_L=${LoginController().JTID} "
      " AND D.SYID_L=${LoginController().SYID} AND D.CIID_L=${LoginController().CIID} $Wheresql4 ";
  var result = await dbClient!.rawQuery(sql);
  List<Mat_Pri_Local> list = result.map((item) {
    return Mat_Pri_Local.fromMap(item);
  }).toList();
  return list;
}

Future<List<Mat_Uni_B_Local>> GET_MAT_UNI_B(String GETMUCBC) async {
  var dbClient = await conn.database;
  String sql;
  String Wheresql = '';
  LoginController().BIID_ALL_V == '1'
      ? Wheresql = " AND  A.BIID_L=${LoginController().BIID}"
      : Wheresql = '';

  sql =
  "SELECT A.MGNO,A.MINO FROM MAT_UNI_B A WHERE A.MUCBC LIKE '%$GETMUCBC%' "
      " AND A.JTID_L=${LoginController().JTID} AND A.SYID_L=${LoginController().SYID} "
      " AND A.CIID_L=${LoginController().CIID} $Wheresql LIMIT 1 ";
  var result = await dbClient!.rawQuery(sql);
  List<Mat_Uni_B_Local> list = result.map((item) {
    return Mat_Uni_B_Local.fromMap(item);
  }).toList();
  return list;
}

Future<List<Mat_Inf_Local>> GET_MAT_INF(String GETMINO) async {
  var dbClient = await conn.database;
  String sql;
  String Wheresql = '';
  LoginController().BIID_ALL_V == '1'
      ? Wheresql = " AND  A.BIID_L=${LoginController().BIID}"
      : Wheresql = '';

  sql = "SELECT A.MGNO,A.MINO FROM MAT_INF A WHERE (A.MINO LIKE '%$GETMINO%' OR A.MINA LIKE '%$GETMINO%') "
      " AND A.JTID_L=${LoginController().JTID} AND A.SYID_L=${LoginController().SYID} "
      " AND A.CIID_L=${LoginController().CIID} $Wheresql LIMIT 1 ";
  var result = await dbClient!.rawQuery(sql);
  List<Mat_Inf_Local> list = result.map((item) {
    return Mat_Inf_Local.fromMap(item);
  }).toList();
  return list;
}

Future<List<Bil_Dis_Local>> GET_BIL_DIS_NAM(String GETBDID) async {
  var dbClient = await conn.database;
  String sql;
  String Wheresql = '';
  LoginController().BIID_ALL_V == '1'
      ? Wheresql = " AND  A.BIID_L=${LoginController().BIID}"
      : Wheresql = '';

  sql =
  "SELECT * FROM BIL_DIS A WHERE A.BDID=$GETBDID AND A.JTID_L=${LoginController().JTID} "
      " AND A.SYID_L=${LoginController().SYID} AND A.CIID_L='${LoginController().CIID}' $Wheresql";
  var result = await dbClient!.rawQuery(sql);

  List<Bil_Dis_Local> list = result.map((item) {
    return Bil_Dis_Local.fromMap(item);
  }).toList();
  return list;
}

Future<List<Sys_Var_Local>> GET_SYS_VAR(int GETSVID) async {
  var dbClient = await conn.database;
  String sql;
  String Wheresql = '';
  LoginController().BIID_ALL_V == '1'
      ? Wheresql = " AND  BIID_L=${LoginController().BIID}"
      : Wheresql = '';
  sql = " SELECT SVID,SVVL from SYS_VAR WHERE SVID=$GETSVID AND JTID_L=${LoginController().JTID} "
      " AND SYID_L=${LoginController().SYID} AND CIID_L='${LoginController().CIID}' $Wheresql";
  var result = await dbClient!.rawQuery(sql);
  List<Sys_Var_Local> list = result.map((item) {
    return Sys_Var_Local.fromMap(item);
  }).toList();
  return list;
}

Future<List<Acc_Ban_Local>> GET_ACC_BAN(String GETBIID) async {
  var dbClient = await conn.database;
  String sql;
  String Wheresql = '';
  String Wheresql2 = '';
  LoginController().BIID_ALL_V == '1'
      ? Wheresql = " AND  A.BIID_L=${LoginController().BIID}"
      : Wheresql = '';
  LoginController().BIID_ALL_V == '1'
      ? Wheresql2 = " AND  B.BIID_L=${LoginController().BIID}"
      : Wheresql2 = '';

  sql =
  "SELECT A.ABID,CASE WHEN ${LoginController().LAN}=2 AND A.ABNE IS NOT NULL THEN A.ABNE ELSE A.ABNA END  ABNA_D"
      " FROM ACC_BAN A WHERE A.ABST!=2  AND (A.BIID IS NULL OR A.BIID=$GETBIID) "
      " AND EXISTS(SELECT 1 FROM ACC_USR B WHERE B.AANO=A.AANO AND B.AUIN=1 "
      " AND B.SUID IS NOT NULL AND B.SUID=${LoginController().SUID} "
      " AND B.JTID_L=${LoginController().JTID} AND B.SYID_L=${LoginController().SYID} AND "
      " B.CIID_L='${LoginController().CIID}' $Wheresql2 ) AND A.JTID_L=${LoginController().JTID} "
      " AND A.SYID_L=${LoginController().SYID} AND A.CIID_L='${LoginController().CIID}' $Wheresql "
      "  ORDER BY A.ABID ";
  var result = await dbClient!.rawQuery(sql);
  List<Acc_Ban_Local> list = result.map((item) {
    return Acc_Ban_Local.fromMap(item);
  }).toList();
  return list;
}

Future<List<Acc_Ban_Local>> GET_ACC_BAN_ONE(String GETBIID, int GETABID) async {
  var dbClient = await conn.database;
  String sql;
  String Wheresql = '';
  String Wheresql2 = '';
  LoginController().BIID_ALL_V == '1'
      ? Wheresql = " AND  A.BIID_L=${LoginController().BIID}"
      : Wheresql = '';
  LoginController().BIID_ALL_V == '1'
      ? Wheresql2 = " AND  B.BIID_L=${LoginController().BIID}"
      : Wheresql2 = '';

  sql =
  "SELECT A.ABID,CASE WHEN ${LoginController().LAN}=2 AND A.ABNE IS NOT NULL THEN A.ABNE ELSE A.ABNA END  ABNA_D"
      " FROM ACC_BAN A WHERE A.ABST!=2  AND (A.BIID IS NULL OR A.BIID=$GETBIID AND A.ABID=$GETABID) "
      " AND EXISTS(SELECT 1 FROM ACC_USR B WHERE B.AANO=A.AANO AND B.AUIN=1 "
      " AND B.SUID IS NOT NULL AND B.SUID=${LoginController().SUID} "
      " AND B.JTID_L=${LoginController().JTID} AND B.SYID_L=${LoginController().SYID} AND "
      " B.CIID_L='${LoginController().CIID}' $Wheresql2 ) AND A.JTID_L=${LoginController().JTID} "
      " AND A.SYID_L=${LoginController().SYID} AND A.CIID_L='${LoginController().CIID}' $Wheresql "
      "  ORDER BY A.ABID ";
  var result = await dbClient!.rawQuery(sql);
  List<Acc_Ban_Local> list = result.map((item) {
    return Acc_Ban_Local.fromMap(item);
  }).toList();
  return list;
}

Future<List<Bal_Acc_C_Local>> GET_BIL_ACC_C(String GETAANO, GETGUID, String GETBIID, String GETSCID) async {
  var dbClient = await conn.database;
  String sql;
  String Wheresql = '';
  LoginController().BIID_ALL_V == '1'
      ? Wheresql = " AND  A.BIID_L=${LoginController().BIID}"
      : Wheresql = '';

  sql = " SELECT A.BACBMD,A.BACBDA,A.BACBA,A.BACBNF,A.BACBAS,A.BACBAR1,A.BACLU,A.BACMN,A.BACLP,A.BACLBI,"
      " A.BACLBN,A.BACLBD FROM BAL_ACC_C A WHERE A.AANO='$GETAANO'  AND A.SCID=$GETSCID "
      " AND A.JTID_L=${LoginController().JTID} AND A.SYID_L=${LoginController().SYID} "
      " AND A.CIID_L='${LoginController().CIID}' $Wheresql LIMIT 1";
  var result = await dbClient!.rawQuery(sql);
  List<Bal_Acc_C_Local> list = result.map((item) {
    return Bal_Acc_C_Local.fromMap(item);
  }).toList();
  return list;
}

Future<List<Bil_Cre_C_Local>> GET_BIL_CRE_C(String GETBIID) async {
  var dbClient = await conn.database;
  String sql;
  String Wheresql = '';
  String Wheresql2 = '';
  LoginController().BIID_ALL_V == '1'
      ? Wheresql = " AND  A.BIID_L=${LoginController().BIID}"
      : Wheresql = '';
  LoginController().BIID_ALL_V == '1'
      ? Wheresql2 = " AND  B.BIID_L=${LoginController().BIID}"
      : Wheresql2 = '';

  sql =
  "SELECT A.BCCID,A.BCCPK,A.BCCSP,CASE WHEN ${LoginController().LAN}=2 AND A.BCCNE IS NOT NULL THEN A.BCCNE ELSE A.BCCNA END  BCCNA_D"
      " FROM BIL_CRE_C A WHERE A.BCCST!=2 AND (A.BIID IS NULL OR A.BIID=$GETBIID) "
      " AND EXISTS(SELECT 1 FROM ACC_USR B WHERE B.AANO=A.AANO AND B.AUIN=1 "
      " AND B.SUID IS NOT NULL AND B.SUID='${LoginController().SUID}' "
      " AND B.JTID_L=${LoginController().JTID} AND B.SYID_L=${LoginController().SYID} AND "
      " B.CIID_L='${LoginController().CIID}' $Wheresql2 ) AND A.JTID_L=${LoginController().JTID} AND A.SYID_L=${LoginController().SYID} "
      " AND A.CIID_L='${LoginController().CIID}' $Wheresql"
      "  ORDER BY A.BCCID ";
  var result = await dbClient!.rawQuery(sql);
  List<Bil_Cre_C_Local> list = result.map((item) {
    return Bil_Cre_C_Local.fromMap(item);
  }).toList();
  // print(sql);
  // print(result);
  return list;
}

Future<List<Bil_Cre_C_Local>> GET_BIL_CRE_C_ONE(String GETBIID, int GETBCCID) async {
  var dbClient = await conn.database;
  String sql;
  String Wheresql = '';
  String Wheresql2 = '';
  LoginController().BIID_ALL_V == '1'
      ? Wheresql = " AND  A.BIID_L=${LoginController().BIID}"
      : Wheresql = '';
  LoginController().BIID_ALL_V == '1'
      ? Wheresql2 = " AND  B.BIID_L=${LoginController().BIID}"
      : Wheresql2 = '';

  sql =
  "SELECT A.BCCID,CASE WHEN ${LoginController().LAN}=2 AND A.BCCNE IS NOT NULL THEN A.BCCNE ELSE A.BCCNA END  BCCNA_D"
      " FROM BIL_CRE_C A WHERE A.BCCST!=2 AND (A.BIID IS NULL OR A.BIID=$GETBIID AND A.BCCID=$GETBCCID) "
      " AND EXISTS(SELECT 1 FROM ACC_USR B WHERE B.AANO=A.AANO AND B.AUIN=1 "
      " AND B.SUID IS NOT NULL AND B.SUID='${LoginController().SUID}' "
      " AND B.JTID_L=${LoginController().JTID} AND B.SYID_L=${LoginController().SYID} AND "
      " B.CIID_L='${LoginController().CIID}' $Wheresql2 ) $Wheresql"
      "  ORDER BY A.BCCID ";
  var result = await dbClient!.rawQuery(sql);
  List<Bil_Cre_C_Local> list = result.map((item) {
    return Bil_Cre_C_Local.fromMap(item);
  }).toList();
  return list;
}

Future<List<Bra_Inf_Local>> GET_BRA(int GETTYPE) async {
  var dbClient = await conn.database;
  String sql;
  String sq2 = '';
  String Wheresql = '';
  String Wheresql2 = '';
  LoginController().BIID_ALL_V == '1'
      ? Wheresql = " AND  A.BIID_L=${LoginController().BIID}"
      : Wheresql = '';
  LoginController().BIID_ALL_V == '1'
      ? Wheresql2 = " AND  B.BIID_L=${LoginController().BIID}"
      : Wheresql2 = '';
  GETTYPE == 2 ? sq2 = ' AND B.SUBPR=1 ' : sq2 = ' AND B.SUBIN=1 ';
  sql =
  " SELECT A.BIID,A.BINA,CASE WHEN ${LoginController().LAN}=2 AND BINE IS NOT NULL THEN BINE ELSE BINA END  BINA_D "
      " FROM BRA_INF A WHERE A.BIST=1  AND A.JTID_L=${LoginController().JTID} "
      " AND A.SYID_L=${LoginController().SYID} AND A.CIID_L='${LoginController().CIID}' $Wheresql "
      " AND EXISTS(SELECT 1 FROM SYS_USR_B B WHERE B.BIID IS NOT NULL "
      " AND B.BIID=A.BIID AND B.SUID IS NOT NULL AND B.SUID=${LoginController().SUID} AND B.SUBST=1 $sq2"
      " AND B.JTID_L=${LoginController().JTID} "
      " AND B.SYID_L=${LoginController().SYID} AND B.CIID_L='${LoginController().CIID}' $Wheresql2)"
      " ORDER BY A.BIID ";

  var result = await dbClient!.rawQuery(sql);
  List<Bra_Inf_Local> list = result.map((item) {
    return Bra_Inf_Local.fromMap(item);
  }).toList();
  // print(result);
  // print(sql);
  return list;
}

//جلب تذليل المستندات
Future<List<Sys_Doc_D_Local>> Get_SYS_DOC_D(String GETSTID, int GETSDID, int GETBIID) async {
  var dbClient = await conn.database;
  String sql;
  String Wheresql;
  LoginController().BIID_ALL_V == '1'
      ? Wheresql = " AND BIID_L=${LoginController().BIID}"
      : Wheresql = '';

  sql = " SELECT *,CASE WHEN ${LoginController().LAN}=2 AND SDDDE IS NOT NULL THEN SDDDE ELSE SDDDA END  SDDDA_D,"
      " CASE WHEN ${LoginController().LAN}=2 AND SDDSE IS NOT NULL THEN SDDSE ELSE SDDSA END  SDDSA_D"
      " FROM SYS_DOC_D WHERE STID='$GETSTID' AND SDID=$GETSDID AND BIID=$GETBIID "
      " AND JTID_L=${LoginController().JTID} AND SYID_L=${LoginController().SYID} AND "
      " CIID_L=${LoginController().CIID} $Wheresql";
  var result = await dbClient!.rawQuery(sql);
  List<Sys_Doc_D_Local> list = result.map((item) {
    return Sys_Doc_D_Local.fromMap(item);
  }).toList();
  return list;
}

Future<List<Sys_Var_Local>> USE_SMDED() async {
  var dbClient = await conn.database;
  String sql;
  String Wheresql = '';
  LoginController().BIID_ALL_V == '1'
      ? Wheresql = " AND  BIID_L=${LoginController().BIID}"
      : Wheresql = '';

  sql =
  "select SVID,SVVL from SYS_VAR where SVID=976 AND JTID_L=${LoginController().JTID} "
      "AND SYID_L=${LoginController().SYID} AND CIID_L=${LoginController().CIID} $Wheresql";
  var result = await dbClient!.rawQuery(sql);
  //if (result.length == 0) return null;
  List<Sys_Var_Local> list = result.map((item) {
    return Sys_Var_Local.fromMap(item);
  }).toList();
  return list;
}

Future<int> DeleteROWIDLIST_VALUE() async {
  var dbClient = await conn.database;
  String sql =
      " DELETE FROM LIST_VALUE WHERE ROWID NOT IN(SELECT MIN(ROWID) FROM LIST_VALUE A "
      " GROUP BY A.LVID,A.LVTY) ";
  final res = await dbClient!.rawDelete(sql);
  return res;
}

Future<List<Sys_Cur_Local>> GET_SYS_CUR() async {
  var dbClient = await conn.database;
  String sql;
  String Wheresql = '';
  LoginController().BIID_ALL_V == '1'
      ? Wheresql = " AND  A.BIID_L=${LoginController().BIID}"
      : Wheresql = '';

  sql =
  "SELECT *,CASE WHEN ${LoginController().LAN}=2 AND A.SCNE IS NOT NULL THEN A.SCNE ELSE A.SCNA END  SCNA_D"
      " FROM SYS_CUR A WHERE A.SCST!=2 AND A.JTID_L=${LoginController().JTID} "
      " AND A.SYID_L=${LoginController().SYID} AND A.CIID_L='${LoginController().CIID}' $Wheresql"
      " ORDER BY A.ORDNU ";
  var result = await dbClient!.rawQuery(sql);
  List<Sys_Cur_Local> list = result.map((item) {
    return Sys_Cur_Local.fromMap(item);
  }).toList();
  return list;
}

Future<List<Pay_Kin_Local>> GET_PAY_ONE(String GET_PKID) async {
  var dbClient = await conn.database;
  String sql;
  String Wheresql = '';

  sql =
  "SELECT A.PKID,CASE WHEN ${LoginController().LAN}=2 AND A.PKNE IS NOT NULL THEN A.PKNE ELSE A.PKNA END  PKNA_D"
      " FROM PAY_KIN A WHERE  A.PKID=$GET_PKID AND  A.JTID_L=${LoginController().JTID} "
      " AND A.SYID_L=${LoginController().SYID} AND A.CIID_L='${LoginController().CIID}' $Wheresql"
      " ORDER BY A.PKID LIMIT 1 ";
  var result = await dbClient!.rawQuery(sql);
  List<Pay_Kin_Local> list = result.map((item) {
    return Pay_Kin_Local.fromMap(item);
  }).toList();
  return list;
}

Future<List<List_Value>> GET_SELECT(String GETV1, String GETV2, String GETV3) async {
  var dbClient = await conn.database;
  String sql;
  sql = "SELECT ${GETV1} ${GETV2} ${GETV3} AS SUM_AM";
  var result = await dbClient!.rawQuery(sql);
  List<List_Value> list = result.map((item) {
    return List_Value.fromMap_SUM(item);
  }).toList();
  return list;
}

Future<List<Bil_Cus_T_Local>> GET_BIL_CUS_T() async {
  var dbClient = await conn.database;
  String sql;
  String Wheresql = '';
  LoginController().BIID_ALL_V == '1'
      ? Wheresql = " AND  A.BIID_L=${LoginController().BIID}"
      : Wheresql = '';
  sql =
  "SELECT A.BCTID,CASE WHEN ${LoginController().LAN}=2 AND BCTNE IS NOT NULL THEN BCTNE ELSE BCTNA END  BCTNA_D"
      " FROM BIL_CUS_T A WHERE A.BCTST=1   AND A.JTID_L=${LoginController().JTID} "
      " AND A.SYID_L=${LoginController().SYID} AND A.CIID_L='${LoginController().CIID}' $Wheresql"
      " ORDER BY A.BCTID";

  var result = await dbClient!.rawQuery(sql);
  List<Bil_Cus_T_Local> list = result.map((item) {
    return Bil_Cus_T_Local.fromMap(item);
  }).toList();
  return list;
}

Future<List<Cou_Wrd_Local>> GET_COU_WRD() async {
  var dbClient = await conn.database;
  String sql;
  String Wheresql = '';
  LoginController().BIID_ALL_V == '1'
      ? Wheresql = " AND  A.BIID_L=${LoginController().BIID}"
      : Wheresql = '';
  sql =
  "SELECT A.CWID,CASE WHEN ${LoginController().LAN}=2 AND CWNE IS NOT NULL THEN CWNE ELSE CWNA END  CWNA_D"
      " FROM COU_WRD A WHERE A.CWST=1  AND A.JTID_L=${LoginController().JTID} "
      " AND A.SYID_L=${LoginController().SYID} AND A.CIID_L='${LoginController().CIID}' $Wheresql"
      " ORDER BY A.CWID";
  var result = await dbClient!.rawQuery(sql);
  List<Cou_Wrd_Local> list = result.map((item) {
    return Cou_Wrd_Local.fromMap(item);
  }).toList();
  return list;
}

Future<List<Bil_Are_Local>> GET_BIL_ARE_REP() async {
  var dbClient = await conn.database;
  String sql;
  String Wheresql = '';
  LoginController().BIID_ALL_V == '1'
      ? Wheresql = " AND  A.BIID_L=${LoginController().BIID}"
      : Wheresql = '';
  sql =
  "SELECT A.BAID,CASE WHEN ${LoginController().LAN}=2 AND BANE IS NOT NULL THEN BANE ELSE BANA END  BANA_D"
      " FROM BIL_ARE A WHERE A.BAST=1  AND A.JTID_L=${LoginController().JTID} "
      " AND A.SYID_L=${LoginController().SYID} AND A.CIID_L='${LoginController().CIID}' $Wheresql"
      " ORDER BY A.BAID";
  var result = await dbClient!.rawQuery(sql);
  List<Bil_Are_Local> list = result.map((item) {
    return Bil_Are_Local.fromMap(item);
  }).toList();
  return list;
}

Future<List<Acc_Mov_K_Local>> GET_ACC_MOV_K_TYPE() async {
  var dbClient = await conn.database;
  String sql;
  String Wheresql = '';
  LoginController().BIID_ALL_V == '1'
      ? Wheresql = " AND  A.BIID_L=${LoginController().BIID}"
      : Wheresql = '';

  sql =
  " SELECT A.AMKID,CASE WHEN ${LoginController().LAN}=2 AND A.AMKNE IS NOT NULL THEN A.AMKNE ELSE A.AMKNA END  AMKNA_D "
      " FROM ACC_MOV_K A WHERE A.AMKST!=2  AND A.STID='AC'  AND (AMKID IN (15,16,17,18,21,22,23,24,25,26,27,28,29,30,33"
      " ,34,35,36,37,38,39,40)  OR AMKDL=1) AND  A.JTID_L=${LoginController().JTID} "
      " AND A.SYID_L=${LoginController().SYID} AND A.CIID_L='${LoginController().CIID}' $Wheresql"
      " ORDER BY A.ORDNU ";
  var result = await dbClient!.rawQuery(sql);
  List<Acc_Mov_K_Local> list = result.map((item) {
    return Acc_Mov_K_Local.fromMap(item);
  }).toList();
  // print(sql);
  // print(result);
  return list;
}

Future<List<Bil_Dis_Local>> GET_BIL_DIS_ONE(String GETBIID, String GETBDID) async {
  var dbClient = await conn.database;
  String sql;
  String Wheresql = '';
  String Wheresql2 = '';
  LoginController().BIID_ALL_V == '1'
      ? Wheresql = " AND  A.BIID_L=${LoginController().BIID}"
      : Wheresql = '';
  LoginController().BIID_ALL_V == '1'
      ? Wheresql2 = " AND  B.BIID_L=${LoginController().BIID}"
      : Wheresql2 = '';

  sql =
  "SELECT * FROM BIL_DIS A WHERE A.BDST!=2 AND  (A.BIID IS NULL OR A.BIID==$GETBIID) AND A.BDID=$GETBDID AND "
      "  A.JTID_L=${LoginController().JTID} "
      " AND A.SYID_L=${LoginController().SYID} AND A.CIID_L='${LoginController().CIID}' $Wheresql "
      " AND EXISTS(SELECT 1 FROM ACC_USR B WHERE B.AANO=A.AANO AND B.AUIN=1 "
      " AND B.SUID IS NOT NULL AND B.SUID=${LoginController().SUID} AND B.JTID_L=${LoginController().JTID} "
      " AND B.SYID_L=${LoginController().SYID} AND B.CIID_L='${LoginController().CIID}' $Wheresql2)"
      " ORDER BY A.BDID ";
  var result = await dbClient!.rawQuery(sql);
  List<Bil_Dis_Local> list = result.map((item) {
    return Bil_Dis_Local.fromMap(item);
  }).toList();
  return list;
}

Future<List<Sto_Inf_Local>> GET_STO_INF_ONE_SALE(String StringBIID, String GETSIID) async {
  var dbClient = await conn.database;
  String sql;
  String Wheresql = '';
  String Wheresql2 = '';
  LoginController().BIID_ALL_V == '1'
      ? Wheresql = " AND A.BIID_L=${LoginController().BIID}"
      : Wheresql = '';
  LoginController().BIID_ALL_V == '1'
      ? Wheresql2 = " AND B.BIID_L=${LoginController().BIID}"
      : Wheresql2 = '';
  sql =
  "SELECT A.SIID FROM STO_INF A where A.SIST NOT IN(2,3) AND  (A.BIID IS NULL OR  A.BIID=$StringBIID) AND "
      " A.SIID=$GETSIID AND A.JTID_L=${LoginController().JTID} AND A.SYID_L=${LoginController().SYID} "
      " AND A.CIID_L=${LoginController().CIID}  $Wheresql  AND "
      " EXISTS(SELECT 1 FROM STO_USR B WHERE  B.SIID=A.SIID AND B.SUOU=1 AND B.SUID IS NOT NULL AND B.SUID=${LoginController().SUID}"
      " AND B.JTID_L=${LoginController().JTID} AND B.SYID_L=${LoginController().SYID} "
      " AND B.CIID_L=${LoginController().CIID} $Wheresql2) ORDER BY A.SIID LIMIT 1";
  var result = await dbClient!.rawQuery(sql);
  List<Sto_Inf_Local> list = result.map((item) {
    return Sto_Inf_Local.fromMap(item);
  }).toList();
  return list;
}

Future<int> UpdateSYS_USR(String GETSUAP) async {
  var dbClient = await conn.database;
  String SQLBIID = '';
  SQLBIID = LoginController().BIID_ALL_V == '1'
      ? SQLBIID = " AND  BIID_L=${LoginController().BIID}"
      : SQLBIID = '';
  final data = {'SUPA': GETSUAP};
  final result = await dbClient!.update('SYS_USR', data,
      where: " SUID='${LoginController().SUID}' AND  "
          " JTID_L=${LoginController().JTID} AND SYID_L=${LoginController().SYID} $SQLBIID "
          " AND CIID_L=${LoginController().CIID} ");
  return result;
}

Future<List<Cou_Tow_Local>> GET_COU_TOW(String GETCWID) async {
  var dbClient = await conn.database;
  String sql;
  String Wheresql = '';
  LoginController().BIID_ALL_V == '1'
      ? Wheresql = " AND  A.BIID_L=${LoginController().BIID}"
      : Wheresql = '';
  sql =
  "SELECT *,CASE WHEN ${LoginController().LAN}=2 AND CTNE IS NOT NULL THEN CTNE ELSE CTNA END  CTNA_D"
      " FROM COU_TOW A WHERE A.CWID='$GETCWID' AND A.JTID_L=${LoginController().JTID} "
      " AND A.SYID_L=${LoginController().SYID} AND A.CIID_L='${LoginController().CIID}' $Wheresql"
      " ORDER BY A.CTID";
  var result = await dbClient!.rawQuery(sql);
  List<Cou_Tow_Local> list = result.map((item) {
    return Cou_Tow_Local.fromMap(item);
  }).toList();
  // print(list);
  // print(sql);
  return list;
}

Future<List<Bil_Are_Local>> GET_BIL_ARE(String GETCWID, String GETCTID) async {
  var dbClient = await conn.database;
  String sql;
  String Wheresql = '';
  LoginController().BIID_ALL_V == '1'
      ? Wheresql = " AND  A.BIID_L=${LoginController().BIID}"
      : Wheresql = '';
  sql =
  "SELECT *,CASE WHEN ${LoginController().LAN}=2 AND BANE IS NOT NULL THEN BANE ELSE BANA END  BANA_D"
      " FROM BIL_ARE A WHERE A.BAST=1 AND A.CWID='$GETCWID' AND A.CTID='$GETCTID' AND A.JTID_L=${LoginController().JTID} "
      " AND A.SYID_L=${LoginController().SYID} AND A.CIID_L='${LoginController().CIID}' $Wheresql"
      " ORDER BY A.BAID";
  var result = await dbClient!.rawQuery(sql);
  List<Bil_Are_Local> list = result.map((item) {
    return Bil_Are_Local.fromMap(item);
  }).toList();
  return list;
}

Future<List<Sys_Cur_Local>> GET_SYS_CUR_ONE_P(String GETSCID) async {
  var dbClient = await conn.database;
  String sql;
  String Wheresql = '';
  LoginController().BIID_ALL_V == '1'
      ? Wheresql = " AND  A.BIID_L=${LoginController().BIID}"
      : Wheresql = '';

  sql =
  "SELECT *,CASE WHEN ${LoginController().LAN}=2 AND A.SCNE IS NOT NULL THEN A.SCNE ELSE A.SCNA END  SCNA_D"
      " FROM SYS_CUR A WHERE A.SCST NOT IN(2,4) AND A.SCID=$GETSCID AND A.JTID_L=${LoginController().JTID} "
      " AND A.SYID_L=${LoginController().SYID} AND A.CIID_L='${LoginController().CIID}' $Wheresql"
      " ORDER BY A.SCID ";
  var result = await dbClient!.rawQuery(sql);
  List<Sys_Cur_Local> list = result.map((item) {
    return Sys_Cur_Local.fromMap(item);
  }).toList();
  return list;
}

Future<List<Bil_Mov_M_Local>> GET_BIF_MOV_M_STATE(String GETBMMST) async {
  var dbClient = await conn.database;
  String sql = '';
  String Wheresql = '';
  String WheresqlGETBMMST = '';

  LoginController().BIID_ALL_V == '1'
      ? Wheresql = " AND A.BIID_L=${LoginController().BIID}"
      : Wheresql = '';
  GETBMMST == '0'
      ? WheresqlGETBMMST = ''
      : WheresqlGETBMMST = 'A.BMMST2=$GETBMMST AND';
  sql =
  "SELECT ifnull(COUNT(1),0) AS BMMNO,ifnull(SUM(A.BMMMT),0.0) AS BMMMT  FROM BIF_MOV_M A WHERE "
      " $WheresqlGETBMMST  A.JTID_L=${LoginController().JTID} "
      " AND A.SYID_L=${LoginController().SYID} AND A.CIID_L=${LoginController().CIID} $Wheresql ";
  var result = await dbClient!.rawQuery(sql);
  List<Bil_Mov_M_Local> list = result.map((item) {
    return Bil_Mov_M_Local.fromMap(item);
  }).toList();
  // print(sql);
  return list;
}

Future<List<Bil_Mov_D_Local>> GET_BIL_MOV_D_SUM(String TAB_N, String BMMIDNUM) async {
  var dbClient = await conn.database;
  //List<Map> maps = await dbClient!.query(STO_MOV_D_TABLE, columns: [SMDID, MINO,MUID,SMDNO]);
  String sql;
  String sql2 = '';
  String Wheresql = '';
  String Wheresql2 = '';
  String Wheresql3 = '';
  String Wheresql4 = '';
  LoginController().BIID_ALL_V == '1'
      ? Wheresql = " AND A.BIID_L=${LoginController().BIID}"
      : Wheresql = '';
  LoginController().BIID_ALL_V == '1'
      ? Wheresql2 = " AND B.BIID_L=${LoginController().BIID}"
      : Wheresql = '';
  LoginController().BIID_ALL_V == '1'
      ? Wheresql3 = " AND C.BIID_L=${LoginController().BIID}"
      : Wheresql3 = '';
  LoginController().BIID_ALL_V == '1'
      ? Wheresql4 = " AND D.BIID_L=${LoginController().BIID}"
      : Wheresql4 = '';

  sql =
  " SELECT *,CASE WHEN ${LoginController().LAN}=2 AND B.MINE IS NOT NULL AND "
      " C.MUNE IS NOT NULL THEN B.MINE||'-'||C.MUNE ELSE B.MINA||'-'||C.MUNA END  NAM,"
      " CASE WHEN ${LoginController().LAN}=2 AND B.MINE IS NOT NULL AND "
      " C.MUNE IS NOT NULL THEN B.MINO||'-'||B.MINE||'-'||C.MUNE ELSE B.MINO||' -'||B.MINA||'-'||C.MUNA END  NAM_D, "
      " CASE WHEN ${LoginController().LAN}=2 AND B.MINE IS NOT NULL  THEN B.MINE ELSE B.MINA END  MINA_D,"
      " CASE WHEN ${LoginController().LAN}=2 AND C.MUNE IS NOT NULL  THEN C.MUNE ELSE C.MUNA END  MUNA_D ,"
      " CASE WHEN ${LoginController().LAN}=2 AND D.MGNE IS NOT NULL  THEN D.MGNE ELSE D.MGNA END  MGNA_D "
      " FROM BIF_MOV_D A,MAT_INF B,MAT_UNI C ,MAT_GRO D "
      " WHERE  A.MINO=B.MINO AND A.MGNO=D.MGNO AND C.MUID=A.MUID AND B.MGNO=A.MGNO AND A.BMMID=$BMMIDNUM  $sql2"
      " AND A.JTID_L=${LoginController().JTID} "
      " AND A.SYID_L=${LoginController().SYID} AND A.CIID_L=${LoginController().CIID} $Wheresql"
      " AND B.JTID_L=${LoginController().JTID} "
      " AND B.SYID_L=${LoginController().SYID} AND B.CIID_L=${LoginController().CIID} $Wheresql2"
      " AND C.JTID_L=${LoginController().JTID} "
      " AND C.SYID_L=${LoginController().SYID} AND C.CIID_L=${LoginController().CIID} $Wheresql3"
      " AND D.JTID_L=${LoginController().JTID} "
      " AND D.SYID_L=${LoginController().SYID} AND D.CIID_L=${LoginController().CIID} $Wheresql4";
  var result = await dbClient!.rawQuery(sql);
  //if (result.isEmpty) return null;
  List<Bil_Mov_D_Local> list = result.map((item) {
    return Bil_Mov_D_Local.fromMap(item);
  }).toList();
  return list;
}

Future<List<Sto_Inf_Local>> Get_STO_INF(int GETBMKID, String StringBIID, String StringBPID) async {
  var dbClient = await conn.database;
  String sql;
  String sql2 = '';
  String Wheresql = '';
  String Wheresql2 = '';
  String Wheresql3 = '';
  if (GETBMKID == 11 || GETBMKID == 12) {
    sql2 =
    " AND EXISTS(SELECT 1 FROM BIL_POI_U D WHERE D.SIID=A.SIID AND D.BPID=$StringBPID "
        " AND D.JTID_L=${LoginController().JTID} AND D.SYID_L=${LoginController().SYID} "
        " AND D.CIID_L=${LoginController().CIID} $Wheresql3) ";
  } else {
    sql2 = '';
  }

  LoginController().BIID_ALL_V == '1'
      ? Wheresql = " AND A.BIID_L=${LoginController().BIID}"
      : Wheresql = '';
  LoginController().BIID_ALL_V == '1'
      ? Wheresql2 = " AND B.BIID_L=${LoginController().BIID}"
      : Wheresql2 = '';
  LoginController().BIID_ALL_V == '1'
      ? Wheresql3 = " AND D.BIID_L=${LoginController().BIID}"
      : Wheresql3 = '';
  sql = " SELECT A.*,CASE WHEN ${LoginController().LAN}=2 AND A.SINE IS NOT NULL THEN A.SINE ELSE A.SINA END  SINA_D"
      " FROM STO_INF A where A.SIST NOT IN(2,3) AND  (A.BIID IS NULL OR  A.BIID=$StringBIID)   "
      " AND A.JTID_L=${LoginController().JTID} AND A.SYID_L=${LoginController().SYID} "
      " AND A.CIID_L=${LoginController().CIID} $Wheresql AND"
      " EXISTS(SELECT 1 FROM STO_USR B WHERE  B.SIID=A.SIID AND B.SUOU=1 AND B.SUID IS NOT NULL AND SUID=${LoginController().SUID}"
      " AND B.JTID_L=${LoginController().JTID} AND B.SYID_L=${LoginController().SYID} "
      " AND B.CIID_L=${LoginController().CIID} $Wheresql2) $sql2 ORDER BY A.SIID ";
  //sql = "SELECT * FROM $STO_INF_TABLE A,$STO_NUM_TABLE B where A.$SIID(+)=B.$SIID AND A.$BIID=$StringBIID";
  var result = await dbClient!.rawQuery(sql);
  // if (result.isEmpty) return null;

  List<Sto_Inf_Local> list = result.map((item) {
    return Sto_Inf_Local.fromMap(item);
  }).toList();
  return list;
}



Future<List<Bil_Mov_M_Local>> GET_STATE_BIL_MOV(String TAB_N, String GET_BMMST,
    String GETBMKID, String GETDATE_F, String GETDATE_T) async {
  var dbClient = await conn.database;
  String sql = '';
  String Wheresql = '';

  LoginController().BIID_ALL_V == '1'
      ? Wheresql = " AND A.BIID_L=${LoginController().BIID}"
      : Wheresql = '';

  sql =
  " SELECT ifnull(SUM(A.BMMMT),0.0) AS BMMMT,ifnull(COUNT(1),0) AS BMMNO  FROM $TAB_N A WHERE "
      " A.BMKID=$GETBMKID  AND A.BMMST=$GET_BMMST AND  A.BMMDOR BETWEEN '$GETDATE_F' AND '$GETDATE_T'"
      " AND A.JTID_L=${LoginController().JTID} AND A.SYID_L=${LoginController().SYID} "
      " AND A.CIID_L=${LoginController().CIID} $Wheresql ";
  var result = await dbClient!.rawQuery(sql);
  List<Bil_Mov_M_Local> list = result.map((item) {
    return Bil_Mov_M_Local.fromMap(item);
  }).toList();
  return list;
}

Future<List<Bil_Mov_D_Local>> GET_MAX_MIN_ITEM_NO_BIL_MOV(String GETTYPE, String TAB_N, String TAB_D_N,
    String GETBMKID, String GETDATE_F, String GETDATE_T) async {
  var dbClient = await conn.database;
  String sql = '';
  String sql2 = '';
  String Wheresql = '';
  String Wheresql2 = '';

  GETTYPE == '1' ? sql2 = " DESC " : sql2 = ' ASC ';
  LoginController().BIID_ALL_V == '1'
      ? Wheresql = " AND A.BIID_L=${LoginController().BIID}"
      : Wheresql = '';
  LoginController().BIID_ALL_V == '1'
      ? Wheresql = " AND B.BIID_L=${LoginController().BIID}"
      : Wheresql = '';
  sql = " SELECT  A.MINO,A.BMDNO  FROM $TAB_N B,$TAB_D_N A,MAT_INF C   WHERE "
      " B.BMMID=A.BMMID AND  B.BMKID=$GETBMKID  AND  B.BMMDOR BETWEEN '$GETDATE_F' AND '$GETDATE_T'"
      " AND (C.MGNO=A.MGNO AND C.MINO=A.MINO)"
      " AND A.JTID_L=${LoginController().JTID} AND A.SYID_L=${LoginController().SYID} "
      " AND A.CIID_L=${LoginController().CIID} $Wheresql "
      " AND B.JTID_L=${LoginController().JTID} AND B.SYID_L=${LoginController().SYID} "
      " AND B.CIID_L=${LoginController().CIID} $Wheresql2 GROUP BY A.MINO,A.BMDNO ORDER BY SUM(A.BMDNO) $sql2 LIMIT 3 ";
  var result = await dbClient!.rawQuery(sql);
  List<Bil_Mov_D_Local> list = result.map((item) {
    return Bil_Mov_D_Local.fromMap(item);
  }).toList();
  return list;
}

Future<List<Acc_Gro_Local>> GET_ACC_GRO() async {
  var dbClient = await conn.database;
  String sql = '';
  String Wheresql = '';
  LoginController().BIID_ALL_V == '1'
      ? Wheresql = " AND BIID_L=${LoginController().BIID}"
      : Wheresql = '';

  sql = " SELECT AGID,AGNA  FROM ACC_GRO WHERE JTID_L=${LoginController().JTID} "
      " AND SYID_L=${LoginController().SYID} "
      " AND CIID_L=${LoginController().CIID} $Wheresql ORDER BY AGID ";
  var result = await dbClient!.rawQuery(sql);
  List<Acc_Gro_Local> list = result.map((item) {
    return Acc_Gro_Local.fromMap(item);
  }).toList();
  return list;
}

Future<List<Sys_Rep_Local>> GET_SYS_REP(String GETSRID) async {
  var dbClient = await conn.database;
  String sql = '';
  String Wheresql = '';
  LoginController().BIID_ALL_V == '1'
      ? Wheresql = " AND BIID_L=${LoginController().BIID}"
      : Wheresql = '';

  sql = " SELECT *  FROM SYS_REP WHERE SRID=$GETSRID "
      " AND JTID_L=${LoginController().JTID} AND SYID_L=${LoginController().SYID} "
      " AND CIID_L=${LoginController().CIID} $Wheresql  ";
  var result = await dbClient!.rawQuery(sql);
  List<Sys_Rep_Local> list = result.map((item) {
    return Sys_Rep_Local.fromMap(item);
  }).toList();
  return list;
}

Future<List<Bil_Cus_Local>> GET_BIL_CUS_REP(String GETBIID_F, String GETBIID_T) async {
  var dbClient = await conn.database;
  String sql;
  String Wheresql = '';
  LoginController().BIID_ALL_V == '1'
      ? Wheresql = " AND  A.BIID_L=${LoginController().BIID}"
      : Wheresql = '';

  sql =
  "SELECT BCID,CASE WHEN ${LoginController().LAN}=2 AND A.BCNE IS NOT NULL THEN A.BCNE ELSE A.BCNA END  BCNA_D "
      " FROM BIL_CUS A WHERE (A.BIID IS NULL OR (A.BIID>=$GETBIID_F AND A.BIID<=$GETBIID_T))  "
      " AND A.JTID_L=${LoginController().JTID} AND A.SYID_L=${LoginController().SYID} "
      " AND A.CIID_L='${LoginController().CIID}' $Wheresql "
      " ORDER BY A.BCID ";
  var result = await dbClient!.rawQuery(sql);
  List<Bil_Cus_Local> list = result.map((item) {
    return Bil_Cus_Local.fromMap(item);
  }).toList();
  return list;
}

Future<List<Bil_Imp_Local>> GET_BIL_IMP_REP() async {
  var dbClient = await conn.database;
  String sql;
  String Wheresql = '';
  LoginController().BIID_ALL_V == '1'
      ? Wheresql = " AND  A.BIID_L=${LoginController().BIID}"
      : Wheresql = '';

  sql =
  "SELECT BIID,CASE WHEN ${LoginController().LAN}=2 AND A.BINE IS NOT NULL THEN A.BINE ELSE A.BINA END  BINA_D "
      " FROM BIL_IMP A WHERE  A.JTID_L=${LoginController().JTID} AND A.SYID_L=${LoginController().SYID} "
      " AND A.CIID_L='${LoginController().CIID}' $Wheresql "
      " ORDER BY A.BIID ";
  var result = await dbClient!.rawQuery(sql);
  List<Bil_Imp_Local> list = result.map((item) {
    return Bil_Imp_Local.fromMap(item);
  }).toList();
  return list;
}

Future<List<Acc_Acc_Local>> GET_ACC_ACC_REP(String GETBIID_F, String GETBIID_T) async {
  var dbClient = await conn.database;
  String sql;
  String Wheresql = '';
  LoginController().BIID_ALL_V == '1'
      ? Wheresql = " AND  A.BIID_L=${LoginController().BIID}"
      : Wheresql = '';

  sql =
  "SELECT AANO,CASE WHEN ${LoginController().LAN}=2 AND A.AANE IS NOT NULL THEN A.AANE ELSE A.AANA END  AANA_D "
      " FROM ACC_ACC A WHERE (A.BIID IS NULL OR (A.BIID>=$GETBIID_F AND A.BIID<=$GETBIID_T))  "
      " AND A.JTID_L=${LoginController().JTID} AND A.SYID_L=${LoginController().SYID} "
      " AND A.CIID_L='${LoginController().CIID}' $Wheresql "
      " ORDER BY A.AANO ";
  var result = await dbClient!.rawQuery(sql);
  List<Acc_Acc_Local> list = result.map((item) {
    return Acc_Acc_Local.fromMap(item);
  }).toList();
  return list;
}

Future<List<Bil_Imp_T_Local>> GET_BIL_IMP_T() async {
  var dbClient = await conn.database;
  String sql;
  String Wheresql = '';
  LoginController().BIID_ALL_V == '1'
      ? Wheresql = " AND  A.BIID_L=${LoginController().BIID}"
      : Wheresql = '';
  sql =
  "SELECT A.BITID,CASE WHEN ${LoginController().LAN}=2 AND BITNE IS NOT NULL THEN BITNE ELSE BITNA END  BITNA_D"
      " FROM BIL_IMP_T A WHERE  A.JTID_L=${LoginController().JTID} "
      " AND A.SYID_L=${LoginController().SYID} AND A.CIID_L='${LoginController().CIID}' $Wheresql"
      " ORDER BY A.BITID";

  var result = await dbClient!.rawQuery(sql);
  List<Bil_Imp_T_Local> list = result.map((item) {
    return Bil_Imp_T_Local.fromMap(item);
  }).toList();
  return list;
}

Future<List<Sys_Lan_Local>> GET_SYS_LAN(String GETSLTY, String GETSLIT, String GETSLSC) async {
  var dbClient = await conn.database;
  String sql;
  String Wheresql = '';
  LoginController().BIID_ALL_V == '1'
      ? Wheresql = " AND  A.BIID_L=${LoginController().BIID}"
      : Wheresql = '';

  sql =
  "SELECT A.SLSC,CASE WHEN ${LoginController().LAN}=2 AND SLN2 IS NOT NULL THEN SLN2 ELSE SLN1 END  SLN_D"
      " FROM SYS_LAN A WHERE A.SLTY=$GETSLTY AND A.SLIT='$GETSLIT'   $GETSLSC AND A.JTID_L=${LoginController().JTID} "
      " AND A.SYID_L=${LoginController().SYID} AND A.CIID_L='${LoginController().CIID}' $Wheresql"
      " ORDER BY A.SLSC";

  var result = await dbClient!.rawQuery(sql);
  // print(sql);
  // print(result);
  // print('GET_SYS_LAN');
  List<Sys_Lan_Local> list = result.map((item) {
    return Sys_Lan_Local.fromMap(item);
  }).toList();
  return list;
}


Future<List<Acc_Mov_K_Local>> GET_ACC_MOV_K_REP() async {
  var dbClient = await conn.database;
  String sql;
  String Wheresql = '';
  LoginController().BIID_ALL_V == '1'
      ? Wheresql = " AND  BIID_L=${LoginController().BIID}"
      : Wheresql = '';

  sql =
  "SELECT  AMKID,CASE WHEN ${LoginController().LAN}=2 AND AMKNE IS NOT NULL THEN AMKNE ELSE AMKNA END  AMKNA_D"
      " FROM ACC_MOV_K  WHERE  JTID_L=${LoginController().JTID} "
      " AND SYID_L=${LoginController().SYID} AND CIID_L='${LoginController().CIID}' $Wheresql";
  var result = await dbClient!.rawQuery(sql);
  List<Acc_Mov_K_Local> list = result.map((item) {
    return Acc_Mov_K_Local.fromMap(item);
  }).toList();
  return list;
}

Future<List<Sys_Usr_Local>> GET_SYS_USR() async {
  var dbClient = await conn.database;
  String sql;
  String Wheresql = '';
  LoginController().BIID_ALL_V == '1'
      ? Wheresql = " AND  BIID_L=${LoginController().BIID}"
      : Wheresql = '';

  sql =
  "select SUID,CASE WHEN ${LoginController().LAN}=2 AND SUNE IS NOT NULL THEN SUNE ELSE SUNA END  SUNA_D"
      " FROM SYS_USR WHERE   JTID_L=${LoginController().JTID} "
      " AND SYID_L=${LoginController().SYID} AND CIID_L='${LoginController().CIID}' $Wheresql";
  var result = await dbClient!.rawQuery(sql);
  List<Sys_Usr_Local> list = result.map((item) {
    return Sys_Usr_Local.fromMap(item);
  }).toList();
  return list;
}

Future<List<Acc_Cas_Local>> GET_ACC_CAS_REP(String GETBIID) async {
  var dbClient = await conn.database;
  String sql;
  String Wheresql = '';
  String Wheresql2 = '';
  LoginController().BIID_ALL_V == '1'
      ? Wheresql = " AND A.BIID_L=${LoginController().BIID}"
      : Wheresql = '';
  LoginController().BIID_ALL_V == '1'
      ? Wheresql2 = " AND C.BIID_L=A.BIID_L"
      : Wheresql2 = '';

  sql =
  " SELECT A.ACID,CASE WHEN ${LoginController().LAN}=2 AND A.ACNE IS NOT NULL THEN A.ACNE ELSE A.ACNA END  ACNA_D"
      " FROM ACC_CAS A WHERE  A.JTID_L=${LoginController().JTID} AND A.SYID_L=${LoginController().SYID} "
      " AND A.CIID_L='${LoginController().CIID}' $Wheresql AND A.ACST!=2  AND(A.BIID IS NULL OR A.BIID=$GETBIID) "
      " AND  EXISTS(SELECT 1  FROM ACC_USR C WHERE C.AANO=A.AANO AND C.AUIN=1 AND C.SUID IS NOT NULL AND "
      " C.SUID='${LoginController().SUID}' AND ( C.CIID_L=A.CIID_L AND C.JTID_L=A.JTID_L AND C.SYID_L=A.SYID_L $Wheresql2)) "
      "  ORDER BY A.ACID ";

  var result = await dbClient!.rawQuery(sql);
  List<Acc_Cas_Local> list = result.map((item) {
    return Acc_Cas_Local.fromMap(item);
  }).toList();
  return list;
}

Future<List<Acc_Cos_Local>> GET_ACC_COS_ONE() async {
  var dbClient = await conn.database;
  String sql;
  String Wheresql = '';
  String Wheresql2 = '';
  LoginController().BIID_ALL_V == '1'
      ? Wheresql = " AND A.BIID_L=${LoginController().BIID}"
      : Wheresql = '';
  LoginController().BIID_ALL_V == '1'
      ? Wheresql2 = " AND D.BIID_L=${LoginController().BIID}"
      : Wheresql2 = '';

  sql =
  "SELECT A.ACNO,CASE WHEN ${LoginController().LAN}=2 AND A.ACNE IS NOT NULL THEN A.ACNE ELSE A.ACNA END  ACNA_D "
      " FROM ACC_COS A WHERE A.ACST=1 AND A.ACTY=2 AND A.JTID_L=${LoginController().JTID} "
      " AND A.SYID_L=${LoginController().SYID} AND A.CIID_L=${LoginController().CIID} $Wheresql "
      " AND  EXISTS(SELECT 1 FROM COS_USR D WHERE D.ACNO=A.ACNO AND D.CUOU=1 AND D.SUID='${LoginController().SUID}' "
      " AND D.JTID_L=${LoginController().JTID} AND D.SYID_L=${LoginController().SYID} "
      " AND D.CIID_L=${LoginController().CIID} $Wheresql2 ) ORDER BY A.ACNO LIMIT 1 ";
  final result = await dbClient!.rawQuery(sql);
  // print(result);
  // print('Acc_Cos_Local');
  return result.map((json) => Acc_Cos_Local.fromMap(json)).toList();
}

Future<List<Acc_Cas_Local>> GET_ACC_CAS_REP_ONE() async {
  var dbClient = await conn.database;
  String sql;
  String Wheresql = '';
  String Wheresql2 = '';
  LoginController().BIID_ALL_V == '1'
      ? Wheresql = " AND A.BIID_L=${LoginController().BIID}"
      : Wheresql = '';
  LoginController().BIID_ALL_V == '1'
      ? Wheresql2 = " AND C.BIID_L=A.BIID_L"
      : Wheresql2 = '';

  sql = sql = " SELECT A.ACID,CASE WHEN ${LoginController().LAN}=2 AND A.ACNE IS NOT NULL THEN A.ACNE ELSE A.ACNA END  ACNA_D"
      " FROM ACC_CAS A WHERE  A.JTID_L=${LoginController().JTID} AND A.SYID_L=${LoginController().SYID} "
      " AND A.CIID_L='${LoginController().CIID}' $Wheresql AND A.ACST!=2   AND "
      "    EXISTS(SELECT 1  FROM ACC_USR C WHERE C.AANO=A.AANO AND C.AUIN=1 AND C.SUID IS NOT NULL AND "
      " C.SUID='${LoginController().SUID}' AND ( C.CIID_L=A.CIID_L AND C.JTID_L=A.JTID_L AND C.SYID_L=A.SYID_L $Wheresql2)) "
      "  ORDER BY A.ACID LIMIT 1";
  var result = await dbClient!.rawQuery(sql);
  List<Acc_Cas_Local> list = result.map((item) {
    return Acc_Cas_Local.fromMap(item);
  }).toList();
  return list;
}

Future<List<Acc_Acc_Local>> GET_AKID(String GETAANO) async {
  var dbClient = await conn.database;
  String sql;
  String Wheresql = '';

  LoginController().BIID_ALL_V == '1'
      ? Wheresql = " AND  BIID_L=${LoginController().BIID}"
      : Wheresql = '';

  sql = " SELECT AKID,AACC FROM ACC_ACC WHERE AANO='$GETAANO' AND JTID_L=${LoginController().JTID} "
      " AND SYID_L=${LoginController().SYID} AND CIID_L=${LoginController().CIID} $Wheresql LIMIT 1 ";
  var result = await dbClient!.rawQuery(sql);
  List<Acc_Acc_Local> list = result.map((item) {
    return Acc_Acc_Local.fromMap(item);
  }).toList();
  return list;
}

Future<Fat_Snd_Log_Local> INSERT_FAT_SND_LOG({BMMGU, FCIGU, FISGU, FSLSIG, FSLCIE, FSLSTP, FSLST, FSLRT,
  MSG_ERR, FISST_N, SSID_N, FSLDRQ, FSLDRC, FSLDER, FSLDRS}) async {
  var dbClient = await conn.database;
  var uuid = const Uuid().v4();
  Fat_Snd_Log_Local FAT_SND_LOG_S = Fat_Snd_Log_Local(
    FSLGU: uuid,
    FSLTY: 'P',
    FCIGU: FCIGU,
    CIIDL: int.parse(LoginController().CIID.toString()),
    JTIDL: int.parse(LoginController().JTID.toString()),
    BIIDL: int.parse(LoginController().BIIDL_N.toString()),
    SYIDL: LoginController().SYID,
    SCHNA: LoginController().SCHEMA_V,
    BMMGU: BMMGU,
    FISGU: FISGU,
    FSLPT: 1,
    FSLJOB: 2,
    SSID: SSID_N,
    FSLSIG: FSLSIG,
    FSLCIE: FSLCIE,
    FSLSTP: FSLSTP,
    FSLST: FSLST,
    FSLRT: FSLRT,
    FSLMSG: MSG_ERR,
    FSLIS: FISST_N,
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
  FAT_SND_LOG_S.FSLSEQ = await dbClient!.insert('FAT_SND_LOG', FAT_SND_LOG_S.toMap());
  // print('FSLDRQ');
  // print(FSLDRQ.toString());
  if(FISST_N ==5 || FISST_N==3 ){
    if (FSLDRQ.toString().isNotEmpty && FSLDRQ.toString() != 'null') {
      await dbClient.execute(
          'INSERT INTO FAT_SND_LOG_D(FSLSEQ,FSLGU,FSLDRQ, FSLDRC,FSLDER, FSLDRS,JTID_L,BIID_L,SYID_L,CIID_L) values(?,?,?,?,?,?,?,?,?,?)',
          [
            FAT_SND_LOG_S.FSLSEQ,
            uuid,
            FSLDRQ.toString(),
            FSLDRC.toString(),
            FSLDER.toString(),
            FSLDRS.toString(),
            LoginController().JTID,
            LoginController().BIID,
            LoginController().SYID,
            LoginController().CIID
          ]);
      print('INSERT_FAT_SND_LOG_D');
    }
  }

  return FAT_SND_LOG_S;
}

Future<List<TYP_NAM>> GET_TYP_NAM(F_TY, VAL_V, VAL_V2) async {
  var dbClient = await conn.database;
  String sql = '';
  String Wheresql = '';
  var LAN_V = LoginController().LAN;
  LoginController().BIID_ALL_V == '1'
      ? Wheresql = " AND  BIID_L=${LoginController().BIID}"
      : Wheresql = '';

  if (F_TY == 'BAID' || F_TY == 'BIL_ARE' || F_TY == 'BA') {
    sql =
    "SELECT BAID AS ID_V,CASE WHEN $LAN_V=2 AND BANE IS NOT NULL THEN BANE ELSE BANA END  NAM_V"
        "  FROM BIL_ARE WHERE BAID=$VAL_V AND JTID_L=${LoginController().JTID} "
        " AND SYID_L=${LoginController().SYID} AND CIID_L=${LoginController().CIID} $Wheresql LIMIT 1 ";
  } else if (F_TY == 'CTID' || F_TY == 'COU_TOW' || F_TY == 'CT') {
    sql = "SELECT CTID AS ID_V,CASE WHEN $LAN_V=2 AND CTNE IS NOT NULL THEN CTNE ELSE CTNA END  NAM_V"
        "  FROM COU_TOW WHERE CWID=$VAL_V AND CTID=$VAL_V2 AND JTID_L=${LoginController().JTID} "
        " AND SYID_L=${LoginController().SYID} AND CIID_L=${LoginController().CIID} $Wheresql LIMIT 1 ";
  } else if (F_TY == 'CWWC2' || F_TY == 'COU_WRD2' || F_TY == 'CW2') {
    sql = "SELECT CWID AS ID_V,CWWC2 AS  NAM_V"
        "  FROM COU_WRD WHERE CWID=$VAL_V AND JTID_L=${LoginController().JTID} "
        " AND SYID_L=${LoginController().SYID} AND CIID_L=${LoginController().CIID} $Wheresql LIMIT 1 ";
  } else if (F_TY == 'TCSDID' || F_TY == 'TAX_COD_SYS_D') {
    sql =
    "SELECT TCSDID AS ID_V,CASE WHEN $LAN_V=2 AND TCSDNA IS NOT NULL THEN TCSDNE ELSE TCSDNE END  NAM_V"
        "  FROM TAX_COD_SYS_D WHERE TCSDID=$VAL_V AND JTID_L=${LoginController().JTID} "
        " AND SYID_L=${LoginController().SYID} AND CIID_L=${LoginController().CIID} $Wheresql LIMIT 1 ";
  } else if (F_TY == 'SCID' || F_TY == 'SYS_SCR') {
    sql = " SELECT SCID AS ID_V,CASE WHEN $LAN_V=2 AND SCNE IS NOT NULL THEN SCNE ELSE SCNA END  NAM_V"
        "  FROM SYS_CUR WHERE SCID=$VAL_V AND JTID_L=${LoginController().JTID} "
        " AND SYID_L=${LoginController().SYID} AND CIID_L=${LoginController().CIID} $Wheresql LIMIT 1 ";
  }

  var result = await dbClient!.rawQuery(sql);
  List<TYP_NAM> list = result.map((item) {
    return TYP_NAM.fromMap(item);
  }).toList();
  return list;
}

Future<void> INSERT_FAT_SND_LOG_D(FSLGU, FSLDRQ, FSLDRC, FSLDER, FSLDRS) async {
  var dbClient = await conn.database;
  await dbClient!.execute(
      'INSERT INTO FAT_SND_LOG_D(FSLGU,FSLDRQ, FSLDRC,FSLDER, FSLDRS,JTID_L,BIID_L,SYID_L,CIID_L) values(?,?,?,?,?,?,?,?)',
      [
        FSLDRQ,
        FSLDRC,
        FSLDER,
        FSLDRS,
        LoginController().JTID,
        LoginController().BIID,
        LoginController().SYID,
        LoginController().CIID
      ]);
}

Future<List<Sto_Mov_K_Local>> GET_STO_MOV_K_ST(int GETSMKID) async {
  var dbClient = await conn.database;
  String sql;
  String Wheresql = '';
  LoginController().BIID_ALL_V == '1'
      ? Wheresql = " AND  BIID_L=${LoginController().BIID}"
      : Wheresql = '';

  sql = "SELECT SMKST FROM STO_MOV_K WHERE SMKID=$GETSMKID "
      " AND JTID_L=${LoginController().JTID} "
      " AND SYID_L=${LoginController().SYID} AND CIID_L='${LoginController().CIID}' $Wheresql";
  var result = await dbClient!.rawQuery(sql);
  List<Sto_Mov_K_Local> list = result.map((item) {
    return Sto_Mov_K_Local.fromMap(item);
  }).toList();
  return list;
}

Future<List<Sto_Num_Local>> GET_SNNO_INVC(
    String GETBIID,
    int GETSIID,
    String StringMGNO,
    String StringMINO,
    String IntMUID,
    String USESMDED,
    String GETSMDED) async {
  var dbClient = await conn.database;
  String sql;
  String sql2 = '';
  String Wheresql = '';
  String Wheresql2 = '';
  LoginController().BIID_ALL_V == '1'
      ? Wheresql = " AND A.BIID_L=${LoginController().BIID}"
      : Wheresql = '';
  LoginController().BIID_ALL_V == '1'
      ? Wheresql2 = " AND B.BIID_L=${LoginController().BIID}"
      : Wheresql2 = '';
  // USESMDED == '1' || USESMDED == '3'?sql2=" AND A.SNED='$GETSMDED' ":sql2='';
  USESMDED == '1' ? sql2 = " AND A.SNED='$GETSMDED' " : sql2 = '';

  sql =
  "SELECT ifnull(SUM(A.SNNO-A.SNHO),0) AS SNNO,CASE WHEN ${LoginController().LAN}=2 AND B.MUNE IS NOT NULL THEN B.MUNE ELSE B.MUNA END  MUNA_D"
      "  FROM STO_NUM A,MAT_UNI B WHERE A.SIID=$GETSIID AND  A.MGNO='$StringMGNO' AND A.MINO='$StringMINO' "
      " AND A.MUID=$IntMUID $sql2 AND EXISTS (SELECT 1 FROM STO_INF C,STO_USR D WHERE C.SIID=D.SIID AND C.SIID=A.SIID AND D.SIID=A.SIID"
      " AND C.BIID IS NULL OR C.BIID=$GETBIID AND D.SUID IS NOT NULL"
      " AND D.SUID=${LoginController().SUID} AND (D.SUOU=1 OR D.SUIN=1 OR D.SUCH=1 OR D.SUAP=1))"
      " AND A.JTID_L=${LoginController().JTID} "
      " AND A.SYID_L=${LoginController().SYID} AND A.CIID_L=${LoginController().CIID} $Wheresql"
      " AND B.MUID=A.MUID AND B.JTID_L=${LoginController().JTID} "
      " AND B.SYID_L=${LoginController().SYID} AND B.CIID_L=${LoginController().CIID} $Wheresql2";
  var result = await dbClient!.rawQuery(sql);
  List<Sto_Num_Local> list = result.map((item) {
    return Sto_Num_Local.fromMap(item);
  }).toList();
  return list;
}

Future<List<Mat_Pri_Local>> GET_MPCO(int GETBIID, String GETMGNO, String GETMINO, GETMUID, int GETSCID) async {
  var dbClient = await conn.database;
  String sql;
  String Wheresql = '';
  LoginController().BIID_ALL_V == '1'
      ? Wheresql = " AND  BIID_L=${LoginController().BIID}"
      : Wheresql = '';

  sql =
  " SELECT * FROM MAT_PRI WHERE BIID=$GETBIID AND MGNO='$GETMGNO' AND MINO='$GETMINO' AND MUID=$GETMUID "
      " AND SCID=$GETSCID AND JTID_L=${LoginController().JTID} "
      " AND SYID_L=${LoginController().SYID} AND CIID_L=${LoginController().CIID} $Wheresql"
      " ORDER BY BIID  LIMIT 1";

  var result = await dbClient!.rawQuery(sql);
  // print(sql);
  // print(result);
  // print('GET_MPCO');
  List<Mat_Pri_Local> list = result.map((item) {
    return Mat_Pri_Local.fromMap(item);
  }).toList();
  return list;
}


Future<int> Get_CustomerData_Check() async {
  var dbClient = await conn.database;
  String sql2;
  int Count_Rec = 0;
  sql2 = "SELECT  COUNT(*) FROM BIL_CUS WHERE SYST_L!=1 AND JTID_L=${LoginController().JTID} AND SYID_L=${LoginController().SYID} "
      " AND CIID_L=${LoginController().CIID} $SQLBIID";
  var x = await dbClient!.rawQuery(sql2);
  Count_Rec = Sqflite.firstIntValue(x)!;
  // print('Count_Check ${sql2} = ${Count_Rec}');
  return Count_Rec;
}

UpdateDataGUID(String GetTableName) async {
  var dbClient = await conn.database;
  String SQL;

  String SQL2 =
      "UPDATE $GetTableName SET (AANO,BCID,BMMNA) = (SELECT B.AANO,B.BCID,B.BCNA  "
      " FROM BIL_CUS B WHERE B.GUID = $GetTableName.AANO) WHERE $GetTableName.AANO IS NOT NULL"
      " AND LENGTH($GetTableName.AANO)>30 AND  $GetTableName.BMKID IN(3,4,5,6,7,10,11,12) "
      " AND EXISTS (SELECT 1  FROM BIL_CUS C  WHERE C.GUID = $GetTableName.AANO)";

  String SQL3 =
      " UPDATE $GetTableName SET (AANO,BCID,BMMNA) = (SELECT B.AANO,B.BCID,B.BCNA"
      " FROM BIL_CUS B WHERE B.GUID = $GetTableName.GUIDC)"
      " WHERE $GetTableName.AANO IS NULL AND  $GetTableName.BMKID IN(3,4,5,6,7,10,11,12)  "
      " AND $GetTableName.GUIDC IS NOT NULL AND EXISTS (SELECT 1  FROM BIL_CUS C  WHERE C.GUID = $GetTableName.GUIDC)";

  String SQL4 = "select biid from bra_inf where biid=0";

  SQL =
  "UPDATE $GetTableName SET AANO = (SELECT B.AANO FROM BIL_CUS B WHERE B.GUID = $GetTableName.AANO) "
      " WHERE  $GetTableName.AANO IS NOT NULL AND LENGTH($GetTableName.AANO)>30 "
      " and EXISTS (SELECT 1  FROM BIL_CUS C  WHERE C.GUID = $GetTableName.AANO)";

  final res = await dbClient!.rawUpdate(
      GetTableName == 'BIL_MOV_M' || GetTableName == 'BIF_MOV_M' ? SQL2 : SQL);
  final res2 = await dbClient!.rawUpdate(
      GetTableName == 'BIL_MOV_M' || GetTableName == 'BIF_MOV_M' ? SQL3 : SQL4);
  // print(
  //     'UpdateDataByGUID ${GetTableName == 'BIL_MOV_M' || GetTableName == 'BIF_MOV_M' ? SQL2 : SQL} : ${res}');
  return res;
}

Future<List<Acc_Acc_Local>> Query_Acc_Acc_P(String GETBIID) async {
  var dbClient = await conn.database;
  String sql;
  String Wheresql = '';
  String Wheresql2 = '';
  String Wheresql3 = '';
  LoginController().BIID_ALL_V == '1' ? Wheresql = " AND A.BIID_L=${LoginController().BIID}" : Wheresql = '';
  LoginController().BIID_ALL_V == '1' ? Wheresql2 = " AND U.BIID_L=${LoginController().BIID}" : Wheresql = '';
  LoginController().BIID_ALL_V == '1' ? Wheresql3 = " AND P.BIID_L=${LoginController().BIID}" : Wheresql3 = '';

  sql = " SELECT A.*,CASE WHEN ${LoginController().LAN}=2 AND A.AANE IS NOT NULL THEN A.AANE ELSE A.AANA END  AANA_D"
      " FROM ACC_ACC A,ACC_USR U WHERE (U.AANO=A.AANO) AND A.AAST!=2 AND A.AATY=2  "
      " AND U.AUIN=1 AND (U.SUID IS NOT NULL AND U.SUID=${LoginController().SUID})"
      " AND A.JTID_L=${LoginController().JTID} AND A.SYID_L=${LoginController().SYID} AND A.CIID_L=${LoginController().CIID} $Wheresql"
      " AND ( A.JTID_L=U.JTID_L AND A.SYID_L=U.SYID_L AND A.CIID_L=U.CIID_L $Wheresql2)"
      " AND (A.AASE=1 OR EXISTS (SELECT 1 FROM USR_PRI P WHERE P.SUID=${LoginController().SUID}  "
      " AND ((P.PRID=52 AND A.AASE=2) OR (P.PRID=53 AND A.AASE=3)) "
      " AND (A.JTID_L=P.JTID_L AND A.SYID_L=P.SYID_L AND A.CIID_L=P.CIID_L $Wheresql3) )) "
      " ORDER BY A.AANO";
  final result = await dbClient!.rawQuery(sql);

  return result.map((json) => Acc_Acc_Local.fromMap(json)).toList();
}

Future<List<Mat_Gro_Local>> GET_MAT_GRO() async {
  var dbClient = await conn.database;
  String sql;
  String Wheresql='';
  String Wheresql2='';
  String Wheresql3='';
  LoginController().BIID_ALL_V=='1'? Wheresql= " AND A.BIID_L=${LoginController().BIID}":Wheresql='';
  LoginController().BIID_ALL_V=='1'? Wheresql2= " AND B.BIID_L=${LoginController().BIID}":Wheresql='';
  LoginController().BIID_ALL_V=='1'? Wheresql3= " AND C.BIID_L=${LoginController().BIID}":Wheresql3='';

  sql ="SELECT *,CASE WHEN ${LoginController().LAN}=2 AND A.MGNE IS NOT NULL THEN A.MGNE ELSE A.MGNA END  MGNA_D"
      " FROM MAT_GRO A WHERE A.MGST NOT IN(2,3,5) AND A.MGTY=2 "
      " AND A.JTID_L=${LoginController().JTID} "
      " AND A.SYID_L=${LoginController().SYID} AND A.CIID_L=${LoginController().CIID} $Wheresql"
      " AND EXISTS(SELECT 1 FROM GRO_USR B WHERE B.MGNO=A.MGNO AND  B.GUOU=1 AND B.SUID=${LoginController().SUID}"
      " AND B.JTID_L=${LoginController().JTID} "
      " AND B.SYID_L=${LoginController().SYID} AND B.CIID_L=${LoginController().CIID} $Wheresql2)"
      "  AND EXISTS(SELECT 1 FROM MAT_INF C WHERE C.MGNO=A.MGNO"
      " AND C.JTID_L=${LoginController().JTID} "
      " AND C.SYID_L=${LoginController().SYID} AND C.CIID_L=${LoginController().CIID} $Wheresql3) ORDER BY A.MGNO";
  final result = await dbClient!.rawQuery(sql);
  return result.map((json) => Mat_Gro_Local.fromMap(json)).toList();
}

Future<int> UpdateMOB_VAR(int ColmunID, GETColmunValue) async {
  var dbClient = await conn.database;

  // تحضير المتغيرات لتجنب حقن SQL
  String Wheresql = '';
  if (LoginController().BIID_ALL_V == '1') {
    Wheresql = " AND BIID_L=${LoginController().BIID}";
  }

  // تنسيق التاريخ بشكل صحيح
  String formattedDate = DateFormat('dd-MM-yyyy HH:mm').format(DateTime.now());

  // الاستعلام باستخدام prepared statements
  String SQL = """
    UPDATE MOB_VAR 
    SET MVVL = ?, DATEU = ? 
    WHERE MVID = ? 
    AND JTID_L = ? 
    AND SYID_L = ? 
    AND CIID_L = ? $Wheresql
  """;

  // تنفيذ الاستعلام مع المعاملات المحمية
  var result = await dbClient!.rawUpdate(
      SQL,
      [GETColmunValue, formattedDate, ColmunID, LoginController().JTID, LoginController().SYID, LoginController().CIID]
  );

  return result; // يمكنك إرجاع نتيجة الاستعلام (عدد الصفوف المتأثرة)
}


Future UpdateMOB_VAR_CONFIG() async {
  var dbClient = await conn.database;;
  String SQL='';
  SQL = "UPDATE MOB_VAR SET JTID_L=${LoginController().JTID},SYID_L=${LoginController().SYID}"
      ",CIID_L=${LoginController().CIID},BIID_L=${LoginController().BIID}"
      " where JTID_L=-1 AND SYID_L=-1 AND CIID_L=-1";
  var result = await dbClient!.rawUpdate(SQL);
  return result;
}

//تعديل القيم عند فتح سنه جديده
Future UpdateMOB_VAR_SYID(int GRTSYID) async {
  var dbClient = await conn.database;;
  String SQL='';
  SQL =" UPDATE MOB_VAR SET SYID_L=$GRTSYID "
      "where JTID_L=${LoginController().JTID} AND SYID_L=${LoginController().SYID} "
      " AND CIID_L=${LoginController().CIID} $SQLBIID";
  var result = await dbClient!.rawUpdate(SQL);
  return result;
}

Future<List<Mob_Var_Local>> GETMOB_VAR(GETMVID) async {
  var dbClient = await conn.database;
  String SQL='';

  SQL = "SELECT  ifnull(MVVL,MVVLS) AS MVVL FROM MOB_VAR WHERE MVID=$GETMVID ";

  // إذا كانت النتيجة تحتوي على صفوف، أعد القيمة الأولى
  var result = await dbClient!.rawQuery(SQL);
  List<Mob_Var_Local> list = result.map((item) {
    return Mob_Var_Local.fromMap(item);
  }).toList();
  return list;
}


//لة لتنفيذ الاستعلام مع المتغيرات
Future<int> GET_CON_ACC_M( {
  String? STMID,
  String? CIID,
  String? JTID,
  String? BIID,
  String? SUID,
  String? SOMSN,
  String? SOMID,
}) async {
  var dbClient = await conn.database;

  var sql ='''
      SELECT IFNULL(COUNT(1), 0) AS ACT  FROM CON_ACC_M  WHERE STMID = '$STMID'
      AND CIID = $CIID AND JTID = $JTID AND BIID = $BIID AND CAMTY IN (0, 1, 2) 
      AND ((CAMTY = 0 AND UPPER(IFNULL(CAMUS, '#')) = UPPER(IFNULL('$SUID', '#')) 
      AND (UPPER(IFNULL(SOMSN, '#')) = UPPER('$SOMSN') OR IFNULL(SOMID, 0) = $SOMID))
      OR (CAMTY = 1 AND UPPER(IFNULL(CAMUS, '#')) = UPPER(IFNULL('$SUID', '#')))
      OR (CAMTY = 2 AND (UPPER(IFNULL(SOMSN, '#')) = UPPER('$SOMSN') OR IFNULL(SOMID, 0) = $SOMID))
      )
    ''';

  var result = await dbClient!.rawQuery(sql);
  return result.isNotEmpty ? result.first.values.first as int : 0;
}

Future<List<Syn_Set_Local>> GET_SYN_SET() async {
  var dbClient = await conn.database;
  String SQL;
  String SQLBIID_L = LoginController().BIID_ALL_V == '1'
      ? " AND  BIID_L=${LoginController().BIID}" :  '';

  SQL =" SELECT  * FROM SYN_SET WHERE STMID='EWA2' AND JTID_L=${LoginController().JTID} "
      " AND SYID_L=${LoginController().SYID} AND CIID_L=${LoginController().CIID} $SQLBIID_L LIMIT 1";

  // إذا كانت النتيجة تحتوي على صفوف، أعد القيمة الأولى
  var result = await dbClient!.rawQuery(SQL);
  List<Syn_Set_Local> list = result.map((item) {
    return Syn_Set_Local.fromMap(item);
  }).toList();
  return list;
}

Future<List<Syn_Off_M2_Local>> GET_SYN_OFF_M2() async {
  var dbClient = await conn.database;
  String SQL;
  String SQLBIID_L = LoginController().BIID_ALL_V == '1'
      ? " AND  BIID_L=${LoginController().BIID}" :  '';

  SQL =" SELECT  * FROM SYN_OFF_M2 WHERE STMID='EWA' AND JTID_L=${LoginController().JTID} "
      " AND SYID_L=${LoginController().SYID} AND CIID_L=${LoginController().CIID} $SQLBIID_L LIMIT 1";

  // إذا كانت النتيجة تحتوي على صفوف، أعد القيمة الأولى
  var result = await dbClient!.rawQuery(SQL);
  List<Syn_Off_M2_Local> list = result.map((item) {
    return Syn_Off_M2_Local.fromMap(item);
  }).toList();
  return list;
}

Future<List<Syn_Off_M_Local>> GET_SYN_OFF_M() async {
  var dbClient = await conn.database;
  String SQL;
  String SQLBIID_L = LoginController().BIID_ALL_V == '1'
      ? " AND  BIID_L=${LoginController().BIID}" :  '';

  SQL =''' SELECT  * FROM SYN_OFF_M WHERE STMID='EWA' AND JTID_L=${LoginController().JTID} "
       AND SYID_L=${LoginController().SYID} AND CIID_L=${LoginController().CIID} $SQLBIID_L LIMIT 1''';

  // إذا كانت النتيجة تحتوي على صفوف، أعد القيمة الأولى
  var result = await dbClient!.rawQuery(SQL);
  List<Syn_Off_M_Local> list = result.map((item) {
    return Syn_Off_M_Local.fromMap(item);
  }).toList();
  return list;
}

Future<List<Eco_Var_Local>> GET_ECO_VAR(String GETSVID) async {
  var dbClient = await conn.database;
  String sql = '';
  String SQLBIID_L = LoginController().BIID_ALL_V == '1'
      ? " AND  BIID_L=${LoginController().BIID}" :  '';

  sql = '''SELECT  *  FROM ECO_VAR WHERE  SVID=$GETSVID AND JTID_L=${LoginController().JTID} 
  AND SYID_L=${LoginController().SYID} AND CIID_L=${LoginController().CIID} $SQLBIID_L LIMIT 1 ''';
  var result = await dbClient!.rawQuery(sql);
  // print(sql);
  // print(result);
  // print('GET_ECO_VAR');
  List<Eco_Var_Local> list = result.map((item) {
    return Eco_Var_Local.fromMap(item);
  }).toList();
  return list;
}

Future<List<Eco_Acc_Local>> GET_ECO_ACC(String GETECID) async {
  var dbClient = await conn.database;
  String sql = '';
  String SQLBIID_L = LoginController().BIID_ALL_V == '1'
      ? " AND  BIID_L=${LoginController().BIID}" :  '';
  sql = '''SELECT * FROM ECO_ACC WHERE AANO= '$GETECID' AND EAST=1  AND JTID_L=${LoginController().JTID} 
  AND SYID_L=${LoginController().SYID} AND CIID_L=${LoginController().CIID} $SQLBIID_L LIMIT 1 ''';
  var result = await dbClient!.rawQuery(sql);
  List<Eco_Acc_Local> list = result.map((item) {
    return Eco_Acc_Local.fromMap(item);
  }).toList();
  return list;
}

// دالة استرجاع البيانات من قاعدة البيانات
Future<List<Bil_Mov_M_Local>> getTopClients(TYPE,SCID,String GETDATE_F, String GETDATE_T) async {
  var dbClient = await conn.database; // الحصول على اتصال قاعدة البيانات
  String SQLBIID_L = LoginController().BIID_ALL_V == '1'
      ? " AND  A.BIID_L=${LoginController().BIID}" :  '';
  String sql2='';
  TYPE=='2'?sql2='A.BMKID IN(4,12)':sql2='A.BMKID IN(3,11,5)';
  String sql = '''
  SELECT A.AANO,A.BCID,A.BMMNA,SUM(A.BMMMT) AS BMMMT
    FROM BIL_MOV_M A WHERE $sql2 AND A.SCID=$SCID AND A.BMMDOR BETWEEN '$GETDATE_F' 
    AND '$GETDATE_T' AND A.JTID_L=${LoginController().JTID} 
    AND A.SYID_L=${LoginController().SYID} AND A.CIID_L=${LoginController().CIID} $SQLBIID_L
    GROUP BY A.BCID, A.BMMNA
    UNION ALL 
    SELECT A.AANO,A.BCID,A.BMMNA,SUM(A.BMMMT) AS BMMMT
    FROM BIF_MOV_M A WHERE $sql2 AND A.SCID=$SCID AND A.BMMDOR BETWEEN '$GETDATE_F' 
    AND '$GETDATE_T' AND A.JTID_L=${LoginController().JTID} 
    AND A.SYID_L=${LoginController().SYID} AND A.CIID_L=${LoginController().CIID} $SQLBIID_L
    GROUP BY A.BCID, A.BMMNA
    ORDER BY BMMMT DESC
    LIMIT 10
  ''';
  var result = await dbClient!.rawQuery(sql);
  return result.map((item) => Bil_Mov_M_Local.fromMap(item)).toList();
}

Future<List<Bil_Mov_M_Local>> getTopSuppliers(SCID,String GETDATE_F, String GETDATE_T) async {
  var dbClient = await conn.database; // الحصول على اتصال قاعدة البيانات
  String SQLBIID_L = LoginController().BIID_ALL_V == '1'
      ? " AND  A.BIID_L=${LoginController().BIID}" :  '';
  String sql = '''
  SELECT A.BIID, A.BMMNA, SUM(A.BMMMT) AS BMMMT
    FROM BIL_MOV_M A WHERE A.BMKID IN(1) AND A.SCID=$SCID AND A.BMMDOR BETWEEN '$GETDATE_F' 
    AND '$GETDATE_T' AND A.JTID_L=${LoginController().JTID} 
    AND A.SYID_L=${LoginController().SYID} AND A.CIID_L=${LoginController().CIID} $SQLBIID_L
    GROUP BY A.BIID, A.BMMNA
    UNION ALL
    SELECT A.BIID, A.BMMNA, SUM(A.BMMMT) AS BMMMT
    FROM BIF_MOV_M A WHERE A.BMKID IN(1) AND A.SCID=$SCID AND A.BMMDOR BETWEEN '$GETDATE_F' 
    AND '$GETDATE_T' AND A.JTID_L=${LoginController().JTID} 
    AND A.SYID_L=${LoginController().SYID} AND A.CIID_L=${LoginController().CIID} $SQLBIID_L
    GROUP BY A.BIID, A.BMMNA
    ORDER BY BMMMT DESC
    LIMIT 10
  ''';
  var result = await dbClient!.rawQuery(sql);
  return result.map((item) => Bil_Mov_M_Local.fromMap(item)).toList();
}

Future<List<Bil_Mov_M_Local>> GET_SUM_PAY_BIL_MOV(SCID,String GETDATE_F, String GETDATE_T) async {
  var dbClient = await conn.database;
  String sql = '';
  String Wheresql = '';

  LoginController().BIID_ALL_V == '1'
      ? Wheresql = " AND A.BIID_L=${LoginController().BIID}"
      : Wheresql = '';
  String SQLBIID_L2 = LoginController().BIID_ALL_V == '1'
      ? " AND A.BIID_L = B.BIID_L " :  '';

  sql=''' SELECT ifnull(SUM(BMMMT),0.0) AS BMMMT,A.BMKID,A.PKID,A.JTID_L,A.SYID_L,A.CIID_L,A.BIID_L,
   CASE WHEN ${LoginController().LAN}=2 AND B.PKNE IS NOT NULL THEN B.PKNE ELSE B.PKNA END  PKNA_D
   FROM BIL_MOV_M A JOIN PAY_KIN B ON A.PKID = B.PKID AND A.JTID_L = B.JTID_L AND A.SYID_L = B.SYID_L
   AND A.CIID_L = B.CIID_L $SQLBIID_L2 WHERE  A.BMKID IN (3, 5)  AND A.SCID=$SCID AND A.BMMDOR BETWEEN '$GETDATE_F' 
   AND '$GETDATE_T' AND A.JTID_L=${LoginController().JTID} 
   AND A.SYID_L=${LoginController().SYID} AND A.CIID_L=${LoginController().CIID} $Wheresql
   GROUP BY A.PKID 
   UNION ALL
   SELECT ifnull(SUM(BMMMT),0.0) AS BMMMT,A.BMKID,A.PKID,A.JTID_L,A.SYID_L,A.CIID_L,A.BIID_L,
   CASE WHEN ${LoginController().LAN}=2 AND B.PKNE IS NOT NULL THEN B.PKNE ELSE B.PKNA END  PKNA_D
   FROM BIF_MOV_M A JOIN PAY_KIN B ON A.PKID = B.PKID AND A.JTID_L = B.JTID_L AND A.SYID_L = B.SYID_L
   AND A.CIID_L = B.CIID_L $SQLBIID_L2 WHERE  A.BMKID IN (11)   AND A.SCID=$SCID AND  A.BMMDOR BETWEEN '$GETDATE_F' 
   AND '$GETDATE_T' AND A.JTID_L=${LoginController().JTID} 
   AND A.SYID_L=${LoginController().SYID} AND A.CIID_L=${LoginController().CIID} $Wheresql
   GROUP BY A.PKID 
    ''';

  var result = await dbClient!.rawQuery(sql);
  // print(sql);
  // print(result);
  // print('GET_SUM_PAY_BIL_MOV');
  List<Bil_Mov_M_Local> list = result.map((item) {
    return Bil_Mov_M_Local.fromMap(item);
  }).toList();
  return list;
}

Future<List<Bil_Mov_D_Local>> getTopItem(TYPE,SCID,String GETDATE_F, String GETDATE_T) async {
  var dbClient = await conn.database; // الحصول على اتصال قاعدة البيانات
  String SQLBIID_L = LoginController().BIID_ALL_V == '1'
      ? " AND  A.BIID_L=${LoginController().BIID}" :  '';
  String BIID_F = LoginController().BIID_ALL_V == '1'
      ? " AND  B.BIID_L=A.BIID_L " :  '';
  String sql2='';
  TYPE=='2'?sql2='A.BMKID IN(4,12)':sql2='A.BMKID IN(3,11,5)';
  String sql = '''
    SELECT A.MGNO,A.MINO,SUM(((A.BMDAM-A.BMDDI) * A.BMDNO ) + A.BMDTXT1) AS BMDAMT,
    SUM(A.BMDNO+A.BMDNF) AS BMDNO,
    CASE WHEN ${LoginController().LAN}=2 AND E.MINE IS NOT NULL  THEN E.MINE ELSE E.MINA END  MINA_D
    FROM BIL_MOV_D A JOIN MAT_INF E ON A.MGNO = E.MGNO AND A.MINO = E.MINO WHERE A.BMDAM>0 
    AND $sql2 AND A.JTID_L=${LoginController().JTID} 
    AND A.SYID_L=${LoginController().SYID} AND A.CIID_L=${LoginController().CIID} $SQLBIID_L
    AND EXISTS(SELECT 1 FROM BIL_MOV_M B
    WHERE B.BMMID=A.BMMID AND B.SCID=$SCID AND B.BMMDOR BETWEEN '$GETDATE_F' AND '$GETDATE_T' AND 
    B.JTID_L=A.JTID_L AND B.SYID_L=A.SYID_L AND B.CIID_L=A.CIID_L $BIID_F)
    GROUP BY A.MGNO, A.MINO
    UNION ALL
    SELECT A.MGNO,A.MINO,SUM(((A.BMDAM-A.BMDDI) * A.BMDNO ) + A.BMDTXT1) AS BMDAMT,
    SUM(A.BMDNO+A.BMDNF) AS BMDNO,
    CASE WHEN ${LoginController().LAN}=2 AND E.MINE IS NOT NULL  THEN E.MINE ELSE E.MINA END  MINA_D
    FROM BIF_MOV_D A JOIN MAT_INF E ON A.MGNO = E.MGNO AND A.MINO = E.MINO WHERE A.BMDAM>0 
    AND $sql2 AND A.JTID_L=${LoginController().JTID} 
    AND A.SYID_L=${LoginController().SYID} AND A.CIID_L=${LoginController().CIID} $SQLBIID_L
     AND EXISTS(SELECT 1 FROM BIF_MOV_M B
    WHERE B.BMMID=A.BMMID AND B.SCID=$SCID AND B.BMMDOR BETWEEN '$GETDATE_F' AND '$GETDATE_T' AND 
    B.JTID_L=A.JTID_L AND B.SYID_L=A.SYID_L AND B.CIID_L=A.CIID_L $BIID_F)
    GROUP BY A.MGNO, A.MINO
    ORDER BY BMDAMT DESC
    LIMIT 10
  ''';
  var result = await dbClient!.rawQuery(sql);
  return result.map((item) => Bil_Mov_D_Local.fromMap(item)).toList();
}

Future<List<Bil_Mov_M_Local>> getMonthlySales(SCID,String GETDATE_F, String GETDATE_T) async {
  var dbClient = await conn.database; // الحصول على اتصال قاعدة البيانات
  String SQLBIID_L = LoginController().BIID_ALL_V == '1'
      ? " AND  A.BIID_L=${LoginController().BIID}" :  '';

  String sql = '''
  SELECT  substr(A.BMMDO, 7, 4) || '-' || substr(A.BMMDO, 4, 2) AS BMMDO,
  SUM(CASE WHEN BMKID IN (3,5,11) THEN A.BMMMT ELSE 0.0 END) - 
  SUM(CASE WHEN BMKID IN (4,12) THEN A.BMMMT ELSE 0.0 END)  AS BMMMT
  FROM BIL_MOV_M A WHERE A.SCID=$SCID 
  AND A.JTID_L=${LoginController().JTID} 
  AND A.SYID_L=${LoginController().SYID} AND A.CIID_L=${LoginController().CIID} $SQLBIID_L
  AND A.BMMDO IS NOT NULL 
  GROUP BY substr(A.BMMDO, 7, 4), substr(A.BMMDO, 4, 2)
  UNION ALL
  SELECT  substr(A.BMMDO, 7, 4) || '-' || substr(A.BMMDO, 4, 2) AS BMMDO,
  SUM(CASE WHEN BMKID IN (3,5,11) THEN A.BMMMT ELSE 0.0 END) - 
  SUM(CASE WHEN BMKID IN (4,12) THEN A.BMMMT ELSE 0.0 END)  AS BMMMT
  FROM BIF_MOV_M A WHERE A.SCID=$SCID 
  AND A.JTID_L=${LoginController().JTID} 
  AND A.SYID_L=${LoginController().SYID} AND A.CIID_L=${LoginController().CIID} $SQLBIID_L
  AND A.BMMDO IS NOT NULL  
  GROUP BY substr(A.BMMDO, 7, 4), substr(A.BMMDO, 4, 2)
  ''';

  var result = await dbClient!.rawQuery(sql);
  // print('getMonthlySales $result');
  return result.map((item) => Bil_Mov_M_Local.fromMap(item)).toList();
}

Future<List<Bil_Mov_M_Local>> getBil(type,SCID,String GETDATE_F, String GETDATE_T) async {
  var dbClient = await conn.database; // الحصول على اتصال قاعدة البيانات
  String sql='';
  String Where='';
  String BIID_F= LoginController().BIID_ALL_V == '1'
      ? " AND  B.BIID_L=A.BIID_L " :  '';
  String SQLBIID_L = LoginController().BIID_ALL_V == '1'
      ? " AND  A.BIID_L=${LoginController().BIID}" :  '';
  String SQLBIID_L2 = LoginController().BIID_ALL_V == '1'
      ? " AND A.BIID_L = B.BIID_L " :  '';
  String SQL2 = ''' AND A.JTID_L=${LoginController().JTID} AND A.SYID_L=${LoginController().SYID} 
                  AND A.CIID_L=${LoginController().CIID} $SQLBIID_L''';
  Where=" AND A.SCID=$SCID AND A.BMMDOR BETWEEN '$GETDATE_F' AND '$GETDATE_T' ";

  if(type=='1'){
    sql = '''
    SELECT A.BIID2,SUM(CASE WHEN A.BMKID IN (3, 5, 11) THEN A.BMMMT ELSE 0.0 END) AS BMMMT,
    SUM(CASE WHEN A.BMKID IN (4, 12) THEN A.BMMMT ELSE 0.0 END) AS BMMAM,
    SUM(CASE WHEN BMKID IN (3,5,11) THEN BMMMT ELSE 0 END) - 
    SUM(CASE WHEN BMKID IN (4,12) THEN BMMMT ELSE 0 END) AS NET,
    CASE WHEN ${LoginController().LAN}=2 AND B.BINE IS NOT NULL THEN B.BINE ELSE B.BINA END  BINA_D 
    FROM BIL_MOV_M A JOIN BRA_INF B ON A.BIID2 = B.BIID AND A.JTID_L = B.JTID_L AND A.SYID_L = B.SYID_L
    AND A.CIID_L = B.CIID_L $SQLBIID_L2 WHERE A.BMKID IN(3, 4, 5, 11, 12) $Where $SQL2
    GROUP BY A.BIID2
    UNION ALL
    SELECT A.BIID2,SUM(CASE WHEN A.BMKID IN (3, 5, 11) THEN A.BMMMT ELSE 0.0 END) AS BMMMT,
    SUM(CASE WHEN A.BMKID IN (4, 12) THEN A.BMMMT ELSE 0.0 END) AS BMMAM,
    SUM(CASE WHEN BMKID IN (3,5,11) THEN BMMMT ELSE 0 END) - 
    SUM(CASE WHEN BMKID IN (4,12) THEN BMMMT ELSE 0 END) AS NET,
    CASE WHEN ${LoginController().LAN}=2 AND B.BINE IS NOT NULL THEN B.BINE ELSE B.BINA END  BINA_D 
    FROM BIF_MOV_M A JOIN BRA_INF B ON A.BIID2 = B.BIID AND A.JTID_L = B.JTID_L AND A.SYID_L = B.SYID_L
    AND A.CIID_L = B.CIID_L $SQLBIID_L2 WHERE A.BMKID IN(3, 4, 5, 11, 12) $Where $SQL2
    GROUP BY A.BIID2
    ORDER BY BMMMT DESC
  ''';
  }else if(type=='2'){
    sql = '''
    SELECT A.MGNO,SUM(CASE WHEN A.BMKID IN (3, 5) THEN (((A.BMDAM-A.BMDDI) * A.BMDNO ) + A.BMDTXT1)
    ELSE 0.0 END) AS BMMMT,
    SUM(CASE WHEN A.BMKID IN (4) THEN (((A.BMDAM-A.BMDDI) * A.BMDNO ) + A.BMDTXT1) ELSE 0.0 END) AS BMMAM,
    CASE WHEN ${LoginController().LAN}=2 AND B.MGNA IS NOT NULL THEN B.MGNE ELSE B.MGNA END  BINA_D 
    FROM BIL_MOV_D A JOIN MAT_GRO B ON A.MGNO = B.MGNO AND A.JTID_L = B.JTID_L AND A.SYID_L = B.SYID_L
    AND A.CIID_L = B.CIID_L $SQLBIID_L2 WHERE A.BMKID IN(3, 4, 5) AND EXISTS(SELECT 1 FROM BIL_MOV_M B
    WHERE B.BMMID=A.BMMID AND B.SCID=$SCID AND B.BMMDOR BETWEEN '$GETDATE_F' AND '$GETDATE_T' AND 
    B.JTID_L=A.JTID_L AND B.SYID_L=A.SYID_L AND B.CIID_L=A.CIID_L $BIID_F) $SQL2
    GROUP BY A.MGNO
    UNION ALL
    SELECT A.MGNO,SUM(CASE WHEN A.BMKID IN (11) THEN (((A.BMDAM-A.BMDDI) * A.BMDNO ) + A.BMDTXT1)
    ELSE 0.0 END) AS BMMMT,
    SUM(CASE WHEN A.BMKID IN (12) THEN (((A.BMDAM-A.BMDDI) * A.BMDNO ) + A.BMDTXT1) ELSE 0.0 END) AS BMMAM,
    CASE WHEN ${LoginController().LAN}=2 AND B.MGNA IS NOT NULL THEN B.MGNE ELSE B.MGNA END  BINA_D 
    FROM BIF_MOV_D A JOIN MAT_GRO B ON A.MGNO = B.MGNO AND A.JTID_L = B.JTID_L AND A.SYID_L = B.SYID_L
    AND A.CIID_L = B.CIID_L $SQLBIID_L2 WHERE A.BMKID IN(11, 12) AND EXISTS(SELECT 1 FROM BIF_MOV_M B
    WHERE B.BMMID=A.BMMID AND B.SCID=$SCID AND B.BMMDOR BETWEEN '$GETDATE_F' AND '$GETDATE_T' AND 
    B.JTID_L=A.JTID_L AND B.SYID_L=A.SYID_L AND B.CIID_L=A.CIID_L $BIID_F) $SQL2
    GROUP BY A.MGNO
    ORDER BY BMMMT DESC
  ''';
  }else if(type=='3'){
    sql = '''
    SELECT A.MGNO,A.MINO,SUM(CASE WHEN A.BMKID IN (3, 5) THEN (((A.BMDAM-A.BMDDI) * A.BMDNO ) + A.BMDTXT1)
    ELSE 0.0 END) AS BMMMT,
    SUM(CASE WHEN A.BMKID IN (4) THEN (((A.BMDAM-A.BMDDI) * A.BMDNO ) + A.BMDTXT1) ELSE 0.0 END) AS BMMAM,
    CASE WHEN ${LoginController().LAN}=2 AND B.MINA IS NOT NULL THEN B.MINE ELSE B.MINA END  BINA_D 
    FROM BIL_MOV_D A JOIN MAT_INF B ON A.MGNO = B.MGNO AND A.MINO = B.MINO 
    AND A.JTID_L = B.JTID_L AND A.SYID_L = B.SYID_L
    AND A.CIID_L = B.CIID_L $SQLBIID_L2 WHERE A.BMKID IN(3, 4, 5) AND EXISTS(SELECT 1 FROM BIL_MOV_M B
    WHERE B.BMMID=A.BMMID AND B.SCID=$SCID AND B.BMMDOR BETWEEN '$GETDATE_F' AND '$GETDATE_T' AND 
    B.JTID_L=A.JTID_L AND B.SYID_L=A.SYID_L AND B.CIID_L=A.CIID_L $BIID_F) $SQL2
    GROUP BY A.MGNO,A.MINO
    UNION ALL
    SELECT A.MGNO,A.MINO,SUM(CASE WHEN A.BMKID IN (11) THEN (((A.BMDAM-A.BMDDI) * A.BMDNO ) + A.BMDTXT1)
    ELSE 0.0 END) AS BMMMT,
    SUM(CASE WHEN A.BMKID IN ( 12) THEN (((A.BMDAM-A.BMDDI) * A.BMDNO ) + A.BMDTXT1) ELSE 0.0 END) AS BMMAM,
    CASE WHEN ${LoginController().LAN}=2 AND B.MINA IS NOT NULL THEN B.MINE ELSE B.MINA END  BINA_D 
    FROM BIF_MOV_D A JOIN MAT_INF B ON A.MGNO = B.MGNO AND A.MINO = B.MINO 
    AND A.JTID_L = B.JTID_L AND A.SYID_L = B.SYID_L
    AND A.CIID_L = B.CIID_L $SQLBIID_L2 WHERE A.BMKID IN( 11, 12) AND EXISTS(SELECT 1 FROM BIF_MOV_M B
    WHERE B.BMMID=A.BMMID AND B.SCID=$SCID AND B.BMMDOR BETWEEN '$GETDATE_F' AND '$GETDATE_T' AND 
    B.JTID_L=A.JTID_L AND B.SYID_L=A.SYID_L AND B.CIID_L=A.CIID_L $BIID_F) $SQL2
    GROUP BY A.MGNO,A.MINO
    ORDER BY BMMMT DESC
  ''';
  }
  else if(type=='4'){
    sql = '''
    SELECT A.SIID AS BIID2,SUM(CASE WHEN A.BMKID IN (3, 5, 11) THEN A.BMMMT ELSE 0.0 END) AS BMMMT,
    SUM(CASE WHEN A.BMKID IN (4, 12) THEN A.BMMMT ELSE 0.0 END) AS BMMAM,
    CASE WHEN ${LoginController().LAN}=2 AND B.SINE IS NOT NULL THEN B.SINE ELSE B.SINA END  BINA_D 
    FROM BIL_MOV_M A JOIN STO_INF B ON A.SIID = B.SIID AND A.JTID_L = B.JTID_L AND A.SYID_L = B.SYID_L
    AND A.CIID_L = B.CIID_L $SQLBIID_L2 WHERE A.BMKID IN(3, 4, 5, 11, 12) $Where $SQL2
    GROUP BY A.SIID
    UNION ALL
    SELECT A.SIID AS BIID2,SUM(CASE WHEN A.BMKID IN (3, 5, 11) THEN A.BMMMT ELSE 0.0 END) AS BMMMT,
    SUM(CASE WHEN A.BMKID IN (4, 12) THEN A.BMMMT ELSE 0.0 END) AS BMMAM,
    CASE WHEN ${LoginController().LAN}=2 AND B.SINE IS NOT NULL THEN B.SINE ELSE B.SINA END  BINA_D 
    FROM BIF_MOV_M A JOIN STO_INF B ON A.SIID = B.SIID AND A.JTID_L = B.JTID_L AND A.SYID_L = B.SYID_L
    AND A.CIID_L = B.CIID_L $SQLBIID_L2 WHERE A.BMKID IN(3, 4, 5, 11, 12) $Where $SQL2
    GROUP BY A.SIID 
    ORDER BY BMMMT DESC
  ''';
  }
  else if(type=='5'){
    sql = '''
    SELECT A.BCID AS BIID2,SUM(CASE WHEN A.BMKID IN (3, 5, 11) THEN A.BMMMT ELSE 0.0 END) AS BMMMT,
    SUM(CASE WHEN A.BMKID IN (4, 12) THEN A.BMMMT ELSE 0.0 END) AS BMMAM,
    CASE WHEN ${LoginController().LAN}=2 AND B.BCNE IS NOT NULL THEN B.BCNE ELSE B.BCNA END  BINA_D 
    FROM BIL_MOV_M A JOIN BIL_CUS B ON A.BCID = B.BCID AND A.JTID_L = B.JTID_L AND A.SYID_L = B.SYID_L
    AND A.CIID_L = B.CIID_L $SQLBIID_L2 WHERE A.BMKID IN(3, 4, 5, 11, 12) $Where $SQL2
    GROUP BY A.BCID
    UNION ALL
    SELECT A.BCID AS BIID2,SUM(CASE WHEN A.BMKID IN (3, 5, 11) THEN A.BMMMT ELSE 0.0 END) AS BMMMT,
    SUM(CASE WHEN A.BMKID IN (4, 12) THEN A.BMMMT ELSE 0.0 END) AS BMMAM,
    CASE WHEN ${LoginController().LAN}=2 AND B.BCNE IS NOT NULL THEN B.BCNE ELSE B.BCNA END  BINA_D 
    FROM BIF_MOV_M A JOIN BIL_CUS B ON A.BCID = B.BCID AND A.JTID_L = B.JTID_L AND A.SYID_L = B.SYID_L
    AND A.CIID_L = B.CIID_L $SQLBIID_L2 WHERE A.BMKID IN(3, 4, 5, 11, 12) $Where $SQL2
    GROUP BY A.BCID
    ORDER BY BMMMT DESC
  ''';
  }
  else if(type=='6'){
    sql = '''
    SELECT A.BDID AS BIID2,SUM(CASE WHEN A.BMKID IN (3, 5, 11) THEN A.BMMMT ELSE 0.0 END) AS BMMMT,
    SUM(CASE WHEN A.BMKID IN (4, 12) THEN A.BMMMT ELSE 0.0 END) AS BMMAM,
    CASE WHEN ${LoginController().LAN}=2 AND B.BDNE IS NOT NULL THEN B.BDNE ELSE B.BDNA END  BINA_D 
    FROM BIL_MOV_M A JOIN BIL_DIS B ON A.BDID = B.BDID AND A.JTID_L = B.JTID_L AND A.SYID_L = B.SYID_L
    AND A.CIID_L = B.CIID_L $SQLBIID_L2 WHERE A.BMKID IN(3, 4, 5, 11, 12) $Where $SQL2
    GROUP BY A.BDID
    UNION ALL
    SELECT A.BDID AS BIID2,SUM(CASE WHEN A.BMKID IN (3, 5, 11) THEN A.BMMMT ELSE 0.0 END) AS BMMMT,
    SUM(CASE WHEN A.BMKID IN (4, 12) THEN A.BMMMT ELSE 0.0 END) AS BMMAM,
    CASE WHEN ${LoginController().LAN}=2 AND B.BDNE IS NOT NULL THEN B.BDNE ELSE B.BDNA END  BINA_D 
    FROM BIF_MOV_M A JOIN BIL_DIS B ON A.BDID = B.BDID AND A.JTID_L = B.JTID_L AND A.SYID_L = B.SYID_L
    AND A.CIID_L = B.CIID_L $SQLBIID_L2 WHERE A.BMKID IN(3, 4, 5, 11, 12) $Where $SQL2
    GROUP BY A.BDID
    ORDER BY BMMMT DESC
  ''';
  }
  else if(type=='7'){
    sql = '''
    SELECT A.SUID,SUM(CASE WHEN A.BMKID IN (3, 5, 11) THEN A.BMMMT ELSE 0.0 END) AS BMMMT,
    SUM(CASE WHEN A.BMKID IN (4, 12) THEN A.BMMMT ELSE 0.0 END) AS BMMAM,
    CASE WHEN ${LoginController().LAN}=2 AND B.SUNE IS NOT NULL THEN B.SUNE ELSE B.SUNA END  BINA_D 
    FROM BIL_MOV_M A JOIN SYS_USR B ON A.SUID = B.SUID AND A.JTID_L = B.JTID_L AND A.SYID_L = B.SYID_L
    AND A.CIID_L = B.CIID_L $SQLBIID_L2 WHERE A.BMKID IN(3, 4, 5, 11, 12) $Where $SQL2
    GROUP BY A.SUID
    UNION ALL
    SELECT A.SUID,SUM(CASE WHEN A.BMKID IN (3, 5, 11) THEN A.BMMMT ELSE 0.0 END) AS BMMMT,
    SUM(CASE WHEN A.BMKID IN (4, 12) THEN A.BMMMT ELSE 0.0 END) AS BMMAM,
    CASE WHEN ${LoginController().LAN}=2 AND B.SUNE IS NOT NULL THEN B.SUNE ELSE B.SUNA END  BINA_D 
    FROM BIF_MOV_M A JOIN SYS_USR B ON A.SUID = B.SUID AND A.JTID_L = B.JTID_L AND A.SYID_L = B.SYID_L
    AND A.CIID_L = B.CIID_L $SQLBIID_L2 WHERE A.BMKID IN(3, 4, 5, 11, 12) $Where $SQL2
    GROUP BY A.SUID 
    ORDER BY BMMMT DESC
  ''';
  }
  else if(type=='8'){
    sql = '''
    SELECT A.PKID AS BIID2,SUM(CASE WHEN A.BMKID IN (3, 5, 11) THEN A.BMMMT ELSE 0.0 END) AS BMMMT,
    SUM(CASE WHEN A.BMKID IN (4, 12) THEN A.BMMMT ELSE 0.0 END) AS BMMAM,
    CASE WHEN ${LoginController().LAN}=2 AND B.PKNE IS NOT NULL THEN B.PKNE ELSE B.PKNA END  BINA_D 
    FROM BIL_MOV_M A JOIN PAY_KIN B ON A.PKID = B.PKID AND A.JTID_L = B.JTID_L AND A.SYID_L = B.SYID_L
    AND A.CIID_L = B.CIID_L $SQLBIID_L2 WHERE A.BMKID IN(3, 4, 5, 11, 12) $Where $SQL2
    GROUP BY A.PKID
    UNION ALL
    SELECT A.PKID AS BIID2,SUM(CASE WHEN A.BMKID IN (3, 5, 11) THEN A.BMMMT ELSE 0.0 END) AS BMMMT,
    SUM(CASE WHEN A.BMKID IN (4, 12) THEN A.BMMMT ELSE 0.0 END) AS BMMAM,
    CASE WHEN ${LoginController().LAN}=2 AND B.PKNE IS NOT NULL THEN B.PKNE ELSE B.PKNA END  BINA_D 
    FROM BIF_MOV_M A JOIN PAY_KIN B ON A.PKID = B.PKID AND A.JTID_L = B.JTID_L AND A.SYID_L = B.SYID_L
    AND A.CIID_L = B.CIID_L $SQLBIID_L2 WHERE A.BMKID IN(3, 4, 5, 11, 12) $Where $SQL2
    GROUP BY A.PKID
    ORDER BY BMMMT DESC
  ''';
  }else if(type=='9'){
    sql = '''
    SELECT A.ACNO,SUM(CASE WHEN A.BMKID IN (3, 5, 11) THEN A.BMMMT ELSE 0.0 END) AS BMMMT,
    SUM(CASE WHEN A.BMKID IN (4, 12) THEN A.BMMMT ELSE 0.0 END) AS BMMAM,
    CASE WHEN ${LoginController().LAN}=2 AND B.ACNE IS NOT NULL THEN B.ACNE ELSE B.ACNA END  BINA_D 
    FROM BIL_MOV_M A JOIN ACC_COS B ON A.ACNO = B.ACNO AND A.JTID_L = B.JTID_L AND A.SYID_L = B.SYID_L
    AND A.CIID_L = B.CIID_L $SQLBIID_L2 WHERE A.BMKID IN(3, 4, 5, 11, 12) $Where $SQL2
    GROUP BY A.ACNO
    UNION ALL
    SELECT A.ACNO,SUM(CASE WHEN A.BMKID IN (3, 5, 11) THEN A.BMMMT ELSE 0.0 END) AS BMMMT,
    SUM(CASE WHEN A.BMKID IN (4, 12) THEN A.BMMMT ELSE 0.0 END) AS BMMAM,
    CASE WHEN ${LoginController().LAN}=2 AND B.ACNE IS NOT NULL THEN B.ACNE ELSE B.ACNA END  BINA_D 
    FROM BIF_MOV_M A JOIN ACC_COS B ON A.ACNO = B.ACNO AND A.JTID_L = B.JTID_L AND A.SYID_L = B.SYID_L
    AND A.CIID_L = B.CIID_L $SQLBIID_L2 WHERE A.BMKID IN(3, 4, 5, 11, 12) $Where $SQL2
    GROUP BY A.ACNO
    ORDER BY BMMMT DESC
  ''';
  }else if(type=='10'){
    sql = '''
    SELECT A.SCID AS BIID2,SUM(CASE WHEN A.BMKID IN (3, 5, 11) THEN A.BMMMT ELSE 0.0 END) AS BMMMT,
    SUM(CASE WHEN A.BMKID IN (4, 12) THEN A.BMMMT ELSE 0.0 END) AS BMMAM,
    CASE WHEN ${LoginController().LAN}=2 AND B.SCNE IS NOT NULL THEN B.SCNE ELSE B.SCNA END  BINA_D 
    FROM BIL_MOV_M A JOIN SYS_CUR B ON A.SCID = B.SCID AND A.JTID_L = B.JTID_L AND A.SYID_L = B.SYID_L
    AND A.CIID_L = B.CIID_L $SQLBIID_L2 WHERE A.BMKID IN(3, 4, 5, 11, 12) $Where $SQL2
    GROUP BY A.SCID
    UNION ALL
    SELECT A.SCID AS BIID2,SUM(CASE WHEN A.BMKID IN (3, 5, 11) THEN A.BMMMT ELSE 0.0 END) AS BMMMT,
    SUM(CASE WHEN A.BMKID IN (4, 12) THEN A.BMMMT ELSE 0.0 END) AS BMMAM,
    CASE WHEN ${LoginController().LAN}=2 AND B.SCNE IS NOT NULL THEN B.SCNE ELSE B.SCNA END  BINA_D 
    FROM BIF_MOV_M A JOIN SYS_CUR B ON A.SCID = B.SCID AND A.JTID_L = B.JTID_L AND A.SYID_L = B.SYID_L
    AND A.CIID_L = B.CIID_L $SQLBIID_L2 WHERE A.BMKID IN(3, 4, 5, 11, 12) $Where $SQL2
    GROUP BY A.SCID
    ORDER BY BMMMT DESC
  ''';
  }
  var result = await dbClient!.rawQuery(sql);
  return result.map((item) => Bil_Mov_M_Local.fromMap(item)).toList();
}

Future<List<Bil_Mov_M_Local>> getSumBal(SCID,String GETDATE_F, String GETDATE_T) async {
  try {
    var dbClient = await conn.database; // الحصول على اتصال قاعدة البيانات
    String SQLBIID_L = LoginController().BIID_ALL_V == '1'
        ? " AND  A.BIID_L=${LoginController().BIID}" :  '';
    String sql = ''' 
     SELECT  COALESCE(SUM(CASE WHEN A.BMKID IN (3, 5, 11) THEN A.BMMMT ELSE 0.0 END), 0.0) AS BMMMT,
    COALESCE(SUM(CASE WHEN A.BMKID IN (4, 12) THEN A.BMMMT ELSE 0.0 END), 0.0) AS BMMAM,
    COALESCE(SUM(CASE WHEN A.BMKID IN (3, 5, 11) THEN A.BMMMT ELSE 0.0 END), 0.0) - 
    COALESCE(SUM(CASE WHEN A.BMKID IN (4, 12) THEN A.BMMMT ELSE 0.0 END), 0.0) AS NET
    FROM BIL_MOV_M A WHERE A.BMKID IN  (3, 5, 11,4, 12) AND A.SCID=$SCID 
    AND A.BMMDOR BETWEEN '$GETDATE_F' AND '$GETDATE_T'
    AND A.JTID_L=${LoginController().JTID} 
    AND A.SYID_L=${LoginController().SYID} 
    AND A.CIID_L=${LoginController().CIID} 
    $SQLBIID_L 
     UNION ALL
     SELECT  COALESCE(SUM(CASE WHEN A.BMKID IN (11) THEN A.BMMMT ELSE 0.0 END), 0.0) AS BMMMT,
    COALESCE(SUM(CASE WHEN A.BMKID IN (12) THEN A.BMMMT ELSE 0.0 END), 0.0) AS BMMAM,
    COALESCE(SUM(CASE WHEN A.BMKID IN (11) THEN A.BMMMT ELSE 0.0 END), 0.0) - 
    COALESCE(SUM(CASE WHEN A.BMKID IN (12) THEN A.BMMMT ELSE 0.0 END), 0.0) AS NET
    FROM BIF_MOV_M A WHERE A.BMKID IN  (11,12) AND A.SCID=$SCID 
    AND A.BMMDOR BETWEEN '$GETDATE_F' AND '$GETDATE_T'
    AND A.JTID_L=${LoginController().JTID} 
    AND A.SYID_L=${LoginController().SYID} 
    AND A.CIID_L=${LoginController().CIID} 
    $SQLBIID_L 
    ''';

    var result = await dbClient!.rawQuery(sql);
    // printLongText(sql);
    return result.map((item) => Bil_Mov_M_Local.fromMap(item)).toList();
  } catch (e) {
    print('Error in getSumBal: $e');
    return []; // إرجاع قائمة فارغة في حالة حدوث خطأ
  }
}

Future<List<Bil_Mov_M_Local>> GET_COUNT_ST(type,String GETDATE_F, String GETDATE_T) async {

  var dbClient = await conn.database; // الحصول على اتصال قاعدة البيانات

  // شرط BIID إضافي إذا كان مطلوباً
  String SQLBIID_L = LoginController().BIID_ALL_V == '1'
      ? " AND A.BIID_L = ${LoginController().BIID}"
      : "";

  String SQLBIID_L2 = LoginController().BIID_ALL_V == '1'
      ? " AND B.BIID_L = ${LoginController().BIID}"
      : "";

  String Where =type==1?' A.BMKID IN(1,2) ':' A.BMKID IN(3,4,5,6,11,12)';

  // استعلام SQL باستخدام UNION ALL لتجميع النتائج من ثلاثة جداول
  String sql = '''
      SELECT IFNULL(SUM(BMMST), 0) AS BMMST, IFNULL(SUM(BMMST2), 0) AS BMMST2 FROM (
        SELECT COUNT(CASE WHEN A.BMMST = 1 THEN 1 END) AS BMMST,
        COUNT(CASE WHEN A.BMMST != 1 THEN 1 END) AS BMMST2
        FROM BIL_MOV_M A 
        WHERE  $Where AND A.BMMDOR BETWEEN '$GETDATE_F' AND '$GETDATE_T' AND A.JTID_L = ${LoginController().JTID}
        AND A.SYID_L = ${LoginController().SYID}
        AND A.CIID_L = ${LoginController().CIID}
        $SQLBIID_L
        UNION ALL
        SELECT COUNT(CASE WHEN B.BMMST = 1 THEN 1 END) AS BMMST,
        COUNT(CASE WHEN B.BMMST != 1 THEN 1 END) AS BMMST2
        FROM BIF_MOV_M B
        WHERE B.BMMDOR BETWEEN '$GETDATE_F' AND '$GETDATE_T' AND
        B.JTID_L = ${LoginController().JTID}
        AND B.SYID_L = ${LoginController().SYID}
        AND B.CIID_L = ${LoginController().CIID}
        $SQLBIID_L2
      )
    ''';

  var result = await dbClient!.rawQuery(sql);
  return result.map((item) => Bil_Mov_M_Local.fromMap(item)).toList();
}

Future<List<Acc_Mov_M_Local>> GET_COUNT_VOU() async {

  var dbClient = await conn.database; // الحصول على اتصال قاعدة البيانات

  // شرط BIID إضافي إذا كان مطلوباً
  String SQLBIID_L = LoginController().BIID_ALL_V == '1'
      ? " AND A.BIID_L = ${LoginController().BIID}"
      : "";

  // استعلام SQL باستخدام UNION ALL لتجميع النتائج من ثلاثة جداول
  String sql = '''
        SELECT SUM(COUNT(CASE WHEN A.AMMST = 1 THEN 1 ELSE 0 END)) AS AMMST,
        SUM(COUNT(CASE WHEN A.AMMST != 1 THEN 1  ELSE 0 END)) AS AMMST2
        FROM ACC_MOV_M A
        WHERE A.JTID_L = ${LoginController().JTID}
        AND A.SYID_L = ${LoginController().SYID}
        AND A.CIID_L = ${LoginController().CIID}
        $SQLBIID_L
    ''';

  var result = await dbClient!.rawQuery(sql);
  return result.map((item) => Acc_Mov_M_Local.fromMap(item)).toList();
}

Future<List<Bil_Mov_M_Local>> GET_SUM_PAY_MOV(SCID,String GETDATE_F, String GETDATE_T) async {
  var dbClient = await conn.database;
  String sql = '';
  String Wheresql = '';

  LoginController().BIID_ALL_V == '1'
      ? Wheresql = " AND A.BIID_L=${LoginController().BIID}"
      : Wheresql = '';
  String SQLBIID_L2 = LoginController().BIID_ALL_V == '1'
      ? " AND A.BIID_L = B.BIID_L " :  '';

  sql=''' SELECT ifnull(SUM(BMMMT),0.0) AS BMMMT,A.BMKID,A.PKID,A.JTID_L,A.SYID_L,A.CIID_L,A.BIID_L,
   CASE WHEN ${LoginController().LAN}=2 AND B.PKNE IS NOT NULL THEN B.PKNE ELSE B.PKNA END  PKNA_D
   FROM BIL_MOV_M A JOIN PAY_KIN B ON A.PKID = B.PKID AND A.JTID_L = B.JTID_L AND A.SYID_L = B.SYID_L
   AND A.CIID_L = B.CIID_L $SQLBIID_L2 WHERE  A.BMKID IN (1)  AND A.SCID=$SCID AND A.BMMDOR BETWEEN '$GETDATE_F' 
   AND '$GETDATE_T' AND A.JTID_L=${LoginController().JTID} 
   AND A.SYID_L=${LoginController().SYID} AND A.CIID_L=${LoginController().CIID} $Wheresql
   GROUP BY A.PKID 
    ''';
  var result = await dbClient!.rawQuery(sql);
  List<Bil_Mov_M_Local> list = result.map((item) {
    return Bil_Mov_M_Local.fromMap(item);
  }).toList();
  return list;
}

Future<void> insertBackupInfo(String type, String path,String date, String time) async {
  try {
    final db = await DatabaseHelper().database; // تأكد من وجود DatabaseHelper
    final file = File(path);
    final sizeInBytes = await file.length();
    final sizeInMB = (sizeInBytes / (1024 * 1024)).toStringAsFixed(2);
    await db!.insert('BK_INF', {
      'BITY': type,
      'BIUR': path,
      'BIDA': date,
      'BITI': time,
      'BIZI': '$sizeInMB MB',
      'JTID_L': LoginController().JTID,
      'BIID_L': LoginController().BIID,
      'SYID_L': LoginController().SYID,
      'CIID_L': LoginController().CIID,
    });
    print('✅ Backup info inserted successfully.');
  } catch (e) {
    print('❌ Error inserting backup info: $e');
  }
}

Future<List<Bk_inf>> GET_BK_INF() async {
  try {
    var dbClient = await conn.database; // الحصول على اتصال قاعدة البيانات
    String SQLBIID_L = LoginController().BIID_ALL_V == '1'
        ? " AND  A.BIID_L=${LoginController().BIID}" :  '';
    String sql = ''' SELECT * FROM BK_INF A WHERE A.JTID_L=${LoginController().JTID} 
    AND A.SYID_L=${LoginController().SYID} AND A.CIID_L=${LoginController().CIID} 
    $SQLBIID_L ORDER BY A.BIDA DESC  ''';

    var result = await dbClient!.rawQuery(sql);


    return result.map((item) => Bk_inf.fromMap(item)).toList();
  } catch (e) {
    print('Error in Bk_inf: $e');
    return []; // إرجاع قائمة فارغة في حالة حدوث خطأ
  }
}


Future<List<Bil_Mov_M_Local>> SUM_BAL(TYPE,TYPE2,GETID,AANO,SCID,Last_Asyn) async {
  var dbClient = await conn.database;
  String sql='';
  String sqlBMMST='';
  String sqlAMMST='';
  String sqlBMMID='';
  String sqlAMMID='';
  final inputFormat = DateFormat('dd-MM-yyyy HH:mm:ss');
  final dt = inputFormat.parse(Last_Asyn);
  final outputFormat = DateFormat('yyyy-MM-dd HH:mm:ss');
  final lastSyncIso = outputFormat.format(dt);
  print(lastSyncIso);

  if(TYPE2==1){
    sqlBMMST='  A.BMMST=2  ';
    sqlAMMST='  A.AMMST=2  ';
  }else{

 sqlBMMST='''   (A.BMMST=2 OR (A.BMMST=1 AND datetime(
 substr(COALESCE(A.DATEU, A.DATEI), 7, 4) || '-' ||
 substr(COALESCE(A.DATEU, A.DATEI), 4, 2) || '-' ||
 substr(COALESCE(A.DATEU, A.DATEI), 1, 2) || ' ' ||
 substr(COALESCE(A.DATEU, A.DATEI), 12, 5)) > datetime('$lastSyncIso'))) ''';

 sqlAMMST=''' (A.AMMST=2 OR (A.AMMST=1 AND datetime(
 substr(COALESCE(A.DATEU, A.DATEI), 7, 4) || '-' ||
 substr(COALESCE(A.DATEU, A.DATEI), 4, 2) || '-' ||
 substr(COALESCE(A.DATEU, A.DATEI), 1, 2) || ' ' ||
 substr(COALESCE(A.DATEU, A.DATEI), 12, 5)) > datetime('$lastSyncIso')))  ''';
  }


  if(TYPE==1){
    sqlBMMID=' A.BMMID!=$GETID AND ';
  }else{
    sqlBMMID=' ';
  }

  if(TYPE==2){
    sqlAMMID='  A.AMMID!=$GETID  AND ';
  }else{
    sqlAMMID=' ';
  }

sql=''' SELECT SUM(IFNULL(A1.MD,0.0)) AS MD,SUM(IFNULL(A1.DA,0.0)) AS DA,
IFNULL((SUM(A1.MD)-SUM(A1.DA)),0.0) AS SUM_BAL
FROM (SELECT A.MD,A.DA,A.AANO,A.SCID,A.CIID_L,A.JTID_L,A.BIID_L,A.SYID_L FROM 
(SELECT  A.AANO,A.SCID,(CASE WHEN B.BMKTY = 2 THEN
(Ifnull (A.BMMAM, 0) - Ifnull (A.BMMDI, 0) - Ifnull (A.BMMDIA, 0) - 
Ifnull (A.BMMDIF, 0)) ELSE 0 END)  AS MD,(CASE WHEN B.BMKTY = 1 THEN (  Ifnull (A.BMMAM, 0)
 - Ifnull (A.BMMDI, 0) - Ifnull (A.BMMDIA, 0) - Ifnull (A.BMMDIF, 0)) ELSE 0 END) 
AS DA,A.BMMST AS SYN_ST,  A.CIID_L,A.JTID_L,A.BIID_L,A.SYID_L FROM BIL_MOV_M A 
LEFT JOIN BIL_MOV_K AS B ON(A.BMKID=B.BMKID AND A.CIID_L=B.CIID_L  AND A.JTID_L=B.JTID_L  
AND A.BIID_L=B.BIID_L AND A.SYID_L=B.SYID_L ) WHERE $sqlBMMID
 B.BMKTY IN(1,2) AND B.BMKAN IS NOT NULL AND (Ifnull(A.BCID,A.BIID) IS NOT NULL) 
AND A.BPID IS NULL AND A.PKID IN(3) AND $sqlBMMST

UNION ALL 
  SELECT C.AANO,A.SCID,(CASE WHEN B.BMKTY = 2 THEN(  Ifnull (A.BMMAM, 0)- Ifnull (A.BMMDI, 0)
  - Ifnull (A.BMMDIA, 0)- Ifnull (A.BMMDIF, 0)) ELSE  0 END) AS MD,
  (CASE WHEN B.BMKTY = 1 THEN(  Ifnull (A.BMMAM, 0) - Ifnull (A.BMMDI, 0)
  - Ifnull (A.BMMDIA, 0) - Ifnull (A.BMMDIF, 0)) ELSE 0 END) AS DA,
			    A.BMMST AS SYN_ST, A.CIID_L,A.JTID_L,A.BIID_L,A.SYID_L
          FROM BIF_MOV_M A 
          LEFT JOIN BIL_MOV_K AS B ON(A.BMKID=B.BMKID AND A.CIID_L=B.CIID_L  AND A.JTID_L=B.JTID_L  
		      AND A.BIID_L=B.BIID_L AND A.SYID_L=B.SYID_L ) 
          left join BIL_CUS AS C ON(A.BCID=C.BCID AND A.CIID_L=C.CIID_L  
          AND A.BIID_L=C.BIID_L AND A.JTID_L=C.JTID_L AND A.SYID_L=C.SYID_L )		  
          WHERE  $sqlBMMID
           B.BMKTY IN(1,2) AND B.BMKAN IS NOT NULL 
          AND (A.BCID IS NOT NULL) AND A.BPID IS NULL 
          AND A.PKID IN(3)  AND $sqlBMMST
		  UNION ALL 
SELECT C.AANO,Ifnull (CAST (C.SCID AS INTEGER), A.SCID) AS SCID,
     Ifnull (C.AMDMD, 0) AS MD,Ifnull (C.AMDDA, 0) AS DA,
	   A.AMMST AS SYN_ST,A.CIID_L,A.JTID_L,A.BIID_L,A.SYID_L
  FROM ACC_MOV_M A 
  LEFT JOIN ACC_MOV_K AS B ON(A.AMKID=B.AMKID AND A.CIID_L=B.CIID_L  AND A.JTID_L=B.JTID_L 
  AND A.BIID_L=B.BIID_L AND A.SYID_L=B.SYID_L ) 
  left join ACC_MOV_D AS C ON(A.AMKID=C.AMKID AND A.AMMID=C.AMMID AND A.CIID_L=C.CIID_L  
  AND A.BIID_L=C.BIID_L AND A.JTID_L=C.JTID_L AND A.SYID_L=C.SYID_L ) 
  left join ACC_ACC AS E ON(C.AANO=E.AANO  AND C.CIID_L=E.CIID_L  AND C.JTID_L=E.JTID_L 
  AND A.BIID_L=E.BIID_L AND  C.SYID_L=E.SYID_L ) 
  WHERE  $sqlAMMID    $sqlAMMST AND B.AMKAC IN (1) ) AS A 
WHERE (A.CIID_L='${LoginController().CIID}' AND A.JTID_L= ${LoginController().JTID}
AND A.SYID_L=${LoginController().SYID} ) AND A.AANO='$AANO' AND A.SCID=$SCID  ) AS A1 ''';

  var result = await dbClient!.rawQuery(sql,);
   print('SUM_BAL');
   printLongText('SQL: $sql');
  // print('Args: [$lastSyncIso]');
   print('Result: $result');
  List<Bil_Mov_M_Local> list = result.map((item) {
    return Bil_Mov_M_Local.fromMap(item);
  }).toList();
  return list;
}


// تحميل جميع الطابعات من SQLite
Future<List<AppPrinterDevice>> loadPrinters() async {
  var dbClient = await conn.database;
  final rows = await dbClient!.query('AppPrinterDevice');
  print(rows);
  return rows.map((m) => AppPrinterDevice.fromMap(m)).toList();
}

// إضافة طابعة جديدة
Future<void> addPrinter(AppPrinterDevice printer) async {
  var dbClient = await conn.database;
  await dbClient!.insert(
    'AppPrinterDevice',
    printer.toMap(),
    conflictAlgorithm: ConflictAlgorithm.replace,
  );
}

// تحديث طابعة موجودة
Future<void> updatePrinter(AppPrinterDevice printer) async {
  var dbClient = await conn.database;
  await dbClient!.update(
    'AppPrinterDevice',
    printer.toMap(),
    where: 'id = ?',
    whereArgs: [printer.id],
  );
}

// حذف طابعة
Future<void> deletePrinter(int id) async {
  var dbClient = await conn.database;
  await dbClient!.delete(
    'AppPrinterDevice',
    where: 'id = ?',
    whereArgs: [id],
  );
}

Future<void> insertMob_Log(String MLTY,String MLIN) async {
  try {
    final db = await DatabaseHelper().database; // تأكد من وجود DatabaseHelper
    final dateTimes = DateFormat('dd-MM-yyyy hh:mm').format(DateTime.now());
    await db!.insert('MOB_LOG', {
      'MLTY': MLTY,
      'MLDO': dateTimes.toString(),
      'SUID': LoginController().SUID,
      'SUNA': LoginController().SUNA,
      'MLIN': MLIN.toString(),
      'JTID_L': LoginController().JTID,
      'BIID_L': LoginController().BIID,
      'SYID_L': LoginController().SYID,
      'CIID_L': LoginController().CIID,
    });
    print('✅ Mob_Log info inserted successfully.');
  } catch (e) {
    print('❌ Error inserting Mob Log: $e');
  }
}

/// Fetch all MobLog records.
Future<List<MobLog>> fetchAllMobLogs() async {
  final db = await DatabaseHelper().database;
  final result = await db!.query(
    MobLog.tableName,
    orderBy: 'MLDO DESC',
  );
  return result.map((map) => MobLog.fromMap(map)).toList();
}

/// Delete a MobLog by its MLID.
Future<int> deleteMobLog(int mlid) async {
  final db = await DatabaseHelper().database;
  return await db!.delete(
    MobLog.tableName,
    where: 'MLID = ?',
    whereArgs: [mlid],
  );
}