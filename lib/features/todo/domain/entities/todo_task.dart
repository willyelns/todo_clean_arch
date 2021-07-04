import 'package:equatable/equatable.dart';

class TodoTask extends Equatable {
  const TodoTask({
    required this.id,
    required this.completed,
    required this.name,
    this.description,
    this.icon,
  });

  final String id;
  final bool completed;
  final String name;
  final String? description;
  final String? icon;

  @override
  bool? get stringify => true;

  @override
  List<Object?> get props => [id, completed, name, description, icon];
}
