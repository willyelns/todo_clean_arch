part of 'todo_bloc.dart';

abstract class TodoEvent extends Equatable {
  const TodoEvent();

  @override
  List<Object> get props => [];
}

class TodoList extends TodoEvent {}

class TodoAdded extends TodoEvent {
  const TodoAdded(this.todo);

  final TodoTask todo;

  @override
  List<Object> get props => [todo];

  @override
  String toString() => 'TodoTask Added { todo: $todo }';
}

class TodoUpdated extends TodoEvent {
  const TodoUpdated(this.todo);

  final TodoTask todo;

  @override
  List<Object> get props => [todo];

  @override
  String toString() => 'TodoTask Updated { todo: $todo }';
}

class TodoDeleted extends TodoEvent {
  const TodoDeleted(this.todo);

  final TodoTask todo;

  @override
  List<Object> get props => [todo];

  @override
  String toString() => 'TodoTask Deleted { todo: $todo }';
}
