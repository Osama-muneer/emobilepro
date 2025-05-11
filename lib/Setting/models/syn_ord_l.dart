import '../../Setting/controllers/login_controller.dart';

class Syn_Ord_L_Local {
  int? SOLSQ;
  String? SOID;
  String? STMID;
  String? STID;
  String? SOKI;
  String? SOTY;
  String? SOET;
  String? SOFT;
  String? SOTT;
  int? SDSQ;
  String? SDNO;
  String? GUID;
  String? SDTY;
  int? CIID;
  int? JTID;
  int? SYID;
  String? SYDV_NAME;
  String? SYDV_IP;
  String? SYDV_SER;
  String? SYDV_POI;
  String? SYDV_NO;
  String? SYDV_BRA;
  int? SOLST;
  int? BIID;
  int? SOLKI;
  String? SOLDO;
  int? SOLID;
  int? SOLNO;
  var SOLAM;
  String? SOLGU;
  int? BIID2;
  int? SOLKI2;
  String? SOLDO2;
  int? SOLID2;
  int? SOLNO2;
  var SOLAM2;
  String? SOLGU2;
  String? SUID2;
  String? SOLER;
  String? SOLIN;
  int? SOLN1;
  int? SOLN2;
  int? SOLN3;
  int? SMID;
  String? SOLC1;
  String? SOLC2;
  String? SOLC3;
  String? SYDV_LATITUDE;
  String? SYDV_LONGITUDE;
  String? SYDV_APPV;
  String? SYDV_TY;
  String? SYDV_ID;
  String? SYDV_APIV;
  String? SYDV_GU;
  String? SOGU;
  int? SOLNT;
  String? SOLDF;
  String? SUID;
  String? DATEI;
  String? DATEU;
  String? SUCH;
  int? JTID_L;
  int? BIID_L;
  int? SYID_L;
  String? CIID_L;


  Syn_Ord_L_Local({this.SOLSQ,this.SOID,this.STMID,this.STID,this.SOKI,this.SOFT,this.SOET
    ,this.SOTY,this.SOTT,this.SUID,this.SDSQ,this.SDNO,this.SDTY,this.CIID,this.JTID,this.SYID
    ,this.SYDV_NAME,this.SYDV_IP,this.SYDV_POI,this.SYDV_SER,this.SYDV_NO,this.SYDV_BRA,this.SOLST
    ,this.BIID,this.SOLKI,this.SOLDO,this.SOLID,this.SOLNO,this.SOLAM,this.SOLGU,this.BIID2,this.SOLKI2
    ,this.SOLDO2,this.SOLID2,this.SOLNO2,this.SOLAM2,this.SOLGU2,this.SUID2,this.SOLER,this.SOLIN,this.SOLN1
    ,this.SOLN2,this.SOLN3,this.SOLC1,this.SOLC2,this.SOLC3,this.SYDV_LATITUDE,this.SYDV_LONGITUDE,this.SYDV_APPV
    ,this.SMID,this.SYDV_TY,this.SYDV_ID,this.SYDV_APIV,this.SYDV_GU,this.SOGU,this.SOLNT,this.SOLDF
    ,this.SUCH,this.DATEI,this.DATEU,this.JTID_L,this.SYID_L,this.BIID_L,this.CIID_L,this.GUID});


