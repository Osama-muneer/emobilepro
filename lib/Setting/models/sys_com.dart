import 'dart:convert';

class Sys_Com_Local {
  int? SCID;
  String? SCNA;
  String? SCNE;
  String? CWID;
  String? CTID;
  String? SCHO;
  String? SCTL;
  String? SCMO;
  String? SCFX;
  String? SCAD;
  String? SCWE;
  String? SCEM;
  String? SCIN;
  String? SCBR;
  String? SCFA;
  String? SCTW;
  String? SCYO;
  String? SCIS;
  String? SCWA;
  String? SCQQ;
  String? SCC1;
  String? SCC2;
  String? GUID;
  String? DATEI;
  String? DEVI;
  String? SUID;
  String? SUCH;
  String? DATEU;
  String? DEVU;
  Sys_Com_Local({required this.SCID,required this.SCNA,this.SCNE,this.CWID,this.CTID,this.SCHO,this.SCTL,
    this.SCMO,this.SCFX,this.SCAD,this.SCWE,this.SCEM,this.SCBR,this.SCFA,this.SCIN,this.SCTW,this.SCYO,
    this.SCWA,this.SCQQ,this.SCIS,this.SCC1,this.SCC2,this.GUID,this.DATEI,this.DEVI,this.SUCH,this.DATEU,this.DEVU,this.SUID});

  Map<String, dynamic> toMap() {
    var map = <String, dynamic>{
      'SCID': SCID,
      'SCNA': SCNA,
      'SCNE': SCNE,
      'CWID': CWID,
      'CTID': CTID,
      'SCHO': SCHO,
      'SCTL': SCTL,
      'SCMO': SCMO,
      'SCFX': SCFX,
      'SCAD': SCAD,
      'SCWE': SCWE,
      'SCEM': SCEM,
      'SCBR': SCBR,
      'SCFA': SCFA,
      'SCIN': SCIN,
      'SCTW': SCTW,
      'SCYO': SCYO,
      'SCWA': SCWA,
      'SCQQ': SCQQ,
      'SCIS': SCIS,
      'SCC1': SCC1,
      'SCC2': SCC2,
      'GUID': GUID,
      'DATEI': DATEI,
      'DEVI': DEVI,
      'SUCH': SUCH,
      'DATEU': DATEU,
      'DEVU': DEVU,
      'SUID': SUID,
    };
    return map;
  }

  Sys_Com_Local.fromMap(Map<dynamic, dynamic> map) {
    SCID = map['SCID'];
    SCNA = map['SCNA'];
    SCNE = map['SCNE'];
    CWID = map['CWID'];
    CTID = map['CTID'];
    SCHO = map['SCHO'];
    SCTL = map['SCTL'];
    SCMO = map['SCMO'];
    SCFX = map['SCFX'];
    SCAD = map['SCAD'];
    SCWE = map['SCWE'];
    SCEM = map['SCEM'];
    SCBR = map['SCBR'];
    SCFA = map['SCFA'];
    SCIN = map['SCIN'];
    SCTW = map['SCTW'];
    SCYO = map['SCYO'];
    SCWA = map['SCWA'];
    SCQQ = map['SCQQ'];
    SCIS = map['SCIS'];
    SCC1 = map['SCC1'];
    SCC2 = map['SCC2'];
    GUID = map['GUID'];
    DATEI = map['DATEI'];
    DEVI = map['DEVI'];
    SUCH = map['SUCH'];
    DATEU = map['DATEU'];
    DEVU = map['DEVU'];
    SUID = map['SUID'];
  }

  String Sys_ComToJson(List<Sys_Com_Local> data) =>
      json.encode(List<dynamic>.from(data.map((x) => x.toMap())));
}
