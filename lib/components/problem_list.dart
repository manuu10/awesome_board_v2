import 'package:awesome_board_v2/components/shared/dimmed_button.dart';
import 'package:awesome_board_v2/components/shared/size_offset_wrapper.dart';
import 'package:awesome_board_v2/constants/app_colors.dart';
import 'package:awesome_board_v2/constants/routes.dart';
import 'package:awesome_board_v2/models/problem.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class ResponsiveProblemList extends HookConsumerWidget {
  const ResponsiveProblemList(this.problems, {super.key});
  final List<Problem> problems;
  static const gridItemWidth = 200;
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final widgetSize = useState(const Size(0, 0));
    final columns = widgetSize.value.width / gridItemWidth;

    return SizeOffsetWrapper(
      onSizeChange: (size) {
        widgetSize.value = size;
      },
      child: widgetSize.value.width > 600
          ? GridView.builder(
              itemCount: problems.length,
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: columns.toInt(),
                childAspectRatio: 2,
                mainAxisSpacing: 10,
                crossAxisSpacing: 10,
              ),
              itemBuilder: (ctx, index) => ProblemCard(
                problem: problems[index],
              ),
            )
          : ListView.builder(
              itemCount: problems.length,
              itemBuilder: (ctx, index) => ProblemListTile(
                problem: problems[index],
              ),
            ),
    );
  }
}

class ProblemListTile extends StatelessWidget {
  const ProblemListTile({super.key, required this.problem});
  final Problem problem;
  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: () => Routes.goProblemID(context, problem.id),
      title: Text(
        problem.title,
        style: const TextStyle(color: AppTheme.primary),
      ),
    );
  }
}

class ProblemCard extends StatelessWidget {
  const ProblemCard({Key? key, required this.problem}) : super(key: key);
  final Problem problem;

  @override
  Widget build(BuildContext context) {
    return DimmedButton(
      onPressed: () => Routes.goProblemID(context, problem.id),
      child: Padding(
        padding: const EdgeInsets.all(8),
        child: Text(problem.title),
      ),
    );
  }
}
