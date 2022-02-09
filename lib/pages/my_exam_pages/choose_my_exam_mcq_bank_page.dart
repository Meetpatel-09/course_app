import 'package:flutter/material.dart';
import 'package:velocity_x/velocity_x.dart';

class ChooseMyExamMCQBankPage extends StatefulWidget {
  const ChooseMyExamMCQBankPage({Key? key}) : super(key: key);

  @override
  _ChooseMyExamMCQBankPageState createState() => _ChooseMyExamMCQBankPageState();
}

class _ChooseMyExamMCQBankPageState extends State<ChooseMyExamMCQBankPage> {
  String subjectID = "";

  @override
  Widget build(BuildContext context) {
    final arg = ModalRoute.of(context)!.settings.arguments as Map;
    subjectID = arg['subjectID'];
    return Container(child: subjectID.text.make(),);
  }
}
