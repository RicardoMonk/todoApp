import 'package:flutter/material.dart';
import 'package:to_do/shared/routes/app_routes.dart';
import 'package:to_do/shared/theme/app_theme.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

void main() {
  runApp(
    const ProviderScope(
      // Esto permite que toda la app acceda a los datos
      child: FocusApp(),
    ),
  );
}

class FocusApp extends StatelessWidget {
  const FocusApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Focus',
      theme: AppTheme.lightTheme,
      // En lugar de 'home:', usamos 'initialRoute' y el mapa de rutas
      initialRoute: AppRoutes.home,
      routes: AppRoutes.routes,
    );
  }
}
