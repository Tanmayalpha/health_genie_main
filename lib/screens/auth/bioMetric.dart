import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:health_genie/helper/colors.dart';
import 'package:local_auth/auth_strings.dart';
import 'package:local_auth/local_auth.dart';

class BioMetricAuth extends StatefulWidget {
  const BioMetricAuth({Key? key}) : super(key: key);

  @override
  State<BioMetricAuth> createState() => _BioMetricAuthState();
}

class _BioMetricAuthState extends State<BioMetricAuth> {
  final LocalAuthentication auth = LocalAuthentication();
@override
  void initState() {
    // TODO: implement initState
    super.initState();
    checkAuth();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(children: [
        SizedBox(
          height: MediaQuery.of(context).size.height * 0.15,
        ),
        const Text(
          "Add Your Finger Print",
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
                      width:  1),
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
                'Step 3',
                style: TextStyle(
                    color: colors.primary),
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
                'Step 4',
                style: TextStyle(color: colors.primary),
              ),
            ),
            SizedBox(height: MediaQuery.of(context).size.height * 0.1,),


          ],
        ),
        const SizedBox(height: 40,),
        SizedBox(
          height: MediaQuery.of(context).size.height / 7,
          child: Image.asset(true
              ? 'assets/images/Login With Fingerprints.png'
              : 'assets/images/Log in with Face ID.png'),
        ),
        SizedBox(height: MediaQuery.of(context).size.height/5,),
        const Padding(
          padding: EdgeInsets.symmetric(horizontal: 40.0),
          child: Text(
            true
                ? "Please put your phone in front of your Fingerprints to signup"
                : "Please put your phone in front of your face to log in",
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 18, color: Colors.grey),
          ),
        )
      ],),

    );
  }

  void checkAuth() async{
    final bool canAuthenticateWithBiometrics = await auth.canCheckBiometrics;

    final bool canAuthenticate =
        canAuthenticateWithBiometrics || await auth.isDeviceSupported();
    print('___________${canAuthenticateWithBiometrics}__________');
    print('___________${canAuthenticate}__________');
    final List<BiometricType> availableBiometrics =
    await auth.getAvailableBiometrics();

    if(canAuthenticate){
      _authenticate();
    }

  }
  bool _isAuthenticating = false;

  Future<void> _authenticate() async {
    bool authenticated = false;
    String _authorized = 'Not Authorized';

    try {
      setState(() {
        _isAuthenticating = true;
        _authorized = 'Authenticating';
      });
      authenticated = await auth.authenticate(
        localizedReason: 'Let OS determine authentication method',

        androidAuthStrings: const AndroidAuthMessages(),
        stickyAuth: true
      );
      setState(() {
        _isAuthenticating = false;
      });
    } on PlatformException catch (e) {
      print(e);
      setState(() {
        _isAuthenticating = false;
        _authorized = 'Error - ${e.message}';
      });
      return;
    }
    if (!mounted) {
      return;
    }

    setState(
            () => _authorized = authenticated ? 'Authorized' : 'Not Authorized');
  }
}
