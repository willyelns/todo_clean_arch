// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'add_todo_form_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$AddTodoFormStore on _AddTodoFormStoreBase, Store {
  final _$nameAtom = Atom(name: '_AddTodoFormStoreBase.name');

  @override
  String get name {
    _$nameAtom.reportRead();
    return super.name;
  }

  @override
  set name(String value) {
    _$nameAtom.reportWrite(value, super.name, () {
      super.name = value;
    });
  }

  final _$descriptionAtom = Atom(name: '_AddTodoFormStoreBase.description');

  @override
  String? get description {
    _$descriptionAtom.reportRead();
    return super.description;
  }

  @override
  set description(String? value) {
    _$descriptionAtom.reportWrite(value, super.description, () {
      super.description = value;
    });
  }

  final _$_AddTodoFormStoreBaseActionController =
      ActionController(name: '_AddTodoFormStoreBase');

  @override
  void updateName(String value) {
    final _$actionInfo = _$_AddTodoFormStoreBaseActionController.startAction(
        name: '_AddTodoFormStoreBase.updateName');
    try {
      return super.updateName(value);
    } finally {
      _$_AddTodoFormStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void updateDescription(String value) {
    final _$actionInfo = _$_AddTodoFormStoreBaseActionController.startAction(
        name: '_AddTodoFormStoreBase.updateDescription');
    try {
      return super.updateDescription(value);
    } finally {
      _$_AddTodoFormStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
name: ${name},
description: ${description}
    ''';
  }
}
