
import '../../Setting/controllers/login_controller.dart';

class Mat_Dis_M_Local {
  int? MDMID;
  int? MDTID;
  int? MDKID;
  var MDMRA;
  int? MDMSM;
  int? MDMCO;
  int? MDMAM;
  int? MDMMN;
  int? MDMCR;
  int? MDMCR2;
  int? MDMCR3;
  int? MDMOI;
  String? MDMFD;
  String? MDMTD;
  int? MDMFDA;
  int? MDMTDA;
  int? MDMFM;
  int? MDMTM;
  int? MDMFY;
  int? MDMTY;
  int? MDMFT;
  int? MDMTT;
  int? MDMDAYT;
  String? MDMDAY;
  int? MDMST;
  String? MDMDE;
  String? MDMRE;
  String? SUID;
  String? GUID;
  String? DATEI;
  String? DEVI;
  String? SUCH;
  String? DATEU;
  String? DEVU;
  int? JTID_L;
  int? BIID_L;
  int? SYID_L;
  String? CIID_L;


  Mat_Dis_M_Local({this.MDMID,this.MDTID,this.MDKID,this.MDMRA,this.MDMSM,this.MDMCO,this.MDMAM,this.MDMMN,this.MDMCR,
    this.MDMCR2,this.MDMCR3,this.MDMOI,this.MDMFD,this.MDMTD,this.MDMFDA, this.MDMTDA,this.MDMFM,this.MDMTM,this.MDMFY,
    this.MDMTY,this.MDMFT,this.MDMTT,this.MDMDAYT,this.MDMDAY,this.MDMST, this.MDMDE,this.MDMRE,this.SUID,
    this.JTID_L,this.SYID_L,this.BIID_L,this.CIID_L, this.GUID,this.DATEI,this.DEVI,this.SUCH,this.DATEU,this.DEVU});
  Map<String, dynamic> toMap() {
    var map = <String, dynamic>{
      'MDMID': MDMID,
      'MDTID': MDTID,
      'MDKID': MDKID,
      'MDMRA': MDMRA,
      'MDMSM': MDMSM,
      'MDMCO': MDMCO,
      'MDMAM': MDMAM,
      'MDMMN': MDMMN,
      'MDMCR': MDMCR,
      'MDMCR2': MDMCR2,
      'MDMCR3': MDMCR3,
      'MDMOI': MDMOI,
      'MDMFD': MDMFD,
      'MDMTD': MDMTD,
      'MDMFDA': MDMFDA,
      'MDMTDA': MDMTDA,
      'MDMFM': MDMFM,
      'MDMTM': MDMTM,
      'MDMFY': MDMFY,
      'MDMTY': MDMTY,
      'MDMFT': MDMFT,
      'MDMTT': MDMTT,
      'MDMDAYT': MDMDAYT,
      'MDMDAY': MDMDAY,
      'MDMST': MDMST,
      'MDMDE': MDMDE,
      'MDMRE': MDMRE,
      'SUID': SUID,
      'GUID': GUID,
      'DATEI': DATEI,
      'DEVI': DEVI,
      'SUCH': SUCH,
      'DATEU': DATEU,
      'DEVU': DEVU,
      'JTID_L': JTID_L ?? LoginController().JTID_L,
      'SYID_L': SYID_L ?? LoginController().SYID_L,
      'BIID_L': BIID_L ?? LoginController().BIID_L,
      'CIID_L': CIID_L ?? LoginController().CIID_L,
    };
    return map;
  }

  Mat_Dis_M_Local.fromMap(Map<dynamic, dynamic> map) {
    MDMID = map['MDMID'];
    MDKID = map['MDKID'];
    MDTID = map['MDTID'];
    MDKID = map['MDKID'];
    MDMRA = map['MDMRA'];
    MDMSM = map['MDMSM'];
    MDMCO = map['MDMCO'];
    MDMAM = map['MDMAM'];
    MDMMN = map['MDMMN'];
    MDMCR = map['MDMCR'];
    MDMCR2 = map['MDMCR2'];
    MDMCR3 = map['MDMCR3'];
    MDMOI = map['MDMOI'];
    MDMFD = map['MDMFD'];
    MDMTD = map['MDMTD'];
    MDMFDA = map['MDMFDA'];
    MDMTDA = map['MDMTDA'];
    MDMFM = map['MDMFM'];
    MDMTM = map['MDMTM'];
    MDMFY = map['MDMFY'];
    MDMTY = map['MDMTY'];
    MDMFT = map['MDMFT'];
    MDMTT = map['MDMTT'];
    MDMDAYT = map['MDMDAYT'];
    MDMDAY = map['MDMDAY'];
    MDMST = map['MDMST'];
    MDMDE = map['MDMDE'];
    MDMRE = map['MDMRE'];
    SUID = map['SUID'];
    GUID = map['GUID'];
    DATEI = map['DATEI'];
    DEVI = map['DEVI'];
    SUCH = map['SUCH'];
    DATEU = map['DATEU'];
    DEVU = map['DEVU'];
    JTID_L = map['JTID_L'];
    SYID_L = map['SYID_L'];
    BIID_L = map['BIID_L'];
    CIID_L = map['CIID_L'];
  }

}
