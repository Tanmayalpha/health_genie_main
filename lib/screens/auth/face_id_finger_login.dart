import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';

import 'package:health_genie/helper/colors.dart';
import 'package:health_genie/screens/auth/login_page.dart';

class FaceIdAndFingerLoginPage extends StatefulWidget {
  final int selectedIndex;
  const FaceIdAndFingerLoginPage({super.key, required this.selectedIndex});

  @override
  State<FaceIdAndFingerLoginPage> createState() =>
      _FaceIdAndFingerLoginPageState();
}

class _FaceIdAndFingerLoginPageState extends State<FaceIdAndFingerLoginPage> {
  final _formKey = GlobalKey<FormState>();
  String _inputText = '';
  int selectedIndex = 2;

  @override
  void initState() {
    // TODO: implement initState
    selectedIndex = widget.selectedIndex;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: MediaQuery.of(context).size.width,
        padding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
        child: Form(
          key: _formKey,
          child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                const SizedBox(
                  height: 20,
                ),
                Text(
                  selectedIndex == 3
                      ? "Login with Fingerprints"
                      : "Login in with Face Id",
                  style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    InkWell(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const LoginPage()),
                        );
                      },
                      child: Container(
                        child: Row(children: [
                          Icon(selectedIndex == 0
                              ? Icons.radio_button_checked
                              : Icons.radio_button_unchecked),
                          const SizedBox(
                            width: 2,
                          ),
                          const Text('Mobile No.', style: TextStyle(fontSize: 12))
                        ]),
                      ),
                    ),
                    InkWell(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const LoginPage()),
                        );
                      },
                      child: Container(
                        child: Row(children: [
                          Icon(selectedIndex == 1
                              ? Icons.radio_button_checked
                              : Icons.radio_button_unchecked),
                          SizedBox(
                            width: 2,
                          ),
                          Text('Email', style: TextStyle(fontSize: 12))
                        ]),
                      ),
                    ),
                    InkWell(
                      onTap: () {
                        setState(() {
                          selectedIndex = 2;
                        });
                      },
                      child: Container(
                        child: Row(children: [
                          Icon(selectedIndex == 2
                              ? Icons.radio_button_checked
                              : Icons.radio_button_unchecked),
                          SizedBox(
                            width: 2,
                          ),
                          Text(
                            'Face Id',
                            style: TextStyle(fontSize: 12),
                          )
                        ]),
                      ),
                    ),
                    InkWell(
                      onTap: () {
                        setState(() {
                          selectedIndex = 3;
                        });
                      },
                      child: Container(
                        child: Row(children: [
                          Icon(selectedIndex == 3
                              ? Icons.radio_button_checked
                              : Icons.radio_button_unchecked),
                          SizedBox(
                            width: 2,
                          ),
                          Text('Fingerprints', style: TextStyle(fontSize: 12))
                        ]),
                      ),
                    )
                  ],
                ),
                Container(
                  height: MediaQuery.of(context).size.height / 10,
                  child: Image.asset(selectedIndex == 3
                      ? 'assets/images/Login With Fingerprints.png'
                      : 'assets/images/Log in with Face ID.png'),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 40.0),
                  child: Text(
                    selectedIndex == 3
                        ? "Please put your phone in front of your Fingerprints to log in"
                        : "Please put your phone in front of your face to log in",
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 18, color: Colors.grey),
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Card(
                      elevation: 2,
                      child: Container(
                        padding: EdgeInsets.all(10),
                        height: 45,
                        width: 45,
                        // decoration: BoxDecoration(
                        //     image: DecorationImage(
                        //         image: AssetImage('assets/images/google.png'),
                        //         fit: BoxFit.cover)),

                        child: Image.asset('assets/images/google.png'),
                      ),
                    ),
                    Card(
                      elevation: 2,
                      child: Container(
                        padding: EdgeInsets.all(10),
                        height: 45,
                        width: 45,
                        child: Image.asset('assets/images/instagram.png'),
                      ),
                    ),
                    Card(
                      elevation: 2,
                      child: Container(
                        padding: EdgeInsets.all(10),
                        height: 45,
                        width: 45,
                        child: Image.asset('assets/images/facebook.png'),
                      ),
                    ),
                    Card(
                      elevation: 2,
                      child: Container(
                        padding: EdgeInsets.all(10),
                        height: 45,
                        width: 45,
                        child: Image.asset('assets/images/twitter.png'),
                      ),
                    ),
                    Card(
                      elevation: 2,
                      child: Container(
                        padding: EdgeInsets.all(10),
                        height: 45,
                        width: 45,
                        child: Image.asset('assets/images/whatsapp (1).png'),
                      ),
                    )
                  ],
                ),
                SizedBox(
                  height: 80,
                )
              ]),
        ),
      ),
    );
  }
}
