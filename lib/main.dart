import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'screens/splash_screen.dart';

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
      home: const ChkobaSplashScreen(),
    );
  }
}