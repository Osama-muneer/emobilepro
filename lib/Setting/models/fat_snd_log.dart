import '../../Setting/controllers/login_controller.dart';

class Fat_Snd_Log_Local {
  int? FSLSEQ;
  String? FSLGU;
  String? FSLTY;
  String? FISGU;
  String? FCIGU;
  int? CIIDL;
  int? JTIDL;
  int? BIIDL;
  int? SYIDL;
  String? SCHNA;
  String? BMMGU;
  int? FSLPT;
  int? FSLJOB;
  int? SSID;
  int? FSLSIG;
  int? FSLCIE;
  int? FSLSTP;
  int? FSLST;
  int? FSLRT;
  String? FSLMSG;
  int? FSLIS;
  String? SUID;
  String? DATEI;
  String? STMIDI;
  int? SOMIDI;
  int? FSLFS;
  String? DEVI;
  int? JTID_L;
  int? BIID_L;
  int? SYID_L;
  String? CIID_L;


  Fat_Snd_Log_Local({this.FSLSEQ,this.FSLGU,this.FSLTY,this.FISGU,this.FCIGU,this.CIIDL,this.JTIDL,this.BIIDL,this.SYIDL,
    this.SCHNA,this.BMMGU,this.FSLPT,this.FSLJOB,this.SSID,this.FSLSIG,this.FSLCIE,this.FSLSTP,this.FSLST,this.FSLRT,
    this.FSLMSG,this.FSLIS,this.SUID,this.STMIDI,this.SOMIDI,this.DATEI,this.DEVI,this.JTID_L,this.SYID_L,
    this.BIID_L,this.CIID_L});


  Map<String, dynamic> toMap() {
    var map = <String, dynamic>{
      'FSLSEQ': FSLSEQ,
      'FSLGU': FSLGU,
      'FSLTY': FSLTY,
      'FISGU': FISGU,
      'FCIGU': FCIGU,
      'CIIDL': CIIDL,
      'JTIDL': JTIDL,
      'BIIDL': BIIDL,
      'SYIDL': SYIDL,
      'SCHNA': SCHNA,
      'BMMGU': BMMGU,
      'FSLPT': FSLPT,
      'FSLJOB': FSLJOB,
      'SSID': SSID,
      'FSLSIG': FSLSIG,
      'FSLCIE': FSLCIE,
      'FSLSTP': FSLSTP,
      'FSLST': FSLST,
      'FSLRT': FSLRT,
      'FSLMSG': FSLMSG,
      'FSLIS': FSLIS,
      'SUID': SUID,
      'STMIDI': STMIDI,
      'SOMIDI': SOMIDI,
      'DATEI': DATEI,
      'DEVI': DEVI,
      'JTID_L': JTID_L ?? LoginController().JTID_L,
      'SYID_L': SYID_L ?? LoginController().SYID_L,
      'BIID_L': BIID_L ?? LoginController().BIID_L,
      'CIID_L': CIID_L ?? LoginController().CIID_L,
    };
    return map;
  }

  Fat_Snd_Log_Local.fromMap(Map<dynamic, dynamic> map) {
    FSLSEQ = map['FSLSEQ'];
    FSLGU = map['FSLGU'];
    FSLTY = map['FSLTY'];
    FCIGU = map['FCIGU'];
    CIIDL = map['CIIDL'];
    BIIDL = map['BIIDL'];
    SYIDL = map['SYIDL'];
    JTIDL = map['JTIDL'];
    SCHNA = map['SCHNA'];
    FISGU = map['FISGU'];
    BMMGU = map['BMMGU'];
    FSLPT = map['FSLPT'];
    FSLJOB = map['FSLJOB'];
    SSID = map['SSID'];
    FSLSIG = map['FSLSIG'];
    FSLCIE = map['FSLCIE'];
    FSLSTP = map['FSLSTP'];
    FSLST = map['FSLST'];
    FSLRT = map['FSLRT'];
    FSLMSG = map['FSLMSG'];
    FSLIS = map['FSLIS'];
    SUID = map['SUID'];
    DATEI = map['DATEI'];
    STMIDI = map['STMIDI'];
    SOMIDI = map['SOMIDI'];
    FSLFS = map['FSLFS'];
    DEVI = map['DEVI'];
    JTID_L = map['JTID_L'];
    SYID_L = map['SYID_L'];
    BIID_L = map['BIID_L'];
    CIID_L = map['CIID_L'];
  }
}
