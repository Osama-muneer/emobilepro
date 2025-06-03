import 'package:dio/dio.dart';
import '../../Setting/models/eco_var.dart';
import '../../Setting/models/acc_acc.dart';
import '../../Setting/models/acc_ban.dart';
import '../../Setting/models/acc_cas.dart';
import '../../Setting/models/acc_cas_u.dart';
import '../../Setting/models/acc_cos.dart';
import '../../Setting/models/acc_mov_k.dart';
import '../../Setting/models/acc_tax_t.dart';
import '../../Setting/models/acc_usr.dart';
import '../../Setting/models/bal_acc_c.dart';
import '../../Setting/models/bal_acc_d.dart';
import '../../Setting/models/bal_acc_m.dart';
import '../../Setting/models/bif_cus_d.dart';
import '../../Setting/models/bif_gro.dart';
import '../../Setting/models/bif_gro2.dart';
import '../../Setting/models/bil_are.dart';
import '../../Setting/models/bil_cre_c.dart';
import '../../Setting/models/bil_cus.dart';
import '../../Setting/models/bil_cus_t.dart';
import '../../Setting/models/bil_dis.dart';
import '../../Setting/models/bil_imp.dart';
import '../../Setting/models/bil_mov_k.dart';
import '../../Setting/models/bil_poi.dart';
import '../../Setting/models/bil_poi_u.dart';
import '../../Setting/models/bil_usr_d.dart';
import '../../Setting/models/bra_inf.dart';
import '../../Setting/models/cos_usr.dart';
import '../../Setting/models/cou_tow.dart';
import '../../Setting/models/cou_wrd.dart';
import '../../Setting/models/ide_lin.dart';
import '../../Setting/models/ide_typ.dart';
import '../../Setting/models/mat_des_d.dart';
import '../../Setting/models/mat_des_m.dart';
import '../../Setting/models/mat_fol.dart';
import '../../Setting/models/mat_gro.dart';
import '../../Setting/models/mat_inf.dart';
import '../../Setting/models/mat_uni.dart';
import '../../Setting/models/mat_uni_b.dart';
import '../../Setting/models/pay_kin.dart';
import '../../Setting/models/res_emp.dart';
import '../../Setting/models/res_sec.dart';
import '../../Setting/models/res_tab.dart';
import '../../Setting/models/shi_inf.dart';
import '../../Setting/models/shi_usr.dart';
import '../../Setting/models/sto_num.dart';
import '../../Setting/models/syn_dat.dart';
import '../../Setting/models/sys_cur.dart';
import '../../Setting/models/sys_cur_bet.dart';
import '../../Setting/models/sys_cur_d.dart';
import '../../Setting/models/sys_ref.dart';
import '../../Setting/models/tax_cod.dart';
import '../../Setting/models/tax_cod_sys.dart';
import '../../Setting/models/tax_cod_sys_d.dart';
import '../../Setting/models/tax_lin.dart';
import '../../Setting/models/tax_loc.dart';
import '../../Setting/models/tax_loc_sys.dart';
import '../../Setting/models/tax_mov_sin.dart';
import '../../Setting/models/tax_sys.dart';
import '../../Setting/models/tax_sys_bra.dart';
import '../../Setting/models/tax_sys_d.dart';
import '../../Setting/models/tax_tbl_lnk.dart';
import '../../Setting/models/tax_typ.dart';
import '../../Setting/models/tax_typ_bra.dart';
import '../../Setting/models/tax_typ_sys.dart';
import '../../Setting/models/tax_var.dart';
import '../../Setting/models/tax_var_d.dart';
import '../../Widgets/theme_helper.dart';
import 'package:get/get.dart';
import '../../Setting/controllers/login_controller.dart';
import '../../Setting/controllers/sync_controller.dart';
import '../../Setting/models/bra_yea.dart';
import '../../Setting/models/gen_var.dart';
import '../../Setting/models/gro_usr.dart';
import '../../Setting/models/mat_inf_a.dart';
import '../../Setting/models/mat_pri.dart';
import '../../Setting/models/sto_inf.dart';
import '../../Setting/models/sto_usr.dart';
import '../../Setting/models/syn_ord.dart';
import '../../Setting/models/sys_doc_d.dart';
import '../../Setting/models/sys_own.dart';
import '../../Setting/models/sys_scr.dart';
import '../../Setting/models/sys_usr.dart';
import '../../Setting/models/sys_usr_b.dart';
import '../../Setting/models/sys_var.dart';
import '../../Setting/models/usr_pri.dart';
import '../../Widgets/config.dart';
import '../../database/sync_db.dart';
import 'package:intl/intl.dart';
import '../models/acc_tax_c.dart';
import '../models/cou_inf_m.dart';
import '../models/cou_poi_l.dart';
import '../models/cou_red.dart';
import '../models/cou_typ_m.dart';
import '../models/cou_usr.dart';
import '../models/eco_acc.dart';
import '../models/eco_msg_acc.dart';
import '../models/fat_api_inf.dart';
import '../models/fat_csid_inf.dart';
import '../models/fat_csid_inf_d.dart';
import '../models/fat_csid_seq.dart';
import '../models/fat_csid_st.dart';
import '../models/fat_que.dart';
import '../models/mat_dis_d.dart';
import '../models/mat_dis_f.dart';
import '../models/mat_dis_k.dart';
import '../models/mat_dis_l.dart';
import '../models/mat_dis_m.dart';
import '../models/mat_dis_s.dart';
import '../models/mat_dis_t.dart';
import '../models/mat_inf_d.dart';
import '../models/mat_mai_m.dart';
import '../models/mat_uni_c.dart';
import '../models/sto_mov_k.dart';
import '../models/syn_off_m.dart';
import '../models/syn_off_m2.dart';
import '../models/syn_set.dart';
import '../models/syn_tas.dart';
import '../models/tax_mov_d.dart';
import '../models/tax_per_bra.dart';
import '../models/tax_per_d.dart';
import '../models/tax_per_m.dart';

class ApiProvider {
  final SyncController controller = Get.find();

