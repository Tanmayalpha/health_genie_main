 import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_blue_plus/flutter_blue_plus.dart';
import 'package:fluttertoast/fluttertoast.dart';
 import 'package:health_genie/helper/colors.dart';
import 'package:health_genie/screens/Device_List.dart';
import 'package:health_genie/utils/snackbar.dart';

import 'DEVICE_sCREEN/connected_device_tile.dart';
import 'DEVICE_sCREEN/device_screen.dart';
import 'DEVICE_sCREEN/scan_result_tile.dart';

 class SmartDevice extends StatefulWidget {
   const SmartDevice({super.key});
   @override
  State<SmartDevice> createState() => _SmartDeviceState();
 }

 class _SmartDeviceState extends State<SmartDevice> {
 List smartDeviceList = [
    {
     "firstName": "Body Fat",
     "lastName": " Analyzers",
     "image": "assets/images/12-1133.png",
    },
    {
    "firstName": "Weighing",
      "lastName": " Scale",
      "image": "assets/images/81E9JTIsCIL._SL1500_.jpg.png",
    },
    {
      "firstName": "Blood Pressure",
      "lastName": "Monitor",
      "image":
         "assets/images/omron-hem-7113-automatic-blood-pressure-monitor-2 (1).png",
    },
    {
     "firstName": "Camera Door",
     "lastName": "bell",
     "image": "assets/images/81E9JTIsCIL._SL1500_.jpg.png",
    },
    {
      "firstName": "Smart",
      "lastName": "Switches",
      "image": "assets/images/niscomed-fpo-50-pulse-oximeter-2.png",
    },
     {
      "firstName": "Smart",
     "lastName": "Plug",
      "image": "assets/images/51G-xrIXsKL._SL1480_.jpg.png",
    },
    {
      "firstName": "Blood Glucose",
     "lastName": "Monitor",
      "image":
         "assets/images/Omron-Blood-Glucose-Monitor-HGM-SDL337008205-1-fd92a.png",    },
    {
      "firstName": "Smart IR",
       "lastName": "",
       "image": "assets/images/41NGJcWpRWL.png",
   },
  ];



 List<BluetoothDevice> _connectedDevices = [];
 List<ScanResult> _scanResults = [];
 late StreamSubscription<List<ScanResult>> _scanResultsSubscription;
 late StreamSubscription<bool> _isScanningSubscription;

 @override
  void initState() {
    // TODO: implement initState
    super.initState();

    /*FlutterBluePlus.connectedSystemDevices.then((devices) {
      _connectedDevices = devices;
      setState(() {});
    });

    _scanResultsSubscription = FlutterBluePlus.scanResults.listen((results) {
      _scanResults = results;

      setState(() {});
    });

    _isScanningSubscription = FlutterBluePlus.isScanning.listen((state) {
      setState(() {});
    });
*/
  }

 @override
 void dispose() {
  // _scanResultsSubscription.cancel();
  // _isScanningSubscription.cancel();
   super.dispose();
 }
  @override
  Widget build(BuildContext context) {
    return ScaffoldMessenger(
       key: Snackbar.snackBarKeyB,
      child: Scaffold(
       // floatingActionButton: buildScanButton(context),
        appBar: AppBar(
          title: const Text('Find Devices'),
        ),

        body: RefreshIndicator(
          onRefresh: onRefresh,
          child: SingleChildScrollView(
            child: Column(
              children: [
                Container(
                   padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 20),
                   decoration: const BoxDecoration(
                     border: Border(             top: BorderSide(
                        color: colors.primary,
                       width: 2,
                      ),
                  ),
                 ),
                   child: GridView.builder(
                       shrinkWrap: true,
                       itemCount: smartDeviceList.length,
                       gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                         mainAxisExtent: MediaQuery.of(context).size.height * 0.18,
                         crossAxisCount: 3, // number of items in each row
                         mainAxisSpacing: 0.0, // spacing between rows
                         crossAxisSpacing: 0.0, // spacing between columns
                       ),
                       // padding: EdgeInsets.all(20.0),
                       // weddingCardList?.data?.length == null
                       //     ? 0
                       //     : weddingCardList?.data?[0].templates!.length,

                       // scrollDirection: Axis.vertical,
                       itemBuilder: (BuildContext context, int index) {
                         return InkWell(
                           onTap: () {
                             /*if(FlutterBluePlus.isScanningNow){
                               onStopPressed();
                             }else{
                               onScanPressed();
                             }*/


                             if('Weighing' == smartDeviceList[index]["firstName"]) {
                               Navigator.push(context, MaterialPageRoute(builder: (context) => const DeviceListScreen(),));
                             }else {
                               Fluttertoast.showToast(msg: 'Device not available');
                             }

                           },
                           child: Card(
                             elevation: 2,
                             shape: RoundedRectangleBorder(
                               borderRadius: BorderRadius.circular(5.0),
                             ),
                             child: Container(
                               padding: const EdgeInsets.symmetric(
                                 horizontal: 10,
                               ),
                               decoration: BoxDecoration(
                                   borderRadius: BorderRadius.circular(10),
                                   color: Colors.white),
                               child: Column(
                                 children: [
                                   Container(
                                     height: MediaQuery.of(context).size.height * 0.12,
                                     decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(15),
                                        image: DecorationImage(
                                           image:
                                               AssetImage(smartDeviceList[index]["image"]),
                                         )),
                                   ),
                                   Container(
                                     child: Text(   smartDeviceList[index]["firstName"],
                                       style: TextStyle(
                                         fontSize: 12,
                                       ),
                                     ),
                                   ),
                                   Container(
                                     child: Text(
                                       smartDeviceList[index]["lastName"],
                                       style: TextStyle(
                                         fontSize: 12,
                                       ),
                                     ),
                                  )
                                 ],
                               ),
                             ),
                           ),
                         );             })       ),
              //  ..._buildConnectedDeviceTiles(context),
               // ..._buildScanResultTiles(context),


              ],
            ),
          ),
        ),
      ),
    );
 }


 Future onScanPressed() async {
   try {
     await FlutterBluePlus.startScan(timeout: const Duration(seconds: 400));
   } catch (e) {
     Snackbar.show(ABC.b, prettyException("Start Scan Error:", e), success: false);
   }
   setState(() {}); // force refresh of connectedSystemDevices
 }

 Future onStopPressed() async {
   try {
     FlutterBluePlus.stopScan();
   } catch (e) {
     Snackbar.show(ABC.b, prettyException("Stop Scan Error:", e), success: false);
   }
 }

 void onConnectPressed(BluetoothDevice device) {
   MaterialPageRoute route = MaterialPageRoute(
       builder: (context) {
         device.connect().catchError((e) {
           Snackbar.show(ABC.c, prettyException("Connect Error:", e), success: false);
         });
         return DeviceScreen(device: device);
       },
       settings: RouteSettings(name: '/DeviceScreen'));
   Navigator.of(context).push(route);
 }

 Future onRefresh() {
   if (FlutterBluePlus.isScanningNow == false) {
     FlutterBluePlus.startScan(timeout: const Duration(seconds: 100));
   }
   setState(() {});
   return Future.delayed(const Duration(milliseconds: 500));
 }

 Widget buildScanButton(BuildContext context) {
   if (FlutterBluePlus.isScanningNow) {
     return FloatingActionButton(
       onPressed: onStopPressed,
       backgroundColor: Colors.red,
       child: const Icon(Icons.stop),
     );
   } else {
     return FloatingActionButton(onPressed: onScanPressed, child: const Text("SCAN"));
   }
 }

 List _buildConnectedDeviceTiles(BuildContext context) {
   return _connectedDevices
       .map(
         (d) => ConnectedDeviceTile(
       device: d,
       onOpen: () => Navigator.of(context).push(
         MaterialPageRoute(
           builder: (context) => DeviceScreen(device: d),
           settings: const RouteSettings(name: '/DeviceScreen'),
         ),
       ),
       onConnect: () => onConnectPressed(d),
     ),
   )
       .toList();
 }

 List _buildScanResultTiles(BuildContext context) {
   List<ScanResult> _l = _scanResults.where((ScanResult element) => element.advertisementData.localName == 'EL2').toList();
   return _l
       .map(
         (r) => ScanResultTile(
       result: r,
       onTap: () => onConnectPressed(r.device),
     ),
   )
       .toList();
 }


 }