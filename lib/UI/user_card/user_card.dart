import 'package:flutter/material.dart';

import '../../models/users/user_model.dart';
import '../../request_constant/colors.dart';
import 'card_info.dart';

class UserCardScreen extends StatelessWidget {
  User user;


  UserCardScreen(this.user);

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    var theme = Theme.of(context);

    return Material(
      
      child: Scaffold(
        body: Stack(
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
                  image: DecorationImage(image: AssetImage(user.photo), fit: BoxFit.cover),
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
              child: CardInfo(user),
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
        ),
      ),
    );
  }
}
