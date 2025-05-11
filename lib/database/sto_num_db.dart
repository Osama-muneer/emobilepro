import '../Setting/controllers/login_controller.dart';
import '../Setting/models/bra_inf.dart';
import '../Setting/models/mat_gro.dart';
import '../Setting/models/mat_inf.dart';
import '../Setting/models/sto_num_local.dart';
import '../Widgets/config.dart';
import '../database/database.dart';
import 'package:sqflite/sqflite.dart';

final conn = DatabaseHelper.instance;

int COUMINO_ITEM=0;
String WhereSql=" JTID_L=${LoginController().JTID} AND SYID_L=${LoginController().SYID} AND CIID_L=${LoginController().CIID}";
String Wheresql2='';

Future<List<Sto_Num>> query_STO_NUM(String BIID_N,String SIID_N,String MGNO,String MINO,
    String MINO_to,bool TYPE,String GETSCID,STO_V_N,TYPE_DATA,TYPE_ORD) async {
  var dbClient = await conn.database;
  String sql;
  String sql2='';
  String sqlOrd='';
  String sqlSIID='';
  String sqlSIID_W='';
  String S='';
  String M='';
  String N='';
  String B='';
  String B2='';


  if (MGNO.isEmpty || MGNO=='null'){
    M=" ";
  }else{
    M="  AND A.MGNO='$MGNO'";
  }

  if (MINO.isEmpty || MINO=='null'){
    N=" ";
  }else{
    N="  AND A.MINO BETWEEN '$MINO' AND '$MINO_to'";
  }

  if (SIID_N.toString()!='null' && STO_V_N==false){
    S="  AND A.SIID=$SIID_N $M  $N";
  }
  else{
    S='';

  }

  STO_V_N==true?  sqlSIID=' SUM(ifnull(A.SNNO,0.0)) AS SNNO,SUM(ifnull(F.MPCO,0.0)) AS MPCO,':'';
  STO_V_N==true?  sqlSIID_W='GROUP BY A.MGNO,A.MINO,A.MUID':'';

  if(TYPE==false){
    sql2=' A.SNNO>0 AND ';
  }

  if(TYPE_ORD=='1'){
    sqlOrd='A.MGNO';
  }else if(TYPE_ORD=='2'){
    TYPE_DATA=='2'?sqlOrd=' CAST(A.MINO AS INTEGER)':sqlOrd='A.MINO';
  }else if(TYPE_ORD=='3'){
    sqlOrd='A.SIID';
  }else if(TYPE_ORD=='4'){
    sqlOrd='A.SNED';
  }else if(TYPE_ORD=='5'){
    sqlOrd='A.SNNO';
  }else if(TYPE_ORD=='6'){
    TYPE_DATA=='2'?sqlOrd=' A.MGNO,CAST(A.MINO AS INTEGER)':sqlOrd='A.MGNO,,A.MINO';
  }

  String Wheresql3='';
  String Wheresql4='';
  String Wheresql5='';
  String Wheresql6='';
  String Wheresql7='';
  String Wheresql8='';
  String Wheresql9='';
  String Wheresql10='';
  String Wheresql11='';
  LoginController().BIID_ALL_V=='1'? Wheresql2= " AND  A.BIID_L=${LoginController().BIID}":Wheresql2='';
  LoginController().BIID_ALL_V=='1'? Wheresql3= " AND  G.BIID_L=A.BIID_L ":Wheresql3='';
  LoginController().BIID_ALL_V=='1'? Wheresql4= " AND  B.BIID_L=A.BIID_L ":Wheresql4='';
  LoginController().BIID_ALL_V=='1'? Wheresql5= " AND  D.BIID_L=A.BIID_L ":Wheresql5='';
  LoginController().BIID_ALL_V=='1'? Wheresql6= " AND  C.BIID_L=A.BIID_L ":Wheresql6='';
  LoginController().BIID_ALL_V=='1'? Wheresql7= " AND  F.BIID_L=A.BIID_L ":Wheresql7='';
  LoginController().BIID_ALL_V=='1'? Wheresql8= " AND  E.BIID_L=A.BIID_L ":Wheresql8='';
  LoginController().BIID_ALL_V=='1'? Wheresql9= " AND  F.BIID_L=A.BIID_L ":Wheresql9='';
  LoginController().BIID_ALL_V=='1'? Wheresql10= " AND  T.BIID_L=A.BIID_L ":Wheresql10='';
  LoginController().BIID_ALL_V=='1'? Wheresql11= " AND  G.BIID_L=A.BIID_L ":Wheresql11='';

  sql =" SELECT * ,ifnull(A.SNHO,0.0) AS SNHO, $sqlSIID "
      " B.MINO||'- '|| CASE WHEN ${LoginController().LAN}=2 AND B.MINE IS NOT NULL THEN B.MINE ELSE B.MINA END  MINA_D,"
      " CASE WHEN ${LoginController().LAN}=2 AND D.MGNE IS NOT NULL THEN D.MGNE ELSE D.MGNA END  MGNA_D,"
      " CASE WHEN ${LoginController().LAN}=2 AND E.MUNE IS NOT NULL THEN E.MUNE ELSE E.MUNA END  MUNA_D,"
      " CASE WHEN ${LoginController().LAN}=2 AND G.SINE IS NOT NULL THEN G.SINE ELSE G.SINA END  SINA_D, "
      " B.MINA,D.MGNA,E.MUNA,F.MPCO,G.SINA FROM STO_NUM A,MAT_INF B,MAT_UNI_C C,MAT_GRO D,MAT_UNI E,"
      " MAT_PRI F,STO_INF G  WHERE $sql2 A.JTID_L=${LoginController().JTID} "
      " AND A.SYID_L=${LoginController().SYID} AND "
      " A.CIID_L=${LoginController().CIID} $Wheresql2 AND "
      " G.JTID_L=A.JTID_L AND G.SYID_L=A.SYID_L AND "
      " G.CIID_L=A.CIID_L $Wheresql3 AND G.SIID=A.SIID AND "
      " B.JTID_L=A.JTID_L AND B.SYID_L=A.SYID_L AND "
      " B.CIID_L=A.CIID_L $Wheresql4 AND (A.MGNO=B.MGNO AND A.MINO=B.MINO) AND "
      " D.JTID_L=A.JTID_L AND D.SYID_L=A.SYID_L AND "
      " D.CIID_L=A.CIID_L $Wheresql5 AND (A.MGNO=D.MGNO) AND "
      " C.JTID_L=A.JTID_L AND C.SYID_L=A.SYID_L AND "
      " C.CIID_L=A.CIID_L $Wheresql6 AND(A.MGNO=C.MGNO AND A.MINO=C.MINO AND A.MUID=C.MUID) AND "
      " F.JTID_L=A.JTID_L AND F.SYID_L=A.SYID_L AND "
      " F.CIID_L=A.CIID_L $Wheresql7 AND(A.MGNO=F.MGNO AND A.MINO=F.MINO AND A.MUID=F.MUID) "
      " AND F.SCID=$GETSCID AND F.BIID=$BIID_N AND E.JTID_L=A.JTID_L AND E.SYID_L=A.SYID_L AND "
      " E.CIID_L=${LoginController().CIID} $Wheresql8 AND (A.MUID=E.MUID)  "
      " AND EXISTS(SELECT 1 FROM STO_USR F WHERE  F.SIID=A.SIID AND F.SUID IS NOT NULL "
      " AND F.SUID='${LoginController().SUID}' AND (F.SUIN=1 OR F.SUCH=1)"
      " AND F.JTID_L=A.JTID_L AND F.SYID_L=A.SYID_L AND "
      " F.CIID_L=A.CIID_L $Wheresql9)"
      " AND EXISTS(SELECT 1 FROM SYS_USR_B BR WHERE BR.BIID=G.BIID AND BR.SUID='${LoginController().SUID}'"
      " AND BR.SUBST=1 AND (BR.SUBIN=1 OR BR.SUBPR=1))"
      " AND EXISTS(SELECT 1 FROM STO_INF T WHERE  T.SIID=A.SIID  AND T.BIID=$BIID_N "
      " AND T.JTID_L=A.JTID_L AND T.SYID_L=A.SYID_L AND "
      " T.CIID_L=A.CIID_L $Wheresql10 ) "
      " AND EXISTS(SELECT 1 FROM GRO_USR G WHERE G.MGNO=A.MGNO AND G.GUOU=1 AND G.SUID='${LoginController().SUID}' "
      " AND G.JTID_L=${LoginController().JTID} "
      " AND G.SYID_L=${LoginController().SYID} AND G.CIID_L=${LoginController().CIID} $Wheresql11)"
      " $S  $M  $N   $sqlSIID_W ORDER BY $sqlOrd ";

  //printLongText(sql);
  final result = await dbClient!.rawQuery(sql);
  printLongText(sql);
 // print(result);
  print('query_STO_NUM');
  return result.map((json) => Sto_Num.fromMap(json)).toList();
}

