
class Syn_Tas_Local {
  int? CIID;
  int? JTID;
  int? BIID;
  int? SYID;
  String? STMID;
  String? STKI;
  String? STTY;
  String? STTB;
  String? STDE;
  String? STDE2;
  String? STDE3;
  String? STFU;
  String? STTU;
  int? STFID;
  int? STTID;
  String? STFD;
  String? STTD;
  int? STIM;
  int? STST;
  String? SUID;
  String? DATEI;
  String? DATEU;
  String? SUCH;
  String? DEVI;
  String? DEVU;
  String? GUID;


  Syn_Tas_Local({this.CIID,this.JTID,this.BIID,this.SYID,this.STMID,this.STTB,this.STTY
    ,this.STKI,this.STDE,this.STDE2,this.SUID,this.SUCH,this.DATEI,this.DEVI,this.DATEU,this.DEVU,
    this.GUID});


  Map<String, dynamic> toMap() {
    var map = <String, dynamic>{
      'CIID': CIID,
      'JTID': JTID,
      'BIID': BIID,
      'SYID': SYID,
      'STMID': STMID,
      'STTB': STTB,
      'STTY': STTY,
      'STKI': STKI,
      'STDE': STDE,
      'STDE2': STDE2,
      'STDE3': STDE3,
      'STFU': STFU,
      'STTU': STTU,
      'STFID': STFID,
      'STTID': STTID,
      'STFD': STFD,
      'STTD': STTD,
      'STIM': STIM,
      'STST': STST,
      'SUID': SUID,
      'SUCH': SUCH,
      'DATEI': DATEI,
      'DEVI': DEVI,
      'DATEU': DATEU,
      'DEVU': DEVU,
      'GUID': GUID,
    };
    return map;
  }

  Syn_Tas_Local.fromMap(Map<dynamic, dynamic> map) {
    CIID = map['CIID'];
    JTID = map['JTID'];
    BIID = map['BIID'];
    SYID = map['SYID'];
    STMID = map['STMID'];
    STKI = map['STKI'];
    STTY = map['STTY'];
    STTB = map['STTB'];
    STDE = map['STDE'];
    STDE2 = map['STDE2'];
    STDE3 = map['STDE3'];
    STFU = map['STFU'];
    STTU = map['STTU'];
    STFID = map['STFID'];
    STTID = map['STTID'];
    STFD = map['STFD'];
    STTD = map['STTD'];
    STIM = map['STIM'];
    STST = map['STST'];
    SUID = map['SUID'];
    DATEI = map['DATEI'];
    DATEU = map['DATEU'];
    SUCH = map['SUCH'];
    DEVI = map['DEVI'];
    DEVU = map['DEVU'];
    GUID = map['GUID'];
  }

}
