import '../../Setting/controllers/login_controller.dart';

class Fat_Inv_Snd_Local {
  int? FISSEQ;
  String? FISGU;
  String? FCIGU;
  int? CIIDL;
  int? JTIDL;
  int? BIIDL;
  int? SYIDL;
  String? SCHNA;
  String? UUID;
  String? STID;
  String? BMMGU;
  int? FISSI;
  int? FISST;
  int? FISICV;
  int? FISPIN;
  String? FISPGU;
  String? FISPIH;
  String? FISIH;
  String? FISQR;
  String? FISZHS;
  String? FISZHSO;
  String? FISZS;
  String? FISIS;
  String? FISINF;
  var FISWE;
  int? FISEE;
  String? FISXML;
  double? FISTOT;
  double? FISSUM;
  double? FISTWV;
  String? FISSD;
  String? FISLSD;
  int? FISNS;
  String? SOMGU;
  String? SYDV_APPV;
  int? SMID;
  String? SYDV_APIV;
  String? SUID;
  String? DATEI;
  String? DATEU;
  String? STMIDI;
  int? SOMIDI;
  String? SUCH;
  String? DEVI;
  String? DEVU;
  String? STMIDU;
  int? SOMIDU;
  int? FISSTO;
  int? FISFS;
  int? JTID_L;
  int? BIID_L;
  int? SYID_L;
  String? CIID_L;
  String? FISINO;
  int? FISXE;
  int? FISXN;
  String? FISXNA;


  Fat_Inv_Snd_Local({this.UUID,this.STID,this.FISSEQ,this.FISGU,this.FCIGU,this.CIIDL,this.JTIDL,this.BIIDL,this.SYIDL,
    this.SCHNA,this.BMMGU,this.FISSI,this.FISST,this.FISICV,this.FISPIN,this.FISPGU,this.FISPIH,this.FISIH,this.FISQR,
    this.FISZHS,this.FISZHSO,this.FISZS,this.FISIS,this.FISINF,this.FISWE,this.FISEE,this.FISXML
    ,this.FISTOT,this.FISSUM,this.FISTWV,this.FISSD,this.FISLSD,this.FISNS,
    this.SOMGU,this.SYDV_APPV,this.SMID,this.SYDV_APIV,this.SUID,this.STMIDI,this.SOMIDI,this.SUCH,
    this.DATEI,this.DEVI,this.DATEU,this.DEVU,this.STMIDU,this.SOMIDU,this.FISSTO,this.JTID_L,
    this.SYID_L,this.BIID_L,this.CIID_L,this.FISINO,this.FISXE});


  Map<String, dynamic> toMap() {
    var map = <String, dynamic>{
      'UUID': UUID,
      'STID': STID,
      'FISSEQ': FISSEQ,
      'FISGU': FISGU,
      'FCIGU': FCIGU,
      'CIIDL': CIIDL,
      'JTIDL': JTIDL,
      'BIIDL': BIIDL,
      'SYIDL': SYIDL,
      'SCHNA': SCHNA,
      'BMMGU': BMMGU,
      'FISSI': FISSI,
      'FISST': FISST,
      'FISICV': FISICV,
      'FISPIN': FISPIN,
      'FISPGU': FISPGU,
      'FISPIH': FISPIH,
      'FISIH': FISIH,
      'FISQR': FISQR,
      'FISZHS': FISZHS,
      'FISZHSO': FISZHSO,
      'FISZS': FISZS,
      'FISIS': FISIS,
      'FISINF': FISINF,
      'FISWE': FISWE,
      'FISEE': FISEE,
      'FISXML': FISXML,
      'FISTOT': FISTOT,
      'FISSUM': FISSUM,
      'FISTWV': FISTWV,
      'FISSD': FISSD,
      'FISLSD': FISLSD,
      'FISNS': FISNS,
      'SOMGU': SOMGU,
      'SMID': SMID,
      'SYDV_APIV': SYDV_APIV,
      'SUID': SUID,
      'SYDV_APPV': SYDV_APPV,
      'STMIDI': STMIDI,
      'SOMIDI': SOMIDI,
      'SUCH': SUCH,
      'DATEI': DATEI,
      'DEVI': DEVI,
      'DATEU': DATEU,
      'DEVU': DEVU,
      'STMIDU': STMIDU,
      'SOMIDU': SOMIDU,
      'FISSTO': FISSTO,
      'FISINO': FISINO,
      'FISXN': FISXN,
      'FISXE': FISXE,
      'FISXNA': FISXNA,
      'JTID_L': JTID_L ?? LoginController().JTID_L,
      'SYID_L': SYID_L ?? LoginController().SYID_L,
      'BIID_L': BIID_L ?? LoginController().BIID_L,
      'CIID_L': CIID_L ?? LoginController().CIID_L,
    };
    return map;
  }

  Fat_Inv_Snd_Local.fromMap(Map<dynamic, dynamic> map) {
    UUID = map['UUID'];
    STID = map['STID'];
    FISSEQ = map['FISSEQ'];
    FCIGU = map['FCIGU'];
    CIIDL = map['CIIDL'];
    BIIDL = map['BIIDL'];
    SYIDL = map['SYIDL'];
    JTIDL = map['JTIDL'];
    SCHNA = map['SCHNA'];
    FISGU = map['FISGU'];
    BMMGU = map['BMMGU'];
    FISSI = map['FISSI'];
    FISST = map['FISST'];
    FISICV = map['FISICV'];
    FISPIN = map['FISPIN'];
    FISPGU = map['FISPGU'];
    FISPIH = map['FISPIH'];
    FISIH = map['FISIH'];
    FISIH = map['FISIH'];
    FISQR = map['FISQR'];
    FISZHS = map['FISZHS'];
    FISZHSO = map['FISZHSO'];
    FISZS = map['FISZS'];
    FISIS = map['FISIS'];
    FISINF = map['FISINF'];
    FISWE = map['FISWE'];
    FISEE = map['FISEE'];
    FISXML = map['FISXML'];
    FISTOT = map['FISTOT'];
    FISSUM = map['FISSUM'];
    FISTWV = map['FISTWV'];
    FISSD = map['FISSD'];
    FISLSD = map['FISLSD'];
    FISNS = map['FISNS'];
    SOMGU = map['SOMGU'];
    SYDV_APPV = map['SYDV_APPV'];
    SMID = map['SMID'];
    SYDV_APIV = map['SYDV_APIV'];
    SUID = map['SUID'];
    DATEI = map['DATEI'];
    DATEU = map['DATEU'];
    STMIDI = map['STMIDI'];
    SOMIDI = map['SOMIDI'];
    FISFS = map['FISFS'];
    SUCH = map['SUCH'];
    DEVI = map['DEVI'];
    DEVU = map['DEVU'];
    STMIDU = map['STMIDU'];
    SOMIDU = map['SOMIDU'];
    FISSTO = map['FISSTO'];
    FISINO = map['FISINO'];
    FISXE = map['FISXE'];
    FISXN = map['FISXN'];
    FISXNA = map['FISXNA'];
    JTID_L = map['JTID_L'];
    SYID_L = map['SYID_L'];
    BIID_L = map['BIID_L'];
    CIID_L = map['CIID_L'];
  }
}
