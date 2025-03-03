import '../entities/world_entity.dart';
import '../entities/game_entity.dart';

abstract class WorldRepository {
  Future<WorldEntity> loadWorld(String worldId);
  Future<void> saveWorld(WorldEntity world);
  Future<List<GameEntity>> getAvailableGames();
  Stream<WorldEntity> get worldUpdates;
}
