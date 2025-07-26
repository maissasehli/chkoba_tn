import '../repositories/auth_repository.dart';
import '../user.dart';

class SocialLoginUseCase {
  final AuthRepository _repository;

  SocialLoginUseCase(this._repository);

  Future<User> loginWithFacebook() async {
    try {
      return await _repository.loginWithFacebook();
    } catch (e) {
      throw AuthException('Erreur de connexion Facebook: ${e.toString()}');
    }
  }

  Future<User> loginWithGoogle() async {
    try {
      return await _repository.loginWithGoogle();
    } catch (e) {
      throw AuthException('Erreur de connexion Google: ${e.toString()}');
    }
  }
}

class AuthException implements Exception {
  final String message;
  AuthException(this.message);
  
  @override
  String toString() => message;
}
