import 'dart:math' as math;
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../core/constants/app_colors.dart';
import '../../core/utils/app_preferences.dart';
import '../../services/auth_service.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  late final Animation<double> _logoScale;
  late final Animation<double> _logoFade;
  late final Animation<Offset> _titleSlide;
  late final Animation<double> _titleFade;
  late final Animation<double> _subtitleFade;
  late final Animation<double> _indicatorFade;
  late final Animation<double> _progressAnimation;
  late final Animation<double> _orbPulse;

  String? _targetRoute;
  bool _animationCompleted = false;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 2200),
    );

    _logoScale = Tween<double>(begin: 0.6, end: 1.0).animate(
      CurvedAnimation(
        parent: _controller,
        curve: const Interval(0.08, 0.55, curve: Curves.easeOutBack),
      ),
    );

    _logoFade = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _controller,
        curve: const Interval(0.05, 0.45, curve: Curves.easeIn),
      ),
    );

    _titleSlide = Tween<Offset>(
      begin: const Offset(0, 0.35),
      end: Offset.zero,
    ).animate(
      CurvedAnimation(
        parent: _controller,
        curve: const Interval(0.35, 0.72, curve: Curves.easeOutCubic),
      ),
    );

    _titleFade = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _controller,
        curve: const Interval(0.35, 0.65, curve: Curves.easeIn),
      ),
    );

    _subtitleFade = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _controller,
        curve: const Interval(0.52, 0.82, curve: Curves.easeIn),
      ),
    );

    _indicatorFade = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _controller,
        curve: const Interval(0.65, 0.90, curve: Curves.easeIn),
      ),
    );

    _progressAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _controller,
        curve: const Interval(0.55, 0.95, curve: Curves.easeInOutCubic),
      ),
    );

    _orbPulse = Tween<double>(begin: 0.9, end: 1.15).animate(
      CurvedAnimation(
        parent: _controller,
        curve: const Interval(0.0, 1.0, curve: Curves.easeInOutSine),
      ),
    );

    _controller.forward().then((_) {
      if (mounted) {
        setState(() => _animationCompleted = true);
        _navigateIfReady();
      }
    });

    _resolveNextRoute();
  }

  Future<void> _resolveNextRoute() async {
    try {
      // 1. Highest priority: Keep user/company permanently logged in!
      final authService = AuthService();
      final user = await authService.getCachedUser();
      final isLoggedIn = (await AppPreferences.getBool('is_logged_in')) ?? false;

      if (user != null && isLoggedIn) {
        _targetRoute = '/home';
        _navigateIfReady();
        return;
      }

      // 2. Check onboarding completion
      final completed = (await AppPreferences.getBool('onboarding_completed')) ?? false;
      if (!completed) {
        _targetRoute = '/onboarding';
      } else {
        _targetRoute = '/login';
      }
    } catch (_) {
      _targetRoute = '/onboarding';
    }

    _navigateIfReady();
  }

  void _navigateIfReady() {
    if (_animationCompleted && _targetRoute != null && mounted) {
      context.go(_targetRoute!);
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      body: Stack(
        children: [
          // 1. Modern Deep Royal Blue Background Gradient
          Container(
            width: double.infinity,
            height: double.infinity,
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
                  Color(0xFF1E3A8A), // Deep Royal 900
                  Color(0xFF1D4ED8), // Vibrant Royal 700
                  Color(0xFF0F172A), // Slate 900
                ],
                stops: [0.0, 0.55, 1.0],
              ),
            ),
          ),

          // 2. Top-Right Ambient Glowing Orb
          AnimatedBuilder(
            animation: _orbPulse,
            builder: (context, child) {
              return Positioned(
                top: -80 * _orbPulse.value,
                right: -80 * _orbPulse.value,
                child: Container(
                  width: 260 * _orbPulse.value,
                  height: 260 * _orbPulse.value,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    gradient: RadialGradient(
                      colors: [
                        const Color(0xFF60A5FA).withOpacity(0.28),
                        const Color(0xFF2563EB).withOpacity(0.0),
                      ],
                    ),
                  ),
                ),
              );
            },
          ),

          // 3. Bottom-Left Ambient Glowing Orb
          AnimatedBuilder(
            animation: _orbPulse,
            builder: (context, child) {
              return Positioned(
                bottom: -100 * _orbPulse.value,
                left: -80 * _orbPulse.value,
                child: Container(
                  width: 300 * _orbPulse.value,
                  height: 300 * _orbPulse.value,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    gradient: RadialGradient(
                      colors: [
                        const Color(0xFF38BDF8).withOpacity(0.20),
                        const Color(0xFF1E40AF).withOpacity(0.0),
                      ],
                    ),
                  ),
                ),
              );
            },
          ),

          // 4. Centered Logo and Brand Content
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // Animated Logo with Glassmorphic Container & Glow
                AnimatedBuilder(
                  animation: _controller,
                  builder: (context, child) {
                    return Opacity(
                      opacity: _logoFade.value,
                      child: Transform.scale(
                        scale: _logoScale.value,
                        child: Container(
                          width: 124,
                          height: 124,
                          decoration: BoxDecoration(
                            color: Colors.white.withOpacity(0.12),
                            borderRadius: BorderRadius.circular(32),
                            border: Border.all(
                              color: Colors.white.withOpacity(0.28),
                              width: 1.5,
                            ),
                            boxShadow: [
                              BoxShadow(
                                color: const Color(0xFF3B82F6).withOpacity(0.40),
                                blurRadius: 36,
                                spreadRadius: 6,
                                offset: const Offset(0, 10),
                              ),
                            ],
                          ),
                          padding: const EdgeInsets.all(18),
                          child: Image.asset(
                            'assets/images/logo.png',
                            fit: BoxFit.contain,
                          ),
                        ),
                      ),
                    );
                  },
                ),

                const SizedBox(height: 26),

                // Animated App Title
                AnimatedBuilder(
                  animation: _controller,
                  builder: (context, child) {
                    return Opacity(
                      opacity: _titleFade.value,
                      child: SlideTransition(
                        position: _titleSlide,
                        child: Column(
                          children: [
                            const Text(
                              'دايركت وورك',
                              style: TextStyle(
                                fontSize: 28,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                                fontFamily: 'Cairo',
                                letterSpacing: -0.3,
                                shadows: [
                                  Shadow(
                                    color: Colors.black26,
                                    blurRadius: 10,
                                    offset: Offset(0, 3),
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(height: 4),
                            Text(
                              'DIRECT WORK',
                              style: TextStyle(
                                fontSize: 13,
                                fontWeight: FontWeight.w700,
                                color: const Color(0xFF93C5FD).withOpacity(0.95),
                                letterSpacing: 4.0,
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),

                const SizedBox(height: 12),

                // Animated Subtitle Tagline
                FadeTransition(
                  opacity: _subtitleFade,
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 5),
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.08),
                      borderRadius: BorderRadius.circular(20),
                      border: Border.all(
                        color: Colors.white.withOpacity(0.12),
                        width: 1,
                      ),
                    ),
                    child: const Text(
                      'بوابتك المباشرة للوظائف والكفاءات',
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w500,
                        color: Color(0xFFE2E8F0),
                        fontFamily: 'Cairo',
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),

          // 5. Sleek Bottom Loading Indicator
          Positioned(
            bottom: 50,
            left: 0,
            right: 0,
            child: FadeTransition(
              opacity: _indicatorFade,
              child: Column(
                children: [
                  // Minimal Progress Bar Capsule
                  Container(
                    width: 140,
                    height: 4,
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.15),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: AnimatedBuilder(
                        animation: _progressAnimation,
                        builder: (context, child) {
                          return Container(
                            width: 140 * _progressAnimation.value,
                            height: 4,
                            decoration: BoxDecoration(
                              gradient: const LinearGradient(
                                colors: [
                                  Color(0xFF60A5FA),
                                  Color(0xFF93C5FD),
                                  Colors.white,
                                ],
                              ),
                              borderRadius: BorderRadius.circular(10),
                              boxShadow: [
                                BoxShadow(
                                  color: const Color(0xFF60A5FA).withOpacity(0.6),
                                  blurRadius: 8,
                                  spreadRadius: 1,
                                ),
                              ],
                            ),
                          );
                        },
                      ),
                    ),
                  ),
                  const SizedBox(height: 14),
                  Text(
                    'GCC Careers & Talent Network',
                    style: TextStyle(
                      fontSize: 11,
                      fontWeight: FontWeight.w500,
                      color: Colors.white.withOpacity(0.45),
                      letterSpacing: 0.8,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
