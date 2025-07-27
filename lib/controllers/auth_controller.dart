import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import '../models/user_model.dart';
import '../services/auth_service.dart';

class AuthController extends GetxController {
  final AuthService _authService = AuthService();
  
  // Observables
  final Rx<UserModel?> currentUser = Rx<UserModel?>(null);
  final RxBool isLoading = false.obs;
  final RxBool isAuthenticated = false.obs;
  final RxString errorMessage = ''.obs;
  final RxString loadingProvider = ''.obs;

  @override
  void onInit() {
    super.onInit();
    _initAuthListener();
    _checkAuthState();
  }

  void _initAuthListener() {
    _authService.authStateChange.listen((AuthState data) {
      final event = data.event;
      final session = data.session;
      
      if (event == AuthChangeEvent.signedIn && session != null) {
        _updateUserFromSession(session);
        isAuthenticated.value = true;
        Get.offAllNamed('/home');
      } else if (event == AuthChangeEvent.signedOut) {
        currentUser.value = null;
        isAuthenticated.value = false;
        Get.offAllNamed('/login');
      }
    });
  }

  void _checkAuthState() {
    final session = _authService.currentSession;
    if (session != null) {
      _updateUserFromSession(session);
      isAuthenticated.value = true;
    }
  }

  void _updateUserFromSession(Session session) {
    final user = session.user;
    currentUser.value = UserModel(
      id: user.id,
      email: user.email ?? '',
      name: user.userMetadata?['name'] ?? user.userMetadata?['full_name'] ?? 'Utilisateur',
      avatarUrl: user.userMetadata?['avatar_url'] ?? user.userMetadata?['picture'],
      createdAt: DateTime.parse(user.createdAt),
    );
  }

  Future<void> signInWithGoogle() async {
    try {
      isLoading.value = true;
      loadingProvider.value = 'Google';
      errorMessage.value = '';

      final response = await _authService.signInWithGoogle();
      
      if (response?.user != null) {
        showSuccessMessage('Connexion réussie');
      }
    } catch (e) {
      errorMessage.value = 'Erreur de connexion: ${e.toString()}';
      showErrorMessage(errorMessage.value);
    } finally {
      isLoading.value = false;
      loadingProvider.value = '';
    }
  }

  Future<void> signInWithFacebook() async {
    try {
      isLoading.value = true;
      loadingProvider.value = 'Facebook';
      errorMessage.value = '';

      // TODO: Implémenter la connexion Facebook
      await Future.delayed(const Duration(seconds: 2));
      showErrorMessage('Facebook: En cours de développement');
    } catch (e) {
      errorMessage.value = 'Erreur de connexion Facebook: ${e.toString()}';
      showErrorMessage(errorMessage.value);
    } finally {
      isLoading.value = false;
      loadingProvider.value = '';
    }
  }

  Future<void> signInAsGuest() async {
    try {
      isLoading.value = true;
      errorMessage.value = '';

      final response = await _authService.signInAnonymously();
      
      if (response?.user != null) {
        showSuccessMessage('Connexion en mode invité');
      }
    } catch (e) {
      errorMessage.value = 'Erreur de connexion invité: ${e.toString()}';
      showErrorMessage(errorMessage.value);
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> signOut() async {
    try {
      isLoading.value = true;
      await _authService.signOut();
      showSuccessMessage('Déconnexion réussie');
    } catch (e) {
      errorMessage.value = 'Erreur de déconnexion: ${e.toString()}';
      showErrorMessage(errorMessage.value);
    } finally {
      isLoading.value = false;
    }
  }

  // Made these methods public by removing the underscore
  void showSuccessMessage(String message) {
    Get.snackbar(
      'Succès',
      message,
      snackPosition: SnackPosition.BOTTOM,
      backgroundColor: const Color(0xFF4CAF50),
      colorText: Colors.white,
      duration: const Duration(seconds: 2),
    );
  }

  void showErrorMessage(String message) {
    Get.snackbar(
      'Erreur',
      message,
      snackPosition: SnackPosition.BOTTOM,
      backgroundColor: const Color(0xFFE31E24),
      colorText: Colors.white,
      duration: const Duration(seconds: 4),
    );
  }
}