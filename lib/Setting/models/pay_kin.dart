import 'dart:convert';

import '../../Setting/controllers/login_controller.dart';

class Pay_Kin_Local {
  int? PKID;
  String? PKNA;
  String? PKNE;
  String? PKN3;
  int? JTID_L;
  int? BIID_L;
  int? SYID_L;
  String? CIID_L;
  String? PKNA_D;
  String? GUID;
  String? DATEI;
  String? DEVI;
  String? SUID;
  String? SUCH;
  String? DATEU;
  String? DEVU;
  int? PKTY;

  Pay_Kin_Local({this.PKID,this.PKNA,this.PKNE,this.PKN3,this.JTID_L,this.SYID_L,this.BIID_L,this.CIID_L,this.PKNA_D,
    this.GUID,this.DATEI,this.DEVI,this.SUCH,this.DATEU,this.DEVU,this.SUID,this.PKTY});


  Map<String, dynamic> toMap() {
    var map = <String, dynamic>{
      'PKID': PKID,
      'PKNA': PKNA,
      'PKNE': PKNE,
      'PKN3': PKN3,
      'GUID': GUID,
      'DATEI': DATEI,
      'DEVI': DEVI,
      'SUCH': SUCH,
      'DATEU': DATEU,
      'DEVU': DEVU,
      'SUID': SUID,
      'PKTY': PKTY,
      'JTID_L': JTID_L ?? LoginController().JTID_L,
      'SYID_L': SYID_L ?? LoginController().SYID_L,
      'BIID_L': BIID_L ?? LoginController().BIID_L,
      'CIID_L': CIID_L ?? LoginController().CIID_L,
    };
    return map;
  }

  Pay_Kin_Local.fromMap(Map<dynamic, dynamic> map) {
    PKID = map['PKID'];
    PKNA = map['PKNA'];
    PKNE = map['PKNE'];
    PKN3 = map['PKN3'];
    GUID = map['GUID'];
    DATEI = map['DATEI'];
    DEVI = map['DEVI'];
    SUCH = map['SUCH'];
    DATEU = map['DATEU'];
    DEVU = map['DEVU'];
    SUID = map['SUID'];
    PKTY = map['PKTY'];
    JTID_L = map['JTID_L'];
    SYID_L = map['SYID_L'];
    BIID_L = map['BIID_L'];
    CIID_L = map['CIID_L'];
    PKNA_D = map['PKNA_D'];
  }

  String Pay_Kin_toJson(List<Pay_Kin_Local> data) =>
      json.encode(List<dynamic>.from(data.map((x) => x.toMap())));
}
