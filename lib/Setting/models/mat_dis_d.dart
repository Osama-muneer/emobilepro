import '../../Setting/controllers/login_controller.dart';

class Mat_Dis_D_Local {
  int? MDDID;
  int? MDMID;
  String? MGNO;
  String? MINO;
  int? MUID;
  var MDDRA;
  int? MDDNU;
  int? MDDAM;
  int? MDDMN;
  int? MDDSI;
  int? MDDST;
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


  Mat_Dis_D_Local({this.MDDID,this.MDMID,this.MGNO,this.MINO,this.MUID,this.MDDRA,this.MDDNU,this.MDDAM,this.MDDMN,
    this.MDDSI,this.MDDST,this.SUID,
    this.JTID_L,this.SYID_L,this.BIID_L,this.CIID_L, this.GUID,this.DATEI,this.DEVI,this.SUCH,this.DATEU,this.DEVU});


  Map<String, dynamic> toMap() {
    var map = <String, dynamic>{
      'MDDID': MDDID,
      'MDMID': MDMID,
      'MGNO': MGNO,
      'MINO': MINO,
      'MUID': MUID,
      'MDDRA': MDDRA,
      'MDDNU': MDDNU,
      'MDDAM': MDDAM,
      'MDDMN': MDDMN,
      'MDDSI': MDDSI,
      'MDDST': MDDST,
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

  Mat_Dis_D_Local.fromMap(Map<dynamic, dynamic> map) {
    MDDID = map['MDDID'];
    MDMID = map['MDMID'];
    MGNO = map['MGNO'];
    MINO = map['MINO'];
    MUID = map['MUID'];
    MDDRA = map['MDDRA'];
    MDDNU = map['MDDNU'];
    MDDAM = map['MDDAM'];
    MDDMN = map['MDDMN'];
    MDDSI = map['MDDSI'];
    MDDST = map['MDDST'];
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
