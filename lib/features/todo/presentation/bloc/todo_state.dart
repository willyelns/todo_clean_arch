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
  const TodoLoadedState([this.todoTasks = const []]);

  final List<TodoTask> todoTasks;

  @override
  List<Object> get props => [todoTasks];

  @override
  String toString() => 'TodoLoadedState { todos: $todoTasks }';
}

class TodoFailureState extends TodoState {}
