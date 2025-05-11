
import '../../Setting/controllers/login_controller.dart';

class Fas_Acc_Usr_Local {
  String? SUID;
  int? SSID;
  String? FAUIC;
  String? FAUICS;
  int? STMID;
  String? FAUKE;
  int? FAUST;
  String? SUID2;
  String? DATEI;
  String? DATEU;
  String? SUCH;
  String? DEVI;
  String? DEVU;
  String? RES;
  int? ORDNU;
  int? FAUST2;
  int? JTID_L;
  int? BIID_L;
  int? SYID_L;
  String? CIID_L;
  String? GUID;
  String? SSDA_D;


  Fas_Acc_Usr_Local({this.SUID,this.SSID,this.FAUIC,this.STMID,this.FAUICS,this.FAUST,this.FAUST2
    ,this.FAUKE,this.SUID2,this.SUCH,this.DATEI,this.DEVI,this.DATEU,this.DEVU,
    this.RES,this.ORDNU,this.JTID_L,this.SYID_L,this.BIID_L,this.CIID_L,this.GUID});


  Map<String, dynamic> toMap() {
    var map = <String, dynamic>{
      'SUID': SUID,
      'SSID': SSID,
      'FAUIC': FAUIC,
      'STMID': STMID,
      'FAUICS': FAUICS,
      'FAUST': FAUST,
      'FAUST2': FAUST2,
      'FAUKE': FAUKE,
      'SUID2': SUID2,
      'SUCH': SUCH,
      'DATEI': DATEI,
      'DEVI': DEVI,
      'DATEU': DATEU,
      'DEVU': DEVU,
      'RES': RES,
      'ORDNU': ORDNU,
      'GUID': GUID,
      'JTID_L': JTID_L ?? LoginController().JTID_L,
      'SYID_L': SYID_L ?? LoginController().SYID_L,
      'BIID_L': BIID_L ?? LoginController().BIID_L,
      'CIID_L': CIID_L ?? LoginController().CIID_L,
    };
    return map;
  }

  Fas_Acc_Usr_Local.fromMap(Map<dynamic, dynamic> map) {
    SUID = map['SUID'];
    SSID = map['SSID'];
    FAUIC = map['FAUIC'];
    STMID = map['STMID'];
    FAUKE = map['FAUKE'];
    FAUST = map['FAUST'];
    FAUICS = map['FAUICS'];
    SUID2 = map['SUID2'];
    DATEI = map['DATEI'];
    DATEU = map['DATEU'];
    SUCH = map['SUCH'];
    DEVI = map['DEVI'];
    DEVU = map['DEVU'];
    RES = map['RES'];
    ORDNU = map['ORDNU'];
    FAUST2 = map['FAUST2'];
    GUID = map['GUID'];
    JTID_L = map['JTID_L'];
    SYID_L = map['SYID_L'];
    BIID_L = map['BIID_L'];
    CIID_L = map['CIID_L'];
    SSDA_D = map['SSDA_D'];
  }
}