Future<List<Sto_Num>> GET_SUM_STO_NUM(String BIID_N,String SIID_N,String MGNO,String MINO,bool TYPE,String GETSCID,STO_V_N) async {
  var dbClient = await conn.database;
  String sql;
  String sql2='';
  String S='';
  String M='';
  String sqlSIID='';
  String sqlSIID_W='';
  String N='';
  String Wheresql11='';
 // SIID_N='';
  if (MGNO.isEmpty || MGNO=='null'){
    M=" ";
  }else{
    M="  AND A.MGNO='$MGNO'";
  }
  if (MINO.isEmpty || MINO=='null'){
    N=" ";
  }else{
    N="  AND A.MINO='$MINO'";
  }
  if (SIID_N.toString()!='null' && STO_V_N==false){
    S="  AND A.SIID=$SIID_N $M  $N";
  }else{
    S='';

  }
  if(TYPE==false){
    sql2=' A.SNNO>0 AND ';
  }

  STO_V_N==true?  sqlSIID=' SUM(ifnull(A.SNNO,0.0)) AS SNNO,SUM(ifnull(F.MPCO,0.0)) AS MPCO,':'';
  STO_V_N==true?  sqlSIID_W='GROUP BY A.MGNO,A.MINO,A.MUID':'';

  String Wheresql7='';
  String Wheresql9='';
  String Wheresql10='';
  LoginController().BIID_ALL_V=='1'? Wheresql2= " AND  A.BIID_L=${LoginController().BIID}":Wheresql2='';
  LoginController().BIID_ALL_V=='1'? Wheresql7= " AND  F.BIID_L=${LoginController().BIID}":Wheresql7='';
  LoginController().BIID_ALL_V=='1'? Wheresql9= " AND  F.BIID_L=${LoginController().BIID}":Wheresql9='';
  LoginController().BIID_ALL_V=='1'? Wheresql10= " AND  T.BIID_L=${LoginController().BIID}":Wheresql10='';
  LoginController().BIID_ALL_V=='1'? Wheresql11= " AND  G.BIID_L=A.BIID_L ":Wheresql11='';

  sql =" SELECT ifnull(round(SUM(A.SNNO),6),0.0) AS SUM_SNNO,ifnull(round(SUM(A.SNNO*F.MPCO),6),0.0) AS SUM_MPS1,"
      " ifnull(COUNT(A.MINO),0) AS COUNT_MINO FROM STO_NUM A,MAT_PRI F  WHERE $sql2 "
      " A.JTID_L=${LoginController().JTID} AND A.SYID_L=${LoginController().SYID} AND "
      " A.CIID_L=${LoginController().CIID} $Wheresql2 AND "
      " F.JTID_L=${LoginController().JTID} AND F.SYID_L=${LoginController().SYID} AND "
      " F.CIID_L=${LoginController().CIID} $Wheresql7 AND(A.MGNO=F.MGNO AND A.MINO=F.MINO AND A.MUID=F.MUID) AND F.SCID=$GETSCID "
      " AND F.BIID=$BIID_N "
      " AND EXISTS(SELECT 1 FROM STO_USR F WHERE  F.SIID=A.SIID AND F.SUID IS NOT NULL AND F.SUID='${LoginController().SUID}' "
      " AND F.JTID_L=${LoginController().JTID} AND F.SYID_L=${LoginController().SYID} AND "
      " F.CIID_L=${LoginController().CIID} $Wheresql9)"
      " AND EXISTS(SELECT 1 FROM STO_INF T WHERE  T.SIID=A.SIID AND T.BIID=$BIID_N "
      " AND T.JTID_L=${LoginController().JTID} AND T.SYID_L=${LoginController().SYID} AND "
      " T.CIID_L=${LoginController().CIID} $Wheresql10 ) "
      " AND EXISTS(SELECT 1 FROM GRO_USR G WHERE G.MGNO=A.MGNO AND G.SUID='${LoginController().SUID}' "
      " AND G.JTID_L=${LoginController().JTID} "
      " AND G.SYID_L=${LoginController().SYID} AND G.CIID_L=${LoginController().CIID} $Wheresql11)"
      " $S  $M  $N $sqlSIID_W  ORDER BY A.SIID,A.MGNO";
  final result = await dbClient!.rawQuery(sql);
  print(sql);
  print(result);
  print('GET_SUM_STO_NUM');
  return result.map((json) => Sto_Num.fromMap(json)).toList();
}

