import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:smart_tbolt/colors/custom_color_scheme.dart';

class CustomDrawer extends StatefulWidget {
  final String headerTitle;
  final String headerSubtitle;
  final String headerEmail;
  final String profilePhotoPath;

  CustomDrawer({
    Key key,
    this.headerTitle = "User",
    this.headerSubtitle = "Developer",
    this.headerEmail = "user@email.com",
    this.profilePhotoPath = "assets/images/default_user.png"
  });

  @override
  State createState() => _CustomDrawer();


}

class _CustomDrawer extends State<CustomDrawer> {
  final double _circleSize = 35.0;
  
  final List<Map<String, dynamic>> _listViewData = [
    {'title': 'Inicio', 'icon': Icons.home},
    {'title': 'Triage', 'icon': Icons.accessibility},
    {'title': 'Historia Clínica', 'icon': Icons.assignment}
  ];
  
  int _selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    // The profile photo of the Drawer Header.
    final Row _profilePhoto = Row(
      children: <Widget>[
        Container(
          margin: EdgeInsets.only(
            right: 20.0,
            bottom: 20.0
          ),
          child: CircleAvatar(
            radius: _circleSize,
            backgroundImage: AssetImage(widget.profilePhotoPath),
          ),
        ),
        Container(
          margin: EdgeInsets.only(bottom: 20.0),
          child: Text(
            widget.headerTitle,
            style: TextStyle(
                fontSize: 18.0
            ),
          ),
        )
      ],
    );

    final Container _headerSubtitleText = Container(
      margin: EdgeInsets.only(bottom: 3.0),
      child: Text(
        widget.headerSubtitle,
        style: TextStyle(
            fontSize: 16.0
        ),
      ),
    );

    final Container _headerEmailText = Container(
      margin: EdgeInsets.only(bottom: 5.0),
      child: Text(
        widget.headerEmail,
        style: TextStyle(
            fontSize: 14.0,
            fontStyle: FontStyle.italic
        ),
      )
    );

    return Drawer(
      child: Column(
        children: <Widget>[
          DrawerHeader(
            decoration: BoxDecoration(
              border: Border(
                bottom: BorderSide(
                  color: CustomColorScheme.primaryColor,
                    width: 2.0
                  )
              )
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                _profilePhoto,
                _headerSubtitleText,
                _headerEmailText
              ],
            )
          ),
          Expanded(
            child: ListView.builder(
              padding: EdgeInsets.zero,
              physics: PageScrollPhysics(),
              itemCount: _listViewData.length,
              itemBuilder: (context, index) => Ink(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5.0),
                  color: _selectedIndex == index ? CustomColorScheme.primaryColor : null,
                ),
                child: ListTileTheme(
                  style: ListTileStyle.drawer,
                  child: ListTile(
                    leading: Icon(_listViewData[index]['icon']),
                    title: Text(_listViewData[index]['title']),
                    onTap: () => _selectIndex(index),
                  ),
                ),
              )
            )
          )
        ]
      )
    );
  }

  void _selectIndex(int index) {
    setState(() => _selectedIndex = index);
  }
}