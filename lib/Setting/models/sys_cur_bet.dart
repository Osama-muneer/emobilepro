
import '../../Setting/controllers/login_controller.dart';

class Sys_Cur_Bet_Local {
  int? SCIDF;
  int? SCIDT;
  String? SCBTY;
  var SCEX;
  String? DATEI;
  String? DATEU;
  int? JTID_L;
  int? BIID_L;
  int? SYID_L;
  String? CIID_L;
  String? GUID;
  String? DEVI;
  String? SUID;
  String? SUCH;
  String? DEVU;

  Sys_Cur_Bet_Local({this.SCIDF,this.SCIDT,this.SCBTY,this.SCEX,this.DATEI,this.DATEU,this.JTID_L,this.SYID_L,this.BIID_L,this.CIID_L,
    this.GUID,this.DEVI,this.SUCH,this.DEVU,this.SUID
  });


  Map<String, dynamic> toMap() {
    var map = <String, dynamic>{
      'SCIDF': SCIDF,
      'SCIDT': SCIDT,
      'SCBTY': SCBTY,
      'SCEX': SCEX,
      'DATEI': DATEI,
      'DATEU': DATEU,
      'GUID': GUID,
      'DEVI': DEVI,
      'SUCH': SUCH,
      'DEVU': DEVU,
      'SUID': SUID,
      'JTID_L': JTID_L ?? LoginController().JTID_L,
      'SYID_L': SYID_L ?? LoginController().SYID_L,
      'BIID_L': BIID_L ?? LoginController().BIID_L,
      'CIID_L': CIID_L ?? LoginController().CIID_L,
    };
    return map;
  }

  Sys_Cur_Bet_Local.fromMap(Map<dynamic, dynamic> map) {
    SCIDF = map['SCIDF'];
    SCIDT = map['SCIDT'];
    SCBTY = map['SCBTY'];
    SCEX = map['SCEX'];
    DATEI = map['DATEI'];
    DATEU = map['DATEU'];
    GUID = map['GUID'];
    DEVI = map['DEVI'];
    SUCH = map['SUCH'];
    DEVU = map['DEVU'];
    SUID = map['SUID'];
    JTID_L = map['JTID_L'];
    SYID_L = map['SYID_L'];
    BIID_L = map['BIID_L'];
    CIID_L = map['CIID_L'];
  }

}
