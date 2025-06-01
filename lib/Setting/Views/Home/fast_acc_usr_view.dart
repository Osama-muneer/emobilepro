import 'package:flutter/services.dart';
import 'package:lucide_icons/lucide_icons.dart';
import '../../../Setting/controllers/home_controller.dart';
import '../../../Widgets/colors.dart';
import '../../../database/setting_db.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../Widgets/theme_helper.dart';


class FAS_ACC_USR_View extends StatefulWidget {
  @override
  State<FAS_ACC_USR_View> createState() => _FAS_ACC_USR_ViewState();
}

class _FAS_ACC_USR_ViewState extends State<FAS_ACC_USR_View> {
  final HomeController controller = Get.find();
  bool isSelected_l=false;

  @override
  void initState() {
    super.initState();
    setState(() {
      controller.GET_SYS_SCR_FAS_P2();
      //  controller.update();
      controller.GET_SYS_SCR_FAS_P();
      // controller.update();
      controller.FAUST=1;
      controller.SSID=0;
      //  main();
    });
  }

  Future<bool> onWillPop() async {
    final shouldPop;
    if (controller.FAS_ACC_USR2.length == 4 || controller.FAS_ACC_USR2.isEmpty) {
      Navigator.of(context).pop(false);
      controller.GET_SYS_SCR_FAS_P2();
      controller.update();
      shouldPop = await Get.toNamed('/Home');
    } else {
      shouldPop = await Get.defaultDialog(
        title: 'StringMestitle'.tr,
        middleText: 'StringSCR_FAS_ACC_CHK'.tr,
        backgroundColor: Colors.white,
        radius: 40,
        textCancel: 'StringOK'.tr,
        cancelTextColor: Colors.blue,
      );
    }
    return shouldPop ?? false;
  }
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return  WillPopScope(
      onWillPop: onWillPop,
      child: Scaffold(
        appBar: ThemeHelper().MainAppBar('StringSCR_FAS_ACC'.tr),
        body: GetBuilder<HomeController>(
            init: HomeController(),
            builder: ((value) =>  SingleChildScrollView(
                  child:  Column(
                    children: [
                     Text('StringSCR_SYS'.tr,style:
                     ThemeHelper().buildTextStyle(context, AppColors.MainColor,'L')),
                      Container(
                      //  height: 345,
                        child: ListView.builder(
                            itemCount: controller.FAS_ACC_USR.length,
                            shrinkWrap: true,
                            itemBuilder: (BuildContext context, int index) {
                              return ListTile(
                                leading: CircleAvatar(
                                  backgroundColor: Colors.red[700],
                                  child: Icon(Icons.screenshot_monitor_sharp,
                                    color: Colors.white,),
                                ),
                                title: Text(controller.FAS_ACC_USR[index].SSDA_D.toString(),
                                  style: ThemeHelper().buildTextStyle(context, AppColors.black,'M'),),
                                trailing: controller.FAS_ACC_USR[index].FAUST2==1 ?Icon(Icons.check_circle,color: Colors.red[700]):
                                Icon(Icons.check_circle_outline,color: Colors.grey,),
                                onTap: () async {
                                  controller.SSID=controller.FAS_ACC_USR[index].SSID;
                                  if(controller.FAS_ACC_USR[index].FAUST2==1){
                                    UpdateFAS_ACC_USR(controller.FAS_ACC_USR[index].SSID!,2);
                                    await Future.delayed(const Duration(milliseconds: 100));
                                    controller.update();
                                    controller.GET_SYS_SCR_FAS_P();
                                    controller.update();
                                  }else{
                                    UpdateFAS_ACC_USR(controller.FAS_ACC_USR[index].SSID!,1);
                                    await Future.delayed(const Duration(milliseconds: 100));
                                    controller.update();
                                    controller.GET_SYS_SCR_FAS_P();
                                    controller.update();
                                  }
                                  //controller.SYS_SCR[index].SSST2==1?isSelected=true?isSelected=false;
                                },
                              );
                            }),
                      ),
                      controller.FAS_ACC_USR2.length>=4?Container():MaterialButton(
                        onPressed: () async {
                          UpdateFAS_ACC_USR_FAUST(controller.SSID!,1,2,controller.FAS_ACC_USR2.length+1);
                          await Future.delayed(const Duration(milliseconds: 100));
                          controller.GET_SYS_SCR_FAS_P2();
                          controller.update();
                          controller.GET_SYS_SCR_FAS_P();
                          controller.FAUST=1;
                          controller.update();
                        },
                        child: Container(
                          height: height * 0.05,
                          width: width * 0.9,
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                              color: AppColors.MainColor,
                              borderRadius: BorderRadius.circular(5 * width)),
                          child: Text(
                            'StringAdd'.tr,
                            style: ThemeHelper().buildTextStyle(context, AppColors.textColor,'L')
                          ),
                        ),
                      ),
                      Divider(height: 1,color: Colors.black,),
                      Text('StringSCR_FAS'.tr,style:
                      ThemeHelper().buildTextStyle(context, AppColors.MainColor,'L')),
                      // Row(
                      //   mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      //   children: [
                      //     Text('StringSCR_FAS'.tr,style: TextStyle(fontSize: 16.sp, color: AppColors.MainColor, fontWeight: FontWeight.bold)),
                      //     IconButton(
                      //       icon: const Icon(Icons.upload),
                      //       tooltip: 'ترتيب الى اعلى',
                      //       onPressed: () {
                      //
                      //       },
                      //     ),
                      //     IconButton(
                      //       icon: const Icon(Icons.download),
                      //       tooltip: 'ترتيب الى اسفل',
                      //       onPressed: () {
                      //       },
                      //     )
                      //   ],
                      // ),
                      Container(
                       // height: 215,
                        child: ListView.builder(
                           shrinkWrap: true,
                            itemCount: controller.FAS_ACC_USR2.length,
                            itemBuilder: (BuildContext context, int index) {
                              return   ListTile(
                                leading: CircleAvatar(
                                  backgroundColor: Colors.red[700],
                                  child: Icon(Icons.screenshot_monitor_sharp,
                                    color: Colors.white,),
                                ),
                                title: Text(controller.FAS_ACC_USR2[index].SSDA_D.toString(),
                                  style: ThemeHelper().buildTextStyle(context, AppColors.black,'M')),
                                trailing: controller.FAS_ACC_USR2[index].FAUST2==1 ?Icon(Icons.check_circle,color: Colors.red[700]):
                                Icon(Icons.check_circle_outline,color: Colors.grey,),
                                onTap: () async {
                                  controller.FAUST=controller.FAS_ACC_USR2[index].FAUST2;
                                  controller.SSID=controller.FAS_ACC_USR2[index].SSID;
                                  if(controller.FAS_ACC_USR2[index].FAUST2==1){
                                    UpdateFAS_ACC_USR_Single(controller.FAS_ACC_USR2[index].SSID!,2);
                                    await Future.delayed(const Duration(milliseconds: 100));
                                    controller.update();
                                    controller.GET_SYS_SCR_FAS_P2();
                                    controller.update();
                                  }else{
                                    UpdateFAS_ACC_USR_Single(controller.FAS_ACC_USR2[index].SSID!,1);
                                    await Future.delayed(const Duration(milliseconds: 100));
                                    controller.update();
                                    controller.GET_SYS_SCR_FAS_P2();
                                    controller.update();
                                  }
                                  //controller.SYS_SCR[index].SSST2==1?isSelected=true?isSelected=false;
                                },
                              );
                            }),
                      ),
                      controller.FAUST==2 ?
                      MaterialButton(
                        onPressed: () async {
                          UpdateFAS_ACC_USR_FAUST(controller.SSID!,2,1,0);
                          await Future.delayed(const Duration(milliseconds: 100));
                          controller.GET_SYS_SCR_FAS_P2();
                          controller.update();
                          controller.GET_SYS_SCR_FAS_P();
                          controller.FAUST=1;
                          controller.update();
                        },
                        child: Container(
                          height: height * 0.05,
                          width: width * 0.9,
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                              color: AppColors.MainColor,
                              borderRadius:
                              BorderRadius.circular(5 * width)),
                          child: Text(
                            'StringDeleteAppBar'.tr,
                            style:
                            ThemeHelper().buildTextStyle(context, AppColors.textColor,'L')
                          ),
                        ),
                      )
                          :Container(),
                    ],
                  ),
                ))),
      ),
    );
  }

}

