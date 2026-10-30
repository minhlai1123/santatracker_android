import 'package:flutter/material.dart';

import '../../../../core/constants/app_dimensions.dart';
import '../../../../core/theme/app_colors.dart';
import '../../domain/models/village_location.dart';

class VillageMap extends StatelessWidget {
  final List<VillageLocation> locations;
  final Set<String> discoveredLocationIds;
  final String? selectedLocationId;
  final ValueChanged<String> onSelectLocation;

  const VillageMap({
    super.key,
    required this.locations,
    required this.discoveredLocationIds,
    required this.selectedLocationId,
    required this.onSelectLocation,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      key: const Key('village_map_container'),
      decoration: BoxDecoration(
        color: const Color(0xFF0D253F),
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
      child: AspectRatio(
        aspectRatio: 16 / 11,
        child: LayoutBuilder(
          builder: (context, constraints) {
            final mapWidth = constraints.maxWidth;
            final mapHeight = constraints.maxHeight;

            return Stack(
              clipBehavior: Clip.hardEdge,
              children: [
                Positioned.fill(
                  child: CustomPaint(
                    key: const Key('village_map_canvas'),
                    painter: _VillageMapPainter(),
                  ),
                ),
                ..._buildLocationMarkers(mapWidth, mapHeight),
              ],
            );
          },
        ),
      ),
    );
  }

  List<Widget> _buildLocationMarkers(double mapWidth, double mapHeight) {
    final markers = <Widget>[];

    for (final loc in locations) {
      final isDiscovered = discoveredLocationIds.contains(loc.id);
      final isSelected = selectedLocationId == loc.id;

      final centerX = (loc.normalizedX * mapWidth).clamp(24.0, mapWidth - 24.0);
      final centerY = (loc.normalizedY * mapHeight).clamp(
        24.0,
        mapHeight - 24.0,
      );

      markers.add(
        Positioned(
          left: centerX - 22,
          top: centerY - 22,
          child: GestureDetector(
            key: Key('village_marker_${loc.id}'),
            behavior: HitTestBehavior.opaque,
            onTap: () => onSelectLocation(loc.id),
            child: Semantics(
              button: true,
              label:
                  'Location ${loc.name}. ${isDiscovered ? 'Discovered' : 'Undiscovered'}',
              child: SizedBox(
                width: 44,
                height: 44,
                child: Stack(
                  alignment: Alignment.center,
                  clipBehavior: Clip.none,
                  children: [
                    // Selected glowing outer ring
                    if (isSelected)
                      Container(
                        width: 44,
                        height: 44,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          border: Border.all(
                            color: AppColors.warmGold,
                            width: 2.5,
                          ),
                          boxShadow: [
                            BoxShadow(
                              color: AppColors.warmGold.withAlpha(140),
                              blurRadius: 8,
                              spreadRadius: 2,
                            ),
                          ],
                        ),
                      ),
                    // Marker body
                    Container(
                      width: 32,
                      height: 32,
                      decoration: BoxDecoration(
                        color: isDiscovered
                            ? AppColors.pineGreen
                            : AppColors.christmasRed,
                        shape: BoxShape.circle,
                        border: Border.all(
                          color: isDiscovered
                              ? AppColors.warmGold
                              : Colors.white,
                          width: 2.0,
                        ),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withAlpha(70),
                            blurRadius: 6,
                            offset: const Offset(0, 2),
                          ),
                        ],
                      ),
                      child: Center(
                        child: Icon(
                          loc.type.icon,
                          size: 16,
                          color: Colors.white,
                        ),
                      ),
                    ),
                    // Discovered checkmark badge
                    if (isDiscovered)
                      Positioned(
                        right: 2,
                        top: 2,
                        child: Container(
                          width: 14,
                          height: 14,
                          decoration: const BoxDecoration(
                            color: AppColors.warmGold,
                            shape: BoxShape.circle,
                          ),
                          child: const Center(
                            child: Icon(
                              Icons.check,
                              size: 10,
                              color: Color(0xFF0D253F),
                            ),
                          ),
                        ),
                      ),
                  ],
                ),
              ),
            ),
          ),
        ),
      );

