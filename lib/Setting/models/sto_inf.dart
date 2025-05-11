import 'dart:convert';

import '../../Setting/controllers/login_controller.dart';

class Sto_Inf_Local {
  int? SIID;
  String? SINA;
  String? SINE;
  String? AANO;
  String? SIPR;
  String? SITL;
  String? SIFX;
  String? SIAD;
  int? SIPN;
  int? SIST;
  int? BIID;
  String? SIDO;
  String? SUID;
  var BINA;
  String? DETUI;
  String? SUCH;
  String? DATEU;
  String? GUID;
  int? SISY;
  int? JTID_L;
  int? BIID_L;
  int? SYID_L;
  String? CIID_L;
  String? SINA_D;
  String? DATEI;
  String? DEVI;
  String? DEVU;

  Sto_Inf_Local({this.SIID,required this.SINA, this.SINE, this.AANO, this.SIPR
    , this.SITL, this.SIFX, this.SIAD, this.SIPN,required this.SIST,required this.BIID
    ,this.SIDO, this.SUID, this.DETUI, this.SUCH, this.GUID,this.DATEI,this.DEVI,this.DATEU,this.DEVU
    ,this.BINA,this.SISY,this.JTID_L,this.SYID_L,this.BIID_L,this.CIID_L,this.SINA_D});

  Map<String, dynamic> toMap() {
    var map = <String, dynamic>{
      'BIID': BIID,
      'SIID': SIID,
      'SINA': SINA,
      'SINE': SINE,
      'AANO': AANO,
      'SIPR': SIPR,
      'SITL': SITL,
      'SIFX': SIFX,
      'SIAD': SIAD,
      'SIPN': SIPN,
      'SIST': SIST,
      'SIDO': SIDO,
      'SUID': SUID,
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
      // 'SISY': SISY,
    };
    return map;
  }

  Sto_Inf_Local.fromMap(Map<dynamic, dynamic> map) {
    SIID = map['SIID'];
    SINA = map['SINA'];
    SINE = map['SINE'];
    AANO = map['AANO'];
    SIPR = map['SIPR'];
    SITL = map['SITL'];
    SIFX = map['SIFX'];
    SITL = map['SITL'];
    SIAD = map['SIAD'];
    SIPN = map['SIPN'];
    SIST = map['SIST'];
    SIDO = map['SIDO'];
    BIID = map['BIID'];
    SUID = map['SUID'];
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
    SINA_D = map['SINA_D'];
  }

  String employeeToJson(List<Sto_Inf_Local> data) =>
      json.encode(List<dynamic>.from(data.map((x) => x.toMap())));
}
