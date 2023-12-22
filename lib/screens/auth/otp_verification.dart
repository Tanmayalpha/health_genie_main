import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:health_genie/api/apiConstants.dart';
import 'package:health_genie/helper/appbtn.dart';
import 'package:health_genie/helper/colors.dart';
import 'package:health_genie/screens/auth/password.dart';
import 'package:health_genie/screens/bottomNavbar.dart';
import 'package:health_genie/screens/home_page.dart';

import 'package:otp_text_field/otp_text_field.dart';
import 'package:otp_text_field/style.dart';
import 'package:http/http.dart'as http;

import '../../api/apiStrings.dart';
import '../../utils/my_snackbar.dart';

// import 'package:pinput/pinput.dart';

class Verification extends StatefulWidget {
  const Verification({super.key,  this.mobile});
  final String? mobile ;

  @override
  State<Verification> createState() => _VerificationState();
}

class _VerificationState extends State<Verification> {
  final _formKey = GlobalKey<FormState>();
  String _inputText = '';
  OtpFieldController pinController = OtpFieldController();
  // final defaultPinTheme = PinTheme(
  //   width: 56,
  //   height: 56,
  //   textStyle: TextStyle(
  //       fontSize: 20, color: Colors.black, fontWeight: FontWeight.w600),
  //   decoration: BoxDecoration(
  //     border: Border.all(color: colors.transparent),
  //     borderRadius: BorderRadius.circular(5),
  //   ),
  // );
  String? otp ;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.grey,
        leading: IconButton(
            onPressed: () {
              Navigator.pop(context, false);
            },
            icon: const Icon(
              Icons.arrow_back_ios_outlined,
              color: colors.primary,
            )),
        centerTitle: true,
        title: const Text(
            'Verification',
          style: TextStyle(color: colors.primary),
        ),
      ),
      body: SizedBox(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        //    padding: EdgeInsets.symmetric(horizontal: 20),
        child: Form(
          key: _formKey,
          child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  children: [
                    Container(
                      height: 2,
                      width: MediaQuery.of(context).size.width,
                      color: colors.primary,
                    ),
                    const SizedBox(
                      height: 50,
                    ),
                    const Text(
                      "Code has sent to ",
                      style: TextStyle(fontSize: 16,fontWeight: FontWeight.bold),
                    ),
                     Text(
                      widget.mobile ?? '',
                      style: TextStyle(fontSize: 22,fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
                Column(
                  children: [
                    Padding(
                      padding:
                          const EdgeInsets.symmetric(vertical: 0, horizontal: 20),

                      child: OTPTextField(
                        length: 6,
                        width: MediaQuery.of(context).size.width - 40,
                        fieldWidth: 40,
                        style: const TextStyle(fontSize: 17),
                        textFieldAlignment: MainAxisAlignment.spaceAround,
                        fieldStyle: FieldStyle.underline,
                        // onCompleted: (pin) {
                        //   pinController.text = pin;
                        // },
                        controller: pinController,
                        onChanged: (enteredOtp){
                           otp = enteredOtp ;
                           // if(otp != enteredOtp){
                           //   setSnackbar(context, "Otp is match");
                           // }else{
                           //   setSnackbar(context, "Otp is not match");
                           // }
                        },
                      ),
                      // child: Pinput(
                      //   length: 6,
                      //   controller: pinController,
                      //   defaultPinTheme: defaultPinTheme,

                      //   // focusedPinTheme: ,
                      //   // submittedPinTheme: submittedPinTheme,
                      //   // validator: (s) {
                      //   //   return s == 'gfd' ? null : 'Pin is incorrect';
                      //   // },
                      //   pinputAutovalidateMode: PinputAutovalidateMode.onSubmit,
                      //   showCursor: true,
                      //   onCompleted: (pin) => print(pin),
                      // ),
                    ),
                    // Padding(
                    //   padding:
                    //       EdgeInsets.symmetric(vertical: 0, horizontal: 23),
                    //   child: Row(
                    //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    //     children: [
                    //       Container(
                    //         width: 40,
                    //         height: 2,
                    //         color: Colors.grey,
                    //       ),
                    //       Container(
                    //         width: 40,
                    //         height: 2,
                    //         color: Colors.grey,
                    //       ),
                    //       Container(
                    //         width: 40,
                    //         height: 2,
                    //         color: Colors.grey,
                    //       ),
                    //       Container(
                    //         width: 40,
                    //         height: 2,
                    //         color: Colors.grey,
                    //       ),
                    //       Container(
                    //         width: 40,
                    //         height: 2,
                    //         color: Colors.grey,
                    //       ),
                    //       Container(
                    //         width: 40,
                    //         height: 2,
                    //         color: Colors.grey,
                    //       ),
                    //     ],
                    //   ),
                    // ),
                  ],
                ),
                SizedBox(
                    width: MediaQuery.of(context).size.width,
                    height: 50,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text('Haven\'t received the verification code?'),
                        const SizedBox(
                          width: 5,
                        ),
                        InkWell(
                          onTap: () {
                            // Navigator.push(
                            //   context,
                            //   MaterialPageRoute(
                            //       builder: (context) => const LoginPage()),
                            // );
                          },
                          child: const Text(
                            'Resend',
                            style: TextStyle(
                                fontSize: 18, fontWeight: FontWeight.bold),
                          ),
                        ),
                      ],
                    )),
                Btn(
                  onPress: (){
                    if (otp == null) {
                      // _formKey.currentState!.save();
                      setSnackbar(context, "Please Enter OTP!!");
                    }else{
                      verifyOtpApi();

                    }

                  },
                  title: "Verify",
                ),
                InkWell(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const PasswordPage()),
                    );
                  },
                  child: SizedBox(
                      width: MediaQuery.of(context).size.width,
                      height: 50,
                      child: const Center(
                        child: Text(
                          'Or continue with password',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                      )),
                ),
                const SizedBox(
                  height: 80,
                )
              ]),
        ),
      ),
    );
  }
  /*verifyOtpApi() async {
    var headers = {
      'Cookie': 'PHPSESSID=p4pafm1iius2hfblu17d9lu17l'
    };
    var request = http.MultipartRequest('GET', getVerifyOtp);
    request.fields.addAll({
      'mobile_number': widget.mobile.toString(),
      'otp': '983820'
    });

    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      var result = await response.stream.bytesToString();
      var finalResult = jsonDecode(result);
      if(finalResult['status']){
        setSnackbar(context, finalResult['msg']) ;
        Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) =>  BottomNavBar()),
        );
      }else {
        setSnackbar(context, finalResult['msg']) ;

      }
    }
    else {
    print(response.reasonPhrase);
    }


  }*/

  Future<void> verifyOtpApi() async {
    var parm = {
      'mobile_number': widget.mobile.toString(),
      'otp': otp
  };
    print('_____ssssss______${parm}__________');
    apiBaseHelper.postAPICall(getVerifyOtp, parm).then((getData) {
      bool status = getData['status'];
      String msg = getData['msg'];
      if (status) {
        print('___________444444444444__________');
        setSnackbar(context, msg) ;
        Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) =>  const HomePageWidget()),
        );
      }
    });
  }
}