import '../../domain/entities/game_entity.dart';

class GameModel extends GameEntity {
  GameModel({
    required String id,
    required String name,
    required String description,
    required String thumbnailUrl,
    required String creatorId,
    required String creatorName,
    required double rating,
    required int playerCount,
    required bool isWeb3Enabled,
    required List<String> categories,
  }) : super(
         id: id,
         name: name,
         description: description,
         thumbnailUrl: thumbnailUrl,
         creatorId: creatorId,
         creatorName: creatorName,
         rating: rating,
         playerCount: playerCount,
         isWeb3Enabled: isWeb3Enabled,
         categories: categories,
       );

  factory GameModel.fromJson(Map<String, dynamic> json) {
    return GameModel(
      id: json['id'],
      name: json['name'],
      description: json['description'],
      thumbnailUrl: json['thumbnailUrl'],
      creatorId: json['creatorId'],
      creatorName: json['creatorName'],
      rating: json['rating'],
      playerCount: json['playerCount'],
      isWeb3Enabled: json['isWeb3Enabled'],
      categories: List<String>.from(json['categories']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'description': description,
      'thumbnailUrl': thumbnailUrl,
      'creatorId': creatorId,
      'creatorName': creatorName,
      'rating': rating,
      'playerCount': playerCount,
      'isWeb3Enabled': isWeb3Enabled,
      'categories': categories,
    };
  }

  // Helper to create mock games for testing
  static List<GameEntity> getMockGames() {
    return [
      GameModel(
        id: 'racing_1',
        name: 'Quantum Speed',
        description:
            'Futuristic racing game with physics-defying tracks and vehicles.',
        thumbnailUrl: 'assets/images/games/quantum_speed.jpg',
        creatorId: 'studio_1',
        creatorName: 'Velocity Studios',
        rating: 4.7,
        playerCount: 15420,
        isWeb3Enabled: true,
        categories: ['Racing', 'Multiplayer', 'Action'],
      ),
      GameModel(
        id: 'rpg_1',
        name: 'Eternal Legacy',
        description:
            'Epic RPG with vast open worlds and deep character progression.',
        thumbnailUrl: 'assets/images/games/eternal_legacy.jpg',
        creatorId: 'studio_2',
        creatorName: 'Epic World Games',
        rating: 4.9,
        playerCount: 89700,
        isWeb3Enabled: true,
        categories: ['RPG', 'Open World', 'Fantasy'],
      ),
      GameModel(
        id: 'strategy_1',
        name: 'Galactic Dominion',
        description: 'Build and manage your own interstellar empire.',
        thumbnailUrl: 'assets/images/games/galactic_dominion.jpg',
        creatorId: 'studio_3',
        creatorName: 'Nebula Interactive',
        rating: 4.5,
        playerCount: 42300,
        isWeb3Enabled: false,
        categories: ['Strategy', 'Simulation', 'Sci-Fi'],
      ),
      GameModel(
        id: 'puzzle_1',
        name: 'Mind Architect',
        description:
            'Brain-teasing puzzles that challenge your spatial reasoning.',
        thumbnailUrl: 'assets/images/games/mind_architect.jpg',
        creatorId: 'indie_1',
        creatorName: 'Puzzleverse',
        rating: 4.6,
        playerCount: 28500,
        isWeb3Enabled: false,
        categories: ['Puzzle', 'Educational', 'Single Player'],
      ),
      GameModel(
        id: 'sandbox_1',
        name: 'Genesis Creator',
        description:
            'Build anything you can imagine in this limitless sandbox.',
        thumbnailUrl: 'assets/images/games/genesis_creator.jpg',
        creatorId: 'studio_4',
        creatorName: 'Infinite Realms',
        rating: 4.8,
        playerCount: 67200,
        isWeb3Enabled: true,
        categories: ['Sandbox', 'Building', 'Creative'],
      ),
    ];
  }
}
