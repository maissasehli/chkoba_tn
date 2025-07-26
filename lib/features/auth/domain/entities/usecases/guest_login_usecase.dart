import 'package:chkoba_tn/features/auth/domain/entities/usecases/social_login_usecase.dart';

import '../repositories/auth_repository.dart';
import '../user.dart';

class GuestLoginUseCase {
  final AuthRepository _repository;

  GuestLoginUseCase(this._repository);

  Future<User> loginAsGuest() async {
    try {
      return await _repository.loginAsGuest();
    } catch (e) {
      throw AuthException('Erreur de connexion invité: ${e.toString()}');
    }
  }
}