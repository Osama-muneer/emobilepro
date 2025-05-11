import '../../Setting/controllers/login_controller.dart';

class Sto_Num_Local {
  int? SIID;
  var MGNO;
  var MGNA;
  var MUNA;
  String? MINO;
  int? MUID;
  var SNNO;
  int? SNSA;
  String? SNDO;
  String? SNED;
  var SNHO;
  String? SUID;
  String? GUID;
  int? JTID_L;
  int? BIID_L;
  int? SYID_L;
  String? CIID_L;
  String? MUNA_D;
  String? DATEI;
  String? DEVI;
  String? SUCH;
  String? DATEU;
  String? DEVU;
  var SNNOA;
  int? COUNT_SNNO;


  Sto_Num_Local({required this.SIID, required this.MGNO,this.MGNA,required this.MINO,required this.MUID,
     this.SNED,required this.SNNO, this.SNSA,this.SNDO,this.SUID,this.GUID,this.MUNA,this.SNHO,this.JTID_L,
  this.SYID_L,this.BIID_L,this.CIID_L,this.DATEI,this.DEVI,this.SUCH,this.DATEU,this.DEVU,this.SNNOA});

  Map<String, dynamic> toMap() {
    var map = <String, dynamic>{
      'MGNO': MGNO,
      'MINO': MINO,
      'MUID': MUID,
      'SIID': SIID,
      'SNED': SNED,
      'SNNO': SNNO,
      'SNHO': SNHO,
      'SNSA': SNSA,
      'SNDO': SNDO,
      'SUID': SUID,
      'GUID': GUID,
      'SNNOA': SNNOA,
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

  Sto_Num_Local.fromMap(Map<dynamic, dynamic> map) {
    MGNO = map['MGNO'];
    MINO = map['MINO'];
    MGNA = map['MGNA'];
    MUID = map['MUID'];
    SIID = map['SIID'];
    SNED = map['SNED'];
    SNNO = map['SNNO'];
    SNHO = map['SNHO'];
    SNSA = map['SNSA'];
    SNDO = map['SNDO'];
    SUID = map['SUID'];
    GUID = map['GUID'];
    MUNA = map['MUNA'];
    SNNOA = map['SNNOA'];
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
    COUNT_SNNO = map['COUNT_SNNO'];
  }

}
