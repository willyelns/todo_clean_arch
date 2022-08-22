import '../../../../commons/types/use_case_response.dart';
import '../entities/todo_task.dart';
import '../repositories/todo_repository.dart';

abstract class UpdateTodoTask {
  UseCaseResponse<void> call(TodoTask todoTask);
}

class UpdateTodoTaskImpl implements UpdateTodoTask {
  const UpdateTodoTaskImpl(this.repository);

  final TodoRepository repository;

  @override
  UseCaseResponse<void> call(TodoTask todoTask) async {
    return repository.updateTodoTask(todoTask);
  }
}
