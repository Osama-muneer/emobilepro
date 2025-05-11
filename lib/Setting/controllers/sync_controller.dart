import 'dart:async';
import 'dart:io';
import '../../Setting/models/config.dart';
import '../../Setting/models/fas_acc_usr.dart';
import '../../Setting/models/sys_own.dart';
import '../../Setting/models/sys_usr.dart';
import '../../database/database.dart';
import 'package:flutter/material.dart';
import 'package:flutter_background_service/flutter_background_service.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import '../../Setting/models/gen_var.dart';
import '../../Setting/services/api_provider.dart';
import '../../Widgets/config.dart';
import '../../database/setting_db.dart';
import '../../database/sync_db.dart';
import 'package:intl/intl.dart';
import 'package:uuid/uuid.dart';
import '../models/syn_tas.dart';
import 'login_controller.dart';

class SyncController extends GetxController {
  //TODO: Implement HomeController
  var uuid = const Uuid();
  final conn = DatabaseHelper.instance;
  String DateDays = DateFormat('dd-MM-yyyy HH:mm:ss').format(DateTime.now());
  String SYDV_ID_V = '',
      SYDV_NO_V = '',
      TypeGet = 'SYS_VAR';
  bool round = true,
      checkclick = false,
      CheckClickAll = false,
      ClickAllOrLastTime = false;
  final service = FlutterBackgroundService();
  var CheckSync = true.obs;
  RxBool loading = false.obs;
  RxBool loadingone = false.obs;
  late List<Gen_Var_Local> GEN_VAR;
  late List<Sys_Own_Local> SYS_OWN;
  late List<Config_Local> Config;
  late List<Syn_Tas_Local> SYN_TAS_List;
  int TypeSync = 0,
      TypeSyncAll = 0,
      TypeCheckSync = 1,
      SysVarProgress = -2,
      SysWProgress = -2,
      BraProgress = -2,
      SysUProgress = -2,
      BilCusTProgress = -2,
      StoProgress = -2,
      MatUProgress = -2,
      SYSSCRProgress = -2,
      MatIProgress = -2,
      UsrPProgress = -2,
      CountFor = 0,
      arrlength = -1,
      UsrBProgress = -2,
      MatGProgress = -2,
      MatUCProgress = -2,
      MatUBProgress = -2,
      StoNProgress = -2,
      MatIAProgress = -5,
      StoUProgress = -2,
      GroUProgress = -2,
      MatPProgress = -2,
      SysDProgress = -2,
      SysUBProgress = -2,
      BilCusProgress = -2,
      BilDisProgress = -2,
      ShiInfProgress = -2,
      ShiUsrProgress = -2,
      BilPoiProgress = -2,
      BilPoiUProgress = -2,
      BILIMPProgress = -2,
      CouWrdProgress = -2,
      CouTowProgress = -2,
      AccCosProgress = -2,
      CosUsrProgress = -2,
      BilUsrdProgress = -2,
      BilAreProgress = -2,
      SYN_DATProgress = -2,
      BIFCDProgress = -2,
      BILMOVKProgress = -2,
      ACCMOVKProgress = -2,
      ACCTAXTProgress = -2,
      PayKinProgress = -2,
      SysCurProgress = -2,
      SysCurBetProgress = -2,
      SysCurDProgress = -2,
      AccCasProgress = -2,
      BilCrecProgress = -2,
      AccUsrProgress = -2,
      AccAccProgress = -2,
      AccBanProgress = -2,
      BALACCMProgress = -2,
      BALACCDProgress = -2,
      BALACCCProgress = -2,
      ACCCASUProgress = -2,
      TAXCODProgress = -2,
      TAXCODSYSProgress = -2,
      TAXCODSYSDProgress = -2,
      TAXLINProgress = -2,
      TAXLOCProgress = -2,
      TAXLOCSYSProgress = -2,
      TAXMOVSINProgress = -2,
      TAXSYSProgress = -2,
      TAXSYSBRAProgress = -2,
      TAXSYSDProgress = -2,
      TAXTYPProgress = -2,
      TAXTYPBRAProgress = -2,
      TAXTYPSYSProgress = -2,
      TAXTBLLNKProgress = -2,
      TAXVARProgress = -2,
      TAXVARDProgress = -2,
      IDETYPProgress = -2,
      IDELINProgress = -2,
      RESSECProgress = -2,
      RESTABProgress = -2,
      RESEMPProgress = -2,
      BIFGROProgress = -2,
      BIFGRO2Progress = -2,
      MATFOLProgress = -2,
      MATDESMProgress = -2,
      MATDESDProgress = -2,
      MATDISTProgress = -2,
      MATDISKProgress = -2,
      MATDISMProgress = -2,
      MATDISDProgress = -2,
      MATDISFProgress = -2,
      MATDISLProgress = -2,
      MATMAIMProgress = -2,
      MATDISSProgress = -2,
      ACCTAXCProgress = -2,
      TAXMOVTProgress = -2,
      TAXPERMProgress = -2,
      TAXPERDProgress = -2,
      TAXPERBRAProgress = -2,
      FATAPIINFProgress = -2,
      FATCSIDINFProgress = -2,
      FATCSIDINFDProgress = -2,
      FATCSIDSEQProgress = -2,
      FATCSIDSTProgress = -2,
      FATINVSNDProgress = -2,
      FATINVSNDARCProgress = -2,
      FATQUEProgress = -2,
      CouTypMProgress = -2,
      CouInfMProgress = -2,
      CouPoiLProgress = -2,
      CouUsrProgress = -2,
      SYNSETProgress = -2,
      SYNOFFM2Progress = -2,
      SYNOFFMProgress = -2,
      ECOVARProgress = -2,
      ECOACCProgress = -2,
      ECOMSGACCProgress = -2,
      CouRedProgress = -2;


  int PercentValue = 0,
      BraPercent = 0,
      CHIKE_BACK_MAIN = 1,
      StoPercent = 0,
      SysVarPercent = 0,
      SYSSCRPercent = 0,
      UsrBPercent = 0,
      MatGPercent = 0,
      MatIPercent = 0,
      MatUPercent = 0,
      MatUCPercent = 0,
      MatUBPercent = 0,
      StoNPercent = 0,
      MatIAPercent = 0,
      StoUPercent = 0,
      SysUPercent = 0,
      BIFCDPercent = 0,
      UsrPPercent = 0,
      GroUPercent = 0,
      MatPPercent = 0,
      SysWPercent = 0,
      SysDPercent = 0,
      SysUBPercent = 0,
      BilArePercent = 0,
      BilCusPercent = 0,
      BilDisPercent = 0,
      CouWrdPercent = 0,
      ShiInfPercent = 0,
      ShiUsrPercent = 0,
      BilPoiPercent = 0,
      BilPoiUPercent = 0,
      BILIMPPercent = 0,
      SYN_DATPercent = 0,
      AccCosPercent = 0,
      CosUsrPercent = 0,
      BilUsrdPercent = 0,
      PayKinPercent = 0,
      SysCurDPercent = 0,
      SysCurPercent = 0,
      SysCurBetPercent = 0,
      AccCasPercent = 0,
      BILMOVKPercent = 0,
      ACCMOVKPercent = 0,
      ACCTAXTPercent = 0,
      BilCrecPercent = 0,
      AccUsrPercent = 0,
      AccAccPercent = 0,
      AccBanPercent = 0,
      CouTowPercent = 0,
      BilCusTPercent = 0,
      BALACCMPercent = 0,
      BALACCDPercent = 0,
      BALACCCPercent = 0,
      ACCCASUPercent = 0,
      TAXCODPercent = 0,
      TAXCODSYSPercent = 0,
      TAXCODSYSDPercent = 0,
      TAXLINPercent = 0,
      TAXLOCPercent = 0,
      TAXLOCSYSPercent = 0,
      TAXSYSPercent = 0,
      TAXSYSBRAPercent = 0,
      TAXSYSDPercent = 0,
      TAXTYPPercent = 0,
      IDELINPercent = 0,
      TAXTYPBRAPercent = 0,
      TAXTYPSYSPercent = 0,
      TAXMOVSINPercent = 0,
      TAXTBLLNKPercent = 0,
      TAXVARPercent = 0,
      TAXVARDPercent = 0,
      IDETYPPercent = 0,
      RESSECPercent = 0,
      RESTABPercent = 0,
      RESEMPPercent = 0,
      BIFGROPercent = 0,
      MATFOLPercent = 0,
      BIFGRO2Percent = 0,
      MATDESMPercent = 0,
      MATDESDPercent = 0,
      MATDISTPercent = 0,
      MATDISKPercent = 0,
      MATDISMPercent = 0,
      MATDISDPercent = 0,
      MATDISFPercent = 0,
      MATDISLPercent = 0,
      MATMAIMPercent = 0,
      MATDISSPercent = 0,
      ACCTAXCPercent = 0,
      TAXMOVTPercent = 0,
      TAXPERMPercent = 0,
      TAXPERDPercent = 0,
      TAXPERBRAPercent = 0,
      FATAPIINFPercent = 0,
      FATCSIDINFPercent = 0,
      FATCSIDINFDPercent = 0,
      FATCSIDSEQPercent = 0,
      FATCSIDSTPercent = 0,
      FATINVSNDPercent = 0,
      FATINVSNDARCPercent = 0,
      FATQUEPercent = 0,
      CouTypMPercent = 0,
      CouInfMPercent = 0,
      CouPoiLPercent = 0,
      CouUsrPercent = 0,
      SYNSETPercent = 0,
      SYNOFFM2Percent = 0,
      SYNOFFMPercent = 0,
      ECOVARPercent = 0,
      ECOACCPercent = 0,
      ECOMSGACCPercent = 0,
      CouRedPercent = 0;

  double cireclValue = 0,
      Bravalue = 0,
      Stovalue = 0,
      SysVarvalue = 0,
      SYSSCRvalue = 0,
      UsrBvalue = 0,
      MatGvalue = 0,
      MatIvalue = 0,
      MatUvalue = 0,
      MatUCvalue = 0,
      MatUBvalue = 0,
      StoNvalue = 0,
      MatIAvalue = 0,
      StoUvalue = 0,
      SysUvalue = 0,
      UsrPvalue = 0,
      GroUvalue = 0,
      BIFCDvalue = 0,
      MatPvalue = 0,
      SysWvalue = 0,
      SysDvalue = 0,
      SysUBvalue = 0,
      BilCusvalue = 0,
      BilDisvalue = 0,
      ShiInfvalue = 0,
      ShiUsrvalue = 0,
      BilPoivalue = 0,
      BilPoiUvalue = 0,
      BILIMPvalue = 0,
      CouWrdvalue = 0,
      AccCosvalue = 0,
      CosUsrvalue = 0,
      BilUsrdvalue = 0,
      PayKinvalue = 0,
      BilArevalue = 0,
      BilCusTvalue = 0,
      SYN_DATvalue = 0,
      SysCurvalue = 0,
      SysCurBetvalue = 0,
      SysCurDvalue = 0,
      AccCasvalue = 0,
      BilCrecvalue = 0,
      AccUsrvalue = 0,
      AccAccvalue = 0,
      AccBanvalue = 0,
      CouTowvalue = 0,
      BILMOVKvalue = 0,
      ACCMOVKvalue = 0,
      ACCTAXTvalue = 0,
      BALACCMvalue = 0,
      BALACCDvalue = 0,
      BALACCCvalue = 0,
      ACCCASUvalue = 0,
      TAXCODvalue = 0,
      TAXCODSYSvalue = 0,
      TAXCODSYSDvalue = 0,
      TAXLOCvalue = 0,
      TAXLOCSYSvalue = 0,
      TAXLINvalue = 0,
      TAXSYSvalue = 0,
      TAXSYSBRAvalue = 0,
      TAXSYSDvalue = 0,
      TAXTYPvalue = 0,
      TAXTYPBRAvalue = 0,
      TAXTYPSYSvalue = 0,
      TAXMOVSINvalue = 0,
      TAXTBLLNKvalue = 0,
      TAXVARvalue = 0,
      TAXVARDvalue = 0,
      IDETYPvalue = 0,
      IDELINvalue = 0,
      RESSECvalue = 0,
      RESTABvalue = 0,
      RESEMPvalue = 0,
      BIFGROvalue = 0,
      MATFOLvalue = 0,
      BIFGRO2value = 0,
      MATDESMvalue = 0,
      MATDESDvalue = 0,
      MATDISTvalue = 0,
      MATDISKvalue = 0,
      MATDISMvalue = 0,
      MATDISDvalue = 0,
      MATDISFvalue = 0,
      MATDISLvalue = 0,
      MATMAIMvalue = 0,
      MATDISSvalue = 0,
      ACCTAXCvalue = 0,
      TAXMOVTvalue = 0,
      TAXPERMvalue = 0,
      TAXPERDvalue = 0,
      TAXPERBRAvalue = 0,
      FATAPIINFvalue = 0,
      FATCSIDINFvalue = 0,
      FATCSIDINFDvalue = 0,
      FATCSIDSEQvalue = 0,
      FATCSIDSTvalue = 0,
      FATINVSNDvalue = 0,
      FATINVSNDARCvalue = 0,
      FATQUEvalue = 0,
      CouTypvalue = 0,
      CouInfMvalue = 0,
      CouPoiLvalue = 0,
      CouUsrvalue = 0,
      SYNSETvalue = 0,
      SYNOFFM2value = 0,
      SYNOFFMvalue= 0,
      ECOVARvalue = 0,
      ECOACCvalue= 0,
      ECOMSGACCvalue = 0,
      CouRedvalue = 0;

  int TotalBRA_INF = -1,
      TotalSTO_INF = -1,
      TotalSYS_VAR = -1,
      TotalBRA_YEA = -1,
      TotalSYS_USR_B = -1,
      TotalMAT_GRO = -1,
      TotalMAT_INF = -1,
      TotalMAT_UNI = -1,
      TotalMAT_UNI_C = -1,
      TotalMAT_UNI_B = -1,
      TotalSTO_NUM = -1,
      TotalMAT_INF_A = -1,
      TotalSTO_USR = -1,
      TotalSYS_USR = -1,
      TotalUSR_PRI = -1,
      TotalGRO_USR = -1,
      TotalMAT_PRI = -1,
      TotalSYS_OWN = -1,
      TotalSYS_DOC_D = -1,
      TotalSYS_SCR = -1,
      TotalSYS_SCR_N = -1,
      TotalBIL_CUS = -1,
      TotalBIL_DIS = -1,
      TotalBIF_CUS_D = -1,
      TotalSHI_INF = -1,
      TotalSHI_USR = -1,
      TotalBIL_POI = -1,
      TotalBIL_POI_U = -1,
      TotalBIL_IMP = -1,
      TotalCOU_WRD = -1,
      TotalCOU_TOW = -1,
      TotalACC_COS = -1,
      TotalBIL_USR_D = -1,
      TotalPAY_KIN = -1,
      TotalSYS_CUR = -1,
      TotalSYS_CUR_D = -1,
      TotalALLSYS_CUR = -1,
      TotalSYS_CUR_BET = -1,
      TotalACC_CAS = -1,
      TotalBIL_CRE_C = -1,
      TotalACC_USR = -1,
      TotalSYS_REF = -1,
      TotalCOS_USR = -1,
      TotalACC_ACC = -1,
      TotalSYN_DAT = -1,
      TotalBIL_MOV_K = -1,
      TotalACC_MOV_K = -1,
      TotalACC_BAN = -1,
      TotalBIL_ARE = -1,
      TotalACC_TAX_T = -1,
      TotalBIL_CUS_T = -1,
      TotalALLBIL_CUS_T = -1,
      TotalALLTAX_SYS = -1,
      TotalALLFAT_CSID_INF = -1,
      TotalBAL_ACC_M = -1,
      TotalBAL_ACC_D = -1,
      TotalBAL_ACC_C = -1,
      TotalACC_CAS_U = -1,
      TotalTAX_COD = -1,
      TotalTAX_COD_SYS = -1,
      TotalTAX_COD_SYS_D = -1,
      TotalTAX_LOC = -1,
      TotalTAX_LOC_SYS = -1,
      TotalALLTAX_LOC = -1,
      TotalTAX_SYS = -1,
      TotalTAX_SYS_BRA = -1,
      TotalTAX_SYS_D = -1,
      TotalTAX_TYP = -1,
      TotalTAX_TYP_BRA = -1,
      TotalTAX_TYP_SYS = -1,
      TotalALLTAX_TYP = -1,
      TotalALLTAX_PER_M = -1,
      TotalALLTAX_MOV_T = -1,
      TotalALLTAX_COD = -1,
      TotalTAX_LIN = -1,
      TotalTAX_MOV_SIN = -1,
      TotalTAX_TBL_LNK = -1,
      TotalTAX_VAR = -1,
      TotalALLTAX_VAR = -1,
      TotalTAX_VAR_D = -1,
      TotalIDE_TYP = -1,
      TotalIDE_LIN = -1,
      TotalRES_SEC = -1,
      TotalRES_TAB = -1,
      TotalRES_EMP = -1,
      TotalBIF_GRO = -1,
      TotalMAT_FOL = -1,
      TotalBIF_GRO2 = -1,
      TotalMAT_DES_M = -1,
      TotalMAT_DES_D = -1,
      TotalMAT_DIS_T = -1,
      TotalMAT_DIS_K = -1,
      TotalMAT_DIS_M = -1,
      TotalMAT_DIS_D = -1,
      TotalMAT_DIS_F = -1,
      TotalMAT_DIS_L = -1,
      TotalMAT_MAI_M = -1,
      TotalMAT_DIS_S = -1,
      TotalACC_TAX_C = -1,
      TotalTAX_MOV_T = -1,
      TotalTAX_PER_M = -1,
      TotalTAX_PER_D = -1,
      TotalTAX_PER_BRA = -1,
      TotalFAT_API_INF = -1,
      TotalFAT_CSID_INF = -1,
      TotalFAT_CSID_INF_D = -1,
      TotalFAT_CSID_SEQ = -1,
      TotalFAT_CSID_ST = -1,
      TotalFAT_INV_SND = -1,
      TotalFAT_INV_SND_ARC = -1,
      TotalFAT_QUE = -1,
      TotalCOU_TYP_M = -1,
      TotalCOU_INF_M = -1,
      TotalCOU_POI_L = -1,
      TotalCOU_USR = -1,
      TotalSYN_SET = -1,
      TotalSYN_OFF_M2 = -1,
      TotalSYN_OFF_M = -1,
      TotalECO_VAR = -1,
      TotalECO_ACC = -1,
      TotalECO_MSG_ACC = -1,
      TotalCOU_RED = -1;

  int CheckBra_Inf = -1,
      CheckSto_Inf = -1,
      CheckSys_Var = -1,
      CheckBRA_YEA = -1,
      CheckSys_Usr_B = -1,
      CheckMat_Gro = -1,
      CheckMat_Inf = -1,
      CheckMat_Uni = -1,
      CheckMat_Uni_C = -1,
      CheckMat_Uni_B = -1,
      CheckSto_Num = -1,
      CheckMat_Inf_A = -1,
      CheckSto_Usr = -1,
      CheckSys_Usr = -1,
      CheckUsr_Pri = -1,
      CheckGro_Usr = -1,
      CheckMat_Pri = -1,
      CheckSys_Won = -1,
      CheckSys_Doc = -1,
      CheckSYS_SCR = -1,
      CheckSYS_SCR_N = -1,
      CheckBIL_CUS = -1,
      CheckBIL_DIS = -1,
      CheckBIF_CUS_D = -1,
      CheckSHI_INF = -1,
      CheckSHI_USR = -1,
      CheckBIL_POI = -1,
      CheckBIL_POI_U = -1,
      CheckBIL_IMP = -1,
      CheckCOU_WRD = -1,
      CheckCOU_TOW = -1,
      CheckACC_COS = -1,
      CheckBIL_USR_D = -1,
      CheckPAY_KIN = -1,
      CheckSYS_CUR = -1,
      CheckSYS_CUR_D = -1,
      CheckALLSYS_CUR = -1,
      CheckSYS_CUR_BET = -1,
      CheckACC_CAS = -1,
      CheckBIL_CRE_C = -1,
      CheckACC_USR = -1,
      CheckSYS_REF = -1,
      CheckCOS_USR = -1,
      CheckACC_ACC = -1,
      CheckSYN_DAT = -1,
      CheckBIL_MOV_K = -1,
      CheckACC_MOV_K = -1,
      CheckACC_BAN = -1,
      CheckBil_Are = -1,
      CheckACC_TAX_T = -1,
      CheckBIL_CUS_T = -1,
      CheckALLBIL_CUS_T = -1,
      CheckALLSYN_ORD = -1,
      CheckBAL_ACC_M = -1,
      CheckBAL_ACC_D = -1,
      CheckBAL_ACC_C = -1,
      CheckACC_CAS_U = -1,
      CheckDataBase = -1,
      CheckDataBaseTmp = -1,
      CheckTAX_COD = -1,
      CheckTAX_COD_SYS = -1,
      CheckTAX_COD_SYS_D = -1,
      CheckTAX_LOC = -1,
      CheckTAX_LOC_SYS = -1,
      CheckTAX_LIN = -1,
      CheckTAX_SYS = -1,
      CheckTAX_SYS_BRA = -1,
      CheckTAX_SYS_D = -1,
      CheckTAX_TYP = -1,
      CheckTAX_TYP_BRA = -1,
      CheckTAX_TYP_SYS = -1,
      CheckTAX_MOV_SIN = -1,
      CheckTAX_TBL_LNK = -1,
      CheckTAX_VAR = -1,
      CheckTAX_VAR_D = -1,
      CheckIDE_TYP = -1,
      CheckIDE_LIN = -1,
      CheckRES_SEC = -1,
      CheckRES_TAB = -1,
      CheckRES_EMP = -1,
      CheckBIF_GRO = -1,
      CheckMAT_FOL = -1,
      CheckBIF_GRO2 = -1,
      CheckMAT_DES_M = -1,
      CheckMAT_DES_D = -1,
      CheckMAT_DIS_T = -1,
      CheckMAT_DIS_K = -1,
      CheckMAT_DIS_M = -1,
      CheckMAT_DIS_D = -1,
      CheckMAT_DIS_F = -1,
      CheckMAT_DIS_L = -1,
      CheckMAT_MAI_M= -1,
      CheckMAT_DIS_S = -1,
      CheckACC_TAX_C = -1,
      CheckTAX_MOV_T = -1,
      CheckTAX_PER_M = -1,
      CheckTAX_PER_D = -1,
      CheckTAX_PER_BRA = -1,
      CheckFAT_API_INF = -1,
      CheckFAT_CSID_INF = -1,
      CheckFAT_CSID_INF_D = -1,
      CheckFAT_CSID_SEQ = -1,
      CheckFAT_CSID_ST = -1,
      CheckFAT_INV_SND = -1,
      CheckFAT_INV_SND_ARC = -1,
      CheckFAT_QUE = -1,
      CheckCOU_TYP_M = -1,
      CheckCOU_INF_M = -1,
      CheckCOU_POI_L = -1,
      CheckCOU_USR = -1,
      CheckCOU_RED= -1,
      CheckSYN_SET= -1,
      CheckSYN_OFF_M2= -1,
      CheckSYN_OFF_M= -1,
      CheckECO_VAR= -1,
      CheckECO_ACC = -1,
      CheckECO_MSG_ACC = -1;

  RxString LastSYS_VAR = ''.obs;
  String LastBra_Inf = '',
      SYN_TAS = '',
      LastSto_Inf = '',
      LastBRA_YEA = '',
      LastSys_Usr_B = '',
      LastMat_Gro = '',
      LastMat_Inf = '',
      LastMat_Uni = '',
      LastMat_Uni_C = '',
      LastMat_Uni_B = '',
      LastSto_Num = '',
      LastMat_Inf_A = '',
      LastSto_Usr = '',
      LastSys_Usr = '',
      LastUsr_Pri = '',
      LastGro_Usr = '',
      LastMat_Pri = '',
      LastSys_Won = '',
      LastBIL_MOV_K = '',
      LastSys_Doc = '',
      LastSYS_SCR = '',
      LastSYS_SCR_N = '',
      LastBIL_CUS = '',
      LastBIL_DIS = '',
      LastBIF_CUS_D = '',
      LastSHI_INF = '',
      LastSHI_USR = '',
      LastBIL_POI = '',
      LastBIL_POI_U = '',
      LastBIL_IMP = '',
      LastCOU_WRD = '',
      LastCOU_TOW = '',
      LastACC_COS = '',
      LastBIL_USR_D = '',
      LastPAY_KIN = '',
      LastSYS_CUR = '',
      LastSYS_CUR_D = '',
      LastALLSYS_CUR = '',
      LastSYS_CUR_BET = '',
      LastACC_CAS = '',
      LastBIL_CRE_C = '',
      LastACC_USR = '',
      LastSYS_REF = '',
      LastSumBIL_CUS = '',
      LastCOS_USR = '',
      LastACC_ACC = '',
      LastSYN_DAT = '',
      LastACC_BAN = '',
      LastBil_Are = '',
      LastACC_TAX_T = '',
      LastBIL_CUS_T = '',
      LastACC_MOV_K = '',
      LastBAL_ACC_M = '',
      LastBAL_ACC_D = '',
      LastBAL_ACC_C = '',
      LastSyncDate = '',
      LastACC_CAS_U = '',
      LastTAX_MOV_SIN = '',
      LastTAX_TBL_LNK = '',
      LastTAX_COD = '',
      LastTAX_COD_SYS = '',
      LastTAX_COD_SYS_D = '',
      LastTAX_LOC = '',
      LastTAX_LOC_SYS = '',
      LastTAX_LIN = '',
      LastTAX_SYS = '',
      LastTAX_SYS_BRA = '',
      LastTAX_SYS_D = '',
      LastTAX_TYP = '',
      LastTAX_TYP_BRA = '',
      LastTAX_TYP_SYS = '',
      LastTAX_VAR = '',
      LastTAX_VAR_D = '',
      LastIDE_TYP = '',
      LastIDE_LIN = '',
      LastRES_SEC = '',
      LastRES_TAB = '',
      LastRES_EMP = '',
      LastBIF_GRO = '',
      LastMAT_FOL = '',
      LastBIF_GRO2 = '',
      LastMAT_DES_M = '',
      LastMAT_DES_D = '',
      LastMAT_DIS_T = '',
      LastMAT_DIS_K = '',
      LastMAT_DIS_M = '',
      LastMAT_DIS_D = '',
      LastMAT_DIS_F = '',
      LastMAT_DIS_L = '',
      LastMAT_MAI_M = '',
      SYN_TAS_TMP_GUID = '',
      SYN_TAS_GUID = '',
      LastMAT_DIS_S = '',

      LastACC_TAX_C = '',
      LastTAX_MOV_T = '',
      LastTAX_PER_M = '',
      LastTAX_PER_D = '',
      LastTAX_PER_BRA = '',
      LastFAT_API_INF = '',
      LastFAT_CSID_INF ='',
      LastFAT_CSID_INF_D ='',
      LastFAT_CSID_SEQ ='',
      LastFAT_CSID_ST = '',
      LastFAT_INV_SND = '',
      LastFAT_INV_SND_ARC = '',
      LastFAT_QUE = '',
      LastCOU_TYP_M = '',
      LastCOU_INF_M = '',
      LastCOU_POI_L = '',
      LastCOU_USR = '',
      LastSYN_SET= '',
      LastSYN_OFF_M2= '',
      LastSYN_OFF_M= '',
      LastECO_VAR= '',
      LastECO_ACC = '',
      LastECO_MSG_ACC = '',
      LastCOU_RED = '';

  String SLIN = LoginController().LAN == 2
      ? 'The data has been successfully received/updated'
      : "تم بنجاج استلام/تحديث البيانات";
  int ROW_NUM = 0,
      CHIKE_ALL = 0,
      F_ROW_V = 1,
      T_ROW_V = 0,
      avgcount = 0;
  bool SyncOneTable = false;

  GetCountSYN_ORD() async {
    CheckALLSYN_ORD=await Get_Count_Check('SYN_ORD');
      update();
  }

