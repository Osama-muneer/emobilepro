import 'dart:io';

import 'package:get/get.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import 'package:path/path.dart' as p;

class ExportedInvoicesController extends GetxController
    with StateMixin<List<File>> {
  RefreshController refreshController = RefreshController(initialRefresh: false);
  @override
  void onInit() {
    super.onInit();
    getFileDirectories();
  }

  void onRefresh() async {
    await getFileDirectories();
    refreshController.refreshCompleted();
  }

  getFileDirectories() async {
    try {
      change(null, status: RxStatus.loading());
      Directory? path = await (getApplicationDocumentsDirectory());

      List<File> files =
          Directory(path.path).listSync().map((e) => File(e.path)).toList();

      if (files.isEmpty) {
        change(null, status: RxStatus.empty());
      }
      files.sort(
          (a, b) => b.statSync().modified.compareTo(a.statSync().modified));
      change(files, status: RxStatus.success());
    } catch (e) {
      change(null, status: RxStatus.error(e.toString()));
    }
  }

  String getFileName({String? path}) {
    return p.withoutExtension(p.basename(path!));
  }

  // openFile(File file) {
  //   if (file.path.contains('.pdf')) {
  //     Get.to(() => PdfPerview(
  //           filePath: file.path,
  //         ));
  //   } else {
  //     OpenFile.open(file.path);
  //   }
  // }

  deleteFile(String path) async {
    try {
      File file = File(path);

      await file.delete();
      getFileDirectories();
      //GetSnackMsg(msg: "deleted successfully",bgClr:kColorRed ,txClr:kColorsWhite ).showTxt();

     // showSnakBarSuccess(msg: InvoiceStrings.deletedSuccessfully.tran);
    } catch (e) {
      return false;
    }
  }
}
