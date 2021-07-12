import 'package:mobx/mobx.dart';

part 'add_todo_form_store.g.dart';

class AddTodoFormStore = _AddTodoFormStoreBase with _$AddTodoFormStore;

abstract class _AddTodoFormStoreBase with Store {
  // Observables
  @observable
  String name = '';

  @observable
  String? description;

  // Action methods
  @action
  void updateName(String value) {
    name = value;
  }

  @action
  void updateDescription(String value) {
    description = value;
  }
}
