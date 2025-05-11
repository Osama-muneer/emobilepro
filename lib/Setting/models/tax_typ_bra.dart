import '../../Setting/controllers/login_controller.dart';

class Tax_Typ_Bra_Local {
  int? TTBID;
  int? TTID;
  int? BIID;
  String? TTBTN;
  String? TTBTS;
  String? TTBTG;
  String? TTBPK;
  int? TTBST;
  int? TTDR;
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


  Tax_Typ_Bra_Local({this.TTBID,this.TTID,this.BIID,this.TTBTS,this.TTBTN,this.TTBPK
    ,this.TTBTG,this.TTBST,this.TTDR,this.SUID,this.SUCH,this.DATEI,this.DEVI,this.DATEU,this.DEVU,
    this.DEFN,this.RES,this.ORDNU,this.JTID_L,this.SYID_L,this.BIID_L,this.CIID_L,this.GUID});


  Map<String, dynamic> toMap() {
    var map = <String, dynamic>{
      'TTBID': TTBID,
      'TTID': TTID,
      'BIID': BIID,
      'TTBTS': TTBTS,
      'TTBTN': TTBTN,
      'TTBPK': TTBPK,
      'TTBTG': TTBTG,
      'TTBST': TTBST,
      'TTDR': TTDR,
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

  Tax_Typ_Bra_Local.fromMap(Map<dynamic, dynamic> map) {
    TTBID = map['TTBID'];
    TTID = map['TTID'];
    BIID = map['BIID'];
    TTBTS = map['TTBTS'];
    TTBTG = map['TTBTG'];
    TTBPK = map['TTBPK'];
    TTBTN = map['TTBTN'];
    TTBST = map['TTBST'];
    TTDR = map['TTDR'];
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
