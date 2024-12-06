import 'package:flutter/material.dart';

class EventBottomSheet extends StatelessWidget {
  const EventBottomSheet({super.key});

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return DraggableScrollableSheet(
      snapAnimationDuration: Duration(seconds: 4),
      initialChildSize: 0.5,
      maxChildSize: 1,
      builder: (context, _) {
        return Container(
          decoration: BoxDecoration(
            color: Colors.red,
          ),
          padding: EdgeInsets.zero,
          height: size.height,
          child: SingleChildScrollView(
            controller: _,
            child: Column(
                  children: [
            ListTile(
              leading: Icon(Icons.share),
              title: Text('Share'),
            ),
            ListTile(
              leading: Icon(Icons.copy),
              title: Text('Copy Link'),
            ),
            ListTile(
              leading: Icon(Icons.edit),
              title: Text('Edit'),
            ),ListTile(
              leading: Icon(Icons.edit),
              title: Text('Edit'),
            )
                  ],
                ),
          ),
        );
      }
    );
  }
}
