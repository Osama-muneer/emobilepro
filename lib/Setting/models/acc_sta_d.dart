import '../../Setting/controllers/login_controller.dart';

late List<Acc_Sta_D_Local> ACC_STA_DDataList=[] ;

class Acc_Sta_D_Local {
  var ASMID;
  var ASDID;
  var ATC1;
  var ATC2;
  var ATC3;
  var ATC4;
  var ATC5;
  var ATC6;
  var ATC7;
  var ATC8;
  var ATC9;
  var ATC10;
  String? ATC11;
  String? ATC12;
  String? ATC13;
  String? ATC14;
  String? ATC15;
  String? ATC16;
  String? ATC17;
  String? ATC18;
  String? ATC19;
  String? ATC20;
  String? ATC21;
  String? ATC22;
  String? ATC23;
  String? ATC24;
  String? ATC25;
  String? ATC26;
  String? ATC27;
  String? ATC28;
  String? SUID;
  var SYID;
  String? GUID;
  String? ACNOT;
  String? GUID_REP;
  String? GUID_LNK;
  var JTID_L;
  var BIID_L;
  var SYID_L;
  String? CIID_L;
  var COU;
  var SUMAMDMD;
  var SUMAMDDA;


  Acc_Sta_D_Local({this.ASMID,this.ASDID,this.ATC1,this.ATC2,this.ATC3,this.ATC4,this.ATC5,this.ATC6,this.JTID_L,this.SYID_L,
    this.BIID_L, this.CIID_L,this.GUID_REP,this.ATC15,this.COU});
  Map<String, dynamic> toMap() {
    var map = <String, dynamic>{
      'ASMID': ASMID,
      'ASDID': ASDID,
      'ATC1': ATC1,
      'ATC2': ATC2,
      'ATC3': ATC3,
      'ATC4': ATC4,
      'ATC5': ATC5,
      'ATC6': ATC6,
      'ATC7': ATC7,
      'ATC8': ATC8,
      'ATC9': ATC9,
      'ATC10': ATC10,
      'ATC11': ATC11,
      'ATC12': ATC12,
      'ATC13': ATC13,
      'ATC14': ATC14,
      'ATC15': ATC15,
      'ATC16': ATC16,
      'ATC17': ATC17,
      'ATC18': ATC18,
      'ATC19': ATC19,
      'ATC20': ATC20,
      'ATC21': ATC21,
      'ATC22': ATC22,
      'ATC23': ATC23,
      'ATC24': ATC24,
      'ATC25': ATC25,
      'ATC26': ATC26,
      'ATC27': ATC27,
      'ATC28': ATC28,
      'SUID': SUID,
      'SYID': SYID,
      'GUID': GUID,
      'GUID_REP': GUID_REP,
      'GUID_LNK': GUID_LNK,
      'JTID_L': JTID_L ?? LoginController().JTID_L,
      'SYID_L': SYID_L ?? LoginController().SYID_L,
      'BIID_L': BIID_L ?? LoginController().BIID_L,
      'CIID_L': CIID_L ?? LoginController().CIID_L,
    };
    return map;
  }

  Acc_Sta_D_Local.fromMap(Map<dynamic, dynamic> map) {
    ASMID = map['ASMID'];
    ASDID = map['ASDID'];
    ATC1 = map['ATC1'];
    ATC2 = map['ATC2'];
    ATC3 = map['ATC3'];
    ATC4 = map['ATC4'];
    ATC5 = map['ATC5'];
    ATC6 = map['ATC6'];
    ATC7 = map['ATC7'];
    ATC8 = map['ATC8'];
    ATC9 = map['ATC9'];
    ATC10 = map['ATC10'];
    ATC11 = map['ATC11'];
    ATC12 = map['ATC12'];
    ATC13 = map['ATC13'];
    ATC14 = map['ATC14'];
    ATC15 = map['ATC15'];
    ATC16 = map['ATC16'];
    ATC17 = map['ATC17'];
    ATC18 = map['ATC18'];
    ATC19 = map['ATC19'];
    ATC20 = map['ATC20'];
    ATC21 = map['ATC21'];
    ATC22 = map['ATC22'];
    ATC23 = map['ATC23'];
    ATC24 = map['ATC24'];
    ATC25 = map['ATC25'];
    ATC26 = map['ATC26'];
    ATC27 = map['ATC27'];
    ATC28 = map['ATC28'];
    SUID = map['SUID'];
    SYID = map['SYID'];
    GUID = map['GUID'];
    GUID_REP = map['GUID_REP'];
    GUID_LNK = map['GUID_LNK'];
    JTID_L = map['JTID_L'];
    SYID_L = map['SYID_L'];
    BIID_L = map['BIID_L'];
    CIID_L = map['CIID_L'];
    COU = map['COU'];
    SUMAMDMD = map['SUMAMDMD'];
    SUMAMDDA = map['SUMAMDDA'];
  }

}
