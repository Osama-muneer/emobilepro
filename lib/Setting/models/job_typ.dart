import 'dart:convert';

class Job_Typ_Local {
  int? JTID;
  String? JTNA;
  String? JTNE;
  int? JTST;
  String? JTDO;
  String? JTNA_D;
  String? GUID;
  String? DATEI;
  String? DEVI;
  String? SUID;
  String? SUCH;
  String? DATEU;
  String? DEVU;

  Job_Typ_Local({this.JTID,this.JTNA,this.JTNE,this.JTST,this.JTDO,this.JTNA_D,
                 this.GUID,this.DATEI,this.DEVI,this.SUID,this.SUCH,this.DATEU,this.DEVU});

  Map<String, dynamic> toMap() {
    var map = <String, dynamic>{
      'JTID': JTID,
      'JTNA': JTNA,
      'JTNE': JTNE,
      'JTST': JTST,
      'JTDO': JTDO,
      'GUID': GUID,
      'DATEI': DATEI,
      'DEVI': DEVI,
      'SUID': SUID,
      'SUCH': SUCH,
      'DATEU': DATEU,
      'DEVU': DEVU,
    };
    return map;
  }

  Job_Typ_Local.fromMap(Map<dynamic, dynamic> map) {
    JTID = map['JTID'];
    JTNA = map['JTNA'];
    JTNE = map['JTNE'];
    JTST = map['JTST'];
    JTDO = map['JTDO'];
    GUID = map['GUID'];
    DATEI = map['DATEI'];
    DEVI = map['DEVI'];
    SUID = map['SUID'];
    SUCH = map['SUCH'];
    DATEU = map['DATEU'];
    DEVU = map['DEVU'];
    JTNA_D = map['JTNA_D'];
  }

  String Job_TypToJson(List<Job_Typ_Local> data) =>
      json.encode(List<dynamic>.from(data.map((x) => x.toMap())));
}
