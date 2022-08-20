import 'package:dartz/dartz.dart';
import '../../../../commons/errors/failures/failure.dart';
import '../entities/todo_task.dart';
import '../repositories/todo_repository.dart';

abstract class DeleteTodoTask {
  Future<Either<void, Failure>> call(TodoTask todoTask);
}

class DeleteTodoTaskImpl implements DeleteTodoTask {
  const DeleteTodoTaskImpl(this.repository);

  final TodoRepository repository;

  @override
  Future<Either<void, Failure>> call(TodoTask todoTask) async {
    return repository.deleteTodoTask(todoTask);
  }
}
