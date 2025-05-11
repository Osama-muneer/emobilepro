
class Cou_Usr_Local {
  int? CIMID;
  String? SUID;
  int? CUIN;
  int? CUVI;
  int? CUPR;
  int? CUDL;
  int? CURE;
  int? CUAP;
  int? CUST;
  String? SUCH;
  String? DATEU;
  String? DEVU;
  String? RES;
  String? GUID;
  int? JTID_L;
  int? BIID_L;
  int? SYID_L;
  String? CIID_L;


  Cou_Usr_Local({this.CIMID,this.SUID,this.CUIN,this.CUVI,this.CUPR,this.SUCH,this.GUID,this.DEVU,this.DATEU,this.RES,this.CUAP,this.CUDL,
    this.CUST,this.JTID_L,this.SYID_L,this.BIID_L,this.CIID_L});


  Map<String, dynamic> toMap() {
    var map = <String, dynamic>{
      'CIMID': CIMID,
      'SUID': SUID,
      'CUIN': CUIN,
      'CUVI': CUVI,
      'CUPR': CUPR,
      'CUDL': CUDL,
      'CURE': CURE,
      'CUAP': CUAP,
      'CUST': CUST,
      'SUCH': SUCH,
      'DATEU': DATEU,
      'DEVU': DEVU,
      'RES': RES,
      'GUID': GUID,
      'JTID_L': JTID_L,
      'SYID_L': SYID_L,
      'BIID_L': BIID_L,
      'CIID_L': CIID_L,
    };
    return map;
  }

  Cou_Usr_Local.fromMap(Map<dynamic, dynamic> map) {
    CIMID = map['CIMID'];
    SUID = map['SUID'];
    CUIN = map['CUIN'];
    CUVI = map['CUVI'];
    CUPR = map['CUPR'];
    CUDL = map['CUDL'];
    CURE = map['CURE'];
    CUAP = map['CUAP'];
    CUST = map['CUST'];
    SUCH = map['SUCH'];
    DATEU = map['DATEU'];
    DEVU = map['DEVU'];
    RES = map['RES'];
    GUID = map['GUID'];
    JTID_L = map['JTID_L'];
    SYID_L = map['SYID_L'];
    BIID_L = map['BIID_L'];
    CIID_L = map['CIID_L'];
  }

}
