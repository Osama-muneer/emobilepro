import '../../Setting/controllers/login_controller.dart';

class Acc_Cas_Local {
  int? ACID;
  String? ACNA;
  String? ACNE;
  String? AANO;
  int? ACCT;
  int? SCID;
  int? ACTY;
  var ACMD;
  var ACDA;
  String? SUIDT;
  int? ACTM;
  int? ACTMS;
  int? ACTMP;
  String? SUIDG;
  int? ACGM;
  int? ACGMS;
  int? ACGMP;
  int? ACST;
  String? SUID;
  String? ACDO;
  String? ACDC;
  String? SUCH;
  String? ACIN;
  int? BIID;
  int? JTID_L;
  int? BIID_L;
  int? SYID_L;
  String? CIID_L;
  String? ACNA_D;
  String? GUID;
  String? DATEI;
  String? DEVI;
  String? DATEU;
  String? DEVU;

  Acc_Cas_Local({this.ACID,this.ACNA,this.ACNE,this.AANO,this.SUID,this.SUCH,this.BIID,this.SCID,this.ACCT,this.ACDA,this.ACDC
    ,this.ACDO,this.ACGM,this.ACGMP,this.ACGMS,this.ACIN,this.ACMD,this.ACST,this.ACTM,this.ACTMP,this.ACTMS,this.ACTY
    ,this.SUIDG,this.SUIDT,this.JTID_L,this.SYID_L,this.BIID_L,this.CIID_L,this.ACNA_D,this.GUID,this.DATEI,this.DEVI,this.DATEU,this.DEVU});


  Map<String, dynamic> toMap() {
    var map = <String, dynamic>{
      'ACID': ACID,
      'ACNA': ACNA,
      'ACNE': ACNE,
      'AANO': AANO,
      'ACCT': ACCT,
      'SCID': SCID,
      'ACTY': ACTY,
      'ACMD': ACMD,
      'ACDA': ACDA,
      'SUIDT': SUIDT,
      'ACTM': ACTM,
      'ACTMS': ACTMS,
      'ACTMP': ACTMP,
      'SUIDG': SUIDG,
      'ACGM': ACGM,
      'ACGMS': ACGMS,
      'ACGMP': ACGMP,
      'ACST': ACST,
      'SUID': SUID,
      'ACDO': ACDO,
      'ACDC': ACDC,
      'SUCH': SUCH,
      'ACIN': ACIN,
      'BIID': BIID,
      'GUID': GUID,
      'DATEI': DATEI,
      'DEVI': DEVI,
      'DATEU': DATEU,
      'DEVU': DEVU,
      'JTID_L': JTID_L ?? LoginController().JTID_L,
      'SYID_L': SYID_L ?? LoginController().SYID_L,
      'BIID_L': BIID_L ?? LoginController().BIID_L,
      'CIID_L': CIID_L ?? LoginController().CIID_L,
    };
    return map;
  }

  Acc_Cas_Local.fromMap(Map<dynamic, dynamic> map) {
    ACID = map['ACID'];
    ACNA = map['ACNA'];
    ACNE = map['ACNE'];
    AANO = map['AANO'];
    ACCT = map['ACCT'];
    SCID = map['SCID'];
    ACTY = map['ACTY'];
    ACMD = map['ACMD'];
    ACDA = map['ACDA'];
    SUIDT = map['SUIDT'];
    ACTM = map['ACTM'];
    ACTMS = map['ACTMS'];
    ACTMP = map['ACTMP'];
    SUIDG = map['SUIDG'];
    ACGM = map['ACGM'];
    ACGMS = map['ACGMS'];
    ACGMP = map['ACGMP'];
    ACST = map['ACST'];
    SUID = map['SUID'];
    ACDO = map['ACDO'];
    ACDC = map['ACDC'];
    SUCH = map['SUCH'];
    ACIN = map['ACIN'];
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
    ACNA_D = map['ACNA_D'];
  }

}
