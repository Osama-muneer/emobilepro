import '../Operation/models/bif_tra_tbl.dart';
import '../Setting/models/pay_kin.dart';
import '../Setting/models/tax_cod.dart';
import 'package:intl/intl.dart';
import 'package:uuid/uuid.dart';
import '../Operation/models/bif_cou_c.dart';
import '../Operation/models/bif_cou_m.dart';
import '../Operation/models/bif_eord_m.dart';
import '../Operation/models/bif_mov_a.dart';
import '../Operation/models/bil_mov_d.dart';
import '../Operation/models/bil_mov_m.dart';
import '../Setting/controllers/login_controller.dart';
import '../Setting/models/bal_acc_m.dart';
import '../Setting/models/bif_cus_d.dart';
import '../Setting/models/bil_cre_c.dart';
import '../Setting/models/bil_cus.dart';
import '../Setting/models/bil_dis.dart';
import '../Setting/models/bil_imp.dart';
import '../Setting/models/bil_poi.dart';
import '../Setting/models/cou_inf_m.dart';
import '../Setting/models/cou_red.dart';
import '../Setting/models/cou_tow.dart';
import '../Setting/models/cou_typ_m.dart';
import '../Setting/models/cou_wrd.dart';
import '../Setting/models/fat_api_inf.dart';
import '../Setting/models/fat_csid_inf.dart';
import '../Setting/models/fat_csid_seq.dart';
import '../Setting/models/fat_inv_rs.dart';
import '../Setting/models/fat_inv_snd.dart';
import '../Setting/models/fat_inv_snd_d.dart';
import '../Setting/models/fat_inv_snd_r.dart';
import '../Setting/models/fat_que.dart';
import '../Setting/models/ide_lin.dart';
import '../Setting/models/list_value.dart';
import '../Setting/models/mat_des_m.dart';
import '../Setting/models/mat_dis_m.dart';
import '../Setting/models/mat_fol.dart';
import '../Setting/models/mat_gro.dart';
import '../Setting/models/mat_inf.dart';
import '../Setting/models/mat_inf_d.dart';
import '../Setting/models/mat_uni.dart';
import '../Setting/models/mat_uni_b.dart';
import '../Setting/models/mat_uni_c.dart';
import '../Setting/models/res_emp.dart';
import '../Setting/models/res_sec.dart';
import '../Setting/models/res_tab.dart';
import '../Setting/models/sto_inf.dart';
import '../Setting/models/sto_num.dart';
import '../Setting/models/sys_cur.dart';
import '../Setting/models/sys_cur_bet.dart';
import '../Setting/models/sys_own.dart';
import '../Setting/models/tax_cod_sys_d.dart';
import '../Setting/models/tax_lin.dart';
import '../Setting/models/tax_sys.dart';
import '../Setting/models/tax_tbl_lnk.dart';
import '../Setting/models/tax_typ.dart';
import '../Setting/models/tax_typ_bra.dart';
import '../Setting/models/tax_var_d.dart';
import '../Widgets/ES_FAT_PKG.dart';
import '../Widgets/config.dart';
import 'database.dart';

final conn = DatabaseHelper.instance;

Future<List<Sys_Own_Local>> GET_SYS_OWN_INV(int GetBIID) async {
  var dbClient = await conn.database;
  //AMHAD
  String sql;
  String Wheresql='';
  String Wheresql2='';
  String Wheresql3='';
  LoginController().BIID_ALL_V=='1'? Wheresql= " AND  A.BIID_L=${LoginController().BIID}":Wheresql='';
  LoginController().BIID_ALL_V=='1'? Wheresql2= " AND  B.BIID_L=${LoginController().BIID}":Wheresql2='';
  LoginController().BIID_ALL_V=='1'? Wheresql3= " AND  C.BIID_L=${LoginController().BIID}":Wheresql3='';
  sql = "SELECT A.*,CASE WHEN ${LoginController().LAN}=2 AND B.CWNE IS NOT NULL THEN B.CWNE ELSE B.CWNA END  CWNA_D,"
      "  CASE WHEN ${LoginController().LAN}=2 AND C.CTNE IS NOT NULL THEN C.CTNE ELSE C.CTNA END  CTNA_D"
      " FROM SYS_OWN A,COU_WRD B,COU_TOW C WHERE A.BIID=$GetBIID AND A.JTID_L=${LoginController().JTID} "
      " AND A.SYID_L=${LoginController().SYID} AND A.CIID_L=${LoginController().CIID} $Wheresql"
      " AND B.CWID=A.CWID AND B.JTID_L=${LoginController().JTID} "
      " AND B.SYID_L=${LoginController().SYID} AND B.CIID_L=${LoginController().CIID} $Wheresql2"
      " AND (C.CWID=A.CWID AND C.CTID=A.CTID) AND C.JTID_L=${LoginController().JTID} "
      " AND C.SYID_L=${LoginController().SYID} AND C.CIID_L=${LoginController().CIID} $Wheresql3";
  var result = await dbClient!.rawQuery(sql);
  //if (result.length == 0) return null;
  List<Sys_Own_Local> list = result.map((item) {
    return Sys_Own_Local.fromMap(item);
  }).toList();
  return list;
}

Future<List<Pay_Kin_Local>> GET_PAY_KIN(int BMKID,String SYS_TYPE,int UPIN_PKID,String GETBPID) async {
  var dbClient = await conn.database;
  String sql;
  String sql2='';
  String sql3='';
  String Wheresql='';
  LoginController().BIID_ALL_V=='1'? Wheresql= " AND  A.BIID_L=${LoginController().BIID}":Wheresql='';
  if(SYS_TYPE=='BO' && UPIN_PKID==1 || SYS_TYPE=='BI' && UPIN_PKID==1  ||
      SYS_TYPE=='AC' && UPIN_PKID==1 ||  SYS_TYPE=='REP' && UPIN_PKID==1){
    sql2=' PKID IN(1,3,8,9)';
  }else if(SYS_TYPE=='BF' && UPIN_PKID==1){
    sql2=' PKID IN(1,3,8)';
  }else if(SYS_TYPE=='CUS'){
    sql2=' PKID IN(1,2,3,4,5,6,8)';
  }else{
    sql2=' PKID IN(1,2,8,9)';
  }
  BMKID==11 || BMKID==12?
  sql3="AND EXISTS(SELECT 1 FROM BIL_POI_U B WHERE B.BPUUS IS NOT NULL AND B.BPID IS NOT NULL AND "
      "  B.BPUUS='${LoginController().SUID}' AND B.BPID=$GETBPID AND ((B.PKIDT=0 AND A.PKID=A.PKID ) "
      "  OR (B.PKIDT=1 AND INSTR(B.PKIDV,'<'||A.PKID||'>')>0)))":sql3='';

  sql = "SELECT *,CASE WHEN ${LoginController().LAN}=2 AND A.PKNE IS NOT NULL THEN A.PKNE ELSE A.PKNA END  PKNA_D"
      " FROM PAY_KIN A WHERE $sql2 $sql3 AND  A.JTID_L=${LoginController().JTID} "
      " AND A.SYID_L=${LoginController().SYID} AND A.CIID_L='${LoginController().CIID}' $Wheresql"
      " ORDER BY A.PKID ";
  var result = await dbClient!.rawQuery(sql);
  List<Pay_Kin_Local> list = result.map((item) {
    return Pay_Kin_Local.fromMap(item);
  }).toList();
  return list;
}

Future<List<Pay_Kin_Local>> GET_PAY_KIN_ONE(int BMKID,String SYS_TYPE,int UPIN_PKID,String GETBPID) async {
  var dbClient = await conn.database;
  String sql;
  String sql2='';
  String sql3='';
  String Wheresql='';
  String Wheresql2='';
  LoginController().BIID_ALL_V=='1'? Wheresql= " AND  A.BIID_L=${LoginController().BIID}":Wheresql='';
  LoginController().BIID_ALL_V=='1'? Wheresql2= " AND B.BIID_L=${LoginController().BIID}":Wheresql2='';
  if(SYS_TYPE=='BO' && UPIN_PKID==1 || SYS_TYPE=='BI' && UPIN_PKID==1  ||
      SYS_TYPE=='AC' && UPIN_PKID==1 ||  SYS_TYPE=='REP' && UPIN_PKID==1){
    sql2=' PKID IN(1,3,8,9)';
  }else if(SYS_TYPE=='BF' && UPIN_PKID==1){
    sql2=' PKID IN(1,3,8)';
  }else{
    sql2=' PKID IN(1,8,9)';
  }
  BMKID==11?sql3=" AND EXISTS(SELECT 1 FROM BIL_POI_U B WHERE B.BPUUS IS NOT NULL AND B.BPID IS NOT NULL AND "
      "  B.BPUUS='${LoginController().SUID}' AND B.BPID=$GETBPID AND ((B.PKIDT=0 AND A.PKID=A.PKID ) "
      "  OR (B.PKIDT=1 AND INSTR(B.PKIDV,'<'||A.PKID||'>')>0)) AND B.JTID_L=${LoginController().JTID} "
      " AND B.SYID_L=${LoginController().SYID} AND B.CIID_L=${LoginController().CIID} $Wheresql2)":sql3='';

  sql = "SELECT *,CASE WHEN ${LoginController().LAN}=2 AND A.PKNE IS NOT NULL THEN A.PKNE ELSE A.PKNA END  PKNA_D"
      " FROM PAY_KIN A WHERE $sql2 $sql3 AND  A.JTID_L=${LoginController().JTID} "
      " AND A.SYID_L=${LoginController().SYID} AND A.CIID_L='${LoginController().CIID}' $Wheresql"
      " ORDER BY A.PKID LIMIT 1 ";
  var result = await dbClient!.rawQuery(sql);
  List<Pay_Kin_Local> list = result.map((item) {
    return Pay_Kin_Local.fromMap(item);
  }).toList();
  return list;
}

Future<List<Mat_Inf_Local>> Get_MAT_INF(int BMKID,String SHOW_ITEM,String Allow_Show_Items,
    String GetSIID,String GetMGNO,int TYPESQL,String GETSCID,String GETBIID,TYPE_MGNO) async {
  var dbClient = await conn.database;
  String sql='';
  String sql2='';
  String sql6='';
  String MGNOsql='';
  String MGNOsql2='';
  String sqLBPPR='';
  String sql3='';
  String sql4='';
  String sql5='';
  String sql7='';
  String Wheresql='';
  String Wheresql2='';
  String Wheresql3='';
  String Wheresql4='';
  String Wheresql5='';
  String Wheresql7='';
  String Wheresql8='';
  String Wheresql9='';

  LoginController().BIID_ALL_V=='1'? Wheresql= " AND C.BIID_L=A.BIID_L":Wheresql='';
  LoginController().BIID_ALL_V=='1'? Wheresql2= " AND A.BIID_L=${LoginController().BIID}":Wheresql2='';
  LoginController().BIID_ALL_V=='1'? Wheresql3= " AND B.BIID_L=A.BIID_L":Wheresql3='';
  LoginController().BIID_ALL_V=='1'? Wheresql4= " AND D.BIID_L=A.BIID_L":Wheresql4='';
  LoginController().BIID_ALL_V=='1'? Wheresql7= " AND GU.BIID_L=D.BIID_L ":Wheresql7='';
  LoginController().BIID_ALL_V=='1'? Wheresql8= " AND D.BIID_L=C.BIID_L ":Wheresql8='';
  LoginController().BIID_ALL_V=='1'? Wheresql9= " AND D.BIID_L=E.BIID_L ":Wheresql9='';
  LoginController().BIID_ALL_V=='1'? Wheresql5= " AND D.BIID_L=B.BIID_L ":Wheresql5='';


  if(TYPE_MGNO=='2' && GetMGNO!='0'){
    MGNOsql=" A.MGNO='$GetMGNO' AND  ";
  }else{
    MGNOsql2='';
  }


  if((BMKID!=1 && BMKID!=2 && BMKID!=4) && (SHOW_ITEM=='2' || (SHOW_ITEM=='3' && Allow_Show_Items!='1'))){
    sql3=" AND (B.MGKI=2 OR (B.MGKI=1 AND EXISTS(SELECT 1 FROM STO_NUM C WHERE  C.SIID=$GetSIID "
        " AND (C.MGNO=A.MGNO AND C.MINO=A.MINO) "
        " AND C.JTID_L=${LoginController().JTID} AND C.SYID_L=${LoginController().SYID} "
        " AND C.CIID_L=${LoginController().CIID} $Wheresql))) ";

    sql7=" AND (C.MGKI=2 OR (C.MGKI=1 AND EXISTS(SELECT 1 FROM STO_NUM C WHERE  C.SIID=$GetSIID "
        " AND (C.MGNO=A.MGNO AND C.MINO=A.MINO) "
        " AND C.JTID_L=${LoginController().JTID} AND C.SYID_L=${LoginController().SYID} "
        " AND C.CIID_L=${LoginController().CIID} $Wheresql))) ";
  }

  if(BMKID==1 || BMKID==4 || BMKID==12){
    sql4=" D.GUIN=1 ";
    sql5=" GU.GUIN=1 ";
  }
  else{
    sql4=" D.GUOU=1 ";
    sql5=" GU.GUOU=1 ";
  }

  // print(GetMGNO);
  // print(MGNOsql2);
  // print('MGNOsql2');

  sql=" SELECT A.*,B.MGKI,CASE WHEN ${LoginController().LAN}=2 AND A.MINE IS NOT NULL THEN A.MINE ELSE A.MINA END  MINA_D "
      " FROM MAT_INF A,MAT_GRO B WHERE  "
      " A.MIST!=2 AND A.JTID_L=${LoginController().JTID} AND A.SYID_L=${LoginController().SYID} "
      " AND A.CIID_L=${LoginController().CIID} $Wheresql2 AND A.MGNO=B.MGNO AND B.MGTY=2 "
      " AND B.JTID_L=${LoginController().JTID} AND B.SYID_L=${LoginController().SYID} "
      " AND B.CIID_L=${LoginController().CIID} $Wheresql3 "
      " AND $MGNOsql  EXISTS(SELECT 1 FROM GRO_USR D WHERE D.MGNO=A.MGNO "
      " AND $sql4 AND D.SUID='${LoginController().SUID}' "
      " AND D.JTID_L=${LoginController().JTID} AND D.SYID_L=${LoginController().SYID} "
      " AND D.CIID_L=${LoginController().CIID} $Wheresql4)"
      " $sql3  ORDER BY A.MGNO,A.MINO ";


  sql2=" SELECT D.MGNO,D.MINO,D.MUCBC,D.MUID,B.MPS1,B.MPS2,B.MPS3,B.MPS4,C.MGKI,"
      " CASE WHEN ${LoginController().LAN}=2 AND A.MINE IS NOT NULL THEN A.MINE ELSE A.MINA END  MINA_D,"
      " CASE WHEN ${LoginController().LAN}=2 AND D.MUCNE IS NOT NULL THEN D.MUCNE ELSE D.MUCNA END  MUCNA_D,"
      " CASE WHEN ${LoginController().LAN}=2 AND E.MUNE IS NOT NULL THEN E.MUNE ELSE E.MUNA END  MUNA_D"
      " FROM MAT_INF A,MAT_PRI B,MAT_GRO C,MAT_UNI_C D,MAT_UNI E WHERE  C.MGTY=2 AND  A.MIST!=2 "
      " AND A.JTID_L=${LoginController().JTID} AND A.SYID_L=${LoginController().SYID} "
      " AND A.CIID_L=${LoginController().CIID} $Wheresql "
      " AND (D.MGNO=A.MGNO AND D.MINO=A.MINO AND D.JTID_L=A.JTID_L AND D.CIID_L=A.CIID_L AND D.SYID_L=A.SYID_L $Wheresql2)"
      " AND (D.MGNO=C.MGNO AND D.JTID_L=C.JTID_L AND D.CIID_L=C.CIID_L AND D.SYID_L=C.SYID_L $Wheresql3) "
      " AND (D.MUID=E.MUID AND D.JTID_L=E.JTID_L AND D.CIID_L=E.CIID_L AND D.SYID_L=E.SYID_L $Wheresql4) "
      " AND (D.MGNO=B.MGNO AND D.MINO=B.MINO AND D.MUID=B.MUID AND D.JTID_L=B.JTID_L AND D.CIID_L=B.CIID_L "
      " AND D.SYID_L=B.SYID_L $Wheresql5) "
      " AND B.BIID=$GETBIID AND B.SCID=$GETSCID AND $MGNOsql  "
      " EXISTS(SELECT 1 FROM GRO_USR GU WHERE GU.MGNO=C.MGNO AND  $sql5"
      "  AND GU.SUID='${LoginController().SUID}'"
      " AND GU.JTID_L=D.JTID_L AND GU.CIID_L=D.CIID_L AND GU.SYID_L=D.SYID_L $Wheresql7)"
      " $sql7 ORDER BY A.ORDNU ";

  var result = await dbClient!.rawQuery(TYPESQL==2?sql2:sql);
//  printLongText(TYPESQL==2?sql2:sql);
//  printLongText('Get_MAT_INF');
  List<Mat_Inf_Local> list = result.map((item) {
    return Mat_Inf_Local.fromMap(item);
  }).toList();
  return list;
}

Future<List<Mat_Inf_Local>> Get_MUIDS_D(String GetMGNO,String GetMINO) async {
  var dbClient = await conn.database;
  String sql;
  String Wheresql='';

  LoginController().BIID_ALL_V=='1'? Wheresql= " AND  BIID_L=${LoginController().BIID}":Wheresql='';

  sql = "SELECT * FROM MAT_INF where MGNO='$GetMGNO' AND MINO='$GetMINO' AND "
      "JTID_L=${LoginController().JTID} AND SYID_L=${LoginController().SYID} AND "
      "CIID_L=${LoginController().CIID} $Wheresql ";
  var result = await dbClient!.rawQuery(sql);
  List<Mat_Inf_Local> list = result.map((item) {
    return Mat_Inf_Local.fromMap(item);
  }).toList();
  return list;
}

Future<List<Sto_Num_Local>> Get_SNDE_ONE(String GETMGNO,String GETMINO,String GETSIID,String GETMUID) async {
  var dbClient = await conn.database;
  String sql;
  String Wheresql='';
  LoginController().BIID_ALL_V=='1'? Wheresql= " AND  BIID_L=${LoginController().BIID}":Wheresql='';

  sql = "SELECT MIN(SNED) AS SNED FROM STO_NUM WHERE  SIID=$GETSIID AND  MGNO='$GETMGNO' AND MINO='$GETMINO' AND MUID=$GETMUID"
      " AND JTID_L=${LoginController().JTID} AND SYID_L=${LoginController().SYID} "
      " AND CIID_L=${LoginController().CIID} $Wheresql ORDER BY SIID DESC LIMIT 1";
  var result = await dbClient!.rawQuery(sql);
  // print(sql);
  // print(result);
  // print('Get_SNDE_ONE');
  List<Sto_Num_Local> list = result.map((item) {
    return Sto_Num_Local.fromMap(item);
  }).toList();
  return list;
}

Future<List<Mat_Uni_C_Local>> GetMat_Uni_C(String StringMGNO,String StringMINO) async {
  var dbClient = await conn.database;
  String sql;
  String Wheresql='';
  String Wheresql2='';
  LoginController().BIID_ALL_V=='1'? Wheresql= " AND A.BIID_L=${LoginController().BIID}":Wheresql='';
  LoginController().BIID_ALL_V=='1'? Wheresql2= " AND B.BIID_L=${LoginController().BIID}":Wheresql='';

  sql =" SELECT A.*,B.MUNA,CASE WHEN ${LoginController().LAN}=2 AND MUNE IS NOT NULL THEN MUNE ELSE MUNA END  MUNA_D "
      " FROM MAT_UNI_C A,MAT_UNI B "
      " WHERE B.MUID=A.MUID AND A.MGNO='$StringMGNO' AND  A.MINO='$StringMINO'"
      " AND A.JTID_L=${LoginController().JTID} "
      " AND A.SYID_L=${LoginController().SYID} AND A.CIID_L=${LoginController().CIID} $Wheresql"
      " AND B.JTID_L=${LoginController().JTID} "
      " AND B.SYID_L=${LoginController().SYID} AND B.CIID_L=${LoginController().CIID} $Wheresql2";
  var result = await dbClient!.rawQuery(sql);
  List<Mat_Uni_C_Local> list = result.map((item) {
    return Mat_Uni_C_Local.fromMap(item);
  }).toList();
  return list;
}

Future<List<Bil_Mov_M_Local>> GET_BMMID(String TAB_N) async {
  var dbClient = await conn.database;
  String sql;
  sql = "SELECT ifnull(MAX(BMMID),0)+1 AS BMMID FROM $TAB_N ";
  var result = await dbClient!.rawQuery(sql);
  List<Bil_Mov_M_Local> list = result.map((item) {
    return Bil_Mov_M_Local.fromMap(item);
  }).toList();
  return list;
}

Future<List<Bil_Mov_D_Local>> GET_BMDID(String TAB_N,int GETBMMID) async {
  var dbClient = await conn.database;
  String sql;
  sql = "SELECT ifnull(MAX(BMDID),0)+1 AS BMDID FROM $TAB_N  WHERE  BMMID=$GETBMMID  ";
  var result = await dbClient!.rawQuery(sql);
  List<Bil_Mov_D_Local> list = result.map((item) {
    return Bil_Mov_D_Local.fromMap(item);
  }).toList();
  return list;
}

Future<List<Sto_Num_Local>> GET_SMDED(String GETMGNO,String GETMINO,String GETSIID,String GETMUID) async {
  var dbClient = await conn.database;
  String sql;
  String Wheresql='';
  LoginController().BIID_ALL_V=='1'? Wheresql= " AND  BIID_L=${LoginController().BIID}":Wheresql='';

  sql = "SELECT * FROM STO_NUM WHERE SIID=$GETSIID AND  MGNO='$GETMGNO' AND MINO='$GETMINO' AND MUID=$GETMUID "
      " AND SNNO>0 AND JTID_L=${LoginController().JTID} "
      " AND SYID_L=${LoginController().SYID} AND CIID_L=${LoginController().CIID} $Wheresql ORDER BY SNED";
  var result = await dbClient!.rawQuery(sql);
  //if (result.length == 0) return null;
  List<Sto_Num_Local> list = result.map((item) {
    return Sto_Num_Local.fromMap(item);
  }).toList();
  return list;
}

Future<List<Bil_Mov_D_Local>> GET_BIL_MOV_D(String TAB_N,String BMMIDNUM,String GETMINA,String GETTYPE_SHOW) async {
  var dbClient = await conn.database;
  //List<Map> maps = await dbClient!.query(STO_MOV_D_TABLE, columns: [SMDID, MINO,MUID,SMDNO]);
  String sql;
  String sql2='';
  String sqlCOU='';
  String sqlCOU2='';
  String sqlCOU3='';
  String sqlBMDTY='';
  String Wheresql='';
  String Wheresql2='';
  String Wheresql3='';
  String Wheresql4='';
  String Wheresql5='';
  LoginController().BIID_ALL_V=='1'? Wheresql= " AND A.BIID_L=${LoginController().BIID}":Wheresql='';
  LoginController().BIID_ALL_V=='1'? Wheresql2= " AND B.BIID_L=${LoginController().BIID}":Wheresql='';
  LoginController().BIID_ALL_V=='1'? Wheresql3= " AND C.BIID_L=${LoginController().BIID}":Wheresql3='';
  LoginController().BIID_ALL_V=='1'? Wheresql4= " AND D.BIID_L=${LoginController().BIID}":Wheresql4='';
  LoginController().BIID_ALL_V=='1'? Wheresql5= " AND E.BIID_L=${LoginController().BIID}":Wheresql5='';

  if (GETTYPE_SHOW=='2'){
    sqlBMDTY=' A.BMDTY=1 AND ';
  }

  if(GETMINA.isNotEmpty){
    sql2=" AND B.MINA LIKE '%$GETMINA%' ";
  }

  STMID=='COU'? sqlCOU=' ,CASE WHEN ${LoginController().LAN}=2 AND E.CIMNE IS NOT NULL THEN E.CIMNE '
      ' ELSE E.CIMNA END  CIMNA_D':sqlCOU='';
  STMID=='COU'? sqlCOU2=',COU_INF_M E':sqlCOU2='';
  STMID=='COU'? sqlCOU3=" AND E.CTMID=A.CTMID AND E.CIMID=A.CIMID "
      " AND E.JTID_L=${LoginController().JTID} AND E.SYID_L=${LoginController().SYID} AND "
      " E.CIID_L='${LoginController().CIID}' $Wheresql5":sqlCOU3='';

  sql =" SELECT *,CASE WHEN ${LoginController().LAN}=2 AND B.MINE IS NOT NULL AND "
      " C.MUNE IS NOT NULL THEN B.MINE||'-'||C.MUNE ELSE B.MINA||'-'||C.MUNA END  NAM,"
      " CASE WHEN ${LoginController().LAN}=2 AND B.MINE IS NOT NULL AND "
      " C.MUNE IS NOT NULL THEN B.MINO||'-'||B.MINE||'-'||C.MUNE ELSE B.MINO||' -'||B.MINA END  NAM_D, "
      " CASE WHEN ${LoginController().LAN}=2 AND B.MINE IS NOT NULL  THEN B.MINE ELSE B.MINA END  MINA_D,"
      " CASE WHEN ${LoginController().LAN}=2 AND C.MUNE IS NOT NULL  THEN C.MUNE ELSE C.MUNA END  MUNA_D,"
      " CASE WHEN ${LoginController().LAN}=2 AND D.MGNE IS NOT NULL  THEN D.MGNE ELSE D.MGNA END  MGNA_D "
      " $sqlCOU "
      " FROM $TAB_N A,MAT_INF B,MAT_UNI C ,MAT_GRO D $sqlCOU2 "
      " WHERE $sqlBMDTY A.MINO=B.MINO AND A.MGNO=D.MGNO AND C.MUID=A.MUID AND B.MGNO=A.MGNO "
      " AND A.BMMID=$BMMIDNUM  $sql2  $sqlCOU3"
      " AND A.JTID_L=${LoginController().JTID} "
      " AND A.SYID_L=${LoginController().SYID} AND A.CIID_L=${LoginController().CIID} $Wheresql"
      " AND B.JTID_L=${LoginController().JTID} "
      " AND B.SYID_L=${LoginController().SYID} AND B.CIID_L=${LoginController().CIID} $Wheresql2"
      " AND C.JTID_L=${LoginController().JTID} "
      " AND C.SYID_L=${LoginController().SYID} AND C.CIID_L=${LoginController().CIID} $Wheresql3"
      " AND D.JTID_L=${LoginController().JTID} "
      " AND D.SYID_L=${LoginController().SYID} AND D.CIID_L=${LoginController().CIID} $Wheresql4";
  var result = await dbClient!.rawQuery(sql);
  // print(sql);
  // print(result);
  // print('GET_BIL_MOV_D');
  List<Bil_Mov_D_Local> list = result.map((item) {
    return Bil_Mov_D_Local.fromMap(item);
  }).toList();
  return list;
}

