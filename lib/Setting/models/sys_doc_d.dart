import 'dart:convert';

import '../../Setting/controllers/login_controller.dart';

class Sys_Doc_D_Local {
  String? STID;
  int? SDID;
  int? BIID;
  String? SDDDA;
  String? SDDDE;
  String? SDDD3;
  int? SDDST1;
  String? SDDSA;
  String? SDDSE;
  String? SDDS3;
  int? SDDST2;
  String? SUCH;
  String? DATEU;
  String? DEVU;
  int? JTID_L;
  int? BIID_L;
  int? SYID_L;
  String? CIID_L;
  String? SDDSA_D;
  String? SDDDA_D;
  String? GUID;
  String? DATEI;
  String? DEVI;
  String? SUID;

  Sys_Doc_D_Local({required this.STID,required this.SDID,this.SDDDA,this.SDDDE,this.SDDD3,this.SDDST1,
    this.SDDSA,this.SDDSE,this.SDDS3,this.SDDST2,this.SUCH,this.DATEU,this.DEVU,this.BIID,this.JTID_L,
    this.SYID_L,this.BIID_L,this.CIID_L,this.SDDSA_D,this.GUID,this.DATEI,this.DEVI,this.SUID});

  Map<String, dynamic> toMap() {
    var map = <String, dynamic>{
      'STID': STID,
      'SDID': SDID,
      'SDDDA': SDDDA,
      'SDDDE': SDDDE,
      'SDDD3': SDDD3,
      'SDDST1': SDDST1,
      'SDDSA': SDDSA,
      'SDDSE': SDDSE,
      'SDDS3': SDDS3,
      'SDDST2': SDDST2,
      'SUCH': SUCH,
      'DATEU': DATEU,
      'DEVU': DEVU,
      'BIID': BIID,
      'GUID': GUID,
      'DATEI': DATEI,
      'DEVI': DEVI,
      'SUID': SUID,
      'JTID_L': JTID_L ?? LoginController().JTID_L,
      'SYID_L': SYID_L ?? LoginController().SYID_L,
      'BIID_L': BIID_L ?? LoginController().BIID_L,
      'CIID_L': CIID_L ?? LoginController().CIID_L,
    };
    return map;
  }

  Sys_Doc_D_Local.fromMap(Map<dynamic, dynamic> map) {
    STID = map['STID'];
    SDID = map['SDID'];
    SDDDA = map['SDDDA'];
    SDDDE = map['SDDDE'];
    SDDD3 = map['SDDD3'];
    SDDST1 = map['SDDST1'];
    SDDSA = map['SDDSA'];
    SDDSE = map['SDDSE'];
    SDDS3 = map['SDDS3'];
    SDDST2 = map['SDDST2'];
    SUCH = map['SUCH'];
    DATEU = map['DATEU'];
    DEVU = map['DEVU'];
    BIID = map['BIID'];
    GUID = map['GUID'];
    DATEI = map['DATEI'];
    DEVI = map['DEVI'];
    SUID = map['SUID'];
    JTID_L = map['JTID_L'];
    SYID_L = map['SYID_L'];
    BIID_L = map['BIID_L'];
    CIID_L = map['CIID_L'];
    SDDSA_D = map['SDDSA_D'];
    SDDDA_D = map['SDDDA_D'];
  }

  String Sys_DocToJson(List<Sys_Doc_D_Local> data) =>
      json.encode(List<dynamic>.from(data.map((x) => x.toMap())));
}
