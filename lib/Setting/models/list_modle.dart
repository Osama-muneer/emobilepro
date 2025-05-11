import 'dart:convert';

class List_Local {
  String? VAL;
  String? NAME;

  List_Local.fromMap(Map<dynamic, dynamic> map) {
    VAL = map['ACNO'];
    NAME = map['ACNA'];
  }

}
