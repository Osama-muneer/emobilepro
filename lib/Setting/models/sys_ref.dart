import 'dart:convert';

import '../../Setting/controllers/login_controller.dart';

class Sys_Ref_Local {
  String? STID;
  int? SRID;
  String? SRNA;
  String? SRNE;
  String? SRNO;
  String? SRNL;
  int? SRLE;
  String? SRYE;
  String? SRFO;
  int? SRCO1;
  int? SRCO2;
  String? SRDO;
  String? SUID;
  int? BIID;
  int? JTID_L;
  int? BIID_L;
  int? SYID_L;
  String? CIID_L;
  String? GUID;
  String? DATEI;
  String? DEVI;
  String? SUCH;
  String? DATEU;
  String? DEVU;

  Sys_Ref_Local({this.STID,this.SRID,this.SRNA,this.SRNE,this.SUID,this.BIID,this.SRCO1,this.SRCO2,this.SRDO,this.SRFO,this.SRLE
    ,this.SRNL,this.SRNO,this.SRYE,this.JTID_L,this.SYID_L,this.BIID_L,this.CIID_L,this.GUID,this.DATEI,this.DEVI,this.SUCH,this.DATEU,this.DEVU});


  Map<String, dynamic> toMap() {
    var map = <String, dynamic>{
      'STID': STID,
      'SRID': SRID,
      'SRNA': SRNA,
      'SRNE': SRNE,
      'SRNO': SRNO,
      'SRNL': SRNL,
      'SRLE': SRLE,
      'SRFO': SRFO,
      'SRCO1': SRCO1,
      'SRCO2': SRCO2,
      'SRDO': SRDO,
      'SUID': SUID,
      'BIID': BIID,
      'GUID': GUID,
      'DATEI': DATEI,
      'DEVI': DEVI,
      'SUCH': SUCH,
      'DATEU': DATEU,
      'DEVU': DEVU,
      'JTID_L': JTID_L ?? LoginController().JTID_L,
      'SYID_L': SYID_L ?? LoginController().SYID_L,
      'BIID_L': BIID_L ?? LoginController().BIID_L,
      'CIID_L': CIID_L ?? LoginController().CIID_L,
    };
    return map;
  }

  Sys_Ref_Local.fromMap(Map<dynamic, dynamic> map) {
    STID = map['STID'];
    SRID = map['SRID'];
    SRNA = map['SRNA'];
    SRNE = map['SRNE'];
    SRNO = map['SRNO'];
    SRNL = map['SRNL'];
    SRLE = map['SRLE'];
    SRFO = map['SRFO'];
    SRCO1 = map['SRCO1'];
    SRCO2 = map['SRCO2'];
    SRDO = map['SRDO'];
    SUID = map['SUID'];
    BIID = map['BIID'];
    GUID = map['GUID'];
    DATEI = map['DATEI'];
    DEVI = map['DEVI'];
    SUCH = map['SUCH'];
    DATEU = map['DATEU'];
    DEVU = map['DEVU'];
    JTID_L = map['JTID_L'];
    SYID_L = map['SYID_L'];
    BIID_L = map['BIID_L'];
    CIID_L = map['CIID_L'];
  }

  String Pay_Kin_toJson(List<Sys_Ref_Local> data) =>
      json.encode(List<dynamic>.from(data.map((x) => x.toMap())));
}
