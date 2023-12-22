import 'dart:async';

import 'package:flutter/material.dart';
import 'package:health_genie/helper/appbtn.dart';

import 'package:health_genie/helper/colors.dart';
import 'package:health_genie/screens/auth/signup_page.dart';

import 'login_page.dart';

class StartUpPage extends StatefulWidget {
  const StartUpPage({Key? key}) : super(key: key);

  @override
  State<StartUpPage> createState() => _StartUpPageState();
}

class _StartUpPageState extends State<StartUpPage> {
  int selected = 0;
  @override
  void initState() {
    //  Timer(Duration(seconds: 3), () {Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=> IntroSlider()));});
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        body: Stack(
          children: [
            Container(
              padding: EdgeInsets.symmetric(horizontal: 65),
              height: MediaQuery.of(context).size.height,
              child: Center(
                  child:
                      Image.asset("assets/images/logo.png", fit: BoxFit.cover)),
            ),
            Container(
              width: MediaQuery.of(context).size.width,
              padding: EdgeInsets.only(
                  top: MediaQuery.of(context).size.height * 0.6),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  InkWell(
                    onTap: () {
                      setState(() {
                        selected = 0;
                      });

                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const LoginPage()),
                      );
                    },
                    child: FilledBtn(title: 'Login'),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  InkWell(
                    onTap: () {
                      setState(() {
                        selected = 1;
                      });
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const SignUpPage()),
                      );
                    },
                    child: Btn(
                      title: "Sign Up" ,
                    )

                    // Container(
                    //   decoration: BoxDecoration(
                    //       color: selected == 1 ? colors.primary : Colors.white,
                    //       borderRadius: BorderRadius.circular(5),
                    //       border: Border.all(color: colors.primary, width: 1)),
                    //   width: MediaQuery.of(context).size.width * 0.5,
                    //   height: 50,
                    //   child: Center(
                    //       child: Text(
                    //     'Sign Up',
                    //     style: TextStyle(
                    //       fontWeight: FontWeight.bold,
                    //       color: selected == 1 ? Colors.white : colors.primary,
                    //     ),
                    //   )),
                    // ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}