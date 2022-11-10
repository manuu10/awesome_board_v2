// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'package:flutter/material.dart';

class ConnectedToConfig {
  final bool top;
  final bool bottom;
  final bool left;
  final bool right;
  const ConnectedToConfig({
    this.top = false,
    this.bottom = false,
    this.left = false,
    this.right = false,
  });
}

class CustomHullPainter extends CustomPainter {
  late Paint _paint;
  late Paint _paintFill;
  final ConnectedToConfig config;
  final Color color;

  CustomHullPainter(this.color, {this.config = const ConnectedToConfig()}) {
    _paint = Paint()
      ..color = color
      ..strokeWidth = 5
      ..strokeCap = StrokeCap.round
      ..style = PaintingStyle.stroke;
    _paintFill = Paint()
      ..color = color.withOpacity(0.2)
      ..style = PaintingStyle.fill;
  }

  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    final radius = size.width / 2;
    final rect =
        Rect.fromCenter(center: center, width: radius * 2, height: radius * 2);

    final bottomLeft = rect.bottomLeft;
    final bottomRight = rect.bottomRight;
    final topRight = rect.topRight;
    final topLeft = rect.topLeft;

    if (color != Colors.transparent) canvas.drawRect(rect, _paintFill);
    if (!config.top) {
      canvas.drawLine(topLeft, topRight, _paint);
    }
    if (!config.bottom) {
      canvas.drawLine(bottomLeft, bottomRight, _paint);
    }
    if (!config.left) {
      canvas.drawLine(topLeft, bottomLeft, _paint);
    }
    if (!config.right) {
      canvas.drawLine(topRight, bottomRight, _paint);
    }
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }
}



/*

final center = Offset(size.width / 2, size.height / 2);
    final radius = size.width / 2;
    final bottomLeft = Offset(center.dx - radius, center.dy + radius);
    final bottomRight = Offset(center.dx + radius, center.dy + radius);
    final topRight = Offset(center.dx + radius, center.dy - radius);
    final topLeft = Offset(center.dx - radius, center.dy - radius);
if (!includedPoints.containsAny(
        [Points.DIR_UP, Points.DIR_UP_LEFT, Points.DIR_UP_RIGHT])) {
      canvas.drawLine(topLeft, topRight, _paint);
    }
    if (!includedPoints.containsAny(
        [Points.DIR_DOWN, Points.DIR_DOWN_LEFT, Points.DIR_DOWN_RIGHT])) {
      canvas.drawLine(bottomLeft, bottomRight, _paint);
    }
    if (!includedPoints.containsAny(
        [Points.DIR_LEFT, Points.DIR_UP_LEFT, Points.DIR_DOWN_LEFT])) {
      canvas.drawLine(topLeft, bottomLeft, _paint);
    }
    if (!includedPoints.containsAny(
        [Points.DIR_RIGHT, Points.DIR_UP_RIGHT, Points.DIR_DOWN_RIGHT])) {
      canvas.drawLine(topRight, bottomRight, _paint);
    }

    if (includedPoints.contains(Points.DIR_DOWN_RIGHT)) {
      canvas.drawLine(
          bottomLeft, Offset(center.dx, center.dy + size.height), _paint);
      canvas.drawLine(
          topRight, Offset(center.dx + size.width, center.dy), _paint);
    }

    if (includedPoints.contains(Points.DIR_DOWN_LEFT)) {
      canvas.drawLine(
          bottomRight, Offset(center.dx, center.dy + size.height), _paint);
      canvas.drawLine(
          topLeft, Offset(center.dx - size.width, center.dy), _paint);
    }

    if (includedPoints.contains(Points.DIR_UP_LEFT)) {
      canvas.drawLine(
          topRight, Offset(center.dx, center.dy - size.height), _paint);
      canvas.drawLine(
          bottomLeft, Offset(center.dx - size.width, center.dy), _paint);
    }
    if (includedPoints.contains(Points.DIR_UP_RIGHT)) {
      canvas.drawLine(
          topLeft, Offset(center.dx, center.dy - size.height), _paint);
      canvas.drawLine(
          bottomRight, Offset(center.dx + size.width, center.dy), _paint);
    }
    
    
    */