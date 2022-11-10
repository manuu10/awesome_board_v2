import 'package:awesome_board_v2/components/board/board.dart';
import 'package:awesome_board_v2/models/problem.dart';
import 'package:flutter/material.dart';

class ProblemDetailScreen extends StatelessWidget {
  const ProblemDetailScreen({Key? key, required this.problem})
      : super(key: key);

  final Problem problem;

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        Card(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(problem.title),
          ),
        ),
        Align(
          alignment: Alignment.center,
          child: Board(
            holds: problem.holds,
          ),
        )
      ],
    );
  }
}
