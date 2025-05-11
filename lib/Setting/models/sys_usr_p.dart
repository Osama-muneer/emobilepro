import 'dart:convert';

class Sys_Usr_P_Local {
  int? JTID;
  int? BIID;
  int? SYID;
  String? SUID;
  String? SUNA;
  String? SUNE;
  String? SUPA;
  int? SULA;
  int? SUST;
  String? SUCP;
  String? SUNA_D;
  String? GUID;
  String? DATEI;
  String? DEVI;
  String? SUCH;
  String? DATEU;
  String? DEVU;


  Sys_Usr_P_Local({this.JTID,this.BIID,this.SYID,this.SUID, this.SUNA,this.SUNE,this.SUPA,this.SULA,this.SUST,
                  this.SUCP,this.SUNA_D,this.GUID,this.DATEI,this.DEVI,this.SUCH,this.DATEU,this.DEVU});

  Map<String, dynamic> toMap() {
    var map = <String, dynamic>{
      'JTID': JTID,
      'BIID': BIID,
      'SYID': SYID,
      'SUID': SUID,
      'SUNA': SUNA,
      'SUNE': SUNE,
      'SUPA': SUPA,
      'SULA': SULA,
      'SUST': SUST,
      'SUCP': SUCP,
      'GUID': GUID,
      'DATEI': DATEI,
      'DEVI': DEVI,
      'SUCH': SUCH,
      'DATEU': DATEU,
      'DEVU': DEVU,
    };
    return map;
  }

  Sys_Usr_P_Local.fromMap(Map<dynamic, dynamic> map) {
    JTID = map['JTID'];
    BIID = map['BIID'];
    SYID = map['SYID'];
    SUID = map['SUID'];
    SUNA = map['SUNA'];
    SUNE = map['SUNE'];
    SUPA = map['SUPA'];
    SULA = map['SULA'];
    SUST = map['SUST'];
    SUCP = map['SUCP'];
    SUNA_D = map['SUNA_D'];
    GUID = map['GUID'];
    DATEI = map['DATEI'];
    DEVI = map['DEVI'];
    SUCH = map['SUCH'];
    DATEU = map['DATEU'];
    DEVU = map['DEVU'];
  }

  String Sys_Usr_PToJson(List<Sys_Usr_P_Local> data) =>
      json.encode(List<dynamic>.from(data.map((x) => x.toMap())));
}
