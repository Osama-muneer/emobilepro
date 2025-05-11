import '../../Setting/controllers/login_controller.dart';

class Eco_Acc_Local {

  int? EAID;
  String? EANA;
  String? EANE;
  String? EAN3;
  int? EAGID;
  int? JTID;
  int? BIID;
  int? SYID;
  int? BCID;
  String? AANO;
  int? CWID;
  String? EATL;
  int? CWID2;
  String? EATL2;
  int? CTID;
  int? BAID;
  int? EASX;
  int? EAAG;
  int? EALA;
  String? EAEM;
  int? EAST;
  int? EADL;
  String? EAAD;
  String? EAIN;
  String? EADO;
  String? SUID;
  String? EADC;
  String? SUCH;
  String? EAUS;
  String? EASC;
  int? EAET;
  String? EATLS;
  String? EATL2S;
  String? GUID;
  int? EAUP;
  String? DATEI;
  String? DEVI;
  String? DATEU;
  String? DEVU;
  int? EATST;
  String? EATSV;
  String? EAIMT;
  int? EATST2;
  String? EATSV2;
  String? EAIMT2;
  String? RES;
  String? GUIDF;
  int? JTID_L;
  int? BIID_L;
  int? SYID_L;
  String? CIID_L;

  Eco_Acc_Local({ this.EAID, this.EANA, this.EANE,this.EAN3,this.EAGID,this.JTID,this.BIID,
    this.SYID,this.JTID_L,this.SYID_L,this.BIID_L,this.CIID_L,this.GUID,this.DATEI,this.DEVI,this.SUCH,this.DATEU,this.DEVU});

  Map<String, dynamic> toMap() {
    var map = <String, dynamic>{
      'EAID': EAID,
      'EANA': EANA,
      'EANE': EANE,
      'EAN3': EAN3,
      'EAGID': EAGID,
      'JTID': JTID,
      'BIID': BIID,
      'SYID': SYID,
      'BCID': BCID,
      'AANO': AANO,
      'CWID': CWID,
      'EATL': EATL,
      'CWID2': CWID2,
      'EATL2': EATL2,
      'CTID': CTID,
      'BAID': BAID,
      'EASX': EASX,
      'EAAG': EAAG,
      'EALA': EALA,
      'EAEM': EAEM,
      'EAST': EAST,
      'EADL': EADL,
      'EAAD': EAAD,
      'EAIN': EAIN,
      'EADO': EADO,
      'SUID': SUID,
      'EADC': EADC,
      'EAUS': EAUS,
      'EASC': EASC,
      'EAET': EAET,
      'EATLS': EATLS,
      'EATL2S': EATL2S,
      'GUID': GUID,
      'EAUP': EAUP,
      'DATEI': DATEI,
      'DEVI': DEVI,
      'SUCH': SUCH,
      'DATEU': DATEU,
      'DEVU': DEVU,
      'EATST': EATST,
      'EATSV': EATSV,
      'EAIMT': EAIMT,
      'EATST2': EATST2,
      'EATSV2': EATSV2,
      'EAIMT2': EAIMT2,
      'RES': RES,
      'GUIDF': GUIDF,
      'JTID_L': JTID_L ?? LoginController().JTID_L,
      'SYID_L': SYID_L ?? LoginController().SYID_L,
      'BIID_L': BIID_L ?? LoginController().BIID_L,
      'CIID_L': CIID_L ?? LoginController().CIID_L,
    };
    return map;
  }

  Eco_Acc_Local.fromMap(Map<dynamic, dynamic> map) {
    EAID = map['EAID'];
    EANA = map['EANA'];
    EANE = map['EANE'];
    EAN3 = map['EAN3'];
    EAGID = map['EAGID'];
    JTID = map['JTID'];
    BIID = map['BIID'];
    SYID = map['SYID'];
    BCID = map['BCID'];
    AANO = map['AANO'];
    CWID = map['CWID'];
    EATL = map['EATL'];
    CWID2 = map['CWID2'];
    EATL2 = map['EATL2'];
    CTID = map['CTID'];
    BAID = map['BAID'];
    EASX = map['EASX'];
    EAAG = map['EAAG'];
    EALA = map['EALA'];
    EAEM = map['EAEM'];
    EAST = map['EAST'];
    EADL = map['EADL'];
    EAAD = map['EAAD'];
    EAIN = map['EAIN'];
    EADO = map['EADO'];
    SUID = map['SUID'];
    EADC = map['EADC'];
    EAUS = map['EAUS'];
    EASC = map['EASC'];
    EAET = map['EAET'];
    EATLS = map['EATLS'];
    EATL2S = map['EATL2S'];
    GUID = map['GUID'];
    EAUP = map['EAUP'];
    DATEI = map['DATEI'];
    DEVI = map['DEVI'];
    SUCH = map['SUCH'];
    DATEU = map['DATEU'];
    DEVU = map['DEVU'];
    EATST = map['EATST'];
    EATSV = map['EATSV'];
    EAIMT = map['EAIMT'];
    EATST2 = map['EATST2'];
    EATSV2 = map['EATSV2'];
    EAIMT2 = map['EAIMT2'];
    RES = map['RES'];
    GUIDF = map['GUIDF'];
    JTID_L = map['JTID_L'];
    SYID_L = map['SYID_L'];
    BIID_L = map['BIID_L'];
    CIID_L = map['CIID_L'];
  }

}
