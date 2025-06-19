import 'package:sqflite/sqflite.dart';
import '../Operation/models/inventory.dart';
import '../Operation/models/sto_mov_m.dart';
import '../Services/ErrorHandlerService.dart';
import '../Setting/controllers/login_controller.dart';
import '../Setting/controllers/setting_controller.dart';
import '../Setting/models/acc_acc.dart';
import '../Setting/models/bra_inf.dart';
import '../Setting/models/mat_gro.dart';
import '../Setting/models/mat_inf.dart';
import '../Setting/models/mat_uni_b.dart';
import '../Setting/models/mat_uni_c.dart';
import '../Setting/models/sto_inf.dart';
import '../Setting/models/sto_num.dart';
import '../Setting/models/sys_cur.dart';
import '../Setting/models/sys_yea.dart';
import 'database.dart';

final conn = DatabaseHelper.instance;

Future<List<STO_MOV_M_Local>> GET_SMMID() async {
  return await ErrorHandlerService.run(() async {
    var dbClient = await conn.database;
    String sql;
    String Wheresql='';
    LoginController().BIID_ALL_V=='1'? Wheresql= " AND  BIID_L=${LoginController().BIID}":Wheresql='';
    sql = "SELECT ifnull(MAX(SMMID),0)+1 AS SMMID FROM STO_MOV_M where"
        "  JTID_L=${LoginController().JTID} "
        " AND SYID_L=${LoginController().SYID} AND CIID_L='${LoginController().CIID}' $Wheresql";
    var result = await dbClient!.rawQuery(sql);
    List<STO_MOV_M_Local> list = result.map((item) {
      return STO_MOV_M_Local.fromMap(item);
    }).toList();
    return list;
  },Err: 'GET_SMMID');
}

Future<List<STO_MOV_M_Local>> GET_SMMNO(int GETSMKID) async {
  return await ErrorHandlerService.run(() async {
    var dbClient = await conn.database;
    String sql;
    String Wheresql='';
    String sql2='';
    String sql3='';

    GETSMKID==0?sql2=' AND BKID=-1  AND BMMID=-1 ':sql2=' AND BKID is null  AND BMMID is null ';
    if(GETSMKID==131){
      sql3=' AND BIID!=BIIDT ';
    }else{
      sql3=' AND BIIDT is null ';
    };

    GETSMKID==0?GETSMKID=1:GETSMKID==131?GETSMKID=13:GETSMKID;

    LoginController().BIID_ALL_V=='1'? Wheresql= " AND  BIID_L=${LoginController().BIID}":Wheresql='';
    sql = "SELECT ifnull(MAX(SMMNO),0)+1 AS SMMNO FROM STO_MOV_M  WHERE SMKID=$GETSMKID $sql2 $sql3 AND SUID='${LoginController().SUID}' AND "
        " JTID_L=${LoginController().JTID} AND SYID_L=${LoginController().SYID}  AND CIID_L='${LoginController().CIID}' $Wheresql ";
    var result = await dbClient!.rawQuery(sql);
    List<STO_MOV_M_Local> list = result.map((item) {
      return STO_MOV_M_Local.fromMap(item);
    }).toList();
    return list;
  },Err: 'GET_SMMNO');
}

Future<List<Sto_Mov_D_Local>> GET_SMDID(int GETSMMID) async {
  return await ErrorHandlerService.run(() async {
    var dbClient = await conn.database;
    String sql;
    String Wheresql='';
    LoginController().BIID_ALL_V=='1'? Wheresql= " AND  BIID_L=${LoginController().BIID}":Wheresql='';
    sql = "SELECT ifnull(MAX(SMDID),0)+1 AS SMDID FROM STO_MOV_D  WHERE  SMMID=$GETSMMID ";
    var result = await dbClient!.rawQuery(sql);
    List<Sto_Mov_D_Local> list = result.map((item) {
      return Sto_Mov_D_Local.fromMap(item);
    }).toList();
    return list;
    },Err: 'GET_SMDID');
}


Future<STO_MOV_M_Local> SaveSto_Mov_M(STO_MOV_M_Local data) async {
  return await ErrorHandlerService.run(() async {
    var dbClient = await conn.database;
    data.SMMID = await dbClient!.insert('STO_MOV_M', data.toMap());
    return data;
  },Err: 'SaveSto_Mov_M');
}

Future<Sto_Mov_D_Local> SaveSto_Mov_D(Sto_Mov_D_Local data) async {
  return await ErrorHandlerService.run(() async {
    var dbClient = await conn.database;
    data.SMDID = await dbClient!.insert('STO_MOV_D', data.toMap());
    return data;
  },Err: 'SaveSto_Mov_D');
}

Future<int> DeleteSTO_MOV_D(int id) async {
  return await ErrorHandlerService.run(() async {
    var dbClient = await conn.database;
    return await dbClient!.delete('STO_MOV_D', where: 'SMMID=?', whereArgs: [id]);
  },Err: 'DeleteSTO_MOV_D');
}

Future<int> DeleteSTO_MOV_M(int id) async {
  return await ErrorHandlerService.run(() async {
    var dbClient = await conn.database;
    return await dbClient!.delete('STO_MOV_M', where: 'SMMID=?', whereArgs: [id]);
  },Err: 'DeleteSTO_MOV_M');
}


Future<List<Mat_Inf_Local>> Get_MAT_INF(int GetSMKID,String GetSIID,String GetSIID_T,String GetMGNO) async {
  return await ErrorHandlerService.run(() async {
    var dbClient = await conn.database;
    String sql='';
    String MGNOsql='';
    String sqlSIID='';
    String sql3='';
    String Wheresql='';
    String Wheresql2='';
    String Wheresql3='';
    String Wheresql4='';
    String Wheresql5='';
    LoginController().BIID_ALL_V=='1'? Wheresql= " AND C.BIID_L=${LoginController().BIID}":Wheresql='';
    LoginController().BIID_ALL_V=='1'? Wheresql2= " AND A.BIID_L=${LoginController().BIID}":Wheresql2='';
    LoginController().BIID_ALL_V=='1'? Wheresql3= " AND B.BIID_L=${LoginController().BIID}":Wheresql3='';
    LoginController().BIID_ALL_V=='1'? Wheresql4= " AND D.BIID_L=${LoginController().BIID}":Wheresql4='';
    LoginController().BIID_ALL_V=='1'? Wheresql5= " AND E.BIID_L=${LoginController().BIID}":Wheresql5='';

    if(StteingController().isSwitchUse_Gro==true && GetMGNO.isNotEmpty){
      MGNOsql=" A.MGNO='$GetMGNO' AND  ";
    }

    GetSMKID==13 || GetSMKID==11 || GetSMKID==131?sqlSIID=' C.SIID BETWEEN $GetSIID AND $GetSIID_T ':sqlSIID=' C.SIID=$GetSIID ';

    if(StteingController().isShow_Mat_No_SNNO==false){
      sql3=" AND EXISTS(SELECT 1 FROM STO_NUM C WHERE  $sqlSIID AND (C.MGNO=A.MGNO AND C.MINO=A.MINO)"
          "AND C.JTID_L=${LoginController().JTID} AND C.SYID_L=${LoginController().SYID} "
          " AND C.CIID_L=${LoginController().CIID} $Wheresql) ";
    }

    if(StteingController().Type_Serach==2){
      sql = " SELECT CASE WHEN ${LoginController().LAN}=2 AND A.MINE IS NOT NULL THEN A.MINE ELSE A.MINA END  MINA_D,"
          " A.MINA,A.MINO,A.MGNO,D.MUCBC,A.MIED FROM MAT_INF A,MAT_GRO B,MAT_UNI_B D WHERE  "
          " A.JTID_L=${LoginController().JTID} AND A.SYID_L=${LoginController().SYID} "
          " AND A.CIID_L=${LoginController().CIID} $Wheresql2 AND A.MGNO=B.MGNO"
          " AND B.MGTY=2 AND B.MGKI=1 AND B.JTID_L=${LoginController().JTID} AND B.SYID_L=${LoginController().SYID} "
          " AND B.CIID_L=${LoginController().CIID} $Wheresql3"
          " AND (D.MGNO=A.MGNO AND D.MINO=A.MINO) AND D.MUCBC IS NOT NULL AND $MGNOsql "
          " D.JTID_L=${LoginController().JTID} AND D.SYID_L=${LoginController().SYID} "
          " AND D.CIID_L=${LoginController().CIID} $Wheresql4 AND "
          " EXISTS(SELECT 1 FROM GRO_USR E WHERE E.MGNO=A.MGNO AND E.SUID='${LoginController().SUID}'"
          " AND E.JTID_L=${LoginController().JTID} AND E.SYID_L=${LoginController().SYID} "
          " AND E.CIID_L=${LoginController().CIID} $Wheresql5)"
          " $sql3  ORDER BY A.MGNO,A.MINO ";
    }
    else{
      sql = "SELECT A.MINA,A.MINO,A.MGNO,A.MIED,CASE WHEN ${LoginController().LAN}=2 AND A.MINE IS NOT NULL THEN A.MINE ELSE A.MINA END  MINA_D"
          " FROM MAT_INF A,MAT_GRO B WHERE A.JTID_L=${LoginController().JTID} AND A.SYID_L=${LoginController().SYID} "
          " AND A.CIID_L=${LoginController().CIID} $Wheresql2 AND A.MGNO=B.MGNO AND B.MGTY=2 AND B.MGKI=1 "
          " AND B.JTID_L=${LoginController().JTID} AND B.SYID_L=${LoginController().SYID} "
          " AND B.CIID_L=${LoginController().CIID} $Wheresql3"
          " AND $MGNOsql  EXISTS(SELECT 1 FROM GRO_USR D WHERE D.MGNO=A.MGNO AND D.SUID='${LoginController().SUID}'"
          " AND D.JTID_L=${LoginController().JTID} AND D.SYID_L=${LoginController().SYID} "
          " AND D.CIID_L=${LoginController().CIID} $Wheresql4)"
          " $sql3  ORDER BY A.MGNO,A.MINO ";
    }

    var result = await dbClient!.rawQuery(sql);
    //if (result.length == 0) return null;
    List<Mat_Inf_Local> list = result.map((item) {
      return Mat_Inf_Local.fromMap(item);
    }).toList();
    print(sql);
    print(result);
    return list;
  },Err: 'Get_MAT_INF');
}

