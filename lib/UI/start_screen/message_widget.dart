import 'package:flutter/material.dart';

import 'message.dart';

Widget message(ChatMessage chatMessage, double height, double width, ThemeData theme) => Container(
  padding: EdgeInsets.only(
      left: 14, right: 14, top: 10, bottom: height / 100),
  child: Row(
    mainAxisAlignment: chatMessage.messageType == "receiver"
        ? MainAxisAlignment.start
        : MainAxisAlignment.end,
    children: [
      chatMessage.messageType == "receiver"
          ? Container(
        padding: EdgeInsets.only(right: height / 100),
        child: Image(
            image: const AssetImage(
                'assets/icons/bita_icon.png'),
            height: height / 20),
      )
          : Container(),
      Container(
        constraints: BoxConstraints(
            minWidth: height / 100, maxWidth: width / 1.5),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          color: (chatMessage.messageType == "receiver"
              ? theme.hoverColor
              : theme.primaryColor),
        ),
        padding: EdgeInsets.all(16),
        child: Text(
          chatMessage.messageContent,
          style: theme.textTheme.bodyMedium!.copyWith(
              color: chatMessage.messageType == "receiver"
                  ? theme.cardColor
                  : theme.hoverColor),
        ),
      ),
    ],
  ),
);