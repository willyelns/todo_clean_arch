// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'todo_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$TodoStore on _TodoStoreBase, Store {
  Computed<TodoState>? _$currentStateComputed;

  @override
  TodoState get currentState =>
      (_$currentStateComputed ??= Computed<TodoState>(() => super.currentState,
              name: '_TodoStoreBase.currentState'))
          .value;
  Computed<String>? _$errorMessageComputed;

  @override
  String get errorMessage =>
      (_$errorMessageComputed ??= Computed<String>(() => super.errorMessage,
              name: '_TodoStoreBase.errorMessage'))
          .value;

  final _$todoTasksAtom = Atom(name: '_TodoStoreBase.todoTasks');

  @override
  List<TodoTask> get todoTasks {
    _$todoTasksAtom.reportRead();
    return super.todoTasks;
  }

  @override
  set todoTasks(List<TodoTask> value) {
    _$todoTasksAtom.reportWrite(value, super.todoTasks, () {
      super.todoTasks = value;
    });
  }

  final _$todoStateAtom = Atom(name: '_TodoStoreBase.todoState');

  @override
  TodoState get todoState {
    _$todoStateAtom.reportRead();
    return super.todoState;
  }

  @override
  set todoState(TodoState value) {
    _$todoStateAtom.reportWrite(value, super.todoState, () {
      super.todoState = value;
    });
  }

  final _$retrieveAllTasksAsyncAction =
      AsyncAction('_TodoStoreBase.retrieveAllTasks');

  @override
  Future<void> retrieveAllTasks() {
    return _$retrieveAllTasksAsyncAction.run(() => super.retrieveAllTasks());
  }

  final _$addTodoTaskAsyncAction = AsyncAction('_TodoStoreBase.addTodoTask');

  @override
  Future<void> addTodoTask() {
    return _$addTodoTaskAsyncAction.run(() => super.addTodoTask());
  }

  final _$updateTodoTaskAsyncAction =
      AsyncAction('_TodoStoreBase.updateTodoTask');

  @override
  Future<void> updateTodoTask(TodoTask task) {
    return _$updateTodoTaskAsyncAction.run(() => super.updateTodoTask(task));
  }

  final _$deleteTodoTaskAsyncAction =
      AsyncAction('_TodoStoreBase.deleteTodoTask');

  @override
  Future<void> deleteTodoTask(TodoTask task) {
    return _$deleteTodoTaskAsyncAction.run(() => super.deleteTodoTask(task));
  }

  @override
  String toString() {
    return '''
todoTasks: ${todoTasks},
todoState: ${todoState},
currentState: ${currentState},
errorMessage: ${errorMessage}
    ''';
  }
}
