import 'dart:convert';

import '../../Setting/controllers/login_controller.dart';

class Usr_Pri_Local {
  int? PRID;
  String? SUID ;
  int? UPIN ;
  int? UPCH;
  int? UPQR;
  int? UPDL;
  int? UPPR;
  int? JTID_L;
  int? BIID_L;
  int? SYID_L;
  String? CIID_L;
  String? GUID;
  String? DATEI;
  String? DEVI;
  String? SUCH;
  String? DATEU;
  String? DEVU;
  String? SUID2;

  Usr_Pri_Local({required this.PRID,required this.SUID,this.UPIN,this.UPCH,this.UPQR,this.UPDL,this.UPPR,
    this.JTID_L,this.SYID_L,this.BIID_L,this.CIID_L,this.GUID,this.DATEI,this.DEVI,this.SUCH,this.DATEU,this.DEVU});

  Map<String, dynamic> toMap() {
    var map = <String, dynamic>{
      'PRID': PRID,
      'SUID': SUID,
      'UPCH': UPCH,
      'UPIN': UPIN,
      'UPQR': UPQR,
      'UPDL': UPDL,
      'UPPR': UPPR,
      'GUID': GUID,
      'DATEI': DATEI,
      'DEVI': DEVI,
      'SUCH': SUCH,
      'DATEU': DATEU,
      'DEVU': DEVU,
      'SUID2': SUID2,
      'JTID_L': JTID_L ?? LoginController().JTID_L,
      'SYID_L': SYID_L ?? LoginController().SYID_L,
      'BIID_L': BIID_L ?? LoginController().BIID_L,
      'CIID_L': CIID_L ?? LoginController().CIID_L,
    };
    return map;
  }

  Usr_Pri_Local.fromMap(Map<dynamic, dynamic> map) {
    PRID = map['PRID'];
    SUID = map['SUID'];
    UPIN = map['UPIN'];
    UPCH = map['UPCH'];
    UPQR = map['UPQR'];
    UPDL = map['UPDL'];
    UPPR = map['UPPR'];
    GUID = map['GUID'];
    DATEI = map['DATEI'];
    DEVI = map['DEVI'];
    SUCH = map['SUCH'];
    DATEU = map['DATEU'];
    DEVU = map['DEVU'];
    SUID2 = map['SUID2'];
    JTID_L = map['JTID_L'];
    SYID_L = map['SYID_L'];
    BIID_L = map['BIID_L'];
    CIID_L = map['CIID_L'];
  }

  String Usr_PriToJson(List<Usr_Pri_Local> data) =>
      json.encode(List<dynamic>.from(data.map((x) => x.toMap())));
}
