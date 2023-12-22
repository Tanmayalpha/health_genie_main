import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:health_genie/helper/colors.dart';

import '../helper/appbtn.dart';

class WarrantyWithSC extends StatefulWidget {
  const WarrantyWithSC({super.key});

  @override
  State<WarrantyWithSC> createState() => _WarrantyWithSCState();
}

class _WarrantyWithSCState extends State<WarrantyWithSC> {
  TextEditingController _uniqueCodeController = TextEditingController();
  TextEditingController _orderNumberController = TextEditingController();
  TextEditingController _invoiceNumberController = TextEditingController();
  TextEditingController _dateController = TextEditingController();

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
        title: Column(
          children: [
            Text(
              'Warranty Activation',
              style: TextStyle(
                color: colors.primary,
                fontSize: 20,
              ),
            ),
            Text(
              'With Scratch Card',
              style: TextStyle(
                color: colors.primary,
                fontSize: 14,
              ),
            ),
          ],
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
        child: ListView(
          children: [
            Card(
              elevation: 2,
              child: TextFormField(
                controller: _uniqueCodeController,
                decoration: InputDecoration(
                  contentPadding: EdgeInsets.only(left: 10, top: 0),
                  //   prefixIcon: Icon(Icons.person),
                  hintText: 'Unique Code (12 alphanumeric ) ',
                  focusedBorder: InputBorder.none,
                  errorBorder: InputBorder.none,
                  enabledBorder: InputBorder.none,
                ),
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Please enter Unique Code (12 alphanumeric )';
                  }
                  return null; // Return null if the input is valid
                },
              ),
            ),
            SizedBox(
              height: 15,
            ),
            Card(
              elevation: 2,
              child: TextFormField(
                controller: _orderNumberController,
                decoration: InputDecoration(
                  contentPadding: EdgeInsets.only(left: 10, top: 0),
                  hintText: 'Order Number',
                  focusedBorder: InputBorder.none,
                  errorBorder: InputBorder.none,
                  enabledBorder: InputBorder.none,
                ),
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Please enter Order Number';
                  }
                  return null; // Return null if the input is valid
                },
              ),
            ),
            SizedBox(
              height: 15,
            ),
            Card(
              elevation: 2,
              child: TextFormField(
                controller: _invoiceNumberController,
                decoration: InputDecoration(
                  contentPadding: EdgeInsets.only(left: 10, top: 0),
                  //   prefixIcon: Icon(Icons.person),
                  hintText: 'Invoice Number',
                  focusedBorder: InputBorder.none,
                  errorBorder: InputBorder.none,
                  enabledBorder: InputBorder.none,
                ),
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Please enter Invoice Number';
                  }
                  return null; // Return null if the input is valid
                },
              ),
            ),
            SizedBox(
              height: 15,
            ),
            Card(
              elevation: 2,
              child: TextFormField(
                onTap: () {
                  _selectDate(context);
                },
                controller: _dateController,
                decoration: InputDecoration(
                  contentPadding: EdgeInsets.only(left: 10, top: 15),
                  hintText: "Invoice Date",
                  focusedBorder: InputBorder.none,
                  errorBorder: InputBorder.none,
                  enabledBorder: InputBorder.none,
                  suffixIcon: GestureDetector(
                    onTap: () {
                      _selectDate(context);
                    },
                    child: Icon(Icons.calendar_today,color:Color(0xffED777777) ,),
                  ),
                ),
                readOnly: true,
              ),
            ),
            SizedBox(
              height: 15,
            ),
            Card(
              elevation: 2,
              child: TextFormField(
                readOnly: true,
                decoration: InputDecoration(
                  suffixIcon: Icon(Icons.file_upload_outlined,color:Color(0xffED777777)),
                  contentPadding: EdgeInsets.only(left: 10, top: 15),
                  hintText: 'Upload Invoice / Capture Image',
                  focusedBorder: InputBorder.none,
                  errorBorder: InputBorder.none,
                  enabledBorder: InputBorder.none,
                ),
                validator: (value) {
                  // Return null if the input is valid
                },
              ),
            ),
            Text('PDF/Images max 1mb'),
            SizedBox(
              height: 39,
            ),

            Btn(
              title: "Submit",
              onPress: (){

              },
            )

          ],
        ),
      ),
    );
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
    );

    if (picked != null && picked != _dateController.text) {
      setState(() {
        _dateController.text = picked.toLocal().toString().split(' ')[0];
        // if (widget.onDateSelected != null) {
        //   widget.onDateSelected!(picked);
        // }
      });
    }
  }
}