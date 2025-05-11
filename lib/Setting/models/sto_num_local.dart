import '../../Setting/controllers/login_controller.dart';

class Sto_Num {
  int? SIID;
  String? MGNO ;
  var MGNA ;
  String? MINO;
  var MINA;
  int? MUID;
  var MUNA;
  String? SNED;
  double? SNNO;
  double? MPCO;
  double? SNHO;
  double? SUM;
  int? SNSA;
  String? SNDO;
  var SUID;
  String? GUID;
  String? SINA;
  int? JTID_L;
  int? BIID_L;
  int? SYID_L;
  String? CIID_L;
  String? MINA_D;
  String? MGNA_D;
  String? MUNA_D;
  String? SINA_D;
  String? DATEI;
  String? DEVI;
  String? SUCH;
  String? DATEU;
  String? DEVU;
  double? SNNOA;
  double? SUM_SNNO;
  double? SUM_MPS1;
  int? COUNT_MINO;

  Sto_Num({required this.SIID,required this.MGNO,required this.MINO, required this.MUID, this.SNED, this.SNNO, this.SNHO, this.SNSA,
    this.SNDO, this.SUID,this.GUID,this.MGNA,this.MINA,this.MUNA,this.MPCO,this.SINA,
    this.SUM,this.JTID_L,this.SYID_L,this.BIID_L,this.CIID_L,this.MGNA_D,this.MINA_D,this.MUNA_D,this.SINA_D,
    this.DATEI,this.DEVI,this.SUCH,this.DATEU,this.DEVU,this.SNNOA});

  Map<String, dynamic> toMap() {
    var map = <String, dynamic>{
      'SIID': SIID,
      'MGNO': MGNO,
      'MINO': MINO,
      'MUID': MUID,
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

  Sto_Num.fromMap(Map<dynamic, dynamic> map) {
    SIID = map['SIID'];
    MGNO = map['MGNO'];
    MGNA = map['MGNA'];
    MINO = map['MINO'];
    MINA = map['MINA'];
    MUID = map['MUID'];
    MUNA = map['MUNA'];
    SNED = map['SNED'];
    SNNO = map['SNNO'];
    SNHO = map['SNHO'];
    SNSA = map['SNSA'];
    SNDO = map['SNDO'];
    SUID = map['SUID'];
    GUID = map['GUID'];
    MPCO = map['MPCO'];
    SINA = map['SINA'];
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
    MINA_D = map['MINA_D'];
    MGNA_D = map['MGNA_D'];
    MUNA_D = map['MUNA_D'];
    SINA_D = map['SINA_D'];
    SUM_SNNO = map['SUM_SNNO'];
    SUM_MPS1 = map['SUM_MPS1'];
    COUNT_MINO = map['COUNT_MINO'];
  }
  Sto_Num.fromMapSum(Map<dynamic, dynamic> map) {
    SUM = map['SUM'];
  }
}
