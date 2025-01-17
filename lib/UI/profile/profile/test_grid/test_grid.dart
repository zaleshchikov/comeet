import 'package:comeet/UI/profile/profile/test_grid/test_container.dart';
import 'package:comeet/bloc/tag/tag_bloc.dart';
import 'package:comeet/request_constant/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class TestGrid extends StatelessWidget {
  const TestGrid({super.key});

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery
        .of(context)
        .size;


    return BlocProvider(
      create: (context) =>
      TagBloc()
        ..add(GetAllTags()),
      child: Builder(
          builder: (context) {
            return BlocBuilder<TagBloc, TagState>(
              builder: (context, state) {
                var tagsNames = state.userTags.map((e) => e.name).toList();
                return Container(
                  height: size.height / 1.8,
                  width: size.width * 0.95,
                  padding: EdgeInsets.all(size.height / 40),
                  child: Stack(
                    children: [
                      Container(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            TestContainer(color: colorPink, text: tagsNames.contains('old') ? '${tagsNames.where((e) => e.contains('old')).first.split(' ')[1]} лет' : ''),
                            TestContainer(color: orangeColor, text: tagsNames.contains('height') ? '${tagsNames.where((e) => e.contains('height')).first.split(' ')[1]} см' : ''),
                            TestContainer(color: greenColor, text: tagsNames.contains('experience') ? '${tagsNames.where((e) => e.contains('experience')).first.split(' ')[1]} лет' : '')
                          ],
                        ),
                      ),
                      Container(
                        height: size.width / 4 + size.height / 10,
                        padding: EdgeInsets.only(top: size.height / 10),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Container(width: size.width / 15),
                            TestContainer(color: profileBackBottomColor),
                            TestContainer(color: colorPink),
                            Container(width: size.width / 15),
                          ],
                        ),
                      ),
                      Container(
                        height: size.width / 4 * 2 + size.height / 11,
                        padding: EdgeInsets.only(
                            top: size.height / 11 + size.width / 4),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            TestContainer(color: orangeColor),
                            TestContainer(color: greenColor),
                            TestContainer(color: bottomNavigationColorDark)
                          ],
                        ),
                      ),
                      Container(
                        height: size.width / 4 * 3 + size.height / 12,
                        padding: EdgeInsets.only(
                            top: size.height / 12 + size.width / 4 * 2),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Container(width: size.width / 15),
                            TestContainer(color: colorPink),
                            TestContainer(color: blueColor),
                            Container(width: size.width / 15),
                          ],
                        ),
                      ),
                    ],
                  ),
                );
              },
            );
          }
      ),
    );
  }
}
