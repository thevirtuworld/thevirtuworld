import 'region_entity.dart';
import 'player_entity.dart';
import 'game_object_entity.dart';

class WorldEntity {
  final String id;
  final String name;
  final List<RegionEntity> regions;
  final List<PlayerEntity> players;
  final List<GameObjectEntity> gameObjects;
  final Map<String, dynamic> environmentSettings;
  final DateTime lastUpdated;

  WorldEntity({
    required this.id,
    required this.name,
    required this.regions,
    required this.players,
    required this.gameObjects,
    required this.environmentSettings,
    required this.lastUpdated,
  });

  WorldEntity copyWith({
    String? id,
    String? name,
    List<RegionEntity>? regions,
    List<PlayerEntity>? players,
    List<GameObjectEntity>? gameObjects,
    Map<String, dynamic>? environmentSettings,
    DateTime? lastUpdated,
  }) {
    return WorldEntity(
      id: id ?? this.id,
      name: name ?? this.name,
      regions: regions ?? this.regions,
      players: players ?? this.players,
      gameObjects: gameObjects ?? this.gameObjects,
      environmentSettings: environmentSettings ?? this.environmentSettings,
      lastUpdated: lastUpdated ?? this.lastUpdated,
    );
  }
}
