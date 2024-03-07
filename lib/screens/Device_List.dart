import 'dart:async';
import 'dart:convert';

import 'package:ailink/ailink.dart';
import 'package:ailink/model/param_body_fat_data.dart';
import 'package:ailink/utils/body_data_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_blue_plus/flutter_blue_plus.dart';
import 'package:health_genie/helper/colors.dart';
import 'package:health_genie/screens/ailinkclasese/parambodyfat.dart';
import 'package:health_genie/screens/home_page.dart';
import 'package:health_genie/utils/snackbar.dart';

import 'ailinkclasese/brodcastutils.dart';
import 'ailinkclasese/fat_data.dart';

class DeviceListScreen extends StatefulWidget {
  const DeviceListScreen({Key? key}) : super(key: key);

  @override
  State<DeviceListScreen> createState() => _DeviceListScreenState();
}

class _DeviceListScreenState extends State<DeviceListScreen> {
  final _ailinkPlugin = Ailink();

  //late StreamSubscription<List<ScanResult>> _scanResultsSubscription;
  //List<ScanResult> scanResult = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    /*scanResultsSubscription = FlutterBluePlus.scanResults.listen((results) {
      scanResult = results;

      setState(() {});
      if (dialogState != null) {
        dialogState!(() {});
      }
    });*/
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
   // _scanResultsSubscription.cancel();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Devices')),
      floatingActionButton: dataindex != null ? const SizedBox(): buildScanButton(context),
      body: dataindex != null  ? _buildScanResultindx : _buildScanResultWidget,
    );
  }

  Widget buildScanButton(BuildContext context) {
    if (FlutterBluePlus.isScanningNow) {
      return FloatingActionButton(
        onPressed: onStopPressed,
        backgroundColor: Colors.red,
        child: const Icon(Icons.stop),
      );
    } else {
      return FloatingActionButton(
          onPressed: onScanPressed, child: const Text("SCAN"));
    }
  }

  Future onScanPressed() async {
    /*try {
      await FlutterBluePlus.startScan(timeout: const Duration(seconds: 400));
    } catch (e) {
      Snackbar.show(ABC.b, prettyException("Start Scan Error:", e), success: false);
    }*/
    await FlutterBluePlus.startScan(withServices: [Guid('F0A0')]).onError(
      ///Filter specified scales by serviceUUID
      (error, stackTrace) => ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(prettyException(error.toString(), context)),
          backgroundColor: Colors.red,
        ),
      ),
    );
    setState(() {}); // force refresh of connectedSystemDevices
  }

  Future onStopPressed() async {
    try {
      FlutterBluePlus.stopScan();
    } catch (e) {
      Snackbar.show(ABC.b, prettyException("Stop Scan Error:", e),
          success: false);
    }
  }

  StateSetter? dialogState;

  Widget get _buildScanResultWidget => StreamBuilder<List<ScanResult>>(
        stream: FlutterBluePlus.onScanResults,
        builder: (context, snapshot) {
          final List<ScanResult> list =
              snapshot.hasData ? (snapshot.data ?? []) : [];
          list.sort((a, b) => b.rssi.compareTo(a.rssi));
          // print("${snapshot.data?[0].device.toString()}"+"++++++++++++++++++++++");

          return ListView.builder(
            itemCount: list.length,
            itemBuilder: (context, index) {
              List<int> manufacturerData = getManufacturerData(
                  list[index].advertisementData.manufacturerData);
              return InkWell(
                onTap: () {

                  dataindex = index ;
                  //FlutterBluePlus.stopScan() ;
                  setState(() {

                  });
                  /*showDialog(context: context, builder: (context) =>

                      StatefulBuilder(

                        builder: (context,setState) {
                          dialogState = setState ;
                          return  FutureBuilder(
                            future: _ailinkPlugin.decryptBroadcast(
                              Uint8List.fromList(manufacturerData),
                            ),
                            builder: (context, snapshot) {
                              if (snapshot.hasData && snapshot.data != null) {
                                final weightData = BroadcastScaleDataUtils()
                                    .getWeightData(snapshot.data);
                                return Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      'ParseResult: ${snapshot.data?.toHex()}',
                                    ),
                                    Text('Status: ${weightData?.statusStr}'),
                                    Text('Impedance value: ${weightData?.adc}'),
                                    Text(
                                      'WeightData: ${weightData
                                          ?.weightStr} ${weightData
                                          ?.weightUnitStr}',
                                    ),
                                    weightData == null ||
                                        weightData.isAdcError == true
                                        ? Container()
                                        : FutureBuilder(
                                      future: _ailinkPlugin.getBodyFatData(
                                          ParamBodyFatData(
                                              double.parse(weightData.weightStr),
                                              weightData.adc, 0, 34, 170,
                                              weightData.algorithmId).toJson()),
                                      builder: (context, snapshot) {
                                        print('${weightData.status}___________');
                                        if (weightData.status == 0xFF) {
                                          if (snapshot.hasData &&
                                              snapshot.data != null) {
                                            return Text(
                                              'BodyFatData: ${BodyFatData
                                                  .fromJson(
                                                  json.decode(snapshot.data!))
                                                  .toJson()}',
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
                          );
                        }
                      ,));*/

                  /*showDialog(
                    context: context,
                    builder: (context) => StatefulBuilder(
                      builder: (context, setState) {
                        dialogState = setState;
                        return StreamBuilder<List<ScanResult>>(
                          stream: FlutterBluePlus.onScanResults,
                          builder: (context, snapshot) {
                            final List<ScanResult> list = snapshot.hasData ? (snapshot.data ?? []) : [];
                            list.sort((a, b) => b.rssi.compareTo(a.rssi));

                            if (!snapshot.hasData) {
                              // Handle loading state or other conditions
                              return CircularProgressIndicator();
                            }

                            if (list.isEmpty) {
                              // Handle case when there are no scan results
                              return Text('No scan results');
                            }

                            final ScanResult result = list[0];
                            List<int> manufacturerData = getManufacturerData(result.advertisementData.manufacturerData);

                            return FutureBuilder(
                              future: _ailinkPlugin.decryptBroadcast(
                                Uint8List.fromList(manufacturerData),
                              ),
                              builder: (context, snapshot) {
                                if (snapshot.hasData && snapshot.data != null) {
                                  final weightData = BroadcastScaleDataUtils().getWeightData(snapshot.data);

                                  return AlertDialog(
                                    content: Column(
                                      mainAxisSize: MainAxisSize.min,
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text('ParseResult: ${snapshot.data?.toHex()}'),
                                        Text('Status: ${weightData?.statusStr ?? ''}'),
                                        Text('Impedance value: ${weightData?.adc ?? ''}'),
                                        Text(
                                          'WeightData: ${weightData?.weightStr ?? '0.0'} ${weightData?.weightUnitStr ?? ''}',
                                        ),
                                        Text(
                                          'Temperature: ${weightData?.temp ?? ''}',
                                        ),
                                        weightData == null || weightData.isAdcError == true
                                            ? Container()
                                            : FutureBuilder(
                                          future: _ailinkPlugin.getBodyFatData(
                                            ParamBodyFatData(
                                              double.parse(weightData.weightStr),
                                              weightData.adc, 0, 34, 170,
                                              weightData.algorithmId,
                                            ).toJson(),
                                          ),
                                          builder: (context, snapshot) {
                                            print('${weightData.status}____________');
                                            if (weightData.status == 0xFF) {
                                              if (snapshot.hasData && snapshot.data != null) {
                                               var item = BodyFatData.fromJson(json.decode(snapshot.data!));
                                                return Column(children: [
                                                  Text(
                                                    'Body fat: ${item.bmr ?? ''}',
                                                  ),
                                                  Text(
                                                    'moisture: ${item.bm ?? ''}',
                                                  ),
                                                  Text(
                                                    'BMI: ${item.bmi ?? ''}',
                                                  ),

                                                  Text(
                                                  'Muscle Mass: ${item.rom ?? ''}',
                                            ),
                                                  Text(
                                                    'BMR: ${item.bmr ?? ''}',
                                                  ),
                                                  Text(
                                                    'Protein Mass: ${item.pp ?? ''}',
                                                  ),
                                                ],);
                                              }
                                            }
                                            return Container();
                                          },
                                        ),
                                      ],
                                    ),
                                  );
                                } else {
                                  // Handle case when decryption is still in progress
                                  return CircularProgressIndicator();
                                }
                              },
                            );
                          },
                        );
                      },
                    ),
                  );*/

                  /*Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('ParseResult: ${snapshot.data?.toHex()}'),
                      Text('Status: ${weightData?.statusStr ?? ''}'),
                      Text('Impedance value: ${weightData?.adc ?? ''}'),
                      Text(
                        'WeightData: ${weightData?.weightStr ?? '0.0'} ${weightData?.weightUnitStr ?? ''}',
                      ),
                      Text(
                        'Temperature: ${weightData?.temp ?? ''}',
                      ),
                      weightData == null || weightData.isAdcError == true
                          ? Container()
                          : FutureBuilder(
                        future: _ailinkPlugin.getBodyFatData(
                          ParamBodyFatData(
                            double.parse(weightData.weightStr),
                            weightData.adc, 0, 34, 170,
                            weightData.algorithmId,
                          ).toJson(),
                        ),
                        builder: (context, snapshot) {
                          print('${weightData.status}____________');
                          if (weightData.status == 0xFF) {
                            if (snapshot.hasData && snapshot.data != null) {
                              var item = BodyFatData.fromJson(json.decode(snapshot.data!));
                              return Column(children: [
                                Text(
                                  'Body fat: ${item.bmr ?? ''}',
                                ),
                                Text(
                                  'moisture: ${item.bm ?? ''}',
                                ),
                                Text(
                                  'BMI: ${item.bmi ?? ''}',
                                ),

                                Text(
                                  'Muscle Mass: ${item.rom ?? ''}',
                                ),
                                Text(
                                  'BMR: ${item.bmr ?? ''}',
                                ),
                                Text(
                                  'Protein Mass: ${item.pp ?? ''}',
                                ),
                              ],);
                            }
                          }
                          return Container();
                        },
                      ),
                    ],
                  )*/
                },
                child: ListTile(
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
                      /*Text(
                        'Data: ${manufacturerData.toHex()}',
                      ),*/
                      /*FutureBuilder(
                        future: _ailinkPlugin.decryptBroadcast(
                          Uint8List.fromList(manufacturerData),
                        ),
                        builder: (context, snapshot) {
                          if (snapshot.hasData && snapshot.data != null) {
                            final weightData = BroadcastScaleDataUtils().getWeightData(snapshot.data);
                            return Column(
                              mainAxisSize: MainAxisSize.min,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text('ParseResult: ${snapshot.data?.toHex()}'),
                                Text('Status: ${weightData?.statusStr ?? ''}'),
                                Text(
                                    'Impedance value: ${weightData?.adc ?? ''}'),
                                Text(
                                  'WeightData: ${weightData?.weightStr ?? '0.0'} ${weightData?.weightUnitStr ?? ''}',
                                ),
                                Text(
                                  'Temperature: ${weightData?.temp ?? ''}',
                                ),
                                weightData == null *//*||
                                    weightData.isAdcError == true*//*
                                    ? Container()
                                    : FutureBuilder(
                                  future: _ailinkPlugin.getBodyFatData(
                                    ParamBodyFatData(
                                      double.parse(weightData.weightStr),
                                      weightData.adc,
                                      0,
                                      34,
                                      170,
                                      weightData.algorithmId,
                                    ).toJson(),
                                  ),
                                  builder: (context, snapshot) {
                                    print(
                                        '${weightData.status}____________');
                                    if (weightData.status == 0xFF) {
                                      if (snapshot.hasData &&
                                          snapshot.data != null) {
                                        var item = BodyFatData.fromJson(
                                            json.decode(snapshot.data!));
                                        return Column(
                                          children: [
                                            Text(
                                              'Body fat: ${item.bmr ?? ''}',
                                            ),
                                            Text(
                                              'moisture: ${item.bm ?? ''}',
                                            ),
                                            Text(
                                              'BMI: ${item.bmi ?? ''}',
                                            ),
                                            Text(
                                              'Muscle Mass: ${item.rom ?? ''}',
                                            ),
                                            Text(
                                              'BMR: ${item.bmr ?? ''}',
                                            ),
                                            Text(
                                              'Protein Mass: ${item.pp ?? ''}',
                                            ),
                                          ],
                                        );
                                      }
                                    }
                                    return Container();
                                  },
                                ),
                              ],
                            );
                          } else {
                            return Container();
                          }
                        },
                      )*/
                    ],
                  ),
                  trailing: Text(
                    list[index].rssi.toString(),
                  ),
                ),
              );
            },
          );
        },
      );
