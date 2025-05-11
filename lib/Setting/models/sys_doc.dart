import 'dart:convert';

class Sys_Doc_Local {
  String? STID;
  int? SDID;
  String? SDNA;
  String? SDNE;
  String? SDDA;
  String? SDDE;
  int? SDST;
  String? SDSI;
  String? SUID;
  String? SDDO;
  String? SDN3;
  String? SUCH;
  String? DATEU;
  String? DEVU;
  int? SDSIS;
  int? SDSY;
  String? RES;

  Sys_Doc_Local({required this.STID,required this.SDID,this.SDNA,this.SDNE,this.SDDA,this.SDDE,this.SDST,
    this.SDSI,this.SUID,this.SDDO,this.SDN3,this.SUCH,this.DATEU,this.DEVU,this.SDSIS,this.SDSY,this.RES});

  Map<String, dynamic> toMap() {
    var map = <String, dynamic>{
      'STID': STID,
      'SDID': SDID,
      'SDNA': SDNA,
      'SDNE': SDNE,
      'SDDA': SDDA,
      'SDDE': SDDE,
      'SDST': SDST,
      'SDSI': SDSI,
      'SUID': SUID,
      'SDDO': SDDO,
      'SDN3': SDN3,
      'SUCH': SUCH,
      'DATEU': DATEU,
      'DEVU': DEVU,
      'SDSIS': SDSIS,
      'SDSY': SDSY,
      'RES': RES,
    };
    return map;
  }

  Sys_Doc_Local.fromMap(Map<dynamic, dynamic> map) {
    STID = map['STID'];
    SDID = map['SDID'];
    SDNA = map['SDNA'];
    SDNE = map['SDNE'];
    SDDA = map['SDDA'];
    SDDE = map['SDDE'];
    SDST = map['SDST'];
    SDSI = map['SDSI'];
    SUID = map['SUID'];
    SDDO = map['SDDO'];
    SDN3 = map['SDN3'];
    SUCH = map['SUCH'];
    DATEU = map['DATEU'];
    DEVU = map['DEVU'];
    SDSIS = map['SDSIS'];
    SDSY = map['SDSY'];
    RES = map['RES'];
  }

  String Sys_DocToJson(List<Sys_Doc_Local> data) =>
      json.encode(List<dynamic>.from(data.map((x) => x.toMap())));
}
