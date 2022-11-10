import 'dart:math';

abstract class Utils {
  static Point<int> convert1DTo2D(int index, int length) {
    int x = (index % length);
    int y = (index ~/ length);

    return Point<int>(x, y);
  }

  static int convert2DTo1D(Point<int> p, int length) {
    return (p.y * length) + p.x;
  }
}
