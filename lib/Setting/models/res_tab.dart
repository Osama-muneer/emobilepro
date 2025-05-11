import '../../Setting/controllers/login_controller.dart';

class Res_Tab_Local {
  int? RSID;
  String? RTID;
  String? RTNA;
  String? RTNE;
  String? RTN3;
  int? RTST;
  int? BIID;
  String? RTIN;
  String? SUID;
  String? DATEI;
  String? DATEU;
  String? SUCH;
  String? DEVI;
  String? DEVU;
  String? RES;
  int? ORDNU;
  int? JTID_L;
  int? BIID_L;
  int? SYID_L;
  String? CIID_L;
  String? GUID;
  String? RTNA_D;


  Res_Tab_Local({this.RSID,this.RTID,this.RTNA,this.RTNE,this.RTST,this.RTN3,this.RTIN
    ,this.BIID,this.SUID,this.SUCH,this.DATEI,this.DEVI,this.DATEU,this.DEVU,
    this.RES,this.ORDNU,this.JTID_L,this.SYID_L,this.BIID_L,this.CIID_L,this.GUID});


  Map<String, dynamic> toMap() {
    var map = <String, dynamic>{
      'RSID': RSID,
      'RTID': RTID,
      'RTNA': RTNA,
      'RTNE': RTNE,
      'RTN3': RTN3,
      'RTST': RTST,
      'BIID': BIID,
      'RTIN': RTIN,
      'SUID': SUID,
      'SUCH': SUCH,
      'DATEI': DATEI,
      'DEVI': DEVI,
      'DATEU': DATEU,
      'DEVU': DEVU,
      'RES': RES,
      'ORDNU': ORDNU,
      'GUID': GUID,
      'JTID_L': JTID_L ?? LoginController().JTID_L,
      'SYID_L': SYID_L ?? LoginController().SYID_L,
      'BIID_L': BIID_L ?? LoginController().BIID_L,
      'CIID_L': CIID_L ?? LoginController().CIID_L,
    };
    return map;
  }

  Res_Tab_Local.fromMap(Map<dynamic, dynamic> map) {
    RSID = map['RSID'];
    RTID = map['RTID'];
    RTNA = map['RTNA'];
    RTNE = map['RTNE'];
    RTN3 = map['RTN3'];
    RTST = map['RTST'];
    BIID = map['BIID'];
    RTIN = map['RTIN'];
    SUID = map['SUID'];
    DATEI = map['DATEI'];
    DATEU = map['DATEU'];
    SUCH = map['SUCH'];
    DEVI = map['DEVI'];
    DEVU = map['DEVU'];
    RES = map['RES'];
    ORDNU = map['ORDNU'];
    GUID = map['GUID'];
    JTID_L = map['JTID_L'];
    SYID_L = map['SYID_L'];
    BIID_L = map['BIID_L'];
    CIID_L = map['CIID_L'];
    RTNA_D = map['RTNA_D'];
  }

}
