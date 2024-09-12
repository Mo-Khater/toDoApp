import 'package:flutter/material.dart';
import 'package:todolist/to_do_app.dart';

final kColorSchema = ColorScheme.fromSeed(
  seedColor: const Color.fromARGB(239, 155, 4, 230),
);
void main() {
  runApp(MaterialApp(
    theme: ThemeData().copyWith(
        colorScheme: kColorSchema,
        appBarTheme: const AppBarTheme().copyWith(
            backgroundColor: kColorSchema.onSecondaryContainer,
            foregroundColor: kColorSchema.surfaceBright),
        scaffoldBackgroundColor: kColorSchema.surfaceContainer),
    home: const ToDoList(),
  ));
}
