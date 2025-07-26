
import 'package:chkoba_tn/features/auth/data/models/user_model.dart';

abstract class AuthRemoteDataSource {
  Future<UserModel> loginWithFacebook();
  Future<UserModel> loginWithGoogle();
  Future<UserModel> loginAsGuest();
  Future<void> logout();
}

class AuthRemoteDataSourceImpl implements AuthRemoteDataSource {
  @override
  Future<UserModel> loginWithFacebook() async {
    // Simulation d'un appel API
    await Future.delayed(const Duration(seconds: 2));
    
    // Simulation d'une réponse réussie
    return const UserModel(
      id: 'fb_123456789',
      name: 'Ahmed Ben Ali',
      email: 'ahmed@facebook.com',
      avatarUrl: 'https://example.com/avatar.jpg',
      provider: 'facebook',
    );
  }

  @override
  Future<UserModel> loginWithGoogle() async {
    // Simulation d'un appel API
    await Future.delayed(const Duration(seconds: 2));
    
    // Simulation d'une réponse réussie
    return const UserModel(
      id: 'google_987654321',
      name: 'Fatma Trabelsi',
      email: 'fatma@gmail.com',
      avatarUrl: 'https://example.com/avatar2.jpg',
      provider: 'google',
    );
  }

  @override
  Future<UserModel> loginAsGuest() async {
    await Future.delayed(const Duration(milliseconds: 500));
    return UserModel.guest();
  }
   @override
  Future<void> logout() async {
    await Future.delayed(const Duration(milliseconds: 500));
  }
}

