import 'dart:convert';

class Sys_Yea_Local {
  int? SYID;
  String? SYSD;
  String? SYED;
  String? SYOD;
  String? SYOU;
  String? SYCD;
  String? SYCU;
  int? SYST;
  String? SYAC;
  String? SYNO;
  String? SUID;
  String? DATEI;
  String? DEVI;
  String? SUCH;
  String? DATEU;
  String? DEVU;
  int? DEFN;
  String? GUID;

  Sys_Yea_Local({this.SYID,this.SYSD,this.SYED,this.SYOD,this.SYOU,this.SYCD,this.SYCU,this.SYST,this.SYAC,
  this.SYNO,this.SUID,this.SUCH,this.DATEI,this.DATEU,this.DEFN,this.DEVI,this.DEVU,this.GUID});

  Map<String, dynamic> toMap() {
    var map = <String, dynamic>{
      'SYID': SYID,
      'SYSD': SYSD,
      'SYED': SYED,
      'SYOD': SYOD,
      'SYOU': SYOU,
      'SYCD': SYCD,
      'SYCU': SYCU,
      'SYST': SYST,
      'SYAC': SYAC,
      'SYNO': SYNO,
      'SUID': SUID,
      'DATEI': DATEI,
      'DEVI': DEVI,
      'DATEU': DATEU,
      'SUCH': SUCH,
      'DEVU': DEVU,
      'DEFN': DEFN,
      'GUID': GUID,
    };
    return map;
  }

  Sys_Yea_Local.fromMap(Map<dynamic, dynamic> map) {
    SYID = map['SYID'];
    SYSD = map['SYSD'];
    SYED = map['SYED'];
    SYOD = map['SYOD'];
    SYOU = map['SYOU'];
    SYCD = map['SYCD'];
    SYCU = map['SYCU'];
    SYST = map['SYST'];
    SYAC = map['SYAC'];
    SYNO = map['SYNO'];
    SUID = map['SUID'];
    DATEI = map['DATEI'];
    DEVI = map['DEVI'];
    DATEU = map['DATEU'];
    SUCH = map['SUCH'];
    DEVU = map['DEVU'];
    DEFN = map['DEFN'];
    GUID = map['GUID'];
  }

  String Sys_YeaToJson(List<Sys_Yea_Local> data) =>
      json.encode(List<dynamic>.from(data.map((x) => x.toMap())));
}
