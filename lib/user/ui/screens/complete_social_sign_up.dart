import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class CompleteSocialSignUp extends StatelessWidget {

  TextEditingController signUpDniController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final double _screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      body: Container(
        height: _screenHeight,
        child: Column(
          children: <Widget>[
            TextFormField(
              controller: signUpDniController,
              keyboardType: TextInputType.number,
              style: TextStyle(
                fontSize: 16.0,
                color: Colors.white
              ),
              decoration: InputDecoration(
                enabledBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.blueAccent)
                ),
                focusedBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.lightBlueAccent)
                ),
                prefixIcon: Icon(
                  FontAwesomeIcons.addressCard,
                  color: Colors.white,
                  size: 22.0,
                ),
                labelText: "Cédula",
                labelStyle: TextStyle(
                  fontSize: 17.0,
                  color: Colors.white70
                )
              ),
            ),
          ],
        ),
      ),
    );
  }
}