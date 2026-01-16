import 'package:animal_world/core/bloc/bloc_providers.dart';
import 'package:animal_world/features/splash/presentation/screens/splash_screen.dart';
import 'package:flutter/material.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  BlocProviders.setup();
  runApp(const SplashScreen());
}
