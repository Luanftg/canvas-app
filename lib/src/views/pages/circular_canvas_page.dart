import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_application_1/src/views/components/circular_painter_canvas.dart';

import '../components/particle.dart';

class CircularCanavasPage extends StatefulWidget {
  const CircularCanavasPage({super.key});

  @override
  State<CircularCanavasPage> createState() => _CircularCanavasPageState();
}

Color getRandomColor(Random rnd) {
  var a = rnd.nextInt(255);
  var r = rnd.nextInt(255);
  var g = rnd.nextInt(255);
  var b = rnd.nextInt(255);
  return Color.fromARGB(a, r, g, b);
}

double maxRadius = 6;
double maxSpeed = 0.2;
double maxTheta = 2.0 * pi;

class _CircularCanavasPageState extends State<CircularCanavasPage>
    with SingleTickerProviderStateMixin {
  late List<Particle> particles;
  late Animation<double> animation;
  late AnimationController controller;

  Random random = Random(DateTime.now().millisecondsSinceEpoch);
  @override
  void initState() {
    super.initState();

    controller =
        AnimationController(duration: const Duration(seconds: 10), vsync: this);

    animation = Tween<double>(begin: 0, end: 300).animate(controller)
      ..addListener(() {
        setState(() {
          // The state that has changed here is the animation object’s value.
        });
      })
      ..addStatusListener(
        (status) {
          if (status == AnimationStatus.completed) {
            controller.repeat();
          } else if (status == AnimationStatus.dismissed) {
            controller.forward();
          }
        },
      );
    controller.forward();

    particles = List<Particle>.generate(200, (index) {
      Particle particle = Particle(
        position: const Offset(-1, -1),
        color: getRandomColor(random),
        speed: random.nextDouble() * maxSpeed,
        theta: random.nextDouble() * maxTheta,
        radius: random.nextDouble() * maxRadius,
      );
      return particle;
    });
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Scaffold(
        body: CustomPaint(
          foregroundPainter: CircularPainterCanvas(
            particles,
            random,
            animation.value,
          ),
          child: Container(
            color: Colors.black54,
          ),
        ),
      ),
    );
  }
}
