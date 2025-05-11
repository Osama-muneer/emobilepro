import 'dart:convert';

import '../../Setting/controllers/login_controller.dart';

class Bra_Yea_Local {
  int? JTID;
  int? BIID;
  int? SYID;
  int? BYST;
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

  Bra_Yea_Local({required this.JTID,required this.BIID,required this.SYID,this.BYST,this.JTID_L,this.SYID_L,this.BIID_L,this.CIID_L,
                 this.GUID,this.DATEI,this.DEVI,this.SUCH,this.DATEU,this.DEVU,this.SUID});

  Map<String, dynamic> toMap() {
    var map = <String, dynamic>{
      'JTID': JTID,
      'BIID': BIID,
      'SYID': SYID,
      'BYST': BYST,
      'JTID_L': JTID_L ?? LoginController().JTID_L,
      'SYID_L': SYID_L ?? LoginController().SYID_L,
      'BIID_L': BIID_L ?? LoginController().BIID_L,
      'CIID_L': CIID_L ?? LoginController().CIID_L,
      'GUID': GUID,
      'DATEI': DATEI,
      'DEVI': DEVI,
      'SUCH': SUCH,
      'DATEU': DATEU,
      'DEVU': DEVU,
      'SUID': SUID,
    };
    return map;
  }

  Bra_Yea_Local.fromMap(Map<dynamic, dynamic> map) {
    JTID = map['JTID'];
    BIID = map['BIID'];
    SYID = map['SYID'];
    BYST = map['BYST'];
    JTID_L = map['JTID_L'];
    SYID_L = map['SYID_L'];
    BIID_L = map['BIID_L'];
    CIID_L = map['CIID_L'];
    GUID = map['GUID'];
    DATEI = map['DATEI'];
    DEVI = map['DEVI'];
    SUCH = map['SUCH'];
    DATEU = map['DATEU'];
    DEVU = map['DEVU'];
    SUID = map['SUID'];
  }

  String Bra_YeaToJson(List<Bra_Yea_Local> data) =>
      json.encode(List<dynamic>.from(data.map((x) => x.toMap())));
}
