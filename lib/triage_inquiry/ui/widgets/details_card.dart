import 'package:flutter/material.dart';

class DetailsCard extends StatefulWidget {
  final IconData icon;
  final String title;
  final String subtitle;
  final double height;
  final double width;
  final EdgeInsets margin;
  final Color color;
  final Color titleFontColor;
  final Color subtitleFontColor;
  final ShapeBorder shape;

  DetailsCard({
    Key key,
    this.icon,
    this.title = "",
    this.subtitle = "",
    this.height,
    this.width,
    this.margin = EdgeInsets.zero,
    this.color,
    this.titleFontColor,
    this.subtitleFontColor,
    this.shape
  });

  @override
  State createState() => _DetailsCard();
}

class _DetailsCard extends State<DetailsCard> {
  final double _padding = 15.0;

  @override
  Widget build(BuildContext context) {
    final Container _icon = Container(
      padding: EdgeInsets.all(_padding),
      child: Icon(widget.icon),
    );

    final Column _content = Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Container(
          padding: EdgeInsets.only(
            top: _padding,
            right: _padding
          ),
          child: Text(
            widget.title,
            style: TextStyle(
              fontSize: 15.0,
              fontWeight: FontWeight.bold,
              color: widget.titleFontColor
            ),
          ),
        ),
        Container(
          padding: EdgeInsets.only(
            right: _padding,
            bottom: _padding
          ),
          child: Text(
            widget.subtitle,
            style: TextStyle(
              fontSize: 15.0,
              fontStyle: FontStyle.italic,
              color: widget.subtitleFontColor
            ),
          ),
        )
      ],
    );

    return Container(
      height: widget.height,
      width: widget.width,
      margin: widget.margin,
      child: Card(
        color: widget.color,
        elevation: 2.0,
        shape: widget.shape,
        child: Row(
          children: <Widget>[
            _icon,
            _content
          ],
        ),
      ),
    );
  }
}