import '../../Setting/controllers/login_controller.dart';

class Res_Sec_Local {
  int? RSID;
  String? RSNA;
  String? RSNE;
  String? RSN3;
  String? RSHN;
  int? RSST;
  int? RSFN;
  int? BIID;
  String? RSIN;
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
  String? RSNA_D;


  Res_Sec_Local({this.RSID,this.RSNA,this.RSNE,this.RSHN,this.RSST,this.RSN3,this.RSIN
    ,this.RSFN,this.BIID,this.SUID,this.SUCH,this.DATEI,this.DEVI,this.DATEU,this.DEVU,
    this.RES,this.ORDNU,this.JTID_L,this.SYID_L,this.BIID_L,this.CIID_L,this.GUID});


  Map<String, dynamic> toMap() {
    var map = <String, dynamic>{
      'RSID': RSID,
      'RSNA': RSNA,
      'RSNE': RSNE,
      'RSN3': RSN3,
      'RSHN': RSHN,
      'RSST': RSST,
      'BIID': BIID,
      'RSFN': RSFN,
      'RSIN': RSIN,
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

  Res_Sec_Local.fromMap(Map<dynamic, dynamic> map) {
    RSID = map['RSID'];
    RSNA = map['RSNA'];
    RSNE = map['RSNE'];
    RSN3 = map['RSN3'];
    RSST = map['RSST'];
    RSFN = map['RSFN'];
    BIID = map['BIID'];
    RSIN = map['RSIN'];
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
    RSNA_D = map['RSNA_D'];
  }

}
