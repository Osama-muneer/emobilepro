// import 'package:bluetooth_print/bluetooth_print.dart';
// import 'package:bluetooth_print/bluetooth_print_model.dart';
import '../../../Setting/controllers/setting_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class Print_View extends StatefulWidget {
  const Print_View({Key? key}) : super(key: key);
  @override
  State<Print_View> createState() => _Print_ViewState();
}

class _Print_ViewState extends State<Print_View> {
  final StteingController controller = Get.find();
  // BluetoothPrint bluetoothPrint = BluetoothPrint.instance;
  // List<BluetoothDevice> _devices = [];
  String _devicesMsg ="";
  late bool _connected;
  final f = NumberFormat("\$###,###.00", "en_US");
  final GlobalKey<RefreshIndicatorState> _refreshIndicatorKey =
  new GlobalKey<RefreshIndicatorState>();

  void initState() {
    // TODO: implement initState
    super.initState();
   // WidgetsBinding.instance.addPostFrameCallback((timeStamp) { initPrinter(); });
  }

  // Future<void> initPrinter() async{
  //   bluetoothPrint.startScan(timeout: Duration(seconds: 2));
  //   if (!mounted) return;
  //   bluetoothPrint.scanResults.listen((val) {
  //     if (!mounted) return;
  //     setState(() {_devices = val; });
  //     print('_devices');
  //     print(_devices);
  //     if(_devices.isEmpty) setState(() {
  //       _devicesMsg= "No Devices";
  //     });
  //   });
  // }
  // Future<void> _refresh() {
  //   return  initPrinter();
  // }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("StrinSelect_Printer".tr,style: TextStyle(color: Colors.white),),
          backgroundColor: Colors.redAccent,
          iconTheme: IconThemeData(color: Colors.white),
        ),
        body:Container()// This trailing comma makes auto-formatting nicer for build methods.
    );
  }
  bool _isLoading = false;

}
