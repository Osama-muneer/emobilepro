import 'package:sqflite/sqflite.dart';
import '../Operation/models/acc_mov_m.dart';
import '../Operation/models/bif_cou_c.dart';
import '../Operation/models/bil_mov_d.dart';
import '../Operation/models/bil_mov_m.dart';
import '../Operation/models/inventory.dart';
import '../Setting/controllers/login_controller.dart';
import '../Setting/models/acc_acc.dart';
import '../Setting/models/acc_sta_d.dart';
import '../Setting/models/acc_sta_m.dart';
import '../Setting/models/bal_acc_c.dart';
import '../Setting/models/bal_acc_d.dart';
import '../Setting/models/bil_cre_c.dart';
import '../Setting/models/bil_poi.dart';
import '../Setting/models/bra_inf.dart';
import '../Setting/models/cou_inf_m.dart';
import '../Setting/models/cou_typ_m.dart';
import '../Setting/models/mat_inf.dart';
import '../Setting/models/pay_kin.dart';
import '../Setting/models/sto_inf.dart';
import '../Setting/models/sto_mov_k.dart';
import '../Setting/models/syn_log.dart';
import '../Setting/models/sys_scr.dart';
import '../Setting/models/sys_yea.dart';
import '../database/database.dart';

final conn = DatabaseHelper.instance;
double? SUM_BCCID=0.0;
int? COUNTMINO_ITEM;
int? PLUS_ITEM;
int? Minus_ITEM;
int? Equil_ITEM;
int? SUM_SMDDF_ITEM;
double? SUMSMDNO_ITEM;

Future<List<Acc_Sta_D_Local>> GET_ACC_Statement(String GETGUID) async {
  var dbClient = await conn.database;
  String sql;

  sql = "SELECT * FROM ACC_STA_D A  WHERE   A.GUID_REP='$GETGUID'  AND A.ATC14 IS NULL ORDER BY A.ASDID";
  var result = await dbClient!.rawQuery(sql);
  List<Acc_Sta_D_Local> list = result.map((item) {return Acc_Sta_D_Local.fromMap(item);}).toList();
  return list;
}

Future<List<Mat_Inf_Local>> Get_Mat_Inf_REP(String MGNO_F,String MGNO_T) async {
  var dbClient = await conn.database;
  String sql;
  String Wheresql='';
  LoginController().BIID_ALL_V=='1'? Wheresql= " AND BIID_L=${LoginController().BIID}":Wheresql='';
  MGNO_T=MGNO_T=='null'?MGNO_F:MGNO_T;
  sql ="SELECT *,CASE WHEN ${LoginController().LAN}=2 AND MINE IS NOT NULL THEN MINE ELSE MINA END  MINA_D"
      " FROM MAT_INF WHERE MGNO BETWEEN '$MGNO_F' AND '$MGNO_T' AND MIST=1"
      " AND JTID_L=${LoginController().JTID} "
      " AND SYID_L=${LoginController().SYID} AND CIID_L=${LoginController().CIID} $Wheresql ORDER BY MGNO,MINO";
  final result = await dbClient!.rawQuery(sql);
  // print(sql);
  return result.map((json) => Mat_Inf_Local.fromMap(json)).toList();
}

Future<List<Bra_Inf_Local>> GET_BRA_INF() async {
  var dbClient = await conn.database;
  String sql;
  String Wheresql='';
  String Wheresql2='';
  LoginController().BIID_ALL_V=='1'? Wheresql= " AND  A.BIID_L=${LoginController().BIID}":Wheresql='';
  LoginController().BIID_ALL_V=='1'? Wheresql2= " AND  B.BIID_L=${LoginController().BIID}":Wheresql2='';

  sql = "SELECT *,CASE WHEN ${LoginController().LAN}=2 AND BINE IS NOT NULL THEN BINE ELSE BINA END  BINA_D"
      " FROM BRA_INF A WHERE A.BIST=1  AND A.JTID_L=${LoginController().JTID} "
      "AND A.SYID_L=${LoginController().SYID} AND A.CIID_L='${LoginController().CIID}' $Wheresql"
      " AND EXISTS(SELECT 1 FROM SYS_USR_B B WHERE B.BIID IS NOT NULL "
      " AND B.BIID=A.BIID AND B.SUID IS NOT NULL AND B.SUID=${LoginController().SUID} AND B.SUBST=1 AND B.SUBIN=1"
      " AND B.JTID_L=${LoginController().JTID} "
      " AND B.SYID_L=${LoginController().SYID} AND B.CIID_L='${LoginController().CIID}' $Wheresql2) "
      " ORDER BY A.BIID";
  var result = await dbClient!.rawQuery(sql);
  List<Bra_Inf_Local> list = result.map((item) {
    return Bra_Inf_Local.fromMap(item);
  }).toList();
  return list;
}
Future<List<Bil_Poi_Local>> GET_BIL_POI(String GETBIID_F,String GETBIID_T) async {
  var dbClient = await conn.database;
  String sql;
  String Wheresql='';
  String Wheresql2='';
  LoginController().BIID_ALL_V=='1'? Wheresql= " AND  A.BIID_L=${LoginController().BIID}":Wheresql='';
  LoginController().BIID_ALL_V=='1'? Wheresql2= " AND  B.BIID_L=${LoginController().BIID}":Wheresql2='';

  sql = "SELECT *,CASE WHEN ${LoginController().LAN}=2 AND A.BPNE IS NOT NULL THEN A.BPNE ELSE A.BPNA END  BPNA_D"
      " FROM BIL_POI A WHERE A.BIID BETWEEN $GETBIID_F AND $GETBIID_T AND A.BPST=1"
      " AND A.BPID IN(SELECT B.BPID FROM BIL_POI_U B WHERE  B.BPUST=1 AND  B.BPUTY IN(1,3)  AND  B.BPUUS='${LoginController().SUID}' "
      " AND B.JTID_L=${LoginController().JTID} AND B.SYID_L=${LoginController().SYID} AND "
      " B.CIID_L='${LoginController().CIID}' $Wheresql2 GROUP BY BPID) AND A.JTID_L=${LoginController().JTID} "
      " AND A.SYID_L=${LoginController().SYID} AND A.CIID_L='${LoginController().CIID}' $Wheresql "
      " ORDER BY A.BPID ";
  var result = await dbClient!.rawQuery(sql);
  List<Bil_Poi_Local> list = result.map((item) {
    return Bil_Poi_Local.fromMap(item);
  }).toList();
  return list;
}

Future<List<Pay_Kin_Local>> GET_PAY_KIN(String UPIN_PKID) async {
  var dbClient = await conn.database;
  String sql;
  String sql2='';
  String Wheresql='';
  UPIN_PKID=='1'?sql2=' A.PKID IN (1,3,8)':sql2=' A.PKID IN (1,8)';
  LoginController().BIID_ALL_V=='1'? Wheresql= " AND  A.BIID_L=${LoginController().BIID}":Wheresql='';

  sql = "SELECT *,CASE WHEN ${LoginController().LAN}=2 AND A.PKNE IS NOT NULL THEN A.PKNE ELSE A.PKNA END  PKNA_D"
      " FROM PAY_KIN A WHERE $sql2 AND  A.JTID_L=${LoginController().JTID} "
      " AND A.SYID_L=${LoginController().SYID} AND A.CIID_L='${LoginController().CIID}' $Wheresql"
      " ORDER BY A.PKID ";
  var result = await dbClient!.rawQuery(sql);
  List<Pay_Kin_Local> list = result.map((item) {
    return Pay_Kin_Local.fromMap(item);
  }).toList();
  return list;
}

Future<List<Sys_Scr_Local>> GET_SYS_SCR(GETWHERE) async {
  var dbClient = await conn.database;
  String sql;
  String sql2='';
  String WhereSql=" ";
  LoginController().BIID_ALL_V=='1'? sql2= " AND  A.BIID_L=${LoginController().BIID}":sql2='';
  LoginController().BIID_ALL_V=='1'? WhereSql= " AND B.BIID_L=A.BIID_L":WhereSql='';
  sql = "SELECT A.SSID,CASE WHEN ${LoginController().LAN}=2 AND A.SSDE IS NOT NULL THEN A.SSDE ELSE A.SSDA END  SSNA_D"
      " FROM SYS_SCR A WHERE  $GETWHERE  AND A.JTID_L=${LoginController().JTID} "
      " AND A.SYID_L=${LoginController().SYID} AND A.CIID_L=${LoginController().CIID} $sql2 "
      " AND EXISTS(SELECT 1 FROM USR_PRI B WHERE B.SUID='${LoginController().SUID}' AND A.SSID=B.PRID "
      " AND ( B.CIID_L=A.CIID_L AND B.JTID_L=A.JTID_L "
      " AND B.SYID_L=A.SYID_L  $WhereSql)) order by SSID DESC";
  var result = await dbClient!.rawQuery(sql);
 print(result);
 print('GET_SYS_SCR');
  List<Sys_Scr_Local> list = result.map((item) {
    return Sys_Scr_Local.fromMap(item);
  }).toList();
  return list;
}

Future<List<Sys_Scr_Local>> GET_SYS_SCR2() async {
  var dbClient = await conn.database;
  String sql;
  String sql2='';
  String WhereSql=" ";
  LoginController().BIID_ALL_V=='1'? sql2= " AND  A.BIID_L=${LoginController().BIID}":sql2='';
  LoginController().BIID_ALL_V=='1'? WhereSql= " AND B.BIID_L=A.BIID_L":WhereSql='';
  sql = "SELECT A.SSID,CASE WHEN ${LoginController().LAN}=2 AND A.SSDE IS NOT NULL THEN A.SSDE ELSE A.SSDA END  SSNA_D"
      " FROM SYS_SCR A WHERE  A.SSID=202 AND A.JTID_L=${LoginController().JTID} "
      " AND A.SYID_L=${LoginController().SYID} AND A.CIID_L=${LoginController().CIID} $sql2 "
      " AND EXISTS(SELECT 1 FROM USR_PRI B WHERE B.SUID='${LoginController().SUID}' AND A.SSID=B.PRID "
      " AND ( B.CIID_L=A.CIID_L AND B.JTID_L=A.JTID_L "
      " AND B.SYID_L=A.SYID_L  $WhereSql)) order by SSID DESC";
  var result = await dbClient!.rawQuery(sql);
  print(result);
  print('GET_SYS_SCR');
  List<Sys_Scr_Local> list = result.map((item) {
    return Sys_Scr_Local.fromMap(item);
  }).toList();
  return list;
}

Future<List<Acc_Acc_Local>> query_Acc_Acc(String GETBIID,String GETSCID) async {
  var dbClient = await conn.database;
  String sql;
  String sql2='';
  String sql3='';
  String sql4='';
  String Wheresql='';
  String Wheresql2='';
  String Wheresql3='';
  String Wheresql4='';
  String Wheresql5='';
  String Wheresql6='';
  LoginController().BIID_ALL_V=='1'? Wheresql= " AND A.BIID_L=${LoginController().BIID}":Wheresql='';
  LoginController().BIID_ALL_V=='1'? Wheresql2= " AND B.BIID_L=${LoginController().BIID}":Wheresql2='';
  LoginController().BIID_ALL_V=='1'? Wheresql3= " AND C.BIID_L=A.BIID_L":Wheresql3='';
  LoginController().BIID_ALL_V=='1'? Wheresql4= " AND D.BIID_L=${LoginController().BIID}":Wheresql4='';
  LoginController().BIID_ALL_V=='1'? Wheresql5= " AND F.BIID_L=${LoginController().BIID}":Wheresql5='';
  LoginController().BIID_ALL_V=='1'? Wheresql6= " AND H.BIID_L=A.BIID_L":Wheresql6='';

  if(GETSCID=='208'){
  sql2=" AND EXISTS(SELECT 1 FROM BIL_CUS C WHERE A.AANO=C.AANO  AND C.JTID_L=A.JTID_L "
      " AND C.SYID_L=A.SYID_L AND C.CIID_L=A.CIID_L $Wheresql3) ";
  }
  else if(GETSCID=='206'){
  sql2=" AND EXISTS(SELECT 1 FROM BIL_IMP C WHERE A.AANO=C.AANO  AND C.JTID_L=A.JTID_L "
      " AND C.SYID_L=A.SYID_L AND C.CIID_L=A.CIID_L $Wheresql3)";
  }
  else if(GETSCID=='207'){
  sql2=" AND (A.AANO IN(SELECT AANO FROM ACC_CAS) OR "
      " A.AANO IN(SELECT AANO FROM ACC_BAN) OR AANO IN(SELECT AANO FROM BIL_DIS)"
       " OR A.AANO IN(SELECT AANO FROM BIL_CRE_C) OR A.AANO IN(SELECT AANO FROM BIL_POI))"
       " AND NOT EXISTS(SELECT 1 FROM BIL_IMP C WHERE A.AANO=C.AANO  AND C.JTID_L=A.JTID_L "
      " AND C.SYID_L=A.SYID_L AND C.CIID_L=A.CIID_L $Wheresql3)"
      " AND NOT EXISTS(SELECT 1 FROM BIL_CUS D WHERE A.AANO=D.AANO  AND D.JTID_L=${LoginController().JTID} "
      " AND D.SYID_L=${LoginController().SYID} AND D.CIID_L=${LoginController().CIID} $Wheresql4)";
  }

  if(GETSCID=='203'){
    sql3='A.AATY=1';
    sql4=''' AND EXISTS(SELECT 1 FROM ACC_ACC H WHERE H.AATY=2 AND H.AAFN=A.AANO AND H.JTID_L=A.JTID_L
     AND H.SYID_L=A.SYID_L AND H.CIID_L=A.CIID_L $Wheresql6) ''';
  }else{
    sql3='A.AATY=2';
    sql4=' ';
  }

    sql ="SELECT *,CASE WHEN ${LoginController().LAN}=2 AND A.AANE IS NOT NULL THEN A.AANE ELSE A.AANA END  AANA_D"
        " FROM ACC_ACC A WHERE  $sql3   $sql2 "
        " AND A.JTID_L=${LoginController().JTID} "
        " AND A.SYID_L=${LoginController().SYID} AND A.CIID_L='${LoginController().CIID}' $Wheresql $sql4"
        " AND  (A.AASE=1 OR EXISTS (SELECT CASE WHEN R.PRID=52 THEN 2 WHEN R.PRID=53 THEN 3 END AASE FROM USR_PRI R "
        " WHERE R.SUID='${LoginController().SUID}' AND R.PRID IN(52,53) )) "
        " AND EXISTS(SELECT 1 FROM ACC_USR B WHERE B.AANO=A.AANO AND B.AUOU=1 AND B.SUID='${LoginController().SUID}' "
        " AND B.JTID_L=${LoginController().JTID} "
        " AND B.SYID_L=${LoginController().SYID} AND B.CIID_L='${LoginController().CIID}' $Wheresql2)"
        " AND(A.BIID IS NULL OR A.BIID IN(SELECT BIID FROM SYS_USR_B F WHERE F.SUID='${LoginController().SUID}'"
        " AND F.SUBST=1 AND( F.SUBIN=1 OR F.SUBPR=1)   AND F.JTID_L=${LoginController().JTID} "
        " AND F.SYID_L=${LoginController().SYID} AND F.CIID_L='${LoginController().CIID}' $Wheresql5)) "
        " ORDER BY A.AANO ";

  final result = await dbClient!.rawQuery(sql);
  print(sql);
  print(result);
  print('query_Acc_Acc');
  return result.map((json) => Acc_Acc_Local.fromMap(json)).toList();
}

Future<List<Acc_Mov_M_Local>> GET_ACC_MOV_REP(String GETBIID_F,String GETBIID_T,String GETAMMDO_F,String GETAMMDO_T,
    String GETSCID,String GETPKID,String GETAANO_D,String GETDATE_F,String GETDATE_T,String ORD_BY,
    String ORD_BY2) async {
  var dbClient = await conn.database;
  String sql;
  String Wheresql='';
  String SCIDsql='';
  String PKIDsql='';
  String DATEIsql='';
  String OrdSql='';
  String Ord2Sql='';
  (GETDATE_F.isEmpty || GETDATE_F=='null' || GETDATE_T.isEmpty || GETDATE_T=='null') ?
  DATEIsql= "":DATEIsql= "  AND (A.DATEI BETWEEN '$GETDATE_F 00:00' AND '$GETDATE_T 23:59') ";

  (GETSCID.isEmpty || GETSCID=='null')? SCIDsql= "":SCIDsql= "  AND  A.SCID=$GETSCID";
  (GETPKID.isEmpty || GETPKID=='null')? PKIDsql= "":PKIDsql= "  AND  A.PKID=$GETPKID";

  if(ORD_BY=='1'){
    OrdSql=' ORDER BY A.BIID ';
  }else if(ORD_BY=='2') {
    OrdSql = ' ORDER BY A.AMKID ';
  }else if(ORD_BY=='3') {
    OrdSql = ' ORDER BY A.AMMNO ';
  }else if(ORD_BY=='4') {
    OrdSql = ' ORDER BY A.AMMDO ';
  }else if(ORD_BY=='5') {
    OrdSql = ' ORDER BY A.SIID ';
  }else if(ORD_BY=='6') {
    OrdSql = ' ORDER BY A.AMMAM ';
  }

  ORD_BY2=='2'?Ord2Sql='DESC':Ord2Sql='ASC';


  sql="SELECT A.BIID,A.AMMID,A.AMKID,A.AMMNO,A.AMMDO,A.SCID,A.AMMAM,A.PKID,A.AMMST,A.AMMDOR,A.DATEI,A.AMMIN,E.SCSY, "
      " CASE WHEN 1=2 AND B.BINE IS NOT NULL THEN B.BINE ELSE B.BINA END  BINA_D, "
  " CASE WHEN ${LoginController().LAN}=2 AND E.SCNE IS NOT NULL THEN E.SCNE ELSE E.SCNA END  SCNA_D, "
  " CASE WHEN ${LoginController().LAN}=2 AND F.ACNE IS NOT NULL THEN F.ACNE ELSE F.ACNA END  ACNA_D, "
  " CASE WHEN ${LoginController().LAN}=2 AND G.ABNE IS NOT NULL THEN G.ABNE ELSE G.ABNA END  ABNA_D, "
  " CASE WHEN ${LoginController().LAN}=2 AND C.BCCNE IS NOT NULL THEN C.BCCNE ELSE C.BCCNE END  BCCNA_D, "
  "  CASE WHEN ${LoginController().LAN}=2 AND D.PKNE IS NOT NULL THEN D.PKNE ELSE D.PKNA END  PKNA_D, "
  " ( SELECT  "
  " GROUP_CONCAT(CASE WHEN ${LoginController().LAN}=2 AND T.AANE IS NOT NULL THEN T.AANA ELSE T.AANA END ,CHAR(10)) "
  " FROM ACC_MOV_D R,ACC_ACC T WHERE (R.AANO IS NOT NULL ) "
  " AND (A.AMKID=R.AMKID AND A.AMMID=R.AMMID  AND A.CIID_L=R.CIID_L AND A.JTID_L=R.JTID_L AND A.BIID_L=R.BIID_L  AND A.SYID_L=R.SYID_L) "
  " AND  (R.AANO=T.AANO  AND R.CIID_L=T.CIID_L AND R.JTID_L=T.JTID_L AND R.BIID_L=T.BIID_L  AND R.SYID_L=T.SYID_L) "
  " ) AS AANO_D ,( SELECT  T.AANO FROM ACC_MOV_D R,ACC_ACC T WHERE (R.AANO IS NOT NULL ) "
  " AND (A.AMKID=R.AMKID AND A.AMMID=R.AMMID  AND A.CIID_L=R.CIID_L AND A.JTID_L=R.JTID_L AND A.BIID_L=R.BIID_L  AND A.SYID_L=R.SYID_L) "
  " AND  (R.AANO=T.AANO  AND R.CIID_L=T.CIID_L AND R.JTID_L=T.JTID_L AND R.BIID_L=T.BIID_L  AND R.SYID_L=T.SYID_L) "
  " ) AS AANO FROM ACC_MOV_M A,BRA_INF B,SYS_CUR E "
  " left join ACC_CAS F on (A.ACID=F.ACID  AND A.CIID_L=F.CIID_L  AND A.JTID_L=F.JTID_L AND A.BIID_L=F.BIID_L AND A.SYID_L=F.SYID_L) "
  " left join ACC_BAN G on (A.ABID=G.ABID  AND A.CIID_L=G.CIID_L  AND A.JTID_L=G.JTID_L AND A.BIID_L=G.BIID_L  AND A.SYID_L=G.SYID_L) "
  " left join BIL_CRE_C C on (A.BCCID=C.BCCID  AND A.CIID_L=C.CIID_L  AND A.JTID_L=C.JTID_L AND A.BIID_L=C.BIID_L  AND A.SYID_L=C.SYID_L) "
  " left join PAY_KIN D on (A.PKID=D.PKID  AND A.CIID_L=D.CIID_L  AND A.JTID_L=D.JTID_L AND A.BIID_L=D.BIID_L  AND A.SYID_L=D.SYID_L) "
  " WHERE A.BIID BETWEEN $GETBIID_F AND $GETBIID_T AND  AANO_D LIKE '%$GETAANO_D%' and "
  " strftime('%Y-%m-%d', substr(A.AMMDOR, 7, 4) || '-' || substr(A.AMMDOR, 4, 2) || '-' || substr(A.AMMDOR, 1, 2))"
  " BETWEEN '$GETAMMDO_F' AND '$GETAMMDO_T' $DATEIsql $SCIDsql $PKIDsql AND  "
      " (A.CIID_L='${LoginController().CIID}'  AND A.JTID_L=${LoginController().JTID} AND A.SYID_L=${LoginController().SYID} $Wheresql ) "
  " AND (A.BIID=B.BIID AND A.CIID_L=B.CIID_L AND A.JTID_L=B.JTID_L  AND A.BIID_L=B.BIID_L AND A.SYID_L=B.SYID_L) "
  " AND (A.PKID=D.PKID AND A.CIID_L=D.CIID_L AND A.JTID_L=D.JTID_L AND A.BIID_L=D.BIID_L AND A.SYID_L=D.SYID_L) "
  " AND (A.SCID=E.SCID AND A.CIID_L=E.CIID_L AND A.JTID_L=E.JTID_L AND A.BIID_L=E.BIID_L  AND A.SYID_L=E.SYID_L) "
  " $OrdSql $Ord2Sql ";

  var result = await dbClient!.rawQuery(sql);
  List<Acc_Mov_M_Local> list = result.map((item) {
    return Acc_Mov_M_Local.fromMap(item);
  }).toList();
  // INSERT_SYN_LOG(sql,'e.error','D');
   print(sql);
  return list;
}


Future<List<Acc_Mov_M_Local>> GET_ACC_MOV_SUM_REP(String GETBIID_F,String GETBIID_T,String GETAMMDO_F,String GETAMMDO_T,
    String GETSCID,String GETPKID,String GETAANO_D,String GETDATE_F,String GETDATE_T) async {
  var dbClient = await conn.database;
  String sql;
  String Wheresql='';
  String SCIDsql='';
  String PKIDsql='';
  String DATEIsql='';

  (GETDATE_F.isEmpty || GETDATE_F=='null' || GETDATE_T.isEmpty || GETDATE_T=='null') ?
  DATEIsql= "":DATEIsql= "  AND (A.DATEI BETWEEN '$GETDATE_F 00:00' AND '$GETDATE_T 23:59') ";
  (GETSCID.isEmpty || GETSCID=='null')? SCIDsql= "":SCIDsql= "  AND  A.SCID=$GETSCID";
  (GETPKID.isEmpty || GETPKID=='null')? PKIDsql= "":PKIDsql= "  AND  A.PKID=$GETPKID";
  LoginController().BIID_ALL_V=='1'? Wheresql= " AND  A.BIID_L=${LoginController().BIID}": Wheresql='';

  sql="SELECT ifnull(SUM(AMMAM),0.0) AS AMMAM,A.AMKID,A.SCID, "
      " CASE WHEN 1=2 AND B.BINE IS NOT NULL THEN B.BINE ELSE B.BINA END  BINA_D, "
      " CASE WHEN ${LoginController().LAN}=2 AND E.SCNE IS NOT NULL THEN E.SCNE ELSE E.SCNA END  SCNA_D, "
      " CASE WHEN ${LoginController().LAN}=2 AND F.ACNE IS NOT NULL THEN F.ACNE ELSE F.ACNA END  ACNA_D, "
      " CASE WHEN ${LoginController().LAN}=2 AND G.ABNE IS NOT NULL THEN G.ABNE ELSE G.ABNA END  ABNA_D, "
      " CASE WHEN ${LoginController().LAN}=2 AND C.BCCNE IS NOT NULL THEN C.BCCNE ELSE C.BCCNE END  BCCNA_D, "
      "  CASE WHEN ${LoginController().LAN}=2 AND D.PKNE IS NOT NULL THEN D.PKNE ELSE D.PKNA END  PKNA_D, "
      " ( SELECT  "
      " GROUP_CONCAT(CASE WHEN ${LoginController().LAN}=2 AND T.AANE IS NOT NULL THEN T.AANA ELSE T.AANA END ,CHAR(10)) "
      " FROM ACC_MOV_D R,ACC_ACC T WHERE (R.AANO IS NOT NULL ) "
      " AND (A.AMKID=R.AMKID AND A.AMMID=R.AMMID  AND A.CIID_L=R.CIID_L AND A.JTID_L=R.JTID_L AND A.BIID_L=R.BIID_L  AND A.SYID_L=R.SYID_L) "
      " AND  (R.AANO=T.AANO  AND R.CIID_L=T.CIID_L AND R.JTID_L=T.JTID_L AND R.BIID_L=T.BIID_L  AND R.SYID_L=T.SYID_L) "
      " ) AS AANO_D ,( SELECT  T.AANO FROM ACC_MOV_D R,ACC_ACC T WHERE (R.AANO IS NOT NULL ) "
      " AND (A.AMKID=R.AMKID AND A.AMMID=R.AMMID  AND A.CIID_L=R.CIID_L AND A.JTID_L=R.JTID_L AND A.BIID_L=R.BIID_L  AND A.SYID_L=R.SYID_L) "
      " AND  (R.AANO=T.AANO  AND R.CIID_L=T.CIID_L AND R.JTID_L=T.JTID_L AND R.BIID_L=T.BIID_L  AND R.SYID_L=T.SYID_L) "
      " ) AS AANO FROM ACC_MOV_M A,BRA_INF B,SYS_CUR E "
      " left join ACC_CAS F on (A.ACID=F.ACID  AND A.CIID_L=F.CIID_L  AND A.JTID_L=F.JTID_L AND A.BIID_L=F.BIID_L AND A.SYID_L=F.SYID_L) "
      " left join ACC_BAN G on (A.ABID=G.ABID  AND A.CIID_L=G.CIID_L  AND A.JTID_L=G.JTID_L AND A.BIID_L=G.BIID_L  AND A.SYID_L=G.SYID_L) "
      " left join BIL_CRE_C C on (A.BCCID=C.BCCID  AND A.CIID_L=C.CIID_L  AND A.JTID_L=C.JTID_L AND A.BIID_L=C.BIID_L  AND A.SYID_L=C.SYID_L) "
      " left join PAY_KIN D on (A.PKID=D.PKID  AND A.CIID_L=D.CIID_L  AND A.JTID_L=D.JTID_L AND A.BIID_L=D.BIID_L  AND A.SYID_L=D.SYID_L) "
      " WHERE A.BIID BETWEEN $GETBIID_F AND $GETBIID_T AND  AANO_D LIKE '%$GETAANO_D%' and "
      " strftime('%Y-%m-%d', substr(A.AMMDOR, 7, 4) || '-' || substr(A.AMMDOR, 4, 2) || '-' || substr(A.AMMDOR, 1, 2))"
      " BETWEEN '$GETAMMDO_F' AND '$GETAMMDO_T' $DATEIsql $SCIDsql $PKIDsql AND  "
      " (A.CIID_L='${LoginController().CIID}'  AND A.JTID_L=${LoginController().JTID} AND A.SYID_L=${LoginController().SYID} $Wheresql ) "
      " AND (A.BIID=B.BIID AND A.CIID_L=B.CIID_L AND A.JTID_L=B.JTID_L  AND A.BIID_L=B.BIID_L AND A.SYID_L=B.SYID_L) "
      " AND (A.PKID=D.PKID AND A.CIID_L=D.CIID_L AND A.JTID_L=D.JTID_L AND A.BIID_L=D.BIID_L AND A.SYID_L=D.SYID_L) "
      " AND (A.SCID=E.SCID AND A.CIID_L=E.CIID_L AND A.JTID_L=E.JTID_L AND A.BIID_L=E.BIID_L  AND A.SYID_L=E.SYID_L) "
      " GROUP BY A.CIID_L,A.JTID_L,A.BIID_L,A.SYID_L,A.AMKID,A.SCID ";

  var result = await dbClient!.rawQuery(sql);
  List<Acc_Mov_M_Local> list = result.map((item) {
    return Acc_Mov_M_Local.fromMap(item);
  }).toList();
  return list;
}

