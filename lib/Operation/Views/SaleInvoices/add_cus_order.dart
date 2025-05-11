import 'package:dropdown_button2/dropdown_button2.dart';
import '../../../Operation/Controllers/sale_invoices_controller.dart';
import '../../../Setting/models/bil_are.dart';
import '../../../Setting/models/cou_tow.dart';
import '../../../Setting/models/cou_wrd.dart';
import '../../../Widgets/app_extension.dart';
import '../../../Widgets/clipper.dart';
import '../../../Widgets/colors.dart';
import '../../../Widgets/config.dart';
import '../../../Widgets/dropdown.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../Widgets/theme_helper.dart';
import '../../../database/setting_db.dart';


class Add_Cus_Order extends StatefulWidget {
  const Add_Cus_Order({super.key});

  @override
  State<Add_Cus_Order> createState() => _CheckOutState();
}

class _CheckOutState extends State<Add_Cus_Order> {
  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return GetBuilder<Sale_Invoices_Controller>(
        init: Sale_Invoices_Controller(),
        builder: ((controller) => Scaffold(
          body: SingleChildScrollView(
            child: Column(
              children: [
                Stack(
                  children: [
                    ClipPath(
                      clipper: BottomClipper(),
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.black,
                          borderRadius: BorderRadius.only(
                            bottomLeft: Radius.circular(30),
                            bottomRight: Radius.circular(30),
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(top: 5, left: 10, right: 10),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          IconButton(
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            icon: Icon(
                              Icons.close,
                              color: Colors.black,
                            ),
                          ),
                          Text(
                            'StringDelivery'.tr,
                            style: ThemeHelper().buildTextStyle(context,AppColors.black,'L'),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.only(
                        topRight: Radius.circular(0.03 * width),
                        topLeft: Radius.circular(0.03 * width),
                      ),
                      color: Color(0xFFf3f6fa),
                    ),
                    child: Padding(
                      padding: EdgeInsets.only(left: 0.01 * width, right: 0.01 * width),
                      child: Column(
                        children: [
                          SizedBox(height: 0.01 * height),
                          TextFormField(
                            style: ThemeHelper().buildTextStyle(context, Colors.black,'M'),
                            controller: controller.BCDMOController,
                            decoration: ThemeHelper().InputDecorationDropDown('StringBCDMO'.tr),
                          ),
                          SizedBox(height: 0.01 * height),
                          TextFormField(
                            style: ThemeHelper().buildTextStyle(context, Colors.black,'M'),
                            controller: controller.BCDNAController,
                            decoration: ThemeHelper().InputDecorationDropDown('StringBMMNA'.tr),
                          ),
                          SizedBox(height: 0.01 * height),
                          TextFormField(
                            style: ThemeHelper().buildTextStyle(context, Colors.black,'M'),
                            controller: controller.BCDADController,
                            decoration: ThemeHelper().InputDecorationDropDown('StringAddress'.tr),
                          ),
                          SizedBox(height: 0.01 * height),
                          DropdownCou_WrdBuilder(),
                          SizedBox(height: 0.01 * height),
                          DropdownCOU_TOWBuilder(),
                          SizedBox(height: 0.01 * height),
                          DropdownBIL_AREBuilder(),
                          SizedBox(height: 0.01 * height),
                          TextFormField(
                            style: ThemeHelper().buildTextStyle(context, Colors.black,'M'),
                            controller: controller.BCDSNController,
                            decoration: ThemeHelper().InputDecorationDropDown('StringStreetNo'.tr),
                          ),
                          SizedBox(height: 0.01 * height),
                          TextFormField(
                            style: ThemeHelper().buildTextStyle(context, Colors.black,'M'),
                            controller: controller.BCDBNController,
                            decoration: ThemeHelper().InputDecorationDropDown('StringBuildingNo'.tr),
                          ),
                          SizedBox(height: 0.01 * height),
                          TextFormField(
                            style: ThemeHelper().buildTextStyle(context, Colors.black,'M'),
                            controller: controller.BCDFNController,
                            decoration: ThemeHelper().InputDecorationDropDown('StringBCDFN'.tr),
                          ),
                          SizedBox(height: 0.01 * height),
                          MaterialButton(
                            onPressed: () async {
                           bool valid_save =   controller.Save_BIF_CUS_D_P();
                           if (valid_save==true){
                             Navigator.pop(context);
                           }
                            },
                            child: Container(
                              height: 0.04 * height,
                              // width: 330.w,
                              alignment: Alignment.center,
                              decoration: BoxDecoration(color: AppColors.MainColor,
                                  borderRadius: BorderRadius.circular(5)),
                              child: Text('StringSave'.tr, style: ThemeHelper().buildTextStyle(context, Colors.white,'L'),
                              ),
                            ).fadeAnimation(0 * 0.6),
                          ),
                        ],
                      ),
                    )),
              ],
            ),
          ),
        )));
  }

  GetBuilder<Sale_Invoices_Controller> DropdownCou_WrdBuilder() {
    return GetBuilder<Sale_Invoices_Controller>(
        init: Sale_Invoices_Controller(),
        builder: ((controller) => FutureBuilder<List<Cou_Wrd_Local>>(
            future: GET_COU_WRD(),
            builder: (BuildContext context, AsyncSnapshot<List<Cou_Wrd_Local>> snapshot) {
              if (!snapshot.hasData) {
                return Dropdown(josnStatus: josnStatus,GETSTRING: 'StringChooseCountry',);
              }
              return DropdownButtonFormField2(
                decoration: ThemeHelper().InputDecorationDropDown('StringChooseCountry'.tr),
                dropdownStyleData: const DropdownStyleData(
                  maxHeight: 200,
                ),
                isExpanded: true,
                hint: ThemeHelper().buildText(context,'StringChooseCountry', Colors.grey,'S'),
                value: controller.SelectDataCWID2,
                style: ThemeHelper().buildTextStyle(context, Colors.black,'M'),
                items: snapshot.data!.map((item) => DropdownMenuItem<String>(
                  value: "${item.CWID.toString() + " +++ " + item.CWNA_D.toString()}",
                  // value: item.CWID.toString(),
                  child: Text(
                    item.CWNA_D.toString(),
                    style: ThemeHelper().buildTextStyle(context, Colors.black,'M'),
                  ),
                )).toList().obs,
                onChanged: (value) {
                  setState(() {
                    controller.SelectDataCWID2 = value as String;
                    controller.SelectDataCWID = value.toString().split(" +++ ")[0];
                    controller.SelectDataCTID = null;
                    controller.SelectDataCTID2 = null;
                    controller.SelectDataBAID2 = null;
                    controller.SelectDataBAID = null;
                    print(controller.SelectDataCWID);
                    print('controller.SelectDataCWID');
                    controller.update();
                  });
                },
                dropdownSearchData: DropdownSearchData(
                  searchInnerWidgetHeight: 50,
                  searchController: controller.TextEditingSercheController,
                  searchInnerWidget: Padding(
                    padding: const EdgeInsets.only(
                      top: 8,
                      bottom: 4,
                      right: 8,
                      left: 8,
                    ),
                    child: TextFormField(
                      controller: controller.TextEditingSercheController,
                      decoration: InputDecoration(
                        isDense: true,
                        contentPadding: const EdgeInsets.symmetric(
                          horizontal: 10,
                          vertical: 8,
                        ),
                        hintText: 'StringSearch_for_CWID'.tr,
                        hintStyle: const TextStyle(fontSize: 12),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                    ),
                  ),
                  searchMatchFn: (item, searchValue) {
                    return (item.value
                        .toString()
                        .toLowerCase()
                        .contains(searchValue));
                  },
                ),
                //This to clear the search value when you close the menu
                onMenuStateChange: (isOpen) {
                  if (!isOpen) {
                    controller.TextEditingSercheController.clear();
                  }
                },
              );
            })));
  }

  GetBuilder<Sale_Invoices_Controller> DropdownCOU_TOWBuilder() {
    return GetBuilder<Sale_Invoices_Controller>(
        init: Sale_Invoices_Controller(),
        builder: ((controller) => FutureBuilder<List<Cou_Tow_Local>>(
            future: GET_COU_TOW(controller.SelectDataCWID.toString()),
            builder: (BuildContext context,
                AsyncSnapshot<List<Cou_Tow_Local>> snapshot) {
              if (!snapshot.hasData) {
                return Dropdown(
                  josnStatus: josnStatus,
                  GETSTRING: 'StringBrach',
                );
              }
              return DropdownButtonFormField2(
                decoration:  ThemeHelper().InputDecorationDropDown('StringCity'.tr),
                dropdownStyleData: const DropdownStyleData(
                  maxHeight: 200,
                ),
                isExpanded: true,
                hint:ThemeHelper().buildText(context,'StringCity', Colors.grey,'S'),
                items: snapshot.data!.map((item) => DropdownMenuItem<String>(
                  value: "${item.CTID.toString() + " +++ " + item.CTNA_D.toString()}",
                  //   value: item.CTID.toString(),
                  child: Text(
                    item.CTNA_D.toString(),
                    style: ThemeHelper().buildTextStyle(context, Colors.black,'M'),
                  ),
                )).toList().obs,
                value: controller.SelectDataCTID2,
                onChanged: (value) {
                  setState(() {
                    controller.SelectDataCTID2 = value as String;
                    controller.SelectDataCTID = value.toString().split(" +++ ")[0];
                    controller.SelectDataBAID = null;
                    controller.SelectDataBAID2 = null;
                  });
                },
                dropdownSearchData: DropdownSearchData(
                  searchInnerWidgetHeight: 60,
                  searchController: controller.TextEditingSercheController,
                  searchInnerWidget: Padding(
                    padding: const EdgeInsets.only(
                      top: 8,
                      bottom: 4,
                      right: 8,
                      left: 8,
                    ),
                    child: TextFormField(
                      controller: controller.TextEditingSercheController,
                      decoration: InputDecoration(
                        isDense: true,
                        contentPadding: const EdgeInsets.symmetric(
                          horizontal: 10,
                          vertical: 8,
                        ),
                        hintText: 'StringSearch_for_CTID'.tr,
                        hintStyle: const TextStyle(fontSize: 12),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                    ),
                  ),
                  searchMatchFn: (item, searchValue) {
                    return (item.value
                        .toString()
                        .toLowerCase()
                        .contains(searchValue));
                  },
                ),
                //This to clear the search value when you close the menu
                onMenuStateChange: (isOpen) {
                  if (!isOpen) {
                    controller.TextEditingSercheController.clear();
                  }
                },
              );
            })));
  }

  GetBuilder<Sale_Invoices_Controller> DropdownBIL_AREBuilder() {
    return GetBuilder<Sale_Invoices_Controller>(
        init: Sale_Invoices_Controller(),
        builder: ((controller) => FutureBuilder<List<Bil_Are_Local>>(
            future: GET_BIL_ARE(controller.SelectDataCWID.toString(),
                controller.SelectDataCTID.toString()),
            builder: (BuildContext context,
                AsyncSnapshot<List<Bil_Are_Local>> snapshot) {
              if (!snapshot.hasData) {
                return Dropdown(
                  josnStatus: josnStatus,
                  GETSTRING: 'StringBrach',
                );
              }
              return DropdownButtonFormField2(
                decoration: ThemeHelper().InputDecorationDropDown('StringArea'.tr),
                dropdownStyleData: const DropdownStyleData(
                  maxHeight: 200,
                ),
                isExpanded: true,
                hint: ThemeHelper().buildText(context,'StringArea', Colors.grey,'S'),
                items: snapshot.data!.map((item) => DropdownMenuItem<String>(
                  value: "${item.BAID.toString() + " +++ " + item.BANA_D.toString()}",
                  //  value: item.BAID.toString(),
                  child: Text(
                    item.BANA_D.toString(),
                    style: ThemeHelper().buildTextStyle(context, Colors.black,'M'),
                  ),
                ))
                    .toList()
                    .obs,
                value: controller.SelectDataBAID2,
                onChanged: (value) {
                  setState(() {
                    controller.SelectDataBAID2 = value as String;
                    controller.SelectDataBAID = value.toString().split(" +++ ")[0];
                  });
                },
                dropdownSearchData: DropdownSearchData(
                  searchInnerWidgetHeight: 60,
                  searchController: controller.TextEditingSercheController,
                  searchInnerWidget: Padding(
                    padding: const EdgeInsets.only(
                      top: 8,
                      bottom: 4,
                      right: 8,
                      left: 8,
                    ),
                    child: TextFormField(
                      controller: controller.TextEditingSercheController,
                      decoration: InputDecoration(
                        isDense: true,
                        contentPadding: const EdgeInsets.symmetric(
                          horizontal: 10,
                          vertical: 8,
                        ),
                        hintText: 'StringSearch_for_BAID'.tr,
                        hintStyle: const TextStyle(fontSize: 12),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                    ),
                  ),
                  searchMatchFn: (item, searchValue) {
                    return (item.value
                        .toString()
                        .toLowerCase()
                        .contains(searchValue));
                  },
                ),
                //This to clear the search value when you close the menu
                onMenuStateChange: (isOpen) {
                  if (!isOpen) {
                    controller.TextEditingSercheController.clear();
                  }
                },

              );
            })));
  }

}
