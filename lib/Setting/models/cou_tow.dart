import '../../Setting/controllers/login_controller.dart';

class Cou_Tow_Local {
  String? CWID;
  String? CTID;
  String? CTNA;
  String? CTNE;
  String? CTN3;
  int? CTST;
  String? CTPT;
  int? JTID_L;
  int? BIID_L;
  int? SYID_L;
  String? CIID_L;
  String? CTNA_D;
  String? GUID;
  String? DATEI;
  String? DEVI;
  String? SUID;
  String? SUCH;
  String? DATEU;
  String? DEVU;
  int? DEFN;
  int? ORDNU;
  String? RES;

  Cou_Tow_Local({this.CWID,this.CTID,this.CTNA,this.CTNE,this.CTST,this.CTPT,this.JTID_L,this.SYID_L,this.DEFN,this.ORDNU,this.RES,
    this.BIID_L,this.CIID_L,this.CTNA_D, this.GUID,this.DATEI,this.DEVI,this.SUCH,this.DATEU,this.DEVU,this.SUID});

  Map<String, dynamic> toMap() {
    var map = <String, dynamic>{
      'CWID': CWID,
      'CTID': CTID,
      'CTNA': CTNA,
      'CTNE': CTNE,
      'CTST': CTST,
      'CTPT': CTPT,
      'GUID': GUID,
      'DATEI': DATEI,
      'DEVI': DEVI,
      'SUCH': SUCH,
      'DATEU': DATEU,
      'DEVU': DEVU,
      'SUID': SUID,
      'CTN3': CTN3,
      'DEFN': DEFN,
      'ORDNU': ORDNU,
      'RES': RES,
      'JTID_L': JTID_L ?? LoginController().JTID_L,
      'SYID_L': SYID_L ?? LoginController().SYID_L,
      'BIID_L': BIID_L ?? LoginController().BIID_L,
      'CIID_L': CIID_L ?? LoginController().CIID_L,
    };
    return map;
  }

  Cou_Tow_Local.fromMap(Map<dynamic, dynamic> map) {
    CWID = map['CWID'];
    CTID = map['CTID'];
    CTNA = map['CTNA'];
    CTNE = map['CTNE'];
    CTN3 = map['CTN3'];
    CTST = map['CTST'];
    CTPT = map['CTPT'];
    GUID = map['GUID'];
    DATEI = map['DATEI'];
    DEVI = map['DEVI'];
    SUCH = map['SUCH'];
    DATEU = map['DATEU'];
    DEVU = map['DEVU'];
    SUID = map['SUID'];
    DEFN = map['DEFN'];
    ORDNU = map['ORDNU'];
    RES = map['RES'];
    JTID_L = map['JTID_L'];
    SYID_L = map['SYID_L'];
    BIID_L = map['BIID_L'];
    CIID_L = map['CIID_L'];
    CTNA_D = map['CTNA_D'];
  }

}