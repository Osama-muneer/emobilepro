// import '../../../Operation/Controllers/sale_invoices_controller.dart';
// import '../../../Widgets/app_extension.dart';
// import '../../../Widgets/clipper.dart';
// import '../../../Widgets/colors.dart';
// import 'package:flutter/material.dart';
// import 'package:font_awesome_flutter/font_awesome_flutter.dart';
// import 'package:get/get.dart';
// import '../../../Widgets/theme_helper.dart';
//
// class Table_View extends StatefulWidget {
//   const Table_View({super.key});
//   @override
//   State<Table_View> createState() => _CheckOutState();
// }
//
// class _CheckOutState extends State<Table_View> {
//   @override
//   Widget build(BuildContext context) {
//     double height = MediaQuery.of(context).size.height;
//     double width = MediaQuery.of(context).size.width;
//     return GetBuilder<Sale_Invoices_Controller>(
//         init: Sale_Invoices_Controller(),
//         builder: ((controller) => Scaffold(
//           body: SingleChildScrollView(
//             child: Padding(
//               padding: const EdgeInsets.all(8.0),
//               child: Column(
//                 children: [
//                   // custom app bar
//                   Stack(
//                     children: [
//                       ClipPath(
//                         clipper: BottomClipper(),
//                         child: Container(
//                           decoration: BoxDecoration(
//                             color: Colors.black,
//                             borderRadius: BorderRadius.only(
//                               bottomLeft: Radius.circular(30),
//                               bottomRight: Radius.circular(30),
//                             ),
//                           ),
//                         ),
//                       ),
//                       Row(
//                         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                         children: [
//                           IconButton(
//                             onPressed: () {
//                               Navigator.pop(context);
//                             },
//                             icon: Icon(
//                               Icons.close,
//                               color: Colors.black,
//                             ),
//                           ),
//                           Text('StringRES_TAB'.tr,
//                             style: ThemeHelper().buildTextStyle(context,AppColors.black,'L')
//                           ),
//                         ],
//                       ),
//                     ],
//                   ),
//                   Column(
//                     children: [
//                       SizedBox(height: 0.02*height,),
//                       if(controller.RES_SEC.length>0)
//                       Row(
//                         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                         children: [
//                           Text(
//                             'StrinRSID'.tr,
//                             style:ThemeHelper().buildTextStyle(context,AppColors.black,'L'),
//                           ),
//                         ],
//                       ).fadeAnimation(0 * 0.1),
//                       if(controller.SelectDataGETTYPE=='1' )
//                       SizedBox(
//                         height:  height * 0.05,
//                         child: ListView.builder(
//                           physics: BouncingScrollPhysics(),
//                           scrollDirection: Axis.horizontal,
//                           itemCount: controller.RES_SEC.length,
//                           itemBuilder: (BuildContext context, int index) {
//                             return   Padding(
//                               padding:EdgeInsets.only(left: 0.01 * width, right: 0.01 * width),
//                               child: TextButton(
//                                 onPressed: () {
//                                   setState(() {
//                                     controller.SelectDataRSID=controller.RES_SEC[index].RSID.toString();
//                                     controller.SelectDataRTID=null;
//                                     controller.SelectDataREID=null;
//                                     controller.GET_RES_TAB_P(controller.RES_SEC[index].RSID.toString());
//                                     controller.GET_RES_EMP_P(controller.RES_SEC[index].RSID.toString());
//                                     controller.update();
//                                   });
//                                 },
//                                 style:
//                                 TextButton.styleFrom(
//                                   side:  BorderSide(color:controller.RES_SEC[index].RSID.toString()==controller.SelectDataRSID?
//                                   Colors.red:Colors.black45),
//                                   //foregroundColor: Colors.black,
//                                   // backgroundColor: Colors.grey[400],
//                                   shape:RoundedRectangleBorder(
//                                     borderRadius: BorderRadius.circular(0.01 * height), // <-- Radius
//                                   ),
//                                 ),
//                                 child: Text(
//                                   controller.RES_SEC[index].RSNA_D.toString(),
//                                   style:ThemeHelper().buildTextStyle(context, controller.RES_SEC[index].RSID.toString()==controller.SelectDataRSID?
//                                   Colors.red:Colors.black,'M')
//                                 ),
//                               ).fadeAnimation(index * 0.6),
//                             );
//                           },
//                         ),
//                       ),
//                       SizedBox(height: 0.02 * height),
//                       if(controller.SelectDataGETTYPE=='1'  && controller.RES_TAB.length>0 )
//                       Row(
//                         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                         children: [
//                           Text(
//                             'StringRES_TAB'.tr,
//                             style:ThemeHelper().buildTextStyle(context,AppColors.black,'L'),
//                           ),
//                         ],
//                       ).fadeAnimation(1 * 0.1),
//                       if(controller.SelectDataGETTYPE=='1')
//                       SizedBox(
//                         height: height / 23,
//                         child:  ListView.builder(
//                           physics: BouncingScrollPhysics(),
//                           scrollDirection: Axis.horizontal,
//                           itemCount: controller.RES_TAB.length,
//                           itemBuilder: (BuildContext context, int index) {
//                             return Padding(
//                               padding: EdgeInsets.only(left: 0.01 * width, right: 0.01 * width),
//                               child: TextButton(
//                                 onPressed: () {
//                                   setState(() {
//                                     if(controller.RES_TAB[index].RTID==controller.SelectDataRTID){
//                                       controller.SelectDataRTID=null;
//                                     }else{
//                                       controller.SelectDataRTID=controller.RES_TAB[index].RTID.toString();
//                                       controller.SelectDataRTNA=controller.RES_TAB[index].RTNA_D.toString();
//                                     }
//                                     controller.update();
//                                   });
//                                 },
//                                 style:
//                                 TextButton.styleFrom(
//                                   side:  BorderSide(color:controller.RES_TAB[index].RTID.toString()==controller.SelectDataRTID?
//                                   Colors.red:Colors.black45),
//                                   shape:RoundedRectangleBorder(
//                                     borderRadius: BorderRadius.circular( 0.01 * height), // <-- Radius
//                                   ),
//                                 ),
//                                 child:
//                                 Text(
//                                     "${controller.RES_TAB[index].RTID.toString()}-${controller.RES_TAB[index].RTNA_D.toString()}",
//                                     style: ThemeHelper().buildTextStyle(context, controller.RES_TAB[index].RTID.toString()==controller.SelectDataRTID?
//                                     Colors.red:Colors.black,'M')
//                                 ),
//                               ).fadeAnimation(index * 0.6),
//                             );
//                           },
//                         ),),
//                       SizedBox(height: 0.02 * height),
//                       if(controller.SelectDataGETTYPE=='1' && controller.RES_EMP.length>0)
//                       Row(
//                         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                         children: [
//                           Text(
//                             'StringRES_EMP'.tr,
//                             style:ThemeHelper().buildTextStyle(context,AppColors.black,'L'),
//                           ),
//                         ],
//                       ).fadeAnimation(2 * 0.1),
//                       if(controller.SelectDataGETTYPE=='1')
//                       SizedBox(
//                         height: height / 23,
//                         child:  ListView.builder(
//                           physics: BouncingScrollPhysics(),
//                           scrollDirection: Axis.horizontal,
//                           itemCount: controller.RES_EMP.length,
//                           itemBuilder: (BuildContext context, int index) {
//                             return Padding(
//                               padding: EdgeInsets.only(left: 0.01 * width, right: 0.01 * width),
//                               child: TextButton(
//                                 onPressed: () {
//                                   setState(() {
//                                     if(controller.RES_EMP[index].REID==controller.SelectDataREID){
//                                       controller.SelectDataREID=null;
//                                     }else{
//                                       controller.SelectDataREID=controller.RES_EMP[index].REID.toString();
//                                     }
//                                     controller.update();
//                                   });
//                                 },
//                                 style:
//                                 TextButton.styleFrom(
//                                   side:  BorderSide(color:controller.RES_EMP[index].REID.toString()==controller.SelectDataREID?
//                                   Colors.red:Colors.black45),
//                                   shape:RoundedRectangleBorder(
//                                     borderRadius: BorderRadius.circular( 0.01 * height), // <-- Radius
//                                   ),
//                                 ),
//                                 child: Text(
//                                     "${controller.RES_EMP[index].RENA_D.toString()}",
//                                     style: ThemeHelper().buildTextStyle(context, controller.RES_EMP[index].REID.toString()==controller.SelectDataREID?
//                                     Colors.red:Colors.black,'M')
//                                 ),
//                               ).fadeAnimation(index * 0.6),
//                             );
//                           },
//                         ),),
//                     ],
//                   ),
//                 ],
//               ),
//             ),
//           ),
//           floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
//           floatingActionButton: MaterialButton(
//             onPressed: () async {
//               controller.AddSale_Invoices();
//             },
//             child: Container(
//               height: 0.04 * height,
//               // width: 330.w,
//               alignment: Alignment.center,
//               decoration: BoxDecoration(color: AppColors.MainColor,
//                   borderRadius: BorderRadius.circular(10)),
//               child: Text('StringContinue'.tr, style:  ThemeHelper().buildTextStyle(context, Colors.white,'L')
//               ),
//             ).fadeAnimation(0 * 0.6),
//           ),
//         )));
//   }
// }