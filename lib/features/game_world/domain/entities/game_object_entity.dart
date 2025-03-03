import 'dart:ui';
import 'physics_entity.dart';

enum GameObjectType { building, vehicle, nature, item, npc }

class GameObjectEntity {
  final String id;
  final GameObjectType type;
  final String name;
  final Offset position;
  final double rotation;
  final PhysicsEntity physics;
  final Map<String, dynamic> properties;
  final bool isInteractable;

  GameObjectEntity({
    required this.id,
    required this.type,
    required this.name,
    required this.position,
    required this.rotation,
    required this.physics,
    required this.properties,
    required this.isInteractable,
  });

  GameObjectEntity copyWith({
    String? id,
    GameObjectType? type,
    String? name,
    Offset? position,
    double? rotation,
    PhysicsEntity? physics,
    Map<String, dynamic>? properties,
    bool? isInteractable,
  }) {
    return GameObjectEntity(
      id: id ?? this.id,
      type: type ?? this.type,
      name: name ?? this.name,
      position: position ?? this.position,
      rotation: rotation ?? this.rotation,
      physics: physics ?? this.physics,
      properties: properties ?? this.properties,
      isInteractable: isInteractable ?? this.isInteractable,
    );
  }
}
