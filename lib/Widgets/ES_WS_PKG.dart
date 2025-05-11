import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import '../Setting/controllers/login_controller.dart';
import '../Setting/models/eco_acc.dart';
import '../Setting/models/message_request.dart';
import '../Setting/models/syn_off_m2.dart';
import '../Setting/models/syn_set.dart';
import '../Setting/services/fat_mod.dart';
import '../database/setting_db.dart';
import 'config.dart';

class ES_WS_PKG {

  //لحفظ بيانات عامه
  static Future  GET_P() async {
    var STP_N=0;
    try {
      STP_N=1;
      //
      // --4101 استخدام الواتساب
      var USE_WS=await  GET_ECO_VAR('4101');
      if (USE_WS.isNotEmpty) {
        LoginController().SET_P('USE_WS',USE_WS.elementAt(0).SVVL.toString());
      }else{
        LoginController().SET_P('USE_WS','2');
      }

      //--4102 الفارق التوقيت بالثانيه بين كل رساله في الواتساب
      var IS_WA_DELAY_TIM=await GET_ECO_VAR('4102');
      if (IS_WA_DELAY_TIM.isNotEmpty) {
        LoginController().SET_P('IS_WA_DELAY_TIM',IS_WA_DELAY_TIM.elementAt(0).SVVL.toString());
      }
      else{
        LoginController().SET_P('IS_WA_DELAY_TIM','2');
      }

      //--4057 الدوله الاساسيه لنظام ايليت تواصل
      var MAI_COU = await GET_ECO_VAR('4057');
      if (MAI_COU.isNotEmpty) {
        LoginController().SET_P('MAI_COU',MAI_COU.elementAt(0).SVVL.toString());
      }
      else{
        LoginController().SET_P('MAI_COU','1');
      }


      //العنوان الرئيسي لاسم المنشأه في الرسايل
      var MS_T = await GET_ECO_VAR('4053');
      if (MS_T.isNotEmpty) {
        LoginController().SET_P('MS_T',MS_T.elementAt(0).SVVL.toString());
      }
      else{
        LoginController().SET_P('MS_T','Elite');
      }

      //تضمين بيان الحركه في الرساله :
      var ADD_DET_MESSAGE = await GET_ECO_VAR('4155');
      if (ADD_DET_MESSAGE.isNotEmpty) {
        LoginController().SET_P('ADD_DET_MESSAGE',ADD_DET_MESSAGE.elementAt(0).SVVL.toString());
      }
      else{
        LoginController().SET_P('ADD_DET_MESSAGE','1');
      }


      //اسم المنشأه المضاف نهاية الرساله
      var COM_NAM_MESS = await GET_ECO_VAR('4164');
      if (COM_NAM_MESS.isNotEmpty) {
        LoginController().SET_P('COM_NAM_MESS',COM_NAM_MESS.elementAt(0).SVVL.toString());
      }
      else{
        LoginController().SET_P('COM_NAM_MESS','ايليت');
      }

      //تضمين بيانات اصناف  الفاتوره في الرساله
      var ADD_ITEM_MESS = await GET_ECO_VAR('4165');
      if (ADD_ITEM_MESS.isNotEmpty) {
        LoginController().SET_P('ADD_ITEM_MESS',ADD_ITEM_MESS.elementAt(0).SVVL.toString());
      }
      else{
        LoginController().SET_P('ADD_ITEM_MESS','2');
      }


      //بيانات الاصناف المضافه هيا:
      var ITEM_MESS_INCLUDE = await GET_ECO_VAR('4166');
      if (ITEM_MESS_INCLUDE.isNotEmpty) {
        LoginController().SET_P('ITEM_MESS_INCLUDE',ITEM_MESS_INCLUDE.elementAt(0).SVVL.toString());
      }
      else{
        LoginController().SET_P('ITEM_MESS_INCLUDE','');
      }

      //بيانات الاصناف المضافه هيا:
      var ITEM_MESS_INCLUD = await GET_ECO_VAR('4079');
      if (ITEM_MESS_INCLUDE.isNotEmpty) {
        LoginController().SET_P('ITEM_MESS_INCLUDE',ITEM_MESS_INCLUDE.elementAt(0).SVVL.toString());
      }
      else{
        LoginController().SET_P('ITEM_MESS_INCLUDE','');
      }

      //بيانات الاصناف المضافه هيا:
      var ITEM_MESS_INCUD = await GET_ECO_VAR('4179');
      if (ITEM_MESS_INCLUDE.isNotEmpty) {
        LoginController().SET_P('ITEM_MESS_INCLUDE',ITEM_MESS_INCLUDE.elementAt(0).SVVL.toString());
      }
      else{
        LoginController().SET_P('ITEM_MESS_INCLUDE','');
      }

      //Verify that the number you are sending to has a WhatsApp account before sending
      //التحقق من ان الرقم المرسل له يمتلك حسابا في الواتساب قبل الارسال
      var WhatsAppAccountVerified = await GET_ECO_VAR('4168');
      if (WhatsAppAccountVerified.isNotEmpty) {
        LoginController().SET_P('isWhatsAppAccountVerified',WhatsAppAccountVerified.elementAt(0).SVVL.toString());
      }
      else{
        LoginController().SET_P('isWhatsAppAccountVerified','2');
      }

      //التحقق من  ان الرقم المرسل له يقع ضمن جهات الاتصال للحساب قبل الارسال
      var CON_SAV_N = await GET_ECO_VAR('4167');
      if (CON_SAV_N.isNotEmpty) {
        LoginController().SET_P('CON_SAV_N',CON_SAV_N.elementAt(0).SVVL.toString());
      }
      else{
        LoginController().SET_P('CON_SAV_N','2');
      }

      //انواع المستندات التي سيتم ارساله كملف الكتروني
      var TYPE_DOC = await GET_ECO_VAR('4170');
      if (TYPE_DOC.isNotEmpty) {
        LoginController().SET_P('TYPE_DOC',TYPE_DOC.elementAt(0).SVVL.toString());
      }
      else{
        LoginController().SET_P('TYPE_DOC',' ');
      }


      //تحويل الملف الكتروني الى صورة
      var CONVERT_FILE_TO_IMAGE = await GET_ECO_VAR('4171');
      if (CONVERT_FILE_TO_IMAGE.isNotEmpty) {
        LoginController().SET_P('CONVERT_FILE_TO_IMAGE',TYPE_DOC.elementAt(0).SVVL.toString());
      }
      else{
        LoginController().SET_P('CONVERT_FILE_TO_IMAGE','2');
      }

      //ارسال الصورة كمستند
      var SNED_IMAGE_DOC = await GET_ECO_VAR('4172');
      if (SNED_IMAGE_DOC.isNotEmpty) {
        LoginController().SET_P('SNED_IMAGE_DOC',TYPE_DOC.elementAt(0).SVVL.toString());
      }
      else{
        LoginController().SET_P('SNED_IMAGE_DOC','2');
      }

      print("USE_WS=${LoginController().USE_WS}");
      print("IS_WA_DELAY_TIM=${LoginController().IS_WA_DELAY_TIM}");
      print("MAI_COU=${LoginController().MAI_COU}");
      print("MS_T=${LoginController().MS_T}");
      print("ADD_DET_MESSAGE=${LoginController().ADD_DET_MESSAGE}");
      print("COM_NAM_MESS=${LoginController().COM_NAM_MESS}");
      print("ADD_ITEM_MESS=${LoginController().ADD_ITEM_MESS}");
      print("ITEM_MESS_INCLUDE=${LoginController().ITEM_MESS_INCLUDE}");
      print("isWhatsAppAccountVerified=${LoginController().isWhatsAppAccountVerified}");
      print("CON_SAV_N=${LoginController().CON_SAV_N}");
      print("TYPE_DOC=${LoginController().TYPE_DOC}");
      print("CONVERT_FILE_TO_IMAGE=${LoginController().CONVERT_FILE_TO_IMAGE}");
      print("SNED_IMAGE_DOC=${LoginController().SNED_IMAGE_DOC}");

    } catch (e, stackTrace) {
      print('ES_WS_PKG.GET_P $e $stackTrace');
      Fluttertoast.showToast(
          msg: "$STP_N-ES_WS_PKG.GET_P-${e.toString()}",
          toastLength: Toast.LENGTH_LONG,
          textColor: Colors.white,
          backgroundColor: Colors.redAccent);
    }
  }