Future<int> UpdateStateSto_Mov_M(String TypeSync,int GTSMKID,String GetSMMID,int GetSMMST) async {
  return await ErrorHandlerService.run(() async {
    var dbClient = await conn.database;
    String value='';
    if(TypeSync=='SyncAll'){
      value='SMMST=2 AND SMKID=$GTSMKID';
    }
    else if(TypeSync=='SyncOnly'){
      value='SMMST=2 and SMMID=$GetSMMID';
    }

    final data = {'SMMST':GetSMMST};
    final result = await dbClient!.update('STO_MOV_M', data, where: value);
    return result;
  },Err: 'UpdateStateSto_Mov_M');
}

Future<int> UPADTE_SIID(int GetSMMID,String GetSIID) async {
  return await ErrorHandlerService.run(() async {
    var dbClient = await conn.database;
    final data = {'SIID':GetSIID};
    final result = await dbClient!.update('STO_MOV_D', data, where: "SMMID=$GetSMMID");
    return result;
  },Err: 'UPADTE_SIID');
}

Future<int> UpdateStateSto_Mov_D(String TypeSync,int GTSMKID,String GetSMMID,int GetSYST) async {
  return await ErrorHandlerService.run(() async {
    var dbClient = await conn.database;
    String value='';
    if(TypeSync=='SyncAll'){
      value='SYST=2 AND SMKID=$GTSMKID';
    }
    else if(TypeSync=='SyncOnly'){
      value='SYST=2 and SMMID=$GetSMMID';
    }

    final data = {'SYST':GetSYST};
    final result = await dbClient!.update('STO_MOV_D', data, where: value);
    return result;
  },Err: 'UpdateStateSto_Mov_D');
}

Future<int?> Get_Count_D(int GetSMMID,String GetMGNO,String GetMINO,int GETMUID,String USESMDE,String GETSMDDE) async {
  return await ErrorHandlerService.run(() async {
    var dbClient = await conn.database;
    String sql;
    String SqlUSESMDE='';
    String Wheresql='';

    LoginController().BIID_ALL_V=='1'? Wheresql= " AND  BIID_L=${LoginController().BIID}":Wheresql='';
    if(USESMDE=='1'){
      SqlUSESMDE=" AND SMDED='$GETSMDDE'";
    }

    sql = "SELECT count(*)  FROM STO_MOV_D where SMMID=$GetSMMID AND MGNO='$GetMGNO' AND MINO='$GetMINO' AND MUID=$GETMUID"
        "  $SqlUSESMDE   AND  JTID_L=${LoginController().JTID} "
        " AND SYID_L=${LoginController().SYID} AND CIID_L='${LoginController().CIID}' $Wheresql";
    var x = await dbClient!.rawQuery(sql);
    int? Count = Sqflite.firstIntValue(x);
    return Count;
  },Err: 'Get_Count_D');
}

Future<int> UpdateSMDNF(int GetSMKID,int GetSMMID,String GetMGNO,String GetMINO,int GETMUID,
    double GetSMDNF,String USESMDE,String GETSMDDE,double GetSMDAM) async {
  return await ErrorHandlerService.run(() async {
    var dbClient = await conn.database;
    String SQLUPDATE;
    String SqlUSESMDE='';
    String SqlUSEGetSMKID='';
    if(USESMDE=='1'){
      SqlUSESMDE=" AND SMDED='$GETSMDDE'";
    }
    if(GetSMKID==17){
      SqlUSEGetSMKID=" SMDDF=SMDDF+$GetSMDNF,SMDNF=SMDNF+$GetSMDNF";
    }else if (GetSMKID==1){
      SqlUSEGetSMKID=" SMDNO=SMDNO+$GetSMDNF , SMDAM=$GetSMDAM , SMDEQ=$GetSMDAM";
    }

    SQLUPDATE = "update sto_mov_d set  $SqlUSEGetSMKID "
        " where SMMID=$GetSMMID AND MGNO='$GetMGNO' AND MINO='$GetMINO' AND MUID=$GETMUID  $SqlUSESMDE";
    final result = await dbClient!.rawUpdate(SQLUPDATE);
    return result;
  },Err: 'UpdateSMDNF');
}

Future<int> UpdateSto_Mov_D(int GetSMKID,int GetSMMID,int GetSMDID,String GetMGNO,String GetMINO,
    int GETMUID,double GetSMDNF,double GetSMDDF,String GETSMDDE,double GetSMDAM,double GetSMDEQ,double GetSMDEQC,
    double GetSMDAMR,double GetSMDAMRE,double GetSMDAMT,double GetSMDAMTF) async {
  return await ErrorHandlerService.run(() async {
    var dbClient = await conn.database;
    final data = {'MGNO':GetMGNO,'MINO':GetMINO,
      'MUID':GETMUID, 'SMDNF':GetSMDNF
      ,'SMDDF':GetSMDDF,'SMDED':GETSMDDE};

    final data2={'MGNO':GetMGNO,'MINO':GetMINO,
      'MUID':GETMUID, 'SMDNO':GetSMDNF,'SMDNF':GetSMDDF,'SMDAM':GetSMDAM,'SMDEQ':GetSMDAM,
      'SMDED':GETSMDDE,'SMDEQC':GetSMDEQC,'SMDAMR':GetSMDAMR,'SMDAMRE':GetSMDAMRE,'SMDAMT':GetSMDAMT,
      'SMDAMTF':GetSMDAMTF,'SUCH':LoginController().SUID};
    final result = await dbClient!.update('STO_MOV_D', GetSMKID==17?data:data2, where: 'SMMID=$GetSMMID AND '
        'SMDID=$GetSMDID');
    return result;
  },Err: 'UpdateSto_Mov_D');
}


