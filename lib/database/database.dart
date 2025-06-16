import 'dart:io';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import '../Services/ErrorHandlerService.dart';
import '../Services/ToastService.dart';
import '../Setting/controllers/login_controller.dart';
import '../Setting/controllers/setting_controller.dart';
import '../Widgets/config.dart';

class DatabaseHelper {
  static Database? _database;
  static final DatabaseHelper db = DatabaseHelper._();
  DatabaseHelper._();
  DatabaseHelper.internal();
  static final DatabaseHelper instance = DatabaseHelper.internal();
  factory DatabaseHelper() => instance;
  final  dbname = DBNAME;
  final dbversion = 17;

  Future<Database?> get database async {
    if (_database != null) {
      return _database;
    }
    _database = await initiateDatabase();
    return _database;
  }

  String path = '';

  initiateDatabase() async {
    Directory directory = await getApplicationDocumentsDirectory();
    path = join(directory.path, dbname);
    print(path);
    print('dbname');
    return await openDatabase(path,
        version: dbversion,
        onCreate: onCreate,
        onUpgrade: onUpgrade,
        onDowngrade: onDatabaseDowngradeDelete);
  }

  String CreateCOU_TYP_M = '''
       CREATE TABLE COU_TYP_M (
        CTMID  INTEGER,
  CTMNA  TEXT,
  CTMNE  TEXT,
  CTMN3  TEXT,
  CTMDE  TEXT,
  CTMST  INTEGER,
  MGNO   TEXT,
  MINO   TEXT,
  MUID   INTEGER,
  CTMCR  INTEGER,
  SUID   TEXT,
  SUCH   TEXT,
  DATEI  DATE,
  DATEU  DATE,
  DEVI   TEXT,
  DEVU   TEXT,
  ORDNU  INTEGER,
  DEFN   INTEGER,
  RES    TEXT,
  CTMTY  INTEGER,
  GUID   TEXT ,
  JTID_L INTEGER,
  BIID_L INTEGER,
  SYID_L INTEGER,
  CIID_L TEXT );
''';

  String CreateCOU_INF_M = '''
         CREATE TABLE COU_INF_M (
          CIMID  INTEGER,
  BIID   INTEGER,
  CTMID  INTEGER,
  CIMNA  TEXT,
  CIMNE  TEXT,
  CIMN3  TEXT,
  MGNO   TEXT,
  MINO   TEXT,
  MUID   INTEGER,
  CIMSN  TEXT,
  CIMNP  INTEGER,
  CIMIR  REAL,
  ACNO   TEXT,
  CIMST  INTEGER,
  CIMDE  TEXT,
  ORDNU  INTEGER,
  SIID   INTEGER,
  SUID   TEXT,
  DATEI  DATE,
  DEVI   TEXT,
  SUCH   TEXT,
  DATEU  DATE,
  DEVU   TEXT,
  DEFN   INTEGER,
  RES    TEXT,
  GUID   TEXT,
  SCIDO   INTEGER,
  CIMUS   INTEGER,
  JTID_L INTEGER,
  BIID_L INTEGER,
  SYID_L INTEGER,
  CIID_L TEXT  );
''';

  String CreateCOU_POI_L = '''
         CREATE TABLE COU_POI_L (
          CPLID  INTEGER,
  CIMID  INTEGER,
  BPID   INTEGER,
  CPLST  INTEGER,
  SUID   TEXT,
  DATEI  DATE,
  DEVI   TEXT,
  SUCH   TEXT,
  DATEU  DATE,
  DEVU   TEXT,
  DEFN   INTEGER,
  RES    TEXT,
  GUID   TEXT,
  GUIDF  TEXT ,
         JTID_L INTEGER,
         BIID_L INTEGER,
         SYID_L INTEGER,
         CIID_L TEXT)  ;
''';

  String CreateBIF_COU_M = '''
          CREATE TABLE BIF_COU_M (
   BIID    INTEGER,
  BCMID   INTEGER,
  BCMNO   INTEGER,
  BCMDO   DATE,
  BCMST   INTEGER                            DEFAULT 1,
  SCIDC   INTEGER,
  SCNO    INTEGER,
  BPID    INTEGER,
  BCMFD   DATETIME,
  BCMTD   DATETIME,
  BCMRO   REAL,
  BCMRN   REAL,
  MGNO    TEXT,
  MINO    TEXT,
  MUID    INTEGER,
  SIID    INTEGER,
  BCMRE   TEXT,
  BCMIN   TEXT,
  SCID    INTEGER,
  SCEX    REAL,
  BCMAM   REAL                              DEFAULT 0,
  BCMTX   INTEGER                           DEFAULT 0,
  BCMDI   INTEGER                           DEFAULT 0,
  BCMDIA  INTEGER                           DEFAULT 0,
  BCMTXD  INTEGER                           DEFAULT 0,
  ACID    INTEGER,
  BCMTA   REAL                            DEFAULT 0,
  ACNO    TEXT,
  SUID    TEXT,
  SUCH    TEXT,
  SCEXS   INTEGER,
  BMKIDR  INTEGER,
  BMMIDR  INTEGER,
  AMKIDR  INTEGER,
  AMMIDR  INTEGER,
  BCMAT   INTEGER                            DEFAULT 0,
  BCMAT1  INTEGER                           DEFAULT 0,
  BCMAT2  INTEGER                           DEFAULT 0,
  BCMAT3  INTEGER                           DEFAULT 0,
  BCMTY   INTEGER                          DEFAULT 1,
   CTMID    INTEGER,
  CIMID    INTEGER,
    BCCID1  INTEGER,
  BCCID2  INTEGER,
  BCCID3  INTEGER,
  BCMAM1  REAL,
  BCMAM2  REAL,
  BCMAM3  REAL,
  DATEI   DATE,
  DEVI    TEXT,
  DATEU   DATE,
  DEVU    TEXT,
  BCMPT   INTEGER,
  GUID   TEXT,
    BCMFT TEXT,
  BCMTT TEXT,
    BCMRD    TEXT,
  BCMKI INTEGER DEFAULT 1,
  BCMNR INTEGER ,
    JTID_L INTEGER,
  BIID_L INTEGER,
  SYID_L INTEGER,
  CIID_L TEXT  )   ;
''';

  String CreateCOU_USR = '''
           CREATE TABLE COU_USR (
 CIMID  INTEGER, 
SUID TEXT,
CUIN INTEGER,
CUVI INTEGER,
CUPR INTEGER,
CUDL INTEGER,
CURE INTEGER,
CUAP INTEGER,
CUST INTEGER ,
SUCH   TEXT,
DATEU  DATE,
DEVU   TEXT,
RES TEXT ,
GUID TEXT,
SUID2 TEXT,
DATEI TEXT,
DEVI TEXT,
  JTID_L INTEGER,
  BIID_L INTEGER,
  SYID_L INTEGER,
  CIID_L TEXT   );
''';

  String CreateCOU_RED = '''
        CREATE TABLE COU_RED (
 CIMID  INTEGER,
  CRLR   INTEGER,
  CRLD   DATE,
  CRPR   INTEGER,
  CRPD   DATE,
  GUID   TEXT,
  BPMTY  INTEGER,
  BPMID  INTEGER,
  GUIDF  TEXT,
  BPDID  INTEGER,
  BCMID  INTEGER,
  SUID   TEXT,
  DATEI  DATE,
  DEVI   TEXT,
  SUCH   TEXT,
  DATEU  DATE,
  DEVU   TEXT,
  JTID_L INTEGER,
  BIID_L INTEGER,
  SYID_L INTEGER,
  CIID_L TEXT   ) ;
''';

  String CreateBIF_COU_C = '''
CREATE TABLE BIF_COU_C (
  BCCID   INTEGER,
  BCMID   INTEGER,
  GUIDM    TEXT,
  BCCST   INTEGER            DEFAULT 1,
  SCIDC   INTEGER,
  SCNO    INTEGER,
  CTMID   INTEGER,
  CIMID   INTEGER,
  BCMFD   DATE,
  BCMTD   DATE,
  BCMFT   TEXT,
  BCMTT   TEXT,
  BCMRO   REAL ,
  BCMRN   REAL ,
  SIID    INTEGER,
  BCCIN   TEXT,
  SCID    INTEGER,
  SCEX    REAL,
  BCMAM   REAL  ,
  BCMTX   INTEGER   DEFAULT 0,
  BCMDI   INTEGER   DEFAULT 0,
  BCMDIA  INTEGER   DEFAULT 0,
  BCMTXD  INTEGER   DEFAULT 0,
  ACID    INTEGER,
  BCMTA   REAL   ,
  ACNO    TEXT,
  SUID    TEXT,
  SUCH    TEXT,
  SCEXS   INTEGER,
  BMKIDR  INTEGER,
  BMMIDR  INTEGER,
  AMKIDR  INTEGER,
  AMMIDR  INTEGER,
  BCMAT   INTEGER   DEFAULT 0,
  BCMAT1  INTEGER   DEFAULT 0,
  BCMAT2  INTEGER   DEFAULT 0,
  BCMAT3  INTEGER   DEFAULT 0,
  BCMTY   INTEGER   DEFAULT 1,
  BCCID1  INTEGER,
  BCCID2  INTEGER,
  BCCID3  INTEGER,
  BCMAM1  REAL ,
  BCMAM2  REAL ,
  BCMAM3  REAL ,
  DATEI   DATE   DEFAULT SYSDATE,
  DEVI    TEXT,
  DATEU   DATE,
  DEVU    TEXT,
  BCMPT   INTEGER,
  GUID    TEXT,
  BCMAMSUM  REAL ,
  JTID_L INTEGER,
  BIID_L INTEGER,
  SYID_L INTEGER,
  CIID_L TEXT   )   ;
''';

  String CreateCON_ACC_M = '''
CREATE TABLE CON_ACC_M (
  STMID  TEXT,
  CAMTY  INTEGER,
  SOMID  INTEGER,
  SOMSN  TEXT,
  CAMUS  TEXT,
  CAMST  INTEGER                                 DEFAULT 1,
  CIID   INTEGER,
  JTID   INTEGER,
  BIID   INTEGER,
  SYID   INTEGER,
  ORDNU  INTEGER,
  RES    TEXT,
  SUID   TEXT,
  DATEI  DATE,
  DEVI   TEXT,
  SUCH   TEXT,
  DATEU  DATE,
  DEVU   TEXT,
  GUID   TEXT,
  JTID_L INTEGER,
  BIID_L INTEGER,
  SYID_L INTEGER,
  CIID_L TEXT   )   ;
''';

  String CreateMOB_VAR = '''
     CREATE TABLE MOB_VAR(
         MVID INTEGER ,
         MVNA TEXT ,
         MVVL TEXT ,
         MVVLS TEXT,
         MVST INTEGER DEFAULT 1,
         DATEI  DATE DEFAULT CURRENT_TIMESTAMP,
         DATEU  DATE,
         JTID_L INTEGER,
         BIID_L INTEGER,
         SYID_L INTEGER,
         CIID_L TEXT
         )  ;
''';

  String CreateSYN_SET = '''
     CREATE TABLE SYN_SET(
         STMID    TEXT,
  SSUS     TEXT,
  SSPA     TEXT,
  CIID     INTEGER,
  JTID     INTEGER,
  SSST     INTEGER                               DEFAULT 1,
  SSFD     DATE,
  SSTD     DATE,
  SSCO     TEXT,
  SSIN     TEXT,
  SUID     TEXT,
  SUCH     TEXT,
  DATEI    DATE,
  DATEU    DATE,
  SSWS     TEXT,
  SSLO     INTEGER                               DEFAULT 2,
  SSPAE    INTEGER                               DEFAULT 1,
  SYID     INTEGER,
  GUID     TEXT,
  BIID     INTEGER,
  SSTY     INTEGER                               DEFAULT 2,
  SSCT     INTEGER                               DEFAULT 2,
  SSAN     TEXT,
  SSAK     TEXT,
  SSAS     TEXT,
  SSAT     TEXT,
  SSPW     TEXT,
  SSPT     TEXT,
  SSTKN    INTEGER                               DEFAULT 2,
  SSPO     TEXT,
  SSIP     TEXT,
  SSNCT    INTEGER,
  SSAPITY  INTEGER                               DEFAULT 1,
  SSPAR1   TEXT,
  SSPAR2   TEXT,
  SSOR     TEXT,
  SSME     TEXT                   DEFAULT 'GET',
         JTID_L INTEGER,
         BIID_L INTEGER,
         SYID_L INTEGER,
         CIID_L TEXT
         )  ;
''';
  
  String CreateSYN_OFF_M2 = '''
     CREATE TABLE SYN_OFF_M2(
         STMID   TEXT,
  SOMID   INTEGER,
  SOMTY   INTEGER,
  GUID    TEXT,
  STMIDL  TEXT                     DEFAULT '0',
  SOMIDL  INTEGER,
  SOMTYL  INTEGER,
  GUIDL   TEXT,
  SOMCN   TEXT,
  SOMSN   TEXT,
  SOMOI   TEXT,
  SOMOUN  TEXT,
  SOMON   TEXT,
  SOMCS   TEXT,
  SOMBT   TEXT,
  SOMLD   TEXT,
  SOMJT   TEXT,
  SOMLA   TEXT,
  SOMVN   TEXT,
  SOMCST  INTEGER,
  SOMDI   DATE,
  SOMDE   DATE,
  SOMDC   DATE,
  SOMPK   TEXT,
  SOMCSR  TEXT,
  SOMBST  TEXT,
  SOMSE   TEXT,
  SOMER   TEXT,
  SOMRI   TEXT,
  SOMDM   TEXT,
  SOMAC   INTEGER                                DEFAULT 2,
  SOMOTP  TEXT,
  BIIDT   INTEGER                                DEFAULT 0,
  BIIDV   TEXT,
  BIID    INTEGER,
  SUID    TEXT,
  SUCH    TEXT,
  DATEI   DATE,
  DATEU   DATE,
  DEVI    TEXT,
  DEVU    TEXT,
  ORDNU   INTEGER,
  DEFN    INTEGER                                DEFAULT 2,
  RES     TEXT,
         JTID_L INTEGER,
         BIID_L INTEGER,
         SYID_L INTEGER,
         CIID_L TEXT
         )  ;
''';

  String CreateSYN_OFF_M = '''
     CREATE TABLE SYN_OFF_M(      
  STMID   TEXT,
  SOMID   INTEGER,
  SOMTY   INTEGER                                DEFAULT 2,
  SOMST   INTEGER                                DEFAULT 2,
  SOMNA   TEXT,
  SOMSN   TEXT,
  SOMDE   TEXT,
  SOMIP   TEXT,
  SOMWN   INTEGER,
  SOMDB   TEXT,
  SOMHO   TEXT,
  SOMAP   INTEGER                                DEFAULT 2,
  SOMDO   DATE                                  DEFAULT SYSDATE,
  SOMIN   TEXT,
  SOMDA   DATE,
  SUID    TEXT,
  SOMJD   DATE,
  SOMJN   TEXT,
  SOMMN   INTEGER,
  SOMAC   INTEGER                                DEFAULT 1,
  BIID    INTEGER,
  CIID    TEXT,
  JTID    INTEGER,
  SUCH    TEXT,
  SOMUP   INTEGER,
  SOMUPD  DATE,
  SOMDL   INTEGER,
  SOMDLD  DATE,
  SYID    INTEGER,
  DATEI   DATE,
  DEVI    TEXT,
  DATEU   DATE,
  DEVU    TEXT,
  RES     TEXT,
  GUID    TEXT,
  SOMMOS  INTEGER,
  SOMGUF  TEXT,
  SOMRDS  INTEGER DEFAULT 2,
         JTID_L INTEGER,
         BIID_L INTEGER,
         SYID_L INTEGER,
         CIID_L TEXT
         )  ;
''';

  String CreateECO_VAR = '''
     CREATE TABLE ECO_VAR (
         SVID  INTEGER,
         SVVL TEXT ,
         SVNA TEXT NOT NULL,
         SVNE TEXT,
         SVN3 TEXT,
         SVVLS TEXT,
         SVDO DATETIME,
         SUID TEXT,
         GUID TEXT,
         SUCH TEXT,
         DATEI DATETIME,
         DATEU DATETIME,
         DEVI TEXT,
         DEVU TEXT,
         JTID_L INTEGER,
         BIID_L INTEGER,
         SYID_L INTEGER,
         CIID_L TEXT
         )  ;
''';

  String CreateECO_ACC = '''
     CREATE TABLE ECO_ACC (
         EAID    INTEGER,
  EANA    TEXT,
  EANE    TEXT,
  EAN3    TEXT,
  EAGID   INTEGER,
  JTID    INTEGER,
  BIID    INTEGER,
  SYID    INTEGER,
  BCID    INTEGER,
  AANO    TEXT,
  CWID    INTEGER,
  EATL    TEXT,
  CWID2   INTEGER,
  EATL2   TEXT,
  CTID    INTEGER,
  BAID    INTEGER,
  EASX    INTEGER,
  EAAG    INTEGER,
  EALA    INTEGER                                DEFAULT 1,
  EAEM    TEXT,
  EAST    INTEGER                                DEFAULT 1,
  EADL    INTEGER                                DEFAULT 1,
  EAAD    TEXT,
  EAIN    TEXT,
  EADO    DATE,
  SUID    TEXT,
  EADC    DATE,
  SUCH    TEXT,
  EAUS    TEXT,
  EASC    TEXT,
  EAET    INTEGER                                DEFAULT 1,
  EATLS   TEXT,
  EATL2S  TEXT,
  GUID    TEXT,
  EAUP    INTEGER                                DEFAULT 1,
  DATEI   DATE ,
  DATEU   DATE,
  DEVI    TEXT,
  DEVU    TEXT,
  EATST   INTEGER                                DEFAULT 0,
  EATSV   TEXT,
  EAIMT   TEXT,
  EATST2  INTEGER                                DEFAULT 0,
  EATSV2  TEXT,
  EAIMT2  TEXT,
  RES     TEXT,
  GUIDF   TEXT,
         JTID_L INTEGER,
         BIID_L INTEGER,
         SYID_L INTEGER,
         CIID_L TEXT
         )  ;
''';

  String CreateECO_MSG_ACC = '''
     CREATE TABLE ECO_MSG_ACC (
         EMID   TEXT,
         EAID   INTEGER,
         EMAST  INTEGER,
         EMADL  INTEGER,
         GUID   TEXT,
         JTID_L INTEGER,
         BIID_L INTEGER,
         SYID_L INTEGER,
         CIID_L TEXT
         )  ;
''';

  String CreateBK_INF = '''
     CREATE TABLE BK_INF (
         BIID   INTEGER PRIMARY KEY AUTOINCREMENT,
         BITY   TEXT,
         BIUR   TEXT,
         BIZI   TEXT,
         BIDA  TEXT,
         BITI  TEXT,
         JTID_L INTEGER,
         BIID_L INTEGER,
         SYID_L INTEGER,
         CIID_L TEXT
         )  ;
''';

  String CreateBIF_TRA_TBL = '''
     CREATE TABLE BIF_TRA_TBL (
         BTTID   INTEGER primary key autoincrement,
         RSIDO   INTEGER ,
         RTIDO   TEXT,
         RSIDN   INTEGER ,
         RTIDN   TEXT,
         BTTST  INTEGER DEFAULT 2,
         GUIDF   TEXT,
         GUID  TEXT,
         BTTDE  TEXT,
         STMIDI TEXT,
         SOMIDI INTEGER,
         SUID    TEXT,
         DATEI   DATE ,
         DEVI    TEXT,
         JTID_L INTEGER,
         BIID_L INTEGER,
         SYID_L INTEGER,
         CIID_L TEXT
         )  ;
''';

  String CreateAppPrinterDevice = '''
  CREATE TABLE AppPrinterDevice(
  id INTEGER PRIMARY KEY AUTOINCREMENT,
  deviceName TEXT NOT NULL,
  address TEXT,
  port TEXT,
  vendorId TEXT,
  productId TEXT,
  typePrinter TEXT,
  isBle INTEGER,
  state INTEGER,
         GUID  TEXT,
         SUID    TEXT,
         DATEI   DATE ,
         DEVI    TEXT,
         JTID_L INTEGER,
         BIID_L INTEGER,
         SYID_L INTEGER,
         CIID_L TEXT
         )  ;
''';

  String CreateMOB_LOG = '''
  CREATE TABLE MOB_LOG(
  MLID INTEGER PRIMARY KEY AUTOINCREMENT,
  MLTY TEXT,
  MLDO  DATE,
  SUID  TEXT,
  SUNA  TEXT,
  MLIN  TEXT,
  JTID_L INTEGER,
  BIID_L INTEGER,
  SYID_L INTEGER,
  CIID_L TEXT
  ) 
''';

  // دالة مساعدة لتحويل القيمة إلى صيغة مناسبة لـ SQL
  String toSqlValue(dynamic value) {
    if (value == null) return 'null';
    if (value is String) {
      // هروب أي علامة اقتباس مفردة داخل النص
      String escaped = value.replaceAll("'", "''");
      return "'$escaped'";
    }
    return value.toString();
  }

  Future<void> InsertMobVar(Database db) async {
    // قائمة البيانات للإدخال
    final List<Map<String, dynamic>> data = [
      {
        'MVID': 1,
        'MVNA': 'عدد السجلات للمزامنه',
        'MVVL': 150,
        'MVVLS': 150
      },
      {
        'MVID': 2,
        'MVNA': 'S.N.M',
        'MVVL': null,
        'MVVLS': null
      },
      {
        'MVID': 3,
        'MVNA': 'SUID',
        'MVVL': null,
        'MVVLS': null
      },
      {
        'MVID': 4,
        'MVNA': 'SYDV_ID',
        'MVVL': null,
        'MVVLS': null
      },
      {
        'MVID': 5,
        'MVNA': 'SYDV_NO',
        'MVVL': null,
        'MVVLS': null
      },
      {
        'MVID': 6,
        'MVNA': 'DBVersion',
        'MVVL': dbversion,
        'MVVLS': dbversion
      },
      {
        'MVID': 7,
        'MVNA': 'اصدار التطبيق',
        'MVVL': SYDV_APPV.toString(),
        'MVVLS': SYDV_APPV.toString()
      },

      {
        'MVID': 21,
        'MVNA': 'استخدام التوقيع',
        'MVVL': 0,
        'MVVLS': 0
      },
      {
        'MVID': 22,
        'MVNA': 'اظهار تنبيه بالتوقيع قبل الطباعه',
        'MVVL': 0,
        'MVVLS': 0
      },
    ];

    // تنفيذ الإدخالات باستخدام حلقة
    for (var item in data) {
      await db.execute('''
      INSERT INTO MOB_VAR (MVID, MVNA, MVVL, MVVLS, JTID_L, BIID_L, SYID_L, CIID_L)
      VALUES (
        ${item['MVID']},
        '${item['MVNA']}',
        ${toSqlValue(item['MVVL'])},
        ${toSqlValue(item['MVVLS'])},
        ${LoginController().JTID},
        ${LoginController().BIID},
        ${LoginController().SYID},
        '${LoginController().CIID}'
      )
    ''');
    }
  }

  Future<void> InsertMobVar2(Database db) async {
    // قائمة البيانات للإدخال
    final List<Map<String, dynamic>> data = [
      {
        'MVID': 8,
        'MVNA': 'IP',
        'MVVL': LoginController().IP.toString(),
        'MVVLS': StringIP.toString()
      },
      {
        'MVID': 9,
        'MVNA': 'PORT',
        'MVVL': LoginController().PORT.toString(),
        'MVVLS': StringPort.toString()
      },
      {
        'MVID': 10,
        'MVNA': 'URL',
        'MVVL': LoginController().baseApi.toString(),
        'MVVLS': baseApi.toString()
      },
      {
        'MVID': 11,
        'MVNA': 'DEV_NAME',
        'MVVL': LoginController().DeviceName.toString(),
        'MVVLS': null
      },

      {
        'MVID': 23,
        'MVNA': 'النموذج الافتراضي للشاشه الرئيسيه',
        'MVVL': StteingController().Standard_Form.toString(),
        'MVVLS': '1'
      },
      {
        'MVID': 24,
        'MVNA': 'حجم الخط',
        'MVVL': StteingController().Size_Font,
        'MVVLS': '1'
      },
      {
        'MVID': 25,
        'MVNA': 'تفعيل ميزه التفاعل عند الانتقال بين الشاشات',
        'MVVL': StteingController().isActivateInteractionScreens == true ? '1' : '2',
        'MVVLS': '1'
      },
      {
        'MVID': 26,
        'MVNA': 'مزامنه الحركات بشكل تلقائي عند حفظ الحركه',
        'MVVL': StteingController().isActivateAutoMoveSync == true ? '1' : '2',
        'MVVLS': '1'
      },
      {
        'MVID': 27,
        'MVNA': 'اظهار شاشة الدفع',
        'MVVL': StteingController().Show_Inv_Pay == true ? '1' : '2',
        'MVVLS': '1'
      },
      {
        'MVID': 28,
        'MVNA': 'استخدام الباركود',
        'MVVL': StteingController().isSwitchBrcode == true ? '1' : '2',
        'MVVLS': '2'
      },
      {
        'MVID': 29,
        'MVNA': 'استخدام المجموعات',
        'MVVL': StteingController().isSwitchUse_Gro == true ? '1' : '2',
        'MVVLS': '2'
      },
      {
        'MVID': 30,
        'MVNA': 'تثبيت المحصل/المندوب',
        'MVVL': StteingController().Install_BDID == true ? '1' : '2',
        'MVVLS': '2'
      },
      {
        'MVID': 31,
        'MVNA': 'تعدد المخازن في فاتورة المبيعات',
        'MVVL': StteingController().MULTI_STORES_BO == true ? '1' : '2',
        'MVVLS': '2'
      },
      {
        'MVID': 32,
        'MVNA': 'تعدد المخازن في فاتورة المشتريات',
        'MVVL': StteingController().MULTI_STORES_BI == true ? '1' : '2',
        'MVVLS': '2'
      },
      {
        'MVID': 33,
        'MVNA': 'عرض الاصناف على شكل جدول في الفاتورة',
        'MVVL': StteingController().SHOW_ITEM == true ? '1' : '2',
        'MVVLS': '1'
      },
      {
        'MVID': 34,
        'MVNA': 'عرض الاصناف على شكل كرت في الفاتورة',
        'MVVL': StteingController().SHOW_ITEM_C == true ? '1' : '2',
        'MVVLS': '2'
      },
      {
        'MVID': 35,
        'MVNA': 'تضمين الحركات الغير نهايئة في الرصيد',
        'MVVL': StteingController().PRINT_BALANCE == true ? '1' : '2',
        'MVVLS': '2'
      },
      {
        'MVID': 36,
        'MVNA': 'اظهار تنبيه للتضمين الرصيد عند الطباعة',
        'MVVL': StteingController().PRINT_BALANCE_ALERT == true ? '1' : '2',
        'MVVLS': '2'
      },
      {
        'MVID': 37,
        'MVNA': 'طباعة رصيد العميل بعد كل فاتوره',
        'MVVL': StteingController().Print_Balance == true ? '1' : '2',
        'MVVLS': '2'
      },
      {
        'MVID': 38,
        'MVNA': 'اظهار رصيد الحساب عند طباعة السندات',
        'MVVL': StteingController().Print_Balance_Pay == true ? '1' : '2',
        'MVVLS': '2'
      },
      {
        'MVID': 39,
        'MVNA': 'اخفاء التنبيه عند طباعة التقارير الغير نهائية',
        'MVVL': StteingController().SHOW_ALTER_REP == true ? '1' : '2',
        'MVVLS': '2'
      },
      {
        'MVID': 40,
        'MVNA': 'التنبيه عند وجود مديونية على العميل في المبيعات',
        'MVVL': StteingController().ALR_CUS_DEBT_SAL == true ? '1' : '2',
        'MVVLS': '2'
      },
      {
        'MVID': 41,
        'MVNA': 'الهامش العلوي',
        'MVVL': StteingController().TOP_MARGIN.toString(),
        'MVVLS': '2.5'
      },
      {
        'MVID': 42,
        'MVNA': 'الهامش السفلي',
        'MVVL': StteingController().BOTTOM_MARGIN.toString(),
        'MVVLS': '2.5'
      },
      {
        'MVID': 43,
        'MVNA': 'الهامش الأيسر',
        'MVVL': StteingController().LEFT_MARGIN.toString(),
        'MVVLS': '2.5'
      },
      {
        'MVID': 44,
        'MVNA': 'الهامش الأيمن',
        'MVVL': StteingController().RIGHT_MARGIN.toString(),
        'MVVLS': '2.5'
      },
      {
        'MVID': 45,
        'MVNA': 'حجم الخط',
        'MVVL': StteingController().FONT_SIZE_PDF.toString(),
        'MVVLS': '9.0'
      },
      {
        'MVID': 46,
        'MVNA': 'عدد النسخ',
        'MVVL': StteingController().NUMBER_COPIES_REP.toString(),
        'MVVLS': '1'
      },
      {
        'MVID': 47,
        'MVNA': 'طباعة الفاتورة',
        'MVVL': StteingController().isPrint == true ? '1' : '2',
        'MVVLS': '1'
      },
      {
        'MVID': 48,
        'MVNA': 'طباعة السند',
        'MVVL': StteingController().isPrint_VOU == true ? '1' : '2',
        'MVVLS': '2'
      },
      {
        'MVID': 49,
        'MVNA': 'عرض رأس التقرير',
        'MVVL': StteingController().SHOW_REP_HEADER == true ? '1' : '2',
        'MVVLS': '1'
      },
      {
        'MVID': 50,
        'MVNA': 'تكرار رأس التقرير',
        'MVVL': StteingController().REPEAT_REP_HEADER == true ? '1' : '2',
        'MVVLS': '1'
      },
      {
        'MVID': 51,
        'MVNA': 'تكرار تذليل التوقيع',
        'MVVL': StteingController().REPEAT_SIN_FOOTER == true ? '1' : '2',
        'MVVLS': '2'
      },
      {
        'MVID': 52,
        'MVNA': 'طباعة شعار المنشأة',
        'MVVL': StteingController().Print_Image == true ? '1' : '2',
        'MVVLS': '2'
      },
      {
        'MVID': 53,
        'MVNA': 'اظهار رقم الصنف عند طباعة الفاتورة',
        'MVVL': StteingController().Show_MINO == true ? '1' : '2',
        'MVVLS': '2'
      },
      {
        'MVID': 54,
        'MVNA': 'اظهار تسلسل الصنف عند طباعة الفاتورة',
        'MVVL': StteingController().Show_BMDID == true ? '1' : '2',
        'MVVLS': '2'
      },
      {
        'MVID': 55,
        'MVNA': 'استخدام طريقة اخرى للربط مع الطابعة',
        'MVVL': StteingController().Type_Print == true ? '1' : '2',
        'MVVLS': '2'
      },
      {
        'MVID': 56,
        'MVNA': 'اسم الطابعة',
        'MVVL': StteingController().Printer,
        'MVVLS': null
      },
      {
        'MVID': 57,
        'MVNA': 'address Printer',
        'MVVL': StteingController().Printer_Name,
        'MVVLS': null
      },
      {
        'MVID': 58,
        'MVNA': 'حجم ورق الطابعه',
        'MVVL': StteingController().Thermal_printer_paper_size,
        'MVVLS': '58'
      },
      {
        'MVID': 59,
        'MVNA': 'اسم حجم ورق الطابعه',
        'MVVL': StteingController().Thermal_printer_paper_size_Name,
        'MVVLS': '58 mm حراري'
      },
      {
        'MVID': 60,
        'MVNA': 'نوع النموذج الحراري',
        'MVVL': StteingController().Type_Model.toString(),
        'MVVLS': '1'
      },
      {
        'MVID': 61,
        'MVNA': 'اسم نوع النموذج الحراري',
        'MVVL': StteingController().Type_Model_Name.toString(),
        'MVVLS': 'النموذج الاول'
      },
      {
        'MVID': 62,
        'MVNA': 'تفعيل الواتس',
        'MVVL': StteingController().WAT_ACT == true ? '1' : '2',
        'MVVLS': '2'
      },
      {
        'MVID': 63,
        'MVNA': 'اظهار تنبيه عند ارسال رسالة واتس',
        'MVVL': StteingController().USE_WAT_ALERT == true ? '1' : '2',
        'MVVLS': '2'
      },
    ];

    // تنفيذ الإدخالات باستخدام حلقة
    for (var item in data) {
      await db.execute('''
      INSERT INTO MOB_VAR (MVID, MVNA, MVVL, MVVLS, JTID_L, BIID_L, SYID_L, CIID_L)
      VALUES (
        ${item['MVID']},
        '${item['MVNA']}',
        ${toSqlValue(item['MVVL'])},
        ${toSqlValue(item['MVVLS'])},
        ${LoginController().JTID},
        ${LoginController().BIID},
        ${LoginController().SYID},
        '${LoginController().CIID}'
      )
    ''');
    }
  }

  Future onCreate(Database db, int dbversion) async {


    await db.execute('''
     CREATE TABLE SYS_USR (
      SUID TEXT NOT NULL,
      SUNA TEXT NOT NULL,
      SUNE TEXT,
      SUPA TEXT,
      SULA INTEGER,
      SUST INTEGER,
      SUCP DATETIME,
      SUAC INTEGER,
      SUDA DATETIME,
      SUJO TEXT,
      SUEM TEXT,
      SUTL TEXT,
      SUMO TEXT,
      SUFX TEXT,
      SUAD TEXT,
      SUEX INTEGER DEFAULT 1,
      BIID INTEGER,
      GUID TEXT,
      SUCH TEXT,
      DATEI DATETIME,
      DATEU DATETIME,
      DEVI TEXT,
      DEVU TEXT,
      JTID_L INTEGER,
      BIID_L INTEGER,
      SYID_L INTEGER,
      CIID_L TEXT
    ) 
      ''');
    await db.execute('''
     CREATE TABLE SYS_USR_P (
      JTID INTEGER,
      BIID INTEGER,
      SYID INTEGER,
      SUID TEXT,
      SUNA TEXT,
      SUNE TEXT,
      SUPA TEXT,
      SULA INTEGER,
      SUST INTEGER,
      SUCP DATETIME,
      GUID TEXT,
      SUCH TEXT,
      DATEI DATETIME,
      DATEU DATETIME,
      DEVI TEXT,
      DEVU TEXT
    ) 
      ''');
    await db.execute('''
     CREATE TABLE JOB_TYP (
      JTID INTEGER NOT NULL,
      JTNA TEXT NOT NULL,
      JTNE TEXT,
      JTST INTEGER DEFAULT 1,
      JTDO DATETIME,
      GUID TEXT,
      SUID TEXT,
      SUCH TEXT,
      DATEI DATETIME,
      DATEU DATETIME,
      DEVI TEXT,
      DEVU TEXT
    ) 
      ''');
    await db.execute('''
     CREATE TABLE SYS_YEA (
      SYID INTEGER NOT NULL,
      SYSD DATE NOT NULL,
      SYED DATE NOT NULL,
      SYOD DATETIME NOT NULL,
      SYOU TEXT,
      SYCD DATE,
      SYCU TEXT,
      SYST INTEGER,
      SYAC TEXT,
      SYNO TEXT,
      SUID TEXT,
      DATEI DATE DEFAULT CURRENT_TIMESTAMP,
      DEVI TEXT,
      SUCH TEXT,
      DATEU DATE,
      DEVU TEXT,
      DEFN INTEGER DEFAULT 2,
      GUID TEXT
    ) 
      ''');
    await db.execute('''
     CREATE TABLE BRA_YEA (
      JTID INTEGER ,
      BIID INTEGER ,
      SYID INTEGER ,
      BYST INTEGER ,
      JTID_L INTEGER,
      BIID_L INTEGER,
      SYID_L INTEGER,
      CIID_L TEXT,
      GUID TEXT,
      SUID TEXT,
      SUCH TEXT,
      DATEI DATETIME,
      DATEU DATETIME,
      DEVI TEXT,
      DEVU TEXT
    ) 
      ''');
    await db.execute('''
     CREATE TABLE SYS_TYP (
      STID TEXT NOT NULL,
      STNA TEXT NOT NULL,
      STNE TEXT,
      STST INTEGER DEFAULT 2,
      STN3 TEXT,
      STBT TEXT,
      ORDNU INTEGER DEFAULT NULL,
      STAC INTEGER DEFAULT 1
    ) 
      ''');
    await db.execute('''
     CREATE TABLE SYS_SCR (
      SSID INTEGER NOT NULL,
      SSNA TEXT NOT NULL,
      SSNE TEXT,
      SSDA TEXT,
      SSDE TEXT,
      SSDAS TEXT,
      SSDES TEXT,
      SSD3 TEXT,
      SSD3S TEXT,
      STMID INTEGER,
      SUCH TEXT,
      DATEU DATETIME,
      DEVU TEXT,
      SSIM TEXT,
      SSIMS TEXT,
      SSIC TEXT,
      SSICS TEXT,
      GUID TEXT,
      SUID TEXT,
      DATEI DATETIME,
      DEVI TEXT,
      SSST2 INTEGER  DEFAULT 2,
      JTID_L INTEGER,
      BIID_L INTEGER,
      SYID_L INTEGER,
      CIID_L TEXT
    ) 
      ''');
    await db.execute('''
     CREATE TABLE SYS_COM (
      SCID INTEGER NOT NULL,
      SCNA TEXT NOT NULL,
      SCNE TEXT,
      CWID TEXT,
      CTID TEXT,
      SCHO TEXT,
      SCTL TEXT,
      SCMO TEXT,
      SCFX TEXT,
      SCAD TEXT,
      SCWE TEXT,
      SCEM TEXT,
      SCIN TEXT,
      SCBR TEXT,
      SCFA TEXT,
      SCTW TEXT,
      SCYO TEXT,
      SCIS TEXT,
      SCWA TEXT,
      SCQQ TEXT,
      SCC1 TEXT,
      SCC2 TEXT,
      GUID TEXT,
      SUID TEXT,
      SUCH TEXT,
      DATEI DATETIME,
      DATEU DATETIME,
      DEVI TEXT,
      DEVU TEXT
    ) 
      ''');
    await db.execute('''
     CREATE TABLE BRA_INF (
      JTID INTEGER NOT NULL,
      BIID INTEGER NOT NULL,
      BINA TEXT NOT NULL,
      BINE TEXT,
      BIDO DATE,
      BIST INTEGER  DEFAULT 1,
      CWID TEXT,
      CTID TEXT,
      BITL TEXT,
      BIAD TEXT,
      BIMO TEXT,
      BIFX TEXT,
      BIBX TEXT,
      BIEM TEXT,
      BIWE TEXT,
      BINO TEXT,
      BIIN TEXT,
      SUID TEXT,
      GUID TEXT,
      SUCH TEXT,
      DATEI DATETIME,
      DATEU DATETIME,
      DEVI TEXT,
      DEVU TEXT,
      JTID_L INTEGER,
      BIID_L INTEGER,
      SYID_L INTEGER,
      CIID_L TEXT
    ) 
      ''');
    await db.execute('''
         CREATE TABLE MAT_GRO (
         MGNO TEXT NOT NULL,
         MGNA TEXT NOT NULL,
         MGNE TEXT,
         MGN3 TEXT,
         MGTY INTEGER DEFAULT 2,
         MOID INTEGER,
         MGKI INTEGER  DEFAULT 1,
         MGST INTEGER  DEFAULT 1,
         MGNF TEXT,
         MGIN TEXT,
         MGED INTEGER  DEFAULT 2,
         MGSN INTEGER  DEFAULT 2,
         MGBC INTEGER  DEFAULT 2,
         MGPN INTEGER  DEFAULT 2,
         MGMA INTEGER  DEFAULT 2,
         MGFN INTEGER  DEFAULT 2,
         MGTP INTEGER  DEFAULT 2,
         MGTS INTEGER  DEFAULT 2,
         MGGR INTEGER  DEFAULT 2,
         MGDO DATE,
         ORDNU INTEGER  DEFAULT 0,
         STMID INTEGER  DEFAULT 1,
         SUID TEXT,
         DATEI DATETIME DEFAULT CURRENT_TIMESTAMP,
         DEVI TEXT,
         SUCH TEXT,
         DATEU DATETIME,
         DEVU TEXT,
         DEFN INTEGER  DEFAULT 2,
         RES TEXT,
         GUID TEXT,
         JTID_L INTEGER,
         BIID_L INTEGER,
         SYID_L INTEGER,
         CIID_L TEXT
         ) ''');
    await db.execute('''
         CREATE TABLE MAT_INF (
         MGNO TEXT NOT NULL,
         MINO TEXT NOT NULL,
         MINA TEXT ,
         MINE TEXT,
         MIN3 TEXT,
         BIID INTEGER,
         MUIDP INTEGER,
         MUIDS INTEGER,
         MIST INTEGER DEFAULT 1,
         MIED INTEGER DEFAULT 2,
         MITP REAL,
         MITS REAL,
         MIMX INTEGER,
         MIMI INTEGER,
         MION INTEGER,
         MISP INTEGER DEFAULT 2,
         MIDI INTEGER DEFAULT 1,
         MIGP INTEGER,
         MIGS INTEGER,
         MIDN INTEGER,
         MIPN TEXT,
         MIPNC TEXT,
         MIIN TEXT,
         MIUS TEXT,
         MICO TEXT,
         MIPC TEXT,
         CWID TEXT,
         CWIDP TEXT,
         MIIM BLOB,
         MIDO DATETIME DEFAULT CURRENT_TIMESTAMP,
         SUID TEXT,
         MITPK INTEGER DEFAULT 0,
         MITSK INTEGER DEFAULT 0,
         ORDNU INTEGER DEFAULT 0,
         STMID INTEGER DEFAULT 1,
         DATEI DATETIME DEFAULT CURRENT_TIMESTAMP,
         DEVI TEXT,
         SUCH TEXT,
         DATEU DATETIME,
         DEVU TEXT,
         RES TEXT,
         GUID TEXT,
         JTID_L INTEGER,
         BIID_L INTEGER,
         SYID_L INTEGER,
         CIID_L TEXT
         )  
      ''');
    await db.execute('''
         CREATE TABLE MAT_INF_D (
         MGNO TEXT NOT NULL,
         MINO TEXT NOT NULL,
         MAT_CON TEXT,
         SHORT_NAME TEXT,
         MAT_WEIGHT REAL,
         MAT_MODEL TEXT,
         MAT_NOTE TEXT,
         MAT_KIN TEXT,
         MAT_TEST INTEGER,
         MAT_REP_TYP TEXT,
         MISN INTEGER DEFAULT 2,
         MISL INTEGER DEFAULT 0,
         MIPV INTEGER DEFAULT 1,
         MIAD INTEGER DEFAULT 2,
         MIDPI TEXT,
         MIDPI2 TEXT,
         MIDPI3 TEXT,
         MIFR INTEGER  DEFAULT 2,
         MAT_WEIGHT_YES INTEGER  DEFAULT 2,
         GUID TEXT,
         SUID TEXT,
         SUCH TEXT,
         DATEI DATETIME,
         DATEU DATETIME,
         DEVI TEXT,
         DEVU TEXT,
         JTID_L INTEGER,
         BIID_L INTEGER,
         SYID_L INTEGER,
         CIID_L TEXT
         )  
      ''');
    await db.execute('''
         CREATE TABLE MAT_UNI (
         MUID INTEGER NOT NULL,
         MUNA TEXT NOT NULL,
         MUNE TEXT,
         MUN3 TEXT,
         MUTY TEXT,
         MUST INTEGER DEFAULT 1,
         ORDNU INTEGER,
         SUID TEXT,
         DATEI DATETIME DEFAULT CURRENT_TIMESTAMP,
         DEVI TEXT,
         SUCH TEXT,
         DATEU DATETIME,
         DEVU TEXT,
         DEFN INTEGER  DEFAULT 2,
         RES TEXT,
         GUID TEXT,
         JTID_L INTEGER,
         BIID_L INTEGER,
         SYID_L INTEGER,
         CIID_L TEXT
         )  
      ''');
    await db.execute('''
         CREATE TABLE MAT_UNI_C (
         MGNO TEXT  NULL,
         MINO TEXT NOT NULL,
         MUID INTEGER NOT NULL,
         MUCID INTEGER,
         MUCNO REAL,
         MUCBC TEXT,
         MUCBT INTEGER DEFAULT 1,
         MUIDA INTEGER,
         MUCDO DATE,
         MUCNA TEXT,  
         MUCNE TEXT,  
         MUCN3 TEXT,  
         GUID TEXT,  
         SUID TEXT,
         SUCH TEXT,
         DATEI DATETIME,
         DATEU DATETIME,
         DEVI TEXT,
         DEVU TEXT,
         JTID_L INTEGER,
         BIID_L INTEGER,
         SYID_L INTEGER,
         CIID_L TEXT
         )  
      ''');
    await db.execute('''
           CREATE TABLE MAT_UNI_B (
         MGNO TEXT NOT NULL,
         MINO TEXT NOT NULL,
         MUID INTEGER NOT NULL,
         MUCBC TEXT  NULL,
         MUCBT INTEGER DEFAULT 1,
         MUBNA TEXT,
         MUBDO DATETIME,
         SUID TEXT,
         GUID TEXT,
         SUCH TEXT,
         DATEI DATETIME,
         DATEU DATETIME,
         DEVI TEXT,
         DEVU TEXT,
         JTID_L INTEGER,
         BIID_L INTEGER,
         SYID_L INTEGER,
         CIID_L TEXT
         )  
      ''');
    await db.execute('''
         CREATE TABLE MAT_INF_A (
         MBID TEXT,
         MGNO TEXT NOT NULL,
         MINO TEXT NOT NULL,
         MIPN2 TEXT,
         MIPNC2 TEXT,
         SUID TEXT,
         GUID TEXT,
         SUCH TEXT,
         DATEI DATETIME,
         DATEU DATETIME,
         DEVI TEXT,
         DEVU TEXT,
         JTID_L INTEGER,
         BIID_L INTEGER,
         SYID_L INTEGER,
         CIID_L TEXT
         )  
      ''');
    await db.execute('''
          CREATE TABLE STO_INF (
            SIID INTEGER NOT NULL,
            SINA TEXT NOT NULL,
            SINE TEXT,
            AANO TEXT, 
            BIID INTEGER,
            SIPR TEXT, 
            SITL TEXT, 
            SIFX TEXT, 
            SIAD TEXT, 
            SIPN INTEGER, 
            SIST INTEGER DEFAULT 1,  
            SIDO Date,
            SUID TEXT,
            GUID TEXT,
            SUCH TEXT,
            DATEI DATETIME,
            DATEU DATETIME,
            DEVI TEXT,
            DEVU TEXT,
            SIN3 TEXT,
            SITID INTEGER,
            ORDNU INTEGER,
            DEFN INTEGER DEFAULT 2,
            RES TEXT,
            JTID_L INTEGER,
            BIID_L INTEGER,
            SYID_L INTEGER,
            CIID_L TEXT
            )
          ''');
    await db.execute('''
          CREATE TABLE SYS_CUR (
            SCID INTEGER ,
            SCNA TEXT ,
            SCNE TEXT,
            SCN3 TEXT,
            SCSF3 TEXT, 
            SCEX REAL,
            SCHR REAL, 
            SCLR REAL, 
            SCSF TEXT, 
            CWID TEXT, 
            SCST INTEGER DEFAULT 1,  
            SCDO DATETIME,
            SCDC DATETIME,
            SCSY TEXT,
            SCTID INTEGER,
            SCSFE TEXT, 
            ORDNU INTEGER, 
            SCSFL INTEGER DEFAULT 2, 
            DEFN INTEGER DEFAULT 2, 
            RES TEXT, 
            SUID TEXT, 
            DEVI TEXT, 
            DEVU TEXT, 
            DATEI DATETIME, 
            SUCH TEXT, 
            DATEU DATETIME,  
            GUID TEXT,
            JTID_L INTEGER,
            BIID_L INTEGER,
            SYID_L INTEGER,
            CIID_L TEXT
            )
          ''');
    await db.execute('''
         CREATE TABLE STO_NUM (
         SIID INTEGER NOT NULL,
         MGNO TEXT NOT NULL,
         MINO TEXT NOT NULL,
         MUID INTEGER NOT NULL,
         SNED Date,
         SNNO REAL DEFAULT 0,
         SNHO REAL,
         SNSA REAL,
         SNDO Date,
         SUID TEXT,
         GUID TEXT,
         SNNOA REAL DEFAULT 0,
         SUCH TEXT,
         DATEI DATETIME,
         DATEU DATETIME,
         DEVI TEXT,
         DEVU TEXT,
         JTID_L INTEGER,
         BIID_L INTEGER,
         SYID_L INTEGER,
         CIID_L TEXT  
         )  
      ''');
    await db.execute('''
         CREATE TABLE SYS_USR_B (
         BIID  INTEGER NOT NULL,
         SUID TEXT NOT NULL,
         SUBST INTEGER  DEFAULT 1,
         SUBIN INTEGER  DEFAULT 2,
         SUBPR INTEGER DEFAULT 2,
         SUBAP INTEGER DEFAULT 2,
         SUAP TEXT,
         SUBDO DATE,
         GUID TEXT,
         SUCH TEXT,
         DATEI DATETIME,
         DATEU DATETIME,
         DEVI TEXT,
         DEVU TEXT,
         JTID_L INTEGER,
         BIID_L INTEGER,
         SYID_L INTEGER,
         CIID_L TEXT
         )  
      ''');
    await db.execute('''
         CREATE TABLE STO_USR (
         SIID  INTEGER NOT NULL,
         SUID TEXT NOT NULL,
         SUIN INTEGER  DEFAULT 2,
         SUOU INTEGER  DEFAULT 2,
         SUAM INTEGER DEFAULT 2,
         SUCH INTEGER DEFAULT 2,
         SUAP TEXT,
         SUDO Date,
         GUID TEXT,
         DATEI DATETIME,
         DATEU DATETIME,
         DEVI TEXT,
         DEVU TEXT,
         SUID2 TEXT,
         SUCH2 TEXT,
         JTID_L INTEGER,
         BIID_L INTEGER,
         SYID_L INTEGER,
         CIID_L TEXT
         )  
      ''');
    await db.execute('''
         CREATE TABLE USR_PRI (
         PRID  INTEGER NOT NULL,
         SUID TEXT NOT NULL,
         UPIN INTEGER  DEFAULT 2,
         UPCH INTEGER  DEFAULT 2,
         UPQR INTEGER DEFAULT 2,
         UPDL INTEGER DEFAULT 2,
         UPPR INTEGER DEFAULT 2,
         GUID TEXT,
         SUCH TEXT,
         DATEI DATETIME,
         DATEU DATETIME,
         DEVI TEXT,
         DEVU TEXT,
         SUID2 TEXT,
         JTID_L INTEGER,
         BIID_L INTEGER,
         SYID_L INTEGER,
         CIID_L TEXT
         )  
      ''');
    await db.execute('''
         CREATE TABLE SYS_VAR (
         SVID  INTEGER NOT NULL,
         SVVL TEXT ,
         SVNA TEXT NOT NULL,
         SVNE TEXT,
         SVN3 TEXT,
         SVVLS TEXT,
         SVDO DATETIME,
         SUID TEXT,
         GUID TEXT,
         SUCH TEXT,
         DATEI DATETIME,
         DATEU DATETIME,
         DEVI TEXT,
         DEVU TEXT,
         JTID_L INTEGER,
         BIID_L INTEGER,
         SYID_L INTEGER,
         CIID_L TEXT
         )  
      ''');
    await db.execute('''
         CREATE TABLE GRO_USR (
         MGNO TEXT NOT NULL,
         SUID TEXT NOT NULL,
         GUIN INTEGER DEFAULT 1,
         GUOU INTEGER DEFAULT 1,
         GUAM INTEGER DEFAULT 1,
         GUCH INTEGER DEFAULT 1,
         GUDO DATETIME,
         GUAP TEXT,
         GUID TEXT,
         SUCH TEXT,
         DATEI DATETIME,
         DATEU DATETIME,
         DEVI TEXT,
         DEVU TEXT,
         SUID2  TEXT,
         JTID_L INTEGER,
         BIID_L INTEGER,
         SYID_L INTEGER,
         CIID_L TEXT
         )  
      ''');
    await db.execute('''
         CREATE TABLE SYN_ORD (
         SOET TEXT NOT NULL,
         ROW_NUM INTEGER DEFAULT 0,
         SOLD TEXT,
         SOOR INTEGER NOT NULL,
         SOST INTEGER NOT NULL,
         SOPK TEXT,
         JTID_L INTEGER,
         BIID_L INTEGER,
         SYID_L INTEGER,
         CIID_L TEXT
         )  
      ''');
    await db.execute('''
         CREATE TABLE LIST_VALUE (
         LVID  TEXT,
         LVNA  TEXT,
         LVNE  TEXT,
         LVTY  TEXT
         )  
      ''');
    await db.execute('''
         CREATE TABLE MAT_PRI (
         MGNO TEXT NOT NULL,
         MINO TEXT NOT NULL,
         MUID INTEGER NOT NULL,
         SCID INTEGER NOT NULL,
         MPCO REAL NOT NULL,
         MPS1 REAL,
         MPS2 REAL,
         MPS3 REAL,
         MPS4 REAL,
         MPUP INTEGER DEFAULT 1,
         MPUP1 REAL,
         MPUP2 REAL,
         MPUP3 REAL,
         MPUP4 REAL,
         MPDO DATETIME,
         SUID TEXT,
         MPCD DATETIME,
         SUCH TEXT,
         BIID INTEGER,
         GUID TEXT,
         MPLP REAL DEFAULT 0,
         MPHP REAL DEFAULT 0,
         MPLT INTEGER DEFAULT 1,
         MPHT INTEGER DEFAULT 1,
         DATEI DATETIME,
         DATEU DATETIME,
         DEVI TEXT,
         DEVU TEXT,
         JTID_L INTEGER,
         BIID_L INTEGER,
         SYID_L INTEGER,
         CIID_L TEXT
         )  
      ''');
    await db.execute('''
         CREATE TABLE SYS_DOC (
         STID TEXT NOT NULL,
          SDID INTEGER NOT NULL,
         SDNA TEXT,
         SDNE TEXT,
         SDN3 TEXT,
         SDDA TEXT,
         SDDE TEXT,
         SDST INTEGER DEFAULT 1,
         SDSI TEXT,
         SUID TEXT,
         SDDO DATETIME,
         SUCH TEXT,
         DATEU DATETIME,
         DEVU TEXT,
         SDSIS INTEGER,
         SDSY INTEGER DEFAULT 1,
         RES TEXT  
         )  
      ''');
    await db.execute('''
         CREATE TABLE SYS_DOC_D (
         STID TEXT NOT NULL,
         SDID INTEGER NOT NULL,
         BIID INTEGER NOT NULL,
         SDDDA TEXT,
         SDDDE TEXT,
         SDDD3 TEXT,
         SDDST1 INTEGER DEFAULT 1,
         SDDSA TEXT,
         SDDSE TEXT,
         SDDS3 TEXT,
         SDDST2 INTEGER DEFAULT 1,
         SUCH TEXT,
         DATEU DATETIME,
         DEVU TEXT,
         SUID TEXT,
         GUID TEXT,
         DATEI DATETIME,
         DEVI TEXT,
         JTID_L INTEGER,
         BIID_L INTEGER,
         SYID_L INTEGER,
         CIID_L TEXT 
         )  
      ''');
    await db.execute('''
         CREATE TABLE SYS_OWN (
         SOID INTEGER NOT NULL,
         SONA TEXT,
         SONE INTEGER,
         SORN TEXT,
         SOLN TEXT,
         CWID TEXT,
         CTID TEXT,
         SOAD TEXT,
         SOTL TEXT,
         SOFX TEXT,
         SOBX TEXT,
         SOEM TEXT,
         SOWE TEXT,
         SOIN TEXT,
         SOHN TEXT,
         SOSI TEXT,
         SODO DATETIME,
         SUID TEXT,
         SOST INTEGER DEFAULT 2,
         BIID INTEGER,
         SOTX TEXT,
         SOQN TEXT,
         SOQND TEXT,
         SOSN TEXT,
         SOSND TEXT,
         SOBN TEXT,
         SOBND TEXT,
         SOON TEXT,
         SOPC TEXT,
         SOAD2 TEXT,
         SOSA TEXT,
         SOSW TEXT,
         SOSWD TEXT,
         SOAB TEXT,
         SOABD TEXT,
         SOAB2 TEXT,
         SOAB2D TEXT,
         SOTXG TEXT,
         SOTX2 TEXT,
         SOTX2G TEXT,
         SOC1 TEXT,
         SOC2 TEXT,
         SOC3 TEXT,
         SOC4 TEXT,
         SOC5 TEXT,
         SOC6 TEXT,
         SOC7 TEXT,
         SOC8 TEXT,
         SOC9 TEXT,
         SOC10 TEXT,
         BAID INTEGER,
         SUCH TEXT,
         DATEU DATETIME,
         DEVU TEXT,
         GUID TEXT,
         DATEI DATETIME,
         DEVI TEXT,
         JTID_L INTEGER,
         BIID_L INTEGER,
         SYID_L INTEGER,
         CIID_L TEXT 
         )  
      ''');
    await db.execute('''
         CREATE TABLE SYS_LAN (
         SLID INTEGER NOT NULL,
         SLTY INTEGER,
         SLIT TEXT,
         SLSC TEXT,
         SLN1 TEXT,
         SLN2 TEXT,
         SLN3 TEXT,
         SLST INTEGER DEFAULT 1,
         SLN1S TEXT,
         SLN2S TEXT,
         SLN3S TEXT,
         SLDO DATE,
         SUID TEXT,
         SLCH INTEGER DEFAULT 1,
         SLTB TEXT,
         SLIN TEXT,
         STID TEXT,
         DATEI DATE DEFAULT CURRENT_TIMESTAMP,
         DEVI TEXT,
         SUCH TEXT,
         DATEU DATE,
         DEVU TEXT,
         GUID TEXT,
         JTID_L INTEGER,
         BIID_L INTEGER,
         SYID_L INTEGER,
         CIID_L TEXT 
         )  
      ''');
    await db.execute('''
         CREATE TABLE GEN_VAR (
         DES TEXT,
         VAL TEXT,
         JTID_L INTEGER,
         BIID_L INTEGER,
         SYID_L INTEGER,
         CIID_L TEXT 
         )  
      ''');
    await db.execute('''
         CREATE TABLE CONFIG (
         JTID INTEGER,
         SYID INTEGER,
         BIID INTEGER,
         CIID TEXT,
         SYST INTEGER DEFAULT 2,
         DATEI TEXT,
         LastSyncDate TEXT,
         CHIKE_ALL INTEGER,
         STMID TEXT,
         SYDV_NAME TEXT,
         SYDV_TY TEXT,
         SYDV_SER TEXT,
         SYDV_ID TEXT,
         SYDV_NO TEXT,
         SYDV_IP TEXT,
         SYDV_APPV TEXT
         )  
      ''');
    await db.execute('''
         CREATE TABLE SHI_INF (
         SIID INTEGER NOT NULL,
         BIID INTEGER,
         SITY INTEGER,
         SIVA INTEGER,
         SINA TEXT,
         SINE TEXT,
         SIN3 TEXT,
         SIST INTEGER,
         SIFD DATE,
         SITD DATE,
         SIFT INTEGER,
         SITT INTEGER,
         SIAS INTEGER,
         SIHN INTEGER,
         SUID TEXT,
         SIDO DATE,
         SUCH TEXT,
         SIDC DATE,
         BIIDT INTEGER,
         BIIDV TEXT,
         SIDAYT INTEGER,
         SIDAY TEXT,
         SIDEVT INTEGER,
         SIDEV TEXT,
         RES TEXT,
         DEFN INTEGER,
         ORDNU INTEGER,
         GUID TEXT,
         DATEI DATETIME,
         DATEU DATETIME,
         DEVI TEXT,
         DEVU TEXT,
         JTID_L INTEGER,
         BIID_L INTEGER,
         SYID_L INTEGER,
         CIID_L TEXT
         )  
      ''');
    await db.execute('''
         CREATE TABLE SHI_USR (
         SUNO INTEGER NOT NULL,
         SIID INTEGER,
         SUID TEXT,
         BPID INTEGER,
         SUST INTEGER,
         SIFT INTEGER,
         SITT INTEGER,
         SIAS INTEGER,
         SIHN INTEGER,
         SUID2 TEXT,
         SUDO DATE,
         SUCH TEXT,
         SUDC DATE,
         SIDAYT INTEGER,
         SIDAY TEXT,
         SIDEVT INTEGER,
         SIDEV TEXT,
         RES TEXT,
         GUID TEXT,
         DATEI DATETIME,
         DATEU DATETIME,
         DEVI TEXT,
         DEVU TEXT,
         GUIDF TEXT,
         JTID_L INTEGER,
         BIID_L INTEGER,
         SYID_L INTEGER,
         CIID_L TEXT
         )  
      ''');
    await db.execute('''
         CREATE TABLE BIL_POI (
         BPID INTEGER NOT NULL,
         BPNA TEXT,
         BPNE TEXT,
         AANO TEXT,
         BPTY INTEGER,
         BPUS TEXT,
         SIID INTEGER,
         BPST INTEGER,
         BPCT INTEGER,
         SCID INTEGER,
         BPPL TEXT,
         BPTI INTEGER,
         BPIN TEXT,
         BPDO DATE,
         SUID TEXT,
         BIID INTEGER,
         BPN3    TEXT,
         BPDEVT  INTEGER                             DEFAULT 0,
         BPDEV   TEXT,
         SCIDV   TEXT,
         ORDNU   INTEGER,
         RES     TEXT,
         DATEI   DATE,
         DEVI    TEXT,
         SUCH    TEXT,
         DATEU   DATE,
         DEVU    TEXT,
         DEFN    INTEGER                           DEFAULT 2,
         GUID    TEXT,
         ACNO    TEXT,
         AANO2   TEXT,
         PKIDL INTEGER DEFAULT 1,
         PKIDT INTEGER DEFAULT 0,
         PKIDV TEXT,
         BPPR INTEGER DEFAULT 1,
         BPPRT INTEGER DEFAULT 0,
         BPPRV TEXT,
         BPSEO INTEGER,
         BPIDT INTEGER,
         BPIDV TEXT,
         JTID_L INTEGER,
         BIID_L INTEGER,
         SYID_L INTEGER,
         CIID_L TEXT
         )  
      ''');
    await db.execute('''
         CREATE TABLE BIL_POI_U (
         BPID INTEGER NOT NULL,
         BPUUS TEXT,
         SIID INTEGER,
         BPUTY INTEGER,
         BPUTI INTEGER,
         BPUFT REAL,
         BPUTT REAL,
         BPUFT2 REAL,
         BPUTT2 REAL,
         BPUCT INTEGER,
         SCID INTEGER,
         BPUIN TEXT,
         BPUST INTEGER,
         BPUDO DATE,
         SUID TEXT,
         ORDNU   INTEGER,
         RES     TEXT,
         DATEI   DATE    DEFAULT SYSDATE,
         DEVI    TEXT,
         SUCH    TEXT,
         DATEU   DATE,
         DEVU    TEXT,
         DEFN    INTEGER          DEFAULT 2,
         GUID    TEXT,
         GUIDF   TEXT,
         SCIDV   TEXT,
         PKIDT   INTEGER    DEFAULT 0,
         PKIDV   TEXT,
         BPUPR   INTEGER                                DEFAULT 1,
         BPUPRT  INTEGER                            DEFAULT 0,
         BPUPRV  TEXT,
         JTID_L INTEGER,
         BIID_L INTEGER,
         SYID_L INTEGER,
         CIID_L TEXT
         )  
      ''');
    await db.execute('''
         CREATE TABLE PAY_KIN (
         PKID INTEGER NOT NULL,
         PKNA TEXT,
         PKNE TEXT,
         PKN3 TEXT,
         SUID TEXT,
         GUID TEXT,
         SUCH TEXT,
         DATEI DATETIME,
         DATEU DATETIME,
         DEVI TEXT,
         DEVU TEXT,
         PKTY INTEGER,
         JTID_L INTEGER,
         BIID_L INTEGER,
         SYID_L INTEGER,
         CIID_L TEXT
         )  
      ''');
    await db.execute('''
         CREATE TABLE CAR_PRE_G (
         CPGID INTEGER NOT NULL,
         CPGNA TEXT,
         CPGNE TEXT,
         CPGN3 TEXT,
         BIID INTEGER,
         CPGST INTEGER,
         SCID INTEGER,
         CPGAM INTEGER,
         CPGDI INTEGER,
         CPGRC INTEGER,
         AANOM TEXT,
         AANOD TEXT,
         AANOS TEXT,
         CPGEX INTEGER,
         CPGLE INTEGER,
         CPGNS TEXT,
         CPGDO DATE,
         SUID TEXT,
         CPGSM INTEGER,
         JTID_L INTEGER,
         BIID_L INTEGER,
         SYID_L INTEGER,
         CIID_L TEXT
         )  
      ''');
    await db.execute('''
         CREATE TABLE BIL_CUS (
         BCID INTEGER NOT NULL,
         BCNA TEXT,
         BCNE TEXT,
         AANO TEXT,
         BCTY INTEGER,
         BCFN INTEGER,
         BCTID INTEGER,
         ATTID INTEGER ,
         BCST INTEGER,
         BCTL TEXT,
         BCFX TEXT,
         BCBX TEXT,
         BCMO TEXT,
         BCEM TEXT,
         BCWE TEXT,
         CWID TEXT,
         CWID2 TEXT,
         CTID TEXT,
         CTID2 TEXT,
         BCAD TEXT,
         BDID INTEGER,
         BAID INTEGER,
         BAID2 TEXT,
         BCLA INTEGER,
         PKID INTEGER,
         BCBL REAL,
         BCPR INTEGER,
         BCBA REAL,
         BCBAA REAL,
         BCIN TEXT,
         BCNAF TEXT,
         OKID INTEGER,
         BCCT INTEGER,
         SCID INTEGER,
         BCDM INTEGER,
         BCHN TEXT,
         BCHT TEXT,
         BCHG TEXT,
         BCPS INTEGER,
         BCPD DATE,
         BCDO DATE,
         SUID TEXT,
         BCDC DATE,
         SUCH TEXT,
         BIID INTEGER,
         GUID TEXT,
         BCN3 TEXT,
         BCQN TEXT,
         BCQND TEXT,
         BCSN TEXT,
         BCSND TEXT,
         BCBN TEXT,
         BCBND TEXT,
         BCON TEXT,
         BCPC TEXT,
         BCAD2 TEXT,
         BCSA TEXT,
         BCSW TEXT,
         BCSWD TEXT,
         BCAB TEXT,
         BCABD TEXT,
         BCAB2 TEXT,
         BCAB2D TEXT,
         BCTX TEXT,
         BCTXG TEXT,
         BCTX2 TEXT,
         BCTX2G TEXT,
         BCC1 TEXT,
         BCC2 TEXT,
         BCC3 TEXT,
         BCC4 TEXT,
         BCC5 TEXT,
         BCC6 TEXT,
         BCC7 TEXT,
         BCC8 TEXT,
         BCC9 TEXT,
         BCC10 TEXT,
         BCLON TEXT,
         BCLAT TEXT,
         BCJT TEXT,
         BCCR INTEGER DEFAULT 0,
         BCCR2 REAL DEFAULT 0,
   		   DATEI DATETIME,
	   	   DATEU DATETIME,
		     DEVI TEXT,
		     DEVU TEXT,
         SYST_L INTEGER  DEFAULT 1,
         BCDL_L INTEGER  DEFAULT 1,
         JTID_L INTEGER,
         BIID_L INTEGER,
         SYID_L INTEGER,
         CIID_L TEXT
         )  
      ''');
    await db.execute('''
         CREATE TABLE ACC_BAN (
         ABID INTEGER NOT NULL,
         ABNA TEXT,
         ABNE TEXT,
         AANO TEXT,
         ABCT INTEGER,
         SCID INTEGER,
         ABNO TEXT,
         ABAD TEXT,
         ABTL TEXT,
         ABFX TEXT,
         ABIN TEXT,
         ABWE TEXT,
         ABEM TEXT,
         ABHN TEXT,
         ABJO TEXT,
         ABHT TEXT,
         ABCB TEXT,
         ABS1T INTEGER,
         ABS1 TEXT,
         ABST INTEGER,
         SUID TEXT,
         ABDO DATE,
         ABDC DATE,
         SUCH TEXT,
         BIID INTEGER,
		     GUID TEXT,
		     DATEI DATETIME,
		     DATEU DATETIME,
		     DEVI TEXT,
		     DEVU TEXT,
		     ABN3 TEXT,
		     ABTID INTEGER,
		     ORDNU INTEGER,
		     DEFN INTEGER,
		     RES TEXT,
		     SCIDV TEXT,
         JTID_L INTEGER,
         BIID_L INTEGER,
         SYID_L INTEGER,
         CIID_L TEXT
         )  
      ''');
    await db.execute('''
         CREATE TABLE ACC_COS (
         ACNO TEXT NOT NULL,
         ACNA TEXT,
         ACNE TEXT,
         ACTY INTEGER DEFAULT 1,
         OKID INTEGER,
         ACFN TEXT,
         ACST INTEGER DEFAULT 1,
         ACDO DATE,
         SUID TEXT,
         DATEI DATE DEFAULT CURRENT_TIMESTAMP,
         SUCH TEXT,
         DATEU DATE,
         GUID TEXT,
         DEVI TEXT,
         DEVU TEXT,
         JTID_L INTEGER,
         BIID_L INTEGER,
         SYID_L INTEGER,
         CIID_L TEXT
         )  
      ''');
    await db.execute('''
         CREATE TABLE BIL_MOV_K (
         BMKID INTEGER NOT NULL,
         BMKNA TEXT,
         BMKNE TEXT,
         BMKN3 TEXT,
         BMKST INTEGER DEFAULT 1,
         BMKTY INTEGER,
         BMKSN INTEGER,
         BMKAN INTEGER,
         STID TEXT,
         BMKDO DATE,
         SUID TEXT,
         DATEI DATE DEFAULT CURRENT_TIMESTAMP,
         SUCH TEXT,
         DATEU DATE,
         DEVI TEXT,
         DEVU TEXT,
         RES TEXT,
         ORDNU INTEGER,
         GUID TEXT,
         JTID_L INTEGER,
         BIID_L INTEGER,
         SYID_L INTEGER,
         CIID_L TEXT
         )  
      ''');
    await db.execute('''
  CREATE TABLE ACC_MOV_K (
  AMKID  INTEGER,
  AMKNA  TEXT,
  AMKNE  TEXT,
  AMKST  INTEGER            DEFAULT 1,
  AMKAC  INTEGER            DEFAULT 1,
  STID   TEXT,
  AMKDL  INTEGER            DEFAULT 2,
  AMKN3  TEXT,
  AMKFA  INTEGER,
  SUID   TEXT,
  DATEI  DATE,
  DEVI   TEXT,
  SUCH   TEXT,
  DATEU  DATE,
  DEVU   TEXT,
  RES    TEXT,
  ORDNU  INTEGER,
  GUID   TEXT,
  JTID_L INTEGER,
  BIID_L INTEGER,
  SYID_L INTEGER,
  CIID_L TEXT
         )  
      ''');
    await db.execute('''
         CREATE TABLE SYS_CUR_D (
         SCID INTEGER NOT NULL,
         SCDNO REAL,
         SCDNA TEXT,
         SCDNE TEXT,
         SCDN3 TEXT,
         SCDST INTEGER DEFAULT 1,
         SUID TEXT,
         SUCH TEXT,
         DATEI DATE,
         DATEU DATE,
         DEVI TEXT,
         DEVU TEXT,
         RES TEXT,
         GUID TEXT,
         DEFN INTEGER,
         ORDNU INTEGER,
         JTID_L INTEGER,
         BIID_L INTEGER,
         SYID_L INTEGER,
         CIID_L TEXT
         )  
      ''');
    await db.execute('''
         CREATE TABLE BIL_CRE_C (
         BCCID INTEGER NOT NULL,
         BCCNA TEXT,
         BCCNE TEXT,
         AANO TEXT,
         BCCCT INTEGER,
         SCID INTEGER,
         BCCCO INTEGER,
         BCCPR REAL,
         AANOC TEXT,
         BCCBN TEXT,
         BCCNO TEXT,
         BCCAD TEXT,
         BCCTL TEXT,
         BCCFX TEXT,
         BCCWE TEXT,
         BCCEM TEXT,
         BCCHN TEXT,
         BCCHT TEXT,
         BCCST INTEGER,
         BCCIN TEXT,
         SUID TEXT,
         SUCH TEXT,
         BCCDO DATE,
         BCCDC DATE,
         BIID INTEGER,
         BCCPK INTEGER,
         BCCSP INTEGER,
			   GUID TEXT,
			   DATEI DATETIME,
			   DATEU DATETIME,
			   DEVI TEXT,
			   DEVU TEXT,
			   BCCN3 TEXT,
			   BCCTID INTEGER,
			   ORDNU INTEGER,
			   DEFN INTEGER,
			   RES TEXT,
			   SCIDV TEXT,
         JTID_L INTEGER,
         BIID_L INTEGER,
         SYID_L INTEGER,
         CIID_L TEXT
         )  
      ''');
    await db.execute('''
         CREATE TABLE BIF_CUS_D (
         BCDID INTEGER ,
         BCDDO DATE,
         BCDNA TEXT,
         BCDMO TEXT,
         BCDTL TEXT,
         BCDAD TEXT,
         CWID TEXT,
         CTID TEXT,
         BAID INTEGER,
         BCDSN TEXT,
         BCDBN TEXT,
         BCDFN TEXT,
         BCDHN TEXT,
         BCDST INTEGER,
         BCDIN TEXT,
         BCID INTEGER,
         EAID INTEGER,
         GUIDE TEXT,
         GUID TEXT,
         SUID TEXT,
         SYUP INTEGER,
         BCDMO2 TEXT,
         BCDMO3 TEXT,
         BCDMO4 TEXT,
         BCDMO5 TEXT,
         GUIDC TEXT,
         DATEI DATE,
         DEVI TEXT,
         SUCH TEXT,
         DATEU DATE,
         DEVU TEXT,
         RES TEXT,
         ORDNU INTEGER,
         BCDNE TEXT,
         BCDN3 TEXT,
         BCDLON TEXT,
         BCDLAT TEXT,
         SYST_L INTEGER  DEFAULT 1,
         BCDDL_L INTEGER  DEFAULT 1,
         JTID_L INTEGER,
         BIID_L INTEGER,
         SYID_L INTEGER,
         CIID_L TEXT
         )  
      ''');
    await db.execute('''
         CREATE TABLE BIL_DIS (
           BDID  INTEGER NOT NULL,
           BDNA  TEXT,
           AANO  TEXT,
           BAID  INTEGER,
           BDTY  INTEGER,
           BDAD  TEXT,
           BDTL  TEXT,
           BDFX  TEXT,
           BDEM  TEXT,
           BDIN  TEXT,
           BDST  INTEGER,
           SUID  TEXT,
           BDDO  DATE,
			     GUID TEXT,
			     SUCH TEXT,
			     DATEI DATETIME,
			     DATEU DATETIME,
			     DEVI TEXT,
			     DEVU TEXT,
           BIID  INTEGER,
           BDNE  TEXT,
           BDN3  TEXT,
           BDTID  INTEGER,
           ORDNU  INTEGER,
           DEFN  INTEGER,
           RES  TEXT,
           JTID_L INTEGER,
           BIID_L INTEGER,
           SYID_L INTEGER,
           CIID_L TEXT
         )  
      ''');
    await db.execute('''
         CREATE TABLE SYS_REF (
          STID   TEXT,
          SRID   INTEGER,
  SRNA   TEXT,
  SRNE   TEXT,
  SRNO   TEXT,
  SRNL   TEXT,
  SRLE   INTEGER,
  SRYE   TEXT,
  SRFO   TEXT,
  SRCO1  INTEGER,
  SRCO2  INTEGER,
  SRDO   DATE,
  SUID   TEXT,
  BIID   INTEGER,
  			  GUID TEXT,
			  SUCH TEXT,
			  DATEI DATETIME,
			  DATEU DATETIME,
			  DEVI TEXT,
			  DEVU TEXT,
         JTID_L INTEGER,
         BIID_L INTEGER,
         SYID_L INTEGER,
         CIID_L TEXT )  
      ''');
    await db.execute('''
         CREATE TABLE BIL_USR_D (
             SUID   TEXT,
             BUDDI  REAL,
             BUDIN  REAL,
             BUDFD  DATE,
             BUDTD  DATE,
             BUDST INTEGER      DEFAULT 1,
             SUCH   TEXT,
             BUDDO  DATE,
             BUDDE  TEXT ,
             GUID TEXT,
			       DATEI DATETIME,
			       DATEU DATETIME,
			       DEVI TEXT,
			       DEVU TEXT,
			       SUID2 TEXT,
             JTID_L INTEGER,
             BIID_L INTEGER,
             SYID_L INTEGER,
             CIID_L TEXT)  
                       ''');
    await db.execute('''
         CREATE TABLE ACC_CAS (
            ACID   INTEGER,
            ACNA   TEXT,
            ACNE   TEXT,
            AANO   TEXT,
            ACCT   INTEGER    DEFAULT 1,
            SCID   INTEGER,
            ACTY   INTEGER    DEFAULT 2,
            ACMD   REAL,
            ACDA   REAL,
            SUIDT  TEXT,
            ACTM   INTEGER   DEFAULT 1,
            ACTMS  INTEGER   DEFAULT 1,
            ACTMP  INTEGER   DEFAULT 0,
            SUIDG  TEXT,
            ACGM   INTEGER   DEFAULT 1,
            ACGMS  INTEGER   DEFAULT 1,
            ACGMP  INTEGER   DEFAULT 0,
            ACST   INTEGER   DEFAULT 1,
            SUID   TEXT,
            ACDO   DATE,
            ACDC   DATE,
            SUCH   TEXT,
            ACIN   TEXT,
            BIID   INTEGER,
			      GUID TEXT,
			      DATEI DATETIME,
			      DATEU DATETIME,
			      DEVI TEXT,
			      DEVU TEXT,
			      ACN3 TEXT,
			      ACTID INTEGER,
			      ORDNU INTEGER,
			      DEFN INTEGER,
			      RES TEXT,
			      SCIDV TEXT,
            JTID_L INTEGER,
            BIID_L INTEGER,
            SYID_L INTEGER,
            CIID_L TEXT)
            ''');
    await db.execute('''
         CREATE TABLE COS_USR (
         ACNO TEXT NOT NULL,
         SUID TEXT NOT NULL,
         CUST INTEGER DEFAULT 2,
         CUOU INTEGER DEFAULT 2,
         CUPR INTEGER DEFAULT 2,
         CUDL INTEGER DEFAULT 2,
         CUOT INTEGER DEFAULT 2,
         CUDO DATETIME,
         SUAP TEXT,
			   GUID TEXT,
			   SUCH TEXT,
			   DATEI DATETIME,
			   DATEU DATETIME,
			   DEVI TEXT,
			   DEVU TEXT,
			   SUID2 TEXT,
         JTID_L INTEGER,
         BIID_L INTEGER,
         SYID_L INTEGER,
         CIID_L TEXT
         )  
      ''');
    await db.execute('''
         CREATE TABLE BIF_MOV_M (
         BMKID     INTEGER,
         BMMID     INTEGER,
         BMMNO     INTEGER,
         PKID      INTEGER,
         BMMDO     DATE,
         BMMST     INTEGER   DEFAULT 2,
         BMMST2     INTEGER   DEFAULT 2,
         BCID      INTEGER,
         BCID2      TEXT,
         BPID      INTEGER,
         BMMNA     TEXT,
         AANO      TEXT,
         SIID      INTEGER,
         BMMAM     REAL,
         SCID      INTEGER,
         SCEX      REAL,
         BMMEQ     REAL,
         ACID      INTEGER,
         ABID      INTEGER,
         BIID2     INTEGER,
         BMMIN     TEXT,
         BMMRE     TEXT,
         BMMDI     REAL,
         BMMDIA    REAL,
         BMMDIF    REAL,
         BMMTX     REAL,
         BMMIDR    INTEGER,
         BMMNOR    INTEGER,
         SUID      TEXT,
         BMMDA     DATE,
         SUAP      TEXT,
         BMMLO     REAL,
         BMMCP     REAL,
         BMMTC     REAL,
         BMMIDN    INTEGER,
         BMMNON    INTEGER,
         BEPID     INTEGER,
         BCCID     INTEGER,
         BMMCN     TEXT,
         BMMCD     DATE,
         BMMGR     TEXT,
         BMMCO     INTEGER                         DEFAULT 2,
         BIID      INTEGER,
         SCIDP     INTEGER,
         SCEXP     REAL,
         BMMAMP    REAL,
         SCIDP2    INTEGER,
         SCEXP2    REAL,
         BMMAMP2   REAL,
         GUIDR     TEXT,
         BMMDIR    REAL,
         BDID      INTEGER,
         BMMCR     REAL                         DEFAULT 0,
         BMMCA     REAL                        DEFAULT 0,
         BMMTXD    REAL                        DEFAULT 0,
         PKIDB     INTEGER                         DEFAULT 1,
         SCIDC     INTEGER,
         BMMDN     INTEGER                          DEFAULT 0,
         BMMDIA2   INTEGER                              DEFAULT 0,
         BMMDIR2   INTEGER                              DEFAULT 0,
          BMMPE     INTEGER                              DEFAULT 2,
         BMMPA     INTEGER                              DEFAULT 0,
        BMMPD     DATE,
  BMMDR     TEXT,
  GUID      TEXT,
  GUIDC     TEXT,
  BMMBR     INTEGER                              DEFAULT 1,
  BIIDB     INTEGER,
  BMMIS     INTEGER                              DEFAULT 0,
  DATEI     DATE,
  DATEU     DATE,
  SUCH      TEXT,
  GUID_LNK  TEXT,
  DEVI      TEXT,
  DEVU      TEXT,
  SCEXS     REAL,
  BMMPT     INTEGER                              DEFAULT 0,
  BMMDT     INTEGER                              DEFAULT 0,
  BCDID     INTEGER,
  BCDMO     TEXT,
  GUIDC2    TEXT,
  BMMWE     INTEGER                              DEFAULT 0,
  BMMVO     INTEGER                              DEFAULT 0,
  BMMVC     INTEGER                              DEFAULT 0,
  BMMDD     DATE,
  CTMID     INTEGER,
  CIMID     INTEGER,
  CCMTY     INTEGER,
  CCMID     INTEGER,
  CCDID     INTEGER,
  CCDNO     INTEGER,
  CCMFD     DATE,
  CCMTD     DATE,
  ACNO      TEXT,
  ACNO2      TEXT,
  BMMCT     INTEGER                          DEFAULT 1,
  ATTID     INTEGER,
  BMMNR INTEGER,
  BMMPR INTEGER,
  BCNA TEXT,
  BCCNA TEXT,
  BMMRD    DATE,
   BCMO TEXT,
  BMMMS TEXT,
  BMMDOR     DATE,
  BMMMT     REAL,
  BIID3 TEXT,
  BMMRE2    TEXT,
  BMMDE     TEXT,
  TTID1     INTEGER,
  TTID2     INTEGER,
  TTID3     INTEGER,
  TMTID2    INTEGER,
  ATTID2    INTEGER,
  BMMTX1    REAL                              DEFAULT 0,
  BMMTX2    REAL                              DEFAULT 0,
  BMMTX3    REAL                              DEFAULT 0,
  BMMTX11    REAL                              DEFAULT 0,
  BMMTX22    REAL                              DEFAULT 0,
  BMMTX33    REAL                              DEFAULT 0,
  STMID_NO  INTEGER,
  DEVI_NO  INTEGER,
  AMMID INTEGER,
  BMMLON TEXT,
  BMMLAT TEXT,
    TDKID TEXT,
  TCKID TEXT,
  STMIDI TEXT,
  SOMIDI INTEGER,
  STMIDU TEXT,
  SOMIDU INTEGER,
  BMMTX_DAT TEXT,
  BMMFS INTEGER DEFAULT 10,
  BMMQR TEXT,
  BMMRO INTEGER,
  TTLID INTEGER,
  TCRA     REAL,
  TCSDID     INTEGER,
  TCSDSY     TEXT,
  TCID     INTEGER,
  TCSY     TEXT,
  BMMAM_TX     REAL,
  BMMDI_TX     REAL,
  TCAM     REAL,
  BMMICV  INTEGER,
  BMMUU  TEXT,
  BMMFST INTEGER DEFAULT 10,
  BMMFQR TEXT,
  BMMFIC INTEGER,
  BMMFUU TEXT,
  BMMFNO TEXT,
  BMMCOU INTEGER DEFAULT 2,
  BMMCRT TEXT,
  BMMTN TEXT,
  JTID_L INTEGER,
  BIID_L INTEGER,
  SYID_L INTEGER,
  CIID_L TEXT
         )  
      ''');
    await db.execute('''
  CREATE TABLE BIF_MOV_D (
  BMKID   INTEGER,
  BMMID    INTEGER,
  BMDID    INTEGER,
  MGNO     TEXT,
  MINO     TEXT,
  MUID     INTEGER,
  MUCBC    TEXT,
  BMDAM    REAL,
  BMDAM1    REAL,
  BMDNO    REAL,
  BMDNF    REAL                         DEFAULT 0,
  BMDED    DATE,
  BMDEQ    REAL,
  BMDEQC   REAL,
  BMDIN    TEXT,
  BMDDI    REAL                         DEFAULT 0,
  BMDDIA   REAL                         DEFAULT 0,
  BMDDIF   REAL                        DEFAULT 0,
  BMDTX    REAL                        DEFAULT 0,
  BMDIDR   INTEGER,
  BMDAMR   REAL,
  BMDAMRC  REAL,
  BMDAMRE  REAL,
  BMDIDRS  INTEGER,
  SIID     INTEGER,
  BMDDIR   REAL                          DEFAULT 0,
  BMDTXA   REAL                         DEFAULT 0,
  BMDTXAT   REAL                         DEFAULT 0,
  BMDTXD   REAL                         DEFAULT 0,
  BMDTY    INTEGER                           DEFAULT 1,
  BMDDIA2  INTEGER                               DEFAULT 0,
  BMDDIR2  INTEGER                               DEFAULT 0,
  BMDDE    TEXT,
  BMDAMO   REAL                               DEFAULT 0,
  GUID     TEXT,
  BMDWE    INTEGER                               DEFAULT 0,
  BMDVO    INTEGER                               DEFAULT 0,
  BMDVC    INTEGER                               DEFAULT 0,
  BMDDD    DATE,
  CTMID    INTEGER,
  CIMID    INTEGER,
  CCMTY    INTEGER,
  CCMID    INTEGER,
  CCDID    INTEGER,
  CCDNO    INTEGER,
  CCMFD    DATE,
  CCMTD    DATE,
  BIID     INTEGER,
  GUIDM     TEXT,
  SCIDC    INTEGER,
  BMDAMT   REAL                               DEFAULT 0,
  BMDAMTF   REAL                               DEFAULT 0,
  BMDTXT   REAL                               DEFAULT 0,
  BMDTXT1   REAL                               DEFAULT 0,
  BMDTXT2   REAL                               DEFAULT 0,
  BMDTXT3   REAL                               DEFAULT 0,
  BMDDIT   REAL                               DEFAULT 0,
  BMDDIM   REAL                               DEFAULT 0,
  SYST INTEGER,
  MITSK INTEGER DEFAULT 0,
  MGKI  INTEGER DEFAULT 1,
   BMDTX1   REAL                               DEFAULT 0,
  BMDTX2   REAL                               DEFAULT 0,
  BMDTX3   REAL                               DEFAULT 0,
  BMDTXA1  REAL                               DEFAULT 0,
  BMDTXA2  REAL                               DEFAULT 0,
  BMDTXA3  REAL                               DEFAULT 0,
  BMDTX11   REAL                               DEFAULT 0,
  BMDTX22   REAL                               DEFAULT 0,
  BMDTX33   REAL                               DEFAULT 0,
  BMDTXA11  REAL                               DEFAULT 0,
  BMDTXA22  REAL                               DEFAULT 0,
  BMDTXA33  REAL                               DEFAULT 0,
  TDKID  TEXT ,
  TCKID  TEXT ,
  GUIDMT  TEXT ,
    TCRA     REAL,
  TCSDID     INTEGER,
  TCSDSY     TEXT,
  TCID     INTEGER,
  TCSY     TEXT,
  TCVL     INTEGER,
  BMDAM_TX     REAL,
  BMDDI_TX     REAL,
  BMDAMT3     REAL,
  TCAMT     REAL,
  JTID_L INTEGER,
  BIID_L INTEGER,
  SYID_L INTEGER,
  CIID_L TEXT
        )  
      ''');
    await db.execute('''
         CREATE TABLE BIL_BAR (
   BBAR   TEXT,
  BMKID  INTEGER,
  GUID  TEXT ,
  JTID_L INTEGER,
  BIID_L INTEGER,
  SYID_L INTEGER,
  CIID_L TEXT   )  
      ''');
    await db.execute('''
                CREATE TABLE COU_WRD(
                CWID   TEXT,
                CWNA  TEXT,
                CWNE  TEXT ,
                CWST  INTEGER ,
                CWPT  TEXT ,
                CWTL  INTEGER ,
                SUID TEXT,
			          GUID TEXT,
			          SUCH TEXT,
			          DATEI DATETIME,
			          DATEU DATETIME,
			          DEVI TEXT,
			          DEVU TEXT,
			          ORDNU   INTEGER,
                RES     TEXT,
                DEFN    INTEGER,
                CWN3    TEXT,
                CWCC    TEXT,
                CWWC    TEXT,
                CWWN    INTEGER,
                CWCC1   TEXT,
                CWWC2   TEXT,
                CWWN3   INTEGER,
                CWCN1   TEXT,
                CWCN2   TEXT,
                CWNAT   TEXT,
                CWSFL   INTEGER   DEFAULT 2,
                CWCN3   TEXT,
                CWNAT1  TEXT,
                CWNAT2  TEXT,
                CWNAT3  TEXT,
                JTID_L INTEGER,
                BIID_L INTEGER,
                SYID_L INTEGER,
                CIID_L TEXT   )  
                  ''');
    await db.execute('''
                CREATE TABLE COU_TOW(
                CWID  TEXT,
                CTID  TEXT,
                CTNA  TEXT ,
                CTNE  TEXT ,
                CTN3  TEXT ,
                CTST  INTEGER ,
                CTPT  TEXT ,
                SUID TEXT,
			          GUID TEXT,
			          SUCH TEXT,
			          DATEI DATETIME,
			          DATEU DATETIME,
			          DEVI TEXT,
			          DEVU TEXT,
			          ORDNU  INTEGER,
                RES    TEXT,
                DEFN   INTEGER,
                JTID_L INTEGER,
                BIID_L INTEGER,
                SYID_L INTEGER,
                CIID_L TEXT   )  
                  ''');
    await db.execute('''
                CREATE TABLE BIL_CUS_T(
                BCTID  INTEGER,
                BCTNA  TEXT,
                BCTNE  TEXT ,
                PKID  INTEGER ,
                BCTAM  TEXT ,
                BCTST  INTEGER ,
                SUID TEXT,
			          GUID TEXT,
			          SUCH TEXT,
			          DATEI DATETIME,
			          DATEU DATETIME,
			          DEVI TEXT,
			          DEVU TEXT,
                JTID_L INTEGER,
                BIID_L INTEGER,
                SYID_L INTEGER,
                CIID_L TEXT   )  
                  ''');
    await db.execute('''
                CREATE TABLE BIL_ARE(
                BAID  INTEGER,
                BANA  TEXT,
                BANE  TEXT ,
                BAN3  TEXT ,
                CWID  TEXT ,
                CTID  TEXT ,
                BAIM  INTEGER ,
                BAIN  TEXT ,
                BAST  INTEGER ,
                BADO  TEXT ,
                SUID  TEXT ,
                			  GUID TEXT,
			  SUCH TEXT,
			  DATEI DATETIME,
			  DATEU DATETIME,
			  DEVI TEXT,
			  DEVU TEXT,
                JTID_L INTEGER,
                BIID_L INTEGER,
                SYID_L INTEGER,
                CIID_L TEXT   )  
                  ''');
    await db.execute('''
                CREATE TABLE ACC_TAX_T(
                ATTID  INTEGER,
                ATTNA  TEXT,
                ATTNE  TEXT ,
                ATTN3  TEXT ,
                ATTP1  TEXT ,
                ATTP1U  TEXT ,
                ATTP1D  TEXT ,
                ATTS1  TEXT ,
                ATTS1U  TEXT ,
                ATTS1D  TEXT ,
                ATTP2  TEXT ,
                ATTP2U  TEXT ,
                ATTP2D  TEXT ,
                ATTS2  TEXT ,
                ATTS2U  TEXT ,
                ATTS2D  TEXT ,
                ATTP3  TEXT ,
                ATTP3U  TEXT ,
                ATTP3D  TEXT ,
                ATTS3  TEXT ,
                ATTS3U  TEXT ,
                ATTS3D  TEXT ,
                ATTST  TEXT ,
                SUID TEXT,
			  GUID TEXT,
			  SUCH TEXT,
			  DATEI DATETIME,
			  DATEU DATETIME,
			  DEVI TEXT,
			  DEVU TEXT,
                JTID_L INTEGER,
                BIID_L INTEGER,
                SYID_L INTEGER,
                CIID_L TEXT   )  
                  ''');
    await db.execute('''
                CREATE TABLE ACC_MOV_M(
                AMKID  INTEGER,
                AMMID  INTEGER,
                AMMNO  INTEGER,
                PKID  TEXT,
                AMMDO  TEXT,
                AMMST  INTEGER,
                AMMRE  TEXT,
                AMMCC  INTEGER,
                SCID  INTEGER,
                SCEX  TEXT,
                AMMAM  REAL DEFAULT 0 ,
                AMMEQ  REAL DEFAULT 0 ,
                ACID  INTEGER ,
                ABID  INTEGER ,
                AMMCN  TEXT ,
                AMMCD  TEXT,
                AMMCI  TEXT,
                BDID  TEXT ,
                AMMIN  TEXT ,
                AMMNA  TEXT ,
                AMMRE2 TEXT,
                ACNO TEXT,
                AMMDN TEXT,
                BKID TEXT,
                BMMID TEXT,
                SUID TEXT,
                AMMDA TEXT,
                SUAP TEXT,
                AMMDU TEXT,
                SUUP TEXT,
                AMMCT INTEGER,
                BIID TEXT,
                BCCID INTEGER,
                GUID TEXT,
                AMMBR INTEGER,
                BIIDB TEXT,
                DATEI TEXT,
                DATEU TEXT,
                SUCH TEXT,
                GUID_LNK TEXT,
                DEVI TEXT,
                DEVU TEXT,
                AMMPR INTEGER,
                AMMDOR TEXT,
                ROWN1 INTEGER,
                JTID_L TEXT,
                BIID_L INTEGER,
                SYID_L INTEGER,
                CIID_L TEXT   )  
                  ''');
    await db.execute('''
                CREATE TABLE ACC_MOV_D(
                AMKID  INTEGER,
                AMMID  INTEGER,
                AMDID  INTEGER ,
                AANO  TEXT ,
                ACNO  TEXT ,
                AMDRE  TEXT ,
                AMDIN  TEXT ,
                SCID  TEXT ,
                SCEX  TEXT ,
                AMDMD  REAL DEFAULT 0 ,
                AMDDA  REAL DEFAULT 0 ,
                AMDEQ  REAL DEFAULT 0 ,
                AMDTY  TEXT ,
                AMDST  TEXT ,
                BIID  TEXT ,
                AMDVW  INTEGER ,
                AMDKI  TEXT ,
                GUID  TEXT ,
                GUIDF  TEXT ,
                GUIDC TEXT,
                SUID TEXT,
			          SUCH TEXT,
			          DATEI DATETIME,
			          DATEU DATETIME,
			          DEVI TEXT,
			          DEVU TEXT,
			          AMDSS INTEGER,
			          AMDMS TEXT,
			          SYST_L INTEGER  DEFAULT 2,
                JTID_L INTEGER,
                BIID_L INTEGER,
                SYID_L INTEGER,
                CIID_L TEXT   )  
                  ''');
    await db.execute('''
         CREATE TABLE ACC_ACC (
  AANO  TEXT,
  AANA  TEXT,
  AANE  TEXT,
  AATY  INTEGER                              DEFAULT 2,
  AKID  INTEGER,
  OKID  INTEGER,
  AGID  INTEGER,
  AAFN  TEXT,
  AASE  INTEGER                             DEFAULT 1,
  AAST  INTEGER                              DEFAULT 1,
  AAIN  TEXT,
  AAAD  TEXT,
  AATL  TEXT,
  AAFX  TEXT,
  AACT  INTEGER                              DEFAULT 1,
  SCID  INTEGER,
  AAKI  INTEGER,
  AAOV  INTEGER                              DEFAULT 1,
  AACC  INTEGER                            DEFAULT 3,
  AACH  INTEGER                              DEFAULT 2,
  AAPR  INTEGER                              DEFAULT 2,
  AAPN  INTEGER                              DEFAULT 0,
  AADP  DATE,
  AADO  DATE,
  SUID  TEXT,
  AADC  DATE,
  SUCH  TEXT,
  AAMA  INTEGER                              DEFAULT 2,
  AAMN  INTEGER                              DEFAULT 90,
  BIID  INTEGER,
  			  GUID TEXT,
			  DATEI DATETIME,
			  DATEU DATETIME,
			  DEVI TEXT,
			  DEVU TEXT,
			  AAN3 TEXT,
			  RES TEXT,
			  SCIDV TEXT,
			  ACNOD TEXT,
			  AABL TEXT,
			  ORDNU TEXT,
			   SYST_L INTEGER  DEFAULT 1,
 JTID_L INTEGER,
  BIID_L INTEGER,
  SYID_L INTEGER,
  CIID_L TEXT   )  
      ''');
    await db.execute('''
         CREATE TABLE ACC_USR (
   AANO  TEXT,
  SUID  TEXT,
  AUIN  INTEGER                             DEFAULT 2,
  AUOU  INTEGER                              DEFAULT 2,
  AUPR  INTEGER                              DEFAULT 2,
  AUDL  INTEGER                              DEFAULT 2,
  AUOT  INTEGER                              DEFAULT 2,
  SUAP  TEXT,
  AUDO  DATE,
			  GUID TEXT,
			  SUCH TEXT,
			  DATEI DATETIME,
			  DATEU DATETIME,
			  DEVI TEXT,
			  DEVU TEXT,
			  SYST_L INTEGER  DEFAULT 1,
  JTID_L INTEGER,
  BIID_L INTEGER,
  SYID_L INTEGER,
  CIID_L TEXT   )  
      ''');
    await db.execute('''
         CREATE TABLE BIL_MOV_M (
    BMKID     INTEGER,
  BMMID     INTEGER,
  BMMNO     INTEGER,
  PKID      INTEGER,
  BMMDO     DATE,
  BMMST     INTEGER  DEFAULT 2,
  BMMST2     INTEGER   DEFAULT 2,
  BCID      INTEGER,
  BCID2      TEXT,
  BIID      INTEGER,
  BMMNA     TEXT,
  AANO      TEXT,
  SIID      INTEGER,
  BMMAM     REAL,
  SCID      INTEGER,
  SCEX      REAL,
  BMMEQ     REAL,
  ACID      INTEGER,
  ABID      INTEGER,
  BMMCN     TEXT,
  BMMCD     DATE,
  BMMCT     INTEGER                          DEFAULT 1,
  BMMIN     TEXT,
  BMMRE     TEXT,
  BMMRE2    TEXT,
  SCEXS     REAL,
  BDID      INTEGER,
  BMMDI     REAL,
  BMMDIA    REAL,
  BMMDIF    REAL,
  BMMTX     REAL,
  BMMTN     TEXT,
  BMMDR     TEXT,
  BMMDN     INTEGER,
  BMMIDR    INTEGER,
  BMMNOR    INTEGER,
  ACNO      TEXT,
  ACNO2     TEXT,
  SUID      TEXT,
  BMMDA     DATE,
  SUAP      TEXT,
  BMMDE     TEXT,
  BPID      INTEGER,
  BMMLC     INTEGER                         DEFAULT 3,
  ALID      INTEGER,
  BMMLA     REAL,
  BMMDIR    REAL                         DEFAULT 0,
  SCID2     INTEGER,
  SCEX2     REAL,
  BMMAM2    REAL,
  SCID3     INTEGER,
  SCEX3     REAL,
  BMMAM3    REAL,
  BMMLAD    REAL,
  BMMCDT    INTEGER,
  BMMGR     TEXT,
  BIID2     INTEGER,
  BCCID     INTEGER,
  BMMCR     REAL                         DEFAULT 0,
  BMMCA     REAL                       DEFAULT 0,
  BMMTXD    REAL                        DEFAULT 0,
  BMMTXY    INTEGER                          DEFAULT 1,
  TMTID     INTEGER                          DEFAULT 1,
  ATTID     INTEGER,
  BMMDIA2   INTEGER                              DEFAULT 0,
  BMMDIR2   INTEGER                              DEFAULT 0,
  GUID      TEXT,
  GUIDC     TEXT,
  BMMBR     INTEGER                              DEFAULT 1,
  BIIDB     INTEGER,
  BMMIS     INTEGER                              DEFAULT 0,
  DATEI     DATE                                DEFAULT CURRENT_TIMESTAMP,
  DATEU     DATE,
  SUCH      TEXT,
  GUID_LNK  TEXT,
  DEVI      TEXT,
  DEVU      TEXT,
  BMMPT     INTEGER                              DEFAULT 0,
  BMMDT     INTEGER                              DEFAULT 0,
  BCDID     INTEGER,
  BCDMO     TEXT,
  GUIDC2    TEXT,
  BMMWE     INTEGER                              DEFAULT 0,
  BMMVO     INTEGER                              DEFAULT 0,
  BMMVC     INTEGER                              DEFAULT 0,
  BMMDD     DATE,
  BMMNR     INTEGER,
  BMMPR INTEGER,
  BCMO TEXT,
  BMMMS TEXT,
  BMMDOR     DATE,
  BMMRD    DATE,
  BMMMT     REAL,
  BIID3      TEXT,
  TTID1     INTEGER,
  TTID2     INTEGER,
  TTID3     INTEGER,
  TMTID2    INTEGER,
  ATTID2    INTEGER,
  BMMTX1    REAL                              DEFAULT 0,
  BMMTX2    REAL                              DEFAULT 0,
  BMMTX3    REAL                              DEFAULT 0,
  BMMTX11    REAL                              DEFAULT 0,
  BMMTX22    REAL                              DEFAULT 0,
  BMMTX33    REAL                              DEFAULT 0,
  STMID_NO  INTEGER,
  DEVI_NO  INTEGER,
  SCIDP     INTEGER,
  SCEXP     REAL,
  BMMAMP    REAL,
  SCIDP2     INTEGER,
  SCEXP2     REAL,
  BMMAMP2    REAL,
  BMMCP     REAL,
  BMMTC     REAL,
  BMMLON    TEXT,
  BMMLAT    TEXT,
  AMMID INTEGER,
  TDKID TEXT,
  TCKID TEXT,
  STMIDI TEXT,
  SOMIDI INTEGER,
  STMIDU TEXT,
  SOMIDU INTEGER,
  BMMTX_DAT TEXT,
  BMMFS INTEGER DEFAULT 10,
  BMMQR TEXT,
  BMMRO INTEGER,
  TTLID INTEGER,
  TCRA     REAL,
  TCSDID     INTEGER,
  TCSDSY     TEXT,
  TCID     INTEGER,
  TCSY     TEXT,
  BMMAM_TX     REAL,
  BMMDI_TX     REAL,
  TCAM     REAL,
  BMMICV  INTEGER,
  BMMUU  TEXT,
  BMMFST INTEGER DEFAULT 10,
  BMMFQR TEXT,
  BMMFIC INTEGER,
  BMMFUU TEXT,
  BMMFNO TEXT,
    CTMID     INTEGER,
  CIMID     INTEGER,
  SCIDC   INTEGER,
  BMMCRT TEXT,
  JTID_L INTEGER,
  BIID_L INTEGER,
  SYID_L INTEGER,
  CIID_L TEXT   )  
      ''');
    await db.execute('''
         CREATE TABLE BIL_MOV_D (
    BMKID    INTEGER,
  BMMID    INTEGER,
  BMDID    INTEGER,
  SIID     INTEGER,
  MGNO     TEXT,
  MINO     TEXT,
  MUID     INTEGER,
  MUCBC    TEXT,
  BMDAM    REAL,
  BMDNO    REAL,
  BMDNF    REAL                         DEFAULT 0,
  BMDED    DATE,
  BMDEQ    REAL,
  BMDIN    TEXT,
  SIIDT    INTEGER,
  BMDDI    REAL                         DEFAULT 0,
  BMDDIA   REAL                         DEFAULT 0,
  BMDDIF   REAL                         DEFAULT 0,
  BMDTX    REAL                         DEFAULT 0,
  BMDEX    REAL,
  BMDAML   REAL,
  BMDEQC   REAL,
  BMDCB    REAL,
  BMDCA    REAL,
  BMDAMR   REAL,
  BMDAMRE  REAL,
  BMMIDR   INTEGER,
  BMMNOR   INTEGER,
  BMDIDR   INTEGER,
  BIID     INTEGER,
  BMDDIR   REAL                          DEFAULT 0,
  BMDTXA   REAL                         DEFAULT 0,
  BMDTXD   REAL                         DEFAULT 0,
  BMDTY    INTEGER                           DEFAULT 1,
  BMDDIA2  INTEGER                               DEFAULT 0,
  BMDDIR2  INTEGER                               DEFAULT 0,
  BMDDE    TEXT,
  BMDAMO   REAL                               DEFAULT 0,
   BMDWE    INTEGER                               DEFAULT 0,
  BMDVO    INTEGER                               DEFAULT 0,
  BMDVC    INTEGER                               DEFAULT 0,
  BMDDD    DATE,
  BMDAMT   REAL                               DEFAULT 0,
  BMDAMTF   REAL                               DEFAULT 0,
  BMDTXT   REAL                               DEFAULT 0,
  BMDTXT1   REAL                               DEFAULT 0,
  BMDTXT2   REAL                               DEFAULT 0,
  BMDTXT3   REAL                               DEFAULT 0,
  BMDDIT   REAL                               DEFAULT 0,
  BMDDIM   REAL                               DEFAULT 0,
  GUID     TEXT,
  MITSK  INTEGER DEFAULT 0,
  GUIDM    TEXT,
  SYST  INTEGER,
  MGKI  INTEGER DEFAULT 1,
  BMDTX1   REAL                               DEFAULT 0,
  BMDTX2   REAL                               DEFAULT 0,
  BMDTX3   REAL                               DEFAULT 0,
  BMDTXA1  REAL                               DEFAULT 0,
  BMDTXA2  REAL                               DEFAULT 0,
  BMDTXA3  REAL                               DEFAULT 0,
  BMDTX11   REAL                               DEFAULT 0,
  BMDTX22   REAL                               DEFAULT 0,
  BMDTX33   REAL                               DEFAULT 0,
  BMDTXA11  REAL                               DEFAULT 0,
  BMDTXA22  REAL                               DEFAULT 0,
  BMDTXA33  REAL                               DEFAULT 0,
  TDKID    TEXT,
  TCKID    TEXT,
  GUIDMT     TEXT,
  TCRA     REAL,
  TCSDID     INTEGER,
  TCSDSY     TEXT,
  TCID     INTEGER,
  TCSY     TEXT,
  TCVL     INTEGER,
  BMDAM_TX     REAL,
  BMDDI_TX     REAL,
  BMDAMT3     REAL,
  TCAMT     REAL,
    SCIDC    INTEGER,
   CTMID    INTEGER,
  CIMID    INTEGER,
  BMDAM1    REAL,
  JTID_L INTEGER,
  BIID_L INTEGER,
  SYID_L INTEGER,
  CIID_L TEXT)  
      ''');
    await db.execute('''
         CREATE TABLE MAT_PRI_Y (
   MPYID    TEXT,
  SYID     INTEGER,
  BIID2    INTEGER,
  BMKID    INTEGER,
  SCID     INTEGER,
  BCID     INTEGER,
  MGNO     TEXT,
  MINO     TEXT,
  MUID     INTEGER,
  BMDAM    REAL,
  BMDED    DATE,
  BMMDO    DATE,
  JTID     INTEGER,
  BMDAMH   REAL                         DEFAULT 0,
  BMDAML   REAL                        DEFAULT 0,
  BMMID    INTEGER,
  BMDAMO   REAL                         DEFAULT 0,
  BMDAMHO  REAL                         DEFAULT 0,
  BMDAMLO  REAL                         DEFAULT 0,
  BMMIDO   INTEGER,
  BMMDOO   DATE,
  MUIDO    INTEGER,
  SUID     TEXT,
  DATEI    DATE                                 DEFAULT SYSDATE,
  SUCH     TEXT,
  DATEU    DATE,
  GUID     TEXT,
  JTID_L INTEGER,
  BIID_L INTEGER,
  SYID_L INTEGER,
  CIID_L TEXT   )  
      ''');
    await db.execute('''
  CREATE TABLE BIL_IMP (
  BIID    INTEGER,
  BINA    TEXT,
  BINE    TEXT,
  AANO    TEXT,
  BITY    INTEGER                           DEFAULT 2,
  BIFN    INTEGER,
  BITID   INTEGER,
  BIST    INTEGER                            DEFAULT 1,
  BITL    TEXT,
  BIFX    TEXT,
  BIMO    TEXT,
  BIBX    TEXT,
  BIEM    TEXT,
  BIWE    TEXT,
  CWID    TEXT,
  CTID    TEXT,
  BIAD    TEXT,
  PKID    INTEGER,
  BIAM    INTEGER,
  BICT    INTEGER                           DEFAULT 1,
  SCID    INTEGER,
  BIPS    INTEGER,
  BIPD    DATE,
  BIHN    TEXT,
  BIHT    TEXT,
  BIHG    TEXT,
  BILA    INTEGER                            DEFAULT 1,
  BIIN    TEXT,
  BIDO    DATE,
  SUID    TEXT,
  BIDM    INTEGER                            DEFAULT 0,
  BIID2   INTEGER,
  DATEI   DATE                                  DEFAULT SYSDATE,
  SUCH    TEXT,
  DATEU   DATE,
  GUID    TEXT,
  BIN3    TEXT,
  BIQN    TEXT,
  BIQND   TEXT,
  BISN    TEXT,
  BISND   TEXT,
  BIBN    TEXT,
  BIBND   TEXT,
  BION    TEXT,
  BIPC    TEXT,
  BIAD2   TEXT,
  BISA    TEXT,
  BISW    TEXT,
  BISWD   TEXT,
  BIAB    TEXT,
  BIABD   TEXT,
  BIAB2   TEXT,
  BIAB2D  TEXT,
  BITX    TEXT,
  BITXG   TEXT,
  BITX2   TEXT,
  BITX2G  TEXT,
  BIC1    TEXT,
  BIC2    TEXT,
  BIC3    TEXT,
  BIC4    TEXT,
  BIC5    TEXT,
  BIC6    TEXT,
  BIC7    TEXT,
  BIC8    TEXT,
  BIC9    TEXT,
  BIC10   TEXT,
  DEVI    TEXT,
  DEVU    TEXT,
  BICR INTEGER,
  BILON TEXT,
  BILAT TEXT,
  JTID_L INTEGER,
  BIID_L INTEGER,
  SYID_L INTEGER,
  CIID_L TEXT   )  
      ''');
    await db.execute('''
         CREATE TABLE SYS_CUR_BET (
         SCIDF  INTEGER ,
         SCIDT  INTEGER ,
         SCBTY  TEXT,
         SCEX   TEXT,
         DATEI  DATETIME,
         DATEU  DATETIME,
         		  SUID TEXT,
			  GUID TEXT,
			  SUCH TEXT,
			  DEVI TEXT,
			  DEVU TEXT,
         JTID_L INTEGER,
         BIID_L INTEGER,
         SYID_L INTEGER,
         CIID_L TEXT
         )  
      ''');
    await db.execute('''
         CREATE TABLE ACC_TAX_C (
         AANO  TEXT,
         ATTID  INTEGER,
         SUID  TEXT,
         SUCH  TEXT,
         GUID  TEXT,
         DATEI  DATE,
         DATEU  DATE,
         DEVI   TEXT,
         DEVU   TEXT,
         ATCST   TEXT,
         JTID_L INTEGER,
         BIID_L INTEGER,
         SYID_L INTEGER,
         CIID_L TEXT
         )  
      ''');
    await db.execute('''
         CREATE TABLE SYN_DAT (
         STMID  TEXT ,
         SDSQ  INTEGER ,
         SDNO  TEXT ,
         GUID  TEXT ,
         SDTB  TEXT,
         SDTN   INTEGER,
         SDTY   TEXT,
         JTID   INTEGER,
         CIID   INTEGER,
         BIID   INTEGER,
         SDST   INTEGER,
         DATEI  DATETIME,
         SYER  TEXT,
         SMID INTEGER,
			   SDBR_A TEXT,
			   SDPO_A TEXT,
			   SYID INTEGER,
			   DATEU  DATETIME,
			   SOMSQ TEXT,
			   SOGU TEXT,
			  SYDV_ID TEXT,
			  SYDV_GU TEXT,
			  SYDV_NAME TEXT,
			  SYDV_IP TEXT,
			  SYDV_SER TEXT,
			  SYDV_POI TEXT,
			  SYDV_NO TEXT,
			  SYDV_LATITUDE TEXT,
			  SYDV_LONGITUDE TEXT,
			  SYDV_APPV TEXT,
			  SYDV_APIV TEXT,
			  SYDV_TY TEXT,
			  SLTY2 TEXT,
			  SLIT2 TEXT,
			  SLSC2 TEXT,
			  SLTYP TEXT,
			  SDC2 TEXT,
			  SDC3 TEXT,
			  SDNO2 TEXT,
			  SDNO3 TEXT,
			  DEVI TEXT,
			  SUID TEXT,
			  SUCH TEXT,
			  DEVU TEXT,
         JTID_L INTEGER,
         BIID_L INTEGER,
         SYID_L INTEGER,
         CIID_L TEXT
         )  
      ''');
    await db.execute('''
         CREATE TABLE ACC_STA_M (
          ASMID     REAL,
  SUID      TEXT,
  AANO      TEXT,
  AANA      TEXT,
  BIIDF     INTEGER,
  BIIDT     INTEGER,
  BINA      TEXT,
  ACNOF     TEXT,
  ACNOT     TEXT,
  ACNA      TEXT,
  FROMD     DATE,
  TOD       DATE,
  SCIDF     INTEGER,
  SCIDT     INTEGER,
  SCNA      TEXT,
  ASMIN     TEXT,
  ASMNA     TEXT,
  AMLAS     REAL,
  AMBAL     REAL,
  AMLASN    TEXT,
  AMBALN    TEXT,
  ATC1      INTEGER,
  ATC2      INTEGER,
  ATC3      INTEGER,
  ATC4      TEXT,
  ATC5      TEXT,
  ATC6      TEXT,
  ATC7      DATE,
  ATC8      DATE,
  ASMDA     TEXT,
  ASMSA     TEXT,
  ASMDAY    INTEGER                              DEFAULT 1,
  ASMSAY    INTEGER                              DEFAULT 1,
  GUID_REP  TEXT,
  SUID_REP  TEXT,
  ROWN1    INTEGER,
         JTID_L INTEGER,
         BIID_L INTEGER,
         SYID_L INTEGER,
         CIID_L TEXT
         )  
      ''');
    await db.execute('''
         CREATE TABLE ACC_STA_D (
     ASMID     REAL,
  ASDID     REAL,
  ATC1      REAL,
  ATC2      REAL,
  ATC3      REAL,
  ATC4      REAL,
  ATC5      REAL,
  ATC6      REAL,
  ATC7      REAL,
  ATC8      REAL,
  ATC9      REAL,
  ATC10     INTEGER,
  ATC11     TEXT,
  ATC12     TEXT,
  ATC13     TEXT,
  ATC14     TEXT,
  ATC15     TEXT,
  ATC16     TEXT,
  ATC17     TEXT,
  ATC18     TEXT,
  ATC19     TEXT,
  ATC20     TEXT,
  ATC21     TEXT,
  ATC22     TEXT,
  ATC23     TEXT,
  ATC26     TEXT,
  ATC27     TEXT,
  ATC28     TEXT,
  ATC24     DATE,
  ATC25     DATE,
  SUID      TEXT,
  SYID      INTEGER,
  GUID      TEXT,
  GUID_LNK  TEXT,
  GUID_REP  TEXT,
         JTID_L INTEGER,
         BIID_L INTEGER,
         SYID_L INTEGER,
         CIID_L TEXT
         )  
      ''');
    await db.execute('''
         CREATE TABLE SYN_LOG (   
         SLSQ            INTEGER PRIMARY KEY,
       SLDO            DATE ,
       SLIN            TEXT,
       SLTY            TEXT,
    SUID            TEXT,
    STMSQ           INTEGER,
    SMID            INTEGER,
    STMID           TEXT,
    GUID            TEXT,
    SOTT            TEXT,
    SOTY            TEXT,
    SLC1            TEXT,
    CIID            INTEGER,
    JTID            INTEGER,
    BIID            INTEGER,
    SYID            INTEGER,
    SOMID           INTEGER,
    SYDV_NAME       TEXT,
    SYDV_IP         TEXT,
    SYDV_SER        TEXT,
    SYDV_POI        TEXT,
    SYDV_NO         TEXT,
    SYDV_LATITUDE   TEXT,
    SYDV_LONGITUDE  TEXT,
    SYDV_APPV       TEXT,
    SYDV_APIV       TEXT,
    SYDV_TY         TEXT,
    SDSQ            INTEGER,
    SLTY2           INTEGER,
    SLIT2           TEXT,
    SLSC2           TEXT,
    SLTYP           TEXT,
    SLC2            TEXT,
    SLC3            TEXT,
    SYDV_ID         TEXT,
    SYDV_GU         TEXT,
    SOGU            TEXT,
         JTID_L INTEGER,
         BIID_L INTEGER,
         SYID_L INTEGER,
         CIID_L TEXT
         )  
      ''');
    await db.execute('''
         CREATE TABLE QR_INF (
         QIID INTEGER,
         QICN TEXT,
         QITX TEXT,
         QIDI TEXT,
         QIAM TEXT,
         QITM TEXT,
         SUID TEXT,
         DETAI TEXT,
         DEVI TEXT,
         JTID_L INTEGER,
         BIID_L INTEGER,
         SYID_L INTEGER,
         CIID_L TEXT 
         )  
      ''');
    await db.execute('''
         CREATE TABLE FAS_ACC_USR (
         SUID    TEXT,
         SSID    INTEGER,
         FAUIC   TEXT,
         FAUICS  TEXT,
         STMID   INTEGER,
         FAUKE   TEXT,
         FAUST   INTEGER                             DEFAULT 1,
         ORDNU   INTEGER,
         RES     TEXT,
         SUID2   TEXT,
         DATEI   DATE,
         DEVI    TEXT,
         SUCH    TEXT,
         DATEU   DATE,
         DEVU    TEXT,
         DEFN    INTEGER  DEFAULT 2,
         GUID    TEXT,
         FAUST2 INTEGER  DEFAULT 2,
         JTID_L INTEGER,
         BIID_L INTEGER,
         SYID_L INTEGER,
         CIID_L TEXT 
         )  
      ''');
    await db.execute('''
         CREATE TABLE BAL_ACC_M (
         BAMSQ     INTEGER,
  AANO      TEXT,
  GUID      TEXT,
  BAMLU     DATE,
  BAMMN     INTEGER                             ,
  BAMMD     TEXT                              ,
  BAMDA     INTEGER                              ,
  BAMBA     INTEGER                              ,
  BAMBAS    TEXT,
  BAMBAR1   TEXT,
  BAMBAR2   TEXT,
  BAMBAR3   TEXT,
  BAMBNFL   TEXT                              ,
  BAMBNFLS  TEXT,
  BAMCAL    TEXT                              ,
  BAMBN     TEXT                              ,
  BAMBNFN   TEXT                              ,
  BAMLP     DATE,
  BAMLBI    TEXT,
  BAMLBN    TEXT,
  BAMLBD    DATE,
  ROWN1    INTEGER,
  ROWN2    INTEGER,
  GUIDN      TEXT,
  SUID      TEXT,
  SUCH      TEXT,
  DATEI     DATE,
  DATEU     DATE, 
  DEVI      TEXT,
  DEVU      TEXT,
         JTID_L INTEGER,
         BIID_L INTEGER,
         SYID_L INTEGER,
         CIID_L TEXT 
         )  
      ''');
    await db.execute('''
         CREATE TABLE BAL_ACC_D (
 BADSQ    INTEGER,
  BACSQ    INTEGER,
  BAMSQ    INTEGER,
  BADNO    INTEGER,
  AANO     TEXT,
  GUIDA     TEXT,
  GUID     TEXT,
  BIID     INTEGER,
  BADDO    DATE,
  AMKID    INTEGER,
  AMMID    INTEGER,
  AMMNO    INTEGER,
  AMDID    INTEGER,
  ACNO     TEXT,
  BADRE    TEXT,
  BADDE    TEXT,
  SCID     INTEGER,
  SCEX     TEXT,
  BADMD    TEXT,
  BADDA    TEXT,
  BADMDL   TEXT,
  BADDAL   TEXT,
  BADTY    INTEGER,
  BADBA    TEXT                               DEFAULT 0,
  BADBAS   TEXT,
  BADBAL   TEXT                               DEFAULT 0,
  BADBALS  TEXT,
  BADST    INTEGER                               DEFAULT 2,
  BADVW    INTEGER                               DEFAULT 1,
  BADKI    TEXT                  DEFAULT 'O',
  PKID     INTEGER,
  BADCC    INTEGER                               DEFAULT 2,
  SCIDM    INTEGER,
  SCEXM    TEXT,
  AMMAM    TEXT,
  AMMEQ    TEXT,
  ACID     INTEGER,
  ABID     INTEGER,
  BADCN    TEXT,
  BADCD    DATE,
  BADCI    TEXT,
  BADCT    TEXT                               DEFAULT 0,
  BCCID    TEXT,
  BDID     TEXT,
  BADNA    TEXT,
  BADRE2   TEXT,
  BADDN    TEXT,
  STIDL    TEXT,
  BADKIL   TEXT,
  BADIDL   TEXT,
  BADGUL   TEXT,
  BADGUM   TEXT,
  BADGUD   TEXT,
  BADBR    TEXT                               DEFAULT 1,
  BIIDB    TEXT,
  BADBI    TEXT,
  BADMN    TEXT                               DEFAULT 1,
  BADAD    DATE,
  SUAP     TEXT,
  BADDU    DATE,
  BADEQ     TEXT,
  SUUP     TEXT,
  SUID     TEXT,
  SUCH     TEXT,
  DATEI    DATE,
  DATEU    DATE,
  DEVI     TEXT,
  DEVU     TEXT,
  SUID2     TEXT,
  SUCH2     TEXT,
  DATEI2    DATE,
  DATEU2    DATE,
  DEVI2     TEXT,
  DEVU2     TEXT,
  BADDO2   DATE,
  GUIDN   TEXT,
  JTID_L INTEGER,
  BIID_L INTEGER,
  SYID_L INTEGER,
  CIID_L TEXT 
         )  
      ''');
    await db.execute('''
         CREATE TABLE BAL_ACC_C (
  BACSQ      INTEGER,
  BAMSQ      INTEGER,
  GUID       TEXT,
  AANO       TEXT,
  GUIDA      TEXT,
  BIID       INTEGER,
  SCID       INTEGER,
  SCEX       TEXT,
  BCDFY      TEXT,
  BCDTY      TEXT,
  BCDFD      DATE,
  BCDTD      DATE,
  BACCA      TEXT                             ,
  BACCAL     TEXT                            ,
  BACBN      TEXT                             ,
  BACOBMD    TEXT                             ,
  BACOBDA    TEXT                             ,
  BACOB      TEXT                             ,
  BACOBS     TEXT,
  BACOBLMD   TEXT                             ,
  BACOBLDA   TEXT                             ,
  BACOBL     TEXT                             ,
  BACOBLS    TEXT,
  BACLBMD    TEXT                             ,
  BACLBDA    TEXT                             ,
  BACLB      TEXT                             ,
  BACLBS     TEXT,
  BACLBLMD   TEXT                             ,
  BACLBLDA   TEXT                             ,
  BACLBL     TEXT                             ,
  BACLBLS    TEXT,
  BACPBMD    TEXT                             ,
  BACPBDA    TEXT                            ,
  BACPB      TEXT                            ,
  BACPBS     TEXT,
  BACPBLMD   TEXT                             ,
  BACPBLDA   TEXT                             ,
  BACPBL     TEXT                             ,
  BACPBLS    TEXT,
  BACBMD     TEXT                             ,
  BACBDA     TEXT                             ,
  BACBA      TEXT                             ,
  BACBAS     TEXT,
  BACBAR1    TEXT,
  BACBAR2    TEXT,
  BACBAR3    TEXT,
  BACBALMD   TEXT                             ,
  BACBALDA   TEXT                             ,
  BACBAL     TEXT                             ,
  BACBALS    TEXT,
  BACBNFMD   TEXT                             ,
  BACBNFDA   TEXT                             ,
  BACBNF     TEXT                             ,
  BACBNFS    TEXT,
  BACBNFLMD  TEXT                             ,
  BACBNFLDA  TEXT                             ,
  BACBNFL    TEXT                             ,
  BACBNFLS   TEXT,
  BACBNFN    TEXT                             ,
  BACLU      DATE,
  BACMN      TEXT                             ,
  BACLP      DATE,
  BACLBI     TEXT,
  BACLBN     TEXT,
  BACLBD     DATE,
  BACDE      TEXT,
  BACC1      TEXT,
  BACC2      TEXT,
  BACC3      TEXT,
  ROWN1      INTEGER DEFAULT 0,
  GUIDN       TEXT,
  SUID       TEXT,
  SUCH       TEXT,
  DATEI      DATE,
  DATEU      DATE,
  DEVI       TEXT,
  DEVU       TEXT,  
     JTID_L INTEGER,
         BIID_L INTEGER,
         SYID_L INTEGER,
         CIID_L TEXT 
         )  
      ''');
    await db.execute('''
       CREATE TABLE TAX_TYP_SYS (
  TTSID  INTEGER,
  TTSSY  TEXT,
  TTSNA  TEXT,
  TTSNE  TEXT,
  TTSN3  TEXT,
  TTSNS  TEXT,
  CWID   INTEGER,
  TTSST  INTEGER                                 DEFAULT 1,
  TTSSE  INTEGER                                 DEFAULT 2,
  TTSCR  INTEGER                                 DEFAULT 2,
  TTSAD  INTEGER                                 DEFAULT 1,
  TTSAE  INTEGER                                 DEFAULT 1,
  TTSNT  INTEGER                                 DEFAULT 2,
  SCID   INTEGER                                 DEFAULT 1,
  ORDNU  INTEGER,
  RES    TEXT,
  SUID   TEXT,
  DATEI  DATE,
  DEVI   TEXT,
  SUCH   TEXT,
  DATEU  DATE,
  DEVU   TEXT,
  DEFN   INTEGER                                 DEFAULT 2,
  GUID   TEXT,
  TTSIDC   TEXT,
  JTID_L INTEGER,
  BIID_L INTEGER,
  SYID_L INTEGER,
  CIID_L TEXT 
         )  
      ''');
    await db.execute('''
       CREATE TABLE TAX_COD_SYS (
  TCSID  INTEGER,
  TTSID  INTEGER,
  TCSSY  TEXT,
  TCSNA  TEXT,
  TCSNE  TEXT,
  TCSN3  TEXT,
  TCSTY  INTEGER                                 DEFAULT 1,
  TCSST  INTEGER                                 DEFAULT 1,
  TCSDA  TEXT,
  TCSDE  TEXT,
  TCSD3  TEXT,
  TCSVL  INTEGER                                 DEFAULT 0,
  ORDNU  INTEGER,
  RES    TEXT,
  SUID   TEXT,
  DATEI  DATE,
  DEVI   TEXT,
  SUCH   TEXT,
  DATEU  DATE,
  DEVU   TEXT,
  DEFN   INTEGER                                 DEFAULT 2,
  GUID   TEXT,
  JTID_L INTEGER,
  BIID_L INTEGER,
  SYID_L INTEGER,
  CIID_L TEXT 
         )  
      ''');
    await db.execute('''
       CREATE TABLE TAX_COD_SYS_D (
    TCSDID  INTEGER,
  TTSID   INTEGER,
  TCSID   INTEGER,
  TCSDSY  TEXT,
  TCSDNA  TEXT,
  TCSDNE  TEXT,
  TCSDN3  TEXT,
  TCSDST  INTEGER                                DEFAULT 1,
  ORDNU   INTEGER,
  RES     TEXT,
  SUID    TEXT,
  DATEI   DATE,
  DEVI    TEXT,
  SUCH    TEXT,
  DATEU   DATE,
  DEVU    TEXT,
  DEFN    INTEGER                                DEFAULT 2,
  GUID    TEXT,
  JTID_L INTEGER,
  BIID_L INTEGER,
  SYID_L INTEGER,
  CIID_L TEXT 
         )  
      ''');
    await db.execute('''
       CREATE TABLE TAX_TYP (
    TTID   INTEGER,
  GUID   TEXT,
  TTSID  INTEGER,
  TTNA   TEXT,
  TTNE   TEXT,
  TTN3   TEXT,
  TTSY   TEXT,
  TTNS   TEXT,
  TTST   INTEGER                                 DEFAULT 1,
  TTDE   TEXT,
  TTDA   DATE,
  TTSE   INTEGER                                 DEFAULT 2,
  TTCR   INTEGER                                 DEFAULT 2,
  TTTL   INTEGER                                 DEFAULT 2,
  TTPE   INTEGER,
  TTTY   INTEGER                                 DEFAULT 1,
  TTAD   INTEGER                                 DEFAULT 1,
  TTAE   INTEGER                                 DEFAULT 1,
  TTNT   INTEGER                                 DEFAULT 2,
  TTDR   INTEGER,
  SCID   INTEGER                                 DEFAULT 1,
  ORDNU  INTEGER,
  RES    TEXT,
  SUID   TEXT,
  DATEI  DATE,
  DEVI   TEXT,
  SUCH   TEXT,
  DATEU  DATE,
  DEVU   TEXT,
  DEFN   INTEGER                                 DEFAULT 2,
  TTUI   INTEGER                                 DEFAULT 2,
  TTUD   DATE,
  TTLN   INTEGER,
  TTIDC   TEXT,
  JTID_L INTEGER,
  BIID_L INTEGER,
  SYID_L INTEGER,
  CIID_L TEXT 
         )  
      ''');
    await db.execute('''
       CREATE TABLE TAX_TYP_BRA (
    TTBID  INTEGER,
  TTID   INTEGER,
  BIID   INTEGER,
  TTBTN  TEXT,
  TTBTS  TEXT,
  TTBTG  TEXT,
  TTBPK  TEXT,
  TTBST  INTEGER                                 DEFAULT 1,
  TTDR   INTEGER,
  ORDNU  INTEGER,
  RES    TEXT,
  SUID   TEXT,
  DATEI  DATE,
  DEVI   TEXT,
  SUCH   TEXT,
  DATEU  DATE,
  DEVU   TEXT,
  DEFN   INTEGER                                 DEFAULT 2,
  GUID   TEXT,
  JTID_L INTEGER,
  BIID_L INTEGER,
  SYID_L INTEGER,
  CIID_L TEXT 
         )  
      ''');
    await db.execute('''
       CREATE TABLE TAX_PER_M (
   TPMID  INTEGER,
  GUID   TEXT,
  TPNA   TEXT,
  TPNE   TEXT,
  TPN3   TEXT,
  TPMTY  INTEGER,
  TTID   INTEGER,
  TPMST  INTEGER                                 DEFAULT 1,
  TPMDE  TEXT,
  TPMFR  DATE,
  TPMTD  DATE,
  SYID   INTEGER,
  ORDNU  INTEGER,
  RES    TEXT,
  SUID   TEXT,
  DATEI  DATE,
  DEVI   TEXT,
  SUCH   TEXT,
  DATEU  DATE,
  DEVU   TEXT,
  DEFN   INTEGER,
  JTID_L INTEGER,
  BIID_L INTEGER,
  SYID_L INTEGER,
  CIID_L TEXT 
         )  
      ''');
    await db.execute('''
       CREATE TABLE TAX_PER_D (
    TPDID  INTEGER,
  GUID   TEXT,
  TPDNO  INTEGER,
  TPDNA  TEXT,
  TPDNE  TEXT,
  TPDN3  TEXT,
  TPMID  INTEGER,
  TPDST  INTEGER                                 DEFAULT 1,
  TPDFR  DATE,
  TPDTD  DATE,
  SYID   INTEGER,
  ORDNU  INTEGER,
  RES    TEXT,
  SUID   TEXT,
  DATEI  DATE,
  DEVI   TEXT,
  SUCH   TEXT,
  DATEU  DATE,
  DEVU   TEXT,
  DEFN   INTEGER       ,
  JTID_L INTEGER,
  BIID_L INTEGER,
  SYID_L INTEGER,
  CIID_L TEXT 
         )  
      ''');
    await db.execute('''
       CREATE TABLE TAX_PER_BRA (
     TPBID  INTEGER,
  TPMID  INTEGER,
  GUID   TEXT,
  TPDID  INTEGER,
  BIID   INTEGER,
  TPBST  INTEGER                                 DEFAULT 1,
  TPBDE  TEXT,
  ORDNU  INTEGER,
  RES    TEXT,
  SUID   TEXT,
  DATEI  DATE,
  DEVI   TEXT,
  SUCH   TEXT,
  DATEU  DATE,
  DEVU   TEXT,
  DEFN   INTEGER,
  JTID_L INTEGER,
  BIID_L INTEGER,
  SYID_L INTEGER,
  CIID_L TEXT 
         )  
      ''');
    await db.execute('''
       CREATE TABLE TAX_COD (
   TCID    INTEGER,
  GUID    TEXT,
  TTID    INTEGER,
  TCNA    TEXT,
  TCNE    TEXT,
  TCN3    TEXT,
  TCSY    TEXT,
  TCST    INTEGER                                DEFAULT 1,
  TCDA    TEXT,
  TCDE    TEXT,
  TCD3    TEXT,
  TCSID   INTEGER,
  TCSSY   TEXT,
  TCSDSY  TEXT,
  TCIT    INTEGER                                DEFAULT 1,
  TCAC    INTEGER                                DEFAULT 1,
  TCVL    INTEGER                                DEFAULT 0,
  ORDNU   INTEGER,
  RES     TEXT,
  SUID    TEXT,
  DATEI   DATE,
  DEVI    TEXT,
  SUCH    TEXT,
  DATEU   DATE,
  DEVU    TEXT,
  DEFN    INTEGER,
  JTID_L INTEGER,
  BIID_L INTEGER,
  SYID_L INTEGER,
  CIID_L TEXT 
         )  
      ''');
    await db.execute('''
       CREATE TABLE TAX_SYS (
    TSID    INTEGER,
  GUID    TEXT,
  TTID    INTEGER,
  STID    TEXT,
  TSST    INTEGER                                DEFAULT 1,
  TSCT    INTEGER                             DEFAULT 5,
  TSRA    INTEGER,
  TSPT    INTEGER                                DEFAULT 2,
  AANOO   TEXT,
  AANOI   TEXT,
  AANOR   TEXT,
  AANORR  TEXT,
  TSDC    INTEGER,
  TSFR    INTEGER                                DEFAULT 2,
  TSDI    INTEGER                                DEFAULT 2,
  TSAT    INTEGER                                DEFAULT 1,
  TSCR    INTEGER                                DEFAULT 2,
  TSPR    INTEGER                                DEFAULT 3,
  TSQR    INTEGER                                DEFAULT 1,
  TSQRT   INTEGER                                DEFAULT 2,
  TSAM    INTEGER                                DEFAULT 0,
  TSDL    INTEGER                                DEFAULT 1,
  TSUP    INTEGER                                DEFAULT 1,
  TSSNF   INTEGER                                DEFAULT 1,
  TSRF    INTEGER                                DEFAULT 1,
  TSCA    INTEGER                                DEFAULT 1,
  TSVCA   INTEGER                                DEFAULT 1,
  TSVIA   INTEGER                                DEFAULT 1,
  TSVOA   INTEGER                                DEFAULT 1,
  TSRE    TEXT,
  TSRES   TEXT,
  TSRET   TEXT,
  TSRETS  TEXT,
  ORDNU   INTEGER,
  RES     TEXT,
  SUID    TEXT,
  DATEI   DATE,
  DEVI    TEXT,
  SUCH    TEXT,
  DATEU   DATE,
  DEVU    TEXT,
  DEFN    INTEGER                                DEFAULT 2,
  TSDT    INTEGER,
  JTID_L INTEGER,
  BIID_L INTEGER,
  SYID_L INTEGER,
  CIID_L TEXT 
         )  
      ''');
    await db.execute('''
       CREATE TABLE TAX_SYS_BRA (
  TSBID   INTEGER,
  GUID    TEXT,
  TSID    INTEGER,
  BIID    INTEGER,
  TSBDC   INTEGER,
  AANOO   TEXT,
  AANOI   TEXT,
  AANOR   TEXT,
  AANORR  TEXT,
  SUID   TEXT,
  DATEI  DATE,
  DEVI   TEXT,
  SUCH   TEXT,
  DATEU  DATE,
  DEVU   TEXT,
  TSBST INTEGER DEFAULT 1,
  JTID_L INTEGER,
  BIID_L INTEGER,
  SYID_L INTEGER,
  CIID_L TEXT 
         )  
      ''');
    await db.execute('''
       CREATE TABLE TAX_SYS_D (
  TSDID  INTEGER,
  GUID   TEXT,
  TSID   INTEGER,
  STID   TEXT,
  TTID   INTEGER,
  TCID   INTEGER,
  TSDMN  TEXT,
  TTST   INTEGER                                 DEFAULT 1,
  TTDE   TEXT,
  ORDNU  INTEGER,
  RES    TEXT,
  SUID   TEXT,
  DATEI  DATE,
  DEVI   TEXT,
  SUCH   TEXT,
  DATEU  DATE,
  DEVU   TEXT,
  DEFN   INTEGER,
  TSDQR   TEXT,
  JTID_L INTEGER,
  BIID_L INTEGER,
  SYID_L INTEGER,
  CIID_L TEXT 
         )  
      ''');
    await db.execute('''
       CREATE TABLE TAX_LIN (
  TLID      INTEGER,
  GUID      TEXT,
  TLTY      TEXT,
  TLNO      TEXT,
  TLNO2     TEXT,
  TLNO3     INTEGER,
  TTID      INTEGER,
  TLIDL     INTEGER,
  TCIDI     INTEGER,
  TCSDIDI   INTEGER,
  TLRAI     INTEGER,
  TCIDO     INTEGER,
  TCSDIDO   INTEGER,
  TLRAO     INTEGER,
  TLTN      TEXT,
  TLTN2     TEXT,
  TLGN      TEXT,
  TLST      INTEGER                              DEFAULT 1,
  TLDE      TEXT,
  TLAF1     TEXT,
  TLAF2     TEXT,
  ORDNU     INTEGER,
  RES       TEXT,
  SUID      TEXT,
  DATEI     DATE,
  DEVI      TEXT,
  SUCH      TEXT,
  DATEU     DATE,
  DEVU      TEXT,
  DEFN      INTEGER                              DEFAULT 2,
  GUID_LNK  TEXT,
  JTID_L INTEGER,
  BIID_L INTEGER,
  SYID_L INTEGER,
  CIID_L TEXT 
         )  
      ''');
    await db.execute('''
       CREATE TABLE IDE_TYP (
  ITID   INTEGER,
  GUID   TEXT,
  ITNA   TEXT,
  ITNE   TEXT,
  ITN3   TEXT,
  ITSY   TEXT,
  ITST   INTEGER                                 DEFAULT 1,
  ITAD   INTEGER                                 DEFAULT 1,
  ORDNU  INTEGER,
  RES    TEXT,
  SUID   TEXT,
  DATEI  DATE,
  DEVI   TEXT,
  SUCH   TEXT,
  DATEU  DATE,
  DEVU   TEXT,
  DEFN   INTEGER ,
  JTID_L INTEGER,
  BIID_L INTEGER,
  SYID_L INTEGER,
  CIID_L TEXT 
         )  
      ''');
    await db.execute('''
       CREATE TABLE IDE_LIN (
  ILID      INTEGER,
  GUID      TEXT,
  ITID      INTEGER,
  ILTY      TEXT,
  ILNO      TEXT,
  ILNO2     TEXT,
  ILDE      TEXT,
  ILST      INTEGER                              DEFAULT 1,
  ILAF1     TEXT,
  ILAF2     TEXT,
  ORDNU     INTEGER,
  RES       TEXT,
  SUID      TEXT,
  DATEI     DATE,
  DEVI      TEXT,
  SUCH      TEXT,
  DATEU     DATE,
  DEVU      TEXT,
  DEFN      INTEGER                              DEFAULT 2,
  GUID_LNK  TEXT,
  JTID_L INTEGER,
  BIID_L INTEGER,
  SYID_L INTEGER,
  CIID_L TEXT 
         )  
      ''');
    await db.execute('''
       CREATE TABLE SYN_ORD_L (
   SOLSQ           INTEGER,
  SOID            TEXT,
  STMID           TEXT,
  STID            TEXT,
  SOKI            TEXT,
  SOTY            TEXT,
  SOET            TEXT,
  SOFT            TEXT,
  SOTT            TEXT,
  SDSQ            INTEGER,
  SDNO            TEXT,
  GUID            TEXT,
  SDTY            TEXT,
  CIID            INTEGER,
  JTID            INTEGER,
  SYID            INTEGER,
  SYDV_NAME       TEXT,
  SYDV_IP         TEXT,
  SYDV_SER        TEXT,
  SYDV_POI        TEXT,
  SYDV_NO         TEXT,
  SYDV_BRA        TEXT,
  SOLST           INTEGER                        DEFAULT 2,
  BIID            INTEGER,
  SOLKI           INTEGER,
  SOLDO           DATE,
  SOLID           INTEGER,
  SOLNO           INTEGER,
  SOLAM           REAL                        DEFAULT 0,
  SOLGU           TEXT,
  SUID            TEXT,
  BIID2           INTEGER,
  SOLKI2          INTEGER,
  SOLDO2          DATE,
  SOLID2          INTEGER,
  SOLNO2          INTEGER,
  SOLAM2          REAL                        DEFAULT 0,
  SOLGU2          TEXT,
  SUID2           TEXT,
  SOLER           TEXT,
  SOLIN           TEXT,
  SOLN1           INTEGER,
  SOLN2           INTEGER,
  SOLN3           INTEGER,
  SOLC1           TEXT,
  SOLC2           TEXT,
  SOLC3           TEXT,
  DATEI           DATE,
  SUCH            TEXT,
  DATEU           DATE,
  SYDV_LATITUDE   TEXT,
  SYDV_LONGITUDE  TEXT,
  SYDV_APPV       TEXT,
  SMID            INTEGER,
  SYDV_TY         TEXT,
  SYDV_ID         TEXT,
  SYDV_APIV       TEXT,
  SYDV_GU         TEXT,
  SOGU            TEXT,
  SOLNT           INTEGER,
  SOLDF           DATE,
  JTID_L INTEGER,
  BIID_L INTEGER,
  SYID_L INTEGER,
  CIID_L TEXT 
         )  
      ''');
    await db.execute('''
       CREATE TABLE ACC_CAS_U (
   ACID   INTEGER,
  ACUTY  INTEGER                             DEFAULT 1,
  SUID   TEXT,
  ACCT   INTEGER                             DEFAULT 1,
  SCID   INTEGER,
  ACTMS  INTEGER                             DEFAULT 1,
  ACTMP  INTEGER                             DEFAULT 0,
  ACUST  INTEGER                             DEFAULT 1,
  ACUAM  REAL,
  SUCH   TEXT,
  GUID   TEXT,
  DATEI  DATE,
  DATEU  DATE,
  DEVI   TEXT,
  DEVU   TEXT,
  SUID2  TEXT,
  ORDNU  INTEGER,
  DEFN  INTEGER,
  RES  TEXT,
  SCIDV  TEXT,
  JTID_L INTEGER,
  BIID_L INTEGER,
  SYID_L INTEGER,
  CIID_L TEXT 
         )  
      ''');
    await db.execute('''
       CREATE TABLE TAX_LOC (
   TLID   INTEGER,
  GUID  TEXT ,
  TLSY   TEXT,
  TLNA   TEXT ,
  TLNE   TEXT,
  TLN3  TEXT,
  TTID  INTEGER                             DEFAULT 0,
  CWID  INTEGER                             DEFAULT 1,
  CTID  INTEGER,
  TLST   INTEGER,
  TLDE   TEXT,
  AANOO  TEXT,
  AANOI  TEXT,
  AANOR   TEXT,
  AANORR   TEXT,
  TLDC  INTEGER,
  ORDNU  INTEGER,
  RES  TEXT,
  SUID  TEXT,
  DATEI  TEXT,
  DEVI  TEXT,
  SUCH  TEXT,
  DATEU  TEXT,
  DEVU  TEXT,
  DEFN INTEGER,
  JTID_L INTEGER,
  BIID_L INTEGER,
  SYID_L INTEGER,
  CIID_L TEXT 
         )  
      ''');
    await db.execute('''
       CREATE TABLE TAX_LOC_SYS (
   TLSID   INTEGER,
  TLID    INTEGER,
  STID    TEXT,
  GUID    TEXT,
  AANOO   TEXT,
  AANOI   TEXT,
  AANOR   TEXT,
  AANORR  TEXT,
  TLSDC   INTEGER,
  ORDNU   INTEGER,
  RES     TEXT,
  SUID    TEXT,
  DATEI   TEXT ,
  DEVI    TEXT,
  SUCH    TEXT,
  DATEU   TEXT,
  DEVU    TEXT,
  DEFN    INTEGER ,
  JTID_L INTEGER,
  BIID_L INTEGER,
  SYID_L INTEGER,
  CIID_L TEXT 
         )  
      ''');
    await db.execute('''
       CREATE TABLE TAX_MOV_SIN (
  TMSID   INTEGER,
  GUID    TEXT,
  TMSNA   TEXT,
  TMSNE   TEXT,
  TMSN3   TEXT,
  TMSSY   TEXT,
  TMSST   INTEGER                                DEFAULT 1,
  TMSDE   TEXT,
  TMSDE2  TEXT,
  TTID    INTEGER,
  TCID    INTEGER,
  TCSID   INTEGER,
  TCSSY   TEXT,
  TCSDSY  TEXT,
  TMSIT   INTEGER                                DEFAULT 1,
  TMSAC   INTEGER                                DEFAULT 2,
  TMSCO   TEXT,
  TMSDL   INTEGER                                DEFAULT 1,
  TMSUP   INTEGER                                DEFAULT 1,
  ORDNU   INTEGER,
  RES     TEXT,
  SUID    TEXT,
  DATEI   TEXT,
  DEVI    TEXT,
  SUCH    TEXT,
  DATEU   TEXT,
  DEVU    TEXT,
  DEFN    INTEGER ,
  JTID_L INTEGER,
  BIID_L INTEGER,
  SYID_L INTEGER,
  CIID_L TEXT 
         )  
      ''');
    await db.execute('''
       CREATE TABLE TAX_VAR (
 TVID   INTEGER,
  TVSY   TEXT,
  TVNA   TEXT,
  TVNE   TEXT,
  TVN3   TEXT,
  TVVL   TEXT,
  TVDT   TEXT,
  TVDS   TEXT,
  TVDH   INTEGER,
  TVDA   INTEGER,
  TVAD   INTEGER ,
  STID   TEXT,
  STMID  TEXT,
  PRID   TEXT,
  PRIDY  TEXT,
  PRIDN  TEXT,
  TVDAC  INTEGER,
  TVCH   INTEGER,
  TVDL   INTEGER,
  TVIDF  INTEGER,
  TVST   INTEGER,
  ORDNU  INTEGER,
  RES   TEXT,
  SUID   TEXT,
  DATEI  TEXT,
  DEVI   TEXT,
  SUCH   TEXT,
  DATEU  TEXT,
  DEVU   TEXT,
  DEFN   INTEGER,
  GUID   TEXT,
  JTID_L INTEGER,
  BIID_L INTEGER,
  SYID_L INTEGER,
  CIID_L TEXT 
         )  
      ''');
    await db.execute('''
       CREATE TABLE TAX_VAR_D (
  TVDID   INTEGER,
  TVID    INTEGER,
  TTID    INTEGER,
  TVDSY   TEXT,
  TVDTY   INTEGER,
  TVDVL   TEXT,
  TVDDA   DATE,
  STID    TEXT,
  STMID   TEXT,
  PRID    TEXT,
  PRIDY   TEXT,
  PRIDN   TEXT,
  TVDCH   INTEGER,
  TVDIDF  INTEGER,
  TVDST   INTEGER,
  ORDNU   INTEGER,
  RES     TEXT,
  SUID    TEXT,
  DATEI   TEXT,
  DEVI    TEXT,
  SUCH    TEXT,
  DATEU   TEXT,
  DEVU    TEXT,
  DEFN    INTEGER ,
  GUID   TEXT,
  JTID_L INTEGER,
  BIID_L INTEGER,
  SYID_L INTEGER,
  CIID_L TEXT 
         )  
      ''');
    await db.execute('''
       CREATE TABLE TAX_TBL_LNK (
TTLID     INTEGER,
  GUID     TEXT,
  TTID      INTEGER,
  TTLNA     TEXT,
  TTLNE     TEXT,
  TTLN3     TEXT,
  STID     TEXT,
  TTLTB     TEXT,
  TTLNO    TEXT,
  TTLNO2   TEXT,
  TTLSY     TEXT,
  TTLNOL   TEXT,
  TTLNO2L  TEXT,
  TTLSY2    TEXT,
  TTLNOL2  TEXT,
  TTLNO2L2 TEXT,
  TTLST     INTEGER,
  TTLCO    TEXT,
  TTLLN     INTEGER,
  TTLHN     INTEGER,
  TTLDE     TEXT,
  TTLVB     INTEGER,
  TTLVN     INTEGER,
  TTLVF     INTEGER,
  TTLSN     TEXT,
  TTLUP     INTEGER,
  TTLDL     INTEGER,
  TTLN1     INTEGER,
  TTLN2     INTEGER,
  TTLC1     TEXT,
  TTLC2     TEXT,
  ORDNU     INTEGER,
  RES       TEXT,
  SUID      TEXT,
  DATEI     TEXT,
  DEVI      TEXT,
  SUCH      TEXT,
  DATEU     TEXT,
  DEVU      TEXT,
  DEFN      INTEGER,               
  TTLSYM      TEXT,               
  JTID_L INTEGER,
  BIID_L INTEGER,
  SYID_L INTEGER,
  CIID_L TEXT 
         )  
      ''');
    await db.execute('''
       CREATE TABLE RES_SEC (
  RSID   INTEGER,
  RSNA   TEXT,
  RSNE   TEXT,
  RSHN   TEXT,
  RSST   INTEGER                            DEFAULT 1,
  RSFN   INTEGER,
  RSIN   TEXT,
  BIID   INTEGER,
  ORDNU  INTEGER,
  RES    TEXT,
  DATEI  DATE,
  SUID   TEXT,
  SUCH   TEXT,
  DATEU  DATE,
  DEVI   TEXT,
  DEVU   TEXT,
  DEFN   INTEGER,
  RSN3   TEXT,
  GUID   TEXT,               
  JTID_L INTEGER,
  BIID_L INTEGER,
  SYID_L INTEGER,
  CIID_L TEXT 
         )  
      ''');
    await db.execute('''
       CREATE TABLE RES_TAB (
  RSID   INTEGER,
  RTID   TEXT,
  RTNA   TEXT,
  RTNE   TEXT,
  RTST   INTEGER                            DEFAULT 1,
  RTIN   TEXT,
  BIID   INTEGER,
  ORDNU  INTEGER,
  RES    TEXT,
  DATEI  DATE,
  SUID   TEXT,
  SUCH   TEXT,
  DATEU  DATE,
  DEVI   TEXT,
  DEVU   TEXT,
  DEFN   INTEGER,
  RTN3   TEXT,
  GUID   TEXT,              
  JTID_L INTEGER,
  BIID_L INTEGER,
  SYID_L INTEGER,
  CIID_L TEXT 
         )  
      ''');
    await db.execute('''
       CREATE TABLE RES_EMP (
  REID   INTEGER,
  RSID   INTEGER,
  RENA   TEXT,
  RENE   TEXT,
  REST   INTEGER                            DEFAULT 1,
  REIN   TEXT,
  BIID   INTEGER,
  ORDNU  INTEGER,
  RES    TEXT,
  DATEI  DATE,
  SUID   TEXT,
  SUCH   TEXT,
  DATEU  DATE,
  DEVI   TEXT,
  DEVU   TEXT,
  DEFN   INTEGER,
  REN3   TEXT,
  GUID   TEXT,              
  JTID_L INTEGER,
  BIID_L INTEGER,
  SYID_L INTEGER,
  CIID_L TEXT 
         )  
      ''');
    await db.execute('''
       CREATE TABLE BIF_GRO (
  MGNO  TEXT,
  BGOR  INTEGER,
  BGBR  TEXT,
  BGCR  TEXT,
  BGMA  TEXT,  
  DATEI  DATE,
  SUID   TEXT,
  SUCH   TEXT,
  DATEU  DATE,
  DEVI   TEXT,
  DEVU   TEXT,
  BGST   INTEGER,
  GUID   TEXT,            
  JTID_L INTEGER,
  BIID_L INTEGER,
  SYID_L INTEGER,
  CIID_L TEXT 
         )  
      ''');
    await db.execute('''
       CREATE TABLE BIF_GRO2 (
  MGNO  TEXT,
  BGOR  INTEGER,
  BGBR  TEXT,
  BGCR  TEXT,
  BGMA  TEXT, 
  BGST   INTEGER, 
  DATEI  DATE,
  SUID   TEXT,
  SUCH   TEXT,
  DATEU  DATE,
  DEVI   TEXT,
  DEVU   TEXT,
  GUID   TEXT,            
  JTID_L INTEGER,
  BIID_L INTEGER,
  SYID_L INTEGER,
  CIID_L TEXT 
         )  
      ''');
    await db.execute('''
       CREATE TABLE BIF_MOV_A (
 BMKID  INTEGER,
  BMMID  INTEGER,
  BMMNO  INTEGER,
  RSID   INTEGER,
  RTID   TEXT,
  REID   INTEGER,
  BMATY  INTEGER                             DEFAULT 1,
  GUID   TEXT,
  BDID   INTEGER,
  BMACR  REAL                            DEFAULT 0,
  BMACA  REAL                           DEFAULT 0,
  BCDID  INTEGER,
  GUIDR  TEXT,
  BMADD  DATE                                   DEFAULT SYSDATE,
  BMADT  REAL                        DEFAULT 0,
  PKIDB  INTEGER                            DEFAULT 1,
  GUIDP  TEXT,              
  JTID_L INTEGER,
  BIID_L INTEGER,
  SYID_L INTEGER,
  CIID_L TEXT 
         )  
      ''');
    await db.execute('''
       CREATE TABLE MAT_FOL (
 BIID  INTEGER,
  MGNO  TEXT,
  MINO  TEXT,
  MUID   INTEGER,
  MFNO   REAL,
  MGNOF   TEXT,
  MINOF  TEXT ,
  MUIDF   INTEGER,
  MFNOF   REAL,
  MFDO  TEXT,
  MFIN  TEXT,
  MFST  INTEGER,
  MFID  INTEGER ,
  DATEI  DATE,
  SUID   TEXT,
  SUCH   TEXT,
  DATEU  DATE,
  DEVI   TEXT,
  DEVU   TEXT,
  GUID   TEXT,            
  JTID_L INTEGER,
  BIID_L INTEGER,
  SYID_L INTEGER,
  CIID_L TEXT 
         )  
      ''');
    await db.execute('''
       CREATE TABLE MAT_DES_M (
  MDMID  INTEGER,
  MDMNA  TEXT,
  MDMNE  TEXT,
  MDMN3  TEXT,
  MDMDE  TEXT,
  MGNOT  INTEGER                                 DEFAULT 1,
  MDMST  INTEGER                                 DEFAULT 1,
  ORDNU  INTEGER,
  RES    TEXT,
  SUID   TEXT,
  DATEI  DATE,
  DEVI   TEXT,
  SUCH   TEXT,
  DATEU  DATE,
  DEVU   TEXT,
  DEFN   INTEGER,
  GUID   TEXT,
  JTID_L INTEGER,
  BIID_L INTEGER,
  SYID_L INTEGER,
  CIID_L TEXT 
         )  
      ''');
    await db.execute('''
       CREATE TABLE MAT_DES_D (
   MDDID  INTEGER,
  MDMID  INTEGER,
  MGNO   TEXT,
  MINO   TEXT,
  MDDST  INTEGER                                 DEFAULT 1,
  ORDNU  INTEGER,
  RES    TEXT,
  SUID   TEXT,
  DATEI  DATE,
  DEVI   TEXT,
  SUCH   TEXT,
  DATEU  DATE,
  DEVU   TEXT,
  DEFN   INTEGER                                 DEFAULT 2,
  GUID   TEXT,
  JTID_L INTEGER,
  BIID_L INTEGER,
  SYID_L INTEGER,
  CIID_L TEXT 
         )  
      ''');
    await db.execute('''
       CREATE TABLE BIF_EORD_M (
   BMKID INTEGER,
BMMID INTEGER,
GUID TEXT,
BEMPS INTEGER DEFAULT 1,
BEMPCS  INTEGER DEFAULT 1,
BEMIPS  INTEGER DEFAULT 1,
BEMBS  INTEGER DEFAULT 1,
SUID   TEXT,
DATEI  DATE,
DEVI   TEXT,
SUCH   TEXT,
DATEU  DATE,
DEVU   TEXT,
  JTID_L INTEGER,
  BIID_L INTEGER,
  SYID_L INTEGER,
  CIID_L TEXT 
         )  
      ''');
    await db.execute('''
       CREATE TABLE MAT_DIS_T (
   MDTID  INTEGER,
  MDTNA  TEXT,
  MDTNE  TEXT,
  MDTN3  TEXT,
  MDTST  INTEGER                             DEFAULT 1,
  SUID   TEXT,
  DATEI  DATE,
  SUCH   TEXT,
  DATEU  DATE,
    DEVI   TEXT,
  DEVU   TEXT,
  GUID   TEXT,
  JTID_L INTEGER,
  BIID_L INTEGER,
  SYID_L INTEGER,
  CIID_L TEXT 
         )  
      ''');
    await db.execute('''
       CREATE TABLE MAT_DIS_K (
   MDKID  INTEGER,
  MDTID  INTEGER                             DEFAULT 0,
  MDKNA  TEXT,
  MDKNE  TEXT,
  MDKN3  TEXT,
  MDKST  INTEGER                             DEFAULT 1,
  SUID   TEXT,
  DATEI  DATE,
  SUCH   TEXT,
  DATEU  DATE,
    DEVI   TEXT,
  DEVU   TEXT,
  GUID   TEXT,
  JTID_L INTEGER,
  BIID_L INTEGER,
  SYID_L INTEGER,
  CIID_L TEXT 
         )  
      ''');
    await db.execute('''
       CREATE TABLE MAT_DIS_M (
    GUID     TEXT,
  MDMID    INTEGER,
  MDTID    INTEGER,
  MDKID    INTEGER,
  MDMRA    REAL                               DEFAULT 0,
  MDMSM    INTEGER                          DEFAULT 1,
  MDMCO    REAL                               DEFAULT 0,
  MDMAM    REAL                               DEFAULT 0,
  MDMMN    REAL                               DEFAULT 0,
  MDMCR    INTEGER                           DEFAULT 0,
  MDMCR2   INTEGER,
  MDMCR3   INTEGER,
  MDMOI    INTEGER                         DEFAULT 0,
  MDMFD    DATE,
  MDMTD    DATE,
  MDMFDA   INTEGER,
  MDMTDA   INTEGER,
  MDMFM    INTEGER,
  MDMTM    INTEGER,
  MDMFY    INTEGER,
  MDMTY    INTEGER,
  MDMFT    INTEGER,
  MDMTT    INTEGER,
  MDMDAYT  INTEGER                           DEFAULT 0,
  MDMDAY   TEXT,
  MDMST    INTEGER                         DEFAULT 1,
  MDMDE    TEXT,
  MDMRE    TEXT,
  SUID     TEXT,
  DATEI    DATE,
  SUCH     TEXT,
  DATEU    DATE,
    DEVI   TEXT,
  DEVU   TEXT,
  JTID_L INTEGER,
  BIID_L INTEGER,
  SYID_L INTEGER,
  CIID_L TEXT 
         )  
      ''');
    await db.execute('''
       CREATE TABLE MAT_DIS_D (
    GUID   TEXT,
  MDDID  INTEGER,
  MDMID  INTEGER,
  MGNO   TEXT,
  MINO   TEXT,
  MUID   INTEGER,
  MDDRA  REAL,
  MDDNU  REAL                                 DEFAULT 0,
  MDDAM  REAL                                 DEFAULT 0,
  MDDMN  REAL                                 DEFAULT 0,
  MDDSI  INTEGER                            DEFAULT 1,
  MDDST  INTEGER                                 DEFAULT 1,
  SUID   TEXT,
  DATEI  DATE,
  SUCH   TEXT,
  DATEU  DATE,
    DEVI   TEXT,
  DEVU   TEXT,
  JTID_L INTEGER,
  BIID_L INTEGER,
  SYID_L INTEGER,
  CIID_L TEXT 
         )  
      ''');
    await db.execute('''
       CREATE TABLE MAT_DIS_F (
    GUID   TEXT,
  MDFID  INTEGER,
  MDDID  INTEGER,
  MDMID  INTEGER,
  MGNO   TEXT,
  MINO   TEXT,
  MUID   INTEGER,
  MDFFN  INTEGER,
  MDFTN  INTEGER,
  SCID   INTEGER,
  MDFMP  INTEGER,
  MDFRA  INTEGER,
  MDFNU  INTEGER                                 DEFAULT 0,
  MDFAM  INTEGER                                 DEFAULT 0,
  MDFMN  INTEGER                                 DEFAULT 0,
  MDFST  INTEGER                             DEFAULT 1,
  SUID   TEXT,
  DATEI  DATE,
  SUCH   TEXT,
  DATEU  DATE,
  DEVI   TEXT,
  DEVU   TEXT,
  JTID_L INTEGER,
  BIID_L INTEGER,
  SYID_L INTEGER,
  CIID_L TEXT 
         )  
      ''');
    await db.execute('''
       CREATE TABLE MAT_DIS_L (
    GUID   TEXT,
   GUIDM  TEXT,
  GUIDD  TEXT,
  MMMID  INTEGER,
  MDMID  INTEGER,
  MDLST  INTEGER                             DEFAULT 1,
  SUID   TEXT,
  DATEI  DATE,
  SUCH   TEXT,
  DATEU  DATE,
    DEVI   TEXT,
  DEVU   TEXT,
  MCKID  INTEGER,
  JTID_L INTEGER,
  BIID_L INTEGER,
  SYID_L INTEGER,
  CIID_L TEXT 
         )  
      ''');
    await db.execute('''
       CREATE TABLE MAT_DIS_N (
    GUID    TEXT,
  MDNID   INTEGER,
  MMMID   INTEGER,
  MDMID   INTEGER,
  MDDID   INTEGER,
  MDFID   INTEGER,
  GUIDM   TEXT,
  MDNAM   INTEGER                                DEFAULT 0,
  MDNAM2  INTEGER                                DEFAULT 0,
  MDNNU   INTEGER                                DEFAULT 0,
  MDNNU2  INTEGER                                DEFAULT 0,
  MDNMN   INTEGER                                DEFAULT 0,
  MDNMN2  INTEGER                                DEFAULT 0,
  MDNN2   INTEGER                                DEFAULT 0,
  MDNN22  INTEGER                                DEFAULT 0,
  MDNN3   INTEGER                                DEFAULT 0,
  MDNN32  INTEGER                                DEFAULT 0,
  MDNC1   TEXT,
  MDNC2   TEXT,
  MDNST   INTEGER                            DEFAULT 1,
  SUID    TEXT,
  DATEI   DATE,
  SUCH    TEXT,
  DATEU   DATE,
    DEVI   TEXT,
  DEVU   TEXT,
  JTID_L INTEGER,
  BIID_L INTEGER,
  SYID_L INTEGER,
  CIID_L TEXT 
         )  
      ''');
    await db.execute('''
       CREATE TABLE MAT_DIS_S (
      GUID   TEXT,
  MDSST  INTEGER                                 DEFAULT 2,
  MDSRE  TEXT,
  SUID   TEXT,
  DATEI  DATE,
  SUCH   TEXT,
  DATEU  DATE,
    DEVI   TEXT,
  DEVU   TEXT,
  JTID_L INTEGER,
  BIID_L INTEGER,
  SYID_L INTEGER,
  CIID_L TEXT 
         )  
      ''');
    await db.execute('''
       CREATE TABLE SYN_TAS (
       CIID INTEGER,
       JTID INTEGER,
       BIID INTEGER,
       SYID INTEGER,
 GUID    TEXT, 
 STMID   TEXT,
 STKI    TEXT, 
 STTY    TEXT,
 STTB    TEXT,
 STDE    TEXT,
 STDE2   TEXT,
 STDE3   TEXT,
 STFU    TEXT,
 STTU    TEXT,
 STFID   INTEGER,
 STTID   INTEGER,
 STFD    DATE, 
 STTD    DATE,
 STIM    INTEGER DEFAULT 2, 
 STST    INTEGER DEFAULT 1, 
 SUID    TEXT, 
 DATEI   DATE, 
 DEVI    TEXT,
 SUCH    TEXT,
 DATEU   DATE, 
 DEVU    TEXT,
  JTID_L INTEGER,
  BIID_L INTEGER,
  SYID_L INTEGER,
  CIID_L TEXT 
         )  
      ''');
    await db.execute('''
       CREATE TABLE MAT_MAI_M (
       GUID    TEXT,
  MMMID   INTEGER,
  MMMDE   TEXT,
  BIIDT   INTEGER                                DEFAULT 0,
  BIID    TEXT,
  MMMBLT  INTEGER                                DEFAULT 0,
  MMMBL   TEXT,
  PKIDT   INTEGER                                DEFAULT 0,
  PKID    TEXT,
  BCCIDT  INTEGER                                DEFAULT 0,
  BCCID   TEXT,
  SCIDT   INTEGER                                DEFAULT 0,
  SCID    TEXT,
  BCTIDT  INTEGER                                DEFAULT 0,
  BCTID   TEXT,
  BCIDT   INTEGER                                DEFAULT 0,
  BCDIDT  INTEGER                                DEFAULT 0,
  CIIDT   INTEGER                                DEFAULT 0,
  ECIDT   INTEGER                                DEFAULT 0,
  SIIDT   INTEGER                                DEFAULT 0,
  SIID    TEXT,
  ACNOT   INTEGER                                DEFAULT 0,
  ACNO    TEXT,
  SUIDT   INTEGER                                DEFAULT 0,
  SUIDV   TEXT,
  MMMFD   DATE,
  MMMTD   DATE,
  MMMFT   INTEGER,
  MMMTT   INTEGER,
  MMMDAY  TEXT,
  ORDNU   INTEGER,
  SUID    TEXT,
  DATEI   DATE,
  SUCH    TEXT,
  DATEU   DATE,
  MMMST   INTEGER                                DEFAULT 1,
  DEVI    TEXT,
  DEVU    TEXT,
  JTID_L INTEGER,
  BIID_L INTEGER,
  SYID_L INTEGER,
  CIID_L TEXT 
         )  
      ''');
    await db.execute('''
       CREATE TABLE BIL_MOV_DD (
       BMDSQ   INTEGER,
  BMKID   INTEGER,
  BMMID   INTEGER,
  BMDID   INTEGER,
  GUID    TEXT,
  MMMID   INTEGER,
  MDMID   INTEGER,
  MDDID   INTEGER,
  MDFID   INTEGER,
  GUIDM   TEXT,
  MDTID   INTEGER                                DEFAULT 2,
  MGNO    TEXT,
  MINO    TEXT,
  MUID    INTEGER,
  BMDAM   REAL                                DEFAULT 0,
  BMDNO   REAL                                DEFAULT 0,
  BMDRE   REAL                                DEFAULT 0,
  BMDN1   INTEGER                                DEFAULT 0,
  BMDN2   INTEGER                                DEFAULT 0,
  BMDC1   TEXT,
  BMDC2   TEXT,
  BMDC3   TEXT,
  BMDST   INTEGER                                DEFAULT 1,
  BMDSQR  INTEGER,
  MCKID   INTEGER                                DEFAULT 1,
  MCDID   INTEGER,
  JTID_L INTEGER,
  BIID_L INTEGER,
  SYID_L INTEGER,
  CIID_L TEXT 
         )  
      ''');
    await db.execute('''
       CREATE TABLE BIF_MOV_DD (
       BMDSQ   INTEGER,
  BMKID   INTEGER,
  BMMID   INTEGER,
  BMDID   INTEGER,
  GUID    TEXT,
  MMMID   INTEGER,
  MDMID   INTEGER,
  MDDID   INTEGER,
  MDFID   INTEGER,
  GUIDM   TEXT,
  MDTID   INTEGER                                DEFAULT 2,
  MGNO    TEXT,
  MINO    TEXT,
  MUID    INTEGER,
  BMDAM   REAL                                DEFAULT 0,
  BMDNO   REAL                                DEFAULT 0,
  BMDRE   REAL                                DEFAULT 0,
  BMDN1   INTEGER                                DEFAULT 0,
  BMDN2   INTEGER                                DEFAULT 0,
  BMDC1   TEXT,
  BMDC2   TEXT,
  BMDC3   TEXT,
  BMDST   INTEGER                                DEFAULT 1,
  BMDSQR  INTEGER,
  MCKID   INTEGER                                DEFAULT 1,
  MCDID   INTEGER,
    TDKID    TEXT,
  TCKID    TEXT,
  JTID_L INTEGER,
  BIID_L INTEGER,
  SYID_L INTEGER,
  CIID_L TEXT 
         )  
      ''');
    await db.execute('''
       CREATE TABLE BIL_MOV_MD (
      BMMSQ   INTEGER,
  BMKID   INTEGER,
  BMMID   INTEGER,
  GUID    TEXT,
  MMMID   INTEGER,
  MDMID   INTEGER,
  MDDID   INTEGER,
  MDFID   INTEGER,
  GUIDM   TEXT,
  BMMAM   REAL                                DEFAULT 0,
  BMMNO   REAL                                DEFAULT 0,
  BMMRE   REAL                                DEFAULT 0,
  BMMN1   INTEGER                                DEFAULT 0,
  BMMN2   INTEGER                                DEFAULT 0,
  BMMN3   INTEGER                                DEFAULT 0,
  BMMC1   TEXT,
  BMMC2   TEXT,
  BMMC3   TEXT,
  BMMC4   TEXT,
  BMMC5   TEXT,
  BMMST   INTEGER                                DEFAULT 1,
  BMMSQR  INTEGER,
  MCKID   INTEGER                                DEFAULT 1,
  MCDID   INTEGER,
  JTID_L INTEGER,
  BIID_L INTEGER,
  SYID_L INTEGER,
  CIID_L TEXT 
         )  
      ''');
    await db.execute('''
       CREATE TABLE BIF_MOV_MD (
      BMMSQ   INTEGER,
  BMKID   INTEGER,
  BMMID   INTEGER,
  GUID    TEXT,
  MMMID   INTEGER,
  MDMID   INTEGER,
  MDDID   INTEGER,
  MDFID   INTEGER,
  GUIDM   TEXT,
  BMMAM   REAL                                DEFAULT 0,
  BMMNO   REAL                                DEFAULT 0,
  BMMRE   REAL                                DEFAULT 0,
  BMMN1   INTEGER                                DEFAULT 0,
  BMMN2   INTEGER                                DEFAULT 0,
  BMMN3   INTEGER                                DEFAULT 0,
  BMMC1   TEXT,
  BMMC2   TEXT,
  BMMC3   TEXT,
  BMMC4   TEXT,
  BMMC5   TEXT,
  BMMST   INTEGER                                DEFAULT 1,
  BMMSQR  INTEGER,
  MCKID   INTEGER                                DEFAULT 1,
  MCDID   INTEGER,
  JTID_L INTEGER,
  BIID_L INTEGER,
  SYID_L INTEGER,
  CIID_L TEXT 
         )  
      ''');
    //   03-17-2024   --V446
    await db.execute('''
    CREATE TABLE BIF_EORD_D(
BMKID INTEGER,
BMMID INTEGER,
BMDID INTEGER,
GUIDF TEXT,
GUID TEXT,
BEDPS INTEGER DEFAULT 2,
BEDTY TEXT,
  JTID_L INTEGER,
  BIID_L INTEGER,
  SYID_L INTEGER,
  CIID_L TEXT
)      
''');
    await db.execute('''
CREATE TABLE STO_INF_TYP(
  SITID  INTEGER,
  SITNA  TEXT,
  SITNE  TEXT,
  SITN3  TEXT,
  SITTY  INTEGER,
  SITST  INTEGER  DEFAULT 1,
  SITDL  INTEGER DEFAULT 1, 
  SUID   TEXT,
  SUCH   TEXT,
  DATEI  DATE,
  DATEU  DATE,
  DEVI   TEXT,
  DEVU   TEXT,
  ORDNU  INTEGER,
  DEFN   INTEGER  DEFAULT 2,
  RES    TEXT,
  GUID   TEXT,
  JTID_L INTEGER,
  BIID_L INTEGER,
  SYID_L INTEGER,
  CIID_L TEXT)      
''');
    await db.execute('''
 CREATE TABLE ACC_BAN_TYP(
  ABTID  INTEGER,
  ABTNA  TEXT,
  ABTNE  TEXT,
  ABTN3  TEXT,
  ABTTY  INTEGER,
  ABTST  INTEGER  DEFAULT 1,
  ABTDL  INTEGER DEFAULT 1,
  SUID   TEXT,
  SUCH   TEXT,
  DATEI  DATE   DEFAULT SYSDATE,
  DATEU  DATE,
  DEVI   TEXT,
  DEVU   TEXT,
  ORDNU  INTEGER,
  DEFN   INTEGER  DEFAULT 2,
  RES    TEXT,
  GUID   TEXT,
  JTID_L INTEGER,
  BIID_L INTEGER,
  SYID_L INTEGER,
  CIID_L TEXT
  )      
''');
    await db.execute('''
CREATE TABLE BIL_CRE_C_TYP(
  BCCTID  INTEGER,
  BCCTNA  TEXT,
  BCCTNE  TEXT,
  BCCTN3  TEXT,
  BCCTTY  INTEGER,
  BCCTST  INTEGER    DEFAULT 1,
  BCCTDL  INTEGER DEFAULT 1,
  SUID   TEXT,
  SUCH   TEXT,
  DATEI  DATE ,
  DATEU  DATE,
  DEVI   TEXT,
  DEVU   TEXT,
  ORDNU  INTEGER,
  DEFN   INTEGER  DEFAULT 2,
  RES    TEXT,
  GUID   TEXT,
  JTID_L INTEGER,
  BIID_L INTEGER,
  SYID_L INTEGER,
  CIID_L TEXT
  )      
''');
    await db.execute('''
CREATE TABLE BIL_DIS_TYP(
  BDTID  INTEGER,
  BDTNA  TEXT,
  BDTNE  TEXT,
  BDTN3  TEXT,
  BDTTY  INTEGER,
  BDTST  INTEGER    DEFAULT 1,
  BDTDL  INTEGER DEFAULT 1,
  SUID   TEXT,
  SUCH   TEXT,
  DATEI  DATE,
  DATEU  DATE,
  DEVI   TEXT,
  DEVU   TEXT,
  ORDNU  INTEGER,
  DEFN   INTEGER  DEFAULT 2,
  RES    TEXT,
  GUID   TEXT,
  JTID_L INTEGER,
  BIID_L INTEGER,
  SYID_L INTEGER,
  CIID_L TEXT    
  )
''');
    await db.execute('''
CREATE TABLE ACC_CAS_TYP(
  ACTID  INTEGER,
  ACTNA  TEXT,
  ACTNE  TEXT,
  ACTN3  TEXT,
  ACTTY  INTEGER,
  ACTST  INTEGER     DEFAULT 1,
  ACTDL  INTEGER DEFAULT 1, 
  SUID   TEXT,
  SUCH   TEXT,
  DATEI  DATE,
  DATEU  DATE,
  DEVI   TEXT,
  DEVU   TEXT,
  ORDNU  INTEGER,
  DEFN   INTEGER,
  RES    TEXT,
  GUID   TEXT,
  JTID_L INTEGER,
  BIID_L INTEGER,
  SYID_L INTEGER,
  CIID_L TEXT )
''');
    await db.execute('''CREATE INDEX BIF_EORD_D_I2 ON BIF_EORD_D (BMKID,BMMID,BEDTY)''');
    //   03-17-2024   --V446


    //   27-05-2024   --V446
    await db.execute('''
CREATE TABLE ACC_GRO(
  AGID  INTEGER,
  AGNA  TEXT,
  AGNE  TEXT,
  AGST  INTEGER                                  DEFAULT 1, 
  SUID   TEXT,
  SUCH   TEXT,
  DATEI  DATE,
  DATEU  DATE,
  DEVI   TEXT,
  DEVU   TEXT,
  GUID   TEXT,
  JTID_L INTEGER,
  BIID_L INTEGER,
  SYID_L INTEGER,
  CIID_L TEXT  )
''');
    await db.execute('''
CREATE TABLE SYS_REP(
  SRID   INTEGER,
  SRNA   TEXT,
  SRNE   TEXT,
  SRDE   TEXT,
  SRIN   TEXT,
  SRTY   TEXT,
  SRSE   INTEGER                                 DEFAULT 3,
  SRDES  TEXT,
  SRST   INTEGER                                 DEFAULT 1,
  SRKI   INTEGER                                 DEFAULT 1,
  SRCH   INTEGER                                 DEFAULT 1,
  SRCN   INTEGER                                 DEFAULT 1,
  SUID   TEXT,
  SRDT   INTEGER                                 DEFAULT 1,
  SRDEE  TEXT,
  SRDO   DATE,
  SRSN   INTEGER,
  SRNAS  TEXT,
  SRINS  TEXT,
  SRSES  INTEGER,
  SRDE3  TEXT,
  SRSY   INTEGER                                 DEFAULT 1,
  SRINE  TEXT,
  SRIN3  TEXT,
  STID   TEXT,
  SDID   INTEGER,
  STIDT  TEXT,
  SRFRM  TEXT,
  DATEI  DATE,
  DEVI   TEXT,
  SUCH   TEXT,
  DATEU  DATE,
  DEVU   TEXT,
  RES    TEXT,
  ORDNU  INTEGER,
  SSIDT  TEXT,
  SRXLS  INTEGER                                 DEFAULT 1,
  SRSYN  INTEGER                                 DEFAULT 2,
  SRSEP  INTEGER                                 DEFAULT 2,
  SRUD   INTEGER                                 DEFAULT 1,
  SRID2  INTEGER,
  GUID   TEXT,
  JTID_L INTEGER,
  BIID_L INTEGER,
  SYID_L INTEGER,
  CIID_L TEXT  )
''');
    await db.execute('''
                CREATE TABLE BIL_IMP_T(
                BITID  INTEGER,
                BITNA  TEXT,
                BITNE  TEXT ,
                PKID  INTEGER ,
                BITAM  TEXT ,
                BITST  INTEGER ,
                SUID TEXT,
			          GUID TEXT,
			          SUCH TEXT,
			          DATEI DATETIME,
			          DATEU DATETIME,
			          DEVI TEXT,
			          DEVU TEXT,
                JTID_L INTEGER,
                BIID_L INTEGER,
                SYID_L INTEGER,
                CIID_L TEXT   )  
                  ''');

    //   11-06-2024
    await db.execute('''
     CREATE TABLE STO_MOV_M(
      SMKID INTEGER NOT NULL,
      SMMID INTEGER NOT NULL,
      SMMNO INTEGER NULL,
      SMMDO DATE DEFAULT CURRENT_TIMESTAMP,
      SMMST INTEGER  DEFAULT 2,
      AANO TEXT,
      AANO2 TEXT,
      SIID INTEGER  NOT NULL,
      SIIDT INTEGER,
      SMMAM REAL,
      SMMAMT REAL,
      SCID INTEGER,
      SCEX REAL,
      SMMEQ REAL,
      SMMIN TEXT,
      SMMRE TEXT,
      SMMRE2 TEXT,
      SCEXS REAL,
      SMMDI REAL,
      SMMDIA REAL,
      SMMDIF REAL,
      SMMTX REAL,
      SMMCN TEXT,
      SMMDR TEXT,
      SMMNN TEXT,
      SMMDN INTEGER,
      SMMIDR INTEGER,
      SMMNOR INTEGER,
      SMMTY INTEGER DEFAULT 2,
      BKID INTEGER,
      BMMID INTEGER,
      ACNO TEXT,
      ACNO2 TEXT,
      SMMDA DATE,
      SUAP TEXT,
      SMMDE TEXT,
      SMMLA     REAL,
      SMMLC     INTEGER,
      SMMLAD    REAL,
      BMMDCT    REAL,
      BIID INTEGER,
      BIIDT INTEGER,
      SMMCR REAL DEFAULT 0,
      SMMCA REAL DEFAULT 0,
      SMMTXD REAL DEFAULT 0,
      SMMTXY REAL DEFAULT 1,
      TMTID INTEGER DEFAULT 1,
      ATTID INTEGER,
      SMMAN INTEGER DEFAULT 2,
      SMMDIA2 REAL DEFAULT 0,
      SMMDIR2 REAL DEFAULT 0,
      SMMCC INTEGER DEFAULT 2,
      SMMCQ INTEGER DEFAULT 2,
      SMMCCT REAL DEFAULT 0,
      SMMCQT REAL DEFAULT 0,
      SMMBR INTEGER DEFAULT 1,
      BIIDB INTEGER,
      SMMIS REAL DEFAULT 0,
      SMMPT REAL DEFAULT 0,
      SMMDT REAL DEFAULT 0,
      SMMWE REAL DEFAULT 0,
      SMMVO REAL DEFAULT 0,
      SMMVC REAL DEFAULT 0,
      AANOS TEXT,
      STMIDI TEXT,
      SOMIDI REAL,
      STMIDU TEXT,
      SOMIDU REAL,
      SUID TEXT,
      GUID TEXT,
      DATEI DATE DEFAULT CURRENT_TIMESTAMP,
      DATEU DATE,
      SUCH TEXT,
      GUID_LNK TEXT,
      DEVI TEXT,
      DEVU TEXT, 
      SMMTS INTEGER,
      SMMNR INTEGER,
      JTID_L INTEGER,
      BIID_L INTEGER,
      SYID_L INTEGER,
      CIID_L TEXT
    ) 
      ''');
    await db.execute('''
         CREATE TABLE STO_MOV_D(
         SMMID INTEGER NOT NULL,
         SMKID INTEGER NOT NULL,
         SMDID INTEGER NOT NULL,
         SIID INTEGER ,
         MGNO TEXT NOT NULL,
         MINO TEXT NOT NULL,
         MUID INTEGER NOT NULL,
         SMDNO REAL,
         SMDAM REAL,
         SMDNF REAL DEFAULT 0,
         SMDED DATE,
         SMDEQ REAL,
         SMDIN TEXT,
         SIIDT INTEGER,  
         BIID INTEGER,
         SMDDI REAL DEFAULT 0,
         SMDDIA REAL DEFAULT 0,
         SMDDIF REAL DEFAULT 0,
         SMDTX REAL DEFAULT 0,
         SMDEX REAL,
         SMDAML REAL,
         SMDEQC REAL,
         SMDCB REAL,
         SMDCA REAL,
         SMDAMR REAL,
         SMDAMRE REAL,
         SMMIDR INTEGER,
         SMMNOR INTEGER,
         SMDIDR INTEGER,
         SMDDIR REAL DEFAULT 0,
         SMDTXA REAL DEFAULT 0,
         SMDTXD REAL DEFAULT 0,
         SMDTY INTEGER DEFAULT 1,
         SMDDIA2 REAL DEFAULT 0,
         SMDDIR2 REAL DEFAULT 0,
         SMDCC REAL DEFAULT 2,
         SMDCQ REAL DEFAULT 2,
         SMDAMO REAL DEFAULT 0,
         SMDWE REAL DEFAULT 0,
         SMDVO REAL DEFAULT 0,
         SMDVC REAL DEFAULT 0,
         SYST INTEGER DEFAULT 2,
         SMDDF REAL DEFAULT 0,
         SMDAMT REAL,
         SMDAMTF REAL,
         GUID TEXT,
         GUIDM TEXT,
         SMDNO2 REAL,
         SUID TEXT,
         DATEI DATE DEFAULT CURRENT_TIMESTAMP,
         DATEU DATE,
         SUCH TEXT,
         DEVI TEXT,
         DEVU TEXT,
         JTID_L INTEGER,
         BIID_L INTEGER,
         SYID_L INTEGER,
         CIID_L TEXT
         ) 
      ''');
    //   28-05-2024   --V446

    //   13-06-2024
    await db.execute('''
         CREATE TABLE STO_MOV_K (
           SMKID  INTEGER,
           SMKNA  TEXT,
           SMKNE  TEXT,
           SMKST  INTEGER                             DEFAULT 1,
           SMKTY  INTEGER,
           SMKAC  INTEGER                            DEFAULT 1,
           STID   TEXT,
           SMKDL  INTEGER                          DEFAULT 2,
           SMKN3  TEXT,
           SUID   TEXT,
           DATEI  DATE,
           DEVI   TEXT,
           SUCH   TEXT,
           DATEU  DATE,
           DEVU   TEXT,
           RES    TEXT,
           ORDNU  INTEGER,
           GUID   TEXT,
           JTID_L INTEGER,
           BIID_L INTEGER,
           SYID_L INTEGER,
           CIID_L TEXT
         )  
      ''');
    // 13-06-2024

    //   08-09-2024
    await db.execute('''
 CREATE TABLE FAT_API_INF(
  GUID    TEXT,
  FAISP   TEXT,
  SCHNA   TEXT,
  STMID   TEXT,
  FAITY   TEXT,
  FAIURL  TEXT,
  FAIME   TEXT,
  FAIRO   TEXT,
  FAIPO   TEXT,
  FAICT   TEXT                   DEFAULT 'application/json',
  FAICH   INTEGER                             DEFAULT 1,
  FAITI   INTEGER                                DEFAULT 120,
  FAIRL   INTEGER                            DEFAULT 2,
  FAIUN   INTEGER                             DEFAULT 2,
  FAIUS   TEXT,
  FAIPA   TEXT,
  FAITO   TEXT,
  FAIAF1  TEXT,
  FAIAF2  TEXT,
  FAIAF3  TEXT,
  FAIAF4  TEXT,
  SUID    TEXT,
  DATEI   DATE,
  DEVI    TEXT,
  STMIDI  TEXT,
  SOMIDI  INTEGER,
  SUCH    TEXT,
  DATEU   DATE,
  DEVU    TEXT,
  STMIDU  TEXT,
  SOMIDU  INTEGER,
  FAIST   INTEGER                            DEFAULT 1,
  JTID_L INTEGER,
  BIID_L INTEGER,
  SYID_L INTEGER,
  CIID_L TEXT  )
''');
    await db.execute('''
 CREATE TABLE FAT_CSID_INF(
  FCIID   INTEGER,
  FCIGU   TEXT,
  FCITY   TEXT                      DEFAULT 'P',
  CIIDL   INTEGER,
  JTIDL   INTEGER,
  BIIDL   INTEGER,
  BIIDV   TEXT,
  STMIDV  TEXT,
  SOMGUV  TEXT,
  SUIDV   TEXT,
  BMKIDV  TEXT,
  FCIBTV  TEXT,
  SCHNA   TEXT,
  FCIJOB  INTEGER                            DEFAULT 2,
  FCIDE   TEXT,
  FCICN   TEXT,
  FCISN   TEXT,
  FCIOI   TEXT,
  FCIOUN  TEXT,
  FCION   TEXT,
  FCIAD   TEXT,
  FCIFM   TEXT                    DEFAULT 'BOTH',
  FCIIPC  TEXT,
  FCICC   TEXT,
  FCILA   TEXT,
  FCIVN   TEXT,
  FCIOTP  TEXT,
  FCIPK   TEXT,
  FCICSR  TEXT,
  FCIBST  TEXT,
  FCISE   TEXT,
  FCIDI   TEXT,
  FCIDC   TEXT,
  FCIED   TEXT,
  FCIEM   TEXT,
  FCIZTS  TEXT,
  FCIJS   TEXT,
  FCIRI   TEXT,
  FCIDM   TEXT,
  FCIAF1  TEXT,
  FCIAF2  TEXT,
  FCIAF3  TEXT,
  FCIAF4  TEXT,
  FCIAF5  TEXT,
  SUID    TEXT,
  DATEI   DATE,
  DEVI    TEXT,
  STMIDI  TEXT,
  SOMIDI  INTEGER,
  SUCH    TEXT,
  DATEU   DATE,
  DEVU    TEXT,
  STMIDU  TEXT,
  SOMIDU  INTEGER,
  FCIST   INTEGER                             DEFAULT 1,
  DEFN    INTEGER                             DEFAULT 2,
  ORDNU   INTEGER,
  RES     TEXT,
  JTID_L INTEGER,
  BIID_L INTEGER,
  SYID_L INTEGER,
  CIID_L TEXT  )
''');
    await db.execute('''
 CREATE TABLE FAT_CSID_INF_D(
  FCIGU   TEXT,
  GUID    TEXT,
  FCIDTY  TEXT,
  FCIDVA  TEXT,
  JTID_L INTEGER,
  BIID_L INTEGER,
  SYID_L INTEGER,
  CIID_L TEXT  )
''');
    await db.execute('''
 CREATE TABLE FAT_CSID_SEQ(
  FCIGU   TEXT,
  FCSNO   INTEGER                                DEFAULT 0,
  FISSEQ  INTEGER,
  FISGU   TEXT,
  FCSHA   TEXT,
  SUID    TEXT,
  DATEI   DATE,
  DEVI    TEXT,
  STMIDI  TEXT,
  SOMIDI  INTEGER,
  SUCH    TEXT,
  DATEU   DATE,
  DEVU    TEXT,
  STMIDU  TEXT,
  SOMIDU  INTEGER,
  FCSFS INTEGER DEFAULT 2,
  JTID_L INTEGER,
  BIID_L INTEGER,
  SYID_L INTEGER,
  CIID_L TEXT  )
''');
    await db.execute('''
 CREATE TABLE FAT_CSID_ST(
    FCIGU   TEXT,
  FCSST   INTEGER                             DEFAULT 2,
  FCSHA   TEXT,
  SUCH    TEXT,
  DATEU   DATE,
  DEVU    TEXT,
  STMIDU  TEXT,
  SOMIDU  INTEGER,
  JTID_L INTEGER,
  BIID_L INTEGER,
  SYID_L INTEGER,
  CIID_L TEXT  )
''');
    await db.execute('''
 CREATE TABLE FAT_INV_HOL(
  FCIGU   TEXT,
  CIIDL   INTEGER,
  JTIDL   INTEGER,
  BIIDL   INTEGER,
  SYIDL   INTEGER,
  SCHNA   TEXT,
  BMMGU   TEXT,
  SID     TEXT,
  SERIAL  TEXT,
  FIHHA   TEXT,
  SUCH    TEXT,
  DATEU   TEXT,
  DEVU    TEXT,
  STMIDU  TEXT,
  SOMIDU  INTEGER,
  JTID_L INTEGER,
  BIID_L INTEGER,
  SYID_L INTEGER,
  CIID_L TEXT  )
''');
    await db.execute('''
 CREATE TABLE FAT_INV_JOBS(
  FIJSEQ  INTEGER primary key autoincrement,
  FIGGU   TEXT,
  FSLGU   TEXT,
  FISGU   TEXT,
  FCIGU   TEXT,
  CIIDL   INTEGER,
  JTIDL   INTEGER,
  BIIDL   INTEGER,
  SYIDL   INTEGER,
  SCHNA   TEXT,
  BMMGU   TEXT,
  FIJTY   TEXT                      DEFAULT 'P',
  FIJJY   INTEGER,
  FIJIS   INTEGER,
  FIJDA   DATE                                  DEFAULT SYSDATE,
  FIJST   INTEGER,
  SUID    TEXT,
  DATEI   DATE                                  DEFAULT SYSDATE,
  DEVI    TEXT,
  STMIDI  TEXT,
  SOMIDI  INTEGER,
  SUCH    TEXT,
  DATEU   DATE,
  DEVU    TEXT,
  STMIDU  TEXT,
  SOMIDU  INTEGER,
  FIJTYP  TEXT,
  JTID_L INTEGER,
  BIID_L INTEGER,
  SYID_L INTEGER,
  CIID_L TEXT  )
''');
    await db.execute('''
 CREATE TABLE FAT_INV_RS(
    FIRSEQ   INTEGER primary key autoincrement,
  GUID     TEXT,
  FISSEQ   INTEGER,
  FISGU    TEXT,
  FCIGU    TEXT,
  CIIDL    INTEGER,
  JTIDL    INTEGER,
  BIIDL    INTEGER,
  SYIDL    INTEGER,
  SCHNA    TEXT,
  BMMGU    TEXT,
  FIREQD   TEXT,
  FIRESC   TEXT,
  FIRERR   TEXT,
  FIRESD   TEXT,
  FIRDA    DATE,
  SUID     TEXT,
  DATEI    DATE,
  DEVI     TEXT,
  STMIDI   TEXT,
  SOMIDI   INTEGER,
  SUCH     TEXT,
  DATEU    DATE,
  DEVU     TEXT,
  STMIDU   TEXT,
  SOMIDU   INTEGER,
  FIRFS INTEGER DEFAULT 2,
  JTID_L INTEGER,
  BIID_L INTEGER,
  SYID_L INTEGER,
  CIID_L TEXT  )
''');
    await db.execute('''
 CREATE TABLE FAT_INV_SND(
    FISSEQ     INTEGER primary key autoincrement,
  FISGU      TEXT,
  FCIGU      TEXT,
  CIIDL      INTEGER,
  JTIDL      INTEGER,
  BIIDL      INTEGER,
  SYIDL      INTEGER,
  SCHNA      TEXT,
  UUID       TEXT,
  STID       TEXT,
  BMMGU      TEXT,
  FISSI      INTEGER                          DEFAULT 2,
  FISST      INTEGER,
  FISICV     INTEGER,
  FISPIN     INTEGER,
  FISPGU     TEXT,
  FISPIH     TEXT,
  FISIH      TEXT,
  FISQR      TEXT,
  FISZHS     TEXT,
  FISZHSO    TEXT,
  FISZS      TEXT,
  FISIS      TEXT,
  FISINF     TEXT,
  FISWE      INTEGER                          DEFAULT 2,
  FISEE      INTEGER                         DEFAULT 2,
  FISXML     TEXT,
  FISTOT     REAL,
  FISSUM     REAL,
  FISTWV     REAL,
  FISSD      DATE,
  FISLSD     DATE,
  FISNS      INTEGER                             DEFAULT 0,
  SOMGU      TEXT,
  SYDV_APPV  TEXT,
  SMID       INTEGER,
  SYDV_APIV  TEXT,
  SUID       TEXT,
  DATEI      DATE,
  DEVI       TEXT,
  STMIDI     TEXT,
  SOMIDI     INTEGER,
  SUCH       TEXT,
  DATEU      DATE,
  DEVU       TEXT,
  STMIDU     TEXT,
  SOMIDU     INTEGER,
  FISSTO     INTEGER,
  FISST2      INTEGER,
  FISFS INTEGER DEFAULT 2,
  FISXE INTEGER DEFAULT 2,
  FISXN INTEGER DEFAULT 0,
  FISXNA TEXT,
  FISINO TEXT,
  JTID_L INTEGER,
  BIID_L INTEGER,
  SYID_L INTEGER,
  CIID_L TEXT  )
''');
    await db.execute('''
 CREATE TABLE FAT_INV_SND_ARC(
    FISSEQ     INTEGER,
  FISGU      TEXT,
  FCIGU      TEXT,
  CIIDL      INTEGER,
  JTIDL      INTEGER,
  BIIDL      INTEGER,
  SYIDL      INTEGER,
  SCHNA      TEXT,
  UUID       TEXT,
  STID       TEXT,
  BMMGU      TEXT,
  FISSI      INTEGER                          DEFAULT 2,
  FISST      INTEGER,
  FISICV     INTEGER,
  FISPIN     INTEGER,
  FISPGU     TEXT,
  FISPIH     TEXT,
  FISIH      TEXT,
  FISQR      TEXT,
  FISZHS     TEXT,
  FISZHSO    TEXT,
  FISZS      TEXT,
  FISIS      TEXT,
  FISINF     TEXT,
  FISWE      INTEGER                          DEFAULT 2,
  FISEE      INTEGER                         DEFAULT 2,
  FISXML     TEXT,
  FISTOT     REAL,
  FISSUM     REAL,
  FISTWV     REAL,
  FISSD      DATE,
  FISLSD     DATE,
  FISNS      INTEGER                             DEFAULT 0,
  SOMGU      TEXT,
  SYDV_APPV  TEXT,
  SMID       INTEGER,
  SYDV_APIV  TEXT,
  SUID       TEXT,
  DATEI      DATE,
  DEVI       TEXT,
  STMIDI     TEXT,
  SOMIDI     INTEGER,
  SUCH       TEXT,
  DATEU      DATE,
  DEVU       TEXT,
  STMIDU     TEXT,
  SOMIDU     INTEGER,
  FISSTO     INTEGER,
  FISAFS INTEGER DEFAULT 2,
  JTID_L INTEGER,
  BIID_L INTEGER,
  SYID_L INTEGER,
  CIID_L TEXT  )
''');
    await db.execute('''
 CREATE TABLE FAT_QUE(
  FQTY    TEXT,
  GUID    TEXT,
  SCHNA   TEXT,
  FQQU1   TEXT,
  FQQU2   TEXT,
  FQQU3   TEXT,
  FQQU4   TEXT,
  FQQU5   TEXT,
  SUID    TEXT,
  DATEI   DATE            DEFAULT SYSDATE,
  DEVI    TEXT,
  STMIDI  TEXT,
  SOMIDI  INTEGER,
  SUCH    TEXT,
  DATEU   DATE,
  DEVU    TEXT,
  STMIDU  TEXT,
  SOMIDU  INTEGER,
  JTID_L INTEGER,
  BIID_L INTEGER,
  SYID_L INTEGER,
  CIID_L TEXT  )
''');
    await db.execute('''
 CREATE TABLE FAT_LOG(
    FLSEQ   INTEGER primary key autoincrement,
  GUID    TEXT,
  FCIGU   TEXT,
  FISGU   TEXT,
  CIIDL   INTEGER,
  JTIDL   INTEGER,
  BIIDL   INTEGER,
  SYIDL   INTEGER,
  SCHNA   TEXT,
  BMMGU   TEXT,
  FLTY    TEXT,
  FLPRO   TEXT,
  FLMSG   TEXT,
  SUID    TEXT,
  DATEI   DATE,
  DEVI    TEXT,
  STMIDI  TEXT,
  SOMIDI  INTEGER,
  JTID_L INTEGER,
  BIID_L INTEGER,
  SYID_L INTEGER,
  CIID_L TEXT  )
''');
    await db.execute('''
 CREATE TABLE FAT_SND_LOG(
  FSLSEQ  INTEGER primary key autoincrement,
  FSLGU   TEXT,
  FSLTY   TEXT    DEFAULT 'P',
  FCIGU   TEXT,
  CIIDL   INTEGER,
  JTIDL   INTEGER,
  BIIDL   INTEGER,
  SYIDL   INTEGER,
  SCHNA   TEXT,
  BMMGU   TEXT,
  FISGU   TEXT,
  FSLPT   INTEGER,
  FSLJOB  INTEGER                            DEFAULT 2,
  SSID    INTEGER,
  FSLSIG  INTEGER,
  FSLCIE  INTEGER,
  FSLSTP  INTEGER,
  FSLST   INTEGER,
  FSLRT   INTEGER,
  FSLMSG  TEXT,
  FSLIS   INTEGER,
  SUID    TEXT,
  DATEI   DATE,
  DEVI    TEXT,
  STMIDI  TEXT,
  SOMIDI  INTEGER,
  FSLFS INTEGER DEFAULT 2,
  JTID_L INTEGER,
  BIID_L INTEGER,
  SYID_L INTEGER,
  CIID_L TEXT  )
''');
    await db.execute('''
 CREATE TABLE FAT_SND_LOG_D(
      FSLSEQ  INTEGER,
        FSLGU TEXT,
  FSLDRQ  TEXT,
  FSLDRC  TEXT,
  FSLDER  TEXT,
  FSLDRS  TEXT,
  FSLDFS INTEGER DEFAULT 2,
  JTID_L INTEGER,
  BIID_L INTEGER,
  SYID_L INTEGER,
  CIID_L TEXT  )
''');
    await db.execute('''
 CREATE TABLE FAT_SND_LOG_ARC(
  FSLSEQ  INTEGER,
  FSLGU   TEXT,
  FSLTY   TEXT,
  FCIGU   TEXT,
  CIIDL   INTEGER,
  JTIDL   INTEGER,
  BIIDL   INTEGER,
  SYIDL   INTEGER,
  SCHNA   TEXT,
  BMMGU   TEXT,
  FISGU   TEXT,
  FSLPT   INTEGER,
  FSLJOB  INTEGER,
  SSID    INTEGER,
  FSLSIG  INTEGER,
  FSLCIE  INTEGER,
  FSLSTP  INTEGER,
  FSLST   INTEGER,
  FSLRT   INTEGER,
  FSLMSG  TEXT,
  FSLIS   INTEGER,
  SUID    TEXT,
  DATEI   DATE,
  DEVI    TEXT,
  STMIDI  TEXT,
  SOMIDI  INTEGER,
  JTID_L INTEGER,
  BIID_L INTEGER,
  SYID_L INTEGER,
  CIID_L TEXT  )
''');
    await db.execute('''
 CREATE TABLE FAT_SND_LOG_D_ARC(
      FSLSEQ  INTEGER,
    FSLGU   TEXT,
  FSLDRQ  TEXT,
  FSLDRC  TEXT,
  FSLDER  TEXT,
  FSLDRS  TEXT,
  JTID_L INTEGER,
  BIID_L INTEGER,
  SYID_L INTEGER,
  CIID_L TEXT  )
''');
    await db.execute('''
 CREATE TABLE TAX_MOV_T(
   TTID   INTEGER      DEFAULT 1,
  TMTTY  TEXT,
  TMTID  INTEGER,
  TMTNA  TEXT,
  TMTNE  TEXT,
  TMTN3  TEXT,
  TMTST  INTEGER       DEFAULT 1,
  TTTP   INTEGER,
  ATTID  TEXT,
  TMTMN  TEXT,
  TRTID  INTEGER,
  DATEI  DATE    DEFAULT SYSDATE,
  DATEU  DATE,
  SUID   TEXT,
  SUCH   TEXT,
  GUID   TEXT,
  DEVI   TEXT,
  DEVU   TEXT,
  JTID_L INTEGER,
  BIID_L INTEGER,
  SYID_L INTEGER,
  CIID_L TEXT  )
''');
    //   08-09-2024


    await db.execute('''
         CREATE TABLE SYS_ACC_M (
   SAMID  INTEGER,
  SAMNA  TEXT,
  SAMNE  TEXT,
  AANO   TEXT,
  SAMTY  INTEGER                            DEFAULT 1,
  STID   TEXT,
  SAMST  INTEGER                             DEFAULT 1,
  SAMDO  DATE,
  SUID   TEXT,
  SAMKI  INTEGER,
  BIID   INTEGER,
  SAMN3  TEXT,
  SUCH   TEXT,
  DATEU  DATE,
  DEVU   TEXT,
  RES    TEXT,
  JTID_L INTEGER,
  BIID_L INTEGER,
  SYID_L INTEGER,
  CIID_L TEXT   )  
      ''');

    //16-11-2024
    await db.execute('''
 CREATE TABLE FAT_INV_SND_D(
    FISDGU     TEXT,
  FISGU      TEXT,
  FISDTY      TEXT,
  FISDDA      TEXT,
  FISDFS INTEGER DEFAULT 2,
  JTID_L INTEGER,
  BIID_L INTEGER,
  SYID_L INTEGER,
  CIID_L TEXT  )
''');
    await db.execute('''
 CREATE TABLE FAT_INV_SND_R(
    FISRGU     TEXT,
    FISGU      TEXT,
    FISRTY      TEXT,
    FISRDA      TEXT,
    FISRFS INTEGER DEFAULT 2,
  JTID_L INTEGER,
  BIID_L INTEGER,
  SYID_L INTEGER,
  CIID_L TEXT  )
''');

    await db.execute(CreateCOU_TYP_M);
    await db.execute(CreateCOU_INF_M);
    await db.execute(CreateCOU_POI_L);
    await db.execute(CreateBIF_COU_M);
    await db.execute(CreateCOU_USR);
    await db.execute(CreateCOU_RED);
    await db.execute(CreateBIF_COU_C);
    await db.execute(CreateCON_ACC_M);
    await db.execute(CreateMOB_VAR);
    await db.execute(CreateSYN_SET);
    await db.execute(CreateSYN_OFF_M2);
    await db.execute(CreateSYN_OFF_M);
    await db.execute(CreateECO_VAR);
    await db.execute(CreateECO_ACC);
    await db.execute(CreateECO_MSG_ACC);
    await db.execute(CreateBK_INF);
    await db.execute(CreateBIF_TRA_TBL);
    await db.execute(CreateAppPrinterDevice);
    await db.execute(CreateMOB_LOG);

    InsertMobVar(db);
    InsertMobVar2(db);
    await db.execute('''CREATE TABLE MAT_INF_D_TMP AS  SELECT  * FROM MAT_INF_D WHERE 1=2''');
    await db.execute('''CREATE TABLE MAT_DES_M_TMP AS  SELECT  * FROM MAT_DES_M WHERE 1=2''');
    await db.execute('''CREATE TABLE MAT_DES_D_TMP AS  SELECT  * FROM MAT_DES_D WHERE 1=2''');
    await db.execute('''CREATE TABLE MAT_FOL_TMP AS  SELECT  * FROM MAT_FOL WHERE 1=2''');
    await db.execute('''CREATE TABLE RES_TAB_TMP AS  SELECT  * FROM RES_TAB WHERE 1=2''');
    await db.execute('''CREATE TABLE RES_SEC_TMP AS  SELECT  * FROM RES_SEC WHERE 1=2''');
    await db.execute('''CREATE TABLE RES_EMP_TMP AS  SELECT  * FROM RES_EMP WHERE 1=2''');
    await db.execute('''CREATE TABLE BIF_GRO_TMP AS  SELECT  * FROM BIF_GRO WHERE 1=2''');
    await db.execute('''CREATE TABLE BIF_GRO2_TMP AS  SELECT  * FROM BIF_GRO2 WHERE 1=2''');
    await db.execute('''CREATE TABLE BIF_MOV_A_TMP AS  SELECT  * FROM BIF_MOV_A WHERE 1=2''');
    await db.execute('''CREATE TABLE TAX_TBL_LNK_TMP AS  SELECT  * FROM TAX_TBL_LNK WHERE 1=2''');
    await db.execute('''CREATE TABLE TAX_VAR_D_TMP AS  SELECT  * FROM TAX_VAR_D WHERE 1=2''');
    await db.execute('''CREATE TABLE TAX_VAR_TMP AS  SELECT  * FROM TAX_VAR WHERE 1=2''');
    await db.execute('''CREATE TABLE TAX_MOV_SIN_TMP AS  SELECT  * FROM TAX_MOV_SIN WHERE 1=2''');
    await db.execute('''CREATE TABLE TAX_LOC_SYS_TMP AS  SELECT  * FROM TAX_LOC_SYS WHERE 1=2''');
    await db.execute('''CREATE TABLE TAX_LOC_TMP AS  SELECT  * FROM TAX_LOC WHERE 1=2''');
    await db.execute('''CREATE TABLE BRA_INF_ACC AS  SELECT  * FROM BRA_INF WHERE 1=2''');
    await db.execute('''CREATE TABLE SYS_USR_ACC AS  SELECT  * FROM SYS_USR WHERE 1=2''');
    await db.execute('''CREATE TABLE BRA_YEA_ACC AS  SELECT  * FROM BRA_YEA WHERE 1=2''');
    await db.execute('''CREATE TABLE SYS_YEA_ACC AS  SELECT  * FROM SYS_YEA WHERE 1=2''');
    await db.execute('''CREATE TABLE GEN_VAR_ACC AS  SELECT  * FROM GEN_VAR WHERE 1=2''');
    await db.execute('''CREATE TABLE SYS_VAR_TMP AS SELECT  * FROM SYS_VAR WHERE 1=2''');
    await db.execute('''CREATE TABLE SYN_DAT_TMP AS SELECT  * FROM SYN_DAT WHERE 1=2''');
    await db.execute('''CREATE TABLE SYS_OWN_TMP AS SELECT  * FROM SYS_OWN WHERE 1=2''');
    await db.execute('''CREATE TABLE SYS_USR_TMP AS SELECT  * FROM SYS_USR WHERE 1=2''');
    await db.execute('''CREATE TABLE BRA_INF_TMP AS SELECT  * FROM BRA_INF WHERE 1=2''');
    await db.execute('''CREATE TABLE USR_PRI_TMP AS SELECT  * FROM USR_PRI WHERE 1=2''');
    await db.execute('''CREATE TABLE ACC_MOV_K_TMP AS SELECT  * FROM ACC_MOV_K WHERE 1=2''');
    await db.execute('''CREATE TABLE BIL_MOV_K_TMP AS SELECT  * FROM BIL_MOV_K WHERE 1=2''');
    await db.execute('''CREATE TABLE SYS_USR_B_TMP AS SELECT  * FROM SYS_USR_B WHERE 1=2''');
    await db.execute('''CREATE TABLE STO_INF_TMP AS SELECT  * FROM STO_INF WHERE 1=2''');
    await db.execute('''CREATE TABLE STO_USR_TMP AS SELECT  * FROM STO_USR WHERE 1=2''');
    await db.execute('''CREATE TABLE GRO_USR_TMP AS SELECT  * FROM GRO_USR WHERE 1=2''');
    await db.execute('''CREATE TABLE MAT_UNI_TMP AS SELECT  * FROM MAT_UNI WHERE 1=2''');
    await db.execute('''CREATE TABLE MAT_GRO_TMP AS SELECT  * FROM MAT_GRO WHERE 1=2''');
    await db.execute('''CREATE TABLE MAT_INF_TMP AS SELECT  * FROM MAT_INF WHERE 1=2''');
    await db.execute('''CREATE TABLE MAT_UNI_C_TMP AS SELECT  * FROM MAT_UNI_C WHERE 1=2''');
    await db.execute('''CREATE TABLE MAT_UNI_B_TMP AS SELECT  * FROM MAT_UNI_B WHERE 1=2''');
    await db.execute('''CREATE TABLE MAT_PRI_TMP AS SELECT  * FROM MAT_PRI WHERE 1=2''');
    await db.execute('''CREATE TABLE MAT_INF_A_TMP AS SELECT  * FROM MAT_INF_A WHERE 1=2''');
    await db.execute('''CREATE TABLE STO_NUM_TMP AS SELECT  * FROM STO_NUM WHERE 1=2''');
    await db.execute('''CREATE TABLE SYS_CUR_TMP AS SELECT  * FROM SYS_CUR WHERE 1=2''');
    await db.execute('''CREATE TABLE SYS_CUR_D_TMP AS SELECT  * FROM SYS_CUR_D WHERE 1=2''');
    await db.execute('''CREATE TABLE SYS_CUR_BET_TMP AS SELECT  * FROM SYS_CUR_BET WHERE 1=2''');
    await db.execute('''CREATE TABLE PAY_KIN_TMP AS SELECT  * FROM PAY_KIN WHERE 1=2''');
    await db.execute('''CREATE TABLE ACC_CAS_TMP AS SELECT  * FROM ACC_CAS WHERE 1=2''');
    await db.execute('''CREATE TABLE BIL_CRE_C_TMP AS SELECT  * FROM BIL_CRE_C WHERE 1=2''');
    await db.execute('''CREATE TABLE ACC_BAN_TMP AS SELECT  * FROM ACC_BAN WHERE 1=2''');
    await db.execute('''CREATE TABLE BIL_CUS_T_TMP AS SELECT  * FROM BIL_CUS_T WHERE 1=2''');
    await db.execute('''CREATE TABLE ACC_TAX_T_TMP AS SELECT  * FROM ACC_TAX_T WHERE 1=2''');
    await db.execute('''CREATE TABLE BIL_CUS_TMP AS SELECT  * FROM BIL_CUS WHERE 1=2''');
    await db.execute('''CREATE TABLE BIF_CUS_D_TMP AS SELECT  * FROM BIF_CUS_D WHERE 1=2''');
    await db.execute('''CREATE TABLE BIL_DIS_TMP AS SELECT  * FROM BIL_DIS WHERE 1=2''');
    await db.execute('''CREATE TABLE BIL_IMP_TMP AS SELECT  * FROM BIL_IMP WHERE 1=2''');
    await db.execute('''CREATE TABLE COU_WRD_TMP AS SELECT  * FROM COU_WRD WHERE 1=2''');
    await db.execute('''CREATE TABLE COU_TOW_TMP AS SELECT  * FROM COU_TOW WHERE 1=2''');
    await db.execute('''CREATE TABLE BIL_ARE_TMP AS SELECT  * FROM BIL_ARE WHERE 1=2''');
    await db.execute('''CREATE TABLE ACC_ACC_TMP AS SELECT  * FROM ACC_ACC WHERE 1=2''');
    await db.execute('''CREATE TABLE ACC_USR_TMP AS SELECT  * FROM ACC_USR WHERE 1=2''');
    await db.execute('''CREATE TABLE SHI_INF_TMP AS SELECT  * FROM SHI_INF WHERE 1=2''');
    await db.execute('''CREATE TABLE SHI_USR_TMP AS SELECT  * FROM SHI_USR WHERE 1=2''');
    await db.execute('''CREATE TABLE BIL_POI_TMP AS SELECT  * FROM BIL_POI WHERE 1=2''');
    await db.execute('''CREATE TABLE BIL_POI_U_TMP AS SELECT  * FROM BIL_POI_U WHERE 1=2''');
    await db.execute('''CREATE TABLE BIL_USR_D_TMP AS SELECT  * FROM BIL_USR_D WHERE 1=2''');
    await db.execute('''CREATE TABLE ACC_COS_TMP AS SELECT  * FROM ACC_COS WHERE 1=2''');
    await db.execute('''CREATE TABLE COS_USR_TMP AS SELECT  * FROM COS_USR WHERE 1=2''');
    await db.execute('''CREATE TABLE SYS_REF_TMP AS SELECT  * FROM SYS_REF WHERE 1=2''');
    await db.execute('''CREATE TABLE SYS_DOC_D_TMP AS SELECT  * FROM SYS_DOC_D WHERE 1=2''');
    await db.execute('''CREATE TABLE BRA_YEA_TMP AS SELECT  * FROM BRA_YEA WHERE 1=2''');
    await db.execute('''CREATE TABLE SYS_SCR_TMP AS SELECT  * FROM SYS_SCR WHERE 1=2''');
    await db.execute('''CREATE TABLE SYN_ORD_TMP AS SELECT  * FROM SYN_ORD WHERE 1=2''');
    await db.execute('''CREATE TABLE BIL_MOV_M_TMP AS SELECT  * FROM BIL_MOV_M WHERE 1=2''');
    await db.execute('''CREATE TABLE BIL_MOV_D_TMP AS SELECT  * FROM BIL_MOV_D WHERE 1=2''');
    await db.execute('''CREATE TABLE BAL_ACC_C_TMP AS SELECT  * FROM BAL_ACC_C WHERE 1=2''');
    await db.execute('''CREATE TABLE BAL_ACC_M_TMP AS SELECT  * FROM BAL_ACC_M WHERE 1=2''');
    await db.execute('''CREATE TABLE BAL_ACC_D_TMP AS SELECT  * FROM BAL_ACC_D WHERE 1=2''');
    await db.execute('''CREATE TABLE TAX_SYS_BRA_TMP AS SELECT  * FROM TAX_SYS_BRA WHERE 1=2''');
    await db.execute('''CREATE TABLE TAX_SYS_D_TMP AS SELECT  * FROM TAX_SYS_D WHERE 1=2''');
    await db.execute('''CREATE TABLE TAX_SYS_TMP AS SELECT  * FROM TAX_SYS WHERE 1=2''');
    await db.execute('''CREATE TABLE TAX_TYP_BRA_TMP AS SELECT  * FROM TAX_TYP_BRA WHERE 1=2''');
    await db.execute('''CREATE TABLE TAX_COD_SYS_D_TMP AS SELECT  * FROM TAX_COD_SYS_D WHERE 1=2''');
    await db.execute('''CREATE TABLE TAX_LIN_TMP AS SELECT  * FROM TAX_LIN WHERE 1=2''');
    await db.execute('''CREATE TABLE TAX_COD_TMP AS SELECT  * FROM TAX_COD WHERE 1=2''');
    await db.execute('''CREATE TABLE TAX_COD_SYS_TMP AS SELECT  * FROM TAX_COD_SYS WHERE 1=2''');
    await db.execute('''CREATE TABLE TAX_PER_BRA_TMP AS SELECT  * FROM TAX_PER_BRA WHERE 1=2''');
    await db.execute('''CREATE TABLE TAX_PER_D_TMP AS SELECT  * FROM TAX_PER_D WHERE 1=2''');
    await db.execute('''CREATE TABLE TAX_PER_M_TMP AS SELECT  * FROM TAX_PER_M WHERE 1=2''');
    await db.execute('''CREATE TABLE TAX_TYP_TMP AS SELECT  * FROM TAX_TYP WHERE 1=2''');
    await db.execute('''CREATE TABLE TAX_TYP_SYS_TMP AS SELECT  * FROM TAX_TYP_SYS WHERE 1=2''');
    await db.execute('''CREATE TABLE IDE_LIN_TMP AS SELECT  * FROM IDE_LIN WHERE 1=2''');
    await db.execute('''CREATE TABLE IDE_TYP_TMP AS SELECT  * FROM IDE_TYP WHERE 1=2''');
    await db.execute('''CREATE TABLE SYN_ORD_L_TMP AS SELECT  * FROM SYN_ORD_L WHERE 1=2''');
    await db.execute('''CREATE TABLE ACC_CAS_U_TMP AS SELECT  * FROM ACC_CAS_U WHERE 1=2''');
    await db.execute('''CREATE TABLE MAT_DIS_T_TMP AS SELECT  * FROM MAT_DIS_T WHERE 1=2''');
    await db.execute('''CREATE TABLE MAT_DIS_K_TMP AS SELECT  * FROM MAT_DIS_K WHERE 1=2''');
    await db.execute('''CREATE TABLE MAT_DIS_M_TMP AS SELECT  * FROM MAT_DIS_M WHERE 1=2''');
    await db.execute('''CREATE TABLE MAT_DIS_D_TMP AS SELECT  * FROM MAT_DIS_D WHERE 1=2''');
    await db.execute('''CREATE TABLE MAT_DIS_F_TMP AS SELECT  * FROM MAT_DIS_F WHERE 1=2''');
    await db.execute('''CREATE TABLE MAT_DIS_L_TMP AS SELECT  * FROM MAT_DIS_L WHERE 1=2''');
    await db.execute('''CREATE TABLE MAT_DIS_N_TMP AS SELECT  * FROM MAT_DIS_N WHERE 1=2''');
    await db.execute('''CREATE TABLE MAT_DIS_S_TMP AS SELECT  * FROM MAT_DIS_S WHERE 1=2''');
    await db.execute('''CREATE TABLE SYN_TAS_TMP AS SELECT  * FROM SYN_TAS WHERE 1=2''');
    await db.execute('''CREATE TABLE MAT_MAI_M_TMP AS SELECT  * FROM MAT_MAI_M WHERE 1=2''');
    await db.execute('''CREATE TABLE SYN_SET_TMP AS SELECT  * FROM SYN_SET WHERE 1=2''');
    await db.execute('''CREATE TABLE SYN_OFF_M2_TMP AS SELECT  * FROM SYN_OFF_M2 WHERE 1=2''');
    await db.execute('''CREATE TABLE SYN_OFF_M_TMP AS SELECT  * FROM SYN_OFF_M WHERE 1=2''');
    await db.execute('''CREATE TABLE ECO_VAR_TMP AS SELECT  * FROM ECO_VAR WHERE 1=2''');
    await db.execute('''CREATE TABLE ECO_ACC_TMP AS SELECT  * FROM ECO_ACC WHERE 1=2''');
    await db.execute('''CREATE TABLE ECO_MSG_ACC_TMP AS SELECT  * FROM ECO_MSG_ACC WHERE 1=2''');

    //27-05-2024
    await db.execute('''CREATE TABLE ACC_GRO_TMP AS SELECT  * FROM ACC_GRO WHERE 1=2''');
    await db.execute('''CREATE TABLE SYS_REP_TMP AS SELECT  * FROM SYS_REP WHERE 1=2''');
    //28-05-2024
    await db.execute('''CREATE TABLE BIL_IMP_T_TMP AS SELECT  * FROM BIL_IMP_T WHERE 1=2''');
    //04-06-2024
    await db.execute('''CREATE TABLE SYS_LAN_TMP AS SELECT  * FROM SYS_LAN WHERE 1=2''');
    //   13-06-2024
    await db.execute('''CREATE TABLE STO_MOV_K_TMP AS SELECT  * FROM STO_MOV_K WHERE 1=2''');

    //   08-09-2024
    await db.execute('''CREATE TABLE ACC_TAX_C_TMP AS SELECT  * FROM ACC_TAX_C WHERE 1=2''');
    await db.execute('''CREATE TABLE FAT_API_INF_TMP AS SELECT  * FROM FAT_API_INF WHERE 1=2''');
    await db.execute('''CREATE TABLE FAT_CSID_INF_TMP AS SELECT  * FROM FAT_CSID_INF WHERE 1=2''');
    await db.execute('''CREATE TABLE FAT_CSID_INF_D_TMP AS SELECT  * FROM FAT_CSID_INF_D WHERE 1=2''');
    await db.execute('''CREATE TABLE FAT_CSID_SEQ_TMP AS SELECT  * FROM FAT_CSID_SEQ WHERE 1=2''');
    await db.execute('''CREATE TABLE FAT_CSID_ST_TMP AS SELECT  * FROM FAT_CSID_ST WHERE 1=2''');
    await db.execute('''CREATE TABLE FAT_INV_HOL_TMP AS SELECT  * FROM FAT_INV_HOL WHERE 1=2''');
    await db.execute('''CREATE TABLE FAT_INV_JOBS_TMP AS SELECT  * FROM FAT_INV_JOBS WHERE 1=2''');
    await db.execute('''CREATE TABLE FAT_INV_RS_TMP AS SELECT  * FROM FAT_INV_RS WHERE 1=2''');
    await db.execute('''CREATE TABLE FAT_INV_SND_TMP AS SELECT  * FROM FAT_INV_SND WHERE 1=2''');
    await db.execute('''CREATE TABLE FAT_INV_SND_ARC_TMP AS SELECT  * FROM FAT_INV_SND_ARC WHERE 1=2''');
    await db.execute('''CREATE TABLE FAT_QUE_TMP AS SELECT  * FROM FAT_QUE WHERE 1=2''');
    await db.execute('''CREATE TABLE FAT_LOG_TMP AS SELECT  * FROM FAT_LOG WHERE 1=2''');
    await db.execute('''CREATE TABLE FAT_SND_LOG_TMP AS SELECT  * FROM FAT_SND_LOG WHERE 1=2''');
    await db.execute('''CREATE TABLE FAT_SND_LOG_D_TMP AS SELECT  * FROM FAT_SND_LOG_D WHERE 1=2''');
    await db.execute('''CREATE TABLE FAT_SND_LOG_ARC_TMP AS SELECT  * FROM FAT_SND_LOG_ARC WHERE 1=2''');
    await db.execute('''CREATE TABLE FAT_SND_LOG_D_ARC_TMP AS SELECT  * FROM FAT_SND_LOG_D_ARC WHERE 1=2''');
    await db.execute('''CREATE TABLE TAX_MOV_T_TMP AS SELECT  * FROM TAX_MOV_T WHERE 1=2''');
    await db.execute('''CREATE TABLE SYS_ACC_M_TMP AS SELECT  * FROM SYS_ACC_M WHERE 1=2''');

    // 21-11-2024
    await db.execute('''CREATE TABLE COU_TYP_M_TMP AS SELECT  * FROM COU_TYP_M WHERE 1=2''');
    await db.execute('''CREATE TABLE COU_INF_M_TMP AS SELECT  * FROM COU_INF_M WHERE 1=2''');
    await db.execute('''CREATE TABLE COU_POI_L_TMP AS SELECT  * FROM COU_POI_L WHERE 1=2''');
    await db.execute('''CREATE TABLE BIF_COU_M_TMP AS SELECT  * FROM BIF_COU_M WHERE 1=2''');
    await db.execute('''CREATE TABLE COU_USR_TMP AS SELECT  * FROM COU_USR WHERE 1=2''');
    await db.execute('''CREATE TABLE COU_RED_TMP AS SELECT  * FROM COU_RED WHERE 1=2''');
    await db.execute('''CREATE TABLE BIF_COU_C_TMP AS SELECT  * FROM BIF_COU_C WHERE 1=2''');

    await db.execute('''DELETE FROM LIST_VALUE''');
    await db.execute('''INSERT INTO LIST_VALUE(LVTY,LVID,LVNA,LVNE) values('BMMDN','0','على مستوى الفاتورة','By Invoice level')''');
    await db.execute('''INSERT INTO LIST_VALUE(LVTY,LVID,LVNA,LVNE) values('BMMDN','1','على مستوى الصنف','By Item level')''');
    await db.execute('''INSERT INTO LIST_VALUE(LVTY,LVID,LVNA,LVNE) values('BCPR','1','سعر بيع 1','sale price 1')''');
    await db.execute('''INSERT INTO LIST_VALUE(LVTY,LVID,LVNA,LVNE) values('BCPR','2','سعر بيع 2','sale price 2')''');
    await db.execute('''INSERT INTO LIST_VALUE(LVTY,LVID,LVNA,LVNE) values('BCPR','3','سعر بيع 3','sale price 3')''');
    await db.execute('''INSERT INTO LIST_VALUE(LVTY,LVID,LVNA,LVNE) values('BCPR','4','سعر بيع 4','sale price 4')''');
    await db.execute('''INSERT INTO LIST_VALUE(LVTY,LVID,LVNA,LVNE) values('ST','0','الكل','All')''');
    await db.execute('''INSERT INTO LIST_VALUE(LVTY,LVID,LVNA,LVNE) values('ST','1','فعال','Active')''');
    await db.execute('''INSERT INTO LIST_VALUE(LVTY,LVID,LVNA,LVNE) values('ST','2','موقوف','Not Active')''');
    await db.execute('''INSERT INTO LIST_VALUE(LVTY,LVID,LVNA,LVNE) values('ST','3','وقف مدين','Not debit')''');
    await db.execute('''INSERT INTO LIST_VALUE(LVTY,LVID,LVNA,LVNE) values('ST','4','وقف دائن','Not credit')''');


    await db.execute('''CREATE INDEX COU_INF_M_I1 on COU_INF_M(CIMID,BIID,CTMID)''');
    await db.execute('''CREATE INDEX COU_INF_M_I2 on COU_INF_M(CIMID,BIID,CTMID,JTID_L,BIID_L,SYID_L,CIID_L)''');


//   08-09-2024

    await db.execute('''CREATE TABLE FAT_INV_SND_D_ARC AS SELECT  * FROM FAT_INV_SND_D WHERE 1=2''');
    await db.execute('''CREATE TABLE FAT_INV_SND_R_ARC AS SELECT  * FROM FAT_INV_SND_R WHERE 1=2''');


    await db.execute('''CREATE INDEX BIF_MOV_M_I1 on BIF_MOV_M(BMMID)''');
    await db.execute('''CREATE INDEX BIF_MOV_M_I2 on BIF_MOV_M(BMMID,JTID_L,BIID_L,SYID_L,CIID_L)''');
    await db.execute('''CREATE INDEX BIF_MOV_D_I1 on BIF_MOV_D(BMMID)''');
    await db.execute('''CREATE INDEX BIF_MOV_D_I2 on BIF_MOV_D(BMDID,JTID_L,BIID_L,SYID_L,CIID_L)''');
    await db.execute('''CREATE INDEX BIL_MOV_M_I1 on BIL_MOV_M(BMMID)''');
    await db.execute('''CREATE INDEX BIL_MOV_M_I2 on BIL_MOV_M(BMMID,JTID_L,BIID_L,SYID_L,CIID_L)''');
    await db.execute('''CREATE INDEX BIL_MOV_D_I1 on BIL_MOV_D(BMMID)''');
    await db.execute('''CREATE INDEX BIL_MOV_D_I2 on BIL_MOV_D(BMDID,JTID_L,BIID_L,SYID_L,CIID_L)''');
    await db.execute('''CREATE INDEX SYS_VAR_I1 on SYS_VAR(SVID)''');
    await db.execute('''CREATE INDEX SYS_VAR_I2 on SYS_VAR(SVID,JTID_L,BIID_L,SYID_L,CIID_L)''');
    await db.execute('''CREATE INDEX MAT_GRO_I1 on MAT_GRO(MGNO)''');
    await db.execute('''CREATE INDEX MAT_GRO_I2 on MAT_GRO(MGNO,JTID_L,BIID_L,SYID_L,CIID_L)''');
    await db.execute('''CREATE INDEX MAT_INF_I1 on MAT_INF(MGNO,MINO)''');
    await db.execute('''CREATE INDEX MAT_INF_I2 on MAT_INF(MGNO,MINO,JTID_L,BIID_L,SYID_L,CIID_L)''');
    await db.execute('''CREATE INDEX STO_NUM_I1 on STO_NUM(SIID,MGNO,MINO,MUID)''');
    await db.execute('''CREATE INDEX STO_NUM_I2 on STO_NUM(SIID,MGNO,MINO,MUID,JTID_L,BIID_L,SYID_L,CIID_L)''');
    await db.execute('''CREATE INDEX MAT_PRI_I1 on MAT_PRI(BIID,SCID,MGNO,MINO,MUID)''');
    await db.execute('''CREATE INDEX MAT_PRI_I2 on MAT_PRI(BIID,SCID,MGNO,MINO,MUID,JTID_L,BIID_L,SYID_L,CIID_L)''');
    await db.execute('''CREATE INDEX MAT_UNI_C_I1 on MAT_UNI_C(MGNO,MINO,MUID)''');
    await db.execute('''CREATE INDEX MAT_UNI_C_I2 on MAT_UNI_C(MGNO,MINO,MUID,JTID_L,BIID_L,SYID_L,CIID_L)''');
    await db.execute('''CREATE INDEX MAT_UNI_B_I1 on MAT_UNI_B(MGNO,MINO,MUID)''');
    await db.execute('''CREATE INDEX MAT_UNI_B_I2 on MAT_UNI_B(MGNO,MINO,MUID,JTID_L,BIID_L,SYID_L,CIID_L)''');
    await db.execute('''CREATE INDEX GRO_USR_I1 on GRO_USR(MGNO,SUID)''');
    await db.execute('''CREATE INDEX GRO_USR_I2 on GRO_USR(MGNO,SUID,JTID_L,BIID_L,SYID_L,CIID_L)''');
    await db.execute('''CREATE INDEX SYS_USR_B_I1 on SYS_USR_B(BIID,SUID)''');
    await db.execute('''CREATE INDEX SYS_USR_B_I2 on SYS_USR_B(BIID,SUID,JTID_L,BIID_L,SYID_L,CIID_L)''');
    await db.execute('''CREATE INDEX STO_USR_I1 on STO_USR(SIID,SUID)''');
    await db.execute('''CREATE INDEX STO_USR_I2 on STO_USR(SIID,SUID,JTID_L,BIID_L,SYID_L,CIID_L)''');
    await db.execute('''CREATE INDEX BRA_INF_I1 on BRA_INF(BIID,JTID_L,BIID_L,SYID_L,CIID_L)''');
    await db.execute('''CREATE INDEX BRA_INF_I2 on BRA_INF(BIID)''');
    await db.execute('''CREATE INDEX STO_INF_I1 on STO_INF(SIID,JTID_L,BIID_L,SYID_L,CIID_L)''');
    await db.execute('''CREATE INDEX STO_INF_I2 on STO_INF(SIID)''');
    await db.execute('''CREATE INDEX ACC_ACC_I1 on ACC_ACC(AANO)''');
    await db.execute('''CREATE INDEX ACC_ACC_I2 on ACC_ACC(AANO,JTID_L,BIID_L,SYID_L,CIID_L)''');
    await db.execute('''CREATE INDEX ACC_USR_I1 on ACC_USR(AANO,SUID)''');
    await db.execute('''CREATE INDEX ACC_USR_I2 on ACC_USR(AANO,SUID,JTID_L,BIID_L,SYID_L,CIID_L)''');
    await db.execute('''CREATE INDEX ACC_STA_M_I1 on ACC_STA_M(GUID_REP)''');
    await db.execute('''CREATE INDEX ACC_STA_M_I2 on ACC_STA_M(GUID_REP,JTID_L,BIID_L,SYID_L,CIID_L)''');
    await db.execute('''CREATE INDEX ACC_STA_D_I1 on ACC_STA_D(GUID_REP)''');
    await db.execute('''CREATE INDEX ACC_STA_D_I2 on ACC_STA_D(GUID_REP,JTID_L,BIID_L,SYID_L,CIID_L)''');
    await db.execute(''' CREATE  INDEX BAL_ACC_M_I1 ON BAL_ACC_M(AANO)''');
    await db.execute(''' CREATE  INDEX BAL_ACC_M_I2 ON BAL_ACC_M(AANO,JTID_L,BIID_L,SYID_L,CIID_L)''');
    await db.execute(''' CREATE  INDEX BAL_ACC_M_I3 ON BAL_ACC_M(GUID)''');
    await db.execute(''' CREATE  INDEX BAL_ACC_M_I4 ON BAL_ACC_M(GUID,JTID_L,BIID_L,SYID_L,CIID_L)''');
    await db.execute(''' CREATE  INDEX BAL_ACC_M_I5 ON BAL_ACC_M(GUIDN)''');
    await db.execute(''' CREATE  INDEX BAL_ACC_M_I6 ON BAL_ACC_M(GUIDN,JTID_L,BIID_L,SYID_L,CIID_L)''');
    await db.execute(''' CREATE  INDEX BAL_ACC_C_I1 ON BAL_ACC_C(AANO)''');
    await db.execute(''' CREATE  INDEX BAL_ACC_C_I2 ON BAL_ACC_C(AANO,JTID_L,BIID_L,SYID_L,CIID_L)''');
    await db.execute(''' CREATE  INDEX BAL_ACC_C_I3 ON BAL_ACC_C(GUID)''');
    await db.execute(''' CREATE  INDEX BAL_ACC_C_I4 ON BAL_ACC_C(GUID,JTID_L,BIID_L,SYID_L,CIID_L)''');
    await db.execute(''' CREATE  INDEX BAL_ACC_C_I5 ON BAL_ACC_C(AANO,SCID,BIID)''');
    await db.execute(''' CREATE  INDEX BAL_ACC_C_I6 ON BAL_ACC_C(AANO,SCID,BIID,JTID_L,BIID_L,SYID_L,CIID_L)''');
    await db.execute(''' CREATE  INDEX BAL_ACC_C_I7 ON BAL_ACC_C(GUIDN)''');
    await db.execute(''' CREATE  INDEX BAL_ACC_C_I8 ON BAL_ACC_C(GUIDN,JTID_L,BIID_L,SYID_L,CIID_L)''');
    await db.execute(''' CREATE  INDEX BAL_ACC_C_I9 ON BAL_ACC_C(AANO,SCID)''');
    await db.execute(''' CREATE  INDEX BAL_ACC_C_I10 ON BAL_ACC_C(AANO,SCID,JTID_L,BIID_L,SYID_L,CIID_L)''');
    await db.execute(''' CREATE  INDEX BAL_ACC_D_I1 ON BAL_ACC_D(AANO)''');
    await db.execute(''' CREATE  INDEX BAL_ACC_D_I2 ON BAL_ACC_D(AANO,JTID_L,BIID_L,SYID_L,CIID_L)''');
    await db.execute(''' CREATE  INDEX BAL_ACC_D_I3 ON BAL_ACC_D(GUID)''');
    await db.execute(''' CREATE  INDEX BAL_ACC_D_I4 ON BAL_ACC_D(GUID,JTID_L,BIID_L,SYID_L,CIID_L)''');
    await db.execute(''' CREATE  INDEX BAL_ACC_D_I5 ON BAL_ACC_D(AANO,SCID,BIID)''');
    await db.execute(''' CREATE  INDEX BAL_ACC_D_I6 ON BAL_ACC_D(AANO,SCID,BIID,JTID_L,BIID_L,SYID_L,CIID_L)''');
    await db.execute(''' CREATE  INDEX BAL_ACC_D_I7 ON BAL_ACC_D(GUIDN)''');
    await db.execute(''' CREATE  INDEX BAL_ACC_D_I8 ON BAL_ACC_D(GUIDN,JTID_L,BIID_L,SYID_L,CIID_L)''');
    await db.execute(''' CREATE  INDEX BAL_ACC_D_I9 ON BAL_ACC_D(AANO,SCID)''');
    await db.execute(''' CREATE  INDEX BAL_ACC_D_I10 ON BAL_ACC_D(AANO,SCID,JTID_L,BIID_L,SYID_L,CIID_L)''');
    await db.execute(''' CREATE  INDEX SYN_DAT_I1 ON SYN_DAT(SDTB,GUID)''');
    await db.execute(''' CREATE  INDEX SYN_DAT_I2 ON SYN_DAT(SDTB,GUID,JTID_L,BIID_L,SYID_L,CIID_L)''');
    await db.execute(''' CREATE  INDEX TAX_LIN_I1 ON TAX_LIN(TLTY,TLNO,JTID_L,BIID_L,SYID_L,CIID_L)''');
    await db.execute(''' CREATE  INDEX TAX_LIN_I2 ON TAX_LIN(TLTY,TLNO,TLNO2,JTID_L,BIID_L,SYID_L,CIID_L)''');
    await db.execute(''' CREATE  INDEX ACC_CAS_U_I1 ON ACC_CAS_U(ACID,JTID_L,BIID_L,SYID_L,CIID_L)''');
    await db.execute(''' CREATE  INDEX ACC_CAS_U_I2 ON ACC_CAS_U(ACID,JTID_L,SYID_L,CIID_L)''');
    await db.execute(''' CREATE  INDEX BIF_EORD_M_I1 ON BIF_EORD_M(BMKID,BMMID,JTID_L,SYID_L,CIID_L)''');
    await db.execute(''' CREATE  INDEX MAT_DIS_M_I1 ON MAT_DIS_M(MDMID,JTID_L,SYID_L,CIID_L)''');
    await db.execute(''' CREATE  INDEX MAT_DIS_D_I1 ON MAT_DIS_D(MDDID,JTID_L,SYID_L,CIID_L)''');

    //27-05-2024
    await db.execute('''CREATE INDEX ACC_MOV_M_I1 on ACC_MOV_M(AMMID)''');
    await db.execute('''CREATE INDEX ACC_MOV_M_I2 on ACC_MOV_M(AMMID,JTID_L,SYID_L,CIID_L)''');
    await db.execute('''CREATE INDEX ACC_MOV_M_I3 on ACC_MOV_M(AMMID,JTID_L,BIID_L,SYID_L,CIID_L)''');
    await db.execute('''CREATE INDEX ACC_MOV_D_I1 on ACC_MOV_D(AMMID)''');
    await db.execute('''CREATE INDEX ACC_MOV_D_I2 on ACC_MOV_D(AMDID,JTID_L,SYID_L,CIID_L)''');
    await db.execute('''CREATE INDEX ACC_MOV_D_I3 on ACC_MOV_D(AMDID,JTID_L,BIID_L,SYID_L,CIID_L)''');
    await db.execute('''CREATE INDEX SYS_REP_I1 on SYS_REP(SRID)''');
    await db.execute('''CREATE INDEX SYS_REP_I2 on SYS_REP(SRID,JTID_L,SYID_L,CIID_L)''');
    await db.execute('''CREATE INDEX SYS_REP_I3 on SYS_REP(SRID,JTID_L,BIID_L,SYID_L,CIID_L)''');
    //28-05-2024
    await db.execute('''CREATE INDEX BIL_IMP_T_I1 on BIL_IMP_T(BITID)''');
    await db.execute('''CREATE INDEX BIL_IMP_T_I2 on BIL_IMP_T(BITID,JTID_L,SYID_L,CIID_L)''');
    await db.execute('''CREATE INDEX BIL_IMP_T_I3 on BIL_IMP_T(BITID,JTID_L,BIID_L,SYID_L,CIID_L)''');

    //04-06-2024
    await db.execute('''CREATE INDEX SYS_LAN_I1 on SYS_LAN(SLID)''');
    await db.execute('''CREATE INDEX SYS_LAN_I2 on SYS_LAN(SLID,JTID_L,SYID_L,CIID_L)''');
    await db.execute('''CREATE INDEX SYS_LAN_I3 on SYS_LAN(SLID,JTID_L,BIID_L,SYID_L,CIID_L)''');
    await db.execute('''CREATE INDEX SYS_LAN_I4 on SYS_LAN(SLTY, SLIT, SLSC)''');
    await db.execute('''CREATE INDEX SYS_LAN_I5 on SYS_LAN(SLTY, SLIT, SLSC,JTID_L,SYID_L,CIID_L)''');
    await db.execute('''CREATE INDEX SYS_LAN_I6 on SYS_LAN(SLTY, SLIT, SLSC,JTID_L,BIID_L,SYID_L,CIID_L)''');
    await db.execute('''CREATE INDEX SYS_LAN_I7 on SYS_LAN(SLN1, SLN2, SLN3)''');
    await db.execute('''CREATE INDEX SYS_LAN_I8 on SYS_LAN(SLN1, SLN2, SLN3,JTID_L,SYID_L,CIID_L)''');
    await db.execute('''CREATE INDEX SYS_LAN_I9 on SYS_LAN(SLN1, SLN2, SLN3,JTID_L,BIID_L,SYID_L,CIID_L)''');

    //11-06-2024
    await db.execute('''CREATE INDEX STO_MOV_D_I1 on STO_MOV_D(SMMID,JTID_L,BIID_L,SYID_L,CIID_L)''');
    await db.execute('''CREATE INDEX STO_MOV_D_I2 on STO_MOV_D(MGNO,MINO,MUID,JTID_L,BIID_L,SYID_L,CIID_L)''');
    await db.execute('''CREATE INDEX STO_MOV_M_I1 on STO_MOV_M(SMMID,JTID_L,BIID_L,SYID_L,CIID_L)''');


    //09-09-2024
    await db.execute('''CREATE INDEX FAT_API_INF_I1 on FAT_API_INF(FAISP, STMID, FAITY)''');
    await db.execute('''CREATE INDEX FAT_API_INF_I2 on FAT_API_INF(FAISP, STMID, FAITY,JTID_L,SYID_L,CIID_L)''');
    await db.execute('''CREATE INDEX FAT_CSID_INF_I1 on FAT_CSID_INF(FCIID)''');
    await db.execute('''CREATE INDEX FAT_CSID_INF_I2 on FAT_CSID_INF(FCIID,JTID_L,SYID_L,CIID_L)''');
    await db.execute('''CREATE INDEX FAT_CSID_INF_I3 on FAT_CSID_INF(FCITY, CIIDL, JTIDL, BIIDL, BIIDV,STMIDV, SOMGUV, SUIDV, BMKIDV, FCIBTV, FCIJOB, FCIST)''');
    await db.execute('''CREATE INDEX FAT_CSID_SEQ_I1 on FAT_CSID_SEQ(FCIGU,JTID_L,SYID_L,CIID_L)''');
    await db.execute('''CREATE INDEX FAT_CSID_ST_I1 on FAT_CSID_ST(FCIGU,JTID_L,SYID_L,CIID_L)''');
    await db.execute('''CREATE INDEX FAT_INV_RS_I1 on FAT_INV_RS(FISGU,JTID_L,SYID_L,CIID_L)''');
    await db.execute('''CREATE INDEX FAT_INV_RS_I2 on FAT_INV_RS(BMMGU,JTID_L,SYID_L,CIID_L)''');
    await db.execute('''CREATE INDEX FAT_INV_SND_I1 on FAT_INV_SND(FISSEQ,JTID_L,SYID_L,CIID_L)''');
    await db.execute('''CREATE INDEX FAT_INV_SND_I2 on FAT_INV_SND(FCIGU,JTID_L,SYID_L,CIID_L)''');
    await db.execute('''CREATE INDEX FAT_INV_SND_I3 on FAT_INV_SND(CIIDL, JTIDL, BIIDL, SYIDL)''');
    await db.execute('''CREATE INDEX FAT_INV_SND_I4 on FAT_INV_SND(BMMGU,JTID_L,SYID_L,CIID_L)''');
    await db.execute('''CREATE INDEX FAT_INV_SND_I5 on FAT_INV_SND(FISST,JTID_L,SYID_L,CIID_L)''');
    await db.execute('''CREATE INDEX FAT_LOG_I1 on FAT_LOG(FLSEQ,JTID_L,SYID_L,CIID_L)''');
    await db.execute('''CREATE INDEX FAT_LOG_I2 on FAT_LOG(CIIDL, JTIDL, BIIDL, SYIDL)''');
    await db.execute('''CREATE INDEX FAT_LOG_I3 on FAT_LOG(BMMGU,JTID_L,SYID_L,CIID_L)''');
    await db.execute('''CREATE INDEX FAT_SND_LOG_I1 on FAT_SND_LOG(FSLSEQ,JTID_L,SYID_L,CIID_L)''');
    await db.execute('''CREATE INDEX FAT_SND_LOG_I2 on FAT_SND_LOG(BMMGU,JTID_L,SYID_L,CIID_L)''');
    await db.execute('''CREATE INDEX FAT_SND_LOG_I3 on FAT_SND_LOG(FSLGU,JTID_L,SYID_L,CIID_L)''');
    await db.execute('''CREATE INDEX FAT_SND_LOG_D_I1 on FAT_SND_LOG_D(FSLSEQ,JTID_L,SYID_L,CIID_L)''');

    await db.execute('''CREATE INDEX FAT_INV_SND_D_I1 on FAT_INV_SND_D(FISDGU,JTID_L,SYID_L,CIID_L)''');
    await db.execute('''CREATE INDEX FAT_INV_SND_D_I2 on FAT_INV_SND_D(FISGU,JTID_L,SYID_L,CIID_L)''');
    await db.execute('''CREATE INDEX FAT_INV_SND_D_ARC_I1 on FAT_INV_SND_D_ARC(FISDGU, JTID_L,SYID_L,CIID_L)''');
    await db.execute('''CREATE INDEX FAT_INV_SND_D_ARC_I2 on FAT_INV_SND_D_ARC(FISGU,JTID_L,SYID_L,CIID_L)''');
    await db.execute('''CREATE INDEX FAT_INV_SND_R_I1 on FAT_INV_SND_R(FISRGU,JTID_L,SYID_L,CIID_L)''');
    await db.execute('''CREATE INDEX FAT_INV_SND_R_I2 on FAT_INV_SND_R(FISGU,JTID_L,SYID_L,CIID_L)''');
    await db.execute('''CREATE INDEX FAT_INV_SND_R_ARC_I1 on FAT_INV_SND_R_ARC(FISRGU, JTID_L,SYID_L,CIID_L)''');
    await db.execute('''CREATE INDEX FAT_INV_SND_R_ARC_I2 on FAT_INV_SND_R_ARC(FISGU,JTID_L,SYID_L,CIID_L)''');

  }

  Future onUpgrade(Database db, int oldversion,int newversion)async{
    await ErrorHandlerService.run(() async {
      var batch = db.batch();

      if (oldversion == 1) {
        await db.execute('''
       CREATE TABLE SYN_ORD_L (
   SOLSQ           INTEGER,
  SOID            TEXT,
  STMID           TEXT,
  STID            TEXT,
  SOKI            TEXT,
  SOTY            TEXT,
  SOET            TEXT,
  SOFT            TEXT,
  SOTT            TEXT,
  SDSQ            INTEGER,
  SDNO            TEXT,
  GUID            TEXT,
  SDTY            TEXT,
  CIID            INTEGER,
  JTID            INTEGER,
  SYID            INTEGER,
  SYDV_NAME       TEXT,
  SYDV_IP         TEXT,
  SYDV_SER        TEXT,
  SYDV_POI        TEXT,
  SYDV_NO         TEXT,
  SYDV_BRA        TEXT,
  SOLST           INTEGER                        DEFAULT 2,
  BIID            INTEGER,
  SOLKI           INTEGER,
  SOLDO           DATE,
  SOLID           INTEGER,
  SOLNO           INTEGER,
  SOLAM           REAL                        DEFAULT 0,
  SOLGU           TEXT,
  SUID            TEXT,
  BIID2           INTEGER,
  SOLKI2          INTEGER,
  SOLDO2          DATE,
  SOLID2          INTEGER,
  SOLNO2          INTEGER,
  SOLAM2          REAL                        DEFAULT 0,
  SOLGU2          TEXT,
  SUID2           TEXT,
  SOLER           TEXT,
  SOLIN           TEXT,
  SOLN1           INTEGER,
  SOLN2           INTEGER,
  SOLN3           INTEGER,
  SOLC1           TEXT,
  SOLC2           TEXT,
  SOLC3           TEXT,
  DATEI           DATE,
  SUCH            TEXT,
  DATEU           DATE,
  SYDV_LATITUDE   TEXT,
  SYDV_LONGITUDE  TEXT,
  SYDV_APPV       TEXT,
  SMID            INTEGER,
  SYDV_TY         TEXT,
  SYDV_ID         TEXT,
  SYDV_APIV       TEXT,
  SYDV_GU         TEXT,
  SOGU            TEXT,
  SOLNT           INTEGER,
  SOLDF           DATE,
  JTID_L INTEGER,
  BIID_L INTEGER,
  SYID_L INTEGER,
  CIID_L TEXT 
         )  
      ''');
        await db.execute('''
       CREATE TABLE ACC_CAS_U (
   ACID   INTEGER,
  ACUTY  INTEGER                             DEFAULT 1,
  SUID   TEXT,
  ACCT   INTEGER                             DEFAULT 1,
  SCID   INTEGER,
  ACTMS  INTEGER                             DEFAULT 1,
  ACTMP  INTEGER                             DEFAULT 0,
  ACUST  INTEGER                             DEFAULT 1,
  ACUAM  REAL,
  SUCH   TEXT,
  GUID   TEXT,
  DATEI  DATE,
  DATEU  DATE,
  DEVI   TEXT,
  DEVU   TEXT,
  SUID2  TEXT,
  JTID_L INTEGER,
  BIID_L INTEGER,
  SYID_L INTEGER,
  CIID_L TEXT 
         )  
      ''');
        await db.execute('''CREATE TABLE SYN_ORD_L_TMP AS SELECT  * FROM SYN_ORD_L WHERE 1=2''');
        await db.execute('''CREATE TABLE ACC_CAS_U_TMP AS SELECT  * FROM ACC_CAS_U WHERE 1=2''');
        await db.execute('''ALTER TABLE BIL_POI ADD COLUMN BPSEO INTEGER''');
        await db.execute('''ALTER TABLE BIL_POI ADD COLUMN BPIDT INTEGER''');
        await db.execute('''ALTER TABLE BIL_POI ADD COLUMN BPIDV TEXT''');
        await db.execute('''ALTER TABLE BIL_MOV_M ADD COLUMN TTID1 INTEGER''');
        await db.execute('''ALTER TABLE BIL_MOV_M ADD COLUMN TTID2 INTEGER''');
        await db.execute('''ALTER TABLE BIL_MOV_M ADD COLUMN TTID3 INTEGER''');
        await db.execute('''ALTER TABLE BIL_MOV_M ADD COLUMN TMTID2 INTEGER''');
        await db.execute('''ALTER TABLE BIL_MOV_M ADD COLUMN ATTID2  INTEGER''');
        await db.execute('''ALTER TABLE BIL_MOV_M ADD COLUMN STMID_NO INTEGER''');
        await db.execute('''ALTER TABLE BIL_MOV_M ADD COLUMN DEVI_NO INTEGER''');
        await db.execute('''ALTER TABLE BIF_MOV_M ADD COLUMN TTID1 INTEGER''');
        await db.execute('''ALTER TABLE BIF_MOV_M ADD COLUMN TTID2 INTEGER''');
        await db.execute('''ALTER TABLE BIF_MOV_M ADD COLUMN TTID3 INTEGER''');
        await db.execute('''ALTER TABLE BIF_MOV_M ADD COLUMN TMTID2 INTEGER''');
        await db.execute('''ALTER TABLE BIF_MOV_M ADD COLUMN ATTID2  INTEGER''');
        await db.execute('''ALTER TABLE BIF_MOV_M ADD COLUMN STMID_NO INTEGER''');
        await db.execute('''ALTER TABLE BIF_MOV_M ADD COLUMN DEVI_NO INTEGER''');
        await db.execute('''ALTER TABLE BIF_MOV_M ADD COLUMN BMMST2 INTEGER DEFAULT 2''');
        await db.execute('''ALTER TABLE BIL_MOV_M ADD COLUMN BMMST2 INTEGER DEFAULT 2''');



        await db.execute('''ALTER TABLE BIL_MOV_M ADD COLUMN BMMTX11  REAL''');
        await db.execute('''ALTER TABLE BIL_MOV_M ADD COLUMN BMMTX22  REAL''');
        await db.execute('''ALTER TABLE BIL_MOV_M ADD COLUMN BMMTX33 REAL''');
        await db.execute('''ALTER TABLE BIF_MOV_M ADD COLUMN BMMTX11  REAL''');
        await db.execute('''ALTER TABLE BIF_MOV_M ADD COLUMN BMMTX22  REAL''');
        await db.execute('''ALTER TABLE BIF_MOV_M ADD COLUMN BMMTX33 REAL''');



        await db.execute('''ALTER TABLE BIL_MOV_D ADD COLUMN BMDTX11 REAL''');
        await db.execute('''ALTER TABLE BIL_MOV_D ADD COLUMN BMDTX22 REAL''');
        await db.execute('''ALTER TABLE BIL_MOV_D ADD COLUMN BMDTX33 REAL''');
        await db.execute('''ALTER TABLE BIL_MOV_D ADD COLUMN BMDTXA11 REAL''');
        await db.execute('''ALTER TABLE BIL_MOV_D ADD COLUMN BMDTXA22  REAL''');
        await db.execute('''ALTER TABLE BIL_MOV_D ADD COLUMN BMDTXA33  REAL''');
        await db.execute('''ALTER TABLE BIF_MOV_D ADD COLUMN BMDTX11  REAL''');
        await db.execute('''ALTER TABLE BIF_MOV_D ADD COLUMN BMDTX22 REAL''');
        await db.execute('''ALTER TABLE BIF_MOV_D ADD COLUMN BMDTX33 REAL''');
        await db.execute('''ALTER TABLE BIF_MOV_D ADD COLUMN BMDTXA11 REAL''');
        await db.execute('''ALTER TABLE BIF_MOV_D ADD COLUMN BMDTXA22 REAL''');
        await db.execute('''ALTER TABLE BIF_MOV_D ADD COLUMN BMDTXA33 REAL''');

        await db.execute(''' CREATE  INDEX ACC_CAS_U_I1 ON ACC_CAS_U(ACID,JTID_L,BIID_L,SYID_L,CIID_L)''');
        await db.execute(''' CREATE  INDEX ACC_CAS_U_I2 ON ACC_CAS_U(ACID,JTID_L,SYID_L,CIID_L)''');

        await db.execute('''ALTER TABLE BIL_MOV_M ADD COLUMN SCIDP INTEGER''');
        await db.execute('''ALTER TABLE BIL_MOV_M ADD COLUMN SCEXP REAL''');
        await db.execute('''ALTER TABLE BIL_MOV_M ADD COLUMN BMMAMP REAL''');
        await db.execute('''ALTER TABLE BIL_MOV_M ADD COLUMN SCIDP2 INTEGER''');
        await db.execute('''ALTER TABLE BIL_MOV_M ADD COLUMN SCEXP2 REAL''');
        await db.execute('''ALTER TABLE BIL_MOV_M ADD COLUMN BMMAMP2 REAL''');
        await db.execute('''ALTER TABLE BIL_MOV_M ADD COLUMN BMMCP REAL''');
        await db.execute('''ALTER TABLE BIL_MOV_M ADD COLUMN BMMTC REAL''');
        await db.execute('''ALTER TABLE ACC_MOV_D ADD COLUMN AMDSS INTEGER''');
        await db.execute('''ALTER TABLE ACC_MOV_D ADD COLUMN AMDMS TEXT''');
        await db.execute('''ALTER TABLE BIL_MOV_M ADD COLUMN AMMID INTEGER''');
        await db.execute('''ALTER TABLE BIF_MOV_M ADD COLUMN AMMID INTEGER''');
        await db.execute(''' DROP TABLE SYN_LOG ''');
        await db.execute('''
         CREATE TABLE SYN_LOG (   
         SLSQ            INTEGER PRIMARY KEY,
       SLDO            DATE ,
       SLIN            TEXT,
       SLTY            TEXT,
    SUID            TEXT,
    STMSQ           INTEGER,
    SMID            INTEGER,
    STMID           TEXT,
    GUID            TEXT,
    SOTT            TEXT,
    SOTY            TEXT,
    SLC1            TEXT,
    CIID            INTEGER,
    JTID            INTEGER,
    BIID            INTEGER,
    SYID            INTEGER,
    SOMID           INTEGER,
    SYDV_NAME       TEXT,
    SYDV_IP         TEXT,
    SYDV_SER        TEXT,
    SYDV_POI        TEXT,
    SYDV_NO         TEXT,
    SYDV_LATITUDE   TEXT,
    SYDV_LONGITUDE  TEXT,
    SYDV_APPV       TEXT,
    SYDV_APIV       TEXT,
    SYDV_TY         TEXT,
    SDSQ            INTEGER,
    SLTY2           INTEGER,
    SLIT2           TEXT,
    SLSC2           TEXT,
    SLTYP           TEXT,
    SLC2            TEXT,
    SLC3            TEXT,
    SYDV_ID         TEXT,
    SYDV_GU         TEXT,
    SOGU            TEXT,
         JTID_L INTEGER,
         BIID_L INTEGER,
         SYID_L INTEGER,
         CIID_L TEXT
         )  
      ''');
        await db.execute('''
       CREATE TABLE TAX_LOC (
   TLID   INTEGER,
  GUID  TEXT ,
  TLSY   TEXT,
  TLNA   TEXT ,
  TLNE   TEXT,
  TLN3  TEXT,
  TTID  INTEGER                             DEFAULT 0,
  CWID  INTEGER                             DEFAULT 1,
  CTID  INTEGER,
  TLST   INTEGER,
  TLDE   TEXT,
  AANOO  TEXT,
  AANOI  TEXT,
  AANOR   TEXT,
  AANORR   TEXT,
  TLDC  INTEGER,
  ORDNU  INTEGER,
  RES  TEXT,
  SUID  TEXT,
  DATEI  TEXT,
  DEVI  TEXT,
  SUCH  TEXT,
  DATEU  TEXT,
  DEVU  TEXT,
  DEFN INTEGER,
  JTID_L INTEGER,
  BIID_L INTEGER,
  SYID_L INTEGER,
  CIID_L TEXT 
         )  
      ''');
        await db.execute('''
       CREATE TABLE TAX_LOC_SYS (
   TLSID   INTEGER,
  TLID    INTEGER,
  STID    TEXT,
  GUID    TEXT,
  AANOO   TEXT,
  AANOI   TEXT,
  AANOR   TEXT,
  AANORR  TEXT,
  TLSDC   INTEGER,
  ORDNU   INTEGER,
  RES     TEXT,
  SUID    TEXT,
  DATEI   TEXT ,
  DEVI    TEXT,
  SUCH    TEXT,
  DATEU   TEXT,
  DEVU    TEXT,
  DEFN    INTEGER ,
  JTID_L INTEGER,
  BIID_L INTEGER,
  SYID_L INTEGER,
  CIID_L TEXT 
         )  
      ''');
        await db.execute('''
       CREATE TABLE TAX_MOV_SIN (
  TMSID   INTEGER,
  GUID    TEXT,
  TMSNA   TEXT,
  TMSNE   TEXT,
  TMSN3   TEXT,
  TMSSY   TEXT,
  TMSST   INTEGER                                DEFAULT 1,
  TMSDE   TEXT,
  TMSDE2  TEXT,
  TTID    INTEGER,
  TCID    INTEGER,
  TCSID   INTEGER,
  TCSSY   TEXT,
  TCSDSY  TEXT,
  TMSIT   INTEGER                                DEFAULT 1,
  TMSAC   INTEGER                                DEFAULT 2,
  TMSCO   TEXT,
  TMSDL   INTEGER                                DEFAULT 1,
  TMSUP   INTEGER                                DEFAULT 1,
  ORDNU   INTEGER,
  RES     TEXT,
  SUID    TEXT,
  DATEI   TEXT,
  DEVI    TEXT,
  SUCH    TEXT,
  DATEU   TEXT,
  DEVU    TEXT,
  DEFN    INTEGER ,
  JTID_L INTEGER,
  BIID_L INTEGER,
  SYID_L INTEGER,
  CIID_L TEXT 
         )  
      ''');
        await db.execute('''
       CREATE TABLE TAX_VAR (
 TVID   INTEGER,
  TVSY   TEXT,
  TVNA   TEXT,
  TVNE   TEXT,
  TVN3   TEXT,
  TVVL   TEXT,
  TVDT   TEXT,
  TVDS   TEXT,
  TVDH   INTEGER,
  TVDA   INTEGER,
  TVAD   INTEGER ,
  STID   TEXT,
  STMID  TEXT,
  PRID   TEXT,
  PRIDY  TEXT,
  PRIDN  TEXT,
  TVDAC  INTEGER,
  TVCH   INTEGER,
  TVDL   INTEGER,
  TVIDF  INTEGER,
  TVST   INTEGER,
  ORDNU  INTEGER,
  RES   TEXT,
  SUID   TEXT,
  DATEI  TEXT,
  DEVI   TEXT,
  SUCH   TEXT,
  DATEU  TEXT,
  DEVU   TEXT,
  DEFN   INTEGER,
  GUID   TEXT,
  JTID_L INTEGER,
  BIID_L INTEGER,
  SYID_L INTEGER,
  CIID_L TEXT 
         )  
      ''');
        await db.execute('''
       CREATE TABLE TAX_VAR_D (
  TVDID   INTEGER,
  TVID    INTEGER,
  TTID    INTEGER,
  TVDSY   TEXT,
  TVDTY   INTEGER,
  TVDVL   TEXT,
  TVDDA   DATE,
  STID    TEXT,
  STMID   TEXT,
  PRID    TEXT,
  PRIDY   TEXT,
  PRIDN   TEXT,
  TVDCH   INTEGER,
  TVDIDF  INTEGER,
  TVDST   INTEGER,
  ORDNU   INTEGER,
  RES     TEXT,
  SUID    TEXT,
  DATEI   TEXT,
  DEVI    TEXT,
  SUCH    TEXT,
  DATEU   TEXT,
  DEVU    TEXT,
  DEFN    INTEGER ,
  GUID   TEXT,
  JTID_L INTEGER,
  BIID_L INTEGER,
  SYID_L INTEGER,
  CIID_L TEXT 
         )  
      ''');
        await db.execute('''
       CREATE TABLE TAX_TBL_LNK (
TTLID     INTEGER,
  GUID     TEXT,
  TTID      INTEGER,
  TTLNA     TEXT,
  TTLNE     TEXT,
  TTLN3     TEXT,
  STID     TEXT,
  TTLTB     TEXT,
  TTLNO    TEXT,
  TTLNO2   TEXT,
  TTLSY     TEXT,
  TTLNOL   TEXT,
  TTLNO2L  TEXT,
  TTLSY2    TEXT,
  TTLNOL2  TEXT,
  TTLNO2L2 TEXT,
  TTLST     INTEGER,
  TTLCO    TEXT,
  TTLLN     INTEGER,
  TTLHN     INTEGER,
  TTLDE     TEXT,
  TTLVB     INTEGER,
  TTLVN     INTEGER,
  TTLVF     INTEGER,
  TTLSN     TEXT,
  TTLUP     INTEGER,
  TTLDL     INTEGER,
  TTLN1     INTEGER,
  TTLN2     INTEGER,
  TTLC1     TEXT,
  TTLC2     TEXT,
  ORDNU     INTEGER,
  RES       TEXT,
  SUID      TEXT,
  DATEI     TEXT,
  DEVI      TEXT,
  SUCH      TEXT,
  DATEU     TEXT,
  DEVU      TEXT,
  DEFN      INTEGER,               
  JTID_L INTEGER,
  BIID_L INTEGER,
  SYID_L INTEGER,
  CIID_L TEXT 
         )  
      ''');
        await db.execute('''CREATE TABLE TAX_TBL_LNK_TMP AS  SELECT  * FROM TAX_TBL_LNK WHERE 1=2''');
        await db.execute('''CREATE TABLE TAX_VAR_D_TMP AS  SELECT  * FROM TAX_VAR_D WHERE 1=2''');
        await db.execute('''CREATE TABLE TAX_VAR_TMP AS  SELECT  * FROM TAX_VAR WHERE 1=2''');
        await db.execute('''CREATE TABLE TAX_MOV_SIN_TMP AS  SELECT  * FROM TAX_MOV_SIN WHERE 1=2''');
        await db.execute('''CREATE TABLE TAX_LOC_SYS_TMP AS  SELECT  * FROM TAX_LOC_SYS WHERE 1=2''');
        await db.execute('''CREATE TABLE TAX_LOC_TMP AS  SELECT  * FROM TAX_LOC WHERE 1=2''');

        await db.execute('''ALTER TABLE BIL_MOV_D ADD COLUMN BMDTXT1 REAL''');
        await db.execute('''ALTER TABLE BIL_MOV_D ADD COLUMN BMDTXT2 REAL''');
        await db.execute('''ALTER TABLE BIL_MOV_D ADD COLUMN BMDTXT3 REAL''');
        await db.execute('''ALTER TABLE BIF_MOV_D ADD COLUMN BMDTXT1 REAL''');
        await db.execute('''ALTER TABLE BIF_MOV_D ADD COLUMN BMDTXT2 REAL''');
        await db.execute('''ALTER TABLE BIF_MOV_D ADD COLUMN BMDTXT3 REAL''');
        await db.execute('''ALTER TABLE ACC_ACC ADD COLUMN  SYST_L INTEGER  DEFAULT 1''');
        await db.execute('''ALTER TABLE ACC_USR ADD COLUMN  SYST_L INTEGER  DEFAULT 1''');

        await db.execute('''ALTER TABLE TAX_SYS_BRA ADD COLUMN  SUID TEXT  ''');
        await db.execute('''ALTER TABLE TAX_SYS_BRA ADD COLUMN  DATEI TEXT ''');
        await db.execute('''ALTER TABLE TAX_SYS_BRA ADD COLUMN  DEVI TEXT  ''');
        await db.execute('''ALTER TABLE TAX_SYS_BRA ADD COLUMN  SUCH TEXT  ''');
        await db.execute('''ALTER TABLE TAX_SYS_BRA ADD COLUMN  DATEU TEXT ''');
        await db.execute('''ALTER TABLE TAX_SYS_BRA ADD COLUMN  DEVU TEXT  ''');


        await db.execute('''INSERT INTO SYN_ORD(SOET,ROW_NUM,SOOR,SOST,JTID_L,BIID_L,SYID_L,CIID_L) values('TAX_TYP_SYS',0,83,1, ${LoginController().JTID},${LoginController().BIID},${LoginController().SYID},'${LoginController().CIID}')''');
        await db.execute('''INSERT INTO SYN_ORD(SOET,ROW_NUM,SOOR,SOST,JTID_L,BIID_L,SYID_L,CIID_L) values('TAX_TYP',0,84,1, ${LoginController().JTID},${LoginController().BIID},${LoginController().SYID},'${LoginController().CIID}')''');
        await db.execute('''INSERT INTO SYN_ORD(SOET,ROW_NUM,SOOR,SOST,JTID_L,BIID_L,SYID_L,CIID_L) values('TAX_TYP_BRA',0,85,1, ${LoginController().JTID},${LoginController().BIID},${LoginController().SYID},'${LoginController().CIID}')''');
        await db.execute('''INSERT INTO SYN_ORD(SOET,ROW_NUM,SOOR,SOST,JTID_L,BIID_L,SYID_L,CIID_L) values('TAX_LOC_SYS',0,89,1, ${LoginController().JTID},${LoginController().BIID},${LoginController().SYID},'${LoginController().CIID}')''');
        await db.execute('''INSERT INTO SYN_ORD(SOET,ROW_NUM,SOOR,SOST,JTID_L,BIID_L,SYID_L,CIID_L) values('TAX_LOC',0,90,1, ${LoginController().JTID},${LoginController().BIID},${LoginController().SYID},'${LoginController().CIID}')''');
        await db.execute('''INSERT INTO SYN_ORD(SOET,ROW_NUM,SOOR,SOST,JTID_L,BIID_L,SYID_L,CIID_L) values('TAX_COD_SYS',0,91,1, ${LoginController().JTID},${LoginController().BIID},${LoginController().SYID},'${LoginController().CIID}')''');
        await db.execute('''INSERT INTO SYN_ORD(SOET,ROW_NUM,SOOR,SOST,JTID_L,BIID_L,SYID_L,CIID_L) values('TAX_COD',0,92,1, ${LoginController().JTID},${LoginController().BIID},${LoginController().SYID},'${LoginController().CIID}')''');
        await db.execute('''INSERT INTO SYN_ORD(SOET,ROW_NUM,SOOR,SOST,JTID_L,BIID_L,SYID_L,CIID_L) values('TAX_COD_SYS_D',0,93,1, ${LoginController().JTID},${LoginController().BIID},${LoginController().SYID},'${LoginController().CIID}')''');
        await db.execute('''INSERT INTO SYN_ORD(SOET,ROW_NUM,SOOR,SOST,JTID_L,BIID_L,SYID_L,CIID_L) values('TAX_SYS',0,94,1, ${LoginController().JTID},${LoginController().BIID},${LoginController().SYID},'${LoginController().CIID}')''');
        await db.execute('''INSERT INTO SYN_ORD(SOET,ROW_NUM,SOOR,SOST,JTID_L,BIID_L,SYID_L,CIID_L) values('TAX_SYS_BRA',0,95,1, ${LoginController().JTID},${LoginController().BIID},${LoginController().SYID},'${LoginController().CIID}')''');
        await db.execute('''INSERT INTO SYN_ORD(SOET,ROW_NUM,SOOR,SOST,JTID_L,BIID_L,SYID_L,CIID_L) values('TAX_SYS_D',0,96,1, ${LoginController().JTID},${LoginController().BIID},${LoginController().SYID},'${LoginController().CIID}')''');
        await db.execute('''INSERT INTO SYN_ORD(SOET,ROW_NUM,SOOR,SOST,JTID_L,BIID_L,SYID_L,CIID_L) values('TAX_VAR',0,97,1, ${LoginController().JTID},${LoginController().BIID},${LoginController().SYID},'${LoginController().CIID}')''');
        await db.execute('''INSERT INTO SYN_ORD(SOET,ROW_NUM,SOOR,SOST,JTID_L,BIID_L,SYID_L,CIID_L) values('TAX_VAR_D',0,98,1, ${LoginController().JTID},${LoginController().BIID},${LoginController().SYID},'${LoginController().CIID}')''');
        await db.execute('''INSERT INTO SYN_ORD(SOET,ROW_NUM,SOOR,SOST,JTID_L,BIID_L,SYID_L,CIID_L) values('TAX_LIN',0,99,1, ${LoginController().JTID},${LoginController().BIID},${LoginController().SYID},'${LoginController().CIID}')''');
        await db.execute('''INSERT INTO SYN_ORD(SOET,ROW_NUM,SOOR,SOST,JTID_L,BIID_L,SYID_L,CIID_L) values('IDE_TYP',0,100,1, ${LoginController().JTID},${LoginController().BIID},${LoginController().SYID},'${LoginController().CIID}')''');
        await db.execute('''INSERT INTO SYN_ORD(SOET,ROW_NUM,SOOR,SOST,JTID_L,BIID_L,SYID_L,CIID_L) values('IDE_LIN',0,101,1, ${LoginController().JTID},${LoginController().BIID},${LoginController().SYID},'${LoginController().CIID}')''');
        await db.execute('''INSERT INTO SYN_ORD(SOET,ROW_NUM,SOOR,SOST,JTID_L,BIID_L,SYID_L,CIID_L) values('TAX_MOV_SIN',0,102,1, ${LoginController().JTID},${LoginController().BIID},${LoginController().SYID},'${LoginController().CIID}')''');
        await db.execute('''INSERT INTO SYN_ORD(SOET,ROW_NUM,SOOR,SOST,JTID_L,BIID_L,SYID_L,CIID_L) values('TAX_TBL_LNK',0,103,1, ${LoginController().JTID},${LoginController().BIID},${LoginController().SYID},'${LoginController().CIID}')''');
        await db.execute('''INSERT INTO SYN_ORD(SOET,ROW_NUM,SOOR,SOST,JTID_L,BIID_L,SYID_L,CIID_L) values('RES_SEC',0,301,1, ${LoginController().JTID},${LoginController().BIID},${LoginController().SYID},'${LoginController().CIID}')''');
        await db.execute('''INSERT INTO SYN_ORD(SOET,ROW_NUM,SOOR,SOST,JTID_L,BIID_L,SYID_L,CIID_L) values('RES_TAB',0,302,1, ${LoginController().JTID},${LoginController().BIID},${LoginController().SYID},'${LoginController().CIID}')''');
        await db.execute('''INSERT INTO SYN_ORD(SOET,ROW_NUM,SOOR,SOST,JTID_L,BIID_L,SYID_L,CIID_L) values('RES_EMP',0,303,1, ${LoginController().JTID},${LoginController().BIID},${LoginController().SYID},'${LoginController().CIID}')''');
        await db.execute('''INSERT INTO SYN_ORD(SOET,ROW_NUM,SOOR,SOST,JTID_L,BIID_L,SYID_L,CIID_L) values('BIF_GRO',0,304,1, ${LoginController().JTID},${LoginController().BIID},${LoginController().SYID},'${LoginController().CIID}')''');
        await db.execute('''INSERT INTO SYN_ORD(SOET,ROW_NUM,SOOR,SOST,JTID_L,BIID_L,SYID_L,CIID_L) values('BIF_GRO2',0,305,1, ${LoginController().JTID},${LoginController().BIID},${LoginController().SYID},'${LoginController().CIID}')''');
        await db.execute('''INSERT INTO SYN_ORD(SOET,ROW_NUM,SOOR,SOST,JTID_L,BIID_L,SYID_L,CIID_L) values('MAT_FOL',0,306,1, ${LoginController().JTID},${LoginController().BIID},${LoginController().SYID},'${LoginController().CIID}')''');
        await db.execute('''INSERT INTO SYN_ORD(SOET,ROW_NUM,SOOR,SOST,JTID_L,BIID_L,SYID_L,CIID_L) values('MAT_DES_M',0,307,1, ${LoginController().JTID},${LoginController().BIID},${LoginController().SYID},'${LoginController().CIID}')''');
        await db.execute('''INSERT INTO SYN_ORD(SOET,ROW_NUM,SOOR,SOST,JTID_L,BIID_L,SYID_L,CIID_L) values('MAT_DES_D',0,308,1, ${LoginController().JTID},${LoginController().BIID},${LoginController().SYID},'${LoginController().CIID}')''');

        await db.execute('''UPDATE BIL_MOV_D SET BMDTX11=BMDTX,BMDTXA11=BMDTXA,BMDTXT1=BMDTXT''');
        await db.execute('''UPDATE BIF_MOV_D SET BMDTX11=BMDTX,BMDTXA11=BMDTXA,BMDTXT1=BMDTXT''');
        await db.execute('''UPDATE BIL_MOV_M SET BMMTX11=BMMTX, TTID1=1''');
        await db.execute('''UPDATE BIF_MOV_M SET BMMTX11=BMMTX, TTID1=1''');

        await db.execute('''
       CREATE TABLE RES_SEC (
  RSID   INTEGER,
  RSNA   TEXT,
  RSNE   TEXT,
  RSHN   TEXT,
  RSST   INTEGER                            DEFAULT 1,
  RSFN   INTEGER,
  RSIN   TEXT,
  BIID   INTEGER,
  ORDNU  INTEGER,
  RES    TEXT,
  DATEI  DATE,
  SUID   TEXT,
  SUCH   TEXT,
  DATEU  DATE,
  DEVI   TEXT,
  DEVU   TEXT,
  DEFN   INTEGER,
  RSN3   TEXT,
  GUID   TEXT,               
  JTID_L INTEGER,
  BIID_L INTEGER,
  SYID_L INTEGER,
  CIID_L TEXT 
         )  
      ''');
        await db.execute('''
       CREATE TABLE RES_TAB (
  RSID   INTEGER,
  RTID   TEXT,
  RTNA   TEXT,
  RTNE   TEXT,
  RTST   INTEGER                            DEFAULT 1,
  RTIN   TEXT,
  BIID   INTEGER,
  ORDNU  INTEGER,
  RES    TEXT,
  DATEI  DATE,
  SUID   TEXT,
  SUCH   TEXT,
  DATEU  DATE,
  DEVI   TEXT,
  DEVU   TEXT,
  DEFN   INTEGER,
  RTN3   TEXT,
  GUID   TEXT,              
  JTID_L INTEGER,
  BIID_L INTEGER,
  SYID_L INTEGER,
  CIID_L TEXT 
         )  
      ''');
        await db.execute('''
       CREATE TABLE RES_EMP (
  REID   INTEGER,
  RSID   INTEGER,
  RENA   TEXT,
  RENE   TEXT,
  REST   INTEGER                            DEFAULT 1,
  REIN   TEXT,
  BIID   INTEGER,
  ORDNU  INTEGER,
  RES    TEXT,
  DATEI  DATE,
  SUID   TEXT,
  SUCH   TEXT,
  DATEU  DATE,
  DEVI   TEXT,
  DEVU   TEXT,
  DEFN   INTEGER,
  REN3   TEXT,
  GUID   TEXT,              
  JTID_L INTEGER,
  BIID_L INTEGER,
  SYID_L INTEGER,
  CIID_L TEXT 
         )  
      ''');
        await db.execute('''
       CREATE TABLE BIF_GRO (
  MGNO  TEXT,
  BGOR  INTEGER,
  BGBR  TEXT,
  BGCR  TEXT,
  BGMA  TEXT,  
  DATEI  DATE,
  SUID   TEXT,
  SUCH   TEXT,
  DATEU  DATE,
  DEVI   TEXT,
  DEVU   TEXT,
  BGST   INTEGER,
  GUID   TEXT,            
  JTID_L INTEGER,
  BIID_L INTEGER,
  SYID_L INTEGER,
  CIID_L TEXT 
         )  
      ''');
        await db.execute('''
       CREATE TABLE BIF_GRO2 (
  MGNO  TEXT,
  BGOR  INTEGER,
  BGBR  TEXT,
  BGCR  TEXT,
  BGMA  TEXT, 
  BGST   INTEGER, 
  DATEI  DATE,
  SUID   TEXT,
  SUCH   TEXT,
  DATEU  DATE,
  DEVI   TEXT,
  DEVU   TEXT,
  GUID   TEXT,            
  JTID_L INTEGER,
  BIID_L INTEGER,
  SYID_L INTEGER,
  CIID_L TEXT 
         )  
      ''');
        await db.execute('''
       CREATE TABLE BIF_MOV_A (
 BMKID  INTEGER,
  BMMID  INTEGER,
  BMMNO  INTEGER,
  RSID   INTEGER,
  RTID   TEXT,
  REID   INTEGER,
  BMATY  INTEGER                             DEFAULT 1,
  GUID   TEXT,
  BDID   INTEGER,
  BMACR  REAL                            DEFAULT 0,
  BMACA  REAL                           DEFAULT 0,
  BCDID  INTEGER,
  GUIDR  TEXT,
  BMADD  DATE                                   DEFAULT SYSDATE,
  BMADT  REAL                        DEFAULT 0,
  PKIDB  INTEGER                            DEFAULT 1,
  GUIDP  TEXT,              
  JTID_L INTEGER,
  BIID_L INTEGER,
  SYID_L INTEGER,
  CIID_L TEXT 
         )  
      ''');
        await db.execute('''
       CREATE TABLE MAT_FOL (
 BIID  INTEGER,
  MGNO  TEXT,
  MINO  TEXT,
  MUID   INTEGER,
  MFNO   REAL,
  MGNOF   TEXT,
  MINOF  TEXT ,
  MUIDF   INTEGER,
  MFNOF   REAL,
  MFDO  TEXT,
  MFIN  TEXT,
  MFST  INTEGER,
  MFID  INTEGER ,
  DATEI  DATE,
  SUID   TEXT,
  SUCH   TEXT,
  DATEU  DATE,
  DEVI   TEXT,
  DEVU   TEXT,
  GUID   TEXT,            
  JTID_L INTEGER,
  BIID_L INTEGER,
  SYID_L INTEGER,
  CIID_L TEXT 
         )  
      ''');
        await db.execute('''
       CREATE TABLE MAT_DES_M (
  MDMID  INTEGER,
  MDMNA  TEXT,
  MDMNE  TEXT,
  MDMN3  TEXT,
  MDMDE  TEXT,
  MGNOT  INTEGER                                 DEFAULT 1,
  MDMST  INTEGER                                 DEFAULT 1,
  ORDNU  INTEGER,
  RES    TEXT,
  SUID   TEXT,
  DATEI  DATE,
  DEVI   TEXT,
  SUCH   TEXT,
  DATEU  DATE,
  DEVU   TEXT,
  DEFN   INTEGER,
  GUID   TEXT,
  JTID_L INTEGER,
  BIID_L INTEGER,
  SYID_L INTEGER,
  CIID_L TEXT 
         )  
      ''');
        await db.execute('''
       CREATE TABLE MAT_DES_D (
   MDDID  INTEGER,
  MDMID  INTEGER,
  MGNO   TEXT,
  MINO   TEXT,
  MDDST  INTEGER                                 DEFAULT 1,
  ORDNU  INTEGER,
  RES    TEXT,
  SUID   TEXT,
  DATEI  DATE,
  DEVI   TEXT,
  SUCH   TEXT,
  DATEU  DATE,
  DEVU   TEXT,
  DEFN   INTEGER                                 DEFAULT 2,
  GUID   TEXT,
  JTID_L INTEGER,
  BIID_L INTEGER,
  SYID_L INTEGER,
  CIID_L TEXT 
         )  
      ''');
        await db.execute('''CREATE TABLE MAT_DES_M_TMP AS  SELECT  * FROM MAT_DES_M WHERE 1=2''');
        await db.execute('''CREATE TABLE MAT_DES_D_TMP AS  SELECT  * FROM MAT_DES_D WHERE 1=2''');
        await db.execute('''CREATE TABLE MAT_FOL_TMP AS  SELECT  * FROM MAT_FOL WHERE 1=2''');
        await db.execute('''CREATE TABLE RES_TAB_TMP AS  SELECT  * FROM RES_TAB WHERE 1=2''');
        await db.execute('''CREATE TABLE RES_SEC_TMP AS  SELECT  * FROM RES_SEC WHERE 1=2''');
        await db.execute('''CREATE TABLE RES_EMP_TMP AS  SELECT  * FROM RES_EMP WHERE 1=2''');
        await db.execute('''CREATE TABLE BIF_GRO_TMP AS  SELECT  * FROM BIF_GRO WHERE 1=2''');
        await db.execute('''CREATE TABLE BIF_GRO2_TMP AS  SELECT  * FROM BIF_GRO2 WHERE 1=2''');
        await db.execute('''CREATE TABLE BIF_MOV_A_TMP AS  SELECT  * FROM BIF_MOV_A WHERE 1=2''');

        await db.execute('''ALTER TABLE BIF_MOV_M ADD COLUMN  BMMGR  TEXT''');
        await db.execute('''ALTER TABLE BIF_CUS_D ADD COLUMN  SYST_L INTEGER  DEFAULT 1''');
        await db.execute('''ALTER TABLE BIF_CUS_D ADD COLUMN  BCDDL_L INTEGER  DEFAULT 1''');
        await db.execute('''ALTER TABLE BIF_CUS_D_TMP ADD COLUMN  SYST_L INTEGER  DEFAULT 1''');
        await db.execute('''ALTER TABLE BIF_CUS_D_TMP ADD COLUMN  BCDDL_L INTEGER  DEFAULT 1''');
        await db.execute('''ALTER TABLE ACC_ACC_TMP ADD COLUMN  SYST_L INTEGER  DEFAULT 1''');
        await db.execute('''ALTER TABLE ACC_USR_TMP ADD COLUMN  SYST_L INTEGER  DEFAULT 1''');

        await db.execute('''ALTER TABLE BIL_POI_TMP ADD COLUMN BPSEO INTEGER''');
        await db.execute('''ALTER TABLE BIL_POI_TMP ADD COLUMN BPIDT INTEGER''');
        await db.execute('''ALTER TABLE BIL_POI_TMP ADD COLUMN BPIDV TEXT''');
        await db.execute('''ALTER TABLE TAX_SYS_BRA_TMP ADD COLUMN  SUID TEXT  ''');
        await db.execute('''ALTER TABLE TAX_SYS_BRA_TMP ADD COLUMN  DATEI TEXT ''');
        await db.execute('''ALTER TABLE TAX_SYS_BRA_TMP ADD COLUMN  DEVI TEXT  ''');
        await db.execute('''ALTER TABLE TAX_SYS_BRA_TMP ADD COLUMN  SUCH TEXT  ''');
        await db.execute('''ALTER TABLE TAX_SYS_BRA_TMP ADD COLUMN  DATEU TEXT ''');
        await db.execute('''ALTER TABLE TAX_SYS_BRA_TMP ADD COLUMN  DEVU TEXT  ''');
        await db.execute('''ALTER TABLE BIF_MOV_M ADD COLUMN  BMMDE  TEXT  ''');
        await db.execute('''CREATE TABLE MAT_INF_D_TMP AS  SELECT  * FROM MAT_INF_D WHERE 1=2''');

        await db.execute('''
       CREATE TABLE MAT_DIS_T (
   MDTID  INTEGER,
  MDTNA  TEXT,
  MDTNE  TEXT,
  MDTN3  TEXT,
  MDTST  INTEGER                             DEFAULT 1,
  SUID   TEXT,
  DATEI  DATE,
  SUCH   TEXT,
  DATEU  DATE,
  GUID   TEXT,
    DEVI   TEXT,
  DEVU   TEXT,
  JTID_L INTEGER,
  BIID_L INTEGER,
  SYID_L INTEGER,
  CIID_L TEXT 
         )  
      ''');
        await db.execute('''
       CREATE TABLE MAT_DIS_K (
   MDKID  INTEGER,
  MDTID  INTEGER                             DEFAULT 0,
  MDKNA  TEXT,
  MDKNE  TEXT,
  MDKN3  TEXT,
  MDKST  INTEGER                             DEFAULT 1,
  SUID   TEXT,
  DATEI  DATE,
  SUCH   TEXT,
  DATEU  DATE,
  GUID   TEXT,
    DEVI   TEXT,
  DEVU   TEXT,
  JTID_L INTEGER,
  BIID_L INTEGER,
  SYID_L INTEGER,
  CIID_L TEXT 
         )  
      ''');
        await db.execute('''
       CREATE TABLE MAT_DIS_M (
    GUID     TEXT,
  MDMID    INTEGER,
  MDTID    INTEGER,
  MDKID    INTEGER,
  MDMRA    REAL                               DEFAULT 0,
  MDMSM    INTEGER                          DEFAULT 1,
  MDMCO    REAL                               DEFAULT 0,
  MDMAM    REAL                               DEFAULT 0,
  MDMMN    REAL                               DEFAULT 0,
  MDMCR    INTEGER                           DEFAULT 0,
  MDMCR2   INTEGER,
  MDMCR3   INTEGER,
  MDMOI    INTEGER                         DEFAULT 0,
  MDMFD    DATE,
  MDMTD    DATE,
  MDMFDA   INTEGER,
  MDMTDA   INTEGER,
  MDMFM    INTEGER,
  MDMTM    INTEGER,
  MDMFY    INTEGER,
  MDMTY    INTEGER,
  MDMFT    INTEGER,
  MDMTT    INTEGER,
  MDMDAYT  INTEGER                           DEFAULT 0,
  MDMDAY   TEXT,
  MDMST    INTEGER                         DEFAULT 1,
  MDMDE    TEXT,
  MDMRE    TEXT,
  SUID     TEXT,
  DATEI    DATE,
  SUCH     TEXT,
  DATEU    DATE,
    DEVI   TEXT,
  DEVU   TEXT,
  JTID_L INTEGER,
  BIID_L INTEGER,
  SYID_L INTEGER,
  CIID_L TEXT 
         )  
      ''');
        await db.execute('''
       CREATE TABLE MAT_DIS_D (
    GUID   TEXT,
  MDDID  INTEGER,
  MDMID  INTEGER,
  MGNO   TEXT,
  MINO   TEXT,
  MUID   INTEGER,
  MDDRA  REAL,
  MDDNU  REAL                                 DEFAULT 0,
  MDDAM  REAL                                 DEFAULT 0,
  MDDMN  REAL                                 DEFAULT 0,
  MDDSI  INTEGER                            DEFAULT 1,
  MDDST  INTEGER                                 DEFAULT 1,
  SUID   TEXT,
  DATEI  DATE,
  SUCH   TEXT,
  DATEU  DATE,
    DEVI   TEXT,
  DEVU   TEXT,
  JTID_L INTEGER,
  BIID_L INTEGER,
  SYID_L INTEGER,
  CIID_L TEXT 
         )  
      ''');
        await db.execute('''
       CREATE TABLE MAT_DIS_F (
    GUID   TEXT,
  MDFID  INTEGER,
  MDDID  INTEGER,
  MDMID  INTEGER,
  MGNO   TEXT,
  MINO   TEXT,
  MUID   INTEGER,
  MDFFN  INTEGER,
  MDFTN  INTEGER,
  SCID   INTEGER,
  MDFMP  INTEGER,
  MDFRA  INTEGER,
  MDFNU  INTEGER                                 DEFAULT 0,
  MDFAM  INTEGER                                 DEFAULT 0,
  MDFMN  INTEGER                                 DEFAULT 0,
  MDFST  INTEGER                             DEFAULT 1,
  SUID   TEXT,
  DATEI  DATE,
  SUCH   TEXT,
  DATEU  DATE,
    DEVI   TEXT,
  DEVU   TEXT,
  JTID_L INTEGER,
  BIID_L INTEGER,
  SYID_L INTEGER,
  CIID_L TEXT 
         )  
      ''');
        await db.execute('''
       CREATE TABLE MAT_DIS_L (
    GUID   TEXT,
   GUIDM  TEXT,
  GUIDD  TEXT,
  MMMID  INTEGER,
  MDMID  INTEGER,
  MDLST  INTEGER                             DEFAULT 1,
  SUID   TEXT,
  DATEI  DATE,
  SUCH   TEXT,
  DATEU  DATE,
    DEVI   TEXT,
  DEVU   TEXT,
  MCKID  INTEGER,
  JTID_L INTEGER,
  BIID_L INTEGER,
  SYID_L INTEGER,
  CIID_L TEXT 
         )  
      ''');
        await db.execute('''
       CREATE TABLE MAT_DIS_N (
    GUID    TEXT,
  MDNID   INTEGER,
  MMMID   INTEGER,
  MDMID   INTEGER,
  MDDID   INTEGER,
  MDFID   INTEGER,
  GUIDM   TEXT,
  MDNAM   INTEGER                                DEFAULT 0,
  MDNAM2  INTEGER                                DEFAULT 0,
  MDNNU   INTEGER                                DEFAULT 0,
  MDNNU2  INTEGER                                DEFAULT 0,
  MDNMN   INTEGER                                DEFAULT 0,
  MDNMN2  INTEGER                                DEFAULT 0,
  MDNN2   INTEGER                                DEFAULT 0,
  MDNN22  INTEGER                                DEFAULT 0,
  MDNN3   INTEGER                                DEFAULT 0,
  MDNN32  INTEGER                                DEFAULT 0,
  MDNC1   TEXT,
  MDNC2   TEXT,
  MDNST   INTEGER                            DEFAULT 1,
  SUID    TEXT,
  DATEI   DATE,
  SUCH    TEXT,
  DATEU   DATE,
    DEVI   TEXT,
  DEVU   TEXT,
  JTID_L INTEGER,
  BIID_L INTEGER,
  SYID_L INTEGER,
  CIID_L TEXT 
         )  
      ''');
        await db.execute('''
       CREATE TABLE MAT_DIS_S (
      GUID   TEXT,
  MDSST  INTEGER                                 DEFAULT 2,
  MDSRE  TEXT,
  SUID   TEXT,
  DATEI  DATE,
  SUCH   TEXT,
  DATEU  DATE,
    DEVI   TEXT,
  DEVU   TEXT,
  JTID_L INTEGER,
  BIID_L INTEGER,
  SYID_L INTEGER,
  CIID_L TEXT 
         )  
      ''');
        await db.execute('''
       CREATE TABLE SYN_TAS (
       CIID INTEGER,
       JTID INTEGER,
       BIID INTEGER,
       SYID INTEGER,
 GUID    TEXT, 
 STMID   TEXT,
 STKI    TEXT, 
 STTY    TEXT,
 STTB    TEXT,
 STDE    TEXT,
 STDE2   TEXT,
 STDE3   TEXT,
 STFU    TEXT,
 STTU    TEXT,
 STFID   INTEGER,
 STTID   INTEGER,
 STFD    DATE, 
 STTD    DATE,
 STIM    INTEGER DEFAULT 2, 
 STST    INTEGER DEFAULT 1, 
 SUID    TEXT, 
 DATEI   DATE, 
 DEVI    TEXT,
 SUCH    TEXT,
 DATEU   DATE, 
 DEVU    TEXT,
  JTID_L INTEGER,
  BIID_L INTEGER,
  SYID_L INTEGER,
  CIID_L TEXT 
         )  
      ''');
        await db.execute('''CREATE TABLE MAT_DIS_T_TMP AS SELECT  * FROM MAT_DIS_T WHERE 1=2''');
        await db.execute('''CREATE TABLE MAT_DIS_K_TMP AS SELECT  * FROM MAT_DIS_K WHERE 1=2''');
        await db.execute('''CREATE TABLE MAT_DIS_M_TMP AS SELECT  * FROM MAT_DIS_M WHERE 1=2''');
        await db.execute('''CREATE TABLE MAT_DIS_D_TMP AS SELECT  * FROM MAT_DIS_D WHERE 1=2''');
        await db.execute('''CREATE TABLE MAT_DIS_F_TMP AS SELECT  * FROM MAT_DIS_F WHERE 1=2''');
        await db.execute('''CREATE TABLE MAT_DIS_L_TMP AS SELECT  * FROM MAT_DIS_L WHERE 1=2''');
        await db.execute('''CREATE TABLE MAT_DIS_N_TMP AS SELECT  * FROM MAT_DIS_N WHERE 1=2''');
        await db.execute('''CREATE TABLE MAT_DIS_S_TMP AS SELECT  * FROM MAT_DIS_S WHERE 1=2''');
        await db.execute('''CREATE TABLE SYN_TAS_TMP AS SELECT  * FROM SYN_TAS WHERE 1=2''');

        await db.execute(''' CREATE  INDEX MAT_DIS_M_I1 ON MAT_DIS_M(MDMID,JTID_L,SYID_L,CIID_L)''');
        await db.execute(''' CREATE  INDEX MAT_DIS_D_I1 ON MAT_DIS_D(MDDID,JTID_L,SYID_L,CIID_L)''');

        await db.execute('''ALTER TABLE CONFIG ADD COLUMN  STMID TEXT  ''');
        await db.execute('''ALTER TABLE CONFIG ADD COLUMN  SYDV_NAME TEXT  ''');
        await db.execute('''ALTER TABLE CONFIG ADD COLUMN  SYDV_TY TEXT  ''');
        await db.execute('''ALTER TABLE CONFIG ADD COLUMN  SYDV_SER TEXT ''');
        await db.execute('''ALTER TABLE CONFIG ADD COLUMN  SYDV_ID TEXT ''');
        await db.execute('''ALTER TABLE CONFIG ADD COLUMN SYDV_NO TEXT ''');
        await db.execute('''ALTER TABLE CONFIG ADD COLUMN SYDV_IP TEXT ''');
        await db.execute('''ALTER TABLE CONFIG ADD COLUMN SYDV_APPV TEXT ''');

        await db.execute('''ALTER TABLE BIL_CUS ADD COLUMN BCLON TEXT''');
        await db.execute('''ALTER TABLE BIL_CUS ADD COLUMN BCLAT TEXT''');
        await db.execute('''ALTER TABLE BIL_CUS ADD COLUMN BILON TEXT''');
        await db.execute('''ALTER TABLE BIL_CUS_TMP ADD COLUMN BCLON TEXT''');
        await db.execute('''ALTER TABLE BIL_CUS_TMP ADD COLUMN BILON TEXT''');
        await db.execute('''ALTER TABLE BIL_CUS_TMP ADD COLUMN BCLAT TEXT''');

        await db.execute('''ALTER TABLE BIL_IMP ADD COLUMN BILON TEXT''');
        await db.execute('''ALTER TABLE BIL_IMP ADD COLUMN BILAT TEXT''');
        await db.execute('''ALTER TABLE BIL_IMP ADD COLUMN BICR INTEGER''');
        await db.execute('''ALTER TABLE BIL_IMP_TMP ADD COLUMN BICR INTEGER''');
        await db.execute('''ALTER TABLE BIL_IMP_TMP ADD COLUMN BILON TEXT''');
        await db.execute('''ALTER TABLE BIL_IMP_TMP ADD COLUMN BILAT TEXT''');

        await db.execute('''ALTER TABLE BIF_CUS_D ADD COLUMN BCDLON TEXT''');
        await db.execute('''ALTER TABLE BIF_CUS_D ADD COLUMN BCDLAT TEXT''');
        await db.execute('''ALTER TABLE BIF_CUS_D_TMP ADD COLUMN BCDLON TEXT''');
        await db.execute('''ALTER TABLE BIF_CUS_D_TMP ADD COLUMN BCDLAT TEXT''');

        await db.execute('''ALTER TABLE BIL_MOV_M ADD COLUMN BMMLON TEXT''');
        await db.execute('''ALTER TABLE BIL_MOV_M ADD COLUMN BMMLAT TEXT''');
        await db.execute('''ALTER TABLE BIF_MOV_M ADD COLUMN BMMLON TEXT''');
        await db.execute('''ALTER TABLE BIF_MOV_M ADD COLUMN BMMLAT TEXT''');

        await db.execute('''ALTER TABLE PAY_KIN ADD COLUMN  PKTY INTEGER''');
        await db.execute('''ALTER TABLE PAY_KIN_TMP ADD COLUMN  PKTY INTEGER''');
        await db.execute('''UPDATE PAY_KIN SET PKTY=1 WHERE PKID IN(1,2,5,8,9)''');
        await db.execute('''UPDATE PAY_KIN SET PKTY=2 WHERE PKID IN(3,4,10,11)''');
        await db.execute('''UPDATE PAY_KIN SET PKTY=3 WHERE PKID NOT IN(1,2,5,8,9,3,4,10,11)''');

        //2023-11-22
        await db.execute('''
       CREATE TABLE MAT_MAI_M (
       GUID    TEXT,
  MMMID   INTEGER,
  MMMDE   TEXT,
  BIIDT   INTEGER                                DEFAULT 0,
  BIID    TEXT,
  MMMBLT  INTEGER                                DEFAULT 0,
  MMMBL   TEXT,
  PKIDT   INTEGER                                DEFAULT 0,
  PKID    TEXT,
  BCCIDT  INTEGER                                DEFAULT 0,
  BCCID   TEXT,
  SCIDT   INTEGER                                DEFAULT 0,
  SCID    TEXT,
  BCTIDT  INTEGER                                DEFAULT 0,
  BCTID   TEXT,
  BCIDT   INTEGER                                DEFAULT 0,
  BCDIDT  INTEGER                                DEFAULT 0,
  CIIDT   INTEGER                                DEFAULT 0,
  ECIDT   INTEGER                                DEFAULT 0,
  SIIDT   INTEGER                                DEFAULT 0,
  SIID    TEXT,
  ACNOT   INTEGER                                DEFAULT 0,
  ACNO    TEXT,
  SUIDT   INTEGER                                DEFAULT 0,
  SUIDV   TEXT,
  MMMFD   DATE,
  MMMTD   DATE,
  MMMFT   INTEGER,
  MMMTT   INTEGER,
  MMMDAY  TEXT,
  ORDNU   INTEGER,
  SUID    TEXT,
  DATEI   DATE,
  SUCH    TEXT,
  DATEU   DATE,
  MMMST   INTEGER                                DEFAULT 1,
  DEVI    TEXT,
  DEVU    TEXT,
  JTID_L INTEGER,
  BIID_L INTEGER,
  SYID_L INTEGER,
  CIID_L TEXT 
         )  
      ''');
        await db.execute('''CREATE TABLE MAT_MAI_M_TMP AS SELECT  * FROM MAT_MAI_M WHERE 1=2''');
        await db.execute('''
       CREATE TABLE BIL_MOV_DD (
       BMDSQ   INTEGER,
  BMKID   INTEGER,
  BMMID   INTEGER,
  BMDID   INTEGER,
  GUID    TEXT,
  MMMID   INTEGER,
  MDMID   INTEGER,
  MDDID   INTEGER,
  MDFID   INTEGER,
  GUIDM   TEXT,
  MDTID   INTEGER                                DEFAULT 2,
  MGNO    TEXT,
  MINO    TEXT,
  MUID    INTEGER,
  BMDAM   REAL                                DEFAULT 0,
  BMDNO   REAL                                DEFAULT 0,
  BMDRE   REAL                                DEFAULT 0,
  BMDN1   INTEGER                                DEFAULT 0,
  BMDN2   INTEGER                                DEFAULT 0,
  BMDC1   TEXT,
  BMDC2   TEXT,
  BMDC3   TEXT,
  BMDST   INTEGER                                DEFAULT 1,
  BMDSQR  INTEGER,
  MCKID   INTEGER                                DEFAULT 1,
  MCDID   INTEGER,
  JTID_L INTEGER,
  BIID_L INTEGER,
  SYID_L INTEGER,
  CIID_L TEXT 
         )  
      ''');
        await db.execute('''
       CREATE TABLE BIL_MOV_MD (
      BMMSQ   INTEGER,
  BMKID   INTEGER,
  BMMID   INTEGER,
  GUID    TEXT,
  MMMID   INTEGER,
  MDMID   INTEGER,
  MDDID   INTEGER,
  MDFID   INTEGER,
  GUIDM   TEXT,
  BMMAM   REAL                                DEFAULT 0,
  BMMNO   REAL                                DEFAULT 0,
  BMMRE   REAL                                DEFAULT 0,
  BMMN1   INTEGER                                DEFAULT 0,
  BMMN2   INTEGER                                DEFAULT 0,
  BMMN3   INTEGER                                DEFAULT 0,
  BMMC1   TEXT,
  BMMC2   TEXT,
  BMMC3   TEXT,
  BMMC4   TEXT,
  BMMC5   TEXT,
  BMMST   INTEGER                                DEFAULT 1,
  BMMSQR  INTEGER,
  MCKID   INTEGER                                DEFAULT 1,
  MCDID   INTEGER,
  JTID_L INTEGER,
  BIID_L INTEGER,
  SYID_L INTEGER,
  CIID_L TEXT 
         )  
      ''');
        await db.execute('''
       CREATE TABLE BIF_MOV_DD (
       BMDSQ   INTEGER,
  BMKID   INTEGER,
  BMMID   INTEGER,
  BMDID   INTEGER,
  GUID    TEXT,
  MMMID   INTEGER,
  MDMID   INTEGER,
  MDDID   INTEGER,
  MDFID   INTEGER,
  GUIDM   TEXT,
  MDTID   INTEGER                                DEFAULT 2,
  MGNO    TEXT,
  MINO    TEXT,
  MUID    INTEGER,
  BMDAM   REAL                                DEFAULT 0,
  BMDNO   REAL                                DEFAULT 0,
  BMDRE   REAL                                DEFAULT 0,
  BMDN1   INTEGER                                DEFAULT 0,
  BMDN2   INTEGER                                DEFAULT 0,
  BMDC1   TEXT,
  BMDC2   TEXT,
  BMDC3   TEXT,
  BMDST   INTEGER                                DEFAULT 1,
  BMDSQR  INTEGER,
  MCKID   INTEGER                                DEFAULT 1,
  MCDID   INTEGER,
  JTID_L INTEGER,
  BIID_L INTEGER,
  SYID_L INTEGER,
  CIID_L TEXT 
         )  
      ''');
        await db.execute('''
       CREATE TABLE BIF_MOV_MD (
      BMMSQ   INTEGER,
  BMKID   INTEGER,
  BMMID   INTEGER,
  GUID    TEXT,
  MMMID   INTEGER,
  MDMID   INTEGER,
  MDDID   INTEGER,
  MDFID   INTEGER,
  GUIDM   TEXT,
  BMMAM   REAL                                DEFAULT 0,
  BMMNO   REAL                                DEFAULT 0,
  BMMRE   REAL                                DEFAULT 0,
  BMMN1   INTEGER                                DEFAULT 0,
  BMMN2   INTEGER                                DEFAULT 0,
  BMMN3   INTEGER                                DEFAULT 0,
  BMMC1   TEXT,
  BMMC2   TEXT,
  BMMC3   TEXT,
  BMMC4   TEXT,
  BMMC5   TEXT,
  BMMST   INTEGER                                DEFAULT 1,
  BMMSQR  INTEGER,
  MCKID   INTEGER                                DEFAULT 1,
  MCDID   INTEGER,
  JTID_L INTEGER,
  BIID_L INTEGER,
  SYID_L INTEGER,
  CIID_L TEXT 
         )  
      ''');

        //2023-11-24
        await db.execute('''INSERT INTO SYN_ORD(SOET,ROW_NUM,SOOR,SOST,JTID_L,BIID_L,SYID_L,CIID_L) values('MAT_DIS_T',0,309,1, ${LoginController().JTID},${LoginController().BIID},${LoginController().SYID},'${LoginController().CIID}')''');
        await db.execute('''INSERT INTO SYN_ORD(SOET,ROW_NUM,SOOR,SOST,JTID_L,BIID_L,SYID_L,CIID_L) values('MAT_DIS_K',0,310,1, ${LoginController().JTID},${LoginController().BIID},${LoginController().SYID},'${LoginController().CIID}')''');
        await db.execute('''INSERT INTO SYN_ORD(SOET,ROW_NUM,SOOR,SOST,JTID_L,BIID_L,SYID_L,CIID_L) values('MAT_DIS_M',0,311,1, ${LoginController().JTID},${LoginController().BIID},${LoginController().SYID},'${LoginController().CIID}')''');
        await db.execute('''INSERT INTO SYN_ORD(SOET,ROW_NUM,SOOR,SOST,JTID_L,BIID_L,SYID_L,CIID_L) values('MAT_DIS_D',0,312,1, ${LoginController().JTID},${LoginController().BIID},${LoginController().SYID},'${LoginController().CIID}')''');
        await db.execute('''INSERT INTO SYN_ORD(SOET,ROW_NUM,SOOR,SOST,JTID_L,BIID_L,SYID_L,CIID_L) values('MAT_DIS_F',0,313,1, ${LoginController().JTID},${LoginController().BIID},${LoginController().SYID},'${LoginController().CIID}')''');
        await db.execute('''INSERT INTO SYN_ORD(SOET,ROW_NUM,SOOR,SOST,JTID_L,BIID_L,SYID_L,CIID_L) values('MAT_DIS_L',0,314,1, ${LoginController().JTID},${LoginController().BIID},${LoginController().SYID},'${LoginController().CIID}')''');
        await db.execute('''INSERT INTO SYN_ORD(SOET,ROW_NUM,SOOR,SOST,JTID_L,BIID_L,SYID_L,CIID_L) values('MAT_DIS_N',0,315,1, ${LoginController().JTID},${LoginController().BIID},${LoginController().SYID},'${LoginController().CIID}')''');
        await db.execute('''INSERT INTO SYN_ORD(SOET,ROW_NUM,SOOR,SOST,JTID_L,BIID_L,SYID_L,CIID_L) values('MAT_MAI_M',0,316,1, ${LoginController().JTID},${LoginController().BIID},${LoginController().SYID},'${LoginController().CIID}')''');

        //2023-11-25
        await db.execute('''UPDATE BIL_MOV_M SET BMMST2=1 WHERE BMMST=1''');
        await db.execute('''UPDATE BIF_MOV_M SET BMMST2=1 WHERE BMMST=1''');
        await OnUpgradeV446(db);
        await OnUpgradeV446_9(db);
        await OnUpgradeV448_10(db);
        await OnUpgradeV449_11(db);
        await OnUpgradeV449_12(db);
        await OnUpgradeV449_13(db);
        await OnUpgradeV449_14(db);
        await OnUpgradeV449_15(db);
        await OnUpgradeV449_16(db);
        await OnUpgradeV449_17(db);

        print(oldversion);
        print(newversion);
        print("oldversion");
      }

      else  if (oldversion == 2) {
        await db.execute('''
       CREATE TABLE ACC_CAS_U (
   ACID   INTEGER,
  ACUTY  INTEGER                             DEFAULT 1,
  SUID   TEXT,
  ACCT   INTEGER                             DEFAULT 1,
  SCID   INTEGER,
  ACTMS  INTEGER                             DEFAULT 1,
  ACTMP  INTEGER                             DEFAULT 0,
  ACUST  INTEGER                             DEFAULT 1,
  ACUAM  REAL,
  SUCH   TEXT,
  GUID   TEXT,
  DATEI  DATE,
  DATEU  DATE,
  DEVI   TEXT,
  DEVU   TEXT,
  SUID2  TEXT,
  JTID_L INTEGER,
  BIID_L INTEGER,
  SYID_L INTEGER,
  CIID_L TEXT 
         )  
      ''');
        await db.execute(''' CREATE TABLE ACC_CAS_U_TMP AS SELECT  * FROM ACC_CAS_U WHERE 1=2''');
        await db.execute(''' CREATE  INDEX ACC_CAS_U_I1 ON ACC_CAS_U(ACID,JTID_L,BIID_L,SYID_L,CIID_L)''');
        await db.execute(''' CREATE  INDEX ACC_CAS_U_I2 ON ACC_CAS_U(ACID,JTID_L,SYID_L,CIID_L)''');
        await db.execute('''ALTER TABLE BIF_MOV_M ADD COLUMN BMMST2 INTEGER DEFAULT 2''');
        await db.execute('''ALTER TABLE BIL_MOV_M ADD COLUMN BMMST2 INTEGER DEFAULT 2''');
        await db.execute(''' ALTER TABLE BIL_MOV_M ADD COLUMN SCIDP INTEGER''');
        await db.execute(''' ALTER TABLE BIL_MOV_M ADD COLUMN SCEXP REAL''');
        await db.execute(''' ALTER TABLE BIL_MOV_M ADD COLUMN BMMAMP REAL''');
        await db.execute(''' ALTER TABLE BIL_MOV_M ADD COLUMN SCIDP2 INTEGER''');
        await db.execute(''' ALTER TABLE BIL_MOV_M ADD COLUMN SCEXP2 REAL''');
        await db.execute(''' ALTER TABLE BIL_MOV_M ADD COLUMN BMMAMP2 REAL''');
        await db.execute(''' ALTER TABLE BIL_MOV_M ADD COLUMN BMMCP REAL''');
        await db.execute(''' ALTER TABLE BIL_MOV_M ADD COLUMN BMMTC REAL''');
        await db.execute(''' ALTER TABLE ACC_MOV_D ADD COLUMN AMDSS INTEGER''');
        await db.execute(''' ALTER TABLE ACC_MOV_D ADD COLUMN AMDMS TEXT''');
        await db.execute(''' ALTER TABLE BIL_MOV_M ADD COLUMN AMMID INTEGER''');
        await db.execute(''' ALTER TABLE BIF_MOV_M ADD COLUMN AMMID INTEGER''');
        await db.execute('''ALTER TABLE BIL_POI ADD COLUMN BPSEO INTEGER''');
        await db.execute('''ALTER TABLE BIL_POI ADD COLUMN BPIDT INTEGER''');
        await db.execute('''ALTER TABLE BIL_POI ADD COLUMN BPIDV TEXT''');
        await db.execute('''ALTER TABLE TAX_SYS_BRA ADD COLUMN  SUID TEXT  ''');
        await db.execute('''ALTER TABLE TAX_SYS_BRA ADD COLUMN  DATEI TEXT ''');
        await db.execute('''ALTER TABLE TAX_SYS_BRA ADD COLUMN  DEVI TEXT  ''');
        await db.execute('''ALTER TABLE TAX_SYS_BRA ADD COLUMN  SUCH TEXT  ''');
        await db.execute('''ALTER TABLE TAX_SYS_BRA ADD COLUMN  DATEU TEXT ''');
        await db.execute('''ALTER TABLE TAX_SYS_BRA ADD COLUMN  DEVU TEXT  ''');


        await db.execute(''' DROP TABLE SYN_LOG ''');
        await db.execute('''
         CREATE TABLE SYN_LOG (   
         SLSQ            INTEGER PRIMARY KEY,
       SLDO            DATE ,
       SLIN            TEXT,
       SLTY            TEXT,
    SUID            TEXT,
    STMSQ           INTEGER,
    SMID            INTEGER,
    STMID           TEXT,
    GUID            TEXT,
    SOTT            TEXT,
    SOTY            TEXT,
    SLC1            TEXT,
    CIID            INTEGER,
    JTID            INTEGER,
    BIID            INTEGER,
    SYID            INTEGER,
    SOMID           INTEGER,
    SYDV_NAME       TEXT,
    SYDV_IP         TEXT,
    SYDV_SER        TEXT,
    SYDV_POI        TEXT,
    SYDV_NO         TEXT,
    SYDV_LATITUDE   TEXT,
    SYDV_LONGITUDE  TEXT,
    SYDV_APPV       TEXT,
    SYDV_APIV       TEXT,
    SYDV_TY         TEXT,
    SDSQ            INTEGER,
    SLTY2           INTEGER,
    SLIT2           TEXT,
    SLSC2           TEXT,
    SLTYP           TEXT,
    SLC2            TEXT,
    SLC3            TEXT,
    SYDV_ID         TEXT,
    SYDV_GU         TEXT,
    SOGU            TEXT,
         JTID_L INTEGER,
         BIID_L INTEGER,
         SYID_L INTEGER,
         CIID_L TEXT
         )  
      ''');
        await db.execute('''
       CREATE TABLE TAX_LOC (
   TLID   INTEGER,
  GUID  TEXT ,
  TLSY   TEXT,
  TLNA   TEXT ,
  TLNE   TEXT,
  TLN3  TEXT,
  TTID  INTEGER                             DEFAULT 0,
  CWID  INTEGER                             DEFAULT 1,
  CTID  INTEGER,
  TLST   INTEGER,
  TLDE   TEXT,
  AANOO  TEXT,
  AANOI  TEXT,
  AANOR   TEXT,
  AANORR   TEXT,
  TLDC  INTEGER,
  ORDNU  INTEGER,
  RES  TEXT,
  SUID  TEXT,
  DATEI  TEXT,
  DEVI  TEXT,
  SUCH  TEXT,
  DATEU  TEXT,
  DEVU  TEXT,
  DEFN INTEGER,
  JTID_L INTEGER,
  BIID_L INTEGER,
  SYID_L INTEGER,
  CIID_L TEXT 
         )  
      ''');
        await db.execute('''
       CREATE TABLE TAX_LOC_SYS (
   TLSID   INTEGER,
  TLID    INTEGER,
  STID    TEXT,
  GUID    TEXT,
  AANOO   TEXT,
  AANOI   TEXT,
  AANOR   TEXT,
  AANORR  TEXT,
  TLSDC   INTEGER,
  ORDNU   INTEGER,
  RES     TEXT,
  SUID    TEXT,
  DATEI   TEXT ,
  DEVI    TEXT,
  SUCH    TEXT,
  DATEU   TEXT,
  DEVU    TEXT,
  DEFN    INTEGER ,
  JTID_L INTEGER,
  BIID_L INTEGER,
  SYID_L INTEGER,
  CIID_L TEXT 
         )  
      ''');
        await db.execute('''
       CREATE TABLE TAX_MOV_SIN (
  TMSID   INTEGER,
  GUID    TEXT,
  TMSNA   TEXT,
  TMSNE   TEXT,
  TMSN3   TEXT,
  TMSSY   TEXT,
  TMSST   INTEGER                                DEFAULT 1,
  TMSDE   TEXT,
  TMSDE2  TEXT,
  TTID    INTEGER,
  TCID    INTEGER,
  TCSID   INTEGER,
  TCSSY   TEXT,
  TCSDSY  TEXT,
  TMSIT   INTEGER                                DEFAULT 1,
  TMSAC   INTEGER                                DEFAULT 2,
  TMSCO   TEXT,
  TMSDL   INTEGER                                DEFAULT 1,
  TMSUP   INTEGER                                DEFAULT 1,
  ORDNU   INTEGER,
  RES     TEXT,
  SUID    TEXT,
  DATEI   TEXT,
  DEVI    TEXT,
  SUCH    TEXT,
  DATEU   TEXT,
  DEVU    TEXT,
  DEFN    INTEGER ,
  JTID_L INTEGER,
  BIID_L INTEGER,
  SYID_L INTEGER,
  CIID_L TEXT 
         )  
      ''');
        await db.execute('''
       CREATE TABLE TAX_VAR (
 TVID   INTEGER,
  TVSY   TEXT,
  TVNA   TEXT,
  TVNE   TEXT,
  TVN3   TEXT,
  TVVL   TEXT,
  TVDT   TEXT,
  TVDS   TEXT,
  TVDH   INTEGER,
  TVDA   INTEGER,
  TVAD   INTEGER ,
  STID   TEXT,
  STMID  TEXT,
  PRID   TEXT,
  PRIDY  TEXT,
  PRIDN  TEXT,
  TVDAC  INTEGER,
  TVCH   INTEGER,
  TVDL   INTEGER,
  TVIDF  INTEGER,
  TVST   INTEGER,
  ORDNU  INTEGER,
  RES   TEXT,
  SUID   TEXT,
  DATEI  TEXT,
  DEVI   TEXT,
  SUCH   TEXT,
  DATEU  TEXT,
  DEVU   TEXT,
  DEFN   INTEGER,
  GUID   TEXT,
  JTID_L INTEGER,
  BIID_L INTEGER,
  SYID_L INTEGER,
  CIID_L TEXT 
         )  
      ''');
        await db.execute('''
       CREATE TABLE TAX_VAR_D (
  TVDID   INTEGER,
  TVID    INTEGER,
  TTID    INTEGER,
  TVDSY   TEXT,
  TVDTY   INTEGER,
  TVDVL   TEXT,
  TVDDA   DATE,
  STID    TEXT,
  STMID   TEXT,
  PRID    TEXT,
  PRIDY   TEXT,
  PRIDN   TEXT,
  TVDCH   INTEGER,
  TVDIDF  INTEGER,
  TVDST   INTEGER,
  ORDNU   INTEGER,
  RES     TEXT,
  SUID    TEXT,
  DATEI   TEXT,
  DEVI    TEXT,
  SUCH    TEXT,
  DATEU   TEXT,
  DEVU    TEXT,
  DEFN    INTEGER ,
  GUID   TEXT,
  JTID_L INTEGER,
  BIID_L INTEGER,
  SYID_L INTEGER,
  CIID_L TEXT 
         )  
      ''');
        await db.execute('''
       CREATE TABLE TAX_TBL_LNK (
TTLID     INTEGER,
  GUID     TEXT,
  TTID      INTEGER,
  TTLNA     TEXT,
  TTLNE     TEXT,
  TTLN3     TEXT,
  STID     TEXT,
  TTLTB     TEXT,
  TTLNO    TEXT,
  TTLNO2   TEXT,
  TTLSY     TEXT,
  TTLNOL   TEXT,
  TTLNO2L  TEXT,
  TTLSY2    TEXT,
  TTLNOL2  TEXT,
  TTLNO2L2 TEXT,
  TTLST     INTEGER,
  TTLCO    TEXT,
  TTLLN     INTEGER,
  TTLHN     INTEGER,
  TTLDE     TEXT,
  TTLVB     INTEGER,
  TTLVN     INTEGER,
  TTLVF     INTEGER,
  TTLSN     TEXT,
  TTLUP     INTEGER,
  TTLDL     INTEGER,
  TTLN1     INTEGER,
  TTLN2     INTEGER,
  TTLC1     TEXT,
  TTLC2     TEXT,
  ORDNU     INTEGER,
  RES       TEXT,
  SUID      TEXT,
  DATEI     TEXT,
  DEVI      TEXT,
  SUCH      TEXT,
  DATEU     TEXT,
  DEVU      TEXT,
  DEFN      INTEGER,               
  JTID_L INTEGER,
  BIID_L INTEGER,
  SYID_L INTEGER,
  CIID_L TEXT 
         )  
      ''');

        await db.execute('''CREATE TABLE TAX_TBL_LNK_TMP AS  SELECT  * FROM TAX_TBL_LNK WHERE 1=2''');
        await db.execute('''CREATE TABLE TAX_VAR_D_TMP AS  SELECT  * FROM TAX_VAR_D WHERE 1=2''');
        await db.execute('''CREATE TABLE TAX_VAR_TMP AS  SELECT  * FROM TAX_VAR WHERE 1=2''');
        await db.execute('''CREATE TABLE TAX_MOV_SIN_TMP AS  SELECT  * FROM TAX_MOV_SIN WHERE 1=2''');
        await db.execute('''CREATE TABLE TAX_LOC_SYS_TMP AS  SELECT  * FROM TAX_LOC_SYS WHERE 1=2''');
        await db.execute('''CREATE TABLE TAX_LOC_TMP AS  SELECT  * FROM TAX_LOC WHERE 1=2''');

        await db.execute('''ALTER TABLE BIL_MOV_M ADD COLUMN BMMTX11  REAL''');
        await db.execute('''ALTER TABLE BIL_MOV_M ADD COLUMN BMMTX22  REAL''');
        await db.execute('''ALTER TABLE BIL_MOV_M ADD COLUMN BMMTX33 REAL''');
        await db.execute('''ALTER TABLE BIF_MOV_M ADD COLUMN BMMTX11  REAL''');
        await db.execute('''ALTER TABLE BIF_MOV_M ADD COLUMN BMMTX22  REAL''');
        await db.execute('''ALTER TABLE BIF_MOV_M ADD COLUMN BMMTX33 REAL''');



        await db.execute('''ALTER TABLE BIL_MOV_D ADD COLUMN BMDTX11 REAL''');
        await db.execute('''ALTER TABLE BIL_MOV_D ADD COLUMN BMDTX22 REAL''');
        await db.execute('''ALTER TABLE BIL_MOV_D ADD COLUMN BMDTX33 REAL''');
        await db.execute('''ALTER TABLE BIL_MOV_D ADD COLUMN BMDTXA11 REAL''');
        await db.execute('''ALTER TABLE BIL_MOV_D ADD COLUMN BMDTXA22  REAL''');
        await db.execute('''ALTER TABLE BIL_MOV_D ADD COLUMN BMDTXA33  REAL''');
        await db.execute('''ALTER TABLE BIF_MOV_D ADD COLUMN BMDTX11  REAL''');
        await db.execute('''ALTER TABLE BIF_MOV_D ADD COLUMN BMDTX22 REAL''');
        await db.execute('''ALTER TABLE BIF_MOV_D ADD COLUMN BMDTX33 REAL''');
        await db.execute('''ALTER TABLE BIF_MOV_D ADD COLUMN BMDTXA11 REAL''');
        await db.execute('''ALTER TABLE BIF_MOV_D ADD COLUMN BMDTXA22 REAL''');
        await db.execute('''ALTER TABLE BIF_MOV_D ADD COLUMN BMDTXA33 REAL''');


        await db.execute('''ALTER TABLE BIL_MOV_D ADD COLUMN BMDTXT1 REAL''');
        await db.execute('''ALTER TABLE BIL_MOV_D ADD COLUMN BMDTXT2 REAL''');
        await db.execute('''ALTER TABLE BIL_MOV_D ADD COLUMN BMDTXT3 REAL''');
        await db.execute('''ALTER TABLE BIF_MOV_D ADD COLUMN BMDTXT1 REAL''');
        await db.execute('''ALTER TABLE BIF_MOV_D ADD COLUMN BMDTXT2 REAL''');
        await db.execute('''ALTER TABLE BIF_MOV_D ADD COLUMN BMDTXT3 REAL''');
        await db.execute('''ALTER TABLE ACC_ACC ADD COLUMN  SYST_L INTEGER  DEFAULT 1''');
        await db.execute('''ALTER TABLE ACC_USR ADD COLUMN  SYST_L INTEGER  DEFAULT 1''');


        await db.execute('''INSERT INTO SYN_ORD(SOET,ROW_NUM,SOOR,SOST,JTID_L,BIID_L,SYID_L,CIID_L) values('TAX_TYP_SYS',0,83,1, ${LoginController().JTID},${LoginController().BIID},${LoginController().SYID},'${LoginController().CIID}')''');
        await db.execute('''INSERT INTO SYN_ORD(SOET,ROW_NUM,SOOR,SOST,JTID_L,BIID_L,SYID_L,CIID_L) values('TAX_TYP',0,84,1, ${LoginController().JTID},${LoginController().BIID},${LoginController().SYID},'${LoginController().CIID}')''');
        await db.execute('''INSERT INTO SYN_ORD(SOET,ROW_NUM,SOOR,SOST,JTID_L,BIID_L,SYID_L,CIID_L) values('TAX_TYP_BRA',0,85,1, ${LoginController().JTID},${LoginController().BIID},${LoginController().SYID},'${LoginController().CIID}')''');
        await db.execute('''INSERT INTO SYN_ORD(SOET,ROW_NUM,SOOR,SOST,JTID_L,BIID_L,SYID_L,CIID_L) values('TAX_LOC_SYS',0,89,1, ${LoginController().JTID},${LoginController().BIID},${LoginController().SYID},'${LoginController().CIID}')''');
        await db.execute('''INSERT INTO SYN_ORD(SOET,ROW_NUM,SOOR,SOST,JTID_L,BIID_L,SYID_L,CIID_L) values('TAX_LOC',0,90,1, ${LoginController().JTID},${LoginController().BIID},${LoginController().SYID},'${LoginController().CIID}')''');
        await db.execute('''INSERT INTO SYN_ORD(SOET,ROW_NUM,SOOR,SOST,JTID_L,BIID_L,SYID_L,CIID_L) values('TAX_COD_SYS',0,91,1, ${LoginController().JTID},${LoginController().BIID},${LoginController().SYID},'${LoginController().CIID}')''');
        await db.execute('''INSERT INTO SYN_ORD(SOET,ROW_NUM,SOOR,SOST,JTID_L,BIID_L,SYID_L,CIID_L) values('TAX_COD',0,92,1, ${LoginController().JTID},${LoginController().BIID},${LoginController().SYID},'${LoginController().CIID}')''');
        await db.execute('''INSERT INTO SYN_ORD(SOET,ROW_NUM,SOOR,SOST,JTID_L,BIID_L,SYID_L,CIID_L) values('TAX_COD_SYS_D',0,93,1, ${LoginController().JTID},${LoginController().BIID},${LoginController().SYID},'${LoginController().CIID}')''');
        await db.execute('''INSERT INTO SYN_ORD(SOET,ROW_NUM,SOOR,SOST,JTID_L,BIID_L,SYID_L,CIID_L) values('TAX_SYS',0,94,1, ${LoginController().JTID},${LoginController().BIID},${LoginController().SYID},'${LoginController().CIID}')''');
        await db.execute('''INSERT INTO SYN_ORD(SOET,ROW_NUM,SOOR,SOST,JTID_L,BIID_L,SYID_L,CIID_L) values('TAX_SYS_BRA',0,95,1, ${LoginController().JTID},${LoginController().BIID},${LoginController().SYID},'${LoginController().CIID}')''');
        await db.execute('''INSERT INTO SYN_ORD(SOET,ROW_NUM,SOOR,SOST,JTID_L,BIID_L,SYID_L,CIID_L) values('TAX_SYS_D',0,96,1, ${LoginController().JTID},${LoginController().BIID},${LoginController().SYID},'${LoginController().CIID}')''');
        await db.execute('''INSERT INTO SYN_ORD(SOET,ROW_NUM,SOOR,SOST,JTID_L,BIID_L,SYID_L,CIID_L) values('TAX_VAR',0,97,1, ${LoginController().JTID},${LoginController().BIID},${LoginController().SYID},'${LoginController().CIID}')''');
        await db.execute('''INSERT INTO SYN_ORD(SOET,ROW_NUM,SOOR,SOST,JTID_L,BIID_L,SYID_L,CIID_L) values('TAX_VAR_D',0,98,1, ${LoginController().JTID},${LoginController().BIID},${LoginController().SYID},'${LoginController().CIID}')''');
        await db.execute('''INSERT INTO SYN_ORD(SOET,ROW_NUM,SOOR,SOST,JTID_L,BIID_L,SYID_L,CIID_L) values('TAX_LIN',0,99,1, ${LoginController().JTID},${LoginController().BIID},${LoginController().SYID},'${LoginController().CIID}')''');
        await db.execute('''INSERT INTO SYN_ORD(SOET,ROW_NUM,SOOR,SOST,JTID_L,BIID_L,SYID_L,CIID_L) values('IDE_TYP',0,100,1, ${LoginController().JTID},${LoginController().BIID},${LoginController().SYID},'${LoginController().CIID}')''');
        await db.execute('''INSERT INTO SYN_ORD(SOET,ROW_NUM,SOOR,SOST,JTID_L,BIID_L,SYID_L,CIID_L) values('IDE_LIN',0,101,1, ${LoginController().JTID},${LoginController().BIID},${LoginController().SYID},'${LoginController().CIID}')''');
        await db.execute('''INSERT INTO SYN_ORD(SOET,ROW_NUM,SOOR,SOST,JTID_L,BIID_L,SYID_L,CIID_L) values('TAX_MOV_SIN',0,102,1, ${LoginController().JTID},${LoginController().BIID},${LoginController().SYID},'${LoginController().CIID}')''');
        await db.execute('''INSERT INTO SYN_ORD(SOET,ROW_NUM,SOOR,SOST,JTID_L,BIID_L,SYID_L,CIID_L) values('TAX_TBL_LNK',0,103,1, ${LoginController().JTID},${LoginController().BIID},${LoginController().SYID},'${LoginController().CIID}')''');
        await db.execute('''INSERT INTO SYN_ORD(SOET,ROW_NUM,SOOR,SOST,JTID_L,BIID_L,SYID_L,CIID_L) values('RES_SEC',0,301,1, ${LoginController().JTID},${LoginController().BIID},${LoginController().SYID},'${LoginController().CIID}')''');
        await db.execute('''INSERT INTO SYN_ORD(SOET,ROW_NUM,SOOR,SOST,JTID_L,BIID_L,SYID_L,CIID_L) values('RES_TAB',0,302,1, ${LoginController().JTID},${LoginController().BIID},${LoginController().SYID},'${LoginController().CIID}')''');
        await db.execute('''INSERT INTO SYN_ORD(SOET,ROW_NUM,SOOR,SOST,JTID_L,BIID_L,SYID_L,CIID_L) values('RES_EMP',0,303,1, ${LoginController().JTID},${LoginController().BIID},${LoginController().SYID},'${LoginController().CIID}')''');
        await db.execute('''INSERT INTO SYN_ORD(SOET,ROW_NUM,SOOR,SOST,JTID_L,BIID_L,SYID_L,CIID_L) values('BIF_GRO',0,304,1, ${LoginController().JTID},${LoginController().BIID},${LoginController().SYID},'${LoginController().CIID}')''');
        await db.execute('''INSERT INTO SYN_ORD(SOET,ROW_NUM,SOOR,SOST,JTID_L,BIID_L,SYID_L,CIID_L) values('BIF_GRO2',0,305,1, ${LoginController().JTID},${LoginController().BIID},${LoginController().SYID},'${LoginController().CIID}')''');
        await db.execute('''INSERT INTO SYN_ORD(SOET,ROW_NUM,SOOR,SOST,JTID_L,BIID_L,SYID_L,CIID_L) values('MAT_FOL',0,306,1, ${LoginController().JTID},${LoginController().BIID},${LoginController().SYID},'${LoginController().CIID}')''');
        await db.execute('''INSERT INTO SYN_ORD(SOET,ROW_NUM,SOOR,SOST,JTID_L,BIID_L,SYID_L,CIID_L) values('MAT_DES_M',0,307,1, ${LoginController().JTID},${LoginController().BIID},${LoginController().SYID},'${LoginController().CIID}')''');
        await db.execute('''INSERT INTO SYN_ORD(SOET,ROW_NUM,SOOR,SOST,JTID_L,BIID_L,SYID_L,CIID_L) values('MAT_DES_D',0,308,1, ${LoginController().JTID},${LoginController().BIID},${LoginController().SYID},'${LoginController().CIID}')''');

        await db.execute('''UPDATE BIL_MOV_D SET BMDTX11=BMDTX,BMDTXA11=BMDTXA,BMDTXT1=BMDTXT''');
        await db.execute('''UPDATE BIF_MOV_D SET BMDTX11=BMDTX,BMDTXA11=BMDTXA,BMDTXT1=BMDTXT''');
        await db.execute('''UPDATE BIL_MOV_M SET BMMTX11=BMMTX, TTID1=1''');
        await db.execute('''UPDATE BIF_MOV_M SET BMMTX11=BMMTX, TTID1=1''');

        await db.execute('''
       CREATE TABLE RES_SEC (
  RSID   INTEGER,
  RSNA   TEXT,
  RSNE   TEXT,
  RSHN   TEXT,
  RSST   INTEGER                            DEFAULT 1,
  RSFN   INTEGER,
  RSIN   TEXT,
  BIID   INTEGER,
  ORDNU  INTEGER,
  RES    TEXT,
  DATEI  DATE,
  SUID   TEXT,
  SUCH   TEXT,
  DATEU  DATE,
  DEVI   TEXT,
  DEVU   TEXT,
  DEFN   INTEGER,
  RSN3   TEXT,
  GUID   TEXT,               
  JTID_L INTEGER,
  BIID_L INTEGER,
  SYID_L INTEGER,
  CIID_L TEXT 
         )  
      ''');
        await db.execute('''
       CREATE TABLE RES_TAB (
  RSID   INTEGER,
  RTID   TEXT,
  RTNA   TEXT,
  RTNE   TEXT,
  RTST   INTEGER                            DEFAULT 1,
  RTIN   TEXT,
  BIID   INTEGER,
  ORDNU  INTEGER,
  RES    TEXT,
  DATEI  DATE,
  SUID   TEXT,
  SUCH   TEXT,
  DATEU  DATE,
  DEVI   TEXT,
  DEVU   TEXT,
  DEFN   INTEGER,
  RTN3   TEXT,
  GUID   TEXT,              
  JTID_L INTEGER,
  BIID_L INTEGER,
  SYID_L INTEGER,
  CIID_L TEXT 
         )  
      ''');
        await db.execute('''
       CREATE TABLE RES_EMP (
  REID   INTEGER,
  RSID   INTEGER,
  RENA   TEXT,
  RENE   TEXT,
  REST   INTEGER                            DEFAULT 1,
  REIN   TEXT,
  BIID   INTEGER,
  ORDNU  INTEGER,
  RES    TEXT,
  DATEI  DATE,
  SUID   TEXT,
  SUCH   TEXT,
  DATEU  DATE,
  DEVI   TEXT,
  DEVU   TEXT,
  DEFN   INTEGER,
  REN3   TEXT,
  GUID   TEXT,              
  JTID_L INTEGER,
  BIID_L INTEGER,
  SYID_L INTEGER,
  CIID_L TEXT 
         )  
      ''');
        await db.execute('''
       CREATE TABLE BIF_GRO (
  MGNO  TEXT,
  BGOR  INTEGER,
  BGBR  TEXT,
  BGCR  TEXT,
  BGMA  TEXT,  
  DATEI  DATE,
  SUID   TEXT,
  SUCH   TEXT,
  DATEU  DATE,
  DEVI   TEXT,
  DEVU   TEXT,
  BGST   INTEGER,
  GUID   TEXT,            
  JTID_L INTEGER,
  BIID_L INTEGER,
  SYID_L INTEGER,
  CIID_L TEXT 
         )  
      ''');
        await db.execute('''
       CREATE TABLE BIF_GRO2 (
  MGNO  TEXT,
  BGOR  INTEGER,
  BGBR  TEXT,
  BGCR  TEXT,
  BGMA  TEXT, 
  BGST   INTEGER, 
  DATEI  DATE,
  SUID   TEXT,
  SUCH   TEXT,
  DATEU  DATE,
  DEVI   TEXT,
  DEVU   TEXT,
  GUID   TEXT,            
  JTID_L INTEGER,
  BIID_L INTEGER,
  SYID_L INTEGER,
  CIID_L TEXT 
         )  
      ''');
        await db.execute('''
       CREATE TABLE BIF_MOV_A (
 BMKID  INTEGER,
  BMMID  INTEGER,
  BMMNO  INTEGER,
  RSID   INTEGER,
  RTID   TEXT,
  REID   INTEGER,
  BMATY  INTEGER                             DEFAULT 1,
  GUID   TEXT,
  BDID   INTEGER,
  BMACR  REAL                            DEFAULT 0,
  BMACA  REAL                           DEFAULT 0,
  BCDID  INTEGER,
  GUIDR  TEXT,
  BMADD  DATE                                   DEFAULT SYSDATE,
  BMADT  REAL                        DEFAULT 0,
  PKIDB  INTEGER                            DEFAULT 1,
  GUIDP  TEXT,              
  JTID_L INTEGER,
  BIID_L INTEGER,
  SYID_L INTEGER,
  CIID_L TEXT 
         )  
      ''');
        await db.execute('''
       CREATE TABLE MAT_FOL (
 BIID  INTEGER,
  MGNO  TEXT,
  MINO  TEXT,
  MUID   INTEGER,
  MFNO   REAL,
  MGNOF   TEXT,
  MINOF  TEXT ,
  MUIDF   INTEGER,
  MFNOF   REAL,
  MFDO  TEXT,
  MFIN  TEXT,
  MFST  INTEGER,
  MFID  INTEGER ,
  DATEI  DATE,
  SUID   TEXT,
  SUCH   TEXT,
  DATEU  DATE,
  DEVI   TEXT,
  DEVU   TEXT,
  GUID   TEXT,            
  JTID_L INTEGER,
  BIID_L INTEGER,
  SYID_L INTEGER,
  CIID_L TEXT 
         )  
      ''');
        await db.execute('''
       CREATE TABLE MAT_DES_M (
  MDMID  INTEGER,
  MDMNA  TEXT,
  MDMNE  TEXT,
  MDMN3  TEXT,
  MDMDE  TEXT,
  MGNOT  INTEGER                                 DEFAULT 1,
  MDMST  INTEGER                                 DEFAULT 1,
  ORDNU  INTEGER,
  RES    TEXT,
  SUID   TEXT,
  DATEI  DATE,
  DEVI   TEXT,
  SUCH   TEXT,
  DATEU  DATE,
  DEVU   TEXT,
  DEFN   INTEGER,
  GUID   TEXT,
  JTID_L INTEGER,
  BIID_L INTEGER,
  SYID_L INTEGER,
  CIID_L TEXT 
         )  
      ''');
        await db.execute('''
       CREATE TABLE MAT_DES_D (
   MDDID  INTEGER,
  MDMID  INTEGER,
  MGNO   TEXT,
  MINO   TEXT,
  MDDST  INTEGER                                 DEFAULT 1,
  ORDNU  INTEGER,
  RES    TEXT,
  SUID   TEXT,
  DATEI  DATE,
  DEVI   TEXT,
  SUCH   TEXT,
  DATEU  DATE,
  DEVU   TEXT,
  DEFN   INTEGER                                 DEFAULT 2,
  GUID   TEXT,
  JTID_L INTEGER,
  BIID_L INTEGER,
  SYID_L INTEGER,
  CIID_L TEXT 
         )  
      ''');

        await db.execute('''CREATE TABLE MAT_DES_M_TMP AS  SELECT  * FROM MAT_DES_M WHERE 1=2''');
        await db.execute('''CREATE TABLE MAT_DES_D_TMP AS  SELECT  * FROM MAT_DES_D WHERE 1=2''');
        await db.execute('''CREATE TABLE MAT_FOL_TMP AS  SELECT  * FROM MAT_FOL WHERE 1=2''');
        await db.execute('''CREATE TABLE RES_TAB_TMP AS  SELECT  * FROM RES_TAB WHERE 1=2''');
        await db.execute('''CREATE TABLE RES_SEC_TMP AS  SELECT  * FROM RES_SEC WHERE 1=2''');
        await db.execute('''CREATE TABLE RES_EMP_TMP AS  SELECT  * FROM RES_EMP WHERE 1=2''');
        await db.execute('''CREATE TABLE BIF_GRO_TMP AS  SELECT  * FROM BIF_GRO WHERE 1=2''');
        await db.execute('''CREATE TABLE BIF_GRO2_TMP AS  SELECT  * FROM BIF_GRO2 WHERE 1=2''');
        await db.execute('''CREATE TABLE BIF_MOV_A_TMP AS  SELECT  * FROM BIF_MOV_A WHERE 1=2''');


        await db.execute('''ALTER TABLE BIF_MOV_M ADD COLUMN  BMMGR  TEXT''');
        await db.execute('''ALTER TABLE BIF_CUS_D ADD COLUMN  SYST_L INTEGER  DEFAULT 1''');
        await db.execute('''ALTER TABLE BIF_CUS_D ADD COLUMN  BCDDL_L INTEGER  DEFAULT 1''');
        await db.execute('''ALTER TABLE BIF_CUS_D_TMP ADD COLUMN  SYST_L INTEGER  DEFAULT 1''');
        await db.execute('''ALTER TABLE BIF_CUS_D_TMP ADD COLUMN  BCDDL_L INTEGER  DEFAULT 1''');
        await db.execute('''ALTER TABLE ACC_ACC_TMP ADD COLUMN  SYST_L INTEGER  DEFAULT 1''');
        await db.execute('''ALTER TABLE ACC_USR_TMP ADD COLUMN  SYST_L INTEGER  DEFAULT 1''');

        await db.execute('''ALTER TABLE BIL_POI_TMP ADD COLUMN BPSEO INTEGER''');
        await db.execute('''ALTER TABLE BIL_POI_TMP ADD COLUMN BPIDT INTEGER''');
        await db.execute('''ALTER TABLE BIL_POI_TMP ADD COLUMN BPIDV TEXT''');
        await db.execute('''ALTER TABLE TAX_SYS_BRA_TMP ADD COLUMN  SUID TEXT  ''');
        await db.execute('''ALTER TABLE TAX_SYS_BRA_TMP ADD COLUMN  DATEI TEXT ''');
        await db.execute('''ALTER TABLE TAX_SYS_BRA_TMP ADD COLUMN  DEVI TEXT  ''');
        await db.execute('''ALTER TABLE TAX_SYS_BRA_TMP ADD COLUMN  SUCH TEXT  ''');
        await db.execute('''ALTER TABLE TAX_SYS_BRA_TMP ADD COLUMN  DATEU TEXT ''');
        await db.execute('''ALTER TABLE TAX_SYS_BRA_TMP ADD COLUMN  DEVU TEXT  ''');
        await db.execute('''ALTER TABLE BIF_MOV_M ADD COLUMN  BMMDE  TEXT  ''');
        await db.execute('''CREATE TABLE MAT_INF_D_TMP AS  SELECT  * FROM MAT_INF_D WHERE 1=2''');

        await db.execute('''
       CREATE TABLE MAT_DIS_T (
   MDTID  INTEGER,
  MDTNA  TEXT,
  MDTNE  TEXT,
  MDTN3  TEXT,
  MDTST  INTEGER                             DEFAULT 1,
  SUID   TEXT,
  DATEI  DATE,
  SUCH   TEXT,
  DATEU  DATE,
  GUID   TEXT,
    DEVI   TEXT,
  DEVU   TEXT,
  JTID_L INTEGER,
  BIID_L INTEGER,
  SYID_L INTEGER,
  CIID_L TEXT 
         )  
      ''');
        await db.execute('''
       CREATE TABLE MAT_DIS_K (
   MDKID  INTEGER,
  MDTID  INTEGER                             DEFAULT 0,
  MDKNA  TEXT,
  MDKNE  TEXT,
  MDKN3  TEXT,
  MDKST  INTEGER                             DEFAULT 1,
  SUID   TEXT,
  DATEI  DATE,
  SUCH   TEXT,
  DATEU  DATE,
  GUID   TEXT,
    DEVI   TEXT,
  DEVU   TEXT,
  JTID_L INTEGER,
  BIID_L INTEGER,
  SYID_L INTEGER,
  CIID_L TEXT 
         )  
      ''');
        await db.execute('''
       CREATE TABLE MAT_DIS_M (
    GUID     TEXT,
  MDMID    INTEGER,
  MDTID    INTEGER,
  MDKID    INTEGER,
  MDMRA    REAL                               DEFAULT 0,
  MDMSM    INTEGER                          DEFAULT 1,
  MDMCO    REAL                               DEFAULT 0,
  MDMAM    REAL                               DEFAULT 0,
  MDMMN    REAL                               DEFAULT 0,
  MDMCR    INTEGER                           DEFAULT 0,
  MDMCR2   INTEGER,
  MDMCR3   INTEGER,
  MDMOI    INTEGER                         DEFAULT 0,
  MDMFD    DATE,
  MDMTD    DATE,
  MDMFDA   INTEGER,
  MDMTDA   INTEGER,
  MDMFM    INTEGER,
  MDMTM    INTEGER,
  MDMFY    INTEGER,
  MDMTY    INTEGER,
  MDMFT    INTEGER,
  MDMTT    INTEGER,
  MDMDAYT  INTEGER                           DEFAULT 0,
  MDMDAY   TEXT,
  MDMST    INTEGER                         DEFAULT 1,
  MDMDE    TEXT,
  MDMRE    TEXT,
  SUID     TEXT,
  DATEI    DATE,
  SUCH     TEXT,
  DATEU    DATE,
    DEVI   TEXT,
  DEVU   TEXT,
  JTID_L INTEGER,
  BIID_L INTEGER,
  SYID_L INTEGER,
  CIID_L TEXT 
         )  
      ''');
        await db.execute('''
       CREATE TABLE MAT_DIS_D (
    GUID   TEXT,
  MDDID  INTEGER,
  MDMID  INTEGER,
  MGNO   TEXT,
  MINO   TEXT,
  MUID   INTEGER,
  MDDRA  REAL,
  MDDNU  REAL                                 DEFAULT 0,
  MDDAM  REAL                                 DEFAULT 0,
  MDDMN  REAL                                 DEFAULT 0,
  MDDSI  INTEGER                            DEFAULT 1,
  MDDST  INTEGER                                 DEFAULT 1,
  SUID   TEXT,
  DATEI  DATE,
  SUCH   TEXT,
  DATEU  DATE,
    DEVI   TEXT,
  DEVU   TEXT,
  JTID_L INTEGER,
  BIID_L INTEGER,
  SYID_L INTEGER,
  CIID_L TEXT 
         )  
      ''');
        await db.execute('''
       CREATE TABLE MAT_DIS_F (
    GUID   TEXT,
  MDFID  INTEGER,
  MDDID  INTEGER,
  MDMID  INTEGER,
  MGNO   TEXT,
  MINO   TEXT,
  MUID   INTEGER,
  MDFFN  INTEGER,
  MDFTN  INTEGER,
  SCID   INTEGER,
  MDFMP  INTEGER,
  MDFRA  INTEGER,
  MDFNU  INTEGER                                 DEFAULT 0,
  MDFAM  INTEGER                                 DEFAULT 0,
  MDFMN  INTEGER                                 DEFAULT 0,
  MDFST  INTEGER                             DEFAULT 1,
  SUID   TEXT,
  DATEI  DATE,
  SUCH   TEXT,
  DATEU  DATE,
    DEVI   TEXT,
  DEVU   TEXT,
  JTID_L INTEGER,
  BIID_L INTEGER,
  SYID_L INTEGER,
  CIID_L TEXT 
         )  
      ''');
        await db.execute('''
       CREATE TABLE MAT_DIS_L (
    GUID   TEXT,
   GUIDM  TEXT,
  GUIDD  TEXT,
  MMMID  INTEGER,
  MDMID  INTEGER,
  MDLST  INTEGER                             DEFAULT 1,
  SUID   TEXT,
  DATEI  DATE,
  SUCH   TEXT,
  DATEU  DATE,
    DEVI   TEXT,
  DEVU   TEXT,
  MCKID  INTEGER,
  JTID_L INTEGER,
  BIID_L INTEGER,
  SYID_L INTEGER,
  CIID_L TEXT 
         )  
      ''');
        await db.execute('''
       CREATE TABLE MAT_DIS_N (
    GUID    TEXT,
  MDNID   INTEGER,
  MMMID   INTEGER,
  MDMID   INTEGER,
  MDDID   INTEGER,
  MDFID   INTEGER,
  GUIDM   TEXT,
  MDNAM   INTEGER                                DEFAULT 0,
  MDNAM2  INTEGER                                DEFAULT 0,
  MDNNU   INTEGER                                DEFAULT 0,
  MDNNU2  INTEGER                                DEFAULT 0,
  MDNMN   INTEGER                                DEFAULT 0,
  MDNMN2  INTEGER                                DEFAULT 0,
  MDNN2   INTEGER                                DEFAULT 0,
  MDNN22  INTEGER                                DEFAULT 0,
  MDNN3   INTEGER                                DEFAULT 0,
  MDNN32  INTEGER                                DEFAULT 0,
  MDNC1   TEXT,
  MDNC2   TEXT,
  MDNST   INTEGER                            DEFAULT 1,
  SUID    TEXT,
  DATEI   DATE,
  SUCH    TEXT,
  DATEU   DATE,
    DEVI   TEXT,
  DEVU   TEXT,
  JTID_L INTEGER,
  BIID_L INTEGER,
  SYID_L INTEGER,
  CIID_L TEXT 
         )  
      ''');
        await db.execute('''
       CREATE TABLE MAT_DIS_S (
      GUID   TEXT,
  MDSST  INTEGER                                 DEFAULT 2,
  MDSRE  TEXT,
  SUID   TEXT,
  DATEI  DATE,
  SUCH   TEXT,
  DATEU  DATE,
    DEVI   TEXT,
  DEVU   TEXT,
  JTID_L INTEGER,
  BIID_L INTEGER,
  SYID_L INTEGER,
  CIID_L TEXT 
         )  
      ''');
        await db.execute('''
       CREATE TABLE SYN_TAS (
       CIID INTEGER,
       JTID INTEGER,
       BIID INTEGER,
       SYID INTEGER,
 GUID    TEXT, 
 STMID   TEXT,
 STKI    TEXT, 
 STTY    TEXT,
 STTB    TEXT,
 STDE    TEXT,
 STDE2   TEXT,
 STDE3   TEXT,
 STFU    TEXT,
 STTU    TEXT,
 STFID   INTEGER,
 STTID   INTEGER,
 STFD    DATE, 
 STTD    DATE,
 STIM    INTEGER DEFAULT 2, 
 STST    INTEGER DEFAULT 1, 
 SUID    TEXT, 
 DATEI   DATE, 
 DEVI    TEXT,
 SUCH    TEXT,
 DATEU   DATE, 
 DEVU    TEXT,
  JTID_L INTEGER,
  BIID_L INTEGER,
  SYID_L INTEGER,
  CIID_L TEXT 
         )  
      ''');
        await db.execute('''CREATE TABLE MAT_DIS_T_TMP AS SELECT  * FROM MAT_DIS_T WHERE 1=2''');
        await db.execute('''CREATE TABLE MAT_DIS_K_TMP AS SELECT  * FROM MAT_DIS_K WHERE 1=2''');
        await db.execute('''CREATE TABLE MAT_DIS_M_TMP AS SELECT  * FROM MAT_DIS_M WHERE 1=2''');
        await db.execute('''CREATE TABLE MAT_DIS_D_TMP AS SELECT  * FROM MAT_DIS_D WHERE 1=2''');
        await db.execute('''CREATE TABLE MAT_DIS_F_TMP AS SELECT  * FROM MAT_DIS_F WHERE 1=2''');
        await db.execute('''CREATE TABLE MAT_DIS_L_TMP AS SELECT  * FROM MAT_DIS_L WHERE 1=2''');
        await db.execute('''CREATE TABLE MAT_DIS_N_TMP AS SELECT  * FROM MAT_DIS_N WHERE 1=2''');
        await db.execute('''CREATE TABLE MAT_DIS_S_TMP AS SELECT  * FROM MAT_DIS_S WHERE 1=2''');
        await db.execute('''CREATE TABLE SYN_TAS_TMP AS SELECT  * FROM SYN_TAS WHERE 1=2''');

        await db.execute(''' CREATE  INDEX MAT_DIS_M_I1 ON MAT_DIS_M(MDMID,JTID_L,SYID_L,CIID_L)''');
        await db.execute(''' CREATE  INDEX MAT_DIS_D_I1 ON MAT_DIS_D(MDDID,JTID_L,SYID_L,CIID_L)''');

        await db.execute('''ALTER TABLE CONFIG ADD COLUMN  STMID TEXT  ''');
        await db.execute('''ALTER TABLE CONFIG ADD COLUMN  SYDV_NAME TEXT  ''');
        await db.execute('''ALTER TABLE CONFIG ADD COLUMN  SYDV_TY TEXT  ''');
        await db.execute('''ALTER TABLE CONFIG ADD COLUMN  SYDV_SER TEXT ''');
        await db.execute('''ALTER TABLE CONFIG ADD COLUMN  SYDV_ID TEXT ''');
        await db.execute('''ALTER TABLE CONFIG ADD COLUMN SYDV_NO TEXT ''');
        await db.execute('''ALTER TABLE CONFIG ADD COLUMN SYDV_IP TEXT ''');
        await db.execute('''ALTER TABLE CONFIG ADD COLUMN SYDV_APPV TEXT ''');

        await db.execute('''ALTER TABLE BIL_CUS ADD COLUMN BCLON TEXT''');
        await db.execute('''ALTER TABLE BIL_CUS ADD COLUMN BCLAT TEXT''');
        await db.execute('''ALTER TABLE BIL_CUS ADD COLUMN BILON TEXT''');
        await db.execute('''ALTER TABLE BIL_CUS_TMP ADD COLUMN BCLON TEXT''');
        await db.execute('''ALTER TABLE BIL_CUS_TMP ADD COLUMN BILON TEXT''');
        await db.execute('''ALTER TABLE BIL_CUS_TMP ADD COLUMN BCLAT TEXT''');

        await db.execute('''ALTER TABLE BIL_IMP ADD COLUMN BILON TEXT''');
        await db.execute('''ALTER TABLE BIL_IMP ADD COLUMN BILAT TEXT''');
        await db.execute('''ALTER TABLE BIL_IMP ADD COLUMN BICR INTEGER''');
        await db.execute('''ALTER TABLE BIL_IMP_TMP ADD COLUMN BICR INTEGER''');
        await db.execute('''ALTER TABLE BIL_IMP_TMP ADD COLUMN BILON TEXT''');
        await db.execute('''ALTER TABLE BIL_IMP_TMP ADD COLUMN BILAT TEXT''');

        await db.execute('''ALTER TABLE BIF_CUS_D ADD COLUMN BCDLON TEXT''');
        await db.execute('''ALTER TABLE BIF_CUS_D ADD COLUMN BCDLAT TEXT''');
        await db.execute('''ALTER TABLE BIF_CUS_D_TMP ADD COLUMN BCDLON TEXT''');
        await db.execute('''ALTER TABLE BIF_CUS_D_TMP ADD COLUMN BCDLAT TEXT''');

        await db.execute('''ALTER TABLE BIL_MOV_M ADD COLUMN BMMLON TEXT''');
        await db.execute('''ALTER TABLE BIL_MOV_M ADD COLUMN BMMLAT TEXT''');
        await db.execute('''ALTER TABLE BIF_MOV_M ADD COLUMN BMMLON TEXT''');
        await db.execute('''ALTER TABLE BIF_MOV_M ADD COLUMN BMMLAT TEXT''');

        await db.execute('''ALTER TABLE PAY_KIN ADD COLUMN  PKTY INTEGER''');
        await db.execute('''ALTER TABLE PAY_KIN_TMP ADD COLUMN  PKTY INTEGER''');
        await db.execute('''UPDATE PAY_KIN SET PKTY=1 WHERE PKID IN(1,2,5,8,9)''');
        await db.execute('''UPDATE PAY_KIN SET PKTY=2 WHERE PKID IN(3,4,10,11)''');
        await db.execute('''UPDATE PAY_KIN SET PKTY=3 WHERE PKID NOT IN(1,2,5,8,9,3,4,10,11)''');

        //2023-11-22
        await db.execute('''
       CREATE TABLE MAT_MAI_M (
       GUID    TEXT,
  MMMID   INTEGER,
  MMMDE   TEXT,
  BIIDT   INTEGER                                DEFAULT 0,
  BIID    TEXT,
  MMMBLT  INTEGER                                DEFAULT 0,
  MMMBL   TEXT,
  PKIDT   INTEGER                                DEFAULT 0,
  PKID    TEXT,
  BCCIDT  INTEGER                                DEFAULT 0,
  BCCID   TEXT,
  SCIDT   INTEGER                                DEFAULT 0,
  SCID    TEXT,
  BCTIDT  INTEGER                                DEFAULT 0,
  BCTID   TEXT,
  BCIDT   INTEGER                                DEFAULT 0,
  BCDIDT  INTEGER                                DEFAULT 0,
  CIIDT   INTEGER                                DEFAULT 0,
  ECIDT   INTEGER                                DEFAULT 0,
  SIIDT   INTEGER                                DEFAULT 0,
  SIID    TEXT,
  ACNOT   INTEGER                                DEFAULT 0,
  ACNO    TEXT,
  SUIDT   INTEGER                                DEFAULT 0,
  SUIDV   TEXT,
  MMMFD   DATE,
  MMMTD   DATE,
  MMMFT   INTEGER,
  MMMTT   INTEGER,
  MMMDAY  TEXT,
  ORDNU   INTEGER,
  SUID    TEXT,
  DATEI   DATE,
  SUCH    TEXT,
  DATEU   DATE,
  MMMST   INTEGER                                DEFAULT 1,
  DEVI    TEXT,
  DEVU    TEXT,
  JTID_L INTEGER,
  BIID_L INTEGER,
  SYID_L INTEGER,
  CIID_L TEXT 
         )  
      ''');
        await db.execute('''CREATE TABLE MAT_MAI_M_TMP AS SELECT  * FROM MAT_MAI_M WHERE 1=2''');
        await db.execute('''
       CREATE TABLE BIL_MOV_DD (
       BMDSQ   INTEGER,
  BMKID   INTEGER,
  BMMID   INTEGER,
  BMDID   INTEGER,
  GUID    TEXT,
  MMMID   INTEGER,
  MDMID   INTEGER,
  MDDID   INTEGER,
  MDFID   INTEGER,
  GUIDM   TEXT,
  MDTID   INTEGER                                DEFAULT 2,
  MGNO    TEXT,
  MINO    TEXT,
  MUID    INTEGER,
  BMDAM   REAL                                DEFAULT 0,
  BMDNO   REAL                                DEFAULT 0,
  BMDRE   REAL                                DEFAULT 0,
  BMDN1   INTEGER                                DEFAULT 0,
  BMDN2   INTEGER                                DEFAULT 0,
  BMDC1   TEXT,
  BMDC2   TEXT,
  BMDC3   TEXT,
  BMDST   INTEGER                                DEFAULT 1,
  BMDSQR  INTEGER,
  MCKID   INTEGER                                DEFAULT 1,
  MCDID   INTEGER,
  JTID_L INTEGER,
  BIID_L INTEGER,
  SYID_L INTEGER,
  CIID_L TEXT 
         )  
      ''');
        await db.execute('''
       CREATE TABLE BIL_MOV_MD (
      BMMSQ   INTEGER,
  BMKID   INTEGER,
  BMMID   INTEGER,
  GUID    TEXT,
  MMMID   INTEGER,
  MDMID   INTEGER,
  MDDID   INTEGER,
  MDFID   INTEGER,
  GUIDM   TEXT,
  BMMAM   REAL                                DEFAULT 0,
  BMMNO   REAL                                DEFAULT 0,
  BMMRE   REAL                                DEFAULT 0,
  BMMN1   INTEGER                                DEFAULT 0,
  BMMN2   INTEGER                                DEFAULT 0,
  BMMN3   INTEGER                                DEFAULT 0,
  BMMC1   TEXT,
  BMMC2   TEXT,
  BMMC3   TEXT,
  BMMC4   TEXT,
  BMMC5   TEXT,
  BMMST   INTEGER                                DEFAULT 1,
  BMMSQR  INTEGER,
  MCKID   INTEGER                                DEFAULT 1,
  MCDID   INTEGER,
  JTID_L INTEGER,
  BIID_L INTEGER,
  SYID_L INTEGER,
  CIID_L TEXT 
         )  
      ''');
        await db.execute('''
       CREATE TABLE BIF_MOV_DD (
       BMDSQ   INTEGER,
  BMKID   INTEGER,
  BMMID   INTEGER,
  BMDID   INTEGER,
  GUID    TEXT,
  MMMID   INTEGER,
  MDMID   INTEGER,
  MDDID   INTEGER,
  MDFID   INTEGER,
  GUIDM   TEXT,
  MDTID   INTEGER                                DEFAULT 2,
  MGNO    TEXT,
  MINO    TEXT,
  MUID    INTEGER,
  BMDAM   REAL                                DEFAULT 0,
  BMDNO   REAL                                DEFAULT 0,
  BMDRE   REAL                                DEFAULT 0,
  BMDN1   INTEGER                                DEFAULT 0,
  BMDN2   INTEGER                                DEFAULT 0,
  BMDC1   TEXT,
  BMDC2   TEXT,
  BMDC3   TEXT,
  BMDST   INTEGER                                DEFAULT 1,
  BMDSQR  INTEGER,
  MCKID   INTEGER                                DEFAULT 1,
  MCDID   INTEGER,
  JTID_L INTEGER,
  BIID_L INTEGER,
  SYID_L INTEGER,
  CIID_L TEXT 
         )  
      ''');
        await db.execute('''
       CREATE TABLE BIF_MOV_MD (
      BMMSQ   INTEGER,
  BMKID   INTEGER,
  BMMID   INTEGER,
  GUID    TEXT,
  MMMID   INTEGER,
  MDMID   INTEGER,
  MDDID   INTEGER,
  MDFID   INTEGER,
  GUIDM   TEXT,
  BMMAM   REAL                                DEFAULT 0,
  BMMNO   REAL                                DEFAULT 0,
  BMMRE   REAL                                DEFAULT 0,
  BMMN1   INTEGER                                DEFAULT 0,
  BMMN2   INTEGER                                DEFAULT 0,
  BMMN3   INTEGER                                DEFAULT 0,
  BMMC1   TEXT,
  BMMC2   TEXT,
  BMMC3   TEXT,
  BMMC4   TEXT,
  BMMC5   TEXT,
  BMMST   INTEGER                                DEFAULT 1,
  BMMSQR  INTEGER,
  MCKID   INTEGER                                DEFAULT 1,
  MCDID   INTEGER,
  JTID_L INTEGER,
  BIID_L INTEGER,
  SYID_L INTEGER,
  CIID_L TEXT 
         )  
      ''');

        //2023-11-24
        await db.execute('''INSERT INTO SYN_ORD(SOET,ROW_NUM,SOOR,SOST,JTID_L,BIID_L,SYID_L,CIID_L) values('MAT_DIS_T',0,309,1, ${LoginController().JTID},${LoginController().BIID},${LoginController().SYID},'${LoginController().CIID}')''');
        await db.execute('''INSERT INTO SYN_ORD(SOET,ROW_NUM,SOOR,SOST,JTID_L,BIID_L,SYID_L,CIID_L) values('MAT_DIS_K',0,310,1, ${LoginController().JTID},${LoginController().BIID},${LoginController().SYID},'${LoginController().CIID}')''');
        await db.execute('''INSERT INTO SYN_ORD(SOET,ROW_NUM,SOOR,SOST,JTID_L,BIID_L,SYID_L,CIID_L) values('MAT_DIS_M',0,311,1, ${LoginController().JTID},${LoginController().BIID},${LoginController().SYID},'${LoginController().CIID}')''');
        await db.execute('''INSERT INTO SYN_ORD(SOET,ROW_NUM,SOOR,SOST,JTID_L,BIID_L,SYID_L,CIID_L) values('MAT_DIS_D',0,312,1, ${LoginController().JTID},${LoginController().BIID},${LoginController().SYID},'${LoginController().CIID}')''');
        await db.execute('''INSERT INTO SYN_ORD(SOET,ROW_NUM,SOOR,SOST,JTID_L,BIID_L,SYID_L,CIID_L) values('MAT_DIS_F',0,313,1, ${LoginController().JTID},${LoginController().BIID},${LoginController().SYID},'${LoginController().CIID}')''');
        await db.execute('''INSERT INTO SYN_ORD(SOET,ROW_NUM,SOOR,SOST,JTID_L,BIID_L,SYID_L,CIID_L) values('MAT_DIS_L',0,314,1, ${LoginController().JTID},${LoginController().BIID},${LoginController().SYID},'${LoginController().CIID}')''');
        await db.execute('''INSERT INTO SYN_ORD(SOET,ROW_NUM,SOOR,SOST,JTID_L,BIID_L,SYID_L,CIID_L) values('MAT_DIS_N',0,315,1, ${LoginController().JTID},${LoginController().BIID},${LoginController().SYID},'${LoginController().CIID}')''');
        await db.execute('''INSERT INTO SYN_ORD(SOET,ROW_NUM,SOOR,SOST,JTID_L,BIID_L,SYID_L,CIID_L) values('MAT_MAI_M',0,316,1, ${LoginController().JTID},${LoginController().BIID},${LoginController().SYID},'${LoginController().CIID}')''');

        //2023-11-25
        await db.execute('''UPDATE BIL_MOV_M SET BMMST2=1 WHERE BMMST=1''');
        await db.execute('''UPDATE BIF_MOV_M SET BMMST2=1 WHERE BMMST=1''');

        await OnUpgradeV446(db);
        await OnUpgradeV446_9(db);
        await OnUpgradeV448_10(db);
        await OnUpgradeV449_11(db);
        await OnUpgradeV449_12(db);
        await OnUpgradeV449_13(db);
        await OnUpgradeV449_14(db);
        await OnUpgradeV449_15(db);
        await OnUpgradeV449_16(db);
        await OnUpgradeV449_17(db);

        print(oldversion);
        print(newversion);
        print("oldversion");
      }

      else  if (oldversion == 3) {
        await db.execute('''ALTER TABLE BIF_MOV_M ADD COLUMN BMMST2 INTEGER DEFAULT 2''');
        await db.execute('''ALTER TABLE BIL_MOV_M ADD COLUMN BMMST2 INTEGER DEFAULT 2''');
        await db.execute('''ALTER TABLE BIL_MOV_M ADD COLUMN SCIDP INTEGER''');
        await db.execute('''ALTER TABLE BIL_MOV_M ADD COLUMN SCEXP REAL''');
        await db.execute('''ALTER TABLE BIL_MOV_M ADD COLUMN BMMAMP REAL''');
        await db.execute('''ALTER TABLE BIL_MOV_M ADD COLUMN SCIDP2 INTEGER''');
        await db.execute('''ALTER TABLE BIL_MOV_M ADD COLUMN SCEXP2 REAL''');
        await db.execute('''ALTER TABLE BIL_MOV_M ADD COLUMN BMMAMP2 REAL''');
        await db.execute('''ALTER TABLE BIL_MOV_M ADD COLUMN BMMCP REAL''');
        await db.execute('''ALTER TABLE BIL_MOV_M ADD COLUMN BMMTC REAL''');
        await db.execute('''ALTER TABLE BIL_MOV_M ADD COLUMN AMMID INTEGER''');
        await db.execute('''ALTER TABLE BIF_MOV_M ADD COLUMN AMMID INTEGER''');
        await db.execute('''ALTER TABLE ACC_MOV_D ADD COLUMN AMDSS INTEGER''');
        await db.execute('''ALTER TABLE ACC_MOV_D ADD COLUMN AMDMS TEXT''');

        await db.execute('''ALTER TABLE BIL_POI ADD COLUMN BPSEO INTEGER''');
        await db.execute('''ALTER TABLE BIL_POI ADD COLUMN BPIDT INTEGER''');
        await db.execute('''ALTER TABLE BIL_POI ADD COLUMN BPIDV TEXT''');
        await db.execute('''ALTER TABLE TAX_SYS_BRA ADD COLUMN  SUID TEXT  ''');
        await db.execute('''ALTER TABLE TAX_SYS_BRA ADD COLUMN  DATEI TEXT ''');
        await db.execute('''ALTER TABLE TAX_SYS_BRA ADD COLUMN  DEVI TEXT  ''');
        await db.execute('''ALTER TABLE TAX_SYS_BRA ADD COLUMN  SUCH TEXT  ''');
        await db.execute('''ALTER TABLE TAX_SYS_BRA ADD COLUMN  DATEU TEXT ''');
        await db.execute('''ALTER TABLE TAX_SYS_BRA ADD COLUMN  DEVU TEXT ''');
        await db.execute(''' DROP TABLE SYN_LOG ''');
        await db.execute('''
         CREATE TABLE SYN_LOG (   
         SLSQ            INTEGER PRIMARY KEY,
       SLDO            DATE ,
       SLIN            TEXT,
       SLTY            TEXT,
    SUID            TEXT,
    STMSQ           INTEGER,
    SMID            INTEGER,
    STMID           TEXT,
    GUID            TEXT,
    SOTT            TEXT,
    SOTY            TEXT,
    SLC1            TEXT,
    CIID            INTEGER,
    JTID            INTEGER,
    BIID            INTEGER,
    SYID            INTEGER,
    SOMID           INTEGER,
    SYDV_NAME       TEXT,
    SYDV_IP         TEXT,
    SYDV_SER        TEXT,
    SYDV_POI        TEXT,
    SYDV_NO         TEXT,
    SYDV_LATITUDE   TEXT,
    SYDV_LONGITUDE  TEXT,
    SYDV_APPV       TEXT,
    SYDV_APIV       TEXT,
    SYDV_TY         TEXT,
    SDSQ            INTEGER,
    SLTY2           INTEGER,
    SLIT2           TEXT,
    SLSC2           TEXT,
    SLTYP           TEXT,
    SLC2            TEXT,
    SLC3            TEXT,
    SYDV_ID         TEXT,
    SYDV_GU         TEXT,
    SOGU            TEXT,
         JTID_L INTEGER,
         BIID_L INTEGER,
         SYID_L INTEGER,
         CIID_L TEXT
         )  
      ''');
        await db.execute('''
       CREATE TABLE TAX_LOC (
   TLID   INTEGER,
  GUID  TEXT ,
  TLSY   TEXT,
  TLNA   TEXT ,
  TLNE   TEXT,
  TLN3  TEXT,
  TTID  INTEGER                             DEFAULT 0,
  CWID  INTEGER                             DEFAULT 1,
  CTID  INTEGER,
  TLST   INTEGER,
  TLDE   TEXT,
  AANOO  TEXT,
  AANOI  TEXT,
  AANOR   TEXT,
  AANORR   TEXT,
  TLDC  INTEGER,
  ORDNU  INTEGER,
  RES  TEXT,
  SUID  TEXT,
  DATEI  TEXT,
  DEVI  TEXT,
  SUCH  TEXT,
  DATEU  TEXT,
  DEVU  TEXT,
  DEFN INTEGER,
  JTID_L INTEGER,
  BIID_L INTEGER,
  SYID_L INTEGER,
  CIID_L TEXT 
         )  
      ''');
        await db.execute('''
       CREATE TABLE TAX_LOC_SYS (
   TLSID   INTEGER,
  TLID    INTEGER,
  STID    TEXT,
  GUID    TEXT,
  AANOO   TEXT,
  AANOI   TEXT,
  AANOR   TEXT,
  AANORR  TEXT,
  TLSDC   INTEGER,
  ORDNU   INTEGER,
  RES     TEXT,
  SUID    TEXT,
  DATEI   TEXT ,
  DEVI    TEXT,
  SUCH    TEXT,
  DATEU   TEXT,
  DEVU    TEXT,
  DEFN    INTEGER ,
  JTID_L INTEGER,
  BIID_L INTEGER,
  SYID_L INTEGER,
  CIID_L TEXT 
         )  
      ''');
        await db.execute('''
       CREATE TABLE TAX_MOV_SIN (
  TMSID   INTEGER,
  GUID    TEXT,
  TMSNA   TEXT,
  TMSNE   TEXT,
  TMSN3   TEXT,
  TMSSY   TEXT,
  TMSST   INTEGER                                DEFAULT 1,
  TMSDE   TEXT,
  TMSDE2  TEXT,
  TTID    INTEGER,
  TCID    INTEGER,
  TCSID   INTEGER,
  TCSSY   TEXT,
  TCSDSY  TEXT,
  TMSIT   INTEGER                                DEFAULT 1,
  TMSAC   INTEGER                                DEFAULT 2,
  TMSCO   TEXT,
  TMSDL   INTEGER                                DEFAULT 1,
  TMSUP   INTEGER                                DEFAULT 1,
  ORDNU   INTEGER,
  RES     TEXT,
  SUID    TEXT,
  DATEI   TEXT,
  DEVI    TEXT,
  SUCH    TEXT,
  DATEU   TEXT,
  DEVU    TEXT,
  DEFN    INTEGER ,
  JTID_L INTEGER,
  BIID_L INTEGER,
  SYID_L INTEGER,
  CIID_L TEXT 
         )  
      ''');
        await db.execute('''
       CREATE TABLE TAX_VAR (
 TVID   INTEGER,
  TVSY   TEXT,
  TVNA   TEXT,
  TVNE   TEXT,
  TVN3   TEXT,
  TVVL   TEXT,
  TVDT   TEXT,
  TVDS   TEXT,
  TVDH   INTEGER,
  TVDA   INTEGER,
  TVAD   INTEGER ,
  STID   TEXT,
  STMID  TEXT,
  PRID   TEXT,
  PRIDY  TEXT,
  PRIDN  TEXT,
  TVDAC  INTEGER,
  TVCH   INTEGER,
  TVDL   INTEGER,
  TVIDF  INTEGER,
  TVST   INTEGER,
  ORDNU  INTEGER,
  RES   TEXT,
  SUID   TEXT,
  DATEI  TEXT,
  DEVI   TEXT,
  SUCH   TEXT,
  DATEU  TEXT,
  DEVU   TEXT,
  DEFN   INTEGER,
  GUID   TEXT,
  JTID_L INTEGER,
  BIID_L INTEGER,
  SYID_L INTEGER,
  CIID_L TEXT 
         )  
      ''');
        await db.execute('''
       CREATE TABLE TAX_VAR_D (
  TVDID   INTEGER,
  TVID    INTEGER,
  TTID    INTEGER,
  TVDSY   TEXT,
  TVDTY   INTEGER,
  TVDVL   TEXT,
  TVDDA   DATE,
  STID    TEXT,
  STMID   TEXT,
  PRID    TEXT,
  PRIDY   TEXT,
  PRIDN   TEXT,
  TVDCH   INTEGER,
  TVDIDF  INTEGER,
  TVDST   INTEGER,
  ORDNU   INTEGER,
  RES     TEXT,
  SUID    TEXT,
  DATEI   TEXT,
  DEVI    TEXT,
  SUCH    TEXT,
  DATEU   TEXT,
  DEVU    TEXT,
  DEFN    INTEGER ,
  GUID   TEXT,
  JTID_L INTEGER,
  BIID_L INTEGER,
  SYID_L INTEGER,
  CIID_L TEXT 
         )  
      ''');
        await db.execute('''
       CREATE TABLE TAX_TBL_LNK (
TTLID     INTEGER,
  GUID     TEXT,
  TTID      INTEGER,
  TTLNA     TEXT,
  TTLNE     TEXT,
  TTLN3     TEXT,
  STID     TEXT,
  TTLTB     TEXT,
  TTLNO    TEXT,
  TTLNO2   TEXT,
  TTLSY     TEXT,
  TTLNOL   TEXT,
  TTLNO2L  TEXT,
  TTLSY2    TEXT,
  TTLNOL2  TEXT,
  TTLNO2L2 TEXT,
  TTLST     INTEGER,
  TTLCO    TEXT,
  TTLLN     INTEGER,
  TTLHN     INTEGER,
  TTLDE     TEXT,
  TTLVB     INTEGER,
  TTLVN     INTEGER,
  TTLVF     INTEGER,
  TTLSN     TEXT,
  TTLUP     INTEGER,
  TTLDL     INTEGER,
  TTLN1     INTEGER,
  TTLN2     INTEGER,
  TTLC1     TEXT,
  TTLC2     TEXT,
  ORDNU     INTEGER,
  RES       TEXT,
  SUID      TEXT,
  DATEI     TEXT,
  DEVI      TEXT,
  SUCH      TEXT,
  DATEU     TEXT,
  DEVU      TEXT,
  DEFN      INTEGER,               
  JTID_L INTEGER,
  BIID_L INTEGER,
  SYID_L INTEGER,
  CIID_L TEXT 
         )  
      ''');
        await db.execute('''CREATE TABLE TAX_TBL_LNK_TMP AS  SELECT  * FROM TAX_TBL_LNK WHERE 1=2''');
        await db.execute('''CREATE TABLE TAX_VAR_D_TMP AS  SELECT  * FROM TAX_VAR_D WHERE 1=2''');
        await db.execute('''CREATE TABLE TAX_VAR_TMP AS  SELECT  * FROM TAX_VAR WHERE 1=2''');
        await db.execute('''CREATE TABLE TAX_MOV_SIN_TMP AS  SELECT  * FROM TAX_MOV_SIN WHERE 1=2''');
        await db.execute('''CREATE TABLE TAX_LOC_SYS_TMP AS  SELECT  * FROM TAX_LOC_SYS WHERE 1=2''');
        await db.execute('''CREATE TABLE TAX_LOC_TMP AS  SELECT  * FROM TAX_LOC WHERE 1=2''');

        await db.execute('''ALTER TABLE BIL_MOV_M ADD COLUMN BMMTX11  REAL''');
        await db.execute('''ALTER TABLE BIL_MOV_M ADD COLUMN BMMTX22  REAL''');
        await db.execute('''ALTER TABLE BIL_MOV_M ADD COLUMN BMMTX33 REAL''');
        await db.execute('''ALTER TABLE BIF_MOV_M ADD COLUMN BMMTX11  REAL''');
        await db.execute('''ALTER TABLE BIF_MOV_M ADD COLUMN BMMTX22  REAL''');
        await db.execute('''ALTER TABLE BIF_MOV_M ADD COLUMN BMMTX33 REAL''');
        await db.execute('''ALTER TABLE ACC_ACC ADD COLUMN  SYST_L INTEGER  DEFAULT 1''');
        await db.execute('''ALTER TABLE ACC_USR ADD COLUMN  SYST_L INTEGER  DEFAULT 1''');
        await db.execute('''ALTER TABLE BIL_MOV_D ADD COLUMN BMDTX11 REAL''');
        await db.execute('''ALTER TABLE BIL_MOV_D ADD COLUMN BMDTX22 REAL''');
        await db.execute('''ALTER TABLE BIL_MOV_D ADD COLUMN BMDTX33 REAL''');
        await db.execute('''ALTER TABLE BIL_MOV_D ADD COLUMN BMDTXA11 REAL''');
        await db.execute('''ALTER TABLE BIL_MOV_D ADD COLUMN BMDTXA22  REAL''');
        await db.execute('''ALTER TABLE BIL_MOV_D ADD COLUMN BMDTXA33  REAL''');
        await db.execute('''ALTER TABLE BIF_MOV_D ADD COLUMN BMDTX11  REAL''');
        await db.execute('''ALTER TABLE BIF_MOV_D ADD COLUMN BMDTX22 REAL''');
        await db.execute('''ALTER TABLE BIF_MOV_D ADD COLUMN BMDTX33 REAL''');
        await db.execute('''ALTER TABLE BIF_MOV_D ADD COLUMN BMDTXA11 REAL''');
        await db.execute('''ALTER TABLE BIF_MOV_D ADD COLUMN BMDTXA22 REAL''');
        await db.execute('''ALTER TABLE BIF_MOV_D ADD COLUMN BMDTXA33 REAL''');



        await db.execute('''ALTER TABLE BIL_MOV_D ADD COLUMN BMDTXT1 REAL''');
        await db.execute('''ALTER TABLE BIL_MOV_D ADD COLUMN BMDTXT2 REAL''');
        await db.execute('''ALTER TABLE BIL_MOV_D ADD COLUMN BMDTXT3 REAL''');
        await db.execute('''ALTER TABLE BIF_MOV_D ADD COLUMN BMDTXT1 REAL''');
        await db.execute('''ALTER TABLE BIF_MOV_D ADD COLUMN BMDTXT2 REAL''');
        await db.execute('''ALTER TABLE BIF_MOV_D ADD COLUMN BMDTXT3 REAL''');

        await db.execute('''INSERT INTO SYN_ORD(SOET,ROW_NUM,SOOR,SOST,JTID_L,BIID_L,SYID_L,CIID_L) values('TAX_TYP_SYS',0,83,1, ${LoginController().JTID},${LoginController().BIID},${LoginController().SYID},'${LoginController().CIID}')''');
        await db.execute('''INSERT INTO SYN_ORD(SOET,ROW_NUM,SOOR,SOST,JTID_L,BIID_L,SYID_L,CIID_L) values('TAX_TYP',0,84,1, ${LoginController().JTID},${LoginController().BIID},${LoginController().SYID},'${LoginController().CIID}')''');
        await db.execute('''INSERT INTO SYN_ORD(SOET,ROW_NUM,SOOR,SOST,JTID_L,BIID_L,SYID_L,CIID_L) values('TAX_TYP_BRA',0,85,1, ${LoginController().JTID},${LoginController().BIID},${LoginController().SYID},'${LoginController().CIID}')''');
        await db.execute('''INSERT INTO SYN_ORD(SOET,ROW_NUM,SOOR,SOST,JTID_L,BIID_L,SYID_L,CIID_L) values('TAX_LOC_SYS',0,89,1, ${LoginController().JTID},${LoginController().BIID},${LoginController().SYID},'${LoginController().CIID}')''');
        await db.execute('''INSERT INTO SYN_ORD(SOET,ROW_NUM,SOOR,SOST,JTID_L,BIID_L,SYID_L,CIID_L) values('TAX_LOC',0,90,1, ${LoginController().JTID},${LoginController().BIID},${LoginController().SYID},'${LoginController().CIID}')''');
        await db.execute('''INSERT INTO SYN_ORD(SOET,ROW_NUM,SOOR,SOST,JTID_L,BIID_L,SYID_L,CIID_L) values('TAX_COD_SYS',0,91,1, ${LoginController().JTID},${LoginController().BIID},${LoginController().SYID},'${LoginController().CIID}')''');
        await db.execute('''INSERT INTO SYN_ORD(SOET,ROW_NUM,SOOR,SOST,JTID_L,BIID_L,SYID_L,CIID_L) values('TAX_COD',0,92,1, ${LoginController().JTID},${LoginController().BIID},${LoginController().SYID},'${LoginController().CIID}')''');
        await db.execute('''INSERT INTO SYN_ORD(SOET,ROW_NUM,SOOR,SOST,JTID_L,BIID_L,SYID_L,CIID_L) values('TAX_COD_SYS_D',0,93,1, ${LoginController().JTID},${LoginController().BIID},${LoginController().SYID},'${LoginController().CIID}')''');
        await db.execute('''INSERT INTO SYN_ORD(SOET,ROW_NUM,SOOR,SOST,JTID_L,BIID_L,SYID_L,CIID_L) values('TAX_SYS',0,94,1, ${LoginController().JTID},${LoginController().BIID},${LoginController().SYID},'${LoginController().CIID}')''');
        await db.execute('''INSERT INTO SYN_ORD(SOET,ROW_NUM,SOOR,SOST,JTID_L,BIID_L,SYID_L,CIID_L) values('TAX_SYS_BRA',0,95,1, ${LoginController().JTID},${LoginController().BIID},${LoginController().SYID},'${LoginController().CIID}')''');
        await db.execute('''INSERT INTO SYN_ORD(SOET,ROW_NUM,SOOR,SOST,JTID_L,BIID_L,SYID_L,CIID_L) values('TAX_SYS_D',0,96,1, ${LoginController().JTID},${LoginController().BIID},${LoginController().SYID},'${LoginController().CIID}')''');
        await db.execute('''INSERT INTO SYN_ORD(SOET,ROW_NUM,SOOR,SOST,JTID_L,BIID_L,SYID_L,CIID_L) values('TAX_VAR',0,97,1, ${LoginController().JTID},${LoginController().BIID},${LoginController().SYID},'${LoginController().CIID}')''');
        await db.execute('''INSERT INTO SYN_ORD(SOET,ROW_NUM,SOOR,SOST,JTID_L,BIID_L,SYID_L,CIID_L) values('TAX_VAR_D',0,98,1, ${LoginController().JTID},${LoginController().BIID},${LoginController().SYID},'${LoginController().CIID}')''');
        await db.execute('''INSERT INTO SYN_ORD(SOET,ROW_NUM,SOOR,SOST,JTID_L,BIID_L,SYID_L,CIID_L) values('TAX_LIN',0,99,1, ${LoginController().JTID},${LoginController().BIID},${LoginController().SYID},'${LoginController().CIID}')''');
        await db.execute('''INSERT INTO SYN_ORD(SOET,ROW_NUM,SOOR,SOST,JTID_L,BIID_L,SYID_L,CIID_L) values('IDE_TYP',0,100,1, ${LoginController().JTID},${LoginController().BIID},${LoginController().SYID},'${LoginController().CIID}')''');
        await db.execute('''INSERT INTO SYN_ORD(SOET,ROW_NUM,SOOR,SOST,JTID_L,BIID_L,SYID_L,CIID_L) values('IDE_LIN',0,101,1, ${LoginController().JTID},${LoginController().BIID},${LoginController().SYID},'${LoginController().CIID}')''');
        await db.execute('''INSERT INTO SYN_ORD(SOET,ROW_NUM,SOOR,SOST,JTID_L,BIID_L,SYID_L,CIID_L) values('TAX_MOV_SIN',0,102,1, ${LoginController().JTID},${LoginController().BIID},${LoginController().SYID},'${LoginController().CIID}')''');
        await db.execute('''INSERT INTO SYN_ORD(SOET,ROW_NUM,SOOR,SOST,JTID_L,BIID_L,SYID_L,CIID_L) values('TAX_TBL_LNK',0,103,1, ${LoginController().JTID},${LoginController().BIID},${LoginController().SYID},'${LoginController().CIID}')''');
        await db.execute('''INSERT INTO SYN_ORD(SOET,ROW_NUM,SOOR,SOST,JTID_L,BIID_L,SYID_L,CIID_L) values('RES_SEC',0,301,1, ${LoginController().JTID},${LoginController().BIID},${LoginController().SYID},'${LoginController().CIID}')''');
        await db.execute('''INSERT INTO SYN_ORD(SOET,ROW_NUM,SOOR,SOST,JTID_L,BIID_L,SYID_L,CIID_L) values('RES_TAB',0,302,1, ${LoginController().JTID},${LoginController().BIID},${LoginController().SYID},'${LoginController().CIID}')''');
        await db.execute('''INSERT INTO SYN_ORD(SOET,ROW_NUM,SOOR,SOST,JTID_L,BIID_L,SYID_L,CIID_L) values('RES_EMP',0,303,1, ${LoginController().JTID},${LoginController().BIID},${LoginController().SYID},'${LoginController().CIID}')''');
        await db.execute('''INSERT INTO SYN_ORD(SOET,ROW_NUM,SOOR,SOST,JTID_L,BIID_L,SYID_L,CIID_L) values('BIF_GRO',0,304,1, ${LoginController().JTID},${LoginController().BIID},${LoginController().SYID},'${LoginController().CIID}')''');
        await db.execute('''INSERT INTO SYN_ORD(SOET,ROW_NUM,SOOR,SOST,JTID_L,BIID_L,SYID_L,CIID_L) values('BIF_GRO2',0,305,1, ${LoginController().JTID},${LoginController().BIID},${LoginController().SYID},'${LoginController().CIID}')''');
        await db.execute('''INSERT INTO SYN_ORD(SOET,ROW_NUM,SOOR,SOST,JTID_L,BIID_L,SYID_L,CIID_L) values('MAT_FOL',0,306,1, ${LoginController().JTID},${LoginController().BIID},${LoginController().SYID},'${LoginController().CIID}')''');
        await db.execute('''INSERT INTO SYN_ORD(SOET,ROW_NUM,SOOR,SOST,JTID_L,BIID_L,SYID_L,CIID_L) values('MAT_DES_M',0,307,1, ${LoginController().JTID},${LoginController().BIID},${LoginController().SYID},'${LoginController().CIID}')''');
        await db.execute('''INSERT INTO SYN_ORD(SOET,ROW_NUM,SOOR,SOST,JTID_L,BIID_L,SYID_L,CIID_L) values('MAT_DES_D',0,308,1, ${LoginController().JTID},${LoginController().BIID},${LoginController().SYID},'${LoginController().CIID}')''');

        await db.execute('''UPDATE BIL_MOV_D SET BMDTX11=BMDTX,BMDTXA11=BMDTXA,BMDTXT1=BMDTXT''');
        await db.execute('''UPDATE BIF_MOV_D SET BMDTX11=BMDTX,BMDTXA11=BMDTXA,BMDTXT1=BMDTXT''');
        await db.execute('''UPDATE BIL_MOV_M SET BMMTX11=BMMTX, TTID1=1''');
        await db.execute('''UPDATE BIF_MOV_M SET BMMTX11=BMMTX, TTID1=1''');

        await db.execute('''
       CREATE TABLE RES_SEC (
  RSID   INTEGER,
  RSNA   TEXT,
  RSNE   TEXT,
  RSHN   TEXT,
  RSST   INTEGER                            DEFAULT 1,
  RSFN   INTEGER,
  RSIN   TEXT,
  BIID   INTEGER,
  ORDNU  INTEGER,
  RES    TEXT,
  DATEI  DATE,
  SUID   TEXT,
  SUCH   TEXT,
  DATEU  DATE,
  DEVI   TEXT,
  DEVU   TEXT,
  DEFN   INTEGER,
  RSN3   TEXT,
  GUID   TEXT,               
  JTID_L INTEGER,
  BIID_L INTEGER,
  SYID_L INTEGER,
  CIID_L TEXT 
         )  
      ''');
        await db.execute('''
       CREATE TABLE RES_TAB (
  RSID   INTEGER,
  RTID   TEXT,
  RTNA   TEXT,
  RTNE   TEXT,
  RTST   INTEGER                            DEFAULT 1,
  RTIN   TEXT,
  BIID   INTEGER,
  ORDNU  INTEGER,
  RES    TEXT,
  DATEI  DATE,
  SUID   TEXT,
  SUCH   TEXT,
  DATEU  DATE,
  DEVI   TEXT,
  DEVU   TEXT,
  DEFN   INTEGER,
  RTN3   TEXT,
  GUID   TEXT,              
  JTID_L INTEGER,
  BIID_L INTEGER,
  SYID_L INTEGER,
  CIID_L TEXT 
         )  
      ''');
        await db.execute('''
       CREATE TABLE RES_EMP (
  REID   INTEGER,
  RSID   INTEGER,
  RENA   TEXT,
  RENE   TEXT,
  REST   INTEGER                            DEFAULT 1,
  REIN   TEXT,
  BIID   INTEGER,
  ORDNU  INTEGER,
  RES    TEXT,
  DATEI  DATE,
  SUID   TEXT,
  SUCH   TEXT,
  DATEU  DATE,
  DEVI   TEXT,
  DEVU   TEXT,
  DEFN   INTEGER,
  REN3   TEXT,
  GUID   TEXT,              
  JTID_L INTEGER,
  BIID_L INTEGER,
  SYID_L INTEGER,
  CIID_L TEXT 
         )  
      ''');
        await db.execute('''
       CREATE TABLE BIF_GRO (
  MGNO  TEXT,
  BGOR  INTEGER,
  BGBR  TEXT,
  BGCR  TEXT,
  BGMA  TEXT,  
  DATEI  DATE,
  SUID   TEXT,
  SUCH   TEXT,
  DATEU  DATE,
  DEVI   TEXT,
  DEVU   TEXT,
  BGST   INTEGER,
  GUID   TEXT,            
  JTID_L INTEGER,
  BIID_L INTEGER,
  SYID_L INTEGER,
  CIID_L TEXT 
         )  
      ''');
        await db.execute('''
       CREATE TABLE BIF_GRO2 (
  MGNO  TEXT,
  BGOR  INTEGER,
  BGBR  TEXT,
  BGCR  TEXT,
  BGMA  TEXT, 
  BGST   INTEGER, 
  DATEI  DATE,
  SUID   TEXT,
  SUCH   TEXT,
  DATEU  DATE,
  DEVI   TEXT,
  DEVU   TEXT,
  GUID   TEXT,            
  JTID_L INTEGER,
  BIID_L INTEGER,
  SYID_L INTEGER,
  CIID_L TEXT 
         )  
      ''');
        await db.execute('''
       CREATE TABLE BIF_MOV_A (
 BMKID  INTEGER,
  BMMID  INTEGER,
  BMMNO  INTEGER,
  RSID   INTEGER,
  RTID   TEXT,
  REID   INTEGER,
  BMATY  INTEGER                             DEFAULT 1,
  GUID   TEXT,
  BDID   INTEGER,
  BMACR  REAL                            DEFAULT 0,
  BMACA  REAL                           DEFAULT 0,
  BCDID  INTEGER,
  GUIDR  TEXT,
  BMADD  DATE                                   DEFAULT SYSDATE,
  BMADT  REAL                        DEFAULT 0,
  PKIDB  INTEGER                            DEFAULT 1,
  GUIDP  TEXT,              
  JTID_L INTEGER,
  BIID_L INTEGER,
  SYID_L INTEGER,
  CIID_L TEXT 
         )  
      ''');
        await db.execute('''
       CREATE TABLE MAT_FOL (
 BIID  INTEGER,
  MGNO  TEXT,
  MINO  TEXT,
  MUID   INTEGER,
  MFNO   REAL,
  MGNOF   TEXT,
  MINOF  TEXT ,
  MUIDF   INTEGER,
  MFNOF   REAL,
  MFDO  TEXT,
  MFIN  TEXT,
  MFST  INTEGER,
  MFID  INTEGER ,
  DATEI  DATE,
  SUID   TEXT,
  SUCH   TEXT,
  DATEU  DATE,
  DEVI   TEXT,
  DEVU   TEXT,
  GUID   TEXT,            
  JTID_L INTEGER,
  BIID_L INTEGER,
  SYID_L INTEGER,
  CIID_L TEXT 
         )  
      ''');
        await db.execute('''
       CREATE TABLE MAT_DES_M (
  MDMID  INTEGER,
  MDMNA  TEXT,
  MDMNE  TEXT,
  MDMN3  TEXT,
  MDMDE  TEXT,
  MGNOT  INTEGER                                 DEFAULT 1,
  MDMST  INTEGER                                 DEFAULT 1,
  ORDNU  INTEGER,
  RES    TEXT,
  SUID   TEXT,
  DATEI  DATE,
  DEVI   TEXT,
  SUCH   TEXT,
  DATEU  DATE,
  DEVU   TEXT,
  DEFN   INTEGER,
  GUID   TEXT,
  JTID_L INTEGER,
  BIID_L INTEGER,
  SYID_L INTEGER,
  CIID_L TEXT 
         )  
      ''');
        await db.execute('''
       CREATE TABLE MAT_DES_D (
   MDDID  INTEGER,
  MDMID  INTEGER,
  MGNO   TEXT,
  MINO   TEXT,
  MDDST  INTEGER                                 DEFAULT 1,
  ORDNU  INTEGER,
  RES    TEXT,
  SUID   TEXT,
  DATEI  DATE,
  DEVI   TEXT,
  SUCH   TEXT,
  DATEU  DATE,
  DEVU   TEXT,
  DEFN   INTEGER                                 DEFAULT 2,
  GUID   TEXT,
  JTID_L INTEGER,
  BIID_L INTEGER,
  SYID_L INTEGER,
  CIID_L TEXT 
         )  
      ''');
        await db.execute('''CREATE TABLE MAT_DES_M_TMP AS  SELECT  * FROM MAT_DES_M WHERE 1=2''');
        await db.execute('''CREATE TABLE MAT_DES_D_TMP AS  SELECT  * FROM MAT_DES_D WHERE 1=2''');
        await db.execute('''CREATE TABLE MAT_FOL_TMP AS  SELECT  * FROM MAT_FOL WHERE 1=2''');
        await db.execute('''CREATE TABLE RES_TAB_TMP AS  SELECT  * FROM RES_TAB WHERE 1=2''');
        await db.execute('''CREATE TABLE RES_SEC_TMP AS  SELECT  * FROM RES_SEC WHERE 1=2''');
        await db.execute('''CREATE TABLE RES_EMP_TMP AS  SELECT  * FROM RES_EMP WHERE 1=2''');
        await db.execute('''CREATE TABLE BIF_GRO_TMP AS  SELECT  * FROM BIF_GRO WHERE 1=2''');
        await db.execute('''CREATE TABLE BIF_GRO2_TMP AS  SELECT  * FROM BIF_GRO2 WHERE 1=2''');
        await db.execute('''CREATE TABLE BIF_MOV_A_TMP AS  SELECT  * FROM BIF_MOV_A WHERE 1=2''');

        await db.execute('''ALTER TABLE BIF_MOV_M ADD COLUMN  BMMGR  TEXT''');
        await db.execute('''ALTER TABLE BIF_CUS_D ADD COLUMN  SYST_L INTEGER  DEFAULT 1''');
        await db.execute('''ALTER TABLE BIF_CUS_D ADD COLUMN  BCDDL_L INTEGER  DEFAULT 1''');
        await db.execute('''ALTER TABLE BIF_CUS_D_TMP ADD COLUMN  SYST_L INTEGER  DEFAULT 1''');
        await db.execute('''ALTER TABLE BIF_CUS_D_TMP ADD COLUMN  BCDDL_L INTEGER  DEFAULT 1''');
        await db.execute('''ALTER TABLE ACC_ACC_TMP ADD COLUMN  SYST_L INTEGER  DEFAULT 1''');
        await db.execute('''ALTER TABLE ACC_USR_TMP ADD COLUMN  SYST_L INTEGER  DEFAULT 1''');

        await db.execute('''ALTER TABLE BIL_POI_TMP ADD COLUMN BPSEO INTEGER''');
        await db.execute('''ALTER TABLE BIL_POI_TMP ADD COLUMN BPIDT INTEGER''');
        await db.execute('''ALTER TABLE BIL_POI_TMP ADD COLUMN BPIDV TEXT''');
        await db.execute('''ALTER TABLE TAX_SYS_BRA_TMP ADD COLUMN  SUID TEXT  ''');
        await db.execute('''ALTER TABLE TAX_SYS_BRA_TMP ADD COLUMN  DATEI TEXT ''');
        await db.execute('''ALTER TABLE TAX_SYS_BRA_TMP ADD COLUMN  DEVI TEXT  ''');
        await db.execute('''ALTER TABLE TAX_SYS_BRA_TMP ADD COLUMN  SUCH TEXT  ''');
        await db.execute('''ALTER TABLE TAX_SYS_BRA_TMP ADD COLUMN  DATEU TEXT ''');
        await db.execute('''ALTER TABLE TAX_SYS_BRA_TMP ADD COLUMN  DEVU TEXT  ''');
        await db.execute('''ALTER TABLE BIF_MOV_M ADD COLUMN  BMMDE  TEXT  ''');
        await db.execute('''CREATE TABLE MAT_INF_D_TMP AS  SELECT  * FROM MAT_INF_D WHERE 1=2''');
        await db.execute('''
       CREATE TABLE MAT_DIS_T (
   MDTID  INTEGER,
  MDTNA  TEXT,
  MDTNE  TEXT,
  MDTN3  TEXT,
  MDTST  INTEGER                             DEFAULT 1,
  SUID   TEXT,
  DATEI  DATE,
  SUCH   TEXT,
  DATEU  DATE,
  GUID   TEXT,
    DEVI   TEXT,
  DEVU   TEXT,
  JTID_L INTEGER,
  BIID_L INTEGER,
  SYID_L INTEGER,
  CIID_L TEXT 
         )  
      ''');
        await db.execute('''
       CREATE TABLE MAT_DIS_K (
   MDKID  INTEGER,
  MDTID  INTEGER                             DEFAULT 0,
  MDKNA  TEXT,
  MDKNE  TEXT,
  MDKN3  TEXT,
  MDKST  INTEGER                             DEFAULT 1,
  SUID   TEXT,
  DATEI  DATE,
  SUCH   TEXT,
  DATEU  DATE,
  GUID   TEXT,
    DEVI   TEXT,
  DEVU   TEXT,
  JTID_L INTEGER,
  BIID_L INTEGER,
  SYID_L INTEGER,
  CIID_L TEXT 
         )  
      ''');
        await db.execute('''
       CREATE TABLE MAT_DIS_M (
    GUID     TEXT,
  MDMID    INTEGER,
  MDTID    INTEGER,
  MDKID    INTEGER,
  MDMRA    REAL                               DEFAULT 0,
  MDMSM    INTEGER                          DEFAULT 1,
  MDMCO    REAL                               DEFAULT 0,
  MDMAM    REAL                               DEFAULT 0,
  MDMMN    REAL                               DEFAULT 0,
  MDMCR    INTEGER                           DEFAULT 0,
  MDMCR2   INTEGER,
  MDMCR3   INTEGER,
  MDMOI    INTEGER                         DEFAULT 0,
  MDMFD    DATE,
  MDMTD    DATE,
  MDMFDA   INTEGER,
  MDMTDA   INTEGER,
  MDMFM    INTEGER,
  MDMTM    INTEGER,
  MDMFY    INTEGER,
  MDMTY    INTEGER,
  MDMFT    INTEGER,
  MDMTT    INTEGER,
  MDMDAYT  INTEGER                           DEFAULT 0,
  MDMDAY   TEXT,
  MDMST    INTEGER                         DEFAULT 1,
  MDMDE    TEXT,
  MDMRE    TEXT,
  SUID     TEXT,
  DATEI    DATE,
  SUCH     TEXT,
  DATEU    DATE,
    DEVI   TEXT,
  DEVU   TEXT,
  JTID_L INTEGER,
  BIID_L INTEGER,
  SYID_L INTEGER,
  CIID_L TEXT 
         )  
      ''');
        await db.execute('''
       CREATE TABLE MAT_DIS_D (
    GUID   TEXT,
  MDDID  INTEGER,
  MDMID  INTEGER,
  MGNO   TEXT,
  MINO   TEXT,
  MUID   INTEGER,
  MDDRA  REAL,
  MDDNU  REAL                                 DEFAULT 0,
  MDDAM  REAL                                 DEFAULT 0,
  MDDMN  REAL                                 DEFAULT 0,
  MDDSI  INTEGER                            DEFAULT 1,
  MDDST  INTEGER                                 DEFAULT 1,
  SUID   TEXT,
  DATEI  DATE,
  SUCH   TEXT,
  DATEU  DATE,
    DEVI   TEXT,
  DEVU   TEXT,
  JTID_L INTEGER,
  BIID_L INTEGER,
  SYID_L INTEGER,
  CIID_L TEXT 
         )  
      ''');
        await db.execute('''
       CREATE TABLE MAT_DIS_F (
    GUID   TEXT,
  MDFID  INTEGER,
  MDDID  INTEGER,
  MDMID  INTEGER,
  MGNO   TEXT,
  MINO   TEXT,
  MUID   INTEGER,
  MDFFN  INTEGER,
  MDFTN  INTEGER,
  SCID   INTEGER,
  MDFMP  INTEGER,
  MDFRA  INTEGER,
  MDFNU  INTEGER                                 DEFAULT 0,
  MDFAM  INTEGER                                 DEFAULT 0,
  MDFMN  INTEGER                                 DEFAULT 0,
  MDFST  INTEGER                             DEFAULT 1,
  SUID   TEXT,
  DATEI  DATE,
  SUCH   TEXT,
  DATEU  DATE,
    DEVI   TEXT,
  DEVU   TEXT,
  JTID_L INTEGER,
  BIID_L INTEGER,
  SYID_L INTEGER,
  CIID_L TEXT 
         )  
      ''');
        await db.execute('''
       CREATE TABLE MAT_DIS_L (
    GUID   TEXT,
   GUIDM  TEXT,
  GUIDD  TEXT,
  MMMID  INTEGER,
  MDMID  INTEGER,
  MDLST  INTEGER                             DEFAULT 1,
  SUID   TEXT,
  DATEI  DATE,
  SUCH   TEXT,
  DATEU  DATE,
    DEVI   TEXT,
  DEVU   TEXT,
  MCKID  INTEGER,
  JTID_L INTEGER,
  BIID_L INTEGER,
  SYID_L INTEGER,
  CIID_L TEXT 
         )  
      ''');
        await db.execute('''
       CREATE TABLE MAT_DIS_N (
    GUID    TEXT,
  MDNID   INTEGER,
  MMMID   INTEGER,
  MDMID   INTEGER,
  MDDID   INTEGER,
  MDFID   INTEGER,
  GUIDM   TEXT,
  MDNAM   INTEGER                                DEFAULT 0,
  MDNAM2  INTEGER                                DEFAULT 0,
  MDNNU   INTEGER                                DEFAULT 0,
  MDNNU2  INTEGER                                DEFAULT 0,
  MDNMN   INTEGER                                DEFAULT 0,
  MDNMN2  INTEGER                                DEFAULT 0,
  MDNN2   INTEGER                                DEFAULT 0,
  MDNN22  INTEGER                                DEFAULT 0,
  MDNN3   INTEGER                                DEFAULT 0,
  MDNN32  INTEGER                                DEFAULT 0,
  MDNC1   TEXT,
  MDNC2   TEXT,
  MDNST   INTEGER                            DEFAULT 1,
  SUID    TEXT,
  DATEI   DATE,
  SUCH    TEXT,
  DATEU   DATE,
    DEVI   TEXT,
  DEVU   TEXT,
  JTID_L INTEGER,
  BIID_L INTEGER,
  SYID_L INTEGER,
  CIID_L TEXT 
         )  
      ''');
        await db.execute('''
       CREATE TABLE MAT_DIS_S (
      GUID   TEXT,
  MDSST  INTEGER                                 DEFAULT 2,
  MDSRE  TEXT,
  SUID   TEXT,
  DATEI  DATE,
  SUCH   TEXT,
  DATEU  DATE,
    DEVI   TEXT,
  DEVU   TEXT,
  JTID_L INTEGER,
  BIID_L INTEGER,
  SYID_L INTEGER,
  CIID_L TEXT 
         )  
      ''');
        await db.execute('''
       CREATE TABLE SYN_TAS (
       CIID INTEGER,
       JTID INTEGER,
       BIID INTEGER,
       SYID INTEGER,
 GUID    TEXT, 
 STMID   TEXT,
 STKI    TEXT, 
 STTY    TEXT,
 STTB    TEXT,
 STDE    TEXT,
 STDE2   TEXT,
 STDE3   TEXT,
 STFU    TEXT,
 STTU    TEXT,
 STFID   INTEGER,
 STTID   INTEGER,
 STFD    DATE, 
 STTD    DATE,
 STIM    INTEGER DEFAULT 2, 
 STST    INTEGER DEFAULT 1, 
 SUID    TEXT, 
 DATEI   DATE, 
 DEVI    TEXT,
 SUCH    TEXT,
 DATEU   DATE, 
 DEVU    TEXT,
  JTID_L INTEGER,
  BIID_L INTEGER,
  SYID_L INTEGER,
  CIID_L TEXT 
         )  
      ''');
        await db.execute('''CREATE TABLE MAT_DIS_T_TMP AS SELECT  * FROM MAT_DIS_T WHERE 1=2''');
        await db.execute('''CREATE TABLE MAT_DIS_K_TMP AS SELECT  * FROM MAT_DIS_K WHERE 1=2''');
        await db.execute('''CREATE TABLE MAT_DIS_M_TMP AS SELECT  * FROM MAT_DIS_M WHERE 1=2''');
        await db.execute('''CREATE TABLE MAT_DIS_D_TMP AS SELECT  * FROM MAT_DIS_D WHERE 1=2''');
        await db.execute('''CREATE TABLE MAT_DIS_F_TMP AS SELECT  * FROM MAT_DIS_F WHERE 1=2''');
        await db.execute('''CREATE TABLE MAT_DIS_L_TMP AS SELECT  * FROM MAT_DIS_L WHERE 1=2''');
        await db.execute('''CREATE TABLE MAT_DIS_N_TMP AS SELECT  * FROM MAT_DIS_N WHERE 1=2''');
        await db.execute('''CREATE TABLE MAT_DIS_S_TMP AS SELECT  * FROM MAT_DIS_S WHERE 1=2''');
        await db.execute('''CREATE TABLE SYN_TAS_TMP AS SELECT  * FROM SYN_TAS WHERE 1=2''');

        await db.execute(''' CREATE  INDEX MAT_DIS_M_I1 ON MAT_DIS_M(MDMID,JTID_L,SYID_L,CIID_L)''');
        await db.execute(''' CREATE  INDEX MAT_DIS_D_I1 ON MAT_DIS_D(MDDID,JTID_L,SYID_L,CIID_L)''');

        await db.execute('''ALTER TABLE CONFIG ADD COLUMN  STMID TEXT  ''');
        await db.execute('''ALTER TABLE CONFIG ADD COLUMN  SYDV_NAME TEXT  ''');
        await db.execute('''ALTER TABLE CONFIG ADD COLUMN  SYDV_TY TEXT  ''');
        await db.execute('''ALTER TABLE CONFIG ADD COLUMN  SYDV_SER TEXT ''');
        await db.execute('''ALTER TABLE CONFIG ADD COLUMN  SYDV_ID TEXT ''');
        await db.execute('''ALTER TABLE CONFIG ADD COLUMN SYDV_NO TEXT ''');
        await db.execute('''ALTER TABLE CONFIG ADD COLUMN SYDV_IP TEXT ''');
        await db.execute('''ALTER TABLE CONFIG ADD COLUMN SYDV_APPV TEXT ''');

        await db.execute('''ALTER TABLE BIL_CUS ADD COLUMN BCLON TEXT''');
        await db.execute('''ALTER TABLE BIL_CUS ADD COLUMN BCLAT TEXT''');
        await db.execute('''ALTER TABLE BIL_CUS ADD COLUMN BILON TEXT''');
        await db.execute('''ALTER TABLE BIL_CUS_TMP ADD COLUMN BCLON TEXT''');
        await db.execute('''ALTER TABLE BIL_CUS_TMP ADD COLUMN BILON TEXT''');
        await db.execute('''ALTER TABLE BIL_CUS_TMP ADD COLUMN BCLAT TEXT''');

        await db.execute('''ALTER TABLE BIL_IMP ADD COLUMN BILON TEXT''');
        await db.execute('''ALTER TABLE BIL_IMP ADD COLUMN BILAT TEXT''');
        await db.execute('''ALTER TABLE BIL_IMP ADD COLUMN BICR INTEGER''');
        await db.execute('''ALTER TABLE BIL_IMP_TMP ADD COLUMN BICR INTEGER''');
        await db.execute('''ALTER TABLE BIL_IMP_TMP ADD COLUMN BILON TEXT''');
        await db.execute('''ALTER TABLE BIL_IMP_TMP ADD COLUMN BILAT TEXT''');

        await db.execute('''ALTER TABLE BIF_CUS_D ADD COLUMN BCDLON TEXT''');
        await db.execute('''ALTER TABLE BIF_CUS_D ADD COLUMN BCDLAT TEXT''');
        await db.execute('''ALTER TABLE BIF_CUS_D_TMP ADD COLUMN BCDLON TEXT''');
        await db.execute('''ALTER TABLE BIF_CUS_D_TMP ADD COLUMN BCDLAT TEXT''');

        await db.execute('''ALTER TABLE BIL_MOV_M ADD COLUMN BMMLON TEXT''');
        await db.execute('''ALTER TABLE BIL_MOV_M ADD COLUMN BMMLAT TEXT''');
        await db.execute('''ALTER TABLE BIF_MOV_M ADD COLUMN BMMLON TEXT''');
        await db.execute('''ALTER TABLE BIF_MOV_M ADD COLUMN BMMLAT TEXT''');

        await db.execute('''ALTER TABLE PAY_KIN ADD COLUMN  PKTY INTEGER''');
        await db.execute('''ALTER TABLE PAY_KIN_TMP ADD COLUMN  PKTY INTEGER''');
        await db.execute('''UPDATE PAY_KIN SET PKTY=1 WHERE PKID IN(1,2,5,8,9)''');
        await db.execute('''UPDATE PAY_KIN SET PKTY=2 WHERE PKID IN(3,4,10,11)''');
        await db.execute('''UPDATE PAY_KIN SET PKTY=3 WHERE PKID NOT IN(1,2,5,8,9,3,4,10,11)''');

        //2023-11-22
        await db.execute('''
       CREATE TABLE MAT_MAI_M (
       GUID    TEXT,
  MMMID   INTEGER,
  MMMDE   TEXT,
  BIIDT   INTEGER                                DEFAULT 0,
  BIID    TEXT,
  MMMBLT  INTEGER                                DEFAULT 0,
  MMMBL   TEXT,
  PKIDT   INTEGER                                DEFAULT 0,
  PKID    TEXT,
  BCCIDT  INTEGER                                DEFAULT 0,
  BCCID   TEXT,
  SCIDT   INTEGER                                DEFAULT 0,
  SCID    TEXT,
  BCTIDT  INTEGER                                DEFAULT 0,
  BCTID   TEXT,
  BCIDT   INTEGER                                DEFAULT 0,
  BCDIDT  INTEGER                                DEFAULT 0,
  CIIDT   INTEGER                                DEFAULT 0,
  ECIDT   INTEGER                                DEFAULT 0,
  SIIDT   INTEGER                                DEFAULT 0,
  SIID    TEXT,
  ACNOT   INTEGER                                DEFAULT 0,
  ACNO    TEXT,
  SUIDT   INTEGER                                DEFAULT 0,
  SUIDV   TEXT,
  MMMFD   DATE,
  MMMTD   DATE,
  MMMFT   INTEGER,
  MMMTT   INTEGER,
  MMMDAY  TEXT,
  ORDNU   INTEGER,
  SUID    TEXT,
  DATEI   DATE,
  SUCH    TEXT,
  DATEU   DATE,
  MMMST   INTEGER                                DEFAULT 1,
  DEVI    TEXT,
  DEVU    TEXT,
  JTID_L INTEGER,
  BIID_L INTEGER,
  SYID_L INTEGER,
  CIID_L TEXT 
         )  
      ''');
        await db.execute('''CREATE TABLE MAT_MAI_M_TMP AS SELECT  * FROM MAT_MAI_M WHERE 1=2''');
        await db.execute('''
       CREATE TABLE BIL_MOV_DD (
       BMDSQ   INTEGER,
  BMKID   INTEGER,
  BMMID   INTEGER,
  BMDID   INTEGER,
  GUID    TEXT,
  MMMID   INTEGER,
  MDMID   INTEGER,
  MDDID   INTEGER,
  MDFID   INTEGER,
  GUIDM   TEXT,
  MDTID   INTEGER                                DEFAULT 2,
  MGNO    TEXT,
  MINO    TEXT,
  MUID    INTEGER,
  BMDAM   REAL                                DEFAULT 0,
  BMDNO   REAL                                DEFAULT 0,
  BMDRE   REAL                                DEFAULT 0,
  BMDN1   INTEGER                                DEFAULT 0,
  BMDN2   INTEGER                                DEFAULT 0,
  BMDC1   TEXT,
  BMDC2   TEXT,
  BMDC3   TEXT,
  BMDST   INTEGER                                DEFAULT 1,
  BMDSQR  INTEGER,
  MCKID   INTEGER                                DEFAULT 1,
  MCDID   INTEGER,
  JTID_L INTEGER,
  BIID_L INTEGER,
  SYID_L INTEGER,
  CIID_L TEXT 
         )  
      ''');
        await db.execute('''
       CREATE TABLE BIL_MOV_MD (
      BMMSQ   INTEGER,
  BMKID   INTEGER,
  BMMID   INTEGER,
  GUID    TEXT,
  MMMID   INTEGER,
  MDMID   INTEGER,
  MDDID   INTEGER,
  MDFID   INTEGER,
  GUIDM   TEXT,
  BMMAM   REAL                                DEFAULT 0,
  BMMNO   REAL                                DEFAULT 0,
  BMMRE   REAL                                DEFAULT 0,
  BMMN1   INTEGER                                DEFAULT 0,
  BMMN2   INTEGER                                DEFAULT 0,
  BMMN3   INTEGER                                DEFAULT 0,
  BMMC1   TEXT,
  BMMC2   TEXT,
  BMMC3   TEXT,
  BMMC4   TEXT,
  BMMC5   TEXT,
  BMMST   INTEGER                                DEFAULT 1,
  BMMSQR  INTEGER,
  MCKID   INTEGER                                DEFAULT 1,
  MCDID   INTEGER,
  JTID_L INTEGER,
  BIID_L INTEGER,
  SYID_L INTEGER,
  CIID_L TEXT 
         )  
      ''');
        await db.execute('''
       CREATE TABLE BIF_MOV_DD (
       BMDSQ   INTEGER,
  BMKID   INTEGER,
  BMMID   INTEGER,
  BMDID   INTEGER,
  GUID    TEXT,
  MMMID   INTEGER,
  MDMID   INTEGER,
  MDDID   INTEGER,
  MDFID   INTEGER,
  GUIDM   TEXT,
  MDTID   INTEGER                                DEFAULT 2,
  MGNO    TEXT,
  MINO    TEXT,
  MUID    INTEGER,
  BMDAM   REAL                                DEFAULT 0,
  BMDNO   REAL                                DEFAULT 0,
  BMDRE   REAL                                DEFAULT 0,
  BMDN1   INTEGER                                DEFAULT 0,
  BMDN2   INTEGER                                DEFAULT 0,
  BMDC1   TEXT,
  BMDC2   TEXT,
  BMDC3   TEXT,
  BMDST   INTEGER                                DEFAULT 1,
  BMDSQR  INTEGER,
  MCKID   INTEGER                                DEFAULT 1,
  MCDID   INTEGER,
  JTID_L INTEGER,
  BIID_L INTEGER,
  SYID_L INTEGER,
  CIID_L TEXT 
         )  
      ''');
        await db.execute('''
       CREATE TABLE BIF_MOV_MD (
      BMMSQ   INTEGER,
  BMKID   INTEGER,
  BMMID   INTEGER,
  GUID    TEXT,
  MMMID   INTEGER,
  MDMID   INTEGER,
  MDDID   INTEGER,
  MDFID   INTEGER,
  GUIDM   TEXT,
  BMMAM   REAL                                DEFAULT 0,
  BMMNO   REAL                                DEFAULT 0,
  BMMRE   REAL                                DEFAULT 0,
  BMMN1   INTEGER                                DEFAULT 0,
  BMMN2   INTEGER                                DEFAULT 0,
  BMMN3   INTEGER                                DEFAULT 0,
  BMMC1   TEXT,
  BMMC2   TEXT,
  BMMC3   TEXT,
  BMMC4   TEXT,
  BMMC5   TEXT,
  BMMST   INTEGER                                DEFAULT 1,
  BMMSQR  INTEGER,
  MCKID   INTEGER                                DEFAULT 1,
  MCDID   INTEGER,
  JTID_L INTEGER,
  BIID_L INTEGER,
  SYID_L INTEGER,
  CIID_L TEXT 
         )  
      ''');

        //2023-11-24
        await db.execute('''INSERT INTO SYN_ORD(SOET,ROW_NUM,SOOR,SOST,JTID_L,BIID_L,SYID_L,CIID_L) values('MAT_DIS_T',0,309,1, ${LoginController().JTID},${LoginController().BIID},${LoginController().SYID},'${LoginController().CIID}')''');
        await db.execute('''INSERT INTO SYN_ORD(SOET,ROW_NUM,SOOR,SOST,JTID_L,BIID_L,SYID_L,CIID_L) values('MAT_DIS_K',0,310,1, ${LoginController().JTID},${LoginController().BIID},${LoginController().SYID},'${LoginController().CIID}')''');
        await db.execute('''INSERT INTO SYN_ORD(SOET,ROW_NUM,SOOR,SOST,JTID_L,BIID_L,SYID_L,CIID_L) values('MAT_DIS_M',0,311,1, ${LoginController().JTID},${LoginController().BIID},${LoginController().SYID},'${LoginController().CIID}')''');
        await db.execute('''INSERT INTO SYN_ORD(SOET,ROW_NUM,SOOR,SOST,JTID_L,BIID_L,SYID_L,CIID_L) values('MAT_DIS_D',0,312,1, ${LoginController().JTID},${LoginController().BIID},${LoginController().SYID},'${LoginController().CIID}')''');
        await db.execute('''INSERT INTO SYN_ORD(SOET,ROW_NUM,SOOR,SOST,JTID_L,BIID_L,SYID_L,CIID_L) values('MAT_DIS_F',0,313,1, ${LoginController().JTID},${LoginController().BIID},${LoginController().SYID},'${LoginController().CIID}')''');
        await db.execute('''INSERT INTO SYN_ORD(SOET,ROW_NUM,SOOR,SOST,JTID_L,BIID_L,SYID_L,CIID_L) values('MAT_DIS_L',0,314,1, ${LoginController().JTID},${LoginController().BIID},${LoginController().SYID},'${LoginController().CIID}')''');
        await db.execute('''INSERT INTO SYN_ORD(SOET,ROW_NUM,SOOR,SOST,JTID_L,BIID_L,SYID_L,CIID_L) values('MAT_DIS_N',0,315,1, ${LoginController().JTID},${LoginController().BIID},${LoginController().SYID},'${LoginController().CIID}')''');
        await db.execute('''INSERT INTO SYN_ORD(SOET,ROW_NUM,SOOR,SOST,JTID_L,BIID_L,SYID_L,CIID_L) values('MAT_MAI_M',0,316,1, ${LoginController().JTID},${LoginController().BIID},${LoginController().SYID},'${LoginController().CIID}')''');
        //2023-11-25
        await db.execute('''UPDATE BIL_MOV_M SET BMMST2=1 WHERE BMMST=1''');
        await db.execute('''UPDATE BIF_MOV_M SET BMMST2=1 WHERE BMMST=1''');

        await OnUpgradeV446(db);
        await OnUpgradeV446_9(db);
        await OnUpgradeV448_10(db);
        await OnUpgradeV449_11(db);
        await OnUpgradeV449_12(db);
        await  OnUpgradeV449_13(db);
        await OnUpgradeV449_14(db);
        await OnUpgradeV449_15(db);
        await OnUpgradeV449_16(db);
        await OnUpgradeV449_17(db);

        print(oldversion);
        print(newversion);
        print("oldversion");
      }

      else  if (oldversion == 4) {
        await db.execute('''
       CREATE TABLE TAX_LOC (
   TLID   INTEGER,
  GUID  TEXT ,
  TLSY   TEXT,
  TLNA   TEXT ,
  TLNE   TEXT,
  TLN3  TEXT,
  TTID  INTEGER                             DEFAULT 0,
  CWID  INTEGER                             DEFAULT 1,
  CTID  INTEGER,
  TLST   INTEGER,
  TLDE   TEXT,
  AANOO  TEXT,
  AANOI  TEXT,
  AANOR   TEXT,
  AANORR   TEXT,
  TLDC  INTEGER,
  ORDNU  INTEGER,
  RES  TEXT,
  SUID  TEXT,
  DATEI  TEXT,
  DEVI  TEXT,
  SUCH  TEXT,
  DATEU  TEXT,
  DEVU  TEXT,
  DEFN INTEGER,
  JTID_L INTEGER,
  BIID_L INTEGER,
  SYID_L INTEGER,
  CIID_L TEXT 
         )  
      ''');
        await db.execute('''
       CREATE TABLE TAX_LOC_SYS (
   TLSID   INTEGER,
  TLID    INTEGER,
  STID    TEXT,
  GUID    TEXT,
  AANOO   TEXT,
  AANOI   TEXT,
  AANOR   TEXT,
  AANORR  TEXT,
  TLSDC   INTEGER,
  ORDNU   INTEGER,
  RES     TEXT,
  SUID    TEXT,
  DATEI   TEXT ,
  DEVI    TEXT,
  SUCH    TEXT,
  DATEU   TEXT,
  DEVU    TEXT,
  DEFN    INTEGER ,
  JTID_L INTEGER,
  BIID_L INTEGER,
  SYID_L INTEGER,
  CIID_L TEXT 
         )  
      ''');
        await db.execute('''
       CREATE TABLE TAX_MOV_SIN (
  TMSID   INTEGER,
  GUID    TEXT,
  TMSNA   TEXT,
  TMSNE   TEXT,
  TMSN3   TEXT,
  TMSSY   TEXT,
  TMSST   INTEGER                                DEFAULT 1,
  TMSDE   TEXT,
  TMSDE2  TEXT,
  TTID    INTEGER,
  TCID    INTEGER,
  TCSID   INTEGER,
  TCSSY   TEXT,
  TCSDSY  TEXT,
  TMSIT   INTEGER                                DEFAULT 1,
  TMSAC   INTEGER                                DEFAULT 2,
  TMSCO   TEXT,
  TMSDL   INTEGER                                DEFAULT 1,
  TMSUP   INTEGER                                DEFAULT 1,
  ORDNU   INTEGER,
  RES     TEXT,
  SUID    TEXT,
  DATEI   TEXT,
  DEVI    TEXT,
  SUCH    TEXT,
  DATEU   TEXT,
  DEVU    TEXT,
  DEFN    INTEGER ,
  JTID_L INTEGER,
  BIID_L INTEGER,
  SYID_L INTEGER,
  CIID_L TEXT 
         )  
      ''');
        await db.execute('''
       CREATE TABLE TAX_VAR (
 TVID   INTEGER,
  TVSY   TEXT,
  TVNA   TEXT,
  TVNE   TEXT,
  TVN3   TEXT,
  TVVL   TEXT,
  TVDT   TEXT,
  TVDS   TEXT,
  TVDH   INTEGER,
  TVDA   INTEGER,
  TVAD   INTEGER ,
  STID   TEXT,
  STMID  TEXT,
  PRID   TEXT,
  PRIDY  TEXT,
  PRIDN  TEXT,
  TVDAC  INTEGER,
  TVCH   INTEGER,
  TVDL   INTEGER,
  TVIDF  INTEGER,
  TVST   INTEGER,
  ORDNU  INTEGER,
  RES   TEXT,
  SUID   TEXT,
  DATEI  TEXT,
  DEVI   TEXT,
  SUCH   TEXT,
  DATEU  TEXT,
  DEVU   TEXT,
  DEFN   INTEGER,
  GUID   TEXT,
  JTID_L INTEGER,
  BIID_L INTEGER,
  SYID_L INTEGER,
  CIID_L TEXT 
         )  
      ''');
        await db.execute('''
       CREATE TABLE TAX_VAR_D (
  TVDID   INTEGER,
  TVID    INTEGER,
  TTID    INTEGER,
  TVDSY   TEXT,
  TVDTY   INTEGER,
  TVDVL   TEXT,
  TVDDA   DATE,
  STID    TEXT,
  STMID   TEXT,
  PRID    TEXT,
  PRIDY   TEXT,
  PRIDN   TEXT,
  TVDCH   INTEGER,
  TVDIDF  INTEGER,
  TVDST   INTEGER,
  ORDNU   INTEGER,
  RES     TEXT,
  SUID    TEXT,
  DATEI   TEXT,
  DEVI    TEXT,
  SUCH    TEXT,
  DATEU   TEXT,
  DEVU    TEXT,
  DEFN    INTEGER ,
  GUID   TEXT,
  JTID_L INTEGER,
  BIID_L INTEGER,
  SYID_L INTEGER,
  CIID_L TEXT 
         )  
      ''');
        await db.execute('''
       CREATE TABLE TAX_TBL_LNK (
TTLID     INTEGER,
  GUID     TEXT,
  TTID      INTEGER,
  TTLNA     TEXT,
  TTLNE     TEXT,
  TTLN3     TEXT,
  STID     TEXT,
  TTLTB     TEXT,
  TTLNO    TEXT,
  TTLNO2   TEXT,
  TTLSY     TEXT,
  TTLNOL   TEXT,
  TTLNO2L  TEXT,
  TTLSY2    TEXT,
  TTLNOL2  TEXT,
  TTLNO2L2 TEXT,
  TTLST     INTEGER,
  TTLCO    TEXT,
  TTLLN     INTEGER,
  TTLHN     INTEGER,
  TTLDE     TEXT,
  TTLVB     INTEGER,
  TTLVN     INTEGER,
  TTLVF     INTEGER,
  TTLSN     TEXT,
  TTLUP     INTEGER,
  TTLDL     INTEGER,
  TTLN1     INTEGER,
  TTLN2     INTEGER,
  TTLC1     TEXT,
  TTLC2     TEXT,
  ORDNU     INTEGER,
  RES       TEXT,
  SUID      TEXT,
  DATEI     TEXT,
  DEVI      TEXT,
  SUCH      TEXT,
  DATEU     TEXT,
  DEVU      TEXT,
  DEFN      INTEGER,               
  JTID_L INTEGER,
  BIID_L INTEGER,
  SYID_L INTEGER,
  CIID_L TEXT 
         )  
      ''');
        await db.execute('''CREATE TABLE TAX_TBL_LNK_TMP AS  SELECT  * FROM TAX_TBL_LNK WHERE 1=2''');
        await db.execute('''CREATE TABLE TAX_VAR_D_TMP AS  SELECT  * FROM TAX_VAR_D WHERE 1=2''');
        await db.execute('''CREATE TABLE TAX_VAR_TMP AS  SELECT  * FROM TAX_VAR WHERE 1=2''');
        await db.execute('''CREATE TABLE TAX_MOV_SIN_TMP AS  SELECT  * FROM TAX_MOV_SIN WHERE 1=2''');
        await db.execute('''CREATE TABLE TAX_LOC_SYS_TMP AS  SELECT  * FROM TAX_LOC_SYS WHERE 1=2''');
        await db.execute('''CREATE TABLE TAX_LOC_TMP AS  SELECT  * FROM TAX_LOC WHERE 1=2''');

        await db.execute('''ALTER TABLE BIF_MOV_M ADD COLUMN BMMST2 INTEGER DEFAULT 2''');
        await db.execute('''ALTER TABLE BIL_MOV_M ADD COLUMN BMMST2 INTEGER DEFAULT 2''');
        await db.execute('''ALTER TABLE BIL_MOV_M ADD COLUMN BMMTX11  REAL''');
        await db.execute('''ALTER TABLE BIL_MOV_M ADD COLUMN BMMTX22  REAL''');
        await db.execute('''ALTER TABLE BIL_MOV_M ADD COLUMN BMMTX33 REAL''');
        await db.execute('''ALTER TABLE BIF_MOV_M ADD COLUMN BMMTX11  REAL''');
        await db.execute('''ALTER TABLE BIF_MOV_M ADD COLUMN BMMTX22  REAL''');
        await db.execute('''ALTER TABLE BIF_MOV_M ADD COLUMN BMMTX33 REAL''');

        await db.execute('''ALTER TABLE BIL_MOV_D ADD COLUMN BMDTX11 REAL''');
        await db.execute('''ALTER TABLE BIL_MOV_D ADD COLUMN BMDTX22 REAL''');
        await db.execute('''ALTER TABLE BIL_MOV_D ADD COLUMN BMDTX33 REAL''');
        await db.execute('''ALTER TABLE BIL_MOV_D ADD COLUMN BMDTXA11 REAL''');
        await db.execute('''ALTER TABLE BIL_MOV_D ADD COLUMN BMDTXA22  REAL''');
        await db.execute('''ALTER TABLE BIL_MOV_D ADD COLUMN BMDTXA33  REAL''');
        await db.execute('''ALTER TABLE BIF_MOV_D ADD COLUMN BMDTX11  REAL''');
        await db.execute('''ALTER TABLE BIF_MOV_D ADD COLUMN BMDTX22 REAL''');
        await db.execute('''ALTER TABLE BIF_MOV_D ADD COLUMN BMDTX33 REAL''');
        await db.execute('''ALTER TABLE BIF_MOV_D ADD COLUMN BMDTXA11 REAL''');
        await db.execute('''ALTER TABLE BIF_MOV_D ADD COLUMN BMDTXA22 REAL''');
        await db.execute('''ALTER TABLE BIF_MOV_D ADD COLUMN BMDTXA33 REAL''');


        await db.execute('''ALTER TABLE BIL_MOV_D ADD COLUMN BMDTXT1 REAL''');
        await db.execute('''ALTER TABLE BIL_MOV_D ADD COLUMN BMDTXT2 REAL''');
        await db.execute('''ALTER TABLE BIL_MOV_D ADD COLUMN BMDTXT3 REAL''');
        await db.execute('''ALTER TABLE BIF_MOV_D ADD COLUMN BMDTXT1 REAL''');
        await db.execute('''ALTER TABLE BIF_MOV_D ADD COLUMN BMDTXT2 REAL''');
        await db.execute('''ALTER TABLE BIF_MOV_D ADD COLUMN BMDTXT3 REAL''');
        await db.execute('''ALTER TABLE ACC_ACC ADD COLUMN  SYST_L INTEGER  DEFAULT 1''');
        await db.execute('''ALTER TABLE ACC_USR ADD COLUMN  SYST_L INTEGER  DEFAULT 1''');

        await db.execute('''ALTER TABLE BIL_POI ADD COLUMN BPSEO INTEGER''');
        await db.execute('''ALTER TABLE BIL_POI ADD COLUMN BPIDT INTEGER''');
        await db.execute('''ALTER TABLE BIL_POI ADD COLUMN BPIDV TEXT''');

        await db.execute('''ALTER TABLE TAX_SYS_BRA ADD COLUMN  SUID TEXT  ''');
        await db.execute('''ALTER TABLE TAX_SYS_BRA ADD COLUMN  DATEI TEXT ''');
        await db.execute('''ALTER TABLE TAX_SYS_BRA ADD COLUMN  DEVI TEXT  ''');
        await db.execute('''ALTER TABLE TAX_SYS_BRA ADD COLUMN  SUCH TEXT  ''');
        await db.execute('''ALTER TABLE TAX_SYS_BRA ADD COLUMN  DATEU TEXT ''');
        await db.execute('''ALTER TABLE TAX_SYS_BRA ADD COLUMN  DEVU TEXT  ''');

        await db.execute(''' CREATE  INDEX TAX_LIN_I3 ON TAX_LIN(TTID,TLTY,TLNO,TLNO2,JTID_L,BIID_L,SYID_L,CIID_L)''');
        await db.execute(''' CREATE  INDEX TAX_LIN_I4 ON TAX_LIN(TTID,TCIDI,TLTY,TLNO,TLNO2,JTID_L,BIID_L,SYID_L,CIID_L)''');
        await db.execute(''' CREATE  INDEX TAX_LIN_I5 ON TAX_LIN(TTID,TCIDO,TLTY,TLNO,TLNO2,JTID_L,BIID_L,SYID_L,CIID_L)''');

        await db.execute('''INSERT INTO SYN_ORD(SOET,ROW_NUM,SOOR,SOST,JTID_L,BIID_L,SYID_L,CIID_L) values('TAX_TYP_SYS',0,83,1, ${LoginController().JTID},${LoginController().BIID},${LoginController().SYID},'${LoginController().CIID}')''');
        await db.execute('''INSERT INTO SYN_ORD(SOET,ROW_NUM,SOOR,SOST,JTID_L,BIID_L,SYID_L,CIID_L) values('TAX_TYP',0,84,1, ${LoginController().JTID},${LoginController().BIID},${LoginController().SYID},'${LoginController().CIID}')''');
        await db.execute('''INSERT INTO SYN_ORD(SOET,ROW_NUM,SOOR,SOST,JTID_L,BIID_L,SYID_L,CIID_L) values('TAX_TYP_BRA',0,85,1, ${LoginController().JTID},${LoginController().BIID},${LoginController().SYID},'${LoginController().CIID}')''');
        await db.execute('''INSERT INTO SYN_ORD(SOET,ROW_NUM,SOOR,SOST,JTID_L,BIID_L,SYID_L,CIID_L) values('TAX_LOC_SYS',0,89,1, ${LoginController().JTID},${LoginController().BIID},${LoginController().SYID},'${LoginController().CIID}')''');
        await db.execute('''INSERT INTO SYN_ORD(SOET,ROW_NUM,SOOR,SOST,JTID_L,BIID_L,SYID_L,CIID_L) values('TAX_LOC',0,90,1, ${LoginController().JTID},${LoginController().BIID},${LoginController().SYID},'${LoginController().CIID}')''');
        await db.execute('''INSERT INTO SYN_ORD(SOET,ROW_NUM,SOOR,SOST,JTID_L,BIID_L,SYID_L,CIID_L) values('TAX_COD_SYS',0,91,1, ${LoginController().JTID},${LoginController().BIID},${LoginController().SYID},'${LoginController().CIID}')''');
        await db.execute('''INSERT INTO SYN_ORD(SOET,ROW_NUM,SOOR,SOST,JTID_L,BIID_L,SYID_L,CIID_L) values('TAX_COD',0,92,1, ${LoginController().JTID},${LoginController().BIID},${LoginController().SYID},'${LoginController().CIID}')''');
        await db.execute('''INSERT INTO SYN_ORD(SOET,ROW_NUM,SOOR,SOST,JTID_L,BIID_L,SYID_L,CIID_L) values('TAX_COD_SYS_D',0,93,1, ${LoginController().JTID},${LoginController().BIID},${LoginController().SYID},'${LoginController().CIID}')''');
        await db.execute('''INSERT INTO SYN_ORD(SOET,ROW_NUM,SOOR,SOST,JTID_L,BIID_L,SYID_L,CIID_L) values('TAX_SYS',0,94,1, ${LoginController().JTID},${LoginController().BIID},${LoginController().SYID},'${LoginController().CIID}')''');
        await db.execute('''INSERT INTO SYN_ORD(SOET,ROW_NUM,SOOR,SOST,JTID_L,BIID_L,SYID_L,CIID_L) values('TAX_SYS_BRA',0,95,1, ${LoginController().JTID},${LoginController().BIID},${LoginController().SYID},'${LoginController().CIID}')''');
        await db.execute('''INSERT INTO SYN_ORD(SOET,ROW_NUM,SOOR,SOST,JTID_L,BIID_L,SYID_L,CIID_L) values('TAX_SYS_D',0,96,1, ${LoginController().JTID},${LoginController().BIID},${LoginController().SYID},'${LoginController().CIID}')''');
        await db.execute('''INSERT INTO SYN_ORD(SOET,ROW_NUM,SOOR,SOST,JTID_L,BIID_L,SYID_L,CIID_L) values('TAX_VAR',0,97,1, ${LoginController().JTID},${LoginController().BIID},${LoginController().SYID},'${LoginController().CIID}')''');
        await db.execute('''INSERT INTO SYN_ORD(SOET,ROW_NUM,SOOR,SOST,JTID_L,BIID_L,SYID_L,CIID_L) values('TAX_VAR_D',0,98,1, ${LoginController().JTID},${LoginController().BIID},${LoginController().SYID},'${LoginController().CIID}')''');
        await db.execute('''INSERT INTO SYN_ORD(SOET,ROW_NUM,SOOR,SOST,JTID_L,BIID_L,SYID_L,CIID_L) values('TAX_LIN',0,99,1, ${LoginController().JTID},${LoginController().BIID},${LoginController().SYID},'${LoginController().CIID}')''');
        await db.execute('''INSERT INTO SYN_ORD(SOET,ROW_NUM,SOOR,SOST,JTID_L,BIID_L,SYID_L,CIID_L) values('IDE_TYP',0,100,1, ${LoginController().JTID},${LoginController().BIID},${LoginController().SYID},'${LoginController().CIID}')''');
        await db.execute('''INSERT INTO SYN_ORD(SOET,ROW_NUM,SOOR,SOST,JTID_L,BIID_L,SYID_L,CIID_L) values('IDE_LIN',0,101,1, ${LoginController().JTID},${LoginController().BIID},${LoginController().SYID},'${LoginController().CIID}')''');
        await db.execute('''INSERT INTO SYN_ORD(SOET,ROW_NUM,SOOR,SOST,JTID_L,BIID_L,SYID_L,CIID_L) values('TAX_MOV_SIN',0,102,1, ${LoginController().JTID},${LoginController().BIID},${LoginController().SYID},'${LoginController().CIID}')''');
        await db.execute('''INSERT INTO SYN_ORD(SOET,ROW_NUM,SOOR,SOST,JTID_L,BIID_L,SYID_L,CIID_L) values('TAX_TBL_LNK',0,103,1, ${LoginController().JTID},${LoginController().BIID},${LoginController().SYID},'${LoginController().CIID}')''');
        await db.execute('''INSERT INTO SYN_ORD(SOET,ROW_NUM,SOOR,SOST,JTID_L,BIID_L,SYID_L,CIID_L) values('RES_SEC',0,301,1, ${LoginController().JTID},${LoginController().BIID},${LoginController().SYID},'${LoginController().CIID}')''');
        await db.execute('''INSERT INTO SYN_ORD(SOET,ROW_NUM,SOOR,SOST,JTID_L,BIID_L,SYID_L,CIID_L) values('RES_TAB',0,302,1, ${LoginController().JTID},${LoginController().BIID},${LoginController().SYID},'${LoginController().CIID}')''');
        await db.execute('''INSERT INTO SYN_ORD(SOET,ROW_NUM,SOOR,SOST,JTID_L,BIID_L,SYID_L,CIID_L) values('RES_EMP',0,303,1, ${LoginController().JTID},${LoginController().BIID},${LoginController().SYID},'${LoginController().CIID}')''');
        await db.execute('''INSERT INTO SYN_ORD(SOET,ROW_NUM,SOOR,SOST,JTID_L,BIID_L,SYID_L,CIID_L) values('BIF_GRO',0,304,1, ${LoginController().JTID},${LoginController().BIID},${LoginController().SYID},'${LoginController().CIID}')''');
        await db.execute('''INSERT INTO SYN_ORD(SOET,ROW_NUM,SOOR,SOST,JTID_L,BIID_L,SYID_L,CIID_L) values('BIF_GRO2',0,305,1, ${LoginController().JTID},${LoginController().BIID},${LoginController().SYID},'${LoginController().CIID}')''');
        await db.execute('''INSERT INTO SYN_ORD(SOET,ROW_NUM,SOOR,SOST,JTID_L,BIID_L,SYID_L,CIID_L) values('MAT_FOL',0,306,1, ${LoginController().JTID},${LoginController().BIID},${LoginController().SYID},'${LoginController().CIID}')''');
        await db.execute('''INSERT INTO SYN_ORD(SOET,ROW_NUM,SOOR,SOST,JTID_L,BIID_L,SYID_L,CIID_L) values('MAT_DES_M',0,307,1, ${LoginController().JTID},${LoginController().BIID},${LoginController().SYID},'${LoginController().CIID}')''');
        await db.execute('''INSERT INTO SYN_ORD(SOET,ROW_NUM,SOOR,SOST,JTID_L,BIID_L,SYID_L,CIID_L) values('MAT_DES_D',0,308,1, ${LoginController().JTID},${LoginController().BIID},${LoginController().SYID},'${LoginController().CIID}')''');


        await db.execute('''UPDATE BIL_MOV_D SET BMDTX11=BMDTX,BMDTXA11=BMDTXA,BMDTXT1=BMDTXT''');
        await db.execute('''UPDATE BIF_MOV_D SET BMDTX11=BMDTX,BMDTXA11=BMDTXA,BMDTXT1=BMDTXT''');
        await db.execute('''UPDATE BIL_MOV_M SET BMMTX11=BMMTX, TTID1=1''');
        await db.execute('''UPDATE BIF_MOV_M SET BMMTX11=BMMTX, TTID1=1''');

        await db.execute('''
       CREATE TABLE RES_SEC (
  RSID   INTEGER,
  RSNA   TEXT,
  RSNE   TEXT,
  RSHN   TEXT,
  RSST   INTEGER                            DEFAULT 1,
  RSFN   INTEGER,
  RSIN   TEXT,
  BIID   INTEGER,
  ORDNU  INTEGER,
  RES    TEXT,
  DATEI  DATE,
  SUID   TEXT,
  SUCH   TEXT,
  DATEU  DATE,
  DEVI   TEXT,
  DEVU   TEXT,
  DEFN   INTEGER,
  RSN3   TEXT,
  GUID   TEXT,               
  JTID_L INTEGER,
  BIID_L INTEGER,
  SYID_L INTEGER,
  CIID_L TEXT 
         )  
      ''');
        await db.execute('''
       CREATE TABLE RES_TAB (
  RSID   INTEGER,
  RTID   TEXT,
  RTNA   TEXT,
  RTNE   TEXT,
  RTST   INTEGER                            DEFAULT 1,
  RTIN   TEXT,
  BIID   INTEGER,
  ORDNU  INTEGER,
  RES    TEXT,
  DATEI  DATE,
  SUID   TEXT,
  SUCH   TEXT,
  DATEU  DATE,
  DEVI   TEXT,
  DEVU   TEXT,
  DEFN   INTEGER,
  RTN3   TEXT,
  GUID   TEXT,              
  JTID_L INTEGER,
  BIID_L INTEGER,
  SYID_L INTEGER,
  CIID_L TEXT 
         )  
      ''');
        await db.execute('''
       CREATE TABLE RES_EMP (
  REID   INTEGER,
  RSID   INTEGER,
  RENA   TEXT,
  RENE   TEXT,
  REST   INTEGER                            DEFAULT 1,
  REIN   TEXT,
  BIID   INTEGER,
  ORDNU  INTEGER,
  RES    TEXT,
  DATEI  DATE,
  SUID   TEXT,
  SUCH   TEXT,
  DATEU  DATE,
  DEVI   TEXT,
  DEVU   TEXT,
  DEFN   INTEGER,
  REN3   TEXT,
  GUID   TEXT,              
  JTID_L INTEGER,
  BIID_L INTEGER,
  SYID_L INTEGER,
  CIID_L TEXT 
         )  
      ''');
        await db.execute('''
       CREATE TABLE BIF_GRO (
  MGNO  TEXT,
  BGOR  INTEGER,
  BGBR  TEXT,
  BGCR  TEXT,
  BGMA  TEXT,  
  DATEI  DATE,
  SUID   TEXT,
  SUCH   TEXT,
  DATEU  DATE,
  DEVI   TEXT,
  DEVU   TEXT,
  BGST   INTEGER,
  GUID   TEXT,            
  JTID_L INTEGER,
  BIID_L INTEGER,
  SYID_L INTEGER,
  CIID_L TEXT 
         )  
      ''');
        await db.execute('''
       CREATE TABLE BIF_GRO2 (
  MGNO  TEXT,
  BGOR  INTEGER,
  BGBR  TEXT,
  BGCR  TEXT,
  BGMA  TEXT, 
  BGST   INTEGER, 
  DATEI  DATE,
  SUID   TEXT,
  SUCH   TEXT,
  DATEU  DATE,
  DEVI   TEXT,
  DEVU   TEXT,
  GUID   TEXT,            
  JTID_L INTEGER,
  BIID_L INTEGER,
  SYID_L INTEGER,
  CIID_L TEXT 
         )  
      ''');
        await db.execute('''
       CREATE TABLE BIF_MOV_A (
 BMKID  INTEGER,
  BMMID  INTEGER,
  BMMNO  INTEGER,
  RSID   INTEGER,
  RTID   TEXT,
  REID   INTEGER,
  BMATY  INTEGER                             DEFAULT 1,
  GUID   TEXT,
  BDID   INTEGER,
  BMACR  REAL                            DEFAULT 0,
  BMACA  REAL                           DEFAULT 0,
  BCDID  INTEGER,
  GUIDR  TEXT,
  BMADD  DATE                                   DEFAULT SYSDATE,
  BMADT  REAL                        DEFAULT 0,
  PKIDB  INTEGER                            DEFAULT 1,
  GUIDP  TEXT,              
  JTID_L INTEGER,
  BIID_L INTEGER,
  SYID_L INTEGER,
  CIID_L TEXT 
         )  
      ''');
        await db.execute('''
       CREATE TABLE MAT_FOL (
 BIID  INTEGER,
  MGNO  TEXT,
  MINO  TEXT,
  MUID   INTEGER,
  MFNO   REAL,
  MGNOF   TEXT,
  MINOF  TEXT ,
  MUIDF   INTEGER,
  MFNOF   REAL,
  MFDO  TEXT,
  MFIN  TEXT,
  MFST  INTEGER,
  MFID  INTEGER ,
  DATEI  DATE,
  SUID   TEXT,
  SUCH   TEXT,
  DATEU  DATE,
  DEVI   TEXT,
  DEVU   TEXT,
  GUID   TEXT,            
  JTID_L INTEGER,
  BIID_L INTEGER,
  SYID_L INTEGER,
  CIID_L TEXT 
         )  
      ''');
        await db.execute('''
       CREATE TABLE MAT_DES_M (
  MDMID  INTEGER,
  MDMNA  TEXT,
  MDMNE  TEXT,
  MDMN3  TEXT,
  MDMDE  TEXT,
  MGNOT  INTEGER                                 DEFAULT 1,
  MDMST  INTEGER                                 DEFAULT 1,
  ORDNU  INTEGER,
  RES    TEXT,
  SUID   TEXT,
  DATEI  DATE,
  DEVI   TEXT,
  SUCH   TEXT,
  DATEU  DATE,
  DEVU   TEXT,
  DEFN   INTEGER,
  GUID   TEXT,
  JTID_L INTEGER,
  BIID_L INTEGER,
  SYID_L INTEGER,
  CIID_L TEXT 
         )  
      ''');
        await db.execute('''
       CREATE TABLE MAT_DES_D (
   MDDID  INTEGER,
  MDMID  INTEGER,
  MGNO   TEXT,
  MINO   TEXT,
  MDDST  INTEGER                                 DEFAULT 1,
  ORDNU  INTEGER,
  RES    TEXT,
  SUID   TEXT,
  DATEI  DATE,
  DEVI   TEXT,
  SUCH   TEXT,
  DATEU  DATE,
  DEVU   TEXT,
  DEFN   INTEGER                                 DEFAULT 2,
  GUID   TEXT,
  JTID_L INTEGER,
  BIID_L INTEGER,
  SYID_L INTEGER,
  CIID_L TEXT 
         )  
      ''');
        await db.execute('''CREATE TABLE MAT_DES_M_TMP AS  SELECT  * FROM MAT_DES_M WHERE 1=2''');
        await db.execute('''CREATE TABLE MAT_DES_D_TMP AS  SELECT  * FROM MAT_DES_D WHERE 1=2''');
        await db.execute('''CREATE TABLE MAT_FOL_TMP AS  SELECT  * FROM MAT_FOL WHERE 1=2''');
        await db.execute('''CREATE TABLE RES_TAB_TMP AS  SELECT  * FROM RES_TAB WHERE 1=2''');
        await db.execute('''CREATE TABLE RES_SEC_TMP AS  SELECT  * FROM RES_SEC WHERE 1=2''');
        await db.execute('''CREATE TABLE RES_EMP_TMP AS  SELECT  * FROM RES_EMP WHERE 1=2''');
        await db.execute('''CREATE TABLE BIF_GRO_TMP AS  SELECT  * FROM BIF_GRO WHERE 1=2''');
        await db.execute('''CREATE TABLE BIF_GRO2_TMP AS  SELECT  * FROM BIF_GRO2 WHERE 1=2''');
        await db.execute('''CREATE TABLE BIF_MOV_A_TMP AS  SELECT  * FROM BIF_MOV_A WHERE 1=2''');


        await db.execute('''ALTER TABLE BIF_MOV_M ADD COLUMN  BMMGR  TEXT''');
        await db.execute('''ALTER TABLE BIF_CUS_D ADD COLUMN  SYST_L INTEGER  DEFAULT 1''');
        await db.execute('''ALTER TABLE BIF_CUS_D ADD COLUMN  BCDDL_L INTEGER  DEFAULT 1''');
        await db.execute('''ALTER TABLE BIF_CUS_D_TMP ADD COLUMN  SYST_L INTEGER  DEFAULT 1''');
        await db.execute('''ALTER TABLE BIF_CUS_D_TMP ADD COLUMN  BCDDL_L INTEGER  DEFAULT 1''');
        await db.execute('''ALTER TABLE ACC_ACC_TMP ADD COLUMN  SYST_L INTEGER  DEFAULT 1''');
        await db.execute('''ALTER TABLE ACC_USR_TMP ADD COLUMN  SYST_L INTEGER  DEFAULT 1''');

        await db.execute('''ALTER TABLE BIL_POI_TMP ADD COLUMN BPSEO INTEGER''');
        await db.execute('''ALTER TABLE BIL_POI_TMP ADD COLUMN BPIDT INTEGER''');
        await db.execute('''ALTER TABLE BIL_POI_TMP ADD COLUMN BPIDV TEXT''');
        await db.execute('''ALTER TABLE TAX_SYS_BRA_TMP ADD COLUMN  SUID TEXT  ''');
        await db.execute('''ALTER TABLE TAX_SYS_BRA_TMP ADD COLUMN  DATEI TEXT ''');
        await db.execute('''ALTER TABLE TAX_SYS_BRA_TMP ADD COLUMN  DEVI TEXT  ''');
        await db.execute('''ALTER TABLE TAX_SYS_BRA_TMP ADD COLUMN  SUCH TEXT  ''');
        await db.execute('''ALTER TABLE TAX_SYS_BRA_TMP ADD COLUMN  DATEU TEXT ''');
        await db.execute('''ALTER TABLE TAX_SYS_BRA_TMP ADD COLUMN  DEVU TEXT  ''');
        await db.execute('''ALTER TABLE BIF_MOV_M ADD COLUMN  BMMDE  TEXT  ''');
        await db.execute('''CREATE TABLE MAT_INF_D_TMP AS  SELECT  * FROM MAT_INF_D WHERE 1=2''');
        await db.execute('''
       CREATE TABLE MAT_DIS_T (
   MDTID  INTEGER,
  MDTNA  TEXT,
  MDTNE  TEXT,
  MDTN3  TEXT,
  MDTST  INTEGER                             DEFAULT 1,
  SUID   TEXT,
  DATEI  DATE,
  SUCH   TEXT,
  DATEU  DATE,
  GUID   TEXT,
    DEVI   TEXT,
  DEVU   TEXT,
  JTID_L INTEGER,
  BIID_L INTEGER,
  SYID_L INTEGER,
  CIID_L TEXT 
         )  
      ''');
        await db.execute('''
       CREATE TABLE MAT_DIS_K (
   MDKID  INTEGER,
  MDTID  INTEGER                             DEFAULT 0,
  MDKNA  TEXT,
  MDKNE  TEXT,
  MDKN3  TEXT,
  MDKST  INTEGER                             DEFAULT 1,
  SUID   TEXT,
  DATEI  DATE,
  SUCH   TEXT,
  DATEU  DATE,
  GUID   TEXT,
    DEVI   TEXT,
  DEVU   TEXT,
  JTID_L INTEGER,
  BIID_L INTEGER,
  SYID_L INTEGER,
  CIID_L TEXT 
         )  
      ''');
        await db.execute('''
       CREATE TABLE MAT_DIS_M (
    GUID     TEXT,
  MDMID    INTEGER,
  MDTID    INTEGER,
  MDKID    INTEGER,
  MDMRA    REAL                               DEFAULT 0,
  MDMSM    INTEGER                          DEFAULT 1,
  MDMCO    REAL                               DEFAULT 0,
  MDMAM    REAL                               DEFAULT 0,
  MDMMN    REAL                               DEFAULT 0,
  MDMCR    INTEGER                           DEFAULT 0,
  MDMCR2   INTEGER,
  MDMCR3   INTEGER,
  MDMOI    INTEGER                         DEFAULT 0,
  MDMFD    DATE,
  MDMTD    DATE,
  MDMFDA   INTEGER,
  MDMTDA   INTEGER,
  MDMFM    INTEGER,
  MDMTM    INTEGER,
  MDMFY    INTEGER,
  MDMTY    INTEGER,
  MDMFT    INTEGER,
  MDMTT    INTEGER,
  MDMDAYT  INTEGER                           DEFAULT 0,
  MDMDAY   TEXT,
  MDMST    INTEGER                         DEFAULT 1,
  MDMDE    TEXT,
  MDMRE    TEXT,
  SUID     TEXT,
  DATEI    DATE,
  SUCH     TEXT,
  DATEU    DATE,
    DEVI   TEXT,
  DEVU   TEXT,
  JTID_L INTEGER,
  BIID_L INTEGER,
  SYID_L INTEGER,
  CIID_L TEXT 
         )  
      ''');
        await db.execute('''
       CREATE TABLE MAT_DIS_D (
    GUID   TEXT,
  MDDID  INTEGER,
  MDMID  INTEGER,
  MGNO   TEXT,
  MINO   TEXT,
  MUID   INTEGER,
  MDDRA  REAL,
  MDDNU  REAL                                 DEFAULT 0,
  MDDAM  REAL                                 DEFAULT 0,
  MDDMN  REAL                                 DEFAULT 0,
  MDDSI  INTEGER                            DEFAULT 1,
  MDDST  INTEGER                                 DEFAULT 1,
  SUID   TEXT,
  DATEI  DATE,
  SUCH   TEXT,
  DATEU  DATE,
    DEVI   TEXT,
  DEVU   TEXT,
  JTID_L INTEGER,
  BIID_L INTEGER,
  SYID_L INTEGER,
  CIID_L TEXT 
         )  
      ''');
        await db.execute('''
       CREATE TABLE MAT_DIS_F (
    GUID   TEXT,
  MDFID  INTEGER,
  MDDID  INTEGER,
  MDMID  INTEGER,
  MGNO   TEXT,
  MINO   TEXT,
  MUID   INTEGER,
  MDFFN  INTEGER,
  MDFTN  INTEGER,
  SCID   INTEGER,
  MDFMP  INTEGER,
  MDFRA  INTEGER,
  MDFNU  INTEGER                                 DEFAULT 0,
  MDFAM  INTEGER                                 DEFAULT 0,
  MDFMN  INTEGER                                 DEFAULT 0,
  MDFST  INTEGER                             DEFAULT 1,
  SUID   TEXT,
  DATEI  DATE,
  SUCH   TEXT,
  DATEU  DATE,
    DEVI   TEXT,
  DEVU   TEXT,
  JTID_L INTEGER,
  BIID_L INTEGER,
  SYID_L INTEGER,
  CIID_L TEXT 
         )  
      ''');
        await db.execute('''
       CREATE TABLE MAT_DIS_L (
    GUID   TEXT,
   GUIDM  TEXT,
  GUIDD  TEXT,
  MMMID  INTEGER,
  MDMID  INTEGER,
  MDLST  INTEGER                             DEFAULT 1,
  SUID   TEXT,
  DATEI  DATE,
  SUCH   TEXT,
  DATEU  DATE,
    DEVI   TEXT,
  DEVU   TEXT,
  MCKID  INTEGER,
  JTID_L INTEGER,
  BIID_L INTEGER,
  SYID_L INTEGER,
  CIID_L TEXT 
         )  
      ''');
        await db.execute('''
       CREATE TABLE MAT_DIS_N (
    GUID    TEXT,
  MDNID   INTEGER,
  MMMID   INTEGER,
  MDMID   INTEGER,
  MDDID   INTEGER,
  MDFID   INTEGER,
  GUIDM   TEXT,
  MDNAM   INTEGER                                DEFAULT 0,
  MDNAM2  INTEGER                                DEFAULT 0,
  MDNNU   INTEGER                                DEFAULT 0,
  MDNNU2  INTEGER                                DEFAULT 0,
  MDNMN   INTEGER                                DEFAULT 0,
  MDNMN2  INTEGER                                DEFAULT 0,
  MDNN2   INTEGER                                DEFAULT 0,
  MDNN22  INTEGER                                DEFAULT 0,
  MDNN3   INTEGER                                DEFAULT 0,
  MDNN32  INTEGER                                DEFAULT 0,
  MDNC1   TEXT,
  MDNC2   TEXT,
  MDNST   INTEGER                            DEFAULT 1,
  SUID    TEXT,
  DATEI   DATE,
  SUCH    TEXT,
  DATEU   DATE,
    DEVI   TEXT,
  DEVU   TEXT,
  JTID_L INTEGER,
  BIID_L INTEGER,
  SYID_L INTEGER,
  CIID_L TEXT 
         )  
      ''');
        await db.execute('''
       CREATE TABLE MAT_DIS_S (
      GUID   TEXT,
  MDSST  INTEGER                                 DEFAULT 2,
  MDSRE  TEXT,
  SUID   TEXT,
  DATEI  DATE,
  SUCH   TEXT,
  DATEU  DATE,
    DEVI   TEXT,
  DEVU   TEXT,
  JTID_L INTEGER,
  BIID_L INTEGER,
  SYID_L INTEGER,
  CIID_L TEXT 
         )  
      ''');
        await db.execute('''
       CREATE TABLE SYN_TAS (
       CIID INTEGER,
       JTID INTEGER,
       BIID INTEGER,
       SYID INTEGER,
 GUID    TEXT, 
 STMID   TEXT,
 STKI    TEXT, 
 STTY    TEXT,
 STTB    TEXT,
 STDE    TEXT,
 STDE2   TEXT,
 STDE3   TEXT,
 STFU    TEXT,
 STTU    TEXT,
 STFID   INTEGER,
 STTID   INTEGER,
 STFD    DATE, 
 STTD    DATE,
 STIM    INTEGER DEFAULT 2, 
 STST    INTEGER DEFAULT 1, 
 SUID    TEXT, 
 DATEI   DATE, `
 DEVI    TEXT,
 SUCH    TEXT,
 DATEU   DATE, 
 DEVU    TEXT,
  JTID_L INTEGER,
  BIID_L INTEGER,
  SYID_L INTEGER,
  CIID_L TEXT 
         )  
      ''');
        await db.execute('''CREATE TABLE MAT_DIS_T_TMP AS SELECT  * FROM MAT_DIS_T WHERE 1=2''');
        await db.execute('''CREATE TABLE MAT_DIS_K_TMP AS SELECT  * FROM MAT_DIS_K WHERE 1=2''');
        await db.execute('''CREATE TABLE MAT_DIS_M_TMP AS SELECT  * FROM MAT_DIS_M WHERE 1=2''');
        await db.execute('''CREATE TABLE MAT_DIS_D_TMP AS SELECT  * FROM MAT_DIS_D WHERE 1=2''');
        await db.execute('''CREATE TABLE MAT_DIS_F_TMP AS SELECT  * FROM MAT_DIS_F WHERE 1=2''');
        await db.execute('''CREATE TABLE MAT_DIS_L_TMP AS SELECT  * FROM MAT_DIS_L WHERE 1=2''');
        await db.execute('''CREATE TABLE MAT_DIS_N_TMP AS SELECT  * FROM MAT_DIS_N WHERE 1=2''');
        await db.execute('''CREATE TABLE MAT_DIS_S_TMP AS SELECT  * FROM MAT_DIS_S WHERE 1=2''');
        await db.execute('''CREATE TABLE SYN_TAS_TMP AS SELECT  * FROM SYN_TAS WHERE 1=2''');

        await db.execute(''' CREATE  INDEX MAT_DIS_M_I1 ON MAT_DIS_M(MDMID,JTID_L,SYID_L,CIID_L)''');
        await db.execute(''' CREATE  INDEX MAT_DIS_D_I1 ON MAT_DIS_D(MDDID,JTID_L,SYID_L,CIID_L)''');

        await db.execute('''ALTER TABLE CONFIG ADD COLUMN  STMID TEXT  ''');
        await db.execute('''ALTER TABLE CONFIG ADD COLUMN  SYDV_NAME TEXT  ''');
        await db.execute('''ALTER TABLE CONFIG ADD COLUMN  SYDV_TY TEXT  ''');
        await db.execute('''ALTER TABLE CONFIG ADD COLUMN  SYDV_SER TEXT ''');
        await db.execute('''ALTER TABLE CONFIG ADD COLUMN  SYDV_ID TEXT ''');
        await db.execute('''ALTER TABLE CONFIG ADD COLUMN SYDV_NO TEXT ''');
        await db.execute('''ALTER TABLE CONFIG ADD COLUMN SYDV_IP TEXT ''');
        await db.execute('''ALTER TABLE CONFIG ADD COLUMN SYDV_APPV TEXT ''');

        await db.execute('''ALTER TABLE BIL_CUS ADD COLUMN BCLON TEXT''');
        await db.execute('''ALTER TABLE BIL_CUS ADD COLUMN BCLAT TEXT''');
        await db.execute('''ALTER TABLE BIL_CUS ADD COLUMN BILON TEXT''');
        await db.execute('''ALTER TABLE BIL_CUS_TMP ADD COLUMN BCLON TEXT''');
        await db.execute('''ALTER TABLE BIL_CUS_TMP ADD COLUMN BILON TEXT''');
        await db.execute('''ALTER TABLE BIL_CUS_TMP ADD COLUMN BCLAT TEXT''');

        await db.execute('''ALTER TABLE BIL_IMP ADD COLUMN BILON TEXT''');
        await db.execute('''ALTER TABLE BIL_IMP ADD COLUMN BILAT TEXT''');
        await db.execute('''ALTER TABLE BIL_IMP ADD COLUMN BICR INTEGER''');
        await db.execute('''ALTER TABLE BIL_IMP_TMP ADD COLUMN BICR INTEGER''');
        await db.execute('''ALTER TABLE BIL_IMP_TMP ADD COLUMN BILON TEXT''');
        await db.execute('''ALTER TABLE BIL_IMP_TMP ADD COLUMN BILAT TEXT''');

        await db.execute('''ALTER TABLE BIF_CUS_D ADD COLUMN BCDLON TEXT''');
        await db.execute('''ALTER TABLE BIF_CUS_D ADD COLUMN BCDLAT TEXT''');
        await db.execute('''ALTER TABLE BIF_CUS_D_TMP ADD COLUMN BCDLON TEXT''');
        await db.execute('''ALTER TABLE BIF_CUS_D_TMP ADD COLUMN BCDLAT TEXT''');

        await db.execute('''ALTER TABLE BIL_MOV_M ADD COLUMN BMMLON TEXT''');
        await db.execute('''ALTER TABLE BIL_MOV_M ADD COLUMN BMMLAT TEXT''');
        await db.execute('''ALTER TABLE BIF_MOV_M ADD COLUMN BMMLON TEXT''');
        await db.execute('''ALTER TABLE BIF_MOV_M ADD COLUMN BMMLAT TEXT''');

        await db.execute('''ALTER TABLE PAY_KIN ADD COLUMN  PKTY INTEGER''');
        await db.execute('''ALTER TABLE PAY_KIN_TMP ADD COLUMN  PKTY INTEGER''');
        await db.execute('''UPDATE PAY_KIN SET PKTY=1 WHERE PKID IN(1,2,5,8,9)''');
        await db.execute('''UPDATE PAY_KIN SET PKTY=2 WHERE PKID IN(3,4,10,11)''');
        await db.execute('''UPDATE PAY_KIN SET PKTY=3 WHERE PKID NOT IN(1,2,5,8,9,3,4,10,11)''');

        //2023-11-22
        await db.execute('''
       CREATE TABLE MAT_MAI_M (
       GUID    TEXT,
  MMMID   INTEGER,
  MMMDE   TEXT,
  BIIDT   INTEGER                                DEFAULT 0,
  BIID    TEXT,
  MMMBLT  INTEGER                                DEFAULT 0,
  MMMBL   TEXT,
  PKIDT   INTEGER                                DEFAULT 0,
  PKID    TEXT,
  BCCIDT  INTEGER                                DEFAULT 0,
  BCCID   TEXT,
  SCIDT   INTEGER                                DEFAULT 0,
  SCID    TEXT,
  BCTIDT  INTEGER                                DEFAULT 0,
  BCTID   TEXT,
  BCIDT   INTEGER                                DEFAULT 0,
  BCDIDT  INTEGER                                DEFAULT 0,
  CIIDT   INTEGER                                DEFAULT 0,
  ECIDT   INTEGER                                DEFAULT 0,
  SIIDT   INTEGER                                DEFAULT 0,
  SIID    TEXT,
  ACNOT   INTEGER                                DEFAULT 0,
  ACNO    TEXT,
  SUIDT   INTEGER                                DEFAULT 0,
  SUIDV   TEXT,
  MMMFD   DATE,
  MMMTD   DATE,
  MMMFT   INTEGER,
  MMMTT   INTEGER,
  MMMDAY  TEXT,
  ORDNU   INTEGER,
  SUID    TEXT,
  DATEI   DATE,
  SUCH    TEXT,
  DATEU   DATE,
  MMMST   INTEGER                                DEFAULT 1,
  DEVI    TEXT,
  DEVU    TEXT,
  JTID_L INTEGER,
  BIID_L INTEGER,
  SYID_L INTEGER,
  CIID_L TEXT 
         )  
      ''');
        await db.execute('''CREATE TABLE MAT_MAI_M_TMP AS SELECT  * FROM MAT_MAI_M WHERE 1=2''');
        await db.execute('''
       CREATE TABLE BIL_MOV_DD (
       BMDSQ   INTEGER,
  BMKID   INTEGER,
  BMMID   INTEGER,
  BMDID   INTEGER,
  GUID    TEXT,
  MMMID   INTEGER,
  MDMID   INTEGER,
  MDDID   INTEGER,
  MDFID   INTEGER,
  GUIDM   TEXT,
  MDTID   INTEGER                                DEFAULT 2,
  MGNO    TEXT,
  MINO    TEXT,
  MUID    INTEGER,
  BMDAM   REAL                                DEFAULT 0,
  BMDNO   REAL                                DEFAULT 0,
  BMDRE   REAL                                DEFAULT 0,
  BMDN1   INTEGER                                DEFAULT 0,
  BMDN2   INTEGER                                DEFAULT 0,
  BMDC1   TEXT,
  BMDC2   TEXT,
  BMDC3   TEXT,
  BMDST   INTEGER                                DEFAULT 1,
  BMDSQR  INTEGER,
  MCKID   INTEGER                                DEFAULT 1,
  MCDID   INTEGER,
  JTID_L INTEGER,
  BIID_L INTEGER,
  SYID_L INTEGER,
  CIID_L TEXT 
         )  
      ''');
        await db.execute('''
       CREATE TABLE BIL_MOV_MD (
      BMMSQ   INTEGER,
  BMKID   INTEGER,
  BMMID   INTEGER,
  GUID    TEXT,
  MMMID   INTEGER,
  MDMID   INTEGER,
  MDDID   INTEGER,
  MDFID   INTEGER,
  GUIDM   TEXT,
  BMMAM   REAL                                DEFAULT 0,
  BMMNO   REAL                                DEFAULT 0,
  BMMRE   REAL                                DEFAULT 0,
  BMMN1   INTEGER                                DEFAULT 0,
  BMMN2   INTEGER                                DEFAULT 0,
  BMMN3   INTEGER                                DEFAULT 0,
  BMMC1   TEXT,
  BMMC2   TEXT,
  BMMC3   TEXT,
  BMMC4   TEXT,
  BMMC5   TEXT,
  BMMST   INTEGER                                DEFAULT 1,
  BMMSQR  INTEGER,
  MCKID   INTEGER                                DEFAULT 1,
  MCDID   INTEGER,
  JTID_L INTEGER,
  BIID_L INTEGER,
  SYID_L INTEGER,
  CIID_L TEXT 
         )  
      ''');
        await db.execute('''
       CREATE TABLE BIF_MOV_DD (
       BMDSQ   INTEGER,
  BMKID   INTEGER,
  BMMID   INTEGER,
  BMDID   INTEGER,
  GUID    TEXT,
  MMMID   INTEGER,
  MDMID   INTEGER,
  MDDID   INTEGER,
  MDFID   INTEGER,
  GUIDM   TEXT,
  MDTID   INTEGER                                DEFAULT 2,
  MGNO    TEXT,
  MINO    TEXT,
  MUID    INTEGER,
  BMDAM   REAL                                DEFAULT 0,
  BMDNO   REAL                                DEFAULT 0,
  BMDRE   REAL                                DEFAULT 0,
  BMDN1   INTEGER                                DEFAULT 0,
  BMDN2   INTEGER                                DEFAULT 0,
  BMDC1   TEXT,
  BMDC2   TEXT,
  BMDC3   TEXT,
  BMDST   INTEGER                                DEFAULT 1,
  BMDSQR  INTEGER,
  MCKID   INTEGER                                DEFAULT 1,
  MCDID   INTEGER,
  JTID_L INTEGER,
  BIID_L INTEGER,
  SYID_L INTEGER,
  CIID_L TEXT 
         )  
      ''');
        await db.execute('''
       CREATE TABLE BIF_MOV_MD (
      BMMSQ   INTEGER,
  BMKID   INTEGER,
  BMMID   INTEGER,
  GUID    TEXT,
  MMMID   INTEGER,
  MDMID   INTEGER,
  MDDID   INTEGER,
  MDFID   INTEGER,
  GUIDM   TEXT,
  BMMAM   REAL                                DEFAULT 0,
  BMMNO   REAL                                DEFAULT 0,
  BMMRE   REAL                                DEFAULT 0,
  BMMN1   INTEGER                                DEFAULT 0,
  BMMN2   INTEGER                                DEFAULT 0,
  BMMN3   INTEGER                                DEFAULT 0,
  BMMC1   TEXT,
  BMMC2   TEXT,
  BMMC3   TEXT,
  BMMC4   TEXT,
  BMMC5   TEXT,
  BMMST   INTEGER                                DEFAULT 1,
  BMMSQR  INTEGER,
  MCKID   INTEGER                                DEFAULT 1,
  MCDID   INTEGER,
  JTID_L INTEGER,
  BIID_L INTEGER,
  SYID_L INTEGER,
  CIID_L TEXT 
         )  
      ''');

        //2023-11-24
        await db.execute('''INSERT INTO SYN_ORD(SOET,ROW_NUM,SOOR,SOST,JTID_L,BIID_L,SYID_L,CIID_L) values('MAT_DIS_T',0,309,1, ${LoginController().JTID},${LoginController().BIID},${LoginController().SYID},'${LoginController().CIID}')''');
        await db.execute('''INSERT INTO SYN_ORD(SOET,ROW_NUM,SOOR,SOST,JTID_L,BIID_L,SYID_L,CIID_L) values('MAT_DIS_K',0,310,1, ${LoginController().JTID},${LoginController().BIID},${LoginController().SYID},'${LoginController().CIID}')''');
        await db.execute('''INSERT INTO SYN_ORD(SOET,ROW_NUM,SOOR,SOST,JTID_L,BIID_L,SYID_L,CIID_L) values('MAT_DIS_M',0,311,1, ${LoginController().JTID},${LoginController().BIID},${LoginController().SYID},'${LoginController().CIID}')''');
        await db.execute('''INSERT INTO SYN_ORD(SOET,ROW_NUM,SOOR,SOST,JTID_L,BIID_L,SYID_L,CIID_L) values('MAT_DIS_D',0,312,1, ${LoginController().JTID},${LoginController().BIID},${LoginController().SYID},'${LoginController().CIID}')''');
        await db.execute('''INSERT INTO SYN_ORD(SOET,ROW_NUM,SOOR,SOST,JTID_L,BIID_L,SYID_L,CIID_L) values('MAT_DIS_F',0,313,1, ${LoginController().JTID},${LoginController().BIID},${LoginController().SYID},'${LoginController().CIID}')''');
        await db.execute('''INSERT INTO SYN_ORD(SOET,ROW_NUM,SOOR,SOST,JTID_L,BIID_L,SYID_L,CIID_L) values('MAT_DIS_L',0,314,1, ${LoginController().JTID},${LoginController().BIID},${LoginController().SYID},'${LoginController().CIID}')''');
        await db.execute('''INSERT INTO SYN_ORD(SOET,ROW_NUM,SOOR,SOST,JTID_L,BIID_L,SYID_L,CIID_L) values('MAT_DIS_N',0,315,1, ${LoginController().JTID},${LoginController().BIID},${LoginController().SYID},'${LoginController().CIID}')''');
        await db.execute('''INSERT INTO SYN_ORD(SOET,ROW_NUM,SOOR,SOST,JTID_L,BIID_L,SYID_L,CIID_L) values('MAT_MAI_M',0,316,1, ${LoginController().JTID},${LoginController().BIID},${LoginController().SYID},'${LoginController().CIID}')''');

        //2023-11-25
        await db.execute('''UPDATE BIL_MOV_M SET BMMST2=1 WHERE BMMST=1''');
        await db.execute('''UPDATE BIF_MOV_M SET BMMST2=1 WHERE BMMST=1''');

        await OnUpgradeV446(db);
        await OnUpgradeV446_9(db);
        await OnUpgradeV448_10(db);
        await OnUpgradeV449_11(db);
        await OnUpgradeV449_12(db);
        await OnUpgradeV449_13(db);
        await OnUpgradeV449_14(db);
        await OnUpgradeV449_15(db);
        await OnUpgradeV449_16(db);
        await OnUpgradeV449_17(db);

        print(oldversion);
        print(newversion);
        print("oldversion");
      }

      else  if (oldversion == 5) {
        await db.execute('''INSERT INTO SYN_ORD(SOET,ROW_NUM,SOOR,SOST,JTID_L,BIID_L,SYID_L,CIID_L) values('RES_SEC',0,301,1, ${LoginController().JTID},${LoginController().BIID},${LoginController().SYID},'${LoginController().CIID}')''');
        await db.execute('''INSERT INTO SYN_ORD(SOET,ROW_NUM,SOOR,SOST,JTID_L,BIID_L,SYID_L,CIID_L) values('RES_TAB',0,302,1, ${LoginController().JTID},${LoginController().BIID},${LoginController().SYID},'${LoginController().CIID}')''');
        await db.execute('''INSERT INTO SYN_ORD(SOET,ROW_NUM,SOOR,SOST,JTID_L,BIID_L,SYID_L,CIID_L) values('RES_EMP',0,303,1, ${LoginController().JTID},${LoginController().BIID},${LoginController().SYID},'${LoginController().CIID}')''');
        await db.execute('''INSERT INTO SYN_ORD(SOET,ROW_NUM,SOOR,SOST,JTID_L,BIID_L,SYID_L,CIID_L) values('BIF_GRO',0,304,1, ${LoginController().JTID},${LoginController().BIID},${LoginController().SYID},'${LoginController().CIID}')''');
        await db.execute('''INSERT INTO SYN_ORD(SOET,ROW_NUM,SOOR,SOST,JTID_L,BIID_L,SYID_L,CIID_L) values('BIF_GRO2',0,305,1, ${LoginController().JTID},${LoginController().BIID},${LoginController().SYID},'${LoginController().CIID}')''');
        await db.execute('''INSERT INTO SYN_ORD(SOET,ROW_NUM,SOOR,SOST,JTID_L,BIID_L,SYID_L,CIID_L) values('MAT_FOL',0,306,1, ${LoginController().JTID},${LoginController().BIID},${LoginController().SYID},'${LoginController().CIID}')''');
        await db.execute('''INSERT INTO SYN_ORD(SOET,ROW_NUM,SOOR,SOST,JTID_L,BIID_L,SYID_L,CIID_L) values('MAT_DES_M',0,307,1, ${LoginController().JTID},${LoginController().BIID},${LoginController().SYID},'${LoginController().CIID}')''');
        await db.execute('''INSERT INTO SYN_ORD(SOET,ROW_NUM,SOOR,SOST,JTID_L,BIID_L,SYID_L,CIID_L) values('MAT_DES_D',0,308,1, ${LoginController().JTID},${LoginController().BIID},${LoginController().SYID},'${LoginController().CIID}')''');

        await db.execute('''ALTER TABLE BIF_MOV_M ADD COLUMN BMMST2 INTEGER DEFAULT 2''');
        await db.execute('''ALTER TABLE BIL_MOV_M ADD COLUMN BMMST2 INTEGER DEFAULT 2''');
        await db.execute('''ALTER TABLE BIL_POI ADD COLUMN BPSEO INTEGER''');
        await db.execute('''ALTER TABLE BIL_POI ADD COLUMN BPIDT INTEGER''');
        await db.execute('''ALTER TABLE BIL_POI ADD COLUMN BPIDV TEXT''');
        await db.execute('''ALTER TABLE TAX_SYS_BRA ADD COLUMN  SUID TEXT  ''');
        await db.execute('''ALTER TABLE TAX_SYS_BRA ADD COLUMN  DATEI TEXT ''');
        await db.execute('''ALTER TABLE TAX_SYS_BRA ADD COLUMN  DEVI TEXT  ''');
        await db.execute('''ALTER TABLE TAX_SYS_BRA ADD COLUMN  SUCH TEXT  ''');
        await db.execute('''ALTER TABLE TAX_SYS_BRA ADD COLUMN  DATEU TEXT ''');
        await db.execute('''ALTER TABLE TAX_SYS_BRA ADD COLUMN  DEVU TEXT  ''');

        await db.execute('''ALTER TABLE ACC_ACC ADD COLUMN  SYST_L INTEGER  DEFAULT 1''');
        await db.execute('''ALTER TABLE ACC_USR ADD COLUMN  SYST_L INTEGER  DEFAULT 1''');
        await db.execute('''
       CREATE TABLE RES_SEC (
  RSID   INTEGER,
  RSNA   TEXT,
  RSNE   TEXT,
  RSHN   TEXT,
  RSST   INTEGER                            DEFAULT 1,
  RSFN   INTEGER,
  RSIN   TEXT,
  BIID   INTEGER,
  ORDNU  INTEGER,
  RES    TEXT,
  DATEI  DATE,
  SUID   TEXT,
  SUCH   TEXT,
  DATEU  DATE,
  DEVI   TEXT,
  DEVU   TEXT,
  DEFN   INTEGER,
  RSN3   TEXT,
  GUID   TEXT,               
  JTID_L INTEGER,
  BIID_L INTEGER,
  SYID_L INTEGER,
  CIID_L TEXT 
         )  
      ''');
        await db.execute('''
       CREATE TABLE RES_TAB (
  RSID   INTEGER,
  RTID   TEXT,
  RTNA   TEXT,
  RTNE   TEXT,
  RTST   INTEGER                            DEFAULT 1,
  RTIN   TEXT,
  BIID   INTEGER,
  ORDNU  INTEGER,
  RES    TEXT,
  DATEI  DATE,
  SUID   TEXT,
  SUCH   TEXT,
  DATEU  DATE,
  DEVI   TEXT,
  DEVU   TEXT,
  DEFN   INTEGER,
  RTN3   TEXT,
  GUID   TEXT,              
  JTID_L INTEGER,
  BIID_L INTEGER,
  SYID_L INTEGER,
  CIID_L TEXT 
         )  
      ''');
        await db.execute('''
       CREATE TABLE RES_EMP (
  REID   INTEGER,
  RSID   INTEGER,
  RENA   TEXT,
  RENE   TEXT,
  REST   INTEGER                            DEFAULT 1,
  REIN   TEXT,
  BIID   INTEGER,
  ORDNU  INTEGER,
  RES    TEXT,
  DATEI  DATE,
  SUID   TEXT,
  SUCH   TEXT,
  DATEU  DATE,
  DEVI   TEXT,
  DEVU   TEXT,
  DEFN   INTEGER,
  REN3   TEXT,
  GUID   TEXT,              
  JTID_L INTEGER,
  BIID_L INTEGER,
  SYID_L INTEGER,
  CIID_L TEXT 
         )  
      ''');
        await db.execute('''
       CREATE TABLE BIF_GRO (
  MGNO  TEXT,
  BGOR  INTEGER,
  BGBR  TEXT,
  BGCR  TEXT,
  BGMA  TEXT,  
  DATEI  DATE,
  SUID   TEXT,
  SUCH   TEXT,
  DATEU  DATE,
  DEVI   TEXT,
  DEVU   TEXT,
  BGST   INTEGER,
  GUID   TEXT,            
  JTID_L INTEGER,
  BIID_L INTEGER,
  SYID_L INTEGER,
  CIID_L TEXT 
         )  
      ''');
        await db.execute('''
       CREATE TABLE BIF_GRO2 (
  MGNO  TEXT,
  BGOR  INTEGER,
  BGBR  TEXT,
  BGCR  TEXT,
  BGMA  TEXT, 
  BGST   INTEGER, 
  DATEI  DATE,
  SUID   TEXT,
  SUCH   TEXT,
  DATEU  DATE,
  DEVI   TEXT,
  DEVU   TEXT,
  GUID   TEXT,            
  JTID_L INTEGER,
  BIID_L INTEGER,
  SYID_L INTEGER,
  CIID_L TEXT 
         )  
      ''');
        await db.execute('''
       CREATE TABLE BIF_MOV_A (
 BMKID  INTEGER,
  BMMID  INTEGER,
  BMMNO  INTEGER,
  RSID   INTEGER,
  RTID   TEXT,
  REID   INTEGER,
  BMATY  INTEGER                             DEFAULT 1,
  GUID   TEXT,
  BDID   INTEGER,
  BMACR  REAL                            DEFAULT 0,
  BMACA  REAL                           DEFAULT 0,
  BCDID  INTEGER,
  GUIDR  TEXT,
  BMADD  DATE                                   DEFAULT SYSDATE,
  BMADT  REAL                        DEFAULT 0,
  PKIDB  INTEGER                            DEFAULT 1,
  GUIDP  TEXT,              
  JTID_L INTEGER,
  BIID_L INTEGER,
  SYID_L INTEGER,
  CIID_L TEXT 
         )  
      ''');
        await db.execute('''
       CREATE TABLE MAT_FOL (
 BIID  INTEGER,
  MGNO  TEXT,
  MINO  TEXT,
  MUID   INTEGER,
  MFNO   REAL,
  MGNOF   TEXT,
  MINOF  TEXT ,
  MUIDF   INTEGER,
  MFNOF   REAL,
  MFDO  TEXT,
  MFIN  TEXT,
  MFST  INTEGER,
  MFID  INTEGER ,
  DATEI  DATE,
  SUID   TEXT,
  SUCH   TEXT,
  DATEU  DATE,
  DEVI   TEXT,
  DEVU   TEXT,
  GUID   TEXT,            
  JTID_L INTEGER,
  BIID_L INTEGER,
  SYID_L INTEGER,
  CIID_L TEXT 
         )  
      ''');
        await db.execute('''
       CREATE TABLE MAT_DES_M (
  MDMID  INTEGER,
  MDMNA  TEXT,
  MDMNE  TEXT,
  MDMN3  TEXT,
  MDMDE  TEXT,
  MGNOT  INTEGER                                 DEFAULT 1,
  MDMST  INTEGER                                 DEFAULT 1,
  ORDNU  INTEGER,
  RES    TEXT,
  SUID   TEXT,
  DATEI  DATE,
  DEVI   TEXT,
  SUCH   TEXT,
  DATEU  DATE,
  DEVU   TEXT,
  DEFN   INTEGER,
  GUID   TEXT,
  JTID_L INTEGER,
  BIID_L INTEGER,
  SYID_L INTEGER,
  CIID_L TEXT 
         )  
      ''');
        await db.execute('''
       CREATE TABLE MAT_DES_D (
   MDDID  INTEGER,
  MDMID  INTEGER,
  MGNO   TEXT,
  MINO   TEXT,
  MDDST  INTEGER                                 DEFAULT 1,
  ORDNU  INTEGER,
  RES    TEXT,
  SUID   TEXT,
  DATEI  DATE,
  DEVI   TEXT,
  SUCH   TEXT,
  DATEU  DATE,
  DEVU   TEXT,
  DEFN   INTEGER                                 DEFAULT 2,
  GUID   TEXT,
  JTID_L INTEGER,
  BIID_L INTEGER,
  SYID_L INTEGER,
  CIID_L TEXT 
         )  
      ''');
        await db.execute('''CREATE TABLE MAT_DES_M_TMP AS  SELECT  * FROM MAT_DES_M WHERE 1=2''');
        await db.execute('''CREATE TABLE MAT_DES_D_TMP AS  SELECT  * FROM MAT_DES_D WHERE 1=2''');
        await db.execute('''CREATE TABLE MAT_FOL_TMP AS  SELECT  * FROM MAT_FOL WHERE 1=2''');
        await db.execute('''CREATE TABLE RES_TAB_TMP AS  SELECT  * FROM RES_TAB WHERE 1=2''');
        await db.execute('''CREATE TABLE RES_SEC_TMP AS  SELECT  * FROM RES_SEC WHERE 1=2''');
        await db.execute('''CREATE TABLE RES_EMP_TMP AS  SELECT  * FROM RES_EMP WHERE 1=2''');
        await db.execute('''CREATE TABLE BIF_GRO_TMP AS  SELECT  * FROM BIF_GRO WHERE 1=2''');
        await db.execute('''CREATE TABLE BIF_GRO2_TMP AS  SELECT  * FROM BIF_GRO2 WHERE 1=2''');
        await db.execute('''CREATE TABLE BIF_MOV_A_TMP AS  SELECT  * FROM BIF_MOV_A WHERE 1=2''');

        await db.execute('''ALTER TABLE BIF_MOV_M ADD COLUMN  BMMGR  TEXT''');
        await db.execute('''ALTER TABLE BIF_CUS_D ADD COLUMN  SYST_L INTEGER  DEFAULT 1''');
        await db.execute('''ALTER TABLE BIF_CUS_D ADD COLUMN  BCDDL_L INTEGER  DEFAULT 1''');
        await db.execute('''ALTER TABLE BIF_CUS_D_TMP ADD COLUMN  SYST_L INTEGER  DEFAULT 1''');
        await db.execute('''ALTER TABLE BIF_CUS_D_TMP ADD COLUMN  BCDDL_L INTEGER  DEFAULT 1''');
        await db.execute('''ALTER TABLE ACC_ACC_TMP ADD COLUMN  SYST_L INTEGER  DEFAULT 1''');
        await db.execute('''ALTER TABLE ACC_USR_TMP ADD COLUMN  SYST_L INTEGER  DEFAULT 1''');


        await db.execute('''ALTER TABLE BIL_POI_TMP ADD COLUMN BPSEO INTEGER''');
        await db.execute('''ALTER TABLE BIL_POI_TMP ADD COLUMN BPIDT INTEGER''');
        await db.execute('''ALTER TABLE BIL_POI_TMP ADD COLUMN BPIDV TEXT''');
        await db.execute('''ALTER TABLE TAX_SYS_BRA_TMP ADD COLUMN  SUID TEXT  ''');
        await db.execute('''ALTER TABLE TAX_SYS_BRA_TMP ADD COLUMN  DATEI TEXT ''');
        await db.execute('''ALTER TABLE TAX_SYS_BRA_TMP ADD COLUMN  DEVI TEXT  ''');
        await db.execute('''ALTER TABLE TAX_SYS_BRA_TMP ADD COLUMN  SUCH TEXT  ''');
        await db.execute('''ALTER TABLE TAX_SYS_BRA_TMP ADD COLUMN  DATEU TEXT ''');
        await db.execute('''ALTER TABLE TAX_SYS_BRA_TMP ADD COLUMN  DEVU TEXT  ''');
        await db.execute('''ALTER TABLE BIF_MOV_M ADD COLUMN  BMMDE  TEXT  ''');
        await db.execute('''CREATE TABLE MAT_INF_D_TMP AS  SELECT  * FROM MAT_INF_D WHERE 1=2''');
        await db.execute('''
       CREATE TABLE MAT_DIS_T (
   MDTID  INTEGER,
  MDTNA  TEXT,
  MDTNE  TEXT,
  MDTN3  TEXT,
  MDTST  INTEGER                             DEFAULT 1,
  SUID   TEXT,
  DATEI  DATE,
  SUCH   TEXT,
  DATEU  DATE,
  GUID   TEXT,
    DEVI   TEXT,
  DEVU   TEXT,
  JTID_L INTEGER,
  BIID_L INTEGER,
  SYID_L INTEGER,
  CIID_L TEXT 
         )  
      ''');
        await db.execute('''
       CREATE TABLE MAT_DIS_K (
   MDKID  INTEGER,
  MDTID  INTEGER                             DEFAULT 0,
  MDKNA  TEXT,
  MDKNE  TEXT,
  MDKN3  TEXT,
  MDKST  INTEGER                             DEFAULT 1,
  SUID   TEXT,
  DATEI  DATE,
  SUCH   TEXT,
  DATEU  DATE,
  GUID   TEXT,
    DEVI   TEXT,
  DEVU   TEXT,
  JTID_L INTEGER,
  BIID_L INTEGER,
  SYID_L INTEGER,
  CIID_L TEXT 
         )  
      ''');
        await db.execute('''
       CREATE TABLE MAT_DIS_M (
    GUID     TEXT,
  MDMID    INTEGER,
  MDTID    INTEGER,
  MDKID    INTEGER,
  MDMRA    REAL                               DEFAULT 0,
  MDMSM    INTEGER                          DEFAULT 1,
  MDMCO    REAL                               DEFAULT 0,
  MDMAM    REAL                               DEFAULT 0,
  MDMMN    REAL                               DEFAULT 0,
  MDMCR    INTEGER                           DEFAULT 0,
  MDMCR2   INTEGER,
  MDMCR3   INTEGER,
  MDMOI    INTEGER                         DEFAULT 0,
  MDMFD    DATE,
  MDMTD    DATE,
  MDMFDA   INTEGER,
  MDMTDA   INTEGER,
  MDMFM    INTEGER,
  MDMTM    INTEGER,
  MDMFY    INTEGER,
  MDMTY    INTEGER,
  MDMFT    INTEGER,
  MDMTT    INTEGER,
  MDMDAYT  INTEGER                           DEFAULT 0,
  MDMDAY   TEXT,
  MDMST    INTEGER                         DEFAULT 1,
  MDMDE    TEXT,
  MDMRE    TEXT,
  SUID     TEXT,
  DATEI    DATE,
  SUCH     TEXT,
  DATEU    DATE,
    DEVI   TEXT,
  DEVU   TEXT,
  JTID_L INTEGER,
  BIID_L INTEGER,
  SYID_L INTEGER,
  CIID_L TEXT 
         )  
      ''');
        await db.execute('''
       CREATE TABLE MAT_DIS_D (
    GUID   TEXT,
  MDDID  INTEGER,
  MDMID  INTEGER,
  MGNO   TEXT,
  MINO   TEXT,
  MUID   INTEGER,
  MDDRA  REAL,
  MDDNU  REAL                                 DEFAULT 0,
  MDDAM  REAL                                 DEFAULT 0,
  MDDMN  REAL                                 DEFAULT 0,
  MDDSI  INTEGER                            DEFAULT 1,
  MDDST  INTEGER                                 DEFAULT 1,
  SUID   TEXT,
  DATEI  DATE,
  SUCH   TEXT,
  DATEU  DATE,
    DEVI   TEXT,
  DEVU   TEXT,
  JTID_L INTEGER,
  BIID_L INTEGER,
  SYID_L INTEGER,
  CIID_L TEXT 
         )  
      ''');
        await db.execute('''
       CREATE TABLE MAT_DIS_F (
    GUID   TEXT,
  MDFID  INTEGER,
  MDDID  INTEGER,
  MDMID  INTEGER,
  MGNO   TEXT,
  MINO   TEXT,
  MUID   INTEGER,
  MDFFN  INTEGER,
  MDFTN  INTEGER,
  SCID   INTEGER,
  MDFMP  INTEGER,
  MDFRA  INTEGER,
  MDFNU  INTEGER                                 DEFAULT 0,
  MDFAM  INTEGER                                 DEFAULT 0,
  MDFMN  INTEGER                                 DEFAULT 0,
  MDFST  INTEGER                             DEFAULT 1,
  SUID   TEXT,
  DATEI  DATE,
  SUCH   TEXT,
  DATEU  DATE,
  DEVI   TEXT,
  DEVU   TEXT,
  JTID_L INTEGER,
  BIID_L INTEGER,
  SYID_L INTEGER,
  CIID_L TEXT 
         )  
      ''');
        await db.execute('''
       CREATE TABLE MAT_DIS_L (
    GUID   TEXT,
   GUIDM  TEXT,
  GUIDD  TEXT,
  MMMID  INTEGER,
  MDMID  INTEGER,
  MDLST  INTEGER                             DEFAULT 1,
  SUID   TEXT,
  DATEI  DATE,
  SUCH   TEXT,
  DATEU  DATE,
    DEVI   TEXT,
  DEVU   TEXT,
  MCKID  INTEGER,
  JTID_L INTEGER,
  BIID_L INTEGER,
  SYID_L INTEGER,
  CIID_L TEXT 
         )  
      ''');
        await db.execute('''
       CREATE TABLE MAT_DIS_N (
    GUID    TEXT,
  MDNID   INTEGER,
  MMMID   INTEGER,
  MDMID   INTEGER,
  MDDID   INTEGER,
  MDFID   INTEGER,
  GUIDM   TEXT,
  MDNAM   INTEGER                                DEFAULT 0,
  MDNAM2  INTEGER                                DEFAULT 0,
  MDNNU   INTEGER                                DEFAULT 0,
  MDNNU2  INTEGER                                DEFAULT 0,
  MDNMN   INTEGER                                DEFAULT 0,
  MDNMN2  INTEGER                                DEFAULT 0,
  MDNN2   INTEGER                                DEFAULT 0,
  MDNN22  INTEGER                                DEFAULT 0,
  MDNN3   INTEGER                                DEFAULT 0,
  MDNN32  INTEGER                                DEFAULT 0,
  MDNC1   TEXT,
  MDNC2   TEXT,
  MDNST   INTEGER                            DEFAULT 1,
  SUID    TEXT,
  DATEI   DATE,
  SUCH    TEXT,
  DATEU   DATE,
    DEVI   TEXT,
  DEVU   TEXT,
  JTID_L INTEGER,
  BIID_L INTEGER,
  SYID_L INTEGER,
  CIID_L TEXT 
         )  
      ''');
        await db.execute('''
       CREATE TABLE MAT_DIS_S (
      GUID   TEXT,
  MDSST  INTEGER                                 DEFAULT 2,
  MDSRE  TEXT,
  SUID   TEXT,
  DATEI  DATE,
  SUCH   TEXT,
  DATEU  DATE,
    DEVI   TEXT,
  DEVU   TEXT,
  JTID_L INTEGER,
  BIID_L INTEGER,
  SYID_L INTEGER,
  CIID_L TEXT 
         )  
      ''');
        await db.execute('''
       CREATE TABLE SYN_TAS (
       CIID INTEGER,
       JTID INTEGER,
       BIID INTEGER,
       SYID INTEGER,
 GUID    TEXT, 
 STMID   TEXT,
 STKI    TEXT, 
 STTY    TEXT,
 STTB    TEXT,
 STDE    TEXT,
 STDE2   TEXT,
 STDE3   TEXT,
 STFU    TEXT,
 STTU    TEXT,
 STFID   INTEGER,
 STTID   INTEGER,
 STFD    DATE, 
 STTD    DATE,
 STIM    INTEGER DEFAULT 2, 
 STST    INTEGER DEFAULT 1, 
 SUID    TEXT, 
 DATEI   DATE, 
 DEVI    TEXT,
 SUCH    TEXT,
 DATEU   DATE, 
 DEVU    TEXT,
  JTID_L INTEGER,
  BIID_L INTEGER,
  SYID_L INTEGER,
  CIID_L TEXT 
         )  
      ''');
        await db.execute('''CREATE TABLE MAT_DIS_T_TMP AS SELECT  * FROM MAT_DIS_T WHERE 1=2''');
        await db.execute('''CREATE TABLE MAT_DIS_K_TMP AS SELECT  * FROM MAT_DIS_K WHERE 1=2''');
        await db.execute('''CREATE TABLE MAT_DIS_M_TMP AS SELECT  * FROM MAT_DIS_M WHERE 1=2''');
        await db.execute('''CREATE TABLE MAT_DIS_D_TMP AS SELECT  * FROM MAT_DIS_D WHERE 1=2''');
        await db.execute('''CREATE TABLE MAT_DIS_F_TMP AS SELECT  * FROM MAT_DIS_F WHERE 1=2''');
        await db.execute('''CREATE TABLE MAT_DIS_L_TMP AS SELECT  * FROM MAT_DIS_L WHERE 1=2''');
        await db.execute('''CREATE TABLE MAT_DIS_N_TMP AS SELECT  * FROM MAT_DIS_N WHERE 1=2''');
        await db.execute('''CREATE TABLE MAT_DIS_S_TMP AS SELECT  * FROM MAT_DIS_S WHERE 1=2''');
        await db.execute('''CREATE TABLE SYN_TAS_TMP AS SELECT  * FROM SYN_TAS WHERE 1=2''');

        await db.execute(''' CREATE  INDEX MAT_DIS_M_I1 ON MAT_DIS_M(MDMID,JTID_L,SYID_L,CIID_L)''');
        await db.execute(''' CREATE  INDEX MAT_DIS_D_I1 ON MAT_DIS_D(MDDID,JTID_L,SYID_L,CIID_L)''');

        await db.execute('''ALTER TABLE CONFIG ADD COLUMN  STMID TEXT  ''');
        await db.execute('''ALTER TABLE CONFIG ADD COLUMN  SYDV_NAME TEXT  ''');
        await db.execute('''ALTER TABLE CONFIG ADD COLUMN  SYDV_TY TEXT  ''');
        await db.execute('''ALTER TABLE CONFIG ADD COLUMN  SYDV_SER TEXT ''');
        await db.execute('''ALTER TABLE CONFIG ADD COLUMN  SYDV_ID TEXT ''');
        await db.execute('''ALTER TABLE CONFIG ADD COLUMN SYDV_NO TEXT ''');
        await db.execute('''ALTER TABLE CONFIG ADD COLUMN SYDV_IP TEXT ''');
        await db.execute('''ALTER TABLE CONFIG ADD COLUMN SYDV_APPV TEXT ''');

        await db.execute('''ALTER TABLE BIL_CUS ADD COLUMN BCLON TEXT''');
        await db.execute('''ALTER TABLE BIL_CUS ADD COLUMN BCLAT TEXT''');
        await db.execute('''ALTER TABLE BIL_CUS ADD COLUMN BILON TEXT''');
        await db.execute('''ALTER TABLE BIL_CUS_TMP ADD COLUMN BCLON TEXT''');
        await db.execute('''ALTER TABLE BIL_CUS_TMP ADD COLUMN BILON TEXT''');
        await db.execute('''ALTER TABLE BIL_CUS_TMP ADD COLUMN BCLAT TEXT''');

        await db.execute('''ALTER TABLE BIL_IMP ADD COLUMN BILON TEXT''');
        await db.execute('''ALTER TABLE BIL_IMP ADD COLUMN BILAT TEXT''');
        await db.execute('''ALTER TABLE BIL_IMP ADD COLUMN BICR INTEGER''');
        await db.execute('''ALTER TABLE BIL_IMP_TMP ADD COLUMN BICR INTEGER''');
        await db.execute('''ALTER TABLE BIL_IMP_TMP ADD COLUMN BILON TEXT''');
        await db.execute('''ALTER TABLE BIL_IMP_TMP ADD COLUMN BILAT TEXT''');

        await db.execute('''ALTER TABLE BIF_CUS_D ADD COLUMN BCDLON TEXT''');
        await db.execute('''ALTER TABLE BIF_CUS_D ADD COLUMN BCDLAT TEXT''');
        await db.execute('''ALTER TABLE BIF_CUS_D_TMP ADD COLUMN BCDLON TEXT''');
        await db.execute('''ALTER TABLE BIF_CUS_D_TMP ADD COLUMN BCDLAT TEXT''');

        await db.execute('''ALTER TABLE BIL_MOV_M ADD COLUMN BMMLON TEXT''');
        await db.execute('''ALTER TABLE BIL_MOV_M ADD COLUMN BMMLAT TEXT''');
        await db.execute('''ALTER TABLE BIF_MOV_M ADD COLUMN BMMLON TEXT''');
        await db.execute('''ALTER TABLE BIF_MOV_M ADD COLUMN BMMLAT TEXT''');

        await db.execute('''ALTER TABLE PAY_KIN ADD COLUMN  PKTY INTEGER''');
        await db.execute('''ALTER TABLE PAY_KIN_TMP ADD COLUMN  PKTY INTEGER''');
        await db.execute('''UPDATE PAY_KIN SET PKTY=1 WHERE PKID IN(1,2,5,8,9)''');
        await db.execute('''UPDATE PAY_KIN SET PKTY=2 WHERE PKID IN(3,4,10,11)''');
        await db.execute('''UPDATE PAY_KIN SET PKTY=3 WHERE PKID NOT IN(1,2,5,8,9,3,4,10,11)''');

        //2023-11-22
        await db.execute('''
       CREATE TABLE MAT_MAI_M (
       GUID    TEXT,
  MMMID   INTEGER,
  MMMDE   TEXT,
  BIIDT   INTEGER                                DEFAULT 0,
  BIID    TEXT,
  MMMBLT  INTEGER                                DEFAULT 0,
  MMMBL   TEXT,
  PKIDT   INTEGER                                DEFAULT 0,
  PKID    TEXT,
  BCCIDT  INTEGER                                DEFAULT 0,
  BCCID   TEXT,
  SCIDT   INTEGER                                DEFAULT 0,
  SCID    TEXT,
  BCTIDT  INTEGER                                DEFAULT 0,
  BCTID   TEXT,
  BCIDT   INTEGER                                DEFAULT 0,
  BCDIDT  INTEGER                                DEFAULT 0,
  CIIDT   INTEGER                                DEFAULT 0,
  ECIDT   INTEGER                                DEFAULT 0,
  SIIDT   INTEGER                                DEFAULT 0,
  SIID    TEXT,
  ACNOT   INTEGER                                DEFAULT 0,
  ACNO    TEXT,
  SUIDT   INTEGER                                DEFAULT 0,
  SUIDV   TEXT,
  MMMFD   DATE,
  MMMTD   DATE,
  MMMFT   INTEGER,
  MMMTT   INTEGER,
  MMMDAY  TEXT,
  ORDNU   INTEGER,
  SUID    TEXT,
  DATEI   DATE,
  SUCH    TEXT,
  DATEU   DATE,
  MMMST   INTEGER                                DEFAULT 1,
  DEVI    TEXT,
  DEVU    TEXT,
  JTID_L INTEGER,
  BIID_L INTEGER,
  SYID_L INTEGER,
  CIID_L TEXT 
         )  
      ''');
        await db.execute('''CREATE TABLE MAT_MAI_M_TMP AS SELECT  * FROM MAT_MAI_M WHERE 1=2''');
        await db.execute('''
       CREATE TABLE BIL_MOV_DD (
       BMDSQ   INTEGER,
  BMKID   INTEGER,
  BMMID   INTEGER,
  BMDID   INTEGER,
  GUID    TEXT,
  MMMID   INTEGER,
  MDMID   INTEGER,
  MDDID   INTEGER,
  MDFID   INTEGER,
  GUIDM   TEXT,
  MDTID   INTEGER                                DEFAULT 2,
  MGNO    TEXT,
  MINO    TEXT,
  MUID    INTEGER,
  BMDAM   REAL                                DEFAULT 0,
  BMDNO   REAL                                DEFAULT 0,
  BMDRE   REAL                                DEFAULT 0,
  BMDN1   INTEGER                                DEFAULT 0,
  BMDN2   INTEGER                                DEFAULT 0,
  BMDC1   TEXT,
  BMDC2   TEXT,
  BMDC3   TEXT,
  BMDST   INTEGER                                DEFAULT 1,
  BMDSQR  INTEGER,
  MCKID   INTEGER                                DEFAULT 1,
  MCDID   INTEGER,
  JTID_L INTEGER,
  BIID_L INTEGER,
  SYID_L INTEGER,
  CIID_L TEXT 
         )  
      ''');
        await db.execute('''
       CREATE TABLE BIL_MOV_MD (
      BMMSQ   INTEGER,
  BMKID   INTEGER,
  BMMID   INTEGER,
  GUID    TEXT,
  MMMID   INTEGER,
  MDMID   INTEGER,
  MDDID   INTEGER,
  MDFID   INTEGER,
  GUIDM   TEXT,
  BMMAM   REAL                                DEFAULT 0,
  BMMNO   REAL                                DEFAULT 0,
  BMMRE   REAL                                DEFAULT 0,
  BMMN1   INTEGER                                DEFAULT 0,
  BMMN2   INTEGER                                DEFAULT 0,
  BMMN3   INTEGER                                DEFAULT 0,
  BMMC1   TEXT,
  BMMC2   TEXT,
  BMMC3   TEXT,
  BMMC4   TEXT,
  BMMC5   TEXT,
  BMMST   INTEGER                                DEFAULT 1,
  BMMSQR  INTEGER,
  MCKID   INTEGER                                DEFAULT 1,
  MCDID   INTEGER,
  JTID_L INTEGER,
  BIID_L INTEGER,
  SYID_L INTEGER,
  CIID_L TEXT 
         )  
      ''');
        await db.execute('''
       CREATE TABLE BIF_MOV_DD (
       BMDSQ   INTEGER,
  BMKID   INTEGER,
  BMMID   INTEGER,
  BMDID   INTEGER,
  GUID    TEXT,
  MMMID   INTEGER,
  MDMID   INTEGER,
  MDDID   INTEGER,
  MDFID   INTEGER,
  GUIDM   TEXT,
  MDTID   INTEGER                                DEFAULT 2,
  MGNO    TEXT,
  MINO    TEXT,
  MUID    INTEGER,
  BMDAM   REAL                                DEFAULT 0,
  BMDNO   REAL                                DEFAULT 0,
  BMDRE   REAL                                DEFAULT 0,
  BMDN1   INTEGER                                DEFAULT 0,
  BMDN2   INTEGER                                DEFAULT 0,
  BMDC1   TEXT,
  BMDC2   TEXT,
  BMDC3   TEXT,
  BMDST   INTEGER                                DEFAULT 1,
  BMDSQR  INTEGER,
  MCKID   INTEGER                                DEFAULT 1,
  MCDID   INTEGER,
  JTID_L INTEGER,
  BIID_L INTEGER,
  SYID_L INTEGER,
  CIID_L TEXT 
         )  
      ''');
        await db.execute('''
       CREATE TABLE BIF_MOV_MD (
      BMMSQ   INTEGER,
  BMKID   INTEGER,
  BMMID   INTEGER,
  GUID    TEXT,
  MMMID   INTEGER,
  MDMID   INTEGER,
  MDDID   INTEGER,
  MDFID   INTEGER,
  GUIDM   TEXT,
  BMMAM   REAL                                DEFAULT 0,
  BMMNO   REAL                                DEFAULT 0,
  BMMRE   REAL                                DEFAULT 0,
  BMMN1   INTEGER                                DEFAULT 0,
  BMMN2   INTEGER                                DEFAULT 0,
  BMMN3   INTEGER                                DEFAULT 0,
  BMMC1   TEXT,
  BMMC2   TEXT,
  BMMC3   TEXT,
  BMMC4   TEXT,
  BMMC5   TEXT,
  BMMST   INTEGER                                DEFAULT 1,
  BMMSQR  INTEGER,
  MCKID   INTEGER                                DEFAULT 1,
  MCDID   INTEGER,
  JTID_L INTEGER,
  BIID_L INTEGER,
  SYID_L INTEGER,
  CIID_L TEXT 
         )  
      ''');

        //2023-11-24
        await db.execute('''INSERT INTO SYN_ORD(SOET,ROW_NUM,SOOR,SOST,JTID_L,BIID_L,SYID_L,CIID_L) values('MAT_DIS_T',0,309,1, ${LoginController().JTID},${LoginController().BIID},${LoginController().SYID},'${LoginController().CIID}')''');
        await db.execute('''INSERT INTO SYN_ORD(SOET,ROW_NUM,SOOR,SOST,JTID_L,BIID_L,SYID_L,CIID_L) values('MAT_DIS_K',0,310,1, ${LoginController().JTID},${LoginController().BIID},${LoginController().SYID},'${LoginController().CIID}')''');
        await db.execute('''INSERT INTO SYN_ORD(SOET,ROW_NUM,SOOR,SOST,JTID_L,BIID_L,SYID_L,CIID_L) values('MAT_DIS_M',0,311,1, ${LoginController().JTID},${LoginController().BIID},${LoginController().SYID},'${LoginController().CIID}')''');
        await db.execute('''INSERT INTO SYN_ORD(SOET,ROW_NUM,SOOR,SOST,JTID_L,BIID_L,SYID_L,CIID_L) values('MAT_DIS_D',0,312,1, ${LoginController().JTID},${LoginController().BIID},${LoginController().SYID},'${LoginController().CIID}')''');
        await db.execute('''INSERT INTO SYN_ORD(SOET,ROW_NUM,SOOR,SOST,JTID_L,BIID_L,SYID_L,CIID_L) values('MAT_DIS_F',0,313,1, ${LoginController().JTID},${LoginController().BIID},${LoginController().SYID},'${LoginController().CIID}')''');
        await db.execute('''INSERT INTO SYN_ORD(SOET,ROW_NUM,SOOR,SOST,JTID_L,BIID_L,SYID_L,CIID_L) values('MAT_DIS_L',0,314,1, ${LoginController().JTID},${LoginController().BIID},${LoginController().SYID},'${LoginController().CIID}')''');
        await db.execute('''INSERT INTO SYN_ORD(SOET,ROW_NUM,SOOR,SOST,JTID_L,BIID_L,SYID_L,CIID_L) values('MAT_DIS_N',0,315,1, ${LoginController().JTID},${LoginController().BIID},${LoginController().SYID},'${LoginController().CIID}')''');
        await db.execute('''INSERT INTO SYN_ORD(SOET,ROW_NUM,SOOR,SOST,JTID_L,BIID_L,SYID_L,CIID_L) values('MAT_MAI_M',0,316,1, ${LoginController().JTID},${LoginController().BIID},${LoginController().SYID},'${LoginController().CIID}')''');

        //2023-11-25
        await db.execute('''UPDATE BIL_MOV_M SET BMMST2=1 WHERE BMMST=1''');
        await db.execute('''UPDATE BIF_MOV_M SET BMMST2=1 WHERE BMMST=1''');

        await OnUpgradeV446(db);
        await OnUpgradeV446_9(db);
        await OnUpgradeV448_10(db);
        await OnUpgradeV449_11(db);
        await OnUpgradeV449_12(db);
        await OnUpgradeV449_13(db);
        await OnUpgradeV449_14(db);
        await OnUpgradeV449_15(db);
        await OnUpgradeV449_16(db);
        await OnUpgradeV449_17(db);

        print(oldversion);
        print(newversion);
        print("oldversion");
      }
      //2023-11-25
      else  if (oldversion == 6) {
        await db.execute('''ALTER TABLE BIL_CUS ADD COLUMN BCLON TEXT''');
        await db.execute('''ALTER TABLE BIL_CUS_TMP ADD COLUMN BCLON TEXT''');
        await db.execute('''UPDATE BIL_MOV_M SET BMMST2=1 WHERE BMMST=1''');
        await db.execute('''UPDATE BIF_MOV_M SET BMMST2=1 WHERE BMMST=1''');
        await OnUpgradeV446(db);
        await OnUpgradeV446_9(db);
        await OnUpgradeV448_10(db);
        await OnUpgradeV449_11(db);
        await OnUpgradeV449_12(db);
        await OnUpgradeV449_13(db);
        await OnUpgradeV449_14(db);
        await OnUpgradeV449_15(db);
        await OnUpgradeV449_16(db);
        await OnUpgradeV449_17(db);
        print(oldversion);
        print(newversion);
        print("oldversion");
      }

      else  if (oldversion == 7) {
        await OnUpgradeV446(db);
        await OnUpgradeV446_9(db);
        await OnUpgradeV448_10(db);
        await OnUpgradeV449_11(db);
        await OnUpgradeV449_12(db);
        await OnUpgradeV449_13(db);
        await OnUpgradeV449_14(db);
        await OnUpgradeV449_15(db);
        await OnUpgradeV449_16(db);
        await OnUpgradeV449_17(db);
        print(oldversion);
        print(newversion);
        print("oldversion");
      }

      //27-05-2024 --تحديث 9
      else  if (oldversion == 8){
        await OnUpgradeV446_9(db);
        await OnUpgradeV448_10(db);
        await OnUpgradeV449_11(db);
        await OnUpgradeV449_12(db);
        await OnUpgradeV449_13(db);
        await OnUpgradeV449_14(db);
        await OnUpgradeV449_15(db);
        await OnUpgradeV449_16(db);
        await OnUpgradeV449_17(db);
        print(oldversion);
        print(newversion);
        print("oldversion8");
      }

      //27-05-2024 --تحديث 10
      else  if (oldversion == 9){
        await  OnUpgradeV448_10(db);
        await OnUpgradeV449_11(db);
        await OnUpgradeV449_12(db);
        await  OnUpgradeV449_13(db);
        await OnUpgradeV449_14(db);
        await OnUpgradeV449_15(db);
        await OnUpgradeV449_16(db);
        await OnUpgradeV449_17(db);
        print(oldversion);
        print(newversion);
        print("oldversion9");
      }

      //13-10-2024 --تحديث 11
      else  if (oldversion == 10){
        await OnUpgradeV449_11(db);
        await OnUpgradeV449_12(db);
        await OnUpgradeV449_13(db);
        await OnUpgradeV449_14(db);
        await OnUpgradeV449_15(db);
        await OnUpgradeV449_16(db);
        await OnUpgradeV449_17(db);
        print(oldversion);
        print(newversion);
        print("oldversion10");
      }

      else  if (oldversion == 11){
        await OnUpgradeV449_12(db);
        await OnUpgradeV449_13(db);
        await OnUpgradeV449_14(db);
        await OnUpgradeV449_15(db);
        await OnUpgradeV449_16(db);
        await OnUpgradeV449_17(db);
        print(oldversion);
        print(newversion);
        print("oldversion11");
      }

      else  if (oldversion == 12){
        await OnUpgradeV449_13(db);
        await OnUpgradeV449_14(db);
        await OnUpgradeV449_15(db);
        await OnUpgradeV449_16(db);
        await OnUpgradeV449_17(db);
        print(oldversion);
        print(newversion);
        print("oldversion12");
      }

      else  if (oldversion == 13){
        await OnUpgradeV449_14(db);
        await OnUpgradeV449_15(db);
        await OnUpgradeV449_16(db);
        await OnUpgradeV449_17(db);
        print(oldversion);
        print(newversion);
        print("oldversion13");
      }

      else  if (oldversion == 14){
        await OnUpgradeV449_15(db);
        await OnUpgradeV449_16(db);
        await OnUpgradeV449_17(db);
        print(oldversion);
        print(newversion);
        print("oldversion14");
      }

      else  if (oldversion == 15){
        await OnUpgradeV449_16(db);
        await OnUpgradeV449_17(db);
        print(oldversion);
        print(newversion);
        print("oldversion15");
      }
      else  if (oldversion == 16){
        await OnUpgradeV449_17(db);
        print(oldversion);
        print(newversion);
        print("oldversion15");
      }


      await batch.commit();



      },Err: 'onUpgrade Database from ${oldversion} to ${newversion} -');
    // } catch (e) {
    //   await ToastService.showError("onUpgrade Database from ${oldversion} to ${newversion} -${e.toString()}");
    //   print("onUpgrade Database from ${oldversion} to ${newversion} -${e.toString()}");
    //   return false;
    // }
  }

  Future OnUpgradeV446 (Database db) async{
//   03-17-2024   --V446
    await db.execute('''
    CREATE TABLE BIF_EORD_D(
BMKID INTEGER,
BMMID INTEGER,
BMDID INTEGER,
GUIDF TEXT,
GUID TEXT,
BEDPS INTEGER DEFAULT 2,
BEDTY TEXT
)      
''');

    await db.execute('''
CREATE TABLE STO_INF_TYP(
  SITID  INTEGER,
  SITNA  TEXT,
  SITNE  TEXT,
  SITN3  TEXT,
  SITTY  INTEGER,
  SITST  INTEGER  DEFAULT 1,
  SITDL  INTEGER DEFAULT 1, 
  SUID   TEXT,
  SUCH   TEXT,
  DATEI  DATE,
  DATEU  DATE,
  DEVI   TEXT,
  DEVU   TEXT,
  ORDNU  INTEGER,
  DEFN   INTEGER  DEFAULT 2,
  RES    TEXT,
  GUID   TEXT)      
''');

    await db.execute('''
CREATE TABLE ACC_BAN_TYP(
  ABTID  INTEGER,
  ABTNA  TEXT,
  ABTNE  TEXT,
  ABTN3  TEXT,
  ABTTY  INTEGER,
  ABTST  INTEGER  DEFAULT 1,
  ABTDL  INTEGER DEFAULT 1,
  SUID   TEXT,
  SUCH   TEXT,
  DATEI  DATE   DEFAULT SYSDATE,
  DATEU  DATE,
  DEVI   TEXT,
  DEVU   TEXT,
  ORDNU  INTEGER,
  DEFN   INTEGER  DEFAULT 2,
  RES    TEXT,
  GUID   TEXT
  )      
''');

    await db.execute('''
CREATE TABLE BIL_CRE_C_TYP(
  BCCTID  INTEGER,
  BCCTNA  TEXT,
  BCCTNE  TEXT,
  BCCTN3  TEXT,
  BCCTTY  INTEGER,
  BCCTST  INTEGER    DEFAULT 1,
  BCCTDL  INTEGER DEFAULT 1,
  SUID   TEXT,
  SUCH   TEXT,
  DATEI  DATE ,
  DATEU  DATE,
  DEVI   TEXT,
  DEVU   TEXT,
  ORDNU  INTEGER,
  DEFN   INTEGER  DEFAULT 2,
  RES    TEXT,
  GUID   TEXT
  )      
''');

    await db.execute('''
CREATE TABLE BIL_DIS_TYP(
  BDTID  INTEGER,
  BDTNA  TEXT,
  BDTNE  TEXT,
  BDTN3  TEXT,
  BDTTY  INTEGER,
  BDTST  INTEGER    DEFAULT 1,
  BDTDL  INTEGER DEFAULT 1,
  SUID   TEXT,
  SUCH   TEXT,
  DATEI  DATE,
  DATEU  DATE,
  DEVI   TEXT,
  DEVU   TEXT,
  ORDNU  INTEGER,
  DEFN   INTEGER  DEFAULT 2,
  RES    TEXT,
  GUID   TEXT    
  )
''');

    await db.execute('''
CREATE TABLE ACC_CAS_TYP(
  ACTID  INTEGER,
  ACTNA  TEXT,
  ACTNE  TEXT,
  ACTN3  TEXT,
  ACTTY  INTEGER,
  ACTST  INTEGER     DEFAULT 1,
  ACTDL  INTEGER DEFAULT 1, 
  SUID   TEXT,
  SUCH   TEXT,
  DATEI  DATE,
  DATEU  DATE,
  DEVI   TEXT,
  DEVU   TEXT,
  ORDNU  INTEGER,
  DEFN   INTEGER,
  RES    TEXT,
  GUID   TEXT )
''');

    await db.execute('''ALTER TABLE ACC_ACC ADD COLUMN AAN3 TEXT''');
    await db.execute('''ALTER TABLE ACC_ACC ADD COLUMN RES TEXT''');
    await db.execute('''ALTER TABLE ACC_ACC ADD COLUMN SCIDV TEXT''');
    await db.execute('''ALTER TABLE ACC_ACC ADD COLUMN ACNOD TEXT''');
    await db.execute('''ALTER TABLE ACC_ACC ADD COLUMN AABL INTEGER''');
    await db.execute('''ALTER TABLE ACC_ACC ADD COLUMN ORDNU INTEGER''');
    await db.execute('''ALTER TABLE ACC_ACC_TMP ADD COLUMN AAN3 TEXT''');
    await db.execute('''ALTER TABLE ACC_ACC_TMP ADD COLUMN RES TEXT''');
    await db.execute('''ALTER TABLE ACC_ACC_TMP ADD COLUMN SCIDV TEXT''');
    await db.execute('''ALTER TABLE ACC_ACC_TMP ADD COLUMN ACNOD TEXT''');
    await db.execute('''ALTER TABLE ACC_ACC_TMP ADD COLUMN AABL INTEGER''');
    await db.execute('''ALTER TABLE ACC_ACC_TMP ADD COLUMN ORDNU INTEGER''');


    await db.execute('''ALTER TABLE STO_INF ADD COLUMN SIN3 TEXT''');
    await db.execute('''ALTER TABLE STO_INF ADD COLUMN RES TEXT''');
    await db.execute('''ALTER TABLE STO_INF ADD COLUMN SITID INTEGER''');
    await db.execute('''ALTER TABLE STO_INF ADD COLUMN ORDNU INTEGER''');
    await db.execute('''ALTER TABLE STO_INF ADD COLUMN DEFN INTEGER''');
    await db.execute('''ALTER TABLE STO_INF_TMP ADD COLUMN SIN3 TEXT''');
    await db.execute('''ALTER TABLE STO_INF_TMP ADD COLUMN RES TEXT''');
    await db.execute('''ALTER TABLE STO_INF_TMP ADD COLUMN SITID INTEGER''');
    await db.execute('''ALTER TABLE STO_INF_TMP ADD COLUMN ORDNU INTEGER''');
    await db.execute('''ALTER TABLE STO_INF_TMP ADD COLUMN DEFN INTEGER''');

    await db.execute('''ALTER TABLE ACC_BAN ADD COLUMN ABN3 TEXT''');
    await db.execute('''ALTER TABLE ACC_BAN ADD COLUMN RES TEXT''');
    await db.execute('''ALTER TABLE ACC_BAN ADD COLUMN ABTID INTEGER''');
    await db.execute('''ALTER TABLE ACC_BAN ADD COLUMN ORDNU INTEGER''');
    await db.execute('''ALTER TABLE ACC_BAN ADD COLUMN DEFN INTEGER''');
    await db.execute('''ALTER TABLE ACC_BAN ADD COLUMN SCIDV TEXT''');
    await db.execute('''ALTER TABLE ACC_BAN_TMP ADD COLUMN ABN3 TEXT''');
    await db.execute('''ALTER TABLE ACC_BAN_TMP ADD COLUMN RES TEXT''');
    await db.execute('''ALTER TABLE ACC_BAN_TMP ADD COLUMN ABTID INTEGER''');
    await db.execute('''ALTER TABLE ACC_BAN_TMP ADD COLUMN ORDNU INTEGER''');
    await db.execute('''ALTER TABLE ACC_BAN_TMP ADD COLUMN DEFN INTEGER''');
    await db.execute('''ALTER TABLE ACC_BAN_TMP ADD COLUMN SCIDV TEXT''');

    await db.execute('''ALTER TABLE BIL_CRE_C ADD COLUMN BCCN3 TEXT''');
    await db.execute('''ALTER TABLE BIL_CRE_C ADD COLUMN RES TEXT''');
    await db.execute('''ALTER TABLE BIL_CRE_C ADD COLUMN BCCTID INTEGER''');
    await db.execute('''ALTER TABLE BIL_CRE_C ADD COLUMN ORDNU INTEGER''');
    await db.execute('''ALTER TABLE BIL_CRE_C ADD COLUMN DEFN INTEGER''');
    await db.execute('''ALTER TABLE BIL_CRE_C ADD COLUMN SCIDV TEXT''');
    await db.execute('''ALTER TABLE BIL_CRE_C_TMP ADD COLUMN BCCN3 TEXT''');
    await db.execute('''ALTER TABLE BIL_CRE_C_TMP ADD COLUMN RES TEXT''');
    await db.execute('''ALTER TABLE BIL_CRE_C_TMP ADD COLUMN BCCTID INTEGER''');
    await db.execute('''ALTER TABLE BIL_CRE_C_TMP ADD COLUMN ORDNU INTEGER''');
    await db.execute('''ALTER TABLE BIL_CRE_C_TMP ADD COLUMN DEFN INTEGER''');
    await db.execute('''ALTER TABLE BIL_CRE_C_TMP ADD COLUMN SCIDV TEXT''');

    await db.execute('''ALTER TABLE BIL_DIS ADD COLUMN BDNE TEXT''');
    await db.execute('''ALTER TABLE BIL_DIS ADD COLUMN BDN3 TEXT''');
    await db.execute('''ALTER TABLE BIL_DIS ADD COLUMN RES TEXT''');
    await db.execute('''ALTER TABLE BIL_DIS ADD COLUMN BDTID INTEGER''');
    await db.execute('''ALTER TABLE BIL_DIS ADD COLUMN ORDNU INTEGER''');
    await db.execute('''ALTER TABLE BIL_DIS ADD COLUMN DEFN INTEGER''');
    await db.execute('''ALTER TABLE BIL_DIS_TMP ADD COLUMN BDNE TEXT''');
    await db.execute('''ALTER TABLE BIL_DIS_TMP ADD COLUMN BDN3 TEXT''');
    await db.execute('''ALTER TABLE BIL_DIS_TMP ADD COLUMN RES TEXT''');
    await db.execute('''ALTER TABLE BIL_DIS_TMP ADD COLUMN BDTID INTEGER''');
    await db.execute('''ALTER TABLE BIL_DIS_TMP ADD COLUMN ORDNU INTEGER''');
    await db.execute('''ALTER TABLE BIL_DIS_TMP ADD COLUMN DEFN INTEGER''');

    await db.execute('''ALTER TABLE ACC_CAS ADD COLUMN ACN3 TEXT''');
    await db.execute('''ALTER TABLE ACC_CAS ADD COLUMN RES TEXT''');
    await db.execute('''ALTER TABLE ACC_CAS ADD COLUMN ACTID INTEGER''');
    await db.execute('''ALTER TABLE ACC_CAS ADD COLUMN ORDNU INTEGER''');
    await db.execute('''ALTER TABLE ACC_CAS ADD COLUMN DEFN INTEGER''');
    await db.execute('''ALTER TABLE ACC_CAS ADD COLUMN SCIDV TEXT''');
    await db.execute('''ALTER TABLE ACC_CAS_TMP ADD COLUMN ACN3 TEXT''');
    await db.execute('''ALTER TABLE ACC_CAS_TMP ADD COLUMN RES TEXT''');
    await db.execute('''ALTER TABLE ACC_CAS_TMP ADD COLUMN ACTID INTEGER''');
    await db.execute('''ALTER TABLE ACC_CAS_TMP ADD COLUMN ORDNU INTEGER''');
    await db.execute('''ALTER TABLE ACC_CAS_TMP ADD COLUMN DEFN INTEGER''');
    await db.execute('''ALTER TABLE ACC_CAS_TMP ADD COLUMN SCIDV TEXT''');

    await db.execute('''ALTER TABLE ACC_CAS_U ADD COLUMN ORDNU INTEGER''');
    await db.execute('''ALTER TABLE ACC_CAS_U ADD COLUMN DEFN INTEGER''');
    await db.execute('''ALTER TABLE ACC_CAS_U ADD COLUMN RES TEXT''');
    await db.execute('''ALTER TABLE ACC_CAS_U ADD COLUMN SCIDV TEXT''');
    await db.execute('''ALTER TABLE ACC_CAS_U_TMP ADD COLUMN ORDNU INTEGER''');
    await db.execute('''ALTER TABLE ACC_CAS_U_TMP ADD COLUMN DEFN INTEGER''');
    await db.execute('''ALTER TABLE ACC_CAS_U_TMP ADD COLUMN RES TEXT''');
    await db.execute('''ALTER TABLE ACC_CAS_U_TMP ADD COLUMN SCIDV TEXT''');

    await db.execute('''CREATE INDEX BIF_EORD_D_I2 ON BIF_EORD_D (BMKID,BMMID,BEDTY)''');
  }

  //27-05-2024 --تحديث 9
  Future OnUpgradeV446_9 (Database db) async{

    //   27-05-2024   --9
    await db.execute('''
CREATE TABLE ACC_GRO(
  AGID  INTEGER,
  AGNA  TEXT,
  AGNE  TEXT,
  AGST  INTEGER                                  DEFAULT 1, 
  SUID   TEXT,
  SUCH   TEXT,
  DATEI  DATE,
  DATEU  DATE,
  DEVI   TEXT,
  DEVU   TEXT,
  GUID   TEXT,
  JTID_L INTEGER,
  BIID_L INTEGER,
  SYID_L INTEGER,
  CIID_L TEXT  )
''');
    await db.execute('''
CREATE TABLE SYS_REP(
  SRID   INTEGER,
  SRNA   TEXT,
  SRNE   TEXT,
  SRDE   TEXT,
  SRIN   TEXT,
  SRTY   TEXT,
  SRSE   INTEGER                                 DEFAULT 3,
  SRDES  TEXT,
  SRST   INTEGER                                 DEFAULT 1,
  SRKI   INTEGER                                 DEFAULT 1,
  SRCH   INTEGER                                 DEFAULT 1,
  SRCN   INTEGER                                 DEFAULT 1,
  SUID   TEXT,
  SRDT   INTEGER                                 DEFAULT 1,
  SRDEE  TEXT,
  SRDO   DATE,
  SRSN   INTEGER,
  SRNAS  TEXT,
  SRINS  TEXT,
  SRSES  INTEGER,
  SRDE3  TEXT,
  SRSY   INTEGER                                 DEFAULT 1,
  SRINE  TEXT,
  SRIN3  TEXT,
  STID   TEXT,
  SDID   INTEGER,
  STIDT  TEXT,
  SRFRM  TEXT,
  DATEI  DATE,
  DEVI   TEXT,
  SUCH   TEXT,
  DATEU  DATE,
  DEVU   TEXT,
  RES    TEXT,
  ORDNU  INTEGER,
  SSIDT  TEXT,
  SRXLS  INTEGER                                 DEFAULT 1,
  SRSYN  INTEGER                                 DEFAULT 2,
  SRSEP  INTEGER                                 DEFAULT 2,
  SRUD   INTEGER                                 DEFAULT 1,
  SRID2  INTEGER,
  GUID   TEXT,
  JTID_L INTEGER,
  BIID_L INTEGER,
  SYID_L INTEGER,
  CIID_L TEXT  )
''');
    await db.execute('''
                CREATE TABLE BIL_IMP_T(
                BITID  INTEGER,
                BITNA  TEXT,
                BITNE  TEXT ,
                PKID  INTEGER ,
                BITAM  TEXT ,
                BITST  INTEGER ,
                SUID TEXT,
			          GUID TEXT,
			          SUCH TEXT,
			          DATEI DATETIME,
			          DATEU DATETIME,
			          DEVI TEXT,
			          DEVU TEXT,
                JTID_L INTEGER,
                BIID_L INTEGER,
                SYID_L INTEGER,
                CIID_L TEXT   )  
                  ''');
    //   28-05-2024

    //   11-06-2024
    await db.execute('''
     CREATE TABLE STO_MOV_M(
      SMKID INTEGER NOT NULL,
      SMMID INTEGER NOT NULL,
      SMMNO INTEGER NULL,
      SMMDO DATE DEFAULT CURRENT_TIMESTAMP,
      SMMST INTEGER  DEFAULT 2,
      AANO TEXT,
      AANO2 TEXT,
      SIID INTEGER  NOT NULL,
      SIIDT INTEGER,
      SMMAM REAL,
      SMMAMT REAL,
      SCID INTEGER,
      SCEX REAL,
      SMMEQ REAL,
      SMMIN TEXT,
      SMMRE TEXT,
      SMMRE2 TEXT,
      SCEXS REAL,
      SMMDI REAL,
      SMMDIA REAL,
      SMMDIF REAL,
      SMMTX REAL,
      SMMCN TEXT,
      SMMDR TEXT,
      SMMNN TEXT,
      SMMDN INTEGER,
      SMMIDR INTEGER,
      SMMNOR INTEGER,
      SMMTY INTEGER DEFAULT 2,
      BKID INTEGER,
      BMMID INTEGER,
      ACNO TEXT,
      ACNO2 TEXT,
      SMMDA DATE,
      SUAP TEXT,
      SMMDE TEXT,
      SMMLA     REAL,
      SMMLC     INTEGER,
      SMMLAD    REAL,
      BMMDCT    REAL,
      BIID INTEGER,
      BIIDT INTEGER,
      SMMCR REAL DEFAULT 0,
      SMMCA REAL DEFAULT 0,
      SMMTXD REAL DEFAULT 0,
      SMMTXY REAL DEFAULT 1,
      TMTID INTEGER DEFAULT 1,
      ATTID INTEGER,
      SMMAN INTEGER DEFAULT 2,
      SMMDIA2 REAL DEFAULT 0,
      SMMDIR2 REAL DEFAULT 0,
      SMMCC INTEGER DEFAULT 2,
      SMMCQ INTEGER DEFAULT 2,
      SMMCCT REAL DEFAULT 0,
      SMMCQT REAL DEFAULT 0,
      SMMBR INTEGER DEFAULT 1,
      BIIDB INTEGER,
      SMMIS REAL DEFAULT 0,
      SMMPT REAL DEFAULT 0,
      SMMDT REAL DEFAULT 0,
      SMMWE REAL DEFAULT 0,
      SMMVO REAL DEFAULT 0,
      SMMVC REAL DEFAULT 0,
      AANOS TEXT,
      STMIDI TEXT,
      SOMIDI REAL,
      STMIDU TEXT,
      SOMIDU REAL,
      SUID TEXT,
      GUID TEXT,
      DATEI DATE DEFAULT CURRENT_TIMESTAMP,
      DATEU DATE,
      SUCH TEXT,
      GUID_LNK TEXT,
      DEVI TEXT,
      DEVU TEXT, 
      SMMTS INTEGER,
      SMMNR INTEGER,
      JTID_L INTEGER,
      BIID_L INTEGER,
      SYID_L INTEGER,
      CIID_L TEXT
    ) 
      ''');
    await db.execute('''
         CREATE TABLE STO_MOV_D(
         SMMID INTEGER NOT NULL,
         SMKID INTEGER NOT NULL,
         SMDID INTEGER NOT NULL,
         SIID INTEGER ,
         MGNO TEXT NOT NULL,
         MINO TEXT NOT NULL,
         MUID INTEGER NOT NULL,
         SMDNO REAL,
         SMDAM REAL,
         SMDNF REAL DEFAULT 0,
         SMDED DATE,
         SMDEQ REAL,
         SMDIN TEXT,
         SIIDT INTEGER,  
         BIID INTEGER,
         SMDDI REAL DEFAULT 0,
         SMDDIA REAL DEFAULT 0,
         SMDDIF REAL DEFAULT 0,
         SMDTX REAL DEFAULT 0,
         SMDEX REAL,
         SMDAML REAL,
         SMDEQC REAL,
         SMDCB REAL,
         SMDCA REAL,
         SMDAMR REAL,
         SMDAMRE REAL,
         SMMIDR INTEGER,
         SMMNOR INTEGER,
         SMDIDR INTEGER,
         SMDDIR REAL DEFAULT 0,
         SMDTXA REAL DEFAULT 0,
         SMDTXD REAL DEFAULT 0,
         SMDTY INTEGER DEFAULT 1,
         SMDDIA2 REAL DEFAULT 0,
         SMDDIR2 REAL DEFAULT 0,
         SMDCC REAL DEFAULT 2,
         SMDCQ REAL DEFAULT 2,
         SMDAMO REAL DEFAULT 0,
         SMDWE REAL DEFAULT 0,
         SMDVO REAL DEFAULT 0,
         SMDVC REAL DEFAULT 0,
         SYST INTEGER DEFAULT 2,
         SMDDF REAL DEFAULT 0,
         SMDAMT REAL,
         SMDAMTF REAL,
         GUID TEXT,
         GUIDM TEXT,
         SMDNO2 REAL,
         SUID TEXT,
         DATEI DATE DEFAULT CURRENT_TIMESTAMP,
         DATEU DATE,
         SUCH TEXT,
         DEVI TEXT,
         DEVU TEXT,
         JTID_L INTEGER,
         BIID_L INTEGER,
         SYID_L INTEGER,
         CIID_L TEXT
         ) 
      ''');

    //13-06-2024
    await db.execute('''
         CREATE TABLE STO_MOV_K (
           SMKID  INTEGER,
           SMKNA  TEXT,
           SMKNE  TEXT,
           SMKST  INTEGER                             DEFAULT 1,
           SMKTY  INTEGER,
           SMKAC  INTEGER                            DEFAULT 1,
           STID   TEXT,
           SMKDL  INTEGER                          DEFAULT 2,
           SMKN3  TEXT,
           SUID   TEXT,
           DATEI  DATE,
           DEVI   TEXT,
           SUCH   TEXT,
           DATEU  DATE,
           DEVU   TEXT,
           RES    TEXT,
           ORDNU  INTEGER,
           GUID   TEXT,
           JTID_L INTEGER,
           BIID_L INTEGER,
           SYID_L INTEGER,
           CIID_L TEXT
         )  
      ''');

    //13-06-2024

    //27-05-2024
    await db.execute('''CREATE TABLE ACC_GRO_TMP AS SELECT  * FROM ACC_GRO WHERE 1=2''');
    await db.execute('''CREATE TABLE SYS_REP_TMP AS SELECT  * FROM SYS_REP WHERE 1=2''');
    //28-05-2024
    await db.execute('''CREATE TABLE BIL_IMP_T_TMP AS SELECT  * FROM BIL_IMP_T WHERE 1=2''');
    //04-06-2024
    await db.execute('''CREATE TABLE SYS_LAN_TMP AS SELECT  * FROM SYS_LAN WHERE 1=2''');
    //13-06-2024
    await db.execute('''CREATE TABLE STO_MOV_K_TMP AS SELECT  * FROM STO_MOV_K WHERE 1=2''');


    await db.execute('''ALTER TABLE BIF_EORD_D ADD COLUMN JTID_L INTEGER''');
    await db.execute('''ALTER TABLE BIF_EORD_D ADD COLUMN BIID_L INTEGER''');
    await db.execute('''ALTER TABLE BIF_EORD_D ADD COLUMN SYID_L INTEGER''');
    await db.execute('''ALTER TABLE BIF_EORD_D ADD COLUMN CIID_L TEXT''');
    await db.execute('''ALTER TABLE STO_INF_TYP ADD COLUMN JTID_L INTEGER''');
    await db.execute('''ALTER TABLE STO_INF_TYP ADD COLUMN BIID_L INTEGER''');
    await db.execute('''ALTER TABLE STO_INF_TYP ADD COLUMN SYID_L INTEGER''');
    await db.execute('''ALTER TABLE STO_INF_TYP ADD COLUMN CIID_L TEXT''');
    await db.execute('''ALTER TABLE ACC_BAN_TYP ADD COLUMN JTID_L INTEGER''');
    await db.execute('''ALTER TABLE ACC_BAN_TYP ADD COLUMN BIID_L INTEGER''');
    await db.execute('''ALTER TABLE ACC_BAN_TYP ADD COLUMN SYID_L INTEGER''');
    await db.execute('''ALTER TABLE ACC_BAN_TYP ADD COLUMN CIID_L TEXT''');
    await db.execute('''ALTER TABLE BIL_CRE_C_TYP ADD COLUMN JTID_L INTEGER''');
    await db.execute('''ALTER TABLE BIL_CRE_C_TYP ADD COLUMN BIID_L INTEGER''');
    await db.execute('''ALTER TABLE BIL_CRE_C_TYP ADD COLUMN SYID_L INTEGER''');
    await db.execute('''ALTER TABLE BIL_CRE_C_TYP ADD COLUMN CIID_L TEXT''');
    await db.execute('''ALTER TABLE BIL_DIS_TYP ADD COLUMN JTID_L INTEGER''');
    await db.execute('''ALTER TABLE BIL_DIS_TYP ADD COLUMN BIID_L INTEGER''');
    await db.execute('''ALTER TABLE BIL_DIS_TYP ADD COLUMN SYID_L INTEGER''');
    await db.execute('''ALTER TABLE BIL_DIS_TYP ADD COLUMN CIID_L TEXT''');
    await db.execute('''ALTER TABLE ACC_CAS_TYP ADD COLUMN JTID_L INTEGER''');
    await db.execute('''ALTER TABLE ACC_CAS_TYP ADD COLUMN BIID_L INTEGER''');
    await db.execute('''ALTER TABLE ACC_CAS_TYP ADD COLUMN SYID_L INTEGER''');
    await db.execute('''ALTER TABLE ACC_CAS_TYP ADD COLUMN CIID_L TEXT''');
    //25-6-2024
    await db.execute('''ALTER TABLE ACC_MOV_K ADD COLUMN AMKFA  INTEGER''');
    await db.execute('''ALTER TABLE ACC_MOV_K_TMP ADD COLUMN AMKFA  INTEGER''');


    //27-05-2024
    await db.execute('''CREATE INDEX ACC_MOV_M_I1 on ACC_MOV_M(AMMID)''');
    await db.execute('''CREATE INDEX ACC_MOV_M_I2 on ACC_MOV_M(AMMID,JTID_L,SYID_L,CIID_L)''');
    await db.execute('''CREATE INDEX ACC_MOV_M_I3 on ACC_MOV_M(AMMID,JTID_L,BIID_L,SYID_L,CIID_L)''');
    await db.execute('''CREATE INDEX ACC_MOV_D_I1 on ACC_MOV_D(AMMID)''');
    await db.execute('''CREATE INDEX ACC_MOV_D_I2 on ACC_MOV_D(AMDID,JTID_L,SYID_L,CIID_L)''');
    await db.execute('''CREATE INDEX ACC_MOV_D_I3 on ACC_MOV_D(AMDID,JTID_L,BIID_L,SYID_L,CIID_L)''');
    await db.execute('''CREATE INDEX SYS_REP_I1 on SYS_REP(SRID)''');
    await db.execute('''CREATE INDEX SYS_REP_I2 on SYS_REP(SRID,JTID_L,SYID_L,CIID_L)''');
    await db.execute('''CREATE INDEX SYS_REP_I3 on SYS_REP(SRID,JTID_L,BIID_L,SYID_L,CIID_L)''');
    //28-05-2024
    await db.execute('''CREATE INDEX BIL_IMP_T_I1 on BIL_IMP_T(BITID)''');
    await db.execute('''CREATE INDEX BIL_IMP_T_I2 on BIL_IMP_T(BITID,JTID_L,SYID_L,CIID_L)''');
    await db.execute('''CREATE INDEX BIL_IMP_T_I3 on BIL_IMP_T(BITID,JTID_L,BIID_L,SYID_L,CIID_L)''');
    //04-06-2024
    await db.execute('''CREATE INDEX SYS_LAN_I1 on SYS_LAN(SLID)''');
    await db.execute('''CREATE INDEX SYS_LAN_I2 on SYS_LAN(SLID,JTID_L,SYID_L,CIID_L)''');
    await db.execute('''CREATE INDEX SYS_LAN_I3 on SYS_LAN(SLID,JTID_L,BIID_L,SYID_L,CIID_L)''');
    await db.execute('''CREATE INDEX SYS_LAN_I4 on SYS_LAN(SLTY, SLIT, SLSC)''');
    await db.execute('''CREATE INDEX SYS_LAN_I5 on SYS_LAN(SLTY, SLIT, SLSC,JTID_L,SYID_L,CIID_L)''');
    await db.execute('''CREATE INDEX SYS_LAN_I6 on SYS_LAN(SLTY, SLIT, SLSC,JTID_L,BIID_L,SYID_L,CIID_L)''');
    await db.execute('''CREATE INDEX SYS_LAN_I7 on SYS_LAN(SLN1, SLN2, SLN3)''');
    await db.execute('''CREATE INDEX SYS_LAN_I8 on SYS_LAN(SLN1, SLN2, SLN3,JTID_L,SYID_L,CIID_L)''');
    await db.execute('''CREATE INDEX SYS_LAN_I9 on SYS_LAN(SLN1, SLN2, SLN3,JTID_L,BIID_L,SYID_L,CIID_L)''');

    //11-06-2024
    await db.execute('''CREATE INDEX STO_MOV_D_I1 on STO_MOV_D(SMMID,JTID_L,BIID_L,SYID_L,CIID_L)''');
    await db.execute('''CREATE INDEX STO_MOV_D_I2 on STO_MOV_D(MGNO,MINO,MUID,JTID_L,BIID_L,SYID_L,CIID_L)''');
    await db.execute('''CREATE INDEX STO_MOV_M_I1 on STO_MOV_M(SMMID,JTID_L,BIID_L,SYID_L,CIID_L)''');

    //25-06-2024
    await db.execute('''UPDATE ACC_MOV_K SET AMKFA=15 WHERE NVL(AMKFA,0)<>15 AND STID='AC' AND AMKAC=1
      AND( (AMKDL=2 AND AMKID IN(15,16) ) OR (AMKDL=1 AND ((AMKID>1000)OR (AMKID BETWEEN 21 AND 40) )))''');
    await db.execute('''UPDATE ACC_MOV_K SET AMKFA=AMKID WHERE AMKFA IS NULL ''');

  }

  Future OnUpgradeV448_10 (Database db) async{

    //2024-09-03
    await db.execute('''CREATE TABLE ACC_TAX_C_TMP AS SELECT  * FROM ACC_TAX_C WHERE 1=2''');
    await db.execute('''ALTER TABLE TAX_SYS_BRA ADD COLUMN TSBST INTEGER DEFAULT 1''');
    await db.execute('''ALTER TABLE TAX_SYS_D ADD COLUMN TSDQR TEXT''');
    await db.execute('''ALTER TABLE TAX_TBL_LNK ADD COLUMN TTLSYM TEXT''');
    await db.execute('''ALTER TABLE TAX_TYP ADD COLUMN TTLN INTEGER''');
    await db.execute('''ALTER TABLE TAX_TYP ADD COLUMN TTIDC TEXT''');
    await db.execute('''ALTER TABLE TAX_TYP_SYS ADD COLUMN TTSIDC TEXT''');

    await db.execute('''ALTER TABLE TAX_SYS_BRA_TMP ADD COLUMN TSBST INTEGER DEFAULT 1''');
    await db.execute('''ALTER TABLE TAX_SYS_D_TMP ADD COLUMN TSDQR TEXT''');
    await db.execute('''ALTER TABLE TAX_TBL_LNK_TMP ADD COLUMN TTLSYM TEXT''');
    await db.execute('''ALTER TABLE TAX_TYP_TMP ADD COLUMN TTLN INTEGER''');
    await db.execute('''ALTER TABLE TAX_TYP_TMP ADD COLUMN TTIDC TEXT''');
    await db.execute('''ALTER TABLE TAX_TYP_SYS_TMP ADD COLUMN TTSIDC TEXT''');


    await db.execute('''ALTER TABLE COU_WRD ADD COLUMN ORDNU INTEGER''');
    await db.execute('''ALTER TABLE COU_WRD ADD COLUMN RES TEXT''');
    await db.execute('''ALTER TABLE COU_WRD ADD COLUMN DEFN INTEGER''');
    await db.execute('''ALTER TABLE COU_WRD ADD COLUMN CWN3 TEXT''');
    await db.execute('''ALTER TABLE COU_WRD ADD COLUMN CWWC TEXT''');
    await db.execute('''ALTER TABLE COU_WRD ADD COLUMN CWCC TEXT''');
    await db.execute('''ALTER TABLE COU_WRD ADD COLUMN CWWN INTEGER''');
    await db.execute('''ALTER TABLE COU_WRD ADD COLUMN CWCC1 TEXT''');
    await db.execute('''ALTER TABLE COU_WRD ADD COLUMN CWWC2 TEXT''');
    await db.execute('''ALTER TABLE COU_WRD ADD COLUMN CWWN3 INTEGER''');
    await db.execute('''ALTER TABLE COU_WRD ADD COLUMN CWCN1 TEXT''');
    await db.execute('''ALTER TABLE COU_WRD ADD COLUMN CWCN2 TEXT''');
    await db.execute('''ALTER TABLE COU_WRD ADD COLUMN CWNAT TEXT''');
    await db.execute('''ALTER TABLE COU_WRD ADD COLUMN CWSFL INTEGER DEFAULT 2''');
    await db.execute('''ALTER TABLE COU_WRD ADD COLUMN CWCN3 TEXT''');
    await db.execute('''ALTER TABLE COU_WRD ADD COLUMN CWNAT1 TEXT''');
    await db.execute('''ALTER TABLE COU_WRD ADD COLUMN CWNAT2 TEXT''');
    await db.execute('''ALTER TABLE COU_WRD ADD COLUMN CWNAT3 TEXT''');

    await db.execute('''ALTER TABLE COU_WRD_TMP ADD COLUMN ORDNU INTEGER''');
    await db.execute('''ALTER TABLE COU_WRD_TMP ADD COLUMN RES TEXT''');
    await db.execute('''ALTER TABLE COU_WRD_TMP ADD COLUMN DEFN INTEGER''');
    await db.execute('''ALTER TABLE COU_WRD_TMP ADD COLUMN CWN3 TEXT''');
    await db.execute('''ALTER TABLE COU_WRD_TMP ADD COLUMN CWWC TEXT''');
    await db.execute('''ALTER TABLE COU_WRD_TMP ADD COLUMN CWCC TEXT''');
    await db.execute('''ALTER TABLE COU_WRD_TMP ADD COLUMN CWWN INTEGER''');
    await db.execute('''ALTER TABLE COU_WRD_TMP ADD COLUMN CWCC1 TEXT''');
    await db.execute('''ALTER TABLE COU_WRD_TMP ADD COLUMN CWWC2 TEXT''');
    await db.execute('''ALTER TABLE COU_WRD_TMP ADD COLUMN CWWN3 INTEGER''');
    await db.execute('''ALTER TABLE COU_WRD_TMP ADD COLUMN CWCN1 TEXT''');
    await db.execute('''ALTER TABLE COU_WRD_TMP ADD COLUMN CWCN2 TEXT''');
    await db.execute('''ALTER TABLE COU_WRD_TMP ADD COLUMN CWNAT TEXT''');
    await db.execute('''ALTER TABLE COU_WRD_TMP ADD COLUMN CWSFL INTEGER DEFAULT 2''');
    await db.execute('''ALTER TABLE COU_WRD_TMP ADD COLUMN CWCN3 TEXT''');
    await db.execute('''ALTER TABLE COU_WRD_TMP ADD COLUMN CWNAT1 TEXT''');
    await db.execute('''ALTER TABLE COU_WRD_TMP ADD COLUMN CWNAT2 TEXT''');
    await db.execute('''ALTER TABLE COU_WRD_TMP ADD COLUMN CWNAT3 TEXT''');

    await db.execute('''ALTER TABLE COU_TOW ADD COLUMN DEFN INTEGER ''');
    await db.execute('''ALTER TABLE COU_TOW ADD COLUMN ORDNU INTEGER ''');
    await db.execute('''ALTER TABLE COU_TOW ADD COLUMN RES TEXT''');

    await db.execute('''ALTER TABLE COU_TOW_TMP ADD COLUMN DEFN INTEGER ''');
    await db.execute('''ALTER TABLE COU_TOW_TMP ADD COLUMN ORDNU INTEGER ''');
    await db.execute('''ALTER TABLE COU_TOW_TMP ADD COLUMN RES TEXT''');


    await db.execute('''ALTER TABLE BIL_MOV_M ADD COLUMN TDKID TEXT''');
    await db.execute('''ALTER TABLE BIL_MOV_M ADD COLUMN TCKID TEXT''');
    await db.execute('''ALTER TABLE BIL_MOV_M ADD COLUMN STMIDI TEXT''');
    await db.execute('''ALTER TABLE BIL_MOV_M ADD COLUMN SOMIDI INTEGER ''');
    await db.execute('''ALTER TABLE BIL_MOV_M ADD COLUMN STMIDU TEXT''');
    await db.execute('''ALTER TABLE BIL_MOV_M ADD COLUMN SOMIDU INTEGER ''');
    await db.execute('''ALTER TABLE BIL_MOV_M ADD COLUMN BMMTX_DAT TEXT''');
    await db.execute('''ALTER TABLE BIL_MOV_M ADD COLUMN BMMFS INTEGER DEFAULT 10''');
    await db.execute('''ALTER TABLE BIL_MOV_M ADD COLUMN BMMQR TEXT ''');
    await db.execute('''ALTER TABLE BIL_MOV_M ADD COLUMN BMMRO INTEGER ''');

    await db.execute('''ALTER TABLE BIL_MOV_M_TMP ADD COLUMN TDKID TEXT''');
    await db.execute('''ALTER TABLE BIL_MOV_M_TMP ADD COLUMN TCKID TEXT''');
    await db.execute('''ALTER TABLE BIL_MOV_M_TMP ADD COLUMN STMIDI TEXT''');
    await db.execute('''ALTER TABLE BIL_MOV_M_TMP ADD COLUMN SOMIDI INTEGER ''');
    await db.execute('''ALTER TABLE BIL_MOV_M_TMP ADD COLUMN STMIDU TEXT''');
    await db.execute('''ALTER TABLE BIL_MOV_M_TMP ADD COLUMN SOMIDU INTEGER ''');
    await db.execute('''ALTER TABLE BIL_MOV_M_TMP ADD COLUMN BMMTX_DAT TEXT''');
    await db.execute('''ALTER TABLE BIL_MOV_M_TMP ADD COLUMN BMMFS INTEGER DEFAULT 10''');
    await db.execute('''ALTER TABLE BIL_MOV_M_TMP ADD COLUMN BMMQR TEXT ''');
    await db.execute('''ALTER TABLE BIL_MOV_M_TMP ADD COLUMN BMMRO INTEGER ''');


    await db.execute('''ALTER TABLE BIF_MOV_M ADD COLUMN TDKID TEXT''');
    await db.execute('''ALTER TABLE BIF_MOV_M ADD COLUMN TCKID TEXT''');
    await db.execute('''ALTER TABLE BIF_MOV_M ADD COLUMN STMIDI TEXT''');
    await db.execute('''ALTER TABLE BIF_MOV_M ADD COLUMN SOMIDI INTEGER ''');
    await db.execute('''ALTER TABLE BIF_MOV_M ADD COLUMN STMIDU TEXT''');
    await db.execute('''ALTER TABLE BIF_MOV_M ADD COLUMN SOMIDU INTEGER ''');
    await db.execute('''ALTER TABLE BIF_MOV_M ADD COLUMN BMMTX_DAT TEXT''');
    await db.execute('''ALTER TABLE BIF_MOV_M ADD COLUMN BMMFS INTEGER DEFAULT 2''');
    await db.execute('''ALTER TABLE BIF_MOV_M ADD COLUMN BMMQR TEXT ''');
    await db.execute('''ALTER TABLE BIF_MOV_M ADD COLUMN BMMRO INTEGER ''');

    await db.execute('''ALTER TABLE BIL_MOV_D ADD COLUMN TDKID TEXT ''');
    await db.execute('''ALTER TABLE BIL_MOV_D ADD COLUMN TCKID TEXT ''');
    await db.execute('''ALTER TABLE BIL_MOV_D ADD COLUMN GUIDMT TEXT ''');

    await db.execute('''ALTER TABLE BIL_MOV_D_TMP ADD COLUMN TDKID TEXT ''');
    await db.execute('''ALTER TABLE BIL_MOV_D_TMP ADD COLUMN TCKID TEXT ''');
    await db.execute('''ALTER TABLE BIL_MOV_D_TMP ADD COLUMN GUIDMT TEXT ''');

    await db.execute('''ALTER TABLE BIF_MOV_D ADD COLUMN TDKID TEXT ''');
    await db.execute('''ALTER TABLE BIF_MOV_D ADD COLUMN TCKID TEXT ''');
    await db.execute('''ALTER TABLE BIF_MOV_D ADD COLUMN GUIDMT TEXT ''');

    await db.execute('''ALTER TABLE SYN_ORD ADD COLUMN SOPK TEXT ''');
    await db.execute('''ALTER TABLE SYN_ORD_TMP ADD COLUMN SOPK TEXT ''');

    await db.execute('''UPDATE SYN_ORD SET SOPK='GUID' ''');


    //   08-09-2024
    await db.execute('''
 CREATE TABLE FAT_API_INF(
  GUID    TEXT,
  FAISP   TEXT,
  SCHNA   TEXT,
  STMID   TEXT,
  FAITY   TEXT,
  FAIURL  TEXT,
  FAIME   TEXT,
  FAIRO   TEXT,
  FAIPO   TEXT,
  FAICT   TEXT                   DEFAULT 'application/json',
  FAICH   INTEGER                             DEFAULT 1,
  FAITI   INTEGER                                DEFAULT 120,
  FAIRL   INTEGER                            DEFAULT 2,
  FAIUN   INTEGER                             DEFAULT 2,
  FAIUS   TEXT,
  FAIPA   TEXT,
  FAITO   TEXT,
  FAIAF1  TEXT,
  FAIAF2  TEXT,
  FAIAF3  TEXT,
  FAIAF4  TEXT,
  SUID    TEXT,
  DATEI   DATE,
  DEVI    TEXT,
  STMIDI  TEXT,
  SOMIDI  INTEGER,
  SUCH    TEXT,
  DATEU   DATE,
  DEVU    TEXT,
  STMIDU  TEXT,
  SOMIDU  INTEGER,
  FAIST   INTEGER                            DEFAULT 1,
  JTID_L INTEGER,
  BIID_L INTEGER,
  SYID_L INTEGER,
  CIID_L TEXT  )
''');
    await db.execute('''
 CREATE TABLE FAT_CSID_INF(
  FCIID   INTEGER,
  FCIGU   TEXT,
  FCITY   TEXT                      DEFAULT 'P',
  CIIDL   INTEGER,
  JTIDL   INTEGER,
  BIIDL   INTEGER,
  BIIDV   TEXT,
  STMIDV  TEXT,
  SOMGUV  TEXT,
  SUIDV   TEXT,
  BMKIDV  TEXT,
  FCIBTV  TEXT,
  SCHNA   TEXT,
  FCIJOB  INTEGER                            DEFAULT 2,
  FCIDE   TEXT,
  FCICN   TEXT,
  FCISN   TEXT,
  FCIOI   TEXT,
  FCIOUN  TEXT,
  FCION   TEXT,
  FCIAD   TEXT,
  FCIFM   TEXT                    DEFAULT 'BOTH',
  FCIIPC  TEXT,
  FCICC   TEXT,
  FCILA   TEXT,
  FCIVN   TEXT,
  FCIOTP  TEXT,
  FCIPK   TEXT,
  FCICSR  TEXT,
  FCIBST  TEXT,
  FCISE   TEXT,
  FCIDI   TEXT,
  FCIDC   TEXT,
  FCIED   TEXT,
  FCIEM   TEXT,
  FCIZTS  TEXT,
  FCIJS   TEXT,
  FCIRI   TEXT,
  FCIDM   TEXT,
  FCIAF1  TEXT,
  FCIAF2  TEXT,
  FCIAF3  TEXT,
  FCIAF4  TEXT,
  FCIAF5  TEXT,
  SUID    TEXT,
  DATEI   DATE,
  DEVI    TEXT,
  STMIDI  TEXT,
  SOMIDI  INTEGER,
  SUCH    TEXT,
  DATEU   DATE,
  DEVU    TEXT,
  STMIDU  TEXT,
  SOMIDU  INTEGER,
  FCIST   INTEGER                             DEFAULT 1,
  DEFN    INTEGER                             DEFAULT 2,
  ORDNU   INTEGER,
  RES     TEXT,
  JTID_L INTEGER,
  BIID_L INTEGER,
  SYID_L INTEGER,
  CIID_L TEXT  )
''');
    await db.execute('''
 CREATE TABLE FAT_CSID_INF_D(
  FCIGU   TEXT,
  GUID    TEXT,
  FCIDTY  TEXT,
  FCIDVA  TEXT,
  JTID_L INTEGER,
  BIID_L INTEGER,
  SYID_L INTEGER,
  CIID_L TEXT  )
''');
    await db.execute('''
 CREATE TABLE FAT_CSID_SEQ(
  FCIGU   TEXT,
  FCSNO   INTEGER                                DEFAULT 0,
  FISSEQ  INTEGER,
  FISGU   TEXT,
  FCSHA   TEXT,
  SUID    TEXT,
  DATEI   DATE,
  DEVI    TEXT,
  STMIDI  TEXT,
  SOMIDI  INTEGER,
  SUCH    TEXT,
  DATEU   DATE,
  DEVU    TEXT,
  STMIDU  TEXT,
  SOMIDU  INTEGER,
  FCSFS INTEGER DEFAULT 2,
  JTID_L INTEGER,
  BIID_L INTEGER,
  SYID_L INTEGER,
  CIID_L TEXT  )
''');
    await db.execute('''
 CREATE TABLE FAT_CSID_ST(
    FCIGU   TEXT,
  FCSST   INTEGER                             DEFAULT 2,
  FCSHA   TEXT,
  SUCH    TEXT,
  DATEU   DATE,
  DEVU    TEXT,
  STMIDU  TEXT,
  SOMIDU  INTEGER,
  JTID_L INTEGER,
  BIID_L INTEGER,
  SYID_L INTEGER,
  CIID_L TEXT  )
''');

    await db.execute('''
 CREATE TABLE FAT_INV_HOL(
  FCIGU   TEXT,
  CIIDL   INTEGER,
  JTIDL   INTEGER,
  BIIDL   INTEGER,
  SYIDL   INTEGER,
  SCHNA   TEXT,
  BMMGU   TEXT,
  SID     TEXT,
  SERIAL  TEXT,
  FIHHA   TEXT,
  SUCH    TEXT,
  DATEU   TEXT,
  DEVU    TEXT,
  STMIDU  TEXT,
  SOMIDU  INTEGER,
  JTID_L INTEGER,
  BIID_L INTEGER,
  SYID_L INTEGER,
  CIID_L TEXT  )
''');

    await db.execute('''
 CREATE TABLE FAT_INV_JOBS(
  FIJSEQ  INTEGER primary key autoincrement,
  FIGGU   TEXT,
  FSLGU   TEXT,
  FISGU   TEXT,
  FCIGU   TEXT,
  CIIDL   INTEGER,
  JTIDL   INTEGER,
  BIIDL   INTEGER,
  SYIDL   INTEGER,
  SCHNA   TEXT,
  BMMGU   TEXT,
  FIJTY   TEXT                      DEFAULT 'P',
  FIJJY   INTEGER,
  FIJIS   INTEGER,
  FIJDA   DATE                                  DEFAULT SYSDATE,
  FIJST   INTEGER,
  SUID    TEXT,
  DATEI   DATE                                  DEFAULT SYSDATE,
  DEVI    TEXT,
  STMIDI  TEXT,
  SOMIDI  INTEGER,
  SUCH    TEXT,
  DATEU   DATE,
  DEVU    TEXT,
  STMIDU  TEXT,
  SOMIDU  INTEGER,
  JTID_L INTEGER,
  BIID_L INTEGER,
  SYID_L INTEGER,
  CIID_L TEXT  )
''');

    await db.execute('''
 CREATE TABLE FAT_INV_RS(
    FIRSEQ   INTEGER primary key autoincrement,
  GUID     TEXT,
  FISSEQ   INTEGER,
  FISGU    TEXT,
  FCIGU    TEXT,
  CIIDL    INTEGER,
  JTIDL    INTEGER,
  BIIDL    INTEGER,
  SYIDL    INTEGER,
  SCHNA    TEXT,
  BMMGU    TEXT,
  FIREQD   TEXT,
  FIRESC   TEXT,
  FIRERR   TEXT,
  FIRESD   TEXT,
  FIRDA    DATE,
  SUID     TEXT,
  DATEI    DATE,
  DEVI     TEXT,
  STMIDI   TEXT,
  SOMIDI   INTEGER,
  SUCH     TEXT,
  DATEU    DATE,
  DEVU     TEXT,
  STMIDU   TEXT,
  SOMIDU   INTEGER,
  FIRFS INTEGER DEFAULT 2,
  JTID_L INTEGER,
  BIID_L INTEGER,
  SYID_L INTEGER,
  CIID_L TEXT  )
''');
    await db.execute('''
 CREATE TABLE FAT_INV_SND(
    FISSEQ   INTEGER primary key autoincrement,
  FISGU      TEXT,
  FCIGU      TEXT,
  CIIDL      INTEGER,
  JTIDL      INTEGER,
  BIIDL      INTEGER,
  SYIDL      INTEGER,
  SCHNA      TEXT,
  UUID       TEXT,
  STID       TEXT,
  BMMGU      TEXT,
  FISSI      INTEGER                          DEFAULT 2,
  FISST      INTEGER,
  FISICV     INTEGER,
  FISPIN     INTEGER,
  FISPGU     TEXT,
  FISPIH     TEXT,
  FISIH      TEXT,
  FISQR      TEXT,
  FISZHS     TEXT,
  FISZHSO    TEXT,
  FISZS      TEXT,
  FISIS      TEXT,
  FISINF     TEXT,
  FISWE      INTEGER                          DEFAULT 2,
  FISEE      INTEGER                         DEFAULT 2,
  FISXML     TEXT,
  FISTOT     INTEGER,
  FISSUM     INTEGER,
  FISTWV     INTEGER,
  FISSD      DATE,
  FISLSD     DATE,
  FISNS      INTEGER                             DEFAULT 0,
  SOMGU      TEXT,
  SYDV_APPV  TEXT,
  SMID       INTEGER,
  SYDV_APIV  TEXT,
  SUID       TEXT,
  DATEI      DATE,
  DEVI       TEXT,
  STMIDI     TEXT,
  SOMIDI     INTEGER,
  SUCH       TEXT,
  DATEU      DATE,
  DEVU       TEXT,
  STMIDU     TEXT,
  SOMIDU     INTEGER,
  FISSTO     INTEGER,
  FISST2      INTEGER,
   FISFS INTEGER DEFAULT 2,
  JTID_L INTEGER,
  BIID_L INTEGER,
  SYID_L INTEGER,
  CIID_L TEXT  )
''');
    await db.execute('''
 CREATE TABLE FAT_INV_SND_ARC(
    FISSEQ     INTEGER,
  FISGU      TEXT,
  FCIGU      TEXT,
  CIIDL      INTEGER,
  JTIDL      INTEGER,
  BIIDL      INTEGER,
  SYIDL      INTEGER,
  SCHNA      TEXT,
  UUID       TEXT,
  STID       TEXT,
  BMMGU      TEXT,
  FISSI      INTEGER                          DEFAULT 2,
  FISST      INTEGER,
  FISICV     INTEGER,
  FISPIN     INTEGER,
  FISPGU     TEXT,
  FISPIH     TEXT,
  FISIH      TEXT,
  FISQR      TEXT,
  FISZHS     TEXT,
  FISZHSO    TEXT,
  FISZS      TEXT,
  FISIS      TEXT,
  FISINF     TEXT,
  FISWE      INTEGER                          DEFAULT 2,
  FISEE      INTEGER                         DEFAULT 2,
  FISXML     TEXT,
  FISTOT     INTEGER,
  FISSUM     INTEGER,
  FISTWV     INTEGER,
  FISSD      DATE,
  FISLSD     DATE,
  FISNS      INTEGER                             DEFAULT 0,
  SOMGU      TEXT,
  SYDV_APPV  TEXT,
  SMID       INTEGER,
  SYDV_APIV  TEXT,
  SUID       TEXT,
  DATEI      DATE,
  DEVI       TEXT,
  STMIDI     TEXT,
  SOMIDI     INTEGER,
  SUCH       TEXT,
  DATEU      DATE,
  DEVU       TEXT,
  STMIDU     TEXT,
  SOMIDU     INTEGER,
  FISSTO     INTEGER,
  JTID_L INTEGER,
  BIID_L INTEGER,
  SYID_L INTEGER,
  CIID_L TEXT  )
''');
    await db.execute('''
 CREATE TABLE FAT_QUE(
  FQTY    TEXT,
  GUID    TEXT,
  SCHNA   TEXT,
  FQQU1   TEXT,
  FQQU2   TEXT,
  FQQU3   TEXT,
  FQQU4   TEXT,
  FQQU5   TEXT,
  SUID    TEXT,
  DATEI   DATE            DEFAULT SYSDATE,
  DEVI    TEXT,
  STMIDI  TEXT,
  SOMIDI  INTEGER,
  SUCH    TEXT,
  DATEU   DATE,
  DEVU    TEXT,
  STMIDU  TEXT,
  SOMIDU  INTEGER,
  JTID_L INTEGER,
  BIID_L INTEGER,
  SYID_L INTEGER,
  CIID_L TEXT  )
''');
    await db.execute('''
 CREATE TABLE FAT_LOG(
    FLSEQ   INTEGER primary key autoincrement,
  GUID    TEXT,
  FCIGU   TEXT,
  FISGU   TEXT,
  CIIDL   INTEGER,
  JTIDL   INTEGER,
  BIIDL   INTEGER,
  SYIDL   INTEGER,
  SCHNA   TEXT,
  BMMGU   TEXT,
  FLTY    TEXT,
  FLPRO   TEXT,
  FLMSG   TEXT,
  SUID    TEXT,
  DATEI   DATE,
  DEVI    TEXT,
  STMIDI  TEXT,
  SOMIDI  INTEGER,
  JTID_L INTEGER,
  BIID_L INTEGER,
  SYID_L INTEGER,
  CIID_L TEXT  )
''');
    await db.execute('''
 CREATE TABLE FAT_SND_LOG(
    FSLSEQ  INTEGER primary key autoincrement,
  FSLGU   TEXT,
  FSLTY   TEXT                      DEFAULT 'P',
  FCIGU   TEXT,
  CIIDL   INTEGER,
  JTIDL   INTEGER,
  BIIDL   INTEGER,
  SYIDL   INTEGER,
  SCHNA   TEXT,
  BMMGU   TEXT,
  FISGU   TEXT,
  FSLPT   INTEGER,
  FSLJOB  INTEGER                            DEFAULT 2,
  SSID    INTEGER,
  FSLSIG  INTEGER,
  FSLCIE  INTEGER,
  FSLSTP  INTEGER,
  FSLST   INTEGER,
  FSLRT   INTEGER,
  FSLMSG  TEXT,
  FSLIS   INTEGER,
  SUID    TEXT,
  DATEI   DATE,
  DEVI    TEXT,
  STMIDI  TEXT,
  SOMIDI  INTEGER,
  FSLFS INTEGER DEFAULT 2,
  JTID_L INTEGER,
  BIID_L INTEGER,
  SYID_L INTEGER,
  CIID_L TEXT  )
''');
    await db.execute('''
 CREATE TABLE FAT_SND_LOG_D(
      FSLSEQ  INTEGER,
  FSLDRQ  TEXT,
  FSLDRC  TEXT,
  FSLDER  TEXT,
  FSLDRS  TEXT,
  FSLDFS INTEGER DEFAULT 2,
  JTID_L INTEGER,
  BIID_L INTEGER,
  SYID_L INTEGER,
  CIID_L TEXT  )
''');
    await db.execute('''
 CREATE TABLE FAT_SND_LOG_ARC(
  FSLSEQ  INTEGER,
  FSLGU   TEXT,
  FSLTY   TEXT,
  FCIGU   TEXT,
  CIIDL   INTEGER,
  JTIDL   INTEGER,
  BIIDL   INTEGER,
  SYIDL   INTEGER,
  SCHNA   TEXT,
  BMMGU   TEXT,
  FISGU   TEXT,
  FSLPT   INTEGER,
  FSLJOB  INTEGER,
  SSID    INTEGER,
  FSLSIG  INTEGER,
  FSLCIE  INTEGER,
  FSLSTP  INTEGER,
  FSLST   INTEGER,
  FSLRT   INTEGER,
  FSLMSG  TEXT,
  FSLIS   INTEGER,
  SUID    TEXT,
  DATEI   DATE,
  DEVI    TEXT,
  STMIDI  TEXT,
  SOMIDI  INTEGER,
  JTID_L INTEGER,
  BIID_L INTEGER,
  SYID_L INTEGER,
  CIID_L TEXT  )
''');
    await db.execute('''
 CREATE TABLE FAT_SND_LOG_D_ARC(
      FSLSEQ  INTEGER,
  FSLDRQ  TEXT,
  FSLDRC  TEXT,
  FSLDER  TEXT,
  FSLDRS  TEXT,
  JTID_L INTEGER,
  BIID_L INTEGER,
  SYID_L INTEGER,
  CIID_L TEXT  )
''');
    await db.execute('''
 CREATE TABLE TAX_MOV_T(
   TTID   INTEGER      DEFAULT 1,
  TMTTY  TEXT,
  TMTID  INTEGER,
  TMTNA  TEXT,
  TMTNE  TEXT,
  TMTN3  TEXT,
  TMTST  INTEGER       DEFAULT 1,
  TTTP   INTEGER,
  ATTID  TEXT,
  TMTMN  TEXT,
  TRTID  INTEGER,
  DATEI  DATE    DEFAULT SYSDATE,
  DATEU  DATE,
  SUID   TEXT,
  SUCH   TEXT,
  GUID   TEXT,
  DEVI   TEXT,
  DEVU   TEXT,
  JTID_L INTEGER,
  BIID_L INTEGER,
  SYID_L INTEGER,
  CIID_L TEXT  )
''');

    await db.execute('''
         CREATE TABLE SYS_ACC_M (
   SAMID  INTEGER,
  SAMNA  TEXT,
  SAMNE  TEXT,
  AANO   TEXT,
  SAMTY  INTEGER                            DEFAULT 1,
  STID   TEXT,
  SAMST  INTEGER                             DEFAULT 1,
  SAMDO  DATE,
  SUID   TEXT,
  SAMKI  INTEGER,
  BIID   INTEGER,
  SAMN3  TEXT,
  SUCH   TEXT,
  DATEU  DATE,
  DEVU   TEXT,
  RES    TEXT,
  JTID_L INTEGER,
  BIID_L INTEGER,
  SYID_L INTEGER,
  CIID_L TEXT   )  
      ''');


    await db.execute('''INSERT INTO SYN_ORD(SOET,ROW_NUM,SOOR,SOST,SOPK,JTID_L,BIID_L,SYID_L,CIID_L) values('ACC_TAX_C',0,44,1,'GUID', ${LoginController().JTID},${LoginController().BIID},${LoginController().SYID},'${LoginController().CIID}')''');
    await db.execute('''INSERT INTO SYN_ORD(SOET,ROW_NUM,SOOR,SOST,SOPK,JTID_L,BIID_L,SYID_L,CIID_L) values('TAX_MOV_T',0,45,1,'GUID', ${LoginController().JTID},${LoginController().BIID},${LoginController().SYID},'${LoginController().CIID}')''');
    await db.execute('''INSERT INTO SYN_ORD(SOET,ROW_NUM,SOOR,SOST,SOPK,JTID_L,BIID_L,SYID_L,CIID_L) values('TAX_PER_M',0,94,1,'GUID', ${LoginController().JTID},${LoginController().BIID},${LoginController().SYID},'${LoginController().CIID}')''');
    await db.execute('''INSERT INTO SYN_ORD(SOET,ROW_NUM,SOOR,SOST,SOPK,JTID_L,BIID_L,SYID_L,CIID_L) values('TAX_PER_D',0,95,1,'GUID', ${LoginController().JTID},${LoginController().BIID},${LoginController().SYID},'${LoginController().CIID}')''');
    await db.execute('''INSERT INTO SYN_ORD(SOET,ROW_NUM,SOOR,SOST,SOPK,JTID_L,BIID_L,SYID_L,CIID_L) values('TAX_PER_BRA',0,96,1,'GUID', ${LoginController().JTID},${LoginController().BIID},${LoginController().SYID},'${LoginController().CIID}')''');
    await db.execute('''INSERT INTO SYN_ORD(SOET,ROW_NUM,SOOR,SOST,SOPK,JTID_L,BIID_L,SYID_L,CIID_L) values('FAT_API_INF',0,112,1,'GUID', ${LoginController().JTID},${LoginController().BIID},${LoginController().SYID},'${LoginController().CIID}')''');
    await db.execute('''INSERT INTO SYN_ORD(SOET,ROW_NUM,SOOR,SOST,SOPK,JTID_L,BIID_L,SYID_L,CIID_L) values('FAT_CSID_INF',0,113,1,'FCIGU', ${LoginController().JTID},${LoginController().BIID},${LoginController().SYID},'${LoginController().CIID}')''');
    await db.execute('''INSERT INTO SYN_ORD(SOET,ROW_NUM,SOOR,SOST,SOPK,JTID_L,BIID_L,SYID_L,CIID_L) values('FAT_CSID_INF_D',0,114,1,'GUID', ${LoginController().JTID},${LoginController().BIID},${LoginController().SYID},'${LoginController().CIID}')''');
    await db.execute('''INSERT INTO SYN_ORD(SOET,ROW_NUM,SOOR,SOST,SOPK,JTID_L,BIID_L,SYID_L,CIID_L) values('FAT_CSID_SEQ',0,115,1,'FCIGU', ${LoginController().JTID},${LoginController().BIID},${LoginController().SYID},'${LoginController().CIID}')''');
    await db.execute('''INSERT INTO SYN_ORD(SOET,ROW_NUM,SOOR,SOST,SOPK,JTID_L,BIID_L,SYID_L,CIID_L) values('FAT_CSID_ST',0,116,1,'FCIGU', ${LoginController().JTID},${LoginController().BIID},${LoginController().SYID},'${LoginController().CIID}')''');
    await db.execute('''INSERT INTO SYN_ORD(SOET,ROW_NUM,SOOR,SOST,SOPK,JTID_L,BIID_L,SYID_L,CIID_L) values('FAT_INV_SND',0,117,1,'FISGU', ${LoginController().JTID},${LoginController().BIID},${LoginController().SYID},'${LoginController().CIID}')''');
    await db.execute('''INSERT INTO SYN_ORD(SOET,ROW_NUM,SOOR,SOST,SOPK,JTID_L,BIID_L,SYID_L,CIID_L) values('FAT_INV_SND_ARC',0,118,1,'FISGU', ${LoginController().JTID},${LoginController().BIID},${LoginController().SYID},'${LoginController().CIID}')''');
    await db.execute('''INSERT INTO SYN_ORD(SOET,ROW_NUM,SOOR,SOST,SOPK,JTID_L,BIID_L,SYID_L,CIID_L) values('FAT_INV_RS',0,119,1,'GUID', ${LoginController().JTID},${LoginController().BIID},${LoginController().SYID},'${LoginController().CIID}')''');
    await db.execute('''INSERT INTO SYN_ORD(SOET,ROW_NUM,SOOR,SOST,SOPK,JTID_L,BIID_L,SYID_L,CIID_L) values('FAT_QUE',0,120,1,'GUID', ${LoginController().JTID},${LoginController().BIID},${LoginController().SYID},'${LoginController().CIID}')''');
    await db.execute('''INSERT INTO SYN_ORD(SOET,ROW_NUM,SOOR,SOST,SOPK,JTID_L,BIID_L,SYID_L,CIID_L) values('FAT_CSID_SEQ',0,163,1,'FCIGU', ${LoginController().JTID},${LoginController().BIID},${LoginController().SYID},'${LoginController().CIID}')''');
    await db.execute('''INSERT INTO SYN_ORD(SOET,ROW_NUM,SOOR,SOST,SOPK,JTID_L,BIID_L,SYID_L,CIID_L) values('FAT_CSID_ST',0,164,1,'FCIGU', ${LoginController().JTID},${LoginController().BIID},${LoginController().SYID},'${LoginController().CIID}')''');
    await db.execute('''INSERT INTO SYN_ORD(SOET,ROW_NUM,SOOR,SOST,SOPK,JTID_L,BIID_L,SYID_L,CIID_L) values('FAT_INV_SND',0,165,1,'FISGU', ${LoginController().JTID},${LoginController().BIID},${LoginController().SYID},'${LoginController().CIID}')''');
    await db.execute('''INSERT INTO SYN_ORD(SOET,ROW_NUM,SOOR,SOST,SOPK,JTID_L,BIID_L,SYID_L,CIID_L) values('FAT_INV_RS',0,166,1,'GUID', ${LoginController().JTID},${LoginController().BIID},${LoginController().SYID},'${LoginController().CIID}')''');
    await db.execute('''INSERT INTO SYN_ORD(SOET,ROW_NUM,SOOR,SOST,SOPK,JTID_L,BIID_L,SYID_L,CIID_L) values('FAT_SND_LOG',0,167,1,'FSLGU', ${LoginController().JTID},${LoginController().BIID},${LoginController().SYID},'${LoginController().CIID}')''');
    await db.execute('''INSERT INTO SYN_ORD(SOET,ROW_NUM,SOOR,SOST,SOPK,JTID_L,BIID_L,SYID_L,CIID_L) values('FAT_SND_LOG_D',0,168,1,'FSLGU', ${LoginController().JTID},${LoginController().BIID},${LoginController().SYID},'${LoginController().CIID}')''');

    //   08-09-2024
    await db.execute('''CREATE TABLE FAT_API_INF_TMP AS SELECT  * FROM FAT_API_INF WHERE 1=2''');
    await db.execute('''CREATE TABLE FAT_CSID_INF_TMP AS SELECT  * FROM FAT_CSID_INF WHERE 1=2''');
    await db.execute('''CREATE TABLE FAT_CSID_INF_D_TMP AS SELECT  * FROM FAT_CSID_INF_D WHERE 1=2''');
    await db.execute('''CREATE TABLE FAT_CSID_SEQ_TMP AS SELECT  * FROM FAT_CSID_SEQ WHERE 1=2''');
    await db.execute('''CREATE TABLE FAT_CSID_ST_TMP AS SELECT  * FROM FAT_CSID_ST WHERE 1=2''');
    await db.execute('''CREATE TABLE FAT_INV_HOL_TMP AS SELECT  * FROM FAT_INV_HOL WHERE 1=2''');
    await db.execute('''CREATE TABLE FAT_INV_JOBS_TMP AS SELECT  * FROM FAT_INV_JOBS WHERE 1=2''');
    await db.execute('''CREATE TABLE FAT_INV_RS_TMP AS SELECT  * FROM FAT_INV_RS WHERE 1=2''');
    await db.execute('''CREATE TABLE FAT_INV_SND_TMP AS SELECT  * FROM FAT_INV_SND WHERE 1=2''');
    await db.execute('''CREATE TABLE FAT_INV_SND_ARC_TMP AS SELECT  * FROM FAT_INV_SND_ARC WHERE 1=2''');
    await db.execute('''CREATE TABLE FAT_QUE_TMP AS SELECT  * FROM FAT_QUE WHERE 1=2''');
    await db.execute('''CREATE TABLE FAT_LOG_TMP AS SELECT  * FROM FAT_LOG WHERE 1=2''');
    await db.execute('''CREATE TABLE FAT_SND_LOG_TMP AS SELECT  * FROM FAT_SND_LOG WHERE 1=2''');
    await db.execute('''CREATE TABLE FAT_SND_LOG_D_TMP AS SELECT  * FROM FAT_SND_LOG_D WHERE 1=2''');
    await db.execute('''CREATE TABLE FAT_SND_LOG_ARC_TMP AS SELECT  * FROM FAT_SND_LOG_ARC WHERE 1=2''');
    await db.execute('''CREATE TABLE FAT_SND_LOG_D_ARC_TMP AS SELECT  * FROM FAT_SND_LOG_D_ARC WHERE 1=2''');
    await db.execute('''CREATE TABLE TAX_MOV_T_TMP AS SELECT  * FROM TAX_MOV_T WHERE 1=2''');
    await db.execute('''CREATE TABLE SYS_ACC_M_TMP AS SELECT  * FROM SYS_ACC_M WHERE 1=2''');

    //09-09-2024
    await db.execute('''CREATE INDEX FAT_API_INF_I1 on FAT_API_INF(FAISP, STMID, FAITY)''');
    await db.execute('''CREATE INDEX FAT_API_INF_I2 on FAT_API_INF(FAISP, STMID, FAITY,JTID_L,SYID_L,CIID_L)''');
    await db.execute('''CREATE INDEX FAT_CSID_INF_I1 on FAT_CSID_INF(FCIID)''');
    await db.execute('''CREATE INDEX FAT_CSID_INF_I2 on FAT_CSID_INF(FCIID,JTID_L,SYID_L,CIID_L)''');
    await db.execute('''CREATE INDEX FAT_CSID_INF_I3 on FAT_CSID_INF(FCITY, CIIDL, JTIDL, BIIDL, BIIDV,STMIDV, SOMGUV, SUIDV, BMKIDV, FCIBTV, FCIJOB, FCIST)''');
    await db.execute('''CREATE INDEX FAT_CSID_SEQ_I1 on FAT_CSID_SEQ(FCIGU,JTID_L,SYID_L,CIID_L)''');
    await db.execute('''CREATE INDEX FAT_CSID_ST_I1 on FAT_CSID_ST(FCIGU,JTID_L,SYID_L,CIID_L)''');
    await db.execute('''CREATE INDEX FAT_INV_RS_I1 on FAT_INV_RS(FISGU,JTID_L,SYID_L,CIID_L)''');
    await db.execute('''CREATE INDEX FAT_INV_RS_I2 on FAT_INV_RS(BMMGU,JTID_L,SYID_L,CIID_L)''');
    await db.execute('''CREATE INDEX FAT_INV_SND_I1 on FAT_INV_SND(FISSEQ,JTID_L,SYID_L,CIID_L)''');
    await db.execute('''CREATE INDEX FAT_INV_SND_I2 on FAT_INV_SND(FCIGU,JTID_L,SYID_L,CIID_L)''');
    await db.execute('''CREATE INDEX FAT_INV_SND_I3 on FAT_INV_SND(CIIDL, JTIDL, BIIDL, SYIDL)''');
    await db.execute('''CREATE INDEX FAT_INV_SND_I4 on FAT_INV_SND(BMMGU,JTID_L,SYID_L,CIID_L)''');
    await db.execute('''CREATE INDEX FAT_INV_SND_I5 on FAT_INV_SND(FISST,JTID_L,SYID_L,CIID_L)''');
    await db.execute('''CREATE INDEX FAT_LOG_I1 on FAT_LOG(FLSEQ,JTID_L,SYID_L,CIID_L)''');
    await db.execute('''CREATE INDEX FAT_LOG_I2 on FAT_LOG(CIIDL, JTIDL, BIIDL, SYIDL)''');
    await db.execute('''CREATE INDEX FAT_LOG_I3 on FAT_LOG(BMMGU,JTID_L,SYID_L,CIID_L)''');
    await db.execute('''CREATE INDEX FAT_SND_LOG_I1 on FAT_SND_LOG(FSLSEQ,JTID_L,SYID_L,CIID_L)''');
    await db.execute('''CREATE INDEX FAT_SND_LOG_I2 on FAT_SND_LOG(BMMGU,JTID_L,SYID_L,CIID_L)''');
    await db.execute('''CREATE INDEX FAT_SND_LOG_I3 on FAT_SND_LOG(FSLGU,JTID_L,SYID_L,CIID_L)''');
    await db.execute('''CREATE INDEX FAT_SND_LOG_D_I1 on FAT_SND_LOG_D(FSLSEQ,JTID_L,SYID_L,CIID_L)''');

  }

  Future OnUpgradeV449_11 (Database db) async{

    // await db.execute('''ALTER TABLE FAT_INV_RS ADD COLUMN FIRFS INTEGER DEFAULT 2''');
    // await db.execute('''ALTER TABLE FAT_SND_LOG ADD COLUMN FSLFS INTEGER DEFAULT 2''');
    // await db.execute('''ALTER TABLE FAT_SND_LOG_D ADD COLUMN FSLDFS INTEGER DEFAULT 2''');
    // await db.execute('''ALTER TABLE FAT_SND_LOG_D ADD COLUMN FSLGU TEXT''');
    // await db.execute('''ALTER TABLE FAT_SND_LOG_D_ARC ADD COLUMN FSLGU TEXT''');
    // await db.execute('''ALTER TABLE FAT_CSID_SEQ ADD COLUMN FCSFS INTEGER DEFAULT 2''');
    // await db.execute('''ALTER TABLE ACC_MOV_D ADD COLUMN GUIDC TEXT''');
    //
    // await db.execute('''ALTER TABLE FAT_INV_RS_TMP ADD COLUMN FIRFS INTEGER DEFAULT 2''');
    // await db.execute('''ALTER TABLE FAT_SND_LOG_TMP ADD COLUMN FSLFS INTEGER DEFAULT 2''');
    // await db.execute('''ALTER TABLE FAT_SND_LOG_D_TMP ADD COLUMN FSLDFS INTEGER DEFAULT 2''');
    // await db.execute('''ALTER TABLE FAT_SND_LOG_D_TMP ADD COLUMN FSLGU TEXT''');
    // await db.execute('''ALTER TABLE FAT_SND_LOG_D_ARC_TMP ADD COLUMN FSLGU TEXT''');
    // await db.execute('''ALTER TABLE FAT_CSID_SEQ_TMP ADD COLUMN FCSFS INTEGER DEFAULT 2''');

    //2024-10-13
    await db.execute('''DROP TABLE IF EXISTS FAT_INV_SND ''');
    await db.execute('''DROP TABLE IF EXISTS FAT_INV_SND_TMP ''');
    await db.execute('''DROP TABLE IF EXISTS FAT_INV_SND_ARC ''');
    await db.execute('''DROP TABLE IF EXISTS FAT_INV_SND_ARC_TMP ''');

    await db.execute('''
 CREATE TABLE FAT_INV_SND(
    FISSEQ     INTEGER primary key autoincrement,
  FISGU      TEXT,
  FCIGU      TEXT,
  CIIDL      INTEGER,
  JTIDL      INTEGER,
  BIIDL      INTEGER,
  SYIDL      INTEGER,
  SCHNA      TEXT,
  UUID       TEXT,
  STID       TEXT,
  BMMGU      TEXT,
  FISSI      INTEGER                          DEFAULT 2,
  FISST      INTEGER,
  FISICV     INTEGER,
  FISPIN     INTEGER,
  FISPGU     TEXT,
  FISPIH     TEXT,
  FISIH      TEXT,
  FISQR      TEXT,
  FISZHS     TEXT,
  FISZHSO    TEXT,
  FISZS      TEXT,
  FISIS      TEXT,
  FISINF     TEXT,
  FISWE      INTEGER                          DEFAULT 2,
  FISEE      INTEGER                         DEFAULT 2,
  FISXML     TEXT,
  FISTOT     REAL,
  FISSUM     REAL,
  FISTWV     REAL,
  FISSD      DATE,
  FISLSD     DATE,
  FISNS      INTEGER                             DEFAULT 0,
  SOMGU      TEXT,
  SYDV_APPV  TEXT,
  SMID       INTEGER,
  SYDV_APIV  TEXT,
  SUID       TEXT,
  DATEI      DATE,
  DEVI       TEXT,
  STMIDI     TEXT,
  SOMIDI     INTEGER,
  SUCH       TEXT,
  DATEU      DATE,
  DEVU       TEXT,
  STMIDU     TEXT,
  SOMIDU     INTEGER,
  FISSTO     INTEGER,
  FISST2      INTEGER,
   FISFS INTEGER DEFAULT 2,
  JTID_L INTEGER,
  BIID_L INTEGER,
  SYID_L INTEGER,
  CIID_L TEXT  )
''');
    await db.execute('''
 CREATE TABLE FAT_INV_SND_ARC(
    FISSEQ     INTEGER,
  FISGU      TEXT,
  FCIGU      TEXT,
  CIIDL      INTEGER,
  JTIDL      INTEGER,
  BIIDL      INTEGER,
  SYIDL      INTEGER,
  SCHNA      TEXT,
  UUID       TEXT,
  STID       TEXT,
  BMMGU      TEXT,
  FISSI      INTEGER                          DEFAULT 2,
  FISST      INTEGER,
  FISICV     INTEGER,
  FISPIN     INTEGER,
  FISPGU     TEXT,
  FISPIH     TEXT,
  FISIH      TEXT,
  FISQR      TEXT,
  FISZHS     TEXT,
  FISZHSO    TEXT,
  FISZS      TEXT,
  FISIS      TEXT,
  FISINF     TEXT,
  FISWE      INTEGER                          DEFAULT 2,
  FISEE      INTEGER                         DEFAULT 2,
  FISXML     TEXT,
  FISTOT     REAL,
  FISSUM     REAL,
  FISTWV     REAL,
  FISSD      DATE,
  FISLSD     DATE,
  FISNS      INTEGER                             DEFAULT 0,
  SOMGU      TEXT,
  SYDV_APPV  TEXT,
  SMID       INTEGER,
  SYDV_APIV  TEXT,
  SUID       TEXT,
  DATEI      DATE,
  DEVI       TEXT,
  STMIDI     TEXT,
  SOMIDI     INTEGER,
  SUCH       TEXT,
  DATEU      DATE,
  DEVU       TEXT,
  STMIDU     TEXT,
  SOMIDU     INTEGER,
  FISSTO     INTEGER,
  FISAFS INTEGER DEFAULT 2,
  JTID_L INTEGER,
  BIID_L INTEGER,
  SYID_L INTEGER,
  CIID_L TEXT  )
''');

    await db.execute('''CREATE TABLE FAT_INV_SND_TMP AS SELECT  * FROM FAT_INV_SND WHERE 1=2''');
    await db.execute('''CREATE TABLE FAT_INV_SND_ARC_TMP AS SELECT  * FROM FAT_INV_SND_ARC WHERE 1=2''');

    await db.execute('''CREATE INDEX FAT_INV_SND_I1 on FAT_INV_SND(FISSEQ,JTID_L,SYID_L,CIID_L)''');
    await db.execute('''CREATE INDEX FAT_INV_SND_I2 on FAT_INV_SND(FCIGU,JTID_L,SYID_L,CIID_L)''');
    await db.execute('''CREATE INDEX FAT_INV_SND_I3 on FAT_INV_SND(CIIDL, JTIDL, BIIDL, SYIDL)''');
    await db.execute('''CREATE INDEX FAT_INV_SND_I4 on FAT_INV_SND(BMMGU,JTID_L,SYID_L,CIID_L)''');
    await db.execute('''CREATE INDEX FAT_INV_SND_I5 on FAT_INV_SND(FISST,JTID_L,SYID_L,CIID_L)''');


    // // تنفيذ PRAGMA stats
    // await db.execute('PRAGMA stats;');
    //
    // // تنفيذ PRAGMA table_list
    // var tables = await db.rawQuery('PRAGMA table_list;');
    // print('Tables: $tables');
    //
    // // تنفيذ PRAGMA user_version
    // var userVersion = await db.rawQuery('PRAGMA user_version;');
    // print('User Version: $userVersion');
    //
    // // تنفيذ PRAGMA trusted_schema
    // await db.execute('PRAGMA trusted_schema;');
    //
    // // تنفيذ PRAGMA optimize
    // await db.execute('PRAGMA optimize;');
    //
    // // تنفيذ PRAGMA integrity_check
    // var integrityCheck = await db.rawQuery('PRAGMA integrity_check;');
    // print('Integrity Check: $integrityCheck');
    //
    // // تنفيذ PRAGMA quick_check
    // var quickCheck = await db.rawQuery('PRAGMA quick_check;');
    // print('Quick Check: $quickCheck');

  }

  Future OnUpgradeV449_12 (Database db) async{

    //13-11-2024
    await db.execute('''ALTER TABLE BIL_MOV_M ADD COLUMN TTLID INTEGER ''');
    await db.execute('''ALTER TABLE BIL_MOV_M ADD COLUMN TCRA   REAL ''');
    await db.execute('''ALTER TABLE BIL_MOV_M ADD COLUMN TCSDID  INTEGER ''');
    await db.execute('''ALTER TABLE BIL_MOV_M ADD COLUMN TCSDSY   TEXT ''');
    await db.execute('''ALTER TABLE BIL_MOV_M ADD COLUMN TCID   INTEGER ''');
    await db.execute('''ALTER TABLE BIL_MOV_M ADD COLUMN TCSY  TEXT ''');
    await db.execute('''ALTER TABLE BIL_MOV_M ADD COLUMN BMMAM_TX  REAL ''');
    await db.execute('''ALTER TABLE BIL_MOV_M ADD COLUMN BMMDI_TX  REAL ''');
    await db.execute('''ALTER TABLE BIL_MOV_M ADD COLUMN TCAM  REAL ''');
    await db.execute('''ALTER TABLE BIL_MOV_M ADD COLUMN BMMICV  INTEGER ''');
    await db.execute('''ALTER TABLE BIL_MOV_M ADD COLUMN BMMUU  TEXT ''');

    await db.execute('''ALTER TABLE BIF_MOV_M ADD COLUMN TTLID INTEGER ''');
    await db.execute('''ALTER TABLE BIF_MOV_M ADD COLUMN TCRA   REAL ''');
    await db.execute('''ALTER TABLE BIF_MOV_M ADD COLUMN TCSDID  INTEGER ''');
    await db.execute('''ALTER TABLE BIF_MOV_M ADD COLUMN TCSDSY   TEXT ''');
    await db.execute('''ALTER TABLE BIF_MOV_M ADD COLUMN TCID   INTEGER ''');
    await db.execute('''ALTER TABLE BIF_MOV_M ADD COLUMN TCSY  TEXT ''');
    await db.execute('''ALTER TABLE BIF_MOV_M ADD COLUMN BMMAM_TX  REAL ''');
    await db.execute('''ALTER TABLE BIF_MOV_M ADD COLUMN BMMDI_TX  REAL ''');
    await db.execute('''ALTER TABLE BIF_MOV_M ADD COLUMN TCAM  REAL ''');
    await db.execute('''ALTER TABLE BIF_MOV_M ADD COLUMN BMMICV  INTEGER ''');
    await db.execute('''ALTER TABLE BIF_MOV_M ADD COLUMN BMMUU  TEXT ''');

    await db.execute('''ALTER TABLE BIL_MOV_D ADD COLUMN TCRA   REAL ''');
    await db.execute('''ALTER TABLE BIL_MOV_D ADD COLUMN TCSDID  INTEGER ''');
    await db.execute('''ALTER TABLE BIL_MOV_D ADD COLUMN TCSDSY   TEXT ''');
    await db.execute('''ALTER TABLE BIL_MOV_D ADD COLUMN TCID   INTEGER ''');
    await db.execute('''ALTER TABLE BIL_MOV_D ADD COLUMN TCSY  TEXT ''');
    await db.execute('''ALTER TABLE BIL_MOV_D ADD COLUMN TCVL  INTEGER ''');
    await db.execute('''ALTER TABLE BIL_MOV_D ADD COLUMN BMDAM_TX  REAL ''');
    await db.execute('''ALTER TABLE BIL_MOV_D ADD COLUMN BMDDI_TX  REAL ''');
    await db.execute('''ALTER TABLE BIL_MOV_D ADD COLUMN BMDAMT3   REAL ''');
    await db.execute('''ALTER TABLE BIL_MOV_D ADD COLUMN TCAMT  REAL ''');

    await db.execute('''ALTER TABLE BIF_MOV_D ADD COLUMN TCRA   REAL ''');
    await db.execute('''ALTER TABLE BIF_MOV_D ADD COLUMN TCSDID  INTEGER ''');
    await db.execute('''ALTER TABLE BIF_MOV_D ADD COLUMN TCSDSY   TEXT ''');
    await db.execute('''ALTER TABLE BIF_MOV_D ADD COLUMN TCID   INTEGER ''');
    await db.execute('''ALTER TABLE BIF_MOV_D ADD COLUMN TCSY  TEXT ''');
    await db.execute('''ALTER TABLE BIF_MOV_D ADD COLUMN TCVL  INTEGER ''');
    await db.execute('''ALTER TABLE BIF_MOV_D ADD COLUMN BMDAM_TX  REAL ''');
    await db.execute('''ALTER TABLE BIF_MOV_D ADD COLUMN BMDDI_TX  REAL ''');
    await db.execute('''ALTER TABLE BIF_MOV_D ADD COLUMN BMDAMT3   REAL ''');
    await db.execute('''ALTER TABLE BIF_MOV_D ADD COLUMN TCAMT  REAL ''');


    //16-11-2024
    await db.execute('''
 CREATE TABLE FAT_INV_SND_D(
    FISDGU     TEXT,
  FISGU      TEXT,
  FISDTY      TEXT,
  FISDDA      TEXT,
  FISDFS INTEGER DEFAULT 2,
  JTID_L INTEGER,
  BIID_L INTEGER,
  SYID_L INTEGER,
  CIID_L TEXT  )
''');
    await db.execute('''
 CREATE TABLE FAT_INV_SND_R(
    FISRGU     TEXT,
    FISGU      TEXT,
    FISRTY      TEXT,
    FISRDA      TEXT,
    FISRFS INTEGER DEFAULT 2,
  JTID_L INTEGER,
  BIID_L INTEGER,
  SYID_L INTEGER,
  CIID_L TEXT  )
''');

    await db.execute('''CREATE TABLE FAT_INV_SND_D_ARC AS SELECT  * FROM FAT_INV_SND_D WHERE 1=2''');
    await db.execute('''CREATE TABLE FAT_INV_SND_R_ARC AS SELECT  * FROM FAT_INV_SND_R WHERE 1=2''');

    await db.execute('''CREATE INDEX FAT_INV_SND_D_I1 on FAT_INV_SND_D(FISDGU,JTID_L,SYID_L,CIID_L)''');
    await db.execute('''CREATE INDEX FAT_INV_SND_D_I2 on FAT_INV_SND_D(FISGU,JTID_L,SYID_L,CIID_L)''');
    await db.execute('''CREATE INDEX FAT_INV_SND_D_ARC_I1 on FAT_INV_SND_D_ARC(FISDGU, JTID_L,SYID_L,CIID_L)''');
    await db.execute('''CREATE INDEX FAT_INV_SND_D_ARC_I2 on FAT_INV_SND_D_ARC(FISGU,JTID_L,SYID_L,CIID_L)''');
    await db.execute('''CREATE INDEX FAT_INV_SND_R_I1 on FAT_INV_SND_R(FISRGU,JTID_L,SYID_L,CIID_L)''');
    await db.execute('''CREATE INDEX FAT_INV_SND_R_I2 on FAT_INV_SND_R(FISGU,JTID_L,SYID_L,CIID_L)''');
    await db.execute('''CREATE INDEX FAT_INV_SND_R_ARC_I1 on FAT_INV_SND_R_ARC(FISRGU, JTID_L,SYID_L,CIID_L)''');
    await db.execute('''CREATE INDEX FAT_INV_SND_R_ARC_I2 on FAT_INV_SND_R_ARC(FISGU,JTID_L,SYID_L,CIID_L)''');


    //2024-10-13
    await db.execute('''DROP TABLE IF EXISTS FAT_INV_SND ''');
    await db.execute('''DROP TABLE IF EXISTS FAT_INV_SND_TMP ''');
    await db.execute('''DROP TABLE IF EXISTS FAT_INV_SND_ARC ''');
    await db.execute('''DROP TABLE IF EXISTS FAT_INV_SND_ARC_TMP ''');
    await db.execute('''DROP TABLE IF EXISTS FAT_INV_RS ''');

    await db.execute('''
 CREATE TABLE FAT_INV_SND(
    FISSEQ     INTEGER primary key autoincrement,
  FISGU      TEXT,
  FCIGU      TEXT,
  CIIDL      INTEGER,
  JTIDL      INTEGER,
  BIIDL      INTEGER,
  SYIDL      INTEGER,
  SCHNA      TEXT,
  UUID       TEXT,
  STID       TEXT,
  BMMGU      TEXT,
  FISSI      INTEGER                          DEFAULT 2,
  FISST      INTEGER,
  FISICV     INTEGER,
  FISPIN     INTEGER,
  FISPGU     TEXT,
  FISPIH     TEXT,
  FISIH      TEXT,
  FISQR      TEXT,
  FISZHS     TEXT,
  FISZHSO    TEXT,
  FISZS      TEXT,
  FISIS      TEXT,
  FISINF     TEXT,
  FISWE      INTEGER                          DEFAULT 2,
  FISEE      INTEGER                         DEFAULT 2,
  FISXML     TEXT,
  FISTOT     REAL,
  FISSUM     REAL,
  FISTWV     REAL,
  FISSD      DATE,
  FISLSD     DATE,
  FISNS      INTEGER                             DEFAULT 0,
  SOMGU      TEXT,
  SYDV_APPV  TEXT,
  SMID       INTEGER,
  SYDV_APIV  TEXT,
  SUID       TEXT,
  DATEI      DATE,
  DEVI       TEXT,
  STMIDI     TEXT,
  SOMIDI     INTEGER,
  SUCH       TEXT,
  DATEU      DATE,
  DEVU       TEXT,
  STMIDU     TEXT,
  SOMIDU     INTEGER,
  FISSTO     INTEGER,
  FISST2      INTEGER,
  FISFS INTEGER DEFAULT 2,
  FISXE INTEGER DEFAULT 2,
  FISXN INTEGER DEFAULT 0,
  FISXNA TEXT,
  FISINO TEXT,
  JTID_L INTEGER,
  BIID_L INTEGER,
  SYID_L INTEGER,
  CIID_L TEXT  )
''');
    await db.execute('''
 CREATE TABLE FAT_INV_SND_ARC(
    FISSEQ     INTEGER,
  FISGU      TEXT,
  FCIGU      TEXT,
  CIIDL      INTEGER,
  JTIDL      INTEGER,
  BIIDL      INTEGER,
  SYIDL      INTEGER,
  SCHNA      TEXT,
  UUID       TEXT,
  STID       TEXT,
  BMMGU      TEXT,
  FISSI      INTEGER                          DEFAULT 2,
  FISST      INTEGER,
  FISICV     INTEGER,
  FISPIN     INTEGER,
  FISPGU     TEXT,
  FISPIH     TEXT,
  FISIH      TEXT,
  FISQR      TEXT,
  FISZHS     TEXT,
  FISZHSO    TEXT,
  FISZS      TEXT,
  FISIS      TEXT,
  FISINF     TEXT,
  FISWE      INTEGER                          DEFAULT 2,
  FISEE      INTEGER                         DEFAULT 2,
  FISXML     TEXT,
  FISTOT     REAL,
  FISSUM     REAL,
  FISTWV     REAL,
  FISSD      DATE,
  FISLSD     DATE,
  FISNS      INTEGER                             DEFAULT 0,
  SOMGU      TEXT,
  SYDV_APPV  TEXT,
  SMID       INTEGER,
  SYDV_APIV  TEXT,
  SUID       TEXT,
  DATEI      DATE,
  DEVI       TEXT,
  STMIDI     TEXT,
  SOMIDI     INTEGER,
  SUCH       TEXT,
  DATEU      DATE,
  DEVU       TEXT,
  STMIDU     TEXT,
  SOMIDU     INTEGER,
  FISSTO     INTEGER,
  FISAFS INTEGER DEFAULT 2,
  JTID_L INTEGER,
  BIID_L INTEGER,
  SYID_L INTEGER,
  CIID_L TEXT  )
''');
    await db.execute('''
 CREATE TABLE FAT_INV_RS(
    FIRSEQ   INTEGER primary key autoincrement,
  GUID     TEXT,
  FISSEQ   INTEGER,
  FISGU    TEXT,
  FCIGU    TEXT,
  CIIDL    INTEGER,
  JTIDL    INTEGER,
  BIIDL    INTEGER,
  SYIDL    INTEGER,
  SCHNA    TEXT,
  BMMGU    TEXT,
  FIREQD   TEXT,
  FIRESC   TEXT,
  FIRERR   TEXT,
  FIRESD   TEXT,
  FIRDA    DATE,
  SUID     TEXT,
  DATEI    DATE,
  DEVI     TEXT,
  STMIDI   TEXT,
  SOMIDI   INTEGER,
  SUCH     TEXT,
  DATEU    DATE,
  DEVU     TEXT,
  STMIDU   TEXT,
  SOMIDU   INTEGER,
  FIRFS INTEGER DEFAULT 2,
  JTID_L INTEGER,
  BIID_L INTEGER,
  SYID_L INTEGER,
  CIID_L TEXT  )
''');


    await db.execute('''CREATE TABLE FAT_INV_SND_TMP AS SELECT  * FROM FAT_INV_SND WHERE 1=2''');
    await db.execute('''CREATE TABLE FAT_INV_SND_ARC_TMP AS SELECT  * FROM FAT_INV_SND_ARC WHERE 1=2''');

  }

  //21-11-2024 --تحديث 13
  Future OnUpgradeV449_13 (Database db) async{

    Future<bool> isColumnExists( String tableName, String columnName) async {
      // final conn = DatabaseHelper.instance;
      // var dbClient = await conn.database;
      var result = await db.rawQuery('PRAGMA table_info($tableName)');
      for (var column in result) {
        if (column['name'] == columnName) {
          return true; // العمود موجود
        }
      }
      return false; // العمود غير موجود
    }
    Future<void> addColumnIfNotExists( String tableName, String columnName ,String Typecolumn) async {
      bool exists = await isColumnExists( tableName, columnName);

      if (!exists) {
        // إضافة العمود إلى الجدول
        String sql = 'ALTER TABLE $tableName ADD COLUMN $columnName $Typecolumn'; // يمكنك تغيير نوع العمود حسب الحاجة
        await db.execute(sql);
        print('تم إضافة العمود: $columnName إلى الجدول: $tableName');
      } else {
        print('العمود موجود بالفعل: $columnName');
      }
    }

    // مثال على كيفية استدعاء الدالة
    Future<void> CHIK_DB(String tableName, String columnName,Typecolumn) async {
      // اسم الجدول والعمود الذي ترغب في التحقق منه

      // استدعاء الدالة لإضافة العمود إذا لم يكن موجودًا
      print('اسم الجدول: $tableName');
      print('اسم العمود: $columnName');
      print('قاعدة البيانات: $db');
      print('تشغيل الدالة CHIK_DB');
      addColumnIfNotExists( tableName, columnName,Typecolumn);

      // إغلاق قاعدة البيانات
      // await dbClient!.close();
    }

    //21-11-2024
    CHIK_DB('BIL_MOV_M','TTLID','INTEGER');
    CHIK_DB('BIL_MOV_M','TCRA','REAL');
    CHIK_DB('BIL_MOV_M','TCSDID','INTEGER');
    CHIK_DB('BIL_MOV_M','TCSDSY','TEXT');
    CHIK_DB('BIL_MOV_M','TCID','INTEGER');
    CHIK_DB('BIL_MOV_M','TCSY','TEXT');
    CHIK_DB('BIL_MOV_M','BMMAM_TX','REAL');
    CHIK_DB('BIL_MOV_M','BMMDI_TX','REAL');
    CHIK_DB('BIL_MOV_M','TCAM','REAL');
    CHIK_DB('BIL_MOV_M','BMMICV','INTEGER');
    CHIK_DB('BIL_MOV_M','BMMUU','TEXT');

    CHIK_DB('BIF_MOV_M','TTLID','INTEGER');
    CHIK_DB('BIF_MOV_M','TCRA','REAL');
    CHIK_DB('BIF_MOV_M','TCSDID','INTEGER');
    CHIK_DB('BIF_MOV_M','TCSDSY','TEXT');
    CHIK_DB('BIF_MOV_M','TCID','INTEGER');
    CHIK_DB('BIF_MOV_M','TCSY','TEXT');
    CHIK_DB('BIF_MOV_M','BMMAM_TX','REAL');
    CHIK_DB('BIF_MOV_M','BMMDI_TX','REAL');
    CHIK_DB('BIF_MOV_M','TCAM','REAL');
    CHIK_DB('BIF_MOV_M','BMMICV','INTEGER');
    CHIK_DB('BIF_MOV_M','BMMUU','TEXT');

    CHIK_DB('BIF_MOV_D','TCRA','REAL');
    CHIK_DB('BIF_MOV_D','TCSDID','INTEGER');
    CHIK_DB('BIF_MOV_D','TCSDSY','TEXT');
    CHIK_DB('BIF_MOV_D','TCID','INTEGER');
    CHIK_DB('BIF_MOV_D','TCSY','TEXT');
    CHIK_DB('BIF_MOV_D','TCVL','INTEGER');
    CHIK_DB('BIF_MOV_D','BMDAM_TX','REAL');
    CHIK_DB('BIF_MOV_D','BMDDI_TX','REAL');
    CHIK_DB('BIF_MOV_D','BMDAMT3','REAL');
    CHIK_DB('BIF_MOV_D','TCAMT','REAL');

    CHIK_DB('BIL_MOV_D','TCRA','REAL');
    CHIK_DB('BIL_MOV_D','TCSDID','INTEGER');
    CHIK_DB('BIL_MOV_D','TCSDSY','TEXT');
    CHIK_DB('BIL_MOV_D','TCID','INTEGER');
    CHIK_DB('BIL_MOV_D','TCSY','TEXT');
    CHIK_DB('BIL_MOV_D','TCVL','INTEGER');
    CHIK_DB('BIL_MOV_D','BMDAM_TX','REAL');
    CHIK_DB('BIL_MOV_D','BMDDI_TX','REAL');
    CHIK_DB('BIL_MOV_D','BMDAMT3','REAL');
    CHIK_DB('BIL_MOV_D','TCAMT','REAL');


    await db.execute('''DROP TABLE IF EXISTS FAT_INV_SND ''');
    await db.execute('''DROP TABLE IF EXISTS FAT_INV_SND_TMP ''');
    await db.execute('''DROP TABLE IF EXISTS FAT_INV_SND_ARC ''');
    await db.execute('''DROP TABLE IF EXISTS FAT_INV_SND_ARC_TMP ''');
    await db.execute('''DROP TABLE IF EXISTS FAT_INV_RS ''');
    await db.execute('''DROP TABLE IF EXISTS FAT_INV_SND_D ''');
    await db.execute('''DROP TABLE IF EXISTS FAT_INV_SND_D_ARC ''');
    await db.execute('''DROP TABLE IF EXISTS FAT_INV_SND_R ''');
    await db.execute('''DROP TABLE IF EXISTS FAT_INV_SND_R_ARC ''');


    await db.execute(CreateCOU_TYP_M);
    await db.execute(CreateCOU_INF_M);
    await db.execute(CreateCOU_POI_L);
    await db.execute(CreateBIF_COU_M);
    await db.execute(CreateCOU_USR);
    await db.execute(CreateCOU_RED);
    await db.execute(CreateBIF_COU_C);
    await db.execute('''
 CREATE TABLE FAT_INV_SND(
    FISSEQ     INTEGER primary key autoincrement,
  FISGU      TEXT,
  FCIGU      TEXT,
  CIIDL      INTEGER,
  JTIDL      INTEGER,
  BIIDL      INTEGER,
  SYIDL      INTEGER,
  SCHNA      TEXT,
  UUID       TEXT,
  STID       TEXT,
  BMMGU      TEXT,
  FISSI      INTEGER                          DEFAULT 2,
  FISST      INTEGER,
  FISICV     INTEGER,
  FISPIN     INTEGER,
  FISPGU     TEXT,
  FISPIH     TEXT,
  FISIH      TEXT,
  FISQR      TEXT,
  FISZHS     TEXT,
  FISZHSO    TEXT,
  FISZS      TEXT,
  FISIS      TEXT,
  FISINF     TEXT,
  FISWE      INTEGER                          DEFAULT 2,
  FISEE      INTEGER                         DEFAULT 2,
  FISXML     TEXT,
  FISTOT     REAL,
  FISSUM     REAL,
  FISTWV     REAL,
  FISSD      DATE,
  FISLSD     DATE,
  FISNS      INTEGER                             DEFAULT 0,
  SOMGU      TEXT,
  SYDV_APPV  TEXT,
  SMID       INTEGER,
  SYDV_APIV  TEXT,
  SUID       TEXT,
  DATEI      DATE,
  DEVI       TEXT,
  STMIDI     TEXT,
  SOMIDI     INTEGER,
  SUCH       TEXT,
  DATEU      DATE,
  DEVU       TEXT,
  STMIDU     TEXT,
  SOMIDU     INTEGER,
  FISSTO     INTEGER,
  FISST2      INTEGER,
  FISFS INTEGER DEFAULT 2,
  FISXE INTEGER DEFAULT 2,
  FISXN INTEGER DEFAULT 0,
  FISXNA TEXT,
  FISINO TEXT,
  JTID_L INTEGER,
  BIID_L INTEGER,
  SYID_L INTEGER,
  CIID_L TEXT  )
''');
    await db.execute('''
 CREATE TABLE FAT_INV_SND_ARC(
    FISSEQ     INTEGER,
  FISGU      TEXT,
  FCIGU      TEXT,
  CIIDL      INTEGER,
  JTIDL      INTEGER,
  BIIDL      INTEGER,
  SYIDL      INTEGER,
  SCHNA      TEXT,
  UUID       TEXT,
  STID       TEXT,
  BMMGU      TEXT,
  FISSI      INTEGER                          DEFAULT 2,
  FISST      INTEGER,
  FISICV     INTEGER,
  FISPIN     INTEGER,
  FISPGU     TEXT,
  FISPIH     TEXT,
  FISIH      TEXT,
  FISQR      TEXT,
  FISZHS     TEXT,
  FISZHSO    TEXT,
  FISZS      TEXT,
  FISIS      TEXT,
  FISINF     TEXT,
  FISWE      INTEGER                          DEFAULT 2,
  FISEE      INTEGER                         DEFAULT 2,
  FISXML     TEXT,
  FISTOT     REAL,
  FISSUM     REAL,
  FISTWV     REAL,
  FISSD      DATE,
  FISLSD     DATE,
  FISNS      INTEGER                             DEFAULT 0,
  SOMGU      TEXT,
  SYDV_APPV  TEXT,
  SMID       INTEGER,
  SYDV_APIV  TEXT,
  SUID       TEXT,
  DATEI      DATE,
  DEVI       TEXT,
  STMIDI     TEXT,
  SOMIDI     INTEGER,
  SUCH       TEXT,
  DATEU      DATE,
  DEVU       TEXT,
  STMIDU     TEXT,
  SOMIDU     INTEGER,
  FISSTO     INTEGER,
  FISAFS INTEGER DEFAULT 2,
  JTID_L INTEGER,
  BIID_L INTEGER,
  SYID_L INTEGER,
  CIID_L TEXT  )
''');
    await db.execute('''
 CREATE TABLE FAT_INV_RS(
    FIRSEQ   INTEGER primary key autoincrement,
  GUID     TEXT,
  FISSEQ   INTEGER,
  FISGU    TEXT,
  FCIGU    TEXT,
  CIIDL    INTEGER,
  JTIDL    INTEGER,
  BIIDL    INTEGER,
  SYIDL    INTEGER,
  SCHNA    TEXT,
  BMMGU    TEXT,
  FIREQD   TEXT,
  FIRESC   TEXT,
  FIRERR   TEXT,
  FIRESD   TEXT,
  FIRDA    DATE,
  SUID     TEXT,
  DATEI    DATE,
  DEVI     TEXT,
  STMIDI   TEXT,
  SOMIDI   INTEGER,
  SUCH     TEXT,
  DATEU    DATE,
  DEVU     TEXT,
  STMIDU   TEXT,
  SOMIDU   INTEGER,
  FIRFS INTEGER DEFAULT 2,
  JTID_L INTEGER,
  BIID_L INTEGER,
  SYID_L INTEGER,
  CIID_L TEXT  )
''');
    await db.execute('''
 CREATE TABLE FAT_INV_SND_D(
    FISDGU     TEXT,
  FISGU      TEXT,
  FISDTY      TEXT,
  FISDDA      TEXT,
  FISDFS INTEGER DEFAULT 2,
  JTID_L INTEGER,
  BIID_L INTEGER,
  SYID_L INTEGER,
  CIID_L TEXT  )
''');
    await db.execute('''
 CREATE TABLE FAT_INV_SND_R(
    FISRGU     TEXT,
    FISGU      TEXT,
    FISRTY      TEXT,
    FISRDA      TEXT,
    FISRFS INTEGER DEFAULT 2,
  JTID_L INTEGER,
  BIID_L INTEGER,
  SYID_L INTEGER,
  CIID_L TEXT  )
''');


    // 21-11-2024
    await db.execute('''CREATE TABLE COU_TYP_M_TMP AS SELECT  * FROM COU_TYP_M WHERE 1=2''');
    await db.execute('''CREATE TABLE COU_INF_M_TMP AS SELECT  * FROM COU_INF_M WHERE 1=2''');
    await db.execute('''CREATE TABLE COU_POI_L_TMP AS SELECT  * FROM COU_POI_L WHERE 1=2''');
    await db.execute('''CREATE TABLE BIF_COU_M_TMP AS SELECT  * FROM BIF_COU_M WHERE 1=2''');
    await db.execute('''CREATE TABLE COU_USR_TMP AS SELECT  * FROM COU_USR WHERE 1=2''');
    await db.execute('''CREATE TABLE COU_RED_TMP AS SELECT  * FROM COU_RED WHERE 1=2''');
    await db.execute('''CREATE TABLE BIF_COU_C_TMP AS SELECT  * FROM BIF_COU_C WHERE 1=2''');

    await db.execute('''CREATE INDEX COU_INF_M_I1 on COU_INF_M(CIMID,BIID,CTMID)''');
    await db.execute('''CREATE INDEX COU_INF_M_I2 on COU_INF_M(CIMID,BIID,CTMID,JTID_L,BIID_L,SYID_L,CIID_L)''');

    await db.execute('''CREATE TABLE FAT_INV_SND_D_ARC AS SELECT  * FROM FAT_INV_SND_D WHERE 1=2''');
    await db.execute('''CREATE TABLE FAT_INV_SND_R_ARC AS SELECT  * FROM FAT_INV_SND_R WHERE 1=2''');

    await db.execute('''CREATE INDEX FAT_INV_SND_I1 on FAT_INV_SND(FISSEQ,JTID_L,SYID_L,CIID_L)''');
    await db.execute('''CREATE INDEX FAT_INV_SND_I2 on FAT_INV_SND(FCIGU,JTID_L,SYID_L,CIID_L)''');
    await db.execute('''CREATE INDEX FAT_INV_SND_I3 on FAT_INV_SND(CIIDL, JTIDL, BIIDL, SYIDL)''');
    await db.execute('''CREATE INDEX FAT_INV_SND_I4 on FAT_INV_SND(BMMGU,JTID_L,SYID_L,CIID_L)''');
    await db.execute('''CREATE INDEX FAT_INV_SND_I5 on FAT_INV_SND(FISST,JTID_L,SYID_L,CIID_L)''');
    await db.execute('''CREATE INDEX FAT_INV_RS_I1 on FAT_INV_RS(FISGU,JTID_L,SYID_L,CIID_L)''');
    await db.execute('''CREATE INDEX FAT_INV_RS_I2 on FAT_INV_RS(BMMGU,JTID_L,SYID_L,CIID_L)''');
    await db.execute('''CREATE INDEX FAT_INV_SND_D_I1 on FAT_INV_SND_D(FISDGU,JTID_L,SYID_L,CIID_L)''');
    await db.execute('''CREATE INDEX FAT_INV_SND_D_I2 on FAT_INV_SND_D(FISGU,JTID_L,SYID_L,CIID_L)''');
    await db.execute('''CREATE INDEX FAT_INV_SND_D_ARC_I1 on FAT_INV_SND_D_ARC(FISDGU, JTID_L,SYID_L,CIID_L)''');
    await db.execute('''CREATE INDEX FAT_INV_SND_D_ARC_I2 on FAT_INV_SND_D_ARC(FISGU,JTID_L,SYID_L,CIID_L)''');
    await db.execute('''CREATE INDEX FAT_INV_SND_R_I1 on FAT_INV_SND_R(FISRGU,JTID_L,SYID_L,CIID_L)''');
    await db.execute('''CREATE INDEX FAT_INV_SND_R_I2 on FAT_INV_SND_R(FISGU,JTID_L,SYID_L,CIID_L)''');
    await db.execute('''CREATE INDEX FAT_INV_SND_R_ARC_I1 on FAT_INV_SND_R_ARC(FISRGU, JTID_L,SYID_L,CIID_L)''');
    await db.execute('''CREATE INDEX FAT_INV_SND_R_ARC_I2 on FAT_INV_SND_R_ARC(FISGU,JTID_L,SYID_L,CIID_L)''');

  }

  //25-11-2024 --تحديث 14
  Future OnUpgradeV449_14 (Database db) async{

    await db.execute('''ALTER TABLE BIL_MOV_M ADD COLUMN BMMCRT TEXT''');
    await db.execute('''ALTER TABLE BIF_MOV_M ADD COLUMN BMMCRT TEXT''');
    await db.execute('''ALTER TABLE BIF_MOV_M ADD COLUMN BMMTN TEXT''');
    await db.execute('''ALTER TABLE BIF_MOV_M ADD COLUMN BMMCOU INTEGER DEFAULT 2''');
    await db.execute('''ALTER TABLE BIL_MOV_D ADD COLUMN SCIDC    INTEGER''');
    await db.execute('''ALTER TABLE BIL_MOV_D ADD COLUMN CTMID    INTEGER''');
    await db.execute('''ALTER TABLE BIL_MOV_D ADD COLUMN CIMID    INTEGER''');
    await db.execute('''ALTER TABLE BIL_MOV_D ADD COLUMN BMDAM1    REAL''');
    await db.execute('''ALTER TABLE BIF_MOV_D ADD COLUMN BMDAM1    REAL''');
    await db.execute('''ALTER TABLE BIL_MOV_M ADD COLUMN CTMID   INTEGER''');
    await db.execute('''ALTER TABLE BIL_MOV_M ADD COLUMN CIMID   INTEGER''');
    await db.execute('''ALTER TABLE BIL_MOV_M ADD COLUMN SCIDC INTEGER''');

    Future<bool> isColumnExists( String tableName, String columnName) async {
      // final conn = DatabaseHelper.instance;
      // var dbClient = await conn.database;
      var result = await db.rawQuery('PRAGMA table_info($tableName)');
      for (var column in result) {
        if (column['name'] == columnName) {
          return true; // العمود موجود
        }
      }
      return false; // العمود غير موجود
    }
    Future<void> addColumnIfNotExists( String tableName, String columnName ,String Typecolumn) async {
      bool exists = await isColumnExists( tableName, columnName);

      if (!exists) {
        // إضافة العمود إلى الجدول
        String sql = 'ALTER TABLE $tableName ADD COLUMN $columnName $Typecolumn'; // يمكنك تغيير نوع العمود حسب الحاجة
        await db.execute(sql);
        print('تم إضافة العمود: $columnName إلى الجدول: $tableName');
      } else {
        print('العمود موجود بالفعل: $columnName');
      }
    }

    // مثال على كيفية استدعاء الدالة
    Future<void> CHIK_DB(String tableName, String columnName,Typecolumn) async {
      // اسم الجدول والعمود الذي ترغب في التحقق منه

      // استدعاء الدالة لإضافة العمود إذا لم يكن موجودًا
      print('اسم الجدول: $tableName');
      print('اسم العمود: $columnName');
      print('قاعدة البيانات: $db');
      print('تشغيل الدالة CHIK_DB');
      addColumnIfNotExists( tableName, columnName,Typecolumn);

      // إغلاق قاعدة البيانات
      // await dbClient!.close();
    }

    //25-11-2024
    CHIK_DB('BIL_MOV_M','BMMFST','INTEGER DEFAULT 10');
    CHIK_DB('BIL_MOV_M','BMMFQR','TEXT');
    CHIK_DB('BIL_MOV_M','BMMFIC','INTEGER');
    CHIK_DB('BIL_MOV_M','BMMFUU','TEXT');
    CHIK_DB('BIL_MOV_M','BMMFNO','TEXT');

    CHIK_DB('BIF_MOV_M','BMMFST','INTEGER DEFAULT 10');
    CHIK_DB('BIF_MOV_M','BMMFQR','TEXT');
    CHIK_DB('BIF_MOV_M','BMMFIC','INTEGER');
    CHIK_DB('BIF_MOV_M','BMMFUU','TEXT');
    CHIK_DB('BIF_MOV_M','BMMFNO','TEXT');

    await db.execute('''DROP TABLE IF EXISTS FAT_INV_SND ''');
    await db.execute('''DROP TABLE IF EXISTS FAT_INV_SND_TMP ''');
    await db.execute('''DROP TABLE IF EXISTS FAT_INV_SND_ARC ''');
    await db.execute('''DROP TABLE IF EXISTS FAT_INV_SND_ARC_TMP ''');

    await db.execute('''
 CREATE TABLE FAT_INV_SND(
    FISSEQ     INTEGER primary key autoincrement,
  FISGU      TEXT,
  FCIGU      TEXT,
  CIIDL      INTEGER,
  JTIDL      INTEGER,
  BIIDL      INTEGER,
  SYIDL      INTEGER,
  SCHNA      TEXT,
  UUID       TEXT,
  STID       TEXT,
  BMMGU      TEXT,
  FISSI      INTEGER                          DEFAULT 2,
  FISST      INTEGER,
  FISICV     INTEGER,
  FISPIN     INTEGER,
  FISPGU     TEXT,
  FISPIH     TEXT,
  FISIH      TEXT,
  FISQR      TEXT,
  FISZHS     TEXT,
  FISZHSO    TEXT,
  FISZS      TEXT,
  FISIS      TEXT,
  FISINF     TEXT,
  FISWE      INTEGER                          DEFAULT 2,
  FISEE      INTEGER                         DEFAULT 2,
  FISXML     TEXT,
  FISTOT     REAL,
  FISSUM     REAL,
  FISTWV     REAL,
  FISSD      DATE,
  FISLSD     DATE,
  FISNS      INTEGER                             DEFAULT 0,
  SOMGU      TEXT,
  SYDV_APPV  TEXT,
  SMID       INTEGER,
  SYDV_APIV  TEXT,
  SUID       TEXT,
  DATEI      DATE,
  DEVI       TEXT,
  STMIDI     TEXT,
  SOMIDI     INTEGER,
  SUCH       TEXT,
  DATEU      DATE,
  DEVU       TEXT,
  STMIDU     TEXT,
  SOMIDU     INTEGER,
  FISSTO     INTEGER,
  FISST2      INTEGER,
  FISFS INTEGER DEFAULT 2,
  FISXE INTEGER DEFAULT 2,
  FISXN INTEGER DEFAULT 0,
  FISXNA TEXT,
  FISINO TEXT,
  JTID_L INTEGER,
  BIID_L INTEGER,
  SYID_L INTEGER,
  CIID_L TEXT  )
''');

    await db.execute('''CREATE TABLE FAT_INV_SND_ARC AS SELECT  * FROM FAT_INV_SND WHERE 1=2''');

    await db.execute('''CREATE INDEX FAT_INV_SND_I1 on FAT_INV_SND(FISSEQ,JTID_L,SYID_L,CIID_L)''');
    await db.execute('''CREATE INDEX FAT_INV_SND_I2 on FAT_INV_SND(FCIGU,JTID_L,SYID_L,CIID_L)''');
    await db.execute('''CREATE INDEX FAT_INV_SND_I3 on FAT_INV_SND(CIIDL, JTIDL, BIIDL, SYIDL)''');
    await db.execute('''CREATE INDEX FAT_INV_SND_I4 on FAT_INV_SND(BMMGU,JTID_L,SYID_L,CIID_L)''');
    await db.execute('''CREATE INDEX FAT_INV_SND_I5 on FAT_INV_SND(FISST,JTID_L,SYID_L,CIID_L)''');

    //04-12-2024
    await db.execute(CreateCON_ACC_M);
    await db.execute(CreateMOB_VAR);
    InsertMobVar(db);
  }

  Future OnUpgradeV449_15 (Database db) async{
    await db.execute('''UPDATE MOB_VAR SET SYID_L=${LoginController().SYID} where SYID_L!=${LoginController().SYID} ''');
  }

  //18-01-2025--تحديث 16
  Future OnUpgradeV449_16 (Database db) async{

    Future<bool> isColumnExists( String tableName, String columnName) async {
      // final conn = DatabaseHelper.instance;
      // var dbClient = await conn.database;
      var result = await db.rawQuery('PRAGMA table_info($tableName)');
      for (var column in result) {
        if (column['name'] == columnName) {
          return true; // العمود موجود
        }
      }
      return false; // العمود غير موجود
    }
    Future<void> addColumnIfNotExists( String tableName, String columnName ,String Typecolumn) async {
      bool exists = await isColumnExists( tableName, columnName);

      if (!exists) {
        // إضافة العمود إلى الجدول
        String sql = 'ALTER TABLE $tableName ADD COLUMN $columnName $Typecolumn'; // يمكنك تغيير نوع العمود حسب الحاجة
        await db.execute(sql);
        print('تم إضافة العمود: $columnName إلى الجدول: $tableName');
      } else {
        print('العمود موجود بالفعل: $columnName');
      }
    }
    // مثال على كيفية استدعاء الدالة
    Future<void> CHIK_DB(String tableName, String columnName,Typecolumn) async {
      // اسم الجدول والعمود الذي ترغب في التحقق منه

      // استدعاء الدالة لإضافة العمود إذا لم يكن موجودًا
      print('اسم الجدول: $tableName');
      print('اسم العمود: $columnName');
      print('قاعدة البيانات: $db');
      print('تشغيل الدالة CHIK_DB');
      addColumnIfNotExists( tableName, columnName,Typecolumn);

    }

    // await db.execute('''DROP TABLE SYN_SET ''');
    // await db.execute('''DROP TABLE SYN_SET_TMP ''');
    // await db.execute('''DROP TABLE SYN_OFF_M2 ''');
    // await db.execute('''DROP TABLE SYN_OFF_M2_TMP ''');
    // await db.execute('''DROP TABLE SYN_OFF_M ''');
    // await db.execute('''DROP TABLE SYN_OFF_M_TMP ''');
    // await db.execute('''DROP TABLE ECO_VAR ''');
    // await db.execute('''DROP TABLE ECO_VAR_TMP ''');
    // await db.execute('''DROP TABLE ECO_ACC ''');
    // await db.execute('''DROP TABLE ECO_ACC_TMP ''');
    // await db.execute('''DROP TABLE ECO_ACC_TMP ''');
    // await db.execute('''DROP TABLE ECO_MSG_ACC ''');
    // await db.execute('''DROP TABLE ECO_MSG_ACC_TMP ''');
    // await db.execute('''DROP TABLE BK_INF ''');

    await db.execute(CreateSYN_SET);
    await db.execute(CreateSYN_OFF_M2);
    await db.execute(CreateSYN_OFF_M);
    await db.execute(CreateECO_VAR);
    await db.execute(CreateECO_ACC);
    await db.execute(CreateECO_MSG_ACC);
    await db.execute(CreateBK_INF);
    await db.execute('''CREATE TABLE SYN_SET_TMP AS SELECT  * FROM SYN_SET WHERE 1=2''');
    await db.execute('''CREATE TABLE SYN_OFF_M2_TMP AS SELECT  * FROM SYN_OFF_M2 WHERE 1=2''');
    await db.execute('''CREATE TABLE SYN_OFF_M_TMP AS SELECT  * FROM SYN_OFF_M WHERE 1=2''');
    await db.execute('''CREATE TABLE ECO_VAR_TMP AS SELECT  * FROM ECO_VAR WHERE 1=2''');
    await db.execute('''CREATE TABLE ECO_ACC_TMP AS SELECT  * FROM ECO_ACC WHERE 1=2''');
    await db.execute('''CREATE TABLE ECO_MSG_ACC_TMP AS SELECT  * FROM ECO_MSG_ACC WHERE 1=2''');
    await db.execute('''INSERT INTO SYN_ORD(SOET,ROW_NUM,SOOR,SOST,JTID_L,BIID_L,SYID_L,CIID_L) values('SYN_SET',0,169,1, ${LoginController().JTID},${LoginController().BIID},${LoginController().SYID},'${LoginController().CIID}')''');
    await db.execute('''INSERT INTO SYN_ORD(SOET,ROW_NUM,SOOR,SOST,JTID_L,BIID_L,SYID_L,CIID_L) values('SYN_OFF_M2',0,170,1, ${LoginController().JTID},${LoginController().BIID},${LoginController().SYID},'${LoginController().CIID}')''');
    await db.execute('''INSERT INTO SYN_ORD(SOET,ROW_NUM,SOOR,SOST,JTID_L,BIID_L,SYID_L,CIID_L) values('SYN_OFF_M',0,171,1, ${LoginController().JTID},${LoginController().BIID},${LoginController().SYID},'${LoginController().CIID}')''');
    await db.execute('''INSERT INTO SYN_ORD(SOET,ROW_NUM,SOOR,SOST,JTID_L,BIID_L,SYID_L,CIID_L) values('ECO_VAR',0,172,1, ${LoginController().JTID},${LoginController().BIID},${LoginController().SYID},'${LoginController().CIID}')''');
    await db.execute('''INSERT INTO SYN_ORD(SOET,ROW_NUM,SOOR,SOST,JTID_L,BIID_L,SYID_L,CIID_L) values('ECO_ACC',0,172,1, ${LoginController().JTID},${LoginController().BIID},${LoginController().SYID},'${LoginController().CIID}')''');
    await db.execute('''INSERT INTO SYN_ORD(SOET,ROW_NUM,SOOR,SOST,JTID_L,BIID_L,SYID_L,CIID_L) values('ECO_MSG_ACC',0,173,1, ${LoginController().JTID},${LoginController().BIID},${LoginController().SYID},'${LoginController().CIID}')''');
    await db.execute('''DELETE FROM LIST_VALUE''');
    await db.execute('''INSERT INTO LIST_VALUE(LVTY,LVID,LVNA,LVNE) values('BMMDN','0','على مستوى الفاتورة','By Invoice level')''');
    await db.execute('''INSERT INTO LIST_VALUE(LVTY,LVID,LVNA,LVNE) values('BMMDN','1','على مستوى الصنف','By Item level')''');
    await db.execute('''INSERT INTO LIST_VALUE(LVTY,LVID,LVNA,LVNE) values('BCPR','1','سعر بيع 1','sale price 1')''');
    await db.execute('''INSERT INTO LIST_VALUE(LVTY,LVID,LVNA,LVNE) values('BCPR','2','سعر بيع 2','sale price 2')''');
    await db.execute('''INSERT INTO LIST_VALUE(LVTY,LVID,LVNA,LVNE) values('BCPR','3','سعر بيع 3','sale price 3')''');
    await db.execute('''INSERT INTO LIST_VALUE(LVTY,LVID,LVNA,LVNE) values('BCPR','4','سعر بيع 4','sale price 4')''');
    await db.execute('''INSERT INTO LIST_VALUE(LVTY,LVID,LVNA,LVNE) values('ST','0','الكل','All')''');
    await db.execute('''INSERT INTO LIST_VALUE(LVTY,LVID,LVNA,LVNE) values('ST','1','فعال','Active')''');
    await db.execute('''INSERT INTO LIST_VALUE(LVTY,LVID,LVNA,LVNE) values('ST','2','موقوف','Not Active')''');
    await db.execute('''INSERT INTO LIST_VALUE(LVTY,LVID,LVNA,LVNE) values('ST','3','وقف مدين','Not debit')''');
    await db.execute('''INSERT INTO LIST_VALUE(LVTY,LVID,LVNA,LVNE) values('ST','4','وقف دائن','Not credit')''');
    await db.execute('''ALTER TABLE BIL_CUS ADD COLUMN BCJT TEXT''');
    await db.execute('''ALTER TABLE BIL_CUS ADD COLUMN BCCR INTEGER DEFAULT 0''');
    await db.execute('''ALTER TABLE BIL_CUS_TMP ADD COLUMN BCJT TEXT''');
    await db.execute('''ALTER TABLE BIL_CUS_TMP ADD COLUMN BCCR INTEGER DEFAULT 0''');
    CHIK_DB('ACC_MOV_D','GUIDC','TEXT');
    InsertMobVar2(db);
  }

  Future OnUpgradeV449_17 (Database db) async{
    await db.execute(CreateBIF_TRA_TBL);
    await db.execute(CreateAppPrinterDevice);
    await db.execute(CreateMOB_LOG);
    await db.execute('''ALTER TABLE BIF_MOV_M ADD COLUMN ACNO2 TEXT''');
    await db.execute('''ALTER TABLE BIL_CUS ADD COLUMN BCCR2 REAL DEFAULT 0''');
    await db.execute('''ALTER TABLE BIL_CUS_TMP ADD COLUMN BCCR2 REAL DEFAULT 0''');
  }

  Future<List<Map<String, dynamic>>> query(String sql, [List<dynamic>? arguments]) async {
    final db = await database;
    return await db!.rawQuery(sql, arguments);
  }

  Future deleteDB() async {
    try {
      deleteDatabase(path);
    } catch (e) {
      print(e.toString());
    }
  }

}
