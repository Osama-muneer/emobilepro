import '../Setting/controllers/login_controller.dart';
import '../Setting/models/acc_acc.dart';
import '../Setting/models/acc_tax_c.dart';
import '../Setting/models/acc_tax_t.dart';
import '../Setting/models/acc_usr.dart';
import '../Setting/models/bil_cus.dart';
import '../Widgets/config.dart';
import 'database.dart';

final conn = DatabaseHelper.instance;
Future<List<Acc_Tax_T_Local>> GET_ACC_TAX_T() async {
  var dbClient = await conn.database;
  String sql;
  String Wheresql='';
  LoginController().BIID_ALL_V=='1'? Wheresql= " AND  A.BIID_L=${LoginController().BIID}":Wheresql='';
  sql = "SELECT *,CASE WHEN ${LoginController().LAN}=2 AND ATTNE IS NOT NULL THEN ATTNE ELSE ATTNA END  ATTNA_D"
      " FROM ACC_TAX_T A WHERE A.ATTST=1   AND A.JTID_L=${LoginController().JTID} "
      " AND A.SYID_L=${LoginController().SYID} AND A.CIID_L='${LoginController().CIID}' $Wheresql"
      " ORDER BY A.ATTID";
  var result = await dbClient!.rawQuery(sql);

  List<Acc_Tax_T_Local> list = result.map((item) {
    return Acc_Tax_T_Local.fromMap(item);
  }).toList();
  return list;
}

Future<List<Bil_Cus_Local>> GET_BIL_CUS(String TYPE,String GETDateNow,SYST) async {
  var dbClient = await conn.database;
  String sql;
  String sql2='';
  String sql3='';
  String Wheresql='';
  String Wheresql2='';
  String Wheresql3='';
  String Wheresql4='';
  String Wheresql5='';
  String Wheresql6='';
  String Wheresql7='';
  LoginController().BIID_ALL_V=='1'? Wheresql= " AND  A.BIID_L=${LoginController().BIID}":Wheresql='';
  LoginController().BIID_ALL_V=='1'? Wheresql2= " AND  D.BIID_L=A.BIID_L":Wheresql2='';
  LoginController().BIID_ALL_V=='1'? Wheresql3= " AND  B.BIID_L=A.BIID_L":Wheresql3='';
  LoginController().BIID_ALL_V=='1'? Wheresql4= " AND  E.BIID_L=A.BIID_L":Wheresql4='';
  LoginController().BIID_ALL_V=='1'? Wheresql5= " AND  R.BIID_L=A.BIID_L":Wheresql5='';
  LoginController().BIID_ALL_V=='1'? Wheresql6= " AND  S.BIID_L=A.BIID_L":Wheresql6='';
  LoginController().BIID_ALL_V=='1'? Wheresql7= " AND  F.BIID_L=A.BIID_L":Wheresql7='';
  if(TYPE=='DateNow' || TYPE=='FromDate'){
    sql2=" A.BCDO like'%$GETDateNow%' AND";
  }

  if(SYST==1){
    sql3=" AND A.SYST_L=1";
  }else if(SYST==2){
    sql3=" AND A.SYST_L!=1 ";
  }else{
    sql3='';
  }

  sql=" SELECT A.*,E.CWNA,E.CWNE,E.CWID,R.CTNA,R.CTNE,R.CTID,B.BAID,B.BANA,B.BANE,F.BDNA,F.BDNE "
      " ,CASE WHEN ${LoginController().LAN}=2 AND A.BCNE IS NOT NULL THEN A.BCNE ELSE A.BCNA END  BCNA_D"
      " ,CASE WHEN ${LoginController().LAN}=2 AND D.BINE IS NOT NULL THEN D.BINE ELSE D.BINA END  BINA_D "
      ",CASE WHEN ${LoginController().LAN}=2 AND B.BANE IS NOT NULL THEN B.BANE ELSE B.BANA END  BANA_D"
      " FROM BIL_CUS A,BRA_INF D left join BIL_ARE B on A.BAID=B.BAID  AND B.JTID_L=A.JTID_L "
      " AND B.SYID_L=A.SYID_L AND B.CIID_L=A.CIID_L $Wheresql3 "
      " left join COU_WRD E on A.CWID=E.CWID  AND E.JTID_L=A.JTID_L "
      " AND E.SYID_L=A.SYID_L AND E.CIID_L=A.CIID_L $Wheresql4 "
      " left join COU_TOW R on A.CTID=R.CTID AND A.CWID=R.CWID AND   R.JTID_L=A.JTID_L "
      " AND R.SYID_L=A.SYID_L AND R.CIID_L=A.CIID_L $Wheresql5 "
      " left join BIL_DIS F on A.BDID=F.BDID  AND F.JTID_L=A.JTID_L "
      " AND F.SYID_L=A.SYID_L AND F.CIID_L=A.CIID_L $Wheresql4 "
      " WHERE $sql2 D.BIID=A.BIID $sql3 AND A.BCTY=2 "
      " AND (A.BIID IS NULL OR EXISTS(SELECT 1 FROM SYS_USR_B S WHERE A.BIID=S.BIID AND S.SUID=${LoginController().SUID} "
      " AND S.SUBST=1 AND(S.SUBIN=1 OR S.SUBPR=1) AND S.JTID_L=A.JTID_L AND S.SYID_L=A.SYID_L "
      " AND S.CIID_L=A.CIID_L $Wheresql6)) "
      " AND (A.AANO IS NULL OR  EXISTS(SELECT 1 FROM ACC_USR F WHERE A.AANO=F.AANO "
      " AND F.SUID=${LoginController().SUID} "
      " AND (F.AUIN=1 OR F.AUOU=1 OR F.AUPR=1) AND F.JTID_L=A.JTID_L AND F.SYID_L=A.SYID_L "
      " AND F.CIID_L=A.CIID_L $Wheresql7)) "
      " AND A.JTID_L=${LoginController().JTID} "
      " AND A.SYID_L=${LoginController().SYID} AND A.CIID_L='${LoginController().CIID}' $Wheresql "
      " AND D.JTID_L=${LoginController().JTID} "
      " AND D.SYID_L=${LoginController().SYID} AND D.CIID_L='${LoginController().CIID}' $Wheresql2 "
      " ORDER BY A.BCID DESC";
  var result = await dbClient!.rawQuery(sql);
  printLongText(sql);
  List<Bil_Cus_Local> list = result.map((item) {return Bil_Cus_Local.fromMap(item);}).toList();

  return list;
}

