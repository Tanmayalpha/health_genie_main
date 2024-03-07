import 'dart:convert';
import 'dart:io';
import 'dart:async';
import 'package:ailink/ailink.dart';
import 'package:ailink/model/param_body_fat_data.dart';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_blue_plus/flutter_blue_plus.dart';
import 'package:health_genie/helper/colors.dart';
import 'package:health_genie/screens/ailinkclasese/weightdata.dart';
import 'package:health_genie/screens/new_demo/new_plugin_demo_class.dart';
import 'package:health_genie/screens/smart_device.dart';

import 'ailinkclasese/brodcastutils.dart';
import 'ailinkclasese/fat_data.dart';
import 'ailinkclasese/parambodyfat.dart';

class HomePageWidget extends StatefulWidget {
  const HomePageWidget({super.key});

  @override
  State<HomePageWidget> createState() => _HomePageWidgetState();
}

class _HomePageWidgetState extends State<HomePageWidget> {
  final items = [
    Image.asset(
      'assets/images/Banner1.png',
      fit: BoxFit.fill,
    ),
    Image.asset(
      'assets/images/banner2.png',
      fit: BoxFit.fill,
    ),
    Image.asset(
      'assets/images/banner3.png',
      fit: BoxFit.fill,
    ),
  ];

  bool isSeen = false;

  int currentIndex = 0;
  static const platform = MethodChannel('samples.flutter.dev/battery');

  String _batteryLevel = 'Unknown battery level.';


