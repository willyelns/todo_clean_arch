import '../../../../commons/types/use_case_response.dart';
import '../entities/todo_task.dart';
import '../repositories/todo_repository.dart';

abstract class AddTodoTask {
  UseCaseResponse<void> call(TodoTask todoTask);
}

class AddTodoTaskImpl implements AddTodoTask {
  const AddTodoTaskImpl(this.repository);

  final TodoRepository repository;

  @override
  UseCaseResponse<void> call(TodoTask todoTask) async {
    return repository.addTodoTask(todoTask);
  }
}
