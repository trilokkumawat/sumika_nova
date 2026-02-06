import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:sumikanova/core/navigation/route_name.dart';
import 'package:sumikanova/app.dart';
import 'package:sumikanova/presentation/screens/auth/createnewpwd.dart';
import 'package:sumikanova/presentation/screens/auth/forget.dart';
import 'package:sumikanova/presentation/screens/auth/login.dart';
import 'package:sumikanova/presentation/screens/auth/register.dart';
import 'package:sumikanova/presentation/screens/auth/verify.dart';
import 'package:sumikanova/presentation/screens/onboarding.dart';
import 'package:sumikanova/presentation/screens/splash.dart';

final GoRouter appRouter = GoRouter(
  initialLocation: RouteName.splash,
  routes: <RouteBase>[
    GoRoute(
      path: RouteName.splash,
      builder: (BuildContext context, GoRouterState state) => const Splash(),
    ),
    GoRoute(
      path: RouteName.onboarding,
      builder: (BuildContext context, GoRouterState state) =>
          const Onboarding(),
    ),
    GoRoute(
      path: RouteName.app,
      builder: (BuildContext context, GoRouterState state) => const AppState(),
    ),
    GoRoute(
      path: RouteName.login,
      builder: (BuildContext context, GoRouterState state) =>
          const LoginScreen(),
    ),
    GoRoute(
      path: RouteName.register,
      builder: (BuildContext context, GoRouterState state) =>
          const RegisterScreen(),
    ),
    GoRoute(
      path: RouteName.forget,
      builder: (BuildContext context, GoRouterState state) =>
          const ForgetScreen(),
    ),
    GoRoute(
      path: RouteName.verify,
      builder: (BuildContext context, GoRouterState state) =>
          VerifyScreen(extra: state.extra as String?),
    ),
    GoRoute(
      path: RouteName.createnewpwd,
      builder: (BuildContext context, GoRouterState state) =>
          const CreateNewPwdScreen(),
    ),
  ],
);
