import '../../Setting/controllers/login_controller.dart';

class Mat_Des_D_Local {
  int? MDMID;
  int? MDDID;
  String? MGNO;
  String? MINO;
  int? MDDST;
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
  String? MDMNA_D;


  Mat_Des_D_Local({this.MDMID,this.MDDID,this.MGNO,this.MINO,this.MDDST
    ,this.SUID,this.SUCH,this.DATEI,this.DEVI,this.DATEU,this.DEVU,
    this.RES,this.ORDNU,this.JTID_L,this.SYID_L,this.BIID_L,this.CIID_L,this.GUID,this.MDMNA_D});


  Map<String, dynamic> toMap() {
    var map = <String, dynamic>{
      'MDMID': MDMID,
      'MDDID': MDDID,
      'MGNO': MGNO,
      'MINO': MINO,
      'MDDST': MDDST,
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

  Mat_Des_D_Local.fromMap(Map<dynamic, dynamic> map) {
    MDMID = map['MDMID'];
    MDDID = map['MDDID'];
    MGNO = map['MGNO'];
    MINO = map['MINO'];
    MDDST = map['MDDST'];
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
    MDMNA_D = map['MDMNA_D'];
  }

}
