import 'package:dartz/dartz.dart';
import '../../../../commons/errors/failures/failure.dart';
import '../entities/todo_task.dart';
import '../repositories/todo_repository.dart';

abstract class AddTodoTask {
  Future<Either<void, Failure>> call(TodoTask todoTask);
}

class AddTodoTaskImpl implements AddTodoTask {
  const AddTodoTaskImpl(this.repository);

  final TodoRepository repository;

  @override
  Future<Either<void, Failure>> call(TodoTask todoTask) async {
    return repository.addTodoTask(todoTask);
  }
}
