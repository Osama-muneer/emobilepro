import '../../Setting/controllers/login_controller.dart';

class Bil_Cus_T_Local {
  int? BCTID;
  String? BCTNA;
  String? BCTNE;
  int? PKID;
  var BCTAM;
  int? BCTST;
  int? JTID_L;
  int? BIID_L;
  int? SYID_L;
  String? CIID_L;
  String? BCTNA_D;
  String? GUID;
  String? DATEI;
  String? DEVI;
  String? SUID;
  String? SUCH;
  String? DATEU;
  String? DEVU;
  Bil_Cus_T_Local({this.BCTID,this.BCTNA,this.BCTNE,this.PKID,this.BCTAM,this.BCTST,
                   this.JTID_L,this.SYID_L,this.BIID_L,this.CIID_L,this.BCTNA_D,
    this.GUID,this.DATEI,this.DEVI,this.SUCH,this.DATEU,this.DEVU,this.SUID});

  Map<String, dynamic> toMap() {
    var map = <String, dynamic>{
      'BCTID': BCTID,
      'BCTNA': BCTNA,
      'BCTNE': BCTNE,
      'PKID': PKID,
      'BCTST': BCTST,
      'GUID': GUID,
      'BCTAM': BCTAM,
      'DATEI': DATEI,
      'DEVI': DEVI,
      'SUCH': SUCH,
      'DATEU': DATEU,
      'DEVU': DEVU,
      'SUID': SUID,
      'JTID_L': JTID_L ?? LoginController().JTID_L,
      'SYID_L': SYID_L ?? LoginController().SYID_L,
      'BIID_L': BIID_L ?? LoginController().BIID_L,
      'CIID_L': CIID_L ?? LoginController().CIID_L,
    };
    return map;
  }

  Bil_Cus_T_Local.fromMap(Map<dynamic, dynamic> map) {
    BCTID = map['BCTID'];
    BCTNA = map['BCTNA'];
    BCTNE = map['BCTNE'];
    PKID = map['PKID'];
    BCTAM = map['BCTAM'];
    BCTST = map['BCTST'];
    GUID = map['GUID'];
    DATEI = map['DATEI'];
    DEVI = map['DEVI'];
    SUCH = map['SUCH'];
    DATEU = map['DATEU'];
    DEVU = map['DEVU'];
    SUID = map['SUID'];
    JTID_L = map['JTID_L'];
    SYID_L = map['SYID_L'];
    BIID_L = map['BIID_L'];
    CIID_L = map['CIID_L'];
    BCTNA_D = map['BCTNA_D'];
  }

}