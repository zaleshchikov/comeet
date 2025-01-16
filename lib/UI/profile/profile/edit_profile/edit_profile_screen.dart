import 'dart:convert';

import 'package:comeet/UI/animation/animation_one.dart';
import 'package:comeet/UI/navigation/botoom_navigation.dart';
import 'package:comeet/UI/profile/friends/friend_screen.dart';
import 'package:comeet/UI/profile/profile/profile_back.dart';
import 'package:comeet/UI/profile/profile/test_grid/test_grid.dart';
import 'package:comeet/bloc/profile/profile_bloc.dart';
import 'package:comeet/models/users/user_model.dart';
import 'package:comeet/request_constant/cached_image.dart';
import 'package:comeet/request_constant/colors.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:reactive_forms/reactive_forms.dart';

import '../../../../bloc/profile/edit_profile_form.dart';
import '../profile_screen.dart';

class EditProfileSCreen extends StatefulWidget {
  User profile;

  EditProfileSCreen(this.profile);

  @override
  State<EditProfileSCreen> createState() => _EditProfileSCreenState();
}

class _EditProfileSCreenState extends State<EditProfileSCreen> {
  late final form;
  var imageBytes;

  @override
  void initState() {
    super.initState();
    form = FormGroup({
      'name': FormControl<String>(
          validators: [Validators.required], value: widget.profile.name),
      'profession': FormControl<String>(
          validators: [Validators.required], value: widget.profile.profession),
      'description': FormControl<String>(
          validators: [Validators.required], value: widget.profile.description),
    });
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    var theme = Theme.of(context);

    return BlocProvider(
      create: (context) => ProfileBloc(),
      child: Builder(builder: (context) {
        return BlocListener<ProfileBloc, ProfileState>(
          listener: (context, state) {
            if (state.isSuccessRequest) {
              Navigator.of(context).push(
                  SlideAnimationRoute(BottomNavigationScreen(ProfileScreen())));
            }
          },
          child: BlocBuilder<ProfileBloc, ProfileState>(
            builder: (context, state) {
              return Material(
                child: Scaffold(
                  resizeToAvoidBottomInset: true,
                  body: SingleChildScrollView(
                    child: ReactiveForm(
                      formGroup: this.form,
                      child: Container(
                        height: size.height,
                        child: Stack(
                          children: [
                            ProfileBack(),
                            Column(
                              children: [
                                Container(
                                  height: size.height,
                                  width: size.width,
                                  child: Column(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    children: [
                                      Container(
                                        height: size.height / 30,
                                      ),
                                      Container(
                                        width: size.width * 0.85,
                                        child: Row(
                                          children: [
                                            Column(
                                              children: [
                                                Container(
                                                    width: size.width * 0.8,
                                                    child: ReactiveTextField(
                                                      validationMessages: {
                                                        ValidationMessage
                                                                .required:
                                                            (error) =>
                                                                'Поле не может быть пустым',
                                                      },
                                                      style: theme
                                                          .textTheme.titleSmall,
                                                      cursorColor: Colors.white,
                                                      formControlName: 'name',
                                                    )),
                                                //Text(widget.profile.name, style: theme.textTheme.titleSmall)),
                                                Container(
                                                    width: size.width * 0.8,
                                                    child: ReactiveTextField(
                                                      validationMessages: {
                                                        ValidationMessage
                                                                .required:
                                                            (error) =>
                                                                'Поле не может быть пустым',
                                                      },
                                                      style: theme
                                                          .textTheme.bodyLarge!
                                                          .copyWith(
                                                              color:
                                                                  Colors.white),
                                                      cursorColor: Colors.white,
                                                      formControlName:
                                                          'profession',
                                                    )),
                                              ],
                                            )
                                          ],
                                        ),
                                      ),
                                      Container(
                                        height: size.width * 0.85,
                                        width: size.width * 0.8,
                                        child: GestureDetector(
                                          onTap: () async {
                                            ImagePicker picker = ImagePicker();
                                            XFile? image =
                                                await picker.pickImage(
                                                    source: ImageSource.gallery,
                                                    imageQuality: 50);
                                            imageBytes =
                                                await image!.readAsBytes();
                                            setState(() {
                                              imageBytes = imageBytes;
                                            });
                                          },
                                          child: Container(
                                            child: Stack(
                                              children: [
                                                Center(
                                                  child: Container(
                                                    alignment: Alignment.center,
                                                    height: size.width * 0.85,
                                                    width: size.width * 0.8,
                                                    padding: EdgeInsets.all(
                                                        size.height / 100),
                                                    decoration: BoxDecoration(
                                                        color: Colors.white,
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(30)),
                                                    child: Center(
                                                      child: Container(
                                                        alignment:
                                                            Alignment.center,
                                                        decoration: BoxDecoration(
                                                            borderRadius: BorderRadius.circular(20),
                                                            image: DecorationImage(
                                                                image: imageBytes != null
                                                                    ? CacheMemoryImageProvider((Uint8List.fromList(imageBytes).length * Uint8List.fromList(imageBytes)[10] * Uint8List.fromList(imageBytes)[100] * Uint8List.fromList(imageBytes)[5]).toString(), Uint8List.fromList(imageBytes))
                                                                    : widget.profile.photo == ""
                                                                        ? AssetImage('assets/test_images/test1.jpeg')
                                                                        : MemoryImage(base64Decode(widget.profile.photo)),
                                                                fit: BoxFit.cover)),
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                                Center(
                                                  child: Container(
                                                    alignment: Alignment.center,
                                                    child: Icon(
                                                      Icons.edit,
                                                      size: size.height / 8,
                                                      color: Colors.white,
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                      ),
                                      Container(
                                          padding: EdgeInsets.symmetric(
                                              horizontal: size.width * 0.1),
                                          height: size.height / 6,
                                          child: Center(
                                            child: ReactiveTextField(
                                              textAlign: TextAlign.start,
                                              validationMessages: {
                                                ValidationMessage.required:
                                                    (error) =>
                                                        'Поле не может быть пустым',
                                              },
                                              style: theme.textTheme.bodyLarge!
                                                  .copyWith(
                                                      color: Color(0xff8993A6),
                                                      height: 0.9),
                                              cursorColor:
                                                  bottomNavigationColorDark,
                                              maxLines: 4,
                                              formControlName: 'description',
                                            ),
                                          )),
                                      ReactiveFormConsumer(
                                          builder: (context, form, child) {
                                        return Center(
                                          child: GestureDetector(
                                            onTap: () {
                                              if (form.valid) {
                                                BlocProvider.of<ProfileBloc>(
                                                        context)
                                                    .add(UpdateProfile(
                                                        form
                                                            .control('name')
                                                            .value,
                                                        form
                                                            .control(
                                                                'profession')
                                                            .value,
                                                        form
                                                            .control(
                                                                'description')
                                                            .value,
                                                        widget.profile.photo ==
                                                                    "" &&
                                                                imageBytes ==
                                                                    null
                                                            ? ''
                                                            : imageBytes == null
                                                                ? widget.profile
                                                                    .photo
                                                                : base64Encode(
                                                                    imageBytes)));
                                              } else {
                                                form
                                                    .control('name')
                                                    .markAllAsTouched();
                                                form
                                                    .control('profession')
                                                    .markAllAsTouched();
                                                form
                                                    .control('description')
                                                    .markAllAsTouched();
                                              }
                                            },
                                            child: Container(
                                              height: size.height / 10,
                                              width: size.width * 0.8,
                                              decoration: BoxDecoration(
                                                  border: Border.all(
                                                      color: Colors.black),
                                                  borderRadius:
                                                      BorderRadius.circular(50),
                                                  color: theme.cardColor),
                                              child: state.isLoading
                                                  ? Column(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .center,
                                                      children: [
                                                        SizedBox(
                                                          height:
                                                              size.height / 20,
                                                          width:
                                                              size.height / 20,
                                                          child:
                                                              CircularProgressIndicator(
                                                            color: theme
                                                                .textTheme
                                                                .titleSmall!
                                                                .color,
                                                          ),
                                                        ),
                                                      ],
                                                    )
                                                  : Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .center,
                                                      children: [
                                                        Center(
                                                          child: Text(
                                                            'Редактировать',
                                                            style: theme
                                                                .textTheme
                                                                .titleSmall!
                                                                .copyWith(
                                                                    color: Colors
                                                                        .white),
                                                          ),
                                                        ),
                                                        Container(
                                                            width: size.width /
                                                                20),
                                                        Container(
                                                          height:
                                                              size.height / 20,
                                                          width:
                                                              size.height / 20,
                                                          child: Image.asset(
                                                            'assets/icons/edit.png',
                                                            fit: BoxFit.contain,
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                            ),
                                          ),
                                        );
                                      }),
                                      Container(
                                        height: size.height / 10,
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              );
            },
          ),
        );
      }),
    );
  }
}
