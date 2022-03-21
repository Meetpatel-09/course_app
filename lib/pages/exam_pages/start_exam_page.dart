import 'package:course_app_ui/model/course_model.dart';
import 'package:course_app_ui/widgets/exam/start_exam_page/start_exam_widget.dart';
import 'package:course_app_ui/widgets/web/bottom_navigation.dart';
import 'package:course_app_ui/widgets/web/navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:velocity_x/velocity_x.dart';
import 'package:flutter/foundation.dart' show kIsWeb;

class StartExamPage extends StatelessWidget {
  const StartExamPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final arg = ModalRoute.of(context)!.settings.arguments as Map;
    String token = arg['token'];
    int mbid = arg['mbid'];
    String examTime = arg['examTime'];
    bool wantExamTimer = arg['wantExamTimer'];
    bool wantQuestionTimer = arg['wantQuestionTimer'];
    String questionTime = arg['questionTime'];
    String numQuestions = arg['numQuestions'];
    int userMCQID = arg['user_mcq_id'];
    List<Subject>? subjectList = arg['subjectList'];
    int subjectIndex = arg['index'];
    String subjectID = arg['subjectID'];

    return Scaffold(
      appBar: kIsWeb ? null : AppBar(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            "Exam".text.make()
          ],
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            kIsWeb ? const CustomNavigationBar() : const SizedBox(),
            StartExamWidget(
              token: token,
              mbid: mbid,
              wantExamTimer: wantExamTimer,
              examTime: examTime,
              wantQuestionTimer: wantQuestionTimer,
              questionTime: questionTime,
              numQuestions: numQuestions,
              userMCQID: userMCQID,
              subjectIndex: subjectIndex,
              subjectList: subjectList,
              subjectID: subjectID
            ),
            kIsWeb ? const BottomNavigation() : const SizedBox(),
          ],
        ),
      )
    );
  }
}