Future<List<Sto_Num>> GET_SUMSMDNO(String BIID_N,String SIID_N,String MGNO,String MINO) async {
  var dbClient = await conn.database;
  String sql;
  String S='';
  String M='';
  String N='';
  // SIID_N='';
  if (MGNO.isEmpty){
    M=" ";
  }else{
    M="  AND A.MGNO='$MGNO'";
  }
  if (MINO.isEmpty){
    N=" ";
  }else{
    N="  AND A.MINO='$MINO'";
  }
  if (SIID_N.isNotEmpty){
    S="  AND A.SIID=$SIID_N $M  $N";
  }else{
    S='';
  }

  sql =" SELECT ifnull(sum(A.SNNO),0.0) AS SUM "
      "FROM STO_NUM A,MAT_INF B,MAT_UNI_C C,MAT_GRO D,MAT_UNI E,"
      " MAT_PRI F  WHERE (A.MGNO=B.MGNO AND A.MINO=B.MINO) AND (A.MGNO=D.MGNO) "
      "AND(A.MGNO=C.MGNO AND A.MINO=C.MINO AND A.MUID=C.MUID)"
      " AND(A.MGNO=F.MGNO AND A.MINO=F.MINO AND A.MUID=F.MUID) AND F.SCID=1 AND F.BIID=$BIID_N"
      " AND (A.MUID=E.MUID)  AND EXISTS(SELECT 1 FROM STO_USR F WHERE  F.SIID=A.SIID AND F.SUID IS NOT NULL AND F.SUID='${LoginController().SUID}')"
      "  AND EXISTS(SELECT 1 FROM STO_INF T WHERE  T.SIID=A.SIID AND T.BIID=$BIID_N) $S  $M  $N  ORDER BY A.MGNO";

  var result = await dbClient!.rawQuery(sql);
  List<Sto_Num> list = result.map((item) {
    return Sto_Num.fromMapSum(item);
  }).toList();
  return list;
}

