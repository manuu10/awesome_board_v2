import 'dart:math';

extension AllComparerExtensions on List<dynamic> {
  bool containsAll(List<dynamic> values) {
    for (final x in values) {
      if (!contains(x)) return false;
    }
    return true;
  }

  bool containsAny(List<dynamic> values) {
    for (final x in values) {
      if (contains(x)) return true;
    }
    return false;
  }
}

extension PointIntExtMisc on Point<int> {
  Point<int> add(Point<int> other) {
    return Point(x + other.x, y + other.y);
  }
}
