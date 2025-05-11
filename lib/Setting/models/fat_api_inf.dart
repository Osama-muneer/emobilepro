import '../../Setting/controllers/login_controller.dart';

class Fat_Api_Inf_Local {
  String? GUID;
  String? FAISP;
  String? SCHNA;
  String? STMID;
  String? FAITY;
  String? FAIURL;
  String? FAIME;
  String? FAIRO;
  String? FAIPO;
  String? FAICT;
  int? FAICH;
  int? FAITI;
  int? FAIRL;
  int? FAIUN;
  String? FAIUS;
  String? FAIPA;
  String? FAITO;
  String? FAIAF1;
  String? FAIAF2;
  String? FAIAF3;
  String? FAIAF4;
  String? SUID;
  String? DATEI;
  String? DATEU;
  String? STMIDI;
  int? SOMIDI;
  String? SUCH;
  String? DEVI;
  String? DEVU;
  String? STMIDU;
  int? SOMIDU;
  int? FAIST;
  int? JTID_L;
  int? BIID_L;
  int? SYID_L;
  String? CIID_L;


  Fat_Api_Inf_Local({this.GUID,this.FAISP,this.SCHNA,this.STMID,this.FAITY,this.FAIME,this.FAIPO
    ,this.FAIURL,this.FAIRO,this.FAICT,this.FAICH,this.FAITI,this.FAIRL,this.FAIUN,this.FAIUS,this.FAIPA,
    this.FAITO,this.FAIAF1,this.FAIAF2,this.FAIAF3,this.FAIAF4,this.SUID,this.STMIDI,this.SOMIDI,this.SUCH,
    this.DATEI,this.DEVI,this.DATEU,this.DEVU,
    this.STMIDU,this.SOMIDU,this.FAIST,this.JTID_L,this.SYID_L,this.BIID_L,this.CIID_L});


  Map<String, dynamic> toMap() {
    var map = <String, dynamic>{
      'GUID': GUID,
      'FAISP': FAISP,
      'SCHNA': SCHNA,
      'STMID': STMID,
      'FAITY': FAITY,
      'FAIME': FAIME,
      'FAIPO': FAIPO,
      'FAIURL': FAIURL,
      'FAIRO': FAIRO,
      'FAICT': FAICT,
      'FAICH': FAICH,
      'FAITI': FAITI,
      'FAIRL': FAIRL,
      'FAIUN': FAIUN,
      'FAIUS': FAIUS,
      'FAIPA': FAIPA,
      'FAITO': FAITO,
      'FAIAF1': FAIAF1,
      'FAIAF2': FAIAF2,
      'FAIAF3': FAIAF3,
      'FAIAF4': FAIAF4,
      'SUID': SUID,
      'STMIDI': STMIDI,
      'SOMIDI': SOMIDI,
      'SUCH': SUCH,
      'DATEI': DATEI,
      'DEVI': DEVI,
      'DATEU': DATEU,
      'DEVU': DEVU,
      'STMIDU': STMIDU,
      'SOMIDU': SOMIDU,
      'FAIST': FAIST,
      'JTID_L': JTID_L ?? LoginController().JTID_L,
      'SYID_L': SYID_L ?? LoginController().SYID_L,
      'BIID_L': BIID_L ?? LoginController().BIID_L,
      'CIID_L': CIID_L ?? LoginController().CIID_L,
    };
    return map;
  }

  Fat_Api_Inf_Local.fromMap(Map<dynamic, dynamic> map) {
    GUID = map['GUID'];
    FAISP = map['FAISP'];
    SCHNA = map['SCHNA'];
    STMID = map['STMID'];
    FAIURL = map['FAIURL'];
    FAIME = map['FAIME'];
    FAITY = map['FAITY'];
    FAIRO = map['FAIRO'];
    FAIPO = map['FAIPO'];
    FAICT = map['FAICT'];
    FAICH = map['FAICH'];
    FAITI = map['FAITI'];
    FAIRL = map['FAIRL'];
    FAIUN = map['FAIUN'];
    FAIUS = map['FAIUS'];
    FAIPA = map['FAIPA'];
    FAITO = map['FAITO'];
    FAIAF1 = map['FAIAF1'];
    FAIAF2 = map['FAIAF2'];
    FAIAF3 = map['FAIAF3'];
    FAIAF4 = map['FAIAF4'];
    SUID = map['SUID'];
    DATEI = map['DATEI'];
    DATEU = map['DATEU'];
    STMIDI = map['STMIDI'];
    SOMIDI = map['SOMIDI'];
    SUCH = map['SUCH'];
    DEVI = map['DEVI'];
    DEVU = map['DEVU'];
    STMIDU = map['STMIDU'];
    SOMIDU = map['SOMIDU'];
    JTID_L = map['JTID_L'];
    SYID_L = map['SYID_L'];
    BIID_L = map['BIID_L'];
    CIID_L = map['CIID_L'];
    FAIST = map['FAIST'];
  }
}
