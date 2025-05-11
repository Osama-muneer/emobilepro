late List<Sto_Mov_D_Local> get_item;
class Sto_Mov_D_Local {
  int? SMDID;
  int? SMMID;
  int? SMMNO;
  int? SMKID;
  String? MGNO;
  String? MINO;
  String? SMDED;
  int? MUID;
  int? SIID;
  int? SIIDT;
  int? BIID;
  double? SMDNF;
  double? SMDNO;
  double? SMDNO2;
  double? SMDDF;
  double? SUM;
  double? SUMSMDFN;
  var SMDAM;
  double? SMDEQ;
  double? SMDDI;
  double? SMDDIA;
  double? SMDDIF;
  double? SMDTX;
  double? SMDEX;
  double? SMDAML;
  double? SMDEQC;
  double? SMDCB;
  double? SMDCA;
  double? SMDAMR;
  double? SMDAMRE;
  double? SUM_SMDAM;
  double? SMDAMT;
  double? SMDAMTF;
  double? SUM_TOTSMDAM;
  double? SMMDIF;
  int? SYST;
  int? COU;
  int? MAX;
  String? GUID;
  String? GUIDM;
  var MINA;
  var MUNA;
  var MGNA;
  String? SUID;
  String? SUCH;
  String? DATEI;
  String? DATEU;
  String? DEVI;
  String? DEVU;
  String? NAM;
  int? NUM_MINO;
  int? JTID_L;
  int? SYID_L;
  int? BIID_L;
  String? CIID_L;
  String? MINA_D;
  String? MUNA_D;



  Sto_Mov_D_Local({this.SMDID,required this.SMMID,this.SMMNO,required this.SMKID, this.MGNO,this.MINO,required this.MUID,
    this.SIID, this.SMDNF,this.SMDNO,this.SMDDF,this.SMDED ,this.MINA,this.MUNA,this.MGNA,this.SUM,this.SUMSMDFN,this.NAM,
    this.SMDAM,this.BIID,this.SIIDT,this.COU,this.GUID,this.GUIDM,this.SMDNO2,this.SUID,this.SUCH,this.DATEU,this.DEVI,
    this.DEVU,this.MAX,this.DATEI,this.SYST,this.NUM_MINO,this.BIID_L,this.JTID_L,this.SYID_L,this.CIID_L,this.MUNA_D,
    this.MINA_D,this.SMDEQ,this.SMDDI,this.SMDDIA,this.SMDDIF,this.SMDTX,this.SMDEX,this.SMDAML,this.SMDEQC,this.SMDCA,
    this.SMDAMR,this.SMDAMRE,this.SMDAMT,this.SMDAMTF});


  Map<String, dynamic> toMap() {
    var map = <String, dynamic>{
      'SMDID': SMDID,
      'SMMID': SMMID,
      'SMKID': SMKID,
      'MINO': MINO,
      'MGNO': MGNO,
      'MUID': MUID,
      'SIID': SIID,
      'SMDNF': SMDNF,
      'SMDNO': SMDNO,
      'SMDDF': SMDDF,
      'SMDAM': SMDAM,
      'SMDED': SMDED,
      'BIID': BIID,
      'SIIDT': SIIDT,
      'GUID': GUID,
      'GUIDM': GUIDM,
      'SMDNO2': SMDNO2,
      'SYST': SYST,
      'SUID': SUID,
      'SUCH': SUCH,
      'DATEU': DATEU,
      'DEVI': DEVI,
      'DEVU': DEVU,
      'SMDEQ': SMDEQ,
      'SMDEQC': SMDEQC,
      'SMDAMR': SMDAMR,
      'SMDAMRE': SMDAMRE,
      'SMDAMT': SMDAMT,
      'SMDAMTF': SMDAMTF,
      'JTID_L': JTID_L,
      'BIID_L': BIID_L,
      'SYID_L': SYID_L,
      'CIID_L': CIID_L,
    };
    return map;
  }

  Sto_Mov_D_Local.fromMap(Map<dynamic, dynamic> map) {
    SMDID = map['SMDID'];
    SMMID = map['SMMID'];
    SMMNO = map['SMMNO'];
    SMKID = map['SMKID'];
    MGNO = map['MGNO'];
    MINO = map['MINO'];
    MUID = map['MUID'];
    SIID = map['SIID'];
    SMDNF = map['SMDNF'];
    MINA = map['MINA'];
    MUNA = map['MUNA'];
    SMDNO = map['SMDNO'];
    SMDDF = map['SMDDF'];
    MGNA = map['MGNA'];
    SMDAM = map['SMDAM'];
    SMDED = map['SMDED'];
    BIID = map['BIID'];
    SIIDT = map['SIIDT'];
    GUID = map['GUID'];
    GUIDM = map['GUIDM'];
    SMDNO2 = map['SMDNO2'];
    SYST = map['SYST'];
    NAM = map['NAM'];
    SUID = map['SUID'];
    DEVI = map['DEVI'];
    DATEI = map['DATEI'];
    SUCH = map['SUCH'];
    DATEU = map['DATEU'];
    DEVU = map['DEVU'];
    SMDEQ = map['SMDEQ'];
    SMDDI = map['SMDDI'];
    SMDDIA = map['SMDDIA'];
    SMDDIF = map['SMDDIF'];
    SMDTX = map['SMDTX'];
    SMDEX = map['SMDEX'];
    SMDAML = map['SMDAML'];
    SMDEQC = map['SMDEQC'];
    SMDCA = map['SMDCA'];
    SMDAMR = map['SMDAMR'];
    SMDAMRE = map['SMDAMRE'];
    SUM_SMDAM = map['SUM_SMDAM'];
    SMDAMT = map['SMDAMT'];
    SMDAMTF = map['SMDAMTF'];
    SUM_TOTSMDAM = map['SUM_TOTSMDAM'];
    SMMDIF = map['SMMDIF'];
    JTID_L = map['JTID_L'];
    BIID_L = map['BIID_L'];
    SYID_L = map['SYID_L'];
    CIID_L = map['CIID_L'];
    MUNA_D = map['MUNA_D'];
    MINA_D = map['MINA_D'];
  }

  Sto_Mov_D_Local.fromMapSum(Map<dynamic, dynamic> map) {
    SUM = map['SUM'];
    SUMSMDFN = map['SUMSMDFN'];
    NUM_MINO = map['NUM_MINO'];
  }

  Sto_Mov_D_Local.fromMapCou(Map<dynamic, dynamic> map) {
    COU = map['COU'];
    MAX = map['MAX'];
  }
}