  GetCountNum() async{
    CheckSys_Var= await Get_Count_Check('SYS_VAR');
    CheckSys_Won= await Get_Count_Check('SYS_OWN');
    CheckBra_Inf= await Get_Count_Check('BRA_INF');
    CheckSys_Usr= await Get_Count_Check('SYS_USR');
    CheckUsr_Pri= await Get_Count_Check('USR_PRI');
    CheckSys_Usr_B= await Get_Count_Check('SYS_USR_B');
    CheckSto_Inf= await Get_Count_Check('STO_INF');
    CheckSto_Usr = await Get_Count_Check('STO_USR');
    CheckMat_Gro = await Get_Count_Check('MAT_GRO');
    CheckGro_Usr = await Get_Count_Check('GRO_USR');
    CheckMat_Uni = await Get_Count_Check('MAT_UNI');
    CheckMat_Inf = await Get_Count_Check('MAT_INF');
    CheckMat_Uni_C = await Get_Count_Check('MAT_UNI_C');
    CheckMat_Uni_B = await Get_Count_Check('MAT_UNI_B');
    CheckMat_Pri = await Get_Count_Check('MAT_PRI');
    CheckMat_Inf_A = await Get_Count_Check(STMID == 'EORD' ? 'MAT_INF_D' : 'MAT_INF_A');
    CheckSto_Num = await Get_Count_Check('STO_NUM');
    CheckSYS_CUR = await Get_Count_Check('SYS_CUR');
    CheckSYS_CUR_D = await Get_Count_Check('SYS_CUR_D');
    CheckSYS_CUR_BET = await Get_Count_Check('SYS_CUR_BET');
    CheckPAY_KIN = await Get_Count_Check('PAY_KIN');
    CheckACC_CAS = await Get_Count_Check('ACC_CAS');
    CheckACC_CAS_U = await Get_Count_Check('ACC_CAS_U');
    CheckBIL_CRE_C = await Get_Count_Check('BIL_CRE_C');
    CheckACC_BAN = await Get_Count_Check('ACC_BAN');
    CheckBIL_CUS_T = await Get_Count_Check('BIL_CUS_T');
    CheckACC_TAX_T = await Get_Count_Check('ACC_TAX_T');
    CheckBIL_CUS = await Get_Count_Check('BIL_CUS');
    CheckBIF_CUS_D = await Get_Count_Check('BIF_CUS_D');
    CheckBIL_DIS = await Get_Count_Check('BIL_DIS');
    CheckBIL_IMP = await Get_Count_Check('BIL_IMP');
    CheckCOU_WRD = await Get_Count_Check('COU_WRD');
    CheckCOU_TOW = await Get_Count_Check('COU_TOW');
    CheckBil_Are = await Get_Count_Check('BIL_ARE');
    CheckACC_ACC = await Get_Count_Check('ACC_ACC');
    CheckACC_USR = await Get_Count_Check('ACC_USR');
    CheckSHI_INF = await Get_Count_Check('SHI_INF');
    CheckSHI_USR = await Get_Count_Check('SHI_USR');
    CheckBIL_POI = await Get_Count_Check('BIL_POI');
    CheckBIL_POI_U = await Get_Count_Check('BIL_POI_U');
    CheckBIL_USR_D = await Get_Count_Check('BIL_USR_D');
    CheckACC_COS = await Get_Count_Check('ACC_COS');
    CheckCOS_USR = await Get_Count_Check('COS_USR');
    CheckSYS_REF = await Get_Count_Check('SYS_REF');
    CheckSys_Doc = await Get_Count_Check('SYS_DOC_D');
    CheckSys_Doc = await Get_Count_Check('BRA_YEA');
    CheckSYS_SCR = await Get_Count_Check('SYS_SCR');
    CheckBIL_MOV_K = await Get_Count_Check(STMID == 'INVC' ? 'STO_MOV_K' : 'BIL_MOV_K');
    CheckACC_MOV_K = await Get_Count_Check('ACC_MOV_K');
    CheckBAL_ACC_M = await Get_Count_Check('BAL_ACC_M');
    CheckBAL_ACC_C = await Get_Count_Check('BAL_ACC_C');
    CheckBAL_ACC_D = await Get_Count_Check('BAL_ACC_D');
    CheckSYN_DAT = await Get_Count_Check('SYN_DAT');
    CheckTAX_COD = await Get_Count_Check('TAX_COD');
    CheckTAX_COD_SYS = await Get_Count_Check('TAX_COD_SYS');
    CheckTAX_COD_SYS_D = await Get_Count_Check('TAX_COD_SYS_D');
    CheckTAX_LOC = await Get_Count_Check('TAX_LOC');
    CheckTAX_LOC_SYS = await Get_Count_Check('TAX_LOC_SYS');
    CheckTAX_LIN = await Get_Count_Check('TAX_LIN');
    CheckTAX_SYS = await Get_Count_Check('TAX_SYS');
    CheckTAX_SYS_BRA = await Get_Count_Check('TAX_SYS_BRA');
    CheckTAX_SYS_D = await Get_Count_Check('TAX_SYS_D');
    CheckTAX_TYP = await Get_Count_Check('TAX_TYP');
    CheckTAX_TYP_BRA = await Get_Count_Check('TAX_TYP_BRA');
    CheckTAX_TYP_SYS = await Get_Count_Check('TAX_TYP_SYS');
    CheckTAX_TBL_LNK = await Get_Count_Check('TAX_TBL_LNK');
    CheckTAX_VAR = await Get_Count_Check('TAX_VAR');
    CheckTAX_VAR_D = await Get_Count_Check('TAX_VAR_D');
    CheckIDE_TYP = await Get_Count_Check('IDE_TYP');
    CheckIDE_LIN = await Get_Count_Check('IDE_LIN');
    CheckTAX_MOV_SIN = await Get_Count_Check('TAX_MOV_SIN');
    CheckRES_SEC = await Get_Count_Check('RES_SEC');
    CheckRES_TAB = await Get_Count_Check('RES_TAB');
    CheckRES_EMP = await Get_Count_Check('RES_EMP');
    CheckBIF_GRO = await Get_Count_Check('BIF_GRO');
    CheckBIF_GRO2 = await Get_Count_Check('BIF_GRO2');
    CheckMAT_FOL = await Get_Count_Check('MAT_FOL');
    CheckMAT_DES_M = await Get_Count_Check('MAT_DES_M');
    CheckMAT_DES_D = await Get_Count_Check('MAT_DES_D');
    CheckMAT_DIS_T = await Get_Count_Check('MAT_DIS_T');
    CheckMAT_DIS_K = await Get_Count_Check('MAT_DIS_K');
    CheckMAT_DIS_M = await Get_Count_Check('MAT_DIS_M');
    CheckMAT_DIS_D = await Get_Count_Check('MAT_DIS_D');
    CheckMAT_DIS_F = await Get_Count_Check('MAT_DIS_F');
    CheckMAT_DIS_L = await Get_Count_Check('MAT_DIS_L');
    CheckMAT_DIS_S = await Get_Count_Check('MAT_DIS_S');
    CheckMAT_MAI_M = await Get_Count_Check('MAT_MAI_M');
    CheckACC_TAX_C = await Get_Count_Check('ACC_TAX_C');
    CheckTAX_MOV_T = await Get_Count_Check('TAX_MOV_T');
    CheckTAX_PER_M = await Get_Count_Check('TAX_PER_M');
    CheckTAX_PER_D = await Get_Count_Check('TAX_PER_D');
    CheckTAX_PER_BRA = await Get_Count_Check('TAX_PER_BRA');
    CheckFAT_API_INF = await Get_Count_Check('FAT_API_INF');
    CheckFAT_CSID_INF = await Get_Count_Check('FAT_CSID_INF');
    CheckFAT_CSID_INF_D = await Get_Count_Check('FAT_CSID_INF_D');
    CheckFAT_CSID_SEQ = await Get_Count_Check('FAT_CSID_SEQ');
    CheckFAT_CSID_ST = await Get_Count_Check('FAT_CSID_ST');
    CheckFAT_INV_SND = await Get_Count_Check('FAT_INV_SND');
    CheckFAT_INV_SND_ARC = await Get_Count_Check('FAT_INV_SND_ARC');
    CheckFAT_QUE = await Get_Count_Check('FAT_QUE');
    CheckCOU_TYP_M = await Get_Count_Check('COU_TYP_M');
    CheckCOU_INF_M = await Get_Count_Check('COU_INF_M');
    CheckCOU_POI_L = await Get_Count_Check('COU_POI_L');
    CheckCOU_USR = await Get_Count_Check('COU_USR');
    CheckCOU_RED = await Get_Count_Check('COU_RED');
    CheckSYN_SET = await Get_Count_Check('SYN_SET');
    CheckSYN_OFF_M2 = await Get_Count_Check('SYN_OFF_M2');
    CheckSYN_OFF_M = await Get_Count_Check('SYN_OFF_M');
    CheckECO_VAR = await Get_Count_Check('ECO_VAR');
    CheckECO_ACC = await Get_Count_Check('ECO_ACC');
    CheckECO_MSG_ACC = await Get_Count_Check('ECO_MSG_ACC');
  }


//دالة اضافة الووصول السريع
  int ArrLengthFAS_ACC=0;
  Future<void> GetCheckFAS_ACC_USRData() async {
    ArrLengthFAS_ACC = await Get_FAS_ACC_USRData_Check();
    update();
    if (ArrLengthFAS_ACC == 0) {
      await DeleteFAS_ACC_USR();
      await SAVE_FAS_ACC_USR();
    }
    update();
  }

  Future<List<Sys_Usr_Local>> fetchSYS_USR() async {
    final dbClient = await conn.database;
    List<Sys_Usr_Local> contactList = [];
    try {
      final maps = await dbClient!.query('SYS_USR');
      for (var item in maps) {
        contactList.add(Sys_Usr_Local.fromMap(item));
      }
    } catch (e) {
      print(e.toString());
    }
    return contactList;
  }

  Future SAVE_FAS_ACC_USR() async {
      await fetchSYS_USR().then((userList) async {
        print(userList.length);
        print('userList');
        if (userList.isNotEmpty) {
          for (var i = 0; i < userList.length; i++) {
            try {
              //فواتير المبيعات
              Fas_Acc_Usr_Local FAS_ACC_USR1 = Fas_Acc_Usr_Local(
                  SUID: userList[i].SUID,
                  SSID: 601,
                  FAUST: 1,
                  FAUST2: 2,
                  ORDNU: 1,
                  SUID2: 'IT',
                  DATEI: DateTime.now().toString(),
                  DEVI: LoginController().DeviceName,
                  GUID: uuid.v4().toUpperCase(),
                  JTID_L: LoginController().JTID,
                  BIID_L: LoginController().BIID,
                  SYID_L: LoginController().SYID,
                  CIID_L: LoginController().CIID);
              //فاتورة مشتريات
              Fas_Acc_Usr_Local FAS_ACC_USR2 = Fas_Acc_Usr_Local(
                  SUID: userList[i].SUID,
                  SSID: 901,
                  FAUST: 1,
                  FAUST2: 2,
                  ORDNU: 2,
                  SUID2: 'IT',
                  DATEI: DateTime.now().toString(),
                  DEVI: LoginController().DeviceName,
                  GUID: uuid.v4().toUpperCase(),
                  JTID_L: LoginController().JTID,
                  BIID_L: LoginController().BIID,
                  SYID_L: LoginController().SYID,
                  CIID_L: LoginController().CIID);
              //سندات القبض
              Fas_Acc_Usr_Local FAS_ACC_USR3 = Fas_Acc_Usr_Local(
                  SUID: userList[i].SUID,
                  SSID: 102,
                  FAUST: 1,
                  FAUST2: 2,
                  ORDNU: 3,
                  SUID2: 'IT',
                  DATEI: DateTime.now().toString(),
                  DEVI: LoginController().DeviceName,
                  GUID: uuid.v4().toUpperCase(),
                  JTID_L: LoginController().JTID,
                  BIID_L: LoginController().BIID,
                  SYID_L: LoginController().SYID,
                  CIID_L: LoginController().CIID);
              //سندات الصرف
              Fas_Acc_Usr_Local FAS_ACC_USR4 = Fas_Acc_Usr_Local(
                  SUID: userList[i].SUID,
                  SSID: 103,
                  FAUST: 1,
                  FAUST2: 2,
                  ORDNU: 4,
                  SUID2: 'IT',
                  DATEI: DateTime.now().toString(),
                  DEVI: LoginController().DeviceName,
                  GUID: uuid.v4().toUpperCase(),
                  JTID_L: LoginController().JTID,
                  BIID_L: LoginController().BIID,
                  SYID_L: LoginController().SYID,
                  CIID_L: LoginController().CIID);
              //فاتورة مبيعات(POS)
              Fas_Acc_Usr_Local FAS_ACC_USR5 = Fas_Acc_Usr_Local(
                  SUID: userList[i].SUID,
                  SSID: 742,
                  FAUST: 2,
                  FAUST2: 2,
                  ORDNU: 5,
                  SUID2: 'IT',
                  DATEI: DateTime.now().toString(),
                  DEVI: LoginController().DeviceName,
                  GUID: uuid.v4().toUpperCase(),
                  JTID_L: LoginController().JTID,
                  BIID_L: LoginController().BIID,
                  SYID_L: LoginController().SYID,
                  CIID_L: LoginController().CIID);
              //فواتير الخدمات
              Fas_Acc_Usr_Local FAS_ACC_USR6 = Fas_Acc_Usr_Local(
                  SUID: userList[i].SUID,
                  SSID: 621,
                  FAUST: 2,
                  FAUST2: 2,
                  ORDNU: 6,
                  SUID2: 'IT',
                  DATEI: DateTime.now().toString(),
                  DEVI: LoginController().DeviceName,
                  GUID: uuid.v4().toUpperCase(),
                  JTID_L: LoginController().JTID,
                  BIID_L: LoginController().BIID,
                  SYID_L: LoginController().SYID,
                  CIID_L: LoginController().CIID);
              //مردود فواتير المبيعات
              Fas_Acc_Usr_Local FAS_ACC_USR7 = Fas_Acc_Usr_Local(
                  SUID: userList[i].SUID,
                  SSID: 611,
                  FAUST: 2,
                  FAUST2: 2,
                  ORDNU: 7,
                  SUID2: 'IT',
                  DATEI: DateTime.now().toString(),
                  DEVI: LoginController().DeviceName,
                  GUID: uuid.v4().toUpperCase(),
                  JTID_L: LoginController().JTID,
                  BIID_L: LoginController().BIID,
                  SYID_L: LoginController().SYID,
                  CIID_L: LoginController().CIID);
              //مردود مبيعات (POS)
              Fas_Acc_Usr_Local FAS_ACC_USR8 = Fas_Acc_Usr_Local(
                  SUID: userList[i].SUID,
                  SSID: 743,
                  FAUST: 2,
                  FAUST2: 2,
                  ORDNU: 8,
                  SUID2: 'IT',
                  DATEI: DateTime.now().toString(),
                  DEVI: LoginController().DeviceName,
                  GUID: uuid.v4().toUpperCase(),
                  JTID_L: LoginController().JTID,
                  BIID_L: LoginController().BIID,
                  SYID_L: LoginController().SYID,
                  CIID_L: LoginController().CIID);
              //القيود اليوميه
              Fas_Acc_Usr_Local FAS_ACC_USR9 = Fas_Acc_Usr_Local(
                  SUID: userList[i].SUID,
                  SSID: 111,
                  FAUST: 2,
                  FAUST2: 2,
                  ORDNU: 9,
                  SUID2: 'IT',
                  DATEI: DateTime.now().toString(),
                  DEVI: LoginController().DeviceName,
                  GUID: uuid.v4().toUpperCase(),
                  JTID_L: LoginController().JTID,
                  BIID_L: LoginController().BIID,
                  SYID_L: LoginController().SYID,
                  CIID_L: LoginController().CIID);
              //اعدادات العملاء
              Fas_Acc_Usr_Local FAS_ACC_USR10 = Fas_Acc_Usr_Local(
                  SUID: userList[i].SUID,
                  SSID: 91,
                  FAUST: 2,
                  FAUST2: 2,
                  ORDNU: 10,
                  SUID2: 'IT',
                  DATEI: DateTime.now().toString(),
                  DEVI: LoginController().DeviceName,
                  GUID: uuid.v4().toUpperCase(),
                  JTID_L: LoginController().JTID,
                  BIID_L: LoginController().BIID,
                  SYID_L: LoginController().SYID,
                  CIID_L: LoginController().CIID);
              //كشف حساب
              Fas_Acc_Usr_Local FAS_ACC_USR11 = Fas_Acc_Usr_Local(
                  SUID: userList[i].SUID,
                  SSID: 202,
                  FAUST: 2,
                  FAUST2: 2,
                  ORDNU: 11,
                  SUID2: 'IT',
                  DATEI: DateTime.now().toString(),
                  DEVI: LoginController().DeviceName,
                  GUID: uuid.v4().toUpperCase(),
                  JTID_L: LoginController().JTID,
                  BIID_L: LoginController().BIID,
                  SYID_L: LoginController().SYID,
                  CIID_L: LoginController().CIID);


              await SaveFAS_ACC_USR(FAS_ACC_USR1);
              await SaveFAS_ACC_USR(FAS_ACC_USR2);
              await SaveFAS_ACC_USR(FAS_ACC_USR3);
              await SaveFAS_ACC_USR(FAS_ACC_USR4);
              await SaveFAS_ACC_USR(FAS_ACC_USR5);
              await SaveFAS_ACC_USR(FAS_ACC_USR6);
              await SaveFAS_ACC_USR(FAS_ACC_USR7);
              await SaveFAS_ACC_USR(FAS_ACC_USR8);
              await SaveFAS_ACC_USR(FAS_ACC_USR9);
              await SaveFAS_ACC_USR(FAS_ACC_USR10);
              await SaveFAS_ACC_USR(FAS_ACC_USR11);
            } catch (e) {
              print(e.toString());
              Fluttertoast.showToast(
                  msg: "SAVE_FAS_ACC_USR: ${e.toString()}",
                  textColor: Colors.white,
                  backgroundColor: Colors.red);
              return Future.error(e);
            }
          }
        }
      });
  }


  configloading(String MESSAGE) {
    EasyLoading.instance
      ..displayDuration = const Duration(milliseconds: 6000)
      ..indicatorType = EasyLoadingIndicatorType.fadingCircle
      ..loadingStyle = EasyLoadingStyle.custom
      ..indicatorSize = 45.0
      ..radius = 10.0
      ..backgroundColor = Colors.grey[300]
      ..indicatorColor = Colors.black
      ..textColor = Colors.black
      ..maskColor = Colors.blue.withOpacity(0.5)
      ..userInteractions = true
      ..dismissOnTap = true;
    EasyLoading.showInfo(MESSAGE);
  }

  bool isValuePresent(String values, int valueToCheck) {
    // تحويل القيمة إلى سلسلة بالشكل المناسب
    String valueStr = '<$valueToCheck>';
    // التحقق مما إذا كانت القيمة موجودة في السلسلة
    return values.contains(valueStr);

  }

  Future GET_GEN_VAR_P() async {
    GET_GEN_VAR('SOMID').then((data) {
      GEN_VAR = data;
      if (GEN_VAR.isNotEmpty) {
        SYDV_ID_V = GEN_VAR.elementAt(0).VAL.toString();
        LoginController().SET_P('SYDV_ID',SYDV_ID_V);
        UpdateMOB_VAR(4,SYDV_ID_V);
      }
    });
    GET_GEN_VAR('SOMWN').then((data) {
      GEN_VAR = data;
      if (GEN_VAR.isNotEmpty) {
        SYDV_NO_V = GEN_VAR.elementAt(0).VAL.toString();
        LoginController().SET_P('SYDV_NO',SYDV_NO_V);
        UpdateMOB_VAR(5,SYDV_NO_V);
      }
    });
    GET_GEN_VAR('SOMGU').then((data) {
      GEN_VAR = data;
      if (GEN_VAR.isNotEmpty) {
        F_GUID_V = GEN_VAR.elementAt(0).VAL.toString();
      }
    });
    GET_GEN_VAR('PKID1').then((data) {
      GEN_VAR = data;
      if (GEN_VAR.isNotEmpty) {
        LoginController().SET_P('PKID1',GEN_VAR.elementAt(0).VAL.toString());
      }
    });
    GET_GEN_VAR('PKID3').then((data) {
      GEN_VAR = data;
      if (GEN_VAR.isNotEmpty) {
        LoginController().SET_P('PKID2',GEN_VAR.elementAt(0).VAL.toString());
      }
    });
    GET_GEN_VAR('SYN_USR_TYP').then((data) {
      GEN_VAR = data;
      if (GEN_VAR.isNotEmpty) {
        LoginController().SET_P('SYN_USR_TYP',GEN_VAR.elementAt(0).VAL.toString());
        print(GEN_VAR.elementAt(0).VAL.toString());
        print('isValuePresent');
        // اختبار القيم
        if(isValuePresent(LoginController().SYN_USR_TYP, int.parse(LoginController().SUID))){
          print('isValuePresent(values, true)');
        }
        else{
          if(LoginController().SUID!=''){
            DeleteAllDataByUser();}
        }
      }
    });
  }