Future<List<Bil_Mov_M_Local>> GET_BIL_MOV_REP(String GETBIID_F,String GETBIID_T,String GETBMMDO_F,String GETBMMDO_T,
    String GETSCID,String GETPKID,String GETDATE_F,String GETDATE_T,String ORD_BY,
String ORD_BY2)
async {
  var dbClient = await conn.database;
  String sql;
  String SCIDsql='';
  String DATEIsql='';
  String PKIDsql='';
  String Wheresql='';
  String Wheresql2='';
  String Wheresql6='';
  String Wheresql7='';
  String OrdSql='';
  String Ord2Sql='';
  (GETDATE_F.isEmpty || GETDATE_F=='null' || GETDATE_T.isEmpty || GETDATE_T=='null') ?
  DATEIsql= "":DATEIsql= "  AND (A.DATEI BETWEEN '$GETDATE_F 00:00' AND '$GETDATE_T 23:59') ";

  (GETSCID.isEmpty || GETSCID=='null')? SCIDsql= "":SCIDsql= "  AND  A.SCID=$GETSCID";
  (GETPKID.isEmpty || GETPKID=='null')? PKIDsql= "":PKIDsql= "  AND  A.PKID=$GETPKID";
  LoginController().BIID_ALL_V=='1'? Wheresql= " AND  A.BIID_L=${LoginController().BIID}":Wheresql='';
  LoginController().BIID_ALL_V=='1'? Wheresql2= " AND  B.BIID_L=${LoginController().BIID}":Wheresql2='';
  LoginController().BIID_ALL_V=='1'? Wheresql6= " AND  F.BIID_L=${LoginController().BIID}":Wheresql6='';
  LoginController().BIID_ALL_V=='1'? Wheresql7= " AND  G.BIID_L=${LoginController().BIID}":Wheresql7='';

  if(ORD_BY=='1'){
    OrdSql=' ORDER BY BIID ';
  }else if(ORD_BY=='2') {
    OrdSql = ' ORDER BY BMKID ';
  }else if(ORD_BY=='3') {
    OrdSql = ' ORDER BY BMMNO ';
  }else if(ORD_BY=='4') {
    OrdSql = ' ORDER BY BMMDO ';
  }else if(ORD_BY=='5') {
    OrdSql = ' ORDER BY SIID ';
  }else if(ORD_BY=='6') {
    OrdSql = ' ORDER BY BMMMT ';
  }

  ORD_BY2=='2'?Ord2Sql='DESC':Ord2Sql='ASC';


  sql = "SELECT BMMID,BMKID,BMMNO,BMMRE,BMMDO,BMMAM,BMMDI,BMMTX,BMMDIF,BMMMT,BMMNA,BMMST,A.DATEI,A.BIID,A.BCID"
      ",CASE WHEN ${LoginController().LAN}=2 AND B.BINE IS NOT NULL THEN B.BINE ELSE B.BINA END  BINA_D, "
      " CASE WHEN ${LoginController().LAN}=2 AND F.SCNE IS NOT NULL THEN F.SCNE ELSE F.SCNA END  SCNA_D,"
      " CASE WHEN ${LoginController().LAN}=2 AND G.PKNE IS NOT NULL THEN G.PKNE ELSE G.PKNA END  PKNA_D "
      " FROM BIL_MOV_M A,BRA_INF B ,SYS_CUR F,PAY_KIN G WHERE "
      " A.BIID2 BETWEEN $GETBIID_F AND $GETBIID_T AND A.BMMDOR BETWEEN '$GETBMMDO_F' AND '$GETBMMDO_T' $DATEIsql "
      "  $SCIDsql $PKIDsql  AND A.JTID_L=${LoginController().JTID} "
      "  AND A.SYID_L=${LoginController().SYID} AND A.CIID_L='${LoginController().CIID}' $Wheresql"
      " AND B.BIID=A.BIID2  AND B.JTID_L=${LoginController().JTID} "
      " AND B.SYID_L=${LoginController().SYID} AND B.CIID_L='${LoginController().CIID}' $Wheresql2"
      " AND F.SCID=A.SCID AND  F.JTID_L=${LoginController().JTID} "
      " AND F.SYID_L=${LoginController().SYID} AND F.CIID_L='${LoginController().CIID}' $Wheresql6"
      " AND G.PKID=A.PKID AND  G.JTID_L=${LoginController().JTID} "
      " AND G.SYID_L=${LoginController().SYID} AND G.CIID_L='${LoginController().CIID}' $Wheresql7"
      " UNION ALL "
      " SELECT BMMID,BMKID,BMMNO,BMMRE,BMMDO,BMMAM,BMMDI,BMMTX,BMMDIF,BMMMT,BMMNA,BMMST,A.DATEI,A.BIID,A.BCID"
      ",CASE WHEN ${LoginController().LAN}=2 AND B.BINE IS NOT NULL THEN B.BINE ELSE B.BINA END  BINA_D, "
      " CASE WHEN ${LoginController().LAN}=2 AND F.SCNE IS NOT NULL THEN F.SCNE ELSE F.SCNA END  SCNA_D,"
      " CASE WHEN ${LoginController().LAN}=2 AND G.PKNE IS NOT NULL THEN G.PKNE ELSE G.PKNA END  PKNA_D "
      " FROM BIF_MOV_M A,BRA_INF B ,SYS_CUR F,PAY_KIN G WHERE "
      " A.BIID2 BETWEEN $GETBIID_F AND $GETBIID_T AND A.BMMDOR BETWEEN '$GETBMMDO_F' AND '$GETBMMDO_T' $DATEIsql "
      "  $SCIDsql $PKIDsql  AND A.JTID_L=${LoginController().JTID} "
      "  AND A.SYID_L=${LoginController().SYID} AND A.CIID_L='${LoginController().CIID}' $Wheresql"
      " AND B.BIID=A.BIID2  AND B.JTID_L=${LoginController().JTID} "
      " AND B.SYID_L=${LoginController().SYID} AND B.CIID_L='${LoginController().CIID}' $Wheresql2"
      " AND F.SCID=A.SCID AND  F.JTID_L=${LoginController().JTID} "
      " AND F.SYID_L=${LoginController().SYID} AND F.CIID_L='${LoginController().CIID}' $Wheresql6"
      " AND G.PKID=A.PKID AND  G.JTID_L=${LoginController().JTID} "
      " AND G.SYID_L=${LoginController().SYID} AND G.CIID_L='${LoginController().CIID}' $Wheresql7"
      " $OrdSql  $Ord2Sql ";
  var result = await dbClient!.rawQuery(sql);
  List<Bil_Mov_M_Local> list = result.map((item) {
    return Bil_Mov_M_Local.fromMap(item);
  }).toList();
  return list;
}

Future<List<Bil_Mov_M_Local>> GET_BIL_MOV_REP_SUM(String GETBIID_F,String GETBIID_T,String GETBMMDO_F,String GETBMMDO_T,
    String GETSCID,String GETPKID,String GETDATE_F,String GETDATE_T) async {
  var dbClient = await conn.database;
  String sql;
  String SCIDsql='';
  String PKIDsql='';
  String DATEIsql='';
  String Wheresql='';
  String Wheresql6='';

  (GETDATE_F.isEmpty || GETDATE_F=='null' || GETDATE_T.isEmpty || GETDATE_T=='null') ?
  DATEIsql= "":DATEIsql= "  AND (A.DATEI BETWEEN '$GETDATE_F 00:00' AND '$GETDATE_T 23:59') ";

  LoginController().BIID_ALL_V=='1'? Wheresql6= " AND  F.BIID_L=${LoginController().BIID}":Wheresql6='';
  (GETSCID.isEmpty || GETSCID=='null')? SCIDsql= "":SCIDsql= "  AND  A.SCID=$GETSCID";
  (GETPKID.isEmpty || GETPKID=='null')? PKIDsql= "":PKIDsql= "  AND  A.PKID=$GETPKID";
  LoginController().BIID_ALL_V=='1'? Wheresql= " AND  A.BIID_L=${LoginController().BIID}":Wheresql='';

  sql = "SELECT ifnull(SUM(BMMMT),0.0) AS BMMMT,A.BMKID,"
      " CASE WHEN ${LoginController().LAN}=2 AND F.SCNE IS NOT NULL THEN F.SCNE ELSE F.SCNA END  SCNA_D"
      " FROM BIL_MOV_M A,SYS_CUR F WHERE "
      " A.BIID2 BETWEEN $GETBIID_F AND $GETBIID_T AND A.BMMDOR BETWEEN '$GETBMMDO_F' AND '$GETBMMDO_T' $DATEIsql"
      "  $SCIDsql $PKIDsql  AND A.JTID_L=${LoginController().JTID} "
      "  AND A.SYID_L=${LoginController().SYID} AND A.CIID_L='${LoginController().CIID}' $Wheresql"
      " AND F.SCID=A.SCID AND  F.JTID_L=${LoginController().JTID} "
      " AND F.SYID_L=${LoginController().SYID} AND F.CIID_L='${LoginController().CIID}' $Wheresql6"
      " GROUP BY A.CIID_L,A.JTID_L,A.BIID_L,A.SYID_L,A.BMKID,A.SCID"
      " UNION ALL "
      " SELECT ifnull(SUM(BMMMT),0.0) AS BMMMT,A.BMKID,"
      " CASE WHEN ${LoginController().LAN}=2 AND F.SCNE IS NOT NULL THEN F.SCNE ELSE F.SCNA END  SCNA_D"
      " FROM BIF_MOV_M A,SYS_CUR F WHERE "
      " A.BIID2 BETWEEN $GETBIID_F AND $GETBIID_T AND A.BMMDOR BETWEEN '$GETBMMDO_F' AND '$GETBMMDO_T' $DATEIsql"
      "  $SCIDsql $PKIDsql  AND A.JTID_L=${LoginController().JTID} "
      "  AND A.SYID_L=${LoginController().SYID} AND A.CIID_L='${LoginController().CIID}' $Wheresql"
      " AND F.SCID=A.SCID AND  F.JTID_L=${LoginController().JTID} "
      " AND F.SYID_L=${LoginController().SYID} AND F.CIID_L='${LoginController().CIID}' $Wheresql6"
      "  GROUP BY A.CIID_L,A.JTID_L,A.BIID_L,A.SYID_L,A.BMKID,A.SCID";

  var result = await dbClient!.rawQuery(sql);
  List<Bil_Mov_M_Local> list = result.map((item) {
    return Bil_Mov_M_Local.fromMap(item);
  }).toList();
  print(result);
  return list;
}


Future<List<Bil_Mov_M_Local>> GET_BIF_REP(String TAB_N,String TAB_N2,String GETBMKID,String GETBIID_F,String GETBIID_T,String GETBMMDO_F,
    String GETBMMDO_T,String GETBPID_F,String GETBPID_T,String GETPKID,String GETSCID,String GETBMMST) async {
  var dbClient = await conn.database;
  String sql;
  String BPIDsql='';
  String PKIDsql='';
  String SCIDsql='';
  String Wheresql='';
  (GETBPID_F.isEmpty || GETBPID_F=='null')  && (GETBPID_T.isEmpty || GETBPID_T=='null')? BPIDsql= "":BPIDsql= " AND  A.BPID BETWEEN $GETBPID_F AND $GETBPID_T";
  (GETPKID.isEmpty || GETPKID=='null') ? PKIDsql= "":PKIDsql= " AND  A.PKID=$GETPKID ";
  (GETSCID.isEmpty || GETSCID=='null') ? SCIDsql= "":SCIDsql= " AND  A.SCID=$GETSCID ";
  LoginController().BIID_ALL_V=='1'? Wheresql= " AND  A.BIID_L=${LoginController().BIID}":Wheresql='';

  sql=" SELECT ifnull(SUM(A.BMMAM-A.BMMTX),0.0) AS BMMAM,ifnull(SUM(A.BMMTX),0.0) AS BMMTX,"
      " ifnull(COUNT(A.BMMNO),0) AS BMMNO,ifnull(MAX(A.BMMNO),0) AS MAX_BMMNO,"
      " ifnull(MIN(A.BMMNO),0) AS MIN_BMMNO, ifnull(MAX(A.BMMDO),'')  AS MAX_BMMDO,"
      " ifnull(MIN(A.BMMDO),'') AS MIN_BMMDO,ifnull(SUM(A.BMMMT),0.0) AS SUM_BMMAM "
      " FROM $TAB_N A WHERE A.BMKID=$GETBMKID AND A.BMMST=$GETBMMST "
      " AND  A.BIID2 BETWEEN $GETBIID_F AND $GETBIID_T "
      " AND A.BMMDOR BETWEEN '$GETBMMDO_F' AND '$GETBMMDO_T' "
      " $BPIDsql  $PKIDsql $SCIDsql AND A.JTID_L=${LoginController().JTID} "
      " AND A.SYID_L=${LoginController().SYID} AND A.CIID_L='${LoginController().CIID}' $Wheresql"
      " ORDER BY A.BMMID ";
  var result = await dbClient!.rawQuery(sql);
  print(sql);
  print(result);
  print('GET_BIF_REP');
  List<Bil_Mov_M_Local> list = result.map((item) {
    return Bil_Mov_M_Local.fromMap(item);
  }).toList();
  return list;
}


Future<List<Bil_Mov_M_Local>> GET_BIF_REP2(String TAB_N,String GETBMKID,String GETBIID_F,String GETBIID_T,String GETBMMDO_F,String GETBMMDO_T
    , String GETBPID_F,String GETBPID_T,String GETPKID,String GETSCID,String GETBMMST) async {
  var dbClient = await conn.database;
  String sql;
  String BPIDsql='';
  String SCIDsql='';
  String PKIDsql='';
  String Wheresql='';
  (GETBPID_F.isEmpty || GETBPID_F=='null')  && (GETBPID_T.isEmpty || GETBPID_T=='null')? BPIDsql= "":BPIDsql= " AND  A.BPID BETWEEN $GETBPID_F AND $GETBPID_T";
  LoginController().BIID_ALL_V=='1'? Wheresql= " AND  A.BIID_L=${LoginController().BIID}":Wheresql='';
  (GETPKID.isEmpty || GETPKID=='null') ? PKIDsql= "":PKIDsql= " AND  A.PKID=$GETPKID ";
  (GETSCID.isEmpty || GETSCID=='null') ? SCIDsql= "":SCIDsql= " AND  A.SCID=$GETSCID ";

  sql = "SELECT  ifnull(SUM(A.BMMMT),0.0) AS SUM_BMMAM_delayed FROM $TAB_N A  WHERE A.BMKID=$GETBMKID AND"
      " A.BMMST=$GETBMMST AND A.PKID=3 AND "
      " A.BIID2 BETWEEN $GETBIID_F AND $GETBIID_T AND A.BMMDOR BETWEEN '$GETBMMDO_F' AND '$GETBMMDO_T' "
      " $BPIDsql $PKIDsql $SCIDsql  AND A.JTID_L=${LoginController().JTID} "
      "  AND A.SYID_L=${LoginController().SYID} AND A.CIID_L='${LoginController().CIID}' $Wheresql"
      " ORDER BY A.BMMID";
  var result = await dbClient!.rawQuery(sql);
  // print(result);
  List<Bil_Mov_M_Local> list = result.map((item) {
    return Bil_Mov_M_Local.fromMap(item);
  }).toList();
  return list;
}

Future<List<Bil_Mov_M_Local>> GET_BIF_REP3(String TAB_N,String GETBMKID,String GETBIID_F,String GETBIID_T,String GETBMMDO_F,String GETBMMDO_T
    ,String GETBPID_F,String GETBPID_T,String GETPKID,String GETSCID,String GETBMMST) async {
  var dbClient = await conn.database;
  String sql;
  String BPIDsql='';
  String SCIDsql='';
  String PKIDsql='';
  String Wheresql='';
  (GETBPID_F.isEmpty || GETBPID_F=='null')  && (GETBPID_T.isEmpty || GETBPID_T=='null')? BPIDsql= "":BPIDsql= " AND  A.BPID BETWEEN $GETBPID_F AND $GETBPID_T";
   LoginController().BIID_ALL_V=='1'? Wheresql= " AND  A.BIID_L=${LoginController().BIID}":Wheresql='';
  (GETPKID.isEmpty || GETPKID=='null') ? PKIDsql= "":PKIDsql= " AND  A.PKID=$GETPKID ";
  (GETSCID.isEmpty || GETSCID=='null') ? SCIDsql= "":SCIDsql= " AND  A.SCID=$GETSCID ";

  sql = "SELECT  ifnull(SUM(A.BMMMT),0.0) AS SUM_BMMAM_CASH FROM $TAB_N A WHERE A.BMKID=$GETBMKID AND "
      " A.BMMST=$GETBMMST AND A.PKID=1 AND "
      " A.BIID2 BETWEEN $GETBIID_F AND $GETBIID_T AND A.BMMDOR BETWEEN '$GETBMMDO_F' AND '$GETBMMDO_T' "
      " $BPIDsql $PKIDsql $SCIDsql  AND A.JTID_L=${LoginController().JTID} "
      "  AND A.SYID_L=${LoginController().SYID} AND A.CIID_L='${LoginController().CIID}' $Wheresql"
      " ORDER BY A.BMMID";
  var result = await dbClient!.rawQuery(sql);
  // print(result);
  List<Bil_Mov_M_Local> list = result.map((item) {
    return Bil_Mov_M_Local.fromMap(item);
  }).toList();
  return list;
}
Future<List<Bil_Mov_M_Local>> GET_BCCAM1(String TAB_N,String GETBMKID,String GETBIID_F,String GETBIID_T,String GETBMMDO_F,String GETBMMDO_T
    , String GETBPID_F,String GETBPID_T,
    String GETBCCID,String GETPKID,String GETSCID,String GETBMMST) async {
  var dbClient = await conn.database;
  String sql;
  String BPIDsql='';
  String SCIDsql='';
  String PKIDsql='';
  String Wheresql='';
  (GETBPID_F.isEmpty || GETBPID_F=='null')  && (GETBPID_T.isEmpty || GETBPID_T=='null')? BPIDsql= "":BPIDsql= " AND  A.BPID BETWEEN $GETBPID_F AND $GETBPID_T";
  LoginController().BIID_ALL_V=='1'? Wheresql= " AND  A.BIID_L=${LoginController().BIID}":Wheresql='';
  (GETPKID.isEmpty || GETPKID=='null') ? PKIDsql= "":PKIDsql= " AND  A.PKID=$GETPKID ";
  (GETSCID.isEmpty || GETSCID=='null') ? SCIDsql= "":SCIDsql= " AND  A.SCID=$GETSCID ";
  sql = "SELECT ifnull(SUM(A.BMMMT),0.0) AS SUM_BCCAM1 FROM $TAB_N A WHERE A.BMKID=$GETBMKID AND"
      " A.BMMST=$GETBMMST AND  A.BCCID=$GETBCCID AND "
      " A.BIID2 BETWEEN $GETBIID_F AND $GETBIID_T AND A.BMMDOR BETWEEN '$GETBMMDO_F' AND '$GETBMMDO_T' "
      " $BPIDsql $PKIDsql $SCIDsql  AND A.JTID_L=${LoginController().JTID} "
      "  AND A.SYID_L=${LoginController().SYID} AND A.CIID_L='${LoginController().CIID}' $Wheresql"
      " ORDER BY A.BMMID";
  var result = await dbClient!.rawQuery(sql);
  // print(result);
  List<Bil_Mov_M_Local> list = result.map((item) {
    return Bil_Mov_M_Local.fromMap(item);
  }).toList();
  return list;
}
Future<List<Bil_Mov_M_Local>> GET_BCCAM2(String TAB_N,String GETBMKID,String GETBIID_F,String GETBIID_T,String GETBMMDO_F,String GETBMMDO_T
    , String GETBPID_F,String GETBPID_T, String GETBCCID,String GETPKID,String GETSCID,String GETBMMST) async {
  var dbClient = await conn.database;
  String sql;
  String BPIDsql='';
  String SCIDsql='';
  String PKIDsql='';
  String Wheresql='';
  (GETBPID_F.isEmpty || GETBPID_F=='null')  && (GETBPID_T.isEmpty || GETBPID_T=='null')? BPIDsql= "":BPIDsql= " AND  A.BPID BETWEEN $GETBPID_F AND $GETBPID_T";
  LoginController().BIID_ALL_V=='1'? Wheresql= " AND  A.BIID_L=${LoginController().BIID}":Wheresql='';
  (GETPKID.isEmpty || GETPKID=='null') ? PKIDsql= "":PKIDsql= " AND  A.PKID=$GETPKID ";
  (GETSCID.isEmpty || GETSCID=='null') ? SCIDsql= "":SCIDsql= " AND  A.SCID=$GETSCID ";

  sql = "SELECT ifnull(SUM(A.BMMMT),0.0) AS SUM_BCCAM2 FROM $TAB_N A WHERE A.BMKID=$GETBMKID AND "
      " A.BMMST=$GETBMMST AND A.BCCID=$GETBCCID AND "
      " A.BIID2 BETWEEN $GETBIID_F AND $GETBIID_T AND A.BMMDOR BETWEEN '$GETBMMDO_F' AND '$GETBMMDO_T' "
      " $BPIDsql $PKIDsql $SCIDsql AND A.JTID_L=${LoginController().JTID} "
      "  AND A.SYID_L=${LoginController().SYID} AND A.CIID_L='${LoginController().CIID}' $Wheresql"
      " ORDER BY A.BMMID";
  var result = await dbClient!.rawQuery(sql);
  // print(result);
  List<Bil_Mov_M_Local> list = result.map((item) {
    return Bil_Mov_M_Local.fromMap(item);
  }).toList();
  return list;
}
Future<List<Bil_Mov_M_Local>> GET_BCCAM3(String TAB_N,String GETBMKID,String GETBIID_F,String GETBIID_T,String GETBMMDO_F,String GETBMMDO_T
    ,String GETBPID_F,String GETBPID_T, String GETBCCID,String GETPKID,String GETSCID,String GETBMMST) async {
  var dbClient = await conn.database;
  String sql;
  String BPIDsql='';
  String SCIDsql='';
  String PKIDsql='';
  String Wheresql='';
  (GETBPID_F.isEmpty || GETBPID_F=='null')  && (GETBPID_T.isEmpty || GETBPID_T=='null')? BPIDsql= "":BPIDsql= " AND  A.BPID BETWEEN $GETBPID_F AND $GETBPID_T";
  LoginController().BIID_ALL_V=='1'? Wheresql= " AND  A.BIID_L=${LoginController().BIID}":Wheresql='';
  (GETPKID.isEmpty || GETPKID=='null') ? PKIDsql= "":PKIDsql= " AND  A.PKID=$GETPKID ";
  (GETSCID.isEmpty || GETSCID=='null') ? SCIDsql= "":SCIDsql= " AND  A.SCID=$GETSCID ";

  sql = "SELECT ifnull(SUM(A.BMMMT),0.0) AS SUM_BCCAM3 FROM $TAB_N A WHERE A.BMKID=$GETBMKID AND "
      " A.BMMST=$GETBMMST AND A.BCCID=$GETBCCID AND "
      " A.BIID2 BETWEEN $GETBIID_F AND $GETBIID_T AND A.BMMDOR BETWEEN '$GETBMMDO_F' AND '$GETBMMDO_T' "
      " $BPIDsql $PKIDsql $SCIDsql AND A.JTID_L=${LoginController().JTID} "
      "  AND A.SYID_L=${LoginController().SYID} AND A.CIID_L='${LoginController().CIID}' $Wheresql"
      " ORDER BY A.BMMID";
  var result = await dbClient!.rawQuery(sql);
  // print(result);
  List<Bil_Mov_M_Local> list = result.map((item) {
    return Bil_Mov_M_Local.fromMap(item);
  }).toList();
  return list;
}
Future<List<Bil_Cre_C_Local>> GET_BIL_CRE_C_APPROVE() async {
  var dbClient = await conn.database;
  String sql;
  String Wheresql='';
  String Wheresql2='';
  LoginController().BIID_ALL_V=='1'? Wheresql= " AND  A.BIID_L=${LoginController().BIID}":Wheresql='';
  LoginController().BIID_ALL_V=='1'? Wheresql2= " AND  B.BIID_L=${LoginController().BIID}":Wheresql2='';

  sql = "SELECT *,CASE WHEN ${LoginController().LAN}=2 AND A.BCCNE IS NOT NULL THEN A.BCCNE ELSE A.BCCNA END  BCCNA_D"
      " FROM BIL_CRE_C A WHERE A.BCCST=1  AND A.AANO IN(SELECT B.AANO FROM ACC_USR B WHERE B.AUIN=1"
      " AND B.SUID IS NOT NULL AND B.SUID=${LoginController().SUID} "
      " AND B.JTID_L=${LoginController().JTID} AND B.SYID_L=${LoginController().SYID} AND "
      " B.CIID_L='${LoginController().CIID}' $Wheresql2 GROUP BY AANO) AND A.JTID_L=${LoginController().JTID} "
      " AND A.SYID_L=${LoginController().SYID} AND A.CIID_L='${LoginController().CIID}' $Wheresql "
      "  ORDER BY A.BCCID LIMIT 3";
  var result = await dbClient!.rawQuery(sql);
   print(sql);
   print(result);
   print('GET_BIL_CRE_C_APPROVE');
  List<Bil_Cre_C_Local> list = result.map((item) {
    return Bil_Cre_C_Local.fromMap(item);
  }).toList();
  return list;
}
Future<List<Sys_Yea_Local>> GET_SYS_YEA() async {
  var dbClient = await conn.database;
  String sql;
  sql =" SELECT * FROM SYS_YEA_ACC A ";
  var result = await dbClient!.rawQuery(sql);
  List<Sys_Yea_Local> list = result.map((item) {
    return Sys_Yea_Local.fromMap(item);
  }).toList();
  return list;
}

Future<List<Acc_Mov_M_Local>> GET_ACC_REP(String GETAMKID,String GETBIID_F,String GETBIID_T,String GETAMMDO_F,
    String GETAMMDO_T,String GETPKID,String GETSCID) async {
  var dbClient = await conn.database;
  String sql;
  String PKIDsql='';
  String SCIDsql='';
  String AMKIDsql='';
  String Wheresql='';
  (GETAMKID=='0') ? AMKIDsql= "":AMKIDsql= " AND  A.AMKID=$GETAMKID AND ";
  (GETPKID.isEmpty || GETPKID=='null') ? PKIDsql= "":PKIDsql= " AND  A.PKID=$GETPKID ";
  (GETSCID.isEmpty || GETSCID=='null') ? SCIDsql= "":SCIDsql= " AND  A.SCID=$GETSCID ";
  LoginController().BIID_ALL_V=='1'? Wheresql= " AND  A.BIID_L=${LoginController().BIID}":Wheresql='';

  sql = "SELECT ifnull(SUM(A.AMMAM),0.0) AS AMMAM,ifnull(SUM(AMMEQ),0.0) AS AMMEQ,ifnull(MAX(AMMNO),0) AS MAX_AMMNO,"
      " ifnull(MIN(AMMNO),0) AS MIN_AMMNO, ifnull(MAX(AMMDO),'')  AS MAX_AMMDO,ifnull(MIN(AMMDO),'')  AS MIN_AMMDO "
      " FROM ACC_MOV_M A WHERE  $AMKIDsql  A.BIID BETWEEN $GETBIID_F AND $GETBIID_T "
      " AND A.AMMDOR BETWEEN '$GETAMMDO_F' AND '$GETAMMDO_T' "
      " $PKIDsql $SCIDsql AND A.JTID_L=${LoginController().JTID} "
      " AND A.SYID_L=${LoginController().SYID} AND A.CIID_L='${LoginController().CIID}' $Wheresql";
  var result = await dbClient!.rawQuery(sql);
  // print(sql);
  // print(result);
  List<Acc_Mov_M_Local> list = result.map((item) {
    return Acc_Mov_M_Local.fromMap(item);
  }).toList();
  return list;
}


