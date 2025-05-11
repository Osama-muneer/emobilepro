import 'dart:convert';

import '../../Setting/controllers/login_controller.dart';

class Mat_Uni_B_Local {
  String? MGNO;
  String? MINO;
  String? MINA;
  int? MUID ;
  String? MUCBC;
  int? MUCBT;
  String? MUBNA;
  String? MUBDO;
  String? SUID;
  String? GUID;
  int? JTID_L;
  int? BIID_L;
  int? SYID_L;
  String? CIID_L;
  String? DATEI;
  String? DEVI;
  String? SUCH;
  String? DATEU;
  String? DEVU;
  int? MITSK;
  int? MGKI;
  int? MIED;
  double? MITS;


  Mat_Uni_B_Local({required this.MGNO,required this.MINO, this.MINA,required this.MUID,required this.MUCBC,this.MUCBT,
    this.MUBNA,this.MUBDO,this.SUID,this.GUID,this.JTID_L,this.SYID_L,this.BIID_L,this.CIID_L
    ,this.DATEI,this.DEVI,this.SUCH,this.DATEU,this.DEVU,});

  Map<String, dynamic> toMap() {
    var map = <String, dynamic>{
      'MGNO': MGNO,
      'MINO': MINO,
      'MUID': MUID,
      'MUCBC': MUCBC,
      'MUCBT': MUCBT,
      'MUBNA': MUBNA,
      'MUBDO': MUBDO,
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

  Mat_Uni_B_Local.fromMap(Map<dynamic, dynamic> map) {
    MGNO = map['MGNO'];
    MINO = map['MINO'];
    MINA = map['MINA'];
    MUID = map['MUID'];
    MUCBC = map['MUCBC'];
    MUCBT = map['MUCBT'];
    MUBNA = map['MUBNA'];
    MUBDO = map['MUBDO'];
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
    MITSK = map['MITSK'];
    MGKI = map['MGKI'];
    MIED = map['MIED'];
    MITS = map['MITS'];
  }

  String MAT_UNI_BToJson(List<Mat_Uni_B_Local> data) =>
      json.encode(List<dynamic>.from(data.map((x) => x.toMap())));
}
