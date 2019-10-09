import 'package:flutter/material.dart';
import 'package:smart_tbolt/colors/custom_color_scheme.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;

  CustomAppBar({Key key, this.title});

  final double bottomLineSize = 2.0;

  final Size preferredSize = Size.fromHeight(60.0);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      bottom: PreferredSize(
        child: Container(
          color: CustomColorScheme.primaryColor,
          height: bottomLineSize,
        ),
        preferredSize: Size.fromHeight(bottomLineSize),
      ),
      backgroundColor: CustomColorScheme.backgroundColor,
      title: Text(
        title,
        style: TextStyle(
          color: CustomColorScheme.primaryColor,
        ),
      ),
      iconTheme: IconThemeData(
        color: CustomColorScheme.primaryColorAccent
      ),
    );
  }
}