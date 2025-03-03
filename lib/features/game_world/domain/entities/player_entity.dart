import 'dart:ui';
import 'physics_entity.dart';

class PlayerEntity {
  final String id;
  final String userId;
  final String displayName;
  final Offset position;
  final double direction;
  final PhysicsEntity physics;
  final Map<String, dynamic> attributes;
  final Map<String, dynamic> inventory;

  PlayerEntity({
    required this.id,
    required this.userId,
    required this.displayName,
    required this.position,
    required this.direction,
    required this.physics,
    required this.attributes,
    required this.inventory,
  });

  PlayerEntity copyWith({
    String? id,
    String? userId,
    String? displayName,
    Offset? position,
    double? direction,
    PhysicsEntity? physics,
    Map<String, dynamic>? attributes,
    Map<String, dynamic>? inventory,
  }) {
    return PlayerEntity(
      id: id ?? this.id,
      userId: userId ?? this.userId,
      displayName: displayName ?? this.displayName,
      position: position ?? this.position,
      direction: direction ?? this.direction,
      physics: physics ?? this.physics,
      attributes: attributes ?? this.attributes,
      inventory: inventory ?? this.inventory,
    );
  }
}
