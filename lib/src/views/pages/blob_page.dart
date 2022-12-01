import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_application_1/src/model/particle.dart';

import 'package:flutter_application_1/src/views/components/blob_painter.dart';

Color getRandomColor(Random rnd) {
  var a = rnd.nextInt(255);
  var r = rnd.nextInt(255);
  var g = rnd.nextInt(255);
  var b = rnd.nextInt(255);
  return Color.fromARGB(a, r, g, b);
}

Offset polarToCartesian(double radius, double theta) {
  return Offset(radius * cos(theta), radius * sin(theta));
}

class BlobPage extends StatefulWidget {
  const BlobPage({super.key});

  @override
  State<BlobPage> createState() => _BlobPageState();
}

class _BlobPageState extends State<BlobPage>
    with SingleTickerProviderStateMixin {
  late List<Particle> particles = [];
  late Animation<double> animation;
  late AnimationController controller;

  int particleCount = 500;

  Random random = Random(DateTime.now().millisecondsSinceEpoch);

  @override
  void initState() {
    super.initState();

    controller =
        AnimationController(duration: const Duration(seconds: 10), vsync: this);

    animation = Tween<double>(begin: 0, end: 300).animate(controller)
      ..addListener(() {
        if (particles.isEmpty) {
          createBlobField();
        } else {
          setState(() {
            updateBlobField();
          });
        }
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
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      painter: BlobPainter(particles: particles, random: random),
      child: Container(),
    );
  }

  void createBlobField() {
    //get the size of the screen
    final size = MediaQuery.of(context).size;
    //center of the screen
    final center = Offset(size.width / 2, size.height / 2);
    //number of blobs
    const n = 5;
    //radius of the blob
    final radius = size.width / n;
    //alpha blending value
    const a = 0.2;

    blobField(radius, n, a, center);
  }

  void blobField(double radius, int n, double a, Offset center) {
    if (radius < 10) return;
    //draw the center blob
    particles.add(
      Particle(
        color: Colors.black,
        theta: 0,
        position: center,
        radius: radius / n,
        origin: center,
      ),
    );

    // add orbital blobs
    var theta = 0.0;
    var dtheta = 2 * pi / n;
    for (var i = 0; i < n; i++) {
      var pos = polarToCartesian(radius, theta) + center;
      particles.add(
        Particle(
          radius: radius / 3,
          origin: center,
          position: pos,
          color: Colors.black,
          theta: theta,
        ),
      );
      theta += dtheta;
      var f = 0.43;
      blobField(radius * f, n, a * 1.5, pos);
    }
  }

  double t = 0;
  double dt = 0.01;
  void updateBlobField() {
    t += dt;
    //move the particles around in its orbit
    for (var element in particles) {
      element.position =
          polarToCartesian(element.radius * 5, element.theta + t) +
              element.origin;
    }
  }
}
