import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:velocity_x/velocity_x.dart';

class ExamTimer extends StatefulWidget {
  final bool wantExamTimer;
  final String examTime;
  const ExamTimer({Key? key, required this.wantExamTimer, required this.examTime}) : super(key: key);

  @override
  _ExamTimerState createState() => _ExamTimerState();
}

class _ExamTimerState extends State<ExamTimer> {
  static Duration countdownDurationExam = const Duration();
  Duration durationExam = const Duration(minutes: 100);
  Timer? timerExam;

  @override
  void initState() {
    super.initState();
    if (widget.wantExamTimer) {
      timerExam = Timer.periodic(const Duration(seconds: 1), (_) => addTime());
    }
  }

  void addTime() {
    const addSeconds = -1;
    print(durationExam.inSeconds);
    setState(() {
      // widget.userMCQQuestionTimer[widget.mcqid] = durationQuestion;
      final seconds = durationExam.inSeconds + addSeconds;

      if(seconds < 0) {
        // timerQuestion?.cancel();
      } else {
        durationExam = Duration(seconds: seconds);
      }
    });
  }

  void reset() {
    if (widget.wantExamTimer) {
      countdownDurationExam = Duration(minutes: int.parse(widget.examTime));
      setState(() => durationExam = countdownDurationExam);
    } else {
      setState(() => durationExam = const Duration(hours: 10));
    }
  }

  void startTimer({bool resets = true}) {
    if(resets) {
      reset();
    }
    timerExam = Timer.periodic(const Duration(seconds: 1), (_) => addTime());
  }

  void stopTimer({bool resets = true}) {
    if (resets) {
      reset();
    }
    setState(() => timerExam?.cancel());
  }

  @override
  void dispose() {
    timerExam?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // 9 --> 09     11 --> 11
    String twoDigits(int n) => n.toString().padLeft(2, '0');
    final minutes = twoDigits(durationExam.inMinutes.remainder(60));
    final seconds = twoDigits(durationExam.inSeconds.remainder(60));

    return buildCircle(
        color: context.backgroundColor,
        all: 3,
        child: buildCircle(
          color: context.primaryColor,
          all: 3,
          child: buildTimer(minutes, seconds),
        )
    );
  }

  buildTimer(String minutes, String seconds) => Container(
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
        widget.wantExamTimer ? "$minutes : $seconds".text.xl.textStyle(GoogleFonts.lato()).make() : "∞".text.xl4.make(),
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
