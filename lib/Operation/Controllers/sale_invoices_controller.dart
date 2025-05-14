import 'dart:async';
import 'dart:io';
import 'dart:math';
import 'package:barcode_scan2/barcode_scan2.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import '../../Setting/Views/Customers/add_ed_customer.dart';
import '../../Setting/models/eco_acc.dart';
import '../../Setting/models/pay_kin.dart';
import 'package:geolocator/geolocator.dart';
import '../../Operation/Views/SaleInvoices/add_edit_sale_invoice.dart';
import '../../Operation/Views/SaleInvoices/add_edit_sale_order.dart';
import '../../Operation/Views/SaleInvoices/sale_invoice_pay.dart';
import '../../Operation/models/acc_mov_d.dart';
import '../../Operation/models/acc_mov_m.dart';
import '../../Operation/models/bif_mov_a.dart';
import '../../Operation/models/bil_mov_d.dart';
import '../../Operation/models/bil_mov_m.dart';
import '../../PrintFile/Invoice/invoice_view.dart';
import '../../PrintFile/Invoice/invoice_view_thermal.dart';
import '../../PrintFile/Invoice/invoice_view_simple.dart';
import '../../PrintFile/share_mode.dart';
import '../../Setting/controllers/login_controller.dart';
import '../../Setting/controllers/setting_controller.dart';
import '../../Setting/models/acc_ban.dart';
import '../../Setting/models/acc_cas.dart';
import '../../Setting/models/acc_cos.dart';
import '../../Setting/models/bal_acc_c.dart';
import '../../Setting/models/bal_acc_m.dart';
import '../../Setting/models/bif_cus_d.dart';
import '../../Setting/models/bil_cre_c.dart';
import '../../Setting/models/bil_cus.dart';
import '../../Setting/models/bil_dis.dart';
import '../../Setting/models/bil_imp.dart';
import '../../Setting/models/bil_poi.dart';
import '../../Setting/models/bra_inf.dart';
import '../../Setting/models/cou_inf_m.dart';
import '../../Setting/models/cou_tow.dart';
import '../../Setting/models/cou_typ_m.dart';
import '../../Setting/models/cou_wrd.dart';
import '../../Setting/models/list_value.dart';
import '../../Setting/models/mat_des_m.dart';
import '../../Setting/models/mat_fol.dart';
import '../../Setting/models/mat_gro.dart';
import '../../Setting/models/mat_inf.dart';
import '../../Setting/models/mat_inf_d.dart';
import '../../Setting/models/mat_pri.dart';
import '../../Setting/models/mat_uni.dart';
import '../../Setting/models/mat_uni_b.dart';
import '../../Setting/models/mat_uni_c.dart';
import '../../Setting/models/res_emp.dart';
import '../../Setting/models/res_sec.dart';
import '../../Setting/models/res_tab.dart';
import '../../Setting/models/sto_inf.dart';
import '../../Setting/models/sto_num.dart';
import '../../Setting/models/sys_cur.dart';
import '../../Setting/models/sys_cur_bet.dart';
import '../../Setting/models/sys_doc_d.dart';
import '../../Setting/models/sys_own.dart';
import '../../Setting/models/sys_usr.dart';
import '../../Setting/models/sys_var.dart';
import '../../Setting/models/usr_pri.dart';
import '../../Setting/services/fat_mod.dart';
import '../../Setting/services/syncronize.dart';
import '../../Widgets/ES_FAT_PKG.dart';
import '../../Widgets/ES_MAT_PKG.dart';
import '../../Widgets/ES_WS_PKG.dart';
import '../../Widgets/SignatureScreen.dart';
import '../../Widgets/config.dart';
import '../../Widgets/dropdown.dart';
import '../../Widgets/theme_helper.dart';
import '../../database/TreasuryVouchers_db.dart';
import '../../database/database.dart';
import '../../database/invoices_db.dart';
import '../../database/setting_db.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:number_to_character/number_to_character.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';
import 'package:uuid/uuid.dart';
import '../../database/sync_db.dart';
import '../Views/SaleInvoices/add_edit_counter_invoice.dart';
import '../Views/SaleInvoices/get_bil_cus.dart';
import '../Views/SaleInvoices/datagrid_sale_invoice.dart';
import 'package:intl/intl.dart' as intl;
import '../models/bif_eord_m.dart';
import '../models/bif_tra_tbl.dart';

class Sale_Invoices_Controller extends GetxController {
  //AMJAD15
  final formatter = intl.NumberFormat.decimalPattern();
  final DataGridController dataGridController = DataGridController();
  final ES_MAT_PKG ES_MAT = ES_MAT_PKG();
  final typeRep = StteingController().Thermal_printer_paper_size;
  final FocusNode minaFocusNode = FocusNode();
  late FocusNode focusNode;
  Uint8List? signature;
  late FocusNode _autocompleteFocusNode;
  RxBool loading = false.obs,BMATY_SHOW = false.obs,RSID_SHOW = false.obs,
      REID_SHOW = false.obs,RTID_SHOW = false.obs,SHOW_MAT_DES = false.obs;
  bool value = false, edit = false,isTablet= false,
      SHOW_GRO = false, SHOW_ITEM = true, Price_include_Tax = false,
      SEND_SMS = false, isloadingInstallData = false, Serch_MINO = false, Serch_MINA = true,
      Serch_MUBCB = false, Show_Inv_Pay = true,isChecked=false,isChecked2=false,isChecked3=false,
      isCheckedSer=false, PRINT_BALANCE_ALR=false;
  var isloadingvalidator = false.obs, SUM_M, detailsField, detailsMap,selectedRowIndex = (-1).obs;
  late FocusNode myFocusNode;
  late FocusNode myFocusBMMAM;
  RxList<Map> BMMDN_LIST = [
    {"id": '0', "name": 'StringBy_Invoice_level'.tr},
    {"id": '1', "name": 'StringBy_Item_level'.tr}
  ].obs;
  final List GET_TYP_LIST = [
    {'name': 'StrinLocal'.tr, 'id': '1'},
    {'name': 'StrinExternal'.tr, 'id': '2'},
    {'name': 'StrinDelivery'.tr, 'id': '3'},
  ];
  RxnString errorTextBIID = RxnString(null);
  RxnString errorTextCWID = RxnString(null);
  RxnString errorTextSCID = RxnString(null);
  RxnString errorTextPKID = RxnString(null);
  RxnString errorTextBPID = RxnString(null);
  RxnString errorTextCTMID = RxnString(null);
  RxBool loadingerror = false.obs;
  var isloading = false.obs, BDNO_F = 0.0, BDNO_F2 = 0.0, ST_O_N = 2, MSG_O, TOT_NUM = 0.0,
      SNNO_V = 0.0, BMMTX_DAT = '';
  DateTime dateTimeDays = DateTime.now();
  DateTime BMMCD = DateTime.now();
  final now = DateTime.now();
  final formatter2 = DateFormat('yyyy-MM-dd');
  DateTime fromDate = DateTime(2025, 1, 1);
  DateTime toDate = DateTime(2025, 12, 31);
  // GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final String _selectedDatesercher = DateFormat('dd-MM-yyyy').format(DateTime.now());
  final String DateDays_last = DateFormat('dd-MM-yyyy').format(DateTime.now());
  final String selectedDatesercher = DateFormat('dd-MM-yyyy').format(DateTime.now());
  final String BMADD = DateFormat('dd-MM-yyyy HH:mm').format(DateTime.now());
  final String UpdateselectedDate = DateFormat('dd-MM-yyyy hh:mm').format(DateTime.now());
  DateTime dateFromDays1 = DateTime.now();
  DateTime dateFromYear1 = DateTime.now();
  String dateFromDays = DateFormat('dd-MM-yyyy').format(DateTime.now());
  String dateFromYear = DateFormat('yyyy').format(DateTime.now());
  DateTime dateTimeToDays2 = DateTime.now();
  String dateTimeToDays = DateFormat('dd-MM-yyyy').format(DateTime.now());
  String SER_DA = DateFormat('yyyy-MM-dd').format(DateTime.now());
  final ADD_EDformKey = GlobalKey<FormState>();
  FocusNode contentFocusNode = FocusNode();
  final conn = DatabaseHelper.instance;
  var uuid = const Uuid();
  var converter = NumberToCharacterConverter('ar');
  var GUID,
      GUIDD,
      GUIDC,
      GUID_LNK,
      GUID_ACC_M,
      GUIDMT,
      TTIDC1,
      TTIDC2,
      TTIDC3,
      TSDI1 = 2,
      TSDI2 = 2,
      TSDI3 = 2,
      TSFR1 = 2,
      TSFR2 = 2,
      TSFR3 = 2,
      TSQR1 = 2,
      TSQR2 = 2,
      TSQR3 = 2,
      BMMNOR,
      BMMIDR;
  StreamSubscription<Position>? _positionStreamSubscription;
  final GeolocatorPlatform _geolocatorPlatform = GeolocatorPlatform.instance;
  String? SelectDataBIID,
      titleScreen,
      SelectDataSCID,
      SelectDataSCID_S,
      SelectDataPKID,
      SelectDataPKID_S,
      ASK_SAVE,
      SelectDays,
      BMMRD,
      BMMDD,
      SelectDataACNO,
      SelectDataACID,
      SelectDataACID2,
      SMDED,
      SelectDataSIID,
      SelectDataBIID2,
      SelectDataBIID3,
      SelectDataBMMDN,
      SelectDataBDID,
      SelectDataBDID2,
      SelectDataBCID,
      SelectDataBCID2,
      SelectDataBCDID,
      SelectDataBCID3,
      SelectDataMINO,
      SelectDataMINA,
      SelectDataMUID,
      SelectDataMUCNA,
      SelectDataMGNO,
      SelectDataMGNO2,
      SelectDataBMMBR,
      SelectDataABID,
      SelectDataTMTID,
      SelectDataBPID,
      SelectDataSCIDP,
      SelectDataRSID,
      SelectDataRSIDO,
      SelectDataRTID,
      SelectDataRTIDO,
      SelectDataREID,
      SelectDataMDMID,
      SER_MINA = '',
      SelectDataSNED = "01-01-2900",
      SVVL_TAX,
      USE_TX,
      SVVL_NO,
      ALLOW_MPS1,
      P_PRI_COS,
      P_BM_NO,
      P_ZERO,
      USING_TAX_SALES,
      BMMNO,
      View_Tax_number_when_print_Invoices,
      Date_of_Insert_Invoice,
      Sequence_Numbering_of_Invoice,
      When_Repeating_Same_inserted_Items_in_Invoice,
      When_Selling_Items_Lower_Price_than_Cost_Price,
      When_Selling_Expired_Items,
      Use_lowest_selling_price,
      Use_highest_selling_price,
      Serial_Number_V,
      Show_Items,
      Use_delivery_date,
      Allow_give_Free_Quantities,
      Allow_give_Discount,
      Allow_Edit_Sale_Prices,
      Show_DueDate,
      SHOW_BMDED,
      Show_Date_the_Last_Payment,
      SHOW_BDID,
      SHOW_BMDNO,
      calculating_discount,
      Accounting_Effect_of_Branches,
      P_COSS = '5',
      SelectDataBCCID,
      USE_BMDFN,
      SCID2,
      MUST_VERIFY_BMDNO,
      PRINT_INV,
      PRINT_PAY_RET,
      PRINT_PAY,
      PAY_V,
      Print_Balance,
      STNADRAD_REPORT,
      SUMO,
      SCBTY = '/',
      TAX_TYP1,
      TAX_TYP2,
      TAX_TYP3,
      SelectDataGETTYPE,
      BCDID,
      BCDMO,
      GUIDC2,
      SelectDataCWID,
      selectedValue,
      SelectDataCTID,
      SelectDataBAID,
      SelectDataATTID,
      SelectDataBCTID,
      SelectDataBCST,
      SelectDataBCPR,
      SelectDataCTID2,
      SelectDataCWID2,
      SelectDataBAID2,
      DELIVERY_VAR,
      ADDRESS_CUS_REQUEST,
      USE_MULTIPLE_PRINTER,
      RINT_RELATED_ITEMS_DETAIL,
      SelectDataBDID_ORD,
      SelectDataBDID2_ORD,
      BMMDO,
      USING_QUICK_NOTES_FOR_ITEM,
      Allow_Cho_Price = '2',
      Allow_give_Free_Pay_Cash = '1',
      Allow_give_Free_Pay_due = '1',
      Allow_give_Free_Pay_Not_Cash_Due = '1',
      Must_Specify_Location_Invoice = '3',
      Allow_Issuance_Invoice_Distance_Meters = '0',
      Allow_give_discount_Pay_Cash = '1',
      Allow_give_discount_Pay_due = '1',
      Allow_give_discount_Pay_Not_Cash_Due = '1',
      CHK_DIS_ITEM = '2',
      CHK_DIS_INV = '2',
      SHOW_TAB = '1',
      Use_Multi_Stores = '2',
      SIID_V2,
      Show_Items_Expire_Date = '1',
      P_COSM = '1',
      P_COS1 = '2',
      P_COS2 = '2',
      P_COS_SEQ = '2',
      SelectDataRTNA = '',
      SelectDataCTMID,
      SelectDataCTMID2,
      errorText,SelectDays_F,SelectDays_T,selectedBranchFrom,selectedBranchTo;
  String Type = '1',
      SCSY = '',
      SCSY2 = '',
      titleAddScreen = '',
      TextButton_title = '',
      STB_N = '',
      SelectNumberOfDays = '',
      DDSA = '',
      SONA = '',
      SONE = '',
      SORN = '',
      SOLN = '',
      SDDSA = '',
      SDDDA = '',
      PKNA = '',
      MGNA = '',
      MES_ADD_EDIT = '',
      SOTX = '',
      SOAD = '',
      SOBN = '',
      SOSN = '',
      SOQN = '',
      CTID = '',
      CWID = '',
      SOPC = '',
      SOAD2 = '',
      SOTL = '',
      SOC1 = '',
      BCAD = '',
      BCNA = '',
      BCBN = '',
      BCSN = '',
      BCQND = '',
      CWNA = '',
      CTNA = '',
      BCPC = '',
      BCAD2 = '',
      BCTX = '',
      BCTL = '',
      BCC1 = '',
      SUM_STRING_NUMBER = '',
      _scanBarcode = 'Unknown',
      SCNA = '',
      BACBAS = '',
      BACBAR = '',
      BCAD_D = '',
      AMMIN = '',
      Statement_Quotation = '',
      BCLON = '0',
      BCLAT = '0',
      TCSY_D = '',
      TCSY_M = '',
      TCSDSY = '',
      TCSDSY_M = '',
      RSNA_TitleScreen = '',
      TCSY = '',
      TYPE_SHOW = "DateNow",
      distanceStr='',
      BACMN='',
      BACLP='',
      BACLBI='',
      BACLBN='',
      BACLBD='',
      BACBNFN='0',
      BACLU='',
      LastBAL_ACC_C='';
  int
  ADD_T = 1,
      SCSFL = 2,
      SCSFL_TX = 2,
      BMMST = 2,
      BMMFS = 2,
      UPIN_PKID = 1,
      CheckBack = 0,
      COUNT = 0,
      lARGEST_VALUE_QUANTITY = 50,
      lARGEST_VALUE_QUANTITY2 = 50,
      lARGEST_VALUE_PRICE = 5000000,
      lARGEST_VALUE_PRICE2 = 5000000,
      COUNT_SYNC = 0,
      COUNT_MINO = 0,
      COUNT_NO = 0,
      BMMMSLN = 0,
      COUNTRecode_ORD = 0,
      UseSignature = 0,
      ShowSignatureAlert = 0,
      currentIndex=0;

  int? BMKID,
      TCID_D,
      TCID_M,
      TCSDID,
      TCSDID_M,
      ArrLengthCus = 0,
      BMMID_L,
      BMDID_L,
      PKID,
      UPINCUS = 1,
      UPIN_VOU = 1,
      UPIN = 1,
      UPCH = 1,
      UPQR = 1,
      UPDL = 1,
      UPPR = 1,
      BYST = 1,
      MIED = 2,
      BMMID,
      BMDID,
      BMDIDR,
      DEL_SMMID,
      UPIN_USING_TAX_SALES = 1,
      UPIN_SHOW_BMMNO = 1,
      UPIN_PRI_COS = 1,
      Check_PRI_COS,
      UPIN_PRI = 1,
      UPIN_PRINT_AGAIN = 1,
      BMMNO_length,
      Allow_to_Print_Invoice_Once_Again,
      CheckSearech,
      SHOW_COST_PRICE,
      Allow_to_Inserted_Date_of_Sales_Invoices,
      Allowto_Adjust_the_Number_Manual_Sequence_of_Sales_Invoices,
      Allowto_Sell_Less_than_Cost_Price,
      Allow_BMDED,
      Allow_lowest_selling_price,
      Allow_highest_selling_price,
      Allow_Show_Items,
      Allow_Must_Specify_Location_Invoice,
      UPIN_ACCOUNTING_EFFECT,
      UPIN_BMMDI,
      UPIN_EDIT_MPS1 = 1,
      UPIN_Allow_Cho_Price = 1,
      BCPR = 1,
      BCPR2 = 1,
      BCCSP = 1,
      BPPR = 1,
      MIFR = 2,
      UPIN_BMDNF = 1,
      UPIN_Allow_give_Free_Pay_Cash = 1,
      UPIN_Allow_give_discount_Pay_Cash = 1,
      UPIN_Allow_give_Free_Pay_due = 1,
      UPIN_Allow_give_discount_Pay_due = 1,
      UPIN_Allow_give_Free_Pay_Not_Cash_Due = 1,
      UPIN_Allow_give_discount_Pay_Not_Cash_Due = 1,
      UPIN_USE_ACNO = 2,
      UPIN_USE_COS1 = 2,
      UPIN_USE_COS2 = 2,
      MAX_MIN_MUCID = 1,
      MUCID_F,
      MUCID_T,
      MUID,
      MUID_MIN,
      V_FROM,
      V_TO,
      V_KIN,
      MITSK = 0,
      BIIDB,
      MGKI = 1,
      PKID_C = 4,
      BCCT = 1,
      SCID_C,
      PKIDL = 1,
      AMMNO,
      AMMID,
      TTID1,
      TTID2,
      TTID3,
      TSCT1,
      TSCT2,
      TSCT3,
      TSRA1 = 0,
      TSRA2 = 0,
      TSRA3 = 0,
      TSPT1,
      TSPT2,
      TSPT3,
      TCVL = 0,
      TCVL2 = 0,
      TCVL3 = 0,
      TCVL_C = 1,
      TCVL2_C = 1,
      TCVL3_C = 1,
      TCVL_V1 = 1,
      TCVL_V2 = 1,
      BMMTX1,
      BMDTX2,
      AKID = 1,
      AACC = 1,
      BMDTX3,
      TYPE_ORDER = 1,
      TCID,
      TCVL_S,
      TTLID = 0,
      CheckOutTemplate = 0,selectedPaymentMethod,selectedSCIDSER,TYPE_SER=2;
  double? SUMBMDAM,
      SCEX,
      BMDAMT = 0,
      BMDNO_VAL = 0,
      BMDAM_VAL = 0,
      BMDAM1 = 0,
      BMDAM = 0,
      BMDTXAT = 0,
      COUNT_BMMAM = 0,
      BMDTXA_V = 0,
      BMDTXA = 0,
      BMDTXA2 = 0,
      BMDTXA3 = 0,
      SUMBMDDI = 0,
      SUMBMDDIR = 0,
      SUM_Totle_BMDDI = 0,
      BMDNO = 0,
      SUMBMDTXA = 0,
      SUMBMDTXT = 0,
      SUMBMDTXT1 = 0,
      SUMBMDTXT2 = 0,
      SUMBMDTXT3 = 0,
      SUMBMMDIF = 0,
      SUMBMMDI = 0,
      SUM_BMDAM = 0,
      BMDAM2 = 0,
      SUM_BMDAM2 = 0,
      MPS1 = 0,
      MPHP = 0,
      MPLP = 0,
      SCEXS = 0,
      BMDNO_V = 0,
      MPCO = 0,
      BMDDIR = 0,
      COUNTBMDNO = 0,
      SUM_AM_TXT_DI_V = 0,
      BMMAM_TX = 0,
      BMMDI_TX = 0,
      TCAM = 0,
      MUCNO = 0,
      MPCO_V = 0,
      CHIN_NO = 1,
      V_N1 = 0,
      CUS_BAL = 0,
      TOTSUMBMDAM = 0,
      BACBMD = 0,
      BAMMD = 0,
      BAMBA = 0,
      BACBDA = 0,
      BAMDA = 0,
      BACBA = 0,
      BACBNF = 0,
      BCBL = 0,
      SCEX_BET = 0,
      BMMTC = 0,
      BMMTC_TOT = 0,
      SCEXP = 0,
      BMMCP = 0,
      SUM_AM = 0,
      TLRAI = 0,
      BMDTX = 0,
      BMMAMT_RET = 0,
      BMDTXT1 = 0,
      BMDTXT2 = 0,
      BMDTXT3 = 0,
      TCRA = 0,
      TCRA_M = 0,
      BMDDI_TX = 0,
      BMDAM_TX = 0,
      BMDAMT3 = 0,
      BMDNF = 0,
      TCAMT = 0,
      SUMBAL = 0;
  RxDouble? longitude = 0.0.obs;
  RxDouble? latitude = 0.0.obs;
  double distanceInMeters = 0;
  late TextEditingController AANAController,
      AANOController,
      SCNAController,
      SCEXController,
      SCEXSController,
      AMDDAController,
      PKIDController,
      BCCIDController,
      BCCNAController,
      ABIDController,
      ABNAController,
      BCBNController,
      BCONController,
      BMMCNController,
      ACIDController,
      ACNAController,
      UPDATEController,
      AMDMDController,
      BMMINController,
      AMDIDController,
      BMMREController,
      BMMRE2Controller,
      BMMAMController,
      TextEditingSercheController,
      MGNOController,
      MINOController,
      MUIDController,
      BMDNOController,
      BMDNFController,
      BMDEDController,
      BMDAMController,
      BMDAMTXController,
      SUMBMDAMController,
      SUMBMDAMTFController,
      BMDINController,
      BMMDIRController,
      BMMDIController,
      MINAController,
      BMDTXController,
      SIIDController,
      SCIDOController,
      BMDTX2Controller,
      BMDTX3Controller,
      MUCBCController,
      MPCOController,
      MPCO_VController,
      BMDTXAController,
      BMDDIController,
      BMDDIRController,
      SUMBMDAMTController,
      BCNAController,
      BCIDController,
      CIMIDController,
      CTMIDController,
      BMMCRTController,
      BMMTXController,
      BCMOController,
      BMMAMTOTController,
      BMDIDController,
      BMMIDController,
      BMMDDController,
      BMMCDController,
      BMDTXTController,
      BMDDITController,
      MPS1Controller,
      MPS2Controller,
      MPS3Controller,
      MPS4Controller,
      CountRecodeController,
      SUMBMMDIFController,
      COUNTBMDNOController,
      SUMBMDTXTController,
      SCHRController,
      SCLRController,
      SCHRSController,
      SCLRSController,
      BMMCPController,
      BCDNAController,
      BCDMOController,
      BCDSNController,
      BCDBNController,
      BCDFNController,
      BCDADController,
      BMMDRController,
      BMMTNController,
      BMMDEController,
      CTMTYController,
      BMMGRController,
      FromDaysController,
      BCLATController,
      BCLONController,
      ToDaysController;
  late List<Bil_Mov_M_Local> BIL_MOV_M_List = [];
  late List<Bil_Mov_M_Local> RETURN_SALE_INV = [];
  late List<Bil_Mov_M_Local> BIF_MOV_M_List = [];
  late List<Cou_Inf_M_Local> COU_INF_M_List = [];
  late List<Cou_Typ_M_Local> COU_TYP_M_List = [];
  late List<Bil_Cus_Local> BIL_CUS_List = [];
  late List<Bil_Mov_D_Local> InvoiceList = [];
  late List<Bil_Mov_D_Local> InvoiceList_COU = [];
  late List<Bil_Mov_D_Local> BIL_MOV_D_SHOW = [];
  late List<Bil_Mov_M_Local> BIF_MOV_M_PRINT = [];
  late List<Mat_Inf_Local> MAT_INF_DATE = [];
  late List<Bil_Mov_D_Local> cartFood = [];
  late List<Mat_Gro_Local> MAT_GRO = [];
  late List<Mat_Gro_Local> MAT_GRO_LIST = [];
  late List<Res_Sec_Local> RES_SEC = [];
  late List<Res_Tab_Local> RES_TAB = [];
  late List<Res_Emp_Local> RES_EMP = [];
  late List<Pay_Kin_Local> PAY_KIN_LIST = [];
  late List<Mat_Fol_Local> MAT_FOL = [];
  late List<Mat_Des_M_Local> MAT_DES_M = [];
  late List<Sys_Var_Local> SYS_VAR;
  late List<Usr_Pri_Local> USR_PRI;
  late List<Sys_Doc_D_Local> GET_SYS_DOC;
  late List<Sys_Own_Local> SYS_OWN;
  late List<Mat_Inf_Local> autoCompleteData;
  late List<Cou_Typ_M_Local> COU_TYP_M;
  late List<Bif_Cus_D_Local> BIF_CUS_D;
  late List<Mat_Inf_Local> MAT_INF;
  late List<Sto_Num_Local> GET_SNDE;
  late List<Bil_Mov_M_Local> BIL_MOV_M;
  late List<Bil_Mov_D_Local> BIF_MOV_D;
  late List<Mat_Uni_B_Local> MAT_UNI_B;
  late List<Mat_Uni_Local> MAT_UNI;
  late List<Sto_Num_Local> GET_STO_NUM;
  late List<Mat_Pri_Local> MAT_PRI;
  late List<Bil_Cus_Local> BIL_CUS;
  late List<Cou_Wrd_Local> COU_WRD;
  late List<Cou_Tow_Local> COU_TOW;
  late List<Bil_Imp_Local> BIL_IMP;
  late List<Bil_Mov_D_Local> SUM_TOT;
  late List<Bil_Mov_M_Local> SUM_TOT_M;
  late List<Bil_Mov_D_Local> COUNT_RECODE;
  late List<Bil_Mov_D_Local> COUNT_MINO_P;
  late List<Sys_Cur_Local> SYS_CUR;
  late List<Mat_Inf_D_Local> MAT_INF_D;
  late List<Mat_Uni_B_Local> barcodData;
  late List<Mat_Uni_C_Local> MAT_UNI_C;
  late List<Bil_Poi_Local> BOL_POI;
  late List<Sto_Inf_Local> STO_INF;
  late List<Pay_Kin_Local> PAY_KIN = [];
  late List<Bil_Cus_Local> BIL_CUS_P;
  late List<Bra_Inf_Local> BRA_INF;
  late List<Bil_Dis_Local> BIL_DIS;
  late List<Bal_Acc_C_Local> BIL_ACC_C;
  late List<Bal_Acc_M_Local> BAL_ACC_M;
  late List<Sys_Usr_Local> SYS_USR;
  late List<Sys_Cur_Bet_Local> SYS_CUR_BET;
  late List<List_Value> SYS_CUR_BET_AM;
  late List<Acc_Cas_Local> ACC_CAS;
  late List<Acc_Ban_Local> ACC_BAN_List;
  late List<Bil_Cre_C_Local> BIL_CRE_C_List = [];
  late List<Acc_Mov_M_Local> ACC_MOV_M_AMMNO;
  late List<Eco_Acc_Local> ECO_ACC;
  List<String> selectedDetails = [];
  late Bil_Cus_Local item;

  void updateDetailsField() {
    detailsField = selectedDetails.map((detail) => '< $detail >').join(' ');
    update(); // تحديث واجهة المستخدم
  }

  void onInit() async {
    super.onInit();
    if(STMID=='EORD'){
      BMKID = 11;
    }else{
      if (Get.arguments is int) {
        (Get.arguments == 3 || BMKID == 3) ? BMKID = 3
            : (Get.arguments == 1 || BMKID == 1) ? BMKID = 1
            : (Get.arguments == 2 || BMKID == 2) ? BMKID = 2
            : (Get.arguments == 12 || BMKID == 12) ? BMKID = 12
            : (Get.arguments == 4 || BMKID == 4) ? BMKID = 4
            : (Get.arguments == 5 || BMKID == 5) ? BMKID = 5
            : (Get.arguments == 7 || BMKID == 7) ? BMKID = 7
            : (Get.arguments == 10 || BMKID == 10) ? BMKID = 10
            : BMKID = 11;
      }else if (Get.arguments is Map<String, dynamic>) {
        BMKID = 3;
      }
    }


    print('BMKID123');
    print(STMID);
    print(BMKID);

    AANOController = TextEditingController();
    MGNOController = TextEditingController();
    MINOController = TextEditingController();
    MUIDController = TextEditingController();
    BMDNOController = TextEditingController();
    MINAController = TextEditingController();
    BMDNFController = TextEditingController();
    AANAController = TextEditingController();
    SCNAController = TextEditingController();
    SCEXController = TextEditingController();
    AMDDAController = TextEditingController();
    PKIDController = TextEditingController();
    BCCIDController = TextEditingController();
    BCCNAController = TextEditingController();
    BCBNController = TextEditingController();
    BCONController = TextEditingController();
    ABIDController = TextEditingController();
    ABNAController = TextEditingController();
    BMMCNController = TextEditingController();
    ACIDController = TextEditingController();
    ACNAController = TextEditingController();
    UPDATEController = TextEditingController();
    AMDMDController = TextEditingController();
    BMMINController = TextEditingController();
    AMDIDController = TextEditingController();
    BMMREController = TextEditingController();
    BMMRE2Controller = TextEditingController();
    BMMAMController = TextEditingController();
    BMDEDController = TextEditingController();
    BMDAMController = TextEditingController();
    BMDINController = TextEditingController();
    BMMDIRController = TextEditingController();
    BMMDIController = TextEditingController();
    BMDTXController = TextEditingController();
    MUCBCController = TextEditingController();
    MPCOController = TextEditingController();
    MPCO_VController = TextEditingController();
    BMDTXAController = TextEditingController();
    CountRecodeController = TextEditingController();
    TextEditingSercheController = TextEditingController();
    SUMBMDAMController = TextEditingController();
    BMDDIController = TextEditingController();
    BMDDIRController = TextEditingController();
    BCNAController = TextEditingController();
    SUMBMDAMTController = TextEditingController();
    BMMAMTOTController = TextEditingController();
    BMDIDController = TextEditingController();
    BMMIDController = TextEditingController();
    BMMDDController = TextEditingController();
    BMMCDController = TextEditingController();
    SUMBMDAMTFController = TextEditingController();
    BMDTXTController = TextEditingController();
    BMDDITController = TextEditingController();
    MPS1Controller = TextEditingController();
    MPS2Controller = TextEditingController();
    MPS3Controller = TextEditingController();
    MPS4Controller = TextEditingController();
    COUNTBMDNOController = TextEditingController();
    SUMBMMDIFController = TextEditingController();
    SUMBMDTXTController = TextEditingController();
    BCMOController = TextEditingController();
    BMDAMTXController = TextEditingController();
    SCHRController = TextEditingController();
    SCLRController = TextEditingController();
    SCEXSController = TextEditingController();
    SCHRSController = TextEditingController();
    SCLRSController = TextEditingController();
    BMMCPController = TextEditingController();
    BMDTX2Controller = TextEditingController();
    BMDTX3Controller = TextEditingController();
    BCDNAController = TextEditingController();
    BCDMOController = TextEditingController();
    BCDADController = TextEditingController();
    BCDSNController = TextEditingController();
    BCDBNController = TextEditingController();
    BCDFNController = TextEditingController();
    BMMGRController = TextEditingController();
    BMMDRController = TextEditingController();
    BMMDEController = TextEditingController();
    CTMTYController = TextEditingController();
    BCIDController = TextEditingController();
    BMMCRTController = TextEditingController();
    BMMTNController = TextEditingController();
    CIMIDController = TextEditingController();
    BMMTXController = TextEditingController();
    SCIDOController = TextEditingController();
    SIIDController = TextEditingController();
    CTMIDController = TextEditingController();
    FromDaysController = TextEditingController();
    ToDaysController = TextEditingController();
    BCLATController = TextEditingController();
    BCLONController = TextEditingController();
    myFocusNode = FocusNode();
    myFocusBMMAM = FocusNode();
    focusNode = FocusNode();
    _autocompleteFocusNode = FocusNode();
    FromDaysController.text = SER_DA;
    ToDaysController.text = SER_DA;
    GET_USR_PRI();
    GET_BRA_YEA_P();
    SyncBIL_MOV_D_P('SyncOnly', '-1', false, 2);
    GET_BIL_MOV_M_P("DateNow");
    get_RETURN_SALE("DateNow");
    await ES_FAT_PKG.GET_P();
    UpdateDataGUID_P();
    USE_SMDED_P();
    GET_SYS_DOC_D();
    GET_Sys_Own_P(LoginController().BIID.toString());
    Get_Permission_bluetooth();
    GET_COUNT_SYNC();
    GET_PRINT_INV_P();
    GET_TAX_TYP_P();
    GET_P_NO();
    GET_PKID_V();
    GET_PRI_P();
    GET_SHOW_BMMNO();
    GET_PRINT_AGAIN();
    GET_Date_of_Insert_Invoice();
    GET_P_PRI_COS();
    GET_P_BM_NO();
    GET_P_ZERO();
    GET_When_Repeating_Same_inserted_Items_in_Invoice();
    GET_When_Selling_Items_Lower_Price_than_Cost_Price();
    GET_Use_advantage_of_not_exceeding_lowest_selling_price();
    GET_Use_advantage_of_not_exceeding_highest_selling_price();
    GET_When_Selling_Expired_Items();
    GET_USING_TAX_SALES();
    GET_Serial_Number_Mechanism();
    GET_Show_Items();
    GET_Use_delivery_date();
    GET_Allow_give_Free_Quantities();
    GET_Allow_give_Discount();
    GET_Allow_Edit_Sale_Prices();
    GET_Show_DueDate_in_Credit();
    GET_Show_Expire_Date();
    GET_Show_Date_the_Last_Payment();
    GET_SHOW_BDID();
    GET_lARGEST_VALUE_QUANTITY();
    GET_lARGEST_VALUE_PRICE();
    GET_Accounting_Effect_of_Branches();
    GET_USE_BMDFN();
    USE_SCID_P();
    GET_MUST_VERIFY_BMDNO();
    Delete_BIL_Mov_D_DetectApp();
    GET_View_Tax_number_when_print_Invoices();
    GET_Print_Balance();
    GET_PRINT_PAY_RET();
    GET_PAY_RET();
    GET_PRINT_PAY();
    GET_ASK_SAVE_MESSAGE();
    GET_DELIVERY_VAR();
    GET_ADDRESS_CUS_REQUEST();
    GET_USE_MULTIPLE_PRINTER();
    GET_PRINT_RELATED_ITEMS_DETAIL();
    GET_Statement_Quotation();
    GET_SUMO();
    GET_BIF_CUS_D_P();
    GET_Must_Specify_Location_Invoice();
    GET_Allow_Issuance_Invoice_Distance_Meters();
    GET_PRIVLAGECUS();
    GET_Use_Multi_Stores();
    GET_Show_Items_Expire_Date();
    GET_Allow_to_Print_Invoice_Once_Again();
    GET_USE_Cost_Centers();
    GET_USE_Linking_Accounts_Cost_Centers();
    GET_USE_Linking_Income_Accounts_Cost_Centers();
    GET_USE_ACNO();
    GET_COS_SEQ();
    GET_SYS_CUR_SCSFL_TX();
    GET_COU_TYP_M_P();
    GET_COU_TYP_M_ONE_P();
    GET_SYS_CUR_ONE_P_COU();
    GETMOB_VAR_P(21);
    GETMOB_VAR_P(22);
    GET_USE_TAX_P();
    GET_USR_PRI_VOU();
    GET_SYN_ORD_P();
    LoginController().SET_P('Return_Type', '1');
    if (Get.arguments is Map<String, dynamic>) {
    final arguments = Get.arguments as Map<String, dynamic>?;
    if (arguments != null) {
      SelectDataBCID = arguments['BCID']; // قيمة افتراضية إذا لم توجد
      SelectDataBCID2 = arguments['BCID2']; // قيمة افتراضية إذا لم توجد
      item = arguments['item']; // تحويل النوع
    }
     await AddSale_Invoices();
     await _onItemTap(item);
      print('SelectDataBCID');
      print(SelectDataBCID);
    }

  }

  void dispose() {
    super.dispose();
    // TODO: implement dispose
    AANAController.dispose();
    MGNOController.dispose();
    BMDNOController.dispose();
    MINOController.dispose();
    MUIDController.dispose();
    MINAController.dispose();
    BMDNFController.dispose();
    BMDEDController.dispose();
    AANAController.dispose();
    SCNAController.dispose();
    SCEXController.dispose();
    SCEXSController.dispose();
    AMDDAController.dispose();
    PKIDController.dispose();
    BCCIDController.dispose();
    BCCNAController.dispose();
    BCBNController.dispose();
    BCONController.dispose();
    ABIDController.dispose();
    ABNAController.dispose();
    BMMCNController.dispose();
    ACIDController.dispose();
    ACNAController.dispose();
    UPDATEController.dispose();
    AMDMDController.dispose();
    BMMINController.dispose();
    AMDIDController.dispose();
    BMMREController.dispose();
    BMMRE2Controller.dispose();
    BMMAMController.dispose();
    BMDAMController.dispose();
    SUMBMDAMController.dispose();
    BMDINController.dispose();
    BMMDIRController.dispose();
    BMMDIController.dispose();
    BMDTXController.dispose();
    MUCBCController.dispose();
    MPCOController.dispose();
    MPCO_VController.dispose();
    BMDTXAController.dispose();
    BMDDIController.dispose();
    BMDDIRController.dispose();
    SUMBMDAMTController.dispose();
    BCNAController.dispose();
    BMDIDController.dispose();
    CountRecodeController.dispose();
    BMMAMTOTController.dispose();
    BMMIDController.dispose();
    BMMCDController.dispose();
    TextEditingSercheController.dispose();
    BMMDDController.dispose();
    SUMBMDAMTFController.dispose();
    BMDTXTController.dispose();
    BMDDITController.dispose();
    MPS1Controller.dispose();
    MPS2Controller.dispose();
    MPS3Controller.dispose();
    MPS4Controller.dispose();
    SUMBMMDIFController.dispose();
    SUMBMDTXTController.dispose();
    BCMOController.dispose();
    BMDAMTXController.dispose();
    myFocusNode.dispose();
    myFocusBMMAM.dispose();
    SCHRController.dispose();
    SCLRController.dispose();
    SCHRSController.dispose();
    SCLRSController.dispose();
    BMMCPController.dispose();
    BMDTX2Controller.dispose();
    BMDTX3Controller.dispose();
    BCDNAController.dispose();
    BCDMOController.dispose();
    BCDADController.dispose();
    BCDSNController.dispose();
    BCDBNController.dispose();
    BCDFNController.dispose();
    BMMGRController.dispose();
    BMMDRController.dispose();
    BMMDEController.dispose();
    CTMTYController.dispose();
    BCIDController.dispose();
    BMMCRTController.dispose();
    BMMTNController.dispose();
    CIMIDController.dispose();
    SCIDOController.dispose();
    SIIDController.dispose();
    CTMIDController.dispose();
    minaFocusNode.dispose();
    focusNode.dispose();
    FromDaysController.dispose();
    ToDaysController.dispose();
    BCLATController.dispose();
    BCLONController.dispose();
    _autocompleteFocusNode.dispose();
    if(isTablet && STMID=='EORD') {
      SystemChrome.setPreferredOrientations([
        DeviceOrientation.portraitUp,
        DeviceOrientation.portraitDown,
      ]);
    }
  }


  Future<void> selectDateFromDays_F(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate:  dateFromDays1,
      firstDate: DateTime(2000,5),
      lastDate: DateTime(2040),
      builder: (context, child) {
        return   Theme(
          data: ThemeData.light().copyWith(
              primaryColor: const Color(0xFF4A5BF6),
              colorScheme: ColorScheme.fromSwatch(primarySwatch: buttonTextColor).copyWith(secondary: const Color(0xFF4A5BF6))//selection color
          ),
          child: child!,
        );
      },
    );
    if (picked != null) {
      FromDaysController.text =  DateFormat("yyyy-MM-dd").format(picked);
    }
    update();
  }

  Future GET_SYN_ORD_P() async {
    var SYN_ORD=await GET_SYN_ORD('BAL_ACC_C');
    if (SYN_ORD.isNotEmpty) {
      LastBAL_ACC_C = SYN_ORD.elementAt(0).SOLD.toString();
      print('LastBAL_ACC_C');
      print(LastBAL_ACC_C);
    }
  }

  Future<void> selectDateToDays(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: dateTimeToDays2,
      firstDate: DateTime(2000, 5),
      lastDate: DateTime(2040),
      builder: (context, child) {
        return   Theme(
          data: ThemeData.light().copyWith(
              primaryColor: const Color(0xFF4A5BF6),
              colorScheme: ColorScheme.fromSwatch(primarySwatch: buttonTextColor).copyWith(secondary: const Color(0xFF4A5BF6))//selection color
          ),
          child: child!,
        );
      },
    );
    if (picked != null) {
      ToDaysController.text = DateFormat("yyyy-MM-dd").format(picked);
    }
    update();
  }


  Future GETMOB_VAR_P(int GETMVID) async {
    var MVVL = await GETMOB_VAR(GETMVID);
    if (MVVL.isNotEmpty) {
      if (GETMVID == 21) {
        UseSignature = int.parse(MVVL.elementAt(0).MVVL.toString());
      }
      else if (GETMVID == 22) {
        ShowSignatureAlert = int.parse(MVVL.elementAt(0).MVVL.toString());
      }
      ShowSignatureAlert = UseSignature == 0 ? 0 : ShowSignatureAlert;
      update();
    } else {
      if (GETMVID == 21) {
        UseSignature = StteingController().UseSignatureValue == true ? 1 : 0;
      } else if (GETMVID == 22) {
        ShowSignatureAlert =
        StteingController().ShowSignatureAlertValue == true ? 1 : 0;
      }
    }
  }


  //صلاحيات شاشة السندات
  Future GET_USR_PRI_VOU() async {
    await PRIVLAGE(LoginController().SUID, 102).then((data) {
      USR_PRI = data;
      if (USR_PRI.isNotEmpty) {
        UPIN_VOU = USR_PRI
            .elementAt(0)
            .UPIN;
        UPCH = USR_PRI
            .elementAt(0)
            .UPCH;
      }
      else {
        UPIN_VOU = 2;
      }
    });
  }

  Future UpdateDataGUID_P() async {
    await UpdateDataGUID(BMKID == 11 || BMKID == 12 ? 'BIF_MOV_M' : 'BIL_MOV_M');
  }

  //التأكد من السنة المالية من انه فعالة
  Future GET_BRA_YEA_P() async {
    var BRA_YEA=await GET_BRA_YEA(LoginController().JTID, LoginController().BIID,LoginController().SYID);
    if (BRA_YEA.isNotEmpty) {
      BYST = BRA_YEA.elementAt(0).BYST;
    } else {
      BYST = 1;
    }
  }

  //صلاحيات فاتورة
  Future GET_USR_PRI() async {
    PRIVLAGE(LoginController().SUID,
          BMKID == 3 ? 601
        : BMKID == 1 ? 901
        : BMKID == 2 ? 911
        : BMKID == 4 ? 611
        : BMKID == 5 ? 621
        : BMKID == 7 ? 641 :
          BMKID == 10 ? 645 :
          BMKID == 12 ? 2272 : 2207).then((data) {
      USR_PRI = data;
      if (USR_PRI.isNotEmpty) {
        UPIN = USR_PRI
            .elementAt(0)
            .UPIN;
        UPCH = USR_PRI
            .elementAt(0)
            .UPCH;
        UPDL = USR_PRI
            .elementAt(0)
            .UPDL;
        UPPR = USR_PRI
            .elementAt(0)
            .UPPR;
        UPQR = USR_PRI
            .elementAt(0)
            .UPQR;
      } else {
        UPIN = 2;
        UPCH = 2;
        UPDL = 2;
        UPPR = 2;
        UPQR = 2;
      }
    });
  }

  //جلب صلاحية استخدام تاريخ الانتهاء
  Future USE_SMDED_P() async {
   var data =await USE_SMDED();
      if (data.isNotEmpty) {
        SMDED = data.elementAt(0).SVVL.toString();
      } else {
        SMDED = '2';
      }
  }

  //جلب تذلبل المستندات
  Future GET_SYS_DOC_D() async {
    Get_SYS_DOC_D(
        (BMKID == 3 || BMKID == 4 || BMKID == 7 || BMKID == 10) ? 'BO' : (BMKID ==
            1 || BMKID == 2) ? 'BI' : BMKID == 5 ? 'BS' : 'BF',
        BMKID == 3 ? 3 : BMKID == 4 ? 4 : BMKID == 1 ? 1 : BMKID == 2 ? 2 : BMKID == 5 ? 5
            : BMKID == 7 ? 7 : BMKID == 10 ? 10 :
        BMKID == 12 ? 12 : 11,
        LoginController().BIID).then((data) {
      GET_SYS_DOC = data;
      if (GET_SYS_DOC.isNotEmpty) {
        if (GET_SYS_DOC
            .elementAt(0)
            .SDDST1 == 1 &&
            GET_SYS_DOC
                .elementAt(0)
                .SDDDA_D
                .toString()
                .isNotEmpty) {
          SDDDA = GET_SYS_DOC
              .elementAt(0)
              .SDDDA_D
              .toString();
          SDDDA != 'null' ? SDDDA = SDDDA : SDDDA = '';
        } else {
          SDDDA = '';
        }
        if (GET_SYS_DOC
            .elementAt(0)
            .SDDST2 == 1 &&
            GET_SYS_DOC
                .elementAt(0)
                .SDDSA_D
                .toString()
                .isNotEmpty) {
          SDDSA = GET_SYS_DOC
              .elementAt(0)
              .SDDSA_D
              .toString();
          SDDSA != 'null' ? SDDSA = SDDSA : SDDSA = '';
        } else {
          SDDSA = '';
        }
      }
    });
  }

  //جلب بيانات المنشاة
  Future GET_Sys_Own_P(String GETBIID) async {
    SYS_OWN = await GET_SYS_OWN(GETBIID);
    if (SYS_OWN.isNotEmpty) {
      //الاسم يمين
      SONA = SYS_OWN
          .elementAt(0)
          .SONA
          .toString();
      SORN = SYS_OWN
          .elementAt(0)
          .SORN
          .toString();
      //الاسم شمال
      SONE = SYS_OWN
          .elementAt(0)
          .SONE
          .toString();
      SOLN = SYS_OWN
          .elementAt(0)
          .SOLN
          .toString();
      //العنوان
      SOAD = SYS_OWN
          .elementAt(0)
          .SOAD
          .toString();
      //رقم البنايه
      SOBN = SYS_OWN
          .elementAt(0)
          .SOBN == null ? '' : "-${SYS_OWN
          .elementAt(0)
          .SOBN
          .toString()}${SYS_OWN
          .elementAt(0)
          .SOBND
          .toString()}";
      //اسم الشارع
      SOSN = SYS_OWN
          .elementAt(0)
          .SOSN == null ? '' : SYS_OWN
          .elementAt(0)
          .SOSND
          .toString();
      //الحي/المنطقه
      SOQN = SYS_OWN
          .elementAt(0)
          .SOQN == null ? '' : SYS_OWN
          .elementAt(0)
          .SOQND
          .toString();
      //المدينه
      CTID = SYS_OWN
          .elementAt(0)
          .CTID == null ? '' : SYS_OWN
          .elementAt(0)
          .CTNA_D
          .toString();
      //الدوله
      CWID = SYS_OWN
          .elementAt(0)
          .CWID == null ? '' : SYS_OWN
          .elementAt(0)
          .CWNA_D
          .toString();
      //الرمز البريدي
      SOPC = SYS_OWN
          .elementAt(0)
          .SOPC == null ? '' : SYS_OWN
          .elementAt(0)
          .SOPC
          .toString();
      //رقم اضافي للعنوان
      SOAD2 = SYS_OWN
          .elementAt(0)
          .SOAD2 == null ? '' : SYS_OWN
          .elementAt(0)
          .SOAD2
          .toString();
      //رقم تسجيل ضريبة القيمه المضافه
      await GET_TAX_TYP_BRA(GETBIID, '1').then((userList) async {
        if (userList.isNotEmpty) {
          SOTX = userList
              .elementAt(0)
              .TTBTN == null ? '' : userList
              .elementAt(0)
              .TTBTN
              .toString();
        } else {
          SOTX = '';
        }
      });
      SOTX == 'null' || SOTX
          .toString()
          .isEmpty ?
      SOTX = SYS_OWN
          .elementAt(0)
          .SOTX == null ? '' : SYS_OWN
          .elementAt(0)
          .SOTX
          .toString() : '';
      //هاتف
      SOTL = SYS_OWN
          .elementAt(0)
          .SOTL == null ? '' : SYS_OWN
          .elementAt(0)
          .SOTL
          .toString();
      //رقم السجل التجاري
      SOC1 = SYS_OWN
          .elementAt(0)
          .SOC1 == null ? '' : SYS_OWN
          .elementAt(0)
          .SOC1
          .toString();
      //رقم المعرف
//        var IDE_LIN=await GET_IDE_LIN('BRA', SYS_OWN.elementAt(0).BIID);
    }
  }

  //الية طباعة الفواتير
  Future GET_PRINT_INV_P() async {
    GET_SYS_VAR(BMKID == 11 ? 702 : BMKID == 12 ? 718 : 652).then((data) {
      SYS_VAR = data;
      if (SYS_VAR.isNotEmpty) {
        PRINT_INV = SYS_VAR
            .elementAt(0)
            .SVVL
            .toString();
      } else {
        PRINT_INV = '1';
      }
    });
  }

  //لنموذج المعتمد لتقرير فاتورة
  Future GET_STNADRAD_REPORT_P() async {
    GET_SYS_VAR(BMKID == 3 ? 657 : BMKID == 1 ? 658 : 704).then((data) {
      SYS_VAR = data;
      if (SYS_VAR.isNotEmpty) {
        STNADRAD_REPORT = SYS_VAR
            .elementAt(0)
            .SVVL
            .toString();
      } else {
        STNADRAD_REPORT = '1';
      }
    });
  }

  Future GET_USE_TAX_P() async {
    var data = await GET_USE_FAT_P('1', 1);
    if (data.isNotEmpty) {
      USE_TX = data
          .elementAt(0)
          .TVDVL
          .toString();
      print('GET_USE_TAX_P');
      print(data
          .elementAt(0)
          .TVDVL
          .toString());
    } else {
      USE_TX = '2';
    }
  }

  //مع ربط الضريبة بالانظمة جلب انواع الضريبة الفعالة
  Future GET_TAX_TYP_P() async {
    await GET_TAX_TYP(
        (BMKID == 3 || BMKID == 4 || BMKID == 7 || BMKID == 10) ? 'BO' :
        (BMKID == 1 || BMKID == 2)? 'BI' : BMKID == 5 ? 'BS' : 'BF').then((userList) async {
      if (userList.isNotEmpty) {
        for (var i = 0; i < userList.length; i++) {
          try {
            if (TTID1 == null) {
              TTID1 = userList[i].TTID;
              TSCT1 = userList[i].TSCT;
              SVVL_TAX = userList[i].TSCT.toString();
              TSRA1 = userList[i].TSRA;
              TSPT1 = userList[i].TSPT;
              TTIDC1 = userList[i].TTIDC;
              TSDI1 = userList[i].TSDI!;
              TSFR1 = userList[i].TSFR!;
              TSQR1 = userList[i].TSQR!;
              BMDTXController.text = userList[i].TSRA.toString();
              BMDTX = double.parse(userList[i].TSRA.toString());
            } else {
              if (TTID2 == null) {
                TTID2 = userList[i].TTID;
                TSCT2 = userList[i].TSCT;
                TSRA2 = userList[i].TSRA;
                TSPT2 = userList[i].TSPT;
                TTIDC2 = userList[i].TTIDC;
                TSDI2 = userList[i].TSDI!;
                TSFR2 = userList[i].TSFR!;
                TSFR2 = userList[i].TSFR!;
                TSQR2 = userList[i].TSQR!;
                BMDTX2Controller.text =
                userList[i].TTID != null ? userList[i].TSRA.toString() : '0';
                BMDTX = double.parse(userList[i].TTID != null
                    ? userList[i].TSRA.toString()
                    : '0') + double.parse(BMDTXController.text);
              } else {
                if (TTID3 == null) {
                  TTID3 = userList[i].TTID;
                  TSCT3 = userList[i].TSCT;
                  TSRA3 = userList[i].TSRA;
                  TSPT3 = userList[i].TSPT;
                  TTIDC3 = userList[i].TTIDC;
                  TSDI3 = userList[i].TSDI!;
                  TSFR3 = userList[i].TSFR!;
                  TSQR3 = userList[i].TSQR!;
                  BMDTX3Controller.text =
                  userList[i].TTID != null ? userList[i].TSRA.toString() : '0';
                  BMDTX = double.parse(userList[i].TTID != null
                      ? userList[i].TSRA.toString()
                      : '0') +
                      double.parse(BMDTXController.text) +
                      double.parse(BMDTX2Controller.text);
                }
              }
            }
            print('SVVL_TAX');
            print(SVVL_TAX);
          } catch (e, stackTrace) {
            print(e.toString());
            print(stackTrace);
            Fluttertoast.showToast(
                msg: "GET_TAX_TYP_P: ${e.toString()}",
                textColor: Colors.white,
                backgroundColor: Colors.red);
            return Future.error(e);
          }
        }
      } else {
        SVVL_TAX = '2';
        BMDTXController.text = '0';
        BMDTX2Controller.text = '0';
        BMDTX3Controller.text = '0';
      }
    });
  }

  //جلب التصنيف الضريبي الاصناف والمجموعات
  Future GET_TAX_LIN_P(String GETTLTY, String GETTLNO, String GETTLNO2) async {
    await GET_TAX_LIN(BMKID!, TTID1.toString(), GETTLTY, GETTLNO, GETTLNO2).then((userList) async {
      if (userList.isNotEmpty) {
        TCID_D = userList[0].TCID;
        TCSY_D = userList[0].TCSY.toString();
        var TAX_TCSDID = await GET_TAX_TCSDID(
            TTID1.toString(), GETTLTY, GETTLNO, GETTLNO2);
        if (TAX_TCSDID.isNotEmpty) {
          TCSDID = TAX_TCSDID[0].TCSDIDI;

          var TAX_TCSDSY = await GET_TAX_TCSDSY(
              TTID1.toString(), TAX_TCSDID[0].TCSDIDI);
          if (TAX_TCSDSY.isNotEmpty) {
            TCSDSY = TAX_TCSDSY[0].TCSDSY.toString();
            TCVL_V2 = TAX_TCSDSY[0].TCSVL;
          }
        }

        if (BMKID == 1 || BMKID == 2) {
          TCRA = userList.elementAt(0).TLRAI!.toDouble();

          if (TSCT1 == 1) {
            BMDTXController.text = (userList
                .elementAt(0)
                .TLRAI! * userList
                .elementAt(0)
                .TCVL!).toString();
          } else {
            if (userList
                .elementAt(0)
                .TLRAI == 'Z') {
              BMDTXController.text = '0';
            } else {
              BMDTXController.text = (TSRA1! * userList
                  .elementAt(0)
                  .TCVL!).toString();
            }
          }
        }
        else {
          TCRA = userList
              .elementAt(0)
              .TLRAO!
              .toDouble();

          if (TSCT1 == 1) {
            BMDTXController.text = (userList
                .elementAt(0)
                .TLRAO! * userList
                .elementAt(0)
                .TCVL!).toString();
          } else {
            if (userList
                .elementAt(0)
                .TLRAO == 'Z') {
              BMDTXController.text = '0';
            } else {
              BMDTXController.text = (TSRA1! * userList
                  .elementAt(0)
                  .TCVL!).toString();
            }
          }
        }
        TCVL = userList
            .elementAt(0)
            .TCVL! * TCVL_C! * TCVL_V2!;
      }
    });
    if (TTID2 != null) {
      await GET_TAX_LIN(BMKID!, TTID2.toString(), GETTLTY, GETTLNO, GETTLNO2)
          .then((userList) async {
        if (userList.isNotEmpty) {
          if (BMKID == 1 || BMKID == 2) {
            if (TSCT2 == 1) {
              BMDTX2Controller.text =
                  (userList
                      .elementAt(0)
                      .TLRAI! * userList
                      .elementAt(0)
                      .TCVL!)
                      .toString();
            } else {
              if (userList
                  .elementAt(0)
                  .TLRAI == 'Z') {
                BMDTX2Controller.text = '0';
              } else {
                BMDTX2Controller.text =
                    (TSRA2! * userList
                        .elementAt(0)
                        .TCVL!).toString();
              }
            }
          } else {
            if (TSCT2 == 1) {
              BMDTX2Controller.text =
                  (userList
                      .elementAt(0)
                      .TLRAO! * userList
                      .elementAt(0)
                      .TCVL!)
                      .toString();
            } else {
              if (userList
                  .elementAt(0)
                  .TLRAO == 'Z') {
                BMDTX2Controller.text = '0';
              } else {
                BMDTX2Controller.text =
                    (TSRA2! * userList
                        .elementAt(0)
                        .TCVL!).toString();
              }
            }
          }
          TCVL2 = userList
              .elementAt(0)
              .TCVL! * TCVL2_C!;
        }
      });
    }
    else {
      BMDTX2Controller.text = '0';
    }
    if (TTID3 != null) {
      await GET_TAX_LIN(BMKID!, TTID3.toString(), GETTLTY, GETTLNO, GETTLNO2)
          .then((userList) async {
        if (userList.isNotEmpty) {
          if (BMKID == 1 || BMKID == 2) {
            if (TSCT3 == 1) {
              BMDTX3Controller.text =
                  (userList
                      .elementAt(0)
                      .TLRAI! * userList
                      .elementAt(0)
                      .TCVL!)
                      .toString();
            } else {
              if (userList
                  .elementAt(0)
                  .TLRAI == 'Z') {
                BMDTX3Controller.text = '0';
              } else {
                BMDTX3Controller.text =
                    (TSRA3! * userList
                        .elementAt(0)
                        .TCVL!).toString();
              }
            }
          } else {
            if (TSCT3 == 1) {
              BMDTX3Controller.text =
                  (userList
                      .elementAt(0)
                      .TLRAO! * userList
                      .elementAt(0)
                      .TCVL!)
                      .toString();
            } else {
              if (userList
                  .elementAt(0)
                  .TLRAO == 'Z') {
                BMDTX3Controller.text = '0';
              } else {
                BMDTX3Controller.text =
                    (TSRA3! * userList
                        .elementAt(0)
                        .TCVL!).toString();
              }
            }
          }
          TCVL3 = userList
              .elementAt(0)
              .TCVL! * TCVL3_C!;
        }
      });
    }
    else {
      BMDTX3Controller.text = '0';
    }
    print('GET_TAX_LIN_P');
    print(BMDTXController.text);
    print(BMDTX2Controller.text);
    print(BMDTX3Controller.text);
    BMDTX = double.parse(BMDTXController.text) +
        double.parse(BMDTX2Controller.text) +
        double.parse(BMDTX3Controller.text);
  }

  //جلب التصنيف الضريبي والرقم الضريبي للعميل والمورد
  Future GET_TAX_LIN_CUS_IMP_P(String GETTLTY, String GETTLNO,
      String GETTLNO2) async {
    await GET_TAX_LIN(BMKID!, TTID1.toString(), GETTLTY, GETTLNO, GETTLNO2)
        .then((userList) async {
      if (userList.isNotEmpty) {
        BCTX = userList
            .elementAt(0)
            .TLTN
            .toString();
        TCID_M = userList[0].TCID;
        TCSY_M = userList[0].TCSY.toString();
        var TAX_TCSDID_M = await GET_TAX_TCSDID(
            TTID1.toString(), GETTLTY, GETTLNO, GETTLNO2);
        if (TAX_TCSDID_M.isNotEmpty) {
          TCSDID_M = TAX_TCSDID_M[0].TCSDIDI;

          var TAX_TCSDSY = await GET_TAX_TCSDSY(
              TTID1.toString(), TAX_TCSDID_M[0].TCSDIDI);
          if (TAX_TCSDSY.isNotEmpty) {
            TCSDSY_M = TAX_TCSDSY[0].TCSDSY.toString();
          }
        }
        var GET_TCRA = await GET_USE_FAT_P(TTID1.toString(), 2);
        if (GET_TCRA.isNotEmpty) {
          TCRA_M = double.parse(GET_TCRA
              .elementAt(0)
              .TVDVL
              .toString());
        } else {
          TCRA_M = 0;
        }
        if (userList
            .elementAt(0)
            .TCSDIDI != null) {
          await GET_TAX_LIN_CUS(TTID1.toString(), userList
              .elementAt(0)
              .TCSDIDI
              .toString()).then((TAX_LIN_CUS) async {
            if (userList.isNotEmpty) {
              print(TAX_LIN_CUS
                  .elementAt(0)
                  .TCSVL);
              print('TCSVL');
              TCVL_C = TAX_LIN_CUS
                  .elementAt(0)
                  .TCSVL! * userList
                  .elementAt(0)
                  .TCVL!;
            }
            print(TAX_LIN_CUS
                .elementAt(0)
                .TCVL);
            print(TAX_LIN_CUS
                .elementAt(0)
                .TCSVL);
            print(TTID1);
            print(TCVL_C);
            print('GET_TAX_LIN_CUS_IMP_P');
          });
        } else {
          TCVL_C = 1 * userList
              .elementAt(0)
              .TCVL!;
        }
        print('BCTX');
        print(BCTX);
      }
    });
    if (TTID2 != null) {
      await GET_TAX_LIN(BMKID!, TTID2.toString(), GETTLTY, GETTLNO, GETTLNO2)
          .then((userList) async {
        if (userList.isNotEmpty) {
          if (userList
              .elementAt(0)
              .TCSDIDI != null) {
            await GET_TAX_LIN_CUS(TTID1.toString(), userList
                .elementAt(0)
                .TCSDIDI
                .toString()).then((TAX_LIN_CUS) async {
              if (userList.isNotEmpty) {
                TCVL2_C = TAX_LIN_CUS
                    .elementAt(0)
                    .TCSVL! * userList
                    .elementAt(0)
                    .TCVL!;
                print(TAX_LIN_CUS
                    .elementAt(0)
                    .TCSVL);
                print('TCSVL');
              }
            });
          } else {
            TCVL2_C = 1 * userList
                .elementAt(0)
                .TCVL!;
          }
        }
      });
    }
    if (TTID3 != null) {
      await GET_TAX_LIN(BMKID!, TTID3.toString(), GETTLTY, GETTLNO, GETTLNO2)
          .then((userList) async {
        if (userList.isNotEmpty) {
          if (userList
              .elementAt(0)
              .TCSDIDI != null) {
            await GET_TAX_LIN_CUS(TTID1.toString(), userList
                .elementAt(0)
                .TCSDIDI
                .toString()).then((TAX_LIN_CUS) async {
              if (userList.isNotEmpty) {
                TCVL3_C = TAX_LIN_CUS
                    .elementAt(0)
                    .TCSVL! * userList
                    .elementAt(0)
                    .TCVL!;
              }
            });
          } else {
            TCVL3_C = 1 * userList
                .elementAt(0)
                .TCVL!;
          }
        }
      });
    }
  }

  //احتساب ضريبة مبيعات في المبيعات
  Future GET_TAX_INVO() async {
    GET_SYS_VAR(
        BMKID == 3 || BMKID == 4 || BMKID == 5 || BMKID == 7 || BMKID == 10 ? 659
            : (BMKID == 1 || BMKID == 2) ? 660 : 701).then((data) {
      SYS_VAR = data;
      if (SYS_VAR.isNotEmpty) {
        SVVL_TAX = SYS_VAR.elementAt(0).SVVL;
        //SVVL_TAX = '2';
        if (SVVL_TAX == '5') {
          //نسبة الضريبه في فاتورة المبيعات
          GET_SYS_VAR(BMKID == 3 ? 751 : BMKID == 1 ? 752 : 726).then((data) {
            SYS_VAR = data;
            if (SYS_VAR.isNotEmpty) {
              BMDTXController.text = SYS_VAR.elementAt(0).SVVL.toString();
            }
          });
        } else if (SVVL_TAX == '2' || SVVL_TAX == '3' || SVVL_TAX == '4') {
          BMDTXController.text = '0';
        }
      } else {
        SVVL_TAX = '2';
        BMDTXController.text = '0';
      }
    });
  }

  //اظهار الرقم الضريبي عند طباعة الفاتوره
  Future GET_View_Tax_number_when_print_Invoices() async {
    GET_SYS_VAR(BMKID == 11 || BMKID == 12 ? 755 : 727).then((data) {
      SYS_VAR = data;
      if (SYS_VAR.isNotEmpty) {
        View_Tax_number_when_print_Invoices = SYS_VAR
            .elementAt(0)
            .SVVL;
      } else {
        View_Tax_number_when_print_Invoices = '1';
      }
    });
  }

  //تاريخ ادخال حركات الفواتير
  Future GET_Date_of_Insert_Invoice() async {
    GET_SYS_VAR(654).then((data) {
      SYS_VAR = data;
      if (SYS_VAR.isNotEmpty) {
        Date_of_Insert_Invoice = BMKID == 11 || BMKID == 12 ? '2' : SYS_VAR.elementAt(0).SVVL;
        //حسب الصلاحيات
        if (SYS_VAR
            .elementAt(0)
            .SVVL
            .toString() == '4') {
          //السماح بتعديل تاريخ ادخال فواتير المبيعات
          PRIVLAGE(LoginController().SUID,
              BMKID == 3 || BMKID == 4 || BMKID == 5 || BMKID == 7 ||
                  BMKID == 10 ? 732 : 1022).then((data) {
            USR_PRI = data;
            if (USR_PRI.isNotEmpty) {
              Allow_to_Inserted_Date_of_Sales_Invoices = USR_PRI.elementAt(0).UPIN;
            } else {
              Allow_to_Inserted_Date_of_Sales_Invoices = 2;
            }
          });
        }
      } else {
        Date_of_Insert_Invoice = '2';
      }
    });
  }

  //تسلسل/ترقيم حركات الفواتير
  Future GET_Sequence_Numbering_of_Invoice() async {
    GET_SYS_VAR(655).then((data) {
      SYS_VAR = data;
      if (SYS_VAR.isNotEmpty) {
        Sequence_Numbering_of_Invoice = SYS_VAR
            .elementAt(0)
            .SVVL;
        //حسب الصلاحيات
        if (SYS_VAR
            .elementAt(0)
            .SVVL
            .toString() == '4') {
          //السماح بتعديل ترقيم/يدوي لتسلسل فواتير المبيعات
          PRIVLAGE(LoginController().SUID, 733).then((data) {
            USR_PRI = data;
            if (USR_PRI.isNotEmpty) {
              Allowto_Adjust_the_Number_Manual_Sequence_of_Sales_Invoices =
                  USR_PRI
                      .elementAt(0)
                      .UPIN;
            } else {
              Allowto_Adjust_the_Number_Manual_Sequence_of_Sales_Invoices = 2;
            }
          });
        }
      }
    });
  }

  //عند تكرار ادخال نفس الصنف في الفاتوره
  Future GET_When_Repeating_Same_inserted_Items_in_Invoice() async {
    GET_SYS_VAR(BMKID == 11 || BMKID == 12 ? 703 : 656).then((data) {
      SYS_VAR = data;
      if (SYS_VAR.isNotEmpty) {
        When_Repeating_Same_inserted_Items_in_Invoice =
            SYS_VAR.elementAt(0).SVVL;
      } else {
        When_Repeating_Same_inserted_Items_in_Invoice = '1';
      }
    });
  }

  //عند بيع الصنف بسعر اقل من سعر التكلفه
  Future GET_When_Selling_Items_Lower_Price_than_Cost_Price() async {
    GET_SYS_VAR(BMKID == 11 || BMKID == 12 ? 706 : 663).then((data) {
      SYS_VAR = data;
      if (SYS_VAR.isNotEmpty) {
        When_Selling_Items_Lower_Price_than_Cost_Price = SYS_VAR
            .elementAt(0)
            .SVVL;
        //حسب الصلاحيات
        if (SYS_VAR
            .elementAt(0)
            .SVVL
            .toString() == '4') {
          //السماح بالبيع بسعر اقل من سعر التكلفه
          PRIVLAGE(LoginController().SUID, BMKID == 11 || BMKID == 12 ? 2206 : 606).then((data) {
            USR_PRI = data;
            if (USR_PRI.isNotEmpty) {
              Allowto_Sell_Less_than_Cost_Price = USR_PRI
                  .elementAt(0)
                  .UPIN;
            } else {
              Allowto_Sell_Less_than_Cost_Price = 2;
            }
          });
        }
      } else {
        When_Selling_Items_Lower_Price_than_Cost_Price = '1';
      }
    });
  }

  //عند بيع الصنف بسعر اقل من سعر التكلفه في المبيعات الفوريه
  Future GET_P_PRI_COS() async {
    GET_SYS_VAR(706).then((data) {
      SYS_VAR = data;
      if (SYS_VAR.isNotEmpty) {
        P_PRI_COS = SYS_VAR
            .elementAt(0)
            .SVVL;
        if (P_PRI_COS == '4') {
          PRIVLAGE(LoginController().SUID, 2206).then((data) {
            USR_PRI = data;
            if (USR_PRI.isNotEmpty) {
              UPIN_PRI_COS = USR_PRI
                  .elementAt(0)
                  .UPIN;
            } else {
              UPIN_PRI_COS = 2;
            }
          });
        }
      }
    });
  }

  //عند بيع الصنف منتهي تاريخ صلاحيته
  Future GET_When_Selling_Expired_Items() async {
    GET_SYS_VAR(664).then((data) {
      SYS_VAR = data;
      if (SYS_VAR.isNotEmpty) {
        When_Selling_Expired_Items = SYS_VAR
            .elementAt(0)
            .SVVL;
        //حسب الصلاحيات
        if (SYS_VAR
            .elementAt(0)
            .SVVL
            .toString() == '4') {
          //امكانية تحديد تاريخ الانتهاء للاصناف في فاتورة المبيعات
          PRIVLAGE(LoginController().SUID, 2213).then((data) {
            USR_PRI = data;
            if (USR_PRI.isNotEmpty) {
              Allow_BMDED = USR_PRI
                  .elementAt(0)
                  .UPIN;
            } else {
              Allow_BMDED = 2;
            }
          });
        }
      }
    });
  }

  //عنداستخدام ضريبةالمبيعات فإن سعر البيع في الفاتوره يكون
  Future GET_USING_TAX_SALES() async {
    GET_SYS_VAR(
        BMKID == 11 || BMKID == 12 ? 739 : BMKID == 3 || BMKID == 4 ? 772
            : BMKID == 5 ? 773 : 771).then((data) {
      SYS_VAR = data;
      if (SYS_VAR.isNotEmpty) {
        USING_TAX_SALES = TSPT1.toString();
        LoginController().SET_P('USING_TAX_SALES', USING_TAX_SALES.toString());
        if (USING_TAX_SALES == '3') {
          //السماح بتحديد سعرالصنف يشمل الضريبه في الفاتوره
          PRIVLAGE(
              LoginController().SUID,
              BMKID == 11 || BMKID == 12
                  ? 2240
                  : BMKID == 3 || BMKID == 4
                  ? 615
                  : BMKID == 5
                  ? 627
                  : 906).then((data) {
            USR_PRI = data;
            if (USR_PRI.isNotEmpty) {
              UPIN_USING_TAX_SALES = USR_PRI
                  .elementAt(0)
                  .UPIN;
            } else {
              UPIN_USING_TAX_SALES = 2;
            }
          });
        }
      } else {
        USING_TAX_SALES = '2';
      }
    });
  }

  //استخدام ميزة عدم تجاوز اقل سعر بيع في المبيعات.
  Future GET_Use_advantage_of_not_exceeding_lowest_selling_price() async {
    GET_SYS_VAR(BMKID == 11 || BMKID == 12 ? 740 : BMKID == 5 ? 776 : 774)
        .then((data) {
      SYS_VAR = data;
      if (SYS_VAR.isNotEmpty) {
        Use_lowest_selling_price = SYS_VAR.elementAt(0).SVVL;
        //حسب الصلاحيات
        if (SYS_VAR.elementAt(0).SVVL.toString() == '3') {
          //تجاوزأقل سعر بيع في الفاتوره
          PRIVLAGE(LoginController().SUID,
              BMKID == 11 || BMKID == 12 ? 2276 : BMKID == 5 ? 628 : 616).then((
              data) {
            USR_PRI = data;
            if (USR_PRI.isNotEmpty) {
              Allow_lowest_selling_price = USR_PRI
                  .elementAt(0)
                  .UPIN;
            } else {
              Allow_lowest_selling_price = 2;
            }
          });
        }
      } else {
        Use_lowest_selling_price = '2';
      }
    });
  }

  //استخدام ميزة عدم تجاوز اكبر سعر بيع في المبيعات.
  Future GET_Use_advantage_of_not_exceeding_highest_selling_price() async {
    GET_SYS_VAR(
        BMKID == 3 || BMKID == 4 || BMKID == 7 || BMKID == 10 ? 775 : BMKID == 5
            ? 777 : 741).then((data) {
      SYS_VAR = data;
      if (SYS_VAR.isNotEmpty) {
        Use_highest_selling_price = SYS_VAR.elementAt(0).SVVL;
        //حسب الصلاحيات
        if (SYS_VAR.elementAt(0).SVVL.toString() == '3') {
          //تجاوزأعلى سعر بيع في الفاتوره
          PRIVLAGE(LoginController().SUID,
              BMKID == 3 || BMKID == 4 || BMKID == 7 || BMKID == 10 ? 617 :
              BMKID == 5 ? 629 : 2277).then((data) {
            USR_PRI = data;
            if (USR_PRI.isNotEmpty) {
              Allow_highest_selling_price = USR_PRI
                  .elementAt(0)
                  .UPIN;
            } else {
              Allow_highest_selling_price = 2;
            }
          });
        }
      } else {
        Use_highest_selling_price = '2';
      }
    });
  }

  //آلية ترقيم تسلسل حركات فواتير المبيعات/المردود
  Future GET_Serial_Number_Mechanism() async {
    GET_SYS_VAR(669).then((data) {
      SYS_VAR = data;
      if (SYS_VAR.isNotEmpty) {
        Serial_Number_V = SYS_VAR
            .elementAt(0)
            .SVVL;
      }
    });
  }

  //في فاتوره المبيعات يتم اظهار الاصناف التي
  Future GET_Show_Items() async {
    GET_SYS_VAR(BMKID == 3 || BMKID == 4 || BMKID == 5 ? 767 : 719).then((
        data) {
      SYS_VAR = data;
      if (SYS_VAR.isNotEmpty) {
        Show_Items = BMKID == 7 || BMKID == 10 ? '1' : SYS_VAR
            .elementAt(0)
            .SVVL;
        //حسب الصلاحيات
        if (SYS_VAR
            .elementAt(0)
            .SVVL
            .toString() == '3') {
          //اظهار الاصناف المتوفره او الغير متوفره في المخازن
          PRIVLAGE(LoginController().SUID,
              BMKID == 3 || BMKID == 4 || BMKID == 5 ? 610 : 2211).then((data) {
            USR_PRI = data;
            if (USR_PRI.isNotEmpty) {
              Allow_Show_Items = USR_PRI
                  .elementAt(0)
                  .UPIN;
            } else {
              Allow_Show_Items = 2;
            }
          });
        }
      }
    });
  }

  //تعدد المخازن في فاتورة المبيعات
  Future GET_Use_Multi_Stores() async {
    GET_SYS_VAR((BMKID == 1 || BMKID == 2) ? 509 : 508).then((data) {
      if (data.isNotEmpty) {
        Use_Multi_Stores =
        BMKID == 1 || BMKID == 2 || BMKID == 3 || BMKID == 4 ? data.elementAt(0).SVVL : '2';
      } else {
        Use_Multi_Stores = '2';
      }
    });
  }


  //اظهار تاريخ الانتهاء للصنف عند طباعة  فاتورة
  Future GET_Show_Items_Expire_Date() async {
    GET_SYS_VAR(BMKID == 1 || BMKID == 2 ? 683 : 684).then((data) {
      if (data.isNotEmpty) {
        Show_Items_Expire_Date =
        BMKID == 1 || BMKID == 2 || BMKID == 3 || BMKID == 4 || BMKID == 5
            ? data
            .elementAt(0)
            .SVVL
            : '1';
      } else {
        Show_Items_Expire_Date = '1';
      }
    });
  }


  //السماح بطباعة فاتورة مبيعات مره اخرى
  Future GET_Allow_to_Print_Invoice_Once_Again() async {
    PRIVLAGE(LoginController().SUID, 750).then((data) {
      USR_PRI = data;
      if (USR_PRI.isNotEmpty) {
        Allow_to_Print_Invoice_Once_Again = USR_PRI
            .elementAt(0)
            .UPIN;
      } else {
        Allow_to_Print_Invoice_Once_Again = 2;
      }
    });
  }

  //صلاحيات العملاء
  Future GET_PRIVLAGECUS() async {
    PRIVLAGE(LoginController().SUID, 91).then((data) {
      USR_PRI = data;
      if (USR_PRI.isNotEmpty) {
        UPINCUS = USR_PRI
            .elementAt(0)
            .UPIN;
      } else {
        UPINCUS = 2;
      }
    });
  }

  //استخدام تاريخ/موعد التسليم في فاتورة المبيعات
  Future GET_Use_delivery_date() async {
    GET_SYS_VAR(BMKID == 3 || BMKID == 4 || BMKID == 7 || BMKID == 10 ? 436 :
    (BMKID == 1 || BMKID == 2) ? 435
            : BMKID == 5 ? 437 : 438).then((data) {
      SYS_VAR = data;
      if (SYS_VAR.isNotEmpty) {
        Use_delivery_date = SYS_VAR.elementAt(0).SVVL;
      } else {
        Use_delivery_date = '2';
      }
    });
  }

  //فصل تسلسل حركات الفواتير النقد عن الاجل
  Future GET_P_NO() async {
    GET_SYS_VAR(BMKID == 11 || BMKID == 12 ? 601 : 502).then((data) {
      SYS_VAR = data;
      if (SYS_VAR.isNotEmpty) {
        SVVL_NO = SYS_VAR.elementAt(0).SVVL;
      }
    });
  }

  //السماح باعطاء كميات مجانيه في المبيعات
  Future GET_Allow_give_Free_Quantities() async {
    await GET_SYS_VAR(BMKID == 11 || BMKID == 12 ? 602 : BMKID == 7 ? 531 : 514)
        .then((data) {
      SYS_VAR = data;
      if (SYS_VAR.isNotEmpty) {
        Allow_give_Free_Quantities = (BMKID == 1 || BMKID == 2)? '1' : SYS_VAR.elementAt(0).SVVL;
        if (SYS_VAR.elementAt(0).SVVL == '1') {
          //اعطاء كميات مجانيه في المبيعات
          PRIVLAGE(LoginController().SUID, BMKID == 11 || BMKID == 12 ? 2201 : BMKID == 5 ? 622 : 602).
          then((data) {
            USR_PRI = data;
            if (USR_PRI.isNotEmpty) {
              UPIN_BMDNF = (BMKID == 1 || BMKID == 2 )? 1 : USR_PRI.elementAt(0).UPIN;
              if (USR_PRI.elementAt(0).UPIN == 1) {
                //في الفاتورة السماح باعطاء كميات مجانية اذا كان الدفع نقدا
                GET_SYS_VAR(
                    BMKID == 3 || BMKID == 4 || BMKID == 10 ? 567 : BMKID == 5
                        ? 568
                        : BMKID == 7 ? 569 : 592).then((data) {
                  if (data.isNotEmpty) {
                    Allow_give_Free_Pay_Cash = (BMKID == 1 || BMKID == 2) ? '1' :
                    data.elementAt(0).SVVL;
                    if (data.elementAt(0).SVVL == '3') {
                      //السماح باعطاء كميات مجانية اذا كان الدفع نقدا
                      PRIVLAGE(LoginController().SUID,
                          BMKID == 3 || BMKID == 4 || BMKID == 10
                              ? 1854
                              : BMKID == 5 ? 1855
                              : BMKID == 7 ? 1856 : 2342).then((data) {
                        if (data.isNotEmpty) {
                          UPIN_Allow_give_Free_Pay_Cash = (BMKID == 1 || BMKID == 2) ? 1
                              : data.elementAt(0).UPIN;
                        } else {
                          UPIN_Allow_give_Free_Pay_Cash = 2;
                        }
                      });
                    }
                  } else {
                    Allow_give_Free_Pay_Cash = '2';
                  }
                  update();
                });

                //في الفاتورة السماح باعطاء كميات مجانية اذا كان الدفع اجل
                GET_SYS_VAR(
                    BMKID == 3 || BMKID == 4 || BMKID == 10 ? 570 : BMKID == 5
                        ? 571
                        : BMKID == 7 ? 572 : 593).then((data) {
                  if (data.isNotEmpty) {
                    Allow_give_Free_Pay_due = (BMKID == 1 || BMKID == 2) ? '1'
                        : data.elementAt(0).SVVL;
                    if (data.elementAt(0).SVVL == '3') {
                      //السماح باعطاء كميات مجانية اذا كان الدفع اجل
                      PRIVLAGE(LoginController().SUID,
                          BMKID == 3 || BMKID == 4 || BMKID == 10
                              ? 1857
                              : BMKID == 5 ? 1858
                              : BMKID == 7 ? 1859 : 2343).then((data) {
                        if (data.isNotEmpty) {
                          UPIN_Allow_give_Free_Pay_due = (BMKID == 1 || BMKID == 2) ? 1
                              : data.elementAt(0).UPIN;
                        } else {
                          UPIN_Allow_give_Free_Pay_due = 2;
                        }
                      });
                    }
                  } else {
                    Allow_give_Free_Pay_due = '2';
                  }
                  update();
                });

                //في الفاتورة السماح باعطاء كميات مجانية اذا كان الدفع ليس نقدا او اجل
                GET_SYS_VAR(
                    BMKID == 3 || BMKID == 4 || BMKID == 10 ? 573 : BMKID == 5
                        ? 574
                        : BMKID == 7 ? 575 : 594).then((data) {
                  if (data.isNotEmpty) {
                    Allow_give_Free_Pay_Not_Cash_Due = (BMKID == 1 || BMKID==2) ? '1'
                        : data.elementAt(0).SVVL;
                    if (data.elementAt(0).SVVL == '3') {
                      //السماح باعطاء كميات مجانية اذا كان الدفع ليس نقدا او اجل
                      PRIVLAGE(LoginController().SUID,
                          BMKID == 3 || BMKID == 4 || BMKID == 10
                              ? 1860 : BMKID == 5 ? 1861 : BMKID == 7 ? 1862 : 2344).then((data) {
                        if (data.isNotEmpty) {
                          UPIN_Allow_give_Free_Pay_Not_Cash_Due =
                          (BMKID == 1 || BMKID == 2) ? 1 : data.elementAt(0).UPIN;
                        } else {
                          UPIN_Allow_give_Free_Pay_Not_Cash_Due = 2;
                        }
                      });
                    }
                  } else {
                    Allow_give_Free_Pay_Not_Cash_Due = '2';
                  }
                  update();
                });
              }
            } else {
              UPIN_BMDNF = 2;
            }
          });
        }
      } else {
        Allow_give_Free_Quantities = '2';
        Allow_give_Free_Pay_Not_Cash_Due = '2';
        Allow_give_Free_Pay_due = '2';
        Allow_give_Free_Pay_Cash = '2';
      }
      print('GET_Allow_give_Free_Quantities');
      print(Allow_give_Free_Quantities);
      print(Allow_give_Free_Pay_Not_Cash_Due);
      print(Allow_give_Free_Pay_due);
      print(Allow_give_Free_Pay_Cash);
      update();
    });
  }

  //السماح باعطاء تخفيض في الفواتير
  Future GET_Allow_give_Discount() async {
    await GET_SYS_VAR(BMKID == 11 || BMKID == 12 ? 603 : BMKID == 7 ? 532 : 515).then((data) async {
      SYS_VAR = data;
      if (SYS_VAR.isNotEmpty) {
        Allow_give_Discount = SYS_VAR.elementAt(0).SVVL;
        update();
        if (SYS_VAR.elementAt(0).SVVL == '1') {
          await PRIVLAGE(LoginController().SUID,
              BMKID == 3 || BMKID == 4 || BMKID == 7 || BMKID == 10
                  ? 603
                  : BMKID == 5 ? 623 : 2202).then((data) async {
            USR_PRI = data;
            if (USR_PRI.isNotEmpty) {
              UPIN_BMMDI = BMKID == 1 ? 1 : USR_PRI.elementAt(0).UPIN;
            } else {
              UPIN_BMMDI = 2;
            }
          });

          if (UPIN_BMMDI == 1) {
            //في الفاتورة السماح باعطاء تخفيض اذا كان الدفع نقدا
            await GET_SYS_VAR(
                BMKID == 3 || BMKID == 4 || BMKID == 10 ? 576 : BMKID == 5 ||
                    BMKID == 6 ? 577 : BMKID == 7 ? 578 : 595).then((
                data) async {
              if (data.isNotEmpty) {
                Allow_give_discount_Pay_Cash = (BMKID == 1 || BMKID==2) ? '1'
                    : data.elementAt(0).SVVL.toString();
                if (data.elementAt(0).SVVL == '3') {
                  //السماح باعطاء تخفيض اذا كان الدفع نقدا
                  await PRIVLAGE(LoginController().SUID,
                      BMKID == 3 || BMKID == 4 || BMKID == 10 ? 1863 :
                      BMKID == 5 || BMKID == 6 ? 1864 : BMKID == 7
                          ? 1865 : 2345).then((data) {
                    if (data.isNotEmpty) {
                      UPIN_Allow_give_discount_Pay_Cash = (BMKID == 1 || BMKID == 2) ? 1
                          : data.elementAt(0).UPIN;
                    } else {
                      UPIN_Allow_give_discount_Pay_Cash = 2;
                    }
                  });
                }
              } else {
                Allow_give_discount_Pay_Cash = '2';
              }
              update();
            });
            update();
            //في الفاتورة السماح باعطاء تخفيض اذا كان الدفع اجل
            await GET_SYS_VAR(
                BMKID == 3 || BMKID == 4 || BMKID == 10 ? 579 : BMKID == 5 ||
                    BMKID == 6 ? 580 : BMKID == 7 ? 581 : 596).then((
                data) async {
              if (data.isNotEmpty) {
                Allow_give_discount_Pay_due =( BMKID == 1 || BMKID == 2) ? '1'
                    : data.elementAt(0).SVVL;
                if (data.elementAt(0).SVVL == '3') {
                  //السماح باعطاء تخفيض اذا كان الدفع اجل
                  await PRIVLAGE(LoginController().SUID,
                      BMKID == 3 || BMKID == 4 || BMKID == 10 ? 1866 :
                      BMKID == 5 || BMKID == 6 ? 1867 : BMKID == 7
                          ? 1868 : 2346).then((data) {
                    if (data.isNotEmpty) {
                      UPIN_Allow_give_discount_Pay_due = (BMKID == 1 || BMKID == 2) ? 1 : data.elementAt(0).UPIN;
                    } else {
                      UPIN_Allow_give_discount_Pay_due = 2;
                    }
                  });
                }

              } else {
                Allow_give_discount_Pay_due = '2';
              }
              update();
            });
            update();
            //في الفاتورة السماح باعطاء كميات مجانية اذا كان الدفع ليس نقدا او اجل
            await GET_SYS_VAR(
                BMKID == 3 || BMKID == 4 || BMKID == 10 ? 582 : BMKID == 5 ||
                    BMKID == 6 ? 583 : BMKID == 7 ? 584 : 597).then((
                data) async {
              if (data.isNotEmpty) {
                Allow_give_discount_Pay_Not_Cash_Due = (BMKID == 1 || BMKID == 2)? '1'
                    : data.elementAt(0).SVVL;
                if (data.elementAt(0).SVVL == '3') {
                  //السماح باعطاء تخفيض اذا كان الدفع ليس نقدا او اجل
                  await PRIVLAGE(LoginController().SUID,
                      BMKID == 3 || BMKID == 4 || BMKID == 10 ? 1869 :
                      BMKID == 5 || BMKID == 6 ? 1870 : BMKID == 7
                          ? 1871
                          : 2347).then((data) {
                    if (data.isNotEmpty) {
                      UPIN_Allow_give_discount_Pay_Not_Cash_Due = (BMKID == 1 || BMKID == 2)
                          ? 1 : data.elementAt(0).UPIN;
                    } else {
                      UPIN_Allow_give_discount_Pay_Not_Cash_Due = 2;
                    }
                  });
                }
              } else {
                Allow_give_discount_Pay_Not_Cash_Due = '2';
              }
              update();
            });
            update();
          }

          print('GET_Allow_give_Discount');
          print(UPIN_BMMDI);
          print(Allow_give_Discount);
          print(Allow_give_discount_Pay_Cash);
          print(Allow_give_discount_Pay_due);
          print(Allow_give_discount_Pay_Not_Cash_Due);
        }
      } else {
        if (LoginController().SUID == '1') {
          Allow_give_Discount = '1';
          Allow_give_discount_Pay_Cash = '1';
          Allow_give_discount_Pay_due = '1';
          Allow_give_discount_Pay_Not_Cash_Due = '1';
          UPIN_BMMDI = 1;
        } else {
          Allow_give_Discount = '2';
          Allow_give_discount_Pay_Cash = '2';
          Allow_give_discount_Pay_due = '2';
          Allow_give_discount_Pay_Not_Cash_Due = '2';
          UPIN_BMMDI = 2;
        }
      }
    });
  }

  //السماح بتعديل سعر البيع
  Future GET_Allow_Edit_Sale_Prices() async {
    var SYS_VAR = await GET_SYS_VAR(
        BMKID == 3 || BMKID == 4 || BMKID == 5 || BMKID == 7 || BMKID == 10
            ? 516 : 604);
    if (SYS_VAR.isNotEmpty) {
      Allow_Edit_Sale_Prices = (BMKID == 1 || BMKID == 2) ? '1' : SYS_VAR.elementAt(0).SVVL;
      if (SYS_VAR.elementAt(0).SVVL == '1') {
        var USR_PRI = await PRIVLAGE(LoginController().SUID,
            BMKID == 3 || BMKID == 4 || BMKID == 7 || BMKID == 10
                ? 605
                : BMKID == 5 ? 625 : 2204);
        print('Allow_Edit_Sale_Prices3');
        print(USR_PRI);
        if (USR_PRI.isNotEmpty) {
          UPIN_EDIT_MPS1 = (BMKID == 1 || BMKID == 2) ? 1 : USR_PRI.elementAt(0).UPIN!;
          Allow_Cho_Price = USR_PRI.elementAt(0).UPIN.toString();
          update();
        }
        else {
          UPIN_EDIT_MPS1 = 2;
          update();
        }
      }
      else {
        await GET_SYS_VAR(
            BMKID == 3 || BMKID == 4 || BMKID == 10 ? 564 : BMKID == 5 ||
                BMKID == 6 ? 565 :
            BMKID == 7 ? 566 : 591).then((data) {
          if (data.isNotEmpty) {
            Allow_Cho_Price = (BMKID == 1 || BMKID==2) ? '1' : data.elementAt(0).SVVL.toString();
            if (data.elementAt(0).SVVL == '3') {
              PRIVLAGE(LoginController().SUID,
                  BMKID == 3 || BMKID == 4 || BMKID == 10 ? 1851 : BMKID == 5 ||
                      BMKID == 6 ? 1852
                      : BMKID == 7 ? 1853 : 2341).then((data) {
                USR_PRI = data;
                if (USR_PRI.isNotEmpty) {
                  UPIN_Allow_Cho_Price = (BMKID == 1 || BMKID==2) ? 1 : USR_PRI.elementAt(0).UPIN!;
                  update();
                } else {
                  UPIN_Allow_Cho_Price = 2;
                  update();
                }
              });
            }
            update();
          } else {
            Allow_Cho_Price = '2';
            update();
          }
        });
      }
    }
    else {
      Allow_Edit_Sale_Prices = '1';
      Allow_Cho_Price = '2';
    }
  }

  //اظهار تاريخ الاستحقاق في فاتورة المبيعات الاجل
  Future GET_Show_DueDate_in_Credit() async {
    GET_SYS_VAR(BMKID == 3 || BMKID == 4 || BMKID == 5 ? 533 : 534).then((
        data) {
      SYS_VAR = data;
      if (SYS_VAR.isNotEmpty) {
        Show_DueDate = SYS_VAR
            .elementAt(0)
            .SVVL;
      } else {
        Show_DueDate = '2';
      }
    });
  }

  //اظهار تاريخ الانتهاء في فاتورة المبيعات
  Future GET_Show_Expire_Date() async {
    GET_SYS_VAR(BMKID == 3 || BMKID == 4 || BMKID == 5 ? 538 : 539).then((
        data) {
      SYS_VAR = data;
      if (SYS_VAR.isNotEmpty) {
        SHOW_BMDED = SYS_VAR
            .elementAt(0)
            .SVVL;
      }
    });
  }

  //اظهار تاريخ آخر سداد في فاتورة المبيعات الاجل
  Future GET_Show_Date_the_Last_Payment() async {
    GET_SYS_VAR(537).then((data) {
      SYS_VAR = data;
      if (SYS_VAR.isNotEmpty) {
        Show_Date_the_Last_Payment = SYS_VAR
            .elementAt(0)
            .SVVL;
      }
    });
  }

  //ضرورة تحديد المندوب/الموزع عند ادخال فاتورة مبيعات
  Future GET_SHOW_BDID() async {
    GET_SYS_VAR(
        BMKID == 3 || BMKID == 4 || BMKID == 7 || BMKID == 10 ? 692 : (BMKID == 1 || BMKID == 2)
            ? 691 : BMKID == 5 ? 693 : 737).then((data) {
      SYS_VAR = data;
      if (SYS_VAR.isNotEmpty) {
        SHOW_BDID = SYS_VAR.elementAt(0).SVVL;
      }
    });
  }

  //في فاتورة المبيعات عند استخدام الضريبه فأن الية احتساب الخصم
  Future GET_When_using_Tax_method_for_calculating_discount() async {
    GET_SYS_VAR(5032).then((data) {
      SYS_VAR = data;
      if (SYS_VAR.isNotEmpty) {
        calculating_discount = SYS_VAR
            .elementAt(0)
            .SVVL;
      }
    });
  }

  //اكبر قيمه لحقل الكميه في الفاتوره ولا يمكن تجاوزه-للاصناف المخزنيه
  Future GET_lARGEST_VALUE_QUANTITY() async {
    GET_SYS_VAR(5041).then((data) {
      SYS_VAR = data;
      if (SYS_VAR.isNotEmpty) {
        lARGEST_VALUE_QUANTITY = int.parse(SYS_VAR
            .elementAt(0)
            .SVVL
            .toString());
      }
    });
    GET_SYS_VAR(5043).then((data) {
      SYS_VAR = data;
      if (SYS_VAR.isNotEmpty) {
        lARGEST_VALUE_QUANTITY2 = int.parse(SYS_VAR
            .elementAt(0)
            .SVVL
            .toString());
      }
    });
  }

  //اكبر قيمه لحقل السعر في الفاتوره ولا يمكن تجاوزه-للاصناف المخزنيه
  Future GET_lARGEST_VALUE_PRICE() async {
    GET_SYS_VAR(5042).then((data) {
      SYS_VAR = data;
      if (SYS_VAR.isNotEmpty) {
        lARGEST_VALUE_PRICE = int.parse(SYS_VAR
            .elementAt(0)
            .SVVL
            .toString());
      } else {
        lARGEST_VALUE_PRICE = 0;
      }
    });
    GET_SYS_VAR(5044).then((data) {
      SYS_VAR = data;
      if (SYS_VAR.isNotEmpty) {
        lARGEST_VALUE_PRICE2 = int.parse(SYS_VAR
            .elementAt(0)
            .SVVL
            .toString());
      }
    });
  }

  //بيان عرض السعر
  Future GET_Statement_Quotation() async {
    GET_SYS_VAR(667).then((data) {
      SYS_VAR = data;
      if (SYS_VAR.isNotEmpty) {
        Statement_Quotation = SYS_VAR
            .elementAt(0)
            .SVVL
            .toString();
      } else {
        Statement_Quotation = '';
      }
    });
  }

  //في فاتورة المبيعات يكون التأثير المحاسبي للحساب على الفروع بـ
  Future GET_Accounting_Effect_of_Branches() async {
    GET_SYS_VAR(
        BMKID == 3 || BMKID == 4 || BMKID == 7 || BMKID == 10 ? 403 : (BMKID == 1 || BMKID==2)
            ? 402 : BMKID == 5 ? 404 : 405).then((data) {
      SYS_VAR = data;
      if (SYS_VAR.isNotEmpty) {
        Accounting_Effect_of_Branches = SYS_VAR
            .elementAt(0)
            .SVVL;
        SYS_VAR
            .elementAt(0)
            .SVVL == '1' ? SelectDataBMMBR = '1' : SYS_VAR
            .elementAt(0)
            .SVVL == '2' ? SelectDataBMMBR = '2' : SelectDataBMMBR = '1';
        print(SelectDataBMMBR);
        if (Accounting_Effect_of_Branches == '4') {
          //تعديل الية تاثير الحساب على الفروع في الشاشه
          PRIVLAGE(LoginController().SUID,
              BMKID == 3 || BMKID == 4 || BMKID == 7 || BMKID == 10
                  ? 640
                  : (BMKID == 1  || BMKID == 2) ? 908
                  : BMKID == 5 ? 635 : 2352).then((data) {
            USR_PRI = data;
            if (USR_PRI.isNotEmpty) {
              UPIN_ACCOUNTING_EFFECT = USR_PRI
                  .elementAt(0)
                  .UPIN;
            } else {
              UPIN_ACCOUNTING_EFFECT = 2;
            }
          });
        }
      } else {
        SelectDataBMMBR = '1';
      }
    });
  }


//------------مراكز التكلفة------------

  // هل يتم استخدام مراكز التكلفة بشكل عام
  Future GET_USE_Cost_Centers() async {
    var data = await GET_SYS_VAR(351);
    if (data.isNotEmpty) {
      P_COSM = data
          .elementAt(0)
          .SVVL!;
    } else {
      P_COSM = '2';
    }
    print('P_COSM : ${P_COSM}');
  }

  Future GET_USE_Linking_Accounts_Cost_Centers() async {
    await GET_SYS_VAR(352).then((data) {
      SYS_VAR = data;
      if (SYS_VAR.isNotEmpty) {
        P_COS1 = SYS_VAR
            .elementAt(0)
            .SVVL
            .toString();
        if (SYS_VAR
            .elementAt(0)
            .SVVL
            .toString() == '4') {
          //تحديد/عدم تحديد مركز التكلفه لحسابات القوائم الماليه في الحركه
          PRIVLAGE(LoginController().SUID, 57).then((data) {
            USR_PRI = data;
            if (USR_PRI.isNotEmpty) {
              UPIN_USE_COS1 = USR_PRI
                  .elementAt(0)
                  .UPIN;
            } else {
              UPIN_USE_COS1 = 2;
            }
          });
        }
      } else {
        P_COS1 = '2';
      }
    });
    print('P_COS1 : ${P_COS1}');
  }

  //ربط حسابات قائمة الدخل-الارباح,المتاجره بمراكز التكلفه
  Future GET_USE_Linking_Income_Accounts_Cost_Centers() async {
    await GET_SYS_VAR(353).then((data) {
      SYS_VAR = data;
      if (SYS_VAR.isNotEmpty) {
        P_COS2 = SYS_VAR
            .elementAt(0)
            .SVVL
            .toString();
        if (SYS_VAR
            .elementAt(0)
            .SVVL
            .toString() == '4') {
          //تحديد/عدم تحديد مركز التكلفه لحسابات قائمة الدخل في الحركه
          PRIVLAGE(LoginController().SUID, 58).then((data) {
            USR_PRI = data;
            if (USR_PRI.isNotEmpty) {
              UPIN_USE_COS2 = USR_PRI
                  .elementAt(0)
                  .UPIN;
            } else {
              UPIN_USE_COS2 = 2;
            }
          });
        }
      } else {
        P_COS2 = '2';
      }
    });
    print('P_COS2 : ${P_COS2}');
  }

  //استخدام مراكز تكلفه في فاتورة المبيعات
  Future GET_USE_ACNO() async {
    GET_SYS_VAR(BMKID == 1 ? 507 : BMKID == 5 || BMKID == 6 ? 530 : 506).then((
        data) {
      SYS_VAR = data;
      if (SYS_VAR.isNotEmpty) {
        P_COSS = BMKID == 7 || BMKID == 10 || BMKID == 11 || BMKID == 12 ? '2'
            : SYS_VAR.elementAt(0).SVVL;
        if (P_COSS == '4') {
          //حسب الصلاحيات
          PRIVLAGE(LoginController().SUID,
              (BMKID == 1 || BMKID == 2 )? 954 : BMKID == 5 || BMKID == 6 ? 637 : 664).then((data) {
            USR_PRI = data;
            if (USR_PRI.isNotEmpty) {
              UPIN_USE_ACNO = USR_PRI.elementAt(0).UPIN;
            } else {
              UPIN_USE_ACNO = 2;
            }
          });
          UPIN_USE_ACNO == 1 ? P_COSS = '4' : P_COSS = '5';
        }
      } else {
        P_COSS = '5';
      }
      print('P_COSS : ${P_COSS}');
    });
  }

  //تسلسل الحركة حسب مراكز التكلفة في الشاشة
  Future GET_COS_SEQ() async {
    GET_SYS_VAR((BMKID == 1 || BMKID == 2) ? 607 : (BMKID == 5 || BMKID == 6) ? 671 : 669).then((data) {
      SYS_VAR = data;
      if (data.isNotEmpty) {
        P_COS_SEQ = data.elementAt(0).SVVL!;
        P_COS_SEQ == '4' ? P_COS_SEQ = '1' : P_COS_SEQ = '2';
      } else {
        P_COS_SEQ = '2';
      }
       SET_COS();
    });
  }

  Future SET_COS() async {
    if (P_COSM != '1') {
      P_COS_SEQ = '2';
      P_COS1 = '5';
      P_COS2 = '5';
      P_COSS = '5';
      print('SET_COS');
      print('P_COS_SEQ : ${P_COS_SEQ}');
      print('P_COS1 : ${P_COS1}');
      print('P_COS2 : ${P_COS2}');
      print('P_COSS : ${P_COSS}');
      print('SET_COS');
      update();
    }
  }

  // نوع الحساب اذا كان 1 قائمة مركز مالي و 2 قائمة دخل
  GET_AKID_P() async {
    GET_AKID(AANOController.text.toString()).then((data) {
      if (data.isEmpty) {
        AKID = 1;
        AACC = 1;
      } else {
        AKID = data
            .elementAt(0)
            .AKID!;
        AACC = data
            .elementAt(0)
            .AACC!;
        update();
      }
    });
    update();
  }

  //------------مراكز التكلفة------------

  //في فاتورة المبيعات الكميه المجانيه للمنتج/الخدمه تكون
  Future GET_USE_BMDFN() async {
    GET_SYS_VAR(
        BMKID == 3 || BMKID == 4 || BMKID == 7 || BMKID == 10 ? 431 :
        (BMKID == 1 || BMKID == 2) ? 430 : BMKID == 5 ? 432 : 433).then((data) {
      SYS_VAR = data;
      if (SYS_VAR.isNotEmpty) {
        USE_BMDFN = SYS_VAR.elementAt(0).SVVL;
      } else {
        USE_BMDFN = '1';
      }
    });
  }

  //يجب التحقق من توفر الكميه المباعه للصنف عند ادخال فاتورة مبيعات فوريه
  Future GET_MUST_VERIFY_BMDNO() async {
    GET_SYS_VAR(717).then((data) {
      SYS_VAR = data;
      if (SYS_VAR.isNotEmpty) {
        MUST_VERIFY_BMDNO = SYS_VAR
            .elementAt(0)
            .SVVL;
      } else {
        MUST_VERIFY_BMDNO = '1';
      }
    });
  }

  //البيع بطريقة الاجل في المبيعات
  Future GET_PKID_V() async {
    PRIVLAGE(LoginController().SUID,
        BMKID == 3 || BMKID == 4 || BMKID == 7 || BMKID == 10 ? 604 : (BMKID == 1 || BMKID==2)
            ? 904 : BMKID == 5 ? 624 : 2203).then((data) {
      USR_PRI = data;
      if (USR_PRI.isNotEmpty) {
        UPIN_PKID = USR_PRI.elementAt(0).UPIN!;
        update();
      } else {
        UPIN_PKID = 2;
        update();
      }
    });
  }

  //الاستعلام عن سعر التكلفه للاصناف
  Future GET_PRI_P() async {
    PRIVLAGE(LoginController().SUID, 1293).then((data) {
      USR_PRI = data;
      if (USR_PRI.isNotEmpty) {
        UPIN_PRI = USR_PRI
            .elementAt(0)
            .UPIN;
      } else {
        UPIN_PRI = 2;
      }
    });
  }

  //السماح بطباعة فاتورة مبيعات مره اخرى
  Future GET_PRINT_AGAIN() async {
    PRIVLAGE(LoginController().SUID, 750).then((data) {
      USR_PRI = data;
      if (USR_PRI.isNotEmpty) {
        UPIN_PRINT_AGAIN = USR_PRI
            .elementAt(0)
            .UPIN;
      } else {
        UPIN_PRINT_AGAIN = 2;
      }
    });
  }

  //آلية ترقيم تسلسل حركة الفواتير الفوريه
  Future GET_P_BM_NO() async {
    GET_SYS_VAR(711).then((data) {
      SYS_VAR = data;
      if (SYS_VAR.isNotEmpty) {
        P_BM_NO = SYS_VAR
            .elementAt(0)
            .SVVL;
      }
    });
  }

  //الفتره الزمنيه التي يتم خلالها تصفير مسلسل الحركات والبدء بترقيم جديد -1- للفواتير الفوريه
  Future GET_P_ZERO() async {
    GET_SYS_VAR(712).then((data) {
      SYS_VAR = data;
      if (SYS_VAR.isNotEmpty) {
        P_ZERO = SYS_VAR
            .elementAt(0)
            .SVVL;
      }
    });
  }

  //جلب عملة المخزون
  Future USE_SCID_P() async {
    GET_SYS_VAR(952).then((data) {
      SYS_VAR = data;
      if (SYS_VAR.isNotEmpty) {
        SCID2 = SYS_VAR
            .elementAt(0)
            .SVVL
            .toString();
        //سعر الصرف لعملة المخزون
        GET_SYS_CUR_ONE_P(SYS_VAR
            .elementAt(0)
            .SVVL
            .toString()).then((data) {
          SYS_CUR = data;
          if (SYS_CUR.isNotEmpty) {
            SCEXS = SYS_CUR
                .elementAt(0)
                .SCEX;
            SCEXSController.text = SYS_CUR
                .elementAt(0)
                .SCEX
                .toString();
            SCLRSController.text = SYS_CUR
                .elementAt(0)
                .SCLR
                .toString();
            SCHRSController.text = SYS_CUR
                .elementAt(0)
                .SCHR
                .toString();
          }
        });
      } else {
        SCID2 = '1';
        GET_SYS_CUR_ONE_P('1').then((data) {
          SYS_CUR = data;
          if (SYS_CUR.isNotEmpty) {
            SCEXS = SYS_CUR
                .elementAt(0)
                .SCEX;
            SCEXSController.text = SYS_CUR
                .elementAt(0)
                .SCEX
                .toString();
            SCLRSController.text = SYS_CUR
                .elementAt(0)
                .SCLR
                .toString();
            SCHRSController.text = SYS_CUR
                .elementAt(0)
                .SCHR
                .toString();
          }
        });
      }
    });
  }


  Future Get_Permission_bluetooth() async {
    var status = await Permission.bluetooth.status;
    if (!status.isGranted) {
      await Permission.bluetoothConnect.request();
    }
  }

  //الاطلاع على الكميه المخزنيه للاصناف
  Future GET_SHOW_BMMNO() async {
    PRIVLAGE(LoginController().SUID, 2227).then((data) {
      USR_PRI = data;
      if (USR_PRI.isNotEmpty) {
        UPIN_SHOW_BMMNO = USR_PRI
            .elementAt(0)
            .UPIN;
      } else {
        UPIN_SHOW_BMMNO = 2;
      }
    });
  }

  //طباعة رصيد العميل بعد كل فاتوره
  Future GET_Print_Balance() async {
    GET_SYS_VAR(668).then((data) {
      SYS_VAR = data;
      if (SYS_VAR.isNotEmpty) {
        Print_Balance = SYS_VAR
            .elementAt(0)
            .SVVL
            .toString();
        if (SYS_VAR
            .elementAt(0)
            .SVVL == '1') {
          StteingController().SET_B_P('Print_Balance', false);
          update();
        }
      } else {
        Print_Balance = '1';
      }
    });
  }

  //طباعة المبلغ المدفوع والمتبقي في الفاتوره
  Future GET_PRINT_PAY_RET() async {
    GET_SYS_VAR(609).then((data) {
      SYS_VAR = data;
      if (SYS_VAR.isNotEmpty) {
        PRINT_PAY_RET = SYS_VAR
            .elementAt(0)
            .SVVL
            .toString();
      } else {
        PRINT_PAY_RET = '1';
      }
    });
  }

  //طباعة المبلغ المستلم من العميل بعد كل فاتورة
  Future GET_PRINT_PAY() async {
    GET_SYS_VAR(5019).then((data) {
      SYS_VAR = data;
      if (SYS_VAR.isNotEmpty) {
        PRINT_PAY = SYS_VAR
            .elementAt(0)
            .SVVL
            .toString();
      } else {
        PRINT_PAY = '1';
      }
    });
  }

  //الية التعامل مع حقل المبلغ المدفوع/المستلم عند الحفظ للفاتوره
  Future GET_PAY_RET() async {
    GET_SYS_VAR(630).then((data) {
      SYS_VAR = data;
      if (SYS_VAR.isNotEmpty) {
        PAY_V = SYS_VAR
            .elementAt(0)
            .SVVL
            .toString();
      } else {
        PAY_V = '1';
      }
    });
  }

// في شاشة المبيعات وعند اختيار المستخدم الحفظ الحركه , يجب اظهار سؤال للمستخدم لتأكيد المتابعه وحفظ الفاتوره.
  Future GET_ASK_SAVE_MESSAGE() async {
    GET_SYS_VAR(723).then((data) {
      SYS_VAR = data;
      if (SYS_VAR.isNotEmpty) {
        ASK_SAVE = SYS_VAR
            .elementAt(0)
            .SVVL
            .toString();
      } else {
        ASK_SAVE = '2';
      }
    });
  }

  //البيان الافتراضي عند ادخال السندات
  Future GETDefaultDescription_Voucher() async {
    GET_SYS_VAR(395).then((data) {
      SYS_VAR = data;
      if (SYS_VAR.isNotEmpty) {
        AMMIN = '${SYS_VAR
            .elementAt(0)
            .SVVL
            .toString()} ';
      } else {
        AMMIN = '';
      }
    });
  }

  //ضرورة تحديد موظف التوصيل/التسليم ، اذا كانت الفاتوره (توصيل).
  Future GET_DELIVERY_VAR() async {
    GET_SYS_VAR(735).then((data) {
      SYS_VAR = data;
      if (SYS_VAR.isNotEmpty) {
        DELIVERY_VAR = SYS_VAR
            .elementAt(0)
            .SVVL
            .toString();
      } else {
        DELIVERY_VAR = '1';
      }
    });
  }

  //ضرورة تحديد عنوان وبيانات المستلم للطلب ، اذا كانت الفاتوره (توصيل).
  Future GET_ADDRESS_CUS_REQUEST() async {
    GET_SYS_VAR(736).then((data) {
      SYS_VAR = data;
      if (SYS_VAR.isNotEmpty) {
        ADDRESS_CUS_REQUEST = SYS_VAR
            .elementAt(0)
            .SVVL
            .toString();
      } else {
        ADDRESS_CUS_REQUEST = '1';
      }
    });
  }

  //استخدام ميزه تعدد الطابعات في فواتير المبيعات الفورية
  Future GET_USE_MULTIPLE_PRINTER() async {
    GET_SYS_VAR(743).then((data) {
      SYS_VAR = data;
      if (SYS_VAR.isNotEmpty) {
        USE_MULTIPLE_PRINTER = SYS_VAR
            .elementAt(0)
            .SVVL
            .toString();
      } else {
        USE_MULTIPLE_PRINTER = '2';
      }
    });
  }

  //طباعة الاصناف التابعه والمرتبطه في فواتير المبيعات الفوريه/المردود
  Future GET_PRINT_RELATED_ITEMS_DETAIL() async {
    await GET_SYS_VAR(BMKID == 1 || BMKID == 2 ? 5021 : BMKID == 3 || BMKID == 4
        ? 5022
        : BMKID == 5 || BMKID == 6 ? 5023 :
    BMKID == 7 ? 5024 : 5025).then((data) {
      SYS_VAR = data;
      if (SYS_VAR.isNotEmpty) {
        RINT_RELATED_ITEMS_DETAIL = SYS_VAR
            .elementAt(0)
            .SVVL
            .toString();
      } else {
        RINT_RELATED_ITEMS_DETAIL = '2';
      }
      print('RINT_RELATED_ITEMS_DETAIL');
      print(RINT_RELATED_ITEMS_DETAIL);
    });
  }

  //استخدام ( مواصفات / ملاحظات سريعة للصنف ) في فاتورة البيع
  Future GET_USING_QUICK_NOTES_FOR_ITEM() async {
    GET_SYS_VAR(619).then((data) {
      SYS_VAR = data;
      if (SYS_VAR.isNotEmpty) {
        USING_QUICK_NOTES_FOR_ITEM = SYS_VAR
            .elementAt(0)
            .SVVL
            .toString();
      } else {
        USING_QUICK_NOTES_FOR_ITEM = '2';
      }
    });
  }

  //يجب تحديد الموقع عند ادخال الفاتورة من التطبيق
  Future GET_Must_Specify_Location_Invoice() async {
    var SYS_VAR =await GET_SYS_VAR(902);
    if (SYS_VAR.isNotEmpty) {
      Must_Specify_Location_Invoice =
      BMKID == 1 || BMKID == 2 || BMKID == 7 || BMKID == 10 ? '3' : SYS_VAR.elementAt(0).SVVL;
      if (SYS_VAR.elementAt(0).SVVL.toString() != '3' && BMKID != 1 && BMKID != 2 && BMKID != 7 && BMKID != 10) {
        STMID=='MOB'? determinePosition():false;
      }
      //حسب الصلاحيات
      if (SYS_VAR.elementAt(0).SVVL.toString() == '4') {
        //عدم تحديد الموقع عند ادخال الفاتورة من التطبيق
        await PRIVLAGE(LoginController().SUID, 1873).then((data) {
          USR_PRI = data;
          if (USR_PRI.isNotEmpty) {
            Allow_Must_Specify_Location_Invoice = USR_PRI.elementAt(0).UPIN;
          } else {
            Allow_Must_Specify_Location_Invoice = 2;
          }
        });
      }
      print(Must_Specify_Location_Invoice);
      print(Allow_Must_Specify_Location_Invoice);
      print('GET_Must_Specify_Location_Invoice');
    } else {
      Must_Specify_Location_Invoice = '3';
    }
  }

  //السماح باصدار فاتورة اذا كانت المسافة بالامتار من الموقع لا تزيد عن:
  Future GET_Allow_Issuance_Invoice_Distance_Meters() async {
    var SYS_VAR =await GET_SYS_VAR(904);
    if (SYS_VAR.isNotEmpty) {
      Allow_Issuance_Invoice_Distance_Meters =
      BMKID == 1 || BMKID == 2 || BMKID == 7 || BMKID == 10 ? '0'
          : SYS_VAR.elementAt(0).SVVL;
    } else {
      Allow_Issuance_Invoice_Distance_Meters = '0';
    }
  }

  /// دالة لجلب الموقع الحالي بعد التأكد من تفعيل خدمة الموقع وصلاحياتها
  Future<Position> determinePosition() async {
    bool serviceEnabled;
    LocationPermission permission;
    print('determinePosition');

    // التأكد من تفعيل خدمات الموقع
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      // إذا لم تكن الخدمة مفعلة، يُفتح إعدادات الموقع ويتم إرجاع خطأ
      await Geolocator.openLocationSettings();
      return Future.error('خدمات الموقع غير مفعلة.');
    }

    // فحص صلاحيات الموقع
    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        await Geolocator.openLocationSettings();
        return Future.error('تم رفض صلاحيات الموقع.');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      return Future.error('صلاحيات الموقع مرفوضة بشكل دائم.');
    }

    // بدء الاستماع لتحديثات الموقع
    toggleListening();

    // محاولة جلب الموقع الحالي مع التعامل مع الأخطاء
    try {
      return await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high,
      );
    } catch (e) {
      return Future.error('حدث خطأ أثناء جلب الموقع: $e');
    }
  }

  /// دالة للاستماع لتحديثات الموقع عبر الـ Stream وتحديث الواجهة
  Future<void> toggleListening() async{
    // إذا لم يكن هناك اشتراك قائم بالفعل، نقوم بالاشتراك
    if (_positionStreamSubscription == null) {
      final positionStream = _geolocatorPlatform.getPositionStream();
      _positionStreamSubscription = positionStream.handleError((error) {
        _positionStreamSubscription?.cancel();
        _positionStreamSubscription = null;
      }).listen((position) {
        updateLocation(position);
        // إذا كنت تريد تحديث الموقع مرة واحدة فقط يمكنك إيقاف الاشتراك مؤقتًا
        _positionStreamSubscription?.pause();
      });
    } else {
      // إذا كان الاشتراك موجودًا، يمكن استئنافه أو إيقافه حسب الحالة
      if (_positionStreamSubscription!.isPaused) {
        _positionStreamSubscription!.resume();
      } else {
        _positionStreamSubscription!.pause();
      }
    }
  }

  /// دالة لتحديث الإحداثيات في الواجهة والحقول عند وصول موقع جديد
  Future<void> updateLocation(Position position) async {
    // التأكد من أن الموقع صحيح وغير وهمي
    if (position != null && !position.isMocked) {
      // تحديث المتغيرات
      latitude!.value = position.latitude;
      longitude!.value = position.longitude;

      // // تحديث حقول الإدخال إذا كانت فارغة
      if (BCLATController.text.isEmpty) {
        BCLATController.text = position.latitude.toString();
      }
      if (BCLONController.text.isEmpty) {
        BCLONController.text = position.longitude.toString();
      }

      print("Latitude: ${latitude!.value}");
      print("Longitude: ${longitude!.value}");
    } else {
      // في حالة عدم صحة الموقع أو أنه وهمي، يتم تعيين القيم الافتراضية
      latitude!.value = 0.0;
      longitude!.value = 0.0;
      distanceInMeters = 0;
      BCLAT = '0.0';
      BCLON = '0.0';
      print('تم استلام موقع وهمي أو غير متوفر.');
    }
  }

  /// دالة لحساب المسافة بين الموقع السابق (المخزن في حقول الإدخال) والموقع الحالي
  Future<void> calculateDistanceBetweenLocations() async {
    // افتراض أن القيم السابقة محفوظة في حقول الإدخال BCLATController و BCLONController
    String previousLatStr = BCLAT;
    String previousLonStr = BCLON;

    double? previousLat = double.tryParse(previousLatStr);
    double? previousLon = double.tryParse(previousLonStr);
    print('previousLat: $previousLat');
    print('previousLon: $previousLat');

    if (previousLat == null || previousLon == null) {
      print('بيانات الموقع السابقة غير صالحة.');
      return;
    }

    double currentLat = latitude!.value;
    double currentLon = longitude!.value;

    double calculatedDistance = Geolocator.distanceBetween(
        previousLat, previousLon, currentLat, currentLon);
    distanceInMeters = calculatedDistance;

    distanceStr = calculatedDistance > 1000
        ? '${(calculatedDistance / 1000).toStringAsFixed(2)} KM'
        : '${calculatedDistance.toStringAsFixed(2)} meters';

    print('Total Distance: $distanceInMeters');
    print('Distance: $distanceStr');
    print('distanceInMeters');
  }



  //التحقق هل هناك عروض ام لا مرتبطة بالمستخدم الحالي بنوع الفاتورة الحالي
  Future CHK_MAT_DIS_M(int MDTID_V, String BIID_V, String BIL_V,
      String SUID_V) async {
    GET_MAT_DIS_M().then((data) {
      if (BMKID == 3 || BMKID == 5 || BMKID == 7 || BMKID == 11) {
        if (data.isNotEmpty) {
          if (data
              .elementAt(0)
              .MDMID! > 0) {
            GET_MAT_DIS_M_CHK(BIID_V, BIL_V, SUID_V).then((data2) {
              if (data2.isNotEmpty) {
                if (data2
                    .elementAt(0)
                    .MDMID! > 0) {
                  GET_MAT_DIS_M_CHK_INV_ITEM(MDTID_V, BIID_V, BIL_V, SUID_V)
                      .then((data3) {
                    if (data3.isNotEmpty) {
                      if (data3
                          .elementAt(0)
                          .MDMID! > 0) {
                        if (MDTID_V == 1) {
                          CHK_DIS_INV = '1';
                        } else {
                          CHK_DIS_ITEM = '1';
                        }
                      }
                      else {
                        if (MDTID_V == 1) {
                          CHK_DIS_INV = '2';
                        } else {
                          CHK_DIS_ITEM = '2';
                        }
                      }
                    } else {
                      CHK_DIS_ITEM = '2';
                      CHK_DIS_INV = '2';
                    }
                  });
                } else {
                  CHK_DIS_ITEM = '2';
                  CHK_DIS_INV = '2';
                }
              } else {
                CHK_DIS_ITEM = '2';
                CHK_DIS_INV = '2';
              }
            });
          } else {
            CHK_DIS_ITEM = '2';
            CHK_DIS_INV = '2';
          }
        } else {
          CHK_DIS_ITEM = '2';
          CHK_DIS_INV = '2';
        }
      } else {
        CHK_DIS_ITEM = '2';
        CHK_DIS_INV = '2';
      }
    });
  }


  //حلب العروض على مستوى الفاتورة
  Future GET_DIS_BIL_P(String BIID_P, String BIL_P, String PKID_P,
      String BCCID_P, String SCID_P, String BCID_P, String CIID_P,
      String BCTID_P, String ECID_P, String SIID_P, String ACNO_P,
      String SUID_P, String DATE_P, String AM_P) async {
    if (BIID_P.toString() != 'null' || SCID_P.toString() != 'null') {
      if (CHK_DIS_INV == '1') {
        GET_DIS_BIL(
            BIID_P,
            BIL_P,
            PKID_P,
            BCCID_P,
            SCID_P,
            BCID_P,
            CIID_P,
            BCTID_P,
            ECID_P,
            SIID_P,
            ACNO_P,
            SUID_P,
            DATE_P,
            AM_P).then((value) {

        });
      }
    }
  }


  //جلب بيانات المستخدم(رقمه)
  Future GET_SUMO() async {
    SYS_USR = await GET_USR_NAME(LoginController().SUID);
    if (SYS_USR.isNotEmpty) {
      SUMO = SYS_USR.elementAt(0).SUMO.toString();
    }
  }


  //جلب النقطه عند الدخول
  Future GET_BIL_POI_ONE_P() async {
    BOL_POI = await GET_BIL_POI_ONE(SelectDataBIID.toString());
    if (BOL_POI.isNotEmpty) {
      SelectDataBPID = BOL_POI.elementAt(0).BPID.toString();
      BPPR = BOL_POI.elementAt(0).BPPR;
      BCPR = BOL_POI.elementAt(0).BPPR;
      PKIDL = BOL_POI.elementAt(0).PKIDL;
      update();
    }
  }


  //جلب العمله عند الدخول
  Future GET_SYS_CUR_ONE_P_POS() async {
    GET_SYS_CUR_ONE_SALE().then((data) {
      SYS_CUR = data;
      if (SYS_CUR.isNotEmpty) {
        SelectDataSCID = SYS_CUR
            .elementAt(0)
            .SCID
            .toString();
        SCEXController.text = SYS_CUR
            .elementAt(0)
            .SCEX
            .toString();
        SCSY = SYS_CUR
            .elementAt(0)
            .SCSY!;
        SCSFL = SYS_CUR
            .elementAt(0)
            .SCSFL!;
      }
      update();
    });
  }

  //جلب العمله عند الدخول
  Future GET_SYS_CUR_ONE_P_COU() async {
    GET_SYS_CUR_ONE_SALE().then((data) {
      SYS_CUR = data;
      if (SYS_CUR.isNotEmpty) {
        SelectDataSCID = SYS_CUR
            .elementAt(0)
            .SCID
            .toString();
        SCEX = SYS_CUR
            .elementAt(0)
            .SCEX;
        SCEXController.text = SYS_CUR
            .elementAt(0)
            .SCEX
            .toString();
        SCSY = SYS_CUR
            .elementAt(0)
            .SCSY!;
        SCSFL = SYS_CUR
            .elementAt(0)
            .SCSFL!;
      }
    });
  }

  Future GET_SYS_CUR_ONE_SALE_P(String GETSCID) async {
    GET_SYS_CUR_ONE_P(GETSCID).then((data) {
      SYS_CUR = data;
      if (SYS_CUR.isNotEmpty) {
        SelectDataSCID = SYS_CUR
            .elementAt(0)
            .SCID
            .toString();
        SCEXController.text = SYS_CUR
            .elementAt(0)
            .SCEX
            .toString();
        SCSY = SYS_CUR
            .elementAt(0)
            .SCSY!;
        SCSFL = SYS_CUR
            .elementAt(0)
            .SCSFL!;
      } else {
        GET_SYS_CUR_ONE_P_POS();
      }
      update();
    });
  }

  Future GET_BIL_DIS_NAM_P(String GETBDID) async {
    GET_BIL_DIS_NAM(GETBDID).then((data) {
      BIL_DIS = data;
      if (BIL_DIS.isNotEmpty) {
        SelectDataBDID2 = BIL_DIS
            .elementAt(0)
            .BDNA
            .toString();
      }
      update();
    });
  }

  Future GET_STO_INF_ONE_P() async {
    GET_STO_INF_ONE(BMKID!, SelectDataBIID.toString(), SelectDataBPID.toString()).then((data) {
      STO_INF = data;
      if (STO_INF.isNotEmpty) {
        SelectDataSIID = STO_INF.elementAt(0).SIID.toString();
        update();
      }
      update();
    });
  }

  //جلب الدفع عند الدخول
  Future GET_PAY_KIN_ONE_P_POS() async {
    PAY_KIN = await GET_PAY_KIN_ONE(BMKID!,
        BMKID == 3 || BMKID == 4 || BMKID == 5 || BMKID == 7 || BMKID == 10
            ? 'BO' : (BMKID == 1 || BMKID== 2) ? 'BI' : 'BF',
        UPIN_PKID, SelectDataBPID.toString());

    if (PAY_KIN.isNotEmpty) {
      PKID = PAY_KIN.elementAt(0).PKID;
      SelectDataPKID = PAY_KIN.elementAt(0).PKID.toString();
      PKNA = PAY_KIN.elementAt(0).PKNA_D.toString();
    }
    update();
  }

  Future GET_PAY_ONE_P(String GET_PKID) async {
    GET_PAY_ONE(GET_PKID).then((data) {
      PAY_KIN = data;
      if (PAY_KIN.isNotEmpty) {
        PKNA = PAY_KIN
            .elementAt(0)
            .PKNA_D
            .toString();
      }
      update();
    });
  }

  //جلب الدفع
  Future GET_PAY_KIN_P() async {
    PAY_KIN_LIST = await GET_PAY_KIN(BMKID!, [3, 4, 5, 6].contains(BMKID) ? 'BO'
        : (BMKID == 1 || BMKID==2) ? 'BI' : 'BF', UPIN_PKID, SelectDataBPID.toString());
    update();
  }

  //جلب موصفات سريعه للاصناف
  Future GET_MAT_DES_M_P(String GETMGNO, String GETMINO) async {
    MAT_DES_M = await GET_MAT_DES_M(GETMGNO, GETMINO);
  }

  //جلب جدول الانواع والاقسام والطاولات
  Future GET_BIF_MOV_A_P(String GETBMMID) async {
   var data =await GET_BIF_MOV_A(GETBMMID);
      if (data.isNotEmpty) {
        SelectDataGETTYPE = data.elementAt(0).BMATY.toString();
        SelectDataRSID = data
            .elementAt(0)
            .RSID
            .toString();
        SelectDataRTID = data.elementAt(0).RTID.toString();
        SelectDataREID = data.elementAt(0).REID.toString();
        BCDID = data
            .elementAt(0)
            .BCDID
            .toString();
        GUIDC2 = data
            .elementAt(0)
            .GUIDR
            .toString();
        SelectDataBDID_ORD = data
            .elementAt(0)
            .BDID
            .toString();
        GET_BIL_DIS_ORD_ONE_P();
        GET_RES_TAB_P(data
            .elementAt(0)
            .RSID
            .toString());
        GET_RES_EMP_P(data
            .elementAt(0)
            .RSID
            .toString());
        GET_BIF_CUS_D_ONE_P(data
            .elementAt(0)
            .GUIDR
            .toString());
        print('GET_BIF_MOV_A_P');
        print(SelectDataGETTYPE);
        print(SelectDataRSID);
        print(SelectDataRTID);
      };

  }


  Future GET_SYS_CUR_DAT_P(String GETSCID) async {
    GET_SYS_CUR_DATI(GETSCID).then((data) {
      SYS_CUR = data;
      if (SYS_CUR.isNotEmpty) {
        //  SCEXController.text=SYS_CUR.elementAt(0).SCEX.toString();
        SCHRController.text = SYS_CUR
            .elementAt(0)
            .SCHR
            .toString();
        SCLRController.text = SYS_CUR
            .elementAt(0)
            .SCLR
            .toString();
        SCSY = SYS_CUR
            .elementAt(0)
            .SCSY!;
        SCNA = SYS_CUR
            .elementAt(0)
            .SCNA!;
        SCSFL = SYS_CUR
            .elementAt(0)
            .SCSFL!;
        update();
      }
    });
  }

  Future GET_SYS_CUR_SCSFL_TX() async {
    GET_SYS_CUR_DATI('1').then((data) {
      SYS_CUR = data;
      if (SYS_CUR.isNotEmpty) {
        SCSFL_TX = SYS_CUR
            .elementAt(0)
            .SCSFL!;
        update();
      }
    });
  }

  //جلب رصيد العميل
  Future GET_BIL_ACC_C_P(String GETAANO, GETGUID, String GETBIID, String GETSCID,String GETPKID,{GETBMMID}) async {
    BIL_ACC_C = await GET_BIL_ACC_C(GETAANO, GETGUID, GETBIID, GETSCID);
    // await PRINT_BALANCE_P(AANO:GETAANO,SCID:GETSCID,TYPE:TYPE,PKID:GETPKID);
    if (BIL_ACC_C.isNotEmpty) {
      //اجمالي مدين كلي
      BACBMD = double.parse(BIL_ACC_C.elementAt(0).BACBMD.toString());
      // اجمالي دائن كلي
      BACBDA = double.parse(BIL_ACC_C.elementAt(0).BACBDA.toString());

      //رصيد الفواتير الغير نهائيه
      BACBNF = double.parse(BIL_ACC_C.elementAt(0).BACBNF.toString());
      // الرصيد الكلي
      BACBA = double.parse(BIL_ACC_C.elementAt(0).BACBA.toString()) + BACBNF!;
      // BACBA=BACBA!+SUMBMMAMT!;
      // SYMBOL
      // M-مدين
      // D-دائن
      BACBAS = BIL_ACC_C.elementAt(0).BACBAS.toString();
      //مبلغ كتابيا
      BACBAR = BIL_ACC_C.elementAt(0).BACBAR1.toString();

      //LAST UPDATE
      // تاريخ اخر تحديث للرصيد
      BACLU = BIL_ACC_C.elementAt(0).BACLU.toString();

      // عدد الحركات الغير نهائي من الفواتير
      BACBNFN = BIL_ACC_C.elementAt(0).BACBNFN.toString();

      //عدد الحركات التي تمت على الحساب من الحسابات
      BACMN = BIL_ACC_C.elementAt(0).BACMN.toString();

      //اخر سداد حسابات
      BACLP = BIL_ACC_C.elementAt(0).BACLP.toString();

      //رقم اخر فاتوره BMMID
      BACLBI = BIL_ACC_C.elementAt(0).BACLBI.toString();

      //رقم اخر فاتوره BMMNO
      BACLBN = BIL_ACC_C.elementAt(0).BACLBN.toString();

      //تاريخ اخر فاتوره
      BACLBD = BIL_ACC_C.elementAt(0).BACLBD.toString();

      print('BACBNF');
      print(BACBNF);
      print(BACBA);
      print(BACBAR);
      await GET_BAL_P(GETBMMID,GETAANO,GETSCID);
      update();

    } else {
      BACBMD = 0;
      BACBDA = 0;
      BACBNF = 0;
      BACBA = 0;
      BACBAS = '';
      BACBAR = '';
    }
    update();
  }

  //جلب الفروع
  Future GET_BRA_INF_P() async {
    BRA_INF = await GET_BRA_ONE_CHECK(LoginController().BIID_SALE);
    if (BRA_INF.isNotEmpty) {
      LoginController().BIID_SALE != 0 && BMKID != 11 && BMKID != 12
          ? SelectDataBIID = LoginController().BIID_SALE.toString()
          : BMKID == 11 || BMKID == 12
          ? ''
          : BRA_INF
          .elementAt(0)
          .BIID
          .toString();
      update();
    } else {
      BRA_INF = await GET_BRA_ONE(1);
      if (BRA_INF.isNotEmpty) {
        SelectDataBIID = BRA_INF
            .elementAt(0)
            .BIID
            .toString();
        SelectDataSIID = null;
        update();
      }
    }
    LoginController().SIID_SALE != 0 && BMKID != 11 && BMKID != 12
        ? GET_STO_INF_ONE_SALE_P()
        : BMKID == 11 || BMKID == 12 ? '' : await GET_STO_INF_ONE_P();
    await GET_ACC_BAN_P();
    await GET_BIL_CRE_C_P();
    await GET_ACC_CAS_P();
    await GET_BIL_DIS_ONE_P();
    update();
  }

  //جلب المخازن
  Future GET_STO_INF_ONE_SALE_P() async {
    STO_INF = await GET_STO_INF_ONE_SALE(
        SelectDataBIID.toString(), LoginController().SIID_SALE.toString());
    if (STO_INF.isNotEmpty) {
      SelectDataSIID = LoginController().SIID_SALE.toString();
      update();
    } else {
      SelectDataSIID = null;
    }
  }

  //جلب الصناديق
  Future GET_ACC_CAS_P() async {
    ACC_CAS = await GET_ACC_CAS_ONE(
        SelectDataBIID.toString(), SelectDataSCID.toString(),
       ( BMKID == 1 || BMKID == 2) ? 'BI' : BMKID == 3 ? 'BO' : BMKID == 4 ? 'BO' : BMKID == 5
            ? 'BS'
            : 'BF',
        BMKID!, LoginController().ACID_SALE);
    if (ACC_CAS.isNotEmpty) {
      LoginController().PKID_SALE == 1 && LoginController().ACID_SALE != 0 ?
      SelectDataACID = LoginController().ACID_SALE.toString() : '';
      update();
    } else {
      SelectDataACID = null;
    }
  }

  //جلب البنوك
  Future GET_ACC_BAN_P() async {
    ACC_BAN_List = await GET_ACC_BAN_ONE(
        SelectDataBIID.toString(), LoginController().ABID_SALE);
    if (ACC_BAN_List.isNotEmpty) {
      LoginController().PKID_SALE == 9 || LoginController().PKID_SALE == 2 ?
      SelectDataABID = LoginController().ABID_SALE.toString() : '';
    } else {
      SelectDataABID = null;
    }
  }

  //جلب بطائق الائتمان
  Future GET_BIL_CRE_C_P() async {
    BIL_CRE_C_List = await GET_BIL_CRE_C_ONE(
        SelectDataBIID.toString(), LoginController().BCCID_SALE);
    if (BIL_CRE_C_List.isNotEmpty) {
      LoginController().PKID_SALE == 8 ?
      SelectDataBCCID = LoginController().BCCID_SALE.toString() : '';
      update();
    } else {
      SelectDataBCCID = null;
    }
  }

  //جلب المحصل
  Future GET_BIL_DIS_ONE_P() async {
    if (StteingController().Install_BDID == true) {
      BIL_DIS = await GET_BIL_DIS_ONE(
          SelectDataBIID.toString(), LoginController().BDID_SALE.toString());
      if (BIL_DIS.isNotEmpty) {
        SelectDataBDID = LoginController().BDID_SALE.toString();
        SelectDataBDID2 = BIL_DIS
            .elementAt(0)
            .BDNA
            .toString();
        update();
      } else {
        SelectDataBDID = null;
        SelectDataBDID2 = null;
      }
    } else {
      SelectDataBDID = null;
      SelectDataBDID2 = null;
    }
  }

  //جلب المحصل
  Future GET_BIL_DIS_ORD_ONE_P() async {
    if (StteingController().Install_BDID == true) {
      BIL_DIS = await GET_BIL_DIS_ONE(
          SelectDataBIID.toString(), SelectDataBDID_ORD.toString());
      if (BIL_DIS.isNotEmpty) {
        SelectDataBDID2_ORD = BIL_DIS
            .elementAt(0)
            .BDNA
            .toString();
        update();
      } else {
        SelectDataBDID2_ORD = null;
      }
    } else {
      SelectDataBDID = null;
      SelectDataBDID2 = null;
    }
  }

  //جلب مراكز التكلفه
  Future GET_ACC_COS_ONE_P() async {
    await GET_ACC_COS_ONE().then((data) {
      if (data.isNotEmpty) {
        SelectDataACNO = data.elementAt(0).ACNO.toString();
      }
      update();
    });
  }

  //جلب العدادت
  Future GET_COU_INF_M_P() async {
    COU_INF_M_List = await GET_COU_INF_M(LoginController().BIID_V.toString(),
        SelectDataCTMID.toString(), LoginController().BPID_V.toString(),
        LoginController().SCID_V, 1);
    update();
  }

  //جلب انواع الوقود
  Future GET_COU_TYP_M_P() async {
    COU_TYP_M_List = await GET_COU_TYP_M('NOTALL');
  }

  //جلب انواع العملاء
  Future GET_BIL_CUS_P() async {
    GET_BIL_CUS().then((data) {
      BIL_CUS_List = data;
    });
  }


  //جلب نوع الوقود عند الدخول
  Future GET_COU_TYP_M_ONE_P() async {
    COU_TYP_M = await GET_COU_TYP_M_ONE();
    if (COU_TYP_M.isNotEmpty) {
      SelectDataCTMID = COU_TYP_M.elementAt(0).CTMID.toString();
      CTMTYController.text = COU_TYP_M.elementAt(0).CTMTY.toString();
    }
  }

  //اضافة فاتورة
  AddSale_Invoices() async {
    edit = false;
    SHOW_GRO = false;
    SHOW_ITEM = true;
    ADD_T = 1;
    print( generateTransactionDetails(
        amount: 3000,
        balance: 1000,
        companyName: 'ايليت سوفت',
        currency: 'ريال',
        dateString: '2025-01-21',
        transactionType: 'لكم سند قبض', // تحديد نوع السند
        //   transactionText: "عليكم فاتورة مبيعات", // تخصيص النص
        fieldsOrder: ["companyName","transactionType", "amount", "balance", "date", "currency"], // ترتيب الحقول
        amountLabel: "مجموع المبلغ",
        balanceLabel: "الرصيد المتبقي",
        companyNameLabel: "اسم المؤسسة",
        currencyLabel: "الوحدة النقدية",
        dateLabel: "تاريخ الفاتورة"
    ));
    LoginController().SET_P('Return_Type', '1');
    LoginController().SET_N_P('TIMER_POST', 1);
    GET_Must_Specify_Location_Invoice();
    await GET_BMMID_P();
    await GET_BMMNO_P();
    STMID == 'COU' || STMID == 'EORD' ?
    SelectDays = DateFormat('dd-MM-yyyy').format(DateTime.now()) : null;
    GUID = uuid.v4();
    BMKID != 11 && BMKID != 12 ? (LoginController().PKID_SALE != 0 ? PKID = LoginController().PKID_SALE : PKID = 1) : '';
    BMKID != 11 && BMKID != 12 ? GET_BRA_INF_P() : null;
    LoginController().SCID_SALE != 0 && BMKID != 11 && BMKID != 12
        ? GET_SYS_CUR_ONE_SALE_P(LoginController().SCID_SALE.toString())
        : BMKID == 11 || BMKID == 12 ? '' : GET_SYS_CUR_ONE_P_POS();
    update();
    BMMRD =
    DateFormat('yyyy-MM-dd').format(dateTimeDays).toString().split(" ")[0];
    String DATEBMMCD = '';
    DATEBMMCD = DateFormat('dd-MM-yyyy').format(BMMCD.add(const Duration(days: 3))).toString().split(" ")[0];
    PKID == 3 || BMKID == 7 || BMKID == 10 ?
    BMMCDController.text = BMKID == 7 || BMKID == 10 ?
    DateFormat('dd-MM-yyyy').format(BMMCD.add(const Duration(days: 30))).toString().split(" ")[0] :
    DATEBMMCD.substring(0, 10) : BMMCDController.clear();
    SER_MINA = '';
    Serch_MINA = true;
    Serch_MINO = false;
    Serch_MUBCB = false;
    titleScreen = BMKID == 2 || BMKID == 4 || BMKID == 6 || BMKID == 12
        ? 'StringAdd_Ru'.tr : 'StringAdd_Inv_Num'.tr;
    SelectDataBMMDN = '0';
    BMMDIRController.text = '0';
    BMMDIController.text = '0';
    BMMAMTOTController.text = '0';
    BMMAMController.text = '0';
    COUNTBMDNOController.text = '0';
    SUMBMMDIFController.text = '0';
    SUMBMDTXTController.text = '0';
    BMMCPController.text = '0';
    BMMTC = 0;
    BMMTC_TOT = 0;
    BMMCP = 0;
    BMMAMT_RET = 0;
    BMMINController.text = '';
    BMMREController.text = '';
    BMMRE2Controller.text = '';
    BMMGRController.clear();
    SelectDataACNO = null;
    BCDNAController.clear();
    BCDID = null;
    GUIDC = null;
    GUIDC2 = null;
    BCDMOController.clear();
    BCDADController.clear();
    BCDSNController.clear();
    BCDFNController.clear();
    BCDBNController.clear();
    BMMDRController.clear();
    BMMDEController.clear();
    BMMGRController.clear();
    BMMDRController.clear();
    BMMDEController.clear();
    BMMCRTController.clear();
    BMMTNController.clear();
    BMMST = 2;
    CheckBack = 0;
    COUNTRecode_ORD = 0;
    SUMBAL=0.0;
    CountRecodeController.text = '0';
    update();
    await GET_BAL_P(BMMID,AANOController.text,SelectDataSCID.toString());
    await GET_BIL_ACC_C_P(AANOController.text, GUIDC,
        SelectDataBIID.toString(),SelectDataSCID.toString(),PKID.toString()
        ,GETBMMID: BMMID.toString());
    await GET_PAY_ONE_P(PKID.toString());
    await GET_ECO_ACC_P(AANOController.text);
    P_COSS == '1' || (P_COSS == '4' && UPIN_USE_ACNO == 1)
        ? LoginController().ACNO_SALE != 0?
         SelectDataACNO= LoginController().ACNO_SALE.toString():
    GET_ACC_COS_ONE_P()
          : null;
    await GET_MAT_GRO_P();
    await GET_COU_INF_M_P();
    await GET_PAY_KIN_P();
    await GET_Allow_give_Discount();
    await GET_Allow_give_Free_Quantities();
    //OSAMA
    STMID == 'EORD' ? await GET_BIF_MOV_D_P(BMMID.toString(), '2') : false;
    update();
    Get.to(() => STMID == 'EORD' ? const Add_Edit_Sale_order() :
    STMID == 'COU' ? const Add_Edit_CounterSalesInvoiceView() :
    const Add_Edit_Sale_Invoice(),
        transition: StteingController().isActivateInteractionScreens == true ?
        Transition.zoom : Transition.noTransition,
        duration: Duration(milliseconds: 500));
    //Get.to(() => const Add_Edit_Sale_Invoice());
    await Future.delayed(const Duration(milliseconds: 1000));
    await CHK_MAT_DIS_M(1, SelectDataBIID.toString(),
        BMKID == 11 || BMKID == 12 ? 'BIF_MOV_OUT' :
        BMKID == 5 || BMKID == 6 ? 'BIL_MOV_OUT_S' : 'BIL_MOV_OUT',
        '${LoginController().SUID}');
    await CHK_MAT_DIS_M(2, SelectDataBIID.toString(),
        BMKID == 11 || BMKID == 12 ? 'BIF_MOV_OUT' :
        BMKID == 5 || BMKID == 6 ? 'BIL_MOV_OUT_S' : 'BIL_MOV_OUT',
        '${LoginController().SUID}');
    GET_AKID_P();
    update();
  }


  //تعديل حركة
  EditSales_Invoices(Bil_Mov_M_Local note) async {
    if (BYST == 2) {
      Get.snackbar('StringByst_Mes'.tr, 'String_CHK_Byst'.tr,
          backgroundColor: Colors.red,
          icon: const Icon(Icons.error, color: Colors.white),
          colorText: Colors.white,
          isDismissible: true,
          dismissDirection: DismissDirection.horizontal,
          forwardAnimationCurve: Curves.easeOutBack);
    } else {
      if (UPCH == 1) {
        GET_Must_Specify_Location_Invoice();
        SHOW_GRO = false;
        SHOW_ITEM = true;
        ADD_T = 1;
        if ((BMKID == 1 || BMKID == 4 || BMKID == 12) && LoginController().Return_Type == '2') {
          edit = false;
          LoginController().SET_N_P('TIMER_POST', 1);
          await GET_BMMID_P();
          await GET_BMMNO_P();
          update();
          GUID = uuid.v4();
          GUID_LNK = note.GUID;
          BMMNOR = note.BMMNO;
          BMMIDR = note.BMMID;
          SelectDataBIID = note.BIID2.toString();
          SelectDataBIID2 = note.BIID.toString();
          SelectDataBPID = BMKID == 11 || BMKID == 12 ? note.BPID.toString() : null;
          SelectDataSIID = note.SIID.toString();
          SelectDataPKID = note.PKID.toString();
          PKID = note.PKID;
          BMMST = note.BMMST!;
          BMMFS = 5;
          BMMRD = DateFormat('yyyy-MM-dd').format(dateTimeDays).toString().split(" ")[0];
          SelectDataSCID = note.SCID.toString();
          SelectDataACID = BMKID != 11 ? note.ACID.toString() : null;
          SelectDataBDID = note.BDID.toString() == 'null' ? null : note.BDID.toString();
          SelectDataACNO = note.ACNO.toString() == 'null' ? null : note.ACNO.toString();
          SelectDataBCID = note.BCID.toString() == 'null' ? null : note.BCID.toString();
          SelectDataBCID2 = note.BCID2.toString() == 'null' ? null : note.BCID2.toString();
          SelectDataBIID3 = note.BIID3.toString() == 'null' ? null : note.BIID3.toString();
          SelectDataABID = note.ABID.toString();
          SelectDataBMMDN = note.BMMDN.toString();
          BMMINController.text = " متعلق بفاتورة مبيعات رقم${note.BMMNO.toString()} بتاريخ ${note.BMMDO.toString().substring(0, 11)}";
          BMMREController.text = note.BMMRE.toString() == 'null' ? '' : note.BMMRE.toString();
          BMMRE2Controller.text = note.BMMDR.toString() == 'null' ? '' : note.BMMDR.toString();
          BMMDIController.text = note.BMMDI.toString();
          BMMDIRController.text = note.BMMDIR.toString();
          AANOController.text = note.AANO.toString();
          BMMCNController.text = note.BMMCN.toString();
          GUIDC = note.GUIDC;
          AANOController.text = note.AANO.toString();
          BCNAController.text = note.BMMNA.toString();
          SCEXController.text = note.SCEX.toString();
          BCMOController.text = note.BCMO.toString();
          BCMOController.text = note.BCMO.toString();
          BMMCDController.text = note.BMMCD.toString();
          SelectDataSCIDP = note.SCIDP.toString();
          SCEXP = note.SCEXP;
          BMMCPController.text = note.BMMCP.toString();
          BMMCP = note.BMMCP;
          BMMTC = note.BMMTC;
          TTID1 = note.TTID1;
          TTID2 = note.TTID2;
          TTID3 = note.TTID3;
          BMMAMT_RET = note.BMMMT;
          BMMTX_DAT = note.BMMTX_DAT.toString();
          TTLID = note.TTLID;
          TCRA_M = note.TCRA;
          TCSDID_M = note.TCSDID;
          TCSDSY_M = note.TCSDSY.toString();
          TCID_M = note.TCID;
          TCSY_M = note.TCSY.toString();
          BMMAM_TX = note.BMMAM_TX;
          BMMDI_TX = note.BMMDI_TX;
          TCAM = note.TCAM;
          SER_MINA = '';
          note.BDID.toString() == 'null' ? SelectDataBDID2 = null : await GET_BIL_DIS_NAM_P(note.BDID.toString());
          Serch_MINA = true;
          Serch_MINO = false;
          Serch_MUBCB = false;
          titleScreen =
          BMKID == 2 || BMKID == 4 || BMKID == 6 || BMKID == 12 ? 'StringAdd_Ru'.tr : 'StringAdd_Inv_Num'.tr;
          CheckBack = 1;
          await Future.delayed(const Duration(milliseconds: 150));
          await deleteBIL_MOV_D(BMKID == 11 || BMKID == 12 ? 'BIF_MOV_D' : 'BIL_MOV_D', BMMID!);
          await Future.delayed(const Duration(milliseconds: 200));
          await UPDATE_BIL_MOV_D(note.BMMID.toString(), BMMID!, GUID);
          await Future.delayed(const Duration(milliseconds: 400));
          await GET_BMMNO_P();
          await GET_SUMBMDTXA();
          await GET_SUMBMMDIF();
          await GET_SUMBMMDI();
          await GET_SUMBMMAM();
          await GET_SUMBMMAM2();
          await GET_CountRecode(note.BMMID!);
          await GET_COUNT_BMDNO_P(note.BMMID!);
          await GET_SUMBMDTXT();
          await GET_SUM_AM_TXT_DI();
          print('SelectDataSIID');
          print(SelectDataSIID);
          update();
        }
        else {
          edit = true;
          BMMID = note.BMMID;
          BMMNO = note.BMMNO.toString();
          SelectDataBIID = note.BIID2.toString();
          SelectDataBIID2 = note.BIID.toString();
          SelectDataBPID = BMKID == 11 ? note.BPID.toString() : null;
          SelectDataSIID = note.SIID.toString();
          SelectDataPKID = note.PKID.toString();
          SelectDataCTMID = note.CTMID.toString();
          CIMIDController.text = note.CIMID.toString();
          PKID = note.PKID;
          BMMST = note.BMMST!;
          BMMFS = note.BMMFST!;
          BMMRD = note.BMMRD!;
          SelectDataSCID = note.SCID.toString();
          SelectDataACID = BMKID != 11 ? note.ACID.toString() : null;
          SelectDataBDID =
          note.BDID.toString() == 'null' ? null : note.BDID.toString();
          SelectDataACNO = note.ACNO.toString() == 'null' ? null : note.ACNO.toString();
          SelectDataBCID = note.BCID.toString() == 'null' ? null : note.BCID.toString();
          SelectDataBCID2 = note.BCID2.toString() == 'null' ? null : note.BCID2.toString();
          SelectDataBIID3 = note.BIID3.toString() == 'null' ? null : note.BIID3.toString();
          SelectDataABID = note.ABID.toString();
          SelectDataBMMDN = note.BMMDN.toString();
          BMMINController.text = note.BMMIN.toString();
          BMMREController.text = note.BMMRE.toString() == 'null' ? '' : note.BMMRE.toString();
          BMMRE2Controller.text = note.BMMRE2.toString() == 'null' ? '' : note.BMMRE2.toString();
          BMMDIController.text = note.BMMDI.toString();
          BMMDIRController.text = note.BMMDIR.toString();
          AANOController.text = note.AANO.toString();
          BMMCNController.text = note.BMMCN.toString();
          GUID = note.GUID;
          GUIDC = note.GUIDC;
          GUID_LNK = note.GUID_LNK;
          SelectDays = note.BMMDO.toString().substring(0, 11);
          BMMDO = note.BMMDO.toString();
          AANOController.text = note.AANO.toString();
          BCNAController.text = note.BMMNA.toString();
          SCEXController.text = note.SCEX.toString();
          BCMOController.text = note.BCMO.toString();
          BMMCDController.text = note.BMMCD.toString();
          SelectDataSCIDP = note.SCIDP.toString();
          SCEXP = note.SCEXP;
          BMMCPController.text = note.BMMCP.toString();
          BMMCP = note.BMMCP;
          BMMTC = note.BMMTC;
          TTID1 = note.TTID1;
          TTID2 = note.TTID2;
          TTID3 = note.TTID3;
          BCDID = note.BCDID.toString();
          BCDMOController.text = note.BCDMO.toString();
          GUIDC2 = note.GUIDC2.toString();
          BMMGRController.text = note.BMMGR.toString();
          BMMDRController.text = note.BMMDR.toString();
          BMMDEController.text = note.BMMDE.toString();
          BMMCRTController.text = note.BMMCRT.toString();
          BMMTNController.text = note.BMMTN.toString();
          BCLON = note.BMMLON.toString();
          BCLAT = note.BMMLAT.toString();
          BMMAMT_RET = 0;
          BMMTX_DAT = note.BMMTX_DAT.toString();
          TTLID = note.TTLID;
          TCRA_M = note.TCRA;
          TCSDID_M = note.TCSDID;
          TCSDSY_M = note.TCSDSY.toString();
          TCID_M = note.TCID;
          TCSY_M = note.TCSY.toString();
          BMMAM_TX = note.BMMAM_TX;
          BMMDI_TX = note.BMMDI_TX;
          TCAM = note.TCAM;
          if (STMID == 'COU') {
            BMDNOController.text = note.BMDNO.toString();
          }
          note.BDID.toString() == 'null'
              ? SelectDataBDID2 = null
              : GET_BIL_DIS_NAM_P(note.BDID.toString());
          titleScreen = 'StringEdit'.tr;
          SER_MINA = '';
          GET_COU_INF_M_P();
          await GET_SUMBMDTXA();
          await GET_SUMBMMDIF();
          await GET_SUMBMMDI();
          await GET_SUMBMMAM();
          await GET_SUMBMMAM2();
          await GET_CountRecode(BMMID!);
          await GET_COUNT_BMDNO_P(BMMID!);
          await GET_SUMBMDTXT();
          await GET_SUM_AM_TXT_DI();
        }
        await GET_BAL_P(BMMID,AANOController.text,SelectDataSCID.toString());
        await GET_BIL_ACC_C_P(AANOController.text, GUIDC,
            SelectDataBIID.toString(),SelectDataSCID.toString(),PKID.toString(),
            GETBMMID: BMMID.toString());
        await GET_PAY_ONE_P(PKID.toString());
        await GET_MAT_GRO_P();
        await GET_PAY_KIN_P();
        await GET_Allow_give_Discount();
        await GET_Allow_give_Free_Quantities();
        GET_AKID_P();
        STMID == 'EORD' ? GET_BIF_MOV_D_P(note.BMMID.toString(), '2') : null;
        update();
        Get.to(() => STMID == 'EORD' ? const Add_Edit_Sale_order() :
        STMID == 'COU' ? const Add_Edit_CounterSalesInvoiceView() :
        const Add_Edit_Sale_Invoice(), arguments: note.BMMID,
            transition: StteingController().isActivateInteractionScreens == true
                ? Transition.zoom
                : Transition.noTransition,
            duration: Duration(milliseconds: 500));
      } else {
        Get.snackbar('StringUPCH'.tr, 'String_CHK_UPCH'.tr,
            backgroundColor: Colors.red,
            icon: const Icon(Icons.error, color: Colors.white),
            colorText: Colors.white,
            isDismissible: true,
            dismissDirection: DismissDirection.horizontal,
            forwardAnimationCurve: Curves.easeOutBack);
      }
    }
  }

  String? validate_Continue() {
    errorTextBIID.value = null;
    errorTextBPID.value = null;
    errorTextCTMID.value = null;
    errorTextSCID.value = null;
    errorTextPKID.value = null;
    try {
      if (SelectDataBIID == null) {
        errorTextBIID.value = 'StringvalidateBIID'.tr;
        loadingerror(true);
        update();
        return 'StringvalidateBIID'.tr;
      } else if (SelectDataBPID == null) {
        errorTextBPID.value = 'StringvalidateBPID'.tr;
        loadingerror(true);
        update();
        return 'StringvalidateBPID'.tr;
      } else if (SelectDataCTMID == null) {
        errorTextCTMID.value = 'StringvalidateCTMID'.tr;
        loadingerror(true);
        update();
        return 'StringvalidateCTMID'.tr;
      }
      else if (SelectDataSCID == null) {
        errorTextSCID.value = 'StringvalidateSCID'.tr;
        loadingerror(true);
        update();
        return 'StringvalidateSCID'.tr;
      }
      else if (SelectDataPKID == null) {
        errorTextPKID.value = 'StringvalidatePKID'.tr;
        loadingerror(true);
        update();
        return 'StringvalidatePKID'.tr;
      }
      else {
        // LoginController().setInstallData(isloadingInstallData);
        errorTextBIID.value = null;
        errorTextBPID.value = null;
        errorTextCTMID.value = null;
        errorTextSCID.value = null;
        print('error');
        update();
        return null;
      }
    } catch (e) {
      errorText = 'StringErrorDefault_SNNO_NUM'.tr;
      update();
      print("error${e.toString()}");
    }
    return null;
  }

  //الذهاب الي شاشة اظهار العملاء
  GET_BIL_CUS_CER(int type) async {
    type == 1 ? Type = "1" : Type = "2";
    var data = await Get.to(Get_Bil_CusView());
    // if(data == 'success')  {
    //   BCNAController.text=LoginController().BCNA_V;
    //   BCIDController.text=LoginController().BCID_V;
    //   AANOController.text=LoginController().AANO_V;
    //   GUIDCController.text=LoginController().GUIDC_V;
    //   BCCIDController.text=LoginController().BCCID_V;
    //   BCCNAController.text=LoginController().BCCNA_V;
    // };
  }

  //جلب عدد السجلات
  Future GET_COUNT_CIMID() async {
    GET_COUNT_BIF_MOV_D(int.parse(CIMIDController.text), BMMID!).then((data) {
      BIF_MOV_D = data;
      if (BIF_MOV_D.isNotEmpty) {
        COUNT = BIF_MOV_D
            .elementAt(0)
            .COUNT_CIMID!;
        update();
        print(COUNT);
        print('COUNT');
      }
    });
  }


  //جلب الاصناف
  Future fetchAutoCompleteData(int Type, TYPE_MGNO) async {
    update();
    print(MGNOController.text);
    autoCompleteData = await Get_MAT_INF(
        BMKID!,
        Show_Items.toString(),
        Allow_Show_Items.toString(),
        SelectDataSIID.toString(),
        MGNOController.text,
        Type,
        SelectDataSCID.toString(),
        SelectDataBIID.toString(),
        TYPE_MGNO);
    update();
  }

  //جلب عملاء بدون حسابات
  Future GET_BIF_CUS_D_P() async {
    GET_BIF_CUS_D().then((data) {
      BIF_CUS_D = data;
      update();
    });
  }

  //جلب بيانات العميل مطاعم
  Future GET_BIF_CUS_D_ONE_P(String GETBCDID) async {
    GET_BIF_CUS_D_ONE(GETBCDID).then((data) {
      if (data.isNotEmpty) {
        BCDID = data
            .elementAt(0)
            .BCDID
            .toString();
        GUIDC2 = data
            .elementAt(0)
            .GUID
            .toString();
        BCDNAController.text = data.elementAt(0).BCDNA_D.toString();
        BCDMOController.text = data.elementAt(0).BCDMO.toString();
        BCDADController.text = data.elementAt(0).BCDAD.toString();
        BCDSNController.text = data
            .elementAt(0)
            .BCDSN
            .toString();
        BCDBNController.text = data
            .elementAt(0)
            .BCDBN
            .toString();
        BCDFNController.text = data
            .elementAt(0)
            .BCDFN
            .toString();
        SelectDataCWID = data
            .elementAt(0)
            .CWID
            .toString();
        SelectDataBAID = data
            .elementAt(0)
            .BAID
            .toString();
        SelectDataCTID = data
            .elementAt(0)
            .CTID
            .toString();
        GET_COU_WRD_SAL(data
            .elementAt(0)
            .CWID
            .toString()).then((data) {
          COU_WRD = data;
          if (COU_WRD.isNotEmpty) {
            //الدولة
            CWNA = COU_WRD
                .elementAt(0)
                .CWNA_D
                .toString();
            SelectDataCWID2 = "${COU_WRD
                .elementAt(0)
                .CWID
                .toString() + " +++ " + COU_WRD
                .elementAt(0)
                .CWNA_D
                .toString()}";
          }
        });
        GET_COU_TOW_SAL(data
            .elementAt(0)
            .CWID
            .toString(), data
            .elementAt(0)
            .CTID
            .toString()).then((data) {
          COU_TOW = data;
          if (COU_TOW.isNotEmpty) {
            //المدينه
            CTNA = COU_TOW
                .elementAt(0)
                .CTNA
                .toString();
            SelectDataCTID2 = "${COU_TOW
                .elementAt(0)
                .CTID
                .toString() + " +++ " + COU_TOW
                .elementAt(0)
                .CTNA_D
                .toString()}";
          }
        });
      }
      update();
    });
  }

  //جلب الاصناف مطاعم
  Future GET_MAT_INF_DATE(String GETMGNO, String GETSCID, String GETBIID,
      int GETBCPR) async {
    MAT_INF_DATE = await GET_MAT_INF_LIST(GETMGNO, GETSCID, GETBIID, GETBCPR);
    update();
  }

  validarTitulo(String? value) {
    if (value == null || value.isEmpty) {
      return '';
    }
    return null;
  }

  String? validateSMDFN(String value) {
    if (value
        .trim()
        .isEmpty) {
      return 'StringvalidateSMDFN'.tr;
    }
    return null;
  }

  String? validateBMDAM(String value) {
    if (value
        .trim()
        .isEmpty) {
      return 'StrinReq_BMDAM'.tr;
    }
    return null;
  }

  String? validateMINO(String value) {
    if (value
        .trim()
        .isEmpty) {
      return 'StringvalidateMINO'.tr;
    }
    return null;
  }


  //جلب وحدة البيع-الشراء
  GETMUIDS() async {
    MAT_INF = await Get_MUIDS_D(
        MGNOController.text.toString(), SelectDataMINO.toString());
    if (MAT_INF.isNotEmpty) {
      (BMKID == 1 || BMKID == 2 )? SelectDataMUID = MAT_INF.elementAt(0).MUIDP.toString() :
      SelectDataMUID = MAT_INF.elementAt(0).MUIDS.toString();
      SIID_V2 = SelectDataSIID.toString();
      await GETSNDE_ONE();
      await GET_COUNT_MINO_P();
      update();
    }
  }

  //جلب اول تاريخ انتهاء
  GETSNDE_ONE() async {
    if (SMDED == '1' || SMDED == '3') {
      GET_SNDE = await Get_SNDE_ONE(MGNOController.text.toString(), SelectDataMINO.toString(), SIID_V2.toString(), SelectDataMUID.toString());
      if (GET_SNDE.isNotEmpty) {
        MGKI != 1 ? SelectDataSNED = '01-01-2900' : SelectDataSNED = GET_SNDE.elementAt(0).SNED.toString();
        MGKI != 1 ? BMDEDController.text = '01-01-2900' : BMDEDController.text =
            GET_SNDE.elementAt(0).SNED.toString();
      } else {
        SelectDataSNED = '01-01-2900';
        BMDEDController.text = '01-01-2900';
      }
      await GET_STO_NUM_P(SelectDataMUID.toString());
      update();
    } else {
      SelectDataSNED = '01-01-2900';
      BMDEDController.text = '01-01-2900';
      await GET_STO_NUM_P(SelectDataMUID.toString());
    }
    await GET_COUNT_MINO_P();
  }


  //جلب الكمية
  GET_STO_NUM_P(String StringMUID) async {
    //العدد للمخزن
    var GET_SNNO_V = await GET_SNNO(
        SelectDataBIID.toString(),
        int.parse(SIID_V2.toString()),
        MGNOController.text.toString(),
        SelectDataMINO.toString(),
        StringMUID,
        SMDED.toString(),
        SelectDataSNED.toString(),
        1);
    if (GET_SNNO_V.isNotEmpty) {
      TOT_NUM = 0;
      for (var i = 0; i < GET_SNNO_V.length; i++) {
        SNNO_V = 0;
        // استدعاء الدالة GET_MAT_UNI_F
        SNNO_V = await ES_MAT.GET_MAT_UNI_F(
          F_MGNO: MGNOController.text.toString(),
          // أدخل القيم المناسبة هنا
          F_MINO: SelectDataMINO.toString(),
          F_MUID_F: GET_SNNO_V[i].MUID!.toDouble(),
          F_MUID_T: double.parse(SelectDataMUID.toString()),
          F_NO: GET_SNNO_V[i].SNNO.toDouble(),
          F_TY: 1, // أو 2 أو 3 أو 4 أو 44 حسب الحاجة
        );

        print('TOT_NUM1 $TOT_NUM');
        print('SNNO_V $SNNO_V');

        TOT_NUM = TOT_NUM + SNNO_V;
        //  GET_STO_NUM = GET_SNNO_V;
        print('TOT_NUM1 $TOT_NUM');
        MGKI != 1 ? BDNO_F = 0 : BDNO_F = TOT_NUM;
      }
    } else {
      BDNO_F = 0;
    }

    //ع.كل المخازن
    var GET_BDNO_F2 = await GET_SNNO(
        SelectDataBIID.toString(),
        int.parse(SIID_V2.toString()),
        MGNOController.text.toString(),
        SelectDataMINO.toString(),
        StringMUID,
        SMDED.toString(),
        SelectDataSNED.toString(),
        2);
    TOT_NUM = 0;
    if (GET_BDNO_F2.isNotEmpty) {
      for (var i = 0; i < GET_BDNO_F2.length; i++) {
        SNNO_V = 0;
        // استدعاء الدالة GET_MAT_UNI_F
        SNNO_V = await ES_MAT.GET_MAT_UNI_F(
          F_MGNO: MGNOController.text.toString(),
          // أدخل القيم المناسبة هنا
          F_MINO: SelectDataMINO.toString(),
          F_MUID_F: GET_BDNO_F2[i].MUID!.toDouble(),
          F_MUID_T: double.parse(SelectDataMUID.toString()),
          F_NO: GET_BDNO_F2[i].SNNO.toDouble(),
          F_TY: 1, // أو 2 أو 3 أو 4 أو 44 حسب الحاجة
        );

        print('TOT_NUM2 $TOT_NUM');
        print('SNNO_V2 $SNNO_V');

        TOT_NUM = TOT_NUM + SNNO_V;
        //  GET_STO_NUM = GET_SNNO_V;
        print('TOT_NUM2 $TOT_NUM');
        MGKI != 1 ? BDNO_F2 = 0 : BDNO_F2 = TOT_NUM;
      }
    } else {
      BDNO_F2 = 0;
    }

    // اعادة الوحده الاساسيه للصنف اصغر وحده
    var MUID2 = await ES_MAT.GET_MAT_UNI_F(
      F_MGNO: MGNOController.text.toString(),
      // أدخل القيم المناسبة هنا
      F_MINO: SelectDataMINO.toString(),
      F_MUID_F: 0,
      F_MUID_T: 0,
      F_NO: 0,
      F_TY: 4, // أو 2 أو 3 أو 4 أو 44 حسب الحاجة
    );

    await GET_MAT_INF_D_P(MGNOController.text.toString(), SelectDataMINO.toString());
    await GET_MPCO_P(MGNOController.text.toString(), SelectDataMINO!, MUID2);
    if (StteingController().SHOW_ITEM == false ||
        StteingController().SHOW_ITEM_C == false || ADD_T == 2) {
      await GET_MPS1_P(MGNOController.text.toString(), SelectDataMINO!,
          int.parse(StringMUID));
    }
    await GET_MGNA_P();
    await GET_BROCODE_P(
        MGNOController.text.toString(), SelectDataMINO!, StringMUID);
    await GET_MUNA_P(StringMUID);
    update();
  }

  //جلب سعر التكلفة
  Future GET_MPCO_P(String GETMGNO, String GETMINO, GETMUID) async {
    //جلب سعر التكلفه بعملة الفاتورة
    MAT_PRI = await GET_MPCO(
        int.parse(SelectDataBIID.toString()), GETMGNO, GETMINO, GETMUID,
        int.parse(SCID2.toString()));
    if (MAT_PRI.isNotEmpty) {
      var MPCO_V = await ES_MAT.GET_MAT_UNI_F(
        F_MGNO: MGNOController.text.toString(),
        // أدخل القيم المناسبة هنا
        F_MINO: SelectDataMINO.toString(),
        F_MUID_F: GETMUID,
        F_MUID_T: double.parse(SelectDataMUID.toString()),
        F_NO: MAT_PRI
            .elementAt(0)
            .MPCO!,
        F_TY: 2, // أو 2 أو 3 أو 4 أو 44 حسب الحاجة
      );
      print('SCEXController');
      print(SCEXController.text);

      MPCOController.text =
          roundDouble((MPCO_V * SCEXS!) / double.parse(SCEXController.text), 6)
              .toString();
      MPCO_VController.text = formatter.format(
          roundDouble((MPCO_V * SCEXS!) / double.parse(SCEXController.text), 6))
          .toString();
      update();
    }

    //جلب سعر التكلفه بعملة المخزون
    MAT_PRI = await GET_MPCO(
        int.parse(SelectDataBIID.toString()), GETMGNO, GETMINO,
        int.parse(SelectDataMUID.toString()), int.parse(SCID2.toString()));
    if (MAT_PRI.isNotEmpty) {
      MPCO = MAT_PRI
          .elementAt(0)
          .MPCO;
      update();
    }
  }

  //الاستعلام عن سعر التكلفه للاصناف
  Future GET_SYS_CUR_BET_P(String GETSCID_F, String GETSCID_T,
      String GETAM) async {
    SYS_CUR_BET = await GET_SYS_CUR_BET(GETSCID_F, GETSCID_T);
    if (SYS_CUR_BET.isNotEmpty) {
      SYS_CUR_BET_AM = await GET_SELECT(GETAM, SYS_CUR_BET
          .elementAt(0)
          .SCBTY
          .toString(), SYS_CUR_BET
          .elementAt(0)
          .SCEX
          .toString());
      if (SYS_CUR_BET_AM.isNotEmpty) {
        BMMTC = roundDouble(SYS_CUR_BET_AM
            .elementAt(0)
            .SUM_AM!
            .toDouble() - double.parse(BMMAMTOTController.text), 6);
        BMMTC_TOT = roundDouble(SYS_CUR_BET_AM
            .elementAt(0)
            .SUM_AM!
            .toDouble(), 6);
        BMMCP = roundDouble(SYS_CUR_BET_AM
            .elementAt(0)
            .SUM_AM!
            .toDouble(), 6);
      }
      SCBTY = SYS_CUR_BET
          .elementAt(0)
          .SCBTY;
      SCEX_BET = double.parse(SYS_CUR_BET
          .elementAt(0)
          .SCEX);
    } else {
      SCBTY = '*';
    }
  }


  //جلب   سعر البيع
  Future GET_MPS1_P(String GETMGNO, String GETMINO, int GETMUID) async {
    MAT_PRI = await GET_MPCO(
        int.parse(SelectDataBIID.toString()), GETMGNO, GETMINO, GETMUID,
        int.parse(SelectDataSCID.toString()));
    if (MAT_PRI.isNotEmpty) {
      //اذا كان الصنف مجاني فيتم تعبئة سعر بسعر صفر
      if (MIFR == 1) {
        MPS1 = 0;
        BMDAMController.text = '0';
      } else {
        if (BMKID != 1 && BMKID != 2) {
          //جلب سعر البيع حسب العميل عن طريق حقل السعر من جدول العميل
          if (((BMKID == 11 || BMKID == 12) && BPPR == 1) ||
              ((BMKID == 3 || BMKID == 4 || BMKID == 5 || BMKID == 7 ||
                  BMKID == 10) && BCPR == 1)) {
            if (MAT_PRI
                .elementAt(0)
                .MPS1! > 0) {
              MPS1 = MAT_PRI
                  .elementAt(0)
                  .MPS1;
              BMDAMController.text = MAT_PRI
                  .elementAt(0)
                  .MPS1
                  .toString();
              update();
            } else {
              if (SelectDataSCID != SCID2) {
                GET_MPS_P(GETMGNO, GETMINO, GETMUID);
              }
            }
          } else if (((BMKID == 11 || BMKID == 12) && BPPR == 2) ||
              ((BMKID == 3 || BMKID == 4 || BMKID == 5 || BMKID == 7 ||
                  BMKID == 10) && BCPR == 2)) {
            if (MAT_PRI
                .elementAt(0)
                .MPS2! > 0) {
              MPS1 = MAT_PRI
                  .elementAt(0)
                  .MPS2;
              BMDAMController.text = MAT_PRI
                  .elementAt(0)
                  .MPS2
                  .toString();
              update();
            } else {
              if (SelectDataSCID != SCID2) {
                GET_MPS_P(GETMGNO, GETMINO, GETMUID);
              }
            }
          } else if (((BMKID == 11 || BMKID == 12) && BPPR == 3) ||
              ((BMKID == 3 || BMKID == 4 || BMKID == 5 || BMKID == 7 ||
                  BMKID == 10) && BCPR == 3)) {
            if (MAT_PRI
                .elementAt(0)
                .MPS3! > 0) {
              MPS1 = MAT_PRI
                  .elementAt(0)
                  .MPS3;
              BMDAMController.text = MAT_PRI
                  .elementAt(0)
                  .MPS3
                  .toString();
              update();
            } else {
              if (SelectDataSCID != SCID2) {
                GET_MPS_P(GETMGNO, GETMINO, GETMUID);
              }
            }
          } else if (((BMKID == 11 || BMKID == 12) && BPPR == 4) ||
              ((BMKID == 3 || BMKID == 4 || BMKID == 5 || BMKID == 7 ||
                  BMKID == 10) && BCPR == 4)) {
            if (MAT_PRI
                .elementAt(0)
                .MPS4! > 0) {
              MPS1 = MAT_PRI
                  .elementAt(0)
                  .MPS4;
              BMDAMController.text = MAT_PRI
                  .elementAt(0)
                  .MPS4
                  .toString();
              update();
            } else {
              if (SelectDataSCID != SCID2) {
                GET_MPS_P(GETMGNO, GETMINO, GETMUID);
              }
            }
          } else {
            MPS1 = 0;
            BMDAMController.text = '0';
          }
        } else {
          MPS1 = 0;
          BMDAMController.text = '0';
        }
      }
      update();
      //احتساب اقل سعر
     ( BMKID == 1 || BMKID==2) ? MPLP = 0 : MAT_PRI
          .elementAt(0)
          .MPLT == 1 && MAT_PRI
          .elementAt(0)
          .MPLP! > 0
          ? MPLP = roundDouble(MPS1! - (MPS1! * (MAT_PRI
          .elementAt(0)
          .MPLP! / 100)), 6)
          : MPLP = MAT_PRI
          .elementAt(0)
          .MPLP;
      //احتساب اعلى سعر
      (BMKID == 1 || BMKID==2) ? MPHP = 0 : MAT_PRI
          .elementAt(0)
          .MPHT == 1 && MAT_PRI
          .elementAt(0)
          .MPHP! > 0
          ? MPHP = roundDouble(MPS1! + (MPS1! * (MAT_PRI
          .elementAt(0)
          .MPHP! / 100)), 6)
          : MPHP = MAT_PRI
          .elementAt(0)
          .MPHP;
      //سعر بيع1و2و3و4
      MPS1Controller.text = MAT_PRI
          .elementAt(0)
          .MPS1
          .toString();
      MPS2Controller.text = MAT_PRI
          .elementAt(0)
          .MPS2
          .toString();
      MPS3Controller.text = MAT_PRI
          .elementAt(0)
          .MPS3
          .toString();
      MPS4Controller.text = MAT_PRI
          .elementAt(0)
          .MPS4
          .toString();
      update();
    } else {
      if (SelectDataSCID != SCID2) {
        GET_MPS_P(GETMGNO, GETMINO, GETMUID);
      }
    }
  }

  //جلب   سعر البيع بعملة المخزون
  Future GET_MPS_P(String GETMGNO, String GETMINO, int GETMUID) async {
    MAT_PRI = await GET_MPCO(
        int.parse(SelectDataBIID.toString()), GETMGNO, GETMINO, GETMUID,
        int.parse(SCID2.toString()));
    if (MAT_PRI.isNotEmpty) {
      //اذا كان الصنف مجاني فيتم تعبئة سعر بسعر صفر
      if (MIFR == 1) {
        MPS1 = 0;
        BMDAMController.text = '0';
      } else {
        if (BMKID != 1 && BMKID != 2) {
          //جلب سعر البيع حسب العميل عن طريق حقل السعر من جدول العميل
          if (((BMKID == 11 || BMKID == 12) && BPPR == 1) ||
              ((BMKID == 3 || BMKID == 4 || BMKID == 5 || BMKID == 7 ||
                  BMKID == 10) && BCPR == 1) &&
                  MAT_PRI
                      .elementAt(0)
                      .MPS1! > 0) {
            print(MAT_PRI
                .elementAt(0)
                .MPS1_D);
            MPS1 = roundDouble(
                (MAT_PRI
                    .elementAt(0)
                    .MPS1! * SCEXS!) /
                    double.parse(SCEXController.text),
                6);
            BMDAMController.text = roundDouble(
                (MAT_PRI
                    .elementAt(0)
                    .MPS1! * SCEXS!) /
                    double.parse(SCEXController.text),
                6)
                .toString();
            print(MPS1);
            print(BMDAMController.text);
            update();
          } else if (((BMKID == 11 || BMKID == 12) && BPPR == 2) ||
              ((BMKID == 3 || BMKID == 4 || BMKID == 5 || BMKID == 7 ||
                  BMKID == 10) && BCPR == 2) &&
                  MAT_PRI
                      .elementAt(0)
                      .MPS2! > 0) {
            MPS1 = roundDouble(
                (MAT_PRI
                    .elementAt(0)
                    .MPS2! * SCEXS!) /
                    double.parse(SCEXController.text),
                6);
            BMDAMController.text = roundDouble(
                (MAT_PRI
                    .elementAt(0)
                    .MPS2! * SCEXS!) /
                    double.parse(SCEXController.text),
                6)
                .toString();
            update();
          } else if (((BMKID == 11 || BMKID == 12) && BPPR == 3) ||
              ((BMKID == 3 || BMKID == 4 || BMKID == 5 || BMKID == 7 ||
                  BMKID == 10) && BCPR == 3) &&
                  MAT_PRI
                      .elementAt(0)
                      .MPS3! > 0) {
            MPS1 = roundDouble(
                (MAT_PRI
                    .elementAt(0)
                    .MPS3! * SCEXS!) /
                    double.parse(SCEXController.text),
                6);
            BMDAMController.text = roundDouble(
                (MAT_PRI
                    .elementAt(0)
                    .MPS3! * SCEXS!) /
                    double.parse(SCEXController.text),
                6)
                .toString();
            update();
          } else if (((BMKID == 11 || BMKID == 12) && BPPR == 4) ||
              ((BMKID == 3 || BMKID == 4 || BMKID == 5 || BMKID == 7 ||
                  BMKID == 10) && BCPR == 4) &&
                  MAT_PRI
                      .elementAt(0)
                      .MPS4! > 0) {
            MPS1 = roundDouble(
                (MAT_PRI
                    .elementAt(0)
                    .MPS4! * SCEXS!) /
                    double.parse(SCEXController.text),
                6);
            BMDAMController.text = roundDouble(
                (MAT_PRI
                    .elementAt(0)
                    .MPS4! * SCEXS!) /
                    double.parse(SCEXController.text),
                6)
                .toString();
            update();
          } else {
            MPS1 = 0;
            BMDAMController.text = '0';
          }
        } else {
          MPS1 = 0;
          BMDAMController.text = '0';
        }
      }

      update();
      //احتساب اقل سعر
      (BMKID == 1 || BMKID == 2)
          ? MPLP = 0
          : MAT_PRI
          .elementAt(0)
          .MPLT == 1 && MAT_PRI
          .elementAt(0)
          .MPLP! > 0
          ? MPLP = roundDouble(
          MPS1! - (MPS1! * (MAT_PRI
              .elementAt(0)
              .MPLP! / 100)), 6)
          : MPLP = MAT_PRI
          .elementAt(0)
          .MPLP;
      //احتساب اعلى سعر
     ( BMKID == 1 || BMKID == 2)
          ? MPHP = 0
          : MAT_PRI
          .elementAt(0)
          .MPHT == 1 && MAT_PRI
          .elementAt(0)
          .MPHP! > 0
          ? MPHP = roundDouble(
          MPS1! + (MPS1! * (MAT_PRI
              .elementAt(0)
              .MPHP! / 100)), 6)
          : MPHP = MAT_PRI
          .elementAt(0)
          .MPHP;
      //سعر بيع1و2و3و4
      MPS1Controller.text = MAT_PRI
          .elementAt(0)
          .MPS1_D
          .toString();
      MPS2Controller.text = MAT_PRI
          .elementAt(0)
          .MPS2_D
          .toString();
      MPS3Controller.text = MAT_PRI
          .elementAt(0)
          .MPS3_D
          .toString();
      MPS4Controller.text = MAT_PRI
          .elementAt(0)
          .MPS4_D
          .toString();
      update();
    }
  }

  //جلب تفاصيل الاصناف
  Future GET_MAT_INF_D_P(String GETMGNO, String GETMINO) async {
    MAT_INF_D = await GET_MAT_INF_D(GETMGNO, GETMINO);
    if (MAT_INF_D.isNotEmpty) {
      MIFR = MAT_INF_D.elementAt(0).MIFR;
    } else {
      MIFR = 2;
    }
  }

  //جلب رقم الحركة الفرعي
  Future GET_BMDID_P() async {
    BIF_MOV_D = await GET_BMDID(
        BMKID == 11 || BMKID == 12 ? 'BIF_MOV_D' : 'BIL_MOV_D', BMMID!);
    if (BIF_MOV_D.isNotEmpty) {
      BMDID = BIF_MOV_D
          .elementAt(0)
          .BMDID;
    }
  }

  Future<void> renumberbmdid(String TAB,String BMMID) async {
    var dbClient = await conn.database;

    // استرجاع كل الحركات الفرعية الخاصة بالحركة الرئيسية وترتيبها تصاعديًا حسب BMDID
    List<Map<String, dynamic>> subRows = await dbClient!.rawQuery(
        "SELECT BMDID FROM $TAB WHERE BMMID = ? ORDER BY BMDID ASC",
        [BMMID]
    );

    // إعادة ترقيم كل سجل بحيث يبدأ BMDID من 1
    for (int i = 0; i < subRows.length; i++) {
      int newBMDID = i + 1;
      await dbClient.update(
        "$TAB",
        {"BMDID": newBMDID},
        where: "BMDID = ?",
        whereArgs: [subRows[i]["BMDID"]],
      );
    }
  }

  //جلب اسم المجموعة
  Future GET_MGNA_P() async {
    MAT_GRO_LIST = await GET_MGNA(MGNOController.text);
    if (MAT_GRO_LIST.isNotEmpty) {
      MGNA = MAT_GRO_LIST
          .elementAt(0)
          .MGNA_D
          .toString();
    }
  }

  //جلب  المجموعة
  Future GET_MAT_GRO_P() async {
    MAT_GRO = await GET_MAT_GRO_ORD('0', STMID == 'MOB' ? 2 : 1);
    if (MAT_GRO.isNotEmpty) {
      SelectDataMGNO = MAT_GRO
          .elementAt(0)
          .MGNO
          .toString();
      await GET_MAT_INF_DATE(MAT_GRO
          .elementAt(0)
          .MGNO
          .toString(), SelectDataSCID.toString(),
          SelectDataBIID.toString(), BCPR!);
      await GET_RES_SEC_P(SelectDataBIID.toString());
      update();
    }
  }

  //جلب الاقسام
  Future GET_RES_SEC_P(String GETBIID) async {
    RES_SEC = await GET_RES_SEC(GETBIID);
    print('RES_SEC.length');
    print(RES_SEC.length);
    if (RES_SEC.isNotEmpty) {
      RSNA_TitleScreen = RES_SEC.elementAt(0).RSNA_D.toString();
      print(edit);
      print('edit');
      if (edit == false) {
        print(SelectDataRSID);
        print('SelectDataRSID');
        if (SelectDataRSID == null) {
          SelectDataRSID = RES_SEC.elementAt(0).RSID.toString();
          await GET_RES_TAB_P(RES_SEC.elementAt(0).RSID.toString());
          await GET_RES_EMP_P(RES_SEC
              .elementAt(0)
              .RSID
              .toString());
        }
        else {
          await GET_RES_TAB_P(SelectDataRSID.toString());
          await GET_RES_EMP_P(SelectDataRSID.toString());
        }
      } else {
        STMID == 'EORD' ? GET_BIF_MOV_A_P(BMMID.toString()) : null;
      }
    }
  }

  //جلب الطاولات
  Future GET_RES_TAB_P(String GETRSID) async {
    RES_TAB = await GET_RES_TAB(GETRSID);
    update();
  }

  //جلب موظفي الخدمة
  Future GET_RES_EMP_P(String GETRSID) async {
    RES_EMP = await GET_RES_EMP(GETRSID);
    update();
  }

  //جلب عدد تكرار الصنف
  Future GET_COUNT_MINO_P() async {
    COUNT_MINO_P = await GET_COUNT_MINO(BMKID == 11 || BMKID == 12 ? 'BIF_MOV_D' : 'BIL_MOV_D',
        BMMID!, MGNOController.text.toString(), SelectDataMINO.toString());
    if (COUNT_MINO_P.isNotEmpty) {
      COUNT_MINO = COUNT_MINO_P.elementAt(0).COUNT_MINO!;
    } else {
      COUNT_MINO = 0;
    }
  }

  //جلب باركود الصنف
  Future GET_BROCODE_P(String GetMGNO, String GetMINO, String GETMUID) async {
    MAT_UNI_B = await Get_BROCODE(GetMGNO, GetMINO, GETMUID);
    if (MAT_UNI_B.isNotEmpty) {
      MUCBCController.text = MAT_UNI_B
          .elementAt(0)
          .MUCBC
          .toString();
    }
  }

  //جلب اسم الوحده
  Future GET_MUNA_P(String GETMUID) async {
    await GET_MUNA(GETMUID).then((data) {
      MAT_UNI = data;
      if (MAT_UNI.isNotEmpty) {
        SelectDataMUCNA = MAT_UNI
            .elementAt(0)
            .MUNA_D
            .toString();
      }
    });
  }

  //اظهار البيانات +البحث
  GET_BIL_MOV_M_P(String type) async {
    BIL_MOV_M_List = await GET_BIL_MOV_M(
        BMKID == 11 || BMKID == 12 ? 'BIF_MOV_M' : 'BIL_MOV_M', BMKID!, TYPE_SHOW,
        TYPE_SHOW == "DateNow" ? DateFormat('dd-MM-yyyy').format(DateTime.now()) :
        TYPE_SHOW == "FromDate" ? SelectNumberOfDays : '', BMKID!,currentIndex,
        selectedBranchFrom.toString(),selectedBranchTo.toString(),FromDaysController.text,
        ToDaysController.text,SelectDataSCID_S.toString(),SelectDataPKID_S.toString(),2,TYPE_SER!);
    update();
  }


  //اظهار البيانات +البحث
  get_RETURN_SALE(String type) async {
    print('BMKID == 2 ? 1:BMKID!');
    print(BMKID);
    print(BMKID == 2 ? 1:BMKID!);
    RETURN_SALE_INV = await GET_BIL_MOV_M(BMKID == 11 || BMKID == 12 ? 'BIF_MOV_M' : 'BIL_MOV_M',
        BMKID == 4 ? 3 : BMKID == 12 ? 11 : BMKID == 2 ? 1 : BMKID!, type,
        type == "DateNow" ? DateFormat('dd-MM-yyyy').format(DateTime.now()) :
        type == "FromDate" ? SelectNumberOfDays : '', BMKID!,currentIndex,
        selectedBranchFrom.toString(),selectedBranchTo.toString(),FromDaysController.text,
        ToDaysController.text,SelectDataSCID_S.toString(),SelectDataPKID_S.toString(),1,TYPE_SER!);
    update();
  }

  //جلب الباركود
  Future FetchBarcodData(String barcod) async {
    if (barcod == '-1') {
      ClearBil_Mov_D_Data();
      Fluttertoast.showToast(
          msg: "error -1",
          toastLength: Toast.LENGTH_LONG,
          textColor: Colors.white,
          backgroundColor: Colors.redAccent);
      ClearBil_Mov_D_Data();
    } else {
      barcodData = await Get_BRO(SelectDataSIID!, barcod);
      if (barcodData.isEmpty) {
        Fluttertoast.showToast(
            msg: "لا يوجد صنف بهذا الباركود",
            toastLength: Toast.LENGTH_LONG,
            textColor: Colors.white,
            backgroundColor: Colors.redAccent);
        ClearBil_Mov_D_Data();
      } else {
        MGNOController.text = barcodData
            .elementAt(0)
            .MGNO
            .toString();
        MITSK = barcodData
            .elementAt(0)
            .MITSK;
        SelectDataMINO = barcodData
            .elementAt(0)
            .MINO
            .toString();
        MINAController.text = barcodData
            .elementAt(0)
            .MINA
            .toString();
        SelectDataMUID = barcodData
            .elementAt(0)
            .MUID
            .toString();
        SIID_V2 = SelectDataSIID.toString();
        MUCBCController.text = barcodData
            .elementAt(0)
            .MUCBC
            .toString();
        MITSK = barcodData
            .elementAt(0)
            .MITSK;
        MGKI = barcodData
            .elementAt(0)
            .MGKI;
        update();
        MIED = barcodData.elementAt(0).MIED;
        await GETSNDE_ONE();
        await GET_COUNT_MINO_P();
        BMDNOController.text = '0';
        BMDNO_V = 0;
        BMDNFController.text = '0';
        SUMBMDAMController.text = '0';
        BMDDIRController.text = '0';
        BMDDIController.text = '0';
        if (TTID1 != null) {
          await GET_TAX_LIN_P('MAT', barcodData.elementAt(0).MGNO.toString(),
              barcodData.elementAt(0).MINO.toString());
        }
        update();
        myFocusNode.requestFocus();
      }
    }
  }

  //جلب بيانات العميل-المورد مثل العنوان و الاسم والرقم الضريبي
  Future GET_BIL_CUS_IMP_INF_P(String GETBCID) async {
    if (BMKID == 1 || BMKID == 2) {
      BIL_IMP = await GET_BIL_IMP_INF(GETBCID);
      if (BIL_IMP.isNotEmpty) {
        //الاسم
        BCNA = BIL_IMP.elementAt(0).BINA.toString();
        //رقم البنايه
        BCBN = BIL_IMP.elementAt(0).BIBN == null
            ? '' : BIL_IMP.elementAt(0).BIBN.toString();
        //رقم الشارع
        BCSN = BIL_IMP
            .elementAt(0)
            .BISND == null
            ? ''
            : BIL_IMP
            .elementAt(0)
            .BISND
            .toString();
        //الحي/المنطقه
        BCQND = BIL_IMP
            .elementAt(0)
            .BIQND == null
            ? ''
            : BIL_IMP
            .elementAt(0)
            .BIQND
            .toString();
        //الرمز البريدي
        BCPC = BIL_IMP
            .elementAt(0)
            .BIPC == null
            ? ''
            : BIL_IMP
            .elementAt(0)
            .BIPC
            .toString();
        //رقم اضافي للعنوان
        BCAD2 = BIL_IMP
            .elementAt(0)
            .BIAD2 == null ? '' : BIL_IMP
            .elementAt(0)
            .BIAD2
            .toString();
        //رقم تسجيل ضريبة القيمه المضافه
        await GET_TAX_LIN_CUS_IMP_P('IMP', BIL_IMP
            .elementAt(0)
            .AANO
            .toString(), GETBCID);
        BCTX == 'null' || BCTX
            .toString()
            .isEmpty ?
        BCTX = BIL_IMP
            .elementAt(0)
            .BITX == null ? '' : BIL_IMP
            .elementAt(0)
            .BITX
            .toString() : '';
        update();
        //هاتف
        BCTL = BIL_IMP
            .elementAt(0)
            .BIMO == null
            ? ''
            : BIL_IMP
            .elementAt(0)
            .BIMO
            .toString();

        //رقم السجل التجاري
        BCC1 = BIL_IMP
            .elementAt(0)
            .BIC1 == null
            ? ''
            : BIL_IMP
            .elementAt(0)
            .BIC1
            .toString();
        //العنوان
        BCAD = BIL_IMP
            .elementAt(0)
            .BIAD == null
            ? ''
            : BIL_IMP
            .elementAt(0)
            .BIAD
            .toString();
        GET_COU_WRD_SAL(BIL_IMP
            .elementAt(0)
            .CWID
            .toString()).then((data) {
          COU_WRD = data;
          if (COU_WRD.isNotEmpty) {
            //الدولة
            CWNA = COU_WRD
                .elementAt(0)
                .CWNA
                .toString();
          }
        });
        GET_COU_TOW_SAL(BIL_IMP
            .elementAt(0)
            .CWID
            .toString(), BIL_IMP
            .elementAt(0)
            .CTID
            .toString()).then((data) {
          COU_TOW = data;
          if (COU_TOW.isNotEmpty) {
            //المدينه
            CTNA = COU_TOW
                .elementAt(0)
                .CTNA
                .toString();
          }
        });
        update();
      }
    } else {
      BIL_CUS = await GET_BIL_CUS_INF(GETBCID);
      if (BIL_CUS.isNotEmpty) {
        //الاسم
        BCNA = BIL_CUS.elementAt(0).BCNA.toString();
        //رقم البنايه
        BCBN = BIL_CUS.elementAt(0).BCBN == null ? '' : BIL_CUS.elementAt(0).BCBN.toString();
        //رقم الشارع
        BCSN = BIL_CUS.elementAt(0).BCSN == null
            ? '' : BIL_CUS.elementAt(0).BCSND.toString();
        //الحي/المنطقه
        BCQND = BIL_CUS.elementAt(0).BCQND == null
            ? '' : BIL_CUS.elementAt(0).BCQND.toString();
        //الرمز البريدي
        BCPC = BIL_CUS
            .elementAt(0)
            .BCPC == null
            ? ''
            : BIL_CUS
            .elementAt(0)
            .BCPC
            .toString();
        //رقم اضافي للعنوان
        BCAD2 = BIL_CUS
            .elementAt(0)
            .BCAD2 == null
            ? ''
            : BIL_CUS
            .elementAt(0)
            .BCAD2
            .toString();
        //رقم تسجيل ضريبة القيمه المضافه
        await GET_TAX_LIN_CUS_IMP_P('CUS', BIL_CUS
            .elementAt(0)
            .AANO
            .toString(), GETBCID);
        print('BCTX1111');
        print(BCTX);
        BCTX == 'null' || BCTX
            .toString()
            .isEmpty ?
        BCTX = BIL_CUS
            .elementAt(0)
            .BCTX == null ? '' : BIL_CUS
            .elementAt(0)
            .BCTX
            .toString() : null;
        update();
        //هاتف
        BCTL = BIL_CUS
            .elementAt(0)
            .BCMO == null
            ? ''
            : BIL_CUS
            .elementAt(0)
            .BCMO
            .toString();
        print(BCTL);
        print('BCTL');
        //رقم السجل التجاري
        BCC1 = BIL_CUS
            .elementAt(0)
            .BCC1 == null
            ? ''
            : BIL_CUS
            .elementAt(0)
            .BCC1
            .toString();
        //العنوان
        BCAD = BIL_CUS
            .elementAt(0)
            .BCAD == null
            ? ''
            : BIL_CUS
            .elementAt(0)
            .BCAD
            .toString();
        print('BCAD2');
        print(BCAD2);
        print(BIL_CUS
            .elementAt(0)
            .BCAD2);
        GET_COU_WRD_SAL(BIL_CUS
            .elementAt(0)
            .CWID
            .toString()).then((data) {
          COU_WRD = data;
          if (COU_WRD.isNotEmpty) {
            //الدولة
            CWNA = BIL_CUS
                .elementAt(0)
                .CWID == null
                ? ''
                : COU_WRD
                .elementAt(0)
                .CWNA
                .toString();
          }
        });
        GET_COU_TOW_SAL(BIL_CUS
            .elementAt(0)
            .CWID
            .toString(),
            BIL_CUS
                .elementAt(0)
                .CTID
                .toString())
            .then((data) {
          COU_TOW = data;
          if (COU_TOW.isNotEmpty) {
            //المدينه
            CTNA = COU_TOW
                .elementAt(0)
                .CTID == null
                ? ''
                : COU_TOW
                .elementAt(0)
                .CTNA
                .toString();
          }
        });
        update();
      }
    }
  }

  //دالة التقريب
  double roundDouble(double value, int places) {
    num mod = pow(10.0, places);
    return ((value * mod).round().toDouble() / mod);
  }

  //تنطيف Bil_Mov_D
  ClearBil_Mov_D_Data() {
    MINAController.clear();
    BMDNFController.clear();
    BMDNOController.clear();
    MGNOController.clear();
    MGNOController.text = '';
    SelectDataMUCNA = null;
    SIID_V2 = null;
    SelectDataMUCNA = '';
    SelectDataMINO = '';
    SelectDataSNED = '';
    SelectDataSNED = null;
    SelectDataRTID = null;
    // SelectDataMGNO = null;
    BMDAMController.clear();
    BMDINController.clear();
    BMDEDController.clear();
    SUMBMDAMController.clear();
    SUMBMDAMController.clear();
    MPCOController.clear();
    MPCO_VController.clear();
    BMDTXAController.clear();
    BMDNOController.text = '0';
    BMDNO_V = 0;
    BMDNFController.text = '0';
    BMDAMController.text = '0';
    BMDAMTXController.text = '0';
    SUMBMDAMController.text = '0';
    BMDDIRController.text = '0';
    BMDDIController.text = '0';
    BMDTXAController.text = '0';
    MPCOController.text = '0';
    MPCO_VController.text = '0';
    SUMBMDAMTController.text = '0';
    TOTSUMBMDAM = 0;
    SUM_Totle_BMDDI = 0;
    SUMBMDDI = 0;
    SUMBMDDIR = 0;
    SUMBMDAM = 0;
    SUM_BMDAM = 0;
    BMDAM1 = 0;
    SUM_BMDAM2 = 0;
    BMDAM2 = 0;
    MPS1 = 0;
    BDNO_F = 0.0;
    BDNO_F2 = 0.0;
    BMDDIR = 0;
    BMDTXT1 = 0;
    BMDTXT2 = 0;
    BMDTXT3 = 0;
    BMDIDController.clear();
    BMDTXTController.text = '0';
    SUMBMDAMTFController.text = '0';
    BMDDITController.text = '0';
    MPS1Controller.text = '0';
    MPS2Controller.text = '0';
    MPS3Controller.text = '0';
    MPS4Controller.text = '0';
    CHIN_NO = 1;
    MPCO_V = 0;
    MPCO = 0;
    BMDNO = 0;
    V_FROM = 0;
    V_TO = 0;
    V_KIN = 0;
    V_N1 = 0;
    MITSK = 0;
    SUM_STRING_NUMBER = '';
    titleAddScreen = 'StringAdd'.tr;
    TextButton_title = 'StringAdd'.tr;
    print('STP-7');
  }

  //جلب رقم الحركة
  Future GET_BMMNO_P() async {
    BIL_MOV_M = await GET_BMMNO(BMKID == 11 || BMKID == 12 ? 'BIF_MOV_M' : 'BIL_MOV_M', BMKID.toString());
    if (BIL_MOV_M.isNotEmpty) {
      print(BIL_MOV_M.elementAt(0).BMMNO);
      BIL_MOV_M.elementAt(0).BMMNO.toString().length <= 1 ? BMMNO = LoginController().PKID1 :
      BMMNO = BIL_MOV_M.elementAt(0).BMMNO.toString();
      print(BIL_MOV_M.elementAt(0).BMMNO.toString());
      print(LoginController().PKID1);
      print(BMMNO);
      print('GET_BMMNO_P');
    }
  }

  //جلب رقم الحركة
  Future GET_BMMNO_P_COU() async {
    String ToDate = '';
    P_ZERO.toString() == '1' ?
    ToDate = DateFormat('yyyy').format(DateTime.now()) : P_ZERO.toString() ==
        '2' ?
    ToDate = DateFormat('MM').format(DateTime.now()) : ToDate =
        DateFormat('dd').format(DateTime.now());
    await GET_BMMNO_COU(
        P_ZERO.toString(), SVVL_NO.toString(), SelectDataPKID.toString(),
        ToDate).then((data) {
      BIL_MOV_M = data;
      print(BIL_MOV_M
          .elementAt(0)
          .BMMNO
          .toString());
      print('BMMNO');
      if (BIL_MOV_M.isNotEmpty) {
        if (SVVL_NO == '1') {
          print('BMMNO1');
          if (SelectDataPKID.toString() == '1' ||
              SelectDataPKID.toString() == '8') {
            print('BMMNO2');
            BIL_MOV_M
                .elementAt(0)
                .BMMNO
                .toString()
                .length <= 1 ? BMMNO = LoginController().PKID1 : BMMNO =
                BIL_MOV_M
                    .elementAt(0)
                    .BMMNO
                    .toString();
          } else if (SelectDataPKID.toString() == '3') {
            print('BMMNO3');
            BIL_MOV_M
                .elementAt(0)
                .BMMNO
                .toString()
                .length <= 1 ? BMMNO = LoginController().PKID2 : BMMNO =
                BIL_MOV_M
                    .elementAt(0)
                    .BMMNO
                    .toString();
          }
        }
        else {
          print(LoginController().PKID1);
          print('LoginController().PKID1');
          BIL_MOV_M
              .elementAt(0)
              .BMMNO
              .toString()
              .length <= 1 ?
          BMMNO = LoginController().PKID1.toString() :
          BMMNO = BIL_MOV_M
              .elementAt(0)
              .BMMNO
              .toString();
          print(LoginController().PKID1);
          print('BMMNO');
        }
      }
    });
  }

  //جلب رقم الحركة
  Future GET_BMMID_P() async {
    BIL_MOV_M =
    await GET_BMMID(BMKID == 11 || BMKID == 12 ? 'BIF_MOV_M' : 'BIL_MOV_M');
    if (BIL_MOV_M.isNotEmpty) {
      BMMID = BIL_MOV_M.elementAt(0).BMMID;
      update();
      LoginController().SET_N_P('BMMID', BIL_MOV_M.elementAt(0).BMMID!);
    }
    update();
  }

  setSelectedPay_Kin(int V) {
    PKID = V;
    SelectDataPKID = PKID.toString();
    update();
    loading(false);
  }

  // جلب  اجمالي الضريبه
  GET_SUMBMDTXA() async {
    SUM_TOT = await COUNT_BMDTXA(BMKID == 11 || BMKID == 12 ? 'BIF_MOV_D' : 'BIL_MOV_D', BMMID!);
    if (SUM_TOT.isEmpty) {
      SUMBMDTXA = 0.0;
    } else {
      SUMBMDTXA = roundDouble(SUM_TOT.elementAt(0).SUM_BMDTXA!, SCSFL);
    }
  }

  //BMDTXA*BMDNO جلب  اجمالي الضريبه
  GET_SUMBMDTXT() async {
    SUM_TOT = await SUM_BMDTXT(
        BMKID == 11 || BMKID == 12 ? 'BIF_MOV_D' : 'BIL_MOV_D', BMMID!);
    if (SUM_TOT.isEmpty) {
      SUMBMDTXT = 0.0;
      SUMBMDTXT1 = 0.0;
      SUMBMDTXT2 = 0.0;
      SUMBMDTXT3 = 0.0;
      SUMBMDTXTController.text = '0';
    } else {
      SUMBMDTXT = roundDouble(SUM_TOT
          .elementAt(0)
          .SUM_BMDTXT!, SCSFL);
      SUMBMDTXT1 = roundDouble(SUM_TOT
          .elementAt(0)
          .SUM_BMDTXT1!, SCSFL);
      SUMBMDTXT2 = roundDouble(SUM_TOT
          .elementAt(0)
          .SUM_BMDTXT2!, SCSFL);
      SUMBMDTXT3 = roundDouble(SUM_TOT
          .elementAt(0)
          .SUM_BMDTXT3!, SCSFL);
      SUMBMDTXTController.text = roundDouble(SUM_TOT
          .elementAt(0)
          .SUM_BMDTXT!, SCSFL).toString();
      update();
    }
  }

  // جلب اجمالي المجاني
  GET_SUMBMMDIF() async {
    SUM_TOT = await SUM_BMMDIF(
        BMKID == 11 || BMKID == 12 ? 'BIF_MOV_D' : 'BIL_MOV_D', BMMID!);
    if (SUM_TOT.isEmpty) {
      SUMBMMDIF = 0.0;
      SUMBMMDIFController.text = '0';
    } else {
      SUMBMMDIF = roundDouble(SUM_TOT
          .elementAt(0)
          .BMMDIF!, SCSFL);
      SUMBMMDIFController.text = roundDouble(SUM_TOT
          .elementAt(0)
          .BMMDIF!, SCSFL).toString();
    }
  }

  // جلب اجمالي التخفيض
  GET_SUMBMMDI() async {
    SUM_TOT = await SUM_BMMDI(
        BMKID == 11 || BMKID == 12 ? 'BIF_MOV_D' : 'BIL_MOV_D', BMMID!);
    if (SUM_TOT.isEmpty) {
      SUMBMMDI = 0.0;
    } else {
      SUMBMMDI = roundDouble(SUM_TOT
          .elementAt(0)
          .BMMDI!, SCSFL);
      SelectDataBMMDN == '1' ? BMMDIController.text = roundDouble(SUM_TOT
          .elementAt(0)
          .BMMDI!, SCSFL).toString() : '';
    }
  }

  // جلب  اجمالي المبلغ
  GET_SUMBMMAM() async {
    SUM_TOT = await SUM_BMMAM(
        BMKID == 11 || BMKID == 12 ? 'BIF_MOV_D' : 'BIL_MOV_D', BMMID!);
    if (SUM_TOT.isEmpty) {
      BMMAMController.text = '0.0';
    } else {
      BMMAMController.text = roundDouble(SUM_TOT
          .elementAt(0)
          .SUM_BMDAM!, SCSFL).toString();
      update();
    }
    update();
    await GET_BMMAM_TX();
    await GET_BMMDI_TX();
    await GET_TCAM();
  }

  // جلب  صافي المبلغ
  GET_SUMBMMAM2() async {
    SUM_TOT = await SUM_BMMAM2(
        BMKID == 11 || BMKID == 12 ? 'BIF_MOV_D' : 'BIL_MOV_D', BMMID!);
    if (SUM_TOT.isEmpty) {
      BMMAMTOTController.text = '0.0';
    }
    BMMAMTOTController.text = roundDouble(SUM_TOT
        .elementAt(0)
        .SUM_TOTBMDAM!, SCSFL).toString();
    update();
  }


  //جلب رصيد غير مرحل
  GET_BAL_P(BMMID,AANO,SCID) async {
    SUMBAL = 0.0;
    SUM_M = await SUM_BAL(1,BMMID,AANO.toString(), SCID,LastBAL_ACC_C.toString());
    if (SUM_M.isEmpty) {
      SUMBAL = 0.0;
    } else {
      SUMBAL = SUM_M.elementAt(0).SUM_BAL;
      update();
    }
    update();
    print('SUMBAL');
    print(SUMBAL);
    update();
  }

  //جلب عدد  السجلات
  GET_CountRecode(int GETBMMID) async {
    COUNT_RECODE = await CountRecode(
        BMKID == 11 || BMKID == 12 ? 'BIF_MOV_D' : 'BIL_MOV_D', GETBMMID, 1);
    if (COUNT_RECODE.isEmpty) {
      CountRecodeController.text = '0';
    } else {
      CountRecodeController.text = COUNT_RECODE.elementAt(0).COU.toString();
      await UpdateBMMNR(BMKID == 11 || BMKID == 12 ? 'BIF_MOV_M' : 'BIL_MOV_M',
          COUNT_RECODE.elementAt(0).COU.toString(), GETBMMID);
      update();
    }
    await CountRecode(
        BMKID == 11 || BMKID == 12 ? 'BIF_MOV_D' : 'BIL_MOV_D', GETBMMID, 2)
        .then((data) {
      if (data.isEmpty) {
        COUNTRecode_ORD = 0;
      } else {
        COUNTRecode_ORD = data.elementAt(0).COU!;
        update();
      }
    });
    update();
  }

  //جلب اجمالي القطع
  GET_COUNT_BMDNO_P(int GETBMMID) async {
    COUNT_RECODE = await GET_COUNT_BMDNO(
        BMKID == 11 || BMKID == 12 ? 'BIF_MOV_D' : 'BIL_MOV_D', GETBMMID);
    if (COUNT_RECODE.isEmpty) {
      COUNTBMDNO = 0;
      COUNTBMDNOController.text = '0';
    } else {
      COUNTBMDNOController.text = COUNT_RECODE
          .elementAt(0)
          .COUNT_BMDNO
          .toString();
      update();
    }
    update();
  }

  //اجمالي المبلغ-خصومات+ضريبه
  GET_SUM_AM_TXT_DI() async {
    COUNT_RECODE = await SUM_AM_TXT_DI(
        BMKID == 11 || BMKID == 12 ? 'BIF_MOV_D' : 'BIL_MOV_D', BMMID!);
    if (COUNT_RECODE.isEmpty) {
      SUM_AM_TXT_DI_V = 0;
    } else {
      SUM_AM_TXT_DI_V = COUNT_RECODE
          .elementAt(0)
          .SUM_AM_TXT_DI;
      update();
    }
  }

  // اجمالي BMDAM_TX
  GET_BMMAM_TX() async {
    COUNT_RECODE = await SUM_BMDAM_TX(
        BMKID == 11 || BMKID == 12 ? 'BIF_MOV_D' : 'BIL_MOV_D', BMMID!);
    if (COUNT_RECODE.isEmpty) {
      BMMAM_TX = 0;
    } else {
      BMMAM_TX = COUNT_RECODE
          .elementAt(0)
          .BMDAM_TX;
      update();
    }
  }

  // اجمالي BMDDI_TX
  GET_BMMDI_TX() async {
    COUNT_RECODE = await SUM_BMDDI_TX(
        BMKID == 11 || BMKID == 12 ? 'BIF_MOV_D' : 'BIL_MOV_D', BMMID!);
    if (COUNT_RECODE.isEmpty) {
      BMMDI_TX = 0;
    } else {
      BMMDI_TX = COUNT_RECODE
          .elementAt(0)
          .BMDDI_TX;
      update();
    }
  }

  // اجمالي TCAM
  GET_TCAM() async {
    COUNT_RECODE = await SUM_TCAMT(
        BMKID == 11 || BMKID == 12 ? 'BIF_MOV_D' : 'BIL_MOV_D', BMMID!);
    if (COUNT_RECODE.isEmpty) {
      TCAM = 0;
    } else {
      TCAM = COUNT_RECODE
          .elementAt(0)
          .TCAMT;
      update();
    }
  }

  Future GET_BIL_MOV_M_PRINT_P(int GETBMMID) async {
    BIF_MOV_M_PRINT = await GET_BIL_MOV_M_PRINT(
        BMKID == 11 || BMKID == 12 ? 'BIF_MOV_M' : 'BIL_MOV_M',
        GETBMMID.toString());
    update();
  }

  //جلب السجلات الفرعية للفاتورة
  Future GET_BIF_MOV_D_P(String GetBMMID, String GETTYPE_SHOW) async {
    var data = await GET_BIL_MOV_D(
        BMKID == 11 || BMKID == 12 ? 'BIF_MOV_D' : 'BIL_MOV_D',
        GetBMMID, SER_MINA.toString(), RINT_RELATED_ITEMS_DETAIL.toString());
    InvoiceList = data;
    cartFood = data;
    update();
  }


  Future GET_BIF_MOV_D_SHOW(String GetBMMID) async {
    BIL_MOV_D_SHOW = await GET_BIL_MOV_D(
        BMKID == 11 || BMKID == 12 ? 'BIF_MOV_D' : 'BIL_MOV_D', GetBMMID,
        SER_MINA.toString(), '2');
    update();
  }

  // احتساب المبلغ المتبقي
  Calculate_BMMTC(String GETBMMCP, String GETSCID) async {
    if (int.parse(GETSCID.toString()) == int.parse(SelectDataSCID.toString())) {
      BMMTC = roundDouble(
          double.parse(GETBMMCP) - double.parse(BMMAMTOTController.text), 6);
      BMMTC_TOT = roundDouble(double.parse(GETBMMCP), 6);
      BMMCP = double.parse(GETBMMCP);
    } else {
      await GET_SYS_CUR_BET_P(
          SelectDataSCIDP.toString(), SelectDataSCID.toString(), GETBMMCP);
    }
    update();
  }

  //وسعر الوحدة  دالة احتساب الكميه والمجاني
  Calculate_BMD_NO_AM() {
    print('Calculate_BMD_NO_AM');
    print(USING_TAX_SALES);
    print(Price_include_Tax);
    print(UPIN_USING_TAX_SALES);
    //الكميه الحقيقه
    //التحقق من المتغير رقم 431 هل المجاني ضمن الكميه ام لا وعليه عندما يكون المتغير المجاني ضمن العدد يتم عند الحفظ انقاص المجاني من العدد وحفظه في حقل BMDNO
    USE_BMDFN == '1' ? BMDNO_V = double.parse(BMDNOController.text)
        : BMDNO_V =
    (double.parse(BMDNOController.text) - double.parse(BMDNFController.text));

    BMDAM1 =
    BMDAMController.text.isEmpty ? 0 : double.parse(BMDAMController.text);

    if (USING_TAX_SALES == '1' || (USING_TAX_SALES == '3'
        && (UPIN_USING_TAX_SALES == 1 && Price_include_Tax == true))) {
      print('BMDAMController.text');
      print(BMDAMController.text);

      BMDTXA_V = roundDouble(double.parse(BMDAMController.text) *
          (100 / (100 + (double.parse(BMDTXController.text) * TCVL!))), 6);

      //احتساب مبلغ الضريبه
      if (TTID2 != null) {
        BMDTXA2 = roundDouble((BMDTXA_V! *
            ((double.parse(BMDTX2Controller.text) / 100) * TCVL2!)), 6);
      }
      else {
        BMDTXA2 = 0;
      }

      ['<$TTID2>'].contains(TTIDC1) ? BMDTXA = roundDouble(
          (double.parse(BMDAMController.text) - BMDTXA_V!) + (BMDTXA2! *
              (double.parse(BMDTXController.text) / 100)), 6) :
      BMDTXA = roundDouble((double.parse(BMDAMController.text) -
          (double.parse(BMDAMController.text) *
              (100 / (100 + (double.parse(BMDTXController.text) * TCVL!))))),
          6);


      if (TTID3 != null) {
        BMDTXA3 = roundDouble((double.parse(BMDAMController.text) -
            (double.parse(BMDAMController.text) *
                (100 /
                    (100 + (double.parse(BMDTX3Controller.text) * TCVL3!))))),
            6);
      }
      else {
        BMDTXA3 = 0;
      }

      //احتساب سعر الوحدة مع سعر شامل الضريبه
      ['<$TTID2>'].contains(TTIDC1) ? BMDAMTXController.text =
          roundDouble(BMDTXA_V!, 8).toString() :

      BMDAMTXController.text = roundDouble(double.parse(BMDAMController.text) -
          (BMDTXA! + BMDTXA2! + BMDTXA3!), 6).toString();

      BMDAM1 =
      BMDAMController.text.isEmpty ? 0 : double.parse(BMDAMTXController.text);
      print('BMDAM1');
      print(BMDAM1);
      print(BMDAMTXController.text);

      //اجمالي المبلغ الكميه في السعر
      SUMBMDAMController.text = roundDouble(BMDAM1! * BMDNO_V!, 6).toString();
      update();
    }
    else {
      BMDAM1 =
      BMDAMController.text.isEmpty ? 0 : double.parse(BMDAMController.text);
      //اجمالي المبلغ
      SUMBMDAMController.text = roundDouble(BMDAM1! * BMDNO_V!, 6).toString();
    }

    print('BMDAMTXController');
    print(BMDAM1);
    print(BMDNOController.text);
    print(BMDAMController.text);
    print(SUMBMDAMController.text);
    //اجمالي المجاني
    SUMBMDAMTFController.text =
        roundDouble(BMDAM1! * double.parse(BMDNFController.text), 6).toString();
    // دالة احتساب نسبه الخصم و مبلغ الخصم
    Calculate_BMDDI_IR();
  }

  // دالة احتساب نسبه الخصم و مبلغ الخصم
  Calculate_BMDDI_IR() {
    //اجمالي مبلغ التخفيض
    SUMBMDDI = roundDouble(BMDNO_V! * double.parse(BMDDIController.text), 6);
    //اجمالي نسبه التخفيض
    SUMBMDDIR = roundDouble((double.parse(SUMBMDAMController.text) *
        (double.parse(BMDDIRController.text) / 100)), 6);
    //مبلغ التخفيض على مستوي للصنف
    BMDDITController.text = roundDouble(double.parse(BMDDIController.text) +
        (((double.parse(BMDDIRController.text) / 100) * BMDAM1!)), 6)
        .toString();
    //الاجمالي المبلغ الكلي للتخفيض
    SUM_Totle_BMDDI =
        roundDouble(double.parse(BMDDITController.text) * BMDNO_V!, 6);
    GET_USING_TAX_P();
    update();
  }

  //  `دالة احتساب الضريبه و الاجمالي
  GET_USING_TAX_P() {
    // if(MITSK==1){
    (BMDAM1.isNull) ? BMDAM1 = 0 : BMDAM1 = BMDAM1;

    if (TTID2 != null) {
      if (TSDI2 == 1) {
        BMDTXA2 = roundDouble(
            (BMDAM1!) * ((double.parse(BMDTX2Controller.text) * TCVL2!) / 100),
            6);
      } else {
        BMDTXA2 = roundDouble((BMDAM1! - double.parse(BMDDITController.text)) *
            ((double.parse(BMDTX2Controller.text) * TCVL2!) / 100), 6);
      }
    } else {
      BMDTXA2 = 0;
    }


    print(['<$TTID2>'].contains(TTIDC1));

    if (TSDI1 == 1) {
      //BMDTXA = roundDouble((BMDAM1! - double.parse(BMDDITController.text)) * ((double.parse(BMDTXController.text) * TCVL!) / 100), 6);
      BMDTXA = ['<$TTID2>'].contains(TTIDC1) ?
      roundDouble((BMDAM1! + BMDTXA2!) *
          ((double.parse(BMDTXController.text) * TCVL!) / 100), 6) :
      roundDouble(
          (BMDAM1!) * ((double.parse(BMDTXController.text) * TCVL!) / 100), 6);
    } else {
      //BMDTXA = roundDouble((BMDAM1! - double.parse(BMDDITController.text)) * ((double.parse(BMDTXController.text) * TCVL!) / 100), 6);
      BMDTXA = ['<$TTID2>'].contains(TTIDC1) ?
      roundDouble((BMDAM1! - double.parse(BMDDITController.text) + BMDTXA2!) *
          ((double.parse(BMDTXController.text) * TCVL!) / 100), 6) :
      roundDouble((BMDAM1! - double.parse(BMDDITController.text)) *
          ((double.parse(BMDTXController.text) * TCVL!) / 100), 6);
    }


    if (TTID3 != null) {
      if (TSDI3 == 1) {
        BMDTXA3 = roundDouble((BMDAM1!) *
            ((double.parse(BMDTX3Controller.text) * TCVL3!) / 100), 6);
      } else {
        BMDTXA3 = roundDouble((BMDAM1! - double.parse(BMDDITController.text)) *
            ((double.parse(BMDTX3Controller.text) * TCVL3!) / 100), 6);
      }
    } else {
      BMDTXA3 = 0;
    }

    // BMDTXA = roundDouble((double.parse(SUMBMDAMController.text) * (double.parse(BMDTXController.text) / 100)), 6);
    BMDTXAController.text = (BMDTXA! + BMDTXA2! + BMDTXA3!).toString();
    update();
    // اجمالي الضريبه
    BMDTXT1 = roundDouble(BMDTXA! * BMDNO_V!, 6);
    BMDTXT2 = roundDouble(BMDTXA2! * BMDNO_V!, 6);
    BMDTXT3 = roundDouble(BMDTXA3! * BMDNO_V!, 6);

    BMDTXTController.text =
        roundDouble((BMDTXA! + BMDTXA2! + BMDTXA3!) * BMDNO_V!, 6).toString();

    update();

    //  احتساب الاجمالي الكلي على مستوى الصنف
    SUMBMDAMTController.text = formatter.format(roundDouble(
        (double.parse(SUMBMDAMController.text) +
            double.parse(BMDTXTController.text)) -
            SUM_Totle_BMDDI!, SCSFL)).toString();
    TOTSUMBMDAM = roundDouble((double.parse(SUMBMDAMController.text) +
        double.parse(BMDTXTController.text)) -
        SUM_Totle_BMDDI!, SCSFL);
    update();
  }

  //تعديل الخصم
  Future UPDATE_BMMDI() async {
    if (SelectDataBMMDN == '0' && BMMDIRController.text.isNotEmpty &&
        double.parse(BMMDIRController.text) > 0) {
      await Future.delayed(const Duration(milliseconds: 300));
      // احتساب مبلغ التخفيض على مستوى الفاتورة
      BMMDIController.text = roundDouble((double.parse(BMMAMController.text) *
          (double.parse(BMMDIRController.text) / 100)), SCSFL).toString();
    }
    await Future.delayed(const Duration(milliseconds: 500));
    await UpdateBIL_MOV_D_BMDDI(
        BMKID == 11 || BMKID == 12 ? 'BIF_MOV_D' : 'BIL_MOV_D',
        BMMID.toString(),
        double.parse(BMMAMController.text),
        SUMBMMDIF!,
        double.parse(BMMDIController.text),
        0,
        USE_BMDFN!);
    update();
    // await Future.delayed(const Duration(milliseconds: 800));
    await GET_SUMBMDTXA();
    await GET_SUMBMMDI();
    await GET_SUMBMMAM2();
    await GET_SUMBMDTXT();
    update();
  }

  //حالة الحفظ
  editMode() async{
    print('editMode');
    contentFocusNode.unfocus();
    bool isValidate = true;
    if (isValidate == false) {
      isloadingvalidator(false);
    } else {
      STMID == 'MOB' ? await calculateDistanceBetweenLocations() : null;
      if (Get.arguments == null && edit == false) {
        if (CheckBack == 0 || CountRecodeController.text == '0') {
          Get.snackbar('StringCHK_Save_Err'.tr, 'StringCHK_Save'.tr,
              backgroundColor: Colors.red,
              icon: const Icon(Icons.error, color: Colors.white),
              colorText: Colors.white,
              isDismissible: true,
              dismissDirection: DismissDirection.horizontal,
              forwardAnimationCurve: Curves.easeOutBack);
        } else {
          Save_BIL_MOV_M(edit);
        }
      } else {
        Save_BIL_MOV_M(edit);
        //  _updateItem(Get.arguments);
      }
    }
  }


  //حفظ فاتورة فرعي
  Future<bool> Save_BIL_MOV_D_P() async {
    try {
      STB_N = 'S1';
      await GET_BMDID_P();
      GUIDD = uuid.v4();
      BMDNFController.text.isEmpty
          ? BMDNFController.text = '0'
          : BMDNFController.text = BMDNFController.text;
      bool isValidate = ADD_EDformKey.currentState!.validate();
      if (isValidate == false) {
        loading(true);
      } else {
        if ((SelectDataMINO == null || SelectDataMINO.toString().isEmpty) &&
            (SelectDataMUID == null || SelectDataMUID.toString().isEmpty)) {
          Fluttertoast.showToast(
              msg: "يجب تعبئة جميع البيانات",
              toastLength: Toast.LENGTH_LONG,
              textColor: Colors.white,
              backgroundColor: Colors.redAccent);
          STB_N = 'S2';
          return false;
        }
        else if (!BMDNOController.text.isNum) {
          Fluttertoast.showToast(
              msg: 'StrinReq_SMDFN_NUM'.tr,
              toastLength: Toast.LENGTH_LONG,
              textColor: Colors.white,
              backgroundColor: Colors.redAccent);
          STB_N = 'S3';
          return false;
        }
        else if (double.parse(BMDNOController.text) < 0.0) {
          Fluttertoast.showToast(
              msg: 'StrinReq_SMDFN'.tr,
              toastLength: Toast.LENGTH_LONG,
              textColor: Colors.white,
              backgroundColor: Colors.redAccent);
          STB_N = 'S4';
          return false;
        }
        // else if (BMDAM1! <= 0.0 && MIFR == 2) {
        //   Fluttertoast.showToast(
        //       msg: 'StrinReq_BMDAM_Vlaue'.tr,
        //       toastLength: Toast.LENGTH_LONG,
        //       textColor: Colors.white,
        //       backgroundColor: Colors.redAccent);
        //   STB_N = 'S5';
        //   return false;
        // }
        else if (double.parse(BMDNFController.text) < 0.0) {
          Fluttertoast.showToast(
              msg: 'StrinReq_SMDFN'.tr,
              toastLength: Toast.LENGTH_LONG,
              textColor: Colors.white,
              backgroundColor: Colors.redAccent);
          STB_N = 'S6';
          return false;
        }
        // else if (TOTSUMBMDAM! <= 0.0 && MIFR == 2) {
        //   Fluttertoast.showToast(
        //       msg: 'StrinReq_SUMBMDAM'.tr,
        //       toastLength: Toast.LENGTH_LONG,
        //       textColor: Colors.white,
        //       backgroundColor: Colors.redAccent);
        //   STB_N = 'S6';
        //   return false;
        // }
        else if (MGKI == 1 && lARGEST_VALUE_QUANTITY != 0 &&
            double.parse(BMDNOController.text) > lARGEST_VALUE_QUANTITY) {
          Fluttertoast.showToast(
              msg: 'StrinlARGEST_VALUE_QUANTITY'.tr,
              toastLength: Toast.LENGTH_LONG,
              textColor: Colors.white,
              backgroundColor: Colors.redAccent);
          STB_N = 'S8';
          return false;
        } else if (MGKI == 2 && lARGEST_VALUE_QUANTITY2 != 0 &&
            double.parse(BMDNOController.text) > lARGEST_VALUE_QUANTITY2) {
          Fluttertoast.showToast(
              msg: 'StrinlARGEST_VALUE_QUANTITY'.tr,
              toastLength: Toast.LENGTH_LONG,
              textColor: Colors.white,
              backgroundColor: Colors.redAccent);
          STB_N = 'S8';
          return false;
        } else if (MGKI == 1 && lARGEST_VALUE_PRICE != 0 &&
            BMDAM1! > lARGEST_VALUE_PRICE) {
          Fluttertoast.showToast(
              msg: 'StrinlARGEST_VALUE_PRICE'.tr,
              toastLength: Toast.LENGTH_LONG,
              textColor: Colors.white,
              backgroundColor: Colors.redAccent);
          STB_N = 'S9';
          return false;
        } else if (MGKI == 2 && lARGEST_VALUE_PRICE2 != 0 &&
            BMDAM1! > lARGEST_VALUE_PRICE2) {
          Fluttertoast.showToast(
              msg: 'StrinlARGEST_VALUE_PRICE'.tr,
              toastLength: Toast.LENGTH_LONG,
              textColor: Colors.white,
              backgroundColor: Colors.redAccent);
          STB_N = 'S9';
          return false;
        } else if (SelectDataBMMDN == '1' &&
            double.parse(BMDDITController.text) > BMDAM1!) {
          Fluttertoast.showToast(
              msg: 'StringErr_SUM_BMDDI'.tr,
              toastLength: Toast.LENGTH_LONG,
              textColor: Colors.white,
              backgroundColor: Colors.redAccent);
          STB_N = 'S10';
          return false;
        } else if (SelectDataBMMDN == '1' &&
            double.parse(BMDDIRController.text) > 100) {
          Fluttertoast.showToast(
              msg: 'StringErr_SUM_BMDDI'.tr,
              toastLength: Toast.LENGTH_LONG,
              textColor: Colors.white,
              backgroundColor: Colors.redAccent);
          STB_N = 'S11';
          return false;
        } else if (MGKI == 1 && BMKID != 1 && BMKID != 2 && BMKID != 12 && BMKID != 4 &&
            (Show_Items == '2' || Show_Items == '3' && Allow_Show_Items == 2) &&
            (double.parse(BMDNOController.text) > BDNO_F)) {
          Get.defaultDialog(
            title: 'StringMestitle'.tr,
            middleText: 'StringChk_BMDNO'.tr,
            backgroundColor: Colors.white,
            radius: 40,
            textCancel: 'StringOK'.tr,
            cancelTextColor: Colors.blueAccent,
            barrierDismissible: false,
          );
          STB_N = 'S12';
          return false;
        } else {
          BMDAM_TX = BMDAM1! + BMDTXA2!;

          BMDNF =
          BMDNFController.text.isEmpty ? 0 : double.parse(BMDNFController.text);

          BMDDI_TX = (roundDouble(
              (((double.parse(BMDDIController.text) + ((BMDAM1! + BMDTXA2!)
                  * (0 / 100))) * BMDNO_V!) +
                  (BMDNF! <= 0 ? 0 : BMDAM1! * BMDNF!)), SCSFL)) /
              (BMDNO_V! + BMDNF!);

          BMDAMT3 =
              roundDouble((BMDAM_TX! - BMDDI_TX!) * (BMDNO_V! + BMDNF!), SCSFL);

          if (BMDNO_V! > 0) {
            TCAMT = roundDouble(
                (BMDAMT3! * (TCRA! / 100)) / BMDNO_V! * BMDNO_V!, SCSFL_TX);
          } else {
            TCAMT = 0;
          }

          if (BMDIDController.text.isNotEmpty) {
            MES_ADD_EDIT = 'StringED'.tr;
            STB_N = 'S13';
            UpdateBil_Mov_D(
                BMKID == 11 || BMKID == 12 ? 'BIF_MOV_D' : 'BIL_MOV_D',
                BMKID!,
                BMMID!,
                int.parse(BMDIDController.text.toString()),
                MGNOController.text,
                SelectDataMINO.toString(),
                int.parse(SelectDataMUID.toString()),
                SIID_V2,
                double.parse(BMDNFController.text),
                BMDNO_V!,
                SelectDataSNED.toString(),
                BMDAM1!,
                double.parse(BMDDIController.text),
                double.parse(BMDDIRController.text),
                roundDouble(BMDAM1! * double.parse(SCEXController.text), 6),
                double.parse(BMDTXController.text) +
                    double.parse(BMDTX2Controller.text) +
                    double.parse(BMDTX3Controller.text),
                BMDTXController.text.isEmpty ? 0 : double.parse(
                    BMDTXController.text),
                BMDTX2Controller.text.isEmpty ? 0 : double.parse(
                    BMDTX2Controller.text),
                BMDTX3Controller.text.isEmpty ? 0 : double.parse(
                    BMDTX3Controller.text),
                BMDTXA!,
                BMDTXA2!,
                BMDTXA3!,
                BMDTXA! + BMDTXA2! + BMDTXA3!,
                BMDNFController.text.isEmpty ||
                    double.parse(BMDNFController.text) <= 0 ? 0 : BMDAM1!,
                double.parse(SUMBMDAMController.text),
                double.parse(SUMBMDAMTFController.text),
                BMDTXT1!,
                BMDTXT2!,
                BMDTXT3!,
                double.parse(BMDTXTController.text),
                double.parse(BMDDITController.text),
                SUM_Totle_BMDDI!,
                BMDINController.text,
                BMDAM_TX,
                BMDDI_TX,
                BMDAMT3,
                TCAMT);
          } else {
            STB_N = 'S14';
            Bil_Mov_D_Local e = Bil_Mov_D_Local(
              BMMID: BMMID,
              BMDID: BMDID,
              BMKID: BMKID,
              MGNO: MGNOController.text,
              MINO: SelectDataMINO,
              MUID: int.parse(SelectDataMUID.toString()),
              BMDNO: BMDNO_V,
              BMDNF: BMDNFController.text.isEmpty ? 0 : double.parse(BMDNFController.text),
              BMDAM: BMDAM1,
              BMDEQ: roundDouble(BMDAM1! * double.parse(SCEXController.text), 6),
              BMDEQC: roundDouble((BMDAM1! * double.parse(SCEXController.text)) / SCEXS!, 6),
              BMDTXA1: BMDTXA,
              BMDTXA2: BMDTXA2,
              BMDTXA3: BMDTXA3,
              BMDTXA: BMDTXA! + BMDTXA2! + BMDTXA3!,
              BMDTX: double.parse(BMDTXController.text) +
                  double.parse(BMDTX2Controller.text) + double.parse(BMDTX3Controller.text),
              BMDTX1: BMDTXController.text.isEmpty ? 0 : double.parse(BMDTXController.text),
              BMDTX2: BMDTX2Controller.text.isEmpty ? 0 : double.parse(BMDTX2Controller.text),
              BMDTX3: BMDTX3Controller.text.isEmpty ? 0 : double.parse(BMDTX3Controller.text),
              BMDDI: double.parse(BMDDIController.text),
              BMDDIR: double.parse(BMDDIRController.text),
              SIID: int.parse(SIID_V2.toString()),
              BIID: int.parse(SelectDataBIID.toString()),
              MUCBC: MUCBCController.text.isEmpty ? '' : MUCBCController.text,
              BMDED: BMKID == 1 || BMKID == 2 ? BMDEDController.text : SelectDataSNED.toString(),
              BMDTY: 1,
              BMDAMR: roundDouble(double.parse(MPCOController.text) / SCEXS!, 6),
              BMDAMO: MPS1,
              BMDAMRE: double.parse(MPCOController.text),
              BMDDIF: BMDNFController.text.isEmpty || double.parse(BMDNFController.text) <= 0 ? 0 : BMDAM1,
              BMDAMT: double.parse(SUMBMDAMController.text),
              BMDAMTF: double.parse(SUMBMDAMTFController.text),
              BMDTXT1: BMDTXT1,
              BMDTXT2: BMDTXT2,
              BMDTXT3: BMDTXT3,
              BMDTXT: double.parse(BMDTXTController.text),
              BMDDIT: double.parse(BMDDITController.text),
              BMDDIM: SUM_Totle_BMDDI,
              GUID: GUIDD.toString().toUpperCase(),
              GUIDM: GUID.toString().toUpperCase(),
              BMDIN: BMDINController.text,
              MITSK: MITSK,
              MGKI: MGKI,
              GUIDMT: GUIDMT,
              BMDDIA: 0,
              SYST: 0,
              TCRA: TCRA,
              TCID: TCID_D,
              TCSY: TCSY_D,
              TCSDID: TCSDID,
              TCSDSY: TCSDSY,
              TCVL: TCVL,
              BMDAM_TX: BMDAM_TX,
              BMDDI_TX: BMDDI_TX,
              BMDAMT3: BMDAMT3,
              TCAMT: TCVL != 1 ? 0 : TCAMT,
              JTID_L: LoginController().JTID,
              BIID_L: LoginController().BIID,
              SYID_L: LoginController().SYID,
              CIID_L: LoginController().CIID,
            );
            await Save_BIF_MOV_D(BMKID == 11 || BMKID == 12 ? 'BIF_MOV_D' : 'BIL_MOV_D', e);
            update();
            MES_ADD_EDIT = 'StringAD'.tr;
            STB_N = 'S15';

          }
          CheckBack = 1;
          update();
          Fluttertoast.showToast(
              msg: MES_ADD_EDIT,
              toastLength: Toast.LENGTH_LONG,
              textColor: Colors.white,
              backgroundColor: Colors.green);
          GET_SUMBMMAM();
          GET_SUMBMMAM2();
          GET_SUMBMDTXA();
          GET_SUMBMMDIF();
          GET_SUMBMMDI();
          GET_CountRecode(BMMID!);
          GET_COUNT_BMDNO_P(BMMID!);
          GET_SUMBMDTXT();
          GET_SUM_AM_TXT_DI();
          update();
          STB_N = 'S6';
          //الخصم علي مستوى الفاتورة
          if (SelectDataBMMDN == '0' &&
              (double.parse(BMMDIController.text) > 0 ||
                  double.parse(BMMDIRController.text) > 0)) {
            await UPDATE_BMMDI();
            update();
          }

          if (BMKID != 1 && BMKID != 2) {
            //اضافة الاصناف التابعة والمرتبطة
            await ADD_MAT_FOL_TO_MOV_D(
                SelectDataBIID.toString(), MGNOController.text,
                SelectDataMINO.toString(), BMDID!);
            update();
          }

          if (_autocompleteFocusNode != 'null') {
            _autocompleteFocusNode.requestFocus();
          }
          update();
          return true;
        }
      }
    } catch (e, stackTrace) {
      print(' $e $stackTrace');
      Fluttertoast.showToast(
          msg: "$STB_N-${'StrinError_save_data'.tr}-${e.toString()}",
          toastLength: Toast.LENGTH_LONG,
          textColor: Colors.white,
          backgroundColor: Colors.redAccent);
      print("error-save_D ${e.toString()}");
      return false;
    }
    return true;
  }

  //حفظ فاتورة فرعي مطاعم
  Future<bool> Save_BIL_MOV_D_ORD_P() async {
    try {
      STB_N = 'S1';
      GUIDD = uuid.v4();
      await GET_BMDID_P();
      BMDNFController.text.isEmpty
          ? BMDNFController.text = '0'
          : BMDNFController.text = BMDNFController.text;
      if ((SelectDataMINO == null || SelectDataMINO.toString().isEmpty) &&
          (SelectDataMUID == null || SelectDataMUID.toString().isEmpty)) {
        Fluttertoast.showToast(
            msg: "يجب تعبئة جميع البيانات",
            toastLength: Toast.LENGTH_LONG,
            textColor: Colors.white,
            backgroundColor: Colors.redAccent);
        STB_N = 'S2';
        return false;
      } else if (!BMDNOController.text.isNum) {
        Fluttertoast.showToast(
            msg: 'StrinReq_SMDFN_NUM'.tr,
            toastLength: Toast.LENGTH_LONG,
            textColor: Colors.white,
            backgroundColor: Colors.redAccent);
        STB_N = 'S3';
        return false;
      } else if (MGKI == 1 && lARGEST_VALUE_QUANTITY != 0 &&
          double.parse(BMDNOController.text) > lARGEST_VALUE_QUANTITY) {
        Fluttertoast.showToast(
            msg: 'StrinlARGEST_VALUE_QUANTITY'.tr,
            toastLength: Toast.LENGTH_LONG,
            textColor: Colors.white,
            backgroundColor: Colors.redAccent);
        STB_N = 'S8';
        return false;
      } else if (MGKI == 2 && lARGEST_VALUE_QUANTITY2 != 0 &&
          double.parse(BMDNOController.text) > lARGEST_VALUE_QUANTITY2) {
        Fluttertoast.showToast(
            msg: 'StrinlARGEST_VALUE_QUANTITY'.tr,
            toastLength: Toast.LENGTH_LONG,
            textColor: Colors.white,
            backgroundColor: Colors.redAccent);
        STB_N = 'S8';
        return false;
      } else if (MGKI == 1 && lARGEST_VALUE_PRICE != 0 &&
          BMDAM1! > lARGEST_VALUE_PRICE) {
        Fluttertoast.showToast(
            msg: 'StrinlARGEST_VALUE_PRICE'.tr,
            toastLength: Toast.LENGTH_LONG,
            textColor: Colors.white,
            backgroundColor: Colors.redAccent);
        STB_N = 'S9';
        return false;
      } else if (MGKI == 2 && lARGEST_VALUE_PRICE2 != 0 &&
          BMDAM1! > lARGEST_VALUE_PRICE2) {
        Fluttertoast.showToast(
            msg: 'StrinlARGEST_VALUE_PRICE'.tr,
            toastLength: Toast.LENGTH_LONG,
            textColor: Colors.white,
            backgroundColor: Colors.redAccent);
        STB_N = 'S9';
        return false;
      } else {
        BMDAM_TX = BMDAM1! + BMDTXA2!;

        BMDNF = BMDNFController.text.isEmpty ? 0 : double.parse(BMDNFController.text);

        BMDDI_TX = (roundDouble(
            (((double.parse(BMDDIController.text) + ((BMDAM1! + BMDTXA2!)
                * (0 / 100))) * BMDNO_V!) +
                (BMDNF! <= 0 ? 0 : BMDAM1! * BMDNF!)), SCSFL)) /
            (BMDNO_V! + BMDNF!);

        BMDAMT3 = roundDouble((BMDAM_TX! - BMDDI_TX!) * (BMDNO_V! + BMDNF!), SCSFL);

        if (BMDNO_V! > 0) {
          TCAMT = roundDouble((BMDAMT3! * (TCRA! / 100)) / BMDNO_V! * BMDNO_V!, SCSFL_TX);
        } else {
          TCAMT = 0;
        }
        if (COUNT_NO > 0) {
          MES_ADD_EDIT = 'StringED'.tr;
          STB_N = 'S13';
          UpdateBil_Mov_D(
              BMKID == 11 || BMKID == 12 ? 'BIF_MOV_D' : 'BIL_MOV_D',
              BMKID!,
              BMMID!,
              int.parse(BMDIDController.text.toString()),
              MGNOController.text,
              SelectDataMINO.toString(),
              int.parse(SelectDataMUID.toString()),
              SelectDataSIID.toString(),
              double.parse(BMDNFController.text),
              BMDNO_V!,
              SelectDataSNED.toString(),
              BMDAM1!,
              double.parse(BMDDIController.text),
              double.parse(BMDDIRController.text),
              roundDouble(BMDAM1! * double.parse(SCEXController.text), 6),
              double.parse(BMDTXController.text) + double.parse(BMDTX2Controller.text) +
                  double.parse(BMDTX3Controller.text),
              BMDTXController.text.isEmpty ? 0 : double.parse(BMDTXController.text),
              BMDTX2Controller.text.isEmpty ? 0 : double.parse(BMDTX2Controller.text),
              BMDTX3Controller.text.isEmpty ? 0 : double.parse(BMDTX3Controller.text),
              BMDTXA!,
              BMDTXA2!,
              BMDTXA3!,
              BMDTXA! + BMDTXA2! + BMDTXA3!,
              BMDNFController.text.isEmpty || double.parse(BMDNFController.text) <= 0 ? 0 : BMDAM1!,
              double.parse(SUMBMDAMController.text),
              double.parse(SUMBMDAMTFController.text),
              BMDTXT1!,
              BMDTXT2!,
              BMDTXT3!,
              double.parse(BMDTXTController.text),
              double.parse(BMDDITController.text),
              SUM_Totle_BMDDI!,
              BMDINController.text,
              BMDAM_TX,
              BMDDI_TX,
              BMDAMT3,
              TCAMT
          );
        }
        else {
          STB_N = 'S14';
          print('STP-4');
          Bil_Mov_D_Local e = Bil_Mov_D_Local(
            BMMID: BMMID,
            BMDID: BMDID,
            BMKID: BMKID,
            MGNO: MGNOController.text,
            MINO: SelectDataMINO,
            MUID: int.parse(SelectDataMUID.toString()),
            BMDNO: BMDNO_V,
            BMDNF: 0,
            BMDAM: BMDAM1,
            BMDEQ: roundDouble(BMDAM1! * double.parse(SCEXController.text), 6),
            BMDEQC: roundDouble(
                (BMDAM1! * double.parse(SCEXController.text)) / SCEXS!, 6),
            BMDTXA1: BMDTXA,
            BMDTXA2: BMDTXA2,
            BMDTXA3: BMDTXA3,
            BMDTXA: BMDTXA! + BMDTXA2! + BMDTXA3!,
            BMDTX: double.parse(BMDTXController.text) +
                double.parse(BMDTX2Controller.text) +
                double.parse(BMDTX3Controller.text),
            BMDTX1: BMDTXController.text.isEmpty ? 0 : double.parse(
                BMDTXController.text),
            BMDTX2: BMDTX2Controller.text.isEmpty ? 0 : double.parse(
                BMDTX2Controller.text),
            BMDTX3: BMDTX3Controller.text.isEmpty ? 0 : double.parse(
                BMDTX3Controller.text),
            BMDDI: double.parse(BMDDIController.text),
            BMDDIR: double.parse(BMDDIRController.text),
            SIID: int.parse(SelectDataSIID.toString()),
            BIID: int.parse(SelectDataBIID.toString()),
            MUCBC: MUCBCController.text.isEmpty ? '' : MUCBCController.text,
            BMDED: BMKID == 1 || BMKID == 2? BMDEDController.text : SelectDataSNED.toString(),
            BMDTY: 1,
            BMDDIF: BMDNFController.text.isEmpty ||
                double.parse(BMDNFController.text) <= 0 ? 0 : BMDAM1,
            BMDAMT: double.parse(SUMBMDAMController.text),
            BMDAMTF: double.parse(SUMBMDAMTFController.text),
            BMDTXT1: BMDTXT1,
            BMDTXT2: BMDTXT2,
            BMDTXT3: BMDTXT3,
            BMDTXT: double.parse(BMDTXTController.text),
            BMDDIT: double.parse(BMDDITController.text),
            BMDAMO: MPS1,
            BMDDIM: SUM_Totle_BMDDI,
            GUID: GUIDD.toString().toUpperCase(),
            GUIDM: GUID.toString().toUpperCase(),
            BMDIN: BMDINController.text,
            MITSK: MITSK,
            MGKI: 2,
            BMDDIA: 0,
            SYST: 0,
            TCRA: TCRA,
            TCID: TCID_D,
            TCSY: TCSY_D,
            TCSDID: TCSDID,
            TCSDSY: TCSDSY,
            TCVL: TCVL,
            BMDAM_TX: BMDAM_TX,
            BMDDI_TX: BMDDI_TX,
            BMDAMT3: BMDAMT3,
            TCAMT: TCVL != 1 ? 0 : TCAMT,
            JTID_L: LoginController().JTID,
            BIID_L: LoginController().BIID,
            SYID_L: LoginController().SYID,
            CIID_L: LoginController().CIID,
          );
          Save_BIF_MOV_D(BMKID == 11 || BMKID == 12 ? 'BIF_MOV_D' : 'BIL_MOV_D', e);
          MES_ADD_EDIT = 'StringAD'.tr;
        }
        STB_N = 'S15';
        CheckBack = 1;
        update();
        // Fluttertoast.showToast(msg: MES_ADD_EDIT,
        //     toastLength: Toast.LENGTH_LONG,
        //     textColor: Colors.white,
        //      backgroundColor: Colors.green);
         print('STP-5');
         GET_SUMBMMAM();
         GET_SUMBMMAM2();
         GET_SUMBMDTXA();
         GET_SUMBMMDIF();
         GET_SUMBMMDI();
         GET_CountRecode(BMMID!);
         GET_COUNT_BMDNO_P(BMMID!);
         GET_SUMBMDTXT();
         GET_SUM_AM_TXT_DI();
         GET_BIF_MOV_D_P(BMMID.toString(), '2');
         print('STP-6');
         ClearBil_Mov_D_Data();
         print('STP-8');
        STB_N = 'S6';
        update();
        return true;
      }
    } catch (e, stackTrace) {
      print(' $e $stackTrace');
      Fluttertoast.showToast(
          msg: "$STB_N-${'StrinError_save_data'.tr}-${e.toString()}",
          toastLength: Toast.LENGTH_LONG,
          textColor: Colors.white,
          backgroundColor: Colors.redAccent);
      print("error-save_m ${e.toString()}");
      return false;
    }
  }

  //حفظ فاتورة فرعي
  Future<bool> Save_BIF_MOV_D_P_COU() async {
    try {
      STB_N = 'S1';
      await GET_BMDID_P();
      if (COUNT <= 0) {
        GUIDD = uuid.v4();
        print('BMDTXController.text');
        print(BMDTXController.text);
        print(BMDTX2Controller.text);
        print(BMDTX3Controller.text);
        SCIDOController.text.contains('null')
            ? SCIDOController.text = '0'
            : SCIDOController.text = SCIDOController.text;
        Bil_Mov_D_Local e = Bil_Mov_D_Local(
          BMMID: BMMID,
          BMDID: BMDID,
          BMKID: 11,
          BMDNO: 0,
          BMDNF: 0,
          BMDAMT: 0,
          BMDAM: double.parse(BMDAMController.text),
          BMDAM1: BMDAM1,
          BMDTXA: BMDTXA,
          BMDTX: double.parse(BMDTXController.text),
          SIID: int.parse(SIIDController.text),
          MGNO: MGNOController.text,
          MINO: MINOController.text,
          MUID: int.parse(MUIDController.text),
          MUCBC: MUCBCController.text.isEmpty ? '' : MUCBCController.text,
          CTMID: int.parse(CTMIDController.text),
          CIMID: int.parse(CIMIDController.text),
          SCIDC: int.parse(SCIDOController.text),
          BMDTY: 1,
          GUID: GUIDD.toString().toUpperCase(),
          GUIDM: GUID.toString().toUpperCase(),
          SYST: 2,
          BMDTXA1: 0,
          BMDTXA2: 0,
          BMDTXA3: 0,
          BMDTX1: BMDTXController.text.isEmpty ? 0 : double.parse(
              BMDTXController.text),
          BMDTX2: BMDTX2Controller.text.isEmpty ? 0 : double.parse(
              BMDTX2Controller.text),
          BMDTX3: BMDTX3Controller.text.isEmpty ? 0 : double.parse(
              BMDTX3Controller.text),
          BMDDI: 0,
          BMDDIR: 0,
          BIID: int.parse(SelectDataBIID.toString()),
          BMDAMR: roundDouble(double.parse(MPCOController.text) / SCEXS!, 6),
          BMDAMO: MPS1,
          BMDAMRE: double.parse(MPCOController.text),
          BMDDIF: 0,
          BMDAMTF: 0,
          BMDTXT1: 0,
          BMDTXT2: 0,
          BMDTXT3: 0,
          BMDTXT: 0,
          BMDDIT: 0,
          BMDDIM: 0,
          BMDDIA: 0,
          TCRA: TCRA,
          TCID: TCID_D,
          TCSY: TCSY_D,
          TCSDID: TCSDID,
          TCSDSY: TCSDSY,
          TCVL: TCVL,
          BMDAM_TX: 0,
          BMDDI_TX: 0,
          BMDAMT3: 0,
          TCAMT: 0,
          JTID_L: LoginController().JTID,
          BIID_L: LoginController().BIID,
          SYID_L: LoginController().SYID,
          CIID_L: LoginController().CIID,
        );
        Save_BIF_MOV_D('BIF_MOV_D', e);
        CheckBack = 1;
        // CheckSave = 1;
        update();
        STB_N = 'S2';
        return true;
      }
    } catch (e) {
      Fluttertoast.showToast(
          msg: "${STB_N}-${'StrinError_save_data'.tr}",
          toastLength: Toast.LENGTH_LONG,
          textColor: Colors.white,
          backgroundColor: Colors.redAccent);
      print("error-save_m ${e.toString()}");
      return false;
    }
    return true;
  }


  //اضافة الاصناف التابعة والمرتبطة
  Future ADD_MAT_FOL_TO_MOV_D(String GETBIID, String GETMGNO, String GETMINO,
      int GETBMDID) async {
    await GET_MAT_FOL(GETBIID, GETMGNO, GETMINO).then((userList) async {
      if (userList.isNotEmpty) {
        print('ADD_MAT_FOL_TO_MOV_D');
        for (var i = 0; i < userList.length; i++) {
          try {
            await GET_BROCODE_P(
                userList[i].MGNOF.toString(), userList[i].MINOF.toString(),
                userList[i].MUIDF.toString());
            var data = await GET_BMDID(BMKID == 11 || BMKID == 12 ? 'BIF_MOV_D' : 'BIL_MOV_D', BMMID!);
            if (data.isNotEmpty) {
              Bil_Mov_D_Local e = Bil_Mov_D_Local(
                BMMID: BMMID,
                BMDIDR: GETBMDID,
                BMDID: data.elementAt(0).BMDID,
                BMKID: BMKID,
                MGNO: userList[i].MGNOF,
                MINO: userList[i].MINOF,
                MUID: userList[i].MUIDF,
                BMDNO: 0,
                BMDNF: userList[i].MFNOF,
                BMDAM: 0,
                BMDED: '',
                BMDEQ: 0,
                BMDEQC: 0,
                BMDTXA: 0,
                BMDTXA1: 0,
                BMDTXA2: 0,
                BMDTXA3: 0,
                BMDTX: 0,
                BMDTX1: 0,
                BMDTX2: 0,
                BMDTX3: 0,
                BMDDI: 0,
                BMDDIR: 0,
                MUCBC: MUCBCController.text.isEmpty ? '' : MUCBCController.text,
                BMDTY: 2,
                BMDAMO: 0,
                BMDDIF: 0,
                BMDAMT: 0,
                BMDAMTF: 0,
                BMDTXT: 0,
                BMDTXT1: 0,
                BMDTXT2: 0,
                BMDTXT3: 0,
                BMDDIT: 0,
                BMDDIM: 0,
                GUID: uuid.v4().toUpperCase(),
                GUIDM: GUID.toUpperCase(),
                BMDDIA: 0,
                SYST: 0,
                JTID_L: userList[i].JTID_L,
                BIID_L: userList[i].BIID_L,
                SYID_L: userList[i].SYID_L,
                CIID_L: userList[i].CIID_L,
              );
              Save_BIF_MOV_D(BMKID == 11 || BMKID == 12 ? 'BIF_MOV_D' : 'BIL_MOV_D', e);
              print(e);
            }
          } catch (e) {
            print(e.toString());
            Fluttertoast.showToast(
                msg: "ADD_MAT_FOL_TO_MOV_D ${e.toString()}",
                textColor: Colors.white,
                backgroundColor: Colors.red);
            return Future.error(e);
          }
        }
      }
    });
  }

  Future GET_BMDID_COUNT_P() async {
    await GET_BMDID_COUNT(BMKID == 11 || BMKID == 12 ? 'BIF_MOV_D' : 'BIL_MOV_D',
        BMMID.toString()).then((userList) async {
      if (userList.isNotEmpty) {
        print('GET_BMDID_COUNT_P');
        for (var i = 0; i < userList.length; i++) {
          try {
            UpdateBMDID(BMKID == 11 || BMKID == 12 ? 'BIF_MOV_D' : 'BIL_MOV_D',
                userList[i].BMMID.toString(), i + 1,
                userList[i].GUID.toString());
          } catch (e) {
            print(e.toString());
            Fluttertoast.showToast(
                msg: "GET_BMDID_COUNT_P: ${e.toString()}",
                textColor: Colors.white,
                backgroundColor: Colors.red);
            return Future.error(e);
          }
        }
      }
    });
  }

  //دالة تعديل الكميه المخزنيه
  Future<List<Bil_Mov_D_Local>> fetchBMDNO(String GETBMMID) async {
    final dbClient = await conn.database;
    List<Bil_Mov_D_Local> contactList = [];
    try {
      final maps = await dbClient!.query(BMKID == 11 || BMKID == 12 ? 'BIF_MOV_D' : 'BIL_MOV_D',
          where: "MGKI=1 AND BMMID='$GETBMMID' ");
      for (var item in maps) {
        contactList.add(Bil_Mov_D_Local.fromMap(item));
      }
    } catch (e) {
      print(e.toString());
    }
    return contactList;
  }

  //دالة تعديل مردرد
  Future<List<Bil_Mov_D_Local>> fetchBIL_MOV_D(String GETBMMID) async {
    final dbClient = await conn.database;
    List<Bil_Mov_D_Local> contactList = [];
    try {
      final maps = await dbClient!.query(
          BMKID == 11 || BMKID == 12 ? 'BIF_MOV_D' : 'BIL_MOV_D',
          where: " BMMID='$GETBMMID' ");
      for (var item in maps) {
        contactList.add(Bil_Mov_D_Local.fromMap(item));
      }
    } catch (e) {
      print(e.toString());
    }
    return contactList;
  }

  //تعديل المردود
  Future UPDATE_BIL_MOV_D(String GetBMMID, int GetBMMID2,
      String GETGUID) async {
    await fetchBIL_MOV_D(GetBMMID).then((userList) async {
      if (userList.isNotEmpty) {
        for (var i = 0; i < userList.length; i++) {
          try {
            Bil_Mov_D_Local e = Bil_Mov_D_Local(
              BMMID: GetBMMID2,
              BMDIDR: userList[i].BMDID,
              BMDID: userList[i].BMDID,
              BMKID: BMKID,
              MGNO: userList[i].MGNO,
              MINO: userList[i].MINO,
              MUID: userList[i].MUID,
              BMDNO: userList[i].BMDNO,
              BMDNF: userList[i].BMDNF,
              BMDAM: userList[i].BMDAM,
              BMDEQ: userList[i].BMDEQ,
              BMDEQC: userList[i].BMDEQC,
              BMDTXA: userList[i].BMDTXA,
              BMDTXA1: userList[i].BMDTXA1,
              BMDTXA2: userList[i].BMDTXA2,
              BMDTXA3: userList[i].BMDTXA3,
              BMDTX: userList[i].BMDTX,
              BMDTX1: userList[i].BMDTX1,
              BMDTX2: userList[i].BMDTX2,
              BMDTX3: userList[i].BMDTX3,
              BMDDI: userList[i].BMDDI,
              BMDDIR: userList[i].BMDDIR,
              SIID: userList[i].SIID,
              BIID: userList[i].BIID,
              MUCBC: userList[i].MUCBC,
              BMDED: userList[i].BMDED,
              BMDTY: userList[i].BMDTY,
              BMDAMR: userList[i].BMDAMR,
              BMDAMO: userList[i].BMDAMO,
              BMDAMRE: userList[i].BMDAMRE,
              BMDDIF: userList[i].BMDDIF,
              BMDAMT: userList[i].BMDAMT,
              BMDAMTF: userList[i].BMDAMTF,
              BMDTXT1: userList[i].BMDTXT1,
              BMDTXT2: userList[i].BMDTXT2,
              BMDTXT3: userList[i].BMDTXT3,
              BMDTXT: userList[i].BMDTXT,
              BMDDIT: userList[i].BMDDIT,
              BMDDIM: userList[i].BMDDIM,
              GUID: uuid.v4().toUpperCase(),
              GUIDM: GETGUID.toUpperCase(),
              BMDIN: userList[i].BMDIN,
              MITSK: userList[i].MITSK,
              MGKI: userList[i].MGKI,
              BMDDIA: userList[i].BMDDIA,
              SYST: 0,
              GUIDMT: userList[i].GUIDMT,
              TCRA: userList[i].TCRA,
              TCID: userList[i].TCID,
              TCSY: userList[i].TCSY,
              TCSDID: userList[i].TCSDID,
              TCSDSY: userList[i].TCSDSY,
              TCVL: userList[i].TCVL,
              BMDAM_TX: userList[i].BMDAM_TX,
              BMDDI_TX: userList[i].BMDDI_TX,
              BMDAMT3: userList[i].BMDAMT3,
              TCAMT: userList[i].TCAMT,
              JTID_L: userList[i].JTID_L,
              BIID_L: userList[i].BIID_L,
              SYID_L: userList[i].SYID_L,
              CIID_L: userList[i].CIID_L,
            );
            Save_BIF_MOV_D(BMKID == 11 || BMKID == 12 ? 'BIF_MOV_D' : 'BIL_MOV_D', e);
          } catch (e) {
            print(e.toString());
            Fluttertoast.showToast(
                msg: "UPDATE_MOV_D: ${e.toString()}",
                textColor: Colors.white,
                backgroundColor: Colors.red);
            return Future.error(e);
          }
        }
      }
    });
  }

  //تعديل الكمية
  Future UPDATE_STO_NUM() async {
    await fetchBMDNO(BMMID.toString()).then((userList) async {
      if (userList.isNotEmpty) {
        for (var i = 0; i < userList.length; i++) {
          try {
            if (userList[i].BMDNO! > 0) {
              UpdateSNNO(
                  BMKID!,
                  userList[i].SIID.toString(),
                  userList[i].MGNO.toString(),
                  userList[i].MINO.toString(),
                  userList[i].MUID.toString(),
                  userList[i].BMDED.toString(),
                  userList[i].BMDNO!);
            }
          } catch (e) {
            print(e.toString());
            Fluttertoast.showToast(
                msg: "UPDATE_STO_NUM ${e.toString()}",
                textColor: Colors.white,
                backgroundColor: Colors.red);
            return Future.error(e);
          }
        }
      }
    });
  }

  //جلب رقم الحركة
  Future GET_AMMNO_P() async {
    GET_AMMNO(BMKID == 1 ? 2 : 1).then((data) {
      ACC_MOV_M_AMMNO = data;
      if (ACC_MOV_M_AMMNO.isNotEmpty) {
        AMMNO = ACC_MOV_M_AMMNO
            .elementAt(0)
            .AMMNO;
      }
    });
  }

  Future GET_AMMID_P() async {
    GET_AMMID().then((data) {
      ACC_MOV_M_AMMNO = data;
      if (ACC_MOV_M_AMMNO.isNotEmpty) {
        AMMID = ACC_MOV_M_AMMNO
            .elementAt(0)
            .AMMID;
        update();
      }
    });
  }

  String generateTransactionDetails({
    required double amount,
    required double balance,
    required String companyName,
    required String currency,
    required String dateString,
    required String transactionType,  // معلمة نوع السند
    List<String> fieldsOrder = const ["transactionType", "amount", "balance", "companyName", "currency", "date"],  // ترتيب الحقول
    String transactionText = "",  // نص المعاملة (مثل سند قبض أو فاتورة مبيعات)
    String amountLabel = "المبلغ",
    String balanceLabel = "الرصيد",
    String companyNameLabel = "اسم الشركة",
    String currencyLabel = "العملة",
    String dateLabel = "التاريخ",
  }) {
    // تحويل السلسلة النصية إلى كائن DateTime
    DateTime date = DateTime.parse(dateString);

    // تنسيق التاريخ لعرضه بشكل مناسب (يمكنك تخصيصه كما تريد)
    String formattedDate = DateFormat('yyyy-MM-dd').format(date);

    // تنسيق الأرقام (إضافة الفواصل)
    String formattedAmount = NumberFormat('#,##0.00', 'en_US').format(amount);
    String formattedBalance = NumberFormat('#,##0.00', 'en_US').format(balance);

    // تحديد النص الأساسي للمعاملة إذا لم يتم تحديده
    String transactionDescription = transactionText.isNotEmpty
        ? transactionText
        : transactionType;

    // إنشاء النص النهائي بناءً على ترتيب الحقول المرسل
    String transactionDetails = "$transactionDescription\n";  // إضافة نص المعاملة في البداية

    for (var field in fieldsOrder) {
      switch (field) {
        case "transactionType":
          transactionDetails += " $transactionText\n";
          break;
        case "amount":
          transactionDetails += "$amountLabel $formattedAmount $currency\n";
          break;
        case "balance":
          transactionDetails += "$balanceLabel $formattedBalance $currency\n";
          break;
        case "companyName":
          transactionDetails += "$companyNameLabel $companyName\n";
          break;
        case "currency":
          transactionDetails += "$currencyLabel $currency\n";
          break;
        case "date":
          transactionDetails += "$dateLabel $formattedDate\n";
          break;
        default:
          break;
      }
    }

    return transactionDetails;
  }


  //حفظ فاتوره
  Future<bool> Save_BIL_MOV_M(bool typesave) async {
    try {

      print('Save_BIL_MOV_M');
      // print(Must_Specify_Location_Invoice);
      // print(distanceInMeters);
      // print(Allow_Must_Specify_Location_Invoice);
      // print(distanceInMeters);
      print(BCBL!);
      print(SUMBAL!);
      print(BACBA!);
      print(((BACBA! + SUMBAL!)));
      print((BCBL! - (BACBA! + SUMBAL!)));
      print(double.parse(BMMAMTOTController.text));
      print((BCBL! - (BACBA! + SUMBAL!)) < double.parse(BMMAMTOTController.text));
      print('GUID_LNK');
     // print(GUID_LNK.toString().toUpperCase());
      STB_N = 'S1';
      String BMMMS = PKID == 1 ? "عليكم ف.مبيعات نقداً" : PKID == 3
          ? "عليكم ف.مبيعات آجل"
          : PKID == 8 ? "عليكم ف.مبيعات ائتمان"
          : PKID == 9 ? "عليكم ف.مبيعات حواله" : "عليكم فاتورة مبيعات";

      String BMMIN = BMKID != 1 ? " فاتورة مبيعات  ($STMID)-${BCNAController.text}" : " فاتورة مشتريات ($STMID)-${BCNAController.text}";

      BMMTX_DAT = '[TTIDC1{<$TTIDC1>}][TSDI1{$TSDI1}][TSFR1{$TSFR1}][TSDI2{$TSDI1}][TSFR2{$TSFR1}]';
      if (TTID1 != null) {
        TTLID = await ES_FAT_PKG.GET_TTLID(BMKID!,
            double.parse(BMMAMController.text) +
                double.parse(SUMBMDTXTController.text),
            double.parse(SCEXController.text), TTID1!, BCTX.toString());
      }

      if ((STMID != 'COU' && SelectDataSIID == null) ||
          SelectDataBIID == null || PKID == null ||
          SelectDataSCID == null || ((BMKID == 3 ||
          BMKID == 4 || BMKID == 5 || BMKID == 7 || BMKID == 10)
          && SelectDataBCID == null ||
          ((BMKID == 1 || BMKID == 2) && SelectDataBIID2 == null))) {
        Get.snackbar('StringErrorMes'.tr, 'StringError_MESSAGE'.tr,
            backgroundColor: Colors.red,
            icon: const Icon(Icons.error, color: Colors.white),
            colorText: Colors.white,
            isDismissible: true,
            dismissDirection: DismissDirection.horizontal,
            forwardAnimationCurve: Curves.easeOutBack);
        return false;
      } else
      if (BMKID != 11 && BMKID != 12 && PKID == 1 && SelectDataACID == null) {
        Fluttertoast.showToast(
            msg: 'StringChi_ACID'.tr,
            toastLength: Toast.LENGTH_LONG,
            textColor: Colors.white,
            backgroundColor: Colors.redAccent);
        return false;
      } else if ((BMKID == 1 || BMKID == 2) && SelectDataBIID2 == null) {
        Fluttertoast.showToast(
            msg: 'StringChi_BIID'.tr,
            textColor: Colors.white,
            backgroundColor: Colors.red);
        return false;
      } else if ((BMKID == 3 || BMKID == 5 || BMKID == 7 || BMKID == 10) &&
          SelectDataBCID == null) {
        Fluttertoast.showToast(
            msg: 'StringvalidateBCNA'.tr,
            textColor: Colors.white,
            backgroundColor: Colors.red);
        return false;
      } else if (PKID == 8 && SelectDataBCCID == null) {
        Fluttertoast.showToast(
            msg: 'StringChi_ACID'.tr,
            toastLength: Toast.LENGTH_LONG,
            textColor: Colors.white,
            backgroundColor: Colors.redAccent);
        return false;
      } else if ((BMKID != 1 || BMKID != 2 )&& SelectDataPKID.toString() == '3' &&
          SelectDataBCID == null) {
        Fluttertoast.showToast(
            msg: 'StrinError_BCID'.tr,
            toastLength: Toast.LENGTH_LONG,
            textColor: Colors.white,
            backgroundColor: Colors.redAccent);
        return false;
      } else if (PKID == 9 && SelectDataABID == null) {
        Fluttertoast.showToast(
            msg: 'StringvalidateABID'.tr,
            toastLength: Toast.LENGTH_LONG,
            textColor: Colors.white,
            backgroundColor: Colors.redAccent);
        return false;
      } else if ((BMKID == 3 || BMKID == 5 || BMKID == 11) && PKID == 3 && SelectDataBCID != null && BCBL != 0 &&
          (BACBA! + SUMBAL! + double.parse(BMMAMTOTController.text)) > BCBL!) {
        Fluttertoast.showToast(
            msg: 'StringBCBL'.tr,
            toastLength: Toast.LENGTH_LONG,
            textColor: Colors.white,
            backgroundColor: Colors.redAccent);
        return false;
      } else if (BMKID != 11 && BMKID != 12 && SHOW_BDID == '3' && SelectDataBDID == null) {
        Fluttertoast.showToast(
            msg: 'StringChi_BDID'.tr,
            toastLength: Toast.LENGTH_LONG,
            textColor: Colors.white,
            backgroundColor: Colors.redAccent);
        return false;
      } else if (STMID == 'COU' &&
          (BMDNOController.text.isEmpty || BMDNOController.text == '0' ||
              BMDAM1 == 0)) {
        Fluttertoast.showToast(
            msg: 'StrinError_BMMNO_OR_BMDAM1'.tr,
            toastLength: Toast.LENGTH_LONG,
            textColor: Colors.white,
            backgroundColor: Colors.redAccent);
        return false;
      } else
      if (STMID != 'COU' && (BMKID == 11 || BMKID == 12) && SHOW_BDID == '4' &&
          SelectDataBDID == null) {
        Fluttertoast.showToast(
            msg: 'StringChi_BDID'.tr,
            toastLength: Toast.LENGTH_LONG,
            textColor: Colors.white,
            backgroundColor: Colors.redAccent);
        return false;
      } else if (STMID != 'COU' && SelectDataBMMDN == '0' &&
          double.parse(BMMDIRController.text) > 100) {
        Fluttertoast.showToast(
            msg: 'StringErr_SUM_BMDDI'.tr,
            toastLength: Toast.LENGTH_LONG,
            textColor: Colors.white,
            backgroundColor: Colors.redAccent);
        return false;
      }
      else if (STMID != 'COU' && SelectDataBMMDN == '0' &&
          double.parse(BMMDIController.text) >
              double.parse(BMMAMController.text)) {
        Fluttertoast.showToast(
            msg: 'StringErr_SUM_BMDDI'.tr,
            toastLength: Toast.LENGTH_LONG,
            textColor: Colors.white,
            backgroundColor: Colors.redAccent);
        return false;
      }
      else if (STMID == 'MOB'  && (BMKID!=11 || BMKID!=12)  &&(P_COS_SEQ == '1' || P_COSS == '1')
          && SelectDataACNO == null) {
        Fluttertoast.showToast(
            msg: 'StringACNO_ERR'.tr,
            toastLength: Toast.LENGTH_LONG,
            textColor: Colors.white,
            backgroundColor: Colors.redAccent);
        return false;
      }
      else if (STMID == 'MOB' &&  (BMKID!=11 || BMKID!=12) &&
          ((P_COSS == '2' || P_COSS == '3') && SelectDataBCID != null &&
              ((P_COS1 == '1' && AKID == 1) ||
                  (P_COS2 == '1' && (AKID == 2 || AKID == 3))) &&
              SelectDataACNO == null)) {
        Fluttertoast.showToast(
            msg: 'StringACNO_ERR'.tr,
            toastLength: Toast.LENGTH_LONG,
            textColor: Colors.white,
            backgroundColor: Colors.redAccent);
        return false;
      }
      else if (STMID == 'MOB' && (BMKID!=11 || BMKID!=12)  && ((((P_COS1 == '3' && AKID == 1) ||
          (P_COS2 == '3' && (AKID == 2 || AKID == 3))) && AACC == 1) &&
          SelectDataACNO == null)) {
        Fluttertoast.showToast(
            msg: 'StringACNO_ERR'.tr,
            toastLength: Toast.LENGTH_LONG,
            textColor: Colors.white,
            backgroundColor: Colors.redAccent);
        return false;
      }
      else if (STMID == 'MOB' && (BMKID!=11 || BMKID!=12) && (BMKID!=11 || BMKID!=12) &&
      (P_COSS == '3' && AACC == 1 && SelectDataACNO == null)) {
        Fluttertoast.showToast(
            msg: 'StringACNO_ERR'.tr,
            toastLength: Toast.LENGTH_LONG,
            textColor: Colors.white,
            backgroundColor: Colors.redAccent);
        return false;
      }
      else if (STMID == 'MOB' &&
          (Must_Specify_Location_Invoice == '2' && distanceInMeters <= 0.0) ||
          (Allow_Must_Specify_Location_Invoice == 2 && distanceInMeters <= 0.0)) {
        Fluttertoast.showToast(
            msg: "${'StringError_Location_of_Account'.tr} $distanceInMeters",
            toastLength: Toast.LENGTH_LONG,
            textColor: Colors.white,
            backgroundColor: Colors.redAccent);
        STB_N = 'S9';
        determinePosition();
        return false;
      }
      else if (STMID == 'MOB' && (Must_Specify_Location_Invoice == '2' ||
          (Must_Specify_Location_Invoice == '4' && Allow_Must_Specify_Location_Invoice == 2)) &&
          (double.parse(Allow_Issuance_Invoice_Distance_Meters.toString()) <
              distanceInMeters)) {
        Fluttertoast.showToast(
            msg: "${'StringError_Location_Distance_Between'.tr} $distanceInMeters",
            toastLength: Toast.LENGTH_LONG,
            textColor: Colors.white,
            backgroundColor: Colors.redAccent);
        STB_N = 'S10';
        determinePosition();
        return false;
      } else
      if (STMID == 'EORD' && SelectDataGETTYPE == '3' && DELIVERY_VAR == '4' &&
          SelectDataBDID == null) {
        Fluttertoast.showToast(
            msg: 'StringBCID_VAL'.tr,
            toastLength: Toast.LENGTH_LONG,
            textColor: Colors.white,
            backgroundColor: Colors.redAccent);
        return false;
      } else if (STMID == 'EORD' && SelectDataGETTYPE == '3' &&
          ADDRESS_CUS_REQUEST == '4' && BCDMOController.text.isEmpty) {
        Fluttertoast.showToast(
            msg: 'StringBCDMO_VAL'.tr,
            toastLength: Toast.LENGTH_LONG,
            textColor: Colors.white,
            backgroundColor: Colors.redAccent);
        return false;
      } else if (STMID == 'MOB' && StteingController().Show_Inv_Pay == true &&
          Show_Inv_Pay == true && BMKID != 4 && BMKID != 12 && BMKID != 2 &&
          ((BMKID == 1 || BMKID == 3 || BMKID == 5) && PKID == 3 ||
              BMKID == 11)) {
        await GET_AMMID_P();
        await GET_AMMNO_P();
        GETDefaultDescription_Voucher();
        if (edit == false) {
          SelectDataSCIDP = SelectDataSCID.toString();
          SCEXP = double.parse(SCEXController.text);
        }
        Calculate_BMMTC(BMMCPController.text, SelectDataSCIDP.toString());
        Get.dialog(
          Sale_Invoice_Pay(),
        );
        return false;
      } else {
        if (typesave == false) {
          Bil_Mov_M_Local e = Bil_Mov_M_Local(
            BMKID: BMKID,
            BMMID: BMMID,
            BMMNO: BMMNO == null ? 1 : int.parse(BMMNO.toString()),
            BIID2: int.parse(SelectDataBIID.toString()),
            BIID: BMKID == 1 || BMKID == 2 ? int.parse(SelectDataBIID2.toString()) : BMKID ==
                11 || BMKID == 12 ? int.parse(SelectDataBIID.toString()) : null,
            SIID: int.parse(SelectDataSIID.toString()),
            BPID: BMKID == 11 || BMKID == 12 ? int.parse(SelectDataBPID.toString()) : null,
            BMMST: BMMST,
            BMMST2: STMID == 'EORD' ? 4 : BMMST,
            BMMFS: 10,
            BMMFST: 10,
            BMMIN: BMMINController.text.isEmpty ? BMMIN : BMMINController.text,
            BMMDO: '$SelectDays  ${DateFormat('HH:mm').format(DateTime.now())}',
            BMMDA: SelectDays,
            AANO: AANOController.text.isEmpty ? '' : AANOController.text,
            SCID: int.parse(SelectDataSCID.toString()),
            //SCIDC: int.parse(SCIDOController.text),
            PKID: PKID,
            SCEX: double.parse(SCEXController.text),
            ACID: BMKID != 11 && BMKID != 12 ? PKID == 1 ? int.parse(
                SelectDataACID.toString()) : null : null,
            ACNO: SelectDataACNO.toString(),
            ACNO2: SelectDataACNO.toString(),
            BCID: SelectDataBCID == null ? null : int.parse(
                SelectDataBCID.toString()),
            BCID2: SelectDataBCID2 == null ? null : SelectDataBCID2.toString(),
            BIID3: SelectDataBIID3 == null ? null : SelectDataBIID3.toString(),
            BDID: SelectDataBDID == null ? null : int.parse(
                SelectDataBDID.toString()),
            BCCID: PKID == 8 ? int.parse(SelectDataBCCID.toString()) : null,
            CTMID: STMID == 'COU' ? int.parse(CTMIDController.text) : null,
            CIMID: STMID == 'COU' ? int.parse(CIMIDController.text) : null,
            BMMNA: BCNAController.text,
            ABID: PKID == 9 ? int.parse(SelectDataABID.toString()) : null,
            BMMCN: BMMCNController.text,
            BMMRE: BMMREController.text.isEmpty || BMMREController.text == ''
                ? BMMNO
                : BMMREController.text,
            BMMDR: STMID == 'COU' ? BMMDRController.text : BMKID == 7 ||
                BMKID == 10 ? BMMDRController.text : BMMRE2Controller.text,
            BCMO: BCMOController.text,
            BMMMS: "$BMMMS ${BMMAMTOTController.text} ($SONA)",
            BMMEQ: roundDouble((double.parse(BMMAMController.text) + double
                .parse(SUMBMDTXTController.text)) * double.parse(SCEXController
                .text), 2),
            BMMTX1: SUMBMDTXT1,
            BMMTX2: SUMBMDTXT2,
            BMMTX3: SUMBMDTXT3,
            BMMTX: SUMBMDTXT,
            BMMDIF: SUMBMMDIF,
            BMMAM: roundDouble(double.parse(BMMAMController.text) +
                double.parse(SUMBMDTXTController.text), SCSFL),
            BMMDN: STMID == 'COU' ? 0 : int.parse(SelectDataBMMDN.toString()),
            BMMDI: SelectDataBMMDN == '1' ? SUMBMMDI : BMMDIController.text
                .isNotEmpty ? double.parse(BMMDIController.text) : 0,
            BMMDIA: 0,
            SCEXS: SCEXS,
            BMMDIR: BMMDIRController.text.isNotEmpty ? double.parse(
                BMMDIRController.text) : 0,
            BMMPT: USING_TAX_SALES == '2' ? 2 : Price_include_Tax == true ? 1 : 2,
            BMMDT: 1,
            BMMCD: (BMKID == 7 || BMKID == 10) ? BMMCDController.text : PKID == 3 ? BMMCDController.text : '',
            BMMCR: 0,
            BMMCA: 0,
            BMMTXD: 0,
            BMMLO: 0,
            BMMCT: 1,
            ATTID: 1,
            TTID1: TTID1,
            TTID2: TTID2,
            TTID3: TTID3,
            GUIDC: GUIDC,
            BMMBR: int.parse(SelectDataBMMBR.toString()),
            BMMDD: BMMDDController.text.isNotEmpty ? BMMDDController.text : _selectedDatesercher,
            BMMDOR: BMMRD,
            BMMRD: BMMRD,
            BIIDB: SelectDataBMMBR == '1' ? BIIDB : int.parse(
                SelectDataBIID.toString()),
            BMMMT: double.parse(BMMAMTOTController.text),
            AMMID: AMMID == null ? null : AMMID,
            SCIDP: STMID == 'COU'
                ? int.parse(SelectDataSCID.toString())
                : SelectDataSCIDP == null
                ? int.parse(SelectDataSCID.toString())
                : int.parse(SelectDataSCIDP.toString()),
            SCEXP: SCEXP == null ? double.parse(SCEXController.text) : SCEXP,
            BMMAMP: BMMCPController.text.isEmpty ? 0 : double.parse(
                BMMCPController.text),
            BMMCP: BMMCPController.text.isEmpty ? 0 : BMMCP,
            BMMTC: BMMTC == null ? 0 : BMMTC,
            BMMGR: BMMGRController.text,
            BMMDE: BMMDEController.text,
            BCDMO: BCDMOController.text,
            BCCNA: BCCNAController.text.isEmpty ? null : BCCNAController.text,
            BMMCRT: BMMCRTController.text,
            BMMTN: BMMTNController.text,
            BMMPD: DateFormat('dd-MM-yyyy HH:m').format(DateTime.now()),
            BMMLON: BCLON,
            BMMLAT: BCLAT,
            BMMTX_DAT: BMMTX_DAT,
            TTLID: BMKID == 1 || BMKID == 2 ? 0 : TTLID,
            TCRA: TCRA_M,
            TCSDID: TCSDID_M,
            TCSDSY: TCSDSY_M,
            TCID: TCID_M,
            TCSY: TCSY_M,
            BMMAM_TX: BMMAM_TX,
            BMMDI_TX: BMMDI_TX,
            TCAM: TCAM,
            SUID: LoginController().SUID,
            DATEI: DateFormat('dd-MM-yyyy hh:mm').format(DateTime.now()),
            DEVI: LoginController().DeviceName,
            GUID: GUID.toString().toUpperCase(),
            GUID_LNK: GUID_LNK.toString().toUpperCase(),
            BMMNOR: BMKID == 2 || BMKID == 4 || BMKID == 12 ? BMMNOR : null,
            BMMIDR: BMKID == 2 || BMKID == 4 || BMKID == 12 ? BMMIDR : null,
            BMMNR: STMID == 'COU' ? 1 : int.parse(CountRecodeController.text),
            JTID_L: LoginController().JTID,
            BIID_L: LoginController().BIID,
            SYID_L: LoginController().SYID,
            CIID_L: LoginController().CIID,
          );
          STB_N = 'S2';
          print('Save_BIF_MOV_M');
          print(e);
          await Save_BIF_MOV_M(
              BMKID == 11 || BMKID == 12 ? 'BIF_MOV_M' : 'BIL_MOV_M', e);
        }
        else {
          await UpdateBIL_MOV_M(
              BMKID == 11 || BMKID == 12 ? 'BIF_MOV_M' : 'BIL_MOV_M',
              BMKID!,
              BMMID!,
              '$SelectDays ${DateFormat('HH:mm').format(DateTime.now())}',
              PKID.toString(),
              roundDouble(
                  double.parse(BMMAMController.text) +
                      double.parse(SUMBMDTXTController.text),
                  SCSFL),
              SUMBMDTXT1!,
              SUMBMDTXT2!,
              SUMBMDTXT3!,
              SUMBMDTXT!,
              BMMREController.text,
              SelectDataACNO.toString(),
              SelectDataBCID.toString(),
              SelectDataBCID2 == null ? null : SelectDataBCID2.toString(),
              SelectDataBDID == null ? null : int.parse(
                  SelectDataBDID.toString()),
              BMKID == 11 || BMKID == 12
                  ? null
                  : PKID == 1
                  ? int.parse(SelectDataACID.toString())
                  : null,
              BMMINController.text,
              SelectDays.toString(),
              AANOController.text,
              BCNAController.text,
              BMMST,
              BMMCNController.text,
              PKID == 8 ? int.parse(SelectDataBCCID.toString()) : null,
              PKID == 9 ? int.parse(SelectDataABID.toString()) : null,
              int.parse(CountRecodeController.text),
              roundDouble(
                  (double.parse(BMMAMController.text) +
                      double.parse(SUMBMDTXTController.text)) *
                      double.parse(SCEXController.text),
                  2).toString(),
              SUMBMMDIF!,
              SelectDataBMMDN.toString(),
              SelectDataBMMDN == '1'
                  ? SUMBMMDI!
                  : BMMDIController.text.isNotEmpty
                  ? double.parse(BMMDIController.text)
                  : 0,
              BMMDIRController.text.isNotEmpty
                  ? double.parse(BMMDIRController.text)
                  : 0,
              PKID == 3 ? BMMCDController.text : '',
              int.parse(SelectDataBMMBR.toString()),
              BMMDDController.text.isNotEmpty
                  ? BMMDDController.text
                  : _selectedDatesercher,
              BMMRD!,
              double.parse(BMMAMTOTController.text),
              SelectDataBIID3 == null ? null : SelectDataBIID3.toString(),
              AMMID == null ? null : AMMID,
              SelectDataSCIDP == null
                  ? int.parse(SelectDataSCID.toString())
                  : int.parse(SelectDataSCIDP.toString()),
              SCEXP == null ? double.parse(SCEXController.text) : SCEXP,
              BMMCPController.text.isEmpty
                  ? 0
                  : double.parse(BMMCPController.text),
              BMMCPController.text.isEmpty
                  ? 0
                  : double.parse(BMMCPController.text),
              BMMTC == null ? 0 : BMMTC,
              SelectDataGETTYPE == '3' ? BCDID == 'null' ? null : BCDID
                  .toString() : null,
              SelectDataGETTYPE == '3' ? BCDMOController.text : null,
              SelectDataGETTYPE == '3' ? GUIDC2 : null,
              BMMGRController.text,
              TTLID,
              TCRA_M,
              TCSDID_M,
              TCSDSY_M,
              TCID_M,
              TCSY_M,
              BMMAM_TX,
              BMMDI_TX,
              TCAM,
              BMMCRTController.text,
              BMMTNController.text,
              BMMDRController.text
          );
        }

        if (STMID == 'EORD') {
          Save_BIL_MOV_A(typesave);
          Save_BIF_EORD_M_P();
        }

        //تعديل الكميه المخزنية
        if (BMMST != 4 && [1, 2, 3, 4].contains(BMKID)) {
          await UPDATE_STO_NUM();
        }

        if (StteingController().Show_Inv_Pay == true &&
            BMMCPController.text.isNotEmpty &&
            double.parse(BMMCPController.text) > 0 &&
            (BMKID == 1 || BMKID == 3 || BMKID == 5)) {
          await Save_ACC_MOV_D_P();
        }
        if (BMKID != 11 && BMKID != 12) {
          LoginController().SET_N_P(
              'BIID_SALE', int.parse(SelectDataBIID.toString()));
          LoginController().SET_N_P(
              'SCID_SALE', int.parse(SelectDataSCID.toString()));
          LoginController().SET_N_P('ACID_SALE', PKID == 1
              ? int.parse(SelectDataACID.toString())
              : LoginController().ACID_SALE);
          LoginController().SET_N_P('ABID_SALE', PKID == 9 || PKID == 2
              ? int.parse(SelectDataABID.toString())
              : LoginController().ABID_SALE);
          LoginController().SET_N_P('BCCID_SALE', PKID == 8 ? int.parse(SelectDataBCCID.toString())
              : LoginController().BCCID_SALE);
          LoginController().SET_N_P('SIID_SALE', int.parse(SelectDataSIID.toString()));
          LoginController().SET_N_P('SCID_SALE', int.parse(SelectDataSCID.toString()));
          LoginController().SET_N_P('PKID_SALE', PKID!);
          LoginController().SET_D_P('SCEX_SALE', double.parse(SCEXController.text));
          LoginController().SET_P('SCSY_SALE', SCSY);
          LoginController().SET_N_P('SCSFL_SALE', SCSFL);
          LoginController().SET_N_P('BDID_SALE', SelectDataBDID.toString() == 'null' ? 0 : int.parse(
                  SelectDataBDID.toString()));
          LoginController().SET_P('ACNO_SALE', SelectDataACNO.toString() == 'null' ? '0'
              : SelectDataACNO.toString());
        }
        LoginController().SET_N_P('TIMER_POST', 0);
        LoginController().SET_P('Return_Type', '1');
        CheckBack = 0;
        //save
        Get.snackbar('StringMesSave'.tr, "${'StringMesSave'.tr}-$BMMID",
            backgroundColor: Colors.green,
            icon: const Icon(Icons.save, color: Colors.white),
            colorText: Colors.white,
            isDismissible: true,
            dismissDirection: DismissDirection.horizontal,
            forwardAnimationCurve: Curves.easeOutBack);
        update();
        loading(false);
        Show_Inv_Pay = true;
        update();
        await UpdateStateBIL_MOV_D('SyncAll', BMKID.toString(), BMMID.toString(),
            2, BMKID == 11 || BMKID == 12 ? 'BIF_MOV_D' : 'BIL_MOV_D', '', '', '');
        update();
        STMID == 'EORD' ? Get.offNamed('/Home', arguments: 1) :
        STMID == 'MOB' ? Get.offNamed('/Sale_Invoices'):false;
        update();
        await GET_CountRecode(BMMID!);
        await GET_BIL_MOV_M_P("DateNow");
        await GET_BIL_MOV_M_PRINT_P(BMMID!);
        await GET_BIF_MOV_D_P(BMMID.toString(), RINT_RELATED_ITEMS_DETAIL.toString());
        await GET_Sys_Own_P(SelectDataBIID.toString());
        await GET_BIL_CUS_IMP_INF_P(BMKID == 1 || BMKID == 2? SelectDataBIID2.toString() : SelectDataBCID.toString());

        if (LoginController().USE_VAT_N == '1' && LoginController().USE_FAT_P_N == 1 && BMMST != 4 && STMID != 'EORD') {
         print('BMMST');
         print(BMMFS);
         print(BMMST);
          var FAT_CHK = await ES_FAT_PKG.MAIN_FAT_SND_INV(BMKID, BMMID,
              SelectDataBIID.toString(),'$SelectDays ${DateFormat('HH:mm').format(DateTime.now())}',
              GUID.toString().toUpperCase(), BMMST,
              LoginController().SSID_N, BMMFS, LoginController().SIGN_N, ST_O_N, MSG_O);
          if (await FAT_CHK) {
            print(MSG_O);
            print(ST_O_N);
            print(FAT_CHK);
            print('FAT_CHK');
          }
        }
        update();

        if (StteingController().isPrint == true && BMMST != 4 && PRINT_INV != '4') {
            await Future.delayed(const Duration(seconds: 2));
            {
              await PRINT_BALANCE_P(
                  BMMID:BMMID,
                  AANO:AANOController.text,
                  SCID:SelectDataSCID.toString(),
                  PKID:PKID.toString(),
                  typeRep: typeRep,
                  GetBMKID: BMKID.toString(),
                  GetBMMDO: '$SelectDays  ${DateFormat('HH:mm').format(DateTime.now())}',
                  GetBMMNO: BMMNO.toString(),
                  GetPKNA: PKNA.toString(),
                  mode: ShareMode.print
              );
            }

        }

        await GET_BIL_MOV_M_P("DateNow");

        if (BMMST != 4) {
          StteingController().isActivateAutoMoveSync == true
              ? await Socket_IP_Connect('SyncOnly', BMMID.toString(), false, 2)
              : false;
        }

        if( STMID == 'COU'){
          LoginController().InstallAddAfterSaving == true ?
          AddSale_Invoices() : Get.offNamed('/Sale_Invoices');
        }

        await GET_BIL_MOV_M_P("DateNow");

        // await SND_WS_P(GetBMKID: BMKID.toString(),
        //   GetBMMDO: '$SelectDays  ${DateFormat('HH:mm').format(DateTime.now())}',
        //   GetBMMNO: BMMNO.toString(), GetPKNA: PKNA.toString(),MSG_WS: 'تجربه',GetPHOEN: '');

        update();
        return true;
      }
    } catch (e, stackTrace) {
      Show_Inv_Pay = true;
      print('Save_BIL_MOV_M $e $stackTrace');
      Fluttertoast.showToast(
          msg: "${'StrinError_save_data'.tr}-${e.toString()}",
          toastLength: Toast.LENGTH_LONG,
          textColor: Colors.white,
          backgroundColor: Colors.redAccent);
      print("error-save_m ${e.toString()}");
      return false;
    }
  }


  //حفظ  النوع وبيانات الاقسام الطاولات
  Future<bool> Save_BIL_MOV_A(bool typesave) async {
    try {
      if (typesave == false) {
        Bif_Mov_A_Local e = Bif_Mov_A_Local(
          BMKID: BMKID,
          BMMID: BMMID,
          BMMNO: BMMNO == null ? 1 : int.parse(BMMNO!),
          RSID: SelectDataGETTYPE == '1' ? SelectDataRSID == null || SelectDataRSID=='null' ? null :
          int.parse(SelectDataRSID!) : null,
          RTID: SelectDataGETTYPE == '1' ? SelectDataRTID == null || SelectDataRTID=='null' ? null
              : SelectDataRTID : null,
          REID: SelectDataGETTYPE == '1' ? SelectDataREID == null || SelectDataREID=='null' ? null :
          int.parse(SelectDataREID.toString()) : null,
          BMATY: SelectDataGETTYPE == null ? 1 : int.parse(
              SelectDataGETTYPE.toString()),
          BDID: SelectDataGETTYPE == '3' ? SelectDataBDID_ORD == null
              ? null
              : int.parse(SelectDataBDID_ORD.toString()) : null,
          BMADD: BMADD.toString(),
          BCDID: SelectDataGETTYPE == '3' ? BCDID == 'null' ? null : int.parse(
              BCDID.toString()) : null,
          GUIDR: SelectDataGETTYPE == '3' ? GUIDC2 : null,
          GUID: GUID.toString().toUpperCase(),
          JTID_L: LoginController().JTID,
          BIID_L: LoginController().BIID,
          SYID_L: LoginController().SYID,
          CIID_L: LoginController().CIID,
        );
        Save_BIF_MOV_A(e);
      }
      else {
        UpdateBIL_MOV_A(
            BMKID!,
            BMMID!,
            SelectDataRSID == null ? null : SelectDataRSID.toString(),
            SelectDataRTID == null ? null : SelectDataRTID,
            SelectDataREID == null ? null : SelectDataREID.toString(),
            SelectDataGETTYPE == null ? '1' : SelectDataGETTYPE.toString(),
            SelectDataBDID_ORD == null ? null : SelectDataBDID_ORD.toString(),
            SelectDataGETTYPE == '3'
                ? BCDID == 'null' ? null : BCDID.toString()
                : null,
            SelectDataGETTYPE == '3' ? GUIDC2 : null);
      }
      return false;
    } catch (e) {
      Fluttertoast.showToast(
          msg: "SAVE_BIL_MOV_A-${e.toString()}",
          toastLength: Toast.LENGTH_LONG,
          textColor: Colors.white,
          backgroundColor: Colors.redAccent);
      print("error-save_a ${e.toString()}");
      return false;
    }
  }

  // حفظ جدول نقل الطاولات
  Future<bool> Save_BIF_TRA_TBL_P() async {
    try {
      if ( SelectDataGETTYPE == '1' && ( ( SelectDataRSIDO == null || SelectDataRSIDO=='null') ||
          ( SelectDataRTIDO == null || SelectDataRTIDO =='null') ||
          ( SelectDataRSID == null || SelectDataRSID =='null') ||
          ( SelectDataRTID == null || SelectDataRTID =='null')) ) {
        Fluttertoast.showToast(
            msg: 'StringError_MESSAGE'.tr,
            toastLength: Toast.LENGTH_LONG,
            textColor: Colors.white,
            backgroundColor: Colors.redAccent);
      }
      else{
        BIF_TRA_TBL_Local e = BIF_TRA_TBL_Local(
          RSIDO: int.parse(SelectDataRSIDO!) ,
          RTIDO: SelectDataRTIDO ,
          RSIDN: int.parse(SelectDataRSID!) ,
          RTIDN: SelectDataRTID ,
          GUIDF : GUID,
          BTTST : 2,
          STMIDI : STMID,
          GUID: uuid.v4().toUpperCase(),
          SUID: LoginController().SUID.toString(),
          DATEI: DateFormat('dd-MM-yyyy HH:mm').format(DateTime.now()),
          DEVI: LoginController().DeviceName.toString(),
          JTID_L: LoginController().JTID,
          BIID_L: LoginController().BIID,
          SYID_L: LoginController().SYID,
          CIID_L: LoginController().CIID,
        );
        Save_BIF_TRA_TBL(e);
        UpdateBIL_MOV_A(
            BMKID!,
            BMMID!,
            SelectDataRSID == null ? null : SelectDataRSID.toString(),
            SelectDataRTID == null ? null : SelectDataRTID,
            SelectDataREID == null ? null : SelectDataREID.toString(),
            SelectDataGETTYPE == null ? '1' : SelectDataGETTYPE.toString(),
            SelectDataBDID_ORD == null ? null : SelectDataBDID_ORD.toString(),
            SelectDataGETTYPE == '3'
                ? BCDID == 'null' ? null : BCDID.toString()
                : null,
            SelectDataGETTYPE == '3' ? GUIDC2 : null);
        Fluttertoast.showToast(
            msg: 'StringED'.tr,
            toastLength: Toast.LENGTH_LONG,
            textColor: Colors.white,
            backgroundColor: Colors.green);
        GET_BIL_MOV_M_P('DateNow');
      }
        return true;
    } catch (e) {
      Fluttertoast.showToast(
          msg: "Save_BIF_TRA_TBL-${e.toString()}",
          toastLength: Toast.LENGTH_LONG,
          textColor: Colors.white,
          backgroundColor: Colors.redAccent);
      print("error-save_a ${e.toString()}");
      return false;
    }
}


  //حفظ حالة الطلب
  Future<bool> Save_BIF_EORD_M_P() async {
    try {
      Bif_Eord_M_Local e = Bif_Eord_M_Local(
        BMKID: BMKID,
        BMMID: BMMID,
        BEMPS: 1,
        BEMPCS: 2,
        BEMIPS: 1,
        BEMBS: 2,
        SUID: LoginController().SUID.toString(),
        DATEI: DateFormat('dd-MM-yyyy HH:mm').format(DateTime.now()),
        DEVI: LoginController().DeviceName.toString(),
        GUID: GUID.toString().toUpperCase(),
        JTID_L: LoginController().JTID,
        BIID_L: LoginController().BIID,
        SYID_L: LoginController().SYID,
        CIID_L: LoginController().CIID,
      );
      Save_BIF_EORD_M(e);
      return false;
    } catch (e) {
      Fluttertoast.showToast(
          msg: "SAVE_BIF_EORD_M_P-${'StrinError_save_data'.tr}-${e.toString()}",
          toastLength: Toast.LENGTH_LONG,
          textColor: Colors.white,
          backgroundColor: Colors.redAccent);
      print("error-save_a ${e.toString()}");
      return false;
    }
  }

  //حذف الفاتورة
  bool delete_BIL_MOV(int? GetBMMID, int type) {
    if (type == 1) {
      deleteBIL_MOV_D(
          BMKID == 11 || BMKID == 12 ? 'BIF_MOV_D' : 'BIL_MOV_D', BMMID!);
      deleteBIL_MOV_M(
          BMKID == 11 || BMKID == 12 ? 'BIF_MOV_M' : 'BIL_MOV_M', BMMID!);
      deleteBIL_MOV_A(BMMID!);
      Get.snackbar('StringDelete'.tr, "${'StringDelete'.tr}-$BMMID",
          backgroundColor: Colors.green,
          icon: const Icon(Icons.delete, color: Colors.white),
          colorText: Colors.white,
          isDismissible: true,
          dismissDirection: DismissDirection.horizontal,
          forwardAnimationCurve: Curves.easeOutBack);
      update();
    } else if (type == 2) {
      if (UPDL == 1) {
        deleteBIL_MOV_D(
            BMKID == 11 || BMKID == 12 ? 'BIF_MOV_D' : 'BIL_MOV_D', GetBMMID!);
        deleteBIL_MOV_M(
            BMKID == 11 || BMKID == 12 ? 'BIF_MOV_M' : 'BIL_MOV_M', GetBMMID);
        deleteBIL_MOV_A(GetBMMID);
        Get.snackbar('StringDelete'.tr, "${'StringDelete'.tr}-$GetBMMID",
            backgroundColor: Colors.green,
            icon: const Icon(Icons.delete, color: Colors.white),
            colorText: Colors.white,
            isDismissible: true,
            dismissDirection: DismissDirection.horizontal,
            forwardAnimationCurve: Curves.easeOutBack);
        update();
        return true;
      } else {
        Get.snackbar('StringUPDL'.tr, 'String_CHK_UPDL'.tr,
            backgroundColor: Colors.red,
            icon: const Icon(Icons.error, color: Colors.white),
            colorText: Colors.white,
            isDismissible: true,
            dismissDirection: DismissDirection.horizontal,
            forwardAnimationCurve: Curves.easeOutBack);
        return false;
      }
    }
    return true;
  }

  //حذف الحركة الفرعية عند الخروج من التطبيق
  Future Delete_BIL_Mov_D_DetectApp() async {
    GET_BiL_Mov_D_DetectApp(
        BMKID == 11 || BMKID == 12 ? 'BIF_MOV_D' : 'BIL_MOV_D',
        BMKID == 11 || BMKID == 12 ? 'BIF_MOV_M' : 'BIL_MOV_M').then((data) {
      if (data.isNotEmpty) {
        BIF_MOV_D = data;
        DEL_SMMID = BIF_MOV_D
            .elementAt(0)
            .BMMID;
        deleteBIL_MOV_D(BMKID == 11 || BMKID == 12 ? 'BIF_MOV_D' : 'BIL_MOV_D',
            DEL_SMMID.toString());
      }
    });
  }

  //حفظ سند رئيسي
  Future<bool> Save_ACC_MOV_M_P() async {
    try {
      Acc_Mov_M_Local M = Acc_Mov_M_Local(
        AMKID: BMKID == 1 ? 2 : 1,
        AMMID: AMMID,
        AMMNO: AMMNO,
        PKID: '1',
        AMMDO: '$SelectDays ${DateFormat('HH:mm:ss').format(DateTime.now())}',
        AMMST: 2,
        AMMRE: BMMREController.text.isEmpty
            ? AMMNO.toString()
            : BMMREController.text,
        AMMCC: 2,
        SCID: int.parse(SelectDataSCID.toString()),
        SCEX: SCEXController.text,
        AMMAM: double.parse(BMMCPController.text),
        AMMEQ: roundDouble(
            (double.parse(BMMCPController.text) *
                double.parse(SCEXController.text.toString())),
            2),
        ACID: int.parse(SelectDataACID2.toString()),
        AMMIN: " سند ناتج عن فاتورة رقم ${BMMNO.toString()}",
        GUID: GUID_ACC_M.toUpperCase(),
        SUID: LoginController().SUID,
        AMMCT: 1,
        BKID: BMKID,
        BMMID: BMMID,
        BDID: SelectDataBDID.toString(),
        DATEI: DateFormat('dd-MM-yyyy HH:m').format(DateTime.now()),
        AMMDOR: DateFormat('dd-MM-yyyy').format(DateTime.now()),
        DEVI: LoginController().DeviceName,
        BIID: SelectDataBIID.toString(),
        AMMBR: 1,
        BIIDB: SelectDataBIID.toString(),
        GUID_LNK: GUID.toString().toUpperCase(),
        ROWN1: 1,
        JTID_L: LoginController().JTID.toString(),
        BIID_L: LoginController().BIID,
        SYID_L: LoginController().SYID,
        CIID_L: LoginController().CIID,
      );
      Save_ACC_MOV_M(M);
      update();
      Timer(const Duration(seconds: 10), () {
        Socket_IP_Connect_Save_ACC_MOV('SyncOnly', AMMID.toString());
        update();
      });
      return true;
    } catch (e) {
      Fluttertoast.showToast(
          msg: "${STB_N}-${'StrinError_save_data'.tr}",
          toastLength: Toast.LENGTH_LONG,
          textColor: Colors.white,
          backgroundColor: Colors.redAccent);
      return false;
    }
  }

  //حفظ الحركه الفرعيه
  Future<bool> Save_ACC_MOV_D_P() async {
    try {
      GUID_ACC_M = uuid.v4();
      Acc_Mov_D_Local e = Acc_Mov_D_Local(
        AMKID: BMKID == 1 ? 2 : 1,
        AMMID: AMMID,
        AMDID: 1,
        AANO: AANOController.text,
        AMDRE: BMMREController.text,
        AMDIN: AMMIN,
        SCID: SelectDataSCID,
        SCEX: SCEXController.text,
        AMDDA: BMKID == 1
            ? 0.0
            : roundDouble(double.parse(BMMCPController.text.toString()), 2),
        AMDMD: BMKID == 1
            ? roundDouble(double.parse(BMMCPController.text.toString()), 2)
            : 0.0,
        AMDEQ: roundDouble(
            (double.parse(BMMCPController.text.toString()) *
                double.parse(SCEXController.text)),
            2),
        AMDTY: '1',
        AMDST: '1',
        GUID: uuid.v4().toUpperCase(),
        GUIDF: GUID_ACC_M.toUpperCase(),
        AMDKI: 'O',
        AMDVW: 1,
        SYST_L: 2,
        BIID: SelectDataBIID.toString(),
        SUID: LoginController().SUID,
        DATEI: DateFormat('dd-MM-yyyy HH:m').format(DateTime.now()),
        DEVI: LoginController().DeviceName,
        JTID_L: LoginController().JTID,
        BIID_L: LoginController().BIID,
        SYID_L: LoginController().SYID,
        CIID_L: LoginController().CIID,
      );
      print(e);
      Save_ACC_MOV_D(e);
      Save_ACC_MOV_M_P();
      return true;
    } catch (e) {
      print("Save_ACC_MOV_D_P-${e}");
      Fluttertoast.showToast(
          msg: "Save_ACC_MOV_D_P${'StrinError_save_data'.tr}${e}",
          toastLength: Toast.LENGTH_LONG,
          textColor: Colors.white,
          backgroundColor: Colors.redAccent);
      return false;
    }
  }


  //جلب رقم
  Future GET_BCDID_P() async {
    GET_BCDID().then((data) {
      BCDID = data
          .elementAt(0)
          .BCDID
          .toString();
    });
  }

  //حفظ العميل
  bool Save_BIF_CUS_D_P() {
    try {
      STB_N = 'S1';
      if (BCDNAController.text
          .trim()
          .isEmpty || BCDMOController.text
          .trim()
          .isEmpty) {
        Get.snackbar('StringErrorMes'.tr, 'StringError_MESSAGE'.tr,
            backgroundColor: Colors.red,
            icon: const Icon(Icons.error, color: Colors.white),
            colorText: Colors.white,
            isDismissible: true,
            dismissDirection: DismissDirection.horizontal,
            forwardAnimationCurve: Curves.easeOutBack);
        STB_N = 'S2';
        return false;
      } else {
        GUIDC2 = uuid.v4().toString();
        GET_BCDID_P();
        Timer(const Duration(seconds: 1), () {
          if (edit == false) {
            Bif_Cus_D_Local B = Bif_Cus_D_Local(
              BCDID: int.parse(BCDID.toString()),
              BCDNA: BCDNAController.text,
              BCDNE: BCDNAController.text,
              BCDDO: DateFormat('dd-MM-yyyy HH:mm:ss').format(DateTime.now()),
              BCDMO: BCDMOController.text,
              BCDAD: BCDADController.text,
              CWID: SelectDataCWID.toString(),
              CTID: SelectDataCTID.toString(),
              BAID: SelectDataBAID == null ? null : int.parse(
                  SelectDataBAID.toString()),
              BCDSN: BCDSNController.text,
              BCDBN: BCDBNController.text,
              BCDFN: BCDFNController.text,
              BCDST: 1,
              SUID: LoginController().SUID,
              GUID: GUIDC2.toString().toUpperCase(),
              SYST_L: 2,
              BCDDL_L: 2,
              DATEI: DateFormat('dd-MM-yyyy HH:mm:ss').format(DateTime.now()),
              DEVI: LoginController().DeviceName,
              JTID_L: LoginController().JTID,
              BIID_L: LoginController().BIID,
              SYID_L: LoginController().SYID,
              CIID_L: LoginController().CIID,
            );
            STB_N = 'S3';
            Save_BIF_CUS_D(B);
          }
          else {
            STB_N = 'S4';
            UpdateBIF_CUS_D(
                int.parse(BCDID.toString()),
                BCDNAController.text,
                BCDMOController.text,
                BCDADController.text
                ,
                SelectDataCWID,
                SelectDataCTID,
                SelectDataBAID,
                BCDSNController.text,
                BCDBNController.text,
                BCDBNController.text,
                2);
          }
          Fluttertoast.showToast(
              msg: 'StringAD'.tr,
              toastLength: Toast.LENGTH_LONG,
              textColor: Colors.white,
              backgroundColor: Colors.green);
          Socket_IP_Connect_Save_BIF_CUS_D();
        });
        return true;
      }
    }
    catch (e) {
      Fluttertoast.showToast(
          msg: "${STB_N}-${'StrinError_save_data'.tr}",
          toastLength: Toast.LENGTH_LONG,
          textColor: Colors.white,
          backgroundColor: Colors.redAccent);
      return false;
    }
  }

  void DataGrid() {
    DataGridPageInvoice();
    update();
  }
  scanBarcodeNormal() async {
    String barcodeScanRes;

    try {
      var result = await BarcodeScanner.scan();
      barcodeScanRes = result.rawContent;
    } catch (e) {
      barcodeScanRes = 'Failed to get barcode.';
    }

    _scanBarcode = barcodeScanRes;
    FetchBarcodData(_scanBarcode);

    Timer(const Duration(milliseconds: 400), () {
      displayAddItemsWindo();
      myFocusNode.requestFocus();
    });
  }

  // scanBarcodeNormal() async {
  //   String barcodeScanRes;
  //   // Platform messages may fail, so we use a try/catch PlatformException.
  //   try {
  //     barcodeScanRes = await FlutterBarcodeScanner.scanBarcode(
  //         '#ff6666', 'Cancel', true, ScanMode.BARCODE);
  //   } on PlatformException {
  //     barcodeScanRes = 'Failed to get platform version.';
  //   }
  //   _scanBarcode = barcodeScanRes;
  //   FetchBarcodData(_scanBarcode);
  //   Timer(const Duration(milliseconds: 400), () {
  //     displayAddItemsWindo();
  //     myFocusNode.requestFocus();
  //   });
  // }


  //تعديل الصنف(الكمية) مطاعم
  Future<void> UPDATE_BIF_MOV_D_ORD(Bil_Mov_D_Local food, int TYPE) async {
    if (food.SYST != 1) {
      print('MGNOController2');
      print(food.BMDID.toString());
      print(food.MGNO.toString());
      print('MGNOController2');
      BMDIDController.text = food.BMDID.toString();
      MGNOController.text = food.MGNO.toString();
      SelectDataMINO = food.MINO.toString();
      SelectDataMUID = food.MUID.toString();
      BMDNOController.text = food.BMDNO.toString();
      await GET_COUNT_MINO_P();
      await GET_COUNT_NO_P(
          food.MGNO.toString(), food.MINO.toString(), food.MUID!);
      BMDNO_V = food.BMDNO;
      BMDNFController.text = food.BMDNF.toString();
      BMDAMController.text = food.BMDAMO.toString();
      BMDDIController.text = food.BMDDI.toString();
      BMDDIRController.text = food.BMDDIR.toString();
      SelectDataSNED = food.BMDED.toString();
      BMDTXAController.text = food.BMDTXA.toString();
      BMDTX = food.BMDTX;
      BMDTXController.text = food.BMDTX1.toString();
      BMDTX2Controller.text = food.BMDTX2.toString();
      BMDTX3Controller.text = food.BMDTX3.toString();
      BMDTXA = food.BMDTXA1;
      BMDTXA2 = food.BMDTXA2;
      BMDTXA3 = food.BMDTXA3;
      BMDTXT1 = food.BMDTXT1;
      BMDTXT2 = food.BMDTXT2;
      BMDTXT3 = food.BMDTXT3;
      if (TTID1 != null) {
        await GET_TAX_LIN_P('MAT', food.MGNO.toString(), food.MINO.toString());
      }
      if (TYPE == 1) {
        print((double.parse(food.BMDNO.toString()) + 1));
        BMDNOController.text =
            (double.parse(food.BMDNO.toString()) + 1).toString();
        // Timer(const Duration(milliseconds: 200), () async {
          await Calculate_BMD_NO_AM();
          update();
          bool isValid = await Save_BIL_MOV_D_ORD_P();
          if (isValid) {
            // ClearBil_Mov_D_Data();
          }
        // });
      } else {
        if ((food.BMDNO! - 1) < 1) {
          deleteBIL_MOV_D_ONE(
              'BIF_MOV_D', food.BMMID.toString(), food.BMDID.toString());
          cartFood.removeWhere((element) => element == food);
          update();
        }
        else {
          BMDNOController.text = (double.parse(food.BMDNO.toString()) - 1).toString();
          // Timer(const Duration(milliseconds: 200), () async {
            await Calculate_BMD_NO_AM();
            update();
            bool isValid = await Save_BIL_MOV_D_ORD_P();
            if (isValid) {
              // ClearBil_Mov_D_Data();
            }
            update();
          // });
        }
      }
      // await GET_SUMBMMAM();
      // await GET_SUMBMMAM2();
      // await GET_SUMBMDTXA();
      // await GET_SUMBMMDIF();
      // await GET_SUMBMMDI();
      // await GET_CountRecode(BMMID!);
      // await GET_COUNT_BMDNO_P(BMMID!);
      // await GET_SUMBMDTXT();
      // await GET_SUM_AM_TXT_DI();
      update();
    }
  }

  //جلب عدد السجلات على حسب المجموعة والصبف والوحدة من الفاتورة
  Future GET_COUNT_NO_P(String GETMGNO, String GETMINO, int GETMUID) async {
    var GET_COUNT = await GET_COUNT_NO(
        BMKID == 11 || BMKID == 12 ? 'BIF_MOV_D' : 'BIL_MOV_D',
        BMMID.toString(), GETMGNO, GETMINO, GETMUID);
    if (GET_COUNT.isNotEmpty) {
      COUNT_NO = GET_COUNT
          .elementAt(0)
          .COUNT_MINO!;
    } else {
      COUNT_NO = 0;
    }
  }

  //دوال المزامنة
  //التي لم تزامن  جلب عدد السجلات
  Future GET_COUNT_SYNC() async {
    GET_SYNC_DATA(BMKID == 11 || BMKID == 12 ? 'BIF_MOV_M' : 'BIL_MOV_M',
        DateFormat('dd-MM-yyyy').format(DateTime.now())).then((data) {
      BIL_MOV_M = data;
      if (BIL_MOV_M.isNotEmpty) {
        COUNT_SYNC = BIL_MOV_M
            .elementAt(0)
            .SYNC_COUNT!;
        update();
      }
    });
  }

  void configloading(String MES_ERR) {
    EasyLoading.instance
      ..displayDuration = const Duration(milliseconds: 2000)
      ..indicatorType = EasyLoadingIndicatorType.fadingCircle
      ..loadingStyle = EasyLoadingStyle.custom
      ..indicatorSize = 45.0
      ..radius = 10.0
      ..backgroundColor = Colors.redAccent
      ..indicatorColor = Colors.white
      ..textColor = Colors.white
      ..maskColor = Colors.blue.withOpacity(0.5)
      ..userInteractions = true
      ..dismissOnTap = false;
    EasyLoading.showError(MES_ERR);
  }

  Socket_IP_Connect(String TypeSync, String GetBMMID, bool TypeAuto, int BMMST2) async {
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
      ..userInteractions = true
      ..dismissOnTap = false;
    TypeAuto == true ? EasyLoading.show(status: 'StringWeAreSync'.tr) : false;
    Socket.connect(LoginController().IP, int.parse(LoginController().PORT),
        timeout: const Duration(seconds: 5)).then((socket) async {
      print("Success");
      await SyncCustomerData(TypeSync, GetBMMID, TypeAuto, BMMST2);
      socket.destroy();
    }).catchError((error) {
      Get.snackbar('StringCHK_Err_Con'.tr, 'StringCHK_Con'.tr,
          backgroundColor: Colors.red,
          icon: const Icon(Icons.error, color: Colors.white),
          colorText: Colors.white,
          isDismissible: true,
          dismissDirection: DismissDirection.horizontal,
          forwardAnimationCurve: Curves.easeOutBack);
      configloading("StrinError_Sync".tr);
      Fluttertoast.showToast(
          msg: "${error.toString()}",
          toastLength: Toast.LENGTH_LONG,
          textColor: Colors.white,
          backgroundColor: Colors.red);
      print("Exception on Socket $error");
    });
  }

  GetCheckCustomerData() async {
    ArrLengthCus = await Get_CustomerData_Check();
    update();
  }

  AwaitFunc(String TypeSync, String GetBMMID, bool TypeAuto, int BMMST2) async {
    for (var i = 0; i <= 200; i++) {
      await Future.delayed(const Duration(milliseconds: 500));
      {
        print(i);
        print(ArrLengthCus);
        print('arrlength');
        if (ArrLengthCus == 0) {
          await Future.delayed(const Duration(seconds: 1));
          await SyncBIL_MOV_D_P(TypeSync, GetBMMID, TypeAuto, BMMST2);
          ArrLengthCus = 0;
          break; // Exit the loop instead of setting i = 200 manually
        }
        else {
          await GetCheckCustomerData();
          update();
        }
      }
    }
  }

  Future SyncCustomerData(String TypeSync, String GetBMMID, bool TypeAuto, int BMMST2) async {
    var CustomerList = await SyncronizationData().FetchCustomerData('SyncAll', '0');
    if (CustomerList.isNotEmpty && CustomerList.length > 0) {
      await SyncronizationData().SyncCustomerToSystem(CustomerList, 'SyncAll', '0', 0, TypeAuto); // GET_COUNT_SYNC();
      update();
      await AwaitFunc(TypeSync, GetBMMID, TypeAuto, BMMST2);
    }
    else {
      await SyncBIL_MOV_D_P(TypeSync, GetBMMID, TypeAuto, BMMST2);
    }
  }

  Future<void> SyncBIL_MOV_D_P(String TypeSync, String GetBMMID, bool TypeAuto, int BMMST2) async {
    if (STMID == "EORD") {
      Socket_IP_Connect_Save_BIF_CUS_D();
    }
    print('STEP----1');

    // Fetch Data
    var listD = await SyncronizationData().fetchAll_BIL_D(TypeSync, BMKID!, GetBMMID, '', '', '');

    if (listD.isNotEmpty) {
      // // Ensure correct type if needed
      // List<BIL_MOV_D> typedList = listD.cast<BIL_MOV_D>();
      await SyncronizationData().SyncBIL_MOV_DToSystem(
        TypeSync,
        BMKID!,
        GetBMMID,
        listD, // Pass the correctly casted list
        BMKID == 11 || BMKID == 12 ? 'BIF_MOV_D' : 'BIL_MOV_D',
        TypeAuto,
        BMMST2,
        '',
        '',
      );

      await Future.delayed(const Duration(seconds: 3));
      GET_BIL_MOV_M_P("DateNow");

    } else {
      if (TypeAuto) {
        configloading("StringNoDataSync".tr);
      }
    }
  }


  Future GET_ECO_ACC_P(String AANO) async {
    ECO_ACC=await GET_ECO_ACC(AANO);
    if(ECO_ACC.isNotEmpty){
      BCDMOController.text= ECO_ACC.elementAt(0).EATL.toString();
    }
  }

  Future<void> Socket_IP_Connect_Save_ACC_MOV(String TypeSync, String GetAMMID) async {
    try {
      final socket = await Socket.connect(
        LoginController().IP,
        int.parse(LoginController().PORT),
        timeout: const Duration(seconds: 5),
      );

      print("Socket Connection Successful");
      await SyncACC_MOV_D_AUTO(TypeSync, GetAMMID);

      socket.destroy();
    } catch (error) {
      print("Socket Connection Failed: $error");
    }
  }

  Future<void> Socket_IP_Connect_Save_BIF_CUS_D() async {
    try {
      final socket = await Socket.connect(
        LoginController().IP,
        int.parse(LoginController().PORT),
        timeout: const Duration(seconds: 5),
      );

      print("Socket Connection Successful");

      var customerList = await SyncronizationData().FetchBIF_CUS_D('SyncAll', '0');

      if (customerList.isNotEmpty) {
        TAB_N = 'BIF_CUS_D';
        await SyncronizationData().SyncBIF_CUS_D_ToSystem(customerList, 'SyncAll', '0', 0);

        Timer(const Duration(seconds: 5), () {
          GET_BIF_CUS_D_P();
          GET_BIF_CUS_D_ONE_P(GUIDC2.toString());
          update();
        });

        update();
      }

      socket.destroy();
    } catch (error) {
      print("Socket Connection Failed: $error");
    }
  }

  Future<void> SyncACC_MOV_D_AUTO(String TypeSync, String GetAMMID) async {
    var listD = await SyncronizationData().FetchACC_MOV_DData(TypeSync, '1', GetAMMID, '', '', '');
    if (listD.isNotEmpty) {
      await SyncronizationData().SyncACC_MOV_DToSystem(TypeSync, '1', GetAMMID, listD, false, '', '', '');
    }
  }


  //----------- التصميم -------------
  Future<void> selectDateFromDays2(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
        context: context,
        initialDate: dateTimeDays,
        firstDate: DateTime(2022, 5),
        lastDate: DateTime(2050));

    if (picked != null) {
      dateTimeDays = picked;
      BMDEDController.text = dateTimeDays.toString().split(" ")[0];
      update();
    }
  }

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
                                                  crossAxisAlignment: CrossAxisAlignment
                                                      .end,
                                                  children: <Widget>[
                                                    StteingController()
                                                        .isSwitchUse_Gro == true
                                                        ? SizedBox(
                                                      height: 0.01 * height,
                                                    )
                                                        : const SizedBox(
                                                      height: 0,
                                                    ),
                                                    StteingController()
                                                        .isSwitchUse_Gro == true
                                                        ? Row(
                                                      children: [
                                                        Expanded(
                                                            child:
                                                            DropdownMAT_GROBuilder()),
                                                      ],
                                                    )
                                                        : const SizedBox(
                                                      height: 0,
                                                    ),
                                                    Center(child: Text(
                                                        'عدد السجلات: ${autoCompleteData.length}')),
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
                                                            _autocompleteFocusNode = focusNode;
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
                                                                scanBarcodeNormal();
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
                                                                selectDateFromDays2(
                                                                    context);
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
                                                        (([3, 4, 7, 10].contains(BMKID)) &&
                                                            StteingController().MULTI_STORES_BO == true) || (([1, 2].contains(BMKID)) &&
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
                                                        (PKID == 1 && controller
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
                                                                'M')) : (PKID ==
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
                                                            : (PKID != 1 &&
                                                            PKID != 3 &&
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
                                                        (USING_TAX_SALES == '1' ||
                                                            (USING_TAX_SALES ==
                                                                '3' &&
                                                                (UPIN_USING_TAX_SALES ==
                                                                    1 &&
                                                                    Price_include_Tax ==
                                                                        true)))
                                                            ? Text(
                                                            "StringBMMAMTX".tr,
                                                            style: ThemeHelper()
                                                                .buildTextStyle(
                                                                context,
                                                                Colors.black,
                                                                'M'))
                                                            : Container(),
                                                        (USING_TAX_SALES == '1' ||
                                                            (USING_TAX_SALES ==
                                                                '3' &&
                                                                (UPIN_USING_TAX_SALES ==
                                                                    1 &&
                                                                    Price_include_Tax ==
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
                                                        (USING_TAX_SALES == '1' ||
                                                            (USING_TAX_SALES ==
                                                                '3' &&
                                                                (UPIN_USING_TAX_SALES ==
                                                                    1 &&
                                                                    Price_include_Tax ==
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
                                                        (USING_TAX_SALES == '1' ||
                                                            (USING_TAX_SALES ==
                                                                '3' &&
                                                                (UPIN_USING_TAX_SALES ==
                                                                    1 &&
                                                                    Price_include_Tax ==
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
                                                                if (v
                                                                    .isNotEmpty &&
                                                                    double.parse(
                                                                        v) >=
                                                                        0.0) {
                                                                  controller
                                                                      .Calculate_BMD_NO_AM();
                                                                } else {
                                                                  SUMBMDAMController
                                                                      .text = '0';
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
                                                        (PKID == 1 && controller
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
                                                            )) : (PKID == 3 &&
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
                                                            : (PKID != 1 &&
                                                            PKID != 3 &&
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
                                                        (USING_TAX_SALES == '1' ||
                                                            (USING_TAX_SALES ==
                                                                '3' &&
                                                                (UPIN_USING_TAX_SALES ==
                                                                    1 &&
                                                                    Price_include_Tax ==
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
                                                        (USING_TAX_SALES == '1' ||
                                                            (USING_TAX_SALES ==
                                                                '3' &&
                                                                (UPIN_USING_TAX_SALES ==
                                                                    1 &&
                                                                    Price_include_Tax ==
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
                                                                    Allow_Cho_Price);
                                                                print(
                                                                    UPIN_Allow_Cho_Price);
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
                                                                    controller
                                                                        .MPS1 = 0;
                                                                    controller
                                                                        .MPS1 =
                                                                        double
                                                                            .parse(
                                                                            BMDAMController
                                                                                .text);
                                                                    // await Future.delayed(const Duration(milliseconds: 1300));
                                                                    controller
                                                                        .Calculate_BMD_NO_AM();
                                                                  } else {
                                                                    BMDAMTXController
                                                                        .text =
                                                                    '0';
                                                                    SUMBMDAMController
                                                                        .text =
                                                                    '0';
                                                                  }
                                                                },
                                                                onTap: () {
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
                                                                if (v
                                                                    .isNotEmpty &&
                                                                    double.parse(
                                                                        v) >=
                                                                        0.0) {
                                                                  controller
                                                                      .Calculate_BMD_NO_AM();
                                                                } else {
                                                                  SUMBMDAMController
                                                                      .text = '0';
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
                                                        (USING_TAX_SALES == '1' ||
                                                            (USING_TAX_SALES ==
                                                                '3' &&
                                                                (UPIN_USING_TAX_SALES ==
                                                                    1 &&
                                                                    Price_include_Tax ==
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
                                                        (USING_TAX_SALES == '1' ||
                                                            (USING_TAX_SALES ==
                                                                '3' &&
                                                                (UPIN_USING_TAX_SALES ==
                                                                    1 &&
                                                                    Price_include_Tax ==
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
                                                                    Allow_Cho_Price);
                                                                print(
                                                                    UPIN_Allow_Cho_Price);
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
                                                                            BMDAMController
                                                                                .text);
                                                                    await Future
                                                                        .delayed(
                                                                        const Duration(
                                                                            milliseconds: 1200));
                                                                    controller
                                                                        .Calculate_BMD_NO_AM();
                                                                  } else {
                                                                    BMDAMTXController
                                                                        .text =
                                                                    '0';
                                                                    SUMBMDAMController
                                                                        .text =
                                                                    '0';
                                                                  }
                                                                },
                                                                onTap: () {
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
                                          ? (PKID == 1 && controller
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
                                          : (PKID == 3 && controller
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
                                          : (PKID != 1 && PKID != 3 && controller
                                          .Allow_give_discount_Pay_Not_Cash_Due ==
                                          '1' ||
                                          (controller
                                              .Allow_give_discount_Pay_Not_Cash_Due ==
                                              '3'
                                              && controller
                                                  .UPIN_Allow_give_discount_Pay_Not_Cash_Due ==
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
                                                    "${'StringSUM_BMMTX'
                                                        .tr}                                                          %${formatter
                                                        .format(BMDTX)
                                                        .toString()}",
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
                                                  if (BMKID != 1 && BMKID != 2 &&
                                                      controller.When_Selling_Items_Lower_Price_than_Cost_Price == '1' &&
                                                      double.parse(controller.MPCOController.text) > 0 &&
                                                      double.parse(controller.MPCOController.text) > controller.BMDAM1!) {
                                                    Navigator.of(context).pop(
                                                        false);
                                                    Get.defaultDialog(
                                                      title: 'StringMestitle'.tr,
                                                      middleText:
                                                      'StringItems_Lower_Price'
                                                          .tr,
                                                      backgroundColor: Colors
                                                          .white,
                                                      radius: 40,
                                                      textCancel: 'StringNo'.tr,
                                                      cancelTextColor: Colors.red,
                                                      textConfirm: 'StringYes'.tr,
                                                      confirmTextColor: Colors
                                                          .white,
                                                      onConfirm: () async {
                                                        if (BMKID != 1 && BMKID != 2 && Use_lowest_selling_price == '1' && MPLP! > 0
                                                            && BMDAM1! < MPLP!) {
                                                          Navigator.of(context).pop(false);
                                                          Get.defaultDialog(
                                                            title:
                                                            'StringMestitle'.tr,
                                                            middleText:
                                                            'StringUse_lowest_selling_price'
                                                                .tr,
                                                            backgroundColor:
                                                            Colors.white,
                                                            radius: 40,
                                                            textCancel: 'StringOK'.tr,
                                                            cancelTextColor:
                                                            Colors.blueAccent,
                                                            barrierDismissible: false,
                                                          );
                                                        } else if (BMKID != 1 && BMKID != 2 &&
                                                            Use_lowest_selling_price ==
                                                                '3' &&
                                                            Allow_lowest_selling_price !=
                                                                1 &&
                                                            MPLP! > 0 &&
                                                            BMDAM1! < MPLP!) {
                                                          Navigator.of(context)
                                                              .pop(false);
                                                          Get.defaultDialog(
                                                            title:
                                                            'StringMestitle'.tr,
                                                            middleText:
                                                            'StringUse_lowest_selling_price'
                                                                .tr,
                                                            backgroundColor:
                                                            Colors.white,
                                                            radius: 40,
                                                            textCancel: 'StringOK'
                                                                .tr,
                                                            cancelTextColor:
                                                            Colors.blueAccent,
                                                            barrierDismissible: false,
                                                          );
                                                        } else {
                                                          if (BMKID != 1 && BMKID != 2 &&
                                                              Use_highest_selling_price == '1' &&
                                                              MPHP! > 0 &&
                                                              BMDAM1! > MPHP!) {
                                                            Navigator.of(context)
                                                                .pop(false);
                                                            Get.defaultDialog(
                                                              title:
                                                              'StringMestitle'.tr,
                                                              middleText:
                                                              'StringUse_highest_selling_price'
                                                                  .tr,
                                                              backgroundColor:
                                                              Colors.white,
                                                              radius: 40,
                                                              textCancel:
                                                              'StringOK'.tr,
                                                              cancelTextColor:
                                                              Colors.blueAccent,
                                                              barrierDismissible:
                                                              false,
                                                            );
                                                          } else if (BMKID != 1 && BMKID != 2 &&
                                                              Use_highest_selling_price == '3' &&
                                                              Allow_highest_selling_price != 1 &&
                                                              MPHP! > 0 && BMDAM1! > MPHP!) {
                                                            Navigator.of(context)
                                                                .pop(false);
                                                            Get.defaultDialog(
                                                              title:
                                                              'StringMestitle'.tr,
                                                              middleText:
                                                              'StringUse_highest_selling_price'
                                                                  .tr,
                                                              backgroundColor:
                                                              Colors.white,
                                                              radius: 40,
                                                              textCancel:
                                                              'StringOK'.tr,
                                                              cancelTextColor:
                                                              Colors.blueAccent,
                                                              barrierDismissible:
                                                              false,
                                                            );
                                                          } else {
                                                            // Navigator.of(context).pop(false);
                                                            bool isValid = await controller
                                                                .Save_BIL_MOV_D_P();
                                                            if (isValid) {
                                                              DataGrid();
                                                              controller
                                                                  .ClearBil_Mov_D_Data();
                                                              controller
                                                                  .minaFocusNode
                                                                  .requestFocus();
                                                            }
                                                          }
                                                        }
                                                      },
                                                      barrierDismissible: false,
                                                    );
                                                  } else if (BMKID != 1 &&
                                                      controller.When_Selling_Items_Lower_Price_than_Cost_Price == '2' &&
                                                      double.parse(controller.MPCOController.text) > 0 &&
                                                      double.parse(controller.MPCOController.text) > BMDAM1!) {
                                                    Navigator.of(context).pop(false);
                                                    Get.defaultDialog(
                                                      title: 'StringMestitle'.tr,
                                                      middleText:
                                                      'StringErr_Items_Lower_Price'.tr,
                                                      backgroundColor: Colors.white,
                                                      radius: 40,
                                                      textCancel: 'StringOK'.tr,
                                                      cancelTextColor: Colors.blueAccent,
                                                      barrierDismissible: false,
                                                    );
                                                  } else if (BMKID != 1 && BMKID != 2 &&
                                                      controller.When_Selling_Items_Lower_Price_than_Cost_Price ==
                                                          '4' &&
                                                      controller
                                                          .Allowto_Sell_Less_than_Cost_Price !=
                                                          1 &&
                                                      double.parse(controller
                                                          .MPCOController.text) >
                                                          0 &&
                                                      double.parse(controller
                                                          .MPCOController.text) >
                                                          BMDAM1!) {
                                                    Navigator.of(context).pop(
                                                        false);
                                                    Get.defaultDialog(
                                                      title: 'StringMestitle'.tr,
                                                      middleText:
                                                      'StringErr_Items_Lower_Price'
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
                                                    Navigator.of(context).pop(
                                                        false);
                                                    if (BMKID != 1 && BMKID != 2 &&
                                                        Use_lowest_selling_price ==
                                                            '1' &&
                                                        MPLP! > 0 &&
                                                        BMDAM1! < MPLP!) {
                                                      Navigator.of(context)
                                                          .pop(false);
                                                      Get.defaultDialog(
                                                        title: 'StringMestitle'
                                                            .tr,
                                                        middleText:
                                                        'StringUse_lowest_selling_price'
                                                            .tr,
                                                        backgroundColor: Colors
                                                            .white,
                                                        radius: 40,
                                                        textCancel: 'StringOK'.tr,
                                                        cancelTextColor:
                                                        Colors.blueAccent,
                                                        barrierDismissible: false,
                                                      );
                                                    } else if (BMKID != 1 && BMKID != 2 &&
                                                        Use_lowest_selling_price ==
                                                            '3' &&
                                                        Allow_lowest_selling_price !=
                                                            1 &&
                                                        MPLP! > 0 &&
                                                        BMDAM1! < MPLP!) {
                                                      Navigator.of(context)
                                                          .pop(false);
                                                      Get.defaultDialog(
                                                        title: 'StringMestitle'
                                                            .tr,
                                                        middleText:
                                                        'StringUse_lowest_selling_price'
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
                                                      if (BMKID != 1 && BMKID != 2 &&
                                                          Use_highest_selling_price ==
                                                              '1' &&
                                                          MPHP! > 0 &&
                                                          BMDAM1! > MPHP!) {
                                                        Navigator.of(context)
                                                            .pop(false);
                                                        Get.defaultDialog(
                                                          title: 'StringMestitle'
                                                              .tr,
                                                          middleText:
                                                          'StringUse_highest_selling_price'
                                                              .tr,
                                                          backgroundColor:
                                                          Colors.white,
                                                          radius: 40,
                                                          textCancel: 'StringOK'
                                                              .tr,
                                                          cancelTextColor:
                                                          Colors.blueAccent,
                                                          barrierDismissible: false,
                                                        );
                                                      } else if (BMKID != 1 && BMKID != 2 &&
                                                          Use_highest_selling_price ==
                                                              '3' &&
                                                          Allow_highest_selling_price !=
                                                              1 &&
                                                          MPHP! > 0 &&
                                                          BMDAM1! > MPHP!) {
                                                        Navigator.of(context)
                                                            .pop(false);
                                                        Get.defaultDialog(
                                                          title: 'StringMestitle'
                                                              .tr,
                                                          middleText:
                                                          'StringUse_highest_selling_price'
                                                              .tr,
                                                          backgroundColor:
                                                          Colors.white,
                                                          radius: 40,
                                                          textCancel: 'StringOK'
                                                              .tr,
                                                          cancelTextColor:
                                                          Colors.blueAccent,
                                                          barrierDismissible: false,
                                                        );
                                                      } else {
                                                        // Navigator.of(context).pop(false);

                                                        bool isValid = await controller
                                                            .Save_BIL_MOV_D_P();
                                                        if (isValid) {
                                                          DataGrid();
                                                          controller
                                                              .ClearBil_Mov_D_Data();
                                                        }
                                                      }
                                                    }
                                                  }
                                                },
                                                barrierDismissible: false,
                                              );
                                            } else if (controller
                                                .When_Repeating_Same_inserted_Items_in_Invoice ==
                                                '3' &&
                                                controller.COUNT_MINO > 0) {
                                              Get.defaultDialog(
                                                title: 'StringMestitle'.tr,
                                                middleText: 'StringErr_COUNT_MINO'
                                                    .tr,
                                                backgroundColor: Colors.white,
                                                radius: 40,
                                                textCancel: 'StringOK'.tr,
                                                cancelTextColor: Colors
                                                    .blueAccent,
                                                barrierDismissible: false,
                                              );
                                            } else {
                                              if (BMKID != 1 && BMKID != 2  && controller
                                                  .When_Selling_Items_Lower_Price_than_Cost_Price ==
                                                  '1' &&
                                                  double.parse(
                                                      controller.MPCOController
                                                          .text) > 0 &&
                                                  double.parse(
                                                      controller.MPCOController
                                                          .text) > BMDAM1!) {
                                                Get.defaultDialog(
                                                  title: 'StringMestitle'.tr,
                                                  middleText: 'StringItems_Lower_Price'
                                                      .tr,
                                                  backgroundColor: Colors.white,
                                                  radius: 40,
                                                  textCancel: 'StringNo'.tr,
                                                  cancelTextColor: Colors.red,
                                                  textConfirm: 'StringYes'.tr,
                                                  confirmTextColor: Colors.white,
                                                  onConfirm: () async {
                                                    if (BMKID != 1 && BMKID != 2 &&
                                                        Use_lowest_selling_price ==
                                                            '1' &&
                                                        MPLP! > 0 &&
                                                        BMDAM1! < MPLP!) {
                                                      Navigator.of(context)
                                                          .pop(false);
                                                      Get.defaultDialog(
                                                        title: 'StringMestitle'
                                                            .tr,
                                                        middleText:
                                                        'StringUse_lowest_selling_price'
                                                            .tr,
                                                        backgroundColor: Colors
                                                            .white,
                                                        radius: 40,
                                                        textCancel: 'StringOK'.tr,
                                                        cancelTextColor:
                                                        Colors.blueAccent,
                                                        barrierDismissible: false,
                                                      );
                                                    } else if (BMKID != 1 && BMKID != 2 &&
                                                        Use_lowest_selling_price ==
                                                            '3' &&
                                                        Allow_lowest_selling_price !=
                                                            1 &&
                                                        MPLP! > 0 &&
                                                        BMDAM1! < MPLP!) {
                                                      Navigator.of(context)
                                                          .pop(false);
                                                      Get.defaultDialog(
                                                        title: 'StringMestitle'
                                                            .tr,
                                                        middleText:
                                                        'StringUse_lowest_selling_price'
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
                                                      if (BMKID != 1 && BMKID != 2 &&
                                                          Use_highest_selling_price ==
                                                              '1' &&
                                                          MPHP! > 0 &&
                                                          BMDAM1! > MPHP!) {
                                                        Navigator.of(context)
                                                            .pop(false);
                                                        Get.defaultDialog(
                                                          title: 'StringMestitle'
                                                              .tr,
                                                          middleText:
                                                          'StringUse_highest_selling_price'
                                                              .tr,
                                                          backgroundColor:
                                                          Colors.white,
                                                          radius: 40,
                                                          textCancel: 'StringOK'
                                                              .tr,
                                                          cancelTextColor:
                                                          Colors.blueAccent,
                                                          barrierDismissible: false,
                                                        );
                                                      } else if (BMKID != 1 && BMKID != 2 &&
                                                          Use_highest_selling_price ==
                                                              '3' &&
                                                          Allow_highest_selling_price !=
                                                              1 &&
                                                          MPHP! > 0 &&
                                                          BMDAM1! > MPHP!) {
                                                        Navigator.of(context)
                                                            .pop(false);
                                                        Get.defaultDialog(
                                                          title: 'StringMestitle'
                                                              .tr,
                                                          middleText:
                                                          'StringUse_highest_selling_price'
                                                              .tr,
                                                          backgroundColor:
                                                          Colors.white,
                                                          radius: 40,
                                                          textCancel: 'StringOK'
                                                              .tr,
                                                          cancelTextColor:
                                                          Colors.blueAccent,
                                                          barrierDismissible: false,
                                                        );
                                                      } else {
                                                        Navigator.of(context).pop(
                                                            false);
                                                        bool isValid = await controller
                                                            .Save_BIL_MOV_D_P();
                                                        if (isValid) {
                                                          DataGrid();
                                                          controller
                                                              .ClearBil_Mov_D_Data();
                                                        }
                                                      }
                                                    }
                                                  },
                                                  barrierDismissible: false,
                                                );
                                              } else if (BMKID != 1 && BMKID != 2 &&
                                                  controller
                                                      .When_Selling_Items_Lower_Price_than_Cost_Price ==
                                                      '2' &&
                                                  double.parse(controller
                                                      .MPCOController.text) >
                                                      0 &&
                                                  double.parse(controller
                                                      .MPCOController.text) >
                                                      BMDAM1!) {
                                                Get.defaultDialog(
                                                  title: 'StringMestitle'.tr,
                                                  middleText:
                                                  'StringErr_Items_Lower_Price'
                                                      .tr,
                                                  backgroundColor: Colors.white,
                                                  radius: 40,
                                                  textCancel: 'StringOK'.tr,
                                                  cancelTextColor: Colors
                                                      .blueAccent,
                                                  barrierDismissible: false,
                                                );
                                              } else if (BMKID != 1 && BMKID != 2 &&
                                                  controller
                                                      .When_Selling_Items_Lower_Price_than_Cost_Price ==
                                                      '4' &&
                                                  controller
                                                      .Allowto_Sell_Less_than_Cost_Price !=
                                                      1 &&
                                                  double.parse(
                                                      controller.MPCOController
                                                          .text) > 0 &&
                                                  double.parse(
                                                      controller.MPCOController
                                                          .text) > BMDAM1!) {
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
                                                if (BMKID != 1 && BMKID != 2 &&
                                                    Use_lowest_selling_price ==
                                                        '1' && MPLP! > 0 &&
                                                    BMDAM1! < MPLP!) {
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
                                                } else if (BMKID != 1 && BMKID != 2 &&
                                                    Use_lowest_selling_price == '3' &&
                                                    Allow_lowest_selling_price != 1 &&
                                                    MPLP! > 0 && BMDAM1! < MPLP!) {
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
                                                  if (BMKID != 1 && BMKID != 2 &&
                                                      Use_highest_selling_price == '1' &&
                                                      MPHP! > 0 && BMDAM1! > MPHP!) {
                                                    Get.defaultDialog(
                                                      title: 'StringMestitle'.tr,
                                                      middleText: 'StringUse_highest_selling_price'.tr,
                                                      backgroundColor: Colors.white,
                                                      radius: 40,
                                                      textCancel: 'StringOK'.tr,
                                                      cancelTextColor: Colors.blueAccent,
                                                      barrierDismissible: false,
                                                    );
                                                  } else if (BMKID != 1 && BMKID != 2 &&
                                                      Use_highest_selling_price == '3' &&
                                                      Allow_highest_selling_price != 1 &&
                                                      MPHP! > 0 && BMDAM1! > MPHP!) {
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
                                                    bool isValid = await controller
                                                        .Save_BIL_MOV_D_P();
                                                    if (isValid) {
                                                      DataGrid();
                                                      controller
                                                          .ClearBil_Mov_D_Data();
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
        ? autoCompleteData.where((county) =>
        "${county.MGNO ?? ''}${county.MINA_D ?? ''}${county.MINO ?? ''}${county.MUNA_D ?? ''}${county.MUCBC ?? ''}${county.MPS1 ?? ''}${county.MPS2 ?? ''}"
            .toLowerCase()
            .contains(query.toLowerCase()))
        .toList().obs
        : autoCompleteData.where((county) =>
        "${county.MINA_D ?? ''}${county.MINO ?? ''}"
            .toLowerCase()
            .contains(query.toLowerCase())).toList().obs;
  }


  Widget _buildTextField(BuildContext context,
      TextEditingController textEditingController, FocusNode focusNode) {
    final isEmpty = MINAController.text.isEmpty;
    return TextFormField(
      controller: isEmpty ? textEditingController : MINAController,
      focusNode: focusNode,
      autofocus: isEmpty,
      validator: (value) => validateMINO(value!),
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
    ClearBil_Mov_D_Data();
    focusNode.requestFocus();
    update();
  }

  void _showDetailsDialog(BuildContext context) {
    if (SelectDataMUID?.isNotEmpty ?? false) {
      Get.defaultDialog(
        title: '${MINAController.text}. ${SelectDataMUCNA}',
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
      if (UPIN_PRI == 1) 'StringCost_Price',
      'String_MPHP',
      'String_MPLP',
    ];
    final values = [
      MGNA,
      formatter.format(BDNO_F),
      formatter.format(BDNO_F2),
      formatter.format(double.parse(SCEXController.text)),
      formatter.format(SCEXS),
      if (UPIN_PRI == 1) formatter.format(MPCO),
      formatter.format(MPHP),
      formatter.format(MPLP),
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
    print('controller.SelectDataMINO');
    print(SelectDataMINO);
    SelectDataMINO = selection.MINO.toString();
    MGNOController.text = selection.MGNO.toString();
    SelectDataMUID = null;
    SelectDataSNED = null;
    MITSK = selection.MITSK;
    MGKI = selection.MGKI;
    GUIDMT = selection.GUID;
    update();
    if (StteingController().SHOW_ITEM == true ||
        StteingController().SHOW_ITEM_C == true) {
      SelectDataMUID = selection.MUID.toString();
      SIID_V2 = SelectDataSIID.toString();
      await GETSNDE_ONE();
      if(BMKID==1){
        BMDAMController.text ='0';
      }else{
        BMDAMController.text = BCPR == 2 ? selection.MPS2.toString() : BCPR == 3 ?
        selection.MPS3.toString() : BCPR == 4
            ? selection.MPS4.toString()
            : selection.MPS1.toString();
      }
      SelectDataMUCNA = selection.MUNA_D.toString();
      MPS1 = double.parse(BMDAMController.text);
    } else {
      await GETMUIDS();
    }
    MINAController.text = selection.MINA_D.toString();
    MIED = selection.MIED;
    BMDNOController.text = '';
    BMDNO_V = 0;
    BMDNFController.text = '0';
    SUMBMDAMController.text = '0';
    BMDDIRController.text = '0';
    BMDDIController.text = '0';
    if (TTID1 != null) {
      await GET_TAX_LIN_P('MAT', selection.MGNO.toString(),
          selection.MINO.toString());
    }
    update();
    myFocusNode.requestFocus();
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
                        print('BCPR');
                        print(BCPR);
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
                                    "${option.MGNO} - (${option.MINO}-${option
                                        .MINA_D})",
                                    style: TextStyle(color: Colors.black),
                                  ),
                                  SizedBox(height: 5),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment
                                        .spaceAround,
                                    children: [
                                      Text(
                                        "${'StringMUID'.tr}: ${option
                                            .MUNA_D}", // استبدل `unit` بالمفتاح الصحيح للوحدة

                                      ),
                                      Text(
                                        "${'StringPrice'.tr}: ${formatter
                                            .format(
                                            BCPR == 2 ? option.MPS2 : BCPR == 3
                                                ? option.MPS3
                                                : BCPR == 4
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
                                    child: Text("${formatter.format(
                                        BCPR == 2 ? option.MPS2 : BCPR == 3 ? option.MPS3
                                            : BCPR == 4 ? option.MPS4 : option.MPS1).toString()}",
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
                      ClearBil_Mov_D_Data();
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
            MGNOController.text.toString(), SelectDataMINO.toString()),
        builder: (BuildContext context,
            AsyncSnapshot<List<Mat_Uni_C_Local>> snapshot) {
          if (!snapshot.hasData) {
            return Dropdown2(josnStatus: josnStatus);
          }
          return DropdownButtonFormField2(
            isExpanded: true,
            hint: ThemeHelper().buildText(
                context, 'StringMUID', Colors.grey, 'S'),
            value: SelectDataMUID,
            style: ThemeHelper().buildTextStyle(context, Colors.black, 'M'),
            items: snapshot.data!
                .map((item) =>
                DropdownMenuItem<String>(
                  onTap: () {
                    SelectDataMUCNA = item.MUNA_D.toString();
                    update();
                  },
                  value: item.MUID.toString(),
                  child: Text(
                    '${item.MUNA_D.toString()}   ',
                    style: ThemeHelper().buildTextStyle(
                        context, Colors.black, 'M'),
                  ),
                ))
                .toList()
                .obs,
            validator: (value) {
              if (value == null) {
                return 'StringvalidateMUID'.tr;
              }
              return null;
            },
            onChanged: (value) async {
              SelectDataMUID = value.toString();
              SelectDataSNED = null;
              SelectDataMUCNA = null;
              SelectDataMUCNA = '';
              BMDAMController.clear();
              BMDINController.clear();
              BMDEDController.clear();
              SUMBMDAMController.clear();
              MPCOController.clear();
              MPCO_VController.clear();
              BMDTXAController.clear();
              BMDAMController.text = '0';
              BMDAMTXController.text = '0';
              SUMBMDAMController.text = '0';
              BMDTXAController.text = '0';
              MPCOController.text = '0';
              MPCO_VController.text = '0';
              SUMBMDAMTController.text = '0';
              SUMBMDAM = 0;
              SUM_BMDAM = 0;
              BMDAM1 = 0;
              SUM_BMDAM2 = 0;
              BMDAM2 = 0;
              MPS1 = 0;
              BDNO_F = 0;
              BDNO_F2 = 0;
              BMDTXTController.text = '0';
              SUMBMDAMTFController.text = '0';
              MPS1Controller.text = '0';
              MPS2Controller.text = '0';
              MPS3Controller.text = '0';
              MPS4Controller.text = '0';
              CHIN_NO = 1;
              MPCO_V = 0;
              MPCO = 0;
              BMDNO = 0;
              V_FROM = 0;
              V_TO = 0;
              V_KIN = 0;
              V_N1 = 0;
              update();
              await GETSNDE_ONE();
              myFocusNode.requestFocus();
              Timer(const Duration(seconds: 1), () async {
                await Calculate_BMD_NO_AM();
                update();
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

  Future<dynamic> buildShowMPS1(BuildContext context) {
    double height = MediaQuery
        .of(context)
        .size
        .height;
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
                    controller: MPS1Controller,
                    onTap: () async {
                      BMDAMController.text = MPS1Controller.text;
                      MPS1 = double.parse(MPS1Controller.text);
                      Navigator.of(context).pop(false);
                      await Future.delayed(const Duration(milliseconds: 600));
                      Calculate_BMD_NO_AM();
                      update();
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
                    controller: MPS2Controller,
                    onTap: () async {
                      BMDAMController.text = MPS2Controller.text;
                      MPS1 = double.parse(MPS2Controller.text);
                      Navigator.of(context).pop(false);
                      await Future.delayed(const Duration(milliseconds: 600));
                      Calculate_BMD_NO_AM();
                      update();
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
                    controller: MPS3Controller,
                    onTap: () async {
                      BMDAMController.text = MPS3Controller.text;
                      MPS1 = double.parse(MPS3Controller.text);
                      Navigator.of(context).pop(false);
                      await Future.delayed(const Duration(milliseconds: 600));
                      Calculate_BMD_NO_AM();
                      update();
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
                    controller: MPS4Controller,
                    onTap: () async {
                      BMDAMController.text = MPS4Controller.text;
                      MPS1 = double.parse(MPS4Controller.text);
                      Navigator.of(context).pop(false);
                      await Future.delayed(const Duration(milliseconds: 600));
                      Calculate_BMD_NO_AM();
                      update();
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

  FutureBuilder<List<Bil_Cus_Local>> DropdownBIL_CUSBuilder() {
    return FutureBuilder<List<Bil_Cus_Local>>(
      future: GET_BIL_CUS(),
      builder: (BuildContext context, AsyncSnapshot<List<Bil_Cus_Local>> snapshot) {
        double height = MediaQuery.of(context).size.height;
        // حالة التحميل
        if (!snapshot.hasData) {
          return Dropdown(
            josnStatus: josnStatus,
            GETSTRING: 'StringBCID',
          );
        }
        // Dropdown الرئيسي
        return IgnorePointer(
          ignoring: _isIgnoringDropdown(),
          child: DropdownButtonFormField2(
            decoration: _buildInputDecoration(context, height),
            isDense: true,
            isExpanded: true,
            hint: ThemeHelper().buildText(context, 'StringBCID', Colors.grey, 'S'),
            iconStyleData: _buildIconStyle(context,snapshot),
            items: _buildDropdownItems(snapshot.data!,context),
            value: SelectDataBCID2,
            onChanged: (value) => _onDropdownChanged(value),
            dropdownStyleData: const DropdownStyleData(maxHeight: 300),
            dropdownSearchData: _buildSearchData(context),
            onMenuStateChange: (isOpen) {
              if (!isOpen) TextEditingSercheController.clear();
            },
          ),
        );
      },
    );
  }

// دالة للتحقق من حالة الـ IgnorePointer
  bool _isIgnoringDropdown() {
    if (edit == true && (BMKID == 12 || BMKID == 4)) {
      return true;
    }

    if (BMKID == 4 && LoginController().Return_Type == '2') {
      return true;
    }

    return false;
  }


  bool _isIgnoringDropdown_IMP() {
    if (edit == true && BMKID == 2) {
      return true;
    }
    if (BMKID == 2 && LoginController().Return_Type == '2') {
      return true;
    }

    return false;
  }

// دالة لإنشاء InputDecoration
  InputDecoration _buildInputDecoration(BuildContext context, double height) {
    return InputDecoration(
      isDense: true,
      contentPadding: const EdgeInsets.symmetric(vertical: 13, horizontal: 8),
      labelText: "${'StringBCID'.tr}  ${'StringCUS_BAL'.tr} ${formatter.format(BACBA).toString()} ",
      labelStyle: const TextStyle(color: Colors.black54),
      border: OutlineInputBorder(borderRadius: BorderRadius.circular(0.015 * height)),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(0.015 * height),
        borderSide: BorderSide(color: Colors.grey.shade400),
      ),
      prefixIconColor: Colors.black45,
      suffixIconColor: Colors.black45,
      prefixIcon:_isIgnoringDropdown()?null: _buildPrefixIcon(context),
      suffixIcon:_isIgnoringDropdown()?null:
      LoginController().Return_Type == '2'? null:_buildSuffixIcon(),
    );
  }

// دالة لإنشاء أيقونة البداية
  Widget _buildPrefixIcon(BuildContext context) {
    return IconButton(
      icon: const Icon(Icons.group_add, size: 23),
      onPressed: () {
        if (UPINCUS == 1) {
          Get.to(() => Add_Ed_Customer(), arguments: 1);
        } else {
          Get.snackbar(
            'StringUPIN'.tr,
            'String_CHK_UPIN'.tr,
            backgroundColor: Colors.red,
            icon: const Icon(Icons.error, color: Colors.white),
            colorText: Colors.white,
            isDismissible: true,
            dismissDirection: DismissDirection.horizontal,
            forwardAnimationCurve: Curves.easeOutBack,
          );
        }
      },
    );
  }

// دالة لإنشاء أيقونة النهاية
  Widget _buildSuffixIcon() {
    return  IconButton(
      icon: const Icon(Icons.cancel, size: 23),
      onPressed: () {
        SelectDataBCID = null;
        SelectDataBCID2 = null;
        BACBA = 0;
        if (int.parse(CountRecodeController.text) == 0) {
          //  BCPR = BPPR;
          GET_MAT_INF_DATE(
            SelectDataMGNO.toString(),
            SelectDataSCID.toString(),
            SelectDataBIID.toString(),
            BCPR!,
          );
        }
        update();
      },
    );
  }

  IconStyleData _buildIconStyle(BuildContext context,snapshot) {
    return IconStyleData(
      icon: SelectDataBCID == null
          ? snapshot.connectionState == ConnectionState.waiting
          ? const SizedBox(
        width: 24,
        height: 24,
        child: CircularProgressIndicator(
          strokeWidth: 2,
          color: Colors.black45,
        ),
      )
          :const Icon(
        Icons.arrow_drop_down,
        color: Colors.black45,
      )
          : InkWell(
        onTap: () {
          buildShowBIL_ACC_C(context);
        },
        child: const Icon(
          Icons.error_outline,
          color: Colors.black45,
          // يمكن التحكم بحجم الأيقونة هنا
        ),
      ),
    );
  }

// دالة لإنشاء العناصر في Dropdown
  List<DropdownMenuItem<String>> _buildDropdownItems(List<Bil_Cus_Local> data,context) {
    return data.map(
          (item) => DropdownMenuItem<String>(
        onTap: () => _onItemTap(item),
        value: "${item.BCID.toString()} +++ ${item.BCNA_D.toString()}",
        child: Text(
          "${item.BCID.toString()} - ${item.BCNA_D.toString()}",
          style: ThemeHelper().buildTextStyle(context, Colors.black, 'M'),
        ),
      ),
    ).toList();
  }

// دالة للبحث في Dropdown
  DropdownSearchData _buildSearchData(context) {
    return DropdownSearchData(
      searchController: TextEditingSercheController,
      searchInnerWidget: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 8),
        child: TextFormField(
          controller: TextEditingSercheController,
          decoration: InputDecoration(
            isDense: true,
            suffixIcon: IconButton(
              icon: const Icon(Icons.clear, size: 20),
              onPressed: () {
                TextEditingSercheController.clear();
                update();
              },
            ),
            contentPadding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
            hintText: 'StringSearch_for_BCID'.tr,
            hintStyle: ThemeHelper().buildTextStyle(context, Colors.grey, 'S'),
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
          ),
        ),
      ),
      searchMatchFn: (DropdownMenuItem item, searchValue) {
        return (item.value.toString().toLowerCase().contains(searchValue.toLowerCase()));
      },
      searchInnerWidgetHeight: 50,
    );
  }

// عند تغيير قيمة Dropdown
  void _onDropdownChanged(String? value) {
    print(value);
    SelectDataBCID2 = value.toString();
    SelectDataBCID = value.toString().split(" +++ ")[0];
    update();
    print('SelectDataBCID');
    print(SelectDataBCID);
  }

// عند اختيار عنصر
  Future<void> _onItemTap(Bil_Cus_Local item) async {
    BCNAController.text = item.BCNA.toString();
    AANOController.text = item.AANO.toString();
    GUIDC = item.GUID.toString();
    BCMOController.text = item.BCMO.toString();
    BIIDB = item.BIID;
    PKID_C = item.PKID;
    BCCT = item.BCCT;
    SCID_C = item.SCID;
    BCBL = item.BCBL;
    BCPR = item.BCPR;
    BCAD_D = item.BCAD.toString();
    BCLON = item.BCLON.toString() == 'null' ? '0' : item.BCLON.toString();
    BCLAT = item.BCLAT.toString() == 'null' ? '0' : item.BCLAT.toString();
    SelectDataBCID3 = "${item.BCID.toString()} +++ ${item.BCNA.toString()}";
    await GET_BAL_P(BMMID,AANOController.text,SelectDataSCID.toString());
    await GET_BIL_ACC_C_P(AANOController.text,GUIDC,SelectDataBIID.toString(),
        SelectDataSCID.toString(),PKID.toString(),GETBMMID: BMMID.toString());
    await GET_TAX_LIN_CUS_IMP_P('CUS', item.AANO.toString(), item.BCID.toString());
    await GET_ECO_ACC_P(item.AANO.toString());
    STMID == 'MOB' ?  await calculateDistanceBetweenLocations() : null;
    print('BCPR');
    print(BCPR);
    if(StteingController().ALR_CUS_DEBT_SAL==true && [3,5,11].contains(BMKID) && BACBA!>0){
      Get.snackbar('StringCUS_DEBT'.tr, "${'StringCUS_UNPAID_DEBT'.tr}       $BACBA",
          backgroundColor: Colors.red,
          icon: Icon(Icons.warning, color: Colors.white),
          colorText: Colors.white,
          isDismissible: true,
          dismissDirection: DismissDirection.horizontal,
          animationDuration: Duration(seconds: 1),
          forwardAnimationCurve: Curves.easeOutBack);
    }
    update();
  }

  FutureBuilder<List<Bif_Cus_D_Local>> DropdownBIF_CUS_DBuilder() {
    return FutureBuilder<List<Bif_Cus_D_Local>>(
        future: GET_BIF_CUS_D(),
        builder: (BuildContext context,
            AsyncSnapshot<List<Bif_Cus_D_Local>> snapshot) {
          double height = MediaQuery.of(context).size.height;
          if (!snapshot.hasData) {
            return Dropdown(
              josnStatus: josnStatus,
              GETSTRING: 'StringBCID',
            );
          }
          return DropdownButtonFormField2(
            decoration: InputDecoration(
              isDense: true,
              contentPadding: const EdgeInsets.symmetric(
                  vertical: 13, horizontal: 8),
              labelText: "${'StringBCID'.tr}",
              labelStyle: const TextStyle(color: Colors.black54),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(0.015 * height),
              ),
              focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(0.015 * height),
                  borderSide: BorderSide(color: Colors.grey.shade400)),
              prefixIconColor: Colors.black45,
              suffixIconColor: Colors.black45,
              prefixIcon: IconButton(
                icon: const Icon(Icons.error, color: Colors.black,),
                onPressed: () {
                  print('controller.SelectDataCWID');
                  print(SelectDataCWID);
                  if (BCDID.toString() != 'null') {
                    Get.defaultDialog(
                      title: '${BCDNAController.text}',
                      backgroundColor: Colors.white,
                      radius: 30,
                      content: Column(children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Text(
                              "${'StringBCDMO'.tr}:",
                              style: ThemeHelper().buildTextStyle(
                                  context, Colors.black87, 'M'),
                            ),
                            SizedBox(width: 0.01 * height),
                            Text(
                                BCDMOController.text,
                                style: ThemeHelper().buildTextStyle(
                                    context, Colors.black, 'M')
                            ),
                          ],
                        ),
                        SelectDataCWID != 'null' ?
                        SizedBox(height: 0.02 * height) :
                        Container(),
                        SelectDataCWID != 'null' || SelectDataCWID != null
                            ? Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Text(
                                "${'StringCountry'.tr}:",
                                style: ThemeHelper().buildTextStyle(
                                    context, Colors.black87, 'M')),
                            SizedBox(width: 0.01 * height),
                            Text(CWNA.toString(),
                                style: ThemeHelper().buildTextStyle(
                                    context, Colors.black, 'M')
                            ),
                          ],
                        )
                            :
                        Container(),
                        SelectDataCWID != 'null' ? SizedBox(height: 0.02 *
                            height) :
                        Container(),
                        SelectDataCTID != 'null' || SelectDataCTID != null
                            ? Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Text(
                                "${'StringCity'.tr}:",
                                style: ThemeHelper().buildTextStyle(
                                    context, Colors.black87, 'M')
                            ),
                            SizedBox(width: 0.01 * height),
                            Text(CTNA.toString(),
                                style: ThemeHelper().buildTextStyle(
                                    context, Colors.black, 'M')
                            ),
                          ],
                        )
                            :
                        Container(),
                        BCDADController.text.isEmpty ||
                            BCDADController.text == 'null' ? Container() :
                        SizedBox(height: 0.02 * height),
                        BCDADController.text.isEmpty ||
                            BCDADController.text == 'null' ? Container() :
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Text(
                                "${'StringAddress'.tr}:",
                                style: ThemeHelper().buildTextStyle(
                                    context, Colors.black87, 'M')),
                            SizedBox(width: 0.01 * height),
                            Text(BCDADController.text,
                                style: ThemeHelper().buildTextStyle(
                                    context, Colors.black, 'M')
                            ),
                          ],
                        ),
                        BCDSNController.text.isEmpty ||
                            BCDSNController.text == 'null' ? Container() :
                        SizedBox(height: 0.02 * height),
                        BCDSNController.text.isEmpty ||
                            BCDSNController.text == 'null' ? Container() :
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Text(
                                "${'StringStreetNo'.tr}:",
                                style: ThemeHelper().buildTextStyle(
                                    context, Colors.black87, 'M')),
                            SizedBox(width: 0.01 * height),
                            Text(BCDSNController.text,
                                style: ThemeHelper().buildTextStyle(
                                    context, Colors.black, 'M')
                            ),
                          ],
                        ),
                        BCDBNController.text.isEmpty ||
                            BCDBNController.text == 'null' ? Container() :
                        SizedBox(height: 0.02 * height),
                        BCDBNController.text.isEmpty ||
                            BCDBNController.text == 'null' ? Container() :
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Text("${'StringBuildingNo'.tr}:",
                              style: ThemeHelper().buildTextStyle(
                                  context, Colors.black87, 'M'),
                            ),
                            SizedBox(width: 0.01 * height),
                            Text(BCDBNController.text,
                                style: ThemeHelper().buildTextStyle(
                                    context, Colors.black, 'M')
                            ),
                          ],
                        ),
                        BCDFNController.text.isEmpty ||
                            BCDFNController.text == 'null' ? Container() :
                        SizedBox(height: 0.02 * height),
                        BCDFNController.text.isEmpty ||
                            BCDFNController.text == 'null' ? Container() :
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Text("${'StringBCDFN'.tr}:",
                                style: ThemeHelper().buildTextStyle(
                                    context, Colors.black87, 'M')
                            ),
                            SizedBox(width: 0.01 * height),
                            Text(BCDFNController.text,
                                style: ThemeHelper().buildTextStyle(
                                    context, Colors.black87, 'M')
                            ),
                          ],
                        ),
                      ]),
                      textCancel: 'StringHide'.tr,
                      cancelTextColor: Colors.blueAccent,
                      // barrierDismissible: false,
                    );
                  }
                },
              ),
              suffixIcon: IconButton(
                icon: const Icon(Icons.clear, color: Colors.black,),
                onPressed: () {
                  BCDNAController.clear();
                  BCDID = null;
                  SelectDataBCDID = null;
                  GUIDC2 = null;
                  BCDMOController.clear();
                  SelectDataCWID = null;
                  SelectDataBAID = null;
                  SelectDataCTID = null;
                  SelectDataCWID2 = null;
                  SelectDataBAID2 = null;
                  SelectDataCTID2 = null;
                  BCDADController.clear();
                  BCDSNController.clear();
                  BCDFNController.clear();
                  BCDBNController.clear();
                  update();
                },
              ),
            ),
            isDense: true,
            isExpanded: true,
            hint: ThemeHelper().buildText(
                context, 'StringBCID', Colors.grey, 'S'),
            iconStyleData: IconStyleData(
              icon: SelectDataBCID == null ? const Icon(
                Icons.arrow_drop_down,
                color: Colors.black45,
              ) : IconButton(icon: Icon(Icons.error_outline), iconSize: 21,
                  onPressed: () {
                    buildShowBIL_ACC_C(context);
                  },
                  padding: EdgeInsets.only(right: 25)),
            ),
            items: snapshot.data!.map((item) =>
                DropdownMenuItem<String>(
                  onTap: () async {
                    print(item.BCDID.toString());
                    print('BCDID');
                    BCDID = item.BCDID.toString();
                    GUIDC2 = item.GUID.toString();
                    BCDNAController.text = item.BCDNA_D.toString();
                    BCDMOController.text = item.BCDMO.toString();
                    SelectDataCWID = item.CWID.toString();
                    SelectDataBAID = item.BAID.toString();
                    SelectDataCTID = item.CTID.toString();
                    GET_BIF_CUS_D_ONE_P(item.GUID.toString());
                  },
                  value: "${item.BCDNA.toString() + " +++ " +
                      item.BCDMO.toString()}",
                  child: Text(
                    "${item.BCDNA.toString() == 'null' ? '' : item.BCDNA
                        .toString()}-${item.BCDMO.toString() == 'null'
                        ? ''
                        : item.BCDMO.toString()}",
                    style: ThemeHelper().buildTextStyle(
                        context, Colors.black, 'M'),
                  ),
                ))
                .toList()
                .obs,
            value: SelectDataBCDID,
            onChanged: (value) {
              SelectDataBCDID = value.toString();
              update();
              print('SelectDataBCID');
              print(BCDID);
              print(SelectDataBCDID);
            },
            dropdownStyleData: const DropdownStyleData(
              maxHeight: 200,
            ),
            dropdownSearchData: DropdownSearchData(
                searchController: TextEditingSercheController,
                searchInnerWidget: Padding(
                  padding: const EdgeInsets.only(
                    top: 8,
                    bottom: 4,
                    right: 8,
                    left: 8,
                  ),
                  child: TextFormField(
                    controller: TextEditingSercheController,
                    decoration: InputDecoration(
                      isDense: true,
                      suffixIcon: IconButton(icon: const Icon(
                        Icons.clear,
                        size: 20,
                      ),
                        onPressed: () {
                          TextEditingSercheController.clear();
                          update();
                        },),
                      contentPadding: const EdgeInsets.symmetric(
                        horizontal: 10,
                        vertical: 8,
                      ),
                      hintText: 'StringSearch_for_BCID'.tr,
                      hintStyle: ThemeHelper().buildTextStyle(
                          context, Colors.grey, 'S'),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                  ),
                ),
                searchMatchFn: (DropdownMenuItem item, searchValue) {
                  // print(controller.TextEditingSercheController.text);
                  return (item.value.toString().toLowerCase().contains(
                      searchValue.toLowerCase()));
                },
                searchInnerWidgetHeight: 50),
            //This to clear the search value when you close the menu
            onMenuStateChange: (isOpen) {
              if (!isOpen) {
                TextEditingSercheController.clear();
              }
            },
          );
        });
  }

  GetBuilder<Sale_Invoices_Controller> DropdownBIL_CRE_CBuilder() {
    return GetBuilder<Sale_Invoices_Controller>(
        init: Sale_Invoices_Controller(),
        builder: ((controller) =>
            FutureBuilder<List<Bil_Cre_C_Local>>(
                future: GET_BIL_CRE_C(controller.SelectDataBIID.toString()),
                builder: (BuildContext context,
                    AsyncSnapshot<List<Bil_Cre_C_Local>> snapshot) {
                  double height = MediaQuery
                      .of(context)
                      .size
                      .height;
                  if (!snapshot.hasData) {
                    return Dropdown(
                      josnStatus: josnStatus,
                      GETSTRING: 'StringBilCrec',
                    );
                  }
                  return DropdownButtonFormField2(
                    decoration: InputDecoration(
                      isDense: true,
                      contentPadding: const EdgeInsets.symmetric(
                          vertical: 13, horizontal: 8),
                      labelText: 'StringCreditCard'.tr,
                      labelStyle: const TextStyle(color: Colors.black54),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(0.015 * height),
                      ),
                      focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(0.015 * height),
                          borderSide: BorderSide(color: Colors.grey.shade400)),
                    ),
                    isDense: true,
                    isExpanded: true,
                    hint: ThemeHelper().buildText(
                        context, 'StringCreditCard', Colors.grey, 'S'),
                    items: snapshot.data!.map((item) =>
                        DropdownMenuItem<String>(
                          onTap: () {
                            print('BCCPK');
                            print(item.BCCPK);
                            print(controller.SelectDataBCCID);
                            print(item.BCCID.toString());
                            if (item.BCCPK == 1) {
                              if (int.parse(CountRecodeController.text) == 0) {
                                BCPR = item.BCCSP;
                                BCCSP = item.BCCSP;
                                GET_MAT_INF_DATE(SelectDataMGNO.toString(),
                                    SelectDataSCID.toString(),
                                    SelectDataBIID.toString(), BCCSP!);
                              }
                            }
                          },
                          value: item.BCCID.toString(),
                          child: Text("${item.BCCID.toString()} - ${item.BCCNA_D
                              .toString()}",
                            style: ThemeHelper().buildTextStyle(
                                context, Colors.black, 'M'),),
                        ))
                        .toList()
                        .obs,
                    value: controller.SelectDataBCCID,
                    onChanged: (value) {
                      controller.SelectDataBCCID = value as String;
                      controller.update();
                    },
                    dropdownStyleData: const DropdownStyleData(
                      maxHeight: 200,
                    ),
                  );
                })));
  }

  GetBuilder<Sale_Invoices_Controller> DropdownBIL_DISBuilder() {
    return GetBuilder<Sale_Invoices_Controller>(
        init: Sale_Invoices_Controller(),
        builder: ((controller) =>
            FutureBuilder<List<Bil_Dis_Local>>(
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
                    decoration: ThemeHelper().InputDecorationDropDown(
                        'StringCollector'.tr),
                    isDense: true,
                    isExpanded: true,
                    hint: ThemeHelper().buildText(
                        context, 'StringCollector', Colors.grey, 'S'),
                    items: snapshot.data!
                        .map((item) =>
                        DropdownMenuItem<String>(
                          onTap: () {
                            controller.SelectDataBDID = item.BDID.toString();
                            controller.update();
                          },
                          value: item.BDNA.toString(),
                          child: Text(
                            "${item.BDID.toString()} - ${item.BDNA.toString()}",
                            style: ThemeHelper().buildTextStyle(
                                context, Colors.black, 'M'),
                          ),
                        ))
                        .toList()
                        .obs,
                    value: controller.SelectDataBDID2,
                    onChanged: (value) {
                      controller.SelectDataBDID2 = value.toString();
                      controller.update();
                    },
                    dropdownStyleData: const DropdownStyleData(
                      maxHeight: 250,
                    ),
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
                              suffixIcon: IconButton(icon: const Icon(
                                Icons.clear,
                                size: 20,
                              ),
                                onPressed: () {
                                  controller.TextEditingSercheController
                                      .clear();
                                  controller.update();
                                },),
                              contentPadding: const EdgeInsets.symmetric(
                                horizontal: 10,
                                vertical: 8,
                              ),
                              hintText: 'StringSearch_for_BDID'.tr,
                              hintStyle: ThemeHelper().buildTextStyle(
                                  context, Colors.grey, 'S'),
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

  GetBuilder<Sale_Invoices_Controller> DropdownBIL_DIS_ORDBuilder() {
    return GetBuilder<Sale_Invoices_Controller>(
        init: Sale_Invoices_Controller(),
        builder: ((controller) =>
            FutureBuilder<List<Bil_Dis_Local>>(
                future: GET_BIL_DIS(controller.SelectDataBIID.toString()),
                builder: (BuildContext context,
                    AsyncSnapshot<List<Bil_Dis_Local>> snapshot) {
                  double height = MediaQuery
                      .of(context)
                      .size
                      .height;
                  if (!snapshot.hasData) {
                    return Dropdown(
                      josnStatus: josnStatus,
                      GETSTRING: 'StringCollector_Ord'.tr,
                    );
                  }
                  return DropdownButtonFormField2(
                    decoration: InputDecoration(
                      isDense: true,
                      contentPadding: const EdgeInsets.symmetric(
                          vertical: 13, horizontal: 8),
                      labelText: 'StringCollector_Ord'.tr,
                      labelStyle: TextStyle(color: Colors.grey.shade800),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(0.015 * height),
                      ),
                      focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(0.015 * height),
                          borderSide: BorderSide(color: Colors.grey.shade400)),
                    ),
                    isDense: true,
                    isExpanded: true,
                    hint: ThemeHelper().buildText(
                        context, 'StringCollector_Ord', Colors.grey, 'S'),
                    items: snapshot.data!
                        .map((item) =>
                        DropdownMenuItem<String>(
                          onTap: () {
                            controller.SelectDataBDID_ORD =
                                item.BDID.toString();
                            controller.update();
                          },
                          value: item.BDNA.toString(),
                          child: Text(
                            item.BDNA.toString(),
                            style: ThemeHelper().buildTextStyle(
                                context, Colors.black, 'S'),
                          ),
                        ))
                        .toList()
                        .obs,
                    value: controller.SelectDataBDID2_ORD,
                    onChanged: (value) {
                      controller.SelectDataBDID2_ORD = value.toString();
                      controller.update();
                    },
                    dropdownStyleData: const DropdownStyleData(
                      maxHeight: 250,
                    ),
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
                              suffixIcon: IconButton(icon: const Icon(
                                Icons.clear,
                                size: 20,
                              ),
                                onPressed: () {
                                  controller.TextEditingSercheController
                                      .clear();
                                  controller.update();
                                },),
                              contentPadding: const EdgeInsets.symmetric(
                                horizontal: 10,
                                vertical: 8,
                              ),
                              hintText: 'StringSearch_for_BDID'.tr,
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

  final List<Map> items_ACCOUNTING_EFFECT = [
    {"id": '1', "name": 'StringBMMBR1'.tr},
    {"id": '2', "name": 'StringBMMBR2'.tr}
  ].obs;

  GetBuilder<Sale_Invoices_Controller> DropdownBra_InfBuilder() {
    return GetBuilder<Sale_Invoices_Controller>(
        init: Sale_Invoices_Controller(),
        builder: ((controller) =>
            FutureBuilder<List<Bra_Inf_Local>>(
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
                      ignoring: controller.edit == true ||
                          controller.BMKID == 11
                          || controller.BMKID == 12
                          ? true
                          : controller.CheckBack == 1
                          ? true
                          : false,
                      child: DropdownButtonFormField2(
                        decoration: ThemeHelper().InputDecorationDropDown(
                            'StringBIIDlableText'.tr),
                        isExpanded: true,
                        hint: ThemeHelper().buildText(
                            context, 'StringBrach', Colors.grey, 'S'),
                        value: controller.SelectDataBIID,
                        style: ThemeHelper().buildTextStyle(
                            context, Colors.black, 'M'),
                        items: snapshot.data!.map((item) =>
                            DropdownMenuItem<String>(
                              value: item.BIID.toString(),
                              child: Text("${item.BIID.toString()} - ${item
                                  .BINA_D.toString()}",
                                style: ThemeHelper().buildTextStyle(context,
                                    Colors.black, 'M'),
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
                          controller.SelectDataBIID = value.toString();
                          controller.SelectDataSIID = null;
                          controller.SelectDataACID = null;
                          controller.SelectDataABID = null;
                          controller.SelectDataBCCID = null;
                          controller.update();
                        },
                      ));
                })));
  }

  GetBuilder<Sale_Invoices_Controller> DropdownSto_InfBuilder() {
    return GetBuilder<Sale_Invoices_Controller>(
        init: Sale_Invoices_Controller(),
        builder: ((controller) =>
            FutureBuilder<List<Sto_Inf_Local>>(
                future: Get_STO_INF(
                    controller.BMKID!, controller.SelectDataBIID.toString(),
                    controller.SelectDataBPID.toString()),
                builder: (BuildContext context,
                    AsyncSnapshot<List<Sto_Inf_Local>> snapshot) {
                  if (!snapshot.hasData || snapshot.data!.isEmpty) {
                    return Dropdown(
                      josnStatus: josnStatus,
                      GETSTRING: 'StringStoch',
                    );
                  } else if (snapshot.hasError) {
                    return Dropdown(
                      josnStatus: josnStatus,
                      GETSTRING: 'StringStoch',
                    );
                  }
                  return IgnorePointer(
                      ignoring: controller.edit == true ? true : controller
                          .CheckBack == 1 ? true : false,
                      child: DropdownButtonFormField2(
                        decoration: ThemeHelper().InputDecorationDropDown(
                            'StringSIIDlableText'.tr),
                        isExpanded: true,
                        hint: ThemeHelper().buildText(
                            context, 'StringStoch', Colors.grey, 'S'),
                        value: snapshot.data!.any((item) =>
                        item.SIID.toString() == controller.SelectDataSIID)
                            ? controller.SelectDataSIID : null,
                        style: ThemeHelper().buildTextStyle(
                            context, Colors.black, 'M'),
                        items: snapshot.data!.map((item) =>
                            DropdownMenuItem<String>(
                              value: item.SIID.toString(),
                              child: Text(
                                "${item.SIID.toString()} - ${item.SINA_D
                                    .toString()}",
                                style: ThemeHelper().buildTextStyle(context,
                                    Colors.black, 'M'),
                              ),
                            ))
                            .toList()
                            .obs,
                        validator: (value) {
                          if (value == null) {
                            return 'StringStoch'.tr;
                          }
                          return null;
                        },
                        onChanged: (value) {
                          //Do something when changing the item if you want.
                          controller.SelectDataSIID = value.toString();
                          controller.update();
                        },
                        dropdownStyleData: const DropdownStyleData(
                          maxHeight: 400,
                        ),
                      ));
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
                        ))
                        .toList()
                        .obs,
                    validator: (value) {
                      if (value == null) {
                        return 'StringStoch'.tr;
                      }
                      return null;
                    },
                    onChanged: (value) async {
                      //Do something when changing the item if you want.
                      SIID_V2 = value.toString();
                      await GETSNDE_ONE();
                      controller.update();
                    },
                    dropdownStyleData: const DropdownStyleData(
                      maxHeight: 400,
                    ),
                  );
                })));
  }

  GetBuilder<Sale_Invoices_Controller> DropdownBil_PoiBuilder() {
    return GetBuilder<Sale_Invoices_Controller>(
        init: Sale_Invoices_Controller(),
        builder: ((controller) =>
            FutureBuilder<List<Bil_Poi_Local>>(
                future: GET_BIL_POI(controller.SelectDataBIID.toString()),
                builder: (BuildContext context,
                    AsyncSnapshot<List<Bil_Poi_Local>> snapshot) {
                  if (!snapshot.hasData) {
                    return Dropdown(
                      josnStatus: josnStatus,
                      GETSTRING: '',
                    );
                  }
                  return IgnorePointer(
                    ignoring: controller.edit == true ||
                        controller.BMKID == 11 || controller.BMKID == 12
                        ? true
                        : controller.CheckBack == 1
                        ? true
                        : false,
                    child: DropdownButtonFormField2(
                      decoration: ThemeHelper().InputDecorationDropDown(
                          'StringBPIDlableText'.tr),
                      isExpanded: true,
                      hint: ThemeHelper().buildText(
                          context, 'StringBrach', Colors.grey, 'S'),
                      value: controller.SelectDataBPID,
                      style: ThemeHelper().buildTextStyle(
                          context, Colors.black, 'M'),
                      items: snapshot.data!
                          .map((item) =>
                          DropdownMenuItem<String>(
                            onTap: () {
                              controller.PKIDL == item.PKIDL;
                            },
                            value: item.BPID.toString(),
                            child: Text(
                              "${item.BPID.toString()} - ${item.BPNA_D
                                  .toString()}",
                              style: ThemeHelper().buildTextStyle(context,
                                  Colors.black, 'M'),
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
                        controller.SelectDataBPID = value.toString();
                      },
                    ),
                  );
                })));
  }

  GetBuilder<Sale_Invoices_Controller> DropdownACC_COSBuilder() {
    return GetBuilder<Sale_Invoices_Controller>(
        init: Sale_Invoices_Controller(),
        builder: ((controller) =>
            FutureBuilder<List<Acc_Cos_Local>>(
                future: GET_ACC_COS(),
                builder: (BuildContext context,
                    AsyncSnapshot<List<Acc_Cos_Local>> snapshot) {
                  if (!snapshot.hasData) {
                    return Dropdown(
                      josnStatus: josnStatus,
                      GETSTRING: 'StringChi_ACNO',
                    );
                  }
                  return DropdownButtonFormField2(
                    decoration: ThemeHelper().InputDecorationDropDown(
                        'StringACNOlableText'.tr),
                    isExpanded: true,
                    hint: ThemeHelper().buildText(
                        context, 'StringChi_ACNO', Colors.grey, 'S'),
                    value: controller.SelectDataACNO,
                    style: ThemeHelper().buildTextStyle(
                        context, Colors.black, 'M'),
                    items: snapshot.data!.map((item) =>
                        DropdownMenuItem<String>(
                          value: item.ACNO.toString(),
                          child: Text(
                            "${item.ACNO.toString()} - ${item.ACNA_D
                                .toString()}",
                            style: ThemeHelper().buildTextStyle(
                                context, Colors.black, 'M'),
                          ),
                        ))
                        .toList()
                        .obs,
                    onChanged: (value) {
                      controller.SelectDataACNO = value.toString();
                      controller.update();
                    },
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
          return IgnorePointer(
              ignoring: edit == true || BMKID == 11 || BMKID == 12
                  ? true
                  : CheckBack == 1
                  ? true
                  : false,
              child: DropdownButtonFormField2(
                decoration: ThemeHelper().InputDecorationDropDown(
                    "${'StringSCIDlableText'.tr}  ${'Stringexchangerate'
                        .tr} ${SCEXController.text}"),
                isExpanded: true,
                hint: ThemeHelper().buildText(
                    context, 'StringChi_currency', Colors.grey, 'S'),
                iconStyleData: IconStyleData(
                  icon: SelectDataSCID == null || edit == true || CheckBack == 1
                      || BMKID == 11 || BMKID == 12 ? const Icon(
                    Icons.arrow_drop_down,
                    color: Colors.black45,
                  ) : IconButton(icon: Icon(Icons.error_outline), iconSize: 21,
                      onPressed: () {
                        GET_SYS_CUR_DAT_P(SelectDataSCID.toString());
                        buildShowSYS_CUR(context);
                      },
                      padding: EdgeInsets.only(bottom: 12, right: 25)),
                ),
                value: SelectDataSCID,
                style: ThemeHelper().buildTextStyle(context, Colors.black, 'M'),
                items: snapshot.data!.map((item) =>
                    DropdownMenuItem<String>(
                      value: item.SCID.toString(),
                      onTap: () {
                        SCEXController.text = item.SCEX.toString();
                        SCHRController.text = item.SCHR.toString();
                        SCLRController.text = item.SCLR.toString();
                        SCNA = item.SCNA_D.toString();
                        SCSY = item.SCSY!;
                        SCSFL = item.SCSFL!;
                        update();
                      },
                      child: Text(
                        "${item.SCSY.toString()} - ${item.SCNA_D.toString()}",
                        style: ThemeHelper().buildTextStyle(
                            context, Colors.black, 'M'),
                      ),
                    ))
                    .toList()
                    .obs,
                validator: (v) {
                  if (v == null) {
                    return 'StringBrach'.tr;
                  };
                  return null;
                },
                onChanged: (value)  {
                  SelectDataSCID = value.toString();
                  update();
                  GET_BIL_ACC_C_P(AANOController.text, GUIDC, SelectDataBIID.toString(),
                      value.toString(),PKID.toString(),GETBMMID: BMMID.toString());
                  update();
                },
              ));
        });
  }

  GetBuilder<Sale_Invoices_Controller> DropdownPAY_KINBuilder() {
    return GetBuilder<Sale_Invoices_Controller>(
        init: Sale_Invoices_Controller(),
        builder: ((controller) =>
            FutureBuilder<List<Pay_Kin_Local>>(
                future: GET_PAY_KIN(controller.BMKID!,
                    controller.BMKID == 3 || controller.BMKID == 5 ||
                        controller.BMKID == 4 || controller.BMKID == 7 ||
                        controller.BMKID == 10 ? 'BO'
                        : (controller.BMKID == 1 ||  controller.BMKID == 2)
                        ? 'BI'
                        : 'BF',
                    controller.UPIN_PKID, controller.SelectDataBPID.toString()),
                builder: (BuildContext context,
                    AsyncSnapshot<List<Pay_Kin_Local>> snapshot) {
                  if (!snapshot.hasData) {
                    return Dropdown(
                      josnStatus: josnStatus,
                      GETSTRING: 'StringChi_PAY'.tr,
                    );
                  }
                  return DropdownButtonFormField2(
                    decoration: ThemeHelper().InputDecorationDropDown(
                        'StringPKIDlableText'.tr),
                    isExpanded: true,
                    hint: ThemeHelper().buildText(
                        context, 'StringChi_PAY', Colors.grey, 'S'),
                    value: controller.PKID.toString(),
                    style: ThemeHelper().buildTextStyle(
                        context, Colors.black, 'M'),
                    items: snapshot.data!.map((item) =>
                        DropdownMenuItem<String>(
                          onTap: () {
                            controller.PKNA = item.PKNA_D.toString();
                          },
                          value: item.PKID.toString(),
                          child: Text(
                            "${item.PKID.toString()} - ${item.PKNA_D
                                .toString()}",
                            style: ThemeHelper().buildTextStyle(
                                context, Colors.black, 'M'),
                          ),
                        ))
                        .toList()
                        .obs,
                    validator: (v) {
                      if (v == null) {
                        return 'StringBrach'.tr;
                      };
                      return null;
                    },
                    onChanged: (value) {
                      controller.SelectDataPKID = value.toString();
                      controller.PKID = int.parse(value.toString());
                      if (value.toString() == '3') {
                        String DATEBMMCD = '';
                        DATEBMMCD = DateFormat('dd-MM-yyyy')
                            .format(
                            controller.BMMCD.add(const Duration(days: 3)))
                            .toString()
                            .split(" ")[0];
                        controller.BMMCD.add(const Duration(days: 3))
                            .toString();
                        controller.BMMCDController.text =
                            DATEBMMCD.substring(0, 10);
                        controller.update();
                      }
                      // GET_Allow_give_Free_Quantities();
                      // GET_Allow_give_Discount();
                      controller.update();
                    },
                  );
                })));
  }

  GetBuilder<Sale_Invoices_Controller> DropdownACC_CASBuilder() {
    return GetBuilder<Sale_Invoices_Controller>(
        init: Sale_Invoices_Controller(),
        builder: ((controller) =>
            FutureBuilder<List<Acc_Cas_Local>>(
                future: GET_ACC_CAS(controller.SelectDataBIID.toString(),
                    controller.SelectDataSCID.toString(),
                    (controller.BMKID == 1 || controller.BMKID == 2) ? 'BI' : controller.BMKID == 3
                        ? 'BO'
                        : controller.BMKID == 4 ? 'BO' : controller.BMKID == 5
                        ? 'BS'
                        : 'BF', controller.BMKID!),
                builder: (BuildContext context,
                    AsyncSnapshot<List<Acc_Cas_Local>> snapshot) {
                  if (!snapshot.hasData) {
                    return Dropdown(
                      josnStatus: josnStatus,
                      GETSTRING: 'StringCashier',
                    );
                  }
                  return DropdownButtonFormField2(
                    decoration: ThemeHelper().InputDecorationDropDown(
                        'StringCashier'.tr),
                    isDense: true,
                    isExpanded: true,
                    hint: ThemeHelper().buildText(
                        context, 'StringCashier', Colors.grey, 'S'),
                    items: snapshot.data!.map((item) =>
                        DropdownMenuItem<String>(
                          value: item.ACID.toString(),
                          child: Text(
                            "${item.ACID.toString()} - ${item.ACNA_D
                                .toString()}",
                            style: ThemeHelper().buildTextStyle(
                                context, Colors.black, 'M'),
                          ),
                        ))
                        .toList()
                        .obs,
                    value: controller.SelectDataACID,
                    onChanged: (value) {
                      controller.SelectDataACID = value as String;
                      update();
                    },
                    dropdownStyleData: const DropdownStyleData(
                      maxHeight: 250,
                    ),
                  );
                })));
  }

  GetBuilder<Sale_Invoices_Controller> DropdownDiscountTYPEBuilder() {
    return GetBuilder<Sale_Invoices_Controller>(
        init: Sale_Invoices_Controller(),
        builder: ((controller) =>
            FutureBuilder<List<List_Value>>(
                future: GET_LIST_VALUE('BMMDN'),
                builder: (BuildContext context,
                    AsyncSnapshot<List<List_Value>> snapshot) {
                  if (!snapshot.hasData) {
                    return Dropdown(
                      josnStatus: josnStatus,
                      GETSTRING: 'StringBrach',
                    );
                  }
                  return IgnorePointer(
                    ignoring: controller.edit == true ||
                        controller.CheckBack == 1
                        ? true
                        : false,
                    child: DropdownButtonFormField2(
                      decoration: ThemeHelper().InputDecorationDropDown(
                          'StringDiscount_TYPE'.tr),
                      isExpanded: true,
                      hint: ThemeHelper().buildText(
                          context, 'StringDiscount_TYPE', Colors.grey, 'S'),
                      value: controller.SelectDataBMMDN,
                      style: ThemeHelper().buildTextStyle(
                          context, Colors.black, 'M'),
                      items: snapshot.data!
                          .map((item) =>
                          DropdownMenuItem<String>(
                            value: item.LVID.toString(),
                            child: Text(
                              item.LVNA_D.toString(),
                              style: ThemeHelper().buildTextStyle(context,
                                  Colors.black, 'S'),
                            ),
                          ))
                          .toList()
                          .obs,
                      onChanged: (value) {
                        // Do something when changing the item if you want.
                        if (value.toString() == '0') {
                          if (controller.SelectDataBMMDN == '1' &&
                              controller.CheckBack == 1) {
                            buildShowTotal2(context);
                          } else {
                            controller.SelectDataBMMDN = '0';
                            controller.BMMDIRController.text = '0';
                            controller.BMMDIController.text = '0';
                            controller.update();
                          }
                        } else {
                          controller.SelectDataBMMDN = '1';
                          controller.update();
                        }
                        controller.update();
                      },
                    ),
                  );
                })));
  }

  GetBuilder<Sale_Invoices_Controller> DropdownACCOUNTING_EFFECTBuilder(BuildContext context) {
    return GetBuilder<Sale_Invoices_Controller>(
        init: Sale_Invoices_Controller(),
        builder: ((controller) =>
            DropdownButtonFormField2(
              decoration: ThemeHelper().InputDecorationDropDown(
                  'StringBMMBR'.tr),
              isExpanded: true,
              value: controller.SelectDataBMMBR,
              style: ThemeHelper().buildTextStyle(context, Colors.black, 'M'),
              items: items_ACCOUNTING_EFFECT
                  .map((item) =>
                  DropdownMenuItem<String>(
                    value: item['id'],
                    child: Text(
                      item['name'],
                      style: ThemeHelper().buildTextStyle(
                          context, Colors.black, 'M'),
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
                controller.SelectDataBMMBR = value.toString();
              },
            )));
  }

  GetBuilder<Sale_Invoices_Controller> DropdownACC_BANBuilder() {
    return GetBuilder<Sale_Invoices_Controller>(
        init: Sale_Invoices_Controller(),
        builder: ((controller) =>
            FutureBuilder<List<Acc_Ban_Local>>(
                future: GET_ACC_BAN(controller.SelectDataBIID.toString()),
                builder: (BuildContext context,
                    AsyncSnapshot<List<Acc_Ban_Local>> snapshot) {
                  if (!snapshot.hasData) {
                    return Dropdown(
                      josnStatus: josnStatus,
                      GETSTRING: 'StringBrach',
                    );
                  }
                  return DropdownButtonFormField2(
                    decoration: ThemeHelper().InputDecorationDropDown('StringBank'.tr),
                    isExpanded: true,
                    hint: ThemeHelper().buildText(
                        context, 'StringvalidateABID', Colors.grey, 'S'),
                    value: controller.SelectDataABID,
                    style: ThemeHelper().buildTextStyle(context, Colors.black, 'M'),
                    items: snapshot.data!.map((item) =>
                        DropdownMenuItem<String>(
                          value: item.ABID.toString(),
                          child: Text(
                            "${item.ABID.toString()} - ${item.ABNA_D
                                .toString()}",
                            style: ThemeHelper().buildTextStyle(
                                context, Colors.black, 'M'),
                          ),
                        ))
                        .toList()
                        .obs,
                    onChanged: (value) {
                      //Do something when changing the item if you want.
                      controller.SelectDataABID = value.toString();
                      controller.update();
                    },
                  );
                })));
  }

  GetBuilder<Sale_Invoices_Controller> DropdownBIL_IMPBuilder() {
    return GetBuilder<Sale_Invoices_Controller>(
        init: Sale_Invoices_Controller(),
        builder: (controller) => FutureBuilder<List<Bil_Imp_Local>>(
          future: GET_BIL_IMP(),
          builder: (BuildContext context, AsyncSnapshot<List<Bil_Imp_Local>> snapshot) {
            if (!snapshot.hasData) {
              return Dropdown(
                josnStatus: josnStatus,
                GETSTRING: 'StringSupplier'.tr,
              );
            }
            return IgnorePointer(
              ignoring:  _isIgnoringDropdown_IMP(),
              child: DropdownButtonFormField2(
                decoration: ThemeHelper().InputDecorationDropDown(
                    suffixIconColor: Colors.black45,
                    suffixIcon:_isIgnoringDropdown_IMP()?null: _buildSuffixIcon_IMP(),
                    "${'StringSupplier'.tr}  ${'StringCUS_BAL'.tr} ${controller.formatter.format(controller.BACBA).toString()}"),
                isDense: true,
                isExpanded: true,
                hint: ThemeHelper().buildText(context, 'StringSupplier', Colors.grey, 'S'),
                iconStyleData: IconStyleData(
                  icon: controller.SelectDataBIID2 == null
                      ?snapshot.connectionState == ConnectionState.waiting
                      ? const SizedBox(
                    width: 24,
                    height: 24,
                    child: CircularProgressIndicator(
                      strokeWidth: 2,
                      color: Colors.black45,
                    ),
                  )
                      : const Icon(
                    Icons.arrow_drop_down,
                    color: Colors.black45,
                  )
                      : InkWell(
                    onTap: () {
                      controller.buildShowBIL_ACC_C(context);
                    },
                    child: const Icon(
                      Icons.error_outline,
                      color: Colors.black45,
                      size: 20,
                    ),
                  ),
                ),
                items: snapshot.data!.map((item) => DropdownMenuItem<String>(
                  onTap: () async {
                    controller.BCNAController.text = item.BINA.toString();
                    controller.AANOController.text = item.AANO.toString();
                    controller.GUIDC = item.GUID.toString();
                    controller.BCMOController.text = item.BIMO.toString();
                    controller.BIIDB = item.BIID;
                    controller.PKID_C = item.PKID;
                    controller.BCCT = item.BICT;
                    controller.SCID_C = item.SCID;
                    controller.BCAD_D = item.BIAD.toString();
                    controller.GET_BIL_ACC_C_P(
                        controller.AANOController.text,
                        controller.GUIDC,
                        controller.SelectDataBIID.toString(),
                        controller.SelectDataSCID.toString(),
                        PKID.toString(),GETBMMID: BMMID.toString());
                    await controller.GET_TAX_LIN_CUS_IMP_P(
                        'IMP', item.AANO.toString(), item.BIID.toString());
                  },
                  value: "${item.BIID.toString() + " +++ " + item.BINA_D.toString()}",
                  child: Text(
                    "${item.BIID.toString()} - ${item.BINA_D.toString()}",
                    style: ThemeHelper()
                        .buildTextStyle(context, Colors.black, 'M'),
                    overflow: TextOverflow.ellipsis,
                  ),
                )).toList().obs,
                value: controller.SelectDataBIID3,
                onChanged: (value) {
                  controller.SelectDataBIID3 = value as String;
                  controller.SelectDataBIID2 = value.toString().split(" +++ ")[0];
                  controller.update();
                },
                dropdownStyleData: const DropdownStyleData(
                  maxHeight: 300,
                ),
                dropdownSearchData: DropdownSearchData(
                    searchController: controller.TextEditingSercheController,
                    searchInnerWidget: Padding(
                      padding: const EdgeInsets.symmetric(
                        vertical: 8,
                        horizontal: 8,
                      ),
                      child: TextFormField(
                        controller: controller.TextEditingSercheController,
                        decoration: InputDecoration(
                          isDense: true,
                          suffixIcon: IconButton(
                            icon: const Icon(Icons.clear, size: 20),
                            onPressed: () {
                              controller.TextEditingSercheController.clear();
                              controller.update();
                            },
                          ),
                          contentPadding: const EdgeInsets.symmetric(
                            horizontal: 10,
                            vertical: 8,
                          ),
                          hintText: 'StringSearch_for_BIID'.tr,
                          hintStyle: ThemeHelper()
                              .buildTextStyle(context, Colors.grey, 'S'),
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
                          .contains(searchValue.toLowerCase()));
                    },
                    searchInnerWidgetHeight: 50),
                onMenuStateChange: (isOpen) {
                  if (!isOpen) {
                    controller.TextEditingSercheController.clear();
                  }
                },
              ),
            );
          },
        ));
  }

  // دالة لإنشاء أيقونة النهاية
  Widget _buildSuffixIcon_IMP() {
    return IconButton(
      icon: const Icon(Icons.cancel, size: 23),
      onPressed: () {
        SelectDataBIID3 = null;
        SelectDataBIID2 = null;
        BACBA = 0;
        update();
      },
    );
  }

  Future<dynamic> buildShowTotal(BuildContext context) {
    double height = MediaQuery
        .of(context)
        .size
        .height;
    return Get.defaultDialog(
      title: "StringTotal".tr,
      content: Padding(
        padding: EdgeInsets.only(
            right: 0.002 * height, left: 0.002 * height),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                ThemeHelper().buildText(
                    context, 'StrinCount_MINO', Colors.black, 'M'),
                Expanded(
                  child: TextFormField(
                    readOnly: true,
                    textAlign: TextAlign.center,
                    controller: CountRecodeController,
                    decoration: InputDecoration(
                        contentPadding: const EdgeInsets.symmetric(
                            vertical: 10, horizontal: 8)),
                  ),
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                ThemeHelper().buildText(
                    context, 'StringTotal_BMDNO', Colors.black, 'M'),
                Expanded(
                  child: TextFormField(
                    readOnly: true,
                    textAlign: TextAlign.center,
                    controller: COUNTBMDNOController,
                    decoration: InputDecoration(
                        contentPadding: const EdgeInsets.symmetric(
                            vertical: 10, horizontal: 8)),
                  ),
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                ThemeHelper().buildText(
                    context, 'StringBMMDIF', Colors.black, 'M'),
                Expanded(
                  child: TextFormField(
                    readOnly: true,
                    textAlign: TextAlign.center,
                    controller: SUMBMMDIFController,
                    decoration: InputDecoration(
                        contentPadding: const EdgeInsets.symmetric(
                            vertical: 10, horizontal: 8)),
                  ),
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                ThemeHelper().buildText(
                    context, 'StringSUMBMMDI', Colors.black, 'M'),
                Expanded(
                  child: TextFormField(
                    readOnly: true,
                    textAlign: TextAlign.center,
                    controller: BMMDIController,
                    decoration: InputDecoration(
                        contentPadding: const EdgeInsets.symmetric(
                            vertical: 10, horizontal: 8)),
                  ),
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                ThemeHelper().buildText(
                    context, 'StringSUMBMDAMT', Colors.black, 'M'),
                Expanded(
                  child: TextFormField(
                    readOnly: true,
                    textAlign: TextAlign.center,
                    controller: BMMAMController,
                    decoration: InputDecoration(
                        contentPadding: const EdgeInsets.symmetric(
                            vertical: 10, horizontal: 8)),
                  ),
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                ThemeHelper().buildText(
                    context, 'StringSUMBMDTXT', Colors.black, 'M'),
                Expanded(
                  child: TextFormField(
                    readOnly: true,
                    textAlign: TextAlign.center,
                    controller: SUMBMDTXTController,
                    decoration: InputDecoration(
                        contentPadding: const EdgeInsets.symmetric(
                            vertical: 10, horizontal: 8)),
                  ),
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                ThemeHelper().buildText(
                    context, 'StrinSUMBCMAM', Colors.black, 'M'),
                Expanded(
                  child: TextFormField(
                    readOnly: true,
                    textAlign: TextAlign.center,
                    controller: BMMAMTOTController,
                    decoration: InputDecoration(
                        contentPadding: const EdgeInsets.symmetric(
                            vertical: 10, horizontal: 8)),
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

  Future<dynamic> buildShowTotal2(BuildContext context) {
    return Get.defaultDialog(
        title: 'StringMestitle'.tr,
        middleText: 'StrinErr_BMMDN'.tr,
        backgroundColor: Colors.white,
        radius: 40,
        textCancel: 'StringNo'.tr,
        cancelTextColor: Colors.red,
        textConfirm: 'StringYes'.tr,
        confirmTextColor: Colors.white,
        onConfirm: () async {
          Navigator.of(context).pop(false);
          SelectDataBMMDN = '0';
          BMMDIRController.text = '0';
          BMMDIController.text = '0';
          //الخصم علي مستوى الفاتورة
          UPDATE_BMMDI();
          update();
        },
        onCancel: () {
          update();
          SelectDataBMMDN = '1';
          update();
        }
      // barrierDismissible: false,
    );
  }

  Future<dynamic> buildShowSYS_CUR(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    return Get.defaultDialog(
      title: "StringAdditional_Data".tr,
      content: Padding(
        padding: EdgeInsets.only(right: 0.002 * height, left: 0.002 * height),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text("${'String_SCEXS'.tr}  ",
                  style: ThemeHelper().buildTextStyle(
                      context, Colors.black, 'M'),),
                Expanded(
                  child: TextFormField(
                    readOnly: edit == true || CheckBack == 1 ? true : false,
                    textAlign: TextAlign.center,
                    keyboardType: TextInputType.number,
                    controller: SCEXSController,
                    decoration: InputDecoration(
                        contentPadding: const EdgeInsets.symmetric(
                            vertical: 13, horizontal: 8)),
                    onChanged: (v) {
                      if (v.isNotEmpty) {
                        SCEXS = double.parse(v);
                        update();
                      }
                    },
                  ),
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text("${'Stringexchangerate'.tr}               ",
                    style: ThemeHelper().buildTextStyle(
                        context, Colors.black, 'M')),
                Expanded(
                  child: TextFormField(
                    readOnly: edit == true || CheckBack == 1 ||
                        SelectDataSCID == '1' ? true : false,
                    textAlign: TextAlign.center,
                    keyboardType: TextInputType.number,
                    controller: SCEXController,
                    decoration: InputDecoration(
                        contentPadding: const EdgeInsets.symmetric(
                            vertical: 13, horizontal: 8)),
                    // onChanged: (v) {
                    //   controller.validateDefault_SNNO(v);
                    // },
                  ),
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('StrinSCHR'.tr,
                    style: ThemeHelper().buildTextStyle(
                        context, Colors.black, 'M')),
                Expanded(
                  child: TextFormField(
                    readOnly: true,
                    textAlign: TextAlign.center,
                    controller: SCHRController,
                    decoration: InputDecoration(
                        contentPadding: const EdgeInsets.symmetric(
                            vertical: 13, horizontal: 8)),
                  ),
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text("${'StrinSCLR'.tr}  ",
                    style: ThemeHelper().buildTextStyle(
                        context, Colors.black, 'M')),
                Expanded(
                  child: TextFormField(
                    readOnly: true,
                    textAlign: TextAlign.center,
                    controller: SCLRController,
                    decoration: InputDecoration(
                        contentPadding: const EdgeInsets.symmetric(
                            vertical: 13, horizontal: 8)),
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

  Future<dynamic> buildShowBIL_ACC_C(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    return Get.defaultDialog(
      title: BMKID == 1 || BMKID == 2 ? 'StringDAT_IMP'.tr : 'StringDAT_CUS'.tr,
      backgroundColor: Colors.white,
      radius: 30,
      content: Column(children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Text(
                "${'StringAMDMD'.tr}:",
                style: ThemeHelper().buildTextStyle(
                    context, Colors.black87, 'M')
            ),

            Text(formatter.format(BACBMD).toString(),
              style: ThemeHelper().buildTextStyle(context, Colors.black, 'M'),
            ),
          ],
        ),
        SizedBox(height: 0.015 * height),
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Text(
              "${'StringAMDDA'.tr}:",
              style: ThemeHelper().buildTextStyle(context, Colors.black87, 'M'),
            ),

            Text(formatter.format(BACBDA).toString(),
                style: ThemeHelper().buildTextStyle(context, Colors.black, 'M')
            ),
          ],
        ),
        SizedBox(height: 0.015 * height),
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Text(
              "${'StringBalance_Not_Final'.tr}:",
              style: ThemeHelper().buildTextStyle(context, Colors.black87, 'M'),
            ),
            Text(formatter.format(BACBNF).toString(),
                style: ThemeHelper().buildTextStyle(context, Colors.black, 'M')
            ),
          ],
        ),
        SizedBox(height: 0.015 * height),
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Text(
              "${'StringUn_Balance'.tr}:",
              style: ThemeHelper().buildTextStyle(context, Colors.black87, 'M'),
            ),
            Text(formatter.format(SUMBAL).toString(),
                style: ThemeHelper().buildTextStyle(context, Colors.black, 'M')
            ),
          ],
        ),
        SizedBox(height: 0.015 * height),
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Text(
                "${'StringCurrent_Balance'.tr}:",
                style: ThemeHelper().buildTextStyle(
                    context, Colors.black87, 'M')
            ),

            Text(formatter.format(BACBA).toString(),
              style: ThemeHelper().buildTextStyle(context,
                  BACBA == 0 ? Colors.black : BACBAS == 'M'
                      ? Colors.green
                      : Colors.red, 'M'),
            ),
          ],
        ),
        SizedBox(height: 0.015 * height),
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Text(
              "${'StringBCBL3'.tr}:",
              style: ThemeHelper().buildTextStyle(context, Colors.black87, 'M'),
            ),
            Text(formatter.format(BCBL).toString(),
                style: ThemeHelper().buildTextStyle(context, Colors.black, 'M')
            ),
          ],
        ),
        SizedBox(height: 0.015 * height),
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Text(
                "${'StringBACLBN'.tr}:",
                style: ThemeHelper().buildTextStyle(
                    context, Colors.black87, 'M')
            ),

            Text(
                BACLBN.toString(),
                style: ThemeHelper().buildTextStyle(
                    context, Colors.black, 'M')
            ),
          ],
        ),
        SizedBox(height: 0.015 * height),
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Text(
                "${'StringBACLBD'.tr}:",
                style: ThemeHelper().buildTextStyle(
                    context, Colors.black87, 'M')
            ),
            Text(
                BACLBD.toString(),
                style: ThemeHelper().buildTextStyle(
                    context, Colors.black, 'M')
            ),
          ],
        ),
        SizedBox(height: 0.015 * height),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Text(
                "${'StringAddress'.tr}:",
                style: ThemeHelper().buildTextStyle(
                    context, Colors.black87, 'M')
            ),

            Expanded(
              child: Text(BCAD_D.toString() == 'null' ? '' : BCAD_D.toString(),
                  style: ThemeHelper().buildTextStyle(
                      context, Colors.black, 'M')
              ),
            ),
          ],
        ),
        SizedBox(height: 0.015 * height),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Text(
                "${'StringLONGITUDE'.tr}:",
                style: ThemeHelper().buildTextStyle(
                    context, Colors.black87, 'M')
            ),

            Expanded(
              child: Text(BCLON.toString() == 'null' ? '' : BCLON.toString(),
                  style: ThemeHelper().buildTextStyle(context, Colors.black, 'M')
              ),
            ),
          ],
        ),
        SizedBox(height: 0.015 * height),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Text(
                "${'StringLATITUDE'.tr}:",
                style: ThemeHelper().buildTextStyle(
                    context, Colors.black87, 'M')
            ),

            Expanded(
              child: Text(BCLAT.toString() == 'null' ? '' : BCLAT.toString(),
                  style: ThemeHelper().buildTextStyle(context, Colors.black, 'M')
              ),
            ),
          ],
        ),
        SizedBox(height: 0.015 * height),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            // Text(
            //     "${'StringLATITUDE'.tr}:",
            //     style: ThemeHelper().buildTextStyle(
            //         context, Colors.black87, 'M')
            // ),

            Expanded(
              child: Text(distanceStr.toString() == 'null' ? '' : distanceStr.toString(),
                  style: ThemeHelper().buildTextStyle(context, Colors.black, 'M')
              ),
            ),
          ],
        ),
      ]),
      textCancel: 'StringHide'.tr,
      cancelTextColor: Colors.blueAccent,
      // barrierDismissible: false,
    );
  }

  static const MaterialColor buttonTextColor = MaterialColor(
    0xFFEF5350,
    <int, Color>{
      50: Color(0xFFFFEBEE),
      100: Color(0xFFFFCDD2),
      200: Color(0xFFEF9A9A),
      300: Color(0xFFE57373),
      400: Color(0xFFEF5350),
      500: Color(0xFFF44336),
      600: Color(0xFFE53935),
      700: Color(0xFFD32F2F),
      800: Color(0xFFC62828),
      900: Color(0xFFB71C1C),
    },
  );

  Future<void> selectDateFromDays(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: dateTimeDays,
      firstDate: DateTime(2022, 5),
      lastDate: DateTime(2050),
      builder: (context, child) {
        return Theme(
          data: ThemeData.light().copyWith(
              primaryColor: const Color(0xFF4A5BF6),
              colorScheme: ColorScheme.fromSwatch(
                  primarySwatch: buttonTextColor).copyWith(
                  secondary: const Color(0xFF4A5BF6)) //selection color
          ),
          child: child!,
        );
      },);

    if (picked != null) {
      final difference = dateTimeDays
          .difference(picked)
          .inDays;
      if (difference >= 0) {
        dateTimeDays = picked;
        SelectDays =
        DateFormat('dd-MM-yyyy HH:m').format(dateTimeDays).toString().split(
            " ")[0];
        BMMRD =
        DateFormat('yyyy-MM-dd').format(dateTimeDays).toString().split(" ")[0];
      } else {
        Fluttertoast.showToast(
            msg: "StringCHK_SMMDO".tr,
            textColor: Colors.white,
            backgroundColor: Colors.redAccent);
      }
      update();
    }
  }

  Future<void> selectDateBMMDD(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
        context: context,
        initialDate: dateTimeDays,
        firstDate: DateTime(2022, 5),
        lastDate: DateTime(2050));
    if (picked != null) {
      final difference = dateTimeDays
          .difference(picked)
          .inDays;
      if (difference <= 0) {
        dateTimeDays = picked;
        BMMDDController.text =
        DateFormat('dd-MM-yyyy HH:m').format(dateTimeDays).toString().split(
            " ")[0];
        update();
      } else {
        Fluttertoast.showToast(
            msg: "StringCHK_BMMDD".tr,
            textColor: Colors.white,
            backgroundColor: Colors.redAccent);
      }
      update();
    }
  }

  Future<void> selectDateBMMCD(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
        context: context,
        initialDate: dateTimeDays,
        firstDate: DateTime(2022, 5),
        lastDate: DateTime(2050));

    if (picked != null) {
      final difference = dateTimeDays
          .difference(picked)
          .inDays;
      if (difference <= 0) {
        dateTimeDays = picked;
        BMMCDController.text =
        DateFormat('dd-MM-yyyy HH:m').format(dateTimeDays).toString().split(
            " ")[0];
        update();
      } else {
        Fluttertoast.showToast(
            msg: "StringCHK_BMMDD".tr,
            textColor: Colors.white,
            backgroundColor: Colors.redAccent);
      }

      update();
    }
  }


  //دالة استدعاء الطباعة
  dynamic generatePdfInvoice({
    required String typeRep,
    required String? GetBMKID,
    required String? GetBMMDO,
    required String? GetBMMNO,
    required String? GetPKNA,
    required ShareMode mode,
  }) {
    print('typeRep');
    print(typeRep);
    if (['58', '80'].contains(typeRep)) {
      taxTikcetReportThermal(
        mode: mode,
        msg: 'مرحبا',
        Type_Rep: typeRep,
      );
    }
    else {
      print(USE_TX);
      print(BCTX);
      print(GetBMKID);
      print(USE_TX != '1');
      if (USE_TX != '1') {
        Pdf_Invoices_Samplie(
          GetBMKID: GetBMKID,
          GetBMMDO: GetBMMDO,
          GetBMMNO: GetBMMNO,
          GetPKNA: GetPKNA,
          mode: mode,
        );
      } else {
        if ((BCTX.isEmpty || BCTX == 'null') ||
            (GetBMKID == '7' || GetBMKID == '10')) {
          return Pdf_Invoices_Samplie(
            GetBMKID: GetBMKID,
            GetBMMDO: GetBMMDO,
            GetBMMNO: GetBMMNO,
            GetPKNA: GetPKNA,
            mode: mode,
          );
        }
        else {
          return Pdf_Invoices(
            GetBMKID: GetBMKID,
            GetBMMDO: GetBMMDO,
            GetBMMNO: GetBMMNO,
            GetPKNA: GetPKNA,
            Type_Model_A4: typeRep,
            mode: mode,
          );
        }
      }
    }
  }


  //دالة استخدام التوقيع
  dynamic generateSignature({
    required String typeRep,
    required String? GetBMKID,
    required String? GetBMMDO,
    required String? GetBMMNO,
    required String? GetPKNA,
    required ShareMode mode,
  }) async {
    print('generateSignature');
    print(typeRep);
    print(UseSignature);
    print(ShowSignatureAlert);
    if (UseSignature == 0 && ShowSignatureAlert == 0) {
      generatePdfInvoice(
          typeRep: typeRep,
          GetBMKID: GetBMKID,
          GetBMMDO: GetBMMDO,
          GetBMMNO: GetBMMNO,
          GetPKNA: GetPKNA,
          mode: mode);
    }
    else if (UseSignature == 1 && ShowSignatureAlert == 0) {
      signature = await Get.to(SignatureScreen());
      if (signature != null) {
        generatePdfInvoice(
            typeRep: typeRep,
            GetBMKID: GetBMKID,
            GetBMMDO: GetBMMDO,
            GetBMMNO: GetBMMNO,
            GetPKNA: GetPKNA,
            mode: mode);
      }
    }
    else {
      print('ShowSignatureAlert');
      Get.defaultDialog(
        title: 'StringMestitle'.tr,
        middleText: 'StringPrintSureSUID'.tr,
        backgroundColor: Colors.white,
        radius: 40,
        textCancel: 'StringNo'.tr,
        cancelTextColor: Colors.red,
        textConfirm: 'StringYes'.tr,
        confirmTextColor: Colors.white,
        onConfirm: () async {
          Get.back();
          // Navigator.of(context).pop(false);
          signature = await Get.to(SignatureScreen());
          //  controller.signature = await Navigator.push(context, MaterialPageRoute(builder: (_) => SignatureScreen()));
          if (signature != null) {
            generatePdfInvoice(
                typeRep: typeRep,
                GetBMKID: GetBMKID,
                GetBMMDO: GetBMMDO,
                GetBMMNO: GetBMMNO,
                GetPKNA: GetPKNA,
                mode: mode);
          }
        },
        onCancel: () {
          generatePdfInvoice(
              typeRep: typeRep,
              GetBMKID: GetBMKID,
              GetBMMDO: GetBMMDO,
              GetBMMNO: GetBMMNO,
              GetPKNA: GetPKNA,
              mode: mode);
        },
      );
    }
  }

  Future PRINT_BALANCE_P({
    BMMID,AANO,SCID,PKID,
    required String typeRep,
    String? GetBMKID,
    String? GetBMMDO,
    String? GetBMMNO,
    String? GetPKNA,
    required ShareMode mode}) async {
    PRINT_BALANCE_ALR=false;
    if (StteingController().PRINT_BALANCE == true && PKID=='3') {
      if(StteingController().PRINT_BALANCE_ALERT == true ){
        Get.defaultDialog(
          title: 'StringMestitle'.tr,
          middleText: 'StringPrintSureBalance'.tr,
          backgroundColor: Colors.white,
          radius: 40,
          textCancel: 'StringNo'.tr,
          cancelTextColor: Colors.red,
          textConfirm: 'StringYes'.tr,
          confirmTextColor: Colors.white,
          onConfirm: () async {
            Get.back();
            PRINT_BALANCE_ALR=true;
            await GET_BIL_ACC_C_P(AANO, '', '', SCID,PKID,GETBMMID: BMMID);
            await generateSignature(typeRep: typeRep,GetBMKID:GetBMKID,GetBMMDO:GetBMMDO,
                GetBMMNO:GetBMMNO,GetPKNA:GetPKNA,mode:mode);
          },
          onCancel: () async {
            //  Get.back();
            print('onCancel');
            PRINT_BALANCE_ALR=false;
            await Future.delayed(const Duration(milliseconds: 300));
            await generateSignature(typeRep: typeRep,GetBMKID:GetBMKID,GetBMMDO:GetBMMDO,
                GetBMMNO:GetBMMNO,GetPKNA:GetPKNA,mode:mode);
          },
        );
      }
      else{
        PRINT_BALANCE_ALR=false;
        await GET_BIL_ACC_C_P(AANO, '', '', SCID,PKID,GETBMMID: BMMID);
        await generateSignature(typeRep: typeRep,GetBMKID:GetBMKID,GetBMMDO:GetBMMDO,
            GetBMMNO:GetBMMNO,GetPKNA:GetPKNA,mode:mode);
      }
    }else{
      PRINT_BALANCE_ALR=false;
      await generateSignature(typeRep: typeRep,GetBMKID:GetBMKID,GetBMMDO:GetBMMDO,
          GetBMMNO:GetBMMNO,GetPKNA:GetPKNA,mode:mode);
    }
  }

  Future SND_WS_P({
    String? MSG_WS,
    String? GetBMKID,
    String? GetBMMDO,
    String? GetBMMNO,
    String? GetPKNA,
    String? GetPHOEN}) async {
    INV_RE_TYP INV_RE_R=INV_RE_TYP();
    if (StteingController().WAT_ACT == true) {
      if(StteingController().USE_WAT_ALERT == true ){
        Get.defaultDialog(
          title: 'StringMestitle'.tr,
          middleText: "${'StringPrintSureWS'.tr}",
          backgroundColor: Colors.white,
          radius: 40,
          textCancel: 'StringNo'.tr,
          cancelTextColor: Colors.red,
          textConfirm: 'StringYes'.tr,
          confirmTextColor: Colors.white,
          onConfirm: () async {
            Get.back();
            generatePdfInvoice(
                typeRep: '4',
                GetBMKID: GetBMKID,
                GetBMMDO: GetBMMDO,
                GetBMMNO: GetBMMNO,
                GetPKNA: GetPKNA,
                mode: ShareMode.sendBase64);
          },
          onCancel: () {
            print('onCancel');
          },
        );
      }
      else{
        generatePdfInvoice(
            typeRep: '4',
            GetBMKID: GetBMKID,
            GetBMMDO: GetBMMDO,
            GetBMMNO: GetBMMNO,
            GetPKNA: GetPKNA,
            mode: ShareMode.sendBase64);

        INV_RE_R=await ES_WS_PKG.SND_WS_P(MSG_WS,AANOController.text);
        print('ERR_TYP_N');
        print(INV_RE_R.ERR_TYP_N);
        print(INV_RE_R.ERR_V);
        if(INV_RE_R.ERR_TYP_N!=1){
          Fluttertoast.showToast(
              msg: INV_RE_R.ERR_V.toString(),
              toastLength: Toast.LENGTH_LONG,
              textColor: Colors.white,
              backgroundColor: Colors.redAccent);
        }
      }
    }
  }



}
