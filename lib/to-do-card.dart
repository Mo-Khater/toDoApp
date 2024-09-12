import 'package:todolist/models/todo.dart';
import 'package:flutter/material.dart';

class Todocard extends StatelessWidget {
  final Todo todo;
  const Todocard({super.key, required this.todo});
  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          children: [
            Text(
              todo.text,
              style: TextStyle(
                decoration: todo.isChecked
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
    );
  }
}
