import 'package:comeet/UI/events/event.dart';
import 'package:comeet/UI/events/events_back.dart';
import 'package:comeet/UI/profile/friends/friend_list.dart';
import 'package:comeet/UI/profile/friends/friends_card.dart';
import 'package:comeet/request_constant/colors.dart';
import 'package:flutter/material.dart';
import 'package:reactive_forms/reactive_forms.dart';

class FriendScreen extends StatelessWidget {
  static final form = FormGroup({
    'text': FormControl<String>(validators: [Validators.required]),
  });
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    var theme = Theme.of(context);

    return Scaffold(
      resizeToAvoidBottomInset: false,
        body: Container(
          height: size.height,
          width: size.width,
          child: ReactiveForm(
            formGroup: form,
            child: Stack(
              children: [
                EventBack(),
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
                      FriendsCards(),
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
  }
}
