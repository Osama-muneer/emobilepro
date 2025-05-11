import 'dart:convert';

import '../../Setting/controllers/login_controller.dart';

class Shi_Usr_Local {
  int? SUNO;
  int? SIID ;
  String? SUID;
  int? BPID;
  int? SUST;
  int? SIFT;
  int? SITT;
  int? SIAS;
  int? SIHN;
  String? SUID2;
  String? SUDO;
  String? SUCH;
  String? SUDC;
  int? SIDAYT;
  String? SIDAY;
  int? SIDEVT;
  String? SIDEV;
  String? RES;
  int? JTID_L;
  int? BIID_L;
  int? SYID_L;
  String? CIID_L;
  String? GUID;
  String? GUIDF;
  String? DATEI;
  String? DEVI;
  String? DATEU;
  String? DEVU;

  Shi_Usr_Local({this.SUNO,this.SIID,this.SUID,this.BPID,this.SUCH,this.SIAS,this.SIFT,this.SIHN,this.SITT,this.SUDC
    ,this.SUDO,this.SUID2,this.SUST,this.JTID_L,this.SYID_L,this.BIID_L,this.CIID_L,this.GUID,this.DATEI,this.DEVI,this.DATEU,this.DEVU,
    this.SIDAYT,this.SIDAY,this.SIDEVT,this.SIDEV,this.RES,this.GUIDF});


  Map<String, dynamic> toMap() {
    var map = <String, dynamic>{
      'SUNO': SUNO,
      'SIID': SIID,
      'SUID': SUID,
      'BPID': BPID,
      'SUST': SUST,
      'SIFT': SIFT,
      'SITT': SITT,
      'SIAS': SIAS,
      'SIHN': SIHN,
      'SUID2': SUID2,
      'SUDO': SUDO,
      'SUCH': SUCH,
      'SUDC': SUDC,
      'GUID': GUID,
      'DATEI': DATEI,
      'DEVI': DEVI,
      'DATEU': DATEU,
      'DEVU': DEVU,
      'SIDAYT': SIDAYT,
      'SIDAY': SIDAY,
      'SIDEVT': SIDEVT,
      'SIDEV': SIDEV,
      'RES': RES,
      'GUIDF': GUIDF,
      'JTID_L': JTID_L ?? LoginController().JTID_L,
      'SYID_L': SYID_L ?? LoginController().SYID_L,
      'BIID_L': BIID_L ?? LoginController().BIID_L,
      'CIID_L': CIID_L ?? LoginController().CIID_L,
    };
    return map;
  }

  Shi_Usr_Local.fromMap(Map<dynamic, dynamic> map) {
    SUNO = map['SUNO'];
    SIID = map['SIID'];
    SUID = map['SUID'];
    BPID = map['BPID'];
    SUST = map['SUST'];
    SIFT = map['SIFT'];
    SITT = map['SITT'];
    SIAS = map['SIAS'];
    SIHN = map['SIHN'];
    SUID2 = map['SUID2'];
    GUID = map['GUID'];
    DATEI = map['DATEI'];
    DEVI = map['DEVI'];
    SUCH = map['SUCH'];
    DATEU = map['DATEU'];
    DEVU = map['DEVU'];
    SIDAYT = map['SIDAYT'];
    SIDAY = map['SIDAY'];
    SIDEVT = map['SIDEVT'];
    SIDEV = map['SIDEV'];
    RES = map['RES'];
    GUIDF = map['GUIDF'];
    JTID_L = map['JTID_L'];
    SYID_L = map['SYID_L'];
    BIID_L = map['BIID_L'];
    CIID_L = map['CIID_L'];
  }

  String Shi_Usr_toJson(List<Shi_Usr_Local> data) =>
      json.encode(List<dynamic>.from(data.map((x) => x.toMap())));
}
