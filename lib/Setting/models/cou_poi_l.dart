import 'dart:convert';

class Cou_Poi_L_Local {
  int? CPLID;
  int? CIMID;
  int? BPID;
  int? CPLST;
  String? SUID;
  String? DATEI;
  String? DATEU;
  String? SUCH;
  String? DEVI;
  String? DEVU;
  String? RES;
  String? GUID;
  String? GUIDF;
  int? JTID_L;
  int? BIID_L;
  int? SYID_L;
  String? CIID_L;



  Cou_Poi_L_Local({this.CPLID,this.CIMID,this.BPID,this.CPLST,this.SUID,this.SUCH,this.GUID,this.RES,this.DEVU,this.DATEU,
    this.DEVI,this.DATEI,this.GUIDF,this.JTID_L,this.SYID_L,this.BIID_L,this.CIID_L});


  Map<String, dynamic> toMap() {
    var map = <String, dynamic>{
      'CPLID': CPLID,
      'CIMID': CIMID,
      'BPID': BPID,
      'CPLST': CPLST,
      'SUID': SUID,
      'SUCH': SUCH,
      'DATEI': DATEI,
      'DEVI': DEVI,
      'DATEU': DATEU,
      'DEVU': DEVU,
      'RES': RES,
      'GUID': GUID,
      'GUIDF': GUIDF,
      'JTID_L': JTID_L,
      'SYID_L': SYID_L,
      'BIID_L': BIID_L,
      'CIID_L': CIID_L,
    };
    return map;
  }

  Cou_Poi_L_Local.fromMap(Map<dynamic, dynamic> map) {
    CPLID = map['CPLID'];
    CIMID = map['CIMID'];
    BPID = map['BPID'];
    CPLST = map['CPLST'];
    SUID = map['SUID'];
    DATEI = map['DATEI'];
    DATEU = map['DATEU'];
    SUCH = map['SUCH'];
    DEVI = map['DEVI'];
    DEVU = map['DEVU'];
    RES = map['RES'];
    GUID = map['GUID'];
    GUIDF = map['GUIDF'];
    JTID_L = map['JTID_L'];
    SYID_L = map['SYID_L'];
    BIID_L = map['BIID_L'];
    CIID_L = map['CIID_L'];
  }

  String Pay_Kin_toJson(List<Cou_Poi_L_Local> data) =>
      json.encode(List<dynamic>.from(data.map((x) => x.toMap())));
}
