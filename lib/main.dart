import 'package:awesome_board_v2/constants/app_colors.dart';
import 'package:awesome_board_v2/constants/routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ProviderScope(
      child: MaterialApp.router(
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: AppTheme.colorToMatColor(AppTheme.primary),
          backgroundColor: AppTheme.background,
          scaffoldBackgroundColor: AppTheme.background,
          dialogBackgroundColor: AppTheme.background.withAlpha(128),
          brightness: Brightness.dark,
          textTheme: Theme.of(context).textTheme.apply(
                bodyColor: AppTheme.foreground,
                displayColor: AppTheme.foreground,
              ),
          cardColor: AppTheme.secondBackground,
          iconTheme: const IconThemeData(
            color: AppTheme.foreground,
          ),
          appBarTheme: const AppBarTheme(
            backgroundColor: AppTheme.background,
            foregroundColor: AppTheme.foreground,
          ),
          navigationBarTheme: NavigationBarTheme.of(context).copyWith(
            indicatorColor: AppTheme.primary,
            indicatorShape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(AppTheme.radius),
            ),
            backgroundColor: AppTheme.primary.withAlpha(20),
          ),
        ),
        routerConfig: Routes.router,
      ),
    );
  }
}