Future<List<Acc_Sta_M_Local>> GET_ACOUNT_ACC_M(String GETGUID) async {
  var dbClient = await conn.database;
  String sql;
  sql = " SELECT ifnull(COUNT(*),0) AS COU,ROWN1 FROM ACC_STA_M A  WHERE   A.GUID_REP='$GETGUID' ";
  var result = await dbClient!.rawQuery(sql);
  List<Acc_Sta_M_Local> list = result.map((item) {return Acc_Sta_M_Local.fromMap(item);}).toList();
  return list;

}
Future<List<Acc_Sta_D_Local>> GET_ACOUNT_ACC_D(String GETGUID) async {
  var dbClient = await conn.database;
  String sql;
  sql = " SELECT COUNT(*) AS COU FROM ACC_STA_D A  WHERE   A.GUID_REP='$GETGUID' ";
  var result = await dbClient!.rawQuery(sql);
  List<Acc_Sta_D_Local> list = result.map((item) {return Acc_Sta_D_Local.fromMap(item);}).toList();
  return list;

}

Future<int> Update_ACC_STA(String TAB_N,int GETJTID,int GETSYID,int GETBIID,String GETCIID,String GETGUID) async {
  var dbClient = await conn.database;
  final data = { 'JTID_L': GETJTID, 'SYID_L': GETSYID, 'BIID_L': GETBIID, 'CIID_L': GETCIID};
  final result = await dbClient!.update(TAB_N, data,where: " GUID_REP='$GETGUID'");
  return result;
}

Future<List<Acc_Sta_M_Local>> GET_ACC_STA_M(String GETGUID) async {
  var dbClient = await conn.database;
  String sql;
  sql = "SELECT * FROM ACC_STA_M A  WHERE   A.GUID_REP='$GETGUID'";
  var result = await dbClient!.rawQuery(sql);
  // print(sql);
  // print(result);
  List<Acc_Sta_M_Local> list = result.map((item) {return Acc_Sta_M_Local.fromMap(item);}).toList();
  return list;
}

Future<List<Acc_Sta_D_Local>> GET_SUM_ACC_STA(String GETGUID) async {
  var dbClient = await conn.database;
  String sql;
  String Wheresql='';

  LoginController().BIID_ALL_V=='1'? Wheresql= " AND  A.BIID_L=${LoginController().BIID}":Wheresql='';

  sql = "SELECT ifnull(round(SUM(A.ATC20),6),0.0) AS SUMAMDMD,ifnull(round(SUM(A.ATC22),6),0.0) AS SUMAMDDA FROM ACC_STA_D A  WHERE   A.GUID_REP='$GETGUID' AND A.ATC11 IS NOT NULL AND A.JTID_L=${LoginController().JTID} "
      " AND A.SYID_L=${LoginController().SYID} AND A.CIID_L='${LoginController().CIID}' $Wheresql ORDER BY A.ASDID";
  var result = await dbClient!.rawQuery(sql);
  // print(sql);
  // print(result);
  List<Acc_Sta_D_Local> list = result.map((item) {return Acc_Sta_D_Local.fromMap(item);}).toList();
  return list;
}

Future<int> deleteACC_STA_D() async {
  var dbClient = await conn.database;
  return await dbClient!.delete('ACC_STA_D');
}


Future<int> deleteACC_STA_M() async {
  var dbClient = await conn.database;
  return await dbClient!.delete('ACC_STA_M');
}


Future<List<Acc_Sta_D_Local>> GET_ACC_STA_PDF(String GETGUID) async {
  var dbClient = await conn.database;
  String sql;
  sql = "SELECT * FROM ACC_STA_D A  WHERE   A.GUID_REP='$GETGUID' AND A.ATC11 IS NOT NULL AND A.ATC14 IS NULL ORDER BY A.ASDID";
  var result = await dbClient!.rawQuery(sql);
  // print(sql);
  // print(result);
  // print('GET_ACC_STA_PDF');
  List<Acc_Sta_D_Local> list = result.map((item) {return Acc_Sta_D_Local.fromMap(item);}).toList();
  return list;
}

Future<List<Syn_Log_Local>> GET_SYN_LOG() async {
  var dbClient = await conn.database;
  String sql;
  String Wheresql='';
  LoginController().BIID_ALL_V=='1'? Wheresql= " AND  A.BIID_L=${LoginController().BIID}":Wheresql='';
  sql = "SELECT * FROM SYN_LOG A  WHERE  A.JTID_L=${LoginController().JTID} "
      " AND A.SYID_L=${LoginController().SYID} AND A.CIID_L='${LoginController().CIID}' $Wheresql ORDER BY A.SLDO DESC";
  var result = await dbClient!.rawQuery(sql);
  // print(sql);
  // print(result);
  List<Syn_Log_Local> list = result.map((item) {return Syn_Log_Local.fromMap(item);}).toList();
  return list;
}

Future<List<Syn_Log_Local>> GET_COUNT_SYN_LOG() async {
  var dbClient = await conn.database;
  String sql;
  String Wheresql='';
  LoginController().BIID_ALL_V=='1'? Wheresql= " AND  A.BIID_L=${LoginController().BIID}":Wheresql='';
  sql = "SELECT COUNT(*) AS COUNTROW FROM SYN_LOG A  WHERE  A.JTID_L=${LoginController().JTID} "
      " AND A.SYID_L=${LoginController().SYID} AND A.CIID_L='${LoginController().CIID}' $Wheresql";
  var result = await dbClient!.rawQuery(sql);
  // print(sql);
  // print(result);
  // print('GET_COUNT_SYN_LOG');
  List<Syn_Log_Local> list = result.map((item) {return Syn_Log_Local.fromMap(item);}).toList();
  return list;
}

Future<int> DELETESYN_LOG() async {
  var dbClient = await conn.database;
  return await dbClient!.delete('SYN_LOG');
}


Future<List<Bal_Acc_D_Local>> GET_BIL_ACC_D(String GETAANO,String TYPESCID,String GETSCID,
    bool GETNOT_INC_LAS,String SSID) async {
  var dbClient = await conn.database;
  String sql;
  String sql3='';
  String Wheresql='';
  String Wheresql2='';
  GETNOT_INC_LAS==true?sql3=' AND A.AMKID!=0 ':sql3='';
  LoginController().BIID_ALL_V=='1'? Wheresql= " AND  A.BIID_L=${LoginController().BIID}":Wheresql='';
  LoginController().BIID_ALL_V=='1'? Wheresql2= " AND  B.BIID_L=${LoginController().BIID}":Wheresql2='';

  // if(SSID=='203'){
  // sql = "SELECT SUM(A.BADMD) AS BADMD,SUM(A.BADDA) AS BADDA,SUM(A.BADEQ) AS BADEQ,SUM(A.BADEQ) AS BADEQ"
  //     " ,CASE WHEN ${LoginController().LAN}=2 AND B.AMKNE IS NOT NULL THEN B.AMKNE ELSE B.AMKNA END  AMKNA_D "
  //     " FROM BAL_ACC_D A left join ACC_MOV_K B  on  A.AMKID=B.AMKID  AND B.JTID_L=${LoginController().JTID} "
  //     " AND B.SYID_L=${LoginController().SYID} AND B.CIID_L='${LoginController().CIID}' $Wheresql2 "
  //     "  WHERE   A.AANO='$GETAANO'  $sql3  AND A.SCID=$GETSCID  AND A.JTID_L=${LoginController().JTID} "
  //     " AND A.SYID_L=${LoginController().SYID} AND A.CIID_L='${LoginController().CIID}' $Wheresql "
  //     "  ORDER BY A.BADNO";
  // }else{
  sql=" SELECT *,CASE WHEN ${LoginController().LAN}=2 AND B.AMKNE IS NOT NULL THEN B.AMKNE ELSE B.AMKNA END  AMKNA_D "
      " FROM BAL_ACC_D A left join ACC_MOV_K B  on  A.AMKID=B.AMKID  AND B.JTID_L=${LoginController().JTID} "
      " AND B.SYID_L=${LoginController().SYID} AND B.CIID_L='${LoginController().CIID}' $Wheresql2 "
      " WHERE   A.AANO='$GETAANO'  $sql3  AND A.SCID=$GETSCID  AND A.JTID_L=${LoginController().JTID} "
      " AND A.SYID_L=${LoginController().SYID} AND A.CIID_L='${LoginController().CIID}' $Wheresql "
      " ORDER BY A.BADNO ";
 // }

  var result = await dbClient!.rawQuery(sql);
  List<Bal_Acc_D_Local> list = result.map((item) {return Bal_Acc_D_Local.fromMap(item);}).toList();
  return list;
}

Future<List<Bal_Acc_C_Local>> GET_BIL_ACC_M(String GETAANO,String GETGUID,String TYPESCID,String GETSCID) async {
  var dbClient = await conn.database;
  String sql;
  String Wheresql='';

  LoginController().BIID_ALL_V=='1'? Wheresql= " AND  A.BIID_L=${LoginController().BIID}":Wheresql='';

  sql =" SELECT * FROM BAL_ACC_C A  WHERE   A.AANO='$GETAANO' AND A.SCID='$GETSCID'   AND A.JTID_L=${LoginController().JTID} "
      " AND A.SYID_L=${LoginController().SYID} AND A.CIID_L='${LoginController().CIID}' $Wheresql ";
  var result = await dbClient!.rawQuery(sql);
  // print(sql);
  // print(result);
  // print('GET_BIL_ACC_M');
  List<Bal_Acc_C_Local> list = result.map((item) {return Bal_Acc_C_Local.fromMap(item);}).toList();
  return list;
}

Future<List<Acc_Acc_Local>> GET_ACC_ACC(String GETSCID) async {
  var dbClient = await conn.database;
  String sql;
  String sql2='';
  String Wheresql='';
  String Wheresql2='';
  String Wheresql3='';
  LoginController().BIID_ALL_V=='1'? Wheresql= " AND A.BIID_L=${LoginController().BIID}":Wheresql='';
  LoginController().BIID_ALL_V=='1'? Wheresql2= " AND B.BIID_L=${LoginController().BIID}":Wheresql2='';
  LoginController().BIID_ALL_V=='1'? Wheresql3= " AND C.BIID_L=${LoginController().BIID}":Wheresql3='';

  GETSCID=='1'?sql2=" AND EXISTS(SELECT 1 FROM BIL_CUS C WHERE A.AANO=C.AANO  AND C.JTID_L=${LoginController().JTID} "
      " AND C.SYID_L=${LoginController().SYID} AND C.CIID_L=${LoginController().CIID} $Wheresql3) ":
  GETSCID=='2'?sql2="AND EXISTS(SELECT 1 FROM BIL_IMP C WHERE A.AANO=C.AANO  AND C.JTID_L=${LoginController().JTID} "
      " AND C.SYID_L=${LoginController().SYID} AND C.CIID_L=${LoginController().CIID} $Wheresql3)":
  GETSCID=='3'?sql2=" ":sql2='';

  sql ="SELECT A.AANO,CASE WHEN ${LoginController().LAN}=2 AND A.AANE IS NOT NULL THEN A.AANE ELSE A.AANA END  AANA_D"
      " FROM ACC_ACC A WHERE   A.AATY=2  $sql2 "
      " AND A.JTID_L=${LoginController().JTID} "
      " AND A.SYID_L=${LoginController().SYID} AND A.CIID_L='${LoginController().CIID}' $Wheresql"
      " AND EXISTS(SELECT 1 FROM ACC_USR B WHERE B.AANO=A.AANO AND B.AUOU=1 AND B.SUID='${LoginController().SUID}' "
      " AND B.JTID_L=${LoginController().JTID} "
      " AND B.SYID_L=${LoginController().SYID} AND B.CIID_L='${LoginController().CIID}' $Wheresql2)"
      " ORDER BY A.AANO";
  // print(sql);
  // print('GET_ACC_ACC');
  final result = await dbClient!.rawQuery(sql);
  return result.map((json) => Acc_Acc_Local.fromMap(json)).toList();
}


Future<List<Bal_Acc_C_Local>> GET_Customers_Balances(int TYPE,String GETBIID_F,String GETBIID_T,String GETSCID_F,String GETSCID_T,
    String GETAANO_F,String GETAANO_T,String GETBCTID_F,String GETBCTID_T,String GETBCST_F,String GETBCST_T,
    String GETCWID_F,String GETCWID_T,String GETBAID_F,String GETBAID_T,bool GETNOT_BAL,TYPE_ORD,TYPE_ORD2) async {
  var dbClient = await conn.database;
  String sql='';
  String sql2='';
  String sql3='';
  String sqlORD='';
  String sqlORD2='';
  String Wheresql='';
  String Wheresql2='';
  String Wheresql3='';
  String Wheresql4='';
  String sqlBCTID='';
  String sqlBCST='';
  String sqlCWID='';
  String sqlBAID='';
  String sqlNOT_BAL=' ';
  LoginController().BIID_ALL_V=='1'? Wheresql= " AND  A.BIID_L=A.BIID_L":Wheresql='';
  LoginController().BIID_ALL_V=='1'? Wheresql2= " AND  B.BIID_L=A.BIID_L":Wheresql2='';
  LoginController().BIID_ALL_V=='1'? Wheresql3= " AND  C.BIID_L=A.BIID_L":Wheresql3='';
  LoginController().BIID_ALL_V=='1'? Wheresql4= " AND  E.BIID_L=B.BIID_L":Wheresql4='';
  GETNOT_BAL==false? sqlNOT_BAL= " A.BACBA!=0 AND ":sqlNOT_BAL='';
  if(TYPE_ORD=='2'){
    sqlORD=' A.SCID ';
  }else if(TYPE_ORD=='3'){
    sqlORD=' A.BACBA ';
  }else{
    sqlORD=' A.AANO';
  }

  TYPE_ORD2=='2'?sqlORD2='DESC':sqlORD2='ASC';
  print(GETSCID_F);
  print(GETSCID_T);
  print('GETSCID_T');

  if (GETSCID_F == 'null') {
    sql2 = "";
  } else if (GETSCID_T == 'null') {
    sql2 = " A.SCID BETWEEN $GETSCID_F AND $GETSCID_F AND ";
  } else {
    sql2 = " A.SCID BETWEEN $GETSCID_F AND $GETSCID_T AND ";
  }

  // شرط AANO
  if (GETAANO_F.isEmpty || GETAANO_F == 'null') {
    sql3 = "";
  } else if (GETAANO_T.isEmpty || GETAANO_T == 'null') {
    sql3 = " AND B.AANO BETWEEN $GETAANO_F AND $GETAANO_F";
  } else {
    sql3 = " AND B.AANO BETWEEN $GETAANO_F AND $GETAANO_T";
  }

// شرط BCTID أو BITID حسب نوع TYPE
  if (GETBCTID_F.isEmpty || GETBCTID_F == 'null') {
    sqlBCTID = "";
  } else if (TYPE == 1) {
    sqlBCTID = " AND B.BCTID BETWEEN $GETBCTID_F AND $GETBCTID_T";
  } else {
    sqlBCTID = " AND B.BITID BETWEEN $GETBCTID_F AND $GETBCTID_T";
  }

// شرط BCST أو BIST أو AAST حسب نوع TYPE
  if (GETBCST_F.isEmpty || GETBCST_F == 'null') {
    sqlBCST = "";
  } else if (TYPE == 1) {
    sqlBCST = " AND B.BCST BETWEEN $GETBCST_F AND $GETBCST_T";
  } else if (TYPE == 2) {
    sqlBCST = " AND B.BIST BETWEEN $GETBCST_F AND $GETBCST_T";
  } else {
    sqlBCST = " AND B.AAST BETWEEN $GETBCST_F AND $GETBCST_T";
  }

// شرط CWID
  if (GETCWID_F.isEmpty || GETCWID_F == 'null') {
    sqlCWID = "";
  } else {
    sqlCWID = " AND B.CWID BETWEEN '$GETCWID_F' AND '$GETCWID_T'";
  }

// شرط BAID
  if (GETBAID_F.isEmpty || GETBAID_F == 'null') {
    sqlBAID = "";
  } else {
    sqlBAID = " AND B.BAID BETWEEN $GETBAID_F AND $GETBAID_T";
  }

  if(TYPE==1){
    sql = " SELECT A.AANO,A.SCID,A.BACBMD,A.BACBDA,A.BACBA,A.BACLP,A.BACLBN,B.BCAD,B.BCID,B.BCTL,"
        " CASE WHEN ${LoginController().LAN}=2 AND B.BCNE IS NOT NULL THEN B.BCNE ELSE B.BCNA END  BCNA_D,"
        " CASE WHEN ${LoginController().LAN}=2 AND C.SCNE IS NOT NULL THEN C.SCNE ELSE C.SCNA END  SCNA_D "
        " FROM BAL_ACC_C A JOIN BIL_CUS B ON A.AANO = B.AANO  AND A.JTID_L = B.JTID_L "
        " AND A.SYID_L = B.SYID_L AND A.CIID_L = B.CIID_L $Wheresql2"
        " JOIN SYS_CUR C ON A.SCID = C.SCID  AND A.JTID_L = C.JTID_L "
        " AND A.SYID_L = C.SYID_L AND A.CIID_L = C.CIID_L $Wheresql3 "
        "  WHERE  $sql2  $sqlNOT_BAL A.JTID_L=${LoginController().JTID} "
        " AND A.SYID_L=${LoginController().SYID} AND A.CIID_L='${LoginController().CIID}' $Wheresql "
        " AND B.BIID BETWEEN $GETBIID_F AND $GETBIID_T  $sql3  $sqlBCTID  $sqlBCST "
        " $sqlCWID $sqlBAID "
        " AND EXISTS(SELECT 1 FROM ACC_USR E WHERE E.AANO=B.AANO AND E.AUPR=1 "
        " AND E.SUID IS NOT NULL AND E.SUID=${LoginController().SUID} AND E.JTID_L=B.JTID_L "
        " AND E.SYID_L=B.SYID_L AND E.CIID_L=B.CIID_L $Wheresql4)"
        "  ORDER BY $sqlORD $sqlORD2";
  }
  else if(TYPE==2){
    sql = " SELECT A.AANO,A.SCID,A.BACBMD,A.BACBDA,A.BACBA,A.BACLP,A.BACLBN,B.BIAD AS BCAD,B.BIID AS BCID,B.BITL AS BCTL,"
        " CASE WHEN ${LoginController().LAN}=2 AND B.BINE IS NOT NULL THEN B.BINE ELSE B.BINA END  BCNA_D,"
        " CASE WHEN ${LoginController().LAN}=2 AND C.SCNE IS NOT NULL THEN C.SCNE ELSE C.SCNA END  SCNA_D "
        " FROM BAL_ACC_C A JOIN BIL_IMP B ON A.AANO = B.AANO  AND A.JTID_L = B.JTID_L "
        " JOIN SYS_CUR C ON A.SCID = C.SCID  AND A.JTID_L = C.JTID_L "
        " AND A.SYID_L = B.SYID_L AND A.CIID_L = B.CIID_L $Wheresql2"
        " AND A.SYID_L = C.SYID_L AND A.CIID_L = C.CIID_L $Wheresql3   WHERE  $sql2 $sqlNOT_BAL"
        " A.JTID_L=${LoginController().JTID} "
        " AND A.SYID_L=${LoginController().SYID} AND A.CIID_L='${LoginController().CIID}' $Wheresql "
        "   AND B.BIID2 BETWEEN $GETBIID_F AND $GETBIID_T  $sql3  $sqlBCTID  $sqlBCST "
        " $sqlCWID $sqlBAID  "
        " AND EXISTS(SELECT 1 FROM ACC_USR E WHERE E.AANO=B.AANO AND E.AUPR=1 "
        " AND E.SUID IS NOT NULL AND E.SUID=${LoginController().SUID} AND E.JTID_L=B.JTID_L "
        " AND E.SYID_L=B.SYID_L AND E.CIID_L=B.CIID_L $Wheresql4)"
        "  ORDER BY $sqlORD $sqlORD2 ";
  }
  else{
    sql = " SELECT A.AANO,A.SCID,A.BACBMD,A.BACBDA,A.BACBA,A.BACLP,A.BACLBN,B.AAAD AS BCAD,B.AANO AS BCID,B.AATL AS BCTL,"
        " CASE WHEN ${LoginController().LAN}=2 AND B.AANE IS NOT NULL THEN B.AANE ELSE B.AANA END  BCNA_D,"
        " CASE WHEN ${LoginController().LAN}=2 AND C.SCNE IS NOT NULL THEN C.SCNE ELSE C.SCNA END  SCNA_D "
        " FROM BAL_ACC_C A,ACC_ACC B JOIN SYS_CUR C ON A.SCID = C.SCID  AND A.JTID_L = C.JTID_L "
        " AND A.SYID_L = B.SYID_L AND A.CIID_L = B.CIID_L $Wheresql2 WHERE  $sql2 $sqlNOT_BAL"
        " A.JTID_L=${LoginController().JTID} "
        " AND A.SYID_L=${LoginController().SYID} AND A.CIID_L='${LoginController().CIID}' $Wheresql "
        " AND A.AANO=B.AANO   $sql3  $sqlBCTID  $sqlBCST "
        " $sqlCWID $sqlBAID AND B.JTID_L=${LoginController().JTID} "
        " AND B.SYID_L=${LoginController().SYID} AND B.CIID_L='${LoginController().CIID}' $Wheresql2 "
        " AND EXISTS(SELECT 1 FROM ACC_USR E WHERE E.AANO=B.AANO AND E.AUPR=1 "
        " AND E.SUID IS NOT NULL AND E.SUID='${LoginController().SUID}' AND E.JTID_L=${LoginController().JTID} "
        " AND E.SYID_L=${LoginController().SYID} AND E.CIID_L='${LoginController().CIID}' $Wheresql4)"
        "  ORDER BY $sqlORD $sqlORD2 ";
  }


  //var result = await dbClient!.rawQuery(sql);
  print(sql);
//  print(result);
  print('GET_Customers_Balances');
 // List<Bal_Acc_C_Local> list = result.map((item) {return Bal_Acc_C_Local.fromMap(item);}).toList();
  return dbClient!.transaction<List<Bal_Acc_C_Local>>((txn) async {
    // إذا أحببت يمكنك ضبط مهلة الانتظار هنا (مثلاً 5 ثواني بدل 10):
   // await txn.rawExecute("PRAGMA busy_timeout = 5000");

    // شغّل الـ rawQuery على كائن المعاملة txn وليس dbClient
    final result = await txn.rawQuery(sql);

    // تحويل النتيجة إلى كائناتك
    return result.map((item) => Bal_Acc_C_Local.fromMap(item)).toList();
  });

}



Future<List<Bal_Acc_C_Local>> GET_Customers_Balances_SUM(int TYPE,String GETBIID_F,String GETBIID_T,String GETSCID_F,String GETSCID_T,
    String GETAANO_F,String GETAANO_T,String GETBCTID_F,String GETBCTID_T,String GETBCST_F,String GETBCST_T,
    String GETCWID_F,String GETCWID_T,String GETBAID_F,String GETBAID_T,bool GETNOT_BAL,TYPE_ORD,TYPE_ORD2) async {
  var dbClient = await conn.database;
  String sql='';
  String sql2='';
  String sql3='';
  String sqlORD='';
  String sqlORD2='';
  String Wheresql='';
  String Wheresql2='';
  String Wheresql3='';
  String Wheresql4='';
  String sqlBCTID='';
  String sqlBCST='';
  String sqlCWID='';
  String sqlBAID='';
  String sqlNOT_BAL=' ';
  LoginController().BIID_ALL_V=='1'? Wheresql= " AND  A.BIID_L=${LoginController().BIID}":Wheresql='';
  LoginController().BIID_ALL_V=='1'? Wheresql2= " AND  B.BIID_L=${LoginController().BIID}":Wheresql2='';
  LoginController().BIID_ALL_V=='1'? Wheresql3= " AND  C.BIID_L=${LoginController().BIID}":Wheresql3='';
  LoginController().BIID_ALL_V=='1'? Wheresql4= " AND  E.BIID_L=${LoginController().BIID}":Wheresql4='';

  GETNOT_BAL==false? sqlNOT_BAL= " A.BACBA!=0 AND ":sqlNOT_BAL='';

  if(TYPE_ORD=='2'){
    sqlORD=' A.SCID ';
  }else if(TYPE_ORD=='3'){
    sqlORD=' A.BACBA ';
  }else{
    sqlORD=' A.AANO';
  }

  TYPE_ORD2=='2'?sqlORD2='DESC':sqlORD2='ASC';

  (GETSCID_F.isEmpty || GETSCID_F=='null') ? sql2= "":(GETSCID_T.isEmpty || GETSCID_T=='null') ?
  sql2= " A.SCID BETWEEN $GETSCID_F AND $GETSCID_T AND ":sql2= " A.SCID BETWEEN $GETSCID_F AND $GETSCID_F AND ";

  (GETAANO_F.isEmpty || GETAANO_F=='null') ? sql3= "":sql3= (GETAANO_T.isEmpty || GETAANO_T=='null')?
  " AND B.AANO BETWEEN $GETAANO_F AND $GETAANO_F  ":" AND B.AANO BETWEEN $GETAANO_F AND $GETAANO_T  ";

  (GETBCTID_F.isEmpty || GETBCTID_F=='null') ? sqlBCTID= "":TYPE==1?sqlBCTID= " AND B.BCTID BETWEEN $GETBCTID_F AND $GETBCTID_T  ":

  sqlBCTID= " AND B.BITID BETWEEN $GETBCTID_F AND $GETBCTID_T  ";

  (GETBCST_F.isEmpty || GETBCST_F=='null') ? sqlBCST= "":TYPE==1?sqlBCST= " AND B.BCST BETWEEN $GETBCST_F AND $GETBCST_T ":

  TYPE==2?sqlBCST= " AND B.BIST BETWEEN $GETBCST_F AND $GETBCST_T ":sqlBCST= " AND B.AAST BETWEEN $GETBCST_F AND $GETBCST_T ";

  (GETCWID_F.isEmpty || GETCWID_F=='null') ? sqlCWID= "":sqlCWID= " AND B.CWID BETWEEN '$GETCWID_F' AND '$GETCWID_T' ";

  (GETBAID_F.isEmpty || GETBAID_F=='null') ? sqlBAID= "":sqlBAID= " AND B.BAID BETWEEN $GETBAID_F AND $GETBAID_T ";

  if(TYPE==1){
    sql = " SELECT ifnull(SUM(A.BACBMD),0.0) AS SUM_BACBMD,ifnull(SUM(A.BACBDA),0.0) AS SUM_BACBDA,ifnull(SUM(A.BACBA),0.0) AS SUM_BACBA "
        " FROM BAL_ACC_C A,BIL_CUS B,SYS_CUR C "
        " WHERE  $sql2  $sqlNOT_BAL A.JTID_L=${LoginController().JTID} "
        " AND A.SYID_L=${LoginController().SYID} AND A.CIID_L='${LoginController().CIID}' $Wheresql "
        " AND A.AANO=B.AANO  AND B.BIID BETWEEN $GETBIID_F AND $GETBIID_T  $sql3  $sqlBCTID  $sqlBCST "
        " $sqlCWID $sqlBAID AND B.JTID_L=${LoginController().JTID} "
        " AND B.SYID_L=${LoginController().SYID} AND B.CIID_L='${LoginController().CIID}' $Wheresql2 "
        " AND A.SCID=C.SCID  AND  C.JTID_L=${LoginController().JTID} "
        " AND C.SYID_L=${LoginController().SYID} AND C.CIID_L='${LoginController().CIID}' $Wheresql3 "
        " AND EXISTS(SELECT 1 FROM ACC_USR E WHERE E.AANO=B.AANO AND E.AUPR=1 "
        " AND E.SUID IS NOT NULL AND E.SUID=${LoginController().SUID} AND E.JTID_L=${LoginController().JTID} "
        " AND E.SYID_L=${LoginController().SYID} AND E.CIID_L='${LoginController().CIID}' $Wheresql4)"
        "  ORDER BY $sqlORD $sqlORD2 ";
  }else if(TYPE==2){
    sql = " SELECT ifnull(SUM(A.BACBMD),0.0) AS SUM_BACBMD,ifnull(SUM(A.BACBDA),0.0) AS SUM_BACBDA,ifnull(SUM(A.BACBA),0.0) AS SUM_BACBA "
        " FROM BAL_ACC_C A,BIL_IMP B,SYS_CUR C  WHERE  $sql2  $sqlNOT_BAL "
        " A.JTID_L=${LoginController().JTID} "
        " AND A.SYID_L=${LoginController().SYID} AND A.CIID_L='${LoginController().CIID}' $Wheresql "
        " AND A.AANO=B.AANO  AND B.BIID2 BETWEEN $GETBIID_F AND $GETBIID_T  $sql3  $sqlBCTID  $sqlBCST "
        " $sqlCWID $sqlBAID AND B.JTID_L=${LoginController().JTID} "
        " AND B.SYID_L=${LoginController().SYID} AND B.CIID_L='${LoginController().CIID}' $Wheresql2 "
        " AND A.SCID=C.SCID  AND  C.JTID_L=${LoginController().JTID} "
        " AND C.SYID_L=${LoginController().SYID} AND C.CIID_L='${LoginController().CIID}' $Wheresql3 "
        " AND EXISTS(SELECT 1 FROM ACC_USR E WHERE E.AANO=B.AANO AND E.AUPR=1 "
        " AND E.SUID IS NOT NULL AND E.SUID=${LoginController().SUID} AND E.JTID_L=${LoginController().JTID} "
        " AND E.SYID_L=${LoginController().SYID} AND E.CIID_L='${LoginController().CIID}' $Wheresql4)"
        "  ORDER BY $sqlORD $sqlORD2 ";
  }else{
    sql =" SELECT ifnull(SUM(A.BACBMD),0.0) AS SUM_BACBMD,ifnull(SUM(A.BACBDA),0.0) AS SUM_BACBDA,ifnull(SUM(A.BACBA),0.0) AS SUM_BACBA"
        " FROM BAL_ACC_C A,ACC_ACC B,SYS_CUR C  WHERE  $sql2  $sqlNOT_BAL "
        " A.JTID_L=${LoginController().JTID} "
        " AND A.SYID_L=${LoginController().SYID} AND A.CIID_L='${LoginController().CIID}' $Wheresql "
        " AND A.AANO=B.AANO   $sql3  $sqlBCTID  $sqlBCST "
        " $sqlCWID $sqlBAID AND B.JTID_L=${LoginController().JTID} "
        " AND B.SYID_L=${LoginController().SYID} AND B.CIID_L='${LoginController().CIID}' $Wheresql2 "
        " AND A.SCID=C.SCID  AND  C.JTID_L=${LoginController().JTID} "
        " AND C.SYID_L=${LoginController().SYID} AND C.CIID_L='${LoginController().CIID}' $Wheresql3 "
        " AND EXISTS(SELECT 1 FROM ACC_USR E WHERE E.AANO=B.AANO AND E.AUPR=1 "
        " AND E.SUID IS NOT NULL AND E.SUID='${LoginController().SUID}' AND E.JTID_L=${LoginController().JTID} "
        " AND E.SYID_L=${LoginController().SYID} AND E.CIID_L='${LoginController().CIID}' $Wheresql4)"
        "  ORDER BY $sqlORD $sqlORD2 ";
  }

  var result = await dbClient!.rawQuery(sql);
  // print(sql);
  // print(result);
  // print('GET_Customers_Balance_SUM');
  List<Bal_Acc_C_Local> list = result.map((item) {return Bal_Acc_C_Local.fromMap(item);}).toList();
  return list;
}