  late var params = {
    "STMID_CO_V": STMID,
    "SYDV_NAME_V": LoginController().DeviceName,
    "SYDV_IP_V": LoginController().IP,
    "SYDV_TY_V":  LoginController().SYDV_TY,
    "SYDV_SER_V": LoginController().DeviceID,
    "SYDV_POI_V": "",
    "SYDV_ID_V": LoginController().SYDV_ID,
    "SYDV_NO_V": LoginController().SYDV_NO,
    "SYDV_BRA_V": 1,
    "SYDV_LATITUDE_V": "",
    "SYDV_LONGITUDE_V": "",
    "SYDV_APPV_V": LoginController().APPV,
    "SOID_V": SOID_V,
    "STID_V": "",
    "TBNA_V": TAB_N,
    "LAN_V":LoginController().LAN,
    "CIID_V":LoginController().CIID,
    "JTID_V":LoginController().JTID,
    "BIID_V":LoginController().BIID,
    "SYID_V":LoginController().SYID,
    "SUID_V":LoginController().SUID,
    "SUPA_V":LoginController().SUPA,
    "F_ROW_V":controller.F_ROW_V.toString(),
    "T_ROW_V":controller.T_ROW_V.toString(),
    "F_DAT_V": (FROM_DATE=='null' || controller.TypeSyncAll==1) ? '' : FROM_DATE,
    "T_DAT_V": (FROM_DATE=='null' || controller.TypeSyncAll==1) ? '' :DateFormat('dd-MM-yyyy HH:mm:ss').format(DateTime.now()),
    "F_GUID_V": '',
    "WH_V1":'',
    "PAR_V":"",
    "JSON_V":PAR_V,
    "JSON_V2":"",
    "JSON_V3":""
  };
  late var params2 = {
    "STMID_CO_V": STMID,
    "SYDV_NAME_V": LoginController().DeviceName,
    "SYDV_IP_V": LoginController().IP,
    "SYDV_TY_V":  LoginController().SYDV_TY,
    "SYDV_SER_V": LoginController().DeviceID,
    "SYDV_POI_V":"",
    "SYDV_ID_V":LoginController().SYDV_ID,
    "SYDV_NO_V":LoginController().SYDV_NO,
    "SYDV_BRA_V":1,
    "SYDV_LATITUDE_V":"",
    "SYDV_LONGITUDE_V":"",
    "SYDV_APPV_V":LoginController().APPV,
    "SOID_V":SOID_V,
    "STID_V":"",
    "TBNA_V":TAB_N,
    "LAN_V":LoginController().LAN,
    "CIID_V":LoginController().CIID,
    "JTID_V":LoginController().JTID,
    "BIID_V":LoginController().BIID,
    "SYID_V":LoginController().SYID,
    "SUID_V" : LoginController().SUID,
    "SUPA_V" : LoginController().SUPA,
    "F_ROW_V" :'0',
    "T_ROW_V" :'0',
    //LoginController().CHIKE_ALL_MAIN==0
    "F_DAT_V" : LoginController().CHIKE_ALL_MAIN==0?'':
    (FROM_DATE=='null' || (controller.TypeSyncAll==1 && controller.TypeSync!=2)) ? '' : FROM_DATE,
    "T_DAT_V" : LoginController().CHIKE_ALL_MAIN==0?'':
    (FROM_DATE=='null' || (controller.TypeSyncAll==1 && controller.TypeSync!=2)) ? '' :DateFormat('dd-MM-yyyy HH:mm:ss').format(DateTime.now()),
    "F_GUID_V":'',
    "WH_V1":'',
    "PAR_V":"",
    "JSON_V":PAR_V,
    "JSON_V2":"",
    "JSON_V3":""
  };
  late var Syn_DatParams = {
    "STMID_CO_V": STMID,
    "SYDV_NAME_V": LoginController().DeviceName,
    "SYDV_IP_V": LoginController().IP,
    "SYDV_TY_V":  LoginController().SYDV_TY,
    "SYDV_SER_V": LoginController().DeviceID,
    "SYDV_POI_V":"",
    "SYDV_ID_V":LoginController().SYDV_ID,
    "SYDV_NO_V":LoginController().SYDV_NO,
    "SYDV_BRA_V":1,
    "SYDV_LATITUDE_V":"",
    "SYDV_LONGITUDE_V":"",
    "SYDV_APPV_V":LoginController().APPV,
    "SOID_V":SOID_V,
    "STID_V":"",
    "TBNA_V":'SYN_DAT',
    "LAN_V":LoginController().LAN,
    "CIID_V":LoginController().CIID,
    "JTID_V":LoginController().JTID,
    "BIID_V":LoginController().BIID,
    "SYID_V":LoginController().SYID,
    "SUID_V":LoginController().SUID,
    "SUPA_V":LoginController().SUPA,
    "F_ROW_V":controller.F_ROW_V.toString(),
    "T_ROW_V":controller.T_ROW_V.toString(),
    "F_DAT_V": controller.LastSYN_DAT,
    "T_DAT_V": DateFormat('dd-MM-yyyy HH:mm:ss').format(DateTime.now()),
    "F_GUID_V":'',
    "WH_V1":'',
    "PAR_V":"",
    "JSON_V":PAR_V,
    "JSON_V2":"",
    "JSON_V3":""
  };


  Future<dynamic> GetAllSYN_ORD() async {
    var url = "${LoginController().baseApi}/ESAPI/ESGET";
    print('${url}/SYN_ORD');

    try {
      var response = await Dio().get(url, queryParameters: params2);
      if (response.statusCode == 200) {
        List<dynamic> arr = response.data['result'];
        controller.arrlength=arr.length;
        print('SYN_ORD');
        // printLongText(response.data.toString());
        // print(params2);
        return (response.data)['result'].map((data) {
          SaveSYN_ORD(SYN_ORD_Local.fromMap(data));
          INSERT_SYN_LOG('SYN_ORD', '${controller.SLIN}', 'D');
        }).toList();
      } else if (response.statusCode == 207) {
        LoginController().Timer_Strat==1?
        ThemeHelper().ShowToastW(response.data.toString()):false;
        INSERT_SYN_LOG('SYN_ORD',response.data,'D');
        controller.CheckSync(false);
        print("response error: ${response.data}");
      }
      else {
        LoginController().Timer_Strat==1?
        ThemeHelper().ShowToastW(response.data.toString()):false;
        print("response error: ${response.data}");
        INSERT_SYN_LOG('SYN_ORD',response.data,'D');
        controller.CheckSync(false);
        throw Exception("response error: ${response.data}");
      }
    } on DioException catch (e) {
      LoginController().Timer_Strat==1?
      ThemeHelper().ShowToastW(e.error.toString()):false;
      print("response error: ${e.error}");
      INSERT_SYN_LOG('SYN_ORD',e.error,'D');
      controller.CheckSync(false);
      return Future.error("DioError: ${e.error}");
    }
  }

