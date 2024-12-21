import 'package:comeet/bloc/test/test/test_bloc.dart';
import 'package:comeet/request_constant/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';

class TestStartScreen extends StatelessWidget {
  const TestStartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    var theme = Theme.of(context);

    return Scaffold(
      backgroundColor: purpuleColor,
      body: BlocBuilder<TestBloc, TestState>(
  builder: (context, state) {
    return Center(
        child: Container(
          height: size.height / 2.3,
          width: size.width * 0.8,
          decoration: BoxDecoration(
              color: state.test!.color,
              borderRadius: BorderRadius.circular(25)),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Text(
                state.test!.label,
                style: theme.textTheme.titleMedium!.copyWith(
                    color: Colors.black, fontFamily: GoogleFonts.mPlusRounded1c().fontFamily, fontWeight: FontWeight.w800
                ),
              ),
              Container(
                  width: size.width * 0.6,
                  child: Text(
                    textAlign: TextAlign.center,
                    state.test!.description,
                    style: theme.textTheme.bodyLarge!.copyWith(
                      color: Colors.black, fontFamily: GoogleFonts.mPlusRounded1c().fontFamily, fontWeight: FontWeight.w600
                    ),
                  )),
              Image(
                image: AssetImage('assets/tests/start_main_test_button.png'),
                height: size.height / 5,
              )
            ],
          ),
        ),
      );
  },
),
    );
  }
}
