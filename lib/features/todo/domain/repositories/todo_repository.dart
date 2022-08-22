import '../../../../commons/types/use_case_response.dart';
import '../entities/todo_task.dart';

abstract class TodoRepository {
  UseCaseResponse<List<TodoTask>> retrieveAllTasks();
  UseCaseResponse<void> updateTodoTask(TodoTask todoTask);
  UseCaseResponse<void> deleteTodoTask(TodoTask todoTask);
  UseCaseResponse<void> addTodoTask(TodoTask todoTask);
}
