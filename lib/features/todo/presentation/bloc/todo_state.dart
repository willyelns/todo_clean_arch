part of 'todo_bloc.dart';

abstract class TodoState extends Equatable {
  const TodoState();

  @override
  List<Object> get props => [];
}

class TodoInitialState extends TodoState {}

class TodoLoadingState extends TodoState {}

class TodoDeletedState extends TodoState {}

class TodoLoadedState extends TodoState {
  final List<TodoTask> todoTasks;

  const TodoLoadedState([this.todoTasks = const []]);

  @override
  List<Object> get props => [todoTasks];

  @override
  String toString() => 'TodoLoadedState { todos: $todoTasks }';
}

class TodoFailureState extends TodoState {}
