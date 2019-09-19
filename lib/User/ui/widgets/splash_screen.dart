import 'dart:async';

import 'package:flutter/material.dart';
import 'package:smart_tbolt/User/ui/screens/sign_in_screen.dart';
import 'package:smart_tbolt/User/ui/widgets/custom_material_router.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreen createState() => _SplashScreen();
}

class _SplashScreen extends State<SplashScreen> {

  FlutterLogoStyle _logoStyle = FlutterLogoStyle.markOnly;
  Duration _splashDuration = Duration(seconds: 2);
  Duration _animDuration = Duration(seconds: 1);

  _SplashScreen() {
    Timer(_animDuration, () {
      setState(() {
        _logoStyle = FlutterLogoStyle.horizontal;
      });
    });
  }

  void navigateToLogin() {
    Navigator.pushReplacement(
        context,
        CustomMaterialRouter(builder: (context) => SignInScreen())
    );
  }

  @override
  void initState() {
    super.initState();
    
    initData().then((value) {
      navigateToLogin();
    });
  }

  Future initData() async {
    await Future.delayed(_splashDuration);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Container(
          color: Colors.black,
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          child: Hero(
            tag: 'logo',
            child: FlutterLogo(
              size: 200.0,
              style: _logoStyle,
            ),
          ),
        ),
      ),
    );
  }

}