Future<List<Mat_Inf_Local>> Get_MUIDS_D(String GetMGNO,String GetMINO) async {
  return await ErrorHandlerService.run(() async {

    var dbClient = await conn.database;
    String sql;
    String Wheresql='';

    LoginController().BIID_ALL_V=='1'? Wheresql= " AND  BIID_L=${LoginController().BIID}":Wheresql='';

    sql = "SELECT * FROM MAT_INF where MGNO='$GetMGNO' AND MINO='$GetMINO' AND "
        "JTID_L=${LoginController().JTID} AND SYID_L=${LoginController().SYID} AND "
        "CIID_L=${LoginController().CIID} $Wheresql ";
    var result = await dbClient!.rawQuery(sql);
    //if (result.length == 0) return null;
    List<Mat_Inf_Local> list = result.map((item) {
      return Mat_Inf_Local.fromMap(item);
    }).toList();
    return list;

  },Err: 'Get_MUIDS_D');
}


Future<List<Mat_Uni_B_Local>> Get_BRO(String GetSIID,String Getbarcod) async {
  return await ErrorHandlerService.run(() async {
    var dbClient = await conn.database;
    String sql;
    String sql3='';
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

  },Err: 'Get_BRO');
}


Future<List<Sto_Mov_D_Local>> CountSMDNF(int GetSMMID,int TYPE) async {
  return await ErrorHandlerService.run(() async {
    var dbClient = await conn.database;
    String sql;
    String sql2='';
    TYPE==11 || TYPE==1 || TYPE==0 || TYPE==3 || TYPE==13 || TYPE==131 ? sql2='SMDNO':sql2='SMDNF';
    sql = "select ifnull(sum($sql2),0.0) AS SUM from STO_MOV_D where SMMID=$GetSMMID";
    var result = await dbClient!.rawQuery(sql);
    List<Sto_Mov_D_Local> list = result.map((item) {
      return Sto_Mov_D_Local.fromMapSum(item);
    }).toList();
    return list;
  },Err: 'CountSMDNF');
}



Future<List<Sto_Num_Local>> GET_SMDED(String GETMGNO,String GETMINO,String GETSIID,String GETMUID,GETSMKID) async {
  return await ErrorHandlerService.run(() async {
    var dbClient = await conn.database;
    String sql;
    String sql2=GETSMKID=='3' ?  ' and SNNO>0 ':'';
    String Wheresql='';
    LoginController().BIID_ALL_V=='1'? Wheresql= " AND  BIID_L=${LoginController().BIID}":Wheresql='';

    sql = "SELECT * FROM STO_NUM WHERE SIID=$GETSIID AND  MGNO='$GETMGNO' AND MINO='$GETMINO' AND MUID=$GETMUID  $sql2"
        " AND JTID_L=${LoginController().JTID} "
        " AND SYID_L=${LoginController().SYID} AND CIID_L=${LoginController().CIID} $Wheresql";
    var result = await dbClient!.rawQuery(sql);
    List<Sto_Num_Local> list = result.map((item) {
      return Sto_Num_Local.fromMap(item);
    }).toList();
    return list;
  },Err: 'GET_SMDED');
}

Future<List<Sto_Num_Local>> Get_SNDE_ONE(String GETMGNO,String GETMINO,String GETSIID,String GETMUID) async {
  return await ErrorHandlerService.run(() async {
    var dbClient = await conn.database;
    String sql;
    String Wheresql='';
    LoginController().BIID_ALL_V=='1'? Wheresql= " AND  BIID_L=${LoginController().BIID}":Wheresql='';

    sql = "SELECT * FROM STO_NUM WHERE  SIID=$GETSIID AND  MGNO='$GETMGNO' AND MINO='$GETMINO' AND MUID=$GETMUID"
        " AND JTID_L=${LoginController().JTID} AND SYID_L=${LoginController().SYID} "
        " AND CIID_L=${LoginController().CIID} $Wheresql ORDER BY SIID DESC LIMIT 1";
    var result = await dbClient!.rawQuery(sql);
    List<Sto_Num_Local> list = result.map((item) {
      return Sto_Num_Local.fromMap(item);
    }).toList();
    return list;
  },Err: 'Get_SNDE_ONE');
}


Future<List<Sto_Mov_D_Local>> CountRecode(int GetSMMID) async {
  return await ErrorHandlerService.run(() async {
    var dbClient = await conn.database;
    String sql;
    String Wheresql='';
    LoginController().BIID_ALL_V=='1'? Wheresql= " AND  BIID_L=${LoginController().BIID}":Wheresql='';
    sql = "select ifnull(count(1),0) AS COU from STO_MOV_D where SMMID=$GetSMMID "
        " AND JTID_L=${LoginController().JTID} AND SYID_L=${LoginController().SYID} "
        " AND CIID_L=${LoginController().CIID} $Wheresql";
    var result = await dbClient!.rawQuery(sql);
    //if (result.length == 0) return null;
    List<Sto_Mov_D_Local> list = result.map((item) {
      return Sto_Mov_D_Local.fromMapCou(item);
    }).toList();
    return list;
  },Err: 'CountRecode');

}


Future<List<Sys_Yea_Local>> GET_SYS_YEA(int GetSYID) async {
  return await ErrorHandlerService.run(() async {
    var dbClient = await conn.database;
    String sql;

    sql = " SELECT *  FROM  SYS_YEA_ACC WHERE  SYID=$GetSYID  ORDER BY SYID  LIMIT 1";
    var result = await dbClient!.rawQuery(sql);
    //if (result.length == 0) return null;
    List<Sys_Yea_Local> list = result.map((item) {
      return Sys_Yea_Local.fromMap(item);
    }).toList();
    return list;
  },Err: 'GET_SYS_YEA');
}

Future<int> UpdateSMMNR(int GetSMMNR,int? GetSMMID) async {
  return await ErrorHandlerService.run(() async {
    var dbClient = await conn.database;
    final data = {'SMMNR':GetSMMNR};
    final result = await dbClient!.update('STO_MOV_M', data, where: 'SMMID=$GetSMMID');
    return result;
  },Err: 'UpdateSMMNR');
}

Future<List<Mat_Gro_Local>> GET_MGNA(String GetMGNO) async {
  return await ErrorHandlerService.run(() async {
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
  },Err: 'GET_MGNA');
}


Future<List<Sto_Mov_D_Local>> GET_NUM_INV_MINO(String GetBIID,String GetSIID,String GetMGNO,String GetMINO) async {
  var dbClient = await conn.database;
  String sql;
  String Wheresql='';
  LoginController().BIID_ALL_V=='1'? Wheresql= " AND BIID_L=${LoginController().BIID}":Wheresql='';

  sql = " SELECT COUNT(*) AS NUM_MINO FROM STO_MOV_D  WHERE   SIID=$GetSIID AND MGNO='$GetMGNO' AND MINO='$GetMINO'"
      " AND JTID_L=${LoginController().JTID} AND SYID_L=${LoginController().SYID} "
      " AND CIID_L=${LoginController().CIID} $Wheresql";
  var result = await dbClient!.rawQuery(sql);
  List<Sto_Mov_D_Local> list = result.map((item) {
    return Sto_Mov_D_Local.fromMapSum(item);
  }).toList();
  return list;
}

Future<int> updateSYST(int GETSMMID, int GETSYST) async {
  var dbClient = await conn.database;
  final data = { 'SYST': GETSYST};
  final result =
  await dbClient!.update('STO_MOV_D', data, where: 'SMMID=?', whereArgs: [GETSMMID]);
  return result;
}

