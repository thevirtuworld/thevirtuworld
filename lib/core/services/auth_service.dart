import 'dart:async';
import '../models/user.dart';
import 'service_locator.dart';
import 'storage_service.dart';

class AuthService {
  final _authStateController = StreamController<User?>.broadcast();
  Stream<User?> get authStateChanges => _authStateController.stream;

  User? _currentUser;
  User? get currentUser => _currentUser;

  AuthService() {
    // Check for existing user in storage
    _loadUserFromStorage();
  }

  Future<void> _loadUserFromStorage() async {
    final userJson = getIt<StorageService>().getObject('user');
    if (userJson != null) {
      _currentUser = User.fromJson(userJson);
      _authStateController.add(_currentUser);
    } else {
      _authStateController.add(null);
    }
  }

  Future<bool> login(String email, String password) async {
    // Simulate network call
    await Future.delayed(const Duration(seconds: 1));

    // This is a placeholder. In a real app, you'd verify with a backend
    if (email == 'test@example.com' && password == 'password') {
      _currentUser = User(id: '1', email: email, displayName: 'Test User');

      // Save to storage
      await getIt<StorageService>().setObject('user', _currentUser!.toJson());
      _authStateController.add(_currentUser);
      return true;
    }

    return false;
  }

  Future<void> logout() async {
    await getIt<StorageService>().remove('user');
    _currentUser = null;
    _authStateController.add(null);
  }

  Future<bool> isLoggedIn() async {
    return _currentUser != null;
  }

  void dispose() {
    _authStateController.close();
  }
}