Future<List<Bil_Mov_D_Local>> GET_SUM_DetailedItem_REP(String TAB_M,String TAB_D,String GETBIID_F,String GETBIID_T,String GETBMMDO_F,
    String GETBMMDO_T,String GETMGNO_F,String GETMGNO_T,String GETMINO_F,String GETMINO_T,String GETPKID,
    String GETSCID,String GETBMKID,String GETBMMST) async {
  var dbClient = await conn.database;
  String sql;
  String sql2='';
  String M='';
  String N='';
  String PKIDsql='';
  String SCIDsql='';
  (GETMGNO_F.isEmpty || GETMGNO_F=='null') && (GETMGNO_T.isEmpty || GETMGNO_T=='null')?
  M =" " : M="  AND A.MGNO BETWEEN '$GETMGNO_F' AND '$GETMGNO_F'";
  (GETMINO_F.isEmpty || GETMINO_F=='null') && (GETMINO_T.isEmpty || GETMINO_T=='null')?
  N =" " : N="  AND A.MINO BETWEEN '$GETMINO_F' AND '$GETMINO_T'";
  (GETPKID.isEmpty || GETPKID=='null') ? PKIDsql= "":PKIDsql= "  AND F.PKID=$GETPKID  ";
  (GETSCID.isEmpty || GETSCID=='null') ? SCIDsql= "":SCIDsql= " AND F.SCID=$GETSCID  ";

  String Wheresql1='';
  String Wheresql2='';

  LoginController().BIID_ALL_V=='1'? Wheresql1= " AND  F.BIID_L=${LoginController().BIID}":Wheresql1='';
  LoginController().BIID_ALL_V=='1'? Wheresql2= " AND  A.BIID_L=${LoginController().BIID}":Wheresql2='';


  sql =" SELECT ifnull(SUM(A.BMDNO),0.0) AS BMDNO,ifnull(SUM(A.BMDAMT+A.BMDTXT),0.0) AS BMDAMT "
      " FROM $TAB_D A,$TAB_M F "
      " WHERE $sql2 A.JTID_L=${LoginController().JTID} AND A.SYID_L=${LoginController().SYID} AND "
      " A.CIID_L=${LoginController().CIID} $Wheresql2 AND A.BMMID=F.BMMID AND  F.BMKID=A.BMKID AND "
      " F.JTID_L=${LoginController().JTID} AND F.SYID_L=${LoginController().SYID} AND "
      " F.CIID_L=${LoginController().CIID} $Wheresql1 AND  F.BMMDOR BETWEEN '$GETBMMDO_F' AND '$GETBMMDO_T' "
      " AND F.BMKID=$GETBMKID AND  F.BMMST=$GETBMMST  $PKIDsql $SCIDsql $M  $N";

  final result = await dbClient!.rawQuery(sql);
  return result.map((json) => Bil_Mov_D_Local.fromMap(json)).toList();
}

Future<List<Bil_Mov_D_Local>> GET_TotalDetailedItem_REP(int TYPE,String TAB_M,String TAB_D,String GETBIID_F,String GETBIID_T,String GETBMMDO_F,
    String GETBMMDO_T,String GETMGNO_F,String GETMGNO_T,String GETMINO_F,String GETMINO_T,
    String GETPKID,String GETSCID,String GETBMKID,
    String GETBMMST) async {
  var dbClient = await conn.database;
  String sql;
  String sql2='';
  String S='';
  String M='';
  String N='';
  String PKIDsql='';
  String SCIDsql='';
  (GETMGNO_F.isEmpty || GETMGNO_F=='null') && (GETMGNO_T.isEmpty || GETMGNO_T=='null')?
  M =" " : M="  AND A.MGNO BETWEEN '$GETMGNO_F' AND '$GETMGNO_F'";
  (GETMINO_F.isEmpty || GETMINO_F=='null') && (GETMINO_T.isEmpty || GETMINO_T=='null')?
  N =" " : N="  AND A.MINO BETWEEN '$GETMINO_F' AND '$GETMINO_T'";
  (GETPKID.isEmpty || GETPKID=='null') ? PKIDsql= "":PKIDsql= " F.PKID=$GETPKID AND";
  (GETSCID.isEmpty || GETSCID=='null') ? SCIDsql= "":SCIDsql= " F.SCID=$GETSCID AND";

  String Wheresql1='';
  String Wheresql2='';
  String Wheresql3='';
  String Wheresql4='';
  String Wheresql5='';
  String Wheresql6='';
  LoginController().BIID_ALL_V=='1'? Wheresql1= " AND  F.BIID_L=${LoginController().BIID}":Wheresql1='';
  LoginController().BIID_ALL_V=='1'? Wheresql2= " AND  A.BIID_L=${LoginController().BIID}":Wheresql2='';
  LoginController().BIID_ALL_V=='1'? Wheresql4= " AND  B.BIID_L=${LoginController().BIID}":Wheresql4='';
  LoginController().BIID_ALL_V=='1'? Wheresql5= " AND  D.BIID_L=${LoginController().BIID}":Wheresql5='';
  LoginController().BIID_ALL_V=='1'? Wheresql6= " AND  C.BIID_L=${LoginController().BIID}":Wheresql6='';
  LoginController().BIID_ALL_V=='1'? Wheresql3= " AND  E.BIID_L=${LoginController().BIID}":Wheresql3='';

  sql2 =" SELECT ifnull(SUM(A.BMDNO),0.0) AS BMDNO,ifnull(SUM(A.BMDNF),0.0) AS BMDNF,ifnull(SUM(A.BMDAMT),0.0) AS BMDAMT,"
      "  CASE WHEN ${LoginController().LAN}=2 AND B.MINE IS NOT NULL THEN B.MINE ELSE B.MINA END  MINA_D,"
      " CASE WHEN ${LoginController().LAN}=2 AND E.MUNE IS NOT NULL THEN E.MUNE ELSE E.MUNA END  MUNA_D"
      "  FROM $TAB_D A,MAT_INF B,MAT_UNI_C C,MAT_GRO D,MAT_UNI E,$TAB_M F"
      " WHERE F.BMMST=$GETBMMST AND A.JTID_L=${LoginController().JTID} AND A.SYID_L=${LoginController().SYID} AND "
      " A.CIID_L=${LoginController().CIID} $Wheresql2 AND A.BMMID=F.BMMID AND  F.BMKID=A.BMKID AND "
      " F.JTID_L=${LoginController().JTID} AND F.SYID_L=${LoginController().SYID} AND "
      " F.CIID_L=${LoginController().CIID} $Wheresql1 AND  F.BMMDOR BETWEEN '$GETBMMDO_F' AND '$GETBMMDO_T' "
      " AND F.BMKID=$GETBMKID AND $PKIDsql $SCIDsql"
      " B.JTID_L=${LoginController().JTID} AND B.SYID_L=${LoginController().SYID} AND "
      " B.CIID_L=${LoginController().CIID} $Wheresql4 AND (A.MGNO=B.MGNO AND A.MINO=B.MINO) AND "
      " D.JTID_L=${LoginController().JTID} AND D.SYID_L=${LoginController().SYID} AND "
      " D.CIID_L=${LoginController().CIID} $Wheresql5 AND (A.MGNO=D.MGNO) AND "
      " C.JTID_L=${LoginController().JTID} AND C.SYID_L=${LoginController().SYID} AND "
      " C.CIID_L=${LoginController().CIID} $Wheresql6 AND (A.MGNO=C.MGNO AND A.MINO=C.MINO AND A.MUID=C.MUID) AND "
      " E.JTID_L=${LoginController().JTID} AND E.SYID_L=${LoginController().SYID} AND "
      " E.CIID_L=${LoginController().CIID} $Wheresql3 AND (A.MUID=E.MUID) $S  $M  $N   GROUP BY A.MGNO,A.MINO,A.MUID";

  sql =" SELECT A.*,"
      " CASE WHEN ${LoginController().LAN}=2 AND B.MINE IS NOT NULL THEN B.MINE ELSE B.MINA END  MINA_D,"
      " F.BMMNA AS NAM_D ,"
      " CASE WHEN ${LoginController().LAN}=2 AND D.MGNE IS NOT NULL THEN D.MGNE ELSE D.MGNA END  MGNA_D,"
      " CASE WHEN ${LoginController().LAN}=2 AND E.MUNE IS NOT NULL THEN E.MUNE ELSE E.MUNA END  MUNA_D"
      "  FROM $TAB_D A,MAT_INF B,MAT_UNI_C C,MAT_GRO D,MAT_UNI E,$TAB_M F"
      " WHERE  A.JTID_L=${LoginController().JTID} AND A.SYID_L=${LoginController().SYID} AND "
      " A.CIID_L=${LoginController().CIID} $Wheresql2 AND A.BMMID=F.BMMID AND  F.BMKID=A.BMKID AND "
      " F.JTID_L=${LoginController().JTID} AND F.SYID_L=${LoginController().SYID} AND "
      " F.CIID_L=${LoginController().CIID} $Wheresql1 AND  F.BMMDOR BETWEEN '$GETBMMDO_F' AND '$GETBMMDO_T' "
      " AND F.BMKID=$GETBMKID AND $PKIDsql $SCIDsql"
      " B.JTID_L=${LoginController().JTID} AND B.SYID_L=${LoginController().SYID} AND "
      " B.CIID_L=${LoginController().CIID} $Wheresql4 AND (A.MGNO=B.MGNO AND A.MINO=B.MINO) AND "
      " D.JTID_L=${LoginController().JTID} AND D.SYID_L=${LoginController().SYID} AND "
      " D.CIID_L=${LoginController().CIID} $Wheresql5 AND (A.MGNO=D.MGNO) AND "
      " C.JTID_L=${LoginController().JTID} AND C.SYID_L=${LoginController().SYID} AND "
      " C.CIID_L=${LoginController().CIID} $Wheresql6 AND (A.MGNO=C.MGNO AND A.MINO=C.MINO AND A.MUID=C.MUID) AND "
      " E.JTID_L=${LoginController().JTID} AND E.SYID_L=${LoginController().SYID} AND "
      " E.CIID_L=${LoginController().CIID} $Wheresql3 AND (A.MUID=E.MUID) $S  $M  $N  "
      " ORDER BY A.SIID,A.MGNO,A.MINO";
  print(TYPE);
  print(TYPE==101?sql2:sql);
  print(sql);
  print('GET_TotalDetailedItem_REP');
  final result = await dbClient!.rawQuery(TYPE==101?sql2:sql);
  return result.map((json) => Bil_Mov_D_Local.fromMap(json)).toList();
}


//تقرير حركة جرد+تقرير حركة تحويل
Future<List<Sto_Mov_D_Local>> Get_Inv_Tra_Mov_Rep(int GET_SMKID,String F_BIID,String T_BIID,String F_SMMDO,String T_SMMDO,
    String F_MGNO,String T_MGNO,String GetTypeValue,String F_SMMNO,String T_SMMNO,String F_SIID,String T_SIID) async {
  var dbClient = await conn.database;
  String MGNOsql='';
  String SMMNOsql='';
  String SIIDsql='';
  String GetTypeValuesql='';

  if(F_MGNO!='null' || T_MGNO!='null' ){
    MGNOsql=" A.MGNO BETWEEN '$F_MGNO' AND '$T_MGNO' and";
  }

  if(F_SIID.isNotEmpty || T_SIID.isNotEmpty){
    SIIDsql=" A.SIID BETWEEN '$F_SIID' AND '$T_SIID' and";
  }

  if(F_SMMNO.isNotEmpty || T_SMMNO.isNotEmpty){
    SMMNOsql=" B.SMMNO BETWEEN '$F_SMMNO' AND '$T_SMMNO' and";
  }

  // النوع زياده او عجز او .....
  GetTypeValue=="Minus"?GetTypeValuesql='SMDNF<SMDNO and':GetTypeValue=="Plus"?GetTypeValuesql='SMDNF>SMDNO and':
  GetTypeValue=="Equil"?GetTypeValuesql='SMDNF=SMDNO and':GetTypeValuesql='';


  String sql;
  String sql2='';
  if(LoginController().BIID_ALL_V=='1'){
    sql2= " AND  A.BIID_L=${LoginController().BIID}   ";
  }

  String Wheresql3='';
  String Wheresql4='';
  String Wheresql5='';
  String Wheresql6='';
  LoginController().BIID_ALL_V=='1'? Wheresql3= " AND  C.BIID_L=${LoginController().BIID}":Wheresql3='';
  LoginController().BIID_ALL_V=='1'? Wheresql4= " AND  D.BIID_L=${LoginController().BIID}":Wheresql4='';
  LoginController().BIID_ALL_V=='1'? Wheresql5= " AND  E.BIID_L=${LoginController().BIID}":Wheresql5='';
  LoginController().BIID_ALL_V=='1'? Wheresql6= " AND  F.BIID_L=${LoginController().BIID}":Wheresql6='';

  sql =" SELECT *,CASE WHEN ${LoginController().LAN}=2 AND D.MINE IS NOT NULL THEN D.MINE ELSE D.MINA END  MINA_D,"
      " CASE WHEN ${LoginController().LAN}=2 AND E.MUNE IS NOT NULL THEN E.MUNE ELSE E.MUNA END  MUNA_D "
      " FROM STO_MOV_D A,MAT_GRO C,MAT_INF D,MAT_UNI E,STO_MOV_M B,BRA_INF F  "
      " WHERE $MGNOsql $SIIDsql $GetTypeValuesql   EXISTS(SELECT 1 FROM STO_MOV_M B WHERE"
      " $SMMNOsql  B.SMMID=A.SMMID AND B.SMKID=A.SMKID"
      " AND B.BIID BETWEEN $F_BIID AND $T_BIID  AND SMMDA BETWEEN '$F_SMMDO' AND '$T_SMMDO') AND "
      "C.JTID_L=${LoginController().JTID} AND C.SYID_L=${LoginController().SYID} AND "
      "C.CIID_L=${LoginController().CIID} $Wheresql3 AND A.MGNO=C.MGNO AND "
      "D.JTID_L=${LoginController().JTID} AND D.SYID_L=${LoginController().SYID} AND "
      "D.CIID_L=${LoginController().CIID} $Wheresql4 AND (A.MINO=D.MINO AND A.MGNO=D.MGNO) AND "
      "E.JTID_L=${LoginController().JTID} AND E.SYID_L=${LoginController().SYID} AND "
      "E.CIID_L=${LoginController().CIID} $Wheresql5 AND E.MUID=A.MUID "
      " AND A.SMMID=B.SMMID AND "
      "F.JTID_L=${LoginController().JTID} AND F.SYID_L=${LoginController().SYID} AND "
      "F.CIID_L=${LoginController().CIID} $Wheresql6 AND F.BIID=B.BIID  "
      "AND A.SMKID=$GET_SMKID AND A.JTID_L=${LoginController().JTID} "
      " AND A.SYID_L=${LoginController().SYID} AND  A.CIID_L='${LoginController().CIID}'  $sql2"
      " ORDER BY A.SMMID ";

  var result = await dbClient!.rawQuery(sql);
  List<Sto_Mov_D_Local> list = result.map((item) {
    return Sto_Mov_D_Local.fromMap(item);
  }).toList();
  print(result);
  print(sql);
  print('Sto_Mov_D_Local');
  return list;
}

Future<List<Sto_Mov_D_Local>> Get_Mat_Mov_Rep(String F_BIID,String T_BIID,String F_SMMDO,String T_SMMDO,
    String F_MGNO,String T_MGNO,String GetTypeValue,String F_SMMNO,String T_SMMNO,String F_SIID,String T_SIID) async {
  var dbClient = await conn.database;
  String MGNOsql='';
  String SIIDsql='';
  String SMMNOsql='';
  String GetTypeValue2sql='';

  if(F_MGNO.toString()!='null' || T_MGNO.toString()!='null'){
    MGNOsql=" C.MGNO BETWEEN '$F_MGNO' AND '$T_MGNO' and ";
  }

  if(F_SMMNO.isNotEmpty || T_SMMNO.isNotEmpty){
    SMMNOsql=" E.SMMNO BETWEEN '$F_SMMNO' AND '$T_SMMNO' and";
  }
  if(F_SIID.isNotEmpty || T_SIID.isNotEmpty){
    SIIDsql=" B.SIID BETWEEN '$F_SIID' AND '$T_SIID' and";
  }

  //لها كمية
  GetTypeValue=="Plus"?GetTypeValue2sql='B.SNNO>0 and':
  //ليس لها كمية
  GetTypeValue=="Equil"?GetTypeValue2sql='B.SNNO=0 and':GetTypeValue2sql='';

  String sql;
  String sql2='';
  String Wheresql3='';
  String Wheresql4='';
  String Wheresql5='';
  String Wheresql6='';
  if(LoginController().BIID_ALL_V=='1'){
    sql2= " AND  E.BIID_L=${LoginController().BIID}   ";
  }
  LoginController().BIID_ALL_V=='1'? Wheresql3= " AND  C.BIID_L=${LoginController().BIID}":Wheresql3='';
  LoginController().BIID_ALL_V=='1'? Wheresql4= " AND  A.BIID_L=${LoginController().BIID}":Wheresql4='';
  LoginController().BIID_ALL_V=='1'? Wheresql5= " AND  D.BIID_L=${LoginController().BIID}":Wheresql5='';
  LoginController().BIID_ALL_V=='1'? Wheresql6= " AND  B.BIID_L=${LoginController().BIID}":Wheresql6='';

  sql ="SELECT *,CASE WHEN ${LoginController().LAN}=2 AND A.MINE IS NOT NULL THEN A.MINE ELSE A.MINA END  MINA_D,"
      " CASE WHEN ${LoginController().LAN}=2 AND D.MUNE IS NOT NULL THEN D.MUNE ELSE D.MUNA END  MUNA_D "
      ",B.SNNO AS SMDNO,B.SNED AS SMDED  FROM MAT_INF A,MAT_GRO C,STO_NUM B,MAT_UNI D WHERE  "
      "NOT EXISTS(SELECT 1 FROM STO_MOV_D B,STO_MOV_M E WHERE "
      "$SMMNOsql  A.JTID_L=${LoginController().JTID} AND A.SYID_L=${LoginController().SYID} AND "
      " A.CIID_L=${LoginController().CIID} $Wheresql4 AND(A.MGNO=B.MGNO AND A.MINO=B.MINO) "
      " AND B.SMKID=17 AND D.JTID_L=${LoginController().JTID} AND D.SYID_L=${LoginController().SYID} AND "
      " D.CIID_L=${LoginController().CIID} $Wheresql5 AND B.MUID=D.MUID AND E.SMMID=B.SMMID "
      " AND E.BIID BETWEEN $F_BIID AND $T_BIID  AND E.SMMDA BETWEEN '$F_SMMDO' AND '$T_SMMDO'"
      " AND E.JTID_L=${LoginController().JTID} "
      " AND E.SYID_L=${LoginController().SYID}   AND E.CIID_L='${LoginController().CIID}' $sql2)"
      " AND $SIIDsql  $MGNOsql $GetTypeValue2sql "
      " C.JTID_L=${LoginController().JTID} AND C.SYID_L=${LoginController().SYID} AND "
      " C.CIID_L=${LoginController().CIID} $Wheresql3 AND A.MGNO=C.MGNO AND "
      " A.JTID_L=${LoginController().JTID} AND A.SYID_L=${LoginController().SYID} AND "
      " A.CIID_L=${LoginController().CIID} $Wheresql4 AND A.MGNO=B.MGNO AND A.MINO=B.MINO AND "
      " D.JTID_L=${LoginController().JTID} AND D.SYID_L=${LoginController().SYID} AND "
      " D.CIID_L=${LoginController().CIID} $Wheresql5 AND D.MUID=B.MUID AND "
      " B.JTID_L=${LoginController().JTID} AND B.SYID_L=${LoginController().SYID} AND "
      " B.CIID_L=${LoginController().CIID} $Wheresql6"
      " ORDER BY A.MGNO,A.MINO";

  var result = await dbClient!.rawQuery(sql);
  List<Sto_Mov_D_Local> list = result.map((item) {
    return Sto_Mov_D_Local.fromMap(item);
  }).toList();
  return list;
}