  Map<String, dynamic> toMap() {
    var map = <String, dynamic>{
      'SOLSQ': SOLSQ,
      'SOID': SOID,
      'STMID': STMID,
      'STID': STID,
      'SOKI': SOKI,
      'SOFT': SOFT,
      'SOET': SOET,
      'SOTY': SOTY,
      'SOTT': SOTT,
      'SDSQ': SDSQ,
      'SDNO': SDNO,
      'SDTY': SDTY,
      'CIID': CIID,
      'JTID': JTID,
      'SYID': SYID,
      'SYDV_NAME': SYDV_NAME,
      'SYDV_IP': SYDV_IP,
      'SYDV_SER': SYDV_SER,
      'SYDV_POI': SYDV_POI,
      'SYDV_NO': SYDV_NO,
      'SYDV_BRA': SYDV_BRA,
      'SOLST': SOLST,
      'BIID': BIID,
      'SOLKI': SOLKI,
      'SOLDO': SOLDO,
      'SOLID': SOLID,
      'SOLNO': SOLNO,
      'SOLAM': SOLAM,
      'SOLGU': SOLGU,
      'BIID2': BIID2,
      'SOLKI2': SOLKI2,
      'SOLDO2': SOLDO2,
      'SOLID2': SOLID2,
      'SOLNO2': SOLNO2,
      'SOLAM2': SOLAM2,
      'SOLGU2': SOLGU2,
      'SUID2': SUID2,
      'SOLER': SOLER,
      'SOLIN': SOLIN,
      'SOLN1': SOLN1,
      'SOLN2': SOLN2,
      'SOLN3': SOLN3,
      'SOLC1': SOLC1,
      'SOLC2': SOLC2,
      'SOLC3': SOLC3,
      'SYDV_LATITUDE': SYDV_LATITUDE,
      'SYDV_LONGITUDE': SYDV_LONGITUDE,
      'SYDV_APPV': SYDV_APPV,
      'SMID': SMID,
      'SYDV_TY': SYDV_TY,
      'SYDV_ID': SYDV_ID,
      'SYDV_APIV': SYDV_APIV,
      'SYDV_GU': SYDV_GU,
      'SOGU': SOGU,
      'SOLNT': SOLNT,
      'SOLDF': SOLDF,
      'SUID': SUID,
      'SUCH': SUCH,
      'DATEI': DATEI,
      'DATEU': DATEU,
      'GUID': GUID,
      'JTID_L': JTID_L ?? LoginController().JTID_L,
      'SYID_L': SYID_L ?? LoginController().SYID_L,
      'BIID_L': BIID_L ?? LoginController().BIID_L,
      'CIID_L': CIID_L ?? LoginController().CIID_L,
    };
    return map;
  }

  Syn_Ord_L_Local.fromMap(Map<dynamic, dynamic> map) {
    SOLSQ = map['SOLSQ'];
    SOID = map['SOID'];
    STMID = map['STMID'];
    STID = map['STID'];
    SOKI = map['SOKI'];
    SOTY = map['SOTY'];
    SOET = map['SOET'];
    SOFT = map['SOFT'];
    SOTT = map['SOTT'];
    SDNO = map['SDNO'];
    SDTY = map['SDTY'];
    CIID = map['CIID'];
    JTID = map['JTID'];
    SYID = map['SYID'];
    SYDV_NAME = map['SYDV_NAME'];
    SYDV_IP = map['SYDV_IP'];
    SYDV_SER = map['SYDV_SER'];
    SYDV_POI = map['SYDV_POI'];
    SYDV_NO = map['SYDV_NO'];
    SYDV_BRA = map['SYDV_BRA'];
    SOLST = map['SOLST'];
    BIID = map['BIID'];
    SOLKI = map['SOLKI'];
    SOLDO = map['SOLDO'];
    SOLID = map['SOLID'];
    SOLNO = map['SOLNO'];
    SOLAM = map['SOLAM'];
    SOLGU = map['SOLGU'];
    BIID2 = map['BIID2'];
    SOLKI2 = map['SOLKI2'];
    SOLDO2 = map['SOLDO2'];
    SOLID2 = map['SOLID2'];
    SOLNO2 = map['SOLNO2'];
    SOLAM2 = map['SOLAM2'];
    SOLGU2 = map['SOLGU2'];
    SUID2 = map['SUID2'];
    SOLER = map['SOLER'];
    SOLIN = map['SOLIN'];
    SOLN1 = map['SOLN1'];
    SOLN2 = map['SOLN2'];
    SOLN3 = map['SOLN3'];
    SOLC1 = map['SOLC1'];
    SOLC2 = map['SOLC2'];
    SOLC3 = map['SOLC3'];
    SYDV_LATITUDE = map['SYDV_LATITUDE'];
    SYDV_LONGITUDE = map['SYDV_LONGITUDE'];
    SYDV_APPV = map['SYDV_APPV'];
    SMID = map['SMID'];
    SYDV_TY = map['SYDV_TY'];
    SYDV_ID = map['SYDV_ID'];
    SYDV_APIV = map['SYDV_APIV'];
    SYDV_GU = map['SYDV_GU'];
    SOGU = map['SOGU'];
    SOLNT = map['SOLNT'];
    SOLDF = map['SOLDF'];
    SUID = map['SUID'];
    STID = map['STID'];
    DATEI = map['DATEI'];
    DATEU = map['DATEU'];
    SUCH = map['SUCH'];
    GUID = map['GUID'];
    JTID_L = map['JTID_L'];
    SYID_L = map['SYID_L'];
    BIID_L = map['BIID_L'];
    CIID_L = map['CIID_L'];
  }
}