  // داله جلب وحفظ قيمه كل عدد سجلات الجداول
  Future GET_ROW_NUM() async {
   await GetLastSyncDate_P();
   var SYN_ORD=await GET_SYN_ORD('SYS_VAR');
      if (SYN_ORD.isNotEmpty) {
        TotalSYS_VAR = SYN_ORD.elementAt(0).ROW_NUM!;
        LastSYS_VAR.value = SYN_ORD.elementAt(0).SOLD.toString();
        update();
      }
      else{
        TotalSYS_VAR=0;
        update();
      }

    SYN_ORD=await GET_SYN_ORD('SYN_DAT');
      if (SYN_ORD.isNotEmpty) {
        TotalSYN_DAT = SYN_ORD.elementAt(0).ROW_NUM!;
        LastSYN_DAT = SYN_ORD.elementAt(0).SOLD.toString();
      }
      else{
        TotalSYN_DAT=0;
      }
    SYN_ORD=await GET_SYN_ORD('SYS_OWN');
      if (SYN_ORD.isNotEmpty) {
        TotalSYS_OWN = SYN_ORD
            .elementAt(0)
            .ROW_NUM!;
        LastSys_Won = SYN_ORD
            .elementAt(0)
            .SOLD
            .toString();
        update();
      }
      else{
        TotalSYS_OWN=0;
      }

    SYN_ORD=await GET_SYN_ORD('ACC_MOV_K');
      if (SYN_ORD.isNotEmpty) {
        TotalACC_MOV_K = SYN_ORD.elementAt(0).ROW_NUM!;
        LastACC_MOV_K = SYN_ORD.elementAt(0).SOLD.toString();
        update();
      }
      else{
        TotalACC_MOV_K=0;
      }

    SYN_ORD=await GET_SYN_ORD(STMID=='INVC'?'STO_MOV_K':'BIL_MOV_K');

      if (SYN_ORD.isNotEmpty) {
        TotalBIL_MOV_K = SYN_ORD
            .elementAt(0)
            .ROW_NUM!;
        LastBIL_MOV_K = SYN_ORD
            .elementAt(0)
            .SOLD
            .toString();
        update();
      }
      else{
        TotalBIL_MOV_K=0;
      }

    SYN_ORD=await GET_SYN_ORD('BRA_INF');
      if (SYN_ORD.isNotEmpty) {
        TotalBRA_INF = SYN_ORD
            .elementAt(0)
            .ROW_NUM!;
        LastBra_Inf = SYN_ORD
            .elementAt(0)
            .SOLD
            .toString();
        update();
      }
      else{
        TotalBRA_INF=0;
      }
    SYN_ORD=await GET_SYN_ORD('SYS_USR');
      if (SYN_ORD.isNotEmpty) {
        TotalSYS_USR = SYN_ORD
            .elementAt(0)
            .ROW_NUM!;
        LastSys_Usr = SYN_ORD
            .elementAt(0)
            .SOLD
            .toString();
      }
      else{
        TotalSYS_USR=0;
      }
    SYN_ORD=await GET_SYN_ORD('USR_PRI');
      if (SYN_ORD.isNotEmpty) {
        TotalUSR_PRI = SYN_ORD
            .elementAt(0)
            .ROW_NUM!;
        LastUsr_Pri = SYN_ORD
            .elementAt(0)
            .SOLD
            .toString();
      }
      else{
        TotalUSR_PRI=0;
      }

    SYN_ORD=await GET_SYN_ORD('SYS_USR_B');

      if (SYN_ORD.isNotEmpty) {
        TotalSYS_USR_B = SYN_ORD
            .elementAt(0)
            .ROW_NUM!;
        LastSys_Usr_B = SYN_ORD
            .elementAt(0)
            .SOLD
            .toString();
      }
      else{
        TotalSYS_USR_B=0;
      }

    SYN_ORD=await GET_SYN_ORD('STO_INF');
      if (SYN_ORD.isNotEmpty) {
        TotalSTO_INF = SYN_ORD
            .elementAt(0)
            .ROW_NUM!;
        LastSto_Inf = SYN_ORD
            .elementAt(0)
            .SOLD
            .toString();
      }
      else{
        TotalSTO_INF=0;
      }

    SYN_ORD=await GET_SYN_ORD('STO_USR');
      if (SYN_ORD.isNotEmpty) {
        TotalSTO_USR = SYN_ORD
            .elementAt(0)
            .ROW_NUM!;
        LastSto_Usr = SYN_ORD
            .elementAt(0)
            .SOLD
            .toString();
      }
      else{
        TotalSTO_USR=0;
      }

    SYN_ORD=await GET_SYN_ORD('MAT_GRO');
      if (SYN_ORD.isNotEmpty) {
        TotalMAT_GRO = SYN_ORD
            .elementAt(0)
            .ROW_NUM!;
        LastMat_Gro = SYN_ORD
            .elementAt(0)
            .SOLD
            .toString();
      }
      else{
        TotalMAT_GRO=0;
      }

    SYN_ORD=await GET_SYN_ORD('GRO_USR');
      if (SYN_ORD.isNotEmpty) {
        TotalGRO_USR = SYN_ORD
            .elementAt(0)
            .ROW_NUM!;
        LastGro_Usr = SYN_ORD
            .elementAt(0)
            .SOLD
            .toString();
      }
      else{
        TotalGRO_USR=0;
      }

    SYN_ORD=await GET_SYN_ORD('MAT_UNI');
      if (SYN_ORD.isNotEmpty) {
        TotalMAT_UNI = SYN_ORD
            .elementAt(0)
            .ROW_NUM!;
        LastMat_Uni = SYN_ORD
            .elementAt(0)
            .SOLD
            .toString();
      }
      else{
        TotalMAT_UNI=0;
      }

    SYN_ORD=await GET_SYN_ORD('MAT_INF');
      if (SYN_ORD.isNotEmpty) {
        TotalMAT_INF = SYN_ORD
            .elementAt(0)
            .ROW_NUM!;
        LastMat_Inf = SYN_ORD
            .elementAt(0)
            .SOLD
            .toString();
      }
      else{
        TotalMAT_INF=0;
      }


    SYN_ORD=await GET_SYN_ORD('MAT_UNI_C');
      if (SYN_ORD.isNotEmpty) {
        TotalMAT_UNI_C = SYN_ORD
            .elementAt(0)
            .ROW_NUM!;
        LastMat_Uni_C = SYN_ORD
            .elementAt(0)
            .SOLD
            .toString();
      }
      else{
        TotalMAT_UNI_C=0;
      }

    SYN_ORD=await GET_SYN_ORD('MAT_UNI_B');
      if (SYN_ORD.isNotEmpty) {
        TotalMAT_UNI_B = SYN_ORD
            .elementAt(0)
            .ROW_NUM!;
        LastMat_Uni_B = SYN_ORD
            .elementAt(0)
            .SOLD
            .toString();
      }
      else{
        TotalMAT_UNI_B=0;
      }

    SYN_ORD=await GET_SYN_ORD('MAT_PRI');

      if (SYN_ORD.isNotEmpty) {
        TotalMAT_PRI = SYN_ORD
            .elementAt(0)
            .ROW_NUM!;
        LastMat_Pri = SYN_ORD
            .elementAt(0)
            .SOLD
            .toString();
      }
      else{
        TotalMAT_PRI=0;
      }

    SYN_ORD=await GET_SYN_ORD(STMID=='EORD'?'MAT_INF_D':'MAT_INF_A');
      if (SYN_ORD.isNotEmpty) {
        TotalMAT_INF_A = SYN_ORD
            .elementAt(0)
            .ROW_NUM!;
        LastMat_Inf_A = SYN_ORD
            .elementAt(0)
            .SOLD
            .toString();
      }
      else{
        TotalMAT_INF_A=0;
      }

    SYN_ORD=await GET_SYN_ORD('STO_NUM');
      if (SYN_ORD.isNotEmpty) {
        TotalSTO_NUM = SYN_ORD.elementAt(0)
            .ROW_NUM!;
        LastSto_Num = SYN_ORD
            .elementAt(0)
            .SOLD
            .toString();
      }
      else{
        TotalSTO_NUM=0;
      }

    SYN_ORD=await GET_SYN_ORD('SYS_DOC_D');
      if (SYN_ORD.isNotEmpty) {
        TotalSYS_DOC_D = SYN_ORD
            .elementAt(0)
            .ROW_NUM!;
        LastSys_Doc = SYN_ORD
            .elementAt(0)
            .SOLD
            .toString();
      }
      else{
        TotalSYS_DOC_D=0;
      }

    SYN_ORD=await GET_SYN_ORD('BRA_YEA');
      if (SYN_ORD.isNotEmpty) {
        TotalBRA_YEA = SYN_ORD
            .elementAt(0)
            .ROW_NUM!;
        LastBRA_YEA = SYN_ORD
            .elementAt(0)
            .SOLD
            .toString();
      }
      else{
        TotalBRA_YEA=0;
      }

    SYN_ORD=await GET_SYN_ORD('SYS_SCR');
      if (SYN_ORD.isNotEmpty) {
        TotalSYS_SCR = SYN_ORD
            .elementAt(0)
            .ROW_NUM!;
        LastSYS_SCR = SYN_ORD
            .elementAt(0)
            .SOLD
            .toString();
      }
      else{
        TotalSYS_SCR=0;
      }

    SYN_ORD=await GET_SYN_ORD('SYS_SCR_N');
      if (SYN_ORD.isNotEmpty) {
        TotalSYS_SCR_N = SYN_ORD
            .elementAt(0)
            .ROW_NUM!;
        LastSYS_SCR_N = SYN_ORD
            .elementAt(0)
            .SOLD
            .toString();
      }
      else{
        TotalSYS_SCR_N=0;
      }

    SYN_ORD=await GET_SYN_ORD('BIL_CUS_T');
      if (SYN_ORD.isNotEmpty) {
        TotalBIL_CUS_T = SYN_ORD
            .elementAt(0)
            .ROW_NUM!;
        LastBIL_CUS_T = SYN_ORD
            .elementAt(0)
            .SOLD
            .toString();
      }
      else{
        TotalBIL_CUS_T=0;
      }


    SYN_ORD=await GET_SYN_ORD('ACC_TAX_T');
      if (SYN_ORD.isNotEmpty) {
        TotalACC_TAX_T = SYN_ORD
            .elementAt(0)
            .ROW_NUM!;
        LastACC_TAX_T = SYN_ORD
            .elementAt(0)
            .SOLD
            .toString();
      }
      else{
        TotalACC_TAX_T=0;
      }

    SYN_ORD=await GET_SYN_ORD('BIL_CUS');
      if (SYN_ORD.isNotEmpty) {
        TotalBIL_CUS = SYN_ORD
            .elementAt(0)
            .ROW_NUM!;
        LastBIL_CUS = SYN_ORD
            .elementAt(0)
            .SOLD
            .toString();
      }
      else{
        TotalBIL_CUS=0;
      }

    SYN_ORD=await GET_SYN_ORD('BIF_CUS_D');
      if (SYN_ORD.isNotEmpty) {
        TotalBIF_CUS_D = SYN_ORD
            .elementAt(0)
            .ROW_NUM!;
        LastBIF_CUS_D = SYN_ORD
            .elementAt(0)
            .SOLD
            .toString();
      }
      else{
        TotalBIF_CUS_D=0;
      }

    SYN_ORD=await GET_SYN_ORD('BIL_DIS');
      if (SYN_ORD.isNotEmpty) {
        TotalBIL_DIS = SYN_ORD
            .elementAt(0)
            .ROW_NUM!;
        LastBIL_DIS = SYN_ORD
            .elementAt(0)
            .SOLD
            .toString();
      }
      else{
        TotalBIL_DIS=0;
      }

    SYN_ORD=await GET_SYN_ORD('SHI_INF');
      if (SYN_ORD.isNotEmpty) {
        TotalSHI_INF = SYN_ORD
            .elementAt(0)
            .ROW_NUM!;
        LastSHI_INF = SYN_ORD
            .elementAt(0)
            .SOLD
            .toString();
      }
      else{
        TotalSHI_INF=0;
      }

    SYN_ORD=await GET_SYN_ORD('SHI_USR');
      if (SYN_ORD.isNotEmpty) {
        TotalSHI_USR = SYN_ORD
            .elementAt(0)
            .ROW_NUM!;
        LastSHI_USR = SYN_ORD
            .elementAt(0)
            .SOLD
            .toString();
      }
      else{
        TotalSHI_USR=0;
      }

    SYN_ORD=await GET_SYN_ORD('BIL_POI');
      if (SYN_ORD.isNotEmpty) {
        TotalBIL_POI = SYN_ORD
            .elementAt(0)
            .ROW_NUM!;
        LastBIL_POI = SYN_ORD
            .elementAt(0)
            .SOLD
            .toString();
      }
      else{
        TotalBIL_POI=0;
      }

    SYN_ORD=await GET_SYN_ORD('BIL_POI_U');
      if (SYN_ORD.isNotEmpty) {
        TotalBIL_POI_U = SYN_ORD
            .elementAt(0)
            .ROW_NUM!;
        LastBIL_POI_U = SYN_ORD
            .elementAt(0)
            .SOLD
            .toString();
      }
      else{
        TotalBIL_POI_U=0;
      }

    SYN_ORD=await GET_SYN_ORD('COU_WRD');
      if (SYN_ORD.isNotEmpty) {
        TotalCOU_WRD = SYN_ORD
            .elementAt(0)
            .ROW_NUM!;
        LastCOU_WRD = SYN_ORD
            .elementAt(0)
            .SOLD
            .toString();
      }
      else{
        TotalCOU_WRD=0;
      }

    SYN_ORD=await GET_SYN_ORD('BIL_IMP');
      if (SYN_ORD.isNotEmpty) {
        TotalBIL_IMP = SYN_ORD
            .elementAt(0)
            .ROW_NUM!;
        LastBIL_IMP = SYN_ORD
            .elementAt(0)
            .SOLD
            .toString();
      }
      else{
        TotalBIL_IMP=0;
      }

    SYN_ORD=await GET_SYN_ORD('COU_TOW');
      if (SYN_ORD.isNotEmpty) {
        TotalCOU_TOW = SYN_ORD
            .elementAt(0)
            .ROW_NUM!;
        LastCOU_TOW = SYN_ORD
            .elementAt(0)
            .SOLD
            .toString();
      }
      else{
        TotalCOU_TOW=0;
      }

    SYN_ORD=await GET_SYN_ORD('BIL_USR_D');
      if (SYN_ORD.isNotEmpty) {
        TotalBIL_USR_D = SYN_ORD
            .elementAt(0)
            .ROW_NUM!;
        LastBIL_USR_D = SYN_ORD
            .elementAt(0)
            .SOLD
            .toString();
      }
      else{
        TotalBIL_USR_D=0;
      }

    SYN_ORD=await GET_SYN_ORD('SYS_REF');
      if (SYN_ORD.isNotEmpty) {
        TotalSYS_REF = SYN_ORD
            .elementAt(0)
            .ROW_NUM!;
        LastSYS_REF = SYN_ORD
            .elementAt(0)
            .SOLD
            .toString();
      }
      else{
        TotalSYS_REF=0;
      }

    SYN_ORD=await GET_SYN_ORD('ACC_COS');
      if (SYN_ORD.isNotEmpty) {
        TotalACC_COS = SYN_ORD
            .elementAt(0)
            .ROW_NUM!;
        LastACC_COS = SYN_ORD
            .elementAt(0)
            .SOLD
            .toString();
      }
      else{
        TotalACC_COS=0;
      }

    SYN_ORD=await GET_SYN_ORD('COS_USR');
      if (SYN_ORD.isNotEmpty) {
        TotalCOS_USR = SYN_ORD
            .elementAt(0)
            .ROW_NUM!;
        LastCOS_USR = SYN_ORD
            .elementAt(0)
            .SOLD
            .toString();
      }
      else{
        TotalCOS_USR=0;
      }

    SYN_ORD=await GET_SYN_ORD('PAY_KIN');
      if (SYN_ORD.isNotEmpty) {
        TotalPAY_KIN = SYN_ORD
            .elementAt(0)
            .ROW_NUM!;
        LastPAY_KIN = SYN_ORD
            .elementAt(0)
            .SOLD
            .toString();
      }
      else{
        TotalPAY_KIN=0;
      }

    SYN_ORD=await GET_SYN_ORD('SYS_CUR');
      if (SYN_ORD.isNotEmpty) {
        TotalSYS_CUR = SYN_ORD
            .elementAt(0)
            .ROW_NUM!;
        LastSYS_CUR = SYN_ORD
            .elementAt(0)
            .SOLD
            .toString();
      }
      else{
        TotalSYS_CUR=0;
      }

    SYN_ORD=await GET_SYN_ORD('SYS_CUR_D');
      if (SYN_ORD.isNotEmpty) {
        TotalSYS_CUR_D = SYN_ORD
            .elementAt(0)
            .ROW_NUM!;
        LastSYS_CUR_D = SYN_ORD
            .elementAt(0)
            .SOLD
            .toString();
      }
      else{
        TotalSYS_CUR_D=0;
      }

    SYN_ORD=await GET_SYN_ORD('SYS_CUR_BET');
      if (SYN_ORD.isNotEmpty) {
        TotalSYS_CUR_BET = SYN_ORD
            .elementAt(0)
            .ROW_NUM!;
        LastSYS_CUR_BET = SYN_ORD
            .elementAt(0)
            .SOLD
            .toString();
      }
      else{
        TotalSYS_CUR_BET=0;
      }

    SYN_ORD=await GET_SYN_ORD('ACC_CAS');
      if (SYN_ORD.isNotEmpty) {
        TotalACC_CAS = SYN_ORD
            .elementAt(0)
            .ROW_NUM!;
        LastACC_CAS = SYN_ORD
            .elementAt(0)
            .SOLD
            .toString();
      }
      else{
        TotalACC_CAS=0;
      }

    SYN_ORD=await GET_SYN_ORD('ACC_CAS_U');
      if (SYN_ORD.isNotEmpty) {
        TotalACC_CAS_U = SYN_ORD
            .elementAt(0)
            .ROW_NUM!;
        LastACC_CAS_U = SYN_ORD
            .elementAt(0)
            .SOLD
            .toString();
      }
      else{
        TotalACC_CAS_U=0;
      }


    SYN_ORD=await GET_SYN_ORD('ACC_USR');
      if (SYN_ORD.isNotEmpty) {
        TotalACC_USR = SYN_ORD
            .elementAt(0)
            .ROW_NUM!;
        LastACC_USR = SYN_ORD
            .elementAt(0)
            .SOLD
            .toString();
      }
      else{
        TotalACC_USR=0;
      }


    SYN_ORD=await GET_SYN_ORD('BIL_CRE_C');
      if (SYN_ORD.isNotEmpty) {
        TotalBIL_CRE_C = SYN_ORD
            .elementAt(0)
            .ROW_NUM!;
        LastBIL_CRE_C = SYN_ORD
            .elementAt(0)
            .SOLD
            .toString();
      }
      else{
        TotalBIL_CRE_C=0;
      }


    SYN_ORD=await GET_SYN_ORD('ACC_BAN');
      if (SYN_ORD.isNotEmpty) {
        TotalACC_BAN = SYN_ORD
            .elementAt(0)
            .ROW_NUM!;
        LastACC_BAN = SYN_ORD
            .elementAt(0)
            .SOLD
            .toString();
      }
      else{
        TotalACC_BAN=0;
      }


    SYN_ORD=await GET_SYN_ORD('ACC_ACC');
      if (SYN_ORD.isNotEmpty) {
        TotalACC_ACC = SYN_ORD
            .elementAt(0)
            .ROW_NUM!;
        LastACC_ACC = SYN_ORD
            .elementAt(0)
            .SOLD
            .toString();
      }
      else{
        TotalACC_ACC=0;
      }

    SYN_ORD=await GET_SYN_ORD('BIL_ARE');
      if (SYN_ORD.isNotEmpty) {
        TotalBIL_ARE = SYN_ORD
            .elementAt(0)
            .ROW_NUM!;
        LastBil_Are = SYN_ORD
            .elementAt(0)
            .SOLD
            .toString();
      }
      else{
        TotalBIL_ARE=0;
      }


    SYN_ORD=await GET_SYN_ORD('BAL_ACC_M');
      if (SYN_ORD.isNotEmpty) {
        TotalBAL_ACC_M = SYN_ORD
            .elementAt(0)
            .ROW_NUM!;
        LastBAL_ACC_M = SYN_ORD
            .elementAt(0)
            .SOLD
            .toString();
      }
      else{
        TotalBAL_ACC_M=0;
      }


    SYN_ORD=await GET_SYN_ORD('BAL_ACC_C');
      if (SYN_ORD.isNotEmpty) {
        TotalBAL_ACC_C = SYN_ORD
            .elementAt(0)
            .ROW_NUM!;
        LastBAL_ACC_C = SYN_ORD
            .elementAt(0)
            .SOLD
            .toString();
      }
      else{
        TotalBAL_ACC_C=0;
      }


    SYN_ORD=await GET_SYN_ORD('BAL_ACC_D');
      if (SYN_ORD.isNotEmpty) {
        TotalBAL_ACC_D = SYN_ORD
            .elementAt(0)
            .ROW_NUM!;
        LastBAL_ACC_D = SYN_ORD
            .elementAt(0)
            .SOLD
            .toString();
      }
      else{
        TotalBAL_ACC_D=0;
      }


    SYN_ORD=await GET_SYN_ORD('TAX_COD');
      if (SYN_ORD.isNotEmpty) {
        TotalTAX_COD = SYN_ORD
            .elementAt(0)
            .ROW_NUM!;
        LastTAX_COD = SYN_ORD
            .elementAt(0)
            .SOLD
            .toString();
      }
      else{
        TotalTAX_COD=0;
      }


    SYN_ORD=await GET_SYN_ORD('TAX_COD_SYS');
      if (SYN_ORD.isNotEmpty) {
        TotalTAX_COD_SYS = SYN_ORD
            .elementAt(0)
            .ROW_NUM!;
        LastTAX_COD_SYS = SYN_ORD
            .elementAt(0)
            .SOLD
            .toString();
      }
      else{
        TotalTAX_COD_SYS=0;
      }

    SYN_ORD=await GET_SYN_ORD('TAX_COD_SYS_D');
      if (SYN_ORD.isNotEmpty) {
        TotalTAX_COD_SYS_D = SYN_ORD
            .elementAt(0)
            .ROW_NUM!;
        LastTAX_COD_SYS_D = SYN_ORD
            .elementAt(0)
            .SOLD
            .toString();
      }
      else{
        TotalTAX_COD_SYS_D=0;
      }


    SYN_ORD=await GET_SYN_ORD('TAX_LOC');
      if (SYN_ORD.isNotEmpty) {
        TotalTAX_LOC = SYN_ORD
            .elementAt(0)
            .ROW_NUM!;
        LastTAX_LOC = SYN_ORD
            .elementAt(0)
            .SOLD
            .toString();
      }
      else{
        TotalTAX_LOC=0;
      }


    SYN_ORD=await GET_SYN_ORD('TAX_LOC_SYS');
      if (SYN_ORD.isNotEmpty) {
        TotalTAX_LOC_SYS = SYN_ORD
            .elementAt(0)
            .ROW_NUM!;
        LastTAX_LOC_SYS = SYN_ORD
            .elementAt(0)
            .SOLD
            .toString();
      }
      else{
        TotalTAX_LOC_SYS=0;
      }

    SYN_ORD=await GET_SYN_ORD('TAX_SYS');
      if (SYN_ORD.isNotEmpty) {
        TotalTAX_SYS = SYN_ORD
            .elementAt(0)
            .ROW_NUM!;
        LastTAX_SYS = SYN_ORD
            .elementAt(0)
            .SOLD
            .toString();
      }
      else{
        TotalTAX_SYS=0;
      }

    SYN_ORD=await GET_SYN_ORD('TAX_MOV_SIN');
      if (SYN_ORD.isNotEmpty) {
        TotalTAX_MOV_SIN = SYN_ORD
            .elementAt(0)
            .ROW_NUM!;
        LastTAX_MOV_SIN = SYN_ORD
            .elementAt(0)
            .SOLD
            .toString();
      }
      else{
        TotalTAX_MOV_SIN=0;
      }


    SYN_ORD=await GET_SYN_ORD('TAX_SYS_BRA');
      if (SYN_ORD.isNotEmpty) {
        TotalTAX_SYS_BRA = SYN_ORD.elementAt(0).ROW_NUM!;
        LastTAX_SYS_BRA = SYN_ORD.elementAt(0).SOLD.toString();
      }
      else{
        TotalTAX_SYS_BRA=0;
      }


    SYN_ORD=await GET_SYN_ORD('TAX_SYS_D');
      if (SYN_ORD.isNotEmpty) {
        TotalTAX_SYS_D = SYN_ORD
            .elementAt(0)
            .ROW_NUM!;
        LastTAX_SYS_D = SYN_ORD
            .elementAt(0)
            .SOLD
            .toString();
      }
      else{
        TotalTAX_SYS_D=0;
      }


    SYN_ORD=await GET_SYN_ORD('TAX_TYP');
      if (SYN_ORD.isNotEmpty) {
        TotalTAX_TYP = SYN_ORD
            .elementAt(0)
            .ROW_NUM!;
        LastTAX_TYP = SYN_ORD
            .elementAt(0)
            .SOLD
            .toString();
      }
      else{
        TotalTAX_TYP=0;
      }

    SYN_ORD=await GET_SYN_ORD('TAX_TYP_BRA');
      if (SYN_ORD.isNotEmpty) {
        TotalTAX_TYP_BRA = SYN_ORD
            .elementAt(0)
            .ROW_NUM!;
        LastTAX_TYP_BRA = SYN_ORD
            .elementAt(0)
            .SOLD
            .toString();
      }
      else{
        TotalTAX_TYP_BRA=0;
      }

    SYN_ORD=await GET_SYN_ORD('TAX_TYP_SYS');
      if (SYN_ORD.isNotEmpty) {
        TotalTAX_TYP_SYS = SYN_ORD
            .elementAt(0)
            .ROW_NUM!;
        LastTAX_TYP_SYS = SYN_ORD
            .elementAt(0)
            .SOLD
            .toString();
      }
      else{
        TotalTAX_TYP_SYS=0;
      }

    SYN_ORD=await GET_SYN_ORD('TAX_LIN');
      if (SYN_ORD.isNotEmpty) {
        TotalTAX_LIN = SYN_ORD
            .elementAt(0)
            .ROW_NUM!;
        LastTAX_LIN = SYN_ORD
            .elementAt(0)
            .SOLD
            .toString();
      }
      else{
        TotalTAX_LIN=0;
      }

    SYN_ORD=await GET_SYN_ORD('TAX_TBL_LNK');
      if (SYN_ORD.isNotEmpty) {
        TotalTAX_TBL_LNK = SYN_ORD
            .elementAt(0)
            .ROW_NUM!;
        LastTAX_TBL_LNK = SYN_ORD
            .elementAt(0)
            .SOLD
            .toString();
      }
      else{
        TotalTAX_TBL_LNK=0;
      }

    SYN_ORD=await GET_SYN_ORD('TAX_VAR');
      if (SYN_ORD.isNotEmpty) {
        TotalTAX_VAR = SYN_ORD
            .elementAt(0)
            .ROW_NUM!;
        LastTAX_VAR = SYN_ORD
            .elementAt(0)
            .SOLD
            .toString();
      }
      else{
        TotalTAX_VAR=0;
      }

    SYN_ORD=await GET_SYN_ORD('TAX_VAR_D');
      if (SYN_ORD.isNotEmpty) {
        TotalTAX_VAR_D = SYN_ORD
            .elementAt(0)
            .ROW_NUM!;
        LastTAX_VAR_D = SYN_ORD
            .elementAt(0)
            .SOLD
            .toString();
      }
      else{
        TotalTAX_VAR_D=0;
      }

    SYN_ORD=await GET_SYN_ORD('IDE_TYP');
      if (SYN_ORD.isNotEmpty) {
        TotalIDE_TYP = SYN_ORD
            .elementAt(0)
            .ROW_NUM!;
        LastIDE_TYP = SYN_ORD
            .elementAt(0)
            .SOLD
            .toString();
      }
      else{
        TotalIDE_TYP=0;
      }

    SYN_ORD=await GET_SYN_ORD('IDE_LIN');
      if (SYN_ORD.isNotEmpty) {
        TotalIDE_LIN = SYN_ORD
            .elementAt(0)
            .ROW_NUM!;
        LastIDE_LIN = SYN_ORD
            .elementAt(0)
            .SOLD
            .toString();
      }
      else{
        TotalIDE_LIN=0;
      }

    SYN_ORD=await GET_SYN_ORD('RES_SEC');
      if (SYN_ORD.isNotEmpty) {
        TotalRES_SEC = SYN_ORD
            .elementAt(0)
            .ROW_NUM!;
        LastRES_SEC= SYN_ORD
            .elementAt(0)
            .SOLD
            .toString();
      }
      else{
        TotalRES_SEC=0;
      }

    SYN_ORD=await GET_SYN_ORD('RES_TAB');
      if (SYN_ORD.isNotEmpty) {
        TotalRES_TAB = SYN_ORD
            .elementAt(0)
            .ROW_NUM!;
        LastRES_TAB = SYN_ORD
            .elementAt(0)
            .SOLD
            .toString();
      }
      else{
        TotalRES_TAB=0;
      }

    SYN_ORD=await GET_SYN_ORD('RES_EMP');
      if (SYN_ORD.isNotEmpty) {
        TotalRES_EMP = SYN_ORD
            .elementAt(0)
            .ROW_NUM!;
        LastRES_EMP = SYN_ORD
            .elementAt(0)
            .SOLD
            .toString();
      }
      else{
        TotalRES_EMP=0;
      }


    SYN_ORD=await GET_SYN_ORD('BIF_GRO');
      if (SYN_ORD.isNotEmpty) {
        TotalBIF_GRO = SYN_ORD
            .elementAt(0)
            .ROW_NUM!;
        LastBIF_GRO = SYN_ORD.elementAt(0).SOLD.toString();
      }
      else{
        TotalBIF_GRO=0;
      }

    SYN_ORD=await GET_SYN_ORD('BIF_GRO2');
      if (SYN_ORD.isNotEmpty) {
        TotalBIF_GRO2 = SYN_ORD.elementAt(0).ROW_NUM!;
        LastBIF_GRO2 = SYN_ORD.elementAt(0).SOLD.toString();
      }
      else{
        TotalBIF_GRO2=0;
      }

    SYN_ORD=await GET_SYN_ORD('MAT_FOL');
      if (SYN_ORD.isNotEmpty) {
        TotalMAT_FOL = SYN_ORD.elementAt(0).ROW_NUM!;
        LastMAT_FOL = SYN_ORD.elementAt(0).SOLD.toString();
      }
      else{
        TotalMAT_FOL=0;
      }

    SYN_ORD=await GET_SYN_ORD('MAT_DES_M');
      if (SYN_ORD.isNotEmpty) {
        TotalMAT_DES_M = SYN_ORD.elementAt(0).ROW_NUM!;
        LastMAT_DES_M = SYN_ORD.elementAt(0).SOLD.toString();
      }
      else{
        TotalMAT_DES_M=0;
      }

    SYN_ORD=await GET_SYN_ORD('MAT_DES_D');
      if (SYN_ORD.isNotEmpty) {
        TotalMAT_DES_D = SYN_ORD.elementAt(0).ROW_NUM!;
        LastMAT_DES_D = SYN_ORD.elementAt(0).SOLD.toString();
      }
      else{
        TotalMAT_DES_D=0;
      }

    SYN_ORD=await GET_SYN_ORD('MAT_DIS_T');
      if (SYN_ORD.isNotEmpty) {
        TotalMAT_DIS_T = SYN_ORD.elementAt(0).ROW_NUM!;
        LastMAT_DIS_T = SYN_ORD.elementAt(0).SOLD.toString();
      }
      else{
        TotalMAT_DIS_T=0;
      }


    SYN_ORD=await GET_SYN_ORD('MAT_DIS_K');
      if (SYN_ORD.isNotEmpty) {
        TotalMAT_DIS_K = SYN_ORD.elementAt(0).ROW_NUM!;
        LastMAT_DIS_K = SYN_ORD.elementAt(0).SOLD.toString();
      }
      else{
        TotalMAT_DIS_K=0;
      }

    SYN_ORD=await GET_SYN_ORD('MAT_DIS_M');
      if (SYN_ORD.isNotEmpty) {
        TotalMAT_DIS_M = SYN_ORD.elementAt(0).ROW_NUM!;
        LastMAT_DIS_M = SYN_ORD.elementAt(0).SOLD.toString();
      }
      else{
        TotalMAT_DIS_M=0;
      }

    SYN_ORD=await GET_SYN_ORD('MAT_DIS_D');
      if (SYN_ORD.isNotEmpty) {
        TotalMAT_DIS_D = SYN_ORD.elementAt(0).ROW_NUM!;
        LastMAT_DIS_D = SYN_ORD.elementAt(0).SOLD.toString();
      }
      else{
        TotalMAT_DIS_D=0;
      }

    SYN_ORD=await GET_SYN_ORD('MAT_DIS_F');
      if (SYN_ORD.isNotEmpty) {
        TotalMAT_DIS_F = SYN_ORD.elementAt(0).ROW_NUM!;
        LastMAT_DIS_F = SYN_ORD.elementAt(0).SOLD.toString();
      }
      else{
        TotalMAT_DIS_F=0;
      }

    SYN_ORD=await GET_SYN_ORD('MAT_DIS_S');
      if (SYN_ORD.isNotEmpty) {
        TotalMAT_DIS_S = SYN_ORD.elementAt(0).ROW_NUM!;
        LastMAT_DIS_S = SYN_ORD.elementAt(0).SOLD.toString();
      }
      else{
        TotalMAT_DIS_S=0;
      }

    SYN_ORD=await GET_SYN_ORD('MAT_DIS_L');
      if (SYN_ORD.isNotEmpty) {
        TotalMAT_DIS_L = SYN_ORD.elementAt(0).ROW_NUM!;
        LastMAT_DIS_L = SYN_ORD.elementAt(0).SOLD.toString();
      }
      else{
        TotalMAT_DIS_L=0;
      }

    SYN_ORD=await GET_SYN_ORD('MAT_MAI_M');
      if (SYN_ORD.isNotEmpty) {
        TotalMAT_MAI_M = SYN_ORD.elementAt(0).ROW_NUM!;
        LastMAT_MAI_M = SYN_ORD.elementAt(0).SOLD.toString();
      }
      else{
        TotalMAT_MAI_M=0;
      }

    SYN_ORD=await GET_SYN_ORD('ACC_TAX_C');
      if (SYN_ORD.isNotEmpty) {
        TotalACC_TAX_C = SYN_ORD.elementAt(0).ROW_NUM!;
        LastACC_TAX_C = SYN_ORD.elementAt(0).SOLD.toString();
      }
      else{
        TotalACC_TAX_C=0;
      }
      print(TotalACC_TAX_C);
      print('TotalACC_TAX_C');
    SYN_ORD=await GET_SYN_ORD('TAX_MOV_T');
      if (SYN_ORD.isNotEmpty) {
        TotalTAX_MOV_T = SYN_ORD.elementAt(0).ROW_NUM!;
        LastTAX_MOV_T = SYN_ORD.elementAt(0).SOLD.toString();
      }
      else{
        TotalTAX_MOV_T=0;
      }

    SYN_ORD=await GET_SYN_ORD('TAX_PER_M');
      if (SYN_ORD.isNotEmpty) {
        TotalTAX_PER_M = SYN_ORD.elementAt(0).ROW_NUM!;
        LastTAX_PER_M = SYN_ORD.elementAt(0).SOLD.toString();
      }
      else{
        TotalTAX_PER_M=0;
      }

    SYN_ORD=await GET_SYN_ORD('TAX_PER_D');
      if (SYN_ORD.isNotEmpty) {
        TotalTAX_PER_D = SYN_ORD.elementAt(0).ROW_NUM!;
        LastTAX_PER_D = SYN_ORD.elementAt(0).SOLD.toString();
      }
      else{
        TotalTAX_PER_D=0;
      }

    SYN_ORD=await GET_SYN_ORD('TAX_PER_BRA');
      if (SYN_ORD.isNotEmpty) {
        TotalTAX_PER_BRA = SYN_ORD.elementAt(0).ROW_NUM!;
        LastTAX_PER_BRA = SYN_ORD.elementAt(0).SOLD.toString();
      }
      else{
        TotalTAX_PER_BRA=0;
      }

    SYN_ORD=await GET_SYN_ORD('FAT_API_INF');
      if (SYN_ORD.isNotEmpty) {
        TotalFAT_API_INF = SYN_ORD.elementAt(0).ROW_NUM!;
        LastFAT_API_INF = SYN_ORD.elementAt(0).SOLD.toString();
      }
      else{
        TotalFAT_API_INF=0;
      }

    SYN_ORD=await GET_SYN_ORD('FAT_CSID_INF');
      if (SYN_ORD.isNotEmpty) {
        TotalFAT_CSID_INF = SYN_ORD.elementAt(0).ROW_NUM!;
        LastFAT_CSID_INF = SYN_ORD.elementAt(0).SOLD.toString();
      }
      else{
        TotalFAT_CSID_INF=0;
      }

    SYN_ORD=await GET_SYN_ORD('FAT_CSID_INF_D');
      if (SYN_ORD.isNotEmpty) {
        TotalFAT_CSID_INF_D = SYN_ORD.elementAt(0).ROW_NUM!;
        LastFAT_CSID_INF_D = SYN_ORD.elementAt(0).SOLD.toString();
      }
      else{
        TotalFAT_CSID_INF_D=0;
      }

    SYN_ORD=await GET_SYN_ORD('FAT_CSID_SEQ');
      if (SYN_ORD.isNotEmpty) {
        TotalFAT_CSID_SEQ = SYN_ORD.elementAt(0).ROW_NUM!;
        LastFAT_CSID_SEQ = SYN_ORD.elementAt(0).SOLD.toString();
      }
      else{
        TotalFAT_CSID_SEQ=0;
      }

    SYN_ORD=await GET_SYN_ORD('FAT_CSID_ST');
      if (SYN_ORD.isNotEmpty) {
        TotalFAT_CSID_ST = SYN_ORD.elementAt(0).ROW_NUM!;
        LastFAT_CSID_ST = SYN_ORD.elementAt(0).SOLD.toString();
      }
      else{
        TotalFAT_CSID_ST=0;
      }

    SYN_ORD=await GET_SYN_ORD('FAT_INV_SND');
      if (SYN_ORD.isNotEmpty) {
        TotalFAT_INV_SND= SYN_ORD.elementAt(0).ROW_NUM!;
        LastFAT_INV_SND = SYN_ORD.elementAt(0).SOLD.toString();
      }
      else{
        TotalFAT_INV_SND=0;
      }

    SYN_ORD=await GET_SYN_ORD('FAT_INV_SND_ARC');
      if (SYN_ORD.isNotEmpty) {
        TotalFAT_INV_SND_ARC = SYN_ORD.elementAt(0).ROW_NUM!;
        LastFAT_INV_SND_ARC = SYN_ORD.elementAt(0).SOLD.toString();
      }
      else{
        TotalFAT_INV_SND_ARC=0;
      }

    SYN_ORD=await GET_SYN_ORD('FAT_QUE');
      if (SYN_ORD.isNotEmpty) {
        TotalFAT_QUE = SYN_ORD.elementAt(0).ROW_NUM!;
        LastFAT_QUE = SYN_ORD.elementAt(0).SOLD.toString();
      }
      else{
        TotalFAT_QUE=0;
      }


    SYN_ORD=await GET_SYN_ORD('COU_TYP_M');
      if (SYN_ORD.isNotEmpty) {
        TotalCOU_TYP_M = SYN_ORD.elementAt(0).ROW_NUM!;
        LastCOU_TYP_M = SYN_ORD.elementAt(0).SOLD.toString();
      }
      else{
        TotalCOU_TYP_M=0;
      }


    SYN_ORD=await GET_SYN_ORD('COU_INF_M');
      if (SYN_ORD.isNotEmpty) {
        TotalCOU_INF_M = SYN_ORD.elementAt(0).ROW_NUM!;
        LastCOU_INF_M = SYN_ORD.elementAt(0).SOLD.toString();
      }
      else{
        TotalCOU_INF_M=0;
      }

    SYN_ORD=await GET_SYN_ORD('COU_POI_L');
      if (SYN_ORD.isNotEmpty) {
        TotalCOU_POI_L = SYN_ORD.elementAt(0).ROW_NUM!;
        LastCOU_POI_L = SYN_ORD.elementAt(0).SOLD.toString();
      }
      else{
        TotalCOU_POI_L=0;
      }

    SYN_ORD=await GET_SYN_ORD('COU_USR');
      if (SYN_ORD.isNotEmpty) {
        TotalCOU_USR = SYN_ORD.elementAt(0).ROW_NUM!;
        LastCOU_USR = SYN_ORD.elementAt(0).SOLD.toString();
      }
      else{
        TotalCOU_USR=0;
      }

    SYN_ORD=await GET_SYN_ORD('COU_RED');
      if (SYN_ORD.isNotEmpty) {
        TotalCOU_RED = SYN_ORD.elementAt(0).ROW_NUM!;
        LastCOU_RED = SYN_ORD.elementAt(0).SOLD.toString();
      }
      else{
        TotalCOU_RED=0;
      }

   SYN_ORD=await GET_SYN_ORD('SYN_SET');
   if (SYN_ORD.isNotEmpty) {
     TotalSYN_SET = SYN_ORD.elementAt(0).ROW_NUM!;
     LastSYN_SET = SYN_ORD.elementAt(0).SOLD.toString();
   }
   else{
     TotalSYN_SET=0;
   }

   SYN_ORD=await GET_SYN_ORD('SYN_OFF_M2');
   if (SYN_ORD.isNotEmpty) {
     TotalSYN_OFF_M2 = SYN_ORD.elementAt(0).ROW_NUM!;
     LastSYN_OFF_M2 = SYN_ORD.elementAt(0).SOLD.toString();
   }
   else{
     TotalSYN_OFF_M2=0;
   }

   SYN_ORD=await GET_SYN_ORD('SYN_OFF_M');
   if (SYN_ORD.isNotEmpty) {
     TotalSYN_OFF_M = SYN_ORD.elementAt(0).ROW_NUM!;
     LastSYN_OFF_M = SYN_ORD.elementAt(0).SOLD.toString();
   }
   else{
     TotalSYN_OFF_M=0;
   }

   SYN_ORD=await GET_SYN_ORD('ECO_VAR');
   if (SYN_ORD.isNotEmpty) {
     TotalECO_VAR = SYN_ORD.elementAt(0).ROW_NUM!;
     LastECO_VAR = SYN_ORD.elementAt(0).SOLD.toString();
   }
   else{
     TotalECO_VAR=0;
   }

   SYN_ORD=await GET_SYN_ORD('ECO_ACC');
   if (SYN_ORD.isNotEmpty) {
     TotalECO_ACC = SYN_ORD.elementAt(0).ROW_NUM!;
     LastECO_ACC = SYN_ORD.elementAt(0).SOLD.toString();
   }
   else{
     TotalECO_ACC=0;
   }

   SYN_ORD=await GET_SYN_ORD('ECO_MSG_ACC');
   if (SYN_ORD.isNotEmpty) {
     TotalECO_MSG_ACC = SYN_ORD.elementAt(0).ROW_NUM!;
     LastECO_MSG_ACC = SYN_ORD.elementAt(0).SOLD.toString();
   }
   else{
     TotalECO_MSG_ACC=0;
   }

     update();
    await DeleteALLDataTMP('SYN_ORD');
  }

