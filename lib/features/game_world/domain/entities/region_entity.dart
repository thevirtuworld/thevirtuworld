import 'dart:ui';
import 'terrain_entity.dart';

class RegionEntity {
  final String id;
  final String name;
  final Rect bounds;
  final TerrainEntity terrain;
  final String climate;
  final Map<String, dynamic> properties;

  RegionEntity({
    required this.id,
    required this.name,
    required this.bounds,
    required this.terrain,
    required this.climate,
    required this.properties,
  });
}
