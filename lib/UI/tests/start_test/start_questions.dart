import 'package:comeet/UI/navigation/botoom_navigation.dart';
import 'package:comeet/UI/tests/start_test/first_question.dart';
import 'package:comeet/bloc/start_test/start_test_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../request_constant/colors.dart';
import '../../animation/animation_one.dart';
import '../../profile/profile/profile_screen.dart';

class StartQuestionsScreen extends StatefulWidget {
  @override
  State<StartQuestionsScreen> createState() => _StartQuestionsScreenState();
}

class _StartQuestionsScreenState extends State<StartQuestionsScreen> {
  int index = 0;

  List<String> questons = [
    '1. На ваш взгляд, какими качествами вы обладаете?',
    '2. На ваш взгляд, какими качествами вы обладаете?',
    '3. Какие хобби у вас есть?',
    '4. Что вы цените в людях?',
    '5. Что вы цените в людях?',
    '6. Что для вас самое важное в работе?',
    '7. Какие темы для обсуждения вам интересны?',
    '8. Какой тип досуга вы предпочитаете?',
    '9. Какими видами спорта вы увлекаетесь?',
    '10. Предпочитаете ли вы работать в команде или самостоятельно?',
    '11. Как вы предпочитаете проводить время с коллегами?'
  ];

  List<List<String>> answers = [
    [
      'Юмор',
      'Доброта',
      'Интеллект',
      'Открытость',
      'Честность',
      'Ум',
      'Эмпатия',
    ],
    [
      'Отзывчивость',
      'Доброжелательность',
      'Уважение',
      'Ответственность',
      'Целеустремленность',
      'Гибкость',
      'Упорство'
    ],
    [
      'Спорт',
      'Чтение книг',
      'Фильмы и сериалы',
      'Писательство',
      'Игры (настольные, видеоигры)',
      'Путешествия',
      'Рисование',
      'Кулинария',
      'Музыка',
      'Фотография',
      'Танцы',
      'Иностранные языки'
    ],
    [
      'Юмор',
      'Доброта',
      'Интеллект',
      'Открытость',
      'Честность',
      'Ум',
      'Эмпатия',
    ],
    [
      'Отзывчивость',
      'Доброжелательность',
      'Уважение',
      'Ответственность',
      'Целеустремленность',
      'Гибкость',
      'Упорство'
    ],
    [
      'Возможность профессионального роста',
      'Командная атмосфера',
      'Финансовая стабильность',
      'Участие в интересных проектах',
      'Свобода и независимость',
      'Баланс работы и личной жизни',
      'Смысл и вклад',
      'Признание и уважение',
      'Творческая свобода',
      'Обучение и развитие',
    ],
    [
      'Технологии',
      'Наука',
      'Общество',
      'Личное развитие',
      'Спорт',
      'Путешествия',
      'Программирование',
      'Еда',
      'Музыка',
      'Кино и ТВ',
      'Литература'
    ],
    [
      'Активный (походы, мероприятия на свежем воздухе)',
      'Пассивный (просмотр сериалов, чтение)',
      'Социальный (встречи с друзьями)'
    ],
    [
      'Командные виды спорта (футбол, баскетбол, волейбол, хоккей, гандбол и т.д.)',
      'Индивидуальные виды спорта (бег, плавание, велоспорт, теннис, бадминтон, бокс и т.д.)',
      'Экстремальные виды спорта (сноубординг, горные лыжи, скайдайвинг и т.д.)',
      'Киберспорт, видеоигры',
      'Физическая активность (пешие прогулки, фитнес, йога, езда на велосипеде и т.д.)'
    ],
    ['В команде', 'Самостоятельно', 'Смешанный формат'],
    [
      'В неформальной обстановке (например, в кафе или на пикнике)',
      'На совместных мероприятиях (например, тимбилдинг)',
      'В офисе за работой',
      'Онлайн (видеозвонки, чаты)'
    ]
  ];

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    var theme = Theme.of(context);

    return BlocProvider(
        create: (context) => StartTestBloc(),
        child: Builder(builder: (context) {
          return BlocListener<StartTestBloc, StartTestState>(
              listener: (context, state) {
                if (state.successRequest) {
                  if (index == 10) {
                    showDialog(
                        context: context,
                        builder: (_) => AlertDialog(

                              title: Container(
                                height: size.height/4,
                                width: size.width*0.8,
                                child: Center(
                                    child: Text("Вы успешно прошли первый тест")),
                              ),
                              content: Container(
                                width: size.width*0.8,
                                height: size.height/2.4,
                                child: Center(
                                    child: Text(
                                        "Можете перейти к заполнению профиля и ознакомлению с возможностями приложения")),
                              ),
                              titleTextStyle: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black,
                                  fontSize: 20),
                              actionsOverflowButtonSpacing: 20,
                            ));
                    Future.delayed(const Duration(milliseconds: 500), () {
// Here you can write your code
                      Navigator.of(context).push(SlideAnimationRoute(
                          BottomNavigationScreen(ProfileScreen())));
                    });
                  } else {
                    setState(() {
                      index++;
                    });
                  }
                }
              },
              child: FirstStartQuestion(questons[index], answers[index]));
        }));
  }
}
