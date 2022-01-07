import 'package:course_app_ui/model/mcq_models/mcq_question_bank_model.dart';
import 'package:flutter/material.dart';
import 'package:velocity_x/velocity_x.dart';

class OptionsWidget extends StatefulWidget {
  final Result? question;
  final ValueChanged<String>? onClickedOptions;
  const OptionsWidget({Key? key, this.question, this.onClickedOptions}) : super(key: key);

  @override
  State<OptionsWidget> createState() => _OptionsWidgetState();
}

class _OptionsWidgetState extends State<OptionsWidget> {
  List<String> optionCode = ["A", "B", "C", "D"];
  int index = -1;

  @override
  Widget build(BuildContext context) {

    return ListView(
      physics: const BouncingScrollPhysics(),
      children: widget.question!.options.map((option) => buildOption(context, option)).toList(),
    );
  }

  Widget buildOption(BuildContext context, String option) {
    return Container(
      decoration: BoxDecoration(
        color: context.backgroundColor
      ),
      child: buildAnswer(option)
    );
  }

  Widget buildAnswer(String option) {
    if (index < 4) {
      index++;
    } else {
      index = 0;
    }
    return Container(
      height: 50,
      child: Row(
        children: [
          optionCode[index].text.semiBold.xl.make(),
          const SizedBox(width: 20,),
          option.text.xl.make()
        ],
      ),
    );
  }
}
