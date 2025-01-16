import 'dart:convert';

import 'package:comeet/bloc/event/event_bloc.dart';
import 'package:comeet/request_constant/cached_image.dart';
import 'package:comeet/request_constant/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:reactive_forms/reactive_forms.dart';

import '../../models/events/event_model.dart';
import '../profile/profile/profile_screen.dart';

class AddEventBottomSheet extends StatefulWidget {
  @override
  State<AddEventBottomSheet> createState() => _AddEventBottomSheetState();
}

class _AddEventBottomSheetState extends State<AddEventBottomSheet> {
  var imageBytes;
  Event event = Event('', '', '', DateTime.now(), DateTime.now(), true, [], '',
      getRandomColor());
  final form = FormGroup({
    'name': FormControl<String>(validators: [Validators.required]),
    'description': FormControl<String>(),
  });
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    var theme = Theme.of(context);


    return BlocBuilder<EventBloc, EventState>(
      builder: (context, state) {
        return BlocListener<EventBloc, EventState>(
          listener: (context, state) {
            if (state.successRequest) {
              Navigator.of(context).pop();
            }
          },
          child: DraggableScrollableSheet(
              snapAnimationDuration: Duration(seconds: 4),
              initialChildSize: 0.5,
              maxChildSize: 1,
              builder: (context, _) {
                return Scaffold(
                  backgroundColor: Colors.transparent,
                  resizeToAvoidBottomInset: true,
                  body: ReactiveForm(
                    formGroup: form,
                    child: Container(
                      width: size.width,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.only(
                            topRight: Radius.circular(20),
                            topLeft: Radius.circular(20)),
                        color: event.color,
                      ),
                      padding: EdgeInsets.zero,
                      height: size.height,
                      child: SingleChildScrollView(
                        controller: _,
                        child: Column(
                          children: [
                            Center(
                              child: Container(
                                margin: EdgeInsets.symmetric(
                                    vertical: size.height / 100),
                                height: size.height / 40,
                                width: size.width * 0.2,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(20),
                                    color: bottomNavigationColorDark),
                                foregroundDecoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(20),
                                    color: bottomNavigationColorDark),
                              ),
                            ),
                            Container(
                              padding: EdgeInsets.symmetric(
                                  horizontal: size.width / 20),
                              child: Row(
                                children: [
                                  Text(
                                    'Добавьте\nфотографию',
                                    style: theme.textTheme.titleLarge!.copyWith(
                                        color: bottomNavigationColorDark),
                                  ),
                                ],
                              ),
                            ),
                            GestureDetector(
                              onTap: () async {
                                ImagePicker picker = ImagePicker();
                                XFile? image = await picker.pickImage(
                                    source: ImageSource.gallery,
                                    imageQuality: 50);
                                imageBytes = await image!.readAsBytes();
                                event.photo = base64Encode(imageBytes);
                                setState(() {
                                  imageBytes = imageBytes;
                                });
                              },
                              child: Container(
                                margin: EdgeInsets.all(size.height / 50),
                                height: size.height / 2,
                                width: size.width * 0.8,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(30),
                                    image: DecorationImage(
                                        image: imageBytes == null
                                            ? AssetImage(
                                                'assets/icons/add_event.png')
                                            : CacheMemoryImageProvider((Uint8List.fromList(imageBytes).length*Uint8List.fromList(imageBytes)[0]*Uint8List.fromList(imageBytes)[110]).toString(),
                                                Uint8List.fromList(imageBytes)),
                                        fit: BoxFit.cover)),
                              ),
                            ),
                            Container(
                              padding: EdgeInsets.symmetric(
                                  horizontal: size.width / 20),
                              child: Row(
                                children: [
                                  Text(
                                    'Укажите дату\nмероприятия',
                                    style: theme.textTheme.titleLarge!.copyWith(
                                        color: bottomNavigationColorDark),
                                  ),
                                ],
                              ),
                            ),
                            Container(height: size.height / 30),
                            Center(
                              child: Container(
                                height: size.height / 15,
                                width: size.width * 0.8,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(20),
                                    color: bottomNavigationColorDark),
                                child: Row(
                                  children: [
                                    Container(
                                      height: size.height / 15,
                                      width: size.width * 0.4,
                                      decoration: const BoxDecoration(
                                        borderRadius: BorderRadius.only(
                                            bottomLeft: Radius.circular(20.0),
                                            topLeft: Radius.circular(20.0)),
                                        color: Colors.white,
                                      ),
                                      padding:
                                          EdgeInsets.all(size.height / 200),
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Text('Запланированно:',
                                              style: theme.textTheme.labelLarge)
                                        ],
                                      ),
                                    ),
                                    Container(
                                      padding:
                                          EdgeInsets.all(size.height / 200),
                                      height: size.height / 15,
                                      width: size.width * 0.4,
                                      decoration: BoxDecoration(
                                        borderRadius: const BorderRadius.only(
                                            bottomRight: Radius.circular(20.0),
                                            topRight: Radius.circular(20.0)),
                                        color: bottomNavigationColorDark,
                                      ),
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Text(
                                              '${event.dateStart.day.toString().padLeft(2, '0')}.${event.dateStart.month.toString().padLeft(2, '0')}',
                                              style: theme.textTheme.labelLarge!
                                                  .copyWith(
                                                      color: Colors.white))
                                        ],
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            ),
                            Center(
                              child: Container(
                                padding: EdgeInsets.all(size.height / 50),
                                width: size.width,
                                height: size.height / 3,
                                child: GridView(
                                    physics: NeverScrollableScrollPhysics(),
                                    gridDelegate:
                                        SliverGridDelegateWithFixedCrossAxisCount(
                                      crossAxisCount: 7,
                                    ),
                                    children: List<Widget>.generate(
                                        DateTime(event.dateStart.year,
                                                event.dateStart.month + 1, 0)
                                            .day,
                                        (int index) => GestureDetector(
                                              onTap: () {
                                                event.dateStart = event
                                                    .dateStart
                                                    .copyWith(day: index + 1);
                                                print(event.dateStart.day);
                                                setState(() {});
                                              },
                                              child: Container(
                                                height: size.width / 12,
                                                width: size.width / 12,
                                                margin: EdgeInsets.all(
                                                    size.height / 200),
                                                decoration: BoxDecoration(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            12),
                                                    color: index ==
                                                            (event.dateStart
                                                                    .day -
                                                                1)
                                                        ? bottomNavigationColorDark
                                                        : Colors.white),
                                                child: Center(
                                                  child: GestureDetector(
                                                    onTap: () {
                                                      event.dateStart = event
                                                          .dateStart
                                                          .copyWith(
                                                              day: index + 1);
                                                      print(
                                                          event.dateStart.day);
                                                      setState(() {});
                                                    },
                                                    child: Text(
                                                      '${index + 1}',
                                                      style: theme
                                                          .textTheme.labelLarge!
                                                          .copyWith(
                                                              color: index !=
                                                                      (event.dateStart
                                                                              .day -
                                                                          1)
                                                                  ? bottomNavigationColorDark
                                                                  : Colors
                                                                      .white),
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ))),
                              ),
                            ),
                            Container(
                              padding: EdgeInsets.symmetric(
                                  horizontal: size.width / 20),
                              child: Row(
                                children: [
                                  Text(
                                    'Добавьте название\nи описание',
                                    style: theme.textTheme.titleLarge!.copyWith(
                                        color: bottomNavigationColorDark),
                                  ),
                                ],
                              ),
                            ),
                            Container(height: size.height / 50),
                            Container(
                              height: size.height / 10,
                              width: size.width * 0.9,
                              padding: EdgeInsets.all(size.height / 100),
                              child: ReactiveTextField(
                                validationMessages: {
                                  ValidationMessage.required: (error) =>
                                      'Что-то тут явно не так',
                                },
                                style: theme.textTheme.bodySmall,
                                cursorColor: theme.textTheme.bodySmall!.color,
                                decoration: InputDecoration(
                                  label: Row(
                                    children: [
                                      Container(width: 20),
                                      Text('Название'),
                                    ],
                                  ),
                                  labelStyle:
                                      theme.textTheme.bodySmall!.copyWith(),
                                  filled: true,
                                  fillColor: Colors.white,
                                  border: OutlineInputBorder(
                                      borderSide: BorderSide.none,
                                      borderRadius: BorderRadius.circular(20)),
                                ),
                                onChanged: (_) {
                                  setState(() {
                                    event.name = form.control('name').value ?? '';
                                  });
                                },
                                formControlName: 'name',
                              ),
                            ),
                            Container(
                              height: size.height / 10,
                              width: size.width * 0.9,
                              padding: EdgeInsets.all(size.height / 100),
                              child: ReactiveTextField(
                                onChanged: (_) {
                                  setState(() {
                                    event.description =
                                        form.control('description').value ?? '';
                                  });
                                },
                                style: theme.textTheme.bodySmall,
                                cursorColor: theme.textTheme.bodySmall!.color,
                                decoration: InputDecoration(
                                  label: Row(
                                    children: [
                                      Container(width: 20),
                                      Text('Описание'),
                                    ],
                                  ),
                                  labelStyle:
                                      theme.textTheme.bodySmall!.copyWith(),
                                  filled: true,
                                  fillColor: Colors.white,
                                  border: OutlineInputBorder(
                                      borderSide: BorderSide.none,
                                      borderRadius: BorderRadius.circular(20)),
                                ),
                                formControlName: 'description',
                              ),
                            ),
                            ReactiveFormConsumer(
                                builder: (context, form, child) {
                              return GestureDetector(
                                onTap: () {
                                  if(form.control('name').valid) {
                                    event.name = form
                                        .control('name')
                                        .value ?? '';
                                    event.description =
                                        form
                                            .control('description')
                                            .value ?? '';


                                    BlocProvider.of<EventBloc>(context)
                                        .add(AddEvent(event));
                                  } else{
                                    form.markAllAsTouched();
                                  }
    },
                                child: Center(
                                  child: Container(
                                    decoration: BoxDecoration(
                                        color: bottomNavigationColorDark,
                                        borderRadius:
                                            BorderRadius.circular(20)),
                                    height: size.height / 15,
                                    width: size.width * 0.7,
                                    child: Center(
                                      child: state.isLoading
                                          ? CircularProgressIndicator(
                                              color: Colors.white,
                                            )
                                          : Text(
                                              'Добавить',
                                              style: theme.textTheme.titleSmall,
                                            ),
                                    ),
                                  ),
                                ),
                              );
                            }),
                            Container(height: size.height / 20),
                          ],
                        ),
                      ),
                    ),
                  ),
                );
              }),
        );
      },
    );
  }
}
