import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import '../Operation/models/acc_mov_d.dart';
import '../Operation/models/acc_mov_m.dart';
import '../Setting/controllers/login_controller.dart';
import '../Setting/models/acc_acc.dart';
import '../Setting/models/sys_cur.dart';
import 'database.dart';

final conn = DatabaseHelper.instance;

Future<List<Acc_Mov_M_Local>> GET_AMMNO(int GETAMKID) async {
  var dbClient = await conn.database;
  String sql;
  String Wheresql = '';
  String sqlAMKID = '';
  if (GETAMKID == 1 || GETAMKID == 2 || GETAMKID == 3) {
    sqlAMKID = " AMKID=$GETAMKID AND ";
  } else {
    sqlAMKID = " AMKID NOT IN (1,2,3) AND ";
  }

  LoginController().BIID_ALL_V == '1'
      ? Wheresql = " AND  BIID_L=${LoginController().BIID}"
      : Wheresql = '';
  sql =
  "SELECT ifnull(MAX(AMMNO),0)+1 AS AMMNO FROM ACC_MOV_M  WHERE $sqlAMKID SUID=${LoginController().SUID}  AND"
      " JTID_L=${LoginController().JTID} AND SYID_L=${LoginController().SYID}  AND CIID_L='${LoginController().CIID}' $Wheresql ";
  var result = await dbClient!.rawQuery(sql);
  List<Acc_Mov_M_Local> list = result.map((item) {
    return Acc_Mov_M_Local.fromMap(item);
  }).toList();
  return list;
}

Future<List<Acc_Mov_M_Local>> GET_AMMID() async {
  var dbClient = await conn.database;
  String sql;
  sql = "SELECT ifnull(MAX(AMMID),0)+1 AS AMMID FROM ACC_MOV_M  ";
  var result = await dbClient!.rawQuery(sql);
  List<Acc_Mov_M_Local> list = result.map((item) {
    return Acc_Mov_M_Local.fromMap(item);
  }).toList();
  return list;
}

Future<List<Acc_Mov_D_Local>> GET_AMDID(int GETAMKID, int GETAMMID) async {
  var dbClient = await conn.database;
  String Wheresql = '';

  LoginController().BIID_ALL_V == '1'
      ? Wheresql = " AND  BIID_L=${LoginController().BIID}"
      : Wheresql = '';
  String sql;

  sql =
  "SELECT ifnull(MAX(AMDID),0)+1 AS AMDID FROM ACC_MOV_D  WHERE  AMMID=$GETAMMID  AND "
      " JTID_L=${LoginController().JTID} AND SYID_L=${LoginController().SYID}  AND CIID_L='${LoginController().CIID}' $Wheresql ";
  var result = await dbClient!.rawQuery(sql);
  List<Acc_Mov_D_Local> list = result.map((item) {
    return Acc_Mov_D_Local.fromMap(item);
  }).toList();

  return list;
}

Future<Acc_Mov_D_Local> Save_ACC_MOV_D(Acc_Mov_D_Local data) async {
  try {
    var dbClient = await conn.database;
    data.AMDID = await dbClient!.insert('ACC_MOV_D', data.toMap());
    return data;
  } catch (e) {
    print(e.toString());
    Fluttertoast.showToast(
        msg: e.toString(),
        toastLength: Toast.LENGTH_LONG,
        textColor: Colors.white,
        backgroundColor: Colors.redAccent);
    return data;
  }
}

