import 'package:fitmass_flutter_test/features/Home/presentation/cubit/home_cubit.dart';
import 'package:fitmass_flutter_test/models/task.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';

final GetIt getIt = GetIt.instance;

class TaskListScreen extends StatefulWidget {
  const TaskListScreen({super.key});

  @override
  _TaskListScreenState createState() => _TaskListScreenState();
}

class _TaskListScreenState extends State<TaskListScreen> {
  List<Task> tasks = [];
  final TextEditingController taskController = TextEditingController();

  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    getIt<HomeCubit>().fetchTasks();
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
      body: Column(children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            children: [
              Expanded(
                child: TextFormField(
                  controller: taskController,
                  onChanged: (value) {
                    context.read<HomeCubit>().inputchange(value);
                  },
                  decoration: const InputDecoration(
                    hintText: 'Digite uma tarefa',
                    border: OutlineInputBorder(),
                  ),
                ),
              ),
              const SizedBox(width: 8),
              ElevatedButton(
                onPressed: () => context.read<HomeCubit>().addTask(context),
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
                          onPressed: () => showDeleteConfirmationDialog(
                              tasks[index].id,
                              () => context
                                  .read<HomeCubit>()
                                  .removeTask(tasks[index].id)),
                        ),
                      );
                    }))
      ]),
    );
  }

  void showDeleteConfirmationDialog(int taskId, VoidCallback ontap) {
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
              },
            ),
          ],
        );
      },
    );
  }
}
