import 'dart:async';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:sumikanova/core/navigation/route_name.dart';

class Onboarding extends StatefulWidget {
  const Onboarding({super.key});

  @override
  State<Onboarding> createState() => _OnboardingState();
}

class _OnboardingState extends State<Onboarding> {
  static const _delaySeconds = 2;
  static const _totalSlides = 4;

  int _currentIndex = 0;
  Timer? _timer;

  void _redirect() {
    debugPrint('done');
    if (!mounted) return;
    context.go(RouteName.home);
  }

  void _nextSlide() {
    if (_currentIndex < _totalSlides - 1) {
      setState(() => _currentIndex++);
    } else {
      _timer?.cancel();
      Future.delayed(const Duration(seconds: _delaySeconds), () {
        _redirect();
      });
    }
  }

  @override
  void initState() {
    super.initState();
    _timer = Timer.periodic(const Duration(seconds: _delaySeconds), (_) {
      if (!mounted) return;
      _nextSlide();
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
          if (_currentIndex == 0)
            Center(
              child: Image.asset(
                'assets/icons/smartcontrol.png',
                fit: BoxFit.cover,
              ),
            ),
          if (_currentIndex == 1)
            Center(
              child: Image.asset(
                'assets/icons/smartcontrol.png',
                fit: BoxFit.cover,
              ),
            ),
          if (_currentIndex == 2)
            Center(
              child: Image.asset(
                'assets/icons/smartsecurity.png',
                fit: BoxFit.cover,
              ),
            ),
          if (_currentIndex == 3)
            Center(
              child: Image.asset(
                'assets/icons/saveenergy.png',
                fit: BoxFit.cover,
              ),
            ),
        ],
      ),
    );
  }
}
