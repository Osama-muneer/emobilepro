import '../../Setting/controllers/login_controller.dart';

class Ide_Typ_Local {
  int? ITID;
  String? ITNA;
  String? ITNE;
  String? ITN3;
  String? ITSY;
  int? ITST;
  int? ITAD;
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


  Ide_Typ_Local({this.ITID,this.ITNA,this.ITNE,this.ITSY,this.ITN3,this.ITAD
    ,this.ITST,this.SUID,this.SUCH,this.DATEI,this.DEVI,this.DATEU,this.DEVU,
    this.DEFN,this.RES,this.ORDNU,this.JTID_L,this.SYID_L,this.BIID_L,this.CIID_L,this.GUID});


  Map<String, dynamic> toMap() {
    var map = <String, dynamic>{
      'ITID': ITID,
      'ITNA': ITNA,
      'ITNE': ITNE,
      'ITSY': ITSY,
      'ITN3': ITN3,
      'ITAD': ITAD,
      'ITST': ITST,
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

  Ide_Typ_Local.fromMap(Map<dynamic, dynamic> map) {
    ITID = map['ITID'];
    ITNA = map['ITNA'];
    ITNE = map['ITNE'];
    ITSY = map['ITSY'];
    ITST = map['ITST'];
    ITAD = map['ITAD'];
    ITN3 = map['ITN3'];
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
  }
}
