import 'package:dartz/dartz.dart';
import '../../../../commons/errors/failures/failure.dart';
import '../entities/todo_task.dart';
import '../repositories/todo_repository.dart';

abstract class RetrieveAllTasks {
  Future<Either<List<TodoTask>, Failure>> call();
}

class RetrieveAllTasksImpl implements RetrieveAllTasks {
  const RetrieveAllTasksImpl(this.repository);

  final TodoRepository repository;

  @override
  Future<Either<List<TodoTask>, Failure>> call() async {
    return repository.retrieveAllTasks();
  }
}
