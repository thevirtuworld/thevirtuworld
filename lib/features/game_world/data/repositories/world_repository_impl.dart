import 'dart:async';
import '../../domain/repositories/world_repository.dart';
import '../../domain/entities/world_entity.dart';
import '../../domain/entities/game_entity.dart';
import '../models/world_model.dart';
import '../models/game_model.dart';
import '../datasources/world_local_datasource.dart';

class WorldRepositoryImpl implements WorldRepository {
  final _worldController = StreamController<WorldEntity>.broadcast();

  WorldEntity? _currentWorld;

  @override
  Stream<WorldEntity> get worldUpdates => _worldController.stream;

  @override
  Future<WorldEntity> loadWorld(String worldId) async {
    // For now, we'll create a mock world
    // In a real implementation, this would load from storage or a server
    _currentWorld = WorldModel.createDefaultWorld();
    _worldController.add(_currentWorld!);
    return _currentWorld!;
  }

  @override
  Future<void> saveWorld(WorldEntity world) async {
    // Here we would persist the world to storage
    _currentWorld = world;
    _worldController.add(_currentWorld!);
  }

  @override
  Future<List<GameEntity>> getAvailableGames() async {
    // In a real app, this would fetch from an API or local database
    return GameModel.getMockGames();
  }

  void dispose() {
    _worldController.close();
  }
}