  // داله ينم استعداها في حال فشل التزامن جلب عدد البيانات التي انحفظت بالجدزل ومن تم تغيير ارقام من الى
  GetLastNum() async {
    F_ROW_V=await Get_Count_Rec(TypeGet=='BIL_MOV_K' && STMID=='INVC'? 'STO_MOV_K' :TypeGet);
      T_ROW_V = F_ROW_V + ROW_NUM;
      F_ROW_V += 1;
      update();
  }

  // ---1--- دالة التحقق من الربط مع السيرفر
  Socket_IP() async {
    Socket.connect(LoginController().IP,int.parse(LoginController().PORT), timeout: const Duration(seconds: 7)).then((socket) async {
      print("Success");
      round = true;
      awaitforstart();
      socket.destroy();
      INSERT_SYN_LOG(TAB_N, 'StringSuccesCheck'.tr, 'D');
    }).catchError((error) {
      INSERT_SYN_LOG(TAB_N, '!تأكد من اعدادات الربط او من ان السرفر شغال', 'D');
      CheckSync(false);
      checkclick = false;
      loadingone.value = false;
      LoginController().Timer_Strat == 1 ?
      Fluttertoast.showToast(
          msg: 'StringCHK_Con'.tr,
          toastLength: Toast.LENGTH_LONG,
          textColor: Colors.white,
          backgroundColor: Colors.redAccent) :
      {
        service.invoke("stopService"),
        print('stopService')};
      print("Exception on Socket " + error.toString());
    });
  }

  // داله لجلب اخر تاريخ مزامنه
  GetLastSyncDate_P() async {
    var Config=await GetLastSyncDate();
      if (Config.isNotEmpty) {
        CHIKE_ALL = Config.elementAt(0).CHIKE_ALL!;
        LastSyncDate = Config.elementAt(0).LastSyncDate.toString();
        update();
      }
      else {
        LastSyncDate = '';
      }
    update();
  }

  AwaitFuncBasicData() async {
    for (var i = 0; i <= 40; i++) {
      await Future.delayed(const Duration(milliseconds: 500));
      {
        if (CheckSync == true) {
          if (arrlength != -1) {
            StartWorkingBasicData(TAB_N);
            i = 40;
            arrlength=-1;
            print(i);
          }
          else {
            print(i);
            if (i == 40) {
              LoginController().Timer_Strat == 1 ?
              Fluttertoast.showToast(
                  msg: "StringFailedtoConnect".tr,
                  textColor: Colors.white,
                  backgroundColor: Colors.red) : false;
              checkclick = false;
              loadingone.value = false;
              modifyMap(MyGUIDMap, VarGUIDMap.toString().toUpperCase(), 2, 'update');
              update();
            }
            update();
          }
        }
        else {
          i = 40;
          update();
        }
      }
    }
  }

  Future<void> StartWorkingBasicData(String TypeGet)   async {
    arrlength=-1;
    if (TypeGet=='GEN_VAR') {
     await Update_TABLE_ALL('GEN_VAR');
      TAB_N = "SYN_ORD";
      FROM_DATE = LastSyncDate;
      ApiProvider().GetAllSYN_ORD();
      await AwaitFuncBasicData();
    }
    else if (TypeGet=='SYN_ORD') {
      if (SyncOneTable == true) {
        await UpdateSYN_ORD_ALL();
       await GET_ROW_NUM();}
      else{
        await GET_GEN_VAR_P();
        await Update_TABLE_ALL('SYN_ORD_TMP');
        await INSERT_SYN_LOG(TAB_N, '${SLIN}', 'D');
        if (CheckSync == true) {
          //في حال كانت اول مره يزامن يتم عمل اضافه للجدول
          if ((CHIKE_ALL == 0 && TypeSync == 1) || CheckALLSYN_ORD == 0) {
            await DeleteSYN_ORD();
            await Future.delayed(const Duration(seconds: 2));
            await SaveALLData('SYN_ORD');
          }
          else {
            //في حال لم تكن اول مره يزامن يتم عمل تعديل للعدد بالجدول
            await UpdateSYN_ORD_ALL();
          }
          await Future.delayed(const Duration(seconds: 3));
          await GET_ROW_NUM();
          await GetCountNum();
          await Future.delayed(const Duration(seconds: 5));
          if (TotalSYS_VAR != -1) {
            CheckSync(true) ? await CheckNumberLoad() : false;
          }
          else {
            CheckSync(false);
          }
        }
        update();
      }
    }
  }

  // ---2--- دالة  في حالة المزامنه اول نره يتم SYN_ORD وGEN_VAR
  // مالم يتم الذهاب لدالة جلب اخر رقم بالجدول لتفير القيم ومن ثم الذهاب للخطوه 3
  awaitforstart() async {
    if (CheckSync(true) && round == true) {
      if (TypeCheckSync == 1 && SyncOneTable == false) {
        await GetCountSYN_ORD();
        await DeleteGEN_VAR_ALL();
        TAB_N = "GEN_VAR";
        await ApiProvider().GetAllGEN_VAR();
        await AwaitFuncBasicData();
      }
      else {
        if (SyncOneTable == true) {
          await StartWorkingBasicData('GEN_VAR');
        }
        await Future.delayed(const Duration(seconds: 4));
        await GetLastNum();
        await Future.delayed(const Duration(seconds: 3));
        CheckSync == true ? await CheckNumberLoad() : false;
      }
    }
  }

  // ---3--- دالة لتحديد رقم التزامن اي في اي جدول حاليا يزامن
  CheckNumberLoad() async {
    if (TypeCheckSync == 1 && SyncOneTable == false) {
      TypeSync = 1;
      await loadFromApi();
      checkclick = true;
      update();
    }
    else {
      // GET_ROW_NUM();
      TypeSync = TypeCheckSync;
      CheckSync(true);
      checkclick = true;
      await  loadFromApi();
      update();
    }
  }

  var VarGUIDMap;

  Map MyGUIDMap = Map<String, int>();

  void modifyMap(Map myMap, String key, dynamic value, String operation) {
    switch (operation) {
      case 'add':
        myMap[key] = value;
        // MyGUIDMap[key] = value;
        break;
      case 'update':
        if (myMap.containsKey(key)) {
          myMap[key] = value;
          // MyGUIDMap[key] = value;
        }
        break;
      case 'delete':
        myMap.remove(key);
        break;
      default:
        print('Invalid operation');
    }
  }


