import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:health_genie/helper/colors.dart';
import 'package:health_genie/screens/new_demo/new_plugin_demo_class.dart';
import 'package:health_genie/screens/smart_device.dart';

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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
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
                        _checkScanning();
                       // Navigator.push(context, MaterialPageRoute(builder: (context) => const SmartDevice()));
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
}
