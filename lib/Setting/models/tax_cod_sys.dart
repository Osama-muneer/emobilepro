import '../../Setting/controllers/login_controller.dart';

class Tax_Cod_Sys_Local {
  int? TCSID;
  int? TTSID;
  String? TCSSY;
  String? TCSNA;
  String? TCSNE;
  String? TCSN3;
  int? TCSTY;
  int? TCSST;
  String? TCSDA;
  String? TCSDE;
  String? TCSD3;
  int? TCSVL;
  String? SUID;
  String? DATEI;
  String? DATEU;
  String? SUCH;
  String? DEVI;
  String? DEVU;
  String? RES;
  int? ORDNU;
  int? DEFN;
  int? JTID_L;
  int? BIID_L;
  int? SYID_L;
  String? CIID_L;
  String? GUID;


  Tax_Cod_Sys_Local({this.TCSID,this.TTSID,this.TCSSY,this.TCSNE,this.TCSNA,this.TCSTY
    ,this.TCSN3,this.TCSST,this.TCSDA,this.TCSDE,this.TCSD3,this.TCSVL
    ,this.SUID,this.SUCH,this.DATEI,this.DEVI,this.DATEU,this.DEVU,this.DEFN,
    this.RES,this.ORDNU,this.JTID_L,this.SYID_L,this.BIID_L,this.CIID_L,this.GUID});


  Map<String, dynamic> toMap() {
    var map = <String, dynamic>{
      'TCSID': TCSID,
      'TTSID': TTSID,
      'TCSSY': TCSSY,
      'TCSNE': TCSNE,
      'TCSNA': TCSNA,
      'TCSTY': TCSTY,
      'TCSN3': TCSN3,
      'TCSST': TCSST,
      'TCSDA': TCSDA,
      'TCSDE': TCSDE,
      'TCSD3': TCSD3,
      'TCSVL': TCSVL,
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
      'JTID_L': JTID_L ?? LoginController().JTID_L,
      'SYID_L': SYID_L ?? LoginController().SYID_L,
      'BIID_L': BIID_L ?? LoginController().BIID_L,
      'CIID_L': CIID_L ?? LoginController().CIID_L,
    };
    return map;
  }

  Tax_Cod_Sys_Local.fromMap(Map<dynamic, dynamic> map) {
    TCSID = map['TCSID'];
    TTSID = map['TTSID'];
    TCSSY = map['TCSSY'];
    TCSNE = map['TCSNE'];
    TCSN3 = map['TCSN3'];
    TCSTY = map['TCSTY'];
    TCSNA = map['TCSNA'];
    TCSST = map['TCSST'];
    TCSDA = map['TCSDA'];
    TCSDE = map['TCSDE'];
    TCSD3 = map['TCSD3'];
    TCSVL = map['TCSVL'];
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
    JTID_L = map['JTID_L'];
    SYID_L = map['SYID_L'];
    BIID_L = map['BIID_L'];
    CIID_L = map['CIID_L'];
  }

}
