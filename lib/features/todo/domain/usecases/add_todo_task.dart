import 'package:dartz/dartz.dart';
import 'package:to_do/commons/errors/failures/failure.dart';
import 'package:to_do/features/todo/domain/entities/todo_task.dart';
import 'package:to_do/features/todo/domain/repositories/todo_repository.dart';

abstract class AddTodoTask {
  Future<Either<void, Failure>> call(TodoTask todoTask);
}

class AddTodoTaskImpl implements AddTodoTask {
  const AddTodoTaskImpl(this.repository);

  final TodoRepository repository;

  @override
  Future<Either<void, Failure>> call(TodoTask todoTask) async {
    return await repository.addTodoTask(todoTask);
  }
}
