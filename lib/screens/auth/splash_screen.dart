import 'dart:async';

import 'package:flutter/material.dart';
import 'package:health_genie/screens/auth/t&c.dart';


class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  String? uid;
  String? type;
  bool? isSeen;
  @override
  void initState() {
    print("u id in splash screeen-----------${uid}");
    // TODO: implement initState
    Future.delayed(Duration(seconds: 2), () async {
      // SharedPreferences prefs  = await SharedPreferences.getInstance();
      // bool? isLogin  =  prefs.getBool('isLogin');
      // print("is login trueee--------${isLogin}");
      // if(isLogin ?? false) {
      //   Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=> BottomScreen()));
      //  } else{
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => UserAgreement()));
      //  }
    });
    //  Timer(Duration(seconds: 3), () {Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=> IntroSlider()));});
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        body: Container(
          padding: EdgeInsets.symmetric(horizontal: 40),
          height: MediaQuery.of(context).size.height,
          child: Center(
              child: Image.asset("assets/images/logo.png", fit: BoxFit.cover)),
        ),
      ),
    );
  }
}