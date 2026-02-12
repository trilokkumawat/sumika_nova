import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:sumikanova/core/navigation/route_name.dart';
import 'package:sumikanova/app.dart';
import 'package:sumikanova/presentation/screens/auth/createnewpwd.dart';
import 'package:sumikanova/presentation/screens/auth/forget.dart';
import 'package:sumikanova/presentation/screens/auth/login.dart';
import 'package:sumikanova/presentation/screens/auth/register.dart';
import 'package:sumikanova/presentation/screens/auth/verify.dart';
import 'package:sumikanova/presentation/screens/device/add_device.dart';
import 'package:sumikanova/presentation/screens/device/device_details.dart';
import 'package:sumikanova/presentation/screens/onboarding.dart';
import 'package:sumikanova/presentation/screens/roomadd/room_add.dart';
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
      builder: (BuildContext context, GoRouterState state) {
        final extra = state.extra;
        if (extra is Map<String, dynamic>) {
          return VerifyScreen(extraData: extra);
        }
        return VerifyScreen(extra: extra as String?);
      },
    ),
    GoRoute(
      path: RouteName.createnewpwd,
      builder: (BuildContext context, GoRouterState state) =>
          const CreateNewPwdScreen(),
    ),
    GoRoute(
      path: RouteName.roomAdd,
      builder: (BuildContext context, GoRouterState state) =>
          const RoomAddScreen(),
    ),
    GoRoute(
      path: RouteName.addDevice,
      builder: (BuildContext context, GoRouterState state) =>
          const AddDeviceScreen(),
    ),
    GoRoute(
      path: RouteName.deviceDetails,
      builder: (BuildContext context, GoRouterState state) =>
          DeviceDetailsScreen(deviceid: state.extra as String?),
    ),
  ],
);
