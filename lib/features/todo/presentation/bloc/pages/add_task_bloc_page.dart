import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../injection_container.dart';
import '../../../../../routes/app_pages.dart';
import '../todo_bloc.dart';

class AddTaskBlocPage extends StatefulWidget {
  const AddTaskBlocPage({Key? key}) : super(key: key);

  @override
  _AddTaskBlocPageState createState() => _AddTaskBlocPageState();
}

class _AddTaskBlocPageState extends State<AddTaskBlocPage> {
  TodoBloc get _todoBloc => serviceLocator<TodoBloc>();
  TextEditingController get _nameFieldController => TextEditingController();
  TextEditingController get _descriptionFieldController =>
      TextEditingController();

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    _nameFieldController.dispose();
    _descriptionFieldController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider<TodoBloc>(
      create: (context) => _todoBloc,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Add task - BLoC'),
        ),
        body: GestureDetector(
          onTap: FocusScope.of(context).unfocus,
          child: Container(
            padding: const EdgeInsets.all(16),
            child:
                BlocConsumer<TodoBloc, TodoState>(listener: (context, state) {
              if (state is TodoAddedState) {
                _returnFromAddPage(context);
              }
            }, builder: (context, state) {
              return Column(
                children: [
                  TextField(
                    decoration: const InputDecoration(labelText: 'Name'),
                    controller: _nameFieldController,
                    onChanged: (value) => _nameFieldController.text = value,
                  ),
                  TextField(
                    decoration: const InputDecoration(labelText: 'Description'),
                    controller: _descriptionFieldController,
                  ),
                  Container(
                    margin: const EdgeInsets.only(top: 16),
                    child: ElevatedButton(
                      onPressed: _onSave,
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 16, vertical: 8),
                        child: state is! TodoLoadingState
                            ? Text(
                                'Add task'.toUpperCase(),
                              )
                            : const SizedBox(
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
      ),
    );
  }

  void _returnFromAddPage(BuildContext context) {
    context.pop();
  }

  void _onSave() {
    final nameValue = _nameFieldController.value;
    final name = nameValue.text;
    final descriptionValue = _descriptionFieldController.value;
    final description = descriptionValue.text;
    _todoBloc.add(TodoAdd(
      name: name,
      description: description,
    ));
  }
}
