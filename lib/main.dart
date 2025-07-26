import 'package:chkoba_tn/features/auth/presentation/controllers/pages/login_page.dart';
import 'package:chkoba_tn/features/home/home_screen.dart';
import 'package:chkoba_tn/features/splash/presentation/pages/splash_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void main() async {
  try {
    debugPrint('Démarrage de l\'application...');
    WidgetsFlutterBinding.ensureInitialized();
    
    debugPrint('Configuration de l\'orientation horizontale...');
    await SystemChrome.setPreferredOrientations([
      DeviceOrientation.landscapeLeft,
      DeviceOrientation.landscapeRight,
    ]);
    
    debugPrint('Lancement de l\'application en mode horizontal');
    runApp(const ChkobaApp());
  } catch (e, stackTrace) {
    debugPrint('Erreur critique lors du démarrage: $e');
    debugPrint('Stack trace: $stackTrace');
  }
}

class ChkobaApp extends StatelessWidget {
  const ChkobaApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Chkoba Tunisienne',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.amber,
        fontFamily: 'Roboto',
        visualDensity: VisualDensity.adaptivePlatformDensity,
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.amber,
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
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => const SplashPage(),
        '/login': (context) => const LoginPage(),
        '/home': (context) => const ChkobaHomePage(), 
      },
    );
  }
}
