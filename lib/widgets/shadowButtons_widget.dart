import 'package:flutter/material.dart';

class shadowButtons_widget extends StatelessWidget {
  final Color _bgColor;
  final Color _txtColor;
  final String _txt;
  final Size _bgSize;
  final VoidCallback _fun;

  const shadowButtons_widget(
      this._bgColor, this._txtColor, this._txt, this._bgSize, this._fun);

  @override
  Widget build(BuildContext context) {
    return Material(
      color: _bgColor,
      borderRadius: BorderRadius.circular(10),
      child: InkWell(
        splashColor: Colors.red,
        onTap: _fun,
        borderRadius: BorderRadius.circular(10),
        child: Container(
          width: _bgSize.width * 0.35,
          height: _bgSize.height * 0.3,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            boxShadow: [
              BoxShadow(color: _bgColor, spreadRadius: 1, blurRadius: 10),
            ],
          ),
          child: Center(
            child: Text(
              _txt,
              style: TextStyle(fontSize: 20, color: _txtColor),
            ),
          ),
        ),
      ),
    );
  }
}
