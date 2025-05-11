import 'dart:convert';
class Mat_Inf_D_Local {
  String? MGNO;
  String? MINO;
  var MAT_CON;
  var SHORT_NAME;
  var MAT_WEIGHT;
  var MAT_MODEL;
  var MAT_NOTE;
  var MAT_KIN;
  var MAT_TEST;
  var MAT_REP_TYP;
  int? MISN;
  int? MISL;
  int? MIPV;
  int? MIAD;
  String? MIDPI;
  String? MIDPI2;
  String? MIDPI3;
  int? MIFR;
  int? MAT_WEIGHT_YES;
  String? GUID;
  String? DATEI;
  String? DEVI;
  String? SUID;
  String? SUCH;
  String? DATEU;
  String? DEVU;

  Mat_Inf_D_Local({required this.MGNO,required this.MINO,this.MAT_CON,this.SHORT_NAME,this.MAT_WEIGHT,
    this.MAT_MODEL, this.MAT_NOTE,this.MAT_KIN,this.MAT_TEST,this.MAT_REP_TYP,this.MISN,
    this.MISL,this.MIPV,this.MIAD,this.MIDPI,this.MIDPI2,this.MIDPI3,this.MIFR,this.MAT_WEIGHT_YES,
    this.GUID,this.DATEI,this.DEVI,this.SUCH,this.DATEU,this.DEVU,this.SUID});

  Map<String, dynamic> toMap() {
    var map = <String, dynamic>{
      'MGNO': MGNO,
      'MINO': MINO,
      'MAT_CON': MAT_CON,
      'SHORT_NAME': SHORT_NAME,
      'MAT_WEIGHT': MAT_WEIGHT,
      'MAT_MODEL': MAT_MODEL,
      'MAT_NOTE': MAT_NOTE,
      'MAT_KIN': MAT_KIN,
      'MAT_TEST': MAT_TEST,
      'MAT_REP_TYP': MAT_REP_TYP,
      'MISN': MISN,
      'MISL': MISL,
      'MIPV': MIPV,
      'MIAD': MIAD,
      'MIDPI': MIDPI,
      'MIDPI2': MIDPI2,
      'MIDPI3': MIDPI3,
      'MIFR': MIFR,
      'MAT_WEIGHT_YES': MAT_WEIGHT_YES,
      'GUID': GUID,
      'DATEI': DATEI,
      'DEVI': DEVI,
      'SUCH': SUCH,
      'DATEU': DATEU,
      'DEVU': DEVU,
      'SUID': SUID,
    };
    return map;
  }

  Mat_Inf_D_Local.fromMap(Map<dynamic, dynamic> map) {
    MGNO = map['MGNO'];
    MINO = map['MINO'];
    MAT_CON = map['MAT_CON'];
    SHORT_NAME = map['SHORT_NAME'];
    MAT_WEIGHT = map['MAT_WEIGHT'];
    MAT_MODEL = map['MAT_MODEL'];
    MAT_NOTE = map['MAT_NOTE'];
    MAT_KIN = map['MAT_KIN'];
    MAT_TEST = map['MAT_TEST'];
    MAT_REP_TYP = map['MAT_REP_TYP'];
    MISN = map['MISN'];
    MISL = map['MISL'];
    MIPV = map['MIPV'];
    MIAD = map['MIAD'];
    MIDPI = map['MIDPI'];
    MIDPI2 = map['MIDPI2'];
    MIDPI3 = map['MIDPI3'];
    MIFR = map['MIFR'];
    MAT_WEIGHT_YES = map['MAT_WEIGHT_YES'];
    GUID = map['GUID'];
    DATEI = map['DATEI'];
    DEVI = map['DEVI'];
    SUCH = map['SUCH'];
    DATEU = map['DATEU'];
    DEVU = map['DEVU'];
    SUID = map['SUID'];

  }

  String Mat_Inf_DToJson(List<Mat_Inf_D_Local> data) =>
      json.encode(List<dynamic>.from(data.map((x) => x.toMap())));
}
