import 'dart:convert';

import '../../Setting/controllers/login_controller.dart';

class Bil_Poi_U_Local {
  int? BPID;
  String? BPUUS;
  int? SIID;
  int? BPUTY;
  int? BPUTI;
  var BPUFT;
  var BPUTT;
  var BPUFT2;
  var BPUTT2;
  int? BPUCT;
  int? SCID;
  String? BPUIN;
  int? BPUST;
  String? BPUDO;
  String? SUID;
  int? JTID_L;
  int? BIID_L;
  int? SYID_L;
  String? CIID_L;
  String? PKNA_D;

  int? ORDNU;
  String? RES;
  String? DATEI;
  String? DEVI;
  String? SUCH;
  String? DATEU;
  String? DEVU;
  int? DEFN;
  String? GUID;
  String? GUIDF;
  String? SCIDV;
  int? PKIDT;
  String? PKIDV;
  int? BPUPR;
  int? BPUPRT;
  String? BPUPRV;
  Bil_Poi_U_Local({this.BPID,this.BPUUS,this.SIID,this.BPUTY,this.SUID,this.SCID,this.BPUCT,this.BPUDO,this.BPUFT,
    this.BPUFT2,this.BPUIN,this.BPUST,this.BPUTI,this.BPUTT,this.BPUTT2,this.JTID_L,this.SYID_L,this.BIID_L,this.CIID_L,
    this.ORDNU,this.RES,this.DATEI,this.DEVI,this.SUCH,this.DATEU,this.DEVU,this.DEFN,this.GUID,this.GUIDF,
    this.SCIDV,this.PKIDT,this.PKIDV,this.BPUPR,this.BPUPRT,this.BPUPRV
  });
  Map<String, dynamic> toMap() {
    var map = <String, dynamic>{
      'BPID': BPID,
      'BPUUS': BPUUS,
      'SIID': SIID,
      'BPUTY': BPUTY,
      'BPUTI': BPUTI,
      'BPUFT': BPUFT,
      'BPUTT': BPUTT,
      'BPUFT2': BPUFT2,
      'BPUTT2': BPUTT2,
      'BPUCT': BPUCT,
      'SCID': SCID,
      'BPUIN': BPUIN,
      'BPUST': BPUST,
      'BPUDO': BPUDO,
      'SUID': SUID,
      'JTID_L': JTID_L ?? LoginController().JTID_L,
      'SYID_L': SYID_L ?? LoginController().SYID_L,
      'BIID_L': BIID_L ?? LoginController().BIID_L,
      'CIID_L': CIID_L ?? LoginController().CIID_L,
      'ORDNU': ORDNU,
      'RES': RES,
      'DATEI': DATEI,
      'DEVI': DEVI,
      'SUCH': SUCH,
      'DATEU': DATEU,
      'DEVU': DEVU,
      'DEFN': DEFN,
      'GUID': GUID,
      'GUIDF': GUIDF,
      'SCIDV': SCIDV,
      'PKIDT': PKIDT,
      'PKIDV': PKIDV,
      'BPUPR': BPUPR,
      'BPUPRT': BPUPRT,
      'BPUPRV': BPUPRV,
    };
    return map;
  }

  Bil_Poi_U_Local.fromMap(Map<dynamic, dynamic> map) {
    BPID = map['BPID'];
    BPUUS = map['BPUUS'];
    SIID = map['SIID'];
    BPUTY = map['BPUTY'];
    BPUTI = map['BPUTI'];
    BPUFT = map['BPUFT'];
    BPUTT = map['BPUTT'];
    BPUFT2 = map['BPUFT2'];
    BPUTT2 = map['BPUTT2'];
    BPUCT = map['BPUCT'];
    SCID = map['SCID'];
    BPUIN = map['BPUIN'];
    BPUST = map['BPUST'];
    BPUDO = map['BPUDO'];
    JTID_L = map['JTID_L'];
    SYID_L = map['SYID_L'];
    BIID_L = map['BIID_L'];
    CIID_L = map['CIID_L'];
    ORDNU = map['ORDNU'];
    RES = map['RES'];
    SUID = map['SUID'];
    DATEI = map['DATEI'];
    DEVI = map['DEVI'];
    SUCH = map['SUCH'];
    DATEU = map['DATEU'];
    DEVU = map['DEVU'];
    DEFN = map['DEFN'];
    GUID = map['GUID'];
    GUIDF = map['GUIDF'];
    SCIDV = map['SCIDV'];
    PKIDT = map['PKIDT'];
    PKIDV = map['PKIDV'];
    BPUPR = map['BPUPR'];
    BPUPRT = map['BPUPRT'];
    BPUPRV = map['BPUPRV'];
  }

  String Pay_Kin_toJson(List<Bil_Poi_U_Local> data) =>
      json.encode(List<dynamic>.from(data.map((x) => x.toMap())));
}
