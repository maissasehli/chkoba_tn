import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'dart:io';

class AuthService {
  static final _instance = AuthService._internal();
  factory AuthService() => _instance;
  AuthService._internal();

  final SupabaseClient _supabase = Supabase.instance.client;
  late GoogleSignIn _googleSignIn;

  void initGoogleSignIn() {
    if (Platform.isIOS) {
      _googleSignIn = GoogleSignIn(
        clientId: '477072394253-afq0np2gnlka9cje82q06p817h1hn4vk.apps.googleusercontent.com',
        serverClientId: '477072394253-q9necinvnvpfouh3nb26lr46lgad0uh9.apps.googleusercontent.com',
      );
    } else if (Platform.isAndroid) {
      _googleSignIn = GoogleSignIn(
        serverClientId: '477072394253-q9necinvnvpfouh3nb26lr46lgad0uh9.apps.googleusercontent.com',
      );
    } else {
      // Web
      _googleSignIn = GoogleSignIn(
        clientId: '477072394253-afq0np2gnlka9cje82q06p817h1hn4vk.apps.googleusercontent.com',
      );
    }
  }

  // Connexion avec Google
  Future<AuthResponse?> signInWithGoogle() async {
    try {
      final GoogleSignInAccount? googleUser = await _googleSignIn.signIn();
      
      if (googleUser == null) {
        throw Exception('Connexion Google annulée');
      }

      final GoogleSignInAuthentication googleAuth = await googleUser.authentication;

      if (googleAuth.accessToken == null || googleAuth.idToken == null) {
        throw Exception('Tokens Google non disponibles');
      }

      final AuthResponse response = await _supabase.auth.signInWithIdToken(
        provider: OAuthProvider.google,
        idToken: googleAuth.idToken!,
        accessToken: googleAuth.accessToken!,
      );

      return response;
    } catch (error) {
      rethrow;
    }
  }

  // Déconnexion
  Future<void> signOut() async {
    try {
      // Déconnexion de Google
      await _googleSignIn.signOut();
      
      // Déconnexion de Supabase
      await _supabase.auth.signOut();
    } catch (error) {
      rethrow;
    }
  }

  // Utilisateur actuel
  User? get currentUser => _supabase.auth.currentUser;

  // Session actuelle
  Session? get currentSession => _supabase.auth.currentSession;

  // Écouter les changements d'authentification
  Stream<AuthState> get authStateChange => _supabase.auth.onAuthStateChange;

  // Vérifier si l'utilisateur est connecté
  bool get isSignedIn => currentSession != null;

  // Connexion anonyme (mode invité)
  Future<AuthResponse?> signInAnonymously() async {
    try {
      final response = await _supabase.auth.signInAnonymously();
      return response;
    } catch (error) {
      rethrow;
    }
  }

  // Mettre à jour le profil utilisateur
  Future<void> updateUserProfile({
    String? displayName,
    String? avatarUrl,
  }) async {
    try {
      final updates = <String, dynamic>{};
      
      if (displayName != null) {
        updates['display_name'] = displayName;
      }
      
      if (avatarUrl != null) {
        updates['avatar_url'] = avatarUrl;
      }

      if (updates.isNotEmpty) {
        await _supabase.auth.updateUser(
          UserAttributes(data: updates),
        );
      }
    } catch (error) {
      rethrow;
    }
  }

  // Récupérer les informations de l'utilisateur
  Map<String, dynamic>? get userMetadata => currentUser?.userMetadata;
  
  String? get userEmail => currentUser?.email;
  String? get userName => userMetadata?['name'] ?? userMetadata?['full_name'];
  String? get userAvatarUrl => userMetadata?['avatar_url'] ?? userMetadata?['picture'];
}