import '../../../Widgets/theme_helper.dart';
import 'package:flutter/material.dart';
import '../../../Widgets/colors.dart';
import 'package:get/get.dart';
import '../../controllers/home_controller.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  final HomeController controller = Get.find();
  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    var size = MediaQuery.of(context).size;
    return GetBuilder<HomeController>(
        init: HomeController(),
        builder: ((value) {return
          Scaffold(
      backgroundColor: AppColors.grey.withOpacity(0.05),
      appBar: AppBar(
        backgroundColor: AppColors.MainColor,
        title: Stack(
          children: [
            Text('${'Stringhello'.tr} ${controller.SUNAController.text}',
            style: ThemeHelper().buildTextStyle(context, Colors.white,'S')
          ),
            Padding(
              padding: EdgeInsets.only(top: 0.02* height),
              child:  Text(
                  "${controller.JTNAController.text}-${controller.BINAController.text} ",
                  style: ThemeHelper().buildTextStyle(context, Colors.white,'S')
                )
            ),
          ],
        ),
        elevation: 0.5,
        iconTheme: const IconThemeData(color: Colors.white),
        actions: [
          IconButton(
              icon: const Icon(Icons.logout),
              onPressed: () async {
                ThemeHelper().buildShowDialog(context);
              }),
        ],
      ),
      drawer: ThemeHelper().buildDrawer(context),
      body: Padding(
        padding: EdgeInsets.only(left: 0.02 * width, right: 0.02 * width),
        child: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(height: 0.01 * height),
              MainContainer(context,size,'Stringfinal',controller.COUNT_ST1,controller.SUM_ST1,AppColors.green),
              SizedBox(height: 0.01 * height),
              MainContainer(context,size,'StringNotfinal',controller.COUNT_ST2,controller.SUM_ST2,AppColors.blue),
              SizedBox(height: 0.01 * height),
              MainContainer(context,size,'StringPending',controller.COUNT_ST3,controller.SUM_ST3,AppColors.red),
            ],
          ),
        ),
      ),
    ); }));
  }


  Container MainContainer(BuildContext Context,Size size,String StateType,int? COUNT_ST,double? SUM_ST,Color AppColor) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return Container(
            width: double.infinity,
            decoration: BoxDecoration(
                color: AppColors.white2,
                borderRadius: BorderRadius.circular(12),
                boxShadow: [
                  BoxShadow(
                    color: AppColors.grey.withOpacity(0.01),
                    spreadRadius: 10,
                    blurRadius: 3,
                    // changes position of shadow
                  ),
                ]),
            child: Padding(
              padding:  EdgeInsets.only(left: 0.03 * width, right: 0.03 * width,bottom: 0.03 * height, top: 0.03 * height),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ThemeHelper().buildText(context,StateType, Color(0xff67727d).withOpacity(0.6),'L'),
                  SizedBox(height: 0.01 * height),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          Text(COUNT_ST.toString(),
                            style:  ThemeHelper().buildTextStyle(context, Colors.black,'L'),
                          ),
                          SizedBox(width: 0.02 * width),
                          Padding(
                            padding: const EdgeInsets.only(top: 3),
                            child: Text(
                              int.parse(controller.COUNT_ST.toString())!=0?
                              '${(COUNT_ST!/controller.COUNT_ST!*100).toStringAsFixed(0)}%':'0%',
                              style: ThemeHelper().buildTextStyle(context, Color(0xff67727d).withOpacity(0.6),'M'),
                            ),
                          ),
                        ],
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 3),
                        child: Text(
                          controller.formatter.format(SUM_ST).toString(),
                          style:ThemeHelper().buildTextStyle(context, Color(0xff67727d).withOpacity(0.6),'M'),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 0.01 * height),
                  Stack(
                    children: [
                      Container(
                        width: (size.width - int.parse(controller.COUNT_ST.toString())),
                        height:  0.005 * height,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(5),
                            color: Color(0xff67727d).withOpacity(0.1)),
                      ),
                      int.parse(controller.COUNT_ST.toString())!=0?
                      Container(
                        width: (size.width - int.parse(controller.COUNT_ST.toString())) * COUNT_ST!/controller.COUNT_ST!,
                        height: 0.005 * height,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(5),
                            color: AppColor),
                      ):Container(),
                    ],
                  )
                ],
              ),
            ),
          );
  }
}
