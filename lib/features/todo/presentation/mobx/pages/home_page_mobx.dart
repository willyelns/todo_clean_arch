import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:mobx/mobx.dart';
import 'package:to_do/features/todo/domain/entities/todo_task.dart';
import 'package:to_do/features/todo/presentation/page_states/todo_state.dart';
import 'package:to_do/features/todo/presentation/mobx/stores/todo_store.dart';
import 'package:to_do/injection_container.dart';

class HomePageMobx extends StatefulWidget {
  HomePageMobx({Key? key}) : super(key: key);

  @override
  _HomePageMobxState createState() => _HomePageMobxState();
}

class _HomePageMobxState extends State<HomePageMobx> {
  final todoStore = serviceLocator<TodoStore>();

  List<ReactionDisposer> disposers = [];

  void _addTask() async {
    await Navigator.of(context).pushNamed('add_task_mobx');
  }

  @override
  void initState() {
    super.initState();
    todoStore.retrieveAllTasks();
    print('list: ${todoStore.todoTasks}');

    disposers.add(reaction((_) => todoStore.todoState, (state) {
      if (state == TodoState.deleted) _showDeletedSnackBar(context);
    }));

    disposers.add(reaction((_) => todoStore.todoState, (state) {
      if (state == TodoState.added) todoStore.todoState = TodoState.loaded;
    }, delay: 500));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("To do list with - MobX"),
      ),
      body: Observer(
        builder: (context) {
          final state = todoStore.currentState;
          if (state == TodoState.initial) {
            return _InitialStateWidget();
          }
          if (state == TodoState.loading) {
            return _LoadingStateWidget();
          }
          if (state == TodoState.loaded || state == TodoState.deleted) {
            return _LoadedStateWidget();
          }
          if (state == TodoState.error) {
            return _ErrorStateWidget(
              errorMessage: todoStore.errorMessage,
            );
          }
          return Text('Not Recognized');
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _addTask,
        tooltip: 'Add new Task',
        child: Icon(Icons.add),
      ),
    );
  }

  void _showDeletedSnackBar(BuildContext context) {
    final snackBar = SnackBar(
      content: Text('Task removed with success!'),
      action: SnackBarAction(
        label: 'OK',
        onPressed: () {
          // do something
        },
      ),
    );
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  @override
  void dispose() {
    disposers.forEach((element) {
      element.reaction.dispose();
    });
    super.dispose();
  }
}

class _LoadedStateWidget extends StatelessWidget {
  final todoStore = serviceLocator<TodoStore>();

  _LoadedStateWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final List<TodoTask> todoTasks = todoStore.todoTasks;

    if (todoTasks.isEmpty) {
      return Center(
          child: Container(
        child: Text('No tasks'),
      ));
    }
    return RefreshIndicator(
      onRefresh: todoStore.retrieveAllTasks,
      child: ListView.builder(
        itemCount: todoTasks.length,
        itemBuilder: (context, index) {
          final todoTask = todoTasks[index];
          return ListTile(
            leading: Checkbox(
              value: todoTask.completed,
              onChanged: (value) {
                final task = todoTask.copyWith(completed: value);
                todoStore.updateTodoTask(task);
              },
            ),
            title: Text(todoTask.name),
            onLongPress: () => _deleteItem(context, todoTask),
          );
        },
      ),
    );
  }

  void _deleteItem(BuildContext context, TodoTask todoTask) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text("Delete"),
        content: Text("Delete this task: ${todoTask.name}"),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () {
              todoStore.deleteTodoTask(todoTask);
              Navigator.of(context).pop();
            },
            child: Text('Confirm'),
          )
        ],
      ),
    );
  }
}

class _ErrorStateWidget extends StatelessWidget {
  final String errorMessage;

  const _ErrorStateWidget({
    required this.errorMessage,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(errorMessage),
    );
  }
}

class _LoadingStateWidget extends StatelessWidget {
  const _LoadingStateWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(child: CircularProgressIndicator());
  }
}

class _InitialStateWidget extends StatelessWidget {
  const _InitialStateWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(child: Text('Initial State'));
  }
}
