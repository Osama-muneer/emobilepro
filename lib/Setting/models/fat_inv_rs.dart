import '../../Setting/controllers/login_controller.dart';

class Fat_Inv_Rs_Local {
  int? FIRSEQ;
  String? GUID;
  int? FISSEQ;
  String? FISGU;
  String? FCIGU;
  int? CIIDL;
  int? JTIDL;
  int? BIIDL;
  int? SYIDL;
  String? SCHNA;
  String? BMMGU;
  String? FIREQD;
  String? FIRESC;
  String? FIRERR;
  String? FIRESD;
  String? FIRDA;
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


  Fat_Inv_Rs_Local({this.FIRSEQ,this.GUID,this.FISSEQ,this.FISGU,this.FCIGU,this.CIIDL,this.JTIDL,this.BIIDL,this.SYIDL,
    this.SCHNA,this.BMMGU,this.FIREQD,this.FIRESC,this.FIRERR,this.FIRESD,this.FIRDA,this.SUID,this.STMIDI,this.SOMIDI,this.SUCH,
    this.DATEI,this.DEVI,this.DATEU,this.DEVU,this.STMIDU,this.SOMIDU,this.JTID_L,this.SYID_L,this.BIID_L,this.CIID_L});


  Map<String, dynamic> toMap() {
    var map = <String, dynamic>{
      'FIRSEQ': FIRSEQ,
      'GUID': GUID,
      'FISSEQ': FISSEQ,
      'FISGU': FISGU,
      'FCIGU': FCIGU,
      'CIIDL': CIIDL,
      'JTIDL': JTIDL,
      'BIIDL': BIIDL,
      'SYIDL': SYIDL,
      'SCHNA': SCHNA,
      'BMMGU': BMMGU,
      'FIREQD': FIREQD,
      'FIRESC': FIRESC,
      'FIRERR': FIRERR,
      'FIRESD': FIRESD,
      'FIRDA': FIRDA,
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

  Fat_Inv_Rs_Local.fromMap(Map<dynamic, dynamic> map) {
    FIRSEQ = map['FIRSEQ'];
    GUID = map['GUID'];
    FISSEQ = map['FISSEQ'];
    FCIGU = map['FCIGU'];
    CIIDL = map['CIIDL'];
    BIIDL = map['BIIDL'];
    SYIDL = map['SYIDL'];
    JTIDL = map['JTIDL'];
    SCHNA = map['SCHNA'];
    FISGU = map['FISGU'];
    BMMGU = map['BMMGU'];
    FIREQD = map['FIREQD'];
    FIRESC = map['FIRESC'];
    FIRERR = map['FIRERR'];
    FIRESD = map['FIRESD'];
    FIRDA = map['FIRDA'];
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