Future<Bil_Cus_Local> Save_BIL_CUS(Bil_Cus_Local data) async {
  var dbClient = await conn.database;
  data.BCID = await dbClient!.insert('BIL_CUS', data.toMap());
  return data;
}

Save_ACC_ACC(Acc_Acc_Local Acc_Acc_Data) async {
  var dbClient = await conn.database;
  final res = await dbClient!.insert('ACC_ACC', Acc_Acc_Data.toMap());
  return res;
}

Save_ACC_USR(Acc_Usr_Local Acc_Usr_Data) async {
  var dbClient = await conn.database;
  final res = await dbClient!.insert('ACC_USR', Acc_Usr_Data.toMap());
  return res;
}

Save_ACC_TAX_C(Acc_Tax_C_Local ACC_TAX_C_Data) async {
  var dbClient = await conn.database;
  final res = await dbClient!.insert('ACC_TAX_C', ACC_TAX_C_Data.toMap());
  return res;
}

Future<int> deleteBIL_CUS(int id) async {
  var dbClient = await conn.database;
  return await dbClient!.delete(
      'BIL_CUS', where: 'BCID=?', whereArgs: [id]);
}

Future<int> deleteCUS(TABLENAME,id) async {
  var dbClient = await conn.database;
  return await dbClient!.delete(
      '$TABLENAME', where: 'AANO=?', whereArgs: [id]);
}

Future<List<Bil_Cus_Local>> GET_BCID() async {
  var dbClient = await conn.database;
  String sql;
  String Wheresql='';
  LoginController().BIID_ALL_V=='1'? Wheresql= " AND  BIID_L=${LoginController().BIID}":Wheresql='';
  sql = "SELECT ifnull(MAX(BCID),0)+1 AS BCID FROM BIL_CUS WHERE  JTID_L=${LoginController().JTID} "
  " AND SYID_L=${LoginController().SYID} AND CIID_L='${LoginController().CIID}' $Wheresql";
  var result = await dbClient!.rawQuery(sql);
  List<Bil_Cus_Local> list = result.map((item) {
    return Bil_Cus_Local.fromMap(item);
  }).toList();
  return list;
}

Future<List<Bil_Cus_Local>> CHECK_DELETE_BCID(GETAANO,GETBCID) async {
  var dbClient = await conn.database;
  String sql;
  String Wheresql='';
  LoginController().BIID_ALL_V=='1'? Wheresql= " AND  BIID_L=${LoginController().BIID}":Wheresql='';
  sql = "SELECT ifnull(COUNT(AANO),0) AS AANO_D FROM ACC_MOV_D WHERE AANO='$GETAANO' AND  JTID_L=${LoginController().JTID} "
  " AND SYID_L=${LoginController().SYID} AND CIID_L='${LoginController().CIID}' $Wheresql";
  var result = await dbClient!.rawQuery(sql);
  if(result[0].values.first==0){
    sql = "SELECT ifnull(COUNT(BCID),0) AS AANO_D FROM BIL_MOV_M WHERE BCID=$GETBCID AND  JTID_L=${LoginController().JTID} "
        " AND SYID_L=${LoginController().SYID} AND CIID_L='${LoginController().CIID}' $Wheresql";
  }
  List<Bil_Cus_Local> list = result.map((item) {
    return Bil_Cus_Local.fromMap(item);
  }).toList();

  return list;
}

