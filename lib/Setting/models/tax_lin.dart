import '../../Setting/controllers/login_controller.dart';

class Tax_Lin_Local {
  int? TLID;
  String? TLTY;
  String? TLNO;
  String? TLNO2;
  int? TLNO3;
  int? TTID;
  int? TLIDL;
  int? TCIDI;
  int? TCSDIDI;
  int? TLRAI;
  int? TCIDO;
  int? TCSDIDO;
  int? TLRAO;
  String? TLTN;
  String? TLTN2;
  String? TLGN;
  int? TLST;
  String? TLDE;
  String? TLAF1;
  String? TLAF2;
  String? GUID_LNK;
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
  int? TCVL;
  String? TCSY;
  int? TCSVL;
  int? TCID;


  Tax_Lin_Local({this.TLID,this.TLTY,this.TLNO,this.TLNO3,this.TLNO2,this.TLIDL
    ,this.TTID,this.TCIDI,this.TCSDIDI,this.TLRAI,this.TCIDO,this.TCSDIDO,this.TLRAO,
    this.TLTN,this.TLTN2,this.TLGN,this.TLST,this.TLDE,this.TLAF1,this.TLAF2,this.GUID_LNK
    ,this.SUID,this.SUCH,this.DATEI,this.DEVI,this.DATEU,this.DEVU,
    this.DEFN,this.RES,this.ORDNU,this.JTID_L,this.SYID_L,this.BIID_L,this.CIID_L,this.GUID});


  Map<String, dynamic> toMap() {
    var map = <String, dynamic>{
      'TLID': TLID,
      'TLTY': TLTY,
      'TLNO': TLNO,
      'TLNO3': TLNO3,
      'TLNO2': TLNO2,
      'TLIDL': TLIDL,
      'TTID': TTID,
      'TCIDI': TCIDI,
      'TCSDIDI': TCSDIDI,
      'TLRAI': TLRAI,
      'TCIDO': TCIDO,
      'TCSDIDO': TCSDIDO,
      'TLRAO': TLRAO,
      'TLTN': TLTN,
      'TLTN2': TLTN2,
      'TLGN': TLGN,
      'TLST': TLST,
      'TLDE': TLDE,
      'TLAF1': TLAF1,
      'TLAF2': TLAF2,
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
      'JTID_L': JTID_L ?? LoginController().JTID_L,
      'SYID_L': SYID_L ?? LoginController().SYID_L,
      'BIID_L': BIID_L ?? LoginController().BIID_L,
      'CIID_L': CIID_L ?? LoginController().CIID_L,
    };
    return map;
  }

  Tax_Lin_Local.fromMap(Map<dynamic, dynamic> map) {
    TLID = map['TLID'];
    TLTY = map['TLTY'];
    TLNO = map['TLNO'];
    TLNO3 = map['TLNO3'];
    TTID = map['TTID'];
    TLIDL = map['TLIDL'];
    TLNO2 = map['TLNO2'];
    TCIDI = map['TCIDI'];
    TLRAI = map['TLRAI'];
    TCIDO = map['TCIDO'];
    TCSDIDO = map['TCSDIDO'];
    TCSDIDI = map['TCSDIDI'];
    TLRAO = map['TLRAO'];
    TLTN = map['TLTN'];
    TLTN2 = map['TLTN2'];
    TLGN = map['TLGN'];
    TLST = map['TLST'];
    TLDE = map['TLDE'];
    TLAF1 = map['TLAF1'];
    TLAF2 = map['TLAF2'];
    SUID = map['SUID'];
    DATEI = map['DATEI'];
    DATEU = map['DATEU'];
    SUCH = map['SUCH'];
    DEVI = map['DEVI'];
    DEVU = map['DEVU'];
    RES = map['RES'];
    ORDNU = map['ORDNU'];
    DEFN = map['DEFN'];
    GUID = map['GUID'];
    JTID_L = map['JTID_L'];
    SYID_L = map['SYID_L'];
    BIID_L = map['BIID_L'];
    CIID_L = map['CIID_L'];
    TCVL = map['TCVL'];
     TCSY = map['TCSY'];
    TCSVL = map['TCSVL'];
    TCID = map['TCID'];
  }
}
