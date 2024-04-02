import 'dart:math';
import 'dart:async';

import 'package:flutter/material.dart';
import 'package:todo/pages/main.dart';

Color _bgColor = Colors.white;
Random r = Random();

class clickIcon_widget extends StatefulWidget {
  final IconData _icon;
  final bool _doColor;

  clickIcon_widget(this._icon, this._doColor);

  @override
  State<clickIcon_widget> createState() => _clickIcon_widgetState();

  Color get newColor {
    return _bgColor;
  }
}

class _clickIcon_widgetState extends State<clickIcon_widget> {
  @override
  Widget build(BuildContext context) {
    return Material(
      borderRadius: BorderRadius.circular(10),
      color: (!widget._doColor == true) ? Colors.white : _bgColor,
      child: InkWell(
        borderRadius: BorderRadius.circular(10),
        splashColor: (!widget._doColor == true) ? Colors.grey : null,
        onLongPress: () {
          if (widget._doColor) {
            setState(() {
              _bgColor = Colors.white;
            });
          }
        },
        onTap: () {
          if (widget._doColor) {
            setState(() {
              _bgColor = Color.fromRGBO(
                  r.nextInt(255), r.nextInt(255), r.nextInt(255), 1);
            });
          } else {}
        },
        child: Container(
          width: 50,
          height: 50,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
          ),
          child: Icon(
            widget._icon,
            color: Colors.black,
            size: 40,
          ),
        ),
      ),
    );
  }
}