Future<List<Sto_Mov_D_Local>> GET_Sto_Mov_D_DetectApp() async {
  var dbClient = await conn.database;
  String sql;
  sql = "select A.SMMID from sto_mov_d A WHERE NOT EXISTS (SELECT 1 FROM STO_MOV_M B WHERE A.SMMID=B.SMMID) "
      " ORDER BY A.SMMID  LIMIT 1";
  var result = await dbClient!.rawQuery(sql);
  List<Sto_Mov_D_Local> list = result.map((item) {
    return Sto_Mov_D_Local.fromMap(item);
  }).toList();
  return list;
}

Future<List<Mat_Inf_Local>> Get_MAT_INF_Download(String GETBIID,String GetSIID,String GETSCID) async {
  var dbClient = await conn.database;
  String sql='';
  String sql3='';
  String Wheresql='';
  String Wheresql2='';
  String Wheresql3='';
  String Wheresql4='';
  String Wheresql5='';
  LoginController().BIID_ALL_V=='1'? Wheresql= " AND C.BIID_L=${LoginController().BIID}":Wheresql='';
  LoginController().BIID_ALL_V=='1'? Wheresql2= " AND A.BIID_L=${LoginController().BIID}":Wheresql2='';
  LoginController().BIID_ALL_V=='1'? Wheresql3= " AND B.BIID_L=${LoginController().BIID}":Wheresql3='';
  LoginController().BIID_ALL_V=='1'? Wheresql4= " AND D.BIID_L=${LoginController().BIID}":Wheresql4='';
  LoginController().BIID_ALL_V=='1'? Wheresql5= " AND E.BIID_L=${LoginController().BIID}":Wheresql5='';

  if(StteingController().isShow_Mat_No_SNNO==false){

  sql = "SELECT *,C.MUID AS MUID FROM MAT_INF A,MAT_GRO B,STO_NUM C,MAT_PRI D WHERE A.JTID_L=${LoginController().JTID} AND A.SYID_L=${LoginController().SYID} "
      " AND A.CIID_L=${LoginController().CIID} $Wheresql2 AND A.MGNO=B.MGNO AND B.MGTY=2 AND B.MGKI=1 "
      " AND B.JTID_L=${LoginController().JTID} AND B.SYID_L=${LoginController().SYID} "
      " AND B.CIID_L=${LoginController().CIID} $Wheresql3"
      "  AND EXISTS(SELECT 1 FROM GRO_USR D WHERE D.MGNO=A.MGNO AND D.SUID='${LoginController().SUID}'"
      " AND D.JTID_L=${LoginController().JTID} AND D.SYID_L=${LoginController().SYID} "
      " AND D.CIID_L=${LoginController().CIID} $Wheresql4)"
      " AND C.SIID=$GetSIID AND (C.MGNO=A.MGNO AND C.MINO=A.MINO)"
      " AND C.JTID_L=${LoginController().JTID} AND C.SYID_L=${LoginController().SYID} "
      " AND C.CIID_L=${LoginController().CIID} $Wheresql"
      " AND D.BIID=$GETBIID AND (D.MGNO=A.MGNO AND D.MINO=A.MINO) AND D.MUID=A.MUIDP "
      " AND D.SCID=$GETSCID AND D.JTID_L=${LoginController().JTID} "
      " AND D.SYID_L=${LoginController().SYID} AND D.CIID_L=${LoginController().CIID} $Wheresql4"
      "  ORDER BY A.MGNO,A.MINO";

} else{

  sql = "SELECT * FROM MAT_INF A,MAT_GRO B,MAT_PRI D WHERE A.JTID_L=${LoginController().JTID} AND A.SYID_L=${LoginController().SYID} "
      " AND A.CIID_L=${LoginController().CIID} $Wheresql2 AND A.MGNO=B.MGNO AND B.MGTY=2 AND B.MGKI=1 "
      " AND B.JTID_L=${LoginController().JTID} AND B.SYID_L=${LoginController().SYID} "
      " AND B.CIID_L=${LoginController().CIID} $Wheresql3"
      "  AND EXISTS(SELECT 1 FROM GRO_USR D WHERE D.MGNO=A.MGNO AND D.SUID='${LoginController().SUID}'"
      " AND D.JTID_L=${LoginController().JTID} AND D.SYID_L=${LoginController().SYID} "
      " AND D.CIID_L=${LoginController().CIID} $Wheresql4)"
      " AND D.BIID=$GETBIID AND (D.MGNO=A.MGNO AND D.MINO=A.MINO) AND D.MUID=A.MUIDP "
      " AND D.SCID=$GETSCID AND D.JTID_L=${LoginController().JTID} "
      " AND D.SYID_L=${LoginController().SYID} AND D.CIID_L=${LoginController().CIID} $Wheresql4"
      "  ORDER BY A.MGNO,A.MINO ";
  }

  var result = await dbClient!.rawQuery(sql);
  List<Mat_Inf_Local> list = result.map((item) {
    return Mat_Inf_Local.fromMap(item);
  }).toList();
  return list;
}

Future<List<Sto_Num_Local>> GET_COUNT_STO_NUM(String GetSIID,String GetMGNO,String GetMINO,
    String GetMUID,String GetSNED) async {
  var dbClient = await conn.database;
  String sql;
  String Wheresql='';
  LoginController().BIID_ALL_V=='1'? Wheresql= " AND BIID_L=${LoginController().BIID}":Wheresql='';
//AND SNDE=$GetSNED
  sql = " SELECT COUNT(*) AS COUNT_SNNO,SNNO,SNED FROM STO_NUM  WHERE  SIID=$GetSIID AND MGNO='$GetMGNO' AND MINO='$GetMINO' "
      " AND MUID=$GetMUID  AND JTID_L=${LoginController().JTID} AND SYID_L=${LoginController().SYID} "
      " AND CIID_L=${LoginController().CIID} $Wheresql ORDER BY SIID LIMIT 1";
  var result = await dbClient!.rawQuery(sql);
  List<Sto_Num_Local> list = result.map((item) {
    return Sto_Num_Local.fromMap(item);
  }).toList();
  return list;
}


Future<int> updateSTO_MOV_M(int id, String UPBIID, String UPSIID,
    int GETSMMST,String? UPAANO,String? UPSUCH,String? UPDATEU,String? UPDEVU,String? UPACNO) async {
  var dbClient = await conn.database;
  final data = {'BIID': UPBIID, 'SIID': UPSIID, 'SMMST': GETSMMST,'AANO': UPAANO,'SUCH':UPSUCH,'DATEU':UPDATEU,
    'DEVU':UPDEVU,'ACNO':UPACNO };
  final result = await dbClient!.update('STO_MOV_M', data, where: 'SMMID=?', whereArgs: [id]);
  return result;
}



Future<List<Sto_Num_Local>> GETSTO_SNNO(int GETSIID,String StringMGNO,String StringMINO,String IntMUID,String USESMDED,
    String GETSMDED) async {
  var dbClient = await conn.database;
  String sql;
  String sqlSMDED='';
  String Wheresql='';
  LoginController().BIID_ALL_V=='1'? Wheresql= " AND BIID_L=${LoginController().BIID}":Wheresql='';
  if( USESMDED=='1') {
    sqlSMDED=" AND  SNED='$GETSMDED'";
  }
  sql = "SELECT * FROM STO_NUM WHERE SIID=$GETSIID AND  MGNO='$StringMGNO' AND MINO='$StringMINO' "
      " AND MUID=$IntMUID  $sqlSMDED  AND JTID_L=${LoginController().JTID} "
      " AND SYID_L=${LoginController().SYID} AND CIID_L=${LoginController().CIID} $Wheresql"
      "  ORDER BY SIID   LIMIT 1";
  var result = await dbClient!.rawQuery(sql);
  List<Sto_Num_Local> list = result.map((item) {
    return Sto_Num_Local.fromMap(item);
  }).toList();
  return list;
}

