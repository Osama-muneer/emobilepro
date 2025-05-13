import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../Setting/models/bra_inf.dart';
import '../../../Setting/models/pay_kin.dart';
import '../../../Setting/models/sys_cur.dart';
import '../../../Widgets/config.dart';
import '../../../Widgets/dropdown.dart';
import '../../../Widgets/theme_helper.dart';
import '../../../database/invoices_db.dart';
import '../../../database/setting_db.dart';
import '../../Controllers/sale_invoices_controller.dart';

class Fliter_Sales {
  final Sale_Invoices_Controller controller = Get.find();

  showFilterSheet(BuildContext  context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (context) => Container(
        padding: const EdgeInsets.all(10),
        constraints: BoxConstraints(
          maxHeight: MediaQuery.of(context).size.height * 0.9,
        ),
        child: buildFilterContent(context),
      ),
    );
  }

  Widget buildFilterContent(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    return GetBuilder<Sale_Invoices_Controller>(
        init: Sale_Invoices_Controller(),
        builder: ((controller) =>
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: ListView(
                shrinkWrap: true,
                children: [
                  SizedBox(height: 0.01 * height),
                  _buildDoubleInputRow(
                    DropdownBra_InfBuilder_f(context),
                    DropdownBra_Inf_ToBuilder(context),context,
                  ),
                  SizedBox(height: 0.02 * height),
                  // التاريخ
                  // _buildSectionHeader('التاريخ'),
                  _buildDoubleInputRow(
                    _buildDateField('StringFROM'.tr, controller.FromDaysController, context,
                            () => controller.selectDateFromDays_F(context)),
                    _buildDateField('StringBPID_TlableText'.tr,  controller.ToDaysController, context,
                            () => controller.selectDateToDays(context)),context,
                  ),
                  SizedBox(height: 0.02 * height),
                  // // رقم الوثيقة
                  // _buildSectionHeader('رقم الوثيقة'),
                  // _buildDoubleInputRow(
                  //   _buildNumberField('من', context),
                  //   _buildNumberField('الى', context),
                  // ),

                  // طريقة الدفع والعملة
                  Row(
                    children: [
                      Expanded(
                        child: Container(
                            margin: EdgeInsets.only(left: 0.02 * height),
                            decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular( 0.02 * height)),
                            child:  DropdownSYS_CUR_SBuilder(context)
                        ),
                      ),
                      SizedBox(height:0.02 * height),
                      Expanded(
                        child: Container(
                            margin: EdgeInsets.only(right: 0.02 * height),
                            decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular( 0.02 * height)),
                            child:   DropdownPAY_KIN_SBuilder()
                        ),
                      ),
                    ],
                  ),

                  // _buildSectionHeader('طريقة الدفع'),
                  // DropdownPAY_KIN_SBuilder(),
                  // const SizedBox(height: 2),
                  // _buildSectionHeader('العملة'),
                  // DropdownSYS_CUR_SBuilder(context),

                  // الأزرار
                  SizedBox(height: 0.02 * height),
                  Row(
                    children: [
                      Expanded(
                        child: OutlinedButton.icon(
                          icon: Icon(Icons.refresh, color: Colors.red[800]),
                          label: Text('StringReset'.tr,
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
                      SizedBox(width: 0.04 * height),
                      Expanded(
                        child: ElevatedButton.icon(
                          icon: const Icon(Icons.check, color: Colors.white),
                          label: Text('StringSEARCH'.tr,
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
                  ),
                  SizedBox(height: 0.02 * height),
                  OutlinedButton.icon(
                    // icon: Icon(Icons.refresh, color: Colors.red[800]),
                    label: Text('StringShowAll'.tr,
                        style: TextStyle(color: Colors.red[800])),
                    style: OutlinedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(vertical: 15),
                      side: BorderSide(color: Colors.red[800]!),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    onPressed: () async {
                      controller.TYPE_SER=1;
                      await controller.GET_BIL_MOV_M_P("DateNow");
                      await controller.get_RETURN_SALE("DateNow");
                    },
                  ),
                  // ElevatedButton.icon(
                  //  // icon: const Icon(Icons.check, color: Colors.white),
                  //   label: Text('StringShowAll'.tr,
                  //       style: TextStyle(color: Colors.white)),
                  //   style: ElevatedButton.styleFrom(
                  //     backgroundColor: Colors.red[800],
                  //     padding: const EdgeInsets.symmetric(vertical: 15),
                  //     shape: RoundedRectangleBorder(
                  //       borderRadius: BorderRadius.circular(10),
                  //     ),
                  //     elevation: 3,
                  //   ),
                  //   onPressed: () async {
                  //     controller.TYPE_SER=1;
                  //     await controller.get_BIL_MOV_M("DateNow");
                  //   },
                  // ),
                ],
              ),
            ))
    );
  }

  Widget _buildDoubleInputRow(Widget first, Widget second,context) {
    double height = MediaQuery.of(context).size.height;
    return Column(
      children: [
        Row(
          children: [
            Expanded(
              child: Container(
                  margin: EdgeInsets.only(left: 0.02 * height),
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular( 0.02 * height)),
                  child: first
              ),
            ),
            Expanded(
              child: Container(
                  margin: EdgeInsets.only(right: 0.02 * height),
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(0.02 * height)),
                  child: second
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildDateField(String label, TextEditingController controller2,BuildContext context,
      Function  onTap) {
    double height = MediaQuery.of(context).size.height;
    return TextFormField(
      decoration: InputDecoration(
        labelText: label,
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(0.02 * height),
          borderSide: BorderSide(color: Colors.red),
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(0.02 * height)),
        ),
        suffixIcon: const Icon(Icons.calendar_today),
      ),
      readOnly: true,
      controller:controller2,
      onTap: () => onTap(),
    );
  }

  Future<void> _resetFilters() async {
      controller.selectedBranchFrom = null;
      controller.selectedBranchTo = null;
      controller.SelectDataSCID_S = null;
      controller.SelectDataPKID_S = null;
      controller.FromDaysController.text = controller.SER_DA;
      controller.ToDaysController.text = controller.SER_DA;
    controller.TYPE_SER=2;
    controller.update();
    await controller.GET_BIL_MOV_M_P("DateNow");
    await controller.get_RETURN_SALE("DateNow");
  }

  Future<void> _applyFilters(BuildContext context) async {
    controller.TYPE_SER=2;
    await controller.GET_BIL_MOV_M_P("DateNow");
    await controller.get_RETURN_SALE("DateNow");
    Navigator.pop(context);
    // تطبيق الفلاتر هنا
  }

  FutureBuilder<List<Bra_Inf_Local>> DropdownBra_InfBuilder_f(BuildContext context) {
    return FutureBuilder<List<Bra_Inf_Local>>(
        future:  GET_BRA(1),
        builder: (BuildContext context,
            AsyncSnapshot<List<Bra_Inf_Local>> snapshot) {
          if (!snapshot.hasData) {
            return Dropdown(josnStatus: josnStatus, GETSTRING: '',);
          }
          return DropdownButtonFormField2(
            decoration: ThemeHelper().InputDecorationDropDown(" ${'StringFROM'.tr}"),
            isExpanded: true,
            hint: ThemeHelper().buildText(context,'StringFromBrach', Colors.grey,'S'),
            value: controller.selectedBranchFrom,
            style: ThemeHelper().buildTextStyle(context, Colors.black,'M'),
            items: snapshot.data!
                .map((item) => DropdownMenuItem<String>(
              value: item.BIID.toString(),
              child: Text(
                item.BINA_D.toString(),
                style:  ThemeHelper().buildTextStyle(context, Colors.black,'M'),
              ),
            ))
                .toList()
                .obs,
            onChanged: (value) {
              controller.selectedBranchFrom = value.toString();
            },
          );
        });
  }

  FutureBuilder<List<Bra_Inf_Local>> DropdownBra_Inf_ToBuilder(BuildContext context) {
    return FutureBuilder<List<Bra_Inf_Local>>(
        future:  GET_BRA(2),
        builder: (BuildContext context,
            AsyncSnapshot<List<Bra_Inf_Local>> snapshot) {
          if (!snapshot.hasData) {
            return Dropdown(josnStatus: josnStatus, GETSTRING: '',);
          }
          return  DropdownButtonFormField2(
            decoration: ThemeHelper().InputDecorationDropDown('StringBPID_TlableText'.tr),
            isExpanded: true,
            hint: ThemeHelper().buildText(context,'StringToBrach', Colors.grey,'S'),
            value: controller.selectedBranchTo,
            style: ThemeHelper().buildTextStyle(context, Colors.black,'M'),
            items: snapshot.data!.map((item) => DropdownMenuItem<String>(
              value: item.BIID.toString(),
              child: Text(
                item.BINA_D.toString(),
                style: ThemeHelper().buildTextStyle(context, Colors.black,'M'),
              ),
            )).toList().obs,
            onChanged: (value) {
              controller.selectedBranchTo = value.toString();
            },
          );
        });
  }

  FutureBuilder<List<Sys_Cur_Local>> DropdownSYS_CUR_SBuilder(BuildContext context) {
    return FutureBuilder<List<Sys_Cur_Local>>(
        future: GET_SYS_CUR(),
        builder: (BuildContext context,
            AsyncSnapshot<List<Sys_Cur_Local>> snapshot) {
          if (!snapshot.hasData) {
            return Dropdown(
              josnStatus: josnStatus,
              GETSTRING: 'StringChi_currency'.tr,
            );
          }
          return DropdownButtonFormField2(
            decoration: ThemeHelper().InputDecorationDropDown("${'StringSCIDlableText'.tr}"),
            isExpanded: true,
            hint: ThemeHelper().buildText(context,'StringChi_currency', Colors.grey,'S'),
            value: controller.SelectDataSCID_S,
            style: ThemeHelper().buildTextStyle(context, Colors.black,'M'),
            items: snapshot.data!.map((item) => DropdownMenuItem<String>(
              value: item.SCID.toString(),
              child: Text(
                item.SCNA_D.toString(),
                style:ThemeHelper().buildTextStyle(context, Colors.black,'M'),
              ),
            ))
                .toList()
                .obs,
            onChanged: (value) {
              controller.SelectDataSCID_S = value.toString();
            },
          );
        });
  }

  GetBuilder<Sale_Invoices_Controller> DropdownPAY_KIN_SBuilder() {
    return GetBuilder<Sale_Invoices_Controller>(
        init: Sale_Invoices_Controller(),
        builder: ((controller) => FutureBuilder<List<Pay_Kin_Local>>(
            future: GET_PAY_KIN(1,'REP',1,''),
            builder: (BuildContext context, AsyncSnapshot<List<Pay_Kin_Local>> snapshot) {
              if (!snapshot.hasData) {
                return Dropdown(josnStatus: josnStatus, GETSTRING: 'StringChi_PAY'.tr,);
              }
              return DropdownButtonFormField2(
                decoration: ThemeHelper().InputDecorationDropDown(''),
                isExpanded: true,
                hint: ThemeHelper().buildText(context,'StringChi_PAY', Colors.grey,'S'),
                value: controller.SelectDataPKID_S,
                style:ThemeHelper().buildTextStyle(context, Colors.black,'M'),
                items: snapshot.data!.map((item) => DropdownMenuItem<String>(
                  value: item.PKID.toString(),
                  child: Text(item.PKNA_D.toString(),
                    style: ThemeHelper().buildTextStyle(context, Colors.black,'M'),),)
                ).toList().obs,
                onChanged: (value) {
                    //Do something when changing the item if you want.
                    controller.SelectDataPKID_S = value.toString();
                    controller.update();
                },
              );
            })));
  }

}

