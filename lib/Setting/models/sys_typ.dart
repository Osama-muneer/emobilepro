import 'dart:convert';

class Sys_Typ_Local {
  String? STID;
  String? STNA;
  String? STNE;
  int? STST;
  String? STN3;
  String? STBT;
  int? ORDNU;
  int? STAC;

  Sys_Typ_Local({required this.STID,required this.STNA,this.STNE,this.STST,this.STN3,
    this.STBT,this.ORDNU,this.STAC});

  Map<String, dynamic> toMap() {
    var map = <String, dynamic>{
      'STID': STID,
      'STNA': STNA,
      'STNE': STNE,
      'STST': STST,
      'STN3': STN3,
      'STBT': STBT,
      'ORDNU': ORDNU,
      'STAC': STAC,
    };
    return map;
  }

  Sys_Typ_Local.fromMap(Map<dynamic, dynamic> map) {
    STID = map['STID'];
    STNA = map['STNA'];
    STNE = map['STNE'];
    STST = map['STST'];
    STN3 = map['STN3'];
    STBT = map['STBT'];
    ORDNU = map['ORDNU'];
    STAC = map['STAC'];
  }

  String Sys_TypToJson(List<Sys_Typ_Local> data) =>
      json.encode(List<dynamic>.from(data.map((x) => x.toMap())));
}
