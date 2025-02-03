import 'package:fitmass_flutter_test/features/Home/presentation/pages/take_list_screen.dart';
import 'package:flutter/material.dart';

class TaskListApp extends StatelessWidget {
  const TaskListApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme:
          ThemeData(colorScheme: ColorScheme.fromSeed(seedColor: Colors.green)),
      debugShowCheckedModeBanner: false,
      home: const TaskListScreen(),
    );
  }
}