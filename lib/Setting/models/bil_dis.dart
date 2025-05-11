import 'dart:convert';

import '../../Setting/controllers/login_controller.dart';

class Bil_Dis_Local {
  int? BDID;
  String? BDNA;
  String? AANO;
  int? BAID;
  int? BDTY;
  String? BDAD;
  String? BDTL;
  String? BDFX;
  String? BDEM;
  String? BDIN;
  int? BDST;
  String? SUID;
  String? BDDO;
  int? BIID;
  String? GUID;
  String? DATEI;
  String? DEVI;
  String? SUCH;
  String? DATEU;
  String? DEVU;
  int? JTID_L;
  int? BIID_L;
  int? SYID_L;
  String? CIID_L;


  Bil_Dis_Local({this.BDID,this.BDNA,this.AANO,this.BAID,this.SUID,this.BIID,this.BDAD,this.BDDO,this.BDEM,this.BDFX
    ,this.BDIN,this.BDST,this.BDTL,this.BDTY,this.JTID_L,this.SYID_L,this.BIID_L,this.CIID_L,
    this.GUID,this.DATEI,this.DEVI,this.SUCH,this.DATEU,this.DEVU});


  Map<String, dynamic> toMap() {
    var map = <String, dynamic>{
      'BDID': BDID,
      'BDNA': BDNA,
      'AANO': AANO,
      'BAID': BAID,
      'BDTY': BDTY,
      'BDAD': BDAD,
      'BDTL': BDTL,
      'BDFX': BDFX,
      'BDEM': BDEM,
      'BDIN': BDIN,
      'BDST': BDST,
      'SUID': SUID,
      'BDDO': BDDO,
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

  Bil_Dis_Local.fromMap(Map<dynamic, dynamic> map) {
    BDID = map['BDID'];
    BDNA = map['BDNA'];
    AANO = map['AANO'];
    BAID = map['BAID'];
    BDTY = map['BDTY'];
    BDAD = map['BDAD'];
    BDTL = map['BDTL'];
    BDFX = map['BDFX'];
    BDEM = map['BDEM'];
    BDIN = map['BDIN'];
    BDST = map['BDST'];
    SUID = map['SUID'];
    BDDO = map['BDDO'];
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

  String Pay_Kin_toJson(List<Bil_Dis_Local> data) =>
      json.encode(List<dynamic>.from(data.map((x) => x.toMap())));
}
