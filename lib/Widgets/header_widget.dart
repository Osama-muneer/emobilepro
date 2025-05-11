// This widget will draw header section of all page. Wich you will get with the project source code.
import 'dart:io';
import '../../../Widgets/theme_helper.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../../../Setting/controllers/login_controller.dart';
import 'package:intl/intl.dart';
import 'package:path_provider/path_provider.dart';
import 'colors.dart';
import 'config.dart';
class HeaderWidget extends StatefulWidget {
  final double _height;
  final bool _showIcon;

  const HeaderWidget(this._height, this._showIcon, {Key? key}) : super(key: key);

  @override
  _HeaderWidgetState createState() => _HeaderWidgetState(_height, _showIcon);
}
final List locale =[
  {'name':'Lan_Arabic'.tr,'locale': const Locale('ar')},
  {'name':'Lan_English'.tr,'locale': const Locale('en')},
];

updatelanguage(Locale locale){
  Get.back();
  Get.updateLocale(locale);
}

Future<dynamic> buildShowDialogLang(BuildContext context) {
  return Get.defaultDialog(
      title: "SettingLan".tr,
      content:Container(
        //width: double.maxFinite,
        height: 80,
        width: 200,
        child: ListView.separated(
          shrinkWrap: true,
            itemBuilder: (context,index){
            return GestureDetector(
                child: Text(locale[index]['name']),
              onTap: (){
                  print(locale[index]['name']);
                  print(locale[index]['locale']);
                  if(locale[index]['locale'].toString()=='ar'){
                    LoginController().SET_N_P('LAN',1);
                  }else{
                    LoginController().SET_N_P('LAN',2);
                  }
                  updatelanguage(locale[index]['locale']);
              },
            );
            },
            separatorBuilder: (context,index){
              return const Divider(
                color: Colors.blue,
              );
            },
            itemCount: locale.length),
      ),
      backgroundColor: Colors.white,
      radius: 40,
    // barrierDismissible: false,
  );
}

class _HeaderWidgetState extends State<HeaderWidget> {
  final double _height;
  final bool _showIcon;

  _HeaderWidgetState(this._height, this._showIcon);

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return  Stack(
      children: [
        ClipPath(
          clipper:  ShapeClipper(
              [
                Offset(width / 5, _height),
                Offset(width / 10 * 5, _height - 60),
                Offset(width / 5 * 4, _height + 20),
                Offset(width, _height - 18)
              ]
          ),
          child: Container(
            decoration:  BoxDecoration(
              gradient:  LinearGradient(
                  colors: [
                    AppColors.MainColor.withOpacity(0.4),
                    AppColors.MainColor.withOpacity(0.4),
                    // Theme.of(context).primaryColor.withOpacity(0.4),
                    // Theme.of(context).accentColor.withOpacity(0.4),
                  ],
                  begin: const FractionalOffset(0.0, 0.0),
                  end: const FractionalOffset(1.0, 0.0),
                  stops: const [0.0, 1.0],
                  tileMode: TileMode.clamp
              ),
            ),

          ),
        ),
        ClipPath(
          clipper:  ShapeClipper(
              [
                Offset(width / 3, _height + 20),
                Offset(width / 10 * 8, _height - 60),
                Offset(width / 5 * 4, _height - 60),
                Offset(width, _height - 20)
              ]
          ),
          child: Container(
            decoration:  BoxDecoration(
              gradient:  LinearGradient(
                  colors: [
                    AppColors.MainColor.withOpacity(0.4),
                    AppColors.MainColor.withOpacity(0.4),
                    // Theme.of(context).primaryColor.withOpacity(0.4),
                    // Theme.of(context).accentColor.withOpacity(0.4),
                  ],
                  begin: const FractionalOffset(0.0, 0.0),
                  end: const FractionalOffset(1.0, 0.0),
                  stops: const [0.0, 1.0],
                  tileMode: TileMode.clamp
              ),
            ),
          ),
        ),
        ClipPath(
          clipper:  ShapeClipper(
              [
                Offset(width / 5, _height),
                Offset(width / 2, _height - 40),
                Offset(width / 5 * 4, _height - 80),
                Offset(width, _height - 20)
              ]
          ),
          child: Container(
         //color: AppColors.MainColor,
            decoration:  BoxDecoration(
              gradient:  LinearGradient(
                  colors: [
                    AppColors.MainColor,
                    AppColors.MainColor,
                    // Theme.of(context).primaryColor,
                    // Theme.of(context).accentColor,
                  ],
                  begin: const FractionalOffset(0.0, 0.0),
                  end: const FractionalOffset(1.0, 0.0),
                  stops: const [0.0, 1.0],
                  tileMode: TileMode.clamp
              ),
            ),
          ),
        ),
        Visibility(
          visible: _showIcon,
          child: Padding(
            padding:  EdgeInsets.only(top: 0.025 * height,left: 0.03 * width,right: 0.03 * width),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [

                IconButton(icon: Icon(Icons.language_rounded, size:  0.06 * width,color:Colors.white),
                  onPressed: (){
                    ThemeHelper().showCustomBottomSheetLan(context);
                    //buildShowDialogLang(context);
                  }),
                InkWell(
                  child: Text('v ${APP_V}',style: TextStyle(color: Colors.white,fontSize: 14.sp),),
                  onTap: (){
                    print('InkWell');
                    if (LoginController().experimentalcopy == 1) {
                      Get.defaultDialog(
                        title: 'StringMestitle'.tr,
                        middleText: 'Stringexperimentalcopy'.tr,
                        backgroundColor: Colors.white,
                        radius: 40,
                        textCancel: 'StringOK'.tr,
                        cancelTextColor: Colors.blueAccent,
                      );
                    } else {
                      ThemeHelper().buildShowDialogimportDataBase(context,2);
                    }
                  },),
              ],
            ),
          ),
        ),
        Center(
          child: Container(
            margin: EdgeInsets.all(20.w),
            padding:  EdgeInsets.only(
              left: 5.w,
              top: 20.h,
              right: 5.w,
              bottom: 20.h,
            ),
            // decoration: BoxDecoration(
            //   // borderRadius: BorderRadius.circular(20),
            //   borderRadius: BorderRadius.only(
            //     topLeft: Radius.circular(100.h),
            //     topRight: Radius.circular(100.w),
            //     bottomLeft: Radius.circular(60.h),
            //     bottomRight: Radius.circular(60.h),
            //   ),
            //   border: Border.all(width: 4.w, color: Colors.white),
            // ),
           child: Image.asset(STMID=="EORD"?"${ImagePath}Eorder.jpg":
           STMID=="INVC"?"${ImagePath}Store.png":
           STMID=="COU"?"${ImagePath}Station.png":
           "${ImagePath}EMobile.png",
            //child: Image.asset("/data/data/com.elitesoftsys.emobilepro/app_flutter/2023_05_13_11_53_28.png",
              fit: BoxFit.cover,
              height: 150,
              width: 120,
            ),
          ),
        ),
      ],
    );
  }
}


