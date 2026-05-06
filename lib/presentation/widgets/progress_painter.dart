import 'dart:math';
import 'package:flutter/material.dart';

class ProgressPainter extends CustomPainter {
  final double progress; // Valor de 0.0 a 1.0
  final Color color;

  ProgressPainter({required this.progress, required this.color});

  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    final radius = min(size.width / 2, size.height / 2);
    final strokeWidth = 10.0;

    // 1. Dibujar el fondo (el círculo gris tenue)
    final backgroundPaint = Paint()
      ..color = Colors.white.withValues(alpha: 0.1)
      ..style = PaintingStyle.stroke
      ..strokeWidth = strokeWidth;

    canvas.drawCircle(center, radius, backgroundPaint);

    // 2. Dibujar el arco de progreso (Rojo Focus)
    final progressPaint = Paint()
      ..color = color
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap
          .round // Bordes redondeados pro
      ..strokeWidth = strokeWidth;

    // Calculamos el ángulo: -pi/2 es para que empiece arriba (las 12 en punto)
    final arcAngle = 2 * pi * progress;
    canvas.drawArc(
      Rect.fromCircle(center: center, radius: radius),
      -pi / 2,
      arcAngle,
      false,
      progressPaint,
    );
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}
