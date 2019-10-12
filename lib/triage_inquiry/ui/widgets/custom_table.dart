import 'package:flutter/material.dart';

class CustomTable extends StatefulWidget {
  final Color backgroundColor;
  final List<Widget> contentRows;
  final Map<int, TableColumnWidth> columnWidths;
  final EdgeInsets margin;
  final Widget header;
  final double height;
  final double width;

  CustomTable({
    Key key,
    this.backgroundColor,
    this.contentRows,
    this.columnWidths,
    this.margin,
    this.header,
    this.width,
    this.height
  });

  @override
  State createState() => _CustomTable();
}

class _CustomTable extends State<CustomTable> {
  final double _externalPadding = 20.0;
  final double _contentPadding = 15.0;

  @override
  Widget build(BuildContext context) {
    final Container _header = Container(
      padding: EdgeInsets.all(_externalPadding),
      child: widget.header
    );

    final Expanded _rows = Expanded(
      child: ListView.separated(
        separatorBuilder: (BuildContext context, int index) {
          return Divider(height: 0.6);
        },
        itemCount: widget.contentRows.length,
        itemBuilder: (BuildContext context, int index) {
          return Container(
              padding: EdgeInsets.symmetric(
                  horizontal: _externalPadding,
                  vertical: _contentPadding
              ),
              child: widget.contentRows[index]
          );
        }
      )
    );

    return Container(
      height: widget.height,
      width: widget.width,
      margin: widget.margin,
      child: Card(
        elevation: 2.0,
        color: widget.backgroundColor,
        child: Column(
          children: <Widget>[
            _header,
            _header.child != null ? Divider(height: 0.6) : Container(),
            _rows
          ],
        ),
      ),
    );
  }
}