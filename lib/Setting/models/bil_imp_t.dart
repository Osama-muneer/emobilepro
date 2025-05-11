import '../../Setting/controllers/login_controller.dart';

class Bil_Imp_T_Local {
  int? BITID;
  String? BITNA;
  String? BITNE;
  int? PKID;
  var BITAM;
  int? BITST;
  int? JTID_L;
  int? BIID_L;
  int? SYID_L;
  String? CIID_L;
  String? GUID;
  String? DATEI;
  String? DEVI;
  String? SUID;
  String? SUCH;
  String? DATEU;
  String? DEVU;
  String? BITNA_D;
  Bil_Imp_T_Local({this.BITID,this.BITNA,this.BITNE,this.PKID,this.BITAM,this.BITST,
    this.JTID_L,this.SYID_L,this.BIID_L,this.CIID_L,this.BITNA_D,
    this.GUID,this.DATEI,this.DEVI,this.SUCH,this.DATEU,this.DEVU,this.SUID});

  Map<String, dynamic> toMap() {
    var map = <String, dynamic>{
      'BITID': BITID,
      'BITNA': BITNA,
      'BITNE': BITNE,
      'PKID': PKID,
      'BITST': BITST,
      'GUID': GUID,
      'BITAM': BITAM,
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

  Bil_Imp_T_Local.fromMap(Map<dynamic, dynamic> map) {
    BITID = map['BITID'];
    BITNA = map['BITNA'];
    BITNE = map['BITNE'];
    PKID = map['PKID'];
    BITAM = map['BITAM'];
    BITST = map['BITST'];
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
    BITNA_D = map['BITNA_D'];
  }

}