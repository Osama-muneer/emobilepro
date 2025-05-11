import '../../Setting/controllers/login_controller.dart';

class Tax_Per_Bra_Local {
  int? TPBID;
  int? TPDID;
  int? BIID;
  int? TPBST;
  String? TPBDE;
  String? SUID;
  String? DATEI;
  String? DATEU;
  String? SUCH;
  String? DEVI;
  String? DEVU;
  String? RES;
  int? ORDNU;
  int? SYID;
  int? DEFN;
  int? JTID_L;
  int? BIID_L;
  int? SYID_L;
  String? CIID_L;
  String? GUID;


  Tax_Per_Bra_Local({this.TPBID,this.TPDID,this.BIID,this.TPBDE
    ,this.TPBST,this.SYID,
    this.SUID,this.SUCH,this.DATEI,this.DEVI,this.DATEU,this.DEVU,
    this.DEFN,this.RES,this.ORDNU,this.JTID_L,this.SYID_L,this.BIID_L,this.CIID_L,this.GUID});


  Map<String, dynamic> toMap() {
    var map = <String, dynamic>{
      'TPBID': TPBID,
      'BIID': BIID,
      'TPDID': TPDID,
      'TPBDE': TPBDE,
      'TPBST': TPBST,
      'SYID': SYID,
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

  Tax_Per_Bra_Local.fromMap(Map<dynamic, dynamic> map) {
    TPBID = map['TPBID'];
    BIID = map['BIID'];
    TPBST = map['TPBST'];
    TPBDE = map['TPBDE'];
    TPDID = map['TPDID'];
    SYID = map['SYID'];
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
    JTID_L = map['JTID_L'];
    SYID_L = map['SYID_L'];
    BIID_L = map['BIID_L'];
    CIID_L = map['CIID_L'];
  }
}
