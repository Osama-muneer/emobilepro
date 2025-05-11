import '../../Setting/controllers/login_controller.dart';

class Mat_Gro_Local {
  var MGNO;
  String? MGNA;
  String? MGNE;
  String? MGN3;
  int? MGST;
  int? MGTY;
  int? MOID;
  int? MGKI;
  int? MGFN;
  String? MGNF;
  String? MGIN;
  int? MGED;
  int? MGSN;
  int? MGBC;
  int? MGPN;
  int? MGMA;
  int? MGTP;
  int? MGTS;
  int? MGGR;
  String? MGDO;
  String? SUID;
  int? ORDNU;
  int? STMID;
  String? DATEI;
  String? DEVI;
  String? SUCH;
  String? DATEU;
  String? DEVU;
  int? DEFN;
  String? RES;
  int? JTID_L;
  int? BIID_L;
  int? SYID_L;
  String? CIID_L;
  String? MGNA_D;
  String? GUID;
  Mat_Gro_Local({this.MGNO,this.MGNA,required this.MGST,required this.MGTY,required this.MOID,required this.MGKI,
    this.MGFN,this.MGNE,this.MGN3,this.MGNF,this.MGIN,this.MGED,this.MGSN,this.MGBC,this.MGPN,this.MGMA,this.MGTP,
    this.MGTS,this.MGGR,this.MGDO,this.SUID,this.ORDNU,this.STMID,this.DATEI,this.DEVI,this.DATEU,this.SUCH,
    this.DEVU,this.DEFN,this.RES,this.JTID_L,this.SYID_L,this.BIID_L,this.CIID_L,this.MGNA_D,this.GUID});

  Map<String, dynamic> toMap() {
    var map = <String, dynamic>{
      'MGNO': MGNO,
      'MGNA': MGNA,
      'MGST': MGST,
      'MGTY': MGTY,
      'MOID': MOID,
      'MGKI': MGKI,
      'MGFN': MGFN,
      'MGNE': MGNE,
      'MGN3': MGN3,
      'MGNF': MGNF,
      'MGIN': MGIN,
      'MGED': MGED,
      'MGSN': MGSN,
      'MGBC': MGBC,
      'MGPN': MGPN,
      'MGMA': MGMA,
      'MGTP': MGTP,
      'MGTS': MGTS,
      'MGGR': MGGR,
      'MGDO': MGDO,
      'SUID': SUID,
      'ORDNU': ORDNU,
      'STMID': STMID,
      'DATEI': DATEI,
      'DEVI': DEVI,
      'DATEU': DATEU,
      'SUCH': SUCH,
      'DEVU': DEVU,
      'RES': RES,
      'DEFN': DEFN,
      'GUID': GUID,
      'JTID_L': JTID_L ?? LoginController().JTID_L,
      'SYID_L': SYID_L ?? LoginController().SYID_L,
      'BIID_L': BIID_L ?? LoginController().BIID_L,
      'CIID_L': CIID_L ?? LoginController().CIID_L,
    };
    return map;
  }

  Mat_Gro_Local.fromMap(Map<dynamic, dynamic> map) {
    MGNO = map['MGNO'];
    MGNA = map['MGNA'];
    MGST = map['MGST'];
    MGTY = map['MGTY'];
    MOID = map['MOID'];
    MGKI = map['MGKI'];
    MGFN = map['MGFN'];
    MGNE = map['MGNE'];
    MGN3 = map['MGN3'];
    MGNF = map['MGNF'];
    MGIN = map['MGIN'];
    MGED = map['MGED'];
    MGSN = map['MGSN'];
    MGBC = map['MGBC'];
    MGPN = map['MGPN'];
    MGMA = map['MGMA'];
    MGTP = map['MGTP'];
    MGTS = map['MGTS'];
    MGGR = map['MGGR'];
    MGDO = map['MGDO'];
    SUID = map['SUID'];
    ORDNU = map['ORDNU'];
    STMID = map['STMID'];
    DATEI = map['DATEI'];
    DEVI = map['DEVI'];
    DATEU = map['DATEU'];
    SUCH = map['SUCH'];
    DEVU = map['DEVU'];
    RES = map['RES'];
    DEFN = map['DEFN'];
    GUID = map['GUID'];
    JTID_L = map['JTID_L'];
    SYID_L = map['SYID_L'];
    BIID_L = map['BIID_L'];
    CIID_L = map['CIID_L'];
    MGNA_D = map['MGNA_D'];
  }
}
