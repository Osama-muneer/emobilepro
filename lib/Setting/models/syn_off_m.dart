import 'dart:convert';

import '../../Setting/controllers/login_controller.dart';

class Syn_Off_M_Local {
  String? STMID;
  int? SOMID;
  int? SOMTY;
  int? SOMST;
  String? SOMNA;
  String? SOMSN;
  String? SOMDE;
  String? SOMIP;
  int? SOMWN;
  String? SOMDB;
  String? SOMHO;
  int? SOMAP;
  String? SOMDO;
  String? SOMIN;
  String? SOMDA;
  String? SUID;
  String? SOMJD;
  String? SOMJN;
  int? SOMMN;
  int? SOMAC;
  int? BIID;
  String? CIID;
  int? JTID;
  String? SUCH;
  int? SOMUP;
  String? SOMUPD;
  int? SOMDL;
  String? SOMDLD;
  int? SYID;
  String? DATEI;
  String? DEVI;
  String? DATEU;
  String? DEVU;
  String? RES;
  String? GUID;
  int? SOMMOS;
  int? SOMRDS;
  int? JTID_L;
  int? BIID_L;
  int? SYID_L;
  String? CIID_L;
  Syn_Off_M_Local({ this.STMID, this.SOMID,this.SOMTY,this.GUID,
    this.JTID_L,this.SYID_L,this.BIID_L,this.CIID_L});

  Map<String, dynamic> toMap() {
    var map = <String, dynamic>{
      'STMID': STMID,
      'SOMID': SOMID,
      'SOMTY': SOMTY,
      'SOMST': SOMST,
      'SOMNA': SOMNA,
      'SOMSN': SOMSN,
      'SOMDE': SOMDE,
      'SOMIP': SOMIP,
      'SOMWN': SOMWN,
      'SOMDB': SOMDB,
      'SOMHO': SOMHO,
      'SOMAP': SOMAP,
      'SOMDO': SOMDO,
      'SOMIN': SOMIN,
      'SOMDA': SOMDA,
      'SUID': SUID,
      'SOMJD': SOMJD,
      'SOMJN': SOMJN,
      'SOMMN': SOMMN,
      'SOMAC': SOMAC,
      'BIID': BIID,
      'CIID': CIID,
      'JTID': JTID,
      'SUCH': SUCH,
      'SOMUP': SOMUP,
      'SOMUPD': SOMUPD,
      'SOMDL': SOMDL,
      'SOMDLD': SOMDLD,
      'SYID': SYID,
      'GUID': GUID,
      'SOMMOS': SOMMOS,
      'SOMRDS': SOMRDS,
      'DATEI': DATEI,
      'DEVI': DEVI,
      'DATEU': DATEU,
      'DEVU': DEVU,
      'RES': RES,
      'JTID_L': JTID_L ?? LoginController().JTID_L,
      'SYID_L': SYID_L ?? LoginController().SYID_L,
      'BIID_L': BIID_L ?? LoginController().BIID_L,
      'CIID_L': CIID_L ?? LoginController().CIID_L,
    };
    return map;
  }

  Syn_Off_M_Local.fromMap(Map<dynamic, dynamic> map) {
    STMID = map['STMID'];
    SOMID = map['SOMID'];
    SOMTY = map['SOMTY'];
    SOMST = map['SOMST'];
    SOMNA = map['SOMNA'];
    SOMIP = map['SOMIP'];
    SOMWN = map['SOMWN'];
    SOMDB = map['SOMDB'];
    SOMHO = map['SOMHO'];
    SOMAP = map['SOMAP'];
    SOMDO = map['SOMDO'];
    SOMIN = map['SOMIN'];
    SOMDA = map['SOMDA'];
    SUID = map['SUID'];
    SOMJD = map['SOMJD'];
    SOMJN = map['SOMJN'];
    SOMMN = map['SOMMN'];
    SOMAC = map['SOMAC'];
    BIID = map['BIID'];
    CIID = map['CIID'];
    JTID = map['JTID'];
    SUCH = map['SUCH'];
    SOMUP = map['SOMUP'];
    SOMUPD = map['SOMUPD'];
    SOMDL = map['SOMDL'];
    SOMDLD = map['SOMDLD'];
    SYID = map['SYID'];
    GUID = map['GUID'];
    SOMMOS = map['SOMMOS'];
    SOMRDS = map['SOMRDS'];
    SOMSN = map['SOMSN'];
    SOMDE = map['SOMDE'];
    DATEI = map['DATEI'];
    DEVI = map['DEVI'];
    DATEU = map['DATEU'];
    DEVU = map['DEVU'];
    RES = map['RES'];
    JTID_L = map['JTID_L'];
    SYID_L = map['SYID_L'];
    BIID_L = map['BIID_L'];
    CIID_L = map['CIID_L'];
  }

}
