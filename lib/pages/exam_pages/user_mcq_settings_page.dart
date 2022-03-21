import 'package:course_app_ui/model/course_model.dart';
import 'package:course_app_ui/model/mcq_models/mcq_banks_model.dart';
import 'package:course_app_ui/pages/exam_pages/mobile/user_mcq_settings_page.dart';
import 'package:course_app_ui/pages/exam_pages/web/user_mcq_settings_page.dart';
import 'package:course_app_ui/services/shared_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart' show kIsWeb;

class UserMCQSettingsPage extends StatefulWidget {
  const UserMCQSettingsPage({Key? key}) : super(key: key);

  @override
  State<UserMCQSettingsPage> createState() => _UserMCQSettingsPageState();
}

class _UserMCQSettingsPageState extends State<UserMCQSettingsPage> {
  List<Subject>? subjectList = [];
  int subjectIndex = 0;
  String token = "empty";
  MCQBanksModel? mcqBanks;
  int mcqBanksIndex = 0;
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
    mcqBanksIndex = arg['mcqBanksIndex'];
    subjectID = arg['subjectID'];

    return LayoutBuilder(
      builder: (context, constraints) {
        if (kIsWeb) {
          // Web SCREEN
          return UserMCQSettingsPageWeb(
              subjectIndex: subjectIndex,
              subjectList: subjectList,
              mbid: mcqBanks!.result![mcqBanksIndex].mbid,
              token: token,
              subjectID: subjectID);
        } else {
          // Mobile Screen
          return UserMCQSettingsPageMobile(
              subjectIndex: subjectIndex,
              subjectList: subjectList,
              mbid: mcqBanks!.result![mcqBanksIndex].mbid,
              token: token,
              subjectID: subjectID
          );
        }
      },
    );
  }
}