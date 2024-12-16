import 'package:comeet/bloc/card/card_bloc.dart';
import 'package:comeet/bloc/friends/friend_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../models/users/friend_model.dart';
import '../../../models/users/user_model.dart';
import '../../../request_constant/colors.dart';

class FriendsCards extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    var size = MediaQuery.of(context).size;

    return BlocBuilder<CardBloc, CardState>(
      builder: (context, state) {
        return state.isLoading
            ? Container(
                height: size.height / 2,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(
                      height: size.height / 20,
                      width: size.height / 20,
                      child: CircularProgressIndicator(
                        color: theme.cardColor,
                      ),
                    ),
                  ],
                ),
              )
            : Container(
                height: size.height / 2,
                width: size.width,
                child: ListView.builder(
                    padding: EdgeInsets.zero,
                    itemCount: state.cards.length,
                    itemBuilder: (context, index) => Container(
                          height: size.height / 6,
                          width: size.width * 0.8,
                          padding: EdgeInsets.only(
                              bottom: size.height / 50,
                              right: size.width * 0.07,
                              left: size.width * 0.07),
                          child: Container(
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(40),
                                color: state.cards[index].color),
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
                                          image: AssetImage(
                                              state.cards[index].photo),
                                          fit: BoxFit.cover)),
                                ),
                                Container(
                                  width: size.width / 4,
                                  padding: EdgeInsets.symmetric(
                                      vertical: size.height / 100),
                                  child: Column(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    children: [
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Container(
                                            width: size.width / 4,
                                            child: Text(state.cards[index].name,
                                                textAlign: TextAlign.center,
                                                style: theme
                                                    .textTheme.bodyMedium!
                                                    .copyWith(
                                                        fontWeight:
                                                            FontWeight.w700)),
                                          ),
                                        ],
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Container(
                                              width: size.width / 4,
                                              child: Text(
                                                state.cards[index].profession,
                                                textAlign: TextAlign.center,
                                                style: theme
                                                    .textTheme.labelMedium!
                                                    .copyWith(
                                                        color:
                                                            bottomNavigationColorDark),
                                              )),
                                        ],
                                      )
                                    ],
                                  ),
                                ),
                                InkWell(
                                  onTap: () {
                                    BlocProvider.of<FriendBloc>(context)
                                            .state
                                            .friends
                                            .contains(state.cards[index])
                                        ? BlocProvider.of<CardBloc>(context)
                                            .add(DeleteFriend(
                                                state.cards[index].id))
                                        : BlocProvider.of<CardBloc>(context)
                                            .add(AddFriend(
                                                state.cards[index].id));
                                  },
                                  child: Container(
                                    width: size.width / 5,
                                    child: Center(
                                      child:
                                          BlocProvider.of<FriendBloc>(context)
                                                  .state
                                                  .friends
                                                  .contains(state.cards[index])
                                              ? Icon(Icons.check)
                                              : Icon(Icons.add),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        )));
      },
    );
  }
}
