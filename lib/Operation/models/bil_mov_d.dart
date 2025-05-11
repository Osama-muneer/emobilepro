
class Bil_Mov_D_Local {
  int? BMKID;
  int? BMMID;
  int? BMDID;
  String? MGNO;
  String? MINO;
  int? MUID;
  String? MUCBC;
  double? BMDAM;
  double? BMDNO;
  double? BMDNF;
  String? BMDED;
  double? BMDEQ;
  String? BMDIN;
  int? SIIDT;
  double? BMDDI;
  double? BMDDIA;
  double? BMDDIF;
  double? BMDTX;
  double? BMDEX;
  double? BMDAML;
  double? BMDEQC;
  double? BMDCB;
  double? BMDCA;
  int? BMDIDR;
  double? BMDAMR;
  int? SIID;
  int? BIID;
  double? BMDDIR;
  double? BMDTXA;
  double? BMDTXD;
  double? BMDTXT;
  int? BMDTY;
  int? BMDDIA2;
  int? BMDDIR2;
  String? BMDDE;
  double? BMDAMO;
  String? GUID;
  String? GUIDMT;
  int? BMDWE;
  int? BMDVO;
  int? BMDVC;
  String? BMDDD;
  int? JTID_L;
  int? BIID_L;
  int? SYID_L;
  String? CIID_L;
  String? CIMNA_D;
  String? GUIDM;
  int? COUNT_CIMID;
  int? SYST;
  double? BMDTXAT;
  String? MINA_D;
  String? MUNA_D;
  var MINA;
  var MUNA;
  var MGNA;
  String? NAM;
  double? SUM_BMDTXA;
  double? SUM_BMDAM;
  double? SUM_TOTBMDAM;
  int? COU;
  int? COUNT_MINO;
  int? MITSK;
  double? BMDAMT;
  double? BMDAMTF;
  double? BMDDIT;
  double? BMDDIM;
  double? BMMDIF;
  double? BMMDI;
  double?  COUNT_BMDNO;
  double?  SUM_BMDAMT;
  double? SUM_AM_TXT_DI;
  double? BMDAMRE;
  int? MGKI;
  String? MGNA_D;
  String? MGNE;
  String? NAM_D;
  double? BMDTX1;
  double? BMDTX2;
  double? BMDTX3;
  double? BMDTXA1;
  double? BMDTXA2;
  double? BMDTXA3;
  double? BMDTXT1;
  double? BMDTXT2;
  double? BMDTXT3;
  double? SUM_BMDTXT;
  double? SUM_BMDTXT1;
  double? SUM_BMDTXT2;
  double? SUM_BMDTXT3;
  double? BMDTX11;
  double? BMDTX22;
  double? BMDTX33;
  double? BMDTXA11;
  double? BMDTXA22;
  double? BMDTXA33;
  String? TDKID;
  String? TCKID;
  int? TCVL;
  double? TCRA;
  int? TCSDID;
  String? TCSDSY;
  int? TCID;
  String? TCSY;
  double? BMDAM_TX;
  double? BMDDI_TX;
  double? BMDAMT3;
  double? TCAMT;
  double? QUN_N;
  double? AM_N;
  double? FR_AM_N;
  String? NAM_V;
  double? TOT_AM_N;
  double? TOT_VAT_N;
  double? TOT_W_VAT_N;
  String? VAT_CAT_V;
  double? VAT_RAT_N;
  String? TAX_EXE_V;
  double? DIS_AM_N2;
  String? DIS_COD_V;
  String? DIS_RES_V;
  String? TAX_EXE_COD_V;
  double? BMDAM1;
  int? CTMID;
  int? CIMID;
  int? SCIDC;


  Bil_Mov_D_Local({this.BMKID,this.MGNO,this.MINO,this.MUID,this.SIID,this.GUID,this.BMMID,this.BMDAM,this.BIID,
  this.BMDAMO,this.BMDAMR,this.BMDDD,this.BMDDE,this.BMDDI,this.BMDDIA,this.BMDDIA2,this.BMDDIF,this.BMDDIR,this.GUIDMT,
  this.BMDDIR2,this.BMDED,this.BMDEQ,this.BMDID,this.BMDIDR,this.BMDIN,this.BMDNF,this.BMDNO,this.BMDTX,this.BMDTXA,
  this.BMDTXD,this.BMDTY,this.BMDVC,this.BMDVO,this.BMDWE,this.JTID_L,this.SYID_L,this.BIID_L,this.CIID_L,this.BMDTXT,
    this.CIMNA_D,this.GUIDM,this.SYST,this.BMDTXAT,this.MINA_D,this.MUNA_D,this.SUM_BMDTXA,this.MUCBC,this.BMDAMT,
    this.BMDAMTF,this.BMDDIT,this.BMDDIM,this.MITSK,this.BMDEQC,this.BMDAMRE,this.MGKI,this.BMDTX1,this.BMDTX2,this.BMDTX3,
  this.BMDTXA1,this.BMDTXA2,this.BMDTXA3,this.BMDTXT1,this.BMDTXT2,this.BMDTXT3,this.TDKID,this.TCKID,
    this.TCVL,this.TCRA,this.TCSDID,this.TCSDSY,this.TCID,this.TCSY,this.BMDAM_TX,this.BMDDI_TX,
    this.BMDAMT3,this.TCAMT,this.BMDAM1,this.CTMID,this.CIMID,this.SCIDC});


