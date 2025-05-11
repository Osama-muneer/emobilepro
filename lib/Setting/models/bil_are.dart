import '../../Setting/controllers/login_controller.dart';

class Bil_Are_Local {
  int? BAID;
  String? BANA;
  String? BANE;
  String? BAN3;
  String? CWID;
  String? CTID;
  int? BAIM;
  String? BAIN;
  int? BAST;
  String? SUID;
  String? BADO;
  int? JTID_L;
  int? BIID_L;
  int? SYID_L;
  String? CIID_L;
  String? BANA_D;
  String? GUID;
  String? DATEI;
  String? DEVI;
  String? SUCH;
  String? DATEU;
  String? DEVU;
  Bil_Are_Local({this.BAID,this.BANA,this.BANE,this.CWID,this.CTID,this.BAIM,this.BAIN,this.BAST,this.SUID,this.BADO,
    this.SYID_L,this.BIID_L,this.CIID_L,this.BANA_D,this.GUID,this.DATEI,this.DEVI,this.SUCH,this.DATEU,this.DEVU});
  Map<String, dynamic> toMap() {
    var map = <String, dynamic>{
      'BAID': BAID,
      'BANA': BANA,
      'BANE': BANE,
      'BAN3': BAN3,
      'CWID': CWID,
      'CTID': CTID,
      'BAIM': BAIM,
      'BAIN': BAIN,
      'BAST': BAST,
      'SUID': SUID,
      'BADO': BADO,
      'GUID': GUID,
      'DATEI': DATEI,
      'DEVI': DEVI,
      'SUCH': SUCH,
      'DATEU': DATEU,
      'DEVU': DEVU,
      'JTID_L': JTID_L ?? LoginController().JTID_L,
      'SYID_L': SYID_L ?? LoginController().SYID_L,
      'BIID_L': BIID_L ?? LoginController().BIID_L,
      'CIID_L': CIID_L ?? LoginController().CIID_L,
    };
    return map;
  }

  Bil_Are_Local.fromMap(Map<dynamic, dynamic> map) {
    BAID = map['BAID'];
    BANA = map['BANA'];
    BANE = map['BANE'];
    BAN3 = map['BAN3'];
    CWID = map['CWID'];
    CTID = map['CTID'];
    BAIM = map['BAIM'];
    BAIN = map['BAIN'];
    BAST = map['BAST'];
    SUID = map['SUID'];
    BADO = map['BADO'];
    GUID = map['GUID'];
    DATEI = map['DATEI'];
    DEVI = map['DEVI'];
    SUCH = map['SUCH'];
    DATEU = map['DATEU'];
    DEVU = map['DEVU'];
    JTID_L = map['JTID_L'];
    SYID_L = map['SYID_L'];
    BIID_L = map['BIID_L'];
    CIID_L = map['CIID_L'];
    BANA_D = map['BANA_D'];
  }

}