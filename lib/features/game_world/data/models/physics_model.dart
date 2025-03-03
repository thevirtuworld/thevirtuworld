import 'dart:ui';
import '../../domain/entities/physics_entity.dart';

class PhysicsModel extends PhysicsEntity {
  PhysicsModel({
    required double mass,
    required bool hasCollision,
    required bool isStatic,
    required Offset velocity,
    required Offset acceleration,
    required double friction,
    required double restitution,
  }) : super(
         mass: mass,
         hasCollision: hasCollision,
         isStatic: isStatic,
         velocity: velocity,
         acceleration: acceleration,
         friction: friction,
         restitution: restitution,
       );

  factory PhysicsModel.fromJson(Map<String, dynamic> json) {
    return PhysicsModel(
      mass: json['mass'],
      hasCollision: json['hasCollision'],
      isStatic: json['isStatic'],
      velocity: Offset(json['velocity']['x'], json['velocity']['y']),
      acceleration: Offset(
        json['acceleration']['x'],
        json['acceleration']['y'],
      ),
      friction: json['friction'],
      restitution: json['restitution'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'mass': mass,
      'hasCollision': hasCollision,
      'isStatic': isStatic,
      'velocity': {'x': velocity.dx, 'y': velocity.dy},
      'acceleration': {'x': acceleration.dx, 'y': acceleration.dy},
      'friction': friction,
      'restitution': restitution,
    };
  }
}
