import '../../Setting/controllers/login_controller.dart';

class Acc_Cas_U_Local {
  int? ACID;
  int? ACUTY;
  String? SUID;
  int? SCID;
  int? ACCT;
  int? ACTMS;
  int? ACTMP;
  int? ACUST;
  int? ACUAM;
  String? SUCH;
  String? SUID2;
  String? GUID;
  String? DATEI;
  String? DEVI;
  String? DATEU;
  String? DEVU;
  int? JTID_L;
  int? BIID_L;
  int? SYID_L;
  String? CIID_L;
  Acc_Cas_U_Local({this.ACID,this.ACUTY,this.SUID,this.SCID,this.ACCT,this.ACTMS,this.ACTMP,this.ACUST,this.ACUAM,this.SUCH,this.SUID2
    ,this.GUID,this.DATEI,this.DEVI,this.DATEU,this.DEVU,this.JTID_L,this.SYID_L,this.BIID_L,this.CIID_L});


  Map<String, dynamic> toMap() {
    var map = <String, dynamic>{
      'ACID': ACID,
      'ACUTY': ACUTY,
      'SUID': SUID,
      'SCID': SCID,
      'ACCT': ACCT,
      'ACTMS': ACTMS,
      'ACTMP': ACTMP,
      'ACUST': ACUST,
      'ACUAM': ACUAM,
      'SUCH': SUCH,
      'SUID2': SUID2,
      'GUID': GUID,
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

  Acc_Cas_U_Local.fromMap(Map<dynamic, dynamic> map) {
    ACID = map['ACID'];
    ACUTY = map['ACUTY'];
    SUID = map['SUID'];
    SCID = map['SCID'];
    ACCT = map['ACCT'];
    ACTMS = map['ACTMS'];
    ACTMP = map['ACTMP'];
    ACUST = map['ACUST'];
    ACUAM = map['ACUAM'];
    SUCH = map['SUCH'];
    SUID2 = map['SUID2'];
    GUID = map['GUID'];
    DATEI = map['DATEI'];
    DEVI = map['DEVI'];
    DATEU = map['DATEU'];
    DEVU = map['DEVU'];
    JTID_L = map['JTID_L'];
    SYID_L = map['SYID_L'];
    BIID_L = map['BIID_L'];
    CIID_L = map['CIID_L'];
  }

}
