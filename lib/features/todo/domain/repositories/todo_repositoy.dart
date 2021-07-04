import 'package:dartz/dartz.dart';
import 'package:to_do/commons/errors/failures/failure.dart';
import 'package:to_do/features/todo/domain/entities/todo_task.dart';

abstract class TodoRepository {
  Future<Either<List<TodoTask>, Failure>> retrieveAllTasks();
}