  Future<dynamic> GetAllGEN_VAR() async {
    var url = "${LoginController().baseApi}/ESAPI/ESGET";
    print("$url/GEN_VAR");
    print('${params2}/SYN_ORD');
    try {
      var response = await Dio().get(url, queryParameters: params2);
      if (response.statusCode == 200 ) {
        List<dynamic> arr = response.data['result'];
        controller.arrlength=arr.length;
        return (response.data)['result'].map((data) {
          SaveGEN_VAR(Gen_Var_Local.fromMap(data));
          INSERT_SYN_LOG('GEN_VAR', '${controller.SLIN}', 'D');
        }).toList();
      }
      else if (response.statusCode == 207) {
        print(' response.statusCode ${response.statusCode}''${response.data}');
        LoginController().Timer_Strat==1?
        ThemeHelper().ShowToastW(response.data.toString()):false;
        INSERT_SYN_LOG('GEN_VAR',response.data,'D');
        controller.CheckSync(false);
      }
      else {
        LoginController().Timer_Strat==1?
        ThemeHelper().ShowToastW(response.data.toString()):false;
        INSERT_SYN_LOG('GEN_VAR',response.data,'D');
        controller.CheckSync(false);
        throw Exception("response error: ${response.data}");
      }
    } on DioException catch (e) {
      LoginController().Timer_Strat==1?
      ThemeHelper().ShowToastW(e.error.toString()):false;
      INSERT_SYN_LOG('GEN_VAR',e.error,'D');
      controller.CheckSync(false);
      return Future.error("DioError: ${e.error}");
    }
  }

  Future<dynamic> GetAllSYN_TAS() async {
    var url = "${LoginController().baseApi}/ESAPI/ESGET";
    print("$url/SYN_TAS");
    // print("$params2/SYN_TAS");
    try {
      var response = await Dio().get(url, queryParameters: params2);
      if (response.statusCode == 200 ) {
        List<dynamic> arr = response.data['result'];
        print('SaveSYN_TAS');
        return (response.data)['result'].map((data) {
          SaveSYN_TAS(Syn_Tas_Local.fromMap(data));
        }).toList();
      }
      else if (response.statusCode == 207) {
        print(' response.statusCode ${response.statusCode}''${response.data}');
        // LoginController().Timer_Strat==1?
        // ThemeHelper().ShowToastW(response.data.toString()):false;
        INSERT_SYN_LOG(TAB_N,response.data,'D');
        // controller.CheckSync(false);
      }
      else {
        // LoginController().Timer_Strat==1?
        // ThemeHelper().ShowToastW(response.data.toString()):false;
        INSERT_SYN_LOG(TAB_N,response.data,'D');
        // controller.CheckSync(false);
        throw Exception("response error: ${response.data}");
      }
    } on DioException catch (e) {
      // LoginController().Timer_Strat==1?
      // ThemeHelper().ShowToastW(e.error.toString()):false;
      INSERT_SYN_LOG(TAB_N,e.error,'D');
      // controller.CheckSync(false);
      return Future.error("DioError");
      return Future.error("DioError: ${e.error}");
    }
  }

  Future<dynamic> GetAllSYN_DAT(GetGUIDMap) async {
    var url = "${LoginController().baseApi}/ESAPI/ESGET";
    print("$url/SYN_DAT");
    // print("$Syn_DatParams/SYN_DAT");
    try {
      var response = await Dio().get(url, queryParameters: Syn_DatParams);
      if (response.statusCode == 200 && controller.MyGUIDMap[GetGUIDMap]==1) {
        List<dynamic> arr = response.data['result'];
        controller.arrlength=arr.length;
        return (response.data)['result'].map((data) {
          SYN_DATList.add(Syn_Dat_Local.fromMap(data));
          // return (response.data)['result'].map((data) {
          //   SaveSYN_DAT(Syn_Dat_Local.fromMap(data));
        }).toList();
      } else if (response.statusCode == 207) {
        print(' response.statusCode ${response.statusCode}''${response.data}');
        ThemeHelper().ShowToastW(response.data.toString());
        INSERT_SYN_LOG(TAB_N,response.data,'D');
        controller.CheckSync(false);
      }
      else {
        ThemeHelper().ShowToastW(response.data.toString());
        INSERT_SYN_LOG(TAB_N,response.data,'D');
        controller.CheckSync(false);
        throw Exception("response error: ${response.data}");
      }
    } on DioException catch (e) {
      ThemeHelper().ShowToastW(e.error.toString());
      INSERT_SYN_LOG(TAB_N,e.error,'D');
      controller.CheckSync(false);
      return Future.error("DioError: ${e.error}");
    }
  }

  // دالة عامة لجلب البيانات
  Future<dynamic> FetchData(String endpoint, Function fromMapFunction, String getGUIDMap) async {
    var url = "${LoginController().API}/ESAPI/ESGET";
    print("$url/$endpoint");
    print("$url/$params");
    try {
      var response = await Dio().get(url, queryParameters: params);

      if (response.statusCode == 200 && controller.MyGUIDMap[getGUIDMap] == 1) {
        List<dynamic> arr = response.data['result'];
        print("$arr");
        controller.arrlength = arr.length;
        return arr.map((data) {
          return fromMapFunction(data);
        }).toList();
      } else if (response.statusCode == 207) {
        print('response.statusCode ${response.statusCode} ${response.data}');
        ThemeHelper().ShowToastW(response.data.toString());
        INSERT_SYN_LOG(TAB_N, response.data, 'D');
        controller.CheckSync(false);
      } else {
        ThemeHelper().ShowToastW(response.data.toString());
        INSERT_SYN_LOG(TAB_N, response.data, 'D');
        controller.CheckSync(false);
        throw Exception("response error: ${response.data}");
      }
    } on DioException catch (e) {
      ThemeHelper().ShowToastW(e.error.toString());
      INSERT_SYN_LOG(TAB_N, e.error, 'D');
      controller.CheckSync(false);
      return Future.error("response error: ${e.error}");
    }
  }

