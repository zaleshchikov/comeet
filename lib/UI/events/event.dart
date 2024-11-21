import 'package:flutter/material.dart';

class EventItem extends StatelessWidget {
  Color color;
  Color titleColor;
  String name;

  EventItem(this.color, this.titleColor, this.name);

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    var theme = Theme.of(context);

    return Container(
      padding: EdgeInsets.only(bottom: size.height / 20),
      height: size.height / 5,
      width: size.width * 0.8,
      decoration:
          BoxDecoration(color: color, borderRadius: BorderRadius.circular(20)),
      child: Column(
        children: [
          Container(
            height: size.width * 0.1,
            width: size.width * 0.8,
            foregroundDecoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                border: Border.all(color: Colors.black, width: 2)),
            child: Container(
              decoration: BoxDecoration(
                color: titleColor,
                borderRadius: BorderRadius.circular(20),
              ),
              child: Stack(
                children: [
                  Container(
                    alignment: Alignment.centerRight,
                    child: Container(
                      height: size.width * 0.1,
                      width: size.width * 0.1,
                      decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          border: Border.all(color: Colors.black, width: 2)),
                      child: Center(
                        child: Icon(Icons.arrow_forward_ios),
                      ),
                    ),
                  ),
                  Center(
                    child: Text(
                      name,
                      style: theme.textTheme.bodyMedium,
                    ),
                  )
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
