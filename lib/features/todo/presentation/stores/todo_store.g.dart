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

  final _$loadTodoTasksAsyncAction =
      AsyncAction('_TodoStoreBase.loadTodoTasks');

  @override
  Future<void> loadTodoTasks() {
    return _$loadTodoTasksAsyncAction.run(() => super.loadTodoTasks());
  }

  final _$addTodoTaskAsyncAction = AsyncAction('_TodoStoreBase.addTodoTask');

  @override
  Future<void> addTodoTask(TodoTask task) {
    return _$addTodoTaskAsyncAction.run(() => super.addTodoTask(task));
  }

  final _$updateTaskAsyncAction = AsyncAction('_TodoStoreBase.updateTask');

  @override
  Future<void> updateTask(int index, TodoTask task) {
    return _$updateTaskAsyncAction.run(() => super.updateTask(index, task));
  }

  final _$deleteTaskAsyncAction = AsyncAction('_TodoStoreBase.deleteTask');

  @override
  Future<void> deleteTask(TodoTask task) {
    return _$deleteTaskAsyncAction.run(() => super.deleteTask(task));
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
