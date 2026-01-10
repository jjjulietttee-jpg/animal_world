import 'package:animal_world/core/navigation/presentation/widgets/app_router.dart';
import 'package:animal_world/core/theme/app_theme.dart';
import 'package:animal_world/core/bloc/bloc_providers.dart';
import 'package:flutter/material.dart';

void main() {
  BlocProviders.setup();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'Animal World',
      theme: AppTheme.light,
      routerConfig: AppRouter.router,
    );
  }
}
