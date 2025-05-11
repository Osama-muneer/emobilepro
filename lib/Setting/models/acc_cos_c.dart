import 'dart:convert';

class Acc_Cos_C_Local {
  int? ACNO;
  String? AANO;
  String? ACCTY;
  int? ACCST;
  String? ACCDO;
  String? SUID;


  Acc_Cos_C_Local({this.ACNO,this.AANO,this.ACCTY,this.ACCST,this.ACCDO,this.SUID});

  Map<String, dynamic> toMap() {
    var map = <String, dynamic>{
      'ACNO': ACNO,
      'AANO': AANO,
      'ACCTY': ACCTY,
      'ACCST': ACCST,
      'ACCDO': ACCDO,
      'SUID': SUID,
    };
    return map;
  }

  Acc_Cos_C_Local.fromMap(Map<dynamic, dynamic> map) {
    ACNO = map['ACNO'];
    AANO = map['AANO'];
    ACCTY = map['ACCTY'];
    ACCST = map['ACCST'];
    ACCDO = map['ACCDO'];
    SUID = map['SUID'];
    SUID = map['SUID'];
  }

  String Job_TypToJson(List<Acc_Cos_C_Local> data) =>
      json.encode(List<dynamic>.from(data.map((x) => x.toMap())));
}
