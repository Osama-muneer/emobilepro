import 'dart:convert';

import '../../Setting/controllers/login_controller.dart';

class Sys_Scr_Local {
  int? SSID;
  String? SSNA;
  String? SSNE;
  String? SSDA;
  String? SSDE;
  String? SSDAS;
  String? SSDES;
  String? SSD3;
  String? SSD3S;
  int? STMID;
  String? SUCH;
  String? DATEU;
  String? DEVU;
  int? JTID_L;
  int? BIID_L;
  int? SYID_L;
  int? SSST2;
  String? CIID_L;
  String? SSIM;
  String? SSIMS;
  String? SSIC;
  String? SSICS;
  String? GUID;
  String? DATEI;
  String? DEVI;
  String? SUID;
  String? SSNA_D;
  String? SSDA_D;

  Sys_Scr_Local({required this.SSID,required this.SSNA,this.SSNE,this.SSDA,this.SSDAS,
    this.SSDES,this.SSD3,this.SSD3S,this.STMID,this.SUCH,this.DATEU,this.DEVU,this.SSDE,
  this.JTID_L,this.SYID_L,this.BIID_L,this.CIID_L,this.SSIM,this.SSIMS,this.SSIC,this.SSICS,
    this.GUID,this.DATEI,this.DEVI,this.SUID});

  Map<String, dynamic> toMap() {
    var map = <String, dynamic>{
      'SSID': SSID,
      'SSNA': SSNA,
      'SSNE': SSNE,
      'SSDA': SSDA,
      'SSDE': SSDE,
      'SSDAS': SSDAS,
      'SSDES': SSDES,
      'SSD3': SSD3,
      'SSD3S': SSD3S,
      'STMID': STMID,
      'SUCH': SUCH,
      'DATEU': DATEU,
      'DEVU': DEVU,
      'JTID_L': JTID_L ?? LoginController().JTID_L,
      'SYID_L': SYID_L ?? LoginController().SYID_L,
      'BIID_L': BIID_L ?? LoginController().BIID_L,
      'CIID_L': CIID_L ?? LoginController().CIID_L,
      'SSIM': SSIM,
      'SSIMS': SSIMS,
      'SSIC': SSIC,
      'SSICS': SSICS,
      'GUID': GUID,
      'DATEI': DATEI,
      'DEVI': DEVI,
      'SUID': SUID,
    };
    return map;
  }

  Sys_Scr_Local.fromMap(Map<dynamic, dynamic> map) {
    SSID = map['SSID'];
    SSNA = map['SSNA'];
    SSNE = map['SSNE'];
    SSDA = map['SSDA'];
    SSDE = map['SSDE'];
    SSDAS = map['SSDAS'];
    SSDES = map['SSDES'];
    SSD3 = map['SSD3'];
    SSD3S = map['SSD3S'];
    STMID = map['STMID'];
    SUCH = map['SUCH'];
    DATEU = map['DATEU'];
    DEVU = map['DEVU'];
    SSST2 = map['SSST2'];
    JTID_L = map['JTID_L'];
    SYID_L = map['SYID_L'];
    BIID_L = map['BIID_L'];
    CIID_L = map['CIID_L'];
    SSIM = map['SSIM'];
    SSIMS = map['SSIMS'];
    SSIC = map['SSIC'];
    SSICS = map['SSICS'];
    GUID = map['GUID'];
    DATEI = map['DATEI'];
    DEVI = map['DEVI'];
    SUID = map['SUID'];
    SSNA_D = map['SSNA_D'];
    SSDA_D = map['SSDA_D'];
  }

  String Sys_ScrToJson(List<Sys_Scr_Local> data) =>
      json.encode(List<dynamic>.from(data.map((x) => x.toMap())));
}
