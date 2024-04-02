import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:todo/pages/note_page.dart';

class noteCard extends StatelessWidget {
  final String text;
  final int priority;
  final int index;
  final int maxCount;
  final BuildContext context;

  noteCard(this.text, this.priority, this.index, this.maxCount, this.context,
      {super.key});

  late Size widgetSize;

  @override
  Widget build(BuildContext context) {
    double topHeight = (index == 0) ? 30 : 15;
    widgetSize = MediaQuery.of(context).size;
    return Stack(
      children: [
        Align(
          alignment: Alignment.topLeft,
          child: Padding(
            padding:
                EdgeInsets.only(left: widgetSize.width * 0.06, top: topHeight),
            child: Text(
              (index + 1).toString(),
              style: const TextStyle(color: Colors.black),
            ),
          ),
        ),
        Align(
          alignment: Alignment.center,
          child: Container(
            margin: EdgeInsets.only(top: topHeight),
            width: widgetSize.width * 0.9,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(7),
            ),
            child: Material(
              borderRadius: BorderRadius.circular(7),
              color: (index % 2 == 0) ? Colors.white10 : Colors.white24,
              child: InkWell(
                splashColor: Colors.red,
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) =>
                            note_page(isNew: false, textIndex: index),
                      ));
                },
                borderRadius: BorderRadius.circular(7),
                child: Padding(
                  padding: const EdgeInsets.all(15),
                  child: Stack(
                    children: [
                      Align(
                         alignment: Alignment.topRight,
                        child: IconButton(
                          icon: const Icon(Icons.remove_circle_rounded),
                          color: Colors.redAccent,
                          onPressed: () {
                            deleteFun(index);
                          },
                        ),
                      ),
                      Align(
                        alignment: Alignment.bottomLeft,
                        child: Text(text, maxLines: 3),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}

Future deleteFun(int index) async {
  Box box = await Hive.openBox('todo');
  box.deleteAt(index);
}
