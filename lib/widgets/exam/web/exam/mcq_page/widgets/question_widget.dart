import 'dart:async';

import 'package:course_app_ui/widgets/web/responsive.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:velocity_x/velocity_x.dart';

class QuestionWidget extends StatefulWidget {
  final String question;
  final bool wantExamTimer;
  final String examTimerMinutes;
  final String examTimerSeconds;
  final String examTime;
  final bool wantQuestionTimer;
  final String questionTime;
  final int questionNumber;
  final int mcqid;
  final Map<int, Duration> userMCQQuestionTimer;
  const QuestionWidget({Key? key, required this.question, required this.questionNumber, required this.wantQuestionTimer, required this.examTimerMinutes, required this.wantExamTimer, required this.examTimerSeconds, required this.questionTime, required this.examTime, required this.userMCQQuestionTimer, required this.mcqid}) : super(key: key);

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
      if (widget.userMCQQuestionTimer.containsKey(widget.mcqid)) {
        countdownDurationQuestion = widget.userMCQQuestionTimer[widget.mcqid]!;
      } else {
        countdownDurationQuestion = Duration(minutes: int.parse(widget.questionTime));
      }
      setState(() {
        durationQuestion = countdownDurationQuestion;
        widget.userMCQQuestionTimer[widget.mcqid] = durationQuestion;
      });
    } else {
      setState(() => durationQuestion = const Duration(hours: 10));
    }
  }

  void addTime() {
    const addSeconds = -1;
    setState(() {
      widget.userMCQQuestionTimer[widget.mcqid] = durationQuestion;
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

    // 9 --> 09     11 --> 11
    String twoDigits(int n) => n.toString().padLeft(2, '0');
    final minutesQuestion = twoDigits(durationQuestion.inMinutes.remainder(60));
    final secondsQuestion = twoDigits(durationQuestion.inSeconds.remainder(60));

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
                width: MediaQuery.of(context).size.width / 3,
                child: "Question ${widget.questionNumber}".text.xl.semiBold.make()
            ),
            ResponsiveWidget.isSmallScreen(context) ? const SizedBox() : widget.wantQuestionTimer ? Row(
              children: [
                "Question Timer ".text.xl.semiBold.make(),
                // "00:45".text.xl.semiBold.make(),
                buildQuestionTimer(minutesQuestion, secondsQuestion)
              ],
            ) : const SizedBox(),
          ],
        ),
        ResponsiveWidget.isSmallScreen(context) ? widget.wantQuestionTimer ? Row(
          children: [
            "Question Timer ".text.xl.semiBold.make(),
            // "00:45".text.xl.semiBold.make(),
            buildQuestionTimer(minutesQuestion, secondsQuestion)
          ],
        ).pOnly(top: 5.0) : const SizedBox() : const SizedBox(),
        const SizedBox(height: 20.0,),
        widget.question.text.xl2.semiBold.make(),
      ],
    );
  }

  Widget buildQuestionTimer(String minutesQuestion, String secondsQuestion) => Row(
    mainAxisAlignment: MainAxisAlignment.end,
    crossAxisAlignment: CrossAxisAlignment.center,
    children: [
      const Icon(Icons.access_alarm),
      "$minutesQuestion : $secondsQuestion".text.xl.semiBold.textStyle(GoogleFonts.lato()).make(),
    ],
  );
}
