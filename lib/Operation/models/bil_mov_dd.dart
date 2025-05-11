class Bil_Mov_DD_Local {
  int? BMDSQ;
  int? BMKID;
  int? BMMID;
  int? BMDID;
  int? MMMID;
  int? MDMID;
  int? MDDID;
  int? MDFID;
  String? MGNO;
  String? MINO;
  int? MUID;
  String? GUID;
  String? GUIDM;
  int? MDTID;
  double? BMDAM;
  double? BMDNO;
  double? BMDRE;
  int? BMDN1;
  int? BMDN2;
  String? BMDC1;
  String? BMDC2;
  String? BMDC3;
  int? BMDST;
  int? BMDSQR;
  int? MCKID;
  int? MCDID;
  int? JTID_L;
  int? BIID_L;
  int? SYID_L;
  String? CIID_L;

  Bil_Mov_DD_Local({this.BMDSQ,this.BMKID,this.MGNO,this.MINO,this.MUID,this.MMMID,this.GUID,this.BMMID,this.MDMID,this.MDDID,
    this.MDFID,this.MDTID,this.BMDAM,this.BMDNO,this.BMDRE,this.JTID_L,this.SYID_L,this.BIID_L,this.CIID_L,this.GUIDM});


  Map<String, dynamic> toMap() {
    var map = <String, dynamic>{
      'BMDSQ': BMDSQ,
      'BMKID': BMKID,
      'BMMID': BMMID,
      'BMDID': BMDID,
      'MGNO': MGNO,
      'MINO': MINO,
      'MUID': MUID,
      'MMMID': MMMID,
      'MDMID': MDMID,
      'MDDID': MDDID,
      'MDFID': MDFID,
      'GUID': GUID,
      'GUIDM': GUIDM,
      'BMDAM': BMDAM,
      'MDTID': MDTID,
      'BMDNO': BMDNO,
      'BMDRE': BMDRE,
      'BMDN1': BMDN1,
      'BMDN2': BMDN2,
      'BMDC1': BMDC1,
      'BMDC2': BMDC2,
      'BMDC3': BMDC3,
      'BMDST': BMDST,
      'BMDSQR': BMDSQR,
      'MCKID': MCKID,
      'MCDID': MCDID,
      'JTID_L': JTID_L,
      'SYID_L': SYID_L,
      'BIID_L': BIID_L,
      'CIID_L': CIID_L,
    };
    return map;
  }

  Bil_Mov_DD_Local.fromMap(Map<dynamic, dynamic> map) {
    BMDSQ = map['BMDSQ'];
    BMKID = map['BMKID'];
    BMMID = map['BMMID'];
    BMDID = map['BMDID'];
    MGNO = map['MGNO'];
    MINO = map['MINO'];
    MUID = map['MUID'];
    MMMID = map['MMMID'];
    MDMID = map['MDMID'];
    MDDID = map['MDDID'];
    MDFID = map['MDFID'];
    GUID = map['GUID'];
    GUIDM = map['GUIDM'];
    MDTID = map['MDTID'];
    BMDAM = map['BMDAM'];
    BMDNO = map['BMDNO'];
    BMDRE = map['BMDRE'];
    BMDN1 = map['BMDN1'];
    BMDN2 = map['BMDN2'];
    BMDC1 = map['BMDC1'];
    BMDC2 = map['BMDC2'];
    BMDC3 = map['BMDC3'];
    BMDST = map['BMDST'];
    BMDSQR = map['BMDSQR'];
    MCKID = map['MCKID'];
    MCDID = map['MCDID'];
    JTID_L = map['JTID_L'];
    SYID_L = map['SYID_L'];
    BIID_L = map['BIID_L'];
    CIID_L = map['CIID_L'];
  }

}
