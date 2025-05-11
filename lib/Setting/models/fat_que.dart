import '../../Setting/controllers/login_controller.dart';

class Fat_Que_Local {
  String? FQTY;
  String? GUID;
  String? SCHNA;
  String? FQQU1;
  String? FQQU2;
  String? FQQU3;
  String? FQQU4;
  String? FQQU5;
  String? SUID;
  String? DATEI;
  String? DATEU;
  String? STMIDI;
  int? SOMIDI;
  String? SUCH;
  String? DEVI;
  String? DEVU;
  String? STMIDU;
  int? SOMIDU;
  int? JTID_L;
  int? BIID_L;
  int? SYID_L;
  String? CIID_L;

  Fat_Que_Local({ this.FQTY, this.GUID, this.SCHNA,this.FQQU1,
    this.FQQU2,this.FQQU3,this.FQQU5,this.FQQU4,this.SUID,this.STMIDI,this.SOMIDI,this.SUCH,
    this.DATEI,this.DEVI,this.DATEU,this.DEVU,this.STMIDU,this.SOMIDU,
    this.JTID_L,this.SYID_L,this.BIID_L,this.CIID_L});

  Map<String, dynamic> toMap() {
    var map = <String, dynamic>{
      'FQTY': FQTY,
      'GUID': GUID,
      'SCHNA': SCHNA,
      'FQQU1': FQQU1,
      'FQQU2': FQQU2,
      'FQQU3': FQQU3,
      'FQQU4': FQQU4,
      'FQQU5': FQQU5,
      'SUID': SUID,
      'STMIDI': STMIDI,
      'SOMIDI': SOMIDI,
      'SUCH': SUCH,
      'DATEI': DATEI,
      'DEVI': DEVI,
      'DATEU': DATEU,
      'DEVU': DEVU,
      'STMIDU': STMIDU,
      'SOMIDU': SOMIDU,
      'JTID_L': JTID_L ?? LoginController().JTID_L,
      'SYID_L': SYID_L ?? LoginController().SYID_L,
      'BIID_L': BIID_L ?? LoginController().BIID_L,
      'CIID_L': CIID_L ?? LoginController().CIID_L,
    };
    return map;
  }

  Fat_Que_Local.fromMap(Map<dynamic, dynamic> map) {
    FQTY = map['FQTY'];
    GUID = map['GUID'];
    SCHNA = map['SCHNA'];
    FQQU1 = map['FQQU1'];
    FQQU2 = map['FQQU2'];
    FQQU3 = map['FQQU3'];
    FQQU4 = map['FQQU4'];
    FQQU5 = map['FQQU5'];
    SUID = map['SUID'];
    DATEI = map['DATEI'];
    DATEU = map['DATEU'];
    STMIDI = map['STMIDI'];
    SOMIDI = map['SOMIDI'];
    SUCH = map['SUCH'];
    DEVI = map['DEVI'];
    DEVU = map['DEVU'];
    STMIDU = map['STMIDU'];
    SOMIDU = map['SOMIDU'];
    JTID_L = map['JTID_L'];
    SYID_L = map['SYID_L'];
    BIID_L = map['BIID_L'];
    CIID_L = map['CIID_L'];
  }

}
