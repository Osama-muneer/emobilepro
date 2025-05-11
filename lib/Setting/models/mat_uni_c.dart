import '../../Setting/controllers/login_controller.dart';

class Mat_Uni_C_Local {
  String? MGNO;
  var MINO;
  int? MUID ;
  int? MUCID;
  var MUCNO;
  String? MUCBC;
  int? MUCBT;
  String? MUCNA;
  String? MUCNE;
  String? MUCN3;
  String? GUID;
  String? SUID;
  String? MUCDO;
  int? MUIDA;
  String? MUNA;
  int? JTID_L;
  int? BIID_L;
  int? SYID_L;
  String? CIID_L;
  String? MUNA_D;
  int? MAX_MUCID;
  int? MIN_MUCID;
  int? MUCID_F;
  int? MUCID_T;
  String? DATEI;
  String? DEVI;
  String? SUCH;
  String? DATEU;
  String? DEVU;


  Mat_Uni_C_Local({ this.MGNO, this.MINO, this.MUID, this.MUCID,this.DATEI,this.DEVI,this.SUCH,this.DATEU,this.DEVU,
     this.MUCNO, this.MUCBC, this.MUCBT, this.MUCNA,this.MUNA,this.SUID,this.GUID,this.MUCDO,this.MUCN3,this.MUCNE,
      this.MUIDA,this.JTID_L,this.SYID_L,this.BIID_L,this.CIID_L,this.MUNA_D});

  Map<String, dynamic> toMap() {
    var map = <String, dynamic>{
      'MGNO': MGNO,
      'MINO': MINO,
      'MUID': MUID,
      'MUCID': MUCID,
      'MUCNO': MUCNO,
      'MUCBC': MUCBC,
      'MUCBT': MUCBT,
      'MUIDA': MUIDA,
      'MUCDO': MUCDO,
      'MUCNA': MUCNA,
      'MUCNE': MUCNE,
      'MUCN3': MUCN3,
      'GUID': GUID,
      'SUID': SUID,
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

  Mat_Uni_C_Local.fromMap(Map<dynamic, dynamic> map) {
    MGNO = map['MGNO'];
    MINO = map['MINO'];
    MUID = map['MUID'];
    MUCID = map['MUCID'];
    MUCNO = map['MUCNO'];
    MUCBC = map['MUCBC'];
    MUCBT = map['MUCBT'];
    MUIDA = map['MUIDA'];
    MUCDO = map['MUCDO'];
    MUCNA = map['MUCNA'];
    MUCNE = map['MUCNE'];
    MUCN3 = map['MUCN3'];
    GUID = map['GUID'];
    SUID = map['SUID'];
    MUNA = map['MUNA'];
    DATEI = map['DATEI'];
    DEVI = map['DEVI'];
    SUCH = map['SUCH'];
    DATEU = map['DATEU'];
    DEVU = map['DEVU'];
    JTID_L = map['JTID_L'];
    SYID_L = map['SYID_L'];
    BIID_L = map['BIID_L'];
    CIID_L = map['CIID_L'];
    MUNA_D = map['MUNA_D'];
    MAX_MUCID = map['MAX_MUCID'];
    MIN_MUCID = map['MIN_MUCID'];
    MUCID_F = map['MUCID_F'];
    MUCID_T = map['MUCID_T'];
  }

}
