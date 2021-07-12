import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:mobx/mobx.dart';
import 'package:to_do/features/todo/presentation/mobx/stores/todo_store.dart';
import 'package:to_do/features/todo/presentation/page_states/todo_state.dart';

import '../../../../../injection_container.dart';

class AddTaskPageMobx extends StatefulWidget {
  AddTaskPageMobx({Key? key}) : super(key: key);

  @override
  _AddTaskPageMobxState createState() => _AddTaskPageMobxState();
}

class _AddTaskPageMobxState extends State<AddTaskPageMobx> {
  final todoStore = serviceLocator<TodoStore>();

  late ReactionDisposer disposer;

  @override
  void initState() {
    super.initState();
    disposer = reaction((_) => todoStore.currentState, (state) {
      if (state == TodoState.added) _returnFromAddPage(context);
    });
  }

  void _returnFromAddPage(BuildContext context) {
    Navigator.of(context).pop();
  }

  @override
  void dispose() {
    disposer.reaction.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add task - MobX'),
      ),
      body: GestureDetector(
        onTap: () => FocusScope.of(context).unfocus(),
        child: Container(
          padding: const EdgeInsets.all(16),
          child: Observer(builder: (context) {
            return Column(
              children: [
                TextField(
                  decoration: InputDecoration(labelText: 'Name'),
                  onChanged: todoStore.addTodoFormStore.updateName,
                ),
                TextField(
                  decoration: InputDecoration(labelText: 'Description'),
                  onChanged: todoStore.addTodoFormStore.updateDescription,
                ),
                Container(
                  margin: const EdgeInsets.only(top: 16),
                  child: ElevatedButton(
                    onPressed: todoStore.addTodoTask,
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 16, vertical: 8),
                      child: todoStore.todoState != TodoState.loading
                          ? Text(
                              'Add task'.toUpperCase(),
                            )
                          : SizedBox(
                              width: 16,
                              height: 16,
                              child: CircularProgressIndicator(
                                color: Colors.white,
                                strokeWidth: 2,
                              ),
                            ),
                    ),
                  ),
                )
              ],
            );
          }),
        ),
      ),
    );
  }
}
