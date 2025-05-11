import '../../Setting/controllers/login_controller.dart';

class Tax_Var_Local {
  int? TVID;
  String? TVSY;
  String? TVNA;
  String? TVNE;
  String? TVN3;
  String? TVVL;
  String? TVDT;
  String? TVDS;
  int? TVDH;
  int? TVDA;
  int? TVAD;
  String? STID;
  String? STMID;
  String? PRID;
  String? PRIDY;
  String? PRIDN;
  int? TVDAC;
  int? TVCH;
  int? TVDL;
  int? TVIDF;
  int? TVST;
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
  Tax_Var_Local({this.TVID,this.TVSY,this.TVNA,this.TVNE,this.TVN3,this.TVVL
    ,this.TVDT,this.TVDS,this.TVDH,this.TVDA,this.TVAD,this.STID,this.STMID
    ,this.PRID,this.PRIDY,this.PRIDN,this.TVDAC,this.TVCH,this.TVDL,this.TVIDF,this.TVST
    ,this.SUID,this.SUCH,this.DATEI,this.DEVI,this.DATEU,this.DEVU,this.DEFN,
    this.RES,this.ORDNU,this.JTID_L,this.SYID_L,this.BIID_L,this.CIID_L,this.GUID});


  Map<String, dynamic> toMap() {
    var map = <String, dynamic>{
      'TVID': TVID,
      'TVSY': TVSY,
      'TVNA': TVNA,
      'TVNE': TVNE,
      'TVN3': TVN3,
      'TVVL': TVVL,
      'TVDT': TVDT,
      'TVDS': TVDS,
      'TVDH': TVDH,
      'TVDA': TVDA,
      'TVAD': TVAD,
      'STID': STID,
      'STMID': STMID,
      'PRID': PRID,
      'PRIDY': PRIDY,
      'PRIDN': PRIDN,
      'TVDAC': TVDAC,
      'TVCH': TVCH,
      'TVDL': TVDL,
      'TVIDF': TVIDF,
      'TVST': TVST,
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

  Tax_Var_Local.fromMap(Map<dynamic, dynamic> map) {
    TVID = map['TVID'];
    TVSY = map['TVSY'];
    TVNA = map['TVNA'];
    TVNE = map['TVNE'];
    TVDT = map['TVDT'];
    TVVL = map['TVVL'];
    TVN3 = map['TVN3'];
    TVDS = map['TVDS'];
    TVDH = map['TVDH'];
    TVDA = map['TVDA'];
    TVAD = map['TVAD'];
    STID = map['STID'];
    STMID = map['STMID'];
    PRID = map['PRID'];
    PRIDY = map['PRIDY'];
    PRIDN = map['PRIDN'];
    TVDAC = map['TVDAC'];
    TVCH = map['TVCH'];
    TVDL = map['TVDL'];
    TVIDF = map['TVIDF'];
    TVST = map['TVST'];
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
