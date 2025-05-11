import '../../Setting/controllers/login_controller.dart';

class Mob_Var_Local {
  int? MVID;
  String? MVNA;
  String? MVVL;
  String? MVVLS;
  int? MVST;
  int? JTID_L;
  int? BIID_L;
  int? SYID_L;
  String? CIID_L;
  String? DATEI;
  String? DATEU;

  Mob_Var_Local({this.MVID,this.MVNA,this.MVVL,this.MVVLS,this.JTID_L,this.SYID_L,this.BIID_L,this.CIID_L,
   this.DATEI,this.DATEU,this.MVST});


  Map<String, dynamic> toMap() {
    var map = <String, dynamic>{
      'MVID': MVID,
      'MVNA': MVNA,
      'MVVL': MVVL,
      'MVVLS': MVVLS,
      'MVST': MVST,
      'DATEI': DATEI,
      'DATEU': DATEU,
      'JTID_L': JTID_L ?? LoginController().JTID_L,
      'SYID_L': SYID_L ?? LoginController().SYID_L,
      'BIID_L': BIID_L ?? LoginController().BIID_L,
      'CIID_L': CIID_L ?? LoginController().CIID_L,
    };
    return map;
  }

  Mob_Var_Local.fromMap(Map<dynamic, dynamic> map) {
    MVID = map['MVID'];
    MVNA = map['MVNA'];
    MVVL = map['MVVL'];
    MVVLS = map['MVVLS'];
    MVST = map['MVST'];
    DATEI = map['DATEI'];
    DATEU = map['DATEU'];
    JTID_L = map['JTID_L'];
    SYID_L = map['SYID_L'];
    BIID_L = map['BIID_L'];
    CIID_L = map['CIID_L'];
  }

}
