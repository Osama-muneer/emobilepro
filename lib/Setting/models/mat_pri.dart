import 'dart:convert';

import '../../Setting/controllers/login_controller.dart';

class Mat_Pri_Local {
  String? MGNO;
  String? MINO;
  int? MUID;
  int? SCID;
  var MPCO;
  var MPS1;
  var MPS2;
  var MPS3;
  var MPS4;
  int? MPUP;
  var MPUP1;
  var MPUP2;
  var MPUP3;
  var MPUP4;
  String? MPDO;
  String? SUID;
  String? MPCD;
  String? SUCH;
  int? BIID;
  String? GUID;
  var MPLP;
  var MPHP;
  int? MPLT;
  int? MPHT;
  int? JTID_L;
  int? BIID_L;
  int? SYID_L;
  String? CIID_L;
  String? DATEI;
  String? DEVI;
  String? DATEU;
  String? DEVU;
  String? MINA_D;
  String? MUNA_D;
  String? SCSY;
  double? MPS1_D;
  double? MPS2_D;
  double? MPS3_D;
  double? MPS4_D;

  Mat_Pri_Local({required this.MGNO,required this.MINO,this.MUID,this.SCID,this.MPCO,this.MPS1,this.MPS2,this.MPS3
    ,this.MPS4,this.MPUP,this.MPUP1,this.MPUP2,this.MPUP3,this.MPUP4,this.MPDO,this.SUID,this.MPCD,this.SUCH,this.BIID
    ,this.GUID,this.MPLP,this.MPHP,this.MPLT,this.MPHT,this.JTID_L,this.SYID_L,this.BIID_L,this.CIID_L,
    this.DATEI,this.DEVI,this.DATEU,this.DEVU});

  Map<String, dynamic> toMap() {
    var map = <String, dynamic>{
      'MGNO': MGNO,
      'MINO': MINO,
      'MUID': MUID,
      'SCID': SCID,
      'MPCO': MPCO,
      'MPS1': MPS1,
      'MPS2': MPS2,
      'MPS3': MPS3,
      'MPS4': MPS4,
      'MPUP': MPUP,
      'MPUP1': MPUP1,
      'MPUP2': MPUP2,
      'MPUP3': MPUP3,
      'MPUP4': MPUP4,
      'MPDO': MPDO,
      'SUID': SUID,
      'MPCD': MPCD,
      'SUCH': SUCH,
      'BIID': BIID,
      'GUID': GUID,
      'MPLP': MPLP,
      'MPHP': MPHP,
      'MPLT': MPLT,
      'MPHT': MPHT,
      'DATEI': DATEI,
      'DEVI': DEVI,
      'DATEU': DATEU,
      'DEVU': DEVU,
      'JTID_L': JTID_L ?? LoginController().JTID_L,
      'SYID_L': SYID_L ?? LoginController().SYID_L,
      'BIID_L': BIID_L ?? LoginController().BIID_L,
      'CIID_L': CIID_L ?? LoginController().CIID_L,
    };
    return map;
  }

  Mat_Pri_Local.fromMap(Map<dynamic, dynamic> map) {
    MGNO = map['MGNO'];
    MINO = map['MINO'];
    MUID = map['MUID'];
    SCID = map['SCID'];
    MPCO = map['MPCO'];
    MPS1 = map['MPS1'];
    MPS2 = map['MPS2'];
    MPS3 = map['MPS3'];
    MPS4 = map['MPS4'];
    MPUP = map['MPUP'];
    MPUP1 = map['MPUP1'];
    MPUP2 = map['MPUP2'];
    MPUP3 = map['MPUP3'];
    MPUP4 = map['MPUP4'];
    MPDO = map['MPDO'];
    SUID = map['SUID'];
    MPCD = map['MPCD'];
    SUCH = map['SUCH'];
    BIID = map['BIID'];
    GUID = map['GUID'];
    MPLP = map['MPLP'];
    MPHP = map['MPHP'];
    MPLT = map['MPLT'];
    MPHT = map['MPHT'];
    DATEI = map['DATEI'];
    DEVI = map['DEVI'];
    DATEU = map['DATEU'];
    DEVU = map['DEVU'];
    JTID_L = map['JTID_L'];
    SYID_L = map['SYID_L'];
    BIID_L = map['BIID_L'];
    CIID_L = map['CIID_L'];
    MINA_D = map['MINA_D'];
    MUNA_D = map['MUNA_D'];
    SCSY = map['SCSY'];
    MPS1_D = map['MPS1_D'];
    MPS2_D = map['MPS2_D'];
    MPS3_D = map['MPS3_D'];
    MPS4_D = map['MPS4_D'];
  }

  String Mat_PriToJson(List<Mat_Pri_Local> data) =>
      json.encode(List<dynamic>.from(data.map((x) => x.toMap())));
}
