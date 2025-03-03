import '../repositories/world_repository.dart';
import '../entities/world_entity.dart';
import '../entities/game_entity.dart';

class LoadWorldUseCase {
  final WorldRepository repository;

  LoadWorldUseCase(this.repository);

  Future<WorldEntity> call(String worldId) {
    return repository.loadWorld(worldId);
  }
}

class UpdateWorldUseCase {
  final WorldRepository repository;

  UpdateWorldUseCase(this.repository);

  Future<void> call(WorldEntity world) {
    return repository.saveWorld(world);
  }
}

class GetAvailableGamesUseCase {
  final WorldRepository repository;

  GetAvailableGamesUseCase(this.repository);

  Future<List<GameEntity>> call() {
    return repository.getAvailableGames();
  }
}
