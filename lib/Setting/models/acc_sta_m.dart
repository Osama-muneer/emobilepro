import '../../Setting/controllers/login_controller.dart';

class Acc_Sta_M_Local {
  var ASMID;
  String? SUID;
  String? AANO;
  String? AANA;
  var BIIDF;
  var BIIDT;
  String? BINA;
  String? ACNOF;
  String? ACNOT;
  String? ACNA;
  String? FROMD;
  String? TOD;
  var SCIDF;
  var SCIDT;
  String? SCNA;
  String? ASMIN;
  String? ASMNA;
  var AMLAS;
  var AMBAL;
  String? AMLASN;
  String? AMBALN;
  var ATC1;
  var ATC2;
  var ATC3;
  String? ATC4;
  String? ATC5;
  String? ATC6;
  String? ATC7;
  String? ATC8;
  String? ASMDA;
  String? ASMSA;
  var ASMDAY;
  var ASMSAY;
  String? GUID_REP;
  String? SUID_REP;
  var ROWN1;
  var JTID_L;
  var BIID_L;
  var SYID_L;
  String? CIID_L;
  var COU;


  Acc_Sta_M_Local({this.ASMID,this.SUID,this.AANO,this.AANA,this.BIIDF,this.BIIDT,this.BINA,this.ACNOF,this.JTID_L,this.SYID_L,
    this.BIID_L, this.CIID_L});
  Map<String, dynamic> toMap() {
    var map = <String, dynamic>{
      'ASMID': ASMID,
      'SUID': SUID,
      'AANO': AANO,
      'AANA': AANA,
      'BIIDF': BIIDF,
      'BIIDT': BIIDT,
      'BINA': BINA,
      'ACNOF': ACNOF,
      'ACNOT': ACNOT,
      'ACNA': ACNA,
      'FROMD': FROMD,
      'TOD': TOD,
      'SCIDF': SCIDF,
      'SCIDT': SCIDT,
      'SCNA': SCNA,
      'ASMIN': ASMIN,
      'ASMNA': ASMNA,
      'AMLAS': AMLAS,
      'AMBAL': AMBAL,
      'AMLASN': AMLASN,
      'AMBALN': AMBALN,
      'ATC1': ATC1,
      'ATC2': ATC2,
      'ATC3': ATC3,
      'ATC4': ATC4,
      'ATC5': ATC5,
      'ATC6': ATC6,
      'ATC7': ATC7,
      'ATC8': ATC8,
      'ASMDA': ASMDA,
      'ASMSA': ASMSA,
      'ASMDAY': ASMDAY,
      'ASMSAY': ASMSAY,
      'GUID_REP': GUID_REP,
      'SUID_REP': SUID_REP,
      'ROWN1': ROWN1,
      'JTID_L': JTID_L ?? LoginController().JTID_L,
      'SYID_L': SYID_L ?? LoginController().SYID_L,
      'BIID_L': BIID_L ?? LoginController().BIID_L,
      'CIID_L': CIID_L ?? LoginController().CIID_L,
    };
    return map;
  }

  Acc_Sta_M_Local.fromMap(Map<dynamic, dynamic> map) {
    ASMID = map['ASMID'];
    SUID = map['SUID'];
    AANO = map['AANO'];
    AANA = map['AANA'];
    BIIDF = map['BIIDF'];
    BIIDT = map['BIIDT'];
    BINA = map['BINA'];
    ACNOF = map['ACNOF'];
    ACNOT = map['ACNOT'];
    ACNA = map['ACNA'];
    FROMD = map['FROMD'];
    TOD = map['TOD'];
    SCIDF = map['SCIDF'];
    SCIDT = map['SCIDT'];
    SCNA = map['SCNA'];
    ASMIN = map['ASMIN'];
    ASMNA = map['ASMNA'];
    AMLAS = map['AMLAS'];
    AMBAL = map['AMBAL'];
    AMLASN = map['AMLASN'];
    AMBALN = map['AMBALN'];
    ATC1 = map['ATC1'];
    ATC2 = map['ATC2'];
    ATC3 = map['ATC3'];
    ATC4 = map['ATC4'];
    ATC5 = map['ATC5'];
    ATC6 = map['ATC6'];
    ATC7 = map['ATC7'];
    ATC8 = map['ATC8'];
    ASMDA = map['ASMDA'];
    ASMSA = map['ASMSA'];
    ASMDAY = map['ASMDAY'];
    ASMSAY = map['ASMSAY'];
    GUID_REP = map['GUID_REP'];
    SUID_REP = map['SUID_REP'];
    ROWN1 = map['ROWN1'];
    JTID_L = map['JTID_L'];
    SYID_L = map['SYID_L'];
    BIID_L = map['BIID_L'];
    CIID_L = map['CIID_L'];
    COU = map['COU'];
  }

}
