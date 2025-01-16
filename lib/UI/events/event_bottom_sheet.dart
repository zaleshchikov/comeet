import 'dart:convert';

import 'package:comeet/bloc/event/event_bloc.dart';
import 'package:comeet/request_constant/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../models/events/event_model.dart';

class EventBottomSheet extends StatefulWidget {
  Event event;

  EventBottomSheet(this.event);

  @override
  State<EventBottomSheet> createState() => _EventBottomSheetState();
}

class _EventBottomSheetState extends State<EventBottomSheet> {
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    var theme = Theme.of(context);
    return DraggableScrollableSheet(
        snapAnimationDuration: Duration(seconds: 4),
        initialChildSize: 0.5,
        maxChildSize: 0.55,
        builder: (context, _) {
          return Container(
            width: size.width,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              color: widget.event.color,
            ),
            padding: EdgeInsets.zero,
            height: size.height / 2,
            child: SingleChildScrollView(
              controller: _,
              child: Column(
                children: [
                  Center(
                    child: Container(
                      margin: EdgeInsets.symmetric(vertical: size.height/100),
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
                            padding: EdgeInsets.all(size.height / 200),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text('Запланированно:',
                                    style: theme.textTheme.labelLarge)
                              ],
                            ),
                          ),
                          Container(
                            padding: EdgeInsets.all(size.height / 200),
                            height: size.height / 15,
                            width: size.width * 0.4,
                            decoration: BoxDecoration(
                              borderRadius: const BorderRadius.only(
                                  bottomRight: Radius.circular(20.0),
                                  topRight: Radius.circular(20.0)),
                              color: bottomNavigationColorDark,
                            ),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                    '${widget.event.dateStart.day.toString().padLeft(2, '0')}.${widget.event.dateStart.month.toString().padLeft(2, '0')}',
                                    style: theme.textTheme.labelLarge!
                                        .copyWith(color: Colors.white))
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
                      child: Center(
                        child: GridView(
                            physics: const NeverScrollableScrollPhysics(),
                            gridDelegate:
                                SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 7,
                            ),
                            children: List<Widget>.generate(
                                DateTime(widget.event.dateStart.year,
                                        widget.event.dateStart.month + 1, 0)
                                    .day,
                                (int index) => Container(
                                      height: size.width / 12,
                                      width: size.width / 12,
                                      margin: EdgeInsets.all(size.height / 200),
                                      decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(12),
                                          color:
                                              index == (widget.event.dateStart.day - 1)
                                                  ? bottomNavigationColorDark
                                                  : Colors.white),
                                      child: Center(
                                        child: Text(
                                          '${index + 1}',
                                          style: theme.textTheme.labelLarge!
                                              .copyWith(
                                                  color: index !=
                                                          (widget.event.dateStart.day -
                                                              1)
                                                      ? bottomNavigationColorDark
                                                      : Colors.white),
                                        ),
                                      ),
                                    ))),
                      ),
                    ),
                  ),
                  Center(
                    child: GestureDetector(
                      onTap: (){
                        widget.event.isLiked ? BlocProvider.of<EventBloc>(context).add(UnSubscribeEvent(widget.event)) :
                        BlocProvider.of<EventBloc>(context).add(SubscribeEvent(widget.event));

                        setState(() {
                          widget.event.isLiked = !widget.event.isLiked;
                        });
                      },
                      child: Container(
                        decoration: BoxDecoration(
                            color: bottomNavigationColorDark,
                            borderRadius: BorderRadius.circular(20)),
                        height: size.height / 15,
                        width: size.width * 0.8,
                        child: Center(
                          child: Text(
                            widget.event.isLiked ? 'Вы записались' : 'Посетить',
                            style: theme.textTheme.titleSmall,
                          ),
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),
          );
        });
  }
}
