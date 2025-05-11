import 'dart:convert';

class Bif_Cou_M_Local {
  int? BIID;
  int? BCMID;
  int? BCMNO;
  String? BCMDO;
  int? BCMST;
  int? SCIDC;
  int? SCNO;
  int? BPID;
  String? BCMFD;
  String? BCMTD;
  double? BCMRO;
  double? BCMRN;
  String? MGNO;
  String? MINO;
  int? MUID;
  int? SIID;
  String? BCMRE;
  String? BCMIN;
  int? SCID;
  double? SCEX;
  double? BCMAM;
  int? BCMTX;
  int? BCMDI;
  int? BCMDIA;
  int? BCMTXD;
  int? ACID;
  double? BCMTA;
  String? ACNO;
  String? SUID;
  String? SUCH;
  int? SCEXS;
  int? BMKIDR;
  int? BMMIDR;
  int? AMKIDR;
  int? AMMIDR;
  int? BCMAT;
  int? BCMAT1;
  int? BCMAT2;
  int? BCMAT3;
  int? BCMTY;
  int? CTMID;
  int? CIMID;
  int? BCCID1;
  int? BCCID2;
  int? BCCID3;
  double? BCMAM1;
  double? BCMAM2;
  double? BCMAM3;
  String? DATEI;
  String? DEVI;
  String? DATEU;
  String? DEVU;
  int? BCMPT;
  int? JTID_L;
  int? BIID_L;
  int? SYID_L;
  String? CIID_L;
  String? PKNA_D;
  String?  BINA_D;
  String?  BPNA_D;
  String?  CTMNA_D;
  String?  SCNA_D;
  String?  GUID;
  String?  BCMFT;
  String?  BCMTT;
  int?  BCMKI;
  int?  BCMNR;
  String?  BCMRD;


  Bif_Cou_M_Local({this.BIID,this.CIMID,this.SCEX,this.CTMID,this.SIID,this.BMMIDR,this.SUID,this.BPID,this.SUCH,this.SCID,this.ACNO
    ,this.MGNO,this.MINO,this.MUID,this.ACID,this.AMKIDR,this.AMMIDR,this.BCMAM,this.BCMAT,this.BCMAT1,this.BCMAT2,this.BCMAT3
    ,this.BCMDI,this.BCMDIA,this.BCMDO,this.BCMFD,this.BCMID,this.BCMIN,this.BCMNO,this.BCMRE,this.BCMRN,this.BCMRO,this.BCMST
    ,this.BCMTA,this.BCMTD,this.BCMTX,this.BCMTXD,this.BCMTY,this.BMKIDR,this.SCEXS,this.SCIDC,this.SCNO,this.DATEU,this.DEVU,
    this.BINA_D,this.DEVI,this.DATEI,this.PKNA_D,this.BCCID1,this.BCCID2,this.BCCID3,this.BCMAM1,this.BCMAM2,this.BCMAM3,this.BCMPT,this.BCMRD,
    this.BPNA_D,this.CTMNA_D,this.SCNA_D,this.JTID_L, this.SYID_L,this.BIID_L,this.CIID_L,this.GUID,this.BCMFT,this.BCMTT,this.BCMKI,this.BCMNR});


