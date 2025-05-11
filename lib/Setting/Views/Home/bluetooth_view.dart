import '../../../Setting/Views/Home/print_view.dart';
import 'package:flutter/material.dart';
import 'package:blue_thermal_printer/blue_thermal_printer.dart';

class BluetoothSerialPermission extends StatefulWidget {
  const BluetoothSerialPermission({Key? key}) : super(key: key);

  @override
  State<BluetoothSerialPermission> createState() => _BluetoothSerialPermissionState();
}

class _BluetoothSerialPermissionState extends State<BluetoothSerialPermission> {
  final BlueThermalPrinter bluetooth = BlueThermalPrinter.instance;

  @override
  void initState() {
    super.initState();
    checkBluetoothStatus();
  }

  // التحقق مما إذا كان البلوتوث مفعلًا
  void checkBluetoothStatus() async {
    bool? isEnabled = await bluetooth.isAvailable;

    if (!isEnabled!) {
      // البلوتوث غير مفعل، يمكن للمستخدم تفعيله يدويًا
      // سيتم الانتقال إلى شاشة الطباعة مباشرة
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (_) => const Print_View()),
      );
    } else {
      // البلوتوث مفعل، يمكن متابعة الإجراءات
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (_) => const Print_View()),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(child: CircularProgressIndicator()),
    );
  }
}
