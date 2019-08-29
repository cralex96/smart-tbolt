import 'package:flutter/material.dart';

class CustomMaterialRouter<T> extends MaterialPageRoute<T> {
  CustomMaterialRouter({WidgetBuilder builder, RouteSettings settings})
      : super(builder: builder, settings: settings);
  @override
  Duration get transitionDuration => const Duration(milliseconds: 2000);

  @override
  Widget buildTransitions(BuildContext context, Animation<double> animation,
      Animation<double> secondaryAnimation, Widget child) {
    if (settings.isInitialRoute) {
      return child;
    }

    return FadeTransition(opacity: animation, child: child);
  }
}