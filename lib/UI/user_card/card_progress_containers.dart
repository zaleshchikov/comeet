import 'package:comeet/request_constant/colors.dart';
import 'package:flutter/material.dart';

class CardProgressContainers extends StatelessWidget {
  double progress;
  CardProgressContainers(this.progress);

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    var theme = Theme.of(context);

    return Container(
      height: size.height/30,
      width: size.width*0.4,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: List<Widget>.generate(6, (int index) => RotationTransition(
            turns: AlwaysStoppedAnimation(45 / 360),
            //it will rotate 20 degree, remove (-) to rotate -20 degree
            child: Container(
              height: size.height/60,
              width: size.height/60,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(2),
                  border: Border.all(color: progressContainerColor, width: 3),
                  color: (index+1)*17 < progress ? progressContainerColor : Colors.transparent
              )
            )
        ))
      ),
    );
  }
}
