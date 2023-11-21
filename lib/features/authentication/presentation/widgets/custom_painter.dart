import 'package:flutter/material.dart';

class AuthMobilePagePainter1 extends CustomPainter {

  AuthMobilePagePainter1({
    super.repaint,
  });

  @override
  void paint(Canvas canvas, Size size) {
    Paint paint_fill_0 = Paint()
      ..color = Colors.cyan
      ..style = PaintingStyle.fill
      ..strokeWidth = size.width * 0.00
      ..strokeCap = StrokeCap.butt
      ..strokeJoin = StrokeJoin.miter;

    Path path_0 = Path();
    path_0.moveTo(size.width * -0.0007692, size.height * 0.6200833);
    path_0.lineTo(0, 0);
    path_0.lineTo(size.width * 1.0014359, size.height * 0.0065000);
    path_0.lineTo(size.width * 0.9992308, size.height * 0.6108333);
    path_0.quadraticBezierTo(size.width * 0.7705128, size.height * 1.2681667,
        size.width * 0.5128205, size.height * 0.6166667);
    path_0.quadraticBezierTo(size.width * 0.2628718, size.height * 0.0187500,
        size.width * -0.0007692, size.height * 0.6200833);
    path_0.close();

    canvas.drawPath(path_0, paint_fill_0);

    Paint paint_stroke_0 = Paint()
      ..color = Colors.white
      ..style = PaintingStyle.stroke
      ..strokeWidth = size.width * 0.00
      ..strokeCap = StrokeCap.butt
      ..strokeJoin = StrokeJoin.miter;

    canvas.drawPath(path_0, paint_stroke_0);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

class AuthMobilePagePainter2 extends CustomPainter {
  AuthMobilePagePainter2({super.repaint});

  @override
  void paint(Canvas canvas, Size size) {
    Paint paint_fill_0 = Paint()
      ..color = Colors.cyan
      ..style = PaintingStyle.fill
      ..strokeWidth = size.width * 0.00
      ..strokeCap = StrokeCap.butt
      ..strokeJoin = StrokeJoin.miter;

    Path path_0 = Path();
    path_0.moveTo(size.width * -0.0000513, size.height * 0.3302500);
    path_0.lineTo(size.width * -0.0000513, size.height * 1.0219167);
    path_0.lineTo(size.width * 0.9999487, size.height * 1.0219167);
    path_0.lineTo(size.width * 0.9999487, size.height * 0.3219167);
    path_0.quadraticBezierTo(size.width * 0.7834103, size.height * 1.0129167,
        size.width * 0.5127692, size.height * 0.3302500);
    path_0.quadraticBezierTo(size.width * 0.2604359, size.height * -0.2868333,
        size.width * -0.0000513, size.height * 0.3302500);
    path_0.close();

    canvas.drawPath(path_0, paint_fill_0);

    Paint paint_stroke_0 = Paint()
      ..color = Colors.white
      ..style = PaintingStyle.stroke
      ..strokeWidth = size.width * 0.00
      ..strokeCap = StrokeCap.butt
      ..strokeJoin = StrokeJoin.miter;

    canvas.drawPath(path_0, paint_stroke_0);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
