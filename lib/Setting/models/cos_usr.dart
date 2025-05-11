import 'dart:convert';

import '../../Setting/controllers/login_controller.dart';

class Cos_Usr_Local {
  String? ACNO;
  int? CUST;
  String? SUAP;
  String? CUDO;
  int? CUOU;
  int? CUPR;
  int? CUDL;
  int? CUOT;
  String? SUID;
  int? JTID_L;
  int? BIID_L;
  int? SYID_L;
  String? CIID_L;
  String? GUID;
  String? DATEI;
  String? DEVI;
  String? SUCH;
  String? DATEU;
  String? DEVU;
  String? SUID2;

  Cos_Usr_Local({this.ACNO,this.CUST,this.SUAP,this.CUDO,this.CUOU,this.CUPR,this.CUDL,this.CUOT,this.SUID,
  this.JTID_L,this.SYID_L,this.BIID_L,this.CIID_L,this.GUID,this.DATEI,this.DEVI,this.SUCH,this.DATEU,this.DEVU
  });

  Map<String, dynamic> toMap() {
    var map = <String, dynamic>{
      'ACNO': ACNO,
      'CUST': CUST,
      'SUAP': SUAP,
      'CUDO': CUDO,
      'CUOU': CUOU,
      'CUPR': CUPR,
      'CUDL': CUDL,
      'CUOT': CUOT,
      'SUID': SUID,
      'GUID': GUID,
      'DATEI': DATEI,
      'DEVI': DEVI,
      'SUCH': SUCH,
      'DATEU': DATEU,
      'DEVU': DEVU,
      'SUID2': SUID2,
      'JTID_L': JTID_L ?? LoginController().JTID_L,
      'SYID_L': SYID_L ?? LoginController().SYID_L,
      'BIID_L': BIID_L ?? LoginController().BIID_L,
      'CIID_L': CIID_L ?? LoginController().CIID_L,
    };
    return map;
  }

  Cos_Usr_Local.fromMap(Map<dynamic, dynamic> map) {
    ACNO = map['ACNO'];
    CUST = map['CUST'];
    SUAP = map['SUAP'];
    CUDO = map['CUDO'];
    CUOU = map['CUOU'];
    CUPR = map['CUPR'];
    CUDL = map['CUDL'];
    CUOT = map['CUOT'];
    SUID = map['SUID'];
    GUID = map['GUID'];
    DATEI = map['DATEI'];
    DEVI = map['DEVI'];
    SUCH = map['SUCH'];
    DATEU = map['DATEU'];
    DEVU = map['DEVU'];
    SUID2 = map['SUID2'];
    JTID_L = map['JTID_L'];
    SYID_L = map['SYID_L'];
    BIID_L = map['BIID_L'];
    CIID_L = map['CIID_L'];
  }

  String Job_TypToJson(List<Cos_Usr_Local> data) =>
      json.encode(List<dynamic>.from(data.map((x) => x.toMap())));
}
