// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:math';

import 'package:awesome_board_v2/utils/utils.dart';
import 'package:equatable/equatable.dart';

enum HoldType { start, finish, normal, foot, unknown }

extension PointXInt on Point<int> {
  Map<String, int> toMap() {
    return {"x": x, "y": y};
  }

  static Point<int> fromMap(Map<String, dynamic> map) {
    return Point<int>(map["x"], map["y"]);
  }

  Point<int> get abovePoint => Point<int>(x, y - 1);
  Point<int> get leftPoint => Point<int>(x - 1, y);
  Point<int> get rightPoint => Point<int>(x + 1, y);
  Point<int> get belowPoint => Point<int>(x, y + 1);
}

extension HoldListX on List<Hold> {
  List<Hold> mirrorHolds() => this;
}

class Hold extends Equatable {
  final Point<int> location;
  final HoldType holdType;
  const Hold({
    required this.location,
    required this.holdType,
  });

  int as1DPoint(int width) {
    return Utils.convert2DTo1D(location, width);
  }

  Hold copyWith({
    Point<int>? location,
    HoldType? holdType,
  }) {
    return Hold(
      location: location ?? this.location,
      holdType: holdType ?? this.holdType,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'location': location.toMap(),
      'holdType': holdType.index,
    };
  }

  factory Hold.fromMap(Map<String, dynamic> map) {
    final holdt = int.tryParse(map['holdType']);
    return Hold(
      location: PointXInt.fromMap(map['location'] as Map<String, dynamic>),
      holdType: holdt == null
          ? HoldType.unknown
          : holdt < HoldType.values.length
              ? HoldType.values[holdt]
              : HoldType.unknown,
    );
  }

  @override
  bool get stringify => true;

  @override
  List<Object> get props => [location, holdType];
}
