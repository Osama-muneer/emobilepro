import 'dart:convert';

class Cou_Inf_M_Local {
  int? CIMID;
  int? BIID;
  int? CTMID;
  String? CIMNA;
  String? CIMNE;
  String? CIMN3;
  String? MGNO;
  String? MINO;
  int? MUID;
  String? CIMSN;
  int? CIMNP;
  var CIMIR;
  String? ACNO;
  int? CIMST;
  int? SIID;
  String? CIMDE;
  String? SUID;
  String? DATEI;
  String? DATEU;
  String? SUCH;
  String? DEVI;
  String? DEVU;
  String? RES;
  String? GUID;
  int? ORDNU;
  int? DEFN;
  double? MPCO;
  double? MPS1;
  double? MITS;
  int? SCIDO;
  int? JTID_L;
  int? BIID_L;
  int? SYID_L;
  String? CIID_L;
  String? CIMNA_D;


  Cou_Inf_M_Local({this.CIMID,this.BIID,this.CTMID,this.CIMNA,this.MUID,this.MINO,this.MGNO,this.DATEI,this.DEVI,this.DATEU,this.DEVU,this.ORDNU
    ,this.RES,this.GUID,this.SUCH,this.SUID,this.ACNO,this.CIMDE,this.CIMIR,this.CIMN3,this.CIMNE,this.CIMNP,this.CIMSN,this.CIMST
    ,this.SIID,this.JTID_L,this.SYID_L,this.BIID_L,this.CIID_L,this.CIMNA_D,this.DEFN,this.MPCO,this.SCIDO});


  Map<String, dynamic> toMap() {
    var map = <String, dynamic>{
      'CIMID': CIMID,
      'BIID': BIID,
      'CTMID': CTMID,
      'CIMNA': CIMNA,
      'CIMNE': CIMNE,
      'CIMN3': CIMN3,
      'MGNO': MGNO,
      'MINO': MINO,
      'MUID': MUID,
      'CIMSN': CIMSN,
      'CIMNP': CIMNP,
      'CIMIR': CIMIR,
      'ACNO': ACNO,
      'CIMST': CIMST,
      'CIMDE': CIMDE,
      'SIID': SIID,
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
      'SCIDO': SCIDO,
      'JTID_L': JTID_L,
      'SYID_L': SYID_L,
      'BIID_L': BIID_L,
      'CIID_L': CIID_L,
    };
    return map;
  }

  Cou_Inf_M_Local.fromMap(Map<dynamic, dynamic> map) {
    CIMID = map['CIMID'];
    BIID = map['BIID'];
    CTMID = map['CTMID'];
    CIMNA = map['CIMNA'];
    CIMNE = map['CIMNE'];
    CIMN3 = map['CIMN3'];
    MGNO = map['MGNO'];
    MINO = map['MINO'];
    MUID = map['MUID'];
    CIMSN = map['CIMSN'];
    CIMNP = map['CIMNP'];
    CIMIR = map['CIMIR'];
    ACNO = map['ACNO'];
    CIMST = map['CIMST'];
    CIMDE = map['CIMDE'];
    SIID = map['SIID'];
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
    MPCO = map['MPCO'];
    MPS1 = map['MPS1'];
    MITS = map['MITS'];
    SCIDO = map['SCIDO'];
    JTID_L = map['JTID_L'];
    SYID_L = map['SYID_L'];
    BIID_L = map['BIID_L'];
    CIID_L = map['CIID_L'];
    CIMNA_D = map['CIMNA_D'];
  }

  String Cou_Inf_M_toJson(List<Cou_Inf_M_Local> data) =>
      json.encode(List<dynamic>.from(data.map((x) => x.toMap())));
}
