import '../../Setting/controllers/login_controller.dart';

class Fat_Snd_Log_D_Local {
  int? FSLSEQ;
  String? FSLGU;
  String? FSLDRQ;
  String? FSLDRC;
  String? FSLDER;
  String? FSLDRS;
  int? FSLDFS;
  int? JTID_L;
  int? BIID_L;
  int? SYID_L;
  String? CIID_L;


  Fat_Snd_Log_D_Local({this.FSLSEQ,this.FSLDRQ,this.FSLDRC,this.FSLDER,this.FSLDRS,
    this.JTID_L,this.SYID_L,this.BIID_L,this.CIID_L});


  Map<String, dynamic> toMap() {
    var map = <String, dynamic>{
      'FSLSEQ': FSLSEQ,
      'FSLGU': FSLGU,
      'FSLDRQ': FSLDRQ,
      'FSLDRC': FSLDRC,
      'FSLDER': FSLDER,
      'FSLDRS': FSLDRS,
      'JTID_L': JTID_L ?? LoginController().JTID_L,
      'SYID_L': SYID_L ?? LoginController().SYID_L,
      'BIID_L': BIID_L ?? LoginController().BIID_L,
      'CIID_L': CIID_L ?? LoginController().CIID_L,
    };
    return map;
  }

  Fat_Snd_Log_D_Local.fromMap(Map<dynamic, dynamic> map) {
    FSLSEQ = map['FSLSEQ'];
    FSLGU = map['FSLGU'];
    FSLDRQ = map['FSLDRQ'];
    FSLDRC = map['FSLDRC'];
    FSLDER = map['FSLDER'];
    FSLDRS = map['FSLDRS'];
    FSLDFS = map['FSLDFS'];
    JTID_L = map['JTID_L'];
    SYID_L = map['SYID_L'];
    BIID_L = map['BIID_L'];
    CIID_L = map['CIID_L'];
  }
}
