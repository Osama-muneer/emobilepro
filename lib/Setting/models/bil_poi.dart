import 'dart:convert';

import '../../Setting/controllers/login_controller.dart';

class Bil_Poi_Local {
  int? BPID;
  String? BPNA;
  String? BPNE;
  String? AANO;
  int? BPTY;
  String? BPUS;
  int? SIID;
  int? BPST;
  int? BPCT;
  int? SCID;
  String? BPPL;
  int? BPTI;
  String? BPIN;
  String? BPDO;
  String? SUID;
  int? BIID;
  String? BPN3;
  int? BPDEVT;
  String? BPDEV;
  String? SCIDV;
  int? ORDNU;
  String? RES;
  String? DATEI;
  String? DEVI;
  String? SUCH;
  String? DATEU;
  String? DEVU;
  int? DEFN;
  String? GUID;
  String? ACNO;
  String? AANO2;
  int? JTID_L;
  int? BIID_L;
  int? SYID_L;
  String? CIID_L;
  String? BPNA_D;
  int? PKIDL;
  int? PKIDT;
  String? PKIDV;
  int? BPPR;
  int? BPPRT;
  String? BPPRV;
  int? BPSEO;
  int? BPIDT;
  String? BPIDV;

  Bil_Poi_Local({this.BPID,this.BPNA,this.BPNE, this.AANO,this.BPTY,this.BPUS,
    this.SIID,this.BPST,this.BPCT,this.SCID,this.BPPL,this.BPTI,this.BPIN,this.BPDO,this.SUID
    ,this.BIID,this.SUCH,this.ORDNU,this.RES,this.DEVU,this.DATEU,this.DEVI,this.DATEI,this.GUID,this.ACNO,this.DEFN
    ,this.AANO2,this.BPDEV,this.BPDEVT,this.BPN3,this.SCIDV,this.JTID_L,this.SYID_L,this.BIID_L,this.CIID_L,this.BPNA_D,
    this.PKIDL,this.PKIDT,this.PKIDV,this.BPPR,this.BPPRT,this.BPPRV,this.BPSEO,this.BPIDT,this.BPIDV});


  Map<String, dynamic> toMap() {
    var map = <String, dynamic>{
      'BPID': BPID,
      'BPNA': BPNA,
      'BPNE': BPNE,
      'AANO': AANO,
      'BPTY': BPTY,
      'BPUS': BPUS,
      'SIID': SIID,
      'BPST': BPST,
      'BPCT': BPCT,
      'SCID': SCID,
      'BPPL': BPPL,
      'BPTI': BPTI,
      'BPIN': BPIN,
      'BPDO': BPDO,
      'SUID': SUID,
      'BIID': BIID,
      'BPN3': BPN3,
      'BPDEVT': BPDEVT,
      'BPDEV': BPDEV,
      'SCIDV': SCIDV,
      'ORDNU': ORDNU,
      'RES': RES,
      'DATEI': RES,
      'DEVI': DEVI,
      'SUCH': SUCH,
      'DATEU': DATEU,
      'DEVU': DEVU,
      'DEFN': DEFN,
      'GUID': GUID,
      'ACNO': ACNO,
      'AANO2': AANO2,
      'JTID_L': JTID_L ?? LoginController().JTID_L,
      'SYID_L': SYID_L ?? LoginController().SYID_L,
      'BIID_L': BIID_L ?? LoginController().BIID_L,
      'CIID_L': CIID_L ?? LoginController().CIID_L,
      'PKIDL': PKIDL,
      'PKIDT': PKIDT,
      'PKIDV': PKIDV,
      'BPPR': BPPR,
      'BPPRT': BPPRT,
      'BPPRV': BPPRV,
      'BPSEO': BPSEO,
      'BPIDT': BPIDT,
      'BPIDV': BPIDV,
    };
    return map;
  }

  Bil_Poi_Local.fromMap(Map<dynamic, dynamic> map) {
    BPID = map['BPID'];
    BPNA = map['BPNA'];
    BPNE = map['BPNE'];
    AANO = map['AANO'];
    BPTY = map['BPTY'];
    BPUS = map['BPUS'];
    SIID = map['SIID'];
    BPST = map['BPST'];
    BPCT = map['BPCT'];
    SCID = map['SCID'];
    BPPL = map['BPPL'];
    BPTI = map['BPTI'];
    BPIN = map['BPIN'];
    BPDO = map['BPDO'];
    SUID = map['SUID'];
    BIID = map['BIID'];
    BPN3 = map['BPN3'];
    BPDEVT = map['BPDEVT'];
    BPDEV = map['BPDEV'];
    SCIDV = map['SCIDV'];
    ORDNU = map['ORDNU'];
    RES = map['RES'];
    DATEI = map['DATEI'];
    DEVI = map['DEVI'];
    SUCH = map['SUCH'];
    DATEU = map['DATEU'];
    DEVU = map['DEVU'];
    DEFN = map['DEFN'];
    GUID = map['GUID'];
    ACNO = map['ACNO'];
    AANO2 = map['AANO2'];
    JTID_L = map['JTID_L'];
    SYID_L = map['SYID_L'];
    BIID_L = map['BIID_L'];
    CIID_L = map['CIID_L'];
    BPNA_D = map['BPNA_D'];
    PKIDL = map['PKIDL'];
    PKIDT = map['PKIDT'];
    PKIDV = map['PKIDV'];
    BPPR = map['BPPR'];
    BPPRT = map['BPPRT'];
    BPPRV = map['BPPRV'];
    BPSEO = map['BPSEO'];
    BPIDT = map['BPIDT'];
    BPIDV = map['BPIDV'];
  }

  String Bil_Poi_toJson(List<Bil_Poi_Local> data) =>
      json.encode(List<dynamic>.from(data.map((x) => x.toMap())));
}
