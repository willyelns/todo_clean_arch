extension BoolExtension on bool {
  bool toggle() {
    // ignore: avoid_bool_literals_in_conditional_expressions
    return this ? false : true;
  }
}
