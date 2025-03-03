import 'dart:ui';
import '../../domain/entities/player_entity.dart';
import '../../domain/entities/physics_entity.dart';
import 'physics_model.dart';

class PlayerModel extends PlayerEntity {
  PlayerModel({
    required String id,
    required String userId,
    required String displayName,
    required Offset position,
    required double direction,
    required PhysicsEntity physics,
    required Map<String, dynamic> attributes,
    required Map<String, dynamic> inventory,
  }) : super(
         id: id,
         userId: userId,
         displayName: displayName,
         position: position,
         direction: direction,
         physics: physics,
         attributes: attributes,
         inventory: inventory,
       );

  factory PlayerModel.fromJson(Map<String, dynamic> json) {
    return PlayerModel(
      id: json['id'],
      userId: json['userId'],
      displayName: json['displayName'],
      position: Offset(json['position']['x'], json['position']['y']),
      direction: json['direction'],
      physics: PhysicsModel.fromJson(json['physics']),
      attributes: json['attributes'],
      inventory: json['inventory'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'userId': userId,
      'displayName': displayName,
      'position': {'x': position.dx, 'y': position.dy},
      'direction': direction,
      'physics': (physics as PhysicsModel).toJson(),
      'attributes': attributes,
      'inventory': inventory,
    };
  }
}
