import 'package:flutter/material.dart';
import '../../presentation/screens/home_screen.dart';
import '../../presentation/screens/details_screen.dart'; // <--- Importa la nueva pantalla

class AppRoutes {
  // Nombres de las rutas como constantes para evitar errores de dedo
  static const String home = 'home';
  static const String details = 'details'; // La usaremos en la Fase 3

  static Map<String, Widget Function(BuildContext)> routes = {
    home: (context) => const HomeScreen(),
    details: (context) => const DetailsScreen(),
    // Aquí agregaremos más rutas conforme avancemos
  };
}