  Map<String, dynamic> toMap() {
    var map = <String, dynamic>{
      'BIID': BIID,
      'BCMID': BCMID,
      'BCMNO': BCMNO,
      'BCMDO': BCMDO,
      'BCMST': BCMST,
      'SCIDC': SCIDC,
      'SCNO': SCNO,
      'BPID': BPID,
      'BCMFD': BCMFD,
      'BCMTD': BCMTD,
      'BCMRO': BCMRO,
      'BCMRN': BCMRN,
      'MGNO': MGNO,
      'MINO': MINO,
      'MUID': MUID,
      'SIID': SIID,
      'BCMRE': BCMRE,
      'BCMIN': BCMIN,
      'SCID': SCID,
      'SCEX': SCEX,
      'BCMAM': BCMAM,
      'BCMTX': BCMTX,
      'BCMDI': BCMDI,
      'BCMDIA': BCMDIA,
      'BCMTXD': BCMTXD,
      'ACID': ACID,
      'BCMTA': BCMTA,
      'ACNO': ACNO,
      'SUID': SUID,
      'SUCH': SUCH,
      'SCEXS': SCEXS,
      'BMKIDR': BMKIDR,
      'BMMIDR': BMMIDR,
      'AMKIDR': AMKIDR,
      'AMMIDR': AMMIDR,
      'BCMAT': BCMAT,
      'BCMAT1': BCMAT1,
      'BCMAT2': BCMAT2,
      'BCMAT3': BCMAT3,
      'BCMTY': BCMTY,
      'CTMID': CTMID,
      'CIMID': CIMID,
      'BCCID1': BCCID1,
      'BCCID2': BCCID2,
      'BCCID3': BCCID3,
      'BCMAM1': BCMAM1,
      'BCMAM2': BCMAM2,
      'BCMAM3': BCMAM3,
      'DATEI': DATEI,
      'DEVI': DEVI,
      'DATEU': DATEU,
      'DEVU': DEVU,
      'BCMPT': BCMPT,
      'JTID_L': JTID_L,
      'SYID_L': SYID_L,
      'BIID_L': BIID_L,
      'CIID_L': CIID_L,
      'GUID': GUID,
      'BCMFT': BCMFT,
      'BCMTT': BCMTT,
      'BCMKI': BCMKI,
      'BCMNR': BCMNR,
      'BCMRD': BCMRD,
    };
    return map;
  }

  Bif_Cou_M_Local.fromMap(Map<dynamic, dynamic> map) {
    BIID = map['BIID'];
    BCMID = map['BCMID'];
    BCMNO = map['BCMNO'];
    BCMDO = map['BCMDO'];
    BCMST = map['BCMST'];
    SCIDC = map['SCIDC'];
    SCNO = map['SCNO'];
    BPID = map['BPID'];
    BCMFD = map['BCMFD'];
    BCMTD = map['BCMTD'];
    BCMRO = map['BCMRO'];
    BCMRN = map['BCMRN'];
    MGNO = map['MGNO'];
    MINO = map['MINO'];
    MUID = map['MUID'];
    SIID = map['SIID'];
    BCMRE = map['BCMRE'];
    BCMIN = map['BCMIN'];
    SCID = map['SCID'];
    SCEX = map['SCEX'];
    BCMAM = map['BCMAM'];
    BCMTX = map['BCMTX'];
    BCMDI = map['BCMDI'];
    BCMDIA = map['BCMDIA'];
    BCMTXD = map['BCMTXD'];
    ACID = map['ACID'];
    BCMTA = map['BCMTA'];
    ACNO = map['ACNO'];
    SUID = map['SUID'];
    SUCH = map['SUCH'];
    SCEXS = map['SCEXS'];
    BMKIDR = map['BMKIDR'];
    AMKIDR = map['AMKIDR'];
    AMMIDR = map['AMMIDR'];
    BCMAT = map['BCMAT'];
    BCMAT1 = map['BCMAT1'];
    BCMAT2 = map['BCMAT2'];
    BCMAT3 = map['BCMAT3'];
    BCMTY = map['BCMTY'];
    CTMID = map['CTMID'];
    CIMID = map['CIMID'];
    BCCID1 = map['BCCID1'];
    BCCID2 = map['BCCID2'];
    BCCID3 = map['BCCID3'];
    BCMAM1 = map['BCMAM1'];
    BCMAM2 = map['BCMAM2'];
    BCMAM3 = map['BCMAM3'];
    DATEI = map['DATEI'];
    DEVI = map['DEVI'];
    DATEU = map['DATEU'];
    DEVU = map['DEVU'];
    BCMPT = map['BCMPT'];
    JTID_L = map['JTID_L'];
    SYID_L = map['SYID_L'];
    BIID_L = map['BIID_L'];
    CIID_L = map['CIID_L'];
    BINA_D = map['BINA_D'];
    BPNA_D = map['BPNA_D'];
    PKNA_D = map['PKNA_D'];
    CTMNA_D = map['CTMNA_D'];
    SCNA_D = map['SCNA_D'];
    GUID = map['GUID'];
    BCMFT = map['BCMFT'];
    BCMTT = map['BCMTT'];
    BCMKI = map['BCMKI'];
    BCMNR = map['BCMNR'];
    BCMRD = map['BCMRD'];
  }
}
