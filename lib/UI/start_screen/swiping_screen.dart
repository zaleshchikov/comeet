import 'package:comeet/UI/start_screen/start_screen.dart';
import 'package:flutter/material.dart';
import '../animation/animation_one.dart';

class SlideScreen extends StatefulWidget {
  const SlideScreen({super.key});

  @override
  State<SlideScreen> createState() => _SlideScreen1State();
}

class _SlideScreen1State extends State<SlideScreen> {
  int _index = 0;
  List<String> assets = [
    'assets/slide/slide1.png',
    'assets/slide/slide2.png',
    'assets/slide/slide3.png',
  ];

  List<String> titles = [
    'Ты в приложении\ncomeet, трудяга',
    'Чтобы налаживать\nсвязи между\nколлегами',
    'А ещё отдыхать,\nсмотреть вместе\nфильмы, играть в..',
  ];

  List<String> descriptions = [
    'И зачем оно мне?',
    'А ещё?',
    'В мафию?',
  ];

  PageController _controller = PageController();

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    var theme = Theme.of(context);

    Widget countContainer(bool celected) => SizedBox(
          width: size.width / 10,
          height: size.height / 100,
          child: Container(
            width: size.width / 10 / (celected ? 3 : 1),
            height: size.height / 100,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(50),
                color: celected ? theme.primaryColor : theme.dividerColor),
          ),
        );

    var pageController = PageController(viewportFraction: 0.8);
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          SizedBox(
              width: size.width,
              height: size.height / 1.7,
              child: PageView.builder(
                  controller: _controller,
                  onPageChanged: (pageIndex) {
                    setState(() {
                      _index = pageIndex;
                    });
                  },
                  itemCount: assets.length,
                  pageSnapping: true,
                  itemBuilder: (context, pagePosition) {
                    return Container(
                        padding: EdgeInsets.zero,
                        margin: EdgeInsets.zero,
                        child: Image.asset(
                          assets[pagePosition],
                          fit: BoxFit.fitWidth,
                        ));
                  })),
          Center(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Container(width: size.width / 5),
                countContainer(_index == 0),
                countContainer(_index == 1),
                countContainer(_index == 2),
                Container(width: size.width / 5),
              ],
            ),
          ),
          Center(
            child: Container(
              height: size.height / 6,
              width: size.width * 0.8,
              child: Center(
                child: Text(
                  textAlign: TextAlign.center,
                  titles[_index],
                  style: Theme.of(context).textTheme.titleMedium,
                ),
              ),
            ),
          ),
          InkWell(
              onTap: () async {
                if (_index == 2) {
                  Navigator.of(context).push(SlideAnimationRoute(StartScreen(
                    secondWay: true,
                  )));
                  return;
                }
                setState(() {
                  _index++;
                  _controller.nextPage(
                      duration: Duration(milliseconds: 500),
                      curve: Curves.easeIn);
                });
              },
              child: Container(
                decoration: BoxDecoration(
                    color: theme.primaryColor,
                    borderRadius: BorderRadius.circular(50)),
                height: size.height / 15,
                width: size.width * 0.9,
                child: Center(
                  child: Text(
                    descriptions[_index],
                    style: theme.textTheme.titleSmall,
                  ),
                ),
              )),
          Container(height: size.height / 15)
        ],
      ),
    );
  }
}
