import 'package:flutter/material.dart';

class ProfileInfo extends StatelessWidget {
  const ProfileInfo({super.key});

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    var theme = Theme.of(context);

    return Container(
      padding: EdgeInsets.all(size.height/50),
      height: size.height/2.5,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(textAlign: TextAlign.center, 'Всем привет, это описание моего аккаунта. Я что-то тут напишу, потому что фронтендеру нужно  показать, как это все должно  выглядеть.', style: theme.textTheme.bodyLarge!.copyWith(color: Colors.white)),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                height: size.height/15,
                width: size.height/15,
                decoration: BoxDecoration(
                  color: Colors.transparent,
                  border: Border.all(color: Colors.white, width: 3),
                  shape: BoxShape.circle
                ),
                child: Icon(Icons.add, color: Colors.white, size: size.height/20,),
              ),
              Container(
                height: size.height/15,
                width: size.height/15,
                decoration: BoxDecoration(
                    color: Colors.transparent,
                    border: Border.all(color: Color(0xffF1A39B), width: 3),
                    shape: BoxShape.circle
                ),
                child: Center(
                  child: ImageIcon(AssetImage('assets/icons/heart.png'), size: size.height/30, color: Color(0xffF1A39B),),
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}