Future<List<Sto_Num_Local>> GETSTO_NUM(int GETSIID,String StringMGNO,String StringMINO,String IntMUID,String USESMDED,
    String GETSMDED) async {
  var dbClient = await conn.database;
  String sql;
  String sqlSMDED='';
  String Wheresql='';
  String Wheresql2='';
  String Wheresql3='';
  LoginController().BIID_ALL_V=='1'? Wheresql= " AND A.BIID_L=${LoginController().BIID}":Wheresql='';
  LoginController().BIID_ALL_V=='1'? Wheresql2= " AND B.BIID_L=${LoginController().BIID}":Wheresql='';
  LoginController().BIID_ALL_V=='1'? Wheresql3= " AND C.BIID_L=${LoginController().BIID}":Wheresql='';

  if( USESMDED=='1'){
    sqlSMDED=" AND  A.SNED='$GETSMDED'";
  }

  sql = "SELECT * FROM STO_NUM A,MAT_GRO B,MAT_UNI C WHERE "
      "A.SIID=$GETSIID AND  A.MGNO=B.MGNO AND A.MUID=C.MUID AND "
      "A.MGNO='$StringMGNO' AND A.MINO='$StringMINO' "
      " AND A.MUID=$IntMUID  $sqlSMDED   AND A.JTID_L=${LoginController().JTID} "
      " AND A.SYID_L=${LoginController().SYID} AND A.CIID_L=${LoginController().CIID} $Wheresql"
      " AND B.JTID_L=${LoginController().JTID} "
      " AND B.SYID_L=${LoginController().SYID} AND B.CIID_L=${LoginController().CIID} $Wheresql2 "
      " AND C.JTID_L=${LoginController().JTID} "
      " AND C.SYID_L=${LoginController().SYID} AND C.CIID_L=${LoginController().CIID} $Wheresql3"
      " ORDER BY A.SIID   LIMIT 1";
  var result = await dbClient!.rawQuery(sql);
  List<Sto_Num_Local> list = result.map((item) {
    return Sto_Num_Local.fromMap(item);
  }).toList();
  return list;
}

Future<List<STO_MOV_M_Local>> GETSTO_MOV_M(int GET_SMKID,String TYPE,String GETDateNow,int TYPE_MOV) async {
  var dbClient = await conn.database;
  String sql;
  String sql2='';
  String sql3='';
  String sql4='';
  String sql5='';
  if(LoginController().BIID_ALL_V=='1'){
    sql2= "  A.BIID_L=${LoginController().BIID}  AND ";
  }

  if( TYPE=='DateNow' || TYPE=='FromDate' ){
    sql3=" A.SMMDO like'%$GETDateNow%' AND";
  }

  TYPE_MOV==-1?sql4=' AND A.BKID=-1  AND A.BMMID=-1 ':sql4=' AND A.BKID is null  AND A.BMMID is null ';

  String Wheresql='';
  String Wheresql2='';
  String Wheresql3='';
  String Wheresql4='';
  String Wheresql5='';
  String Wheresql6='';
  String Wheresql7='';
  String sqlSIID_T='';
  String sqlSIID_T2='';
  String sqlSIID_T3='';
  LoginController().BIID_ALL_V=='1'? Wheresql= " AND B.BIID_L=${LoginController().BIID}":Wheresql='';
  LoginController().BIID_ALL_V=='1'? Wheresql2= " AND S.BIID_L=${LoginController().BIID}":Wheresql2='';
  LoginController().BIID_ALL_V=='1'? Wheresql3= " AND D.BIID_L=${LoginController().BIID}":Wheresql3='';
  LoginController().BIID_ALL_V=='1'? Wheresql4= " AND F.BIID_L=${LoginController().BIID}":Wheresql4='';
  LoginController().BIID_ALL_V=='1'? Wheresql5= " AND C.BIID_L=${LoginController().BIID}":Wheresql5='';
  LoginController().BIID_ALL_V=='1'? Wheresql6= " AND E.BIID_L=${LoginController().BIID}":Wheresql6='';
  LoginController().BIID_ALL_V=='1'? Wheresql7= " AND T.BIID_L=${LoginController().BIID}":Wheresql7='';

  GET_SMKID==131? sql5=' AND A.BIID!=A.BIIDT ':sql5=' AND A.BIIDT is null';
  GET_SMKID==131 ? GET_SMKID=13 :GET_SMKID;

  GET_SMKID==13 ||  GET_SMKID==11?sqlSIID_T=' , STO_INF E ':sqlSIID_T='';
  GET_SMKID==13 ||  GET_SMKID==11?sqlSIID_T3=' CASE WHEN ${LoginController().LAN}=2 AND E.SINE IS NOT NULL THEN E.SINE ELSE E.SINA END  SIIDT_D, ':sqlSIID_T3='';
  GET_SMKID==13 ||  GET_SMKID==11?sqlSIID_T2=" AND E.SIID=A.SIIDT  AND  E.JTID_L=${LoginController().JTID} AND E.SYID_L=${LoginController().SYID} AND  "
      " E.CIID_L='${LoginController().CIID}' $Wheresql6 ":sqlSIID_T2='';

  if(GET_SMKID==17 || GET_SMKID==13 || GET_SMKID==11){
    sql = "SELECT A.*,CASE WHEN ${LoginController().LAN}=2 AND B.BINE IS NOT NULL THEN B.BINE ELSE B.BINA END  BINA_D,"
        " CASE WHEN ${LoginController().LAN}=2 AND S.SINE IS NOT NULL THEN S.SINE ELSE S.SINA END  SINA_D,"
        " CASE WHEN ${LoginController().LAN}=2 AND T.SCNE IS NOT NULL THEN T.SCNE ELSE T.SCNA END  SCNA_D, $sqlSIID_T3 "
        " B.BIID,B.BINA,S.SIID,S.SINA "
        " FROM STO_MOV_M A,BRA_INF B,STO_INF S,SYS_CUR T $sqlSIID_T "
        " WHERE A.SMKID=$GET_SMKID  $sql5 AND $sql3 A.JTID_L=${LoginController().JTID} "
        " AND A.SYID_L=${LoginController().SYID} AND  A.CIID_L='${LoginController().CIID}' AND $sql2"
        " B.BIID=A.BIID AND S.SIID=A.SIID"
        " AND B.JTID_L=${LoginController().JTID} "
        " AND B.SYID_L=${LoginController().SYID} AND B.CIID_L=${LoginController().CIID} $Wheresql "
        " AND S.JTID_L=${LoginController().JTID} "
        " AND S.SYID_L=${LoginController().SYID} AND S.CIID_L=${LoginController().CIID} $Wheresql2 "
        " AND T.SCID=A.SCID AND  T.JTID_L=${LoginController().JTID} "
        " AND T.SYID_L=${LoginController().SYID} AND T.CIID_L=${LoginController().CIID} $Wheresql7 "
        " $sqlSIID_T2 "
        " ORDER BY A.SMMNO DESC";
  }
  else{

    sql = "SELECT A.*,CASE WHEN ${LoginController().LAN}=2 AND B.BINE IS NOT NULL THEN B.BINE ELSE B.BINA END  BINA_D,"
        "CASE WHEN ${LoginController().LAN}=2 AND S.SINE IS NOT NULL THEN S.SINE ELSE S.SINA END  SINA_D,"
        " CASE WHEN ${LoginController().LAN}=2 AND D.AANE IS NOT NULL THEN D.AANE ELSE D.AANA END  AANA_D,"
        "CASE WHEN ${LoginController().LAN}=2 AND F.SCNE IS NOT NULL THEN F.SCNE ELSE F.SCNA END  SCNA_D,"
        "B.BIID,B.BINA,S.SIID,S.SINA "
        " FROM STO_MOV_M A ,ACC_ACC D,BRA_INF B,STO_INF S,SYS_CUR F "
        " WHERE A.SMKID=$GET_SMKID $sql4  AND  $sql3 A.JTID_L=${LoginController().JTID} "
        " AND A.SYID_L=${LoginController().SYID} AND  A.CIID_L='${LoginController().CIID}' AND $sql2"
        " B.BIID=A.BIID AND S.SIID=A.SIID"
        " AND B.JTID_L=${LoginController().JTID} "
        " AND B.SYID_L=${LoginController().SYID} AND B.CIID_L=${LoginController().CIID} $Wheresql"
        " AND S.JTID_L=${LoginController().JTID} "
        " AND S.SYID_L=${LoginController().SYID} AND S.CIID_L=${LoginController().CIID} $Wheresql2"
        " AND D.AANO=A.AANO  AND D.JTID_L=${LoginController().JTID} "
        " AND D.SYID_L=${LoginController().SYID} AND D.CIID_L=${LoginController().CIID} $Wheresql3"
        " AND F.SCID=A.SCID AND F.JTID_L=${LoginController().JTID} "
        " AND F.SYID_L=${LoginController().SYID} AND F.CIID_L=${LoginController().CIID} $Wheresql4"
        " ORDER BY A.SMMNO DESC";
  }
  final result = await dbClient!.rawQuery(sql);
  return result.map((json) => STO_MOV_M_Local.fromMap(json)).toList();
}


