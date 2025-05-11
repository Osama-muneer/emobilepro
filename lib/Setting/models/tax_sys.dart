import '../../Setting/controllers/login_controller.dart';

class Tax_Sys_Local {
  int? TSID;
  int? TTID;
  String? STID;
  int ? TSST;
  int? TSCT;
  int? TSRA;
  int? TSPT;
  String? AANOO;
  String? AANOI;
  String? AANOR;
  String? AANORR;
  int? TSDC;
  int? TSFR;
  int? TSDI;
  int? TSAT;
  int? TSCR;
  int? TSPR;
  int? TSQR;
  int? TSQRT;
  int? TSAM;
  int? TSDL;
  int? TSUP;
  int? TSSNF;
  int? TSRF;
  int? TSCA;
  int? TSVCA;
  int? TSVIA;
  int? TSVOA;
  String? TSRE;
  String? TSRES;
  String? TSRET;
  String? TSRETS;
  String? SUID;
  String? DATEI;
  String? DATEU;
  String? SUCH;
  String? DEVI;
  String? DEVU;
  String? RES;
  int? TSDT;
  int? ORDNU;
  int? DEFN;
  int? JTID_L;
  int? BIID_L;
  int? SYID_L;
  String? CIID_L;
  String? GUID;


  Tax_Sys_Local({this.TSID,this.TTID,this.STID,this.TSCT,this.TSST,this.TSPT
    ,this.TSRA,this.AANOO,this.AANOI,this.AANOR,this.AANORR,this.TSDC,this.TSFR
    ,this.TSDI,this.TSAT,this.TSCR,this.TSPR,this.TSQR,this.TSQRT,this.TSAM,
     this.TSDL,this.TSUP,this.TSSNF,this.TSRF,this.TSCA,this.TSVCA,this.TSVIA
    ,this.TSVOA,this.TSRE,this.TSRES,this.TSRET,this.TSRETS,this.TSDT
    ,this.SUID,this.SUCH,this.DATEI,this.DEVI,this.DATEU,this.DEVU,this.DEFN,
    this.RES,this.ORDNU,this.JTID_L,this.SYID_L,this.BIID_L,this.CIID_L,this.GUID});


  Map<String, dynamic> toMap() {
    var map = <String, dynamic>{
      'TSID': TSID,
      'TTID': TTID,
      'STID': STID,
      'TSCT': TSCT,
      'TSST': TSST,
      'TSPT': TSPT,
      'TSRA': TSRA,
      'AANOO': AANOO,
      'AANOI': AANOI,
      'AANOR': AANOR,
      'AANORR': AANORR,
      'TSDC': TSDC,
      'TSFR': TSFR,
      'TSDI': TSDI,
      'TSAT': TSAT,
      'TSCR': TSCR,
      'TSPR': TSPR,
      'TSQR': TSQR,
      'TSQRT': TSQRT,
      'TSAM': TSAM,
      'TSDL': TSDL,
      'TSUP': TSUP,
      'TSSNF': TSSNF,
      'TSRF': TSRF,
      'TSCA': TSCA,
      'TSVCA': TSVCA,
      'TSVIA': TSVIA,
      'TSVOA': TSVOA,
      'TSRE': TSRE,
      'TSRES': TSRES,
      'TSRET': TSRET,
      'TSRETS': TSRETS,
      'TSDT': TSDT,
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

  Tax_Sys_Local.fromMap(Map<dynamic, dynamic> map) {
    TSID = map['TSID'];
    TTID = map['TTID'];
    STID = map['STID'];
    TSCT = map['TSCT'];
    TSRA = map['TSRA'];
    TSPT = map['TSPT'];
    TSST = map['TSST'];
    AANOO = map['AANOO'];
    AANOI = map['AANOI'];
    AANOR = map['AANOR'];
    AANORR = map['AANORR'];
    TSDC = map['TSDC'];
    TSFR = map['TSFR'];
    TSDI = map['TSDI'];
    TSAT = map['TSAT'];
    TSCR = map['TSCR'];
    TSPR = map['TSPR'];
    TSQR = map['TSQR'];
    TSQRT = map['TSQRT'];
    TSAM = map['TSAM'];
    TSDL = map['TSDL'];
    TSUP = map['TSUP'];
    TSSNF = map['TSSNF'];
    TSRF = map['TSRF'];
    TSCA = map['TSCA'];
    TSVCA = map['TSVCA'];
    TSVIA = map['TSVIA'];
    TSVOA = map['TSVOA'];
    TSRE = map['TSRE'];
    TSRES = map['TSRES'];
    TSRET = map['TSRET'];
    TSRETS = map['TSRETS'];
    TSDT = map['TSDT'];
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
