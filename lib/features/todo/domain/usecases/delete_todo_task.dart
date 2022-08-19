import 'package:dartz/dartz.dart';
import 'package:to_do/commons/errors/failures/failure.dart';
import 'package:to_do/features/todo/domain/entities/todo_task.dart';
import 'package:to_do/features/todo/domain/repositories/todo_repository.dart';

abstract class DeleteTodoTask {
  Future<Either<void, Failure>> call(TodoTask todoTask);
}

class DeleteTodoTaskImpl implements DeleteTodoTask {
  const DeleteTodoTaskImpl(this.repository);

  final TodoRepository repository;

  @override
  Future<Either<void, Failure>> call(TodoTask todoTask) async {
    return await repository.deleteTodoTask(todoTask);
  }
}
