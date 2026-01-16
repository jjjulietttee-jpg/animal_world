import 'package:flutter/material.dart';
import 'package:animal_world/core/services/url_checker_service.dart';
import 'package:animal_world/core/theme/app_colors.dart';
import 'package:animal_world/core/theme/app_theme.dart';
import 'package:animal_world/features/webview/presentation/screens/webview_screen.dart';
import 'package:animal_world/core/navigation/presentation/widgets/app_router.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with WidgetsBindingObserver {
  bool _isChecking = true;
  bool _shouldShowWebView = false;
  bool _checkCompleted = false;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    _checkAndNavigate();
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  /// Обработка изменения состояния приложения (свернули/развернули)
  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.resumed) {
      // При возврате в приложение - проверяем заново
      _checkAndNavigate();
    }
  }

  Future<void> _checkAndNavigate() async {
    if (!mounted) return;

    setState(() {
      _isChecking = true;
    });

    final start = DateTime.now();
    final shouldShowWebView = await UrlCheckerService.shouldShowWebView();
    final elapsed = DateTime.now().difference(start);
    const minDuration = Duration(seconds: 1);
    if (elapsed < minDuration) {
      await Future<void>.delayed(minDuration - elapsed);
    }

    if (!mounted) return;

    setState(() {
      _isChecking = false;
      _shouldShowWebView = shouldShowWebView;
      _checkCompleted = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    // Показываем загрузку пока проверяем
    if (_isChecking || !_checkCompleted) {
      return MaterialApp(
        title: 'Animal World',
        theme: AppTheme.light,
        debugShowCheckedModeBanner: false,
        home: _buildLoadingScreen(),
      );
    }

    // WebView если URL доступен
    if (_shouldShowWebView) {
      return MaterialApp(
        title: 'Animal World',
        theme: AppTheme.light,
        debugShowCheckedModeBanner: false,
        home: const WebViewScreen(),
      );
    }

    // Нативное приложение если URL недоступен
    return MaterialApp.router(
      title: 'Animal World',
      theme: AppTheme.light,
      routerConfig: AppRouter.router,
      debugShowCheckedModeBanner: false,
    );
  }

  Widget _buildLoadingScreen() {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              AppColors.gradientStart,
              AppColors.gradientEnd,
              AppColors.gradientStart,
            ],
          ),
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                padding: const EdgeInsets.all(24),
                decoration: BoxDecoration(
                  color: AppColors.cardBg,
                  shape: BoxShape.circle,
                  boxShadow: [
                    BoxShadow(
                      color: AppColors.glowOrange.withOpacity(0.3),
                      blurRadius: 30,
                      spreadRadius: 10,
                    ),
                  ],
                ),
                child: const Icon(
                  Icons.pets_rounded,
                  size: 64,
                  color: AppColors.primaryOrange,
                ),
              ),
              const SizedBox(height: 32),
              const SizedBox(height: 32),
              const SizedBox(
                width: 40,
                height: 40,
                child: CircularProgressIndicator(
                  color: AppColors.primaryOrange,
                  strokeWidth: 3,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
