
class Acc_Mov_M_Local {
  int? AMKID;
  int? AMMID;
  int? AMMNO;
  String? PKID;
  String? AMMDO;
  int? AMMST;
  String? AMMRE;
  int? AMMCC;
  int? SCID;
  String? SCEX;
  double? AMMAM;
  double? AMMEQ;
  int? ACID;
  int? ABID;
  String? AMMCN;
  String? AMMCD;
  String? AMMCI;
  var BDID;
  String? AMMIN;
  String? AMMNA;
  String? AMMRE2;
  String? ACNO;
  String? AMMDN;
  var BKID;
  var BMMID;
  String? SUID;
  var AMMDA;
  var SUAP;
  var AMMDU;
  var SUUP;
  int? AMMCT;
  String? BIID;
  int? BCCID;
  String? GUID;
  int? AMMBR;
  String? BIIDB;
  String? DATEI;
  String? DATEU;
  String? SUCH;
  String? GUID_LNK;
  String? DEVI;
  String? DEVU;
  String? JTID_L;
  int? BIID_L;
  int? SYID_L;
  String? CIID_L;
  String? BINA_D;
  String? PKNA_D;
  String? SCSY;
  String? SCNA_D;
  String? ACNA_D;
  String? BCCNA_D;
  String? ABNA_D;
  String? AMMDOR;
  int? AMMPR;
  int? ROWN1;
  String? AANO_D;
  String? AMDIN;
  double? AMDDA;
  double? AMDMD;

  Acc_Mov_M_Local({this.AMKID,this.AMMID,this.AMMNO,this.PKID,this.AMMDO,this.AMMST,this.AMMRE,this.AMMCC,this.SCID,this.SCEX
    ,this.AMMAM,this.AMMEQ,this.ACID,this.ABID,this.AMMCN,this.AMMCD,this.AMMCI,this.BDID,this.AMMIN,this.AMMNA,this.AMMRE2,
    this.ACNO,this.AMMDN,this.BKID,this.BMMID,this.SUID,this.AMMDA,this.SUAP,this.AMMDU,this.SUUP,this.AMMCT,this.BIID,
    this.BCCID,this.GUID, this.AMMBR,this.BIIDB,this.DATEI,this.DATEU,this.SUCH, this.GUID_LNK,this.DEVI,this.DEVU,
    this.JTID_L,this.SYID_L,this.BIID_L,this.CIID_L,this.BINA_D,this.PKNA_D,this.SCSY,this.SCNA_D,this.ACNA_D,
    this.BCCNA_D,this.ABNA_D,this.AMMPR,this.AMMDOR,this.ROWN1,this.AANO_D,this.AMDMD});
  Map<String, dynamic> toMap() {
    var map = <String, dynamic>{
      'AMKID': AMKID,
      'AMMID': AMMID,
      'AMMNO': AMMNO,
      'PKID': PKID,
      'AMMDO': AMMDO,
      'AMMST': AMMST,
      'AMMRE': AMMRE,
      'AMMCC': AMMCC,
      'SCID': SCID,
      'SCEX': SCEX,
      'AMMAM': AMMAM,
      'AMMEQ': AMMEQ,
      'ACID': ACID,
      'ABID': ABID,
      'AMMCN': AMMCN,
      'AMMCD': AMMCD,
      'AMMCI': AMMCI,
      'BDID': BDID,
      'AMMIN': AMMIN,
      'AMMNA': AMMNA,
      'AMMRE2': AMMRE2,
      'ACNO': ACNO,
      'AMMDN': AMMDN,
      'BKID': BKID,
      'BMMID': BMMID,
      'SUID': SUID,
      'AMMDA': AMMDA,
      'SUAP': SUAP,
      'AMMDU': AMMDU,
      'SUUP': SUUP,
      'AMMCT': AMMCT,
      'BIID': BIID,
      'BCCID': BCCID,
      'GUID': GUID,
      'AMMBR': AMMBR,
      'BIIDB': BIIDB,
      'DATEI': DATEI,
      'DATEU': DATEU,
      'SUCH': SUCH,
      'GUID_LNK': GUID_LNK,
      'DEVI': DEVI,
      'DEVU': DEVU,
      'AMMPR': AMMPR,
      'AMMDOR': AMMDOR,
      'ROWN1': ROWN1,
      'JTID_L': JTID_L,
      'SYID_L': SYID_L,
      'BIID_L': BIID_L,
      'CIID_L': CIID_L,
    };
    return map;
  }
  Acc_Mov_M_Local.fromMap(Map<dynamic, dynamic> map) {
    AMKID = map['AMKID'];
    AMMID = map['AMMID'];
    AMMNO = map['AMMNO'];
    PKID = map['PKID'];
    AMMDO = map['AMMDO'];
    AMMST = map['AMMST'];
    AMMRE = map['AMMRE'];
    AMMCC = map['AMMCC'];
    SCID = map['SCID'];
    SCEX = map['SCEX'];
    AMMAM = map['AMMAM'];
    AMMEQ = map['AMMEQ'];
    ACID = map['ACID'];
    ABID = map['ABID'];
    AMMCN = map['AMMCN'];
    AMMCD = map['AMMCD'];
    AMMCI = map['AMMCI'];
    BDID = map['BDID'];
    AMMIN = map['AMMIN'];
    AMMNA = map['AMMNA'];
    AMMRE2 = map['AMMRE2'];
    ACNO = map['ACNO'];
    AMMDN = map['AMMDN'];
    BKID = map['BKID'];
    BMMID = map['BMMID'];
    SUID = map['SUID'];
    AMMDA = map['AMMDA'];
    SUAP = map['SUAP'];
    AMMDU = map['AMMDU'];
    SUUP = map['SUUP'];
    AMMCT = map['AMMCT'];
    BIID = map['BIID'];
    BCCID = map['BCCID'];
    GUID = map['GUID'];
    AMMBR = map['AMMBR'];
    BIIDB = map['BIIDB'];
    DATEI = map['DATEI'];
    DATEU = map['DATEU'];
    SUCH = map['SUCH'];
    GUID_LNK = map['GUID_LNK'];
    DEVI = map['DEVI'];
    DEVU = map['DEVU'];
    JTID_L = map['JTID_L'];
    SYID_L = map['SYID_L'];
    BIID_L = map['BIID_L'];
    CIID_L = map['CIID_L'];
    BINA_D = map['BINA_D'];
    PKNA_D = map['PKNA_D'];
    SCSY = map['SCSY'];
    SCNA_D = map['SCNA_D'];
    ACNA_D = map['ACNA_D'];
    BCCNA_D = map['BCCNA_D'];
    ABNA_D = map['ABNA_D'];
    AMMDOR = map['AMMDOR'];
    AMMPR = map['AMMPR'];
    ROWN1 = map['ROWN1'];
    AANO_D = map['AANO_D'];
    AMDIN = map['AMDIN'];
    AMDDA = map['AMDDA'];
    AMDMD = map['AMDMD'];
  }

}
