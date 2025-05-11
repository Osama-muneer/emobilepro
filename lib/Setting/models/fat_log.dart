import '../../Setting/controllers/login_controller.dart';

class Fat_Log_Local {
  int? FLSEQ;
  String? GUID;
  String? FISGU;
  String? FCIGU;
  int? CIIDL;
  int? JTIDL;
  int? BIIDL;
  int? SYIDL;
  String? FCSHA;
  String? BMMGU;
  String? FLTY;
  String? FLPRO;
  String? FLMSG;
  String? FIRESD;
  String? FIRJSON;
  String? FIRDA;
  String? SUID;
  String? DATEI;
  String? DEVI;
  String? STMIDI;
  int? SOMIDI;
  int? JTID_L;
  int? BIID_L;
  int? SYID_L;
  String? CIID_L;


  Fat_Log_Local({this.FLSEQ,this.GUID,this.FISGU,this.FCIGU,this.CIIDL,this.JTIDL,this.BIIDL,this.SYIDL,
    this.FCSHA,this.BMMGU,this.FLTY,this.FLPRO,this.FLMSG,this.FIRESD,this.FIRJSON,this.FIRDA,this.SUID,this.STMIDI,
    this.SOMIDI,this.DATEI,this.DEVI,this.JTID_L,this.SYID_L,this.BIID_L,this.CIID_L});


  Map<String, dynamic> toMap() {
    var map = <String, dynamic>{
      'FLSEQ': FLSEQ,
      'GUID': GUID,
      'FISGU': FISGU,
      'FCIGU': FCIGU,
      'CIIDL': CIIDL,
      'JTIDL': JTIDL,
      'BIIDL': BIIDL,
      'SYIDL': SYIDL,
      'FCSHA': FCSHA,
      'BMMGU': BMMGU,
      'FLTY': FLTY,
      'FLPRO': FLPRO,
      'FLMSG': FLMSG,
      'FIRESD': FIRESD,
      'FIRJSON': FIRJSON,
      'FIRDA': FIRDA,
      'SUID': SUID,
      'STMIDI': STMIDI,
      'SOMIDI': SOMIDI,
      'DATEI': DATEI,
      'DEVI': DEVI,
      'JTID_L': JTID_L ?? LoginController().JTID_L,
      'SYID_L': SYID_L ?? LoginController().SYID_L,
      'BIID_L': BIID_L ?? LoginController().BIID_L,
      'CIID_L': CIID_L ?? LoginController().CIID_L,
    };
    return map;
  }

  Fat_Log_Local.fromMap(Map<dynamic, dynamic> map) {
    FLSEQ = map['FLSEQ'];
    GUID = map['GUID'];
    FCIGU = map['FCIGU'];
    CIIDL = map['CIIDL'];
    BIIDL = map['BIIDL'];
    SYIDL = map['SYIDL'];
    JTIDL = map['JTIDL'];
    FCSHA = map['FCSHA'];
    FISGU = map['FISGU'];
    BMMGU = map['BMMGU'];
    FLTY = map['FLTY'];
    FLPRO = map['FLPRO'];
    FLMSG = map['FLMSG'];
    FIRESD = map['FIRESD'];
    FIRJSON = map['FIRJSON'];
    FIRDA = map['FIRDA'];
    SUID = map['SUID'];
    DATEI = map['DATEI'];
    STMIDI = map['STMIDI'];
    SOMIDI = map['SOMIDI'];
    DEVI = map['DEVI'];
    JTID_L = map['JTID_L'];
    SYID_L = map['SYID_L'];
    BIID_L = map['BIID_L'];
    CIID_L = map['CIID_L'];
  }
}
