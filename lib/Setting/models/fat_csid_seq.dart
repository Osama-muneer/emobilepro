import '../../Setting/controllers/login_controller.dart';

class Fat_Csid_Seq_Local {
  String? FCIGU;
  int? FCSNO;
  int? FISSEQ;
  String? FISGU;
  String? FCSHA;
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
  int? FCSFS;
  int? JTID_L;
  int? BIID_L;
  int? SYID_L;
  String? CIID_L;


  Fat_Csid_Seq_Local({this.FCIGU,this.FCSNO,this.FISSEQ,this.FISGU,this.SUID,this.STMIDI,this.SOMIDI,this.SUCH,
  this.DATEI,this.DEVI,this.DATEU,this.DEVU,this.STMIDU,this.SOMIDU,this.JTID_L,this.SYID_L,this.BIID_L,this.CIID_L});


  Map<String, dynamic> toMap() {
    var map = <String, dynamic>{
      'FCIGU': FCIGU,
      'FCSNO': FCSNO,
      'FISSEQ': FISSEQ,
      'FISGU': FISGU,
      'FCSHA': FCSHA,
      'SUID': SUID,
      'STMIDI': STMIDI,
      'SOMIDI': SOMIDI,
      'SUCH': SUCH,
      'DATEI': DATEI,
      'DEVI': DEVI,
      'DATEU': DATEU,
      'DEVU': DEVU,
      'STMIDU': STMIDU,
      'SOMIDU': SOMIDU,
      'JTID_L': JTID_L ?? LoginController().JTID_L,
      'SYID_L': SYID_L ?? LoginController().SYID_L,
      'BIID_L': BIID_L ?? LoginController().BIID_L,
      'CIID_L': CIID_L ?? LoginController().CIID_L,
    };
    return map;
  }

  Fat_Csid_Seq_Local.fromMap(Map<dynamic, dynamic> map) {
    FCIGU = map['FCIGU'];
    FCSNO = map['FCSNO'];
    FISSEQ = map['FISSEQ'];
    FCSHA = map['FCSHA'];
    FISGU = map['FISGU'];
    SUID = map['SUID'];
    DATEI = map['DATEI'];
    DATEU = map['DATEU'];
    STMIDI = map['STMIDI'];
    SOMIDI = map['SOMIDI'];
    SUCH = map['SUCH'];
    DEVI = map['DEVI'];
    DEVU = map['DEVU'];
    STMIDU = map['STMIDU'];
    SOMIDU = map['SOMIDU'];
    FCSFS = map['FCSFS'];
    JTID_L = map['JTID_L'];
    SYID_L = map['SYID_L'];
    BIID_L = map['BIID_L'];
    CIID_L = map['CIID_L'];
  }
}
