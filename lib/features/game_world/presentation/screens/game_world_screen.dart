import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/services/service_locator.dart';
import '../bloc/world_bloc.dart';
import '../widgets/game_renderer.dart';
import '../widgets/joystick_control.dart';

class GameWorldScreen extends StatefulWidget {
  final String worldId;

  const GameWorldScreen({Key? key, this.worldId = 'default_world'})
    : super(key: key);

  @override
  State<GameWorldScreen> createState() => _GameWorldScreenState();
}

class _GameWorldScreenState extends State<GameWorldScreen> {
  late final WorldBloc _worldBloc;

  @override
  void initState() {
    super.initState();
    _worldBloc = getIt<WorldBloc>();
    _worldBloc.add(LoadWorldEvent(widget.worldId));
  }

  @override
  void dispose() {
    _worldBloc.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocProvider(
        create: (_) => _worldBloc,
        child: BlocBuilder<WorldBloc, WorldState>(
          builder: (context, state) {
            if (state is WorldLoadingState) {
              return const Center(child: CircularProgressIndicator());
            } else if (state is WorldLoadedState) {
              return Stack(
                children: [
                  // Game renderer
                  GameRenderer(world: state.world),

                  // Controls
                  Positioned(
                    left: 20,
                    bottom: 20,
                    child: JoystickControl(
                      onDirectionChanged: (direction) {
                        context.read<WorldBloc>().add(
                          PlayerMovementEvent(direction),
                        );
                      },
                    ),
                  ),

                  // Back button
                  Positioned(
                    top: 40,
                    left: 20,
                    child: IconButton(
                      icon: const Icon(Icons.arrow_back, color: Colors.white),
                      onPressed: () => Navigator.pop(context),
                    ),
                  ),
                ],
              );
            } else if (state is WorldErrorState) {
              return Center(child: Text('Error: ${state.message}'));
            } else {
              return const Center(child: Text('Unknown state'));
            }
          },
        ),
      ),
    );
  }
}
