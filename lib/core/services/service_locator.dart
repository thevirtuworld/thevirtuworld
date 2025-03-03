import 'package:get_it/get_it.dart';
import '../navigation/app_router.dart';
import './storage_service.dart';
import './auth_service.dart';
import '../../features/game_world/domain/repositories/world_repository.dart';
import '../../features/game_world/domain/usecases/world_usecases.dart';
import '../../features/game_world/data/repositories/world_repository_impl.dart';
import '../../features/game_world/presentation/bloc/world_bloc.dart';
import '../../features/game_world/presentation/controllers/physics_controller.dart';

final GetIt getIt = GetIt.instance;

Future<void> setupServiceLocator() async {
  // External services
  getIt.registerSingleton<AppRouter>(AppRouter());

  // Core services
  final storageService = StorageService();
  await storageService.init();
  getIt.registerSingleton<StorageService>(storageService);
  getIt.registerSingleton<AuthService>(AuthService());

  // Repositories
  getIt.registerLazySingleton<WorldRepository>(() => WorldRepositoryImpl());

  // Use cases
  getIt.registerLazySingleton<LoadWorldUseCase>(
    () => LoadWorldUseCase(getIt<WorldRepository>()),
  );
  getIt.registerLazySingleton<UpdateWorldUseCase>(
    () => UpdateWorldUseCase(getIt<WorldRepository>()),
  );

  // Controllers
  getIt.registerLazySingleton<PhysicsController>(() => PhysicsController());

  // BLoCs
  getIt.registerFactory<WorldBloc>(
    () => WorldBloc(
      loadWorld: getIt<LoadWorldUseCase>(),
      updateWorld: getIt<UpdateWorldUseCase>(),
    ),
  );
}
