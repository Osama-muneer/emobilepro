import '../../Setting/controllers/login_controller.dart';

class Acc_Tax_T_Local {
  int? ATTID;
  String? ATTNA;
  String? ATTNE;
  String? ATTN3;
  var ATTP1;
  var ATTP1U;
  var ATTP1D;
  var ATTS1;
  var ATTS1U;
  var ATTS1D;
  var ATTP2;
  var ATTP2U;
  var ATTP2D;
  var ATTS2;
  var ATTS2U;
  var ATTS2D;
  var ATTP3;
  var ATTP3U;
  var ATTP3D;
  var ATTS3;
  var ATTS3U;
  var ATTS3D;
  var ATTST;
  int? JTID_L;
  int? BIID_L;
  int? SYID_L;
  String? CIID_L;
  String? ATTNA_D;
  String? GUID;
  String? DATEI;
  String? DEVI;
  String? SUID;
  String? SUCH;
  String? DATEU;
  String? DEVU;

  Acc_Tax_T_Local({this.ATTID,this.ATTNA,this.ATTNE,this.ATTN3,this.ATTP1,this.ATTP1U,this.ATTP1D,this.ATTS1,this.ATTS1U,this.ATTS1D,
    this.ATTP2,this.ATTP2U,this.ATTP2D,this.ATTS2,this.ATTS2U,this.ATTS2D,this.ATTP3,this.ATTP3U,
    this.ATTP3D,this.ATTS3,this.ATTS3U,this.ATTS3D,this.ATTST,this.SYID_L,this.BIID_L,this.CIID_L,this.ATTNA_D,
    this.GUID,this.DATEI,this.DEVI,this.SUCH,this.DATEU,this.DEVU,this.SUID
  });
  Map<String, dynamic> toMap() {
    var map = <String, dynamic>{
      'ATTID': ATTID,
      'ATTNA': ATTNA,
      'ATTNE': ATTNE,
      'ATTN3': ATTN3,
      'ATTP1': ATTP1,
      'ATTP1U': ATTP1U,
      'ATTP1D': ATTP1D,
      'ATTS1': ATTS1,
      'ATTS1U': ATTS1U,
      'ATTS1D': ATTS1D,
      'ATTP2': ATTP2,
      'ATTP2U': ATTP2U,
      'ATTP2D': ATTP2D,
      'ATTS2': ATTS2,
      'ATTS2U': ATTS2U,
      'ATTS2D': ATTS2D,
      'ATTP3': ATTP3,
      'ATTP3U': ATTP3U,
      'ATTP3D': ATTP3D,
      'ATTS3': ATTS3,
      'ATTS3U': ATTS3U,
      'ATTS3D': ATTS3D,
      'ATTST': ATTST,
      'GUID': GUID,
      'DATEI': DATEI,
      'DEVI': DEVI,
      'SUCH': SUCH,
      'DATEU': DATEU,
      'DEVU': DEVU,
      'SUID': SUID,
      'JTID_L': JTID_L ?? LoginController().JTID_L,
      'SYID_L': SYID_L ?? LoginController().SYID_L,
      'BIID_L': BIID_L ?? LoginController().BIID_L,
      'CIID_L': CIID_L ?? LoginController().CIID_L,
    };
    return map;
  }
  Acc_Tax_T_Local.fromMap(Map<dynamic, dynamic> map) {
    ATTID = map['ATTID'];
    ATTNA = map['ATTNA'];
    ATTNE = map['ATTNE'];
    ATTN3 = map['ATTN3'];
    ATTP1 = map['ATTP1'];
    ATTP1U = map['ATTP1U'];
    ATTP1D = map['ATTP1D'];
    ATTS1 = map['ATTS1'];
    ATTS1U = map['ATTS1U'];
    ATTS1D = map['ATTS1D'];
    ATTP2 = map['ATTP2'];
    ATTP2U = map['ATTP2U'];
    ATTP2D = map['ATTP2D'];
    ATTS2 = map['ATTS2'];
    ATTS2U = map['ATTS2U'];
    ATTS2D = map['ATTS2D'];
    ATTP3 = map['ATTP3'];
    ATTP3U = map['ATTP3U'];
    ATTP3D = map['ATTP3D'];
    ATTS3 = map['ATTS3'];
    ATTS3U = map['ATTS3U'];
    ATTS3D = map['ATTS3D'];
    ATTST = map['ATTST'];
    GUID = map['GUID'];
    DATEI = map['DATEI'];
    DEVI = map['DEVI'];
    SUCH = map['SUCH'];
    DATEU = map['DATEU'];
    DEVU = map['DEVU'];
    SUID = map['SUID'];
    JTID_L = map['JTID_L'];
    SYID_L = map['SYID_L'];
    BIID_L = map['BIID_L'];
    CIID_L = map['CIID_L'];
    ATTNA_D = map['ATTNA_D'];
  }

}