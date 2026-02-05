import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:sumikanova/core/navigation/route_name.dart';
import 'package:sumikanova/presentation/screens/home.dart';
import 'package:sumikanova/presentation/screens/onboarding.dart';
import 'package:sumikanova/presentation/screens/splash.dart';

final GoRouter appRouter = GoRouter(
  initialLocation: RouteName.splash,
  routes: <RouteBase>[
    GoRoute(
      path: RouteName.splash,
      builder: (BuildContext context, GoRouterState state) =>
          const Splash(),
    ),
    GoRoute(
      path: RouteName.onboarding,
      builder: (BuildContext context, GoRouterState state) =>
          const Onboarding(),
    ),
    GoRoute(
      path: RouteName.home,
      builder: (BuildContext context, GoRouterState state) =>
          const Home(),
    ),
  ],
);