Future<File> getImageFileFromAssets(String path) async {
  final byteData = await rootBundle.load('Assets/image/$path');
  final buffer = byteData.buffer;
  Directory tempDir = await getTemporaryDirectory();
  String tempPath = tempDir.path;
  var filePath = '$tempPath/file_01.tmp'; // file_01.tmp is dump file, can be anything
  print('filePath');
  print(filePath);
  return File(filePath)
      .writeAsBytes(buffer.asUint8List(byteData.offsetInBytes,
      byteData.lengthInBytes));
}

Future<void> getUserImage() async {
  XFile? profileimage;
  final pickedFile = await ImagePicker().pickImage(source: ImageSource.gallery);

  final Directory path = await getApplicationDocumentsDirectory();
  final String imgpath = path.path;
 // FilePickerResult? result = await FilePicker.platform.pickFiles();
  Directory directory = await getApplicationDocumentsDirectory();
  //var dbPath = join(directory.path, "app.txt");

  if (pickedFile != null) {
    profileimage = await XFile(pickedFile.path);
    print(imgpath);
    print(pickedFile.path);
    print('profileimage');
    String date = DateFormat("yyyy_MM_dd_hh_mm_ss").format(DateTime.now());
    await pickedFile.saveTo('$imgpath/$date.png');
    getImageFileFromAssets(date);
    print('$imgpath/$date.jpeg');
         // String newPath = "${result.files.single.path}";
         // File backupFile = File(newPath);
         //  backupFile.copy(recoveryPath);
         // print(newPath);

  } else {
    print("No image selected");
  }
}

void getImage({required ImageSource source}) async {
  final XFile? file = await ImagePicker().pickImage(
      source: source, maxWidth: 640, maxHeight: 480, imageQuality: 70 //0-100
  );
  // getting a directory path for saving
  final Directory path = await getApplicationDocumentsDirectory();
  final String imgpath = path.path;
  var imageFile;
  // File temp = file as File;
  String date = DateFormat("yyyy_MM_dd_hh_mm_ss").format(DateTime.now());
  await file!.saveTo('$imgpath/$date.jpeg');

    imageFile = File(file.path);
    print('imageFile');
    print(imageFile);

}

class ShapeClipper extends CustomClipper<Path> {
   List<Offset> _offsets = [];
  ShapeClipper(this._offsets);
  @override
  Path getClip(Size size) {
    var path =  Path();
    path.lineTo(0.0, size.height-20);
    // path.quadraticBezierTo(size.width/5, size.height, size.width/2, size.height-40);
    // path.quadraticBezierTo(size.width/5*4, size.height-80, size.width, size.height-20);

    path.quadraticBezierTo(_offsets[0].dx, _offsets[0].dy, _offsets[1].dx,_offsets[1].dy);
    path.quadraticBezierTo(_offsets[2].dx, _offsets[2].dy, _offsets[3].dx,_offsets[3].dy);

    // path.lineTo(size.width, size.height-20);
    path.lineTo(size.width, 0.0);
    path.close();


    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => false;
}
