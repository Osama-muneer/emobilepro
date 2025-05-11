import 'dart:convert';

class Config_Local {
  int? JTID;
  int? BIID;
  int? SYID;
  int? SYST;
  String? CIID;
  String? DATEI;
  String? LastSyncDate;
  int? CHIKE_ALL;
  String? STMID;
  String? SYDV_NAME;
  String? SYDV_TY;
  String? SYDV_SER;
  String? SYDV_ID;
  String? SYDV_NO;
  String? SYDV_APPV;


  Config_Local({required this.JTID,required this.BIID,required this.SYID,this.SYST,this.CIID,this.DATEI,this.LastSyncDate,
      this.CHIKE_ALL,this.STMID,this.SYDV_NAME,this.SYDV_TY,this.SYDV_SER,this.SYDV_ID,this.SYDV_NO,this.SYDV_APPV});

  Map<String, dynamic> toMap() {
    var map = <String, dynamic>{
      'JTID': JTID,
      'BIID': BIID,
      'SYID': SYID,
      'SYST': SYST,
      'CIID': CIID,
      'DATEI': DATEI,
      'LastSyncDate': LastSyncDate,
      'CHIKE_ALL': CHIKE_ALL,
      'STMID': STMID,
      'SYDV_NAME': SYDV_NAME,
      'SYDV_TY': SYDV_TY,
      'SYDV_SER': SYDV_SER,
      'SYDV_ID': SYDV_ID,
      'SYDV_NO': SYDV_NO,
      'SYDV_APPV': SYDV_APPV,
    };
    return map;
  }

  Config_Local.fromMap(Map<dynamic, dynamic> map) {
    JTID = map['JTID'];
    BIID = map['BIID'];
    SYID = map['SYID'];
    SYST = map['SYST'];
    CIID = map['CIID'];
    DATEI = map['DATEI'];
    LastSyncDate = map['LastSyncDate'];
    CHIKE_ALL = map['CHIKE_ALL'];
    STMID = map['STMID'];
    SYDV_NAME = map['SYDV_NAME'];
    SYDV_TY = map['SYDV_TY'];
    SYDV_SER = map['SYDV_SER'];
    SYDV_ID = map['SYDV_ID'];
    SYDV_NO = map['SYDV_NO'];
    SYDV_APPV = map['SYDV_APPV'];
  }

  String Config_LocalToJson(List<Config_Local> data) =>
      json.encode(List<dynamic>.from(data.map((x) => x.toMap())));
}
