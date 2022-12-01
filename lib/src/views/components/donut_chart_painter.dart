import 'dart:math';

import 'package:flutter/material.dart';

import '../../model/data_item.dart';

final linePaint = Paint()
  ..style = PaintingStyle.stroke
  ..strokeWidth = 2.0
  ..color = Colors.white;
final midPaint = Paint()
  ..style = PaintingStyle.fill
  ..color = Colors.white;

const midTextStyle = TextStyle(
  color: Colors.black38,
  fontWeight: FontWeight.bold,
  fontSize: 30.0,
);

const labelStyle = TextStyle(
  color: Colors.black,
  fontSize: 12.0,
);

class DonutChartPainter extends CustomPainter {
  final List<DataItem> dataset;
  final double fullAngle;
  DonutChartPainter(this.dataset, this.fullAngle);

  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    final radius = size.width * 0.9;
    final rect = Rect.fromCenter(center: center, width: radius, height: radius);

    var startAngle = 0.0;
    canvas.drawArc(rect, startAngle, fullAngle * pi / 180, false, linePaint);
    for (var element in dataset) {
      final sweepAngle = element.value * fullAngle * pi / 180;
      drawSector(element, canvas, rect, startAngle, sweepAngle);
      startAngle += sweepAngle;
    }
    startAngle = 0.0;
    for (var element in dataset) {
      final sweepAngle = element.value * fullAngle * pi / 180;
      drawLine(radius, startAngle, center, canvas);
      startAngle += sweepAngle;
    }
    startAngle = 0.0;
    for (var element in dataset) {
      final sweepAngle = element.value * fullAngle * pi / 180;
      drawLine(radius, startAngle, center, canvas);
      drawLabels(canvas, center, radius, startAngle, sweepAngle, element.label);
      startAngle += sweepAngle;
    }
    canvas.drawCircle(center, radius * 0.3, midPaint);
    drawTextCentered(canvas, center, 'Social\nFinances', midTextStyle,
        radius * 0.6, (Size size) {});
  }

  void drawSector(DataItem element, Canvas canvas, Rect rect, double startAngle,
      double sweepAngle) {
    final paint = Paint()
      ..style = PaintingStyle.fill
      ..color = element.color;
    canvas.drawArc(rect, startAngle, sweepAngle, true, paint);
  }

  void drawLabels(Canvas canvas, Offset center, double radius,
      double startAngle, double sweepAngle, String label) {
    final newRadius = radius * 0.4;
    final dx = newRadius * cos(startAngle + sweepAngle / 2);
    final dy = newRadius * sin(startAngle + sweepAngle / 2);
    final position = center + Offset(dx, dy);
    drawTextCentered(canvas, position, label, labelStyle, 100, (Size size) {
      final rect = Rect.fromCenter(
          center: position, width: size.width + 5, height: size.height + 5);
      final rrect = RRect.fromRectAndRadius(rect, const Radius.circular(5));
      canvas.drawRRect(rrect, midPaint);
    });
  }

  TextPainter measureText(
      String text, TextStyle style, double maxWidth, TextAlign align) {
    final span = TextSpan(text: text, style: style);
    final textPainter = TextPainter(
        text: span, textAlign: align, textDirection: TextDirection.ltr);
    textPainter.layout(maxWidth: maxWidth, minWidth: 0);
    return textPainter;
  }

  Size drawTextCentered(Canvas canvas, Offset position, String text,
      TextStyle style, double maxWidth, Function(Size size) bgCb) {
    final textPainter = measureText(text, style, maxWidth, TextAlign.center);
    final pos =
        position + Offset(-textPainter.width / 2, -textPainter.height / 2);
    bgCb(textPainter.size);
    textPainter.paint(canvas, pos);
    return textPainter.size;
  }

  void drawLine(
      double radius, double startAngle, Offset center, Canvas canvas) {
    final dx = radius / 2 * cos(startAngle);
    final dy = radius / 2 * sin(startAngle);
    final p2 = center + Offset(dx, dy);
    canvas.drawLine(center, p2, linePaint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}
