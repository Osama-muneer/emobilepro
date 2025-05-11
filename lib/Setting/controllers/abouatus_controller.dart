import '../controllers/login_controller.dart';
import '../models/mat_inf.dart';
import '../models/mat_pri.dart';
import '../models/mat_uni_b.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../models/sys_com.dart';
import '../../database/setting_db.dart';
import 'package:intl/intl.dart' as intl;

import '../models/usr_pri.dart';

class AboutUsController extends GetxController {
  //TODO: Implement HomeController
  RxBool loading = false.obs;
  final formatter = intl.NumberFormat.decimalPattern();
  late List<Sys_Com_Local> Sys_Com_List = [];
  late List<Mat_Pri_Local> MAT_PRI = [];
  late List<Mat_Uni_B_Local> MAT_UNI_B;
  late List<Mat_Inf_Local> MAT_INF;
  late List<Usr_Pri_Local> USR_PRI;
  late TextEditingController AANAController,TEXTController;
  int? UPIN_PRI=2;

  void onInit() async {
    super.onInit();
    TEXTController = TextEditingController();
    TEXTController.clear();
    GET_PRI_P();
    getAll();
  }

  void dispose() async {
    super.dispose();
    TEXTController.dispose();
  }

String SCNE='',SCWE='';


  //الاستعلام عن سعر التكلفه للاصناف
  Future GET_PRI_P() async {
    PRIVLAGE(LoginController().SUID, 1293).then((data) {
      USR_PRI = data;
      if (USR_PRI.isNotEmpty) {
        UPIN_PRI = USR_PRI.elementAt(0).UPIN;
      } else {
        UPIN_PRI = 2;
      }
    });
  }

  getAll() {
    loading(true);
      GetSysCom().then((data) {
        Sys_Com_List = data;
        SCNE=Sys_Com_List.elementAt(0).SCNE.toString();
        SCWE=Sys_Com_List.elementAt(0).SCWE.toString();
        loading(false);
      });
  }

  GET_MAT_PRI_P(int GETBIID,String GETMINA,String GETMUCBC,int GETSCID) {
    GET_MAT_PRI( GETBIID, GETMINA, GETMUCBC, GETSCID).then((data) {
      MAT_PRI = data;
      update();
      });
  }

  GET_MAT_UNI_B_P(String GETMUCBC) {
    GET_MAT_UNI_B(GETMUCBC).then((data) {
      MAT_UNI_B = data;
      if(MAT_UNI_B.isNotEmpty){
        GET_MAT_PRI_P(LoginController().BIID,MAT_UNI_B.elementAt(0).MGNO.toString(),MAT_UNI_B.elementAt(0).MINO.toString(),1);
        update();
      }else{
        GET_MAT_INF(GETMUCBC).then((data) {
          MAT_INF = data;
          if(MAT_INF.isNotEmpty){
            GET_MAT_PRI_P(LoginController().BIID,MAT_INF.elementAt(0).MGNO.toString(),MAT_INF.elementAt(0).MINO.toString(),1);
            update();
          }
        });
      }
      update();
      });
  }

  clear(){
    TEXTController.clear();
    MAT_PRI.clear();
    update();
  }

}
