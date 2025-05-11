import '../../Setting/controllers/login_controller.dart';

class Bal_Acc_C_Local {
  int? BACSQ;
  int? BAMSQ;
  String? GUIDA;
  String? AANO;
  String? GUID;
  int? BIID;
  int? SCID;
  var SCEX;
  String? BCDFY;
  String? BCDTY;
  String? BCDFD;
  String? BCDTD;
  var BACCA;
  var BACCAL;
  var BACBN;
  var BACOBMD;
  var BACOBDA;
  var BACOB;
  var BACOBS;
  var BACOBLMD;
  var BACOBLDA;
  var BACOBL;
  var BACOBLS;
  var BACLBMD;
  var BACLBDA;
  var BACLB;
  var BACLBS;
  var BACLBLMD;
  var BACLBLDA;
  var BACLBL;
  var BACLBLS;
  var BACPBMD;
  var BACPBDA;
  var BACPB;
  var BACPBS;
  var BACPBLMD;
  var BACPBLDA;
  var BACPBLS;
  var BACBMD;
  var BACBDA;
  var BACBA;
  var BACBAS;
  var BACBAR1;
  var BACBAR2;
  var BACBAR3;
  var BACBALMD;
  var BACBALDA;
  var BACBAL;
  var BACBALS;
  var BACBNFMD;
  var BACBNFDA;
  var BACBNF;
  var BACBNFS;
  var BACBNFLMD;
  var BACBNFLDA;
  var BACBNFL;
  var BACBNFLS;
  var BACBNFN;
  var BACLU;
  var BACMN;
  var BACLP;
  var BACLBI;
  var BACLBN;
  var BACLBD;
  var BACDE;
  var BACC1;
  var BACC2;
  var BACC3;
  int? ROWN1;
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
  String? BCNA_D;
  String? BCAD;
  String? BCTL;
  String? SCNA_D;
  String? BINA_D;
  dynamic SUM_BACBMD;
  dynamic SUM_BACBDA;
  dynamic SUM_BACBA;


  Bal_Acc_C_Local({this.BACSQ,this.BAMSQ,this.GUIDA,this.GUID,this.AANO,this.SCID
    ,this.BIID,this.SCEX,this.BCDFY,this.BCDTY,this.BCDFD,this.BCDTD,this.BACCA,
    this.BACCAL,this.BACBN,this.BACOBMD,this.BACOBDA,this.BACOB,this.BACOBS,
    this.BACOBLMD,this.BACOBLDA,this.BACOBL,this.BACOBLS,this.BACLBMD,this.BACLBDA,
    this.BACLB,this.BACLBS,this.BACLBLMD,this.BACLBLDA,this.BACLBL,this.BACLBLS,
    this.BACPBMD,this.BACPBDA,this.BACPB,this.BACPBS,this.BACPBLMD,this.BACPBLDA,
    this.BACPBLS,this.BACBMD,this.BACBDA,this.BACBA,this.BACBAS,this.BACBAR1,
    this.BACBAR2,this.BACBAR3,this.BACBALMD,this.BACBALDA,this.BACBAL,this.BACBALS,
    this.BACBNFMD,this.BACBNFDA,this.BACBNF,this.BACBNFS,this.BACBNFLMD,this.BACBNFLDA,
    this.BACBNFL,this.BACBNFLS,this.BACBNFN,this.BACLU,this.BACMN,this.BACLP,this.BACLBI,
    this.BACLBN,this.BACLBD,this.BACDE,this.BACC1,this.BACC2,this.BACC3,this.ROWN1,
    this.SUID,this.SUCH,this.DATEI, this.DEVI,this.DATEU,
    this.DEVU, this.JTID_L,this.SYID_L,this.BIID_L,this.CIID_L});


