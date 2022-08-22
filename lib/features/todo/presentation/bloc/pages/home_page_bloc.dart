import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../injection_container.dart';
import '../../../../../routes/app_pages.dart';
import '../../../domain/entities/todo_task.dart';
import '../todo_bloc.dart';

class HomePageBloc extends StatefulWidget {
  const HomePageBloc({Key? key}) : super(key: key);

  @override
  _HomePageBlocState createState() => _HomePageBlocState();
}

class _HomePageBlocState extends State<HomePageBloc> {
  final todoBloc = serviceLocator<TodoBloc>();

  Future<void> _addTask() async {}

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
              title: const Text('To do list - Bloc'),
            ),
            body: LayoutBuilder(
              builder: (context, constraints) {
                debugPrint('STATE: $state');
                if (state is TodoDeletedState) {
                  _showDeletedSnackBar(context);
                }
                if (state is TodoLoadingState) {
                  return const Center(child: CircularProgressIndicator());
                }
                if (state is TodoInitialState) {
                  return const Center(child: Text('Initial value'));
                }
                if (state is TodoLoadedState) {
                  return _LoadedStateWidget(
                    todoTasks: state.todoTasks,
                  );
                }
                return const Text('Error to handle');
              },
            ),
            floatingActionButton: FloatingActionButton(
              onPressed: _addTask,
              tooltip: 'Add Todo task',
              child: const Icon(Icons.add),
            ),
          );
        },
      ),
    );
  }

  void _showDeletedSnackBar(BuildContext context) {
    final snackBar = SnackBar(
      content: const Text('Task removed with success!'),
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
  _LoadedStateWidget({
    required this.todoTasks,
    Key? key,
  }) : super(key: key);

  final todoBloc = serviceLocator<TodoBloc>();
  final List<TodoTask> todoTasks;

  @override
  Widget build(BuildContext context) {
    if (todoTasks.isEmpty) {
      return const Center(child: Text('No tasks'));
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
        title: const Text('Delete'),
        content: Text('Delete this task: ${todoTask.name}'),
        actions: [
          TextButton(
            onPressed: () {
              context.pop();
            },
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () {
              // todoStore.deleteTask(todoTask);
              todoBloc.add(TodoDeleted(todoTask));
              context.pop();
            },
            child: const Text('Confirm'),
          )
        ],
      ),
    );
  }
}