Future<List<Acc_Mov_D_Local>> GET_ACC_MOV_D(
    String GETAMKID, String GETAMMID) async {
  var dbClient = await conn.database;
  String sql;
  String sqlAMKID = '';
  String Wheresql = '';
  String Wheresql2 = '';
  String Wheresql3 = '';
  String Wheresql6 = '';

  if (GETAMKID == '1' || GETAMKID == '2' || GETAMKID == '3') {
    sqlAMKID = " A.AMKID=$GETAMKID AND ";
  } else {
    sqlAMKID = " A.AMKID NOT IN (1,2,3) AND ";
  }

  LoginController().BIID_ALL_V == '1'
      ? Wheresql = " AND  A.BIID_L=${LoginController().BIID}"
      : Wheresql = '';
  LoginController().BIID_ALL_V == '1'
      ? Wheresql2 = " AND  B.BIID_L=${LoginController().BIID}"
      : Wheresql2 = '';
  LoginController().BIID_ALL_V == '1'
      ? Wheresql2 = " AND  C.BIID_L=${LoginController().BIID}"
      : Wheresql3 = '';
  LoginController().BIID_ALL_V == '1'
      ? Wheresql6 = " AND F.JTID_L=${LoginController().JTID} "
      " AND F.SYID_L=${LoginController().SYID} AND F.CIID_L='${LoginController().CIID}' AND  F.BIID_L=${LoginController().BIID}"
      : Wheresql6 = " AND F.JTID_L=${LoginController().JTID} "
      " AND F.SYID_L=${LoginController().SYID} AND F.CIID_L='${LoginController().CIID}'";

  sql =
  "SELECT A.*,F.BACBA,F.BACBNF,CASE WHEN ${LoginController().LAN}=2 AND B.AANE IS NOT NULL THEN B.AANE ELSE B.AANA END  AANA_D,C.SCSY"
      " FROM ACC_MOV_D A,ACC_ACC B,SYS_CUR C left join BAL_ACC_C F "
      " on A.AANO=F.AANO AND A.SCID=F.SCID $Wheresql6  WHERE A.JTID_L=${LoginController().JTID} "
      " AND A.SYID_L=${LoginController().SYID} AND A.CIID_L='${LoginController().CIID}' $Wheresql "
      " and A.AMMID=$GETAMMID AND $sqlAMKID A.AANO=B.AANO AND B.JTID_L=${LoginController().JTID} "
      " AND B.SYID_L=${LoginController().SYID} AND B.CIID_L='${LoginController().CIID}' $Wheresql2 "
      " AND A.SCID=C.SCID AND  C.JTID_L=${LoginController().JTID} "
      " AND C.SYID_L=${LoginController().SYID} AND C.CIID_L='${LoginController().CIID}' $Wheresql3";

  var result = await dbClient!.rawQuery(sql);
  List<Acc_Mov_D_Local> list = result.map((item) {
    return Acc_Mov_D_Local.fromMap(item);
  }).toList();
  return list;
}

Future<List<Acc_Mov_D_Local>> GET_ACC_MOV_D_SUM(
    String GETAMKID, String GETAMMID) async {
  var dbClient = await conn.database;
  String sql;
  String Wheresql = '';
  LoginController().BIID_ALL_V == '1'
      ? Wheresql = " AND  A.BIID_L=${LoginController().BIID}"
      : Wheresql = '';

  sql =
  "SELECT SUM(A.AMDMD) AS SUMAMDMD,SUM(AMDDA) AS SUMAMDDA,SUM(AMDEQ) AS SUMAMDEQ"
      " FROM ACC_MOV_D A  WHERE A.JTID_L=${LoginController().JTID} "
      " AND A.SYID_L=${LoginController().SYID} AND A.CIID_L='${LoginController().CIID}' $Wheresql"
      " and A.AMMID=$GETAMMID ";

  var result = await dbClient!.rawQuery(sql);
  List<Acc_Mov_D_Local> list = result.map((item) {
    return Acc_Mov_D_Local.fromMapSum(item);
  }).toList();
  return list;
}

Future<int> UpdateACC_MOV_D(
    int? GetAMKID,
    int GetAMMID,
    int GetAMDID,
    String GetAANO,
    String GetGUIDC,
    String GETACNO,
    double GetAMDMO,
    String GETAMDIN,
    String GETAMMRE,
    String GETSCID,
    String GETSCEX,
    double GetAMDEQ,
    bool TypeAMDMO) async {
  var dbClient = await conn.database;

  final data = {
    'AANO': GetAANO,
    'AMDIN': GETAMDIN,
    'ACNO': GETACNO,
    'GUIDC': GetGUIDC,
    (GetAMKID == 1 || GetAMKID == 3)
        ? 'AMDDA'
        : GetAMKID == 2
        ? 'AMDMD'
        : (GetAMKID == 15 && TypeAMDMO == true)
        ? 'AMDMD'
        : 'AMDDA': GetAMDMO,
    'AMDEQ': GetAMDEQ,
    'SCEX': GETSCEX,
    'SCID': GETSCID,
    'AMDRE': GETAMMRE
  };
  final result = await dbClient!.update('ACC_MOV_D', data,
      where: 'AMMID=$GetAMMID AND AMDID=$GetAMDID AND AMKID=$GetAMKID');
  return result;
}

Future<int> UpdateACC_MOV_M(
    int GetAMKID,
    int GetAMMID,
    String GetAMMDO,
    String GetPKID,
    int? GetACID,
    int? GetABID,
    int? GetBCCID,
    String? GETACNO,
    int? GETBDID,
    double GetAMMAM,
    double GetAMMEQ,
    String GetAMMRE,
    String GETAMMIN,
    String GETAMMCN,
    String GETSUCH,
    String GETDATEU,
    String GETDEVU) async {
  var dbClient = await conn.database;

  final data = {
    'AMMDO': GetAMMDO,
    'PKID': GetPKID,
    'ACID': GetACID,
    'ABID': GetABID,
    'BCCID': GetBCCID,
    'ACNO': GETACNO,
    'BDID': GETBDID,
    'AMMAM': GetAMMAM,
    'AMMEQ': GetAMMEQ,
    'AMMRE': GetAMMRE,
    'AMMIN': GETAMMIN,
    'AMMCN': GETAMMCN,
    'SUCH': GETSUCH,
    'DATEU': GETDATEU,
    'DEVU': GETDEVU
  };
  final result = await dbClient!
      .update('ACC_MOV_M', data, where: 'AMMID=$GetAMMID  AND AMKID=$GetAMKID');
  return result;
}

