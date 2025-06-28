import '../Setting/controllers/login_controller.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

String StringIP="192.168.0.0";
String StringPort="5000";
String baseApi="http://$StringIP:$StringPort";
const String StringIPSERVER='  IP : ';
const String StringPORT='Port:';
var TAB_N="";
var WH_V1="";
var F_GUID_V="";
var SOID_V="";
var PAR_V="";
var FROM_DATE="";

/*
COU
MOB
INVC
EORD
REP
*/

var STMID="MOB";

/*
ANDROID
IOS
*/

var TYPEPHONE="ANDROID";

String DBNAME=   STMID=='MOB' ?"ELITEPRO.db":  STMID=="EORD" ? "ELITEORD.db" : STMID=='COU' ? "ESCOU.db": "ESINVC.db";
String TitleApp= STMID=='MOB' ?"ايليت موبايل برو":  STMID=="EORD" ? "ايليت المطاعم" :
STMID=='COU' ? "ايليت المحطات": "ايليت للمخازن و الجرد المخزني";


String SYDV_APPV= STMID=='MOB' ? '1.63' : STMID=='INVC' ? '1.22' : STMID=='EORD' ? '1.9' : '1.20';



String SYDV_APPV_APP= STMID=='MOB' ? '1.0.63' : STMID=='INVC' ? '1.0.22' : STMID=='EORD' ? '1.0.9' : '1.0.20';
String APP_V= STMID=='MOB' ? '1.0.63' :
STMID=='INVC' ? '1.0.22' :
STMID=='EORD' ? '1.0.9' :
'1.0.20';


var APPNAMECOM= STMID=='REP' ? "com.elitesoftsys.emobilepro" :
STMID=='INVC' ? "com.elite.inventory" :
STMID=='EORD' ? "com.elite.eorder" :
STMID=='COU' ? "com.elitesoftsys.station" :
"com.elitesoftsys.emobilepro";


var ShareApp= TYPEPHONE=="ANDROID"?
'https://play.google.com/store/apps/details?id=${APPNAMECOM}':
STMID=='MOB' ? 'https://apps.apple.com/sa/app/emobile-pro/id6479583470?l=ar' :
STMID=='INVC'? 'https://apps.apple.com/sa/app/elite-inventory/id6468591333?l=ar' :
STMID=='COU'? 'https://apps.apple.com/sa/app/estation/id6480013599?l=ar' :
'https://apps.apple.com/sa/app/eorder/id6479821455?l=ar';

const String ImagePath="Assets/image/";
String SignPicture='${LoginController().AppPath}Media/EMobileProSign.png';
String SignPicture_MAT='${LoginController().AppPath}Media/';
const String ImagePathPDF="Assets/image/NO_IMG.jpg";
const String ImageEORDPOS="Assets/image/EORDPOS.png";
const String ImageSaudi_Riyal="Assets/image/Saudi_Riyal_Symbol.png";
final List<Map> josnStatus = [
  {"id": "1", "name": "Stringfinal".tr},
  {"id": "2", "name": "StringNotfinal".tr},
];
final List<Map> JosnStatusApproved = [
  {"id": "1", "name": 'StringAMMST1'.tr},
  {"id": "2", "name": 'StringNotApprove'.tr},
];

final String selectedDatereportnow= DateFormat('dd-MM-yyyy hh:mm').format(DateTime.now());

void printLongText(longText) {
  //String longText = 'هذا نص طويل جداً جداً. ' * 100; // تكرار النص لزيادة الطول
  // يمكنك تقسيم النص إلى أجزاء صغيرة إذا كان طويلاً جداً
  for (int i = 0; i < longText.length; i += 100) {
    print(longText.toString().substring(i, i + 100 > longText.length
        ? longText.length
        : i + 100));
  }
}
