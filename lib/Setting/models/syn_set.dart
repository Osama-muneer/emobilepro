import '../../Setting/controllers/login_controller.dart';

class Syn_Set_Local {
  String? STMID;
  String? SSUS;
  String? SSPA;
  int? CIID;
  int? JTID;
  int? SSST;
  String? SSFD;
  String? SSTD;
  String? SSCO;
  String? SSIN;
  String? SUID;
  String? DATEI;
  String? DATEU;
  String? SUCH;
  int? SSWS;
  int? SSLO;
  int? SSPAE;
  int? SYID;
  String? GUID;
  int? BIID;
  int? SSTY;
  int? SSCT;
  String? SSAN;
  String? SSAK;
  String? SSAS;
  String? SSAT;
  String? SSPW;
  String? SSPT;
  int? SSTKN;
  String? SSPO;
  String? SSIP;
  int? SSNCT;
  int? SSAPITY;
  String? SSPAR1;
  String? SSPAR2;
  String? SSOR;
  String? SSME;
  int? JTID_L;
  int? BIID_L;
  int? SYID_L;
  String? CIID_L;


  Syn_Set_Local({this.SSUS,this.SSPA,this.STMID,this.CIID,this.JTID,this.SSTD,this.SSFD
    ,this.SSST,this.SSCO,this.SUID,this.SSIN,this.SSWS,this.SSPAE,this.SYID
    ,this.GUID,this.SSTY,this.SSAN,this.SSCT,this.SSAK,this.SSAS,this.SSAT
    ,this.BIID,this.SSPW,this.SSPT,this.SSTKN,this.SSPO,this.SSIP,this.SSNCT,this.SSAPITY,this.SSPAR1
    ,this.SSPAR2,this.SSOR,this.SSME
    ,this.SUCH,this.DATEI,this.DATEU,this.JTID_L,this.SYID_L,this.BIID_L,this.CIID_L,this.SSLO});


  Map<String, dynamic> toMap() {
    var map = <String, dynamic>{
      'SSUS': SSUS,
      'SSPA': SSPA,
      'STMID': STMID,
      'CIID': CIID,
      'JTID': JTID,
      'SYID': SYID,
      'SSTD': SSTD,
      'SSFD': SSFD,
      'SSST': SSST,
      'SSCO': SSCO,
      'SSIN': SSIN,
      'SUID': SUID,
      'SUCH': SUCH,
      'DATEI': DATEI,
      'DATEU': DATEU,
      'SSLO': SSLO,
      'SSWS': SSWS,
      'SSPAE': SSPAE,
      'GUID': GUID,
      'SSTY': SSTY,
      'SSCT': SSCT,
      'SSAN': SSAN,
      'SSAK': SSAK,
      'SSAS': SSAS,
      'SSAT': SSAT,
      'BIID': BIID,
      'SSPW': SSPW,
      'SSPT': SSPT,
      'SSTKN': SSTKN,
      'SSPO': SSPO,
      'SSIP': SSIP,
      'SSNCT': SSNCT,
      'SSAPITY': SSAPITY,
      'SSPAR1': SSPAR1,
      'SSPAR2': SSPAR2,
      'SSOR': SSOR,
      'SSME': SSME,
      'JTID_L': JTID_L ?? LoginController().JTID_L,
      'SYID_L': SYID_L ?? LoginController().SYID_L,
      'BIID_L': BIID_L ?? LoginController().BIID_L,
      'CIID_L': CIID_L ?? LoginController().CIID_L,
    };
    return map;
  }

  Syn_Set_Local.fromMap(Map<dynamic, dynamic> map) {
    STMID = map['STMID'];
    SSUS = map['SSUS'];
    SSPA = map['SSPA'];
    CIID = map['CIID'];
    JTID = map['JTID'];
    SSST = map['SSST'];
    SSFD = map['SSFD'];
    SSTD = map['SSTD'];
    SSCO = map['SSCO'];
    SSIN = map['SSIN'];
    SSWS = map['SSWS'];
    SSPAE = map['SSPAE'];
    SYID = map['SYID'];
    GUID = map['GUID'];
    SSTY = map['SSTY'];
    SSCT = map['SSCT'];
    SSAN = map['SSAN'];
    SSAK = map['SSAK'];
    SSAS = map['SSAS'];
    SSAT = map['SSAT'];
    BIID = map['BIID'];
    SSPW = map['SSPW'];
    SSPT = map['SSPT'];
    SSTKN = map['SSTKN'];
    SSPO = map['SSPO'];
    SSIP = map['SSIP'];
    SSNCT = map['SSNCT'];
    SSAPITY = map['SSAPITY'];
    SSPAR1 = map['SSPAR1'];
    SSPAR2 = map['SSPAR2'];
    SSOR = map['SSOR'];
    SSME = map['SSME'];
    SUID = map['SUID'];
    DATEI = map['DATEI'];
    DATEU = map['DATEU'];
    SUCH = map['SUCH'];
    SSLO = map['SSLO'];
    JTID_L = map['JTID_L'];
    SYID_L = map['SYID_L'];
    BIID_L = map['BIID_L'];
    CIID_L = map['CIID_L'];
  }
}
