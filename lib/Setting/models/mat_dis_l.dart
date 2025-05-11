
import '../../Setting/controllers/login_controller.dart';

class Mat_Dis_L_Local {
  String? GUIDM;
  String? GUIDD;
  int? MMMID;
  int? MDMID;
  int? MDLST;
  int? MCKID;
  String? SUID;
  String? GUID;
  String? DATEI;
  String? DEVI;
  String? SUCH;
  String? DATEU;
  String? DEVU;
  int? JTID_L;
  int? BIID_L;
  int? SYID_L;
  String? CIID_L;
  
  Mat_Dis_L_Local({this.GUIDM,this.GUIDD,this.MMMID,this.MDMID,this.MDLST,this.MCKID,this.SUID,
    this.JTID_L,this.SYID_L,this.BIID_L,this.CIID_L, this.GUID,this.DATEI,this.DEVI,this.SUCH,this.DATEU,this.DEVU});


  Map<String, dynamic> toMap() {
    var map = <String, dynamic>{
      'GUIDM': GUIDM,
      'GUIDD': GUIDD,
      'MMMID': MMMID,
      'MDMID': MDMID,
      'MDLST': MDLST,
      'MCKID': MCKID,
      'SUID': SUID,
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

  Mat_Dis_L_Local.fromMap(Map<dynamic, dynamic> map) {
    GUIDM = map['GUIDM'];
    GUIDD = map['GUIDD'];
    MMMID = map['MMMID'];
    MDMID = map['MDMID'];
    MDLST = map['MDLST'];
    MCKID = map['MCKID'];
    SUID = map['SUID'];
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
  }

}
