import 'dart:convert';

import '../../Setting/controllers/login_controller.dart';

class Con_Acc_M_Local {
  String? STMID;
  int? CAMTY;
  int? SOMID;
  String? SOMSN;
  String? CAMUS;
  int? CAMST;
  int? JTID;
  int? BIID;
  int? SYID;
  int? CIID;
  int? ORDNU;
  String? RES;
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

  Con_Acc_M_Local({ this.STMID, this.CAMTY, this.SOMID,this.SOMSN,this.CAMUS,this.CAMST,this.JTID_L,this.SYID_L,this.BIID_L,this.CIID_L,
    this.ORDNU,this.GUID,this.DATEI,this.DEVI,this.SUCH,this.DATEU,this.DEVU,this.SUID});

  Map<String, dynamic> toMap() {
    var map = <String, dynamic>{
      'STMID': STMID,
      'CAMTY': CAMTY,
      'SOMID': SOMID,
      'SOMSN': SOMSN,
      'CAMUS': CAMUS,
      'CAMST': CAMST,
      'JTID': JTID,
      'SYID': SYID,
      'BIID': BIID,
      'CIID': CIID,
      'ORDNU': ORDNU,
      'RES': RES,
      'SUID': SUID,
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

  Con_Acc_M_Local.fromMap(Map<dynamic, dynamic> map) {
    STMID = map['STMID'];
    CAMTY = map['CAMTY'];
    SOMID = map['SOMID'];
    SOMSN = map['SOMSN'];
    CAMUS = map['CAMUS'];
    CAMST = map['CAMST'];
    JTID = map['JTID'];
    SYID = map['SYID'];
    BIID = map['BIID'];
    CIID = map['CIID'];
    ORDNU = map['ORDNU'];
    RES = map['RES'];
    SUID = map['SUID'];
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
  }

}
