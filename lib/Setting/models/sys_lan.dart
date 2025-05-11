import 'dart:convert';

import '../../Setting/controllers/login_controller.dart';

class Sys_Lan_Local {
  int? SLID;
  int? SLTY;
  String? SLIT;
  String? SLSC;
  String? SLN1;
  String? SLN2;
  String? SLN3;
  int? SLST;
  String? SLN1S;
  String? SLN2S;
  String? SLN3S;
  String? SLDO;
  String? SUID;
  int? SLCH;
  String? SLTB;
  String? SLIN;
  String? STID;
  String? DATEI;
  String? DEVI;
  String? SUCH;
  String? DATEU;
  String? DEVU;
  int? JTID_L;
  int? BIID_L;
  int? SYID_L;
  String? CIID_L;
  String? GUID;
  String? SLN_D;

  Sys_Lan_Local({required this.SLID,required this.SLTY,this.SLIT,this.SLSC,this.SLN1,
    this.SLN2,this.SLN3,this.SLST,this.SLN1S,this.SLN2S,this.SLN3S,this.SLDO
    ,this.SUID,this.SLCH,this.SLTB,this.SLIN,this.STID,this.DATEI,this.DEVI,this.SUCH
  ,this.DATEU,this.DEVU,this.JTID_L,this.SYID_L,this.BIID_L, this.CIID_L, this.GUID});

  Map<String, dynamic> toMap() {
    var map = <String, dynamic>{
      'SLID': SLID,
      'SLTY': SLTY,
      'SLIT': SLIT,
      'SLSC': SLSC,
      'SLN1': SLN1,
      'SLN2': SLN2,
      'SLN3': SLN3,
      'SLST': SLST,
      'SLN1S': SLN1S,
      'SLN2S': SLN2S,
      'SLN3S': SLN3S,
      'SLDO': SLDO,
      'SUID': SUID,
      'SLCH': SLCH,
      'SLTB': SLTB,
      'SLIN': SLIN,
      'STID': STID,
      'DATEI': DATEI,
      'DEVI': DEVI,
      'SUCH': SUCH,
      'DATEU': DATEU,
      'DEVU': DEVU,
      'GUID': GUID,
      'JTID_L': JTID_L ?? LoginController().JTID_L,
      'SYID_L': SYID_L ?? LoginController().SYID_L,
      'BIID_L': BIID_L ?? LoginController().BIID_L,
      'CIID_L': CIID_L ?? LoginController().CIID_L,
    };
    return map;
  }

  Sys_Lan_Local.fromMap(Map<dynamic, dynamic> map) {
    SLID = map['SLID'];
    SLTY = map['SLTY'];
    SLIT = map['SLIT'];
    SLSC = map['SLSC'];
    SLN1 = map['SLN1'];
    SLN2 = map['SLN2'];
    SLN3 = map['SLN3'];
    SLST = map['SLST'];
    SLN1S = map['SLN1S'];
    SLN2S = map['SLN2S'];
    SLN3S = map['SLN3S'];
    SLDO = map['SLDO'];
    SUID = map['SUID'];
    SLCH = map['SLCH'];
    SLTB = map['SLTB'];
    SLIN = map['SLIN'];
    STID = map['STID'];
    DATEI = map['DATEI'];
    DEVI = map['DEVI'];
    SUCH = map['SUCH'];
    DATEU = map['DATEU'];
    DEVU = map['DEVU'];
    GUID = map['GUID'];
    JTID_L = map['JTID_L'];
    SYID_L = map['SYID_L'];
    BIID_L = map['BIID_L'];
    CIID_L = map['CIID_L'];
    SLN_D = map['SLN_D'];
  }

  String Sys_LanToJson(List<Sys_Lan_Local> data) =>
      json.encode(List<dynamic>.from(data.map((x) => x.toMap())));
}