Future<int> UpdateSTO_MOV_M(int id, String UPBIID, String UPSIID,String GETSIIDT,
    int GETSMMST,String? GETAANO,String? GETAANA,double GETSMMAM,String GETSCID,double GETSCEX,
    double GETSMMEQ,String? UPSMMIN,String? UPSUCH,String? UPDATEU,String? UPDEVU,String? UPACNO) async {
  var dbClient = await conn.database;
  final data = {'BIID': UPBIID, 'SIID': UPSIID, 'SMMST': GETSMMST,'SMMIN': UPSMMIN,'ACNO': UPACNO,
    'AANO': GETAANO,'AANO2': GETAANA, 'SUCH':UPSUCH,'DATEU':UPDATEU,'DEVU':UPDEVU,};
  final result =
  await dbClient!.update('STO_MOV_M', data, where: 'SMMID=?', whereArgs: [id]);
  return result;
}

Future<int> DeleteSTO_MOV_DOne(String DELSMMID, String DELSMDID) async {
  var dbClient = await conn.database;
  return await dbClient!.delete(
      'STO_MOV_D', where: 'SMMID=? AND SMDID=?', whereArgs: [DELSMMID, DELSMDID]);
}

Future<List<Mat_Gro_Local>> GETGRO_INF() async {
  var dbClient = await conn.database;
  String sql;
  String Wheresql='';
  String Wheresql2='';
  String Wheresql3='';
  LoginController().BIID_ALL_V=='1'? Wheresql= " AND A.BIID_L=${LoginController().BIID}":Wheresql='';
  LoginController().BIID_ALL_V=='1'? Wheresql2= " AND B.BIID_L=${LoginController().BIID}":Wheresql='';
  LoginController().BIID_ALL_V=='1'? Wheresql3= " AND C.BIID_L=${LoginController().BIID}":Wheresql3='';

  sql ="SELECT *,CASE WHEN ${LoginController().LAN}=2 AND A.MGNE IS NOT NULL THEN A.MGNE ELSE A.MGNA END  MGNA_D"
      " FROM MAT_GRO A WHERE A.MGST=1 AND A.MGTY=2 AND A.MGKI=1 "
      " AND A.JTID_L=${LoginController().JTID} "
      " AND A.SYID_L=${LoginController().SYID} AND A.CIID_L=${LoginController().CIID} $Wheresql"
      " AND EXISTS(SELECT 1 FROM GRO_USR B WHERE B.MGNO=A.MGNO AND B.SUID=${LoginController().SUID}"
      " AND B.JTID_L=${LoginController().JTID} "
      " AND B.SYID_L=${LoginController().SYID} AND B.CIID_L=${LoginController().CIID} $Wheresql2)"
      "  AND EXISTS(SELECT 1 FROM MAT_INF C WHERE C.MGNO=A.MGNO"
      " AND C.JTID_L=${LoginController().JTID} "
      " AND C.SYID_L=${LoginController().SYID} AND C.CIID_L=${LoginController().CIID} $Wheresql3) ORDER BY A.MGNO";
  final result = await dbClient!.rawQuery(sql);
  return result.map((json) => Mat_Gro_Local.fromMap(json)).toList();
}

Future<List<Mat_Uni_C_Local>> GETMAT_UNI_C(String StringMGNO,String StringMINO) async {
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
  //if (result.isEmpty) return null;
  List<Mat_Uni_C_Local> list = result.map((item) {
    return Mat_Uni_C_Local.fromMap(item);
  }).toList();
  return list;
}

Future<List<Sto_Inf_Local>> GETSTO_INF(String StringBIID) async {
  var dbClient = await conn.database;
  String sql;
  String Wheresql='';
  String Wheresql2='';
  LoginController().BIID_ALL_V=='1'? Wheresql= " AND A.BIID_L=${LoginController().BIID}":Wheresql='';
  LoginController().BIID_ALL_V=='1'? Wheresql2= " AND B.BIID_L=${LoginController().BIID}":Wheresql2='';
  sql = "SELECT *,CASE WHEN ${LoginController().LAN}=2 AND A.SINE IS NOT NULL THEN A.SINE ELSE A.SINA END  SINA_D"
      " FROM STO_INF A where A.SIST=1 AND  A.BIID=$StringBIID  "
      " AND A.JTID_L=${LoginController().JTID} AND A.SYID_L=${LoginController().SYID} "
      " AND A.CIID_L=${LoginController().CIID} $Wheresql AND"
      " EXISTS(SELECT 1 FROM STO_USR B WHERE  B.SIID=A.SIID AND B.SUID IS NOT NULL AND SUID=${LoginController().SUID}"
      " AND B.JTID_L=${LoginController().JTID} AND B.SYID_L=${LoginController().SYID} "
      " AND B.CIID_L=${LoginController().CIID} $Wheresql2) ORDER BY A.SIID ";
  //sql = "SELECT * FROM STO_INF A,STO_NUM B where A.SIID(+)=B.SIID AND A.$BIID=$StringBIID";
  var result = await dbClient!.rawQuery(sql);
  // if (result.isEmpty) return null;
  List<Sto_Inf_Local> list = result.map((item) {
    return Sto_Inf_Local.fromMap(item);
  }).toList();
  return list;
}

