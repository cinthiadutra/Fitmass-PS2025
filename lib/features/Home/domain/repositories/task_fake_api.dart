import 'dart:convert';

import 'package:http/http.dart' as http;
import '../../../../models/task.dart';

class TaskRepository {
  final String baseUrl = "https://jsonplaceholder.typicode.com/todos";

  /// Busca uma lista de tarefas da API.
  /// Retorna uma lista de objetos [Task].
  /// Lança uma exceção se a requisição falhar.
  Future<List<Task>> fetchTasks() async {
    final response = await http.get(Uri.parse(baseUrl));

    if (response.statusCode == 200) {
      List<dynamic> data = jsonDecode(response.body);
      return data.map((json) => Task.fromJson(json)).take(5).toList();
    } else {
      throw Exception("Falha ao carregar tarefas");
    }
  }

  /// Adiciona uma nova tarefa na API.
  /// Recebe um objeto [Task] e retorna o objeto [Task] criado.
  /// Lança uma exceção se a requisição falhar.
  Future<Task> addTask(Task task) async {
    final response = await http.post(
      Uri.parse(baseUrl),
      headers: {"Content-Type": "application/json"},
      body: jsonEncode(task.toJson()),
    );

    if (response.statusCode == 201) {
      Map<String, dynamic> json = jsonDecode(response.body);
      return Task(
        name: json['title'],
      );
    } else {
      throw Exception("Falha ao adicionar tarefa");
    }
  }

  /// Remove uma tarefa da API.
  /// Recebe o [taskId] da tarefa a ser removida.
  /// Lança uma exceção se a requisição falhar.
  Future<void> removeTask(int taskId) async {
    final response = await http.delete(Uri.parse("$baseUrl/$taskId"));

    if (response.statusCode != 200) {
      throw Exception("Falha ao deletar tarefa");
    }
  }
}
