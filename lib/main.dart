import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'services/auth_service.dart';
import 'routes/app_routes.dart';
import 'routes/app_pages.dart';
import 'bindings/initial_binding.dart';

void main() async {
  try {
    debugPrint('Démarrage de l\'application...');
    WidgetsFlutterBinding.ensureInitialized();
    
    // Initialisation de Supabase
    debugPrint('Initialisation de Supabase...');
    await Supabase.initialize(
      url: 'https://nasjiocfbhyvuwekepnx.supabase.co',
      anonKey: 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6Im5hc2ppb2NmYmh5dnV3ZWtlcG54Iiwicm9sZSI6ImFub24iLCJpYXQiOjE3NTM2MjAwNjUsImV4cCI6MjA2OTE5NjA2NX0.JtriwwO9TVaAohu1URS0Nz4BuQWd09FURaevpAwikmU',
    );
    
    // Initialiser le service d'authentification
    debugPrint('Initialisation du service d\'authentification...');
    AuthService().initGoogleSignIn();
    
    debugPrint('Configuration de l\'orientation horizontale...');
    await SystemChrome.setPreferredOrientations([
      DeviceOrientation.landscapeLeft,
      DeviceOrientation.landscapeRight,
    ]);
    
    // Masquer la barre d'état pour une expérience plein écran
    await SystemChrome.setEnabledSystemUIMode(
      SystemUiMode.immersiveSticky,
      overlays: [SystemUiOverlay.bottom],
    );
    
    debugPrint('Lancement de l\'application en mode horizontal');
    runApp(const ChkobaApp());
  } catch (e, stackTrace) {
    debugPrint('Erreur critique lors du démarrage: $e');
    debugPrint('Stack trace: $stackTrace');
    
    // En cas d'erreur, lancer quand même l'app avec une configuration minimale
    runApp(const ChkobaAppFallback());
  }
}

class ChkobaApp extends StatelessWidget {
  const ChkobaApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Chkoba Tunisienne',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.red,
        primaryColor: const Color(0xFFE31E24),
        fontFamily: 'Roboto',
        visualDensity: VisualDensity.adaptivePlatformDensity,
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: const Color(0xFFE31E24),
            foregroundColor: Colors.white,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            padding: const EdgeInsets.symmetric(
              horizontal: 24,
              vertical: 12,
            ),
          ),
        ),
        appBarTheme: const AppBarTheme(
          backgroundColor: Color(0xFFE31E24),
          foregroundColor: Colors.white,
          elevation: 0,
          systemOverlayStyle: SystemUiOverlayStyle.light,
        ),
      ),
      initialBinding: InitialBinding(),
      initialRoute: AppRoutes.splash,
      getPages: AppPages.routes,
      unknownRoute: GetPage(
        name: '/notfound',
        page: () => const Scaffold(
          body: Center(
            child: Text('Page non trouvée'),
          ),
        ),
      ),
    );
  }
}

// Classe de fallback en cas d'erreur critique
class ChkobaAppFallback extends StatelessWidget {
  const ChkobaAppFallback({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Chkoba Tunisienne',
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [
                Color(0xFFE31E24),
                Color(0xFFC41E3A),
                Color(0xFF8B0000),
              ],
            ),
          ),
          child: const Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.warning,
                  color: Colors.white,
                  size: 64,
                ),
                SizedBox(height: 16),
                Text(
                  'Erreur de démarrage',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 8),
                Text(
                  'L\'application n\'a pas pu démarrer correctement.\nVeuillez redémarrer l\'application.',
                  style: TextStyle(
                    color: Colors.white70,
                    fontSize: 14,
                  ),
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}