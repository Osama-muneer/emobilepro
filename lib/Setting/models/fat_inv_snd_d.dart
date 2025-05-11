import '../../Setting/controllers/login_controller.dart';

class Fat_Inv_Snd_D_Local {
  String? FISDGU;
  String? FISGU;
  String? FISDTY;
  String? FISDDA;
  int? FISDFS;
  int? JTID_L;
  int? BIID_L;
  int? SYID_L;
  String? CIID_L;

  Fat_Inv_Snd_D_Local({ this.FISDGU, this.FISGU, this.FISDTY,this.FISDDA,
    this.FISDFS,this.JTID_L,this.SYID_L,this.BIID_L,this.CIID_L});

  Map<String, dynamic> toMap() {
    var map = <String, dynamic>{
      'FISDGU': FISDGU,
      'FISGU': FISGU,
      'FISDTY': FISDTY,
      'FISDDA': FISDDA,
      'FISDFS': FISDFS,
      'JTID_L': JTID_L ?? LoginController().JTID_L,
      'SYID_L': SYID_L ?? LoginController().SYID_L,
      'BIID_L': BIID_L ?? LoginController().BIID_L,
      'CIID_L': CIID_L ?? LoginController().CIID_L,
    };
    return map;
  }

  Fat_Inv_Snd_D_Local.fromMap(Map<dynamic, dynamic> map) {
    FISDGU = map['FISDGU'];
    FISGU = map['FISGU'];
    FISDTY = map['FISDTY'];
    FISDDA = map['FISDDA'];
    FISDFS = map['FISDFS'];
    JTID_L = map['JTID_L'];
    SYID_L = map['SYID_L'];
    BIID_L = map['BIID_L'];
    CIID_L = map['CIID_L'];
  }

}
