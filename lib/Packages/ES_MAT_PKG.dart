import '../database/database.dart';

class ES_MAT_PKG {
  final dbHelper = DatabaseHelper();

  Future<double> GET_MAT_UNI_F({
    required String F_MGNO,
    required String F_MINO,
    double F_MUID_F = 0,
    double F_MUID_T = 0,
    double F_NO = 0,
    required int F_TY,
  }) async {
    double ucF = 0;
    double ucT = 0;
    double vN1 = 0;
    double chinNo2 = 0;
    double chinNo = 0;
    double x = 0;


    // تحقق من نوع العملية
    if (F_TY == null) {
      return 0;
    }

    // الحصول على البيانات
    if ([4, 44].contains(F_TY)) {
      if (F_MGNO.isEmpty || F_MINO.isEmpty) {
        return 0;
      }


      // إعادة الوحدة الأساسية للصنف
      if (F_TY == 4) {
        // استعلام للحصول على MAX(MUCID)
        x = await _getMaxMucid(F_MGNO, F_MINO);
      } else {
        // استعلام للحصول على MIN(MUCID)
        x = await _getMinMucid(F_MGNO, F_MINO);
      }

      vN1 = await _getMuid(F_MGNO, F_MINO, x);
      return vN1;
    }


    // تحويل الكميات
    if ([1, 2, 3].contains(F_TY)) {

      if (F_MGNO.isEmpty || F_MINO.isEmpty || F_MUID_F <= 0 || F_MUID_T <= 0) {
        return 0;
      }

      if ([1, 2].contains(F_TY) && F_NO == 0) {
        return 0;
      }

      if (F_MUID_F == F_MUID_T) {
        return (F_TY == 1 || F_TY == 2) ? F_NO : 1;
      }

      ucF = await _getMucidByMuid(F_MGNO, F_MINO, F_MUID_F);
      ucT = await _getMucidByMuid(F_MGNO, F_MINO, F_MUID_T);

      if (ucF == ucT || ucF <= 0 || ucT <= 0) {
        return (F_TY == 1 || F_TY == 2) ? F_NO : 1;
      }

      // تحديد اتجاه التحويل
      bool isFromLargerToSmaller = ucF < ucT;
      double vFrom = isFromLargerToSmaller ? ucF : ucT;
      double vTo = isFromLargerToSmaller ? ucT : ucF;


      // حلقة التحويل
      while (true) {
        chinNo2 = await _getChinNo(F_MGNO, F_MINO, vFrom);
        if (vFrom == vTo) {
          vN1 = _calculateResult(F_TY, vFrom, chinNo, F_NO, isFromLargerToSmaller);
          return double.parse(vN1.toStringAsFixed(9));
        }
        vFrom += 1;
        if (chinNo2 != 0) {
          chinNo = chinNo2 * (chinNo != 0 ? chinNo : 1);
        }

      }
    }

    return 1; // القيمة الافتراضية
  }

  // دوال مساعدة مع استعلامات قاعدة البيانات
  Future<double> _getMaxMucid(String F_MGNO, String F_MINO) async {
    final result = await dbHelper.query(
        'SELECT COALESCE(MAX(MUCID), 0) AS MUCID FROM MAT_UNI_C WHERE MGNO = ? AND MINO = ?',
        [F_MGNO, F_MINO]
    );

    // طباعة النتيجة لمساعدتك في معرفة نوع البيانات
    print("Query result: $result");

    if (result.isNotEmpty) {
      var value = result.first['MUCID'];

      // تحقق من نوع البيانات
      if (value is int) {
        return value.toDouble(); // تحويل int إلى double
      } else if (value is double) {
        return value; // إذا كانت القيمة double بالفعل
      }
    }

    return 0.0; // القيمة الافتراضية
  }

  Future<double> _getMinMucid(String F_MGNO, String F_MINO) async {
    final result = await dbHelper.query('SELECT MIN(MUCID) FROM MAT_UNI_C WHERE MGNO = ? AND MINO = ?', [F_MGNO, F_MINO]);
    return result.isNotEmpty ? result.first['MIN(MUCID)'] as double : 1;
  }

  Future<double> _getMuid(String F_MGNO, String F_MINO, double mucid) async {
    final result = await dbHelper.query(
        ' SELECT COALESCE(MUID, 0) AS MUID FROM MAT_UNI_C WHERE MGNO = ? AND MINO = ? AND MUCID = ?',
        [F_MGNO, F_MINO, mucid]
    );
    return result.isNotEmpty ? (result.first['MUID'] as num).toDouble() : 0.0;
  }

  Future<double> _getMucidByMuid(String F_MGNO, String F_MINO, double muid) async {
    final result = await dbHelper.query(
        'SELECT COALESCE(MUCID, 0) AS MUCID FROM MAT_UNI_C WHERE MGNO = ? AND MINO = ? AND MUID = ?',
        [F_MGNO, F_MINO, muid]
    );
    return result.isNotEmpty ? (result.first['MUCID'] as num).toDouble() : 0.0;
  }

  Future<double> _getChinNo(String F_MGNO, String F_MINO, double mucid) async {
    final result = await dbHelper.query(
        'SELECT COALESCE(MUCNO, 0) AS MUCNO FROM MAT_UNI_C WHERE MGNO = ? AND MINO = ? AND MUCID = ?',
        [F_MGNO, F_MINO, mucid]
    );
    return result.isNotEmpty ? (result.first['MUCNO'] as num).toDouble() : 0.0;
  }

  double _calculateResult(int F_TY, double vFrom, double chinNo, double F_NO, bool isFromLargerToSmaller) {
    // تنفيذ الحسابات اللازمة
    if (F_TY == 1) {
      print('_calculateResult');
      print(isFromLargerToSmaller);
      print(F_NO);
      print(chinNo);
      print((F_NO * chinNo));
      print((F_NO / chinNo));
      print(isFromLargerToSmaller ? (F_NO * chinNo) : (F_NO / chinNo));
      return isFromLargerToSmaller ? (F_NO * chinNo) : (F_NO / chinNo);
    } else if (F_TY == 2) {
      return isFromLargerToSmaller ? (F_NO / chinNo) : (F_NO * chinNo);
    } else if (F_TY == 3) {
      return isFromLargerToSmaller ? chinNo : (1 / chinNo);
    }
    return 0;
  }
}