import 'package:comeet/request_constant/colors.dart';
import 'package:flutter/material.dart';

class TestCardBack extends StatelessWidget {
  Color mainColor;
  Color sideColor;
  double hieght;
  TestCardBack(this.mainColor, this.sideColor, this.hieght);

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    var theme = Theme.of(context);

    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(30),
        color: mainColor,
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          ClipPath(
            clipBehavior: Clip.hardEdge,
            clipper: ChevronBottom(),
            child: Container(
              width: size.width,
              height: hieght,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(30),
                color: sideColor,

              ),
            ),
          )
        ],
      ),
    );
  }

}

class ChevronBottom extends CustomClipper<Path> {
  @override
  getClip(Size size) {
    var controlPoint1 = Offset(size.width * 0.9, -50);
    var controlPoint2 = Offset(size.width * 0.85, size.height*0.9);
    var endPoint = Offset(size.width * 0.6, size.height * 0.95);

    var controlPoint12 = Offset(size.width * 0.6, size.height * 0.95);
    var controlPoint22 = Offset(size.width * 0.55, size.height);
    var endPoint2 = Offset(size.width * 0.3, size.height * 0.85);

    var controlPoint13 = Offset(size.width * 0.3, size.height * 0.85);
    var controlPoint23 = Offset(size.width * 0.10, size.height * 0.7);
    var endPoint3 = Offset(0, size.height);

    Path path = Path();
    path.moveTo(0, size.height * 0.3);
    path.lineTo(0, size.height);
    path.lineTo(size.width, size.height);
    path.lineTo(size.width, 0);
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