Future<int?>Get_SUM_ITEM(int GET_SMKID,String F_BIID,String T_BIID,String F_SMMDO,String T_SMMDO,
    String F_MGNO,String T_MGNO,String GetTypeValue,String F_SMMNO,String T_SMMNO,String F_SIID,String T_SIID) async {
  var dbClient = await conn.database;
  String MGNOsql='';
  String SMMNOsql='';
  String SIIDsql='';
  String GetTypeValuesql='';

  if(F_MGNO.toString()!='null' || T_MGNO.toString()!='null'){
    MGNOsql=" A.MGNO BETWEEN '$F_MGNO' AND '$T_MGNO' and ";
  }

  if(F_SIID.isNotEmpty || T_SIID.isNotEmpty){
    SIIDsql=" A.SIID BETWEEN '$F_SIID' AND '$T_SIID' and ";
  }

  if(F_SMMNO.isNotEmpty || T_SMMNO.isNotEmpty){
    SMMNOsql=" B.SMMNO BETWEEN '$F_SMMNO' AND '$T_SMMNO' and ";
  }

  // النوع زياده او عجز او .....
  GetTypeValue=="Minus"?GetTypeValuesql='SMDNF<SMDNO and':GetTypeValue=="Plus"?GetTypeValuesql='SMDNF>SMDNO and':
  GetTypeValue=="Equil"?GetTypeValuesql='SMDNF=SMDNO and':GetTypeValuesql='';

  String sql;
  String sql2;
  String sql3;
  String sql4;
  String sql5;
  String sql6;
  String sql7='';
  String Wheresql3='';
  String Wheresql4='';
  String Wheresql5='';
  String Wheresql6='';

  if(LoginController().BIID_ALL_V=='1'){
    sql7= " AND A.BIID_L=${LoginController().BIID}   ";
  }
  LoginController().BIID_ALL_V=='1'? Wheresql3= " AND  C.BIID_L=${LoginController().BIID}":Wheresql3='';
  LoginController().BIID_ALL_V=='1'? Wheresql4= " AND  D.BIID_L=${LoginController().BIID}":Wheresql4='';
  LoginController().BIID_ALL_V=='1'? Wheresql5= " AND  E.BIID_L=${LoginController().BIID}":Wheresql5='';
  LoginController().BIID_ALL_V=='1'? Wheresql6= " AND  F.BIID_L=${LoginController().BIID}":Wheresql6='';

  //عدد الاصناف
  sql =" select count(A) from (select DISTINCT(A.MINO||A.MGNO)  AS A "
      " FROM STO_MOV_D A,MAT_GRO C,MAT_INF D,MAT_UNI E,STO_MOV_M B,BRA_INF F  "
      " where $MGNOsql $SIIDsql $GetTypeValuesql   EXISTS(SELECT 1 FROM STO_MOV_M B WHERE"
      " $SMMNOsql  B.SMMID=A.SMMID AND B.SMKID=A.SMKID"
      " AND B.BIID BETWEEN $F_BIID AND $T_BIID  AND SMMDA BETWEEN '$F_SMMDO' AND '$T_SMMDO')"
      " AND C.JTID_L=${LoginController().JTID} AND C.SYID_L=${LoginController().SYID} AND "
      " C.CIID_L=${LoginController().CIID} $Wheresql3 AND A.MGNO=C.MGNO "
      "AND D.JTID_L=${LoginController().JTID} AND D.SYID_L=${LoginController().SYID} AND "
      " D.CIID_L=${LoginController().CIID} $Wheresql4 AND (A.MINO=D.MINO AND A.MGNO=D.MGNO) AND "
      " E.JTID_L=${LoginController().JTID} AND E.SYID_L=${LoginController().SYID} AND "
      " E.CIID_L=${LoginController().CIID} $Wheresql5 AND E.MUID=A.MUID  "
      " and A.SMMID=B.SMMID AND F.JTID_L=${LoginController().JTID} AND F.SYID_L=${LoginController().SYID} AND "
      " F.CIID_L=${LoginController().CIID} $Wheresql6 AND F.BIID=B.BIID  "
      " and A.SMKID=$GET_SMKID AND A.JTID_L=${LoginController().JTID} "
      " AND A.SYID_L=${LoginController().SYID}  AND A.CIID_L='${LoginController().CIID}'  $sql7"
      " ORDER BY A.SMMID)";

  //Minus//ناقص
  sql2 =" SELECT count(A.SMDDF) FROM STO_MOV_D A,MAT_GRO C,MAT_INF D,MAT_UNI E,STO_MOV_M B,BRA_INF F  "
      " where $MGNOsql $SIIDsql $GetTypeValuesql  A.SMDNF<A.SMDNO and EXISTS(SELECT 1 FROM STO_MOV_M B WHERE"
      " $SMMNOsql  B.SMMID=A.SMMID AND B.SMKID=A.SMKID"
      " AND B.BIID BETWEEN $F_BIID AND $T_BIID  AND SMMDA BETWEEN '$F_SMMDO' AND '$T_SMMDO')"
      " AND C.JTID_L=${LoginController().JTID} AND C.SYID_L=${LoginController().SYID} AND "
      " C.CIID_L=${LoginController().CIID} $Wheresql3 AND A.MGNO=C.MGNO "
      "AND D.JTID_L=${LoginController().JTID} AND D.SYID_L=${LoginController().SYID} AND "
      " D.CIID_L=${LoginController().CIID} $Wheresql4 AND (A.MINO=D.MINO AND A.MGNO=D.MGNO) AND "
      " E.JTID_L=${LoginController().JTID} AND E.SYID_L=${LoginController().SYID} AND "
      " E.CIID_L=${LoginController().CIID} $Wheresql5 AND E.MUID=A.MUID  "
      " and A.SMMID=B.SMMID AND F.JTID_L=${LoginController().JTID} AND F.SYID_L=${LoginController().SYID} AND "
      " F.CIID_L=${LoginController().CIID} $Wheresql6 AND F.BIID=B.BIID  "
      " and A.SMKID=$GET_SMKID AND A.JTID_L=${LoginController().JTID} "
      " AND A.SYID_L=${LoginController().SYID}  AND A.CIID_L='${LoginController().CIID}'  $sql7"
      " ORDER BY A.SMMID";

  //Plus//زائد
  sql3 =" SELECT count(A.SMDDF) FROM STO_MOV_D A,MAT_GRO C,MAT_INF D,MAT_UNI E,STO_MOV_M B,BRA_INF F  "
      " where $MGNOsql $SIIDsql $GetTypeValuesql  A.SMDNF>A.SMDNO and EXISTS(SELECT 1 FROM STO_MOV_M B WHERE"
      " $SMMNOsql  B.SMMID=A.SMMID AND B.SMKID=A.SMKID"
      " AND B.BIID BETWEEN $F_BIID AND $T_BIID  AND SMMDA BETWEEN '$F_SMMDO' AND '$T_SMMDO')"
      " AND C.JTID_L=${LoginController().JTID} AND C.SYID_L=${LoginController().SYID} AND "
      " C.CIID_L=${LoginController().CIID} $Wheresql3 AND A.MGNO=C.MGNO "
      "AND D.JTID_L=${LoginController().JTID} AND D.SYID_L=${LoginController().SYID} AND "
      " D.CIID_L=${LoginController().CIID} $Wheresql4 AND (A.MINO=D.MINO AND A.MGNO=D.MGNO) AND "
      " E.JTID_L=${LoginController().JTID} AND E.SYID_L=${LoginController().SYID} AND "
      " E.CIID_L=${LoginController().CIID} $Wheresql5 AND E.MUID=A.MUID  "
      " and A.SMMID=B.SMMID AND F.JTID_L=${LoginController().JTID} AND F.SYID_L=${LoginController().SYID} AND "
      " F.CIID_L=${LoginController().CIID} $Wheresql6 AND F.BIID=B.BIID  "
      " and A.SMKID=$GET_SMKID AND A.JTID_L=${LoginController().JTID} "
      " AND A.SYID_L=${LoginController().SYID}  AND A.CIID_L='${LoginController().CIID}'  $sql7"
      " ORDER BY A.SMMID ";

  //Equil//مطابق
  sql4 =" SELECT count(A.SMDDF) FROM STO_MOV_D A,MAT_GRO C,MAT_INF D,MAT_UNI E,STO_MOV_M B,BRA_INF F  "
      " where $MGNOsql $SIIDsql $GetTypeValuesql  A.SMDNF=A.SMDNO and EXISTS(SELECT 1 FROM STO_MOV_M B WHERE"
      " $SMMNOsql  B.SMMID=A.SMMID AND B.SMKID=A.SMKID"
      " AND B.BIID BETWEEN $F_BIID AND $T_BIID  AND SMMDA BETWEEN '$F_SMMDO' AND '$T_SMMDO')"
      " AND C.JTID_L=${LoginController().JTID} AND C.SYID_L=${LoginController().SYID} AND "
      " C.CIID_L=${LoginController().CIID} $Wheresql3 AND A.MGNO=C.MGNO "
      "AND D.JTID_L=${LoginController().JTID} AND D.SYID_L=${LoginController().SYID} AND "
      " D.CIID_L=${LoginController().CIID} $Wheresql4 AND (A.MINO=D.MINO AND A.MGNO=D.MGNO) AND "
      " E.JTID_L=${LoginController().JTID} AND E.SYID_L=${LoginController().SYID} AND "
      " E.CIID_L=${LoginController().CIID} $Wheresql5 AND E.MUID=A.MUID  "
      " and A.SMMID=B.SMMID AND F.JTID_L=${LoginController().JTID} AND F.SYID_L=${LoginController().SYID} AND "
      " F.CIID_L=${LoginController().CIID} $Wheresql6 AND F.BIID=B.BIID  "
      " and A.SMKID=$GET_SMKID AND A.JTID_L=${LoginController().JTID} "
      " AND A.SYID_L=${LoginController().SYID}  AND A.CIID_L='${LoginController().CIID}'  $sql7"
      " ORDER BY A.SMMID ";

//SUM_SMDNO//اجمالي الكمية
  sql5 =" SELECT SUM(A.SMDNO) FROM STO_MOV_D A,MAT_GRO C,MAT_INF D,MAT_UNI E,STO_MOV_M B,BRA_INF F  "
      " where $MGNOsql $SIIDsql $GetTypeValuesql   EXISTS(SELECT 1 FROM STO_MOV_M B WHERE"
      " $SMMNOsql  B.SMMID=A.SMMID AND B.SMKID=A.SMKID"
      " AND B.BIID BETWEEN $F_BIID AND $T_BIID  AND SMMDA BETWEEN '$F_SMMDO' AND '$T_SMMDO')"
      " AND C.JTID_L=${LoginController().JTID} AND C.SYID_L=${LoginController().SYID} AND "
      " C.CIID_L=${LoginController().CIID} $Wheresql3 AND A.MGNO=C.MGNO "
      "AND D.JTID_L=${LoginController().JTID} AND D.SYID_L=${LoginController().SYID} AND "
      " D.CIID_L=${LoginController().CIID} $Wheresql4 AND (A.MINO=D.MINO AND A.MGNO=D.MGNO) AND "
      " E.JTID_L=${LoginController().JTID} AND E.SYID_L=${LoginController().SYID} AND "
      " E.CIID_L=${LoginController().CIID} $Wheresql5 AND E.MUID=A.MUID  "
      " and A.SMMID=B.SMMID AND F.JTID_L=${LoginController().JTID} AND F.SYID_L=${LoginController().SYID} AND "
      " F.CIID_L=${LoginController().CIID} $Wheresql6 AND F.BIID=B.BIID  "
      " and A.SMKID=$GET_SMKID AND A.JTID_L=${LoginController().JTID} "
      " AND A.SYID_L=${LoginController().SYID}  AND A.CIID_L='${LoginController().CIID}'  $sql7"
      " ORDER BY A.SMMID ";

  //SUM_SMDDF//الفارق
  sql6 =" SELECT COUNT(A.SMDDF) FROM STO_MOV_D A,MAT_GRO C,MAT_INF D,MAT_UNI E,STO_MOV_M B,BRA_INF F  "
      " where $MGNOsql $SIIDsql $GetTypeValuesql   A.SMDNF<A.SMDNO and EXISTS(SELECT 1 FROM STO_MOV_M B WHERE"
      " $SMMNOsql  B.SMMID=A.SMMID AND B.SMKID=A.SMKID"
      " AND B.BIID BETWEEN $F_BIID AND $T_BIID  AND SMMDA BETWEEN '$F_SMMDO' AND '$T_SMMDO')"
      " AND C.JTID_L=${LoginController().JTID} AND C.SYID_L=${LoginController().SYID} AND "
      " C.CIID_L=${LoginController().CIID} $Wheresql3 AND A.MGNO=C.MGNO "
      "AND D.JTID_L=${LoginController().JTID} AND D.SYID_L=${LoginController().SYID} AND "
      " D.CIID_L=${LoginController().CIID} $Wheresql4 AND (A.MINO=D.MINO AND A.MGNO=D.MGNO) AND  "
      " E.JTID_L=${LoginController().JTID} AND E.SYID_L=${LoginController().SYID} AND "
      " E.CIID_L=${LoginController().CIID} $Wheresql5 AND E.MUID=A.MUID  "
      " and A.SMMID=B.SMMID AND F.JTID_L=${LoginController().JTID} AND F.SYID_L=${LoginController().SYID} AND "
      " F.CIID_L=${LoginController().CIID} $Wheresql6 AND F.BIID=B.BIID  "
      " and A.SMKID=$GET_SMKID AND A.JTID_L=${LoginController().JTID} "
      " AND A.SYID_L=${LoginController().SYID}  AND A.CIID_L='${LoginController().CIID}'  $sql7"
      " ORDER BY A.SMMID ";


  var x = await dbClient!.rawQuery(sql);
  var x2 = await dbClient.rawQuery(sql2);
  var x3 = await dbClient.rawQuery(sql3);
  var x4 = await dbClient.rawQuery(sql4);
  var x6 = await dbClient.rawQuery(sql6);
  COUNTMINO_ITEM = Sqflite.firstIntValue(x);
  Minus_ITEM = Sqflite.firstIntValue(x2);
  PLUS_ITEM = Sqflite.firstIntValue(x3);
  Equil_ITEM = Sqflite.firstIntValue(x4);
  SUM_SMDDF_ITEM = Sqflite.firstIntValue(x6);
  print(sql);
  print(sql2);
  print(sql3);
  print(sql4);
  print(sql5);
  print(sql6);
  print('Get_SUM_ITEM');
  return null;
}


Future<List<Sto_Mov_D_Local>> GET_SUMSMDNF(int GET_SMKID,String F_BIID,String T_BIID,String F_SMMDO,String T_SMMDO,
    String F_MGNO,String T_MGNO,String GetTypeValue,String F_SMMNO,String T_SMMNO,String F_SIID,String T_SIID) async {
  var dbClient = await conn.database;
  String MGNOsql='';
  String SMMNOsql='';
  String SIIDsql='';
  String GetTypeValuesql='';

  if(F_MGNO.toString()!='null' || T_MGNO.toString()!='null'){
    MGNOsql=" A.MGNO BETWEEN '$F_MGNO' AND '$T_MGNO' and ";
  }


  if(F_SIID.isNotEmpty || T_SIID.isNotEmpty){
    SIIDsql=" A.SIID BETWEEN '$F_SIID' AND '$T_SIID' and";
  }

  if(F_SMMNO.isNotEmpty || T_SMMNO.isNotEmpty){
    SMMNOsql=" B.SMMNO BETWEEN '$F_SMMNO' AND '$T_SMMNO' and";
  }

  // النوع زياده او عجز او .....
  GetTypeValue=="Minus"?GetTypeValuesql='SMDNF<SMDNO and':GetTypeValue=="Plus"?GetTypeValuesql='SMDNF>SMDNO and':
  GetTypeValue=="Equil"?GetTypeValuesql='SMDNF=SMDNO and':GetTypeValuesql='';

  String sql;
  String sql2='';
  String Wheresql='';
  String Wheresql2='';
  String Wheresql3='';
  String Wheresql4='';
  String Wheresql5='';

  LoginController().BIID_ALL_V=='1'? Wheresql= " AND  C.BIID_L=${LoginController().BIID}":Wheresql='';
  LoginController().BIID_ALL_V=='1'? Wheresql2= " AND  D.BIID_L=${LoginController().BIID}":Wheresql2='';
  LoginController().BIID_ALL_V=='1'? Wheresql3= " AND  E.BIID_L=${LoginController().BIID}":Wheresql3='';
  LoginController().BIID_ALL_V=='1'? Wheresql4= " AND  B.BIID_L=${LoginController().BIID}":Wheresql4='';
  LoginController().BIID_ALL_V=='1'? Wheresql5= " AND  F.BIID_L=${LoginController().BIID}":Wheresql5='';

  if(LoginController().BIID_ALL_V=='1'){
    sql2= "  AND A.BIID_L=${LoginController().BIID}   ";
  }
  sql =" select ifnull(sum(A.SMDNO),0.0) AS SUM,ifnull(sum(A.SMDNF),0.0) AS SUMSMDFN "
      "FROM STO_MOV_D A,MAT_GRO C,MAT_INF D,MAT_UNI E,STO_MOV_M B,BRA_INF F"
      " where $MGNOsql $SIIDsql $GetTypeValuesql   EXISTS(SELECT 1 FROM STO_MOV_M B WHERE"
      " $SMMNOsql  B.SMMID=A.SMMID AND B.SMKID=A.SMKID"
      " AND B.BIID BETWEEN $F_BIID AND $T_BIID  AND SMMDA BETWEEN '$F_SMMDO' AND '$T_SMMDO'"
      " AND B.JTID_L=${LoginController().JTID} AND B.SYID_L=${LoginController().SYID} AND "
      " B.CIID_L=${LoginController().CIID} $Wheresql4)"
      " and  A.MGNO=C.MGNO and A.MINO=D.MINO and E.MUID=A.MUID AND A.MGNO=D.MGNO "
      " and A.SMMID=B.SMMID AND F.BIID=B.BIID  and A.SMKID=$GET_SMKID AND A.JTID_L=${LoginController().JTID} "
      " AND A.SYID_L=${LoginController().SYID}   AND A.CIID_L='${LoginController().CIID}'  $sql2"
      " AND C.JTID_L=${LoginController().JTID} AND C.SYID_L=${LoginController().SYID} AND "
      " C.CIID_L=${LoginController().CIID} $Wheresql"
      " AND D.JTID_L=${LoginController().JTID} AND D.SYID_L=${LoginController().SYID} AND "
      " D.CIID_L=${LoginController().CIID} $Wheresql2"
      " AND E.JTID_L=${LoginController().JTID} AND E.SYID_L=${LoginController().SYID} AND "
      " E.CIID_L=${LoginController().CIID} $Wheresql3"
      " AND B.JTID_L=${LoginController().JTID} AND B.SYID_L=${LoginController().SYID} AND "
      " B.CIID_L=${LoginController().CIID} $Wheresql4"
      " AND F.JTID_L=${LoginController().JTID} AND F.SYID_L=${LoginController().SYID} AND "
      " F.CIID_L=${LoginController().CIID} $Wheresql5"
      " ORDER BY A.SMMID";

  var result = await dbClient!.rawQuery(sql);
  //if (result.length == 0) return null;
  List<Sto_Mov_D_Local> list = result.map((item) {
    return Sto_Mov_D_Local.fromMapSum(item);
  }).toList();
  return list;
}


Future<int?>Get_SUM_MAT(String F_BIID,String T_BIID,String F_SMMDO,String T_SMMDO,
    String F_MGNO,String T_MGNO,String GetTypeValue,String F_SMMNO,String T_SMMNO,String F_SIID,String T_SIID) async {
  var dbClient = await conn.database;
  String MGNOsql='';
  String SIIDsql='';
  String SMMNOsql='';
  String GetTypeValue2sql='';

  if(F_MGNO.toString()!='null' || T_MGNO.toString()!='null'){
    MGNOsql=" C.MGNO BETWEEN '$F_MGNO' AND '$T_MGNO' and";
  }

  if(F_SMMNO.isNotEmpty || T_SMMNO.isNotEmpty){
    SMMNOsql=" E.SMMNO BETWEEN '$F_SMMNO' AND '$T_SMMNO' and";
  }
  if(F_SIID.isNotEmpty || T_SIID.isNotEmpty){
    SIIDsql=" B.SIID BETWEEN '$F_SIID' AND '$T_SIID' and";
  }

  //لها كمية
  GetTypeValue=="Plus"?GetTypeValue2sql='B.SNNO>0 and':
  //ليس لها كمية
  GetTypeValue=="Equil"?GetTypeValue2sql='B.SNNO=0 and':GetTypeValue2sql='';

  String sql;
  String sql2='';
  if(LoginController().BIID_ALL_V=='1'){
    sql2= " AND  B.BIID_L=${LoginController().BIID}   ";
  }
  String Wheresql='';
  String Wheresql2='';
  String Wheresql3='';
  String Wheresql4='';

  LoginController().BIID_ALL_V=='1'? Wheresql= " AND  A.BIID_L=${LoginController().BIID}":Wheresql='';
  LoginController().BIID_ALL_V=='1'? Wheresql2= " AND  C.BIID_L=${LoginController().BIID}":Wheresql2='';
  LoginController().BIID_ALL_V=='1'? Wheresql3= " AND  D.BIID_L=${LoginController().BIID}":Wheresql3='';
  LoginController().BIID_ALL_V=='1'? Wheresql4= " AND  B.BIID_L=${LoginController().BIID}":Wheresql4='';

  sql ="  SELECT  count(A) from (select DISTINCT(A.MINO||A.MGNO)  AS A  "
      " FROM MAT_INF A,MAT_GRO C,STO_NUM B,MAT_UNI D WHERE  "
      " NOT EXISTS(SELECT 1 FROM STO_MOV_D B,STO_MOV_M E WHERE "
      "$SMMNOsql  (A.MGNO=B.MGNO AND A.MINO=B.MINO) AND B.SMKID=17 AND B.MUID=D.MUID AND E.SMMID=B.SMMID "
      "AND E.BIID BETWEEN $F_BIID AND $T_BIID  AND E.SMMDA BETWEEN '$F_SMMDO' AND '$T_SMMDO'"
      " AND B.JTID_L=${LoginController().JTID} "
      " AND B.SYID_L=${LoginController().SYID}  AND B.CIID_L='${LoginController().CIID}'   $sql2)"
      "AND $SIIDsql  $MGNOsql $GetTypeValue2sql A.MGNO=C.MGNO AND A.MGNO=B.MGNO "
      "AND A.MINO=B.MINO AND D.MUID=B.MUID "
      " AND A.JTID_L=${LoginController().JTID} AND A.SYID_L=${LoginController().SYID} AND "
      " A.CIID_L=${LoginController().CIID} $Wheresql"
      " AND C.JTID_L=${LoginController().JTID} AND C.SYID_L=${LoginController().SYID} AND "
      " C.CIID_L=${LoginController().CIID} $Wheresql2"
      " AND B.JTID_L=${LoginController().JTID} AND B.SYID_L=${LoginController().SYID} AND "
      " B.CIID_L=${LoginController().CIID} $Wheresql4"
      " AND D.JTID_L=${LoginController().JTID} AND D.SYID_L=${LoginController().SYID} AND "
      " D.CIID_L=${LoginController().CIID} $Wheresql3"
      " ORDER BY A.MINO)";

  var x = await dbClient!.rawQuery(sql);
  COUNTMINO_ITEM = Sqflite.firstIntValue(x);
  return null;
}


Future<List<Sto_Mov_D_Local>> GET_SUMSMDNF_MAT(String F_BIID,String T_BIID,String F_SMMDO,String T_SMMDO,
    String F_MGNO,String T_MGNO,String GetTypeValue,String F_SMMNO,String T_SMMNO,String F_SIID,String T_SIID) async {
  var dbClient = await conn.database;
  String MGNOsql='';
  String SIIDsql='';
  String SMMNOsql='';
  String GetTypeValue2sql='';

  if(F_MGNO.toString()!='null' || T_MGNO.toString()!='null'){
    MGNOsql=" C.MGNO BETWEEN '$F_MGNO' AND '$T_MGNO' and";
  }

  if(F_SMMNO.isNotEmpty || T_SMMNO.isNotEmpty){
    SMMNOsql=" E.SMMNO BETWEEN '$F_SMMNO' AND '$T_SMMNO' and";
  }
  if(F_SIID.isNotEmpty || T_SIID.isNotEmpty){
    SIIDsql=" B.SIID BETWEEN '$F_SIID' AND '$T_SIID' and";
  }

  //لها كمية
  GetTypeValue=="Plus"?GetTypeValue2sql='B.SNNO>0 and':
  //ليس لها كمية
  GetTypeValue=="Equil"?GetTypeValue2sql='B.SNNO=0 and':GetTypeValue2sql='';

  String sql;
  String sql2='';
  if(LoginController().BIID_ALL_V=='1'){
    sql2= " AND  E.BIID_L=${LoginController().BIID}   ";
  }
  String Wheresql3='';
  String Wheresql4='';
  String Wheresql5='';
  LoginController().BIID_ALL_V=='1'? Wheresql3= " AND  A.BIID_L=${LoginController().BIID}":Wheresql3='';
  LoginController().BIID_ALL_V=='1'? Wheresql4= " AND  D.BIID_L=${LoginController().BIID}":Wheresql4='';
  LoginController().BIID_ALL_V=='1'? Wheresql5= " AND  B.BIID_L=${LoginController().BIID}":Wheresql4='';

  sql ="SELECT ifnull(sum(B.SNNO),0.0) AS SUM  FROM MAT_INF A,MAT_GRO C,STO_NUM B,MAT_UNI D WHERE  "
      " NOT EXISTS(SELECT 1 FROM STO_MOV_D B,STO_MOV_M E WHERE "
      " $SMMNOsql  A.JTID_L=${LoginController().JTID} AND A.SYID_L=${LoginController().SYID} AND "
      " A.CIID_L=${LoginController().CIID} $Wheresql3  AND (A.MGNO=B.MGNO AND A.MINO=B.MINO) AND "
      " B.SMKID=17 AND  D.JTID_L=${LoginController().JTID} AND D.SYID_L=${LoginController().SYID} AND "
      " D.CIID_L=${LoginController().CIID} $Wheresql4  AND B.MUID=D.MUID AND E.SMMID=B.SMMID "
      " AND E.BIID BETWEEN $F_BIID AND $T_BIID  AND E.SMMDA BETWEEN '$F_SMMDO' AND '$T_SMMDO'"
      " AND E.JTID_L=${LoginController().JTID} "
      " AND E.SYID_L=${LoginController().SYID}  AND E.CIID_L='${LoginController().CIID}'   $sql2)"
      " AND $SIIDsql  $MGNOsql $GetTypeValue2sql "
      " A.JTID_L=${LoginController().JTID} AND A.SYID_L=${LoginController().SYID} AND "
      " A.CIID_L=${LoginController().CIID} $Wheresql3  AND A.MGNO=C.MGNO  AND"
      " B.JTID_L=${LoginController().JTID} AND B.SYID_L=${LoginController().SYID} AND "
      " B.CIID_L=${LoginController().CIID} $Wheresql5  AND A.MGNO=B.MGNO "
      " AND D.JTID_L=${LoginController().JTID} AND D.SYID_L=${LoginController().SYID} AND "
      " D.CIID_L=${LoginController().CIID} $Wheresql4  AND A.MINO=B.MINO AND D.MUID=B.MUID "
      " ORDER BY A.MGNO,A.MINO";

  var result = await dbClient!.rawQuery(sql);
  //if (result.length == 0) return null;
  List<Sto_Mov_D_Local> list = result.map((item) {
    return Sto_Mov_D_Local.fromMapSum(item);
  }).toList();
  return list;
}

//تقرير الاصناف المطابقه-الاصناف الزائده-الاصناف الناقصة
Future<List<Sto_Mov_D_Local>>GET_Equ_Min_Plus_ITEM(String GetTypeValue) async {
  var dbClient = await conn.database;
  String GetTypeValuesql='';

  // النوع زياده او عجز او .....
  GetTypeValue=="Minus"?GetTypeValuesql='SMDNF<SMDNO ':
  GetTypeValue=="Plus"?GetTypeValuesql='SMDNF>SMDNO ':
  GetTypeValue=="Equil"?GetTypeValuesql='SMDNF=SMDNO ':GetTypeValuesql='';
  String sql;
  String sql2='';
  if(LoginController().BIID_ALL_V=='1'){
    sql2= "  AND A.BIID_L=${LoginController().BIID}   ";
  }
  String Wheresql3='';
  String Wheresql4='';
  LoginController().BIID_ALL_V=='1'? Wheresql3= " AND  B.BIID_L=${LoginController().BIID}":Wheresql3='';
  LoginController().BIID_ALL_V=='1'? Wheresql4= " AND  C.BIID_L=${LoginController().BIID}":Wheresql4='';


  sql =" SELECT  *,CASE WHEN ${LoginController().LAN}=2 AND B.MINE IS NOT NULL THEN B.MINE ELSE B.MINA END  MINA_D,"
      " CASE WHEN ${LoginController().LAN}=2 AND C.MUNE IS NOT NULL THEN C.MUNE ELSE C.MUNA END  MUNA_D "
      " FROM STO_MOV_D A, MAT_INF B,MAT_UNI C,STO_MOV_M D WHERE "
      " A.SMKID=17 AND A.SMMID=D.SMMID AND A.SMKID=D.SMKID AND  $GetTypeValuesql  "
      " AND B.JTID_L=${LoginController().JTID} AND B.SYID_L=${LoginController().SYID} AND "
      "B.CIID_L=${LoginController().CIID} $Wheresql3  AND (A.MGNO=B.MGNO AND A.MINO=B.MINO) AND "
      "C.JTID_L=${LoginController().JTID} AND C.SYID_L=${LoginController().SYID} AND "
      "C.CIID_L=${LoginController().CIID} $Wheresql4 AND A.MUID=C.MUID "
      " AND A.JTID_L=${LoginController().JTID} "
      " AND A.SYID_L=${LoginController().SYID}   AND A.CIID_L='${LoginController().CIID}'  $sql2";
  var result = await dbClient!.rawQuery(sql);
  //if (result.length == 0) return null;
  List<Sto_Mov_D_Local> list = result.map((item) {
    return Sto_Mov_D_Local.fromMap(item);
  }).toList();
  print(sql);
  return list;
}

Future<List<Sto_Inf_Local>> FROM_STO_INF_REP(String GETBIID_F,String GETBIID_T) async {
  var dbClient = await conn.database;
  String sql;
  String Wheresql='';
  String Wheresql2='';
  LoginController().BIID_ALL_V=='1'? Wheresql= " AND A.BIID_L=${LoginController().BIID}":Wheresql='';
  LoginController().BIID_ALL_V=='1'? Wheresql2= " AND B.BIID_L=${LoginController().BIID}":Wheresql2='';
  sql = "SELECT *,CASE WHEN ${LoginController().LAN}=2 AND A.SINE IS NOT NULL THEN A.SINE ELSE A.SINA END  SINA_D"
      " FROM STO_INF A where A.BIID BETWEEN '$GETBIID_F' AND  '$GETBIID_T' and A.SIST=1  AND "
      "  A.JTID_L=${LoginController().JTID} AND A.SYID_L=${LoginController().SYID} "
      " AND A.CIID_L=${LoginController().CIID} $Wheresql AND"
      " EXISTS(SELECT 1 FROM STO_USR B WHERE  B.SIID=A.SIID AND B.SUID IS NOT NULL AND B.SUID=${LoginController().SUID}"
      " AND B.JTID_L=${LoginController().JTID} AND B.SYID_L=${LoginController().SYID} "
      " AND B.CIID_L=${LoginController().CIID} $Wheresql2) ORDER BY A.SIID ";

  var result = await dbClient!.rawQuery(sql);
  List<Sto_Inf_Local> list = result.map((item) {
    return Sto_Inf_Local.fromMap(item);
  }).toList();
  return list;
}


