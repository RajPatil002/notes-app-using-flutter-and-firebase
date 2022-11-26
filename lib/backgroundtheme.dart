import 'package:flutter/cupertino.dart';

class BackgroundTheme extends CustomPainter{
  @override
  void paint(Canvas canvas, Size size) {
    Paint paint = Paint()
      ..color = const Color(0xff01bff9)
      ..style = PaintingStyle.fill;

    final radius = (Offset(size.width * 0.5, size.height * 0.1) - Offset(size.width * 0.5, size.height * 0.5)).distance * 0.5;
    Path path = Path();
    path.moveTo(0, 0);
    path.lineTo(size.width * 0.5, 0);
    path.lineTo(size.width * 0.45, size.height * 0.085);
    path.quadraticBezierTo(size.width * 0.45, size.height * 0.1, size.width * 0.5, size.height * 0.1);
    path.lineTo(size.width * 0.5, size.height * 0.1);

    path.arcToPoint(Offset(size.width * 0.5, size.height * 0.5),radius: Radius.circular(radius));
    path.arcToPoint(Offset(size.width * 0.5, size.height * 0.9),radius: Radius.circular(radius), clockwise: false);

    path.quadraticBezierTo(size.width * 0.55, size.height * 0.9, size.width * 0.55, size.height * 0.915);


    path.lineTo(size.width * 0.5, size.height);
    path.lineTo(0, size.height);
    path.close();

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;

}