class FAS_ACC_USR_View7 extends StatelessWidget {
  final List<Map<String, dynamic>> documents = [
    {"title": "عرض سعر ترويجي", "date": "05/02/2025", "stage": "9", "status": false},
    {"title": "عرض سعر ترويجي", "date": "05/02/2025", "stage": "10", "status": true},
    {"title": "عرض سعر ترويجي", "date": "04/02/2025", "stage": "5", "status": false},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("الوثائق")),
      body: ListView.builder(
        itemCount: documents.length,
        itemBuilder: (context, index) {
          final doc = documents[index];
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
            child: Stack(
              clipBehavior: Clip.none,
              children: [
                // البطاقة الرئيسية مع ExpansionTile
                Card(
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
                  elevation: 4,
                  child: ExpansionTile(
                    tilePadding: EdgeInsets.all(12),
                    title: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(doc["title"], style: TextStyle(fontWeight: FontWeight.bold)),
                      ],
                    ),
                    children: [
                      Padding(
                        padding: EdgeInsets.all(12),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text("تاريخ السند: ${doc['date']}", style: TextStyle(fontSize: 16)),
                            SizedBox(height: 5),
                            Text("المرحلة: رقم ${doc['stage']}", style: TextStyle(fontSize: 16)),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                // الشريط العلوي لحالة الاعتماد
                Positioned(
                  top: 0,
                  right: 0,
                  child: Transform.rotate(
                    angle: 0.0, // لجعل الشريط مائلًا
                    child: Container(
                      padding: EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                      decoration: BoxDecoration(
                        color: doc["status"] ? Colors.green : Colors.red,
                        borderRadius: BorderRadius.only(topRight: Radius.circular(10)),
                      ),
                      child: Text(
                        doc["status"] ? "معتمد" : "غير معتمد",
                        style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}

class FAS_ACC_USR_View4 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("الوثائق")),
      body: ListView.builder(
        itemCount: 3, // عدد العناصر
        itemBuilder: (context, index) {
          return Stack(
            children: [

              // الشريط العلوي لحالة المستند
              Positioned(
                top: 0,
                left: 0,
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                  decoration: BoxDecoration(
                    color: index % 2 == 0 ? Colors.green : Colors.red, // معتمد أو غير معتمد
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(10),
                      bottomRight: Radius.circular(10),
                    ),
                  ),
                  child: Text(
                    index % 2 == 0 ? "معتمد" : "غير معتمد",
                    style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                  ),
                ),
              ),

              // ExpansionTile (المحتوى الرئيسي)
              Padding(
                padding: const EdgeInsets.only(top: 15), // حتى لا يختفي تحت الشريط
                child: Card(
                  margin: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                  child: ExpansionTile(
                    title: Text("عرض سعر أوجيلي"),
                    children: [
                      ListTile(
                        title: Text("تاريخ السند: 05/02/2025"),
                        subtitle: Text("المرحلة: رقم ${index + 9}"),
                      ),
                    ],
                  ),
                ),
              ),

              // الشريط العلوي لحالة المستند
              Positioned(
                top: 0,
                left: 0,
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                  decoration: BoxDecoration(
                    color: index % 2 == 0 ? Colors.green : Colors.red, // معتمد أو غير معتمد
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(10),
                      bottomRight: Radius.circular(10),
                    ),
                  ),
                  child: Text(
                    index % 2 == 0 ? "معتمد" : "غير معتمد",
                    style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}

class FAS_ACC_USR_View9 extends StatelessWidget {
  void _showBottomSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (context) {
        return Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                'البيانات الأساسية',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.teal),
              ),
              SizedBox(height: 16),
              // حقلين للفرع جنب بعض
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(child: _buildTextField('الفرع من', '1',context)),
                  SizedBox(width: 10),
                  Expanded(child: _buildTextField('الفرع إلى', '2',context)),
                ],
              ),
              SizedBox(height: 16),
              _buildTextField('التاريخ من', '31/12/2025',context, isDate: true),
              SizedBox(height: 16),
              _buildTextField('التاريخ إلى', '01/01/2026',context, isDate: true),
              SizedBox(height: 16),
              _buildTextField('رقم الوثيقة', '',context),
              SizedBox(height: 16),
              _buildTextField('المستخدم', '',context),
              SizedBox(height: 16),
              _buildDropdown('طريقة الدفع', ['نقدي', 'بطاقة ائتمان']),
              SizedBox(height: 20),

              // تصميم الأزرار
              ElevatedButton(
                onPressed: () {},
                child: Text('تطبيق'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.teal,
                  padding: EdgeInsets.symmetric(vertical: 14),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  shadowColor: Colors.teal.withOpacity(0.5),
                  elevation: 5,
                ),
              ),
              SizedBox(height: 10),
              OutlinedButton(
                onPressed: () {},
                child: Text('إعادة التصفية', style: TextStyle(color: Colors.teal)),
                style: OutlinedButton.styleFrom(
                  side: BorderSide(color: Colors.teal),
                  padding: EdgeInsets.symmetric(vertical: 14),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildTextField(String label, String hint,BuildContext context, {bool isDate = false}) {
    return TextField(
      decoration: InputDecoration(
        labelText: label,
        hintText: hint,
        border: OutlineInputBorder(),
        contentPadding: EdgeInsets.symmetric(vertical: 12, horizontal: 16),
      ),
      readOnly: isDate,
      onTap: isDate
          ? () {
        // تنفيذ اختيار التاريخ هنا
        _selectDate(context);
      }
          : null,
    );
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1900),
      lastDate: DateTime(2101),
    );
    // إضافة الكود لاختيار التاريخ هنا
  }

  Widget _buildDropdown(String label, List<String> items) {
    String? selectedItem;

    return DropdownButtonFormField<String>(
      decoration: InputDecoration(
        labelText: label,
        border: OutlineInputBorder(),
      ),
      value: selectedItem,
      items: items.map((String item) {
        return DropdownMenuItem<String>(
          value: item,
          child: Text(item),
        );
      }).toList(),
      onChanged: (String? newValue) {
        selectedItem = newValue;
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('الصفحة الرئيسية'),
        backgroundColor: Colors.teal,
      ),
      body: Center(
        child: ElevatedButton(
          onPressed: () => _showBottomSheet(context),
          child: Text('إظهار الشاشة الجانبية'),
          style: ElevatedButton.styleFrom(
            padding: EdgeInsets.symmetric(vertical: 14, horizontal: 20), backgroundColor: Colors.teal,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
          ),
        ),
      ),
    );
  }
}

class FAS_ACC_USR_View33 extends StatefulWidget {
  const FAS_ACC_USR_View33({super.key});

  @override
  State<FAS_ACC_USR_View33> createState() => _FilterScreenState();
}

class _FilterScreenState extends State<FAS_ACC_USR_View33> {
  final _formKey = GlobalKey<FormState>();
  String? _selectedBranchFrom;
  String? _selectedBranchTo;
  DateTime _fromDate = DateTime(2025, 1, 1);
  DateTime _toDate = DateTime(2025, 12, 31);

  showFilterSheet(BuildContext  context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (context) => Directionality(
        textDirection: TextDirection.rtl,
        child: Container(
          padding: const EdgeInsets.all(16),
          constraints: BoxConstraints(
            maxHeight: MediaQuery.of(context).size.height * 0.9,
          ),
          child: _buildFilterContent(context),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('تصفية'),
          actions: [
            IconButton(
              icon: const Icon(Icons.filter_list),
              onPressed: () => showFilterSheet(context),
            ),
          ],
        ),
        body: const Center(child: Text('المحتوى الرئيسي')),
      ),
    );
  }

  Widget _buildFilterContent(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.red.withOpacity(0.1),
            blurRadius: 15,
            spreadRadius: 2,
          ),
        ],
      ),
      padding: const EdgeInsets.all(20),
      child: Form(
        key: _formKey,
        child: ListView(
          shrinkWrap: true,
          children: [
            Center(
              child: Text(
                'البيانات الأساسية',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.red[800],
                ),
              ),
            ),
            const SizedBox(height: 25),

            // الفرع
            _buildSectionHeader('الفرع'),
            _buildDoubleInputRow(
              _buildDropdown('من', _selectedBranchFrom, (v) => _selectedBranchFrom = v),
              _buildDropdown('الى', _selectedBranchTo, (v) => _selectedBranchTo = v),
            ),

            // التاريخ
            _buildSectionHeader('التاريخ'),
            _buildDoubleInputRow(
              _buildDateField('من', _fromDate, context),
              _buildDateField('الى', _toDate, context),
            ),

            // رقم الوثيقة
            _buildSectionHeader('رقم الوثيقة'),
            _buildDoubleInputRow(
              _buildNumberField('من', context),
              _buildNumberField('الى', context),
            ),

            // المستخدم
            _buildSectionHeader('المستخدم'),
            _buildDoubleInputRow(
              _buildDropdown('من', null, (v) {}),
              _buildDropdown('الى', null, (v) {}),
            ),

            // طريقة الدفع والعملة
            _buildSectionHeader('طريقة الدفع'),
            _buildDropdown('اختر طريقة الدفع', null, (v) {}),
            const SizedBox(height: 15),
            _buildSectionHeader('العملة'),
            _buildDropdown('اختر العملة', null, (v) {}),

            // الأزرار
            const SizedBox(height: 30),
            Row(
              children: [
                Expanded(
                  child: OutlinedButton.icon(
                    icon: Icon(Icons.refresh, color: Colors.red[800]),
                    label: Text('إعادة ضبط',
                        style: TextStyle(color: Colors.red[800])),
                    style: OutlinedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(vertical: 15),
                      side: BorderSide(color: Colors.red[800]!),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    onPressed: _resetFilters,
                  ),
                ),
                const SizedBox(width: 15),
                Expanded(
                  child: ElevatedButton.icon(
                    icon: const Icon(Icons.check, color: Colors.white),
                    label: const Text('تطبيق التصفية',
                        style: TextStyle(color: Colors.white)),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.red[800],
                      padding: const EdgeInsets.symmetric(vertical: 15),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      elevation: 3,
                    ),
                    onPressed: () => _applyFilters(context),
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }

  Widget _buildDoubleInputRow(Widget first, Widget second) {
    return Row(
      children: [
        Expanded(child: first),
        const SizedBox(width: 15),
        Expanded(child: second),
      ],
    );
  }

  Widget _buildSectionHeader(String title) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12),
      child: Text(title,
          style: TextStyle(
            fontSize: 16,
            color: Colors.red[800],
            fontWeight: FontWeight.bold,
          )),
    );
  }

  Widget _buildDropdown(String hint, String? value, Function(String?) onChanged) {
    return DropdownButtonFormField<String>(
      decoration: InputDecoration(
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
        contentPadding: const EdgeInsets.symmetric(horizontal: 12),
        hintText: hint,
      ),
      value: value,
      items: const [
        DropdownMenuItem(value: '1', child: Text('الخيار ١')),
        DropdownMenuItem(value: '2', child: Text('الخيار ٢')),
      ],
      onChanged: (v) => onChanged(v),
    );
  }

  Widget _buildDateField(String label, DateTime date,BuildContext context) {
    return TextFormField(
      decoration: InputDecoration(
        labelText: label,
        border: const OutlineInputBorder(),
        suffixIcon: const Icon(Icons.calendar_today),
      ),
      readOnly: true,
      controller: TextEditingController(text: '${date.day}/${date.month}/${date.year}'),
      onTap: () async {
        final picked = await showDatePicker(
          context: context,
          initialDate: date,
          firstDate: DateTime(2020),
          lastDate: DateTime(2030),
        );
        if (picked != null) {
          setState(() => date = picked);
        }
      },
    );
  }

  Widget _buildNumberField(String label,BuildContext context) {
    return TextFormField(
      decoration: InputDecoration(
        labelText: label,
        border: const OutlineInputBorder(),
      ),
      keyboardType: TextInputType.number,
      inputFormatters: [FilteringTextInputFormatter.digitsOnly],
    );
  }

  void _resetFilters() {
    _formKey.currentState?.reset();
    setState(() {
      _selectedBranchFrom = null;
      _selectedBranchTo = null;
      _fromDate = DateTime(2025, 1, 1);
      _toDate = DateTime(2025, 12, 31);
    });
  }

  void _applyFilters(BuildContext context) {
    if (_formKey.currentState!.validate()) {
      Navigator.pop(context);
      // تطبيق الفلاتر هنا
    }
  }
}

class FAS_ACC_USR_View8 extends StatefulWidget {
  const FAS_ACC_USR_View8({Key? key}) : super(key: key);

  @override
  State<FAS_ACC_USR_View> createState() => _SalesInvoiceHeaderState();
}

class _SalesInvoiceHeaderState extends State<FAS_ACC_USR_View> {
  @override
  void initState() {
    super.initState();
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.landscapeLeft,
      DeviceOrientation.landscapeRight,
    ]);
  }

  @override
  void dispose() {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
     body:  Container(
        padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
        color: Colors.white,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                Container(
                  width: 250,
                  height: 40,
                  decoration: BoxDecoration(
                    color: Colors.grey[200],
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Row(
                    children: [
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 8.0),
                        child: Icon(Icons.search, color: Colors.blue),
                      ),
                      Expanded(
                        child: TextField(
                          decoration: InputDecoration(
                            hintText: 'ادخل اسم الصنف',
                            border: InputBorder.none,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                IconButton(
                  icon: Icon(Icons.grid_on, color: Colors.blueGrey),
                  onPressed: () {},
                ),
                IconButton(
                  icon: Icon(Icons.grid_view, color: Colors.blueGrey),
                  onPressed: () {},
                ),
                IconButton(
                  icon: Icon(Icons.list, color: Colors.blueGrey),
                  onPressed: () {},
                ),
              ],
            ),
            Row(
              children: [
                Container(
                  padding: EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: Colors.blue[100],
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Text(
                    '1',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.blue),
                  ),
                ),
                SizedBox(width: 8),
                Text(
                  'إزالة الكل',
                  style: TextStyle(fontSize: 18, color: Colors.red, fontWeight: FontWeight.bold),
                ),
                SizedBox(width: 16),
                Text(
                  '425 رقم الفاتورة / المبيعات',
                  style: TextStyle(fontSize: 16, color: Colors.grey[600]),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

// نموذج للتصنيف
class CategoryModel {
  final IconData icon;
  final String label;
  CategoryModel({required this.icon, required this.label});
}

// نموذج للصنف
class ItemModel {
  final String name;
  final String subName;
  final double price;
  ItemModel({required this.name, required this.subName, required this.price});
}

class FAS_ACC_USR_View34 extends StatelessWidget {


  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
      color: Colors.white,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              Icon(Icons.receipt_long, color: Colors.green, size: 28),
              SizedBox(width: 8),
              Text(
                'فاتورة مبيعات',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.green,
                ),
              ),
              SizedBox(width: 16),
              Text(
                '425 رقم الفاتورة / المبيعات',
                style: TextStyle(fontSize: 16, color: Colors.grey[600]),
              ),
            ],
          ),
          Row(
            children: [
              IconButton(
                icon: Icon(LucideIcons.grid, color: Colors.blueGrey),
                onPressed: () {},
              ),
              IconButton(
                icon: Icon(LucideIcons.list, color: Colors.blueGrey),
                onPressed: () {},
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                decoration: BoxDecoration(
                  color: Colors.redAccent,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Text(
                  'إزالة الكل',
                  style: TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
