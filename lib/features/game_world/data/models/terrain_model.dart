import '../../domain/entities/terrain_entity.dart';

class TerrainModel extends TerrainEntity {
  TerrainModel({
    required TerrainType type,
    required double elevation,
    required Map<String, dynamic> properties,
  }) : super(type: type, elevation: elevation, properties: properties);

  factory TerrainModel.fromJson(Map<String, dynamic> json) {
    return TerrainModel(
      type: _parseTerrainType(json['type']),
      elevation: json['elevation'],
      properties: json['properties'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'type': type.toString().split('.').last,
      'elevation': elevation,
      'properties': properties,
    };
  }

  static TerrainType _parseTerrainType(String type) {
    switch (type) {
      case 'grass':
        return TerrainType.grass;
      case 'water':
        return TerrainType.water;
      case 'mountain':
        return TerrainType.mountain;
      case 'desert':
        return TerrainType.desert;
      case 'snow':
        return TerrainType.snow;
      case 'forest':
        return TerrainType.forest;
      case 'urban':
        return TerrainType.urban;
      default:
        return TerrainType.grass;
    }
  }
}
