import 'dart:math' as math;

import 'package:flutter/material.dart';

/// Reusable snowfall overlay that renders gently falling snowflakes across any screen.
///
/// Wrapped in [IgnorePointer] so it never intercepts or blocks user gestures,
/// taps, scrolling, or game controls.
class SnowfallOverlay extends StatefulWidget {
  final Widget child;
  final int numberOfSnowflakes;
  final bool enabled;
  final double speedMultiplier;

  const SnowfallOverlay({
    super.key,
    required this.child,
    this.numberOfSnowflakes = 40,
    this.enabled = true,
    this.speedMultiplier = 1.0,
  });

  @override
  State<SnowfallOverlay> createState() => _SnowfallOverlayState();
}

class _SnowfallOverlayState extends State<SnowfallOverlay>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  late final List<_SnowflakeParticle> _snowflakes;
  final math.Random _random = math.Random(42);

  bool get _isTestEnvironment =>
      WidgetsBinding.instance.runtimeType.toString().contains('Test');

  @override
  void initState() {
    super.initState();
    _snowflakes = List.generate(
      widget.numberOfSnowflakes,
      (index) => _SnowflakeParticle.random(_random),
    );

    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 10),
    );

    if (widget.enabled && !_isTestEnvironment) {
      _controller.repeat();
    }
  }

  @override
  void didUpdateWidget(SnowfallOverlay oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.enabled != oldWidget.enabled) {
      if (widget.enabled && !_isTestEnvironment) {
        _controller.repeat();
      } else {
        _controller.stop();
      }
    }
    if (widget.numberOfSnowflakes != oldWidget.numberOfSnowflakes) {
      _snowflakes.clear();
      _snowflakes.addAll(
        List.generate(
          widget.numberOfSnowflakes,
          (index) => _SnowflakeParticle.random(_random),
        ),
      );
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (!widget.enabled) {
      return widget.child;
    }

    return Stack(
      children: [
        widget.child,
        Positioned.fill(
          child: IgnorePointer(
            child: AnimatedBuilder(
              animation: _controller,
              builder: (context, _) {
                return CustomPaint(
                  painter: _SnowfallPainter(
                    snowflakes: _snowflakes,
                    progress: _controller.value,
                    speedMultiplier: widget.speedMultiplier,
                  ),
                );
              },
            ),
          ),
        ),
      ],
    );
  }
}

class _SnowflakeParticle {
  final double initialX;
  final double initialY;
  final double radius;
  final double opacity;
  final double fallRate;
  final double swaySpeed;
  final double swayAmplitude;
  final double swayPhase;

  _SnowflakeParticle({
    required this.initialX,
    required this.initialY,
    required this.radius,
    required this.opacity,
    required this.fallRate,
    required this.swaySpeed,
    required this.swayAmplitude,
    required this.swayPhase,
  });

  factory _SnowflakeParticle.random(math.Random rand) {
    return _SnowflakeParticle(
      initialX: rand.nextDouble(),
      initialY: rand.nextDouble(),
      radius: 1.5 + rand.nextDouble() * 2.5,
      opacity: 0.35 + rand.nextDouble() * 0.50,
      fallRate: 0.6 + rand.nextDouble() * 0.8,
      swaySpeed: 1.5 + rand.nextDouble() * 2.5,
      swayAmplitude: 6.0 + rand.nextDouble() * 12.0,
      swayPhase: rand.nextDouble() * 2 * math.pi,
    );
  }
}

class _SnowfallPainter extends CustomPainter {
  final List<_SnowflakeParticle> snowflakes;
  final double progress;
  final double speedMultiplier;

  _SnowfallPainter({
    required this.snowflakes,
    required this.progress,
    required this.speedMultiplier,
  });

  @override
  void paint(Canvas canvas, Size size) {
    if (size.width <= 0 || size.height <= 0) return;

    final paint = Paint()
      ..color = Colors.white
      ..isAntiAlias = true
      ..style = PaintingStyle.fill;

    for (final flake in snowflakes) {
      // Calculate continuous falling y coordinate
      final totalDisplacement = progress * flake.fallRate * speedMultiplier;
      final currentY =
          ((flake.initialY + totalDisplacement) % 1.0) * (size.height + 20) -
          10;

      // Calculate horizontal wind sway
      final sway =
          math.sin(flake.swayPhase + progress * flake.swaySpeed * 2 * math.pi) *
          flake.swayAmplitude;
      final currentX = (flake.initialX * size.width + sway) % size.width;

      paint.color = Colors.white.withAlpha(
        (flake.opacity * 255).round().clamp(0, 255),
      );
      canvas.drawCircle(Offset(currentX, currentY), flake.radius, paint);
    }
  }

  @override
  bool shouldRepaint(covariant _SnowfallPainter oldDelegate) => true;
}
