import 'package:flutter/material.dart';
import 'package:flutter_search_bar/flutter_search_bar.dart' as search;
import 'package:get/get.dart';
import '../../../Widgets/colors.dart';

import '../../../Widgets/theme_helper.dart';
import '../../../database/invoices_db.dart';
import '../../../database/setting_db.dart';
import '../../Controllers/sale_invoices_controller.dart';

class Get_Bil_CusView extends StatefulWidget {
  @override
  State<Get_Bil_CusView> createState() => _Get_Bil_CusViewState();
}
class _Get_Bil_CusViewState extends State<Get_Bil_CusView> {
  var isLoading = false;
  late search.SearchBar searchBar;
 final controller=Get.put(Sale_Invoices_Controller());
  String query = '';
  String queryMINO = '';
  @override

  void searchRequestData(String query) {
    final listDatacustmoerRequest = controller.BIL_CUS_List.where((list) {
      final titleLower = list.BCID.toString().toLowerCase();
      final authorLower = list.BCNA_D.toString().toLowerCase();
      final searchLower = query.toLowerCase();
      return titleLower.contains(searchLower) ||
          authorLower.contains(searchLower);
    }).toList();

    setState(() {
      this.query = query;
      controller.BIL_CUS_List = listDatacustmoerRequest;
      if (query == '') {
        controller.GET_BIL_CUS_P();
      }
    });
  }

  void searchRequestDataMINO(String query) {
    final listDatacustmoerMINO = controller.BIL_CRE_C_List.where((list) {
      final titleLower = list.BCCID.toString().toLowerCase();
      final authorLower = list.BCCNA_D.toString().toLowerCase();
      final searchLower = query.toLowerCase();

      return titleLower.contains(searchLower) ||
          authorLower.contains(searchLower);
    }).toList();
    setState(() {
      this.query = query;
      this.queryMINO = query;
      controller.BIL_CRE_C_List = listDatacustmoerMINO;
       if(queryMINO ==''){
         controller.GET_BIL_CRE_C_P();
       }
    });
  }

  void onSubmitted(String value) {
    setState(() => ScaffoldMessenger.of(context).showSnackBar( SnackBar(content:  Text('You wrote $value!'))));
  }

  AppBar buildAppBar(BuildContext context) {
    return  AppBar(
        iconTheme: IconThemeData(color: Colors.white),
      backgroundColor: AppColors.MainColor,
        title:   Text(controller.Type=="1"?'StringCustomer'.tr:'StringCreditCard'.tr,style: TextStyle(color: Colors.white),),
        actions: [
          Padding(
            padding:  EdgeInsets.all(8),
            child: Row(
              children: [
                searchBar.getSearchAction(context),
              ],
            ),
          )
        ]);
  }

  _SearchBarDemoHomeState() {
    searchBar =  search.SearchBar(
        hintText: controller.Type=="1"?'StringSearchBarMGNO'.tr:'StringSearchBarMINO'.tr,
        inBar: false,
        buildDefaultAppBar: buildAppBar,
        setState: setState,
        onSubmitted: onSubmitted,
        onChanged: controller.Type=="1"?searchRequestData:searchRequestDataMINO,
       // onChanged:,
        onCleared: () {
          print("cleared");
          setState(() {
            controller.GET_BIL_CUS_P();
            controller.GET_BIL_CRE_C_P();
          });
        },
        onClosed: () {
          print("closed");
          setState(() {
            controller.GET_BIL_CUS_P();
            controller.GET_BIL_CRE_C_P();
          });
        });
  }

  void initState() {
    // TODO: implement initState
    super.initState();
    _SearchBarDemoHomeState();
    controller.GET_BIL_CUS_P();
    controller.GET_BIL_CRE_C_P();

  }

  Widget build(BuildContext context) {
    return   Scaffold(
      appBar: searchBar.build(context),
      body:controller.Type=="1"?GET_BIL_CUS_W():GET_BIL_CRE_C_W(),
    );
  }

  GET_BIL_CUS_W() {
    return FutureBuilder(
      future:GET_BIL_CUS(),
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        if (!snapshot.hasData) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        } else {
          return ListView.builder(
            itemCount: controller.BIL_CUS_List.length,
            itemBuilder: (BuildContext context, int index) {
              return Card(

                child: Container(
                  color: Colors.white,
                  child: ListTile(
                    title: Center(
                      child: Text("${controller.BIL_CUS_List[index].BCID.toString()} -  ${controller.BIL_CUS_List[index].BCNA_D.toString()} ".toString(),
                          style:  ThemeHelper().buildTextStyle(context, Colors.black,'M')
                      ),
                    ),
                    onTap: () {
                        controller.BCIDController.text=controller.BIL_CUS_List[index].BCID.toString();
                        controller.SelectDataBCID=controller.BIL_CUS_List[index].BCID.toString();
                        controller.BCNAController.text=controller.BIL_CUS_List[index].BCNA_D.toString();
                        controller.AANOController.text=controller.BIL_CUS_List[index].AANO.toString();
                        controller.GUIDC=controller.BIL_CUS_List[index].GUID.toString();
                        controller.update();
                        Get.back(result: 'success');
                     // Navigator.of(context).pop(false);
                    },
                  ),
                ),
              );
            },
          );
        }
      },
    );
  }
  GET_BIL_CRE_C_W() {
    return FutureBuilder(
      future: GET_BIL_CRE_C(controller.SelectDataBIID.toString()),
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        if (!snapshot.hasData) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        } else {
          return ListView.builder(
            itemCount: controller.BIL_CRE_C_List.length,
            itemBuilder: (BuildContext context, int index) {
              return Card(
                child: ListTile(
                  title: Center(
                    child: Text(" ${controller.BIL_CRE_C_List[index].BCCID.toString()} - ${controller.BIL_CRE_C_List[index].BCCNA_D.toString()}".toString(),
                        style: ThemeHelper().buildTextStyle(context, Colors.black,'M')
                    ),
                  ),
                  onTap: () async{
                    controller.BCCIDController.text=controller.BIL_CRE_C_List[index].BCCID.toString();
                    controller.SelectDataBCCID=controller.BIL_CRE_C_List[index].BCCID.toString();
                    controller.BCCNAController.text=controller.BIL_CRE_C_List[index].BCCNA_D.toString();
                    controller.AANOController.text=controller.BIL_CRE_C_List[index].AANO.toString();
                    Navigator.of(context).pop(false);
                  },
                ),
              );
            },
          );
        }
      },
    );
  }
}
