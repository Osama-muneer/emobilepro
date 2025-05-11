import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'theme_helper.dart';

class Dropdown extends StatelessWidget {
  const Dropdown({
    Key? key,
    required this.josnStatus, this.SelectDataStatus,required this.GETSTRING
  }) : super(key: key);

  final List<Map> josnStatus;
  final String? SelectDataStatus;
  final String? GETSTRING;

  @override
  Widget build(BuildContext context) {
    final alwaysStoppedAnimationCircularProgress = Color(0xFFF1F4F6);
    final backgroundColorCircularProgress = Color(0xFF2196F3);
    return DropdownButtonFormField2(
      decoration: InputDecoration(
        isDense: true,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15),
        ),
      ),
      isExpanded: true,
      hint: ThemeHelper().buildText(context,'$GETSTRING', Colors.grey,'S'),
      // icon:  CircularProgressIndicator(
      //   valueColor: AlwaysStoppedAnimation(alwaysStoppedAnimationCircularProgress),
      //   backgroundColor:backgroundColorCircularProgress,
      // ),
      // iconSize: 25.sp,
      // buttonHeight: 50.h,
      // buttonPadding: EdgeInsets.only(left: 20.w, right: 10.w),
      // dropdownDecoration: BoxDecoration(
      //   borderRadius: BorderRadius.circular(15),
      // ),
      value: SelectDataStatus,
      items: josnStatus
          .map((item) => DropdownMenuItem<String>(
        value: item['id'],
        child:  Text(
          'StringStoch'.tr,
          style: ThemeHelper().buildTextStyle(context, Colors.black,'M'),
        ),
      ))
          .toList(),
      validator: (value) {
        if (value == null) {
          return 'StringStoch'.tr;
        }
        return null;
      },

    );
  }
}
class Dropdown4 extends StatelessWidget {
  const Dropdown4({
    Key? key,
    required this.josnStatus, this.SelectDataStatus,
  }) : super(key: key);

  final List<Map> josnStatus;
  final String? SelectDataStatus;

  @override
  Widget build(BuildContext context) {
    final alwaysStoppedAnimationCircularProgress = Color(0xFFF1F4F6);
    final backgroundColorCircularProgress = Color(0xFF2196F3);
    return DropdownButtonFormField2(
      decoration: InputDecoration(
        isDense: true,
        focusColor: Colors.blueAccent,
        fillColor: Colors.white,
        filled: true,
      
        focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(100.0), borderSide: BorderSide(color: Colors.grey)),
    enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(100.0), borderSide: BorderSide(color: Colors.grey.shade400)),
    errorBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(100.0), borderSide: BorderSide(color: Colors.red, width: 2.0)),
    focusedErrorBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(100.0), borderSide: BorderSide(color: Colors.red, width: 2.0)),

    ),
      isExpanded: true,
      hint: Row(
        children: [
          Icon(
            Icons.account_balance,
            color: Colors.black45,
            size: 22,
          ),
          SizedBox(
            width: 5,
          ),
          Text(
            'StringChicJTID'.tr,
            style: TextStyle(fontFamily: 'Hacen', fontSize:15),
          ),
        ],
      ),
      // icon: const Icon(
      //   Icons.arrow_drop_down,
      //   color: Colors.black45,
      // ),
      // iconSize: 25.sp,
      // buttonHeight: 45.h,
      // buttonPadding:
      //  EdgeInsets.only(left: 10.w, right: 10.w),
      // dropdownDecoration: BoxDecoration(
      //   borderRadius: BorderRadius.circular(15),
      // ),
      value: SelectDataStatus,
      items: josnStatus
          .map((item) => DropdownMenuItem<String>(
        value: item['id'],
        child:  Text(
          'StringvalidateJTID'.tr,
          style: ThemeHelper().buildTextStyle(context, Colors.black,'M'),
        ),
      ))
          .toList(),
      validator: (value) {
        if (value == null) {
          return 'StringvalidateJTID'.tr;
        }
        return null;
      },

    );
  }
}
class Dropdown2 extends StatelessWidget {
  const Dropdown2({
    Key? key,
    required this.josnStatus, this.SelectDataStatus,
  }) : super(key: key);

  final List<Map> josnStatus;
  final String? SelectDataStatus;

  @override
  Widget build(BuildContext context) {
    return DropdownButtonFormField2(
      isExpanded: true,
      hint: ThemeHelper().buildText(context,'StringMUID', Colors.grey,'S'),
      // icon: const Icon(
      //   Icons.arrow_drop_down,
      //   color: Colors.black45,
      // ),
      // iconSize: Dimensions.iconSize35,
      // buttonPadding: EdgeInsets.only( right: Dimensions.width5),
      // dropdownDecoration: BoxDecoration(borderRadius: BorderRadius.circular(Dimensions.width5),),
      value: SelectDataStatus,
      style: const TextStyle(fontFamily: 'Hacen', color: Colors.black),
      items: josnStatus
          .map((item) => DropdownMenuItem<String>(
        value: item['id'],
        child:  Text(
          "لاتوجد بيانات",
          style: ThemeHelper().buildTextStyle(context, Colors.black,'M'),
        ),
      ))
          .toList(),
      validator: (value) {
        if (value == null) {
          return 'StringvalidateMUID'.tr;
        }
        return null;
      },

    );
  }
}
class Dropdown3 extends StatelessWidget {
  const Dropdown3({
    Key? key,
    required this.josnStatus, this.SelectDataStatus,
  }) : super(key: key);

  final List<Map> josnStatus;
  final String? SelectDataStatus;

  @override
  Widget build(BuildContext context) {
    return DropdownButtonFormField2(
      isExpanded: true,
      hint: ThemeHelper().buildText(context,'StringSMDED', Colors.grey,'S'),
      value: SelectDataStatus,
      style: const TextStyle(fontFamily: 'Hacen', color: Colors.black),
      items: josnStatus
          .map((item) => DropdownMenuItem<String>(
        value: item['id'],
        child:  Text(
          "لاتوجد بيانات",
          style: ThemeHelper().buildTextStyle(context, Colors.black,'M'),
        ),
      ))
          .toList(),
      validator: (value) {
        if (value == null) {
          return 'StringvalidateMUID'.tr;
        }
        return null;
      },

    );
  }
}
