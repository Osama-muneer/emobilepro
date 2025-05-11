import 'dart:convert';

import '../../Setting/controllers/login_controller.dart';

class Bil_Mov_K_Local {
  int? BMKID;
  String? BMKNA;
  String? BMKNE;
  String? BMKN3;
  int? BMKST;
  int? BMKTY;
  int? BMKSN;
  int? BMKAN;
  String? BMKDO;
  String? SUID;
  String? STID;
  String? DATEI;
  String? DATEU;
  String? SUCH;
  String? DEVI;
  String? DEVU;
  String? RES;
  int? ORDNU;
  int? JTID_L;
  int? BIID_L;
  int? SYID_L;
  String? CIID_L;
  String? GUID;
  String? BMKNA_D;


  Bil_Mov_K_Local({this.BMKID,this.BMKNA,this.BMKNE,this.BMKN3,this.BMKST,this.BMKAN,this.BMKSN
    ,this.BMKTY,this.BMKDO,this.STID,this.SUID,this.SUCH,this.DATEI,this.DEVI,this.DATEU,this.DEVU,
    this.RES,this.ORDNU,this.JTID_L,this.SYID_L,this.BIID_L,this.CIID_L,this.GUID,this.BMKNA_D});


  Map<String, dynamic> toMap() {
    var map = <String, dynamic>{
      'BMKID': BMKID,
      'BMKNA': BMKNA,
      'BMKNE': BMKNE,
      'BMKN3': BMKN3,
      'BMKST': BMKST,
      'BMKAN': BMKAN,
      'BMKSN': BMKSN,
      'BMKTY': BMKTY,
      'BMKDO': BMKDO,
      'STID': STID,
      'SUID': SUID,
      'SUCH': SUCH,
      'DATEI': DATEI,
      'DEVI': DEVI,
      'DATEU': DATEU,
      'DEVU': DEVU,
      'RES': RES,
      'ORDNU': ORDNU,
      'GUID': GUID,
      'JTID_L': JTID_L ?? LoginController().JTID_L,
      'SYID_L': SYID_L ?? LoginController().SYID_L,
      'BIID_L': BIID_L ?? LoginController().BIID_L,
      'CIID_L': CIID_L ?? LoginController().CIID_L,
    };
    return map;
  }

  Bil_Mov_K_Local.fromMap(Map<dynamic, dynamic> map) {
    BMKID = map['BMKID'];
    BMKNA = map['BMKNA'];
    BMKNE = map['BMKNE'];
    BMKN3 = map['BMKN3'];
    BMKST = map['BMKST'];
    BMKTY = map['BMKTY'];
    BMKSN = map['BMKSN'];
    BMKAN = map['BMKAN'];
    BMKDO = map['BMKDO'];
    SUID = map['SUID'];
    STID = map['STID'];
    DATEI = map['DATEI'];
    DATEU = map['DATEU'];
    SUCH = map['SUCH'];
    DEVI = map['DEVI'];
    DEVU = map['DEVU'];
    RES = map['RES'];
    ORDNU = map['ORDNU'];
    GUID = map['GUID'];
    JTID_L = map['JTID_L'];
    SYID_L = map['SYID_L'];
    BIID_L = map['BIID_L'];
    CIID_L = map['CIID_L'];
    BMKNA_D = map['BMKNA_D'];
  }

  String Bil_Mov_K_toJson(List<Bil_Mov_K_Local> data) =>
      json.encode(List<dynamic>.from(data.map((x) => x.toMap())));
}
