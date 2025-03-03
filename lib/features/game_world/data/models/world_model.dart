import 'dart:math';
import 'dart:ui';
import '../../domain/entities/world_entity.dart';
import 'region_model.dart';
import 'player_model.dart';
import 'game_object_model.dart';
import 'physics_model.dart';
import 'terrain_model.dart';

class WorldModel extends WorldEntity {
  WorldModel({
    required String id,
    required String name,
    required List<RegionEntity> regions,
    required List<PlayerEntity> players,
    required List<GameObjectEntity> gameObjects,
    required Map<String, dynamic> environmentSettings,
    required DateTime lastUpdated,
  }) : super(
         id: id,
         name: name,
         regions: regions,
         players: players,
         gameObjects: gameObjects,
         environmentSettings: environmentSettings,
         lastUpdated: lastUpdated,
       );

  factory WorldModel.fromJson(Map<String, dynamic> json) {
    return WorldModel(
      id: json['id'],
      name: json['name'],
      regions:
          (json['regions'] as List)
              .map((region) => RegionModel.fromJson(region))
              .toList(),
      players:
          (json['players'] as List)
              .map((player) => PlayerModel.fromJson(player))
              .toList(),
      gameObjects:
          (json['gameObjects'] as List)
              .map((object) => GameObjectModel.fromJson(object))
              .toList(),
      environmentSettings: json['environmentSettings'],
      lastUpdated: DateTime.parse(json['lastUpdated']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'regions':
          regions.map((region) => (region as RegionModel).toJson()).toList(),
      'players':
          players.map((player) => (player as PlayerModel).toJson()).toList(),
      'gameObjects':
          gameObjects
              .map((object) => (object as GameObjectModel).toJson())
              .toList(),
      'environmentSettings': environmentSettings,
      'lastUpdated': lastUpdated.toIso8601String(),
    };
  }

  static WorldModel createDefaultWorld() {
    final random = Random();

    // Create default terrain
    final defaultTerrain = TerrainModel(
      type: TerrainType.grass,
      elevation: 0.0,
      properties: {'friction': 0.1},
    );

    // Create a simple region
    final region = RegionModel(
      id: 'region_1',
      name: 'Starting Area',
      bounds: const Rect.fromLTWH(0, 0, 1000, 1000),
      terrain: defaultTerrain,
      climate: 'temperate',
      properties: {},
    );

    // Create player
    final player = PlayerModel(
      id: 'player_1',
      userId: 'user_1',
      displayName: 'Player',
      position: const Offset(500, 500),
      direction: 0.0,
      physics: PhysicsModel(
        mass: 70.0,
        hasCollision: true,
        isStatic: false,
        velocity: Offset.zero,
        acceleration: Offset.zero,
        friction: 0.1,
        restitution: 0.5,
      ),
      attributes: {'health': 100, 'stamina': 100},
      inventory: {},
    );

    // Create some random objects
    final gameObjects = <GameObjectModel>[];
    for (int i = 0; i < 20; i++) {
      gameObjects.add(
        GameObjectModel(
          id: 'object_$i',
          type:
              i % 5 == 0
                  ? GameObjectType.building
                  : i % 4 == 0
                  ? GameObjectType.vehicle
                  : i % 3 == 0
                  ? GameObjectType.nature
                  : i % 2 == 0
                  ? GameObjectType.item
                  : GameObjectType.npc,
          name: 'Object $i',
          position: Offset(
            random.nextDouble() * 900 + 50,
            random.nextDouble() * 900 + 50,
          ),
          rotation: random.nextDouble() * pi * 2,
          physics: PhysicsModel(
            mass: 10.0 + random.nextDouble() * 90,
            hasCollision: true,
            isStatic: i % 3 != 0,
            velocity: Offset.zero,
            acceleration: Offset.zero,
            friction: 0.1 + random.nextDouble() * 0.3,
            restitution: 0.2 + random.nextDouble() * 0.6,
          ),
          properties: {},
          isInteractable: i % 2 == 0,
        ),
      );
    }

    return WorldModel(
      id: 'default_world',
      name: 'Default World',
      regions: [region],
      players: [player],
      gameObjects: gameObjects,
      environmentSettings: {'dayNightCycle': true, 'weatherEnabled': true},
      lastUpdated: DateTime.now(),
    );
  }
}
