import '../../../../commons/types/use_case_response.dart';
import '../entities/todo_task.dart';
import '../repositories/todo_repository.dart';

abstract class DeleteTodoTask {
  UseCaseResponse<void> call(TodoTask todoTask);
}

class DeleteTodoTaskImpl implements DeleteTodoTask {
  const DeleteTodoTaskImpl(this.repository);

  final TodoRepository repository;

  @override
  UseCaseResponse<void> call(TodoTask todoTask) async {
    return repository.deleteTodoTask(todoTask);
  }
}