Future<int> UpdateACC_MOV_D_SCID(
    int GetAMKID, int GetAMMID, String GetSCID, String GetSCEX) async {
  var dbClient = await conn.database;

  final data = {'SCID': GetSCID, 'SCEX': GetSCEX};
  final result = await dbClient!
      .update('ACC_MOV_D', data, where: 'AMMID=$GetAMMID  AND AMKID=$GetAMKID');
  return result;
}

Future<int> DELETEACC_MOV_D( String GETAMMID) async {
  var dbClient = await conn.database;
  var sqlwhere = ' AMMID=$GETAMMID';
  return await dbClient!.delete('ACC_MOV_D', where: sqlwhere);
}

Future<Acc_Mov_M_Local> Save_ACC_MOV_M(Acc_Mov_M_Local data) async {
  var dbClient = await conn.database;
  data.BMMID = await dbClient!.insert('ACC_MOV_M', data.toMap());
  return data;
}

Future<List<Acc_Mov_M_Local>> GET_ACC_MOV_M(
    String TYPE, String GETDateNow, int? GETAMKID,int? GETAMMST,
    String BIID_F,String BIID_T,String BMMDO_F,String BMMDO_T,String SCID_V,int TYPE_SER) async {
  var dbClient = await conn.database;
  String sql;
  String sql2 = '';
  String sqlAMKID = '';
  String sqlAMKST = '';
  String Wheresql = '';
  String Wheresql2 = '';
  String Wheresql3 = '';
  String Wheresql4 = '';
  String Wheresql5 = '';
  String Wheresql6 = '';
  String Wheresql7 = '';
  String Wheresql8 = '';
  String Wheresql9 = '';
  String sqlSCID='';
  String sqlBIID2='';

  sql2=" (A.AMMDOR BETWEEN '$BMMDO_F' AND '$BMMDO_T')  AND";

  // if (TYPE == 'DateNow' || TYPE == 'FromDate') {
  //   sql2 = " A.AMMDOR like'%$GETDateNow%' AND";
  // }

  if (GETAMKID == 15) {
    sqlAMKID = " A.AMKID NOT IN (1,2,3) AND ";
  } else {
    sqlAMKID = " A.AMKID=$GETAMKID AND ";
  }

  if( GETAMMST==1){
    sqlAMKST="  A.AMMST=1 AND ";
  }else if( GETAMMST==2){
    sqlAMKST="  A.AMMST=2 AND ";
  }else if( GETAMMST==3){
    sqlAMKST="  A.AMMST=4 AND ";
  }else{
    sqlAMKST='';
  }

  if(SCID_V.isNotEmpty && SCID_V.toString()!='null'){
    sqlSCID=" AND A.SCID=$SCID_V ";
  }else{
    sqlSCID='';
  }

  if(BIID_F.isNotEmpty && BIID_F.toString()!='null' && BIID_T.isNotEmpty && BIID_T.toString()!='null'){
    sqlBIID2=" AND A.BIID2 BETWEEN $BIID_F AND $BIID_T ";
  }else{
    sqlBIID2='';
  }

  if(TYPE_SER==1){
    sql2='';
    sqlSCID='';
    sqlBIID2='';
  }

  LoginController().BIID_ALL_V == '1'
      ? Wheresql = " AND   A.BIID_L=${LoginController().BIID}"
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
  LoginController().BIID_ALL_V == '1'
      ? Wheresql5 = " AND  E.BIID_L=${LoginController().BIID}"
      : Wheresql5 = '';
  LoginController().BIID_ALL_V == '1'
      ? Wheresql6 = " AND  F.BIID_L=${LoginController().BIID}"
      : Wheresql6 = '';
  LoginController().BIID_ALL_V == '1'
      ? Wheresql7 = " AND  G.BIID_L=${LoginController().BIID}"
      : Wheresql7 = '';
  LoginController().BIID_ALL_V == '1'
      ? Wheresql8 = " AND  R.BIID_L=${LoginController().BIID}"
      : Wheresql8 = '';
  LoginController().BIID_ALL_V == '1'
      ? Wheresql9 = " AND  T.BIID_L=${LoginController().BIID}"
      : Wheresql9 = '';



  sql =
  " SELECT A.*,E.SCSY,CASE WHEN ${LoginController().LAN}=2 AND B.BINE IS NOT NULL THEN B.BINE ELSE B.BINA END  BINA_D,"
      " CASE WHEN ${LoginController().LAN}=2 AND E.SCNE IS NOT NULL THEN E.SCNE ELSE E.SCNA END  SCNA_D,"
      " CASE WHEN ${LoginController().LAN}=2 AND F.ACNE IS NOT NULL THEN F.ACNE ELSE F.ACNA END  ACNA_D,"
      " CASE WHEN ${LoginController().LAN}=2 AND G.ABNE IS NOT NULL THEN G.ABNE ELSE G.ABNA END  ABNA_D,"
      " CASE WHEN ${LoginController().LAN}=2 AND C.BCCNE IS NOT NULL THEN C.BCCNE ELSE C.BCCNE END  BCCNA_D,"
      " CASE WHEN ${LoginController().LAN}=2 AND D.PKNE IS NOT NULL THEN D.PKNE ELSE D.PKNA END  PKNA_D,"
      " (SELECT GROUP_CONCAT(CASE WHEN 1=2 AND T.AANE IS NOT NULL THEN T.AANA ELSE T.AANA END ,CHAR(10))"
      " FROM ACC_MOV_D R,ACC_ACC T WHERE (R.AANO IS NOT NULL )"
      " AND (A.AMKID=R.AMKID AND A.AMMID=R.AMMID  AND A.CIID_L=R.CIID_L AND A.JTID_L=R.JTID_L"
      " AND  A.SYID_L=R.SYID_L $Wheresql8) AND  (R.AANO=T.AANO  AND R.CIID_L=T.CIID_L AND"
      " R.JTID_L=T.JTID_L AND R.SYID_L=T.SYID_L $Wheresql9)) AS AANO_D"
      " FROM ACC_MOV_M A,BRA_INF B,PAY_KIN D,SYS_CUR E "
      " left join ACC_CAS F on (A.ACID=F.ACID  AND A.CIID_L=F.CIID_L AND A.JTID_L=F.JTID_L AND A.SYID_L=F.SYID_L $Wheresql6)"
      " left join ACC_BAN G on (A.ABID=G.ABID  AND A.CIID_L=G.CIID_L  AND A.JTID_L=G.JTID_L AND A.SYID_L=G.SYID_L $Wheresql7)"
      " left join BIL_CRE_C C on (A.BCCID=C.BCCID  AND A.CIID_L=C.CIID_L  AND A.JTID_L=C.JTID_L AND A.SYID_L=C.SYID_L $Wheresql3)"
      " WHERE $sqlAMKID $sqlAMKST $sql2 $sqlBIID2 $sqlSCID A.JTID_L=${LoginController().JTID} "
      " AND A.SYID_L=${LoginController().SYID} AND A.CIID_L='${LoginController().CIID}' $Wheresql"
      " AND (A.BIID=B.BIID AND A.CIID_L=B.CIID_L AND A.JTID_L=B.JTID_L AND A.SYID_L=B.SYID_L $Wheresql2)"
      " AND (A.SCID=E.SCID AND A.CIID_L=E.CIID_L AND A.JTID_L=E.JTID_L  AND A.SYID_L=E.SYID_L $Wheresql5)"
      " AND (D.PKID=A.PKID AND A.CIID_L=D.CIID_L AND A.JTID_L=D.JTID_L  AND A.SYID_L=D.SYID_L $Wheresql4) "
      " ORDER BY A.AMMID DESC";

  var result = await dbClient!.rawQuery(sql);
  // printLongText(sql);
  print(result);
  List<Acc_Mov_M_Local> list = result.map((item) {
    return Acc_Mov_M_Local.fromMap(item);
  }).toList();
  return list;
}

