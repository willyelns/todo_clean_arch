import 'package:equatable/equatable.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:to_do/features/todo/domain/entities/todo_task.dart';

void main() {
  final tId = 'id';
  final tCompleted = false;
  final tName = 'name';
  TodoTask sut;

  setUp(() {
    sut = TodoTask(id: tId, completed: tCompleted, name: tName);
  });

  test('should the sut extends the Equatable', () {
    // verify(sut is Equatable);
  });
}
