import '../../Setting/controllers/login_controller.dart';

class Tax_Per_D_Local {
  int? TPDID;
  String? TPDNA;
  String? TPDNE;
  String? TPDN3;
  int? TPDNO;
  int? TPMID;
  int? TPDST;
  String? TPDFR;
  String? TPDTD;
  String? SUID;
  String? DATEI;
  String? DATEU;
  String? SUCH;
  String? DEVI;
  String? DEVU;
  String? RES;
  int? ORDNU;
  int? SYID;
  int? DEFN;
  int? JTID_L;
  int? BIID_L;
  int? SYID_L;
  String? CIID_L;
  String? GUID;


  Tax_Per_D_Local({this.TPDID,this.TPDNA,this.TPDNE,this.TPDNO
    ,this.TPDN3,this.TPMID,this.TPDST,this.TPDFR,this.TPDTD,this.SYID,
    this.SUID,this.SUCH,this.DATEI,this.DEVI,this.DATEU,this.DEVU,
    this.DEFN,this.RES,this.ORDNU,this.JTID_L,this.SYID_L,this.BIID_L,this.CIID_L,this.GUID});


  Map<String, dynamic> toMap() {
    var map = <String, dynamic>{
      'TPDID': TPDID,
      'TPDNE': TPDNE,
      'TPDNA': TPDNA,
      'TPDNO': TPDNO,
      'TPDN3': TPDN3,
      'TPMID': TPMID,
      'TPDST': TPDST,
      'TPDFR': TPDFR,
      'TPDTD': TPDTD,
      'SYID': SYID,
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

  Tax_Per_D_Local.fromMap(Map<dynamic, dynamic> map) {
    TPDID = map['TPDID'];
    TPDNE = map['TPDNE'];
    TPDN3 = map['TPDN3'];
    TPDNO = map['TPDNO'];
    TPDNA = map['TPDNA'];
    TPMID = map['TPMID'];
    TPDST = map['TPDST'];
    TPDFR = map['TPDFR'];
    TPDTD = map['TPDTD'];
    SYID = map['SYID'];
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
