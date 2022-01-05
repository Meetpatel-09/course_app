import 'package:course_app_ui/model/course_model.dart';
import 'package:course_app_ui/model/mcq_models/mcq_banks_model.dart';
import 'package:course_app_ui/services/shared_service.dart';
import 'package:course_app_ui/widgets/exam/ChooseMCQBank/MCQBanks.dart';
import 'package:flutter/material.dart';
import 'package:velocity_x/velocity_x.dart';

class ChooseMCQBankPage extends StatefulWidget {
  const ChooseMCQBankPage({Key? key}) : super(key: key);

  @override
  _ChooseMCQBankPageState createState() => _ChooseMCQBankPageState();
}

class _ChooseMCQBankPageState extends State<ChooseMCQBankPage> {
  List<Subject>? subjectList = [];
  int subjectIndex = 0;
  late MCQBanksModel mcqBanks;
  String token = "empty";
  final SharedServices _sharedServices = SharedServices();

  @override
  void initState() {
    _sharedServices.checkLogIn("token").then((value) {
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
    subjectList = arg['subjectList'];
    subjectIndex = arg['subjectIndex'];
    mcqBanks = arg['mcqBanks'];
    return Scaffold(
      appBar: AppBar(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            "Exam".text.make()
          ],
        ),
      ),
      backgroundColor: context.canvasColor,
      body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(18.0),
            child: MCQBanks(subjectList: subjectList,subjectIndex: subjectIndex,mcqBanks: mcqBanks,),
          )
      ),
    );
  }

}
