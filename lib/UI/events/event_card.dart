import 'dart:convert';

import 'package:bottom_sheet/bottom_sheet.dart';
import 'package:comeet/UI/events/event_bottom_sheet.dart';
import 'package:comeet/models/events/event_model.dart';
import 'package:flutter/material.dart';

import '../../../models/users/friend_model.dart';
import '../../../request_constant/colors.dart';

class EventCards extends StatefulWidget {

  List<Event> events;

  EventCards(this.events);

  @override
  State<EventCards> createState() => _EventCardsState();
}

class _EventCardsState extends State<EventCards> {


  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    var size = MediaQuery.of(context).size;

    return Container(
        height: size.height / 2,
        width: size.width,
        child: ListView.builder(
            padding: EdgeInsets.zero,
            itemCount: widget.events.length,
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
                    width: size.width,
                    padding: EdgeInsets.only(
                        bottom: size.height / 50,
                        right: size.width * 0.07,
                        left: size.width * 0.07),
                    child: Container(
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(40),
                          color: widget.events[index].color),
                      padding: EdgeInsets.all(size.height / 200),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          widget.events[index].photo == ""
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
                                              MemoryImage(base64Decode(widget.events[index].photo)),
                                          fit: BoxFit.cover)),
                                ),
                          Container(
                            width: size.width / 3,
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
                                      child: Text(widget.events[index].name,
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
                                        width: size.width / 3,
                                        child: Text(
                                          widget.events[index].description,
                                          overflow: TextOverflow.fade,
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
                                widget.events[index].isLiked = !widget.events[index].isLiked;
                              });
                            },
                            child: Container(
                              width: size.width / 10,
                              child: Center(
                                child: widget.events[index].isLiked
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
