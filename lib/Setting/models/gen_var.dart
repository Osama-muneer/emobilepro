import 'dart:convert';

class Gen_Var_Local {
  String? DES;
  String? VAL;

  Gen_Var_Local({ this.DES, this.VAL});

  Map<String, dynamic> toMap() {
    var map = <String, dynamic>{
      'DES': DES,
      'VAL': VAL,

    };
    return map;
  }

  Gen_Var_Local.fromMap(Map<dynamic, dynamic> map) {
    DES = map['DES'];
    VAL = map['VAL'];
  }

  String Gen_VarToJson(List<Gen_Var_Local> data) =>
      json.encode(List<dynamic>.from(data.map((x) => x.toMap())));
}
