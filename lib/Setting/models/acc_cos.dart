import 'dart:convert';

import '../../Setting/controllers/login_controller.dart';

class Acc_Cos_Local {
  String? ACNO;
  String? ACNA;
  String? ACNE;
  int? ACTY;
  int? OKID;
  int? ACST;
  String? ACFN;
  String? ACDO;
  String? SUID;
  String? DATEI;
  String? DATEU;
  String? GUID;
  String? SUCH;
  int? JTID_L;
  int? BIID_L;
  int? SYID_L;
  String? CIID_L;
  String? ACNA_D;
  String? DEVI;
  String? DEVU;

  Acc_Cos_Local({this.ACNO,this.ACNA,this.ACNE,this.ACTY,this.ACST,this.OKID,this.SUID,this.JTID_L,this.SYID_L,this.BIID_L,
                 this.CIID_L,this.ACNA_D,this.DEVI,this.DEVU,this.GUID,this.DATEU,this.DATEI,this.ACDO,this.ACFN,this.SUCH});
  Map<String, dynamic> toMap() {
    var map = <String, dynamic>{
      'ACNO': ACNO,
      'ACNA': ACNA,
      'ACNE': ACNE,
      'ACTY': ACTY,
      'OKID': OKID,
      'ACST': ACST,
    'ACFN': ACFN,
    'ACDO': ACDO,
    'SUID': SUID,
    'DATEI': DATEI,
    'DATEU': DATEU,
    'GUID': GUID,
    'SUCH': SUCH,
    'DEVI': DEVI,
    'DEVU': DEVU,
    'JTID_L': JTID_L ?? LoginController().JTID_L,
    'SYID_L': SYID_L ?? LoginController().SYID_L,
    'BIID_L': BIID_L ?? LoginController().BIID_L,
    'CIID_L': CIID_L ?? LoginController().CIID_L,
    };
    return map;
  }

  Acc_Cos_Local.fromMap(Map<dynamic, dynamic> map) {
    ACNO = map['ACNO'];
    ACNA = map['ACNA'];
    ACNE = map['ACNE'];
    ACTY = map['ACTY'];
    OKID = map['OKID'];
    ACST = map['ACST'];
    ACFN = map['ACFN'];
    ACDO = map['ACDO'];
    SUID = map['SUID'];
    DATEI = map['DATEI'];
    DATEU = map['DATEU'];
    GUID = map['GUID'];
    SUCH = map['SUCH'];
    DEVU = map['DEVU'];
    DEVI = map['DEVI'];
    JTID_L = map['JTID_L'];
    SYID_L = map['SYID_L'];
    BIID_L = map['BIID_L'];
    CIID_L = map['CIID_L'];
    ACNA_D = map['ACNA_D'];
  }

  String Job_TypToJson(List<Acc_Cos_Local> data) =>
      json.encode(List<dynamic>.from(data.map((x) => x.toMap())));
}
