import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class responsButton extends StatelessWidget {
  final String _text;
  final double _coefficient;
  final Color _bgColor;
  final Color _txtColor;
  final VoidCallback _fun;

  const responsButton(
      this._text, this._coefficient, this._bgColor, this._txtColor, this._fun);

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerLeft,
      child: Material(
        color: _bgColor,
        borderRadius: BorderRadius.circular(10),
        child: InkWell(
          onTap: _fun,
          borderRadius: BorderRadius.circular(10),
          child: Container(
            width: (MediaQuery.of(context).size.width - 15) * _coefficient,
            height: 50,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
            ),
            child: Center(
                child: Text(
              _text,
              style: TextStyle(color: _txtColor, fontSize: 25),
            )),
          ),
        ),
      ),
    );
  }
}
