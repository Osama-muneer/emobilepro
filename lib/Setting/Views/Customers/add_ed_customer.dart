import 'package:dropdown_button2/dropdown_button2.dart';
import '../../../Widgets/theme_helper.dart';
import '../../controllers/Customers_Controller.dart';
import '../../controllers/login_controller.dart';
import '../../models/acc_tax_t.dart';
import '../../models/bil_are.dart';
import '../../models/bil_cus_t.dart';
import '../../models/bil_dis.dart';
import '../../models/bra_inf.dart';
import '../../models/cou_tow.dart';
import '../../models/cou_wrd.dart';
import '../../models/list_value.dart';
import '../../models/pay_kin.dart';
import '../../../Widgets/colors.dart';
import '../../../Widgets/config.dart';
import '../../../Widgets/dropdown.dart';
import '../../../database/customer_db.dart';
import '../../../database/invoices_db.dart';
import '../../../database/setting_db.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Add_Ed_Customer extends StatefulWidget {
  const Add_Ed_Customer({Key? key}) : super(key: key);
  @override
  State<Add_Ed_Customer> createState() => _Add_Ed_CustomerState();
}

class _Add_Ed_CustomerState extends State<Add_Ed_Customer> {
  final CustomersController controller = Get.find();
  // PhoneContact? _phoneContact;
  // EmailContact? _emailContact;
  Future<bool> onWillPop() async {
    final shouldPop;
   // Navigator.of(context).pop(false);
    controller.ClearCustomersData();
    if(Get.arguments==1){
      Navigator.of(context).pop(false);
     // Get.back();
      return true;
    }else{
      controller.GET_BIL_CUS_P('ALL');
      shouldPop = await Get.offNamed('/View_Customers');
      return shouldPop ?? false;
    }
  }
  CheckSave() async {
   bool CompareBCNA=await CompareBCNAInputWithDatabase(controller.BCNAController.text);
   if (CompareBCNA==true && controller.CompareBCNAChanged==true ){
     Get.snackbar('StringErrorMes'.tr, 'StringCompareBCNA'.tr,
         backgroundColor: Colors.red,
         icon: const Icon(Icons.error, color: Colors.white),
         colorText: Colors.white,
         isDismissible: true,
         dismissDirection: DismissDirection.horizontal,
         forwardAnimationCurve: Curves.easeOutBack);}
    else {
     await Future.delayed(Duration(milliseconds: 400));
     Get.defaultDialog(
       title: 'StringMestitle'.tr,
       middleText: 'StringMessave'.tr,
       backgroundColor: Colors.white,
       radius: 40,
       textCancel: 'StringNo'.tr,
       cancelTextColor: Colors.red,
       textConfirm: 'StringYes'.tr,
       confirmTextColor: Colors.white,
       onConfirm: () {
         controller.BCLONController.text.isEmpty?controller.BCLONController.text='0': controller.BCLONController.text=controller.BCLONController.text;
         controller.BCLATController.text.isEmpty?controller.BCLATController.text='0': controller.BCLATController.text=controller.BCLATController.text;
         if(controller.location_of_account_application== '1' &&
             (double.parse(controller.BCLONController.text) <= 0.0 ||
                 controller.BCLONController.text.isEmpty ||
                 controller.BCLATController.text.isEmpty ||
                 double.parse(controller.BCLATController.text) <= 0.0 )){
           Get.defaultDialog(
             title: 'StringMestitle'.tr,
             middleText: 'StringLocation_of_Account_Application'.tr,
             backgroundColor:
             Colors.white,
             radius: 40,
             textCancel: 'StringNo'.tr,
             cancelTextColor:
             Colors.red,
             textConfirm: 'StringYes'.tr,
             confirmTextColor:
             Colors.white,
             onConfirm: () async {
               Navigator.of(context).pop(false);
               controller.editMode(context);
             },
             onCancel: () async {
               Navigator.of(context).pop(false);
               await  controller.determinePosition();
             },
             barrierDismissible: false,
           );
         }
         else{
           Navigator.of(context).pop(false);
           controller.editMode(context);
         }
         //      controller. get_BIF_MOV_M('DateNow');
       },
       // barrierDismissible: false,
     );}
  }

  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return WillPopScope(
      onWillPop: onWillPop,
      child: Scaffold(
        appBar: AppBar(
          iconTheme: IconThemeData(color: Colors.white),
          backgroundColor: AppColors.MainColor,
          actions: [
            Row(
              children: [
                IconButton(
                  icon: const Icon(Icons.save,color: Colors.white),
                  onPressed: () async {
                    CheckSave();
                  },
                ),
              ],
            )
          ],
          title: Text('${controller.titleScreen}',
              style: ThemeHelper().buildTextStyle(context, AppColors.textColor,'L')),
          centerTitle: true,
        ),
        body: GetBuilder<CustomersController>(
          init: CustomersController(),
          builder: ((value) => SingleChildScrollView(
                child: Form(
                  key: controller.formKey,
                  child: Padding(
                    padding: EdgeInsets.only(left: 0.02 * width, right: 0.02 * width),
                    child: Column(
                      children: [
                        SizedBox(height: 0.01 * height),
                        Row(
                          children: [
                            Checkbox(
                              value: controller.value,
                              onChanged: (value) {
                                if (controller.value == true) {
                                  controller.value = false;
                                  controller.value = value!;
                                  controller.update();
                                } else {
                                  controller.value = value!;
                                  controller.update();
                                }

                                controller.update();
                              },
                              activeColor: AppColors.MainColor,
                            ),
                            Text('StringInstallData'.tr, style:  ThemeHelper().buildTextStyle(context, Colors.black,'M')),
                          ],
                        ),
                        controller.value == false
                            ? Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  DropdownBra_InfBuilder(),
                                  SizedBox(height: 0.01 * height),
                                  DropdownBIL_CUS_TBuilder(),
                                  SizedBox(height: 0.01 * height),
                                  DropdownAcc_Tax_TBuilder(),
                                  SizedBox(height: 0.01 * height),
                                  DropdownPAY_KINBuilder(),
                                  SizedBox(height: 0.01 * height),
                                  //السعر
                                  DropdownMat_PriBuilder(),
                                  SizedBox(height: 0.01 * height),
                                  DropdownCou_WrdBuilder(),
                                  SizedBox(height: 0.01 * height),
                                  // DropdownMat_Uni_CBuilder(),
                              //    SizedBox(height: 0.01 * height),
                                  //City
                                  DropdownCOU_TOWBuilder(),
                                  SizedBox(height: 0.01 * height),
                                  DropdownBIL_AREBuilder(),
                                  SizedBox(height: 0.01 * height),
                                ],
                              )
                            : Container(),
                        //Cutomer Name1
                        TextFormField(
                          style: TextStyle(fontWeight: FontWeight.bold),
                          controller: controller.BCNAController,
                          focusNode: controller.BCNAFocus,
                          decoration: InputDecoration(
                              suffixIcon: IconButton(icon: Icon(
                                Icons.co_present ,color: controller.BCNAFocus.hasFocus ? Colors.red :
                              Colors.black ,),
                                onPressed: () async {
                                  // final PhoneContact contact = await FlutterContactPicker.pickPhoneContact();
                                  // controller.update();
                                  // _phoneContact = contact;
                                  // controller.update();
                                  // if (_phoneContact != null){
                                  //   controller.BCNAController.text= _phoneContact!.fullName.toString();
                                  //   controller.BCMOController.text= _phoneContact!.phoneNumber!.number.toString();
                                  // }
                                },),
                              contentPadding: const EdgeInsets.symmetric(vertical: 13, horizontal: 8),
                              labelText: 'StringNameCustomer'.tr,
                              labelStyle: TextStyle(
                                color:  controller.BCNAFocus.hasFocus ? Colors.red : Colors.grey.shade500,
                              ),
                              focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(0.15 * height),
                                  borderSide: BorderSide(color: Colors.red)),
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.all(
                                      Radius.circular(0.015 * height)))),
                          validator: (v) {
                            return controller.validateBCNA(v!);
                          },
                          onChanged: (v){
                            controller.CompareBCNAChanged=true;
                          },
                        ),
                        SizedBox(height: 0.01 * height),
                        //Cutomer Name2
                        TextFormField(
                          style: TextStyle(fontWeight: FontWeight.bold),
                          controller: controller.BCNEController,
                          focusNode: controller.BCNEFocus,
                          decoration: InputDecoration(
                              contentPadding: const EdgeInsets.symmetric(vertical: 13, horizontal: 8),
                              labelText: 'StringNameCustomer2'.tr,
                              labelStyle: TextStyle(
                                color:  controller.BCNEFocus.hasFocus ? Colors.red : Colors.grey.shade500,
                              ),
                              focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(0.15 * height),
                                  borderSide: BorderSide(color: Colors.red)),
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.all(
                                      Radius.circular(0.015 * height)))),
                          validator: (v) {
                            return controller.validateBCNA(v!);
                          },
                        ),
                        SizedBox(height: 0.01 * height),
                        //BCCL
                        TextFormField(
                          style: TextStyle(fontWeight: FontWeight.bold),
                          controller: controller.BCBLController,
                          focusNode: controller.BCBLFocus,
                          textAlign: TextAlign.center,
                          decoration: InputDecoration(
                              contentPadding: const EdgeInsets.symmetric(vertical: 13, horizontal: 8),
                              labelText: 'StringBCBL_CUS'.tr,

                              labelStyle: TextStyle(
                                color:  controller.BCBLFocus.hasFocus ? Colors.red : Colors.grey.shade500,
                              ),
                              focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(0.15 * height),
                                  borderSide: BorderSide(color: Colors.red)),
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.all(
                                      Radius.circular(0.015 * height)))),

                        ),
                        SizedBox(height: 0.01 * height),
                        //BCDM
                        TextFormField(
                          style: TextStyle(fontWeight: FontWeight.bold),
                          controller: controller.BCDMController,
                          focusNode: controller.BCDMFocus,
                          textAlign: TextAlign.center,
                          decoration: InputDecoration(
                              contentPadding: const EdgeInsets.symmetric(vertical: 13, horizontal: 8),
                              labelText: 'StringBCDM'.tr,
                              labelStyle: TextStyle(
                                color:  controller.BCDMFocus.hasFocus ? Colors.red : Colors.grey.shade500,
                              ),
                              focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(0.15 * height),
                                  borderSide: BorderSide(color: Colors.red)),
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.all(
                                      Radius.circular(0.015 * height)))),

                        ),
                        // SizedBox(height: 0.01 * height),
                        // //BCCR
                        // TextFormField(
                        //   style: TextStyle(fontWeight: FontWeight.bold),
                        //   controller: controller.BCCRController,
                        //   focusNode: controller.BCCRFocus,
                        //   textAlign: TextAlign.center,
                        //   decoration: InputDecoration(
                        //       contentPadding: const EdgeInsets.symmetric(vertical: 13, horizontal: 8),
                        //       labelText: 'StringBCCR'.tr,
                        //       labelStyle: TextStyle(
                        //         color:  controller.BCCRFocus.hasFocus ? Colors.red : Colors.grey.shade500,
                        //       ),
                        //       focusedBorder: OutlineInputBorder(
                        //           borderRadius: BorderRadius.circular(0.15 * height),
                        //           borderSide: BorderSide(color: Colors.red)),
                        //       border: OutlineInputBorder(
                        //           borderRadius: BorderRadius.all(
                        //               Radius.circular(0.015 * height)))),
                        //
                        // ),
                        SizedBox(height: 0.01 * height),
                        DropdownBIL_DISBuilder(),
                        SizedBox(height: 0.01 * height),
                        //Cutomer Phone
                        TextFormField(
                          style: TextStyle(fontWeight: FontWeight.bold),
                          controller: controller.BCMOController,
                          focusNode: controller.BCMOFocus,
                          keyboardType: TextInputType.number,
                          decoration: InputDecoration(
                            suffixIcon: IconButton(icon:  Icon(
                              Icons.co_present,
                                color: controller.BCMOFocus.hasFocus ? Colors.red :
                                Colors.black
                            ),
                              onPressed: () async {
                                // final PhoneContact contact = await FlutterContactPicker.pickPhoneContact();
                                // controller.update();
                                // _phoneContact = contact;
                                // controller.update();
                                // if (_phoneContact != null){
                                //   controller.BCMOController.text= _phoneContact!.phoneNumber!.number.toString();
                                // }
                              },),
                              contentPadding: const EdgeInsets.symmetric(vertical: 13, horizontal: 8),
                              labelText: 'StringMobile'.tr,
                              labelStyle: TextStyle(
                                color:  controller.BCMOFocus.hasFocus ? Colors.red : Colors.grey.shade500,
                              ),
                              focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(0.15 * height),
                                  borderSide: BorderSide(color: Colors.red)),
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.all(Radius.circular(0.015 * height)))),
                        ),
                        SizedBox(height: 0.01 * height),
                        //
                        TextFormField(
                          style: TextStyle(fontWeight: FontWeight.bold),
                          controller: controller.BCTLController,
                          focusNode: controller.BCTLFocus,
                          keyboardType: TextInputType.number,
                          decoration: InputDecoration(
                              contentPadding: const EdgeInsets.symmetric(vertical: 13, horizontal: 8),
                              labelText: 'StringBCDMO'.tr,
                              labelStyle: TextStyle(
                                color:  controller.BCTLFocus.hasFocus ? Colors.red : Colors.grey.shade500,
                              ),
                              focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(0.15 * height),
                                  borderSide: BorderSide(color: Colors.red)),
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.all(Radius.circular(0.015 * height)))),
                        ),
                        SizedBox(height: 0.01 * height),
                        //Cutomer Address
                        TextFormField(
                          style: TextStyle(fontWeight: FontWeight.bold),
                          controller: controller.BCADController,
                          focusNode: controller.BCADFocus,
                          decoration: InputDecoration(
                              contentPadding: const EdgeInsets.symmetric(vertical: 13, horizontal: 8),
                              labelText: 'StringAddress'.tr,
                              labelStyle: TextStyle(
                                color:controller.BCADFocus.hasFocus ? Colors.red : Colors.grey.shade500,
                              ),
                              focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(0.15 * height),
                                  borderSide: BorderSide(color: Colors.red)),
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.all(
                                      Radius.circular(0.015 * height)))),
                        ),
                        SizedBox(height: 0.01 * height),
                        //Cutomer Manager
                        TextFormField(
                          style: TextStyle(fontWeight: FontWeight.bold),
                          controller: controller.BCHNController,
                            focusNode: controller.BCHNFocus,
                          decoration: InputDecoration(
                              contentPadding: const EdgeInsets.symmetric(vertical: 13, horizontal: 8),
                              labelText: 'StringManager'.tr,
                              labelStyle: TextStyle(
                                color: controller.BCHNFocus.hasFocus ? Colors.red : Colors.grey.shade500,
                              ),
                              focusedBorder: OutlineInputBorder(
                                  borderRadius:
                                  BorderRadius.circular(0.15 * height),
                                  borderSide:
                                  BorderSide(color: Colors.red)),
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.all(
                                      Radius.circular(0.015 * height)))),
                        ),
                        SizedBox(height: 0.01 * height),
                        //VAT Number
                        TextFormField(
                          style: TextStyle(fontWeight: FontWeight.bold),
                          controller: controller.BCTXController,
                          focusNode: controller.BCTXFocus,
                          keyboardType: TextInputType.number,
                          decoration: InputDecoration(
                              contentPadding: const EdgeInsets.symmetric(vertical: 13, horizontal: 8),
                              labelText: 'StringVATNumber'.tr,
                              labelStyle: TextStyle(
                                color:  controller.BCTXFocus.hasFocus ? Colors.red : Colors.grey.shade500,
                              ),
                              focusedBorder: OutlineInputBorder(
                                  borderRadius:
                                      BorderRadius.circular(0.15 * height),
                                  borderSide:
                                      BorderSide(color: Colors.red)),
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.all(
                                      Radius.circular(0.015 * height)))),
                        ),
                        SizedBox(height: 0.01 * height),
                        //الحي
                        TextFormField(
                          style: TextStyle(fontWeight: FontWeight.bold),
                          controller: controller.BCQNDController,
                          focusNode: controller.BCQNDFocus,
                          // keyboardType: TextInputType.number,
                          decoration: InputDecoration(
                              contentPadding: const EdgeInsets.symmetric(vertical: 13, horizontal: 8),
                              labelText: 'StringBCQND'.tr,
                              labelStyle: TextStyle(
                                color: controller.BCQNDFocus.hasFocus ? Colors.red :Colors.grey.shade500,
                              ),
                              focusedBorder: OutlineInputBorder(
                                  borderRadius:
                                  BorderRadius.circular(0.15 * height),
                                  borderSide:
                                  BorderSide(color: Colors.red)),
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.all(
                                      Radius.circular(0.015 * height)))),
                        ),
                        SizedBox(height: 0.01 * height),
                        //Building No.
                        TextFormField(
                          style: const TextStyle(fontWeight: FontWeight.bold),
                          controller: controller.BCBNController,
                          focusNode: controller.BCBNFocus,
                          // keyboardType: TextInputType.number,
                          decoration: InputDecoration(
                              contentPadding: const EdgeInsets.symmetric(vertical: 13, horizontal: 8),
                              labelText: 'StringBuildingNo'.tr,
                              labelStyle: TextStyle(
                                color:controller.BCBNFocus.hasFocus ? Colors.red : Colors.grey.shade500,
                              ),
                              focusedBorder: OutlineInputBorder(
                                  borderRadius:
                                  BorderRadius.circular(0.15 * height),
                                  borderSide:
                                  BorderSide(color: Colors.red)),
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.all(
                                      Radius.circular(0.015 * height)))),
                        ),
                        SizedBox(height: 0.01 * height),
                        //Street No
                        TextFormField(
                          style: TextStyle(fontWeight: FontWeight.bold),
                          controller: controller.BCSNDController,
                            focusNode: controller.BCSNDFocus,
                          // keyboardType: TextInputType.number,
                          decoration: InputDecoration(
                              contentPadding: const EdgeInsets.symmetric(vertical: 13, horizontal: 8),
                              labelText: 'StringStreetNo'.tr,
                              labelStyle: TextStyle(
                                color: controller.BCSNDFocus.hasFocus ? Colors.red :Colors.grey.shade500,
                              ),
                              focusedBorder: OutlineInputBorder(
                                  borderRadius:
                                      BorderRadius.circular(0.15 * height),
                                  borderSide:
                                      BorderSide(color: Colors.red)),
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.all(
                                      Radius.circular(0.015 * height)))),
                        ),
                        SizedBox(height: 0.01 * height),
                        //رقم اضافي للعنوان
                        TextFormField(
                          style: TextStyle(fontWeight: FontWeight.bold),
                          controller: controller.BCAD2Controller,
                          focusNode: controller.BCAD2Focus,
                          // keyboardType: TextInputType.number,
                          decoration: InputDecoration(
                              contentPadding: const EdgeInsets.symmetric(vertical: 13, horizontal: 8),
                              labelText: 'StringBCAD2'.tr,
                              labelStyle: TextStyle(
                                color: controller.BCAD2Focus.hasFocus ? Colors.red :Colors.grey.shade500,
                              ),
                              focusedBorder: OutlineInputBorder(
                                  borderRadius:
                                  BorderRadius.circular(0.15 * height),
                                  borderSide:
                                  BorderSide(color: Colors.red)),
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.all(
                                      Radius.circular(0.015 * height)))),
                        ),
                        SizedBox(height: 0.01 * height),
                        //الرمز البريدي
                        TextFormField(
                          style: TextStyle(fontWeight: FontWeight.bold),
                          controller: controller.BCPCController,
                          focusNode: controller.BCPCFocus,
                          // keyboardType: TextInputType.number,
                          decoration: InputDecoration(
                              contentPadding: const EdgeInsets.symmetric(vertical: 13, horizontal: 8),
                              labelText: 'StringBCPC'.tr,
                              labelStyle: TextStyle(
                                color: controller.BCPCFocus.hasFocus ? Colors.red :Colors.grey.shade500,
                              ),
                              focusedBorder: OutlineInputBorder(
                                  borderRadius:
                                  BorderRadius.circular(0.15 * height),
                                  borderSide:
                                  BorderSide(color: Colors.red)),
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.all(
                                      Radius.circular(0.015 * height)))),
                        ),
                        SizedBox(height: 0.01 * height),
                        // //Office No
                        // TextFormField(
                        //   style: const TextStyle(fontWeight: FontWeight.bold),
                        //   controller: controller.BCONController,
                        //   focusNode: controller.BCONFocus,
                        //   // keyboardType: TextInputType.number,
                        //   decoration: InputDecoration(
                        //       contentPadding: const EdgeInsets.symmetric(vertical: 13, horizontal: 8),
                        //       labelText: 'StringOfficeNo'.tr,
                        //       labelStyle: TextStyle(
                        //         color: controller.BCONFocus.hasFocus ? Colors.red :Colors.grey.shade500,
                        //       ),
                        //       focusedBorder: OutlineInputBorder(
                        //           borderRadius:
                        //               BorderRadius.circular(0.15 * height),
                        //           borderSide:
                        //               BorderSide(color: Colors.red)),
                        //       border: OutlineInputBorder(
                        //           borderRadius: BorderRadius.all(
                        //               Radius.circular(0.015 * height)))),
                        // ),
                        // SizedBox(height: 0.01 * height),
                        //Commercial registration number
                        TextFormField(
                          style: const TextStyle(fontWeight: FontWeight.bold),
                          controller: controller.BCC1Controller,
                          focusNode: controller.BCC1Focus,
                          keyboardType: TextInputType.number,
                          decoration: InputDecoration(
                              contentPadding: const EdgeInsets.symmetric(vertical: 13, horizontal: 8),
                              labelText: 'Stringregistrationnumber'.tr,
                              labelStyle: TextStyle(
                                color:  controller.BCC1Focus.hasFocus ? Colors.red :
                                Colors.grey.shade500,
                              ),
                              focusedBorder: OutlineInputBorder(
                                  borderRadius:
                                      BorderRadius.circular(0.15 * height),
                                  borderSide:
                                      BorderSide(color: Colors.red)),
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.all(
                                      Radius.circular(0.015 * height)))),
                        ),
                        SizedBox(height: 0.01 * height),
                        //النشاط
                        TextFormField(
                          style: TextStyle(fontWeight: FontWeight.bold),
                          controller: controller.BCJTController,
                          focusNode: controller.BCJTFocus,
                          // keyboardType: TextInputType.number,
                          decoration: InputDecoration(
                              contentPadding: const EdgeInsets.symmetric(vertical: 13, horizontal: 8),
                              labelText: 'StringBCJT'.tr,
                              labelStyle: TextStyle(
                                color: controller.BCJTFocus.hasFocus ? Colors.red :Colors.grey.shade500,
                              ),
                              focusedBorder: OutlineInputBorder(
                                  borderRadius:
                                  BorderRadius.circular(0.15 * height),
                                  borderSide:
                                  BorderSide(color: Colors.red)),
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.all(
                                      Radius.circular(0.015 * height)))),
                        ),
                        SizedBox(height: 0.01 * height),
                        //التفاصيل
                        TextFormField(
                          style: const TextStyle(fontWeight: FontWeight.bold),
                          controller: controller.BCINController,
                          focusNode: controller.BCINFocus,
                          decoration: InputDecoration(
                              labelText: 'StringDetails'.tr,
                              contentPadding: const EdgeInsets.symmetric(vertical: 13, horizontal: 8),
                              labelStyle: TextStyle(
                                color: controller.BCINFocus.hasFocus ? Colors.red :Colors.grey.shade500,
                              ),
                              focusedBorder: OutlineInputBorder(
                                  borderRadius:
                                      BorderRadius.circular(0.15 * height),
                                  borderSide:
                                      BorderSide(color: Colors.red)),
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.all(
                                      Radius.circular(0.015 * height)))),
                        ),
                        SizedBox(height: 0.01 * height),
                        //خط العرض
                        TextFormField(
                          keyboardType: TextInputType.number,
                          readOnly: true,
                          style: const TextStyle(fontWeight: FontWeight.bold),
                          controller: controller.BCLATController,
                          decoration: controller.Update_location_account=='2'?
                          InputDecoration(
                              labelText: 'StringLATITUDE'.tr,
                              contentPadding: const EdgeInsets.symmetric(vertical: 13, horizontal: 8),
                              labelStyle: TextStyle(
                                color: Colors.grey.shade500,
                              ),
                              focusedBorder: OutlineInputBorder(
                                  borderRadius:
                                  BorderRadius.circular(0.15 * height),
                                  borderSide:
                                  BorderSide(color: Colors.grey.shade500)),
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.all(
                                      Radius.circular(0.015 * height)))):
                          InputDecoration(
                              suffixIcon: IconButton(icon:  Icon(
                                Icons.location_on,
                                size: 0.026 * height,
                              ),
                                onPressed: () async {
                                  controller.BCLATController.text=controller.latitude!.value.toString();
                                  controller.BCLONController.text=controller.longitude!.value.toString();
                                  controller.update();
                                },),
                              labelText: 'StringLATITUDE'.tr,
                              contentPadding: const EdgeInsets.symmetric(vertical: 13, horizontal: 8),
                              labelStyle: TextStyle(
                                color: Colors.grey.shade500,
                              ),
                              focusedBorder: OutlineInputBorder(
                                  borderRadius:
                                  BorderRadius.circular(0.15 * height),
                                  borderSide:
                                  BorderSide(color: Colors.grey.shade500)),
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.all(
                                      Radius.circular(0.015 * height)))),
                          enabled: controller.Update_location_account=='1'?true:false,
                        ),
                        SizedBox(height: 0.01 * height),
                        //خط الطول
                        TextFormField(
                          keyboardType: TextInputType.number,
                          style: const TextStyle(fontWeight: FontWeight.bold),
                          controller: controller.BCLONController,
                          readOnly: true,
                          decoration: controller.Update_location_account=='2'?
                          InputDecoration(
                              labelText: 'StringLONGITUDE'.tr,
                              contentPadding: const EdgeInsets.symmetric(vertical: 13, horizontal: 8),
                              labelStyle: TextStyle(
                                color: Colors.grey.shade500,
                              ),
                              focusedBorder: OutlineInputBorder(
                                  borderRadius:
                                  BorderRadius.circular(0.15 * height),
                                  borderSide:
                                  BorderSide(color: Colors.grey.shade500)),
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.all(
                                      Radius.circular(0.015 * height)))):
                          InputDecoration(
                              suffixIcon: IconButton(icon:  Icon(
                                Icons.location_on,
                                size: 0.026 * height,
                              ),
                                onPressed: () async {
                                  controller.BCLATController.text=controller.latitude!.value.toString();
                                  controller.BCLONController.text=controller.longitude!.value.toString();
                                  controller.update();
                                },),
                              labelText: 'StringLONGITUDE'.tr,
                              contentPadding: const EdgeInsets.symmetric(vertical: 13, horizontal: 8),
                              labelStyle: TextStyle(
                                color: Colors.grey.shade500,
                              ),
                              focusedBorder: OutlineInputBorder(
                                  borderRadius:
                                  BorderRadius.circular(0.15 * height),
                                  borderSide:
                                  BorderSide(color: Colors.grey.shade500)),
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.all(
                                      Radius.circular(0.015 * height)))),
                          enabled: controller.Update_location_account=='1'?true:false,
                        ),
                        SizedBox(height: 0.01 * height),

                        LoginController().CIID=='2'?
                        TextFormField(
                          style: const TextStyle(fontWeight: FontWeight.bold),
                          controller: controller.BCC3Controller,
                          decoration: InputDecoration(
                              labelText: 'CIID',
                              contentPadding: const EdgeInsets.symmetric(vertical: 13, horizontal: 8),
                              labelStyle: TextStyle(
                                color: Colors.grey.shade500,
                              ),
                              focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(0.15 * height),
                                  borderSide: BorderSide(color: Colors.grey.shade500)),
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.all(
                                      Radius.circular(0.015 * height)))),
                        ):
                        Container(),
                        LoginController().CIID=='2'?SizedBox(height: 0.01 * height):
                        Container(),
                      ],
                    ),
                  ),
                ),
              )),
        ),
      bottomNavigationBar:  SafeArea(
        child: MaterialButton(
          onPressed: () async {
            CheckSave();
          },
          child: Container(
            height:  0.05 * height,
            width: double.infinity,
            alignment: Alignment.center,
            decoration: BoxDecoration(
                color: AppColors.MainColor,
                borderRadius:
                BorderRadius.circular(0.02 * height)),
            child: Text(
              'StringSave'.tr,
              style: ThemeHelper().buildTextStyle(context, Colors.white,'L')
            ),
          ),
        ),
      ),
      ),
    );
  }

  GetBuilder<CustomersController> DropdownBra_InfBuilder() {
    return GetBuilder<CustomersController>(
        init: CustomersController(),
        builder: ((controller) => FutureBuilder<List<Bra_Inf_Local>>(
            future: GET_BRA(1),
            builder: (BuildContext context,
                AsyncSnapshot<List<Bra_Inf_Local>> snapshot) {
              if (!snapshot.hasData) {
                return Dropdown(
                  josnStatus: josnStatus,
                  GETSTRING: 'StringBrach',
                );
              }
              return IgnorePointer(
                ignoring: controller.edit == true ? true : false,
                child: DropdownButtonFormField2(
                  decoration: ThemeHelper().InputDecorationDropDown(" ${'StringBIIDlableText'.tr}",
                      focusNode:controller.BIIDFocus),
                  isExpanded: true,
                  focusNode: controller.BIIDFocus,
                  hint: ThemeHelper().buildText(context,'StringBrach', Colors.grey,'S'),
                  value: controller.SelectDataBIID,
                  style: ThemeHelper().buildTextStyle(context, Colors.black,'M'),
                  items: snapshot.data!.map((item) => DropdownMenuItem<String>(
                            value: item.BIID.toString(),
                            child: Text(
                              item.BINA_D.toString(),
                              style:  ThemeHelper().buildTextStyle(context, Colors.black,'M'),
                            ),
                          )).toList().obs,
                  validator: (v) {
                    if (v == null) {
                      return 'StringBrach'.tr;
                    }
                    return null;
                  },
                  onChanged: (value) {
                    //Do something when changing the item if you want.
                    controller.SelectDataBIID = value.toString();
                  },
                ),
              );
            })));
  }

  GetBuilder<CustomersController> DropdownAcc_Tax_TBuilder() {
    return GetBuilder<CustomersController>(
        init: CustomersController(),
        builder: ((controller) => FutureBuilder<List<Acc_Tax_T_Local>>(
            future: GET_ACC_TAX_T(),
            builder: (BuildContext context,
                AsyncSnapshot<List<Acc_Tax_T_Local>> snapshot) {
              if (!snapshot.hasData) {
                return Dropdown(
                  josnStatus: josnStatus,
                  GETSTRING: 'StringChooseTaxclassification',
                );
              }
              return DropdownButtonFormField2(
                decoration: ThemeHelper().InputDecorationDropDown(" ${'StringTaxclassification'.tr}"
                    ,focusNode:controller.ATTIDFocus),
                isExpanded: true,
                focusNode: controller.ATTIDFocus,
                hint: ThemeHelper().buildText(context,'StringTaxclassification', Colors.grey,'S'),
                value: controller.SelectDataATTID,
                style: ThemeHelper().buildTextStyle(context, Colors.black,'M'),
                items: snapshot.data!
                    .map((item) => DropdownMenuItem<String>(
                          value: item.ATTID.toString(),
                          child: Text(
                            item.ATTNA_D.toString(),
                            style:  ThemeHelper().buildTextStyle(context, Colors.black,'M'),
                          ),
                        ))
                    .toList()
                    .obs,
                validator: (v) {
                  if (v == null) {
                    return 'StringBrach'.tr;
                  }
                  return null;
                },
                onChanged: (value) {
                  //Do something when changing the item if you want.
                  controller.SelectDataATTID = value.toString();
                },
              );
            })));
  }

  GetBuilder<CustomersController> DropdownCOU_TOWBuilder() {
    return GetBuilder<CustomersController>(
        init: CustomersController(),
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
                decoration: ThemeHelper().InputDecorationDropDown(" ${'StringCity'.tr}"
                    ,focusNode:controller.ACIDFocus),
                  dropdownStyleData: const DropdownStyleData(
                    maxHeight: 200,
                  ),
                  isExpanded: true,
                  focusNode: controller.ACIDFocus,
                  hint: ThemeHelper().buildText(context,'StringCity', Colors.grey,'S'),
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

  FutureBuilder<List<Pay_Kin_Local>> DropdownPAY_KINBuilder() {
    return FutureBuilder<List<Pay_Kin_Local>>(
        future: GET_PAY_KIN(1, 'CUS', 1, ''),
        builder: (BuildContext context,
            AsyncSnapshot<List<Pay_Kin_Local>> snapshot) {
          if (!snapshot.hasData) {
            return Dropdown(
              josnStatus: josnStatus,
              GETSTRING: 'StringChi_PAY'.tr,
            );
          }
          return DropdownButtonFormField2(
            decoration: ThemeHelper().InputDecorationDropDown(" ${'StringPKIDlableText'.tr}"
                ,focusNode:controller.PKIDFocus),
            isExpanded: true,
            focusNode: controller.PKIDFocus,
            hint: ThemeHelper().buildText(context,'StringChi_PAY', Colors.grey,'S'),
            value: controller.PKID.toString(),
            style: const TextStyle(
                fontFamily: 'Hacen',
                color: Colors.black,
                fontWeight: FontWeight.bold),
            items: snapshot.data!
                .map((item) => DropdownMenuItem<String>(
                      value: item.PKID.toString(),
                      onTap: () {
                        controller.PKID = item.PKID!;
                        controller.update();
                      },
                      child: Text(
                        item.PKNA_D.toString(),
                        style: ThemeHelper().buildTextStyle(context, Colors.black,'M'),
                      ),
                    ))
                .toList()
                .obs,
            validator: (v) {
              if (v == null) {
                return 'StringBrach'.tr;
              }
              return null;
            },
            onChanged: (value) {
              controller.PKID = int.parse(value.toString());
              controller.update();
            },
          );
        });
  }

  GetBuilder<CustomersController> DropdownBIL_AREBuilder() {
    return GetBuilder<CustomersController>(
        init: CustomersController(),
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
                decoration: ThemeHelper().InputDecorationDropDown(" ${'StringArea'.tr}"
                    ,focusNode:controller.BAIDFocus),
                  dropdownStyleData: const DropdownStyleData(
                    maxHeight: 200,
                  ),
                focusNode: controller.BAIDFocus,
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
                      .toList().obs,
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

  GetBuilder<CustomersController> DropdownBIL_DISBuilder() {
    return GetBuilder<CustomersController>(
        init: CustomersController(),
        builder: ((controller) => FutureBuilder<List<Bil_Dis_Local>>(
            future: GET_BIL_DIS(controller.SelectDataBIID.toString()),
            builder: (BuildContext context,
                AsyncSnapshot<List<Bil_Dis_Local>> snapshot) {
              if (!snapshot.hasData) {
                return Dropdown(
                  josnStatus: josnStatus,
                  GETSTRING: 'StringCollector'.tr,
                );
              }
              return DropdownButtonFormField2(
                decoration: ThemeHelper().InputDecorationDropDown('StringCollector'.tr
                    ,focusNode:controller.BDIDFocus),
                isDense: true,
                isExpanded: true,
                focusNode: controller.BDIDFocus,
                hint: ThemeHelper().buildText(context,'StringCollector', Colors.grey,'S'),
                items: snapshot.data!.map((item) => DropdownMenuItem<String>(
                  onTap: (){
                    controller.SelectDataBDID = item.BDID.toString();
                    controller.update();
                  },
                  value: item.BDNA.toString(),
                  child: Text(
                    item.BDNA.toString(),
                    style: ThemeHelper().buildTextStyle(context, Colors.black,'M'),
                  ),
                )).toList().obs,
                value: controller.SelectDataBDID2,
                onChanged: (value) {
                  controller.SelectDataBDID2=value.toString();
                  controller.update();
                },
                dropdownStyleData: const DropdownStyleData(
                  maxHeight: 250,
                ),
                dropdownSearchData: DropdownSearchData(
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
                          suffixIcon: IconButton(icon: const Icon(
                            Icons.clear,
                            size: 20,
                          ),
                            onPressed: (){
                              controller.TextEditingSercheController.clear();
                              controller.update();
                            },),
                          contentPadding: const EdgeInsets.symmetric(
                            horizontal: 10,
                            vertical: 8,
                          ),
                          hintText: 'StringSearch_for_BDID'.tr,
                          hintStyle:  ThemeHelper().buildTextStyle(context, Colors.grey,'S'),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                      ),
                    ),
                    searchMatchFn: (item, searchValue) {
                      return (item.value.toString().toLowerCase().contains(searchValue));
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

  //StringCollector
  GetBuilder<CustomersController> DropdownCou_WrdBuilder() {
    return GetBuilder<CustomersController>(
        init: CustomersController(),
        builder: ((controller) => FutureBuilder<List<Cou_Wrd_Local>>(
            future: GET_COU_WRD(),
            builder: (BuildContext context, AsyncSnapshot<List<Cou_Wrd_Local>> snapshot) {
              if (!snapshot.hasData) {
                return Dropdown(josnStatus: josnStatus,GETSTRING: 'StringChooseCountry',);
              }
              return DropdownButtonFormField2(
                decoration: ThemeHelper().InputDecorationDropDown(" ${'StringChooseCountry'.tr}"
                    ,focusNode:controller.CWIDFocus),
                  dropdownStyleData: const DropdownStyleData(
                    maxHeight: 200,
                  ),
                  isExpanded: true,
                  focusNode: controller.CWIDFocus,
                  hint: ThemeHelper().buildText(context,'StringChooseCountry', Colors.grey,'S'),
                  value: controller.SelectDataCWID2,
                  style: const TextStyle(
                      fontFamily: 'Hacen',
                      color: Colors.black,
                      fontWeight: FontWeight.bold),
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

  GetBuilder<CustomersController> DropdownMat_PriBuilder() {
    return GetBuilder<CustomersController>(
        init: CustomersController(),
        builder: ((controller) => FutureBuilder<List<List_Value>>(
            future: GET_LIST_VALUE('BCPR'),
            builder: (BuildContext context,
                AsyncSnapshot<List<List_Value>> snapshot) {
              if (!snapshot.hasData) {
                return Dropdown(
                  josnStatus: josnStatus,
                  GETSTRING: 'StringPrice',
                );
              }
              return DropdownButtonFormField2(
                decoration: ThemeHelper().InputDecorationDropDown(" ${'StringPrice'.tr}"
                    ,focusNode:controller.BCPRFocus),
                isExpanded: true,
                focusNode: controller.BCPRFocus,
                hint:  ThemeHelper().buildText(context,'StringPrice', Colors.grey,'S'),
                value: controller.SelectDataBCPR,
                style: const TextStyle(
                    fontFamily: 'Hacen',
                    color: Colors.black,
                    fontWeight: FontWeight.bold),
                items: snapshot.data!
                    .map((item) => DropdownMenuItem<String>(
                          value: item.LVID.toString(),
                          child: Text(
                            item.LVNA_D.toString(),
                            style: ThemeHelper().buildTextStyle(context, Colors.black,'M'),
                          ),
                        ))
                    .toList()
                    .obs,
                onChanged: (value) {
                  setState(() {
                    controller.SelectDataBCPR = value as String;
                  });
                },
              );
            })));
  }

  GetBuilder<CustomersController> DropdownBIL_CUS_TBuilder() {
    return GetBuilder<CustomersController>(
        init: CustomersController(),
        builder: ((controller) => FutureBuilder<List<Bil_Cus_T_Local>>(
            future: GET_BIL_CUS_T(),
            builder: (BuildContext context,
                AsyncSnapshot<List<Bil_Cus_T_Local>> snapshot) {
              if (!snapshot.hasData) {
                return Dropdown(
                  josnStatus: josnStatus,
                  GETSTRING: 'StringChooseCustomerType',
                );
              }
              return DropdownButtonFormField2(
                decoration: ThemeHelper().InputDecorationDropDown(" ${'StringCustomerType'.tr}"
                    ,focusNode:controller.BCTIDFocus),
                isExpanded: true,
                focusNode: controller.BCTIDFocus,
                hint: ThemeHelper().buildText(context,'StringCustomerType', Colors.grey,'S'),
                style: const TextStyle(
                    fontFamily: 'Hacen',
                    color: Colors.black,
                    fontWeight: FontWeight.bold),
                items: snapshot.data!
                    .map((item) => DropdownMenuItem<String>(
                          value: item.BCTID.toString(),
                          child: Text(
                            item.BCTNA_D.toString(),
                            style: ThemeHelper().buildTextStyle(context, Colors.black,'M'),
                          ),
                        ))
                    .toList()
                    .obs,
                value: controller.SelectDataBCTID,
                onChanged: (value) {
                    controller.SelectDataBCTID = value as String;
                    controller.update();
                },
              );
            })));
  }

}
