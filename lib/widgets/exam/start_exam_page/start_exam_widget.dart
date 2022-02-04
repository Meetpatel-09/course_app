import 'package:course_app_ui/model/course_model.dart';
import 'package:course_app_ui/model/mcq_models/user_mcq_settings/user_settings_request_model.dart';
import 'package:course_app_ui/services/api_service.dart';
import 'package:course_app_ui/utils/routes.dart';
import 'package:course_app_ui/widgets/exam/start_exam_page/start_exam_button.dart';
import 'package:flutter/material.dart';

class StartExamWidget extends StatefulWidget {
  final bool wantExamTimer;
  final bool wantQuestionTimer;
  final String examTime;
  final String questionTime;
  final String numQuestions;
  final String token;
  final int mbid;
  final int userMCQID;
  final List<Subject>? subjectList;
  final int? subjectIndex;
  final String? subjectID;
  const StartExamWidget({Key? key, required this.wantExamTimer, required this.wantQuestionTimer, required this.examTime, required this.questionTime, required this.numQuestions, required this.token, required this.mbid, required this.userMCQID, this.subjectList, this.subjectIndex, this.subjectID}) : super(key: key);

  @override
  _StartExamWidgetState createState() => _StartExamWidgetState();
}

class _StartExamWidgetState extends State<StartExamWidget> {
  bool isLoading = true;
  bool isCorrect = true;

  @override
  void initState() {
    super.initState();

    UserSettingsRequestModel model = UserSettingsRequestModel(
      mcqStartDatetime: true
    );

    APIServices.putUserSettings(model, widget.userMCQID.toString(), widget.token).then((response) {
      if (response.toString().isNotEmpty) {
        if (response.status == 200) {
          isCorrect = true;
        } else {
          showDialog(
              context: context,
              barrierDismissible: false,
              builder: (context) => AlertDialog(
                title: Text(response.status.toString()),
                content: Text(response.msg.toString()),
                actions: [
                  TextButton(
                      onPressed: () {
                        Navigator.pop(context);
                        Navigator.pushNamed(context, MyRoutes.homeRoute);
                      },
                      child: const Text("OK")),
                ],
              )
          );
        }
        if (!mounted) return;
        setState(() {
          isLoading = false;
        });
      }
    });
  }
  @override
  Widget build(BuildContext context) {
    return isLoading
        ?
    const Center(child: CircularProgressIndicator(),)
        :
    SizedBox(
        height: MediaQuery.of(context).size.height - 100,
        child: Align(
          child: StartExamButton(
              token: widget.token,
              mbid: widget.mbid,
              wantExamTimer: widget.wantExamTimer,
              examTime: widget.examTime,
              wantQuestionTimer: widget.wantQuestionTimer,
              questionTime: widget.questionTime,
              numQuestions: widget.numQuestions,
              userMCQID: widget.userMCQID,
              subjectIndex: widget.subjectIndex,
              subjectList: widget.subjectList,
              subjectID: widget.subjectID
          ),
        )
    );
  }
}
