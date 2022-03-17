import 'package:course_app_ui/model/course_model.dart';
import 'package:course_app_ui/model/mcq_models/mcq_banks_model.dart';
import 'package:course_app_ui/utils/routes.dart';
import 'package:course_app_ui/widgets/exam/choose_mcq_bank/mcq_bank.dart';
import 'package:flutter/material.dart';
import 'package:velocity_x/velocity_x.dart';

class ChooseMCQBankPageMobile extends StatelessWidget {
  final List<Subject> subjectList;
  final int subjectIndex;
  final MCQBanksModel mcqBanks;
  final String token;
  final String subjectID;
  const ChooseMCQBankPageMobile({Key? key, required this.subjectList, required this.subjectIndex, required this.mcqBanks, required this.token, required this.subjectID}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    // when user press the back button redirecting to home page using WillPopScope
    // done because if use comes to this page after completing exam and then tries to go back
    return WillPopScope(
      onWillPop: () async {
        Navigator.pushNamedAndRemoveUntil(context, MyRoutes.homeRoute, (route) => false);
        return true;
      },
      child: Scaffold(
        appBar: AppBar(
          title: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              IconButton(icon: const Icon(Icons.arrow_back), onPressed: () => Navigator.pushNamedAndRemoveUntil(context, MyRoutes.homeRoute, (route) => false)),
              const SizedBox(width: 10,),
              "Exam".text.make()
            ],
          ),
        ),
        backgroundColor: context.canvasColor,
        body: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(18.0),
              child: MCQBanks(subjectList: subjectList,subjectIndex: subjectIndex,mcqBanks: mcqBanks, subjectID: subjectID),
            )
        ),
      ),
    );
  }
}
