

Map groupByFields<T>(
    List<T> items,
    List<dynamic Function(T)> extractors,
    ) {
  final result = <dynamic, dynamic>{};
  for (var item in items) {
    var level = result;
    for (var i = 0; i < extractors.length; i++) {
      final key = extractors[i](item);
      if (i == extractors.length - 1) {
        (level.putIfAbsent(key, () => <T>[]) as List<T>).add(item);
      } else {
        level = level.putIfAbsent(key, () => <dynamic, dynamic>{}) as Map;
      }
    }
  }
  return result;
}