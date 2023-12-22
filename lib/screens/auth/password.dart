import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:health_genie/api/apiConstants.dart';
import 'package:health_genie/api/apiStrings.dart';
import 'package:health_genie/helper/appbtn.dart';

import 'package:health_genie/helper/colors.dart';
import 'package:health_genie/screens/home_page.dart';
import 'package:health_genie/utils/extentions.dart';
import 'package:health_genie/utils/my_snackbar.dart';

import 'forgot_password.dart';

class PasswordPage extends StatefulWidget {
  const PasswordPage({super.key});

  @override
  State<PasswordPage> createState() => _PasswordPageState();
}

class _PasswordPageState extends State<PasswordPage> {
  final _formKey = GlobalKey<FormState>();
  String _inputText = '';
  final passwordController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.grey,
        leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: const Icon(
              Icons.arrow_back_ios_outlined,
              color: colors.primary,
            )),
        centerTitle: true,
        title: const Text(
          'Password',
          style: TextStyle(color: colors.primary),
        ),
      ),
      body: Form(
        key: _formKey,
        child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                height: 2,
                width: MediaQuery.of(context).size.width,
                color: colors.primary,
              ),
              const Text(
                "Sign In",
                style: TextStyle(fontSize: 28,fontWeight: FontWeight.w600),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Container(
                  decoration: const BoxDecoration().customBoxDecoration(),
                  child: TextFormField(
                    controller: passwordController,
                    decoration: const InputDecoration().customDecoration('Password',const Icon(Icons.lock_open_outlined,)),
                    obscureText: true,
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Please enter Password';
                      }
                      return null; // Return null if the input is valid
                    },
                    onSaved: (value) {
                      _inputText = value!;
                    },
                  ),
                ),
              ),
              Btn(
                onPress: (){
                  if (_formKey.currentState!.validate()) {
                    // If the form is valid, save the input.
                    _formKey.currentState!.save();
                    // Now, you can use the validated input, which is stored in _inputText.
                    print('Input Text: $_inputText');

                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const HomePageWidget()),
                    );
                  }

                },
                title: "Sign In",
              ),
              const SizedBox(
                height: 50,
              )
            ]),
      ),
    );
  }

  Future<void> loginWithPassword() async {
    var parm = {
      "mobile_number":"",
      "email_id": "",
      "password":""
    };
    apiBaseHelper.postAPICall(getSendOtp, parm).then((getData) {
      bool status = getData['status'];
      String msg = getData['msg'];
      if (status) {
        setSnackbar(context, msg) ;
        Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) =>  HomePageWidget()),
        );
      }
    });
  }

}