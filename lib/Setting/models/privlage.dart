import 'dart:convert';

class Privlage_Local {

  int? PRID;
  String? PRNA;
  String? PRNE;
  String? PRN3;
  String? STID;
  int? PRST;
  int? PRTY;

  Privlage_Local({required this.PRID,required this.PRNA,required this.PRNE,this.PRN3,this.STID,this.PRST,this.PRTY});

  Map<String, dynamic> toMap() {
    var map = <String, dynamic>{
      'PRID': PRID,
      'PRNA': PRNA,
      'PRNE': PRNE,
      'PRN3': PRN3,
      'STID': STID,
      'PRST': PRST,
      'PRTY': PRTY,
    };
    return map;
  }

  Privlage_Local.fromMap(Map<dynamic, dynamic> map) {
    PRID = map['PRID'];
    PRNA = map['PRNA'];
    PRNE = map['PRNE'];
    PRN3 = map['PRN3'];
    STID = map['STID'];
    PRST = map['PRST'];
    PRTY = map['PRTY'];
  }

  String PrivlageToJson(List<Privlage_Local> data) =>
      json.encode(List<dynamic>.from(data.map((x) => x.toMap())));
}
