import 'dart:convert';

import '../../Setting/controllers/login_controller.dart';

class Sys_Own_Local {
  int? SOID;
  String? SONA;
  var SONE;
  String? SORN;
  String? SOLN;
  String? CWID;
  String? CTID;
  String? SOAD;
  String? SOTL;
  String? SOFX;
  String? SOBX;
  String? SOEM;
  String? SOWE;
  String? SOIN;
  String? SOHN;
  String? SOSI;
  String? SODO;
  String? SUID;
  int? SOST;
  int? BIID;
  String? SOTX;
  String? SOQN;
  String? SOQND;
  String? SOSN;
  String? SOSND;
  String? SOBN;
  String? SOBND;
  String? SOON;
  String? SOPC;
  String? SOAD2;
  String? SOSA;
  String? SOSW;
  String? SOSWD;
  String? SOAB;
  String? SOABD;
  String? SOAB2;
  String? SOAB2D;
  String? SOTXG;
  String? SOTX2;
  String? SOTX2G;
  String? SOC1;
  String? SOC2;
  String? SOC3;
  String? SOC4;
  String? SOC5;
  String? SOC6;
  String? SOC7;
  String? SOC8;
  String? SOC9;
  String? SOC10;
  int? BAID;
  String? SUCH;
  String? DATEU;
  String? DEVU;
  int? JTID_L;
  int? BIID_L;
  int? SYID_L;
  String? CIID_L;
  String? GUID;
  String? DATEI;
  String? DEVI;
  String? CWNA_D;
  String? CTNA_D;
  String? BAID_D;
  String? CWWC2;
  String? ITSY;
  String? ILDE;

  Sys_Own_Local({required this.SOID,required this.SONA,this.SONE,this.SORN,this.SOLN,this.CWID,
    this.CTID,this.SOAD,this.SOTL,this.SOFX,this.SOBX,this.SOEM,this.SOWE,this.SOIN,this.SOHN,
    this.SOSI,this.SODO,this.SUID,this.SOST,this.BIID,this.SOTX,this.SOQN,this.SOQND,this.SOSN,
    this.SOSND,this.SOBN,this.SOBND,this.SOON,this.SOPC,this.SOAD2,this.SOSA,this.SOSW,
    this.SOSWD ,this.SOAB,this.SOABD,this.SOAB2,this.SOAB2D,this.SOTXG,this.SOTX2,this.SOTX2G,
    this.SOC1,this.SOC2,this.SOC3,this.SOC4,this.SOC5,this.SOC6,this.SOC7,
    this.SOC8,this.SOC9,this.SOC10,this.BAID,this.SUCH,this.DATEU,this.DEVU,this.JTID_L,this.SYID_L,this.BIID_L,
    this.CIID_L, this.GUID,this.DATEI,this.DEVI});

  Map<String, dynamic> toMap() {
    var map = <String, dynamic>{
      'SOID': SOID,
      'SONA': SONA,
      'SONE': SONE,
      'SORN': SORN,
      'SOLN': SOLN,
      'CWID': CWID,
      'CTID': CTID,
      'SOAD': SOAD,
      'SOTL': SOTL,
      'SOFX': SOFX,
      'SOBX': SOBX,
      'SOEM': SOEM,
      'SOWE': SOWE,
      'SOIN': SOIN,
      'SOHN': SOHN,
      'SOSI': SOSI,
      'SODO': SODO,
      'SUID': SUID,
      'SOST': SOST,
      'BIID': BIID,
      'SOTX': SOTX,
      'SOQND': SOQND,
      'SOQN': SOQN,
      'SOSN': SOSN,
      'SOSND': SOSND,
      'SOBN': SOBN,
      'SOBND': SOBND,
      'SOON': SOON,
      'SOPC': SOPC,
      'SOAD2': SOAD2,
      'SOSA': SOSA,
      'SOSW': SOSW,
      'SOSWD': SOSWD,
      'SOAB': SOAB,
      'SOABD': SOABD,
      'SOAB2': SOAB2,
      'SOAB2D': SOAB2D,
      'SOTXG': SOTXG,
      'SOTX2': SOTX2,
      'SOC1': SOC1,
      'SOC2': SOC2,
      'SOC3': SOC3,
      'SOC4': SOC4,
      'SOC5': SOC5,
      'SOC6': SOC6,
      'SOC7': SOC7,
      'SOC8': SOC8,
      'SOC9': SOC9,
      'SOC10': SOC10,
      'BAID': BAID,
      'GUID': GUID,
      'DATEI': DATEI,
      'DEVI': DEVI,
      'JTID_L': JTID_L ?? LoginController().JTID_L,
      'SYID_L': SYID_L ?? LoginController().SYID_L,
      'BIID_L': BIID_L ?? LoginController().BIID_L,
      'CIID_L': CIID_L ?? LoginController().CIID_L,
    };
    return map;
  }

  Sys_Own_Local.fromMap(Map<dynamic, dynamic> map) {
    SOID = map['SOID'];
    SONA = map['SONA'];
    SONE = map['SONE'];
    SORN = map['SORN'];
    SOLN = map['SOLN'];
    CWID = map['CWID'];
    CTID = map['CTID'];
    SOAD = map['SOAD'];
    SOTL = map['SOTL'];
    SOFX = map['SOFX'];
    SOBX = map['SOBX'];
    SOEM = map['SOEM'];
    SOWE = map['SOWE'];
    SOIN = map['SOIN'];
    SOHN = map['SOHN'];
    SOSI = map['SOSI'];
    SODO = map['SODO'];
    SUID = map['SUID'];
    SOST = map['SOST'];
    BIID = map['BIID'];
    SOTX = map['SOTX'];
    SOQN = map['SOQN'];
    SOQND = map['SOQND'];
    SOSN = map['SOSN'];
    SOSND = map['SOSND'];
    SOBN = map['SOBN'];
    SOBND = map['SOBND'];
    SOON = map['SOON'];
    SOPC = map['SOPC'];
    SOAD2 = map['SOAD2'];
    SOSA = map['SOSA'];
    SOSW = map['SOSW'];
    SOSWD = map['SOSWD'];
    SOAB = map['SOAB'];
    SOABD = map['SOABD'];
    SOAB2 = map['SOAB2'];
    SOAB2D = map['SOAB2D'];
    SOTXG = map['SOTXG'];
    SOTX2 = map['SOTX2'];
    SOTX2G = map['SOTX2G'];
    SOC1 = map['SOC1'];
    SOC2 = map['SOC2'];
    SOC3 = map['SOC3'];
    SOC4 = map['SOC4'];
    SOC5 = map['SOC5'];
    SOC6 = map['SOC6'];
    SOC7 = map['SOC7'];
    SOC8 = map['SOC8'];
    SOC9 = map['SOC9'];
    SOC10 = map['SOC10'];
    BAID = map['BAID'];
    SUCH = map['SUCH'];
    DATEU = map['DATEU'];
    DEVU = map['DEVU'];
    GUID = map['GUID'];
    DATEI = map['DATEI'];
    DEVI = map['DEVI'];
    JTID_L = map['JTID_L'];
    SYID_L = map['SYID_L'];
    BIID_L = map['BIID_L'];
    CIID_L = map['CIID_L'];
    CWNA_D = map['CWNA_D'];
    CTNA_D = map['CTNA_D'];
    CWWC2 = map['CWWC2'];
    BAID_D = map['BAID_D'];
    ITSY = map['ITSY'];
    ILDE = map['ILDE'];
  }

  String Sys_OwnToJson(List<Sys_Own_Local> data) =>
      json.encode(List<dynamic>.from(data.map((x) => x.toMap())));
}
