import '../../Setting/controllers/login_controller.dart';

class Fat_Csid_Inf_D_Local {
  String? FCIGU;
  String? FCIDTY;
  String? FCIDVA;
  String? GUID;
  int? JTID_L;
  int? BIID_L;
  int? SYID_L;
  String? CIID_L;


  Fat_Csid_Inf_D_Local({this.FCIDTY,this.FCIGU,this.FCIDVA,this.GUID,this.JTID_L,this.SYID_L,this.BIID_L,this.CIID_L});


  Map<String, dynamic> toMap() {
    var map = <String, dynamic>{
      'FCIDTY': FCIDTY,
      'FCIGU': FCIGU,
      'FCIDVA': FCIDVA,
      'GUID': GUID,
      'JTID_L': JTID_L ?? LoginController().JTID_L,
      'SYID_L': SYID_L ?? LoginController().SYID_L,
      'BIID_L': BIID_L ?? LoginController().BIID_L,
      'CIID_L': CIID_L ?? LoginController().CIID_L,
    };
    return map;
  }

  Fat_Csid_Inf_D_Local.fromMap(Map<dynamic, dynamic> map) {
    FCIDTY = map['FCIDTY'];
    FCIGU = map['FCIGU'];
    FCIDVA = map['FCIDVA'];
    GUID = map['GUID'];
    JTID_L = map['JTID_L'];
    SYID_L = map['SYID_L'];
    BIID_L = map['BIID_L'];
    CIID_L = map['CIID_L'];
  }
}
