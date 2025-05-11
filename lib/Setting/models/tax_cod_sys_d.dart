import '../../Setting/controllers/login_controller.dart';

class Tax_Cod_Sys_D_Local {
  int? TCSDID;
  int? TTSID;
  int? TCSID;
  String? TCSDSY;
  String? TCSDNA;
  String? TCSDNE;
  String? TCSDN3;
  int? TCSDST;
  String? SUID;
  String? DATEI;
  String? DATEU;
  String? SUCH;
  String? DEVI;
  String? DEVU;
  String? RES;
  int? ORDNU;
  int? DEFN;
  int? JTID_L;
  int? BIID_L;
  int? SYID_L;
  String? CIID_L;
  String? GUID;
  int? TCSVL;


  Tax_Cod_Sys_D_Local({this.TCSDID,this.TTSID,this.TCSID,this.TCSDNA,this.TCSDSY,this.TCSDN3
    ,this.TCSDNE,this.TCSDST,this.SUID,this.SUCH,this.DATEI,this.DEVI,this.DATEU,this.DEVU,
    this.DEFN,this.RES,this.ORDNU,this.JTID_L,this.SYID_L,this.BIID_L,this.CIID_L,this.GUID});


  Map<String, dynamic> toMap() {
    var map = <String, dynamic>{
      'TCSDID': TCSDID,
      'TTSID': TTSID,
      'TCSID': TCSID,
      'TCSDNA': TCSDNA,
      'TCSDSY': TCSDSY,
      'TCSDN3': TCSDN3,
      'TCSDNE': TCSDNE,
      'TCSDST': TCSDST,
      'SUID': SUID,
      'SUCH': SUCH,
      'DATEI': DATEI,
      'DEVI': DEVI,
      'DATEU': DATEU,
      'DEVU': DEVU,
      'RES': RES,
      'ORDNU': ORDNU,
      'DEFN': DEFN,
      'GUID': GUID,
      'JTID_L': JTID_L ?? LoginController().JTID_L,
      'SYID_L': SYID_L ?? LoginController().SYID_L,
      'BIID_L': BIID_L ?? LoginController().BIID_L,
      'CIID_L': CIID_L ?? LoginController().CIID_L,
    };
    return map;
  }

  Tax_Cod_Sys_D_Local.fromMap(Map<dynamic, dynamic> map) {
    TCSDID = map['TCSDID'];
    TTSID = map['TTSID'];
    TCSID = map['TCSID'];
    TCSDNA = map['TCSDNA'];
    TCSDNE = map['TCSDNE'];
    TCSDN3 = map['TCSDN3'];
    TCSDSY = map['TCSDSY'];
    TCSDST = map['TCSDST'];
    SUID = map['SUID'];
    DATEI = map['DATEI'];
    DATEU = map['DATEU'];
    SUCH = map['SUCH'];
    DEVI = map['DEVI'];
    DEVU = map['DEVU'];
    RES = map['RES'];
    ORDNU = map['ORDNU'];
    DEFN = map['DEFN'];
    GUID = map['GUID'];
    TCSVL = map['TCSVL'];
    JTID_L = map['JTID_L'];
    SYID_L = map['SYID_L'];
    BIID_L = map['BIID_L'];
    CIID_L = map['CIID_L'];
  }

}
