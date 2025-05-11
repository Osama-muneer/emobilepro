import '../../Setting/controllers/login_controller.dart';

class Tax_Sys_Bra_Local {
  int? TSBID;
  int? TSID;
  int? BIID;
  int? TSBDC;
  String? AANOO;
  String? AANOI;
  String? AANOR;
  String? AANORR;
  int? JTID_L;
  int? BIID_L;
  int? SYID_L;
  String? CIID_L;
  String? GUID;
  String? SUID;
  String? DATEI;
  String? DATEU;
  String? SUCH;
  String? DEVI;
  String? DEVU;
  int? TSBST;

  Tax_Sys_Bra_Local({this.TSBID,this.TSID,this.BIID,this.AANOO,this.TSBDC,this.AANOR
    ,this.AANOI,this.AANORR,this.JTID_L,this.SYID_L,this.BIID_L,this.CIID_L,this.GUID
  ,this.SUID,this.SUCH,this.DATEI,this.DEVI,this.DATEU,this.DEVU,this.TSBST});


  Map<String, dynamic> toMap() {
    var map = <String, dynamic>{
      'TSBID': TSBID,
      'TSID': TSID,
      'BIID': BIID,
      'AANOO': AANOO,
      'TSBDC': TSBDC,
      'AANOR': AANOR,
      'AANOI': AANOI,
      'AANORR': AANORR,
      'TSBST': TSBST,
      'GUID': GUID,
      'SUID': SUID,
      'SUCH': SUCH,
      'DATEI': DATEI,
      'DEVI': DEVI,
      'DATEU': DATEU,
      'DEVU': DEVU,
      'JTID_L': JTID_L ?? LoginController().JTID_L,
      'SYID_L': SYID_L ?? LoginController().SYID_L,
      'BIID_L': BIID_L ?? LoginController().BIID_L,
      'CIID_L': CIID_L ?? LoginController().CIID_L,
    };
    return map;
  }

  Tax_Sys_Bra_Local.fromMap(Map<dynamic, dynamic> map) {
    TSBID = map['TSBID'];
    TSID = map['TSID'];
    BIID = map['BIID'];
    AANOO = map['AANOO'];
    AANOI = map['AANOI'];
    AANOR = map['AANOR'];
    TSBDC = map['TSBDC'];
    AANORR = map['AANORR'];
    GUID = map['GUID'];
    SUID = map['SUID'];
    DATEI = map['DATEI'];
    DATEU = map['DATEU'];
    SUCH = map['SUCH'];
    DEVI = map['DEVI'];
    DEVU = map['DEVU'];
    TSBST = map['TSBST'];
    JTID_L = map['JTID_L'];
    SYID_L = map['SYID_L'];
    BIID_L = map['BIID_L'];
    CIID_L = map['CIID_L'];
  }
}
