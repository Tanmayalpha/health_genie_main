import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:health_genie/helper/appbtn.dart';
import 'package:health_genie/helper/colors.dart';
import 'package:health_genie/screens/auth/sign_up_final.dart';
import 'package:health_genie/screens/auth/sign_up_verify.dart';
import 'package:health_genie/utils/extentions.dart';

import '../../api/apiConstants.dart';
import '../../api/apiStrings.dart';
import '../../utils/my_snackbar.dart';
import 'package:http/http.dart'as http;

class SignUpPage extends StatefulWidget {
  const SignUpPage({super.key});

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  final _formKey = GlobalKey<FormState>();
  String _inputEmailText = '';
  String _inputMobileText = '';

  TextEditingController emailController = TextEditingController();
  TextEditingController nameController = TextEditingController();
  TextEditingController mobileController = TextEditingController();
  TextEditingController lastNameController = TextEditingController();
  TextEditingController cityController = TextEditingController();

  TextEditingController mobileC =  TextEditingController();
  TextEditingController emailC =  TextEditingController();
  List<String> itemList = ["Indore", "Bhopal", "Ujjain", "Dewas"];

  String cityName = 'Indore';

  int selectedIndex = 0;
  int selectedGenderIndex = 0;
  bool selectedAgr = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: MediaQuery.of(context).size.width,
        padding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
        child: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.15,
                  ),
                  const Text(
                    "Create Account",
                    style: TextStyle(fontSize: 28),
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.05,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      /*selectedIndex == 1
                          ? Icon(
                              Icons.check_circle,
                              size: 20,
                              color: Colors.green,
                            )
                          :*/ Container(
                              height: 20,
                              width: 20,
                              decoration: BoxDecoration(
                                  border: Border.all(
                                      color: colors.primary, width: 5),
                                  shape: BoxShape.circle),
                            ),
                      Container(
                        width: MediaQuery.of(context).size.width * 0.4,
                        height: 1,
                        color: Colors.grey,
                      ),
                      Container(
                        height: 20,
                        width: 20,
                        decoration: BoxDecoration(
                            border: Border.all(
                                color: colors.primary,
                                width: selectedIndex == 1 ? 5 : 1),
                            shape: BoxShape.circle),
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        padding: EdgeInsets.only(
                          left: 30,
                        ),
                        child: Text(
                          'Step 1',
                          style: TextStyle(
                              color: selectedIndex == 1
                                  ? Colors.green
                                  : colors.primary),
                        ),
                      ),
                      Container(
                        width: MediaQuery.of(context).size.width * 0.36,
                        height: 1,
                        color: Colors.transparent,
                      ),
                      Container(
                        padding: EdgeInsets.only(
                          right: 30,
                        ),
                        child: Text(
                          'Step 2',
                          style: TextStyle(color: colors.primary),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.1,
                  ),

                    Container(
                      decoration: const BoxDecoration().customBoxDecoration(),
                      child: TextFormField(
                        style: const TextStyle(color: colors.black54),
                        controller: mobileC,
                        keyboardType: TextInputType.number,
                        maxLength: 10,
                        decoration: const InputDecoration().customDecoration("Enter Mobile", const Icon(Icons.phone, size: 25,)),
                        validator: (v) {
                          if (v!.length < 10) {
                            return "mobile number is required";
                          }
                        },
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                  Container(
                    decoration: const BoxDecoration().customBoxDecoration(),
                      child: TextFormField(
                        style:  const TextStyle(color: colors.black54),
                        controller: emailC,
                        keyboardType: TextInputType.emailAddress,
                        decoration: const InputDecoration().customDecoration('Enter Email', Icon(Icons.email,size: 25,)),
                        validator: (v) {
                          if (v!.isEmpty) {
                            return "Email is required";
                          }
                          if (!v.contains("@")) {
                            return "Enter Valid Email Id";
                          }
                        },
                      ),
                    ),
                    Row(
                      children: [
                        IconButton(
                          onPressed: () {
                            setState(() {
                              if (selectedAgr) {
                                selectedAgr = false;
                              } else {
                                selectedAgr = true;
                              }
                            });
                          },
                          icon: Icon(selectedAgr
                              ? Icons.check_box
                              : Icons.check_box_outline_blank),
                        ),
                        Text(
                          'I agree to all terms & condition and privacy policy',
                          style: TextStyle(fontSize: 12),
                        )
                      ],
                    ),


                  const SizedBox(
                    height: 50,
                  ),
                  Btn(
                    onPress: () async {
                      if (_formKey.currentState!.validate()) {
                          //signUpSendOtp();
                        Navigator.push(context, MaterialPageRoute(builder: (context)=>const SignUpFinalScreen()));
                        _formKey.currentState!.save();
                        setState(() {
                          selectedIndex = 1;
                        });
                      } else {

                      }
                    },
                            title:  'Next',
                          ),
                   const SizedBox(height: 80,)


            ]),
          ),
        ),
      ),
    );
  }


  Future<void> signUpApi() async {
    var parm = {
      'mobile_number': "widget.mobile.toString()",
      'email_id': "otp",
      'first_name': "otp",
      'last_name': "otp",
      'city': "otp",
      'country': "otp",
      'gender': "otp",
    };
    print('_____ssssss______${parm}__________');
    apiBaseHelper.postAPICall(getSignUpApi, parm).then((getData) {
      bool status = getData['status'];
      String msg = getData['msg'];
      if (status == true) {
        print('___________444444444444__________');
        setSnackbar(context, msg) ;
        // Navigator.push(
        //   context,
        //   MaterialPageRoute(
        //       builder: (context) =>  const HomePageWidget()),
        // );
      }
    });
  }

  Future<void> signUpSendOtp() async {
    var parm = {
      'mobile_number':mobileC.text,
      'email_id':emailC.text,
    };
    apiBaseHelper.postAPICall(getSignSendOtp,parm).then((getData) {
      bool status = getData['status'];
      String msg = getData['msg'];
      if(status == true){
        setSnackbar(context, msg);
        Navigator.push(context, MaterialPageRoute(builder: (context)=>VerificationSignUp(mobile: mobileC.text,)));
      }

    });
  }



}