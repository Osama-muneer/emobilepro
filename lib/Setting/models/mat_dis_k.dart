
import '../../Setting/controllers/login_controller.dart';

class Mat_Dis_K_Local {
  int? MDKID;
  int? MDTID;
  String? MDKNA;
  String? MDKNE;
  String? MDKN3;
  int? MDKST;
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


  Mat_Dis_K_Local({this.MDKID,this.MDTID,this.MDKNA,this.MDKNE,this.MDKST,this.MDKN3,this.SUID,
    this.JTID_L,this.SYID_L,this.BIID_L,this.CIID_L, this.GUID,this.DATEI,this.DEVI,this.SUCH,this.DATEU,this.DEVU});


  Map<String, dynamic> toMap() {
    var map = <String, dynamic>{
      'MDKID': MDKID,
      'MDTID': MDTID,
      'MDKNA': MDKNA,
      'MDKNE': MDKNE,
      'MDKN3': MDKN3,
      'MDKST': MDKST,
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

  Mat_Dis_K_Local.fromMap(Map<dynamic, dynamic> map) {
    MDKID = map['MDKID'];
    MDTID = map['MDTID'];
    MDKNA = map['MDKNA'];
    MDKNE = map['MDKNE'];
    MDKN3 = map['MDKN3'];
    MDKST = map['MDKST'];
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
