import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:todo/models/todo.dart';
import 'package:todo/pages/view_page.dart';

void main() async {
  await Hive.initFlutter();
  Hive.registerAdapter(TodoAdapter());
  
  runApp(
    MaterialApp(
      home: const view_page(),
      debugShowCheckedModeBanner: false,
      theme: ThemeData.dark().copyWith(
        floatingActionButtonTheme:
            const FloatingActionButtonThemeData(backgroundColor: Colors.red),
      ),
    ),
  );
}
