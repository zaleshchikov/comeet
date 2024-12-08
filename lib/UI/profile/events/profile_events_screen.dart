import 'package:comeet/bloc/event/event_bloc.dart';
import 'package:comeet/request_constant/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:reactive_forms/reactive_forms.dart';

import 'profile_event.dart';
import 'profile_events_back.dart';

class ProfileEventsScreen extends StatelessWidget {
  static final form = FormGroup({
    'text': FormControl<String>(validators: [Validators.required]),
  });

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    var theme = Theme.of(context);

    return BlocProvider(
      create: (context) => EventBloc()..add(GetMyEvent()),
      child: Builder(builder: (context) {
        return BlocBuilder<EventBloc, EventState>(
          builder: (context, state) {
            return Scaffold(
                body: Container(
              height: size.height,
              width: size.width,
              child: ReactiveForm(
                formGroup: form,
                child: Stack(
                  children: [
                    ProfileEventBack(),
                    state.events.length == 0
                        ? Container(
                      padding: EdgeInsets.all(size.height/50),
                          child: Center(
                              child: Text(
                                  'Вы пока не записались ни на одно мероприятие...', style: theme.textTheme.titleLarge, textAlign: TextAlign.center,)),
                        )
                        : ListView(
                            children: List<Widget>.generate(
                                state.events.length,
                                (index) => index == 0
                                    ? Container(
                                        padding: EdgeInsets.only(
                                            top: size.width * 0.2,
                                            left: size.width * 0.1,
                                            right: size.width * 0.1),
                                        child: ReactiveTextField(
                                          style: theme.textTheme.bodySmall,
                                          cursorColor:
                                              theme.textTheme.bodySmall!.color,
                                          decoration: InputDecoration(
                                            label: Row(
                                              children: [
                                                Container(width: 20),
                                                Text(''),
                                              ],
                                            ),
                                            suffixIcon: Icon(
                                              Icons.search,
                                              size: size.height / 20,
                                            ),
                                            labelStyle: theme
                                                .textTheme.bodySmall!
                                                .copyWith(),
                                            filled: true,
                                            fillColor: Colors.white,
                                            border: OutlineInputBorder(
                                                borderSide: BorderSide.none,
                                                borderRadius:
                                                    BorderRadius.circular(20)),
                                          ),
                                          formControlName: 'text',
                                        ),
                                      )
                                    : Container(
                                        padding:
                                            EdgeInsets.all(size.width * 0.1),
                                        child: ProfileEventItem(
                                            state.events[index].color,
                                            colorPinkTitle,
                                            state.events[index].name)))),
                    Container(
                      alignment: Alignment.topLeft,
                      padding: EdgeInsets.only(
                          top: size.height / 17, left: size.height / 100),
                      child: IconButton(
                        icon: ImageIcon(
                            AssetImage('assets/icons/back_icon.png'),
                            size: size.height / 20),
                        onPressed: () => Navigator.of(context).pop(),
                      ),
                    ),
                  ],
                ),
              ),
            ));
          },
        );
      }),
    );
  }
}
