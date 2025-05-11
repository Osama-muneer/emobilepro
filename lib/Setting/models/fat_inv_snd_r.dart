import '../../Setting/controllers/login_controller.dart';

class Fat_Inv_Snd_R_Local {
  String? FISRGU;
  String? FISGU;
  String? FISRTY;
  String? FISRDA;
  int? FISRFS;
  int? JTID_L;
  int? BIID_L;
  int? SYID_L;
  String? CIID_L;

  Fat_Inv_Snd_R_Local({ this.FISRGU, this.FISGU, this.FISRTY,this.FISRDA,
    this.FISRFS,this.JTID_L,this.SYID_L,this.BIID_L,this.CIID_L});

  Map<String, dynamic> toMap() {
    var map = <String, dynamic>{
      'FISRGU': FISRGU,
      'FISGU': FISGU,
      'FISRTY': FISRTY,
      'FISRDA': FISRDA,
      'FISRFS': FISRFS,
      'JTID_L': JTID_L ?? LoginController().JTID_L,
      'SYID_L': SYID_L ?? LoginController().SYID_L,
      'BIID_L': BIID_L ?? LoginController().BIID_L,
      'CIID_L': CIID_L ?? LoginController().CIID_L,
    };
    return map;
  }

  Fat_Inv_Snd_R_Local.fromMap(Map<dynamic, dynamic> map) {
    FISRGU = map['FISRGU'];
    FISGU = map['FISGU'];
    FISRTY = map['FISRTY'];
    FISRDA = map['FISRDA'];
    FISRFS = map['FISRFS'];
    JTID_L = map['JTID_L'];
    SYID_L = map['SYID_L'];
    BIID_L = map['BIID_L'];
    CIID_L = map['CIID_L'];
  }

}