  // دالة لجلب بيانات أنواع القيود
  Future<dynamic> GetAllACC_MOV_K(GetGUIDMap) async {
    return await FetchData('ACC_MOV_K', (data) => SaveACC_MOV_K(Acc_Mov_K_Local.fromMap(data)), GetGUIDMap);
  }

// دالة لجلب المتغيرات العامة
  Future<dynamic> GetAllSYS_VAR(GetGUIDMap) async {
    return await FetchData('SYS_VAR', (data) => SaveSYS_VAR(Sys_Var_Local.fromMap(data)), GetGUIDMap);
  }

// دالة لجلب بيانات المنشأة
  Future<dynamic> GetAllSYS_OWN(GetGUIDMap) async {
    return await FetchData('SYS_OWN', (data) => SaveSYS_OWN(Sys_Own_Local.fromMap(data)), GetGUIDMap);
  }

// دالة لجلب بيانات الفروع
  Future<dynamic> GetAllBRA_INF(GetGUIDMap) async {
    return await FetchData('BRA_INF', (data) => SaveBRA_INF(Bra_Inf_Local.fromMap(data)), GetGUIDMap);
  }

// دالة لجلب بيانات المستخدمين
  Future<dynamic> GetAllSYS_USR(GetGUIDMap) async {
    return await FetchData('SYS_USR', (data) => SaveSYS_USR(Sys_Usr_Local.fromMap(data)), GetGUIDMap);
  }

// دالة لجلب صلاحيات المستخدمين
  Future<dynamic> GetAllUSR_PRI(GetGUIDMap) async {
    return await FetchData('USR_PRI', (data) => SaveUSR_PRI(Usr_Pri_Local.fromMap(data)), GetGUIDMap);
  }

// دالة لجلب صلاحيات الفروع
  Future<dynamic> GetAllSYS_USR_B(GetGUIDMap) async {
    return await FetchData('SYS_USR_B', (data) => SaveSYS_USR_B(Sys_Usr_B_Local.fromMap(data)), GetGUIDMap);
  }

  // دالة لجلب أنواع حركات الفواتير
  Future<dynamic> GetAllBIL_MOV_K(GetGUIDMap) async {
    return await FetchData('BIL_MOV_K', (data) => SaveBIL_MOV_K(Bil_Mov_K_Local.fromMap(data)), GetGUIDMap);
  }

// دالة لجلب أنواع حركات المخازن
  Future<dynamic> GetAllSTO_MOV_K(GetGUIDMap) async {
    return await FetchData('STO_MOV_K', (data) => SaveSTO_MOV_K(Sto_Mov_K_Local.fromMap(data)), GetGUIDMap);
  }
// دالة لجلب بيانات المخازن
  Future<dynamic> GetAllSto_Inf(GetGUIDMap) async {
    return await FetchData('Sto_Inf', (data) => SaveSto_Inf(Sto_Inf_Local.fromMap(data)), GetGUIDMap);
  }

// دالة لجلب صلاحيات المخازن
  Future<dynamic> GetAllSTO_USR(GetGUIDMap) async {
    return await FetchData('STO_USR', (data) => SaveSTO_USR(Sto_Usr_Local.fromMap(data)), GetGUIDMap);
  }

// دالة لجلب بيانات المجموعات
  Future<dynamic> GetAllMAT_GRO(GetGUIDMap) async {
    return await FetchData('MAT_GRO', (data) => SaveMAT_GRO(Mat_Gro_Local.fromMap(data)), GetGUIDMap);
  }

