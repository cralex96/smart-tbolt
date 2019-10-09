import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:generic_bloc_provider/generic_bloc_provider.dart';
import 'package:smart_tbolt/User/ui/widgets/splash_screen.dart';
import 'package:smart_tbolt/colors/custom_color_scheme.dart';
import 'package:smart_tbolt/strings/i18n.dart';
import 'package:smart_tbolt/triage_inquiry/ui/screens/home_screen.dart';
import 'package:smart_tbolt/user/bloc/user_bloc.dart';
import 'package:smart_tbolt/widgets/app_router.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      bloc: UserBloc(),
      child: MaterialApp(
        localizationsDelegates: [
          S.delegate,
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate
        ],
        supportedLocales: S.delegate.supportedLocales,
        title: 'Smart TBolt',
        theme: ThemeData.dark().copyWith(
          canvasColor: CustomColorScheme.canvasColor
        ),
        home: HomeScreen(),
        initialRoute: '/',
        onGenerateRoute: factory
      )
    );
  }
}