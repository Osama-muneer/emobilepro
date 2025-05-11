import '../../Setting/controllers/login_controller.dart';

class Bal_Acc_M_Local {
  int? BAMSQ;
  String? AANO;
  String? GUID;
  String? BAMLU;
  int? BAMMN;
  var BAMMD;
  var BAMDA;
  var BAMBA;
  String? BAMBAS;
  String? BAMBAR1;
  String? BAMBAR2;
  String? BAMBAR3;
  var BAMBNFL;
  String? BAMBNFLS;
  var BAMCAL;
  var BAMBN;
  var BAMBNFN;
  String? BAMLP;
  String? BAMLBI;
  String? BAMLBN;
  String? BAMLBD;
  int? ROWN1;
  int? ROWN2;
  String? GUIDN;
  String? SUID;
  String? DATEI;
  String? DATEU;
  String? SUCH;
  String? DEVI;
  String? DEVU;
  int? JTID_L;
  int? BIID_L;
  int? SYID_L;
  String? CIID_L;



  Bal_Acc_M_Local({this.BAMSQ,this.AANO,this.GUID,this.BAMMN,this.BAMLU,this.BAMDA,this.BAMBA,
    this.BAMBAS,this.BAMBAR1,this.BAMBAR2,this.BAMBAR3,this.BAMMD,this.BAMBNFL,this.BAMBNFLS
    ,this.BAMCAL,this.BAMBN,this.BAMBNFN,this.BAMLP,this.BAMLBI,this.BAMLBN,this.BAMLBD,
    this.GUIDN,this.SUID,this.SUCH,this.DATEI,this.DEVI,this.DATEU,this.DEVU,
    this.JTID_L,this.SYID_L,this.BIID_L,this.CIID_L,this.ROWN1,this.ROWN2});


  Map<String, dynamic> toMap() {
    var map = <String, dynamic>{
      'BAMSQ': BAMSQ,
      'AANO': AANO,
      'GUID': GUID,
      'BAMMN': BAMMN,
      'BAMLU': BAMLU,
      'BAMDA': BAMDA,
      'BAMMD': BAMMD,
      'BAMBA': BAMBA,
      'BAMBAS': BAMBAS,
      'BAMBAR1': BAMBAR1,
      'BAMBAR2': BAMBAR2,
      'BAMBAR3': BAMBAR3,
      'BAMBNFL': BAMBNFL,
      'BAMBNFLS': BAMBNFLS,
      'BAMCAL': BAMCAL,
      'BAMBN': BAMBN,
      'BAMBNFN': BAMBNFN,
      'BAMLP': BAMLP,
      'BAMLBI': BAMLBI,
      'BAMLBN': BAMLBN,
      'BAMLBD': BAMLBD,
      'ROWN1': ROWN1,
      'ROWN2': ROWN2,
      'GUIDN': GUIDN,
      'SUID': SUID,
      'SUCH': SUCH,
      'DATEI': DATEI,
      'DEVI': DEVI,
      'DATEU': DATEU,
      'DEVU': DEVU,
      'JTID_L': JTID_L ?? LoginController().JTID_L,
      'SYID_L': SYID_L ?? LoginController().SYID_L,
      'BIID_L': BIID_L ?? LoginController().BIID_L,
      'CIID_L': CIID_L ?? LoginController().CIID_L,
    };
    return map;
  }

  Bal_Acc_M_Local.fromMap(Map<dynamic, dynamic> map) {
    BAMSQ = map['BAMSQ'];
    AANO = map['AANO'];
    GUID = map['GUID'];
    BAMMN = map['BAMMN'];
    BAMMD = map['BAMMD'];
    BAMDA = map['BAMDA'];
    BAMLU = map['BAMLU'];
    BAMBA = map['BAMBA'];
    BAMBAS = map['BAMBAS'];
    BAMBAR1 = map['BAMBAR1'];
    BAMBAR2 = map['BAMBAR2'];
    BAMBAR3 = map['BAMBAR3'];
    BAMBNFL = map['BAMBNFL'];
    BAMBNFLS = map['BAMBNFLS'];
    BAMCAL = map['BAMCAL'];
    BAMBN = map['BAMBN'];
    BAMBNFN = map['BAMBNFN'];
    BAMLP = map['BAMLP'];
    BAMLBI = map['BAMLBI'];
    BAMLBN = map['BAMLBN'];
    BAMLBD = map['BAMLBD'];
    ROWN1 = map['ROWN1'];
    ROWN2 = map['ROWN2'];
    GUIDN = map['GUIDN'];
    SUID = map['SUID'];
    DATEI = map['DATEI'];
    DATEU = map['DATEU'];
    SUCH = map['SUCH'];
    DEVI = map['DEVI'];
    DEVU = map['DEVU'];
    GUID = map['GUID'];
    JTID_L = map['JTID_L'];
    SYID_L = map['SYID_L'];
    BIID_L = map['BIID_L'];
    CIID_L = map['CIID_L'];
  }

}
