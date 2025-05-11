import '../../Setting/controllers/login_controller.dart';

class Tax_Cod_Local {
  int? TCID;
  int? TTID;
  String? TCNA;
  String? TCNE;
  String? TCN3;
  String? TCSY;
  int? TCST;
  String? TCDA;
  String? TCDE;
  String? TCD3;
  int? TCSID;
  String? TCSSY;
  String? TCSDSY;
  int? TCIT;
  int? TCAC;
  int? TCVL;
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


  Tax_Cod_Local({this.TCID,this.TTID,this.TCNA,this.TCN3,this.TCNE,this.TCST
    ,this.TCSY,this.TCDA,this.TCDE,this.TCD3,this.TCSID,this.TCSSY,this.TCSDSY
    ,this.TCIT,this.TCAC,this.TCVL
    ,this.SUID,this.SUCH,this.DATEI,this.DEVI,this.DATEU,this.DEVU,this.DEFN,
    this.RES,this.ORDNU,this.JTID_L,this.SYID_L,this.BIID_L,this.CIID_L,this.GUID});


  Map<String, dynamic> toMap() {
    var map = <String, dynamic>{
      'TCID': TCID,
      'TTID': TTID,
      'TCNA': TCNA,
      'TCN3': TCN3,
      'TCNE': TCNE,
      'TCST': TCST,
      'TCSY': TCSY,
      'TCDA': TCDA,
      'TCDE': TCDE,
      'TCD3': TCD3,
      'TCSID': TCSID,
      'TCSSY': TCSSY,
      'TCSDSY': TCSDSY,
      'TCIT': TCIT,
      'TCAC': TCAC,
      'TCVL': TCVL,
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

  Tax_Cod_Local.fromMap(Map<dynamic, dynamic> map) {
    TCID = map['TCID'];
    TTID = map['TTID'];
    TCNA = map['TCNA'];
    TCN3 = map['TCN3'];
    TCSY = map['TCSY'];
    TCST = map['TCST'];
    TCNE = map['TCNE'];
    TCDA = map['TCDA'];
    TCDE = map['TCDE'];
    TCD3 = map['TCD3'];
    TCSID = map['TCSID'];
    TCSSY = map['TCSSY'];
    TCSDSY = map['TCSDSY'];
    TCIT = map['TCIT'];
    TCAC = map['TCAC'];
    TCVL = map['TCVL'];
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