UpdateBIL_CUS(GETBCID,BCTID,ATTID,PKID,BCPR,CWID,CTID,BAID,CWID2,CTID2,BAID2,BCNA,BCNE,BCMO,BCAD,BCTX,BCSN,BCBN,BCON,BCC1,BCIN,
             GETJTID, GETSYID, GETBIID, GETCIID,SUCH,DATEU,SYST_L,BDID,BCC3,BCHN,BCLON,BCLAT,BCJT,BCPC,BCAD2,BCQND) async {
  var dbClient = await conn.database;
  final data = {'BCNA':BCNA,'BCNE':BCNE,'BCMO':BCMO,'BCAD':BCAD,'BCTX':BCTX,'BCSN':BCSN,'BCBN':BCBN,'BCON':BCON,
    'BCC1':BCC1,'BCIN':BCIN,'BCTID': BCTID,'ATTID':ATTID, 'CWID': CWID, 'CTID': CTID, 'BAID': BAID,'SUCH':SUCH,
    'DATEU':DATEU,'SYST_L':SYST_L,'PKID':PKID,'BCPR':BCPR,'CWID2': CWID2, 'CTID2': CTID2, 'BAID2': BAID2,
    'BDID': BDID,'BCC3':BCC3,'BCHN':BCHN,'BCLON':BCLON,'BCLAT':BCLAT,'BCJT':BCJT,'BCPC':BCPC,'BCAD2':BCAD2,'BCQND':BCQND};
  final result = await dbClient!.update('BIL_CUS', data,where: "JTID_L=$GETJTID AND BIID_L=$GETBIID AND CIID_L=$GETCIID"
                         " AND SYID_L=$GETSYID AND BCID=$GETBCID");
  return result;
}

UpdateACC_ACC(GETAANO,BCNA,BCNE, GETJTID, GETSYID, GETBIID, GETCIID,SUCH,DATEU) async {
  var dbClient = await conn.database;
  final data = {'AANA':BCNA,'AANE':BCNE, 'SUCH':SUCH,'DATEU':DATEU};
  final result =
  await dbClient!.update('ACC_ACC', data,where: "JTID_L=$GETJTID AND BIID_L=$GETBIID AND CIID_L=$GETCIID"
      " AND SYID_L=$GETSYID AND AANO='$GETAANO'");
  return result;
}

UpdateBIL_NAME_CUS(GETTableName,GETBCID,BMMNA, GETJTID, GETSYID, GETBIID, GETCIID) async {
  var dbClient = await conn.database;
  final data = {'BMMNA':BMMNA};
  final result =
  await dbClient!.update('$GETTableName', data,where: "JTID_L=$GETJTID AND BIID_L=$GETBIID AND CIID_L=$GETCIID"
      " AND SYID_L=$GETSYID AND BCID='$GETBCID'");
  return result;
}

Future<int> UpdateStateBIL_CUS(String TypeSync,GETBCID) async {
  var dbClient = await conn.database;
  String value='';
  if(TypeSync=='SyncAll'){ value='SYST_L!=1';}
  else if(TypeSync=='SyncOnly'){value='SYST_L!=1 and BCID=$GETBCID';
  }

  final data = {'SYST_L':1,'BCDL_L':1};
  final result = await dbClient!.update('BIL_CUS', data, where: value);
  return result;
}


Future<int> UpdateStateACC(TypeTable) async {
  var dbClient = await conn.database;
  final data = {'SYST_L':1};
  final result = await dbClient!.update(TypeTable, data, where: 'SYST_L!=1');
  return result;
}

UpdateTAX_LIN(GETAANO,TLTN, GETJTID, GETSYID, GETBIID, GETCIID,SUCH,DATEU) async {
  var dbClient = await conn.database;
  final data = {'TLTN':TLTN, 'SUCH':SUCH,'DATEU':DATEU};
  final result =
  await dbClient!.update('TAX_LIN', data,where: "JTID_L=$GETJTID AND BIID_L=$GETBIID AND CIID_L=$GETCIID"
      " AND SYID_L=$GETSYID AND TLNO='$GETAANO' AND TLTY='CUS'");
  return result;
}

Future<bool> CompareBCNAInputWithDatabase(String BCNAInput) async {
  var db = await conn.database;
  // استعلام للمقارنة بين الحقل المدخل وعمود في جدول BIL_CUS
  List<Map<String, dynamic>> result = await db!.query('BIL_CUS',
    where: 'BCNA = ?',
    whereArgs: [BCNAInput],
  );

  // إرجاع قيمة لتحديد إذا كانت البيانات موجودة أم لا
  if (result.isNotEmpty) {
    return true;  // تم العثور على بيانات مطابقة
  } else {
    return false; // لا توجد بيانات مطابقة
  }

}
