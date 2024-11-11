import 'package:flutter/material.dart';

class TestBack extends StatelessWidget {
  Color color;
  TestBack(this.color, {super.key});

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    var theme = Theme.of(context);

    return Scaffold(

      body: Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            ClipPath(
              clipBehavior: Clip.hardEdge,
              clipper: ChevronTop(),
              child: Container(
                color: color,
                width: size.width,
                height: size.height / 3.3,
              ),
            ),
            ClipPath(
              clipBehavior: Clip.hardEdge,
              clipper: ChevronBottom(),
              child: Container(
                color: color,
                width: size.width,
                height: size.height / 3.3,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class ChevronTop extends CustomClipper<Path> {
  @override
  getClip(Size size) {
    var controlPoint1 = Offset(size.width * 0.1, size.height * 0.6);
    var controlPoint2 = Offset(size.width * 0.15, size.height * 0.65);
    var endPoint = Offset(size.width * 0.3, size.height * 0.8);

    var controlPoint12 = Offset(size.width * 0.3, size.height * 0.8);
    var controlPoint22 = Offset(size.width * 0.7, size.height*1.1);
    var endPoint2 = Offset(size.width, size.height * 0.9);

    Path path = Path();
    path.moveTo(0, 0);
    path.lineTo(0, size.height * 0.6);
    path.cubicTo(controlPoint1.dx, controlPoint1.dy, controlPoint2.dx,
        controlPoint2.dy, endPoint.dx, endPoint.dy);

    path.cubicTo(controlPoint12.dx, controlPoint12.dy, controlPoint22.dx,
        controlPoint22.dy, endPoint2.dx, endPoint2.dy);

    path.lineTo(size.width, size.height);
    path.lineTo(size.width, 0);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper oldClipper) {
    return false;
  }
}

class ChevronBottom extends CustomClipper<Path> {
  @override
  getClip(Size size) {
    var controlPoint1 = Offset(size.width * 0.8, 0);
    var controlPoint2 = Offset(size.width * 0.7, size.height * 0.3);
    var endPoint = Offset(size.width * 0.6, size.height * 0.4);

    var controlPoint12 = Offset(size.width * 0.60, size.height * 0.4);
    var controlPoint22 = Offset(size.width * 0.5, size.height * 0.5);
    var endPoint2 = Offset(size.width * 0.3, size.height * 0.4);

    var controlPoint13 = Offset(size.width * 0.3, size.height * 0.4);
    var controlPoint23 = Offset(size.width * 0.10, size.height * 0.3);
    var endPoint3 = Offset(0, size.height * 0.4);

    Path path = Path();
    path.moveTo(0, size.height * 0.3);
    path.lineTo(0, size.height);
    path.lineTo(size.width, size.height);
    path.lineTo(size.width, size.height * 0.2);
    path.cubicTo(controlPoint1.dx, controlPoint1.dy, controlPoint2.dx,
        controlPoint2.dy, endPoint.dx, endPoint.dy);

    path.cubicTo(controlPoint12.dx, controlPoint12.dy, controlPoint22.dx,
        controlPoint22.dy, endPoint2.dx, endPoint2.dy);

    path.cubicTo(controlPoint13.dx, controlPoint13.dy, controlPoint23.dx,
        controlPoint23.dy, endPoint3.dx, endPoint3.dy);

    path.lineTo(0, size.height * 0.3);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper oldClipper) {
    return false;
  }
}
