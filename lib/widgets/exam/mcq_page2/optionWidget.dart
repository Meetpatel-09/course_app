import 'package:course_app_ui/model/mcq_models/mcq_question_bank_model.dart';
import 'package:course_app_ui/widgets/exam/mcq_page2/utils.dart';
import 'package:flutter/material.dart';

class OptionsWidget extends StatefulWidget {
  final Result question;
  final ValueChanged<String> onClickedOption;
  const OptionsWidget({Key? key, required this.question, required this.onClickedOption}) : super(key: key);

  @override
  _OptionsWidgetState createState() => _OptionsWidgetState();
}

class _OptionsWidgetState extends State<OptionsWidget> {
  @override
  Widget build(BuildContext context) => ListView(
    physics: BouncingScrollPhysics(),
    children: Utils.heightBetween(
      widget.question.options
          .map((option) => buildOption(context, option))
          .toList(),
      height: 8,
    ),
  );

  Widget buildOption(BuildContext context, String option) {
    // final color = getColorForOption(option, question);

    return GestureDetector(
      onTap: () => widget.onClickedOption(option),
      child: Container(
        padding: EdgeInsets.all(12),
        decoration: BoxDecoration(
          // color: color,
          borderRadius: BorderRadius.circular(16),
        ),
        child: Column(
          children: [
            buildAnswer(option),
            // buildSolution(question.selectedOption, option),
          ],
        ),
      ),
    );
  }

  Widget buildAnswer(String option) => Container(
    height: 50,
    child: Row(children: [
      // Text(
      //   option.code,
      //   style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24),
      // ),
      SizedBox(width: 12),
      Text(
        option,
        style: TextStyle(fontSize: 20),
      )
    ]),
  );

  // Widget buildSolution(Option solution, Option answer) {
  //   if (solution == answer) {
  //     return Text(
  //       question.solution,
  //       style: TextStyle(fontSize: 16, fontStyle: FontStyle.italic),
  //     );
  //   } else {
  //     return Container();
  //   }
  // }

  // Color getColorForOption(String option, Result question) {
  //   final isSelected = option == question.selectedOption;
  //
  //   if (!isSelected) {
  //     return Colors.grey.shade200;
  //   } else {
  //     return option.isCorrect ? Colors.green : Colors.red;
  //   }
  // }
}
