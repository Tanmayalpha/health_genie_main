import 'package:flutter/material.dart';
import 'package:health_genie/helper/colors.dart';

class WarrantyWithoutSC extends StatefulWidget {
  const WarrantyWithoutSC({super.key});

  @override
  State<WarrantyWithoutSC> createState() => _WarrantyWithoutSCState();
}

class _WarrantyWithoutSCState extends State<WarrantyWithoutSC> {
  TextEditingController _orderNumberController = TextEditingController();
  TextEditingController _invoiceNumberController = TextEditingController();
  TextEditingController _orderDateController = TextEditingController();
  TextEditingController _invoiceDateController = TextEditingController();
  TextEditingController _productCategory = TextEditingController();
  String buyPlace = 'Option 1'; // Initial selection
  String productCategory = 'Option 1';
  String productName = 'Option 1';
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
              'Without Scratch Card',
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
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 10),
                child: DropdownButton<String>(
                  value: buyPlace,
                  underline: Container(),
                  isExpanded: true,
                  onChanged: (newValue) {
                    setState(() {
                      buyPlace = newValue!;
                    });
                  },
                  items: <String>[
                    'Option 1',
                    'Option 2',
                    'Option 3',
                    'Option 4'
                  ].map<DropdownMenuItem<String>>((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    );
                  }).toList(),
                ),
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Card(
              elevation: 2,
              child: TextFormField(
                controller: _orderNumberController,
                decoration: InputDecoration(
                  contentPadding: EdgeInsets.only(left: 10, top: 0),
                  //   prefixIcon: Icon(Icons.person),
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
              height: 10,
            ),
            Card(
              elevation: 2,
              child: TextFormField(
                onTap: () {
                  _selectDate(context, _orderDateController);
                },
                controller: _orderDateController,
                decoration: InputDecoration(
                  contentPadding: EdgeInsets.only(left: 10, top: 15),
                  hintText: "Order Date",
                  focusedBorder: InputBorder.none,
                  errorBorder: InputBorder.none,
                  enabledBorder: InputBorder.none,
                  suffixIcon: GestureDetector(
                    onTap: () {
                      _selectDate(context, _orderDateController);
                    },
                    child: Icon(Icons.calendar_today),
                  ),
                ),
                readOnly: true,
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Card(
              elevation: 2,
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 10),
                child: DropdownButton<String>(
                  value: productCategory,
                  underline: Container(),
                  isExpanded: true,
                  onChanged: (newValue) {
                    setState(() {
                      productCategory = newValue!;
                    });
                  },
                  items: <String>[
                    'Option 1',
                    'Option 2',
                    'Option 3',
                    'Option 4'
                  ].map<DropdownMenuItem<String>>((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    );
                  }).toList(),
                ),
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Card(
              elevation: 2,
              child: TextFormField(
                controller: _productCategory,
                decoration: InputDecoration(
                  contentPadding: EdgeInsets.only(left: 10, top: 0),
                  hintText: 'Product Category',
                  focusedBorder: InputBorder.none,
                  errorBorder: InputBorder.none,
                  enabledBorder: InputBorder.none,
                ),
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Please enter Product Category';
                  }
                  return null; // Return null if the input is valid
                },
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Card(
              elevation: 2,
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 10),
                child: DropdownButton<String>(
                  value: productName,
                  underline: Container(),
                  isExpanded: true,
                  onChanged: (newValue) {
                    setState(() {
                      productName = newValue!;
                    });
                  },
                  items: <String>[
                    'Option 1',
                    'Option 2',
                    'Option 3',
                    'Option 4'
                  ].map<DropdownMenuItem<String>>((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    );
                  }).toList(),
                ),
              ),
            ),
            SizedBox(
              height: 10,
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
              height: 10,
            ),
            Card(
              elevation: 2,
              child: TextFormField(
                onTap: () {
                  _selectDate(context, _invoiceDateController);
                },
                controller: _invoiceDateController,
                decoration: InputDecoration(
                  contentPadding: EdgeInsets.only(left: 10, top: 15),
                  hintText: "Invoice Date",
                  focusedBorder: InputBorder.none,
                  errorBorder: InputBorder.none,
                  enabledBorder: InputBorder.none,
                  suffixIcon: GestureDetector(
                    onTap: () {
                      _selectDate(context, _invoiceDateController);
                    },
                    child: Icon(Icons.calendar_today,color: Color(0xffED777777),),
                  ),
                ),
                readOnly: true,
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Card(
              elevation: 2,
              child: TextFormField(
                readOnly: true,
                decoration: InputDecoration(
                  suffixIcon: Icon(Icons.file_upload_outlined,color: Color(0xffED777777),),
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
            Container(
              margin: EdgeInsets.symmetric(
                  horizontal: MediaQuery.of(context).size.width * 0.2),
              width: MediaQuery.of(context).size.width * 0.6,
              height: 50,
              decoration: BoxDecoration(
                  color: Colors.white,
                  border: Border.all(color: colors.primary, width: 2),
                  borderRadius: BorderRadius.circular(10)),
              child: Center(
                child: Text(
                  'Submit',
                  style: TextStyle(color: colors.primary, fontSize: 20,fontWeight: FontWeight.bold),
                ),
              ),
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.1,
            )
          ],
        ),
      ),
    );
  }

  Future<void> _selectDate(
      BuildContext context, TextEditingController controller) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
    );

    if (picked != null && picked != controller.text) {
      setState(() {
        controller.text = picked.toLocal().toString().split(' ')[0];
        // if (widget.onDateSelected != null) {
        //   widget.onDateSelected!(picked);
        // }
      });
    }
  }
}