Future<List<Acc_Mov_M_Local>> GET_ACC_MOV_M_PRINT(
    int GETAMMID, int? GETAMKID) async {
  var dbClient = await conn.database;
  String sql;
  String Wheresql = '';
  String Wheresql2 = '';
  String Wheresql3 = '';
  String Wheresql4 = '';
  String Wheresql5 = '';
  String Wheresql6 = '';
  String Wheresql7 = '';
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
  LoginController().BIID_ALL_V == '1'
      ? Wheresql5 = " AND  E.BIID_L=${LoginController().BIID}"
      : Wheresql5 = '';
  LoginController().BIID_ALL_V == '1'
      ? Wheresql6 = " AND  F.BIID_L=${LoginController().BIID}"
      : Wheresql6 = '';
  LoginController().BIID_ALL_V == '1'
      ? Wheresql7 = " AND  G.BIID_L=${LoginController().BIID}"
      : Wheresql7 = '';

  sql =
  " SELECT A.*,E.SCSY,CASE WHEN ${LoginController().LAN}=2 AND B.BINE IS NOT NULL THEN B.BINE ELSE B.BINA END  BINA_D,"
      " CASE WHEN ${LoginController().LAN}=2 AND E.SCNE IS NOT NULL THEN E.SCNE ELSE E.SCNA END  SCNA_D,"
      " CASE WHEN ${LoginController().LAN}=2 AND F.ACNE IS NOT NULL THEN F.ACNE ELSE F.ACNA END  ACNA_D,"
      " CASE WHEN ${LoginController().LAN}=2 AND G.ABNE IS NOT NULL THEN G.ABNE ELSE G.ABNA END  ABNA_D,"
      " CASE WHEN ${LoginController().LAN}=2 AND C.BCCNE IS NOT NULL THEN C.BCCNE ELSE C.BCCNE END  BCCNA_D,"
      " CASE WHEN ${LoginController().LAN}=2 AND D.PKNE IS NOT NULL THEN D.PKNE ELSE D.PKNA END  PKNA_D"
      " FROM ACC_MOV_M A,BRA_INF B,PAY_KIN D,SYS_CUR E "
      " left join ACC_CAS F on A.ACID=F.ACID $Wheresql6 AND F.JTID_L=${LoginController().JTID} "
      " AND F.SYID_L=${LoginController().SYID} AND F.CIID_L='${LoginController().CIID}'"
      " left join ACC_BAN G on A.ABID=G.ABID $Wheresql7 AND G.JTID_L=${LoginController().JTID} "
      " AND G.SYID_L=${LoginController().SYID} AND G.CIID_L='${LoginController().CIID}'"
      " left join BIL_CRE_C C on A.BCCID=C.BCCID $Wheresql3 AND C.JTID_L=${LoginController().JTID} "
      " AND C.SYID_L=${LoginController().SYID} AND C.CIID_L='${LoginController().CIID}'"
      " WHERE A.AMMID=$GETAMMID  AND A.JTID_L=${LoginController().JTID} "
      " AND A.SYID_L=${LoginController().SYID} AND A.CIID_L='${LoginController().CIID}' $Wheresql"
      " AND B.BIID=A.BIID AND B.JTID_L=${LoginController().JTID} "
      " AND B.SYID_L=${LoginController().SYID} AND B.CIID_L='${LoginController().CIID}' $Wheresql2"
      " AND E.SCID=A.SCID AND E.JTID_L=${LoginController().JTID} "
      " AND E.SYID_L=${LoginController().SYID} AND E.CIID_L='${LoginController().CIID}' $Wheresql5"
      " AND D.PKID=A.PKID AND D.JTID_L=${LoginController().JTID} "
      " AND D.SYID_L=${LoginController().SYID} AND D.CIID_L='${LoginController().CIID}' $Wheresql4"
      " ORDER BY A.AMMID DESC";

  var result = await dbClient!.rawQuery(sql);
  List<Acc_Mov_M_Local> list = result.map((item) {
    return Acc_Mov_M_Local.fromMap(item);
  }).toList();
  return list;
}

