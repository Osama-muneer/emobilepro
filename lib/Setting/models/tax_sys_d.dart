import '../../Setting/controllers/login_controller.dart';

class Tax_Sys_D_Local {
  int? TSDID;
  int? TSID;
  String? STID;
  int? TTID;
  int? TCID;
  String? TSDMN;
  int? TTST;
  String? TTDE;
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
  String? TSDQR;


  Tax_Sys_D_Local({this.TSDID,this.TSID,this.STID,this.TCID,this.TTID,this.TTST,this.TSDQR
    ,this.TSDMN,this.TTDE,this.SUID,this.SUCH,this.DATEI,this.DEVI,this.DATEU,this.DEVU,
    this.DEFN,this.RES,this.ORDNU,this.JTID_L,this.SYID_L,this.BIID_L,this.CIID_L,this.GUID});


  Map<String, dynamic> toMap() {
    var map = <String, dynamic>{
      'TSDID': TSDID,
      'TSID': TSID,
      'STID': STID,
      'TCID': TCID,
      'TTID': TTID,
      'TTST': TTST,
      'TSDMN': TSDMN,
      'TTDE': TTDE,
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
      'TSDQR': TSDQR,
      'JTID_L': JTID_L ?? LoginController().JTID_L,
      'SYID_L': SYID_L ?? LoginController().SYID_L,
      'BIID_L': BIID_L ?? LoginController().BIID_L,
      'CIID_L': CIID_L ?? LoginController().CIID_L,
    };
    return map;
  }

  Tax_Sys_D_Local.fromMap(Map<dynamic, dynamic> map) {
    TSDID = map['TSDID'];
    TSID = map['TSID'];
    STID = map['STID'];
    TCID = map['TCID'];
    TSDMN = map['TSDMN'];
    TTST = map['TTST'];
    TTID = map['TTID'];
    TTDE = map['TTDE'];
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
    TSDQR = map['TSDQR'];
    JTID_L = map['JTID_L'];
    SYID_L = map['SYID_L'];
    BIID_L = map['BIID_L'];
    CIID_L = map['CIID_L'];
  }
}
