import '../../Setting/controllers/login_controller.dart';

class Tax_Var_D_Local {
  int? TVDID;
  int? TVID;
  int? TTID;
  int? TVDTY;
  String? TVDSY;
  String? TVDVL;
  String? TVDDA;
  String? STID;
  String? STMID;
  String? PRID;
  String? PRIDY;
  String? PRIDN;
  int? TVDCH;
  int? TVDIDF;
  int? TVDST;
  String? GUID;
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
  Tax_Var_D_Local({this.TVID,this.TVDID,this.TTID,this.TVDTY,this.TVDSY,this.TVDVL
    ,this.TVDDA,this.STID,this.STMID,this.PRID,this.PRIDY,this.PRIDN,this.TVDCH
    ,this.TVDIDF,this.TVDST
    ,this.SUID,this.SUCH,this.DATEI,this.DEVI,this.DATEU,this.DEVU,this.DEFN,
    this.RES,this.ORDNU,this.JTID_L,this.SYID_L,this.BIID_L,this.CIID_L,this.GUID});


  Map<String, dynamic> toMap() {
    var map = <String, dynamic>{
      'TVID': TVID,
      'TVDID': TVDID,
      'TTID': TTID,
      'TVDTY': TVDTY,
      'TVDSY': TVDSY,
      'TVDVL': TVDVL,
      'TVDDA': TVDDA,
      'STID': STID,
      'STMID': STMID,
      'PRID': PRID,
      'PRIDY': PRIDY,
      'PRIDN': PRIDN,
      'TVDCH': TVDCH,
      'TVDIDF': TVDIDF,
      'TVDST': TVDST,
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

  Tax_Var_D_Local.fromMap(Map<dynamic, dynamic> map) {
    TVID = map['TVID'];
    TVDID = map['TVDID'];
    TTID = map['TTID'];
    TVDTY = map['TVDTY'];
    TVDSY = map['TVDSY'];
    TVDVL = map['TVDVL'];
    TVDDA = map['TVDDA'];
    STID = map['STID'];
    STMID = map['STMID'];
    PRID = map['PRID'];
    PRIDY = map['PRIDY'];
    PRIDN = map['PRIDN'];
    TVDCH = map['TVDCH'];
    TVDIDF = map['TVDIDF'];
    TVDST = map['TVDST'];
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