  Map<String, dynamic> toMap() {
    var map = <String, dynamic>{
      'BMKID': BMKID,
      'BMMID': BMMID,
      'BMDID': BMDID,
      'MGNO': MGNO,
      'MINO': MINO,
      'MUID': MUID,
      'BMDAM': BMDAM,
      'BMDNO': BMDNO,
      'BMDNF': BMDNF,
      'BMDED': BMDED,
      'BMDEQ': BMDEQ,
      'BMDIN': BMDIN,
      'BMDDI': BMDDI,
      'BMDDIF': BMDDIF,
      'BMDTX': BMDTX,
      'BMDIDR': BMDIDR,
      'BMDAMR': BMDAMR,
      'SIID': SIID,
      'BIID': BIID,
      'BMDDIR': BMDDIR,
      'BMDTXA': BMDTXA,
      'BMDTY': BMDTY,
      'BMDDE': BMDDE,
      'BMDAMO': BMDAMO,
      'GUID': GUID,
      'BMDDD': BMDDD,
      'GUIDM': GUIDM,
      'JTID_L': JTID_L,
      'SYID_L': SYID_L,
      'BIID_L': BIID_L,
      'CIID_L': CIID_L,
      'SYST': SYST,
      'MUCBC': MUCBC,
      'BMDAMT': BMDAMT,
      'BMDAMTF': BMDAMTF,
      'BMDTXT': BMDTXT,
      'BMDDIT': BMDDIT,
      'BMDDIM': BMDDIM,
      'BMDEQC': BMDEQC,
      'BMDAMRE': BMDAMRE,
      'MGKI': MGKI,
      'BMDTX11': BMDTX1,
      'BMDTX22': BMDTX2,
      'BMDTX33': BMDTX3,
      'BMDTXA11': BMDTXA1,
      'BMDTXA22': BMDTXA2,
      'BMDTXA33': BMDTXA3,
      'BMDTXT1': BMDTXT1,
      'BMDTXT2': BMDTXT2,
      'BMDTXT3': BMDTXT3,
      'TDKID': TDKID,
      'TCKID': TCKID,
      'GUIDMT': GUIDMT,
      'TCVL': TCVL,
      'TCRA': TCRA,
      'TCSDID': TCSDID,
      'TCSDSY': TCSDSY,
      'TCID': TCID,
      'TCSY': TCSY,
      'BMDAM_TX': BMDAM_TX,
      'BMDDI_TX': BMDDI_TX,
      'BMDAMT3': BMDAMT3,
      'TCAMT': TCAMT,
     'BMDAM1': BMDAM1,
      'CTMID': CTMID,
      'CIMID': CIMID,
      'SCIDC': SCIDC,
    };
    return map;
  }