  //  ---4--- دالة تستدعي الدوال الي في apiProvider ومن ثم يتم الذهاب للخطوه 5
  loadFromApi() async {
    var apiProvider = ApiProvider();
    var uuid = Uuid();
    VarGUIDMap = uuid.v4();
     modifyMap(MyGUIDMap, VarGUIDMap.toString().toUpperCase(), 1, 'add');
    //متغيرات النظام
    if (TypeSync == 1 && round == true) {
      TypeCheckSync = TypeSync;
      TAB_N = "SYS_VAR";
      TypeGet = 'SYS_VAR';
      if (TotalSYS_VAR != 0 && (CHIKE_ALL == 1 || TotalSYS_VAR != CheckSys_Var)) {
        FROM_DATE = LastSYS_VAR.value;
        await  apiProvider.GetAllSYS_VAR(VarGUIDMap.toString().toUpperCase());
        await awaitFunc();
      }
      else {
        await startWorking();
      }
      update();
    }
    //بيانات اخرى
    else if (TypeSync == 2 && round == true) {
      TAB_N = "SYN_DAT";
      TypeCheckSync = TypeSync;
      TypeGet = 'SYN_DAT';
      if (TotalSYN_DAT != 0 && CHIKE_ALL != 0 && ClickAllOrLastTime != true) {
        FROM_DATE = LastSYN_DAT;
        apiProvider.GetAllSYN_DAT(VarGUIDMap.toString().toUpperCase());
        awaitFunc();
      }
      else {
        startWorking();
      }
      update();
    }
    //  بيانات المنشاه
    else if (TypeSync == 3 && round == true) {
      TAB_N = "SYS_OWN";
      TypeCheckSync = TypeSync;
      TypeGet = 'SYS_OWN';
      if (TotalSYS_OWN != 0 &&
          (CHIKE_ALL == 1 || TotalSYS_OWN != CheckSys_Won)) {
        F_ROW_V = 0;
        T_ROW_V = 0;
        FROM_DATE = LastSys_Won;
        apiProvider.GetAllSYS_OWN(VarGUIDMap.toString().toUpperCase());
        awaitFunc();
      }
      else {
        startWorking();
      }
      update();
    }
    // // بيانات الفروع
    else if (TypeSync == 4 && round == true) {
      TAB_N = "BRA_INF";
      TypeCheckSync = TypeSync;
      TypeGet = 'BRA_INF';
      if (TotalBRA_INF != 0 && (CHIKE_ALL == 1 || TotalBRA_INF != CheckBra_Inf)) {
        F_ROW_V = 0;
        T_ROW_V = 0;
        FROM_DATE = LastBra_Inf;
        apiProvider.GetAllBRA_INF(VarGUIDMap.toString().toUpperCase());
        awaitFunc();
      }
      else {
        startWorking();
      }
      update();
    }
    //المستخدمين
    else if (TypeSync == 5 && round == true) {
      TAB_N = "SYS_USR";
      TypeCheckSync = TypeSync;
      TypeGet = 'SYS_USR';
      if (TotalSYS_USR != 0 &&
          (CHIKE_ALL == 1 || TotalSYS_USR != CheckSys_Usr)) {
        FROM_DATE = LastSys_Usr;
        apiProvider.GetAllSYS_USR(VarGUIDMap.toString().toUpperCase());
        awaitFunc();
      }
      else {
        startWorking();
      }
      update();
    }
    // صلاحيات المستخدمين
    else if (TypeSync == 6 && round == true) {
      TypeCheckSync = TypeSync;
      TAB_N = "USR_PRI";
      TypeGet = 'USR_PRI';
      if (TotalUSR_PRI != 0 &&
          (CHIKE_ALL == 1 || TotalUSR_PRI != CheckUsr_Pri)) {
        FROM_DATE = LastUsr_Pri;
        apiProvider.GetAllUSR_PRI(VarGUIDMap.toString().toUpperCase());
        awaitFunc();
      }
      else {
        startWorking();
      }
      update();
    }
    //صلاحية الفروع
    else if (TypeSync == 7 && round == true) {
      TypeCheckSync = TypeSync;
      TAB_N = "SYS_USR_B";
      TypeGet = 'SYS_USR_B';
      if (TotalSYS_USR_B != 0 &&
          (CHIKE_ALL == 1 || TotalSYS_USR_B != CheckSys_Usr_B)) {
        FROM_DATE = LastSys_Usr_B;
        apiProvider.GetAllSYS_USR_B(VarGUIDMap.toString().toUpperCase());
        awaitFunc();
      }
      else {
        startWorking();
      }
      update();
    }
    //بيانات المخازن
    else if (TypeSync == 8 && round == true) {
      TAB_N = "STO_INF";
      TypeCheckSync = TypeSync;
      TypeGet = 'STO_INF';
      if (TotalSTO_INF != 0 &&
          (CHIKE_ALL == 1 || TotalSTO_INF != CheckSto_Inf)) {
        FROM_DATE = LastSto_Inf;
        apiProvider.GetAllSto_Inf(VarGUIDMap.toString().toUpperCase());
        awaitFunc();
      } else {
        startWorking();
      }
      update();
    }
    //صلاحيات المخازن
    else if (TypeSync == 9 && round == true) {
      TAB_N = "STO_USR";
      TypeGet = 'STO_USR';
      TypeCheckSync = TypeSync;
      if (TotalSTO_USR != 0 &&
          (CHIKE_ALL == 1 || TotalSTO_USR != CheckSto_Usr)) {
        FROM_DATE = LastSto_Inf;
        apiProvider.GetAllSTO_USR(VarGUIDMap.toString().toUpperCase());
        awaitFunc();
      }
      else {
        startWorking();
      }
      update();
    }
    //بيانات المجموعات
    else if (TypeSync == 10 && round == true) {
      TAB_N = "MAT_GRO";
      TypeCheckSync = TypeSync;
      TypeGet = 'MAT_GRO';
      if (TotalMAT_GRO != 0 &&
          (CHIKE_ALL == 1 || TotalMAT_GRO != CheckMat_Gro)) {
        FROM_DATE = LastMat_Gro;
        apiProvider.GetAllMAT_GRO(VarGUIDMap.toString().toUpperCase());
        awaitFunc();
      } else {
        startWorking();
      }
      update();
    }
    // //صلاحيات المجموعات
    else if (TypeSync == 11 && round == true) {
      TAB_N = "GRO_USR";
      TypeCheckSync = TypeSync;
      TypeGet = 'GRO_USR';
      if (TotalGRO_USR != 0 &&
          (CHIKE_ALL == 1 || TotalGRO_USR != CheckGro_Usr)) {
        FROM_DATE = LastGro_Usr;
        apiProvider.GetAllGRO_USR(VarGUIDMap.toString().toUpperCase());
        awaitFunc();
      } else {
        startWorking();
      }
      update();
    }
    // //بيانات الوحدات
    else if (TypeSync == 12 && round == true) {
      TAB_N = "MAT_UNI";
      TypeCheckSync = TypeSync;
      TypeGet = 'MAT_UNI';
      if (TotalMAT_UNI != 0 &&
          (CHIKE_ALL == 1 || TotalMAT_UNI != CheckMat_Uni)) {
        FROM_DATE = LastMat_Uni;
        apiProvider.GetAllMAT_UNI(VarGUIDMap.toString().toUpperCase());
        awaitFunc();
      } else {
        startWorking();
      }
      update();
    }
    // //بيانات الاصناف
    else if (TypeSync == 13 && round == true) {
      TAB_N = "MAT_INF";
      TypeCheckSync = TypeSync;
      TypeGet = 'MAT_INF';
      if (TotalMAT_INF != 0 && (CHIKE_ALL == 1 || TotalMAT_INF != CheckMat_Inf)) {
        FROM_DATE = LastMat_Inf;
        apiProvider.GetAllMAT_INF(VarGUIDMap.toString().toUpperCase());
        awaitFunc();
      }
      else {
        startWorking();
      }
      update();
    }
    // //ترتيب وحدات الاصناف
    else if (TypeSync == 14 && round == true) {
      TAB_N = "MAT_UNI_C";
      TypeCheckSync = TypeSync;
      TypeGet = 'MAT_UNI_C';
      if (TotalMAT_UNI_C != 0 &&
          (CHIKE_ALL == 1 || TotalMAT_UNI_C != CheckMat_Uni_C)) {
        FROM_DATE = LastMat_Uni_C;
        apiProvider.GetAllMAT_UNI_C(VarGUIDMap.toString().toUpperCase());
        awaitFunc();
      } else {
        startWorking();
      }
      update();
    }
    //الباركود
    else if (TypeSync == 15 && round == true) {
      TAB_N = "MAT_UNI_B";
      TypeCheckSync = TypeSync;
      TypeGet = 'MAT_UNI_B';
      if (TotalMAT_UNI_B != 0 &&
          (CHIKE_ALL == 1 || TotalMAT_UNI_B != CheckMat_Uni_B)) {
        FROM_DATE = LastMat_Uni_B;
        apiProvider.GetAllMAT_UNI_B(VarGUIDMap.toString().toUpperCase());
        awaitFunc();
      } else {
        startWorking();
      }
      update();
    }
    //تسعيره الاصناف
    else if (TypeSync == 16 && round == true) {
      TAB_N = "MAT_PRI";
      TypeCheckSync = TypeSync;
      TypeGet = 'MAT_PRI';
      if (TotalMAT_PRI != 0 &&
          (CHIKE_ALL == 1 || TotalMAT_PRI != CheckMat_Pri)) {
        FROM_DATE = LastMat_Pri;
        apiProvider.GetAllMAT_PRI(VarGUIDMap.toString().toUpperCase());
        awaitFunc();
      } else {
        startWorking();
      }
      update();
    }
    // //بيانات اضافيه للصنف
    else if (TypeSync == 17 && round == true) {
      TAB_N = STMID=='EORD'?"MAT_INF_D":"MAT_INF_A";
      TypeCheckSync = TypeSync;
      TypeGet = 'MAT_INF_A';
      if (TotalMAT_INF_A != 0 && (CHIKE_ALL == 1 || TotalMAT_INF_A != CheckMat_Inf_A)) {
        FROM_DATE = LastMat_Inf_A;
        STMID=='EORD'?apiProvider.GetAllMAT_INF_D(VarGUIDMap.toString().toUpperCase()):
        apiProvider.GetAllMAT_INF_A(VarGUIDMap.toString().toUpperCase());
        awaitFunc();
      } else {
        startWorking();
      }
      update();
    }
    // الاصناف التابعة/المرتبطة.
    else if (TypeSync == 18 && round == true) {
      TAB_N = "MAT_FOL";
      TypeCheckSync = TypeSync;
      TypeGet = 'MAT_FOL';
      if ((TotalMAT_FOL != 0 )&&
          (CHIKE_ALL == 1 || TotalMAT_FOL != CheckMAT_FOL)) {
        FROM_DATE = LastMAT_FOL;
        apiProvider.GetAllMAT_FOL(VarGUIDMap.toString().toUpperCase());
        awaitFunc();
      } else {
        startWorking();
      }
      update();
    }
    // مواصفات/ملاحظات سريعة للاصناف
    else if (TypeSync == 19 && round == true) {
      TAB_N = "MAT_DES_M";
      TypeCheckSync = TypeSync;
      TypeGet = 'MAT_DES_M';
      if (TotalMAT_DES_M != 0 && (CHIKE_ALL == 1 || TotalMAT_DES_M != CheckMAT_DES_M)) {
        FROM_DATE = LastMAT_DES_M;
        apiProvider.GetAllMAT_DES_M(VarGUIDMap.toString().toUpperCase());
        awaitFunc();
      } else {
        startWorking();
      }
      update();
    }
    // مواصفات/ملاحظات سريعة للاصناف-فرعي
    else if (TypeSync == 20 && round == true) {
      TAB_N = "MAT_DES_D";
      TypeCheckSync = TypeSync;
      TypeGet = 'MAT_DES_D';
      if (TotalMAT_DES_D!= 0 &&
          (CHIKE_ALL == 1 || TotalMAT_DES_D != CheckMAT_DES_D)) {
        FROM_DATE = LastMAT_DES_D;
        apiProvider.GetAllMAT_DES_D(VarGUIDMap.toString().toUpperCase());
        awaitFunc();
      } else {
        startWorking();
      }
      update();
    }
    // //الكميات المخزنية
    else if (TypeSync == 21 && round == true) {
      // TotalALLSYS_CUR = TotalSYS_CUR_BET + TotalSYS_CUR + TotalSYS_CUR_D;
      TAB_N = "STO_NUM";
      TypeCheckSync = TypeSync;
      TypeGet = 'STO_NUM';
      if (TotalSTO_NUM != 0 && (CHIKE_ALL == 1 || TotalSTO_NUM != CheckSto_Num)) {
        FROM_DATE = LastSto_Num;
        apiProvider.GetAllSTO_NUM(VarGUIDMap.toString().toUpperCase());
        awaitFunc();
      }
      else {
        startWorking();
      }
      update();
    }
    //العملات
    else if (TypeSync == 22 && round == true) {
      TAB_N = "SYS_CUR";
      TypeCheckSync = TypeSync;
      TypeGet = 'SYS_CUR';
      if (TotalSYS_CUR != 0 &&
          (CHIKE_ALL == 1 || TotalSYS_CUR != CheckSYS_CUR)) {
        FROM_DATE = LastSYS_CUR;
        apiProvider.GetAllSYS_CUR(VarGUIDMap.toString().toUpperCase());
        awaitFunc();
      }
      else {
        startWorking();
      }
      update();
    }
    //العملات -فرعي
    else if (TypeSync == 23 && round == true) {
      TAB_N = "SYS_CUR_D";
      TypeCheckSync = TypeSync;
      TypeGet = 'SYS_CUR_D';
      if (TotalSYS_CUR_D != 0 &&
          (CHIKE_ALL == 1 || TotalSYS_CUR_D != CheckSYS_CUR_D)) {
        FROM_DATE = LastSYS_CUR_D;
        apiProvider.GetAllSYS_CUR_D(VarGUIDMap.toString().toUpperCase());
        awaitFunc();
      }
      else {
        startWorking();
      }
      update();
    }
    //التحويل بين العملات
    else if (TypeSync == 24 && round == true) {
      TAB_N = "SYS_CUR_BET";
      TypeCheckSync = TypeSync;
      TypeGet = 'SYS_CUR_BET';
      if (TotalSYS_CUR_BET != 0 &&
          (CHIKE_ALL == 1 || TotalSYS_CUR_BET != CheckSYS_CUR_BET)) {
        FROM_DATE = LastSYS_CUR_BET;
        apiProvider.GetAllSYS_CUR_BET(VarGUIDMap.toString().toUpperCase());
        awaitFunc();
      }
      else {
        startWorking();
      }
      update();
    }
    //أنواع الدفع
    else if (TypeSync == 25 && round == true) {
      TAB_N = "PAY_KIN";
      TypeCheckSync = TypeSync;
      TypeGet = 'PAY_KIN';
      if (TotalPAY_KIN != 0 &&
          (CHIKE_ALL == 1 || TotalPAY_KIN != CheckPAY_KIN)) {
        FROM_DATE = LastPAY_KIN;
        apiProvider.GetAllPAY_KIN(VarGUIDMap.toString().toUpperCase());
        awaitFunc();
      } else {
        startWorking();
      }
    }
    //اعدادات الصناديق
    else if (TypeSync == 26 && round == true) {
      TAB_N = "ACC_CAS";
      TypeCheckSync = TypeSync;
      TypeGet = 'ACC_CAS';
      if (TotalACC_CAS != 0 &&
          (CHIKE_ALL == 1 || TotalACC_CAS != CheckACC_CAS)) {
        FROM_DATE = LastACC_CAS;
        apiProvider.GetAllACC_CAS(VarGUIDMap.toString().toUpperCase());
        awaitFunc();
      } else {
        startWorking();
      }
    }
    //صلاحيات الصناديق
    else if (TypeSync == 27 && round == true) {
      TAB_N = "ACC_CAS_U";
      TypeCheckSync = TypeSync;
      TypeGet = 'ACC_CAS_U';
      if (TotalACC_CAS_U != 0 &&
          (CHIKE_ALL == 1 || TotalACC_CAS_U != CheckACC_CAS_U)) {
        FROM_DATE = LastACC_CAS_U;
        apiProvider.GetAllACC_CAS_U(VarGUIDMap.toString().toUpperCase());
        awaitFunc();
      } else {
        startWorking();
      }
    }
    //بطائق الائتمان
    else if (TypeSync == 28 && round == true) {
      TAB_N = "BIL_CRE_C";
      TypeCheckSync = TypeSync;
      TypeGet = 'BIL_CRE_C';
      if (TotalBIL_CRE_C != 0 &&
          (CHIKE_ALL == 1 || TotalBIL_CRE_C != CheckBIL_CRE_C)) {
        FROM_DATE = LastBIL_CRE_C;
        apiProvider.GetAllBIL_CRE_C(VarGUIDMap.toString().toUpperCase());
        awaitFunc();
      } else {
        startWorking();
      }
      update();
    }
    //البنوك
    else if (TypeSync == 29 && round == true) {
      // TotalALLBIL_CUS_T = TotalACC_TAX_T + TotalBIL_CUS_T;
      TAB_N = "ACC_BAN";
      TypeCheckSync = TypeSync;
      TypeGet = 'ACC_BAN';
      if (TotalACC_BAN != 0 &&
          (CHIKE_ALL == 1 || TotalACC_BAN != CheckACC_BAN)) {
        FROM_DATE = LastACC_BAN;
        apiProvider.GetAllACC_BAN(VarGUIDMap.toString().toUpperCase());
        awaitFunc();
      } else {
        startWorking();
      }
      update();
    }
    //انواع العملاء
    else if (TypeSync == 30 && round == true) {
      TAB_N = "BIL_CUS_T";
      TypeCheckSync = TypeSync;
      TypeGet = 'BIL_CUS_T';
      if (TotalBIL_CUS_T != 0 &&
          (CHIKE_ALL == 1 || TotalBIL_CUS_T != CheckBIL_CUS_T)) {
        FROM_DATE = LastBIL_CUS_T;
        apiProvider.GetAllBIL_CUS_T(VarGUIDMap.toString().toUpperCase());
        awaitFunc();
      }
      else {
        startWorking();
      }
      update();
    }
    //العملاء
    else if (TypeSync == 31 && round == true) {
      TAB_N = "BIL_CUS";
      TypeCheckSync = TypeSync;
      TypeGet = 'BIL_CUS';
      if (TotalBIL_CUS != 0 &&
          (CHIKE_ALL == 1 || TotalBIL_CUS != CheckBIL_CUS)) {
        FROM_DATE = LastBIL_CUS;
        apiProvider.GetAllBIL_CUS(VarGUIDMap.toString().toUpperCase());
        awaitFunc();
      }
      else {
        startWorking();
      }
      update();
    }
    //العملاء الفرعيين
    else if (TypeSync == 32 && round == true) {
      TAB_N = "BIF_CUS_D";
      TypeGet = 'BIF_CUS_D';
      TypeCheckSync = TypeSync;
      if (TotalBIF_CUS_D != 0 &&
          (CHIKE_ALL == 1 || TotalBIF_CUS_D != CheckBIF_CUS_D)) {
        FROM_DATE = LastBIF_CUS_D;
        apiProvider.GetAllBIF_CUS_D(VarGUIDMap.toString().toUpperCase());
        awaitFunc();
      } else {
        startWorking();
      }
      update();
    }
    //بيانات المندوبين
    else if (TypeSync == 33 && round == true) {
      TAB_N = "BIL_DIS";
      TypeCheckSync = TypeSync;
      TypeGet = 'BIL_DIS';
      if (TotalBIL_DIS != 0 &&
          (CHIKE_ALL == 1 || TotalBIL_DIS != CheckBIL_DIS)) {
        FROM_DATE = LastBIL_DIS;
        apiProvider.GetAllBIL_DIS(VarGUIDMap.toString().toUpperCase());
        awaitFunc();
      }
      else {
        startWorking();
      }
      update();
    }
    //الموردين
    else if (TypeSync == 34 && round == true) {
      TAB_N = "BIL_IMP";
      TypeGet = 'BIL_IMP';
      TypeCheckSync = TypeSync;
      if (TotalBIL_IMP != 0 &&
          (CHIKE_ALL == 1 || TotalBIL_IMP != CheckBIL_IMP)) {
        FROM_DATE = LastBIL_IMP;
        apiProvider.GetAllBIL_IMP(VarGUIDMap.toString().toUpperCase());
        awaitFunc();
      } else {
        startWorking();
      }
      update();
    }
    //الدول
    else if (TypeSync == 35 && round == true) {
      TAB_N = "COU_WRD";
      TypeCheckSync = TypeSync;
      TypeGet = 'COU_WRD';
      if (TotalCOU_WRD != 0 &&
          (CHIKE_ALL == 1 || TotalCOU_WRD != CheckCOU_WRD)) {
        FROM_DATE = LastCOU_WRD;
        apiProvider.GetAllCOU_WRD(VarGUIDMap.toString().toUpperCase());
        awaitFunc();
      } else {
        startWorking();
      }
      update();
    }
    //المدن
    else if (TypeSync == 36 && round == true) {
      TAB_N = "COU_TOW";
      TypeGet = 'COU_TOW';
      TypeCheckSync = TypeSync;
      if (TotalCOU_TOW != 0 &&
          (CHIKE_ALL == 1 || TotalCOU_TOW != CheckCOU_TOW)) {
        FROM_DATE = LastCOU_TOW;
        apiProvider.GetAllCOU_TOW(VarGUIDMap.toString().toUpperCase());
        awaitFunc();
      }
      else {
        startWorking();
      }
      update();
    }
    //المناطق
    else if (TypeSync == 37 && round == true) {
      TAB_N = "BIL_ARE";
      TypeCheckSync = TypeSync;
      TypeGet = 'BIL_ARE';
      if (TotalBIL_ARE != 0 &&
          (CHIKE_ALL == 1 || TotalBIL_ARE != CheckBil_Are)) {
        FROM_DATE = LastBil_Are;
        apiProvider.GetAllBIL_ARE(VarGUIDMap.toString().toUpperCase());
        awaitFunc();
      }
      else {
        startWorking();
      }
      update();
    }
    //الدليل المحاسبي
    else if (TypeSync == 38 && round == true) {
      TAB_N = "ACC_ACC";
      TypeCheckSync = TypeSync;
      TypeGet = 'ACC_ACC';
      if (TotalACC_ACC != 0 &&
          (CHIKE_ALL == 1 || TotalACC_ACC != CheckACC_ACC)) {
        FROM_DATE = LastACC_ACC;
        apiProvider.GetAllACC_ACC(VarGUIDMap.toString().toUpperCase());
        awaitFunc();
      } else {
        startWorking();
      }
      update();
    }
    //المستخدمين والحسابات.....
    else if (TypeSync == 39 && round == true) {
      TAB_N = "ACC_USR";
      TypeCheckSync = TypeSync;
      TypeGet = 'ACC_USR';
      if (TotalACC_USR != 0 && (CHIKE_ALL == 1 || TotalACC_USR !=
          CheckACC_USR)) {
        // if(CountFor==0){
        //   F_ROW_V=CheckACC_USR;
        //   T_ROW_V=F_ROW_V+150;
        // }
        FROM_DATE = LastACC_USR;
        apiProvider.GetAllACC_USR(VarGUIDMap.toString().toUpperCase());
        awaitFunc();
      } else {
        startWorking();
      }
      update();
    }
    //فترات العمل
    else if (TypeSync == 40 && round == true) {
      TypeGet = 'SHI_INF';
      TAB_N = "SHI_INF";
      TypeCheckSync = TypeSync;
      if (TotalSHI_INF != 0 && (CHIKE_ALL == 1 ||
          TotalSHI_INF != CheckSHI_INF)) {
        FROM_DATE = LastSHI_INF;
        await Future.delayed(const Duration(seconds: 3));
        {
          apiProvider.GetAllSHI_INF(VarGUIDMap.toString().toUpperCase());
          awaitFunc();
        }
      } else {
        startWorking();
      }
      update();
    }
    //ربط فترات العمل بالنقاط والمستخدمين
    else if (TypeSync == 41 && round == true) {
      TAB_N = "SHI_USR";
      TypeCheckSync = TypeSync;
      TypeGet = 'SHI_USR';
      if (TotalSHI_USR != 0 && (CHIKE_ALL == 1 ||
          TotalSHI_USR != CheckSHI_USR)) {
        FROM_DATE = LastSHI_USR;
        apiProvider.GetAllSHI_USR(VarGUIDMap.toString().toUpperCase());
        awaitFunc();
      } else {
        startWorking();
      }
      update();
    }
    //نقاط البيع
    else if (TypeSync == 42 && round == true) {
      TAB_N = "BIL_POI";
      TypeCheckSync = TypeSync;
      TypeGet = 'BIL_POI';
      await Future.delayed(const Duration(seconds: 2));
      if (TotalBIL_POI != 0 &&
          (CHIKE_ALL == 1 || TotalBIL_POI != CheckBIL_POI)) {
        FROM_DATE = LastBIL_POI;
        apiProvider.GetAllBIL_POI(VarGUIDMap.toString().toUpperCase());
        awaitFunc();
      }
      else {
        startWorking();
      }
      update();
    }
    //ربط نقاط البيع بالمستخدمين
    else if (TypeSync == 43 && round == true) {
      TAB_N = "BIL_POI_U";
      TypeCheckSync = TypeSync;
      TypeGet = 'BIL_POI_U';
      await Future.delayed(const Duration(seconds: 1));
      if (TotalBIL_POI_U != 0 &&
          (CHIKE_ALL == 1 || TotalBIL_POI_U != CheckBIL_POI_U)) {
        FROM_DATE = LastBIL_POI_U;
        apiProvider.GetAllBIL_POI_U(VarGUIDMap.toString().toUpperCase());
        awaitFunc();
      } else {
        startWorking();
      }
      update();
    }
    //نسب التخفيض للموظفين
    else if (TypeSync == 44 && round == true) {
      TAB_N = "BIL_USR_D";
      TypeCheckSync = TypeSync;
      TypeGet = 'BIL_USR_D';
      if (TotalBIL_USR_D != 0 &&
          (CHIKE_ALL == 1 || TotalBIL_USR_D != CheckBIL_USR_D)) {
        FROM_DATE = LastBIL_USR_D;
        apiProvider.GetAllBIL_USR_D(VarGUIDMap.toString().toUpperCase());
        awaitFunc();
      } else {
        startWorking();
      }
      update();
    }
    //مراكز التكلفه
    else if (TypeSync == 45 && round == true) {
      TAB_N = "ACC_COS";
      TypeCheckSync = TypeSync;
      TypeGet = 'ACC_COS';
      await Future.delayed(const Duration(seconds: 2));
      if (TotalACC_COS != 0 &&
          (CHIKE_ALL == 1 || TotalACC_COS != CheckACC_COS)) {
        FROM_DATE = LastACC_COS;
        apiProvider.GetAllACC_COS(VarGUIDMap.toString().toUpperCase());
        awaitFunc();
      } else {
        startWorking();
      }
      update();
    }
    //المستخدمين ومراكز التكلفه
    else if (TypeSync == 46 && round == true) {
      TAB_N = "COS_USR";
      TypeGet = 'COS_USR';
      TypeCheckSync = TypeSync;
      await Future.delayed(const Duration(seconds: 1));
      if (TotalCOS_USR != 0 &&
          (CHIKE_ALL == 1 || TotalCOS_USR != CheckCOS_USR)) {
        FROM_DATE = LastCOS_USR;
        apiProvider.GetAllCOS_USR(VarGUIDMap.toString().toUpperCase());
        awaitFunc();
      } else {
        startWorking();
      }
      update();
    }
    // //  الترقيم
    // else if (TypeSync == 44 && round == true) {
    //   TAB_N = "SYS_REF";
    //   TypeCheckSync = TypeSync;
    //   TypeGet = 'SYS_REF';
    //   // if(TotalSYS_REF!=0){
    //   //   FROM_DATE=LastSYS_REF;
    //   //   apiProvider.GetAllSYS_REF();
    //   //   awaitFunc(TotalSYS_REF);
    //   // }else{
    //   startWorking();
    //   // }
    //   update();
    // }
    // تذييل المستندات

    else if (TypeSync == 47 && round == true) {
      TAB_N = "SYS_DOC_D";
      TypeCheckSync = TypeSync;
      TypeGet = 'SYS_DOC_D';
      if (TotalSYS_DOC_D != 0 &&
          (CHIKE_ALL == 1 || TotalSYS_DOC_D != CheckSys_Doc)) {
        FROM_DATE = LastSys_Doc;
        await Future.delayed(const Duration(seconds: 3));
        apiProvider.GetAllSYS_DOC_D(VarGUIDMap.toString().toUpperCase());
        awaitFunc();
      } else {
        startWorking();
      }
      update();
    }

    else if (TypeSync == 48 && round == true) {
      TAB_N = "BRA_YEA";
      TypeCheckSync = TypeSync;
      TypeGet = 'BRA_YEA';
      if (TotalBRA_YEA != 0 &&
          (CHIKE_ALL == 1 || TotalBRA_YEA != CheckBRA_YEA)) {
        FROM_DATE = LastBRA_YEA;
        apiProvider.GetAllBra_Yea(VarGUIDMap.toString().toUpperCase());
        awaitFunc();
      } else {
        startWorking();
      }
      update();
    }
    //الشاشات
    else if (TypeSync == 49 && round == true) {
      TAB_N = "SYS_SCR";
      TypeCheckSync = TypeSync;
      TypeGet = 'SYS_SCR';
      await Future.delayed(const Duration(seconds: 2));
      if (TotalSYS_SCR != 0 &&
          (CHIKE_ALL == 1 || TotalSYS_SCR != CheckSYS_SCR)) {
        FROM_DATE = LastSYS_SCR;
        apiProvider.GetAllSYS_SCR(VarGUIDMap.toString().toUpperCase());
        awaitFunc();
      } else {
        startWorking();
      }
      update();
    }
    //اعدادت امزاع الحركات
    else if (TypeSync == 50 && round == true) {
      TAB_N = STMID=='INVC'?'STO_MOV_K':'BIL_MOV_K';
      print(TAB_N);
      print('TAB_N');
      TypeCheckSync = TypeSync;
      TypeGet = 'BIL_MOV_K';
      if (TotalBIL_MOV_K != 0 && (CHIKE_ALL == 1 || TotalBIL_MOV_K != CheckBIL_MOV_K)) {
        FROM_DATE = LastBIL_MOV_K;
        STMID=='INVC'?
        apiProvider.GetAllSTO_MOV_K(VarGUIDMap.toString().toUpperCase()):
        apiProvider.GetAllBIL_MOV_K(VarGUIDMap.toString().toUpperCase());
        awaitFunc();
      } else {
        startWorking();
      }
      update();
    }
    //اعداد انواع القيود
    else if (TypeSync == 51 && round == true) {
      TAB_N = "ACC_MOV_K";
      TypeCheckSync = TypeSync;
      TypeGet = 'ACC_MOV_K';
      if (TotalACC_MOV_K != 0 &&
          (CHIKE_ALL == 1 || TotalACC_MOV_K != CheckACC_MOV_K)) {
        FROM_DATE = LastACC_MOV_K;
        apiProvider.GetAllACC_MOV_K(VarGUIDMap.toString().toUpperCase());
        awaitFunc();
      } else {
        startWorking();
      }
      update();
    }
    //التصنيف الضريبي
    else if (TypeSync == 52 && round == true) {
      TAB_N = "ACC_TAX_T";
      TypeCheckSync = TypeSync;
      TypeGet = 'ACC_TAX_T';
      if (TotalACC_TAX_T != 0 &&
          (CHIKE_ALL == 1 || TotalACC_TAX_T != CheckACC_TAX_T)) {
        FROM_DATE = LastACC_TAX_T;
        apiProvider.GetAllACC_TAX_T(VarGUIDMap.toString().toUpperCase());
        awaitFunc();
      }
      else {
        startWorking();
      }
      update();
    }

    //التصنيف الضريبي.
    else if (TypeSync == 53 && round == true) {
      TotalALLTAX_MOV_T = TotalTAX_MOV_T + TotalACC_TAX_C;
      TAB_N = "TAX_MOV_T";
      TypeCheckSync = TypeSync;
      TypeGet = 'TAX_MOV_T';
      if (TotalTAX_MOV_T != 0 &&
          (CHIKE_ALL == 1 || TotalTAX_MOV_T != CheckTAX_MOV_T)) {
        FROM_DATE = LastTAX_MOV_T;
        apiProvider.GetAllTAX_MOV_T(VarGUIDMap.toString().toUpperCase());
        awaitFunc();
      }
      else {
        startWorking();
      }
      update();
    }
    //التصنيف الضريبي للحساب
    else if (TypeSync == 54 && round == true) {
      TAB_N = "ACC_TAX_C";
      TypeCheckSync = TypeSync;
      TypeGet = 'ACC_TAX_C';
      if (TotalACC_TAX_C != 0 &&
          (CHIKE_ALL == 1 || TotalACC_TAX_C != CheckACC_TAX_C)) {
        FROM_DATE = LastACC_TAX_C;
        apiProvider.GetAllACC_TAX_C(VarGUIDMap.toString().toUpperCase());
        awaitFunc();
      }
      else {
        startWorking();
      }
      update();
    }
    //انواع الضرائب
    else if (TypeSync == 55 && round == true) {
      TotalALLTAX_TYP = TotalTAX_TYP + TotalTAX_TYP_SYS;
      TAB_N = "TAX_TYP";
      TypeCheckSync = TypeSync;
      TypeGet = 'TAX_TYP';
      if (TotalTAX_TYP != 0 &&
          (CHIKE_ALL == 1 || TotalTAX_TYP != CheckTAX_TYP)) {
        FROM_DATE = LastTAX_TYP;
        apiProvider.GetAllTAX_TYP(VarGUIDMap.toString().toUpperCase());
        awaitFunc();
      }
      else {
        startWorking();
      }
      update();
    }
    //انواع الضرائب -فرعي
    else if (TypeSync == 56 && round == true) {
      TAB_N = "TAX_TYP_SYS";
      TypeCheckSync = TypeSync;
      TypeGet = 'TAX_TYP_SYS';
      if (TotalTAX_TYP_SYS != 0 &&
          (CHIKE_ALL == 1 || TotalTAX_TYP_SYS != CheckTAX_TYP_SYS)) {
        FROM_DATE = LastTAX_TYP_SYS;
        apiProvider.GetAllTAX_TYP_SYS(VarGUIDMap.toString().toUpperCase());
        awaitFunc();
      }
      else {
        startWorking();
      }
      update();
    }
    // ربط الفروع مع انزاع الضرائب
    else if (TypeSync == 57 && round == true) {
      TAB_N = "TAX_TYP_BRA";
      TypeCheckSync = TypeSync;
      TypeGet = 'TAX_TYP_BRA';
      if (TotalTAX_TYP_BRA != 0 &&
          (CHIKE_ALL == 1 || TotalTAX_TYP_BRA != CheckTAX_TYP_BRA)) {
        FROM_DATE = LastTAX_TYP_BRA;
        apiProvider.GetAllTAX_TYP_BRA(VarGUIDMap.toString().toUpperCase());
        awaitFunc();
      }
      else {
        startWorking();
      }
      update();
    }
    //اعداد الفترات الضريبيه
    else if (TypeSync == 58 && round == true) {
      TotalALLTAX_PER_M = TotalTAX_PER_M + TotalTAX_PER_D;
      TAB_N = "TAX_PER_M";
      TypeCheckSync = TypeSync;
      TypeGet = 'TAX_PER_M';
      if (TotalTAX_PER_M != 0 &&
          (CHIKE_ALL == 1 || TotalTAX_PER_M != CheckTAX_PER_M)) {
        FROM_DATE = LastTAX_PER_M;
        apiProvider.GetAllTAX_PER_M(VarGUIDMap.toString().toUpperCase());
        awaitFunc();
      }
      else {
        startWorking();
      }
      update();
    }
    //الفترات الضريبه- فرعي
    else if (TypeSync == 59 && round == true) {
      TAB_N = "TAX_PER_D";
      TypeCheckSync = TypeSync;
      TypeGet = 'TAX_PER_D';
      if (TotalTAX_PER_D != 0 &&
          (CHIKE_ALL == 1 || TotalTAX_PER_D != CheckTAX_PER_D)) {
        FROM_DATE = LastTAX_PER_D;
        apiProvider.GetAllTAX_PER_D(VarGUIDMap.toString().toUpperCase());
        awaitFunc();
      }
      else {
        startWorking();
      }
      update();
    }
    //ربط الفترات الضريبيه بالفروع
    else if (TypeSync == 60 && round == true) {
      TAB_N = "TAX_PER_BRA";
      TypeCheckSync = TypeSync;
      TypeGet = 'TAX_PER_BRA';
      if (TotalTAX_PER_BRA != 0 &&
          (CHIKE_ALL == 1 || TotalTAX_PER_BRA != CheckTAX_PER_BRA)) {
        FROM_DATE = LastTAX_PER_BRA;
        apiProvider.GetAllTAX_PER_BRA(VarGUIDMap.toString().toUpperCase());
        awaitFunc();
      }
      else {
        startWorking();
      }
      update();
    }
    //المواقع الضريبيه
    else if (TypeSync == 61 && round == true) {
      TotalALLTAX_LOC = TotalTAX_LOC + TotalTAX_LOC_SYS;
      TAB_N = "TAX_LOC";
      TypeCheckSync = TypeSync;
      TypeGet = 'TAX_LOC';
      if (TotalTAX_LOC != 0 &&
          (CHIKE_ALL == 1 || TotalTAX_LOC != CheckTAX_LOC)) {
        FROM_DATE = LastTAX_LOC;
        apiProvider.GetAllTAX_LOC(VarGUIDMap.toString().toUpperCase());
        awaitFunc();
      }
      else {
        startWorking();
      }
      update();
    }
    //المواقع الضريبيه -فرعي
    else if (TypeSync == 62 && round == true) {
      TAB_N = "TAX_LOC_SYS";
      TypeCheckSync = TypeSync;
      TypeGet = 'TAX_LOC_SYS';
      if (TotalTAX_LOC_SYS != 0 &&
          (CHIKE_ALL == 1 || TotalTAX_LOC_SYS != CheckTAX_LOC_SYS)) {
        FROM_DATE = LastTAX_LOC_SYS;
        apiProvider.GetAllTAX_LOC_SYS(VarGUIDMap.toString().toUpperCase());
        awaitFunc();
      }
      else {
        startWorking();
      }
      update();
    }

    //الترميزات الضريبيه
    else if (TypeSync == 63 && round == true) {
      TotalALLTAX_COD = TotalTAX_COD + TotalTAX_COD_SYS + TotalTAX_COD_SYS_D;
      TAB_N = "TAX_COD";
      TypeCheckSync = TypeSync;
      TypeGet = 'TAX_COD';
      if (TotalTAX_COD != 0 &&
          (CHIKE_ALL == 1 || TotalTAX_COD != CheckTAX_COD)) {
        FROM_DATE = LastTAX_COD;
        apiProvider.GetAllTAX_COD(VarGUIDMap.toString().toUpperCase());
        awaitFunc();
      }
      else {
        startWorking();
      }
      update();
    }
    //الترميزات الضريبيه -فرعي
    else if (TypeSync == 64 && round == true) {
      TAB_N = "TAX_COD_SYS";
      TypeCheckSync = TypeSync;
      TypeGet = 'TAX_COD_SYS';
      if (TotalTAX_COD_SYS != 0 &&
          (CHIKE_ALL == 1 || TotalTAX_COD_SYS != CheckTAX_COD_SYS)) {
        FROM_DATE = LastTAX_COD_SYS;
        apiProvider.GetAllTAX_COD_SYS(VarGUIDMap.toString().toUpperCase());
        awaitFunc();
      }
      else {
        startWorking();
      }
      update();
    }
    //2الترميزات الضريبيه -فرعي
    else if (TypeSync == 65 && round == true) {
      TAB_N = "TAX_COD_SYS_D";
      TypeCheckSync = TypeSync;
      TypeGet = 'TAX_COD_SYS_D';
      if (TotalTAX_COD_SYS_D != 0 &&
          (CHIKE_ALL == 1 || TotalTAX_COD_SYS_D != CheckTAX_COD_SYS_D)) {
        FROM_DATE = LastTAX_COD_SYS_D;
        apiProvider.GetAllTAX_COD_SYS_D(VarGUIDMap.toString().toUpperCase());
        awaitFunc();
      }
      else {
        startWorking();
      }
      update();
    }
    //ربط الضريبيه بالانظمه
    else if (TypeSync == 66 && round == true) {
      TotalALLTAX_SYS = TotalTAX_SYS + TotalTAX_SYS_D;
      TAB_N = "TAX_SYS";
      TypeCheckSync = TypeSync;
      TypeGet = 'TAX_SYS';
      if (TotalTAX_SYS != 0 &&
          (CHIKE_ALL == 1 || TotalTAX_SYS != CheckTAX_SYS)) {
        FROM_DATE = LastTAX_SYS;
        apiProvider.GetAllTAX_SYS(VarGUIDMap.toString().toUpperCase());
        awaitFunc();
      }
      else {
        startWorking();
      }
      update();
    }
    //
    else if (TypeSync == 67 && round == true) {
      TAB_N = "TAX_SYS_D";
      TypeCheckSync = TypeSync;
      TypeGet = 'TAX_SYS_D';
      if (TotalTAX_SYS_D != 0 && (CHIKE_ALL == 1 || TotalTAX_SYS_D != CheckTAX_SYS_D)) {
        FROM_DATE = LastTAX_SYS_D;
        apiProvider.GetAllTAX_SYS_D(VarGUIDMap.toString().toUpperCase());
        awaitFunc();
      }
      else {
        startWorking();
      }
      update();
    }
    //ربط الضريبه والفروع
    else if (TypeSync == 68 && round == true) {
      TAB_N = "TAX_SYS_BRA";
      TypeCheckSync = TypeSync;
      TypeGet = 'TAX_SYS_BRA';

      if (TotalTAX_SYS_BRA != 0 && (CHIKE_ALL == 1 || TotalTAX_SYS_BRA != CheckTAX_SYS_BRA)) {
        FROM_DATE = LastTAX_SYS_BRA;
        apiProvider.GetAllTAX_SYS_BRA(VarGUIDMap.toString().toUpperCase());
        awaitFunc();
      }
      else {
        startWorking();
      }
      update();
    }
    //متغيرات الضرائب
    else if (TypeSync == 69 && round == true) {
      TotalALLTAX_VAR = TotalTAX_VAR + TotalTAX_VAR_D;
      TAB_N = "TAX_VAR";
      TypeCheckSync = TypeSync;
      TypeGet = 'TAX_VAR';
      if (TotalTAX_VAR != 0 &&
          (CHIKE_ALL == 1 || TotalTAX_VAR != CheckTAX_VAR)) {
        FROM_DATE = LastTAX_VAR;
        apiProvider.GetAllTAX_VAR(VarGUIDMap.toString().toUpperCase());
        awaitFunc();
      }
      else {
        startWorking();
      }
      update();
    }
    //
    else if (TypeSync == 70 && round == true) {
      TAB_N = "TAX_VAR_D";
      TypeCheckSync = TypeSync;
      TypeGet = 'TAX_VAR_D';
      if (TotalTAX_VAR_D != 0 &&
          (CHIKE_ALL == 1 || TotalTAX_VAR_D != CheckTAX_VAR_D)) {
        FROM_DATE = LastTAX_VAR_D;
        apiProvider.GetAllTAX_VAR_D(VarGUIDMap.toString().toUpperCase());
        awaitFunc();
      }
      else {
        startWorking();
      }
      update();
    }
    //التصنيفات الضريبيه
    else if (TypeSync == 71 && round == true) {
      TAB_N = "TAX_LIN";
      TypeCheckSync = TypeSync;
      TypeGet = 'TAX_LIN';
      if (TotalTAX_LIN != 0 &&
          (CHIKE_ALL == 1 || TotalTAX_LIN != CheckTAX_LIN)) {
        FROM_DATE = LastTAX_LIN;
        apiProvider.GetAllTAX_LIN(VarGUIDMap.toString().toUpperCase());
        awaitFunc();
      }
      else {
        startWorking();
      }
      update();
    }
    //بيانات المعرفات الاساسيه
    else if (TypeSync == 72 && round == true) {
      TAB_N = "IDE_TYP";
      TypeCheckSync = TypeSync;
      TypeGet = 'IDE_TYP';
      if (TotalIDE_TYP != 0 &&
          (CHIKE_ALL == 1 || TotalIDE_TYP != CheckIDE_TYP)) {
        FROM_DATE = LastIDE_TYP;
        apiProvider.GetAllIDE_TYP(VarGUIDMap.toString().toUpperCase());
        awaitFunc();
      }
      else {
        startWorking();
      }
      update();
    }
    //
    else if (TypeSync == 73 && round == true) {
      TAB_N = "IDE_LIN";
      TypeCheckSync = TypeSync;
      TypeGet = 'IDE_LIN';
      await Future.delayed(const Duration(milliseconds: 500));
      if (TotalIDE_LIN != 0 &&
          (CHIKE_ALL == 1 || TotalIDE_LIN != CheckIDE_LIN)) {
        FROM_DATE = LastIDE_LIN;
        apiProvider.GetAllIDE_LIN(VarGUIDMap.toString().toUpperCase());
        awaitFunc();
      }
      else {
        startWorking();
      }
      update();
    }
    //مؤشرات/انواع ضريبيه للحركات
    else if (TypeSync == 74 && round == true) {
      TAB_N = "TAX_MOV_SIN";
      TypeCheckSync = TypeSync;
      TypeGet = 'TAX_MOV_SIN';
      if (TotalTAX_MOV_SIN != 0 &&
          (CHIKE_ALL == 1 || TotalTAX_MOV_SIN != CheckTAX_MOV_SIN)) {
        FROM_DATE = LastTAX_MOV_SIN;
        apiProvider.GetAllTAX_MOV_SIN(VarGUIDMap.toString().toUpperCase());
        awaitFunc();
      }
      else {
        startWorking();
      }
      update();
    }
    //ربط الرموز والاكواد الخاصه بالضريبه مع البيانات
    else if (TypeSync == 75 && round == true) {
      TAB_N = "TAX_TBL_LNK";
      TypeCheckSync = TypeSync;
      TypeGet = 'TAX_TBL_LNK';
      if (TotalTAX_TBL_LNK != 0 &&
          (CHIKE_ALL == 1 || TotalTAX_TBL_LNK != CheckTAX_TBL_LNK)) {
        FROM_DATE = LastTAX_TBL_LNK;
        apiProvider.GetAllTAX_TBL_LNK(VarGUIDMap.toString().toUpperCase());
        awaitFunc();
      }
      else {
        startWorking();
      }
      update();
    }
    //بيانات الربط مع الــAPI
    else if (TypeSync == 76 && round == true) {
      TAB_N = "FAT_API_INF";
      TypeCheckSync = TypeSync;
      TypeGet = 'FAT_API_INF';
      if (TotalFAT_API_INF != 0 &&
          (CHIKE_ALL == 1 || TotalFAT_API_INF != CheckFAT_API_INF)) {
        FROM_DATE = LastFAT_API_INF;
        apiProvider.GetAllFAT_API_INF(VarGUIDMap.toString().toUpperCase());
        awaitFunc();
      }
      else {
        startWorking();
      }
      update();
    }

    //الوحدات/الاجهزة التفنية_فرعي
    else if (TypeSync == 77 && round == true) {
      TAB_N = "FAT_CSID_INF_D";
      TypeCheckSync = TypeSync;
      TypeGet = 'FAT_CSID_INF_D';
      if (TotalFAT_CSID_INF_D != 0 && (CHIKE_ALL == 1 || TotalFAT_CSID_INF_D != CheckFAT_CSID_INF_D)) {
        FROM_DATE = LastFAT_CSID_INF_D;
        apiProvider.GetAllFAT_CSID_INF_D(VarGUIDMap.toString().toUpperCase());
        awaitFunc();
      }
      else {
        startWorking();
      }
      update();
    }

    //الوحدات/الاجهزة التفنية
    else if (TypeSync == 78 && round == true) {
      TotalALLFAT_CSID_INF = TotalFAT_CSID_INF + TotalFAT_CSID_INF_D;
      TAB_N = "FAT_CSID_INF";
      TypeCheckSync = TypeSync;
      TypeGet = 'FAT_CSID_INF';
      if (TotalFAT_CSID_INF != 0 && (CHIKE_ALL == 1 || TotalFAT_CSID_INF != CheckFAT_CSID_INF)) {
        FROM_DATE = LastFAT_CSID_INF;
        apiProvider.GetAllFAT_CSID_INF(VarGUIDMap.toString().toUpperCase());
        awaitFunc();
      }
      else {
        startWorking();
      }
      update();
    }

    //مسلسل الترقيم للوحدات/الاجهزه التقنية
    else if (TypeSync == 79 && round == true) {
      TAB_N = "FAT_CSID_SEQ";
      TypeCheckSync = TypeSync;
      TypeGet = 'FAT_CSID_SEQ';
      if (TotalFAT_CSID_SEQ != 0 && (CHIKE_ALL == 1 || TotalFAT_CSID_SEQ != CheckFAT_CSID_SEQ)) {
        FROM_DATE = LastFAT_CSID_SEQ;
        apiProvider.GetAllFAT_CSID_SEQ(VarGUIDMap.toString().toUpperCase());
        awaitFunc();
      }
      else {
        startWorking();
      }
      update();
    }
    //حالة الوحدات/الاجهزه التقنية
    else if (TypeSync == 80 && round == true) {
      TAB_N = "FAT_CSID_ST";
      TypeCheckSync = TypeSync;
      TypeGet = 'FAT_CSID_ST';
      if (TotalFAT_CSID_ST != 0 &&
          (CHIKE_ALL == 1 || TotalFAT_CSID_ST != CheckFAT_CSID_ST)) {
        FROM_DATE = LastFAT_CSID_ST;
        apiProvider.GetAllFAT_CSID_ST(VarGUIDMap.toString().toUpperCase());
        awaitFunc();
      }
      else {
        startWorking();
      }
      update();
    }
    //FAT_QUE
    else if (TypeSync == 81 && round == true) {
      TAB_N = "FAT_QUE";
      TypeCheckSync = TypeSync;
      TypeGet = 'FAT_QUE';
      if (TotalFAT_QUE != 0 && (CHIKE_ALL == 1 || TotalFAT_QUE != CheckFAT_QUE)) {
        FROM_DATE = LastFAT_QUE;
        apiProvider.GetAllFAT_QUE(VarGUIDMap.toString().toUpperCase());
        awaitFunc();
      }
      else {
        startWorking();
      }
      update();
    }
    //انواع العروض والتخفيضات
    else if (TypeSync == 82 && round == true) {
      TAB_N = "MAT_DIS_T";
      TypeCheckSync = TypeSync;
      TypeGet = 'MAT_DIS_T';
      if (TotalMAT_DIS_T != 0 &&
          (CHIKE_ALL == 1 || TotalMAT_DIS_T != CheckMAT_DIS_T)) {
        FROM_DATE = LastMAT_DIS_T;
        apiProvider.GetAllMAT_DIS_T(VarGUIDMap.toString().toUpperCase());
        awaitFunc();
      }
      else {
        startWorking();
      }
      update();
    }
    //طبيعة العروض والتخفيضات
    else if (TypeSync == 83 && round == true) {
      TAB_N = "MAT_DIS_K";
      TypeCheckSync = TypeSync;
      TypeGet = 'MAT_DIS_K';
      if (TotalMAT_DIS_K != 0 &&
          (CHIKE_ALL == 1 || TotalMAT_DIS_K != CheckMAT_DIS_K)) {
        FROM_DATE = LastMAT_DIS_T;
        apiProvider.GetAllMAT_DIS_K(VarGUIDMap.toString().toUpperCase());
        awaitFunc();
      }
      else {
        startWorking();
      }
      update();
    }
    //العروض والتخقيضات -رئيسي
    else if (TypeSync == 84 && round == true) {
      TAB_N = "MAT_DIS_M";
      TypeCheckSync = TypeSync;
      TypeGet = 'MAT_DIS_M';
      if (TotalMAT_DIS_M != 0 && (CHIKE_ALL == 1 || TotalMAT_DIS_M != CheckMAT_DIS_M)) {
        FROM_DATE = LastMAT_DIS_M;
        apiProvider.GetAllMAT_DIS_M(VarGUIDMap.toString().toUpperCase());
        awaitFunc();
      }
      else {
        startWorking();
      }
      update();
    }
    //العروض والتخقيضات -فرعي 1
    else if (TypeSync == 85 && round == true) {
      TAB_N = "MAT_DIS_D";
      TypeCheckSync = TypeSync;
      TypeGet = 'MAT_DIS_D';
      if (TotalMAT_DIS_D != 0 &&
          (CHIKE_ALL == 1 || TotalMAT_DIS_D != CheckMAT_DIS_D)) {
        FROM_DATE = LastMAT_DIS_D;
        apiProvider.GetAllMAT_DIS_D(VarGUIDMap.toString().toUpperCase());
        awaitFunc();
      }
      else {
        startWorking();
      }
      update();
    }
    //العروض والتخقيضات -فرعي 2
    else if (TypeSync == 86 && round == true) {
      TAB_N = "MAT_DIS_F";
      TypeCheckSync = TypeSync;
      TypeGet = 'MAT_DIS_F';
      if (TotalMAT_DIS_F != 0 && (CHIKE_ALL == 1 || TotalMAT_DIS_F != CheckMAT_DIS_F)) {
        FROM_DATE = LastMAT_DIS_F;
        apiProvider.GetAllMAT_DIS_F(VarGUIDMap.toString().toUpperCase());
        awaitFunc();
      }
      else {
        startWorking();
      }
      update();
    }
    //ربط العروض مع المجموعات الرئيسيه
    else if (TypeSync == 87 && round == true) {
      TAB_N = "MAT_DIS_L";
      TypeCheckSync = TypeSync;
      TypeGet = 'MAT_DIS_L';
      if (TotalMAT_DIS_L != 0 &&
          (CHIKE_ALL == 1 || TotalMAT_DIS_L != CheckMAT_DIS_L)) {
        FROM_DATE = LastMAT_DIS_L;
        apiProvider.GetAllMAT_DIS_L(VarGUIDMap.toString().toUpperCase());
        awaitFunc();
      }
      else {
        startWorking();
      }
      update();
    }
    //حالة العروض والتخفيضات
    else if (TypeSync == 88 && round == true) {
      TAB_N = "MAT_DIS_S";
      TypeCheckSync = TypeSync;
      TypeGet = 'MAT_DIS_S';
      if (TotalMAT_DIS_S != 0 &&
          (CHIKE_ALL == 1 || TotalMAT_DIS_S != CheckMAT_DIS_S)) {
        FROM_DATE = LastMAT_DIS_S;
        apiProvider.GetAllMAT_DIS_S(VarGUIDMap.toString().toUpperCase());
        awaitFunc();
      }
      else {
        startWorking();
      }
      update();
    }
    //المجموعات الرئيسية للعروض.
    else if (TypeSync == 89 && round == true) {
      TAB_N = "MAT_MAI_M";
      TypeCheckSync = TypeSync;
      TypeGet = 'MAT_MAI_M';
      if (TotalMAT_MAI_M != 0 &&
          (CHIKE_ALL == 1 || TotalMAT_MAI_M != CheckMAT_MAI_M)) {
        FROM_DATE = LastMAT_MAI_M;
        apiProvider.GetAllMAT_MAI_M(VarGUIDMap.toString().toUpperCase());
        awaitFunc();
      }
      else {
        startWorking();
      }
      update();
    }
    //الاقسام
    else if (TypeSync == 90 && round == true) {
      TAB_N = "RES_SEC";
      TypeCheckSync = TypeSync;
      TypeGet = 'RES_SEC';
      if (TotalRES_SEC != 0 &&
          (CHIKE_ALL == 1 || TotalRES_SEC != CheckRES_SEC)) {
        FROM_DATE = LastRES_SEC;
        apiProvider.GetAllRES_SEC(VarGUIDMap.toString().toUpperCase());
        awaitFunc();
      }
      else {
        startWorking();
      }
      update();
    }
    //الطاولات
    else if (TypeSync == 91 && round == true) {
      TAB_N = "RES_TAB";
      TypeCheckSync = TypeSync;
      TypeGet = 'RES_TAB';
      if (TotalRES_TAB != 0 &&
          (CHIKE_ALL == 1 || TotalRES_TAB != CheckRES_TAB)) {
        FROM_DATE = LastRES_TAB;
        apiProvider.GetAllRES_TAB(VarGUIDMap.toString().toUpperCase());
        awaitFunc();
      }
      else {
        startWorking();
      }
      update();
    }
    //موظفي الخدمه
    else if (TypeSync == 92 && round == true) {
      TAB_N = "RES_EMP";
      TypeCheckSync = TypeSync;
      TypeGet = 'RES_EMP';
      if (TotalRES_EMP != 0 &&
          (CHIKE_ALL == 1 || TotalRES_EMP != CheckRES_EMP)) {
        FROM_DATE = LastRES_EMP;
        apiProvider.GetAllRES_EMP(VarGUIDMap.toString().toUpperCase());
        awaitFunc();
      }
      else {
        startWorking();
      }
      update();
    }
    //أنواع الوقود
    else if (TypeSync == 93 && round == true) {
      TAB_N = "COU_TYP_M";
      TypeCheckSync = TypeSync;
      TypeGet = 'COU_TYP_M';
      if (TotalCOU_TYP_M != 0 &&
          (CHIKE_ALL == 1 || TotalCOU_TYP_M != CheckCOU_TYP_M)) {
        FROM_DATE = LastCOU_TYP_M;
        apiProvider.GetAllCOU_TYP_M(VarGUIDMap.toString().toUpperCase());
        awaitFunc();
      }
      else {
        startWorking();
      }
      update();
    }
    //اعدادات بيانات العدادات
    else if (TypeSync == 94 && round == true) {
      TAB_N = "COU_INF_M";
      TypeCheckSync = TypeSync;
      TypeGet = 'COU_INF_M';
      if (TotalCOU_INF_M != 0 &&
          (CHIKE_ALL == 1 || TotalCOU_INF_M != CheckCOU_INF_M)) {
        FROM_DATE = LastCOU_INF_M;
        apiProvider.GetAllCOU_INF_M(VarGUIDMap.toString().toUpperCase());
        awaitFunc();
      }
      else {
        startWorking();
      }
      update();
    }
    //ربط العدادات بالنقاط
    else if (TypeSync == 95 && round == true) {
      TAB_N = "COU_POI_L";
      TypeCheckSync = TypeSync;
      TypeGet = 'COU_POI_L';
      if (TotalCOU_POI_L != 0 && (CHIKE_ALL == 1 || TotalCOU_POI_L != CheckCOU_POI_L)) {
        FROM_DATE = LastCOU_POI_L;
        apiProvider.GetAllCOU_POI_L(VarGUIDMap.toString().toUpperCase());
        awaitFunc();
      }
      else {
        startWorking();
      }
      update();
    }
    //صلاحيه المستخدمين بالعدادات
    else if (TypeSync == 96 && round == true) {
      TAB_N = "COU_USR";
      TypeCheckSync = TypeSync;
      TypeGet = 'COU_USR';
      if (TotalCOU_USR != 0 && (CHIKE_ALL == 1 || TotalCOU_USR != CheckCOU_USR)) {
        FROM_DATE = LastCOU_USR;
        apiProvider.GetAllCOU_USR(VarGUIDMap.toString().toUpperCase());
        awaitFunc();
      }
      else {
        startWorking();
      }
      update();
    }
    ////القراءات
    else if (TypeSync == 97 && round == true) {
      TAB_N = "COU_RED";
      TypeCheckSync = TypeSync;
      TypeGet = 'COU_RED';
      if (TotalCOU_RED != 0 && (CHIKE_ALL == 1 || TotalCOU_RED != CheckCOU_RED)) {
        FROM_DATE = LastCOU_RED;
        apiProvider.GetAllCOU_RED(VarGUIDMap.toString().toUpperCase());
        awaitFunc();
      }
      else {
        startWorking();
      }
      update();
    }
    //مجموعات الفواتير
    else if (TypeSync == 98 && round == true) {
      TAB_N = "BIF_GRO";
      TypeCheckSync = TypeSync;
      TypeGet = 'BIF_GRO';
      if (TotalBIF_GRO != 0 &&
          (CHIKE_ALL == 1 || TotalBIF_GRO != CheckBIF_GRO)) {
        FROM_DATE = LastBIF_GRO;
        apiProvider.GetAllBIF_GRO(VarGUIDMap.toString().toUpperCase());
        awaitFunc();
      }
      else {
        startWorking();
      }
      update();
    }
    //مجموعات الفواتير2
    else if (TypeSync == 99 && round == true) {
      TAB_N = "BIF_GRO2";
      TypeCheckSync = TypeSync;
      TypeGet = 'BIF_GRO2';
      if (TotalBIF_GRO2 != 0 &&
          (CHIKE_ALL == 1 || TotalBIF_GRO2 != CheckBIF_GRO2)) {
        FROM_DATE = LastBIF_GRO2;
        apiProvider.GetAllBIF_GRO2(VarGUIDMap.toString().toUpperCase());
        awaitFunc();
      }
      else {
        startWorking();
      }
      update();
    }

    //اعدادات الربط/التزامن-السحابي
    else if (TypeSync == 100 && round == true) {
      TAB_N = "SYN_SET";
      TypeCheckSync = TypeSync;
      TypeGet = 'SYN_SET';
      if (TotalSYN_SET != 0 &&
          (CHIKE_ALL == 1 || TotalSYN_SET != CheckSYN_SET)) {
        FROM_DATE = LastSYN_SET;
        apiProvider.GetAllSYN_SET(VarGUIDMap.toString().toUpperCase());
        awaitFunc();
      }
      else {
        startWorking();
      }
      update();
    }
    else if (TypeSync == 101 && round == true) {
      TAB_N = "SYN_OFF_M";
      TypeCheckSync = TypeSync;
      TypeGet = 'SYN_OFF_M';
      if (TotalSYN_OFF_M!= 0 &&
          (CHIKE_ALL == 1 || TotalSYN_OFF_M != CheckSYN_OFF_M)) {
        FROM_DATE = LastSYN_OFF_M;
        apiProvider.GetAllSYN_OFF_M(VarGUIDMap.toString().toUpperCase());
        awaitFunc();
      }
      else {
        startWorking();
      }
      update();
    }
    else if (TypeSync == 102 && round == true) {
      TAB_N = "SYN_OFF_M2";
      TypeCheckSync = TypeSync;
      TypeGet = 'SYN_OFF_M2';
      if (TotalSYN_OFF_M2 != 0 &&
          (CHIKE_ALL == 1 || TotalSYN_OFF_M2 != CheckSYN_OFF_M2)) {
        FROM_DATE = LastSYN_OFF_M2;
        apiProvider.GetAllSYN_OFF_M2(VarGUIDMap.toString().toUpperCase());
        awaitFunc();
      }
      else {
        startWorking();
      }
      update();
    }
    else if (TypeSync == 103 && round == true) {
      TAB_N = "ECO_VAR";
      TypeCheckSync = TypeSync;
      TypeGet = 'ECO_VAR';
      if (TotalECO_VAR != 0 &&
          (CHIKE_ALL == 1 || TotalECO_VAR != CheckECO_VAR)) {
        FROM_DATE = LastECO_VAR;
        apiProvider.GetAllECO_VAR(VarGUIDMap.toString().toUpperCase());
        awaitFunc();
      }
      else {
        startWorking();
      }
      update();
    }

    //حسابات وارقام التواصل
    else if (TypeSync == 104 && round == true) {
      TAB_N = "ECO_ACC";
      TypeCheckSync = TypeSync;
      TypeGet = 'ECO_ACC';
      if (TotalECO_ACC != 0 && (CHIKE_ALL == 1 || TotalECO_ACC != CheckECO_ACC)) {
        FROM_DATE = LastECO_ACC;
        apiProvider.GetAllECO_ACC(VarGUIDMap.toString().toUpperCase());
        awaitFunc();
      }
      else {
        startWorking();
      }
      update();
    }
    //انواع الرسائل المرتبطه بالارقام
    else if (TypeSync == 105 && round == true) {
      TAB_N = "ECO_MSG_ACC";
      TypeCheckSync = TypeSync;
      TypeGet = 'ECO_MSG_ACC';
      if (TotalECO_MSG_ACC != 0 &&
          (CHIKE_ALL == 1 || TotalECO_MSG_ACC != CheckECO_MSG_ACC)) {
        FROM_DATE = LastECO_MSG_ACC;
        apiProvider.GetAllECO_MSG_ACC(VarGUIDMap.toString().toUpperCase());
        awaitFunc();
      }
      else {
        startWorking();
      }
      update();
    }

    // ارصده الحسابات -رئيسي
    else if (TypeSync == 106 && round == true) {
      TAB_N = "BAL_ACC_M";
      TypeCheckSync = TypeSync;
      TypeGet = 'BAL_ACC_M';
      await Future.delayed(const Duration(seconds: 1));
      if (TotalBAL_ACC_M != 0 &&
          (CHIKE_ALL == 1 || TotalBAL_ACC_M != CheckBAL_ACC_M)) {
        FROM_DATE = LastBAL_ACC_M;
        apiProvider.GetAllBAL_ACC_M(VarGUIDMap.toString().toUpperCase());
        awaitFunc();
      }
      else {
        startWorking();
      }
      update();
    }
    // ارصده الحسابات-اجمالي
    else if (TypeSync == 107 && round == true) {
      TAB_N = "BAL_ACC_C";
      TypeCheckSync = TypeSync;
      TypeGet = 'BAL_ACC_C';
      if (TotalBAL_ACC_C != 0 &&
          (CHIKE_ALL == 1 || TotalBAL_ACC_C != CheckBAL_ACC_C)) {
        FROM_DATE = LastBAL_ACC_C;

        apiProvider.GetAllBAL_ACC_C(VarGUIDMap.toString().toUpperCase());
        awaitFunc();
      } else {
        startWorking();
      }
      update();
    }
    // ارصده الحسابات -فرعي
    else if (TypeSync == 108 && round == true) {
      TAB_N = "BAL_ACC_D";
      TypeCheckSync = TypeSync;
      TypeGet = 'BAL_ACC_D';
      await Future.delayed(const Duration(milliseconds: 500));
      if (TotalBAL_ACC_D != 0 &&
          (CHIKE_ALL == 1 || TotalBAL_ACC_D != CheckBAL_ACC_D)) {
        FROM_DATE = LastBAL_ACC_D;
        apiProvider.GetAllBAL_ACC_D(VarGUIDMap.toString().toUpperCase());
        awaitFunc();
      } else {
        startWorking();
      }
      update();
    }
  }

