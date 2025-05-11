import 'dart:convert';

class Cou_Typ_M_Local {
  int? CTMID;
  String? CTMNA;
  String? CTMNE;
  String? CTMN3;
  String? CTMDE;
  int? CTMST;
  String? MGNO;
  String? MINO;
  int? MUID;
  int? CTMCR;
  String? SUID;
  String? SUCH;
  String? DATEI;
  String? DATEU;
  String? DEVI;
  String? DEVU;
  int? ORDNU;
  int? DEFN;
  String? RES;
  int? CTMTY;
  String? GUID;
  int? JTID_L;
  int? BIID_L;
  int? SYID_L;
  String? CIID_L;
  String? CTMNA_D;


  Cou_Typ_M_Local({this.CTMID,this.CTMNA,this.CTMNE,this.CTMN3,this.SUID,this.SUCH,this.GUID,this.DEFN,this.RES,this.ORDNU
    ,this.DEVU,this.DATEU,this.DEVI,this.DATEI,this.CTMCR,this.CTMDE,this.CTMST,this.CTMTY,this.MGNO,this.MINO,this.MUID
    ,this.JTID_L,this.SYID_L,this.BIID_L,this.CIID_L,this.CTMNA_D});


  Map<String, dynamic> toMap() {
    var map = <String, dynamic>{
      'CTMID': CTMID,
      'CTMNA': CTMNA,
      'CTMNE': CTMNE,
      'CTMN3': CTMN3,
      'CTMDE': CTMDE,
      'CTMST': CTMST,
      'MGNO': MGNO,
      'MINO': MINO,
      'MUID': MUID,
      'SUID': SUID,
      'SUCH': SUCH,
      'DATEI': DATEI,
      'DEVI': DEVI,
      'DATEU': DATEU,
      'DEVU': DEVU,
      'RES': RES,
      'ORDNU': ORDNU,
      'CTMCR': CTMCR,
      'CTMTY': CTMTY,
      'GUID': GUID,
      'JTID_L': JTID_L,
      'SYID_L': SYID_L,
      'BIID_L': BIID_L,
      'CIID_L': CIID_L,
    };
    return map;
  }

  Cou_Typ_M_Local.fromMap(Map<dynamic, dynamic> map) {
    CTMID = map['CTMID'];
    CTMNA = map['CTMNA'];
    CTMNE = map['CTMNE'];
    CTMN3 = map['CTMN3'];
    CTMDE = map['CTMDE'];
    CTMST = map['CTMST'];
    MGNO = map['MGNO'];
    MINO = map['MINO'];
    MUID = map['MUID'];
    CTMCR = map['CTMCR'];
    SUID = map['SUID'];
    DATEI = map['DATEI'];
    DATEU = map['DATEU'];
    SUCH = map['SUCH'];
    DEVI = map['DEVI'];
    DEVU = map['DEVU'];
    RES = map['RES'];
    ORDNU = map['ORDNU'];
    CTMTY = map['CTMTY'];
    GUID = map['GUID'];
    JTID_L = map['JTID_L'];
    SYID_L = map['SYID_L'];
    BIID_L = map['BIID_L'];
    CIID_L = map['CIID_L'];
    CTMNA_D = map['CTMNA_D'];
  }

  String Cou_Typ_M_toJson(List<Cou_Typ_M_Local> data) =>
      json.encode(List<dynamic>.from(data.map((x) => x.toMap())));
}
