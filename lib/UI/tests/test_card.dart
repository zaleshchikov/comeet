import 'dart:convert';

import 'package:comeet/UI/animation/animation_one.dart';
import 'package:comeet/UI/tests/start_test/start_test_start_screen.dart';
import 'package:comeet/bloc/test/test/test_bloc.dart';
import 'package:comeet/bloc/test/test_preview/test_preview_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class TestCards extends StatelessWidget {
  const TestCards({super.key});

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    var theme = Theme.of(context);

    return BlocBuilder<TestPreviewBloc, TestPreviewState>(
      builder: (context, state) {
        return Container(
            width: size.width,
            height: size.height * 0.7,
            child: ListView.builder(
                itemCount: state.testPreviews.length,
                itemBuilder: (context, index) => BlocProvider(
                      create: (context) => TestBloc(),
                      child: Builder(builder: (context) {
                        return BlocBuilder<TestBloc, TestState>(
                          builder: (context, stateTest) {
                            return InkWell(
                              onTap: () {
                                BlocProvider.of<TestBloc>(context).add(
                                    onGetTest(state.testPreviews[index].id));
                              },
                              child: BlocListener<TestBloc, TestState>(
                                listener: (context, state) {
                                  if (state.isSuccessRequest) {
                                    Navigator.of(context)
                                        .push(SlideAnimationRoute(
                                      BlocProvider.value(
                                          value: BlocProvider.of<TestBloc>(
                                              context),
                                          child: TestStartScreen()),
                                    ));
                                  }
                                },
                                child: Column(
                                  children: [
                                    Container(
                                      padding: EdgeInsets.only(
                                          bottom: size.height / 50),
                                      child: Container(
                                        height: size.height / 5,
                                        width: size.width * 0.9,
                                        decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(20),
                                            color: state
                                                .testPreviews[index].color),
                                        child: Center(
                                          child: stateTest.isLoading
                                              ? CircularProgressIndicator(
                                                  color: Colors.white)
                                              : Column(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.center,
                                                  children: [
                                                    Container(
                                                      height: size.height / 5 -
                                                          size.height / 50 * 1,
                                                      width: size.width * 0.9 -
                                                          size.height / 50 * 1,
                                                      padding: EdgeInsets.all(
                                                          size.height / 100),
                                                      decoration: BoxDecoration(
                                                        border: Border.all(
                                                            color: Colors.white,
                                                            width: 5),
                                                        color: state
                                                            .testPreviews[
                                                                index]!
                                                            .color,
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(20),
                                                      ),
                                                      child: Center(
                                                        child: Row(
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .spaceEvenly,
                                                          children: [
                                                            Container(
                                                                height:
                                                                    size.height /
                                                                        12,
                                                                width:
                                                                    size.height /
                                                                        12,
                                                                decoration: BoxDecoration(
                                                                    shape: BoxShape
                                                                        .circle,
                                                                    image: DecorationImage(
                                                                        image: state.testPreviews[index]!.image ==
                                                                                ''
                                                                            ? AssetImage('assets/test_images/test1.jpeg')
                                                                            : MemoryImage(base64Decode(state.testPreviews[index]!.image)),
                                                                        fit: BoxFit.cover))),
                                                            Column(
                                                              mainAxisAlignment:
                                                                  MainAxisAlignment
                                                                      .spaceEvenly,
                                                              children: [
                                                                Container(
                                                                  width: size.width*0.5,
                                                                  height: size.height/40,
                                                                  child: Text(
                                                                      state
                                                                          .testPreviews[
                                                                              index]!
                                                                          .label,  overflow: TextOverflow.clip,
                                                                      style: theme
                                                                          .textTheme
                                                                          .labelLarge!
                                                                          .copyWith(
                                                                              color:
                                                                                  Colors.white)),
                                                                ),
                                                                Container(
                                                                    width: size.width*0.5,
                                                                    child: Divider(color: Colors.white, height: size.height/50,)),
                                                                Container(
                                                                  width: size.width*0.5,
                                                                  height: size.height/11,

                                                                  child: Text(
                                                                      state
                                                                          .testPreviews[
                                                                              index]!
                                                                          .description,
                                                                      style: theme
                                                                          .textTheme
                                                                          .bodySmall!
                                                                          .copyWith(
                                                                              color:
                                                                                  Colors.white), overflow: TextOverflow.clip,),
                                                                )
                                                              ],
                                                            )
                                                          ],
                                                        ),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            );
                          },
                        );
                      }),
                    )));
      },
    );
  }
}