  // دالة لجلب صلاحيات المجموعات
  Future<dynamic> GetAllGRO_USR(GetGUIDMap) async {
    return await FetchData('GRO_USR', (data) => SaveGRO_USR(Gro_Usr_Local.fromMap(data)), GetGUIDMap);
  }

// دالة لجلب بيانات الأصناف
  Future<dynamic> GetAllMAT_INF(GetGUIDMap) async {
    return await FetchData('MAT_INF', (data) => SaveMAT_INF(Mat_Inf_Local.fromMap(data)), GetGUIDMap);
  }

// دالة لجلب بيانات الوحدات
  Future<dynamic> GetAllMAT_UNI(GetGUIDMap) async {
    return await FetchData('MAT_UNI', (data) => SaveMAT_UNI(Mat_Uni_Local.fromMap(data)), GetGUIDMap);
  }

// دالة لجلب ترتيب وحدات الأصناف
  Future<dynamic> GetAllMAT_UNI_C(GetGUIDMap) async {
    return await FetchData('MAT_UNI_C', (data) => SaveMAT_UNI_C(Mat_Uni_C_Local.fromMap(data)), GetGUIDMap);
  }

// دالة لجلب الباركود
  Future<dynamic> GetAllMAT_UNI_B(GetGUIDMap) async {
    return await FetchData('MAT_UNI_B', (data) => SaveMAT_UNI_B(Mat_Uni_B_Local.fromMap(data)), GetGUIDMap);
  }

// دالة لجلب الكمية المخزنية
  Future<dynamic> GetAllSTO_NUM(GetGUIDMap) async {
    return await FetchData('STO_NUM', (data) => SaveSTO_NUM(Sto_Num_Local.fromMap(data)), GetGUIDMap);
  }

// دالة لجلب رقم القطعة
  Future<dynamic> GetAllMAT_INF_A(GetGUIDMap) async {
    return await FetchData('MAT_INF_A', (data) => SaveMAT_INF_A(Mat_Inf_A_Local.fromMap(data)), GetGUIDMap);
  }

// دالة لجلب بيانات MAT_INF_D
  Future<dynamic> GetAllMAT_INF_D(GetGUIDMap) async {
    return await FetchData('MAT_INF_D', (data) => SaveMAT_INF_D(Mat_Inf_D_Local.fromMap(data)), GetGUIDMap);
  }

// دالة لجلب الأصناف التابعة/المرتبطة
  Future<dynamic> GetAllMAT_FOL(GetGUIDMap) async {
    return await FetchData('MAT_FOL', (data) => SaveMAT_FOL(Mat_Fol_Local.fromMap(data)), GetGUIDMap);
  }

// دالة لجلب مواصفات/ملاحظات سريعة للأصناف
  Future<dynamic> GetAllMAT_DES_M(GetGUIDMap) async {
    return await FetchData('MAT_DES_M', (data) => SaveMAT_DES_M(Mat_Des_M_Local.fromMap(data)), GetGUIDMap);
  }

// دالة لجلب مواصفات/ملاحظات سريعة للاصناف-فرعي
  Future<dynamic> GetAllMAT_DES_D(GetGUIDMap) async {
    return await FetchData('MAT_DES_D', (data) => SaveMAT_DES_D(Mat_Des_D_Local.fromMap(data)), GetGUIDMap);
  }

// دالة لجلب تسعيرة الاصناف
  Future<dynamic> GetAllMAT_PRI(GetGUIDMap) async {
    return await FetchData('MAT_PRI', (data) => SaveMAT_PRI(Mat_Pri_Local.fromMap(data)), GetGUIDMap);
  }

// دالة لجلب SYS_DOC_D
  Future<dynamic> GetAllSYS_DOC_D(GetGUIDMap) async {
    return await FetchData('SYS_DOC_D', (data) => SaveSYS_DOC_D(Sys_Doc_D_Local.fromMap(data)), GetGUIDMap);
  }

// دالة لجلب صلاحيات
  Future<dynamic> GetAllBra_Yea(GetGUIDMap) async {
    return await FetchData('Bra_Yea', (data) => SaveBRA_YEA(Bra_Yea_Local.fromMap(data)), GetGUIDMap);
  }

// دالة لجلب الشاشات
  Future<dynamic> GetAllSYS_SCR(GetGUIDMap) async {
    return await FetchData('SYS_SCR', (data) => SaveSYS_SCR(Sys_Scr_Local.fromMap(data)), GetGUIDMap);
  }

// دالة لجلب BIL_CUS_T
  Future<dynamic> GetAllBIL_CUS_T(GetGUIDMap) async {
    return await FetchData('BIL_CUS_T', (data) => SaveBIL_CUS_T(Bil_Cus_T_Local.fromMap(data)), GetGUIDMap);
  }

// دالة لجلب العملاء
  Future<dynamic> GetAllBIL_CUS(GetGUIDMap) async {
    return await FetchData('BIL_CUS', (data) => SaveBIL_CUS(Bil_Cus_Local.fromMap(data)), GetGUIDMap);
  }

// دالة لجلب العملاء الفرعيين
  Future<dynamic> GetAllBIF_CUS_D(GetGUIDMap) async {
    return await FetchData('BIF_CUS_D', (data) => SaveBIF_CUS_D(Bif_Cus_D_Local.fromMap(data)), GetGUIDMap);
  }

// بيانات المندوبين
  Future<dynamic> GetAllBIL_DIS(GetGUIDMap) async {
    return await FetchData('BIL_DIS', (data) => SaveBIL_DIS(Bil_Dis_Local.fromMap(data)), GetGUIDMap);
  }

// فترات العمل
  Future<dynamic> GetAllSHI_INF(GetGUIDMap) async {
    return await FetchData('SHI_INF', (data) => SaveSHI_INF(Shi_Inf_Local.fromMap(data)), GetGUIDMap);
  }

// ربط فترات العمل بالنقاط والمستخدمين
  Future<dynamic> GetAllSHI_USR(GetGUIDMap) async {
    return await FetchData('SHI_USR', (data) => SaveSHI_USR(Shi_Usr_Local.fromMap(data)), GetGUIDMap);
  }

// نقاط البيع
  Future<dynamic> GetAllBIL_POI(GetGUIDMap) async {
    return await FetchData('BIL_POI', (data) => SaveBIL_POI(Bil_Poi_Local.fromMap(data)), GetGUIDMap);
  }

// ربط نقاط البيع بالمستخدمين
  Future<dynamic> GetAllBIL_POI_U(GetGUIDMap) async {
    return await FetchData('BIL_POI_U', (data) => SaveBIL_POI_U(Bil_Poi_U_Local.fromMap(data)), GetGUIDMap);
  }

// الموردين
  Future<dynamic> GetAllBIL_IMP(GetGUIDMap) async {
    return await FetchData('BIL_IMP', (data) => SaveBIL_IMP(Bil_Imp_Local.fromMap(data)), GetGUIDMap);
  }

// الدول
  Future<dynamic> GetAllCOU_WRD(GetGUIDMap) async {
    return await FetchData('COU_WRD', (data) => SaveCOU_WRD(Cou_Wrd_Local.fromMap(data)), GetGUIDMap);
  }

// الدليل المحاسبي
  Future<dynamic> GetAllACC_ACC(GetGUIDMap) async {
    return await FetchData('ACC_ACC', (data) => SaveACC_ACC(Acc_Acc_Local.fromMap(data)), GetGUIDMap);
  }

// المدن
  Future<dynamic> GetAllCOU_TOW(GetGUIDMap) async {
    return await FetchData('COU_TOW', (data) => SaveCOU_TOW(Cou_Tow_Local.fromMap(data)), GetGUIDMap);
  }

// نسب التخفيض للموظفين
  Future<dynamic> GetAllBIL_USR_D(GetGUIDMap) async {
    return await FetchData('BIL_USR_D', (data) => SaveBIL_USR_D(Bil_Usr_D_Local.fromMap(data)), GetGUIDMap);
  }

// التسلسل
  Future<dynamic> GetAllSYS_REF(GetGUIDMap) async {
    return await FetchData('SYS_REF', (data) => SaveSYS_REF(Sys_Ref_Local.fromMap(data)), GetGUIDMap);
  }

// مراكز التكلفة
  Future<dynamic> GetAllACC_COS(GetGUIDMap) async {
    return await FetchData('ACC_COS', (data) => SaveACC_COS(Acc_Cos_Local.fromMap(data)), GetGUIDMap);
  }

// المناطق
  Future<dynamic> GetAllBIL_ARE(GetGUIDMap) async {
    return await FetchData('BIL_ARE', (data) => SaveBIL_ARE(Bil_Are_Local.fromMap(data)), GetGUIDMap);
  }

// المستخدمين ومراكز التكلفة
  Future<dynamic> GetAllCOS_USR(GetGUIDMap) async {
    return await FetchData('COS_USR', (data) => SaveCOS_USR(Cos_Usr_Local.fromMap(data)), GetGUIDMap);
  }

// أنواع الدفع
  Future<dynamic> GetAllPAY_KIN(GetGUIDMap) async {
    return await FetchData('PAY_KIN', (data) => SavePAY_KIN(Pay_Kin_Local.fromMap(data)), GetGUIDMap);
  }

// العملات
  Future<dynamic> GetAllSYS_CUR(GetGUIDMap) async {
    return await FetchData('SYS_CUR', (data) => SaveSYS_CUR(Sys_Cur_Local.fromMap(data)), GetGUIDMap);
  }

// العملات - فرعي
  Future<dynamic> GetAllSYS_CUR_D(GetGUIDMap) async {
    return await FetchData('SYS_CUR_D', (data) => SaveSYS_CUR_D(Sys_Cur_D_Local.fromMap(data)), GetGUIDMap);
  }

// التحويل بين العملات
  Future<dynamic> GetAllSYS_CUR_BET(GetGUIDMap) async {
    return await FetchData('SYS_CUR_BET', (data) => SaveSYS_CUR_BET(Sys_Cur_Bet_Local.fromMap(data)), GetGUIDMap);
  }

// إعدادات الصناديق
  Future<dynamic> GetAllACC_CAS(GetGUIDMap) async {
    return await FetchData('ACC_CAS', (data) => SaveACC_CAS(Acc_Cas_Local.fromMap(data)), GetGUIDMap);
  }

// صلاحيات الصناديق
  Future<dynamic> GetAllACC_CAS_U(GetGUIDMap) async {
    return await FetchData('ACC_CAS_U', (data) => SaveACC_CAS_U(Acc_Cas_U_Local.fromMap(data)), GetGUIDMap);
  }

// المستخدمين والحسابات
  Future<dynamic> GetAllACC_USR(GetGUIDMap) async {
    return await FetchData('ACC_USR', (data) => SaveACC_USR(Acc_Usr_Local.fromMap(data)), GetGUIDMap);
  }

// بطائق الائتمان
  Future<dynamic> GetAllBIL_CRE_C(GetGUIDMap) async {
    return await FetchData('BIL_CRE_C', (data) => SaveBIL_CRE_C(Bil_Cre_C_Local.fromMap(data)), GetGUIDMap);
  }

// البنوك
  Future<dynamic> GetAllACC_BAN(GetGUIDMap) async {
    return await FetchData('ACC_BAN', (data) => SaveAcc_Ban(Acc_Ban_Local.fromMap(data)), GetGUIDMap);
  }

// التصنيف الضريبي
  Future<dynamic> GetAllACC_TAX_T(GetGUIDMap) async {
    return await FetchData('ACC_TAX_T', (data) => SaveACC_TAX_T(Acc_Tax_T_Local.fromMap(data)), GetGUIDMap);
  }

// ارصده الحسابات - رئيسي
  Future<dynamic> GetAllBAL_ACC_M(GetGUIDMap) async {
    var url = "${LoginController().baseApi}/ESAPI/ESGET";
    return await FetchData('BAL_ACC_M', (data) => SaveBAL_ACC_M(Bal_Acc_M_Local.fromMap(data)), GetGUIDMap);
  }

// ارصده الحسابات - اجمالي
  Future<dynamic> GetAllBAL_ACC_C(GetGUIDMap) async {
    var url = "${LoginController().baseApi}/ESAPI/ESGET";
    return await FetchData('BAL_ACC_C', (data) => SaveBAL_ACC_C(Bal_Acc_C_Local.fromMap(data)), GetGUIDMap);
  }

// ارصده الحسابات - فرعي
  Future<dynamic> GetAllBAL_ACC_D(GetGUIDMap) async {
    var url = "${LoginController().baseApi}/ESAPI/ESGET";
    return await FetchData('BAL_ACC_D', (data) => SaveBAL_ACC_D(Bal_Acc_D_Local.fromMap(data)), GetGUIDMap);
  }

// أكواد الضريبة
  Future<dynamic> GetAllTAX_COD(GetGUIDMap) async {
    return await FetchData('TAX_COD', (data) => SaveTAX_COD(Tax_Cod_Local.fromMap(data)), GetGUIDMap);
  }

// أكواد الضريبة - نظام
  Future<dynamic> GetAllTAX_COD_SYS(GetGUIDMap) async {
    return await FetchData('TAX_COD_SYS', (data) => SaveTAX_COD_SYS(Tax_Cod_Sys_Local.fromMap(data)), GetGUIDMap);
  }
// دوال لتحميل البيانات المختلفة
  Future<dynamic> GetAllTAX_COD_SYS_D(GetGUIDMap) async {
    return await FetchData('TAX_COD_SYS_D', (data) => SaveTAX_COD_SYS_D(Tax_Cod_Sys_D_Local.fromMap(data)), GetGUIDMap);
  }

