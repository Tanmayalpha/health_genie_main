import 'package:flutter/material.dart';
import 'package:health_genie/helper/colors.dart';

class RequestACall extends StatefulWidget {
  const RequestACall({
    super.key,
  });

  @override
  State<RequestACall> createState() => _RequestACallState();
}

class _RequestACallState extends State<RequestACall> {
  List<String> callDay = [
    "Today",
    "Tomorrow",
    "Day After",
    "Other",
  ];
  TextEditingController _dateController = TextEditingController();
  TextEditingController _reasonController = TextEditingController();
  int selectedIndex = 3;
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
        title: Text(
          "Request A Call Back",
          style: TextStyle(
            color: colors.primary,
            fontSize: 20,fontWeight: FontWeight.bold
          ),
        ),
      ),
      body: Container(
        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
        decoration: BoxDecoration(
          border: Border(
            top: BorderSide(
              color: colors.primary,
              width: 2,
            ),
          ),
        ),
        child: Column(
          children: [
            Container(
              width: MediaQuery.of(context).size.width,
              height: 30,
              child: ListView.separated(
                  scrollDirection: Axis.horizontal,
                  shrinkWrap: true,
                  itemCount: callDay.length,
                  separatorBuilder: (context, index) => SizedBox(
                        width: 10,
                      ),
                  itemBuilder: (context, index) {
                    return InkWell(
                      onTap: () => setState(() => selectedIndex = index),
                      child: Container(
                        decoration: BoxDecoration(
                            color: selectedIndex == index
                                ? colors.primary
                                : colors.whiteTemp,
                            border: Border.all(color: colors.primary)),
                        padding: EdgeInsets.symmetric(
                          horizontal: 10,
                        ),
                        child: Center(
                          child: Text(
                            callDay[index],
                            style: TextStyle(
                                fontSize: 12,
                                color: selectedIndex == index
                                    ? colors.whiteTemp
                                    : colors.primary),
                          ),
                        ),
                      ),
                    );
                  }),
            ),
            SizedBox(
              height: 20,
            ),
            Container(
              width: MediaQuery.of(context).size.width,
              alignment: Alignment.centerLeft,
              child: Text(
                'Convenient Time for a call back',
                style: TextStyle(
                  fontSize: 16,
                ),
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Card(
              elevation: 3,
              child: TextFormField(
                onTap: () {
                  _selectDate(context, _dateController);
                },
                controller: _dateController,
                decoration: InputDecoration(
                  contentPadding: EdgeInsets.only(
                    left: 10,
                  ),
                  hintText: "Date & Time",
                  focusedBorder: InputBorder.none,
                  errorBorder: InputBorder.none,
                  enabledBorder: InputBorder.none,
                ),
                readOnly: true,
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Card(
              elevation: 3,
              child: TextFormField(
                controller: _reasonController,
                decoration: InputDecoration(
                  contentPadding: EdgeInsets.only(left: 10, top: 0),
                  //   prefixIcon: Icon(Icons.person),
                  hintText: 'Reason for a call back',
                  focusedBorder: InputBorder.none,
                  errorBorder: InputBorder.none,
                  enabledBorder: InputBorder.none,
                ),
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Please enter Reason for a call back';
                  }
                  return null; // Return null if the input is valid
                },
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Card(
              elevation: 3,
              child: TextFormField(
                maxLines: 6,
                controller: _reasonController,
                decoration: InputDecoration(
                  contentPadding: EdgeInsets.only(left: 10, top: 0),
                  //   prefixIcon: Icon(Icons.person),
                  hintText: 'Message',
                  focusedBorder: InputBorder.none,
                  errorBorder: InputBorder.none,
                  enabledBorder: InputBorder.none,
                ),
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Please enter Message';
                  }
                  return null; // Return null if the input is valid
                },
              ),
            ),
          ],
        ),
      ),
      bottomSheet: Container(
        padding: EdgeInsets.only(bottom: 20),
        child: Container(
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
              'Save',
              style: TextStyle(color: colors.primary, fontSize: 20,fontWeight: FontWeight.bold),
            ),
          ),
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