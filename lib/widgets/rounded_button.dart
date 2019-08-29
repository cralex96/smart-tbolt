import 'package:flutter/material.dart';

// ignore: must_be_immutable
class RoundedButton extends StatefulWidget {

  final Text text;
  final VoidCallback onPressed;
  Color backgroundColor;
  double width = 0.0;
  double height = 0.0;
  EdgeInsets margin = EdgeInsets.all(0.0);

  RoundedButton({
    Key key,
    @required this.text,
    @required this.onPressed,
    this.height,
    this.width,
    this.backgroundColor = Colors.black54,
    this.margin
  });

  @override
  State createState() {
    return _RoundedButton();
  }
}

class _RoundedButton extends State<RoundedButton> {

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: widget.margin,
      child: Row(
        children: <Widget>[
          Expanded(
            child: FlatButton(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(30.0),
                side: BorderSide(color: Colors.lightBlueAccent, width: 3.0)
              ),
              splashColor: widget.backgroundColor,
              color: widget.backgroundColor,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.only(top: 20.0, bottom: 20.0),
                    child: widget.text,
                  ),
                ],
              ),
              onPressed: widget.onPressed,
            ),
          ),
        ],
      ),
    );
  }
}