      // Compact floating label below marker
      final showLabelBelow = centerY < mapHeight - 34;
      markers.add(
        Positioned(
          left: (centerX - 50).clamp(4.0, mapWidth - 104.0),
          top: showLabelBelow ? centerY + 22 : centerY - 38,
          child: IgnorePointer(
            child: Container(
              constraints: const BoxConstraints(maxWidth: 100),
              padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
              decoration: BoxDecoration(
                color: isSelected
                    ? const Color(0xE60A1E32)
                    : const Color(0xB30A1E32),
                borderRadius: BorderRadius.circular(AppDimensions.radiusPill),
                border: Border.all(
                  color: isSelected ? AppColors.warmGold : Colors.white24,
                  width: isSelected ? 1.2 : 0.8,
                ),
              ),
              child: Text(
                loc.name,
                textAlign: TextAlign.center,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                  fontSize: 10,
                  fontWeight: isSelected ? FontWeight.w700 : FontWeight.w600,
                  color: Colors.white,
                ),
              ),
            ),
          ),
        ),
      );
    }

    return markers;
  }
}

class _VillageMapPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    _paintWinterBackground(canvas, size);
    _paintSnowDrifts(canvas, size);
    _paintFrozenLake(canvas, size);
    _paintCobblestonePaths(canvas, size);
    _paintPineForest(canvas, size);
    _paintVillageDetails(canvas, size);
  }

  void _paintWinterBackground(Canvas canvas, Size size) {
    // Night sky gradient at top, soft snowy earth at bottom
    final skyPaint = Paint()
      ..shader = const LinearGradient(
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
        colors: [Color(0xFF0F2640), Color(0xFF1E3D59), Color(0xFFE2E8F0)],
        stops: [0.0, 0.35, 0.70],
      ).createShader(Offset.zero & size);
    canvas.drawRect(Offset.zero & size, skyPaint);

    // Subtle stars in the winter night sky
    final starPaint = Paint()..color = Colors.white.withAlpha(90);
    const starOffsets = [
      Offset(0.12, 0.08),
      Offset(0.28, 0.14),
      Offset(0.48, 0.06),
      Offset(0.66, 0.12),
      Offset(0.85, 0.09),
      Offset(0.92, 0.18),
    ];
    for (final s in starOffsets) {
      canvas.drawCircle(
        Offset(s.dx * size.width, s.dy * size.height),
        1.5,
        starPaint,
      );
    }
  }

  void _paintSnowDrifts(Canvas canvas, Size size) {
    final hillPaint = Paint()
      ..color = const Color(0xFFF8FAFC)
      ..style = PaintingStyle.fill;

    final shadowPaint = Paint()
      ..color = const Color(0xFFCBD5E1).withAlpha(100)
      ..style = PaintingStyle.fill;

    // Distant hill
    final pathDistant = Path()
      ..moveTo(0, size.height * 0.40)
      ..quadraticBezierTo(
        size.width * 0.3,
        size.height * 0.28,
        size.width * 0.6,
        size.height * 0.38,
      )
      ..quadraticBezierTo(
        size.width * 0.85,
        size.height * 0.44,
        size.width,
        size.height * 0.34,
      )
      ..lineTo(size.width, size.height)
      ..lineTo(0, size.height)
      ..close();
    canvas.drawPath(pathDistant, shadowPaint);

    // Foreground snowy village ground
    final pathForeground = Path()
      ..moveTo(0, size.height * 0.48)
      ..quadraticBezierTo(
        size.width * 0.25,
        size.height * 0.42,
        size.width * 0.5,
        size.height * 0.46,
      )
      ..quadraticBezierTo(
        size.width * 0.75,
        size.height * 0.50,
        size.width,
        size.height * 0.44,
      )
      ..lineTo(size.width, size.height)
      ..lineTo(0, size.height)
      ..close();
    canvas.drawPath(pathForeground, hillPaint);
  }

  void _paintFrozenLake(Canvas canvas, Size size) {
    // Crystal Ice Lake in the bottom-right corner
    final lakePaint = Paint()
      ..shader =
          const LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [Color(0xFFBAE6FD), Color(0xFF7DD3FC), Color(0xFF38BDF8)],
          ).createShader(
            Rect.fromCenter(
              center: Offset(size.width * 0.68, size.height * 0.82),
              width: size.width * 0.26,
              height: size.height * 0.20,
            ),
          );

    final lakeBorder = Paint()
      ..color = Colors.white.withAlpha(200)
      ..strokeWidth = 2.0
      ..style = PaintingStyle.stroke;

    final lakeRect = Rect.fromCenter(
      center: Offset(size.width * 0.68, size.height * 0.82),
      width: size.width * 0.26,
      height: size.height * 0.18,
    );
    canvas.drawOval(lakeRect, lakePaint);
    canvas.drawOval(lakeRect, lakeBorder);
  }

  void _paintCobblestonePaths(Canvas canvas, Size size) {
    final pathPaint = Paint()
      ..color = const Color(0xFFE2B887).withAlpha(160)
      ..strokeWidth = 6.0
      ..strokeCap = StrokeCap.round
      ..style = PaintingStyle.stroke;

    final snowEdgePaint = Paint()
      ..color = Colors.white.withAlpha(140)
      ..strokeWidth = 10.0
      ..strokeCap = StrokeCap.round
      ..style = PaintingStyle.stroke;

    // Center Plaza (0.50, 0.52) radiates to all other locations
    final center = Offset(size.width * 0.50, size.height * 0.52);

    final destinations = [
      Offset(size.width * 0.24, size.height * 0.26), // Santa House
      Offset(size.width * 0.76, size.height * 0.26), // Workshop
      Offset(size.width * 0.80, size.height * 0.64), // Stables
      Offset(size.width * 0.50, size.height * 0.28), // Grand Tree
      Offset(size.width * 0.20, size.height * 0.64), // Post Office
      Offset(size.width * 0.34, size.height * 0.80), // Bakery
      Offset(size.width * 0.68, size.height * 0.82), // Lake
    ];

    for (final dest in destinations) {
      final curvePath = Path()
        ..moveTo(center.dx, center.dy)
        ..quadraticBezierTo(
          (center.dx + dest.dx) / 2 + 10,
          (center.dy + dest.dy) / 2,
          dest.dx,
          dest.dy,
        );
      canvas.drawPath(curvePath, snowEdgePaint);
      canvas.drawPath(curvePath, pathPaint);
    }
  }

  void _paintPineForest(Canvas canvas, Size size) {
    const trees = [
      Offset(0.08, 0.32),
      Offset(0.14, 0.45),
      Offset(0.38, 0.22),
      Offset(0.62, 0.22),
      Offset(0.90, 0.35),
      Offset(0.88, 0.52),
      Offset(0.10, 0.78),
      Offset(0.52, 0.74),
      Offset(0.88, 0.84),
    ];

    final pinePaint = Paint()
      ..color = const Color(0xFF1B4D3E)
      ..style = PaintingStyle.fill;

    final snowCapPaint = Paint()
      ..color = Colors.white.withAlpha(220)
      ..style = PaintingStyle.fill;

    for (final t in trees) {
      final x = t.dx * size.width;
      final y = t.dy * size.height;

      // Tree triangles
      final p1 = Path()
        ..moveTo(x, y - 14)
        ..lineTo(x - 9, y)
        ..lineTo(x + 9, y)
        ..close();
      canvas.drawPath(p1, pinePaint);

      final p2 = Path()
        ..moveTo(x, y - 8)
        ..lineTo(x - 12, y + 8)
        ..lineTo(x + 12, y + 8)
        ..close();
      canvas.drawPath(p2, pinePaint);

      // Snow on branches
      canvas.drawCircle(Offset(x, y - 14), 2.5, snowCapPaint);
    }
  }

  void _paintVillageDetails(Canvas canvas, Size size) {
    // Warm festive lantern glows along paths
    final lanternPaint = Paint()
      ..color = const Color(0xFFFDE047).withAlpha(180);

    const lanterns = [
      Offset(0.42, 0.44),
      Offset(0.58, 0.44),
      Offset(0.32, 0.60),
      Offset(0.68, 0.60),
      Offset(0.40, 0.68),
    ];

    for (final l in lanterns) {
      final center = Offset(l.dx * size.width, l.dy * size.height);
      canvas.drawCircle(center, 3.5, lanternPaint);
    }
  }

  @override
  bool shouldRepaint(covariant _VillageMapPainter oldDelegate) => false;
}
