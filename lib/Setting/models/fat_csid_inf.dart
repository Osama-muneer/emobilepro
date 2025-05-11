import '../../Setting/controllers/login_controller.dart';

class Fat_Csid_Inf_Local {
  int? FCIID;
  String? FCIGU;
  String? FCITY;
  int? CIIDL;
  int? JTIDL;
  int? BIIDL;
  String? BIIDV;
  String? STMIDV;
  String? SOMGUV;
  String? SUIDV;
  String? BMKIDV;
  String? FCIBTV;
  String? SCHNA;
  int? FCIJOB;
  String? FCIDE;
  String? FCICN;
  String? FCISN;
  String? FCIOI;
  String? FCIOUN;
  String? FCION;
  String? FCIAD;
  String? FCIFM;
  String? FCIIPC;
  String? FCICC;
  String? FCILA;
  String? FCIVN;
  String? FCIOTP;
  String? FCIPK;
  String? FCICSR;
  String? FCIBST;
  String? FCISE;
  String? FCIDI;
  String? FCIDC;
  String? FCIED;
  String? FCIEM;
  String? FCIZTS;
  String? FCIJS;
  String? FCIRI;
  String? FCIDM;
  String? FCIAF1;
  String? FCIAF2;
  String? FCIAF3;
  String? FCIAF4;
  String? FCIAF5;
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
  int? FCIST;
  int? DEFN;
  int? ORDNU;
  String? RES;
  int? JTID_L;
  int? BIID_L;
  int? SYID_L;
  String? CIID_L;


  Fat_Csid_Inf_Local({this.FCIID,this.FCIGU,this.FCITY,this.CIIDL,this.JTIDL,this.BIIDV,this.SOMGUV
    ,this.BIIDL,this.STMIDV,this.SUIDV,this.BMKIDV,this.FCIBTV,this.SCHNA,this.FCIJOB,this.FCIDE,this.FCICN,
    this.FCISN,this.FCIOI,this.FCIOUN,this.FCION,this.FCIAD,this.FCIFM,this.FCIIPC,this.FCICC,this.FCILA
    ,this.FCIVN,this.FCIOTP,this.FCIPK,this.FCICSR,this.FCIBST,this.FCISE,this.FCIDI,this.FCIDC,this.FCIED,
    this.FCIEM,this.FCIZTS,this.FCIJS,this.FCIRI,this.FCIDM,this.FCIAF1,this.FCIAF2,this.FCIAF3,this.FCIAF4,
    this.FCIAF5,this.SUID,this.STMIDI,this.SOMIDI,this.SUCH, this.DATEI,this.DEVI,this.DATEU,this.DEVU,
    this.STMIDU,this.SOMIDU,this.FCIST,this.DEFN,this.ORDNU,this.RES,this.JTID_L,this.SYID_L,this.BIID_L,this.CIID_L});


  Map<String, dynamic> toMap() {
    var map = <String, dynamic>{
      'FCIID': FCIID,
      'FCIGU': FCIGU,
      'FCITY': FCITY,
      'CIIDL': CIIDL,
      'JTIDL': JTIDL,
      'BIIDV': BIIDV,
      'SOMGUV': SOMGUV,
      'BIIDL': BIIDL,
      'STMIDV': STMIDV,
      'SUIDV': SUIDV,
      'BMKIDV': BMKIDV,
      'FCIBTV': FCIBTV,
      'SCHNA': SCHNA,
      'FCIJOB': FCIJOB,
      'FCIDE': FCIDE,
      'FCICN': FCICN,
      'FCISN': FCISN,
      'FCIOI': FCIOI,
      'FCIOUN': FCIOUN,
      'FCION': FCION,
      'FCIAD': FCIAD,
      'FCIFM': FCIFM,
      'FCIIPC': FCIIPC,
      'FCICC': FCICC,
      'FCILA': FCILA,
      'FCIVN': FCIVN,
      'FCIOTP': FCIOTP,
      'FCIPK': FCIPK,
      'FCICSR': FCICSR,
      'FCIBST': FCIBST,
      'FCISE': FCISE,
      'FCIDI': FCIDI,
      'FCIDC': FCIDC,
      'FCIED': FCIED,
      'FCIEM': FCIEM,
      'FCIZTS': FCIZTS,
      'FCIJS': FCIJS,
      'FCIRI': FCIRI,
      'FCIDM': FCIDM,
      'FCIAF1': FCIAF1,
      'FCIAF2': FCIAF2,
      'FCIAF3': FCIAF3,
      'FCIAF4': FCIAF4,
      'FCIAF5': FCIAF5,
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
      'FCIST': FCIST,
      'DEFN': DEFN,
      'ORDNU': ORDNU,
      'RES': RES,
      'JTID_L': JTID_L ?? LoginController().JTID_L,
      'SYID_L': SYID_L ?? LoginController().SYID_L,
      'BIID_L': BIID_L ?? LoginController().BIID_L,
      'CIID_L': CIID_L ?? LoginController().CIID_L,
    };
    return map;
  }

  Fat_Csid_Inf_Local.fromMap(Map<dynamic, dynamic> map) {
    FCIID = map['FCIID'];
    FCIGU = map['FCIGU'];
    FCITY = map['FCITY'];
    CIIDL = map['CIIDL'];
    BIIDL = map['BIIDL'];
    BIIDV = map['BIIDV'];
    JTIDL = map['JTIDL'];
    STMIDV = map['STMIDV'];
    SOMGUV = map['SOMGUV'];
    SUIDV = map['SUIDV'];
    BMKIDV = map['BMKIDV'];
    SCHNA = map['SCHNA'];
    FCIJOB = map['FCIJOB'];
    FCIDE = map['FCIDE'];
    FCICN = map['FCICN'];
    FCISN = map['FCISN'];
    FCIOI = map['FCIOI'];
    FCIOUN = map['FCIOUN'];
    FCION = map['FCION'];
    FCIAD = map['FCIAD'];
    FCIFM = map['FCIFM'];
    FCIIPC = map['FCIIPC'];
    FCICC = map['FCICC'];
    FCILA = map['FCILA'];
    FCIVN = map['FCIVN'];
    FCIOTP = map['FCIOTP'];
    FCIPK = map['FCIPK'];
    FCICSR = map['FCICSR'];
    FCIBST = map['FCIBST'];
    FCISE = map['FCISE'];
    FCIDI = map['FCIDI'];
    FCIDC = map['FCIDC'];
    FCIED = map['FCIED'];
    FCIEM = map['FCIEM'];
    FCIZTS = map['FCIZTS'];
    FCIJS = map['FCIJS'];
    FCIRI = map['FCIRI'];
    FCIDM = map['FCIDM'];
    FCIAF1 = map['FCIAF1'];
    FCIAF2 = map['FCIAF2'];
    FCIAF3 = map['FCIAF3'];
    FCIAF4 = map['FCIAF4'];
    FCIAF5 = map['FCIAF5'];
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
    FCIST = map['FCIST'];
    DEFN = map['DEFN'];
    ORDNU = map['ORDNU'];
    RES = map['RES'];
    JTID_L = map['JTID_L'];
    SYID_L = map['SYID_L'];
    BIID_L = map['BIID_L'];
    CIID_L = map['CIID_L'];
  }
}