  //  ---5--- داله تشتغل مع كل داله جلب للبيانات بحيث اذا لم تصل بيانات يرجع للخطوه الاولى مالم ينتقل للخظوة 6
  awaitFunc() async {
    for (var i = 0; i <= 200; i++) {
      await Future.delayed(const Duration(milliseconds: 500));
      {
        if (CheckSync == true) {
          if (arrlength != -1) {
            await startWorking();
            i = 200;
            arrlength=-1;
            print(i);
          }
          else {
            print(i);
            if (i == 100) {
              LoginController().Timer_Strat == 1 ?
              Fluttertoast.showToast(
                  msg: "StringQualityofConnection".tr,
                  textColor: Colors.white,
                  backgroundColor: Colors.red) : false;
            }
            else if (i == 200) {
              LoginController().Timer_Strat == 1 ?
              Fluttertoast.showToast(
                  msg: "StringFailedtoConnect".tr,
                  textColor: Colors.white,
                  backgroundColor: Colors.red) : false;
              checkclick = false;
              loadingone.value = false;
              modifyMap(MyGUIDMap, VarGUIDMap.toString().toUpperCase(), 2, 'update');
              await Socket_IP();
              update();
            }
            update();
          }
        }
        else {
          i = 200;
          checkclick = false;
          loadingone.value = false;
          update();
        }
      }
    }
  }

  GetCheckDataBase() {
    Get_Count_Check('BAL_ACC_D').then((data) {
      CheckDataBase = data;
      update();
    });
  }

  AwaitCheckDataBase() async {
    for (var i = 0; i <= 100; i++) {
      GetCheckDataBase();
      await Future.delayed(const Duration(seconds: 1));
      {
        if (CheckDataBase != -1) {
          i = 100;
          EasyLoading.instance
            ..displayDuration = const Duration(milliseconds: 2000)
            ..indicatorType = EasyLoadingIndicatorType.fadingCircle
            ..loadingStyle = EasyLoadingStyle.custom
            ..indicatorSize = 45.0
            ..radius = 10.0
            ..progressColor = Colors.white
            ..backgroundColor = Colors.green
            ..indicatorColor = Colors.white
            ..textColor = Colors.white
            ..maskColor = Colors.blue.withOpacity(0.5)
            ..userInteractions = false
            ..dismissOnTap = false;
          EasyLoading.showSuccess('StringVerified'.tr);
        }
        else {
          EasyLoading.instance
            ..displayDuration = const Duration(milliseconds: 2000)
            ..indicatorType = EasyLoadingIndicatorType.fadingCircle
            ..loadingStyle = EasyLoadingStyle.custom
            ..indicatorSize = 45.0
            ..radius = 10.0
            ..progressColor = Colors.white
            ..backgroundColor = Colors.green
            ..indicatorColor = Colors.white
            ..textColor = Colors.white
            ..maskColor = Colors.blue.withOpacity(0.5)
            ..userInteractions = false
            ..dismissOnTap = false;
          EasyLoading.show(status: "${'StringVerifiedSaved'.tr}");
        }
      }
    }
  }

  GetSaveTmp(String GetTable) async {
   var data=await Get_Count_Rec(GetTable);
      if (data != 0) {
        CheckDataBaseTmp = data;
        update();
      } else {
        CheckDataBaseTmp = -1;
        update();
      }
  }

// دوال للتحقق من جدوال التمب اذا لم تنتقل البيانات الى الجدوال
  GetCheckSaveTmp(String GetTable,int total) async {
    for (var i = 0; i <= 50; i++) {
      await GetSaveTmp(GetTable);
      await Future.delayed(const Duration(milliseconds : 500));{
        if( CheckDataBaseTmp!=-1){
          print('SaveALLData12');
          i=50;
          String TableNameTmp='$GetTable''_TMP';
          update();
          await Update_TABLE_ALL(TableNameTmp);
          await DeleteALLData(GetTable,ClickAllOrLastTime);
          await SaveALLData(GetTable);
          await INSERT_SYN_LOG(GetTable,'${SLIN} $total','D');
        }
        // else if(i==10){
        //   i=10;
        // }
      }
    }
  }

  double PercentValuecount=110;

