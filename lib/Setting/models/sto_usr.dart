import 'dart:convert';

import '../../Setting/controllers/login_controller.dart';

class Sto_Usr_Local {
  int? SIID;
  String? SUID;
  int? SUIN;
  int? SUOU;
  int? SUAM;
  int? SUCH;
  String? SUAP;
  String? SUDO;
  String? GUID;
  String? DATEI;
  String? DATEU;
  String? DEVI;
  String? DEVU;
  String? SUID2;
  String? SUCH2;
  int? JTID_L;
  int? BIID_L;
  int? SYID_L;
  String? CIID_L;

  Sto_Usr_Local({required this.SIID,required this.SUID, this.SUIN,this.SUOU,this.SUAM,this.SUCH,this.SUAP,this.SUDO,
  this.JTID_L,this.SYID_L,this.BIID_L,this.CIID_L,this.DATEI,this.DATEU,this.GUID,this.DEVU,this.DEVI});

  Map<String, dynamic> toMap() {
    var map = <String, dynamic>{
      'SIID': SIID,
      'SUID': SUID,
      'SUIN': SUIN,
      'SUOU': SUOU,
      'SUAM': SUAM,
      'SUCH': SUCH,
      'SUAP': SUAP,
      'SUDO': SUDO,
      'GUID': GUID,
      'DATEI': DATEI,
      'DEVI': DEVI,
      'SUCH2': SUCH2,
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

  Sto_Usr_Local.fromMap(Map<dynamic, dynamic> map) {
    SIID = map['SIID'];
    SUID = map['SUID'];
    SUIN = map['SUIN'];
    SUOU = map['SUOU'];
    SUAM = map['SUAM'];
    SUCH = map['SUCH'];
    SUAP = map['SUAP'];
    SUDO = map['SUDO'];
    GUID = map['GUID'];
    DATEI = map['DATEI'];
    DEVI = map['DEVI'];
    SUCH2 = map['SUCH2'];
    DATEU = map['DATEU'];
    DEVU = map['DEVU'];
    SUID2 = map['SUID2'];
JTID_L = map['JTID_L'];
SYID_L = map['SYID_L'];
BIID_L = map['BIID_L'];
CIID_L = map['CIID_L'];
  }

  String PrivlageToJson(List<Sto_Usr_Local> data) =>
      json.encode(List<dynamic>.from(data.map((x) => x.toMap())));
}