  Map<String, dynamic> toMap() {
    var map = <String, dynamic>{
      'BACSQ': BACSQ,
      'BAMSQ': BAMSQ,
      'GUIDA': GUIDA,
      'GUID': GUID,
      'AANO': AANO,
      'SCID': SCID,
      'BIID': BIID,
      'SCEX': SCEX,
      'BCDFY': BCDFY,
      'BCDTY': BCDTY,
      'BCDFD': BCDFD,
      'BCDTD': BCDTD,
      'BACCA': BACCA,
      'BACCAL': BACCAL,
      'BACBN': BACBN,
      'BACOBMD': BACOBMD,
      'BACOBDA': BACOBDA,
      'BACOB': BACOB,
      'BACOBS': BACOBS,
      'BACOBLMD': BACOBLMD,
      'BACOBLDA': BACOBLDA,
      'BACOBL': BACOBL,
      'BACOBLS': BACOBLS,
      'BACLBMD': BACLBMD,
      'BACLBDA': BACLBDA,
      'BACLB': BACLB,
      'BACLBS': BACLBS,
      'BACLBLMD': BACLBLMD,
      'BACLBLDA': BACLBLDA,
      'BACLBL': BACLBL,
      'BACLBLS': BACLBLS,
      'BACPBMD': BACPBMD,
      'BACPBDA': BACPBDA,
      'BACPB': BACPB,
      'BACPBS': BACPBS,
      'BACPBLMD': BACPBLMD,
      'BACPBLDA': BACPBLDA,
      'BACPBLS': BACPBLS,
      'BACBMD': BACBMD,
      'BACBDA': BACBDA,
      'BACBA': BACBA,
      'BACBAS': BACBAS,
      'BACBAR1': BACBAR1,
      'BACBAR2': BACBAR2,
      'BACBAR3': BACBAR3,
      'BACBALMD': BACBALMD,
      'BACBALDA': BACBALDA,
      'BACBAL': BACBAL,
      'BACBALS': BACBALS,
      'BACBNFMD': BACBNFMD,
      'BACBNFDA': BACBNFDA,
      'BACBNF': BACBNF,
      'BACBNFS': BACBNFS,
      'BACBNFLMD': BACBNFLMD,
      'BACBNFLDA': BACBNFLDA,
      'BACBNFL': BACBNFL,
      'BACBNFLS': BACBNFLS,
      'BACBNFN': BACBNFN,
      'BACLU': BACLU,
      'BACMN': BACMN,
      'BACLP': BACLP,
      'BACLBI': BACLBI,
      'BACLBN': BACLBN,
      'BACLBD': BACLBD,
      'BACDE': BACDE,
      'BACC1': BACC1,
      'BACC2': BACC2,
      'BACC3': BACC3,
      'ROWN1': ROWN1,
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

  Bal_Acc_C_Local.fromMap(Map<dynamic, dynamic> map) {
    BACSQ = map['BACSQ'];
    BAMSQ = map['BAMSQ'];
    GUIDA = map['GUIDA'];
    GUID = map['GUID'];
    BIID = map['BIID'];
    SCID = map['SCID'];
    AANO = map['AANO'];
    SCEX = map['SCEX'];
    BCDFY = map['BCDFY'];
    BCDTY = map['BCDTY'];
    BCDFD = map['BCDFD'];
    BCDTD = map['BCDTD'];
    BACCA = map['BACCA'];
    BACCAL = map['BACCAL'];
    BACBN = map['BACBN'];
    BACOBMD = map['BACOBMD'];
    BACOBDA = map['BACOBDA'];
    BACOB = map['BACOB'];
    BACOBS = map['BACOBS'];
    BACOBLMD = map['BACOBLMD'];
    BACOBLDA = map['BACOBLDA'];
    BACOBL = map['BACOBL'];
    BACOBLS = map['BACOBLS'];
    BACLBMD = map['BACLBMD'];
    BACLBDA = map['BACLBDA'];
    BACLB = map['BACLB'];
    BACLBS = map['BACLBS'];
    BACLBLMD = map['BACLBLMD'];
    BACLBLDA = map['BACLBLDA'];
    BACLBL = map['BACLBL'];
    BACLBLS = map['BACLBLS'];
    BACPBMD = map['BACPBMD'];
    BACPBDA = map['BACPBDA'];
    BACPB = map['BACPB'];
    BACPBS = map['BACPBS'];
    BACPBLMD = map['BACPBLMD'];
    BACPBLDA = map['BACPBLDA'];
    BACPBLS = map['BACPBLS'];
    BACBMD = map['BACBMD'];
    BACBDA = map['BACBDA'];
    BACBA = map['BACBA'];
    BACBAS = map['BACBAS'];
    BACBAR1 = map['BACBAR1'];
    BACBAR2 = map['BACBAR2'];
    BACBAR3 = map['BACBAR3'];
    BACBALMD = map['BACBALMD'];
    BACBALDA = map['BACBALDA'];
    BACBAL = map['BACBAL'];
    BACBALS = map['BACBALS'];
    BACBNFMD = map['BACBNFMD'];
    BACBNFDA = map['BACBNFDA'];
    BACBNF = map['BACBNF'];
    BACBNFS = map['BACBNFS'];
    BACBNFLMD = map['BACBNFLMD'];
    BACBNFLDA = map['BACBNFLDA'];
    BACBNFL = map['BACBNFL'];
    BACBNFLS = map['BACBNFLS'];
    BACBNFN = map['BACBNFN'];
    BACLU = map['BACLU'];
    BACMN = map['BACMN'];
    BACLP = map['BACLP'];
    BACLBI = map['BACLBI'];
    BACLBN = map['BACLBN'];
    BACLBD = map['BACLBD'];
    BACDE = map['BACDE'];
    BACC1 = map['BACC1'];
    BACC2 = map['BACC2'];
    BACC3 = map['BACC3'];
    ROWN1 = map['ROWN1'];
    GUIDN = map['GUIDN'];
    SUID = map['SUID'];
    DATEI = map['DATEI'];
    DATEU = map['DATEU'];
    SUCH = map['SUCH'];
    DEVI = map['DEVI'];
    DEVU = map['DEVU'];
    JTID_L = map['JTID_L'];
    SYID_L = map['SYID_L'];
    BIID_L = map['BIID_L'];
    CIID_L = map['CIID_L'];
    BCNA_D = map['BCNA_D'];
    BCAD = map['BCAD'];
    BCTL = map['BCTL'];
    SCNA_D = map['SCNA_D'];
    BINA_D = map['BINA_D'];
    SUM_BACBMD = map['SUM_BACBMD'];
    SUM_BACBDA = map['SUM_BACBDA'];
    SUM_BACBA = map['SUM_BACBA'];
  }

}
