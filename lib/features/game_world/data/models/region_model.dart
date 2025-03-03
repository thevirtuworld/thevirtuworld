import 'dart:ui';
import '../../domain/entities/region_entity.dart';
import '../../domain/entities/terrain_entity.dart';
import 'terrain_model.dart';

class RegionModel extends RegionEntity {
  RegionModel({
    required String id,
    required String name,
    required Rect bounds,
    required TerrainEntity terrain,
    required String climate,
    required Map<String, dynamic> properties,
  }) : super(
         id: id,
         name: name,
         bounds: bounds,
         terrain: terrain,
         climate: climate,
         properties: properties,
       );

  factory RegionModel.fromJson(Map<String, dynamic> json) {
    return RegionModel(
      id: json['id'],
      name: json['name'],
      bounds: Rect.fromLTWH(
        json['bounds']['left'],
        json['bounds']['top'],
        json['bounds']['width'],
        json['bounds']['height'],
      ),
      terrain: TerrainModel.fromJson(json['terrain']),
      climate: json['climate'],
      properties: json['properties'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'bounds': {
        'left': bounds.left,
        'top': bounds.top,
        'width': bounds.width,
        'height': bounds.height,
      },
      'terrain': (terrain as TerrainModel).toJson(),
      'climate': climate,
      'properties': properties,
    };
  }
}
