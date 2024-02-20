import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_blue_plus/flutter_blue_plus.dart';

class ScanResultTile extends StatefulWidget {
  const ScanResultTile({Key? key, required this.result, this.onTap}) : super(key: key);

  final ScanResult result;
  final VoidCallback? onTap;

  @override
  State<ScanResultTile> createState() => _ScanResultTileState();
}

class _ScanResultTileState extends State<ScanResultTile> {
  BluetoothConnectionState _connectionState = BluetoothConnectionState.disconnected;

  late StreamSubscription<BluetoothConnectionState> _connectionStateSubscription;

  @override
  void initState() {
    super.initState();
    //convertweight();
    _connectionStateSubscription = widget.result.device.connectionState.listen((state) {
      _connectionState = state;
      setState(() {});
    });
   // convertweight();
  }

  @override
  void dispose() {
    _connectionStateSubscription.cancel();
    super.dispose();
  }

  int hexToDecimal(String hexString) {
    return int.parse(hexString, radix: 16);
  }

  String getNiceHexArray(List<int> bytes) {
    return '[${bytes.map((i) => i.toRadixString(16).padLeft(2, '0')).join(', ')}]' +
        '\n' +
        '\n' +
        '\n' +
        '[${bytes.map((i) => hexToDecimal(i.toRadixString(16).padLeft(2, '0')))}]';
  }

  String getNiceManufacturerData(Map<int, List<int>> data) {
    if (data.isEmpty) {
      return 'N/A';
    }
    return data.entries
        .map((entry) => '${entry.key.toRadixString(16)}: ${getNiceHexArray(entry.value)}')
        .join(', ')
        .toUpperCase();
  }

  String getNiceServiceData(Map<String, List<int>> data) {
    if (data.isEmpty) {
      return 'N/A';
    }
    return data.entries.map((v) => '${v.key}: ${getNiceHexArray(v.value)}').join(', ').toUpperCase();
  }

  String getNiceServiceUuids(List<String> serviceUuids) {
    return serviceUuids.isEmpty ? 'N/A' : serviceUuids.join(', ').toUpperCase();
  }

  bool get isConnected {
    return _connectionState == BluetoothConnectionState.connected;
  }

