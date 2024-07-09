import 'package:flutter/material.dart';

class CustomTooltipShape extends StatelessWidget {
  final String? message;
  final Widget? child;
  final Color? color;

  CustomTooltipShape({this.message, this.child, this.color});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        CustomPaint(
          painter: TooltipPainter(color),
          child: Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: color ?? Colors.white,
              borderRadius: BorderRadius.circular(8),
            ),
            child: child ?? Text(
              message ?? "",
              style: const TextStyle(color: Colors.black),
            ),
          ),
        ),
      ],
    );
  }
}

class TooltipPainter extends CustomPainter {
  final Color? color;
  TooltipPainter(this.color);

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color ?? Colors.white
      ..style = PaintingStyle.fill;

    final path = Path();
    path.moveTo(size.width / 2 - 10, size.height);
    path.lineTo(size.width / 2 + 10, size.height);
    path.lineTo(size.width / 2, size.height + 10);
    path.close();

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return false;
  }
}