Future<List<Bil_Mov_M_Local>> GET_BIL_MOV_M(String TAB_N,int GETBMKID,String TYPE,String GETDateNow,
    int GETBMKID2,int GETBMMST,String BIID_F,String BIID_T,String BMMDO_F,String BMMDO_T,String SCID_V,
    String PKID_V,int REUTEN_T,int TYPE_SER) async {
  var dbClient = await conn.database;
  String sql;
  String sql2='';
  String sql3='';
  String sql_R='';
  String Wheresql='';
  String Wheresql2='';
  String Wheresql3='';
  String Wheresql4='';
  String Wheresql7='';
  String Wheresql8='';
  String Wheresql9='';
  String Wheresql10='';
  String SqlTable='';
  String SqlORD='';
  String sqlRSID='';
  String sqlRTID='';
  String sqlBPID='';
  String sqlCTMID='';
  String sqlBMMID='';
  String sqlBMMST='';
  String sqlSCID='';
  String sqlBIID2='';
  String sqlPKID='';
  REUTEN_T==1?sql_R="  ":sql_R='';

  // if( TYPE=='DateNow' || TYPE=='FromDate' ){
  //   sql2=" A.BMMDO like'%$GETDateNow%' AND";
  // }

  sql2=" (A.BMMDOR BETWEEN '$BMMDO_F' AND '$BMMDO_T')  AND";

  if( GETBMMST==1){
    if(STMID == 'EORD'){
      sqlBMMST=" AND A.BMMST2=1 ";
    }else{
      sqlBMMST=" AND A.BMMST=1 ";
    }
  }else if( GETBMMST==2){
    if(STMID == 'EORD'){
      sqlBMMST=" AND A.BMMST2=2 ";
    }else{
    sqlBMMST=" AND A.BMMST=2 ";
    }
  }else if( GETBMMST==3){
    if(STMID == 'EORD'){
      sqlBMMST=" AND A.BMMST2=4 ";
    }else{
    sqlBMMST=" AND A.BMMST=4 ";
    }
  }else{
    sqlBMMST='';
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

  if(PKID_V.isNotEmpty && PKID_V.toString()!='null'){
    sqlPKID=" AND A.PKID=$PKID_V ";
  }else{
    sqlPKID='';
  }

  if(TYPE_SER==1){
    sql2='';
    sqlSCID='';
    sqlBIID2='';
    sqlPKID='';
  }

  LoginController().BIID_ALL_V=='1'? Wheresql= " AND  A.BIID_L=${LoginController().BIID}":Wheresql='';
  LoginController().BIID_ALL_V=='1'? Wheresql2= " AND  B.BIID_L=${LoginController().BIID}":Wheresql2='';
  LoginController().BIID_ALL_V=='1'? Wheresql3= " AND  C.BIID_L=${LoginController().BIID}":Wheresql3='';
  LoginController().BIID_ALL_V=='1'? Wheresql4= " AND  D.BIID_L=${LoginController().BIID}":Wheresql4='';
  LoginController().BIID_ALL_V=='1'? Wheresql7= " AND  S.BIID_L=${LoginController().BIID}":Wheresql7='';
  LoginController().BIID_ALL_V=='1'? Wheresql8= " AND  F.BIID_L=${LoginController().BIID}":Wheresql8='';
  LoginController().BIID_ALL_V=='1'? Wheresql9= " AND  E.BIID_L=${LoginController().BIID}":Wheresql9='';
  LoginController().BIID_ALL_V=='1'? Wheresql10= " AND  R.BIID_L=${LoginController().BIID}":Wheresql10='';
  LoginController().BIID_ALL_V=='1'? sqlRSID= " AND E.JTID_L=${LoginController().JTID} "
      " AND E.SYID_L=${LoginController().SYID} AND E.CIID_L='${LoginController().CIID}' $Wheresql9 ":sqlRSID='';
  LoginController().BIID_ALL_V=='1'? sqlRTID= " AND R.JTID_L=${LoginController().JTID} "
      " AND R.SYID_L=${LoginController().SYID} AND R.CIID_L='${LoginController().CIID}' $Wheresql10 ":sqlRTID='';

  LoginController().BIID_ALL_V=='1'? sqlBPID= " AND R.JTID_L=${LoginController().JTID} "
      " AND R.SYID_L=${LoginController().SYID} AND R.CIID_L='${LoginController().CIID}' "
      "AND  R.BIID_L=${LoginController().BIID}"
      :sqlBPID=" AND R.JTID_L=${LoginController().JTID} "
      " AND R.SYID_L=${LoginController().SYID} AND R.CIID_L='${LoginController().CIID}'";

  LoginController().BIID_ALL_V=='1'? sqlCTMID= " AND E.JTID_L=${LoginController().JTID} "
      " AND E.SYID_L=${LoginController().SYID} AND E.CIID_L='${LoginController().CIID}' "
      "AND  E.BIID_L=${LoginController().BIID}"
      :sqlCTMID=" AND E.JTID_L=${LoginController().JTID} "
      " AND E.SYID_L=${LoginController().SYID} AND E.CIID_L='${LoginController().CIID}'";

  LoginController().BIID_ALL_V=='1'? sqlBMMID= " AND H.JTID_L=${LoginController().JTID} "
      " AND H.SYID_L=${LoginController().SYID} AND H.CIID_L='${LoginController().CIID}' "
      " AND  H.BIID_L=${LoginController().BIID}"
      :sqlBMMID=" AND H.JTID_L=${LoginController().JTID} "
      " AND H.SYID_L=${LoginController().SYID} AND H.CIID_L='${LoginController().CIID}'";

  STMID=='EORD'?SqlTable=',BIF_MOV_A F left join RES_SEC E on  E.RSID=F.RSID $sqlRSID '
      ' left join RES_TAB R on  R.RSID=F.RSID AND R.RTID=F.RTID $sqlRTID ':
  STMID=='COU'?SqlTable=' LEFT JOIN BIL_POI R ON R.BPID = A.BPID $sqlBPID'
      ' LEFT JOIN COU_TYP_M E ON E.CTMID=A.CTMID $sqlCTMID '
      ' LEFT JOIN BIF_MOV_D H ON H.BMMID=A.BMMID $sqlBMMID ':'';

  STMID=='EORD'?SqlORD=" AND F.BMMID=A.BMMID AND  F.JTID_L=${LoginController().JTID} "
      " AND F.SYID_L=${LoginController().SYID} AND F.CIID_L='${LoginController().CIID}' $Wheresql8 ":'';

  STMID=='EORD'?sql3=' ,F.BMATY,F.RTID,CASE WHEN ${LoginController().LAN}=2 AND E.RSNE IS NOT NULL THEN E.RSNE ELSE E.RSNA END  RSNA_D,'
      ' CASE WHEN ${LoginController().LAN}=2 AND R.RTNE IS NOT NULL THEN R.RTNE ELSE R.RTNA END  RTNA_D,E.RSID ':
  STMID=='COU'?sql3=' ,CASE WHEN ${LoginController().LAN}=2 AND R.BPNE IS NOT NULL THEN R.BPNE '
      'ELSE R.BPNA END  BPNA_D,'
      'CASE WHEN ${LoginController().LAN}=2 AND E.CTMNE IS NOT NULL THEN E.CTMNE '
      'ELSE E.CTMNA END  CTMNA_D,H.BMDNO ' :'';

  sql = " SELECT A.*,C.SCSY,CASE WHEN ${LoginController().LAN}=2 AND B.BINE IS NOT NULL THEN B.BINE ELSE B.BINA END  BINA_D,"
      " CASE WHEN ${LoginController().LAN}=2 AND D.PKNE IS NOT NULL THEN D.PKNE ELSE D.PKNA END  PKNA_D,"
      " CASE WHEN ${LoginController().LAN}=2 AND S.SINE IS NOT NULL THEN S.SINE ELSE S.SINA END  SINA_D,"
      " CASE WHEN ${LoginController().LAN}=2 AND C.SCNE IS NOT NULL THEN C.SCNE ELSE C.SCNA END  SCNA_D  $sql3"
      " FROM $TAB_N A,BRA_INF B ,PAY_KIN D ,STO_INF S,SYS_CUR C $SqlTable "
      " WHERE A.BMKID=$GETBMKID $sqlBMMST $sqlBIID2 $sqlSCID $sqlPKID $sql_R AND $sql2  A.JTID_L=${LoginController().JTID} "
      " AND A.SYID_L=${LoginController().SYID} AND A.CIID_L='${LoginController().CIID}' $Wheresql "
      " AND B.BIID=A.BIID2 AND B.JTID_L=${LoginController().JTID} "
      " AND B.SYID_L=A.SYID_L AND B.CIID_L=A.CIID_L $Wheresql2 "
      " AND C.SCID=A.SCID AND C.JTID_L=A.JTID_L "
      " AND C.SYID_L=A.SYID_L AND C.CIID_L=A.CIID_L $Wheresql3 "
      " AND D.PKID=A.PKID AND D.JTID_L=A.JTID_L "
      " AND D.SYID_L=A.SYID_L AND D.CIID_L=A.CIID_L $Wheresql4 "
      " AND S.SIID=A.SIID AND S.JTID_L=A.JTID_L "
      " AND S.SYID_L=A.SYID_L AND S.CIID_L=A.CIID_L $Wheresql7"
      " $SqlORD ORDER BY A.BMMID DESC";

  var result = await dbClient!.rawQuery(sql);
   // printLongText(sql);
   // print(result);
  List<Bil_Mov_M_Local> list = result.map((item) {return Bil_Mov_M_Local.fromMap(item);
  }).toList();
  return list;
}

Future<Bil_Mov_D_Local> Save_BIF_MOV_D(String TAB_N,Bil_Mov_D_Local data) async {
  var dbClient = await conn.database;
  data.BMDID = await dbClient!.insert(TAB_N, data.toMap());
  return data;
}

Future<Bil_Mov_M_Local> Save_BIF_MOV_M(String TAB_N,Bil_Mov_M_Local data) async {
  var dbClient = await conn.database;
  data.BMMID = await dbClient!.insert(TAB_N, data.toMap());
  return data;
}

Future<Bif_Mov_A_Local> Save_BIF_MOV_A(Bif_Mov_A_Local data) async {
  var dbClient = await conn.database;
  data.BMMID = await dbClient!.insert('BIF_MOV_A', data.toMap());
  return data;
}

Future<BIF_TRA_TBL_Local> Save_BIF_TRA_TBL(BIF_TRA_TBL_Local data) async {
  var dbClient = await conn.database;
  data.BTTID = await dbClient!.insert('BIF_TRA_TBL', data.toMap());
  return data;
}

Future<int> deleteBIL_MOV_D(String TAB_N, id) async {
  var dbClient = await conn.database;
  return await dbClient!.delete(TAB_N, where: 'BMMID=?', whereArgs: [id]);
}

Future<int> deleteBIL_MOV_M(String TAB_N,int id) async {
  var dbClient = await conn.database;
  return await dbClient!.delete(TAB_N, where: 'BMMID=?', whereArgs: [id]);
}

Future<int> deleteBIL_MOV_A(int id) async {
  var dbClient = await conn.database;
  return await dbClient!.delete('BIF_MOV_A', where: 'BMMID=?', whereArgs: [id]);
}

Future<List<Bil_Mov_D_Local>> GET_BiL_Mov_D_DetectApp(String TAB_N1,String TAB_N2) async {
  var dbClient = await conn.database;
  String sql;
  sql = "select A.BMMID from $TAB_N1 A WHERE NOT EXISTS (SELECT 1 FROM $TAB_N2 B WHERE A.BMMID=B.BMMID) "
      " ORDER BY A.BMMID  LIMIT 1";
  var result = await dbClient!.rawQuery(sql);
  List<Bil_Mov_D_Local> list = result.map((item) {
    return Bil_Mov_D_Local.fromMap(item);
  }).toList();
  return list;
}

Future<List<Mat_Uni_B_Local>> Get_BROCODE(String GetMGNO,String GetMINO,String GETMUID) async {
  var dbClient = await conn.database;
  String sql;
  String Wheresql='';
  LoginController().BIID_ALL_V=='1'? Wheresql= " AND  BIID_L=${LoginController().BIID}":Wheresql='';

  sql ="SELECT * FROM MAT_UNI_B  WHERE MGNO='$GetMGNO' AND MINO='$GetMINO' AND MUID=$GETMUID "
      "AND JTID_L=${LoginController().JTID} AND SYID_L=${LoginController().SYID} AND "
      " CIID_L=${LoginController().CIID} $Wheresql ORDER by MGNO,MINO LIMIT 1 ";
  var result = await dbClient!.rawQuery(sql);
  List<Mat_Uni_B_Local> list = result.map((item) {
    return Mat_Uni_B_Local.fromMap(item);
  }).toList();
  return list;
}

Future<List<Sto_Num_Local>> GET_SNNO(String GETBIID,int GETSIID,String StringMGNO,String StringMINO,String IntMUID,
    String USESMDED,String GETSMDED,TYPESIID) async {
  var dbClient = await conn.database;
  String sql;
  String sql2='';
  String sqlSIID='';
  String Wheresql='';
  String Wheresql2='';
  LoginController().BIID_ALL_V=='1'? Wheresql= " AND A.BIID_L=${LoginController().BIID}":Wheresql='';
  LoginController().BIID_ALL_V=='1'? Wheresql2= " AND B.BIID_L=${LoginController().BIID}":Wheresql2='';
  USESMDED == '1' || USESMDED == '3'?sql2=" AND A.SNED='$GETSMDED' ":sql2='';
  TYPESIID==1?sqlSIID=' A.SIID=$GETSIID AND ':sqlSIID=' A.SIID!=$GETSIID AND ';

  sql = "SELECT A.MGNO,A.MINO,ifnull(A.SNNO-ifnull(A.SNHO,0),0) AS SNNO,A.MUID,A.SNED "
      "  FROM STO_NUM A WHERE $sqlSIID A.MGNO='$StringMGNO' AND A.MINO='$StringMINO' "
      "  AND EXISTS (SELECT 1 FROM STO_INF C,STO_USR D WHERE C.SIID=D.SIID AND C.SIID=A.SIID AND D.SIID=A.SIID"
      " AND C.BIID IS NULL OR C.BIID=$GETBIID AND D.SUID IS NOT NULL "
      " AND D.SUID=${LoginController().SUID} AND (D.SUOU=1 OR D.SUIN=1 OR D.SUCH=1 OR D.SUAP=1)"
      " AND C.JTID_L=A.JTID_L AND C.SYID_L=A.SYID_L AND C.CIID_L=A.CIID_L"
      " AND D.JTID_L=A.JTID_L AND D.SYID_L=A.SYID_L AND D.CIID_L=A.CIID_L)"
      " AND A.JTID_L=${LoginController().JTID} "
      " AND A.SYID_L=${LoginController().SYID} AND A.CIID_L=${LoginController().CIID} $Wheresql";

  var result = await dbClient!.rawQuery(sql);
  List<Sto_Num_Local> list = result.map((item) {
    return Sto_Num_Local.fromMap(item);
  }).toList();
  return list;
}



Future<List<Mat_Gro_Local>> GET_MGNA(String GetMGNO) async {
  var dbClient = await conn.database;
  String sql;
  String Wheresql='';
  LoginController().BIID_ALL_V=='1'? Wheresql= " AND BIID_L=${LoginController().BIID}":Wheresql='';
  sql = " SELECT *,CASE WHEN ${LoginController().LAN}=2 AND MGNE IS NOT NULL THEN MGNE ELSE MGNA END  MGNA_D"
      " FROM MAT_GRO WHERE MGNO='$GetMGNO' AND JTID_L=${LoginController().JTID} "
      " AND SYID_L=${LoginController().SYID} "
      " AND CIID_L=${LoginController().CIID} $Wheresql";
  var result = await dbClient!.rawQuery(sql);
  List<Mat_Gro_Local> list = result.map((item) {
    return Mat_Gro_Local.fromMap(item);
  }).toList();
  return list;
}

Future<List<Bil_Cus_Local>> GET_BIL_CUS() async {
  var dbClient = await conn.database;
  String sql;
  String Wheresql='';
  String Wheresql2='';
  LoginController().BIID_ALL_V=='1'? Wheresql= " AND A.BIID_L=${LoginController().BIID}":Wheresql='';
  LoginController().BIID_ALL_V=='1'? Wheresql2= " AND B.BIID_L=A.BIID_L ":Wheresql2='';

  sql=" SELECT *,CASE WHEN ${LoginController().LAN}=2 AND A.BCNE IS NOT NULL THEN A.BCNE ELSE A.BCNA END  BCNA_D"
      " FROM BIL_CUS A WHERE A.BCST!=2 AND A.BCTY=2   AND EXISTS(SELECT 1 FROM ACC_USR B WHERE B.AANO=A.AANO AND B.AUIN=1 "
      " AND B.SUID IS NOT NULL AND B.SUID=${LoginController().SUID} AND B.JTID_L=A.JTID_L AND B.SYID_L=A.SYID_L AND "
      " B.CIID_L=A.CIID_L $Wheresql2) AND A.JTID_L=${LoginController().JTID} "
      " AND A.SYID_L=${LoginController().SYID} AND A.CIID_L='${LoginController().CIID}' $Wheresql "
      " ORDER BY A.BCID ";
  var result = await dbClient!.rawQuery(sql);
  List<Bil_Cus_Local> list = result.map((item) {
    return Bil_Cus_Local.fromMap(item);
  }).toList();
  return list;
}

Future<List<Bil_Mov_M_Local>> GET_BMMNO(String TAB_N,String GETBMKID) async {
  var dbClient = await conn.database;
  String sql;
  String Wheresql='';

  LoginController().BIID_ALL_V=='1'? Wheresql= " AND  BIID_L=${LoginController().BIID}":Wheresql='';
  sql = "SELECT ifnull(MAX(BMMNO),0)+1 AS BMMNO FROM $TAB_N  WHERE BMKID=$GETBMKID AND SUID='${LoginController().SUID}' AND "
      " JTID_L=${LoginController().JTID} AND SYID_L=${LoginController().SYID}  AND CIID_L='${LoginController().CIID}' $Wheresql ";
  var result = await dbClient!.rawQuery(sql);
  List<Bil_Mov_M_Local> list = result.map((item) {
    return Bil_Mov_M_Local.fromMap(item);
  }).toList();
  return list;
}

Future<int> UpdateStateBIL_MOV_D(String TypeSync,String GTBMKID,String GetBMMID,int GetSYST,String TypeTable,GETBMMST,GetFromDate, GetToDate) async {
  var dbClient = await conn.database;
  String value='';
  String SQL='';

  if(TypeSync=='SyncAll'){
    value= GetSYST==1 ? 'BMKID=$GTBMKID AND SYST=2 ':'BMKID=$GTBMKID AND SYST=0';
    SQL = "UPDATE $TypeTable SET SYST=$GetSYST where $value";
  }
  else if(TypeSync=='SyncOnly'){
    value='SYST=2 and BMMID=$GetBMMID';
    SQL = "UPDATE $TypeTable SET SYST=$GetSYST where $value";
  }
  else if(TypeSync=='ByDate'){
    var TBN_M=GTBMKID == '11' || GTBMKID == '12' ? 'BIF_MOV_M' : 'BIL_MOV_M';
    SQL = "UPDATE $TypeTable  SET SYST=$GetSYST where BMKID=$GTBMKID AND"
        " EXISTS(SELECT 1 FROM $TBN_M B WHERE B.BMMDOR BETWEEN '$GetFromDate' AND '$GetToDate' AND B.BMMST=$GETBMMST"
        " and B.BMMID=$TypeTable.BMMID)";
  }

  var result = await dbClient!.rawUpdate(SQL);
  return result;
}

Future<int> UpdateStateBIF_MOV_D_ORDER(String TypeSync,int GTBMKID,String GetBMMID) async {
  var dbClient = await conn.database;
  String value='';
  String SQL='';

  if(TypeSync=='SyncAll'){
    value= 'BMKID=$GTBMKID AND SYST=2 ';
    SQL = "UPDATE BIF_MOV_D SET SYST=1 where $value";
  }
  else if(TypeSync=='SyncOnly'){
    value='BMMID=$GetBMMID';
    SQL = "UPDATE BIF_MOV_D SET SYST=1 where $value";
  }
  var result = await dbClient!.rawUpdate(SQL);
  return result;
}

Future<int> UpdateStateBIF_EPRD_M(int GTBMKID,String GetBMMID) async {
  var dbClient = await conn.database;
  String SQL='';
  SQL = "UPDATE BIF_EORD_M SET BEMBS=1,SUCH=${LoginController().SUID},"
      "DATEU='${DateFormat('dd-MM-yyyy HH:mm:ss').format(DateTime.now())}',DEVU='${LoginController().DeviceName}' "
      " where BMKID=$GTBMKID AND BMMID=$GetBMMID ";
  var result = await dbClient!.rawUpdate(SQL);
  return result;
}

Future<int> UpdateStateBIF_MOV_M(String BMMST,String TypeSync,int GTBMKID,String GetBMMID,String TypeTable,GetFromDate, GetToDate) async {
  var dbClient = await conn.database;
  String SQL='';
  String value='';
  String BMMST2value='';
  if( BMMST=='2' && STMID!='EORD'){
    BMMST2value='1';
  }else{
    BMMST2value=BMMST;
  }
  // BMMST=='2'?BMMST2value='2':BMMST2value='1';
  if(TypeSync=='SyncAll'){
    value=GTBMKID==-1 || GTBMKID==-2?'BMMST=2 ': 'BMMST=2 AND BMKID=$GTBMKID';
    SQL = "UPDATE $TypeTable SET BMMST=1,BMMST2=$BMMST2value where $value";
  }
  else if(TypeSync=='SyncOnly'){
    value='BMMID=$GetBMMID';
    SQL = "UPDATE $TypeTable SET BMMST=1,BMMST2=$BMMST2value where $value";
  }
  else if(TypeSync=='ByDate' && STMID!='EORD'){
    value="BMKID=$GTBMKID AND BMMDOR BETWEEN '$GetFromDate' AND '$GetToDate' AND BMMST=$BMMST";
    SQL = "UPDATE $TypeTable  SET BMMST=1,BMMST2=1 where $value";
  }

  var result = await dbClient!.rawUpdate(SQL);
  return result;
}

Future<int> UpdateBIF_MOV_M_PRINT(int GetBMMPR,int GetBMMST,int GetBMMID) async {
  var dbClient = await conn.database;
  final data = {'BMMPR':GetBMMPR,'BMMST':GetBMMST};
  final result = await dbClient!.update('BIL_MOV_M', data, where: 'BMMID=$GetBMMID AND BMMST!=1');
  return result;
}

Future<List<Bil_Cus_Local>> GET_BIL_CUS_INF(String GETBCID) async {
  var dbClient = await conn.database;
  String sql;
  String Wheresql='';
  LoginController().BIID_ALL_V=='1'? Wheresql= " AND  A.BIID_L=${LoginController().BIID}":Wheresql='';

  sql = "SELECT *,CASE WHEN ${LoginController().LAN}=2 AND A.BCNE IS NOT NULL THEN A.BCNE ELSE A.BCNA END  BCNA_D"
      " FROM BIL_CUS A WHERE A.BCID=$GETBCID AND A.BCTY=2   AND A.JTID_L=${LoginController().JTID} "
      " AND A.SYID_L=${LoginController().SYID} AND A.CIID_L='${LoginController().CIID}' $Wheresql "
      " ORDER BY A.BCID LIMIT 1";
  var result = await dbClient!.rawQuery(sql);
  List<Bil_Cus_Local> list = result.map((item) {
    return Bil_Cus_Local.fromMap(item);
  }).toList();
  try{
    list.elementAt(0).CWWC2=await ES_FAT_PKG.TYP_NAM_F('CWWC2',list.elementAt(0).CWID.toString(),'');
    var BAID_V=await ES_FAT_PKG.TYP_NAM_F('BAID',list.elementAt(0).BAID.toString(),'');
    list.elementAt(0).BAID_D=BAID_V=='null' || BAID_V.isEmpty?list.elementAt(0).BCQND.toString():BAID_V.toString();
    list.elementAt(0).CTNA_D=await ES_FAT_PKG.TYP_NAM_F('CTID',list.elementAt(0).CWID.toString(),list.elementAt(0).CTID.toString());
    var IDE_LIN=await GET_IDE_LIN('CUS', list.elementAt(0).AANO.toString());
    if (IDE_LIN.isNotEmpty){
      list.elementAt(0).ITSY=IDE_LIN.elementAt(0).ITSY.toString();
      list.elementAt(0).ILDE=IDE_LIN.elementAt(0).ILDE.toString();
    }
    var TAX_LIN_CUS=await GET_TAX_LIN(3, LoginController().TTID_N.toString(),'CUS',list.elementAt(0).AANO.toString(),
        list.elementAt(0).BCID.toString());
    if (TAX_LIN_CUS.isNotEmpty){
      list.elementAt(0).BCTX=TAX_LIN_CUS.elementAt(0).TLTN.toString();
    }
  } catch (e, stackTrace) {
    print(' $e $stackTrace');
    return list;
  }
  return list;
}

Future<List<Bil_Imp_Local>> GET_BIL_IMP_INF(String GETBIID) async {
  var dbClient = await conn.database;
  String sql;
  String Wheresql='';
  LoginController().BIID_ALL_V=='1'? Wheresql= " AND  A.BIID_L=${LoginController().BIID}":Wheresql='';

  sql = "SELECT *,CASE WHEN ${LoginController().LAN}=2 AND A.BINE IS NOT NULL THEN A.BINE ELSE A.BINA END  BINA_D"
      " FROM BIL_IMP A WHERE A.BIID=$GETBIID AND A.BITY=2   AND A.JTID_L=${LoginController().JTID} "
      " AND A.SYID_L=${LoginController().SYID} AND A.CIID_L='${LoginController().CIID}' $Wheresql "
      " ORDER BY A.BIID LIMIT 1";
  var result = await dbClient!.rawQuery(sql);
  List<Bil_Imp_Local> list = result.map((item) {
    return Bil_Imp_Local.fromMap(item);
  }).toList();
  return list;
}

Future<List<Bil_Imp_Local>> GET_BIL_IMP() async {
  var dbClient = await conn.database;
  String sql;
  String Wheresql='';
  String Wheresql2='';
  LoginController().BIID_ALL_V=='1'? Wheresql= " AND  A.BIID_L=${LoginController().BIID}":Wheresql='';
  LoginController().BIID_ALL_V=='1'? Wheresql2= " AND  B.BIID_L=${LoginController().BIID}":Wheresql2='';

  sql = "SELECT *,CASE WHEN ${LoginController().LAN}=2 AND A.BINE IS NOT NULL THEN A.BINE ELSE A.BINA END  BINA_D"
      " FROM BIL_IMP A WHERE  A.BITY=2  AND A.BIST!=2 AND EXISTS(SELECT 1 FROM ACC_USR B WHERE B.AANO=A.AANO AND B.AUIN=1 "
      " AND B.SUID IS NOT NULL AND B.SUID=${LoginController().SUID} AND B.JTID_L=${LoginController().JTID} AND B.SYID_L=${LoginController().SYID} AND "
      " B.CIID_L='${LoginController().CIID}' $Wheresql2 ) AND A.JTID_L=${LoginController().JTID} "
      " AND A.SYID_L=${LoginController().SYID} AND A.CIID_L='${LoginController().CIID}' $Wheresql "
      " ORDER BY A.BIID";
  var result = await dbClient!.rawQuery(sql);
  List<Bil_Imp_Local> list = result.map((item) {
    return Bil_Imp_Local.fromMap(item);
  }).toList();
  return list;
}

Future<List<Bil_Mov_D_Local>> COUNT_BMDTXA(String TAB_N,int GetBMMID) async {
  var dbClient = await conn.database;
  String sql;
  sql = "select ifnull(sum(BMDTXA),0.0) AS SUM_BMDTXA from $TAB_N where BMMID=$GetBMMID";
  var result = await dbClient!.rawQuery(sql);
  List<Bil_Mov_D_Local> list = result.map((item) {
    return Bil_Mov_D_Local.fromMap(item);
  }).toList();
  return list;
}

Future<List<Bil_Mov_D_Local>> SUM_BMMAM(String TAB_N,int GetBMMID) async {
  var dbClient = await conn.database;
  String sql;
  sql = "select  ifnull(sum(BMDAMT+BMDAMTF),0.0) AS SUM_BMDAM  from $TAB_N where BMMID=$GetBMMID";
  var result = await dbClient!.rawQuery(sql);
  List<Bil_Mov_D_Local> list = result.map((item) {
    return Bil_Mov_D_Local.fromMap(item);
  }).toList();
  return list;
}

Future<List<Bil_Mov_D_Local>> SUM_BMMAM2(String TAB_N,int GetBMMID) async {
  var dbClient = await conn.database;
  String sql;
  sql = "select  ifnull(sum((BMDAMT+BMDTXT)-BMDDIM),0.0) AS SUM_TOTBMDAM  from $TAB_N where BMMID=$GetBMMID";
  var result = await dbClient!.rawQuery(sql);
  List<Bil_Mov_D_Local> list = result.map((item) {
    return Bil_Mov_D_Local.fromMap(item);
  }).toList();
  return list;
}

Future<List<Bil_Mov_D_Local>> SUM_BMMDIF(String TAB_N,int GetBMMID) async {
  var dbClient = await conn.database;
  String sql;
  sql = "select  ifnull(sum(BMDAMTF),0.0) AS BMMDIF  from $TAB_N where BMMID=$GetBMMID";
  var result = await dbClient!.rawQuery(sql);
  List<Bil_Mov_D_Local> list = result.map((item) {
    return Bil_Mov_D_Local.fromMap(item);
  }).toList();
  return list;
}

Future<List<Bil_Mov_D_Local>> SUM_BMMDI(String TAB_N,int GetBMMID) async {
  var dbClient = await conn.database;
  String sql;
  sql = "select  ifnull(sum(BMDDIM),0.0) AS BMMDI  from $TAB_N where BMMID=$GetBMMID";
  var result = await dbClient!.rawQuery(sql);
  List<Bil_Mov_D_Local> list = result.map((item) {
    return Bil_Mov_D_Local.fromMap(item);
  }).toList();
  return list;
}

Future<int> deleteBIL_MOV_D_ONE(String TAB_N,String DELBMMID, String DELBMDID) async {
  var dbClient = await conn.database;
  var res2 =await dbClient!.delete('$TAB_N', where: 'BMMID=? AND BMDIDR=?', whereArgs: [DELBMMID, DELBMDID]);
  var res =await dbClient.delete('$TAB_N', where: 'BMMID=? AND BMDID=?', whereArgs: [DELBMMID, DELBMDID]);
  return res;
}

Future<List<Bil_Mov_M_Local>> GET_BIL_MOV_M_PRINT(String TAB_N,String GETBMMID) async {
  var dbClient = await conn.database;
  String sql='';
  List<String> whereClauses = [];

  String Wheresql='';
  String Wheresql2='';
  String Wheresql3='';
  LoginController().BIID_ALL_V=='1'? Wheresql= " AND R.JTID_L=${LoginController().JTID} "
      " AND R.SYID_L=${LoginController().SYID} AND R.CIID_L='${LoginController().CIID}' AND  R.BIID_L=${LoginController().BIID}"
      :Wheresql=" AND R.JTID_L=${LoginController().JTID} "
      " AND R.SYID_L=${LoginController().SYID} AND R.CIID_L='${LoginController().CIID}'";

  LoginController().BIID_ALL_V=='1'? Wheresql2= " AND T.JTID_L=${LoginController().JTID} "
      " AND T.SYID_L=${LoginController().SYID} AND T.CIID_L='${LoginController().CIID}' AND  T.BIID_L=${LoginController().BIID}"
      :Wheresql2=" AND T.JTID_L=${LoginController().JTID} "
      " AND T.SYID_L=${LoginController().SYID} AND T.CIID_L='${LoginController().CIID}'";

  LoginController().BIID_ALL_V=='1'? Wheresql3= " AND F.JTID_L=${LoginController().JTID} "
      " AND F.SYID_L=${LoginController().SYID} AND F.CIID_L='${LoginController().CIID}' AND  F.BIID_L=${LoginController().BIID}"
      :Wheresql3=" AND F.JTID_L=${LoginController().JTID} "
      " AND F.SYID_L=${LoginController().SYID} AND F.CIID_L='${LoginController().CIID}'";

  if (LoginController().BIID_ALL_V == '1') {
    String biid = LoginController().BIID.toString();
    whereClauses.add("A.BIID_L = $biid");
    whereClauses.add("B.BIID_L = $biid");
    whereClauses.add("C.BIID_L = $biid");
    whereClauses.add("D.BIID_L = $biid");
    //whereClauses.add("F.BIID_L = $biid");
    whereClauses.add("S.BIID_L = $biid");
    // whereClauses.add("R.BIID_L = $biid");
    //whereClauses.add("T.BIID_L = $biid");
  }

  String jtId = LoginController().JTID.toString();
  String syId = LoginController().SYID.toString();
  String ciId = LoginController().CIID.toString();

  whereClauses.add("A.JTID_L = $jtId");
  whereClauses.add("A.SYID_L = $syId");
  whereClauses.add("A.CIID_L = '$ciId'");
  whereClauses.add("A.BMMID = $GETBMMID");

  sql = """  SELECT A.*, F.ACID AS ACID, R.BPID, T.BCCID,
      CASE WHEN ${LoginController().LAN} = 2 AND B.BINE IS NOT NULL THEN B.BINE ELSE B.BINA END AS BINA_D,
      CASE WHEN ${LoginController().LAN} = 2 AND D.PKNE IS NOT NULL THEN D.PKNE ELSE D.PKNA END AS PKNA_D, '10' AS PKSY,
      CASE WHEN ${LoginController().LAN} = 2 AND S.SINE IS NOT NULL THEN S.SINE ELSE S.SINA END AS SINA_D,
      CASE WHEN ${LoginController().LAN} = 2 AND C.SCNE IS NOT NULL THEN C.SCNE ELSE C.SCNA END AS SCNA_D,C.SCSY,
      CASE WHEN ${LoginController().LAN} = 2 AND F.ACNE IS NOT NULL THEN F.ACNE ELSE F.ACNA END AS ACNA_D,
      CASE WHEN ${LoginController().LAN} = 2 AND R.BPNE IS NOT NULL THEN R.BPNE ELSE R.BPNA END AS BPNA_D,
      CASE WHEN ${LoginController().LAN} = 2 AND T.BCCNE IS NOT NULL THEN T.BCCNE ELSE T.BCCNA END AS BCCID_D,
      (SUBSTR(REPLACE(CAST(A.BMMDO AS TEXT) || ':00', ' ', ''), 7, 4) || '-' ||
      SUBSTR(REPLACE(CAST(A.BMMDO AS TEXT) || ':00', ' ', ''), 4, 2) || '-' ||
      SUBSTR(REPLACE(CAST(A.BMMDO AS TEXT) || ':00', ' ', ''), 1, 2) || 'T' ||
      SUBSTR(REPLACE(CAST(A.BMMDO AS TEXT) || ':00', ' ', ''), 11, 20) || 'Z') AS DAT_TIM_V,
      (SUBSTR(REPLACE(CAST(A.BMMDO AS TEXT) || ':00', ' ', ''), 7, 4) || '-' ||
      SUBSTR(REPLACE(CAST(A.BMMDO AS TEXT) || ':00', ' ', ''), 4, 2) || '-' ||
      SUBSTR(REPLACE(CAST(A.BMMDO AS TEXT) || ':00', ' ', ''), 1, 2)) AS DAT_V,
      round(IFNULL(A.TCAM,0.0)*IFNULL(A.SCEX,0) ,IFNULL(${LoginController().SCSFL_TX},2)) AS TOTVAT_N ,
      IFNULL(A.BMMAM_TX,0.0)-IFNULL(A.BMMDI_TX,0.0) AS TOTAM_N,
      IFNULL(A.BMMAM_TX,0.0)-IFNULL(A.BMMDI_TX,0.0) AS ITE_TOTAM_N,
      IFNULL(A.BMMAM_TX,0.0)-IFNULL(A.BMMDI_TX,0.0) +IFNULL(A.TCAM,0.0) AS TOTAMWVAT_N,
      CASE WHEN IFNULL(A.BMMDI_TX,0.0)>0 THEN  '95' ELSE NULL END  AS DIS_COD_V,
      CASE WHEN IFNULL(A.BMMDI_TX,0.0)>0 THEN  'Discount' ELSE NULL END  AS DIS_RES_V,
      CASE WHEN IFNULL(A.BMMDI_TX,0.0)>0 THEN  A.TCRA ELSE NULL END  AS DIS_VAT_RAT_N,
      'Cancellation' AS INV_REL_RES_V
      FROM $TAB_N A
    LEFT JOIN BRA_INF B ON B.BIID = A.BIID2 AND B.JTID_L = $jtId AND B.SYID_L = $syId AND B.CIID_L = '$ciId'
    LEFT JOIN PAY_KIN D ON D.PKID = A.PKID AND D.JTID_L = $jtId AND D.SYID_L = $syId AND D.CIID_L = '$ciId'
    LEFT JOIN STO_INF S ON S.SIID = A.SIID AND S.JTID_L = $jtId
    LEFT JOIN SYS_CUR C ON C.SCID = A.SCID AND C.JTID_L = $jtId AND C.SYID_L = $syId AND C.CIID_L = '$ciId'
    LEFT JOIN ACC_CAS F ON A.ACID = F.ACID  $Wheresql3
    LEFT JOIN BIL_POI R ON A.BPID = R.BPID  $Wheresql
    LEFT JOIN BIL_CRE_C T ON A.BCCID = T.BCCID $Wheresql2
    WHERE ${whereClauses.join(' AND ')}
    ORDER BY A.BMMID DESC """;

  try {
    var result = await dbClient!.rawQuery(sql);

    List<Bil_Mov_M_Local> list = result.map((item) {
      return Bil_Mov_M_Local.fromMap(item);
    }).toList();
    return list;
  } catch (e ,stackTrace) {
    print('$e $stackTrace');
    print('GET_BIL_MOV_M_PRINT $e');
    return [];
  }
}

Future<int> UpdateBMMNR(String TAB_N,GetBMMNR,int? GetBMMID) async {
  var dbClient = await conn.database;
  final data = {'BMMNR':GetBMMNR};
  final result = await dbClient!.update('$TAB_N', data, where: 'BMMID=$GetBMMID');
  return result;
}

Future<List<Bil_Mov_D_Local>> CountRecode(String TAB_N,int GetBMMID,int GETTYPE) async {
  var dbClient = await conn.database;
  String sql;
  String sql2='';
  if (GETTYPE==2){
    sql2= ' AND BMDTY=1 ';
  }else{
    sql2='';
  }
  sql = "select ifnull(count(1),0) AS COU from $TAB_N where BMMID=$GetBMMID $sql2 ";
  var result = await dbClient!.rawQuery(sql);
  List<Bil_Mov_D_Local> list = result.map((item) {
    return Bil_Mov_D_Local.fromMap(item);
  }).toList();
  return list;
}



Future<int> UpdateBil_Mov_D(String TAB_N,int GetBMKID,int GetBMMID,int GetBMDID,String GetMGNO,String GetMINO,
    int GETMUID,GETSIID,double GetBMDNF,double GetBMDNO,String GETBMDDE,double GetBMDAM,double GETBMDDI,double GETBMDDIR,
    double GETBMDEQ,double GETBMDTX,double GETBMDTX1,double GETBMDTX2,double GETBMDTX3,double GETBMDTXA1,double GETBMDTXA2
    ,double GETBMDTXA3,double GETBMDTXA, double GETBMDDIF,double GETBMDAMT,double GETBMDAMTF,double GETBMDTXT1,
    double GETBMDTXT2,double GETBMDTXT3,double GETBMDTXT,double GETBMDDIT,double GETBMDDIM,
    String GETBMDIN,GETBMDAM_TX,GETBMDDI_TX,BMDAMT3,TCAMT) async {
  var dbClient = await conn.database;
  final data = {'MGNO':GetMGNO,'MINO':GetMINO, 'MUID':GETMUID,'SIID':GETSIID,'BMDNF':GetBMDNF,'BMDNO':GetBMDNO,'BMDED':GETBMDDE,'BMDAM':GetBMDAM,
    'BMDDI':GETBMDDI,'BMDDIR':GETBMDDIR,'BMDEQ':GETBMDEQ,'BMDTXA11':GETBMDTXA1,'BMDTXA22':GETBMDTXA2,'BMDTXA33':GETBMDTXA3
    ,'BMDTXA':GETBMDTXA,'BMDTX':GETBMDTX,'BMDTX11': GETBMDTX1,'BMDTX22':GETBMDTX2,'BMDTX33':GETBMDTX3,'BMDDIF':GETBMDDIF
    ,'BMDAMT':GETBMDAMT,'BMDAMTF':GETBMDAMTF,'BMDTXT1':GETBMDTXT1,'BMDTXT2':GETBMDTXT2,'BMDTXT3':GETBMDTXT3,
    'BMDTXT':GETBMDTXT,'BMDDIT':GETBMDDIT,'BMDDIM':GETBMDDIM,'BMDIN':GETBMDIN,'BMDAM_TX':GETBMDAM_TX,
    'BMDDI_TX':GETBMDDI_TX,'BMDAMT3':BMDAMT3,'TCAMT':TCAMT};
  final result = await dbClient!.update('$TAB_N', data, where: 'BMMID=$GetBMMID AND '
      'BMDID=$GetBMDID');
  return result;
}

Future<List<Bil_Mov_M_Local>> GET_SYNC_DATA(String TAB_N,String GETDATE) async {
  var dbClient = await conn.database;
  String sql;
  String Wheresql='';
  LoginController().BIID_ALL_V=='1'? Wheresql= " AND  BIID_L=${LoginController().BIID}":Wheresql='';

  sql = "SELECT COUNT(*) AS SYNC_COUNT FROM $TAB_N  WHERE BMMST!=1 AND BMMDO<'$GETDATE' "
      " AND JTID_L=${LoginController().JTID} AND SYID_L=${LoginController().SYID} AND CIID_L='${LoginController().CIID}' "
      " $Wheresql ORDER BY BMMID";
  var result = await dbClient!.rawQuery(sql);
  List<Bil_Mov_M_Local> list = result.map((item) {
    return Bil_Mov_M_Local.fromMap(item);
  }).toList();
  return list;
}

Future<List<Sto_Num_Local>> GET_SNNO_ALL(int GETSIID,String StringMGNO,String StringMINO,String IntMUID,String USESMDED,
    String GETSMDED) async {
  var dbClient = await conn.database;
  String sql;
  String sqlSMDED='';
  String Wheresql='';
  LoginController().BIID_ALL_V=='1'? Wheresql= " AND BIID_L=${LoginController().BIID}":Wheresql='';
  if((GETSMDED.isNotEmpty)  && (USESMDED=='1' || USESMDED=='3')){
    sqlSMDED=" AND  SNED='$GETSMDED'";
  }
  sql = "SELECT * FROM STO_NUM WHERE SIID!=$GETSIID AND  MGNO='$StringMGNO' AND MINO='$StringMINO' "
      " AND MUID=$IntMUID  $sqlSMDED  AND JTID_L=${LoginController().JTID} "
      " AND SYID_L=${LoginController().SYID} AND CIID_L=${LoginController().CIID} $Wheresql"
      "  ORDER BY SIID   LIMIT 1";
  var result = await dbClient!.rawQuery(sql);
  List<Sto_Num_Local> list = result.map((item) {
    return Sto_Num_Local.fromMap(item);
  }).toList();
  return list;
}

Future<int> UpdateBIL_MOV_M(String TAB_N,int GetBMKID,int GetBMMID,String GetBMMDO,String GetPKID,
    double GetBMMAM, double GETBMMTX1,double GETBMMTX2,double GETBMMTX3,double GETBMMTX,String GetBMMRE,
    String GETACNO,String GETBCID,String? GETBCID2,int? GETBDID,int? GETACID,String GETBMMIN,String GETBMMDA,String GETAANO,String GETBMMNA,
    int GETBMMST, String GETBMMCN,int? GETBCCID,int? GETABID,int GETBMMNR,String GETBMMEQ,double GETBMMDIF,String GETBMMDN,
    double GETBMMDI, double GETBMMDIR,String GETBMMCD,int GETBMMBR,String GETBMMDD,String GetBMMDOR,double GETBMMMT,String? GETBIID3,
    int? GETAMMID,int? GETSCIDP,double? GETSCEXP,double? GETBMMAMP,double? GETBMMCP,double? GETBMMTC,String? GETBCDID,
    String? GETBCDMO,String? GETGUIDC2,String GETBMMGR,TTLID,TCRA,TCSDID,TCSDSY,TCID,TCSY,BMMAM_TX,
    BMMDI_TX,TCAM, BMMCRT,BMMTN,BMMDR) async {
  var dbClient = await conn.database;

  final data={'BMMDO':GetBMMDO,'PKID':GetPKID, 'BMMAM':GetBMMAM,'ACNO':GETACNO,'ACNO2':GETACNO,'BCID':GETBCID,'BCID2':GETBCID2,
    'BDID':GETBDID,'ACID':GETACID, 'BMMRE':GetBMMRE,'BMMIN':GETBMMIN,'BMMTX11':GETBMMTX1,'BMMTX22':GETBMMTX2,
    'BMMTX33':GETBMMTX3,
    'BMMTX':GETBMMTX,'AANO':GETAANO,'BMMNA':GETBMMNA, 'BMMST': GETBMMST,'BMMST2': GETBMMST,'BMMCN':GETBMMCN,
    'BCCID':GETBCCID,'ABID':GETABID
    ,'BMMNR':GETBMMNR,'BMMEQ':GETBMMEQ,'BMMDIF':GETBMMDIF,'BMMDN':GETBMMDN,'BMMDI':GETBMMDI,'BMMDIR':GETBMMDIR,
    'BMMCD':GETBMMCD,'BMMBR':GETBMMBR,'BMMDD':GETBMMDD, 'BMMDOR':GetBMMDOR,'BMMRD':GetBMMDOR,'BMMMT':GETBMMMT
    ,'BIID3':GETBIID3,'AMMID':GETAMMID,'SCIDP':GETSCIDP,'SCEXP':GETSCEXP,'BMMAMP':GETBMMAMP,'BMMCP':GETBMMCP
    ,'BMMTC':GETBMMTC,'BCDID':GETBCDID,'BCDMO':GETBCDMO,'GUIDC2':GETGUIDC2,'BMMGR':GETBMMGR,
    'TTLID':TTLID,'TCRA':TCRA,'TCSDID':TCSDID,'TCSDSY':TCSDSY,'TCID':TCID,'TCSY':TCSY,
    'BMMAM_TX':BMMAM_TX,'BMMDI_TX':BMMDI_TX,'TCAM':TCAM,'BMMCRT':BMMCRT,'BMMTN':BMMTN,
    'BMMDR':BMMDR};

  final result = await dbClient!.update(TAB_N, data, where: 'BMMID=$GetBMMID  AND BMKID=$GetBMKID');
  return result;
}

Future<int> UpdateBIL_MOV_M_SUM(String TAB_N,int GetBMKID,int GetBMMID,double GetBMMAM,double GETBMMTX,int GETBMMNR,
    String GETBMMEQ,double GETBMMDIF, double GETBMMDI, double GETBMMDIR,double GETBMMMT,
    GETBMMTX1, GETBMMTX2, GETBMMTX3,BMMAM_TX, BMMDI_TX,TCAM) async {
  var dbClient = await conn.database;
  final data={'BMMAM':GetBMMAM,'BMMEQ':GETBMMEQ,'BMMTX':GETBMMTX,'BMMNR':GETBMMNR,
    'BMMDIF':GETBMMDIF,'BMMDI':GETBMMDI,'BMMDIR':GETBMMDIR,'BMMMT':GETBMMMT,'BMMAM_TX':BMMAM_TX,
    'BMMDI_TX':BMMDI_TX,'TCAM':TCAM,'BMMTX11':GETBMMTX1,'BMMTX22':GETBMMTX2,'BMMTX33':GETBMMTX3};
  final result = await dbClient!.update(TAB_N, data, where: 'BMMID=$GetBMMID  AND BMKID=$GetBMKID');
  return result;
}

Future<List<Bil_Mov_D_Local>> GET_COUNT_MINO(String TAB_N,int GetBMMID,String GetMGNO,String GetMINO) async {
  var dbClient = await conn.database;
  String sql;
  sql = "SELECT ifnull(COUNT(*),0) AS COUNT_MINO  FROM $TAB_N WHERE  BMMID=$GetBMMID AND MGNO='$GetMGNO' AND MINO='$GetMINO' AND SYST!=1 ";
  var result = await dbClient!.rawQuery(sql);
  List<Bil_Mov_D_Local> list = result.map((item) {
    return Bil_Mov_D_Local.fromMap(item);
  }).toList();
  return list;
}

Future<List<Bil_Dis_Local>> GET_BIL_DIS(String GETBIID) async {
  var dbClient = await conn.database;
  String sql;
  String Wheresql='';
  String Wheresql2='';
  LoginController().BIID_ALL_V=='1'? Wheresql= " AND  A.BIID_L=${LoginController().BIID}":Wheresql='';
  LoginController().BIID_ALL_V=='1'? Wheresql2= " AND  B.BIID_L=${LoginController().BIID}":Wheresql2='';

  sql = "SELECT * FROM BIL_DIS A WHERE A.BDST!=2 AND  (A.BIID IS NULL OR A.BIID==$GETBIID) AND A.JTID_L=${LoginController().JTID} "
      " AND A.SYID_L=${LoginController().SYID} AND A.CIID_L='${LoginController().CIID}' $Wheresql "
      " AND EXISTS(SELECT 1 FROM ACC_USR B WHERE B.AANO=A.AANO AND B.AUIN=1 "
      " AND B.SUID IS NOT NULL AND B.SUID=${LoginController().SUID} AND B.JTID_L=${LoginController().JTID} "
      " AND B.SYID_L=${LoginController().SYID} AND B.CIID_L='${LoginController().CIID}' $Wheresql2)"
      " ORDER BY A.BDID ";
  var result = await dbClient!.rawQuery(sql);
  List<Bil_Dis_Local> list = result.map((item) {
    return Bil_Dis_Local.fromMap(item);
  }).toList();
  // print(sql);
  // print(result);
  return list;
}

Future<List<Mat_Inf_D_Local>> GET_MAT_INF_D(String GETMGNO,String GETMINO) async {
  var dbClient = await conn.database;
  String sql='';
  String Wheresql='';

  LoginController().BIID_ALL_V=='1'? Wheresql= " AND A.BIID_L=${LoginController().BIID}":Wheresql='';

  sql = "SELECT *  FROM MAT_INF_D A WHERE A.MGNO='$GETMGNO' AND A.MINO='$GETMINO' AND A.JTID_L=${LoginController().JTID} "
      " AND A.SYID_L=${LoginController().SYID} AND A.CIID_L=${LoginController().CIID} $Wheresql   LIMIT  1";

  var result = await dbClient!.rawQuery(sql);
  List<Mat_Inf_D_Local> list = result.map((item) {
    return Mat_Inf_D_Local.fromMap(item);
  }).toList();
  return list;
}

Future<List<Mat_Uni_B_Local>> Get_BRO(String GetSIID,String Getbarcod) async {
  var dbClient = await conn.database;
  String sql;
  String Wheresql='';
  String Wheresql2='';
  String Wheresql3='';
  LoginController().BIID_ALL_V=='1'? Wheresql= " AND  A.BIID_L=${LoginController().BIID}":Wheresql='';
  LoginController().BIID_ALL_V=='1'? Wheresql2= " AND  C.BIID_L=${LoginController().BIID}":Wheresql2='';
  LoginController().BIID_ALL_V=='1'? Wheresql3= " AND  B.BIID_L=${LoginController().BIID}":Wheresql3='';

  sql =" SELECT A.*,C.MINA,C.MITSK,B.MGKI FROM MAT_UNI_B A,MAT_INF C,MAT_GRO B WHERE  A.MUCBC='$Getbarcod'  "
      " AND B.MGNO=A.MGNO AND (C.MINO=A.MINO AND C.MGNO=A.MGNO) AND EXISTS(SELECT 1 FROM GRO_USR D WHERE D.MGNO=A.MGNO "
      " AND D.SUID=${LoginController().SUID})"
      " AND A.JTID_L=${LoginController().JTID} AND A.SYID_L=${LoginController().SYID} AND "
      " A.CIID_L=${LoginController().CIID} $Wheresql AND "
      " C.JTID_L=${LoginController().JTID} AND C.SYID_L=${LoginController().SYID} AND "
      " C.CIID_L=${LoginController().CIID} $Wheresql2  AND"
      " B.JTID_L=${LoginController().JTID} AND B.SYID_L=${LoginController().SYID} AND "
      " B.CIID_L=${LoginController().CIID} $Wheresql3 "
      " ORDER BY A.MGNO,A.MINO LIMIT 1 ";
  var result = await dbClient!.rawQuery(sql);
  List<Mat_Uni_B_Local> list = result.map((item) {
    return Mat_Uni_B_Local.fromMap(item);
  }).toList();
  return list;
}

Future<int> UpdateSTO_NUM(String  GETSIID,String GETMGNO,String GETMINO,String GETMUID,
    double GetSNNO,String GETGUID) async {
  var dbClient = await conn.database;
  final data = {'SNNO':GetSNNO};
  final result = await dbClient!.update('STO_NUM', data, where: 'SIID=$GETSIID AND '
      'MGNO=$GETMGNO AND MINO=$GETMINO AND MUID=$GETMUID AND GUID=$GETGUID');
  return result;
}

Future<int> UpdateBIL_MOV_D_BMDDI(String  TAB_N,String  GETBMMID,double GETBMMAM,double GETBMDAMTF,double GETBMMDI,double GETBMDDIR,String GETUSE_BMDFN) async {
  var dbClient = await conn.database;
  String SQLUPDATE;
  String SQLUPDATE2;
  String SQLUPDATEBMDDIT;
  String SQLUPDATETX;
  String SQLUPDATETTID2;
  String SQLUPDATETTID3;
  SQLUPDATE = " UPDATE  $TAB_N SET  BMDDI=round(((BMDAMT/($GETBMMAM-$GETBMDAMTF))*$GETBMMDI)/BMDNO,6) ,"
      " BMDDIR=$GETBMDDIR WHERE BMMID=$GETBMMID AND BMDNO>0";
  SQLUPDATE2 = " UPDATE  $TAB_N SET  BMDDI=0 , BMDDIR=$GETBMDDIR WHERE BMMID=$GETBMMID AND BMDNO<0 ";
  SQLUPDATEBMDDIT = "UPDATE  $TAB_N SET  BMDDIT=round((BMDDI+($GETBMDDIR*BMDAM)),6)  WHERE BMMID=$GETBMMID ";

  SQLUPDATETX = " UPDATE  $TAB_N SET  BMDDIM=round((BMDDIT*BMDNO),6) , BMDTXA=round((BMDAM-BMDDIT)*(BMDTX / 100),6),"
      " BMDTXT=round(((BMDAM-BMDDIT) * (BMDTX / 100))*BMDNO,6),"
      " BMDTXA11=round((BMDAM-BMDDIT)*(BMDTX11 / 100),6),"
      " BMDTXT1=round(((BMDAM-BMDDIT) * (BMDTX11 / 100))*BMDNO,6) "
      " WHERE BMMID=$GETBMMID ";

  SQLUPDATETTID2 = "UPDATE  $TAB_N SET  BMDTXA22=round((BMDAM-BMDDIT)*(BMDTX22 / 100),6) ,"
      " BMDTXT2=round(((BMDAM-BMDDIT) * (BMDTX22 / 100))*BMDNO,6)  WHERE BMMID=$GETBMMID AND BMDTX22>0 ";

  SQLUPDATETTID3 = "UPDATE  $TAB_N SET  BMDTXA33=round((BMDAM-BMDDIT)*(BMDTX33 / 100),6) ,"
      " BMDTXT3=round(((BMDAM-BMDDIT) * (BMDTX33 / 100))*BMDNO,6)  WHERE BMMID=$GETBMMID AND BMDTX33>0 ";

  final result = await dbClient!.rawUpdate(SQLUPDATE);
  final result2 = await dbClient.rawUpdate(SQLUPDATE2);
  final result3 = await dbClient.rawUpdate(SQLUPDATEBMDDIT);
  final result4 = await dbClient.rawUpdate(SQLUPDATETX);
  final result5 = await dbClient.rawUpdate(SQLUPDATETTID2);
  final result6 = await dbClient.rawUpdate(SQLUPDATETTID3);
  return result;
}

Future<List<Bil_Mov_D_Local>> GET_COUNT_BMDNO(String TAB_N,int GetBMMID) async {
  var dbClient = await conn.database;
  String sql;
  sql = "select ifnull(sum(BMDNO+BMDNF),0.0) AS COUNT_BMDNO from $TAB_N WHERE  BMMID=$GetBMMID";
  var result = await dbClient!.rawQuery(sql);
  List<Bil_Mov_D_Local> list = result.map((item) {
    return Bil_Mov_D_Local.fromMap(item);
  }).toList();
  return list;
}

Future<List<Bil_Mov_D_Local>> SUM_BMDTXT(String TAB_N,int GetBMMID) async {
  var dbClient = await conn.database;
  String sql;
  sql = "select ifnull(sum(BMDTXT),0.0) AS SUM_BMDTXT,ifnull(sum(BMDTXT1),0.0) AS SUM_BMDTXT1"
      " ,ifnull(sum(BMDTXT2),0.0) AS SUM_BMDTXT2,ifnull(sum(BMDTXT3),0.0) AS SUM_BMDTXT3 from $TAB_N where BMMID=$GetBMMID";
  var result = await dbClient!.rawQuery(sql);
  List<Bil_Mov_D_Local> list = result.map((item) {
    return Bil_Mov_D_Local.fromMap(item);
  }).toList();
  return list;
}

Future<List<Bil_Mov_D_Local>> SUM_AM_TXT_DI(String TAB_N,int GetBMMID) async {
  var dbClient = await conn.database;
  String sql;
  sql = "select ifnull(sum((BMDAMT-BMDDIM)+BMDTXT),0.0) AS SUM_BMDTXA from $TAB_N where BMMID=$GetBMMID";
  var result = await dbClient!.rawQuery(sql);
  List<Bil_Mov_D_Local> list = result.map((item) {
    return Bil_Mov_D_Local.fromMap(item);
  }).toList();
  return list;
}

Future<List<Mat_Uni_C_Local>> GET_MAX_MUCID(String  GETMGNO,String  GETMINO) async {
  var dbClient = await conn.database;
  String sql;
  String Wheresql='';
  LoginController().BIID_ALL_V=='1'? Wheresql= " AND  BIID_L=${LoginController().BIID}":Wheresql='';
  sql = "select ifnull(MAX(MUCID),1) AS MAX_MUCID,MUID from MAT_UNI_C where MGNO='$GETMGNO' AND MINO='$GETMINO'"
      " AND JTID_L=${LoginController().JTID} AND SYID_L=${LoginController().SYID} AND CIID_L=${LoginController().CIID} $Wheresql";
  var result = await dbClient!.rawQuery(sql);
  List<Mat_Uni_C_Local> list = result.map((item) {
    return Mat_Uni_C_Local.fromMap(item);
  }).toList();
  return list;
}

Future<List<Mat_Uni_C_Local>> GET_MIN_MUCID(String  GETMGNO,String  GETMINO) async {
  var dbClient = await conn.database;
  String sql;
  String Wheresql='';
  LoginController().BIID_ALL_V=='1'? Wheresql= " AND  BIID_L=${LoginController().BIID}":Wheresql='';
  sql = "select ifnull(MIN(MUCID),1) AS MIN_MUCID,MUID from MAT_UNI_C where MGNO='$GETMGNO' AND MINO='$GETMINO'"
      " AND JTID_L=${LoginController().JTID} AND SYID_L=${LoginController().SYID} AND CIID_L=${LoginController().CIID} $Wheresql";
  var result = await dbClient!.rawQuery(sql);
  List<Mat_Uni_C_Local> list = result.map((item) {
    return Mat_Uni_C_Local.fromMap(item);
  }).toList();
  return list;
}

Future<List<Mat_Uni_C_Local>> GET_MUID(String  GETMGNO,String  GETMINO,int GETMUCID) async {
  var dbClient = await conn.database;
  String sql;
  String Wheresql='';
  LoginController().BIID_ALL_V=='1'? Wheresql= " AND  BIID_L=${LoginController().BIID}":Wheresql='';
  sql = "select MUID from MAT_UNI_C where MGNO='$GETMGNO' AND MINO='$GETMINO' AND MUCID=$GETMUCID "
      "   AND JTID_L=${LoginController().JTID} AND SYID_L=${LoginController().SYID} AND CIID_L=${LoginController().CIID} $Wheresql LIMIT 1";
  var result = await dbClient!.rawQuery(sql);
  List<Mat_Uni_C_Local> list = result.map((item) {
    return Mat_Uni_C_Local.fromMap(item);
  }).toList();
  return list;
}

Future<List<Mat_Uni_C_Local>> GET_MUCID_F(String  GETMGNO,String  GETMINO,int GETMUID_F) async {
  var dbClient = await conn.database;
  String sql;
  String Wheresql='';
  LoginController().BIID_ALL_V=='1'? Wheresql= " AND  BIID_L=${LoginController().BIID}":Wheresql='';
  sql = "select  ifnull(MUCID,0) AS MUCID_F from MAT_UNI_C where MGNO='$GETMGNO' AND MINO='$GETMINO' AND MUID=$GETMUID_F"
      " AND JTID_L=${LoginController().JTID} AND SYID_L=${LoginController().SYID} AND CIID_L=${LoginController().CIID} $Wheresql";
  var result = await dbClient!.rawQuery(sql);
  List<Mat_Uni_C_Local> list = result.map((item) {
    return Mat_Uni_C_Local.fromMap(item);
  }).toList();
  return list;
}

Future<List<Mat_Uni_C_Local>> GET_MUCID_T(String  GETMGNO,String  GETMINO,int GETMUID_T) async {
  var dbClient = await conn.database;
  String sql;
  String Wheresql='';
  LoginController().BIID_ALL_V=='1'? Wheresql= " AND  BIID_L=${LoginController().BIID}":Wheresql='';
  sql = "select  ifnull(MUCID,0) AS MUCID_T from MAT_UNI_C where MGNO='$GETMGNO' AND MINO='$GETMINO' AND MUID=$GETMUID_T"
      " AND JTID_L=${LoginController().JTID} AND SYID_L=${LoginController().SYID} AND CIID_L=${LoginController().CIID} $Wheresql";
  var result = await dbClient!.rawQuery(sql);
  List<Mat_Uni_C_Local> list = result.map((item) {
    return Mat_Uni_C_Local.fromMap(item);
  }).toList();
  return list;
}

Future<List<Mat_Uni_C_Local>> GET_MUCNO(String  GETMGNO,String  GETMINO,int GETMUCID) async {
  var dbClient = await conn.database;
  String sql;
  String Wheresql='';
  LoginController().BIID_ALL_V=='1'? Wheresql= " AND  BIID_L=${LoginController().BIID}":Wheresql='';
  sql = "select  ifnull(MUCNO,0.0) AS MUCNO from MAT_UNI_C where MGNO='$GETMGNO' AND MINO='$GETMINO' AND MUCID=$GETMUCID"
      " AND JTID_L=${LoginController().JTID} AND SYID_L=${LoginController().SYID} AND CIID_L=${LoginController().CIID} $Wheresql";
  var result = await dbClient!.rawQuery(sql);
  List<Mat_Uni_C_Local> list = result.map((item) {
    return Mat_Uni_C_Local.fromMap(item);
  }).toList();
  return list;
}

Future<int> UpdateSNNO(int BMKID,String  GETSIID,String GETMGNO,String GETMINO,String GETMUID,
    String SNED,double GetSNNO) async {
  var dbClient = await conn.database;
  String SQLUPDATE;
  String SQLBMKID='';
  String SQLBMDED='';
  SNED.toString()!='null' && SNED.isNotEmpty?SQLBMDED=" AND SNED='$SNED' ":SQLBMDED='';
  BMKID==1?SQLBMKID=' SNNO=SNNO+$GetSNNO ':SQLBMKID=' SNNO=SNNO-$GetSNNO ';
  SQLUPDATE = " UPDATE  STO_NUM SET   $SQLBMKID "
      " WHERE SIID=$GETSIID AND MGNO='$GETMGNO' AND MINO='$GETMINO' AND MUID=$GETMUID $SQLBMDED";
  final result = await dbClient!.rawUpdate(SQLUPDATE);
  return result;
}

Future<List<List_Value>> GET_LIST_VALUE(String GETLVTY) async {
  var dbClient = await conn.database;
  String sql;
  sql = "select  *,CASE WHEN ${LoginController().LAN}=2 AND LVNE IS NOT NULL THEN LVNE ELSE LVNA END  LVNA_D  "
      " from LIST_VALUE where LVTY='$GETLVTY'";
  var result = await dbClient!.rawQuery(sql);
  List<List_Value> list = result.map((item) {
    return List_Value.fromMap(item);
  }).toList();
  return list;
}

Future<List<Mat_Uni_Local>> GET_MUNA(String IntMUID) async {
  var dbClient = await conn.database;
  String sql;
  String Wheresql='';
  LoginController().BIID_ALL_V=='1'? Wheresql= " AND A.BIID_L=${LoginController().BIID}":Wheresql='';

  sql = "SELECT CASE WHEN ${LoginController().LAN}=2 AND A.MUNE IS NOT NULL THEN A.MUNE ELSE A.MUNA END  MUNA_D"
      "  FROM  MAT_UNI A WHERE  A.MUID=$IntMUID AND A.JTID_L=${LoginController().JTID} "
      " AND A.SYID_L=${LoginController().SYID} AND A.CIID_L=${LoginController().CIID} $Wheresql";
  var result = await dbClient!.rawQuery(sql);
  List<Mat_Uni_Local> list = result.map((item) {
    return Mat_Uni_Local.fromMap(item);
  }).toList();
  return list;
}

Future<List<Bil_Poi_Local>> GET_BIL_POI(String GETBIID) async {
  var dbClient = await conn.database;
  String sql;
  String Wheresql='';
  String Wheresql2='';
  LoginController().BIID_ALL_V=='1'? Wheresql= " AND  A.BIID_L=${LoginController().BIID}":Wheresql='';
  LoginController().BIID_ALL_V=='1'? Wheresql2= " AND  B.BIID_L=${LoginController().BIID}":Wheresql2='';

  sql = "SELECT *,CASE WHEN ${LoginController().LAN}=2 AND A.BPNE IS NOT NULL THEN A.BPNE ELSE A.BPNA END  BPNA_D"
      " FROM BIL_POI A WHERE A.BIID=$GETBIID AND A.BPST=1"
      " AND EXISTS(SELECT 1 FROM BIL_POI_U B WHERE  B.BPID=A.BPID AND B.BPUST=1 AND  B.BPUTY IN(1,3)  AND  B.BPUUS='${LoginController().SUID}' "
      " AND B.JTID_L=${LoginController().JTID} AND B.SYID_L=${LoginController().SYID} AND "
      " B.CIID_L='${LoginController().CIID}' $Wheresql2) "
      " AND A.JTID_L=${LoginController().JTID} "
      " AND A.SYID_L=${LoginController().SYID} AND A.CIID_L='${LoginController().CIID}' $Wheresql"
      " ORDER BY A.BPID ";
  var result = await dbClient!.rawQuery(sql);
  List<Bil_Poi_Local> list = result.map((item) {
    return Bil_Poi_Local.fromMap(item);
  }).toList();
  return list;
}

Future<List<Bil_Poi_Local>> GET_BIL_POI_ONE(String GETBIID) async {
  var dbClient = await conn.database;
  String sql;
  String Wheresql='';
  String Wheresql2='';
  LoginController().BIID_ALL_V=='1'? Wheresql= " AND  A.BIID_L=${LoginController().BIID}":Wheresql='';
  LoginController().BIID_ALL_V=='1'? Wheresql2= " AND  B.BIID_L=${LoginController().BIID}":Wheresql2='';

  sql = "SELECT *,CASE WHEN ${LoginController().LAN}=2 AND A.BPNE IS NOT NULL THEN A.BPNE ELSE A.BPNA END  BPNA_D"
      " FROM BIL_POI A WHERE A.BIID=$GETBIID AND A.BPST=1"
      " AND EXISTS(SELECT 1 FROM BIL_POI_U B WHERE  B.BPID=A.BPID AND B.BPUST=1 AND  B.BPUTY IN(1,3)  AND  B.BPUUS='${LoginController().SUID}' "
      " AND B.JTID_L=${LoginController().JTID} AND B.SYID_L=${LoginController().SYID} AND "
      " B.CIID_L='${LoginController().CIID}' $Wheresql2) "
      " AND A.JTID_L=${LoginController().JTID} "
      " AND A.SYID_L=${LoginController().SYID} AND A.CIID_L='${LoginController().CIID}' $Wheresql"
      " ORDER BY A.BPID LIMIT 1 ";

  var result = await dbClient!.rawQuery(sql);
  List<Bil_Poi_Local> list = result.map((item) {
    return Bil_Poi_Local.fromMap(item);
  }).toList();
  return list;
}

Future<List<Sys_Cur_Local>> GET_SYS_CUR_ONE_SALE() async {
  var dbClient = await conn.database;
  String sql;
  String Wheresql='';
  LoginController().BIID_ALL_V=='1'? Wheresql= " AND  A.BIID_L=${LoginController().BIID}":Wheresql='';

  sql = "SELECT *,CASE WHEN ${LoginController().LAN}=2 AND A.SCNE IS NOT NULL THEN A.SCNE ELSE A.SCNA END  SCNA_D"
      " FROM SYS_CUR A WHERE A.SCST NOT IN(2,4) AND A.JTID_L=${LoginController().JTID} "
      " AND A.SYID_L=${LoginController().SYID} AND A.CIID_L='${LoginController().CIID}' $Wheresql"
      " ORDER BY A.SCID LIMIT 1";
  var result = await dbClient!.rawQuery(sql);
  List<Sys_Cur_Local> list = result.map((item) {
    return Sys_Cur_Local.fromMap(item);
  }).toList();
  return list;
}

Future<List<Sto_Inf_Local>> GET_STO_INF_ONE(int GETBMKID,String StringBIID,String StringBPID) async {
  var dbClient = await conn.database;
  String sql;
  String sql2='';
  String Wheresql='';
  String Wheresql2='';
  String Wheresql3='';
  if(GETBMKID==11 || GETBMKID==12){
    sql2=" AND EXISTS(SELECT 1 FROM BIL_POI_U D WHERE D.SIID=A.SIID AND D.BPID=$StringBPID "
        " AND D.JTID_L=${LoginController().JTID} AND D.SYID_L=${LoginController().SYID} "
        " AND D.CIID_L=${LoginController().CIID} $Wheresql3) ";
  }else{
    sql2='';
  }

  LoginController().BIID_ALL_V=='1'? Wheresql= " AND A.BIID_L=${LoginController().BIID}":Wheresql='';
  LoginController().BIID_ALL_V=='1'? Wheresql2= " AND B.BIID_L=${LoginController().BIID}":Wheresql2='';
  LoginController().BIID_ALL_V=='1'? Wheresql3= " AND D.BIID_L=${LoginController().BIID}":Wheresql3='';
  sql = "SELECT A.SIID,CASE WHEN ${LoginController().LAN}=2 AND A.SINE IS NOT NULL THEN A.SINE ELSE A.SINA END  SINA_D"
      " FROM STO_INF A where A.SIST NOT IN(2,3) AND  (A.BIID IS NULL OR  A.BIID=$StringBIID)   "
      " AND A.JTID_L=${LoginController().JTID} AND A.SYID_L=${LoginController().SYID} "
      " AND A.CIID_L=${LoginController().CIID} $Wheresql AND"
      " EXISTS(SELECT 1 FROM STO_USR B WHERE  B.SIID=A.SIID AND B.SUOU=1 AND B.SUID IS NOT NULL AND SUID=${LoginController().SUID}"
      " AND B.JTID_L=${LoginController().JTID} AND B.SYID_L=${LoginController().SYID} "
      " AND B.CIID_L=${LoginController().CIID} $Wheresql2) $sql2 ORDER BY A.SIID LIMIT 1";
  var result = await dbClient!.rawQuery(sql);
  List<Sto_Inf_Local> list = result.map((item) {
    return Sto_Inf_Local.fromMap(item);
  }).toList();
  return list;
}

Future<List<Cou_Wrd_Local>> GET_COU_WRD_SAL(String GETCWID) async {
  var dbClient = await conn.database;
  String sql;
  String Wheresql='';
  LoginController().BIID_ALL_V=='1'? Wheresql= " AND  A.BIID_L=${LoginController().BIID}":Wheresql='';
  sql = "SELECT *,CASE WHEN ${LoginController().LAN}=2 AND CWNE IS NOT NULL THEN CWNE ELSE CWNA END  CWNA_D"
      " FROM COU_WRD A WHERE A.CWID='$GETCWID'  AND A.JTID_L=${LoginController().JTID} "
      " AND A.SYID_L=${LoginController().SYID} AND A.CIID_L='${LoginController().CIID}' $Wheresql"
      " ORDER BY A.CWID";
  var result = await dbClient!.rawQuery(sql);
  List<Cou_Wrd_Local> list = result.map((item) {
    return Cou_Wrd_Local.fromMap(item);
  }).toList();
  return list;
}

Future<List<Cou_Tow_Local>> GET_COU_TOW_SAL(String GETCWID,String GETCTID) async {
  var dbClient = await conn.database;
  String sql;
  String Wheresql='';
  LoginController().BIID_ALL_V=='1'? Wheresql= " AND  A.BIID_L=${LoginController().BIID}":Wheresql='';
  sql = "SELECT *,CASE WHEN ${LoginController().LAN}=2 AND CTNE IS NOT NULL THEN CTNE ELSE CTNA END  CTNA_D"
      " FROM COU_TOW A WHERE  A.CWID='$GETCWID' AND  A.CTID='$GETCTID' AND A.JTID_L=${LoginController().JTID} "
      " AND A.SYID_L=${LoginController().SYID} AND A.CIID_L='${LoginController().CIID}' $Wheresql"
      " ORDER BY A.CTID";
  var result = await dbClient!.rawQuery(sql);
  List<Cou_Tow_Local> list = result.map((item) {
    return Cou_Tow_Local.fromMap(item);
  }).toList();
  return list;
}

Future<List<Sys_Cur_Local>> GET_SYS_CUR_DATI(String GETSCID) async {
  var dbClient = await conn.database;
  String sql;
  String Wheresql='';
  LoginController().BIID_ALL_V=='1'? Wheresql= " AND  A.BIID_L=${LoginController().BIID}":Wheresql='';

  sql = "SELECT * FROM SYS_CUR A WHERE SCID=$GETSCID AND A.JTID_L=${LoginController().JTID} "
      " AND A.SYID_L=${LoginController().SYID} AND A.CIID_L='${LoginController().CIID}' $Wheresql"
      " ORDER BY A.SCID LIMIT 1";
  var result = await dbClient!.rawQuery(sql);
  List<Sys_Cur_Local> list = result.map((item) {
    return Sys_Cur_Local.fromMap(item);
  }).toList();
  return list;
}

Future<List<Bal_Acc_M_Local>> GET_BAL_ACC_M(String GETAANO,String GETSCID) async {
  var dbClient = await conn.database;
  String sql;
  String Wheresql='';
  LoginController().BIID_ALL_V=='1'? Wheresql= " AND  A.BIID_L=${LoginController().BIID}":Wheresql='';

  sql = "SELECT A.BACBA FROM BAL_ACC_M A WHERE A.AANO='$GETAANO' AND A.SCID=$GETSCID  "
      " AND A.JTID_L=${LoginController().JTID} AND A.SYID_L=${LoginController().SYID} "
      " AND A.CIID_L='${LoginController().CIID}' $Wheresql LIMIT 1";
  var result = await dbClient!.rawQuery(sql);

  List<Bal_Acc_M_Local> list = result.map((item) {
    return Bal_Acc_M_Local.fromMap(item);
  }).toList();
  return list;
}

Future<List<Sys_Cur_Bet_Local>> GET_SYS_CUR_BET(String GETSCIDF,String GETSCIDT) async {
  var dbClient = await conn.database;
  String sql;
  String Wheresql='';
  LoginController().BIID_ALL_V=='1'? Wheresql= " AND  A.BIID_L=${LoginController().BIID}":Wheresql='';

  sql = "SELECT * FROM SYS_CUR_BET A WHERE A.SCIDF=$GETSCIDF AND A.SCIDT=$GETSCIDT "
      " AND A.JTID_L=${LoginController().JTID} AND A.SYID_L=${LoginController().SYID} "
      " AND A.CIID_L='${LoginController().CIID}' $Wheresql LIMIT 1 ";
  var result = await dbClient!.rawQuery(sql);
  List<Sys_Cur_Bet_Local> list = result.map((item) {
    return Sys_Cur_Bet_Local.fromMap(item);
  }).toList();
  return list;
}

Future<List<Tax_Typ_Local>> GET_TAX_TYP(String GETSTID) async {
  var dbClient = await conn.database;
  String sql;
  String Wheresql='';
  String Wheresql2='';
  LoginController().BIID_ALL_V=='1'? Wheresql= " AND  A.BIID_L=${LoginController().BIID}":Wheresql='';
  LoginController().BIID_ALL_V=='1'? Wheresql2= " AND  B.BIID_L=${LoginController().BIID}":Wheresql2='';

  sql = "SELECT A.TTID,A.TTIDC,B.TSCT,B.TSRA,B.TSPT,B.TSDI,B.TSFR,B.TSQR FROM TAX_TYP A,TAX_SYS B WHERE A.TTID=B.TTID AND A.TTST=1 AND B.TSST=1 "
      " AND B.STID='$GETSTID' AND B.TSCT!=2 AND A.JTID_L=${LoginController().JTID} AND A.SYID_L=${LoginController().SYID} "
      " AND A.CIID_L='${LoginController().CIID}' $Wheresql AND B.JTID_L=${LoginController().JTID} "
      " AND B.SYID_L=${LoginController().SYID} "
      " AND B.CIID_L='${LoginController().CIID}' $Wheresql2  ORDER BY A.TTID";
  var result = await dbClient!.rawQuery(sql);
  List<Tax_Typ_Local> list = result.map((item) {
    return Tax_Typ_Local.fromMap(item);
  }).toList();
  return list;
}

Future<List<Tax_Typ_Bra_Local>> GET_TAX_TYP_BRA(String GETBIID,String GETTTID) async {
  var dbClient = await conn.database;
  String sql;
  String Wheresql='';
  LoginController().BIID_ALL_V=='1'? Wheresql= " AND  A.BIID_L=${LoginController().BIID}":Wheresql='';

  sql = "SELECT A.TTBTN FROM TAX_TYP_BRA A WHERE A.TTID=$GETTTID AND  A.BIID=$GETBIID  AND  A.TTBST=1 AND  A.JTID_L=${LoginController().JTID} AND A.SYID_L=${LoginController().SYID} "
      " AND A.CIID_L='${LoginController().CIID}' $Wheresql  ORDER BY A.TTID";
  var result = await dbClient!.rawQuery(sql);
  List<Tax_Typ_Bra_Local> list = result.map((item) {
    return Tax_Typ_Bra_Local.fromMap(item);
  }).toList();
  return list;
}

Future<List<Tax_Sys_Local>> GET_TAX_SYS(String GETTTID,String GETSTID) async {
  var dbClient = await conn.database;
  String sql;
  String Wheresql='';
  LoginController().BIID_ALL_V=='1'? Wheresql= " AND  A.BIID_L=${LoginController().BIID}":Wheresql='';

  sql = "SELECT A.TSCT,A.TSRA,A.TSPT FROM TAX_SYS A WHERE A.TTID=$GETTTID AND A.STID='$GETSTID' AND A.TSST=1 AND  A.JTID_L=${LoginController().JTID} AND A.SYID_L=${LoginController().SYID} "
      " AND A.CIID_L='${LoginController().CIID}' $Wheresql ";
  var result = await dbClient!.rawQuery(sql);
  List<Tax_Sys_Local> list = result.map((item) {
    return Tax_Sys_Local.fromMap(item);
  }).toList();
  return list;
}

Future<List<Tax_Lin_Local>> GET_TAX_LIN(int GETBMKID,String GETTTID,String GETTLTY,String GETTLNO,String GETTLNO2) async {
  var dbClient = await conn.database;
  String sql;
  String sql2='';
  String Wheresql='';
  String Wheresql2='';
  String Wheresql3='';

  LoginController().BIID_ALL_V=='1'? Wheresql= " AND  A.BIID_L=${LoginController().BIID}":Wheresql='';
  LoginController().BIID_ALL_V=='1'? Wheresql2= " AND  B.BIID_L=${LoginController().BIID}":Wheresql2='';
  LoginController().BIID_ALL_V=='1'? Wheresql3= " AND  C.BIID_L=${LoginController().BIID}":Wheresql3='';
  if(GETBMKID==1 || GETBMKID==2){
    sql2=' A.TCIDI=B.TCID AND ';
  }else{
    sql2=' A.TCIDO=B.TCID AND ';
  }
  sql = " SELECT A.TLTY,A.TLNO,A.TLNO2,A.TLNO3,A.TTID,A.TCIDI,A.TCSDIDI,A.TLRAI,A.TCIDO,A.TCSDIDO,A.TLRAO,"
      " B.TCVL,B.TCSY,A.TLTN,B.TCID FROM TAX_LIN A,TAX_COD B "
      "  WHERE $sql2 A.TTID=$GETTTID AND B.TTID=A.TTID AND A.TLTY='$GETTLTY' AND A.TLNO='$GETTLNO' AND A.TLNO2='$GETTLNO2'"
      " AND A.TLST=1  AND A.JTID_L=${LoginController().JTID} AND A.SYID_L=${LoginController().SYID} "
      " AND A.CIID_L='${LoginController().CIID}' $Wheresql"
      " AND B.JTID_L=${LoginController().JTID} AND B.SYID_L=${LoginController().SYID} "
      " AND B.CIID_L='${LoginController().CIID}' $Wheresql2 "
      "  ORDER BY A.TTID LIMIT 1 ";
  var result = await dbClient!.rawQuery(sql);
  List<Tax_Lin_Local> list = result.map((item) {
    return Tax_Lin_Local.fromMap(item);
  }).toList();
  // print(sql);
  return list;
}

Future<List<Tax_Lin_Local>> GET_TAX_LIN_CUS(String GETTTID,String GETTCSDID) async {
  var dbClient = await conn.database;
  String sql;
  String Wheresql='';
  String Wheresql2='';
  LoginController().BIID_ALL_V=='1'? Wheresql= " AND  B.BIID_L=${LoginController().BIID}":Wheresql='';
  LoginController().BIID_ALL_V=='1'? Wheresql2= " AND  C.BIID_L=${LoginController().BIID}":Wheresql2='';

  sql = " SELECT ifnull(B.TCSVL,1) AS TCSVL FROM TAX_COD_SYS B,TAX_COD_SYS_D C"
      " WHERE B.TTSID=C.TTSID AND B.TCSID=C.TCSID AND B.TTSID=$GETTTID AND C.TCSDID=$GETTCSDID "
      " AND B.JTID_L=${LoginController().JTID} AND B.SYID_L=${LoginController().SYID} "
      " AND B.CIID_L='${LoginController().CIID}' $Wheresql"
      " AND C.JTID_L=${LoginController().JTID} AND C.SYID_L=${LoginController().SYID} "
      " AND C.CIID_L='${LoginController().CIID}' $Wheresql2 ORDER BY B.TTSID LIMIT 1";
  var result = await dbClient!.rawQuery(sql);
  List<Tax_Lin_Local> list = result.map((item) {
    return Tax_Lin_Local.fromMap(item);
  }).toList();
  return list;
}

Future<List<Mat_Gro_Local>> GET_MAT_GRO_ORD(String GETTYPE,int TYPE) async {
  var dbClient = await conn.database;
  String sql;
  String sql2='';
  String Wheresql='';
  String Wheresql2='';
  String Wheresql3='';
  String Wheresql4='';
  String Wheresql5='';
  String all='ALL';
  String AllArbic='الكل';

  LoginController().BIID_ALL_V=='1'? Wheresql= " AND A.BIID_L=${LoginController().BIID}":Wheresql='';
  LoginController().BIID_ALL_V=='1'? Wheresql2= " AND A.BIID_L=B.BIID_L ":Wheresql2='';
  LoginController().BIID_ALL_V=='1'? Wheresql3= " AND  UC.BIID_L=A.BIID_L ":Wheresql3='';
  LoginController().BIID_ALL_V=='1'? Wheresql4= " AND A.BIID_L=D.BIID_L ":Wheresql4='';
  LoginController().BIID_ALL_V=='1'? Wheresql5= " AND UI.BIID_L=A.BIID_L ":Wheresql5='';

  sql=" SELECT S.MGNO,S.MGNA_D,S.STMID,S.ORDNU "
      " FROM (SELECT '0' AS MGNO,CASE WHEN ${LoginController().LAN}=2  THEN 'All' ELSE 'الكل' END AS MGNA_D,NULL AS STMID,0 AS "
      " ORDNU UNION ALL "
      " SELECT A.MGNO AS MGNO,CASE WHEN ${LoginController().LAN}=2 AND A.MGNE IS NOT NULL THEN A.MGNE ELSE A.MGNA END  MGNA_D, "
      " ifnull(B.BGOR,ifnull(A.ORDNU,1)) AS ORDNU,A.STMID AS STMID FROM MAT_GRO A,BIF_GRO B  "
      " WHERE A.MGST  IN(1,4) AND A.MGTY=2 AND ( A.JTID_L=${LoginController().JTID} "
      " AND A.SYID_L=${LoginController().SYID} AND A.CIID_L=${LoginController().CIID} $Wheresql ) "
      " AND (A.MGNO=B.MGNO AND A.CIID_L=B.CIID_L AND A.JTID_L=B.JTID_L  AND A.SYID_L=B.SYID_L $Wheresql2) "
      " AND  EXISTS (SELECT 1 FROM MAT_INF UI WHERE (UI.MGNO=A.MGNO AND UI.MGNO=A.MGNO AND  UI.CIID_L=A.CIID_L AND UI.JTID_L=A.JTID_L "
      " AND UI.SYID_L=A.SYID_L $Wheresql5) AND UI.MIST IN(1,4)) "
      " AND  EXISTS (SELECT 1 FROM MAT_UNI_C UC WHERE (UC.MUCBC IS NOT NULL AND  UC.CIID_L=A.CIID_L AND UC.JTID_L=A.JTID_L "
      " AND UC.SYID_L=A.SYID_L $Wheresql3)) "
      " AND EXISTS(SELECT 1 FROM GRO_USR D WHERE D.MGNO=A.MGNO AND  D.GUOU=1 AND D.SUID='${LoginController().SUID}' "
      " AND D.JTID_L=A.JTID_L AND D.SYID_L=A.SYID_L AND D.CIID_L=A.CIID_L $Wheresql4) )S "
      " ORDER BY S.ORDNU ";

  sql2=" SELECT S.MGNO,S.MGNA_D,S.STMID,S.ORDNU "
      " FROM (SELECT '0' AS MGNO,CASE WHEN ${LoginController().LAN}=2  THEN 'All' ELSE 'الكل' END AS MGNA_D,NULL AS STMID,0 AS "
      " ORDNU   UNION ALL "
      " SELECT A.MGNO AS MGNO,CASE WHEN ${LoginController().LAN}=2 AND A.MGNE IS NOT NULL "
      " THEN A.MGNE ELSE A.MGNA END  MGNA_D, "
      " A.STMID AS STMID,A.ORDNU AS ORDNU FROM MAT_GRO A  "
      " WHERE A.MGST  IN(1,4) AND A.MGTY=2 AND ( A.JTID_L=${LoginController().JTID} "
      " AND A.SYID_L=${LoginController().SYID} AND A.CIID_L=${LoginController().CIID} $Wheresql ) "
      " AND  EXISTS (SELECT 1 FROM MAT_INF UC WHERE (UC.MGNO=A.MGNO AND  UC.CIID_L=A.CIID_L AND UC.JTID_L=A.JTID_L "
      " AND UC.SYID_L=A.SYID_L $Wheresql3) AND UC.MIST IN(1,4)) "
      " AND EXISTS(SELECT 1 FROM GRO_USR D WHERE D.MGNO=A.MGNO AND  D.GUOU=1 AND D.SUID='${LoginController().SUID}' "
      " AND D.JTID_L=A.JTID_L AND D.SYID_L=A.SYID_L AND D.CIID_L=A.CIID_L $Wheresql4) )S "
      " ORDER BY S.ORDNU ";

  final result = await dbClient!.rawQuery(TYPE==2?sql2:sql);

  return result.map((json) => Mat_Gro_Local.fromMap(json)).toList();

}

Future<List<Mat_Inf_Local>> GET_MAT_INF_LIST(String GETMGNO,String GETSCID,String GETBIID,int GETBPPR) async {
  var dbClient = await conn.database;
  String sql='';
  String Wheresql='';
  String Wheresql2='';
  String Wheresql3='';
  String Wheresql4='';
  String Wheresql5='';
  String Wheresql6='';
  String Wheresql7='';
  String sqlMGNO='';
  String sqLBPPR='';

  if(GETMGNO!='0'){
    sqlMGNO=" AND A.MGNO='$GETMGNO'";
  }else{
    sqlMGNO='';
  }

  if(GETBPPR==2){
    sqLBPPR="  B.MPS2>0 AND ";
  }else if(GETBPPR==3){
    sqLBPPR="  B.MPS3>0 AND ";
  }else if(GETBPPR==4){
    sqLBPPR="  B.MPS4>0 AND ";
  }else{
    sqLBPPR='  B.MPS1>0 AND ';
  }


  LoginController().BIID_ALL_V=='1'? Wheresql= " AND A.BIID_L=${LoginController().BIID}":Wheresql='';
  LoginController().BIID_ALL_V=='1'? Wheresql2= " AND D.BIID_L=A.BIID_L ":Wheresql2='';
  LoginController().BIID_ALL_V=='1'? Wheresql3= " AND D.BIID_L=C.BIID_L ":Wheresql3='';
  LoginController().BIID_ALL_V=='1'? Wheresql4= " AND D.BIID_L=E.BIID_L ":Wheresql4='';
  LoginController().BIID_ALL_V=='1'? Wheresql5= " AND D.BIID_L=B.BIID_L ":Wheresql5='';
  LoginController().BIID_ALL_V=='1'? Wheresql6= " AND D.BIID_L=H.BIID_L ":Wheresql6='';
  LoginController().BIID_ALL_V=='1'? Wheresql7= " AND GU.BIID_L=D.BIID_L ":Wheresql7='';

  sql=" SELECT D.MGNO,D.MINO,D.MUCBC,D.MUID,B.MPS1,B.MPS2,B.MPS3,B.MPS4,C.MGKI,"
      " CASE WHEN ${LoginController().LAN}=2 AND A.MINE IS NOT NULL THEN A.MINE ELSE A.MINA END  MINA_D,"
      " CASE WHEN ${LoginController().LAN}=2 AND D.MUCNE IS NOT NULL THEN D.MUCNE ELSE D.MUCNA END  MUCNA_D,"
      " CASE WHEN ${LoginController().LAN}=2 AND E.MUNE IS NOT NULL THEN E.MUNE ELSE E.MUNA END  MUNA_D"
      " FROM MAT_INF A,MAT_PRI B,MAT_GRO C,MAT_UNI_C D,MAT_UNI E,BIF_GRO H WHERE  A.MIST IN(1,4) "
      " AND D.MUCBC IS NOT NULL AND A.JTID_L=${LoginController().JTID} AND A.SYID_L=${LoginController().SYID} "
      " AND A.CIID_L=${LoginController().CIID} $Wheresql "
      " AND (D.MGNO=A.MGNO AND D.MINO=A.MINO AND D.JTID_L=A.JTID_L AND D.CIID_L=A.CIID_L AND D.SYID_L=A.SYID_L $Wheresql2)"
      " AND (D.MGNO=C.MGNO  AND D.JTID_L=C.JTID_L AND D.CIID_L=C.CIID_L AND D.SYID_L=C.SYID_L $Wheresql3) "
      " AND (D.MUID=E.MUID  AND D.JTID_L=E.JTID_L AND D.CIID_L=E.CIID_L AND D.SYID_L=E.SYID_L $Wheresql4) "
      " AND (D.MGNO=B.MGNO AND D.MINO=B.MINO AND D.MUID=B.MUID AND D.JTID_L=B.JTID_L AND D.CIID_L=B.CIID_L "
      " AND D.SYID_L=B.SYID_L $Wheresql5) "
      " AND $sqLBPPR (D.MGNO=H.MGNO  AND D.JTID_L=H.JTID_L AND D.CIID_L=H.CIID_L AND D.SYID_L=H.SYID_L $Wheresql6) "
      " AND B.BIID=$GETBIID AND B.SCID=$GETSCID  AND C.MGST IN(1,4) AND C.MGTY=2  $sqlMGNO "
      " AND EXISTS(SELECT 1 FROM GRO_USR GU WHERE GU.MGNO=C.MGNO AND  GU.GUOU=1 AND GU.SUID='${LoginController().SUID}'"
      " AND GU.JTID_L=D.JTID_L AND GU.CIID_L=D.CIID_L AND GU.SYID_L=D.SYID_L $Wheresql7)"
      " ORDER BY ifnull(H.BGOR,C.ORDNU),ifnull(A.ORDNU,0) ";

  var result = await dbClient!.rawQuery(sql);
  List<Mat_Inf_Local> list = result.map((item) {
    return Mat_Inf_Local.fromMap(item);
  }).toList();
  return list;
}

Future<List<Res_Sec_Local>> GET_RES_SEC(String GETBIID) async {
  var dbClient = await conn.database;
  String sql='';
  String Wheresql='';
  LoginController().BIID_ALL_V=='1'? Wheresql= " AND A.BIID_L=${LoginController().BIID}":Wheresql='';

  sql=" SELECT A.RSID,CASE WHEN ${LoginController().LAN}=2 AND A.RSNE IS NOT NULL THEN A.RSNE ELSE A.RSNA END  RSNA_D"
      " FROM RES_SEC A WHERE  A.RSST!=2 AND A.BIID=$GETBIID AND A.JTID_L=${LoginController().JTID} AND A.SYID_L=${LoginController().SYID} "
      " AND A.CIID_L=${LoginController().CIID} $Wheresql"
      "   ORDER BY A.RSID ";

  var result = await dbClient!.rawQuery(sql);
  // print(sql);
  // print(result);
  // print('GET_RES_SEC');
  List<Res_Sec_Local> list = result.map((item) {
    return Res_Sec_Local.fromMap(item);
  }).toList();
  return list;
}

Future<int> UpdateBIL_MOV_A(int GetBMKID,int GetBMMID,String? GetRSID,String? GetRTID,String? GetREID,
    String GETBMATY,String? GETBDID,String? GETBCDID,String? GETGUIDR ) async {
  var dbClient = await conn.database;
  final data={'RSID':GetRSID,'RTID':GetRTID, 'REID':GetREID,'BMATY':GETBMATY,'BDID':GETBDID,'BCDID':GETBCDID,'GUIDR':GETGUIDR};
  final result = await dbClient!.update('BIF_MOV_A', data, where: 'BMMID=$GetBMMID  AND BMKID=$GetBMKID');
  return result;
}


Future<List<Res_Tab_Local>> GET_RES_TAB(String GETRSID) async {
  var dbClient = await conn.database;
  String sql='';
  String Wheresql='';
  LoginController().BIID_ALL_V=='1'? Wheresql= " AND A.BIID_L=${LoginController().BIID}":Wheresql='';

  sql=" SELECT A.RSID,A.RTID,CASE WHEN ${LoginController().LAN}=2 AND A.RTNE IS NOT NULL THEN A.RTNE ELSE A.RTNA END  RTNA_D"
      " FROM RES_TAB A WHERE  A.RTST!=2 AND A.RSID=$GETRSID AND A.JTID_L=${LoginController().JTID} AND A.SYID_L=${LoginController().SYID} "
      " AND A.CIID_L=${LoginController().CIID} $Wheresql"
      "   ORDER BY A.ORDNU,A.RTID ";

  var result = await dbClient!.rawQuery(sql);
  List<Res_Tab_Local> list = result.map((item) {
    return Res_Tab_Local.fromMap(item);
  }).toList();
  print(sql);
  print(result);
  return list;
}

Future<List<Res_Emp_Local>> GET_RES_EMP(String GETRSID) async {
  var dbClient = await conn.database;
  String sql='';
  String Wheresql='';
  LoginController().BIID_ALL_V=='1'? Wheresql= " AND A.BIID_L=${LoginController().BIID}":Wheresql='';

  sql=" SELECT A.RSID,A.REID,CASE WHEN ${LoginController().LAN}=2 AND A.RENE IS NOT NULL THEN A.RENE ELSE A.RENA END  RENA_D"
      " FROM RES_EMP A WHERE  A.REST!=2 AND A.RSID=$GETRSID AND A.JTID_L=${LoginController().JTID} AND A.SYID_L=${LoginController().SYID} "
      " AND A.CIID_L=${LoginController().CIID} $Wheresql"
      "   ORDER BY A.REID ";

  var result = await dbClient!.rawQuery(sql);
  // print(sql);
  // print(result);
  // print('GET_RES_EMP');
  List<Res_Emp_Local> list = result.map((item) {
    return Res_Emp_Local.fromMap(item);
  }).toList();
  return list;
}

Future<List<Mat_Fol_Local>> GET_MAT_FOL(String GETBIID,String GETMGNO,String GETMINO) async {
  var dbClient = await conn.database;
  String sql;
  String Wheresql='';
  String Wheresql2='';

  LoginController().BIID_ALL_V=='1'? Wheresql= " AND A.BIID_L=${LoginController().BIID}":Wheresql='';
  LoginController().BIID_ALL_V=='1'? Wheresql2= " AND B.BIID_L=${LoginController().BIID}":Wheresql='';

  sql =" SELECT A.*,CASE WHEN ${LoginController().LAN}=2 AND B.MINE IS NOT NULL THEN B.MINE ELSE B.MINA END  MINA_D"
      " FROM  MAT_FOL A,MAT_INF B WHERE A.BIID='$GETBIID' AND A.MGNO='$GETMGNO' AND A.MINO='$GETMINO' AND  A.MFST=1 "
      " AND A.JTID_L=${LoginController().JTID} "
      " AND A.SYID_L=${LoginController().SYID} AND A.CIID_L='${LoginController().CIID}' $Wheresql"
      " AND (A.MGNOF=B.MGNO AND A.MINOF=B.MINO) AND B.JTID_L=${LoginController().JTID} "
      " AND B.SYID_L=${LoginController().SYID} AND B.CIID_L='${LoginController().CIID}' $Wheresql2"
      " ORDER BY A.MGNO,A.MINO";
  final result = await dbClient!.rawQuery(sql);
  return result.map((json) => Mat_Fol_Local.fromMap(json)).toList();
}

Future<List<Mat_Des_M_Local>> GET_MAT_DES_M(String GETMGNO,String GETMINO) async {
  var dbClient = await conn.database;
  String sql;
  String Wheresql='';

  LoginController().BIID_ALL_V=='1'? Wheresql= " AND A.BIID_L=${LoginController().BIID}":Wheresql='';

  sql =" SELECT A.MDMID,A.MDMDE,A.MGNOT,A.MDMST,A.ORDNU "
      ",CASE WHEN ${LoginController().LAN}=2 AND A.MDMNE IS NOT NULL THEN A.MDMNE ELSE A.MDMNA END  MDMNA_D"
      " FROM  MAT_DES_M A WHERE A.MDMST=1 AND ( A.MGNOT='0' OR ("
      " EXISTS ( SELECT 1 FROM MAT_DES_D B WHERE A.MDMID=B.MDMID AND  B.MGNO='$GETMGNO' "
      " AND   B.MINO='$GETMINO' AND B.MDDST=1)))  AND A.JTID_L=${LoginController().JTID} "
      " AND A.SYID_L=${LoginController().SYID} AND A.CIID_L='${LoginController().CIID}' $Wheresql"
      " ORDER BY A.MDMID ";

  final result = await dbClient!.rawQuery(sql);
  // print(sql);
  // print(result);
  // print('GET_MAT_DES_M');
  return result.map((json) => Mat_Des_M_Local.fromMap(json)).toList();
}

Future<List<Bif_Mov_A_Local>> GET_BIF_MOV_A(String GETBMMID) async {
  var dbClient = await conn.database;
  String sql;
  String Wheresql='';

  LoginController().BIID_ALL_V=='1'? Wheresql= " AND A.BIID_L=${LoginController().BIID}":Wheresql='';

  sql =" SELECT * FROM  BIF_MOV_A A WHERE A.BMMID=$GETBMMID   AND A.JTID_L=${LoginController().JTID} "
      " AND A.SYID_L=${LoginController().SYID} AND A.CIID_L='${LoginController().CIID}' $Wheresql"
      " ORDER BY A.BMMID ";

  final result = await dbClient!.rawQuery(sql);
  return result.map((json) => Bif_Mov_A_Local.fromMap(json)).toList();
}

Future<int> UpdateBIF_MOV_D_ORD(String TAB_N,int GetBMKID,int GetBMMID,String GetMGNO,String GetMINO,
    int GETMUID,double GetBMDNF,double GetBMDNO,String GETBMDDE,double GetBMDAM,double GETBMDDI,double GETBMDDIR,
    double GETBMDEQ,double GETBMDTX,double GETBMDTX1,double GETBMDTX2,double GETBMDTX3,double GETBMDTXA1,double GETBMDTXA2
    ,double GETBMDTXA3,double GETBMDTXA, double GETBMDDIF,double GETBMDAMT,double GETBMDAMTF,double GETBMDTXT1,
    double GETBMDTXT2,double GETBMDTXT3,double GETBMDTXT,double GETBMDDIT,double GETBMDDIM,String GETBMDIN) async {
  var dbClient = await conn.database;
  final data = {'MGNO':GetMGNO,'MINO':GetMINO, 'MUID':GETMUID, 'BMDNF':GetBMDNF,'BMDNO':GetBMDNO,'BMDED':GETBMDDE,'BMDAM':GetBMDAM,
    'BMDDI':GETBMDDI,'BMDDIR':GETBMDDIR,'BMDEQ':GETBMDEQ,'BMDTXA11':GETBMDTXA1,'BMDTXA22':GETBMDTXA2,'BMDTXA33':GETBMDTXA3
    ,'BMDTXA':GETBMDTXA,'BMDTX':GETBMDTX,'BMDTX11': GETBMDTX1,'BMDTX22':GETBMDTX2,'BMDTX33':GETBMDTX3,'BMDDIF':GETBMDDIF
    ,'BMDAMT':GETBMDAMT,'BMDAMTF':GETBMDAMTF,'BMDTXT1':GETBMDTXT1,'BMDTXT2':GETBMDTXT2,'BMDTXT3':GETBMDTXT3,
    'BMDTXT':GETBMDTXT,'BMDDIT':GETBMDDIT,'BMDDIM':GETBMDDIM};
  final result = await dbClient!.update('$TAB_N', data, where: "BMMID=$GetBMMID AND "
      " MGNO='$GetMGNO' AND MINO='$GetMINO' AND MUID=$GETMUID ");
  return result;
}

Future<List<Bil_Mov_D_Local>> GET_COUNT_NO(String TAB_V,String GETBMMID,String GetMGNO,String GetMINO, int GETMUID) async {
  var dbClient = await conn.database;
  String sql;
  String Wheresql='';

  LoginController().BIID_ALL_V=='1'? Wheresql= " AND A.BIID_L=${LoginController().BIID}":Wheresql='';

  sql =" SELECT ifnull(COUNT(*),0) AS COUNT_MINO FROM  $TAB_V A WHERE A.BMMID=$GETBMMID  AND "
      " A.MGNO='$GetMGNO' AND A.MINO='$GetMINO' AND A.MUID=$GETMUID AND  A.SYST!=1 AND A.JTID_L=${LoginController().JTID} "
      " AND A.SYID_L=${LoginController().SYID} AND A.CIID_L='${LoginController().CIID}' $Wheresql"
      " ORDER BY A.BMMID ";

  final result = await dbClient!.rawQuery(sql);

  return result.map((json) => Bil_Mov_D_Local.fromMap(json)).toList();
}

Future<List<Bil_Mov_D_Local>> GET_BIL_MOV_D_ORD(String TAB_V,String GETBMMID,String GetMGNO,String GetMINO, int GETMUID) async {
  var dbClient = await conn.database;
  String sql;
  String Wheresql='';
  LoginController().BIID_ALL_V=='1'? Wheresql= " AND A.BIID_L=${LoginController().BIID}":Wheresql='';

  sql =" SELECT * FROM $TAB_V A WHERE  A.BMMID=$GETBMMID AND A.MGNO='$GetMGNO' AND A.MINO='$GetMINO' AND A.MUID=$GETMUID"
      " AND A.SYST!=1 AND BMDTY=1 AND A.JTID_L=${LoginController().JTID} "
      " AND A.SYID_L=${LoginController().SYID} AND A.CIID_L=${LoginController().CIID} $Wheresql";
  var result = await dbClient!.rawQuery(sql);
  List<Bil_Mov_D_Local> list = result.map((item) {
    return Bil_Mov_D_Local.fromMap(item);
  }).toList();
  return list;
}

Future<List<Bif_Cus_D_Local>> GET_BIF_CUS_D() async {
  var dbClient = await conn.database;
  String sql;
  String Wheresql='';
  LoginController().BIID_ALL_V=='1'? Wheresql= " AND A.BIID_L=${LoginController().BIID}":Wheresql='';


  sql =" SELECT *,CASE WHEN ${LoginController().LAN}=2 AND A.BCDNE IS NOT NULL THEN A.BCDNE ELSE A.BCDNA END  BCDNA_D "
      " FROM BIF_CUS_D A WHERE   A.BCDST=1 AND A.JTID_L=${LoginController().JTID} "
      " AND A.SYID_L=${LoginController().SYID} AND A.CIID_L=${LoginController().CIID} $Wheresql ORDER BY A.BCDID";
  var result = await dbClient!.rawQuery(sql);
  List<Bif_Cus_D_Local> list = result.map((item) {
    return Bif_Cus_D_Local.fromMap(item);
  }).toList();
  return list;
}

Future<List<Bif_Cus_D_Local>> GET_BIF_CUS_D_ONE(String GETGUID) async {
  var dbClient = await conn.database;
  String sql;
  String sqlBCDID='';
  String Wheresql='';
  LoginController().BIID_ALL_V=='1'? Wheresql= " AND A.BIID_L=${LoginController().BIID}":Wheresql='';

  sql =" SELECT *,CASE WHEN ${LoginController().LAN}=2 AND A.BCDNE IS NOT NULL THEN A.BCDNE ELSE A.BCDNA END  BCDNA_D "
      " FROM BIF_CUS_D A WHERE  A.GUID='$GETGUID' AND  A.BCDST=1 AND A.JTID_L=${LoginController().JTID} "
      " AND A.SYID_L=${LoginController().SYID} AND A.CIID_L=${LoginController().CIID} $Wheresql ORDER BY A.BCDID";
  var result = await dbClient!.rawQuery(sql);
  List<Bif_Cus_D_Local> list = result.map((item) {
    return Bif_Cus_D_Local.fromMap(item);
  }).toList();
  return list;
}

Future<Bif_Cus_D_Local> Save_BIF_CUS_D(Bif_Cus_D_Local data) async {
  var dbClient = await conn.database;
  data.BCDID = await dbClient!.insert('BIF_CUS_D', data.toMap());
  return data;
}

Future<List<Bif_Cus_D_Local>> GET_BCDID() async {
  var dbClient = await conn.database;
  String sql;
  String Wheresql='';
  LoginController().BIID_ALL_V=='1'? Wheresql= " AND  BIID_L=${LoginController().BIID}":Wheresql='';

  sql = "SELECT ifnull(MAX(BCDID),0)+1 AS BCDID FROM BIF_CUS_D WHERE  JTID_L=${LoginController().JTID} "
      " AND SYID_L=${LoginController().SYID} AND CIID_L='${LoginController().CIID}' $Wheresql";
  var result = await dbClient!.rawQuery(sql);
  List<Bif_Cus_D_Local> list = result.map((item) {
    return Bif_Cus_D_Local.fromMap(item);
  }).toList();
  return list;
}

UpdateBIF_CUS_D(GETBCDID,BCDNA,BCDMO,BCDAD,CWID,CTID,BAID,BCDSN,BCDBN,BCDFN,SYST_L) async {
  var dbClient = await conn.database;
  String Wheresql='';
  LoginController().BIID_ALL_V=='1'? Wheresql= " AND  BIID_L=${LoginController().BIID}":Wheresql='';

  final data = {'BCDNA':BCDNA,'BCDMO':BCDMO,'BCDAD':BCDAD,'CWID':CWID, 'CTID': CTID, 'BAID': BAID,'BCDSN':BCDSN,'BCDBN':BCDBN
    ,'SUCH':LoginController().SUID,'BCDFN':BCDFN,'DATEU':'${DateFormat('dd-MM-yyyy HH:mm:ss').format(DateTime.now())}'};
  final result = await dbClient!.update('BIF_CUS_D', data,where: "JTID_L=${LoginController().JTID} $Wheresql "
      " AND CIID_L='${LoginController().CIID}' AND SYID_L=${LoginController().SYID} AND BCDID=$GETBCDID");
  return result;
}

Future<int> UpdateStateBIF_CUS_D(String TypeSync,GETBCDID) async {
  var dbClient = await conn.database;
  String value='';
  if(TypeSync=='SyncAll'){ value='SYST_L!=1';}
  else if(TypeSync=='SyncOnly'){value='SYST_L!=1 and BCDID=$GETBCDID';
  }

  final data = {'SYST_L':1,'BCDDL_L':1};
  final result = await dbClient!.update('BIF_CUS_D', data, where: value);
  return result;
}

Future<List<Mat_Inf_D_Local>> GET_MAT_INF_D_P() async {
  var dbClient = await conn.database;
  String sql='';
  String Wheresql='';

  LoginController().BIID_ALL_V=='1'? Wheresql= " AND A.BIID_L=${LoginController().BIID}":Wheresql='';

  sql = "SELECT *  FROM MAT_INF_D A WHERE  A.JTID_L=${LoginController().JTID} "
      " AND A.SYID_L=${LoginController().SYID} AND A.CIID_L=${LoginController().CIID} $Wheresql ";
  var result = await dbClient!.rawQuery(sql);
  List<Mat_Inf_D_Local> list = result.map((item) {
    return Mat_Inf_D_Local.fromMap(item);
  }).toList();
  return list;
}

Future<Bif_Eord_M_Local> Save_BIF_EORD_M(Bif_Eord_M_Local data) async {
  var dbClient = await conn.database;
  data.BMMID = await dbClient!.insert('BIF_EORD_M', data.toMap());
  return data;
}

Future<int> UpdateStateBIF_EORD_M(String GETBEMBS,String TypeSync,String GetBMMID,String TypeTable) async {
  var dbClient = await conn.database;
  String SQL='';
  if(TypeSync=='SyncAll'){
    SQL = "UPDATE BIF_EORD_M SET BEMBS=1  WHERE  BMKID=11 ";
  }
  else if(TypeSync=='SyncOnly'){
    SQL = "UPDATE BIF_EORD_M SET BEMBS=1 WHERE BMMID=$GetBMMID";
  }
  var result = await dbClient!.rawUpdate(SQL);
  return result;
}

Future<int> UpdateBMDID(String TAB_N,String GETBMMID,int GETBMDID,String GETGUID) async {
  var dbClient = await conn.database;
  String SQL='';
  SQL = "UPDATE $TAB_N SET BMDID=$GETBMDID  WHERE  BMMID=$GETBMMID AND GUID='$GETGUID' ";
  var result = await dbClient!.rawUpdate(SQL);
  return result;
}

Future<List<Bil_Mov_D_Local>> GET_BMDID_COUNT(String TAB_N,String GETBMMID) async {
  var dbClient = await conn.database;
  String sql='';
  String Wheresql='';

  LoginController().BIID_ALL_V=='1'? Wheresql= " AND A.BIID_L=${LoginController().BIID}":Wheresql='';

  sql = "SELECT A.BMDID,A.BMMID,A.GUID  FROM $TAB_N A WHERE A.BMMID=$GETBMMID AND   A.JTID_L=${LoginController().JTID} "
      " AND A.SYID_L=${LoginController().SYID} AND A.CIID_L=${LoginController().CIID} $Wheresql ORDER BY A.BMMID";
  var result = await dbClient!.rawQuery(sql);
  List<Bil_Mov_D_Local> list = result.map((item) {
    return Bil_Mov_D_Local.fromMap(item);
  }).toList();
  return list;
}

Future<int> UpdateBMDIN(String TAB_N,String GETBMMID,String GETBMDID,String GETBMDIN) async {
  var dbClient = await conn.database;
  String SQL='';
  SQL = "UPDATE $TAB_N SET BMDIN='$GETBMDIN'  WHERE  BMMID=$GETBMMID AND BMDID=$GETBMDID ";
  var result = await dbClient!.rawUpdate(SQL);
  return result;
}

Future<List<Mat_Dis_M_Local>> GET_MAT_DIS_M() async {
  var dbClient = await conn.database;
  String sql='';
  String Wheresql='';
  String Wheresql2='';

  LoginController().BIID_ALL_V=='1'? Wheresql= " AND A.BIID_L=${LoginController().BIID}":Wheresql='';
  LoginController().BIID_ALL_V=='1'? Wheresql2= " AND B.BIID_L=A.BIID_L ":Wheresql2='';

  sql = "SELECT ifnull(COUNT(1),0) AS MDMID  FROM MAT_DIS_M A WHERE A.MDMST=1 AND NOT EXISTS(SELECT 1 FROM MAT_DIS_S B WHERE "
      " B.GUID=A.GUID AND B.JTID_L=A.JTID_L AND B.SYID_L=A.SYID_L AND B.CIID_L=A.CIID_L $Wheresql2) "
      " AND A.JTID_L=${LoginController().JTID} "
      " AND A.SYID_L=${LoginController().SYID} AND A.CIID_L=${LoginController().CIID} $Wheresql ";
  var result = await dbClient!.rawQuery(sql);

  List<Mat_Dis_M_Local> list = result.map((item) {
    return Mat_Dis_M_Local.fromMap(item);
  }).toList();
  return list;
}

Future<List<Mat_Dis_M_Local>> GET_MAT_DIS_M_CHK(String BIID_V,String BIL_V,String SUID_V) async {
  var dbClient = await conn.database;
  String sql='';
  String Wheresql='';
  String Wheresql2='';
  String Wheresql3='';
  String Wheresql4='';

  LoginController().BIID_ALL_V=='1'? Wheresql= " AND A.BIID_L=${LoginController().BIID}":Wheresql='';
  LoginController().BIID_ALL_V=='1'? Wheresql2= " AND B.BIID_L=A.BIID_L ":Wheresql2='';
  LoginController().BIID_ALL_V=='1'? Wheresql3= " AND C.BIID_L=A.BIID_L ":Wheresql3='';
  LoginController().BIID_ALL_V=='1'? Wheresql4= " AND D.BIID_L=A.BIID_L ":Wheresql4='';

  sql = "SELECT ifnull(COUNT(1),0) AS MDMID  FROM MAT_DIS_M A WHERE A.MDMST=1 "
      " AND NOT EXISTS(SELECT 1 FROM MAT_DIS_S B WHERE "
      " B.GUID=A.GUID AND B.JTID_L=A.JTID_L AND B.SYID_L=A.SYID_L AND B.CIID_L=A.CIID_L $Wheresql2)"
      " AND EXISTS(SELECT 1 FROM MAT_DIS_L C WHERE "
      " C.GUIDD=A.GUID AND C.MDMID=A.MDMID  AND C.MDLST=1 AND C.MCKID=1 AND EXISTS "
      " (SELECT 1 FROM MAT_MAI_M D WHERE D.GUID=C.GUIDM AND "
      " D.MMMID=C.MMMID AND D.MMMST=1 AND (D.BIIDT=0 OR D.BIID LIKE '%<$BIID_V>%' )"
      " AND (D.MMMBLT=0 OR D.MMMBL LIKE '%<$BIL_V>%' ) "
      " AND (D.SUIDT=0 OR D.SUIDV LIKE '%<$SUID_V>%' )"
      " AND D.JTID_L=A.JTID_L AND D.SYID_L=A.SYID_L AND D.CIID_L=A.CIID_L $Wheresql4) AND  "
      "  C.JTID_L=A.JTID_L AND C.SYID_L=A.SYID_L AND C.CIID_L=A.CIID_L $Wheresql3) "
      " AND A.JTID_L=${LoginController().JTID} "
      " AND A.SYID_L=${LoginController().SYID} AND A.CIID_L=${LoginController().CIID} $Wheresql ";
  var result = await dbClient!.rawQuery(sql);

  List<Mat_Dis_M_Local> list = result.map((item) {
    return Mat_Dis_M_Local.fromMap(item);
  }).toList();
  return list;
}

Future<List<Mat_Dis_M_Local>> GET_MAT_DIS_M_CHK_INV_ITEM(int MDTID_V,String BIID_V,String BIL_V,String SUID_V) async {
  var dbClient = await conn.database;
  String sql='';
  String Wheresql='';
  String Wheresql2='';
  String Wheresql3='';
  String Wheresql4='';
  String Wheresql5='';
  String Wheresql6='';

  LoginController().BIID_ALL_V=='1'? Wheresql= " AND A.BIID_L=${LoginController().BIID}":Wheresql='';
  LoginController().BIID_ALL_V=='1'? Wheresql2= " AND Z.BIID_L=A.BIID_L ":Wheresql2='';
  LoginController().BIID_ALL_V=='1'? Wheresql3= " AND C.BIID_L=A.BIID_L ":Wheresql3='';
  LoginController().BIID_ALL_V=='1'? Wheresql4= " AND Y.BIID_L=A.BIID_L ":Wheresql4='';
  LoginController().BIID_ALL_V=='1'? Wheresql5= " AND D.BIID_L=A.BIID_L ":Wheresql5='';
  LoginController().BIID_ALL_V=='1'? Wheresql6= " AND B.BIID_L=A.BIID_L ":Wheresql6='';

  sql = "SELECT ifnull(COUNT(1),0) AS MDMID  FROM MAT_DIS_M A WHERE A.MDTID=$MDTID_V "
      "  AND EXISTS(SELECT 1 FROM MAT_DIS_T Z WHERE  "
      " Z.MDTID=A.MDTID AND Z.MDTST=1 AND Z.JTID_L=A.JTID_L AND Z.SYID_L=A.SYID_L AND Z.CIID_L=A.CIID_L $Wheresql2)"
      " AND EXISTS(SELECT 1 FROM MAT_DIS_K Y WHERE "
      " Y.MDKID=A.MDKID AND Y.MDKST=1 AND Y.JTID_L=A.JTID_L AND Y.SYID_L=A.SYID_L AND Y.CIID_L=A.CIID_L $Wheresql4) "
      " AND NOT EXISTS(SELECT 1 FROM MAT_DIS_S B WHERE B.GUID=A.GUID AND B.JTID_L=A.JTID_L AND B.SYID_L=A.SYID_L "
      " AND B.CIID_L=A.CIID_L $Wheresql6 ) AND EXISTS(SELECT 1 FROM MAT_DIS_L C "
      " WHERE C.GUIDD=A.GUID AND C.MDMID=A.MDMID  AND C.MDLST=1 AND C.MCKID=1 AND EXISTS "
      " (SELECT 1 FROM MAT_MAI_M D WHERE D.GUID=C.GUIDM AND D.MMMID=C.MMMID AND D.MMMST=1 AND (D.BIIDT=0 OR D.BIID LIKE "
      " '%<$BIID_V>%') AND  (D.MMMBLT=0 OR D.MMMBL LIKE '%<$BIL_V>%' ) AND (D.SUIDT=0 OR D.SUIDV LIKE '%<$SUID_V>%' ) "
      " AND D.JTID_L=A.JTID_L AND D.SYID_L=A.SYID_L AND D.CIID_L=A.CIID_L $Wheresql5 ) "
      " AND C.JTID_L=A.JTID_L AND C.SYID_L=A.SYID_L AND C.CIID_L=A.CIID_L $Wheresql3) "
      " AND A.JTID_L=${LoginController().JTID} "
      " AND A.SYID_L=${LoginController().SYID} AND A.CIID_L=${LoginController().CIID} $Wheresql ";
  var result = await dbClient!.rawQuery(sql);

  List<Mat_Dis_M_Local> list = result.map((item) {
    return Mat_Dis_M_Local.fromMap(item);
  }).toList();
  return list;
}

Future<List<Mat_Dis_M_Local>> GET_DIS_BIL(String BIID_V,String BIL_V,String PKID_V,String BCCID_V,String SCID_V,String BCID_V,
    String CIID_V,String BCTID_V,String ECID_V,String SIID_V,String ACNO_V,String SUID_V,String DATE_V,String AM_P) async {
  var dbClient = await conn.database;
  String sql='';
  String Wheresql='';
  String Wheresql2='';

  LoginController().BIID_ALL_V=='1'? Wheresql= " AND A.BIID_L=${LoginController().BIID}":Wheresql='';
  LoginController().BIID_ALL_V=='1'? Wheresql2= " AND B.BIID_L=A.BIID_L ":Wheresql2='';

  sql =" SELECT * FROM MAT_DIS_M A WHERE A.MDTID=1 AND NOT EXISTS(SELECT 1 FROM MAT_DIS_S B WHERE  "
      " B.GUID=A.GUID) AND EXISTS(SELECT  1 FROM MAT_DIS_K Y WHERE Y.MDKID=A.MDKID AND Y.MDKST=1) "
      " AND EXISTS(SELECT 1 FROM MAT_DIS_L C  WHERE C.GUIDD=A.GUID AND C.MDMID=A.MDMID  AND C.MDLST=1 AND C.MCKID=1 "
      " AND EXISTS (SELECT 1 FROM MAT_MAI_M D WHERE D.GUID=C.GUIDM AND D.MMMID=C.MMMID AND D.MMMST=1"
      " AND (D.BIIDT=0 OR D.BIID LIKE '%<$BIID_V>%' ) "
      " AND (D.MMMBLT=0 OR D.MMMBL LIKE '%<$BIL_V>%' ) AND (D.PKIDT=0 OR D.PKID LIKE '%<$PKID_V>%' )"
      " AND (D.BCCIDT=0 OR D.BCCID LIKE '%<$BCCID_V>%' ) AND (D.SCIDT=0 OR D.SCID LIKE '%<$SCID_V>%' )"
      " AND (D.BCTIDT=0 OR D.BCTID LIKE '%<$BCTID_V>%' ) AND (D.SIIDT=0 OR D.SIID LIKE '%<$SIID_V>%' )"
      " AND (D.ACNOT=0 OR D.ACNO LIKE '%<$ACNO_V>%' ) AND (D.SUIDT=0 OR D.SUIDV LIKE '%<$SUID_V>%' ) )) "
      " AND (CASE WHEN A.MDMCO IS NULL THEN $AM_P ELSE CASE WHEN A.MDMCO = 0 THEN $AM_P ELSE A.MDMCO END END) <= $AM_P "
      " AND (strftime('%Y-%m-%d', COALESCE(DATE_P, date('now'))) BETWEEN "
      " strftime('%Y-%m-%d', COALESCE(A.MDMFDA, '01') || '-' || COALESCE(A.MDMFM, '01') || '-' || COALESCE(A.MDMFY, YE_V)))"
      " AND strftime('%Y-%m-%d', COALESCE(DATE_P, date('now'))) BETWEEN strftime('%Y-%m-%d', COALESCE(A.MDMTDA, CASE A.MDMTM "
      " WHEN '1' THEN '31' WHEN '2' THEN '28' WHEN '3' THEN '31' WHEN '4' THEN '30' WHEN '5' THEN '31' "
      " WHEN '6' THEN '31' WHEN '7' THEN '30' WHEN '8' THEN '31' WHEN '9' THEN '30' WHEN '10' THEN '31' WHEN '11' "
      " THEN '30' WHEN '12' THEN '31' END) || '-' || COALESCE(A.MDMTM, '12') || '-' || COALESCE(A.MDMTY, YE_V)))"
      " AND (strftime('%H:%M', COALESCE(DATE_P, time('now'))) BETWEEN strftime('%H:%M', NUM_TIM_F('NTT', COALESCE(A.MDMFT, '0')))"
      " AND strftime('%H:%M', NUM_TIM_F('NTT', COALESCE(A.MDMTT, '86340'))))"
      " AND (A.MDMDAYT = 0 OR A.MDMDAY LIKE '%'||DAY_V||'%') AND( ( A.MDKID IN (1,2) AND COALESCE(A.MDMRA,0) > 0) OR"
      " ( A.MDKID IN (3,4) AND EXISTS (SELECT 1 FROM MAT_DIS_F E WHERE (E.MDMID=A.MDMID) AND COALESCE(E.MDFRA,0) > 0"
      " AND ((A.MDMSM=2 AND COALESCE(AM_P,0) BETWEEN COALESCE(E.MDFFN,AM_P) AND COALESCE(E.MDFTN,AM_P) ) OR "
      " (A.MDMSM=3 AND COALESCE(AM_P,0) >= COALESCE(E.MDFFN,0))) AND NOT EXISTS(SELECT 1 FROM MAT_DIS_S F WHERE F.GUID=E.GUID)))"
      " OR  (A.MDKID IN (5,6) AND EXISTS (SELECT 1 FROM MAT_DIS_F G WHERE (G.MDMID=A.MDMID)"
      " AND COALESCE(G.MDFRA,0) > 0 AND COALESCE(AM_P,0) BETWEEN COALESCE(G.MDFFN,COALESCE(AM_P,0))"
      " AND COALESCE(G.MDFTN,COALESCE(AM_P,0)) AND NOT EXISTS(SELECT 1 FROM MAT_DIS_S H WHERE H.GUID=G.GUID)"
      " AND EXISTS(SELECT 1 FROM MAT_UNI_C I WHERE (I.MGNO=G.MGNO AND I.MINO=COALESCE(G.MINO,'0')='0',I.MINO,G.MINO)"
      " AND I.MUID=COALESCE(G.MUID,0) THEN 0,I.MUID,G.MUID)) AND EXISTS (SELECT 1 FROM MAT_INF J WHERE (J.MGNO=I.MGNO "
      " AND J.MINO=I.MINO) AND COALESCE(J.MIDI,1)=1 AND J.MIST NOT IN(2,3))))) ORDER BY A.MDMID DESC";
  //  " AND A.SYID_L=${LoginController().SYID} AND A.CIID_L=${LoginController().CIID} $Wheresql ";
  var result = await dbClient!.rawQuery(sql);
  List<Mat_Dis_M_Local> list = result.map((item) {
    return Mat_Dis_M_Local.fromMap(item);
  }).toList();
  return list;
}

Future<List<Tax_Typ_Local>> GET_TTID() async {
  var dbClient = await conn.database;
  String sql;
  String Wheresql='';
  String Wheresql2='';
  LoginController().BIID_ALL_V=='1'? Wheresql= " AND  A.BIID_L=${LoginController().BIID}":Wheresql='';
  LoginController().BIID_ALL_V=='1'? Wheresql2= " AND  B.BIID_L=A.BIID_L ":Wheresql2='';

  sql = " SELECT ifnull(MIN(A.TTID),0) AS TTID FROM TAX_TYP A WHERE A.TTST=1"
      " AND EXISTS(SELECT 1 FROM TAX_TYP_SYS B WHERE B.TTSID=A.TTSID AND UPPER(B.TTSNS)='VAT' "
      " AND B.JTID_L=A.JTID_L  AND B.SYID_L=A.SYID_L AND B.CIID_L=A.CIID_L  $Wheresql2) "
      " AND A.JTID_L=${LoginController().JTID} AND A.SYID_L=${LoginController().SYID} "
      " AND A.CIID_L='${LoginController().CIID}' $Wheresql";
  var result = await dbClient!.rawQuery(sql);
  List<Tax_Typ_Local> list = result.map((item) {
    return Tax_Typ_Local.fromMap(item);
  }).toList();
  return list;
}

Future<List<Tax_Typ_Local>> GET_USE_VAT(V_TTID) async {
  var dbClient = await conn.database;
  String sql;
  String Wheresql='';
  LoginController().BIID_ALL_V=='1'? Wheresql= " AND  A.BIID_L=${LoginController().BIID}":Wheresql='';

  sql = " SELECT ifnull(1,NULL) AS TTID FROM TAX_TYP A WHERE A.TTID=$V_TTID AND A.TTST=1 "
      " AND A.JTID_L=${LoginController().JTID} AND A.SYID_L=${LoginController().SYID} "
      " AND A.CIID_L='${LoginController().CIID}' $Wheresql ORDER BY A.TTID LIMIT 1";

  var result = await dbClient!.rawQuery(sql);
  List<Tax_Typ_Local> list = result.map((item) {
    return Tax_Typ_Local.fromMap(item);
  }).toList();
  return list;
}

Future<List<Sys_Own_Local>> GET_USE_VAT2() async {
  var dbClient = await conn.database;
  String sql;
  String Wheresql='';
  String Wheresql2='';
  LoginController().BIID_ALL_V=='1'? Wheresql= " AND  A.BIID_L=${LoginController().BIID}":Wheresql='';
  LoginController().BIID_ALL_V=='1'? Wheresql2= " AND  B.BIID_L=A.BIID_L ":Wheresql2='';

  sql = " SELECT ifnull(1,NULL) AS SOID FROM SYS_OWN A WHERE A.SOID=1 AND A.CWID IS NOT NULL AND "
      " EXISTS (SELECT 1 FROM COU_WRD B WHERE B.CWID=A.CWID AND B.CWWC2='SA' AND "
      " B.JTID_L=A.JTID_L  AND B.SYID_L=A.SYID_L "
      " AND B.CIID_L=A.CIID_L $Wheresql2) "
      " AND A.JTID_L=${LoginController().JTID} AND A.SYID_L=${LoginController().SYID} "
      " AND A.CIID_L='${LoginController().CIID}' $Wheresql ";

  var result = await dbClient!.rawQuery(sql);
  List<Sys_Own_Local> list = result.map((item) {
    return Sys_Own_Local.fromMap(item);
  }).toList();
  return list;
}

Future<List<Tax_Var_D_Local>> GET_USE_E_INV(V_TTID) async {
  var dbClient = await conn.database;
  String sql;
  String Wheresql='';
  String Wheresql2='';
  LoginController().BIID_ALL_V=='1'? Wheresql= " AND  A.BIID_L=${LoginController().BIID}":Wheresql='';
  LoginController().BIID_ALL_V=='1'? Wheresql2= " AND  B.BIID_L=A.BIID_L ":Wheresql2='';

  sql = " SELECT ifnull(A.TVDVL,NULL) AS TVDVL  FROM TAX_VAR_D A WHERE A.TTID=$V_TTID AND A.TVID=1 AND A.TVDST=1 "
      " AND A.TVDTY=1 AND IFNULL(A.TVDDA, DATE('now', '-1 day')) <= DATE('now')  "
      " AND EXISTS (SELECT 1 FROM TAX_TYP B WHERE B.TTID=A.TTID AND B.TTST=1 AND "
      " B.JTID_L=A.JTID_L  AND B.SYID_L=A.SYID_L AND B.CIID_L=A.CIID_L $Wheresql2)  "
      " AND A.JTID_L=${LoginController().JTID} AND A.SYID_L=${LoginController().SYID} "
      " AND A.CIID_L='${LoginController().CIID}' $Wheresql  LIMIT 1";

  var result = await dbClient!.rawQuery(sql);
  List<Tax_Var_D_Local> list = result.map((item) {
    return Tax_Var_D_Local.fromMap(item);
  }).toList();
  return list;
}

Future<List<Tax_Var_D_Local>> GET_USE_FAT_P(V_TTID,TVID_V) async {
  var dbClient = await conn.database;
  String sql;
  String Wheresql='';
  LoginController().BIID_ALL_V=='1'? Wheresql= " AND  A.BIID_L=${LoginController().BIID}":Wheresql='';
  sql = " SELECT ifnull(A.TVDVL,NULL) AS TVDVL,ifnull(A.TVDDA,NULL) AS TVDDA FROM TAX_VAR_D A "
      " WHERE A.TTID=$V_TTID AND A.TVID=$TVID_V AND A.TVDST=1 AND A.TVDTY=1 "
      " AND A.JTID_L=${LoginController().JTID} AND A.SYID_L=${LoginController().SYID} "
      " AND A.CIID_L='${LoginController().CIID}' $Wheresql  LIMIT 1";

  var result = await dbClient!.rawQuery(sql);
  // print(sql);
  // print(result);
  List<Tax_Var_D_Local> list = result.map((item) {
    return Tax_Var_D_Local.fromMap(item);
  }).toList();
  return list;
}

Future<List<Tax_Var_D_Local>> GET_USE_FAT_BIID(V_TTID,TVID_V,BIID_V) async {
  var dbClient = await conn.database;
  String sql;
  String Wheresql='';
  LoginController().BIID_ALL_V=='1'? Wheresql= " AND  A.BIID_L=${LoginController().BIID}":Wheresql='';
  sql = " SELECT ifnull('1',NULL) AS TVDVL,ifnull(A.TVDDA,NULL) AS TVDDA FROM TAX_VAR_D A WHERE A.TTID=$V_TTID "
      " AND A.TVID=$TVID_V AND A.TVDST=1 AND A.TVDTY=1 AND INSTR(A.TVDVL,'<'||$BIID_V||'>')>0  "
      " AND A.JTID_L=${LoginController().JTID} AND A.SYID_L=${LoginController().SYID} "
      " AND A.CIID_L='${LoginController().CIID}' $Wheresql  LIMIT 1";

  var result = await dbClient!.rawQuery(sql);
  List<Tax_Var_D_Local> list = result.map((item) {
    return Tax_Var_D_Local.fromMap(item);
  }).toList();
  return list;
}

Future<List<Tax_Typ_Bra_Local>> USE_TAX_TYP_BRA(V_TTID,BIID_V) async {
  var dbClient = await conn.database;
  String sql;
  String Wheresql='';
  LoginController().BIID_ALL_V=='1'? Wheresql= " AND  A.BIID_L=${LoginController().BIID}":Wheresql='';

  sql = " SELECT COUNT(1) FROM (SELECT COUNT(A.TTBTN) FROM TAX_TYP_BRA A"
      " WHERE A.TTID=$V_TTID AND INSTR($BIID_V,''<''||A.BIID||''>'')>0 GROUP BY A.TTBTN"
      "  AND A.JTID_L=${LoginController().JTID} AND A.SYID_L=${LoginController().SYID} "
      " AND A.CIID_L='${LoginController().CIID}' $Wheresql)";

  var result = await dbClient!.rawQuery(sql);

  List<Tax_Typ_Bra_Local> list = result.map((item) {
    return Tax_Typ_Bra_Local.fromMap(item);
  }).toList();
  return list;
}

Future<List<Fat_Csid_Inf_Local>> GET_CSID(BIIDV_V,STMIDV_V,SOMGUV_V,SUIDV_V,BMKIDV_V,FCIBTV_V,AF1_V,AF2_V,
    AF3_V,AF4_V,AF5_V) async {
  var dbClient = await conn.database;
  String sql;
  String Wheresql='';

  LoginController().BIID_ALL_V=='1'? Wheresql= " AND  A.BIID_L=${LoginController().BIID}":Wheresql='';

  sql = " SELECT A.FCIGU FROM FAT_CSID_INF A WHERE A.FCITY='P' AND CIIDL=${LoginController().CIID} "
      " AND JTIDL=${LoginController().JTID} AND BIIDL=${LoginController().BIIDL_N} AND A.FCIST=1 ";


  print('SOMGUV_V');
  print(SOMGUV_V);
  if (BIIDV_V != null) {
    sql+=" AND ( INSTR(A.BIIDV,'$BIIDV_V')>0 ) ";
  }
  if (SOMGUV_V != null) {
    sql+=" AND ( INSTR(A.SOMGUV,'$SOMGUV_V')>0 ) ";
  }
  if (STMIDV_V != null) {
    sql+=" AND ( INSTR(A.STMIDV,'$STMIDV_V')>0 ) ";
  }
  if (SUIDV_V != null) {
    sql+=" AND ( INSTR(A.SUIDV,'$SUIDV_V')>0 ) ";
  }
  if (BMKIDV_V != null) {
    sql+=" AND ( INSTR(A.BMKIDV,'$BMKIDV_V')>0 ) ";
  }
  if (FCIBTV_V != null) {
    sql+=" AND ( INSTR(A.FCIBTV,'$FCIBTV_V')>0 ) ";
  }

  sql+=" AND A.JTID_L=${LoginController().JTID} AND A.SYID_L=${LoginController().SYID} "
      " AND A.CIID_L='${LoginController().CIID}' $Wheresql LIMIT 1 ";

  var result = await dbClient!.rawQuery(sql);

  List<Fat_Csid_Inf_Local> list = result.map((item) {
    return Fat_Csid_Inf_Local.fromMap(item);
  }).toList();
  return list;
}

Future<List<Tax_Tbl_Lnk_Local>> GET_TAX_TBL_LNK(TTLID) async {
  var dbClient = await conn.database;
  String sql;
  String Wheresql='';
  LoginController().BIID_ALL_V=='1'? Wheresql= " AND  A.BIID_L=${LoginController().BIID}":Wheresql='';

  sql = " SELECT * FROM TAX_TBL_LNK A WHERE A.TTLID=$TTLID  "
      " AND A.JTID_L=${LoginController().JTID} AND A.SYID_L=${LoginController().SYID} "
      " AND A.CIID_L='${LoginController().CIID}' $Wheresql LIMIT 1 ";

  var result = await dbClient!.rawQuery(sql);
  List<Tax_Tbl_Lnk_Local> list = result.map((item) {
    return Tax_Tbl_Lnk_Local.fromMap(item);
  }).toList();
  return list;
}

Future<List<Ide_Lin_Local>> GET_IDE_LIN(ILTY,ILNO) async {
  var dbClient = await conn.database;
  String sql;
  String Wheresql='';
  LoginController().BIID_ALL_V=='1'? Wheresql= " AND  A.BIID_L=${LoginController().BIID}":Wheresql='';

  sql = " SELECT A.ILDE,B.ITSY,B.ITNA FROM IDE_LIN A,IDE_TYP B WHERE (A.ITID=B.ITID AND A.CIID_L=B.CIID_L "
      " AND A.JTID_L=B.JTID_L AND  A.BIID_L=B.BIID_L AND A.SYID_L=B.SYID_L) "
      " AND A.ILTY='$ILTY' AND A.ILNO='$ILNO' "
      " AND A.JTID_L=${LoginController().JTID} AND A.SYID_L=${LoginController().SYID} "
      " AND A.CIID_L='${LoginController().CIID}' $Wheresql LIMIT 1 ";

  var result = await dbClient!.rawQuery(sql);
  List<Ide_Lin_Local> list = result.map((item) {
    return Ide_Lin_Local.fromMap(item);
  }).toList();
  return list;
}

Future<List<Fat_Inv_Snd_Local>> GET_FAT_INV_SND(FISSEQ_N,BMMGU_V,FISST_N) async {
  var dbClient = await conn.database;
  String sql;
  String sql2='';
  String Wheresql='';
  LoginController().BIID_ALL_V=='1'? Wheresql= " AND  A.BIID_L=${LoginController().BIID}":Wheresql='';

  sql = " SELECT A.UUID,A.FISICV,A.FISPIH,A.FCIGU ,A.FISPIN,A.FISPGU,A.FISGU,A.FISSI,A.FISST,A.FISSTO"
      "  FROM FAT_INV_SND A WHERE  A.FISSEQ IS NOT NULL";
  FISSEQ_N!=null?sql+=' AND A.FISSEQ=$FISSEQ_N  ':null;
  BMMGU_V!=null?sql+=" AND A.BMMGU='$BMMGU_V'":null;
  FISST_N!=null?sql+=" AND A.FISST=$FISST_N":null;

  sql+=" AND A.JTID_L=${LoginController().JTID} AND A.SYID_L=${LoginController().SYID} "
      " AND A.CIID_L='${LoginController().CIID}' $Wheresql  ";

  var result = await dbClient!.rawQuery(sql);
  List<Fat_Inv_Snd_Local> list = result.map((item) {
    return Fat_Inv_Snd_Local.fromMap(item);
  }).toList();
  return list;
}

Future<List<Fat_Csid_Seq_Local>> GET_FAT_CSID_SEQ(FCIGU) async {
  var dbClient = await conn.database;
  String sql;
  String Wheresql='';
  LoginController().BIID_ALL_V=='1'? Wheresql= " AND  A.BIID_L=${LoginController().BIID}":Wheresql='';

  sql = " SELECT * FROM FAT_CSID_SEQ A WHERE A.FCIGU='$FCIGU' "
      " AND A.JTID_L=${LoginController().JTID} AND A.SYID_L=${LoginController().SYID} "
      " AND A.CIID_L='${LoginController().CIID}' $Wheresql  LIMIT 1 ";

  var result = await dbClient!.rawQuery(sql);

  List<Fat_Csid_Seq_Local> list = result.map((item) {
    return Fat_Csid_Seq_Local.fromMap(item);
  }).toList();
  return list;
}

Future<List<Fat_Csid_Inf_Local>> CSID_DAT_F(FCIGU) async {
  var dbClient = await conn.database;
  String sql;
  String Wheresql='';
  LoginController().BIID_ALL_V=='1'? Wheresql= " AND  A.BIID_L=${LoginController().BIID}":Wheresql='';

  sql = " SELECT * FROM FAT_CSID_INF A WHERE A.FCIGU='$FCIGU'  "
      " AND A.JTID_L=${LoginController().JTID} AND A.SYID_L=${LoginController().SYID} "
      " AND A.CIID_L='${LoginController().CIID}' $Wheresql  LIMIT 1 ";

  var result = await dbClient!.rawQuery(sql);
  List<Fat_Csid_Inf_Local> list = result.map((item) {
    return Fat_Csid_Inf_Local.fromMap(item);
  }).toList();
  return list;
}

Future<List<Fat_Api_Inf_Local>> GET_FAT_API_INF(FAITY) async {
  var dbClient = await conn.database;
  String sql;
  String Wheresql='';
  LoginController().BIID_ALL_V=='1'? Wheresql= " AND  A.BIID_L=${LoginController().BIID}":Wheresql='';

  sql = " SELECT * FROM FAT_API_INF A WHERE A.STMID='$STMID' AND A.FAITY='$FAITY' AND A.FAISP='P' "
      " AND A.JTID_L=${LoginController().JTID} AND A.SYID_L=${LoginController().SYID} "
      " AND A.CIID_L='${LoginController().CIID}' $Wheresql  LIMIT 1 ";

  var result = await dbClient!.rawQuery(sql);
  List<Fat_Api_Inf_Local> list = result.map((item) {
    return Fat_Api_Inf_Local.fromMap(item);
  }).toList();
  return list;
}

Future<Fat_Inv_Snd_Local> SAVE_FAT_INV_SND(Fat_Inv_Snd_Local data) async {
  var dbClient = await conn.database;
  data.FISSEQ = await dbClient!.insert('FAT_INV_SND', data.toMap());
  return data;
}

Future<Fat_Inv_Rs_Local> SAVE_FAT_INV_RS(Fat_Inv_Rs_Local data) async {
  var dbClient = await conn.database;
  data.FIRSEQ = await dbClient!.insert('FAT_INV_RS', data.toMap());
  return data;
}

Future<int> UPDATE_FAT_INV_SND({FISSEQ_N,FCIGU,UUID,FISST,FISSTO,
  FISSI,FISICV,FISPIN,FISPIH,FISIH,FISQR,FISZHS,FISZHSO,FISZS,FISIS,FISINF,FISWE,FISEE,FISXML,
  FISTOT,FISSUM,FISTWV,FISNS,SOMGU,STMIDU,SOMIDU,FISXE,FISINO}) async {
  var dbClient = await conn.database;
  final data={'FCIGU':FCIGU,'UUID':UUID, 'FISST':FISST,'FISSTO':FISSTO,'FISSI':FISSI,'FISICV':FISICV,'FISPIN':FISPIN,
    'FISPIH':FISPIH,'FISIH':FISIH,'FISQR':FISQR,'FISZHS':FISZHS,'FISZHSO':FISZHSO,'FISZS':FISZS,'FISIS':FISIS,
    'FISINF':FISINF,'FISWE':FISWE,'FISEE':FISEE,'FISXML':FISXML,'FISTOT':FISTOT,'FISSUM':FISSUM,'FISTWV':FISTWV,
    'FISXE':FISXE,'FISINO':FISINO,'FISLSD':DateFormat('dd-MM-yyyy HH:mm:ss').format(DateTime.now())
    ,'FISNS':FISNS,'SOMGU':SOMGU,'SUCH':LoginController().SUID,'DATEU':DateFormat('dd-MM-yyyy HH:mm:ss').format(DateTime.now()),
    'DEVU':LoginController().DeviceName,'STMIDU':STMIDU,'SOMIDU':SOMIDU};
  final result = await dbClient!.update('FAT_INV_SND', data, where: 'FISSEQ=$FISSEQ_N ' );
  return result;
}

Future<int> UPDATE_FAT_CSID_SEQ({FCIGU,FCSNO,FISSEQ,FISGU,FCSHA,DEVU,STMIDU,SOMIDU}) async {
  var dbClient = await conn.database;
  final data={'FCSNO':FCSNO,'FISSEQ':FISSEQ, 'FISGU':FISGU,'FCSHA':FCSHA
    ,'SUCH':LoginController().SUID,'DATEU':DateFormat('dd-MM-yyyy HH:mm:ss').format(DateTime.now()),
    'DEVU':LoginController().DeviceName,'STMIDU':STMIDU,'SOMIDU':SOMIDU};
  final result = await dbClient!.update('FAT_CSID_SEQ', data, where:  "FCIGU='$FCIGU' " );
  return result;
}

Future<int> UPDATE_FAT_INV_SND_ST({BMMGU, FISST, FISQR, FISZHSO}) async {
  var dbClient = await conn.database;
  final data={'FISST':FISST,'FISQR':FISQR, 'FISZHSO':FISZHSO};
  final result = await dbClient!.update('FAT_CSID_SEQ', data, where:  "BMMGU='$BMMGU' " );
  return result;
}

Future<int> UPDATE_BIL_MOV_M_BMMQR({TBL_V, BMKID, BMMID, BMMQR,BMMFS,BMMFUU,BMMFIC,BMMFNO}) async {
  var dbClient = await conn.database;
  int BMMFST=BMMFS;
  int BMMFST_O=BMMFS;
  if (BMMFST==5){
    var GET_BMMFST=await GET_BIL_ST(TBL_V,BMKID,BMMID);
    if(GET_BMMFST.isNotEmpty){
      BMMFST_O=GET_BMMFST.elementAt(0).BMMFST!;
    }
  }
  if (BMMFST==5 && (BMMFST_O!=5 && BMMFST_O!=10)){
    return 0;
  }
  if ([2,3,4,5].contains(BMMFST)) {
    final data2 = {'BMMST': 4,'BMMST2':4};
    final result2 = await dbClient!.update(TBL_V, data2, where: "BMKID=$BMKID AND BMMID=$BMMID ");
    return result2;
  }

//  final data={'BMMFST':BMMFST,'BMMFQR':BMMQR,'BMMFUU':BMMFUU,'BMMFIC':BMMFIC,'BMMFNO':BMMFNO};

  final data={'BMMFST':BMMFST,'BMMFQR':BMMQR,'BMMFUU':BMMFUU,'BMMFIC':BMMFIC,'BMMFNO':BMMFNO,
    'BMMST': 2,'BMMST2':2};
  // print('BMMFS');
  // print(BMMFS);
  // print(BMMFST);
  // print(data);
  final result = await dbClient!.update(TBL_V,data, where:  "BMKID=$BMKID AND BMMID=$BMMID " );
  return result;
}

Future<int> UPDATE_FAT(String  TAB_N,String  VAL_V) async {
  var dbClient = await conn.database;
  String SQL_UPDATE;
  var result;

  if(TAB_N=='FAT_INV_SND'){
    SQL_UPDATE = " UPDATE  $TAB_N SET  FISFS=1  WHERE FISGU='$VAL_V'  ";
    result = await dbClient!.rawUpdate(SQL_UPDATE);
  }

  if(TAB_N=='FAT_INV_SND_D'){
    SQL_UPDATE = " UPDATE  $TAB_N SET  FISDFS=1  WHERE FISGU='$VAL_V'  ";
    result = await dbClient!.rawUpdate(SQL_UPDATE);
  }

  if(TAB_N=='FAT_INV_SND_R'){
    SQL_UPDATE = " UPDATE  $TAB_N SET  FISRFS=1  WHERE FISGU='$VAL_V'  ";
    result = await dbClient!.rawUpdate(SQL_UPDATE);
  }

  if(TAB_N=='FAT_INV_RS'){
    SQL_UPDATE = " UPDATE  $TAB_N SET  FIRFS=1 WHERE BMMGU='$VAL_V' ";
    result = await dbClient!.rawUpdate(SQL_UPDATE);
  }

  if(TAB_N=='FAT_SND_LOG'){
    SQL_UPDATE = " UPDATE  $TAB_N SET  FSLFS=1 WHERE FSLSEQ=$VAL_V ";
    result = await dbClient!.rawUpdate(SQL_UPDATE);
  }

  if(TAB_N=='FAT_SND_LOG_D'){
    SQL_UPDATE = " UPDATE  $TAB_N SET  FSLDFS=1 WHERE FSLSEQ=$VAL_V ";
    result = await dbClient!.rawUpdate(SQL_UPDATE);
  }

  if(TAB_N=='FAT_CSID_SEQ'){
    SQL_UPDATE = " UPDATE  $TAB_N SET  FCSFS=1 WHERE FCIGU='$VAL_V' ";
    result = await dbClient!.rawUpdate(SQL_UPDATE);
  }
  return result;
}

Future<List<Tax_Cod_Local>> GET_TAX_TCID(GETTTID, GETTLTY, GETTLNO,GETTLNO2) async {
  var dbClient = await conn.database;
  String sql;
  String sql2='';
  String Wheresql='';
  String Wheresql2='';
  String Wheresql3='';

  LoginController().BIID_ALL_V=='1'? Wheresql= " AND  A.BIID_L=${LoginController().BIID}":Wheresql='';
  LoginController().BIID_ALL_V=='1'? Wheresql2= " AND  B.BIID_L=${LoginController().BIID}":Wheresql2='';
  LoginController().BIID_ALL_V=='1'? Wheresql3= " AND  C.BIID_L=${LoginController().BIID}":Wheresql3='';

  sql = " SELECT B.TCID,B.TCSY,IFNULL(B.TCVL,0)  FROM TAX_LIN A,TAX_COD B "
      "  WHERE (A.TTID=B.TTID AND A.TCIDI=B.TCID) AND AND IFNULL(A.TTID,0)>0 AND "
      "  A.TTID=$GETTTID AND A.TLTY='$GETTLTY' AND A.TLNO='$GETTLNO' AND A.TLNO2='$GETTLNO2'"
      "  AND A.JTID_L=${LoginController().JTID} AND A.SYID_L=${LoginController().SYID} "
      " AND A.CIID_L='${LoginController().CIID}' $Wheresql"
      " AND B.JTID_L=${LoginController().JTID} AND B.SYID_L=${LoginController().SYID} "
      " AND B.CIID_L='${LoginController().CIID}' $Wheresql2 "
      "  ORDER BY A.TTID LIMIT 1 ";
  var result = await dbClient!.rawQuery(sql);

  List<Tax_Cod_Local> list = result.map((item) {
    return Tax_Cod_Local.fromMap(item);
  }).toList();
  return list;
}

Future<List<Tax_Lin_Local>> GET_TAX_TCSDID(GETTTID, GETTLTY, GETTLNO,GETTLNO2) async {
  var dbClient = await conn.database;
  String sql;
  String Wheresql='';

  LoginController().BIID_ALL_V=='1'? Wheresql= " AND  A.BIID_L=${LoginController().BIID}":Wheresql='';

  sql = " SELECT A.TCSDIDI FROM TAX_LIN A "
      "  WHERE A.TTID=$GETTTID AND A.TLTY='$GETTLTY' AND A.TLNO='$GETTLNO' AND A.TLNO2='$GETTLNO2'"
      "  AND A.JTID_L=${LoginController().JTID} AND A.SYID_L=${LoginController().SYID} "
      " AND A.CIID_L='${LoginController().CIID}' $Wheresql"
      "  ORDER BY A.TTID LIMIT 1 ";
  var result = await dbClient!.rawQuery(sql);

  List<Tax_Lin_Local> list = result.map((item) {
    return Tax_Lin_Local.fromMap(item);
  }).toList();
  return list;
}

Future<List<Tax_Cod_Sys_D_Local>> GET_TAX_TCSDSY(GETTTID, TCSDID) async {
  var dbClient = await conn.database;
  String sql;
  String Wheresql='';
  String Wheresql2='';

  LoginController().BIID_ALL_V=='1'? Wheresql= " AND  A.BIID_L=${LoginController().BIID}":Wheresql='';
  LoginController().BIID_ALL_V=='1'? Wheresql2= " AND  B.BIID_L=${LoginController().BIID}":Wheresql2='';

  sql = " SELECT A.TCSDSY,IFNULL(B.TCSVL,1) AS TCSVL FROM TAX_COD_SYS_D A,TAX_COD_SYS B WHERE A.TCSID=B.TCSID AND A.TTSID=B.TTSID"
      " AND A.TCSDID=$TCSDID AND A.TTSID>0 AND A.TTSID=$GETTTID"
      "  AND A.JTID_L=${LoginController().JTID} AND A.SYID_L=${LoginController().SYID} "
      " AND A.CIID_L='${LoginController().CIID}' $Wheresql"
      " AND B.JTID_L=${LoginController().JTID} AND B.SYID_L=${LoginController().SYID} "
      " AND B.CIID_L='${LoginController().CIID}' $Wheresql2 LIMIT 1 ";
  var result = await dbClient!.rawQuery(sql);

  List<Tax_Cod_Sys_D_Local> list = result.map((item) {
    return Tax_Cod_Sys_D_Local.fromMap(item);
  }).toList();
  return list;
}

Future<List<Bil_Mov_D_Local>> GET_BIL_MOV_D_TX(String TAB_N,String BMMID,SCSFL_TX) async {
  var dbClient = await conn.database;
  String sql;
  String Wheresql='';
  String Wheresql2='';
  String Wheresql3='';
  String Wheresql4='';
  LoginController().BIID_ALL_V=='1'? Wheresql= " AND A.BIID_L=${LoginController().BIID}":Wheresql='';
  LoginController().BIID_ALL_V=='1'? Wheresql2= " AND B.BIID_L=${LoginController().BIID}":Wheresql='';
  LoginController().BIID_ALL_V=='1'? Wheresql3= " AND C.BIID_L=${LoginController().BIID}":Wheresql3='';
  LoginController().BIID_ALL_V=='1'? Wheresql4= " AND D.BIID_L=${LoginController().BIID}":Wheresql4='';

  sql =""" SELECT IFNULL(B.BMDNO,0.0) AS  BMDNO ,IFNULL(B.BMDNF,0.0) AS BMDNF ,
      IFNULL(B.BMDNO,0)+IFNULL(B.BMDNF,0) AS  QUN_N,IFNULL(B.BMDAM_TX,0.0) AS AM_N,
      IFNULL(B.BMDAM_TX,0.0) AS FR_AM_N ,IFNULL(C.MINA,C.MGNO||'-'||C.MINO) AS NAM_V,
      NULL AS NAM_EN_V,B.BMDAMT3 AS TOT_AM_N,B.TCAMT AS TOT_VAT_N,
      IFNULL(B.BMDAMT3,0.0)+IFNULL(B.TCAMT ,0.0) AS TOT_W_VAT_N ,
      B.TCSY AS VAT_CAT_V,B.TCRA AS VAT_RAT_N,CASE WHEN IFNULL(B.TCSY,'S')<>'S' THEN
      (SELECT  IFNULL(TCSDNE,TCSDNA)  FROM TAX_COD_SYS_D WHERE TCSDID=B.TCSDID)  
      ELSE NULL END AS TAX_EXE_V ,
      CASE WHEN IFNULL(B.TCSY,'S')<>'S' THEN B.TCSDSY ELSE NULL END AS TAX_EXE_COD_V,0 AS DIS_AM_N  , 
      round(IFNULL(B.BMDDI_TX,0.0)*IFNULL( (IFNULL(B.BMDNO,0.0)+IFNULL(B.BMDNF,0.0) ),1),
      IFNULL($SCSFL_TX,1)) AS DIS_AM_N2,
      CASE WHEN IFNULL(BMDDI_TX,0.0)<=0 THEN NULL ELSE  '95' END  AS DIS_COD_V,
      CASE WHEN IFNULL(BMDDI_TX,0.0)<=0 THEN NULL ELSE  'Discount' END AS DIS_RES_V
      FROM $TAB_N B,MAT_INF C
      WHERE (B.MGNO=C.MGNO AND B.MINO=C.MINO) AND IFNULL(B.BMDNO,0.0)+IFNULL(B.BMDNF,0.0) >0
      AND IFNULL(B.BMDAM,0.0)>0 AND B.BMMID=$BMMID
      AND B.JTID_L=${LoginController().JTID} AND B.SYID_L=${LoginController().SYID} 
      AND B.CIID_L=${LoginController().CIID} $Wheresql2
      AND C.JTID_L=${LoginController().JTID} AND C.SYID_L=${LoginController().SYID} 
      AND C.CIID_L=${LoginController().CIID} $Wheresql3
      ORDER BY B.BMDID """;

  var result = await dbClient!.rawQuery(sql);
  List<Bil_Mov_D_Local> list = result.map((item) {
    return Bil_Mov_D_Local.fromMap(item);
  }).toList();
  return list;
}

Future<List<Bil_Mov_D_Local>> SUM_BMDAM_TX(String TAB_N,int GetBMMID) async {
  var dbClient = await conn.database;
  String sql;
  sql = "select ifnull(SUM(ifnull(BMDAM_TX, 0.0) * (ifnull(BMDNO, 0.0) + ifnull(BMDNF, 0.0))),0.0) AS BMDAM_TX "
      " from $TAB_N where BMMID=$GetBMMID ";
  var result = await dbClient!.rawQuery(sql);
  List<Bil_Mov_D_Local> list = result.map((item) {
    return Bil_Mov_D_Local.fromMap(item);
  }).toList();
  return list;
}

Future<List<Bil_Mov_D_Local>> SUM_BMDDI_TX(String TAB_N,int GetBMMID) async {
  var dbClient = await conn.database;
  String sql;
  sql = "select ifnull(SUM(ifnull(BMDDI_TX, 0.0) * (ifnull(BMDNO, 0.0) + ifnull(BMDNF, 0.0))),0.0) AS BMDDI_TX "
      " from $TAB_N where BMMID=$GetBMMID ";
  var result = await dbClient!.rawQuery(sql);
  List<Bil_Mov_D_Local> list = result.map((item) {
    return Bil_Mov_D_Local.fromMap(item);
  }).toList();
  return list;
}

Future<List<Bil_Mov_D_Local>> SUM_TCAMT(String TAB_N,int GetBMMID) async {
  var dbClient = await conn.database;
  String sql;
  sql = "select ifnull(SUM(ifnull(TCAMT, 0.0)),0.0) AS TCAMT from $TAB_N where BMMID=$GetBMMID ";
  var result = await dbClient!.rawQuery(sql);
  List<Bil_Mov_D_Local> list = result.map((item) {
    return Bil_Mov_D_Local.fromMap(item);
  }).toList();
  return list;
}

Future<Fat_Inv_Snd_D_Local> SAVE_FAT_INV_SND_D(Fat_Inv_Snd_D_Local data) async {
  var dbClient = await conn.database;
  await dbClient!.insert('FAT_INV_SND_D', data.toMap());
  return data;
}

Future<Fat_Inv_Snd_R_Local> SAVE_FAT_INV_SND_R(Fat_Inv_Snd_R_Local data) async {
  var dbClient = await conn.database;
  await dbClient!.insert('FAT_INV_SND_R', data.toMap());
  return data;
}

Future<List<Fat_Que_Local>> GET_FAT_QUE(FQTY) async {
  var dbClient = await conn.database;
  String sql;
  String Wheresql='';
  LoginController().BIID_ALL_V=='1'? Wheresql= " AND  A.BIID_L=${LoginController().BIID}":Wheresql='';

  sql = " SELECT * FROM FAT_QUE A WHERE  A.FQTY='$FQTY' "
      " AND A.JTID_L=${LoginController().JTID} AND A.SYID_L=${LoginController().SYID} "
      " AND A.CIID_L='${LoginController().CIID}' $Wheresql  LIMIT 1 ";

  var result = await dbClient!.rawQuery(sql);
  List<Fat_Que_Local> list = result.map((item) {
    return Fat_Que_Local.fromMap(item);
  }).toList();
  return list;
}


//المحطاااااااات
Future<List<Cou_Inf_M_Local>> GET_COU_INF_M(String GETBIID,String GETCTMID,String GETBPID,String GETSCID,int Type_Usr) async {
  var dbClient = await conn.database;
  String sql;
  String sql_COU_USR='';
  String Wheresql='';
  String Wheresql2='';
  String Wheresql3='';
  String Wheresql4='';
  String Wheresql5='';
  String Wheresql6='';
  LoginController().BIID_ALL_V=='1'? Wheresql= " AND  A.BIID_L=${LoginController().BIID}":Wheresql='';
  LoginController().BIID_ALL_V=='1'? Wheresql2= " AND  B.BIID_L=${LoginController().BIID}":Wheresql2='';
  LoginController().BIID_ALL_V=='1'? Wheresql3= " AND  F.BIID_L=${LoginController().BIID}":Wheresql3='';
  LoginController().BIID_ALL_V=='1'? Wheresql4= " AND  C.BIID_L=${LoginController().BIID}":Wheresql4='';
  LoginController().BIID_ALL_V=='1'? Wheresql6= " AND  T.BIID_L=${LoginController().BIID}":Wheresql6='';
  Type_Usr==1? sql_COU_USR =" T.CUIN=1 AND ":sql_COU_USR='  T.CUAP=1 AND ';

  sql = "SELECT *,CASE WHEN ${LoginController().LAN}=2 AND A.CIMNE IS NOT NULL THEN A.CIMNE ELSE A.CIMNA END  CIMNA_D"
      " FROM COU_INF_M A,MAT_PRI C,MAT_INF F WHERE  EXISTS(SELECT 1 FROM COU_USR T WHERE T.CIMID=A.CIMID AND "
      "  $sql_COU_USR  T.SUID='${LoginController().SUID}'  AND T.JTID_L=${LoginController().JTID} "
      "  AND T.SYID_L=${LoginController().SYID} AND T.CIID_L='${LoginController().CIID}' $Wheresql6) AND "
      " $Wheresql5 A.BIID=$GETBIID AND CASE WHEN $GETCTMID=0  THEN A.CTMID  ELSE  A.CTMID=$GETCTMID END  AND A.CIMST=1 AND A.JTID_L=${LoginController().JTID} "
      " AND A.SYID_L=${LoginController().SYID} AND A.CIID_L='${LoginController().CIID}' $Wheresql AND "
      " exists (SELECT 1 FROM COU_POI_L B WHERE B.CIMID=A.CIMID and B.BPID=$GETBPID AND B.CPLST=1 AND B.JTID_L=${LoginController().JTID}"
      " AND B.SYID_L=${LoginController().SYID} AND B.CIID_L='${LoginController().CIID}' $Wheresql2) AND "
      " (C.MGNO=A.MGNO AND C.MINO=A.MINO) AND C.MUID=A.MUID AND C.BIID=A.BIID AND C.SCID=$GETSCID AND C.MPS1>0 AND "
      " C.JTID_L=${LoginController().JTID} AND C.SYID_L=${LoginController().SYID} "
      " AND C.CIID_L='${LoginController().CIID}' $Wheresql4 AND "
      " (F.MGNO=A.MGNO AND F.MINO=A.MINO)  AND F.JTID_L=${LoginController().JTID} "
      "  AND F.SYID_L=${LoginController().SYID} AND F.CIID_L='${LoginController().CIID}' $Wheresql3 "
      " ORDER BY ifnull(A.ordnu,A.CIMID) ";
  var result = await dbClient!.rawQuery(sql);

  List<Cou_Inf_M_Local> list = result.map((item) {
    return Cou_Inf_M_Local.fromMap(item);
  }).toList();
  return list;
}

Future<List<Cou_Inf_M_Local>> GET_COU_INF_M_ONE(String GETBIID,String GETCTMID,String GETBPID,String GETSCID,int Type_Usr) async {
  var dbClient = await conn.database;
  String sql;
  String sql_COU_USR='';
  String Wheresql='';
  String Wheresql2='';
  String Wheresql3='';
  String Wheresql4='';
  String Wheresql6='';
  LoginController().BIID_ALL_V=='1'? Wheresql= " AND  A.BIID_L=${LoginController().BIID}":Wheresql='';
  LoginController().BIID_ALL_V=='1'? Wheresql2= " AND  B.BIID_L=${LoginController().BIID}":Wheresql2='';
  LoginController().BIID_ALL_V=='1'? Wheresql3= " AND  F.BIID_L=${LoginController().BIID}":Wheresql3='';
  LoginController().BIID_ALL_V=='1'? Wheresql4= " AND  C.BIID_L=${LoginController().BIID}":Wheresql4='';
  LoginController().BIID_ALL_V=='1'? Wheresql6= " AND  T.BIID_L=${LoginController().BIID}":Wheresql6='';
  Type_Usr==1? sql_COU_USR =" T.CUIN=1 AND ":sql_COU_USR='  T.CUAP=1 AND ';

  sql = "SELECT *,CASE WHEN ${LoginController().LAN}=2 AND A.CIMNE IS NOT NULL THEN A.CIMNE ELSE A.CIMNA END  CIMNA_D"
      " FROM COU_INF_M A,MAT_PRI C WHERE EXISTS(SELECT 1 FROM COU_USR T WHERE T.CIMID=A.CIMID AND "
      "  $sql_COU_USR  T.SUID='${LoginController().SUID}'  AND T.JTID_L=${LoginController().JTID} "
      "  AND T.SYID_L=${LoginController().SYID} AND T.CIID_L='${LoginController().CIID}' $Wheresql6) AND "
      "  A.BIID=$GETBIID AND CASE WHEN $GETCTMID=0  THEN A.CTMID  ELSE  A.CTMID=$GETCTMID END AND A.CIMST=1 AND A.JTID_L=${LoginController().JTID} "
      " AND A.SYID_L=${LoginController().SYID} AND A.CIID_L='${LoginController().CIID}' $Wheresql AND "
      " A.CIMID IN (SELECT B.CIMID FROM COU_POI_L B WHERE BPID=$GETBPID AND B.CPLST=1 AND B.JTID_L=${LoginController().JTID}"
      " AND B.SYID_L=${LoginController().SYID} AND B.CIID_L='${LoginController().CIID}' $Wheresql2) AND "
      " (C.MGNO=A.MGNO AND C.MINO=A.MINO) AND C.MUID=A.MUID AND C.BIID=A.BIID AND C.SCID=$GETSCID AND "
      " C.JTID_L=${LoginController().JTID} AND C.SYID_L=${LoginController().SYID} "
      " AND C.CIID_L='${LoginController().CIID}' $Wheresql4 "
      " ORDER BY A.CIMID LIMIT 1";
  var result = await dbClient!.rawQuery(sql);
  List<Cou_Inf_M_Local> list = result.map((item) {
    return Cou_Inf_M_Local.fromMap(item);
  }).toList();
  return list;
}

Future<List<Cou_Typ_M_Local>> GET_COU_TYP_M(String GETTYPE) async {
  var dbClient = await conn.database;
  String sql;
  String sql2;
  String Wheresql='';
  String Wheresql2='';
  LoginController().BIID_ALL_V=='1'? Wheresql= " AND  A.BIID_L=${LoginController().BIID}":Wheresql='';
  LoginController().BIID_ALL_V=='1'? Wheresql2= " AND  B.BIID_L=${LoginController().BIID}":Wheresql2='';
  sql2 = "SELECT *,CASE WHEN ${LoginController().LAN}=2 AND A.CTMNE IS NOT NULL THEN A.CTMNE ELSE A.CTMNA END  CTMNA_D"
      " FROM COU_TYP_M A WHERE  A.CTMST=1  AND EXISTS(SELECT 1 FROM COU_INF_M B WHERE  B.CTMID=A.CTMID "
      " AND B.JTID_L=${LoginController().JTID} AND B.SYID_L=${LoginController().SYID} AND "
      " B.CIID_L='${LoginController().CIID}' $Wheresql2) AND A.JTID_L=${LoginController().JTID} "
      " AND A.SYID_L=${LoginController().SYID} AND A.CIID_L='${LoginController().CIID}' $Wheresql"
      " ORDER BY A.CTMID ";
  String all='ALL';
  String AllArbic='الكل';
  sql = "select C.CTMID,CASE WHEN ${LoginController().LAN}=2 AND C.CTMNE IS NOT NULL THEN C.CTMNE ELSE C.CTMNA END  CTMNA_D FROM "
      "(SELECT 0 AS CTMID ,'$AllArbic' AS CTMNA ,'$all' AS CTMNE ,0 AS ORDNU UNION ALL SELECT A.CTMID AS CTMID,A.CTMNA AS CTMNA ,A.CTMNE AS CTMNE,"
      " ifnull(A.ORDNU,A.CTMID) AS ORDNU FROM COU_TYP_M A WHERE A.CTMST=1  "
      " AND EXISTS(SELECT 1 FROM COU_INF_M B WHERE  B.CTMID=A.CTMID  AND B.JTID_L=${LoginController().JTID}"
      " AND B.SYID_L=${LoginController().SYID} AND  B.CIID_L='${LoginController().CIID}' $Wheresql2) "
      " AND A.JTID_L=${LoginController().JTID}  AND A.SYID_L=${LoginController().SYID} "
      " AND A.CIID_L='${LoginController().CIID}' $Wheresql)C ORDER BY ifnull(C.ORDNU,C.CTMID)";
  var result = await dbClient!.rawQuery(GETTYPE=='ALL'?sql:sql2);
  List<Cou_Typ_M_Local> list = result.map((item) {
    return Cou_Typ_M_Local.fromMap(item);
  }).toList();
  return list;
}

Future<List<Cou_Typ_M_Local>> GET_COU_TYP_M_ONE() async {
  var dbClient = await conn.database;
  String sql;
  String Wheresql='';
  String Wheresql2='';
  LoginController().BIID_ALL_V=='1'? Wheresql= " AND  A.BIID_L=${LoginController().BIID}":Wheresql='';
  LoginController().BIID_ALL_V=='1'? Wheresql2= " AND  B.BIID_L=${LoginController().BIID}":Wheresql2='';

  sql = "SELECT *,CASE WHEN ${LoginController().LAN}=2 AND A.CTMNE IS NOT NULL THEN A.CTMNE ELSE A.CTMNA END  CTMNA_D"
      " FROM COU_TYP_M A WHERE  A.CTMST=1  AND EXISTS(SELECT 1 FROM COU_INF_M B WHERE  B.CTMID=A.CTMID "
      " AND B.JTID_L=${LoginController().JTID} AND B.SYID_L=${LoginController().SYID} AND "
      " B.CIID_L='${LoginController().CIID}' $Wheresql2) AND A.JTID_L=${LoginController().JTID} "
      " AND A.SYID_L=${LoginController().SYID} AND A.CIID_L='${LoginController().CIID}' $Wheresql"
      " ORDER BY A.CTMID LIMIT 1 ";

  var result = await dbClient!.rawQuery(sql);
  List<Cou_Typ_M_Local> list = result.map((item) {
    return Cou_Typ_M_Local.fromMap(item);
  }).toList();
  return list;
}

Future<List<Bil_Mov_D_Local>> GET_COUNT_BIF_MOV_D(int GETCIMID,int GETBMMID) async {
  var dbClient = await conn.database;
  String sql;
  String Wheresql='';
  LoginController().BIID_ALL_V=='1'? Wheresql= " AND  BIID_L=${LoginController().BIID}":Wheresql='';

  sql = "SELECT COUNT(*) AS COUNT_CIMID FROM BIF_MOV_D WHERE CIMID=$GETCIMID AND BMMID=$GETBMMID "
      " AND JTID_L=${LoginController().JTID} AND SYID_L=${LoginController().SYID} AND "
      " CIID_L='${LoginController().CIID}' $Wheresql";
  var result = await dbClient!.rawQuery(sql);
  List<Bil_Mov_D_Local> list = result.map((item) {
    return Bil_Mov_D_Local.fromMap(item);
  }).toList();
  return list;
}


Future<int> UpdateBIF_MOV_M(double GetBMMAM,double GETBMMTX,int? GetBMMID,double GETBMMEQ,String GETSUCH,String GETDATEU) async {
  var dbClient = await conn.database;
  final data = {'BMMAM':GetBMMAM,'BMMTX':GETBMMTX,'BMMEQ':GETBMMEQ,'SUCH':GETSUCH,'DATEU':GETDATEU};
  final result = await dbClient!.update('BIF_MOV_M', data, where: 'BMMID=$GetBMMID');
  return result;
}

Future<int> deleteBIF_MOV_D(int id) async {
  var dbClient = await conn.database;
  return await dbClient!.delete('BIF_MOV_D', where: 'BMMID=?', whereArgs: [id]);
}

Future<int> deleteBIF_COU_C(id) async {
  var dbClient = await conn.database;
  return await dbClient!.delete('BIF_COU_C', where: 'BCMID=?', whereArgs: [id]);
}

Future<int> deleteBIF_MOV_M(int id) async {
  var dbClient = await conn.database;
  return await dbClient!.delete(
      'BIF_MOV_M', where: 'BMMID=?', whereArgs: [id]);
}

Future<List<Bil_Mov_D_Local>> GET_Bif_Mov_D_DetectApp() async {
  var dbClient = await conn.database;
  String sql;
  sql = "select A.BMMID from BIF_MOV_D A WHERE NOT EXISTS (SELECT 1 FROM BIF_MOV_M B WHERE A.BMMID=B.BMMID) "
      " ORDER BY A.BMMID  LIMIT 1";
  var result = await dbClient!.rawQuery(sql);
  List<Bil_Mov_D_Local> list = result.map((item) {
    return Bil_Mov_D_Local.fromMap(item);
  }).toList();
  return list;
}

Future<int> UpdateBIF_MOV_M_PAY(String GetPKID,int? GETBCID,String? GetAANO,int? GetBCCID,String? GETBCCNA,String? GETBMMNA,double GETBMMAM,int? GetBMMID) async {
  var dbClient = await conn.database;
  final data = {'PKID':GetPKID,'BCID':GETBCID,'AANO':GetAANO,'BCCID':GetBCCID,'BCCNA':GETBCCNA,'BMMNA':GETBMMNA,'BMMAM':GETBMMAM};
  final result = await dbClient!.update('BIF_MOV_M', data, where: 'BMMID=$GetBMMID');
  return result;
}

Future<List<Sys_Cur_Local>> GET_SYS_CUR_ONE() async {
  var dbClient = await conn.database;
  String sql;
  String Wheresql='';
  LoginController().BIID_ALL_V=='1'? Wheresql= " AND  A.BIID_L=${LoginController().BIID}":Wheresql='';

  sql = "SELECT *,CASE WHEN ${LoginController().LAN}=2 AND A.SCNE IS NOT NULL THEN A.SCNE ELSE A.SCNA END  SCNA_D"
      " FROM SYS_CUR A WHERE A.SCST NOT IN(2,4) AND A.JTID_L=${LoginController().JTID} "
      " AND A.SYID_L=${LoginController().SYID} AND A.CIID_L='${LoginController().CIID}' $Wheresql"
      " ORDER BY A.SCID LIMIT 1";
  var result = await dbClient!.rawQuery(sql);
  List<Sys_Cur_Local> list = result.map((item) {
    return Sys_Cur_Local.fromMap(item);
  }).toList();
  return list;
}

Future<List<Bil_Mov_M_Local>> GET_BMMNO_COU(String TYPE_NO,String SVVL_NO2,String PKID,String GetYear) async {
  var dbClient = await conn.database;
  String sql;
  String SelectPKID=(PKID==8 || PKID==1)?'PKID=8 OR PKID=1':'PKID=$PKID';
  String sql2='';
  String sql3='';
  String Wheresql='';
  SVVL_NO2=='1' ?sql2='  $SelectPKID AND ':sql2='';
  if(TYPE_NO=='1'){
    sql3='  strftime( (substr(BMMDO,7,4) ) )=';
  }else if(TYPE_NO=='2'){
    sql3='  strftime( (substr(BMMDO,4,2) ) )=';
  }else if(TYPE_NO=='3'){
    sql3='  strftime( (substr(BMMDO,1,2) ) )=';
  }
  LoginController().BIID_ALL_V=='1'? Wheresql= " AND  BIID_L=${LoginController().BIID}":Wheresql='';
  sql = "SELECT ifnull(MAX(BMMNO),0)+1 AS BMMNO FROM BIF_MOV_M  WHERE BMKID=11 AND SUID=${LoginController().SUID} AND $sql2 "
      "$sql3 '$GetYear'  AND"
      " JTID_L=${LoginController().JTID} AND SYID_L=${LoginController().SYID}  AND CIID_L='${LoginController().CIID}' $Wheresql ";
  var result = await dbClient!.rawQuery(sql);
  List<Bil_Mov_M_Local> list = result.map((item) {
    return Bil_Mov_M_Local.fromMap(item);
  }).toList();
  return list;
}

Future<List<Bif_Cou_M_Local>> GET_BIF_COU_M(String TYPE,String GETDateNow) async {
  var dbClient = await conn.database;
  String sql;
  String sql2='';
  String Wheresql='';
  String Wheresql2='';
  String Wheresql3='';
  String Wheresql4='';
  if(TYPE=='DateNow' || TYPE=='FromDate'){
    sql2=" A.BCMDO like'%$GETDateNow%' AND";
  }
  LoginController().BIID_ALL_V=='1'? Wheresql= " AND  A.BIID_L=${LoginController().BIID}":Wheresql='';
  LoginController().BIID_ALL_V=='1'? Wheresql2= " AND  B.BIID_L=${LoginController().BIID}":Wheresql2='';
  LoginController().BIID_ALL_V=='1'? Wheresql3= " AND  C.BIID_L=${LoginController().BIID}":Wheresql3='';
  LoginController().BIID_ALL_V=='1'? Wheresql4= " AND  T.BIID_L=${LoginController().BIID}":Wheresql4='';
  sql = "SELECT A.*,CASE WHEN ${LoginController().LAN}=2 AND B.BINE IS NOT NULL THEN B.BINE ELSE B.BINA END  BINA_D,"
      "CASE WHEN ${LoginController().LAN}=2 AND C.BPNE IS NOT NULL THEN C.BPNE ELSE C.BPNA END  BPNA_D,"
      "CASE WHEN ${LoginController().LAN}=2 AND T.SCNE IS NOT NULL THEN T.SCNE ELSE T.SCNA END  SCNA_D"
      " FROM BIF_COU_M A,BRA_INF B,BIL_POI C,SYS_CUR T WHERE $sql2 A.JTID_L=${LoginController().JTID} "
      " AND A.SYID_L=${LoginController().SYID} AND A.CIID_L='${LoginController().CIID}' $Wheresql"
      " AND B.BIID=A.BIID AND B.JTID_L=${LoginController().JTID} "
      " AND B.SYID_L=${LoginController().SYID} AND B.CIID_L='${LoginController().CIID}' $Wheresql2"
      " AND C.BPID=A.BPID AND C.JTID_L=${LoginController().JTID} "
      " AND C.SYID_L=${LoginController().SYID} AND C.CIID_L='${LoginController().CIID}' $Wheresql3"
      " AND T.SCID=A.SCID AND T.JTID_L=${LoginController().JTID} "
      " AND T.SYID_L=${LoginController().SYID} AND T.CIID_L='${LoginController().CIID}' $Wheresql4 ORDER BY A.BCMID DESC";
  var result = await dbClient!.rawQuery(sql);
  List<Bif_Cou_M_Local> list = result.map((item) {
    return Bif_Cou_M_Local.fromMap(item);
  }).toList();
  return list;
}

Future<Bif_Cou_M_Local> Save_BIF_COU_M(Bif_Cou_M_Local data) async {
  var dbClient = await conn.database;
  data.BCMID = await dbClient!.insert('BIF_COU_M', data.toMap());
  return data;
}

Future<Bif_Cou_C_Local> Save_BIF_COU_C(Bif_Cou_C_Local data) async {
  var dbClient = await conn.database;
  data.BCCID = await dbClient!.insert('BIF_COU_C', data.toMap());
  return data;
}

Future<List<Bif_Cou_M_Local>> GET_BCMID() async {
  var dbClient = await conn.database;
  String sql;
  String Wheresql='';
  LoginController().BIID_ALL_V=='1'? Wheresql= " AND  BIID_L=${LoginController().BIID}":Wheresql='';
  sql = "SELECT ifnull(MAX(BCMID),0)+1 AS BCMID FROM BIF_COU_M";
  var result = await dbClient!.rawQuery(sql);
  List<Bif_Cou_M_Local> list = result.map((item) {
    return Bif_Cou_M_Local.fromMap(item);
  }).toList();
  return list;
}

Future<List<Bif_Cou_M_Local>> GET_BCMNO() async {
  var dbClient = await conn.database;
  String sql;
  String sql2='';
  String Wheresql='';
  // SVVL_NO2=='1'?sql2='  PKID=$PKID AND ':sql2='';
  LoginController().BIID_ALL_V=='1'? Wheresql= " AND  BIID_L=${LoginController().BIID}":Wheresql='';
  sql = "SELECT ifnull(MAX(BCMNO),0)+1 AS BCMNO FROM BIF_COU_M  WHERE  "
      " JTID_L=${LoginController().JTID} AND SYID_L=${LoginController().SYID}  AND CIID_L='${LoginController().CIID}' $Wheresql ";
  var result = await dbClient!.rawQuery(sql);

  List<Bif_Cou_M_Local> list = result.map((item) {
    return Bif_Cou_M_Local.fromMap(item);
  }).toList();
  return list;
}


Future<List<Bif_Cou_C_Local>> GET_BCCID( GETBCMID) async {
  var dbClient = await conn.database;
  String sql;
  sql = "SELECT ifnull(MAX(BCCID),0)+1 AS BCCID FROM BIF_COU_C  WHERE  BCMID=$GETBCMID  ";
  var result = await dbClient!.rawQuery(sql);
  List<Bif_Cou_C_Local> list = result.map((item) {
    return Bif_Cou_C_Local.fromMap(item);
  }).toList();

  return list;
}

Future<List<Bif_Cou_C_Local>> GET_COUNTBCCID( GETBCMID) async {
  var dbClient = await conn.database;
  String sql;
  sql = "SELECT COUNT(BCCID) AS COUNTBCCID FROM BIF_COU_C  WHERE  BCMID=$GETBCMID  ";
  var result = await dbClient!.rawQuery(sql);
  List<Bif_Cou_C_Local> list = result.map((item) {
    return Bif_Cou_C_Local.fromMap(item);
  }).toList();
  return list;
}

Future<int> DeleteBIF_COU_C_ONE(DELBCMID,GETBCCID) async {
  var dbClient = await conn.database;
  final res=dbClient!.delete('BIF_COU_C', where: 'BCMID=$DELBCMID AND BCCID=$GETBCCID');
  return res ;
}

Future<List<Bif_Cou_C_Local>> CountSUMBCMAMC(GETBCMID) async {
  var dbClient = await conn.database;
  String sql;
  sql = "select ifnull(sum(BCMAMSUM),0.0) AS SUMBCMAMC from BIF_COU_C where BCMID=$GETBCMID ";
  var result = await dbClient!.rawQuery(sql);
  List<Bif_Cou_C_Local> list = result.map((item) {
    return Bif_Cou_C_Local.fromMap(item);
  }).toList();
  return list;
}

Future<List<Cou_Red_Local>> GET_COU_RED(String GETCIMID) async {
  var dbClient = await conn.database;
  String sql;
  String Wheresql='';
  LoginController().BIID_ALL_V=='1'? Wheresql= " AND  BIID_L=${LoginController().BIID}":Wheresql='';
  sql ="SELECT * FROM COU_RED  WHERE CIMID=$GETCIMID  AND JTID_L=${LoginController().JTID} AND SYID_L=${LoginController().SYID} AND "
      " CIID_L=${LoginController().CIID} $Wheresql ORDER BY CIMID DESC LIMIT 1 ";
  var result = await dbClient!.rawQuery(sql);
  List<Cou_Red_Local> list = result.map((item) {
    return Cou_Red_Local.fromMap(item);
  }).toList();
  return list;
}

Future<List<Bif_Cou_C_Local>> GET_BIF_COU_C_DATE(String GETCIMID) async {
  var dbClient = await conn.database;
  String sql;
  String Wheresql='';
  LoginController().BIID_ALL_V=='1'? Wheresql= " AND  BIID_L=${LoginController().BIID}":Wheresql='';

  sql ="SELECT DATEI,BCMRN FROM BIF_COU_C  WHERE CIMID=$GETCIMID  AND JTID_L=${LoginController().JTID} AND SYID_L=${LoginController().SYID} AND "
      " CIID_L=${LoginController().CIID} $Wheresql ORDER BY BCMID DESC LIMIT 1 ";
  var result = await dbClient!.rawQuery(sql);
  List<Bif_Cou_C_Local> list = result.map((item) {
    return Bif_Cou_C_Local.fromMap(item);
  }).toList();
  return list;
}

Future<Cou_Red_Local> Save_COU_RED(Cou_Red_Local data) async {
  var dbClient = await conn.database;
  data.CIMID = await dbClient!.insert('COU_RED', data.toMap());
  return data;
}

Future<int> UpdateStateCOU_RED(String TypeSync,String GetBCMID,int GetBCMST) async {
  var dbClient = await conn.database;
  String value='';
  if(TypeSync=='SyncAll'){
    value='BCMST=2';
  }
  else if(TypeSync=='SyncOnly'){
    value='BCMST=2 and BCMID=$GetBCMID';
  }
  final data = {'BCMST':GetBCMST};
  final result = await dbClient!.update('COU_RED', data, where: value);
  return result;
}

Future<List<Bil_Mov_M_Local>> GET_COUNT_BIF_MOV_M() async {
  var dbClient = await conn.database;
  String sql;
  String Wheresql='';
  LoginController().BIID_ALL_V=='1'? Wheresql= " AND  BIID_L=${LoginController().BIID}":Wheresql='';

  sql = "SELECT COUNT(*) AS BMMID FROM BIF_MOV_M WHERE BMMST!=1 "
      " AND JTID_L=${LoginController().JTID} AND SYID_L=${LoginController().SYID} AND "
      " CIID_L='${LoginController().CIID}' $Wheresql";
  var result = await dbClient!.rawQuery(sql);
  List<Bil_Mov_M_Local> list = result.map((item) {
    return Bil_Mov_M_Local.fromMap(item);
  }).toList();
  return list;
}

Future<List<Bil_Mov_M_Local>> GET_SUM_MOUNT_BIF_MOV_M(String GETPKID,String GETBIID,String GETBPID,String GETCTMID) async {
  var dbClient = await conn.database;
  String sql;
  String Wheresql='';
  String Wheresql2='';
  LoginController().BIID_ALL_V=='1'? Wheresql= " AND  BIID_L=${LoginController().BIID}":Wheresql='';
  if (GETPKID=='8'){
    Wheresql2='AND PKID=$GETPKID GROUP BY BCCID';
  }else if(GETPKID=='1'){
    Wheresql2='AND PKID=$GETPKID';
  }
  sql = "SELECT SUM(BMMAM) AS SUMBMMAM,BCCID FROM BIF_MOV_M WHERE BMMST=1 AND BMMCOU=2"
      " AND JTID_L=${LoginController().JTID} AND SYID_L=${LoginController().SYID} AND "
      " CIID_L='${LoginController().CIID}' AND BIID=$GETBIID AND BPID=$GETBPID AND"
      " CASE WHEN $GETCTMID=0  THEN CTMID  ELSE  CTMID=$GETCTMID END  $Wheresql $Wheresql2";
  var result = await dbClient!.rawQuery(sql);
  List<Bil_Mov_M_Local> list = result.map((item) {
    return Bil_Mov_M_Local.fromMap(item);
  }).toList();
  return list;
}

Future<List<Bif_Cou_C_Local>> GET_BIF_COU_C( GETBCMID) async {
  var dbClient = await conn.database;
  String sql;
  String Wheresql='';
  String Wheresql2='';
  LoginController().BIID_ALL_V=='1'? Wheresql= " AND  A.BIID_L=${LoginController().BIID}":Wheresql='';
  LoginController().BIID_ALL_V=='1'? Wheresql2= " AND  B.BIID_L=${LoginController().BIID}":Wheresql2='';

  sql = "SELECT *,CASE WHEN ${LoginController().LAN}=2 AND B.CIMNE IS NOT NULL THEN B.CIMNE ELSE B.CIMNA END  CIMNA_D"
      " FROM BIF_COU_C A,COU_INF_M B  WHERE A.CIMID=B.CIMID AND BCMID=$GETBCMID AND  A.JTID_L=${LoginController().JTID} "
      " AND A.SYID_L=${LoginController().SYID} AND A.CIID_L='${LoginController().CIID}' $Wheresql $Wheresql2";
  var result = await dbClient!.rawQuery(sql);
  List<Bif_Cou_C_Local> list = result.map((item) {return Bif_Cou_C_Local.fromMap(item);}).toList();
  return list;
}

Future<int> UpdateBIF_COU_C(String GetBCMID,String GETBCCID,String GETBCMTD,int GETSIID,int GETSCID
    ,double GETSCEX,int GETCTMID,int GETCIMID,int GETSCIDC,double GETBCMRO,double GETBCMRN,
    int? GETBCCID1,int? GETBCCID2,int? GETBCCID3,double GETBCMAM1,double GETBCMAM2,double GETBCMAM3,double GETBCMAM,
    double GETBCMTA,int? GETACID,String GETACNO,double GETBCMAMSUM,String GETBCCIN,String GETSUCH,String GETDATEU,String GETDEVU)
async {
  var dbClient = await conn.database;
  String value='';
  value=' BCMID=$GetBCMID AND BCCID=$GETBCCID';
  final data = {'BCMTD':GETBCMTD,'SIID':GETSIID,'SCID':GETSCID
    ,'SCEX':GETSCEX,'CTMID':GETCTMID,'CIMID':GETCIMID,'SCIDC':GETSCIDC,'BCMRO':GETBCMRO,'BCMRN':GETBCMRN
    ,'BCCID1':GETBCCID1,'BCCID2':GETBCCID2,'BCCID3':GETBCCID3,'BCMAM1':GETBCMAM1,'BCMAM3':GETBCMAM3,'BCMAM2':GETBCMAM2
    ,'BCCIN':GETBCCIN,'BCMAM':GETBCMAM,'BCMTA':GETBCMTA,'ACID':GETACID,'BCMAMSUM':GETBCMAMSUM,'SUCH':GETSUCH,'DATEU':GETDATEU,'DEVU':GETDEVU};
  final result = await dbClient!.update('BIF_COU_C', data, where: value);
  return result;
}

Future<List<Bil_Cre_C_Local>> GET_BIL_CRE_C_APPROVE(String GETBIID) async {
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
      " AND (A.BIID IS NULL OR A.BIID=$GETBIID) ORDER BY A.BCCID LIMIT 3";
  var result = await dbClient!.rawQuery(sql);
  List<Bil_Cre_C_Local> list = result.map((item) {
    return Bil_Cre_C_Local.fromMap(item);
  }).toList();
  return list;
}

Future<List<Bif_Cou_C_Local>> GET_CIMID( GETBCMID,GETCIMID) async {
  var dbClient = await conn.database;
  String sql;
  String Wheresql='';
  LoginController().BIID_ALL_V=='1'? Wheresql= " AND  BIID_L=${LoginController().BIID}":Wheresql='';

  sql = "SELECT COUNT(*) AS COUNTCIMID FROM BIF_COU_C  WHERE  BCMID=$GETBCMID AND CIMID=$GETCIMID "
      " AND JTID_L=${LoginController().JTID} AND SYID_L=${LoginController().SYID} AND CIID_L='${LoginController().CIID}' "
      " $Wheresql ";
  var result = await dbClient!.rawQuery(sql);
  List<Bif_Cou_C_Local> list = result.map((item) {
    return Bif_Cou_C_Local.fromMap(item);
  }).toList();
  return list;
}

Future<int> UpdateStateBIF_COU_M(String TypeSync,String GetBCMID,int GetSYST) async {
  var dbClient = await conn.database;
  String value='';
  if(TypeSync=='SyncAll'){value='BCMST=2';}
  else if(TypeSync=='SyncOnly'){value='BCMST=2 and BCMID=$GetBCMID';}
  final data = {'BCMST':GetSYST};
  final result = await dbClient!.update('BIF_COU_M', data, where: value);
  return result;
}

Future<int> deleteBIF_COU_M(int id) async {
  var dbClient = await conn.database;
  return await dbClient!.delete('BIF_COU_M', where: 'BCMID=?', whereArgs: [id]);
}

Future<int> deleteCOU_RED(int id) async {
  var dbClient = await conn.database;
  return await dbClient!.delete('COU_RED', where: 'BCMID=?', whereArgs: [id]);
}

Future<int> UpdateBIF_COU_M(String GetBCMID,String GETBCMFD,String GETBCMTD,int GETBPID,int GETSIID,int GETSCID
    ,double GETSCEX,int GETBIID,int GETCTMID,int GETCIMID,int GETSCIDC,int GETBCMRO,int GETBCMRN,
    int? GETBCCID1,int? GETBCCID2,int? GETBCCID3,double GETBCMAM1,double GETBCMAM2,double GETBCMAM3,String GETMGNO,String GETMINO,
    int GETMUID,double GETBCMAM,double GETBCMTA,int? GETACID,String GETACNO,String GETBCMIN,String GETSUCH,String GETDATEU,String GETDEVU)
async {
  var dbClient = await conn.database;
  String value='';
  value=' BCMID=$GetBCMID';

  final data = {'BCMFD':GETBCMFD,'BCMTD':GETBCMTD,'BPID':GETBPID,'SIID':GETSIID,'SCID':GETSCID
    ,'SCEX':GETSCEX,'BIID':GETBIID,'CTMID':GETCTMID,'CIMID':GETCIMID,'SCIDC':GETSCIDC,'BCMRO':GETBCMRO,'BCMRN':GETBCMRN
    ,'BCCID1':GETBCCID1,'BCCID2':GETBCCID2,'BCCID3':GETBCCID3,'BCMAM1':GETBCMAM1,'BCMAM3':GETBCMAM3,'BCMAM2':GETBCMAM2
    ,'BCMIN':GETBCMIN,'MGNO':GETMGNO,'MINO':GETMINO
    ,'MUID':GETMUID,'BCMAM':GETBCMAM,'BCMTA':GETBCMTA,'ACID':GETACID,'SUID':GETSUCH,'DATEU':GETDATEU,'DEVU':GETDEVU};
  final result = await dbClient!.update('BIF_COU_M', data, where: value);
  return result;
}

Future<int> UPDATE_BIF_MOV_M(String GETBIID,String GETBPID,String GETCTMID) async {
  var dbClient = await conn.database;
  String SQL=GETCTMID=='0'?'':'and CTMID=$GETCTMID';
  final data = {'BMMCOU': 1 };
  final result = await dbClient!.update('BIF_MOV_M', data,where: 'BIID=$GETBIID and BPID=$GETBPID $SQL');
  return result;
}

Future<List<Bif_Cou_M_Local>> GET_BIF_COU_M_DATE(GETBIID,GETBPID,GETCTMID) async {
  var dbClient = await conn.database;
  String sql;
  String Wheresql='';
  LoginController().BIID_ALL_V=='1'? Wheresql= " AND  A.BIID_L=${LoginController().BIID}":Wheresql='';
  sql = "SELECT MAX(BCMRD) AS BCMRD FROM BIF_COU_M A WHERE A.BIID=$GETBIID  AND A.BPID=$GETBPID AND "
      "  CASE WHEN $GETCTMID=0  THEN A.CTMID=0  ELSE  A.CTMID=$GETCTMID END"
      " AND A.JTID_L=${LoginController().JTID} AND A.SYID_L=${LoginController().SYID} AND "
      " A.CIID_L='${LoginController().CIID}' $Wheresql ";

  var result = await dbClient!.rawQuery(sql);
  List<Bif_Cou_M_Local> list = result.map((item) {
    return Bif_Cou_M_Local.fromMap(item);
  }).toList();
  return list;
}

Future<int> UpdateBIF_MOV_D(double GetBMDNO,double GETBMDAMT,int? GetBMMID,int? GetBMDID,
    double GetBMDAM, double GETBMDEQ,double GETBMDTX,double GETBMDTX1,double GETBMDTX2,double GETBMDTX3,double GETBMDTXA1,double GETBMDTXA2
    ,double GETBMDTXA3,double GETBMDTXA,double GETBMDTXT1,
    double GETBMDTXT2,double GETBMDTXT3,double GETBMDTXT,GETBMDAM_TX,GETBMDDI_TX,BMDAMT3,TCAMT) async {
  var dbClient = await conn.database;
  final data = {'BMDNO':GetBMDNO,'BMDAM':GetBMDAM,'BMDAMT':GETBMDAMT,'BMDEQ':GETBMDEQ,
    'BMDTXA11':GETBMDTXA1,'BMDTXA22':GETBMDTXA2,'BMDTXA33':GETBMDTXA3
    ,'BMDTXA':GETBMDTXA,'BMDTX':GETBMDTX,'BMDTX11': GETBMDTX1,'BMDTX22':GETBMDTX2,'BMDTX33':GETBMDTX3
    ,'BMDTXT1':GETBMDTXT1,'BMDTXT2':GETBMDTXT2,'BMDTXT3':GETBMDTXT3,
    'BMDTXT':GETBMDTXT,'BMDAM_TX':GETBMDAM_TX,
    'BMDDI_TX':GETBMDDI_TX,'BMDAMT3':BMDAMT3,'TCAMT':TCAMT};

  final result = await dbClient!.update('BIF_MOV_D', data, where: 'BMMID=$GetBMMID AND BMDID=$GetBMDID');
  return result;
}


Future<void> SAVE_SND_INV_D_R(String type, String data, int P_BMMFST_N, String P_FISGU_V) async {
  var dbClient = await conn.database;
  String tableName = (type == 'WAR' || type == 'ERR') ? 'FAT_INV_SND_D' : 'FAT_INV_SND_R';
  String query = 'INSERT INTO $tableName (FISDGU, FISGU, FISDTY, FISDDA) VALUES (?, ?, ?, ?)';

  var guid = await Uuid().v4().toString().toUpperCase(); // وظيفة لتوليد GUID
  tableName=='FAT_INV_SND_D'?
  await dbClient!.insert(tableName, {
    'FISDGU': guid,
    'FISGU': P_FISGU_V,
    'FISDTY': type,
    'FISDDA': data.substring(0, data.length > 1999 ? 1999 : data.length), // تقليم البيانات
  }):
  await dbClient!.insert(tableName, {
    'FISRGU': guid,
    'FISGU': P_FISGU_V,
    'FISRTY': type,
    'FISRDA': data.toString(), // تقليم البيانات
  });
}

Future<List<Bil_Mov_M_Local>> GET_BIL_ST(TAB_V,BMKID,BMMID) async {
  var dbClient = await conn.database;
  String sql;
  String Wheresql='';
  LoginController().BIID_ALL_V=='1'? Wheresql= " AND  A.BIID_L=${LoginController().BIID}":Wheresql='';
  sql = "SELECT A.BMMFST FROM $TAB_V A WHERE A.BMKID=$BMKID  AND A.BMMID=$BMMID AND "
      "  A.JTID_L=${LoginController().JTID} AND A.SYID_L=${LoginController().SYID} AND "
      " A.CIID_L='${LoginController().CIID}' $Wheresql ";

  var result = await dbClient!.rawQuery(sql);

  List<Bil_Mov_M_Local> list = result.map((item) {
    return Bil_Mov_M_Local.fromMap(item);
  }).toList();
  return list;
}

Future<List<Bil_Mov_M_Local>> GET_BIL_BMMFNOR(TAB_V,GUID) async {
  var dbClient = await conn.database;
  String sql;
  String Wheresql='';
  LoginController().BIID_ALL_V=='1'? Wheresql= " AND  A.BIID_L=${LoginController().BIID}":Wheresql='';
  sql = "SELECT A.BMMFNO FROM $TAB_V A WHERE A.GUID='$GUID' AND "
      "  A.JTID_L=${LoginController().JTID} AND A.SYID_L=${LoginController().SYID} AND "
      " A.CIID_L='${LoginController().CIID}' $Wheresql ";

  var result = await dbClient!.rawQuery(sql);

  List<Bil_Mov_M_Local> list = result.map((item) {
    return Bil_Mov_M_Local.fromMap(item);
  }).toList();
  return list;
}