Future<int> DELETEACC_MOV_M(String GETAMKID, String GETAMMID) async {
  var dbClient = await conn.database;
  return await dbClient!
      .delete('ACC_MOV_M', where: 'AMKID=$GETAMKID AND AMMID=$GETAMMID');
}

Future<List<Sys_Cur_Local>> GET_SYS_CUR_ONE() async {
  var dbClient = await conn.database;
  String sql;
  String Wheresql = '';
  LoginController().BIID_ALL_V == '1'
      ? Wheresql = " AND  A.BIID_L=${LoginController().BIID}"
      : Wheresql = '';

  sql =
  "SELECT A.*,CASE WHEN ${LoginController().LAN}=2 AND A.SCNE IS NOT NULL THEN A.SCNE ELSE A.SCNA END  SCNA_D"
      " FROM SYS_CUR A WHERE A.SCST NOT IN(2,4) AND A.JTID_L=${LoginController().JTID} "
      " AND A.SYID_L=${LoginController().SYID} AND A.CIID_L='${LoginController().CIID}' $Wheresql"
      " ORDER BY A.SCID LIMIT 1";
  var result = await dbClient!.rawQuery(sql);
  List<Sys_Cur_Local> list = result.map((item) {
    return Sys_Cur_Local.fromMap(item);
  }).toList();
  return list;
}

Future<int> DeleteACC_MOV_D_ONE(String DELAMMID, String DELAMDID) async {
  var dbClient = await conn.database;
  return await dbClient!
      .delete('ACC_MOV_D', where: 'AMMID=$DELAMMID AND AMDID=$DELAMDID');
}

