class AppPrinterDevice {
  int? id;
  String deviceName;
  String? address;
  String? port;
  String? vendorId;
  String? productId;
  String? typePrinter;
  bool? isBle;
  bool? state;
  String? guid;
  String? suid;
  DateTime? dateI;
  String? devi;
  int? jtidL;
  int? biidL;
  int? syidL;
  String? ciidL;

  AppPrinterDevice({
    this.id,
    required this.deviceName,
    this.address,
    this.port,
    this.vendorId,
    this.productId,
    this.typePrinter,
    this.isBle,
    this.state,
    this.guid,
    this.suid,
    this.dateI,
    this.devi,
    this.jtidL,
    this.biidL,
    this.syidL,
    this.ciidL,
  });

  /// تحويل الكائن إلى خريطة لاستخدامها في SQLite
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'deviceName': deviceName,
      'address': address,
      'port': port,
      'vendorId': vendorId,
      'productId': productId,
      'typePrinter': typePrinter,
      'isBle': isBle == null ? null : (isBle! ? 1 : 0),
      'state': state == null ? null : (state! ? 1 : 0),
      'GUID': guid,
      'SUID': suid,
      'DATEI': dateI?.toIso8601String(),
      'DEVI': devi,
      'JTID_L': jtidL,
      'BIID_L': biidL,
      'SYID_L': syidL,
      'CIID_L': ciidL,
    };
  }

  /// إنشاء كائن من خريطة مسترجعة من SQLite
  factory AppPrinterDevice.fromMap(Map<String, dynamic> map) {
    return AppPrinterDevice(
      id: map['id'] ,
      deviceName: map['deviceName'],
      address: map['address'] ,
      port: map['port'],
      vendorId: map['vendorId'],
      productId: map['productId'],
      typePrinter: map['typePrinter'],
      isBle: map['isBle']== null ? null : (map['isBle'] == 1),
      state: map['state'] == null ? null : (map['state'] == 1),
      guid: map['GUID'] ,
      suid: map['SUID'] ,
      dateI: map['DATEI'],
      devi: map['DEVI'] ,
      jtidL: map['JTID_L'] ,
      biidL: map['BIID_L'],
      syidL: map['SYID_L'] ,
      ciidL: map['CIID_L'] ,
    );
  }
}
