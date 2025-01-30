import 'package:fitmass_flutter_test/models/task.dart';
import 'package:fitmass_flutter_test/api/task_fake_api.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const TaskListApp());
}

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

class TaskListScreen extends StatefulWidget {
  const TaskListScreen({super.key});

  @override
  _TaskListScreenState createState() => _TaskListScreenState();
}

class _TaskListScreenState extends State<TaskListScreen> {
  List<Task> tasks = [];
  final TextEditingController taskController = TextEditingController();
  final TaskRepository taskRepository = TaskRepository();
  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    _fetchTasks();
  }

  void _fetchTasks() {
    setState(() {
      isLoading = true;
    });
    taskRepository.fetchTasks().then((tasks) {
      setState(() {
        this.tasks = tasks;
        isLoading = false;
      });
    });
  }

  void _addTask() {
    setState(() {
      isLoading = true;
    });

    if (taskController.text.isNotEmpty) {
      final task = Task(
        name: taskController.text,
      );
      taskRepository.addTask(task).then((task) {
        setState(() {
          tasks.add(task);
          taskController.clear();
          isLoading = false;
        });
      });
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          backgroundColor: Colors.redAccent,
          content: Text('Tarefa não pode ser vazia'),
          duration: Duration(seconds: 2),
        ),
      );
      setState(() {
        isLoading = false;
      });
    }
  }

  void _removeTask(int taskId) {
    isLoading = true;
    taskRepository.removeTask(taskId).then((_) {
      setState(() {
        isLoading = false;
        tasks.removeWhere((task) => task.id == taskId);
      });
    });
  }

  void _showDeleteConfirmationDialog(int taskId) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Confirmação de Exclusão'),
          content:
              const Text('Você tem certeza que deseja excluir esta tarefa?'),
          actions: <Widget>[
            TextButton(
              child: const Text('Cancelar'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: const Text('Excluir'),
              onPressed: () {
                Navigator.of(context).pop();
                _removeTask(taskId);
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.primary,
        title: Text(
          'Fitmass Task List',
          style: TextStyle(color: Theme.of(context).colorScheme.onPrimary),
        ),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: taskController,
                    decoration: const InputDecoration(
                      hintText: 'Digite uma tarefa',
                      border: OutlineInputBorder(),
                    ),
                  ),
                ),
                const SizedBox(width: 8),
                ElevatedButton(
                  onPressed: () => _addTask(),
                  child: const Text('Adicionar'),
                ),
              ],
            ),
          ),
          Expanded(
            child: isLoading
                ? const Center(child: CircularProgressIndicator())
                : ListView.builder(
                    itemCount: tasks.length,
                    itemBuilder: (context, index) {
                      return ListTile(
                        title: Text(tasks[index].name),
                        trailing: IconButton(
                            icon: Icon(Icons.delete,
                                color: Theme.of(context).colorScheme.error),
                            onPressed: () =>
                                _showDeleteConfirmationDialog(tasks[index].id)),
                      );
                    },
                  ),
          ),
        ],
      ),
    );
  }
}
