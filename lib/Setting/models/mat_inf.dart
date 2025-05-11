import 'dart:typed_data';

import '../../Setting/controllers/login_controller.dart';

class Mat_Inf_Local {
  String? MGNO;
  var MINO;
  var MINA;
  String? MINE;
  String? MIN3;
  int? BIID;
  int? MUIDP;
  int? MUIDS;
  int? MUID;
  int? MIST;
  int? MIED;
  var MITP;
  var MITS;
  var MIMX;
  var MIMI;
  var MION;
  int? MISP;
  int? MIDI;
  int? MIGP;
  int? MIGS;
  int? MIDN;
  String? MIPN;
  String? MIPNC;
  String? MIIN;
  String? MIUS;
  String? MICO;
  String? MIPC;
  String? CWID;
  String? CWIDP;
  Uint8List? MIIM;
  String? MIDO;
  String? SUID;
  int? MITPK;
  int? MITSK;
  int? ORDNU;
  int? STMID;
  String? DATEI;
  String? DEVI;
  String? SUCH;
  String? DATEU;
  String? DEVU;
  String? RES;
  int? JTID_L;
  int? BIID_L;
  int? SYID_L;
  String? CIID_L;
  var MINA_D;
  var MUCBC;
  String? GUID;
  String? MGNA_D;
  String? MUCNA_D;
  int? MGKI;
  double? MPS1;
  double? MPS2;
  double? MPS3;
  double? MPS4;
  double? SNNO;
  String? SNED;
  double? MPCO;
  String? MUNA_D;

  Mat_Inf_Local({this.MGNO,this.MINO,required this.MINA, this.BIID, this.MUIDP, this.MUIDS,
    required this.MIST, this.MIED, this.MITP, this.MITS, this.MIMX, this.MIMI,this.GUID,
     this.MION, this.MISP, this.MIDI, this.MIGP,this.MINE,this.MIN3,this.MIGS,this.MIDN,this.MIPN,
    this.MIPNC,this.MIIN,this.MIUS,this.MICO,this.MIPC,this.CWID,this.CWIDP,this.MIIM,this.MIDO,
    this.SUID,this.MITPK,this.MITSK,this.ORDNU,this.STMID,this.DATEI,this.SUCH,this.DEVI,this.RES,
    this.DEVU,this.DATEU,this.JTID_L,this.SYID_L,this.BIID_L,this.CIID_L,this.MUCBC,this.MINA_D});



  Map<String, dynamic> toMap() {
    var map = <String, dynamic>{
      'MGNO': MGNO,
      'MINO': MINO,
      'MINA': MINA,
      'MINE': MINE,
      'MIN3': MIN3,
      'BIID': BIID,
      'MUIDP': MUIDP,
      'MUIDS': MUIDS,
      'MIST': MIST,
      'MIED': MIED,
      'MITP': MITP,
      'MITS': MITS,
      'MIMX': MIMX,
      'MIMI': MIMI,
      'MION': MION,
      'MISP': MISP,
      'MIDI': MIDI,
      'MIGP': MIGP,
      'MIGS': MIGS,
      'MIDN': MIDN,
      'MIPN': MIPN,
      'MIPNC': MIPNC,
      'MIIN': MIIN,
      'MIUS': MIUS,
      'MICO': MICO,
      'MIPC': MIPC,
      'CWID': CWID,
      'CWIDP': CWIDP,
      'MIIM': MIIM,
      'MIDO': MIDO,
      'SUID': SUID,
      'MITPK': MITPK,
      'MITSK': MITSK,
      'ORDNU': ORDNU,
      'STMID': STMID,
      'DATEI': DATEI,
      'DEVI': DEVI,
      'SUCH': SUCH,
      'DATEU': DATEU,
      'DEVU': DEVU,
      'RES': RES,
      'GUID': GUID,
      'JTID_L': JTID_L ?? LoginController().JTID_L,
      'SYID_L': SYID_L ?? LoginController().SYID_L,
      'BIID_L': BIID_L ?? LoginController().BIID_L,
      'CIID_L': CIID_L ?? LoginController().CIID_L,
    };
    return map;
  }

  Mat_Inf_Local.fromMap(Map<dynamic, dynamic> map) {
    MGNO = map['MGNO'];
    MINO = map['MINO'];
    MINA = map['MINA'];
    MINE = map['MINE'];
    MIN3 = map['MIN3'];
    BIID = map['BIID'];
    MUIDP = map['MUIDP'];
    MUIDS = map['MUIDS'];
    MIST = map['MIST'];
    MIED = map['MIED'];
    MITP = map['MITP'];
    MITS = map['MITS'];
    MIMX = map['MIMX'];
    MIMI = map['MIMI'];
    MION = map['MION'];
    MISP = map['MISP'];
    MIDI = map['MIDI'];
    MIGP = map['MIGP'];
    MIGS = map['MIGS'];
    MIDN = map['MIDN'];
    MIPN = map['MIPN'];
    MIPNC = map['MIPNC'];
    MIIN = map['MIIN'];
    MIUS = map['MIUS'];
    MICO = map['MICO'];
    MIPC = map['MIPC'];
    CWID = map['CWID'];
    CWIDP = map['CWIDP'];
    MIIM = map['MIIM'];
    MIDO = map['MIDO'];
    SUID = map['SUID'];
    MITPK = map['MITPK'];
    MITSK = map['MITSK'];
    ORDNU = map['ORDNU'];
    STMID = map['STMID'];
    DATEI = map['DATEI'];
    DEVI = map['DEVI'];
    SUCH = map['SUCH'];
    DATEU = map['DATEU'];
    DEVU = map['DEVU'];
    RES = map['RES'];
    GUID = map['GUID'];
    JTID_L = map['JTID_L'];
    SYID_L = map['SYID_L'];
    BIID_L = map['BIID_L'];
    CIID_L = map['CIID_L'];
    MUCBC = map['MUCBC'];
    MINA_D = map['MINA_D'];
    MGKI = map['MGKI'];
    MGNA_D = map['MGNA_D'];
    MPS1 = map['MPS1'];
    MPS2 = map['MPS2'];
    MPS3 = map['MPS3'];
    MPS4 = map['MPS4'];
    MUCNA_D = map['MUCNA_D'];
    MUID = map['MUID'];
    SNNO = map['SNNO'];
    SNED = map['SNED'];
    MPCO = map['MPCO'];
    MUNA_D = map['MUNA_D'];
  }
}
