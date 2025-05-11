import 'dart:convert';

import '../../Setting/controllers/login_controller.dart';

class Shi_Inf_Local {
  int? SIID;
  int? BIID;
  int? SITY;
  int? SIVA;
  String? SINA;
  String? SINE;
  String? SIN3;
  int? SIST;
  String? SIFD;
  String? SITD;
  int? SIFT;
  int? SITT;
  int? SIAS;
  int? SIHN;
  String? SUID;
  String? SIDO;
  String? SUCH;
  String? SIDC;
  int? JTID_L;
  int? BIID_L;
  int? SYID_L;
  String? CIID_L;
  String? SINA_D;
  int? BIIDT;
  String? BIIDV;
  int? SIDAYT;
  String? SIDAY;
  int? SIDEVT;
  String? SIDEV;
  String? RES;
  int? DEFN;
  String? GUID;
  String? DATEI;
  String? DEVI;
  String? DATEU;
  String? DEVU;

  Shi_Inf_Local({this.SIID,this.BIID,this.SITY, this.SIVA,this.SINA,this.SINE,
    this.SIN3,this.SIST,this.SIFD,this.SITD,this.SIFT,this.SITT,this.SIAS,this.SIHN,this.SUID
    ,this.SIDO,this.SUCH,this.SIDC,this.JTID_L,this.SYID_L,this.BIID_L,this.CIID_L,
  this.BIIDT,this.BIIDV,this.SIDAYT,this.SIDAY,this.SIDEVT,this.SIDEV,this.RES,this.DEFN,
    this.GUID,this.DATEI,this.DEVI,this.DATEU,this.DEVU});


  Map<String, dynamic> toMap() {
    var map = <String, dynamic>{
      'SIID': SIID,
      'BIID': BIID,
      'SITY': SITY,
      'SIVA': SIVA,
      'SINA': SINA,
      'SINE': SINE,
      'SIN3': SIN3,
      'SIST': SIST,
      'SIFD': SIFD,
      'SITD': SITD,
      'SIFT': SIFT,
      'SITT': SITT,
      'SIAS': SIAS,
      'SIHN': SIHN,
      'SUID': SUID,
      'SIDO': SIDO,
      'SUCH': SUCH,
      'SIDC': SIDC,
      'BIIDT': BIIDT,
      'BIIDV': BIIDV,
      'SIDAYT': SIDAYT,
      'SIDAY': SIDAY,
      'SIDEVT': SIDEVT,
      'SIDEV': SIDEV,
      'RES': RES,
      'DEFN': DEFN,
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

  Shi_Inf_Local.fromMap(Map<String, dynamic> map) {
    SIID = map['SIID'];
    BIID = map['BIID'];
    SITY = map['SITY'];
    SIVA = map['SIVA'];
    SINA = map['SINA'];
    SINE = map['SINE'];
    SIN3 = map['SIN3'];
    SIST = map['SIST'];
    SIFD = map['SIFD'];
    SITD = map['SITD'];
    SIFT = map['SIFT'];
    SITT = map['SITT'];
    SIAS = map['SIAS'];
    SIHN = map['SIHN'];
    SUID = map['SUID'];
    SIDO = map['SIDO'];
    SUCH = map['SUCH'];
    SIDC = map['SIDC'];
    BIIDT = map['BIIDT'];
    BIIDV = map['BIIDV'];
    SIDAYT = map['SIDAYT'];
    SIDAY = map['SIDAY'];
    SIDEVT = map['SIDEVT'];
    SIDEV = map['SIDEV'];
    RES = map['RES'];
    DEFN = map['DEFN'];
    GUID = map['GUID'];
    DATEI = map['DATEI'];
    DEVI = map['DEVI'];
    DATEU = map['DATEU'];
    DEVU = map['DEVU'];
    JTID_L = map['JTID_L'];
    SYID_L = map['SYID_L'];
    BIID_L = map['BIID_L'];
    CIID_L = map['CIID_L'];
    SINA_D = map['SINA_D'];
  }

  String Shi_Inf_toJson(List<Shi_Inf_Local> data) =>
      json.encode(List<dynamic>.from(data.map((x) => x.toMap())));
}
