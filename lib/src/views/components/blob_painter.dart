// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:math';

import 'package:flutter/material.dart';

import '../../model/particle.dart';

class BlobPainter extends CustomPainter {
  List<Particle> particles;
  Random random;
  BlobPainter({
    required this.particles,
    required this.random,
  });

  @override
  void paint(Canvas canvas, Size size) {
    for (var particle in particles) {
      var paint = Paint()..color = particle.color;
      canvas.drawCircle(particle.position, particle.radius, paint);
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}
