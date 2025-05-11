import '../../Setting/controllers/login_controller.dart';

class Cou_Wrd_Local {
  String? CWID;
  String? CWNA;
  String? CWNE;
  int? CWST;
  String? CWPT;
  int? CWTL;
  int? JTID_L;
  int? BIID_L;
  int? SYID_L;
  String? CIID_L;
  String? CWNA_D;
  String? GUID;
  String? DATEI;
  String? DEVI;
  String? SUID;
  String? SUCH;
  String? DATEU;
  String? DEVU;
  int? ORDNU;
  String? RES;
  int? DEFN;
  String? CWN3;
  String? CWCC;
  String? CWWC;
  int? CWWN;
  String? CWCC1;
  String? CWWC2;
  int? CWWN3;
  String? CWCN1;
  String? CWNAT;
  int? CWSFL;
  String? CWCN2;
  String? CWCN3;
  String? CWNAT1;
  String? CWNAT2;
  String? CWNAT3;
  Cou_Wrd_Local({this.CWID,this.CWNA,this.CWNE,this.CWST,this.CWPT,this.CWTL,this.JTID_L,
    this.ORDNU,this.RES,this.DEFN,this.CWN3,this.CWCC,this.CWWC,this.CWWN,
    this.CWCC1,this.CWWC2,this.CWWN3,this.CWCN1,this.CWNAT,this.CWSFL,this.CWCN2,
    this.CWCN3,this.CWNAT1,this.CWNAT2,this.CWNAT3,
    this.SYID_L,this.BIID_L,this.CIID_L,this.CWNA_D,this.GUID,this.DATEI,this.DEVI,this.SUCH,this.DATEU,this.DEVU,this.SUID});

  Map<String, dynamic> toMap() {
    var map = <String, dynamic>{
      'CWID': CWID,
      'CWNA': CWNA,
      'CWNE': CWNE,
      'CWST': CWST,
      'CWPT': CWPT,
      'CWTL': CWTL,
      'GUID': GUID,
      'DATEI': DATEI,
      'DEVI': DEVI,
      'SUCH': SUCH,
      'DATEU': DATEU,
      'DEVU': DEVU,
      'SUID': SUID,
      'ORDNU': ORDNU,
      'RES': RES,
      'DEFN': DEFN,
      'CWN3': CWN3,
      'CWCC': CWCC,
      'CWWC': CWWC,
      'CWWN': CWWN,
      'CWCC1': CWCC1,
      'CWWC2': CWWC2,
      'CWWN3': CWWN3,
      'CWCN1': CWCN1,
      'CWNAT': CWNAT,
      'CWSFL': CWSFL,
      'CWCN2': CWCN2,
      'CWCN3': CWCN3,
      'CWNAT1': CWNAT1,
      'CWNAT2': CWNAT2,
      'CWNAT3': CWNAT3,
      'JTID_L': JTID_L ?? LoginController().JTID_L,
      'SYID_L': SYID_L ?? LoginController().SYID_L,
      'BIID_L': BIID_L ?? LoginController().BIID_L,
      'CIID_L': CIID_L ?? LoginController().CIID_L,
    };
    return map;
  }

  Cou_Wrd_Local.fromMap(Map<dynamic, dynamic> map) {
    CWID = map['CWID'];
    CWNA = map['CWNA'];
    CWNE = map['CWNE'];
    CWST = map['CWST'];
    CWPT = map['CWPT'];
    CWTL = map['CWTL'];
    GUID = map['GUID'];
    DATEI = map['DATEI'];
    DEVI = map['DEVI'];
    SUCH = map['SUCH'];
    DATEU = map['DATEU'];
    DEVU = map['DEVU'];
    SUID = map['SUID'];
    ORDNU = map['ORDNU'];
    RES = map['RES'];
    DEFN = map['DEFN'];
    CWN3 = map['CWN3'];
    CWCC = map['CWCC'];
    CWWC = map['CWWC'];
    CWWN = map['CWWN'];
    CWCC1 = map['CWCC1'];
    CWWC2 = map['CWWC2'];
    CWWN3 = map['CWWN3'];
    CWCN1 = map['CWCN1'];
    CWNAT = map['CWNAT'];
    CWSFL = map['CWSFL'];
    CWCN2 = map['CWCN2'];
    CWCN3 = map['CWCN3'];
    CWNAT1 = map['CWNAT1'];
    CWNAT2 = map['CWNAT2'];
    CWNAT3 = map['CWNAT3'];
    JTID_L = map['JTID_L'];
    SYID_L = map['SYID_L'];
    BIID_L = map['BIID_L'];
    CIID_L = map['CIID_L'];
    CWNA_D = map['CWNA_D'];
  }

}