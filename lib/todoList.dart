import 'package:flutter/material.dart';
import 'package:todolist/models/todo.dart';
import 'package:todolist/to-do-card.dart';

class Todolist extends StatefulWidget {
  final List<Todo> toDos;
  const Todolist({super.key, required this.toDos});

  @override
  State<StatefulWidget> createState() {
    return _ToDoListState();
  }
}

class _ToDoListState extends State<Todolist> {
  @override
  Widget build(BuildContext context) {
    List<Todo> toDos = widget.toDos;
    return Expanded(
      child: ListView.builder(
        itemCount: toDos.length,
        itemBuilder: (ctx, index) {
          // card
          return Padding(
            padding: const EdgeInsets.symmetric(vertical: 6),
            child: Row(
              children: [
                Checkbox(
                  value: toDos[index].isChecked,
                  onChanged: (bool? value) {
                    setState(() {
                      toDos[index].isChecked = value!;
                    });
                  },
                ),
                Expanded(
                  child: Card(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        children: [
                          Text(
                            toDos[index].text,
                            style: TextStyle(
                              decoration: toDos[index].isChecked
                                  ? TextDecoration.lineThrough
                                  : TextDecoration.none,
                            ),
                          ),
                          const Spacer(),
                          const Icon(Icons.edit),
                          const SizedBox(
                            width: 8,
                          ),
                          const Icon(Icons.delete),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
