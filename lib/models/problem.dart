// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:awesome_board_v2/models/hold.dart';
import 'package:equatable/equatable.dart';

enum ProblemType {
  none,
  feetFollowHands,
  feetFollowHandsScrewOn,
  footlessKickboard,
  screwOnsOnly,
}

class Problem extends Equatable {
  final String id;
  final String title;
  final String author;
  final int grade;
  final List<Hold> holds;
  final ProblemType type;
  const Problem({
    required this.id,
    required this.title,
    required this.author,
    required this.grade,
    required this.holds,
    required this.type,
  });

  Problem copyWith({
    String? id,
    String? title,
    String? author,
    int? grade,
    List<Hold>? holds,
    ProblemType? type,
  }) {
    return Problem(
      id: id ?? this.id,
      title: title ?? this.title,
      author: author ?? this.author,
      grade: grade ?? this.grade,
      holds: holds ?? this.holds,
      type: type ?? this.type,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'title': title,
      'author': author,
      'grade': grade,
      'holds': holds.map((x) => x.toMap()).toList(),
      'type': type.index,
    };
  }

  factory Problem.fromMap(Map<String, dynamic> map) {
    final type = int.tryParse(map['type']);
    return Problem(
      id: (map['id'] ?? '') as String,
      title: (map['title'] ?? '') as String,
      author: (map['author'] ?? '') as String,
      grade: (map['grade'] ?? 0) as int,
      holds: List<Hold>.from(
        (map['holds'] as List<int>).map<Hold>(
          (x) => Hold.fromMap(x as Map<String, dynamic>),
        ),
      ),
      type: type == null
          ? ProblemType.none
          : type < ProblemType.values.length
              ? ProblemType.values[type]
              : ProblemType.none,
    );
  }

  @override
  bool get stringify => true;

  @override
  List<Object> get props {
    return [
      id,
      title,
      author,
      grade,
      holds,
      type,
    ];
  }
}
