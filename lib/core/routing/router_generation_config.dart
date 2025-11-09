import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../features/home_screen/home_screen.dart';
import 'app_routes.dart';

class RouterGenerationConfig {
  static GoRouter goRouter =
      GoRouter(initialLocation: AppRoutes.homeScreen, routes: [
    GoRoute(
        path: AppRoutes.homeScreen,
        name: AppRoutes.homeScreen,
        builder: (context, state) => HomeScreen()),
    GoRoute(
        path: AppRoutes.searchScreen,
        name: AppRoutes.searchScreen,
        builder: (context, state) => Container()),
    GoRoute(
        path: AppRoutes.searchResultScreen,
        name: AppRoutes.searchResultScreen,
        builder: (context, state) => Container()),
    GoRoute(
        path: AppRoutes.articleDetailsScreen,
        name: AppRoutes.articleDetailsScreen,
        builder: (context, state) => Container()),
  ]);
}
