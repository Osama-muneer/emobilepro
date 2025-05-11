import '../../Setting/controllers/login_controller.dart';

class Res_Emp_Local {
  int? RSID;
  int? REID;
  String? RENA;
  String? RENE;
  String? REN3;
  int? REST;
  int? BIID;
  String? REIN;
  String? SUID;
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
  String? RENA_D;


  Res_Emp_Local({this.RSID,this.REID,this.RENA,this.RENE,this.REST,this.REN3,this.REIN
    ,this.BIID,this.SUID,this.SUCH,this.DATEI,this.DEVI,this.DATEU,this.DEVU,
    this.RES,this.ORDNU,this.JTID_L,this.SYID_L,this.BIID_L,this.CIID_L,this.GUID});


  Map<String, dynamic> toMap() {
    var map = <String, dynamic>{
      'RSID': RSID,
      'REID': REID,
      'RENA': RENA,
      'RENE': RENE,
      'REN3': REN3,
      'REST': REST,
      'BIID': BIID,
      'REIN': REIN,
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

  Res_Emp_Local.fromMap(Map<dynamic, dynamic> map) {
    RSID = map['RSID'];
    REID = map['REID'];
    RENA = map['RENA'];
    RENE = map['RENE'];
    REN3 = map['REN3'];
    REST = map['REST'];
    BIID = map['BIID'];
    REIN = map['REIN'];
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
    RENA_D = map['RENA_D'];
  }

}
