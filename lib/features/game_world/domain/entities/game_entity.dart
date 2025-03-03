class GameEntity {
  final String id;
  final String name;
  final String description;
  final String thumbnailUrl;
  final String creatorId;
  final String creatorName;
  final double rating;
  final int playerCount;
  final bool isWeb3Enabled;
  final List<String> categories;

  GameEntity({
    required this.id,
    required this.name,
    required this.description,
    required this.thumbnailUrl,
    required this.creatorId,
    required this.creatorName,
    required this.rating,
    required this.playerCount,
    required this.isWeb3Enabled,
    required this.categories,
  });
}
