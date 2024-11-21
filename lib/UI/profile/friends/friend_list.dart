import 'package:comeet/models/users/friend_model.dart';
import 'package:comeet/request_constant/colors.dart';
import 'package:flutter/material.dart';

class FriendList extends StatelessWidget {
  FriendList({super.key});

  var friends = [
    Friend('Лера', 'Описание Леры', 'assets/test_images/test1.jpeg',
        'Бэкенд-разработчик', 123, colorPink),
    Friend('Лера', 'Описание Леры', 'assets/test_images/test1.jpeg',
        'Бэкенд-разработчик', 123, colorPink),
    Friend('Лера', 'Описание Леры', 'assets/test_images/test1.jpeg',
        'Бэкенд-разработчик', 123, colorPink),
    Friend('Лера', 'Описание Леры', 'assets/test_images/test1.jpeg',
        'Бэкенд-разработчик', 123, colorPink),
    Friend('Лера', 'Описание Леры', 'assets/test_images/test1.jpeg',
        'Бэкенд-разработчик', 123, colorPink),
  ];

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    var theme = Theme.of(context);

    return Container(
      width: size.width,
      height: size.height / 6 + size.height / 50,
      child: ListView(
          scrollDirection: Axis.horizontal,
          children: List.generate(
              friends.length,
              (index) => Container(
                    padding: EdgeInsets.all(size.height / 100),
                    child: Container(
                      height: size.height / 6,
                      width: size.height / 6,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          image: DecorationImage(
                              image: AssetImage(friends[index].photo),
                              fit: BoxFit.fill)),
                    ),
                  ))),
    );
  }
}