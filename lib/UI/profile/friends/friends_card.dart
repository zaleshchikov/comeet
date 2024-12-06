import 'package:flutter/material.dart';

import '../../../models/users/friend_model.dart';
import '../../../request_constant/colors.dart';

class FriendsCards extends StatelessWidget {
  const FriendsCards({super.key});

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    var size = MediaQuery
        .of(context)
        .size;
    var friends = [
      Friend(
          'Лера',
          'Описание Леры',
          'assets/test_images/test1.jpeg', 'Бэкенд-разработчик',

          123,
          colorPink
      ),
      Friend(
          'Лера',
          'Описание Леры',
          'assets/test_images/test1.jpeg', 'Бэкенд-разработчик',

          123,
          colorPink
      ),
      Friend(
          'Лера',
          'Описание Леры',
          'assets/test_images/test1.jpeg', 'Бэкенд-разработчик',

          123,
          colorPink
      ),
      Friend(
          'Лера',
          'Описание Леры',
          'assets/test_images/test1.jpeg', 'Бэкенд-разработчик',

          123,
          colorPink
      ),
      Friend(
          'Лера',
          'Описание Леры',
          'assets/test_images/test1.jpeg', 'Бэкенд-разработчик',

          123,
          colorPink
      ),
    ];
    ;
    return Container(
        height: size.height / 2,
        width: size.width,
        child: ListView.builder(
          padding: EdgeInsets.zero,
            itemCount: friends.length,
            itemBuilder: (context, index) =>
                Container(
                  height: size.height / 6,
                  width: size.width * 0.8,
                  padding: EdgeInsets.only(bottom: size.height / 50, right: size.width*0.07, left: size.width*0.07),
                  child: Container(
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(40),
                        color: friends[index].color
                    ),
                    padding: EdgeInsets.all(size.height / 200),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Container(
                          height: size.width / 4,
                          width: size.width / 4,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20),
                              image: DecorationImage(
                                  image:
                                  AssetImage(friends[index].photo),
                                  fit: BoxFit.cover)),
                        ),
                        Container(
                          width: size.width / 4,
                          padding: EdgeInsets.symmetric(vertical: size.height/100),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Container(width: size.width/4,
                                    child: Text(friends[index].name, textAlign: TextAlign.center,
                                        style: theme.textTheme.bodyMedium!.copyWith(fontWeight: FontWeight.w700)),
                                  ),
                                ],
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Container(width: size.width/4,child: Text(friends[index].profession,textAlign: TextAlign.center, style: theme.textTheme.labelMedium!.copyWith(color: bottomNavigationColorDark),)),
                                ],
                              )
                            ],
                          ),

                        ),
                        Container(
                          width: size.width / 5,
                          child: Center(
                            child: Icon(Icons.add),
                          ),
                        ),
                      ],
                    ),
                  ),
                ))
    );
  }
}
