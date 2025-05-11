import '../../Setting/controllers/login_controller.dart';

class Tax_Rep_Local {
  int? TRID;
  int? TTID;
     String? TRDO;
     String? SUID;
  int? JTID;
  String? SOTX;
  int? BIID;
  int? BIIDT;
  String? TRFM;
  String? TRFY;
  String? TRSE;
  String? STID;
  String? TRNA;
  String? TRAM1;
  String? TRAM2;
  String? TRAM3;
  String? TRAM4;
  String? TRAM11;
  String? TRAM22;
  String? TRAM33;
  String? TRAM44;
  int? JTID_L;
  int? BIID_L;
  int? SYID_L;
  String? CIID_L;

  Tax_Rep_Local({this.TRID,this.TTID,this.TRDO,this.SUID,this.JTID,this.SOTX,this.BIID,this.BIIDT,this.TRFM,
    this.TRFY,this.TRSE,this.STID,this.TRAM22,this.TRAM33,this.TRAM44,
    this.TRNA,this.TRAM1,this.TRAM2,this.TRAM3,this.TRAM4,this.TRAM11,this.JTID_L,this.SYID_L,this.BIID_L,this.CIID_L});


  Map<String, dynamic> toMap() {
    var map = <String, dynamic>{
      'TRID': TRID,
      'TTID': TTID,
      'TRDO': TRDO,
      'SUID': SUID,
      'JTID': JTID,
      'SOTX': SOTX,
      'BIID': BIID,
      'BIIDT': BIIDT,
      'TRFM': TRFM,
      'TRFY': TRFY,
      'TRSE': TRSE,
      'STID': STID,
      'TRAM22': TRAM22,
      'TRAM33': TRAM33,
      'TRAM44': TRAM44,
      'TRNA': TRNA,
      'TRAM1': TRAM1,
      'TRAM2': TRAM2,
      'TRAM3': TRAM3,
      'TRAM11': TRAM11,
      'TRAM4': TRAM4,
      'JTID_L': JTID_L ?? LoginController().JTID_L,
      'SYID_L': SYID_L ?? LoginController().SYID_L,
      'BIID_L': BIID_L ?? LoginController().BIID_L,
      'CIID_L': CIID_L ?? LoginController().CIID_L,
    };
    return map;
  }

  Tax_Rep_Local.fromMap(Map<dynamic, dynamic> map) {
    TTID = map['TTID'];
    TTID = map['TTID'];
    TRDO = map['TRDO'];
    SUID = map['SUID'];
    JTID = map['JTID'];
    SOTX = map['SOTX'];
    BIID = map['BIID'];
    BIIDT = map['BIIDT'];
    TRFM = map['TRFM'];
    TRFY = map['TRFY'];
    TRSE = map['TRSE'];
    STID = map['STID'];
    TRAM22 = map['TRAM22'];
    TRAM33 = map['TRAM33'];
    TRAM44 = map['TRAM44'];
    TRNA = map['TRNA'];
    TRAM1 = map['TRAM1'];
    TRAM2 = map['TRAM2'];
    TRAM3 = map['TRAM3'];
    TRAM4 = map['TRAM4'];
    TRAM11 = map['TRAM11'];
    JTID_L = map['JTID_L'];
    SYID_L = map['SYID_L'];
    BIID_L = map['BIID_L'];
    CIID_L = map['CIID_L'];
  }

}
