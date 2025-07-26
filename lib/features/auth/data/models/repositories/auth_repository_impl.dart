
import '../../../domain/entities/repositories/auth_repository.dart';
import '../../../domain/entities/user.dart';
import '../datasources/auth_local_datasource.dart';
import '../datasources/auth_remote_datasource.dart';

class AuthRepositoryImpl implements AuthRepository {
  final AuthRemoteDataSource _remoteDataSource;
  final AuthLocalDataSource _localDataSource;

  AuthRepositoryImpl({
    required AuthRemoteDataSource remoteDataSource,
    required AuthLocalDataSource localDataSource,
  })  : _remoteDataSource = remoteDataSource,
        _localDataSource = localDataSource;

  @override
  Future<User> loginWithFacebook() async {
    final user = await _remoteDataSource.loginWithFacebook();
    await _localDataSource.cacheUser(user);
    return user;
  }

  @override
  Future<User> loginWithGoogle() async {
    final user = await _remoteDataSource.loginWithGoogle();
    await _localDataSource.cacheUser(user);
    return user;
  }

  @override
  Future<User> loginAsGuest() async {
    final user = await _remoteDataSource.loginAsGuest();
    await _localDataSource.cacheUser(user);
    return user;
  }

  @override
  Future<void> logout() async {
    await _remoteDataSource.logout();
    await _localDataSource.clearCache();
  }

  @override
  Future<User?> getCurrentUser() async {
    return await _localDataSource.getCachedUser();
  }
}