Future<List<Bra_Inf_Local>> GET_BINA() async {
  var dbClient = await conn.database;
  String sql;
  sql ="SELECT *,CASE WHEN ${LoginController().LAN}=2 AND BINE IS NOT NULL THEN BINE ELSE BINA END  BINA_D"
      " FROM BRA_INF  WHERE  BIID=${LoginController().BIID} AND $WhereSql";
  final result = await dbClient!.rawQuery(sql);
  return result.map((json) => Bra_Inf_Local.fromMap(json)).toList();
}


Future<List<Mat_Inf_Local>> Get_Mat_Inf(String MGNO_V) async {
  var dbClient = await conn.database;
  String sql;
  String sqlMGNO='';
  String Wheresql='';
  String Wheresql2='';
  LoginController().BIID_ALL_V=='1'? Wheresql= " AND BIID_L=${LoginController().BIID}":Wheresql='';
  LoginController().BIID_ALL_V=='1'? Wheresql2= " AND D.BIID_L=A.BIID_L ":Wheresql2='';
  MGNO_V.toString()!='null'?sqlMGNO=" MGNO='$MGNO_V' AND " : sqlMGNO='';

  sql ="SELECT A.*,CASE WHEN ${LoginController().LAN}=2 AND A.MINE IS NOT NULL THEN "
      " A.MINE ELSE MINA END  MINA_D FROM MAT_INF A WHERE $sqlMGNO  MIST=1 "
      " AND EXISTS(SELECT 1 FROM GRO_USR D WHERE D.MGNO=A.MGNO "
      " AND D.GUOU=1 AND D.SUID='${LoginController().SUID}' "
      " AND D.JTID_L=${LoginController().JTID} AND D.SYID_L=${LoginController().SYID} "
      " AND D.CIID_L=${LoginController().CIID} $Wheresql2)"
      " AND A.JTID_L=${LoginController().JTID} "
      " AND A.SYID_L=${LoginController().SYID} AND A.CIID_L=${LoginController().CIID}"
      " $Wheresql ORDER BY A.MGNO,A.MINO";
  final result = await dbClient!.rawQuery(sql);
  return result.map((json) => Mat_Inf_Local.fromMap(json)).toList();
}