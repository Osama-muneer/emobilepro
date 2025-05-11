import 'dart:async';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:path_provider/path_provider.dart';
import 'package:share_plus/share_plus.dart';
import 'package:sqflite/sqflite.dart';
import '../../../Widgets/config.dart';
import '../../../Widgets/theme_helper.dart';
import '../../controllers/home_controller.dart';
import '../../controllers/login_controller.dart';
import '../../models/bk_inf.dart';

class BackupScreen extends StatefulWidget {
  @override
  _BackupScreenState createState() => _BackupScreenState();
}

class _BackupScreenState extends State<BackupScreen> {
  final HomeController controller = Get.find();

  @override
  void initState() {
    super.initState();
    controller.fetchBackups();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: ThemeHelper().MainAppBar('StringBk_Br'.tr),
      body: GetBuilder<HomeController>(
          init: HomeController(),
          builder: ((value) {
            return  Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  _buildSearchField(),
                  SizedBox(height: 10),
                  _buildDataTable(),
                ],
              ),
            );
          })),
    );
  }

  Widget _buildSearchField() {
    return TextField(
      controller: controller.searchController,
      decoration: InputDecoration(
        labelText: 'بحث',
        labelStyle: TextStyle(color: Colors.red),
        prefixIcon: Icon(Icons.search,color: Colors.red,),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide(color: Colors.red),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide(color: Colors.red),
        ),
      ),
      onChanged: (value) {
        controller.filterBackups(value); // تأكد من أن الدالة تعمل بشكل صحيح
      },
    );
  }

  Widget _buildDataTable() {
    return Expanded(
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: DataTable(
          columnSpacing: 12, // المسافة بين الأعمدة
          decoration: BoxDecoration(
            border: Border.all(color: Colors.grey.shade300), // حدود الجدول
            borderRadius: BorderRadius.circular(10),
          ),
          columns: [
            DataColumn(label: Text('النوع', style: TextStyle(fontWeight: FontWeight.bold))),
            DataColumn(label: Text('التاريخ', style: TextStyle(fontWeight: FontWeight.bold))),
            DataColumn(label: Text('الوقت', style: TextStyle(fontWeight: FontWeight.bold))),
            DataColumn(label: Text('الحجم', style: TextStyle(fontWeight: FontWeight.bold))),
            DataColumn(label: Text('المسار', style: TextStyle(fontWeight: FontWeight.bold))),
            DataColumn(label: Text('مشاركه', style: TextStyle(fontWeight: FontWeight.bold))),
          //  DataColumn(label: Text('استعاده', style: TextStyle(fontWeight: FontWeight.bold))),
          //  DataColumn(label: Text('استعادة', style: TextStyle(fontWeight: FontWeight.bold))),
          ],
          rows: controller.filteredBackups.map((backup) {
            return DataRow(
              cells: [
                DataCell(Text(backup.bity)),
                DataCell(Text(backup.bida)),
                DataCell(Text(backup.biti)),
                DataCell(Text(backup.bizi)),
                DataCell(Text(backup.biur)),
                DataCell(
                  IconButton(
                    icon: Icon(Icons.share, color: Colors.blue),
                    onPressed: () => _shareBackup(backup),
                  ),
                ),
                // DataCell(
                //   IconButton(
                //     icon: Icon(Icons.restore, color: Colors.green),
                //     onPressed: () => _restoreBackup(backup),
                //   ),
                // ),// زر الاستعادة
                // DataCell(IconButton(
                //   icon: Icon(Icons.restore, color: Colors.green),
                //   onPressed: () {
                //     _restoreBackup();
                //   },
                // )),
              ],
            );
          }).toList(),
        ),
      ),
    );
  }

  void _shareBackup(Bk_inf backup) async {
    try {
      final file = File(backup.biur); // biur يجب أن يحتوي على المسار الكامل للملف

      if (!await file.exists()) {
        throw Exception('الملف غير موجود');
      }
      final xFile = XFile(file.path, mimeType: 'application/x-sqlite3');
      await Share.shareXFiles([xFile], text:  'تفاصيل النسخة الاحتياطية:\n'
          'النوع: ${backup.bity}\n'
          'التاريخ: ${backup.bida}\n'
          'الحجم: ${backup.bizi}',subject:'مشاركة نسخة احتياطية' );
      // await Share.shareFiles(
      //   [file.path],
      //   text: 'تفاصيل النسخة الاحتياطية:\n'
      //       'النوع: ${backup.bity}\n'
      //       'التاريخ: ${backup.bida}\n'
      //       'الحجم: ${backup.bizi}',
      //   subject: 'مشاركة نسخة احتياطية',
      //   mimeTypes: ['application/x-sqlite3'], // نوع MIME حسب نوع قاعدة البيانات
      // );
    } catch (e) {
      Get.snackbar(
        'خطأ',
        'فشل في المشاركة: ${e.toString()}',
        snackPosition: SnackPosition.BOTTOM,
      );
    }
  }

  void _restoreBackup(Bk_inf backup) async {
    Get.defaultDialog(
      title: 'تأكيد الاستعادة',
      middleText: 'هل أنت متأكد من استعادة هذه النسخة؟',
      confirm: ElevatedButton(
        child: Text('تأكيد'),
        onPressed: () async {
          Get.back();
          try {

            LoginController().save_path(false);
            await restoreBackup(backup);

            LoginController().SET_N_P('CHIKE_ALL_MAIN',1);

            // Navigate after a short delay

              Timer(const Duration(seconds: 3), () async {
                Get.toNamed('/login');
                LoginController().GET_JTID_ONEData();
              });


            Get.snackbar(
              'نجاح',
              'تم استعادة النسخة بنجاح',
              snackPosition: SnackPosition.BOTTOM,
              backgroundColor: Colors.green,
              colorText: Colors.white,
            );
          } catch (e) {
            Get.snackbar(
              'خطأ',
              e.toString(),
              snackPosition: SnackPosition.BOTTOM,
              backgroundColor: Colors.red,
              colorText: Colors.white,
            );
          }
        },
      ),
      cancel: TextButton(
        child: Text('إلغاء'),
        onPressed: () => Get.back(),
      ),
    );
  }

  Future<void> restoreBackup(Bk_inf backup) async {
    try {
      final appDocDir = await getApplicationDocumentsDirectory();
      String recoveryPath = "${appDocDir.path}/$DBNAME";
      final dbPath = await getDatabasesPath();
      final currentDbPath = "${appDocDir.path}/$DBNAME";
      final backupFile = File(backup.biur);

      // التحقق من وجود الملف
      if (!await backupFile.exists()) {
        throw Exception('ملف النسخة الاحتياطية غير موجود');
      }

      // // إغلاق الاتصال الحالي مع القاعدة
      // await closeDatabase();

      // نسخ الملف الاحتياطي فوق القاعدة الحالية
      await backupFile.copy(currentDbPath);

      // إعادة فتح الاتصال مع القاعدة
    //  await openDatabase(currentDbPath);
    } catch (e) {
      throw Exception('فشل في الاستعادة: ${e.toString()}');
    }
  }

}