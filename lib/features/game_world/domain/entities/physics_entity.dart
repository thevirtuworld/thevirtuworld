import 'dart:ui';

class PhysicsEntity {
  final double mass;
  final bool hasCollision;
  final bool isStatic;
  final Offset velocity;
  final Offset acceleration;
  final double friction;
  final double restitution;

  PhysicsEntity({
    required this.mass,
    required this.hasCollision,
    required this.isStatic,
    required this.velocity,
    required this.acceleration,
    required this.friction,
    required this.restitution,
  });

  PhysicsEntity copyWith({
    double? mass,
    bool? hasCollision,
    bool? isStatic,
    Offset? velocity,
    Offset? acceleration,
    double? friction,
    double? restitution,
  }) {
    return PhysicsEntity(
      mass: mass ?? this.mass,
      hasCollision: hasCollision ?? this.hasCollision,
      isStatic: isStatic ?? this.isStatic,
      velocity: velocity ?? this.velocity,
      acceleration: acceleration ?? this.acceleration,
      friction: friction ?? this.friction,
      restitution: restitution ?? this.restitution,
    );
  }
}
