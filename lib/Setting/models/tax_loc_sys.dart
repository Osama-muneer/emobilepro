import '../../Setting/controllers/login_controller.dart';

class Tax_Loc_Sys_Local {
  int? TLID;
  int? TLSID;
     String? GUID;
     String? STID;
  String? AANOO;
  String? AANOI;
  String? AANOR;
  String? AANORR;
  int? TLSDC;
  int? ORDNU;
  String? RES;
  String? SUID;
  String? DATEI;
  String? DATEU;
  String? SUCH;
  String? DEVI;
  String? DEVU;
  int? DEFN;
  int? JTID_L;
  int? BIID_L;
  int? SYID_L;
  String? CIID_L;

  Tax_Loc_Sys_Local({this.TLID,this.TLSID,this.GUID,this.STID,this.AANOO,this.AANOI,this.AANOR,this.AANORR,this.TLSDC,
    this.ORDNU,this.RES,this.SUID,
    this.DATEI,this.DATEU,this.SUCH,this.DEVI,this.DEVU,this.DEFN,this.JTID_L,this.SYID_L,this.BIID_L,this.CIID_L});


  Map<String, dynamic> toMap() {
    var map = <String, dynamic>{
      'TLID': TLID,
      'TLSID': TLSID,
      'GUID': GUID,
      'AANOO': AANOO,
      'AANOI': AANOI,
      'AANOR': AANOR,
      'AANORR': AANORR,
      'TLSDC': TLSDC,
      'ORDNU': ORDNU,
      'RES': RES,
      'SUID': SUID,
      'DATEI': DATEI,
      'DATEU': DATEU,
      'SUCH': SUCH,
      'DEVI': DEVI,
      'DEVU': DEVU,
      'DEFN': DEFN,
      'JTID_L': JTID_L ?? LoginController().JTID_L,
      'SYID_L': SYID_L ?? LoginController().SYID_L,
      'BIID_L': BIID_L ?? LoginController().BIID_L,
      'CIID_L': CIID_L ?? LoginController().CIID_L,
    };
    return map;
  }

  Tax_Loc_Sys_Local.fromMap(Map<dynamic, dynamic> map) {
    TLID = map['TLID'];
    TLSID = map['TLSID'];
    GUID = map['GUID'];
    AANOO = map['AANOO'];
    AANOI = map['AANOI'];
    AANOR = map['AANOR'];
    AANORR = map['AANORR'];
    TLSDC = map['TLSDC'];
    ORDNU = map['ORDNU'];
    RES = map['RES'];
    SUID = map['SUID'];
    DATEI = map['DATEI'];
    DATEU = map['DATEU'];
    SUCH = map['SUCH'];
    DEVI = map['DEVI'];
    DEVU = map['DEVU'];
    DEFN = map['DEFN'];
    GUID = map['GUID'];
    JTID_L = map['JTID_L'];
    SYID_L = map['SYID_L'];
    BIID_L = map['BIID_L'];
    CIID_L = map['CIID_L'];
  }

}