Future<List<Acc_Mov_D_Local>> CountAMMAM(String GETAMMID, int GETAMKID) async {
  var dbClient = await conn.database;
  String sql;
  sql =
  "select ifnull(sum(AMDEQ),0.0) AS SUMAMDEQ,ifnull(sum(AMDDA),0.0) AS SUMAMDDA,ifnull(sum(AMDMD),0.0) AS SUMAMDMD"
      " from ACC_MOV_D where AMMID=$GETAMMID ";
  var result = await dbClient!.rawQuery(sql);
  List<Acc_Mov_D_Local> list = result.map((item) {
    return Acc_Mov_D_Local.fromMapSum(item);
  }).toList();
  return list;
}


Future<List<Acc_Mov_D_Local>> SUMAMDEQ_BYAMDTY(String GETAMMID, int GETAMDTY) async {
  var dbClient = await conn.database;
  String sql;
  sql = "select ifnull(sum(AMDEQ),0.0) AS SUMAMDEQ"
      " from ACC_MOV_D where AMMID=$GETAMMID AND AMDTY=$GETAMDTY";
  var result = await dbClient!.rawQuery(sql);
  List<Acc_Mov_D_Local> list = result.map((item) {
    return Acc_Mov_D_Local.fromMapSum(item);
  }).toList();
  return list;
}


Future<List<Acc_Acc_Local>> GET_ACC_ACC(String GETBIID, int GETAMKID) async {
  var dbClient = await conn.database;
  String sql;
  String sql2;
  String Wheresql = '';
  String WhereAMKID = '';
  String Wheresql2 = '';
  String Wheresql3 = '';
  String Wheresql4 = '';
  LoginController().BIID_ALL_V == '1'
      ? Wheresql = " AND A.BIID_L=${LoginController().BIID}"
      : Wheresql = '';
  LoginController().BIID_ALL_V == '1'
      ? Wheresql2 = " AND U.BIID_L=${LoginController().BIID}"
      : Wheresql2 = '';
  LoginController().BIID_ALL_V == '1'
      ? Wheresql3 = " AND P.BIID_L=${LoginController().BIID}"
      : Wheresql3 = '';
  LoginController().BIID_ALL_V == '1'
      ? Wheresql4 = " AND B.BIID_L=${LoginController().BIID}"
      : Wheresql4 = '';

  if (GETAMKID == 2) {
    WhereAMKID =
    ' AND (A.BIID IS NULL OR (A.BIID IS NOT NULL AND A.BIID=$GETBIID)) ';
  } else {
    WhereAMKID = '';
  }

  sql =
  "SELECT A.*,CASE WHEN ${LoginController().LAN}=2 AND A.AANE IS NOT NULL THEN A.AANE ELSE A.AANA END  AANA_D"
      " FROM ACC_ACC A,ACC_USR U WHERE (U.AANO=A.AANO) AND A.AAST!=2 AND A.AATY=2 $WhereAMKID "
      " AND U.AUIN=1 AND (U.SUID IS NOT NULL AND U.SUID=${LoginController().SUID})"
      " AND A.JTID_L=${LoginController().JTID} AND A.SYID_L=${LoginController().SYID} AND A.CIID_L=${LoginController().CIID} $Wheresql"
      " AND ( A.JTID_L=U.JTID_L AND A.SYID_L=U.SYID_L AND A.CIID_L=U.CIID_L $Wheresql2)"
      " AND (A.AASE=1 OR EXISTS (SELECT 1 FROM USR_PRI P WHERE P.SUID=${LoginController().SUID}  "
      " AND ((P.PRID=52 AND A.AASE=2) OR (P.PRID=53 AND A.AASE=3)) "
      " AND (A.JTID_L=P.JTID_L AND A.SYID_L=P.SYID_L AND A.CIID_L=P.CIID_L $Wheresql3) )) "
      " ORDER BY A.AANO";

  sql2 =
  "SELECT A.*,CASE WHEN ${LoginController().LAN}=2 AND A.AANE IS NOT NULL THEN A.AANE ELSE A.AANA END  AANA_D"
      " FROM ACC_ACC A,ACC_USR U,BIL_CUS B  WHERE A.AANO=B.AANO AND U.AANO=B.AANO AND (U.AANO=A.AANO)"
      " AND A.AAST!=2 AND A.AATY=2 AND (A.BIID IS NULL OR (A.BIID IS NOT NULL AND A.BIID=$GETBIID))"
      " AND U.AUIN=1 AND (U.SUID IS NOT NULL AND U.SUID=${LoginController().SUID})"
      " AND A.JTID_L=${LoginController().JTID} AND A.SYID_L=${LoginController().SYID} AND A.CIID_L=${LoginController().CIID} $Wheresql"
      " AND ( A.JTID_L=U.JTID_L AND A.SYID_L=U.SYID_L AND A.CIID_L=U.CIID_L $Wheresql2)"
      " AND ( A.JTID_L=B.JTID_L AND A.SYID_L=B.SYID_L AND A.CIID_L=B.CIID_L $Wheresql4)"
      " AND (A.AASE=1 OR EXISTS (SELECT 1 FROM USR_PRI P WHERE P.SUID=${LoginController().SUID}  AND P.PRID IN(52,53) "
      " AND (A.JTID_L=P.JTID_L AND A.SYID_L=P.SYID_L AND A.CIID_L=P.CIID_L $Wheresql3) )) "
      " ORDER BY A.AANO";

  final result = await dbClient!.rawQuery(GETAMKID == 3 ? sql2 : sql);
  List<Acc_Acc_Local> list = result.map((item) {
    return Acc_Acc_Local.fromMap(item);
  }).toList();
  return list;
  // return result.map((json) => Acc_Acc_Local.fromMap(json)).toList();
}

