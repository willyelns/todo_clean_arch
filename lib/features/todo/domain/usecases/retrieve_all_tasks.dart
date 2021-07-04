import 'package:dartz/dartz.dart';
import 'package:to_do/commons/errors/failures/failure.dart';
import 'package:to_do/features/todo/domain/entities/todo_task.dart';
import 'package:to_do/features/todo/domain/repositories/todo_repositoy.dart';

abstract class RetrieveAllTasks {
  Future<Either<List<TodoTask>, Failure>> call();
}

class RetrieveAllTasksImpl implements RetrieveAllTasks {
  const RetrieveAllTasksImpl(this.repository);

  final TodoRepository repository;

  @override
  Future<Either<List<TodoTask>, Failure>> call() async {
    return await repository.retrieveAllTasks();
  }
}
