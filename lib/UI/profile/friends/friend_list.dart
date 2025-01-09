import 'package:comeet/UI/animation/animation_one.dart';
import 'package:comeet/bloc/friends/friend_bloc.dart';
import 'package:comeet/models/users/friend_model.dart';
import 'package:comeet/request_constant/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../bloc/card/card_bloc.dart';
import '../../user_card/user_card.dart';

class FriendList extends StatelessWidget {
  FriendList({super.key});

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    var theme = Theme.of(context);

    return Builder(builder: (context) {
      return BlocBuilder<FriendBloc, FriendState>(
        builder: (context, state) {
          return Container(
            width: size.width,
            height: size.height / 6 + size.height / 15,
            child: state.friends.length == 0
                ? Center(
                    child: Container(
                        width: size.width * 0.8,
                        child: Center(
                            child: Text(
                          'Вы пока не добавили\nни одного друга',
                          style: theme.textTheme.titleSmall!
                              .copyWith(color: bottomNavigationColorDark),
                          textAlign: TextAlign.center,
                        ))))
                : ListView(
                    scrollDirection: Axis.horizontal,
                    children: List.generate(
                        state.friends.length,
                        (index) => InkWell(
                          onTap: (){
                            Navigator.of(context).push(SlideAnimationRoute(
                              BlocProvider.value(
                                  value:
                                  BlocProvider.of<FriendBloc>(context),
                                  child: BlocProvider.value(
                                      value: BlocProvider.of<CardBloc>(
                                          context),
                                      child: UserCardScreen(
                                          state.friends[index]))),
                            ));

                          },
                          child: Container(
                                padding: EdgeInsets.all(size.height / 100),
                                child: Column(
                                  children: [
                                    Container(
                                      height: size.height / 6,
                                      width: size.height / 6,
                                      decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(20),
                                          image: DecorationImage(
                                              image: AssetImage(
                                                  state.friends[index].photo),
                                              fit: BoxFit.cover)),
                                    ),
                                    Center(
                                      child: Container(
                                        width: size.height / 6,
                                        child: Text(
                                          maxLines: 2,
                                          state.friends[index].name, style: theme.textTheme.labelLarge,
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                              ),
                        ))),
          );
        },
      );
    });
  }
}
