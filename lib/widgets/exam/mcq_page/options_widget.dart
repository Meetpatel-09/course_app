import 'package:course_app_ui/model/mcq_models/mcq_question_bank_model.dart';
import 'package:flutter/material.dart';
import 'package:velocity_x/velocity_x.dart';

class OptionsWidget extends StatelessWidget {
  final Result? question;
  final ValueChanged<String>? onClickedOptions;
  final List<String>? mcqOptionCodes;
  const OptionsWidget({Key? key, this.question, this.onClickedOptions, this.mcqOptionCodes}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    int index = -1;
    return Padding(
      padding: const EdgeInsets.all(18.0),
      child: ListView(
        physics: const BouncingScrollPhysics(),
        children: question!.options.map((option) {
          index++;
          return buildOption(context, option, mcqOptionCodes!.elementAt(index));
        }).toList(),
      ),
    );
  }

  Widget buildOption(BuildContext context, String option, String mcqOptionCodes) {
    return GestureDetector(
      // onTap: () => onClickedOption(option),
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 6),
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: context.backgroundColor,
          borderRadius: BorderRadius.circular(14),
          border: Border.all(color: Colors.black38, width: 2)
        ),
        child: buildAnswer(option, mcqOptionCodes)
      ),
    );
  }

  Widget buildAnswer(String option, String mcqOptionCodes) {
    return Padding(
      padding: const EdgeInsets.only(left: 15),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          mcqOptionCodes.text.make(),
          option.text.xl.make(),
          const Icon(Icons.circle_outlined, color: Colors.black38,)
        ],
      ),
    );
  }
}
