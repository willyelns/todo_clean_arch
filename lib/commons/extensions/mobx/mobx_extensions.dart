import 'package:mobx/mobx.dart';

extension MobxObjectExtension<T> on T {
  // e.g : instead of using var element = Observable(0); | var element = 0.obs;
  Observable get obs => Observable<T>(this);

  // e.g : instead of using var element = ObservableFuture.value(0) | var element = 0.fObsValue;
  ObservableFuture get fObsValue => ObservableFuture<T>.value(this);
}

extension MobxFutureExtension<T> on Future<T> {
  // e.g : instead of using var element = ObservableFuture(future) | var element = future.fObs
  ObservableFuture<T> get fObs => ObservableFuture(this);
}

extension MobxListExtension<T> on List<T> {
  // e.g : instead of using var element = ObservableFuture(list) | var element = list.obsList
  ObservableList<T> get obsList => ObservableList<T>.of(this);
}

extension MobxSetExtension<T> on Set<T> {
  // e.g : instead of using var element = ObservableFuture(set) | var element = set.obsSet
  ObservableSet<T> get obsSet => ObservableSet<T>.of(this);
}

extension MobxStreamExtension<T> on Stream<T> {
  // e.g : instead of using var element = ObservableFuture(stream) | var element = stream.obsStream
  ObservableStream<T> get obsStream => ObservableStream<T>(this);
}

extension MobxMapExtension<K, V> on Map<K, V> {
  // e.g : instead of using var element = ObservableMap(map) | var element = map.fObs
  ObservableMap<K, V> get obsMap => ObservableMap<K, V>.of(this);
}

extension MobxFunctionExtension on Function {
  // e.g : instead of using var actionName = Action(function) | var actionName = function.action
  Action get action => Action(this);

  // e.g : instead of using var computedName = Computed(function) | var computedName = function.computed
  Computed get computed => Computed(this as dynamic Function());
}

extension MobxListReactionExtension on List<ReactionDisposer> {
  void disposeAll() {
    for (final disposer in this) {
      disposer();
    }
  }
}

extension MobxReactionDisposerExtension on ReactionDisposer {
  void dispose() {
    final reactionDisposer = this;

    final reaction = reactionDisposer.reaction;

    reaction.dispose();
  }
}
