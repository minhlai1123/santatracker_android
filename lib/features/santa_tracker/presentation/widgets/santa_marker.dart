import 'package:flutter/material.dart';

import '../../../../core/theme/app_colors.dart';

class SantaMarker extends StatefulWidget {
  final bool isAnimating;
  final String stopName;

  const SantaMarker({
    super.key,
    required this.isAnimating,
    required this.stopName,
  });

  @override
  State<SantaMarker> createState() => _SantaMarkerState();
}

class _SantaMarkerState extends State<SantaMarker>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  late final Animation<double> _scaleAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1400),
    );
    _scaleAnimation = Tween<double>(
      begin: 1.0,
      end: 1.14,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeInOut));

    _syncAnimationState();
  }

  @override
  void didUpdateWidget(covariant SantaMarker oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.isAnimating != widget.isAnimating) {
      _syncAnimationState();
    }
  }

  void _syncAnimationState() {
    if (widget.isAnimating) {
      if (!_controller.isAnimating) {
        _controller.repeat(reverse: true);
      }
    } else {
      if (_controller.isAnimating) {
        _controller.stop();
      }
      _controller.value = 0.0;
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Semantics(
      label: 'Vị trí Santa tại ${widget.stopName}',
      child: AnimatedBuilder(
        animation: _scaleAnimation,
        builder: (context, child) {
          return Transform.scale(scale: _scaleAnimation.value, child: child);
        },
        child: Container(
          key: const Key('santa_current_marker'),
          width: 34,
          height: 34,
          decoration: BoxDecoration(
            color: AppColors.christmasRed,
            shape: BoxShape.circle,
            border: Border.all(color: AppColors.warmGold, width: 2.5),
            boxShadow: [
              BoxShadow(
                color: AppColors.christmasRed.withAlpha(120),
                blurRadius: 10,
                spreadRadius: 2,
              ),
            ],
          ),
          child: const Center(
            child: Icon(
              Icons.card_giftcard_rounded,
              size: 18,
              color: Colors.white,
            ),
          ),
        ),
      ),
    );
  }
}
