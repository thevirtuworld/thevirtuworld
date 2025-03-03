enum TerrainType { grass, water, mountain, desert, snow, forest, urban }

class TerrainEntity {
  final TerrainType type;
  final double elevation;
  final Map<String, dynamic> properties;

  TerrainEntity({
    required this.type,
    required this.elevation,
    required this.properties,
  });
}
