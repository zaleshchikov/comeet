import 'package:flutter/material.dart';

class ProfileBack extends StatelessWidget {
  const ProfileBack({super.key});


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
                color: theme.cardColor,
                width: size.width,
                height: size.height / 3,
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
    var controlPoint1 = Offset(size.width * 0.1, size.height * 0.9);
    var controlPoint2 = Offset(size.width * 0.2, size.height * 0.95);
    var endPoint = Offset(size.width * 0.4, size.height * 0.75);

    var controlPoint12 = Offset(size.width * 0.4, size.height * 0.75);
    var controlPoint22 = Offset(size.width * 0.6, size.height*0.55);
    var endPoint2 = Offset(size.width*0.7, size.height * 0.75);

    var controlPoint13 = Offset(size.width * 0.7, size.height * 0.75);
    var controlPoint23 = Offset(size.width * 0.8, size.height * 0.95);
    var endPoint3 = Offset(size.width, size.height * 0.75);

    Path path = Path();
    path.moveTo(0, 0);
    path.lineTo(0, size.height * 0.6);
    path.cubicTo(controlPoint1.dx, controlPoint1.dy, controlPoint2.dx,
        controlPoint2.dy, endPoint.dx, endPoint.dy);

    path.cubicTo(controlPoint12.dx, controlPoint12.dy, controlPoint22.dx,
        controlPoint22.dy, endPoint2.dx, endPoint2.dy);

    path.cubicTo(controlPoint13.dx, controlPoint13.dy, controlPoint23.dx,
        controlPoint23.dy, endPoint3.dx, endPoint3.dy);

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


