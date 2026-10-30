class SantaStop {
  final String id;
  final String name;
  final String region;
  final String description;
  final double normalizedX;
  final double normalizedY;
  final int giftsToDeliver;
  final int etaMinutesToNext;
  final int order;

  const SantaStop({
    required this.id,
    required this.name,
    required this.region,
    required this.description,
    required this.normalizedX,
    required this.normalizedY,
    required this.giftsToDeliver,
    required this.etaMinutesToNext,
    required this.order,
  }) : assert(
         normalizedX >= 0.0 && normalizedX <= 1.0,
         'normalizedX must be within [0.0, 1.0]',
       ),
       assert(
         normalizedY >= 0.0 && normalizedY <= 1.0,
         'normalizedY must be within [0.0, 1.0]',
       ),
       assert(giftsToDeliver >= 0, 'giftsToDeliver must be non-negative'),
       assert(etaMinutesToNext >= 0, 'etaMinutesToNext must be non-negative'),
       assert(order >= 0, 'order must be non-negative');

  String get fullLabel => '$name, $region';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is SantaStop &&
        other.id == id &&
        other.name == name &&
        other.region == region &&
        other.description == description &&
        other.normalizedX == normalizedX &&
        other.normalizedY == normalizedY &&
        other.giftsToDeliver == giftsToDeliver &&
        other.etaMinutesToNext == etaMinutesToNext &&
        other.order == order;
  }

  @override
  int get hashCode => Object.hash(
    id,
    name,
    region,
    description,
    normalizedX,
    normalizedY,
    giftsToDeliver,
    etaMinutesToNext,
    order,
  );

  @override
  String toString() {
    return 'SantaStop(order: $order, id: $id, name: $name, '
        'coords: ($normalizedX, $normalizedY), gifts: $giftsToDeliver)';
  }
}
