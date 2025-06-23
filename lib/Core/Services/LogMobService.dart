import 'package:sqflite/sqflite.dart';
import 'package:intl/intl.dart';
import '../../Setting/controllers/login_controller.dart';
import '../../Setting/models/Mob_Log.dart';
import '../../database/database.dart';
import 'ToastService.dart';

/// Log types for MobLog entries.
enum LogType { ERR, INF, SUC }

extension LogTypeExtension on LogType {
  String get name {
    switch (this) {
      case LogType.ERR:
        return 'ERR';
      case LogType.INF:
        return 'INF';
      case LogType.SUC:
        return 'SUC';
    }
  }

  /// Select a suitable toast for each log type.
  Future<void> showToast(String message) {
    switch (this) {
      case LogType.SUC:
        return ToastService.showSuccess(message);
      case LogType.ERR:
        return ToastService.showError(message);
      case LogType.INF:
      return ToastService.show(message);
    }
  }
}


/// إدارة سجل MOB_LOG: إدخال، جلب، حذف، وتسجيل مع Toast
class MobLogDatabase {
  MobLogDatabase._();

  // singleton instance
  static final MobLogDatabase instance = MobLogDatabase._();

  // unnamed factory to allow MobLogDatabase() calls
  factory MobLogDatabase() => instance;

  final conn = DatabaseHelper.instance;

  /// إدخال سجل جديد أو تحديثه
  Future<int> insertMobLog(MobLog mobLog) async {
    var db = await conn.database;
    return await db!.insert(
      MobLog.tableName,
      mobLog.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  /// تسجيل حدث: حفظ في القاعدة + عرض Toast
  Future<void> log({
    required LogType type,
    required String detail,
  }) async {
    final timestamp = DateTime.now();
    final entry = MobLog(
      mlty: type.name,
      mldo: timestamp.toString(),
      suid: LoginController().SUID,
      suna: LoginController().SUNA,
      mlin: detail,
      jtidL: LoginController().JTID,
      biidL: LoginController().BIID,
      syidL: LoginController().SYID,
      ciidL: LoginController().CIID,
    );
    await insertMobLog(entry);
    final formatted = DateFormat('dd-MM-yyyy HH:mm').format(timestamp);
   // await type.showToast('[$formatted] $detail');
  }

  /// جلب جميع السجلات
  Future<List<MobLog>> fetchAllMobLogs() async {
    var db = await conn.database;
    final maps = await db!.query(
      MobLog.tableName,
      orderBy: 'MLDO DESC',
    );
    return maps.map((m) => MobLog.fromMap(m)).toList();
  }

  /// حذف سجل بواسطة معرفه
  Future<int> deleteMobLog(int mlid) async {
    var db = await conn.database;
    return await db!.delete(
      MobLog.tableName,
      where: 'MLID = ?',
      whereArgs: [mlid],
    );
  }
}
