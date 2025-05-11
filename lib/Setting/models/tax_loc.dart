import '../../Setting/controllers/login_controller.dart';

class Tax_Loc_Local {
  int? TLID;
     String? GUID;
     String? TLSY;
     String? TLNA;
     String? TLNE;
     String? TLN3;
  int? TTID;
  int? CWID;
  int? CTID;
  int? TLST;
  String? TLDE;
  String? AANOO;
  String? AANOI;
  String? AANOR;
  String? AANORR;
  int? TLDC;
  int? ORDNU;
  String? RES;
  String? SUID;
  String? DATEI;
  String? DATEU;
  String? SUCH;
  String? DEVI;
  String? DEVU;
  int? DEFN;
  int? JTID_L;
  int? BIID_L;
  int? SYID_L;
  String? CIID_L;

  Tax_Loc_Local({this.TLID,this.GUID,this.TLSY,this.TLNA,this.TLNE,this.TLN3,this.TTID,this.CWID,this.CTID,this.TLST,
    this.TLDE,this.AANOO,this.AANOI,this.AANOR,this.AANORR,this.TLDC,this.ORDNU,this.RES,this.SUID,
    this.DATEI,this.DATEU,this.SUCH,this.DEVI,this.DEVU,this.DEFN,this.JTID_L,this.SYID_L,this.BIID_L,this.CIID_L});


  Map<String, dynamic> toMap() {
    var map = <String, dynamic>{
      'TLID': TLID,
      'GUID': GUID,
      'TLSY': TLSY,
      'TLNA': TLNA,
      'TLNE': TLNE,
      'TLN3': TLN3,
      'TTID': TTID,
      'CWID': CWID,
      'CTID': CTID,
      'TLST': TLST,
      'TLDE': TLDE,
      'AANOO': AANOO,
      'AANOI': AANOI,
      'AANOR': AANOR,
      'AANORR': AANORR,
      'TLDC': TLDC,
      'ORDNU': ORDNU,
      'RES': RES,
      'SUID': SUID,
      'DATEI': DATEI,
      'DATEU': DATEU,
      'SUCH': SUCH,
      'DEVI': DEVI,
      'DEVU': DEVU,
      'DEFN': DEFN,
      'JTID_L': JTID_L ?? LoginController().JTID_L,
      'SYID_L': SYID_L ?? LoginController().SYID_L,
      'BIID_L': BIID_L ?? LoginController().BIID_L,
      'CIID_L': CIID_L ?? LoginController().CIID_L,
    };
    return map;
  }

  Tax_Loc_Local.fromMap(Map<dynamic, dynamic> map) {
    TLID = map['TLID'];
    GUID = map['GUID'];
    TLSY = map['TLSY'];
    TLNA = map['TLNA'];
    TLNE = map['TLNE'];
    TLN3 = map['TLN3'];
    TTID = map['TTID'];
    CWID = map['CWID'];
    CTID = map['CTID'];
    TLST = map['TLST'];
    TLDE = map['TLDE'];
    AANOO = map['AANOO'];
    AANOI = map['AANOI'];
    AANOR = map['AANOR'];
    AANORR = map['AANORR'];
    TLDC = map['TLDC'];
    ORDNU = map['ORDNU'];
    RES = map['RES'];
    SUID = map['SUID'];
    DATEI = map['DATEI'];
    DATEU = map['DATEU'];
    SUCH = map['SUCH'];
    DEVI = map['DEVI'];
    DEVU = map['DEVU'];
    DEFN = map['DEFN'];
    GUID = map['GUID'];
    JTID_L = map['JTID_L'];
    SYID_L = map['SYID_L'];
    BIID_L = map['BIID_L'];
    CIID_L = map['CIID_L'];
  }

}
