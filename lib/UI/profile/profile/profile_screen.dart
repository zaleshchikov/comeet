import 'package:comeet/UI/animation/animation_one.dart';
import 'package:comeet/UI/events/events_screen.dart';
import 'package:comeet/UI/navigation/botoom_navigation.dart';
import 'package:comeet/UI/profile/friends/friend_screen.dart';
import 'package:comeet/UI/profile/profile/profile_back.dart';
import 'package:flutter/material.dart';

class ProfileScreen extends StatelessWidget {
  String name = 'Рим пал';
  String profession = 'центурион';
  String description = 'Рим пал, центурион';

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    var theme = Theme.of(context);

    return Stack(
      children: [
        ProfileBack(),
        Container(
          height: size.height,
          width: size.width,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Container(
                height: size.height / 30,
              ),
              Container(
                width: size.width * 0.8,
                child: Row(
                  children: [
                    Column(
                      children: [
                        Container(
                            width: size.width * 0.8,
                            child:
                                Text(name, style: theme.textTheme.titleSmall)),
                        Container(
                          width: size.width * 0.8,
                          child: Text(profession,
                              style: theme.textTheme.bodyLarge!
                                  .copyWith(color: Colors.white)),
                        ),
                      ],
                    )
                  ],
                ),
              ),
              Container(
                height: size.width * 0.85,
                width: size.width * 0.8,
                padding: EdgeInsets.all(size.height / 100),
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(30)),
                child: Container(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      image: DecorationImage(
                          image: AssetImage('assets/test_images/test1.jpeg'),
                          fit: BoxFit.fill)),
                ),
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: size.width * 0.1),
                height: size.height / 8,
                child: Text(
                  description,
                  style: theme.textTheme.bodyLarge!.copyWith(
                      color: Color(0xff8993A6),
                      height: 0.9 //You can set your custom height here
                      ),
                ),
              ),
              Container(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    InkWell(
                      onTap: () {
                        Navigator.of(context).push(SlideAnimationRoute(BottomNavigationScreen(FriendScreen())));
                      },
                      child: Container(
                        height: size.height / 15,
                        width: size.width * 0.4,
                        decoration: BoxDecoration(
                            border: Border.all(color: Colors.black),
                            borderRadius: BorderRadius.circular(50),
                            color: Colors.transparent),
                        child: Center(
                          child: Text(
                            'друзья',
                            style: theme.textTheme.titleSmall!
                                .copyWith(color: Colors.black),
                          ),
                        ),
                      ),
                    ),
                    InkWell(
                      onTap: () {
                        Navigator.of(context).push(SlideAnimationRoute(EventsScreen()));
                      },
                      child: Container(
                        height: size.height / 15,
                        width: size.width * 0.4,
                        decoration: BoxDecoration(
                            border: Border.all(color: Colors.black),
                            borderRadius: BorderRadius.circular(50),
                            color: theme.cardColor),
                        child: Center(
                          child: Text(
                            'меро',
                            style: theme.textTheme.titleSmall!
                                .copyWith(color: Colors.white),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                height: size.height / 10,
              )
            ],
          ),
        )
      ],
    );
  }
}