Future<List<Sto_Mov_D_Local>> GETSTO_MOV_D(int SMMIDNUM,String GETMINA) async {
  var dbClient = await conn.database;
  //List<Map> maps = await dbClient!.query(STO_MOV_D_TABLE, columns: [SMDID, MINO,MUID,SMDNO]);
  String sql;
  String sql2='';
  String Wheresql='';
  String Wheresql2='';
  String Wheresql3='';
  String Wheresql4='';
  LoginController().BIID_ALL_V=='1'? Wheresql= " AND A.BIID_L=${LoginController().BIID}":Wheresql='';
  LoginController().BIID_ALL_V=='1'? Wheresql2= " AND B.BIID_L=${LoginController().BIID}":Wheresql='';
  LoginController().BIID_ALL_V=='1'? Wheresql3= " AND C.BIID_L=${LoginController().BIID}":Wheresql3='';
  LoginController().BIID_ALL_V=='1'? Wheresql4= " AND D.BIID_L=${LoginController().BIID}":Wheresql4='';

  if(GETMINA.isNotEmpty || GETMINA!=''){
    sql2=" AND B.MINA LIKE '%$GETMINA%' ";
  }

  sql ="SELECT *,CASE WHEN ${LoginController().LAN}=2 AND B.MINE IS NOT NULL AND "
      "  C.MUNE IS NOT NULL THEN B.MINE||'-'||C.MUNE ELSE B.MINA||'-'||C.MUNA END  NAM,"
      " CASE WHEN ${LoginController().LAN}=2 AND B.MINE IS NOT NULL  THEN B.MINE ELSE B.MINA END  MINA_D,"
      " CASE WHEN ${LoginController().LAN}=2 AND C.MUNE IS NOT NULL  THEN C.MUNE ELSE C.MUNA END  MUNA_D, "
      " CASE WHEN ${LoginController().LAN}=2 AND D.MGNE IS NOT NULL  THEN D.MGNE ELSE D.MGNA END  MGNA "
      " FROM STO_MOV_D A,MAT_INF B,MAT_UNI C ,MAT_GRO D"
      " where A.MINO=B.MINO AND A.MGNO=D.MGNO AND C.MUID=A.MUID AND B.MGNO=A.MGNO AND SMMID=$SMMIDNUM  $sql2"
      " AND A.JTID_L=${LoginController().JTID} "
      " AND A.SYID_L=${LoginController().SYID} AND A.CIID_L=${LoginController().CIID} $Wheresql"
      " AND B.JTID_L=${LoginController().JTID} "
      " AND B.SYID_L=${LoginController().SYID} AND B.CIID_L=${LoginController().CIID} $Wheresql2"
      " AND C.JTID_L=${LoginController().JTID} "
      " AND C.SYID_L=${LoginController().SYID} AND C.CIID_L=${LoginController().CIID} $Wheresql3"
      " AND D.JTID_L=${LoginController().JTID} "
      " AND D.SYID_L=${LoginController().SYID} AND D.CIID_L=${LoginController().CIID} $Wheresql4";

  var result = await dbClient!.rawQuery(sql);
  List<Sto_Mov_D_Local> list = result.map((item) {
    return Sto_Mov_D_Local.fromMap(item);
  }).toList();
  return list;
}


Future<List<Sto_Inf_Local>> GET_STO_INF_ONE(String GETBIID) async {
  var dbClient = await conn.database;
  String sql;
  String Wheresql='';
  String Wheresql2='';
  LoginController().BIID_ALL_V=='1'? Wheresql= " AND A.BIID_L=${LoginController().BIID}":Wheresql='';
  LoginController().BIID_ALL_V=='1'? Wheresql2= " AND B.BIID_L=${LoginController().BIID}":Wheresql2='';
  sql = "SELECT A.SIID,CASE WHEN ${LoginController().LAN}=2 AND A.SINE IS NOT NULL THEN A.SINE ELSE A.SINA END  SINA_D"
      " FROM STO_INF A where A.BIID=$GETBIID  and A.SIST=1  AND "
      "  A.JTID_L=${LoginController().JTID} AND A.SYID_L=${LoginController().SYID} "
      " AND A.CIID_L=${LoginController().CIID} $Wheresql AND"
      " EXISTS(SELECT 1 FROM STO_USR B WHERE  B.SIID=A.SIID AND B.SUID IS NOT NULL AND B.SUID=${LoginController().SUID}"
      " AND B.JTID_L=${LoginController().JTID} AND B.SYID_L=${LoginController().SYID} "
      " AND B.CIID_L=${LoginController().CIID} $Wheresql2) ORDER BY A.SIID LIMIT 1 ";
  var result = await dbClient!.rawQuery(sql);
  List<Sto_Inf_Local> list = result.map((item) {
    return Sto_Inf_Local.fromMap(item);
  }).toList();
  return list;
}

