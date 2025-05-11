class Bil_Mov_MD_Local {
  int? BMMSQ;
  int? BMKID;
  int? BMMID;
  int? MMMID;
  int? MDMID;
  int? MDDID;
  int? MDFID;
  String? GUID;
  String? GUIDM;
  double? BMMAM;
  double? BMMNO;
  double? BMMRE;
  int? BMMN1;
  int? BMMN2;
  int? BMMN3;
  String? BMMC1;
  String? BMMC2;
  String? BMMC3;
  String? BMMC4;
  String? BMMC5;
  int? BMMST;
  int? BMMSQR;
  int? MCKID;
  int? MCDID;
  int? JTID_L;
  int? BIID_L;
  int? SYID_L;
  String? CIID_L;

  Bil_Mov_MD_Local({this.BMMSQ,this.BMKID,this.MMMID,this.GUID,this.BMMID,this.MDMID,this.MDDID,
    this.MDFID,this.BMMAM,this.BMMNO,this.BMMRE,this.JTID_L,this.SYID_L,this.BIID_L,this.CIID_L,this.GUIDM});


  Map<String, dynamic> toMap() {
    var map = <String, dynamic>{
      'BMMSQ': BMMSQ,
      'BMKID': BMKID,
      'BMMID': BMMID,
      'MMMID': MMMID,
      'MDMID': MDMID,
      'MDDID': MDDID,
      'MDFID': MDFID,
      'GUID': GUID,
      'GUIDM': GUIDM,
      'BMMAM': BMMAM,
      'BMMNO': BMMNO,
      'BMMRE': BMMRE,
      'BMMN1': BMMN1,
      'BMMN2': BMMN2,
      'BMMC1': BMMC1,
      'BMMC2': BMMC2,
      'BMMC3': BMMC3,
      'BMMC4': BMMC4,
      'BMMC5': BMMC5,
      'BMMST': BMMST,
      'BMMSQR': BMMSQR,
      'MCKID': MCKID,
      'MCDID': MCDID,
      'JTID_L': JTID_L,
      'SYID_L': SYID_L,
      'BIID_L': BIID_L,
      'CIID_L': CIID_L,
    };
    return map;
  }

  Bil_Mov_MD_Local.fromMap(Map<dynamic, dynamic> map) {
    BMMSQ = map['BMMSQ'];
    BMKID = map['BMKID'];
    BMMID = map['BMMID'];
    MMMID = map['MMMID'];
    MDMID = map['MDMID'];
    MDDID = map['MDDID'];
    MDFID = map['MDFID'];
    GUID = map['GUID'];
    GUIDM = map['GUIDM'];
    BMMAM = map['BMMAM'];
    BMMNO = map['BMMNO'];
    BMMRE = map['BMMRE'];
    BMMN1 = map['BMMN1'];
    BMMN2 = map['BMMN2'];
    BMMN3 = map['BMMN3'];
    BMMC1 = map['BMMC1'];
    BMMC2 = map['BMMC2'];
    BMMC3 = map['BMMC3'];
    BMMC4 = map['BMMC4'];
    BMMC5 = map['BMMC5'];
    BMMST = map['BMMST'];
    BMMSQR = map['BMMSQR'];
    MCKID = map['MCKID'];
    MCDID = map['MCDID'];
    JTID_L = map['JTID_L'];
    SYID_L = map['SYID_L'];
    BIID_L = map['BIID_L'];
    CIID_L = map['CIID_L'];
  }

}
