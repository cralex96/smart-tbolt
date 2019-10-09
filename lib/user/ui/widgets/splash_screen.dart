import 'dart:async';

import 'package:flutter/material.dart';

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
    Navigator.pushReplacementNamed(context, '/login');
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