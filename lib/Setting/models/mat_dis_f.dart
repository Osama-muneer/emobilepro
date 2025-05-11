import '../../Setting/controllers/login_controller.dart';

class Mat_Dis_F_Local {
  int? MDFID;
  int? MDDID;
  int? MDMID;
  String? MGNO;
  String? MINO;
  int? MUID;
  int? MDFFN;
  int? MDFTN;
  int? SCID;
  int? MDFMP;
  var MDFRA;
  int? MDFNU;
  int? MDFAM;
  int? MDFMN;
  int? MDFST;
  String? SUID;
  String? GUID;
  String? DATEI;
  String? DEVI;
  String? SUCH;
  String? DATEU;
  String? DEVU;
  int? JTID_L;
  int? BIID_L;
  int? SYID_L;
  String? CIID_L;


  Mat_Dis_F_Local({this.MDFID,this.MDDID,this.MDMID,this.MGNO,this.MINO,this.MUID,this.MDFFN,this.MDFTN,this.SCID,this.MDFMP,
    this.MDFRA,this.MDFNU,this.MDFAM,this.MDFMN,this.MDFST,this.SUID,
    this.JTID_L,this.SYID_L,this.BIID_L,this.CIID_L, this.GUID,this.DATEI,this.DEVI,this.SUCH,this.DATEU,this.DEVU});


  Map<String, dynamic> toMap() {
    var map = <String, dynamic>{
      'MDDID': MDDID,
      'MDMID': MDMID,
      'MGNO': MGNO,
      'MINO': MINO,
      'MUID': MUID,
      'MDFFN': MDFFN,
      'MDFTN': MDFTN,
      'SCID': SCID,
      'MDFMP': MDFMP,
      'MDFRA': MDFRA,
      'MDFNU': MDFNU,
      'MDFAM': MDFAM,
      'MDFMN': MDFMN,
      'MDFST': MDFST,
      'SUID': SUID,
      'GUID': GUID,
      'DATEI': DATEI,
      'DEVI': DEVI,
      'SUCH': SUCH,
      'DATEU': DATEU,
      'DEVU': DEVU,
      'JTID_L': JTID_L ?? LoginController().JTID_L,
      'SYID_L': SYID_L ?? LoginController().SYID_L,
      'BIID_L': BIID_L ?? LoginController().BIID_L,
      'CIID_L': CIID_L ?? LoginController().CIID_L,
    };
    return map;
  }

  Mat_Dis_F_Local.fromMap(Map<dynamic, dynamic> map) {
    MDDID = map['MDDID'];
    MDMID = map['MDMID'];
    MGNO = map['MGNO'];
    MINO = map['MINO'];
    MUID = map['MUID'];
    MDFFN = map['MDFFN'];
    MDFTN = map['MDFTN'];
    SCID = map['SCID'];
    MDFMP = map['MDFMP'];
    MDFRA = map['MDFRA'];
    MDFNU = map['MDFNU'];
    MDFAM = map['MDFAM'];
    MDFMN = map['MDFMN'];
    MDFST = map['MDFST'];
    SUID = map['SUID'];
    GUID = map['GUID'];
    DATEI = map['DATEI'];
    DEVI = map['DEVI'];
    SUCH = map['SUCH'];
    DATEU = map['DATEU'];
    DEVU = map['DEVU'];
    JTID_L = map['JTID_L'];
    SYID_L = map['SYID_L'];
    BIID_L = map['BIID_L'];
    CIID_L = map['CIID_L'];
  }

}
