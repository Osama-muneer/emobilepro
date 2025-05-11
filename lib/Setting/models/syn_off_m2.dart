import 'dart:convert';

import '../../Setting/controllers/login_controller.dart';

class Syn_Off_M2_Local {
  String? STMID;
  int? SOMID;
  int? SOMTY;
  String? GUID;
  String? STMIDL;
  int? SOMIDL;
  int? SOMTYL;
  String? GUIDL;
  String? SOMCN;
  String? SOMSN;
  String? SOMOI;
  String? SOMOUN;
  String? SOMON;
  String? SOMCS;
  String? SOMBT;
  String? SOMLD;
  String? SOMJT;
  String? SOMLA;
  String? SOMVN;
  int? SOMCST;
  String? SOMDI;
  String? SOMDE;
  String? SOMDC;
  String? SOMPK;
  String? SOMCSR;
  String? SOMBST;
  String? SOMSE;
  String? SOMER;
  String? SOMRI;
  String? SOMDM;
  int? SOMAC;
  String? SOMOTP;
  int? BIIDT;
  String? BIIDV;
  int? BIID;
  String? SUID;
  String? SUCH;
  String? DEVU;
  String? DEVI;
  String? DATEI;
  String? DATEU;
  int? ORDNU;
  int? DEFN;
  String? RES;
  int? JTID_L;
  int? BIID_L;
  int? SYID_L;
  String? CIID_L;
  Syn_Off_M2_Local({ this.STMID, this.SOMID,this.SOMTY,this.GUID,this.STMIDL,this.SOMIDL,
    this.JTID_L,this.SYID_L,this.BIID_L,this.CIID_L});

  Map<String, dynamic> toMap() {
    var map = <String, dynamic>{
      'STMID': STMID,
      'SOMID': SOMID,
      'SOMTY': SOMTY,
      'GUID': GUID,
      'STMIDL': STMIDL,
      'SOMIDL': SOMIDL,
      'SOMTYL': SOMTYL,
      'GUIDL': GUIDL,
      'SOMCN': SOMCN,
      'SOMSN': SOMSN,
      'SOMOI': SOMOI,
      'SOMOUN': SOMOUN,
      'SOMON': SOMON,
      'SOMCS': SOMCS,
      'SOMBT': SOMBT,
      'SOMLD': SOMLD,
      'SOMJT': SOMJT,
      'SOMLA': SOMLA,
      'SOMVN': SOMVN,
      'SOMCST': SOMCST,
      'SOMDI': SOMDI,
      'SOMDE': SOMDE,
      'SOMDC': SOMDC,
      'SOMPK': SOMPK,
      'SOMCSR': SOMCSR,
      'SOMBST': SOMBST,
      'SOMSE': SOMSE,
      'SOMER': SOMER,
      'SOMRI': SOMRI,
      'SOMDM': SOMDM,
      'SOMAC': SOMAC,
      'SOMOTP': SOMOTP,
      'BIIDT': BIIDT,
      'BIIDV': BIIDV,
      'BIID': BIID,
      'SUID': SUID,
      'DATEI': DATEI,
      'DEVI': DEVI,
      'SUCH': SUCH,
      'DATEU': DATEU,
      'DEVU': DEVU,
      'ORDNU': ORDNU,
      'DEFN': DEFN,
      'RES': RES,
      'JTID_L': JTID_L ?? LoginController().JTID_L,
      'SYID_L': SYID_L ?? LoginController().SYID_L,
      'BIID_L': BIID_L ?? LoginController().BIID_L,
      'CIID_L': CIID_L ?? LoginController().CIID_L,
    };
    return map;
  }

  Syn_Off_M2_Local.fromMap(Map<dynamic, dynamic> map) {
    STMID = map['STMID'];
    SOMID = map['SOMID'];
    SOMTY = map['SOMTY'];
    GUID = map['GUID'];
    STMIDL = map['STMIDL'];
    SOMIDL = map['SOMIDL'];
    SOMTYL = map['SOMTYL'];
    GUIDL = map['GUIDL'];
    SOMCN = map['SOMCN'];
    SOMSN = map['SOMSN'];
    SOMOI = map['SOMOI'];
    SOMOUN = map['SOMOUN'];
    SOMON = map['SOMON'];
    SOMCS = map['SOMCS'];
    SOMBT = map['SOMBT'];
    SOMLD = map['SOMLD'];
    SOMJT = map['SOMJT'];
    SOMLA = map['SOMLA'];
    SOMVN = map['SOMVN'];
    SOMCST = map['SOMCST'];
    SOMDI = map['SOMDI'];
    SOMDE = map['SOMDE'];
    SOMDC = map['SOMDC'];
    SOMPK = map['SOMPK'];
    SOMCSR = map['SOMCSR'];
    SOMBST = map['SOMBST'];
    SOMSE = map['SOMSE'];
    SOMER = map['SOMER'];
    SOMRI = map['SOMRI'];
    SOMDM = map['SOMDM'];
    SOMAC = map['SOMAC'];
    SOMOTP = map['SOMOTP'];
    BIIDT = map['BIIDT'];
    BIIDV = map['BIIDV'];
    BIID = map['BIID'];
    SUID = map['SUID'];
    DATEI = map['DATEI'];
    DEVI = map['DEVI'];
    SUCH = map['SUCH'];
    DATEU = map['DATEU'];
    DEVU = map['DEVU'];
    ORDNU = map['ORDNU'];
    DEFN = map['DEFN'];
    RES = map['RES'];
    JTID_L = map['JTID_L'];
    SYID_L = map['SYID_L'];
    BIID_L = map['BIID_L'];
    CIID_L = map['CIID_L'];
  }

}
