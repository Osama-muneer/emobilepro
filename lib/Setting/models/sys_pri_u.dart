import 'dart:convert';

class Sys_Pri_U_Local {
  int? SPMSQ;
  String? GUIDM;
  String? STMID;
  int? PRID;
  int? SUIDE;
  String? SUID2;
  String? SUID;
  String? SPST;
  String? SPIN;
  String? SPCH;
  String? SPQR;
  String? SPDL;
  String? SPPR;
  String? ANDROID_Y;
  String? IPHONE_Y;
  String? WEBSITE_Y;
  String? OFFLINE_Y;
  String? ONLINE_Y;
  String? UPLOAD_Y;
  String? DOWNLOAD_Y;
  String? UPDATE_Y;
  String? SPC1;
  String? SPC2;
  String? SPC3;
  String? SPC4;
  String? SPC5;
  String? SPC6;
  String? SUIDA;
  String? DATEI;
  String? SUCH;
  String? DATEU;
  String? GUID;


  Sys_Pri_U_Local({ this.SPMSQ, this.GUIDM, this.STMID,this.PRID,this.SUIDE, this.SUID2, this.SUID,
    this.SPST,this.SPIN, this.SPCH, this.SPQR,this.SPDL,this.SPPR, this.ANDROID_Y, this.IPHONE_Y,
    this.WEBSITE_Y,this.OFFLINE_Y, this.ONLINE_Y, this.UPLOAD_Y,this.DOWNLOAD_Y,this.UPDATE_Y,
    this.SPC1, this.SPC2, this.SPC3, this.SPC4, this.SPC5,this.SPC6,this.SUIDA, this.DATEI, this.SUCH
    , this.DATEU, this.GUID});

  Map<String, dynamic> toMap() {
    var map = <String, dynamic>{
      'SPMSQ': SPMSQ,
      'GUIDM': GUIDM,
      'STMID': STMID,
      'PRID': PRID,
      'SUIDE': SUIDE,
      'SUID2': SUID2,
      'SUID': SUID,
      'SPST': SPST,
      'SPIN': SPIN,
      'SPCH': SPCH,
      'SPQR': SPQR,
      'SPDL': SPDL,
      'SPPR': SPPR,
      'ANDROID_Y': ANDROID_Y,
      'IPHONE_Y': IPHONE_Y,
      'WEBSITE_Y': WEBSITE_Y,
      'OFFLINE_Y': OFFLINE_Y,
      'ONLINE_Y': ONLINE_Y,
      'UPLOAD_Y': UPLOAD_Y,
      'DOWNLOAD_Y': DOWNLOAD_Y,
      'UPDATE_Y': UPDATE_Y,
      'SPC1': SPC1,
      'SPC2': SPC2,
      'SPC3': SPC3,
      'SPC4': SPC4,
      'SPC5': SPC5,
      'SPC6': SPC6,
      'SUIDA': SUIDA,
      'DATEI': DATEI,
      'SUCH': SUCH,
      'DATEU': DATEU,
      'GUID': GUID,
    };
    return map;
  }

  Sys_Pri_U_Local.fromMap(Map<dynamic, dynamic> map) {
    SPMSQ = map['SPMSQ'];
    GUIDM = map['GUIDM'];
    STMID = map['STMID'];
    PRID = map['PRID'];
    SUIDE = map['SUIDE'];
    SUID2 = map['SUID2'];
    SUID = map['SUID'];
    SPST = map['SPST'];
    SPIN = map['SPIN'];
    SPCH = map['SPCH'];
    SPQR = map['SPQR'];
    SPDL = map['SPDL'];
    SPPR = map['SPPR'];
    ANDROID_Y = map['ANDROID_Y'];
    IPHONE_Y = map['IPHONE_Y'];
    WEBSITE_Y = map['WEBSITE_Y'];
    OFFLINE_Y = map['OFFLINE_Y'];
    ONLINE_Y = map['ONLINE_Y'];
    UPLOAD_Y = map['UPLOAD_Y'];
    DOWNLOAD_Y = map['DOWNLOAD_Y'];
    UPDATE_Y = map['UPDATE_Y'];
    SPC1 = map['SPC1'];
    SPC2 = map['SPC2'];
    SPC3 = map['SPC3'];
    SPC4 = map['SPC4'];
    SPC5 = map['SPC5'];
    SPC6 = map['SPC6'];
    SUIDA = map['SUIDA'];
    DATEI = map['DATEI'];
    SUCH = map['SUCH'];
    DATEU = map['DATEU'];
    GUID = map['GUID'];
  }

  String PrivlageToJson(List<Sys_Pri_U_Local> data) =>
      json.encode(List<dynamic>.from(data.map((x) => x.toMap())));
}
