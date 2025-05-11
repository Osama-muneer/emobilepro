import 'dart:convert';

import '../../Setting/controllers/login_controller.dart';

class Acc_Usr_Local {
  String? AANO;
  String? SUID;
  int? AUIN;
  int? AUOU;
  int? AUPR;
  int? AUDL;
  int? AUOT;
  String? SUAP;
  String? AUDO;
  int? JTID_L;
  int? BIID_L;
  int? SYID_L;
  int? SYST_L;
  String? CIID_L;
  String? GUID;
  String? DATEI;
  String? DEVI;
  String? SUCH;
  String? DATEU;
  String? DEVU;

  Acc_Usr_Local({required this.AANO,required this.SUID,this.AUIN,this.AUOU,this.AUPR,this.AUDL,
    this.AUOT,this.SUAP,this.AUDO,this.JTID_L,this.SYID_L,this.BIID_L,this.CIID_L,this.GUID,
    this.DATEI,this.DEVI,this.SUCH,this.DATEU,this.DEVU,this.SYST_L});

  Map<String, dynamic> toMap() {
    var map = <String, dynamic>{
      'AANO': AANO,
      'SUID': SUID,
      'AUIN': AUIN,
      'AUOU': AUOU,
      'AUPR': AUPR,
      'AUDL': AUDL,
      'AUOT': AUOT,
      'SUAP': SUAP,
      'AUDO': AUDO,
      'GUID': GUID,
      'DATEI': DATEI,
      'DEVI': DEVI,
      'SUCH': SUCH,
      'DATEU': DATEU,
      'DEVU': DEVU,
      'SYST_L': SYST_L ?? 1,
      'JTID_L': JTID_L ?? LoginController().JTID_L,
      'SYID_L': SYID_L ?? LoginController().SYID_L,
      'BIID_L': BIID_L ?? LoginController().BIID_L,
      'CIID_L': CIID_L ?? LoginController().CIID_L,
    };
    return map;
  }

  Acc_Usr_Local.fromMap(Map<dynamic, dynamic> map) {
    AANO = map['AANO'];
    SUID = map['SUID'];
    AUIN = map['AUIN'];
    AUOU = map['AUOU'];
    AUPR = map['AUPR'];
    AUDL = map['AUDL'];
    AUOT = map['AUOT'];
    SUAP = map['SUAP'];
    AUDO = map['AUDO'];
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
    SYST_L = map['SYST_L'];
  }

  String Acc_UsrToJson(List<Acc_Usr_Local> data) =>
      json.encode(List<dynamic>.from(data.map((x) => x.toMap())));
}
