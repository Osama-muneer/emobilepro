import 'dart:convert';
import '../../Setting/controllers/login_controller.dart';

class Acc_Gro_Local {
  int? AGID;
  String? AGNA;
  String? AGNE;
  int? AGST;
  String? GUID;
  String? DATEI;
  String? DEVI;
  String? SUID;
  String? SUCH;
  String? DATEU;
  String? DEVU;
  int? JTID_L;
  int? BIID_L;
  int? SYID_L;
  String? CIID_L;
  String? AGNA_D;

  Acc_Gro_Local({this.AGID,this.AGNA,this.AGNE,this.AGST,this.JTID_L,this.SYID_L,this.BIID_L,this.CIID_L,this.AGNA_D,
    this.GUID,this.DATEI,this.DEVI,this.SUCH,this.DATEU,this.DEVU,this.SUID});


  Map<String, dynamic> toMap() {
    var map = <String, dynamic>{
      'AGID': AGID,
      'AGNA': AGNA,
      'AGNE': AGNE,
      'AGST': AGST,
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

  Acc_Gro_Local.fromMap(Map<dynamic, dynamic> map) {
    AGID = map['AGID'];
    AGNA = map['AGNA'];
    AGNE = map['AGNE'];
    AGST = map['AGST'];
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
    AGNA_D = map['AGNA_D'];
  }

  String Pay_Kin_toJson(List<Acc_Gro_Local> data) => json.encode(List<dynamic>.from(data.map((x) => x.toMap())));
}
