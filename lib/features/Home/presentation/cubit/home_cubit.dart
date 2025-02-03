// ignore_for_file: depend_on_referenced_packages

import 'package:bloc/bloc.dart';
import 'package:fitmass_flutter_test/features/Home/domain/repositories/task_fake_api.dart';
import 'package:fitmass_flutter_test/features/Home/presentation/cubit/home_state.dart';
import 'package:fitmass_flutter_test/features/Home/presentation/pages/take_list_screen.dart';

import 'package:fitmass_flutter_test/models/task.dart';
import 'package:flutter/material.dart';

class HomeCubit extends Cubit<HomeState> {
  final TaskRepository _taskRepository;
  HomeCubit()
      : _taskRepository = getIt<TaskRepository>(),
        super(HomeState.initial());

  void fetchTasks() {
    emit(state.copyWith(isLoading: true));

    _taskRepository.fetchTasks().then((tasks) {
      state.task = tasks;
      emit(state);
    });
  }

  inputchange(String value) {
    state.copyWith(taskcontroller: TextEditingController(text: value));
  }

  void addTask(
    BuildContext context,
  ) {
    emit(state.copyWith(isLoading: true));

    if (state.taskcontroller.text.isNotEmpty) {
      final task = Task(
        name: state.taskcontroller.text,
      );
      _taskRepository.addTask(task).then((tasks) {
        state.task.add(tasks);
        state.taskcontroller.clear();
        state.isLoading = false;
      });
      emit(state);
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          backgroundColor: Colors.redAccent,
          content: Text('Tarefa não pode ser vazia'),
          duration: Duration(seconds: 2),
        ),
      );

      emit(state);
    }
  }

  void removeTask(int taskId) {
    emit(state.copyWith(isLoading: true));

    _taskRepository.removeTask(taskId).then((_) {
      state.task.removeWhere((task) => task.id == taskId);
    });
  }
}
