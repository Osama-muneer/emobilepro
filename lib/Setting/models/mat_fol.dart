import '../../Setting/controllers/login_controller.dart';

class Mat_Fol_Local {
  int? BIID;
  String? MGNO;
  String? MINO;
  int? MUID;
  var MFNO;
  String? MGNOF;
  String? MINOF;
  int? MUIDF;
  var MFNOF;
  String? MFDO;
  String? MFIN;
  int? MFST;
  int? MFID;
  int? JTID_L;
  int? BIID_L;
  int? SYID_L;
  String? CIID_L;
  String? ABNA_D;
  String? SUID;
  String? SUCH;
  String? GUID;
  String? DATEI;
  String? DEVI;
  String? DATEU;
  String? DEVU;
  String? MINA_D;

  Mat_Fol_Local({this.BIID,this.MGNO,this.MINO,this.MUID,this.MFNO,this.MGNOF,this.MINOF,this.MUIDF,this.MFNOF,this.MFDO,this.MFIN,this.MFST
    ,this.MFID,this.SUID,this.SUCH,this.JTID_L,this.SYID_L,this.BIID_L,this.CIID_L,this.ABNA_D,
    this.GUID,this.DATEI,this.DEVI,this.DATEU,this.DEVU});

  Map<String, dynamic> toMap() {
    var map = <String, dynamic>{
      'BIID': BIID,
      'MGNO': MGNO,
      'MINO': MINO,
      'MUID': MUID,
      'MFNO': MFNO,
      'MGNOF': MGNOF,
      'MINOF': MINOF,
      'MUIDF': MUIDF,
      'MFNOF': MFNOF,
      'MFDO': MFDO,
      'MFIN': MFIN,
      'MFST': MFST,
      'MFID': MFID,
      'SUID': SUID,
      'SUCH': SUCH,
      'GUID': GUID,
      'DATEI': DATEI,
      'DEVI': DEVI,
      'DATEU': DATEU,
      'DEVU': DEVU,
      'JTID_L': JTID_L ?? LoginController().JTID_L,
      'SYID_L': SYID_L ?? LoginController().SYID_L,
      'BIID_L': BIID_L ?? LoginController().BIID_L,
      'CIID_L': CIID_L ?? LoginController().CIID_L,
    };
    return map;
  }
  Mat_Fol_Local.fromMap(Map<dynamic, dynamic> map) {
    BIID = map['BIID'];
    MGNO = map['MGNO'];
    MINO = map['MINO'];
    MUID = map['MUID'];
    MFNO = map['MFNO'];
    MGNOF = map['MGNOF'];
    MINOF = map['MINOF'];
    MUIDF = map['MUIDF'];
    MFNOF = map['MFNOF'];
    MFDO = map['MFDO'];
    MFIN = map['MFIN'];
    MFST = map['MFST'];
    MFID = map['MFID'];
    SUID = map['SUID'];
    SUCH = map['SUCH'];
    BIID = map['BIID'];
    GUID = map['GUID'];
    DATEI = map['DATEI'];
    DEVI = map['DEVI'];
    DATEU = map['DATEU'];
    DEVU = map['DEVU'];
    JTID_L = map['JTID_L'];
    SYID_L = map['SYID_L'];
    BIID_L = map['BIID_L'];
    CIID_L = map['CIID_L'];
    ABNA_D = map['ABNA_D'];
    MINA_D = map['MINA_D'];
  }

}
