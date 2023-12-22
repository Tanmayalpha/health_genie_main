import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:health_genie/helper/appbtn.dart';
import 'package:health_genie/helper/colors.dart';
import 'package:health_genie/screens/auth/bioMetric.dart';
import 'package:health_genie/utils/extentions.dart';

class SignUpFinalScreen extends StatefulWidget {
  const SignUpFinalScreen({Key? key}) : super(key: key);

  @override
  State<SignUpFinalScreen> createState() => _SignUpFinalScreenState();
}

class _SignUpFinalScreenState extends State<SignUpFinalScreen> {
  final nameController = TextEditingController();
  final lastNameController = TextEditingController();
  final cityController = TextEditingController();
  String? cityName;

  List<String> itemList = [
    "Indore",
    "Bhopal",
    "Jabalpur",
    "Delhi",
    "Mumbai",
    "Pune"
  ];

  int selectedGenderIndex = 0;
  final _formKey = GlobalKey<FormState>();


  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SingleChildScrollView(
padding: EdgeInsets.symmetric(horizontal: 20),
          child: Form(
            key: _formKey,
            child: Column(
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
                const Icon(
                  Icons.check_circle,
                  size: 20,
                  color: Colors.green,
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
                          width:  5 ),
                      shape: BoxShape.circle),
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  padding: const EdgeInsets.only(
                    left: 30,
                  ),
                  child: const Text(
                    'Step 1',
                    style: TextStyle(color: Colors.green),
                  ),
                ),
                Container(
                  width: MediaQuery.of(context).size.width * 0.36,
                  height: 1,
                  color: Colors.transparent,
                ),
                Container(
                  padding: const EdgeInsets.only(
                    right: 30,
                  ),
                  child: const Text(
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
                controller: nameController,
                keyboardType: TextInputType.emailAddress,
                decoration: const InputDecoration()
                    .customDecoration('Enter First Name', const Icon(Icons.person)),
                validator: (v) {
                  if (v!.isEmpty) {
                    return "name is required";
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
                style: const TextStyle(color: colors.black54),
                controller: lastNameController,
                keyboardType: TextInputType.emailAddress,
                decoration: const InputDecoration()
                    .customDecoration('Enter Last Name', Icon(Icons.person)),
                validator: (v) {
                  if (v!.isEmpty) {
                    return "name is required";
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
                style: const TextStyle(color: colors.black54),
                controller: cityController,
                keyboardType: TextInputType.emailAddress,
                decoration: const InputDecoration()
                    .customDecoration('Enter City', Icon(Icons.pin_drop)),
                validator: (v) {
                  if (v!.isEmpty) {
                    return "City is required";
                  }
                },
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Card(
              elevation: 5,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0),
              ),
              child: Row(
                children: [
                  const SizedBox(
                    width: 10,
                  ),
                  const Icon(
                    Icons.location_city,
                    color: colors.red,
                  ),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.all(2.0),
                      child: DropdownButtonHideUnderline(
                        child: DropdownButton<String>(
                          hint: const Text("Select State"),
                          isExpanded: true,
                          elevation: 0,
                          value: cityName,
                          icon: const Icon(
                            Icons.keyboard_arrow_down,
                            size: 40,
                          ),
                          items: itemList.map((items) {
                            return DropdownMenuItem(
                                value: items.toString(),
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Text(items.toString()),
                                ));
                          }).toList(),
                          onChanged: (String? newValue) {
                            setState(() {
                              cityName = newValue!;
                            });
                          },
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Container(
              alignment: Alignment.centerLeft,
              height: 40,
              child: const Text(
                'Gender',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                InkWell(
                  onTap: () {
                    setState(() {
                      selectedGenderIndex = 0;
                    });
                  },
                  child: Row(children: [
                    Icon(selectedGenderIndex == 0
                        ? Icons.radio_button_checked
                        : Icons.radio_button_unchecked),
                    const SizedBox(
                      width: 2,
                    ),
                    const Text('Male')
                  ]),
                ),
                InkWell(
                  onTap: () {
                    setState(() {
                      selectedGenderIndex = 1;
                    });
                  },
                  child: Row(children: [
                    Icon(selectedGenderIndex == 1
                        ? Icons.radio_button_checked
                        : Icons.radio_button_unchecked),
                    const SizedBox(
                      width: 2,
                    ),
                    const Text('Female')
                  ]),
                ),
                InkWell(
                  onTap: () {
                    setState(() {
                      selectedGenderIndex = 2;
                    });
                  },
                  child: Row(children: [
                    Icon(selectedGenderIndex == 2
                        ? Icons.radio_button_checked
                        : Icons.radio_button_unchecked),
                    const SizedBox(
                      width: 2,
                    ),
                    const Text('Others')
                  ]),
                ),
                const SizedBox(
                  width: 20,
                ),

              ],
            ),
        SizedBox(height: 20,),
        Btn(
          onPress: () async {
            if (_formKey.currentState!.validate()) {
              //signUpSendOtp();

              _formKey.currentState!.save();

            } else {

            }
            Navigator.push(context, MaterialPageRoute(builder: (context)=>const BioMetricAuth()));
          },
          title:  'Next',
        ),
      ],
    ),
          ),
        ));
  }
}