  static Future<INV_RE_TYP> SND_WS_P(MSG_WS,String AANO)  async {
    INV_RE_TYP INV_RE_R=INV_RE_TYP();
    var SYN_SET,SYN_OFF_M2,ECO_ACC,ERR_TYP_N=1,MSG_O_V='';



    ECO_ACC=await GET_ECO_ACC(AANO);
    // if(ECO_ACC.isEmpty){
    //   ERR_TYP_N=3;
    //   MSG_O_V='يجب التاكد من البيانات الرئيسيه';
    //   return (ERR_TYP_N,MSG_O_V);
    // }

    SYN_SET=await GET_SYN_SET();
    // if(SYN_SET.isEmpty){
    //   ERR_TYP_N=3;
    //   MSG_O_V='يجب التاكد من البيانات الرئيسيه';
    //   return (ERR_TYP_N,MSG_O_V);
    // }

    SYN_OFF_M2=await GET_SYN_OFF_M2();
    // if(SYN_OFF_M2.isEmpty){
    //   ERR_TYP_N=3;
    //   MSG_O_V='يجب التاكد من البيانات الرئيسيه';
    //   return (ERR_TYP_N,MSG_O_V);
    // }

    INV_RE_R=await CALL_API_P(SYN_SET,SYN_OFF_M2,ECO_ACC,MSG_WS);

    return INV_RE_R;

  }


