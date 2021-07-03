import 'package:flutter/material.dart';

class BackgroundPainter extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      child: Container(),
      painter: BackgoundDrawer(),
    );
  }
}

class BackgoundDrawer extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    double height = size.height;
    double width = size.width;

    Paint paint_0 = new Paint()
      ..color = Color.fromARGB(255, 33, 150, 243)
      ..style = PaintingStyle.fill
      ..strokeWidth = 1;

    Path path_0 = Path();
    path_0.moveTo(0, size.height);
    path_0.quadraticBezierTo(size.width * 0.1543750, size.height * 0.5000000,
        size.width * 0.3125000, size.height * 0.5000000);
    path_0.quadraticBezierTo(size.width * 0.4062500, size.height * 0.5000000,
        size.width * 0.9987500, size.height);
    path_0.lineTo(0, height);

    path_0.close();

    canvas.drawPath(path_0, paint_0);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}
