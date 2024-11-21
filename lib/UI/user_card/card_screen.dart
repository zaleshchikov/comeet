import 'package:comeet/UI/user_card/card_info.dart';
import 'package:comeet/request_constant/colors.dart';
import 'package:flutter/material.dart';

class CardScreen extends StatelessWidget {
  const CardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    var theme = Theme.of(context);

    return Stack(
      children: [
        Container(
          width: size.width,
          height: size.height,
          color: theme.cardColor,
        ),

        Container(
          width: size.width,
          height: size.height / 2,
          decoration: BoxDecoration(
            image: DecorationImage(image: AssetImage('assets/test_images/test1.jpeg'), fit: BoxFit.fill),
              borderRadius: BorderRadius.circular(50), color: Colors.white),
        ),
        Padding(
          padding:
              EdgeInsets.only(top: size.height * 0.3, left: size.width * 0.8),
          child: Container(
            height: size.height / 5,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Container(
                  height: size.height / 15,
                  width: size.height / 15,
                  decoration: BoxDecoration(
                      color: colorBlue,
                      borderRadius: BorderRadius.circular(20)),
                  child: Center(child: Text('M', style: theme.textTheme.bodyLarge)),
                ),
                Container(
                  height: size.height / 15,
                  width: size.height / 15,
                  decoration: BoxDecoration(
                      color: colorBlue,
                      borderRadius: BorderRadius.circular(20)),
                  child: Center(child: Text('Т', style: theme.textTheme.bodyLarge)),
                ),

              ],
            ),
          ),
        ),
        Container(
          padding: EdgeInsets.only(top: size.height*0.5),
          child: CardInfo(),
        ),
        Container(
          padding:
          EdgeInsets.only(top: size.height / 20, left: size.width / 20),
          child: IconButton(
            icon: ImageIcon(AssetImage('assets/icons/back_icon.png'),
                size: size.height / 20),
            onPressed: () => Navigator.of(context).pop(),
          ),
        ),
      ],
    );
  }
}
