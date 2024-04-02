import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:todo/models/todo.dart';
import 'package:todo/widgets/clickIcon_widget.dart';
import 'package:todo/widgets/responsiveButton_widget.dart';
import 'package:todo/widgets/shadowButtons_widget.dart';

class note_page extends StatefulWidget {
  @override
  State<note_page> createState() => _note_pageState();

  final bool isNew;
  final int textIndex;

  note_page({required this.isNew, required this.textIndex});
}

int fontVal = 25;
late Size thisSize;
TextEditingController noteTextController = TextEditingController();

class _note_pageState extends State<note_page> {
  @override
  void initState() {
    super.initState();
    //
    if (!widget.isNew) {
      initText();
      return;
    }
    //
    noteTextController.clear();
  }

  Future initText() async {
    Box box = await Hive.openBox('todo');
    Todo todoBox = box.getAt(widget.textIndex);
    noteTextController.text = todoBox.text;
  }

  @override
  Widget build(BuildContext context) {
    //
    clickIcon_widget changeColorWidget =
        clickIcon_widget(Icons.color_lens_rounded, true);
    //
    thisSize = MediaQuery.of(context).size;
    //
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: Center(
            child: SizedBox(
              width: MediaQuery.of(context).size.width - 30,
              child: Column(
                children: [
                  Center(
                    child: Container(
                      padding: const EdgeInsets.only(top: 25),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              clickIcon_widget(Icons.remove, false),
                              const SizedBox(width: 15),
                              Text(
                                fontVal.toString(),
                                style: const TextStyle(
                                    color: Colors.white, fontSize: 30),
                              ),
                              const SizedBox(width: 15),
                              clickIcon_widget(Icons.add, false),
                            ],
                          ),
                          clickIcon_widget(Icons.format_bold_rounded, false),
                          clickIcon_widget(Icons.format_italic_rounded, false),
                          clickIcon_widget(
                              Icons.format_underline_rounded, false),
                          changeColorWidget
                        ],
                      ),
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(vertical: 20),
                    child: TextField(
                      controller: noteTextController,
                      style: TextStyle(color: changeColorWidget.newColor),
                      maxLines: 50,
                      minLines: 1,
                      cursorColor: Colors.red,
                      cursorWidth: 3,
                      cursorRadius: const Radius.circular(1.5),
                      decoration: InputDecoration(
                        labelText:
                            (widget.isNew) ? "write your note here..." : null,
                        focusedBorder: const OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.red),
                        ),
                        border: const OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.red),
                        ),
                      ),
                    ),
                  ),
                  Row(
                    children: [
                      responsButton("back", 0.2, Colors.white, Colors.black,
                          () {
                        backFun(context);
                      }),
                      const Spacer(),
                      responsButton((widget.isNew) ? "save" : "update", 0.7,
                          Colors.red, Colors.white, () {
                        saveFun(context, widget.isNew);
                      }),
                    ],
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

void saveFun(context, bool isNew) {
  //
  String snackText = (isNew)
      ? "new note [''] has added successfully"
      : "the [''] has updated successfully";
  //
  //
  if (isNew) {
    addNoteBTN(priority: 0, text: noteTextController.text);
  } else {
    // updateBTN(priority: priority, text: text)
  }
  //
  SnackBar snack = SnackBar(content: Text(snackText));
  ScaffoldMessenger.of(context).showSnackBar(snack);
  //
  Navigator.pop(context);
}

void addNoteBTN({required int priority, required String text}) async {
  Todo todo = Todo(text: text, priority: priority);
  Box box = await Hive.openBox('todo');
  box.add(todo);
}

void updateBTN({required int priority, required String text}) async {
  // Box box = await Hive.openBox('todo');
}

backFun(context) {
  showDialog(
    builder: (context) {
      Size dialogSize = Size(thisSize.width * 0.8, thisSize.height * 0.3);
      return Material(
        color: Colors.black.withOpacity(0.7),
        child: Center(
          child: Container(
            width: dialogSize.width,
            height: dialogSize.height,
            decoration: BoxDecoration(
              color: Colors.red.shade700,
              borderRadius: BorderRadius.circular(10),
              boxShadow: const [
                BoxShadow(color: Colors.red, spreadRadius: 1, blurRadius: 10),
              ],
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Padding(
                  padding: EdgeInsets.all(18.0),
                  child: Text(
                    "Are you sure want to exit without save note???",
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 25),
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    shadowButtons_widget(
                        Colors.black, Colors.white, "YES", dialogSize, () {
                      Navigator.pop(context);
                      Navigator.pop(context);
                    }),
                    shadowButtons_widget(
                        Colors.white, Colors.black, "NO", dialogSize, () {
                      Navigator.pop(context);
                    }),
                  ],
                ),
                const SizedBox(height: 6),
              ],
            ),
          ),
        ),
      );
    },
    context: context,
  );
}