Future<List<Acc_Mov_D_Local>> GETAANOCOUNT(
    int GETAMMID, int GETAMKID, String GETAANO) async {
  var dbClient = await conn.database;
  String Wheresql = '';
  LoginController().BIID_ALL_V == '1'
      ? Wheresql = " AND BIID_L=${LoginController().BIID}"
      : Wheresql = '';
  String sql;
  sql =
  " select AANO as AANOCOUNT from ACC_MOV_D where AMMID=$GETAMMID and AMKID=$GETAMKID AND AANO='$GETAANO' AND"
      " JTID_L=${LoginController().JTID} AND SYID_L=${LoginController().SYID} AND CIID_L=${LoginController().CIID} $Wheresql";
  var result = await dbClient!.rawQuery(sql);
  List<Acc_Mov_D_Local> list = result.map((item) {
    return Acc_Mov_D_Local.fromMapSum(item);
  }).toList();
  return list;
}

Future<int> UpdateACC_MOV_M_PRINT(
    int GetAMMPR, int GetAMMST, int GetAMKID, int GetAMMID) async {
  var dbClient = await conn.database;
  final data = {'AMMPR': GetAMMPR, 'AMMST': GetAMMST};
  final result = await dbClient!.update('ACC_MOV_M', data,
      where: ' AMMID=$GetAMMID AND AMMST!=1 AND AMKID=$GetAMKID');
  return result;
}

Future<List<Sys_Cur_Local>> GET_SYS_CURVou(TYPE,GETSCID) async {
  var dbClient = await conn.database;
  String sql;
  String sql2='';
  String Wheresql = '';
  LoginController().BIID_ALL_V == '1'
      ? Wheresql = " AND  A.BIID_L=${LoginController().BIID}"
      : Wheresql = '';
  TYPE==1?sql2='A.SCID!=$GETSCID AND ':sql2='';
  sql = "SELECT A.*,CASE WHEN ${LoginController().LAN}=2 AND A.SCNE IS NOT NULL THEN A.SCNE ELSE A.SCNA END  SCNA_D"
      " FROM SYS_CUR A WHERE $sql2  A.SCST NOT IN(2,4) AND A.JTID_L=${LoginController().JTID} "
      " AND A.SYID_L=${LoginController().SYID} AND A.CIID_L='${LoginController().CIID}' $Wheresql"
      " ORDER BY A.ORDNU ";
  var result = await dbClient!.rawQuery(sql);
  List<Sys_Cur_Local> list = result.map((item) {
    return Sys_Cur_Local.fromMap(item);
  }).toList();
  return list;
}

Future<int> UpdateStateACC_MOV_M(String TypeSync, String GETAMKID,
    String GETAMMID, GETAMMST, GetFromDate, GetToDate) async {
  var dbClient = await conn.database;
  String value = '';
  String SQL = '';
  if (TypeSync == 'SyncAll') {
    value = GETAMKID != '0' ? 'AMMST!=1 AND AMKID=$GETAMKID' : 'AMMST!=1';
    SQL = "UPDATE ACC_MOV_M SET AMMST=1 where $value";
  } else if (TypeSync == 'SyncOnly') {
    value = 'AMMST!=1 and AMMID=$GETAMMID';
    SQL = "UPDATE ACC_MOV_M SET AMMST=1 where $value";
  } else if (TypeSync == 'ByDate') {
    value = "AMKID=$GETAMKID AND "
        " strftime('%Y-%m-%d', substr(AMMDOR, 7, 4) || '-' || substr(AMMDOR, 4, 2) || '-' || substr(AMMDOR, 1, 2))"
        " BETWEEN '$GetFromDate' AND '$GetToDate' AND AMMST=$GETAMMST";
    SQL = "UPDATE ACC_MOV_M SET AMMST=1 where $value";
  }
  var result = await dbClient!.rawUpdate(SQL);
  return result;
}

