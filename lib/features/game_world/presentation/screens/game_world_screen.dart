import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/services/service_locator.dart';
import '../../../../core/constants/colors.dart';
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

class _GameWorldScreenState extends State<GameWorldScreen>
    with WidgetsBindingObserver {
  late final WorldBloc _worldBloc;
  bool _showControls = true;

  @override
  void initState() {
    super.initState();
    _worldBloc = getIt<WorldBloc>();
    _worldBloc.add(LoadWorldEvent(widget.worldId));
    WidgetsBinding.instance.addObserver(this);
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    _worldBloc.close();
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    // Pause the game loop when app is in background
    if (state == AppLifecycleState.paused) {
      _worldBloc.pauseGameLoop();
    } else if (state == AppLifecycleState.resumed) {
      _worldBloc.startGameLoop();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocProvider(
        create: (_) => _worldBloc,
        child: BlocBuilder<WorldBloc, WorldState>(
          builder: (context, state) {
            if (state is WorldLoadingState) {
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const CircularProgressIndicator(
                      color: AppColors.accentDark,
                    ),
                    const SizedBox(height: 20),
                    Text(
                      'Loading ${widget.worldId}...',
                      style: const TextStyle(color: Colors.white),
                    ),
                  ],
                ),
              );
            } else if (state is WorldLoadedState) {
              return Stack(
                children: [
                  // Game renderer
                  GameRenderer(world: state.world),

                  // Controls
                  if (_showControls)
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

                  // Game UI
                  Positioned(
                    top: 40,
                    left: 0,
                    right: 0,
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          IconButton(
                            icon: const Icon(
                              Icons.arrow_back,
                              color: Colors.white,
                            ),
                            onPressed: () => Navigator.pop(context),
                          ),
                          Text(
                            state.world.name,
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          IconButton(
                            icon: Icon(
                              _showControls
                                  ? Icons.gamepad
                                  : Icons.gamepad_outlined,
                              color: Colors.white,
                            ),
                            onPressed: () {
                              setState(() {
                                _showControls = !_showControls;
                              });
                            },
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              );
            } else if (state is WorldErrorState) {
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Icon(
                      Icons.error_outline,
                      color: Colors.red,
                      size: 48,
                    ),
                    const SizedBox(height: 16),
                    Text(
                      'Error: ${state.message}',
                      style: const TextStyle(color: Colors.white),
                    ),
                    const SizedBox(height: 24),
                    ElevatedButton(
                      onPressed: () {
                        _worldBloc.add(LoadWorldEvent(widget.worldId));
                      },
                      child: const Text('Try Again'),
                    ),
                  ],
                ),
              );
            } else {
              return const Center(
                child: Text(
                  'Unknown state',
                  style: TextStyle(color: Colors.white),
                ),
              );
            }
          },
        ),
      ),
    );
  }
}
