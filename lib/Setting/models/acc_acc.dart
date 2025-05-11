import '../../Setting/controllers/login_controller.dart';

class Acc_Acc_Local {
  String? AANO;
  String? AANA;
  String? AANE;
  int? AATY;
  int? AKID;
  int? OKID;
  int? AGID;
  String? AAFN;
  int? AASE;
  int? AAST;
  String? AAIN;
  String? AAAD;
  String? AATL;
  String? AAFX;
  int? AACT;
  int? SCID;
  int? AAKI;
  int? AAOV;
  int? AACC;
  int? AACH;
  int? AAPR;
  int? AAPN;
  String? AADP;
  String? AADO;
  String? SUID;
  String? AADC;
  String? SUCH;
  int? AAMA;
  int? AAMN;
  int? BIID;
  int? JTID_L ;
  int? BIID_L;
  int? SYID_L;
  String? CIID_L;
  String? AANA_D;
  String? GUID;
  String? DATEI;
  String? DEVI;
  String? DATEU;
  String? DEVU;
  int? SYST_L ;

  Acc_Acc_Local({ this.AANO, this.AANA,this.AANE,this.AATY,this.AKID,this.OKID,this.AGID,
    this.AAFN,this.AASE,this.AAST,this.AAIN,this.AAAD,this.AATL,this.AAFX,this.AACT,this.SCID,this.AAKI,this.AAOV
    ,this.AACC,this.AACH,this.AAPR,this.AAPN,this.AADP,this.AADO,this.SUID,this.AADC,this.SUCH,this.AAMA
    ,this.AAMN,this.BIID,this.JTID_L,this.SYID_L,this.BIID_L,this.CIID_L,this.AANA_D,
    this.GUID,this.DATEI,this.DEVI,this.DATEU,this.DEVU,this.SYST_L});

  Map<String, dynamic> toMap() {
    var map = <String, dynamic>{
      'AANO': AANO,
      'AANA': AANA,
      'AANE': AANE,
      'AATY': AATY,
      'AKID': AKID,
      'OKID': OKID,
      'AGID': AGID,
      'AAFN': AAFN,
      'AASE': AASE,
      'AAST': AAST,
      'AAIN': AAIN,
      'AAAD': AAAD,
      'AATL': AATL,
      'AAFX': AAFX,
      'AACT': AACT,
      'SCID': SCID,
      'AAKI': AAKI,
      'AAOV': AAOV,
      'AACC': AACC,
      'AACH': AACH,
      'AAPR': AAPR,
      'AAPN': AAPN,
      'AADP': AADP,
      'AADO': AADO,
      'SUID': SUID,
      'AADC': AADC,
      'SUCH': SUCH,
      'AAMA': AAMA,
      'AAMN': AAMN,
      'BIID': BIID,
      'GUID': GUID,
      'DATEI': DATEI,
      'DEVI': DEVI,
      'DATEU': DATEU,
      'DEVU': DEVU,
      'SYST_L': SYST_L ?? 1,
      'JTID_L': JTID_L ?? LoginController().JTID_L,
      'SYID_L': SYID_L ?? LoginController().SYID_L,
      'BIID_L': BIID_L ?? LoginController().BIID_L,
      'CIID_L': CIID_L ?? LoginController().CIID_L,
    };
    return map;
  }

  Acc_Acc_Local.fromMap(Map<dynamic, dynamic> map) {
    AANO = map['AANO'];
    AANA = map['AANA'];
    AANE = map['AANE'];
    AATY = map['AATY'];
    AKID = map['AKID'];
    OKID = map['OKID'];
    AGID = map['AGID'];
    AAFN = map['AAFN'];
    AASE = map['AASE'];
    AAST = map['AAST'];
    AAIN = map['AAIN'];
    AAAD = map['AAAD'];
    AATL = map['AATL'];
    AAFX = map['AAFX'];
    AACT = map['AACT'];
    SCID = map['SCID'];
    AAKI = map['AAKI'];
    AAOV = map['AAOV'];
    AACC = map['AACC'];
    AACH = map['AACH'];
    AAPR = map['AAPR'];
    AAPN = map['AAPN'];
    AADP = map['AADP'];
    AADO = map['AADO'];
    SUID = map['SUID'];
    AADC = map['AADC'];
    SUCH = map['SUCH'];
    AAMA = map['AAMA'];
    AAMN = map['AAMN'];
    BIID = map['BIID'];
    GUID = map['GUID'];
    DATEI = map['DATEI'];
    DEVI = map['DEVI'];
    DATEU = map['DATEU'];
    DEVU = map['DEVU'];
    JTID_L = map['JTID_L'];
    SYID_L = map['SYID_L'];
    BIID_L = map['BIID_L'];
    CIID_L = map['CIID_L'];
    AANA_D = map['AANA_D'];
    SYST_L = map['SYST_L'];
  }


}
