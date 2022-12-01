// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/animation.dart';

class Particle {
  final double radius;
  Offset position;
  Offset origin;
  final Color color;
  final double theta;
  Particle({
    required this.theta,
    required this.origin,
    required this.radius,
    required this.position,
    required this.color,
  });
}