  Widget _buildTitle(BuildContext context) {
    if (widget.result.device.name.isNotEmpty) {
      return Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            widget.result.device.name,
            overflow: TextOverflow.ellipsis,
          ),
          Text(
            widget.result.device.remoteId.toString(),
            style: Theme.of(context).textTheme.bodySmall,
          )
        ],
      );
    } else {
      return Text(widget.result.device.remoteId.toString());
    }
  }

  Widget _buildConnectButton(BuildContext context) {
    return ElevatedButton(
      child: isConnected ? const Text('OPEN') : const Text('CONNECT'),
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.black,
        foregroundColor: Colors.white,
      ),
      onPressed: (widget.result.advertisementData.connectable) ? widget.onTap : null,
    );
  }

  Widget _buildAdvRow(BuildContext context, String title, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 4.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(title, style: Theme.of(context).textTheme.bodySmall),
          const SizedBox(
            width: 12.0,
          ),
          Expanded(
            child: Text(
              value,
              style: Theme.of(context).textTheme.bodySmall?.apply(color: Colors.black),
              softWrap: true,
            ),
          ),

        ],
      ),
    );
  }

  List _getManufacturerDataList(Map<int, List<int>> data) {
    if (data.isEmpty) {
      return [];
    }
    List<String> res = [];
    data.forEach((id, bytes) {
      res.add(_getHexString(bytes));
    });
    return res;
  }

  //get Hex String from bytes
  String _getHexString(List<int> bytes) {
    return bytes.map((i) => i.toRadixString(16).padLeft(2, '0')).join(',').toUpperCase();
  }


  void convertweight(List<int> byteData) {

    //[0x02, 0xB1, 0x3E, 0x23, 0x8A, 0x7C, 0x09, 0xEB, 0x2D, 0x1C, 0x02, 0x23, 0x1D, 0x2E, 0x5D, 0x82, 0xDA, 0x8B, 0x15, 0x41, 0x67, 0x51, 0x18, 0x25];
    //[0x02, 0xB1, 0x3E, 0x23, 0x8A, 0x7C, 0x09, 0xEB, 0x2D, 0x1C, 0x02, 0x23, 0x1D, 0x2E, 0x5D, 0x82, 0xDA, 0x8B, 0x15, 0x41, 0x67, 0x51, 0x18, 0x25];

    // Assuming each BMI value is a 32-bit floating-point number (4 bytes)
    int bytesPerValue = 4;

    // Calculate the number of BMI values in the byte data
    int numValues = byteData.length ~/ (2 * bytesPerValue);

    // Create a Uint8List view on the original byte data
    Uint8List byteList = Uint8List.fromList(byteData);

    // Create a Float32List view on the byte data for BMI values
    Float32List bmiData = Float32List.view(byteList.buffer);

    // Create a Float32List view on the byte data for weight values
    Float32List weightData = Float32List.view(byteList.buffer, numValues * bytesPerValue);

    // Print the BMI values and corresponding weights
    for (int i = 0; i < numValues; i++) {
      print('BMI $i: ${bmiData[i]}, Weight $i: ${weightData[i]} kg ____________________________');
    }
  }
  double _weighFromScale = 0.0;

  void _readWeightData(ScanResult result) {
    var t = _getManufacturerDataList(result.advertisementData.manufacturerData);

    List temp = t[0].split(',');



    String kashf= temp[10];

    int weightInInt = int.parse(kashf, radix: 16);


    List<int> byteValues = temp.map((hexString) => int.parse(hexString, radix: 16)).toList();



     convertweight(byteValues);
    _weighFromScale = weightInInt / 100;
  //  print('${ _weighFromScale}____________weight}') ;

    if (byteValues.isNotEmpty) {
      //get Hex String from dataList
      // [02, B1, 3E, 23, 8A, 7C, 09, EB, 2D, 1C, 02, 23, 1D, 2E, 5D, 82, DA, 8B, 15, 41, 67, 51, 18, 25]
      // and convert to list

      //here we are swapping the hex value example. 8B15 to 158B
      // 8B=>17th index and 15=>18th index in hexList
      // String hexString = temp[7] + temp[6];

      // //int value after parsing hexString to int
      // // example. 158B = > 5515 (shows 55.15 kg in bluetooth scale device and unit is kg)
      // //NOTE - bluetooth device sends weight data in kg unit
      // int weightInInt = int.parse(hexString, radix: 16);

      int weightIntLE = (byteValues[3] << 24) | (byteValues[2] << 16) | (byteValues[1] << 8) | byteValues[0];

      ByteData byteData = ByteData.sublistView(Uint8List.fromList(byteValues));
      double weightFloatLE = byteData.getFloat32(0, Endian.little);

      double scale = 0.001;

      double scaledWeightIntLE = weightIntLE * scale;
      double scaledWeightFloatLE = weightFloatLE * scale;

      // //divide the (weightInInt / 100 ) => example. (5515 /100 = 55.15)
      // //to get  final weight we get in bluetooth scale to display in the app
      // _weighFromScale = weightInInt / 100;

      // Assuming weight is encoded in the first two bytes (little-endian)
//      print('___________${byteValues}__________');

      //print("Weight as little-endian 32-bit integer: $scaledWeightIntLE kg");
    //  print("Weight as 32-bit float (little-endian): $scaledWeightFloatLE kg");

      //int weightGrams = byteValues[15] + byteValues[14] +  byteValues[13] +byteValues[16];
     //int data =  (byteValues[7] << 8) + byteValues[8];

  //double weightKg = weightGrams / 100.0; // Convert grams to kilograms
      


      //print('Weight: $weightKg KG');

     // _weighFromScale = weightKg;

      setState(() {});

      //refresh UI
    }
  }
  int a=0;
  double getKgWeight(List<int> data, index) {
    a++;
    print("${a}_______________aaaaaaaaaaaaaaa__________");
    return (( 0xff & data[index + 1] ) << 8 | ( 0xff & data[index] ) << 0 ) * 0.005;
  }
  @override
  Widget build(BuildContext context) {
    var adv = widget.result.advertisementData;

   _readWeightData(widget.result);

    //return Text('${_weighFromScale}');
    return ExpansionTile(
      title: _buildTitle(context),
      leading: Text(widget.result.rssi.toString()),
      trailing: _buildConnectButton(context),
      children: <Widget>[
        _buildAdvRow(context, 'Complete Local Name', adv.localName),
        _buildAdvRow(context, 'Tx Power Level', '${adv.txPowerLevel ?? 'N/A'}'),
        _buildAdvRow(context, 'Manufacturer Data', getNiceManufacturerData(adv.manufacturerData)),
        //_buildAdvRow(context, 'Service UUIDs', getNiceServiceUuids(adv.serviceUuids)),
        //_buildAdvRow(context, 'Service Data', getNiceServiceData(adv.serviceData)),
        _buildAdvRow(context, 'Connectable', adv.connectable.toString()),
        _buildAdvRow(context, 'Weight In Kg', _weighFromScale.toString()),
      ],
    );
  }




}
