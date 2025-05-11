import 'dart:math';
import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:get/get.dart';
import '../../../Operation/models/bil_mov_d.dart';
import '../../../Operation/models/bil_mov_m.dart';
import '../../../Widgets/colors.dart';
import '../../../Widgets/config.dart';
import '../../../Widgets/sizes_helpers.dart';
import '../../../Widgets/theme_helper.dart';
import '../../../database/setting_db.dart';
import '../../controllers/home_controller.dart';
import 'package:intl/intl.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class Indicators_View extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<Indicators_View> {
 final HomeController controller = Get.find();
 int touchedIndex = -1;
 //دالة التقريب
 double roundDouble(double value, int places) {
   num mod = pow(10.0, places);
   return ((value * mod).round().toDouble() / mod);
 }
 final List<Map> GET_CON_3 = [
   {"id": '1', "name": 'StringBIID'.tr},
   {"id": '2', "name": 'StringMgno'.tr},
   {"id": '3', "name": 'StringMINO'.tr},
   {"id": '4', "name": 'StringSIID'.tr},
   {"id": '5', "name": 'StringBCID'.tr},
   {"id": '6', "name": 'StringCollector'.tr},
   {"id": '7', "name": 'StringUserName'.tr},
   {"id": '8', "name": 'StringPaymenttypes'.tr},
   {"id": '9', "name": 'StringACNOlableText'.tr},
   {"id": '10', "name": 'StringSCIDlableText'.tr},
 ].obs;
 final List<Map> GET_TOP_CUS = [
   {"id": '1', "name": 'StringTOP_CUS_SEL'.tr},
   {"id": '2', "name": 'StringTOP_CUS_RE_SEL'.tr},
 ].obs;
 final List<Map> GET_TOP_ITM = [
   {"id": '1', "name": 'StringTOP_ITM_SEL'.tr},
   {"id": '2', "name": 'StringTOP_ITM_RE_SEL'.tr},
 ].obs;


  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    final mediaQuery = MediaQuery.of(context);
    final viewInsets = mediaQuery.viewInsets;
    final screenHeight = mediaQuery.size.height;
    final screenWidth = mediaQuery.size.width;
    var size = MediaQuery.of(context).size;
    return  GetBuilder<HomeController>(
        builder: ((value) {
         return SingleChildScrollView(
      child: Padding(
          padding: const EdgeInsets.all(1.0),
          child:  STMID=='EORD'? _buildSalesInvoice(height,size):
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              DefaultTabController(
                length: 2,
                child: Column(
                  children: [
                    TabBar(
                    ///  isScrollable: true,
                      indicatorColor: Colors.red,
                      onTap: (V){
                        print('onTap');
                        print(V);
                      },
                      tabs: [
                        Tab(
                            child: ThemeHelper().buildText(context,'StringSalesInvoice'.tr, Colors.red,'M'),

                        ),
                        // Tab(
                        //   child: ThemeHelper().buildText(context,'StringACC'.tr, Colors.red,'M'),
                        // ),
                        Tab(
                          child: ThemeHelper().buildText(context,'StringPurchases'.tr, Colors.red,'M'),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: displayHeight(context) * 0.80,// تحديد ارتفاع المساحة المخصصة لمحتوى علامات التبويب
                      child: TabBarView(
                        children: [
                          _buildSalesInvoice(height,size),
                          // SingleChildScrollView(
                          //   child: Column(
                          //     children: [
                          //       SizedBox(height: 5.h),
                          //       Padding(
                          //         padding: const EdgeInsets.all(10.0),
                          //         child: Column(
                          //           children: [
                          //
                          //             const SizedBox(height: 4),
                          //             Row(
                          //               children: [
                          //                 Expanded(
                          //                   child: _buildCard(
                          //                     title: 'النقدية بنوك',
                          //                     value: '6,175,641.5557',
                          //                     color: Colors.green,
                          //                     icon: Icons.account_balance,
                          //                   ),
                          //                 ),
                          //                 SizedBox(width: 8),
                          //                 Expanded(
                          //                   child: _buildCard(
                          //                     title: 'النقدية صناديق',
                          //                     value: '4,092,414.1811-',
                          //                     color: Colors.blue,
                          //                     icon: Icons.money,
                          //                   ),
                          //                 ),
                          //               ],
                          //             ),
                          //             SizedBox(height: 8),
                          //             Row(
                          //               children: [
                          //                 Expanded(
                          //                   child: _buildChartCard(
                          //                     title: 'المصروفات',
                          //                     value: '389,056,493.2114',
                          //                     color: Colors.red,
                          //                   ),
                          //                 ),
                          //                 SizedBox(width: 8),
                          //                 Expanded(
                          //                   child: _buildChartCard(
                          //                     title: 'الإيرادات',
                          //                     value: '392,824,590.2843',
                          //                     color: Colors.green,
                          //                   ),
                          //                 ),
                          //               ],
                          //             ),
                          //           ],
                          //         ),
                          //       )
                          //     ],
                          //   ),
                          // ),
                          SingleChildScrollView(
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Column(
                                children: [
                                  FutureBuilder<List<Bil_Mov_M_Local>>(
                                      future: GET_COUNT_ST(1,
                                          controller.SelectDays_F ?? (controller.SelectDays_F = controller.selectedDatesercher.toString().split(" ")[0]),
                                          controller.SelectDays_T ?? (controller.SelectDays_T = controller.selectedDatesercher.toString().split(" ")[0])
                                      ), // جلب البيانات
                                      builder: (context, snapshot) {
                                        if (snapshot.connectionState == ConnectionState.waiting) {
                                          return const Center(child: CircularProgressIndicator());
                                        } else if (snapshot.hasError) {
                                          return Center(child: Text('حدث خطأ: ${snapshot.error}'));
                                        } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                                          return const Center(child: Text('لا توجد بيانات متاحة'));
                                        }

                                        final data = snapshot.data!.first;

                                        print('BMMST: ${data.BMMST}');
                                        print('BMMST2: ${data.BMMST2}');


                                        return Row(
                                          children: [
                                            Flexible(
                                              flex: 1,
                                              child: buildDashboard(
                                                icon: Icons.cloud,
                                                text: "StringStagebills".tr,
                                                value: data.BMMST.toString(),
                                                iconColor: Colors.green,
                                              ),
                                            ),
                                            SizedBox(width: 10),
                                            Flexible(
                                              flex: 1,
                                              child: buildDashboard(
                                                icon: Icons.cloud_off,
                                                text: "StringUnpostedInvoices".tr,
                                                value: data.BMMST2.toString(),
                                                iconColor: Colors.red,
                                              ),
                                            ),
                                          ],
                                        );
                                      }
                                  ),
                                  SizedBox(height: screenHeight * 0.015),
                                  Container(
                                    width: double.infinity,
                                    padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
                                    decoration: BoxDecoration(
                                      color: Colors.red, // خلفية عنوان الحركة اليومية
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                    child: Center(
                                      child:  Text(
                                        "StringPurchasesbypaymentmetod".tr,
                                        style: ThemeHelper().buildTextStyle(context, Colors.white,'L'),
                                      ),
                                    ),
                                  ),
                                  FutureBuilder<List<Bil_Mov_M_Local>>(
                                    future: GET_SUM_PAY_MOV(controller.SelectDataSCID.toString(),
                                        controller.SelectDays_F ?? (controller.SelectDays_F = controller.selectedDatesercher.toString().split(" ")[0]),
                                        controller.SelectDays_T ?? (controller.SelectDays_T = controller.selectedDatesercher.toString().split(" ")[0])
                                    ),
                                    builder: (context, snapshot) {
                                      if (snapshot.connectionState == ConnectionState.waiting) {
                                        return const Center(child: CircularProgressIndicator());
                                      } else if (snapshot.hasError) {
                                        return Text('خطأ: ${snapshot.error}');
                                      } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                                        return const Text('لا يوجد بيانات');
                                      } else {
                                        return controller.Type_chart==1?_buildNormalView(snapshot.data!)
                                            : _buildPieChart(snapshot.data!);
                                      }
                                    },
                                  ),
                                  SizedBox(height: screenHeight * 0.015),
                                  Container(
                                    width: double.infinity,
                                    padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
                                    decoration: BoxDecoration(
                                      color: Colors.red, // خلفية عنوان الحركة اليومية
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                    child: Center(
                                      child: Text(
                                        "StringTOP_BUY_SUP".tr,
                                        style: ThemeHelper().buildTextStyle(context, Colors.white,'L'),
                                      ),
                                    ),
                                  ),
                                  FutureBuilder<List<Bil_Mov_M_Local>>(
                                    future: getTopSuppliers(controller.SelectDataSCID.toString(),
                                        controller.SelectDays_F ?? (controller.SelectDays_F = controller.selectedDatesercher.toString().split(" ")[0]),
                                        controller.SelectDays_T ?? (controller.SelectDays_T = controller.selectedDatesercher.toString().split(" ")[0])
                                    ),
                                    builder: (context, snapshot) {
                                      if (snapshot.connectionState == ConnectionState.waiting) {
                                        return const Center(child: CircularProgressIndicator());
                                      } else if (snapshot.hasError) {
                                        return Center(child: Text('حدث خطأ: ${snapshot.error}'));
                                      } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                                        return const Center(child: Text('لا توجد بيانات لعرضها.'));
                                      } else {
                                        final topClients = snapshot.data!;
                                        final maxSales = topClients.map((client) => client.BMMMT).reduce((a, b) => a! > b! ? a : b);
                                        // قائمة ألوان متكررة
                                        final colors = [
                                          Colors.blue,
                                          Colors.green,
                                          Colors.orange,
                                          Colors.purple,
                                          Colors.red,
                                          Colors.teal,
                                        ];
                                        return Container(
                                          height: 300,
                                          child: ListView.builder(
                                            itemCount: topClients.length,
                                            itemBuilder: (context, index) {
                                              final client = topClients[index];
                                              final progress = client.BMMMT! / maxSales!;
                                              // اختيار لون بناءً على ترتيب العميل
                                              final color = colors[index % colors.length];
                                              return Card(
                                                elevation: 4,
                                                margin: const EdgeInsets.symmetric(vertical: 8),
                                                shape: RoundedRectangleBorder(
                                                  borderRadius: BorderRadius.circular(12),
                                                ),
                                                child: Padding(
                                                  padding: const EdgeInsets.all(16.0),
                                                  child: Column(
                                                    crossAxisAlignment: CrossAxisAlignment.start,
                                                    children: [
                                                      Row(
                                                        children: [
                                                          Expanded(
                                                            child: Text(
                                                              client.BMMNA.toString(),
                                                              style: const TextStyle(
                                                                fontSize: 13,
                                                                fontWeight: FontWeight.bold,
                                                              ),
                                                              maxLines: 1,
                                                              overflow: TextOverflow.ellipsis,
                                                            ),
                                                          ),
                                                          const SizedBox(width: 8),
                                                          Text(
                                                            controller.formatter.format(client.BMMMT).toString(),
                                                            style: const TextStyle(
                                                              fontSize: 14,
                                                              fontWeight: FontWeight.w500,
                                                              color: Colors.grey,
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                      const SizedBox(height: 8),
                                                      LinearProgressIndicator(
                                                        value: progress,
                                                        backgroundColor: Colors.grey[300],
                                                        color: color,
                                                        minHeight: 7,
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              );
                                            },
                                          ),
                                        );
                                      }
                                    },
                                  ),
                                  const SizedBox(height: 20),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 10),
            ],
          ),
        ),
    ); }));
  }

 Widget _buildSalesInvoice(height,size){
   final mediaQuery = MediaQuery.of(context);
   final viewInsets = mediaQuery.viewInsets;
   final screenHeight = mediaQuery.size.height;
   final screenWidth = mediaQuery.size.width;
   return SingleChildScrollView(
     child: Padding(
       padding: const EdgeInsets.all(8.0),
       child: Column(
         children: [
           if(STMID=='EORD') Column(
             children: [
               SizedBox(height: 0.01 * height),
               MainContainer(context,size,'Stringfinal',controller.COUNT_ST1,controller.SUM_ST1,AppColors.green),
               SizedBox(height: 0.01 * height),
               MainContainer(context,size,'StringNotfinal',controller.COUNT_ST2,controller.SUM_ST2,AppColors.blue),
               SizedBox(height: 0.01 * height),
               MainContainer(context,size,'StringPending',controller.COUNT_ST3,controller.SUM_ST3,AppColors.red),
               SizedBox(height: 0.01 * height),
             ],
           ),
           FutureBuilder<List<Bil_Mov_M_Local>>(
               future: GET_COUNT_ST(2,
                   controller.SelectDays_F ?? (controller.SelectDays_F = controller.selectedDatesercher.toString().split(" ")[0]),
                   controller.SelectDays_T ?? (controller.SelectDays_T = controller.selectedDatesercher.toString().split(" ")[0])
               ), // جلب البيانات
               builder: (context, snapshot) {
                 if (snapshot.connectionState == ConnectionState.waiting) {
                   return const Center(child: CircularProgressIndicator());
                 } else if (snapshot.hasError) {
                   return Center(child: Text('حدث خطأ: ${snapshot.error}'));
                 } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                   return const Center(child: Text('لا توجد بيانات متاحة'));
                 }

                 final data = snapshot.data!.first;

                 print('BMMST: ${data.BMMST}');
                 print('BMMST2: ${data.BMMST2}');


                 return Row(
                   children: [
                     Flexible(
                       flex: 1,
                       child: buildDashboard(
                         icon: Icons.cloud,
                         text: "StringStagebills".tr,
                         value: data.BMMST.toString(),
                         iconColor: Colors.green,
                       ),
                     ),
                     SizedBox(width: 10),
                     Flexible(
                       flex: 1,
                       child: buildDashboard(
                         icon: Icons.cloud_off,
                         text: "StringUnpostedInvoices".tr,
                         value: data.BMMST2.toString(),
                         iconColor: Colors.red,
                       ),
                     ),
                   ],
                 );
               }
           ),
           SizedBox(height: screenHeight * 0.015),
           if(STMID!='EORD')
           controller.Type_chart==1?
           FutureBuilder<List<Bil_Mov_M_Local>>(
               future: getSumBal(controller.SelectDataSCID.toString(),
                   controller.SelectDays_F ?? (controller.SelectDays_F = controller.selectedDatesercher.toString().split(" ")[0]),
                   controller.SelectDays_T ?? (controller.SelectDays_T = controller.selectedDatesercher.toString().split(" ")[0])
               ), // جلب البيانات
               builder: (context, snapshot) {
                 if (snapshot.connectionState == ConnectionState.waiting) {
                   return const Center(child: CircularProgressIndicator());
                 } else if (snapshot.hasError) {
                   return Center(child: Text('حدث خطأ: ${snapshot.error}'));
                 } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                   return const Center(child: Text('لا توجد بيانات متاحة'));
                 }

                 final data = snapshot.data!.first;
                 final double bmmmt = data.BMMMT ?? 0.0;
                 final double bmmam = data.BMMAM ?? 0.0;
                 final double net = data.NET ?? 0.0;

                 print('BMMMT: $bmmmt');
                 print('BMMAM: $bmmam');
                 print('NET: $net');


                 return Column(children: [
                   Row(
                     children: [
                       Flexible(
                         flex: 1,
                         child: buildDashboardCard(
                           icon: Icons.trending_up,
                           text: "StringSalesInvoice".tr,
                           value: controller.formatter.format(bmmmt).toString(),
                           iconColor: Colors.green,
                         ),
                       ),
                       SizedBox(width: 10),
                       Flexible(
                         flex: 1,
                         child: buildDashboardCard(
                           icon: Icons.trending_down,
                           text: "StringReturn_Sale".tr,
                           value: controller.formatter.format(bmmam).toString(),
                           iconColor: Colors.red,
                         ),
                       ),
                     ],
                   ),
                   const SizedBox(height: 5),
                   buildDashboardCard(
                     icon: Icons.attach_money,
                     text: "StringNet_Amount2".tr,
                     value: controller.formatter.format(net).toString(),
                     iconColor: Colors.blue,
                   ),
                 ],);
               }
           ):
           FutureBuilder<List<Bil_Mov_M_Local>>(
               future: getSumBal(controller.SelectDataSCID.toString(),
                   controller.SelectDays_F ?? (controller.SelectDays_F = controller.selectedDatesercher.toString().split(" ")[0]),
                   controller.SelectDays_T ?? (controller.SelectDays_T = controller.selectedDatesercher.toString().split(" ")[0])
               ), // جلب البيانات
               builder: (context, snapshot) {
                 if (snapshot.connectionState == ConnectionState.waiting) {
                   return const Center(child: CircularProgressIndicator());
                 } else if (snapshot.hasError) {
                   return Center(child: Text('حدث خطأ: ${snapshot.error}'));
                 } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                   return const Center(child: Text('لا توجد بيانات متاحة'));
                 }

                 final data = snapshot.data!.first;
                 final double bmmmt = data.BMMMT ?? 0.0;
                 final double bmmam = data.BMMAM ?? 0.0;
                 final double net = data.NET ?? 0.0;


                 double minValue = snapshot.data!.map((e) {
                   // يمكنك حساب الحد الأدنى بين القيم الثلاث
                   return [e.NET ?? 0.0, e.BMMAM ?? 0.0, e.BMMMT ?? 0.0].reduce((a, b) => a < b ? a : b);
                 }).reduce((a, b) => a < b ? a : b);

                 double maxValue = snapshot.data!.map((e) {
                   return [e.NET ?? 0.0, e.BMMAM ?? 0.0, e.BMMMT ?? 0.0].reduce((a, b) => a > b ? a : b);
                 }).reduce((a, b) => a > b ? a : b);

                 // إضافة هامش للنطاق
                 double margin = (maxValue - minValue) * 0.1;
                 double adjustedMax = maxValue + margin;
                 double adjustedMin = minValue - margin;


                 print('BMMMT: $bmmmt');
                 print('BMMAM: $bmmam');
                 print('NET: $net');

                 // // تحديد أعلى قيمة في المبيعات لضبط المحور Y
                 // double maxY = snapshot.data!.isEmpty
                 //     ? 100
                 //     : snapshot.data!.map((e) => e.BMMMT!).reduce((a, b) => a > b ? a : b).toDouble();
                 //
                 // // إضافة هامش ديناميكي (مثلاً 10% من أعلى قيمة)
                 // double margin = maxY * 0.9; // يمكنك تعديل النسبة حسب الحاجة
                 // maxY += margin;

                 return AspectRatio(
                   aspectRatio: 1.5,
                   child: BarChart(
                     BarChartData(
                       minY: adjustedMin,
                       maxY: adjustedMax,
                       alignment: BarChartAlignment.spaceAround,
                       barGroups: [
                         BarChartGroupData(
                           x: 0,
                           barRods: [
                             BarChartRodData(
                               toY: net,
                               color: Colors.green,
                               width: 30,
                               borderRadius: BorderRadius.circular(5),
                               backDrawRodData: BackgroundBarChartRodData(
                                 show: true,
                                 toY: net,
                                 color: Colors.green.withOpacity(0.3),
                               ),
                             ),
                           ],
                         ),
                         BarChartGroupData(
                           x: 1,
                           barRods: [
                             BarChartRodData(
                               toY: bmmam,
                               color: Colors.red,
                               width: 30,
                               borderRadius: BorderRadius.circular(5),
                               backDrawRodData: BackgroundBarChartRodData(
                                 show: true,
                                 toY: bmmam,
                                 color: Colors.red.withOpacity(0.3),
                               ),
                             ),
                           ],
                         ),
                         BarChartGroupData(
                           x: 2,
                           barRods: [
                             BarChartRodData(
                               toY: bmmmt,
                               color: Colors.blue,
                               width: 30,
                               borderRadius: BorderRadius.circular(5),
                               backDrawRodData: BackgroundBarChartRodData(
                                 show: true,
                                 toY: bmmmt,
                                 color: Colors.blue.withOpacity(0.3),
                               ),
                             ),
                           ],
                         ),
                       ],
                       titlesData: FlTitlesData(
                         bottomTitles: AxisTitles(
                           sideTitles: SideTitles(
                             showTitles: true,
                             getTitlesWidget: (double value, TitleMeta meta) {
                               switch (value.toInt()) {
                                 case 0:
                                   return Text('StringNet_Amount2'.tr);
                                 case 1:
                                   return Text('StringReturn_Sale'.tr);
                                 case 2:
                                   return Text('StringSalesInvoice'.tr);
                                 default:
                                   return const Text("");
                               }
                             },
                           ),
                         ),
                         topTitles: AxisTitles(
                           sideTitles: SideTitles(
                             showTitles: true,
                             getTitlesWidget: (double value, TitleMeta meta) {
                               switch (value.toInt()) {
                                 case 0:
                                   return Text("${controller.formatter.format(net).toString()}", style: TextStyle(color: Colors.green));
                                 case 1:
                                   return Text("${controller.formatter.format(bmmam).toString()}", style: TextStyle(color: Colors.red));
                                 case 2:
                                   return Text("${controller.formatter.format(bmmmt).toString()}", style: TextStyle(color: Colors.blue));
                                 default:
                                   return const Text("");
                               }
                             },
                           ),
                         ),
                         leftTitles: AxisTitles(
                           sideTitles: SideTitles(showTitles: false),
                         ),
                         rightTitles: AxisTitles(
                           sideTitles: SideTitles(showTitles: false),
                         ),
                       ),
                     ),
                   ),
                 );

               }
           ),
           SizedBox(height: screenHeight * 0.015),
           Container(
             width: double.infinity,
             padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
             decoration: BoxDecoration(
               color: Colors.red, // خلفية عنوان الحركة اليومية
               borderRadius: BorderRadius.circular(10),
             ),
             child: Center(
               child:  Text(
                 "StringMonthlySales".tr,
                 style: ThemeHelper().buildTextStyle(context, Colors.white,'L'),
               ),
             ),
           ),
           const SizedBox(height: 4),
           FutureBuilder<List<Bil_Mov_M_Local>>(
             future: getMonthlySales(controller.SelectDataSCID.toString(),
                 controller.SelectDays_F ?? (controller.SelectDays_F = controller.selectedDatesercher.toString().split(" ")[0]),
                 controller.SelectDays_T ?? (controller.SelectDays_T = controller.selectedDatesercher.toString().split(" ")[0])
             ),
             builder: (context, snapshot) {
               if (snapshot.connectionState == ConnectionState.waiting) {
                 return const Center(child: CircularProgressIndicator());
               } else if (snapshot.hasError) {
                 return Center(child: Text('حدث خطأ: ${snapshot.error}'));
               } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                 return const Center(child: Text('لا توجد بيانات متاحة'));
               }

               // تحويل البيانات لشكل يمكن رسمه
               List<BarChartGroupData> barGroups = snapshot.data!.map((sales) {
                 int monthIndex = DateTime.parse("${sales.BMMDO}-01").month - 1;
                 print('monthIndex: $monthIndex');
                 print('sales.BMMMT!: ${sales.BMMMT!}');

                 return BarChartGroupData(
                   x: monthIndex,
                   barRods: [
                     BarChartRodData(
                       toY: sales.BMMMT!,
                       color: Colors.red,
                       width: 15,
                       borderRadius: BorderRadius.circular(5),
                       backDrawRodData: BackgroundBarChartRodData(
                         show: true,
                         toY: sales.BMMMT!,
                         color: Colors.blue.withOpacity(0.3),
                       ),
                     ),
                   ],
                 );
               }).toList();

               // تحديد أعلى قيمة في المبيعات لضبط المحور Y
               double maxY = snapshot.data!.map((e) => e.BMMMT!).reduce((a, b) => a > b ? a : b) + 100;

               // أسماء الأشهر
               List<String> monthNames = [
                 "يناير", "فبراير", "مارس", "أبريل", "مايو", "يونيو",
                 "يوليو", "أغسطس", "سبتمبر", "أكتوبر", "نوفمبر", "ديسمبر"
               ];

               return AspectRatio(
                 aspectRatio: 1.5,
                 child: BarChart(
                   BarChartData(
                     alignment: BarChartAlignment.spaceAround,
                     maxY: maxY,
                     barGroups: barGroups,
                     titlesData: FlTitlesData(
                       bottomTitles: AxisTitles(
                         sideTitles: SideTitles(
                           showTitles: true,
                           getTitlesWidget: (double value, TitleMeta meta) {
                             int monthIndex = value.toInt();
                             print('monthIndex: $monthIndex');
                             print('snapshot.data!.length: ${snapshot.data!.length}');

                             if (snapshot.data!.any((sale) => DateTime.parse("${sale.BMMDO}-01").month - 1 == monthIndex)) {
                               String monthName = monthNames[monthIndex];
                               String year = snapshot.data!.firstWhere(
                                       (sale) => DateTime.parse("${sale.BMMDO}-01").month - 1 == monthIndex
                               ).BMMDO!.substring(0, 4);
                               print('monthName= $monthName');
                               print('year=$year');
                               return Padding(
                                 padding: const EdgeInsets.only(top: 3.0),
                                 child: Text(
                                   "$monthName $year",
                                   style: TextStyle(fontSize: 12),
                                 ),
                               );
                             }
                             return const Text("");
                           },
                         ),
                       ),
                       topTitles: AxisTitles(
                         sideTitles: SideTitles(
                           showTitles: true,
                           getTitlesWidget: (double value, TitleMeta meta) {
                             int monthIndex = value.toInt();
                             if (snapshot.data!.any((sale) => DateTime.parse("${sale.BMMDO}-01").month - 1 == monthIndex)) {
                               double valueForMonth = snapshot.data!.firstWhere((sale) => DateTime.parse("${sale.BMMDO}-01").month - 1 == monthIndex).BMMMT!;
                               return Padding(
                                 padding: const EdgeInsets.only(bottom: 8.0),
                                 child: Text(
                                   controller.formatter.format(valueForMonth).toString(),
                                   style: TextStyle(fontSize:snapshot.data!.length>4?10.5: 12, color: Colors.black),
                                 ),
                               );
                             }
                             return const Text("");
                           },
                         ),
                       ),
                       leftTitles: AxisTitles(
                         sideTitles: SideTitles(showTitles: false),
                       ),
                       rightTitles: AxisTitles(
                         sideTitles: SideTitles(showTitles: false),
                       ),
                     ),
                     gridData: FlGridData(show: false),
                   ),
                 ),
               );
             },
           ),
           SizedBox(height: screenHeight * 0.015),
           if(STMID!='EORD')Container(
             decoration: BoxDecoration(
               color: Colors.red,
               borderRadius: BorderRadius.circular(8.0),
               border: Border.all(color: Colors.red, width: 1.0),
             ),
             padding: const EdgeInsets.symmetric(horizontal: 12.0),
             child: DropdownButtonFormField<String>(
               value: controller.TYPE_T,
               dropdownColor: Colors.red,
               iconEnabledColor: Colors.white,
               items: GET_CON_3.map((item) => DropdownMenuItem<String>(
                 value: item['id'],
                 child: Text(
                   item['name'],
                   style: ThemeHelper().buildTextStyle(context, Colors.white,'L'),
                 ),
               )).toList().obs,
               onChanged: (value) {
                 setState(() {
                   controller.TYPE_T = value.toString();
                   controller.update();
                 });
               },
               decoration: const InputDecoration(
                 border: InputBorder.none,
               ),
             ),
           ),
           if(STMID!='EORD')SizedBox(height: screenHeight * 0.015),
           // FutureBuilder<List<Bil_Mov_M_Local>>(
           //   future: getBil('1'),
           //   builder: (context, snapshot) {
           //     if (snapshot.connectionState == ConnectionState.waiting) {
           //       return const Center(child: CircularProgressIndicator());
           //     }
           //     if (snapshot.hasError) {
           //       return Center(child: Text("حدث خطأ: ${snapshot.error}"));
           //     }
           //     if (!snapshot.hasData || snapshot.data!.isEmpty) {
           //       return const Center(child: Text("لا توجد بيانات"));
           //     }
           //     return SalesBarChart(data: snapshot.data!);
           //   },
           // ),
           if(STMID!='EORD')
           FutureBuilder<List<Bil_Mov_M_Local>>(
             future: getBil(controller.TYPE_T,controller.SelectDataSCID.toString(),
                 controller.SelectDays_F ?? (controller.SelectDays_F = controller.selectedDatesercher.toString().split(" ")[0]),
                 controller.SelectDays_T ?? (controller.SelectDays_T = controller.selectedDatesercher.toString().split(" ")[0])
             ),
             builder: (context, snapshot) {
               if (snapshot.connectionState == ConnectionState.waiting) {
                 return const Center(child: CircularProgressIndicator());
               }
               else if (snapshot.hasError) {
                 print( '${snapshot.error}${snapshot.stackTrace}');
                 return Center(child: Text('حدث خطأ: ${snapshot.error}${snapshot.hasError}'));
               }
               else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                 return const Center(child: Text('لا توجد بيانات لعرضها.'));
               } else {
                 final tableData = snapshot.data!.map((e) => {
                   '1': controller.TYPE_T=='2'?e.MGNO:controller.TYPE_T=='3'?e.MINO:controller.TYPE_T=='7'?e.SUID:
                   controller.TYPE_T=='9'?e.ACNO:e.BIID2, // رقم الفرع أو اسمه
                   '2': e.BINA_D, // رقم الفرع أو اسمه
                   '3': e.BMMMT!.toDouble(), // المبيعات الإجمالية
                   '4': e.BMMAM!.toDouble(), // قيمة افتراضية للمردود (يمكنك التعديل حسب بياناتك)
                   '5': (e.BMMMT!-e.BMMAM!).toDouble(), // صافي المبيعات
                 }).toList();
                 return Container(
                   height: 300,
                   child: Card(
                     elevation: 4.0,
                     shape: RoundedRectangleBorder(
                       borderRadius: BorderRadius.circular(12.0),
                     ),
                     child: Padding(
                       padding: const EdgeInsets.all(3),
                       child: SingleChildScrollView(
                         scrollDirection: Axis.horizontal,
                         child: SingleChildScrollView(
                           child: DataTable(
                             headingRowColor: MaterialStateColor.resolveWith((states) => Colors.indigo.shade100),
                             columns:  [
                               DataColumn(
                                 label: Text(controller.TYPE_T=='1'?'StringBIID'.tr:controller.TYPE_T=='2'?'StringMgno'.tr:
                                 controller.TYPE_T=='3'?'StringMINO'.tr:controller.TYPE_T=='4'?'StringSIID'.tr:
                                 controller.TYPE_T=='5'?'StringBCID'.tr:controller.TYPE_T=='6'?'StringCollector'.tr:
                                 controller.TYPE_T=='8'?'StringPaymenttypes'.tr:controller.TYPE_T=='9'?'StringACNOlableText'.tr
                                     :controller.TYPE_T=='10'?'StringSCIDlableText'.tr:'StringUserName'.tr, style: TextStyle(fontWeight: FontWeight.bold)),
                               ),
                               DataColumn(
                                 label: Text('StringBMMNA'.tr, style: TextStyle(fontWeight: FontWeight.bold)),
                               ),
                               DataColumn(
                                 label: Text('StringSalesInvoice'.tr, style: TextStyle(fontWeight: FontWeight.bold)),
                               ),
                               DataColumn(
                                 label: Text('StringReturn_Sale'.tr, style: TextStyle(fontWeight: FontWeight.bold)),
                               ),
                               DataColumn(
                                 label: Text('StringNet_Amount2'.tr, style: TextStyle(fontWeight: FontWeight.bold)),
                               ),
                             ],
                             rows: tableData.map((row) => DataRow(
                               cells: [
                                 DataCell(Text(row['1'].toString(), style: const TextStyle(fontSize: 14))),
                                 DataCell(Text(row['2'].toString(), style: const TextStyle(fontSize: 14))),
                                 DataCell(Text(
                                   controller.formatter.format(row['3']).toString(),
                                   style: const TextStyle(fontSize: 14, color: Colors.green),
                                 )),
                                 DataCell(Text(
                                   controller.formatter.format(row['4']).toString(),
                                   style: const TextStyle(fontSize: 14, color: Colors.red),
                                 )),
                                 DataCell(Text(
                                     controller.formatter.format(row['5']).toString(),
                                   style: const TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
                                 )),
                               ],
                             ),
                             ).toList(),
                           ),
                         ),
                       ),
                     ),
                   ),
                 );
               }
             },
           ),
           SizedBox(height: screenHeight * 0.015),
           Container(
             width: double.infinity,
             padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
             decoration: BoxDecoration(
               color: Colors.red, // خلفية عنوان الحركة اليومية
               borderRadius: BorderRadius.circular(10),
             ),
             child: Center(
               child:  Text(
                 "StringSalesbypaymentmethod".tr,
                 style: ThemeHelper().buildTextStyle(context, Colors.white,'L'),
               ),
             ),
           ),
           FutureBuilder<List<Bil_Mov_M_Local>>(
             future: GET_SUM_PAY_BIL_MOV(controller.SelectDataSCID.toString(),
                 controller.SelectDays_F ?? (controller.SelectDays_F = controller.selectedDatesercher.toString().split(" ")[0]),
                 controller.SelectDays_T ?? (controller.SelectDays_T = controller.selectedDatesercher.toString().split(" ")[0])
             ),
             builder: (context, snapshot) {
               if (snapshot.connectionState == ConnectionState.waiting) {
                 return const Center(child: CircularProgressIndicator());
               } else if (snapshot.hasError) {
                 return Text('خطأ: ${snapshot.error}');
               } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                 return const Text('لا يوجد بيانات');
               } else {
                 return controller.Type_chart==1?_buildNormalView(snapshot.data!)
                     : _buildPieChart(snapshot.data!);
               }
             },
           ),
           SizedBox(height: screenHeight * 0.015),
           Container(
             decoration: BoxDecoration(
               color: Colors.red,
               borderRadius: BorderRadius.circular(8.0),
               border: Border.all(color: Colors.red, width: 1.0),
             ),
             padding: const EdgeInsets.symmetric(horizontal: 12.0),
             child: DropdownButtonFormField<String>(
               value: controller.TYPE_TOP_CUS,
               dropdownColor: Colors.red,
               iconEnabledColor: Colors.white,
               items: GET_TOP_CUS.map((item) => DropdownMenuItem<String>(
                 value: item['id'],
                 child: Text(
                   item['name'],
                   style: ThemeHelper().buildTextStyle(context, Colors.white,'L'),
                 ),
               )).toList().obs,
               onChanged: (value) {
                 setState(() {
                   controller.TYPE_TOP_CUS = value.toString();
                   controller.update();
                 });
               },
               decoration: const InputDecoration(
                 border: InputBorder.none,
               ),
             ),
           ),
           SizedBox(height: screenHeight * 0.015),
           FutureBuilder<List<Bil_Mov_M_Local>>(
             future: getTopClients(controller.TYPE_TOP_CUS,controller.SelectDataSCID.toString(),
                 controller.SelectDays_F ?? (controller.SelectDays_F = controller.selectedDatesercher.toString().split(" ")[0]),
                 controller.SelectDays_T ?? (controller.SelectDays_T = controller.selectedDatesercher.toString().split(" ")[0])
             ),
             builder: (context, snapshot) {
               if (snapshot.connectionState == ConnectionState.waiting) {
                 return const Center(child: CircularProgressIndicator());
               } else if (snapshot.hasError) {
                 return Center(child: Text('حدث خطأ: ${snapshot.error}'));
               } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                 return const Center(child: Text('لا توجد بيانات لعرضها.'));
               } else {
                 final topClients = snapshot.data!;
                 final maxSales = topClients.map((client) => client.BMMMT).reduce((a, b) => a! > b! ? a : b);
                 // قائمة ألوان متكررة
                 final colors = [
                   Colors.blue,
                   Colors.green,
                   Colors.orange,
                   Colors.purple,
                   Colors.red,
                   Colors.teal,
                 ];
                 return controller.Type_chart==1?  Container(
                   height: 300,
                   child: ListView.builder(
                     itemCount: topClients.length,
                     itemBuilder: (context, index) {
                       final client = topClients[index];
                       final progress = client.BMMMT! / maxSales!;
                       // اختيار لون بناءً على ترتيب العميل
                       final color = colors[index % colors.length];
                       return Card(
                         elevation: 4,
                         margin: const EdgeInsets.symmetric(vertical: 8),
                         shape: RoundedRectangleBorder(
                           borderRadius: BorderRadius.circular(12),
                         ),
                         child: Padding(
                           padding: const EdgeInsets.all(16.0),
                           child: Column(
                             crossAxisAlignment: CrossAxisAlignment.start,
                             children: [
                               Row(
                                 children: [
                                   Expanded(
                                     child: Text(
                                       client.BMMNA.toString(),
                                       style: const TextStyle(
                                         fontSize: 13,
                                         fontWeight: FontWeight.bold,
                                       ),
                                       maxLines: 1,
                                       overflow: TextOverflow.ellipsis,
                                     ),
                                   ),
                                   const SizedBox(width: 8),
                                   Text(
                                     controller.formatter.format(client.BMMMT).toString(),
                                     style: const TextStyle(
                                       fontSize: 14,
                                       fontWeight: FontWeight.w500,
                                       color: Colors.grey,
                                     ),
                                   ),
                                 ],
                               ),
                               const SizedBox(height: 8),
                               LinearProgressIndicator(
                                 value: progress,
                                 backgroundColor: Colors.grey[300],
                                 color: color,
                                 minHeight: 7,
                               ),
                             ],
                           ),
                         ),
                       );
                     },
                   ),
                 ):
               StunningTopCusChart(items: snapshot.data!);
               }
             },
           ),
           SizedBox(height: screenHeight * 0.015),
           Container(
             decoration: BoxDecoration(
               color: Colors.red,
               borderRadius: BorderRadius.circular(8.0),
               border: Border.all(color: Colors.red, width: 1.0),
             ),
             padding: const EdgeInsets.symmetric(horizontal: 12.0),
             child: DropdownButtonFormField<String>(
               value: controller.TYPE_TOP_ITM,
               dropdownColor: Colors.red,
               iconEnabledColor: Colors.white,
               items: GET_TOP_ITM.map((item) => DropdownMenuItem<String>(
                 value: item['id'],
                 child: Text(
                   item['name'],
                   style: ThemeHelper().buildTextStyle(context, Colors.white,'L'),
                 ),
               )).toList().obs,
               onChanged: (value) {
                 setState(() {
                   controller.TYPE_TOP_ITM = value.toString();
                   controller.update();
                 });
               },
               decoration: const InputDecoration(
                 border: InputBorder.none,
               ),
             ),
           ),
           SizedBox(height: screenHeight * 0.015),
           FutureBuilder<List<Bil_Mov_D_Local>>(
             future: getTopItem(controller.TYPE_TOP_ITM,controller.SelectDataSCID.toString(),
                 controller.SelectDays_F ?? (controller.SelectDays_F = controller.selectedDatesercher.toString().split(" ")[0]),
                 controller.SelectDays_T ?? (controller.SelectDays_T = controller.selectedDatesercher.toString().split(" ")[0])
             ),
             builder: (context, snapshot) {
               if (snapshot.connectionState == ConnectionState.waiting) {
                 return const Center(child: CircularProgressIndicator());
               } else if (snapshot.hasError) {
                 return Center(child: Text('حدث خطأ: ${snapshot.error}'));
               } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                 return const Center(child: Text('لا توجد بيانات لعرضها.'));
               } else {
                 final topClients = snapshot.data!;
                 final maxSales = topClients.map((client) => client.BMDAMT).reduce((a, b) => a! > b! ? a : b);
                 // قائمة ألوان متكررة
                 final colors = [
                   Colors.blue,
                   Colors.green,
                   Colors.orange,
                   Colors.purple,
                   Colors.red,
                   Colors.teal,
                 ];
                 return  controller.Type_chart==1? Container(
                   height: 300,
                   child: ListView.builder(
                     itemCount: topClients.length,
                     itemBuilder: (context, index) {
                       final client = topClients[index];
                       final progress = client.BMDAMT! / maxSales!;
                       // اختيار لون بناءً على ترتيب العميل
                       final color = colors[index % colors.length];
                       return Card(
                         elevation: 4,
                         margin: const EdgeInsets.symmetric(vertical: 8),
                         shape: RoundedRectangleBorder(
                           borderRadius: BorderRadius.circular(12),
                         ),
                         child: Padding(
                           padding: const EdgeInsets.all(16.0),
                           child: Column(
                             crossAxisAlignment: CrossAxisAlignment.start,
                             children: [
                               Row(
                                 children: [
                                   Expanded(
                                     child: Text(
                                       client.MINA_D.toString(),
                                       style: const TextStyle(
                                         fontSize: 13,
                                         fontWeight: FontWeight.bold,
                                       ),
                                       maxLines: 1,
                                       overflow: TextOverflow.ellipsis,
                                     ),
                                   ),
                                   const SizedBox(width: 8),
                                   Text(
                                     "${controller.formatter.format(client.BMDAMT).toString()} (${controller.formatter.format(client.BMDNO).toString()})",
                                     style: const TextStyle(
                                       fontSize: 14,
                                       fontWeight: FontWeight.w500,
                                       color: Colors.grey,
                                     ),
                                   ),
                                 ],
                               ),
                               const SizedBox(height: 8),
                               LinearProgressIndicator(
                                 value: progress,
                                 backgroundColor: Colors.grey[300],
                                 color: color,
                                 minHeight: 7,
                               ),
                             ],
                           ),
                         ),
                       );
                     },
                   ),
                 ):
                 StunningTopItemsChart(items: snapshot.data!);
               }
             },
           ),
           SizedBox(height: screenHeight * 0.015),
         ],
       ),
     ),
   );
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


 Widget _buildDetailsTable(List<Bil_Mov_D_Local> items) {
   return DataTable(
     columns: const [
       DataColumn(label: Text('المجموعة', style: TextStyle(fontFamily: 'Hacen'))),
       DataColumn(label: Text('الصنف', style: TextStyle(fontFamily: 'Hacen'))),
       DataColumn(label: Text('المبلغ', style: TextStyle(fontFamily: 'Hacen'))),
     ],
     rows: items.map((item) => DataRow(
       cells: [
         DataCell(Text(item.MGNO.toString(), style: TextStyle(fontFamily: 'Hacen'))),
         DataCell(Text(item.MINO.toString(), style: TextStyle(fontFamily: 'Hacen'))),
         DataCell(Text(
           NumberFormat('#,###').format(item.BMDAMT),
           style: TextStyle(fontFamily: 'Hacen'),
         )),
       ],
     )).toList(),
   );
 }

 Widget _buildPieChart(List<Bil_Mov_M_Local> data) {
   // تنسيق الأرقام بفواصل (مثال: 2,300)
   final formatter = NumberFormat('#,###');

   return SfCircularChart(
   //  title: ChartTitle(text: 'توزيع المبيعات حسب طريقة الدفع'.tr),
     legend: Legend(
       isVisible: true,
       position: LegendPosition.bottom,
       overflowMode: LegendItemOverflowMode.wrap,
       textStyle: const TextStyle(fontFamily: 'Hacen', fontSize: 14),
     ),
     series: <PieSeries<Bil_Mov_M_Local, String>>[
       PieSeries<Bil_Mov_M_Local, String>(
         dataSource: data,
         xValueMapper: (Bil_Mov_M_Local sales, _) => sales.PKNA_D,
         yValueMapper: (Bil_Mov_M_Local sales, _) => sales.BMMMT,
         dataLabelSettings: const DataLabelSettings(
           isVisible: true,
           labelPosition: ChartDataLabelPosition.outside,
           textStyle: TextStyle(fontFamily: 'Hacen', fontSize: 12),
           connectorLineSettings: ConnectorLineSettings(
             length: '20%',
             color: Colors.grey,
           ),
         ),
         // عرض المبلغ مع فواصل
         dataLabelMapper: (Bil_Mov_M_Local sales, _) =>
             formatter.format(sales.BMMMT),
         // تخصيص لون لكل طريقة دفع
         pointColorMapper: (Bil_Mov_M_Local sales, _) => _getColor(sales.PKID!),
         enableTooltip: true,
       ),
     ],
   );
 }

 // تخصيص ألوان ثابتة لكل PKID
 Color _getColor(int pkid) {
   const colors = {
     1: Color(0xFF4CAF50), // نقداً - أخضر
     3: Color(0xFF2196F3), // أجـل - أزرق
     8: Color(0xFFFFC107), // بطاقة ائتمان - أصفر
     9: Color(0xFFE91E63), // حوالة - وردي
   };
   return colors[pkid] ?? Colors.grey; // لون افتراضي إذا لم يوجد
 }

 Widget _buildCard({
   required String title,
   required String value,
   required Color color,
   required IconData icon,
 }) {
   return Card(
     color: color.withOpacity(0.9),
     shape: RoundedRectangleBorder(
       borderRadius: BorderRadius.circular(10),
     ),
     child: Padding(
       padding: const EdgeInsets.all(16.0),
       child: Column(
         crossAxisAlignment: CrossAxisAlignment.center,
         children: [
           Text(
             title,
             style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold),
           ),
           SizedBox(height: 8),
           Text(
             value,
             style: TextStyle(color: Colors.white, fontSize: 16),
           ),
           SizedBox(height: 8),
           Icon(icon, color: Colors.white, size: 24),
         ],
       ),
     ),
   );
 }

 Widget _buildChartCard({
   required String title,
   required String value,
   required Color color,
 }) {
   return Card(
     shape: RoundedRectangleBorder(
       borderRadius: BorderRadius.circular(10),
     ),
     child: Padding(
       padding: const EdgeInsets.all(16.0),
       child: Column(
         crossAxisAlignment: CrossAxisAlignment.center,
         children: [
           Text(
             title,
             style: TextStyle(color: color, fontSize: 18, fontWeight: FontWeight.bold),
           ),
           SizedBox(height: 8),
           Text(
             value,
             style: TextStyle(color: color, fontSize: 16),
           ),
           SizedBox(height: 8),
           SizedBox(
             height: 100,
             child: LineChart(
               LineChartData(
                 titlesData: FlTitlesData(show: false),
                 borderData: FlBorderData(show: false),
                 gridData: FlGridData(show: false),
                 lineBarsData: [
                   LineChartBarData(
                     isCurved: true,
                     color: color, // ✅ الحل هنا
                     spots: [
                       FlSpot(1, 1),
                       FlSpot(2, 1.5),
                       FlSpot(3, 1.4),
                       FlSpot(4, 3.4),
                       FlSpot(5, 2),
                       FlSpot(6, 2.2),
                       FlSpot(7, 1.8),
                     ],
                     belowBarData: BarAreaData(show: true, color: color.withOpacity(0.3)),
                   ),
                 ],
               ),
             ),
           ),
         ],
       ),
     ),
   );
 }

// 2. التصميم العادي مع الأيقونات
  Widget _buildNormalView(List<Bil_Mov_M_Local> data) {
    final formatter = NumberFormat('#,###');
    return Container(
      height: 300,
      child: ListView.separated(
        padding: EdgeInsets.all(12),
        itemCount: data.length,
        separatorBuilder: (context, index) => Divider(height: 1),
        itemBuilder: (context, index) {
          final item = data[index];
          return ListTile(
            leading: Container(
              padding: EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: _getColor(item.PKID!).withOpacity(0.1),
                borderRadius: BorderRadius.circular(8),
              ),
              child: _getPaymentIcon(item.PKID!), // الأيقونة المخصصة
            ),
            title: Text(
              item.PKNA_D.toString(),
              style: TextStyle(
                fontFamily: 'Hacen',
                fontSize: 16,
                fontWeight: FontWeight.w600,
              ),
            ),
            trailing: Text(
              '${formatter.format(item.BMMMT)}',
              style: TextStyle(
                fontFamily: 'Hacen',
                fontSize: 16,
                color: Colors.grey[700],
              ),
            ),
          );
        },
      ),
    );
  }

// دالة لإرجاع الأيقونة حسب نوع الدفع
  Icon _getPaymentIcon(int pkid) {
    const iconSize = 24.0;
    switch (pkid) {
      case 1: // نقداً
        return Icon(Icons.money, color: _getColor(pkid), size: iconSize);
      case 3: // أجـل
        return Icon(Icons.calendar_today, color: _getColor(pkid), size: iconSize);
      case 8: // بطاقة ائتمان
        return Icon(Icons.credit_card, color: _getColor(pkid), size: iconSize);
      case 9: // حوالة
        return Icon(Icons.account_balance, color: _getColor(pkid), size: iconSize);
      default:
        return Icon(Icons.payment, color: _getColor(pkid), size: iconSize);
    }
  }

 Widget _buildStatCard(String title, String value, Color color) {
   return Container(
     decoration: BoxDecoration(
       color: color.withOpacity(0.1),
       borderRadius: BorderRadius.circular(10),
       border: Border.all(color: color, width: 1),
     ),
     child: Padding(
       padding: const EdgeInsets.all(8.0),
       child: Column(
         mainAxisAlignment: MainAxisAlignment.center,
         children: [
           Text(
             title,
             style: TextStyle(
               fontSize: 14,
               color: color,
               fontWeight: FontWeight.bold,
             ),
           ),
           const SizedBox(height: 5),
           Text(
             value,
             style: TextStyle(
               fontSize: 16,
               color: color,
               fontWeight: FontWeight.bold,
             ),
           ),
         ],
       ),
     ),
   );
 }

 List<PieChartSectionData> showingSections(int GETTYPE) {
   return List.generate(4, (i) {
     final isTouched = i == touchedIndex;
     final fontSize = isTouched ? 19.0 : 14.0;
     final radius = isTouched ? 80.0 : 70.0;
     const shadows = [Shadow(color: Colors.black, blurRadius: 2)];
     switch (i) {
       case 0:
         return PieChartSectionData(
           color: AppColors.contentColorGreen,
           value:GETTYPE==3? controller.SUM_PAY1_BO:GETTYPE==1? controller.SUM_PAY1_BI:GETTYPE==5? controller.SUM_PAY1_BS:
           controller.SUM_PAY1_BF,
           title: GETTYPE==3? controller.formatter.format(controller.SUM_PAY1_BO).toString():
           GETTYPE==1? controller.formatter.format(controller.SUM_PAY1_BI).toString():
           GETTYPE==5? controller.formatter.format(controller.SUM_PAY1_BS).toString():
           controller.formatter.format(controller.SUM_PAY1_BF).toString(),
           radius: radius,
           titleStyle: TextStyle(
             fontSize: fontSize,
             fontWeight: FontWeight.bold,
             color: AppColors.mainTextColor1,
             shadows: shadows,
           ),
         );
       case 1:
         return PieChartSectionData(
           color: AppColors.contentColorRed,
           value:GETTYPE==3? controller.SUM_PAY3_BO:GETTYPE==1? controller.SUM_PAY3_BI:GETTYPE==5? controller.SUM_PAY3_BS:
           controller.SUM_PAY3_BF,
           title: GETTYPE==3? controller.formatter.format(controller.SUM_PAY3_BO).toString():
           GETTYPE==1? controller.formatter.format(controller.SUM_PAY3_BI).toString():
           GETTYPE==5? controller.formatter.format(controller.SUM_PAY3_BS).toString():
           controller.formatter.format(controller.SUM_PAY3_BF).toString(),
           radius: radius,
           titleStyle: TextStyle(
             fontSize: fontSize,
             fontWeight: FontWeight.bold,
             color: AppColors.mainTextColor1,
             shadows: shadows,
           ),
         );
       case 2:
         return PieChartSectionData(
           color: AppColors.contentColorSmoke,
           value:GETTYPE==3? controller.SUM_PAY8_BO:GETTYPE==1? controller.SUM_PAY8_BI:GETTYPE==5? controller.SUM_PAY8_BS:
           controller.SUM_PAY8_BF,
           title: GETTYPE==3? controller.formatter.format(controller.SUM_PAY8_BO).toString():
           GETTYPE==1? controller.formatter.format(controller.SUM_PAY8_BI).toString():
           GETTYPE==5? controller.formatter.format(controller.SUM_PAY8_BS).toString():
           controller.formatter.format(controller.SUM_PAY8_BF).toString(),
           radius: radius,
           titleStyle: TextStyle(
             fontSize: fontSize,
             fontWeight: FontWeight.bold,
             color: AppColors.mainTextColor1,
             shadows: shadows,
           ),
         );
       case 3:
         return PieChartSectionData(
           color: AppColors.contentColorBlue,
           value:GETTYPE==3? controller.SUM_PAY9_BO:GETTYPE==1? controller.SUM_PAY9_BI:GETTYPE==5? controller.SUM_PAY9_BS
               :controller.SUM_PAY9_BF,
           title: GETTYPE==3? controller.formatter.format(controller.SUM_PAY9_BO).toString():
           GETTYPE==1? controller.formatter.format(controller.SUM_PAY9_BI).toString():
           GETTYPE==5? controller.formatter.format(controller.SUM_PAY9_BS).toString():
           controller.formatter.format(controller.SUM_PAY9_BF).toString(),
           radius: radius,
           titleStyle: TextStyle(
             fontSize: fontSize,
             fontWeight: FontWeight.bold,
             color: AppColors.mainTextColor1,
             shadows: shadows,
           ),
         );
       default:
         throw Error();
     }
   });
 }

 List<PieChartSectionData> showingSections_STATE(int GETTYPE) {
   return List.generate(3, (i) {
     final isTouched = i == touchedIndex;
     final fontSize = isTouched ? 19.0 : 14.0;
     final radius = isTouched ? 80.0 : 70.0;
     const shadows = [Shadow(color: Colors.black, blurRadius: 2)];
     switch (i) {
       case 0:
         return PieChartSectionData(
           color: AppColors.contentColorGreen,
           value:GETTYPE==3? controller.SUM_STATE_BO1:GETTYPE==1? controller.SUM_STATE_BI1:GETTYPE==5? controller.SUM_STATE_BS1:
           controller.SUM_STATE_BF1,
           title: GETTYPE==3? "${controller.formatter.format(controller.SUM_STATE_BO1).toString()}":
           GETTYPE==1? controller.formatter.format(controller.SUM_STATE_BI1).toString():
           GETTYPE==5? controller.formatter.format(controller.SUM_STATE_BS1).toString():
           controller.formatter.format(controller.SUM_STATE_BF1).toString(),
           radius: radius,
           titleStyle: TextStyle(
             fontSize: fontSize,
             fontWeight: FontWeight.bold,
             color: AppColors.mainTextColor1,
             shadows: shadows,
           ),
         );
       case 1:
         return PieChartSectionData(
           color: AppColors.red,
           value:GETTYPE==3? controller.SUM_STATE_BO2:GETTYPE==1? controller.SUM_STATE_BI2:GETTYPE==5? controller.SUM_STATE_BS2:
           controller.SUM_STATE_BF2,
           title: GETTYPE==3? controller.formatter.format(controller.SUM_STATE_BO2).toString():
           GETTYPE==1? controller.formatter.format(controller.SUM_STATE_BI2).toString():
           GETTYPE==5? controller.formatter.format(controller.SUM_STATE_BS2).toString():
           controller.formatter.format(controller.SUM_STATE_BF2).toString(),
           radius: radius,
           titleStyle: TextStyle(
             fontSize: fontSize,
             fontWeight: FontWeight.bold,
             color: AppColors.mainTextColor1,
             shadows: shadows,
           ),
         );
       case 2:
         return PieChartSectionData(
           color: Colors.blueAccent,
           value:GETTYPE==3? controller.SUM_STATE_BO4:GETTYPE==1? controller.SUM_STATE_BI4:GETTYPE==5? controller.SUM_STATE_BS4:
           controller.SUM_STATE_BF4,
           title: GETTYPE==3? controller.formatter.format(controller.SUM_STATE_BO4).toString():
           GETTYPE==1? controller.formatter.format(controller.SUM_STATE_BI4).toString():
           GETTYPE==5? controller.formatter.format(controller.SUM_STATE_BS4).toString():
           controller.formatter.format(controller.SUM_STATE_BF4).toString(),
           radius: radius,
           titleStyle: TextStyle(
             fontSize: fontSize,
             fontWeight: FontWeight.bold,
             color: AppColors.mainTextColor1,
             shadows: shadows,
           ),
         );
       default:
         throw Error();
     }
   });
 }

 Widget _buildSummaryCard({
   required String title,
   required int count,
   required Color color,
   required IconData icon,
 }) {
   return Card(
     elevation: 5,
     shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
     child: Container(
       padding: const EdgeInsets.all(20),
       decoration: BoxDecoration(
         color: color.withOpacity(0.2),
         borderRadius: BorderRadius.circular(15),
       ),
       child: Row(
         mainAxisAlignment: MainAxisAlignment.spaceBetween,
         children: [
           Icon(icon, size: 40, color: color),
           Column(
             crossAxisAlignment: CrossAxisAlignment.start,
             children: [
               Text(title,
                 style: TextStyle(
                   fontSize: 15,
                   fontWeight: FontWeight.bold,
                   color: color,
                 ),
               ),
               Text('$count', style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold,color: color,),
               ),
             ],
           ),
         ],
       ),
     ),
   );
 }

 Widget buildDashboardCard({
   required IconData icon,
   required String text,
   required String value,
   required Color iconColor,
 }) {
   return Container(
     padding: EdgeInsets.all(12),
     decoration: BoxDecoration(
       borderRadius: BorderRadius.circular(12),
       border: Border.all(color: Colors.grey, width: 1),
     ),
     child: Row(
       mainAxisAlignment: MainAxisAlignment.spaceBetween,
       children: [
         Row(
           children: [
             CircleAvatar(
               backgroundColor: iconColor.withOpacity(0.2),
               child: Icon(icon, color: iconColor),
             ),
             SizedBox(width: 10),
             Column(
               children: [
                 Text(
                   text,
                   style: TextStyle(fontSize: 13, fontWeight: FontWeight.bold),
                 ),
                 Text(
                   value,
                   style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                 ),
               ],
             ),
           ],
         ),
       ],
     ),
   );
 }

 Widget buildDashboard({
   required IconData icon,
   required String text,
   required String value,
   required Color iconColor,
 }) {
   return Container(
     padding: EdgeInsets.all(12),
     decoration: BoxDecoration(
       borderRadius: BorderRadius.circular(12),
       border: Border.all(color: Colors.grey, width: 1),
     ),
     child: Column(
       mainAxisAlignment: MainAxisAlignment.center, // توسيط عمودي
       crossAxisAlignment: CrossAxisAlignment.center, // توسيط أفقي
       children: [
         Row(
           mainAxisAlignment: MainAxisAlignment.center, // توسيط أفقي للعناصر داخل الـ Row
           children: [
             CircleAvatar(
               backgroundColor: iconColor.withOpacity(0.2),
               child: Icon(icon, color: iconColor),
             ),
             SizedBox(width: 10),
             Text(
               value,
               style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
             ),
           ],
         ),
         SizedBox(height: 10), // مسافة بين السطر الأول والنص السفلي
         Text(
           text,
           textAlign: TextAlign.center, // تأكد من توسيط النص
           style: TextStyle(fontSize: 13, fontWeight: FontWeight.bold),
         ),
       ],
     ),
   );
 }


 Widget _buildDashboardItem(String title, String value, IconData icon, Color color) {
   return Container(
     decoration: BoxDecoration(
       color: Colors.white,
       borderRadius: BorderRadius.circular(12),
       boxShadow: [
         BoxShadow(
           color: Colors.grey.withOpacity(0.3),
           blurRadius: 5,
           spreadRadius: 2,
         ),
       ],
     ),
     padding: const EdgeInsets.all(15),
     child: Column(
       mainAxisAlignment: MainAxisAlignment.center,
       children: [
         CircleAvatar(
           backgroundColor: color.withOpacity(0.1),
           child: Icon(icon, color: color),
         ),
         const SizedBox(height: 10),
         Text(title, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
         const SizedBox(height: 5),
         Text(value, style: TextStyle(fontSize: 18, color: color, fontWeight: FontWeight.bold)),
       ],
     ),
   );
 }

 Widget _buildDrawerItem(IconData icon, String title) {
   return ListTile(
     leading: Icon(icon, color: Colors.teal),
     title: Text(title, style: const TextStyle(fontSize: 16)),
     onTap: () {},
   );
 }
}

class StunningTopItemsChart extends StatelessWidget {
  final List<Bil_Mov_D_Local> items;

  const StunningTopItemsChart({super.key, required this.items});

  // 1. دالة الألوان حسب الفهرس
  Color _getColor(int index) {
    final colors = [
      Colors.blue.shade700,
      Colors.green.shade700,
      Colors.orange.shade700,
      Colors.purple.shade700,
      Colors.red.shade700,
    ];
    return colors[index % colors.length];
  }

  @override
  Widget build(BuildContext context) {
    return SfCartesianChart(
      margin: const EdgeInsets.all(20),
      primaryXAxis: CategoryAxis(
        isInversed: true, // 2. عكس الترتيب
        labelRotation: -45,
        labelStyle: TextStyle(
          fontFamily: 'Hacen',
          fontSize: 14,
          color: Colors.grey[800],
        ),
        majorGridLines: const MajorGridLines(width: 0),
      ),
      tooltipBehavior: TooltipBehavior(
        enable: true,
        elevation: 5,
        color: Colors.white,
        borderColor: Colors.blue.shade300,
        borderWidth: 2,
        builder: (data, _, __, pointIndex, ___) {
          final item = items[pointIndex];
          return _buildCustomTooltip(item);
        },
      ),
      series: <BarSeries<Bil_Mov_D_Local, String>>[
        BarSeries<Bil_Mov_D_Local, String>(
          dataSource: items,
          xValueMapper: (item, _) => item.MINA_D,
          yValueMapper: (item, _) => item.BMDAMT,
          pointColorMapper: (item, index) => _getColor(index), // 3. تلوين حسب الفهرس
          width: 0.7,
          borderRadius: BorderRadius.circular(8),
          dataLabelSettings: DataLabelSettings(
            isVisible: true,
            labelAlignment: ChartDataLabelAlignment.top,
            textStyle: TextStyle(
              fontFamily: 'Hacen',
              fontSize: 14,
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildCustomTooltip(Bil_Mov_D_Local item) {
    return Container(
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [Colors.blue.shade100, Colors.white],
        ),
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.3),
            blurRadius: 10,
            spreadRadius: 3,
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('🔥 ${item.MINA_D}',
              style: TextStyle(fontFamily: 'Hacen', fontSize: 16, fontWeight: FontWeight.bold)),
          const Divider(color: Colors.blueGrey),
          _buildTooltipRow('📦 المجموعة', item.MGNO.toString()),
          _buildTooltipRow('🔢 الرمز', item.MINO.toString()),
          _buildTooltipRow('💰 القيمة', NumberFormat('#,###').format(item.BMDAMT)),
        ],
      ),
    );
  }

  Widget _buildTooltipRow(String title, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        children: [
          Text(title, style: TextStyle(fontFamily: 'Hacen', color: Colors.grey[700])),
          const Spacer(),
          Text(value, style: TextStyle(fontFamily: 'Hacen', fontWeight: FontWeight.bold)),
        ],
      ),
    );
  }
}

class StunningTopCusChart extends StatelessWidget {
  final List<Bil_Mov_M_Local> items;

  const StunningTopCusChart({super.key, required this.items});

  // 1. دالة الألوان حسب الفهرس
  Color _getColor(int index) {
    final colors = [
      Colors.blue.shade700,
      Colors.green.shade700,
      Colors.orange.shade700,
      Colors.purple.shade700,
      Colors.red.shade700,
    ];
    return colors[index % colors.length];
  }

  @override
  Widget build(BuildContext context) {
    return SfCartesianChart(
      margin: const EdgeInsets.all(20),
      primaryXAxis: CategoryAxis(
        isInversed: true, // 2. عكس الترتيب
        labelRotation: -45,
        labelStyle: TextStyle(
          fontFamily: 'Hacen',
          fontSize: 14,
          color: Colors.grey[800],
        ),
        majorGridLines: const MajorGridLines(width: 0),
      ),
      tooltipBehavior: TooltipBehavior(
        enable: true,
        elevation: 5,
        color: Colors.white,
        borderColor: Colors.blue.shade300,
        borderWidth: 2,
        builder: (data, _, __, pointIndex, ___) {
          final item = items[pointIndex];
          return _buildCustomTooltip(item);
        },
      ),
      series: <BarSeries<Bil_Mov_M_Local, String>>[
        BarSeries<Bil_Mov_M_Local, String>(
          dataSource: items,
          xValueMapper: (item, _) => item.BMMNA,
          yValueMapper: (item, _) => item.BMMMT,
          pointColorMapper: (item, index) => _getColor(index), // 3. تلوين حسب الفهرس
          width: 0.7,
          borderRadius: BorderRadius.circular(8),
          dataLabelSettings: DataLabelSettings(
            isVisible: true,
            labelAlignment: ChartDataLabelAlignment.top,
            textStyle: TextStyle(
              fontFamily: 'Hacen',
              fontSize: 14,
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildCustomTooltip(Bil_Mov_M_Local item) {
    return Container(
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [Colors.blue.shade100, Colors.white],
        ),
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.3),
            blurRadius: 10,
            spreadRadius: 3,
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('🔥 ${item.BMMNA}', style: TextStyle(fontFamily: 'Hacen', fontSize: 16, fontWeight: FontWeight.bold)),
          const Divider(color: Colors.blueGrey),
          _buildTooltipRow('📦 الحساب', item.AANO.toString()),
          _buildTooltipRow('🔢 الرقم', item.BCID.toString()),
          _buildTooltipRow('💰 المبلغ', NumberFormat('#,###').format(item.BMMMT)),
        ],
      ),
    );
  }

  Widget _buildTooltipRow(String title, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        children: [
          Text(title, style: TextStyle(fontFamily: 'Hacen', color: Colors.grey[700])),
          const Spacer(),
          Text(value, style: TextStyle(fontFamily: 'Hacen', fontWeight: FontWeight.bold)),
        ],
      ),
    );
  }
}



class SalesBarChart extends StatelessWidget {
  final List<Bil_Mov_M_Local> data;

  const SalesBarChart({Key? key, required this.data}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double? maxY=0;
     maxY = data.isNotEmpty
        ? data.map((e) => e.NET).reduce((a, b) => a! > b! ? a : b)
        : 100;
   // maxY *= 1.2;

    return AspectRatio(
      aspectRatio: 1.5,
      child: BarChart(
        BarChartData(
          alignment: BarChartAlignment.spaceAround,
          maxY: maxY,
          barTouchData: BarTouchData(
            enabled: true,
            touchTooltipData: BarTouchTooltipData(
            //  tooltipBgColor: Colors.blueGrey,
              getTooltipItem: (group, groupIndex, rod, rodIndex) {
                String branch = data[group.x.toInt()].BINA_D.toString();
                return BarTooltipItem(
                  "$branch\n",
                  const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 14,
                  ),
                  children: <TextSpan>[
                    TextSpan(
                      text: rod.toY.toStringAsFixed(2),
                      style: const TextStyle(
                        color: Colors.yellow,
                        fontSize: 12,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                );
              },
            ),
          ),
          titlesData: FlTitlesData(
            show: true,
            rightTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
            topTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
            bottomTitles: AxisTitles(
              sideTitles: SideTitles(
                showTitles: true,
                reservedSize: 40,
                getTitlesWidget: (double value, TitleMeta meta) {
                  int index = value.toInt();
                  if (index < 0 || index >= data.length) return Container();
                  return SideTitleWidget(
                    meta: meta,
                    child: Text(
                      data[index].BINA_D.toString(),
                      style: const TextStyle(fontSize: 10),
                      textAlign: TextAlign.center,
                    ),
                  );
                },
              ),
            ),
            leftTitles: AxisTitles(
              sideTitles: SideTitles(
                showTitles: true,
                interval: maxY! / 5,
                getTitlesWidget: (double value, TitleMeta meta) {
                  return Text(
                    value.toInt().toString(),
                    style: const TextStyle(fontSize: 10),
                  );
                },
              ),
            ),
          ),
          borderData: FlBorderData(show: false),
          barGroups: data.asMap().entries.map((entry) {
            int index = entry.key;
            Bil_Mov_M_Local sales = entry.value;
            return BarChartGroupData(
              x: index,
              barRods: [
                BarChartRodData(
                  toY: sales.NET!,
                  color: Colors.lightBlue,
                  width: 16,
                  borderRadius: BorderRadius.circular(4),
                ),
              ],
            );
          }).toList(),
        ),
      ),
    );
  }
}