Future<int> UpdateStateACC_MOV_D(String TypeSync, String GETAMKID,
    String GETAMMID, int GETSYST, GETAMMST, GetFromDate, GetToDate) async {
  var dbClient = await conn.database;
  String value = '';
  String SQL = '';
  if (TypeSync == 'SyncAll') {
    value = GETSYST == 1
        ? 'AMKID=$GETAMKID AND SYST_L=2 '
        : 'AMKID=$GETAMKID AND SYST_L=0';
    SQL = "UPDATE ACC_MOV_D SET SYST_L=$GETSYST where $value";
  } else if (TypeSync == 'SyncOnly') {
    value = 'SYST_L=2 and AMMID=$GETAMMID';
    SQL = "UPDATE ACC_MOV_D SET SYST_L=$GETSYST where $value";
  } else if (TypeSync == 'ByDate') {
    SQL = "UPDATE ACC_MOV_D  SET SYST_L=$GETSYST where AMKID=$GETAMKID AND"
        " EXISTS(SELECT 1 FROM ACC_MOV_M B WHERE "
        " strftime('%Y-%m-%d', substr(B.AMMDOR, 7, 4) || '-' || substr(B.AMMDOR, 4, 2) || '-' || substr(B.AMMDOR, 1, 2))"
        " BETWEEN '$GetFromDate' AND '$GetToDate' AND B.AMMST=$GETAMMST"
        " and B.AMMID=ACC_MOV_D.AMMID)";
  }
  var result = await dbClient!.rawUpdate(SQL);
  return result;
}

Future<List<Acc_Mov_D_Local>> GET_ROWN1(
    String GetAMKID, String GetAMMID) async {
  var dbClient = await conn.database;
  String sql;
  sql =
  "select ifnull(count(1),0) AS COU from ACC_MOV_D where AMMID=$GetAMMID ";
  var result = await dbClient!.rawQuery(sql);
  List<Acc_Mov_D_Local> list = result.map((item) {
    return Acc_Mov_D_Local.fromMap(item);
  }).toList();
  return list;
}

Future<int> UpdateROWN1(int GetAMMNR, int? GetAMMID) async {
  var dbClient = await conn.database;
  final data = {'ROWN1': GetAMMNR};
  final result =
  await dbClient!.update('ACC_MOV_M', data, where: 'AMMID=$GetAMMID');
  return result;
}

Future<List<Acc_Mov_M_Local>> GET_AMMIN_M() async {
  var dbClient = await conn.database;
  String sql;
  sql = "select * from ACC_MOV_M ";
  var result = await dbClient!.rawQuery(sql);
  List<Acc_Mov_M_Local> list = result.map((item) {
    return Acc_Mov_M_Local.fromMap(item);
  }).toList();
  return list;
}

Future<List<Acc_Mov_D_Local>> GET_AMDIN_M() async {
  var dbClient = await conn.database;
  String sql;
  sql = "select * from ACC_MOV_D ";
  var result = await dbClient!.rawQuery(sql);
  List<Acc_Mov_D_Local> list = result.map((item) {
    return Acc_Mov_D_Local.fromMap(item);
  }).toList();
  return list;
}

Future<List<Sys_Cur_Local>> GET_SYS_CUR_DAT(String GETSCID) async {
  var dbClient = await conn.database;
  String sql;
  String Wheresql = '';
  LoginController().BIID_ALL_V == '1'
      ? Wheresql = " AND  A.BIID_L=${LoginController().BIID}"
      : Wheresql = '';

  sql =
  "SELECT * FROM SYS_CUR A WHERE A.SCID=$GETSCID AND A.JTID_L=${LoginController().JTID} "
      " AND A.SYID_L=${LoginController().SYID} AND A.CIID_L='${LoginController().CIID}' $Wheresql"
      " ORDER BY A.SCID LIMIT 1";
  var result = await dbClient!.rawQuery(sql);
  List<Sys_Cur_Local> list = result.map((item) {
    return Sys_Cur_Local.fromMap(item);
  }).toList();
  return list;
}

Future<List<Acc_Mov_D_Local>> GET_Acc_Mov_D_DetectApp() async {
  var dbClient = await conn.database;
  String sql;
  sql =
  "select A.AMMID from ACC_MOV_D A WHERE NOT EXISTS (SELECT 1 FROM ACC_MOV_M B WHERE A.AMMID=B.AMMID) "
      " ORDER BY A.AMMID  LIMIT 1";
  var result = await dbClient!.rawQuery(sql);
  List<Acc_Mov_D_Local> list = result.map((item) {
    return Acc_Mov_D_Local.fromMap(item);
  }).toList();
  return list;
}
