import 'package:course_app_ui/model/mcq_models/mcq_question_bank_model.dart';
import 'package:course_app_ui/model/mcq_models/user_answers/send_user_mcq_answer_model.dart';
import 'package:course_app_ui/services/api_service.dart';
import 'package:course_app_ui/theme/theme.dart';
import 'package:flutter/material.dart';
import 'package:velocity_x/velocity_x.dart';

class PaginationButtons extends StatefulWidget {
  final List<Result> mcqQuestions;
  final int questionIndex;
  final PageController controller;
  final Map<int, String> userAnswer;
  final String token;
  final String userMcqId;
  final Map<int, String> userAnswerToSend;
  final Map<int, Duration> userMCQQuestionTimer;
  final int questionTime;
  final List<int> mcqIDs;
  const PaginationButtons({Key? key, required this.mcqQuestions, required this.questionIndex, required this.controller, required this.userAnswer, required this.token, required this.userMcqId, required this.userAnswerToSend, required this.userMCQQuestionTimer, required this.questionTime, required this.mcqIDs}) : super(key: key);

  @override
  _PaginationButtonsState createState() => _PaginationButtonsState();
}

class _PaginationButtonsState extends State<PaginationButtons> {
  // bool _isLoading = true;
  List<bool> isSelected = [];
  List<Widget> toggleButton = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    for (int i = 0; i < widget.mcqQuestions.length; i++) {
      if (i == widget.questionIndex) {
        isSelected.add(true);
      } else {
        isSelected.add(false);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(18.0, 0.0, 18.0, 6.0),
      child: slidingButtons(),
    );
  }

  Widget slidingButtons() => SingleChildScrollView(
    scrollDirection: Axis.vertical,
    child: SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: ToggleButtons(
        isSelected: isSelected,
        renderBorder: false,
        fillColor: context.canvasColor,
        splashColor: context.canvasColor,
        children: toggleChild(),
        onPressed: (int newIndex) {

          String na= "";

          Map<int ,String> finalAnswers = {};
          Map<int ,Duration> finalQuestionTime = {};

          for (var element in widget.mcqIDs) {
            finalAnswers[element] = na;
          }

          for (var element in widget.mcqIDs) {
            finalQuestionTime[element] = Duration(seconds: widget.questionTime);
          }

          final thirdMap = {
            ...finalAnswers,
            ...widget.userAnswerToSend,
          };

          final thirdMap2 = {
            ...finalQuestionTime,
            ...widget.userMCQQuestionTimer,
          };

          // variables to store mcq questions and answers
          List<int> q = thirdMap.keys.toList();
          List<String> a = thirdMap.values.toList();

          List queRemainingTime = [];
          List queTotalTakenTime = [];
          // checking if there was a question timer
          if(widget.userMCQQuestionTimer.isNotEmpty) {

            for(int i = 0; i < thirdMap2.length; i++) {

              int n = widget.mcqQuestions[i].mcqid;
              int? s = thirdMap2[n]?.inSeconds;
              int? r = s!;
              int? t = (widget.questionTime * 60) - r;

              queRemainingTime.add(r);
              queTotalTakenTime.add(t);
            }
          }

          SendUserMCQAnswers model = SendUserMCQAnswers(
            token: widget.token,
            userMcqId: int.parse(widget.userMcqId),
            mbid: widget.mcqQuestions[widget.questionIndex].mbid,
            ans: a,
            mcqid: q,
            queRemainingTime: queRemainingTime,
            queTotalTakenTime: queTotalTakenTime,
          );

          // print(model);
          // print("${model.mbid}, ${model.userMcqId}, ${model.token}, ${model.mcqid}, ${model.queTotalTakenTime}, ${model.queRemainingTime}, ${model.ans} ");
          APIServices.sendMCQUserAnswer(model, widget.token, false);

          setState(() {
            for (int index = 0; index < widget.mcqQuestions.length; index++) {
              if (index == newIndex) {
                isSelected[index] = true;
                widget.controller.jumpToPage(index);
              } else {
                isSelected[index] = false;
              }
            }
          });
        },
      ),
    ),
  );

  List<Widget> toggleChild() {
    toggleButton = [];
    for (int i = 0; i < widget.mcqQuestions.length; i++) {
      toggleButton.add(tButton(i));
    }
    return toggleButton;
  }

  Widget tButton(int i) => Container(
      margin: const EdgeInsets.only(right: 2.0, left: 0),
      height: 40,
      width: 40,
      decoration: BoxDecoration(
        border: Border.all(color: context.primaryColor, width: 2),
        borderRadius: const BorderRadius.all(Radius.circular(5)),
        color: isSelected[i] ? context.primaryColor : context.canvasColor,
      ),
      child: Center(
        child: Text(
          (i + 1).toString(),
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: isSelected[i] ? MyTheme.white : context.cardColor,
          ),
        ),
      ));
}
