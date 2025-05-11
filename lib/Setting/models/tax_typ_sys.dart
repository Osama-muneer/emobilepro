
import '../../Setting/controllers/login_controller.dart';

class Tax_Typ_Sys_Local {
  int? TTSID;
  String? TTSSY;
  String? TTSNA;
  String? TTSNE;
  String? TTSN3;
  String? TTSNS;
  int? CWID;
  int? TTSST;
  int? TTSSE;
  int? TTSCR;
  int? TTSAD;
  int? TTSAE;
  int? TTSNT;
  int? SCID;
  String? SUID;
  String? DATEI;
  String? DATEU;
  String? SUCH;
  String? DEVI;
  String? DEVU;
  String? RES;
  int? ORDNU;
  int? DEFN;
  int? JTID_L;
  int? BIID_L;
  int? SYID_L;
  String? CIID_L;
  String? GUID;
  String? TTSIDC;


  Tax_Typ_Sys_Local({this.TTSID,this.TTSSY,this.TTSNA,this.TTSN3,this.TTSNE,this.CWID
    ,this.TTSNS,this.TTSST,this.TTSSE,this.TTSCR,this.TTSAD,this.TTSAE,this.TTSNT,this.SCID
    ,this.SUID,this.SUCH,this.DATEI,this.DEVI,this.DATEU,this.DEVU,this.DEFN,this.TTSIDC,
    this.RES,this.ORDNU,this.JTID_L,this.SYID_L,this.BIID_L,this.CIID_L,this.GUID});


  Map<String, dynamic> toMap() {
    var map = <String, dynamic>{
      'TTSID': TTSID,
      'TTSSY': TTSSY,
      'TTSNA': TTSNA,
      'TTSN3': TTSN3,
      'TTSNE': TTSNE,
      'CWID': CWID,
      'TTSNS': TTSNS,
      'TTSST': TTSST,
      'TTSSE': TTSSE,
      'TTSCR': TTSCR,
      'TTSAD': TTSAD,
      'TTSAE': TTSAE,
      'TTSNT': TTSNT,
      'SCID': SCID,
      'SUID': SUID,
      'SUCH': SUCH,
      'DATEI': DATEI,
      'DEVI': DEVI,
      'DATEU': DATEU,
      'DEVU': DEVU,
      'RES': RES,
      'ORDNU': ORDNU,
      'DEFN': DEFN,
      'GUID': GUID,
      'TTSIDC': TTSIDC,
      'JTID_L': JTID_L ?? LoginController().JTID_L,
      'SYID_L': SYID_L ?? LoginController().SYID_L,
      'BIID_L': BIID_L ?? LoginController().BIID_L,
      'CIID_L': CIID_L ?? LoginController().CIID_L,
    };
    return map;
  }

  Tax_Typ_Sys_Local.fromMap(Map<dynamic, dynamic> map) {
    TTSID = map['TTSID'];
    TTSSY = map['TTSSY'];
    TTSNA = map['TTSNA'];
    TTSN3 = map['TTSN3'];
    TTSNS = map['TTSNS'];
    CWID = map['CWID'];
    TTSNE = map['TTSNE'];
    TTSST = map['TTSST'];
    TTSSE = map['TTSSE'];
    TTSCR = map['TTSCR'];
    TTSAD = map['TTSAD'];
    TTSAE = map['TTSAE'];
    TTSNT = map['TTSNT'];
    SCID = map['SCID'];
    SUID = map['SUID'];
    DATEI = map['DATEI'];
    DATEU = map['DATEU'];
    SUCH = map['SUCH'];
    DEVI = map['DEVI'];
    DEVU = map['DEVU'];
    RES = map['RES'];
    ORDNU = map['ORDNU'];
    DEFN = map['DEFN'];
    GUID = map['GUID'];
    TTSIDC = map['TTSIDC'];
    JTID_L = map['JTID_L'];
    SYID_L = map['SYID_L'];
    BIID_L = map['BIID_L'];
    CIID_L = map['CIID_L'];
  }

}
