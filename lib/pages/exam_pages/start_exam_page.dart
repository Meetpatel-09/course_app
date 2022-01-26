import 'package:course_app_ui/model/course_model.dart';
import 'package:course_app_ui/widgets/exam/start_exam_page/start_exam_widget.dart';
import 'package:flutter/material.dart';
import 'package:velocity_x/velocity_x.dart';

class StartExamPage extends StatelessWidget {
  const StartExamPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final arg = ModalRoute.of(context)!.settings.arguments as Map;
    List<Subject> subjectList = arg['subjectList'];
    int index = arg['index'];
    String token = arg['token'];
    int mbid = arg['mbid'];
    String examTime = arg['examTime'];
    bool wantExamTimer = arg['wantExamTimer'];
    bool wantQuestionTimer = arg['wantQuestionTimer'];
    String questionTime = arg['questionTime'];
    String numQuestions = arg['numQuestions'];
    int userMCQID = arg['user_mcq_id'];

    print('token: $token, index: $index, mbid: $mbid, subjectList: $subjectList, wantExamTimer: $wantExamTimer, examTime: $examTime, wantQuestionTimer: $wantQuestionTimer, questionTime: $questionTime, numQuestions: $numQuestions,userMCQID: $userMCQID');

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
      body: StartExamWidget(
          token: token,
          index: index,
          mbid: mbid,
          subjectList: subjectList,
          wantExamTimer: wantExamTimer,
          examTime: examTime,
          wantQuestionTimer: wantQuestionTimer,
          questionTime: questionTime,
          numQuestions: numQuestions,
          userMCQID: userMCQID
      )
    );
  }
}
