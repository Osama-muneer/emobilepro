import 'dart:async';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../Setting/controllers/setting_controller.dart';
import '../../../Setting/models/mat_gro.dart';
import '../../../Setting/models/mat_inf.dart';
import '../../../Setting/models/mat_uni_c.dart';
import '../../../Setting/models/sto_inf.dart';
import '../../../Setting/models/sto_num.dart';
import '../../../Widgets/config.dart';
import '../../../Widgets/dropdown.dart';
import '../../../Widgets/theme_helper.dart';
import '../../../database/invoices_db.dart';
import '../../../database/setting_db.dart';
import '../../Controllers/sale_invoices_controller.dart';

class Additem {

  final Sale_Invoices_Controller controller = Get.find();

  displayAddItemsWindo() {
    Get.bottomSheet(
      StatefulBuilder(builder: (BuildContext context, StateSetter setState) {
        double width = MediaQuery.of(context).size.width;
        double height = MediaQuery.of(context).size.height;
        return GetBuilder<Sale_Invoices_Controller>(
            init: Sale_Invoices_Controller(),
            builder: ((controller) =>
                Align(
                  alignment: Alignment.topCenter,
                  child: Form(
                    key: controller.ADD_EDformKey,
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.only(
                          topRight: Radius.circular(0.02 * height),
                          topLeft: Radius.circular(0.02 * height),
                        ),
                        color: Colors.white,
                      ),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                              controller.titleAddScreen,
                              style: ThemeHelper().buildTextStyle(
                                  context, Colors.black, 'L')
                          ),
                          Expanded(
                              child: SingleChildScrollView(
                                child: Padding(
                                  padding: EdgeInsets.only(
                                      right: 0.02 * width, left: 0.02 * width),
                                  child: Column(
                                    children: [
                                      Card(
                                        elevation: 2,
                                        shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(
                                              0.02 * width),
                                        ),
                                        clipBehavior: Clip.antiAliasWithSaveLayer,
                                        child: Container(
                                          color: Colors.white,
                                          child: Column(
                                            children: [
                                              Container(
                                                width: double.infinity,
                                                color: Colors.red,
                                                padding: EdgeInsets.symmetric(
                                                    horizontal: 0.01 * height),
                                                child: Center(
                                                  child: Text(
                                                      "Stringdata_Item".tr,
                                                      style: ThemeHelper()
                                                          .buildTextStyle(
                                                          context, Colors.white,
                                                          'L')),
                                                ),
                                              ),
                                              Container(
                                                width: double.infinity,
                                                padding: EdgeInsets.symmetric(
                                                    horizontal: 0.01 * height),
                                                child: Column(
                                                  crossAxisAlignment: CrossAxisAlignment.end,
                                                  children: <Widget>[
                                                    StteingController().isSwitchUse_Gro == true
                                                        ? SizedBox(
                                                      height: 0.01 * height,
                                                    )
                                                        : const SizedBox(
                                                      height: 0,
                                                    ),
                                                    StteingController().isSwitchUse_Gro == true
                                                        ? Row(
                                                      children: [
                                                        Expanded(
                                                            child: DropdownMAT_GROBuilder()),
                                                      ],
                                                    )
                                                        : const SizedBox(
                                                      height: 0,
                                                    ),
                                                    Center(child: Text(
                                                        'عدد السجلات: ${controller.autoCompleteData.length}')),
                                                    Row(
                                                      mainAxisAlignment: MainAxisAlignment.start,
                                                      children: [
                                                        Expanded(child: Autocomplete<Mat_Inf_Local>(
                                                          optionsBuilder: (TextEditingValue textEditingValue) {
                                                            return _filterOptions(textEditingValue.text);
                                                          },
                                                          displayStringForOption: (Mat_Inf_Local option) =>
                                                          controller.MINAController.text.isEmpty ? '' : option.MINA_D,
                                                          fieldViewBuilder: (
                                                              BuildContext context, textEditingController,
                                                              focusNode, onFieldSubmitted) {
                                                            controller.autocompleteFocusNode = focusNode;
                                                            return _buildTextField(context, textEditingController, focusNode);
                                                          },
                                                          onSelected: (
                                                              Mat_Inf_Local selection) async {
                                                            await _handleSelection(selection);
                                                          },
                                                          optionsViewBuilder: (
                                                              BuildContext context,
                                                              AutocompleteOnSelected<Mat_Inf_Local> onSelected,
                                                              Iterable<Mat_Inf_Local> options) {
                                                            return _buildOptionsList(
                                                                context,
                                                                options,
                                                                onSelected);
                                                          },
                                                        ),
                                                        ),
                                                        StteingController().isSwitchBrcode
                                                            ? IconButton(
                                                            icon: Icon(
                                                              Icons.camera_alt,
                                                              size: 0.03 * height,
                                                            ),
                                                            onPressed: () {
                                                              setState(() {
                                                                Navigator.of(
                                                                    context)
                                                                    .pop(false);
                                                                controller.scanBarcodeNormal();
                                                                controller
                                                                    .myFocusNode
                                                                    .requestFocus();
                                                              });
                                                            })
                                                            : Container()
                                                      ],
                                                    ),
                                                    controller.SMDED != '2' &&
                                                        controller.BMKID != 11 &&
                                                        controller.BMKID != 12
                                                        ? Row(
                                                      mainAxisAlignment: MainAxisAlignment
                                                          .spaceAround,
                                                      children: [
                                                        Expanded(
                                                            child: DropdownMat_Uni_CBuilder()),
                                                        SizedBox(
                                                          width: 0.02 * height,),
                                                        controller.BMKID == 3 ||
                                                            controller.BMKID == 4 ||
                                                            controller.BMKID == 5 ||
                                                            controller.BMKID == 7 ||
                                                            controller.BMKID == 10
                                                            ? Expanded(
                                                          child: DropdownMat_Date_endBuilder(),
                                                        )
                                                            : Container(
                                                          width: MediaQuery
                                                              .of(context)
                                                              .size
                                                              .width / 3,
                                                          margin: EdgeInsets.only(
                                                              bottom: 0.01 *
                                                                  height),
                                                          child: TextFormField(
                                                            controller: controller
                                                                .BMDEDController,
                                                            textAlign:
                                                            TextAlign
                                                                .center,
                                                            decoration:
                                                            InputDecoration(
                                                              labelText:
                                                              'StringSMDED'
                                                                  .tr,
                                                              contentPadding: const EdgeInsets
                                                                  .symmetric(
                                                                  vertical:
                                                                  13,
                                                                  horizontal:
                                                                  8),
                                                            ),
                                                            onTap: () {
                                                              setState(() {
                                                                controller.selectDateFromDays2(context);
                                                              });
                                                            },
                                                          ),
                                                        ),
                                                      ],
                                                    )
                                                        : Row(
                                                      mainAxisAlignment: MainAxisAlignment
                                                          .spaceAround,
                                                      children: [
                                                        Expanded(
                                                            child: DropdownMat_Uni_CBuilder()),
                                                      ],
                                                    ),
                                                    SizedBox(
                                                      height: 0.01 * height,
                                                    ),
                                                    controller.Use_Multi_Stores == '1' &&
                                                        (([3, 4, 7, 10].contains(controller.BMKID)) &&
                                                            StteingController().MULTI_STORES_BO == true) || (([1, 2].contains(controller.BMKID)) &&
                                                        StteingController().MULTI_STORES_BI == true) ?
                                                    Row(
                                                      children: [
                                                        Expanded(
                                                            child: DropdownSTO_INF_DBuilder()),
                                                      ],
                                                    ) : Container(),
                                                    SizedBox(
                                                      height: 0.01 * height,
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                      Card(
                                        elevation: 2,
                                        shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(
                                              0.02 * width),
                                        ),
                                        clipBehavior: Clip.antiAliasWithSaveLayer,
                                        child: Container(
                                          color: Colors.white,
                                          child: Column(
                                            children: [
                                              Container(
                                                width: double.infinity,
                                                color: Colors.red,
                                                padding: EdgeInsets.symmetric(
                                                    horizontal: 0.01 * height),
                                                child: Center(
                                                  child: Text(
                                                    "StringUnite_price_Quantity"
                                                        .tr,
                                                    style: ThemeHelper()
                                                        .buildTextStyle(
                                                        context, Colors.white,
                                                        'L'),),
                                                ),
                                              ),
                                              Container(
                                                width: double.infinity,
                                                padding: EdgeInsets.only(
                                                    left: 0.01 * height,
                                                    right: 0.01 * height),
                                                child: Row(
                                                  mainAxisAlignment: MainAxisAlignment
                                                      .spaceBetween,
                                                  children: [
                                                    (controller.BMKID == 1 ||  controller.BMKID == 2 )||
                                                        controller.Allow_give_Free_Quantities == '1' && controller.UPIN_BMDNF == 1
                                                        ? Column(
                                                      mainAxisAlignment: MainAxisAlignment
                                                          .spaceBetween,
                                                      children: [
                                                        SizedBox(height: 0.01 *
                                                            height),
                                                        controller.UPIN_PRI == 1
                                                            ? Text(
                                                          "StringCost_Price".tr,
                                                          style: ThemeHelper()
                                                              .buildTextStyle(
                                                              context,
                                                              Colors.black, 'M'),)
                                                            : Container(),
                                                        controller.UPIN_PRI == 1
                                                            ? SizedBox(
                                                            height: 0.01 * height)
                                                            : const SizedBox(
                                                            height: 1),
                                                        Text(
                                                            "StrinlChice_item_QUANTITY"
                                                                .tr,
                                                            style: ThemeHelper()
                                                                .buildTextStyle(
                                                                context,
                                                                Colors.black,
                                                                'M')),
                                                        SizedBox(
                                                          height: 0.01 * height,
                                                        ),
                                                        (controller.PKID == 1 && controller
                                                            .Allow_give_Free_Pay_Cash ==
                                                            '1' ||
                                                            (controller
                                                                .Allow_give_Free_Pay_Cash ==
                                                                '3' && controller
                                                                .UPIN_Allow_give_Free_Pay_Cash ==
                                                                1)) ?
                                                        Text("StringBMDNF".tr,
                                                            style: ThemeHelper()
                                                                .buildTextStyle(
                                                                context,
                                                                Colors.black,
                                                                'M')) : (controller.PKID ==
                                                            3 && controller
                                                            .Allow_give_Free_Pay_due ==
                                                            '1' || (controller
                                                            .Allow_give_Free_Pay_due ==
                                                            '3'
                                                            && controller
                                                                .UPIN_Allow_give_Free_Pay_due ==
                                                                1)) ? Text(
                                                            "StringBMDNF".tr,
                                                            style: ThemeHelper()
                                                                .buildTextStyle(
                                                                context,
                                                                Colors.black,
                                                                'M'))
                                                            : (controller.PKID != 1 &&
                                                            controller.PKID != 3 &&
                                                            controller
                                                                .Allow_give_Free_Pay_Not_Cash_Due ==
                                                                '1' ||
                                                            (controller
                                                                .Allow_give_Free_Pay_Not_Cash_Due ==
                                                                '3'
                                                                && controller
                                                                    .UPIN_Allow_give_Free_Pay_Not_Cash_Due ==
                                                                    1)) ? Text(
                                                            "StringBMDNF".tr,
                                                            style: ThemeHelper()
                                                                .buildTextStyle(
                                                                context,
                                                                Colors.black,
                                                                'M'))
                                                            : Container(),
                                                        SizedBox(
                                                          height: 0.01 * height,
                                                        ),
                                                        (controller.USING_TAX_SALES == '1' ||
                                                            (controller.USING_TAX_SALES ==
                                                                '3' &&
                                                                (controller.UPIN_USING_TAX_SALES ==
                                                                    1 &&
                                                                    controller.Price_include_Tax ==
                                                                        true)))
                                                            ? Text(
                                                            "StringBMMAMTX".tr,
                                                            style: ThemeHelper()
                                                                .buildTextStyle(
                                                                context,
                                                                Colors.black,
                                                                'M'))
                                                            : Container(),
                                                        (controller.USING_TAX_SALES == '1' ||
                                                            (controller.USING_TAX_SALES ==
                                                                '3' &&
                                                                (controller.UPIN_USING_TAX_SALES ==
                                                                    1 &&
                                                                    controller.Price_include_Tax ==
                                                                        true)))
                                                            ? SizedBox(
                                                          height: 0.01 * height,)
                                                            : Container(),
                                                        Text("StringMPCO".tr,
                                                            style: ThemeHelper()
                                                                .buildTextStyle(
                                                                context,
                                                                Colors.black,
                                                                'M')),
                                                        SizedBox(height: 0.01 *
                                                            height),
                                                        Text("StringSUM_BMMAM".tr,
                                                            style: ThemeHelper()
                                                                .buildTextStyle(
                                                                context,
                                                                Colors.red, 'M')),
                                                      ],
                                                    )
                                                        : Column(
                                                      mainAxisAlignment: MainAxisAlignment
                                                          .spaceBetween,
                                                      children: [
                                                        SizedBox(height: 0.01 *
                                                            height),
                                                        controller.UPIN_PRI == 1
                                                            ? Text(
                                                            "StringCost_Price"
                                                                .tr,
                                                            style: ThemeHelper()
                                                                .buildTextStyle(
                                                                context,
                                                                Colors.black,
                                                                'M'))
                                                            : Container(),
                                                        controller.UPIN_PRI == 1
                                                            ? SizedBox(
                                                            height: 0.01 * height)
                                                            : const SizedBox(
                                                            height: 1),
                                                        Text(
                                                            "StrinlChice_item_QUANTITY"
                                                                .tr,
                                                            style: ThemeHelper()
                                                                .buildTextStyle(
                                                                context,
                                                                Colors.black,
                                                                'M')),
                                                        SizedBox(
                                                          height:
                                                          0.01 * height,
                                                        ),
                                                        (controller.USING_TAX_SALES == '1' ||
                                                            (controller.USING_TAX_SALES ==
                                                                '3' &&
                                                                (controller.UPIN_USING_TAX_SALES ==
                                                                    1 &&
                                                                    controller.Price_include_Tax ==
                                                                        true)))
                                                            ? Text(
                                                            "StringBMMAMTX"
                                                                .tr,
                                                            style: ThemeHelper()
                                                                .buildTextStyle(
                                                                context,
                                                                Colors.black,
                                                                'M'))
                                                            : Container(),
                                                        (controller.USING_TAX_SALES == '1' ||
                                                            (controller.USING_TAX_SALES ==
                                                                '3' &&
                                                                (controller.UPIN_USING_TAX_SALES ==
                                                                    1 &&
                                                                    controller.Price_include_Tax ==
                                                                        true)))
                                                            ? SizedBox(
                                                          height: 0.01 * height,
                                                        )
                                                            : Container(),
                                                        Text("StringMPCO".tr,
                                                            style: ThemeHelper()
                                                                .buildTextStyle(
                                                                context,
                                                                Colors.black,
                                                                'M')),
                                                        SizedBox(
                                                          height:
                                                          0.01 * height,
                                                        ),
                                                        Text("StringSUM_BMMAM".tr,
                                                            style: ThemeHelper()
                                                                .buildTextStyle(
                                                                context,
                                                                Colors.red, 'M')),
                                                      ],
                                                    ),
                                                    (controller.BMKID == 1 || controller.BMKID == 2) ||
                                                        controller.Allow_give_Free_Quantities == '1' && controller.UPIN_BMDNF == 1
                                                        ? Column(
                                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                      children: [
                                                        SizedBox(height: 0.01 * height),
                                                        controller.UPIN_PRI == 1
                                                            ? Text(controller.MPCO_VController.text,
                                                            style: ThemeHelper().buildTextStyle(context, Colors.grey[600]!, 'M'))
                                                            : Container(),
                                                        controller.UPIN_PRI == 1
                                                            ? SizedBox(
                                                            height: 0.01 * height)
                                                            : const SizedBox(
                                                            height: 1),
                                                        Container(
                                                            padding: EdgeInsets
                                                                .only(
                                                                bottom: 0.01 *
                                                                    height),
                                                            width: MediaQuery
                                                                .of(
                                                                context)
                                                                .size
                                                                .width /
                                                                2.4,
                                                            height: MediaQuery
                                                                .of(
                                                                context)
                                                                .size
                                                                .height /
                                                                35.8,
                                                            child: TextFormField(
                                                              style: ThemeHelper()
                                                                  .buildTextStyle(
                                                                  context,
                                                                  Colors.black,
                                                                  'M'),
                                                              controller: controller
                                                                  .BMDNOController,
                                                              keyboardType:
                                                              TextInputType
                                                                  .number,
                                                              textAlign: TextAlign
                                                                  .center,
                                                              focusNode: controller
                                                                  .myFocusNode,
                                                              textInputAction: TextInputAction.go,
                                                              validator: (v) {
                                                                return controller.validateSMDFN(controller.BMDNOController.text.toString());
                                                              },
                                                              onChanged: (v) {
                                                                if (v.isNotEmpty && double.parse(v) >= 0.0) {
                                                                  controller.Calculate_BMD_NO_AM();
                                                                } else {
                                                                  controller.SUMBMDAMController.text = '0';
                                                                }
                                                              },
                                                              onFieldSubmitted: (String value) {
                                                                controller.myFocusBMMAM.requestFocus();
                                                                if (controller.BMDAMController.text.isEmpty) {
                                                                  return;
                                                                } else {
                                                                  controller.BMDAMController.selection = TextSelection(
                                                                      baseOffset: 0,
                                                                      extentOffset: controller.BMDAMController.text.length);
                                                                }
                                                              },
                                                            )),
                                                        SizedBox(
                                                          height: 0.01 * height,),
                                                        (controller.PKID == 1 && controller
                                                            .Allow_give_Free_Pay_Cash ==
                                                            '1' ||
                                                            (controller
                                                                .Allow_give_Free_Pay_Cash ==
                                                                '3' && controller
                                                                .UPIN_Allow_give_Free_Pay_Cash ==
                                                                1)) ?
                                                        Container(
                                                            padding: EdgeInsets
                                                                .only(
                                                                bottom: 0.01 *
                                                                    height),
                                                            width: MediaQuery
                                                                .of(context)
                                                                .size
                                                                .width / 2.4,
                                                            height: MediaQuery
                                                                .of(context)
                                                                .size
                                                                .height / 35.8,
                                                            child: TextFormField(
                                                              style: ThemeHelper()
                                                                  .buildTextStyle(
                                                                  context, Colors
                                                                  .black, 'M'),
                                                              controller: controller
                                                                  .BMDNFController,
                                                              keyboardType: TextInputType
                                                                  .number,
                                                              textAlign: TextAlign
                                                                  .center,
                                                              onChanged: (v) {
                                                                if (v
                                                                    .isNotEmpty) {
                                                                  if (double
                                                                      .parse(v) >=
                                                                      0.0) {
                                                                    controller
                                                                        .Calculate_BMD_NO_AM();
                                                                  }
                                                                }
                                                              },
                                                            )) : (controller.PKID == 3 &&
                                                            controller
                                                                .Allow_give_Free_Pay_due ==
                                                                '1' || (controller
                                                            .Allow_give_Free_Pay_due ==
                                                            '3'
                                                            && controller
                                                                .UPIN_Allow_give_Free_Pay_due ==
                                                                1)) ? Container(
                                                            padding: EdgeInsets
                                                                .only(
                                                                bottom: 0.01 *
                                                                    height),
                                                            width: MediaQuery
                                                                .of(context)
                                                                .size
                                                                .width / 2.4,
                                                            height: MediaQuery
                                                                .of(context)
                                                                .size
                                                                .height / 35.8,
                                                            child: TextFormField(
                                                              style: ThemeHelper()
                                                                  .buildTextStyle(
                                                                  context,
                                                                  Colors.black,
                                                                  'M'),
                                                              controller: controller
                                                                  .BMDNFController,
                                                              keyboardType: TextInputType
                                                                  .number,
                                                              textAlign: TextAlign
                                                                  .center,
                                                              onChanged: (v) {
                                                                if (v
                                                                    .isNotEmpty) {
                                                                  if (double
                                                                      .parse(v) >=
                                                                      0.0) {
                                                                    controller
                                                                        .Calculate_BMD_NO_AM();
                                                                  }
                                                                }
                                                              },
                                                            ))
                                                            : (controller.PKID != 1 &&
                                                            controller.PKID != 3 &&
                                                            controller
                                                                .Allow_give_Free_Pay_Not_Cash_Due ==
                                                                '1' ||
                                                            (controller
                                                                .Allow_give_Free_Pay_Not_Cash_Due ==
                                                                '3'
                                                                && controller
                                                                    .UPIN_Allow_give_Free_Pay_Not_Cash_Due ==
                                                                    1))
                                                            ? Container(
                                                            padding: EdgeInsets
                                                                .only(
                                                                bottom: 0.01 *
                                                                    height),
                                                            width: MediaQuery
                                                                .of(context)
                                                                .size
                                                                .width / 2.4,
                                                            height: MediaQuery
                                                                .of(context)
                                                                .size
                                                                .height / 35.8,
                                                            child: TextFormField(
                                                              style: ThemeHelper()
                                                                  .buildTextStyle(
                                                                  context,
                                                                  Colors.black,
                                                                  'M'),
                                                              controller: controller
                                                                  .BMDNFController,
                                                              keyboardType: TextInputType
                                                                  .number,
                                                              textAlign: TextAlign
                                                                  .center,
                                                              onChanged: (v) {
                                                                if (v
                                                                    .isNotEmpty) {
                                                                  if (double
                                                                      .parse(v) >=
                                                                      0.0) {
                                                                    controller
                                                                        .Calculate_BMD_NO_AM();
                                                                  }
                                                                }
                                                              },
                                                            ))
                                                            : Container(),
                                                        SizedBox(
                                                          height:
                                                          0.01 * height,
                                                        ),
                                                        (controller.USING_TAX_SALES == '1' ||
                                                            (controller.USING_TAX_SALES ==
                                                                '3' &&
                                                                (controller.UPIN_USING_TAX_SALES ==
                                                                    1 &&
                                                                    controller.Price_include_Tax ==
                                                                        true)))
                                                            ? Container(
                                                            padding: EdgeInsets
                                                                .only(
                                                                bottom: 0.01 *
                                                                    height),
                                                            width: MediaQuery
                                                                .of(
                                                                context)
                                                                .size
                                                                .width /
                                                                2.4,
                                                            height: MediaQuery
                                                                .of(
                                                                context)
                                                                .size
                                                                .height /
                                                                35.8,
                                                            child:
                                                            TextFormField(
                                                              style: ThemeHelper()
                                                                  .buildTextStyle(
                                                                  context, Colors
                                                                  .black, 'M'),
                                                              controller:
                                                              controller
                                                                  .BMDAMTXController,
                                                              keyboardType:
                                                              TextInputType
                                                                  .number,
                                                              textAlign:
                                                              TextAlign
                                                                  .center,
                                                              enabled: false,
                                                            ))
                                                            : Container(),
                                                        (controller.USING_TAX_SALES == '1' ||
                                                            (controller.USING_TAX_SALES ==
                                                                '3' &&
                                                                (controller.UPIN_USING_TAX_SALES ==
                                                                    1 &&
                                                                    controller.Price_include_Tax ==
                                                                        true)))
                                                            ? SizedBox(
                                                          height: 0.01 * height,
                                                        )
                                                            : Container(),
                                                        Container(
                                                            padding: EdgeInsets
                                                                .only(
                                                                bottom: 0.01 *
                                                                    height),
                                                            width: MediaQuery
                                                                .of(
                                                                context)
                                                                .size
                                                                .width /
                                                                2.4,
                                                            height: MediaQuery
                                                                .of(
                                                                context)
                                                                .size
                                                                .height /
                                                                35.8,
                                                            child:
                                                            GestureDetector(
                                                              onDoubleTap: () {
                                                                print(
                                                                    controller.Allow_Cho_Price);
                                                                print(
                                                                    controller.UPIN_Allow_Cho_Price);
                                                                print(
                                                                    'UPIN_Allow_Cho_Price');
                                                                if (controller.BMKID != 1 && controller.BMKID != 2 &&
                                                                    (controller.Allow_Cho_Price == '1' ||
                                                                        (controller.Allow_Cho_Price == '3' &&
                                                                            controller.UPIN_Allow_Cho_Price == 1))) {
                                                                  buildShowMPS1(context);
                                                                }
                                                              },
                                                              child: TextFormField(
                                                                style: ThemeHelper().buildTextStyle(context, Colors.black, 'M'),
                                                                controller: controller.BMDAMController,
                                                                keyboardType: TextInputType.number,
                                                                textAlign: TextAlign.center,
                                                                focusNode: controller.myFocusBMMAM,
                                                                enabled: (controller.BMKID == 1 ||
                                                                    controller.BMKID == 1) || controller.Allow_Edit_Sale_Prices == '1' &&
                                                                    controller.UPIN_EDIT_MPS1 == 1 && controller.MIFR == 2
                                                                    ? true : false,
                                                                validator: (v) {
                                                                  return controller.validateBMDAM(controller.BMDAMController.text.toString());
                                                                },
                                                                onChanged:
                                                                    (v) async {
                                                                  if (v
                                                                      .isNotEmpty &&
                                                                      double
                                                                          .parse(
                                                                          v) >=
                                                                          0.0) {
                                                                    controller.MPS1 = 0;
                                                                    controller.MPS1 = double.parse(controller.BMDAMController.text);
                                                                    // await Future.delayed(const Duration(milliseconds: 1300));
                                                                    controller
                                                                        .Calculate_BMD_NO_AM();
                                                                  } else {
                                                                    controller.BMDAMTXController.text = '0';
                                                                    controller.SUMBMDAMController.text = '0';
                                                                  }
                                                                },
                                                                onTap: () {
                                                                  if (controller.BMDAMController.text.isEmpty) {
                                                                    return;
                                                                  } else {
                                                                    controller.BMDAMController.selection =
                                                                        TextSelection(
                                                                            baseOffset: 0,
                                                                            extentOffset: controller.BMDAMController
                                                                                .text
                                                                                .length);
                                                                  }
                                                                },
                                                              ),
                                                            )),
                                                        SizedBox(
                                                          height:
                                                          0.01 * height,
                                                        ),
                                                        Text(
                                                          controller.formatter
                                                              .format(
                                                              double.parse(
                                                                  controller
                                                                      .SUMBMDAMController
                                                                      .text)),
                                                          style: ThemeHelper()
                                                              .buildTextStyle(
                                                              context, Colors.red,
                                                              'M'),),
                                                      ],
                                                    )
                                                        : Column(
                                                      mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                      children: [
                                                        SizedBox(
                                                            height: 0.01 *
                                                                height),
                                                        controller.UPIN_PRI == 1
                                                            ? Text(
                                                          controller
                                                              .MPCO_VController
                                                              .text,
                                                          style: ThemeHelper()
                                                              .buildTextStyle(
                                                              context,
                                                              Colors.grey[600]!,
                                                              'M'),)
                                                            : Container(),
                                                        controller.UPIN_PRI == 1
                                                            ? SizedBox(
                                                          height: 0.01 * height,
                                                        )
                                                            : const SizedBox(
                                                            height: 1),
                                                        Container(
                                                            padding: EdgeInsets
                                                                .only(
                                                                bottom: 0.01 *
                                                                    height),
                                                            width: MediaQuery
                                                                .of(
                                                                context)
                                                                .size
                                                                .width /
                                                                2.4,
                                                            height: MediaQuery
                                                                .of(
                                                                context)
                                                                .size
                                                                .height /
                                                                35.8,
                                                            child: TextFormField(
                                                              style: ThemeHelper()
                                                                  .buildTextStyle(
                                                                  context,
                                                                  Colors.black,
                                                                  'M'),
                                                              controller: controller
                                                                  .BMDNOController,
                                                              keyboardType:
                                                              TextInputType
                                                                  .number,
                                                              textAlign: TextAlign
                                                                  .center,
                                                              focusNode: controller
                                                                  .myFocusNode,
                                                              textInputAction:
                                                              TextInputAction
                                                                  .go,
                                                              validator: (v) {
                                                                return controller
                                                                    .validateSMDFN(
                                                                    controller
                                                                        .BMDNOController
                                                                        .text
                                                                        .toString());
                                                              },
                                                              onChanged: (v) {
                                                                if (v.isNotEmpty && double.parse(v) >= 0.0) {
                                                                  controller.Calculate_BMD_NO_AM();
                                                                } else {
                                                                  controller.SUMBMDAMController.text = '0';
                                                                }
                                                              },
                                                              onFieldSubmitted:
                                                                  (String value) {
                                                                controller
                                                                    .myFocusBMMAM
                                                                    .requestFocus();
                                                                if (controller
                                                                    .BMDAMController
                                                                    .text
                                                                    .isEmpty) {
                                                                  return;
                                                                } else {
                                                                  controller
                                                                      .BMDAMController
                                                                      .selection =
                                                                      TextSelection(
                                                                          baseOffset:
                                                                          0,
                                                                          extentOffset: controller
                                                                              .BMDAMController
                                                                              .text
                                                                              .length);
                                                                }
                                                              },
                                                            )),
                                                        SizedBox(
                                                          height:
                                                          0.01 * height,
                                                        ),
                                                        (controller.USING_TAX_SALES == '1' ||
                                                            (controller.USING_TAX_SALES ==
                                                                '3' &&
                                                                (controller.UPIN_USING_TAX_SALES ==
                                                                    1 &&
                                                                    controller.Price_include_Tax ==
                                                                        true)))
                                                            ? Container(
                                                            padding: EdgeInsets
                                                                .only(
                                                                bottom: 0.01 *
                                                                    height),
                                                            width: MediaQuery
                                                                .of(context)
                                                                .size
                                                                .width / 2.4,
                                                            height: MediaQuery
                                                                .of(context)
                                                                .size
                                                                .height / 35.8,
                                                            child: TextFormField(
                                                              style: ThemeHelper()
                                                                  .buildTextStyle(
                                                                  context, Colors
                                                                  .black, 'M'),
                                                              controller: controller
                                                                  .BMDAMTXController,
                                                              keyboardType: TextInputType
                                                                  .number,
                                                              textAlign: TextAlign
                                                                  .center,
                                                              enabled: false,
                                                            ))
                                                            : Container(),
                                                        (controller.USING_TAX_SALES == '1' ||
                                                            (controller.USING_TAX_SALES ==
                                                                '3' &&
                                                                (controller.UPIN_USING_TAX_SALES ==
                                                                    1 &&
                                                                    controller.Price_include_Tax ==
                                                                        true)))
                                                            ? SizedBox(
                                                          height: 0.01 * height,
                                                        )
                                                            : Container(),
                                                        Container(
                                                            padding: EdgeInsets
                                                                .only(
                                                                bottom: 0.01 *
                                                                    height),
                                                            width: MediaQuery
                                                                .of(context)
                                                                .size
                                                                .width / 2.4,
                                                            height: MediaQuery
                                                                .of(context)
                                                                .size
                                                                .height / 35.8,
                                                            child: GestureDetector(
                                                              onDoubleTap: () {
                                                                print(
                                                                    controller.Allow_Cho_Price);
                                                                print(
                                                                    controller.UPIN_Allow_Cho_Price);
                                                                print(
                                                                    'UPIN_Allow_Cho_Price');
                                                                if (controller.BMKID != 1 && controller.BMKID != 2 &&
                                                                    (controller.Allow_Cho_Price == '1' ||
                                                                        (controller.Allow_Cho_Price == '3' &&
                                                                            controller.UPIN_Allow_Cho_Price == 1))) {
                                                                  buildShowMPS1(
                                                                      context);
                                                                }
                                                              },
                                                              child: TextFormField(
                                                                style: ThemeHelper().buildTextStyle(context, Colors.black, 'M'),
                                                                controller: controller.BMDAMController,
                                                                keyboardType: TextInputType.number,
                                                                textAlign: TextAlign.center,
                                                                focusNode: controller.myFocusBMMAM,
                                                                enabled: (controller.BMKID == 1 || controller.BMKID == 2) ||
                                                                    controller.Allow_Edit_Sale_Prices == '1' &&
                                                                        controller.UPIN_EDIT_MPS1 == 1 &&
                                                                        controller.MIFR == 2
                                                                    ? true : false,
                                                                validator: (v) {
                                                                  return controller.validateBMDAM(
                                                                      controller.BMDAMController.text.toString());
                                                                },
                                                                onChanged:
                                                                    (v) async {
                                                                  if (v
                                                                      .isNotEmpty &&
                                                                      double
                                                                          .parse(
                                                                          v) >=
                                                                          0.0) {
                                                                    controller
                                                                        .MPS1 =
                                                                        double
                                                                            .parse(
                                                                            controller.BMDAMController
                                                                                .text);
                                                                    await Future
                                                                        .delayed(
                                                                        const Duration(
                                                                            milliseconds: 1200));
                                                                    controller
                                                                        .Calculate_BMD_NO_AM();
                                                                  } else {
                                                                    controller.BMDAMTXController.text =
                                                                    '0';controller.SUMBMDAMController.text = '0';
                                                                  }
                                                                },
                                                                onTap: () {
                                                                  if (controller.BMDAMController.text.isEmpty) {
                                                                    return;
                                                                  } else {
                                                                    controller.BMDAMController.selection =
                                                                        TextSelection(
                                                                            baseOffset: 0,
                                                                            extentOffset: controller
                                                                                .BMDAMController
                                                                                .text
                                                                                .length);
                                                                  }
                                                                },
                                                              ),
                                                            )),
                                                        SizedBox(
                                                          height:
                                                          0.01 * height,
                                                        ),
                                                        Text(
                                                          controller.formatter
                                                              .format(
                                                              double.parse(
                                                                  controller
                                                                      .SUMBMDAMController
                                                                      .text)),
                                                          style: ThemeHelper()
                                                              .buildTextStyle(
                                                              context, Colors.red,
                                                              'M'),),
                                                      ],
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                      controller.SelectDataBMMDN == '1' &&
                                          controller.Allow_give_Discount == '1' &&
                                          controller.UPIN_BMMDI == 1
                                          ? (controller.PKID == 1 && controller
                                          .Allow_give_discount_Pay_Cash == '1' ||
                                          (controller
                                              .Allow_give_discount_Pay_Cash ==
                                              '3' && controller
                                              .UPIN_Allow_give_discount_Pay_Cash ==
                                              1)) ?
                                      Card(
                                        elevation: 2,
                                        shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(
                                              0.02 * width),
                                        ),
                                        clipBehavior:
                                        Clip.antiAliasWithSaveLayer,
                                        child: Container(
                                          color: Colors.white,
                                          child: Column(
                                            children: [
                                              Container(
                                                width: double.infinity,
                                                color: Colors.red,
                                                padding: EdgeInsets.symmetric(
                                                    horizontal:
                                                    0.01 * height),
                                                child: Column(
                                                  children: [
                                                    Center(
                                                      child: Text(
                                                        "StringManual_Discount"
                                                            .tr,
                                                        style: ThemeHelper()
                                                            .buildTextStyle(
                                                            context, Colors.white,
                                                            'L'),),
                                                    ),
                                                    Row(
                                                      mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                      children: [
                                                        Expanded(child: Card(
                                                            elevation: 2,
                                                            clipBehavior: Clip
                                                                .antiAliasWithSaveLayer,
                                                            child: Container(
                                                              color: Colors.white,
                                                              child: Column(
                                                                children: [
                                                                  Text(
                                                                    'StringRate'
                                                                        .tr,
                                                                    style: ThemeHelper()
                                                                        .buildTextStyle(
                                                                        context,
                                                                        Colors
                                                                            .black,
                                                                        'M'),),
                                                                  Container(
                                                                    //width: double.infinity,
                                                                    margin: EdgeInsets
                                                                        .only(
                                                                        left: 0.01 *
                                                                            height,
                                                                        right: 0.01 *
                                                                            height,
                                                                        bottom: 0.01 *
                                                                            height),
                                                                    child:
                                                                    TextFormField(
                                                                      style: ThemeHelper()
                                                                          .buildTextStyle(
                                                                          context,
                                                                          Colors
                                                                              .black,
                                                                          'M'),
                                                                      controller:
                                                                      controller
                                                                          .BMDDIRController,
                                                                      keyboardType:
                                                                      TextInputType
                                                                          .number,
                                                                      textAlign:
                                                                      TextAlign
                                                                          .center,
                                                                      onChanged:
                                                                          (v) {
                                                                        if (v
                                                                            .isNotEmpty &&
                                                                            double
                                                                                .parse(
                                                                                v) >=
                                                                                0) {
                                                                          controller
                                                                              .Calculate_BMDDI_IR();
                                                                        }
                                                                        // else{
                                                                        //   controller.BMDDIRController.text = '0';
                                                                        //   controller.SUMBMDDIR = 0;
                                                                        //   controller.Calculate_BMDDI_IR();
                                                                        // }
                                                                      },
                                                                    ),
                                                                  ),
                                                                  Text(
                                                                      controller
                                                                          .formatter
                                                                          .format(
                                                                          controller
                                                                              .SUMBMDDIR)
                                                                          .toString(),
                                                                      style: ThemeHelper()
                                                                          .buildTextStyle(
                                                                          context,
                                                                          Colors
                                                                              .black,
                                                                          'M')),
                                                                ],
                                                              ),
                                                            ))),
                                                        Expanded(child: Card(
                                                            elevation: 2,
                                                            clipBehavior: Clip
                                                                .antiAliasWithSaveLayer,
                                                            child: Container(
                                                              color: Colors.white,
                                                              child: Column(
                                                                children: [
                                                                  Text(
                                                                    'StringAmount'
                                                                        .tr,
                                                                    style: ThemeHelper()
                                                                        .buildTextStyle(
                                                                        context,
                                                                        Colors
                                                                            .black,
                                                                        'M'),),
                                                                  Container(
                                                                    margin: EdgeInsets
                                                                        .only(
                                                                        left: 0.01 *
                                                                            height,
                                                                        right: 0.01 *
                                                                            height,
                                                                        bottom: 0.01 *
                                                                            height),
                                                                    child:
                                                                    TextFormField(
                                                                      style: ThemeHelper()
                                                                          .buildTextStyle(
                                                                          context,
                                                                          Colors
                                                                              .black,
                                                                          'M'),
                                                                      controller:
                                                                      controller
                                                                          .BMDDIController,
                                                                      keyboardType:
                                                                      TextInputType
                                                                          .number,
                                                                      textAlign:
                                                                      TextAlign
                                                                          .center,
                                                                      onChanged:
                                                                          (v) {
                                                                        if (v
                                                                            .isNotEmpty &&
                                                                            double
                                                                                .parse(
                                                                                v) >=
                                                                                0) {
                                                                          controller
                                                                              .Calculate_BMDDI_IR();
                                                                        }
                                                                        // else {
                                                                        //     controller.BMDDIController.text = '0';
                                                                        //     controller.SUMBMDDI = 0;
                                                                        //     controller.Calculate_BMDDI_IR();
                                                                        //   }
                                                                      },
                                                                    ),
                                                                  ),
                                                                  Text(
                                                                    controller
                                                                        .formatter
                                                                        .format(
                                                                        controller
                                                                            .SUMBMDDI)
                                                                        .toString(),
                                                                    style: ThemeHelper()
                                                                        .buildTextStyle(
                                                                        context,
                                                                        Colors
                                                                            .black,
                                                                        'M'),),
                                                                ],
                                                              ),
                                                            )),),
                                                      ],
                                                    ),
                                                    Text(
                                                      "${"StrinCount_BMDAMC"
                                                          .tr}                                                 ${controller
                                                          .formatter.format(
                                                          double.parse(controller
                                                              .BMDDITController
                                                              .text))}",
                                                      style: ThemeHelper()
                                                          .buildTextStyle(
                                                          context, Colors.white,
                                                          'L'),),
                                                  ],
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      )
                                          : (controller.PKID == 3 && controller
                                          .Allow_give_discount_Pay_due == '1' ||
                                          (controller
                                              .Allow_give_discount_Pay_due == '3'
                                              && controller
                                                  .UPIN_Allow_give_discount_Pay_due ==
                                                  1)) ?
                                      Card(
                                        elevation: 2,
                                        shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(
                                              0.02 * width),
                                        ),
                                        clipBehavior:
                                        Clip.antiAliasWithSaveLayer,
                                        child: Container(
                                          color: Colors.white,
                                          child: Column(
                                            children: [
                                              Container(
                                                width: double.infinity,
                                                color: Colors.red,
                                                padding: EdgeInsets.symmetric(
                                                    horizontal:
                                                    0.01 * height),
                                                child: Column(
                                                  children: [
                                                    Center(
                                                      child: Text(
                                                        "StringManual_Discount"
                                                            .tr,
                                                        style: ThemeHelper()
                                                            .buildTextStyle(
                                                            context, Colors.white,
                                                            'L'),),
                                                    ),
                                                    Row(
                                                      mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                      children: [
                                                        Expanded(child: Card(
                                                            elevation: 2,
                                                            clipBehavior: Clip
                                                                .antiAliasWithSaveLayer,
                                                            child: Container(
                                                              color: Colors.white,
                                                              child: Column(
                                                                children: [
                                                                  Text(
                                                                    'StringRate'
                                                                        .tr,
                                                                    style: ThemeHelper()
                                                                        .buildTextStyle(
                                                                        context,
                                                                        Colors
                                                                            .black,
                                                                        'M'),),
                                                                  Container(
                                                                    margin: EdgeInsets
                                                                        .only(
                                                                        left: 0.01 *
                                                                            height,
                                                                        right: 0.01 *
                                                                            height,
                                                                        bottom: 0.01 *
                                                                            height),
                                                                    child:
                                                                    TextFormField(
                                                                      style: ThemeHelper()
                                                                          .buildTextStyle(
                                                                          context,
                                                                          Colors
                                                                              .black,
                                                                          'M'),
                                                                      controller:
                                                                      controller
                                                                          .BMDDIRController,
                                                                      keyboardType:
                                                                      TextInputType
                                                                          .number,
                                                                      textAlign:
                                                                      TextAlign
                                                                          .center,
                                                                      onChanged:
                                                                          (v) {
                                                                        if (v
                                                                            .isNotEmpty &&
                                                                            double
                                                                                .parse(
                                                                                v) >=
                                                                                0) {
                                                                          controller
                                                                              .Calculate_BMDDI_IR();
                                                                        }
                                                                        // else{
                                                                        //   controller.BMDDIRController.text = '0';
                                                                        //   controller.SUMBMDDIR = 0;
                                                                        //   controller.Calculate_BMDDI_IR();
                                                                        // }
                                                                      },
                                                                    ),
                                                                  ),
                                                                  Text(
                                                                    controller
                                                                        .formatter
                                                                        .format(
                                                                        controller
                                                                            .SUMBMDDIR)
                                                                        .toString(),
                                                                    style: ThemeHelper()
                                                                        .buildTextStyle(
                                                                        context,
                                                                        Colors
                                                                            .black,
                                                                        'M'),),
                                                                ],
                                                              ),
                                                            ))),
                                                        Expanded(child: Card(
                                                            elevation: 2,
                                                            clipBehavior: Clip
                                                                .antiAliasWithSaveLayer,
                                                            child: Container(
                                                              color: Colors.white,
                                                              child: Column(
                                                                children: [
                                                                  Text(
                                                                    'StringAmount'
                                                                        .tr,
                                                                    style: ThemeHelper()
                                                                        .buildTextStyle(
                                                                        context,
                                                                        Colors
                                                                            .black,
                                                                        'M'),),
                                                                  Container(
                                                                    margin: EdgeInsets
                                                                        .only(
                                                                        left: 0.01 *
                                                                            height,
                                                                        right: 0.01 *
                                                                            height,
                                                                        bottom: 0.01 *
                                                                            height),
                                                                    child:
                                                                    TextFormField(
                                                                      style: ThemeHelper()
                                                                          .buildTextStyle(
                                                                          context,
                                                                          Colors
                                                                              .black,
                                                                          'M'),
                                                                      controller:
                                                                      controller
                                                                          .BMDDIController,
                                                                      keyboardType:
                                                                      TextInputType
                                                                          .number,
                                                                      textAlign:
                                                                      TextAlign
                                                                          .center,
                                                                      onChanged:
                                                                          (v) {
                                                                        if (v
                                                                            .isNotEmpty &&
                                                                            double
                                                                                .parse(
                                                                                v) >=
                                                                                0) {
                                                                          controller
                                                                              .Calculate_BMDDI_IR();
                                                                        }
                                                                        // else {
                                                                        //     controller.BMDDIController.text = '0';
                                                                        //     controller.SUMBMDDI = 0;
                                                                        //     controller.Calculate_BMDDI_IR();
                                                                        //   }
                                                                      },
                                                                    ),
                                                                  ),
                                                                  Text(
                                                                    controller
                                                                        .formatter
                                                                        .format(
                                                                        controller
                                                                            .SUMBMDDI)
                                                                        .toString(),
                                                                    style: ThemeHelper()
                                                                        .buildTextStyle(
                                                                        context,
                                                                        Colors
                                                                            .black,
                                                                        'M'),),
                                                                ],
                                                              ),
                                                            )),),
                                                      ],
                                                    ),
                                                    Text(
                                                      "${"StrinCount_BMDAMC"
                                                          .tr}                                                 ${controller
                                                          .formatter.format(
                                                          double.parse(controller
                                                              .BMDDITController
                                                              .text))}",
                                                      style: ThemeHelper()
                                                          .buildTextStyle(
                                                          context, Colors.white,
                                                          'L'),),
                                                  ],
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      )
                                          : (controller.PKID != 1 && controller.PKID != 3 && controller.Allow_give_discount_Pay_Not_Cash_Due == '1' ||
                                          (controller.Allow_give_discount_Pay_Not_Cash_Due == '3'
                                              && controller.UPIN_Allow_give_discount_Pay_Not_Cash_Due == 1)) ?
                                      Card(
                                        elevation: 2,
                                        shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(
                                              0.02 * width),
                                        ),
                                        clipBehavior:
                                        Clip.antiAliasWithSaveLayer,
                                        child: Container(
                                          color: Colors.white,
                                          child: Column(
                                            children: [
                                              Container(
                                                width: double.infinity,
                                                color: Colors.red,
                                                padding: EdgeInsets.symmetric(
                                                    horizontal:
                                                    0.01 * height),
                                                child: Column(
                                                  children: [
                                                    Center(
                                                      child: Text(
                                                        "StringManual_Discount"
                                                            .tr,
                                                        style: ThemeHelper()
                                                            .buildTextStyle(
                                                            context, Colors.white,
                                                            'L'),),
                                                    ),
                                                    Row(
                                                      mainAxisAlignment: MainAxisAlignment
                                                          .spaceBetween,
                                                      children: [
                                                        Expanded(child: Card(
                                                            elevation: 2,
                                                            clipBehavior: Clip
                                                                .antiAliasWithSaveLayer,
                                                            child: Container(
                                                              color: Colors.white,
                                                              child: Column(
                                                                children: [
                                                                  Text(
                                                                    'StringRate'
                                                                        .tr,
                                                                    style: ThemeHelper()
                                                                        .buildTextStyle(
                                                                        context,
                                                                        Colors
                                                                            .black,
                                                                        'M'),),
                                                                  Container(
                                                                    margin: EdgeInsets
                                                                        .only(
                                                                        left: 0.01 *
                                                                            height,
                                                                        right: 0.01 *
                                                                            height,
                                                                        bottom: 0.01 *
                                                                            height),
                                                                    child:
                                                                    TextFormField(
                                                                      style: ThemeHelper()
                                                                          .buildTextStyle(
                                                                          context,
                                                                          Colors
                                                                              .black,
                                                                          'M'),
                                                                      controller:
                                                                      controller
                                                                          .BMDDIRController,
                                                                      keyboardType:
                                                                      TextInputType
                                                                          .number,
                                                                      textAlign:
                                                                      TextAlign
                                                                          .center,
                                                                      onChanged:
                                                                          (v) {
                                                                        if (v
                                                                            .isNotEmpty &&
                                                                            double
                                                                                .parse(
                                                                                v) >=
                                                                                0) {
                                                                          controller
                                                                              .Calculate_BMDDI_IR();
                                                                        }
                                                                        // else{
                                                                        //   controller.BMDDIRController.text = '0';
                                                                        //   controller.SUMBMDDIR = 0;
                                                                        //   controller.Calculate_BMDDI_IR();
                                                                        // }
                                                                      },
                                                                    ),
                                                                  ),
                                                                  Text(
                                                                    controller
                                                                        .formatter
                                                                        .format(
                                                                        controller
                                                                            .SUMBMDDIR)
                                                                        .toString(),
                                                                    style: ThemeHelper()
                                                                        .buildTextStyle(
                                                                        context,
                                                                        Colors
                                                                            .black,
                                                                        'M'),),
                                                                ],
                                                              ),
                                                            )),),
                                                        Expanded(child: Card(
                                                            elevation: 2,
                                                            clipBehavior: Clip
                                                                .antiAliasWithSaveLayer,
                                                            child: Container(
                                                              color: Colors.white,
                                                              child: Column(
                                                                children: [
                                                                  Text(
                                                                    'StringAmount'
                                                                        .tr,
                                                                    style: ThemeHelper()
                                                                        .buildTextStyle(
                                                                        context,
                                                                        Colors
                                                                            .black,
                                                                        'M'),),
                                                                  Container(
                                                                    margin: EdgeInsets
                                                                        .only(
                                                                        left: 0.01 *
                                                                            height,
                                                                        right: 0.01 *
                                                                            height,
                                                                        bottom: 0.01 *
                                                                            height),
                                                                    child:
                                                                    TextFormField(
                                                                      style: ThemeHelper()
                                                                          .buildTextStyle(
                                                                          context,
                                                                          Colors
                                                                              .black, 'M'),
                                                                      controller: controller.BMDDIController,
                                                                      keyboardType: TextInputType.number,
                                                                      textAlign: TextAlign.center,
                                                                      onChanged: (v) {
                                                                        if (v.isNotEmpty && double.parse(v) >= 0) {
                                                                          controller.Calculate_BMDDI_IR();
                                                                        }
                                                                        // else {
                                                                        //     controller.BMDDIController.text = '0';
                                                                        //     controller.SUMBMDDI = 0;
                                                                        //     controller.Calculate_BMDDI_IR();
                                                                        //   }
                                                                      },
                                                                    ),
                                                                  ),
                                                                  Text(
                                                                    controller.formatter.format(
                                                                        controller.SUMBMDDI).toString(),
                                                                    style: ThemeHelper().buildTextStyle(
                                                                        context, Colors.black, 'M'),),
                                                                ],
                                                              ),
                                                            )),),

                                                      ],
                                                    ),
                                                    Text(
                                                        "${"StrinCount_BMDAMC"
                                                            .tr}                                                 ${controller
                                                            .formatter.format(
                                                            double.parse(
                                                                controller
                                                                    .BMDDITController
                                                                    .text))}",
                                                        style: ThemeHelper()
                                                            .buildTextStyle(
                                                            context, Colors.white,
                                                            'L')),
                                                  ],
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      )
                                          : Container()
                                          : Container(),
                                      controller.SVVL_TAX != '2'
                                          ? Card(
                                        elevation: 2,
                                        shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(
                                              0.02 * width),
                                        ),
                                        clipBehavior:
                                        Clip.antiAliasWithSaveLayer,
                                        child: Container(
                                          color: Colors.white,
                                          child: Column(
                                            children: [
                                              Container(
                                                width: double.infinity,
                                                color: Colors.red,
                                                padding: EdgeInsets.symmetric(
                                                    horizontal:
                                                    0.01 * height),
                                                child: Center(
                                                  child: Text(
                                                    "${'StringSUM_BMMTX'.tr}                                                          %${controller.formatter.format(controller.BMDTX).toString()}",
                                                    style: ThemeHelper()
                                                        .buildTextStyle(
                                                        context, Colors.white,
                                                        'L'),),
                                                ),
                                              ),
                                              Container(
                                                width: double.infinity,
                                                margin: EdgeInsets.only(
                                                    left: 0.01 * height,
                                                    right: 0.01 * height,
                                                    bottom: 0.01 * height),
                                                child: TextFormField(
                                                  style: ThemeHelper()
                                                      .buildTextStyle(
                                                      context, Colors.black, 'M'),
                                                  controller:
                                                  controller.BMDTXAController,
                                                  keyboardType:
                                                  TextInputType.number,
                                                  textAlign: TextAlign.center,
                                                  enabled: false,
                                                  decoration:
                                                  const InputDecoration(
                                                      hintStyle: TextStyle(
                                                          color:
                                                          Colors.blue)),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      )
                                          : Container(),
                                      Card(
                                        elevation: 2,
                                        shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(
                                              0.02 * width),
                                        ),
                                        clipBehavior: Clip.antiAliasWithSaveLayer,
                                        child: Container(
                                          color: Colors.white,
                                          child: Column(
                                            children: [
                                              Container(
                                                width: double.infinity,
                                                color: Colors.red,
                                                child: Center(
                                                  child: Text(
                                                    "StrinCount_BMDAMC".tr,
                                                    style: ThemeHelper()
                                                        .buildTextStyle(
                                                        context, Colors.white,
                                                        'L'),),
                                                ),
                                              ),
                                              Container(
                                                width: double.infinity,
                                                margin: EdgeInsets.only(
                                                    left: 0.01 * height,
                                                    right: 0.01 * height,
                                                    bottom: 0.01 * height),
                                                child: TextFormField(
                                                  style: ThemeHelper()
                                                      .buildTextStyle(
                                                      context, Colors.black, 'M'),
                                                  enabled: false,
                                                  textAlign: TextAlign.center,

                                                  controller:
                                                  controller.SUMBMDAMTController,
                                                  decoration: const InputDecoration(
                                                    enabledBorder: OutlineInputBorder(
                                                      borderSide: BorderSide(
                                                        color: Colors.white,
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              ),
                                              // Text("${controller.SUM_STRING_NUMBER} $SCNA")
                                            ],
                                          ),
                                        ),
                                      ),
                                      Container(
                                        width: MediaQuery.of(context).size.width / 0.5,
                                        margin: EdgeInsets.only(left: 0.01 * height, right: 0.01 * height),
                                        child: TextButton(
                                          style: ButtonStyle(
                                            shape: WidgetStateProperty.all<RoundedRectangleBorder>(
                                                RoundedRectangleBorder(
                                                    borderRadius: BorderRadius.circular(0.01 * height),
                                                    side: const BorderSide(color: Colors.black45))),
                                            padding: WidgetStateProperty.all<EdgeInsets>(
                                                EdgeInsets.only(left: 0.01 * height, right: 0.01 * height)),
                                          ),
                                          child: Text(
                                            controller.TextButton_title,
                                            style: ThemeHelper().buildTextStyle(
                                                context, Colors.black, 'M'),
                                          ),
                                          onPressed: () async {
                                            // _focusNode.requestFocus();
                                            // FocusScope.of(context).requestFocus(_focusNode);
                                            if (controller.When_Repeating_Same_inserted_Items_in_Invoice == '1' &&
                                                controller.COUNT_MINO > 0) {
                                              Get.defaultDialog(
                                                title: 'StringMestitle'.tr,
                                                middleText: 'StringCOUNT_MINO'.tr,
                                                backgroundColor: Colors.white,
                                                radius: 40,
                                                textCancel: 'StringNo'.tr,
                                                cancelTextColor: Colors.red,
                                                textConfirm: 'StringYes'.tr,
                                                confirmTextColor: Colors.white,
                                                onConfirm: () async {
                                                  if (controller.BMKID != 1 && controller.BMKID != 2 &&
                                                      controller.When_Selling_Items_Lower_Price_than_Cost_Price == '1' &&
                                                      double.parse(controller.MPCOController.text) > 0 &&
                                                      double.parse(controller.MPCOController.text) > controller.BMDAM1!) {
                                                    Navigator.of(context).pop(false);
                                                    Get.defaultDialog(
                                                      title: 'StringMestitle'.tr,
                                                      middleText: 'StringItems_Lower_Price'.tr,
                                                      backgroundColor: Colors.white,
                                                      radius: 40,
                                                      textCancel: 'StringNo'.tr,
                                                      cancelTextColor: Colors.red,
                                                      textConfirm: 'StringYes'.tr,
                                                      confirmTextColor: Colors.white,
                                                      onConfirm: () async {
                                                        if (controller.BMKID != 1 && controller.BMKID != 2 &&
                                                            controller.Use_lowest_selling_price == '1' && controller.MPLP! > 0
                                                            && controller.BMDAM1! < controller.MPLP!) {
                                                          Navigator.of(context).pop(false);
                                                          Get.defaultDialog(
                                                            title: 'StringMestitle'.tr,
                                                            middleText: 'StringUse_lowest_selling_price'.tr,
                                                            backgroundColor: Colors.white,
                                                            radius: 40,
                                                            textCancel: 'StringOK'.tr,
                                                            cancelTextColor: Colors.blueAccent,
                                                            barrierDismissible: false,
                                                          );
                                                        } else if (controller.BMKID != 1 && controller.BMKID != 2 &&
                                                            controller.Use_lowest_selling_price == '3' &&
                                                            controller.Allow_lowest_selling_price != 1 &&
                                                            controller.MPLP! > 0 && controller.BMDAM1! < controller.MPLP!) {
                                                          Navigator.of(context)
                                                              .pop(false);
                                                          Get.defaultDialog(
                                                            title: 'StringMestitle'.tr,
                                                            middleText: 'StringUse_lowest_selling_price'.tr,
                                                            backgroundColor: Colors.white,
                                                            radius: 40,
                                                            textCancel: 'StringOK'.tr,
                                                            cancelTextColor: Colors.blueAccent,
                                                            barrierDismissible: false,
                                                          );
                                                        } else {
                                                          if (controller.BMKID != 1 && controller.BMKID != 2 &&
                                                              controller.Use_highest_selling_price == '1' &&
                                                              controller.MPHP! > 0 && controller.BMDAM1! > controller.MPHP!) {
                                                            Navigator.of(context).pop(false);
                                                            Get.defaultDialog(
                                                              title: 'StringMestitle'.tr,
                                                              middleText: 'StringUse_highest_selling_price'.tr,
                                                              backgroundColor: Colors.white,
                                                              radius: 40,
                                                              textCancel: 'StringOK'.tr,
                                                              cancelTextColor: Colors.blueAccent,
                                                              barrierDismissible: false,
                                                            );
                                                          } else if (controller.BMKID != 1 &&controller. BMKID != 2 &&
                                                              controller. Use_highest_selling_price == '3' &&
                                                              controller.Allow_highest_selling_price != 1 &&
                                                              controller.MPHP! > 0 && controller.BMDAM1! > controller.MPHP!) {
                                                            Navigator.of(context).pop(false);
                                                            Get.defaultDialog(
                                                              title: 'StringMestitle'.tr,
                                                              middleText: 'StringUse_highest_selling_price'.tr,
                                                              backgroundColor:
                                                              Colors.white,
                                                              radius: 40,
                                                              textCancel: 'StringOK'.tr,
                                                              cancelTextColor: Colors.blueAccent,
                                                              barrierDismissible: false,
                                                            );
                                                          } else {
                                                            // Navigator.of(context).pop(false);
                                                            bool isValid = await controller
                                                                .Save_BIL_MOV_D_P();
                                                            if (isValid) {
                                                              controller.DataGrid();
                                                              controller.ClearBil_Mov_D_Data();
                                                              controller.minaFocusNode.requestFocus();
                                                            }
                                                          }
                                                        }
                                                      },
                                                      barrierDismissible: false,
                                                    );
                                                  } else if (controller.BMKID != 1 &&
                                                      controller.When_Selling_Items_Lower_Price_than_Cost_Price == '2' &&
                                                      double.parse(controller.MPCOController.text) > 0 &&
                                                      double.parse(controller.MPCOController.text) > controller.BMDAM1!) {
                                                    Navigator.of(context).pop(false);
                                                    Get.defaultDialog(
                                                      title: 'StringMestitle'.tr,
                                                      middleText: 'StringErr_Items_Lower_Price'.tr,
                                                      backgroundColor: Colors.white,
                                                      radius: 40,
                                                      textCancel: 'StringOK'.tr,
                                                      cancelTextColor: Colors.blueAccent,
                                                      barrierDismissible: false,
                                                    );
                                                  } else if (controller.BMKID != 1 && controller.BMKID != 2 &&
                                                      controller.When_Selling_Items_Lower_Price_than_Cost_Price == '4' &&
                                                      controller.Allowto_Sell_Less_than_Cost_Price != 1 &&
                                                      double.parse(controller.MPCOController.text) > 0 &&
                                                      double.parse(controller.MPCOController.text) >
                                                          controller.BMDAM1!) {
                                                    Navigator.of(context).pop(false);
                                                    Get.defaultDialog(
                                                      title: 'StringMestitle'.tr,
                                                      middleText: 'StringErr_Items_Lower_Price'.tr,
                                                      backgroundColor: Colors.white,
                                                      radius: 40,
                                                      textCancel: 'StringOK'.tr,
                                                      cancelTextColor: Colors.blueAccent,
                                                      barrierDismissible: false,
                                                    );
                                                  } else {
                                                    Navigator.of(context).pop(false);
                                                    if (controller.BMKID != 1 && controller.BMKID != 2 &&
                                                        controller.Use_lowest_selling_price == '1' &&
                                                        controller.MPLP! > 0 &&
                                                        controller.BMDAM1! < controller.MPLP!) {
                                                      Navigator.of(context).pop(false);
                                                      Get.defaultDialog(
                                                        title: 'StringMestitle'.tr,
                                                        middleText: 'StringUse_lowest_selling_price'.tr,
                                                        backgroundColor: Colors.white,
                                                        radius: 40,
                                                        textCancel: 'StringOK'.tr,
                                                        cancelTextColor: Colors.blueAccent,
                                                        barrierDismissible: false,
                                                      );
                                                    } else if (controller.BMKID != 1 && controller.BMKID != 2 &&
                                                        controller.Use_lowest_selling_price == '3' &&
                                                        controller.Allow_lowest_selling_price != 1 &&
                                                        controller.MPLP! > 0 &&
                                                        controller.BMDAM1! < controller.MPLP!) {
                                                      Navigator.of(context).pop(false);
                                                      Get.defaultDialog(
                                                        title: 'StringMestitle'.tr,
                                                        middleText: 'StringUse_lowest_selling_price'.tr,
                                                        backgroundColor: Colors.white,
                                                        radius: 40,
                                                        textCancel: 'StringOK'.tr,
                                                        cancelTextColor: Colors.blueAccent,
                                                        barrierDismissible: false,
                                                      );
                                                    } else {
                                                      if (controller.BMKID != 1 && controller.BMKID != 2 &&
                                                          controller.Use_highest_selling_price == '1' &&
                                                          controller.MPHP! > 0 &&
                                                          controller.BMDAM1! > controller.MPHP!) {
                                                        Navigator.of(context).pop(false);
                                                        Get.defaultDialog(
                                                          title: 'StringMestitle'.tr,
                                                          middleText: 'StringUse_highest_selling_price'.tr,
                                                          backgroundColor:
                                                          Colors.white,
                                                          radius: 40,
                                                          textCancel: 'StringOK'.tr,
                                                          cancelTextColor: Colors.blueAccent,
                                                          barrierDismissible: false,
                                                        );
                                                      } else if (controller.BMKID != 1 && controller.BMKID != 2 &&
                                                          controller.Use_highest_selling_price == '3' &&
                                                          controller.Allow_highest_selling_price != 1 && controller.MPHP! > 0 &&
                                                          controller.BMDAM1! > controller.MPHP!) {
                                                        Navigator.of(context).pop(false);
                                                        Get.defaultDialog(
                                                          title: 'StringMestitle'.tr,
                                                          middleText:
                                                          'StringUse_highest_selling_price'.tr,
                                                          backgroundColor:
                                                          Colors.white,
                                                          radius: 40,
                                                          textCancel: 'StringOK'.tr,
                                                          cancelTextColor:
                                                          Colors.blueAccent,
                                                          barrierDismissible: false,
                                                        );
                                                      } else {
                                                        // Navigator.of(context).pop(false);

                                                        bool isValid = await controller
                                                            .Save_BIL_MOV_D_P();
                                                        if (isValid) {
                                                          controller.DataGrid();
                                                          controller.ClearBil_Mov_D_Data();
                                                        }
                                                      }
                                                    }
                                                  }
                                                },
                                                barrierDismissible: false,
                                              );
                                            } else if (controller.When_Repeating_Same_inserted_Items_in_Invoice == '3' &&
                                                controller.COUNT_MINO > 0) {
                                              Get.defaultDialog(
                                                title: 'StringMestitle'.tr,
                                                middleText: 'StringErr_COUNT_MINO'.tr,
                                                backgroundColor: Colors.white,
                                                radius: 40,
                                                textCancel: 'StringOK'.tr,
                                                cancelTextColor: Colors.blueAccent,
                                                barrierDismissible: false,
                                              );
                                            } else {
                                              if (controller.BMKID != 1 && controller.BMKID != 2  && controller.When_Selling_Items_Lower_Price_than_Cost_Price == '1' &&
                                                  double.parse(controller.MPCOController.text) > 0 &&
                                                  double.parse(controller.MPCOController.text) > controller.BMDAM1!) {
                                                Get.defaultDialog(
                                                  title: 'StringMestitle'.tr,
                                                  middleText: 'StringItems_Lower_Price'.tr,
                                                  backgroundColor: Colors.white,
                                                  radius: 40,
                                                  textCancel: 'StringNo'.tr,
                                                  cancelTextColor: Colors.red,
                                                  textConfirm: 'StringYes'.tr,
                                                  confirmTextColor: Colors.white,
                                                  onConfirm: () async {
                                                    if (controller.BMKID != 1 && controller.BMKID != 2 &&
                                                        controller.Use_lowest_selling_price == '1' &&
                                                        controller.MPLP! > 0 &&
                                                        controller.BMDAM1! < controller.MPLP!) {
                                                      Navigator.of(context).pop(false);
                                                      Get.defaultDialog(
                                                        title: 'StringMestitle'.tr,
                                                        middleText: 'StringUse_lowest_selling_price'.tr,
                                                        backgroundColor: Colors.white,
                                                        radius: 40,
                                                        textCancel: 'StringOK'.tr,
                                                        cancelTextColor: Colors.blueAccent,
                                                        barrierDismissible: false,
                                                      );
                                                    } else if (controller.BMKID != 1 && controller.BMKID != 2 &&
                                                        controller.Use_lowest_selling_price == '3' &&
                                                        controller.Allow_lowest_selling_price != 1 && controller.MPLP! > 0 &&
                                                        controller.BMDAM1! < controller.MPLP!) {
                                                      Navigator.of(context).pop(false);
                                                      Get.defaultDialog(
                                                        title: 'StringMestitle'.tr,
                                                        middleText: 'StringUse_lowest_selling_price'.tr,
                                                        backgroundColor: Colors.white,
                                                        radius: 40,
                                                        textCancel: 'StringOK'.tr,
                                                        cancelTextColor: Colors.blueAccent,
                                                        barrierDismissible: false,
                                                      );
                                                    } else {
                                                      if (controller.BMKID != 1 && controller.BMKID != 2 &&
                                                          controller.Use_highest_selling_price == '1' && controller.MPHP! > 0 &&
                                                          controller.BMDAM1! > controller.MPHP!) {
                                                        Navigator.of(context)
                                                            .pop(false);
                                                        Get.defaultDialog(
                                                          title: 'StringMestitle'.tr,
                                                          middleText: 'StringUse_highest_selling_price'.tr,
                                                          backgroundColor:
                                                          Colors.white,
                                                          radius: 40,
                                                          textCancel: 'StringOK'.tr,
                                                          cancelTextColor: Colors.blueAccent,
                                                          barrierDismissible: false,
                                                        );
                                                      } else if (controller.BMKID != 1 && controller.BMKID != 2 &&
                                                          controller.Use_highest_selling_price == '3' &&
                                                          controller.Allow_highest_selling_price != 1 &&
                                                          controller.MPHP! > 0 && controller.BMDAM1! > controller.MPHP!) {
                                                        Navigator.of(context).pop(false);
                                                        Get.defaultDialog(
                                                          title: 'StringMestitle'.tr,
                                                          middleText:
                                                          'StringUse_highest_selling_price'.tr,
                                                          backgroundColor:
                                                          Colors.white,
                                                          radius: 40,
                                                          textCancel: 'StringOK'.tr,
                                                          cancelTextColor: Colors.blueAccent,
                                                          barrierDismissible: false,
                                                        );
                                                      } else {
                                                        Navigator.of(context).pop(false);
                                                        bool isValid = await controller.Save_BIL_MOV_D_P();
                                                        if (isValid) {
                                                          controller.DataGrid();
                                                          controller.ClearBil_Mov_D_Data();
                                                        }
                                                      }
                                                    }
                                                  },
                                                  barrierDismissible: false,
                                                );
                                              } else if (controller.BMKID != 1 && controller.BMKID != 2 &&
                                                  controller.When_Selling_Items_Lower_Price_than_Cost_Price == '2' &&
                                                  double.parse(controller.MPCOController.text) > 0 &&
                                                  double.parse(controller.MPCOController.text) > controller.BMDAM1!) {
                                                Get.defaultDialog(
                                                  title: 'StringMestitle'.tr,
                                                  middleText: 'StringErr_Items_Lower_Price'.tr,
                                                  backgroundColor: Colors.white,
                                                  radius: 40,
                                                  textCancel: 'StringOK'.tr,
                                                  cancelTextColor: Colors.blueAccent,
                                                  barrierDismissible: false,
                                                );
                                              } else if (controller.BMKID != 1 && controller.BMKID != 2 &&
                                                  controller.When_Selling_Items_Lower_Price_than_Cost_Price == '4' &&
                                                  controller.Allowto_Sell_Less_than_Cost_Price != 1 &&
                                                  double.parse(controller.MPCOController.text) > 0 &&
                                                  double.parse(controller.MPCOController.text) > controller.BMDAM1!) {
                                                Get.defaultDialog(
                                                  title: 'StringMestitle'.tr,
                                                  middleText: 'StringErr_Items_Lower_Price'
                                                      .tr,
                                                  backgroundColor: Colors.white,
                                                  radius: 40,
                                                  textCancel: 'StringOK'.tr,
                                                  cancelTextColor: Colors
                                                      .blueAccent,
                                                  barrierDismissible: false,
                                                );
                                              } else {
                                                if (controller.BMKID != 1 && controller.BMKID != 2 &&
                                                    controller.Use_lowest_selling_price == '1' && controller.MPLP! > 0 &&
                                                    controller.BMDAM1! < controller.MPLP!) {
                                                  Get.defaultDialog(
                                                    title: 'StringMestitle'.tr,
                                                    middleText: 'StringUse_lowest_selling_price'.tr,
                                                    backgroundColor: Colors.white,
                                                    radius: 40,
                                                    textCancel: 'StringOK'.tr,
                                                    cancelTextColor:
                                                    Colors.blueAccent,
                                                    barrierDismissible: false,
                                                  );
                                                } else if (controller.BMKID != 1 && controller.BMKID != 2 &&
                                                    controller.Use_lowest_selling_price == '3' &&
                                                    controller. Allow_lowest_selling_price != 1 &&
                                                    controller.MPLP! > 0 && controller.BMDAM1! < controller.MPLP!) {
                                                  Get.defaultDialog(
                                                    title: 'StringMestitle'.tr,
                                                    middleText:
                                                    'StringUse_lowest_selling_price'
                                                        .tr,
                                                    backgroundColor: Colors.white,
                                                    radius: 40,
                                                    textCancel: 'StringOK'.tr,
                                                    cancelTextColor:
                                                    Colors.blueAccent,
                                                    barrierDismissible: false,
                                                  );
                                                } else {
                                                  if (controller.BMKID != 1 && controller.BMKID != 2 &&
                                                      controller.Use_highest_selling_price == '1' &&
                                                      controller.MPHP! > 0 && controller.BMDAM1! > controller.MPHP!) {
                                                    Get.defaultDialog(
                                                      title: 'StringMestitle'.tr,
                                                      middleText: 'StringUse_highest_selling_price'.tr,
                                                      backgroundColor: Colors.white,
                                                      radius: 40,
                                                      textCancel: 'StringOK'.tr,
                                                      cancelTextColor: Colors.blueAccent,
                                                      barrierDismissible: false,
                                                    );
                                                  } else if (controller.BMKID != 1 && controller.BMKID != 2 &&
                                                      controller.Use_highest_selling_price == '3' &&
                                                      controller.Allow_highest_selling_price != 1 &&
                                                      controller.MPHP! > 0 && controller.BMDAM1! > controller.MPHP!) {
                                                    Get.defaultDialog(
                                                      title: 'StringMestitle'.tr,
                                                      middleText:
                                                      'StringUse_highest_selling_price'
                                                          .tr,
                                                      backgroundColor: Colors
                                                          .white,
                                                      radius: 40,
                                                      textCancel: 'StringOK'.tr,
                                                      cancelTextColor:
                                                      Colors.blueAccent,
                                                      barrierDismissible: false,
                                                    );
                                                  } else {
                                                    //  Navigator.of(context).pop(false);
                                                    bool isValid = await controller.Save_BIL_MOV_D_P();
                                                    if (isValid) {
                                                      controller.DataGrid();
                                                      controller.ClearBil_Mov_D_Data();
                                                    }
                                                  }
                                                }
                                              }
                                            }
                                          },
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ))
                        ],
                      ),
                    ),
                  ),
                )));
      }),
    );
  }

  List<Mat_Inf_Local> _filterOptions(String query) {
    return StteingController().SHOW_ITEM == true || StteingController().SHOW_ITEM_C == true
        ? controller.autoCompleteData.where((county) =>
        "${county.MGNO ?? ''}${county.MINA_D ?? ''}${county.MINO ?? ''}${county.MUNA_D ?? ''}${county.MUCBC ?? ''}${county.MPS1 ?? ''}${county.MPS2 ?? ''}"
            .toLowerCase()
            .contains(query.toLowerCase()))
        .toList().obs
        : controller.autoCompleteData.where((county) =>
        "${county.MINA_D ?? ''}${county.MINO ?? ''}"
            .toLowerCase()
            .contains(query.toLowerCase())).toList().obs;
  }


  Widget _buildTextField(BuildContext context,
      TextEditingController textEditingController, FocusNode focusNode) {
    final isEmpty = controller.MINAController.text.isEmpty;
    return TextFormField(
      controller: isEmpty ? textEditingController : controller.MINAController,
      focusNode: focusNode,
      autofocus: isEmpty,
      validator: (value) => controller.validateMINO(value!),
      textAlign: TextAlign.center,
      style: ThemeHelper().buildTextStyle(context, Colors.black, 'M'),
      decoration: InputDecoration(
        labelText: 'StringMINO'.tr,
        hintText: StteingController().SHOW_ITEM == true ||
            StteingController().SHOW_ITEM_C == true
            ? 'StringSearch_for_MINO_MGNO'.tr
            : 'StringMINO'.tr,
        suffixIcon: isEmpty
            ? null
            : IconButton(
          icon: const Icon(Icons.clear, color: Colors.black),
          onPressed: () {
            _clearField(textEditingController, focusNode);
          },
        ),
        icon: isEmpty
            ? null
            : IconButton(
          icon: const Icon(Icons.error, color: Colors.black),
          onPressed: () {
            _showDetailsDialog(context);
          },
        ),
      ),
    );
  }


  void _clearField(TextEditingController textEditingController, FocusNode focusNode) {
    textEditingController.clear();
    controller.ClearBil_Mov_D_Data();
    focusNode.requestFocus();
    controller.update();
  }

  void _showDetailsDialog(BuildContext context) {
    if (controller.SelectDataMUID?.isNotEmpty ?? false) {
      Get.defaultDialog(
        title: '${controller.MINAController.text}. ${controller.SelectDataMUCNA}',
        backgroundColor: Colors.white,
        radius: 30,
        content: _buildDetailsDialogContent(context),
        textCancel: 'StringHide'.tr,
        cancelTextColor: Colors.blueAccent,
      );
    }
  }

  Widget _buildDetailsDialogContent(BuildContext context) {
    final details = [
      'StringMgno2',
      'String_BDNO_F',
      'String_BDNO_F2',
      'String_SCEX',
      'String_SCEXS',
      if (controller.UPIN_PRI == 1) 'StringCost_Price',
      'String_MPHP',
      'String_MPLP',
    ];
    final values = [
      controller.MGNA,
      controller.formatter.format(controller.BDNO_F),
      controller.formatter.format(controller.BDNO_F2),
      controller.formatter.format(double.parse(controller.SCEXController.text)),
      controller.formatter.format(controller.SCEXS),
      if (controller.UPIN_PRI == 1) controller.formatter.format(controller.MPCO),
      controller.formatter.format(controller.MPHP),
      controller.formatter.format(controller.MPLP),
    ];
    return Row(
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: details.map((detail) =>
              Text(
                '${detail.tr}:',
                style: ThemeHelper().buildTextStyle(
                    context, Colors.black87, 'M'),
              ))
              .toList(),
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: values.map((value) =>
              Text(
                value,
                style: ThemeHelper().buildTextStyle(context, Colors.black, 'M'),
              ))
              .toList(),
        ),
      ],
    );
  }

  Future<void> _handleSelection(Mat_Inf_Local selection) async {
    controller.SelectDataMINO = selection.MINO.toString();
    controller.MGNOController.text = selection.MGNO.toString();
    controller.SelectDataMUID = null;
    controller.SelectDataSNED = null;
    controller.MITSK = selection.MITSK;
    controller.MGKI = selection.MGKI;
    controller.GUIDMT = selection.GUID;
    controller.update();
    if (StteingController().SHOW_ITEM == true ||
        StteingController().SHOW_ITEM_C == true) {
      controller.SelectDataMUID = selection.MUID.toString();
      controller.SIID_V2 = controller.SelectDataSIID.toString();
      await controller.GETSNDE_ONE();
      if(controller.BMKID==1){
        controller.BMDAMController.text ='0';
      }else{
        controller.BMDAMController.text = controller.BCPR == 2 ? selection.MPS2.toString() :
        controller.BCPR == 3 ? selection.MPS3.toString() : controller.BCPR == 4
            ? selection.MPS4.toString()
            : selection.MPS1.toString();
      }
      controller.SelectDataMUCNA = selection.MUNA_D.toString();
      controller.MPS1 = double.parse(controller.BMDAMController.text);
    } else {
      await controller.GETMUIDS();
    }
    controller.MINAController.text = selection.MINA_D.toString();
    controller.MIED = selection.MIED;
    controller.BMDNOController.text = '';
    controller.BMDNO_V = 0;
    controller.BMDNFController.text = '0';
    controller.SUMBMDAMController.text = '0';
    controller.BMDDIRController.text = '0';
    controller.BMDDIController.text = '0';
    if (controller.TTID1 != null) {
      await controller.GET_TAX_LIN_P('MAT', selection.MGNO.toString(),
          selection.MINO.toString());
    }
    controller.update();
    controller.myFocusNode.requestFocus();
  }

  Widget _buildOptionsList(BuildContext context, Iterable<Mat_Inf_Local> options,
      AutocompleteOnSelected<Mat_Inf_Local> onSelected) {
    return GetBuilder<Sale_Invoices_Controller>(
        builder: ((controller) =>
            Align(
              alignment: Alignment.topLeft,
              child: Container(
                width: double.infinity,
                height: (options.length * 100.0).clamp(150.0, 0.4 * MediaQuery.of(context).size.height),
                decoration: BoxDecoration(
                  color: Colors.white,
                  border: Border.all(color: Colors.grey),
                  borderRadius: BorderRadius.circular(8.0),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.5),
                      spreadRadius: 1,
                      blurRadius: 5,
                      offset: Offset(0, 3),
                    ),
                  ],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // رأس الجدول الثابت باستخدام Table
                    if(StteingController().SHOW_ITEM == true )
                      controller.BMKID==1?
                      Table(
                        // border: TableBorder.all(color: Colors.grey),
                        columnWidths: {
                          0: const FixedColumnWidth(260), // عرض ثابت للصنف
                          1: const FractionColumnWidth(0.25), // عرض مرن للوحدة
                        },
                        children: [
                          TableRow(
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text(
                                  "StringMINO".tr,
                                  style: TextStyle(fontWeight: FontWeight.bold,
                                      color: Colors.black),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text(
                                  "StringMUID".tr,
                                  style: TextStyle(fontWeight: FontWeight.bold,
                                      color: Colors.black),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ):
                      Table(
                        // border: TableBorder.all(color: Colors.grey),
                        columnWidths: {
                          0: const FixedColumnWidth(197), // عرض ثابت للصنف
                          1: const FractionColumnWidth(0.21), // عرض مرن للوحدة
                          2: const FixedColumnWidth(110), // عرض ثابت للسعر
                        },
                        children: [
                          TableRow(
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text(
                                  "StringMINO".tr,
                                  style: TextStyle(fontWeight: FontWeight.bold,
                                      color: Colors.black),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text(
                                  "StringMUID".tr,
                                  style: TextStyle(fontWeight: FontWeight.bold,
                                      color: Colors.black),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text(
                                  "StringPrice".tr,
                                  style: TextStyle(fontWeight: FontWeight.bold,
                                      color: Colors.black),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    Expanded(child: ListView.builder(
                      itemCount: options.length,
                      itemBuilder: (context, index) {
                        final option = options.elementAt(index);
                        return StteingController().SHOW_ITEM_C == true ?
                        GestureDetector(
                          onTap: () => onSelected(option),
                          child: Card(
                            margin: EdgeInsets.symmetric(
                                vertical: 3, horizontal: 4),
                            elevation: 2,
                            child: Container(
                              color: Colors.grey[30],
                              padding: const EdgeInsets.all(8),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "${option.MGNO} - (${option.MINO}-${option.MINA_D})",
                                    style: TextStyle(color: Colors.black),
                                  ),
                                  SizedBox(height: 5),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                                    children: [
                                      Text("${'StringMUID'.tr}: ${option.MUNA_D}", // استبدل `unit` بالمفتاح الصحيح للوحدة
                                      ),
                                      Text(
                                        "${'StringPrice'.tr}: ${controller.formatter.format(
                                            controller.BCPR == 2 ? option.MPS2 : controller.BCPR == 3
                                                ? option.MPS3
                                                : controller.BCPR == 4
                                                ? option.MPS4
                                                : option.MPS1).toString()}",
                                        // استبدل `price` بالمفتاح الصحيح للسعر
                                        style: TextStyle(color: Colors.red),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ) :
                        StteingController().SHOW_ITEM == true ?
                        controller.BMKID==1?
                        GestureDetector(
                          onTap: () => onSelected(option),
                          child: Table(
                            // border: TableBorder.all(color: Colors.grey),
                            columnWidths: {
                              0: FixedColumnWidth(120), // عرض ثابت للصنف
                              1: FractionColumnWidth(0.02), // عرض مرن للوحدة
                            },
                            children: [
                              TableRow(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.all(6.0),
                                    child: Text(
                                      "${option.MGNO} - (${option.MINO}-${option.MINA_D.toString()})",),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(6.0),
                                    child: Text("${option.MUNA_D}",),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        )
                            :GestureDetector(
                          onTap: () => onSelected(option),
                          child: Table(
                            // border: TableBorder.all(color: Colors.grey),
                            columnWidths: {
                              0: FixedColumnWidth(120), // عرض ثابت للصنف
                              1: FractionColumnWidth(0.02), // عرض مرن للوحدة
                              2: FixedColumnWidth(50), // عرض ثابت للسعر
                            },
                            children: [
                              TableRow(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.all(6.0),
                                    child: Text(
                                      "${option.MGNO} - (${option.MINO}-${option
                                          .MINA_D})",),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(6.0),
                                    child: Text("${option.MUNA_D}",),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(6.0),
                                    child: Text("${controller.formatter.format(
                                        controller.BCPR == 2 ? option.MPS2 : controller.BCPR == 3 ? option.MPS3
                                            : controller.BCPR == 4 ? option.MPS4 : option.MPS1).toString()}",
                                        style: TextStyle(color: Colors.red)),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        )
                            : GestureDetector(
                          onTap: () => onSelected(option),
                          child: Padding(
                            padding: EdgeInsets.all(6.0),
                            child: Text(
                              option.MINA_D,
                              textAlign: TextAlign.center,
                              style: const TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                        );
                      },
                    ),),
                  ],
                ),
              ),
            )));
  }

  GetBuilder<Sale_Invoices_Controller> DropdownMAT_GROBuilder() {
    return GetBuilder<Sale_Invoices_Controller>(
        init: Sale_Invoices_Controller(),
        builder: ((controller) =>
            FutureBuilder<List<Mat_Gro_Local>>(
                future: GET_MAT_GRO(),
                builder: (BuildContext context,
                    AsyncSnapshot<List<Mat_Gro_Local>> snapshot) {
                  if (!snapshot.hasData) {
                    return Dropdown(
                      josnStatus: josnStatus,
                      GETSTRING: 'StringBrach',
                    );
                  }
                  return DropdownButtonFormField2(
                    isDense: true,
                    isExpanded: true,
                    hint: ThemeHelper().buildText(
                        context, 'StringMgno', Colors.grey, 'S'),
                    dropdownStyleData: const DropdownStyleData(
                      maxHeight: 250,
                    ),
                    items: snapshot.data!.map((item) =>
                        DropdownMenuItem<String>(
                          value: "${item.MGNO.toString() + " +++ " +
                              item.MGNA_D.toString()}",
                          // value: item.MGNO.toString(),
                          child: Text(
                            item.MGNA_D.toString(),
                            style: ThemeHelper().buildTextStyle(
                                context, Colors.black, 'M'),
                          ),
                        ))
                        .toList()
                        .obs,
                    value: controller.SelectDataMGNO2,
                    onChanged: (value) async {
                      controller.ClearBil_Mov_D_Data();
                      controller.update();
                      controller.MGNOController.text =
                      value.toString().split(" +++ ")[0];
                      controller.SelectDataMGNO =
                      value.toString().split(" +++ ")[0];
                      controller.SelectDataMGNO2 = value.toString();
                      await controller.fetchAutoCompleteData(
                          StteingController().SHOW_ITEM == true ||
                              StteingController().SHOW_ITEM_C == true ? 2 : 1,
                          '2');
                      controller.update();
                    },
                    dropdownSearchData: DropdownSearchData(
                        searchController: controller
                            .TextEditingSercheController,
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
                              hintText: 'StringSearch_for_MGNO'.tr,
                              hintStyle: ThemeHelper().buildTextStyle(
                                  context, Colors.grey, 'S'),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(8),
                              ),
                            ),
                          ),
                        ),
                        searchMatchFn: (item, searchValue) {
                          return (item.value.toString().toLowerCase().contains(
                              searchValue));
                        },
                        searchInnerWidgetHeight: 50),

                    //This to clear the search value when you close the menu
                    onMenuStateChange: (isOpen) {
                      if (!isOpen) {
                        controller.TextEditingSercheController.clear();
                      }
                    },
                  );
                })));
  }

  FutureBuilder<List<Mat_Uni_C_Local>> DropdownMat_Uni_CBuilder() {
    return FutureBuilder<List<Mat_Uni_C_Local>>(
        future: GetMat_Uni_C(
            controller.MGNOController.text.toString(), controller.SelectDataMINO.toString()),
        builder: (BuildContext context,
            AsyncSnapshot<List<Mat_Uni_C_Local>> snapshot) {
          if (!snapshot.hasData) {
            return Dropdown2(josnStatus: josnStatus);
          }
          return DropdownButtonFormField2(
            isExpanded: true,
            hint: ThemeHelper().buildText(
                context, 'StringMUID', Colors.grey, 'S'),
            value: controller.SelectDataMUID,
            style: ThemeHelper().buildTextStyle(context, Colors.black, 'M'),
            items: snapshot.data!
                .map((item) =>
                DropdownMenuItem<String>(
                  onTap: () {
                    controller.SelectDataMUCNA = item.MUNA_D.toString();
                    controller.update();
                  },
                  value: item.MUID.toString(),
                  child: Text(
                    '${item.MUNA_D.toString()}   ',
                    style: ThemeHelper().buildTextStyle(
                        context, Colors.black, 'M'),
                  ),
                )).toList().obs,
            validator: (value) {
              if (value == null) {
                return 'StringvalidateMUID'.tr;
              }
              return null;
            },
            onChanged: (value) async {
              controller.SelectDataMUID = value.toString();
              controller.SelectDataSNED = null;
              controller.SelectDataMUCNA = null;
              controller.SelectDataMUCNA = '';
              controller.BMDAMController.clear();
              controller.BMDINController.clear();
              controller.BMDEDController.clear();
              controller.SUMBMDAMController.clear();
              controller.MPCOController.clear();
              controller.MPCO_VController.clear();
              controller.BMDTXAController.clear();
              controller.BMDAMController.text = '0';
              controller.BMDAMTXController.text = '0';
              controller.SUMBMDAMController.text = '0';
              controller.BMDTXAController.text = '0';
              controller.MPCOController.text = '0';
              controller.MPCO_VController.text = '0';
              controller.SUMBMDAMTController.text = '0';
              controller.SUMBMDAM = 0;
              controller.SUM_BMDAM = 0;
              controller.BMDAM1 = 0;
              controller.SUM_BMDAM2 = 0;
              controller.BMDAM2 = 0;
              controller.MPS1 = 0;
              controller.BDNO_F = 0;
              controller.BDNO_F2 = 0;
              controller.BMDTXTController.text = '0';
              controller.SUMBMDAMTFController.text = '0';
              controller.MPS1Controller.text = '0';
              controller.MPS2Controller.text = '0';
              controller.MPS3Controller.text = '0';
              controller.MPS4Controller.text = '0';
              controller.CHIN_NO = 1;
              controller.MPCO_V = 0;
              controller.MPCO = 0;
              controller.BMDNO = 0;
              controller.V_FROM = 0;
              controller.V_TO = 0;
              controller.V_KIN = 0;
              controller.V_N1 = 0;
              controller.update();
              await controller.GETSNDE_ONE();
              controller.myFocusNode.requestFocus();
              Timer(const Duration(seconds: 1), () async {
                await controller.Calculate_BMD_NO_AM();
               controller.update();
              });
            },
          );
        });
  }

  GetBuilder<Sale_Invoices_Controller> DropdownMat_Date_endBuilder() {
    return GetBuilder<Sale_Invoices_Controller>(
        init: Sale_Invoices_Controller(),
        builder: ((controller) =>
            FutureBuilder<List<Sto_Num_Local>>(
                future: GET_SMDED(
                    controller.MGNOController.text.toString(),
                    controller.SelectDataMINO.toString(),
                    controller.SIID_V2.toString(),
                    controller.SelectDataMUID.toString()),
                builder: (BuildContext context,
                    AsyncSnapshot<List<Sto_Num_Local>> snapshot) {
                  if (!snapshot.hasData) {
                    return Dropdown2(josnStatus: josnStatus);
                  }
                  return DropdownButtonFormField2(
                    isExpanded: true,
                    hint: ThemeHelper().buildText(
                        context, 'StringSMDED', Colors.grey, 'S'),
                    value: snapshot.data!.any((item) =>
                    item.SNED.toString() == controller.SelectDataSNED)
                        ? controller.SelectDataSNED : null,
                    style: ThemeHelper().buildTextStyle(
                        context, Colors.black, 'M'),
                    items: snapshot.data!.map((item) =>
                        DropdownMenuItem<String>(
                          value: item.SNED.toString(),
                          child: Text(
                            item.SNED.toString(),
                            style: ThemeHelper().buildTextStyle(
                                context, Colors.black, 'M'),
                          ),
                        )).toList().obs,
                    onChanged: (value) {
                      controller.SelectDataSNED = value.toString();
                      Timer(const Duration(milliseconds: 90), () {
                        controller.myFocusNode.requestFocus();
                      });
                      controller.update();
                    },
                  );
                })));
  }

  GetBuilder<Sale_Invoices_Controller> DropdownSTO_INF_DBuilder() {
    return GetBuilder<Sale_Invoices_Controller>(
        init: Sale_Invoices_Controller(),
        builder: ((controller) =>
            FutureBuilder<List<Sto_Inf_Local>>(
                future: Get_STO_INF(
                    controller.BMKID!,
                    controller.SelectDataBIID.toString(),
                    controller.SelectDataBPID.toString()),
                builder: (BuildContext context,
                    AsyncSnapshot<List<Sto_Inf_Local>> snapshot) {
                  if (!snapshot.hasData) {
                    return Dropdown(
                      josnStatus: josnStatus,
                      GETSTRING: 'StringStoch',
                    );
                  }
                  return DropdownButtonFormField2(
                    decoration: ThemeHelper().InputDecorationDropDown(
                        'StringSIIDlableText'.tr),
                    isExpanded: true,
                    hint: ThemeHelper().buildText(
                        context, 'StringStoch', Colors.grey, 'S'),
                    value: controller.SIID_V2,
                    style: ThemeHelper().buildTextStyle(
                        context, Colors.black, 'M'),
                    items: snapshot.data!
                        .map((item) =>
                        DropdownMenuItem<String>(
                          value: item.SIID.toString(),
                          child: Text(
                            item.SINA_D.toString(),
                            style: ThemeHelper().buildTextStyle(
                                context, Colors.black, 'M'),
                          ),
                        )).toList().obs,
                    validator: (value) {
                      if (value == null) {
                        return 'StringStoch'.tr;
                      }
                      return null;
                    },
                    onChanged: (value) async {
                      //Do something when changing the item if you want.
                      controller.SIID_V2 = value.toString();
                      await controller.GETSNDE_ONE();
                      controller.update();
                    },
                    dropdownStyleData: const DropdownStyleData(
                      maxHeight: 400,
                    ),
                  );
                })));
  }

  Future<dynamic> buildShowMPS1(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    return Get.defaultDialog(
      title: "",
      content: Padding(
        padding: EdgeInsets.only(right: 0.02 * height, left: 0.02 * height),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                ThemeHelper().buildText(
                    context, 'StringMPS1', Colors.black, 'M'),
                Expanded(
                  child: TextFormField(
                    readOnly: true,
                    textAlign: TextAlign.center,
                    controller:controller.MPS1Controller,
                    onTap: () async {
                      controller.BMDAMController.text = controller.MPS1Controller.text;
                      controller.MPS1 = double.parse(controller.MPS1Controller.text);
                      Navigator.of(context).pop(false);
                      await Future.delayed(const Duration(milliseconds: 600));
                      controller.Calculate_BMD_NO_AM();
                      controller.update();
                    },
                  ),
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                ThemeHelper().buildText(
                    context, 'StringMPS2', Colors.black, 'M'),
                Expanded(
                  child: TextFormField(
                    readOnly: true,
                    textAlign: TextAlign.center,
                    controller: controller.MPS2Controller,
                    onTap: () async {
                      controller.BMDAMController.text = controller.MPS2Controller.text;
                      controller.MPS1 = double.parse(controller.MPS2Controller.text);
                      Navigator.of(context).pop(false);
                      await Future.delayed(const Duration(milliseconds: 600));
                      controller.Calculate_BMD_NO_AM();
                      controller.update();
                    },
                  ),
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                ThemeHelper().buildText(
                    context, 'StringMPS3', Colors.black, 'M'),
                Expanded(
                  child: TextFormField(
                    readOnly: true,
                    textAlign: TextAlign.center,
                    controller: controller.MPS3Controller,
                    onTap: () async {
                      controller.BMDAMController.text = controller.MPS3Controller.text;
                      controller.MPS1 = double.parse(controller.MPS3Controller.text);
                      Navigator.of(context).pop(false);
                      await Future.delayed(const Duration(milliseconds: 600));
                      controller.Calculate_BMD_NO_AM();
                      controller.update();
                    },
                  ),
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                ThemeHelper().buildText(
                    context, 'StringMPS4', Colors.black, 'M'),
                Expanded(
                  child: TextFormField(
                    readOnly: true,
                    textAlign: TextAlign.center,
                    controller: controller.MPS4Controller,
                    onTap: () async {
                      controller.BMDAMController.text = controller.MPS4Controller.text;
                      controller.MPS1 = double.parse(controller.MPS4Controller.text);
                      Navigator.of(context).pop(false);
                      await Future.delayed(const Duration(milliseconds: 600));
                      controller.Calculate_BMD_NO_AM();
                      controller.update();
                    },
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
      backgroundColor: Colors.white,
      radius: 40,
      // barrierDismissible: false,
    );
  }

}
