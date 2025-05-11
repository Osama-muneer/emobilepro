import '../../Setting/controllers/login_controller.dart';

class Mat_Mai_M_Local {
  int? MMMID;
  String? MMMDE;
  int? BIIDT;
  String? BIID;
  int? MMMBLT;
  String? MMMBL;
  int? PKIDT;
  String? PKID;
  int? BCCIDT;
  String? BCCID;
  int? SCIDT;
  String? SCID;
  int? BCTIDT;
  String? BCTID;
  int? BCIDT;
  int? BCDIDT;
  int? CIIDT;
  int? ECIDT;
  int? SIIDT;
  String? SIID;
  int? ACNOT;
  String? ACNO;
  int? SUIDT;
  String? SUIDV;
  String? MMMFD;
  String? MMMTD;
  String? MMMFT;
  String? MMMTT;
  String? MMMDAY;
  int? MMMST;
  String? SUID;
  String? DATEI;
  String? DATEU;
  String? SUCH;
  String? DEVI;
  String? DEVU;
  int? ORDNU;
  int? JTID_L;
  int? BIID_L;
  int? SYID_L;
  String? CIID_L;
  String? GUID;


  Mat_Mai_M_Local({this.MMMID,this.MMMDE,this.BIIDT,this.MMMBLT,this.BIID,this.PKIDT
    ,this.MMMBL,this.PKID,this.SUID,this.SUCH,this.DATEI,this.DEVI,this.DATEU,this.DEVU,
    this.MMMST,this.ORDNU,this.JTID_L,this.SYID_L,this.BIID_L,this.CIID_L,this.GUID});


  Map<String, dynamic> toMap() {
    var map = <String, dynamic>{
      'MMMID': MMMID,
      'MMMDE': MMMDE,
      'BIIDT': BIIDT,
      'MMMBLT': MMMBLT,
      'BIID': BIID,
      'PKIDT': PKIDT,
      'MMMBL': MMMBL,
      'PKID': PKID,
      'BCCIDT': BCCIDT,
      'BCCID': BCCID,
      'SCIDT': SCIDT,
      'SCID': SCID,
      'BCTIDT': BCTIDT,
      'BCTID': BCTID,
      'BCIDT': BCIDT,
      'BCDIDT': BCDIDT,
      'CIIDT': CIIDT,
      'ECIDT': ECIDT,
      'SIIDT': SIIDT,
      'SIID': SIID,
      'ACNOT': ACNOT,
      'ACNO': ACNO,
      'SUIDT': SUIDT,
      'SUIDV': SUIDV,
      'MMMFD': MMMFD,
      'MMMTD': MMMTD,
      'MMMFT': MMMFT,
      'MMMTT': MMMTT,
      'MMMDAY': MMMDAY,
      'SUID': SUID,
      'SUCH': SUCH,
      'DATEI': DATEI,
      'DEVI': DEVI,
      'DATEU': DATEU,
      'DEVU': DEVU,
      'MMMST': MMMST,
      'ORDNU': ORDNU,
      'GUID': GUID,
      'JTID_L': JTID_L ?? LoginController().JTID_L,
      'SYID_L': SYID_L ?? LoginController().SYID_L,
      'BIID_L': BIID_L ?? LoginController().BIID_L,
      'CIID_L': CIID_L ?? LoginController().CIID_L,
    };
    return map;
  }

  Mat_Mai_M_Local.fromMap(Map<dynamic, dynamic> map) {
    MMMID = map['MMMID'];
    MMMDE = map['MMMDE'];
    BIIDT = map['BIIDT'];
    MMMBLT = map['MMMBLT'];
    MMMBL = map['MMMBL'];
    PKIDT = map['PKIDT'];
    PKID = map['PKID'];
    BIID = map['BIID'];
    BCCIDT = map['BCCIDT'];
    BCCID = map['BCCID'];
    SCIDT = map['SCIDT'];
    SCID = map['SCID'];
    BCTIDT = map['BCTIDT'];
    BCTID = map['BCTID'];
    BCIDT = map['BCIDT'];
    BCDIDT = map['BCDIDT'];
    CIIDT = map['CIIDT'];
    ECIDT = map['ECIDT'];
    SIIDT = map['SIIDT'];
    SIID = map['SIID'];
    ACNOT = map['ACNOT'];
    ACNO = map['ACNO'];
    SUIDT = map['SUIDT'];
    SUIDV = map['SUIDV'];
    MMMFD = map['MMMFD'];
    MMMTD = map['MMMTD'];
    MMMFT = map['MMMFT'];
    MMMTT = map['MMMTT'];
    MMMDAY = map['MMMDAY'];
    SUID = map['SUID'];
    DATEI = map['DATEI'];
    DATEU = map['DATEU'];
    SUCH = map['SUCH'];
    DEVI = map['DEVI'];
    DEVU = map['DEVU'];
    MMMST = map['MMMST'];
    ORDNU = map['ORDNU'];
    GUID = map['GUID'];
    JTID_L = map['JTID_L'];
    SYID_L = map['SYID_L'];
    BIID_L = map['BIID_L'];
    CIID_L = map['CIID_L'];
  }

}
