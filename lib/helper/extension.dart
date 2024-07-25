extension ListExtension<T> on List<T> {
  T? lastWhereOrNull(bool Function(T) test) {
    final List<T> matches = where(test).toList();
    return matches.isEmpty ? null : matches.last;
  }
}