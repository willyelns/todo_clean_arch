import 'package:equatable/equatable.dart';

class TodoTask extends Equatable {
  const TodoTask({
    required this.id,
    required this.completed,
    required this.name,
    this.description,
  });

  final String id;
  final bool completed;
  final String name;
  final String? description;

  TodoTask copyWith({
    String? id,
    bool? completed,
    String? name,
    String? description,
  }) {
    return TodoTask(
      id: id ?? this.id,
      completed: completed ?? this.completed,
      name: name ?? this.name,
      description: description ?? this.description,
    );
  }

  @override
  bool? get stringify => true;

  @override
  List<Object?> get props => [id, completed, name, description];
}
