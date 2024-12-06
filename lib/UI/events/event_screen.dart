import 'package:comeet/UI/events/event_back.dart';
import 'package:comeet/UI/events/event_card.dart';
import 'package:comeet/request_constant/colors.dart';
import 'package:flutter/material.dart';
import 'package:reactive_forms/reactive_forms.dart';

class EventsScreen extends StatelessWidget {
  const EventsScreen({super.key});

  static final form = FormGroup({
    'text': FormControl<String>(validators: [Validators.required]),
  });

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    var theme = Theme.of(context);
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
                Container(height: size.height / 10),
                Container(
                  width: size.width * 0.9,
                  height: size.height / 15,
                  child: ReactiveTextField(
                    style: theme.textTheme.bodySmall,
                    cursorColor: theme.textTheme.bodySmall!.color,
                    decoration: InputDecoration(
                        suffixIcon: Icon(Icons.search, size: size.height / 20),
                        filled: true,
                        fillColor: Colors.white,
                        enabledBorder: OutlineInputBorder(
                            borderSide:
                                BorderSide(width: 2, color: Colors.black),
                            borderRadius: BorderRadius.circular(40)),
                        focusedBorder: OutlineInputBorder(
                            borderSide:
                                BorderSide(width: 2, color: Colors.black),
                            borderRadius: BorderRadius.circular(40)),
                        focusColor: Colors.black),
                    formControlName: 'text',
                  ),
                ),
                Container(
                  padding: EdgeInsets.only(left: size.width*0.1),
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
                EventCards(),
                Container(height: size.height / 100)
              ],
            )
          ],
        ),
      ),
    );
  }
}
