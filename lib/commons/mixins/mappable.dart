mixin Mappable {
  Map<String, dynamic> toMap();

  @override
  String toString() {
    return '''
    $runtimeType(
      ${toMap()}
    )''';
  }
}