  //دالة ارسال الرسالة
  static Future<INV_RE_TYP> CALL_API_P(List<Syn_Set_Local> SYN_SET,List<Syn_Off_M2_Local> SYN_OFF_M2,
      List<Eco_Acc_Local> ECO_ACC,MSG_WS) async {
    INV_RE_TYP INV_RE_R = INV_RE_TYP();
    var STP_N = 1;
    try {

      // var Url ="http://${SYN_SET[0].SSIP}:${SYN_SET[0].SSPO}/${SYN_SET[0].SSAN}/chat/snd_msg";
      // var TOKEN =SYN_SET[0].SSAT.toString();
      // var org =SYN_SET[0].SSOR.toString();
      // var USER =SYN_OFF_M2[0].SOMBST.toString();
      // var PASS =SYN_OFF_M2[0].SOMBST.toString();
      // var PHONE =ECO_ACC[0].EATL.toString();
      var Url = "http://95.216.42.50:5015/ESAPI/EWA/V2/chat/snd_fil_base64"; // API URL snd_fil_base64
      var TOKEN = 'wa.570e36028a343ffl25k';

      print("base64Pdf=${LoginController().base64Pdf}");
      print("fileName=${LoginController().fileName}");

      Socket.connect('95.216.42.50', int.parse('5015'),
          timeout: Duration(seconds: 5)).then((socket) async {
        print("Success");
        socket.destroy();
      }).catchError((error) {
        INV_RE_R.ERR_TYP_N=3;
        INV_RE_R.API_ERR_N=1;
        INV_RE_R.ERR_V= "ES_WS_PKG.CALL_API_P-${error.toString()}";
        print("Exception on Socket $error");
      });

      MessageRequest messageRequest = MessageRequest(
        org: 'ESC000001WA',
        user: 'ESC1J1B06MVJI1DF36',
        pass: 'd3e115ad4c54c6',
        phone: '967773826389',
        message: MSG_WS.toString(),
        checkRegistered: LoginController().isWhatsAppAccountVerified=='1'?true:false,
        checkMyContact: LoginController().CON_SAV_N=='1'?true:false,
        fileName: LoginController().fileName.toString(),
        base64File: LoginController().base64Pdf.toString(),
        convertPdfToImg:LoginController().CONVERT_FILE_TO_IMAGE=='1'? true:false,
        sendAsDoc:LoginController().SNED_IMAGE_DOC=='1'?true:false,
        sendAsSticker: false,
        sendViewOnce: false,
        delay: int.parse(LoginController().IS_WA_DELAY_TIM.toString()),
      );

      // تحويل الكائن إلى JSON
      String jsonString = jsonEncode(messageRequest.toJson());


      var bodylang = utf8.encode(jsonString);
      var basicAuth = 'Basic $TOKEN';

      // إرسال البيانات
      final response = await http.post(
          Uri.parse(Url),
          body: jsonString,
          headers: {
            'Transfer-Encoding': 'chunked',
            HttpHeaders.contentTypeHeader: 'application/json',
            'Content-Length': bodylang.length.toString(),
            'Authorization': basicAuth,
          }).timeout(Duration(seconds: 60));

      // التحقق من الاستجابة
      if (response.body.isEmpty) {
        INV_RE_R.ERR_TYP_N = 3;
        INV_RE_R.ERR_V = 'ES_WS_PKG.CALL_API_P NO_DATA_RETURN';
        return INV_RE_R;
      }

      // هنا يمكن معالجة البيانات المستلمة
      print('الاستجابة: ${response.body}');


      INV_RE_R.ERR_TYP_N = 1;
      INV_RE_R.API_ERR_N = 1;
      INV_RE_R.ERR_V = response.body.toString();
      return INV_RE_R;

    } on TimeoutException catch (_) {
      print('الطلب استغرق أكثر من دقيقة.');
      INV_RE_R.ERR_V = 'ES_WS_PKG.CALL_API_P الطلب استغرق أكثر من دقيقة';
      INV_RE_R.ERR_TYP_N = 3;
      return INV_RE_R;
    } catch (e, stackTrace) {
      print('ES_WS_PKG.CALL_API_P $e');
      print('ES_WS_PKG.CALL_API_P $stackTrace');
      INV_RE_R.ERR_V = 'ES_WS_PKG.CALL_API_P $e';
      INV_RE_R.ERR_TYP_N = 3;
      return INV_RE_R;
    }
  }

}
