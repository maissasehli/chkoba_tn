import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'screens/splash_screen.dart';


void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const ChkobaApp());
}

class ChkobaApp extends StatelessWidget {
  const ChkobaApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    
    return MaterialApp(
  
      home: const ChkobaSplashScreen(),
      debugShowCheckedModeBanner: false,
    );
  }
}