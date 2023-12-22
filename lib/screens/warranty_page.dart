import 'package:flutter/material.dart';
import 'package:health_genie/helper/colors.dart';

class WarrantyPage extends StatefulWidget {
  const WarrantyPage({super.key});

  @override
  State<WarrantyPage> createState() => _WarrantyPageState();
}

class _WarrantyPageState extends State<WarrantyPage> {
  List warrantyList = [
    {
      "name": "Body Fat Analyzer",
      "date": "22/08/2023",
      "image": "assets/images/Screenshot -1.png",
    },
    {
      "name": "Weighing Scale",
      "date": "22/08/2023",
      "image": "assets/images/Weighing Scale2.png",
    },
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
      padding: EdgeInsets.symmetric(horizontal: 10, vertical: 20),
      decoration: BoxDecoration(
        border: Border(
          top: BorderSide(
            color: colors.primary,
            width: 2,
          ),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          InkWell(
            onTap: () {
              showDialog(
                context: context,
                builder: (BuildContext context) {
                  return AlertDialog(
                    title: Center(child: Text('Warranty Activation')),
                    actions: <Widget>[
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Theme(
                            data: ThemeData(
                              primaryColor: Colors.grey,
                              elevatedButtonTheme: ElevatedButtonThemeData(
                                style: ElevatedButton.styleFrom(
                                  primary: Colors.grey,
                                ),
                              ),
                            ),
                            child: ElevatedButton(
                                onPressed: () {},
                                child: Text('With Scratch Card',
                                    style: TextStyle(fontSize: 10))),
                          ),
                          Theme(
                            data: ThemeData(
                              primaryColor: Colors.grey,
                              elevatedButtonTheme: ElevatedButtonThemeData(
                                style: ElevatedButton.styleFrom(
                                  primary: Colors.grey,
                                ),
                              ),
                            ),
                            child: ElevatedButton(
                                onPressed: () {},
                                child: Text('Without Scratch Card',
                                    style: TextStyle(fontSize: 10))),
                          ),
                        ],
                      )
                      // TextButton(
                      //   onPressed: () {
                      //     // Close the pop-up
                      //     Navigator.of(context).pop();
                      //   },
                      //   child: Text('Close'),
                      // ),
                    ],
                  );
                },
              );
            },
            child: Container(
              width: MediaQuery.of(context).size.width * 0.6,
              height: 50,
              decoration: BoxDecoration(
                  color: colors.primary,
                  borderRadius: BorderRadius.circular(10)),
              child: Center(
                child: Text(
                  'Activate Now',
                  style: TextStyle(color: Colors.white, fontSize: 20),
                ),
              ),
            ),
          ),
          SizedBox(
            height: 20,
          ),
          Container(
            width: MediaQuery.of(context).size.width,
            alignment: Alignment.centerLeft,
            child: Text(
              'Warrenty Activated Products',
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          SizedBox(
            height: 10,
          ),
          ListView.separated(
            shrinkWrap: true,
            padding: EdgeInsets.symmetric(horizontal: 10),
            physics: NeverScrollableScrollPhysics(),
            itemCount: warrantyList.length,
            itemBuilder: (BuildContext context, int index) {
              return InkWell(
                onTap: () {
                  // Navigator.push(
                  //     context,
                  //     MaterialPageRoute(
                  //         builder: (context) => const WeddingForm()));
                },
                child: Stack(
                  children: [
                    Container(
                      height: MediaQuery.of(context).size.height * 0.18,
                      width: MediaQuery.of(context).size.width,
                      padding:
                          EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                      decoration: BoxDecoration(
                          color: Colors.white,
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey.withOpacity(0.1),
                              spreadRadius: 2,
                              blurRadius: 1,
                              // changes position of shadow
                            ),
                          ],
                          borderRadius: BorderRadius.circular(15)),
                      child: Row(
                        children: [
                          Expanded(
                              flex: 1,
                              child: Container(
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(15),
                                    image: DecorationImage(
                                        image: AssetImage(
                                            warrantyList[index]['image']),
                                        fit: BoxFit.cover)),
                              )),
                          Expanded(
                              flex: 2,
                              child: Container(
                                padding: EdgeInsets.symmetric(horizontal: 10),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: [
                                    Text(warrantyList[index]['name'],
                                        style: TextStyle(
                                            fontSize: 14,
                                            fontWeight: FontWeight.bold)),
                                    Text("Portal   Warranty status",
                                        style: TextStyle(fontSize: 12)),
                                    Text("Warranty Details",
                                        style: TextStyle(
                                            fontSize: 11,
                                            fontWeight: FontWeight.bold)),
                                    Text(
                                      'Activation Date : ${warrantyList[index]['date']}',
                                      style: TextStyle(fontSize: 12),
                                    ),
                                    Text(
                                        'Start date : ${warrantyList[index]['date']}',
                                        style: TextStyle(fontSize: 12)),
                                    Text(
                                        'End Date : ${warrantyList[index]['date']}',
                                        style: TextStyle(fontSize: 12)),
                                  ],
                                ),
                              ))
                        ],
                      ),
                      //    padding: EdgeInsets.all(20),
                      // child: Image.asset('assets/images/wddingimg.png'),
                      //  Image.network(
                      //     weddingCardList?.data?[0].templates![index].preview ??
                      //         ''),
                    ),
                    Container(
                        height: MediaQuery.of(context).size.height * 0.18,
                        width: MediaQuery.of(context).size.width,
                        alignment: Alignment.bottomRight,
                        padding:
                            EdgeInsets.symmetric(horizontal: 5, vertical: 10),
                        child: Text(
                          'Claim Warranty',
                          style: TextStyle(
                            decoration: TextDecoration.underline,
                            decorationColor: colors.primary,
                            color: colors.primary,
                            fontSize: 12,
                          ),
                        )),
                  ],
                ),
              );
            },
            separatorBuilder: (context, index) {
              return SizedBox(
                height: 10,
              );
            },
          ),
        ],
      ),
    ));
  }
}
