part of 'todo_bloc.dart';

abstract class TodoEvent extends Equatable {
  const TodoEvent();

  @override
  List<Object> get props => [];
}

class TodoList extends TodoEvent {}

class TodoAdded extends TodoEvent {
  final TodoTask todo;

  const TodoAdded(this.todo);

  @override
  List<Object> get props => [todo];

  @override
  String toString() => 'TodoTask Added { todo: $todo }';
}

class TodoUpdated extends TodoEvent {
  final TodoTask todo;

  const TodoUpdated(this.todo);

  @override
  List<Object> get props => [todo];

  @override
  String toString() => 'TodoTask Updated { todo: $todo }';
}

class TodoDeleted extends TodoEvent {
  final TodoTask todo;

  const TodoDeleted(this.todo);

  @override
  List<Object> get props => [todo];

  @override
  String toString() => 'TodoTask Deleted { todo: $todo }';
}

class ClearCompleted extends TodoEvent {}

class ToggleAll extends TodoEvent {}