  Future<dynamic> GetAllTAX_LOC(GetGUIDMap) async {
    return await FetchData('TAX_LOC', (data) => SaveTAX_LOC(Tax_Loc_Local.fromMap(data)), GetGUIDMap);
  }

  Future<dynamic> GetAllTAX_LOC_SYS(GetGUIDMap) async {
    return await FetchData('TAX_LOC_SYS', (data) => SaveTAX_LOC_SYS(Tax_Loc_Sys_Local.fromMap(data)), GetGUIDMap);
  }

  Future<dynamic> GetAllTAX_MOV_SIN(GetGUIDMap) async {
    return await FetchData('TAX_MOV_SIN', (data) => SaveTAX_MOV_SIN(Tax_Mov_Sin_Local.fromMap(data)), GetGUIDMap);
  }

  Future<dynamic> GetAllTAX_SYS(GetGUIDMap) async {
    return await FetchData('TAX_SYS', (data) => SaveTAX_SYS(Tax_Sys_Local.fromMap(data)), GetGUIDMap);
  }

  Future<dynamic> GetAllTAX_SYS_BRA(GetGUIDMap) async {
    return await FetchData('TAX_SYS_BRA', (data) => SaveTAX_SYS_BRA(Tax_Sys_Bra_Local.fromMap(data)), GetGUIDMap);
  }

