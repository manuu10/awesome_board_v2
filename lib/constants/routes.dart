import 'package:awesome_board_v2/components/app_shell.dart';
import 'package:awesome_board_v2/components/create_screen.dart';
import 'package:awesome_board_v2/components/home_screen.dart';
import 'package:awesome_board_v2/components/problem_detail/problem_detail_screen.dart';
import 'package:awesome_board_v2/components/problem_detail/problem_detail_shell.dart';
import 'package:awesome_board_v2/repository/problem_repository.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

abstract class Routes {
  static const home = "home";
  static const create = "create";
  static const settings = "settings";
  static const heatmap = "heatmap";
  static const problemID = "problemDetail";
  static const ledTester = "led_tester";
  static const viewedProblems = "viewed_problems";

  static void goViewedProblems(BuildContext context) =>
      context.goNamed(viewedProblems);
  static void goHome(BuildContext context) => context.goNamed(home);
  static void goCreate(BuildContext context) => context.goNamed(create);
  static void goSettings(BuildContext context) => context.goNamed(settings);
  static void goHeatmap(BuildContext context) => context.goNamed(heatmap);
  static void goProblemID(BuildContext context, String id) =>
      context.goNamed(problemID, params: {"problemID": id});
  static void goLedTester(BuildContext context) => context.goNamed(ledTester);

  static final router = GoRouter(
    routes: [
      ShellRoute(
        builder: (context, state, child) {
          return AppShell(
            mainContent: child,
          );
        },
        routes: [
          GoRoute(
            path: "/",
            name: home,
            builder: (context, state) {
              return const HomeScreen();
            },
            routes: [
              GoRoute(
                path: "create",
                name: create,
                builder: (context, state) {
                  return const CreateScreen();
                },
              ),
              GoRoute(
                path: "settings",
                name: settings,
                builder: (context, state) {
                  return const Text("Settings");
                },
              )
            ],
          ),
        ],
      ),
      ShellRoute(
        builder: (context, state, child) {
          return ProblemDetailShell(
            problemDetailScreen: child,
          );
        },
        routes: [
          GoRoute(
            path: "/problem/:problemID",
            name: problemID,
            builder: (context, state) {
              final paramProblemID = state.params["problemID"];
              if (paramProblemID != null) {
                final idx = ProblemRepositoryDummy.memoryList
                    .indexWhere((e) => e.id == paramProblemID);
                if (idx >= 0) {
                  return ProblemDetailScreen(
                    problem: ProblemRepositoryDummy.memoryList[idx],
                  );
                }
              }
              return const Center(
                child: Text("Problem not found"),
              );
            },
          ),
        ],
      ),
      GoRoute(
          path: "/viewed_problems",
          name: viewedProblems,
          builder: ((context, state) => const ViewedProblemsListScreen()))
    ],
  );
}
