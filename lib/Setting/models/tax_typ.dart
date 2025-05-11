import '../../Setting/controllers/login_controller.dart';

class Tax_Typ_Local {
  int? TTID;
  int? TTSID;
  String? TTNA;
  String? TTNE;
  String? TTN3;
  String? TTSY;
  String? TTNS;
  int? TTST;
  String? TTDE;
  String? TTDA;
  int? TTSE;
  int? TTCR;
  int? TTTL;
  int? TTPE;
  int? TTTY;
  int? TTAD;
  int? TTAE;
  int? TTNT;
  int? TTDR;
  int? SCID;
  int? TTUI;
  String? TTUD;
  String? SUID;
  String? DATEI;
  String? DATEU;
  String? SUCH;
  String? DEVI;
  String? DEVU;
  String? RES;
  int? ORDNU;
  int? DEFN;
  int? JTID_L;
  int? BIID_L;
  int? SYID_L;
  String? CIID_L;
  String? GUID;
  int? TSCT;
  int? TSRA;
  int? TSPT;
  int? TTLN;
  int? TSDI;
  int? TSFR;
  int? TSQR;
  String? TTIDC;

  Tax_Typ_Local({this.TTID,this.TTSID,this.TTNA,this.TTN3,this.TTNE,this.TTNS
    ,this.TTSY,this.TTST,this.TTDE,this.TTDA,this.TTSE,this.TTCR,this.TTTL,this.TTPE,
    this.TTTY,this.TTAD,this.TTAE,this.TTNT,this.TTDR,this.SCID,this.TTUI,this.TTUD
    ,this.SUID,this.SUCH,this.DATEI,this.DEVI,this.DATEU,this.DEVU,this.TTLN,this.TTIDC,
    this.DEFN,this.RES,this.ORDNU,this.JTID_L,this.SYID_L,this.BIID_L,this.CIID_L,this.GUID});


  Map<String, dynamic> toMap() {
    var map = <String, dynamic>{
      'TTID': TTID,
      'TTSID': TTSID,
      'TTNA': TTNA,
      'TTN3': TTN3,
      'TTNE': TTNE,
      'TTNS': TTNS,
      'TTSY': TTSY,
      'TTST': TTST,
      'TTDE': TTDE,
      'TTDA': TTDA,
      'TTSE': TTSE,
      'TTCR': TTCR,
      'TTTL': TTTL,
      'TTPE': TTPE,
      'TTTY': TTTY,
      'TTAD': TTAD,
      'TTAE': TTAE,
      'TTNT': TTNT,
      'TTDR': TTDR,
      'SCID': SCID,
      'TTUI': TTUI,
      'TTUD': TTUD,
      'SUID': SUID,
      'SUCH': SUCH,
      'DATEI': DATEI,
      'DEVI': DEVI,
      'DATEU': DATEU,
      'DEVU': DEVU,
      'RES': RES,
      'ORDNU': ORDNU,
      'DEFN': DEFN,
      'GUID': GUID,
      'TTLN': TTLN,
      'TTIDC': TTIDC,
      'JTID_L': JTID_L ?? LoginController().JTID_L,
      'SYID_L': SYID_L ?? LoginController().SYID_L,
      'BIID_L': BIID_L ?? LoginController().BIID_L,
      'CIID_L': CIID_L ?? LoginController().CIID_L,
    };
    return map;
  }

  Tax_Typ_Local.fromMap(Map<dynamic, dynamic> map) {
    TTID = map['TTID'];
    TTSID = map['TTSID'];
    TTNA = map['TTNA'];
    TTN3 = map['TTN3'];
    TTSY = map['TTSY'];
    TTNS = map['TTNS'];
    TTNE = map['TTNE'];
    TTST = map['TTST'];
    TTDE = map['TTDE'];
    TTDA = map['TTDA'];
    TTSE = map['TTSE'];
    TTCR = map['TTCR'];
    TTTL = map['TTTL'];
    TTPE = map['TTPE'];
    TTTY = map['TTTY'];
    TTAD = map['TTAD'];
    TTAE = map['TTAE'];
    TTNT = map['TTNT'];
    TTDR = map['TTDR'];
    SCID = map['SCID'];
    TTUI = map['TTUI'];
    TTUD = map['TTUD'];
    SUID = map['SUID'];
    DATEI = map['DATEI'];
    DATEU = map['DATEU'];
    SUCH = map['SUCH'];
    DEVI = map['DEVI'];
    DEVU = map['DEVU'];
    RES = map['RES'];
    TTLN = map['TTLN'];
    TTIDC = map['TTIDC'];
    ORDNU = map['ORDNU'];
    DEFN = map['DEFN'];
    GUID = map['GUID'];
    JTID_L = map['JTID_L'];
    SYID_L = map['SYID_L'];
    BIID_L = map['BIID_L'];
    CIID_L = map['CIID_L'];
    TSCT = map['TSCT'];
    TSRA = map['TSRA'];
    TSPT = map['TSPT'];
    TSDI = map['TSDI'];
    TSFR = map['TSFR'];
    TSQR = map['TSQR'];
  }

}
