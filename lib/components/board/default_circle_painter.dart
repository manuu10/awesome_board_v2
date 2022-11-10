import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

class AnimatedCircle extends HookWidget {
  const AnimatedCircle(this.color, {super.key});
  final Color color;

  @override
  Widget build(BuildContext context) {
    final animC =
        useAnimationController(duration: const Duration(milliseconds: 300));

    useEffect(() {
      if (color != Colors.transparent) {
        animC.forward();
      } else {
        animC.reverse();
      }
      return () {};
    }, [color]);

    return Container(
      color: Colors.transparent,
      child: ScaleTransition(
        scale: animC,
        child: CustomPaint(
          painter: DrawCircle(color),
        ),
      ),
    );
  }
}

class DrawCircle extends CustomPainter {
  late Paint _paint;

  DrawCircle(Color color) {
    _paint = Paint()
      ..color = color
      ..strokeWidth = 5
      ..style = PaintingStyle.stroke;
  }

  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    canvas.drawCircle(center, size.width / 2 + 5, _paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }
}
