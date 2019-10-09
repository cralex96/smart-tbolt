import 'package:flutter/material.dart';
import 'package:smart_tbolt/User/ui/screens/complete_social_sign_up.dart';
import 'package:smart_tbolt/User/ui/screens/sign_in_sign_up_screen.dart';
import 'package:smart_tbolt/User/ui/widgets/splash_screen.dart';
import 'package:smart_tbolt/triage_inquiry/ui/screens/home_screen.dart';

const String splash = '/splash';
const String login = '/login';
const String completeSignUp = '/complete_sign_up';
const String home = '/home';

WidgetBuilder builder;

// Settings that manages the routes for the app.
RouteFactory factory = (RouteSettings settings) {
  switch (settings.name) {
    case splash:
      builder = (BuildContext _) => SplashScreen();
      break;
    case login:
      builder = (BuildContext _) => SignInSignUpScreen();
      break;
    case home:
      builder = (BuildContext _) => HomeScreen();
      break;
    case completeSignUp:
      builder = (BuildContext _) => CompleteSocialSignUp();
      break;
    default:
      throw new Exception('Invalid Route: ${settings.name}');
  }
  return CustomMaterialRouter(builder: builder, settings: settings);
};

// Custom Modal route for transitions between screens.
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