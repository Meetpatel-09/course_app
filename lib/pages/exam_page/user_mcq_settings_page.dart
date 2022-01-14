import 'package:course_app_ui/model/course_model.dart';
import 'package:course_app_ui/model/mcq_models/mcq_banks_model.dart';
import 'package:course_app_ui/services/shared_service.dart';
import 'package:course_app_ui/widgets/exam/exam_chooses_page/exam_chooses.dart';
import 'package:flutter/material.dart';
import 'package:velocity_x/velocity_x.dart';

class UserMCQSettingsPage extends StatefulWidget {
  const UserMCQSettingsPage({Key? key}) : super(key: key);

  @override
  State<UserMCQSettingsPage> createState() => _UserMCQSettingsPageState();
}

class _UserMCQSettingsPageState extends State<UserMCQSettingsPage> {
  List<Subject>? subjectList = [];
  int subjectIndex = 0;
  bool _isEmpty = true;
  String token = "empty";
  MCQBanksModel? mcqBanks;
  int mcqBanksIndex = 0;
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
    subjectList = arg['subjectList'];
    subjectIndex = arg['subjectIndex'];
    mcqBanks = arg['mcqBanks'];
    mcqBanksIndex = arg['mcqBanksIndex'];

    if (subjectList != null) {
      _isEmpty = false;
    }

    return Scaffold(
      appBar: AppBar(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
           'Exam'.text.make()
          ],
        ),
      ),
      backgroundColor: context.canvasColor,
      body: _isEmpty ?
      const Center(child: CircularProgressIndicator(),)
          :
      SingleChildScrollView(
          child: ExamChooses(
            subjectIndex: subjectIndex,
            subjectList: subjectList,
            mbid: mcqBanks!.result![mcqBanksIndex].mbid,
            token: token,
          )
      ),
    );
  }
}
