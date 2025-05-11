
import '../../Setting/controllers/login_controller.dart';

class Bif_Gro2_Local {
  String? MGNO;
  int? BGOR;
  String? BGBR;
  String? BGCR;
  int? BGST;
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


  Bif_Gro2_Local({this.MGNO,this.BGOR,this.BGBR,this.SUID,this.BGCR,this.BGST,
    this.JTID_L,this.SYID_L,this.BIID_L,this.CIID_L,
    this.GUID,this.DATEI,this.DEVI,this.SUCH,this.DATEU,this.DEVU});


  Map<String, dynamic> toMap() {
    var map = <String, dynamic>{
      'MGNO': MGNO,
      'BGOR': BGOR,
      'BGBR': BGBR,
      'SUID': SUID,
      'BGCR': BGCR,
      'BGST': BGST,
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

  Bif_Gro2_Local.fromMap(Map<dynamic, dynamic> map) {
    MGNO = map['MGNO'];
    BGOR = map['BGOR'];
    BGBR = map['BGBR'];
    BGCR = map['BGCR'];
    BGST = map['BGST'];
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
