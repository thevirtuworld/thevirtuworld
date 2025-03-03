import 'package:flutter/material.dart';
import '../../domain/entities/world_entity.dart';
import '../../domain/entities/game_object_entity.dart';

class GameRenderer extends StatelessWidget {
  final WorldEntity world;

  const GameRenderer({Key? key, required this.world}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.black,
      child: CustomPaint(painter: GamePainter(world), child: Container()),
    );
  }
}

class GamePainter extends CustomPainter {
  final WorldEntity world;

  GamePainter(this.world);

  @override
  void paint(Canvas canvas, Size size) {
    // Draw background
    canvas.drawRect(
      Rect.fromLTWH(0, 0, size.width, size.height),
      Paint()..color = const Color(0xFF1A2E35),
    );

    // Calculate view scale
    final scale = 0.5;

    // Center on the player
    final playerPos =
        world.players.isNotEmpty
            ? world.players.first.position
            : const Offset(0, 0);
    final screenCenter = Offset(size.width / 2, size.height / 2);

    // Apply transformation to center on player
    canvas.translate(
      screenCenter.dx - playerPos.dx * scale,
      screenCenter.dy - playerPos.dy * scale,
    );

    canvas.scale(scale, scale);

    // Draw game objects
    for (final object in world.gameObjects) {
      final paint =
          Paint()
            ..color = _getObjectColor(object.type)
            ..style = PaintingStyle.fill;

      // Draw a simple circle representing the object
      canvas.drawCircle(object.position, 15.0, paint);

      // Draw outline for interactable objects
      if (object.isInteractable) {
        canvas.drawCircle(
          object.position,
          17.0,
          Paint()
            ..color = Colors.yellow
            ..style = PaintingStyle.stroke
            ..strokeWidth = 2.0,
        );
      }
    }

    // Draw players
    for (final player in world.players) {
      // Player circle
      canvas.drawCircle(player.position, 20.0, Paint()..color = Colors.blue);

      // Direction indicator
      final directionOffset = Offset(
        player.position.dx + 20.0 * Math.cos(player.direction),
        player.position.dy + 20.0 * Math.sin(player.direction),
      );

      canvas.drawLine(
        player.position,
        directionOffset,
        Paint()
          ..color = Colors.white
          ..strokeWidth = 3.0,
      );

      // Draw player name
      final textSpan = TextSpan(
        text: player.displayName,
        style: const TextStyle(color: Colors.white, fontSize: 16.0),
      );

      final textPainter = TextPainter(
        text: textSpan,
        textDirection: TextDirection.ltr,
      );

      textPainter.layout();
      textPainter.paint(
        canvas,
        player.position.translate(-textPainter.width / 2, -40.0),
      );
    }
  }

  Color _getObjectColor(GameObjectType type) {
    switch (type) {
      case GameObjectType.building:
        return Colors.brown;
      case GameObjectType.vehicle:
        return Colors.red;
      case GameObjectType.nature:
        return Colors.green;
      case GameObjectType.item:
        return Colors.purple;
      case GameObjectType.npc:
        return Colors.orange;
    }
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => true;
}

class Math {
  static double cos(double angle) {
    return math.cos(angle);
  }

  static double sin(double angle) {
    return math.sin(angle);
  }
}
