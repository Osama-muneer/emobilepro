class Sys_Acc_M_Local {
  int? SAMID;
  String? SAMNA;
  String? SAMNE;
  String? SAMN3;
  String? AANO;
  int? SAMTY;
  String? STID;
  int? SAMST;
  String? SAMDO;
  String? SUAP;
  String? SUDO;
  String? SUID;
  int? SAMKI;
  int? BIID;
  String? SUCH;
  String? DATEU;
  String? DEVU;
  String? RES;
  int? JTID_L;
  int? BIID_L;
  int? SYID_L;
  String? CIID_L;
  String? SAMNA_D;

  Sys_Acc_M_Local({required this.SAMID,required this.SAMNA, this.SAMNE,this.AANO,this.SAMTY,this.STID,this.SAMST,
    this.SAMDO,this.SUID,this.SAMKI,this.BIID,this.SAMN3,this.JTID_L,this.SYID_L,this.BIID_L,this.CIID_L});

  Map<String, dynamic> toMap() {
    var map = <String, dynamic>{
      'SAMID': SAMID,
      'SAMNA': SAMNA,
      'SAMNE': SAMNE,
      'AANO': AANO,
      'SAMTY': SAMTY,
      'STID': STID,
      'SAMST': SAMST,
      'SAMDO': SAMDO,
      'SUID': SUID,
      'SAMKI': SAMKI,
      'BIID': BIID,
      'SAMN3': SAMN3,
      'SUCH': SUCH,
      'DATEU': DATEU,
      'DEVU': DEVU,
      'RES': RES,
      'JTID_L': JTID_L,
      'SYID_L': SYID_L,
      'BIID_L': BIID_L,
      'CIID_L': CIID_L,
    };
    return map;
  }

  Sys_Acc_M_Local.fromMap(Map<dynamic, dynamic> map) {
    SAMID = map['SAMID'];
    SAMNA = map['SAMNA'];
    SAMNE = map['SAMNE'];
    AANO = map['AANO'];
    SAMTY = map['SAMTY'];
    STID = map['STID'];
    SAMST = map['SAMST'];
    SAMDO = map['SAMDO'];
    SUID = map['SUID'];
    SAMKI = map['SAMKI'];
    BIID = map['BIID'];
    SAMN3 = map['SAMN3'];
    DATEU = map['DATEU'];
    SUCH = map['SUCH'];
    DEVU = map['DEVU'];
    RES = map['RES'];
    JTID_L = map['JTID_L'];
    SYID_L = map['SYID_L'];
    BIID_L = map['BIID_L'];
    CIID_L = map['CIID_L'];
    SAMNA_D = map['SAMNA_D'];
  }

}
