import '../../Setting/controllers/login_controller.dart';

class Qr_Inf_Local {
  int? QIID;
  String? QICN;
  String? QITX;
  String? QIDI;
  String? QIAM;
  String? QITM;
  String? SUID;
  String? DATEI;
  String? DEVI;
  int? JTID_L;
  int? BIID_L;
  int? SYID_L;
  String? CIID_L;


  Qr_Inf_Local({this.QIID,this.QICN,this.QITX,this.QIAM,this.QIDI
    ,this.QITM,this.SUID,this.DATEI,this.DEVI,
    this.JTID_L,this.SYID_L,this.BIID_L,this.CIID_L});


  Map<String, dynamic> toMap() {
    var map = <String, dynamic>{
      'QIID': QIID,
      'QICN': QICN,
      'QITX': QITX,
      'QIAM': QIAM,
      'QIDI': QIDI,
      'QITM': QITM,
      'SUID': SUID,
      'DATEI': DATEI,
      'DEVI': DEVI,
      'JTID_L': JTID_L ?? LoginController().JTID_L,
      'SYID_L': SYID_L ?? LoginController().SYID_L,
      'BIID_L': BIID_L ?? LoginController().BIID_L,
      'CIID_L': CIID_L ?? LoginController().CIID_L,
    };
    return map;
  }

  Qr_Inf_Local.fromMap(Map<dynamic, dynamic> map) {
    QIID = map['QIID'];
    QICN = map['QICN'];
    QITX = map['QITX'];
    QIAM = map['QIAM'];
    QITM = map['QITM'];
    QIDI = map['QIDI'];
    SUID = map['SUID'];
    DATEI = map['DATEI'];
    DEVI = map['DEVI'];
    JTID_L = map['JTID_L'];
    SYID_L = map['SYID_L'];
    BIID_L = map['BIID_L'];
    CIID_L = map['CIID_L'];
  }

}
