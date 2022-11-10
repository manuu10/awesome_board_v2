import 'package:awesome_board_v2/components/board/board.dart';
import 'package:awesome_board_v2/components/problem_list.dart';
import 'package:awesome_board_v2/components/shared/dimmed_button.dart';
import 'package:awesome_board_v2/components/shared/flexible_row.dart';
import 'package:awesome_board_v2/constants/routes.dart';
import 'package:awesome_board_v2/models/problem.dart';
import 'package:awesome_board_v2/repository/problem_repository.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

final problemsViewedHistoryProvider = StateProvider((ref) => const <Problem>[]);

class ProblemDetailShell extends HookConsumerWidget {
  const ProblemDetailShell({Key? key, required this.problemDetailScreen})
      : super(key: key);

  final Widget problemDetailScreen;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final screenSize = MediaQuery.of(context).size;
    final viewedProblems = ref.watch(problemsViewedHistoryProvider);

    final isRowLayout = screenSize.width > Board.maxWidth * 1.5;

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Routes.goHome(context),
        ),
        title: const Text("Problem Detail Screen"),
        actions: [
          if (!isRowLayout)
            DimmedButton(
              onPressed: () => Routes.goViewedProblems(context),
              icon: const Icon(Icons.remove_red_eye),
              child: const Text("Viewed"),
            )
        ],
      ),
      body: isRowLayout
          ? FlexibleRow(
              children: [
                problemDetailScreen,
                ResponsiveProblemList(ProblemRepositoryDummy.memoryList)
              ],
            )
          : problemDetailScreen,
    );
  }
}

class ViewedProblemsListScreen extends HookConsumerWidget {
  const ViewedProblemsListScreen({super.key});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final viewedProblems = ref.watch(problemsViewedHistoryProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text("Already viewed Problems"),
      ),
      body: ResponsiveProblemList(viewedProblems),
    );
  }
}
