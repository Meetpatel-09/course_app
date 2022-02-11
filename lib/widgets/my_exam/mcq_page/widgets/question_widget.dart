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
          borderRadius: BorderRadius.circular(15),
        ),
        child: Container(
          padding: const EdgeInsets.all(20),
          margin: const EdgeInsets.only(top: 20, left: 18, right: 18,),
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
    );
  }
}
