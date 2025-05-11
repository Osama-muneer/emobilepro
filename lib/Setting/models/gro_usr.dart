import 'dart:convert';

import '../../Setting/controllers/login_controller.dart';

class Gro_Usr_Local {
  String? MGNO;
  String? SUID;
  int? GUIN;
  int? GUOU;
  int? GUAM;
  int? GUCH;
  String? GUAP;
  String? GUDO;
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
  String? SUID2;

  Gro_Usr_Local({required this.MGNO,required this.SUID,this.GUIN,this.GUOU,this.GUAM,this.GUCH,this.GUAP,this.GUDO
    ,this.JTID_L,this.SYID_L,this.BIID_L,this.CIID_L, this.GUID,this.DATEI,this.DEVI,this.SUCH,this.DATEU,this.DEVU});

  Map<String, dynamic> toMap() {
    var map = <String, dynamic>{
      'MGNO': MGNO,
      'SUID': SUID,
      'GUIN': GUIN,
      'GUOU': GUOU,
      'GUAM': GUAM,
      'GUCH': GUCH,
      'GUAP': GUAP,
      'GUDO': GUDO,
      'GUID': GUID,
      'DATEI': DATEI,
      'DEVI': DEVI,
      'SUCH': SUCH,
      'DATEU': DATEU,
      'DEVU': DEVU,
      'SUID2': SUID2,
      'JTID_L': JTID_L ?? LoginController().JTID_L,
      'SYID_L': SYID_L ?? LoginController().SYID_L,
      'BIID_L': BIID_L ?? LoginController().BIID_L,
      'CIID_L': CIID_L ?? LoginController().CIID_L,
    };
    return map;
  }

  Gro_Usr_Local.fromMap(Map<dynamic, dynamic> map) {
    MGNO = map['MGNO'];
    SUID = map['SUID'];
    GUIN = map['GUIN'];
    GUOU = map['GUOU'];
    GUAM = map['GUAM'];
    GUCH = map['GUCH'];
    GUAP = map['GUAP'];
    GUDO = map['GUDO'];
    GUID = map['GUID'];
    DATEI = map['DATEI'];
    DEVI = map['DEVI'];
    SUCH = map['SUCH'];
    DATEU = map['DATEU'];
    DEVU = map['DEVU'];
    SUID2 = map['SUID2'];
    JTID_L = map['JTID_L'];
    SYID_L = map['SYID_L'];
    BIID_L = map['BIID_L'];
    CIID_L = map['CIID_L'];
  }

  String Gro_UsrToJson(List<Gro_Usr_Local> data) =>
      json.encode(List<dynamic>.from(data.map((x) => x.toMap())));
}
