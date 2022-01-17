import 'dart:async';

import 'package:course_app_ui/theme/theme.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:velocity_x/velocity_x.dart';

class QuestionWidget extends StatefulWidget {
  final String question;
  final bool wantExamTimer;
  final String examTimerMinutes;
  final String examTimerSeconds;
  final bool wantQuestionTimer;
  final String questionTimer;
  final int questionNumber;
  final Map<int, Duration> userMCQQuestionTimer;
  const QuestionWidget({Key? key, required this.question, required this.questionNumber, required this.wantQuestionTimer, required this.questionTimer, required this.wantExamTimer, required this.examTimerMinutes, required this.examTimerSeconds, required this.userMCQQuestionTimer}) : super(key: key);

  @override
  State<QuestionWidget> createState() => _QuestionWidgetState();
}

class _QuestionWidgetState extends State<QuestionWidget> {
  static Duration countdownDurationQuestion = const Duration();
  Duration durationQuestion = const Duration();
  Timer? timerQuestion;

  @override
  void initState() {
    super.initState();
    if (widget.wantQuestionTimer) {
      startTimer();
    }
  }

  void startTimer({bool resets = true}) {
    if(resets) {
      reset();
    }
    timerQuestion = Timer.periodic(const Duration(seconds: 1), (_) => addTime());
  }

  void reset() {
    if (widget.wantQuestionTimer) {
      if (widget.userMCQQuestionTimer.containsKey(widget.questionNumber)) {
        countdownDurationQuestion = widget.userMCQQuestionTimer[widget.questionNumber]!;
      } else {
        countdownDurationQuestion = Duration(minutes: int.parse(widget.questionTimer));
      }
      setState(() => durationQuestion = countdownDurationQuestion);
    } else {
      setState(() => durationQuestion = const Duration(hours: 10));
    }
  }

  void addTime() {
    const addSeconds = -1;
    widget.userMCQQuestionTimer[widget.questionNumber] = durationQuestion;
    setState(() {
      final seconds = durationQuestion.inSeconds + addSeconds;

      if(seconds < 0) {
        timerQuestion?.cancel();
      } else {
        durationQuestion = Duration(seconds: seconds);
      }
    });
  }

  void stopTimer({bool resets = true}) {
    if (resets) {
      reset();
    }

    setState(() => timerQuestion?.cancel());
  }

  @override
  void dispose() {
    timerQuestion?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {

    if (widget.wantQuestionTimer) {
      final isRunning = timerQuestion == null ? false : timerQuestion!.isActive;
      int uSeconds = int.parse(widget.questionTimer) * 60;
      final isCompleted = durationQuestion.inSeconds == uSeconds || durationQuestion.inSeconds == 0;
    }

    // 9 --> 09     11 --> 11
    String twoDigits(int n) => n.toString().padLeft(2, '0');
    final minutesQuestion = twoDigits(durationQuestion.inMinutes.remainder(60));
    final secondsQuestion = twoDigits(durationQuestion.inSeconds.remainder(60));

    return
        Container(
            width: MediaQuery.of(context).size.width,
            decoration: BoxDecoration(
                color: context.canvasColor,
            ),
            child: Stack(
              children: [
                Align(
                  alignment: Alignment.topCenter,
                  child: Container(
                    width: MediaQuery.of(context).size.width,
                    padding: const EdgeInsets.fromLTRB(15, 90, 15, 15),
                    margin: const EdgeInsets.only(bottom: 10),
                    decoration: BoxDecoration(
                        color: MyTheme.lightBlue,
                        borderRadius: const BorderRadius.only(bottomRight: Radius.circular(10), bottomLeft: Radius.circular(10))
                    ),
                    child: "${widget.questionNumber}. ${widget.question}".richText.semiBold.xl.color(context.primaryColor).letterSpacing(1).justify.make(),
                  ),
                ),
                Align(
                  alignment: Alignment.bottomCenter,
                  child: Container(
                    width: MediaQuery.of(context).size.width,
                    padding: const EdgeInsets.fromLTRB(15, 90, 15, 15),
                    margin: const EdgeInsets.only(top: 70, left: 18, right: 18,),
                    decoration: BoxDecoration(
                      color: context.backgroundColor,
                      borderRadius: BorderRadius.circular(15),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.8),
                          // spreadRadius: 7,
                          blurRadius: 15,
                          offset: const Offset(0.0, 0.75)
                        ),
                      ]
                    ),
                    child: "${widget.questionNumber}. ${widget.question}".richText.semiBold.xl.letterSpacing(1).justify.make(),
                  ),
                ),
                Align(
                  alignment: Alignment.topCenter,
                  child: Container(
                    padding: const EdgeInsets.fromLTRB(15, 15, 15, 15),
                    margin: const EdgeInsets.only(top: 10, left: 18, right: 18,),
                    child: timer(),
                  ),
                ),
                Align(
                  alignment: Alignment.topRight,
                  child: Container(
                    padding: const EdgeInsets.fromLTRB(15, 15, 15, 15),
                    margin: const EdgeInsets.only(top: 70, left: 18, right: 18,),
                    child: widget.wantQuestionTimer ? buildQuestionTimer(minutesQuestion, secondsQuestion) : const SizedBox(),
                  ),
                ),
              ],
            )
    );
  }

  Widget buildQuestionTimer(String minutesQuestion, String secondsQuestion) => Row(
    mainAxisAlignment: MainAxisAlignment.end,
    crossAxisAlignment: CrossAxisAlignment.center,
    children: [
      const Icon(Icons.access_alarm),
      "$minutesQuestion : $secondsQuestion".text.textStyle(GoogleFonts.lato()).make(),
    ],
  );

  Widget timer() => buildCircle(
      color: context.backgroundColor,
      all: 3,
      child: buildCircle(
        color: context.primaryColor,
        all: 3,
        child: buildTimer(),
      )
  );

  buildTimer() => Container(
    height: 110,
    width: 110,
    decoration: BoxDecoration(
      color: context.backgroundColor,
      borderRadius: BorderRadius.circular(55),
    ),
    child: Align(child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        "Exam Timer".text.center.lg.make(),
        widget.wantExamTimer ? "${widget.examTimerMinutes} : ${widget.examTimerSeconds}".text.xl.textStyle(GoogleFonts.lato()).make() : "∞".text.xl4.make(),
      ],
    )),
  );

  buildCircle({
    required Color color,
    required double all,
    required Widget child}) =>
      ClipOval(
        child: Container(
          padding: EdgeInsets.all(all),
          color: color,
          child: child,
        ),
      );
}
