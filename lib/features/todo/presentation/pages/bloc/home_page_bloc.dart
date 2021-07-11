import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:to_do/features/todo/domain/entities/todo_task.dart';
import 'package:to_do/features/todo/presentation/bloc/todo_bloc.dart';
import 'package:to_do/injection_container.dart';

class HomePageBloc extends StatefulWidget {
  HomePageBloc({Key? key}) : super(key: key);

  @override
  _HomePageBlocState createState() => _HomePageBlocState();
}

class _HomePageBlocState extends State<HomePageBloc> {
  final todoBloc = serviceLocator<TodoBloc>();

  void _addTask() async {}

  @override
  void initState() {
    super.initState();
    todoBloc.add(TodoList());
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => todoBloc,
      child: BlocBuilder<TodoBloc, TodoState>(
        builder: (context, state) {
          return Scaffold(
            appBar: AppBar(
              title: Text('To do list - Bloc'),
            ),
            body: LayoutBuilder(
              builder: (BuildContext context, BoxConstraints constraints) {
                if (state is TodoDeletedState) {
                  _showDeletedSnackBar(context);
                }

                if (state is TodoLoadingState)
                  return Center(child: CircularProgressIndicator());
                else if (state is TodoInitialState)
                  return Center(child: Text('Initial value'));
                else if (state is TodoLoadedState)
                  return _LoadedStateWidget(
                    todoTasks: state.todoTasks,
                  );
                else
                  return Text('Error to handle');
              },
            ),
            floatingActionButton: FloatingActionButton(
              onPressed: _addTask,
              tooltip: 'Add Todo task',
              child: Icon(Icons.add),
            ),
          );
        },
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
}

class _LoadedStateWidget extends StatelessWidget {
  final todoBloc = serviceLocator<TodoBloc>();
  final List<TodoTask> todoTasks;

  _LoadedStateWidget({Key? key, required this.todoTasks}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (todoTasks.isEmpty) {
      return Center(
          child: Container(
        child: Text('No tasks'),
      ));
    }
    return RefreshIndicator(
      onRefresh: () async => todoBloc.add(TodoList()),
      child: ListView.builder(
        itemCount: todoTasks.length,
        itemBuilder: (context, index) {
          final todoTask = todoTasks[index];
          return ListTile(
            leading: Checkbox(
              value: todoTask.completed,
              onChanged: (value) {
                final task = todoTask.copyWith(completed: value);
                todoBloc.add(TodoUpdated(task));
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
              // todoStore.deleteTask(todoTask);
              todoBloc.add(TodoDeleted(todoTask));
              Navigator.of(context).pop();
            },
            child: Text('Confirm'),
          )
        ],
      ),
    );
  }
}
