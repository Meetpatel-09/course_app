import 'package:course_app_ui/model/course_model.dart';
import 'package:course_app_ui/model/mcq_models/mcq_banks_model.dart';
import 'package:course_app_ui/services/shared_service.dart';
import 'package:course_app_ui/utils/routes.dart';
import 'package:course_app_ui/widgets/exam/choose_mcq_bank/mcq_bank.dart';
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
  String subjectID = "";

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
    subjectList = arg['subjectList'];
    subjectIndex = arg['subjectIndex'];
    mcqBanks = arg['mcqBanks'];
    subjectID = arg['subjectID'];
    return WillPopScope(
      onWillPop: () async {
        Navigator.pushNamedAndRemoveUntil(context, MyRoutes.homeRoute, (route) => false);
        // showDialog(
        //     context: context,
        //     builder: (context) => AlertDialog(
        //       title: const Text("Alert"),
        //       content: const Text("Do you want to go back to home?"),
        //       actions: [
        //         TextButton(
        //             onPressed: () {
        //               Navigator.pop(context);
        //               Navigator.pushNamedAndRemoveUntil(context, MyRoutes.homeRoute, (route) => false);
        //             },
        //             child: const Text("Yes")),
        //         TextButton(
        //             onPressed: () {
        //               Navigator.of(context).pop();
        //             },
        //             child: const Text("No")),
        //       ],
        //     )
        // );
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
