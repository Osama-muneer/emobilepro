import '../../Setting/controllers/login_controller.dart';

class Bif_Eord_M_Local {
  int? BMKID;
  int? BMMID;
  int? BEMPS;
  int? BEMPCS;
  int? BEMIPS;
  int? BEMBS;
  String? SUID;
  String? DATEI;
  String? DATEU;
  String? SUCH;
  String? DEVI;
  String? DEVU;
  int? JTID_L;
  int? BIID_L;
  int? SYID_L;
  String? CIID_L;
  String? GUID;


  Bif_Eord_M_Local({this.BMKID,this.BMMID,this.BEMPS,this.BEMIPS,this.BEMPCS,this.BEMBS
    ,this.SUID,this.SUCH,this.DATEI,this.DEVI,this.DATEU,this.DEVU,
    this.JTID_L,this.SYID_L,this.BIID_L,this.CIID_L,this.GUID});


  Map<String, dynamic> toMap() {
    var map = <String, dynamic>{
      'BMKID': BMKID,
      'BMMID': BMMID,
      'BEMPS': BEMPS,
      'BEMPCS': BEMPCS,
      'BEMIPS': BEMIPS,
      'BEMBS': BEMBS,
      'SUID': SUID,
      'SUCH': SUCH,
      'DATEI': DATEI,
      'DEVI': DEVI,
      'DATEU': DATEU,
      'DEVU': DEVU,
      'GUID': GUID,
      'JTID_L': JTID_L ?? LoginController().JTID_L,
      'SYID_L': SYID_L ?? LoginController().SYID_L,
      'BIID_L': BIID_L ?? LoginController().BIID_L,
      'CIID_L': CIID_L ?? LoginController().CIID_L,
    };
    return map;
  }

  Bif_Eord_M_Local.fromMap(Map<dynamic, dynamic> map) {
    BMKID = map['BMKID'];
    BMMID = map['BMMID'];
    BEMPS = map['BEMPS'];
    BEMPCS = map['BEMPCS'];
    BEMIPS = map['BEMIPS'];
    BEMBS = map['BEMBS'];
    SUID = map['SUID'];
    DATEI = map['DATEI'];
    DATEU = map['DATEU'];
    SUCH = map['SUCH'];
    DEVI = map['DEVI'];
    DEVU = map['DEVU'];
    GUID = map['GUID'];
    JTID_L = map['JTID_L'];
    SYID_L = map['SYID_L'];
    BIID_L = map['BIID_L'];
    CIID_L = map['CIID_L'];
  }

}