int? dataindex;
  Widget get _buildScanResultindx => StreamBuilder<List<ScanResult>>(
        stream: FlutterBluePlus.onScanResults,
        builder: (context, snapshot) {
          final List<ScanResult> list =
              snapshot.hasData ? (snapshot.data ?? []) : [];
          list.sort((a, b) => b.rssi.compareTo(a.rssi));
          // print("${snapshot.data?[0].device.toString()}"+"++++++++++++++++++++++");

          return ListView.builder(
            itemCount: list.length,
            itemBuilder: (context, index) {
              List<int> manufacturerData = getManufacturerData(
                  list[dataindex ?? 0].advertisementData.manufacturerData);
              return InkWell(
                onTap: () {
                  /*showDialog(context: context, builder: (context) =>

                      StatefulBuilder(

                        builder: (context,setState) {
                          dialogState = setState ;
                          return  FutureBuilder(
                            future: _ailinkPlugin.decryptBroadcast(
                              Uint8List.fromList(manufacturerData),
                            ),
                            builder: (context, snapshot) {
                              if (snapshot.hasData && snapshot.data != null) {
                                final weightData = BroadcastScaleDataUtils()
                                    .getWeightData(snapshot.data);
                                return Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      'ParseResult: ${snapshot.data?.toHex()}',
                                    ),
                                    Text('Status: ${weightData?.statusStr}'),
                                    Text('Impedance value: ${weightData?.adc}'),
                                    Text(
                                      'WeightData: ${weightData
                                          ?.weightStr} ${weightData
                                          ?.weightUnitStr}',
                                    ),
                                    weightData == null ||
                                        weightData.isAdcError == true
                                        ? Container()
                                        : FutureBuilder(
                                      future: _ailinkPlugin.getBodyFatData(
                                          ParamBodyFatData(
                                              double.parse(weightData.weightStr),
                                              weightData.adc, 0, 34, 170,
                                              weightData.algorithmId).toJson()),
                                      builder: (context, snapshot) {
                                        print('${weightData.status}___________');
                                        if (weightData.status == 0xFF) {
                                          if (snapshot.hasData &&
                                              snapshot.data != null) {
                                            return Text(
                                              'BodyFatData: ${BodyFatData
                                                  .fromJson(
                                                  json.decode(snapshot.data!))
                                                  .toJson()}',
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
                          );
                        }
                      ,));*/

                  /*showDialog(
                    context: context,
                    builder: (context) => StatefulBuilder(
                      builder: (context, setState) {
                        dialogState = setState;
                        return StreamBuilder<List<ScanResult>>(
                          stream: FlutterBluePlus.onScanResults,
                          builder: (context, snapshot) {
                            final List<ScanResult> list = snapshot.hasData ? (snapshot.data ?? []) : [];
                            list.sort((a, b) => b.rssi.compareTo(a.rssi));

                            if (!snapshot.hasData) {
                              // Handle loading state or other conditions
                              return CircularProgressIndicator();
                            }

                            if (list.isEmpty) {
                              // Handle case when there are no scan results
                              return Text('No scan results');
                            }

                            final ScanResult result = list[0];
                            List<int> manufacturerData = getManufacturerData(result.advertisementData.manufacturerData);

                            return FutureBuilder(
                              future: _ailinkPlugin.decryptBroadcast(
                                Uint8List.fromList(manufacturerData),
                              ),
                              builder: (context, snapshot) {
                                if (snapshot.hasData && snapshot.data != null) {
                                  final weightData = BroadcastScaleDataUtils().getWeightData(snapshot.data);

                                  return AlertDialog(
                                    content: Column(
                                      mainAxisSize: MainAxisSize.min,
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text('ParseResult: ${snapshot.data?.toHex()}'),
                                        Text('Status: ${weightData?.statusStr ?? ''}'),
                                        Text('Impedance value: ${weightData?.adc ?? ''}'),
                                        Text(
                                          'WeightData: ${weightData?.weightStr ?? '0.0'} ${weightData?.weightUnitStr ?? ''}',
                                        ),
                                        Text(
                                          'Temperature: ${weightData?.temp ?? ''}',
                                        ),
                                        weightData == null || weightData.isAdcError == true
                                            ? Container()
                                            : FutureBuilder(
                                          future: _ailinkPlugin.getBodyFatData(
                                            ParamBodyFatData(
                                              double.parse(weightData.weightStr),
                                              weightData.adc, 0, 34, 170,
                                              weightData.algorithmId,
                                            ).toJson(),
                                          ),
                                          builder: (context, snapshot) {
                                            print('${weightData.status}____________');
                                            if (weightData.status == 0xFF) {
                                              if (snapshot.hasData && snapshot.data != null) {
                                               var item = BodyFatData.fromJson(json.decode(snapshot.data!));
                                                return Column(children: [
                                                  Text(
                                                    'Body fat: ${item.bmr ?? ''}',
                                                  ),
                                                  Text(
                                                    'moisture: ${item.bm ?? ''}',
                                                  ),
                                                  Text(
                                                    'BMI: ${item.bmi ?? ''}',
                                                  ),

                                                  Text(
                                                  'Muscle Mass: ${item.rom ?? ''}',
                                            ),
                                                  Text(
                                                    'BMR: ${item.bmr ?? ''}',
                                                  ),
                                                  Text(
                                                    'Protein Mass: ${item.pp ?? ''}',
                                                  ),
                                                ],);
                                              }
                                            }
                                            return Container();
                                          },
                                        ),
                                      ],
                                    ),
                                  );
                                } else {
                                  // Handle case when decryption is still in progress
                                  return CircularProgressIndicator();
                                }
                              },
                            );
                          },
                        );
                      },
                    ),
                  );*/
                },
                child: ListTile(
                  title: Text(
                    list[dataindex ?? 0].device.advName.isEmpty
                        ? 'Unknown'
                        : list[dataindex ?? 0].device.advName,
                  ),
                  subtitle: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      /*Text(
                        'MAC: ${list[dataindex ?? 0].device.remoteId.toString()}',
                      ),
                      Text(
                        'UUIDs: ${list[dataindex ?? 0].advertisementData.serviceUuids.join(', ').toUpperCase()}',
                      ),*/
                      /*Text(
                        'Data: ${manufacturerData.toHex()}',
                      ),*/
                      FutureBuilder(
                        future: _ailinkPlugin.decryptBroadcast(
                          Uint8List.fromList(manufacturerData),
                        ),
                        builder: (context, snapshot) {
                          if (snapshot.hasData && snapshot.data != null) {
                            final weightData = BroadcastScaleDataUtils().getWeightData(snapshot.data);

                            print('${weightData?.algorithmId}______________algorithemId_');


                            return Column(
                              mainAxisSize: MainAxisSize.min,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text('ParseResult: ${snapshot.data?.toHex()}'),
                                Text('Status: ${weightData?.statusStr ?? ''}'),
                                Text(
                                    'Impedance value: ${weightData?.adc ?? ''}'),
                                Text(
                                  'WeightData: ${weightData?.weightStr ?? '0.0'} ${weightData?.weightUnitStr ?? ''}',
                                ),
                                Text(
                                  'Temperature: ${weightData?.temp ?? ''}',
                                ),
                                weightData == null || weightData.isAdcError == true /* //Female=0;Male=1 //Gender: Male, Height: 170cm, Weight 65kg, Age 25*/
                                    ? Container()
                                    : FutureBuilder(
                                  future: _ailinkPlugin.getBodyFatData(ParamBodyFatData(double.parse(weightData.weightStr), weightData.adc, 0, 30, 167, weightData.algorithmId).toJson()),
                                  builder: (context, snapshot) {
                                    print('${weightData.status}_____status_________');
                                  /*  print(
                                        '${weightData.status}____________');*/
                                    if (weightData.status == 0xFF) {
                                      if (snapshot.hasData &&
                                          snapshot.data != null) {
                                        print('______${snapshot.data}_____');

                                        var item = BodyFatData.fromJson(
                                            json.decode(snapshot.data!));
                                       // final standardWeight = BodyDataUtils.getStandardWeight(1, 170);
                                        double bodyMass = 0.0;
                                       // int standardWeight = ((item.bmi ?? 0.0) * ((170/100)*(170/100))).toInt();
                                        //double weightControl =  double.parse(weightData.weightStr)- standardWeight;
                                       // double fatMass = double.parse('${weightData.weightStr}') * (item.bfr ??0.0)/100;
                                       // double leanBodyMass = double.parse(weightData.weightStr) - fatMass;
                                       // double muscleMass = leanBodyMass * ((item.rom ?? 0.0)/100);
                                       // double proteinAmount = leanBodyMass * ((item.pp ?? 0.0)/100);

                                        final standardWeight = BodyDataUtils.getStandardWeight(0, 167);
                                        final weightControl = BodyDataUtils.getWeightControl(double.parse(weightData.weightStr), 0, 167);
                                        final fatMass = BodyDataUtils.getFatMass(double.parse(weightData.weightStr), item.bfr ?? 0.0);
                                        final leanBodyMass = BodyDataUtils.getLeanBodyMass(double.parse(weightData.weightStr), item.bfr ?? 0.0);
                                        final muscleMass = BodyDataUtils.getMuscleMass(double.parse(weightData.weightStr), item.rom ?? 0.0);
                                        final proteinMass = BodyDataUtils.getProteinMass(double.parse(weightData.weightStr), item.pp ?? 0.0);
                                        final level = BodyDataUtils.getObesityLevel(double.parse(weightData.weightStr), 0, 167);



                                        return  Column(
                                          children: [
                                            Row(
                                              children: [
                                              bodyData('${weightData.weightStr ?? '0.0'} ${weightData.weightUnitStr ?? ''}','Body Weight' ),
                                              Container(height: 40,width: 2,color: Colors.black26,),
                                              bodyData(item.bmi.toString(),'BMI' ),
                                              Container(height: 40,width: 2,color: Colors.black26,),
                                              bodyData('${item.bfr.toString()}%','Body Fat Percentage' ),
                                            ],),
                                            const SizedBox(height: 20,),
                                            Row(children: [
                                              bodyData('${item.rom.toString()}%','Muscle Rate' ),
                                              Container(height: 40,width: 2,color: Colors.black26,),

                                              bodyData('${item.vwc}%','Moisture' ),
                                              Container(height: 40,width: 2,color: Colors.black26,),

                                              bodyData('${item.bm}kg','Born Mass' ),
                                            ],),
                                            const SizedBox(height: 20,),
                                            Row(children: [
                                              bodyData('${item.bmr}Kcal','BMR' ),
                                              Container(height: 40,width: 2,color: Colors.black26,),

                                              bodyData('${item.pp} %','Protein Rate' ),
                                              Container(height: 40,width: 2,color: Colors.black26,),

                                              bodyData(item.physicalAge.toString(),'Body Age' ),
                                            ],),
                                            const SizedBox(height: 20,),
                                            Row(children: [
                                              bodyData('${item.uvi}','Visceral Fat Index' ),
                                              Container(height: 40,width: 2,color: Colors.black26,),

                                                bodyData('${item.sfr}%','Subcutaneous Fat' ),
                                              Container(height: 40,width: 2,color: Colors.black26,),

                                              bodyData('${standardWeight} ${weightData.weightUnitStr}','Standard Weight' ),
                                            ],),
                                            const SizedBox(height: 20,),
                                            Row(children: [
                                              bodyData('${weightControl} ${weightData.weightUnitStr}','Weight Control' ),
                                              Container(height: 40,width: 2,color: Colors.black26,),

                                              bodyData('${fatMass} ${weightData.weightUnitStr}','Fat Mass' ),
                                              Container(height: 40,width: 2,color: Colors.black26,),

                                              bodyData('${leanBodyMass} ${weightData.weightUnitStr}','Lean Body Mass' ),

                                            ],),
                                            const SizedBox(height: 20,),
                                            Row(children: [
                                              bodyData('${muscleMass}${weightData.weightUnitStr}','Muscle Mass' ),
                                              Container(height: 40,width: 2,color: Colors.black26,),

                                              bodyData('${proteinMass} ${weightData.weightUnitStr}','Protein Amount' ),
                                              Container(height: 40,width: 2,color: Colors.black26,),

                                              bodyData(level.name ?? '','Obesity Rating' ),
                                            ],),






                                          ],
                                        );
                                      }
                                    }
                                    return Container();
                                  },
                                ),
                              ],
                            );
                          } else {
                            return Container();
                          }
                        },
                      ),
                      /*FutureBuilder(
                        future: _ailinkPlugin.decryptBroadcast(
                          Uint8List.fromList(manufacturerData),
                        ),
                        builder: ((context, snapshot) {
                          if (snapshot.hasData && snapshot.data != null) {
                            final weightData = BroadcastScaleDataUtils()
                                .getWeightData(snapshot.data);

                            return Column(
                              mainAxisSize: MainAxisSize.min,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text('ParseResult: ${snapshot.data?.toHex()}'),
                                Text('Status: ${weightData?.statusStr ?? ''}'),
                                Text(
                                    'Impedance value: ${weightData?.adc ?? ''}'),
                                Text(
                                  'WeightData: ${weightData?.weightStr ?? '0.0'} ${weightData?.weightUnitStr ?? ''}',
                                ),
                                Text(
                                  'Temperature: ${weightData?.temp ?? ''}',
                                ),
                                weightData == null ||
                                        weightData.isAdcError == true
                                    ? Container()
                                    : FutureBuilder(
                                        future: _ailinkPlugin.getBodyFatData(
                                          ParamBodyFatData(
                                            double.parse(weightData.weightStr),
                                            weightData.adc,
                                            0,
                                            34,
                                            170,
                                            weightData.algorithmId,
                                          ).toJson(),
                                        ),
                                        builder: (context, snapshot) {
                                          print(
                                              '${weightData.status}____________');
                                          if (weightData.status == 0xFF) {
                                            if (snapshot.hasData &&
                                                snapshot.data != null) {
                                              var item = BodyFatData.fromJson(
                                                  json.decode(snapshot.data!));
                                              return Column(
                                                children: [
                                                  Text(
                                                    'Body fat: ${item.bmr ?? ''}',
                                                  ),
                                                  Text(
                                                    'moisture: ${item.bm ?? ''}',
                                                  ),
                                                  Text(
                                                    'BMI: ${item.bmi ?? ''}',
                                                  ),
                                                  Text(
                                                    'Muscle Mass: ${item.rom ?? ''}',
                                                  ),
                                                  Text(
                                                    'BMR: ${item.bmr ?? ''}',
                                                  ),
                                                  Text(
                                                    'Protein Mass: ${item.pp ?? ''}',
                                                  ),
                                                ],
                                              );
                                            }
                                          }
                                          return Container();
                                        },
                                      ),
                              ],
                            );
                          } else {
                            return Container();
                          }
                        }),
                      )*/
                    ],
                  ),
                  trailing: Text(
                    list[index].rssi.toString(),
                  ),
                ),
              );
            },
          );
        },
      );


  String getBMIStatus(double bmi){
    if (bmi < 18.5) {
      return 'Underweight';
    } else if (bmi >= 18.5 && bmi <= 24.9) {
      return 'Healthy Weight';
    } else if (bmi >= 25.0 && bmi <= 29.9) {
      return 'Overweight';
    } else if (bmi == double.minPositive) {
      return 'Minimum positive BMI. Please provide valid weight and height.';
    } else {
      return 'Obesity';
    }
  }

  Widget bodyData(String? data, String title){
    return
      Expanded(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
          Text(
            data ?? '--',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 18),
          ),
          SizedBox(
            width: 80,
            child: Text(
              title, textAlign: TextAlign.center,
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ],),
      )  ;}

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
