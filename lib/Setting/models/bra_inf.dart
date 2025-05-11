import 'dart:convert';

import '../../Setting/controllers/login_controller.dart';
Bra_Inf_Local articleFromJson(String str) => Bra_Inf_Local.fromMap(json.decode(str));
class Bra_Inf_Local {
  int? JTID;
  int? BIID;
  String? BINA;
  String? BINE;
  String? BIDO;
  int? BIST;
  String? CWID;
  String? CTID;
  String? BIAD;
  String? BITL;
  String? BIMO;
  String? BIFX;
  String? BIBX;
  String? BIEM;
  String? BIWE;
  String? BINO;
  String? BIIN;
  String? SUID;
  int? JTID_L;
  int? BIID_L;
  int? SYID_L;
  String? CIID_L;
  String? BINA_D;
  String? GUID;
  String? DATEI;
  String? DEVI;
  String? SUCH;
  String? DATEU;
  String? DEVU;

  Bra_Inf_Local({this.JTID,this.BIID,required this.BINA, this.BINE,required this.BIST,this.BIDO,
    this.CWID,this.CTID,this.BIAD,this.BITL,this.BIMO,this.BIFX,this.BIBX,this.BIEM,this.BIWE
  ,this.BINO,this.BIIN,this.SUID,this.JTID_L,this.SYID_L,this.BIID_L,this.CIID_L,this.BINA_D,
    this.GUID,this.DATEI,this.DEVI,this.SUCH,this.DATEU,this.DEVU});


  Map<String, dynamic> toMap() {
    var map = <String, dynamic>{
      'JTID': JTID,
      'BIID': BIID,
      'BINA': BINA,
      'BINE': BINE,
      'BIDO': BIDO,
      'BIST': BIST,
      'CWID': CWID,
      'CTID': CTID,
      'BIAD': BIAD,
      'BITL': BITL,
      'BIMO': BIMO,
      'BIFX': BIFX,
      'BIBX': BIBX,
      'BIEM': BIEM,
      'BIWE': BIWE,
      'BINO': BINO,
      'BIIN': BIIN,
      'SUID': SUID,
      'GUID': GUID,
      'DATEI': DATEI,
      'DEVI': DEVI,
      'SUCH': SUCH,
      'DATEU': DATEU,
      'DEVU': DEVU,
      'JTID_L': JTID_L ?? LoginController().JTID_L,
      'SYID_L': SYID_L ?? LoginController().SYID_L,
      'BIID_L': BIID_L ?? LoginController().BIID_L,
      'CIID_L': CIID_L ?? LoginController().CIID_L,
    };
    return map;
  }

  Bra_Inf_Local.fromMap(Map<dynamic, dynamic> map) {
    JTID = map['JTID'];
    BIID = map['BIID'];
    BINA = map['BINA'];
    BINE = map['BINE'];
    BIDO = map['BIDO'];
    BIST = map['BIST'];
    CWID = map['CWID'];
    CTID = map['CTID'];
    BIAD = map['BIAD'];
    BITL = map['BITL'];
    BIMO = map['BIMO'];
    BIFX = map['BIFX'];
    BIBX = map['BIBX'];
    BIEM = map['BIEM'];
    BIWE = map['BIWE'];
    BINO = map['BINO'];
    BIIN = map['BIIN'];
    SUID = map['SUID'];
    GUID = map['GUID'];
    DATEI = map['DATEI'];
    DEVI = map['DEVI'];
    SUCH = map['SUCH'];
    DATEU = map['DATEU'];
    DEVU = map['DEVU'];
    SUID = map['SUID'];
    JTID_L = map['JTID_L'];
    SYID_L = map['SYID_L'];
    BIID_L = map['BIID_L'];
    CIID_L = map['CIID_L'];
    BINA_D = map['BINA_D'];

  }

  String BRA_INFToJson(List<Bra_Inf_Local> data) =>
      json.encode(List<dynamic>.from(data.map((x) => x.toMap())));
}
