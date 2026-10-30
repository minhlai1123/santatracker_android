import 'village_location_type.dart';

class VillageLocation {
  final String id;
  final String name;
  final VillageLocationType type;
  final String description;
  final String details;
  final double normalizedX;
  final double normalizedY;
  final int order;

  const VillageLocation({
    required this.id,
    required this.name,
    required this.type,
    required this.description,
    required this.details,
    required this.normalizedX,
    required this.normalizedY,
    required this.order,
  }) : assert(id != '', 'id cannot be empty'),
       assert(name != '', 'name cannot be empty'),
       assert(
         normalizedX >= 0.0 && normalizedX <= 1.0,
         'normalizedX must be within [0.0, 1.0]',
       ),
       assert(
         normalizedY >= 0.0 && normalizedY <= 1.0,
         'normalizedY must be within [0.0, 1.0]',
       ),
       assert(order >= 0, 'order must be non-negative');

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is VillageLocation &&
        other.id == id &&
        other.name == name &&
        other.type == type &&
        other.description == description &&
        other.details == details &&
        other.normalizedX == normalizedX &&
        other.normalizedY == normalizedY &&
        other.order == order;
  }

  @override
  int get hashCode => Object.hash(
    id,
    name,
    type,
    description,
    details,
    normalizedX,
    normalizedY,
    order,
  );

  @override
  String toString() {
    return 'VillageLocation(order: $order, id: $id, name: $name, '
        'coords: ($normalizedX, $normalizedY))';
  }
}
