import 'package:comeet/bloc/friends/friend_bloc.dart';
import 'package:comeet/models/users/friend_model.dart';
import 'package:comeet/request_constant/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class FriendList extends StatelessWidget {
  FriendList({super.key});

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    var theme = Theme.of(context);

    return BlocProvider(
      create: (context) => FriendBloc()..add(GetFriends()),
      child: Builder(builder: (context) {
        return BlocBuilder<FriendBloc, FriendState>(
          builder: (context, state) {
            return Container(
              width: size.width,
              height: size.height / 6 + size.height / 50,
              child: ListView(
                  scrollDirection: Axis.horizontal,
                  children: List.generate(
                      state.friends.length,
                      (index) => Container(
                            padding: EdgeInsets.all(size.height / 100),
                            child: Container(
                              height: size.height / 6,
                              width: size.height / 6,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(20),
                                  image: DecorationImage(
                                      image: AssetImage(
                                          state.friends[index].photo),
                                      fit: BoxFit.cover)),
                            ),
                          ))),
            );
          },
        );
      }),
    );
  }
}
