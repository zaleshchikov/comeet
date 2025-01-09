import 'package:comeet/UI/user_card/card_progress_containers.dart';
import 'package:comeet/bloc/friends/friend_bloc.dart';
import 'package:comeet/bloc/recommended_users/recommended_users_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../models/users/friend_model.dart';
import '../../models/users/user_model.dart';

class CardInfo extends StatelessWidget {

  User card;

  CardInfo(this.card);


  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    var theme = Theme.of(context);

    return BlocBuilder<RecommendedUsersBloc, RecommendedUsersState>(
  builder: (context, state) {
    return BlocBuilder<FriendBloc, FriendState>(
  builder: (context, fstate) {
    return Container(
      padding: EdgeInsets.all(size.height/50),
      height: size.height/2.3,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Text(textAlign: TextAlign.left, card.name, style: theme.textTheme.titleSmall!.copyWith(color: Colors.white)),

          Text(textAlign: TextAlign.center, card.description, style: theme.textTheme.bodyLarge!.copyWith(color: Colors.white)),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Container(
                  height: size.height/15,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  CardProgressContainers(60),
                  Text('тестов пройдено', style: theme.textTheme.labelMedium,)
                ],
              )),
              Container(
                  height: size.height/15,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      CardProgressContainers(18),
                      Text('меро посещено', style: theme.textTheme.labelMedium,)
                    ],
                  )),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              InkWell(
                onTap: (){
                  fstate.friends
                      .map((e) => e.id)
                      .contains(card.id)
                      ? BlocProvider.of<FriendBloc>(
                      context)
                      .add(DeleteFriend(
                      Friend.friendFromUser(
                          card)))
                      : BlocProvider.of<FriendBloc>(
                      context)
                      .add(AddFriend(
                      Friend.friendFromUser(
                          card)));
                },
                child: Container(
                  height: size.height/15,
                  width: size.height/15,
                  decoration: BoxDecoration(
                    color: Colors.transparent,
                    border: Border.all(color: Colors.white, width: 3),
                    shape: BoxShape.circle
                  ),
                  child: Icon(fstate.friends
                      .map((e) => e.id)
                      .contains(
                      card.id) ? Icons.check : Icons.add, color: Colors.white, size: size.height/20,),
                ),
              ),
              Container(
                height: size.height/15,
                width: size.height/15,
                decoration: BoxDecoration(
                    color: Colors.transparent,
                    border: Border.all(color: Color(0xffF1A39B), width: 3),
                    shape: BoxShape.circle
                ),
                child: Center(
                  child: ImageIcon(AssetImage('assets/icons/heart.png'), size: size.height/30, color: Color(0xffF1A39B),),
                ),
              ),
            ],
          )
        ],
      ),
    );
  },
);
  },
);
  }
}
