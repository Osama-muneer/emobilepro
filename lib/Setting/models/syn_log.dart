import '../../Setting/controllers/login_controller.dart';

class Syn_Log_Local {
  String? SLDO;
  String? SLIN;
  String? SLTY;
  String? SUID;
  int? STMSQ;
  int? SMID;
  String? STMID;
  String? GUID;
  String? SOTT;
  String? SOTY;
  String? SLC1;
  int? CIID;
  int? JTID;
  int? BIID;
  int? SYID;
  int? SOMID;
  String? SYDV_NAME;
  String? SYDV_IP;
  String? SYDV_SER;
  String? SYDV_POI;
  String? SYDV_NO;
  String? SYDV_LATITUDE;
  String? SYDV_LONGITUDE;
  String? SYDV_APPV;
  String? SYDV_APIV;
  String? SYDV_TY;
  int? SDSQ;
  int? SLTY2;
  String? SLIT2;
  String? SLSC2;
  String? SLTYP;
  String? SLC2;
  String? SLC3;
  int? JTID_L;
  int? BIID_L;
  int? SYID_L;
  String? CIID_L;
  String? SYDV_ID;
  String? SYDV_GU;
  String? SOGU;
  int? SLSQ;
  int? COUNTROW;

  Syn_Log_Local({ this.SLDO, this.SLIN,this.SLTY,this.SUID,this.STMSQ,this.SMID,this.STMID,
    this.GUID,this.SOTT,this.SOTY,this.SLC1,this.CIID,this.JTID,this.BIID,this.SYID,this.SOMID,this.SYDV_NAME,this.SYDV_IP
    ,this.SYDV_SER,this.SYDV_POI,this.SYDV_NO,this.SYDV_LATITUDE,this.SYDV_LONGITUDE,this.SYDV_APPV,this.SYDV_APIV,this.SYDV_TY,
    this.SDSQ,this.SLTY2,this.SLTYP,this.SLC2,this.SLC3,this.SYDV_ID,this.SYDV_GU,this.SOGU,this.SLSQ
    ,this.SLIT2,this.SLSC2,this.JTID_L,this.SYID_L,this.BIID_L,this.CIID_L,this.COUNTROW});

  Map<String, dynamic> toMap() {
    var map = <String, dynamic>{
      'SLDO': SLDO,
      'SLIN': SLIN,
      'SLTY': SLTY,
      'SUID': SUID,
      'STMSQ': STMSQ,
      'SMID': SMID,
      'STMID': STMID,
      'GUID': GUID,
      'SOTT': SOTT,
      'SOTY': SOTY,
      'SLC1': SLC1,
      'CIID': CIID,
      'JTID': JTID,
      'BIID': BIID,
      'SYID': SYID,
      'SOMID': SOMID,
      'SYDV_NAME': SYDV_NAME,
      'SYDV_IP': SYDV_IP,
      'SYDV_SER': SYDV_SER,
      'SYDV_POI': SYDV_POI,
      'SYDV_NO': SYDV_NO,
      'SYDV_LATITUDE': SYDV_LATITUDE,
      'SYDV_LONGITUDE': SYDV_LONGITUDE,
      'SYDV_APPV': SYDV_APPV,
      'SYDV_APIV': SYDV_APIV,
      'SYDV_TY': SYDV_TY,
      'SDSQ': SDSQ,
      'SLTY2': SLTY2,
      'SLIT2': SLIT2,
      'SLSC2': SLSC2,
      'SLTYP': SLTYP,
      'SLC2': SLC2,
      'SLC3': SLC3,
      'SYDV_ID': SYDV_ID,
      'SYDV_GU': SYDV_GU,
      'SOGU': SOGU,
      'SLSQ': SLSQ,
      'JTID_L': JTID_L ?? LoginController().JTID_L,
      'SYID_L': SYID_L ?? LoginController().SYID_L,
      'BIID_L': BIID_L ?? LoginController().BIID_L,
      'CIID_L': CIID_L ?? LoginController().CIID_L,
    };
    return map;
  }

  Syn_Log_Local.fromMap(Map<dynamic, dynamic> map) {
    SLDO = map['SLDO'];
    SLIN = map['SLIN'];
    SLTY = map['SLTY'];
    SUID = map['SUID'];
    STMSQ = map['STMSQ'];
    SMID = map['SMID'];
    STMID = map['STMID'];
    GUID = map['GUID'];
    SOTT = map['SOTT'];
    SOTY = map['SOTY'];
    SLC1 = map['SLC1'];
    CIID = map['CIID'];
    JTID = map['JTID'];
    BIID = map['BIID'];
    SYID = map['SYID'];
    SOMID = map['SOMID'];
    SYDV_NAME = map['SYDV_NAME'];
    SYDV_IP = map['SYDV_IP'];
    SYDV_SER = map['SYDV_SER'];
    SYDV_POI = map['SYDV_POI'];
    SYDV_NO = map['SYDV_NO'];
    SYDV_LATITUDE = map['SYDV_LATITUDE'];
    SYDV_LONGITUDE = map['SYDV_LONGITUDE'];
    SYDV_APPV = map['SYDV_APPV'];
    SYDV_APIV = map['SYDV_APIV'];
    SYDV_TY = map['SYDV_TY'];
    SDSQ = map['SDSQ'];
    SLTY2 = map['SLTY2'];
    SLIT2 = map['SLIT2'];
    SLSC2 = map['SLSC2'];
    SLTYP = map['SLTYP'];
    SLC2 = map['SLC2'];
    SLC3 = map['SLC3'];
    SYDV_ID = map['SYDV_ID'];
    SYDV_GU = map['SYDV_GU'];
    JTID_L = map['JTID_L'];
    SYID_L = map['SYID_L'];
    BIID_L = map['BIID_L'];
    CIID_L = map['CIID_L'];
    SOGU = map['SOGU'];
    SLSQ = map['SLSQ'];
    COUNTROW = map['COUNTROW'];
  }


}
