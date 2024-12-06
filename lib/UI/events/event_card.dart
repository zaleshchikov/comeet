import 'package:bottom_sheet/bottom_sheet.dart';
import 'package:comeet/UI/events/event_bottom_sheet.dart';
import 'package:comeet/models/events/event_model.dart';
import 'package:flutter/material.dart';

import '../../../models/users/friend_model.dart';
import '../../../request_constant/colors.dart';

class EventCards extends StatefulWidget {
  @override
  State<EventCards> createState() => _EventCardsState();
}

class _EventCardsState extends State<EventCards> {
  var events = [
    Event('Рыбалка', 'собираемся  с ребятами расслабиться и поймать рыбку',
        DateTime.now(), false, [], 'assets/test_images/test1.jpeg', colorBlue),
    Event('Рыбалка', 'собираемся  с ребятами расслабиться и поймать рыбку',
        DateTime.now(), false, [], '', colorPink),
    Event('Рыбалка', 'собираемся  с ребятами расслабиться и поймать рыбку',
        DateTime.now(), false, [], 'assets/test_images/test1.jpeg', greenColor),
  ];

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    var size = MediaQuery.of(context).size;

    return Container(
        height: size.height / 1.5,
        width: size.width,
        child: ListView.builder(
            padding: EdgeInsets.zero,
            itemCount: events.length,
            itemBuilder: (context, index) => InkWell(
                  onTap: () {
                    showBottomSheet(
                      shape: CircleBorder(),
                      backgroundColor: Colors.transparent,
                      context: context,
                      builder: (
                          context
                          ) => EventBottomSheet(),
                    );
                  },
                  child: Container(
                    height: size.height / 6,
                    width: size.width * 0.8,
                    padding: EdgeInsets.only(
                        bottom: size.height / 50,
                        right: size.width * 0.07,
                        left: size.width * 0.07),
                    child: Container(
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(40),
                          color: events[index].color),
                      padding: EdgeInsets.all(size.height / 200),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          events[index].photo == ""
                              ? Container(
                                  height: size.width / 4,
                                  width: size.width / 4,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(20),
                                      color: emptyPhotoColor.withOpacity(0.35),
                                      border: Border.all(
                                          color:
                                              emptyPhotoColor.withOpacity(0.7),
                                          width: 2)),
                                )
                              : Container(
                                  height: size.width / 4,
                                  width: size.width / 4,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(20),
                                      image: DecorationImage(
                                          image:
                                              AssetImage(events[index].photo),
                                          fit: BoxFit.cover)),
                                ),
                          Container(
                            width: size.width / 4,
                            padding: EdgeInsets.symmetric(
                                vertical: size.height / 100),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Container(
                                      width: size.width / 4,
                                      child: Text(events[index].name,
                                          textAlign: TextAlign.center,
                                          style: theme.textTheme.bodyMedium!
                                              .copyWith(
                                                  fontWeight: FontWeight.w700)),
                                    ),
                                  ],
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Container(
                                        width: size.width / 4,
                                        child: Text(
                                          events[index].description,
                                          textAlign: TextAlign.left,
                                          style: theme.textTheme.labelMedium!
                                              .copyWith(
                                                  color:
                                                      bottomNavigationColorDark),
                                        )),
                                  ],
                                )
                              ],
                            ),
                          ),
                          InkWell(
                            onTap: () {
                              setState(() {
                                events[index].isLiked = !events[index].isLiked;
                              });
                            },
                            child: Container(
                              width: size.width / 5,
                              child: Center(
                                child: events[index].isLiked
                                    ? Icon(Icons.favorite,
                                        color: colorPinkTitle)
                                    : Icon(Icons.favorite_border_outlined,
                                        color: bottomNavigationColorDark
                                            .withOpacity(0.5)),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                )));
  }
}
