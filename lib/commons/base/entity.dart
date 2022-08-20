import 'package:equatable/equatable.dart';

import '../mixins/copyable.dart';

abstract class Entity<T> extends Equatable implements Copyable<T> {}
