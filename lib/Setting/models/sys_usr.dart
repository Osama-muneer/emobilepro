import 'dart:convert';

import '../../Setting/controllers/login_controller.dart';

class Sys_Usr_Local {
  String? SUID;
  String? SUNA;
  String? SUNE;
  String? SUPA;
  int? SULA;
  int? SUST;
  String? SUCP;
  int? SUAC;
  String? SUDA;
  String? SUJO;
  String? SUEM;
  String? SUTL;
  String? SUMO;
  String? SUFX;
  String? SUAD;
  int? SUEX;
  int? BIID;
  int? JTID_L;
  int? BIID_L;
  int? SYID_L;
  String? CIID_L;
  String? SUNA_D;
  String? GUID;
  String? DATEI;
  String? DEVI;
  String? SUCH;
  String? DATEU;
  String? DEVU;

  Sys_Usr_Local({this.SUID, this.SUNA,this.SUNE,this.SUPA,this.SULA,this.SUST,this.SUCP,this.SUAC,
    this.SUDA,this.SUJO,this.SUEM,this.SUTL,this.SUMO,this.SUFX,this.SUAD,this.SUEX,this.BIID
    ,this.JTID_L,this.SYID_L,this.BIID_L,this.CIID_L,this.SUNA_D,this.GUID,this.DATEI,this.DEVI,this.SUCH,this.DATEU,this.DEVU});

  Map<String, dynamic> toMap() {
    var map = <String, dynamic>{
      'SUID': SUID,
      'SUNA': SUNA,
      'SUNE': SUNE,
      'SUPA': SUPA,
      'SULA': SULA,
      'SUST': SUST,
      'SUCP': SUCP,
      'SUAC': SUAC,
      'SUDA': SUDA,
      'SUJO': SUJO,
      'SUEM': SUEM,
      'SUTL': SUTL,
      'SUMO': SUMO,
      'SUFX': SUFX,
      'SUAD': SUAD,
      'SUEX': SUEX,
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

  Sys_Usr_Local.fromMap(Map<dynamic, dynamic> map) {
    SUID = map['SUID'];
    SUNA = map['SUNA'];
    SUNE = map['SUNE'];
    SUPA = map['SUPA'];
    SULA = map['SULA'];
    SUST = map['SUST'];
    SUCP = map['SUCP'];
    SUAC = map['SUAC'];
    SUDA = map['SUDA'];
    SUJO = map['SUJO'];
    SUEM = map['SUEM'];
    SUTL = map['SUTL'];
    SUMO = map['SUMO'];
    SUFX = map['SUFX'];
    SUAD = map['SUAD'];
    SUEX = map['SUEX'];
    BIID = map['BIID'];
    JTID_L = map['JTID_L'];
    SYID_L = map['SYID_L'];
    BIID_L = map['BIID_L'];
    CIID_L = map['CIID_L'];
    SUNA_D = map['SUNA_D'];
    GUID = map['GUID'];
    DATEI = map['DATEI'];
    DEVI = map['DEVI'];
    SUCH = map['SUCH'];
    DATEU = map['DATEU'];
    DEVU = map['DEVU'];
  }

  String Sys_UsrToJson(List<Sys_Usr_Local> data) =>
      json.encode(List<dynamic>.from(data.map((x) => x.toMap())));
}
