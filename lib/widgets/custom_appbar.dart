import 'package:flutter/material.dart';
import 'package:smart_tbolt/colors/custom_color_scheme.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;

  CustomAppBar({Key key, this.title});

  final double bottomLineSize = 2.0;
  final Size preferredSize = Size.fromHeight(60.0);
  final Color _backgroundColor = CustomColorScheme.primaryColor;
  final Color _fontColor = CustomColorScheme.secondaryColor;

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: _backgroundColor,
      title: Text(
        title,
        style: TextStyle(
          color: _fontColor,
        ),
      ),
      iconTheme: IconThemeData(
        color: _fontColor
      ),
    );
  }
}