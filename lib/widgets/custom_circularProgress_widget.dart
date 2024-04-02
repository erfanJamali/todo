import 'package:flutter/material.dart';

class custom_progress extends StatelessWidget {
  const custom_progress({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        width: 70,
        height: 70,
        decoration: BoxDecoration(
            color: Colors.red, borderRadius: BorderRadius.circular(10)),
        child: const Center(
          child: CircularProgressIndicator(
            strokeCap: StrokeCap.round,
            valueColor: AlwaysStoppedAnimation(Colors.black),
          ),
        ),
      ),
    );
  }
}
