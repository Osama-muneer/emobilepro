import '../../Setting/controllers/login_controller.dart';

class Fat_Csid_St_Local {
  String? FCIGU;
  int? FCSST;
  String? FCSHA;
  String? SUCH;
  String? DATEU;
  String? DEVU;
  String? STMIDU;
  int? SOMIDU;
  int? JTID_L;
  int? BIID_L;
  int? SYID_L;
  String? CIID_L;


  Fat_Csid_St_Local({this.FCIGU,this.FCSST,this.SUCH,this.DATEU,this.DEVU,this.STMIDU,this.SOMIDU,
    this.JTID_L,this.SYID_L,this.BIID_L,this.CIID_L});


  Map<String, dynamic> toMap() {
    var map = <String, dynamic>{
      'FCIGU': FCIGU,
      'FCSST': FCSST,
      'FCSHA': FCSHA,
      'SUCH': SUCH,
      'DATEU': DATEU,
      'DEVU': DEVU,
      'STMIDU': STMIDU,
      'SOMIDU': SOMIDU,
      'JTID_L': JTID_L ?? LoginController().JTID_L,
      'SYID_L': SYID_L ?? LoginController().SYID_L,
      'BIID_L': BIID_L ?? LoginController().BIID_L,
      'CIID_L': CIID_L ?? LoginController().CIID_L,
    };
    return map;
  }

  Fat_Csid_St_Local.fromMap(Map<dynamic, dynamic> map) {
    FCIGU = map['FCIGU'];
    FCSST = map['FCSST'];
    FCSHA = map['FCSHA'];
    DATEU = map['DATEU'];
    SUCH = map['SUCH'];
    DEVU = map['DEVU'];
    STMIDU = map['STMIDU'];
    SOMIDU = map['SOMIDU'];
    JTID_L = map['JTID_L'];
    SYID_L = map['SYID_L'];
    BIID_L = map['BIID_L'];
    CIID_L = map['CIID_L'];
  }
}
