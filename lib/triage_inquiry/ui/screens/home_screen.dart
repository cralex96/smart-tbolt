import 'package:flutter/material.dart';
import 'package:generic_bloc_provider/generic_bloc_provider.dart';
import 'package:smart_tbolt/colors/custom_color_scheme.dart';
import 'package:smart_tbolt/strings/i18n.dart';
import 'package:smart_tbolt/user/bloc/user_bloc.dart';
import 'package:smart_tbolt/widgets/custom_appbar.dart';
import 'package:smart_tbolt/widgets/custom_drawer.dart';

class HomeScreen extends StatefulWidget {

  HomeScreen({Key key}) : super(key: key);

  @override
  State createState() => _HomeScreen();
}

class _HomeScreen extends State<HomeScreen> {

  UserBloc userBloc;

  @override
  Widget build(BuildContext context) {
    userBloc = BlocProvider.of(context);

    return Scaffold(
      appBar: CustomAppBar(title: S.of(context).appName),
      body: Container(
        color: CustomColorScheme.backgroundColor,
      ),
      drawer: CustomDrawer()
    );
  }
}