import 'dart:convert';
import '../../../../core/services/storage_service.dart';
import '../../../../core/services/service_locator.dart';
import '../models/world_model.dart';

class WorldLocalDataSource {
  final StorageService _storageService = getIt<StorageService>();

  Future<WorldModel?> getWorld(String worldId) async {
    final worldJson = _storageService.getObject('world_$worldId');
    if (worldJson != null) {
      return WorldModel.fromJson(worldJson);
    }
    return null;
  }

  Future<void> saveWorld(WorldModel world) async {
    await _storageService.setObject('world_${world.id}', world.toJson());
  }

  Future<List<String>> getSavedWorldIds() async {
    final idsJson = _storageService.getString('saved_world_ids');
    if (idsJson != null) {
      return List<String>.from(jsonDecode(idsJson));
    }
    return [];
  }

  Future<void> addWorldId(String worldId) async {
    final ids = await getSavedWorldIds();
    if (!ids.contains(worldId)) {
      ids.add(worldId);
      await _storageService.setString('saved_world_ids', jsonEncode(ids));
    }
  }
}
