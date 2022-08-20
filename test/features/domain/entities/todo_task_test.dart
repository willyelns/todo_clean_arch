import 'package:equatable/equatable.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:to_do/commons/mixins/copyable.dart';
import 'package:to_do/features/todo/domain/entities/todo_task.dart';

void main() {
  const tId = 'id';
  const tCompleted = false;
  const tName = 'name';
  late TodoTask sut;

  setUp(() {
    sut = const TodoTask(id: tId, completed: tCompleted, name: tName);
  });

  test('should the sut extends the Equatable', () {
    expect(sut, isA<Equatable>());
  });

  test('should the sut implements the Copyable', () {
    expect(sut, isA<Copyable>());
  });
}
