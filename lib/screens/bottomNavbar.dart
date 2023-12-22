import 'package:fluid_bottom_nav_bar/fluid_bottom_nav_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:health_genie/helper/colors.dart';
import 'package:health_genie/screens/home_page.dart';
import 'package:health_genie/screens/smart_device.dart';

class BottomNavBar extends StatefulWidget {
  const BottomNavBar({super.key});

  @override
  State<BottomNavBar> createState() => _BottomNavBarState();
}

class _BottomNavBarState extends State<BottomNavBar> {
  Widget? _child;
  int selectedIndex = 0;
  @override
  void initState() {
    _child = HomePageWidget();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: selectedIndex == 0
          ? AppBar(
              backgroundColor: Colors.grey,
              leading: IconButton(
                  onPressed: () {},
                  icon: Icon(
                    Icons.person_pin,
                    size: 30,
                    color: colors.primary,
                  )),
              centerTitle: true,
              title: Image.asset(
                'assets/images/logo.png',
                height: 50,
              ),
              actions: [
                InkWell(
                  child: Image.asset(
                    'assets/images/Group 73318.png',
                    fit: BoxFit.fitWidth,
                    // height: 30,
                    width: 25,
                  ),
                ),
                SizedBox(
                  width: 10,
                ),
                InkWell(
                  child: Image.asset(
                    'assets/images/Group 72045.png',
                    fit: BoxFit.fitWidth,
                    // height: 30,
                    width: 25,
                  ),
                ),
                SizedBox(
                  width: 10,
                ),
              ],
            )
          : AppBar(
              backgroundColor: Colors.grey,
              leading: IconButton(
                  onPressed: () {
                    // _handleNavigationChange(0);
                  },
                  icon: Icon(
                    Icons.arrow_back_ios_new,
                    color: colors.primary,
                  )),
              centerTitle: true,
              title: Text(
                selectedIndex == 3 ? '' : 'Health Genie',
                style: TextStyle(
                  color: colors.primary,
                  fontSize: 20,
                ),
              ),
            ),
      body: _child,
      bottomNavigationBar: FluidNavBar(
        icons: [
          FluidNavBarIcon(
              icon: selectedIndex == 0 ? Icons.home : Icons.home_outlined,

              //  svgPath: "assets/home.svg",
              backgroundColor: colors.primary,
              extras: {"label": "Home"}),
          FluidNavBarIcon(
              icon: selectedIndex == 1 ? null : Icons.mobile_friendly_rounded,
              svgPath:
                  selectedIndex == 1 ? 'assets/images/mobile_fill.svg' : null,
              backgroundColor: colors.primary,
              extras: {"label": "Smart Device"}),
          FluidNavBarIcon(
              // icon: Icons.share,

              svgPath: selectedIndex == 2
                  ? 'assets/images/whatsapp_fill.svg'
                  : 'assets/images/whatsapp.svg',
              backgroundColor: colors.primary,
              extras: {"label": "Whatsapp"}),
          FluidNavBarIcon(
              icon: selectedIndex == 3 ? Icons.shield : Icons.shield_outlined,
              backgroundColor: colors.primary,

              extras: {"label": "Warrenty"}),
        ],
        onChange: _handleNavigationChange,
        style: FluidNavBarStyle(
            barBackgroundColor: colors.primary,
            iconUnselectedForegroundColor: Colors.white,
            iconSelectedForegroundColor: Colors.white),
        scaleFactor: 1.5,
        defaultIndex: 0,
        animationFactor: 0.5,
        itemBuilder: (icon, item) => Semantics(
          label: icon.extras!["label"],
          container: true,
          enabled: true,
          child: Stack(
            children: [
              item,
              Container(
                  width: MediaQuery.of(context).size.width * 0.25- 25,
                  margin: EdgeInsets.only(top: 36),
                  child: Center(
                      child: Text(
                    icon.extras!["label"],
                    style: TextStyle(color: Colors.white, fontSize: 10,fontWeight: FontWeight.bold),
                  )))
            ],
          ),
        ),
      ),
    );
  }

  void _handleNavigationChange(int index) {
    setState(() {
      selectedIndex = index;
      switch (index) {
        case 0:
          _child = HomePageWidget();
          break;
        case 1:
          _child = SmartDevice();
          break;
        case 2:
          _child = Container();
          break;
        case 3:
          _child = Container();
          break;
      }
      _child = AnimatedSwitcher(
        switchInCurve: Curves.bounceOut,
        switchOutCurve: Curves.bounceIn,
        duration: Duration(milliseconds: 100),
        child: _child,
      );
    });
  }
}