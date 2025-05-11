import '../../Setting/controllers/login_controller.dart';

class Mat_Uni_Local {
  int? MUID;
  String? MUTY;
  String? MUNA;
  String? MUNE;
  String? MUN3;
  int? MUST;
  int? ORDNU;
  String? SUID;
  String? DATEI;
  String? DEVI;
  String? SUCH;
  String? DATEU;
  String? DEVU;
  String? RES;
  String? GUID;
  int? JTID_L;
  int? BIID_L;
  int? SYID_L;
  String? CIID_L;
  String? MUNA_D;


  Mat_Uni_Local({this.MUID,this.MUTY,required this.MUNA,this.MUNE,this.MUN3,this.ORDNU,this.SUID,this.GUID,
    this.MUST,this.DATEI,this.DEVI,this.SUCH,this.DATEU,this.DEVU,this.RES,this.JTID_L,this.SYID_L,this.BIID_L,this.CIID_L});

  Map<String, dynamic> toMap() {
    var map = <String, dynamic>{
      'MUID': MUID,
      'MUTY': MUTY,
      'MUNA': MUNA,
      'MUNE': MUNE,
      'MUST': MUST,
      'ORDNU': ORDNU,
      'SUID': SUID,
      'DATEI': DATEI,
      'DEVI': DEVI,
      'SUCH': SUCH,
      'DATEU': DATEU,
      'DEVU': DEVU,
      'RES': RES,
      'GUID': GUID,
      'JTID_L': JTID_L ?? LoginController().JTID_L,
      'SYID_L': SYID_L ?? LoginController().SYID_L,
      'BIID_L': BIID_L ?? LoginController().BIID_L,
      'CIID_L': CIID_L ?? LoginController().CIID_L,
    };
    return map;
  }

  Mat_Uni_Local.fromMap(Map<dynamic, dynamic> map) {
    MUID = map['MUID'];
    MUTY = map['MUTY'];
    MUNA = map['MUNA'];
    MUNE = map['MUNE'];
    MUN3 = map['MUN3'];
    MUST = map['MUST'];
    ORDNU = map['ORDNU'];
    SUID = map['SUID'];
    DATEI = map['DATEI'];
    DEVI = map['DEVI'];
    SUCH = map['SUCH'];
    DATEU = map['DATEU'];
    DEVU = map['DEVU'];
    RES = map['RES'];
    GUID = map['GUID'];
    JTID_L = map['JTID_L'];
    SYID_L = map['SYID_L'];
    BIID_L = map['BIID_L'];
    CIID_L = map['CIID_L'];
    MUNA_D = map['MUNA_D'];
  }

}
