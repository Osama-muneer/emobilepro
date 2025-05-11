import '../../../Setting/controllers/setting_controller.dart';
import 'package:flutter/material.dart';
import 'dart:async';
import 'package:blue_thermal_printer/blue_thermal_printer.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';


class Bule_Print_View extends StatefulWidget {
  const Bule_Print_View({Key? key}) : super(key: key);
  @override
  State<Bule_Print_View> createState() => _Bule_Print_ViewState();
}

class _Bule_Print_ViewState extends State<Bule_Print_View> {
  final StteingController controller = Get.find();
  BlueThermalPrinter bluetooth = BlueThermalPrinter.instance;

  List<BluetoothDevice> _devices = [];
  BluetoothDevice? _device;
  bool _connected = false;

  @override
  void initState() {
    super.initState();
    initPlatformState();
  }

  Future<void> initPlatformState() async {
    bool? isConnected = await bluetooth.isConnected;
    List<BluetoothDevice> devices = [];
    try {
      devices = await bluetooth.getBondedDevices();
    } on PlatformException {}

    bluetooth.onStateChanged().listen((state) {
      switch (state) {
        case BlueThermalPrinter.CONNECTED:
          setState(() {
            _connected = true;
            print("bluetooth device state: connected");
          });
          break;
        case BlueThermalPrinter.DISCONNECTED:
          setState(() {
            _connected = false;
            print("bluetooth device state: disconnected");
          });
          break;
        case BlueThermalPrinter.DISCONNECT_REQUESTED:
          setState(() {
            _connected = false;
            print("bluetooth device state: disconnect requested");
          });
          break;
        case BlueThermalPrinter.STATE_TURNING_OFF:
          setState(() {
            _connected = false;
            print("bluetooth device state: bluetooth turning off");
          });
          break;
        case BlueThermalPrinter.STATE_OFF:
          setState(() {
            _connected = false;
            print("bluetooth device state: bluetooth off");
          });
          break;
        case BlueThermalPrinter.STATE_ON:
          setState(() {
            _connected = false;
            print("bluetooth device state: bluetooth on");
          });
          break;
        case BlueThermalPrinter.STATE_TURNING_ON:
          setState(() {
            _connected = false;
            print("bluetooth device state: bluetooth turning on");
          });
          break;
        case BlueThermalPrinter.ERROR:
          setState(() {
            _connected = false;
            print("bluetooth device state: error");
          });
          break;
        default:
          print(state);
          break;
      }
    });

    if (!mounted) return;
    setState(() {
      _devices = devices;
    });

    if (isConnected == true) {
      setState(() {
        _connected = true;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("StrinSelect_Printer".tr,style: TextStyle(color: Colors.white)),
        backgroundColor: Colors.redAccent,
        iconTheme: IconThemeData(color: Colors.white),
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: () async {
              initPlatformState();
            },
          ),
        ],
      ),
      body: _devices.isEmpty?Center(child: Text('No Device'),):
      Container(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: ListView.builder(
            itemCount:  _devices.length,
            itemBuilder: (c,i){
              return ListTile(
                leading: Icon(Icons.print),
                title: Text(_devices[i].name!),
                subtitle: Text(_devices[i].address!),
               // trailing: Text( _connected ?'disconnect':'connect',style: TextStyle(color:_connected ?Colors.red:Colors.green ),),
                onTap: () async {
                    _device = _devices[i];
                    await  Future.delayed(new Duration(milliseconds: 100));
                   _connect();
                 //   _connected ? _disconnect() : _connect();
                    StteingController().SET_P('Printer_Name',_devices[i].address.toString());
                    controller.PrintController.text=_devices[i].name.toString();
                    StteingController().SET_P('Printer',_devices[i].name.toString());
                    sample();
                    controller.update();
                    //  Navigator.of(context).pop(false);
                },
              );
            },
          ),
        ),
      ),
    );
  }

  List<DropdownMenuItem<BluetoothDevice>> _getDeviceItems() {
    List<DropdownMenuItem<BluetoothDevice>> items = [];
    if (_devices.isEmpty) {
      items.add(DropdownMenuItem(
        child: Text('NONE'),
      ));
    } else {
      _devices.forEach((device) {
        items.add(DropdownMenuItem(
          child: Text(device.name ?? ""),
          value: device,
        ));
      });
    }
    return items;
  }

  Future<void> _connect() async {
    print('_device');
    print(_device);
    if (_device != null) {
      await bluetooth.isConnected.then((isConnected) {
        print('isConnected');
        print(isConnected);
        if (isConnected == true) {
          bluetooth.connect(_device!).catchError((error) {
            setState(() => _connected = false);
          });
          setState(() => _connected = true);
        }else{
          bluetooth.connect(_device!);
        }
      });
    } else {
      show('No device selected.');
    }
  }

  void _disconnect() {
    bluetooth.disconnect();
    setState(() => _connected = false);
  }

  Future show(
      String message, {
        Duration duration = const Duration(seconds: 3),
      }) async {
    await new Future.delayed(new Duration(milliseconds: 100));
    ScaffoldMessenger.of(context).showSnackBar(
      new SnackBar(
        content: new Text(
          message,
          style: new TextStyle(
            color: Colors.white,
          ),
        ),
        duration: duration,
      ),
    );
  }

  sample() async {
    bluetooth.isConnected.then((isConnected) {
      if (isConnected == true) {
        bluetooth.printNewLine();
        // bluetooth.printCustom("TEST", Size.boldMedium.val, Align_Print.center.val);
        bluetooth.printNewLine();
        bluetooth.printNewLine();//path of your image/logo
        bluetooth.printNewLine();//path of your image/logo
        bluetooth.printNewLine();//path of your image/logo
        //bluetooth.drawerPin2(); // or you can use bluetooth.drawerPin5();
      }
    });
  }

}