import 'package:to_do/commons/mixins/decoder.dart';
import 'package:to_do/features/todo/domain/entities/todo_task.dart';

class TodoTaskModel extends TodoTask with Decoder {
  TodoTaskModel({
    required String id,
    required bool completed,
    required String name,
    String? description,
    String? icon,
  }) : super(
          id: id,
          completed: completed,
          name: name,
          description: description,
        );

  factory TodoTaskModel.fromJson(Json json) => TodoTaskModel(
        id: json['id'],
        completed: json['completed'],
        name: json['name'],
        description: json['description'],
      );

  factory TodoTaskModel.fromEntity(TodoTask todoTask) => TodoTaskModel(
        id: todoTask.id,
        completed: todoTask.completed,
        name: todoTask.name,
        description: todoTask.description,
      );

  @override
  Json toJson() {
    final Json response = {
      'id': id,
      'completed': completed,
      'name': name,
      'description': description,
    };
    return response;
  }
}
