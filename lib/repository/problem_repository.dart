import 'package:awesome_board_v2/models/problem.dart';

abstract class ProblemRepository {
  Future<List<Problem>> fetchProblems();
  Future<Problem?> addProblem(Problem problem);
  Future<bool> removeProblem(Problem problem);
  Future<Problem?> updateProblem(Problem problem);
}

class ProblemRepositoryDummy extends ProblemRepository {
  static final memoryList = List.generate(
    100,
    (index) => Problem(
      id: index.toString(),
      title: "Problem $index",
      author: "Author",
      grade: 6,
      holds: const [],
      type: ProblemType.feetFollowHands,
    ),
  );

  @override
  Future<Problem?> addProblem(Problem problem) {
    throw UnimplementedError();
  }

  @override
  Future<List<Problem>> fetchProblems() async {
    await Future.delayed(const Duration(seconds: 3));
    return memoryList;
  }

  @override
  Future<bool> removeProblem(Problem problem) {
    throw UnimplementedError();
  }

  @override
  Future<Problem?> updateProblem(Problem problem) {
    throw UnimplementedError();
  }
}
