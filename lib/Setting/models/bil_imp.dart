
import '../../Setting/controllers/login_controller.dart';

class Bil_Imp_Local {
  int? BIID;
  String? BINA;
  String? BINE;
  String? AANO;
  int? BITY;
  int? BIFN;
  int? BITID;
  int? BIST;
  String? BITL;
  String? BIFX;
  String? BIBX;
  String? BIMO;
  String? BIEM;
  String? BIWE;
  String? CWID;
  String? CTID;
  String? BIAD;
  int? BILA;
  int? PKID;
  int? BIAM;
  int? BICT;
  int? SCID;
  int? BIPS;
  String? BIHN;
  String? BIHT;
  String? BIHG;
  String? BIPD;
  String? BIIN;
  String? BIDO;
  String? SUID;
  String? SUCH;
  int? BIDM;
  int? BIID2;
  String? GUID;
  String? BIN3;
  String? BIQN;
  String? BIQND;
  String? BISN;
  String? BISND;
  String? BIBN;
  String? BIBND;
  String? BION;
  String? BIPC;
  String? BIAD2;
  String? BISA;
  String? BISW;
  String? BISWD;
  String? BIAB;
  String? BIABD;
  String? BIAB2;
  String? BIAB2D;
  String? BITX;
  String? BITXG;
  String? BITX2;
  String? BITX2G;
  String? BIC1;
  String? BIC2;
  String? BIC3;
  String? BIC4;
  String? BIC5;
  String? BIC6;
  String? BIC7;
  String? BIC8;
  String? BIC9;
  String? BIC10;
  String? DEVI;
  String? DEVU;
  String? DATEI;
  String? DATEU;
  int? JTID_L;
  int? BIID_L;
  int? SYID_L;
  String? CIID_L;
  String? BINA_D;
  String? BINA_D2;
  String? BILON;
  String? BILAT;

  Bil_Imp_Local({this.BIID,this.BINA,this.BINE,this.AANO,this.SCID,this.BIID2,this.SUID,this.SUCH,this.BIAB,this.BIAB2,
    this.BIAB2D,this.BIABD,this.BIAD,this.BIAD2,this.BIBN,this.BIBND,this.BIBX,this.BIC1,this.DATEI
    ,this.BIC2,this.BIC3,this.BIC4,this.BIC5,this.BIC6,this.BIC7,this.BIC8,this.BIC9,this.BIC10,this.BICT,
     this.BIDM,this.BIDO,this.BIEM,this.BIFN,this.BIFX,this.BIHG,this.BIHN,this.BIHT,this.BIIN,this.BILA,this.BIMO,
    this.BIN3,this.BION,this.BIPC,this.BIPD,this.BIPS,this.BIQN,this.BIQND,this.BISA,this.BISN,this.DATEU,
     this.BISND,this.BIST,this.BISW,this.BISWD,this.BITID,this.BITL,this.BITX,this.BITX2,this.BITX2G,this.BITXG,
     this.BITY,this.BIWE,this.CTID,this.CWID,this.GUID,this.PKID,this.DEVI,this.DEVU,
      this.JTID_L,this.SYID_L,this.BIID_L,this.CIID_L,this.BINA_D,this.BINA_D2,this.BILAT,this.BILON});


