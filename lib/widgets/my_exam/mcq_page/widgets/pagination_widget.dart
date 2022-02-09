import 'package:course_app_ui/model/my_exam_models/my_exam_result_model.dart';
import 'package:course_app_ui/theme/theme.dart';
import 'package:flutter/material.dart';
import 'package:velocity_x/velocity_x.dart';

class PaginationButtons extends StatefulWidget {
  final List<Result>? myExamResultList;
  final PageController controller;
  final int questionIndex;
  const PaginationButtons({Key? key, required this.myExamResultList, required this.controller, required this.questionIndex}) : super(key: key);

  @override
  _PaginationButtonsState createState() => _PaginationButtonsState();
}

class _PaginationButtonsState extends State<PaginationButtons> {
  List<bool> isSelected = [];
  List<Widget> toggleButton = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    for (int i = 0; i < widget.myExamResultList!.length; i++) {
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

  Widget slidingButtons() {
    return SingleChildScrollView(
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
            // print(newIndex);
            setState(() {
              widget.controller.jumpToPage(newIndex);
            });
          },
        ),
      ),
    );
  }

  List<Widget> toggleChild() {
    toggleButton = [];
    for (int i = 0; i < widget.myExamResultList!.length; i++) {
      // print(i);
      toggleButton.add(tButton(i));
    }
    return toggleButton;
  }

  Widget tButton(int i) {
    // print("tButton ${widget.questionIndex} ");
    return Container(
        margin: const EdgeInsets.only(right: 2.0, left: 0),
        height: 40,
        width: 80,
        decoration: BoxDecoration(
          border: Border.all(color: context.primaryColor, width: 2),
          borderRadius: const BorderRadius.all(Radius.circular(5)),
          color: i == widget.questionIndex ? context.primaryColor : context.canvasColor,
        ),
        child: Center(
          child: Text(
            "Q No. - " + (i + 1).toString(),
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: i == widget.questionIndex ? MyTheme.white : context.cardColor,
            ),
          ),
        ));
  }
}
