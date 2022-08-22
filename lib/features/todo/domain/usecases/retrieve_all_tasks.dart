import '../../../../commons/types/use_case_response.dart';
import '../entities/todo_task.dart';
import '../repositories/todo_repository.dart';

abstract class RetrieveAllTasks {
  UseCaseResponse<List<TodoTask>> call();
}

class RetrieveAllTasksImpl implements RetrieveAllTasks {
  const RetrieveAllTasksImpl(this.repository);

  final TodoRepository repository;

  @override
  UseCaseResponse<List<TodoTask>> call() async {
    return repository.retrieveAllTasks();
  }
}
