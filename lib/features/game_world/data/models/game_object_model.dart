import 'dart:ui';
import '../../domain/entities/game_object_entity.dart';
import '../../domain/entities/physics_entity.dart';
import 'physics_model.dart';

class GameObjectModel extends GameObjectEntity {
  GameObjectModel({
    required String id,
    required GameObjectType type,
    required String name,
    required Offset position,
    required double rotation,
    required PhysicsEntity physics,
    required Map<String, dynamic> properties,
    required bool isInteractable,
  }) : super(
         id: id,
         type: type,
         name: name,
         position: position,
         rotation: rotation,
         physics: physics,
         properties: properties,
         isInteractable: isInteractable,
       );

  factory GameObjectModel.fromJson(Map<String, dynamic> json) {
    return GameObjectModel(
      id: json['id'],
      type: _parseGameObjectType(json['type']),
      name: json['name'],
      position: Offset(json['position']['x'], json['position']['y']),
      rotation: json['rotation'],
      physics: PhysicsModel.fromJson(json['physics']),
      properties: json['properties'],
      isInteractable: json['isInteractable'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'type': type.toString().split('.').last,
      'name': name,
      'position': {'x': position.dx, 'y': position.dy},
      'rotation': rotation,
      'physics': (physics as PhysicsModel).toJson(),
      'properties': properties,
      'isInteractable': isInteractable,
    };
  }

  static GameObjectType _parseGameObjectType(String type) {
    switch (type) {
      case 'building':
        return GameObjectType.building;
      case 'vehicle':
        return GameObjectType.vehicle;
      case 'nature':
        return GameObjectType.nature;
      case 'item':
        return GameObjectType.item;
      case 'npc':
        return GameObjectType.npc;
      default:
        return GameObjectType.item;
    }
  }
}
