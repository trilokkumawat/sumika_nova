import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:sumikanova/core/constant/app_color.dart';
import 'package:sumikanova/core/navigation/route_name.dart';
import 'package:sumikanova/core/services/secure_auth_storage.dart';
import 'package:sumikanova/core/utils/img_colorfilter.dart';

class Splash extends StatefulWidget {
  const Splash({super.key});

  @override
  State<Splash> createState() => _SplashState();
}

class _SplashState extends State<Splash> {
  Future<void> redirectToOnboarding() async {
    await Future.delayed(const Duration(seconds: 2));
    if (!mounted) return;
    final isLoggedIn = await SecureAuthStorage.isLoggedIn();
    if (!mounted) return;
    if (isLoggedIn) {
      context.go(RouteName.app);
    } else {
      context.go(RouteName.onboarding);
    }
  }

  @override
  void initState() {
    super.initState();
    redirectToOnboarding();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // backgroundColor: AppColor.primary,
      body: Stack(
        children: [
          Positioned(
            left: 0,
            right: 0,
            bottom: 0,
            child: Image.asset(
              'assets/icons/btmbg.png',
              width: double.infinity,
              fit: BoxFit.fitWidth,
            ),
          ),
          Center(
            child: Image.asset('assets/icons/splash.png', fit: BoxFit.contain),
          ),
        ],
      ),
    );
  }
}
