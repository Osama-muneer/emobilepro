import '../../Setting/controllers/login_controller.dart';

class Acc_Ban_Local {
  int? ABID;
  String? ABNA;
  String? ABNE;
  String? AANO;
  int? ABCT;
  int? SCID;
  String? ABNO;
  String? ABAD;
  String? ABTL;
  String? ABFX;
  String? ABIN;
  String? ABWE;
  String? ABEM;
  String? ABHN;
  String? ABJO;
  String? ABHT;
  String? ABCB;
  int? ABS1T;
  String? ABS1;
  int? ABST;
  String? SUID;
  String? ABDO;
  String? ABDC;
  String? SUCH;
  int? BIID;
  int? JTID_L;
  int? BIID_L;
  int? SYID_L;
  String? CIID_L;
  String? ABNA_D;
  String? GUID;
  String? DATEI;
  String? DEVI;
  String? DATEU;
  String? DEVU;

  Acc_Ban_Local({this.ABID,this.ABNA,this.ABNE,this.AANO,this.ABCT,this.SCID,this.ABNO,this.ABAD,this.ABTL,this.ABFX,this.ABIN
    ,this.ABWE,this.ABEM,this.ABHN,this.ABJO,this.ABHT,this.ABCB,this.ABS1T,this.ABS1,this.ABST,this.SUID,this.ABDO
    ,this.ABDC,this.SUCH,this.BIID,this.JTID_L,this.SYID_L,this.BIID_L,this.CIID_L,this.ABNA_D,
    this.GUID,this.DATEI,this.DEVI,this.DATEU,this.DEVU});

  Map<String, dynamic> toMap() {
    var map = <String, dynamic>{
      'ABID': ABID,
      'ABNA': ABNA,
      'ABNE': ABNE,
      'AANO': AANO,
      'ABCT': ABCT,
      'SCID': SCID,
      'ABNO': ABNO,
      'ABAD': ABAD,
      'ABTL': ABTL,
      'ABFX': ABFX,
      'ABIN': ABIN,
      'ABWE': ABWE,
      'ABEM': ABEM,
      'ABHN': ABHN,
      'ABJO': ABJO,
      'ABHT': ABHT,
      'ABCB': ABCB,
      'ABS1T': ABS1T,
      'ABS1': ABS1,
      'ABST': ABST,
      'SUID': SUID,
      'ABDO': ABDO,
      'ABDC': ABDC,
      'SUCH': SUCH,
      'BIID': BIID,
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
  Acc_Ban_Local.fromMap(Map<dynamic, dynamic> map) {
    ABID = map['ABID'];
    ABNA = map['ABNA'];
    ABNE = map['ABNE'];
    AANO = map['AANO'];
    ABCT = map['ABCT'];
    SCID = map['SCID'];
    ABNO = map['ABNO'];
    ABAD = map['ABAD'];
    ABTL = map['ABTL'];
    ABFX = map['ABFX'];
    ABIN = map['ABIN'];
    ABWE = map['ABWE'];
    ABEM = map['ABEM'];
    ABHN = map['ABHN'];
    ABJO = map['ABJO'];
    ABHT = map['ABHT'];
    ABCB = map['ABCB'];
    ABS1T = map['ABS1T'];
    ABS1 = map['ABS1'];
    ABST = map['ABST'];
    SUID = map['SUID'];
    ABDO = map['ABDO'];
    ABDC = map['ABDC'];
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
  }

}
