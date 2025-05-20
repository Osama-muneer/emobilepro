import '../../Setting/controllers/login_controller.dart';

class BIF_TRA_TBL_Local {
  int? BTTID;
  int? RSIDO;
  String? RTIDO;
  int? RSIDN;
  int? BTTST;
  String? RTIDN;
  String? GUIDF;
  String? GUID;
  String? STMIDI;
  int? SOMIDI;
  String? SUID;
  String? DATEI;
  String? DEVI;
  int? JTID_L;
  int? BIID_L;
  int? SYID_L;
  String? CIID_L;
  
  BIF_TRA_TBL_Local({this.BTTID,this.RSIDO,this.RTIDO,this.RSIDN,this.RTIDN,this.GUIDF,this.GUID,
     this.STMIDI,this.SOMIDI ,this.SUID,this.BTTST,this.DATEI,this.DEVI,
    this.JTID_L,this.SYID_L,this.BIID_L,this.CIID_L});


  Map<String, dynamic> toMap() {
    var map = <String, dynamic>{
      'BTTID': BTTID,
      'RSIDO': RSIDO,
      'RTIDO': RTIDO,
      'RSIDN': RSIDN,
      'RTIDN': RTIDN,
      'GUIDF': GUIDF,
      'GUID': GUID,
      'STMIDI': STMIDI,
      'SOMIDI': SOMIDI,
      'SUID': SUID,
      'BTTST': BTTST,
      'DATEI': DATEI,
      'DEVI': DEVI,
      'JTID_L': JTID_L ?? LoginController().JTID_L,
      'SYID_L': SYID_L ?? LoginController().SYID_L,
      'BIID_L': BIID_L ?? LoginController().BIID_L,
      'CIID_L': CIID_L ?? LoginController().CIID_L,
    };
    return map;
  }

  BIF_TRA_TBL_Local.fromMap(Map<dynamic, dynamic> map) {
    BTTID = map['BTTID'];
    RSIDO = map['RSIDO'];
    RTIDO = map['RTIDO'];
    RSIDN = map['RSIDN'];
    RTIDN = map['RTIDN'];
    GUIDF = map['GUIDF'];
    GUID = map['GUID'];
    STMIDI = map['STMIDI'];
    SOMIDI = map['SOMIDI'];
    SUID = map['SUID'];
    DATEI = map['DATEI'];
    BTTST = map['BTTST'];
    DEVI = map['DEVI'];
    GUID = map['GUID'];
    JTID_L = map['JTID_L'];
    SYID_L = map['SYID_L'];
    BIID_L = map['BIID_L'];
    CIID_L = map['CIID_L'];
  }
}
