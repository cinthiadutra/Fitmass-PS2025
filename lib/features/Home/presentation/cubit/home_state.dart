
import 'package:equatable/equatable.dart';
import 'package:fitmass_flutter_test/models/task.dart';
import 'package:flutter/material.dart';

class HomeState extends Equatable {
   bool isLoading;
  List<Task> task;
  TextEditingController taskcontroller;

  HomeState({
    required this.isLoading,
    required this.task,
    required this.taskcontroller,
  });

  factory HomeState.initial() => HomeState(
      isLoading: false, task: [], taskcontroller: TextEditingController(text: ''));

  HomeState copyWith(
      {bool? isLoading,
      List<Task>? task,
      TextEditingController? taskcontroller}) {
    return HomeState(
        isLoading: isLoading ?? this.isLoading,
        task: task ?? this.task,
        taskcontroller: taskcontroller ?? this.taskcontroller);
  }

  @override
  List<Object?> get props => [isLoading, task];

  @override
  String toString() => 'HomeState(isLoading: $isLoading, task: $task)';
}