  //  ---6--- دالة تغير الارقام الموجوده بالشاشه ومن ثم ييرجع الى الخطوه 4
  Future<void> startWorking() async {
    var round;
    Map<String, dynamic> typeConfig = {
      'SYS_VAR': {
        'total': TotalSYS_VAR,
        'progress': () => SysVarProgress,
        'value': () => SysVarvalue,
        'percent': () => SysVarPercent,
        'setProgress': (v) => SysVarProgress = v,
        'setValue': (v) => SysVarvalue = v.toDouble(),
        'setPercent': (v) => SysVarPercent = v,
        'typeSyncAll': 2,
        'typeSyncOneTable': 0,
        'saveTmp': () => GetCheckSaveTmp('SYS_VAR', TotalSYS_VAR),
        'updateOrder': () => Update_SYN_ORD('SYS_VAR')
      },
      'SYN_DAT': {
        'total': TotalSYN_DAT,
        'progress': () => SYN_DATProgress,
        'value': () => SYN_DATvalue,
        'percent': () => SYN_DATPercent,
        'setProgress': (v) => SYN_DATProgress = v,
        'setValue': (v) => SYN_DATvalue = v.toDouble(),
        'setPercent': (v) => SYN_DATPercent = v,
        'typeSyncAll': 3,
        'typeSyncOneTable': 0,
        'saveTmp': () => {
          SYN_DAT_P_ROW(),
          INSERT_SYN_LOG('SYN_DAT', '${SLIN} $TotalSYN_DAT', 'D')
        },
        'updateOrder': () => Update_SYN_ORD('SYN_DAT')
      },
      'SYS_OWN': {
        'total': TotalSYS_OWN,
        'progress': () => SysWProgress,
        'value': () => SysWvalue,
        'percent': () => SysWPercent,
        'setProgress': (v) =>SysWProgress = v,
        'setValue': (v) => SysWvalue = v.toDouble(),
        'setPercent': (v) => SysWPercent = v,
        'typeSyncAll': 4,
        'typeSyncOneTable': 0,
        'saveTmp': () => GetCheckSaveTmp('SYS_OWN', TotalSYS_OWN),
        'updateOrder': () => Update_SYN_ORD('SYS_OWN')
      },
      'BRA_INF': {
        'total': TotalBRA_INF,
        'progress': () => BraProgress,
        'value': () => Bravalue,
        'percent': () => BraPercent,
        'setProgress': (v) => BraProgress = v,
        'setValue': (v) => Bravalue = v.toDouble(),
        'setPercent': (v) => BraPercent = v,
        'typeSyncAll': 5,
        'typeSyncOneTable': 0,
        'saveTmp': () => GetCheckSaveTmp('BRA_INF', TotalBRA_INF),
        'updateOrder': () => Update_SYN_ORD('BRA_INF')
      },
      'SYS_USR': {
        'total': TotalSYS_USR,
        'progress': () => SysUProgress,
        'value': () => SysUvalue,
        'percent': () => SysUPercent,
        'setProgress': (v) => SysUProgress = v,
        'setValue': (v) => SysUvalue = v.toDouble(),
        'setPercent': (v) => SysUPercent = v,
        'typeSyncAll': 6,
        'typeSyncOneTable': 0,
        'saveTmp': () => GetCheckSaveTmp('SYS_USR', TotalSYS_USR),
        'updateOrder': () => Update_SYN_ORD('SYS_USR')
      },
      'USR_PRI': {
        'total': TotalUSR_PRI,
        'progress': () => UsrPProgress,
        'value': () => UsrPvalue,
        'percent': () => UsrPPercent,
        'setProgress': (v) => UsrPProgress = v,
        'setValue': (v) => UsrPvalue = v.toDouble(),
        'setPercent': (v) => UsrPPercent = v,
        'typeSyncAll': 7,
        'typeSyncOneTable': 0,
        'saveTmp': () => GetCheckSaveTmp('USR_PRI', TotalUSR_PRI),
        'updateOrder': () => Update_SYN_ORD('USR_PRI')
      },
      'SYS_USR_B': {
        'total': TotalSYS_USR_B,
        'progress': () => SysUBProgress,
        'value': () => SysUBvalue,
        'percent': () => SysUBPercent,
        'setProgress': (v) => SysUBProgress = v,
        'setValue': (v) => SysUBvalue = v.toDouble(),
        'setPercent': (v) => SysUBPercent = v,
        'typeSyncAll': 8,
        'typeSyncOneTable': 0,
        'saveTmp': () => GetCheckSaveTmp('SYS_USR_B', TotalSYS_USR_B),
        'updateOrder': () => Update_SYN_ORD('SYS_USR_B')
      },
      'STO_INF': {
        'total': TotalSTO_INF,
        'progress': () => StoProgress,
        'value': () => Stovalue,
        'percent': () => StoPercent,
        'setProgress': (v) => StoProgress = v,
        'setValue': (v) => Stovalue = v.toDouble(),
        'setPercent': (v) => StoPercent = v,
        'typeSyncAll': 9,
        'typeSyncOneTable': 0,
        'saveTmp': () => GetCheckSaveTmp('STO_INF', TotalSTO_INF),
        'updateOrder': () => Update_SYN_ORD('STO_INF')
      },
      'STO_USR': {
        'total': TotalSTO_USR,
        'progress': () => StoUProgress,
        'value': () => StoUvalue,
        'percent': () => StoUPercent,
        'setProgress': (v) => StoUProgress = v,
        'setValue': (v) => StoUvalue = v.toDouble(),
        'setPercent': (v) => StoUPercent = v,
        'typeSyncAll': 10,
        'typeSyncOneTable': 0,
        'saveTmp': () => GetCheckSaveTmp('STO_USR', TotalSTO_USR),
        'updateOrder': () => Update_SYN_ORD('STO_USR')
      },
      'MAT_GRO': {
        'total': TotalMAT_GRO,
        'progress': () => MatGProgress,
        'value': () => MatGvalue,
        'percent': () => MatGPercent,
        'setProgress': (v) => MatGProgress = v,
        'setValue': (v) => MatGvalue = v.toDouble(),
        'setPercent': (v) => MatGPercent = v,
        'typeSyncAll': 11,
        'typeSyncOneTable': 0,
        'saveTmp': () => GetCheckSaveTmp('MAT_GRO', TotalMAT_GRO),
        'updateOrder': () => Update_SYN_ORD('MAT_GRO')
      },
      'GRO_USR': {
        'total': TotalGRO_USR,
        'progress': () => GroUProgress,
        'value': () => GroUvalue,
        'percent': () => GroUPercent,
        'setProgress': (v) => GroUProgress = v,
        'setValue': (v) => GroUvalue = v.toDouble(),
        'setPercent': (v) => GroUPercent = v,
        'typeSyncAll': 12,
        'typeSyncOneTable': 0,
        'saveTmp': () => GetCheckSaveTmp('GRO_USR', TotalGRO_USR),
        'updateOrder': () => Update_SYN_ORD('GRO_USR')
      },
      'MAT_UNI': {
        'total': TotalMAT_UNI,
        'progress': () => MatUProgress,
        'value': () => MatUvalue,
        'percent': () => MatUPercent,
        'setProgress': (v) => MatUProgress = v,
        'setValue': (v) => MatUvalue = v.toDouble(),
        'setPercent': (v) => MatUPercent = v,
        'typeSyncAll': 13,
        'typeSyncOneTable': 0,
        'saveTmp': () => GetCheckSaveTmp('MAT_UNI', TotalMAT_UNI),
        'updateOrder': () => Update_SYN_ORD('MAT_UNI')
      },
      'MAT_INF': {
        'total': TotalMAT_INF,
        'progress': () => MatIProgress,
        'value': () => MatIvalue,
        'percent': () => MatIPercent,
        'setProgress': (v) => MatIProgress = v,
        'setValue': (v) => MatIvalue = v.toDouble(),
        'setPercent': (v) => MatIPercent = v,
        'typeSyncAll': 14,
        'typeSyncOneTable': 0,
        'saveTmp': () => GetCheckSaveTmp('MAT_INF', TotalMAT_INF),
        'updateOrder': () => Update_SYN_ORD('MAT_INF')
      },
      'MAT_UNI_C': {
        'total': TotalMAT_UNI_C,
        'progress': () => MatUCProgress,
        'value': () => MatUCvalue,
        'percent': () => MatUCPercent,
        'setProgress': (v) => MatUCProgress = v,
        'setValue': (v) => MatUCvalue = v.toDouble(),
        'setPercent': (v) => MatUCPercent = v,
        'typeSyncAll': 15,
        'typeSyncOneTable': 0,
        'saveTmp': () => GetCheckSaveTmp('MAT_UNI_C', TotalMAT_UNI_C),
        'updateOrder': () => Update_SYN_ORD('MAT_UNI_C')
      },//
      'MAT_UNI_B': {
        'total': TotalMAT_UNI_B,
        'progress': () => MatUBProgress,
        'value': () => MatUBvalue,
        'percent': () => MatUBPercent,
        'setProgress': (v) => MatUBProgress = v,
        'setValue': (v) => MatUBvalue = v.toDouble(),
        'setPercent': (v) => MatUBPercent = v,
        'typeSyncAll': 16,
        'typeSyncOneTable': 0,
        'saveTmp': () => GetCheckSaveTmp('MAT_UNI_B', TotalMAT_UNI_B),
        'updateOrder': () => Update_SYN_ORD('MAT_UNI_B'),

      },//الباركود
      'MAT_PRI': {
        'total': TotalMAT_PRI,
        'progress': () => MatPProgress,
        'value': () => MatPvalue,
        'percent': () => MatPPercent,
        'setProgress': (v) => MatPProgress = v,
        'setValue': (v) => MatPvalue = v.toDouble(),
        'setPercent': (v) => MatPPercent = v,
        'typeSyncAll': 17,
        'typeSyncOneTable': 0,
        'saveTmp': () => GetCheckSaveTmp('MAT_PRI', TotalMAT_PRI),
        'updateOrder': () => Update_SYN_ORD('MAT_PRI')
      },//تسعيره الاصناف
      'MAT_INF_A': {
        'total': TotalMAT_INF_A,
        'progress': () => MatIAProgress,
        'value': () => MatIAvalue,
        'percent': () => MatIAPercent,
        'setProgress': (v) => MatIAProgress = v,
        'setValue': (v) => MatIAvalue = v.toDouble(),
        'setPercent': (v) => MatIAPercent = v,
        'typeSyncAll': 18,
        'typeSyncOneTable': 0,
        'saveTmp': () => GetCheckSaveTmp(STMID=='EORD'?'MAT_INF_D':'MAT_INF_A',TotalMAT_INF_A),
        'updateOrder': () => Update_SYN_ORD(STMID=='EORD'?'MAT_INF_D':'MAT_INF_A')
      },//بيانات اضافيه للصنف
      'MAT_FOL': {
        'total': TotalMAT_FOL,
        'progress': () => MATFOLProgress,
        'value': () => MATFOLvalue,
        'percent': () => MATFOLPercent,
        'setProgress': (v) => MATFOLProgress = v,
        'setValue': (v) => MATFOLvalue = v.toDouble(),
        'setPercent': (v) => MATFOLPercent = v,
        'typeSyncAll': 19,
        'typeSyncOneTable': 0,
        'saveTmp': () => GetCheckSaveTmp('MAT_FOL',TotalMAT_FOL),
        'updateOrder': () => Update_SYN_ORD('MAT_FOL'),
      },// الاصناف التابعة/المرتبطة.
      'MAT_DES_M': {
        'total': TotalMAT_DES_M,
        'progress': () => MATDESMProgress,
        'value': () => MATDESMvalue,
        'percent': () => MATDESMPercent,
        'setProgress': (v) => MATDESMProgress = v,
        'setValue': (v) => MATDESMvalue = v.toDouble(),
        'setPercent': (v) => MATDESMPercent = v,
        'typeSyncAll': 20,
        'typeSyncOneTable': 0,
        'saveTmp': () => GetCheckSaveTmp('MAT_DES_M',TotalMAT_DES_M),
        'updateOrder': () => Update_SYN_ORD('MAT_DES_M'),
      },//  // مواصفات/ملاحظات سريعة للاصناف
      'MAT_DES_D': {
        'total': TotalMAT_DES_D,
        'progress': () => MATDESDProgress,
        'value': () => MATDESDvalue,
        'percent': () => MATDESDPercent,
        'setProgress': (v) => MATDESDProgress = v,
        'setValue': (v) => MATDESDvalue = v.toDouble(),
        'setPercent': (v) => MATDESDPercent = v,
        'typeSyncAll': 21,
        'typeSyncOneTable': 0,
        'saveTmp': () => GetCheckSaveTmp('MAT_DES_D',TotalMAT_DES_D),
        'updateOrder': () => Update_SYN_ORD('MAT_DES_D'),
      },//  // مواصفات/ملاحظات سريعة للاصناف-فرعي
      'STO_NUM': {
        'total': TotalSTO_NUM,
        'progress': () => StoNProgress,
        'value': () => StoNvalue,
        'percent': () => StoNPercent,
        'setProgress': (v) => StoNProgress = v,
        'setValue': (v) => StoNvalue = v.toDouble(),
        'setPercent': (v) => StoNPercent = v,
        'typeSyncAll': 22,
        'typeSyncOneTable': 0,
        'saveTmp': () => GetCheckSaveTmp('STO_NUM',TotalSTO_NUM),
        'updateOrder': () => Update_SYN_ORD('STO_NUM'),
      },//الكميات المخزنية
      'SYS_CUR': {
        'total': TotalSYS_CUR,
        'progress': () => SysCurProgress,
        'value': () => SysCurvalue,
        'percent': () => SysCurPercent,
        'setProgress': (v) => SysCurProgress = v,
        'setValue': (v) => SysCurvalue = v.toDouble(),
        'setPercent': (v) => SysCurPercent = v,
        'typeSyncAll': 23,
        'typeSyncOneTable': 0,
        'saveTmp': () => GetCheckSaveTmp('SYS_CUR',TotalSYS_CUR),
        'updateOrder': () => Update_SYN_ORD('SYS_CUR'),
      },//العملات
      'SYS_CUR_D': {
        'total': TotalSYS_CUR_D,
        'progress': () => 0,
        'value': () => 0,
        'percent': () => 0,
        'setProgress': (v) => 0 ,
        'setValue': (v) => 0,
        'setPercent': (v) => 0,
        'typeSyncAll': 24,
        'typeSyncOneTable': 24,
        'saveTmp': () => GetCheckSaveTmp('SYS_CUR_D',TotalSYS_CUR_D),
        'updateOrder': () => Update_SYN_ORD('SYS_CUR_D'),
      },
      'SYS_CUR_BET': {
        'total': TotalSYS_CUR_BET,
        'progress': () => 0,
        'value': () => 0,
        'percent': () => 0,
        'setProgress': (v) => 0,
        'setValue': (v) => 0,
        'setPercent': (v) => 0,
        'typeSyncAll': 25,
        'typeSyncOneTable': 25,
        'saveTmp': () => GetCheckSaveTmp('SYS_CUR_BET',TotalSYS_CUR_BET),
        'updateOrder': () => Update_SYN_ORD('SYS_CUR_BET'),
      },
      'PAY_KIN': {
        'total': TotalPAY_KIN,
        'progress': () => PayKinProgress,
        'value': () => PayKinvalue,
        'percent': () => PayKinPercent,
        'setProgress': (v) => PayKinProgress = v,
        'setValue': (v) => PayKinvalue = v.toDouble(),
        'setPercent': (v) => PayKinPercent = v,
        'typeSyncAll': 26,
        'typeSyncOneTable': 0,
        'saveTmp': () => GetCheckSaveTmp('PAY_KIN',TotalPAY_KIN),
        'updateOrder': () => Update_SYN_ORD('PAY_KIN'),
      },//أنواع الدفع
      'ACC_CAS': {
        'total': TotalACC_CAS,
        'progress': () => AccCasProgress,
        'value': () => AccCasvalue,
        'percent': () => AccCasPercent,
        'setProgress': (v) => AccCasProgress = v,
        'setValue': (v) => AccCasvalue = v.toDouble(),
        'setPercent': (v) => AccCasPercent = v,
        'typeSyncAll': 27,
        'typeSyncOneTable': 27,
        'saveTmp': () => GetCheckSaveTmp('ACC_CAS',TotalACC_CAS),
        'updateOrder': () => Update_SYN_ORD('ACC_CAS'),
      },//اعدادات الصناديق
      'ACC_CAS_U': {
        'total': TotalACC_CAS_U,
        'progress': () => 0,
        'value': () => 0,
        'percent': () => 0,
        'setProgress': (v) => 0 ,
        'setValue': (v) => 0,
        'setPercent': (v) => 0,
        'typeSyncAll': 28,
        'typeSyncOneTable': 0,
        'saveTmp': () => GetCheckSaveTmp('ACC_CAS_U',TotalACC_CAS_U),
        'updateOrder': () => Update_SYN_ORD('ACC_CAS_U'),
      },//صلاخيات الصناديق
      'BIL_CRE_C': {
        'total': TotalBIL_CRE_C,
        'progress': () => BilCrecProgress,
        'value': () => BilCrecvalue,
        'percent': () => BilCrecPercent,
        'setProgress': (v) => BilCrecProgress = v,
        'setValue': (v) => BilCrecvalue = v.toDouble(),
        'setPercent': (v) => BilCrecPercent = v,
        'typeSyncAll': 29,
        'typeSyncOneTable': 0,
        'saveTmp': () => GetCheckSaveTmp('BIL_CRE_C',TotalBIL_CRE_C),
        'updateOrder': () => Update_SYN_ORD('BIL_CRE_C'),
      },//بطائق الائتمان
      'ACC_BAN': {
        'total': TotalACC_BAN,
        'progress': () => AccBanProgress,
        'value': () => AccBanvalue,
        'percent': () => AccBanPercent,
        'setProgress': (v) => AccBanProgress = v,
        'setValue': (v) => AccBanvalue = v.toDouble(),
        'setPercent': (v) => AccBanPercent = v,
        'typeSyncAll': 30,
        'typeSyncOneTable': 0,
        'saveTmp': () => GetCheckSaveTmp('ACC_BAN',TotalACC_BAN),
        'updateOrder': () => Update_SYN_ORD('ACC_BAN'),
      },//البنوك
      'BIL_CUS_T': {
        'total': TotalBIL_CUS_T,
        'progress': () => BilCusTProgress,
        'value': () => BilCusTvalue,
        'percent': () => BilCusTPercent,
        'setProgress': (v) => BilCusTProgress = v,
        'setValue': (v) => BilCusTvalue = v.toDouble(),
        'setPercent': (v) => BilCusTPercent = v,
        'typeSyncAll': 31,
        'typeSyncOneTable': 0,
        'saveTmp': () => GetCheckSaveTmp('BIL_CUS_T',TotalBIL_CUS_T),
        'updateOrder': () => Update_SYN_ORD('BIL_CUS_T'),
      },//انواع العملاء
      'BIL_CUS': {
        'total': TotalBIL_CUS,
        'progress': () => BilCusProgress,
        'value': () => BilCusvalue,
        'percent': () => BilCusPercent,
        'setProgress': (v) => BilCusProgress = v,
        'setValue': (v) => BilCusvalue = v.toDouble(),
        'setPercent': (v) => BilCusPercent = v,
        'typeSyncAll': 32,
        'typeSyncOneTable': 0,
        'saveTmp': () => GetCheckSaveTmp('BIL_CUS',TotalBIL_CUS),
        'updateOrder': () => Update_SYN_ORD('BIL_CUS'),
      },// العملاء
      'BIF_CUS_D': {
        'total': TotalBIF_CUS_D,
        'progress': () => BIFCDProgress,
        'value': () => BIFCDvalue,
        'percent': () => BIFCDPercent,
        'setProgress': (v) => BIFCDProgress = v,
        'setValue': (v) => BIFCDvalue = v.toDouble(),
        'setPercent': (v) => BIFCDPercent = v,
        'typeSyncAll': 33,
        'typeSyncOneTable': 0,
        'saveTmp': () => GetCheckSaveTmp('BIF_CUS_D',TotalBIF_CUS_D),
        'updateOrder': () => Update_SYN_ORD('BIF_CUS_D'),
      },// العملاء بدون حسابات
      'BIL_DIS': {
        'total': TotalBIL_DIS,
        'progress': () => BilDisProgress,
        'value': () => BilDisvalue,
        'percent': () => BilDisPercent,
        'setProgress': (v) => BilDisProgress = v,
        'setValue': (v) =>BilDisvalue = v.toDouble(),
        'setPercent': (v) => BilDisPercent = v,
        'typeSyncAll': 34,
        'typeSyncOneTable': 0,
        'saveTmp': () => GetCheckSaveTmp('BIL_DIS',TotalBIL_DIS),
        'updateOrder': () => Update_SYN_ORD('BIL_DIS'),
      },//بيانات المندوبين
      'BIL_IMP': {
        'total': TotalBIL_IMP,
        'progress': () => BILIMPProgress,
        'value': () =>BILIMPvalue,
        'percent': () => BILIMPPercent,
        'setProgress': (v) => BILIMPProgress = v,
        'setValue': (v) => BILIMPvalue = v.toDouble(),
        'setPercent': (v) => BILIMPPercent = v,
        'typeSyncAll': 35,
        'typeSyncOneTable': 0,
        'saveTmp': () => GetCheckSaveTmp('BIL_IMP',TotalBIL_IMP),
        'updateOrder': () => Update_SYN_ORD('BIL_IMP'),
      },//بيانات الموردين
      'COU_WRD': {
        'total': TotalCOU_WRD,
        'progress': () => CouWrdProgress,
        'value': () => CouWrdvalue,
        'percent': () => CouWrdPercent,
        'setProgress': (v) => CouWrdProgress = v,
        'setValue': (v) => CouWrdvalue = v.toDouble(),
        'setPercent': (v) => CouWrdPercent = v,
        'typeSyncAll': 36,
        'typeSyncOneTable': 0,
        'saveTmp': () => GetCheckSaveTmp('COU_WRD',TotalCOU_WRD),
        'updateOrder': () => Update_SYN_ORD('COU_WRD'),
      },////الدول
      'COU_TOW': {
        'total': TotalCOU_TOW,
        'progress': () => CouTowProgress,
        'value': () => CouTowvalue,
        'percent': () => CouTowPercent,
        'setProgress': (v) => CouTowProgress = v,
        'setValue': (v) => CouTowvalue = v.toDouble(),
        'setPercent': (v) => CouTowPercent = v,
        'typeSyncAll': 37,
        'typeSyncOneTable': 0,
        'saveTmp': () => GetCheckSaveTmp('COU_TOW',TotalCOU_TOW),
        'updateOrder': () => Update_SYN_ORD('COU_TOW'),
      },////المدن
      'BIL_ARE': {
        'total': TotalBIL_ARE,
        'progress': () => BilAreProgress,
        'value': () => BilArevalue,
        'percent': () =>BilArePercent,
        'setProgress': (v) => BilAreProgress = v,
        'setValue': (v) => BilArevalue = v.toDouble(),
        'setPercent': (v) => BilArePercent = v,
        'typeSyncAll': 38,
        'typeSyncOneTable': 0,
        'saveTmp': () => GetCheckSaveTmp('BIL_ARE',TotalBIL_ARE),
        'updateOrder': () => Update_SYN_ORD('BIL_ARE'),
      },////المناطق
      'ACC_ACC': {
        'total': TotalACC_ACC,
        'progress': () => AccAccProgress,
        'value': () => AccAccvalue,
        'percent': () => AccAccPercent,
        'setProgress': (v) =>AccAccProgress = v,
        'setValue': (v) =>AccAccvalue = v.toDouble(),
        'setPercent': (v) => AccAccPercent = v,
        'typeSyncAll': 39,
        'typeSyncOneTable': 0,
        'saveTmp': () => GetCheckSaveTmp('ACC_ACC',TotalACC_ACC),
        'updateOrder': () => Update_SYN_ORD('ACC_ACC'),
      },//////الدليل المحاسبي
      'ACC_USR': {
        'total': TotalACC_USR,
        'progress': () => AccUsrProgress,
        'value': () => AccUsrvalue,
        'percent': () => AccUsrPercent,
        'setProgress': (v) => AccUsrProgress = v,
        'setValue': (v) =>AccUsrvalue = v.toDouble(),
        'setPercent': (v) => AccUsrPercent = v,
        'typeSyncAll': 40,
        'typeSyncOneTable': 0,
        'saveTmp': () => GetCheckSaveTmp('ACC_USR',TotalACC_USR),
        'updateOrder': () => Update_SYN_ORD('ACC_USR'),
      },//المستخدمين والحسابات.....
      'SHI_INF': {
        'total': TotalSHI_INF,
        'progress': () => 0,
        'value': () => 0,
        'percent': () => 0,
        'setProgress': (v) => 0,
        'setValue': (v) => 0,
        'setPercent': (v) => 0,
        'typeSyncAll': 41,
        'typeSyncOneTable': 41,
        'saveTmp': () => GetCheckSaveTmp('SHI_INF',TotalSHI_INF),
        'updateOrder': () => Update_SYN_ORD('SHI_INF'),
      },//فترات العمل
      'SHI_USR': {
        'total': TotalSHI_USR,
        'progress': () => ShiUsrProgress,
        'value': () => ShiUsrvalue,
        'percent': () => ShiUsrPercent,
        'setProgress': (v) => ShiUsrProgress = v,
        'setValue': (v) => ShiUsrvalue = v.toDouble(),
        'setPercent': (v) => ShiUsrPercent = v,
        'typeSyncAll': 42,
        'typeSyncOneTable': 0,
        'saveTmp': () => GetCheckSaveTmp('SHI_USR',TotalSHI_USR),
        'updateOrder': () => Update_SYN_ORD('SHI_USR'),
      },//ربط فترات العمل بالنقاط والمستخدمين
      'BIL_POI': {
        'total': TotalBIL_POI,
        'progress': () => BilPoiProgress,
        'value': () => BilPoivalue,
        'percent': () => BilPoiPercent,
        'setProgress': (v) => BilPoiProgress = v,
        'setValue': (v) => BilPoivalue = v.toDouble(),
        'setPercent': (v) => BilPoiPercent = v,
        'typeSyncAll': 43,
        'typeSyncOneTable': 0,
        'saveTmp': () => GetCheckSaveTmp('BIL_POI',TotalBIL_POI),
        'updateOrder': () => Update_SYN_ORD('BIL_POI'),
      },//نقاط البيع
      'BIL_POI_U': {
        'total': TotalBIL_POI_U,
        'progress': () => BilPoiUProgress,
        'value': () => BilPoiUvalue,
        'percent': () => BilPoiUPercent,
        'setProgress': (v) => BilPoiUProgress = v,
        'setValue': (v) => BilPoiUvalue = v.toDouble(),
        'setPercent': (v) => BilPoiUPercent = v,
        'typeSyncAll': 44,
        'typeSyncOneTable': 0,
        'saveTmp': () => GetCheckSaveTmp('BIL_POI_U',TotalBIL_POI_U),
        'updateOrder': () => Update_SYN_ORD('BIL_POI_U'),
      },//ربط نقاط البيع بالمستخدمين
      'BIL_USR_D': {
        'total': TotalBIL_USR_D,
        'progress': () => BilUsrdProgress,
        'value': () => BilUsrdvalue,
        'percent': () => BilUsrdPercent,
        'setProgress': (v) => BilUsrdProgress = v,
        'setValue': (v) => BilUsrdvalue = v.toDouble(),
        'setPercent': (v) => BilUsrdPercent = v,
        'typeSyncAll': 45,
        'typeSyncOneTable': 0,
        'saveTmp': () => GetCheckSaveTmp('BIL_USR_D',TotalBIL_USR_D),
        'updateOrder': () => Update_SYN_ORD('BIL_USR_D'),
      },////نسب التخفيض للموظفين
      'ACC_COS': {
        'total': TotalACC_COS,
        'progress': () => 0,
        'value': () => 0,
        'percent': () => 0,
        'setProgress': (v) => 0,
        'setValue': (v) => 0,
        'setPercent': (v) => 0,
        'typeSyncAll': 46,
        'typeSyncOneTable': 46,
        'saveTmp': () => GetCheckSaveTmp('ACC_COS',TotalACC_COS),
        'updateOrder': () => Update_SYN_ORD('ACC_COS'),
      },//مراكز التكلفه
      'COS_USR': {
        'total': TotalCOS_USR,
        'progress': () => CosUsrProgress,
        'value': () => CosUsrvalue,
        'percent': () => CosUsrPercent,
        'setProgress': (v) => CosUsrProgress = v,
        'setValue': (v) => CosUsrvalue = v.toDouble(),
        'setPercent': (v) => CosUsrPercent = v,
        'typeSyncAll': 47,
        'typeSyncOneTable': 0,
        'saveTmp': () => GetCheckSaveTmp('COS_USR',TotalCOS_USR),
        'updateOrder': () => Update_SYN_ORD('COS_USR'),
      },//المستخدمين ومراكز التكلفه
      'SYS_DOC_D': {
        'total': TotalSYS_DOC_D,
        'progress': () => SysDProgress,
        'value': () => SysDvalue,
        'percent': () => SysDPercent,
        'setProgress': (v) => SysDProgress = v,
        'setValue': (v) => SysDvalue = v.toDouble(),
        'setPercent': (v) => SysDPercent = v,
        'typeSyncAll': 48,
        'typeSyncOneTable': 0,
        'saveTmp': () => GetCheckSaveTmp('SYS_DOC_D',TotalSYS_DOC_D),
        'updateOrder': () => Update_SYN_ORD('SYS_DOC_D'),
      },//تذييل المستندات
      'BRA_YEA': {
        'total': TotalBRA_YEA,
        'progress': () => 0,
        'value': () => 0,
        'percent': () => 0,
        'setProgress': (v) => 0 ,
        'setValue': (v) => 0,
        'setPercent': (v) => 0,
        'typeSyncAll': 49,
        'typeSyncOneTable': 49,
        'saveTmp': () => GetCheckSaveTmp('BRA_YEA',TotalBRA_YEA),
        'updateOrder': () => Update_SYN_ORD('BRA_YEA'),
      },//
      'SYS_SCR': {
        'total': TotalSYS_SCR,
        'progress': () => SYSSCRProgress,
        'value': () => SYSSCRvalue,
        'percent': () => SYSSCRPercent,
        'setProgress': (v) => SYSSCRProgress = v,
        'setValue': (v) => SYSSCRvalue = v.toDouble(),
        'setPercent': (v) => SYSSCRPercent = v,
        'typeSyncAll': 50,
        'typeSyncOneTable': 50,
        'saveTmp': () => GetCheckSaveTmp('SYS_SCR',TotalSYS_SCR),
        'updateOrder': () => {
          Update_SYN_ORD('SYS_SCR'),
          cireclValue += ((110 ~/ PercentValuecount)-3) / 100,
          PercentValue += (110 ~/ PercentValuecount)-5,
        },
      },//الشاشات
      'BIL_MOV_K': {
        'total': TotalBIL_MOV_K,
        'progress': () => BILMOVKProgress,
        'value': () => BILMOVKvalue,
        'percent': () => BILMOVKPercent,
        'setProgress': (v) => BILMOVKProgress = v,
        'setValue': (v) => BILMOVKvalue = v.toDouble(),
        'setPercent': (v) => BILMOVKPercent = v,
        'typeSyncAll': 51,
        'typeSyncOneTable': 0,
        'saveTmp': () => GetCheckSaveTmp(STMID=='INVC'?'STO_MOV_K':'BIL_MOV_K',TotalBIL_MOV_K),
        'updateOrder': () => Update_SYN_ORD(STMID=='INVC'?'STO_MOV_K':'BIL_MOV_K'),
      },//انواع حركات الفواتير
      'ACC_MOV_K': {
        'total': TotalACC_MOV_K,
        'progress': () => ACCMOVKProgress,
        'value': () => ACCMOVKvalue,
        'percent': () => ACCMOVKPercent,
        'setProgress': (v) => ACCMOVKProgress = v,
        'setValue': (v) => ACCMOVKvalue = v.toDouble(),
        'setPercent': (v) => ACCMOVKPercent = v,
        'typeSyncAll': 52,
        'typeSyncOneTable': 0,
        'saveTmp': () => GetCheckSaveTmp('ACC_MOV_K',TotalACC_MOV_K),
        'updateOrder': () => Update_SYN_ORD('ACC_MOV_K'),
      },//اعداد انواع القيود
      'ACC_TAX_T': {
        'total': TotalACC_TAX_T,
        'progress': () => ACCTAXTProgress,
        'value': () => ACCTAXTvalue,
        'percent': () => ACCTAXTPercent,
        'setProgress': (v) => ACCTAXTProgress = v,
        'setValue': (v) => ACCTAXTvalue = v.toDouble(),
        'setPercent': (v) => ACCTAXTPercent = v,
        'typeSyncAll': 53,
        'typeSyncOneTable': 53,
        'saveTmp': () => GetCheckSaveTmp('ACC_TAX_T',TotalACC_TAX_T),
        'updateOrder': () => Update_SYN_ORD('ACC_TAX_T'),
      },//انواع التصنيف الضريبي
      'TAX_MOV_T': {
        'total': TotalTAX_MOV_T,
        'progress': () => TAXMOVTProgress,
        'value': () => TAXMOVTvalue,
        'percent': () => TAXMOVTPercent,
        'setProgress': (v) => TAXMOVTProgress = v,
        'setValue': (v) =>TAXMOVTvalue = v.toDouble(),
        'setPercent': (v) => TAXMOVTPercent = v,
        'typeSyncAll': 54,
        'typeSyncOneTable': 54,
        'saveTmp': () => GetCheckSaveTmp('TAX_MOV_T',TotalTAX_MOV_T),
        'updateOrder': () => {
          Update_SYN_ORD('TAX_MOV_T'),
          cireclValue += ((110 ~/ PercentValuecount)-1) / 100,
          PercentValue += (110 ~/ PercentValuecount)-5,
        },
      },//التصنيف الضريبي
      'ACC_TAX_C': {
        'total': TotalACC_TAX_C,
        'progress': () => ACCTAXCProgress,
        'value': () => ACCTAXCvalue,
        'percent': () => ACCTAXCPercent,
        'setProgress': (v) => ACCTAXCProgress = v,
        'setValue': (v) => ACCTAXCvalue = v.toDouble(),
        'setPercent': (v) => ACCTAXCPercent = v,
        'typeSyncAll': 55,
        'typeSyncOneTable': 0,
        'saveTmp': () => GetCheckSaveTmp('ACC_TAX_C',TotalACC_TAX_C),
        'updateOrder': () => Update_SYN_ORD('ACC_TAX_C'),
      },////التصنيف الضريبي للحساب
      'TAX_TYP': {
        'total': TotalTAX_TYP,
        'progress': () => 0,
        'value': () => 0,
        'percent': () => 0,
        'setProgress': (v) => 0 ,
        'setValue': (v) => 0 ,
        'setPercent': (v) => 0 ,
        'typeSyncAll': 56,
        'typeSyncOneTable': 56,
        'saveTmp': () => GetCheckSaveTmp('TAX_TYP',TotalTAX_TYP),
        'updateOrder': () => Update_SYN_ORD('TAX_TYP'),
      },//انواع الضرائب
      'TAX_TYP_SYS': {
        'total': TotalTAX_TYP_SYS,
        'progress': () => TAXTYPProgress,
        'value': () => TAXTYPvalue,
        'percent': () => TAXTYPPercent,
        'setProgress': (v) => TAXTYPProgress = v,
        'setValue': (v) => TAXTYPvalue = v.toDouble(),
        'setPercent': (v) => TAXTYPPercent = v,
        'typeSyncAll': 57,
        'typeSyncOneTable': 0,
        'saveTmp': () => GetCheckSaveTmp('TAX_TYP_SYS',TotalTAX_TYP_SYS),
        'updateOrder': () => Update_SYN_ORD('TAX_TYP_SYS'),
      },//
      'TAX_TYP_BRA': {
        'total': TotalTAX_TYP_BRA,
        'progress': () => TAXTYPBRAProgress,
        'value': () => TAXTYPBRAvalue,
        'percent': () => TAXTYPBRAPercent,
        'setProgress': (v) => TAXTYPBRAProgress = v,
        'setValue': (v) => TAXTYPBRAvalue = v.toDouble(),
        'setPercent': (v) => TAXTYPBRAPercent = v,
        'typeSyncAll': 58,
        'typeSyncOneTable': 0,
        'saveTmp': () => GetCheckSaveTmp('TAX_TYP_BRA',TotalTAX_TYP_BRA),
        'updateOrder': () => Update_SYN_ORD('TAX_TYP_BRA'),
      },//ربط الفروع مع انواع الضرائب
      'TAX_PER_M': {
        'total': TotalTAX_PER_M,
        'progress': () => 0,
        'value': () => 0,
        'percent': () => 0,
        'setProgress': (v) => 0 ,
        'setValue': (v) => 0  ,
        'setPercent': (v) => 0,
        'typeSyncAll': 59,
        'typeSyncOneTable': 59,
        'saveTmp': () => GetCheckSaveTmp('TAX_PER_M',TotalTAX_PER_M),
        'updateOrder': () => Update_SYN_ORD('TAX_PER_M'),
      },//اعداد الفترات الضريبيه
      'TAX_PER_D': {
        'total': TotalTAX_PER_D,
        'progress': () => TAXPERDProgress,
        'value': () => TAXPERDvalue,
        'percent': () => TAXPERDPercent,
        'setProgress': (v) => TAXPERDProgress = v,
        'setValue': (v) => TAXPERDvalue = v.toDouble(),
        'setPercent': (v) => TAXPERDPercent = v,
        'typeSyncAll': 60,
        'typeSyncOneTable': 0,
        'saveTmp': () => GetCheckSaveTmp('TAX_PER_D',TotalTAX_PER_D),
        'updateOrder': () => Update_SYN_ORD('TAX_PER_D'),
      },//
      'TAX_PER_BRA': {
        'total': TotalTAX_PER_BRA,
        'progress': () => TAXPERBRAProgress,
        'value': () => TAXPERBRAvalue,
        'percent': () => TAXPERBRAPercent,
        'setProgress': (v) => TAXPERBRAProgress = v,
        'setValue': (v) => TAXPERBRAvalue = v.toDouble(),
        'setPercent': (v) => TAXPERBRAPercent = v,
        'typeSyncAll': 61,
        'typeSyncOneTable': 0,
        'saveTmp': () => GetCheckSaveTmp('TAX_PER_BRA',TotalTAX_PER_BRA),
        'updateOrder': () => Update_SYN_ORD('TAX_PER_BRA'),
      },//ربط الفترات الضريبيه بالفروع
      'TAX_LOC': {
        'total': TotalTAX_LOC,
        'progress': () => 0,
        'value': () => 0,
        'percent': () => 0,
        'setProgress': (v) => 0,
        'setValue': (v) => 0,
        'setPercent': (v) => 0,
        'typeSyncAll': 62,
        'typeSyncOneTable': 62,
        'saveTmp': () => GetCheckSaveTmp('TAX_LOC',TotalTAX_LOC),
        'updateOrder': () => Update_SYN_ORD('TAX_LOC'),
      },//المواقع الضريبيه
      'TAX_LOC_SYS': {
        'total': TotalTAX_LOC_SYS,
        'progress': () => TAXLOCProgress,
        'value': () => TAXLOCvalue,
        'percent': () => TAXLOCPercent,
        'setProgress': (v) => TAXLOCProgress = v,
        'setValue': (v) => TAXLOCvalue = v.toDouble(),
        'setPercent': (v) => TAXLOCPercent = v,
        'typeSyncAll': 63,
        'typeSyncOneTable': 0,
        'saveTmp': () => GetCheckSaveTmp('TAX_LOC_SYS',TotalTAX_LOC_SYS),
        'updateOrder': () => Update_SYN_ORD('TAX_LOC_SYS'),
      },//المواقع الضريبيه
      'TAX_COD': {
        'total': TotalTAX_COD,
        'progress': () => TAXCODProgress,
        'value': () => TAXCODvalue,
        'percent': () => TAXCODPercent,
        'setProgress': (v) => TAXCODProgress = v,
        'setValue': (v) => TAXCODvalue = v.toDouble(),
        'setPercent': (v) => TAXCODPercent = v,
        'typeSyncAll': 64,
        'typeSyncOneTable': 64,
        'saveTmp': () => GetCheckSaveTmp('TAX_COD',TotalTAX_COD),
        'updateOrder': () => Update_SYN_ORD('TAX_COD'),
      },// /الترميزات الضريبيه
      'TAX_COD_SYS': {
        'total': TotalTAX_COD_SYS,
        'progress': () => TAXCODSYSProgress,
        'value': () => TAXCODSYSvalue,
        'percent': () => TAXCODSYSPercent,
        'setProgress': (v) => TAXCODSYSProgress = v,
        'setValue': (v) => TAXCODSYSvalue = v.toDouble(),
        'setPercent': (v) => TAXCODSYSPercent = v,
        'typeSyncAll': 65,
        'typeSyncOneTable': 65,
        'saveTmp': () => GetCheckSaveTmp('TAX_COD_SYS',TotalTAX_COD_SYS),
        'updateOrder': () => Update_SYN_ORD('TAX_COD_SYS'),
      },//الترميزات الضريبيه
      'TAX_COD_SYS_D': {
        'total': TotalTAX_COD_SYS_D,
        'progress': () => TAXCODSYSDProgress,
        'value': () => TAXCODSYSDvalue,
        'percent': () => TAXCODSYSDPercent,
        'setProgress': (v) => TAXCODSYSDProgress = v,
        'setValue': (v) => TAXCODSYSDvalue = v.toDouble(),
        'setPercent': (v) => TAXCODSYSDPercent = v,
        'typeSyncAll': 66,
        'typeSyncOneTable': 0,
        'saveTmp': () => GetCheckSaveTmp('TAX_COD_SYS_D',TotalTAX_COD_SYS_D),
        'updateOrder': () => Update_SYN_ORD('TAX_COD_SYS_D'),
      },//الترميزات الضريبيه
      'TAX_SYS': {
        'total': TotalTAX_SYS,
        'progress': () => TAXSYSProgress,
        'value': () => TAXSYSvalue,
        'percent': () => TAXSYSPercent,
        'setProgress': (v) => TAXSYSProgress = v,
        'setValue': (v) => TAXSYSvalue = v.toDouble(),
        'setPercent': (v) => TAXSYSPercent = v,
        'typeSyncAll': 67,
        'typeSyncOneTable': 67,
        'saveTmp': () => GetCheckSaveTmp('TAX_SYS',TotalTAX_SYS),
        'updateOrder': () => Update_SYN_ORD('TAX_SYS'),
      },//ربط الضريبيه بالانظمه
      'TAX_SYS_D': {
        'total': TotalTAX_SYS_D,
        'progress': () => TAXSYSDProgress,
        'value': () => TAXSYSDvalue,
        'percent': () => TAXSYSDPercent,
        'setProgress': (v) => TAXSYSDProgress = v,
        'setValue': (v) => TAXSYSDvalue = v.toDouble(),
        'setPercent': (v) => TAXSYSDPercent = v,
        'typeSyncAll': 68,
        'typeSyncOneTable': 0,
        'saveTmp': () => GetCheckSaveTmp('TAX_SYS_D',TotalTAX_SYS_D),
        'updateOrder': () => Update_SYN_ORD('TAX_SYS_D'),
      },//ربط الضريبيه بالانظمه
      'TAX_SYS_BRA': {
        'total': TotalTAX_SYS_BRA,
        'progress': () => TAXSYSBRAProgress,
        'value': () => TAXSYSBRAvalue,
        'percent': () => TAXSYSBRAPercent,
        'setProgress': (v) => TAXSYSBRAProgress = v,
        'setValue': (v) => TAXSYSBRAvalue = v.toDouble(),
        'setPercent': (v) => TAXSYSBRAPercent = v,
        'typeSyncAll': 69,
          'typeSyncOneTable': 0,
        'saveTmp': () => GetCheckSaveTmp('TAX_SYS_BRA',TotalTAX_SYS_BRA),
        'updateOrder': () => Update_SYN_ORD('TAX_SYS_BRA'),
      },//ربط الضريبه والفروع
      'TAX_VAR': {
        'total': TotalTAX_VAR,
        'progress': () => TAXVARProgress,
        'value': () => TAXVARvalue,
        'percent': () => TAXVARPercent,
        'setProgress': (v) => TAXVARProgress = v,
        'setValue': (v) => TAXVARvalue = v.toDouble(),
        'setPercent': (v) => TAXVARPercent = v,
        'typeSyncAll': 70,
          'typeSyncOneTable': 70,
        'saveTmp': () => GetCheckSaveTmp('TAX_VAR',TotalTAX_VAR),
        'updateOrder': () => Update_SYN_ORD('TAX_VAR'),
      },////متغيرات الضرائب
      'TAX_VAR_D': {
        'total': TotalTAX_VAR_D,
        'progress': () => TAXVARDProgress,
        'value': () => TAXVARDvalue,
        'percent': () => TAXVARDPercent,
        'setProgress': (v) => TAXVARDProgress = v,
        'setValue': (v) => TAXVARDvalue = v.toDouble(),
        'setPercent': (v) => TAXVARDPercent = v,
        'typeSyncAll': 71,
          'typeSyncOneTable': 0,
        'saveTmp': () => GetCheckSaveTmp('TAX_VAR_D',TotalTAX_VAR_D),
        'updateOrder': () => Update_SYN_ORD('TAX_VAR_D'),
      },////متغيرات الضرائب
      'TAX_LIN': {
        'total': TotalTAX_LIN,
        'progress': () => TAXLINProgress,
        'value': () => TAXLINvalue,
        'percent': () => TAXLINPercent,
        'setProgress': (v) => TAXLINProgress = v,
        'setValue': (v) => TAXLINvalue = v.toDouble(),
        'setPercent': (v) => TAXLINPercent = v,
        'typeSyncAll': 72,
          'typeSyncOneTable': 0,
        'saveTmp': () => GetCheckSaveTmp('TAX_LIN',TotalTAX_LIN),
        'updateOrder': () => Update_SYN_ORD('TAX_LIN'),
      },//
      'IDE_TYP': {
        'total': TotalIDE_TYP,
        'progress': () => IDETYPProgress,
        'value': () => IDETYPvalue,
        'percent': () => IDETYPPercent,
        'setProgress': (v) => IDETYPProgress = v,
        'setValue': (v) => IDETYPvalue = v.toDouble(),
        'setPercent': (v) => IDETYPPercent = v,
        'typeSyncAll': 73,
          'typeSyncOneTable': 0,
        'saveTmp': () => GetCheckSaveTmp('IDE_TYP',TotalIDE_TYP),
        'updateOrder': () => Update_SYN_ORD('IDE_TYP'),
      },//
      'IDE_LIN': {
        'total': TotalIDE_LIN,
        'progress': () => IDELINProgress,
        'value': () => IDELINvalue,
        'percent': () => IDELINPercent,
        'setProgress': (v) => IDELINProgress = v,
        'setValue': (v) => IDELINvalue = v.toDouble(),
        'setPercent': (v) => IDELINPercent = v,
        'typeSyncAll': 74,
          'typeSyncOneTable': 0,
        'saveTmp': () => GetCheckSaveTmp('IDE_LIN',TotalIDE_LIN),
        'updateOrder': () => Update_SYN_ORD('IDE_LIN'),
      },//
      'TAX_MOV_SIN': {
        'total': TotalTAX_MOV_SIN,
        'progress': () => TAXMOVSINProgress,
        'value': () => TAXMOVSINvalue,
        'percent': () => TAXMOVSINPercent,
        'setProgress': (v) => TAXMOVSINProgress = v,
        'setValue': (v) => TAXMOVSINvalue = v.toDouble(),
        'setPercent': (v) => TAXMOVSINPercent = v,
        'typeSyncAll': 75,
          'typeSyncOneTable': 0,
        'saveTmp': () => GetCheckSaveTmp('TAX_MOV_SIN',TotalTAX_MOV_SIN),
        'updateOrder': () => Update_SYN_ORD('TAX_MOV_SIN'),
      },//
      'TAX_TBL_LNK': {
        'total': TotalTAX_TBL_LNK,
        'progress': () => TAXTBLLNKProgress,
        'value': () => TAXTBLLNKvalue,
        'percent': () => TAXTBLLNKPercent,
        'setProgress': (v) => TAXTBLLNKProgress = v,
        'setValue': (v) => TAXTBLLNKvalue = v.toDouble(),
        'setPercent': (v) => TAXTBLLNKPercent = v,
        'typeSyncAll': 76,
          'typeSyncOneTable': 0,
        'saveTmp': () => GetCheckSaveTmp('TAX_TBL_LNK',TotalTAX_TBL_LNK),
        'updateOrder': () => Update_SYN_ORD('TAX_TBL_LNK'),
      },//ربط الرموز والاكواد الخاصه بالضريبه مع البيانات
      'FAT_API_INF': {
        'total': TotalFAT_API_INF,
        'progress': () => FATAPIINFProgress,
        'value': () => FATAPIINFvalue,
        'percent': () => FATAPIINFPercent,
        'setProgress': (v) => FATAPIINFProgress = v,
        'setValue': (v) => FATAPIINFvalue = v.toDouble(),
        'setPercent': (v) => FATAPIINFPercent = v,
        'typeSyncAll': 77,
          'typeSyncOneTable': 0,
        'saveTmp': () => GetCheckSaveTmp('FAT_API_INF',TotalFAT_API_INF),
        'updateOrder': () => Update_SYN_ORD('FAT_API_INF'),
      },//بيانات الربط مع الــAPI
      'FAT_CSID_INF_D': {
        'total': TotalFAT_CSID_INF_D,
        'progress': () => 0,
        'value': () => 0,
        'percent': () => 0,
        'setProgress': (v) => 0 ,
        'setValue': (v) => 0 ,
        'setPercent': (v) =>0,
        'typeSyncAll': 78,
        'typeSyncOneTable': 78,
        'saveTmp': () => GetCheckSaveTmp('FAT_CSID_INF_D',TotalFAT_CSID_INF_D),
        'updateOrder': () => Update_SYN_ORD('FAT_CSID_INF_D'),
      },//
      'FAT_CSID_INF': {
        'total': TotalFAT_CSID_INF,
        'progress': () => FATCSIDINFProgress,
        'value': () => FATCSIDINFvalue,
        'percent': () => FATCSIDINFPercent,
        'setProgress': (v) => FATCSIDINFProgress = v,
        'setValue': (v) => FATCSIDINFvalue = v.toDouble(),
        'setPercent': (v) => FATCSIDINFPercent = v,
        'typeSyncAll': 79,
        'typeSyncOneTable': 0,
        'saveTmp': () => GetCheckSaveTmp('FAT_CSID_INF',TotalFAT_CSID_INF),
        'updateOrder': () => Update_SYN_ORD('FAT_CSID_INF'),
      },
      'FAT_CSID_SEQ': {
        'total': TotalFAT_CSID_SEQ,
        'progress': () => FATCSIDSEQProgress,
        'value': () =>FATCSIDSEQvalue,
        'percent': () => FATCSIDSEQPercent,
        'setProgress': (v) => FATCSIDSEQProgress = v,
        'setValue': (v) => FATCSIDSEQvalue = v.toDouble(),
        'setPercent': (v) => FATCSIDSEQPercent = v,
        'typeSyncAll': 80,
        'typeSyncOneTable': 0,
        'saveTmp': () => GetCheckSaveTmp('FAT_CSID_SEQ',TotalFAT_CSID_SEQ),
        'updateOrder': () => Update_SYN_ORD('FAT_CSID_SEQ'),
      },//مسلسل الترقيم للوحدات/الاجهزه التقنية
      'FAT_CSID_ST': {
        'total': TotalFAT_CSID_ST,
        'progress': () => FATCSIDSTProgress,
        'value': () => FATCSIDSTvalue,
        'percent': () => FATCSIDSTPercent,
        'setProgress': (v) => FATCSIDSTProgress = v,
        'setValue': (v) => FATCSIDSTvalue = v.toDouble(),
        'setPercent': (v) => FATCSIDSTPercent = v,
        'typeSyncAll': 81,
        'typeSyncOneTable': 0,
        'saveTmp': () => GetCheckSaveTmp('FAT_CSID_ST',TotalFAT_CSID_ST),
        'updateOrder': () => Update_SYN_ORD('FAT_CSID_ST'),
      },//حالة الوحدات/الاجهزه التقنية
      'FAT_QUE': {
        'total': TotalFAT_QUE,
        'progress': () => FATQUEProgress,
        'value': () => FATQUEvalue,
        'percent': () => FATQUEPercent,
        'setProgress': (v) => FATQUEProgress = v,
        'setValue': (v) => FATQUEvalue = v.toDouble(),
        'setPercent': (v) => FATQUEPercent = v,
        'typeSyncAll': 82,
        'typeSyncOneTable': 0,
        'saveTmp': () => GetCheckSaveTmp('FAT_QUE',TotalFAT_QUE),
        'updateOrder': () => Update_SYN_ORD('FAT_QUE'),
      },//
      'MAT_DIS_T': {
        'total': TotalMAT_DIS_T,
        'progress': () => MATDISTProgress,
        'value': () => MATDISTvalue,
        'percent': () => MATDISTPercent,
        'setProgress': (v) => MATDISTProgress = v,
        'setValue': (v) => MATDISTvalue = v.toDouble(),
        'setPercent': (v) => MATDISTPercent = v,
        'typeSyncAll': 83,
        'typeSyncOneTable': 0,
        'saveTmp': () => GetCheckSaveTmp('MAT_DIS_T',TotalMAT_DIS_T),
        'updateOrder': () => Update_SYN_ORD('MAT_DIS_T'),
      },////انواع العروض والتخفيضات
      'MAT_DIS_K': {
        'total': TotalMAT_DIS_K,
        'progress': () => MATDISKProgress,
        'value': () => MATDISKvalue,
        'percent': () => MATDISKPercent,
        'setProgress': (v) => MATDISKProgress = v,
        'setValue': (v) => MATDISKvalue = v.toDouble(),
        'setPercent': (v) => MATDISKPercent = v,
        'typeSyncAll': 84,
        'typeSyncOneTable': 0,
        'saveTmp': () => GetCheckSaveTmp('MAT_DIS_K',TotalMAT_DIS_K),
        'updateOrder': () => Update_SYN_ORD('MAT_DIS_K'),
      },////طبيعة العروض والتخفيض
      'MAT_DIS_M': {
        'total': TotalMAT_DIS_M,
        'progress': () => MATDISMProgress,
        'value': () => MATDISMvalue,
        'percent': () => MATDISMPercent,
        'setProgress': (v) => MATDISMProgress = v,
        'setValue': (v) => MATDISMvalue = v.toDouble(),
        'setPercent': (v) => MATDISMPercent = v,
        'typeSyncAll': 85,
        'typeSyncOneTable': 0,
        'saveTmp': () => GetCheckSaveTmp('MAT_DIS_M',TotalMAT_DIS_M),
        'updateOrder': () => Update_SYN_ORD('MAT_DIS_M'),
      },//العروض والتخقيضات -رئيسي
      'MAT_DIS_D': {
        'total': TotalMAT_DIS_D,
        'progress': () => MATDISDProgress,
        'value': () => MATDISDvalue,
        'percent': () => MATDISDPercent,
        'setProgress': (v) => MATDISDProgress = v,
        'setValue': (v) => MATDISDvalue = v.toDouble(),
        'setPercent': (v) => MATDISDPercent = v,
        'typeSyncAll': 86,
        'typeSyncOneTable': 0,
        'saveTmp': () => GetCheckSaveTmp('MAT_DIS_D',TotalMAT_DIS_D),
        'updateOrder': () => Update_SYN_ORD('MAT_DIS_D'),
      },//العروض والتخقيضات -فرعي
      'MAT_DIS_F': {
        'total': TotalMAT_DIS_F,
        'progress': () => MATDISFProgress,
        'value': () => MATDISFvalue,
        'percent': () => MATDISFPercent,
        'setProgress': (v) => MATDISFProgress = v,
        'setValue': (v) => MATDISFvalue = v.toDouble(),
        'setPercent': (v) => MATDISFPercent = v,
        'typeSyncAll': 87,
        'typeSyncOneTable': 0,
        'saveTmp': () => GetCheckSaveTmp('MAT_DIS_F',TotalMAT_DIS_F),
        'updateOrder': () => Update_SYN_ORD('MAT_DIS_F'),
      },//العروض والتخقيضات -فرعي
      'MAT_DIS_L': {
        'total': TotalMAT_DIS_L,
        'progress': () => MATDISLProgress,
        'value': () => MATDISLvalue,
        'percent': () => MATDISLPercent,
        'setProgress': (v) => MATDISLProgress = v,
        'setValue': (v) => MATDISLvalue = v.toDouble(),
        'setPercent': (v) => MATDISLPercent = v,
        'typeSyncAll': 88,
        'typeSyncOneTable': 0,
        'saveTmp': () => GetCheckSaveTmp('MAT_DIS_L',TotalMAT_DIS_L),
        'updateOrder': () => Update_SYN_ORD('MAT_DIS_L'),
      },//اربط العروض مع المجموعات الرئيسيه
      'MAT_DIS_S': {
        'total': TotalMAT_DIS_S,
        'progress': () => MATDISSProgress,
        'value': () => MATDISSvalue,
        'percent': () => MATDISSPercent,
        'setProgress': (v) => MATDISSProgress = v,
        'setValue': (v) => MATDISSvalue = v.toDouble(),
        'setPercent': (v) => MATDISSPercent = v,
        'typeSyncAll': 89,
        'typeSyncOneTable': 0,
        'saveTmp': () => GetCheckSaveTmp('MAT_DIS_S',TotalMAT_DIS_S),
        'updateOrder': () => Update_SYN_ORD('MAT_DIS_S'),
      },//حالة العروض والتخفيضات
      'MAT_MAI_M': {
        'total': TotalMAT_MAI_M,
        'progress': () => MATMAIMProgress,
        'value': () => MATMAIMvalue,
        'percent': () => MATMAIMPercent,
        'setProgress': (v) => MATMAIMProgress = v,
        'setValue': (v) => MATMAIMvalue = v.toDouble(),
        'setPercent': (v) => MATMAIMPercent = v,
        'typeSyncAll': 90,
        'typeSyncOneTable': 0,
        'saveTmp': () => GetCheckSaveTmp('MAT_MAI_M',TotalMAT_MAI_M),
        'updateOrder': () => Update_SYN_ORD('MAT_MAI_M'),
      },//المجموعات الرئيسية للعروض
      'RES_SEC': {
        'total': TotalRES_SEC,
        'progress': () => RESSECProgress,
        'value': () => RESSECvalue,
        'percent': () => RESSECPercent,
        'setProgress': (v) => RESSECProgress = v,
        'setValue': (v) => RESSECvalue = v.toDouble(),
        'setPercent': (v) => RESSECPercent = v,
        'typeSyncAll': 91,
        'typeSyncOneTable': 0,
        'saveTmp': () => GetCheckSaveTmp('RES_SEC',TotalRES_SEC),
        'updateOrder': () => Update_SYN_ORD('RES_SEC'),
      },//الاقسام
      'RES_TAB': {
        'total': TotalRES_TAB,
        'progress': () => RESTABProgress,
        'value': () => RESTABvalue,
        'percent': () => RESTABPercent,
        'setProgress': (v) => RESTABProgress = v,
        'setValue': (v) => RESTABvalue = v.toDouble(),
        'setPercent': (v) => RESTABPercent = v,
        'typeSyncAll': 92,
        'typeSyncOneTable': 0,
        'saveTmp': () => GetCheckSaveTmp('RES_TAB',TotalRES_TAB),
        'updateOrder': () => Update_SYN_ORD('RES_TAB'),
      },//الطاولات
      'RES_EMP': {
        'total': TotalRES_EMP,
        'progress': () => RESEMPProgress,
        'value': () => RESEMPvalue,
        'percent': () => RESEMPPercent,
        'setProgress': (v) => RESEMPProgress = v,
        'setValue': (v) => RESEMPvalue = v.toDouble(),
        'setPercent': (v) => RESEMPPercent = v,
        'typeSyncAll': 93,
        'typeSyncOneTable': 0,
        'saveTmp': () => GetCheckSaveTmp('RES_EMP',TotalRES_EMP),
        'updateOrder': () => Update_SYN_ORD('RES_EMP'),

      },//موظفي الخدمه
      'COU_TYP_M': {
        'total': TotalCOU_TYP_M,
        'progress': () => CouTypMProgress,
        'value': () => CouTypvalue,
        'percent': () => CouTypMPercent,
        'setProgress': (v) => CouTypMProgress = v,
        'setValue': (v) => CouTypvalue = v.toDouble(),
        'setPercent': (v) => CouTypMPercent = v,
        'typeSyncAll': 94,
        'typeSyncOneTable': 0,
        'saveTmp': () => GetCheckSaveTmp('COU_TYP_M',TotalCOU_TYP_M),
        'updateOrder': () => Update_SYN_ORD('COU_TYP_M'),
      },//أنواع الوقود
      'COU_INF_M': {
        'total': TotalCOU_INF_M,
        'progress': () => CouInfMProgress,
        'value': () => CouInfMvalue,
        'percent': () => CouInfMPercent,
        'setProgress': (v) => CouInfMProgress = v,
        'setValue': (v) => CouInfMvalue = v.toDouble(),
        'setPercent': (v) => CouInfMPercent = v,
        'typeSyncAll': 95,
        'typeSyncOneTable': 0,
        'saveTmp': () => GetCheckSaveTmp('COU_INF_M',TotalCOU_INF_M),
        'updateOrder': () => Update_SYN_ORD('COU_INF_M'),
      },//اعدادات بيانات العدادات
      'COU_POI_L': {
        'total': TotalCOU_POI_L,
        'progress': () => CouPoiLProgress,
        'value': () => CouPoiLvalue,
        'percent': () => CouPoiLPercent,
        'setProgress': (v) => CouPoiLProgress = v,
        'setValue': (v) => CouPoiLvalue = v.toDouble(),
        'setPercent': (v) => CouPoiLPercent = v,
        'typeSyncAll': 96,
        'typeSyncOneTable': 0,
        'saveTmp': () => GetCheckSaveTmp('COU_POI_L',TotalCOU_POI_L),
        'updateOrder': () => Update_SYN_ORD('COU_POI_L'),
      },//ربط العدادات بالنقاط
      'COU_USR': {
        'total': TotalCOU_USR,
        'progress': () => CouUsrProgress,
        'value': () => CouUsrvalue,
        'percent': () => CouUsrPercent,
        'setProgress': (v) => CouUsrProgress = v,
        'setValue': (v) => CouUsrvalue = v.toDouble(),
        'setPercent': (v) => CouUsrPercent = v,
        'typeSyncAll': 97,
        'typeSyncOneTable': 0,
        'saveTmp': () => GetCheckSaveTmp('COU_USR',TotalCOU_USR),
        'updateOrder': () => Update_SYN_ORD('COU_USR'),
      },//صلاحيه المستخدمين بالعدادات
      'COU_RED': {
        'total': TotalCOU_RED,
        'progress': () => CouRedProgress,
        'value': () => CouRedvalue,
        'percent': () => CouRedPercent,
        'setProgress': (v) => CouRedProgress = v,
        'setValue': (v) => CouRedvalue = v.toDouble(),
        'setPercent': (v) => CouRedPercent = v,
        'typeSyncAll': 98,
        'typeSyncOneTable': 0,
        'saveTmp': () => GetCheckSaveTmp('COU_RED',TotalCOU_RED),
        'updateOrder': () => Update_SYN_ORD('COU_RED'),
      },//القراءات
      'BIF_GRO': {
        'total': TotalBIF_GRO,
        'progress': () => BIFGROProgress,
        'value': () => BIFGROvalue,
        'percent': () => BIFGROPercent,
        'setProgress': (v) => BIFGROProgress = v,
        'setValue': (v) => BIFGROvalue = v.toDouble(),
        'setPercent': (v) => BIFGROPercent = v,
        'typeSyncAll': 99,
        'typeSyncOneTable': 0,
        'saveTmp': () => GetCheckSaveTmp('BIF_GRO',TotalBIF_GRO),
        'updateOrder': () => Update_SYN_ORD('BIF_GRO'),
      },//مجموعات الفواتير
      'BIF_GRO2': {
        'total': TotalBIF_GRO2,
        'progress': () => BIFGRO2Progress,
        'value': () => BIFGRO2value,
        'percent': () => BIFGRO2Percent,
        'setProgress': (v) => BIFGRO2Progress = v,
        'setValue': (v) => BIFGRO2value = v.toDouble(),
        'setPercent': (v) => BIFGRO2Percent = v,
        'typeSyncAll': 100,
        'typeSyncOneTable': 0,
        'saveTmp': () => GetCheckSaveTmp('BIF_GRO2',TotalBIF_GRO2),
        'updateOrder': () => Update_SYN_ORD('BIF_GRO2'),
      },//مجموعات الفواتير

      'SYN_SET': {
        'total': TotalSYN_SET,
        'progress': () => 0,
        'value': () => 0,
        'percent': () => 0,
        'setProgress': (v) => 0 ,
        'setValue': (v) => 0,
        'setPercent': (v) => 0,
        'typeSyncAll': 101,
        'typeSyncOneTable': 101,
        'saveTmp': () => GetCheckSaveTmp('SYN_SET',TotalSYN_SET),
        'updateOrder': () => Update_SYN_ORD('SYN_SET'),
      },//اعدادات الربط/التزامن-السحابي
      'SYN_OFF_M': {
        'total': TotalSYN_OFF_M,
        'progress': () => 0,
        'value': () => 0,
        'percent': () => 0,
        'setProgress': (v) => 0 ,
        'setValue': (v) => 0,
        'setPercent': (v) => 0,
        'typeSyncAll': 102,
        'typeSyncOneTable': 102,
        'saveTmp': () => GetCheckSaveTmp('SYN_OFF_M',TotalSYN_OFF_M),
        'updateOrder': () => Update_SYN_ORD('SYN_OFF_M'),
      },
      'SYN_OFF_M2': {
        'total': TotalSYN_OFF_M2,
        'progress': () => 0,
        'value': () => 0,
        'percent': () => 0,
        'setProgress': (v) => 0,
        'setValue': (v) => 0,
        'setPercent': (v) => 0,
        'typeSyncAll': 103,
        'typeSyncOneTable': 103,
        'saveTmp': () => GetCheckSaveTmp('SYN_OFF_M2',TotalSYN_OFF_M2),
        'updateOrder': () => Update_SYN_ORD('SYN_OFF_M2'),
      },
      'ECO_VAR': {
        'total': TotalECO_VAR,
        'progress': () => ECOVARProgress,
        'value': () => ECOVARvalue,
        'percent': () => ECOVARPercent,
        'setProgress': (v) => ECOVARProgress = v,
        'setValue': (v) => ECOVARvalue = v.toDouble(),
        'setPercent': (v) => ECOVARPercent = v,
        'typeSyncAll': 104,
        'typeSyncOneTable': 0,
        'saveTmp': () => GetCheckSaveTmp('ECO_VAR',TotalECO_VAR),
        'updateOrder': () => {
          Update_SYN_ORD('ECO_VAR'),
          cireclValue += ((110 ~/ PercentValuecount)-3) / 100,
          PercentValue += (110 ~/ PercentValuecount)-3,
          print('osama'),
          update(),
        },
      },//متغيرات ايليت تواصل
      'ECO_ACC': {
        'total': TotalECO_ACC,
        'progress': () => ECOACCProgress,
        'value': () => ECOACCvalue,
        'percent': () => ECOACCPercent,
        'setProgress': (v) => ECOACCProgress = v,
        'setValue': (v) => ECOACCvalue = v.toDouble(),
        'setPercent': (v) => ECOACCPercent = v,
        'typeSyncAll': 105,
        'typeSyncOneTable': 0,
        'saveTmp': () => GetCheckSaveTmp('ECO_ACC',TotalECO_ACC),
        'updateOrder': () => Update_SYN_ORD('ECO_ACC'),

      },//حسابات وارقام التواصل
      'ECO_MSG_ACC': {
        'total': TotalECO_MSG_ACC,
        'progress': () => ECOMSGACCProgress,
        'value': () => ECOMSGACCvalue,
        'percent': () => ECOMSGACCPercent,
        'setProgress': (v) => ECOMSGACCProgress = v,
        'setValue': (v) => ECOMSGACCvalue = v.toDouble(),
        'setPercent': (v) => ECOMSGACCPercent = v,
        'typeSyncAll': 106,
        'typeSyncOneTable': 0,
        'saveTmp': () => GetCheckSaveTmp('ECO_MSG_ACC',TotalECO_MSG_ACC),
        'updateOrder': () => Update_SYN_ORD('ECO_MSG_ACC'),

      },//انواع الرسائل المرتبطه بالارقام
      'BAL_ACC_M': {
        'total': TotalBAL_ACC_M,
        'progress': () => BALACCMProgress,
        'value': () => BALACCMvalue,
        'percent': () => BALACCMPercent,
        'setProgress': (v) => BALACCMProgress = v,
        'setValue': (v) => BALACCMvalue = v.toDouble(),
        'setPercent': (v) =>BALACCMPercent = v,
        'typeSyncAll': 107,
        'typeSyncOneTable': 107,
        'saveTmp': () => GetCheckSaveTmp('BAL_ACC_M',TotalBAL_ACC_M),
        'updateOrder': () =>
          Update_SYN_ORD('BAL_ACC_M'),
      },//ارصده الحسابات -رئيسي
      'BAL_ACC_C': {
        'total': TotalBAL_ACC_C,
        'progress': () => BALACCCProgress,
        'value': () => BALACCCvalue,
        'percent': () => BALACCCPercent,
        'setProgress': (v) => BALACCCProgress = v,
        'setValue': (v) => BALACCCvalue = v.toDouble(),
        'setPercent': (v) =>BALACCCPercent = v,
        'typeSyncAll': 108,
        'typeSyncOneTable': 108,
        'saveTmp': () => GetCheckSaveTmp('BAL_ACC_C',TotalBAL_ACC_C),
        'updateOrder': () => Update_SYN_ORD('BAL_ACC_C'),
      },//ارصده الحسابات-اجمالي
      'BAL_ACC_D': {
        'total': TotalBAL_ACC_D,
        'progress': () => BALACCDProgress,
        'value': () => BALACCDvalue,
        'percent': () => BALACCDPercent,
        'setProgress': (v) => BALACCDProgress = v,
        'setValue': (v) => BALACCDvalue = v.toDouble(),
        'setPercent': (v) => BALACCDPercent = v,
        'typeSyncAll': 0,
        'typeSyncOneTable': 0,
        'saveTmp': () => GetCheckSaveTmp('BAL_ACC_D',TotalBAL_ACC_D),
        'updateOrder': () async => {
          await GET_SYN_ORDDelete(),
          await Update_SYN_ORD('BAL_ACC_D'),
          await  DeleteROWIDAll(),
          await DeleteROWIDFAS_ACC_USR(),
          await  UpdateCONFIG('LastSyncDate',DateFormat('dd-MM-yyyy HH:mm:ss').format(DateTime.now())),
          await  UpdateCONFIG('CHIKE_ALL','1'),
          await  UpdateCONFIG('SYST','1'),
          await  GetCheckFAS_ACC_USRData(),
    CHIKE_BACK_MAIN=LoginController().CHIKE_ALL_MAIN,
    LoginController().SET_N_P('CHIKE_ALL_MAIN',1),
    round=false,
    F_ROW_V = 0,
    T_ROW_V = 0,
    F_GUID_V='',
    await Update_SYN_ORD(TAB_N),
    cireclValue =100,
    PercentValue = 100,
    service.invoke("stopService"),
    CheckBAL_ACC_D=-1,
          update(),
    LoginController().BIID_ALL_V=='1'?
    DELETE_BRA_INF():null,
    //CheckAllTmpData(),
    LoginController().Timer_Strat==1 || CHIKE_ALL==0?
    AwaitCheckDataBase():false,
    LoginController().SET_N_P('Timer_Strat',1),

  },
      },//ارصده الحسابات-اجمالي

    };
    var config = typeConfig[TypeGet];
    if (config == null) return;
    int totalRows = config['total'];
    round = totalRows >= ROW_NUM ? (totalRows ~/ ROW_NUM) + 1 : 1;
    F_ROW_V += ROW_NUM;
    T_ROW_V += ROW_NUM;
    CountFor += 1;

    config['setProgress'](F_ROW_V);
    config['setValue'](config['value']() + 1 / round);
    config['setPercent']((config['value']() * 100).toInt());
    update();
    if (CountFor == round || config['progress']() >= totalRows) {
      config['setValue'](1);
      config['setPercent']((config['value']() * 100).toInt());
      config['setProgress'](totalRows);
      CountFor = 0;

      if (!SyncOneTable) {
        cireclValue += ((110 ~/ PercentValuecount)) / 110;
        PercentValue += (200 ~/ PercentValuecount);
        TypeSync = config['typeSyncAll'];
      }
      else {
        cireclValue = 0;
        PercentValue = 0;
        TypeSync = config['typeSyncOneTable'];
      }

      if (totalRows > 0) config['saveTmp']();
      config['updateOrder']();

      F_ROW_V = 1;
      T_ROW_V = ROW_NUM;
      update();
    }
    await loadFromApi();
  }


