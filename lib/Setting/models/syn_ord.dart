import 'dart:convert';

import '../../Setting/controllers/login_controller.dart';

class SYN_ORD_Local {
  String? SOET;
  int? ROW_NUM;
  String? SOLD;
  int? SOOR;
  int? SOST;
  String? SOPK;
  int? JTID_L;
  int? BIID_L;
  int? SYID_L;
  String? CIID_L;
  SYN_ORD_Local({ this.SOET, this.ROW_NUM,this.SOLD,this.SOOR,this.SOST,this.SOPK,this.JTID_L,this.SYID_L,this.BIID_L,this.CIID_L});

  Map<String, dynamic> toMap() {
    var map = <String, dynamic>{
      'SOET': SOET,
      'ROW_NUM': ROW_NUM,
      'SOLD': SOLD,
      'SOOR': SOOR,
      'SOST': SOST,
      'SOPK': SOPK,
      'JTID_L': JTID_L ?? LoginController().JTID_L,
      'SYID_L': SYID_L ?? LoginController().SYID_L,
      'BIID_L': BIID_L ?? LoginController().BIID_L,
      'CIID_L': CIID_L ?? LoginController().CIID_L,
    };
    return map;
  }

  SYN_ORD_Local.fromMap(Map<dynamic, dynamic> map) {
    SOET = map['SOET'];
    ROW_NUM = map['ROW_NUM'];
    SOLD = map['SOLD'];
    SOOR = map['SOOR'];
    SOST = map['SOST'];
    SOPK = map['SOPK'];
    JTID_L = map['JTID_L'];
    SYID_L = map['SYID_L'];
    BIID_L = map['BIID_L'];
    CIID_L = map['CIID_L'];
  }

  String SYN_ORDToJson(List<SYN_ORD_Local> data) =>
      json.encode(List<dynamic>.from(data.map((x) => x.toMap())));
}
