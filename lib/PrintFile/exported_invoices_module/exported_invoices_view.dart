import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:flutter/material.dart';
import 'exported_invoices_controller.dart';

class ExportedInvoicesView extends GetWidget<ExportedInvoicesController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          titleSpacing: 0,
          title: Text(
           " InvoiceStrings.invoicesExtracted.tran,"

          )),
      body: SmartRefresher(
        enableTwoLevel: false,
        enablePullDown: true,
        enablePullUp: false,
        physics: BouncingScrollPhysics(),
       // footer: TaxDetailesInvoiceFooter(),
        controller: controller.refreshController,
        onRefresh: controller.onRefresh,
        child: controller.obx(
          (state) => ListView.builder(
            physics: NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            itemCount: state!.length,
            itemBuilder: (context, index) {
              String name = controller.getFileName(path: state[index].path);
              if (!state[index].path.contains('.pdf')) return SizedBox();
              return Container(
                color:Colors.blue,
                margin: EdgeInsets.all(5.sp),
                child: ListTile(
                  leading: Icon(Icons.file_present_outlined),
                //  onTap: () => controller.openFile(state[index]),
                  title: Directionality(
                      textDirection: TextDirection.ltr,
                      child: Text(
                        name,
                        //style: caption,
                      )),
                  trailing: IconButton(
                      onPressed: () => controller.deleteFile(state[index].path),
                      icon: Icon(Icons.delete)),
                ),
              );
            },
          ),
          onLoading: CircularProgressIndicator(),
          // onEmpty: EmptyBuilderComponent(),
          // onError: (e) => ErorrBuilderComponent(
          //   subtitle: e.toString(),
          // ),
        ),
      ),
    );
  }
}
