import 'dart:convert';

import '../../Setting/controllers/login_controller.dart';

class Mat_Pri_Y_Local {
  String? MPYID;
  int? SYID;
  int? BIID2;
  int? BMKID;
  int? SCID;
  int? BCID;
  String? MGNO;
  String? MINO;
  int? MUID;
  double? BMDAM;
  String? BMDED;
  String? BMMDO;
  int? JTID;
  double? BMDAMH;
  double? BMDAML;
  int? BMMID;
  double? BMDAMO;
  double? BMDAMHO;
  double? BMDAMLO;
  int? BMMIDO;
  String? BMMDOO;
  int? MUIDO;
  String? SUID;
  String? DATEI;
  String? SUCH;
  String? DATEU;
  String? GUID;
  int? JTID_L;
  int? BIID_L;
  int? SYID_L;
  String? CIID_L;

  Mat_Pri_Y_Local({ this.MPYID, this.SYID,this.BIID2,this.BMKID,this.SCID,this.BCID,this.MGNO,this.MINO
    ,this.MUID,this.BMDAM,this.BMDED,this.BMMDO,this.JTID,this.BMDAMH,this.BMDAML,this.BMMID,this.BMDAMO,this.BMDAMHO,
    this.BMDAMLO,this.BMMIDO,this.BMMDOO,this.MUIDO,this.SUID,this.DATEI,this.SUCH,this.DATEU,this.GUID
    ,this.JTID_L,this.SYID_L,this.BIID_L,this.CIID_L});

  Map<String, dynamic> toMap() {
    var map = <String, dynamic>{
      'MPYID': MPYID,
      'SYID': SYID,
      'BIID2': BIID2,
      'BMKID': BMKID,
      'SCID': SCID,
      'BCID': BCID,
      'MGNO': MGNO,
      'MINO': MINO,
      'MUID': MUID,
      'BMDAM': BMDAM,
      'BMDED': BMDED,
      'BMMDO': BMMDO,
      'JTID': JTID,
      'BMDAMH': BMDAMH,
      'BMDAML': BMDAML,
      'BMMID': BMMID,
      'BMDAMO': BMDAMO,
      'BMDAMHO': BMDAMHO,
      'BMDAMLO': BMDAMLO,
      'BMMIDO': BMMIDO,
      'BMMDOO': BMMDOO,
      'MUIDO': MUIDO,
      'SUID': SUID,
      'DATEI': DATEI,
      'SUCH': SUCH,
      'DATEU': DATEU,
      'GUID': GUID,
      'JTID_L': JTID_L ?? LoginController().JTID_L,
      'SYID_L': SYID_L ?? LoginController().SYID_L,
      'BIID_L': BIID_L ?? LoginController().BIID_L,
      'CIID_L': CIID_L ?? LoginController().CIID_L,
    };
    return map;
  }

  Mat_Pri_Y_Local.fromMap(Map<dynamic, dynamic> map) {
    MPYID = map['MPYID'];
    SYID = map['SYID'];
    BIID2 = map['BIID2'];
    BMKID = map['BMKID'];
    SCID = map['SCID'];
    BCID = map['BCID'];
    MGNO = map['MGNO'];
    MINO = map['MINO'];
    MUID = map['MUID'];
    BMDAM = map['BMDAM'];
    BMDED = map['BMDED'];
    BMMDO = map['BMMDO'];
    JTID = map['JTID'];
    BMDAMH = map['BMDAMH'];
    BMDAML = map['BMDAML'];
    BMMID = map['BMMID'];
    BMDAMO = map['BMDAMO'];
    BMDAMHO = map['BMDAMHO'];
    BMDAMLO = map['BMDAMLO'];
    BMMIDO = map['BMMIDO'];
    BMMDOO = map['BMMDOO'];
    MUIDO = map['MUIDO'];
    SUID = map['SUID'];
    DATEI = map['DATEI'];
    SUCH = map['SUCH'];
    DATEU = map['DATEU'];
    GUID = map['GUID'];
    JTID_L = map['JTID_L'];
    SYID_L = map['SYID_L'];
    BIID_L = map['BIID_L'];
    CIID_L = map['CIID_L'];
  }

  String Mat_PriToJson(List<Mat_Pri_Y_Local> data) =>
      json.encode(List<dynamic>.from(data.map((x) => x.toMap())));
}
