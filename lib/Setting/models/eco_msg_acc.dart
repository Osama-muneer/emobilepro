import '../../Setting/controllers/login_controller.dart';

class Eco_Msg_Acc_Local {

  String? EMID;
  int? EAID;
  int? EMAST;
  int? EMADL;
  String? GUID;
  int? JTID_L;
  int? BIID_L;
  int? SYID_L;
  String? CIID_L;

  Eco_Msg_Acc_Local({ this.EMID, this.EAID, this.EMAST,
    this.JTID_L,this.SYID_L,this.BIID_L,this.CIID_L,this.GUID});

  Map<String, dynamic> toMap() {
    var map = <String, dynamic>{
      'EMID': EMID,
      'EAID': EAID,
      'EMAST': EMAST,
      'EMADL': EMADL,

      'GUID': GUID,
      'JTID_L': JTID_L ?? LoginController().JTID_L,
      'SYID_L': SYID_L ?? LoginController().SYID_L,
      'BIID_L': BIID_L ?? LoginController().BIID_L,
      'CIID_L': CIID_L ?? LoginController().CIID_L,
    };
    return map;
  }

  Eco_Msg_Acc_Local.fromMap(Map<dynamic, dynamic> map) {
    EMID = map['EMID'];
    EAID = map['EAID'];
    EMAST = map['EMAST'];
    EMADL = map['EMADL'];
    GUID = map['GUID'];
    JTID_L = map['JTID_L'];
    SYID_L = map['SYID_L'];
    BIID_L = map['BIID_L'];
    CIID_L = map['CIID_L'];
  }

}
