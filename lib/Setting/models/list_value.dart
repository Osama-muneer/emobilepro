class List_Value {
  String? LVID;
  String? LVNA;
  String? LVNE;
  String? LVTY;
  String? LVNA_D;
  dynamic  SUM_AM;


  List_Value({required this.LVID,required this.LVNA,this.LVNE,this.LVTY});

  Map<String, dynamic> toMap() {
    var map = <String, dynamic>{
      'LVID': LVID,
      'LVNA': LVNA,
      'LVNE': LVNE,
      'LVTY': LVTY,
    };
    return map;
  }

  List_Value.fromMap(Map<dynamic, dynamic> map) {
    LVID = map['LVID'];
    LVNA = map['LVNA'];
    LVNE = map['LVNE'];
    LVTY = map['LVTY'];
    LVNA_D = map['LVNA_D'];
  }

  List_Value.fromMap_SUM(Map<dynamic, dynamic> map) {
    SUM_AM = map['SUM_AM'];
  }

}
