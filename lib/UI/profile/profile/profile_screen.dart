import 'dart:convert';

import 'package:comeet/UI/animation/animation_one.dart';
import 'package:comeet/UI/navigation/botoom_navigation.dart';
import 'package:comeet/UI/profile/friends/friend_screen.dart';
import 'package:comeet/UI/profile/profile/edit_profile/edit_profile_screen.dart';
import 'package:comeet/UI/profile/profile/profile_back.dart';
import 'package:comeet/UI/profile/profile/test_grid/test_grid.dart';
import 'package:comeet/bloc/profile/profile_bloc.dart';
import 'package:comeet/models/users/user_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../events/profile_events_screen.dart';
import 'last_tests/last_tests.dart';

class ProfileScreen extends StatelessWidget {


  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    var theme = Theme.of(context);

    return BlocProvider(
  create: (context) => ProfileBloc()..add(GetProfileData()),
  child: Builder(
    builder: (context) {
      return BlocBuilder<ProfileBloc, ProfileState>(
  builder: (context, state) {
    return SingleChildScrollView(
          child: Container(
            height: size.height*2.3,
            child: Stack(
              children: [
                ProfileBack(),
                Column(
                  children: [
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
                            width: size.width * 0.85,
                            child: Row(
                              children: [
                                Column(
                                  children: [
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        Container(
                                            width: size.width * 0.7,
                                            child:
                                                Text(state.profile.name, style: theme.textTheme.titleSmall)),
                                        InkWell(
                                          onTap: (){
                                            Navigator.of(context).push(SlideAnimationRoute(EditProfileSCreen(state.profile)));
                                          },
                                          child: Container(
                                            height: size.height/20,
                                            width: size.height/20,
                                            child: Image.asset('assets/icons/edit.png', fit: BoxFit.contain,),
                                          ),
                                        )
                                      ],
                                    ),
                                    Container(
                                      width: size.width * 0.8,
                                      child: Text(state.profile.profession,
                                          style: theme.textTheme.bodyLarge!
                                              .copyWith(color: Colors.white)),
                                    ),
                                  ],
                                )
                              ],
                            ),
                          ),
                         state.isLoading ? Container(
                           height: size.width * 0.85,
                           child: Column(
                             mainAxisAlignment: MainAxisAlignment.center,
                             children: [
                               SizedBox(
                                 height: size.height/20,
                                 width: size.height/20,
                                 child: CircularProgressIndicator(
                                   color: theme.cardColor,
                                 ),
                               ),
                             ],
                           ),
                         ) : Container(
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
                                      image: state.profile.photo == "" ? AssetImage('assets/test_images/test1.jpeg') : MemoryImage(base64Decode(state.profile.photo)),
                                      fit: BoxFit.cover)),
                            ),
                          ),
                          Container(
                            padding: EdgeInsets.symmetric(horizontal: size.width * 0.1),
                            height: size.height / 8,
                            child: Text(
                              state.profile.description,
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
                                    Navigator.of(context).push(SlideAnimationRoute(ProfileEventsScreen()));
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
                          ),
                        ],
                      ),
                    ),
                    TestGrid(),
                    Text('Последние пройденные\nтесты', style: theme.textTheme.titleLarge),
                    Container(height: size.height/20),
                    LastTests()
                  ],
                )
              ],
            ),
          ),
        );
  },
);
    }
  ),
);
  }
}
