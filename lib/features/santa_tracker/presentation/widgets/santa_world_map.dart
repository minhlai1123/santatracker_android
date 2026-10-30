import 'package:flutter/material.dart';

import '../../../../core/constants/app_dimensions.dart';
import '../../../../core/constants/app_strings.dart';
import '../../../../core/theme/app_colors.dart';
import '../../domain/models/santa_stop.dart';
import '../../domain/models/santa_tracker_state.dart';
import 'santa_marker.dart';

class SantaWorldMap extends StatelessWidget {
  final SantaTrackerState state;
  final bool shouldAnimateMarker;

  const SantaWorldMap({
    super.key,
    required this.state,
    required this.shouldAnimateMarker,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      key: const Key('santa_world_map_container'),
      decoration: BoxDecoration(
        color: const Color(0xFF0F2942),
        borderRadius: BorderRadius.circular(AppDimensions.radiusLG),
        border: Border.all(color: AppColors.warmGold.withAlpha(90), width: 1.5),
        boxShadow: [
          BoxShadow(
            color: AppColors.pineGreen.withAlpha(30),
            blurRadius: 16,
            offset: const Offset(0, 6),
          ),
        ],
      ),
      clipBehavior: Clip.antiAlias,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          AspectRatio(
            aspectRatio: 16 / 10,
            child: LayoutBuilder(
              builder: (context, constraints) {
                final mapWidth = constraints.maxWidth;
                final mapHeight = constraints.maxHeight;

                return Stack(
                  clipBehavior: Clip.hardEdge,
                  children: [
                    Positioned.fill(
                      child: CustomPaint(
                        key: const Key('santa_world_map_canvas'),
                        painter: _IllustratedWorldMapPainter(
                          stops: state.stops,
                          currentStopIndex: state.currentStopIndex,
                          isCompleted: state.isCompleted,
                        ),
                      ),
                    ),
                    ..._buildStopMarkers(mapWidth, mapHeight),
                    _buildCurrentStopFloatingTag(mapWidth, mapHeight),
                  ],
                );
              },
            ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(
              horizontal: AppDimensions.spaceMD,
              vertical: AppDimensions.spaceSM,
            ),
            decoration: const BoxDecoration(
              color: Color(0xFF0A1E32),
              border: Border(top: BorderSide(color: Color(0xFF1E3A5F))),
            ),
            child: Wrap(
              alignment: WrapAlignment.spaceEvenly,
              spacing: AppDimensions.spaceMD,
              runSpacing: AppDimensions.spaceXS,
              children: [
                _buildLegendItem(
                  color: AppColors.christmasRed,
                  borderColor: AppColors.warmGold,
                  label: AppStrings.mapLegendCurrent,
                ),
                _buildLegendItem(
                  color: AppColors.warmGold,
                  borderColor: Colors.white,
                  label: AppStrings.mapLegendCompleted,
                ),
                _buildLegendItem(
                  color: const Color(0xFF64748B),
                  borderColor: Colors.white70,
                  label: AppStrings.mapLegendUpcoming,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  List<Widget> _buildStopMarkers(double mapWidth, double mapHeight) {
    final markers = <Widget>[];

    for (int i = 0; i < state.stops.length; i++) {
      final stop = state.stops[i];
      final isCurrent = i == state.currentStopIndex;
      final isVisited = i < state.currentStopIndex || state.isCompleted;

      final centerX = (stop.normalizedX * mapWidth).clamp(
        18.0,
        mapWidth - 18.0,
      );
      final centerY = (stop.normalizedY * mapHeight).clamp(
        18.0,
        mapHeight - 18.0,
      );

      if (isCurrent) {
        markers.add(
          Positioned(
            left: centerX - 17,
            top: centerY - 17,
            child: SantaMarker(
              isAnimating: shouldAnimateMarker,
              stopName: stop.name,
            ),
          ),
        );
      } else {
        markers.add(
          Positioned(
            left: centerX - 7,
            top: centerY - 7,
            child: Tooltip(
              message: stop.fullLabel,
              child: Container(
                key: Key('stop_marker_${stop.id}'),
                width: 14,
                height: 14,
                decoration: BoxDecoration(
                  color: isVisited
                      ? AppColors.warmGold
                      : const Color(0xFF64748B),
                  shape: BoxShape.circle,
                  border: Border.all(
                    color: Colors.white,
                    width: isVisited ? 2.0 : 1.2,
                  ),
                ),
                child: isVisited
                    ? const Center(
                        child: Icon(
                          Icons.check,
                          size: 8,
                          color: Color(0xFF0F2942),
                        ),
                      )
                    : null,
              ),
            ),
          ),
        );
      }
    }

    return markers;
  }

  Widget _buildCurrentStopFloatingTag(double mapWidth, double mapHeight) {
    final stop = state.currentStop;
    final centerX = (stop.normalizedX * mapWidth).clamp(50.0, mapWidth - 50.0);
    final centerY = (stop.normalizedY * mapHeight).clamp(
      18.0,
      mapHeight - 18.0,
    );
    final showBelow = centerY < 48;

    return Positioned(
      left: (centerX - 65).clamp(8.0, mapWidth - 138.0),
      top: showBelow ? centerY + 20 : centerY - 38,
      child: IgnorePointer(
        child: Container(
          constraints: const BoxConstraints(maxWidth: 130),
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
          decoration: BoxDecoration(
            color: const Color(0xE60A1E32),
            borderRadius: BorderRadius.circular(AppDimensions.radiusPill),
            border: Border.all(color: AppColors.warmGold.withAlpha(180)),
          ),
          child: Text(
            stop.name,
            textAlign: TextAlign.center,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: const TextStyle(
              fontSize: 11,
              fontWeight: FontWeight.w700,
              color: Colors.white,
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildLegendItem({
    required Color color,
    required Color borderColor,
    required String label,
  }) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          width: 10,
          height: 10,
          decoration: BoxDecoration(
            color: color,
            shape: BoxShape.circle,
            border: Border.all(color: borderColor, width: 1.5),
          ),
        ),
        const SizedBox(width: 6),
        Text(
          label,
          style: const TextStyle(
            fontSize: 11,
            fontWeight: FontWeight.w600,
            color: Colors.white,
          ),
        ),
      ],
    );
  }
}

class _IllustratedWorldMapPainter extends CustomPainter {
  final List<SantaStop> stops;
  final int currentStopIndex;
  final bool isCompleted;

  const _IllustratedWorldMapPainter({
    required this.stops,
    required this.currentStopIndex,
    required this.isCompleted,
  });

  @override
  void paint(Canvas canvas, Size size) {
    _paintOceanAndGrid(canvas, size);
    _paintContinents(canvas, size);
    _paintRoutePaths(canvas, size);
  }

  void _paintOceanAndGrid(Canvas canvas, Size size) {
    final bgPaint = Paint()
      ..shader = const LinearGradient(
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
        colors: [Color(0xFF0B1F36), Color(0xFF133354), Color(0xFF0D253F)],
      ).createShader(Offset.zero & size);
    canvas.drawRect(Offset.zero & size, bgPaint);

    final gridPaint = Paint()
      ..color = Colors.white.withAlpha(18)
      ..strokeWidth = 1.0
      ..style = PaintingStyle.stroke;

    for (int i = 1; i < 6; i++) {
      final y = size.height * (i / 6);
      canvas.drawLine(Offset(0, y), Offset(size.width, y), gridPaint);
    }

    for (int i = 1; i < 8; i++) {
      final x = size.width * (i / 8);
      canvas.drawLine(Offset(x, 0), Offset(x, size.height), gridPaint);
    }

    final starPaint = Paint()..color = Colors.white.withAlpha(70);
    const stars = <Offset>[
      Offset(0.08, 0.14),
      Offset(0.18, 0.08),
      Offset(0.36, 0.12),
      Offset(0.64, 0.09),
      Offset(0.88, 0.15),
      Offset(0.12, 0.85),
      Offset(0.58, 0.88),
      Offset(0.75, 0.18),
    ];
    for (final star in stars) {
      canvas.drawCircle(
        Offset(star.dx * size.width, star.dy * size.height),
        1.5,
        starPaint,
      );
    }
  }

  void _paintContinents(Canvas canvas, Size size) {
    final landPaint = Paint()
      ..color = const Color(0xFF1E4E4A)
      ..style = PaintingStyle.fill;

    final landBorderPaint = Paint()
      ..color = const Color(0xFF2D6E66)
      ..strokeWidth = 1.2
      ..style = PaintingStyle.stroke;

    final arcticPaint = Paint()
      ..color = Colors.white.withAlpha(45)
      ..style = PaintingStyle.fill;

    // Arctic Cap (North Pole region)
    final arcticRect = Rect.fromCenter(
      center: Offset(size.width * 0.50, size.height * 0.09),
      width: size.width * 0.24,
      height: size.height * 0.10,
    );
    canvas.drawOval(arcticRect, arcticPaint);

    // Simplified stylized landmass polygons in normalized coordinates
    final continents = <List<Offset>>[
      // North America
      const [
        Offset(0.08, 0.18),
        Offset(0.31, 0.18),
        Offset(0.33, 0.34),
        Offset(0.24, 0.46),
        Offset(0.16, 0.42),
        Offset(0.09, 0.29),
      ],
      // South America
      const [
        Offset(0.24, 0.52),
        Offset(0.37, 0.56),
        Offset(0.39, 0.72),
        Offset(0.31, 0.88),
        Offset(0.25, 0.74),
      ],
      // Europe
      const [
        Offset(0.43, 0.20),
        Offset(0.58, 0.19),
        Offset(0.59, 0.36),
        Offset(0.44, 0.37),
      ],
      // Africa
      const [
        Offset(0.44, 0.41),
        Offset(0.60, 0.41),
        Offset(0.62, 0.62),
        Offset(0.54, 0.80),
        Offset(0.47, 0.66),
      ],
      // Asia
      const [
        Offset(0.59, 0.20),
        Offset(0.89, 0.23),
        Offset(0.88, 0.46),
        Offset(0.75, 0.56),
        Offset(0.63, 0.49),
      ],
      // Oceania / Australia & New Zealand
      const [
        Offset(0.78, 0.66),
        Offset(0.93, 0.68),
        Offset(0.94, 0.85),
        Offset(0.79, 0.82),
      ],
    ];

    for (final polygon in continents) {
      final path = Path();
      for (int i = 0; i < polygon.length; i++) {
        final pt = Offset(
          polygon[i].dx * size.width,
          polygon[i].dy * size.height,
        );
        if (i == 0) {
          path.moveTo(pt.dx, pt.dy);
        } else {
          path.lineTo(pt.dx, pt.dy);
        }
      }
      path.close();
      canvas.drawPath(path, landPaint);
      canvas.drawPath(path, landBorderPaint);
    }
  }

  void _paintRoutePaths(Canvas canvas, Size size) {
    if (stops.length < 2) return;

    final upcomingPaint = Paint()
      ..color = Colors.white.withAlpha(65)
      ..strokeWidth = 2.0
      ..strokeCap = StrokeCap.round
      ..style = PaintingStyle.stroke;

    final completedGlowPaint = Paint()
      ..color = AppColors.warmGold.withAlpha(70)
      ..strokeWidth = 6.0
      ..strokeCap = StrokeCap.round
      ..style = PaintingStyle.stroke;

    final completedPaint = Paint()
      ..color = AppColors.warmGold
      ..strokeWidth = 2.6
      ..strokeCap = StrokeCap.round
      ..style = PaintingStyle.stroke;

    for (int i = 0; i < stops.length - 1; i++) {
      final from = Offset(
        stops[i].normalizedX * size.width,
        stops[i].normalizedY * size.height,
      );
      final to = Offset(
        stops[i + 1].normalizedX * size.width,
        stops[i + 1].normalizedY * size.height,
      );

      final isSegmentCompleted = i < currentStopIndex || isCompleted;

      if (isSegmentCompleted) {
        canvas.drawLine(from, to, completedGlowPaint);
        canvas.drawLine(from, to, completedPaint);
      } else {
        _drawDashedLine(canvas, from, to, upcomingPaint);
      }
    }
  }

  void _drawDashedLine(Canvas canvas, Offset p1, Offset p2, Paint paint) {
    const dashWidth = 5.0;
    const dashSpace = 4.0;
    final dx = p2.dx - p1.dx;
    final dy = p2.dy - p1.dy;
    final distance = Offset(dx, dy).distance;
    if (distance <= 0.0) return;

    final unitX = dx / distance;
    final unitY = dy / distance;
    double currentDistance = 0.0;

    while (currentDistance < distance) {
      final endDistance = (currentDistance + dashWidth).clamp(0.0, distance);
      canvas.drawLine(
        Offset(
          p1.dx + unitX * currentDistance,
          p1.dy + unitY * currentDistance,
        ),
        Offset(p1.dx + unitX * endDistance, p1.dy + unitY * endDistance),
        paint,
      );
      currentDistance += dashWidth + dashSpace;
    }
  }

  @override
  bool shouldRepaint(covariant _IllustratedWorldMapPainter oldDelegate) {
    return oldDelegate.currentStopIndex != currentStopIndex ||
        oldDelegate.isCompleted != isCompleted ||
        oldDelegate.stops != stops;
  }
}
