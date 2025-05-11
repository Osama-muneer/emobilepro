import 'dart:convert';

class Sys_Rep_Local {
  int? SRID;
  String? SRNA;
  String? SRNE;
  String? SRDE;
  String? SRIN;
  String? SRTY;
  int? SRSE;
  String? SRDES;
  int? SRST;
  int? SRKI;
  int? SRCH;
  int? SRCN;
  String? SUID;
  int? SRDT;
  String? SRDEE;
  String? SRDO;
  int? SRSN;
  String? SRNAS;
  String? SRINS;
  int? SRSES;
  String? SRDE3;
  int? SRSY;
  String? SRINE;
  String? SRIN3;
  String? STID;
  int? SDID;
  String? STIDT;
  String? SRFRM;
  String? DATEI;
  String? DEVI;
  String? SUCH;
  String? DATEU;
  String? DEVU;
  String? RES;
  String? ORDNU;
  String? SSIDT;
  int? SRXLS;
  int? SRSYN;
  int? SRSEP;
  int? SRUD;
  int? SRID2;

  Sys_Rep_Local({required this.SRID,required this.SRNA,this.SRNE,this.SRDE,this.SRIN,
    this.SRTY,this.SRSE,this.SRDES,this.SRST,this.SRKI,this.SRCH,this.SRCN
    ,this.SUID,this.SRDT,this.SRDEE,this.SRDO,this.SRSN,this.SRNAS,this.SRINS,this.SRSES
    ,this.SRDE3,this.SRSY,this.SRINE,this.SRIN3,this.STID,this.SDID,this.STIDT
    ,this.SRFRM,this.DATEI,this.DEVI,this.SUCH,this.DATEU,this.DEVU,this.RES
    ,this.ORDNU,this.SSIDT,this.SRXLS,this.SRSYN,this.SRSEP,this.SRUD,this.SRID2});

  Map<String, dynamic> toMap() {
    var map = <String, dynamic>{
      'SRID': SRID,
      'SRNA': SRNA,
      'SRNE': SRNE,
      'SRDE': SRDE,
      'SRIN': SRIN,
      'SRTY': SRTY,
      'SRSE': SRSE,
      'SRDES': SRDES,
      'SRST': SRST,
      'SRKI': SRKI,
      'SRCH': SRCH,
      'SRCN': SRCN,
      'SUID': SUID,
      'SRDT': SRDT,
      'SRDEE': SRDEE,
      'SRDO': SRDO,
      'SRSN': SRSN,
      'SRNAS': SRNAS,
      'SRINS': SRINS,
      'SRSES': SRSES,
      'SRDE3': SRDE3,
      'SRSY': SRSY,
      'SRINE': SRINE,
      'SRIN3': SRIN3,
      'STID': STID,
      'SDID': SDID,
      'STIDT': STIDT,
      'SRFRM': SRFRM,
      'DATEI': DATEI,
      'DEVI': DEVI,
      'SUCH': SUCH,
      'DATEU': DATEU,
      'DEVU': DEVU,
      'RES': RES,
      'ORDNU': ORDNU,
      'SSIDT': SSIDT,
      'SRXLS': SRXLS,
      'SRSYN': SRSYN,
      'SRSEP': SRSEP,
      'SRUD': SRUD,
      'SRID2': SRID2,
    };
    return map;
  }

  Sys_Rep_Local.fromMap(Map<dynamic, dynamic> map) {
    SRID = map['SRID '];
    SRNA = map['SRNA'];
    SRNE = map['SRNE'];
    SRDE = map['SRDE'];
    SRIN = map['SRIN'];
    SRTY = map['SRTY'];
    SRSE = map['SRSE'];
    SRDES = map['SRDES'];
    SRST = map['SRST'];
    SRKI = map['SRKI'];
    SRCH = map['SRCH'];
    SRCN = map['SRCN'];
    SUID = map['SUID'];
    SRDT = map['SRDT'];
    SRDEE = map['SRDEE'];
    SRDO = map['SRDO'];
    SRSN = map['SRSN'];
    SRNAS = map['SRNAS'];
    SRINS = map['SRINS'];
    SRSES = map['SRSES'];
    SRDE3 = map['SRDE3'];
    SRSY = map['SRSY'];
    SRINE = map['SRINE'];
    SRIN3 = map['SRIN3'];
    SDID = map['SDID'];
    STIDT = map['STIDT'];
    SRFRM = map['SRFRM'];
    RES = map['RES'];
    ORDNU = map['ORDNU'];
    SRSYN = map['SRSYN'];
    SSIDT = map['SSIDT'];
    SRXLS = map['SRXLS'];
    SRSEP = map['SRSEP'];
    SRUD = map['SRUD'];
    SRID2 = map['SRID2'];
    STID = map['STID'];
    DATEI = map['DATEI'];
    DEVI = map['DEVI'];
    SUCH = map['SUCH'];
    DATEU = map['DATEU'];
    DEVU = map['DEVU'];
  }

  String Sys_RepToJson(List<Sys_Rep_Local> data) =>
      json.encode(List<dynamic>.from(data.map((x) => x.toMap())));
}
