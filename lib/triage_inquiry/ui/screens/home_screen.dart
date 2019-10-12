import 'package:flutter/material.dart';
import 'package:generic_bloc_provider/generic_bloc_provider.dart';
import 'package:smart_tbolt/colors/custom_color_scheme.dart';
import 'package:smart_tbolt/strings/i18n.dart';
import 'package:smart_tbolt/triage_inquiry/ui/widgets/custom_table.dart';
import 'package:smart_tbolt/triage_inquiry/ui/widgets/details_card.dart';
import 'package:smart_tbolt/user/bloc/user_bloc.dart';
import 'package:smart_tbolt/widgets/custom_appbar.dart';
import 'package:smart_tbolt/widgets/custom_drawer.dart';

class HomeScreen extends StatefulWidget {

  HomeScreen({Key key}) : super(key: key);

  @override
  State createState() => _HomeScreen();
}

class _HomeScreen extends State<HomeScreen> {

  final Color _cardBackgroundColor = CustomColorScheme.primaryColor;
  final Color _cardTitleFontColor = CustomColorScheme.secondaryColor;
  final Color _cardSubtitleFontColor = CustomColorScheme.secondaryColorAccent;

  UserBloc userBloc;

  @override
  Widget build(BuildContext context) {
    final double _screenWidth = MediaQuery.of(context).size.width;

    final double _cardWidth = _screenWidth / 2.5;
    final double _tableHeight = 305.0;

    userBloc = BlocProvider.of(context);

    final DetailsCard _firstCard = DetailsCard(
      color: _cardBackgroundColor,
      titleFontColor: _cardTitleFontColor,
      subtitleFontColor: _cardSubtitleFontColor,
      icon: Icons.airline_seat_flat,
      title: "1498",
      subtitle: "Pacientes",
      width: _cardWidth,
      margin: EdgeInsets.symmetric(
        vertical: 20.0
      ),
    );

    final DetailsCard _secondCard = DetailsCard(
      color: _cardBackgroundColor,
      titleFontColor: _cardTitleFontColor,
      subtitleFontColor: _cardSubtitleFontColor,
      icon: Icons.airport_shuttle,
      title: "87613",
      subtitle: "Otros",
      width: _cardWidth,
      margin: EdgeInsets.symmetric(
        vertical: 20.0
      ),
    );

    return Scaffold(
      appBar: CustomAppBar(title: S.of(context).appName),
      body: LayoutBuilder(
        builder: (BuildContext context, BoxConstraints viewportConstraints) {
          return SingleChildScrollView(
            child: ConstrainedBox(
              constraints: BoxConstraints(
                minHeight: viewportConstraints.maxHeight
              ),
              child: Container(
                color: CustomColorScheme.backgroundColor,
                child: Column(
                  children: <Widget>[
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: <Widget>[
                        _firstCard,
                        _secondCard
                      ],
                    ),
                    CustomTable(
                      height: _tableHeight,
                      backgroundColor: CustomColorScheme.primaryColor,
                      margin: EdgeInsets.symmetric(horizontal: 20.0),
                      header: Text("Header"),
                      contentRows: <Widget> [
                        Text("Paciente 1"),
                        Text("Paciente 2"),
                        Text("Paciente 3"),
                        Text("Paciente 4"),
                        Text("Paciente 5")
                      ]
                    )
                  ],
                )
              ),
            ),
          );
        },
      ),
      drawer: CustomDrawer()
    );
  }
}