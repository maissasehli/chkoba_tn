
import '../user.dart';

abstract class AuthRepository {
  Future<User> loginWithFacebook();
  Future<User> loginWithGoogle();
  Future<User> loginAsGuest();
  Future<void> logout();
  Future<User?> getCurrentUser();
}