  Map<String, dynamic> toMap() {
    var map = <String, dynamic>{
      'BIID': BIID,
      'BINA': BINA,
      'BINE': BINE,
      'AANO': AANO,
      'SCID': SCID,
      'BITY': BITY,
      'BIFN': BIFN,
      'BITID': BITID,
      'BIST': BIST,
      'BITL': BITL,
      'BIFX': BIFX,
      'BIBX': BIBX,
      'BIMO': BIMO,
      'BIAM': BIAM,
      'BIEM': BIEM,
      'BIWE': BIWE,
      'CWID': CWID,
      'CTID': CTID,
      'BIAD': BIAD,
      'BILA': BILA,
      'BIID2': BIID2,
      'PKID': PKID,
      'BIIN': BIIN,
      'BIDM': BIDM,
      'BIHN': BIHN,
      'BIHT': BIHT,
      'BIHG': BIHG,
      'BIPS': BIPS,
      'BIPD': BIPD,
      'BIDO': BIDO,
      'SUID': SUID,
      'SUCH': SUCH,
      'GUID': GUID,
      'BIN3': BIN3,
      'BIQN': BIQN,
      'DATEI': DATEI,
      'BIQND': BIQND,
      'BISN': BISN,
      'BISND': BISND,
      'BIBN': BIBN,
      'BIBND': BIBND,
      'BION': BION,
      'BIPC': BIPC,
      'BIAD2': BIAD2,
      'BISA': BISA,
      'BISW': BISW,
      'BISWD': BISWD,
      'BIAB': BIAB,
      'BIABD': BIABD,
      'BIAB2': BIAB2,
      'DATEU': DATEU,
      'BIAB2D': BIAB2D,
      'BITX': BITX,
      'BITXG': BITXG,
      'BITX2': BITX2,
      'BITX2G': BITX2G,
      'BIC1': BIC1,
      'BIC2': BIC2,
      'BIC3': BIC3,
      'BIC4': BIC4,
      'BIC5': BIC5,
      'BIC6': BIC6,
      'BIC7': BIC7,
      'BIC8': BIC8,
      'BIC9': BIC9,
      'BIC10': BIC10,
      'BICT': BICT,
      'DEVI': DEVI,
      'DEVU': DEVU,
      'BILAT': BILAT,
      'BILON': BILON,
      'JTID_L': JTID_L ?? LoginController().JTID_L,
      'SYID_L': SYID_L ?? LoginController().SYID_L,
      'BIID_L': BIID_L ?? LoginController().BIID_L,
      'CIID_L': CIID_L ?? LoginController().CIID_L,
    };
    return map;
  }

  Bil_Imp_Local.fromMap(Map<dynamic, dynamic> map) {
    BIID = map['BIID'];
    BINA = map['BINA'];
    BINE = map['BINE'];
    AANO = map['AANO'];
    BITY = map['BITY'];
    BIFN = map['BIFN'];
    BITID = map['BITID'];
    BIST = map['BIST'];
    BITL = map['BITL'];
    BIPS = map['BIPS'];
    BIFX = map['BIFX'];
    BIBX = map['BIBX'];
    BIMO = map['BIMO'];
    BIHG = map['BIHG'];
    BIEM = map['BIEM'];
    BIWE = map['BIWE'];
    CWID = map['CWID'];
    CTID = map['CTID'];
    SCID = map['SCID'];
    BIAD = map['BIAD'];
    BIHN = map['BIHN'];
    BIID = map['BIID'];
    BIPD = map['BIPD'];
    BILA = map['BILA'];
    PKID = map['PKID'];
    BIAM = map['BIAM'];
    BIDO = map['BIDO'];
    SUID = map['SUID'];
    BIIN = map['BIIN'];
    BITX = map['BITX'];
    BITX2 = map['BITX2'];
    BITXG = map['BITXG'];
    BITX2G = map['BITX2G'];
    BIBN = map['BIBN'];
    BIBND = map['BIBND'];
    DATEI = map['DATEI'];
    GUID = map['GUID'];
    DEVI = map['DEVI'];
    DEVU = map['DEVU'];
    BIHT = map['BIHT'];
    BIDM = map['BIDM'];
    SUCH = map['SUCH'];
    BISN = map['BISN'];
    BISND = map['BISND'];
    DATEU = map['DATEU'];
    BIID2 = map['BIID2'];
    BIN3 = map['BIN3'];
    BIQN = map['BIQN'];
    BIQND = map['BIQND'];
    BION = map['BION'];
    BIPC = map['BIPC'];
    BIAD2 = map['BIAD2'];
    BISA = map['BISA'];
    BISW = map['BISW'];
    BISWD = map['BISWD'];
    BIAB = map['BIAB'];
    BIC1 = map['BIC1'];
    BIC2 = map['BIC2'];
    BIC3 = map['BIC3'];
    BIC4 = map['BIC4'];
    BIC5 = map['BIC5'];
    BIC6 = map['BIC6'];
    BIC7 = map['BIC7'];
    BIC8 = map['BIC8'];
    BIC9 = map['BIC9'];
    BIC10 = map['BIC10'];
    BILAT = map['BILAT'];
    BILON = map['BILON'];
    JTID_L = map['JTID_L'];
    SYID_L = map['SYID_L'];
    BIID_L = map['BIID_L'];
    CIID_L = map['CIID_L'];
    BINA_D = map['BINA_D'];
    BINA_D2 = map['BINA_D2'];
  }
}
