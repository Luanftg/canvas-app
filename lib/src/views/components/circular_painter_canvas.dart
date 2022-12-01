// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:math';

import 'package:flutter/material.dart';

import 'package:flutter_application_1/src/views/components/particle.dart';

Offset polarToCartesian(double speed, double theta) {
  return Offset(speed * cos(theta), speed * sin(theta));
}

class CircularPainterCanvas extends CustomPainter {
  List<Particle> particles;
  Random random;
  double animValue;
  CircularPainterCanvas(
    this.particles,
    this.random,
    this.animValue,
  );

  @override
  void paint(Canvas canvas, Size size) {
    var random = Random();
    for (var particle in particles) {
      var velocity = polarToCartesian(particle.speed, particle.theta);
      var dx = particle.position.dx + velocity.dx;
      var dy = particle.position.dy + velocity.dy;

      if (particle.position.dx < 0 || particle.position.dx > size.width) {
        dx = random.nextDouble() * size.width;
      }
      if (particle.position.dy < 0 || particle.position.dy > size.height) {
        dy = random.nextDouble() * size.height;
      }
      particle.position = Offset(dx, dy);
    }

    for (var element in particles) {
      var paint = Paint()..color = Colors.amber;
      canvas.drawCircle(element.position, element.radius, paint);
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}
