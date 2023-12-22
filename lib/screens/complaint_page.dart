 import 'package:flutter/material.dart';
import 'package:health_genie/helper/colors.dart';

class ComplaintPage extends StatefulWidget {
  const ComplaintPage({super.key});

  @override
  State<ComplaintPage> createState() => _ComplaintPageState();
}

class _ComplaintPageState extends State<ComplaintPage> {
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
        appBar: AppBar(
          backgroundColor: Colors.grey,
          leading: IconButton(
              onPressed: () {
                Navigator.pop(context);
                // _handleNavigationChange(0);
              },
              icon: Icon(
                Icons.arrow_back_ios_new,
                color: colors.primary,
              )),
          centerTitle: true,
          title: Text(
            'Complaints',
            style: TextStyle(
              color: colors.primary,
              fontSize: 20,fontWeight: FontWeight.bold
            ),
          ),
        ),
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
                onTap: () {},
                child: Container(
                  width: MediaQuery.of(context).size.width * 0.6,
                  height: 50,
                  decoration: BoxDecoration(
                      color: colors.primary,
                      borderRadius: BorderRadius.circular(10)),
                  child: Center(
                    child: Text(
                      '+Raise a complaint',
                      style: TextStyle(color: Colors.white, fontSize: 18,fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Container(
                margin: EdgeInsets.symmetric(
                    horizontal: MediaQuery.of(context).size.width * 0.1),
                height: 40,
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                    border: Border.all(color: colors.primary),
                    borderRadius: BorderRadius.circular(5)),
                child: Row(
                  children: [
                    Expanded(
                        child: Container(
                      decoration: BoxDecoration(
                          color: colors.primary,
                          borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(5),
                              bottomLeft: Radius.circular(5))),
                      child: Center(
                          child: Text(
                        'Pending Complaints',
                        style: TextStyle(color: Colors.white),
                      )),
                    )),
                    Expanded(
                        child: Container(
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.only(
                              topRight: Radius.circular(5),
                              bottomRight: Radius.circular(5))),
                      // color: Colors.white,
                      child: Center(
                          child: Text(
                        'Closed Complaints',
                        style: TextStyle(color: colors.primary),
                      )),
                    ))
                  ],
                ),
              ),
              SizedBox(
                height: 20,
              ),
              ListView.separated(
                shrinkWrap: true,
                padding: EdgeInsets.symmetric(horizontal: 10),
                physics: NeverScrollableScrollPhysics(),
                itemCount: warrantyList.length,
                itemBuilder: (BuildContext context, int index) {
                  return Container(
                    height: MediaQuery.of(context).size.height * 0.2,
                    width: MediaQuery.of(context).size.width,
                    padding: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
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
                                  Text("Complaint ID : 525252",
                                      style: TextStyle(
                                          fontSize: 10,
                                          fontWeight: FontWeight.bold)),
                                  Text(
                                    'Complaint Type : Complaint Type',
                                    style: TextStyle(fontSize: 10),
                                  ),
                                  Text('Complaint Date : 22/08/2023',
                                      style: TextStyle(fontSize: 10)),
                                  Text('Complaint Status : Complaint Status',
                                      style: TextStyle(fontSize: 10)),
                                  Text('Complaint Closing Date : 22/08/2023',
                                      style: TextStyle(fontSize: 10)),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Container(
                                        child: Row(
                                          children: [
                                            Text(
                                              '4.5 Out Of 10',
                                              style: TextStyle(
                                                  fontSize: 8,
                                                  fontWeight: FontWeight.bold),
                                            ),
                                            SizedBox(
                                              width: 5,
                                            ),
                                            Icon(
                                              Icons.star,
                                              color: Colors.yellow,
                                              size: 10,
                                            ),
                                            Icon(
                                              Icons.star,
                                              color: Colors.yellow,
                                              size: 10,
                                            ),
                                            Icon(
                                              Icons.star,
                                              color: Colors.yellow,
                                              size: 10,
                                            ),
                                            Icon(
                                              Icons.star,
                                              color: Colors.yellow,
                                              size: 10,
                                            ),
                                            Icon(
                                              Icons.star_border,
                                              color: Colors.black,
                                              size: 10,
                                            ),
                                          ],
                                        ),
                                      ),
                                      Container(
                                        child: Text(
                                          'View Complaint',
                                          style: TextStyle(
                                            decoration:
                                                TextDecoration.underline,
                                            decorationColor: colors.primary,
                                            color: colors.primary,
                                            fontSize: 10,
                                          ),
                                        ),
                                      )
                                    ],
                                  )
                                ],
                              ),
                            ))
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