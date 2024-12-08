import 'package:comeet/UI/profile/friends/friend_list.dart';
import 'package:comeet/UI/profile/friends/friends_card.dart';
import 'package:comeet/request_constant/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:reactive_forms/reactive_forms.dart';

import '../../../bloc/card/card_bloc.dart';
import '../events/profile_events_back.dart';

class FriendScreen extends StatelessWidget {
  static final form = FormGroup({
    'text': FormControl<String>(validators: [Validators.required]),
  });
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    var theme = Theme.of(context);

    return BlocProvider(
        create: (context) => CardBloc()..add(GetCards()),
        child: Builder(
        builder: (context) {
      return BlocBuilder<CardBloc, CardState>(
          builder: (context, state) {
        return Scaffold(
      resizeToAvoidBottomInset: false,
        body: Container(
          height: size.height,
          width: size.width,
          child: ReactiveForm(
            formGroup: form,
            child: Stack(
              children: [
                ProfileEventBack(),
                Container(
                  height: size.height,
                  width: size.width,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Container(
                        height: size.height / 20,
                      ),
                      Container(
                        width: size.width * 0.8,
                        child: Row(
                          children: [
                            Container(
                                width: size.width * 0.8,
                                child: Text('Друзья:', style: theme.textTheme.titleSmall!.copyWith(color: theme.cardColor))),
                          ],
                        ),
                      ),
                       FriendList(),
                      Container(
                        width: size.width*0.9,
                        height: size.height/15,
                        child: ReactiveTextField(
                          onChanged: (_){
                            BlocProvider.of<CardBloc>(context).add(SearchCard(form.control('text').value ?? ''));
                          },
                          style: theme.textTheme.bodySmall,
                          cursorColor: theme.textTheme.bodySmall!.color,
                          decoration: InputDecoration(
                            suffixIcon: Icon(Icons.search, size: size.height/20),
                            filled: true,
                            fillColor: Colors.white,
                            enabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(width: 3, color: Colors.black),
                                borderRadius: BorderRadius.circular(40)),
                            focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(width: 3, color: Colors.black),
                                borderRadius: BorderRadius.circular(40)),
                            focusColor: Colors.black
                          ),
                          formControlName: 'text',
                        ),
                      ),
                      state.isLoading ? Container(
                        height: size.height / 2,
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
                      ) : FriendsCards(state.cards),
                      Container(
                        height: size.height / 15,
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        ));
  });}));
}}
