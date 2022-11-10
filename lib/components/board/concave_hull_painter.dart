// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:math';
import 'dart:ui';

import 'package:awesome_board_v2/models/settings.dart';
import 'package:flutter/material.dart';

class ConcaveHullPainter extends CustomPainter {
  late Paint _paint;
  List<Point> includedPoints;

  ConcaveHullPainter(Color color, {this.includedPoints = const []}) {
    _paint = Paint()
      ..color = color
      ..strokeWidth = 5
      ..strokeCap = StrokeCap.round
      ..style = PaintingStyle.stroke;
  }

  @override
  void paint(Canvas canvas, Size size) {
    final actualPoints = <Offset>[];
    final sizePerCell = Size(size.width / Settings.holdsHorizontal,
        size.height / Settings.holdsVertical);
    for (var p in includedPoints) {
      final rect = Rect.fromLTWH(p.x * sizePerCell.width,
          p.y * sizePerCell.height, sizePerCell.width, sizePerCell.height);
      actualPoints.add(rect.topLeft);
      actualPoints.add(rect.topRight);
      actualPoints.add(rect.bottomLeft);
      actualPoints.add(rect.bottomRight);
      final paint2 = Paint()
        ..color = const Color.fromARGB(114, 194, 77, 77)
        ..style = PaintingStyle.fill;
      canvas.drawRect(rect, paint2);
    }

    canvas.drawPoints(PointMode.points, actualPoints, _paint);
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