import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:latlong2/latlong.dart';
import 'package:sumikanova/core/navigation/route_name.dart';
import 'package:sumikanova/app.dart';
import 'package:sumikanova/core/utils/fluttermap.dart';
import 'package:sumikanova/presentation/screens/auth/newpassword/createnewpwd.dart';
import 'package:sumikanova/presentation/screens/auth/forget/forget_screen.dart';
import 'package:sumikanova/presentation/screens/auth/login/login_screen.dart';
import 'package:sumikanova/presentation/screens/auth/register/register_screen.dart';
import 'package:sumikanova/presentation/screens/auth/verify/verify_screen.dart';
import 'package:sumikanova/presentation/screens/device/add_device.dart';
import 'package:sumikanova/presentation/screens/device/device_details.dart';
import 'package:sumikanova/presentation/screens/onboarding.dart';
import 'package:sumikanova/presentation/screens/roomadd/room_add.dart';
import 'package:sumikanova/presentation/screens/setting/homemanagement/home_management_present.dart';
import 'package:sumikanova/data/model/homelist/homelist_model.dart';
import 'package:sumikanova/presentation/screens/setting/homemanagement/subhomanagement/home_mngmt_screen.dart';
import 'package:sumikanova/presentation/screens/setting/homemanagement/subhomanagement/home_settings_screen.dart';
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
          CreateNewPwdScreen(extra: state.extra as Map<String, dynamic>?),
    ),
    GoRoute(
      path: RouteName.roomAdd,
      builder: (BuildContext context, GoRouterState state) =>
          RoomAddScreen(extraData: state.extra as Map<String, dynamic>?),
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
    GoRoute(
      path: RouteName.homeManagement,
      builder: (BuildContext context, GoRouterState state) =>
          const HomeManagementScreen(),
    ),
    GoRoute(
      path: RouteName.mapView,
      builder: (BuildContext context, GoRouterState state) {
        LatLng? initialCenter;
        final extra = state.extra;
        if (extra is Map<String, dynamic> &&
            extra['lat'] != null &&
            extra['lng'] != null) {
          initialCenter = LatLng(
            (extra['lat'] as num).toDouble(),
            (extra['lng'] as num).toDouble(),
          );
        }
        return MapViewScreen(initialCenter: initialCenter);
      },
    ),
    GoRoute(
      path: RouteName.homeManagementParent,
      builder: (BuildContext context, GoRouterState state) =>
          const HomeManagementParentScreen(),
    ),
    GoRoute(
      path: RouteName.homeSettings,
      builder: (BuildContext context, GoRouterState state) {
        final home = state.extra as HomeItem?;
        if (home == null) {
          return const Scaffold(
            body: Center(child: Text('Home not found')),
          );
        }
        return HomeSettingsScreen(home: home);
      },
    ),
  ],
);