  Future<dynamic> GetAllTAX_SYS_D(GetGUIDMap) async {
    return await FetchData('TAX_SYS_D', (data) => SaveTAX_SYS_D(Tax_Sys_D_Local.fromMap(data)), GetGUIDMap);
  }

  Future<dynamic> GetAllTAX_TBL_LNK(GetGUIDMap) async {
    return await FetchData('TAX_TBL_LNK', (data) => SaveTAX_TBL_LNK(Tax_Tbl_Lnk_Local.fromMap(data)), GetGUIDMap);
  }

  Future<dynamic> GetAllTAX_TYP(GetGUIDMap) async {
    return await FetchData('TAX_TYP', (data) => SaveTAX_TYP(Tax_Typ_Local.fromMap(data)), GetGUIDMap);
  }

  Future<dynamic> GetAllTAX_TYP_BRA(GetGUIDMap) async {
    return await FetchData('TAX_TYP_BRA', (data) => SaveTAX_TYP_BRA(Tax_Typ_Bra_Local.fromMap(data)), GetGUIDMap);
  }


  // دوال لتحميل البيانات المختلفة
  Future<dynamic> GetAllTAX_TYP_SYS(GetGUIDMap) async {
    return await FetchData('TAX_TYP_SYS', (data) => SaveTAX_TYP_SYS(Tax_Typ_Sys_Local.fromMap(data)), GetGUIDMap);
  }

  Future<dynamic> GetAllTAX_VAR(GetGUIDMap) async {
    return await FetchData('TAX_VAR', (data) => SaveTAX_VAR(Tax_Var_Local.fromMap(data)), GetGUIDMap);
  }

  Future<dynamic> GetAllTAX_VAR_D(GetGUIDMap) async {
    return await FetchData('TAX_VAR_D', (data) => SaveTAX_VAR_D(Tax_Var_D_Local.fromMap(data)), GetGUIDMap);
  }

  Future<dynamic> GetAllIDE_TYP(GetGUIDMap) async {
    return await FetchData('IDE_TYP', (data) => SaveIDE_TYP(Ide_Typ_Local.fromMap(data)), GetGUIDMap);
  }

  Future<dynamic> GetAllIDE_LIN(GetGUIDMap) async {
    return await FetchData('IDE_LIN', (data) => SaveIDE_LIN(Ide_Lin_Local.fromMap(data)), GetGUIDMap);
  }

  Future<dynamic> GetAllTAX_LIN(GetGUIDMap) async {
    return await FetchData('TAX_LIN', (data) => SaveTAX_LIN(Tax_Lin_Local.fromMap(data)), GetGUIDMap);
  }

  Future<dynamic> GetAllRES_SEC(GetGUIDMap) async {
    return await FetchData('RES_SEC', (data) => SaveRES_SEC(Res_Sec_Local.fromMap(data)), GetGUIDMap);
  }

  Future<dynamic> GetAllRES_TAB(GetGUIDMap) async {
    return await FetchData('RES_TAB', (data) => SaveRES_TAB(Res_Tab_Local.fromMap(data)), GetGUIDMap);
  }

  Future<dynamic> GetAllRES_EMP(GetGUIDMap) async {
    return await FetchData('RES_EMP', (data) => SaveRES_EMP(Res_Emp_Local.fromMap(data)), GetGUIDMap);
  }

  Future<dynamic> GetAllBIF_GRO(GetGUIDMap) async {
    return await FetchData('BIF_GRO', (data) => SaveBIF_GRO(Bif_Gro_Local.fromMap(data)), GetGUIDMap);
  }

  Future<dynamic> GetAllBIF_GRO2(GetGUIDMap) async {
    return await FetchData('BIF_GRO2', (data) => SaveBIF_GRO2(Bif_Gro2_Local.fromMap(data)), GetGUIDMap);
  }

  Future<dynamic> GetAllMAT_DIS_T(GetGUIDMap) async {
    return await FetchData('MAT_DIS_T', (data) => SaveMAT_DIS_T(Mat_Dis_T_Local.fromMap(data)), GetGUIDMap);
  }