  @override
  void onClose() {
    // TODO: implement onClose
    round=false;
    super.onClose();
  }

  Future GETMOB_VAR_P(int GETMVID) async {
    var MVVL=await GETMOB_VAR(GETMVID);
    if(MVVL.isNotEmpty){
      if(MVVL.elementAt(0).MVVL.toString()!='null'){
        ROW_NUM=int.parse(MVVL.elementAt(0).MVVL.toString());
        T_ROW_V=int.parse(MVVL.elementAt(0).MVVL.toString());
      }else{
        ROW_NUM=150;
        T_ROW_V=150;
      }
      update();
    }else{
      ROW_NUM=150;
      T_ROW_V=150;
      update();
    }
  }

  @override
  Future<void> onInit() async {
    await GETMOB_VAR_P(1);
    if( LoginController().CHIKE_ALL_MAIN==0 ){
      TypeSync=1;
      TypeSyncAll=1;
      CheckClickAll=true;
      ClickAllOrLastTime=true;
      CheckSync(true);
      Socket_IP();
    }
    await  GET_ROW_NUM();
   // GET_ROW_NUM();
    // await GET_ROW_NUM();
    await DeleteSYN_ORD_NULL();
    await DeleteAllTMP();
    await GET_SYN_ORDDelete();
    await DeleteROWIDAll();
    super.onInit();
  }
}
