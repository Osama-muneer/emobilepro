import 'dart:convert';

import '../../Setting/controllers/login_controller.dart';

class Sys_Usr_B_Local {
  int? BIID;
  String? SUID ;
  int? SUBST ;
  int? SUBIN;
  int? SUBPR;
  int? SUBAP;
  String? SUAP;
  String? SUBDO;
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
  Sys_Usr_B_Local({required this.BIID,required this.SUID,required this.SUBST,this.SUBIN,this.SUBPR,this.SUBAP,
    this.SUAP,this.SUBDO,this.JTID_L,this.SYID_L,this.BIID_L,this.CIID_L,this.GUID,this.DATEI,this.DEVI,this.SUCH,this.DATEU,this.DEVU});

  Map<String, dynamic> toMap() {
    var map = <String, dynamic>{
      'BIID': BIID,
      'SUID': SUID,
      'SUBST': SUBST,
      'SUBIN': SUBIN,
      'SUBPR': SUBPR,
      'SUBAP': SUBAP,
      'SUAP': SUAP,
      'SUBDO': SUBDO,
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

  Sys_Usr_B_Local.fromMap(Map<dynamic, dynamic> map) {
    BIID = map['BIID'];
    SUID = map['SUID'];
    SUBST = map['SUBST'];
    SUBIN = map['SUBIN'];
    SUBPR = map['SUBPR'];
    SUBAP = map['SUBAP'];
    SUAP = map['SUAP'];
    SUBDO = map['SUBDO'];
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

  String Sys_Usr_BToJson(List<Sys_Usr_B_Local> data) =>
      json.encode(List<dynamic>.from(data.map((x) => x.toMap())));
}
