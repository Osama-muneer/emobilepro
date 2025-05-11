
import '../../Setting/controllers/login_controller.dart';

class Sys_Cur_Local {
  int? SCID;
  String? SCNA;
  String? SCNE;
  String? SCN3;
  var SCEX;
  var SCHR;
  var SCLR;
  String? SCSF;
  String? CWID;
  int? SCST;
  String? SCDO;
  String? SCDC;
  String? SCSY;
  String? SCSFE;
  String? SCSF3;
  int? SCTID;
  int? SCSFL;
  String? SUID;
  String? DATEI;
  String? DATEU;
  String? SUCH;
  String? DEVI;
  String? DEVU;
  String? RES;
  String? GUID;
  int? ORDNU;
  int? JTID_L;
  int? BIID_L;
  int? SYID_L;
  String? CIID_L;
  String? SCNA_D;


  Sys_Cur_Local({this.SCID,this.SCNA,this.SCNE,this.SCEX,this.SUCH,this.SUID,this.DATEI,this.DEVI,this.DATEU,this.DEVU,
  this.RES,this.ORDNU,this.CWID,this.SCDC,this.SCDO,this.SCHR,this.SCLR,this.SCN3,this.SCSF,this.SCSF3,this.SCSFE,this.SCSFL
    ,this.SCST,this.SCSY,this.SCTID,this.JTID_L,this.SYID_L,this.BIID_L,this.CIID_L,this.SCNA_D,this.GUID});


  Map<String, dynamic> toMap() {
    var map = <String, dynamic>{
      'SCID': SCID,
      'SCNA': SCNA,
      'SCNE': SCNE,
      'SCN3': SCN3,
      'SCEX': SCEX,
      'SCHR': SCHR,
      'SCLR': SCLR,
      'SCSF': SCSF,
      'CWID': CWID,
      'SCST': SCST,
      'SCDO': SCDO,
      'SCDC': SCDC,
      'SCSY': SCSY,
      'SCTID': SCTID,
      'SCSFE': SCSFE,
      'SCSF3': SCSF3,
      'SCSFL': SCSFL,
      'SUID': SUID,
      'SUCH': SUCH,
      'DATEI': DATEI,
      'DEVI': DEVI,
      'DATEU': DATEU,
      'DEVU': DEVU,
      'RES': RES,
      'ORDNU': ORDNU,
      'GUID': GUID,
      'JTID_L': JTID_L ?? LoginController().JTID_L,
      'SYID_L': SYID_L ?? LoginController().SYID_L,
      'BIID_L': BIID_L ?? LoginController().BIID_L,
      'CIID_L': CIID_L ?? LoginController().CIID_L,
    };
    return map;
  }

  Sys_Cur_Local.fromMap(Map<dynamic, dynamic> map) {
    SCID = map['SCID'];
    SCNA = map['SCNA'];
    SCNE = map['SCNE'];
    SCN3 = map['SCN3'];
    SCEX = map['SCEX'];
    SCHR = map['SCHR'];
    SCLR = map['SCLR'];
    SCSF = map['SCSF'];
    CWID = map['CWID'];
    SCST = map['SCST'];
    SCDO = map['SCDO'];
    SCDC = map['SCDC'];
    SCSY = map['SCSY'];
    SCTID = map['SCTID'];
    SCSFE = map['SCSFE'];
    SCSF3 = map['SCSF3'];
    SCSFL = map['SCSFL'];
    SUID = map['SUID'];
    DATEI = map['DATEI'];
    DATEU = map['DATEU'];
    SUCH = map['SUCH'];
    DEVI = map['DEVI'];
    DEVU = map['DEVU'];
    RES = map['RES'];
    ORDNU = map['ORDNU'];
    GUID = map['GUID'];
    JTID_L = map['JTID_L'];
    SYID_L = map['SYID_L'];
    BIID_L = map['BIID_L'];
    CIID_L = map['CIID_L'];
    SCNA_D = map['SCNA_D'];
  }

}
