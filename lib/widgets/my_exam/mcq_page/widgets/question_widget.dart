import 'package:flutter/material.dart';
import 'package:velocity_x/velocity_x.dart';

class QuestionWidget extends StatefulWidget {
  final String question;
  final int questionNumber;
  const QuestionWidget({Key? key, required this.question, required this.questionNumber}) : super(key: key);

  @override
  _QuestionWidgetState createState() => _QuestionWidgetState();
}

class _QuestionWidgetState extends State<QuestionWidget> {
  @override
  Widget build(BuildContext context) {
    return Container(
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
                    color: context.primaryColor,
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
                child: "${widget.questionNumber}. ${widget.question}".richText.semiBold.lg.letterSpacing(1).justify.make(),
              ),
            ),
            Align(
              alignment: Alignment.topCenter,
              child: Container(
                padding: const EdgeInsets.fromLTRB(15, 15, 15, 15),
                margin: const EdgeInsets.only(top: 10, left: 18, right: 18,),
                child: timer(),
                // child: ExamTimer(wantExamTimer: widget.wantExamTimer, examTime: widget.examTime,),
              ),
            ),
            Align(
              alignment: Alignment.topRight,
              child: Container(
                padding: const EdgeInsets.fromLTRB(15, 15, 15, 15),
                margin: const EdgeInsets.only(top: 70, left: 18, right: 18,),
                child: const SizedBox(),
                // child: widget.wantQuestionTimer ? buildQuestionTimer(minutesQuestion, secondsQuestion) : const SizedBox(),
              ),
            ),
          ],
        )
    );
  }

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
        "∞".text.xl4.make(),
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
