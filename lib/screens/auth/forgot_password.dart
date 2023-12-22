import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:health_genie/helper/appbtn.dart';

import 'package:health_genie/helper/colors.dart';
import 'package:health_genie/screens/auth/signup_page.dart';

class ForgetPassword extends StatefulWidget {
  const ForgetPassword({super.key});

  @override
  State<ForgetPassword> createState() => _ForgetPasswordState();
}

class _ForgetPasswordState extends State<ForgetPassword> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController emailController = TextEditingController();
  TextEditingController nameController = TextEditingController();
  TextEditingController mobileController = TextEditingController();
  int selectedIndex = 0;
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
                SizedBox(
                  height: 18,
                ),
                Column(
                  children: [
                    Text(
                      "Forgot Password",
                      style: TextStyle(fontSize: 28,fontWeight: FontWeight.bold),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 30),
                      child: Text(
                        "Enter mobile number associated with your account",
                        textAlign: TextAlign.center,
                        style: TextStyle(fontSize: 16),
                      ),
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    InkWell(
                      onTap: () {
                        setState(() {
                          selectedIndex = 0;
                        });
                      },
                      child: Container(
                        child: Row(children: [
                          Icon(selectedIndex == 0
                              ? Icons.radio_button_checked
                              : Icons.radio_button_unchecked),
                          SizedBox(
                            width: 2,
                          ),
                          Text('Mobile no.')
                        ]),
                      ),
                    ),
                    InkWell(
                      onTap: () {
                        setState(() {
                          selectedIndex = 1;
                        });
                      },
                      child: Container(
                        child: Row(children: [
                          Icon(selectedIndex == 1
                              ? Icons.radio_button_checked
                              : Icons.radio_button_unchecked),
                          SizedBox(
                            width: 2,
                          ),
                          Text('Email Id')
                        ]),
                      ),
                    )
                  ],
                ),
                selectedIndex == 1
                    ? Card(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                        elevation: 5,
                        child: TextFormField(
                          style: const TextStyle(color: colors.black54),
                          controller: emailController,
                          keyboardType: TextInputType.emailAddress,
                          decoration: const InputDecoration(
                            prefixIcon: Icon(Icons.email,color: Colors.red,),
                            enabledBorder: InputBorder.none,
                            focusedBorder: InputBorder.none,
                            hintText: 'Enter email',
                            border: InputBorder.none,
                            // border: OutlineInputBorder(
                            //     borderRadius: BorderRadius.circular(10)),
                          ),
                          validator: (v) {
                            if (v!.isEmpty) {
                              return "Email is required";
                            }
                            if (!v.contains("@")) {
                              return "Enter Valid Email Id";
                            }
                          },
                        ),
                      )
                    : Card(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                        elevation: 5,
                        child: TextFormField(
                          style: TextStyle(color: colors.black54),
                          controller: mobileController,
                          keyboardType: TextInputType.number,
                          maxLength: 10,
                          decoration: const InputDecoration(
                            counterText: "",
                            hintText: 'Enter mobile',
                            prefixIcon: Icon(Icons.phone,color: Colors.red,),
                            enabledBorder: InputBorder.none,
                            focusedBorder: InputBorder.none,
                            border: InputBorder.none,
                            // hintStyle:
                            //     TextStyle(fontSize: 15.0, color: colors.secondary),
                            // border: OutlineInputBorder(
                            //     borderRadius: BorderRadius.circular(10)),
                          ),
                          validator: (v) {
                            if (v!.length < 10) {
                              return "mobile number is required";
                            }
                          },
                        ),
                      ),
                Btn(
                  onPress: (){
                    if (_formKey.currentState!.validate()) {
                      // If the form is valid, save the input.
                      _formKey.currentState!.save();
                      // Now, you can use the validated input, which is stored in _inputText.
                      print('Input Text: $emailController.text');
                    }
                  },
                  title: "Submit",
                ),
                SizedBox(
                  height: 80,
                )
              ]),
        ),
      ),
      bottomSheet: Container(
          width: MediaQuery.of(context).size.width,
          height: 40,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text('Don\'t have an account?'),
              SizedBox(
                width: 5,
              ),
              InkWell(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const SignUpPage()),
                  );
                },
                child: Text(
                  'Sign Up',
                  style: TextStyle(
                      color:Colors.grey,
                      fontSize: 16,
                      fontWeight: FontWeight.bold),
                ),
              ),
            ],
          )),
    );
  }
}