import 'package:comeet/UI/events/add_event_bottom_sheet.dart';
import 'package:comeet/UI/events/event_back.dart';
import 'package:comeet/UI/events/event_card.dart';
import 'package:comeet/bloc/event/event_bloc.dart';
import 'package:comeet/request_constant/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:reactive_forms/reactive_forms.dart';

import 'event_bottom_sheet.dart';

class EventsScreen extends StatelessWidget {
  const EventsScreen({super.key});

  static final form = FormGroup({
    'text': FormControl<String>(validators: [Validators.required]),
  });

  @override
  Widget build(BuildContext context1) {
    var size = MediaQuery.of(context1).size;
    var theme = Theme.of(context1);
    return BlocProvider(
        create: (context) => EventBloc()..add(GetEvents()),
        child: Builder(
          builder: (context2) {
            return Container(
              height: size.height,
              width: size.width,
              child: ReactiveForm(
                formGroup: form,
                child: Stack(
                  children: [
                    EventBack(),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Container(height: size.height / 60),
                        Container(
                          padding: EdgeInsets.only(left: size.width * 0.1),
                          child: Row(
                            children: [
                              Text(
                                'Ближайщие\nмероприятия:',
                                style: theme.textTheme.titleSmall!
                                    .copyWith(color: bottomNavigationColorDark),
                              ),
                            ],
                          ),
                        ),
                        Container(
                          width: size.width * 0.9,
                          height: size.height / 15,
                          child: ReactiveTextField(
                            style: theme.textTheme.bodySmall,
                            cursorColor: theme.textTheme.bodySmall!.color,
                            decoration: InputDecoration(
                                suffixIcon:
                                    Icon(Icons.search, size: size.height / 20),
                                filled: true,
                                fillColor: Colors.white,
                                enabledBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                        width: 2, color: Colors.black),
                                    borderRadius: BorderRadius.circular(40)),
                                focusedBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                        width: 2, color: Colors.black),
                                    borderRadius: BorderRadius.circular(40)),
                                focusColor: Colors.black),
                            formControlName: 'text',
                          ),
                        ),
                        BlocBuilder<EventBloc, EventState>(
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
                              : EventCards(state.events);
                        }),
                        InkWell(
                          onTap: () {
                            showBottomSheet(
                              enableDrag: true,
                              backgroundColor: Colors.transparent,
                              context: context2,
                              builder: (context) => BlocProvider.value(
                                  value: BlocProvider.of<EventBloc>(context2),
                                  child: AddEventBottomSheet()),
                            );
                          },
                          child: Center(
                            child: Container(
                              child: Image(
                                image: AssetImage('assets/icons/add_icon.png'),
                                height: size.height / 15,
                              ),
                            ),
                          ),
                        ),
                        Container(height: size.height / 20)
                      ],
                    )
                  ],
                ),
              ),
            );
          },
        ));
  }
}
