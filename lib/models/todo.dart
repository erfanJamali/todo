import 'package:hive/hive.dart';

part 'todo.g.dart';

@HiveType(typeId: 1)
class Todo {
  @HiveField(0)
  int priority = 0;

  @HiveField(1)
  String text = '';

  Todo({required this.text, required this.priority});
}
