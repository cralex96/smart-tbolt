import 'package:flutter/material.dart';
import 'package:generic_bloc_provider/generic_bloc_provider.dart';
import 'package:smart_tbolt/User/bloc/user_bloc.dart';
import 'package:smart_tbolt/User/ui/screens/sign_in_screen.dart';
import 'package:smart_tbolt/widgets/splash_screen.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        bloc: UserBloc(),
        child: MaterialApp(
          title: 'Flutter Demo',
          theme: ThemeData.dark(),
          home: SplashScreen(),
          initialRoute: 'main',
          routes: {
            'main': (context) => SplashScreen()
          },
        )
    );
  }
}