import 'dart:convert';

import '../../Setting/controllers/login_controller.dart';

class Bif_Cus_D_Local {
  int? BCDID;
  String? BCDDO;
  String? BCDNA;
  String? BCDMO;
  String? BCDTL;
  String? BCDAD;
  String? CWID;
  String? CTID;
  int? BAID;
  String? BCDSN;
  String? BCDBN;
  var BCDFN;
  String? BCDHN;
  int? BCDST;
  String? BCDIN;
  int? BCID;
  int? EAID;
  String? GUIDE;
  String? GUID;
  String? SUID;
  int? SYUP;
  String? BCDMO2;
  String? BCDMO3;
  String? BCDMO4;
  String? BCDMO5;
  String? GUIDC;
  String? DATEI;
  String? DEVI;
  String? SUCH;
  String? DATEU;
  String? DEVU;
  String? RES;
  int? ORDNU;
  String? BCDNE;
  String? BCDN3;
  int? SYST_L;
  int? BCDDL_L;
  int? JTID_L;
  int? BIID_L;
  int? SYID_L;
  String? CIID_L;
  String? BCDNA_D;
  String? BCDLON;
  String? BCDLAT;


  Bif_Cus_D_Local({this.BCDID,this.BCDDO,this.BCDNA,this.BCDNE,this.BCDMO,this.BCDAD,this.CWID,this.BAID,this.BCID
    ,this.CTID,this.BCDSN,this.BCDBN,this.BCDFN,this.BCDST,this.SUID,this.SUCH,this.DATEI,this.DEVI,this.DATEU,
    this.DEVU,this.GUID,this.SYST_L,this.BCDDL_L,this.JTID_L,this.SYID_L,this.BIID_L,this.CIID_L});


  Map<String, dynamic> toMap() {
    var map = <String, dynamic>{
      'BCDID': BCDID,
      'BCDDO': BCDDO,
      'BCDNA': BCDNA,
      'BCDMO': BCDMO,
      'BCDTL': BCDTL,
      'BCDAD': BCDAD,
      'CWID': CWID,
      'CTID': CTID,
      'BAID': BAID,
      'BCDSN': BCDSN,
      'BCDBN': BCDBN,
      'BCDFN': BCDFN,
      'BCDHN': BCDHN,
      'BCDST': BCDST,
      'BCDIN': BCDIN,
      'BCID': BCID,
      'EAID': EAID,
      'GUIDE': GUIDE,
      'GUID': GUID,
      'SUID': SUID,
      'SYUP': SYUP,
      'BCDMO2': BCDMO2,
      'BCDMO3': BCDMO3,
      'BCDMO4': BCDMO4,
      'BCDMO5': BCDMO5,
      'GUIDC': GUIDC,
      'DATEI': DATEI,
      'DEVI': DEVI,
      'SUCH': SUCH,
      'DATEU': DATEU,
      'DEVU': DEVU,
      'RES': RES,
      'ORDNU': ORDNU,
      'BCDNE': BCDNE,
      'BCDN3': BCDN3,
      'BCDLON': BCDLON,
      'BCDLAT': BCDLAT,
      'SYST_L': SYST_L ?? 1,
      'BCDDL_L': BCDDL_L ?? 1,
      'JTID_L': JTID_L ?? LoginController().JTID_L,
      'SYID_L': SYID_L ?? LoginController().SYID_L,
      'BIID_L': BIID_L ?? LoginController().BIID_L,
      'CIID_L': CIID_L ?? LoginController().CIID_L,
    };
    return map;
  }

  Bif_Cus_D_Local.fromMap(Map<dynamic, dynamic> map) {
    BCDID = map['BCDID'];
    BCDDO = map['BCDDO'];
    BCDNA = map['BCDNA'];
    BCDMO = map['BCDMO'];
    BCDTL = map['BCDTL'];
    BCDAD = map['BCDAD'];
    CWID = map['CWID'];
    CTID = map['CTID'];
    BAID = map['BAID'];
    BCDSN = map['BCDSN'];
    BCDBN = map['BCDBN'];
    BCDFN = map['BCDFN'];
    BCDHN = map['BCDHN'];
    BCDST = map['BCDST'];
    BCDIN = map['BCDIN'];
    BCID = map['BCID'];
    EAID = map['EAID'];
    GUIDE = map['GUIDE'];
    GUID = map['GUID'];
    SUID = map['SUID'];
    SYUP = map['SYUP'];
    BCDMO2 = map['BCDMO2'];
    BCDN3 = map['BCDN3'];
    BCDNE = map['BCDNE'];
    JTID_L = map['JTID_L'];
    SYID_L = map['SYID_L'];
    BIID_L = map['BIID_L'];
    CIID_L = map['CIID_L'];
    SYST_L = map['SYST_L'];
    BCDDL_L = map['BCDDL_L'];
    BCDNA_D = map['BCDNA_D'];
    BCDLON = map['BCDLON'];
    BCDLAT = map['BCDLAT'];
  }

  String Bif_Cus_D_toJson(List<Bif_Cus_D_Local> data) =>
      json.encode(List<dynamic>.from(data.map((x) => x.toMap())));
}
