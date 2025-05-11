import '../../Setting/controllers/login_controller.dart';

class Tax_Tbl_Lnk_Local {
  int? TTLID;
  int? TTID;
  String? GUID;
  String? TTLNA;
  String? TTLNE;
  String? TTLN3;
  String? STID;
  String? TTLTB;
  String? TTLNO;
  String? TTLNO2;
  String? TTLSY;
  String? TTLNOL;
  String? TTLNO2L;
  String? TTLSY2;
  String? TTLNO2L2;
  String? TTLCO;
  int? TTLST;
  int? TTLLN;
  var TTLHN;
  String? TTLDE;
  int? TTLVB;
  int? TTLVN;
  int? TTLVF;
  String? TTLSN;
  int? TTLUP;
  int? TTLDL;
  int? TTLN1;
  int? TTLN2;
  String? TTLC1;
  String? TTLC2;
  int? ORDNU;
  String? RES;
  String? SUID;
  String? DATEI;
  String? DATEU;
  String? SUCH;
  String? DEVI;
  String? DEVU;
  int? DEFN;
  int? JTID_L;
  int? BIID_L;
  int? SYID_L;
  String? CIID_L;
  String? TTLSYM;
  Tax_Tbl_Lnk_Local({this.TTLID,this.TTID,this.GUID,this.TTLNA,this.TTLNE,this.TTLN3,this.STID,this.TTLTB,
    this.TTLNO,this.TTLNO2,this.TTLSY,this.TTLNOL,this.TTLNO2L,this.TTLSY2,this.TTLNO2L2,this.TTLCO,this.TTLST,this.TTLLN,
    this.TTLHN,this.TTLDE,this.TTLVB,this.TTLVN,this.TTLVF,this.TTLSN,this.TTLUP,this.TTLDL,this.TTLN1,this.TTLN2,
    this.TTLC1,this.TTLC2,this.SUID,this.ORDNU,this.RES,this.DATEI,this.DATEU,this.SUCH,this.DEVI,this.DEVU,this.DEFN,
    this.JTID_L,this.SYID_L,this.BIID_L,this.CIID_L,this.TTLSYM});
  Map<String, dynamic> toMap() {
    var map = <String, dynamic>{
      'TTLID': TTLID,
      'TTID': TTID,
      'GUID': GUID,
      'TTLNA': TTLNA,
      'TTLNE': TTLNE,
      'TTLN3': TTLN3,
      'STID': STID,
      'TTLTB': TTLTB,
      'TTLNO': TTLNO,
      'TTLNO2': TTLNO2,
      'TTLSY': TTLSY,
      'TTLNOL': TTLNOL,
      'TTLNO2L': TTLNO2L,
      'TTLSY2': TTLSY2,
      'TTLNO2L2': TTLNO2L2,
      'TTLCO': TTLCO,
      'TTLST': TTLST,
      'TTLLN': TTLLN,
      'TTLHN': TTLHN,
      'TTLDE': TTLDE,
      'TTLVB': TTLVB,
      'TTLVN': TTLVN,
      'TTLVF': TTLVF,
      'TTLSN': TTLSN,
      'TTLUP': TTLUP,
      'TTLDL': TTLDL,
      'TTLN1': TTLN1,
      'TTLN2': TTLN2,
      'TTLC1': TTLC1,
      'TTLC2': TTLC2,
      'ORDNU': ORDNU,
      'RES': RES,
      'SUID': SUID,
      'DATEI': DATEI,
      'DATEU': DATEU,
      'SUCH': SUCH,
      'DEVI': DEVI,
      'DEVU': DEVU,
      'DEFN': DEFN,
      'TTLSYM': TTLSYM,
      'JTID_L': JTID_L ?? LoginController().JTID_L,
      'SYID_L': SYID_L ?? LoginController().SYID_L,
      'BIID_L': BIID_L ?? LoginController().BIID_L,
      'CIID_L': CIID_L ?? LoginController().CIID_L,
    };
    return map;
  }
  Tax_Tbl_Lnk_Local.fromMap(Map<dynamic, dynamic> map) {
    TTLID = map['TTLID'];
    TTID = map['TTID'];
    GUID = map['GUID'];
    TTLNA = map['TTLNA'];
    TTLNE = map['TTLNE'];
    TTLN3 = map['TTLN3'];
    STID = map['STID'];
    TTLTB = map['TTLTB'];
    TTLNO = map['TTLNO'];
    TTLNO2 = map['TTLNO2'];
    TTLSY = map['TTLSY'];
    TTLNOL = map['TTLNOL'];
    TTLNO2L = map['TTLNO2L'];
    TTLSY2 = map['TTLSY2'];
    TTLNO2L2 = map['TTLNO2L2'];
    TTLCO = map['TTLCO'];
    TTLST = map['TTLST'];
    TTLLN = map['TTLLN'];
    TTLHN = map['TTLHN'];
    TTLDE = map['TTLDE'];
    TTLVB = map['TTLVB'];
    TTLVN = map['TTLVN'];
    TTLVF = map['TTLVF'];
    TTLSN = map['TTLSN'];
    TTLUP = map['TTLUP'];
    TTLDL = map['TTLDL'];
    TTLN1 = map['TTLN1'];
    TTLN2 = map['TTLN2'];
    TTLC1 = map['TTLC1'];
    TTLC2 = map['TTLC2'];
    ORDNU = map['ORDNU'];
    RES = map['RES'];
    SUID = map['SUID'];
    DATEI = map['DATEI'];
    DATEU = map['DATEU'];
    SUCH = map['SUCH'];
    DEVI = map['DEVI'];
    DEVU = map['DEVU'];
    DEFN = map['DEFN'];
    GUID = map['GUID'];
    TTLSYM = map['TTLSYM'];
    JTID_L = map['JTID_L'];
    SYID_L = map['SYID_L'];
    BIID_L = map['BIID_L'];
    CIID_L = map['CIID_L'];
  }

}
