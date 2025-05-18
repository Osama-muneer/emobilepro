
class Acc_Mov_D_Local {
  int? AMKID;
  int? AMMID;
  int? AMDID;
  String? AANO;
  String? ACNO;
  String? AMDRE;
  String? AMDIN;
  String? SCID;
  String? SCEX;
  String? SCSY;
  double? AMDMD;
  double? AMDDA;
  double? AMDEQ;
  String? AMDTY;
  String? AMDST;
  String? BIID;
  int? AMDVW;
  String? AMDKI;
  String? GUID;
  String? GUIDF;
  String? GUIDC;
  String? DATEI;
  String? DEVI;
  String? SUID;
  String? SUCH;
  String? DATEU;
  String? DEVU;
  int? JTID_L;
  int? BIID_L;
  int? SYID_L;
  String? CIID_L;
  String? AANA_D;
  double? SUMAMDDA;
  double? SUMAMDMD;
  double? SUMAMDEQ;
  String? AANOCOUNT;
  String? AMMDO;
  int? AMMNO;
  int? AMMRE;
  int? COU;
  int? SYST_L;
  int? IDTYP;
  String? BACBA;
  String? IDTYP_D;
  double? MD;
  double? DA;
  double? BAL;
  String? BACBNF;
  double? balance;

  Acc_Mov_D_Local({this.AMKID,this.AMMID,this.AMDID,this.AANO,this.ACNO,this.AMDRE,this.AMDIN,this.SCID,this.SCEX,this.SCSY
    ,this.AMDMD,this.AMDDA,this.AMDEQ,this.AMDTY,this.AMDST,this.BIID,this.AMDVW,this.AMDKI,this.GUID,this.GUIDF,this.GUIDC,
    this.JTID_L,this.SYID_L,this.BIID_L,this.CIID_L,this.AANA_D,this.SUMAMDDA,this.SUMAMDMD,this.SUMAMDEQ,this.AANOCOUNT,
    this.DATEI,this.DEVI,this.SUCH,this.DATEU,this.DEVU,this.SUID,this.SYST_L,this.balance = 0.0});

  Map<String, dynamic> toMap() {
    var map = <String, dynamic>{
      'AMKID': AMKID,
      'AMMID': AMMID,
      'AMDID': AMDID,
      'AANO': AANO,
      'ACNO': ACNO,
      'AMDRE': AMDRE,
      'AMDIN': AMDIN,
      'SCID': SCID,
      'SCEX': SCEX,
      'AMDMD': AMDMD,
      'AMDDA': AMDDA,
      'AMDEQ': AMDEQ,
      'AMDTY': AMDTY,
      'AMDST': AMDST,
      'BIID': BIID,
      'AMDVW': AMDVW,
      'AMDKI': AMDKI,
      'GUID': GUID,
      'GUIDF': GUIDF,
      'GUIDC': GUIDC,
      'DATEI': DATEI,
      'DEVI': DEVI,
      'SUCH': SUCH,
      'DATEU': DATEU,
      'DEVU': DEVU,
      'SUID': SUID,
      'SYST_L': SYST_L,
      'JTID_L': JTID_L,
      'SYID_L': SYID_L,
      'BIID_L': BIID_L,
      'CIID_L': CIID_L,
    };
    return map;
  }

  Acc_Mov_D_Local.fromMap(Map<dynamic, dynamic> map) {
    AMKID = map['AMKID'];
    AMMID = map['AMMID'];
    AMDID = map['AMDID'];
    AANO = map['AANO'];
    ACNO = map['ACNO'];
    AMDRE = map['AMDRE'];
    AMDIN = map['AMDIN'];
    SCID = map['SCID'];
    SCEX = map['SCEX'];
    SCSY = map['SCSY'];
    AMDMD = map['AMDMD'];
    AMDDA = map['AMDDA'];
    AMDEQ = map['AMDEQ'];
    AMDTY = map['AMDTY'];
    AMDST = map['AMDST'];
    BIID = map['BIID'];
    GUIDC = map['GUIDC'];
    AMDKI = map['AMDKI'];
    GUID = map['GUID'];
    GUIDF = map['GUIDF'];
    DATEI = map['DATEI'];
    DEVI = map['DEVI'];
    SUCH = map['SUCH'];
    DATEU = map['DATEU'];
    DEVU = map['DEVU'];
    SUID = map['SUID'];
    JTID_L = map['JTID_L'];
    SYID_L = map['SYID_L'];
    BIID_L = map['BIID_L'];
    CIID_L = map['CIID_L'];
    AANA_D = map['AANA_D'];
    AMMDO = map['AMMDO'];
    AMMNO = map['AMMNO'];
    AMMRE = map['AMMRE'];
    COU = map['COU'];
    SYST_L = map['SYST_L'];
    BACBA = map['BACBA'];
    IDTYP = map['IDTYP'];
    IDTYP_D = map['IDTYP_D'];
    BACBNF = map['BACBNF'];
    balance = map['balance'];
  }

  Acc_Mov_D_Local.fromMapSum(Map<dynamic, dynamic> map) {
    SUMAMDEQ = map['SUMAMDEQ'];
    SUMAMDMD = map['SUMAMDMD'];
    SUMAMDDA = map['SUMAMDDA'];
    AANOCOUNT = map['AANOCOUNT'];
  }

}
