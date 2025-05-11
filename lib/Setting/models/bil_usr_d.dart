import 'dart:convert';

import '../../Setting/controllers/login_controller.dart';

class Bil_Usr_D_Local {
  String? SUID;
  var BUDDI;
  var BUDIN;
  String? BUDFD;
  String? BUDTD;
  int? BUDST;
  String? SUCH;
  String? BUDDO;
  String? BUDDE;
  int? JTID_L;
  int? BIID_L;
  int? SYID_L;
  String? CIID_L;
  String? GUID;
  String? DATEI;
  String? DEVI;
  String? DATEU;
  String? DEVU;
  String? SUID2;


  Bil_Usr_D_Local({this.SUID,this.BUDDI,this.BUDIN,this.BUDFD,this.SUCH,this.BUDDE,this.BUDDO,this.BUDST,this.BUDTD
    ,this.JTID_L,this.SYID_L,this.BIID_L,this.CIID_L, this.GUID,this.DATEI,this.DEVI,this.DATEU,this.DEVU});


  Map<String, dynamic> toMap() {
    var map = <String, dynamic>{
      'SUID': SUID,
      'BUDDI': BUDDI,
      'BUDIN': BUDIN,
      'BUDFD': BUDFD,
      'BUDTD': BUDTD,
      'BUDST': BUDST,
      'SUCH': SUCH,
      'BUDDO': BUDDO,
      'BUDDE': BUDDE,
      'GUID': GUID,
      'DATEI': DATEI,
      'DEVI': DEVI,
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

  Bil_Usr_D_Local.fromMap(Map<dynamic, dynamic> map) {
    SUID = map['SUID'];
    BUDDI = map['BUDDI'];
    BUDIN = map['BUDIN'];
    BUDFD = map['BUDFD'];
    BUDTD = map['BUDTD'];
    BUDST = map['BUDST'];
    SUCH = map['SUCH'];
    BUDDO = map['BUDDO'];
    BUDDE = map['BUDDE'];
    GUID = map['GUID'];
    DATEI = map['DATEI'];
    DEVI = map['DEVI'];
    DATEU = map['DATEU'];
    DEVU = map['DEVU'];
    SUID2 = map['SUID2'];
    JTID_L = map['JTID_L'];
    SYID_L = map['SYID_L'];
    BIID_L = map['BIID_L'];
    CIID_L = map['CIID_L'];
  }

  String Bil_Usr_D_toJson(List<Bil_Usr_D_Local> data) =>
      json.encode(List<dynamic>.from(data.map((x) => x.toMap())));
}
