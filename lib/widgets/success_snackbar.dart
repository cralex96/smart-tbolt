import 'package:flutter/material.dart';

class SuccessSnackBar {
  final GlobalKey<ScaffoldState> scaffoldKey;

  // Constructor.
  SuccessSnackBar({
    Key key,
    @required this.scaffoldKey
  });

  // Generate a custom SnackBar.
  void showInSnackBar(String value) {
    scaffoldKey.currentState?.removeCurrentSnackBar();
    scaffoldKey.currentState.showSnackBar(SnackBar(
      content: Text(
          value,
          textAlign: TextAlign.center,
          style: TextStyle(
            color: Colors.white,
            fontSize: 16.0,
          )
      ),
      //backgroundColor: Colors.redAccent,
      duration: Duration(seconds: 5),
    ));
  }
}