Future<List<Bil_Mov_M_Local>> GET_ACC_MOV_D_REP(String GETBIID_F,String GETBIID_T,
    String GETDATE_F,String GETDATE_T,String GETSCID, String GETAMKID_F,String GETAMKID_T,String GETACNO,String GETACID,
    String GETST_F,String GETST_T) async {
  var dbClient = await conn.database;
  print(GETDATE_T);
  print('GETDATE_T');
  String sql='';
  String sqlAMKID='';
  String sqlACID='';
  String sqlACNO='';

  (GETAMKID_F.isEmpty || GETAMKID_F=='null') ? sqlAMKID= "":sqlAMKID= (GETAMKID_T.isEmpty || GETAMKID_T=='null')?
  " AND A.IDTYP BETWEEN $GETAMKID_F AND $GETAMKID_F  ":" AND A.IDTYP BETWEEN $GETAMKID_F AND $GETAMKID_T  ";

  (GETACID.isEmpty || GETACID=='null') ? sqlACID= "":sqlACID= " AND A.ACID = $GETACID  ";
  (GETACNO.isEmpty || GETACNO=='null') ? sqlACNO= "":sqlACNO= " AND A.ACNO = $GETACNO  ";


  sql=''' SELECT A.IDTYP2 AS BMKID, A.ID AS BMMID,A.NO AS BMMNO,A.DAT2 AS BMMDO,A.RE AS BMMRE, 
   A.BIID,CASE WHEN ${LoginController().LAN} = 3 THEN COALESCE (B.BINE, B.BINA) 
   WHEN ${LoginController().LAN} = 2 THEN COALESCE (B.BINE, B.BINE) ELSE B.BINA END AS BINA_D, 
   A.ACID, CASE WHEN ${LoginController().LAN} = 3 THEN COALESCE (E.ACN3, E.ACNE, E.ACNA) 
   WHEN ${LoginController().LAN} = 2 THEN COALESCE (E.ACNE, E.ACNE) ELSE E.ACNA END AS ACID_D, 
   A.SCID,CASE WHEN ${LoginController().LAN} = 3 THEN COALESCE (C.SCN3, C.SCNE, C.SCNA) 
   WHEN ${LoginController().LAN} = 2 THEN COALESCE (C.SCNE, C.SCNA) ELSE C.SCNA END AS SCNA_D, 
   A.IDTYP,CASE  WHEN D.AMKID = 3 THEN CASE ${LoginController().LAN}
   WHEN 1 THEN 'سند تحصيل' WHEN 2 THEN 'Collections Voucher' ELSE D.AMKNA END
    WHEN ${LoginController().LAN} = 3 THEN COALESCE(D.AMKN3, D.AMKNE, D.AMKNA)
    WHEN ${LoginController().LAN} = 2 THEN COALESCE(D.AMKNE, D.AMKNA) ELSE D.AMKNA END AS IDTYP_D, 
   A.MD,A.DA,SUM (A.MD - A.DA) OVER (PARTITION BY A.ACID, A.SCID ORDER BY A.DAT2, A.ID) AS BAL, 
   A.AANO,A.NAME AS BMMNA,A.DET AS BMMDE,A.SYN_ST, 
   A.ACNO,CASE WHEN ${LoginController().LAN} = 3 THEN COALESCE (F.ACNE , F.ACNA) 
   WHEN ${LoginController().LAN} = 2 THEN COALESCE (F.ACNE, F.ACNA) ELSE F.ACNA END AS ACNA_D
   FROM  (SELECT A.BMMID AS ID, A.BIID2 AS BIID,A.SCID,
   DATETIME (SUBSTR (REPLACE (CAST (A.BMMDO AS TEXT) || ':00', ' ', ''),7,4)|| '-'|| 
   SUBSTR (REPLACE (CAST (A.BMMDO AS TEXT) || ':00', ' ', ''),4,2)|| '-'|| 
   SUBSTR ( REPLACE (CAST (A.BMMDO AS TEXT) || ':00', ' ', ''),1,2)|| ' '|| 
   SUBSTR (REPLACE (CAST (A.BMMDO AS TEXT) || ':00', ' ', ''),11,20)) AS DAT2, 
   B.BMKID AS IDTYP2,B.BMKAN AS IDTYP,A.BMMNO AS NO,A.BMMRE AS RE, 
   (CASE WHEN B.BMKTY = 2 THEN 
   (  Ifnull (A.BMMAM, 0) 
   - Ifnull (A.BMMDI, 0) 
   - Ifnull (A.BMMDIA, 0) 
   - Ifnull (A.BMMDIF, 0)) 
   ELSE   0 END)  AS MD, 
   (CASE  WHEN B.BMKTY = 1 THEN 
   (  Ifnull (A.BMMAM, 0) 
   - Ifnull (A.BMMDI, 0) 
   - Ifnull (A.BMMDIA, 0) 
   - Ifnull (A.BMMDIF, 0)) 
   ELSE  0 END)  AS DA, 
   A.AANO, A.BMMNA AS NAME,A.BMMDE AS DET,Ifnull(A.ACNO,A.ACNO2) AS ACNO, 
   A.ACID,A.BMMST AS SYN_ST, A.CIID_L,A.JTID_L,A.BIID_L,A.SYID_L 
   FROM BIL_MOV_M A 
   LEFT JOIN BIL_MOV_K AS B ON(A.BMKID=B.BMKID AND A.CIID_L=B.CIID_L  AND A.JTID_L=B.JTID_L 
   AND A.BIID_L=B.BIID_L AND A.SYID_L=B.SYID_L ) 
   WHERE A.BMMST IN (1,2) AND B.BMKTY IN(1,2) AND B.BMKAN IS NOT NULL 
   AND (Ifnull(A.BCID,A.BIID) IS NOT NULL) AND A.BPID IS NULL AND A.ACID IS NOT NULL AND A.PKID IN(1) 
   UNION ALL 
   SELECT A.AMMID AS ID,CAST (Ifnull (C.BIID, A.BIID) AS INTEGER) AS BIID, 
   Ifnull (CAST (C.SCID AS INTEGER), A.SCID) AS SCID, 
   DATETIME (SUBSTR (REPLACE (A.AMMDO, ' ', ''), 7, 4)|| '-'|| SUBSTR (REPLACE (A.AMMDO, ' ', ''), 4, 2)|| '-'|| 
   SUBSTR (REPLACE (A.AMMDO, ' ', ''), 1, 2)|| ' '|| 
   SUBSTR (REPLACE (A.AMMDO, ' ', ''), 11, 20)) AS DAT2,B.AMKID AS IDTYP2,B.AMKID AS IDTYP,A.AMMNO AS NO, 
   Ifnull (C.AMDRE, A.AMMRE) AS RE,Ifnull (C.AMDDA, 0) AS MD,Ifnull (C.AMDMD, 0) AS DA, 
   C.AANO,CASE WHEN ${LoginController().LAN} = 3 THEN COALESCE (E.AANE, E.AANA) 
   WHEN ${LoginController().LAN} = 2 THEN COALESCE (E.AANE, E.AANA) ELSE COALESCE (E.AANA, E.AANE) END AS NAME, 
   Ifnull (C.AMDIN, A.AMMIN) AS DET,Ifnull(C.ACNO,A.ACNO) AS ACNO, 
   A.ACID,A.AMMST AS SYN_ST,A.CIID_L,A.JTID_L,A.BIID_L,A.SYID_L FROM ACC_MOV_M A 
   LEFT JOIN ACC_MOV_K AS B ON(A.AMKID=B.AMKID AND A.CIID_L=B.CIID_L  AND A.JTID_L=B.JTID_L 
   AND A.BIID_L=B.BIID_L AND A.SYID_L=B.SYID_L ) 
   left join ACC_MOV_D AS C ON(A.AMKID=C.AMKID AND A.AMMID=C.AMMID AND A.CIID_L=C.CIID_L  
   AND A.JTID_L=C.JTID_L AND A.BIID_L=C.BIID_L AND A.SYID_L=C.SYID_L ) 
   left join ACC_ACC AS E ON(C.AANO=E.AANO  AND C.CIID_L=E.CIID_L  AND C.JTID_L=E.JTID_L 
   AND A.BIID_L=E.BIID_L AND  C.SYID_L=E.SYID_L ) 
   WHERE A.AMMST IN (1,2) AND B.AMKAC IN (1) AND A.ACID IS NOT NULL AND Ifnull(A.PKID,'0') IN ('1') ) AS A 
   left join BRA_INF AS B ON (A.BIID=B.BIID AND A.CIID_L=B.CIID_L  AND A.JTID_L=B.JTID_L 
   AND A.BIID_L=B.BIID_L AND A.SYID_L=B.SYID_L ) 
   left join SYS_CUR AS C ON (A.SCID=C.SCID AND A.CIID_L=C.CIID_L  AND A.JTID_L=C.JTID_L  
   AND A.BIID_L=C.BIID_L AND A.SYID_L=C.SYID_L ) 
   left join ACC_MOV_K AS D ON (A.IDTYP=D.AMKID AND A.CIID_L=D.CIID_L  AND A.JTID_L=D.JTID_L
    AND A.BIID_L=D.BIID_L AND A.SYID_L=D.SYID_L ) 
   left join ACC_CAS AS E ON (A.ACID=E.ACID AND A.CIID_L=E.CIID_L  AND A.JTID_L=E.JTID_L 
    AND A.BIID_L=E.BIID_L AND A.SYID_L=E.SYID_L ) 
   left join ACC_COS AS F ON (A.ACNO=F.ACNO AND A.CIID_L=F.CIID_L  AND A.JTID_L=F.JTID_L  
   AND A.BIID_L=F.BIID_L AND A.SYID_L=F.SYID_L ) 
   WHERE (A.CIID_L='${LoginController().CIID}' AND A.JTID_L=${LoginController().JTID} AND A.SYID_L=${LoginController().SYID} )
    AND (A.BIID BETWEEN '$GETBIID_F'  AND '$GETBIID_T') AND (A.SCID=$GETSCID) $sqlACID $sqlAMKID $sqlACNO
    AND (A.DAT2 BETWEEN '$GETDATE_F 00:00:00' AND '$GETDATE_T 23:59:59') 
    AND (A.SYN_ST BETWEEN '$GETST_F'  AND '$GETST_T' )
   ORDER BY A.DAT2,A.ID''';

  var result = await dbClient!.rawQuery(sql);
  List<Bil_Mov_M_Local> list = result.map((item) {
    return Bil_Mov_M_Local.fromMap(item);}).toList();
  print("CASE WHEN D.AMKID = 3 AND  ${LoginController().LAN} = 2  THEN 'Collections Voucher' ");
  return list;
}




Future<List<Bil_Mov_M_Local>> GET_ACC_MOV_D_SUM_REP(String GETBIID_F,String GETBIID_T,
    String GETDATE_F,String GETDATE_T,String GETSCID, String GETAMKID_F,String GETAMKID_T,String GETACNO,String GETACID,
     String GETST_F,String GETST_T) async {
  var dbClient = await conn.database;
  String sql='';
  String sqlAMKID='';
  String sqlACID='';
  String sqlACNO='';

  (GETAMKID_F.isEmpty || GETAMKID_F=='null') ? sqlAMKID= "":sqlAMKID= (GETAMKID_T.isEmpty || GETAMKID_T=='null')?
  " AND A.IDTYP BETWEEN $GETAMKID_F AND $GETAMKID_F  ":" AND A.IDTYP BETWEEN $GETAMKID_F AND $GETAMKID_T  ";

  (GETACID.isEmpty || GETACID=='null') ? sqlACID= "":sqlACID= " AND A.ACID = $GETACID  ";
  (GETACNO.isEmpty || GETACNO=='null') ? sqlACNO= "":sqlACNO= " AND A.ACNO = $GETACNO  ";

  sql=''' SELECT 
   A.ACID,CASE WHEN ${LoginController().LAN}=3 THEN  COALESCE(E.ACN3,E.ACNE,E.ACNA) 
    WHEN ${LoginController().LAN}=2 THEN  COALESCE(E.ACNE,E.ACNE) ELSE E.ACNA END  AS ACNA_D, 
    A.SCID,CASE WHEN ${LoginController().LAN}=3 THEN  COALESCE(C.SCN3,C.SCNE,C.SCNA) 
    WHEN ${LoginController().LAN}=2 THEN  COALESCE(C.SCNE,C.SCNA) ELSE C.SCNA END  AS SCNA_D, 
  A.IDTYP,CASE  WHEN D.AMKID = 3 THEN CASE ${LoginController().LAN}
  WHEN 1 THEN 'سند تحصيل' WHEN 2 THEN 'Collections Voucher' ELSE D.AMKNA END
  WHEN ${LoginController().LAN} = 3 THEN COALESCE(D.AMKN3, D.AMKNE, D.AMKNA)
  WHEN ${LoginController().LAN} = 2 THEN COALESCE(D.AMKNE, D.AMKNA) ELSE D.AMKNA END AS IDTYP_D,
    A.MD,A.DA,SUM (A.MD-A.DA) OVER (PARTITION BY A.ACID,A.SCID ORDER BY  A.ACID,A.SCID,A.IDTYP) AS BAL 
    FROM (SELECT A1.ACID,A1.SCID,A1.IDTYP,SUM(A1.MD) AS MD,SUM(A1.DA) AS DA ,A1.CIID_L,A1.JTID_L,A1.BIID_L,A1.SYID_L 
    FROM (SELECT A.BIID,A.ACID,A.SCID,A.IDTYP,A.SCID ,A.MD,A.DA,A.CIID_L,A.JTID_L,A.BIID_L,A.SYID_L 
    FROM (SELECT A.BMMID AS ID,A.BIID2 AS BIID,A.SCID, 
    DATETIME (SUBSTR (REPLACE (CAST (A.BMMDO AS TEXT) || ':00', ' ', ''),7,4)|| '-'|| SUBSTR (REPLACE (CAST (A.BMMDO AS TEXT) || ':00', ' ', ''),4, 2)|| '-'|| SUBSTR ( 
    REPLACE (CAST (A.BMMDO AS TEXT) || ':00', ' ', ''),1,2)|| ' '|| SUBSTR (REPLACE (CAST (A.BMMDO AS TEXT) || ':00', ' ', ''),11,20)) AS DAT2, 
   B.BMKID AS IDTYP2,B.BMKAN AS IDTYP,(CASE WHEN B.BMKTY = 2 THEN 
   (  Ifnull (A.BMMAM, 0) 
    + Ifnull (A.BMMTX, 0) 
    - Ifnull (A.BMMDI, 0) 
    - Ifnull (A.BMMDIA, 0)
    - Ifnull (A.BMMDIF, 0)) 
    ELSE 0 END) AS MD, 
   (CASE WHEN B.BMKTY = 1 THEN 
    (  Ifnull (A.BMMAM, 0) 
    + Ifnull (A.BMMTX, 0) 
    - Ifnull (A.BMMDI, 0) 
   - Ifnull (A.BMMDIA, 0) 
    - Ifnull (A.BMMDIF, 0)) 
    ELSE 0 END) AS DA, 
    Ifnull(A.ACNO,A.ACNO2) AS ACNO, A.ACID, A.BMMST AS SYN_ST,  A.CIID_L, A.JTID_L, A.BIID_L, A.SYID_L 
    FROM BIL_MOV_M A 
    LEFT JOIN BIL_MOV_K AS B ON(A.BMKID=B.BMKID AND A.CIID_L=B.CIID_L  AND A.JTID_L=B.JTID_L 
    AND A.BIID_L=B.BIID_L AND A.SYID_L=B.SYID_L ) 
    WHERE A.BMMST IN (1,2)  AND B.BMKTY IN(1,2)  AND B.BMKAN IS NOT NULL 
    AND (Ifnull(A.BCID,A.BIID) IS NOT NULL)  AND A.BPID IS NULL  AND A.ACID IS NOT NULL AND A.PKID IN(1) 
    UNION ALL SELECT A.AMMID AS ID,CAST (Ifnull (C.BIID, A.BIID) AS INTEGER) AS BIID, Ifnull (CAST (C.SCID AS INTEGER), A.SCID) AS SCID, 
    DATETIME ( SUBSTR (REPLACE (A.AMMDO, ' ', ''), 7, 4)|| '-'|| SUBSTR (REPLACE (A.AMMDO, ' ', ''), 4, 2)|| '-'|| SUBSTR (REPLACE (A.AMMDO, ' ', ''), 1, 2)|| ' '|| SUBSTR (REPLACE (A.AMMDO, ' ', ''), 11, 20))AS DAT2, 
    B.AMKID AS IDTYP2,B.AMKID AS IDTYP,Ifnull (C.AMDDA, 0) AS MD,Ifnull (C.AMDMD, 0) AS DA, 
    Ifnull(C.ACNO,A.ACNO) AS ACNO,A.ACID,A.AMMST AS SYN_ST,A.CIID_L,A.JTID_L,A.BIID_L,A.SYID_L 
    FROM ACC_MOV_M A 
    LEFT JOIN ACC_MOV_K AS B ON(A.AMKID=B.AMKID AND A.CIID_L=B.CIID_L  AND A.JTID_L=B.JTID_L 
    AND A.BIID_L=B.BIID_L AND A.SYID_L=B.SYID_L ) 
    left join ACC_MOV_D AS C ON(A.AMKID=C.AMKID AND A.AMMID=C.AMMID AND A.CIID_L=C.CIID_L  AND A.JTID_L=C.JTID_L 
    AND A.BIID_L=C.BIID_L AND A.SYID_L=C.SYID_L ) 
    left join ACC_ACC AS E ON(C.AANO=E.AANO  AND C.CIID_L=E.CIID_L  AND C.JTID_L=E.JTID_L 
    AND A.BIID_L=E.BIID_L AND  C.SYID_L=E.SYID_L ) 
    WHERE A.AMMST IN (1,2) AND B.AMKAC IN (1) AND A.ACID IS NOT NULL AND Ifnull(A.PKID,'0') IN ('1') 
   ) AS A 
    WHERE   (A.CIID_L='${LoginController().CIID}' AND A.JTID_L==${LoginController().JTID} AND A.SYID_L=${LoginController().SYID} ) 
   AND (A.BIID BETWEEN '$GETBIID_F'  AND '$GETBIID_T') AND (A.SCID=$GETSCID) $sqlACID $sqlAMKID $sqlACNO
   AND (A.DAT2 BETWEEN '$GETDATE_F 00:00:00' AND '$GETDATE_T 23:59:59') 
   AND (A.SYN_ST BETWEEN '$GETST_F'  AND '$GETST_T' ) 
   )AS A1 
   GROUP BY A1.CIID_L,A1.JTID_L,A1.BIID_L,A1.SYID_L,A1.ACID,A1.SCID,A1.IDTYP 
    )AS A 
    left join SYS_CUR AS C ON 
    (A.SCID=C.SCID AND A.CIID_L=C.CIID_L  AND A.JTID_L=C.JTID_L AND A.BIID_L=C.BIID_L 
    AND A.BIID_L=C.BIID_L AND A.SYID_L=C.SYID_L) 
    left join ACC_MOV_K AS D ON 
    (A.IDTYP=D.AMKID AND A.CIID_L=D.CIID_L  AND A.JTID_L=D.JTID_L AND A.BIID_L=D.BIID_L 
    AND A.BIID_L=D.BIID_L AND A.SYID_L=D.SYID_L) 
    left join ACC_CAS AS E ON 
    (A.ACID=E.ACID AND A.CIID_L=E.CIID_L  AND A.JTID_L=E.JTID_L AND A.BIID_L=E.BIID_L 
    AND A.BIID_L=E.BIID_L AND A.SYID_L=E.SYID_L) 
   ORDER BY A.ACID,A.SCID,A.IDTYP''';

  var result = await dbClient!.rawQuery(sql);
  print(result);
  List<Bil_Mov_M_Local> list = result.map((item) {
    return Bil_Mov_M_Local.fromMap(item);}).toList();
  return list;
}


Future<List<Bil_Mov_M_Local>> GET_ACC_MOV_D_TOT_REP(String GETBIID_F,String GETBIID_T,
    String GETDATE_F,String GETDATE_T,String GETSCID,
    String GETAMKID_F,String GETAMKID_T,String GETACNO,String GETACID,
    String GETST_F,String GETST_T) async {
  var dbClient = await conn.database;
  String sql='';
  String sqlAMKID='';
  String sqlACID='';
  String sqlACNO='';

  (GETAMKID_F.isEmpty || GETAMKID_F=='null') ? sqlAMKID= "":sqlAMKID= (GETAMKID_T.isEmpty || GETAMKID_T=='null')?
  " AND A.IDTYP BETWEEN $GETAMKID_F AND $GETAMKID_F  ":" AND A.IDTYP BETWEEN $GETAMKID_F AND $GETAMKID_T  ";

  (GETACID.isEmpty || GETACID=='null') ? sqlACID= "":sqlACID= " AND A.ACID = $GETACID  ";
  (GETACNO.isEmpty || GETACNO=='null') ? sqlACNO= "":sqlACNO= " AND A.ACNO = $GETACNO  ";

sql="SELECT (SUM(A1.MD)-SUM(A1.DA)) AS BAL "
    "  FROM ( SELECT A.BIID,A.ACID,A.IDTYP,A.MD,A.BIID,A.SCID ,A.MD,A.DA,A.CIID_L,A.JTID_L,A.BIID_L,A.SYID_L FROM "
      "  (SELECT A.BMMID AS ID, A.BIID2 AS BIID, A.SCID,DATETIME ( "
      "   SUBSTR (REPLACE (CAST (A.BMMDO AS TEXT) || ':00', ' ', ''), 7,4)|| '-'|| SUBSTR (REPLACE (CAST (A.BMMDO AS TEXT) || ':00', ' ', ''),4,2)|| '-'|| SUBSTR ( "
     " REPLACE (CAST (A.BMMDO AS TEXT) || ':00', ' ', ''),1, 2)|| ' '|| SUBSTR (REPLACE (CAST (A.BMMDO AS TEXT) || ':00', ' ', ''),11,20)) AS DAT2, "
      "  B.BMKID AS IDTYP2,B.BMKAN AS IDTYP,(CASE WHEN B.BMKTY = 2  THEN "
      " (  Ifnull (A.BMMAM, 0) "
      "     - Ifnull (A.BMMDI, 0) "
      "     - Ifnull (A.BMMDIA, 0) "
      "     - Ifnull (A.BMMDIF, 0)) "
  " ELSE 0 END) AS MD, "
  " (CASE WHEN B.BMKTY = 1 THEN "
  " (  Ifnull (A.BMMAM, 0) "
  " - Ifnull (A.BMMDI, 0) "
  " - Ifnull (A.BMMDIA, 0) "
  " - Ifnull (A.BMMDIF, 0)) "
  " ELSE 0 END) AS DA, "
  " Ifnull(A.ACNO,A.ACNO2) AS ACNO,A.ACID,A.BMMST AS SYN_ST, A.CIID_L,A.JTID_L,A.BIID_L,A.SYID_L "
  " FROM BIL_MOV_M A "
  " LEFT JOIN BIL_MOV_K AS B ON(A.BMKID=B.BMKID AND A.CIID_L=B.CIID_L  AND A.JTID_L=B.JTID_L "
  " AND A.BIID_L=B.BIID_L AND A.SYID_L=B.SYID_L ) "
  " WHERE A.BMMST IN (1,2) AND B.BMKTY IN(1,2) AND B.BMKAN IS NOT NULL "
  " AND (Ifnull(A.BCID,A.BIID) IS NOT NULL) AND A.BPID IS NULL "
  " AND A.ACID IS NOT NULL  AND A.PKID IN(1) "
  " UNION ALL "
  " SELECT A.AMMID AS ID,CAST (Ifnull (C.BIID, A.BIID) AS INTEGER) AS BIID, "
  " Ifnull (CAST (C.SCID AS INTEGER), A.SCID) AS SCID, "
  " DATETIME (SUBSTR (REPLACE (A.AMMDO, ' ', ''), 7, 4) || '-'|| SUBSTR (REPLACE (A.AMMDO, ' ', ''), 4, 2) || '-' || SUBSTR (REPLACE (A.AMMDO, ' ', ''), 1, 2) || ' ' "
  " || SUBSTR (REPLACE (A.AMMDO, ' ', ''), 11, 20)) AS DAT2, "
  " B.AMKID AS IDTYP2,B.AMKID AS IDTYP, "
  " Ifnull (C.AMDDA, 0) AS MD, Ifnull (C.AMDMD, 0) AS DA,Ifnull(C.ACNO,A.ACNO) AS ACNO, "
  " A.ACID,A.AMMST AS SYN_ST,A.CIID_L,A.JTID_L,A.BIID_L,A.SYID_L "
  " FROM ACC_MOV_M A "
  " LEFT JOIN ACC_MOV_K AS B ON(A.AMKID=B.AMKID AND A.CIID_L=B.CIID_L  AND A.JTID_L=B.JTID_L "
  " AND A.BIID_L=B.BIID_L AND A.SYID_L=B.SYID_L ) "
  " left join ACC_MOV_D AS C ON(A.AMKID=C.AMKID AND A.AMMID=C.AMMID AND A.CIID_L=C.CIID_L  AND A.JTID_L=C.JTID_L "
  " AND A.BIID_L=C.BIID_L AND A.SYID_L=C.SYID_L ) "
  " left join ACC_ACC AS E ON(C.AANO=E.AANO  AND C.CIID_L=E.CIID_L  AND C.JTID_L=E.JTID_L "
  " AND A.BIID_L=E.BIID_L AND  C.SYID_L=E.SYID_L ) "
  " WHERE A.AMMST IN (1,2) AND B.AMKAC IN (1) AND A.ACID IS NOT NULL "
  " AND Ifnull(A.PKID,'0') IN ('1') "
  "  ) AS A "
    "  WHERE   (A.CIID_L='${LoginController().CIID}' AND A.JTID_L==${LoginController().JTID} AND A.SYID_L=${LoginController().SYID} ) "
    " AND (A.BIID BETWEEN '$GETBIID_F'  AND '$GETBIID_T') AND (A.SCID=$GETSCID) $sqlACID $sqlAMKID $sqlACNO"
    " AND (A.DAT2 BETWEEN '$GETDATE_F 00:00:00' AND '$GETDATE_T 23:59:59') "
    " AND (A.SYN_ST BETWEEN '$GETST_F'  AND '$GETST_T' ) "
  " )AS A1";

  // sql="SELECT (SUM(A1.MD)-SUM(A1.DA)) AS BAL"
  //     " FROM (SELECT A.BIID,A.ACID,A.IDTYP,A.MD,A.BIID,A.SCID ,A.MD,A.DA,A.CIID_L,A.JTID_L,A.BIID_L,A.SYID_L"
  //     " FROM (SELECT B.BMKAN AS IDTYP,A.SCID,(CASE WHEN B.BMKTY =2 THEN"
  //     " (Ifnull(A.BMMAM,0)+Ifnull(A.BMMTX,0)-Ifnull(A.BMMDI,0)-Ifnull(A.BMMDIA,0)-Ifnull(A.BMMDIF,0))"
  //     " ELSE 0 END ) AS MD,(CASE WHEN B.BMKTY =1 THEN"
  //     " (Ifnull(A.BMMAM,0)+Ifnull(A.BMMTX,0)-Ifnull(A.BMMDI,0)-Ifnull(A.BMMDIA,0)-Ifnull(A.BMMDIF,0))"
  //     " ELSE 0 END ) AS DA,A.BIID2 AS BIID,A.ACID,A.CIID_L,A.JTID_L,A.BIID_L,A.SYID_L FROM BIL_MOV_M A"
  //     "  left join BIL_MOV_K AS B ON"
  //     "  (A.BMKID=B.BMKID AND A.CIID_L=B.CIID_L  AND A.JTID_L=B.JTID_L AND A.BIID_L=B.BIID_L AND A.SYID_L=B.SYID_L)"
  //     " WHERE  A.BMMST IN (1,2) AND B.BMKTY IN(1,2) AND B.BMKAN IS NOT NULL"
  //     " AND (Ifnull(A.BCID,A.BIID) IS NOT NULL ) AND A.BPID IS NULL"
  //     " AND A.ACID IS NOT NULL AND A.PKID IN(1)"
  //     " AND (DATETIME(SUBSTR(REPLACE(A.BMMDO,' ',''),7,4)||'-'||SUBSTR(REPLACE(A.BMMDO,' ',''),4,2)||'-'||SUBSTR(REPLACE(A.BMMDO,' ',''),1,2)||' '||SUBSTR(REPLACE(A.BMMDO,' ',''),11,20))"
  //     " )<='$GETDATE_T'"
  //     "  UNION ALL"
  //     "  SELECT  B.AMKID  AS IDTYP,Ifnull(CAST(C.SCID AS INTEGER),A.SCID) AS SCID"
  //     "  ,Ifnull(C.AMDDA,0) AS MD,Ifnull(C.AMDMD,0) AS DA,CAST(Ifnull(C.BIID,A.BIID) AS INTEGER) AS BIID"
  //     " ,A.ACID,A.CIID_L,A.JTID_L,A.BIID_L,A.SYID_L FROM ACC_MOV_M A"
  //     " left join ACC_MOV_K AS B ON"
  //     " (A.AMKID=B.AMKID AND A.CIID_L=B.CIID_L  AND A.JTID_L=B.JTID_L AND A.SYID_L=B.SYID_L $Wheresql5)"
  //     " left join ACC_MOV_D AS C ON"
  //     "  (A.AMKID=C.AMKID AND A.AMMID=C.AMMID AND A.CIID_L=C.CIID_L  AND A.JTID_L=C.JTID_L  AND A.SYID_L=C.SYID_L $Wheresql2)"
  //     " WHERE A.AMMST IN (1,2)  AND B.AMKAC IN (1)"
  //     " AND A.ACID IS NOT NULL AND Ifnull(A.PKID,'0') IN ('1')"
  //     " AND (DATETIME(SUBSTR(REPLACE(A.AMMDO,' ',''),7,4)||'-'||SUBSTR(REPLACE(A.AMMDO,' ',''),4,2)||'-'||SUBSTR(REPLACE(A.AMMDO,' ',''),1,2)||' '||SUBSTR(REPLACE(A.AMMDO,' ',''),11,20))"
  //     " )<='$GETDATE_T'"
  //     ") AS A"
  //     " WHERE (A.CIID_L='${LoginController().CIID}' AND A.JTID_L=${LoginController().JTID} AND A.SYID_L=${LoginController().SYID} $Wheresql )"
  //     " AND (A.BIID BETWEEN '$GETBIID_F'  AND '$GETBIID_T') AND (A.SCID=$GETSCID) "
  // // " AND  BMMDO<='$GETDATE_T' "
  // // " AND   (BMMDO BETWEEN '$GETDATE_F'  AND '$GETDATE_F') "
  // // "AND (A.AMKST BETWEEN '$GETST_F'  AND '$GETST_T')"
  //     " $sqlAMKID $sqlSUID $sqlACID $sqlBDID "
  //     ")AS A1";
   print('GET_ACC_MOV_D_REP3');
  var result = await dbClient!.rawQuery(sql);
  List<Bil_Mov_M_Local> list = result.map((item) {
    return Bil_Mov_M_Local.fromMap(item);}).toList();
  return list;
}


