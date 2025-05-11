import 'dart:convert';

import '../../Setting/controllers/login_controller.dart';

class Sys_Cur_D_Local {
  int? SCID;
  var SCDNO;
  String? SCDNA;
  String? SCDNE;
  String? SCDN3;
  int? SCDST;
  String? SUID;
  String? DATEI;
  String? DATEU;
  String? SUCH;
  String? DEVI;
  String? DEVU;
  String? RES;
  int? ORDNU;
  int? DEFN;
  int? JTID_L;
  int? BIID_L;
  int? SYID_L;
  String? CIID_L;
  String? SCDNA_D;
  String? GUID;


  Sys_Cur_D_Local({this.SCID,this.SCDNO,this.SCDNA,this.SCDNE,this.SCDN3,this.SCDST,this.SUID,this.DATEI,this.DEVI,this.GUID,
    this.SUCH,this.DATEU, this.DEVU,this.ORDNU,this.RES,this.DEFN, this.JTID_L,this.SYID_L,this.BIID_L,this.CIID_L,this.SCDNA_D});


  Map<String, dynamic> toMap() {
    var map = <String, dynamic>{
      'SCID': SCID,
      'SCDNO': SCDNO,
      'SCDNA': SCDNA,
      'SCDNE': SCDNE,
      'SCDN3': SCDN3,
      'SCDST': SCDST,
      'SUID': SUID,
      'SUCH': SUCH,
      'DATEI': DATEI,
      'DEVI': DEVI,
      'DATEU': DATEU,
      'DEVU': DEVU,
      'RES': RES,
      'ORDNU': ORDNU,
      'DEFN': DEFN,
      'GUID': GUID,
      'JTID_L': JTID_L ?? LoginController().JTID_L,
      'SYID_L': SYID_L ?? LoginController().SYID_L,
      'BIID_L': BIID_L ?? LoginController().BIID_L,
      'CIID_L': CIID_L ?? LoginController().CIID_L,
    };
    return map;
  }

  Sys_Cur_D_Local.fromMap(Map<dynamic, dynamic> map) {
    SCID = map['SCID'];
    SCDNO = map['SCDNO'];
    SCDNA = map['SCDNA'];
    SCDN3 = map['SCDN3'];
    SCDST = map['SCDST'];
    SUID = map['SUID'];
    DATEI = map['DATEI'];
    DATEU = map['DATEU'];
    SUCH = map['SUCH'];
    DEVI = map['DEVI'];
    DEVU = map['DEVU'];
    RES = map['RES'];
    ORDNU = map['ORDNU'];
    DEFN = map['DEFN'];
    JTID_L = map['JTID_L'];
    SYID_L = map['SYID_L'];
    BIID_L = map['BIID_L'];
    CIID_L = map['CIID_L'];
    SCDNA = map['SCDNA'];
    GUID = map['GUID'];
  }

  String Sys_Cur_D_toJson(List<Sys_Cur_D_Local> data) =>
      json.encode(List<dynamic>.from(data.map((x) => x.toMap())));
}
