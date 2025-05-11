
import '../../Setting/controllers/login_controller.dart';

class Sto_Mov_K_Local {
  int? SMKID;
  String? SMKNA;
  String? SMKNE;
  String? SMKN3;
  int? SMKST;
  int? SMKTY;
  int? SMKAC;
  int? SMKDL;
  String? SUID;
  String? STID;
  String? DATEI;
  String? DATEU;
  String? SUCH;
  String? DEVI;
  String? DEVU;
  String? RES;
  int? ORDNU;
  int? JTID_L;
  int? BIID_L;
  int? SYID_L;
  String? CIID_L;
  String? GUID;
  String? SMKNA_D;


  Sto_Mov_K_Local({this.SMKID,this.SMKNA,this.SMKNE,this.SMKST,this.SMKTY,this.SMKN3,this.SMKDL
    ,this.SMKAC,this.STID,this.SUID,this.SUCH,this.DATEI,this.DEVI,this.DATEU,this.DEVU,
    this.RES,this.ORDNU,this.JTID_L,this.SYID_L,this.BIID_L,this.CIID_L,this.GUID});


  Map<String, dynamic> toMap() {
    var map = <String, dynamic>{
      'SMKID': SMKID,
      'SMKNA': SMKNA,
      'SMKNE': SMKNE,
      'SMKST': SMKST,
      'SMKTY': SMKTY,
      'SMKN3': SMKN3,
      'SMKDL': SMKDL,
      'SMKAC': SMKAC,
      'STID': STID,
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

  Sto_Mov_K_Local.fromMap(Map<dynamic, dynamic> map) {
    SMKID = map['SMKID'];
    SMKNA = map['SMKNA'];
    SMKNE = map['SMKNE'];
    SMKST = map['SMKST'];
    SMKTY = map['SMKTY'];
    SMKAC = map['SMKAC'];
    SMKDL = map['SMKDL'];
    SMKN3 = map['SMKN3'];
    SUID = map['SUID'];
    STID = map['STID'];
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
    SMKNA_D = map['SMKNA_D'];
  }

}
