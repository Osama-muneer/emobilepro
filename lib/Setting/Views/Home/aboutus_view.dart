import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import '../../../Setting/controllers/abouatus_controller.dart';
import '../../../Widgets/config.dart';
import '../../../Widgets/slider_image_header_auto.dart';
import '../../../Widgets/theme_helper.dart';
import 'package:url_launcher/url_launcher.dart';


class AboutUsView extends GetView<AboutUsController> {
  static const Color grey_5 = Color(0xFFf2f2f2);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: ThemeHelper().MainAppBar('StringAboutUs'.tr),
      backgroundColor: grey_5,
      body: Obx(() {
        if (controller.loading.value == true) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
        if (controller.Sys_Com_List.isEmpty) {
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset("${ImagePath}no_data.png",height: 60.h,),
                Text(
                  'StringNoData'.tr,
                  style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                      fontSize: 18.sp),
                ),
              ],
            ),
          );
        }
        return
        Padding(
          padding: EdgeInsets.only(left: 5.h, right: 5.h, top: 5.h),
          child: ListView.builder(
            itemCount: controller.Sys_Com_List.length,
            itemBuilder: (BuildContext context, int index) =>
                Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        height: 180.h,
                        child: SliderImageHeaderAutoRoute(),
                      ),
                      SizedBox(height: 5.h),
                      Stack(
                          children: <Widget>[
                            Align(
                              child: Image.asset(
                                  ThemeHelper.getimages('about.jpg'),
                                  fit: BoxFit.cover),
                            ),
                            Padding(
                              padding: EdgeInsets.only(
                                  right: 25.h,
                                  left: 25.h),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceAround,
                                children: [
                                  IconButton(
                                      icon: Icon(FontAwesomeIcons.facebook,
                                        color: Colors.blue,
                                        size: 25.h,),
                                      onPressed: () {
                                        String url =
                                            controller.Sys_Com_List[index].SCFA.toString();
                                        launch(url);
                                      }
                                  ),
                                  IconButton(
                                    icon: Icon(FontAwesomeIcons.phone,
                                      color: Colors.green,
                                      size: 25.h,),
                                    onPressed: () => launch("tel:${controller.Sys_Com_List[index].SCMO.toString()}"),
                                  ),
                                  IconButton(
                                    icon: Icon(FontAwesomeIcons.youtube,
                                      color: Colors.red,
                                      size: 25.h,),
                                    onPressed: () => launch(controller.Sys_Com_List[index].SCYO.toString()),
                                  ),
                                  IconButton(
                                      icon: Icon(FontAwesomeIcons.whatsapp,
                                        color: Colors.green,
                                        size: 25.h,),
                                      onPressed: () {
                                        String url =
                                            "https://wa.me/+${controller.Sys_Com_List[index].SCWA.toString()}";
                                        launch(url);
                                      }

                                  ),
                                  IconButton(
                                      icon: Icon(FontAwesomeIcons.google,
                                        color: Colors.blue,
                                        size: 25.h,),
                                      onPressed: () {
                                        String url =
                                            "https://${controller.Sys_Com_List[index].SCWE.toString()}";
                                        launch(url);
                                      }

                                  ),
                                ],
                              ),
                            ),
                          ]
                      ),
                      Card(
                        elevation: 2,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(
                              10.h),),
                        clipBehavior: Clip.antiAliasWithSaveLayer,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: <Widget>[
                            Text("العنوان", style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 20.sp)),
                            Center(
                              child: Container(
                                  width: 40.h,
                                  height: 4.h,
                                  decoration: BoxDecoration(
                                    color: Colors.red[700],
                                    borderRadius: BorderRadius.all(
                                        Radius.circular(5.h)),
                                  )),
                            ),
                            Container(height: 5.h),
                            Container(
                              width: double.infinity,
                              padding: EdgeInsets.symmetric(
                                  horizontal: 6.h),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  Image.asset(
                                      ThemeHelper.getimages('elite_ksa_map.jpg'),
                                      height: 180.h,
                                      width: double.infinity,
                                      fit: BoxFit.cover),
                                  Text("المركز الرئيسي", style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 15.sp)),
                                  Text(controller.Sys_Com_List[index].SCAD.toString(),),
                                  Text(
                                    'الهاتف:  ${controller.Sys_Com_List[index]
                                        .SCTL.toString()}',),
                                  Container(height: 10.h),
                                ],
                              ),
                            )
                          ],
                        ),
                      ),
                      Card(
                        elevation: 2,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(
                              10.h),),
                        clipBehavior: Clip.antiAliasWithSaveLayer,
                        child: Padding(
                          padding: EdgeInsets.symmetric(
                              horizontal: 10.h,
                              vertical: 5.h),
                          child: Container(
                            width: double.infinity,

                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: <Widget>[
                                Text("Developed By: ${controller.Sys_Com_List[index].SCNE.toString()}",
                                    style: TextStyle(
                                        fontSize: 15.sp,
                                        fontWeight: FontWeight.bold)),
                                Text(controller.Sys_Com_List[index].SCWE.toString(), style: TextStyle(
                                    fontSize: 14.sp,
                                    fontWeight: FontWeight.bold)),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ]
                ),
          ),
        );
      }
      ),

    );
  }
}
