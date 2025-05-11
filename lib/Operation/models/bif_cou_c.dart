class Bif_Cou_C_Local {
  int? BCCID;
  int? BCMID;
  String? GUIDM;
  int? BCCST;
  int? SCIDC;
  int? SCNO;
  int? CTMID;
  int? CIMID;
  String? BCMFD;
  String? BCMTD;
  String? BCMFT;
  String? BCMTT;
  double? BCMRO;
  double? BCMRN;
  int? SIID;
  String? BCCIN;
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
  int? BCCID1;
  int? BCCID2;
  int? BCCID3;
  double? BCMAM1;
  double? BCMAM2;
  double? BCMAM3;
  double? BCMAMSUM;
  String? DATEI;
  String? DEVI;
  String? DATEU;
  String? DEVU;
  int? BCMPT;
  String? GUID;
  int? JTID_L;
  int? BIID_L;
  int? SYID_L;
  String? CIID_L;
  String? CIMNA_D;
  String? CTMNA_D;
  int? COUNTCIMID;
  int? COUNTBCCID;
  double? SUMBCMRN;
  double? SUMBCMRO;
  double? SUMBCMAMSUM;
  double? SUMBCMTA;
  double? SUMBCMAM;
  double? SUMBCMAMC;


  Bif_Cou_C_Local({this.BCCID,this.BCMID,this.GUIDM,this.BCCST,this.SCIDC,this.SCNO,this.CTMID,this.CIMID,this.BCMFD,this.BCMTD,this.BCMFT
    ,this.BCMTT,this.BCMRO,this.BCMRN,this.SIID,this.BCCIN,this.SCID,this.SCEX,this.BCMAM,this.BCMTX,this.BCMDI,this.BCMDIA,this.BCMAMSUM
    ,this.BCMTXD,this.ACID,this.BCMTA,this.ACNO,this.SUID,this.SUCH,this.SCEXS,this.BMKIDR,this.BMMIDR,this.AMMIDR,this.AMKIDR,this.SUMBCMAM
    ,this.BCMAT,this.BCMAT1,this.BCMAT2,this.BCMAT3,this.BCMTY,this.BCCID1,this.BCCID2,this.BCCID3,this.BCMAM1,this.BCMAM2,this.BCMAM3,
    this.DATEI,this.DEVU,this.DATEU,this.GUID,this.DEVI,this.BCMPT,this.CIMNA_D,this.CTMNA_D,this.SUMBCMAMSUM,this.SUMBCMTA,this.SUMBCMAMC,
    this.JTID_L, this.SYID_L,this.BIID_L,this.CIID_L,this.COUNTCIMID,this.COUNTBCCID,this.SUMBCMRN,this.SUMBCMRO});


  Map<String, dynamic> toMap() {
    var map = <String, dynamic>{
      'BCCID': BCCID,
      'BCMID': BCMID,
      'GUIDM': GUIDM,
      'BCCST': BCCST,
      'SCIDC': SCIDC,
      'SCNO': SCNO,
      'CTMID': CTMID,
      'CIMID': CIMID,
      'BCMFD': BCMFD,
      'BCMTD': BCMTD,
      'BCMFT': BCMFT,
      'BCMTT': BCMTT,
      'BCMRO': BCMRO,
      'BCMRN': BCMRN,
      'SIID': SIID,
      'BCCIN': BCCIN,
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
      'BCMAMSUM': BCMAMSUM,
    };
    return map;
  }

  Bif_Cou_C_Local.fromMap(Map<dynamic, dynamic> map) {
    BCCID = map['BCCID'];
    BCMID = map['BCMID'];
    GUIDM = map['GUIDM'];
    BCCST = map['BCCST'];
    SCIDC = map['SCIDC'];
    SCNO = map['SCNO'];
    CTMID = map['CTMID'];
    CIMID = map['CIMID'];
    BCMFD = map['BCMFD'];
    BCMTD = map['BCMTD'];
    BCMFT = map['BCMFT'];
    BCMTT = map['BCMTT'];
    BCMRO = map['BCMRO'];
    BCMRN = map['BCMRN'];
    SIID = map['SIID'];
    BCCIN = map['BCCIN'];
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
    BCMAMSUM = map['BCMAMSUM'];
    DATEI = map['DATEI'];
    DEVI = map['DEVI'];
    DATEU = map['DATEU'];
    DEVU = map['DEVU'];
    BCMPT = map['BCMPT'];
    JTID_L = map['JTID_L'];
    SYID_L = map['SYID_L'];
    BIID_L = map['BIID_L'];
    CIID_L = map['CIID_L'];
    CIMNA_D = map['CIMNA_D'];
    CTMNA_D = map['CTMNA_D'];
    GUID = map['GUID'];
    COUNTCIMID = map['COUNTCIMID'];
    COUNTBCCID = map['COUNTBCCID'];
    SUMBCMRN = map['SUMBCMRN'];
    SUMBCMRO = map['SUMBCMRO'];
    SUMBCMAMSUM = map['SUMBCMAMSUM'];
    SUMBCMTA = map['SUMBCMTA'];
    SUMBCMAM = map['SUMBCMAM'];
    SUMBCMAMC = map['SUMBCMAMC'];
  }
}