Future<List<Bil_Mov_M_Local>> Show_Last_Balance_REP(String GETBIID_F,String GETBIID_T,
    String GETDATE_F,String GETDATE_T,String GETSCID,
    String GETAMKID_F,String GETAMKID_T,String GETACNO,String GETACID,
    String GETST_F,String GETST_T) async {
  var dbClient = await conn.database;
  String sql='';
  String sqlAMKID='';
  String sqlACID='';
  String sqlACNO='';


  (GETAMKID_F.isEmpty || GETAMKID_F=='null') ? sqlAMKID= "":sqlAMKID= (GETAMKID_T.isEmpty || GETAMKID_T=='null')?
  " AND A.IDTYP BETWEEN $GETAMKID_F AND $GETAMKID_F  ":" AND A.IDTYP BETWEEN $GETAMKID_F AND $GETAMKID_T  ";

  (GETACID.isEmpty || GETACID=='null') ? sqlACID= "":sqlACID= " AND A.ACID = $GETACID  ";
  (GETACNO.isEmpty || GETACNO=='null') ? sqlACNO= "":sqlACNO= " AND A.ACNO = $GETACNO  ";

sql="SELECT (SUM(A1.MD)-SUM(A1.DA)) AS BAL"
  "  FROM (SELECT A.BIID,A.ACID,A.IDTYP,A.MD,A.BIID,A.SCID ,A.MD,A.DA"
      "  ,A.CIID_L,A.JTID_L,A.BIID_L,A.SYID_L FROM (SELECT A.BMMID AS ID, A.BIID2 AS BIID,A.SCID,"
      " DATETIME (SUBSTR (REPLACE (CAST (A.BMMDO AS TEXT) || ':00', ' ', ''),7,4)|| '-'|| SUBSTR (REPLACE (CAST (A.BMMDO AS TEXT) || ':00', ' ', ''),4, 2)|| '-'"
      "|| SUBSTR (REPLACE (CAST (A.BMMDO AS TEXT) || ':00', ' ', ''),1,2)|| ' '|| SUBSTR (REPLACE (CAST (A.BMMDO AS TEXT) || ':00', ' ', ''),11,20))AS DAT2,"
      " B.BMKID AS IDTYP2,B.BMKAN AS IDTYP,"
      " (CASE WHEN B.BMKTY = 2 THEN"
      " (  Ifnull (A.BMMAM, 0)"
      " - Ifnull (A.BMMDI, 0)"
      " - Ifnull (A.BMMDIA, 0)"
      " - Ifnull (A.BMMDIF, 0))"
  "  ELSE 0 END) AS MD,"
  "  (CASE WHEN B.BMKTY = 1 THEN"
  "  (  Ifnull (A.BMMAM, 0)"
  "  - Ifnull (A.BMMDI, 0)"
  "  - Ifnull (A.BMMDIA, 0)"
  "  - Ifnull (A.BMMDIF, 0))"
  "  ELSE 0 END) AS DA,"
  "  Ifnull(A.ACNO,A.ACNO2) AS ACNO,A.ACID,A.BMMST AS SYN_ST,A.CIID_L,A.JTID_L,A.BIID_L,A.SYID_L"
  "  FROM BIL_MOV_M A"
  "  LEFT JOIN BIL_MOV_K AS B ON(A.BMKID=B.BMKID AND A.CIID_L=B.CIID_L  AND A.JTID_L=B.JTID_L"
  "  AND A.BIID_L=B.BIID_L AND A.SYID_L=B.SYID_L )"
  "  WHERE A.BMMST IN (1,2) AND B.BMKTY IN(1,2)  AND B.BMKAN IS NOT NULL"
  "  AND (Ifnull(A.BCID,A.BIID) IS NOT NULL) AND A.BPID IS NULL"
  "  AND A.ACID IS NOT NULL AND A.PKID IN(1)"
  "  UNION ALL SELECT A.AMMID AS ID,"
  "  CAST (Ifnull (C.BIID, A.BIID) AS INTEGER) AS BIID,Ifnull (CAST (C.SCID AS INTEGER), A.SCID) AS SCID,"
  "  DATETIME (SUBSTR (REPLACE (A.AMMDO, ' ', ''), 7, 4)|| '-'|| SUBSTR (REPLACE (A.AMMDO, ' ', ''), 4, 2)|| '-'|| SUBSTR (REPLACE (A.AMMDO, ' ', ''), 1, 2)|| ' '||"
  "  SUBSTR (REPLACE (A.AMMDO, ' ', ''), 11, 20)) AS DAT2,B.AMKID AS IDTYP2,B.AMKID AS IDTYP,Ifnull (C.AMDDA, 0) AS MD,"
  "  Ifnull (C.AMDMD, 0) AS DA,Ifnull(C.ACNO,A.ACNO) AS ACNO,A.ACID,A.AMMST AS SYN_ST,A.CIID_L,A.JTID_L,A.BIID_L,A.SYID_L"
  "  FROM ACC_MOV_M A "
  "  LEFT JOIN ACC_MOV_K AS B ON(A.AMKID=B.AMKID AND A.CIID_L=B.CIID_L  AND A.JTID_L=B.JTID_L"
  "  AND A.BIID_L=B.BIID_L AND A.SYID_L=B.SYID_L )"
  "  left join ACC_MOV_D AS C ON(A.AMKID=C.AMKID AND A.AMMID=C.AMMID AND A.CIID_L=C.CIID_L"
  "   AND A.BIID_L=C.BIID_L AND A.JTID_L=C.JTID_L AND A.SYID_L=C.SYID_L )"
  "  left join ACC_ACC AS E ON(C.AANO=E.AANO  AND C.CIID_L=E.CIID_L  AND C.JTID_L=E.JTID_L"
  "  AND A.BIID_L=E.BIID_L AND  C.SYID_L=E.SYID_L )"
  "  WHERE A.AMMST IN (1,2) AND B.AMKAC IN (1) AND A.ACID IS NOT NULL AND Ifnull(A.PKID,'0') IN ('1')"
  "  ) AS A"
  "  WHERE  (A.CIID_L='${LoginController().CIID}' AND A.JTID_L==${LoginController().JTID} AND A.SYID_L=${LoginController().SYID} ) "
  " AND (A.BIID BETWEEN '$GETBIID_F'  AND '$GETBIID_T') AND (A.SCID=$GETSCID) $sqlACID $sqlAMKID $sqlACNO"
  "  AND (A.DAT2 < '$GETDATE_F 00:00:00')"
  " AND (A.SYN_ST BETWEEN '$GETST_F'  AND '$GETST_T' ) "
  " )AS A1 ";

 print('last');
  var result = await dbClient!.rawQuery(sql);
  List<Bil_Mov_M_Local> list = result.map((item) {
    return Bil_Mov_M_Local.fromMap(item);}).toList();
  return list;
}


Future<List<Sto_Mov_K_Local>> GET_STO_MOV_K() async {
  var dbClient = await conn.database;
  String sql;
  String Wheresql='';
  LoginController().BIID_ALL_V=='1'? Wheresql= " AND  BIID_L=${LoginController().BIID}":Wheresql='';
//SELECT 0 AS BMKID,CASE WHEN ${LoginController().LAN}=2  THEN 'All' ELSE 'الكل' END AS BMKNA_D UNION ALL
  sql = "SELECT SMKID,CASE WHEN ${LoginController().LAN}=2 AND SMKNA IS NOT NULL THEN SMKNE ELSE SMKNA END  SMKNA_D"
      " FROM STO_MOV_K WHERE SMKID IN(1,3,11,13) "
      " AND JTID_L=${LoginController().JTID} "
      " AND SYID_L=${LoginController().SYID} AND CIID_L='${LoginController().CIID}' $Wheresql ";
  var result = await dbClient!.rawQuery(sql);
  List<Sto_Mov_K_Local> list = result.map((item) {
    return Sto_Mov_K_Local.fromMap(item);
  }).toList();
  print(result);
  print(sql);
  return list;
}

Future<List<Bif_Cou_C_Local>> GET_BIF_COU_REP(String GETBIID_F,String GETBIID_T,String GETBMMDO_F,String GETBMMDO_T
    ,String GETCTMID_F,String GETCTMID_T, String GETBPID_F,String GETBPID_T,String GETCIMID_F,String GETCIMID_T) async {
  var dbClient = await conn.database;
  String sql;
  String BPIDsql='';
  String CTMIDsql='';
  String CIMIDsql='';
  String Wheresql='';
  String Wheresql2='';
  String Wheresql3='';
  String Wheresql4='';
  String Wheresql5='';
  (GETBPID_F.isEmpty || GETBPID_F=='null')  && (GETBPID_T.isEmpty || GETBPID_T=='null')? BPIDsql= "":BPIDsql= " "
      "AND  F.BPID BETWEEN $GETBPID_F AND $GETBPID_T";
  (GETCTMID_F.isEmpty || GETCTMID_F=='null')  && (GETCIMID_T.isEmpty || GETCIMID_T=='null')? CTMIDsql= "":CTMIDsql= " AND  C.CTMID BETWEEN $GETCTMID_F AND $GETCTMID_T";
  (GETCIMID_F.isEmpty || GETCIMID_F=='null')  && (GETCIMID_T.isEmpty || GETCIMID_T=='null')? CIMIDsql= "":CIMIDsql= " AND  D.CIMID BETWEEN $GETCIMID_F AND $GETCIMID_T";
  LoginController().BIID_ALL_V=='1'? Wheresql= " AND  A.BIID_L=${LoginController().BIID}":Wheresql='';
  LoginController().BIID_ALL_V=='1'? Wheresql2= " AND  B.BIID_L=${LoginController().BIID}":Wheresql2='';
  LoginController().BIID_ALL_V=='1'? Wheresql2= " AND  C.BIID_L=${LoginController().BIID}":Wheresql3='';
  LoginController().BIID_ALL_V=='1'? Wheresql2= " AND  D.BIID_L=${LoginController().BIID}":Wheresql4='';
  LoginController().BIID_ALL_V=='1'? Wheresql2= " AND  F.BIID_L=${LoginController().BIID}":Wheresql5='';
  sql = "SELECT A.*,CASE WHEN ${LoginController().LAN}=2 AND C.CTMNE IS NOT NULL THEN C.CTMNE ELSE C.CTMNA END  CTMNA_D"
      ",CASE WHEN ${LoginController().LAN}=2 AND D.CIMNE IS NOT NULL THEN D.CIMNE ELSE D.CIMNA END  CIMNA_D"
      " FROM BIF_COU_C A,BIF_COU_M B,COU_TYP_M C,COU_INF_M D,BIL_POI F WHERE "
      " B.BCMID=A.BCMID AND  C.CTMID=A.CTMID AND A.CIMID=D.CIMID AND  B.BPID=F.BPID AND B.BIID BETWEEN $GETBIID_F AND $GETBIID_T "
      " and  B.BCMRD BETWEEN '$GETBMMDO_F' AND '$GETBMMDO_T' "
      " $BPIDsql $CTMIDsql $CIMIDsql   AND A.JTID_L=${LoginController().JTID} "
      "  AND A.SYID_L=${LoginController().SYID} AND A.CIID_L='${LoginController().CIID}' $Wheresql"
      "  AND B.JTID_L=${LoginController().JTID} AND B.SYID_L=${LoginController().SYID} AND B.CIID_L='${LoginController().CIID}' $Wheresql2"
      "  AND C.JTID_L=${LoginController().JTID} AND C.SYID_L=${LoginController().SYID} AND C.CIID_L='${LoginController().CIID}' $Wheresql3"
      "  AND D.JTID_L=${LoginController().JTID} AND D.SYID_L=${LoginController().SYID} AND D.CIID_L='${LoginController().CIID}' $Wheresql4"
      "  AND F.JTID_L=${LoginController().JTID} AND F.SYID_L=${LoginController().SYID} AND F.CIID_L='${LoginController().CIID}' $Wheresql5"
      "   ORDER BY C.CTMID";
  var result = await dbClient!.rawQuery(sql);
  List<Bif_Cou_C_Local> list = result.map((item) {
    return Bif_Cou_C_Local.fromMap(item);
  }).toList();
  print(result);
  print(sql);
  print('sql122222222');
  return list;
}

Future<List<Bif_Cou_C_Local>> GET_BIF_COU_REP_SUM(String GETBIID_F,String GETBIID_T,String GETBMMDO_F,String GETBMMDO_T
    ,String GETCTMID_F,String GETCTMID_T, String GETBPID_F,String GETBPID_T,String GETCIMID_F,String GETCIMID_T) async {
  var dbClient = await conn.database;
  String sql;
  String BPIDsql='';
  String CTMIDsql='';
  String CIMIDsql='';
  String Wheresql='';
  String Wheresql2='';
  String Wheresql3='';
  String Wheresql4='';
  String Wheresql5='';
  (GETBPID_F.isEmpty || GETBPID_F=='null')  && (GETBPID_T.isEmpty || GETBPID_T=='null')? BPIDsql= "":BPIDsql= " "
      "AND  F.BPID BETWEEN $GETBPID_F AND $GETBPID_T";
  (GETCTMID_F.isEmpty || GETCTMID_F=='null')  && (GETCIMID_T.isEmpty || GETCIMID_T=='null')? CTMIDsql= "":CTMIDsql= " AND  C.CTMID BETWEEN $GETCTMID_F AND $GETCTMID_T";
  (GETCIMID_F.isEmpty || GETCIMID_F=='null')  && (GETCIMID_T.isEmpty || GETCIMID_T=='null')? CIMIDsql= "":CIMIDsql= " AND  D.CIMID BETWEEN $GETCIMID_F AND $GETCIMID_T";
  LoginController().BIID_ALL_V=='1'? Wheresql= " AND  A.BIID_L=${LoginController().BIID}":Wheresql='';
  LoginController().BIID_ALL_V=='1'? Wheresql2= " AND  B.BIID_L=${LoginController().BIID}":Wheresql2='';
  LoginController().BIID_ALL_V=='1'? Wheresql2= " AND  C.BIID_L=${LoginController().BIID}":Wheresql3='';
  LoginController().BIID_ALL_V=='1'? Wheresql2= " AND  D.BIID_L=${LoginController().BIID}":Wheresql4='';
  LoginController().BIID_ALL_V=='1'? Wheresql2= " AND  F.BIID_L=${LoginController().BIID}":Wheresql5='';


  sql = "SELECT ifnull(SUM(A.BCMRO),0.0) AS SUMBCMRO,ifnull(SUM(A.BCMRN),0.0) AS SUMBCMRN,"
      " ifnull(SUM(A.BCMAMSUM),0.0) AS SUMBCMAMSUM,"
      "(SELECT ifnull(SUM(B.BCMTA),0.0)  FROM BIF_COU_M B   ORDER BY B.BCMID ) AS SUMBCMTA,"
      " (SELECT ifnull(SUM(B.BCMAM1+B.BCMAM2+B.BCMAM3),0.0)  FROM BIF_COU_M B   ORDER BY B.BCMID ) AS SUMBCMAM"
      " FROM BIF_COU_C A,BIF_COU_M B,COU_TYP_M C,COU_INF_M D,BIL_POI F WHERE "
      " B.BCMID=A.BCMID AND  C.CTMID=A.CTMID AND A.CIMID=D.CIMID AND  B.BPID=F.BPID AND B.BIID BETWEEN $GETBIID_F AND $GETBIID_T "
      "  and  B.BCMRD BETWEEN '$GETBMMDO_F' AND '$GETBMMDO_T' "
      " $BPIDsql $CTMIDsql $CIMIDsql   AND A.JTID_L=${LoginController().JTID} "
      "  AND A.SYID_L=${LoginController().SYID} AND A.CIID_L='${LoginController().CIID}' $Wheresql"
      "  AND B.JTID_L=${LoginController().JTID} AND B.SYID_L=${LoginController().SYID} AND B.CIID_L='${LoginController().CIID}' $Wheresql2"
      "  AND C.JTID_L=${LoginController().JTID} AND C.SYID_L=${LoginController().SYID} AND C.CIID_L='${LoginController().CIID}' $Wheresql3"
      "  AND D.JTID_L=${LoginController().JTID} AND D.SYID_L=${LoginController().SYID} AND D.CIID_L='${LoginController().CIID}' $Wheresql4"
      "  AND F.JTID_L=${LoginController().JTID} AND F.SYID_L=${LoginController().SYID} AND F.CIID_L='${LoginController().CIID}' $Wheresql5"
      "  ORDER BY B.BCMID";
  var result = await dbClient!.rawQuery(sql);
  List<Bif_Cou_C_Local> list = result.map((item) {
    return Bif_Cou_C_Local.fromMap(item);
  }).toList();
  print(result);
  print(sql);
  print('sql122222222');
  return list;
}

Future<List<Bif_Cou_C_Local>> GET_COUNT_BIF_COU_C() async {
  var dbClient = await conn.database;
  String sql;
  String Wheresql='';
  LoginController().BIID_ALL_V=='1'? Wheresql= " AND  BIID_L=${LoginController().BIID}":Wheresql='';

  sql = "SELECT COUNT(*) AS CTMID FROM BIF_COU_C GROUP BY CTMID "
      " AND JTID_L=${LoginController().JTID} AND SYID_L=${LoginController().SYID} AND "
      " CIID_L='${LoginController().CIID}' $Wheresql";
  var result = await dbClient!.rawQuery(sql);
  List<Bif_Cou_C_Local> list = result.map((item) {
    return Bif_Cou_C_Local.fromMap(item);
  }).toList();
  return list;
}

Future<List<Bil_Cre_C_Local>> GET_BIL_CRE_C_APPROVE_REP() async {
  var dbClient = await conn.database;
  String sql;
  String Wheresql='';
  String Wheresql2='';
  LoginController().BIID_ALL_V=='1'? Wheresql= " AND  A.BIID_L=${LoginController().BIID}":Wheresql='';
  LoginController().BIID_ALL_V=='1'? Wheresql2= " AND  B.BIID_L=${LoginController().BIID}":Wheresql2='';

  sql = "SELECT *,CASE WHEN ${LoginController().LAN}=2 AND A.BCCNE IS NOT NULL THEN A.BCCNE ELSE A.BCCNA END  BCCNA_D"
      " FROM BIL_CRE_C A WHERE A.BCCST=1  AND A.AANO IN(SELECT B.AANO FROM ACC_USR B WHERE B.AUIN=1"
      " AND B.SUID IS NOT NULL AND B.SUID=${LoginController().SUID} "
      " AND B.JTID_L=${LoginController().JTID} AND B.SYID_L=${LoginController().SYID} AND "
      " B.CIID_L='${LoginController().CIID}' $Wheresql2 GROUP BY AANO) AND A.JTID_L=${LoginController().JTID} "
      " AND A.SYID_L=${LoginController().SYID} AND A.CIID_L='${LoginController().CIID}' $Wheresql "
      "  ORDER BY A.BCCID LIMIT 3";
  var result = await dbClient!.rawQuery(sql);
  print(sql);
  List<Bil_Cre_C_Local> list = result.map((item) {
    return Bil_Cre_C_Local.fromMap(item);
  }).toList();
  return list;
}

Future<List<Cou_Typ_M_Local>> GET_COU_TYP_M_REP() async {
  var dbClient = await conn.database;
  String sql;
  String Wheresql='';
  LoginController().BIID_ALL_V=='1'? Wheresql= " AND  A.BIID_L=${LoginController().BIID}":Wheresql='';

  sql = "SELECT *,CASE WHEN ${LoginController().LAN}=2 AND A.CTMNE IS NOT NULL THEN A.CTMNE ELSE A.CTMNA END  CTMNA_D"
      " FROM COU_TYP_M A WHERE  A.CTMST=1 AND A.JTID_L=${LoginController().JTID} "
      " AND A.SYID_L=${LoginController().SYID} AND A.CIID_L='${LoginController().CIID}' $Wheresql "
      " ORDER BY A.CTMID ";
  var result = await dbClient!.rawQuery(sql);
  List<Cou_Typ_M_Local> list = result.map((item) {
    return Cou_Typ_M_Local.fromMap(item);
  }).toList();
  return list;
}

Future<List<Cou_Inf_M_Local>> GET_COU_INF_M_REP(String GETBIID_F,String GETBIID_T,String GETCTMID_F,String GETCTMID_T,
    String GETBPID_F,String GETBPID_T) async {
  var dbClient = await conn.database;
  String sql;
  String Wheresql='';
  String Wheresql2='';
  String Wheresql6='';
  LoginController().BIID_ALL_V=='1'? Wheresql= " AND  A.BIID_L=${LoginController().BIID}":Wheresql='';
  LoginController().BIID_ALL_V=='1'? Wheresql2= " AND  B.BIID_L=${LoginController().BIID}":Wheresql2='';
  LoginController().BIID_ALL_V=='1'? Wheresql6= " AND  T.BIID_L=${LoginController().BIID}":Wheresql6='';

  sql = "SELECT *,CASE WHEN ${LoginController().LAN}=2 AND A.CIMNE IS NOT NULL THEN A.CIMNE ELSE A.CIMNA END  CIMNA_D"
      " FROM COU_INF_M A WHERE EXISTS(SELECT 1 FROM COU_USR T WHERE T.CIMID=A.CIMID AND "
      "   T.CUVI=1 AND  T.SUID='${LoginController().SUID}'  AND T.JTID_L=${LoginController().JTID} "
      "  AND T.SYID_L=${LoginController().SYID} AND T.CIID_L='${LoginController().CIID}' $Wheresql6) AND "
      "  A.BIID BETWEEN $GETBIID_F AND $GETBIID_T AND A.CTMID BETWEEN $GETCTMID_F AND $GETCTMID_T AND A.CIMST=1 "
      " AND A.JTID_L=${LoginController().JTID} AND A.SYID_L=${LoginController().SYID} AND A.CIID_L='${LoginController().CIID}' "
      " $Wheresql AND A.CIMID IN (SELECT B.CIMID FROM COU_POI_L B WHERE BPID BETWEEN $GETBPID_F AND $GETBPID_T AND B.CPLST=1 "
      " AND B.JTID_L=${LoginController().JTID} AND B.SYID_L=${LoginController().SYID} AND B.CIID_L='${LoginController().CIID}' $Wheresql2)  "
      " ORDER BY A.CIMID ";
  var result = await dbClient!.rawQuery(sql);
  List<Cou_Inf_M_Local> list = result.map((item) {
    return Cou_Inf_M_Local.fromMap(item);
  }).toList();
  return list;
}


Future<List<Bil_Mov_M_Local>> GET_COUNTER_BIF_REP(String GETBIID_F,String GETBIID_T,String GETBMMDO_F,String GETBMMDO_T
    ,String GETCTMID_F,String GETCTMID_T, String GETBPID_F,String GETBPID_T,String GETCIMID_F,String GETCIMID_T) async {
  var dbClient = await conn.database;
  String sql;
  String BPIDsql='';
  String CTMIDsql='';
  String CIMIDsql='';
  String Wheresql='';
  String Wheresql2='';
  (GETBPID_F.isEmpty || GETBPID_F=='null')  && (GETBPID_T.isEmpty || GETBPID_T=='null')? BPIDsql= "":BPIDsql= " AND  A.BPID BETWEEN $GETBPID_F AND $GETBPID_T";
  (GETCTMID_F.isEmpty || GETCTMID_F=='null')  && (GETCIMID_T.isEmpty || GETCIMID_T=='null')? CTMIDsql= "":CTMIDsql= " AND  A.CTMID BETWEEN $GETCTMID_F AND $GETCTMID_T";
  (GETCIMID_F.isEmpty || GETCIMID_F=='null')  && (GETCIMID_T.isEmpty || GETCIMID_T=='null')? CIMIDsql= "":CIMIDsql= " AND  A.CIMID BETWEEN $GETCIMID_F AND $GETCIMID_T";
  LoginController().BIID_ALL_V=='1'? Wheresql= " AND  A.BIID_L=${LoginController().BIID}":Wheresql='';
  LoginController().BIID_ALL_V=='1'? Wheresql2= " AND  B.BIID_L=${LoginController().BIID}":Wheresql2='';

  sql = "SELECT ifnull(SUM(B.BMDAMT),0.0) AS BMMAM,ifnull(SUM(BMMTX),0.0) AS BMMTX,ifnull(COUNT(BMMNO),0) AS BMMNO,ifnull(MAX(BMMNO),0) AS MAX_BMMNO,"
      " ifnull(MIN(BMMNO),0) AS MIN_BMMNO, ifnull(MAX(BMMDO),'')  AS MAX_BMMDO,ifnull(MIN(BMMDO),'')  AS MIN_BMMDO,ifnull(SUM(BMMAM),0.0) AS SUM_BMMAM "
      " FROM BIF_MOV_M A,BIF_MOV_D B WHERE B.BMMID=A.BMMID AND  A.BIID BETWEEN $GETBIID_F AND $GETBIID_T AND A.BMMRD BETWEEN '$GETBMMDO_F' AND '$GETBMMDO_T' "
      " $BPIDsql $CTMIDsql $CIMIDsql   AND A.JTID_L=${LoginController().JTID} "
      "  AND A.SYID_L=${LoginController().SYID} AND A.CIID_L='${LoginController().CIID}' $Wheresql"
      "  AND B.JTID_L=${LoginController().JTID} "
      "  AND B.SYID_L=${LoginController().SYID} AND B.CIID_L='${LoginController().CIID}' $Wheresql2"
      " ORDER BY A.BMMID";
  var result = await dbClient!.rawQuery(sql);
  List<Bil_Mov_M_Local> list = result.map((item) {
    return Bil_Mov_M_Local.fromMap(item);
  }).toList();
  return list;
}

