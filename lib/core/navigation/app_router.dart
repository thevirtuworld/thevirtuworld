import 'package:auto_route/auto_route.dart';
import '../../features/splash/presentation/screens/splash_screen.dart';
import '../../features/auth/presentation/screens/login_screen.dart';
import '../../features/auth/presentation/screens/register_screen.dart';
import '../../features/home/presentation/screens/home_screen.dart';
import '../../features/game_world/presentation/screens/game_world_screen.dart';
import '../../features/profile/presentation/screens/profile_screen.dart';
import '../../features/settings/presentation/screens/settings_screen.dart';

@MaterialAutoRouter(
  replaceInRouteName: 'Screen,Route',
  routes: <AutoRoute>[
    AutoRoute(page: SplashScreen, initial: true),
    AutoRoute(page: LoginScreen),
    AutoRoute(page: RegisterScreen),
    AutoRoute(page: HomeScreen),
    AutoRoute(page: GameWorldScreen),
    AutoRoute(page: ProfileScreen),
    AutoRoute(page: SettingsScreen),
  ],
)
class $AppRouter {}
