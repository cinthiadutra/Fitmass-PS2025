import 'dart:math';

/// Uma classe que representa uma tarefa com um ID, nome e status de conclusão.
class Task {
  /// O identificador único da tarefa.
  final int id;

  /// O nome ou título da tarefa.
  final String name;

  /// Cria uma nova instância de [Task].
  ///
  /// Se [id] não for fornecido, um ID aleatório maior que 10 será gerado.
  ///
  /// [name] é obrigatório e representa o nome da tarefa.
  /// [completed] indica se a tarefa está concluída ou não.
  Task({
    int? id,
    required this.name,
  }) : id = id ?? _generateRandomId();

  /// Gera um ID aleatório maior que 10.
  ///
  /// O ID gerado estará entre 11 e 1010.
  static int _generateRandomId() {
    return Random().nextInt(1000) + 11;
  }

  /// Cria uma nova instância de [Task] a partir de um objeto JSON.
  ///
  /// O objeto JSON deve conter as seguintes chaves:
  /// - 'id': O identificador único da tarefa.
  /// - 'title': O nome da tarefa.
  /// - 'completed': O status de conclusão da tarefa (opcional).
  ///
  /// Retorna uma instância de [Task].
  factory Task.fromJson(Map<String, dynamic> json) {
    return Task(
      id: json['id'],
      name: json['title'],
    );
  }

  /// Converte a instância de [Task] para um objeto JSON.
  ///
  /// O objeto JSON resultante conterá as seguintes chaves:
  /// - 'id': O identificador único da tarefa.
  /// - 'title': O nome da tarefa.
  /// - 'completed': O status de conclusão da tarefa.
  ///
  /// Retorna uma representação JSON da instância de [Task].
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': name,
    };
  }
}
