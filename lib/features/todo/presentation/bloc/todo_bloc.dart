import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:to_do/features/todo/domain/entities/todo_task.dart';
import 'package:to_do/features/todo/domain/usecases/retrieve_all_tasks.dart';

part 'todo_event.dart';
part 'todo_state.dart';

class TodoBloc extends Bloc<TodoEvent, TodoState> {
  TodoBloc({required this.retrieveAllTasks}) : super(TodoLoadInProgress());

  final RetrieveAllTasks retrieveAllTasks;

  @override
  Stream<TodoState> mapEventToState(TodoEvent event) async* {
    if (event is TodoList) {
      yield* _mapTodoLoadedToState();
    } else if (event is TodoAdded) {
      yield* _mapTodoAddedToState(event);
    } else if (event is TodoUpdated) {
      yield* _mapTodoUpdatedToState(event);
    } else if (event is TodoDeleted) {
      yield* _mapTodoDeletedToState(event);
    } else if (event is ToggleAll) {
      yield* _mapToggleAllToState();
    } else if (event is ClearCompleted) {
      yield* _mapClearCompletedToState();
    }
  }

  Stream<TodoState> _mapTodoLoadedToState() async* {
    final either = await retrieveAllTasks();

    either.fold((list) async* {
      yield TodoLoadSuccess(list);
    }, (failure) async* {
      yield TodoLoadFailure();
    });
  }

  Stream<TodoState> _mapTodoAddedToState(TodoAdded event) async* {
    // if (state is TodosLoadSuccess) {
    //   final List<TodoTask> updatedTodos =
    //       List.from((state as TodosLoadSuccess).todos)..add(event.todo);
    //   yield TodoLoadSuccess(updatedTodos);
    //   _saveTodos(updatedTodos);
    // }
  }

  Stream<TodoState> _mapTodoUpdatedToState(TodoUpdated event) async* {
    // if (state is TodosLoadSuccess) {
    //   final List<Todo> updatedTodos =
    //       (state as TodosLoadSuccess).todos.map((todo) {
    //     return todo.id == event.updatedTodo.id ? event.updatedTodo : todo;
    //   }).toList();
    //   yield TodosLoadSuccess(updatedTodos);
    //   _saveTodos(updatedTodos);
    // }
  }

  Stream<TodoState> _mapTodoDeletedToState(TodoDeleted event) async* {
    // if (state is TodosLoadSuccess) {
    //   final updatedTodos = (state as TodosLoadSuccess)
    //       .todos
    //       .where((todo) => todo.id != event.todo.id)
    //       .toList();
    //   yield TodosLoadSuccess(updatedTodos);
    //   _saveTodos(updatedTodos);
    // }
  }

  Stream<TodoState> _mapToggleAllToState() async* {
    // if (state is TodoLoadSuccess) {
    //   final allComplete =
    //       (state as TodosLoadSuccess).todos.every((todo) => todo.complete);
    //   final List<Todo> updatedTodos = (state as TodosLoadSuccess)
    //       .todos
    //       .map((todo) => todo.copyWith(complete: !allComplete))
    //       .toList();
    //   yield TodosLoadSuccess(updatedTodos);
    //   _saveTodos(updatedTodos);
    // }
  }

  Stream<TodoState> _mapClearCompletedToState() async* {
    // if (state is TodosLoadSuccess) {
    //   final List<Todo> updatedTodos = (state as TodosLoadSuccess)
    //       .todos
    //       .where((todo) => !todo.complete)
    //       .toList();
    //   yield TodosLoadSuccess(updatedTodos);
    //   _saveTodos(updatedTodos);
    // }
  }

  // Future _saveTodoList(List<TodoTask> todos) {
  //   return todosRepository.saveTodos(
  //     todos.map((todo) => todo.toEntity()).toList(),
  //   );
  // }
}
