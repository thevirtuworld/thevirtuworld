import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:flutter/foundation.dart';
import 'package:equatable/equatable.dart';
import '../../domain/entities/world_entity.dart';
import '../../domain/entities/player_entity.dart';
import '../../domain/entities/game_object_entity.dart';
import '../../domain/usecases/world_usecases.dart';
import '../../../../core/services/service_locator.dart';
import '../controllers/physics_controller.dart';
import 'dart:ui';

// Events
abstract class WorldEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class LoadWorldEvent extends WorldEvent {
  final String worldId;
  LoadWorldEvent(this.worldId);

  @override
  List<Object?> get props => [worldId];
}

class UpdateWorldEvent extends WorldEvent {
  final WorldEntity world;
  UpdateWorldEvent(this.world);

  @override
  List<Object?> get props => [world];
}

class PlayerMovementEvent extends WorldEvent {
  final Offset direction;
  PlayerMovementEvent(this.direction);

  @override
  List<Object?> get props => [direction];
}

class GameTickEvent extends WorldEvent {
  final double deltaTime;
  GameTickEvent(this.deltaTime);

  @override
  List<Object?> get props => [deltaTime];
}

// States
abstract class WorldState extends Equatable {
  @override
  List<Object?> get props => [];
}

class WorldInitialState extends WorldState {}

class WorldLoadingState extends WorldState {}

class WorldLoadedState extends WorldState {
  final WorldEntity world;
  WorldLoadedState(this.world);

  @override
  List<Object?> get props => [world];
}

class WorldErrorState extends WorldState {
  final String message;
  WorldErrorState(this.message);

  @override
  List<Object?> get props => [message];
}

// BLoC
class WorldBloc extends Bloc<WorldEvent, WorldState> {
  final LoadWorldUseCase loadWorld;
  final UpdateWorldUseCase updateWorld;
  final PhysicsController _physicsController = getIt<PhysicsController>();
  Timer? _gameLoopTimer;

  WorldBloc({required this.loadWorld, required this.updateWorld})
    : super(WorldInitialState()) {
    on<LoadWorldEvent>(_onLoadWorld);
    on<UpdateWorldEvent>(_onUpdateWorld);
    on<PlayerMovementEvent>(_onPlayerMovement);
    on<GameTickEvent>(_onGameTick);
  }

  void startGameLoop() {
    _gameLoopTimer?.cancel();
    _gameLoopTimer = Timer.periodic(const Duration(milliseconds: 16), (timer) {
      add(GameTickEvent(1 / 60)); // 60 fps fixed time step
    });
  }

  @override
  Future<void> close() {
    _gameLoopTimer?.cancel();
    return super.close();
  }

  Future<void> _onLoadWorld(
    LoadWorldEvent event,
    Emitter<WorldState> emit,
  ) async {
    emit(WorldLoadingState());
    try {
      final world = await loadWorld(event.worldId);
      emit(WorldLoadedState(world));
      startGameLoop();
    } catch (e) {
      emit(WorldErrorState('Failed to load world: $e'));
    }
  }

  Future<void> _onUpdateWorld(
    UpdateWorldEvent event,
    Emitter<WorldState> emit,
  ) async {
    try {
      await updateWorld(event.world);
      emit(WorldLoadedState(event.world));
    } catch (e) {
      emit(WorldErrorState('Failed to update world: $e'));
    }
  }

  void _onPlayerMovement(PlayerMovementEvent event, Emitter<WorldState> emit) {
    if (state is WorldLoadedState) {
      final currentState = state as WorldLoadedState;
      final world = currentState.world;

      if (world.players.isNotEmpty) {
        final player = world.players.first;
        final updatedPlayer = player.copyWith(
          physics: player.physics.copyWith(
            acceleration: event.direction.scale(
              100,
              100,
            ), // Scale to reasonable acceleration
          ),
        );

        final updatedPlayers = List<PlayerEntity>.from(world.players);
        updatedPlayers[0] = updatedPlayer;

        final updatedWorld = world.copyWith(players: updatedPlayers);
        add(UpdateWorldEvent(updatedWorld));
      }
    }
  }

  void _onGameTick(GameTickEvent event, Emitter<WorldState> emit) {
    if (state is WorldLoadedState) {
      final currentState = state as WorldLoadedState;
      final world = currentState.world;

      // Update player positions
      final updatedPlayers =
          world.players.map((player) {
            final result = _physicsController.simulatePhysics(
              position: player.position,
              physics: player.physics,
              deltaTime: event.deltaTime,
            );
            return player.copyWith(
              position: result.newPosition,
              physics: result.updatedPhysics,
            );
          }).toList();

      // Update game object positions
      final updatedObjects =
          world.gameObjects.map((object) {
            final result = _physicsController.simulatePhysics(
              position: object.position,
              physics: object.physics,
              deltaTime: event.deltaTime,
            );
            return object.copyWith(
              position: result.newPosition,
              physics: result.updatedPhysics,
            );
          }).toList();

      // Simple collision detection for player and objects
      for (int i = 0; i < updatedPlayers.length; i++) {
        final player = updatedPlayers[i];

        for (int j = 0; j < updatedObjects.length; j++) {
          final object = updatedObjects[j];

          if (object.physics.hasCollision && player.physics.hasCollision) {
            const playerRadius = 20.0; // Approximation
            const objectRadius = 15.0; // Approximation

            if (_physicsController.checkCollision(
              player.position,
              playerRadius,
              object.position,
              objectRadius,
            )) {
              final results = _physicsController.resolveCollision(
                player.position,
                player.physics,
                playerRadius,
                object.position,
                object.physics,
                objectRadius,
              );

              updatedPlayers[i] = player.copyWith(
                position: results[0].newPosition,
                physics: results[0].updatedPhysics,
              );

              updatedObjects[j] = object.copyWith(
                position: results[1].newPosition,
                physics: results[1].updatedPhysics,
              );
            }
          }
        }
      }

      final updatedWorld = world.copyWith(
        players: updatedPlayers,
        gameObjects: updatedObjects,
        lastUpdated: DateTime.now(),
      );

      emit(WorldLoadedState(updatedWorld));
    }
  }
}
