import 'package:dropdown_button2/dropdown_button2.dart';
import '../../../Operation/Controllers/sale_invoices_controller.dart';
import '../../../Setting/models/acc_cas.dart';
import '../../../Setting/models/sys_cur.dart';
import '../../../Widgets/config.dart';
import '../../../Widgets/dimensions.dart';
import '../../../Widgets/dropdown.dart';
import '../../../database/setting_db.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';

class Sale_Invoice_Pay extends GetWidget<Sale_Invoices_Controller> {

  @override
  Widget build(BuildContext context) {
    return  GetBuilder<Sale_Invoices_Controller>(
        init: Sale_Invoices_Controller(),
        builder: ((value) => Scaffold(
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                SizedBox(height: Dimensions.height40),
                Card(
                  elevation: 1,
                  color: Colors.grey[100],
                  shape: RoundedRectangleBorder(
                    side: BorderSide(
                      color: Colors.grey,
                    ),
                    borderRadius: const BorderRadius.all(Radius.circular(5)),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      children: [
                        Container(
                        //  padding: EdgeInsets.all(20),
                            width: double.infinity,
                            color: Colors.grey[200],
                            child: Column(
                              children: [
                                Row(
                                  children: [
                                    Expanded(
                                      child: Text( " العميل: ${controller.BCNAController.text.isEmpty?'':controller.BCNAController.text}" , style: TextStyle(
                                      color: Colors.black45,
                                      fontSize: Dimensions.fonText,
                                      fontWeight: FontWeight.bold)),
                                    ),
                                  ],
                                ),
                                Row(
                                  children: [
                                    Text( " الدفع: ${controller.PKNA}" , style: TextStyle(
                                    color: Colors.black45,
                                    fontSize: Dimensions.fonText,
                                    fontWeight: FontWeight.bold)),
                                  ],
                                ),
                              ],
                            )),
                        SizedBox(height: Dimensions.height40),
                        controller.BMKID==1  || controller.BMKID==3  || controller.BMKID==5?
                        DropdownACC_CASBuilder(): controller.BMKID==11?DropdownSYS_CURBuilder():Container(),
                        controller.BMKID==1  || controller.BMKID==3  || controller.BMKID==5 || controller.BMKID==11?
                        SizedBox(height: Dimensions.height5): SizedBox(height: Dimensions.height1),
                        Row(
                          children: [
                            Text('  نقدا', style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: Dimensions.fonText,color: Colors.black),),
                          ],
                        ),
                        SizedBox(height: Dimensions.height5),
                        TextFormField(
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: Dimensions.fonText),
                          controller: controller.BMMCPController,
                          keyboardType: TextInputType.number,
                          textAlign: TextAlign.center,
                          decoration: InputDecoration(
                              labelText: 'StringBMMCP'.tr,
                            suffixIcon: IconButton(
                              icon: const Icon(Icons.clear, size: 20,),
                              onPressed: () {
                                controller.BMMCPController.clear();
                                controller.Calculate_BMMTC('0',controller.SelectDataSCIDP.toString());
                              },),
                             contentPadding: const EdgeInsets.symmetric(vertical: 13, horizontal: 8.0),
                              labelStyle: TextStyle(
                                 // color: Colors.grey,
                                  fontSize: Dimensions.fonTextSmall),
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.all(
                                      Radius.circular(1)))),
                          onChanged: (v){
                            if(v.isNotEmpty && double.parse(v)>=0){
                              controller.Calculate_BMMTC(v,controller.SelectDataSCIDP.toString());
                            }else{
                              controller.Calculate_BMMTC('0',controller.SelectDataSCIDP.toString());
                            }
                          },
                        ),
                        controller.SelectDataBMMDN == '0' &&
                            controller.Allow_give_Discount == '1' &&
                            controller.UPIN_BMMDI == 1
                            ?SizedBox(height: Dimensions.height30):SizedBox(height: Dimensions.height5),
                        controller.SelectDataBMMDN == '0' &&
                            controller.Allow_give_Discount == '1' &&
                            controller.UPIN_BMMDI == 1
                            ?Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                           SizedBox(
                              width: MediaQuery.of(context).size.width / 5.20,
                              child: TextFormField(
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: Dimensions.fonTextSmall),
                                controller: controller.BMMDIRController,
                                keyboardType: TextInputType.number,
                                textAlign: TextAlign.center,
                                decoration: InputDecoration(
                                    labelText: '%',
                                    contentPadding: const EdgeInsets.symmetric(vertical: 13, horizontal: 8),
                                    labelStyle: TextStyle(
                                      // color: Colors.grey,
                                        fontSize: Dimensions.fonTextSmall),
                                    border: OutlineInputBorder(
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(1)))),
                                onChanged: (v) async {
                                  if (v.isNotEmpty && double.parse(v) >= 0) {
                                    //الخصم علي مستوى الفاتورة
                                    controller.UPDATE_BMMDI();
                                    await Future.delayed(const Duration(seconds: 2));
                                    controller.Calculate_BMMTC(controller.BMMCPController.text,controller.SelectDataSCIDP.toString());
                                  }
                                },
                              ),
                            ),
                            SizedBox(
                              width: MediaQuery.of(context).size.width / 1.42,
                              child: TextFormField(
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: Dimensions.fonTextSmall),
                                controller: controller.BMMDIController,
                                keyboardType: TextInputType.number,
                                textAlign: TextAlign.center,
                                decoration: InputDecoration(
                                    labelText: 'StringDiscount'.tr,
                                    contentPadding: const EdgeInsets.symmetric(vertical: 13, horizontal: 8),
                                    labelStyle: TextStyle(
                                  //      color: Colors.grey,
                                        fontSize: Dimensions.fonTextSmall),
                                    border: OutlineInputBorder(
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(1)))),
                                onChanged: (v) async {
                                  if (v.isNotEmpty &&
                                      double.parse(v) >= 0) {
                                    controller.BMMDIRController.text = '0';
                                    //الخصم علي مستوى الفاتورة
                                    controller.UPDATE_BMMDI();
                                      await Future.delayed(const Duration(seconds: 2));
                                      controller.Calculate_BMMTC(controller.BMMCPController.text,controller.SelectDataSCIDP.toString());
                                  }
                                },
                              ),
                            ),
                          ],
                        ):
                        Container(),
                      ],
                    ),
                  ),
                ),
                SizedBox(height: Dimensions.height40),
                Card(
                  elevation: 1,
                  color: Colors.grey[100],
                  shape: RoundedRectangleBorder(
                    side: BorderSide(
                      color: Colors.grey,
                    ),
                    borderRadius: const BorderRadius.all(Radius.circular(5)),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text('StringSUMBMDAMT'.tr,
                                style: TextStyle(
                                    fontSize: Dimensions.fonText,
                                    fontWeight: FontWeight.bold)),
                            Text("${controller.SCSY} ${controller.formatter.format(double.parse(controller.BMMAMController.text)).toString()}",
                                style: TextStyle(
                                    fontSize: Dimensions.fonText,
                                    fontWeight: FontWeight.bold)),
                          ],
                        ),
                        controller.SVVL_TAX != '2'?SizedBox(height: Dimensions.height5):Container(),
                        controller.SVVL_TAX != '2'?Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text('StringSUMBMDTXT'.tr,
                                style: TextStyle(
                                    fontSize: Dimensions.fonText,
                                    fontWeight: FontWeight.bold)),
                            Text("${controller.SCSY} ${controller.formatter.format(double.parse(controller.SUMBMDTXTController.text)).toString()}",
                                style: TextStyle(
                                    fontSize: Dimensions.fonText,
                                    fontWeight: FontWeight.bold)),
                          ],
                        ):
                        Container(),
                        SizedBox(height: Dimensions.height5),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text('StrinSUMBCMAM'.tr,
                                style: TextStyle(
                                    fontSize: Dimensions.fonText,color: Colors.red,
                                    fontWeight: FontWeight.bold)),
                            Text("${controller.SCSY} ${controller.formatter.format(double.parse(controller.BMMAMTOTController.text)).toString()}",
                                style: TextStyle(
                                    fontSize: Dimensions.fonText,color: Colors.red,
                                    fontWeight: FontWeight.bold)),
                          ],
                        ),
                        SizedBox(height: Dimensions.height5),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text("${'StringBMMCP'.tr}:",
                                style: TextStyle(
                                    fontSize: Dimensions.fonText,
                                    fontWeight: FontWeight.bold)),
                            Text("${controller.SCSY} ${controller.BMMCPController.text.isEmpty?'0':controller.formatter.format(controller.BMMTC_TOT).toString()}",
                                style: TextStyle(
                                    fontSize: Dimensions.fonText,
                                    fontWeight: FontWeight.bold)),
                          ],
                        ),
                        SizedBox(height: Dimensions.height5),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text('StringReturn_Am'.tr,
                                style: TextStyle(
                                    fontSize: Dimensions.fonText,color: Colors.black,
                                    fontWeight: FontWeight.bold)),
                            Text("${controller.SCSY} ${ controller.formatter.format(controller.BMMTC).toString()}",
                                style: TextStyle(
                                    fontSize: Dimensions.fonText,color:
                                double.parse(controller.BMMCPController.text.isEmpty?'0':controller.BMMTC_TOT.toString())>=double.parse(controller.BMMAMTOTController.text)?
                                    Colors.green:Colors.red,
                                    fontWeight: FontWeight.bold)),
                          ],
                        ),
                        SizedBox(height: Dimensions.height5),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),

      floatingActionButton:  Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          TextButton.icon(     // <-- TextButton
            onPressed: () {
              controller.Show_Inv_Pay=true;
              controller.update();
              Navigator.of(context).pop(false);
            },
            icon: Icon( // <--// Icon
              Icons.clear,
              size: 45.0,
              color: Colors.red,
            ),
            label: Text('الغاء' , style: TextStyle(
                fontSize: Dimensions.fonText, color: Colors.red,
                fontWeight: FontWeight.bold)),
          ),
          TextButton.icon(     // <-- TextButton
            onPressed: () {
              if(controller.BMMCPController.text.isNotEmpty && double.parse(controller.BMMCPController.text)>0 &&
                  (controller.BMKID==1 || controller.BMKID==3 || controller.BMKID==5) &&  controller.SelectDataACID2==null){
                Fluttertoast.showToast(
                    msg: 'StringChi_ACID'.tr,
                    toastLength: Toast.LENGTH_LONG,
                    textColor: Colors.white,
                    backgroundColor: Colors.redAccent);
              }else if (controller.PAY_V=='4' && double.parse(controller.BMMCPController.text)<= 0) {
                Fluttertoast.showToast(
                    msg: 'StringBMMCP_ERR'.tr,
                    toastLength: Toast.LENGTH_LONG,
                    textColor: Colors.white,
                    backgroundColor: Colors.redAccent);
              }else{
                controller.Show_Inv_Pay=false;
                controller.update();
                print('Show_Inv_Pay1');
                print(controller.Show_Inv_Pay);
                Navigator.of(context).pop(false);
                controller.editMode();
              }
            },
            icon: Icon( // <--// Icon
              Icons.offline_pin,
              size: 45.0,
              color: Colors.green,
            ),
            label: Text('تأكيد' , style: TextStyle(
                fontSize: Dimensions.fonText, color: Colors.green,
                fontWeight: FontWeight.bold)),
          ),
        ],
      ),
    )));
  }

  GetBuilder<Sale_Invoices_Controller> DropdownACC_CASBuilder() {
    return GetBuilder<Sale_Invoices_Controller>(
        init: Sale_Invoices_Controller(),
        builder: ((controller) => FutureBuilder<List<Acc_Cas_Local>>(
            future: GET_ACC_CAS(controller.SelectDataBIID.toString(),controller.SelectDataSCID.toString(),
                controller.BMKID==1?'BI':controller.BMKID==3?'BO':controller.BMKID==4?'BO':controller.BMKID==5?'BS':'BF',controller.BMKID!),
            builder: (BuildContext context,
                AsyncSnapshot<List<Acc_Cas_Local>> snapshot) {
              if (!snapshot.hasData) {
                return Dropdown(
                  josnStatus: josnStatus,
                  GETSTRING: 'StringCashier',
                );
              }
              return DropdownButtonFormField2(
                decoration: InputDecoration(
                  contentPadding: const EdgeInsets.symmetric(vertical: 13, horizontal: 8),
                  isDense: true,
                  labelText: 'StringCashier'.tr,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(1),
                  ),
                ),
                isDense: true,
                isExpanded: true,
                hint: Text(
                  'StringCashier'.tr,
                  style: TextStyle(
                      fontFamily: 'Hacen',
                      fontSize: Dimensions.fonTextSmall,
                      fontWeight: FontWeight.bold),
                ),
                items: snapshot.data!
                    .map((item) => DropdownMenuItem<String>(
                  value: item.ACID.toString(),
                  child: Text(
                    item.ACNA_D.toString(),
                    style: TextStyle(
                        fontSize: Dimensions.fonTextSmall,
                        fontWeight: FontWeight.bold),
                  ),
                )).toList().obs,
                value: controller.SelectDataACID2,
                onChanged: (value) {
                    controller.SelectDataACID2 = value as String;
                    controller.update();
                },
                dropdownStyleData: const DropdownStyleData(
                  maxHeight: 250,
                ),
              );
            })));
  }

  FutureBuilder<List<Sys_Cur_Local>> DropdownSYS_CURBuilder() {
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
            decoration: InputDecoration(
              isDense: true,
              contentPadding: const EdgeInsets.symmetric(vertical: 13, horizontal: 8),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(1),
              ),
              labelText: "${'StringSCIDlableText'.tr}  ${'Stringexchangerate'.tr} ${controller.SCEXP}-(${controller.BMMTC_TOT})",
              labelStyle: const TextStyle(color: Colors.black54),
            ),
            isExpanded: true,
            hint: Text(
              'StringChi_currency'.tr,
              style: TextStyle(
                  fontFamily: 'Hacen',
                  fontSize: Dimensions.fonTextSmall,
                  fontWeight: FontWeight.bold),
            ),
            iconStyleData: IconStyleData(
              icon: const Icon(
                Icons.arrow_drop_down,
                color: Colors.black45,
              )
            ),
            value: controller.SelectDataSCIDP,
            style: const TextStyle(
                fontFamily: 'Hacen',
                color: Colors.black,
                fontWeight: FontWeight.bold),
            items: snapshot.data!
                .map((item) => DropdownMenuItem<String>(
              value: item.SCID.toString(),
              onTap: () {
                controller.SCEXP = item.SCEX;
                controller.SCSY2 = item.SCSY!;
                controller.update();
              },
              child: Text(
                item.SCNA_D.toString(),
                style: TextStyle(
                    fontSize: Dimensions.fonTextSmall,
                    fontWeight: FontWeight.bold),
              ),
            )).toList().obs,
            validator: (v) {
              if (v == null) {
                return 'StringBrach'.tr;
              };
              return null;
            },
            onChanged: (value) {
              controller.SelectDataSCIDP = value.toString();
              controller.Calculate_BMMTC(controller.BMMCPController.text, value.toString());
              controller.update();
            },
          );
        });
  }

}
