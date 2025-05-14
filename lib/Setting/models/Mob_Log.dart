import 'package:flutter/foundation.dart';

/// A Dart model class representing a record in the MOB_LOG SQLite table.
class MobLog {
  /// Primary key (auto-incremented).
  final int? mlid;

  /// Log type.
  final String mlty;

  /// Date of the log entry.
  final String mldo;

  /// User ID.
  final String suid;

  /// User name.
  final String suna;

  /// Log description.
  final String mlin;

  /// Job type ID (foreign key).
  final int? jtidL;

  /// Business ID (foreign key).
  final int? biidL;

  /// System ID (foreign key).
  final int? syidL;

  /// City ID (foreign key).
  final String ciidL;

  /// SQLite table name.
  static const String tableName = 'MOB_LOG';

  MobLog({
    this.mlid,
    required this.mlty,
    required this.mldo,
    required this.suid,
    required this.suna,
    required this.mlin,
    this.jtidL,
    this.biidL,
    this.syidL,
    required this.ciidL,
  });

  /// Creates a MobLog instance from a map (e.g. fetched from SQLite).
  factory MobLog.fromMap(Map<String, dynamic> map) => MobLog(
    mlid: map['MLID'] as int?,
    mlty: map['MLTY'] as String,
    mldo:map['MLDO'] as String,
    suid: map['SUID'] as String,
    suna: map['SUNA'] as String,
    mlin: map['MLIN'] as String,
    jtidL: map['JTID_L'] as int?,
    biidL: map['BIID_L'] as int?,
    syidL: map['SYID_L'] as int?,
    ciidL: map['CIID_L'] as String,
  );

  /// Converts this MobLog instance into a map for SQLite operations.
  Map<String, dynamic> toMap() {
    final map = <String, dynamic>{
      'MLTY': mlty,
      'MLDO': mldo,
      'SUID': suid,
      'SUNA': suna,
      'MLIN': mlin,
      'JTID_L': jtidL,
      'BIID_L': biidL,
      'SYID_L': syidL,
      'CIID_L': ciidL,
    };
    if (mlid != null) {
      map['MLID'] = mlid;
    }
    return map;
  }

  @override
  String toString() {
    return 'MobLog{mlid: $mlid, mlty: $mlty, mldo: $mldo, suid: $suid, suna: $suna, mlin: $mlin, jtidL: $jtidL, biidL: $biidL, syidL: $syidL, ciidL: $ciidL}';
  }
}
