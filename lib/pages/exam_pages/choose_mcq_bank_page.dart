import 'package:course_app_ui/model/course_model.dart';
import 'package:course_app_ui/model/mcq_models/mcq_banks_model.dart';
import 'package:course_app_ui/pages/exam_pages/mobile/choose_mcq_bank_page.dart';
import 'package:course_app_ui/pages/exam_pages/web/choose_mcq_bank_page.dart';
import 'package:course_app_ui/utils/routes.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:flutter/material.dart';

class ChooseMCQBankPage extends StatelessWidget {
  const ChooseMCQBankPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    List<Subject> subjectList = [];
    int subjectIndex = 0;
    late MCQBanksModel mcqBanks;
    String token = "empty";
    String subjectID = "";

    final arg = ModalRoute.of(context)!.settings.arguments as Map;
    subjectList = arg['subjectList'];
    subjectIndex = arg['subjectIndex'];
    mcqBanks = arg['mcqBanks'];
    subjectID = arg['subjectID'];
    token = arg['token'];

    // when user press the back button redirecting to home page using WillPopScope
    // done because if use comes to this page after completing exam and then tries to go back
    return WillPopScope(
      onWillPop: () async {
        Navigator.pushNamedAndRemoveUntil(context, MyRoutes.homeRoute, (route) => false);
        return true;
      },
      child: LayoutBuilder(
        builder: (context, constraints) {
          if (kIsWeb) {
            // Web SCREEN
            return ChooseMCQBankPageWeb(token: token, subjectID: subjectID, subjectIndex: subjectIndex, mcqBanks: mcqBanks, subjectList: subjectList,);
          } else {
            // Mobile Screen
            return ChooseMCQBankPageMobile(token: token, subjectID: subjectID, subjectIndex: subjectIndex, mcqBanks: mcqBanks, subjectList: subjectList,);
          }
        },
      ),
    );
  }
}