Future<List<Bil_Mov_M_Local>>  GET_COUNTER_BIF_REP2(String GETBIID_F,String GETBIID_T,String GETBMMDO_F,String GETBMMDO_T
    ,String GETCTMID_F,String GETCTMID_T, String GETBPID_F,String GETBPID_T,String GETCIMID_F,String GETCIMID_T) async {
  var dbClient = await conn.database;
  String sql;
  String BPIDsql='';
  String CTMIDsql='';
  String CIMIDsql='';
  String Wheresql='';
  (GETBPID_F.isEmpty || GETBPID_F=='null')  && (GETBPID_T.isEmpty || GETBPID_T=='null')? BPIDsql= "":BPIDsql= " AND  A.BPID BETWEEN $GETBPID_F AND $GETBPID_T";
  (GETCTMID_F.isEmpty || GETCTMID_F=='null')  && (GETCIMID_T.isEmpty || GETCIMID_T=='null')? CTMIDsql= "":CTMIDsql= " AND  A.CTMID BETWEEN $GETCTMID_F AND $GETCTMID_T";
  (GETCIMID_F.isEmpty || GETCIMID_F=='null')  && (GETCIMID_T.isEmpty || GETCIMID_T=='null')? CIMIDsql= "":CIMIDsql= " AND  A.CIMID BETWEEN $GETCIMID_F AND $GETCIMID_T";
  LoginController().BIID_ALL_V=='1'? Wheresql= " AND  A.BIID_L=${LoginController().BIID}":Wheresql='';

  sql = "SELECT  ifnull(SUM(BMMAM),0.0) AS SUM_BMMAM_delayed FROM BIF_MOV_M A WHERE A.PKID=3 AND "
      " A.BIID BETWEEN $GETBIID_F AND $GETBIID_T AND A.BMMRD BETWEEN '$GETBMMDO_F' AND '$GETBMMDO_T' "
      " $BPIDsql $CTMIDsql $CIMIDsql  AND A.JTID_L=${LoginController().JTID} "
      "  AND A.SYID_L=${LoginController().SYID} AND A.CIID_L='${LoginController().CIID}' $Wheresql"
      " ORDER BY A.BMMID";
  var result = await dbClient!.rawQuery(sql);
  print(result);
  List<Bil_Mov_M_Local> list = result.map((item) {
    return Bil_Mov_M_Local.fromMap(item);
  }).toList();
  return list;
}
Future<List<Bil_Mov_M_Local>>  GET_COUNTER_BIF_REP3(String GETBIID_F,String GETBIID_T,String GETBMMDO_F,String GETBMMDO_T
    ,String GETCTMID_F,String GETCTMID_T, String GETBPID_F,String GETBPID_T,String GETCIMID_F,String GETCIMID_T) async {
  var dbClient = await conn.database;
  String sql;
  String BPIDsql='';
  String CTMIDsql='';
  String CIMIDsql='';
  String Wheresql='';
  (GETBPID_F.isEmpty || GETBPID_F=='null')  && (GETBPID_T.isEmpty || GETBPID_T=='null')? BPIDsql= "":BPIDsql= " AND  A.BPID BETWEEN $GETBPID_F AND $GETBPID_T";
  (GETCTMID_F.isEmpty || GETCTMID_F=='null')  && (GETCIMID_T.isEmpty || GETCIMID_T=='null')? CTMIDsql= "":CTMIDsql= " AND  A.CTMID BETWEEN $GETCTMID_F AND $GETCTMID_T";
  (GETCIMID_F.isEmpty || GETCIMID_F=='null')  && (GETCIMID_T.isEmpty || GETCIMID_T=='null')? CIMIDsql= "":CIMIDsql= " AND  A.CIMID BETWEEN $GETCIMID_F AND $GETCIMID_T";
  LoginController().BIID_ALL_V=='1'? Wheresql= " AND  A.BIID_L=${LoginController().BIID}":Wheresql='';

  sql = "SELECT  ifnull(SUM(BMMAM),0.0) AS SUM_BMMAM_CASH FROM BIF_MOV_M A WHERE A.PKID=1 AND "
      " A.BIID BETWEEN $GETBIID_F AND $GETBIID_T AND A.BMMRD BETWEEN '$GETBMMDO_F' AND '$GETBMMDO_T' "
      " $BPIDsql $CTMIDsql $CIMIDsql  AND A.JTID_L=${LoginController().JTID} "
      "  AND A.SYID_L=${LoginController().SYID} AND A.CIID_L='${LoginController().CIID}' $Wheresql"
      " ORDER BY A.BMMID";
  var result = await dbClient!.rawQuery(sql);
  print(result);
  List<Bil_Mov_M_Local> list = result.map((item) {
    return Bil_Mov_M_Local.fromMap(item);
  }).toList();
  return list;
}
Future<List<Bil_Mov_M_Local>>  GET_COUNTER_BCCAM1(String GETBIID_F,String GETBIID_T,String GETBMMDO_F,String GETBMMDO_T
    ,String GETCTMID_F,String GETCTMID_T, String GETBPID_F,String GETBPID_T,String GETCIMID_F,String GETCIMID_T,
    String GETBCCID) async {
  var dbClient = await conn.database;
  String sql;
  String BPIDsql='';
  String CTMIDsql='';
  String CIMIDsql='';
  String Wheresql='';
  (GETBPID_F.isEmpty || GETBPID_F=='null')  && (GETBPID_T.isEmpty || GETBPID_T=='null')? BPIDsql= "":BPIDsql= " AND  A.BPID BETWEEN $GETBPID_F AND $GETBPID_T";
  (GETCTMID_F.isEmpty || GETCTMID_F=='null')  && (GETCIMID_T.isEmpty || GETCIMID_T=='null')? CTMIDsql= "":CTMIDsql= " AND  A.CTMID BETWEEN $GETCTMID_F AND $GETCTMID_T";
  (GETCIMID_F.isEmpty || GETCIMID_F=='null')  && (GETCIMID_T.isEmpty || GETCIMID_T=='null')? CIMIDsql= "":CIMIDsql= " AND  A.CIMID BETWEEN $GETCIMID_F AND $GETCIMID_T";
  LoginController().BIID_ALL_V=='1'? Wheresql= " AND  A.BIID_L=${LoginController().BIID}":Wheresql='';

  sql = "SELECT ifnull(SUM(BMMAM),0.0) AS SUM_BCCAM1 FROM BIF_MOV_M A WHERE A.BCCID=$GETBCCID AND "
      " A.BIID BETWEEN $GETBIID_F AND $GETBIID_T AND A.BMMRD BETWEEN '$GETBMMDO_F' AND '$GETBMMDO_T' "
      " $BPIDsql $CTMIDsql $CIMIDsql  AND A.JTID_L=${LoginController().JTID} "
      "  AND A.SYID_L=${LoginController().SYID} AND A.CIID_L='${LoginController().CIID}' $Wheresql"
      " ORDER BY A.BMMID";
  var result = await dbClient!.rawQuery(sql);
  print(result);
  List<Bil_Mov_M_Local> list = result.map((item) {
    return Bil_Mov_M_Local.fromMap(item);
  }).toList();
  return list;
}

Future<List<Bil_Mov_M_Local>>  GET_COUNTER_BCCAM2(String GETBIID_F,String GETBIID_T,String GETBMMDO_F,String GETBMMDO_T
    ,String GETCTMID_F,String GETCTMID_T, String GETBPID_F,String GETBPID_T,String GETCIMID_F,String GETCIMID_T,
    String GETBCCID) async {
  var dbClient = await conn.database;
  String sql;
  String BPIDsql='';
  String CTMIDsql='';
  String CIMIDsql='';
  String Wheresql='';
  (GETBPID_F.isEmpty || GETBPID_F=='null')  && (GETBPID_T.isEmpty || GETBPID_T=='null')? BPIDsql= "":BPIDsql= " AND  A.BPID BETWEEN $GETBPID_F AND $GETBPID_T";
  (GETCTMID_F.isEmpty || GETCTMID_F=='null')  && (GETCIMID_T.isEmpty || GETCIMID_T=='null')? CTMIDsql= "":CTMIDsql= " AND  A.CTMID BETWEEN $GETCTMID_F AND $GETCTMID_T";
  (GETCIMID_F.isEmpty || GETCIMID_F=='null')  && (GETCIMID_T.isEmpty || GETCIMID_T=='null')? CIMIDsql= "":CIMIDsql= " AND  A.CIMID BETWEEN $GETCIMID_F AND $GETCIMID_T";
  LoginController().BIID_ALL_V=='1'? Wheresql= " AND  A.BIID_L=${LoginController().BIID}":Wheresql='';

  sql = "SELECT ifnull(SUM(BMMAM),0.0) AS SUM_BCCAM2 FROM BIF_MOV_M A WHERE A.BCCID=$GETBCCID AND "
      " A.BIID BETWEEN $GETBIID_F AND $GETBIID_T AND A.BMMRD BETWEEN '$GETBMMDO_F' AND '$GETBMMDO_T' "
      " $BPIDsql $CTMIDsql $CIMIDsql  AND A.JTID_L=${LoginController().JTID} "
      "  AND A.SYID_L=${LoginController().SYID} AND A.CIID_L='${LoginController().CIID}' $Wheresql"
      " ORDER BY A.BMMID";
  var result = await dbClient!.rawQuery(sql);
  print(result);
  List<Bil_Mov_M_Local> list = result.map((item) {
    return Bil_Mov_M_Local.fromMap(item);
  }).toList();
  return list;
}


Future<List<Bil_Mov_M_Local>>  GET_COUNTER_BCCAM3(String GETBIID_F,String GETBIID_T,String GETBMMDO_F,String GETBMMDO_T
    ,String GETCTMID_F,String GETCTMID_T, String GETBPID_F,String GETBPID_T,String GETCIMID_F,String GETCIMID_T,
    String GETBCCID) async {
  var dbClient = await conn.database;
  String sql;
  String BPIDsql='';
  String CTMIDsql='';
  String CIMIDsql='';
  String Wheresql='';
  (GETBPID_F.isEmpty || GETBPID_F=='null')  && (GETBPID_T.isEmpty || GETBPID_T=='null')? BPIDsql= "":BPIDsql= " AND  A.BPID BETWEEN $GETBPID_F AND $GETBPID_T";
  (GETCTMID_F.isEmpty || GETCTMID_F=='null')  && (GETCIMID_T.isEmpty || GETCIMID_T=='null')? CTMIDsql= "":CTMIDsql= " AND  A.CTMID BETWEEN $GETCTMID_F AND $GETCTMID_T";
  (GETCIMID_F.isEmpty || GETCIMID_F=='null')  && (GETCIMID_T.isEmpty || GETCIMID_T=='null')? CIMIDsql= "":CIMIDsql= " AND  A.CIMID BETWEEN $GETCIMID_F AND $GETCIMID_T";
  LoginController().BIID_ALL_V=='1'? Wheresql= " AND  A.BIID_L=${LoginController().BIID}":Wheresql='';

  sql = "SELECT ifnull(SUM(BMMAM),0.0) AS SUM_BCCAM3 FROM BIF_MOV_M A WHERE A.BCCID=$GETBCCID AND "
      " A.BIID BETWEEN $GETBIID_F AND $GETBIID_T AND A.BMMRD BETWEEN '$GETBMMDO_F' AND '$GETBMMDO_T' "
      " $BPIDsql $CTMIDsql $CIMIDsql  AND A.JTID_L=${LoginController().JTID} "
      "  AND A.SYID_L=${LoginController().SYID} AND A.CIID_L='${LoginController().CIID}' $Wheresql"
      " ORDER BY A.BMMID";
  var result = await dbClient!.rawQuery(sql);
  print(result);
  List<Bil_Mov_M_Local> list = result.map((item) {
    return Bil_Mov_M_Local.fromMap(item);
  }).toList();
  return list;
}


Future<List<Bil_Mov_M_Local>> GET_TotalDetailedItem_REP2(int TYPE,String TAB_M,String TAB_D,
    String GETBMKID_F,String GETBMKID_T,String GETBIID_F,String GETBIID_T,String GETBMMDO_F,
    String GETBMMDO_T,String GETMGNO_F,String GETMGNO_T,String GETMINO_F,String GETMINO_T,
    String GETSCID_F,String GETSCID_T, String GETPKID_F,String GETPKID_T,String GETBMMST_F,
    String GETBMMST_T)
async {
  final dbClient = await conn.database;
  String S='';
  String M='';
  String N='';
  String PKIDsql='';
  String SCIDsql='';
  String BMKIDsql='';
  String BMKSTsql='';
  (GETBMKID_F.isEmpty || GETBMKID_F=='null') && (GETBMKID_T.isEmpty || GETBMKID_T=='null')?
  BMKIDsql =" " : BMKIDsql="  AND M.BMKID BETWEEN '$GETBMKID_F' AND '$GETBMKID_T'";

  (GETMGNO_F.isEmpty || GETMGNO_F=='null') && (GETMGNO_T.isEmpty || GETMGNO_T=='null')?
  M =" " : M="  AND B.MGNO BETWEEN '$GETMGNO_F' AND '$GETMGNO_F'";

  (GETMINO_F.isEmpty || GETMINO_F=='null') && (GETMINO_T.isEmpty || GETMINO_T=='null')?
  N =" " : N="  AND B.MINO BETWEEN '$GETMINO_F' AND '$GETMINO_T'";

  (GETSCID_F.isEmpty || GETSCID_F=='null') && (GETSCID_T.isEmpty || GETSCID_T=='null')?
  SCIDsql =" " : SCIDsql="  AND M.SCID BETWEEN '$GETSCID_F' AND '$GETSCID_T'";

  (GETPKID_F.isEmpty || GETPKID_F=='null') && (GETPKID_T.isEmpty || GETPKID_T=='null')?
  PKIDsql =" " : PKIDsql="  AND M.PKID BETWEEN '$GETSCID_F' AND '$GETSCID_T'";

  (GETBMMST_F.isEmpty || GETBMMST_F=='null') && (GETBMMST_T.isEmpty || GETBMMST_T=='null')?
  BMKSTsql =" " : BMKSTsql="  AND M.BMMST BETWEEN '$GETBMMST_F' AND '$GETBMMST_T'";


  // بناء فلترة BIID ديناميكياً
  String extraJoin = '';
  String extraWhere = '';
  String extraWhere2 = '';
  String extraWhere3 = '';
  String extraWhere4 = '';
  if (LoginController().BIID_ALL_V == '1') {
    extraJoin = " AND D.BIID_L = M.BIID_L";
    extraWhere = "AND M.BIID_L = ${LoginController().BIID}";
    extraWhere2 = " AND M.BIID_L = C.BIID_L ";
    extraWhere3 = " AND B.BIID_L = D.BIID_L ";
    extraWhere4 = " AND E.BIID_L = D.BIID_L ";
  }

  // الاستعلام المصحح
  final sql = """
      SELECT 
      M.BMKID,
      K.BMKNA AS BMKID_D,
      M.BMMDO,
      M.BMMNO,
      M.BMMNA,
      M.SCID,
      CASE WHEN ${LoginController().LAN} = 3 THEN COALESCE(C.SCN3, C.SCNE, C.SCNA)
      WHEN ${LoginController().LAN} = 2 THEN COALESCE(C.SCNE, C.SCNA)
      ELSE C.SCNA
      END AS SCNA_D,
      D.MGNO,
      D.MINO,
      CASE WHEN ${LoginController().LAN}=2 AND B.MINE IS NOT NULL THEN B.MINE ELSE B.MINA END  MINA_D,
      D.MUID,
      CASE WHEN ${LoginController().LAN}=2 AND E.MUNE IS NOT NULL THEN E.MUNE ELSE E.MUNA END  MUNA_D,
      D.BMDNO,
      D.BMDNF,
      D.BMDAM,
      D.BMDAMT,
      D.BMDDI,
      D.BMDTXT1,
      D.BMDTXT2,
      D.BMDDIA,
      D.BMDDIF,
      -- مورد
      CASE WHEN M.BMKID IN (1,4,6,12) THEN D.BMDNO ELSE 0.0 END AS BMDNO_IN,
      CASE WHEN M.BMKID IN (1,4,6,12) THEN D.BMDNF ELSE 0.0 END AS BMDNF_IN,
      -- منصرف
      CASE WHEN M.BMKID IN (2,3,5,11) THEN D.BMDNO ELSE 0.0 END AS BMDNO_OUT,
      CASE WHEN M.BMKID IN (2,3,5,11) THEN D.BMDNF ELSE 0.0 END AS BMDNF_OUT
      FROM BIL_MOV_M AS M
      JOIN BIL_MOV_D AS D 
      ON M.BMMID = D.BMMID
      AND M.CIID_L = D.CIID_L
      AND M.JTID_L = D.JTID_L
      AND M.SYID_L = D.SYID_L
      $extraJoin
      LEFT JOIN BIL_MOV_K AS K 
      ON M.BMKID = K.BMKID
      AND M.CIID_L = K.CIID_L
      AND M.JTID_L = K.JTID_L
      AND M.SYID_L = K.SYID_L
      LEFT JOIN SYS_CUR AS C 
      ON M.SCID = C.SCID
      AND M.CIID_L = C.CIID_L
      AND M.JTID_L = C.JTID_L
      AND M.SYID_L = C.SYID_L
      $extraWhere2
      LEFT JOIN MAT_INF AS B 
      ON (D.MGNO=B.MGNO AND D.MINO=B.MINO)
      AND B.CIID_L = D.CIID_L
      AND B.JTID_L = D.JTID_L
      AND B.SYID_L = D.SYID_L
      $extraWhere3
      LEFT JOIN MAT_UNI AS E
      ON  D.MUID=E.MUID
      AND E.CIID_L = D.CIID_L
      AND E.JTID_L = D.JTID_L
      AND E.SYID_L = D.SYID_L
      $extraWhere4
      WHERE  M.JTID_L = ${LoginController().JTID}
      AND M.SYID_L = ${LoginController().SYID}
      AND M.CIID_L = '${LoginController().CIID}'
      $extraWhere AND  M.BMMDOR BETWEEN '$GETBMMDO_F' AND '$GETBMMDO_T'
      $BMKIDsql $BMKSTsql
      $PKIDsql $SCIDsql $S  $M  $N
      UNION ALL      
      SELECT 
      M.BMKID,
      K.BMKNA AS BMKID_D,
      M.BMMDO,
      M.BMMNO,
      M.BMMNA,
      M.SCID,
      CASE WHEN ${LoginController().LAN} = 3 THEN COALESCE(C.SCN3, C.SCNE, C.SCNA)
      WHEN ${LoginController().LAN} = 2 THEN COALESCE(C.SCNE, C.SCNA)
      ELSE C.SCNA
      END AS SCNA_D,
      D.MGNO,
      D.MINO,
      CASE WHEN ${LoginController().LAN}=2 AND B.MINE IS NOT NULL THEN B.MINE ELSE B.MINA END  MINA_D,
      D.MUID,
      CASE WHEN ${LoginController().LAN}=2 AND E.MUNE IS NOT NULL THEN E.MUNE ELSE E.MUNA END  MUNA_D,
      D.BMDNO,
      D.BMDNF,
      D.BMDAM,
      D.BMDAMT,
      D.BMDDI,
      D.BMDTXT1,
      D.BMDTXT2,
      D.BMDDIA,
      D.BMDDIF,
      -- مورد
      CASE WHEN M.BMKID IN (1,4,6,12) THEN D.BMDNO ELSE 0.0 END AS BMDNO_IN,
      CASE WHEN M.BMKID IN (1,4,6,12) THEN D.BMDNF ELSE 0.0 END AS BMDNF_IN,
      -- منصرف
      CASE WHEN M.BMKID IN (2,3,5,11) THEN D.BMDNO ELSE 0.0 END AS BMDNO_OUT,
      CASE WHEN M.BMKID IN (2,3,5,11) THEN D.BMDNF ELSE 0.0 END AS BMDNF_OUT
      FROM BIF_MOV_M AS M
      JOIN BIF_MOV_D AS D 
      ON M.BMMID = D.BMMID
      AND M.CIID_L = D.CIID_L
      AND M.JTID_L = D.JTID_L
      AND M.SYID_L = D.SYID_L
      $extraJoin
      LEFT JOIN BIL_MOV_K AS K 
      ON M.BMKID = K.BMKID
      AND M.CIID_L = K.CIID_L
      AND M.JTID_L = K.JTID_L
      AND M.SYID_L = K.SYID_L
      LEFT JOIN SYS_CUR AS C 
      ON M.SCID = C.SCID
      AND M.CIID_L = C.CIID_L
      AND M.JTID_L = C.JTID_L
      AND M.SYID_L = C.SYID_L
      $extraWhere2
      LEFT JOIN MAT_INF AS B 
      ON (D.MGNO=B.MGNO AND D.MINO=B.MINO)
      AND B.CIID_L = D.CIID_L
      AND B.JTID_L = D.JTID_L
      AND B.SYID_L = D.SYID_L
      $extraWhere3
      LEFT JOIN MAT_UNI AS E
      ON  D.MUID=E.MUID
      AND E.CIID_L = D.CIID_L
      AND E.JTID_L = D.JTID_L
      AND E.SYID_L = D.SYID_L
      $extraWhere4
      WHERE  M.JTID_L = ${LoginController().JTID}
      AND M.SYID_L = ${LoginController().SYID}
      AND M.CIID_L = '${LoginController().CIID}'
      $extraWhere AND  M.BMMDOR BETWEEN '$GETBMMDO_F' AND '$GETBMMDO_T'
      $BMKIDsql $BMKSTsql $PKIDsql $SCIDsql $S  $M  $N
      ORDER BY M.BMMDO ASC """;

  final sql2 = """
      SELECT  M.SCID,D.MGNO,D.MINO,D.MUID,M.BMKID,K.BMKNA AS BMKID_D,
      CASE WHEN ${LoginController().LAN}=2 AND B.MINE IS NOT NULL THEN B.MINE ELSE B.MINA END  MINA_D,    
      CASE WHEN ${LoginController().LAN}=2 AND E.MUNE IS NOT NULL THEN E.MUNE ELSE E.MUNA END  MUNA_D,
      CASE WHEN ${LoginController().LAN} = 3 THEN COALESCE(C.SCN3, C.SCNE, C.SCNA)
      WHEN ${LoginController().LAN} = 2 THEN COALESCE(C.SCNE, C.SCNA) ELSE C.SCNA END AS SCNA_D,
      SUM(D.BMDNO) AS BMDNO,
      SUM(D.BMDNF) AS BMDNF,
      SUM(D.BMDAM) AS BMDAM,
      SUM(D.BMDAMT) AS BMDAMT,
      SUM(D.BMDDI) AS BMDDI,
      SUM(D.BMDTXT1) AS BMDTXT1,
      SUM(D.BMDTXT2) AS BMDTXT2,
      SUM(D.BMDDIA) AS BMDDIA,
      SUM(D.BMDDIF) AS BMDDIF,
      -- مورد
      SUM(CASE WHEN M.BMKID IN (1,4,6,12) THEN D.BMDNO ELSE 0.0 END) AS BMDNO_IN,
      SUM(CASE WHEN M.BMKID IN (1,4,6,12) THEN D.BMDNF ELSE 0.0 END) AS BMDNF_IN,
      SUM(CASE WHEN M.BMKID IN (1,4,6,12) THEN D.BMDAMT ELSE 0.0 END) AS BMDAM_IN,
      -- منصرف
      SUM(CASE WHEN M.BMKID IN (2,3,5,11) THEN D.BMDNO ELSE 0.0 END) AS BMDNO_OUT,
      SUM(CASE WHEN M.BMKID IN (2,3,5,11) THEN D.BMDNF ELSE 0.0 END) AS BMDNF_OUT,
      SUM(CASE WHEN M.BMKID IN (2,3,5,11) THEN D.BMDAMT ELSE 0.0 END) AS BMDAM_OUT
      FROM BIL_MOV_M AS M
      JOIN BIL_MOV_D AS D 
      ON M.BMMID = D.BMMID
      AND M.CIID_L = D.CIID_L
      AND M.JTID_L = D.JTID_L
      AND M.SYID_L = D.SYID_L
      $extraJoin
      LEFT JOIN BIL_MOV_K AS K 
      ON M.BMKID = K.BMKID
      AND M.CIID_L = K.CIID_L
      AND M.JTID_L = K.JTID_L
      AND M.SYID_L = K.SYID_L
      LEFT JOIN SYS_CUR AS C 
      ON M.SCID = C.SCID
      AND M.CIID_L = C.CIID_L
      AND M.JTID_L = C.JTID_L
      AND M.SYID_L = C.SYID_L
      $extraWhere2
      LEFT JOIN MAT_INF AS B 
      ON (D.MGNO=B.MGNO AND D.MINO=B.MINO)
      AND B.CIID_L = D.CIID_L
      AND B.JTID_L = D.JTID_L
      AND B.SYID_L = D.SYID_L
      $extraWhere3
      LEFT JOIN MAT_UNI AS E
      ON  D.MUID=E.MUID
      AND E.CIID_L = D.CIID_L
      AND E.JTID_L = D.JTID_L
      AND E.SYID_L = D.SYID_L
      $extraWhere4
       WHERE  M.JTID_L = ${LoginController().JTID}
      AND M.SYID_L = ${LoginController().SYID}
      AND M.CIID_L = '${LoginController().CIID}'
      $extraWhere AND  M.BMMDOR BETWEEN '$GETBMMDO_F' AND '$GETBMMDO_T'
      $BMKIDsql $BMKSTsql
      $PKIDsql $SCIDsql $S  $M  $N
      GROUP BY  M.SCID,D.MGNO,D.MINO,D.MUID
     
      UNION ALL
      SELECT  M.SCID,D.MGNO,D.MINO,D.MUID,M.BMKID,K.BMKNA AS BMKID_D,
      CASE WHEN ${LoginController().LAN}=2 AND B.MINE IS NOT NULL THEN B.MINE ELSE B.MINA END  MINA_D,    
      CASE WHEN ${LoginController().LAN}=2 AND E.MUNE IS NOT NULL THEN E.MUNE ELSE E.MUNA END  MUNA_D,
      CASE WHEN ${LoginController().LAN} = 3 THEN COALESCE(C.SCN3, C.SCNE, C.SCNA)
      WHEN ${LoginController().LAN} = 2 THEN COALESCE(C.SCNE, C.SCNA) ELSE C.SCNA END AS SCNA_D,
      SUM(D.BMDNO) AS BMDNO,
      SUM(D.BMDNF) AS BMDNF,
      SUM(D.BMDAM) AS BMDAM,
      SUM(D.BMDAMT) AS BMDAMT,
      SUM(D.BMDDI) AS BMDDI,
      SUM(D.BMDTXT1) AS BMDTXT1,
      SUM(D.BMDTXT2) AS BMDTXT2,
      SUM(D.BMDDIA) AS BMDDIA,
      SUM(D.BMDDIF) AS BMDDIF,
      -- مورد
      SUM(CASE WHEN M.BMKID IN (1,4,6,12) THEN D.BMDNO ELSE 0.0 END) AS BMDNO_IN,
      SUM(CASE WHEN M.BMKID IN (1,4,6,12) THEN D.BMDNF ELSE 0.0 END) AS BMDNF_IN,
      SUM(CASE WHEN M.BMKID IN (1,4,6,12) THEN D.BMDAM ELSE 0.0 END) AS BMDAM_IN,
      -- منصرف
      SUM(CASE WHEN M.BMKID IN (2,3,5,11) THEN D.BMDNO ELSE 0.0 END) AS BMDNO_OUT,
      SUM(CASE WHEN M.BMKID IN (2,3,5,11) THEN D.BMDNF ELSE 0.0 END) AS BMDNF_OUT,
      SUM(CASE WHEN M.BMKID IN (2,3,5,11) THEN D.BMDAM ELSE 0.0 END) AS BMDAM_OUT
    
      FROM BIF_MOV_M AS M
      JOIN BIF_MOV_D AS D 
      ON M.BMMID = D.BMMID
      AND M.CIID_L = D.CIID_L
      AND M.JTID_L = D.JTID_L
      AND M.SYID_L = D.SYID_L
      $extraJoin
      LEFT JOIN BIL_MOV_K AS K 
      ON M.BMKID = K.BMKID
      AND M.CIID_L = K.CIID_L
      AND M.JTID_L = K.JTID_L
      AND M.SYID_L = K.SYID_L
      LEFT JOIN SYS_CUR AS C 
      ON M.SCID = C.SCID
      AND M.CIID_L = C.CIID_L
      AND M.JTID_L = C.JTID_L
      AND M.SYID_L = C.SYID_L
      $extraWhere2
      LEFT JOIN MAT_INF AS B 
      ON (D.MGNO=B.MGNO AND D.MINO=B.MINO)
      AND B.CIID_L = D.CIID_L
      AND B.JTID_L = D.JTID_L
      AND B.SYID_L = D.SYID_L
      $extraWhere3
      LEFT JOIN MAT_UNI AS E
      ON  D.MUID=E.MUID
      AND E.CIID_L = D.CIID_L
      AND E.JTID_L = D.JTID_L
      AND E.SYID_L = D.SYID_L
      $extraWhere4
       WHERE  M.JTID_L = ${LoginController().JTID}
      AND M.SYID_L = ${LoginController().SYID}
      AND M.CIID_L = '${LoginController().CIID}'
      $extraWhere AND  M.BMMDOR BETWEEN '$GETBMMDO_F' AND '$GETBMMDO_T'
      $BMKIDsql $BMKSTsql
      $PKIDsql $SCIDsql $S  $M  $N
      GROUP BY  M.SCID,D.MGNO,D.MINO,D.MUID
  """;

  // printLongText(TYPE==101?sql2:sql);
  final rows = await dbClient!.rawQuery(TYPE==101?sql2:sql);
  // printLongText(rows.toString());
  return rows.map((m) => Bil_Mov_M_Local.fromMap(m)).toList();
}