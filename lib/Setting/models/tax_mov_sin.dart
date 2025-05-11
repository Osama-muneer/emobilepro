import '../../Setting/controllers/login_controller.dart';

class Tax_Mov_Sin_Local {
  int? TMSID;
     String? GUID;
     String? TMSNA;
  String? TMSNE;
  String? TMSN3;
  String? TMSSY;
  int? TMSST;
  String? TMSDE;
  String? TMSDE2;
  int? TTID;
  int? TCID;
  int? TCSID;
  String? TCSSY;
  String? TCSDSY;
  int? TMSIT;
  int? TMSAC;
  String? TMSCO;
  int? TMSDL;
  int? TMSUP;
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

  Tax_Mov_Sin_Local({this.TMSID,this.GUID,this.TMSNA,this.TMSNE,this.TMSN3,this.TMSSY,this.TMSST,this.TMSDE,
    this.TMSDE2,this.TTID,this.TCID,this.TCSID,this.TCSSY,this.TCSDSY,this.TMSIT,this.TMSAC,this.TMSCO,this.TMSDL,
    this.TMSUP,this.ORDNU,this.RES,this.SUID,
    this.DATEI,this.DATEU,this.SUCH,this.DEVI,this.DEVU,this.DEFN,this.JTID_L,this.SYID_L,this.BIID_L,this.CIID_L});

  Map<String, dynamic> toMap() {
    var map = <String, dynamic>{
      'TMSID': TMSID,
      'GUID': GUID,
      'TMSNA': TMSNA,
      'TMSNE': TMSNE,
      'TMSN3': TMSN3,
      'TMSSY': TMSSY,
      'TMSST': TMSST,
      'TMSDE': TMSDE,
      'TMSDE2': TMSDE2,
      'TTID': TTID,
      'TCID': TCID,
      'TCSID': TCSID,
      'TCSSY': TCSSY,
      'TCSDSY': TCSDSY,
      'TMSIT': TMSIT,
      'TMSAC': TMSAC,
      'TMSCO': TMSCO,
      'TMSDL': TMSDL,
      'TMSUP': TMSUP,
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

  Tax_Mov_Sin_Local.fromMap(Map<dynamic, dynamic> map) {
    TMSID = map['TMSID'];
    GUID = map['GUID'];
    TMSNA = map['TMSNA'];
    TMSNE = map['TMSNE'];
    TMSN3 = map['TMSN3'];
    TMSSY = map['TMSSY'];
    TMSST = map['TMSST'];
    TMSDE = map['TMSDE'];
    TMSDE2 = map['TMSDE2'];
    TTID = map['TTID'];
    TCID = map['TCID'];
    TCSID = map['TCSID'];
    TCSSY = map['TCSSY'];
    TCSDSY = map['TCSDSY'];
    TMSIT = map['TMSIT'];
    TMSAC = map['TMSAC'];
    TMSCO = map['TMSCO'];
    TMSDL = map['TMSDL'];
    TMSUP = map['TMSUP'];
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
