import 'package:flutter/material.dart';
import 'package:todolist/models/todo.dart'; // Import the Todo model

class ToDoList extends StatefulWidget {
  const ToDoList({super.key});

  @override
  State<ToDoList> createState() => _ToDoListState();
}

class _ToDoListState extends State<ToDoList> {
  List<Todo> toDos = [
    Todo(isChecked: false, text: 'cooking'),
    Todo(isChecked: false, text: 'watch movies'),
  ];

  final controller = TextEditingController();
  final editController = TextEditingController();

  void addTODo(final todo) {
    if (controller.text.trim() == '') {
      showDialog(
          context: context,
          builder: (ctx) => AlertDialog(
                title: const Text('Invalid input'),
                content: const Text('You should add a todo first'),
                actions: [
                  TextButton(
                    onPressed: () {
                      Navigator.pop(ctx);
                    },
                    child: const Text("Okay"),
                  )
                ],
              ));
      return;
    }
    setState(() {
      toDos.add(todo);
      controller.text = "";
    });
    FocusScope.of(context).unfocus();
  }

  void removeTodo(todo, index) {
    setState(() {
      toDos.remove(todo);
    });

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: const Text('A ToDo deleted'),
        duration: const Duration(seconds: 2),
        action: SnackBarAction(
            label: 'Undo',
            onPressed: () {
              setState(() {
                toDos.insert(index, todo);
              });
            }),
      ),
    );
  }

  void editTodo(final todo, final index) {
    editController.text = todo.text;
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('Edit ToDo'),
        content: TextField(
          controller: editController,
          decoration: const InputDecoration(
            hintText: 'Edit todo',
          ),
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(ctx);
            },
            child: const Text("Cancel"),
          ),
          TextButton(
            onPressed: () {
              setState(() {
                toDos[index] = Todo(
                  isChecked: todo.isChecked,
                  text: editController.text,
                );
              });
              Navigator.pop(ctx);
            },
            child: const Text("Save"),
          )
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Your ToDos Today'),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.fromLTRB(15, 50, 15, 20),
        child: Column(
          children: [
            Expanded(
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
                              padding: const EdgeInsets.symmetric(
                                  vertical: 10, horizontal: 15),
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
                                  IconButton(
                                    padding: const EdgeInsets.all(0),
                                    onPressed: () {
                                      editTodo(toDos[index], index);
                                    },
                                    icon: const Icon(Icons.edit),
                                  ),
                                  IconButton(
                                    onPressed: () {
                                      removeTodo(toDos[index], index);
                                    },
                                    icon: const Icon(Icons.delete),
                                  ),
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
            ),
            // Row to add new Todo item
            Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: controller,
                    decoration: const InputDecoration(
                      hintText: 'Add a new todo',
                    ),
                  ),
                ),
                IconButton(
                  onPressed: () {
                    addTODo(Todo(isChecked: false, text: controller.text));
                  },
                  icon: const Icon(Icons.add),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
