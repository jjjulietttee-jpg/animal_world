import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:talker_flutter/talker_flutter.dart';

import '../navigation/presentation/cubit/navigation_cubit.dart';
import '../navigation/presentation/widgets/app_router.dart';
import '../navigation/data/constants/navigation_constants.dart';
import '../../features/game/data/datasources/animal_local_datasource.dart';
import '../../features/game/data/repositories/animal_repository_impl.dart';
import '../../features/game/domain/repositories/animal_repository.dart';
import '../../features/game/domain/usecases/get_animals.dart';
import '../../features/game/domain/usecases/get_random_animals.dart';
import '../../features/game/presentation/bloc/game_bloc.dart';
import '../services/storage_service.dart';

final GetIt getIt = GetIt.instance;

class BlocProviders {
  BlocProviders._();

  static void setup() {
    _registerTalker();
    _registerNavigationCubit();
    _registerGameDependencies();
    _registerGameBloc();
  }

  static void _registerTalker() {
    getIt.registerLazySingleton<Talker>(
      () => TalkerFlutter.init(settings: TalkerSettings(enabled: true)),
    );
  }

  static void _registerNavigationCubit() {
    getIt.registerFactoryParam<NavigationCubit, String, bool>(
      (currentLocation, isDark) =>
          NavigationCubit(currentLocation: currentLocation, isDark: isDark),
    );
  }

  static void _registerGameDependencies() {
    getIt.registerLazySingleton<StorageService>(
      () => StorageService(),
    );

    getIt.registerLazySingleton<AnimalLocalDataSource>(
      () => AnimalLocalDataSourceImpl(),
    );

    getIt.registerLazySingleton<AnimalRepository>(
      () => AnimalRepositoryImpl(
        localDataSource: getIt<AnimalLocalDataSource>(),
      ),
    );

    getIt.registerLazySingleton<GetAnimals>(
      () => GetAnimals(getIt<AnimalRepository>()),
    );

    getIt.registerLazySingleton<GetRandomAnimals>(
      () => GetRandomAnimals(getIt<AnimalRepository>()),
    );
  }

  static void _registerGameBloc() {
    getIt.registerFactory<GameBloc>(
      () => GameBloc(
        getAnimals: getIt<GetAnimals>(),
        getRandomAnimals: getIt<GetRandomAnimals>(),
        storageService: getIt<StorageService>(),
      ),
    );
  }

  static Widget wrapWithProviders({
    required BuildContext context,
    required Widget child,
  }) {
    final brightness = MediaQuery.platformBrightnessOf(context);
    final isDark = brightness == Brightness.dark;

    String currentLocation;
    try {
      currentLocation =
          AppRouter.router.routerDelegate.currentConfiguration.uri.path;
      if (currentLocation.isEmpty) {
        currentLocation = NavigationConstants.home;
      }
    } catch (_) {
      currentLocation = NavigationConstants.home;
    }

    return MultiBlocProvider(
      providers: [
        BlocProvider<NavigationCubit>(
          create: (_) =>
              getIt<NavigationCubit>(param1: currentLocation, param2: isDark),
        ),
        BlocProvider<GameBloc>(
          create: (_) => getIt<GameBloc>(),
        ),
      ],
      child: child,
    );
  }
}
