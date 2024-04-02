import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:todo/models/todo.dart';
import 'package:todo/pages/note_page.dart';
import 'package:todo/widgets/custom_circularProgress_widget.dart';

import '../widgets/noteCard_widget.dart';

class view_page extends StatefulWidget {
  const view_page({super.key});

  @override
  State<view_page> createState() => _view_pageState();
}

int noteNum = 0;

class _view_pageState extends State<view_page> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Notes",
          style: TextStyle(color: Colors.black),
        ),
        actions: [
          Text(
            noteNum.toString(),
            style: const TextStyle(color: Colors.black),
          ),
          const SizedBox(width: 10),
        ],
        backgroundColor: Colors.red,
      ),
      body: FutureBuilder(
        future: Hive.openBox('todo'),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done &&
              snapshot.hasData) {
            return noteViewBuilder();
          } else {
            return const custom_progress();
          }
        },
      ),
      floatingActionButton: FloatingActionButton(
        splashColor: Colors.black,
        onPressed: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => note_page(isNew: true, textIndex: 0),
              ));
        },
        child: const Icon(
          Icons.add,
          color: Colors.black,
        ),
      ),
    );
  }

  Widget noteViewBuilder() {
    final Box todoBox = Hive.box('todo');
    return ValueListenableBuilder(
        valueListenable: todoBox.listenable(),
        builder: (context, Box box, _) {
          if (box.isEmpty) {
            return const Center(child: Text("there's not any note here!"));
          } else {
            return ListView.builder(
              itemCount: box.length,
              itemBuilder: (context, index) {
                final Todo todo = box.getAt(index);
                return noteCard(
                    todo.text, todo.priority, index, todoBox.length, context);
              },
            );
          }
        });
  }
}
