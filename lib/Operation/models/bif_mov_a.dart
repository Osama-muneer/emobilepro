class Bif_Mov_A_Local {
  int? BMKID;
  int? BMMID;
  int? BMMNO;
  int? RSID;
  String? RTID;
  var REID;
  var BMATY;
  String? GUID;
  var BDID;
  double? BMACR;
  double? BMACA;
  var BCDID;
  String? GUIDR;
  String? BMADD;
  double? BMADT;
  var PKIDB;
  String? GUIDP;
  int? JTID_L;
  int? BIID_L;
  int? SYID_L;
  String? CIID_L;


  Bif_Mov_A_Local({this.BMMID,this.BMKID,this.BMMNO,this.GUID,this.BDID,this.BCDID,this.BMACA,this.BMACR,this.BMADD,this.BMADT
    ,this.BMATY,this.GUIDP,this.GUIDR,this.PKIDB,this.REID,this.RSID,this.RTID,this.JTID_L,this.SYID_L,this.BIID_L,this.CIID_L});


  Map<String, dynamic> toMap() {
    var map = <String, dynamic>{
      'BMKID': BMKID,
      'BMMID': BMMID,
      'BMMNO': BMMNO,
      'RSID': RSID,
      'RTID': RTID,
      'REID': REID,
      'BMATY': BMATY,
      'GUID': GUID,
      'BDID': BDID,
      'BMACR': BMACR,
      'BMACA': BMACA,
      'BCDID': BCDID,
      'GUIDR': GUIDR,
      'BMADT': BMADT,
      'BMADD': BMADD,
      'PKIDB': PKIDB,
      'GUIDP': GUIDP,
      'JTID_L': JTID_L,
      'SYID_L': SYID_L,
      'BIID_L': BIID_L,
      'CIID_L': CIID_L,
    };
    return map;
  }

  Bif_Mov_A_Local.fromMap(Map<dynamic, dynamic> map) {
    BMKID = map['BMKID'];
    BMMID = map['BMMID'];
    BMMNO = map['BMMNO'];
    RSID = map['RSID'];
    RTID = map['RTID'];
    REID = map['REID'];
    BMATY = map['BMATY'];
    GUID = map['GUID'];
    BDID = map['BDID'];
    BMACR = map['BMACR'];
    BMACA = map['BMACA'];
    BCDID = map['BCDID'];
    GUIDR = map['GUIDR'];
    BMADT = map['BMADT'];
    BMADD = map['BMADD'];
    PKIDB = map['PKIDB'];
    GUIDP = map['GUIDP'];
    JTID_L = map['JTID_L'];
    SYID_L = map['SYID_L'];
    BIID_L = map['BIID_L'];
    CIID_L = map['CIID_L'];
  }

}
