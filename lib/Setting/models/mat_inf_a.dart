import 'dart:convert';

import '../../Setting/controllers/login_controller.dart';

class Mat_Inf_A_Local {
  String? MBID;
  String? MGNO;
  String? MINO;
  String? MIPN2;
  String? MIPNC2;
  int? JTID_L;
  int? BIID_L;
  int? SYID_L;
  String? CIID_L;
  String? GUID;
  String? DATEI;
  String? DEVI;
  String? SUID;
  String? SUCH;
  String? DATEU;
  String? DEVU;


  Mat_Inf_A_Local({this.MBID,required this.MGNO,this.MINO,this.MIPN2,this.MIPNC2,this.JTID_L,this.SYID_L,this.BIID_L,this.CIID_L,
    this.GUID,this.DATEI,this.DEVI,this.SUCH,this.DATEU,this.DEVU,this.SUID});

  Map<String, dynamic> toMap() {
    var map = <String, dynamic>{
      'MBID': MBID,
      'MGNO': MGNO,
      'MINO': MINO,
      'MIPN2': MIPN2,
      'MIPNC2': MIPNC2,
      'GUID': GUID,
      'DATEI': DATEI,
      'DEVI': DEVI,
      'SUCH': SUCH,
      'DATEU': DATEU,
      'DEVU': DEVU,
      'SUID': SUID,
      'JTID_L': JTID_L ?? LoginController().JTID_L,
      'SYID_L': SYID_L ?? LoginController().SYID_L,
      'BIID_L': BIID_L ?? LoginController().BIID_L,
      'CIID_L': CIID_L ?? LoginController().CIID_L,
    };
    return map;
  }

  Mat_Inf_A_Local.fromMap(Map<dynamic, dynamic> map) {
    MGNO = map['MGNO'];
    MGNO = map['MGNO'];
    MINO = map['MINO'];
    MIPN2 = map['MIPN2'];
    MIPNC2 = map['MIPNC2'];
    GUID = map['GUID'];
    DATEI = map['DATEI'];
    DEVI = map['DEVI'];
    SUCH = map['SUCH'];
    DATEU = map['DATEU'];
    DEVU = map['DEVU'];
    SUID = map['SUID'];
    JTID_L = map['JTID_L'];
    SYID_L = map['SYID_L'];
    BIID_L = map['BIID_L'];
    CIID_L = map['CIID_L'];
  }

  String Mat_Inf_AToJson(List<Mat_Inf_A_Local> data) =>
      json.encode(List<dynamic>.from(data.map((x) => x.toMap())));
}