  @override
  void initState() {
    // TODO: implement initState
    super.initState();

  }
  final _ailinkPlugin = Ailink();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: /*Column(children: [
        _buildNotSupportedWidget,
        _buildOperatorWidget,
        Expanded(child: _buildScanResultWidget)
      ],)*/
      Container(
        decoration: const BoxDecoration(
          border: Border(
            top: BorderSide(
              color: colors.primary,
              width: 2,
            ),
          ),
        ),
        child: ListView(
          children: [
            const SizedBox(
              height: 20,
            ),
            CarouselSlider(
              options: CarouselOptions(
                height: MediaQuery.of(context).size.height * 0.18,
                autoPlay: false,
                aspectRatio: 2.0,
                enlargeCenterPage: true,
                onPageChanged: (index, reason) {
                  setState(() {
                    currentIndex = index;
                  });
                },
              ),
              items: items,
            ),
            const SizedBox(
              height: 10,
            ),
            Center(
              child: Container(
                width: 50,
                height: 5.5,
                child: ListView.separated(
                  shrinkWrap: true,
                  itemCount: items.length,
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (context, index) {
                    return Container(
                      height: 0.5,
                      width: index == currentIndex ? 20 : 10,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: index == currentIndex
                            ? colors.primary
                            : Colors.grey,
                      ),
                    );
                  },
                  separatorBuilder: (context, index) {
                    return const SizedBox(
                      width: 5,
                    );
                  },
                ),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            Container(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: const Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Weighing Scale',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      "Show More",
                      style: TextStyle(
                        fontSize: 14,
                        color: colors.primary,
                      ),
                    )
                  ],
                )),
            const SizedBox(
              height: 10,
            ),
            Container(
              margin: EdgeInsets.only(
                  left: 20, right: MediaQuery.of(context).size.width * 0.7),
              padding: const EdgeInsets.all(15),
              decoration: BoxDecoration(
                // border: Border.all(
                //   color: Colors.grey,
                //   width: 1,
                // ),
                boxShadow: const [BoxShadow(color: Colors.grey, blurRadius: 2)],
                borderRadius: BorderRadius.circular(8),
                color: Colors.white,
              ),
              child: const Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Text(
                        '68.9',
                        style: TextStyle(
                          fontSize: 18,
                          color: colors.primary,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        'kg',
                        style: TextStyle(
                          fontSize: 12,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  Text(
                    'Weight',
                    style: TextStyle(
                      fontSize: 14,
                    ),
                  )
                ],
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            Container(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: const Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Body Fat Analyzer',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      "Show More",
                      style: TextStyle(
                        fontSize: 14,
                        color: colors.primary,
                      ),
                    )
                  ],
                )),
            const SizedBox(
              height: 10,
            ),
            Container(
                margin: const EdgeInsets.only(left: 20, right: 20),
                padding: const EdgeInsets.symmetric(vertical: 10),
                decoration: BoxDecoration(
                  // border: Border.all(
                  //   color: Colors.grey,
                  //   width: 1,
                  // ),
                  boxShadow: const [BoxShadow(color: Colors.grey, blurRadius: 1)],
                  borderRadius: BorderRadius.circular(8),
                  color: Colors.white,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    const Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Text(
                              '57.2',
                              style: TextStyle(
                                fontSize: 18,
                                color: colors.primary,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Text(
                              'kg',
                              style: TextStyle(
                                fontSize: 12,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        Text(
                          'Weight',
                          style: TextStyle(
                            fontSize: 14,
                          ),
                        )
                      ],
                    ),
                    Container(
                      height: 30,
                      width: 1,
                      color: Colors.grey,
                    ),
                    const Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          '2',
                          style: TextStyle(
                            fontSize: 18,
                            color: colors.primary,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        Text(
                          'BMI',
                          style: TextStyle(
                            fontSize: 14,
                          ),
                        )
                      ],
                    ),
                    Container(
                      height: 30,
                      width: 1,
                      color: Colors.grey,
                    ),
                    const Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          '3',
                          style: TextStyle(
                            fontSize: 18,
                            color: colors.primary,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        Text(
                          'BFR',
                          style: TextStyle(
                            fontSize: 14,
                          ),
                        )
                      ],
                    ),
                    Container(
                      height: 30,
                      width: 1,
                      color: Colors.grey,
                    ),
                    const Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          '4',
                          style: TextStyle(
                            fontSize: 18,
                            color: colors.primary,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        Text(
                          'Muscle Rate',
                          style: TextStyle(
                            fontSize: 14,
                          ),
                        )
                      ],
                    ),
                  ],
                ))

            // DotsIndicator(
            //   dotsCount: items.length,
            //   position: currentIndex.toDouble(),
            // )

            ,
            const SizedBox(
              height: 20,
            ),
            InkWell(
              onTap: () {
                setState(() {
                  isSeen = !isSeen;
                });
              },
              child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: const Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Home Automation',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Icon(
                        Icons.keyboard_arrow_down_rounded,
                        color: colors.primary,
                      )
                    ],
                  )),
            ),
            isSeen == true
                ? Container(
              margin: const EdgeInsets.symmetric(horizontal: 20),
              color: Colors.grey,
              child: Column(
                children: [
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: const Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Content',
                          style: TextStyle(
                            fontSize: 14,
                          ),
                        ),
                        Icon(
                          Icons.toggle_on,
                          size: 30,
                          color: Colors.green,
                        )
                      ],
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: const Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Content',
                          style: TextStyle(
                            fontSize: 14,
                          ),
                        ),
                        Icon(
                          Icons.toggle_on,
                          size: 30,
                          color: Colors.green,
                        )
                      ],
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: const Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Content',
                          style: TextStyle(
                            fontSize: 14,
                          ),
                        ),
                        Icon(
                          Icons.toggle_on,
                          size: 30,
                          color: Colors.green,
                        )
                      ],
                    ),
                  )
                ],
              ),
            )
                : Container(),
            const SizedBox(
              height: 20,
            ),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: GridView.builder(
                  physics: const NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  itemCount: bodyFatList.length,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    mainAxisExtent: MediaQuery.of(context).size.height * 0.16,
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
                       // _checkScanning();
                        Navigator.push(context, MaterialPageRoute(builder: (context) => const SmartDevice()));
                        //Navigator.push(context, MaterialPageRoute(builder: (context) =>  MainPage()));
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
                                margin: const EdgeInsets.symmetric(horizontal: 10),
                                height:
                                MediaQuery.of(context).size.height * 0.1,
                                decoration: BoxDecoration(
                                  color: colors.primary.withOpacity(0.3),
                                  shape: BoxShape.circle,
                                ),
                                child: Container(
                                    padding: const EdgeInsets.all(12),
                                    child: Image.asset(
                                        bodyFatList[index]["image"])),
                              ),
                              const SizedBox(
                                height: 5,
                              ),
                              Text(
                                bodyFatList[index]["firstName"],
                                style: const TextStyle(
                                  fontSize: 12,
                                ),
                              ),
                              Text(
                                bodyFatList[index]["lastName"],
                                style: const TextStyle(
                                  fontSize: 12,
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                    );
                  }),
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.1,
            )
          ],
        ),
      ),
    );
  }

  List bodyFatList = [
    {
      "firstName": "Smart Devices",
      "lastName": " ",
      "image": "assets/images/smart devices.png",
    },
    {
      "firstName": "Warranty",
      "lastName": "Authentication",
      "image": "assets/images/warranty authentication.png",
    },
    {
      "firstName": "Complaints",
      "lastName": "",
      "image": "assets/images/complaints.png",
    },
    {
      "firstName": "Whatsapp",
      "lastName": "",
      "image": "assets/images/whatsapp (1).png",
    },
    {
      "firstName": "Request",
      "lastName": "A Call Back",
      "image": "assets/images/request a call back.png",
    },
    {
      "firstName": "Add a",
      "lastName": "Device",
      "image": "assets/images/add a device.png",
    },
    {
      "firstName": "Shop",
      "lastName": "",
      "image": "assets/images/shop.png",
    },
    {
      "firstName": "Call Now",
      "lastName": "",
      "image": "assets/images/call now.png",
    },
  ];

  Future<void> _checkScanning() async {
    //String? batteryLevel;
    try {
      final  result = await platform.invokeMethod('checkScanning');

      // print('___________${result}__________');
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(result)));
      // batteryLevel = 'Battery level at $result % .';
    } on PlatformException catch (e) {
      // batteryLevel = "Failed to get battery level: '${e.message}'.";
    }

    setState(() {
      //_batteryLevel = batteryLevel ?? '';
    });
    //print('___________${batteryLevel}__________');
  }


  Widget get _buildNotSupportedWidget => FutureBuilder<bool>(
    future: FlutterBluePlus.isSupported,
    builder: (context, snapshot) {
      return Visibility(
        visible: !(snapshot.hasData && snapshot.data == true),
        child: const Text(
          'Bluetooth is not supported',
          style: TextStyle(color: Colors.red, fontSize: 18),
        ),
      );
    },
  );

  Widget get _buildBluetoothStateWidget => StreamBuilder<BluetoothAdapterState>(
    initialData: FlutterBluePlus.adapterStateNow,
    stream: FlutterBluePlus.adapterState,
    builder: (context, snapshot) {
      final bool isBluetoothOn =
          snapshot.hasData && snapshot.data == BluetoothAdapterState.on;
      return IconButton(
        onPressed: () {
          if (Platform.isAndroid && !isBluetoothOn) {
            FlutterBluePlus.turnOn();
          }
        },
        icon: Icon(
          isBluetoothOn ? Icons.bluetooth : Icons.bluetooth_disabled,
          color: Colors.white,
        ),
      );
    },
  );

  Widget get _buildOperatorWidget => Row(
    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
    children: [
      Builder(builder: (context) {
        return _buildOperatorBtn(
          'Scan',
              () => FlutterBluePlus.startScan(withServices: [Guid('F0A0')]).onError( ///Filter specified scales by serviceUUID
                (error, stackTrace) =>
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text(prettyException(error)),
                    backgroundColor: Colors.red,
                  ),
                ),
          ),
        );
      }),
      _buildOperatorBtn(
        'StopScan',
            () async => await FlutterBluePlus.stopScan(),
      ),
    ],
  );

  Widget _buildOperatorBtn(String title, Function() onPressed) {
    return ElevatedButton(
      onPressed: onPressed,
      child: Text(
        title,
        style: const TextStyle(color: Colors.white, fontSize: 18),
      ),
    );
  }

  Widget get _buildScanResultWidget => StreamBuilder<List<ScanResult>>(
    stream: FlutterBluePlus.onScanResults,
    builder: (context, snapshot) {
      final List<ScanResult> list = snapshot.hasData ? (snapshot.data ?? []) : [];
      list.sort((a, b) => b.rssi.compareTo(a.rssi));
     // print("${snapshot.data?[0].device.toString()}"+"++++++++++++++++++++++");
      return ListView.builder(
        itemCount: list.length,
        itemBuilder: (context, index) {
          List<int> manufacturerData = getManufacturerData(list[index].advertisementData.manufacturerData);
          return ListTile(
            title: Text(
              list[index].device.advName.isEmpty
                  ? 'Unknown'
                  : list[index].device.advName,
            ),
            subtitle: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'MAC: ${list[index].device.remoteId.toString()}',
                ),
                Text(
                  'UUIDs: ${list[index].advertisementData.serviceUuids.join(', ').toUpperCase()}',
                ),
                Text(
                  'Data: ${manufacturerData.toHex()}',
                ),
                FutureBuilder(
                  future: _ailinkPlugin.decryptBroadcast(
                    Uint8List.fromList(manufacturerData),
                  ),
                  builder: (context, snapshot) {
                    if (snapshot.hasData && snapshot.data != null) {
                      final weightData = BroadcastScaleDataUtils().getWeightData(snapshot.data);

                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'ParseResult: ${snapshot.data?.toHex()}',
                          ),
                          Text('Status: ${weightData?.statusStr}'),
                          Text('Impedance value: ${weightData?.adc}'),
                          Text(
                            'WeightData: ${weightData?.weightStr} ${weightData?.weightUnitStr}',
                          ),
                          weightData == null || weightData.isAdcError == true ? Container() : FutureBuilder(
                            future: _ailinkPlugin.getBodyFatData(ParamBodyFatData(double.parse(weightData.weightStr), weightData.adc, 0, 34, 170, weightData.algorithmId).toJson()),
                            builder: (context, snapshot) {
                              print('${weightData.status}___________');
                              if (weightData.status == 0xFF) {
                                if (snapshot.hasData && snapshot.data != null) {
                                  return Text(
                                    'BodyFatData: ${BodyFatData.fromJson(json.decode(snapshot.data!)).toJson()}',
                                  );
                                }
                              }
                              return Container();
                            },
                          )
                        ],
                      );
                    } else {
                      return Container();
                    }
                  },
                ),
              ],
            ),
            trailing: Text(
              list[index].rssi.toString(),
            ),
          );
        },
      );
    },
  );

  String prettyException(dynamic e) {
    if (e is FlutterBluePlusException) {
      return "${e.description}";
    } else if (e is PlatformException) {
      return "${e.message}";
    }
    return e.toString();
  }

  List<int> getManufacturerData(Map<int, List<int>> data) {
    return data.entries
        .map((entry) {
      List<int> manufacturerData = intToLittleEndian(entry.key, 2);
      List<int> results = List.empty(growable: true);
      results.addAll(manufacturerData);
      results.addAll(entry.value);
      return results;
    })
        .expand((element) => element)
        .toList();
  }

  List<int> intToLittleEndian(int value, int length) {
    List<int> result = List<int>.filled(length, 0);

    for (int i = 0; i < length; i++) {
      result[i] = (value >> (i * 8)) & 0xFF;
    }

    return result;
  }


}




extension Uint8ListExtension on Uint8List {
  String toHex() {
    return map(
          (byte) => '0x${(byte.toRadixString(16).padLeft(2, '0')).toUpperCase()}',
    ).join(',');
  }
}

extension ListIntExtension on List<int> {
  String toHex() {
    return map(
          (byte) => '0x${(byte.toRadixString(16).padLeft(2, '0')).toUpperCase()}',
    ).join(',');
  }
}