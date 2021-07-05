import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:mobx/mobx.dart';
import 'package:to_do/features/todo/domain/entities/todo_task.dart';
import 'package:to_do/features/todo/presentation/stores/todo_store.dart';
import 'package:to_do/injection_container.dart';

class HomePageMobx extends StatefulWidget {
  HomePageMobx({Key? key}) : super(key: key);

  @override
  _HomePageMobxState createState() => _HomePageMobxState();
}

class _HomePageMobxState extends State<HomePageMobx> {
  final todoStore = serviceLocator<TodoStore>();

  late ReactionDisposer disposer;

  void _addTask() async {
    // final task = TodoTask(id: '2', completed: false, name: 'Name');
    // todoStore.addTodoTask(task);
    await Navigator.of(context).pushNamed('add_task_mobx');
  }

  @override
  void initState() {
    super.initState();
    todoStore.loadTodoTasks();
    print('list: ${todoStore.todoTasks}');

    disposer = reaction((_) => todoStore.todoState, (state) {
      if (state == TodoState.deleted) _showDeletedSnackBar(context);
    });
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
            return Center(child: Text('Initial State'));
          }
          if (state == TodoState.loading) {
            return Center(child: CircularProgressIndicator());
          }
          if (state == TodoState.loaded || state == TodoState.deleted) {
            return _buildloadedContainer(context);
          }
          if (state == TodoState.error) {
            return Center(child: Text('error State'));
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

  Widget _buildloadedContainer(BuildContext context) {
    final todoTaskList = todoStore.todoTasks;
    if (todoTaskList.isEmpty) {
      return Center(
          child: Container(
        child: Text('Sem tarefas'),
      ));
    }
    return ListView.builder(
      itemCount: todoTaskList.length,
      itemBuilder: (context, index) {
        final todoTask = todoTaskList[index];
        return ListTile(
          leading: Checkbox(
            value: todoTask.completed,
            onChanged: (value) {
              final task = todoTask.copyWith(completed: value);
              todoStore.updateTask(index, task);
            },
          ),
          title: Text(todoTask.name),
          onLongPress: () => _deleteItem(context, todoTask),
        );
      },
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
              todoStore.deleteTask(todoTask);
              Navigator.of(context).pop();
            },
            child: Text('Confirm'),
          )
        ],
      ),
    );
  }

  void _showDeletedSnackBar(BuildContext context) {
    final snackBar = SnackBar(
      content: Text('Task removed with success!'),
      action: SnackBarAction(
        label: 'OK',
        onPressed: () {
          // Código para desfazer a ação!
        },
      ),
    );
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  @override
  void dispose() {
    disposer.reaction.dispose();
    super.dispose();
  }
}