  // العروض والتخفيضات - طبيعة العروض
  Future<dynamic> GetAllMAT_DIS_K(GetGUIDMap) async {
    return await FetchData('MAT_DIS_K', (data) => SaveMAT_DIS_K(Mat_Dis_K_Local.fromMap(data)), GetGUIDMap);
  }

// العروض والتخفيضات - رئيسي
  Future<dynamic> GetAllMAT_DIS_M(GetGUIDMap) async {
    return await FetchData('MAT_DIS_M', (data) => SaveMAT_DIS_M(Mat_Dis_M_Local.fromMap(data)), GetGUIDMap);
  }

// العروض والتخفيضات - فرعي 1
  Future<dynamic> GetAllMAT_DIS_D(GetGUIDMap) async {
    return await FetchData('MAT_DIS_D', (data) => SaveMAT_DIS_D(Mat_Dis_D_Local.fromMap(data)), GetGUIDMap);
  }

// العروض والتخفيضات - فرعي 2
  Future<dynamic> GetAllMAT_DIS_F(GetGUIDMap) async {
    return await FetchData('MAT_DIS_F', (data) => SaveMAT_DIS_F(Mat_Dis_F_Local.fromMap(data)), GetGUIDMap);
  }

// ربط العروض مع المجموعات الرئيسية
  Future<dynamic> GetAllMAT_DIS_L(GetGUIDMap) async {
    return await FetchData('MAT_DIS_L', (data) => SaveMAT_DIS_L(Mat_Dis_L_Local.fromMap(data)), GetGUIDMap);
  }

// حالة العروض والتخفيضات
  Future<dynamic> GetAllMAT_DIS_S(GetGUIDMap) async {
    return await FetchData('MAT_DIS_S', (data) => SaveMAT_DIS_S(Mat_Dis_S_Local.fromMap(data)), GetGUIDMap);
  }

// المجموعات الرئيسية للعروض
  Future<dynamic> GetAllMAT_MAI_M(GetGUIDMap) async {
    return await FetchData('MAT_MAI_M', (data) => SaveMAT_MAI_M(Mat_Mai_M_Local.fromMap(data)), GetGUIDMap);
  }

// التصنيف الضريبي
  Future<dynamic> GetAllTAX_MOV_T(GetGUIDMap) async {
    return await FetchData('TAX_MOV_T', (data) => SaveTAX_MOV_T(TAX_MOV_T_Local.fromMap(data)), GetGUIDMap);
  }

// التصنيف الضريبي للحساب
  Future<dynamic> GetAllACC_TAX_C(GetGUIDMap) async {
    return await FetchData('ACC_TAX_C', (data) => SaveACC_TAX_C(Acc_Tax_C_Local.fromMap(data)), GetGUIDMap);
  }

// إعداد الفترات الضريبية
  Future<dynamic> GetAllTAX_PER_M(GetGUIDMap) async {
    return await FetchData('TAX_PER_M', (data) => SaveTAX_PER_M(Tax_Per_M_Local.fromMap(data)), GetGUIDMap);
  }

// الفترات الضريبية - فرعي
  Future<dynamic> GetAllTAX_PER_D(GetGUIDMap) async {
    return await FetchData('TAX_PER_D', (data) => SaveTAX_PER_D(Tax_Per_D_Local.fromMap(data)), GetGUIDMap);
  }

// ربط الفترات الضريبية بالفروع
  Future<dynamic> GetAllTAX_PER_BRA(GetGUIDMap) async {
    return await FetchData('TAX_PER_BRA', (data) => SaveTAX_PER_BRA(Tax_Per_Bra_Local.fromMap(data)), GetGUIDMap);
  }

// بيانات الربط مع الــAPI
  Future<dynamic> GetAllFAT_API_INF(GetGUIDMap) async {
    return await FetchData('FAT_API_INF', (data) => SaveFAT_API_INF(Fat_Api_Inf_Local.fromMap(data)), GetGUIDMap);
  }

// الوحدات/الأجهزة التقنية
  Future<dynamic> GetAllFAT_CSID_INF(GetGUIDMap) async {
    return await FetchData('FAT_CSID_INF', (data) => SaveFAT_CSID_INF(Fat_Csid_Inf_Local.fromMap(data)), GetGUIDMap);
  }

// الوحدات/الأجهزة التقنية - فرعي
  Future<dynamic> GetAllFAT_CSID_INF_D(GetGUIDMap) async {
    return await FetchData('FAT_CSID_INF_D', (data) => SaveFAT_CSID_INF_D(Fat_Csid_Inf_D_Local.fromMap(data)), GetGUIDMap);
  }

  Future<dynamic> GetAllFAT_QUE(GetGUIDMap) async {
    return await FetchData('FAT_QUE', (data) => SaveFAT_QUE(Fat_Que_Local.fromMap(data)), GetGUIDMap);
  }

// مسلسل الترقيم للوحدات/الأجهزة التقنية
  Future<dynamic> GetAllFAT_CSID_SEQ(GetGUIDMap) async {
    return await FetchData('FAT_CSID_SEQ', (data) => SaveFAT_CSID_SEQ(Fat_Csid_Seq_Local.fromMap(data)), GetGUIDMap);
  }

  // حالة الوحدات/الأجهزة التقنية
  Future<dynamic> GetAllFAT_CSID_ST(GetGUIDMap) async {
    return await FetchData('FAT_CSID_ST', (data) => SaveFAT_CSID_ST(Fat_Csid_St_Local.fromMap(data)), GetGUIDMap);
  }

  //أنواع الوقود
  Future<dynamic> GetAllCOU_TYP_M(GetGUIDMap) async {
    return await FetchData('COU_TYP_M', (data) => SaveCOU_TYP_M(Cou_Typ_M_Local.fromMap(data)), GetGUIDMap);
  }

  //ترميز العدادات
  Future<dynamic> GetAllCOU_INF_M(GetGUIDMap) async {
    return await FetchData('COU_INF_M', (data) => SaveCOU_INF_M(Cou_Inf_M_Local.fromMap(data)), GetGUIDMap);
  }

  //صلاحيه المستخدمين بالعدادات
  Future<dynamic> GetAllCOU_USR(GetGUIDMap) async {
    return await FetchData('COU_USR', (data) => SaveCOU_USR(Cou_Usr_Local.fromMap(data)), GetGUIDMap);
  }

  //ربط العدادات بالنقاط
  Future<dynamic> GetAllCOU_POI_L(GetGUIDMap) async {
    return await FetchData('COU_POI_L', (data) => SaveCOU_POI_L(Cou_Poi_L_Local.fromMap(data)), GetGUIDMap);
  }

  //   //القراءات
  Future<dynamic> GetAllCOU_RED(GetGUIDMap) async {
    return await FetchData('COU_RED', (data) => SaveCOU_RED(Cou_Red_Local.fromMap(data)), GetGUIDMap);
  }

  Future<dynamic> GetAllSYN_SET(GetGUIDMap) async {
    return await FetchData('SYN_SET', (data) => SaveSYN_SET(Syn_Set_Local.fromMap(data)), GetGUIDMap);
  }

  Future<dynamic> GetAllSYN_OFF_M2(GetGUIDMap) async {
    return await FetchData('SYN_OFF_M2', (data) => SaveSYN_OFF_M2(Syn_Off_M2_Local.fromMap(data)), GetGUIDMap);
  }

  Future<dynamic> GetAllSYN_OFF_M(GetGUIDMap) async {
    return await FetchData('SYN_OFF_M', (data) => SaveSYN_OFF_M(Syn_Off_M_Local.fromMap(data)), GetGUIDMap);
  }

  Future<dynamic> GetAllECO_VAR(GetGUIDMap) async {
    return await FetchData('ECO_VAR', (data) => SaveECO_VAR(Eco_Var_Local.fromMap(data)), GetGUIDMap);
  }

  Future<dynamic> GetAllECO_ACC(GetGUIDMap) async {
    return await FetchData('ECO_ACC', (data) => SaveECO_ACC(Eco_Acc_Local.fromMap(data)), GetGUIDMap);
  }

  Future<dynamic> GetAllECO_MSG_ACC(GetGUIDMap) async {
    return await FetchData('ECO_MSG_ACC', (data) => SaveECO_MSG_ACC(Eco_Msg_Acc_Local.fromMap(data)), GetGUIDMap);
  }


}



