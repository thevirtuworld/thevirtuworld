import 'dart:ui';
import 'dart:math';
import '../../domain/entities/physics_entity.dart';
import '../../domain/entities/game_object_entity.dart';

/// Result of a physics simulation step.
class SimulationResult {
  final Offset newPosition;
  final PhysicsEntity updatedPhysics;
  SimulationResult({required this.newPosition, required this.updatedPhysics});
}

class PhysicsController {
  // Simulates a physics step for an entity based on deltaTime (in seconds).
  SimulationResult simulatePhysics({
    required Offset position,
    required PhysicsEntity physics,
    required double deltaTime,
  }) {
    // Do not update if the entity is static.
    if (physics.isStatic) {
      return SimulationResult(newPosition: position, updatedPhysics: physics);
    }

    // Update velocity: v = v + a * dt
    final newVelocity = Offset(
      physics.velocity.dx + physics.acceleration.dx * deltaTime,
      physics.velocity.dy + physics.acceleration.dy * deltaTime,
    );

    // Apply friction as a simple damping factor.
    final frictionFactor = 1 - (physics.friction * deltaTime);
    final updatedVelocity = Offset(
      newVelocity.dx * frictionFactor,
      newVelocity.dy * frictionFactor,
    );

    // Update position: p = p + v * dt
    final newPosition = Offset(
      position.dx + updatedVelocity.dx * deltaTime,
      position.dy + updatedVelocity.dy * deltaTime,
    );

    // Create a new PhysicsEntity with the updated velocity.
    final updatedPhysics = physics.copyWith(velocity: updatedVelocity);

    return SimulationResult(
      newPosition: newPosition,
      updatedPhysics: updatedPhysics,
    );
  }

  // Check for collision between two circular objects
  bool checkCollision(
    Offset pos1,
    double radius1,
    Offset pos2,
    double radius2,
  ) {
    final distanceSquared =
        (pos1.dx - pos2.dx) * (pos1.dx - pos2.dx) +
        (pos1.dy - pos2.dy) * (pos1.dy - pos2.dy);
    final radiusSum = radius1 + radius2;
    return distanceSquared <= radiusSum * radiusSum;
  }

  // Resolve collision between two entities
  List<SimulationResult> resolveCollision(
    Offset pos1,
    PhysicsEntity physics1,
    double radius1,
    Offset pos2,
    PhysicsEntity physics2,
    double radius2,
  ) {
    // Calculate normal vector
    final dx = pos2.dx - pos1.dx;
    final dy = pos2.dy - pos1.dy;
    final distance = sqrt(dx * dx + dy * dy);

    if (distance == 0)
      return [
        SimulationResult(newPosition: pos1, updatedPhysics: physics1),
        SimulationResult(newPosition: newPos2, updatedPhysics: physics2),
      ];

    final nx = dx / distance;
    final ny = dy / distance;

    // Calculate overlap
    final overlap = (radius1 + radius2) - distance;

    // Move objects apart proportional to their masses
    final totalMass = physics1.mass + physics2.mass;
    final ratio1 = physics1.isStatic ? 0 : physics2.mass / totalMass;
    final ratio2 = physics2.isStatic ? 0 : physics1.mass / totalMass;

    final newPos1 = Offset(
      pos1.dx - nx * overlap * ratio1,
      pos1.dy - ny * overlap * ratio1,
    );

    final newPos2 = Offset(
      pos2.dx + nx * overlap * ratio2,
      pos2.dy + ny * overlap * ratio2,
    );

    // If either object is static, we don't need to calculate impulse
    if (physics1.isStatic || physics2.isStatic) {
      return [
        SimulationResult(newPosition: newPos1, updatedPhysics: physics1),
        SimulationResult(newPosition: newPos2, updatedPhysics: physics2),
      ];
    }

    // Calculate impulse for elastic collision
    final v1x = physics1.velocity.dx;
    final v1y = physics1.velocity.dy;
    final v2x = physics2.velocity.dx;
    final v2y = physics2.velocity.dy;

    // Calculate dot product of velocity and normal
    final vn1 = v1x * nx + v1y * ny;
    final vn2 = v2x * nx + v2y * ny;

    // Calculate impulse scalar
    final impulseScalar =
        (vn1 - vn2) * (1 + min(physics1.restitution, physics2.restitution));
    final impulseFactor = impulseScalar / totalMass;

    // Apply impulse
    final newVelocity1 = Offset(
      v1x - nx * impulseFactor * physics2.mass,
      v1y - ny * impulseFactor * physics2.mass,
    );

    final newVelocity2 = Offset(
      v2x + nx * impulseFactor * physics1.mass,
      v2y + ny * impulseFactor * physics1.mass,
    );

    return [
      SimulationResult(
        newPosition: newPos1,
        updatedPhysics: physics1.copyWith(velocity: newVelocity1),
      ),
      SimulationResult(
        newPosition: newPos2,
        updatedPhysics: physics2.copyWith(velocity: newVelocity2),
      ),
    ];
  }
}
