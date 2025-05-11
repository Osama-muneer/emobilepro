import 'dart:convert';

import '../../Setting/controllers/login_controller.dart';

class Sys_Var_Local {

  int? SVID;
  String? SVVL;
  String? SVNA;
  String? SVNE;
  String? SVN3;
  String? SVVLS;
  String? SVDO;
  String? SUID;
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

  Sys_Var_Local({required this.SVID,required this.SVVL,required this.SVNA,this.SVNE,this.SVN3,this.SVVLS,this.SVDO,
    this.SUID,this.JTID_L,this.SYID_L,this.BIID_L,this.CIID_L,this.GUID,this.DATEI,this.DEVI,this.SUCH,this.DATEU,this.DEVU});

  Map<String, dynamic> toMap() {
    var map = <String, dynamic>{
      'SVID': SVID,
      'SVVL': SVVL,
      'SVNA': SVNA,
      'SVNE': SVNE,
      'SVN3': SVN3,
      'SVVLS': SVVLS,
      'SVDO': SVDO,
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
    };
    return map;
  }

  Sys_Var_Local.fromMap(Map<dynamic, dynamic> map) {
    SVID = map['SVID'];
    SVVL = map['SVVL'];
    SVNA = map['SVNA'];
    SVNE = map['SVNE'];
    SVN3 = map['SVN3'];
    SVVLS = map['SVVLS'];
    SVDO = map['SVDO'];
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
  }

  String Sys_VarToJson(List<Sys_Var_Local> data) =>
      json.encode(List<dynamic>.from(data.map((x) => x.toMap())));
}
