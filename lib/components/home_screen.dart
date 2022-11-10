import 'package:awesome_board_v2/components/problem_list.dart';
import 'package:awesome_board_v2/repository/problem_repository.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class HomeScreen extends HookConsumerWidget {
  const HomeScreen({super.key});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return ResponsiveProblemList(ProblemRepositoryDummy.memoryList);
  }
}
