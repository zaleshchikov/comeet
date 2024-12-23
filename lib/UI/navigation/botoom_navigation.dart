import 'package:comeet/UI/events/event_screen.dart';
import 'package:comeet/UI/profile/profile/profile_screen.dart';
import 'package:comeet/UI/tests/test_result/test_screen.dart';
import 'package:comeet/UI/user_card/card_screen.dart';
import 'package:comeet/request_constant/colors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';

import '../profile/events/profile_events_screen.dart';

class BottomNavigationScreen extends StatefulWidget {
  BottomNavigationScreen(this.body);

  Widget body;

  @override
  State<BottomNavigationScreen> createState() => _BottomNavigationScreenState();
}

class _BottomNavigationScreenState extends State<BottomNavigationScreen> {
  var _selectedIndex = 4;
  Color bottomColor = Colors.white;
  late List listOfBody;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
      bottomColor = listOfBody[index].toString() == 'CardScreen'
          ? Colors.white
          : bottomNavigationColorDark;
    });
  }

  @override
  void initState() {
    super.initState();
    listOfBody = [
      CardScreen(),
      CardScreen(),
      EventsScreen(),
      ProfileScreen(),
      widget.body
    ];
    bottomColor = widget.body.toString() == 'CardScreen'
        ? Colors.white
        : bottomNavigationColorDark;
    setState(() {
      if (widget.body.toString() == 'EventsScreen') {
        _selectedIndex = 2;
      }
      if (widget.body.toString() == 'CardScreen') {
        _selectedIndex = 1;
      }
      if (widget.body.toString() == 'ProfileScreen') {
        _selectedIndex = 3;
      }

    });
  }

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    var size = MediaQuery.of(context).size;

    Widget BottomBarItem(int index) {
      return InkWell(
          onTap: () => _onItemTapped(index),
          child: Container(
              height: size.height / 25,
              width: size.height / 25,
              decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(width: 2, color: bottomColor),
                  color: (_selectedIndex == index) ||
                          (index == 3 && (_selectedIndex == 4))
                      ? bottomColor
                      : Colors.transparent)));
    }

    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: theme.primaryColor,
      body: Stack(
        children: [
          listOfBody[_selectedIndex],
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              padding: EdgeInsets.only(
                  left: size.height / 20,
                  right: size.height / 20,
                  bottom: size.height / 40),
              height: size.height / 10,
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.transparent,
                ),
                height: size.height / 14,
                child: Container(
                  height: size.height / 12,
                  color: Colors.transparent,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      BottomBarItem(0),
                      BottomBarItem(1),
                      BottomBarItem(2),
                      BottomBarItem(3),
                    ],
                  ),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
