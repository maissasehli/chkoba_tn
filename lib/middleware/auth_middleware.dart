import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/auth_controller.dart';
import '../routes/app_routes.dart';

class AuthMiddleware extends GetMiddleware {
  @override
  RouteSettings? redirect(String? route) {
    final authController = Get.find<AuthController>();
    
    // Si l'utilisateur n'est pas authentifié et essaie d'accéder à une page protégée
    if (!authController.isAuthenticated.value && route == AppRoutes.home) {
      return const RouteSettings(name: AppRoutes.login);
    }
    
    // Si l'utilisateur est authentifié et essaie d'accéder à la page de login
    if (authController.isAuthenticated.value && 
        (route == AppRoutes.login || route == AppRoutes.splash)) {
      return const RouteSettings(name: AppRoutes.home);
    }
    
    return null;
  }
}