import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:health_genie/api/apiConstants.dart';
import 'package:health_genie/api/apiStrings.dart';

import 'package:health_genie/helper/colors.dart';
import 'package:health_genie/screens/auth/password.dart';
import 'package:health_genie/screens/auth/signup_page.dart';
import 'package:health_genie/screens/bottomNavbar.dart';
import 'package:health_genie/screens/home_page.dart';
import 'package:health_genie/utils/extentions.dart';
import 'package:health_genie/utils/my_snackbar.dart';

import 'package:http/http.dart' as http;

import '../../helper/appbtn.dart';
import 'face_id_finger_login.dart';
import 'otp_verification.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();
  String _inputText = '';
  int selectedIndex = 99;
  final mobileEmailController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: MediaQuery.of(context).size.width,
        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
        child: Form(
          key: _formKey,
          child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                const SizedBox(
                  height: 20,
                ),
                const Text(
                  "Login",
                  style: TextStyle(fontSize: 28, fontWeight: FontWeight.w600),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    InkWell(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const FaceIdAndFingerLoginPage(
                                    selectedIndex: 2,
                                  )),
                        );

                        // setState(() {
                        //   selectedIndex = 0;
                        // });
                      },
                      child: Row(children: [
                        Icon(selectedIndex == 0
                            ? Icons.radio_button_checked
                            : Icons.radio_button_unchecked),
                        const SizedBox(
                          width: 2,
                        ),
                        const Text('Face Id')
                      ]),
                    ),
                    InkWell(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const FaceIdAndFingerLoginPage(
                                    selectedIndex: 3,
                                  )),
                        );
                      },
                      child: Container(
                        child: Row(children: [
                          Icon(selectedIndex == 1
                              ? Icons.radio_button_checked
                              : Icons.radio_button_unchecked),
                          const SizedBox(
                            width: 2,
                          ),
                          const Text('Fingerprints')
                        ]),
                      ),
                    )
                  ],
                ),

                Container(
                  decoration: BoxDecoration(
                    color: colors.whiteTemp,
                    borderRadius:  BorderRadius.circular(5.0),
                    boxShadow: const [
                      BoxShadow(
                        color: Colors.black12,
                        spreadRadius: 1,
                        blurRadius: 3,
                      ),
                    ],
                  ),
                  child: TextFormField(
                    controller: mobileEmailController,
                    validator: (value) {
                      if (value?.isEmpty ?? false) {
                        return 'Product title required';
                      }
                      return null;
                    },
                    decoration: const InputDecoration().customDecoration('Mobile No. / Email Id', const Icon(Icons.person, size: 25,)),
                    textAlign: TextAlign.start,
                    maxLines: 1,
                  ),
                ),
                Btn(
                  onPress: (){
                    if (_formKey.currentState!.validate()) {
                      // If the form is valid, save the input.
                      _formKey.currentState!.save();
                      // Now, you can use the validated input, which is stored in _inputText.
                      if (kDebugMode) {
                        print('Input Text: $_inputText');
                      }
                    }
                    if(isValidEmail(mobileEmailController.text)){

                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const PasswordPage()),
                      );

                    }else if(isValidPhoneNumber(mobileEmailController.text)){
                      sendOtp();
                    }
                  },
                  title: "Continue",
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Card(
                      elevation: 2,
                      child: Container(
                        padding: const EdgeInsets.all(10),
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
                        padding: const EdgeInsets.all(10),
                        height: 45,
                        width: 45,
                        child: Image.asset('assets/images/instagram.png'),
                      ),
                    ),
                    Card(
                      elevation: 2,
                      child: Container(
                        padding: const EdgeInsets.all(10),
                        height: 45,
                        width: 45,
                        child: Image.asset('assets/images/facebook.png'),
                      ),
                    ),
                    Card(
                      elevation: 2,
                      child: Container(
                        padding: const EdgeInsets.all(10),
                        height: 45,
                        width: 45,
                        child: Image.asset('assets/images/twitter.png'),
                      ),
                    ),
                    Card(
                      elevation: 2,
                      child: Container(
                        padding: const EdgeInsets.all(10),
                        height: 45,
                        width: 45,
                        child: Image.asset('assets/images/whatsapp (1).png'),
                      ),
                    )
                  ],
                ),
                const SizedBox(
                  height: 80,
                )
              ]),
        ),
      ),
      bottomSheet: SizedBox(
          width: MediaQuery.of(context).size.width,
          height: 50,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text('Don\'t have an account?'),
              const SizedBox(
                width: 5,
              ),
              InkWell(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const SignUpPage()),
                  );
                },
                child: const Text(
                  'Sign Up',
                  style: TextStyle(
                      color: colors.textColor,
                      fontSize: 16,
                      fontWeight: FontWeight.bold),
                ),
              ),
            ],
          )),
    );
  }

  Future<void> sendOtp() async {
    var parm = {
      "mobile_number":mobileEmailController.text
    };
    apiBaseHelper.postAPICall(getSendOtp, parm).then((getData) {
      bool status = getData['status'];
      String msg = getData['msg'];
      if (status) {
        setSnackbar(context, msg) ;
        Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) =>  Verification(mobile: mobileEmailController.text,)),
        );
      }
    });
  }




  bool isValidEmail(String input) {
    // Use a regular expression to validate the email format.
    final emailRegExp = RegExp(r'^[\w-]+(\.[\w-]+)*@[\w-]+(\.[\w-]+)+$');
    return emailRegExp.hasMatch(input);
  }

  bool isValidPhoneNumber(String input) {
    // Check if the input is a 10-digit number.
    return input.length == 10 && int.tryParse(input) != null;
  }

}
