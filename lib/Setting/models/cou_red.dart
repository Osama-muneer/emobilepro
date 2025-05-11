import 'dart:convert';

class Cou_Red_Local {
  int? CIMID;
  int? CRLR;
  String? CRLD;
  int? CRPR;
  String? CRPD;
  String? GUID;
  int? BPMTY;
  int? BPMID;
  String? GUIDF;
  int? BPDID;
  int? BCMID;
  String? SUID;
  String? DATEI;
  String? DEVI;
  String? SUCH;
  String? DATEU;
  String? DEVU;
  int? JTID_L;
  int? BIID_L;
  int? SYID_L;
  String? CIID_L;
  String? PKNA_D;


  Cou_Red_Local({this.CIMID,this.CRLR,this.CRLD,this.CRPR,this.DATEI,this.DEVI,this.DEVU,this.DATEU,this.GUID,this.SUCH,
  this.BCMID,this.SUID,this.GUIDF,this.BPDID,this.BPMID,this.BPMTY,this.CRPD,this.JTID_L,this.SYID_L,this.BIID_L,
    this.CIID_L,this.PKNA_D});


  Map<String, dynamic> toMap() {
    var map = <String, dynamic>{
      'CIMID': CIMID,
      'CRLR': CRLR,
      'CRLD': CRLD,
      'CRPR': CRPR,
      'CRPD': CRPD,
      'GUID': GUID,
      'BPMTY': BPMTY,
      'BPMID': BPMID,
      'GUIDF': GUIDF,
      'BPDID': BPDID,
      'BCMID': BCMID,
      'SUID': SUID,
      'DATEI': DATEI,
      'DEVI': DEVI,
      'SUCH': SUCH,
      'DATEU': DATEU,
      'DEVU': DEVU,
      'JTID_L': JTID_L,
      'SYID_L': SYID_L,
      'BIID_L': BIID_L,
      'CIID_L': CIID_L,
    };
    return map;
  }

  Cou_Red_Local.fromMap(Map<dynamic, dynamic> map) {
    CIMID = map['CIMID'];
    CRLR = map['CRLR'];
    CRLD = map['CRLD'];
    CRPR = map['CRPR'];
    CRPD = map['CRPD'];
    GUID = map['GUID'];
    BPMTY = map['BPMTY'];
    BPMID = map['BPMID'];
    GUIDF = map['GUIDF'];
    BPDID = map['BPDID'];
    BCMID = map['BCMID'];
    SUID = map['SUID'];
    DATEI = map['DATEI'];
    DEVI = map['DEVI'];
    SUCH = map['SUCH'];
    DATEU = map['DATEU'];
    DEVU = map['DEVU'];
    JTID_L = map['JTID_L'];
    SYID_L = map['SYID_L'];
    BIID_L = map['BIID_L'];
    CIID_L = map['CIID_L'];
    PKNA_D = map['PKNA_D'];
  }

}