  Bil_Mov_D_Local.fromMap(Map<dynamic, dynamic> map) {
    BMKID = map['BMKID'];
    BMMID = map['BMMID'];
    BMDID = map['BMDID'];
    MGNO = map['MGNO'];
    MINO = map['MINO'];
    MUID = map['MUID'];
    BMDAM = map['BMDAM'];
    BMDNO = map['BMDNO'];
    BMDNF = map['BMDNF'];
    BMDED = map['BMDED'];
    BMDEQ = map['BMDEQ'];
    BMDIN = map['BMDIN'];
    BMDDI = map['BMDDI'];
    BMDDIA = map['BMDDIA'];
    BMDDIF = map['BMDDIF'];
    BMDTX = map['BMDTX'];
    BMDIDR = map['BMDIDR'];
    BMDAMR = map['BMDAMR'];
    SIID = map['SIID'];
    BMDDIR = map['BMDDIR'];
    BMDTXA = map['BMDTXA'];
    BMDTXD = map['BMDTXD'];
    BMDTY = map['BMDTY'];
    BMDDIA2 = map['BMDDIA2'];
    BMDDIR2 = map['BMDDIR2'];
    BMDDE = map['BMDDE'];
    BMDAMO = map['BMDAMO'];
    GUID = map['GUID'];
    BMDWE = map['BMDWE'];
    BMDVO = map['BMDVO'];
    BMDVC = map['BMDVC'];
    BMDDD = map['BMDDD'];
    JTID_L = map['JTID_L'];
    SYID_L = map['SYID_L'];
    BIID_L = map['BIID_L'];
    CIID_L = map['CIID_L'];
    CIMNA_D = map['CIMNA_D'];
    GUIDM = map['GUIDM'];
    COUNT_CIMID = map['COUNT_CIMID'];
    SYST = map['SYST'];
    BMDTXAT = map['BMDTXAT'];
    MUNA_D = map['MUNA_D'];
    MINA_D = map['MINA_D'];
    SIIDT = map['SIIDT'];
    BMDEX = map['BMDEX'];
    BMDAML = map['BMDAML'];
    BMDEQC = map['BMDEQC'];
    BMDCB = map['BMDCB'];
    BMDCA = map['BMDCA'];
    MINA = map['MINA'];
    MUNA = map['MUNA'];
     NAM = map['NAM'];
    SUM_BMDTXA = map['SUM_BMDTXA'];
    SUM_BMDAM = map['SUM_BMDAM'];
    SUM_TOTBMDAM = map['SUM_TOTBMDAM'];
    COU = map['COU'];
    COUNT_MINO = map['COUNT_MINO'];
    MUCBC = map['MUCBC'];
    BMDAMT = map['BMDAMT'];
    BMDAMTF = map['BMDAMTF'];
    BMDTXT = map['BMDTXT'];
    BMDDIT = map['BMDDIT'];
    BMDDIM = map['BMDDIM'];
    BMMDIF = map['BMMDIF'];
    BMMDI = map['BMMDI'];
    COUNT_BMDNO = map['COUNT_BMDNO'];
    SUM_BMDAMT = map['SUM_BMDAMT'];
    SUM_BMDTXT = map['SUM_BMDTXT'];
    SUM_BMDTXT1 = map['SUM_BMDTXT1'];
    SUM_BMDTXT2 = map['SUM_BMDTXT2'];
    SUM_BMDTXT3 = map['SUM_BMDTXT3'];
    SUM_AM_TXT_DI = map['SUM_AM_TXT_DI'];
    MITSK = map['MITSK'];
    BMDEQC = map['BMDEQC'];
    BMDAMRE = map['BMDAMRE'];
    MGKI = map['MGKI'];
    MGNA_D = map['MGNA_D'];
    MGNA = map['MGNA'];
    MGNE = map['MGNE'];
    NAM_D = map['NAM_D'];
    BMDTX1 = map['BMDTX11'];
    BMDTX2 = map['BMDTX22'];
    BMDTX3 = map['BMDTX33'];
    BMDTXA1 = map['BMDTXA11'];
    BMDTXA2 = map['BMDTXA22'];
    BMDTXA3 = map['BMDTXA33'];
    BMDTXT1 = map['BMDTXT1'];
    BMDTXT2 = map['BMDTXT2'];
    BMDTXT3 = map['BMDTXT3'];
    TDKID = map['TDKID'];
    TCKID = map['TCKID'];
    GUIDMT = map['GUIDMT'];
    TCVL = map['TCVL'];
    TCRA = map['TCRA'];
    TCSDID = map['TCSDID'];
    TCSDSY = map['TCSDSY'];
    TCID = map['TCID'];
    TCSY = map['TCSY'];
    BMDAM_TX = map['BMDAM_TX'];
    BMDDI_TX = map['BMDDI_TX'];
    BMDAMT3 = map['BMDAMT3'];
    TCAMT = map['TCAMT'];
    QUN_N = map['QUN_N'];
    AM_N = map['AM_N'];
    FR_AM_N = map['FR_AM_N'];
    NAM_V = map['NAM_V'];
    TOT_AM_N = map['TOT_AM_N'];
    TOT_VAT_N = map['TOT_VAT_N'];
    TOT_W_VAT_N = map['TOT_W_VAT_N'];
    VAT_CAT_V = map['VAT_CAT_V'];
    VAT_RAT_N = map['VAT_RAT_N'];
    TAX_EXE_V = map['TAX_EXE_V'];
    DIS_AM_N2 = map['DIS_AM_N2'];
    DIS_COD_V = map['DIS_COD_V'];
    DIS_RES_V = map['DIS_RES_V'];
    TAX_EXE_COD_V = map['TAX_EXE_COD_V'];
    BMDAM1 = map['BMDAM1'];
    CTMID = map['CTMID'];
    CIMID = map['CIMID'];
    SCIDC = map['SCIDC'];

  }

 // List<Map<String, dynamic>> jsonList = Bil_Mov_D_Local.map((e) => e.toJson()).toList();
}
