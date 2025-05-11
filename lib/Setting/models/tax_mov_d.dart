import '../../Setting/controllers/login_controller.dart';

class TAX_MOV_T_Local {
  int? TTID;
     String? TMTTY;
     String? TMTNA;
  String? TMTNE;
  String? TMTN3;
  int? TMTID;
  int? TMTST;
  int? TTTP;
  String? ATTID;
  String? TMTMN;
  int? TRTID;
  String? DATEI;
  String? DATEU;
  String? SUID;
  String? SUCH;
  String? DEVI;
  String? DEVU;
  String? GUID;
  int? JTID_L;
  int? BIID_L;
  int? SYID_L;
  String? CIID_L;

  TAX_MOV_T_Local({this.TTID,this.GUID,this.TMTTY,this.TMTNA,this.TMTNE,this.TMTN3,this.TMTID,this.TMTST,
    this.TTTP,this.ATTID,this.TMTMN,this.TRTID,this.SUID,
    this.DATEI,this.DATEU,this.SUCH,this.DEVI,this.DEVU,this.JTID_L,this.SYID_L,this.BIID_L,this.CIID_L});

  Map<String, dynamic> toMap() {
    var map = <String, dynamic>{
      'TTID': TTID,
      'GUID': GUID,
      'TMTTY': TMTTY,
      'TMTNA': TMTNA,
      'TMTNE': TMTNE,
      'TMTN3': TMTN3,
      'TMTID': TMTID,
      'TMTST': TMTST,
      'TTTP': TTTP,
      'ATTID': ATTID,
      'TMTMN': TMTMN,
      'TRTID': TRTID,
      'SUID': SUID,
      'DATEI': DATEI,
      'DATEU': DATEU,
      'SUCH': SUCH,
      'DEVI': DEVI,
      'DEVU': DEVU,
      'JTID_L': JTID_L ?? LoginController().JTID_L,
      'SYID_L': SYID_L ?? LoginController().SYID_L,
      'BIID_L': BIID_L ?? LoginController().BIID_L,
      'CIID_L': CIID_L ?? LoginController().CIID_L,
    };
    return map;
  }

  TAX_MOV_T_Local.fromMap(Map<dynamic, dynamic> map) {
    TTID = map['TTID'];
    GUID = map['GUID'];
    TMTTY = map['TMTTY'];
    TMTNA = map['TMTNA'];
    TMTNE = map['TMTNE'];
    TMTN3 = map['TMTN3'];
    TMTID = map['TMTID'];
    TMTST = map['TMTST'];
    TTTP = map['TTTP'];
    ATTID = map['ATTID'];
    TMTMN = map['TMTMN'];
    TRTID = map['TRTID'];
    SUID = map['SUID'];
    DATEI = map['DATEI'];
    DATEU = map['DATEU'];
    SUCH = map['SUCH'];
    DEVI = map['DEVI'];
    DEVU = map['DEVU'];
    GUID = map['GUID'];
    JTID_L = map['JTID_L'];
    SYID_L = map['SYID_L'];
    BIID_L = map['BIID_L'];
    CIID_L = map['CIID_L'];
  }

}
