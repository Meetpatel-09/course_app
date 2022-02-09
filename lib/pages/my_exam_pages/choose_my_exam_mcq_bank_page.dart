import 'package:course_app_ui/model/my_exam_models/my_exam_banks_model.dart';
import 'package:course_app_ui/services/shared_service.dart';
import 'package:course_app_ui/widgets/my_exam/choose_mcq_bank/mcq_bank.dart';
import 'package:flutter/material.dart';
import 'package:velocity_x/velocity_x.dart';

class ChooseMyExamMCQBankPage extends StatefulWidget {
  const ChooseMyExamMCQBankPage({Key? key}) : super(key: key);

  @override
  _ChooseMyExamMCQBankPageState createState() => _ChooseMyExamMCQBankPageState();
}

class _ChooseMyExamMCQBankPageState extends State<ChooseMyExamMCQBankPage> {
  String subjectID = "";
  List<Result>? mcqBanks = [];
  String token = "empty";
  final SharedServices _sharedServices = SharedServices();

  @override
  void initState() {
    _sharedServices.getData("token").then((value) {
      if (value != null) {
        setState(() {
          token = value;
        });
      } else {
        token = "empty";
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final arg = ModalRoute.of(context)!.settings.arguments as Map;
    subjectID = arg['subjectID'];
    mcqBanks = arg['mcqBanks'];

    return Scaffold(
      appBar: AppBar(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // IconButton(icon: const Icon(Icons.arrow_back), onPressed: () => Navigator.pushNamedAndRemoveUntil(context, MyRoutes.homeRoute, (route) => false)),
            // const SizedBox(width: 10,),
            "Exam".text.make()
          ],
        ),
      ),
      backgroundColor: context.canvasColor,
      body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(18.0),
            child: MCQBanks(mcqBanks: mcqBanks, subjectID: subjectID),
          )
      ),
    );
  }
}
