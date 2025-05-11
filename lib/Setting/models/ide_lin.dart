import '../../Setting/controllers/login_controller.dart';

class Ide_Lin_Local {
  int? ILID;
  int? ITID;
  String? ILTY;
  String? ILNO;
  String? ILNO2;
  String? ILDE;
  int? ILST;
  String? ILAF1;
  String? ILAF2;
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
  String? ITSY;
  String? ITNA;


  Ide_Lin_Local({this.ILID,this.ITID,this.ILTY,this.ILNO2,this.ILNO,this.ILST
    ,this.ILDE,this.ILAF1,this.ILAF2,this.GUID_LNK,this.SUID,this.SUCH,this.DATEI,this.DEVI,this.DATEU,this.DEVU,
    this.DEFN,this.RES,this.ORDNU,this.JTID_L,this.SYID_L,this.BIID_L,this.CIID_L,this.GUID});


  Map<String, dynamic> toMap() {
    var map = <String, dynamic>{
      'ILID': ILID,
      'ITID': ITID,
      'ILTY': ILTY,
      'ILNO2': ILNO2,
      'ILNO': ILNO,
      'ILST': ILST,
      'ILDE': ILDE,
      'ILAF1': ILAF1,
      'ILAF2': ILAF2,
      'GUID_LNK': GUID_LNK,
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

  Ide_Lin_Local.fromMap(Map<dynamic, dynamic> map) {
    ILID = map['ILID'];
    ITID = map['ITID'];
    ILTY = map['ILTY'];
    ILNO2 = map['ILNO2'];
    ILDE = map['ILDE'];
    ILST = map['ILST'];
    ILNO = map['ILNO'];
    ILAF1 = map['ILAF1'];
    ILAF2 = map['ILAF2'];
    GUID_LNK = map['GUID_LNK'];
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
    ITSY = map['ITSY'];
    ITNA = map['ITNA'];
    JTID_L = map['JTID_L'];
    SYID_L = map['SYID_L'];
    BIID_L = map['BIID_L'];
    CIID_L = map['CIID_L'];
  }
}
