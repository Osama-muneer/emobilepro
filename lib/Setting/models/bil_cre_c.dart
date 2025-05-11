import 'dart:convert';

import '../../Setting/controllers/login_controller.dart';

class Bil_Cre_C_Local {
  int? BCCID;
  String? BCCNA;
  String? BCCNE;
  String? AANO;
  int? BCCCT;
  int? SCID;
  int? BCCCO;
  var BCCPR;
  String? AANOC;
  String? BCCBN;
  String? BCCNO;
  String? BCCAD;
  String? BCCTL;
  String? BCCFX;
  String? BCCWE;
  String? BCCEM;
  String? BCCHN;
  String? BCCHT;
  int? BCCST;
  String? BCCIN;
  String? SUID;
  String? BCCDO;
  String? BCCDC;
  String? SUCH;
  int? BIID;
  int? BCCPK;
  int? BCCSP;
  int? JTID_L;
  int? BIID_L;
  int? SYID_L;
  String? CIID_L;
  String? BCCNA_D;
  String? GUID;
  String? DATEI;
  String? DEVI;
  String? DATEU;
  String? DEVU;

  Bil_Cre_C_Local({this.BCCID,this.BCCNA,this.BCCNE,this.AANO,this.BCCCT,this.SUCH,this.SUID,this.AANOC,this.BCCAD
    ,this.BCCBN,this.BCCCO,this.BCCDC,this.BCCDO,this.BCCEM,this.BCCFX,this.BCCHN,this.BCCHT,this.BCCIN,this.BCCNO
    ,this.BCCPK,this.BCCPR,this.BCCSP,this.BCCST,this.BCCTL,this.BCCWE,this.BIID,this.SCID,this.JTID_L,
    this.SYID_L,this.BIID_L,this.CIID_L,this.BCCNA_D,this.GUID,this.DATEI,this.DEVI,this.DATEU,this.DEVU});


  Map<String, dynamic> toMap() {
    var map = <String, dynamic>{
      'BCCID': BCCID,
      'BCCNA': BCCNA,
      'BCCNE': BCCNE,
      'AANO': AANO,
      'BCCCT': BCCCT,
      'SCID': SCID,
      'BCCCO': BCCCO,
      'BCCPR': BCCPR,
      'AANOC': AANOC,
      'BCCBN': BCCBN,
      'BCCNO': BCCNO,
      'BCCAD': BCCAD,
      'BCCTL': BCCTL,
      'BCCFX': BCCFX,
      'BCCWE': BCCWE,
      'BCCEM': BCCEM,
      'BCCHN': BCCHN,
      'BCCHT': BCCHT,
      'BCCST': BCCST,
      'BCCIN': BCCIN,
      'SUID': SUID,
      'BCCDO': BCCDO,
      'BCCDC': BCCDC,
      'SUCH': SUCH,
      'BIID': BIID,
      'BCCPK': BCCPK,
      'BCCSP': BCCSP,
      'GUID': GUID,
      'DATEI': DATEI,
      'DEVI': DEVI,
      'DATEU': DATEU,
      'DEVU': DEVU,
      'JTID_L': JTID_L ?? LoginController().JTID_L,
      'SYID_L': SYID_L ?? LoginController().SYID_L,
      'BIID_L': BIID_L ?? LoginController().BIID_L,
      'CIID_L': CIID_L ?? LoginController().CIID_L,
    };
    return map;
  }

  Bil_Cre_C_Local.fromMap(Map<dynamic, dynamic> map) {
    BCCID = map['BCCID'];
    BCCNA = map['BCCNA'];
    BCCNE = map['BCCNE'];
    AANO = map['AANO'];
    BCCCT = map['BCCCT'];
    BCCCO = map['BCCCO'];
    SCID = map['SCID'];
    BCCPR = map['BCCPR'];
    AANOC = map['AANOC'];
    BCCBN = map['BCCBN'];
    BCCNO = map['BCCNO'];
    BCCAD = map['BCCAD'];
    BCCTL = map['BCCTL'];
    BCCFX = map['BCCFX'];
    BCCWE = map['BCCWE'];
    BCCEM = map['BCCEM'];
    BCCHN = map['BCCHN'];
    BCCHT = map['BCCHT'];
    BCCST = map['BCCST'];
    BCCIN = map['BCCIN'];
    SUID = map['SUID'];
    BCCDO = map['BCCDO'];
    BCCDC = map['BCCDC'];
    SUCH = map['SUCH'];
    BIID = map['BIID'];
    BCCPK = map['BCCPK'];
    BCCSP = map['BCCSP'];
    GUID = map['GUID'];
    DATEI = map['DATEI'];
    DEVI = map['DEVI'];
    DATEU = map['DATEU'];
    DEVU = map['DEVU'];
    JTID_L = map['JTID_L'];
    SYID_L = map['SYID_L'];
    BIID_L = map['BIID_L'];
    CIID_L = map['CIID_L'];
    BCCNA_D = map['BCCNA_D'];
  }

  String Bil_Cre_C_toJson(List<Bil_Cre_C_Local> data) =>
      json.encode(List<dynamic>.from(data.map((x) => x.toMap())));
}
