
import '../../Setting/controllers/login_controller.dart';

class Acc_Mov_K_Local {
  int? AMKID;
  String? AMKNA;
  String? AMKNE;
  String? AMKN3;
  int? AMKST;
  int? AMKAC;
  int? AMKDL;
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
  String? AMKNA_D;


  Acc_Mov_K_Local({this.AMKID,this.AMKNA,this.AMKNE,this.AMKST,this.AMKN3,this.AMKDL
    ,this.AMKAC,this.STID,this.SUID,this.SUCH,this.DATEI,this.DEVI,this.DATEU,this.DEVU,
    this.RES,this.ORDNU,this.JTID_L,this.SYID_L,this.BIID_L,this.CIID_L,this.GUID});


  Map<String, dynamic> toMap() {
    var map = <String, dynamic>{
      'AMKID': AMKID,
      'AMKNA': AMKNA,
      'AMKNE': AMKNE,
      'AMKST': AMKST,
      'AMKN3': AMKN3,
      'AMKDL': AMKDL,
      'AMKAC': AMKAC,
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

  Acc_Mov_K_Local.fromMap(Map<dynamic, dynamic> map) {
    AMKID = map['AMKID'];
    AMKNA = map['AMKNA'];
    AMKNE = map['AMKNE'];
    AMKST = map['AMKST'];
    AMKAC = map['AMKAC'];
    AMKDL = map['AMKDL'];
    AMKN3 = map['AMKN3'];
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
    AMKNA_D = map['AMKNA_D'];
  }

}
