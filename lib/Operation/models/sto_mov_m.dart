

class STO_MOV_M_Local {
  int? SMMID;
  int? SMMNO ;
  int? SMKID;
  String? SMMDO;
  String? SMMDA;
  int? SMMST;
  int? SCID;
  String? SMMIN;
  String? SUID;
  String? SUCH;
  String? DATEU;
  String? DATEI;
  String? DEVI;
  String? DEVU;
  String? GUID;
  var BIID;
  var BIIDT;
  var BINA;
  var SIID;
  var SIIDT;
  var SINA;
  String? AANO;
  String? AANO2;
  String? SMMRE;
  double? SMMAM;
  double? SCEX;
  double? SCEXS;
  double? SMMEQ;
  double? SMMDIF;
  double? SMMDI;
  double? SMMDIA;
  int? SIIDF;
  String? SMMNN;
  String? SIIDTN;
  int? SMMNR;
  String? MGNA;
  String? MINA;
  String? SMDED;
  String? MUNA;
  double? SMDNF;
  double? SMDNO;
  int? JTID_L;
  int? SYID_L;
  int? BIID_L;
  String? CIID_L;
  String? BINA_D;
  String? SINA_D;
  String? AANA_D;
  String? SCNA_D;
  String? ACNO;
  String? SIIDT_D;
  String? SMMCN;
  String? SMMDR;
  int? BKID;
  int? BMMID;

  STO_MOV_M_Local({this.SMMID, this.SMMNO,required this.SMKID, this.SMMDO,
    required this.SMMST,required this.SMMIN,required this.BIID,required this.SIID,this.SINA,this.BINA,
    this.SCID,this.SUID,this.SUCH,this.DATEU,this.DATEI,this.DEVI,this.DEVU,this.GUID,this.AANO,this.SMMAM,
    this.SMMRE,this.SIIDF,this.SIIDT,this.SMMNN,this.SMMDA,this.SIIDTN,this.SMMNR,this.BIID_L,this.JTID_L,
    this.SYID_L,this.CIID_L,this.SINA_D,this.BINA_D,this.SCEX,this.ACNO,this.SCEXS,this.AANO2,this.SMMEQ,this.SMMDIF,
    this.SMMDI,this.SMMDIA,this.BIIDT,this.SMMCN,this.SMMDR,this.BKID,this.BMMID});

  Map<String, dynamic> toMap() {
    var map = <String, dynamic>{
      'SMMID': SMMID,
      'SMMNO': SMMNO,
      'SMKID': SMKID,
      'SMMDO': SMMDO,
      'SMMST': SMMST,
      'SMMIN': SMMIN,
      'BIID': BIID,
      'BIIDT': BIIDT,
      'SIID': SIID,
      'SIIDT': SIIDT,
      'SCID': SCID,
      'SUID': SUID,
      'SUCH': SUCH,
      'DATEU': DATEU,
      'DATEI': DATEI,
      'DEVI': DEVI,
      'DEVU': DEVU,
      'GUID': GUID,
      'AANO': AANO,
      'AANO2': AANO2,
      'SMMAM': SMMAM,
      'SMMRE': SMMRE,
      'SMMDA': SMMDA,
      'SMMNR': SMMNR,
      'SCEX': SCEX,
      'SCEXS': SCEXS,
      'SMMEQ': SMMEQ,
      'ACNO': ACNO,
      'SMMNN': SMMNN,
      'SMMDIF': SMMDIF,
      'SMMDI': SMMDI,
      'SMMDIA': SMMDIA,
      'SMMCN': SMMCN,
      'SMMDR': SMMDR,
      'BKID': BKID,
      'BMMID': BMMID,
      'JTID_L': JTID_L,
      'BIID_L': BIID_L,
      'SYID_L': SYID_L,
      'CIID_L': CIID_L,
    };
    return map;
  }

  STO_MOV_M_Local.fromMap(Map<dynamic, dynamic> map) {
    SMMID = map['SMMID'];
    SMMNO = map['SMMNO'];
    SMKID = map['SMKID'];
    SMMDO = map['SMMDO'];
    SMMST = map['SMMST'];
    SMMIN = map['SMMIN'];
    BIID = map['BIID'];
    BIIDT = map['BIIDT'];
    SIID = map['SIID'];
    SIIDT = map['SIIDT'];
    BINA = map['BINA'];
    SINA = map['SINA'];
    SCID = map['SCID'];
    AANO = map['AANO'];
    AANO2 = map['AANO2'];
    SMMAM = map['SMMAM'];
    SMMRE = map['SMMRE'];
    SMMDA = map['SMMDA'];
    SIIDTN = map['SIIDTN'];
    GUID = map['GUID'];
    SUID = map['SUID'];
    DATEI = map['DATEI'];
    DEVI = map['DEVI'];
    SMMNR = map['SMMNR'];
    SCEX = map['SCEX'];
    ACNO = map['ACNO'];
    SMMNN = map['SMMNN'];
    SCEXS = map['SCEXS'];
    SMMEQ = map['SMMEQ'];
    JTID_L = map['JTID_L'];
    BIID_L = map['BIID_L'];
    SYID_L = map['SYID_L'];
    CIID_L = map['CIID_L'];
    SINA_D = map['SINA_D'];
    BINA_D = map['BINA_D'];
    AANA_D = map['AANA_D'];
    SCNA_D = map['SCNA_D'];
    SMMDIF = map['SMMDIF'];
    SMMDI = map['SMMDI'];
    SMMDIA = map['SMMDIA'];
    SIIDT_D = map['SIIDT_D'];
    SMMDR = map['SMMDR'];
    SMMCN = map['SMMCN'];
    BKID = map['BKID'];
    BMMID = map['BMMID'];
  }

}