Future<List<Sto_Inf_Local>> FROM_STO_INF(String GETBIID) async {
  var dbClient = await conn.database;
  String sql;
  String Wheresql='';
  String Wheresql2='';
  LoginController().BIID_ALL_V=='1'? Wheresql= " AND A.BIID_L=${LoginController().BIID}":Wheresql='';
  LoginController().BIID_ALL_V=='1'? Wheresql2= " AND B.BIID_L=${LoginController().BIID}":Wheresql2='';
  sql = "SELECT *,CASE WHEN ${LoginController().LAN}=2 AND A.SINE IS NOT NULL THEN A.SINE ELSE A.SINA END  SINA_D"
      " FROM STO_INF A where A.BIID=$GETBIID  and A.SIST=1  AND "
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

Future<List<Sto_Inf_Local>> TO_STO_INF(String GETBIID,String GET_SIID) async {
  var dbClient = await conn.database;
  String sql;
  String Wheresql='';
  String Wheresql2='';
  LoginController().BIID_ALL_V=='1'? Wheresql= " AND A.BIID_L=${LoginController().BIID}":Wheresql='';
  LoginController().BIID_ALL_V=='1'? Wheresql2= " AND B.BIID_L=${LoginController().BIID}":Wheresql2='';
  sql = "SELECT *,CASE WHEN ${LoginController().LAN}=2 AND A.SINE IS NOT NULL THEN A.SINE ELSE A.SINA END  SINA_D"
      " FROM STO_INF A where  A.BIID=$GETBIID  and A.SIID!=$GET_SIID and A.SIST=1   "
      " AND A.JTID_L=${LoginController().JTID} AND A.SYID_L=${LoginController().SYID} "
      " AND A.CIID_L=${LoginController().CIID} $Wheresql AND "
      " EXISTS(SELECT 1 FROM STO_USR B WHERE  B.SIID=A.SIID AND B.SUID IS NOT NULL AND B.SUID=${LoginController().SUID}"
      " AND B.JTID_L=${LoginController().JTID} AND B.SYID_L=${LoginController().SYID} "
      " AND B.CIID_L=${LoginController().CIID} $Wheresql2) ORDER BY A.SIID ";

  var result = await dbClient!.rawQuery(sql);
  List<Sto_Inf_Local> list = result.map((item) {
    return Sto_Inf_Local.fromMap(item);
  }).toList();
  return list;
}

Future<List<Sto_Mov_D_Local>> SUM_SMMAM(int GetSMMID) async {
  var dbClient = await conn.database;
  String sql;
  String Wheresql='';
  LoginController().BIID_ALL_V=='1'? Wheresql= " AND  BIID_L=${LoginController().BIID}":Wheresql='';
  sql = "select  ifnull(sum(SMDAMT+SMDAMTF),0.0) AS SUM_SMDAM  from STO_MOV_D where SMMID=$GetSMMID "
      " AND JTID_L=${LoginController().JTID} "
      " AND SYID_L=${LoginController().SYID} AND CIID_L='${LoginController().CIID}' $Wheresql";
  var result = await dbClient!.rawQuery(sql);
  List<Sto_Mov_D_Local> list = result.map((item) {
    return Sto_Mov_D_Local.fromMap(item);
  }).toList();
  return list;
}


Future<List<Sto_Mov_D_Local>> SUM_SMMAM2(int GetSMMID) async {
  var dbClient = await conn.database;
  String sql;
  String Wheresql='';
  LoginController().BIID_ALL_V=='1'? Wheresql= " AND  BIID_L=${LoginController().BIID}":Wheresql='';
  sql = "select  ifnull(sum(SMDAMT),0.0) AS SUM_TOTSMDAM  from STO_MOV_D where SMMID=$GetSMMID"
      " AND JTID_L=${LoginController().JTID} "
      " AND SYID_L=${LoginController().SYID} AND CIID_L='${LoginController().CIID}' $Wheresql";
  var result = await dbClient!.rawQuery(sql);
  List<Sto_Mov_D_Local> list = result.map((item) {
    return Sto_Mov_D_Local.fromMap(item);
  }).toList();
  return list;
}

Future<List<Sto_Mov_D_Local>> SUM_SMMDIF(int GetSMMID) async {
  var dbClient = await conn.database;
  String sql;
  String Wheresql='';
  LoginController().BIID_ALL_V=='1'? Wheresql= " AND  BIID_L=${LoginController().BIID}":Wheresql='';
  sql = "select  ifnull(sum(SMDAMTF),0.0) AS SMMDIF  from STO_MOV_D where SMMID=$GetSMMID "
      " AND JTID_L=${LoginController().JTID} "
      " AND SYID_L=${LoginController().SYID} AND CIID_L='${LoginController().CIID}' $Wheresql";;
  var result = await dbClient!.rawQuery(sql);
  List<Sto_Mov_D_Local> list = result.map((item) {
    return Sto_Mov_D_Local.fromMap(item);
  }).toList();
  return list;
}


Future<List<Sys_Cur_Local>> GET_SYS_CUR_ONE_STO() async {
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
  sql = " select  ifnull(MUCNO,0.0) AS MUCNO from MAT_UNI_C where MGNO='$GETMGNO' AND MINO='$GETMINO' AND MUCID=$GETMUCID"
      " AND JTID_L=${LoginController().JTID} AND SYID_L=${LoginController().SYID} AND CIID_L=${LoginController().CIID} $Wheresql";
  var result = await dbClient!.rawQuery(sql);
  List<Mat_Uni_C_Local> list = result.map((item) {
    return Mat_Uni_C_Local.fromMap(item);
  }).toList();
  return list;
}

Future<List<STO_MOV_M_Local>> GET_STO_MOV_M_PRINT(int GET_SMKID,int GETSMMID) async {
  var dbClient = await conn.database;
  String sql;
  String Wheresql='';
  String Wheresql2='';
  String Wheresql3='';
  String Wheresql6='';
  String Wheresql7='';
  String sqlSIID_T='';
  String sqlSIID_T2='';
  String sqlSIID_T3='';
  LoginController().BIID_ALL_V=='1'? Wheresql= " AND  A.BIID_L=${LoginController().BIID}":Wheresql='';
  LoginController().BIID_ALL_V=='1'? Wheresql2= " AND  B.BIID_L=A.BIID_L ":Wheresql2='';
  LoginController().BIID_ALL_V=='1'? Wheresql3= " AND  C.BIID_L=A.BIID_L ":Wheresql3='';
  LoginController().BIID_ALL_V=='1'? Wheresql7= " AND  S.BIID_L=A.BIID_L ":Wheresql7='';
  LoginController().BIID_ALL_V=='1'? Wheresql6= " AND  E.BIID_L=A.BIID_L ":Wheresql6='';

  GET_SMKID==13 || GET_SMKID==11 || GET_SMKID==131?sqlSIID_T=' , STO_INF E ':sqlSIID_T='';
  GET_SMKID==13 || GET_SMKID==11 || GET_SMKID==131?sqlSIID_T3=' CASE WHEN ${LoginController().LAN}=2 AND E.SINE IS NOT NULL THEN E.SINE ELSE E.SINA END  SIIDT_D, ':sqlSIID_T3='';
  GET_SMKID==13 || GET_SMKID==11 || GET_SMKID==131?sqlSIID_T2=" AND E.SIID=A.SIIDT  AND  E.JTID_L=${LoginController().JTID} AND E.SYID_L=${LoginController().SYID} AND  "
      " E.CIID_L='${LoginController().CIID}' $Wheresql6 ":sqlSIID_T2='';

  sql = "SELECT *,CASE WHEN ${LoginController().LAN}=2 AND B.BINE IS NOT NULL THEN B.BINE ELSE B.BINA END  BINA_D,"
      " CASE WHEN ${LoginController().LAN}=2 AND S.SINE IS NOT NULL THEN S.SINE ELSE S.SINA END  SINA_D,"
      " $sqlSIID_T3 "
      " CASE WHEN ${LoginController().LAN}=2 AND C.SCNE IS NOT NULL THEN C.SCNE ELSE C.SCNA END  SCNA_D"
      " FROM STO_MOV_M A,BRA_INF B,STO_INF S,SYS_CUR C $sqlSIID_T "
      " WHERE A.SMMID=$GETSMMID and A.JTID_L=${LoginController().JTID} "
      " AND A.SYID_L=${LoginController().SYID} AND A.CIID_L='${LoginController().CIID}' $Wheresql "
      " AND B.BIID=A.BIID AND B.JTID_L=A.JTID_L "
      " AND B.SYID_L=A.SYID_L AND B.CIID_L=A.CIID_L $Wheresql2 "
      " AND S.SIID=A.SIID AND S.JTID_L=A.JTID_L "
      " AND S.SYID_L=A.SYID_L AND S.CIID_L=A.CIID_L $Wheresql7"
      " AND C.SCID=A.SCID AND C.JTID_L=A.JTID_L "
      " AND C.SYID_L=A.SYID_L AND C.CIID_L=A.CIID_L $Wheresql3"
      " $sqlSIID_T2 "
      "  ORDER BY A.SMMID DESC";
  var result = await dbClient!.rawQuery(sql);
  List<STO_MOV_M_Local> list = result.map((item) {
    return STO_MOV_M_Local.fromMap(item);
  }).toList();
  return list;
}

Future<List<Bra_Inf_Local>> GET_BRA_T(String GETBIID) async {
  var dbClient = await conn.database;
  String sql;
  String Wheresql='';
  String Wheresql2='';
  LoginController().BIID_ALL_V=='1'? Wheresql= " AND  A.BIID_L=${LoginController().BIID}":Wheresql='';
  LoginController().BIID_ALL_V=='1'? Wheresql2= " AND  B.BIID_L=${LoginController().BIID}":Wheresql2='';

  sql = "SELECT *,CASE WHEN ${LoginController().LAN}=2 AND BINE IS NOT NULL THEN BINE ELSE BINA END  BINA_D"
      " FROM BRA_INF A WHERE A.BIST=1 AND BIID!=$GETBIID AND A.JTID_L=${LoginController().JTID} "
      "AND A.SYID_L=${LoginController().SYID} AND A.CIID_L=${LoginController().CIID} $Wheresql"
      " AND EXISTS(SELECT 1 FROM SYS_USR_B B WHERE B.BIID IS NOT NULL "
      " AND B.BIID=A.BIID AND B.SUID IS NOT NULL AND B.SUID=${LoginController().SUID} AND B.SUBST=1 AND B.SUBIN=1"
      " AND B.JTID_L=${LoginController().JTID} "
      " AND B.SYID_L=${LoginController().SYID} AND B.CIID_L=${LoginController().CIID} $Wheresql2)"
      " ORDER BY A.BIID";
  var result = await dbClient!.rawQuery(sql);
  // if (result.isEmpty) return null;
  List<Bra_Inf_Local> list = result.map((item) {
    return Bra_Inf_Local.fromMap(item);
  }).toList();
  return list;
}

Future<List<Mat_Uni_C_Local>> fetchMAT_UIN_C(String GETMGNO, String GETMINO, int MUCID_F, int MUCID_T) async {
  var dbClient = await conn.database;
  List<Mat_Uni_C_Local> contactList = [];
  try {
    final maps = await dbClient!.query('MAT_UNI_C',
        where:
        " MGNO='$GETMGNO' AND MINO='$GETMINO' AND MUCID>=$MUCID_F AND  MUCID<=$MUCID_T ");
    for (var item in maps) {
      contactList.add(Mat_Uni_C_Local.fromMap(item));
    }
  } catch (e) {
    print(e.toString());
  }
  return contactList;
}

Future<List<Acc_Acc_Local>> GETAANOCOUNT(String GETAANO) async {
  var dbClient = await conn.database;
  String Wheresql='';
  LoginController().BIID_ALL_V=='1'? Wheresql= " AND BIID_L=${LoginController().BIID}":Wheresql='';
  String sql;
  sql = "select CASE WHEN ${LoginController().LAN}=2 AND AANE IS NOT NULL THEN AANE ELSE AANA END  AANA_D "
      " from ACC_ACC where  AANO='$GETAANO'"
      " AND JTID_L=${LoginController().JTID} AND SYID_L=${LoginController().SYID} AND CIID_L=${LoginController().CIID} $Wheresql";
  final result = await dbClient!.rawQuery(sql);
  List<Acc_Acc_Local> list = result.map((item) {
    return Acc_Acc_Local.fromMap(item);
  }).toList();
  return list;
}

