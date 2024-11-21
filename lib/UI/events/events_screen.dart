import 'package:comeet/UI/events/event.dart';
import 'package:comeet/UI/events/events_back.dart';
import 'package:comeet/request_constant/colors.dart';
import 'package:flutter/material.dart';
import 'package:reactive_forms/reactive_forms.dart';

class EventsScreen extends StatelessWidget {
  static final form = FormGroup({
    'text': FormControl<String>(validators: [Validators.required]),
  });

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    var theme = Theme.of(context);

    return Scaffold(
        body: Container(
      height: size.height,
      width: size.width,
      child: ReactiveForm(
        formGroup: form,
        child: Stack(
          children: [
            EventBack(),
            ListView(
                children: List<Widget>.generate(
                    5,
                    (index) => index == 0
                        ? Container(
                            padding: EdgeInsets.only(
                                top: size.width * 0.15,
                                left: size.width * 0.1,
                                right: size.width * 0.1),
                            child: ReactiveTextField(
                              style: theme.textTheme.bodySmall,
                              cursorColor: theme.textTheme.bodySmall!.color,
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
                                labelStyle:
                                    theme.textTheme.bodySmall!.copyWith(),
                                filled: true,
                                fillColor: Colors.white,
                                border: OutlineInputBorder(
                                    borderSide: BorderSide.none,
                                    borderRadius: BorderRadius.circular(20)),
                              ),
                              formControlName: 'text',
                            ),
                          )
                        : Container(
                            padding: EdgeInsets.all(size.width * 0.1),
                            child: EventItem(
                                colorPink, colorPinkTitle, 'test name')))),
            Container(
              alignment: Alignment.topLeft,
              padding: EdgeInsets.only(
                  top: size.height / 17, left: size.height / 100),
              child: IconButton(
                icon: ImageIcon(AssetImage('assets/icons/back_icon.png'),
                    size: size.height / 20),
                onPressed: () => Navigator.of(context).pop(),
              ),
            ),
          ],
        ),
      ),
    ));
  }
}
