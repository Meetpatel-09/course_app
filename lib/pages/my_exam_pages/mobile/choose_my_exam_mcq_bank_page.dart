import 'package:course_app_ui/model/my_exam_models/my_exam_banks_model.dart';
import 'package:course_app_ui/widgets/my_exam/choose_mcq_bank/mcq_bank.dart';
import 'package:flutter/material.dart';
import 'package:velocity_x/velocity_x.dart';

class ChooseMyExamMCQBankPageMobile extends StatelessWidget {
  final String subjectID;
  final List<Result> mcqBanks;
  final String token;
  const ChooseMyExamMCQBankPageMobile({Key? key, required this.subjectID, required this.mcqBanks, required this.token}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            "My Exam".text.make()
          ],
        ),
      ),
      backgroundColor: context.canvasColor,
      body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(18.0),
            child: MCQBanks(mcqBanks: mcqBanks, subjectID: subjectID, token: token,),
          )
      ),
    );
  }
}
